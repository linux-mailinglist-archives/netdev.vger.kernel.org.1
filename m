Return-Path: <netdev+bounces-262005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N9uCA8womke0wQAu9opvQ
	(envelope-from <netdev+bounces-262005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:00:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BA31BF499
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BC2A3039353
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C24234994;
	Sat, 28 Feb 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="A2sIPv23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CA289378
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236813; cv=none; b=FANQQAFVJQimjTuP4g7h0BzJcRQJnTC61wlcJEOFF4jwld1g5Xsc6YnG48Vdpg3PQTD6HgpvIbhVxmx357SOijSMCfKk0qfCTAged79IIPYv4GbqM6mfVWvmZJnkf8Npxdtg3JxRRb4usbKFe9BNU6KoK5iLPlVKXh1f4OZRwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236813; c=relaxed/simple;
	bh=8YUYhWIr8G1dSfaGD/6CqE3LnPHghq++x+liYM6rPM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0Jzgn4IxkDOtUMYtc1tfKliyhi4IvcRC544K9Phw0v8MBVeZkCYCjgdtSUiMJBgIOia2YihPcDEFQF8vGnEQh3J7Wn9Y+rO89YXD72MKG/nWTTAI5OR4c6tk+4T7U0WXCgvfA1RXHdt2oQEx0VyxhSaTh63WOvoYaeewynKoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=A2sIPv23; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480706554beso30397105e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236809; x=1772841609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Bfjux9kTLt+rrHS2I5hQm1ZwltREOkjlOLtKtjmJic=;
        b=A2sIPv23HwykAS4yj15aPrHLOQScpB1JrogyeHg0g1jbXTOfc2ivoh+0VpaPKah9zM
         Kr/yaQKfL3dIS8Dl+kuWhwM+Qvmv1CS7ZMdbtk4DHQpcIs3Gvdo2wvwXMAG6yVFIxltb
         pogf5A/NGNx8qjYo4XXi33ULFt/gLIyrczTWwh9No+8916TApR5V9YxzPd5OoRxaBX+E
         O9kA6kNWLtGSRT3OXj4Y9c42QRz80k/MuCVRWPAebcr2AvZggh4RHYRKaOPVpK/SU79w
         sQFAUPdfQqPqd3lubdvc7V8RfThI+NFubARzTSHkuNt0L6EmrwblkLcK6Ldjh7p7oTcb
         GSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236809; x=1772841609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bfjux9kTLt+rrHS2I5hQm1ZwltREOkjlOLtKtjmJic=;
        b=E4DdwQZsNScfkRwUJWP6cUsSmzDL9onUOTPdPLzzeidDwjKqRr2cnURMnjKhNXCgqY
         qnlwUNpXWDsJWgprHfisqIt9RfY+9+R217jLpmK+udK5Pxvj2epxhPvV51T0CazknLkw
         dcBPotjL9sgAokJIevN8Qf3jFtMmJZZo+CTmXTgBVa0avI+w6hArX2888bcW6AaqqsYX
         +fn7fpSQngkOtPmFzULB8MeTBrpW0psJNoDcftOiRXvLF2Vd5Ozj3GftVwAF63vLF9eq
         sZHvp24jpYSbkFW+fgRtMjYmxKowjQ6hRsyQ6QZc9uiuAd4brF6mxvaqiuzn0h3LFehZ
         YS5g==
X-Gm-Message-State: AOJu0YyR0OpNWl7/Iv+MsmGdPY5ArT5lmZjLqO608fmJGyCUZUPhpYSp
	5HYM84AynsIbLafZwWcKSxT08NL2M7vKUt7hy7iHGluweOebjGpkX9fwHiS0EyWYxeNcQ8DsoBx
	KcFIszJkeBwcC3RspUt1exPVfpStFz/yYEcKtYzwMp+9rmjhsJ9fHCe/gAPJJpO1K
X-Gm-Gg: ATEYQzwQLInuAr3pKlgj/M4jWg3Hi5dhGkKCjdO7MpR7mD4kTvw3ISghxMZ9V+I9r+j
	J4kDjxWWIEAOq3sjb53bx9ovEwy8zyBgxXVbMWQ48+9/z0rN6z8WynZ+FSzTjVif54Ah1wi+bP4
	t11Eu9dH7zIbierKzxCns/WbbV0IdcTFK7D/cme7cR4GUYXYbXO3O7JgFZ7hJVn5EXKfCHVvHxf
	5GSt4xni5HetQXOJlKpIcYuWK0+d/UMdbLQqaV3o8fU9g42qrnJfwrQ0UNiqO5zeFggj1iFs4gm
	yrt6M8DdbYTQpWZXCGdLGFrlz0ZC3i+deJFxVIBdz4+7jpSDBxjU9TuDLYh6Ok1OrtaI5ARbTLW
	FeZYDcDsyO10q3LrDbDnS/a6tjztBMA1isLsGUNR0iAwcEQQ/hsWdTdlqY9Vs4Cz8BOSk/CvOmz
	P6OeNl3MZZqol5fCZJWRAhc1MqncLu0dWLwxXf
X-Received: by 2002:a05:600c:4e8e:b0:483:a922:2e8d with SMTP id 5b1f17b1804b1-483c9b97198mr69985905e9.4.1772236808649;
        Fri, 27 Feb 2026 16:00:08 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 0/9] pull request: ovpn 2026-02-28
Date: Sat, 28 Feb 2026 00:59:46 +0100
Message-ID: <20260227235955.660-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262005-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.988];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Queue-Id: B4BA31BF499
X-Rspamd-Action: no action

Hello netdev team!
Here is our first batch of new features for ovpn.

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


The following changes since commit fd6dad4e1ae296b67b87291256878a58dad36c93:

  netmem: remove the pp fields from net_iov (2026-02-26 19:45:24 -0800)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git ovpn-net-next-20260227

for you to fetch changes up to cbf42accce83c4f9ea91746f716e3090021c250f:

  ovpn: consolidate crypto allocations in one chunk (2026-02-28 00:58:30 +0100)

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
 .../selftests/net/ovpn/check_requirements.py       |  41 ++++++
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
 tools/testing/selftests/net/ovpn/test-mark.sh      |  84 +++++++++++
 tools/testing/selftests/net/ovpn/test.sh           |  57 ++++++--
 tools/testing/selftests/net/ovpn/udp_peers.txt     |  12 +-
 38 files changed, 611 insertions(+), 130 deletions(-)
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

