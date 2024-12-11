Return-Path: <netdev+bounces-151216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F09ED88D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF072165DFE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A6A1DDA14;
	Wed, 11 Dec 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SsCjyXnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B21BD9C6
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952767; cv=none; b=rAxD8qNOdgo44J03/3kyxyZXcRVcLs0MAFrBcaprfEe5m6YRZZxkmu3R2is9Q2YKBTytZO2l0BZnDHwFk6PLz/lVDeC61h111RgyBvKhmb+x2VjOaITsfYZtIGtzoTfD0GnLx+goOVNUWLX665wyNObAN2+wJrdZ3QaV+s92vHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952767; c=relaxed/simple;
	bh=Ms+0Snq+ZKsJjzBT0kUuKksztUg3wDuNRouAz08YE/s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tqSZ4JBS/6a63Wv/cjE3G5kAjGEpzCij2HA+AJ4L58h+Mqvey6GDDJm8BWUxvJYGF6aSSjyiatDNY1CZhNOigMQv9p8gr7ZuE+x82ER24xYxVKH7V9PhO6NVEP04SJqXJG4/wkUvECEb9GKAY3vnNkOGXPQekvKEekRIzgo2HM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SsCjyXnP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a736518eso80546815e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952763; x=1734557563; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WruRpT33WvibcF7ZTHjF2FlOF7he27nd+Nkq8VbaeB4=;
        b=SsCjyXnPQp23rXom3QKt6/+aZinPdi8r1u1XjKobLTIuPT/QH/ASofIIdGjBxdDKQS
         SKymLjPrvIfiIcpnmUwTSYUCTSvNQuw58WK+uOfOhnlFMHJ3N+OVV0CaD7pdqBBxUM39
         gfkiMvZKmrLOxEo8/QQIyqL9BDz1oiXrvTuHer700zSak3eKWl3VLws3w+eoZWC3WhUX
         1xTAa6aKRAp0gUOYLsKwhzi8F2TeSXOIb/NyCCsl9rq/2+6Em8lAQVgl1sMc33AsSYb/
         xAwT50at1IHlzNZ7k4E5JqF6SOdr7C70unLT6Bh4bE+kBGSAOlQeMrEZplNbhITSKSfX
         9eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952763; x=1734557563;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WruRpT33WvibcF7ZTHjF2FlOF7he27nd+Nkq8VbaeB4=;
        b=sjedSSDI3+Pm3vkmXOKJDzvHVA/zldU4e0Y0CLLg/JltDW8VYf4sCxszk6RJEnqtFh
         0ByeLDm3NZhTo3GIuC8jkk5xwuKsdWn5Q2BRfgYqSEXmWDAsA+Y8GrHEJBVXz5Ves1NZ
         Inh34dRNqHQIdUj7QSmrvkjZ1A5fI+3fipXrt4fQAIWDX3/1HGV2dpFUtBuOVyi1xRmQ
         qyiFnYrCTI4Eu+5+bDwT5SxCXjGUby3CeuU6tWPcEUwI3T2gdFxYpzSDP5OB8EgWiQI1
         xvWMEngocmjCCsDlicA1JKA+/U0c2IszGx6T8m+RFsfaah3+2Mud3iHMo9qtCw5y30dJ
         kAHw==
X-Gm-Message-State: AOJu0Ywbx5bzt87tK/58UNzuRNGhvI4NQ6J7U8iG4P5noRoLO7DtuAsO
	eGvYSFjhrJ9r48fvA6fCqXfmq/WguOicq9uuCbne7bco1XiJOZO4ckZ7XZImwQU=
X-Gm-Gg: ASbGncvPvh0exV+HC9ICd/cK7EDo9+eUzG3wXQyKnsHYf9fvA/GjTwv/O3htk0t/y2G
	4PEdTuu52Az2/XAS31u3+Ob+czC/ba8p7udCgPf9KUTBtx2h4qqQkXeIsP2JK8juaR6zw1fnwjX
	HMIQrz8itOI62N7F3YiJCsyDahFL7+vpwL+NQwgp4Y5VfcLcxUj7Tu++L2+XkL3/+FM0LhxM1Fi
	eKAaM9t8FXcUczdwVB/yf+Sf7qz9q9K5fQz+z0Xb8laS1kDg5nDEw3OxH6WNGCD5w==
X-Google-Smtp-Source: AGHT+IHvuIqWV6u08dJbczkURRkthj8sjZtZxR5JevnU0HCHORsfLNDg9R05lUwlARDy6mcpxdn+bg==
X-Received: by 2002:a05:600c:4f11:b0:428:d31:ef25 with SMTP id 5b1f17b1804b1-4361c3ab1bdmr41211505e9.12.1733952763458;
        Wed, 11 Dec 2024 13:32:43 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:32:42 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v15 00/22] Introducing OpenVPN Data Channel
 Offload
