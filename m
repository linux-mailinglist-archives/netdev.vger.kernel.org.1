Return-Path: <netdev+bounces-76802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A586EF1A
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60A72860BF
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF11400A;
	Sat,  2 Mar 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib0EiWcH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34711428F
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364205; cv=none; b=aLmREfsyY1j2zxKXvNNon1/eLg8NgqMRuWc/tHwzJd3dNlVbDxPLQldBVzwIQ9bFG6XpKTSP8f6glCSOMR6z7IHkTLaaJNAksZd1XcBEImRf6+8ih7Z8A160z+p0ov6ocMSqdhYwgaJ3G/untXz/jHGBnmxZ3PiEgYq4QQCzQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364205; c=relaxed/simple;
	bh=aJO7z7J6QkZg90C6iQiXeOQf6XCLg+xoSnpEi6kPRiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIHkiCIH5kbrEbTVZ44PY+JnMnmFRfjeKKw5vpRbUT8t7V9CveFIdbDKFoPqIyxLFO3NOikn7OFonWJcfHa5tRNK4frqrJFzeaCtnFu/6nsTvxyl5tJnPuD6aHRqlwZtMlXrtrtNqU5WpNrWASDZEKITe9RpNIzOnNULopvN9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib0EiWcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5397FC433C7;
	Sat,  2 Mar 2024 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709364204;
	bh=aJO7z7J6QkZg90C6iQiXeOQf6XCLg+xoSnpEi6kPRiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ib0EiWcHzl1+aopBVGOEAwFt8un6V3DDTpy3pn93SuCMzzBpVt21R13bdVv7/edyz
	 qezPrkgukjqKtxqHiACeIc0D4qu3j/Xgxzmr7i4XIlGiVXY0Yfyt3fntjN8fYq/6tY
	 HXm/d/3nFR4zg9TvfHDo63F0vJs8AOlGL1KqgfDzkeTQbi46QT7DVEq3/AtM/evCUt
	 E+6RsHb8Nntj7xvgRSIElHM1ybrFs3f93VjKjDMGdGNr4/FNracSdkEZm+9kWVcmLI
	 elBywmGShVJTUaDUvbk/ydkephXrG67sDyyHltRUJASR65RSg6CAR2LLWeJ/5+C3Wp
	 b5ukvONgB1ChQ==
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
Subject: [net-next V4 06/15] net/mlx5: SD, Add informative prints in kernel log
Date: Fri,  1 Mar 2024 23:22:36 -0800
Message-ID: <20240302072246.67920-7-saeed@kernel.org>
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

Print to kernel log when an SD group moves from/to ready state.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 76c2426c2498..918138c13a92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -376,6 +376,21 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
 	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
 }
 
+static void sd_print_group(struct mlx5_core_dev *primary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_core_dev *pos;
+	int i;
+
+	sd_info(primary, "group id %#x, primary %s, vhca %#x\n",
+		sd->group_id, pci_name(primary->pdev),
+		MLX5_CAP_GEN(primary, vhca_id));
+	mlx5_sd_for_each_secondary(i, primary, pos)
+		sd_info(primary, "group id %#x, secondary_%d %s, vhca %#x\n",
+			sd->group_id, i - 1, pci_name(pos->pdev),
+			MLX5_CAP_GEN(pos, vhca_id));
+}
+
 int mlx5_sd_init(struct mlx5_core_dev *dev)
 {
 	struct mlx5_core_dev *primary, *pos, *to;
@@ -413,6 +428,10 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 			goto err_unset_secondaries;
 	}
 
+	sd_info(primary, "group id %#x, size %d, combined\n",
+		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
+	sd_print_group(primary);
+
 	return 0;
 
 err_unset_secondaries:
@@ -443,6 +462,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 	mlx5_sd_for_each_secondary(i, primary, pos)
 		sd_cmd_unset_secondary(pos);
 	sd_cmd_unset_primary(primary);
+
+	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
 out:
 	sd_unregister(dev);
 	sd_cleanup(dev);
-- 
2.44.0


