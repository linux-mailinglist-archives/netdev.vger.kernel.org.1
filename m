Return-Path: <netdev+bounces-93556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869018BC541
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91E21C20894
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0493BBDC;
	Mon,  6 May 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gdl4ry0m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0253BBD2
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958132; cv=none; b=LHMB60UrYzMS8fL3dBNUB3gAqPVOwNesoBKo+umxF2YI9ZOl5rzH3RZ+Dwz7RPh2YxLT4y4eM+rgsFRQ09xARhqTp2gjYa+/33Z34WfROGxOhDy3xQSkY4JY+BH7+NWYJpzFvvzZUKncPoTu7k+Cpq8lTH8SCw3v4GVUm5Ax/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958132; c=relaxed/simple;
	bh=nbav2kXu5qZsxJbZH30bE1rkbi+z9XgcVmW+2fkRFn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njm3v/NFkPeElUlu3mBlBVPwACjoUmvoLE+8Pma0A+gRXvYiwB32VxDApBefaRSdERhAxeiaxFENbIN/C3AvP/+Hu6GrsXD1AT2u4fqjYxpCtuK+I10q7m9LpYtfgVe5sjWy3PXu3MrD6y3nnN7d/AsmsPpmId2XBa4oyIA2jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gdl4ry0m; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34e667905d2so1105180f8f.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958128; x=1715562928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKghExWnOj81puZr77X84z0xK6Z9rPCYpyBIse13xeQ=;
        b=gdl4ry0maiAoiaSrQUcig0oYDfUQxwUCMDQwgEElYem/ETzUuA4mjkbUluBh9avyst
         vhhXEJ8LCObx2xW172A1dbEn7FP5kYeJxrpFHp/GG6ft+RLC4IVD1ezX3Wo2BU10t1jI
         KYc3tmn9XR/+A01fPMP4SNriL6sfJN9J/BP/sE/UhzcaERcyj2+7Wqg49yU/4P+1xX+Z
         ISrGt8hT3CvVBERHU1dJR4A8ZTQciELpf5KwMPGUrdkU8WtVrNolfQfKZhMGXZZQeFM4
         uMIN08wLFVQJzi+3wthxn5Sww86GJM6d/vlASylZRcQxNq8AEr4G//+M5pw08jA9VnPq
         Vmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958128; x=1715562928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKghExWnOj81puZr77X84z0xK6Z9rPCYpyBIse13xeQ=;
        b=NZLY7gG8p6bCA3GospN1dbFCnGf8xOQljZhfMYZF2NhZv49Htt8iKOe24oD9oHVHr+
         XHqS0Sj2M9vq+l+JgdMkZUj8ZAC7lqLofLWGK0JD83AnIZI5Q+dat881vDbzNEXbuTx+
         5auBpc7ip2+rE76JITW34DT9LLTfHCho2gHN6Ve0c/RMPeVI9rrCgWAeEWrwWlYcfLSS
         UqgVstBN7Dh+Eg6OkbMIjUVp+Dzqntk9zx/8qG6I6X0Hf7lHsz8SWbyOaYsLCP9oVWw6
         EWWG1tV656hr1Z9uHbM+sncDJjdeev7vhR/96eFm1PL9EBh2gkHlE/KtSkvDVYfT7bKa
         Fo5A==
X-Gm-Message-State: AOJu0Yxfsc9QVWNzWBBdqtZCWg1lmM/U4NY6DI9KVisk+LMwvQHUvQD1
	GXHk3LjttyY2p6J33EJG6hSYqqiqoQqzMPfREsDzXPbRA2RfWI9Lf8CvuSHs5c6okxTZe/3EEZJ
	n
X-Google-Smtp-Source: AGHT+IF/C4jeUbm+3W/PJFI+aJzqIbgRhJPCCqlL4SRyCo1K24ovSURm6w3NvZCpxOUq6j6UmFtr6w==
X-Received: by 2002:adf:fdd1:0:b0:34c:8ae2:570d with SMTP id i17-20020adffdd1000000b0034c8ae2570dmr5718797wrs.54.1714958127602;
        Sun, 05 May 2024 18:15:27 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:27 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 00/24] Introducing OpenVPN Data Channel Offload
Date: Mon,  6 May 2024 03:16:13 +0200
Message-ID: <20240506011637.27272-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

I am finally back with version 3 of the ovpn patchset.
It took a while to address all comments I have received on v2, but I
am happy to say that I addressed 99% of the feedback I collected.

The 1% I did not make yet is using BQL for handling the packets queue.

Although such change looks pretty simple in terms of code, I need to
spend some more time understanding the concept behind and therefore
I decided to postpone this change to the (near) future in order to not
slow down the whole review/merge process.

