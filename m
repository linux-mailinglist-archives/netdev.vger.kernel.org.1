Return-Path: <netdev+bounces-203445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39BAF5F9A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991BB4E5E36
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D62FC3A3;
	Wed,  2 Jul 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNMpZ+43"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5C2D3745
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476410; cv=none; b=hkXOqC/fbRJRPq8uYWI8ffOCULtVH16FCgOIHP0AwJZ7Fh9Mn0ZgwxrHn+FPfLploV8glAEV95DbGAmiYfPBwmlen7p3DQXGpEAsCl/bDVszKOP4TLHiMQdDfYQ94n/QT0Ef0st+DlNDm7NZCSqwL3COS+O9S5m8LIxZ7vgJo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476410; c=relaxed/simple;
	bh=yaPHlY0l7DeVzYjaDq7zUizIy6Iv3Bt5wIgIO/WiJfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lqpx8XBhlScmNR0POaKm65v7exgDgj5vjGOl8RY5u0rFi2jEf+kDvUUSqsowHyDeZl3CsWBvCyL+9AibHKQyMAQhq4fPKf3beBLNWOD8bpL1cKGH4vKHRK0go16pMKwKA6290fbBIVYsaSevy58LXVpY22ahv45ueJhfZTY2CoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNMpZ+43; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70f862dbeaeso49872177b3.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476408; x=1752081208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd2mdoUjahYV05QDocw/W4LDeyBYOBoLYWChQUhxTDc=;
        b=nNMpZ+43D2+SPWF1Cxu3wkeI8oQ+qqUfnDVHh0b7BICVp8SYSykiOqvd/x92qIxSdQ
         N32mwHiWWF3Alfq784lr2ibgrZoV7rnTV4N8PWjT5fOVhS7FeYeVCbRCGfTB0ks5Tru5
         oYGhdr30npPJPkLiKJlrZvGwhQK+siLzFTgO7CnNK5QLUebJEwcNbIvoKQFkTX+dXu8a
         38G2/mlPDnMGFWBOq4jaOn4eecL7/poo13/Qcm6tNsedKs59UPGKslDSZkOc/2wzK2/z
         oETB4bsO84wgbzl76GA1gcsiZotd3+HsYvTFBEpMQCGTiQRS74iCQhxMzKQoaXRDZbtP
         u0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476408; x=1752081208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rd2mdoUjahYV05QDocw/W4LDeyBYOBoLYWChQUhxTDc=;
        b=cnfMnhDzn2jYFBxStT9fEwacqHhljKw0tLYfOfrubaBDNi2WdA7kcGsgp5w0f/YDRo
         gjL/WjkEnH3NXo/PzKzXVv0YtPleCky38f0vrFKvl0PJPui2E92u1WuGcdNladpdcJ0U
         JE0t/nqiD3wrOwrdw+Sn+xs4LszGbEYwitxK1Keh4UODZwLlxetOsvHDLA+qMdz8fpCt
         Bb/EMa3XpwfbKvI72H/2VaLpbe8abvmuD96YbaCDkzBU8cWJq0YiXXRK3Di9G7b1JgxW
         eYRBfKEiFJAfpplJlFx0Y6WSUnX0g4Fz0bThxJTOxwrr7jpN2o9cKdT8HtVdU4k4lUwR
         mqVw==
X-Forwarded-Encrypted: i=1; AJvYcCVY4swu3PDCQR0Qa0LpXSV1Sf9Ye1JlZKehL6Nk95ase59NsQ5a/vJzMHNlxmeRORfUWwGRXKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWRehxtExYb62ydSUQgEtO9B64sM3P+1cJrSSZ4CfY2OI6dQ8
	8xTWsX75thoQ+8DLqYDRu2h12qWZZ3IEgTeS2hadiwxbRWWHmF+qkleT
X-Gm-Gg: ASbGncsU7JQ9iRR61FgnSRnNviXwIgsbBoC3JAvEDS4xus6WaA66cG5RT0z/YqXuKsJ
	9to0eNygsG73jlxBUstaHdeJKn8dmTuITcj03MhTA9rCgblejzFnxOzz+bf3udxu+uWbewik2Fy
	1ItsgadAEsHAvjN/rxhOafNRoZ8TI9W2cVLYLLkqhAyLbXhm2Y46P9cI2TXOvbhzOYKRqcV4C18
	8dYkbUvuYI9bPJTE4st/vE6UFrHfdVA4Ov07XsGoaIvpt9FUjhgHKyGPg6Age3x4hEzsOvx5I4e
	+y1GJw+tZ95B4/7YLnVYppQ4ru0Oqh9UCXFDJ0B5P3j9f3gk5Su4XVoLxDhM
