Return-Path: <netdev+bounces-62195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCC88261D4
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E98282ABC
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B2F9E8;
	Sat,  6 Jan 2024 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JMx9hfxz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp119.iad3a.emailsrvr.com (smtp119.iad3a.emailsrvr.com [173.203.187.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D5F9EC
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openvpn.net;
	s=20170822-45nk5nwl; t=1704578257;
	bh=0IHNZZjio2QjQ6EGcZwGeqR3/9lobXk2fxLHDghBmuA=;
	h=From:To:Subject:Date:From;
	b=JMx9hfxza2Kfv6vB9lsQyaKnFb7Iwx2xDO5h1V3l5LsvCXX6UrsG57PC73A18BTyC
	 lr1A2Itn605ttjFIj8tbDhXdPMKmYcbZAkMbxl99caorP0gcSCzzWSwgWrRXqW3h3G
	 HEOBLkqwKqDajkaasfYkaZxi1fLsPYLyp3Cq3Orc=
X-Auth-ID: antonio@openvpn.net
Received: by smtp7.relay.iad3a.emailsrvr.com (Authenticated sender: antonio-AT-openvpn.net) with ESMTPSA id AFB0D19F1;
	Sat,  6 Jan 2024 16:57:36 -0500 (EST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 0/1] Introducing OpenVPN Data Channel Offload
Date: Sat,  6 Jan 2024 22:57:39 +0100
Message-ID: <20240106215740.14770-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: c4c609dd-4a9a-42e2-98a3-0f667af6927b-1-1

Hi all!

After several months of work, I am finally
sending a new version of the OpenVPN Data Channel Offload kernel
module (aka `ovpn`) for official review.

The OpenVPN community has since long been interested in moving the fast path
to kernel space. `ovpn` finally helps achieving this goal.

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

For more technical details please refer to the actual patch commit message.

Please note that the patch touches also a few files outside of the
ovpn-dco folder.
Specifically it adds a new macro named NLA_POLICY_MAX_LEN to net/netlink.h
and also adds a new constant named UDP_ENCAP_OVPNINUDP to linux/udp.h.

I tend to agree that a unique large patch is harder to review, but
splitting the code into several paches proved to be quite cumbersome,
therefore I prefered to not do it. I believe the code can still be
reviewed file by file, despite in the same patch.

** KNOWN ISSUE:
Upon module unloading something is not torn down correctly and sometimes
new packets hit dangling netdev pointers. This problem did not exist
when the RTNL API was implemented (before interface handling was moved
to Netlink). I was hoping to get some feedback from the netdev community
on anything that may look wrong.


Any comment, concern or statement will be appreciated!
Thanks a lot!!

Best Regards,

Antonio Quartulli
OpenVPN Inc.

---

Antonio Quartulli (1):
  net: introduce OpenVPN Data Channel Offload (ovpn)

 MAINTAINERS                    |    8 +
 drivers/net/Kconfig            |   13 +
 drivers/net/Makefile           |    1 +
 drivers/net/ovpn/Makefile      |   21 +
 drivers/net/ovpn/addr.h        |   41 ++
 drivers/net/ovpn/bind.c        |   62 ++
 drivers/net/ovpn/bind.h        |   69 ++
 drivers/net/ovpn/crypto.c      |  154 +++++
 drivers/net/ovpn/crypto.h      |  144 +++++
 drivers/net/ovpn/crypto_aead.c |  367 +++++++++++
 drivers/net/ovpn/crypto_aead.h |   27 +
 drivers/net/ovpn/io.c          |  579 +++++++++++++++++
 drivers/net/ovpn/io.h          |   43 ++
 drivers/net/ovpn/main.c        |  307 +++++++++
 drivers/net/ovpn/main.h        |   39 ++
 drivers/net/ovpn/netlink.c     | 1072 ++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h     |   23 +
 drivers/net/ovpn/ovpnstruct.h  |   65 ++
 drivers/net/ovpn/peer.c        |  928 +++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h        |  175 ++++++
 drivers/net/ovpn/pktid.c       |  127 ++++
 drivers/net/ovpn/pktid.h       |  116 ++++
 drivers/net/ovpn/proto.h       |  101 +++
 drivers/net/ovpn/rcu.h         |   20 +
 drivers/net/ovpn/skb.h         |   51 ++
 drivers/net/ovpn/sock.c        |  144 +++++
 drivers/net/ovpn/sock.h        |   59 ++
 drivers/net/ovpn/stats.c       |   20 +
 drivers/net/ovpn/stats.h       |   67 ++
 drivers/net/ovpn/tcp.c         |  473 ++++++++++++++
 drivers/net/ovpn/tcp.h         |   41 ++
 drivers/net/ovpn/udp.c         |  357 +++++++++++
 drivers/net/ovpn/udp.h         |   25 +
 include/uapi/linux/ovpn.h      |  174 ++++++
 include/uapi/linux/udp.h       |    1 +
 35 files changed, 5914 insertions(+)
 create mode 100644 drivers/net/ovpn/Makefile
 create mode 100644 drivers/net/ovpn/addr.h
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
 create mode 100644 drivers/net/ovpn/peer.c
 create mode 100644 drivers/net/ovpn/peer.h
 create mode 100644 drivers/net/ovpn/pktid.c
 create mode 100644 drivers/net/ovpn/pktid.h
 create mode 100644 drivers/net/ovpn/proto.h
 create mode 100644 drivers/net/ovpn/rcu.h
 create mode 100644 drivers/net/ovpn/skb.h
 create mode 100644 drivers/net/ovpn/sock.c
 create mode 100644 drivers/net/ovpn/sock.h
 create mode 100644 drivers/net/ovpn/stats.c
 create mode 100644 drivers/net/ovpn/stats.h
 create mode 100644 drivers/net/ovpn/tcp.c
 create mode 100644 drivers/net/ovpn/tcp.h
 create mode 100644 drivers/net/ovpn/udp.c
 create mode 100644 drivers/net/ovpn/udp.h
 create mode 100644 include/uapi/linux/ovpn.h

-- 
2.41.0


