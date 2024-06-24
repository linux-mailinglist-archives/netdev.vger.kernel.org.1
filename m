Return-Path: <netdev+bounces-106070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A79148A8
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C916B1C21F34
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7470113A260;
	Mon, 24 Jun 2024 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IvgOZONE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2C139590
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228586; cv=none; b=Deeqfrb/4nPPE8bOxyA/6fg1fdb0HtHzpsJ03JNVDxl0as+vxa7m82rwaUEOSWQXNw7ES99xmddf7qWfH6WHJZsYtlttOJLpnn6732vbPyjDdoFmYUuYRAeY84WVZk53OAHu+nUIjsgNVO0iG6EWl9KqgEULtFub36KihVY2rlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228586; c=relaxed/simple;
	bh=LetSNm8NN2Hc8vVb+bsIM4VEWUfbZuTVN7dppRc58pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDlg7NvjxPffvF30bNaSJirFqjQlF+Mneb3NRGH+qkWYMQ0F8fQ65rCty7VcRtM/ETreUTBzhIJbH8vX8I3Eu09oJeWMbrAYDkTbo8KJ/RmUu/X1e8it+8/QJZjBz4Bg8cc3eBbAzLPiiRGvE9s5V9D0pnPi7BfJszN1EUzVhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IvgOZONE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f090093d8so2899580f8f.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228582; x=1719833382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvpHlCvfTtP+o5SKplusffaJJpuCOGI5NKyr0yDnPNY=;
        b=IvgOZONEY5LTpq8ZqpHaV7CjEEaPmnsGeZsHceRzD3+EmusnSwO6l3ogiSNvkXlBGa
         z+Sl1sbar6mZKVOAzyuuQaXr+O5pDj/BbcmNFDrhDnFmpKJlUgCfoeQyO49ipKgmbPce
         gBzgUdCq2OK8r3LkueKwcUTo28yWxU+y+tOVHylT8hy4TjzfV62/bJ3b/wPu+PvY8tQR
         xKKASiWj5VD4JFESiqQnUpalgmXwAMw+JO3x5NpCPYeNFKKSVWwLrMbExZpRi4ZA6pEP
         w7pWUGhPA6WbUr+Kr1ylZO9DMa8KwtVIwp5XDRWtwj/G/XxSXbGjpAWNDJrKmaI1Jp7n
         AL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228582; x=1719833382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvpHlCvfTtP+o5SKplusffaJJpuCOGI5NKyr0yDnPNY=;
        b=BhzbQsATev7F4upa6jQJXUoaH3Svt8rZXXWX2AF4K2dvtv4pjWYkB4vQo3YgqapcKG
         CUx4c0xX2jsTOS37qsDWCc0ZVx2VDrJ5VqYIRsAJpQxkVudQBFuuYaBQ6bGWQX9Auxpm
         jw92t6yGLgXG0uOQyBto6lYByR2I5hnU+H5XN0iVPHO6E1ltxKUlX2Ivqg5tq9W3q/Ye
         1xcuDhJuB7SJyDQgst6aWiaxDffd4sViLyNANu0+u/N0RcLerG7kbwQm7EdDuw8licio
         8cxiu28mq/y4B4GmL+zLZ7EIo7y7J8OgKhWT4NNDt+cWSr9Btp88Bt0VDLjmG7mLsmOd
         rgoQ==
X-Gm-Message-State: AOJu0Yxde/7uyU7hRyQj2Z2saVdjM/lN17wJlIUjikR+SrWlPfhUIAiY
	UfnderhH292iOs5lOI2nzMLZ+lWyEXjc+j8OEQLhwjgDH7SWZh/YM7U1fai/ZehJvMy/4TxJ/Cz
	Z
X-Google-Smtp-Source: AGHT+IFPr3NWuJH5tMGmEnTvu0zprk5mtTh19W8no6lcwpL7lVkh3usgYkB1kD9oEC+1MNfN10YAfg==
X-Received: by 2002:a5d:484a:0:b0:363:c25:ddc9 with SMTP id ffacd0b85a97d-366e7a639dbmr3413158f8f.65.1719228581531;
        Mon, 24 Jun 2024 04:29:41 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:41 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 00/25] Introducing OpenVPN Data Channel Offload
