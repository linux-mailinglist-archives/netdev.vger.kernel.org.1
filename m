Return-Path: <netdev+bounces-165261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AACA314E8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2C164D72
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B264226388C;
	Tue, 11 Feb 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HooRdEwy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5752505DF
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301715; cv=none; b=lUEVdqdi8niaVNgw/cU8OcCm2aMXW23dAxNwgDlPdTR38LYpW2o9RogEWnHiFlvQO0Wmh+A1oXaXJU17JH1Mffu0LJGoxpU+G7Fqt9DrVboBHXvf68Ke2vdofnAzRydB4LMwhIzLloeZHEaXJAIBM9ziGs4RFdwp9uPZPQxL5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301715; c=relaxed/simple;
	bh=ObuEJMVhzHIkEQYB4qzS0GJaQFRpzFhUqCZPv9N4kuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDOYVTUkQNYnLydQA7BPkhXis3wQFr/TUE0uLs72fMIpjoUjyEkGC5mA7g3rNJAKhfZCEmKmyzdsGmp91zqZPD6wn3ZlrBXacBgDAZUulX2o0Q2aleNOyx4c4VpZwkXE5JiSUrTGBpu2QwzPky07Uaz8cTJdn7SEK+rrzMJlpsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HooRdEwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929ECC4CEE4;
	Tue, 11 Feb 2025 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301715;
	bh=ObuEJMVhzHIkEQYB4qzS0GJaQFRpzFhUqCZPv9N4kuY=;
	h=From:To:Cc:Subject:Date:From;
	b=HooRdEwy6J9otXt1apD6A0I9jl1Rshw2aDEK08sZN+z34ihs3mXctGG4o6hCa/SsB
	 zpi5kq/LivEKaMhJ+vw7cMR3pLYdyPm53Ce57cqqm/zkbuTlQnXEC3TXS49YPNsTbI
	 BM7VC9Z3L6fnPcj/py1JCwaOhSxoF3FVYogac/5/dW11zMYylpp2eTN+O7ZfBlRDHA
	 CrsUN2Lg8K061ozs0UpobSNGpq1R+eX8iSJZ+gkf0WxxgsOrKmnP77djwf+CnkaKiL
	 MDIoTgOKLmbaeBCFG0CUw/IFqehK62/6t3pciQMSMrqe01vZpl+Idm2Zfq4jAXWNQ3
	 pYWjDt5hD/qNg==
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
Subject: [PATCH net-next v2 0/4] eth: mlx4: use the page pool for Rx buffers
Date: Tue, 11 Feb 2025 11:21:37 -0800
Message-ID: <20250211192141.619024-1-kuba@kernel.org>
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

v2:
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
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 120 +++++++------------
 drivers/net/ethernet/mellanox/mlx4/en_tx.c   |  17 ++-
 3 files changed, 53 insertions(+), 99 deletions(-)

-- 
2.48.1


