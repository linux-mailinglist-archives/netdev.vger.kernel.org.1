Return-Path: <netdev+bounces-157668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F259BA0B2D3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E007A2189
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7E23A583;
	Mon, 13 Jan 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CYu1EGWw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A223874A
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760666; cv=none; b=Bk8OS2NaX1ulJHX2I4kbFxbq3EETCXEHHZFQTGCwM38dHC3R+sZCsIYHm0/zqtH+/5A77SFh5hrKdmAtIKDeN2lr/ENstCmuD+oiXJvjkWJH1qG+ZO7Yllp5usmYCuIfMlxSGii7oqOnjg+eX4+DcK6UbtQDxlCNNvDdKXE+Uus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760666; c=relaxed/simple;
	bh=7APpdEA4jr7ps1b8VWTegxDhvEoR42BTlzwB5PRlvl0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HS2Xcs8FxkeUFCFi8Uhdb6oxGfRAtVqdvjQ0Gows8l+F9RLtei6r7MCH3vJPkYcHqKy+h4S8l0TXmN++sTqbBk+PoCX6lIodxVA9geHIDhP9bb9XV1e2KDwSWswSAxnI2F/c3gLgly/WOKKNqPZaftnP4VHfDYsoOBFnxTvJVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CYu1EGWw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385dece873cso1941105f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760663; x=1737365463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc5Zf1W00VNHW+KjirMIPMombgAnhdag4FiwQVcWPXU=;
        b=CYu1EGWw+Sexo6JzQu9HyoI8VLGzQTKf6WYK8Naibsd8GK6bP0GUQ8U8Ha9CKwECmp
         HTzW2Bb4fyyEqKhs/K7K+6lWA6680TWyurKQg69izFj07DMPNyD3BPrAsZ5MzSxkBVlb
         CL7O34VtgAkN5Rf9P9rLgpPV9jG7C2pWfZ+5oJX82jURFkO+VjsCrMH4ILUs0O3YaK+0
         Skh4Fdivui/s2Ar8G9Jyh09Xnk11uh1rVd8phqXW/nJ/0Pc6tr4MEvK3h/K2v5p2y0Er
         UVqvrp9Oqpnlt9Lw8w42XhamYUSkE3cxcMnM/BZqMXWeq/P/8sm7KBvSCITmeTG7ZnDz
         O9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760663; x=1737365463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qc5Zf1W00VNHW+KjirMIPMombgAnhdag4FiwQVcWPXU=;
        b=vni7/mIJ7RvTZmOd+YrE7/HJ4bemB56BDLhBOInjkie1iOrcXVrzEn/fBVc4JcZyLg
         dpAx3vxCVydCxKit4A7myCAgWMNNtcGPivpiRUU/ZtYyughQB8m0wrXmEWNeY9ee388Y
         q0FvzSJmjiMh4qnRbf3nJ29JaYJI2kUeA5q2p74MlsYhFJBOuoHZr/o9wZWJcJ+sta9G
         yaomTaj9RGP0BMTGDaXJnEDrDYYYKN6gy8RsQGUFmT6nVwdbvacFlBGQ8y1qR23rZDjF
         JR+WqLecJoEqFAOGFpsW92btceza6VbB42la/I5l2y+5GWVVc1GQO+VkN7zctV6BCcvd
         us+g==
X-Gm-Message-State: AOJu0YwNQt2SIbcsyOJrq4eUitfaN0PAIfmOOZ81S/iBQJCSY306ZhFY
	53enOWTp1jGOZhxPVBj05F0ZcA640i6d241G3B9tVIbHtcXpnuBhY4mnQHS29xI=
X-Gm-Gg: ASbGncvJFcTETDOt404ItIOrWfjUM7kZfa1t6j30IXcGpcA+hxjb3qnx/cepp6vC8xF
	X5XJlreehRh+SYICh7skBVaSb2baiXG9eNORtD4p2aJOfQFWYV95KnYajHFoVTz1C54n9dTdJ6O
	PG6qNPXd1wOa+ooL7krOAOZQhuIn6nGnnqahN8Tn8Pb1/G30ktQZh+IlHJPniXZfU+z3a+/dxsy
	LRelsFEnaKXSprC9SfVuOezWDgk/k4BvA4Z024uwiTuXN2J82f3DPWrKR+ffS2O2mr4
X-Google-Smtp-Source: AGHT+IFQfk85cLlsOAwzvB9LsrBPxxUaxLijNlenjeYIFXR9Ee1wVy9vyI3gO6fw7g9Y/b7FRD93ZQ==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id ffacd0b85a97d-38a873045d9mr15294245f8f.19.1736760662737;
        Mon, 13 Jan 2025 01:31:02 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:02 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v18 00/25] Introducing OpenVPN Data Channel
 Offload
