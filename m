Return-Path: <netdev+bounces-78144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD92887436F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C951C21769
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9891C6AF;
	Wed,  6 Mar 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FVjVC9VE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEC1CAB8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766303; cv=fail; b=gNwiI51RWmkdU4/wTwPKAGyptQ7J1P12c80OZ9tB/ZXmmPDWEyBIz1SDLVp9DQqnIJ7l2F0t6k8pN1Pi5TrA51BzKInOdZiQNrRO18ObeqX3GPNGCco97J6O5r6V8hftIl//f90uZVmhC94uZVwfMQ7T4jhrjGUcPq59jGtKQQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766303; c=relaxed/simple;
	bh=aUJBokLmRa5bfYgc5CuWnKk7pP/GeHHjdCZYf+hcKgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=redgWv1e5AgDqGGEF7E1S0ewiNUMj1Vp3ax7k+gcUB7twMVn7eGXi3THzsiljjvWx/zsgVYyGAsxlJDIaD8ZpFHWpuAOH0cFPX5gDQCOD+04bCBT3L7Prml3CYPgoHBIwIEEA0zHzGBuEWPXdsnIv6mZovRkpZaAbOqKOUwWrZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FVjVC9VE; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e62sPsP4zf1RHSxzmiUzq4KQiX26RVzvvcmD2cCYQ8S2o8b+H5+IgA44FS0xqpdAP24dq8V66PTJPVR76a7QzXkTdUCyv7z8aNRor0BpHpDyNWLKeeOY7PgiscnmGYDkrVnQupIJ6A12YmRUejH9d80+3+ovaOTd9sbALYYlG9dM54iEQrPOt1Ln6YPs9eo0jOja5Imx17hCgnZSzRO+3QeVOs5Bd79YY0imxz3UrkAXT6sbk9+l7wwHbzJmtDBJdqVX+EpY8Sg3/E6qvnom14zcpPIYcGkj0cVbsrXdJ1tGHNeA5KsoXOItYGnXulJZSrYc0Lm3nf1Ll+kBRfYIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2V2u1UCj1qYe7b2COO6gLyz9icTAHvCPi4D6IFYnWc=;
 b=Jg4GsdypEs62q+zAxdxnXQEoE5gmhlfY9T/mFQz0QtziIo+vfStdaEksaBpUG1c88Huj7x6T3JZumupUVCtFCFi/gRcEfaT5O83oYaImklzU9oh/47UzSrfUQLyMwYa166QsRq0KhUSdyDNvuXekwq9BCU3VtWH8R0ofjXgvdvY8dZT6vdHO/mClrHjc65DdNkjJQ44dmv6AsTA+iRdsMCHfaadGy6qcBwHw4Dlhxb7EQkpYBuMGFQOkeo1Ia2ZfSfIC9GYB+to9dawITcWKAcSzF0r2d3ewKkx6FwhNJJWLXAin6TBlRgoofY+daSmkhTWjczO7f+1Xz1c6qXIWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2V2u1UCj1qYe7b2COO6gLyz9icTAHvCPi4D6IFYnWc=;
 b=FVjVC9VE5bda5jL4A09G8Cunh5hJaYPd9Seg7sSok18AgnTERK0Gcz7aysD6I2weaeHM2wm+VC+Btrh+4y6NRMJhu9gf+nXkpiVXQXuMP1QC6Ko6w48u9vMKtH4D/bDkkiKZ1WOWfMvMfXLDlF54/4JUqfRk6PiZzg64/Blgc1V6cBwyZlW/2RDXxEZ/i6BB3udCL7rxDzLugu5YkyVfhskAMIeoZdyKqvfbALJ7QbGn507EhgnnufE6BvvyhZGbOVNeP/uMWNcuKTyMsnqc+8OrO4lLdN8P5SovGX0/Yx48Cp8Ll2YtQssq/+qzNwmrnDmQdu+tzbHORRopyR8zRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:04:50 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:04:50 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Nabil S . Alramli" <dev@nalramli.com>,
	Joe Damato <jdamato@fastly.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC 6/6] net/mlx5e: Implement ethtool callbacks for supporting per-queue coalescing
