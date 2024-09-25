Return-Path: <netdev+bounces-129849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FAD986787
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205D9B238B8
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B56714E2ED;
	Wed, 25 Sep 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sggBqvOG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE514D2B8
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295622; cv=none; b=D04m47nyT0MJMT2cpb4UaRfBMENdceUovnKISyXQu/lVOk3OnPJKass5bNzRHJHuGAtDxk9+lQUZRXHUk63m2aEGhWh3tQg6y0MYBJ2TYoJ8LPW79kmQlX7Xeh3nSgMycFjMsIInor+otnE4YR2hZ7gLuZskr3sKN1dpbMMBc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295622; c=relaxed/simple;
	bh=UmeLeVjpGuVXJaYH9oHbxtBmYZZ2mIjnmjnppDiBmD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tictvVFq9EVGeO4SpeuUisavgA9QN2B126NKcbSUdgDATBfGR/PcAUBGl6bbt5WTDAaoT7sQloboiA52O6gPszFVN6dN8PmY/QjZTrPq0dX1QwT7aXSkOLLZJDrOqRdND90aZAgZ4QvJ9e+5BoSXsyiN5L6i92yx4pK+vSDlw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sggBqvOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE5BC4CEC3;
	Wed, 25 Sep 2024 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295621;
	bh=UmeLeVjpGuVXJaYH9oHbxtBmYZZ2mIjnmjnppDiBmD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sggBqvOG54v6Rlzyx0vyHJKGMc2oo+ybPt98Dak+PiRYzVBoohfqQb/ssrIC59Gvb
	 nasXFrYi7pEuIr4dwsf4dCbPQU8rz5+Gs8US3YROCoDMr3pyDNakh+qI9FT8kzT9kH
	 hQGMYaIiM3ptlCMTeHiPGhLCAYIeSL379v50Tg0yL4pvLVHqBvSSb7p7NOnb1EfJTb
	 OptY3qRyYaLbTgHrI0e/M7GPk1ZHQgpl5eIkbFjvaJaj8eRBRJvIL/JtB/6bnF7Gdq
	 7m4GPXwXJUh2MItkkL4L8b3QbivHZkd6lfn9yN/KdB1eytEHgClOCaGjzJXZLIWeSi
	 r4WTVL/FaIvVA==
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
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net 4/8] net/mlx5: Fix wrong reserved field in hca_cap_2 in mlx5_ifc
Date: Wed, 25 Sep 2024 13:20:09 -0700
Message-ID: <20240925202013.45374-5-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fixing the wrong size of a field in hca_cap_2.
The bug was introduced by adding new fields for HWS
and not fixing the reserved field size.

Fixes: 34c626c3004a ("net/mlx5: Added missing mlx5_ifc definition for HW Steering")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 620a5c305123..04df1610736e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2115,7 +2115,7 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   ts_cqe_metadata_size2wqe_counter[0x5];
 	u8	   reserved_at_250[0x10];
 
-	u8	   reserved_at_260[0x120];
+	u8	   reserved_at_260[0x20];
 
 	u8	   format_select_dw_gtpu_dw_0[0x8];
 	u8	   format_select_dw_gtpu_dw_1[0x8];
-- 
2.46.1


