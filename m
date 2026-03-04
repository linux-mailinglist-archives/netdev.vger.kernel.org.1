Return-Path: <netdev+bounces-264077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP+rEhy7qGlbwwAAu9opvQ
	(envelope-from <netdev+bounces-264077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:07:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FB208D9F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC747300C382
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075137B02B;
	Wed,  4 Mar 2026 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VoHkXtFy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415837AA70
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665621; cv=none; b=OcD52tILdIlIJFmb63nIIQYuTHJbvyFXyBTfN7Wv29RBjE3cZq+EkFcajrjq4xHZkIcB3XuuEiAMYDObclLJvkIbC0J4G7n6GiHoU5/FBVGQie/BzmiSiD8kbbmv08dM/OC2xSo7Ebm47kuOYGARPDEpWAmd8WpXIg6e31lfZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665621; c=relaxed/simple;
	bh=UMM5SSJ3c7oDSIPu2st52Z5+82idbAlB61f5KchfMaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiGVe5L02NesGm94R7GA8dJnoG2Znl9rEKd1SeT8lyzx+5LPwFJVsNKjNiN7dJCGXEYTMWzUMw5a1ICfRuvMvRiZD463PwQsKp2a1V8Akg69ggUZmptao7GXRS4L5E728G+z02jj9RtPlh/3ZUIeDr+Vu8JyRrxUI3IxMjP/ETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VoHkXtFy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so57164015e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772665618; x=1773270418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hamrIlnXhW60xGY4SAcWesubkswl/hPrsqkpKnHqdYo=;
        b=VoHkXtFyx+lQOWClAD/XYrT+Eep47CJECBD1RxHY1vt1FdYIr9r6HHPT8wE7YiKkU0
         P4E/tJJXxqUHdYTVBKwwAlPux3th3jYHmzFIkQDZZiNMkT/cn96LFhy/FBbQ0UsrYsL6
         RqhAKU0XItAv9efU3JbJTg3gncuuFb8RkwI4BvZD6ngetTrYt/0+dloQL5/az8ApVCSQ
         TeAaPBGmCi7hrXs2L2Ubmlu57G5rvfpcGJwjv83Cp/CgPrzm7Vr2TcPpy5cfl5PQNvO2
         UNIpSEZ6EbzitpdehAdsi2K/hv8uYUPQetZO5SXlk+rsDeXO9ll2+aogCBuEAhKG8cso
         dvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665618; x=1773270418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hamrIlnXhW60xGY4SAcWesubkswl/hPrsqkpKnHqdYo=;
        b=EJWERWOGd0LEX/x4o/VLy7TV97EWFlwOJKU1kW+fAKe2vqbcnp4+cJPwkuTSvIm1or
         js0L3Qh4oIRdlcD5YaDDKTKSEmnPsR+798TqfW3mSvKDEqokTYSVmTaBhmLx3y/DpEXl
         gs1ZDHpbDWz8pMnRAfvrykzu25hBY6xky3v9/FueV0AwfhVysDWLqzFhq7H//J74g3Cl
         kGOIY81RSmAZRZAUUyQ3rLqf2e5wZWuYp2RnVIaxMQcV3AnE8CII/OhxfLYagKD8ksRm
         Eh/XYRBm0Q08wZTIcr6jqdWxqSNDQPNTDceSbcnnLvls1afeu/JKR3VC3qCCQFzamjp4
         HpfA==
X-Gm-Message-State: AOJu0YxZ5zACZqnyslw97rv0TODJKIkSYdC4ZP8K55h9M/0rws95VM6W
	lU5uf5fvCz4jZaUu+bFNNpv5UmkTnDd9up9g6HEQYMgF5qcINTeYFaLQgjqOH7Vb6rbtOeyFL6o
	T9rHP5VqoED+gUO7eNgE83NloQSCQRrPkgOH3O2kgmEZ4Pn0Cw6ovBtaUMCr244Y1
X-Gm-Gg: ATEYQzzat04Mmcf6iNr13YISPMKcwGd6hJl4pnj97d5Err0Oy6rNYU3oer3E8yYeNXQ
	9b4K/LZz82h8M6STE+8DP5whFx7/Ch4jfa4N7pexfeJZOLqGm1qlvasQPVaIlDtDcRZVtn17eSQ
	I1EEODovCasmn3oFPG0WBAD27yJaC7HF8LBwnWqpiKhHxPpX+P7+/PpBpO8A/LXsGHIVqeb41GD
	ZP4f+OYoD5p7jVvgmOxkF2uv2a0S65qFGe1jyqCh6lveo/PQhCNUgWg+kR59QRsIviXJ55SahEa
	Pjv6anvMaJ6NinW/VT2M7BHcG6IZUMSuvZ63ruMTiyw/lW6OkqZnQGITziNiZh5jUp2L1SzXfQj
	I5c85+be2n9/O91GAUgDd/bXeOjTOTEm5vJ1bMFzP0FWc6jO4uNm5SeFIhX7uMf9pTe+IdUN6Nl
	/NK4akV6aqzrGFq9A7O21PhB7SuJiz/zv7OSk=
X-Received: by 2002:a05:600c:1d26:b0:47d:5e02:14e5 with SMTP id 5b1f17b1804b1-485198310e2mr66264295e9.5.1772665617694;
        Wed, 04 Mar 2026 15:06:57 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:880:4d86:fc53:5d46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187caf9fsm87713475e9.7.2026.03.04.15.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:06:57 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 0/9] pull request: ovpn 2026-03-05
