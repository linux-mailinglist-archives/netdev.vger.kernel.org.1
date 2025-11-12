Return-Path: <netdev+bounces-238138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF65C54903
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1600D3AA8C3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F13D2D839E;
	Wed, 12 Nov 2025 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IL2NbtJF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E542D5944;
	Wed, 12 Nov 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981897; cv=fail; b=eurIw2Dflznch983bg6EVS8Z6HwYOsPvdYwCWdDt2unI5OY6a2sBfP1ERTS9eaTezpbiHh7+QAq0T6mxxrsDyW55sFGXrOAoy7K9BTLDNTe5TIp4QJFMjmvfSnW54Gb02ETPoG8aUZKTVd0iNZSb4A1WKRMhbahTr5BL0iCEdd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981897; c=relaxed/simple;
	bh=U8/MOvx7aMwIfdcdxCkNJIHezLFwet3BHgLgPv7+aXI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iRQ1SAkV0IIwg1cvuDKlrhsst9UiUYmwLlsT0liu94hGtrYw8I84Gko96qcWhjaV1t9Y9iNJXGSkMDc82kV6zg3Xqs5ikDMh9AFiIWxrf7KHb4VxOfyUDh9mFp6TpHFOyDUdkntAa9tQ8gmVTuetQsxApv/LJ+lnUbTv0VOLh+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IL2NbtJF; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXiEClTMvzM21hcYQex5tdnQR7+A3/TdfM3YWekrnMokQNodUhaOQFTQ8gDTLT7FoIWw8Y0e/0n2QU5+oWHLHunQIEgeZesesBhNRlMQI3QADHMZZCIyVLiAH9GWWD/d9swWaXGrPjFV30oZOYDAv7/Tr7JuHSTOS92LdrBequzpVv9VOiRVjmuCkdbP0+r3S/t0+INt+ljf3A1MxHMg70zQc05vc2V5C9J4+qiJNa8Q86aYyhw2gVpESk8UReRSkRNhaCqtgeeuUYvsWtDUUTUJpwhIRcPjQhAdpq3soo7pn5zHZr/sWLqA25ldRoRFjlVdWUr5+hhLMzv/ByuYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x/LDmTKVtK5+YoI6xXWWBWfbEX12B5SWDcrWoJXyDA=;
 b=F0pe9dSafhArdJl5QAjkXcEfx4/Ug9MTgonW85NecpFCyIaNDwutCNWG/KCoP5pPi1Nd6gDr9gw8YNVy4n/GBM21h4HKMKzIPBe8f3IvHcJc3b85wSth+/DcUar79/vLIEh/XK+X5m7hMKwwpWZQskxjKC373dIxl5x7fLjtVLxsAvcXRn5BEWzy0/oABvHxkMH4yu+wRVvdKqeJ3LifNwI5sA62Y2sOJDiMvZeeuGZUtHZ6FgTLTFf3IN/zsrUMe7fLGN+nzzImdWkEGYx8naXYheBHEXr1Ysn5NqNwJWT8zplhCkUTzUFaa3pmluyPBCdasiGzohUia+L/JlFsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x/LDmTKVtK5+YoI6xXWWBWfbEX12B5SWDcrWoJXyDA=;
 b=IL2NbtJFTjEh+thyNZ5IQLp4ur9P6VaBCRq/Lbv80SsWQZkE1tTzr2Qlfj7C4dmFNbhFF4dCpXBgUSq5fLp2ccFaovNgvsFRgpx2l5O8bYuKwJef8UmO4ovCVyRXSJJWt56bHpucOblcfT/6HQhUVI//Irjqtx8YL2Z9Ye3G7WR921kqCGwjYX0pNVP/HoNZcfnuhqbE9TLLB/5hhJYCBfBNc7OrV8uRE3EkMLC6r9gMn3+ZXBsRkPz2ahirf8aHz4O58vun5AmoFoDVHdnnwrMQ4R/hoWxCjFZ1MNOQkrSj/4Xsu725JQNb+9Zjcb+eB0EH/p3mrwsHSq31j9GPkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 21:11:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 21:11:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: pcs: xpcs-plat: fix MODULE_AUTHOR