Date: Mon, 13 Jan 2025 10:31:19 +0100
Message-Id: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGjdhGcC/23QzW7DIAwH8FepOI8Nm6+w095j2gESZ+UwEiVV1
 Knqu8/N1BVNcAPz899wESstmVbxeriIhba85qnwBrqng+iPsXySzAMfCFRoQCmUychpm4skXtr
 2LpiIgm/PC435vLd6F4VOstD5JD64kuJKMi2x9Mdbp3vt5SvmcpPHvJ6m5XufYQu7/00D95e2B
 alkjInCgGjjYN+mmQpXnrndnrKBqijaBwXFNnXeauW9T+QbFmobKgtsBzIudL3XEVu5+LBYfRA
 X2KIO4+i1TmNo5eraVs8Fzdb5MZlEzjnChjW1rWc2bCmi0f0IzkAr11aW3/iwlq0GQ9jHQTnoG
 tbVts51N0taKQCrXacb1t+t5Uuqsp6t8Qm192Qd/LPX6/UHe9V8MKsCAAA=
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
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6542; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=7APpdEA4jr7ps1b8VWTegxDhvEoR42BTlzwB5PRlvl0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2A6+0VNKx9H7gk5suENobFMy2b+YYzOg8v7
 0PBqMNVfaWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdgAAKCRALcOU6oDjV
 hydMB/9DvAdG0+pShJ4O3fl6TCLBcp4slhWXBTr2VKtEXvnZOk9hvjeIaNmB8Uij+b/Y/Oy+/3a
 EV266eJ5b0s79KHM4Ysi+I+821v7c0S4VNgTfwrV/hFK8s1k5y2t1RbPYaC6RiY7z5r1pbZQ5N5
 KhuB6MFW/8d4YwI4kve4f2CpdkdvzpPEiBJFtRQxgKU4pSQa1xwN7kZ9kYDTMeUhyJJ0M7mFR3d
 sIujOcfnroL587yTzl5jB2TVu1UgMz1h+lGlNOVHWe2nDUyT6IpYfgER+SXVMfDJnslskt0QFau
 lqk/Xurm1OWvfV6GUEbZTkLuQ9y2MBF3wMBHDLolXiwRNJYl
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v17:
* fixed netdevice_tracker pointer assignment in netlink post_doit
  (triggered by kernel test robot on m86k)
* renamed nla_get_uint() to ovpn_nla_get_uint() in ovpn-cli.c to avoid
  clashes with libnl-3.11.0

FTR, here are the notable changes since v16:
* fixed usage of netdev tracker by removing dev_tracker member from
  ovpn_priv and adding it to ovpn_peer and ovpn_socket as those are the
  objects really holding a ref to the netdev
* switched ovpn_get_dev_from_attrs() to GFP_ATOMIC to prevent sleep under
  rcu_read_lock
* allocated netdevice_tracker in ovpn_nl_pre_doit() [stored in
  user_ptr[1]] to keep track of the netdev reference held during netlink
  handler calls
* moved whole socket detaching routine to worker. This way the code is
  allowed to sleep and in turn it can be executed under lock_sock. This
  lock allows us to happily coordinate concurrent attach/detach calls.
  (note: lock is acquired everytime the refcnt for the socket is
  decremented, because this guarantees us that setting the refcnt to 0
  and detaching the socket will happen atomically)
* dropped kref_put_sock()/refcount handler as it's not required anymore,
  thanks to the point above
* re-arranged ovpn_socket_new() in order to simplify error path by first
  allocating the new ovpn_sock and then attaching

Please note that some patches were already reviewed/tested by a few
people. iThese patches have retained the tags as they have hardly been
touched.

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (25):
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
      ipv6: export inet6_stream_ops via EXPORT_SYMBOL_GPL
      ovpn: implement TCP transport
      skb: implement skb_send_sock_locked_with_flags()
      ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
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
 Documentation/netlink/specs/rt_link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  382 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  446 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  350 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1183 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   54 +
 drivers/net/ovpn/peer.c                            | 1269 +++++++++++
 drivers/net/ovpn/peer.h                            |  164 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   60 +
 drivers/net/ovpn/socket.c                          |  204 ++
 drivers/net/ovpn/socket.h                          |   49 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  565 +++++
 drivers/net/ovpn/tcp.h                             |   33 +
 drivers/net/ovpn/udp.c                             |  421 ++++
 drivers/net/ovpn/udp.h                             |   22 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  111 +
 include/uapi/linux/udp.h                           |    1 +
 net/core/skbuff.c                                  |   18 +-
 net/ipv6/af_inet6.c                                |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   17 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2367 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  185 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 53 files changed, 9673 insertions(+), 5 deletions(-)
---
base-commit: 7d0da8f862340c5f42f0062b8560b8d0971a6ac4
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


