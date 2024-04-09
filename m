Return-Path: <netdev+bounces-86256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8093489E31D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BC81C208E5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15232158D7F;
	Tue,  9 Apr 2024 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B+xN0Pts"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E11157E9A
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689794; cv=fail; b=V2MQRyvjLtN/xY12ALdOR0OW5Vvic4GJ0PqQOu200mUHYr2Ts01DZDNnPHlky8YKstkf5sKiFRESvXcwLjTtEKbNLw+7gz1tzuOuvFE+/TQQMHwhNHEzAmvll+a2Q0lUdUDI/R/bnlwWbsrup4YwFxFQQkvGHQjXJtcuqWNb2/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689794; c=relaxed/simple;
	bh=GhRlgmRJxig89GW80rrcYkis6bcEwu/Mb35WO+rt0fg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoOwQkl62Fs11UeqqbuiUCteyUpVuVqet9x/sFpdWJd8ljrywTfV1yfqY1NHPknzBPjilpxmldkKzWAaLhSQBEQWQjc4Ag7hhZ2e5p/jr61fW/z2wY8l4JWXxac65btW6IqfOohIgJkN3RnyxWzQKPg66XxtGdU+pqnDGSMSEM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B+xN0Pts; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJkhRUj613uUY35M8DgWO4FXcTBUuaAmPsEFYURRP5zamIz/XCdo0nfiBKOfjRWKe46Z3BOzH7DUQ1Q41mR4M3G0EgEJWbz34IPOVQzSzIbOa2CVStBm0RaPLV4QtQpWgEvPd6CnlEB6hAM4OKthN+4Gtqt0DjTPEtfIA+fAt9no32s7j9N2jVXAnHWXgrllF+qxXCVWo3e8RfPncjiWBKyGggcjqWo9jgv3dPIafK85IA5MO3ahsPxA2s1sJZEJBBcOAgUV/vA/jEtWR02SwY7xU/tJdVYr1/qEwfOVpd3UroJUU+xOMIhvBY9FVczn+BcJU5BoNMGYsvl5WmGd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R19iuGU9nC1tCNHpGbgimwQD4GddJ4M5V17Icb4JsbI=;
 b=C4EQ8VHJbBIxgKuu7lltectbPwDc0ZxiZo8SFGYlE9x8C1utLsYfCuvQ6zxHgbi3rtfD+LGlot9+UoUZ4kCLb2LY5swM4fCBvPbN35K8/VN52F7v1lZL72y1qOXvwwwJKWV/v0uIEYQ55THVVkBVRyeq+4rfkZYw4T29ufpbmCA6rJY+SVIzO7vc6ZjYzWM/tppXwljRqbT9Mama1G1332TEuKyFRgZS42oD7yAQsRECTstuN/oNbcQPCsRjW+88RmNzK7B5kuuiRhmOEh+RaWllAmebvNn3jXwGgioMKNAi8SRsqZk5PT3pxFgBHdNhey5q8S/8U8IZGFVecVaAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R19iuGU9nC1tCNHpGbgimwQD4GddJ4M5V17Icb4JsbI=;
 b=B+xN0Pts7yWEZwGMKyrkEez+iS5BlpmMkSWePNy3WZneGdYj5Ra14TX3eA7ZPReBQC+DhiMrZESRrzSZiZtHCavwpR8lkFDsRVbPutfWyYrMCa7CjAhSVrYnJCeHfw+Clu/adiqy5Adfw8VTwmkupygAK4iVR8l+3cZNhepjmjcAHHjWnu/1eAv4yxmPBAx5G2YWz5wMP+WoC7S2gWq1H36La+pNR3w8/nQiIccrJDWKGJyQ4M0ZvPX7XTfAOKG3iMDLWkv/Y9gHknFaDkNGLnnIc3Sc0hBZK2+mSn2bnAh/SBarbLLSNhAlL/RACSXtHy1ZZ/gZ/CeW052VjcZCLQ==
Received: from SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 19:09:49 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4b) by SJ0PR03CA0208.outlook.office365.com
 (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:09:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:09:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:09:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net V2 12/12] net/mlx5: SD, Handle possible devcom ERR_PTR
Date: Tue, 9 Apr 2024 22:08:20 +0300
Message-ID: <20240409190820.227554-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 6098934f-41b6-4651-601f-08dc58c8a092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vq+BQYet1zeE1CaNVt32bGYMt07W158KV601Ng+IRNtDQzYq34UYPV9A+2fNQzpN9FPMbHtg+wNh8giERheoEJyGwxG6Ih8VOb8LugjhYgVIpvhnTmnfImGY++wh8DO+2HrJlJZbP1QGMqyJ6qp4+IY+THQNj+fKtpOvY3diGDHTO8/pAYS2UMT8c22jz6jxrtWCoQhSCDUJW62qYLSZJAanKzHZhoPJkvyLOvwswxM+2mb3KxAesUhIWQCgpYNFZFiSLQQu2Gt3eGO0klwH7MBjhhMVuzjcBbwSc8tLRs7a5YyZKCzHU/aOh5YOmbXeNdwhzNyj7KW1Ch+9CeFn5Eqmo5LiyhrYpqvzA53D796KFicvw3+9jvHRo3C9/ZgXt9iByyIsLybxhtU7EkGYO0NEb4GnpHD/Fl+GVmAuZmGQk5qqrwRWfov+pqAcQXD75OYj54sRAbA1TD9GYxFdncxMqqgJQHQvIIK0ST/NLpi/jFhrMIDomIrTCui8Tum21DI0VVniQqVCTM/jbGKZmBhCkz3jQavrGVKJyZB54pvHH6IW4MPjyIZpaYvCM5oi6N2a8RpFzssuFdMXUXC/mFwxXFbohH7KvGiw0JgFF7J7mtYi+8D/zonGWEbpJQO86UCBCU5noMFGjsaHRgybGqx23hbAat7lgaRbmm2fEsw2TMyImMND4BrkEXLnFaMJLEFaGQNczIhR90g/Fu6Y9zqpYTlErBArGIcrgyOE+kgBSSENBrxBTltQXbksWg96
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:48.8856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6098934f-41b6-4651-601f-08dc58c8a092
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775

Check if devcom holds an error pointer and return immediately.

This fixes Smatch static checker warning:
drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c:221 sd_register()
error: 'devcom' dereferencing possible ERR_PTR()

Fixes: d3d057666090 ("net/mlx5: SD, Implement devcom communication and primary election")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/f09666c8-e604-41f6-958b-4cc55c73faf9@gmail.com/T/
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 5b28084e8a03..adbafed44ce7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -213,8 +213,8 @@ static int sd_register(struct mlx5_core_dev *dev)
 	sd = mlx5_get_sd(dev);
 	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
 						sd->group_id, NULL, dev);
-	if (!devcom)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(devcom))
+		return devcom ? PTR_ERR(devcom) : -ENOMEM;
 
 	sd->devcom = devcom;
 
-- 
2.44.0


