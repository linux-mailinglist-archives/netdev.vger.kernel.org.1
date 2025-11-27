Return-Path: <netdev+bounces-242258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424FC8E320
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961073AF5D4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D9B32E681;
	Thu, 27 Nov 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VstSmJ+F"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3732AAA1
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245376; cv=fail; b=OaIVc4Xu5Im9nGd19K0ss5rKBgGot1iH6ifb1FkXNs/hp/8iKaQyOjMH4wZVTCZmfwfFQUoSvH0yos2/C9bJDcpNwqWrBnt7vTlzOBxkmDM1dCi3IcXkWEcLQeo+SI9Eae6Whumg058e5d7QKyRVvmA+DNouKj1/fJQQw0n/YR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245376; c=relaxed/simple;
	bh=nHHL3VeqXgl3cpJ8W0/WKlQpRL0EYDLNuSJmip7GmEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKz0uJ6Sy698B9C/uDhz04jilc91qU9TePnfJueNB2XHBaNc/ckMmpEcZUFmQPlqc28KVosBqDoqlGBCURqnEp1FZfyczby/bqq2pUfIxYkpB831+8eGGgSs6v6yJ5gv/nHnkxn/tmTEu1uLsbyenECeExZiDfEs+2GanG1mj5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VstSmJ+F; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgoeWRN/Jhe1EQUWfBn9ykAYlS0jDfMTRGb1IlGcrSc5yoUXgUJsjrbuL12+c5sWWX3FcB4Kp1RQeItepxHg74BER4FnIO/pFMBawkPBlk625LV7mXNbBqdcY7yABcLvwQYdFA3AJQ8MxMJI2R9nGaaUeeC1hw5eueSPP646j7fc/Wd4CSG4ZJrSo0CAzG9jic6vWG8oa/qL2DC4jndUGWubKb7d6XZQ6vq5/kkHGKXRCFmy9RH7iiPlCP2lh3ZWhHPg+ri3crtzINc4mh/nZCldfV+LGnTsXsO+n0EkxI2D9NhN3K1M5Bo3/B7xdwYPglL4cwZHI0egqjOh+KosJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWCJJz1uIHBdgYb/KeEB+9BcqUtvXM2NjuDQotP9nfQ=;
 b=b9yFMpSUwrHeRmxnl63c+/VWoixlVUlqb3v9uB0gsOHjLjMrwmTPkG7VW0R7gohnlx4I+KOoOPz4NXboFGW6AObfMgRebaU/0aXskJN/XK930iGCY8cdwf+Y5uXHYxciGQqPMEJ+YILhmRa61kZGZJkn+tB6K4Ck7woBggposDh/43N4dESmA1GcKm7fTyvN06gKsyRTLoWmH2fHhAaOr7yJ7EBHJSpT1xxdV4hFx3owVJgZItWsKic4+pj/4nxPGxZQQq7qlDrjylb8OrN0XDkA2nPHe9tZkmDUVANI8ewGCfCiU/uLopfgh1/KIX41xYKEnMkc0dA3iN1hn1t7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWCJJz1uIHBdgYb/KeEB+9BcqUtvXM2NjuDQotP9nfQ=;
 b=VstSmJ+F+N3KZwUaw+z/YOIfjrzPY8uuywTL7NYo8RAgf8hEmmOB0FAca0LLYZy0i35dKPpLHEfmoHwN7HD+dOnN7NLIxZGZ+S0QzUgRk3drkms5hvQ1A6dedC1etEyQU2m4sKzsXr/mjpTUHtj5cY3NKCwQi0ZSUzwfB6J3gEf3wVo81mnz3a53VASi1CFM2y7tfs//UKUGO9WMcv/YvIVnaGhVXdN3ww/HcgsXmm/IRkcg4SVRUNIYnOzlk30daiKGui4oggKZaraWt4cPPxtrEHR92wqpWMhBudPPM0Lani0bUGZRrPPG6FokzX2i0pXOuJoxUGluF4EisvjvNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:27 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next 04/15] net: dsa: tag_hellcreek: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:51 +0200
