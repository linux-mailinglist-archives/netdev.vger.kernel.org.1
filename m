Return-Path: <netdev+bounces-170037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F06A470F8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56DF16F399
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C154764;
	Thu, 27 Feb 2025 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dBCqNyKI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAC8C11
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619358; cv=none; b=pvqkybuD6lkOvmE8nHjA1lqMV7JjMZ6jMxaByqzneCXlHYcBcWMfKrK648jsxbGrLypN5xandtEoRte08me5J6EZIayIy7XFGssErE6SUgnTdtf/zC8un/xt9u6bZyTfcVba6vNDDNUGBGfv7ga439cyEqIR8Hdais0hNRREDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619358; c=relaxed/simple;
	bh=MReI75EkV9k3t9AT9vcvthtAG1c1xwvUZQq8L8ybBjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iBYJJw5BUDgCNP+wQ3B+FWhtHkp2y8H7MitUqp33t6JyO81UptTIqxXvNDGy6sN+nUmtdhWWGrFFZXCpDVrAk6GhFSBxPP7fct9IO6DOD7ZhXP7n7XAM1w0nWaEuDXMaZB0Uc/2wRKoU+UvyB9/pNiEra6qD+yPSOPbS8oJuWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dBCqNyKI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so4796335e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619354; x=1741224154; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FheOGHvldvdkyHQgGOBZSdE/sgizbueqBR3yf2AnrDw=;
        b=dBCqNyKIwrBjxa1Ziqv1AKb6Azj3mCzjGjgjfmzz1AVTBe0rEuEYBrxFUnkZuSpWWZ
         H3vFwIvro0ZE0z0Ffb6TE2SkcLyoARz7RtAQryEl394/lwflfTXMcP0ORjYocIp2t4E2
         IicBvjcve6TkKduHmTDc0brPjM/G5Z1KSo4Ei7lQ7tnFFLdddFp3MlZb2bSB2J8LVJvJ
         Sns6YCtsyMiV2eieIvM8iLhBrAUlMmESnAg5Nx9W1qlLbPj/VsoS6YZP1p8/axjWhYQD
         VVp7zYmaHTrLRu7hd55p5JD74LpGnMT7MqOr5rAjSzO94GnLKHjw1xTfGMZ8eHaWppUp
         yXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619354; x=1741224154;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FheOGHvldvdkyHQgGOBZSdE/sgizbueqBR3yf2AnrDw=;
        b=GqM+sbB/zX3zgKtbl3o8qgLWXrjJ13PY1lgiI0PMxNTWO96O+f5Mjelw+Ch3/wGxJ2
         otU2FfT2pHEwwnIu0cFUS9k241x5VSixFVY9qpJxJHOhGrPgyQtLMPA/aRaG1bZRCznh
         XA0WKu4CAj4db7cF3d33R0w/SLCgVHiBFWPiyyMWEFnJ23NxUBqUd7PU59sFoNcv4YsE
         nS8Zu8Y2Hr3rnGKLPEf1FwFwGRhmKEBaWa/PHaQrFyMaGFMG8cj8RrNpFtteNwI0Fdlp
         Dj/Gmj3DURuyetZdMapVMw6SV2JHusETXz6ZFiPgQspaCrzhHqmnpVAgLjWX0DGLnYdq
         g3lw==
X-Gm-Message-State: AOJu0YwH2xxtas9hS6rlNBwwH1mf+KoBWgZXDhXXe5UBdXHdcZuBQl8s
	mNWyoS0UKjE7IZmB5OXJvildYjgS+6Y+Rw+cyn46eseAsFt05Ph6bs3p0AdywEU=
X-Gm-Gg: ASbGncs/b3BT/f5JDxPxj90IJbLGVbjCkKcmlDvRGvVemp39XssriUTAozrsOigICm7
	2oHnYkI3VIQ8nuekzyM5RHAG88B7GpkMLxoUISuGGNSvlkP5LL4yc8GNcq8ywPpSteZadotIFpO
	ohkznfZ6OsotQWDPLArfadtdmXD9dptrBjZop8LlGIJyXhNGq46S1W1/mg9pwFqgNMnQK/cjr7G
	xGcThyZJsfaviY5kySgKKhFGGmtvd1w6Uvv+fQDY5uvNSeCXHaLl6t304LS8lzWim4iflU26WVK
	hYxFHx/FG3NxtKsHkdY48ezPVHhRT9CFmWtrWg==