X-Google-Smtp-Source: AGHT+IGOnHBPP7vyZm2NRrKEJLS52IIeKloxdqC9MsjOcxbNPa2juHoSenf671Sa5t0384ghpkEYcg==
X-Received: by 2002:a05:690c:fcf:b0:710:e7ad:9d49 with SMTP id 00721157ae682-71658ff8fdcmr6762067b3.13.1751476407649;
        Wed, 02 Jul 2025 10:13:27 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c1adb5sm25454797b3.53.2025.07.02.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:27 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 00/19] add basic PSP encryption for TCP connections
Date: Wed,  2 Jul 2025 10:13:05 -0700
Message-ID: <20250702171326.3265825-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the PSP RFC [1] posted by Jakub Kicinski one year
ago. General developments since v1 include a fork of packetdrill [2]
with support for PSP added, as well as some test cases, and an
implementation of PSP key exchange and connection upgrade [3]
integrated into the fbthrift RPC library. Both [2] and [3] have been
tested on server platforms with PSP-capable CX7 NICs. Below is the
cover letter from the original RFC:

Add support for PSP encryption of TCP connections.

PSP is a protocol out of Google:
https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
which shares some similarities with IPsec. I added some more info
in the first patch so I'll keep it short here.

The protocol can work in multiple modes including tunneling.
But I'm mostly interested in using it as TLS replacement because
of its superior offload characteristics. So this patch does three
things:

 - it adds "core" PSP code
   PSP is offload-centric, and requires some additional care and
   feeding, so first chunk of the code exposes device info.
   This part can be reused by PSP implementations in xfrm, tunneling etc.

 - TCP integration TLS style
   Reuse some of the existing concepts from TLS offload, such as
   attaching crypto state to a socket, marking skbs as "decrypted",
   egress validation. PSP does not prescribe key exchange protocols.
   To use PSP as a more efficient TLS offload we intend to perform
   a TLS handshake ("inline" in the same TCP connection) and negotiate
   switching to PSP based on capabilities of both endpoints.
   This is also why I'm not including a software implementation.
   Nobody would use it in production, software TLS is faster,
   it has larger crypto records.

 - mlx5 implementation
   That's mostly other people's work, not 100% sure those folks
   consider it ready hence the RFC in the title. But it works :)

Not posted, queued a branch [4] are follow up pieces:
 - standard stats
 - netdevsim implementation and tests

[1] https://lore.kernel.org/netdev/20240510030435.120935-1-kuba@kernel.org/ 
[2] https://github.com/danieldzahka/packetdrill
[3] https://github.com/danieldzahka/fbthrift/tree/dzahka/psp
[4] https://github.com/kuba-moo/linux/tree/psp

Comments we intend to defer to future series:
   - using INDIRECT_CALL for tls/psp in sk_validate_xmit_skb(). We
     prefer to address this in a dedicated patch series, so that this
     series does not need to modify the way tls_validate_xmit_skb() is
     declared and stubbed out.

CHANGES:
v3:
    - move psp_rcv() and psp_encapsulate() driver helpers into
      psp_main.c
    - lift pse/pas comparison code into new function:
      psp_pse_matches_pas()
    - explicitly mark rcu critical section psp_reply_set_decrypted()
    - use rcu_dereference_proteced() instead of rcu_read_lock() in
      psp_sk_assoc_free() and psp_twsk_assoc_free()
    - rename psp_is_nondata() to psp_is_allowed_nondata()
    - psp_reply_set_decrypted() should not call psp_sk_assoc(). Call
      psp_sk_get_assoc_rcu() instead.
    - lift common code from timewait and regular socks into new
      function psp_sk_get_assoc_rcu()
    - export symbols in psp_sock.c with EXPORT_IPV6_MOD_GPL()
    - check for sk_is_inet() before casting to inet_twsk() in
      sk_validate_xmit() and in psp_get_assoc_rcu()
    - psp_reply_set_decrypted() does not use stuct sock* arg. Drop it.
    - reword driver requirement about double rotating keys when the device
      supports requesting arbitrary spi key pairs.
    
v2: https://lore.kernel.org/netdev/20250625135210.2975231-1-daniel.zahka@gmail.com/
    - add pas->dev_id == pse->dev_id to policy checks
    - __psp_sk_rx_policy_check() now allows pure ACKs, FINs, and RSTs to
      be non-psp authenticated before "PSP Full" state.
    - assign tw_validate_skb funtion during psp_twsk_init()
    - psp_skb_get_rcu() also checks if sk is a tcp timewait sock when
      looking for psp assocs.
    - scan ofo queue non-psp data during psp_sock_recv_queue_check()
    - add tcp_write_collapse_fence() to psp_sock_assoc_set_tx()
    - Add psp_reply_set_decrypted() to encapsulate ACKs, FINs, and RSTs
      sent from control socks on behalf of full or timewait socks with PSP
      state.
    - Add dev_id field to psp_skb_ext
    - Move psp_assoc from struct tcp_timewait_sock to struct
      inet_timewait_sock
    - Move psp_sk_assoc_free() from sk_common_release() to
      inet_sock_destruct()
    - add documentation about MITM deletion attack, and expectation
      from userspace
    - add information about accepting clear text ACKs, RSTs, and FINs
      to `Securing Connections` section.

