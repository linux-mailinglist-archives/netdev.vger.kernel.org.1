Return-Path: <netdev+bounces-77741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC51872D27
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3101F24572
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788DDF5C;
	Wed,  6 Mar 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEeGkLBT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424DDF51
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694186; cv=none; b=l8Wz8vHGdjTVZjr5cu5MowGYhJ/g8UAEYSflOb2UWjTzfHBnVNbhKZE08aUXlgYqm0ijlpZPRjuQnhGmtKvbHe5cU6IjrAl6lHqAckf4ckgdxtWP7nBMzYEr+hW+G6kir8TAMHvjdg7GUlquVYM8n7PI3sCci9WemIgPBiZSkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694186; c=relaxed/simple;
	bh=dZUIJ6qTmGMsXNXJr8cZklYFs8zd3RZybmrnj2lUoKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek2rwtzS1NIVnB5aZr6HRT37A+UTixu6w+1cq6zGu/8eysG/fimyw3dF7SjPyywca18V/Rz6Mr3CNdGlzK6OJ9mNBy5/iLeC/b+OIXPi88HHK/bMl0ntxbN0CLIY+gQzuaeS33zifkQIlp6rmv1X4lNujvKnkwVlHuJI6ydyjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEeGkLBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A798EC433A6;
	Wed,  6 Mar 2024 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694185;
	bh=dZUIJ6qTmGMsXNXJr8cZklYFs8zd3RZybmrnj2lUoKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEeGkLBTZ/OXpltpFyRcryEnUL+IC3yFP2AUUGEqbvN2ZFrs7vEgnv79k17Bfotex
	 NGU4NPyPw96b/216ZlgZs7R8499E85mLYNK93ENu2ThuGw9kb9WihhzxZiCFFej1FF
	 //2rXm9fr7D3SB9LhYEOuPOkxfdQF5d+A5A/whxrbank0Z15jBP/F2eoZSAy7AD9n+
	 EtilXn5XKk7ANP/QgpIy+ztUQN6dOD4/THhJpf1FKSlmVQCp/9JxIJyUcQ971eJ8Qb
	 AJ69GZCrXpIZwjjIgLge2VOfQPpXKBHT0eam65/BtmYgX3tZOtpaVzlyHg8y+UgFeA
	 E9X9013u9vCJA==
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
Subject: [net-next V5 01/15] net/mlx5: Add MPIR bit in mcam_access_reg
Date: Tue,  5 Mar 2024 19:02:44 -0800
Message-ID: <20240306030258.16874-2-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306030258.16874-1-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
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


