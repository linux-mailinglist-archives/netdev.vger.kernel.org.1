Return-Path: <netdev+bounces-122275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5E960993
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C8E1F21A42
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301031A08A6;
	Tue, 27 Aug 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fGEciYM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5A19F466
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760404; cv=none; b=eu5i5N82rAJE2eQSzYf2EjXef3DvRytFJP1gFXh7qyfEecuHNSukBlgWA9929WQJ+K8+ITTTXdXwLzcQn+g/HG91r9QuA8D/jaY0MrZikFZNGh82IK6wAY7NqtlWrJX66gNbSPpIBgEzUsRd7NFMZFjO4DJO4o9AlysIDJA8CrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760404; c=relaxed/simple;
	bh=XgeyYCjKW5zrV/VDKmhpGnFmJfrd3fV8D8/xX4wFUbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RkaVm5IdCGLZRAgmO3Jr7eqWGpNZNCwGVsL0INfs4Btaqr5OzTjHaq9tAMLjZjxSjCkEqYPd9QZCjQsNuGUffSVY0BGVFUphnrpfftPPngUKzmUKebey8FAGKBKobOqhyXjWLt7NoDtS0G6jkZFe/O1+PX+noxQuQ6ug3tXgkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fGEciYM4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso48481935e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760399; x=1725365199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kD6Pa54e7KDEd5r0LLCxk9Ww7C+OI4X8Bu3kpbW7gpU=;
        b=fGEciYM4nJ+kaQKZoyn48IpE55Uy2Tzjv8L0cH/AKP7VZd0n5ouf5OT6ktdBFOEGPv
         9FN7EKsbjp1bL9NmPMNTX0KTWGwlp+s4Sdly+ykuM7qbbUfFA0kt1pGcPzy3R7lOTzSE
         ZZwEutrEmJqlygNUO0aVyhcYBXoCJc4GXnBbtdoIYOWb5cYrDdQSj4yLGxaEDOYuaibk
         aqcT5wHbdH9RsrJAQOEg1zK+H33O+t4GKgWUHwBHgYIaCYjDllGBpeNjOVVckolo6/Ow
         xNJGl64ZIP5mqiw/505RuIR5/UAcMDUMsLxCgzQr/+Es8gKtiQwMfBhLcsYZ7j2Kx1Zu
         jIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760399; x=1725365199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kD6Pa54e7KDEd5r0LLCxk9Ww7C+OI4X8Bu3kpbW7gpU=;
        b=WzDJMqhCrMIKDgs4ni/hmblnNe/IKQJsvg0y4UjzDAy/5Yzufx8DfXnPIb3kjaw9br
         Kjpo08z8GKU+a9Av0wyEGiBNq2RHAQ9WGFeE8uyhuqzs9IqgLAeLp1Uvj1PDqQwXZbe7
         ZREgnJdlOqr/ZKRjkIB/ckpfwR5jXSJ4IhXpYg0YolDz8E1owRrc32T/SHB3SYS7uMBa
         IAa8zPdNh86vdkq9T36JNy+UOsHJace9JJ/KCvp8B3P5/zbhRAC1KFi1a/apvC88H1sZ
         KrhQXf1SOXFNk/+9SzDl9n3i9uB2XgVNFb+Cilbp9ME3qC1kCFxh4ifLAD85z0IQSUcd
         9Ifw==
X-Gm-Message-State: AOJu0YyZ1GIjUMn8lA4+2TNQI6dsC5ZuOkUGETbT7oGXSOkWrujQy3KN
	oB6E7QK/MtWfwpEqzwmalWtT0RGPuIb3SP9SNLZ1cO8owPTCxNpsGCM7nJ4DMj0KZ1pPpYgXi8n
	6
X-Google-Smtp-Source: AGHT+IFt8hqRnSReaP5YuQnuBIuGv6Rc2SF6R5oqEX5Ug1x1GX39ZyO+AP2suwi8B2REsApq1dSi0w==
X-Received: by 2002:a05:600c:524b:b0:427:d8f2:5dee with SMTP id 5b1f17b1804b1-42b9add47fbmr16968885e9.15.1724760399463;
        Tue, 27 Aug 2024 05:06:39 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:39 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 00/25] Introducing OpenVPN Data Channel Offload
Date: Tue, 27 Aug 2024 14:07:40 +0200
Message-ID: <20240827120805.13681-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is the 6th version of the ovpn patchset.

