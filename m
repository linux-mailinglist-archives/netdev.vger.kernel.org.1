Return-Path: <netdev+bounces-198668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097FADD053
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24E93BFE00
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FD219A8B;
	Tue, 17 Jun 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ntye8M9y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79792135DD
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171351; cv=none; b=m+MCszXjuHUwhAJMRPFKEH8rsVjTGtu97auI0n1Iuh6EM7KvWla/1dUzudj8X3sbxcHUXhDPtb7IGJ8SfCdZprKzX7hGOBii+LyvxF7k988YBJSyKIVHhwg/1/Bxj/eTp5xK2yZxxKcSZWQ1VooUM8fUirfMqseWQOl/LEQjWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171351; c=relaxed/simple;
	bh=+y4lUUs1cNpvPOfDwifzB5Ow62n8nrodRicm61LFqDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJ5xi5ydLegTvr8Q2juJkud8Muus4oWNehzEJ7udby/WfrrJAAgMsJPF1/VeMT6P7WyftWW2lb0emS16XQvq70+qzKMAyZu55IEjR2NHgsCxAEm06MgajpIIpuU0AStNHA4G3jfRfn0Qc1cakj4tGT0O/ekyL8UH4YiZz0PqIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ntye8M9y; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so854971466b.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171348; x=1750776148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqPM8l1rtTX8snblT7mh4tQg7ejgFilQTowMn9hZeRs=;
        b=Ntye8M9ywEJY6S8GMnT1jQ5Mg2ZLpoZwbC4kx0jHF0fwCRJyhkYe1bdOwcK/+wKP0D
         xyCPLsWoHkYj/JbQm+xpUgCNbab7AKGKd/6s/9kZ/X9mFJFsuQFc/LJjL5HPbeH0KIfz
         LAsyogyM3D/X7U4tLWf0+1SzMKSZ4i5K6QtIib9y2DiBvRK8axEvWhAGmsfQdRdahHE7
         QGPv57WLOhieFWIx0aPbSMMqId6WySoMBMTPLpyBZ0IIIqw612vsPn94Wpm2Pz1iYbqg
         yILIXf7IQg699hB7fDqr6DGCJBM6tyJmCp8gp3W1ux0musdQLKkLdPuLEkCW1bHLFqZv
         WxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171348; x=1750776148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqPM8l1rtTX8snblT7mh4tQg7ejgFilQTowMn9hZeRs=;
        b=qkyIxN2jlwRegQtFjReRtOTGAew4ZzsF28rKz1av+XizNl61w2u/43pGp6INtzOz80
         VqROXOKWY+3KSxNhbIFHySIaRVT8V5qVfqLdx//meaTcN5BehMMgzIB5647XsT2VArvi
         7GAOB5UDPhRgVCV9pB442JnU+Y5GUfYBNxHFcrmOR2xJ9b0CtgWEnXOLNVoseoRsUk63
         LYSzvRsaJ6no+KBpiDgP/8F3PgHUg9TrxKQiPKODw1sAqE1yhibMBAO0aMyVWHzgislk
         I7d2LwRystHwb+uvqx+XYitxfKtCLziwTUeYeOVIvlNOxyzO+jlEL4cRMZ1WdoXFov68
         Qeuw==
X-Gm-Message-State: AOJu0YxzgPLNroCWNFKyW62w/NMk1PN7muUTs1aa6kZ24XvPgSzW212f
	hwlNypIsoWptQeZ5idaFsnI+aoLbhLsodkRleiJfEa60JETaQW3RgvRS
X-Gm-Gg: ASbGncvk88SsBlJYRBVnYJRn7m9fc8Li6Fsyb1WdpOsP4I6z848TYPGMHP7mXnZEJ0W
	KvXy6hYeFriJVIDqXlJrPWe7Rl5fweRbUSRKQQ09Sskp3Nx/GSFREg/3YZR2AjQVTpCCmfeWqQa
	hOzrhm1LPIdMROJYnoj0bZc/eogTNxuqAjf5HRO/RJI35gCgetj85SgYF0DnUC6890xAeyDOtgj
	8BHSu2TL+9UpTVUcuJZMpEeYBPS6szTpdUqf4M6K+YIPgH4yepkswMDCxbql0euNGGHtgQE3ulo
	gR4eK9k3jQnNs4N5+qPy864WftUHnnWNoSIbKhoBPQnaibApHDAhnybeNAOqtq9eV5Tqlnjo/GI
	aelqolg6p/FJW
X-Google-Smtp-Source: AGHT+IGdrh3Xw1G9lmZAKnpGUyH3kg1cJqXEkks+QEfVu7H3I5H5dJDC31av+fh38/+ScsqAP5R1lQ==
X-Received: by 2002:a17:906:9f91:b0:ad8:9257:571b with SMTP id a640c23a62f3a-adfad32fa19mr1282703166b.16.1750171347943;
        Tue, 17 Jun 2025 07:42:27 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec81b887esm878216866b.39.2025.06.17.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:27 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 00/17] BIG TCP for UDP tunnels
