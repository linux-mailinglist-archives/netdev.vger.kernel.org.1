Return-Path: <netdev+bounces-267593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOn5Lel4tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:51:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF11289E63
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6BCD301E987
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC937F755;
	Fri, 13 Mar 2026 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cTejPLl0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7480375AB4
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435111; cv=none; b=MTNYydSiFhDepcrwHBNmOoXa6ybzP1ZbaERn4Ueoc7wOE2czz1QqgO58S0pRkN2EhInoP/+nFlHa5NTxO1d8iz4R9M3mY/45MHmAuNH3PLMpz3MxWwtMwdAS1VZQP0uWjCR7J7GEQ+Cv2alBfIl67X9AtOzAoDsC3fI3OJbXjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435111; c=relaxed/simple;
	bh=S/rqwquxS5PXxlDSarnLR+MW8ZquIsopmO9rCDZXr04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tq0Op7LrQJzbB+E8kacE+rqz1FwauObKsdR7lxz6MnpBTqSUrFaRZn/K7FNXcgsXJAZjUFDMSXq+CC2DyIKR8kqvKPyOCzzuqBNHrKCEky81ni8dv4AmPQwxS+aF4+Gwpez1FY+3f5jwzDDjk99Aib1WQv2OB542IAyXfmjuRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cTejPLl0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439c4bde55cso1668539f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435107; x=1774039907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDP78q+5kz5Z6j3pG5C/+NtbBPNfBU0R6f4lXiKoDCA=;
        b=cTejPLl08hibiFko0UzDXd3f1N13Av6XXW1qzKLrup8f/LWgaAMWphg1L6c2g9b1wi
         P48oRSyBZFh/JEz/YQNQ4sMqdXso0myLjCNv5wvtBc3TSGiBKAzeWXD0NOUXCxGf1SG9
         yXrrAa7P1Xn6+eOifZj76kwZL3DtHhr9A0ozjvmcHSwEXPzugj0CzgynTDUSgBvx6EQS
         9LLAt2gM/cUk6InT86iNpf0xcZ/iS5w+nsbPicpneueyOr3cwBbaS4R+uhuNjokcSQdq
         L45IJcEEYLG0euwZr8fzFRS22EFT3RMvwfIT4CR6hTfIVA/kD1d6dH9sSrc5icc0rpgI
         UIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435107; x=1774039907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDP78q+5kz5Z6j3pG5C/+NtbBPNfBU0R6f4lXiKoDCA=;
        b=jscda/fwCHr5OQ86MOziI5BevdHwSIExY0qOMtN405vZouMKt+qyeLqv93DK1+fRmS
         3cFAikIjpNI8JDWO4Lzr02rKsg1ygSX2EiiLDkQ2LFTRyuhvXmS5boJqLqVRlWVOIVSG
         6a0PeZG5xDN4H4E8VESE9GLHWJ77fh3WvVYgDs5350aHEU2zJt8ktizw5of36k65cjL3
         1Umj1+Q1t7HKXlia/onKNOKbMq+x/bVeRnQR7T5LxSwXRLlvPWwfQVSgjR7o5yTAlBr9
         tmRWaCHr5inNsOByiMPmUumEHg9LF5u8/3eJGG7sacf9AtQXme8JEDz+K3BLmWQaheMS
         kEwg==
X-Gm-Message-State: AOJu0YxBKbbeivkyz5cWYj+HHCXkcfDQigav7oAuSzxCEV0xKlwAx4Rc
	rPCrW//HeSKHi95ZbVb68Dve342sRo2RcYuWCS2IN51TEAPL2gSha69qp9wkiIPM/N/61Sb+Tr6
	AQ5U22izMQeL5BKgTZBc7VAJ5Qj3a+dLO98MmFxkFQPyVCDEapWlf9p98CmNucGDP
X-Gm-Gg: ATEYQzx0SoXC4rwSsC7zUKizhkVVB9qm215ayq5m2KENt2/nAz5tp+uwxywPcTOfiE1
	Yot+UTDw5OCoKqO+/a2p8IOb4aXTfWxNV+If5X4kHArqqDPuslimShKYCtgOPZAFHkwfgQVn1A2
	EGYkEpO7sI1Je0T7GHNvdeH61Sl4VmaxuBZNq1WlkzJtUktUPhG8yTEZPHm0EKEEWxokqJRC/wT
	L3G5E+39eg/Ndg2EiT+c6wSKCat+G7UTk4bSjk+odAt/TDL26EeLYeiWSDIPanigTwRYApSHZdh
	I19IBQyjssipFVALnu3zJa8+vcBzN7tl+zY/qOeN+/WNyFGSSwfaTfw+nBTzE37xml0E8cLcCNE
	9piImRUt8UzDDSKu7VJ7QY8NQpwr93VI1RT72UZHrbdNsadqfDhGlnRSoobxyzGNRCqigMWCiy+
	+Dut/ZEEg+rUY8S/UiGYKmTBBd9m9MJJvzb2s/
X-Received: by 2002:a5d:5e01:0:b0:439:ab3d:1c37 with SMTP id ffacd0b85a97d-43a04d7561bmr8760107f8f.7.1773435107441;
        Fri, 13 Mar 2026 13:51:47 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 0/9] pull request: ovpn 2026-03-13
Date: Fri, 13 Mar 2026 21:51:30 +0100
Message-ID: <20260313205139.2950-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267593-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AF11289E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello netdev team!

This is (yet) another resend of the previous PR.
The selftest Makefile has been adjusted and we have also
addressed all AI's concerns (some were valid).
Thanks for pointing out the nipa URL, so that we could
double check the Makefile locally.


