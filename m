Return-Path: <netdev+bounces-280348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE0MNtWH6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5991C4437F8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFE763013863
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E73BF673;
	Wed, 22 Apr 2026 08:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64610306D2A;
	Wed, 22 Apr 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846802; cv=fail; b=r5rdm4Dh3vCs95V1Cmum47OlbdkUnaQniHaGZ9XyO11u3N/s406zm7oC+yH9K0EftJMQXIE8LiITNYXmYtO5FkZchwQ8NUAZB3j2utqlLMzdfo55AjwxUbW7fyhkLFctA5RIBLVhpAJcQ81fnjzn+o03T7ZiofXTWea888f0sNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846802; c=relaxed/simple;
	bh=/aBRUPe9qgrSOyYZWkOcuom5RKStmxxPfB5/VfhzCtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+I0OXcpLa94f/MjWTRBlKsvlSH90TKXOHdKwonRtqGqMZMYX8MjpkXMwz8TodAem7B/tmyDI1Zz7v7bBIYEiama79SifJyHrVK9oVWmyT3WsNa1M6l40z0SMsdqqn/93rxG7Mm0sVwLbrMt89aXIeWmI0BKAseVIL9E4Vz7daU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqvJzKmy9m872ioJM4w241SL2m0+vEREogfrvoEYO7RikAALA+7Kd1AgN7I/dTcqch4y5JyCNcReSrJVBOazQqVLYo89ROtZN4+7+uP99JrTcTnXHXHSSO26VvRzwUo5+49zOpfoM9yvmBX67dDWMVoxeshcoFjz7kr/EqhDQxDwL19uIxPC2PCtWM9C+EF+7XYE3tXX4VnfBgiymHFKywH+cUHagrQWUV2n8Jpdl/895m4rTkCzGii0Lr0k3Y19+b539FZnxBB2RmLP2S1xPM1QzXpNSnOowwFCOWu1QL4NvuJeQuvmYDX1JBF0aAU8jgpwDi+nQIfq71zpbagYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE+tLd7Knd23KE+vAek+HllHOH96iGZVK9qEUJlucho=;
 b=REHiwRf+LCfQvNv9Qi63XKblxGqvLrbmBVhANBcEGLhqVCO7pQ2gSWYhzKixpxLpxkoUB9zzhcg9Zw6YWciQ9si5Qw4kWBvgQeE3iNa5XH9Fm59TygGMxO9zIlNpwVVefLd9BaIZEbX/EWGNZzuFDVwhzRCnzn/EMRWi8pAB9jiGP9xe4ZcE4Q0J6FPBWJAtT4yjMlTvPFz+hR1tli1/9hLOvtGFBexQjZCNnCZKYC93TuS0r9EWQnjTUF02vgZBrvIYe1INE4xQScDbdlX5o8/lMi2MDhRYHwWXGfE03kA9jlZUC597cPprC85TEhivF4rTf1ry5QXkkCFbZF3zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18) by SH0PR01MB0554.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 22 Apr
 2026 08:33:05 +0000
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 ([fe80::8f25:1579:34a0:8569]) by
 SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn ([fe80::8f25:1579:34a0:8569%5])
 with mapi id 15.20.9769.046; Wed, 22 Apr 2026 08:33:05 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v2 1/3] net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
