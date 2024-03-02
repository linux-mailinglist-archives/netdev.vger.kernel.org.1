Return-Path: <netdev+bounces-76797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0686EF15
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CAFB23902
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850D2125AC;
	Sat,  2 Mar 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR24QRRj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3D125A9
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364197; cv=none; b=OatthBF/+D4I/LRGtbab5TCC+cLh6KBW4TuuZTVCCZ2QkvSmiFlhSGuj6gPsxR7cxJ/VX7S9ytIcjr5fls4f8I28PWglX2Qjl9BE1lMqgGBWa/Gtc77K9gnJSRV7sXq5VF6P9JZBKmZhPhzovZBXcjQdtNhHVux6ehNdvbWKU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364197; c=relaxed/simple;
	bh=dZUIJ6qTmGMsXNXJr8cZklYFs8zd3RZybmrnj2lUoKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkt4lndlSqHKYKEaerthLeNMALLhqEkSiX8E69Qt4Js88+726AC8O6bg1jQV4NwNokhdgGUoZXMu/g59vrFw0mBsyv2JBzp8dyaohxRGUPJ05hex+lv0ktKZXP0z03eVIKktf3KrV82OdbDBcTjPue2gol7u3IvrpeD8Ce4NaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR24QRRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32AEC433F1;
	Sat,  2 Mar 2024 07:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709364196;
	bh=dZUIJ6qTmGMsXNXJr8cZklYFs8zd3RZybmrnj2lUoKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oR24QRRjoMrnvH2xA0IyTO8UKLPun5u4Hj4MT6dI6ddfRN3Sj9VjRFsvO/CxyF6nv
	 vS6Zdo1+NCngnLVU/WibFhfD0ORhx670/vTAKKY3FmWfJSk5BeRao44076tMr+0HJy
	 gFjlFC1QYnljch0Q+iJFPubzB99CXotV4NNARvSZLL6nf25KlpVKu5e+cviZ8KQ7tt
	 6umW8aloMSftC/ypbXpz8ZRmrm9wRMDBwMQhRDiKKPHjjA9mX6v99xNpmTQTqkTwos
	 +Xrkj7RDw3ak+iU3LHETawlrcGvHugL/GWz3qJ40EyAgWraBXdHTcVhX2RK8O5YU8C
	 czMdsU5SJoZtA==
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
	sridhar.samudrala@intel.com,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [net-next V4 01/15] net/mlx5: Add MPIR bit in mcam_access_reg
Date: Fri,  1 Mar 2024 23:22:31 -0800
Message-ID: <20240302072246.67920-2-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302072246.67920-1-saeed@kernel.org>
References: <20240302072246.67920-1-saeed@kernel.org>
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