Date: Mon, 24 Jun 2024 13:30:57 +0200
Message-ID: <20240624113122.12732-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

here I am with v4 of the ovpn patchset!
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

 Documentation/netlink/specs/ovpn.yaml      |  327 ++++
 MAINTAINERS                                |    8 +
 drivers/net/Kconfig                        |   14 +
 drivers/net/Makefile                       |    1 +
 drivers/net/ovpn/Makefile                  |   22 +
 drivers/net/ovpn/bind.c                    |   58 +
 drivers/net/ovpn/bind.h                    |  119 ++
 drivers/net/ovpn/crypto.c                  |  161 ++
 drivers/net/ovpn/crypto.h                  |  138 ++
 drivers/net/ovpn/crypto_aead.c             |  347 ++++
 drivers/net/ovpn/crypto_aead.h             |   30 +
 drivers/net/ovpn/io.c                      |  438 +++++
 drivers/net/ovpn/io.h                      |   21 +
 drivers/net/ovpn/main.c                    |  360 ++++
 drivers/net/ovpn/main.h                    |   29 +
 drivers/net/ovpn/netlink-gen.c             |  206 +++
 drivers/net/ovpn/netlink-gen.h             |   41 +
 drivers/net/ovpn/netlink.c                 |  958 +++++++++++
 drivers/net/ovpn/netlink.h                 |   31 +
 drivers/net/ovpn/ovpnstruct.h              |   52 +
 drivers/net/ovpn/packet.h                  |   40 +
 drivers/net/ovpn/peer.c                    | 1047 ++++++++++++
 drivers/net/ovpn/peer.h                    |  202 +++
 drivers/net/ovpn/pktid.c                   |  130 ++
 drivers/net/ovpn/pktid.h                   |   87 +
 drivers/net/ovpn/proto.h                   |  106 ++
 drivers/net/ovpn/skb.h                     |   56 +
 drivers/net/ovpn/socket.c                  |  165 ++
 drivers/net/ovpn/socket.h                  |   54 +
 drivers/net/ovpn/stats.c                   |   21 +
 drivers/net/ovpn/stats.h                   |   47 +
 drivers/net/ovpn/tcp.c                     |  502 ++++++
 drivers/net/ovpn/tcp.h                     |   42 +
 drivers/net/ovpn/udp.c                     |  404 +++++
 drivers/net/ovpn/udp.h                     |   26 +
 include/net/netlink.h                      |    1 +
 include/uapi/linux/ovpn.h                  |  108 ++
 include/uapi/linux/udp.h                   |    1 +
 net/core/rtnetlink.c                       |    8 +-
 tools/net/ynl/ynl-gen-c.py                 |    2 +
 tools/testing/selftests/Makefile           |    1 +
 tools/testing/selftests/ovpn/Makefile      |   15 +
 tools/testing/selftests/ovpn/config        |    8 +
 tools/testing/selftests/ovpn/data64.key    |    5 +
 tools/testing/selftests/ovpn/float-test.sh |  113 ++
 tools/testing/selftests/ovpn/netns-test.sh |  132 ++
 tools/testing/selftests/ovpn/ovpn-cli.c    | 1743 ++++++++++++++++++++
 tools/testing/selftests/ovpn/run.sh        |   11 +
 tools/testing/selftests/ovpn/tcp_peers.txt |    1 +
 tools/testing/selftests/ovpn/udp_peers.txt |    5 +
 50 files changed, 8442 insertions(+), 2 deletions(-)
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
 create mode 100755 tools/testing/selftests/ovpn/float-test.sh
 create mode 100755 tools/testing/selftests/ovpn/netns-test.sh
 create mode 100644 tools/testing/selftests/ovpn/ovpn-cli.c
 create mode 100755 tools/testing/selftests/ovpn/run.sh
 create mode 100644 tools/testing/selftests/ovpn/tcp_peers.txt
 create mode 100644 tools/testing/selftests/ovpn/udp_peers.txt

-- 
2.44.2


