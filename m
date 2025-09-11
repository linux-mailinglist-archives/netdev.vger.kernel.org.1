Return-Path: <netdev+bounces-221925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE564B525F3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845C4466B06
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70549205ABA;
	Thu, 11 Sep 2025 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTXp3hBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15319DF5F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555260; cv=none; b=T1O9CMrtM0ZgMymuJXc1Cp8WnR/Q68GD6FORStiBRYY9KtK2lkZXs88nG0QoaIkkjVI5k/dnzb3AcmQLuUwzgJZ1rC+ZUoqRFArBy3i1HnG99aKpJD4/fX3PV1qERaoc+dQKStWFo19J9b9bcCuEf8vcmUOWOlTNRxdqtOLsPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555260; c=relaxed/simple;
	bh=B2XOiJjlNbf511QvpFK0QROasNqraXsZwIXz9KcdLDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrnGW3aMfMdMSLr96kEwUzuzBCHZHXjD4OeP4BTqzQfZm/GuVQxufZzvzs4DvXW9MJ2rCPgc3ROHs2LjkdRYF3eGtTks4ednPykRSOrPeFDunX8cW70WI4v/T9o90u29vu3XkKQwvTabmxAtQD3NCCaP6XfFAxBSfcvt9o+prK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTXp3hBa; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72e565bf2feso1888407b3.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555257; x=1758160057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kh7VhehPJw+ZsUt4WTnizW14XWqVxcGsZfUDLLQgEQ0=;
        b=ZTXp3hBaMPokyRPlbDoc/hqM16u73uttYqa74+zVawmjVeZB+7B66+d9z7pYRFF3R6
         2o2kdZCQ/mERmGMVFIywE5pwIpQtI+ZWKX+WHVWyI08/Mdl9BEsnG01NV9GCBb9xlVGm
         LXV6ADkbrkfho0AMfFGT/41ZeqEHKG8Ok0SBzb0DW58zpN8k/IC/yKashJvbzr52YeYG
         GCRXMXT2iOT/WXLXUK1Eg6NWlWDOoperY2cJMyUHOP6aMUvLCfjO2od/noIRA11ZirN8
         0XJnO6Kg5koTgoNc+pGNk+n/7TUt651jwi5F0/NZ03vxBDLthW0rC+2CVYu/yXDBheaf
         68Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555257; x=1758160057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kh7VhehPJw+ZsUt4WTnizW14XWqVxcGsZfUDLLQgEQ0=;
        b=WF2PhZjKxvuWC9EwQVtZ/AGfhkpauajQHx8X+J/5wnH1HgCwl2FYgiS6YNg3urSKvx
         RWrhN5/ppQYmi71VtATvcpcGbBatEe9RDqKCHvVtVXobhBDABlh81VEs/znVOISjrWxs
         qTcFL2rvLaXLFnJO848IUKUQoJs1nYFKYAj+8s1noEHR4xC7bed/dT0rhBPsCgl7kbOf
         GH1NMVE82Kwzs6JmjaX6YhGdyQOpdRuDi3AzUU3d55nxBYnxOlXHCwgDO9RfgDngdvFu
         MIGTgqNqqjz3RDvVALJpQzJamfsUs6KtBDRuRhgRcasyOiXItVqN/4zQyBLQJpcm2c30
         lQYA==
X-Forwarded-Encrypted: i=1; AJvYcCWq2q/c+cB+5h/TM95i5cnRhkU+7JfCgVFQqTLUekfOPtyuESAPMUFxpDlCgvZHIYdrBkPp7BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJ83T9b/jVCCJvaB6XCCMo6aj4UlFVwr0uFHrTJ6Ev4InaM3I
	ziyC9eseDTDEt8vnsEvoiqb/W63gfL6y54xt2Od0um9ATmLU873xWHkG
X-Gm-Gg: ASbGncspldDMhLL/+o7VbB3xOSNeMiQPt5A+YVpV+eNWUMZgOfBJqjjNUuZRy+TCIit
	PzZU/savcxH7iTOv9zG0pdmZzZ3Oa+4RWKRyk9fiLpW+8xpWoWQu5DW/K5GxIojWpGaZwbL+S17
	tGEfRjz1GIHyRVcwOdom7fb2tl51fykCxQRT7xSX6u7IJuPVOPNj+7AajVRjzPU5BSKiLDyID9y
	qVk18O7Jknaowq6lCKa4K1CbP3/K28JST4hl08laHxsqJsMvVWhgGes8y8/tYJGYcDODSi0yGYb
	PgMa2tsor1ck3Xuv1qSAqBQ+7M7U4xVnf8Di7m4Eub+gAy6Ww/gE3j7C3wRTEW0Suq6DuPEmq3I
	l9uRcMJ1mA9BA29rY5NU7
X-Google-Smtp-Source: AGHT+IHuiNvL1sa9+lACMNyUVIt+TTryAkoskhPqzZt3jCTg5QaCVlG1fsQiwW24111ucfjltVQ8ng==
X-Received: by 2002:a05:690c:4c0d:b0:72e:ec1c:8530 with SMTP id 00721157ae682-72eec1cb76amr19708927b3.27.1757555257108;
        Wed, 10 Sep 2025 18:47:37 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f762383f3sm385507b3.9.2025.09.10.18.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:36 -0700 (PDT)
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
Subject: [PATCH net-next v11 00/19] add basic PSP encryption for TCP connections
Date: Wed, 10 Sep 2025 18:47:08 -0700
Message-ID: <20250911014735.118695-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v11 of the PSP RFC [1] posted by Jakub Kicinski one year
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
v11:
    - support IPv4 in psp_dev_encapsulate()
    - support IPv4 in psp_dev_rcv()
    - use pskb_may_pull() in psp_dev_rcv()
    - move psp_twsk_rx_policy_check() into psp/functions.h
    - consolidate mlx5e psp control plane files into en_accel/psp.[ch]
    - check psp_crypto_offload cap in mlx5_is_psp_device()
v10: https://lore.kernel.org/netdev/20250828162953.2707727-1-daniel.zahka@gmail.com/
    - rebase series
v9: https://lore.kernel.org/netdev/20250827155340.2738246-1-daniel.zahka@gmail.com/
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

 Documentation/netlink/specs/psp.yaml          | 187 ++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/psp.rst              | 183 ++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  50 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   2 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 952 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp.h         |  61 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 200 ++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 121 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  49 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 include/linux/netdevice.h                     |   4 +
 include/linux/skbuff.h                        |   3 +
 include/net/dropreason-core.h                 |   6 +
 include/net/inet_timewait_sock.h              |   8 +
 include/net/psp.h                             |  12 +
 include/net/psp/functions.h                   | 210 ++++
 include/net/psp/types.h                       | 184 ++++
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
 net/psp/psp.h                                 |  54 +
 net/psp/psp_main.c                            | 321 ++++++
 net/psp/psp_nl.c                              | 505 ++++++++++
 net/psp/psp_sock.c                            | 295 ++++++
 tools/net/ynl/Makefile.deps                   |   1 +
 50 files changed, 3801 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 Documentation/networking/psp.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
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


