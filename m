Return-Path: <netdev+bounces-86313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EAE89E60D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4773F1F21F93
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB7158DB1;
	Tue,  9 Apr 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHdKGhhn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2138.outbound.protection.outlook.com [40.107.237.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B231E491
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705134; cv=fail; b=MlQ47inh+KE2SQ8N7kyGxwFdua7vkhEbyrSmdQiCZ2icXGYxrtW5AuckiQrVdsLWzH6+lit2oqgacxOkTuuNnA6h0LF2KfJ/bJS34AOQEoWIPyNCDdxano8mu+HIQeGWULjnNhj6HPLeqibmewfuvsMUzy8vDdjpXlJs7B3JeRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705134; c=relaxed/simple;
	bh=MnQAnZALF2yLQNAH6oFPgQC0+gdatUHpd3GuiWp1K/c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hYfJNvj1vuYChDtTml7enMb26cfHO1QwoW0ygKNKbmUjGUWrkHVCD+BCydlyvEZo4vfuCcW319IaG2UuRP0/rg2Q2vm3Qh+yjCd+EaXOCqi33Ez6kuZpKx2BhCD3DmbmjcszyEBWW66hKbRxEc5TMYUDW/UVXKAPDBZdRy1QT6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHdKGhhn; arc=fail smtp.client-ip=40.107.237.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4qJVxgBgvjSeLusTDijPrx3dv1bntIW3LnSNgdf3Y1cglg6vMt2oFQui520Ysb2tbWdcFwtNJRFtHsA/J6eb8RTloE8hBRrNeMuQruQglFfJBw6UO820aI+AknU69+/FBKvzgDDTVl8Gr0HLjDBjk+4oWXBkC5L9ov4l78+FEUHFUFw1iN34Ij+97kuH1kmZXiIBursWdLK/hzoDGSFZRr/dsIqnxbu8Hd/Ygx8SA+bR5OqusvM/SyMkoZkP3UsGOPAvW24Kk9Q61YTJENTlVvvCLnon2BjhIVea/I8bIdEqxxO19tH9SDWkztkTVYnn0IOpHGGoBiYYWBjMeB1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fULBeYqKHt+E9uS/nG4lDvUMxCsx9GVTDHRppyHVEQ=;
 b=QV4qpAbRQBechWpwF2RzgLCjsX1PVYtoUDlACemdBKkmNV8qg/Cu/mwZZp4ce4xNJllyGsgUsjEH3oF8vQj2wMmcj1MVyYqwRchffOyw8r8Jjgiq+lNAQ/2EOy9LLQsxkldsoOyU7wFS2V/M9/2LxU8Ph3NVABJ7izsTws39W9JeKtqbYddgKdwmZfOo5JyItzeN9Ni8wXSASLZ577aG67PWrUS3/zn1Onoxcphsex3fraPc1Fe/hsZ7DLV43x5QEGnUIjzjBrS29uO6Aff2b+uqsnU/LWEzm9ttcYp4n0D+ck+iHj5Q5pP2uN+YmjHPv1ra4j2c5EyaMcCnI4/kUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fULBeYqKHt+E9uS/nG4lDvUMxCsx9GVTDHRppyHVEQ=;
 b=SHdKGhhnAv2jG2dIeoPtuDVmsrtBWaRI84H0QvaeQMBYze1dRZxECXoyAJuMfmDh6j6WDwO9rQkamph9zBHyKi+ihGso32fbvd/QvBRCTyNmOX7u+W1tl09/EmyHru2laXdqs0H214ugo5eKG3JmkVCtX4PajxzG90OrAsNlptTfaZVXm495bXP/ikWsVtnCrZsXFv+Z9UHGhEZvZ8dgkGSX96X+RTppvm53nBzYTFCr6MsQUOAoskkiIg0m9FAtrEfgTinK1z2z5nUAIcGvj2wN7N8lcj73bnTSY5deiGNtcS/vSMa0Qjb2M09q5YaOPr/RI3skssDklgnr3Pr71Q==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 23:25:30 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 23:25:29 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net-next v1] ethtool: update tsinfo statistics attribute docs with correct type
