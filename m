Return-Path: <netdev+bounces-219587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A304AB4216F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D93D687C7D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51E3043A9;
	Wed,  3 Sep 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="E9hhUNwV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2101.outbound.protection.outlook.com [40.107.237.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B82302CBE;
	Wed,  3 Sep 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905979; cv=fail; b=AVhhgu2+QFZ45qo+X5XBzRVNFOJ7bwpK/NGUxDGNRZD44+5FLurZsa61jHRXi6wl3CKg+E7W8UoyXMzj2crPvqcpdRiIQmax1gSoCfj06CJU9cGJ7+ScH2Zte4+IJlfUp4WPdXusbWwyLBgPlEjNfHxVHIkLED+ZnxAfDqz8zGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905979; c=relaxed/simple;
	bh=pm8V7Vv7VXnHAMxfqVx2ulUtwkSKAhR3sb/ieChilEg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eT7THy+fncO45MQ31lEYmv/pFJsHSGZsm7e6EF7/IsGZl2Yb63mWrBqFAMZWY/ruWFW/YWrgcJAd8QvxslDZjuk5s5UE8LqhORvye6sLB49DvyMYpKt6h8bYdxDsIumFkPmy2S/tySSz27dVnToXhL7lxvoZA1Um2jM4k4l1qEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=E9hhUNwV; arc=fail smtp.client-ip=40.107.237.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/keXfSYDNM7KI/nq/Mk/n1bl+msCKyk3N0cAP6FI/WnSwqMrzym4IVjvwMfsHfUL7Oqrq1M0AzbSpNNe97+74s7vYdHaXUzPSTN8Njh+fxmq39BR539tlaekO/hzX5NckNzerkhboOlORxqOJEnZCCq0K6stM+Rc3hjprEm0ew8uT44ISC5ur0xI/f2Hftfs3DPuc1Yr0o4cW+zAczvx4PhqMNe8YLSoXuBdSbuHvfq9xD9UIvkMxeHshZsPH6SWFoCK2K0TdPQ/8phR1S8PdQY/2UOPPW2Q4ZR09Br4n6LId81IzbC5wLB2gN/3xaU+z1Ye6T68tqttdkcQKbWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYY7F4zPa0aOuWdtnwAlVwD9y9LhRBoFiBzoWMQxt68=;
 b=ucUK+mxCYGwkOdXF4CST79zLdewcbAqAbKDD/u//VujyU8K9JpU37W8rD7echH8J0KCGDRVTZBQjJ2B30liy+vMIILW+EI1b0vVuy44dmlvsXPh7v2UqPeLZK1v+cjEXs7T2/8KiOcnv3dFwjE+oNDu2rTF5mOx68HxSozlRDx3LDkhk9dOYp/PT5ca4jiQPxmDn8296SP0vt4zJLhwGaKUm2esk/VBi2ovLhpKZomB7wblUUPfdevL8Z+S1D8IWIZz+NQtBU38KJYm93HbV3u2fKWk0Ge2Ii9X/Aqrj8DEMuGo78tD8MKgC0aOAVWz/W15vYvYYdKHqmKRVk1KsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYY7F4zPa0aOuWdtnwAlVwD9y9LhRBoFiBzoWMQxt68=;
 b=E9hhUNwVdcRQJEyMVxWreWC9sHhDMTMYGyrt57FGaDyFqPni+Y121StURlhZskWtZT3YK6GSz+YfhUe6GJVoNJ/FeGjbYn6GoFTn2H9Ba74sB9P6pk3DBoGdwKDUM3bSRSkolkq8va8KpXzZJbVZ+Yv9B3VM3YVY9XhL9bV9SB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS4PPF3984739DB.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d15) by DS0PR10MB7293.namprd10.prod.outlook.com
 (2603:10b6:8:f4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 13:26:13 +0000
Received: from DS4PPF3984739DB.namprd10.prod.outlook.com
 ([fe80::ba61:8a1f:3eb5:a710]) by DS4PPF3984739DB.namprd10.prod.outlook.com
 ([fe80::ba61:8a1f:3eb5:a710%5]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 13:26:13 +0000
From: Colin Foster <colin.foster@in-advantage.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] smsc911x: add second read of EEPROM mac when possible corruption seen
Date: Wed,  3 Sep 2025 08:26:10 -0500
Message-ID: <20250903132610.966787-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:160::49) To DS4PPF3984739DB.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF3984739DB:EE_|DS0PR10MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: da9f7c67-a712-4c9f-0251-08ddeaed73db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bbvdZe6tkfk/S2lAszoVc2C1zCg+7maxHbT+p8pB/q210NW2rPF9ksw4ZXPo?=
 =?us-ascii?Q?4/NjKoTBTrc7XtmCaDQ/frc6z3KuirT1sKBwqtEgZVWAdIl314aB1k8Dc8Rm?=
 =?us-ascii?Q?8yLetkM1zQu3IlX+0H/BkpB99r7vr4kkqrsTCn2UUKO+jJEYQ/btij5fHTLm?=
 =?us-ascii?Q?0lD6jWhl3c1k9hmeMlB+xdK5zC9UvWpjzM9tDtc0I5iBimKSZgvv5hnagoEe?=
 =?us-ascii?Q?eQG3tNtxssWBPqArQkbu2tLcDdJmPSeVH8UqkfcdB8p6es+FB1ScMKAadP1q?=
 =?us-ascii?Q?PZNot/tZCaP3gZM7mpMBRRRFJeMPCZ/nS8BknWDOv7ngCK+OxNSFOpycGfyG?=
 =?us-ascii?Q?QWXpRKWi+dbJ/IFU1p5INkEbE6J7oilxWfWSAGbsml5TrjUhmuqOIrv7kTGH?=
 =?us-ascii?Q?isYE+A4QRP+8M1NDgJRo+fGyLan0TyORcmoZena56A3mYFhrg2WwRIvHPb6G?=
 =?us-ascii?Q?IMobWrZhTZcAyQWF8Z0fPG3Ln+ytAJwAqMVAaIo2nHGV8pt2nnb67hLaq4bD?=
 =?us-ascii?Q?jyzMsKMHyrtC4ZoiF196kcPBb3Sj/iPFE45SHTclL1i/KorC5xmICtsKY93h?=
 =?us-ascii?Q?giqMZcsxFCHF9TAM8Fs94eUoO/x4t4RzDunLHkuz6ENAih1PraMLZBZrtmK9?=
 =?us-ascii?Q?Ocrm+csPkblvrQhMXpZ2mXTcyxnU2XcCKdrz/eaXrIg9K5YtzDbpGSVgWChB?=
 =?us-ascii?Q?ZSSKwtcryChRAd63JkPXJOKjiSemrn8sbxpB24J7ij1ESxAR1Mz1lK48IVmG?=
 =?us-ascii?Q?vCXotIRrqCk6nJhKwefU7o42GjmdjQf1IhQp0v48IQxTSY5fiPnSMr3gtUai?=
 =?us-ascii?Q?fUSuKJ4q7CD8AksP3BPk56OGj+SStZgB/SRhG5iHYfYPlStmdUR6ZxutNMgD?=
 =?us-ascii?Q?vvg0ZNqaGabR5Ew2TJ7U8F6XKLz6PCT02GofqTv8vzR/JuoRhzPCqZgjrS+5?=
 =?us-ascii?Q?4EkvtwfKlqz3BIRsQs7PcHiZqesLVmM6a2XelBbGO/oWCYzKIheCIaHv4CZz?=
 =?us-ascii?Q?AdlrftMpRfY+giiZjY3N/DUZ6M8q6LEAHKjdGccnBMkPSZbmw0U7o+CD/HsR?=
 =?us-ascii?Q?5wwrlaK9VZpmHgfYNh+iXPWo67V29wDGJCY7mU2DqXm+Fesa01/H4a3dR6Hn?=
 =?us-ascii?Q?Ugr8NQePrv9+CtKmRxS37FspzVqJmWzvf/rYuBuHx+/ng0L0xfTJ8uJIspCH?=
 =?us-ascii?Q?ef2+nyvgw/Lk4XbULE+j0yxl/+ZirvPgtdMDVtNSC52QfFNc0YcFhB+hmkUl?=
 =?us-ascii?Q?J7v9swzCQUzwr4XHZcFf/WYXzzTAVlKSF8TXq12+AEbkI6wRHyoLMl6O4KCm?=
 =?us-ascii?Q?bzDdtRDkwTZhsRXW3voVlp+nC40b1g5VfKs+bjfoiiMaHbl0gylyGQKCPo4/?=
 =?us-ascii?Q?J+JH5m0mu/qoF9aZsD1lRlyaOSRIl7ZNYSsdGT+c23cBkC1Saxj88EROeUxM?=
 =?us-ascii?Q?av/5KjeqCTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF3984739DB.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ZrG3CoTOjNCtt9eAwosira0AdKB76AeRF8ehPquQgna5Nv1ZhxNraRDR0mA?=
 =?us-ascii?Q?H3Gq5E3tUa/j2Qr5yjAhc86J6TYIH18uWfNGW1C/Ltg7u/Tgr3s7Ayav9uUY?=
 =?us-ascii?Q?XwYhU/lw6ajt3XE6eqYYkhYWM/snSpPHrZmeVBDW5CkIW8aOyTELgpjE64ET?=
 =?us-ascii?Q?2EWpFawLz+v8TxDcVNAokUyxZk1A6RBrqD1aTYw/T7MYMmZsoyaaEp6n/dJY?=
 =?us-ascii?Q?mEIOKTAermuSca4ZnkMI5zJsY4LWqqdtcTfygjL8mYjzQTb4c6KSMbPzNsr5?=
 =?us-ascii?Q?VtUatalj5AsUjnySVWa9Govm3k7KvwBQ2hgR5OgeCXEeYKRPyaSHcnYKsSML?=
 =?us-ascii?Q?EOCYhozZMpG1Q7f2vBO3kO1f6ckUBnev3VPbT34U2cI7xTWLfg4cAPiHWzIl?=
 =?us-ascii?Q?sa/DORCcv3nbCdBHZjrgjxoUVepE1BwY6Nj23WSdKb7jec1uTHwCBsUeoEqY?=
 =?us-ascii?Q?l84jeKW5a38lTm07PI+ZahKunl8VYHqcBS3L/LlmZXwR2mpuOB3V3xfOY9FA?=
 =?us-ascii?Q?nKxQojpaXmrBiVVYnIsn4DN8dHDt+GH35gUw2777xuyA/1bousOB2TfrKhaz?=
 =?us-ascii?Q?l0qY/TYSdVhaWfuQaex17UcU+TzGNeT3MW1jZfGO2wHYbTAa4IxHaMuQhbSP?=
 =?us-ascii?Q?sDBIqNF+6HXYEX5yneOeEetPQNcDc8L+/KlLmO8C7O8K0m/EGJe9qPQY4KJc?=
 =?us-ascii?Q?6c00XptRF7YxYuNCzYCbspn2RRMD7O3CPkddbha0xsw/EQTN5k9qv6noypaS?=
 =?us-ascii?Q?tmi5zyXKd4DdAtRDxY133THWjkMIHpeAX04P8c7aDHUWvW4AXGT3LQmI318L?=
 =?us-ascii?Q?876Z3ofru5XCXRXr7C9+5gpxkt03WdQvJRiagot1cmWbeILbEBrpHI4WWoDO?=
 =?us-ascii?Q?4NDmyTjoXh7BGZ2u/zcyjRSq/x/c1QFg9rxN8uUVDinw/1iSZWWEYirVizMT?=
 =?us-ascii?Q?3Rvm2pO6oJWkuUqbHHQ6EWG5SwZEMD94Po1TddnHpesLqi6HY01aAweVeEhn?=
 =?us-ascii?Q?9uaOPMZTxjWIMzJVjCKjLzVhxwz0nUu6J5hfHeWTs5GnhJlhbeG0kVxXDY6v?=
 =?us-ascii?Q?R8iPAyycb/lqgZ7SZVDVnpnyAEp3FArFiQ6p8uMcI9l3BtFb1GnUWRbitUEq?=
 =?us-ascii?Q?f/BL6ZMKylyLpqlvxyNhbSAUkv+7yA3Sg0vZqlCFNymLD70W6IugC6X8zupG?=
 =?us-ascii?Q?xuZZ/zI+lZnWwcGr7an8t6K/I5qeE85kxTiebIiFpIM8w8EWarsJrZan7zL2?=
 =?us-ascii?Q?5oqcMnC1QlYDho+8fpHos4SuhJX5wa+e/mECnJekayOJxQY0rzCGvEqnnOmN?=
 =?us-ascii?Q?6sf+bFUvVC3ql289veGNGq1QBqx41MRo2ia55a9vN6DMOC8keqH6St2ZA3oM?=
 =?us-ascii?Q?e14UZU8ghyHxuaBqLw4EtF4F8kiwEwjGEL+CpC5w73jcwhQCf0ntE1VSflEX?=
 =?us-ascii?Q?4PdPVRL4dvJbcz21UoOxtarhQiQATwJ5Vi0OIF5T3NnWCFC0BSrU0fm5L0o3?=
 =?us-ascii?Q?FJv0YM7VuGzChTEtqoseGN4kXf58IQrFsBudzNRwYQaoPw/jnTy2pIJZrVoa?=
 =?us-ascii?Q?03ImEIoIX7c2QqLBGC465z3ds7jrVeeqTE95CEd4B8L7S10KzgTRyVpcbSeq?=
 =?us-ascii?Q?mjfqIj5OY56ZHa8NWiFZEDY=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9f7c67-a712-4c9f-0251-08ddeaed73db
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF3984739DB.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:26:13.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG73Wu7zIpkn0nOaWzOZfW43EOaLTCylRTwp5TuvbXPATnfLF4w7rex/WMdZA8rP55PQnFMeoXmg5sgbfOfIDoVGmbGTXC/N+1nc+fL3934=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7293