X-Google-Smtp-Source: AGHT+IFeSs672sXAOFyALkoLuDt0/snXViRIquPFtO8usRCbHvJa4+ASz7hRRYbZ8KNxAWOsuXFAFQ==
X-Received: by 2002:a05:600c:46ca:b0:439:9e13:2df4 with SMTP id 5b1f17b1804b1-43ab0f641b6mr87214775e9.21.1740619354455;
        Wed, 26 Feb 2025 17:22:34 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:22:33 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v20 00/25] Introducing OpenVPN Data Channel
 Offload
Date: Thu, 27 Feb 2025 02:21:25 +0100
Message-Id: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABW+v2cC/23SS27DIBAG4KtErEsLw8tk1XtUXYAZGi+KIzuyU
 kW5e8euUhMJ7/Dwzc8gbmzGacCZHQ83NuEyzMNYaAHi5cD6UyhfyIdEPxgI0FII4FHzcTkXjvQ
 p01uvAzDafZ4wD9et1QcreOEFrxf2SZUYZuRxCqU/rZ0etbfvMJRVnob5Mk4/2xkWv/m/NGn/0
 xbPBQ8hok8AJiTzPp6xUOWV2m0pixQVBbNTKcjGzhklnHMRXcPK2vrKSrIJtfVd71SAVi7sFqo
 LogJZUD5np1TMvpWraluNKxVZ63LUEa21CA2ra1ufWZPFAFr1WVotW7mmsjTjbg1ZJTVCH5Kws
 mtYW9s6164WlRBSGmU71bDuYQ1tEpV1ZLWLoJxDY2XLdrVVle3IyixEir6HmGzD+t0+z7u+q84
 mk0KGoF14tvf7/RejcH0TIwMAAA==
X-Change-ID: 20241002-b4-ovpn-eeee35c694a2
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, steffen.klassert@secunet.com, 
 antony.antony@secunet.com, willemdebruijn.kernel@gmail.com, 
 David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7274; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=MReI75EkV9k3t9AT9vcvthtAG1c1xwvUZQq8L8ybBjM=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75auNr90xv9Qr4TB1bKTIQkq6BTr/7VC0flV
 dMnvQhopF6JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++WgAKCRALcOU6oDjV
 hzDcB/4sgcZLIrq4j3a2InK0tN9zJUcGrhcYc7pgUqHrcJZunkygNzTW3rv+OsQ58ew0NQPFUJM
 TBejdcTSD+KlWStjWhPt5cVYR5BZAxihPEcAxCQqzCUlmEag1IAVRucACtIveG68dCtV7WfsCnk
 khDDP1CRoYg3UCGutEe95bsy822FgnsCBRsOfZathvXp4EkW8Zgq0Ue9Rux3ecLm04Rx2rf6wmA
 v4AnZwM+gV0LTbgUguHDYQsApUzxIcLXLVxK8G7lEXZUxK08d1i7t0UYaDLyQfDyG3go5kmm8Fu
 7GhuWBsKik8Q7/N+4j/+nWNuTVvksgWUkNaV3sYy50d805CZ
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

After some time of struggle trying to fix all hidden bugs that Sabrina
has found...here is v20!

Notable changes since v19:
* copyright years updated to 2025
* rtnl_link_ops.newlink adapted to new signature
* removed admindown del-peer-reason attribute from netlink API
  (it should have gone away in v19 already)
* removed asynchronous socket cleanup. All cleanup now happens in the
  same context as the peer removal. I used a "deferred list" to
  collect all peers that needed socket release and traversed it
  after releasing the socket. This wasy there was no need to spawn
  workers to leave the atomic context. Code looks way more linear now
