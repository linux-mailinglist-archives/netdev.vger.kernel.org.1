Return-Path: <netdev+bounces-95261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F56A8C1CAE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB92281A4D
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED3E148820;
	Fri, 10 May 2024 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev9CU9pa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB57E772
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310285; cv=none; b=ag4wORjTolMoHhazcNx9P8tWbQDPgFgeA6a4cThtd6mJQHpcX2EXBsoL9mSkDtssuNRUnAQhvl6c1y71ie4RO6N1b57jPskuY9UOMQNcFHVQKRsUwFD4c4xiZ4F4lLfXZWN2TdLWjyJTqLFPbRUx3O2KbkiMgEXuNWAI7NjJzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310285; c=relaxed/simple;
	bh=niymnATUu0j5awVVBZ2545CDnBhfQbN3EKf4A4VIiK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVOL3m0HLh/XECOlwSEOYIidFbZgsdkXuDQ2LcEo6N4VwKv/nhTeTc1psV3vo97FVqWNOz1FDDU283FZfXJu6CobveQbDgyLD/AdyGeUH+QnOVL5nZU/6VoAAoNey3hjCJRFp81Cd8FmRd255Ea9IIehq3m4qLWZO4JEJZ91rwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev9CU9pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B00C116B1;
	Fri, 10 May 2024 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310284;
	bh=niymnATUu0j5awVVBZ2545CDnBhfQbN3EKf4A4VIiK4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ev9CU9paUrgzDR5QggGh+4grNhfF1vP2W1Z5Pnid/Dky/wBVWFs4v0Irh7B8vYg2I
	 3WvsRgG1/KYM8p2L9CimD1EpotbzuyO3Ybtos66ATuakGyDdXUEqMTMzP6cdxcOkK2
	 yyXBbnMQosYCO0zXg3YdDemvyOH/q1nhFMWlyikkTbHnnOv6YtSk5AOdXayyLDqDwj
	 bN5Rpf7rMVt0CwMfrVNumVzqM35f1MDXHmBxx2wR3dNFMXFWd1qh5n3mLCfSFYFx+G
	 SIcNQhsnApuJ3beCe92RZGuG6hv8+F4waaJndZBiLiB8dwHUkLqAe48Kz5wpGXqfjs
	 5MmyjvZvZWNzw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Date: Thu,  9 May 2024 20:04:20 -0700
Message-ID: <20240510030435.120935-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

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

Not posted, queued a branch [1] are follow up pieces:
 - standard stats
 - netdevsim implementation and tests

[1] https://github.com/kuba-moo/linux/tree/psp

Jakub Kicinski (8):
  psp: add documentation
  psp: base PSP device support
  net: modify core data structures for PSP datapath support
  tcp: add datapath logic for PSP with inline key exchange
  psp: add op for rotation of secret state
  net: psp: add socket security association code
  net: psp: update the TCP MSS to reflect PSP packet overhead
  psp: track generations of secret state

Raed Salem (7):
  net/mlx5e: Support PSP offload functionality
  net/mlx5e: Implement PSP operations .assoc_add and .assoc_del
  net/mlx5e: Implement PSP Tx data path
  net/mlx5e: Add PSP steering in local NIC RX
  net/mlx5e: Configure PSP Rx flow steering rules
  net/mlx5e: Add Rx data path offload
  net/mlx5e: Implement PSP key_rotate operation

 Documentation/netlink/specs/psp.yaml          | 186 +++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/psp.rst              | 138 ++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |  11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   7 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   2 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h    |  50 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   2 +-
 .../mellanox/mlx5/core/en_accel/nisp.c        | 209 +++++
 .../mellanox/mlx5/core/en_accel/nisp.h        |  55 ++
 .../mellanox/mlx5/core/en_accel/nisp_fs.c     | 737 ++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nisp_fs.h     |  30 +
 .../mlx5/core/en_accel/nisp_offload.c         |  52 ++
 .../mellanox/mlx5/core/en_accel/nisp_rxtx.c   | 304 ++++++++
 .../mellanox/mlx5/core/en_accel/nisp_rxtx.h   | 124 +++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  10 +
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   6 +
 .../ethernet/mellanox/mlx5/core/lib/crypto.h  |   1 +
 .../mellanox/mlx5/core/lib/psp_defs.h         |  28 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   5 +
 .../net/ethernet/mellanox/mlx5/core/nisp.c    |  24 +
 .../net/ethernet/mellanox/mlx5/core/nisp.h    |  15 +
 include/linux/mlx5/device.h                   |   4 +
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/mlx5_ifc.h                 |  98 ++-
 include/linux/netdevice.h                     |   4 +
 include/linux/skbuff.h                        |   3 +
 include/linux/tcp.h                           |   3 +
 include/net/dropreason-core.h                 |   6 +
 include/net/psp.h                             |  12 +
 include/net/psp/functions.h                   | 150 ++++
 include/net/psp/types.h                       | 182 +++++
 include/net/sock.h                            |   4 +
 include/uapi/linux/psp.h                      |  66 ++
 net/Kconfig                                   |   1 +
 net/Makefile                                  |   1 +
 net/core/gro.c                                |   2 +
 net/core/skbuff.c                             |   4 +
 net/core/sock.c                               |   2 +
 net/ipv4/inet_connection_sock.c               |   2 +
 net/ipv4/tcp.c                                |   2 +
 net/ipv4/tcp_ipv4.c                           |  13 +-
 net/ipv4/tcp_minisocks.c                      |  21 +-
 net/ipv4/tcp_output.c                         |  16 +-
 net/ipv6/ipv6_sockglue.c                      |   6 +-
 net/ipv6/tcp_ipv6.c                           |  22 +-
 net/mptcp/protocol.c                          |   2 +
 net/psp/Kconfig                               |  15 +
 net/psp/Makefile                              |   5 +
 net/psp/psp-nl-gen.c                          | 119 +++
 net/psp/psp-nl-gen.h                          |  39 +
 net/psp/psp.h                                 |  54 ++
 net/psp/psp_main.c                            | 144 ++++
 net/psp/psp_nl.c                              | 517 ++++++++++++
 net/psp/psp_sock.c                            | 276 +++++++
 tools/net/ynl/Makefile.deps                   |   1 +
 60 files changed, 3791 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/netlink/specs/psp.yaml
 create mode 100644 Documentation/networking/psp.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_offload.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nisp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/psp_defs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/nisp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/nisp.h
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
2.45.0


