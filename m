Return-Path: <netdev+bounces-162849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C89A2826C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50881881A1A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC4213224;
	Wed,  5 Feb 2025 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsK2dsIJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED020C028
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725166; cv=none; b=qG3o+RqfIlC7VVktdIDnaAtp9vB1UctDaLMzlaHHLjvQVDW/BM5qTnckQrONSUoPLEtxEBvKRo927lwgsqxlw5xWAZGQGQejJl9zt6LAGdDwKy8QOqawD1Cy3uB/bI9T6A/L+aTMWcjoZqvIjavWpw4pnO/JfiMNk+4cdx/Qmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725166; c=relaxed/simple;
	bh=b02ZAWqLEKm+QZms/E3sBnaEOWr5mXrETzRS+LRzrZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQ2oYzq1oNuK4H3fWmQr3+PanfsuP7OxOPXYTbemJldJdyQDQhinLC5Wca09Z0zVqVU4025EWnkSMx2wSd1Uv5mOgIvdemgBerHSjUSyBZAl4IBNe4VmHineYemcXtnVYRgqQCMV4+FF0Svs+rGcEH7u3oj0cjW/undTlNCKH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsK2dsIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6616C4CEDF;
	Wed,  5 Feb 2025 03:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738725165;
	bh=b02ZAWqLEKm+QZms/E3sBnaEOWr5mXrETzRS+LRzrZc=;
	h=From:To:Cc:Subject:Date:From;
	b=YsK2dsIJiVDwjxe7/1dKL4g2GyAPtODwYHxvAKl+zIRYhY5wsMdnrX8txJTWntpxk
	 BcMbqMsj6sOV0IbyXiDqW/aWCyie7t6LRJhXffjCsTjKXeb2JQS4hDS3r/RRp/VJm4
	 +Kuuh59vGPn3nJ4v83Gu8eBYc6TlauU4Js3stlbqZe2PeMyVt/XkmbUnFCDjGaLyae
	 xnx0bVagq9/ngYih9BuoZSW5ncBiFriDhRFR4mk3N7HsCiJ8QuUzePcQnZjUjRihiO
	 zuLSQZSxG8piZHEEl7lx8EXGkDtfBSQQYAwN8DU0pqwUqVfi20vEZ5/vN5dpV9XJzL
	 couXoD4gOYeEA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	tariqt@nvidia.com,
	hawk@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] eth: mlx4: use the page pool for Rx buffers
Date: Tue,  4 Feb 2025 19:12:09 -0800
Message-ID: <20250205031213.358973-1-kuba@kernel.org>
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