Date: Wed, 22 Apr 2026 16:32:53 +0800
Message-Id: <20260422083255.29692-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260422083255.29692-1-minda.chen@starfivetech.com>
References: <20260422083255.29692-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::18) To SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0858:EE_|SH0PR01MB0554:EE_
X-MS-Office365-Filtering-Correlation-Id: 626fb3ef-668c-4066-b13d-08dea049c66f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	LmNfllyPbkLb1Yz17GiLPpvhJ3z+H91ZWPNzZfX1+M5JUngaGSkOhlq4ZkK2e5KNqzoqHY/O8nooOUowx67KxDCrfYABCrmwfdbcc99cuoCt/J8Pz/HcYNprO0zbehcYDsC5qJpKj+9RpMX3okUIvXqeM4OrnP02Q6Gsyiv9+TAGoa34t53mfkTqf7MXmjZ3+ls56E0bjzNj2T4UnDqlCwGIIi6Q+cKK75hx1I5VF6JG5d/FPy8a+kFyobX4nWRWU1/1xtAjRxTtZZntuOED1Qde1RIkOCIDLmL585F8dNgNr7vhBF2OMV1jAG7ATBZJ8/0J9mzNFUuW1lG820/Kntx4+SHanjqq4fJZf1GYRuse5ujBVTXUsi7lMnydKrpuwhjFc4PHq/JmDwsJDcJlJTqQu/jFNidbokjnzcYKImxeTHDy4Lq3SINL4f7/57hGaCIHuWEWv/163rK3qiWkP5xtq4Kvd7UCf0pecystnUGIfUjfe97nJCuGr0o4XAMPc1VxBKM/gXkyfJUc1cY8VCEAdFlpvXMYjZb5QSUBr1j2H/UXN4tkETUva2IZOBBaSivICkGNokwehHAX+PBWGCJUavbhPe2Hkh/E43BkM2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzjzcPkomApuoJGQ/1vAnvq4qzDssh55ux0s4xtBoLrN9+dcgCxLxN5I+cDu?=
 =?us-ascii?Q?3aMOQHACZG1pavB2BhNvZ9CXgkvyGm4gLo3+c7TtdGM502+ZawamBtcVYKp6?=
 =?us-ascii?Q?m0FDV9O1Z7eC69SKJ6c8cEmQuu9863Et0r5YBbxWFCt4cUmGGImY+IDnL0Mm?=
 =?us-ascii?Q?JHkIN/prv21p9Q7RsDrdHmoovB+lfe/GTaWVg8bBFIkO++RqJ+KNfTjKyHwq?=
 =?us-ascii?Q?VQCFaPHN2Wf2YNUmkmTTnAxicebwL1N8SkJt0xg6lSkt6CuHQ7pWnMEl6Sbl?=
 =?us-ascii?Q?MyESShX5sxVp7+1i19n76gBXVURAgRV+X03MYVWV05O20NyEocMS7+/1ydZH?=
 =?us-ascii?Q?/teFi1NEt57laC7AsPRPHqIGktCxd1P8Ue8zjc0w5QReOkOHxSSGfv1vpL7e?=
 =?us-ascii?Q?jC+pNQOZJNs+i3kHuq/m8+drsrVCeIG5r0YHZAt2Peo8+2cReKPZJUOXrCYv?=
 =?us-ascii?Q?FOiXHCOB9TAsyped6jDqvWqg1x98v2yVz0uQsOUJVGCv+bqmkvetBq1PuHyK?=
 =?us-ascii?Q?EignNguLu6M4VcIAOd01SeBOnSxoc9ZN8uuEuLDYmAn2bj7RNf5wxB64Rl5l?=
 =?us-ascii?Q?NAKse1w8jC/y4tgHSzkthUF4u6tLX7NbL1WqsYk5LfAVCBDnx5H4p24dn46d?=
 =?us-ascii?Q?MAblH7q5mIfVukuCF27FWEnYIhpRbpXU2vcshZUw0d2lX0mqJBkgaM7+GUdr?=
 =?us-ascii?Q?iSY08fo9WAU4XZVokRLEb6M0kdmdS3os0vcEfXzOKtjvJAUQvkT03Le14Edn?=
 =?us-ascii?Q?TLVmKrMWU2+nnt+P61w9wqxk0/eBSAsaxUON17qvVo66Z2rxN8OjlNpnZQOq?=
 =?us-ascii?Q?HugCrk0NlAEDrqyRiVZHdseV9Pa+TbKfv5sW/y6W0/Le3b4OdyM5jB9EMT6g?=
 =?us-ascii?Q?6zVIyZK+ruMkyTh45Lzc1Q9TcvPlNWqdNUETJqVYX9/NAGM9JZpmQL9ki2F7?=
 =?us-ascii?Q?0qmOJpb0SLuDDjm/VjRBlos84Kkx9qilOy01tlTr1WfS6aEvhFczbcWxUPLr?=
 =?us-ascii?Q?gqPqT6r+jG08HG0lKFedAJ8cuZOrnhO5xwuGOBWalkUP4bkA5SOoNyTVWE7D?=
 =?us-ascii?Q?Sc56IGYZ2gzVbvQhWpjqljAr1DvySNDME16kAU9dyIFTpJ6burDrMHHxr1Vw?=
 =?us-ascii?Q?huegHDUQANwT3r2Fk//ClrSdtEmjhAfiC6mgwXAp4gnOsZG27auAbXfx2jb6?=
 =?us-ascii?Q?Wq4Mjv9rkmkXVZiI6taTXEG6Vr4deZmljSDtJYSRaXBsWsgYDd87CvgtJ6rj?=
 =?us-ascii?Q?rXtEeu/kKzezzGRkaDJetBMCkm0t7yCyfMt8aSQz6AHQJDb10yNvk8Ub2Ot1?=
 =?us-ascii?Q?eCytB3wREq3tmzT9SFaJChCooU2YdWDG5BerhIZVh9I0tH1myVCTs1ffa1Wc?=
 =?us-ascii?Q?NNqJCcvaWNO5r1n2Sl2mhobK6M//I/Fa8zEDHd4vHLjU+Sd6OQbb5qADnya+?=
 =?us-ascii?Q?p7ASwKxZ1ALhl3SJ63mizEd78tdknVnTn0/EQY8rU8AtatmgjlP45X2FRoV2?=
 =?us-ascii?Q?+/w5hHcwCgweEwSimsGr8iTfZ9dQxiel1AzMp2T8dXRsNShiH+AyKdL3Hibg?=
 =?us-ascii?Q?sxv1w1Cd02W196abW/9ecbd8s7dHSZFv6Y4aoRPMnfdfyUugrvORa1T+hagk?=
 =?us-ascii?Q?9EeRvTZ+YzEvyHlIv3MRv4Hqj8rxDxRN8GSyyaW5VhJtJx1xaTQyhlkj39/u?=
 =?us-ascii?Q?kLOj9wdOMpP896k7r03upONCsi1WF0Yfl3HOEtYxjll7kM3FqKG0YWLJJL2c?=
 =?us-ascii?Q?NdBtAOF4tZZ5ZvuH6wBTCGeijDIFr0o=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626fb3ef-668c-4066-b13d-08dea049c66f
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 08:33:05.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrT7W2u8wsdPayoB7rtDldPIgPEADnSfYiiIxcLzj1laYWX4yG4FNVKp5CJJWx+SAh9SXhsrUAQ1hkZw2aE/kX0L5I0ITqi9JT3YjHcJYbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0554
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-280348-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5991C4437F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

