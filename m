Return-Path: <netdev+bounces-153164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B69F71E3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F00618906D7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E27D7580C;
	Thu, 19 Dec 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WtuLua1c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E66CDBA
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572523; cv=none; b=Oo6hUrId9rLRR0H5YJkpcBkY8MeQVBxrbGnWopjxHD4ZiN8/rnIHmSKS+hOwthoVQ/IPhjnmVQgfrT0HT/UQVlCHxHzrIu6+TVngmHKPWFHBOJftuzTlVmgtznMrjFCYyBs+N49gcrI+QC/hM3tRJQjKBGAZxvO9NyZQwKP+qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572523; c=relaxed/simple;
	bh=RM1xjg6PPOzWYsdDSlUgZxyvoqc3TihTKnfhe+Qq09g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sCH9VLSO3RvLX+0winVeePyUxfc4pkByg2RP5LsPFUsw5xGy4m8QCnahYPXy6dA0x4BWkruJQn2x2MHDYNtLrXFNkDV8g78zzQCSS+dgzE4WVXfGy/ufB5Hr4G0E22vIzhUZhuWdRqejmbnJqCmieqRr1ORrG9py2J1xeXRfc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WtuLua1c; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43618283d48so1871805e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572519; x=1735177319; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9xrzt/fxTBS1Xva3xY4fFWuu9U40IFRufoLxRngHbN4=;
        b=WtuLua1cv7ZYIeQjZyC12isBlNizKrzQhGViN3XPJPzyuHIu6bgeRpEMWCyIc+D44C
         YmeJ9EE6+1WtGdELQF27+AG58m6rw6KvjAZwuXTg1DLTXpi7g//dLNVpEpBpugkOHubk
         lU6Fz+9NLld3Nd2qALIxk/jfpYZTpqSnCA5pgVxpVOh8CBpmkE8tJ7gJGjSeDZlhcxYO
         j5mXWxAWtrCqyF3SnPn9iLGfAXXXS3JLfOOmVffOoUNREAklN+Qc2mK5vAlh88rMomhZ
         vXTSCQHQyR8eQPi/XqnjFMw/DVIcFOcIlHcZg9gmuc9uy4Oc+5z7MjOuBmyCOhuX4tBA
         1IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572519; x=1735177319;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xrzt/fxTBS1Xva3xY4fFWuu9U40IFRufoLxRngHbN4=;
        b=O13carQECs0tvFsw+kN8pEZdqgTKvKiCrCr5PLG00/zPfSOXuiDZryfa8PG1wPiHLE
         gyI3J/cQMIARlxZTdRRa4qKFXPPJ1vQHEAZlOh1OpVaEVQe8+4pTgkTK9xD+K51xtEjz
         mOWK4TfRUTR/lSXHOETC0ErsX924MNBQihJBo+DtLhlPM0lkBC5AFfjKCyXsOIIYnV/a
         19LeuJ0PS79LfiHgHNND9KCVTRyczZas8ETxQTeIfuz5SNzDP3ljTmV9w1N5kketDJAx
         9DBJlyw9VTLpWvY2kOSUgodIW5PTHuu7IznXq8K8xy8IDcGvKkNxuNQFzIAEt80WQPzY
         iMYA==
X-Gm-Message-State: AOJu0Yy4AWNk5QhjX6w4QmwPbNRacG90WyKAzt1zmfOATm2YWLFcprFB
	DyXTv4UOzWTb5OU2WSNQLf4Ij9gCdGm9LGvdH4XJTA8c+XT4rcEmOedyn4J3NVU=
X-Gm-Gg: ASbGncv7pJKYUuXb+OXqWKj5q0sfyirrOs0P5jW1fZ00ruyEArUed6UB6pzAVZNwFps
	7yns0TCyKfQJuM39ZOQuzz2A8FDswuhjPGX3+JsKOV9QZyCwSTC1T4Y/fXw9mcU+Pc8wZoBnoKU
	vxFNwa0jR6gSO1lgl66m25K4+SkKdGORTdoV0wtlnw17/fdjCqcPfKjVA+It+LS/DqnrVHIYltW
	VAG97wXwTE2DlRr+pITGVWo27cjv+stX2/LjDEd2hDt3q8iizf1CutjdUX4RqoBm+pH
X-Google-Smtp-Source: AGHT+IHkyBPC/ADkICu1EcYgUOdO3Sx5zKDDEH3ZM0YWpa3BdjNgokkGIZcLn/5AEOc5cOcjiL2TrA==
X-Received: by 2002:a05:600c:314a:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-436553fedf4mr36587155e9.29.1734572518910;
        Wed, 18 Dec 2024 17:41:58 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:41:57 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v16 00/26] Introducing OpenVPN Data Channel
 Offload
