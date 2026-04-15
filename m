Return-Path: <netdev+bounces-278747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJuwCeBx32mFTAAAu9opvQ
	(envelope-from <netdev+bounces-278747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:09:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D9403995
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15321301E7DF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C63491D0;
	Wed, 15 Apr 2026 10:59:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B8332906;
	Wed, 15 Apr 2026 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250766; cv=fail; b=rh09oelrHLlyklM+azN2EzhIjt6/MZ5C/V9/TMJjXWkx0BmrQEWRsW9fHPvAnPJvGThlrlppB4FNYU34BjgZ5Lkdz28Kpzhirt1Ohwd5ETh8JqlPgV58AFfTLzcl0YI1N4VyoKP22zlrKaDx2O1QaJ5RoncLq3oewRXFOdktthk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250766; c=relaxed/simple;
	bh=I630mwmQRw+jz5/IdyyA+bthpejTyh59tAsYQUWg8dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=laiMC6AdZwoPvITa7ICajnT3BF9l6daINQZGZrLGkWiFD3nd0Vae7UZYlYfXOPtjC8OySTHzMgTMB4eyNUXT5naWa4uzb2gL2PYsIYf5GSGuD4OeyWxM79hFMKHnxE/xm1RPuiPIMPdeDY8JIPfL11W7e5G2NlTwmQfu/E7R+NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBzof3rXvVZnv3rWP8Ou1xX5xSKYDDlEWHRJNM/PtLn12kkvW3rYv4jYzhIArHfi24wZd8uzfXXwPDgudTQOYM+mWj4MA2KGQIlH2Ev8iCOpSnYX2JW8II13FvIzE1HoeQYiB+mGS8nC4bOUPooyAV4UExSfe9+kroT1BOGyzraxUkmT6qui2+hZmSJNttlllRkvmZMEyJ7N2/sNT0v/sbEXiyg/e+Mgs3caEO2ERuHUhmKAx4GtpmiMeWa2sD1g8sfTC8Eo1bqCdHkkm3U9NNXbFgS6qyBSSSD+YRvHe+fSeleiorQzOQEackUCHxKhq7AIRNj66IeENx87v76uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfxgmE1CfmPuGqOvG/ZAmhwhtvrIHaSECC86hptxXRM=;
 b=J/+8JPywFMv3cy0qE6uS37oqs1FR/ZKzaCDL8FDQgQgCwmq5eipHNjQyNXmH0N+j9H6QriEOAa2OPHyZrLGfi6VeIYKe1Pxt1vm1Gm3BCjXeU1f7f4L0ob40XLlywZvKNakhPuskTiPk6aJKc0lq9vIxk3hL1jB/uva72Cg7T/P1+zQOlqwJL818lDSAfVLm+bwfAKbFp2hwrDJrXK7YU2trz8UkplzNjYbJmTc6wuTP42hKYsU/gdux7InmHLWg0NSxUuCmYuJrzpP5k1oNzLG/VnTycbQAfITJODvJhH/+t5GIwt+k7aTAFoAF5O31PybbM3yS9IBFx7xHeSMxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0712.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Wed, 15 Apr
 2026 09:27:04 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Wed, 15 Apr 2026 09:27:04 +0000
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
Subject: [net-next v1 2/3] net: motorcomm: phy: set drive strength in 8531s RGMII case
Date: Wed, 15 Apr 2026 17:26:53 +0800
Message-Id: <20260415092654.64907-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260415092654.64907-1-minda.chen@starfivetech.com>
References: <20260415092654.64907-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0712:EE_
X-MS-Office365-Filtering-Correlation-Id: c36e9388-25a5-402e-6e1b-08de9ad12823
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 Lzp+stKst23ojN9hx/YMRFvrth7NcASeoDUqvUTBtEa0NgnV2bJgJrl7tT0KIN0PUEijNG4NvJcgIUQ7nVIBBKtOjUVnq7TVCS2hwdqNE57kAOCj7jxlm2ptka2/XbM+c9IwBMohtUlwOgTT6tAs/Ij9ne3VezJenq5lX/sROAwZ43GvZYpU19s+gIDJj+UXVVlk2iUCWZ1RmB2+mp+4UPVSn0gaA4na0TTzRKNO/i0yoKy9CFhZ9Yxc6flXWZdFtoyIM6g1RLhSVOua1qr/syn0B6daur5rI6i8u/nPz7SrNlUQYFDgtN6xhTy6PEHESC1bQ6HkW5+yo9EiZEmWCXjZac90mYL7M505T34CLHVTPYWoVnfm5ab1BZA38/JZtScrdFn5S3XD0YKA3W8lj0aYjm45untN61I/bYiKvERMdL+umbFurrrb/cRZucG7BfqJSuc3CZY19/SmCZjK3AjmvH9/rmWIni9atPT6Br+L7+llAOGhFABP+ORQHEugaScDHTLgxsKjlmy/7F/3j2WM/Krbf00QuuxNFvg7YSJ9zIbNSju2XscXCtCoZpYeKfDx0oORUxFEzwbIlkAckA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?edlQ8OFE9h3Q5dj7SNJxrpmhaBRla3njYOwwWjfY8EbJrRGwoh5xC3HBvzcy?=
 =?us-ascii?Q?tRWvSzFIVz5NN/NT/FiMBsGnUNwsFL+94wv9t8VpaEgKJj/crJLw/y1ID/w/?=
 =?us-ascii?Q?pV8IaiqNBUBOUkRRiIJGKvRLpmv5uyPRKDFI6MNpmELdCDzYCtLdJjqPqx2R?=
 =?us-ascii?Q?3i9JCEuNpi88W6hHiN328Gdu79Ie3WWuotQaWLmCklNfLb1cK5vmiv5jJlqz?=
 =?us-ascii?Q?iXQkndN79T5eO+7aNyIOLvUvNUHqPJYNfx7TgE1cCJQS/l6O8T68cWAZfxzo?=
 =?us-ascii?Q?9rqSdeb1A2p53kceVMUro1UMo3j8f94/vFM/1r7FwU4UIgQpFPEVa+P3FVGH?=
 =?us-ascii?Q?1Pjiyckp6hZlKds5UK09CvmlP8BtReAhDzcvqJkWbFrl5FUKkFBsT52eIgbt?=
 =?us-ascii?Q?ZIRSi1WWDH6Q9h3nncXaID8rdK8p9fdFB7gVh5ACKt7Sr7w+Zt5FJJEJ0Shi?=
 =?us-ascii?Q?oz5XNm3fCIARO5s+7MRIugoSUd7jWCI4fx5eL3TrbzXYREyB82OHxuqBtOET?=
 =?us-ascii?Q?yIpKCDzR3YjFox6Bxd3u6kzB7H21xCf1n7OaYIBp4+xZ5Pgfjnok//3POlc6?=
 =?us-ascii?Q?+9+z8F0dKNXPvSb/iZsfdGcCzypqaXu3zT0KTTFNa5amG93KKYTcvpwGVQAF?=
 =?us-ascii?Q?x+Xau1XW48Wbkv4h/P67eqgHOkc0lrByMBY8Gih3+7WErB8ajkigtI344uMT?=
 =?us-ascii?Q?NSjhWnoIYfIuxZPN8WwPxYvCy0Lt1DddM7X1aIuq3kAJ79B+0Fsr38g8xF3d?=
 =?us-ascii?Q?rbBbjma/ViiHDpMjX/CgqTwXP4gPpQaslN1mJ72EWmgt6AOvNdCAyq13hVVL?=
 =?us-ascii?Q?lmdg441fTJ0d58M4DMqkJsDbUhWTlYHBlfhHER529oChc5D3i7Za9rgtMrKd?=
 =?us-ascii?Q?u90BlLZ/kp/IUeOqiUEhRZfJp/Q032RanNW5EXwDbT4bck5ipPMn/HwWJye3?=
 =?us-ascii?Q?+IrnAjlKihzlcy5eru3myut2rXsYNHuGVDhqzqohWWpu35PrrOEpbKigFJpn?=
 =?us-ascii?Q?Pa2Mq1dN6jdEYfnp0h4i4E2ssoBpkqGiKvYA9gReA7Mvwd/dVI5VxXlruvDB?=
 =?us-ascii?Q?UbN6Gl3mdLHtW7LaRX3XY9TUV9Z+Nt95s+FZYNrky0wm1ot+kzInQirWz0+o?=
 =?us-ascii?Q?l8Zt1tA9RsCG8PNp1TfcyqOy744d35g2e9O1aDqYNhsjUVdIgjmNbFg9Bqsb?=
 =?us-ascii?Q?O9IEGMphXvzwxP7nd+8SKZ6eLeyZbxCBeeC/eBD2aGsm9n5vhFwDTVImCy8b?=
 =?us-ascii?Q?ou5N6HxEjMBoUH62fTNv3j30wAZbaj8ohJVCCX5Ten2dSYHbFiQ/N60ZMFpP?=
 =?us-ascii?Q?fI6krpza0fVLJXydgmjlpssQtGK8gSDEgYJcFbuhtjEZn/jClasJFigb7jit?=
 =?us-ascii?Q?/9N1PW2+0h73M3v7vELiqGvtCTVjaf89ZdyGfB2gbZ12oYoPaJDPw/VDfVWv?=
 =?us-ascii?Q?ZF6X43WxW9mTRiISVDirpWduqLOf6IANXB+A3dPBh0UIecV3+L8zjwsqFjYv?=
 =?us-ascii?Q?ET5taFshgL20tNSLv0xw+MLzdv0sofCxEr5Em6bqwW+M9NC7fg3g5zw4LEbN?=
 =?us-ascii?Q?KINe4BrRTPv5Tz0aOnUpGmhcmB/as2OWHE+Zk+HIJm6uJ350Fa+/ccFoYtkp?=
 =?us-ascii?Q?1vk9wdQIXq4mYiDBucKRoTQRmxrfmugqSa3yFRglhBKYKGKKYOJrJw4HLCvy?=
 =?us-ascii?Q?16c9EkTmKSLYskaisDf7Y9oGeTbTLYoYKKMJBVZpIKqk6fE07ECQqzwkbysk?=
 =?us-ascii?Q?nh6ISpuUQBdhrKLdePf+f1DuooGk6Uc=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36e9388-25a5-402e-6e1b-08de9ad12823
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:27:04.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA/kP0MKNy07iyZp+OASUhZli3fGHPeyIJdamWFhf8Y2otoKFNZtY2cvXNQqk1W/EMl8d68TxDHZC/hhqR7gx0kSBlZGlrwD52vTK2keSWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0712
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-278747-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.891];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 735D9403995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set RXD and RX CLK pin drive strength while in 8531s RGMII
case.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 35aff1519b4b..f3129419f7c9 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1714,6 +1714,11 @@ static int yt8521_config_init(struct phy_device *phydev)
 		if (ret < 0)
 			goto err_restore_page;
 	}
+
+	if (phydev->drv->phy_id == PHY_ID_YT8531S &&
+	    phydev->interface != PHY_INTERFACE_MODE_SGMII)
+		ret = yt8531_set_ds(phydev, true);
+
 err_restore_page:
 	return phy_restore_page(phydev, old_page, ret);
 }
-- 
2.17.1