Date: Tue,  9 Apr 2024 16:25:16 -0700
Message-ID: <20240409232520.237613-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ2PR12MB8979:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Qf5ysZ6p+6VzA35qZ4LTgzwB1MVvK09dPibG1yjBt6lAaLnvD+UdsTuRuYrDMuHAHygWT9/kB9YCBoEYL0ItjNUdV12mqwC9VcrJesmYcc+Fh4/Z5Nh713rh4RD8LivnC6oObYt7bGlPCHUe7I1N8+Hqxa53oAZmN0pXToCSEBufUKB4zwvDSW3l9zyQiqEGgJLgjYAC+cOibS42p8O8jzO1uefG9HWoa1+/reHyjjyjlfr1RpYPTPL2+tJ2tfv8J+RfbtG+jeakwuBIOGzWgtzOodinWwCoHeQHXOorTFT/mnLIJG4FqKpr26G1qKXd26SqHzVEN/yxM6PS4NeXQH3ho6m9jXjQTS6hAaAE12ZTmq87jxL4+r12DDOSE7JDrl9E8P7yhtxPOxTQtvx1aYxR1ek/ehqZ80aKc/UDKLtVIoRVH9XUfT81zYGgofGUWDgd9lLcFSPDiMZbakdIgPR4OGM93j/w8/2Gc1+Hj9Na+H535H32+HNsN+WmSaLtokknmUhWVZY02ku1162bM9GTmLU4Q/AS0obuPJX+CY31lv5BKjkzI8bJIRS3NBVSSaLVArxMtp39zXUVBGR6TE8/HxyTTza8gxyOZkHlNAzAWmUEvdd/SA7r5woFDCCfww1FpsiT7Jw/HBzkeLALElLC8Ytk/F/wiuZtQYXiS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4vB6+EyNOz244Q4/h53VM+ZS3eFyVFLcEpG9kpok720m98mME7kq2ofvc6pg?=
 =?us-ascii?Q?nYxDiBKmv9UMOASNpSaVfTBLWhvsff8tAfs0cHx9AYQ9uVx+0IqCHAwch2VI?=
 =?us-ascii?Q?yXOoWMh0Ic8ESrOofHq4kL7PuEL4uz6EpHqz756o+21fcorDgODMVwEz67kA?=
 =?us-ascii?Q?HIbGh8EjvMJ7iJE6o5EeUvf5s4l6lUPGFxaz5aCkaS4XZ/p6r9kZZMlhb7jv?=
 =?us-ascii?Q?LpcJn9GtvZ3MhFYnC19v7rLSpfjFaDehtETfKrwT9aavVRV9O4ekX1TUBqB+?=
 =?us-ascii?Q?Y8cRH72G31Kc7/r2Pu3T1HpEBjAo0lwERkc+DLH7AScPgPlcgpI8wMMBfsKL?=
 =?us-ascii?Q?hc7OJ8usK5S9THGcHxIcMqpeK52zB3NMa7iZRCc+AIImrKf+LmI9/AuCPpJj?=
 =?us-ascii?Q?VdguVYaDBu52tPcg27FkmfFwlRF0Xy45rcag5GJlMsy6Ze1RyiQ7U6N+TY7W?=
 =?us-ascii?Q?A8KKGn+SbrZ24qcvrIBg6/0InorVpXFF9uryMDQ29kYUNfgcziMsFjLox/TU?=
 =?us-ascii?Q?66XMcjBR0Mg2cQOObwjOMT9FWDTGP+pp1K93owzX+ZFX3KbZM5O9uYhSun2v?=
 =?us-ascii?Q?bVbKWlBaFuSu9N5UFTS0o+GIB/uHTFeAVKQSlDQdnJuAT8mipD8yWxeXpvO2?=
 =?us-ascii?Q?T56T+7GVW/5ErxmdhApGHILeKZq+EDhj2d67wuhvZP3CU0TwQXS0U+FMPgMF?=
 =?us-ascii?Q?08CKU1iwuLUUvj1u7uyOBlJJxNEC1r5AoU/srN+4PNjks2e4VS3WENp1vqvG?=
 =?us-ascii?Q?fUSSBMlPkmJvMEkDM7VFleVLO2vqyJbNaj/VzHJhM+9F2oxnzOYSh0upWEuA?=
 =?us-ascii?Q?KD2ZqcFwdtDoN9RS3YvYYXplN2egW9neAymPXByKJ4X7d87neNuPJIuwfX+l?=
 =?us-ascii?Q?hZmNh+r11A327RGisD5OT1vylbl13jZAmht8T7M1NvBSsiU2bfAenrT3B+T9?=
 =?us-ascii?Q?kG81R9iOOdc7+UlipuAhmGJpuof5UwFfTPMUOKBMEc14HfqB4duZIL7rNvys?=
 =?us-ascii?Q?5M5aLzVEVjWDD4WUhscR2S6ijWFYcCDeZEMXPI6nir5Py6wyj8OnCSCkxHwJ?=
 =?us-ascii?Q?zH2fTjdRmF242DTMG+QmWGfnCAc+8bRS/X4s0CcsdsJrBE3deb+AWq8JLC7H?=
 =?us-ascii?Q?tA1S+NVEly6kFDcE57A7jgxLGemd4+afJ4u0VBKLbcsoIZ6UUw7LHLu2QSjm?=
 =?us-ascii?Q?KR78Pqbmg7ym/ETp4P3ynK1EsttR1V2mz/3UA1mZD501Yc1rKHnEAfox39O5?=
 =?us-ascii?Q?BChgyHJVRjwygijCpgku+/B+yTQtJhbqvOVr9J94A2g4YhHwh3IdgAi5UEaW?=
 =?us-ascii?Q?j9IEdQd2GYIkshKI2WyUUfeKJeJAGKEnkP1E8z719hw51mI/9YnKPes/BNIq?=
 =?us-ascii?Q?uih9bf4AA17qdNwGLzFKxrzAuEbWbC5aUb3WensLEN8D6aHrbuH4kJUww18Y?=
 =?us-ascii?Q?ab1LBVmG7rzXl1HTBiiC4DFL7BaP4xOA2IMAOhQDKaHZkFeC8xKt5/Zo1N7R?=
 =?us-ascii?Q?VeSVDMPwCXfV4jIMpzVIxw+E27BlxVFC7gdKmjJzn909grCzoWGUcRELwLAX?=
 =?us-ascii?Q?74hih36wkpfIqdCvLnpkE/Q8GFsSoBh4MR4VV+NVB7CWFxN1SRjv3uCypBUw?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8bdc80-c8cf-450d-631a-08dc58ec5812
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:25:29.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8QhOPJhAXz1OSehQ0OeX4QSVYc0s9kNeuLZYdgDPx5kEkETiP9W3Q483k4LmAB4PhoZC30x82AnoaIqHu/OfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979

