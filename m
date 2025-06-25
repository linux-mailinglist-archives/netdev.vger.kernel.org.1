Return-Path: <netdev+bounces-201164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D32AAE8531
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849BB3A4249
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90812263889;
	Wed, 25 Jun 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApsYDFrt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD22126BFA
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859534; cv=none; b=fJ1GT0nGmJ4+DPb/PUjiH8Cy77Z1oOlSpDJqMQji6xPq2i/wjE1GgFsbDFeKAIfZh+4a1vFQAc4HAXYXIZGkA64hntnf8ts3xhdZAsGvmK9+YNg80hu4LcHQs95SdT+qmD3spniJTfU6BNbJOIplntIri7V52wWZnj8D6cdU6JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859534; c=relaxed/simple;
	bh=B+ZJYOLlgQ9YuBRCtgNFvKZ5RZy4PvW37x+zuLCX1s4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mlcJAzRNEJZYYjz2uvuwj/f892reZDyCfE/ZJIwMA4YifqYebIrlKRZxwHpV/TgfQh5C0fAI84DgTN7xHweTqnotnWCt9EtlYJ6ftTM4Wybr0q0z9Pm7ypDjSb1MhKsIjdT/Xo0Yy2AyNX79sSoIWSsxnnbjVwVz3LOBUpe1sIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApsYDFrt; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e82314f9a51so1294357276.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859532; x=1751464332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjXGdQhrETA2pnbKjPFiwfTAwEEcqmalomU6sayk24k=;
        b=ApsYDFrtIOZjusAw/kIUFIvRDxn7p2o7fds+ISIAIbc2a0guqxucMF0C29fv0h4Fjt
         5Cd0Z07SHzvgfZvS7RLyLiQ9P7B/0rFyQQvOleswLItG26qi2YmVf5/XY2bwaZT0pNzY
         ipWkhbjXolgrcUAR53Jf3dKvayUfqENec66s5SvwecWxfizXSuglt9vONLDP+qnLdap6
         Aw+KibfYQf667qBSGV0TpELBsSpcwaE93kiNL2NXNIyQCCEWwQwnNRkWeRrNfVh3G3Bf
         Ui6l1ufIttu8JywFwrFTK/0Kdy7ipY1AdBzp+tLwckBr2NMPXgxqoJs7inV2rdIYIEW/
         EDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859532; x=1751464332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjXGdQhrETA2pnbKjPFiwfTAwEEcqmalomU6sayk24k=;
        b=RXZ9f7rSeOn9GxUiyxfubhlgdivhaaQrZPNE5qT9/S7kZywsywmPjoyzgmoPCGHxJU
         KzbTXCNBKgOynRC8etKlZmqq8jAvT358LSaeNkMNSZeTDBiCtE0FXIT4UYtTs5oGv/ef
         rYaFHk7zHNnYGb2KXYwppwzjt4LY160Mqq5is5t2ugm9PA+hkOfyntr1rnh7IodMx2js
         4FQ7ca2fJ4qYxPv2VHlBpzazW4L5l+q6IdUv2SX98024U01NoWp5wjMPQqONedXu/LwZ
         n7awXLKAp3MpChOuYV9T+SW8yifLfnKyhBP7Ty692NcBgHrup4DmI1idx66g438vntXh
         RHMA==
X-Forwarded-Encrypted: i=1; AJvYcCUePP3kow9lfjmAPHBvMid+7fsb4qi6YuTmPjiiM3PM4VsQ5n6RaRqe+M8HqYHITSDhG+SNUgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhBJ3/QhJvUQOrjJ6PGTlmobnVPvWaav+Eb8xC9nDNvGjZHQz
	9+4IJwKx27O4+sbPxiEt2pP3vcpylkS14pkyEg508LcWkCGbjyi1oz3o
