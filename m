Return-Path: <netdev+bounces-107260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62C91A74A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4490282821
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9B4186E59;
	Thu, 27 Jun 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="g5+NxMYo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734A14D443
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493669; cv=none; b=Mlnu2jDIuhB0283zZkmHp2R7qytZhhmDMA81cXiYdi3bmYqcHO0ynApVfrctF8gcXPAhkLUZlQ/++Yc6QJlRlxefip7qp8Z5puRmzBNhVH7NQ9cc2sOOQDxsUFpKzXerzjsLfRW4jwJWox1dsOFLg6Ws3+HFvYBT8OpEzvkwyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493669; c=relaxed/simple;
	bh=AQXvCiqC9hJr3daDIe922hi7ArbhFglocTCeGdsh7LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsPihv/WLF/6YxokJr37Myjl1z6ADMqx2kuTE8bZsCR2yv5+A2RctdqY4idKupEbneO+lSvZT2Rz4G+hxUgcXczkviCzy/Hp6MdJH4GYNZxh0EilOtfVB2pA+jj+FIWcGrtadXIxIH+UPX2kEKBzPUN1qbXCmz8y8MIPP71StLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=g5+NxMYo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso11574545e9.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493664; x=1720098464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKit1RG0eEHPPURrPnEnVSJFKFkJOJ571XfM+ysEx/I=;
        b=g5+NxMYouF+XVnq/3iNNpWRH5gdErOlZwnYqkMfFp8e9mHd91I7jBXu4hYPyND+W3D
         0+z6ezjAhoYfZZFfoPmBa2JhI5WJixEfEMZF2VSPFx7263yYwmYBr9L/AaVs4dPjr3KR
         0CSHcENx5UVXqVb7YKuaQVbI5jUoGbhhuAx2UtlRI6ZSiegJjwlwuvzMzlDTcJm5ffJA
         1immEQ0c6xFEpwg4WdainQ0K5LumED7UubzDAW2RtQj1L1RKDIQNESLokD3qFp+Yr61K
         SjboATMxXN0cKswv4jPOzvarWbvYp+Un6Crw5WyniVArBXIhxf9bKPBS08Q6vETyPSKL
         nDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493664; x=1720098464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKit1RG0eEHPPURrPnEnVSJFKFkJOJ571XfM+ysEx/I=;
        b=jBR/afaBvJZOzKMCrt8xfSgRau1bBQqvkfG6FxtPIOZN6uCw56jpBesUfGMwmDEJwM
         r4NqUec62jtMfmMWcKYA/LzmNX+6wyP0eSKbOTIRTDLxY9dAYYU5KHKJLFylKYVDH6U3
         GeZoSRr0DFVECB+iUWFxLvinKkdX3QmNtAGeHbTmQLMwluibSLkql21w6Fq9R3cPbD6z
         B/2xpNcqlS9jt2QQ8Tky2U7LvuAneSNCd8KzIIMxxxOIdNAHCB6glmmMuJ1D3cZpq9xh
         l5e4dl/ecXOR4hOLnimGrY32ITY1ACe9TeLmH7EGeOvliMfeXkyftb6u7Mk2EKC7NzbX
         yprg==
X-Gm-Message-State: AOJu0YzHw/lhd2gpYMwJklc6WPb90wOT3/1y4oTfAvP4fSeRK/KiqbVR
	03P4b3p1cmvLAkyNTBVpB9GONS/tO2ePTOT1j+WYOztanBDFszT7imSG3h4h1xO4JTFY1wsUPBL
	J
X-Google-Smtp-Source: AGHT+IHakfAnMH293X2XzpHgazrz8eZ6RyNaafOdC0wGdKVK3Xag7qAr/fFclY1wKNBKF+RqnPR43A==
X-Received: by 2002:a05:600c:3592:b0:424:798a:f7ee with SMTP id 5b1f17b1804b1-4248cc18166mr99112315e9.7.1719493664213;
        Thu, 27 Jun 2024 06:07:44 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:07:43 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 00/25] Introducing OpenVPN Data Channel Offload
Date: Thu, 27 Jun 2024 15:08:18 +0200
Message-ID: <20240627130843.21042-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

here I am with v5 of the ovpn patchset.

The only differences from v4 are:
* moved the ovpn kselftest to the net/ subfolder
* renamed kselftest scripts to something more reasonable
* removed kselftest wrapper script run.sh, now each test runs
  individually
* made checkpatch happy regarding the ovpn-cli.c kselftest tool
* CCed more maintainers to a few individual patches, as requested by
  checkpatch
* fixed one remaining kdoc warning in patch 4
* properly updated MAINTAINERS file in patch 4
* fixed clang build warning in patch 22

(The only remaining failure on patchwork is about series being larger
than 15 patches)

Nothing else has been touched.

For covenience, here is the summary I sent for v4:

Thanks to Sabrina's feedback, several parts of the code are now
simpler than before.

There is an extra kernel patch, compared to v3, that is 02/25.
This patch is required to properly handle virtual devices not
implementing a dellink upon invocation of rtnl_unregister_ops().