nla_put_uint can either write a u32 or u64 netlink attribute value. The
size depends on whether the value can be represented with a u32 or requires
a u64. Use a uint annotation in various documentation to represent this.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Reasoning:
    
      I discovered this inaccuracy while working on ethtool patches for
      implementing support for the statistics. Used the rst initially to base
      the types and then realized we went with uint when I noticed incorrect
      netlink message parsing due to using the incorrect size per attribute.

 Documentation/networking/ethtool-netlink.rst | 6 +++---
 include/uapi/linux/ethtool_netlink.h         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 5dc42f7ce429..4e63d3708ed9 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1254,9 +1254,9 @@ would be empty (no bit set).
 Additional hardware timestamping statistics response contents:
 
   =====================================  ======  ===================================
-  ``ETHTOOL_A_TS_STAT_TX_PKTS``          u64     Packets with Tx HW timestamps
-  ``ETHTOOL_A_TS_STAT_TX_LOST``          u64     Tx HW timestamp not arrived count
-  ``ETHTOOL_A_TS_STAT_TX_ERR``           u64     HW error request Tx timestamp count
+  ``ETHTOOL_A_TS_STAT_TX_PKTS``          uint    Packets with Tx HW timestamps
+  ``ETHTOOL_A_TS_STAT_TX_LOST``          uint    Tx HW timestamp not arrived count
+  ``ETHTOOL_A_TS_STAT_TX_ERR``           uint    HW error request Tx timestamp count
   =====================================  ======  ===================================
 
 CABLE_TEST
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 23e225f00fb0..b4f0d233d048 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -488,9 +488,9 @@ enum {
 enum {
 	ETHTOOL_A_TS_STAT_UNSPEC,
 
-	ETHTOOL_A_TS_STAT_TX_PKTS,			/* u64 */
-	ETHTOOL_A_TS_STAT_TX_LOST,			/* u64 */
-	ETHTOOL_A_TS_STAT_TX_ERR,			/* u64 */
+	ETHTOOL_A_TS_STAT_TX_PKTS,			/* uint */
+	ETHTOOL_A_TS_STAT_TX_LOST,			/* uint */
+	ETHTOOL_A_TS_STAT_TX_ERR,			/* uint */
 
 	/* add new constants above here */
 	__ETHTOOL_A_TS_STAT_CNT,
-- 
2.42.0