Date: Thu,  5 Mar 2026 00:06:18 +0100
Message-ID: <20260304230643.1014-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 739FB208D9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264077-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Hello netdev team!

This is a resend of the last PR.
We have fixed all the issues reported in patchwork (mostly style
related) by the various tools.

The batch includes the following changes:
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


The following changes since commit 4ad96a7c9e2cebbbdc68369438a736a133539f1d:

  selftests: net: add macvlan multicast test for shared source MAC (2026-03-03 18:08:13 -0800)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20270304

for you to fetch changes up to afb7c5378b2a3858923351138887db73b7029d50:

  ovpn: consolidate crypto allocations in one chunk (2026-03-05 00:04:25 +0100)

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
 tools/testing/selftests/net/ovpn/Makefile          |  15 +-
 .../selftests/net/ovpn/check_requirements.py       |  47 ++++++
 tools/testing/selftests/net/ovpn/common.sh         |  55 +++++--
 tools/testing/selftests/net/ovpn/data64.key        |   6 +-
 .../selftests/net/ovpn/json/peer0-float.json       |   9 ++
 tools/testing/selftests/net/ovpn/json/peer0.json   |   6 +
 .../selftests/net/ovpn/json/peer1-float.json       |   1 +
 tools/testing/selftests/net/ovpn/json/peer1.json   |   1 +
 .../selftests/net/ovpn/json/peer2-float.json       |   1 +
 tools/testing/selftests/net/ovpn/json/peer2.json   |   1 +
 .../selftests/net/ovpn/json/peer3-float.json       |   1 +
 tools/testing/selftests/net/ovpn/json/peer3.json   |   1 +
 .../selftests/net/ovpn/json/peer4-float.json       |   1 +
 tools/testing/selftests/net/ovpn/json/peer4.json   |   1 +
 .../selftests/net/ovpn/json/peer5-float.json       |   1 +
 tools/testing/selftests/net/ovpn/json/peer5.json   |   1 +
 .../selftests/net/ovpn/json/peer6-float.json       |   1 +
 tools/testing/selftests/net/ovpn/json/peer6.json   |   1 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  80 +++++++---
 tools/testing/selftests/net/ovpn/requirements.txt  |   1 +
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |  11 +-
 .../selftests/net/ovpn/test-close-socket.sh        |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      |  95 ++++++++++++
 tools/testing/selftests/net/ovpn/test.sh           |  57 ++++++--
 tools/testing/selftests/net/ovpn/udp_peers.txt     |  12 +-
 38 files changed, 628 insertions(+), 130 deletions(-)
 create mode 100755 tools/testing/selftests/net/ovpn/check_requirements.py
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer0.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6.json
 create mode 120000 tools/testing/selftests/net/ovpn/requirements.txt
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh

