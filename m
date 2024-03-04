Return-Path: <netdev+bounces-77127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08DD8704D9
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4D1F2294C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A74653A;
	Mon,  4 Mar 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FOqVQj0O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924E45945
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564940; cv=none; b=R3zNeh47Tk8C1NadzQJ5pczI5RQ6Awe8ooRh5dt7wn9doZsB+/f9Fo3/8UmXyvA3a0Yn/Ru0EJVL5sWHijfsiERqJ6UDapRyfKSEbnk39MIOHy7/33csCfeT5VCALfp1/ru8OmALqIy8hah18/dx5Gif1ksj8+bVuBRQ/3D29zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564940; c=relaxed/simple;
	bh=x+mFjpFi0cUqG6+fWlfLnY50ULlhpbw1PzA4Ra9z5uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OhVd+spmigSViOEWawZoOn4gjJM66VhksjJJP7qzp234sE+A8jnFisPgvssmB0o0UU89mZ301IS+j4jvBCpgvwISFolgNdEcQdbPyN0SRfNW7PLFq0qIPZMkkanzdnUfyYWL8ztT6j/AoO2xJfu5q58dPA3n4hqSaDXZryQ49es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FOqVQj0O; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so6440023a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564936; x=1710169736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6RqSXnI4cB37QYRjxj7s0/pY38Fyzq1sBfIFh2PYkY=;
        b=FOqVQj0O3SlW/zwaSBCPrI1/B3D1V8pNVEvi355KzxCSRDfZcZenPYTXeyULXLAmYL
         a3Rwyzv6Fv3RT8TVwLwk0YoqfyF8d9AqAl8XXZZnJH7mqov83km6JmGn6wmfERyFUaQc
         ufYQwsIBcFVQ4bmMfWmhjmQkwWn7N9Z4zkSoHaX+vICIPcm/2n/wl0cHtOhKI27Ix+sl
         gU5bU9qUtwIy0BDyl6c8SOdtFih0CD+j5kJG6GOkZtF8Rr6Ov31F7Ds5hsAV5868Kbfj
         qbzwbmW+nN+Fj5+w3SI2yjEfEm1gOG0JpHL+75hFN4goYYXjGYLaevO3vCe4rO9TarOu
         jWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564936; x=1710169736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6RqSXnI4cB37QYRjxj7s0/pY38Fyzq1sBfIFh2PYkY=;
        b=KlkHYq3WgxYBC4dePyd+JRp44PzkwtBJ08fpbiQuVv5hy+VcUy6tVHkiP3EN88yRoK
         5rDKgnW6/TGHpUq3gOxdgJ+LuojrthOqveAxwjV9wdKZix1LhN4lasyGrL4gYF7h7NXX
         hTwldfEi5zm9ZqE/qfT7E8m8HPIwbsLxF0Yj57AHioLClsBPRBqiUw6y+AbgPpbftwbC
         TSvkflCnmEJb4ZszJ0FJg7nGxFaex+y+sWgieMmfPfe5IP6zj0m1JLcDkC4wExEdDZMa
         dmhjGJTD0TBqYDUIYRsy+Xdrq++yqth0pfzhYVv8W9XgvnzDmt++nx+5X3Z7vgd6/Xr8
         Mn0g==
X-Gm-Message-State: AOJu0YzhczCh/FHl0T11ozAbFEGEGKpAL9hSm1iawFnhnVDaUvPb48Eh
	IDprRoCjbhFElcdkS49z2cQxEryc84y9NmpYeYZ0AzV7u5wrg+BNTqMUF/nU5SxdbqICAsiRUTh
	nCRc=
X-Google-Smtp-Source: AGHT+IGbEI7Hzg8/DOEm79qEdHgyZrjhDwwbj2vTWyXnu1/cbRH1+UpTG2hK0WNH9rijnS76K4Gw5g==
X-Received: by 2002:a17:906:649:b0:a45:8b6d:9c92 with SMTP id t9-20020a170906064900b00a458b6d9c92mr329222ejb.31.1709564935995;
        Mon, 04 Mar 2024 07:08:55 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:08:55 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 00/22] Introducing OpenVPN Data Channel Offload
Date: Mon,  4 Mar 2024 16:08:51 +0100
Message-ID: <20240304150914.11444-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

After the comments received last month, I reworked the large patch that
I have previously sent and I came up with this patchset hoping to make
the review process more human and less cumbersome.

Some features are stricly intertwined with each other, therefore I
couldn't split everything up to the very last grain of salt, but I did
my best to create a reasonable set of features that add up on top of
each other.

I don't expect the kernel module to work between intermediate
patches, therefore it is important that all patches are applied if you
want to see something meaningful happening.


The following is just the introductory text from v1. It's a useful
summary of what this new kernel module represents.

As an intereting note, an earlier version of this kernel module is already
being used by quite some OpenVPN users out there claiming important
improvements in terms of performance. By merging the ovpn kernel module
upstream we were hoping to extend cooperation beyond the mere OpenVPN
community.

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

If you want to test the `ovpn` kernel module, for the time being you can
use the testing tool `ovpn-cli` available here:
https://github.com/OpenVPN/ovpn-dco/tree/master/tests

The `ovpn` code can also be built as out-of-tree module and its code is
available here https://github.com/OpenVPN/ovpn-dco (currently in the dev
branch).

For more technical details please refer to the actual patches.

Any comment, concern or statement will be appreciated!
Thanks a lot!!

Best Regards,

Antonio Quartulli
OpenVPN Inc.

======================

Antonio Quartulli (22):
  netlink: add NLA_POLICY_MAX_LEN macro
  net: introduce OpenVPN Data Channel Offload (ovpn)
  ovpn: add basic netlink support
  ovpn: add basic interface creation/destruction/management routines
  ovpn: implement interface creation/destruction via netlink
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

 MAINTAINERS                    |    8 +
 drivers/net/Kconfig            |   13 +
 drivers/net/Makefile           |    1 +
 drivers/net/ovpn/Makefile      |   21 +
 drivers/net/ovpn/bind.c        |   60 ++
 drivers/net/ovpn/bind.h        |   91 +++
 drivers/net/ovpn/crypto.c      |  154 +++++
 drivers/net/ovpn/crypto.h      |  144 +++++
 drivers/net/ovpn/crypto_aead.c |  366 +++++++++++
 drivers/net/ovpn/crypto_aead.h |   27 +
 drivers/net/ovpn/io.c          |  533 ++++++++++++++++
 drivers/net/ovpn/io.h          |   29 +
 drivers/net/ovpn/main.c        |  280 +++++++++
 drivers/net/ovpn/main.h        |   38 ++
 drivers/net/ovpn/netlink.c     | 1045 ++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h     |   22 +
 drivers/net/ovpn/ovpnstruct.h  |   58 ++
 drivers/net/ovpn/packet.h      |   44 ++
 drivers/net/ovpn/peer.c        |  929 ++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h        |  176 ++++++
 drivers/net/ovpn/pktid.c       |  126 ++++
 drivers/net/ovpn/pktid.h       |   90 +++
 drivers/net/ovpn/proto.h       |  101 +++
 drivers/net/ovpn/skb.h         |   51 ++
 drivers/net/ovpn/socket.c      |  140 +++++
 drivers/net/ovpn/socket.h      |   57 ++
 drivers/net/ovpn/stats.c       |   21 +
 drivers/net/ovpn/stats.h       |   51 ++
 drivers/net/ovpn/tcp.c         |  474 +++++++++++++++
 drivers/net/ovpn/tcp.h         |   41 ++
 drivers/net/ovpn/udp.c         |  355 +++++++++++
 drivers/net/ovpn/udp.h         |   23 +
 include/net/netlink.h          |    1 +
 include/uapi/linux/ovpn.h      |  174 ++++++
 include/uapi/linux/udp.h       |    1 +
 35 files changed, 5745 insertions(+)
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

-- 
2.43.0


