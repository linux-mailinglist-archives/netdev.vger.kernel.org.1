Return-Path: <netdev+bounces-165742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6397FA3345F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4093A2ADE
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48627456;
	Thu, 13 Feb 2025 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSXupULA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719B6FC3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408802; cv=none; b=i+etRuByz7BQ+zQ8DKDp1EgDAtKR6TOntcxjuv5HHNOavOXbtq/PSHvLOKCPlia/64O2GR0XxmKRi8h+GON5NeQO7e6dvRbi0YmeXuVDHtX/BWev9XW7PQCU56WLyTNvPR/WQFUq/liHhutrt0Y/5G9VQSM+KyRHNWS5uDqsjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408802; c=relaxed/simple;
	bh=oDlZKObnmYpTg4srCcVsOzTKALgSoyXvIgBU0rILKlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mz70jj0yaCm+9P5EXmChc/OIM3vTSL0N3avr6BUKeg2TAFT9yAxEoITNyoo42TGFBvNq+VnpPm8pvqWSh2qJ2/cE0oOjQ2H10Ag7z8nJjd4XvZoia6C9H8e1GNdkPYxvQe4XKRprtHXh0I9/NsnhYbT6unwCGsUAFS2Dixfn8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSXupULA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB81C4CEDF;
	Thu, 13 Feb 2025 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739408801;
	bh=oDlZKObnmYpTg4srCcVsOzTKALgSoyXvIgBU0rILKlk=;
	h=From:To:Cc:Subject:Date:From;
	b=uSXupULAsSi5Fj8eL7B5XalcyuJL060IP1qjT9KnXp4Nk3G+ehtDyImx91v9J1ZVG
	 DgMF9h0ZoE3dfKEqUeViLFScTpIGa0mVoiRoeK+FGmgjCUsfvL7nMzQjkkNKbAULcB
	 WlybQ8/dDOQiMlaP7sJecx4vtdWKPfwavEyvAUKPrGZdiG21qRBWJ2+iNBC9+nA6TY
	 wSCWqgUqeQ/jlwzjlEbkzb4JFNvE882VpK3ZUJ4C00c1fAgGQlhtWQXjW+Il8FHtPu
	 O4BZ7YiDXETUze8hLqZdxA2WF/W55WR04zeCKj91AgBuHNELl+xihSaT4oJ6srWxU/
	 UhEWxVFimhosw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: tariqt@nvidia.com,
	idosch@idosch.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/4] eth: mlx4: use the page pool for Rx buffers
Date: Wed, 12 Feb 2025 17:06:31 -0800
Message-ID: <20250213010635.1354034-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert mlx4 to page pool. I've been sitting on these patches for
over a year, and Jonathan Lemon had a similar series years before.
We never deployed it or sent upstream because it didn't really show
much perf win under normal load (admittedly I think the real testing
was done before Ilias's work on recycling).

During the v6.9 kernel rollout Meta's CDN team noticed that machines
with CX3 Pro (mlx4) are prone to overloads (double digit % of CPU time
spent mapping buffers in the IOMMU). The problem does not occur with
modern NICs, so I dusted off this series and reportedly it still works.
And it makes the problem go away, no overloads, perf back in line with
older kernels. Something must have changed in IOMMU code, I guess.

This series is very simple, and can very likely be optimized further.
Thing is, I don't have access to any CX3 Pro NICs. They only exist
in CDN locations which haven't had a HW refresh for a while. So I can
say this series survives a week under traffic w/ XDP enabled, but
my ability to iterate and improve is a bit limited.

v3:
 - use priv->rx_skb_size for buffer size calculation
 - use priv->dma_dir for DMA mapping direction, instead of always BIDIR
v2: https://lore.kernel.org/20250211192141.619024-1-kuba@kernel.org
 - remove unnecessary .max_size (Nit by Ido.)
 - change pool size
 - fix xdp xmit support description.
v1: https://lore.kernel.org/20250205031213.358973-1-kuba@kernel.org

Jakub Kicinski (4):
  eth: mlx4: create a page pool for Rx
  eth: mlx4: don't try to complete XDP frames in netpoll
  eth: mlx4: remove the local XDP fast-recycling ring
  eth: mlx4: use the page pool for Rx buffers

 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  15 +--
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 119 +++++++------------
 drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  17 ++-
 3 files changed, 52 insertions(+), 99 deletions(-)

-- 
2.48.1


