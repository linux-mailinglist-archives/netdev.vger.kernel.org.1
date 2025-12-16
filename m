Return-Path: <netdev+bounces-244940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A846CC36B1
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADF2F3011B22
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA8364EB9;
	Tue, 16 Dec 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jacna8Cr"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26AB364E9B
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893780; cv=fail; b=Q3cGqm0roPG+C0J1R/CfAp+3AD8NBHL6PF71XmYmBiaa8ZMKqFbuXDEivOiJxBTYxZ9HTrMclPS1hnweSFAqXvm/04675Ql9aqMZvyPxOoqg7Rbm0EduI/MP5cMFXeeo6jkXc1kNVlCojmWqet3UraRT0a/RbgTRcgBgFgBEwpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893780; c=relaxed/simple;
	bh=MQDK6hkXRFWxKG+SW77cjwPUQf602J24j0jYdomD7/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLXuE6I5v5EKUxrvmLvVyat8V2ySFcdFPAXSwRtkXfOY6n5DpoeEg1SxBlMkwbIJtdllKnHFLw9Jv4VpuXrEcfnu5MtP1b0/LI1qL79aSIeLhrp9z9ILxHH/mYV6SgZrBi2iGfEPIy+yUsC4KwTnT/VRj61xeQVRbZtqbJRmVgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jacna8Cr; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkEz0wk6/t+1CJYkb3H6bL38tJa4wSPtchPFWOmuxxbIRac7S8c436k7kgN0Y8rwHYtJ/tyC7vY0SnAoMmfNLiXNgdbzcTSado6oyup/kbnykdGZn/q5wQb6hinZNWz1ELs3NNxbfsQqnQTljTG0dBlX0rKcZxufX3i2/shKsfDpGcEFkcrObmR+V2C2iPGISjKlrg/yPEfz9G6qfd74/Ug+J9cpMh3qqESugk35gOvzOvp2xLHIZXZEVKSv4H02XRuqx2fopx3Ms2e/uYWQxeBy3UYbXoo2vzApENcBWYuTOlv0dPoBqx2jG26WUCER8IGB914jlicdQZ8alxY0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcLJiptzTWdX1xU0yqsOtFe6qhZLCqwHfS1PkWTK2yg=;
 b=y0meewtrGKB8GV42+4sIxe4LQPpikfLv7KNGW9aUK1TY8kQlQch6rS17Fgs2HwcP1as5tEKBNNlwman3b3VHgDdsyoXqnomDUupnRi1CBEXRMJAeEv4vkzrmxcKmf7xf2meeEY6/EV1/1bHicrB4RtVjnXOLKLgTkNEbIiIGzg39UrEUHyawd2vSIdaeH1iimEEoWlAtHLtEiCAZaBzCtjE1EPxTBHaZIzKfQTdzBPOzVe9SriXtbDd2Ky+7KXt/FpsbTkLrf2TOeoWLQsPvuhseOZBqRwj15E7ahOUYvE5EqJizoaOqkydL8YJDcXaL4SxgXLAYmlJgHA+ov2Yb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcLJiptzTWdX1xU0yqsOtFe6qhZLCqwHfS1PkWTK2yg=;
 b=Jacna8CryKeUaK3D4+PmWEnyxfAK0apNMLGrnVs9AP/2b/rRKpI+nsHPnjnxMaJeuGXWN9yn5srdvmGEhFuw4B7nDrMa1CV9lPQgtyO2C8RGG6i0/VJh0buT/X1g/BHiQjkS5j65xy1u6AqlqarpClYiFiRjP6/W8o1aSyZSzk/3ecCAP5GPr8uqEpkJb33udPfBG4N9QUMheS+GseZAO1g+9B7IYShfJoDftB/yDNkSH0232b2QGOUf+NCbdYepenuaH6pTvL5XK1JFDjDZLmu+hGPZKZkjoXwbQC8BWrvkrrnSav/WJhAgx/Z3VGKU9+6NsG259s00tL1RpEAemw==
Received: from SA0PR11CA0187.namprd11.prod.outlook.com (2603:10b6:806:1bc::12)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 14:02:53 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::9a) by SA0PR11CA0187.outlook.office365.com
 (2603:10b6:806:1bc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 14:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 14:02:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 06:02:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 06:02:30 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 16
 Dec 2025 06:02:28 -0800
From: Gal Pressman <gal@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>, "John W. Linville"
	<linville@tuxdriver.com>, <netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ethtool] ethtool.spec: Add AppStream metainfo file to %files section
