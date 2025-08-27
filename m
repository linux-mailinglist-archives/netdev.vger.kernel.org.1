Return-Path: <netdev+bounces-217347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A2B38707
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96B07B3D7B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AF2F0671;
	Wed, 27 Aug 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlsIbJZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (unknown [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3237260F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310024; cv=none; b=l3IAe3t9w78DLE15kVgZyIy6VzAbDAmAL5iqoqAFKuaULUpSz0y1QwBxdW06ycDY4yqbOGWcLo1kHLL7sRMfGVd8/ovA56tae49FJu6lj3fK1PjbW10HIDPJ8ApMMmuBJ2Nyisxq6SqvLcGXl8ghTIwMhKg3ZKghCWwkRsJUv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310024; c=relaxed/simple;
	bh=xGWXbpKENG6CJaVoEmGurRPAyVDt+kWDRW+2+tmg0U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8zLCIOWHH3G1Zsb7UK6aQ5L4NJn6Ool9xhZxqYgn7TVdNNxtWmevyJ3ymO/jriPu/kaB2NcyEjUjqlfN4+oMGZgqhKqCC3jmfkh06B/Az4TsQv/szSyacDehbqwxwDhW1TzSDMPbC5/yOn12uzPAfLgHBIu4ZBDxxpCaefmdIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlsIbJZC; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-5f34874a934so46163d50.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310022; x=1756914822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IufCFADkSm/s05TOsCD6KXotCmTovdtqY2G9dtfsgjM=;
        b=JlsIbJZCkCNXE7ECGv4/bsltEA0RnWX/HSa56u79Z29tMd0Jcq3CjvysHiHLth1EgX
         qKibV8KMmNToCuC/5HNDe1ptQL8DIMKxt/AERBPrYAczUQeLWqMAA2dqZobJDLU8quej
         z3cWC/ap1LDeRuu6UtASvo7s/1Lq9uhqohAPpCfW+MRgzlI+SgaCG69QgzbwefnxG1gq
         j7a9JK8ypkbm3JOO5w9YF264okKl0obC5L/4eAK70VYPgJrAlb5FF5v05FPcaWGAcP8x
         ZrSr74MjSXTqMX6so1Rz+MIl3KEHFCyPRY4QXZiESO4ZrCaMIg0ZwLOpqfUX6/2so3Xw
         1Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310022; x=1756914822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IufCFADkSm/s05TOsCD6KXotCmTovdtqY2G9dtfsgjM=;
        b=knTobGkutDXHoEKIoPwuyJ3QjDgABv62fm3TUBD9/bCLE9sl0aYoprKpSwd8+FxJXn
         hgB3QIyBfNOLF1iTxQEC1thIOPoLSaDc2GKFnHa3rEkhc6I98ppQgrOgCt2bf/A9vWdx
         BO+vcr+RUnWvbYze0j8Jt5ZEXDxNyNI8TwpsahPJnUyB9KnOcEDAjgewyWJzrwUZOEMt
         rhoxE12fkVlE/QQKkRZ8zEr2WVnPPv3Rr4MZkDfn54OvpFEazvxooGZSqU15m4ZsiV7D
         YlTwc9QWpbEZBY8brwvb2ib59/wXTFC3AVwT/sauaL3zN20SHx3XBaWsaF7OgundWlyk
         XUNg==
X-Forwarded-Encrypted: i=1; AJvYcCWEH5Ms4p/fZb/DkYNeEfDBPmkgIOp5+LmTLF9mB1UqjlkmdWmn74ByUnVT2v1cHZEC9ZDpJOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQdwv216NJTJlcMfC1KFLdDpVjOkmHHeIo/Z2TpTBJ7q7eQDi
	Cg7euL+1XjVZypVZDpJ+vk4rxKg3NMWHQWDiVUmSxBXrA6XdaqvBFP18
X-Gm-Gg: ASbGnctvlQS9ZskjdzaGcq80DnSSjIDtcuGL1wkKWIMOQEVOaeHANsBQ8ABgR9xjnez
	efkKkPrxAq920ymJf5Fsv751RKVWJtI4CmpC+rIAa0ldjBTvTU2uOgQ1XyBbKpdWRtBOWEDtSvm
	CRLNioWiewz3B0ROm5HTN9qb9BCA09JAYYqMnMZLq7VYyivRA4fgz6Ke26476tVG8iNgYcwb3PO
	Fx1xQg/fekc+wNcZc4d4DLZwCzdGQT8I4KmSGaQh2jEWSr8R7GRu29jKAC9vYTMsArpT0VrgBKj
	5fax9Da7IAlp7MvO9UcIuKOT0FFWA60nSfWhuMczvNoNRlDs7UxgS4r4XtFHH7EvJFJPUyOfhAL
	5C4NtKSi0hVkgw0PlDk0humbGrM5i+w==
X-Google-Smtp-Source: AGHT+IGHtKaNBN1ZFqTrNaiPeKXOc2NwDyF5itQNVodGx537fzluH4Y5zKxreuc/s4HwUxktNWK6yg==
X-Received: by 2002:a05:690c:4c09:b0:721:1105:e84e with SMTP id 00721157ae682-7211106157emr139710337b3.10.1756310021467;
        Wed, 27 Aug 2025 08:53:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff173633esm31995157b3.27.2025.08.27.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:40 -0700 (PDT)
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
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v9 00/19] add basic PSP encryption for TCP connections
Date: Wed, 27 Aug 2025 08:53:17 -0700
Message-ID: <20250827155340.2738246-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v9 of the PSP RFC [1] posted by Jakub Kicinski one year
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
   - we prefer to keep the version field in the tx-assoc netlink
     request, because it makes parsing keys require less state early
     on, but we are willing to change in the next version of this
     series.
   - using a static branch to wrap psp_enqueue_set_decrypted() and
     other functions called from tcp.
   - using INDIRECT_CALL for tls/psp in sk_validate_xmit_skb(). We
     prefer to address this in a dedicated patch series, so that this
     series does not need to modify the way tls_validate_xmit_skb() is
     declared and stubbed out.

CHANGES:
v9:
    - rebase series
v8: https://lore.kernel.org/netdev/20250825200112.1750547-1-daniel.zahka@gmail.com/
    - rebase series
v7: https://lore.kernel.org/netdev/20250820113120.992829-1-daniel.zahka@gmail.com/
    - use flexible array declaration instead of 0-length array declaration
      in struct mlx5_ifc_psp_gen_spi_out_bits
    - check that 31 LSBs of the SPI are non-zero in psp_nl_parse_key()
    - add details about GRO and TCP coalescing in commit message of
      fourth patch.
    - add comment explaining use of xa_store()/xa_erase() in
      psp_dev_unregister()/psp_dev_destroy().
v6: https://lore.kernel.org/netdev/20250812003009.2455540-1-daniel.zahka@gmail.com/
    - make psp_sk_overhead() add 40B of encapsulation overhead.
    - use PSP_CMD_KEY_ROTATE_NTF instead of PSP_CMD_KEY_ROTATE as arg to
      genl_info_init_ntf()
    - fix errors reported by static analysis
v5: https://lore.kernel.org/netdev/20250723203454.519540-1-daniel.zahka@gmail.com/
    - rebase series
v4: https://lore.kernel.org/netdev/20250716144551.3646755-1-daniel.zahka@gmail.com/
    - rename psp_rcv() to psp_dev_rcv()
    - add strip_icv param psp_dev_rcv() to make trailer stripping optional
    - replace memcpy in mlx5e_psp_set_state()
    - rename psp_encapsulate() to psp_dev_encapsulate()
    - delete unused struct mlx5e_psp_sa_entry declaration
    - use psp_key_size() instead of pas->key_sz in mlx5e_psp_assoc_add()
    - remove unneeded psp.c/psp.h files in mlx5
    - remove unneeded struct psp_key_spi usage in mlx5
    - fix EXPORT_IPV6_MOD_GPL(psp_reply_set_decrypted) semicolon
    - remove version from netlink rx-assoc reply
    - remove key_sz field from struct psp_assoc
    - rename psd_get_for_sock() to psp_dev_get_for_sock()
    - use sk_is_tcp() to check sock in psp_assoc_device_get_locked()
    - add comment to tcp_timewait_state_process() explaining TCP_TW_SYN
      case.
    - psp_twsk_init() accepts const pointer, so caller does not need to
      cast const away.
    - add missing psp_twsk_rx_policy_check() to TCP_TW_SYN case of
      do_timewait in tcp_v4_rcv().
    - remove unused PSP_KEY_V0/PSP_KEY_V1 defines

v3: https://lore.kernel.org/netdev/20250702171326.3265825-1-daniel.zahka@gmail.com/
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

 Documentation/netlink/specs/psp.yaml          | 187 +++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/psp.rst              | 183 +++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  50 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   2 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 195 +++++
 .../mellanox/mlx5/core/en_accel/psp.h         |  49 ++
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 736 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_fs.h      |  30 +
 .../mellanox/mlx5/core/en_accel/psp_offload.c |  44 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 200 +++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 121 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  49 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   1 +
 .../mellanox/mlx5/core/steering/hws/definer.c |   2 +-
 include/linux/mlx5/device.h                   |   4 +
 include/linux/mlx5/mlx5_ifc.h                 |  95 ++-
 include/linux/netdevice.h                     |   4 +
 include/linux/skbuff.h                        |   3 +
 include/net/dropreason-core.h                 |   6 +
 include/net/inet_timewait_sock.h              |   8 +
 include/net/psp.h                             |  12 +
 include/net/psp/functions.h                   | 206 +++++
 include/net/psp/types.h                       | 184 +++++
 include/net/sock.h                            |  26 +-
 include/uapi/linux/psp.h                      |  66 ++
 net/Kconfig                                   |   1 +
 net/Makefile                                  |   1 +
 net/core/dev.c                                |  32 +
 net/core/gro.c                                |   2 +
 net/core/skbuff.c                             |   4 +
 net/ipv4/af_inet.c                            |   2 +
 net/ipv4/inet_timewait_sock.c                 |   5 +
 net/ipv4/ip_output.c                          |   5 +-
 net/ipv4/tcp.c                                |   2 +
 net/ipv4/tcp_ipv4.c                           |  18 +-
 net/ipv4/tcp_minisocks.c                      |  20 +
 net/ipv4/tcp_output.c                         |  17 +-
 net/ipv6/ipv6_sockglue.c                      |   6 +-
 net/ipv6/tcp_ipv6.c                           |  17 +-
 net/psp/Kconfig                               |  15 +
 net/psp/Makefile                              |   5 +
 net/psp/psp-nl-gen.c                          | 119 +++
 net/psp/psp-nl-gen.h                          |  39 +
 net/psp/psp.h                                 |  54 ++
 net/psp/psp_main.c                            | 278 +++++++
 net/psp/psp_nl.c                              | 505 ++++++++++++
 net/psp/psp_sock.c                            | 302 +++++++
 tools/net/ynl/Makefile.deps                   |   1 +
 58 files changed, 3905 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 Documentation/networking/psp.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
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
2.47.3


