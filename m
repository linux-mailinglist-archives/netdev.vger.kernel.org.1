Return-Path: <netdev+bounces-157277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE9A09DBF
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B0B188D5D9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A56216E2C;
	Fri, 10 Jan 2025 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VgUdhjfp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FB2144AD
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547976; cv=none; b=HInInYYBwiIexCv9gaw9Ap70OXfVQ42LGI5DJHfkgIf7LB4/E1txJuISIYLtrwPA7HpruvfUrZL9cp0PIHdT4ka5oiiQL0n4zNKcoLWkwCuqbUmn/tMQT1RTitVKox9zqhoFxorZ+YToYtC6/vVUXensMt0ZWwe6ZGz37tY6RPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547976; c=relaxed/simple;
	bh=y9RkSwpSMt8vws2KO4heuterucNInrDD5WdRELdWuAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e0N4aKA488It5Ix4s9dQymfkyunASZPsONVsDIrrP021aZrLiUIyioSTI/22Qwc8DL2sCs6P4LpOMeERkh/ewpBe3ldbe88Hv+i6VhexfazXdR3o8Qwt0g1NEAjAUvfMd8y+oTxJvLx3pZhNo/Q1JBRvMMnLdlFvR69UK8joS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VgUdhjfp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so1448050f8f.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547972; x=1737152772; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPGgfR69GM1N4IrW34bIx9GJXAddn0xlEVT7ARBMgiM=;
        b=VgUdhjfpzvVL7ep3VKL8gmHs3gQ+3zbWri5f8gieyaDN5yKoLH41PE3MY2BcTKjs2z
         PAHvKWCf7Fi5n3z6hnBwXIQ9VPiZ0KedzLEfVunB6QzmDrMZoKzkcT7LgbVbrTHGsopD
         RHdlRM/4aL/pOFhanYSw7k2iTWSKocIpidNXtv3iGv9Iu412h3aJnRLSpWH88HCXrzcD
         MuwvhJf7ryyasWT14quL9wisd714JAGbadNoD4KcYeKF41saC+GlQQIff4bKxqE8YZXP
         z++q2DONJW0z9QuEak2wPH8/qigZjADfo7OMWq3xMezumvdeV9OSED4nCR0wnMEbzHnM
         Z2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547972; x=1737152772;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPGgfR69GM1N4IrW34bIx9GJXAddn0xlEVT7ARBMgiM=;
        b=b9nR4wMbD7GYyUfzVODDgQPU5OF7onjLjh2M5c5vur8DFQZttOKHFodk3mzD/GZvbi
         WJQ3w5Faq+SqRGff5fGb+RHxgHWbOECE0I1VBVnva3cQFP60RmUJx73+mxsZd70QUOm5
         M5bSM8HG+psK5l0dzwH+e9sB1RMDgqnYtuuJUM4xOdVjgI7AFXZ+mQq2K3ynfZW95RVa
         O+09tJ18h86jsdPCkNJjgvYoKXrofpYD+fGzACq0TlC/qzAeTE+Tl3IY6VRYccbSmr7D
         gFP2mzemO3Gj5+yuDyoy4fY9iqCqINMsfFojsC9ryojFi1HTEEG919+d9Q2XKOUETOLG
         Xmqg==
X-Gm-Message-State: AOJu0Yw26G1Vn4NTPGf/6afR0RAK4ILBVOnQpaxnCOTVsrDS1ZDoegID
	KcGQwwda6EHVBjRj6DFVqac7t3rE+AxEo6HfmsJN2MKIfiE11o3u51oJ7lsEkGg=
X-Gm-Gg: ASbGncswToW0fgxEbWVpeJ4dmdihNW7uyJ99NrUPDhhgpeA5zbqhHhzL6kgCQfKxHv4
	bCjSokudxcnZq0zMBV+tLXu1gAdXza63LsLwGdh6fNWaoSooJmEFkkO9HENlwRg8eQdjlZJ42Vh
	2+DP2dtECtqM/QZhrgiuZFm23UFc9/iZDe1EvGFAxAWraJUsOD62OfnaesoMuPftOUusFMSlCtB
	X9J2wy/uecPc53fAZybErKdgjMjY5tE0m5tLT+560KQJPuGok52/+hTB1zhKh9qDNZR
X-Google-Smtp-Source: AGHT+IGxS/UakDRaQlLP17UQGuftHA5TxHIgYPTvRxLWb0vgtcAtIxlzgerwfXAXBQHo8wvmVigatw==
X-Received: by 2002:a05:6000:4608:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-38a8730aa71mr9949862f8f.27.1736547971518;
        Fri, 10 Jan 2025 14:26:11 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:11 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v17 00/25] Introducing OpenVPN Data Channel
 Offload
Date: Fri, 10 Jan 2025 23:26:16 +0100
Message-Id: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIiegWcC/23QzU7DMAwH8FdBOROI7Xw0nHgPxCFpXZYD6dRO1
 dC0d8crggWpuSXOz38nF7XwXHhRLw8XNfNaljJV2UB4fFD9IdUP1mWQA4UGLRiDOls9rceqWRa
 53kebUMnt48xjOW+t3lTlk658Pql3qeS0sM5zqv3h1um39vyZSr3JQ1lO0/y1zbDGzf+kgf9LW
 6M2OqXMcUB0aXCv05GrVJ6k3ZaygmkoujsFIzZ3wZEJIWQOOxZaGxsLYge2PnZ9oIR7uXi32Hy
 QFMQixXEMRHmMe7nU2ua5QGJ9GLPN7L1n3LG2te3MViwntNSP4C3s5brGyhvv1oklsIx9GoyHb
 sf61ra5/maZjAFw5Dv6b6/X6zf+JAm5bwIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6282; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=y9RkSwpSMt8vws2KO4heuterucNInrDD5WdRELdWuAQ=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGeBnquijfmrr/JlcHZ3FO7KJl0Ij/0ZALF13yfmeChWzMDHB
 okBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJngZ6rAAoJEAtw5TqgONWHmwkIALlH
 DrDk+yKNPT0b+jL/xUGIyVixH29OgJNIgMF3m2prxUMbZuwCsCSZocH0HxBe0ITTxcg0AOxqNmt
 XM62nJAtyiHfxWfkFDNnSh2DGUIWJOzA7NV1daj91Wkz+I3aIeDTC/AZPYf2c5rKXcQYiO9ZJlE
 BqIelZfUq96/tJS/w8jZYM/pW6P1lkdwYMGPuFMWAL/d7lgzqmAE8XXk04sG3y9XELaubZzsGVM
 XPK6z9Un25eAQDBZjoi9CusaSKDuA3rocG56Y0Fc8a1sff1cs1L8pXMgSjP4grHHVrakoXvUhO5
 qmy9usJ6GBTNr5kkO/utKv1Vg/uSmuz9L7aNKpw=
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v16:
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
 tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2366 ++++++++++++++++++++
 tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
 tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
 tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/test.sh           |  185 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 53 files changed, 9672 insertions(+), 5 deletions(-)
---
base-commit: 7b24f164cf005b9649138ef6de94aaac49c9f3d1
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


