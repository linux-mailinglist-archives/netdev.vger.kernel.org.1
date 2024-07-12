Return-Path: <netdev+bounces-110983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE592F312
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8BE1F21CA7
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB6184E;
	Fri, 12 Jul 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHPlwEtF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59071396
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744406; cv=none; b=PZhuYRkkBkjIgXV73YQVhupAanJn4AirOYUzjgvU78fX2lxhJx8hK5OnuqwgIDFpTr9Z90OVqBrKimQ3jeBZJDhpXF3+2amwwo5YDGHlaO3SPEoQIeTbrIpokzX26IFdnQ6eg9qdTuiw9FZq9AwwYQHnNiVTbyUf9JzRqpLFIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744406; c=relaxed/simple;
	bh=qKpMdWz6tE7fBzAUkJxNWrVWadwuxNoA3IqEeWuJVtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYSIi/VvdFqah/dEml905cVkjZh+znTPxjIzb6wD5kNmyXF9cr7VnCexH4txXJUvPNrXMsVBXd2lfYZqiYB/FM17oyvlv7BW5+Sui1oqu8l+pWQWbdPdDKJ7+v886pkvH0MSyTkM6dXnLbpt/Opp0X6/hRbcWU8C4PlkSdokMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHPlwEtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79474C116B1;
	Fri, 12 Jul 2024 00:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744406;
	bh=qKpMdWz6tE7fBzAUkJxNWrVWadwuxNoA3IqEeWuJVtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHPlwEtF6zGPt1Bxn1Cb4+0bcuWczKGZWuBT6K34qpc/d8/SWJA4rDSTZa2xSOfMK
	 OuCzeRUn/dsBHVRNQsa8P8dpnDXJt4LBUIbydSgJ6ET865iFmp83xyGVQu1aCgy8KO
	 beI5aVGDxYMn81tNuHs8dHHYoCIWdwarzsFpt6dGChoPbCwh/7vHLerPI9o3UNXFpS
	 B5mTcyCxwPyOK0zAxkIseApBcoJygjbK2s4IA4PH1tOMaoVhnX01Fe92nNSXlShQwO
	 fBPisMRW0rd5I14csHLqpZ68ov+14Q/fQl738XYGq+e7s7/kGJ2xnw5ejbqusSnJ0w
	 PXJFWEtedAg9Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	William Tu <witu@nvidia.com>
Subject: [PATCH net-next V3 1/4] net/mlx5: IFC updates for SF max IO EQs
Date: Thu, 11 Jul 2024 17:33:07 -0700
Message-ID: <20240712003310.355106-2-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712003310.355106-1-saeed@kernel.org>
References: <20240712003310.355106-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Jurgens <danielj@nvidia.com>

Expose a new cap sf_eq_usage. The vhca_resource_manager can write this
cap, indicating the SF driver should use max_num_eqs_24b to determine
how many EQs to use.

Will be used in the next patch, to indicate to the SF driver from the PF
that the user has set the max io eqs via devlink. So the SF driver can
later query the proper max eq value from the new cap.

devlink port function set pci/0000:08:00.0/32768 max_io_eqs 32

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index fdad0071d599..360d42f041b0 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1994,7 +1994,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   migration_tracking_state[0x1];
 	u8	   reserved_at_ca[0x6];
 	u8	   migration_in_chunks[0x1];
-	u8	   reserved_at_d1[0xf];
+	u8	   reserved_at_d1[0x1];
+	u8	   sf_eq_usage[0x1];
+	u8	   reserved_at_d3[0xd];
 
 	u8	   cross_vhca_object_to_object_supported[0x20];
 
-- 
2.45.2


