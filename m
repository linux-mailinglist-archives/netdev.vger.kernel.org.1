Return-Path: <netdev+bounces-268543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNB9Mb4vuWkYuAEAu9opvQ
	(envelope-from <netdev+bounces-268543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C9E2A81D1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA9893050196
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2873A784B;
	Tue, 17 Mar 2026 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="f8ieUP2S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17D3033C0
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744036; cv=none; b=MfgfwwlQixKTlg2zOsga9/EVd1maxkUmReQViFqZi/L8hg/uZx8l6V3AtL+HtFQok1deiDUSRqh01eLcIav+05mAy8SJ9QpSNTQjDHOpCmezJgpx/SIEbdgh7k6IzSgpUsshXQ1cdZAhhdAYk/Dv1ioHAT6TBjpVzUgnA0/Qyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744036; c=relaxed/simple;
	bh=U8DozW3feVPrY8HymjK4vTwGTNZzaHl71BRlcxGsA04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSm6d7ysng4McC2wc/wgxBqPqJiTCYMWGlsKx4SgxS55vPR9WNc9zL0K0+NgCJs1xZIU0fKMPkGFTucQQJCtvvvKwbZZmukTAK91809RaKzu1VRpAGMi6TX1n0mhM9gIEc3+JjT0HjnQQOvuKIA2WWUNz+9jclDDJ4v0AUzspWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=f8ieUP2S; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso5597034f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773744031; x=1774348831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+vrU1MBy9RvYlW5hLwJn6fO8BiNLsKPq+41Fi+ryx4=;
        b=f8ieUP2S2tSM9vKqWwALatxtr2HhQfAY1AooAv6Tj0kXqbe14v4sEILUKHDiCK801z
         4Gn+R1pW7qAc0u8lDqFh0VtlqHcKZK8//9RjtQjzJHTudTjxHe+KLHsqJ6ab75r9UTLM
         GdEihohSEEFKbwBkwjJh4J74zR7K9HGkwFB0dOys4O5PfGw2c2mihStQYX7y93MhExL1
         7+agvbgUfOno7SiUceHb2t7b+GYddocrpsiCen+wR72cBp9jnal4FypLsE12ANPAmK7L
         3JIanzUsnlnbj5gUAig/X1oDhOAVSsKFlg9C7NcWeLDCFkbH+4Ou9FxDuZ+oLv5bSdMk
         xHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744031; x=1774348831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+vrU1MBy9RvYlW5hLwJn6fO8BiNLsKPq+41Fi+ryx4=;
        b=YBrV7QDIRmCtf8ZmgssdKLr4bhB/10e/iWDuRRHIWvyG9xjpS2UEu4rVhmRiGBZdN9
         CxLTxNPEw2D1jfJ+0PXe2enAhm1FuaxDZLkK1qIq7dkE3Bi26vOLCYDSz4yri9vIhAFs
         fyFQHY7h7PzAYcVu44EAEgpjEccbpMI1YVn42w3uLMv33l5QMeF15D2xG15+c+qFy5Z9
         MLQ7lWMWWU9s64DeOqQvqdSpBqgNSrEv7DBA9wnB5UTeBHswd+jmxFRvLZTKcFKh4TxS
         Jkif6wZhbYF3ulXLf9dWOu4IzbJpCoo9Xph49PEOGhMpBqed5NlxQ27C42lPDairUVjf
         3IIg==
X-Gm-Message-State: AOJu0Yw1w5BjkPf7mdRJdFBsKdNBTmteWypBxC83QB8GZ5p5dwNK/cdE
	rM0nw5KA9sM0IkQFu9yCUUEwlqKFMryM9xdwkfiacTAFyH85WZFjjpwm3L4Xtv8uWUaii2EYUuA
	RTHBdPmzn7rPlJQTdA1ct9Reut5pMAOdWlR41vLOXsdEdncjMxZHUQ3lxbon12E/X
X-Gm-Gg: ATEYQzzWfVNp2p34tK6IhzKUMzI3wcTyXaD7wQdQ0Z8sLcroxXWFQVVctud0/fHWlSt
	jm7jd30wf3ZApksfFihP95tUG62RurvfbnxelG51ZUSoo/voMqYqCvVFdWoTX1TPhN4zwLAtumM
	fklIYFeGhAViiACiRFlOPaaCZvD4pDcJIQsX2C4HyZ+MnBo+2wYZxOGF5LfauWlKRL6qOSjO/8p
	GPMvWkxEveThOApJ7S9Ax+vl9WtN/idgTQhSaCv828wEitSmWlTM51XSV/sTXOaI2KoUkEX/wwE
	uWbdK0CAVLNc/fiK2p9Js52Da43+wmCRtkvGk6FzZAlBNDt2XxBgAzQRuaT3eB2tkoF22nr4X3/
	vPHiAOTHUOE8gce0iuTHruVf4w39/BJzuKmQgFo7SJ29cKxy0Q0tgChtmASpzce2kAKV6T6RwaU
	sWlOIUYPJ/TY3mFj7Sn7Q0RjHKXQbkO+J5Bgo=
X-Received: by 2002:a05:6000:18a9:b0:43b:4989:869d with SMTP id ffacd0b85a97d-43b49898800mr5226469f8f.33.1773744028006;
        Tue, 17 Mar 2026 03:40:28 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:4f22:3f9:13dd:cf23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm49948215f8f.31.2026.03.17.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:40:27 -0700 (PDT)
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
Subject: [PATCH net-next 0/9] pull request: ovpn 2026-03-17
Date: Tue, 17 Mar 2026 11:40:14 +0100
Message-ID: <20260317104023.192548-1-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268543-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Queue-Id: 49C9E2A81D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello netdev team!

This is (yet..yet..yet) another resend of the original PR meant for
net-next.
We have fixed the hitchups in the commit messages, as pointed out by the
AI.


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


The following changes since commit febe8012458fd9057d3fb70f6b37ef67a07ff8a1:

  ppp: remove pch->chan NULL checks from tx path (2026-03-17 10:58:04 +0100)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20260317

for you to fetch changes up to d3244af9c4c2bbce57465130c9cd509182207c2d:

  ovpn: consolidate crypto allocations in one chunk (2026-03-17 11:09:20 +0100)

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

