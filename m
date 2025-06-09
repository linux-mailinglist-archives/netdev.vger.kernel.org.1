Return-Path: <netdev+bounces-195637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4BAD18B9
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36F07A4F08
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ABC28030C;
	Mon,  9 Jun 2025 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b="i4aUDZeQ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021142.outbound.protection.outlook.com [52.101.70.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5ED12CDAE;
	Mon,  9 Jun 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452049; cv=fail; b=fK7pDkfw3m3hjqtBU3j3agdQEVMtjBrHsmiYRhbT18+qs9GnvdrNvch78lhsCpWI7wj/7f0vJNcqWxDIGOsRbw8axzWJ+1kBDjcMhS7DbPHETBcYfZvTw1FwmzviDK34+9Di4RSkpsQritTqm5tKiiVlirBxwvnPaSkBmNoRFRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452049; c=relaxed/simple;
	bh=tOaCHDCy1vu4xA8i0q3iFGhCb+1KhT/9GyA88zNnhqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iey+dejOF44Q+0yHlbH2v5uwmlXMgdVhy3f5CWV/J6v3uWBgttKqkkadqSczSYGqCQJ98xeO2c96dAZOroPXBVoFv0BC8vOIB8qKmBKKk07XzSUtioJORJlg8oX/CE9X2ScomZ6c4+03XPE6ERKAJrxNT+fZVigr0h7Ml2JW15Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=i4aUDZeQ; arc=fail smtp.client-ip=52.101.70.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technica-engineering.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOtoPR2EX0/ufbhti5sMMIrLRCyJzeICJCuWtqESH6zm4G6syahnA7i4WwWo4IFXmgLLCzhSoNzoDgLpfW2Ga/M7wMqGYsFt+aFW0FmTrpSSz0cY7Ed0QiuVu/OLNqRMnxTE/0VUIPU6gQ1N6Vmr2/nwXIQ30fxsE/6g08FwQpHEP06OMoOnIcmnCWu+PkgwfvduMfTZJZh/L9zgYQ420tJPKaLuPmuJDEqGgaltSXAY0thCvZX+BqJUH6sv2HR9jMfUqxZNb8FXmL3UW2FSg0mGzzTxmQAs2CMEUsB0lpfVPVttABdl4wbUlMN7i3Ui8ysL8FU9Z10g3GmU03vyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wESoGR7BnMdcxxaqeIs6T6NKZZ9DCT2YK2CrU/6uRfc=;
 b=sVbawAM5R+HbFIm+lcq+pxueP6TD3e94lEQ+oCs2Bbr6j6Qo94K4FkbagRz9tgZzh3uGkIMu8go84WhkC357WQ73hnNLUS78FB4ZfKTEl5jAYL68zfvDDiTTQJdgH8diizv8xwuh9xZFvdkJyU3x+DxWitRWe1qn3TRHYoA3qA13fRnk3K1J7k+BBEJLlBcnGQh/DdLzqzzOaV1IsJbM0k/yT4xhFkLtwzksWNb+O5GLheCjjGGsWUuNvrLUYjXuT8SAu7A5ZtPRMXGtwA91aTDvXvC+ElwJW/KNO/ZhDR4dGgYwZLnzf7ZHfk1c3pmM3ZEMjYJC1UH1xUhBgeuPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 2.136.200.136) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=technica-engineering.de; dmarc=fail (p=reject sp=reject
 pct=100) action=oreject header.from=technica-engineering.de; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wESoGR7BnMdcxxaqeIs6T6NKZZ9DCT2YK2CrU/6uRfc=;
 b=i4aUDZeQParjfX75b4rESnG/U4uly8EoxQfQOk1x1FrpAqUpoBGO4gOh7vRQcy/X1jnI/rUUKa62qOCzgbwpaNiisIKYN+cRsd9Un91fWmgcUOcJfs6XLnialuVZPQTJ2WSiDZ7Qm9bRjByBdmVP6yGBHJEdK6gDQ16eUVfR3iI=
Received: from AM0PR02CA0007.eurprd02.prod.outlook.com (2603:10a6:208:3e::20)
 by AS8PR08MB9220.eurprd08.prod.outlook.com (2603:10a6:20b:5a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 9 Jun
 2025 06:54:04 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:208:3e:cafe::75) by AM0PR02CA0007.outlook.office365.com
 (2603:10a6:208:3e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via Frontend Transport; Mon,
 9 Jun 2025 06:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 2.136.200.136)
 smtp.mailfrom=technica-engineering.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=technica-engineering.de;
Received-SPF: Fail (protection.outlook.com: domain of technica-engineering.de
 does not designate 2.136.200.136 as permitted sender)
 receiver=protection.outlook.com; client-ip=2.136.200.136;
 helo=jump.ad.technica-electronics.es;
Received: from jump.ad.technica-electronics.es (2.136.200.136) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server id 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 06:54:03
 +0000
Received: from dalek.ad.technica-electronics.es (unknown [10.10.2.101])
	by jump.ad.technica-electronics.es (Postfix) with ESMTP id C1F6040220;
	Mon,  9 Jun 2025 08:54:02 +0200 (CEST)
From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
To:
Cc: carlos.fernandez@technica-engineering.de,
	horms@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] macsec: MACsec SCI assignment for ES = 0