Date: Wed, 12 Nov 2025 23:11:18 +0200
Message-Id: <20251112211118.700875-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::7) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b32ee90-088b-47be-aa16-08de22300e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ubJMsypLkLlIZRb2yPBGayDjExdAUzfgekbhiTW9pw6+X+yUTGejSIQT5i7Z?=
 =?us-ascii?Q?mbXlZ38eklqSG92i6IocA25F7fREPPUJOPlt3A+AxJvXMCANL1YaEnN8i9Cq?=
 =?us-ascii?Q?3tjeexI1XKJEjLMWwFBUHvF9E+7Rbk270wma7Qu+8+F3DPihJ8LygWFQSgMj?=
 =?us-ascii?Q?Yj7+e231GiGSc5P6dfWixpXEV1/CN985+ycHnsoNk2vzX76T+OPFYD8VrgEd?=
 =?us-ascii?Q?hcfbYW2WeLBT4vF49QjnnX/A7I5x4c9Fqgajqk3XH8XRqA8CXfwO1yiTcOVi?=
 =?us-ascii?Q?/kIqOijLdLaLGXyhsqUOBokmEO8uiVI4VRs1/xfmtEqVGXhNclGsyjA8pHPM?=
 =?us-ascii?Q?VkPkwJXy0WNgfH73XjB2fn2xHLo3y21PejDwVTIStu+1Avjp9StqproOu3Nb?=
 =?us-ascii?Q?q+NH6VGZp+H4AczzU5JNIYC1cwnzVhUQXLIbjioTaTQ+NK6FFXip/JznWg8q?=
 =?us-ascii?Q?50bS4zAhUbCC/O3QRR+Sc1S+GfCGSEM8dgUm32zD/Kh5LujD9Fw0CnMbexXR?=
 =?us-ascii?Q?pn7UaPVDQEbF2cwu4I8A7Zah7rLhg1f6i0y9ZvzlEehVLuE2IrUm6blHsBIT?=
 =?us-ascii?Q?lnOArAGcA2urGxR5OohsFJ4LBGnEHfNdV7SAeD5VEn+QkxpQfIVWvAEmOdFt?=
 =?us-ascii?Q?UmvK+eH08AhC6nnfhSMHdnFc0GWTPYiBF4EdOlRGrsFCoA1KyxdGvq9aDjVS?=
 =?us-ascii?Q?zDv9wOlRUvxh4shbljNr85orr3KGcEB7PCGE54XZnBbwwBObakFCvo6ET22c?=
 =?us-ascii?Q?fXRL3bEhTloB5gnnkW2zJVs9Qh8q4scXgp5CrY2JCCFFXkVxXCUGR6cw+OEj?=
 =?us-ascii?Q?N79zJla3p07mZhAPG8QVvtefY7JYxw6YBvZCMY8YiK9mBsrgc4bXte7kgmAt?=
 =?us-ascii?Q?hHRsLPo5gzbYI5i+1lhguX1edtqxNOdbZAY9Wr2u8W5cJZwNjplN1Ofqyrct?=
 =?us-ascii?Q?PwEGa77bBuZYK/1DIElh2RDJesn1waSlvz9eouMFjObzKYqL1kBa8arSJNrO?=
 =?us-ascii?Q?6wIfEM3nMALiMyVUuRrzw51pI7JuNdoUFj7J/noEZlli+bPKEsf9aD139if/?=
 =?us-ascii?Q?UOsDybwcufU29fmG946XwcPuTnygCiD19i+AWgHyB/iQ5cIVREr3uKNcRr2b?=
 =?us-ascii?Q?+oOAuzDlkFIUgkYLGgoAmvhhC/mURbtXpSsF/838RWRwUQ54LZYAGchhrXEs?=
 =?us-ascii?Q?sLKB8z5jdixTFJ9500HCuE9k6oTQsdnSg+IlOh96ki+7j5BFfQ2ipDAYi6da?=
 =?us-ascii?Q?i3urvGb+H3Pddf5GXVDvO/0EBXV1KdQYvIRNZBV0Jb7Wj3/TsJOM0I5AHjXR?=
 =?us-ascii?Q?URizrIWK9yHhkFHgomPZjItpdH3Hbk7uFTn2zmLPMygmNKy7ivemPSnOoLag?=
 =?us-ascii?Q?v2oRusu1pglfDRSQ+kMQiScxsxAyvATM0a3/Xiy0pdu1Gpvojv2ZZiwzuA79?=
 =?us-ascii?Q?TyeSF2Fd8tI9/h6Pp4jzIvYNwLgu6rC4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5CcWu8Sn++FI2OsyAw1UibjFTljeI5nK8KmvsbcNIJ1W4uLIo/ZyNlN2apCf?=
 =?us-ascii?Q?jranSVThtu4OtQ0lw2Pj9/l7I8lA6P1j5DUdej33cLjH0dQF2OMCmGlslmHV?=
 =?us-ascii?Q?9+37dnmn5BlIiwUIt9i+j9zgsWot9JjhusHqGBuYHkI+T9YmlOs5tviCqj2H?=
 =?us-ascii?Q?Scb/bzPHZTa3sTAgpixESOilXGtMQpkSvYKPj3I8eITK+4ZyNDZYMlcYupeH?=
 =?us-ascii?Q?Web9gq0bws3N8kPwMdzt4yJKLJ87jeq7mD9AQAGPeGG0dcEoij3NjJx8vKhT?=
 =?us-ascii?Q?oQ07LFviQ1R4XegBjdk3+EbKID5iiv+bgUWJXv3s4C5Hs0Cuy+jmT1ZthWxU?=
 =?us-ascii?Q?bqCNpn5RPQ97T0OD1dPVGcTV9j6ovjlzRuan/qnAB41CZaZQPZInEzVnwnTu?=
 =?us-ascii?Q?W3/6+1kP755lKrVhX9zy2BdUlGakIIQRavFMBmnVElvtCQTz2+Dwx3xeKPKO?=
 =?us-ascii?Q?FU/QbJL4QkrosqjsNnPSgEYk3SMXYp8YyuXBhkEPxg9X+0t162SZ8RQVrSPP?=
 =?us-ascii?Q?cjyLxTbulWM1CnZU5FX8mVEF2zytrppo0D95EXrCr+d8puCFSgVd1U1birbi?=
 =?us-ascii?Q?67RVgVSPgTKdUreWtQrbZjM08tSRN166RVL7WZAKP27UDh6CU/kfbG/DaPV2?=
 =?us-ascii?Q?7STaMZ5IZWerIaj8bUOv1BXKdeD1BnMSl0G54Ra5CD+DFNejw/TNPXQ3O/VK?=
 =?us-ascii?Q?jeCHRr0+Sy4WWRJ7ykqObXqdV2uFDEK8RLPZTb8zbbjWzRrehpgDUeJ/D8OK?=
 =?us-ascii?Q?0V89dAEZE1k4a2FtvxLEigNLec4lpjLg+idvmje4bU3RXi7CkR+sv/uWPyEI?=
 =?us-ascii?Q?/0VyiEVTlclZq1kYGPhtXJTMko9V2ceWsnuNk9L3emT8U1IzkKhffpRpPqJX?=
 =?us-ascii?Q?YNkeRwEfXZD8B1fzG/yx5knKwwaKZYFdVrEoajbuKlzwfR7cfDBXwSZJSVxy?=
 =?us-ascii?Q?QqQF0ey6oNMWJHCiij1xvlxhVr4XYMjyZb3eXrowukaeAUPbi8AqWQU6B4xg?=
 =?us-ascii?Q?l77bDO+bAlR8tyNnzLwgfb7H7qwpJoE+fGxiqm65W5rHvPq4LGj4HsV1uvcd?=
 =?us-ascii?Q?FELHJriorIO4kWqf/zEIJ1BdE8DcU2GPMCEL7RUEI5+6xzagfNN8wVHkG/fx?=
 =?us-ascii?Q?6VtGaoql6+lCe+6yS0tdF8lFX03jB5x9EBlcC7xh7Za6lFkG6cWWJCEnbtHA?=
 =?us-ascii?Q?CP20ZVFCf3XcX9RJ2RPSZLATRYybok4g8ERgWkUU8K6byWhgF7AlOULpj7ZV?=
 =?us-ascii?Q?UjthdTTNpdK/NTvW8BfimStBea9/lUpUxSVrEO6w7RUrWYYvmQywCXd6txbT?=
 =?us-ascii?Q?bUTwB3yQORpIjeFKnSduiFk61gk9ETHtrVP3DsY2hD5WeKJRXS3Tp75UV6Na?=
 =?us-ascii?Q?TFNgRp2o1ET+jkNRgArRFng6HYxX9OVXwO9sCyIMntyoNCZ64ufckwk5A177?=
 =?us-ascii?Q?CxAn3ncT7nNa+k1mnjlhwi0iGiXqC3o3OV89OYPMreHlH0/e3gc/RD8e+FRh?=
 =?us-ascii?Q?+tC4QtiuUuDcNmyMEiMfj+VdGvTa2rTmIITEJ5/CG2Y250C3en5XzEmS0FRi?=
 =?us-ascii?Q?U38OwdUzxEdyDeCePeCvAFJsV4wptU2zHs3IZ/Pa23AlfXFbLvuz/KTa4ZJi?=
 =?us-ascii?Q?zjig0aIK8W23bkO1VLjKmHo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b32ee90-088b-47be-aa16-08de22300e10
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 21:11:32.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qW3ZvCq4Ylm2IeFUH4EpNH+49aioasrLe0cvGRTFZOIyXecxoy6WZQYiO2LHsYsLD8dA8LnEqnUxUGeSqyTYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153

This field needs to hold just Serge's name.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index 9e1ccc319a1d..c422e8d8b89f 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -456,5 +456,5 @@ static struct platform_driver xpcs_plat_driver = {
 module_platform_driver(xpcs_plat_driver);
 
 MODULE_DESCRIPTION("Synopsys DesignWare XPCS platform device driver");
-MODULE_AUTHOR("Signed-off-by: Serge Semin <fancer.lancer@gmail.com>");
+MODULE_AUTHOR("Serge Semin <fancer.lancer@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.34.1