Date: Thu, 19 Dec 2024 02:41:54 +0100
Message-Id: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJ5Y2cC/23QzU7EIBAH8FfZcBaF4avsyfcwHoBOLQdp0zbNm
 k3f3dkaLSblBsNv/gN3NuOUcWbXy51NuOY5D4U20j5dWOpD+UCeWzpgIEBLIYBHzYd1LBxpKZO
 s1wEY3R4n7PJtb/XGCi684G1h71SJYUYep1BS/+j0W3v5DLk8ZJ/nZZi+9hlWv/ufNGn/0lbPB
 Q8hom8BTGjN6zBiocoztdtTVikqCuagUpCNjTNKOOciuhMra+srK8m2qK1vklMBznLhsFB9EBX
 IgvJd55SKnT/LVbWtnisVWeu6qCNaaxFOrK5tPbMmiwG0Sp20Wp7lmsrSGw9ryCqpEVJohZXNf
 7tt2zdgp95IMwIAAA==
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
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, willemdebruijn.kernel@gmail.com, 
 David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7208; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=RM1xjg6PPOzWYsdDSlUgZxyvoqc3TihTKnfhe+Qq09g=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oPnlX79Ipy6zPOquY7WPi0e8evvOWJhVFWg
 HSIoFnL40WJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6DwAKCRALcOU6oDjV
 h/MpCACvtWA4LY9wvvxReagseqhfN+OfWI2QmadCzmKQUSRsVEU2RhwFe8deoccjEy2L8aNKGsW
 AR/uJecJles6dyNlF5PGsmsJEQYzO55pFP0edLb6GhTzDXpA06ijAiDu12kwl82N+w/U9Rv6Z23
 7cYQt6BwoHIQn3fCMpREMDZIpejiP3NWIg1jmI69n3+aNt6hOaF4GE5Z7jP3oQE8A70Q1j5l5Kg
 6pmMNfS3rWKvzBggsH+J6HHpzMMtwz1s3p4YU9UDnb8DpA82yynq2UoQ1yZoWZIr119NgmCSe8H
 dmaN1ieUCE9HpikuyBWif2odNvI3JCB8MRUXCF4XMDnDtosC
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Notable changes since v15:
* added IPV6 hack in Kconfig
* switched doc '|' operator to '>-' in yaml netlink spec
* added ovpn-mode doc to rt_link.yaml
* implemented rtnl_link_ops.fill_info
* removed ovpn_socket_detach() function because UDP and TCP detachment
  is now happening in different moments
* reworked ovpn_socket lifetime:
** introduced ovpn_socket_release() that depending on transport proto
   will take the right step towards releasing the socket (check large
   comment on top of function for greater details)
** extended comments on various ovpn_socket* functions to ensure socket
   lifecycle is clear
** implemented kref_put_lock() to allow UDP sockets to be detached while
   holding socket lock
** acquired socket lock in ovpn_socket_new() to avoid race with detach
   (point above)
** socket is now released upon peer removal (not upon peer free!)
* added convenient define OVPN_AAD_SIZE
* renamed AUTH_TAG_SIZE to OVPN_AUTH_TAG_SIZE
* s/dev_core_stats_rx_dropped_inc/dev_core_stats_tx_dropped_inc where
  needed
* fixed some typos
* moved tcp_close() call outside of rcu_read_lock area
* moved ovpn_socket creation from ovpn_nl_peer_modify() to
  ovpn_nl_peer_new_doit() to make smatch happy (ovpn_socket_new() may
  have been called under spinlock, but it may sleep)
* added support for MSG_NOSIGNAL flag in TCP calls (required extending
  the skb API)
* improved TCP proto/ops customization (required exporting
  inet6_stream_ops)
* changed kselftest tool (ovpn-cli.c) to pass MSG_NOSIGNAL to TCP
  send/recv calls.

The ovpn_socket lifecycle changes above address the race conditions
previously reported by Sabrina.

Hopefully all though nuts have been cracked at this point.

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
Antonio Quartulli (26):
      net: introduce OpenVPN Data Channel Offload (ovpn)
      ovpn: add basic netlink support
      ovpn: add basic interface creation/destruction/management routines
      ovpn: keep carrier always on for MP interfaces
      ovpn: introduce the ovpn_peer object
      kref/refcount: implement kref_put_sock()
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
 drivers/net/ovpn/netlink.c                         | 1178 ++++++++++
 drivers/net/ovpn/netlink.h                         |   18 +
 drivers/net/ovpn/ovpnstruct.h                      |   57 +
 drivers/net/ovpn/peer.c                            | 1256 +++++++++++
 drivers/net/ovpn/peer.h                            |  159 ++
 drivers/net/ovpn/pktid.c                           |  129 ++
 drivers/net/ovpn/pktid.h                           |   87 +
 drivers/net/ovpn/proto.h                           |  118 +
 drivers/net/ovpn/skb.h                             |   60 +
 drivers/net/ovpn/socket.c                          |  237 ++
 drivers/net/ovpn/socket.h                          |   45 +
 drivers/net/ovpn/stats.c                           |   21 +
 drivers/net/ovpn/stats.h                           |   47 +
 drivers/net/ovpn/tcp.c                             |  567 +++++
 drivers/net/ovpn/tcp.h                             |   33 +
 drivers/net/ovpn/udp.c                             |  392 ++++
 drivers/net/ovpn/udp.h                             |   23 +
 include/linux/kref.h                               |   11 +
 include/linux/refcount.h                           |    3 +
 include/linux/skbuff.h                             |    2 +
 include/uapi/linux/if_link.h                       |   15 +
 include/uapi/linux/ovpn.h                          |  111 +
 include/uapi/linux/udp.h                           |    1 +
 lib/refcount.c                                     |   32 +
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
 tools/testing/selftests/net/ovpn/test.sh           |  182 ++
 tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
 56 files changed, 9698 insertions(+), 5 deletions(-)
---
base-commit: 4b252f2dab2ebb654eebbb2aee980ab8373b2295
change-id: 20241002-b4-ovpn-eeee35c694a2

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


