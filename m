Return-Path: <netdev+bounces-45791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB77DF9D5
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BA42811A2
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821421340;
	Thu,  2 Nov 2023 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bTsAZnQR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BB2111F
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 18:21:16 +0000 (UTC)
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 11:21:09 PDT
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CB2FB;
	Thu,  2 Nov 2023 11:21:09 -0700 (PDT)
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A8555600D4;
	Thu,  2 Nov 2023 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1698948911;
	bh=AcXaQ5Mec4Qx9/dmv68cZ2ZdUnNa3zc4PD95GHCF8M8=;
	h=From:To:Cc:Subject:Date:From;
	b=bTsAZnQRIEq47akNHVGYep1cZF6YUUu9CXHWGPZajC8zTxTqTXi+ydmUMRrfvyAnd
	 pWcS9jRDBeGKNmtA+UIj0nfa7OMap2TeYeozQwdEVKg0FGsCccNb3XNHTdfPhQnga9
	 o9B+ozjUrYFQCNYeEYGk5E8LYymfYg98rWFH9NzhzLb1ZrB7fwtaxqrWXwuhWutE+E
	 zmyV0E9JpL/nS2hN/GTaW21g1qPPoMil5RSV0JDOtOcf3XR2kJ5IxZXgFRAaNfkF1z
	 4OTNwHRVMCrkYlSjz+WLH5tEOf81aaaTmtj6/TzdPodYpzlMRMgUjr8FR4Hfn3Gm1K
	 xxS71QOAaUnfg==
Received: by x201s (Postfix, from userid 1000)
	id 9B272203FD8; Thu,  2 Nov 2023 18:14:36 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Muhammad Sammar <muhammads@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5: Fix reserved at offset in mlx5_ifc_fte_match_set_lyr_2_4_bits
Date: Thu,  2 Nov 2023 18:14:35 +0000
Message-ID: <20231102181436.3458623-1-ast@fiberby.net>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A member of struct mlx5_ifc_fte_match_set_lyr_2_4_bits has been mistakenly
assigned the wrong reserved_at offset value. Correct it to align to the
right value, thus avoid future miscalculation.

Fixes: 5c422bfad2fb ("net/mlx5: DR, Add support for matching on Internet Header Length (IHL)")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/linux/mlx5/mlx5_ifc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4df6d1c12437..09c50e786ff4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -552,7 +552,7 @@ struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
 
 	u8         reserved_at_c0[0x10];
 	u8         ipv4_ihl[0x4];
-	u8         reserved_at_c4[0x4];
+	u8         reserved_at_d4[0x4];
 
 	u8         ttl_hoplimit[0x8];
 
-- 
2.42.0