Date: Wed,  6 Mar 2024 15:04:22 -0800
Message-ID: <20240306230439.647123-7-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306230439.647123-1-rrameshbabu@nvidia.com>
References: <20240306230439.647123-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e56759-c77c-42d1-c226-08dc3e31d27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DrUEnMhqzRmwTVr70Bo/uiCtxR0IGxnyBg7n0jFWqfUMEQ0R4nhDJy8yGobXbNSlXRgBegBdKuxQvNPA06GiSjdXyDlDUts0gXHn457K1u/vlGZJW0BNoa72CSZYN8b+NzQ/fcz/Qdd4HS4Sj5kKEkZRzMJORxklvYRcuiG5barScPbxOelYN47fxcc5vepHCbMRytUmXa5Mm+ob/5H4BPMTmAeLdO4/KNNTnlMMiCCsuR6Mom0cdARaNmhwVXqt4K7AL9g2GTq7FxLQUSBAZswEF0jJXxqPMDsIj72nNerYlDnBoOmfTB+2iA+w5A/E8iQdt3JeoiLIHZ+nmc+dRFKeVsTLJJsjkFQ5ArQadvydUIbU98DAoyodVmHdkM9+cd2IFotJV3v6Tk4mbckEy3QRcYbPv8fHYeKimLn2/e9uxh8Z8ufJdK/+E/be2e43kYYN8b3WBBegOXsalankUxYH5qfmP8nUTVUe0TFLWTcMwuH9iw+HPs0aQmxTskGBgSuS9ClGjSB2YwfE4jpD2Yw3km0jZq5LiiyLb67s1U7ZktbsaGczBToVm1jK3hkyw4PuRXTT/Mrg9d2R0THWdwccTdbqRo/2A1/j8HloDyD3bXzNCuw97tfMJYcKRcd3cxy5XypKMUzxW8k1kwoAWFPGe6QNndRZdvKrNF5OXjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yoGmIQUo6oVMrFbS4Kx1R2gBeQKiL1Tb0kzHYc1z4pPdZPHYKw9v7f5XYvWQ?=
 =?us-ascii?Q?Xm2obFfiZFU3NPfHek/IVSii1wDzyt2pw6Bb4BCUsL2xkWbF9SisGzvGqkuK?=
 =?us-ascii?Q?kjHTRXc7yMLTbWKYNfDamPi+9GIdTrQRnNrDmh7Ak5kJ2x9cgBAx+4nGj3Vt?=
 =?us-ascii?Q?jbOEjEw6SYr9Koi52WV2WJlGiy3Q6gsqYRVjTMKzBgyh3jJMG0IRbbqzVc7q?=
 =?us-ascii?Q?Jjz4iM3TUvJAua+q1D/x/4UZJiU+OjJTGUVYuxpTGnFBKFsIpI8sFadSSBsE?=
 =?us-ascii?Q?HfSZhelwW4CUBc87dUduagR7VAChWkgDzZDHosBCTnY4ft5asDyq9P5ZZHkF?=
 =?us-ascii?Q?TVB+sIAHXBbPwl9fhnHz5jEALzo/sX7XPkPdlNWF8OJ7aRcMEOHI00FVExxi?=
 =?us-ascii?Q?6BKFWpPvr2Y5sNyWeVi8B2QFrDFIyJvMSM1eJmIWxZxu202iZavJOhN8ZmFi?=
 =?us-ascii?Q?SqOZAYxX5GH8Hz7lhKo99ec+6V/pscdzOMfhd7xNxTE3HCEZ7ImWpkw9c1cq?=
 =?us-ascii?Q?I9cqLY+/S58ZPwAdnOdhmkN/l+MFidAPQFmBt4dnGy5MkPZko1MvgqLvjZD3?=
 =?us-ascii?Q?2KpU/lJdElN+365rdyWieQCLq31gjC9zLlLyVdrQLINWxJ8spXpflbECOF5K?=
 =?us-ascii?Q?BWJP3lCtkMG1qSSlY3Mx/RE53LVRxUmqrHa51K0FchdbWSlb5FVln8SWZbt5?=
 =?us-ascii?Q?iWnEuedhAk9KfezSzJotrVZDAFIjRpRDfaTD09tde5h+COoVarqp599vEDj/?=
 =?us-ascii?Q?5W6dTM8IkBp1wyZn+djkAzFqlm7//XsETPxR0t4GqwMJlHIunatUQHBb5ZY4?=
 =?us-ascii?Q?DLKGj4/3WoV/+otJ2cmsMYpYXR9puWuvI+eYKqA8zRxz4qKwYg+l6K8dFe+N?=
 =?us-ascii?Q?aXoAJkDrHYzPeMbWRs6mxwcVEH0AmKiowS2a+VreGu10gapf3A8roX+68Jni?=
 =?us-ascii?Q?poLRwvtTC6i3C1d3UiTuJpSdGsFxDfqw2O2LaMYUa2wWUo1W9fZEL22Uvzxu?=
 =?us-ascii?Q?V4NCP+W6chEoBMPg1AnprSzRLzEdg9zyZJ9ZBJuFpyrrKakGE6gPcIHl7PgG?=
 =?us-ascii?Q?LExtY2EULflUG1iXFLv7JsRDXjwMVrQKabELYi99HSc9wCI8hdQW+AMu0DCa?=
 =?us-ascii?Q?qmdqKe1++9He7Y/CKcsN7Oud2bo/PawbMrJ/iXlJ1O37wMGuRDGkKxF4xCQt?=
 =?us-ascii?Q?jO4SYWE4pyTDdWq9Viovx1GAQ4vOlqiGVYJVBgwC0dIErHSsAVBOtiQMIWZE?=
 =?us-ascii?Q?VjTICm8Epj0SNDnJV/mbDKIE7jNPpPmMKQsNKiiYS4zBAbUk49tg9M6Qowlk?=
 =?us-ascii?Q?cIg3OvM6nMWknbDQ3HhE8gOfMzf4NJJ+3SaPv/Rq92mZ3QL8hjZ/xco+B7tm?=
 =?us-ascii?Q?xWUs0rzf3wBnFZOlXvqmSaG65/AXq+4n86WN7ExrYyHKMa+RCmzwGficQ9qN?=
 =?us-ascii?Q?wpnJCabb6G8+zabMjFOxb7aZNrSvRBHbeaPzFM5Qttx+8EJikb82tEr4ESMq?=
 =?us-ascii?Q?OUMludcC2B1IkP9EmUDmNB5qSj287NRbMLega+Rok2gCW08CAjm8BtKyaGxI?=
 =?us-ascii?Q?dTHpBQMkVhNYPgVx8CSKK3oVH26LrScLM2QUCxpXF7tghoOHeK8T0cGxHEhw?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e56759-c77c-42d1-c226-08dc3e31d27f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:04:48.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJgMxcdND4+KhWbZOmClEWaCi4lJsJE2AHFhKQu4Tyv1arUeU3S8kmyiTSWlXnPd2nNrD42dnXBlhq7cKyakCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

