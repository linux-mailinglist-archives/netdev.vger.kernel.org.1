Return-Path: <netdev+bounces-87891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCFE8A4E01
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B83B213EF
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5462147;
	Mon, 15 Apr 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yh1ezxU0"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B34E1C9
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181702; cv=fail; b=bEhDQ5Lf0D4yKPA/BDsBIyS8wbL/leXFPZG/L/6qoeqsJS8JXjImkdojaOLPORCZ+7uurXYR41um6AngluodY21ka6JKF16op6qCDf/rsOebxDn6bN+8zlQgNhk3HXTEFR2Wv2ZKU2RGuwLWUR2C229/YCjgToZw7mhpgVa3cf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181702; c=relaxed/simple;
	bh=4nFBe8UWdWVxoW4IxzOV37VIE31hz8QABnN4ZrKCK5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TLX8V/uqQKt+sNRcRRZNjbmcHd5Nx++wzz2KhQ1AD7NHWcSFqjTGkac54pI0JDG7RqaCR3O3IAdD9wnpHt8wII4Ckqu/zXpHUZ8Z4kXr3QtkRleFiRmPe+nvNVQ6BNR+y1BDD4cgTzx9htQohn3E0Em6+BLA+EUcsbgH2mclRq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yh1ezxU0; arc=fail smtp.client-ip=40.107.14.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6w6pYO3SI6zufBTLyd/1lZlNJ1iW0OoaWJSDpLPvZIXGZfgwyOAXZmoJKlNURTFWbcMRYbR1TA0Hxis3AEd9gQX94AMM8Bo+Z6sIALbFCRhNQSZLsWUucp6PtqoGehzytmRh+IJ0gl5CVWFYp5OilEKYyt/0kqMeGcRJMi1Bz/Rn1j1oMYHmuIFvMQaRij8kyVJHMgIMWduFLfuv4jDKZFIHflgarUcDjxePu4/e8/vQaX6A1bEanWn8tmUpmz6rNnfDwVI8PcYjLv+uztMBdT7cPjWugiCkk90pgVYFMQHo6+gThBgkOd2vQAYLYL3iHgpWHLq932GXk3ZszSHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb3SJnVjyUK/H8mIMcPWcCCeLfmXXe5ShA0KaFvqf6o=;
 b=JRvNAT88bjW4v4yfHjjnzhYwGa66yAxwpSy9juall3LUaaWLaoy4D7DHFspBpCGzJQ91l/HaVoz/GHmL0ULtgC4WPfDMuLpbnUxucXLj3XJD51Tr2L0qH0AUsX6ra4VsmW29i8DVx9sRt3U0ABsif9rhtjVcxzh1RmjJwMGcdad6GhFB1VVu/w++60vQ957JHzbwpujMy6Na2hZjvIUFMRixFpx2XP4i8rXyo8NDxu6e5V36+V0tWTBd+v/gfLQaXuqFGXpM52ob5bpbDogg6glToW1rKMpRue83577cdcnAzaWTKZVWc07ARzvfdd4tRNfi8sMR5HSD4aTdKk2rHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb3SJnVjyUK/H8mIMcPWcCCeLfmXXe5ShA0KaFvqf6o=;
 b=Yh1ezxU0uP9Ih22sY87LZ87x7w/AEZ0gn6NASUcRps5wblnBsFpYq13gxIlUnyTs8pY8BFrJ0rJqc7HyHRBhdz/iqBVfyDYydTss9vCw7IfXrPtqT32o8NVz6WYddIigYKjhqeK42vWlaR6GGQL3FTm8en1b9RdL9Wouh1rSatY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB8111.eurprd04.prod.outlook.com (2603:10a6:102:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 11:48:13 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 11:48:12 +0000
Date: Mon, 15 Apr 2024 14:48:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: sja1105: provide own phylink MAC
 operations
Message-ID: <20240415114809.7d7ehsd5gfwtwxd2@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rvIcT-006bQW-S3@rmk-PC.armlinux.org.uk>
 <E1rvIcT-006bQW-S3@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: AM0PR08CA0021.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::34) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb19704-4dea-4639-1228-08dc5d41edf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XP8evNaAKrDsB15Y0lBo4UbDvn2Z+teHnUkyjY9UKfLfMkhu+3eIy5Ud5wyYuxVOr0C+I0TCpn/4rLdv/272mpjMraX1aMR4yu5ZJ8YvKSIq5WBoCGjvmzZLfRK1v/PooCDU9FCK60Zl2DT2lgOqZdpDY6eSzMc6aq7Y8Sk1ZPLrYVgIbhnEaQA7RFYcOoOWwH9p+kycLy/HMq+/wFxgnErmk4uqPwLvGueBxP5Lcb4PVcA9QdvEJCY6h2Y4HGHVkCskLilsv5DR0enH/BMBVCwnLJPgxsMllwg3gjzPg4nvVRiZS1jQMaV8TD4hSReas2qbWI1Fi9EPCXs1obVp14NcUnsvs3kfvM0cZEQEcUrkE3V6gq90kmVCFsJRaAc8V4rkqvmh7ZxVsIWEhqMI7+f5xAtLYr670C1nR0L4T0GLwN3QI+UxFzm9DTJX33F/HMuGEeRp073WLyeLDX/lMD8AvcOVZMcRxkjsRAFi4QcUg+LHS6BgUx49HMbo95KrCF+bEbC/sMqwM8QWD3Bdt55bQH+LH/g5twunurNqvG8NIVMyg3lAIhI4Bd0RywRif7DK53CaJHnLZd4sI9MSIPPcrqiPIkE2pUV/N/wy/DpIf0hyV6+VHRWrZwfKWuFtSBbEBkXBDwX5p7fMwuTXWWvCALiUd/Xj/7yIhKBbWXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kt317L/xak5ZG4qstyYH7akzR9SVFi61Gx6+4ilRaA/zKnTX9hlyzzkhQB8?=
 =?us-ascii?Q?LQvASb7MoUvHBhggBVJCpu/6gaUqkx/7HUbaQ8yQ+mhH5B7ztmuu1VcLeYhY?=
 =?us-ascii?Q?z2+FZ3rjeg+hPQXaKpJl1uImxwEYzkXzC4L0hLcKV6KC0kjRvBXw+fztq3xW?=
 =?us-ascii?Q?yJg39krzpj8f2hZSq081q5JT3K1CRfvPLHHDVbmqVCEoYiju8rpM167/PMm8?=
 =?us-ascii?Q?cIJKuiNi1CepgxVkkpQGxfJnAfVH7G1+QB0EG1Brxzyn/8FjKBDlmDitE4ZE?=
 =?us-ascii?Q?QIa0kC0/Hw3yRp/KFMEW3BoPh2dgTrWaxqTCDzYTxv7oeWM0sW/EtfasbZw2?=
 =?us-ascii?Q?vq2smWo0UmHCAObqizsw5Bp0TIcNLwBMGWVu6nPlsQMyux2FNI2iM4mXJBrE?=
 =?us-ascii?Q?ap7cr2Rp5WMwGcKIRrBo66dG4G4Ba4bW/4ATrBTG2Edm16bQ/cbmvrHUm50t?=
 =?us-ascii?Q?WaSlbXHtBR5tIJpnFx0F27KNchFGzSSensmqYT3zkcW2ZlpBeFEH50en4whE?=
 =?us-ascii?Q?YN4n8i9i+dlJcNdYJPpfFmwHkBvhRzA94ccn4YJAh6mkc7ozE6EuOaa6JMuw?=
 =?us-ascii?Q?7y797uYVU280UCuNDHZBPPC+LsnA4jMZvjxncGnRNVA3guAWs3iJ5gJb0u5G?=
 =?us-ascii?Q?7xHr8j67UAiNHLtxq0+ZfPym7GggANRcL7zbyCknWD4HZmUUQ1wnrWhDmR17?=
 =?us-ascii?Q?p2o8hYgntLYIV6ZMaUYpGJaZ8Mzk2ERUuI8Wwcgtj5YZ3HdGTtM3nqftDd1e?=
 =?us-ascii?Q?EtiEu/zcZ+HfSqxAsfsb2hggxV0IfUKX+z7Prf8fZHMLcO/s6WmFPapnULuN?=
 =?us-ascii?Q?NkOv0Tq4KR8zII9jF2lV6PY8jMJoiktu1myTfCvfSDweV/JIYMtw41PRcxDY?=
 =?us-ascii?Q?TmvhAJqMwbv23xExkwq1MDaYCXs552GMDeQns4zxqGrXyK44paZ7bUCMwiqe?=
 =?us-ascii?Q?zWjdGMWYoBZK+asyAPclr4tuai+Xf8cOtRPD5h92Svrr7UBvW454NJzRRj1m?=
 =?us-ascii?Q?IMvX7nxzUDAIaDb4Kx9QUme8CmN6YhbOKFj2aTTniqL0fW4r+8g18SClxybQ?=
 =?us-ascii?Q?ov7P3TiE1FrFlSUdB3DMX4nE9Zf5axbf1Nit2JhrNZfRMx/72euROqjUEWV2?=
 =?us-ascii?Q?cjgT4ngJ6jakrO2hfDYK2sd+Hq+rQFOdYbH9k2OLE26Je4COmVaOHNinao7g?=
 =?us-ascii?Q?i0VBwLt7/rQwLBZ08hEv2OoAYiA3xXQs+gkMXJakQjlVcodmScPPrYrHIGqM?=
 =?us-ascii?Q?JDsvhL/D7uVlfb9KjFAWyTCzZL7CwLZ6PtRQe4Tia+3yMZ/OMglXHhwpanr2?=
 =?us-ascii?Q?kgBAgmE5ERz6DnAGi5AULrvRlp0GZxLJ0Bgx4RoeOiLKRRrMPyS0hjdpYRif?=
 =?us-ascii?Q?taWOK1HdsaltA1J5GV+yGOTB6/Kn5Tz60J32B16FT9Jqh0kGWdkmGIY/U0NC?=
 =?us-ascii?Q?CmpIbqwGUVDHu0qxl/E9a0CnFgk1fAOotVTplhJ6fcU9e9NfjEOyqlREnR7y?=
 =?us-ascii?Q?AtlYaGbCrbtjni8hFA3rDrFB/JComnDiIRCqlwUoTJVM4Bny+hxGati9Mh8f?=
 =?us-ascii?Q?h6d136P2Fp7EjyFnAB4Lyxa54txnEuDhHGblTnMAUeUzIQJWxEQRtHx56cbg?=
 =?us-ascii?Q?L2OpVzZ6QVa+ANWhtqse8NmNmjMTVlhnks2TTu+vvMQXE3z+whYWAAXBEz+S?=
 =?us-ascii?Q?WG2tiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb19704-4dea-4639-1228-08dc5d41edf0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 11:48:12.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qghdYr4ZjLy/+J5kW1m/PLY0ruCp84Q6YkqYA5W7z5kf7okYfySaVJNoqEeAe+xwSAIU8YP2QCpKWe6oJJ1LvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8111

On Fri, Apr 12, 2024 at 04:15:13PM +0100, Russell King (Oracle) wrote:
> Convert sja1105 to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