Notable changes from v5 are:
* moved NETIF_F_LLTX only to features
* added missing call to crypto_key_slot_put() in encrypt_done()
* return also IFINDEX upon nl_new_iface_doit() success
* convert struct ovpn_sockaddr to union
* rename ovpn_bind->sa to ovpn_bind->remote
* added netdevice_tracker to netdev_hold/put when possible
* moved ovpn_peer_index() change to related patch
* removed dev_core_stats_rx_dropped_inc after gro_cells_receive()
* moved call to kill_primary_key to related patch
* passed key_id to userspace when killing key
* passed skb to aead_request_set_callback()
* added missing call to crypto_key_slot_put() in decrypt_post()
* got rid of ptr_ring.h
* removed extra/unneded memset() on cb in TCP code
* made sure to call notify_swap_key
* called notify_del_peer before releasing netdev ref
* converted checks in nl_set_peer_doit to hard requirements
* removed useless keepalive_set boolean variable
* moved kzalloc for ovpn->peers to ndo_init() cb
* added size check in ovpn_is_keepalive()
* drop ovpn_keepalive_xmit() wrapper
* use new helper __skb_put_data()
* hold peer->lock in ovpn_peer_float()
* use ipv6_addr_equal()
* hold peer->lock in update_local_endpoint()
* use hlist_nulls for by_transp_addr due to float rehashing
* switched to CHECKSUM_NONE in RX path
* bailed out when cannot retain peer ref in encrypt_one()
* hold peer ref in ovpn_tcp_sendmsg()
* bail out in case of missing peer ref in ovpn_tcp_rcv()
* moved cancel_work_sync() and strp_done() out of rcu read lock area
* enable extended ack in userspace testing tool
* introduced one lock per hashtable, to avoid conflicting lock
  operations
* added some extra doc regarding IV and key life cycle
* some more minor reshuffling, mostly as consequence of the above..


Please note that patches previously reviewed by Andrew Lunn have
retained the Reviewed-by tag as they have been simply rebased without
any modification.


The latest code can also be found at:

https://github.com/OpenVPN/linux-kernel-ovpn

Thanks a lot!
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

 Documentation/netlink/specs/ovpn.yaml         |  328 +++
 MAINTAINERS                                   |    8 +
 drivers/net/Kconfig                           |   14 +
 drivers/net/Makefile                          |    1 +
 drivers/net/ovpn/Makefile                     |   22 +
 drivers/net/ovpn/bind.c                       |   54 +
 drivers/net/ovpn/bind.h                       |  117 ++
 drivers/net/ovpn/crypto.c                     |  168 ++
 drivers/net/ovpn/crypto.h                     |  138 ++
 drivers/net/ovpn/crypto_aead.c                |  376 ++++
 drivers/net/ovpn/crypto_aead.h                |   31 +
 drivers/net/ovpn/io.c                         |  439 ++++
 drivers/net/ovpn/io.h                         |   25 +
 drivers/net/ovpn/main.c                       |  371 ++++
 drivers/net/ovpn/main.h                       |   29 +
 drivers/net/ovpn/netlink-gen.c                |  206 ++
 drivers/net/ovpn/netlink-gen.h                |   41 +
 drivers/net/ovpn/netlink.c                    | 1052 ++++++++++
 drivers/net/ovpn/netlink.h                    |   18 +
 drivers/net/ovpn/ovpnstruct.h                 |   63 +
 drivers/net/ovpn/packet.h                     |   40 +
 drivers/net/ovpn/peer.c                       | 1187 +++++++++++
 drivers/net/ovpn/peer.h                       |  171 ++
 drivers/net/ovpn/pktid.c                      |  130 ++
 drivers/net/ovpn/pktid.h                      |   87 +
 drivers/net/ovpn/proto.h                      |  104 +
 drivers/net/ovpn/skb.h                        |   61 +
 drivers/net/ovpn/socket.c                     |  165 ++
 drivers/net/ovpn/socket.h                     |   53 +
 drivers/net/ovpn/stats.c                      |   21 +
 drivers/net/ovpn/stats.h                      |   47 +
 drivers/net/ovpn/tcp.c                        |  512 +++++
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
 tools/testing/selftests/net/ovpn/data-test.sh |  150 ++
 tools/testing/selftests/net/ovpn/data64.key   |    5 +
 .../testing/selftests/net/ovpn/float-test.sh  |  115 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 1820 +++++++++++++++++
 .../testing/selftests/net/ovpn/tcp_peers.txt  |    1 +
 .../testing/selftests/net/ovpn/udp_peers.txt  |    5 +
 51 files changed, 8802 insertions(+), 2 deletions(-)
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