yt8531_set_ds() default set register with mdio lock and only called
with YT8531 PHY. But new type YT8531s support RGMII and has the same
pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
setting pin drive strength. But YT8531s config init function
yt8521_config_init() already get the mdio lock with phy_select_page().
If calling yt8521_config_init() with mdio lock will cause dead lock.

Need to get the lock before calling yt8531_get_ds() and move mdio
lock out from it can solve this issue.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 4d62f7b36212..c66804537aa2 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -974,7 +974,8 @@ static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
 {
 	u32 val;
 
-	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	val = ytphy_read_ext(phydev, YT8521_CHIP_CONFIG_REG);
+
 	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
 
 	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
@@ -1010,10 +1011,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 		ds = YT8531_RGMII_RX_DS_DEFAULT;
 	}
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXC_DS_MASK,
-					 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXC_DS_MASK,
+			       FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+
 	if (ret < 0)
 		return ret;
 
@@ -1033,10 +1035,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
 	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
-					 ds_field_low | ds_field_hi);
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
+			       ds_field_low | ds_field_hi);
+
 	if (ret < 0)
 		return ret;
 
@@ -1826,7 +1829,9 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	phy_lock_mdio_bus(phydev);
 	ret = yt8531_set_ds(phydev);
+	phy_unlock_mdio_bus(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1