Date: Tue, 16 Dec 2025 16:02:38 +0200
Message-ID: <20251216140238.3770737-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: 60641f5c-96fa-4302-4370-08de3cabce82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4A2ZNypQ3FZcLu2ZqN/EkKwUcfpIIrItNp73icpyyUfQI0I9ZIaKNNbXkOz?=
 =?us-ascii?Q?fFp/zrd55BT11BrQ+CROZ4XAn+4oORq2spIdVkhBcbTvzvxQ6k/3OHteEyb7?=
 =?us-ascii?Q?SDJg+u8lnKu9dJNiQVXGpsIBQ2Z2m8tjPpB3eITsFpF51gqHrFnAlbq2Pnlu?=
 =?us-ascii?Q?6loIWrbeVZsslffqITzYXAtyF1PggdwDaAsrjPkih504fyRE6b5iNb78GW3q?=
 =?us-ascii?Q?Hs+8eZHNG2xFGP4SA6O+kqdjqP3W1s74SCnqbTpkMaqAXrQj8Vcq8ww+9p4u?=
 =?us-ascii?Q?k5wnKs9Wljsre5rczKTS6pmieNrAe/8h2o28u9moSAl5QLpn91kmGOjGPlh2?=
 =?us-ascii?Q?j2lX1A0c6Y7d0TGkkLMHUW0tCiR+U74L1ZcA8kamrzDXL9IvU8RqQBhwlOy1?=
 =?us-ascii?Q?mZJmZ16LV6EMmxcuHLoFHm7T4t6IGKgxKAItvXGRh2IUnhGuUdwTG5dmGgpJ?=
 =?us-ascii?Q?8c2Ga6fbJ10vL55nGv35913EHcoQewM3fDamA8tMmHbPw+T5v7cupDqCoX3h?=
 =?us-ascii?Q?1j+Wdfs6/BA0z+LwKBgIA+XWlRwRKJpeF+nEm64Qbt9oLL8yVizv6txknwTD?=
 =?us-ascii?Q?9cnGQ/5ryQzsnMnefv4i/47tC31kRoz2f32i5NYyCxHz/5JUiCFPENS/U88f?=
 =?us-ascii?Q?wXaMYFlSVM/YasTdC9sM7/cUVwf8r8DvNx2ssS48NhKYRIpkUi6vFirsaZ/I?=
 =?us-ascii?Q?zi9P7YdMC2KNU6risfbHiySOdztGB+N72eAyo9m6Tpi2hYSQyrE4nCi0EDZ7?=
 =?us-ascii?Q?KadTe86t8lP2wqETPcutKVpBo+NUfTaRXfIPxQ7Jqnp4i9/zlsMkniKMbKAR?=
 =?us-ascii?Q?CwVU0iGoFtVEg+j6v091rCV5UOTrcNlCh7ug8yRUOOANpK/AE9lZNRDt+6fv?=
 =?us-ascii?Q?e6m5HYVLG+tH6XAhloQNF/1W9aJ+18OjUat0PLDxy2KW4H3A+T92AuDmjSiX?=
 =?us-ascii?Q?RRqzGS1QyZhACTYq1JVeWciivmuD5RWbU6L81+5knOhLr5qhIMqPvPov2ENK?=
 =?us-ascii?Q?Aio9dzjBWuAH9SwrIBYXB3r1MyxK+wh3cqn7gj/Z8droO4CfjHuczPgjFEIm?=
 =?us-ascii?Q?nuPnFZU9s3ue1c++Nmze+hM2KKhPO7n3B2qhIbprYDkVZnFMAaxkuHxXNmKp?=
 =?us-ascii?Q?vtbXkmHli9QD6KvM5Ko5KFMfJByWArpZaVPjHaYkWWm+zCa+2YoB3zn/6bqL?=
 =?us-ascii?Q?EyiL6FWHSEgd7TlarcsckfqncvIc0EQbKFU5zdg6WS7MA7FMNZ/gt0SnFw+x?=
 =?us-ascii?Q?sE7jEO03v0TgCxJB8g89pNNEdKCqQGF64pQ2gaS59X2Dfh/kl8UJudoOydRl?=
 =?us-ascii?Q?leHZyFsHQ3I+dUeqc+RwDcDoh2Rjz8B9NSSejVu+cQYXSwmvwjdZqelhGkeQ?=
 =?us-ascii?Q?DbDVju2s12HA6sn8sQC03U77EBxyLAVlVevERG2nFAmhfNbv1eo0Mid9XzwM?=
 =?us-ascii?Q?Mj51k/bDFTgB9SMtVzPbhu5cmWWQ6g4s6YFXzGo6QdOrHP2hAxn5NEFGLOU4?=
 =?us-ascii?Q?T/oKBh9FCyX1ZDuxTFqq1+Yj7iDw0vgDyo5xk9OEEDwh601Y/LrTRrl9VCom?=
 =?us-ascii?Q?/o8Q/YAteDELP42YD94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:02:53.3421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60641f5c-96fa-4302-4370-08de3cabce82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF

The cited commit added the metainfo file and configured it to be
installed via Makefile.am, but forgot to update ethtool.spec.in.
This causes RPM builds to fail with:

  error: Installed (but unpackaged) file(s) found:
     /usr/share/metainfo/org.kernel.software.network.ethtool.metainfo.xml

Add the missing file to the %files section.

Fixes: 02d505bba6fe ("Add AppStream metainfo XML with modalias documented supported hardware.")
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.spec.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ethtool.spec.in b/ethtool.spec.in
index 75f9be6aafa6..f5fadf26fa64 100644
--- a/ethtool.spec.in
+++ b/ethtool.spec.in
@@ -35,6 +35,7 @@ make install DESTDIR=${RPM_BUILD_ROOT}
 %{_sbindir}/ethtool
 %{_mandir}/man8/ethtool.8*
 %{_datadir}/bash-completion/completions/ethtool
+%{_datadir}/metainfo/org.kernel.software.network.ethtool.metainfo.xml
 %doc AUTHORS COPYING NEWS README
 
 
-- 
2.40.1