When the EEPROM MAC is read by way of ADDRH, it can return all 0s the
first time. Subsequent reads succeed.

This is fully reproduceable on the Phytec PCM049 SOM.

Re-read the ADDRH when this behaviour is observed, in an attempt to
correctly apply the EEPROM MAC address.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index a2e511912e6a9..a0a4bb051a4c5 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2162,10 +2162,20 @@ static const struct net_device_ops smsc911x_netdev_ops = {
 static void smsc911x_read_mac_address(struct net_device *dev)
 {
 	struct smsc911x_data *pdata = netdev_priv(dev);
-	u32 mac_high16 = smsc911x_mac_read(pdata, ADDRH);
-	u32 mac_low32 = smsc911x_mac_read(pdata, ADDRL);
+	u32 mac_high16, mac_low32;
 	u8 addr[ETH_ALEN];
 
+	mac_high16 = smsc911x_mac_read(pdata, ADDRH);
+	mac_low32 = smsc911x_mac_read(pdata, ADDRL);
+
+	/* The first mac_read in some setups can incorrectly read 0. Re-read it
+	 * to get the full MAC if this is observed.
+	 */
+	if (mac_high16 == 0) {
+		SMSC_TRACE(pdata, probe, "Re-read MAC ADDRH\n");
+		mac_high16 = smsc911x_mac_read(pdata, ADDRH);
+	}
+
 	addr[0] = (u8)(mac_low32);
 	addr[1] = (u8)(mac_low32 >> 8);
 	addr[2] = (u8)(mac_low32 >> 16);
-- 
2.43.0


