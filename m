Return-Path: <netdev+bounces-248270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD4D064EC
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 22:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B6D5300E8C3
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2933769F;
	Thu,  8 Jan 2026 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8jpVjYJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F939337680
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907627; cv=none; b=bgMu9vJNOszjhj2+ErGzQydLB40iK2PruAu4r5tYOIJ6aC1Jya5oAQiezAn79IaLJr/FK1D4jDvJR4HisSnab9ZMgVmsLsY5kP5hkeaLgbDcIT9rmvph2r/a0dRPhNVuNGcNENacQBv2zwpDJaqnb2gsehXSpohKQWF1Y8Mn/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907627; c=relaxed/simple;
	bh=VcY8TTTh7bZZ3T6K5FSlYOtni9mNEfq7mBNqRAtO9u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQM+JVXQYv4cbdin0BRkXD0LS7B3R14PKeQJoJtiVkTDUuPx4Gi/PAFJh3qRORdrb2JP/PtGe87ZnDNVb7lDJLATkg4aPc6jw6T7V+FBrlvQxUuchwhZV2WlOR+B+xfB1D92NkJ5MQLRnXDx1nPtaZ3XcKWvoZuD8u856ujZFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8jpVjYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C99C116C6;
	Thu,  8 Jan 2026 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767907626;
	bh=VcY8TTTh7bZZ3T6K5FSlYOtni9mNEfq7mBNqRAtO9u0=;
	h=From:To:Cc:Subject:Date:From;
	b=e8jpVjYJEL5vg99msNpzDGBXPeu+cZ54VG4H/kIPm9rjASOMZfndGbw9o4l0tecRT
	 wfL37F5ofMOOJzZ2TAVAWbC6eF8aackncTHkfeWiD4FenixqV/wdEs0wn0krCg+U1R
	 wWKMJG3sux7zd5eAWZShX7h2awVIDZaglDU4ItoABvOLoydk2Mzra0CkcGMEhdY/Ww
	 OepFQ8hXvp3Sj66aNDWPfwkEGGyD8+DNacVjdfEGqxISfPoDE3Dxhuloymw8wI/UZU
	 KmXfFm55IEc4uozb9BXcu9P8PrIxfoasozj26NrR1kb5I8O7A5YGw+bFpoNvhF2JMB
	 NLVzWk/vN/img==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net 0/4] mlx5e profile change fix
Date: Thu,  8 Jan 2026 13:26:53 -0800
Message-ID: <20260108212657.25090-1-saeed@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series fixes a crash in mlx5e due to profile change error flow.

Saeed Mahameed (4):
  net/mlx5e: Fix crash on profile change rollback failure
  net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv
  net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv
  net/mlx5e: Restore destroying state bit after profile cleanup

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 13 +--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 86 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 ++--
 3 files changed, 71 insertions(+), 43 deletions(-)

-- 
2.52.0