Date: Tue, 17 Jun 2025 16:39:59 +0200
Message-ID: <20250617144017.82931-1-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series consists of two parts that will be submitted separately:

01-11: Remove hop-by-hop header for BIG TCP IPv6.
12-17: Fix up things that prevent BIG TCP from working with tunnels.

I kept them both here for the sake of big picture.

There are a few places that make assumptions about skb->len being
smaller than 64k and/or that store it in 16-bit fields, trimming the
length. The first step to enable BIG TCP with VXLAN and GENEVE tunnels
is to patch those places to handle bigger lengths properly (patches
12-17). This is enough to make IPv4 in IPv4 work with BIG TCP, but when
either the outer or the inner protocol is IPv6, the current BIG TCP code
inserts a hop-by-hop extension header that stores the actual 32-bit
length of the packet.

This additional hop-by-hop header turns out problematic for encapsulated
cases, because:

1. The drivers don't strip it, and they'd all need to know the structure
of each tunnel protocol in order to strip it correctly.

2. Even if (1) is implemented, it would be an additional performance
penalty per aggregated packet.

3. The skb_gso_validate_network_len check is skipped in
ip6_finish_output_gso when IP6SKB_FAKEJUMBO is set, but it seems that it
would make sense to do the actual validation, just taking into account
the length of the HBH header. When the support for tunnels is added, it
becomes trickier, because there may be one or two HBH headers, depending
on whether it's IPv6 in IPv6 or not.

At the same time, having an HBH header to store the 32-bit length is not
strictly necessary, as BIG TCP IPv4 doesn't do anything like this and
just restores the length from skb->len. The same thing can be done for
BIG TCP IPv6 (patches 01-11).

The only reason why we keep inserting HBH seems to be for the tools that
parse the packets, but the above drawbacks seem to outweigh this, and
the tools can be patched (like they need to, in order to be able to
parse BIG TCP IPv4 now). I have a patch for tcpdump.

Removing HBH from BIG TCP would allow to simplify the implementation
significantly, and align it with BIG TCP IPv4.

Daniel Borkmann (1):
  geneve: Enable BIG TCP packets

Maxim Mikityanskiy (16):
  net/ipv6: Introduce payload_len helpers
  net/ipv6: Drop HBH for BIG TCP on TX side
  net/ipv6: Drop HBH for BIG TCP on RX side
  net/ipv6: Remove jumbo_remove step from TX path
  net/mlx5e: Remove jumbo_remove step from TX path
  net/mlx4: Remove jumbo_remove step from TX path
  ice: Remove jumbo_remove step from TX path
  bnxt_en: Remove jumbo_remove step from TX path
  gve: Remove jumbo_remove step from TX path
  net: mana: Remove jumbo_remove step from TX path
  net/ipv6: Remove HBH helpers
  net: Enable BIG TCP with partial GSO
  udp: Support gro_ipv4_max_size > 65536
  udp: Validate UDP length in udp_gro_receive
  udp: Set length in UDP header to 0 for big GSO packets
  vxlan: Enable BIG TCP packets

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 -----
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  3 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  3 -
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    | 42 ++--------
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 75 +++---------------
 drivers/net/ethernet/microsoft/mana/mana_en.c |  3 -
 drivers/net/geneve.c                          |  2 +
 drivers/net/vxlan/vxlan_core.c                |  2 +
 include/linux/ipv6.h                          | 21 ++++-
 include/net/ipv6.h                            | 79 -------------------
 include/net/netfilter/nf_tables_ipv6.h        |  4 +-
 net/bridge/br_netfilter_ipv6.c                |  2 +-
 net/bridge/netfilter/nf_conntrack_bridge.c    |  4 +-
 net/core/dev.c                                |  3 +-
 net/core/gro.c                                |  2 -
 net/core/skbuff.c                             | 10 +--
 net/ipv4/udp.c                                |  5 +-
 net/ipv4/udp_offload.c                        | 12 ++-
 net/ipv4/udp_tunnel_core.c                    |  2 +-
 net/ipv6/ip6_input.c                          |  2 +-
 net/ipv6/ip6_offload.c                        | 36 +--------
 net/ipv6/ip6_output.c                         | 20 +----
 net/ipv6/ip6_udp_tunnel.c                     |  2 +-
 net/ipv6/output_core.c                        |  7 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  2 +-
 net/netfilter/nf_conntrack_ovs.c              |  2 +-
 net/netfilter/nf_log_syslog.c                 |  2 +-
 net/sched/sch_cake.c                          |  2 +-
 28 files changed, 83 insertions(+), 287 deletions(-)

-- 
2.49.0