X-Gm-Gg: ASbGnctSpQKkLQR8YpBQbzFYYpdF7o1GOGQwlq6L6iCU2mdW95q1kj5xG4IWeqqgUXs
	ReOer7ter2gjfza+mkwh1eSJkKJhkXF71l6/Y9h9ELcaH+AItjrGVmdZf/VGkne/e33K4h+XYPb
	H35VVk2An9LUbIb/d3OY7e/mOkAUdLWfhWISXqxWCSnIUaBHiuIbPtLZ/sDPF68z9kPERqqI8jx
	0+ynrxgVuCp6/u2DRPFG14rqgQRWe2UyhTZo/4hRtnpeaYfblz9sbDBbPfSvPYVyw67zKiF1PVp
	1dHpi9yuxCjqG6FhLpOcDVNHkzMzOAY1z39X6i59WCNgNaQDEIopyplaHQF/
X-Google-Smtp-Source: AGHT+IGNHnOPPq3iXfNfspyI5SXrL8LIe3CnaLtbsLGqHJYZ7B1yoCJ36S8FTNeNjoRCWdwwV3HKdg==
X-Received: by 2002:a05:6902:2601:b0:e82:7416:deba with SMTP id 3f1490d57ef6-e860177eedfmr3290422276.35.1750859531650;
        Wed, 25 Jun 2025 06:52:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb3947sm3670324276.54.2025.06.25.06.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:11 -0700 (PDT)
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
Subject: [PATCH v2 00/17] add basic PSP encryption for TCP connections
Date: Wed, 25 Jun 2025 06:51:50 -0700
Message-ID: <20250625135210.2975231-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the PSP RFC [1] posted by Jakub Kicinski one year
ago. See the changelogs of inidividual patches for problems that were
addressed from v1. Other developments since v1 include a fork of
packetdrill [2] with support for PSP added, as well as some test
cases, and an implementation of PSP key exchange and connection
upgrade [3] integrated into the fbthrift RPC library. Both [2] and [3]
have been tested on server platforms with PSP-capable CX7 NICs. Below
is the cover letter from the original RFC:

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

Raed Salem (7):
  net/mlx5e: Support PSP offload functionality
  net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
  net/mlx5e: Implement PSP Tx data path
  net/mlx5e: Add PSP steering in local NIC RX
  net/mlx5e: Configure PSP Rx flow steering rules
  net/mlx5e: Add Rx data path offload
  net/mlx5e: Implement PSP key_rotate operation

 Documentation/netlink/specs/psp.yaml          | 188 +++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/psp.rst              | 180 +++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   7 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  50 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   2 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 209 +++++
 .../mellanox/mlx5/core/en_accel/psp.h         |  55 ++
 .../mellanox/mlx5/core/en_accel/psp_fs.c      | 736 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/psp_fs.h      |  30 +
 .../mellanox/mlx5/core/en_accel/psp_offload.c |  52 ++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c    | 306 ++++++++
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h    | 125 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  50 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 .../mellanox/mlx5/core/lib/psp_defs.h         |  28 +
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
 include/net/psp/functions.h                   | 190 +++++
 include/net/psp/types.h                       | 185 +++++
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
 net/ipv4/tcp_ipv4.c                           |  13 +-
 net/ipv4/tcp_minisocks.c                      |  16 +
 net/ipv4/tcp_output.c                         |  17 +-
 net/ipv6/ipv6_sockglue.c                      |   6 +-
 net/ipv6/tcp_ipv6.c                           |  17 +-
 net/psp/Kconfig                               |  15 +
 net/psp/Makefile                              |   5 +
 net/psp/psp-nl-gen.c                          | 119 +++
 net/psp/psp-nl-gen.h                          |  39 +
 net/psp/psp.h                                 |  54 ++
 net/psp/psp_main.c                            | 148 ++++
 net/psp/psp_nl.c                              | 517 ++++++++++++
 net/psp/psp_sock.c                            | 308 ++++++++
 tools/net/ynl/Makefile.deps                   |   1 +
 61 files changed, 3979 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 Documentation/networking/psp.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_offload.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/psp_defs.h
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