Major changes from v2 are:
* added YAML documentation for the netlink uAPI
** uapi/linnu/ovpn.h, driners/net/ovpn/netlink-gen.{c,h} are now self
   generated by the tools/net/ynl/ynl-regen.sh script
* the first patch now also modifies the ynl script to account for the
  new MAX_LEN() policy macro
* added more doxygen documentation
* added kselftest unit for ovpn in tools/testing/selftest/ovpn with
  some basic tests
* fixed various typ0s in documentation
* moved includes of local headers last
* wrapped code at 80 chars
* rearranged includes a bit to reduce double inclusions
* set default ifname to ovpn%d and allowed users to not specify any
* now sending reply to NEW_IFACE NL command containing actual new ifname
* used GENL_REQ_ATTR_CHECK() when possible
* turned carrier off in iface create function
* turned carrier on in open function and clearly explain why we keep it
  always on (new patch)
* left ethtool info ->version empty
* removed internal driver version
* checked return value of alloc_netdev
* renamed _lookup() functions to _get()
* removed memset-zero from init function as netdev is already zero'd
* added missing TCP component initialization in ovpn_init
* .. included various small fixes as requested by reviewers

The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks to the new kunitest component, it is now pssible to run
basic ovpn tests. Peers are emulated by using multiple network
namespaces which are interconnected by means of veth pairs.

Please note that patches have been split for easier review, but if
required, I can send a long 1/1 with all courses and dishes in one go :)

Thanks so far!


Below is the original description posted with the first patchest:
===================================================================

`ovpn` is essentialy a device driver that allows creating a virtual
network interface to handle the OpenVPN data channel. Any traffic
entering the interface is encrypted, encapsulated and sent to the
appropriate destination.

`ovpn` requires OpenVPN in userspace
to run along its side in order to be properly configured and maintained
during its life cycle.

The `ovpn` interface can be created/destroyed and then
configured via Netlink API.

Specifically OpenVPN in userspace will:
* create the `ovpn` interface
* establish the connection with one or more peers
* perform TLS handshake and negotiate any protocol parameter
* configure the `ovpn` interface with peer data (ip/port, keys, etc.)
* handle any subsequent control channel communication

I'd like to point out the control channel is fully handles in userspace.
The idea is to keep the `ovpn` kernel module as simple as possible and
let userspace handle all the non-data (non-fast-path) features.

NOTE: some of you may already know `ovpn-dco` the out-of-tree predecessor
of `ovpn`. However, be aware that the two are not API compatible and
therefore OpenVPN 2.6 will not work with this new `ovpn` module.
More adjustments are required.

For more technical details please refer to the actual patches.

Any comment, concern or statement will be appreciated!
Thanks a lot!!

Best Regards,

Antonio Quartulli
OpenVPN Inc.

======================