Date: Wed, 11 Dec 2024 22:15:04 +0100
Message-Id: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgAWmcC/23QzU7EIBAH8FfZcBaF4WvZk+9hPEA7WA7ShjbNm
 k3f3dkaXWLKDYbf/AdubMaacWaX041VXPOcx0IbaZ5OrBtC+UCeezpgIEBLIYBHzcd1KhxpKdN
 ZrwMwuj1VTPm6t3pjBRde8Lqwd6rEMCOPNZRuuHf6rb18hlzucsjzMtavfYbV7/4nTdq/tNVzw
 UOI6HsAE3rzOk5YqPJM7faUVYqGgnlQKcjGszNKOOciugMrW+sbK8n2qK0/d04FOMqFh4Xmg6h
 AFpRPySkVkz/KVa1tnisVWetS1BGttQgHVre2nVmTxQBadUlaLf/lbtv2DQz/klL3AQAA
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 steffen.klassert@secunet.com, antony.antony@secunet.com, 
 willemdebruijn.kernel@gmail.com, dsahern@kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5328; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Ms+0Snq+ZKsJjzBT0kUuKksztUg3wDuNRouAz08YE/s=;
 b=owGbwMvMwMHIXfDUaoHF1XbG02pJDOlRrPKqySem/1UxfjjNLsJukbSWz8MpJjwl9Qu+teS0L
 77c7a7SyWjMwsDIwSArpsgyc/WdnB9XhJ7ciz/wB2YQKxPIFAYuTgGYyNpPHAyz05j3Jpi0bnU6
 FCH21s9Z3nLSxf7Qa8b7m7fEZM143aSQVST5ZNbBL+ze1jY1b/UvrnWR5OS49uZL3veyL/90e7m
 /SZh9FLRwubN9GteG7wKpP9h+WfHkXAr69e56Yp0OYyJnaHGdxQSnJ/HRQp/NIxV2F94TkU1pbz
 84cWcPK8c1T6+3pZWiLQeF9r7/zPk+oM7oQtmXVK0lTytY3skvn6345lx88Vlx/VrhvLywdUlXy
 kX0l267Vnk+nedZk/jTEt8p36pnZdbZcAUYvL0gNz0mID/214/Kulmh77bcDJI/n39FN3Bzp2Yb
 u2HTrdZFBw8+zFM1S7bTevqF1Xp7+sNF9f6lRTdde8x1AQ==
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v14:
* added socket-netnsid netlink peer attribute containing the socket
  netns
* avoided dereferencing ovpn_priv if NULL in ovpn_udp_encap_recv()
  err path (reported by smatch)
* released ref to peer in ovpn_recv() err path
* made sa_len signed in ovpn_peer_get_by_transp_addr_p2p() (reported
  by smatch)
* avoided starting non-doxygen comments with /** in ovpn-cli.c tool
* shortened peer timeout waiting time in kselftest script

Please note that some patches were already reviewed by Andre Lunn,
Donald Hunter and Shuah Khan. They have retained the Reviewed-by tag
since no major code modification has happened since the review.

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (22):
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on for MP interfaces
      ovpn: introduce the ovpn_peer object
      ovpn: introduce the ovpn_socket object
      ovpn: implement basic TX path (UDP)
      ovpn: implement basic RX path (UDP)
      ovpn: implement packet processing
      ovpn: store tunnel and transport statistics
      ovpn: implement TCP transport
      ovpn: implement multi-peer support
      ovpn: implement peer lookup logic
      ovpn: implement keepalive mechanism
      ovpn: add support for updating local UDP endpoint
      ovpn: add support for peer floating
      ovpn: implement peer add/get/dump/delete via netlink
      ovpn: implement key add/get/del/swap via netlink
      ovpn: kill key and notify userspace in case of IV exhaustion
      ovpn: notify userspace when a peer is deleted
      ovpn: add basic ethtool support
      testing/selftests: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml              |  372 +++
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   14 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  383 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  446 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  339 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1189 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   57 +
 drivers/net/ovpn/peer.c                            | 1266 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   59 +
 drivers/net/ovpn/socket.c                          |  180 ++
 drivers/net/ovpn/socket.h                          |   55 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  578 +++++
 drivers/net/ovpn/tcp.h                             |   33 +
 drivers/net/ovpn/udp.c                             |  397 ++++
 drivers/net/ovpn/udp.h                             |   23 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  111 +
 include/uapi/linux/udp.h                           |    1 +
 net/ipv6/af_inet6.c                                |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   17 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2366 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  182 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 50 files changed, 9603 insertions(+)
---
base-commit: 65fb414c93f486cef5408951350f20552113abd0
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


