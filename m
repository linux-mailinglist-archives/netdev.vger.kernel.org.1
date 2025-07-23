Return-Path: <netdev+bounces-209495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B2B0FB8A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D4960B7B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21885215F4B;
	Wed, 23 Jul 2025 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re1SvXFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CA230BEE
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302899; cv=none; b=b1kLKydjJx1I2h0Bml4GRv8wzp5g1ikERg6Lc1m/+uXfPmRbpQex6UcIowUoixH24Tg+WlrQYUzGrBDhax+MX4aW66vnSnsGxBOL9M59Eir92CWR8yXgc4IZpHqkXfh1Ttll6xTwkpRKzYwQF5U/EW5J4lmfGBgHBq+IR4xxzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302899; c=relaxed/simple;
	bh=OAFIQNO1/BxTutdRTJKlHwI8Tb6f+jQr4QrTCEe3K9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j4E7Y0kQH8oxgR3PYYDYhz1fnQ9R10yQn+KZrmFCCb629burwtSdVQzQszRnnXJLN7U5LvzPQNCJO94D0jco7KZ2cVHk7OfHSsCaKW/AIrhcC3l6FwXBFuzZj3/gqTmujTeUYAS52qia0mdEs26+n+Sa4voJcQuWvQ+RxVbS0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re1SvXFk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7180bb37846so2979207b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302896; x=1753907696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wm+lM0Pgy9DRubFbe6kcrWErgNunHE+aAsVjdcaxLBU=;
        b=Re1SvXFkdnulqYlVmMkjGcdDTUxIAbgUcvM1DXYAm4j7wBAq6XeqTRatGNdbMfke+y
         lUo0YG91Mv9xoosFfhZxDQtc3UEtpMiRqysJaFcXhxj3cuho0XgFojDcy0BVXnA5wvGU
         lgguQ365L2BZyQAVieyXTYuaLPN/B4F28zrqbYd80O84ghD6z+bRbSB/Ylga2Ahhga3m
         ztWCr3XmTliIDQ8CVNEwhnk16zAefKtMlAgLit8mHiDbId7FhV986VqVYSr3qBP/u5S+
         yb4juqPrZmT9SgNUBo8J+CO0Cj/PDUBj1iaD/i5p2fwhwVdQ2YOlY2E3oGU5wvWtvOFB
         PI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302896; x=1753907696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wm+lM0Pgy9DRubFbe6kcrWErgNunHE+aAsVjdcaxLBU=;
        b=K9ygHpRTqS8HlvVinBXw0D7Twq59joVtpRFzTY3VJSfx8WZqjP2KzZSzJPIJFkdjn3
         MOAVMnXmeTkHqkwRhlce+5ZPW+qITlJhHnm34iTSZH9seAtF4F4Wpny9P7a4kZayxjX1
         WPFFXFHZ1tN8tg0q+HauUQE4FdiNESrijRZE0Y3DqOOiLBbecBB4WG/owOUVdQ0Vbk2m
         bUV36LNMg/GoGlP6dVfN/LaXI6s+4/wxKsNlLSFKfawt3JQ6mhtuaxrl7YouPzV/2Ze6
         0ixyH2ChSw9K67pP5RaXQ2KKCSZDXoXA+pSMkH+gdhuC9HHax4Xn64JiPqMn4y2A8uDk
         OtuA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Af0iDJ9NRkpx6jAsjnCYqYiDzJPb+Pm8f9lkhF+Ii91csX5dcucEJuhnTY3PDNrjmnARpVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyRWkj6l7KKw3fByaheedlvQ9uttZBkjbv+yK5ReuvXyJaIpy
	Wq5CKCrvMQ39Xmb5Is41c2PrdhXVN9bxpSPDdyhkJxfFRqIaWpbb1E6f
X-Gm-Gg: ASbGncs4B43DdRRRUEhF8wC73dwemXHlrmLNzZRps3av6LnfW4zmvQIJ6t1NQrv7OGs
	uKIVHl8Rtl87yKMb0JAEvtnU+D3iAbz3PDpf0zDcDG5GVKiO1fFtniqd7pBglh1tB+UApiZI4/9
	7U9IVetWYtHDnKqGRZmeTHsXPWLJqHi7NI00s+TgNPTsDaFVp6W/iPZ6zVyXPze9IQy4U3FuDEo
	vwsdLIQJb90wTjG4+ua/1ZZTzW3vlCVHuoK8JfBa2voQhV3i+YL82BRkFmcxDoivcYqQagggoe3
	TMONStca2X+odxqctEgangEJZEyHRARM0FzM1HAGJoxXnjETof0jBHmjmpRTE/uHBv2gtmwYdUR
	my59gtLzPfuAb9C0QXSyIXvVu5O8=
X-Google-Smtp-Source: AGHT+IGklCN4FfunSKaNcwPaZYAY0uefed5GfGntqBmQ1lYxIv4qvSnv47ErizHfeywj//0T7Gv0Iw==
X-Received: by 2002:a05:690c:6603:b0:719:4cff:16db with SMTP id 00721157ae682-719b4238aa6mr57397447b3.25.1753302895850;
        Wed, 23 Jul 2025 13:34:55 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71953141faesm31186477b3.39.2025.07.23.13.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:34:55 -0700 (PDT)
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
Subject: [PATCH net-next v5 00/19] add basic PSP encryption for TCP connections
Date: Wed, 23 Jul 2025 13:34:11 -0700
Message-ID: <20250723203454.519540-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v5 of the PSP RFC [1] posted by Jakub Kicinski one year
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
v5:
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
 include/linux/mlx5/mlx5_ifc.h                 |  94 ++-
 include/linux/netdevice.h                     |   4 +
 include/linux/skbuff.h                        |   3 +
 include/net/dropreason-core.h                 |   6 +
 include/net/inet_timewait_sock.h              |   8 +
 include/net/psp.h                             |  12 +
 include/net/psp/functions.h                   | 204 +++++
 include/net/psp/types.h                       | 184 +++++
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
 net/psp/psp_main.c                            | 273 +++++++
 net/psp/psp_nl.c                              | 497 ++++++++++++
 net/psp/psp_sock.c                            | 297 +++++++
 tools/net/ynl/Makefile.deps                   |   1 +
 58 files changed, 3884 insertions(+), 62 deletions(-)
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
2.47.1