Antonio Quartulli (24):
  netlink: add NLA_POLICY_MAX_LEN macro
  net: introduce OpenVPN Data Channel Offload (ovpn)
  ovpn: add basic netlink support
  ovpn: add basic interface creation/destruction/management routines
  ovpn: implement interface creation/destruction via netlink
  ovpn: keep carrier always on
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
  ovpn: implement peer add/dump/delete via netlink
  ovpn: implement key add/del/swap via netlink
  ovpn: kill key and notify userspace in case of IV exhaustion
  ovpn: notify userspace when a peer is deleted
  ovpn: add basic ethtool support
  testing/selftest: add test tool and scripts for ovpn module

 Documentation/netlink/specs/ovpn.yaml      |  331 ++++
 MAINTAINERS                                |    8 +
 drivers/net/Kconfig                        |   13 +
 drivers/net/Makefile                       |    1 +
 drivers/net/ovpn/Makefile                  |   22 +
 drivers/net/ovpn/bind.c                    |   61 +
 drivers/net/ovpn/bind.h                    |  130 ++
 drivers/net/ovpn/crypto.c                  |  162 ++
 drivers/net/ovpn/crypto.h                  |  138 ++
 drivers/net/ovpn/crypto_aead.c             |  378 +++++
 drivers/net/ovpn/crypto_aead.h             |   30 +
 drivers/net/ovpn/io.c                      |  566 +++++++
 drivers/net/ovpn/io.h                      |   35 +
 drivers/net/ovpn/main.c                    |  320 ++++
 drivers/net/ovpn/main.h                    |   56 +
 drivers/net/ovpn/netlink-gen.c             |  206 +++
 drivers/net/ovpn/netlink-gen.h             |   41 +
 drivers/net/ovpn/netlink.c                 |  993 ++++++++++++
 drivers/net/ovpn/netlink.h                 |   46 +
 drivers/net/ovpn/ovpnstruct.h              |   48 +
 drivers/net/ovpn/packet.h                  |   40 +
 drivers/net/ovpn/peer.c                    | 1077 +++++++++++++
 drivers/net/ovpn/peer.h                    |  303 ++++
 drivers/net/ovpn/pktid.c                   |  132 ++
 drivers/net/ovpn/pktid.h                   |   85 +
 drivers/net/ovpn/proto.h                   |  115 ++
 drivers/net/ovpn/skb.h                     |   51 +
 drivers/net/ovpn/socket.c                  |  150 ++
 drivers/net/ovpn/socket.h                  |   81 +
 drivers/net/ovpn/stats.c                   |   21 +
 drivers/net/ovpn/stats.h                   |   52 +
 drivers/net/ovpn/tcp.c                     |  511 ++++++
 drivers/net/ovpn/tcp.h                     |   42 +
 drivers/net/ovpn/udp.c                     |  393 +++++
 drivers/net/ovpn/udp.h                     |   47 +
 include/net/netlink.h                      |    1 +
 include/uapi/linux/ovpn.h                  |  109 ++
 include/uapi/linux/udp.h                   |    1 +
 tools/net/ynl/ynl-gen-c.py                 |    2 +
 tools/testing/selftests/Makefile           |    1 +
 tools/testing/selftests/ovpn/Makefile      |   15 +
 tools/testing/selftests/ovpn/config        |    8 +
 tools/testing/selftests/ovpn/data64.key    |    5 +
 tools/testing/selftests/ovpn/float-test.sh |  113 ++
 tools/testing/selftests/ovpn/netns-test.sh |  118 ++
 tools/testing/selftests/ovpn/ovpn-cli.c    | 1640 ++++++++++++++++++++
 tools/testing/selftests/ovpn/run.sh        |   12 +
 tools/testing/selftests/ovpn/tcp_peers.txt |    1 +
 tools/testing/selftests/ovpn/udp_peers.txt |    5 +
 49 files changed, 8716 insertions(+)
 create mode 100644 Documentation/netlink/specs/ovpn.yaml
 create mode 100644 drivers/net/ovpn/Makefile
 create mode 100644 drivers/net/ovpn/bind.c
 create mode 100644 drivers/net/ovpn/bind.h
 create mode 100644 drivers/net/ovpn/crypto.c
 create mode 100644 drivers/net/ovpn/crypto.h
 create mode 100644 drivers/net/ovpn/crypto_aead.c
 create mode 100644 drivers/net/ovpn/crypto_aead.h
 create mode 100644 drivers/net/ovpn/io.c
 create mode 100644 drivers/net/ovpn/io.h
 create mode 100644 drivers/net/ovpn/main.c
 create mode 100644 drivers/net/ovpn/main.h
 create mode 100644 drivers/net/ovpn/netlink-gen.c
 create mode 100644 drivers/net/ovpn/netlink-gen.h
 create mode 100644 drivers/net/ovpn/netlink.c
 create mode 100644 drivers/net/ovpn/netlink.h
 create mode 100644 drivers/net/ovpn/ovpnstruct.h
 create mode 100644 drivers/net/ovpn/packet.h
 create mode 100644 drivers/net/ovpn/peer.c
 create mode 100644 drivers/net/ovpn/peer.h
 create mode 100644 drivers/net/ovpn/pktid.c
 create mode 100644 drivers/net/ovpn/pktid.h
 create mode 100644 drivers/net/ovpn/proto.h
 create mode 100644 drivers/net/ovpn/skb.h
 create mode 100644 drivers/net/ovpn/socket.c
 create mode 100644 drivers/net/ovpn/socket.h
 create mode 100644 drivers/net/ovpn/stats.c
 create mode 100644 drivers/net/ovpn/stats.h
 create mode 100644 drivers/net/ovpn/tcp.c
 create mode 100644 drivers/net/ovpn/tcp.h
 create mode 100644 drivers/net/ovpn/udp.c
 create mode 100644 drivers/net/ovpn/udp.h
 create mode 100644 include/uapi/linux/ovpn.h
 create mode 100644 tools/testing/selftests/ovpn/Makefile
 create mode 100644 tools/testing/selftests/ovpn/config
 create mode 100644 tools/testing/selftests/ovpn/data64.key
 create mode 100644 tools/testing/selftests/ovpn/float-test.sh
 create mode 100644 tools/testing/selftests/ovpn/netns-test.sh
 create mode 100644 tools/testing/selftests/ovpn/ovpn-cli.c
 create mode 100644 tools/testing/selftests/ovpn/run.sh
 create mode 100644 tools/testing/selftests/ovpn/tcp_peers.txt
 create mode 100644 tools/testing/selftests/ovpn/udp_peers.txt

-- 
2.43.2


