Return-Path: <netdev+bounces-65361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622683A3F0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D928AF60
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6D17592;
	Wed, 24 Jan 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNMJ5Wkt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6717580
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084348; cv=none; b=EHF0d9cqCyiOHQrumrHypa5TLqVkvJtT3iVR2FxCst9/rLqrfdKfKUPO18mnDUICUp6MDayoXj7qH2zJrjVLgCNvw6eIf4fDwEAaZXVvfpUpY8MM+JasdoWVzAU8C3DndbhYWy6AOhBNJeL4E4LmwFjEWJMcHkzPm3rKxjloknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084348; c=relaxed/simple;
	bh=1/HOGQk8IcAL/AQOvw0nu3cSZVJD04r7T70Xby+gWwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3IlLDanKqCG+5hq3BilRJuFNIZt3CKojCA9Qsi0n39qID98t1vq7xjohtFJJcbZD8aGQy5G3e+ggB333PLyLoWk6sQBaGxDTJ/3D35NYJ2gHmx93L53R4dUx7K3rqLQD5tF6cWD9UNJanIECO8LEjBYdPq+i9m8DDSgJvzZveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNMJ5Wkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122C2C433F1;
	Wed, 24 Jan 2024 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084348;
	bh=1/HOGQk8IcAL/AQOvw0nu3cSZVJD04r7T70Xby+gWwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNMJ5Wkt3ggGFfSbymgBVOlbgaKMg8CovgjdH/zUiySoPyByrKZt3+EhK5AAlzHiR
	 FhV51Rh7LLF/X7Svoa3tcwQiL8YL5tntFG45EhSIopbY97dVxhppJjb55sCCqnKJ1E
	 r1a952U4cOKxIEEoSmlZtGrQVjf9OdmDgbYJvZGfvRwjaxAMnR1qw1fRLhHKqbKp5D
	 d0fiH3wqLS0pwLOxIHKjDA4w0NsCMZ8dfSlH/2cLqyn1yy/ENKstk28lA8xQFAQ/+Q
	 l1xiPCM5Ivf/qRIXyhN2Mhz5Cz1+iSVaDqpWwkhNLw5A2DKlwfTmAXdT4UFQyy+fyI
	 F8pTAP3oFcEvg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net 04/14] net/mlx5e: Fix inconsistent hairpin RQT sizes
Date: Wed, 24 Jan 2024 00:18:45 -0800
Message-ID: <20240124081855.115410-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

The processing of traffic in hairpin queues occurs in HW/FW and does not
involve the cpus, hence the upper bound on max num channels does not
apply to them.  Using this bound for the hairpin RQT max_table_size is
wrong.  It could be too small, and cause the error below [1].  As the
RQT size provided on init does not get modified later, use the same
value for both actual and max table sizes.

[1]
mlx5_core 0000:08:00.1: mlx5_cmd_out_err:805:(pid 1200): CREATE_RQT(0x916) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x538faf), err(-22)

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 30932c9c9a8f..047b465fc6a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -761,7 +761,7 @@ static int mlx5e_hairpin_create_indirect_rqt(struct mlx5e_hairpin *hp)
 
 	err = mlx5e_rss_params_indir_init(&indir, mdev,
 					  mlx5e_rqt_size(mdev, hp->num_channels),
-					  mlx5e_rqt_size(mdev, priv->max_nch));
+					  mlx5e_rqt_size(mdev, hp->num_channels));
 	if (err)
 		return err;
 
-- 
2.43.0