Message-ID: <20251127120902.292555-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f44a103-be95-4823-f042-08de2dadcde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gwXrMqZUXyEMUQgZncA5eSwh8v+dd3qoEjl5H8qM+D/5ocG654dAZhh6zqNt?=
 =?us-ascii?Q?K1lpEGG+pB1uGUQOBRxVeYrEAlDoms+tFzOH5b6aPCUfDhnHDY2Ain84EWQE?=
 =?us-ascii?Q?K/kREJWN9icT+WuFgo+enp7O25lxZJg5UE06sb9Q7KC++vzvqEnxCxmRZ41Z?=
 =?us-ascii?Q?R2sw1BObbDtJcS00yM0rP9vAwB4LJiZp0Ylb5D3LQIIezwut64aJT7K+m24m?=
 =?us-ascii?Q?c3d5P/IZuCsElURAOzr6gBsEDwWxhLQuF1KJJhhkjzWsYjU+leLOH2VAGof+?=
 =?us-ascii?Q?C8Dwly1efVyug3Z7pNIfP3mxXbDDO+xeuH6n47PmxYoTEuyAZjEUoQSWlnCR?=
 =?us-ascii?Q?dOCHcioYCz3o7ZdYPaXXNLAvzICkgQnIZXo1Ccp6xvKtsZfTVLwSj2ew7L9U?=
 =?us-ascii?Q?UVK/VOqDBpC0eQWYfx8Vlvyt9/phz2nAyxexbfaDNsq7xaxKgLpjEccc1SJ1?=
 =?us-ascii?Q?KPwUK7uR6ZNt+W0Y9vVPuDPshJBu4xxQEeHWeSwCqGwC9/n0zyZyYZsifIhL?=
 =?us-ascii?Q?wCffNvfkWm+NsikkcWVeNVzj4eEOnRpi8qqToh87J07z4h2zShJBjOf+kEIZ?=
 =?us-ascii?Q?1tK+14yzz38hrZoBAk7/cnLHD9h/3jTO7okuq43RumdWniqJPQe2RjG/aHAd?=
 =?us-ascii?Q?yViyCVD08uXpDemWXyI3vdsRQn5VADKlQ/K/+g40S4rrmGDhA0ftvB6qD8rN?=
 =?us-ascii?Q?x2E7X/1/ujQOduq4I526bFN9pF/WwOQVgp4+r/SnKp4s0xQnFhCo69TLT0jC?=
 =?us-ascii?Q?811hZkBYzbfQmgDwlEO6lhMhIwp3y/AilHKWc9wJ7+vuajXdyeYF62dsuIJE?=
 =?us-ascii?Q?QDR418gWBTfKKTtx0oUN5a8U2+pUAxnvOxKiUGSlKbDmr8DP+u+eqrA4UCRe?=
 =?us-ascii?Q?sGhzewZ00QeF51iDU/7nfifC2RX2D97cUV4cJQbJisH0peOkKbVSSgcM2src?=
 =?us-ascii?Q?IJp34zdBEBrP0Hk83Xhv8O7raa/1oARbWPOArkhu+owG66pEKZJ5REepGKwt?=
 =?us-ascii?Q?2ohTS5pEHB6EkZNHxoqYlvG9SjEja6CeQSZg1J127lnzls73crPqSFZQbWKn?=
 =?us-ascii?Q?Cy/LRFpyWi0ZExuPQh4FuML4mcv4Fzn0YKVNPQF3j6zfQXbRrTwG3aT+FfET?=
 =?us-ascii?Q?PTmMVa+UWF4xGLn1eHkmHQ/qTpk9mIkLnM52l4h9Lxc++N+xs7VrTLorNInO?=
 =?us-ascii?Q?WTMAl36gwiIZLCzDkcbb+M+vlPIGnOIOdh1ua+PwcUC+TsUlFXTDQdIYV42v?=
 =?us-ascii?Q?+Us82WQ7LGyREl+kx88j3Z3YyIuDpBeFvbsaviLCrj8fdIbjBRn17QflkKQK?=
 =?us-ascii?Q?08Mmj7KLkEgtCrQDBdIh3EP5WtTjGB9Yzy6uCUm4BxbaTnhx3WscA4kJx6ES?=
 =?us-ascii?Q?u9axG9IiwMlACNOZsOFpOTfuINZyKXoUxvd1UpwZcJ5L6nxLczbmQ+VZ9oM7?=
 =?us-ascii?Q?gZn7znYer1ZzjjlwTBMTb75ZH0Wjo6F9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adoKPtSdMPh7CNPZklq0Gg4/UKylff5rW//osBt/TCWzbyQr8TeSPNJ9PwHq?=
 =?us-ascii?Q?BSutr/1oc8JFIHF6KT8l3zTOMaB1m2Q2PdMCUFwNiPLbOhAnDjn7OEUGtvgy?=
 =?us-ascii?Q?vyi6Pgs6D8TeAoPOa+OLFb27Vvf78S2D4ppV1IQPB9Tuy8T5X7ipaZT5akck?=
 =?us-ascii?Q?AXKo4oNy5zMFxQpaE5N4OvW77VzDKXoiZTMYRWG6RgSvH8GSs8om1Pg9HVCm?=
 =?us-ascii?Q?3A430p1iP3quK7I2CWxsU+6ip8Em22tlB7irs2zTleqDMv6zyzoC6l6uIA4G?=
 =?us-ascii?Q?coTfl7CKGBv800CUwgdJnYo+eT++J8SYmjiw1tV/7YkaW4Jci9sstftNjk22?=
 =?us-ascii?Q?qvF/jZkcDvqBleSZHrTQh/JHWZEIxpD6ju6RyzdygOZbZFnmN+eOD/ZFjyP0?=
 =?us-ascii?Q?6BWaqYf70yIp8Acoenv6m3Qag0K+F+TghwtE5Rf4yC/JGy6bhbMm+TOe9yPd?=
 =?us-ascii?Q?tMLsDqxT9oNPHljZrdDoh0JBdhfkVQRzSE96rk8PG6A5yBmfNXpk+7hQm+da?=
 =?us-ascii?Q?3ZwonTnZ0Cuf/ncHKf0Z09DyuAgbIzrWnh7Pgn8P/EzfMt5XmOcNc7Qz4dai?=
 =?us-ascii?Q?k8DVTnhnKArxl5QaSEMUKUSqVJiIS3lPStK4buosbhWeOmJtTfGJIPFuJnJZ?=
 =?us-ascii?Q?jKq+MOHpbg3EgwZ3sh1p51N6ayagYzq1qmObmekT29sY9KVaWTKIbd3oybfX?=
 =?us-ascii?Q?FMI+yZ+y43VwFqfAdLoH6oYgSMPWW9UfL52iPp7X4tZWw3boCeIJmlu1QKD0?=
 =?us-ascii?Q?5T3J+W5x0d0vLARdgirwnvvrV/lwcunRSWKjBImAoziPO13cX+Vz+3luBAea?=
 =?us-ascii?Q?vdnJG2eXmufUSuuPnHFKHRxi+/8jCSH3emF+epzEWHdHvLTB+UCBIHbjzSYo?=
 =?us-ascii?Q?iCafjAp2TG/JLnDCJEAuaDeAyTblmmdLNs6cOOPPPGRK2Bkh35T2+Zo7loxa?=
 =?us-ascii?Q?J6MuywFyH8+1Vm2VkN3dEKCOBB6ZQA6Z7vkycNVIWwtLUkbYizgZ0JplqMJf?=
 =?us-ascii?Q?MgiVV+gtqv6KPmymSbmDL/UwJqw5afMSJuk4P1gLmxgP5vumRm8ghA7ZJhq/?=
 =?us-ascii?Q?nB9XzruqIbcUxyfInQMgNtUj63zW5dzLn4GgD1/ioRL6FFUlMPFozOp537yy?=
 =?us-ascii?Q?VuEvoWy0vyePlgJ2AA4oDKFjWfQVKnaQQIjeq9PJJoVcaB3nN05e3RXFHSVc?=
 =?us-ascii?Q?OLB0sfOB07Lq2f7ZJAqMf3slx1+VpDqmAZbBdamLgbcWMy8FRPKgVJOcLBBM?=
 =?us-ascii?Q?y5nFiBHip7msAYTV6NOSN22jxe9KqtCPK9EppTB2uogg3yVde8Sd9njWIHhS?=
 =?us-ascii?Q?hDWb1botiFrjhZbTYDqqNSn/T16CTklg3tEo+G6OOvpDOMGgcHA07yodB2Ct?=
 =?us-ascii?Q?eL/XYqAlyc/8Dp2VDEtqagbF0Fx2xd/FdNCS0aOs86SnnaI8w2NtkxLdo5mj?=
 =?us-ascii?Q?0f8k81nKceBXfeN34Mr29oHh+rtRj49h6Z0kKhyTG7Q6gZjeIGFEHgOVWsBw?=
 =?us-ascii?Q?sUVpAQrD+Zyu71wgs6sfMzAQTwtWVyvYJlMhXy0zh459T5I7qRVc2dqeFXZJ?=
 =?us-ascii?Q?yimYQ6E0M7tIIfnQzouUJsl3z/49SGFCgW1hqlAeMkqDCexqxYAHY+9WHMzs?=
 =?us-ascii?Q?XLQdPh9I1qgvAQDJ+u9m/SLHilnIhSBSMC/14SmJryXx44+s+eNrMPQptWcc?=
 =?us-ascii?Q?hrgfEQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f44a103-be95-4823-f042-08de2dadcde4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:24.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6DghehG8JodrX51x4hp42NQRcHUgWvHAJehibG2Bj618uQPWq3hcSboW+or2Q9dKj+737pahqO6SzErATgcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "hellcreek" tagging protocol populates a bit mask for the TX ports,
so we can use dsa_xmit_port_mask() to centralize the decision of how to
set that field.

Cc: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_hellcreek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dsa/tag_hellcreek.c b/net/dsa/tag_hellcreek.c
index 663b25785d95..544ab15685a2 100644
--- a/net/dsa/tag_hellcreek.c
+++ b/net/dsa/tag_hellcreek.c
@@ -20,7 +20,6 @@
 static struct sk_buff *hellcreek_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 *tag;
 
 	/* Calculate checksums (if required) before adding the trailer tag to
@@ -33,7 +32,7 @@ static struct sk_buff *hellcreek_xmit(struct sk_buff *skb,
 
 	/* Tag encoding */
 	tag  = skb_put(skb, HELLCREEK_TAG_LEN);
-	*tag = BIT(dp->index);
+	*tag = dsa_xmit_port_mask(skb, dev);
 
 	return skb;
 }
-- 
2.43.0


