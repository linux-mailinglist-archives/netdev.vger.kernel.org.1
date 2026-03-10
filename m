Return-Path: <netdev+bounces-266196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNxQGmE7sGmohQIAu9opvQ
	(envelope-from <netdev+bounces-266196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:40:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D20DB253C3A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4C031593C8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69F2FD68B;
	Tue, 10 Mar 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XO961wR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059972FD1B3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154230; cv=none; b=pMaq1Rl/q0NxCu11kDWIvZEDp2hx6u//sX0bIt+dSdeNZquEUx50lfgldkSyFNP/3g5LkvG/FodZ3S6YmW90NIbbUHlEEEbRWsAl8hB/2vfkBg5ARlkhNizEasD/rRP5XmTbDc2RPR6nw3/akpLOxzGjn+bWeAMkn80BOZyrbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154230; c=relaxed/simple;
	bh=RoPYtFUG8FwZ4uLlgZzU1Yw3hWCPaK6Lfvnz4wxHiWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TUGake6Yhlb3d6SKfl7JtHqz4DBEtruupIJR9A9hppQT1IdDMQd+MJS17qkNHdsJd/GWZHAJzqRWvua83CjuAWnxdWqBmoczXPwMgbyjlKU5iGqEap5KXxKVmrdSi8KaNObhFVDKbohaeyUDUSSUh/uVM/lFFqaBcOBVRhuvfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XO961wR4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso29857865e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773154227; x=1773759027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/Et0VSyNULS/JjvHfrNtw0ZuSWVxV8DQ1TiD9WHcMY=;
        b=XO961wR4k1ZLRehjjvWHqiLOP5YG6LWCZ909noZwnHQjmHblkycMBcFNPgvNltiZES
         OwY8PfraYh/0trYoGptOdaXihAVBTfAa1qhceaCpL8nRVSyxAMvecPgUfoSCidDZcNd0
         DYg9tTLL/uwbq0OZNfwtE2atu1h9hDs0iR2aRKxWpGeNozfbpyjFUxQczk0zM+1SOTvy
         hTdrr/Lh6FkFUQ4BW8JO14kzqwHOJYtG5VgQt1BbrhKTPAW+dKK7rtjhj2H0qK5dugvy
         lpoEkZKsd8Dvbtw1rApRUSr3t0ALqRwwKRPx36KenZoY9KAHaJ+yAtFzCQ6BXUvS0sd2
         FEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154227; x=1773759027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/Et0VSyNULS/JjvHfrNtw0ZuSWVxV8DQ1TiD9WHcMY=;
        b=ODQKPhE+Z3GJLBx3Ywn0ObfKqYj0Uf6YYZbpsWrEzTFAFGyN0ahTgv8QPnOrC4C512
         pTt7RNJQaLPVlauozgbJ8qFvh1ChovWyD4wp+TH0gX3GisV+FbbA9v+xPboNWb5hCqES
         maLv7DHIr6ix8ghXIIJtjEGAgVXR3CGUfhe0jNiq39Ogu3R2SVmNNvIzhcte8QTlwcQA
         5xRYEvhfbg+BIvpzkd98hrnnrfUQsCALaDSybFRnddXZKuwp8t5d7hamv00C7nQNVLPI
         zre1Sk7MkoOsMEVzWZISqHC3waWZoaNgg6khcvvg94EPTUNWUvQB14jvnVZfAoWbx2gN
         YWNQ==
X-Gm-Message-State: AOJu0Yxp+zdgjCb6Fn86kKD+ImQfIl/Mjsnm6ia51KJNy8ud6Fp941HW
	JDdlT1uy5AmwoTy1LGEI8Dfj1bT3jF6UPwsikXvcLvHydgawalrR7gOgWmRqCaiwEoG75EIfKlS
	l6C1DVAB7hqXCQb8HIM2IwJBmozMyuo4y0UCXuzoJcYJ/+gDSkAMyp6b0LTPYZLpj
X-Gm-Gg: ATEYQzxVQ9mn4djcmvoV+WC4xlxqpfGBK54yFEz0j1vzVtMJD7zd6H0it0dkGcpibL9
	+pCr2sOkXmzXxIt5qg1UOskO8M8HE7qTvBJf3t57NkmiREMxfrStW/2RYfB1ZAflKu1wbzmc6sv
	aSFExg9RYx57xmgSErZ29Q8KQQvOg/dbhFR3FHM4E/Nive+wOoYylhoA+KV8vDpsitLl0e1JWV3
	qD5lR6PPSqy3rdD2XQqXIdABeLw7JV35rbtWs+BmJ4G1PpRmHxNadr6dinojJ7JFJ7zhINjeUlQ
	GDxKpN7axa2jfAdQGKT9gu6fAPQ37rZMEP8jkqh0JZB9brEIbCvYpCsKqNEuGZr+v9vqKkz7QjG
	Py+LoV0v9L17IZZrdlRHSDar9shAJ30JFUCyYLvdQDwMFQSJijbebKG4ZLUS6jTNpJCfqFCaxjH
	rE2HolIha8eBhQ9tk+LZ1E4y8XiS6s9PLBVsA4zWFRBhdSIRE=
X-Received: by 2002:a05:600c:4e91:b0:485:439b:683f with SMTP id 5b1f17b1804b1-485439b6923mr42931305e9.20.1773154226713;
        Tue, 10 Mar 2026 07:50:26 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5594:94ef:1bd6:89e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35586700f8f.6.2026.03.10.07.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:50:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 0/9] pull request: ovpn 2026-03-10
Date: Tue, 10 Mar 2026 15:49:57 +0100
Message-ID: <20260310145006.30858-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D20DB253C3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266196-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello netdev team!

This is another resend of the previous PR.
We have addressed all raised concerns.


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

The following changes since commit 52ede1bce557c66309f41ac29dd190be23ca9129:

  Merge branch 'net-stmmac-further-ptp-cleanups' (2026-03-09 19:45:31 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20260310

for you to fetch changes up to a8c63d0394d4fb73e0104a3557111ba24772a178:

  ovpn: consolidate crypto allocations in one chunk (2026-03-10 15:19:05 +0100)

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
 tools/testing/selftests/net/ovpn/Makefile          |  26 +++-
 tools/testing/selftests/net/ovpn/common.sh         |  72 +++++++--
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
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  92 ++++++++----
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |  11 +-
 .../selftests/net/ovpn/test-close-socket.sh        |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      |  95 ++++++++++++
 tools/testing/selftests/net/ovpn/test.sh           |  66 +++++++--
 tools/testing/selftests/net/ovpn/udp_peers.txt     |  12 +-
 36 files changed, 619 insertions(+), 140 deletions(-)
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
 create mode 100755 tools/testing/selftests/net/ovpn/test-mark.sh