This batch includes the following changes:
* use correct constant when declaring nlattr array in ovpn_nl_key_swap_doit
* use bitops.h API when possible
* send netlink notification in case of client float event
* implement support for asymmetric peer IDs
* consolidate memory allocations during crypto operations
* add netlink notification check in selftests
* add asymmetric peer IDs check in selftest
* add FW mark check in selftest


Please pull or let me know of any issue!

Thanks a lot.
Antonio,


The following changes since commit 8f921f61005450589c0bc1a941a5ddde21d9aed9:

  netlink: update outdated comment (2026-03-12 19:29:01 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20260313

for you to fetch changes up to d56ca0817a5fb97bd6f489f96bb63d410331f5ad:

  ovpn: consolidate crypto allocations in one chunk (2026-03-13 21:36:40 +0100)

----------------------------------------------------------------
Included features:
* use bitops.h API when possible
* send netlink notification in case of client float event
* implement support for asymmetric peer IDs
* consolidate memory allocations during crypto operations
* add netlink notification check in selftests
* add FW mark check in selftest

----------------------------------------------------------------
Antonio Quartulli (1):
      selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3

Qingfang Deng (1):
      ovpn: pktid: use bitops.h API

Ralf Lici (6):
      ovpn: notify userspace on client float event
      selftests: ovpn: add notification parsing and matching
      ovpn: add support for asymmetric peer IDs
      selftests: ovpn: check asymmetric peer-id
      selftests: ovpn: add test for the FW mark feature
      ovpn: consolidate crypto allocations in one chunk

Sabrina Dubroca (1):
      ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit

 Documentation/netlink/specs/ovpn.yaml              |  23 ++-
 drivers/net/ovpn/crypto_aead.c                     | 162 ++++++++++++++++-----
 drivers/net/ovpn/io.c                              |   8 +-
 drivers/net/ovpn/netlink-gen.c                     |  13 +-
 drivers/net/ovpn/netlink-gen.h                     |   6 +-
 drivers/net/ovpn/netlink.c                         |  98 ++++++++++++-
 drivers/net/ovpn/netlink.h                         |   2 +
 drivers/net/ovpn/peer.c                            |   6 +
 drivers/net/ovpn/peer.h                            |   4 +-
 drivers/net/ovpn/pktid.c                           |  11 +-
 drivers/net/ovpn/pktid.h                           |   2 +-
 drivers/net/ovpn/skb.h                             |  13 +-
 include/uapi/linux/ovpn.h                          |   2 +
 tools/testing/selftests/net/ovpn/Makefile          |  29 +++-
 tools/testing/selftests/net/ovpn/common.sh         | 101 +++++++++++--
 tools/testing/selftests/net/ovpn/data64.key        |   6 +-
 .../selftests/net/ovpn/json/peer0-float.json       |   9 ++
 .../selftests/net/ovpn/json/peer0-symm-float.json  |   1 +
 .../selftests/net/ovpn/json/peer0-symm.json        |   1 +
 tools/testing/selftests/net/ovpn/json/peer0.json   |   6 +
 .../selftests/net/ovpn/json/peer1-float.json       |   1 +
 .../selftests/net/ovpn/json/peer1-symm-float.json  |   1 +
 .../selftests/net/ovpn/json/peer1-symm.json        |   1 +
 tools/testing/selftests/net/ovpn/json/peer1.json   |   1 +
 .../selftests/net/ovpn/json/peer2-float.json       |   1 +
 .../selftests/net/ovpn/json/peer2-symm-float.json  |   1 +
 .../selftests/net/ovpn/json/peer2-symm.json        |   1 +
 tools/testing/selftests/net/ovpn/json/peer2.json   |   1 +
 .../selftests/net/ovpn/json/peer3-float.json       |   1 +
 .../selftests/net/ovpn/json/peer3-symm-float.json  |   1 +
 .../selftests/net/ovpn/json/peer3-symm.json        |   1 +
 tools/testing/selftests/net/ovpn/json/peer3.json   |   1 +
 .../selftests/net/ovpn/json/peer4-float.json       |   1 +
 .../selftests/net/ovpn/json/peer4-symm-float.json  |   1 +
 .../selftests/net/ovpn/json/peer4-symm.json        |   1 +
 tools/testing/selftests/net/ovpn/json/peer4.json   |   1 +
 .../selftests/net/ovpn/json/peer5-float.json       |   1 +
 .../selftests/net/ovpn/json/peer5-symm-float.json  |   1 +
 .../selftests/net/ovpn/json/peer5-symm.json        |   1 +
 tools/testing/selftests/net/ovpn/json/peer5.json   |   1 +
 .../selftests/net/ovpn/json/peer6-float.json       |   1 +
 .../selftests/net/ovpn/json/peer6-symm-float.json  |   1 +
 .../selftests/net/ovpn/json/peer6-symm.json        |   1 +
 tools/testing/selftests/net/ovpn/json/peer6.json   |   1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 152 ++++++++++++++-----
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |  11 +-
 .../selftests/net/ovpn/test-close-socket.sh        |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      |  96 ++++++++++++
 .../selftests/net/ovpn/test-symmetric-id-float.sh  |  11 ++
 .../selftests/net/ovpn/test-symmetric-id-tcp.sh    |  11 ++
 .../selftests/net/ovpn/test-symmetric-id.sh        |  10 ++
 tools/testing/selftests/net/ovpn/test.sh           |  76 ++++++++--
 tools/testing/selftests/net/ovpn/udp_peers.txt     |  12 +-
 53 files changed, 756 insertions(+), 152 deletions(-)
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer0-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6-symm.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6.json
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id.sh

