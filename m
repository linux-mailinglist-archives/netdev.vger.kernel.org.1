Return-Path: <netdev+bounces-47487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744727EA68A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3093D2811ED
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11D3D988;
	Mon, 13 Nov 2023 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9WtHaBj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBB3B2B5;
	Mon, 13 Nov 2023 23:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75249C433C8;
	Mon, 13 Nov 2023 23:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916481;
	bh=a5TEmxZGsOjS/GgOYsqRiQG4AzGI2qCqIVQQVx91tgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9WtHaBjxgZNRRRepi52KJnSqhpFkrISdLnHrYri6TTUMC0dkp5hIlSswUwYY+615
	 VJgifQy9ZECPYLd30+p2eF1w9UhA/atOKRXqnkPW0sS66wrfk3CsvVbPlymSlPFfBZ
	 vjObbevHr7UNBilp+T3qWs9D729WNg/smkw4oz55ioITTgryiYnefHaY1HLmi4Mcw+
	 NIQ6dKxXiYJTJM57wvZkePlPX/8OSmghlUX5Hmt1dlg1uVqeeV3fXxl0vLlNwxNnBu
	 IGxZdGJQX73KNZdooQksc8520SiAANdLiIrqSa2c8QWbu7rmImilmh6Jj0zSeKfpMN
	 RfSIWWOTuOZqw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [net-next 06/14] net/mlx5: simplify mlx5_set_driver_version string assignments
Date: Mon, 13 Nov 2023 15:00:43 -0800
Message-ID: <20231113230051.58229-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230051.58229-1-saeed@kernel.org>
References: <20231113230051.58229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Stitt <justinstitt@google.com>

In total, just assigning this version string takes:
(1) strncpy()'s
(5) strlen()'s
(3) strncat()'s
(1) snprintf()'s
(4) max_t()'s

Moreover, `strncpy` is deprecated [1] and `strncat` really shouldn't be
used either [2]. With this in mind, let's simply use a single
`snprintf`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://elixir.bootlin.com/linux/v6.6-rc5/source/include/linux/fortify-string.h#L448 [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 20 +++----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index a17152c1cbb2..bccf6e53556c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -219,7 +219,6 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 	int driver_ver_sz = MLX5_FLD_SZ_BYTES(set_driver_version_in,
 					      driver_version);
 	u8 in[MLX5_ST_SZ_BYTES(set_driver_version_in)] = {};
-	int remaining_size = driver_ver_sz;
 	char *string;
 
 	if (!MLX5_CAP_GEN(dev, driver_version))
@@ -227,22 +226,9 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 
 	string = MLX5_ADDR_OF(set_driver_version_in, in, driver_version);
 
-	strncpy(string, "Linux", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, ",", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, KBUILD_MODNAME, remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, ",", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-
-	snprintf(string + strlen(string), remaining_size, "%u.%u.%u",
-		LINUX_VERSION_MAJOR, LINUX_VERSION_PATCHLEVEL,
-		LINUX_VERSION_SUBLEVEL);
+	snprintf(string, driver_ver_sz, "Linux,%s,%u.%u.%u",
+		 KBUILD_MODNAME, LINUX_VERSION_MAJOR,
+		 LINUX_VERSION_PATCHLEVEL, LINUX_VERSION_SUBLEVEL);
 
 	/*Send the command*/
 	MLX5_SET(set_driver_version_in, in, opcode,
-- 
2.41.0