Here is an overview of the changesfrom v3, sorted more or less by
importance (very minor changes haven't been mentioned):

* got rid of the TX/RX queues entirely
* got rid of the workqueues entirely
** the only sporadic scheduled event, TCP TX retry, is scheduled on the
   global kernel queue
* use strparser for receiving TCP data
* use gro_cells and get rid of any napi and netif_rx_ring related code
* crypto code now follows the classic async paradigma
* removed synchronize_net()
* avoided unregister_netdevice() double call
* added empty rtnl_link_ops to ensure ifaces are destroyed upon ns exit
* convert pkt counters to 64 bit
* counted dropped packets (in core stats)
* simplified peer lookup routines (no need to hold ref every time)
* simplified TCP recvmsg implementation
* peer collection for MultiPeer mode is now allocated dynamically
* use GFP_ATOMIC for sending nl notifications out of process context
* documented how EALREADY and EBUSY are used in UDP socket attach
* used GENL_REQ_ATTR_CHECK in ovpn_get_dev_from_attrs/pre_doit
* used NL_SET_BAD_ATTR/GENL_SET_ERR_MSG in ovpn_get_dev_from_attrs/pre_doit
* used NL_SET_ERR_MSG_MOD for reporting back error strings
* dropped netlink 'pad' attribute
* used genlmsg_iput
* set pcpu_stat_type to let core handle stats internally
* used nla_put_string/in_addr/in6_addr when possibly
* used ipv6 helpers when possible (ipv6_addr_equal/any)
* added various calls to DEBUG_NET_WARN_ON_ONCE/WARN_ON
* removed unworthy error message in case of netlink message size errors
* used -EOPNOTSUPP instead of -ENOTSUPP
* userspace testing tool improved
* various code rearrangments based on provded feedback ..


The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn


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

Antonio Quartulli (25):
  netlink: add NLA_POLICY_MAX_LEN macro
  rtnetlink: don't crash on unregister if no dellink exists
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

 Documentation/netlink/specs/ovpn.yaml         |  327 +++
 MAINTAINERS                                   |    8 +
 drivers/net/Kconfig                           |   14 +
 drivers/net/Makefile                          |    1 +
 drivers/net/ovpn/Makefile                     |   22 +
 drivers/net/ovpn/bind.c                       |   58 +
 drivers/net/ovpn/bind.h                       |  119 ++
 drivers/net/ovpn/crypto.c                     |  161 ++
 drivers/net/ovpn/crypto.h                     |  138 ++
 drivers/net/ovpn/crypto_aead.c                |  347 ++++
 drivers/net/ovpn/crypto_aead.h                |   30 +
 drivers/net/ovpn/io.c                         |  438 ++++
 drivers/net/ovpn/io.h                         |   21 +
 drivers/net/ovpn/main.c                       |  360 ++++
 drivers/net/ovpn/main.h                       |   29 +
 drivers/net/ovpn/netlink-gen.c                |  206 ++
 drivers/net/ovpn/netlink-gen.h                |   41 +
 drivers/net/ovpn/netlink.c                    |  960 +++++++++
 drivers/net/ovpn/netlink.h                    |   31 +
 drivers/net/ovpn/ovpnstruct.h                 |   52 +
 drivers/net/ovpn/packet.h                     |   40 +
 drivers/net/ovpn/peer.c                       | 1047 ++++++++++
 drivers/net/ovpn/peer.h                       |  202 ++
 drivers/net/ovpn/pktid.c                      |  130 ++
 drivers/net/ovpn/pktid.h                      |   87 +
 drivers/net/ovpn/proto.h                      |  106 +
 drivers/net/ovpn/skb.h                        |   56 +
 drivers/net/ovpn/socket.c                     |  165 ++
 drivers/net/ovpn/socket.h                     |   54 +
 drivers/net/ovpn/stats.c                      |   21 +
 drivers/net/ovpn/stats.h                      |   47 +
 drivers/net/ovpn/tcp.c                        |  502 +++++
 drivers/net/ovpn/tcp.h                        |   42 +
 drivers/net/ovpn/udp.c                        |  404 ++++
 drivers/net/ovpn/udp.h                        |   26 +
 include/net/netlink.h                         |    1 +
 include/uapi/linux/ovpn.h                     |  108 +
 include/uapi/linux/udp.h                      |    1 +
 net/core/rtnetlink.c                          |    8 +-
 tools/net/ynl/ynl-gen-c.py                    |    2 +
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/net/ovpn/.gitignore   |    2 +
 tools/testing/selftests/net/ovpn/Makefile     |   17 +
 tools/testing/selftests/net/ovpn/config       |    8 +
 .../selftests/net/ovpn/data-test-tcp.sh       |    9 +
 tools/testing/selftests/net/ovpn/data-test.sh |  130 ++
 tools/testing/selftests/net/ovpn/data64.key   |    5 +
 .../testing/selftests/net/ovpn/float-test.sh  |  115 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 1787 +++++++++++++++++
 .../testing/selftests/net/ovpn/tcp_peers.txt  |    1 +
 .../testing/selftests/net/ovpn/udp_peers.txt  |    5 +
 51 files changed, 8490 insertions(+), 2 deletions(-)
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
 create mode 100644 tools/testing/selftests/net/ovpn/.gitignore
 create mode 100644 tools/testing/selftests/net/ovpn/Makefile
 create mode 100644 tools/testing/selftests/net/ovpn/config
 create mode 100755 tools/testing/selftests/net/ovpn/data-test-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/data-test.sh
 create mode 100644 tools/testing/selftests/net/ovpn/data64.key
 create mode 100755 tools/testing/selftests/net/ovpn/float-test.sh
 create mode 100644 tools/testing/selftests/net/ovpn/ovpn-cli.c
 create mode 100644 tools/testing/selftests/net/ovpn/tcp_peers.txt
 create mode 100644 tools/testing/selftests/net/ovpn/udp_peers.txt

-- 
2.44.2