* provided implementation for sk_prot->close() in order to catch when
  userspace is releasing a socet and act accordingly. This way we can
  avoid the dangling netns problem discussed in v19
* due to the previous item, it is now expected that the process that
  created a socket stays alive all time long.
* kselftest scripts have been re-arranged as per the previous item
  in order to keep ovpn-cli processes alive in background during the
  tests
* improved TCP shutdown coordination across involved components
* fixed false deadlock reporting by using nested lock class (thanks a
  lot to Sean Anderson!)
* exported udpv6_prot via EXPORT_SYMBOL_GPL
* merged patch for exporting inet6_stream_ops with its user
* moved TCP code that may sleep during detach out of lock_sock area
* reverted tcp_release_cb to EXPORT_SYMBOL
* improved kselftest Makefile to allow kselftest_deps.sh to detect
  all dependencies

Please note that some patches were already reviewed/tested by a few
people. These patches have retained the tags as they have hardly been
touched.
(Due to the amount of changes applied to the kselftest scripts, I dropped
the Reviewed-by Shuah Khan tag on that specific patch)

The latest code can also be found at:

https://github.com/OpenVPN/ovpn-net-next

Thanks a lot!
Best Regards,

Antonio Quartulli
OpenVPN Inc.

---
Antonio Quartulli (25):
      mailmap: remove unwanted entry for Antonio Quartulli
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

 .mailmap                                           |    1 -
 Documentation/netlink/specs/ovpn.yaml              |  371 +++
 Documentation/netlink/specs/rt_link.yaml           |   16 +
 MAINTAINERS                                        |   11 +
 drivers/net/Kconfig                                |   15 +
 drivers/net/Makefile                               |    1 +
 drivers/net/ovpn/Makefile                          |   22 +
 drivers/net/ovpn/bind.c                            |   55 +
 drivers/net/ovpn/bind.h                            |  101 +
 drivers/net/ovpn/crypto.c                          |  211 ++
 drivers/net/ovpn/crypto.h                          |  145 ++
 drivers/net/ovpn/crypto_aead.c                     |  408 ++++
 drivers/net/ovpn/crypto_aead.h                     |   33 +
 drivers/net/ovpn/io.c                              |  462 ++++
 drivers/net/ovpn/io.h                              |   34 +
 drivers/net/ovpn/main.c                            |  350 +++
 drivers/net/ovpn/main.h                            |   14 +
 drivers/net/ovpn/netlink-gen.c                     |  213 ++
 drivers/net/ovpn/netlink-gen.h                     |   41 +
 drivers/net/ovpn/netlink.c                         | 1249 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnpriv.h                        |   57 +
 drivers/net/ovpn/peer.c                            | 1341 +++++++++++
 drivers/net/ovpn/peer.h                            |  163 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   61 +
 drivers/net/ovpn/socket.c                          |  241 ++
 drivers/net/ovpn/socket.h                          |   53 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  571 +++++
 drivers/net/ovpn/tcp.h                             |   36 +
 drivers/net/ovpn/udp.c                             |  478 ++++
 drivers/net/ovpn/udp.h                             |   27 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  110 +
 include/uapi/linux/udp.h                           |    1 +
 net/core/skbuff.c                                  |   18 +-
 net/ipv4/tcp_output.c                              |    2 +-
 net/ipv6/af_inet6.c                                |    1 +
 net/ipv6/udp.c                                     |    1 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/net/ovpn/.gitignore        |    2 +
 tools/testing/selftests/net/ovpn/Makefile          |   31 +
 tools/testing/selftests/net/ovpn/common.sh         |   92 +
 tools/testing/selftests/net/ovpn/config            |   10 +
 tools/testing/selftests/net/ovpn/data64.key        |    5 +
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2395 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
 .../selftests/net/ovpn/test-close-socket.sh        |   45 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  113 +
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 59 files changed, 10084 insertions(+), 7 deletions(-)
---
base-commit: 91c8d8e4b7a38dc099b26e14b22f814ca4e75089
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


