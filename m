Return-Path: <netdev+bounces-78277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2D08749EB
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65437B20C03
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146AA82C9B;
	Thu,  7 Mar 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/N9PnpO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10682C8E
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800958; cv=none; b=kC59jBxk/nC/FzDsTUNpqMtLhtuhPEtMi6WSv80YsY5Th99WrA3M8a/5DrFDGCSM0mIeN0uUjAaiidl4Z+FEPp4xzIftMuR+7HFbnuzeWLAdJ2PwhtDwYUeRzwxbdEXqhK++u94ttQRwatemSLBjZu2QfXTA28pwjMvG/4yefZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800958; c=relaxed/simple;
	bh=dZUIJ6qTmGMsXNXJr8cZklYFs8zd3RZybmrnj2lUoKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgSIDjvLSR7yh5wsoX2KW7jPRhyj3UMkhRuA2OOEl2pvhUsdUdgy6DDOS09PiH2oTzr4ksvg0etwTM/QV/eEdvvmmXujONzXoVoyjkOPM54gU6lrxg+Nr2uFeiYEMZ8GYaeTzlYm07Kc7EPPSAqsvQcoDbIhswK6tcefXD12SKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/N9PnpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3870BC43390;
	Thu,  7 Mar 2024 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800957;
	bh=dZUIJ6qTmGMsXNXJr8cZklYFs8zd3RZybmrnj2lUoKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/N9PnpORm8H140nOFL1goQObRhqvKYr2NEUUbZn8N/eBIzqNVDeML12BLrr+WjeG
	 gKLgRImOwxHAe/j38QtehtUUszN7vss6l2JZ8ioACI5rx0o27jXqj0vj8x2GQ4ZEuh
	 nGkWR1I5LE8ToJTr/kYx0TH4OAd9AiTDKGqv+64jyNt+3/J/P1sa+EJXJV4zWRp/ph
	 ZcqFJdmPOPmnMWkeG8IVXxTHuSTxFLptUechLTB7ozM79SOW7ZHwNUEfRwdlrKdjf6
	 +c24enzOdhDsB2eBxQiFsEFB2UcVUmhS+GiJt15xzTocfwzTdHje4cPdXKUTwM0kz1
	 Lv4BbrrMnfvyA==
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
Subject: [net-next V6 01/15] net/mlx5: Add MPIR bit in mcam_access_reg
Date: Thu,  7 Mar 2024 00:42:15 -0800
Message-ID: <20240307084229.500776-2-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307084229.500776-1-saeed@kernel.org>
References: <20240307084229.500776-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Add a cap bit in mcam_access_reg to check for MPIR support.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 628a3aa7a7e0..2756bdb654b4 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10253,7 +10253,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 	u8         mcqi[0x1];
 	u8         mcqs[0x1];
 
-	u8         regs_95_to_87[0x9];
+	u8         regs_95_to_90[0x6];
+	u8         mpir[0x1];
+	u8         regs_88_to_87[0x2];
 	u8         mpegc[0x1];
 	u8         mtutc[0x1];
 	u8         regs_84_to_68[0x11];
-- 
2.44.0