Use mlx5 on-the-fly coalescing configuration support to enable individual
channel configuration.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 139 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +
 3 files changed, 145 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index be40b65b5eb5..1352b07833e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1203,6 +1203,10 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
 			       struct netlink_ext_ack *extack);
+int mlx5e_get_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal);
+int mlx5e_set_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal);
 int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
 				     struct ethtool_link_ksettings *link_ksettings);
 int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 422fb0f16af4..51df721ee229 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -555,6 +555,70 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
 	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
 }
 
+static int mlx5e_ethtool_get_per_queue_coalesce(struct mlx5e_priv *priv, u32 queue,
+						struct ethtool_coalesce *coal)
+{
+	struct dim_cq_moder cur_moder;
+	struct mlx5e_channels *chs;
+	struct mlx5e_channel *c;
+
+	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&priv->state_lock);
+
+	chs = &priv->channels;
+	if (chs->num <= queue) {
+		mutex_unlock(&priv->state_lock);
+		return -EINVAL;
+	}
+
+	c = chs->c[queue];
+
+	coal->use_adaptive_rx_coalesce = !!c->rq.dim;
+	if (coal->use_adaptive_rx_coalesce) {
+		cur_moder = net_dim_get_rx_moderation(c->rq.dim->mode,
+						      c->rq.dim->profile_ix);
+
+		coal->rx_coalesce_usecs = cur_moder.usec;
+		coal->rx_max_coalesced_frames = cur_moder.pkts;
+	} else {
+		coal->rx_coalesce_usecs = c->rx_moder.coal_params.rx_coalesce_usecs;
+		coal->rx_max_coalesced_frames =
+			c->rx_moder.coal_params.rx_max_coalesced_frames;
+	}
+
+	coal->use_adaptive_tx_coalesce = !!c->sq[0].dim;
+	if (coal->use_adaptive_tx_coalesce) {
+		/* NOTE: Will only display DIM coalesce profile information of
+		 * first channel. The current interface cannot display this
+		 * information for all tc.
+		 */
+		cur_moder = net_dim_get_tx_moderation(c->sq[0].dim->mode,
+						      c->sq[0].dim->profile_ix);
+
+		coal->tx_coalesce_usecs = cur_moder.usec;
+		coal->tx_max_coalesced_frames = cur_moder.pkts;
+
+	} else {
+		coal->tx_coalesce_usecs = c->tx_moder.coal_params.tx_coalesce_usecs;
+		coal->tx_max_coalesced_frames =
+			c->tx_moder.coal_params.tx_max_coalesced_frames;
+	}
+
+	mutex_unlock(&priv->state_lock);
+
+	return 0;
+}
+
+int mlx5e_get_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_ethtool_get_per_queue_coalesce(priv, queue, coal);
+}
+
 #define MLX5E_MAX_COAL_TIME		MLX5_MAX_CQ_PERIOD
 #define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
 