Date: Mon,  9 Jun 2025 08:53:54 +0200
Message-ID: <20250609065401.795982-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
References: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|AS8PR08MB9220:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90944177-5f34-4072-5b12-08dda7226b9a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k9BTIRH6XakuD2SFAuitw6b36UyLe7q7HVg9ufsO/dMqX8UmboZDSHHoAh66?=
 =?us-ascii?Q?zHfujt5pnEmpBMUpDN0yokiqL693UFgc4afiPXd0ZCULTXTG5fn9BvogEKQ+?=
 =?us-ascii?Q?2sZY4jDOQh1zd3e1Xlec0/g22YKsSLS0qf/EXkskb1apifppzUnz+2MVeCkw?=
 =?us-ascii?Q?MUtPRTkGJeNtILZJLPKxkOLwqqJ/7Czjuu0p4gVjtCwji1+mwZDqt5Z59yBU?=
 =?us-ascii?Q?lsQ/g4RpxmRExVvXNccYw7cQhD05ABdx82p8IBdP9OCLmeELxsKw9i5deGEG?=
 =?us-ascii?Q?iOv6Pl6UE9hYJU7rss5dpcOIgrpts3dUP5CkY+Q+G2W9eyp2RDsWBfYsf/h6?=
 =?us-ascii?Q?Xu55sO3W7uZ5HnB/pOqgBR3+fL4HuEIxt1s4+LQVzVadWDESodzIvMkTU/e1?=
 =?us-ascii?Q?y1sgrL9sqezYFsIsovx+iYxBQM6C9G5ZrUpS9HGoiiF17sgVqerb8adI4TZR?=
 =?us-ascii?Q?Arewnzkw20Q+smGQbqVjqFFf/XDFFQmQVWrXpf9RyP0DCdtgiK9wU4mFymk8?=
 =?us-ascii?Q?jzJYLaRagn6aUY740xWaUXVklYZEV99GyCcx2i6udTrMwAWBbDTSVSG8fCpq?=
 =?us-ascii?Q?/3Q9/51fSsR5zuqlC4WuAIvzcyeGi0Dc7yxRcxNPjZNrnxrMGdEiZSOAv3tx?=
 =?us-ascii?Q?Gt0SZve2WxxZurThikHAexuZzGhoUImZaVpPjmzzqmzuniZh0ppRVvz6AgAP?=
 =?us-ascii?Q?j4Gnt9HJtO4dBTFHLn8yN/XAqrQDd/UGhvH8CP9ElE/3Yfe7M8sslam9v2om?=
 =?us-ascii?Q?wA/BgGuJm9HY2XwRooGyFM5RawJ6u4fF1wBSIL3E2nuH6ZtczGXM8/WEek6X?=
 =?us-ascii?Q?HH0RX7hkXv3lIDJIxQPfyF+wrXxPvQMGdvvaA+iUU/sgDEKtOYjkD1lBXXPj?=
 =?us-ascii?Q?c8UO0NpYDOlUDFwdKE8MzuXjUUbSBtp7z1ab5LLHpMJr1evSSE965vyTgNMq?=
 =?us-ascii?Q?+RRjQJmZz+SzTlW2PSL7M1wN+fI49bgzwThMHM8dyZRZrPRrI1rJKlooLZlA?=
 =?us-ascii?Q?Q1hasKAlxmXYMTpa06k0E6+rEdfN21ReZAOWWM3lwsrYsQndmUFyPnCsgWX/?=
 =?us-ascii?Q?93WKX2y+TyTw6piEWJlFlqogu/IZ2VaRRNtpWYzPBawR1dtLz4xqlk0BfKxy?=
 =?us-ascii?Q?AfmSlBSdQUMfRCiZA5+T5LNUlNtjA+goLeQ1jo+UDLer8+KynUz0fHxmd+UM?=
 =?us-ascii?Q?ijwBiXMAhyIj3Sm1GrC47HqOYXuCvMhEjUl2MZ86ZPeJDneIkRIKonKwYW2M?=
 =?us-ascii?Q?cBu/09byDP6ze2mn07IRLgIsa6ZHmroEeJfB7Z2fQFJT19GQgv+URPinafKx?=
 =?us-ascii?Q?QR2c0J6QsQgbd3XE5xnlSzxDP7eHCpTR26Rp2UVyNDIzunQfuoyYkMVWtnhK?=
 =?us-ascii?Q?UcNo84Njj4uPwP5En4qyo8D4r7d8cxoZmil6102jDfmkLBvkaSrjnBn4gxUY?=
 =?us-ascii?Q?twVmE2o+M1+aSJtaAoBO1Trrw/9VVcNta8UQQy+qtAZdRiQQS2domktJ3Mlz?=
 =?us-ascii?Q?ZKSvTK6MeEKJeIh00w+pXvccLS0O/OT+TbO3?=
X-Forefront-Antispam-Report:
	CIP:2.136.200.136;CTRY:ES;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jump.ad.technica-electronics.es;PTR:136.red-2-136-200.staticip.rima-tde.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 06:54:03.1256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90944177-5f34-4072-5b12-08dda7226b9a
X-MS-Exchange-CrossTenant-Id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1f04372a-6892-44e3-8f58-03845e1a70c1;Ip=[2.136.200.136];Helo=[jump.ad.technica-electronics.es]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9220

Hi Simon, 

I've added the test explanation in a new v4 of the patch.
https://patchwork.kernel.org/project/netdevbpf/patch/20250609064707.773982-1-carlos.fernandez@technica-engineering.de/

Thanks, 