v1: https://lore.kernel.org/netdev/20240510030435.120935-1-kuba@kernel.org/

Daniel Zahka (2):
  net: move sk_validate_xmit_skb() to net/core/dev.c
  net: tcp: allow tcp_timewait_sock to validate skbs before handing to
    device

Jakub Kicinski (8):
  psp: add documentation
  psp: base PSP device support
  net: modify core data structures for PSP datapath support
  tcp: add datapath logic for PSP with inline key exchange
  psp: add op for rotation of device key
  net: psp: add socket security association code
  net: psp: update the TCP MSS to reflect PSP packet overhead
  psp: track generations of device key

Raed Salem (9):
  net/mlx5e: Support PSP offload functionality
  net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
  psp: provide encapsulation helper for drivers
  net/mlx5e: Implement PSP Tx data path
  net/mlx5e: Add PSP steering in local NIC RX
  net/mlx5e: Configure PSP Rx flow steering rules
  psp: provide decapsulation and receive helper for drivers
  net/mlx5e: Add Rx data path offload
  net/mlx5e: Implement PSP key_rotate operation

 Documentation/netlink/specs/psp.yaml          | 188 +++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/psp.rst              | 183 +++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  50 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   2 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 209 +++++
 .../mellanox/mlx5/core/en_accel/psp.h         |  55 ++
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 736 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_fs.h      |  30 +
 .../mellanox/mlx5/core/en_accel/psp_offload.c |  52 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 204 +++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 125 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  50 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/psp.c |  24 +
 drivers/net/ethernet/mellanox/mlx5/core/psp.h |  15 +
 include/linux/mlx5/device.h                   |   4 +
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/mlx5_ifc.h                 |  94 ++-
 include/linux/netdevice.h                     |   4 +
 include/linux/skbuff.h                        |   3 +
 include/net/dropreason-core.h                 |   6 +
 include/net/inet_timewait_sock.h              |   8 +
 include/net/psp.h                             |  12 +
 include/net/psp/functions.h                   | 203 +++++
 include/net/psp/types.h                       | 187 +++++
 include/net/sock.h                            |  26 +-
 include/uapi/linux/psp.h                      |  66 ++
 net/Kconfig                                   |   1 +
 net/Makefile                                  |   1 +
 net/core/dev.c                                |  32 +
 net/core/gro.c                                |   2 +
 net/core/skbuff.c                             |   4 +
 net/ipv4/af_inet.c                            |   2 +
 net/ipv4/inet_timewait_sock.c                 |   6 +-
 net/ipv4/ip_output.c                          |   5 +-
 net/ipv4/tcp.c                                |   2 +
 net/ipv4/tcp_ipv4.c                           |  14 +-
 net/ipv4/tcp_minisocks.c                      |  16 +
 net/ipv4/tcp_output.c                         |  17 +-
 net/ipv6/ipv6_sockglue.c                      |   6 +-
 net/ipv6/tcp_ipv6.c                           |  17 +-
 net/psp/Kconfig                               |  15 +
 net/psp/Makefile                              |   5 +
 net/psp/psp-nl-gen.c                          | 119 +++
 net/psp/psp-nl-gen.h                          |  39 +
 net/psp/psp.h                                 |  54 ++
 net/psp/psp_main.c                            | 254 ++++++
 net/psp/psp_nl.c                              | 517 ++++++++++++
 net/psp/psp_sock.c                            | 297 +++++++
 tools/net/ynl/Makefile.deps                   |   1 +
 60 files changed, 3962 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 Documentation/networking/psp.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/psp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/psp.h
 create mode 100644 include/net/psp.h
 create mode 100644 include/net/psp/functions.h
 create mode 100644 include/net/psp/types.h
 create mode 100644 include/uapi/linux/psp.h
 create mode 100644 net/psp/Kconfig
 create mode 100644 net/psp/Makefile
 create mode 100644 net/psp/psp-nl-gen.c
 create mode 100644 net/psp/psp-nl-gen.h
 create mode 100644 net/psp/psp.h
 create mode 100644 net/psp/psp_main.c
 create mode 100644 net/psp/psp_nl.c
 create mode 100644 net/psp/psp_sock.c

-- 
2.47.1