@@ -721,6 +785,79 @@ static int mlx5e_set_coalesce(struct net_device *netdev,
 	return mlx5e_ethtool_set_coalesce(priv, coal, kernel_coal, extack);
 }
 
+static int mlx5e_ethtool_set_per_queue_coalesce(struct mlx5e_priv *priv, u32 queue,
+						struct ethtool_coalesce *coal)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	bool rx_dim_enabled, tx_dim_enabled;
+	struct mlx5e_channels *chs;
+	struct mlx5e_channel *c;
+	int err = 0;
+	int tc;
+
+	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
+		return -EOPNOTSUPP;
+
+	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs > MLX5E_MAX_COAL_TIME) {
+		netdev_info(priv->netdev, "%s: maximum coalesce time supported is %lu usecs\n",
+			    __func__, MLX5E_MAX_COAL_TIME);
+		return -ERANGE;
+	}
+
+	if (coal->tx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES ||
+	    coal->rx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES) {
+		netdev_info(priv->netdev, "%s: maximum coalesced frames supported is %lu\n",
+			    __func__, MLX5E_MAX_COAL_FRAMES);
+		return -ERANGE;
+	}
+
+	rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
+	tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
+
+	mutex_lock(&priv->state_lock);
+
+	chs = &priv->channels;
+	if (chs->num <= queue) {
+		mutex_unlock(&priv->state_lock);
+		return -EINVAL;
+	}
+
+	c = chs->c[queue];
+
+	err = mlx5e_dim_rx_change(&c->rq, rx_dim_enabled);
+	if (err)
+		goto err;
+
+	for (tc = 0; tc < mlx5e_get_dcb_num_tc(&priv->channels.params); tc++) {
+		err = mlx5e_dim_tx_change(&c->sq[tc], tx_dim_enabled);
+		if (err)
+			goto err;
+	}
+
+	if (!rx_dim_enabled)
+		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
+					       coal->rx_coalesce_usecs,
+					       coal->rx_max_coalesced_frames);
+	if (!tx_dim_enabled)
+		for (tc = 0; tc < c->num_tc; tc++)
+			mlx5_core_modify_cq_moderation(mdev, &c->sq[tc].cq.mcq,
+						       coal->tx_coalesce_usecs,
+						       coal->tx_max_coalesced_frames);
+
+err:
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
+int mlx5e_set_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_ethtool_set_per_queue_coalesce(priv, queue, coal);
+}
+
 static void ptys2ethtool_supported_link(struct mlx5_core_dev *mdev,
 					unsigned long *supported_modes,
 					u32 eth_proto_cap)
@@ -2425,6 +2562,8 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.set_channels      = mlx5e_set_channels,
 	.get_coalesce      = mlx5e_get_coalesce,
 	.set_coalesce      = mlx5e_set_coalesce,
+	.get_per_queue_coalesce = mlx5e_get_per_queue_coalesce,
+	.set_per_queue_coalesce = mlx5e_set_per_queue_coalesce,
 	.get_link_ksettings  = mlx5e_get_link_ksettings,
 	.set_link_ksettings  = mlx5e_set_link_ksettings,
 	.get_rxfh_key_size   = mlx5e_get_rxfh_key_size,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 92595ada1f70..c4ddced8eccb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -396,6 +396,8 @@ static const struct ethtool_ops mlx5e_rep_ethtool_ops = {
 	.set_channels      = mlx5e_rep_set_channels,
 	.get_coalesce      = mlx5e_rep_get_coalesce,
 	.set_coalesce      = mlx5e_rep_set_coalesce,
+	.get_per_queue_coalesce = mlx5e_get_per_queue_coalesce,
+	.set_per_queue_coalesce = mlx5e_set_per_queue_coalesce,
 	.get_rxfh_key_size   = mlx5e_rep_get_rxfh_key_size,
 	.get_rxfh_indir_size = mlx5e_rep_get_rxfh_indir_size,
 };
-- 
2.42.0


