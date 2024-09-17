Return-Path: <netdev+bounces-128617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BCC97AA14
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3533B21BE6
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467BDAD4B;
	Tue, 17 Sep 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eD975GhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E24683
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535282; cv=none; b=r02bskkqkZlbDFSUDNLtR0cBu5EnbQ4P9/ngRC32zBDoak3QU4znPgSHaAYRBCgY53GROoX4hsYKbeN1K3UoPKK/peFm7yEyS9l2qIMcbL7l1yZNjqTjqGHn9Ezc50t/Z8Dl10201ukBAJRZ8oTrjpyAN8755orIgPhQvMkqX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535282; c=relaxed/simple;
	bh=PDkRZEMZcvmbPwkLCgw1XRLpS0Ti1af1G2Q1RLj+mmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0VCCHmX0GNOUhRoEEy2ePNgTDjjhSNhXQx1XuVyfajojMcV69r9Hu7VtAaSAmO22lkn+k70B3E/J1A55AeHlpQdOhwzvmv3JpOSCowkdtmiPuZgLSe3qf7sQmmRa6Py8NOB0Cu9GEfqkH9JGVp/+oxBpdhKhGFD7q7A9NSWbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eD975GhE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so50279875e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535277; x=1727140077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0nlR+DnXa4IYKKm+oV/za4/SoXqCCZTAbJ8/KMzYLc=;
        b=eD975GhExm0f9MSQS4TbARDXJxcQXh97/SgX+QiLi1RGKTxfHQUlQdtMlOieA4SteD
         KGyy69/BuM+XllPPnovtFPT6w1mFiJssQKFNrXnl4cAXZB0Ioy6mqqzVKdo0J3Zwa8Mx
         RCHmGFOFUZhvdbwp9YuakkfxGiq3WB22BKFYU6ShXfLUccSRPTHWoQctA5z0ADy660tI
         qNrWLM7I8qfyuq7s8WdYJuzHshNRBFnRgsWuZ6pCMhTVA/nKGtwFJRtOlW3NfocEcVja
         fRxkE5NSa2sranB1PEOSZyCYAggDHkFEclczjmjFbkYfNEbaFhinY0vjtnxdhXobrneM
         1ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535277; x=1727140077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0nlR+DnXa4IYKKm+oV/za4/SoXqCCZTAbJ8/KMzYLc=;
        b=gKXFVp9CNDCtc2DVxTielAbxSX5lVlHIdLHD06g8BWDqFR4TJ3/++aSsWcyIJkhbyD
         INCVH23l3P6LQ7cl0g1fBycOIqx++dNi+3N7PU/DWNkVLxI7PzFBG1UVHCeYm5W56+i6
         1Nou/ziOGy1v96WYuECy6pt81nneAjP9kIYYCHMPdV3hcYjqDKEGxlP3lE078DJPrJpo
         wAP+XbRLxPslHsM6W0Ldf4tE3dX0W3I/6euP6fGLIvPBhG3B/kN5vCCA5eI+UXYLcHfL
         yYqpN/BW8KStff+uVGf9vW+e3h0NIlUDjJ+Npd08dEjlZJALEaKNUgn6C0xmNV8SA4lT
         B3nQ==
X-Gm-Message-State: AOJu0Yz/gAK2SezLwpNUSSMh31u6cUNJkdc8xI2RjRyHwBJ48j605qOU
	86lx7v6zy/OmZ57w9X7NVGhtKzVAfXaSpuyOJ+HQmFko+Qw2J+C4pQ0EXVFjTm7u0VZb5mPu87a
	Z
X-Google-Smtp-Source: AGHT+IH9xFFG0Jk7jGgqdjFvOTLMVTfRK2yQS/VUdmzCfOTIbM37cXMsVGy16KK1hmQTdrqRifo91g==
X-Received: by 2002:a05:6000:542:b0:374:c0a3:fbb1 with SMTP id ffacd0b85a97d-378c2d12e01mr9129437f8f.35.1726535277305;
        Mon, 16 Sep 2024 18:07:57 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:07:56 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 00/25] Introducing OpenVPN Data Channel Offload
Date: Tue, 17 Sep 2024 03:07:09 +0200
Message-ID: <20240917010734.1905-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is the 7th version of the ovpn patchset.

Thanks a lot to all those who have dedicated any amount of time to
review, report errors and send suggestions. Code quality (and even
performance!) has increased enormously compared to v1.

Notable changes from v6 are:
* converted NETIF_F_LLTX to dev->lltx
* added STREAM_PARSER to Kconfig
* regenerated netlink policies
* dropped skbs consistently in xmit() and ovpn_send() (drop only
  single skb instead of list)
* stored skb->len before calling ovpn_udp_output()
* stored pkt->len before calling gro_cells_receive()
* added drop_noovpn label in udp_encap_recv()
* removed sk_user_data bogus initialization
* removed call to rcu_barrier() from ovpn_struct_free()
* reworked encrypt/decrypt_post() to properly release CB and clear
  ctx member
* got rid of wrong kfree(sg)
* moved gro_cells_init() right before if (err) in ndo_init()
* added missing gro_cells_destroy() in error path in ndo_init()
* used call_rcu() to release peer and avoid deadlock
* moved hlist_add() after family check and rcu protected access
  in peer_add_mp()
* went back to single lock only for peer hashtables
* skipped keepalive interval computation when tmp_next_run is 0
* switched crypto_state->mutex to spinlock
* converted slots to array[2]
* skipped rehashing upon float in P2P mode
* avoided double free of skb in case of skb_share_check() failure
  (reported by smatch)
* turned ovpn_struct_init() into void as it always returns 0
  (reported by cppcheck)
* turned ovpn_tcp_to_userspace() into void as it always returns 0
  (reported by cppcheck)
* fixed typ0s reported by checkpatch --codespell

Moreover, I have smatch reporting the following:
drivers/net/ovpn/pktid.c:81 ovpn_pktid_recv() warn: potential spectre issue 'pr->history' [w]
drivers/net/ovpn/pktid.c:110 ovpn_pktid_recv() warn: possible spectre second half.  '*p'

I don't think it's code that we should worry about, but I thought it
would make sense to hear your opinion.


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
 drivers/net/Kconfig                           |   15 +
 drivers/net/Makefile                          |    1 +
 drivers/net/ovpn/Makefile                     |   22 +
 drivers/net/ovpn/bind.c                       |   54 +
 drivers/net/ovpn/bind.h                       |  117 ++
 drivers/net/ovpn/crypto.c                     |  172 ++
 drivers/net/ovpn/crypto.h                     |  138 ++
 drivers/net/ovpn/crypto_aead.c                |  356 ++++
 drivers/net/ovpn/crypto_aead.h                |   31 +
 drivers/net/ovpn/io.c                         |  459 +++++
 drivers/net/ovpn/io.h                         |   25 +
 drivers/net/ovpn/main.c                       |  364 ++++
 drivers/net/ovpn/main.h                       |   29 +
 drivers/net/ovpn/netlink-gen.c                |  206 ++
 drivers/net/ovpn/netlink-gen.h                |   41 +
 drivers/net/ovpn/netlink.c                    | 1052 ++++++++++
 drivers/net/ovpn/netlink.h                    |   18 +
 drivers/net/ovpn/ovpnstruct.h                 |   59 +
 drivers/net/ovpn/packet.h                     |   40 +
 drivers/net/ovpn/peer.c                       | 1192 +++++++++++
 drivers/net/ovpn/peer.h                       |  171 ++
 drivers/net/ovpn/pktid.c                      |  130 ++
 drivers/net/ovpn/pktid.h                      |   87 +
 drivers/net/ovpn/proto.h                      |  104 +
 drivers/net/ovpn/skb.h                        |   61 +
 drivers/net/ovpn/socket.c                     |  165 ++
 drivers/net/ovpn/socket.h                     |   53 +
 drivers/net/ovpn/stats.c                      |   21 +
 drivers/net/ovpn/stats.h                      |   47 +
 drivers/net/ovpn/tcp.c                        |  506 +++++
 drivers/net/ovpn/tcp.h                        |   43 +
 drivers/net/ovpn/udp.c                        |  406 ++++
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
 .../testing/selftests/net/ovpn/tcp_peers.txt  |    5 +
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


