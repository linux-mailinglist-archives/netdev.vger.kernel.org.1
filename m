Return-Path: <netdev+bounces-206737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769BB043DE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038C87B8492
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58226B0B2;
	Mon, 14 Jul 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="O7VHYjXy"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588823A9BB;
	Mon, 14 Jul 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506749; cv=fail; b=T+xZ1rcuuAhMFSlYJWK7+EcOWIGCehKSPeCXzEsDZXLJ4Hm4jjO91/W+atw2ei1tYzOK3GIfZ3p1lnN6W4IMJdaypD77XzX2NdI8bZBcoBuwiXTU7L3JJQEcLfzzLBD/jPaf9elRf1SJ4CzEju1v5DwQVYdWh5r27XjRq+XRX3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506749; c=relaxed/simple;
	bh=w5ZI7TTU0cORvA1cKiRhqfTUODR/UQ9pZJZQlxWKM0k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IxSG/Jn1Dj5VCsVWX0OGmO5K8zfFWTQ9ErQB1hnEQasOF9FyrIHGBHZTva8GmMS88rRTvejDCHk0ZoTDnXoLEWlBHBTM5KNV50XNZlxb4aCJ4fXtgBUYYu8Hrx7ERsEcDORdA3bTf8qUM22eTuN5G+fc2n3gfLX8CumCIWQFkls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=O7VHYjXy; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSZ/mI0168EWPO9g1gW6yWkKoDG6Qem68tOyYvwVj4XQuCMdiFXKqqAvyyGENIqhVjNXdGDHx54jhOKnpV7n/3yXlvYy3ub7pxfqCC4WtZ1yepla3QnBra5ATyTKDmNPwZo0TriqPNPBCQ1HhOOyMDrL67CcAFcv2lTD37xuw3PuviQuRDIYXnXKGRTNH7geOJZIdCYugxD6L3gtQvEr1QkwSb10MBiKjwAyedh5r7pwsNUWTlYEVOpoYAp1R5cpqGjRGCDmOeS9tTqZTqEEz+YXf3aFcYg2+kgK+ieAb5hMMtSsjbAGSrzEOeA1hxv9IAL9vs2FoZeuRP0i3s/fRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRgFKGRqWwZwC2MrVf9mTaxaoAmdNpgj+qUcDwYbZgc=;
 b=yF5yCqsp0xjZBxZcyFBwrE9fxJJrdaij7VWuASdBtjUwkIoXWM/9NleeQW/olkfP3XNoW8vRYu87l2JQ4Hi7Kdvz5OmGXSE0c14hZX+2iLs+myECXyCSibVEJr7df8j2+nHwMGOxQD+lrcQLFrQu1XOgrfOJ3lSbntsY/eDmDl6lvRjn89LNOD8CC6gloAtEWEalIO6+ch5dBjM3fqyAz0pWgR64wYcZm4GJFQW4eDkrEihmkM/0jrPDkdNIGEvQIHrc+/mJPM7lzaXPW3JYjDIJF60/MWEXSd09INFx9ospJB9y1GtBXCG8tWbO7aZqHsgKtWUJd1+80PhbCySExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRgFKGRqWwZwC2MrVf9mTaxaoAmdNpgj+qUcDwYbZgc=;
 b=O7VHYjXyEZ0gZnqEKyGb4HW7gZyOWnqucTJ6471ZrBRHR/XSCfVUyjvgTsu1HI3mrxVYccYiyuWXQNN5/fldcCPya75+xD6plVhbUVPDUhW2cXPJ7BOpQ9Gng7A5ckUy5KHNKqlSGK5UG8J1eWmGr2gfFBvMBiAvt/Zj06zCpbA5u8CZA5WuQfbfuaujlPy5tUtx7WH4K5z+9rFgdMUQMTY27NylU6W0Kh5y5G0nuN56ZVfCKkrWYe5PtoliWKUa0GNdJMzSgD3FvYC649yA6VtVYYtjXVtXHDnFCd0GvAkx47YTCDrkVPkMqVlHrWywDY4GNanKOOTFLVpHfWo7qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH0PR03MB6368.namprd03.prod.outlook.com (2603:10b6:510:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 15:25:44 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 15:25:44 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 0/4] arm64: dts: socfpga: enable ethernet support for Agilex5
Date: Mon, 14 Jul 2025 08:25:24 -0700
Message-ID: <20250714152528.311398-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH0PR03MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a195bf-35d9-4be1-0bc7-08ddc2eab302
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gl6VvWnqZxVLJ0g7E7JjP5Fvt1rs477Koi3jWZ0jZg87EtQIRSGCyD5I9Huz?=
 =?us-ascii?Q?pwQWwi/s/g/nJEfMNPtDqoQkOtEcks/Du+cHL2ziVSAI6BSn8x3giW4vNQCC?=
 =?us-ascii?Q?q1BgMr1z79YyyWhwj3tFbQWMPZkivDPI8jb9SxD63qtZvW97fJaI9sQpteuY?=
 =?us-ascii?Q?L2zbG0cmbHkh+6ifeHx6w4lBFaUa3ZJ1EJPTfRQ6jMZC3Imuh3LG1U/iP0W1?=
 =?us-ascii?Q?TxV6lqPt9um9she4MZM4xSGV2uLngCAdq9W/nH4BBYbjg2qUMQsHtgqbkznc?=
 =?us-ascii?Q?sxIrLK314I6QCGYFgzHj3yXzbwf6wPEElpPyXS5h2TEWTAFJvVbMePzO6yvA?=
 =?us-ascii?Q?y7aQClWT6y8IpToqyHI7LV98CcEEWIYCBwX83WHWiaoiHB1fgqaVDH8lsmf5?=
 =?us-ascii?Q?VOmedwjSbmQDWBFqXL0Lr2/rSDR+l2tQfJpkgDgVhQCK6Z/u+fQK4Od4qxMK?=
 =?us-ascii?Q?4Zx2SRqoUfz54LDmIJAO+hbycFLGXJ4enck+FWTEzei+99mvIs+V0X8aNEiI?=
 =?us-ascii?Q?Yycdylcuif39gcsULwhw/e40ZF6Q1Ksk8aHKtWol3v9fNTk5Ids2NVSKHMF5?=
 =?us-ascii?Q?mqs5IPR5NmpZ9hnqnOvMeJ+rm/q+EyjeVTwOOPcoXbYXs+mb0OjNdfmjZVEV?=
 =?us-ascii?Q?vVFILHUlc9xPKBYs8ieeFYYjzkTf3MhF71V0pz4eOQqkcZRrXRszf9rstcHk?=
 =?us-ascii?Q?LugV8Vun/O27d6bpJa93H+Eyj24WKHFqWlprbCWtljhVFgKJOhZF771VACMo?=
 =?us-ascii?Q?UFBl9S2iWTjz1x9hzzh+ZdIYofNdLnusaKYdtYEYdtUezCJf+qS2D4xHSzFu?=
 =?us-ascii?Q?Rji/VkxgsFOpQu3LsnJdrgFqCIW/PYDEedOyGMUKErAjECtVqUYkmY9bMQBz?=
 =?us-ascii?Q?pjExEnE6wftalqYqwv8xo57Dn+52k+AEImSPZPMouIq+7xRW8zh7bGheD8Zw?=
 =?us-ascii?Q?TUhyiAgz5JwzgE3VgL/2j9UFNX3AbSm7iZpoWVyrGseCqiyamFBB6Z3nURhj?=
 =?us-ascii?Q?sA86ZY8Kn0e+uFWBIFnd7ET2njTXq+jKap0O8NCEn2aeMpv4idYnoB0ox2YL?=
 =?us-ascii?Q?N830Ir+JG9hboz0XYkSRc0GFzQ8GD96KGNOVCbSRFRvKC0cZrt6jsifLYwgi?=
 =?us-ascii?Q?yTF/F099Il+JJjouA9XUBOtYzYO53s4xxfe9mveM75LlLVFUKkYBdDPrgW9f?=
 =?us-ascii?Q?MSNnw0aGHjcFfhBthcS9IKXC5Zzn9zdD9T78JFsjePChU3Kl1yUK/x9/V7Qd?=
 =?us-ascii?Q?fepfXFei33Kf0/fr8dYFpWVDRt9b2bUjkJDsWcT+prFMpydJA/zXtEwnrzUe?=
 =?us-ascii?Q?Ldq/8jR+ww8mlv57BG6S2WWNbRm+sqeMMEu8Q70cCLX2gTygb/n7k/Iiu+2i?=
 =?us-ascii?Q?XWdW6OFeFVMj6d77nCj/9UHMInmSafV5flDiXLUUpvulN/lzv+daZ7eQv/I4?=
 =?us-ascii?Q?RthM5i7l+GHfqUAwex8sBR0IhbMm0+XLMnL7ms56qB4yDmJQuTu7Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cenSZ4nQHFiP2+z+n+6nM6iZeOR4NNTpGpJ+pF7GQ897JHh62/F0h5HypVc2?=
 =?us-ascii?Q?3h5CmwsdeYcZvIFBT3TcptZrrH8iqIlKu5+UpjCeFCLwuYVPov44HxU5AAdr?=
 =?us-ascii?Q?CKoSWYS662lTtd72MsuR/fMnWTazC6ATSr+ZB1QBXxhvJzz7DVTmzeUSULo2?=
 =?us-ascii?Q?i9H16j2c0oxg2+mo5JUJ3hV0q0ADIKge0BAGLMs0GmQBS10FDErTDM15csF9?=
 =?us-ascii?Q?kuuRlSJpDnbmNSdDxoPwV+q9bur9zqao92TCFZqe62Azi526a5B7urcBCpiH?=
 =?us-ascii?Q?Mfc+LSTr8ZJeeQcVDTdJZQZo0QIx2oX8nzJVL/Yh7O6Kgl6b/kNRzYKkwYUI?=
 =?us-ascii?Q?xtSNGNL2i2tekEjwd/07KOEgo5hU5GXS+Kta6asn3sTfihdSyY2T1f0RcbjJ?=
 =?us-ascii?Q?Rvzz947LOnqTXBYC6wakBkaeer3LSFT1TeU/O6ER7IigHAy6r13QO2bHVzN3?=
 =?us-ascii?Q?5Wbl7m+X0Lh2+cXJ50QzvF0KDGEt9KqqeiZUn//dpZdCrjGyDO+fb+eGF1pu?=
 =?us-ascii?Q?B9KHHo46QQjk5Okant8VHpXxpBKrQ68j/R22UNDsFg2DmypFXRQdzEEED6mU?=
 =?us-ascii?Q?6BKbTHkke+jHwwyuCj3B/A/znJIJSbMRLF/3MIsIzX8XITpiRYwHE/mnH8QA?=
 =?us-ascii?Q?O3YtqlOtq5yT8FK+BhVYvSzTtpjkFYzbFcNJSuQ7JQdl/+jU+41XNzOYs57y?=
 =?us-ascii?Q?PLDg/L7yVdXyDkrnwaVIodlQEZlwEqEeLCSLuyozRH+ZOR3Rwo6Tg3jTOK8C?=
 =?us-ascii?Q?Odr0yd39HXd1xjnPWwMphvJ/IUctYNO3trRCum3aTgCKJwofpayDtZsz25un?=
 =?us-ascii?Q?1KonybQyXY71j+Y/QlwLF9yxCfK4cJ4IXR6nddTr0fGilkJ83k3hWrjHhFoo?=
 =?us-ascii?Q?5e5BaXC7BtarPSL7zCAxDGa7swLbJIEJ00q8+n7DfwhHhkfNhUsIiAIlZcy6?=
 =?us-ascii?Q?7Z5lAKbRDi3LwT/pZ3RDrn3PZnH93Sp9Bmd2IMYG4rYqv+X10dIZTzO6M5UZ?=
 =?us-ascii?Q?EpGdvwxNIAlhmA7z1l7ZZtycuHBnjLcRZxtCOL18WPq+e9BdDujtrjGj7ZdZ?=
 =?us-ascii?Q?YCuQm5YGRLMjiLyNOqxpxFteerIvtUoPhacr8QyQHcQ+YkVNDkfcC2/LJqhH?=
 =?us-ascii?Q?1xDR+NGM0ubrVU3rFj/yOmvtzr9+iEcOVE/z7Fqfy2tpRRfm5H7WXx99cQNT?=
 =?us-ascii?Q?6YJHDnxGMj0CE5xWE4RPE9HSNwO+DLM+lKKB/tU0ecxcCnuNjnk6wmorSxXs?=
 =?us-ascii?Q?K9/k10zQlTbdYbak9hlojnSdI6Z+AMpTsqx291DmMj8zVjAdr1DVWNlZiLQN?=
 =?us-ascii?Q?5nkuC/TzPLGT1B+RydG+iefWtvK4IPpyXVP0JZ7NFbpwPyGl4LDESisfnnHl?=
 =?us-ascii?Q?UEh/egzsIQiQ4+zh5W/2bNHQExEUqRkAWWh6Z6tthlzSmUXsjjZ1tVaibX1r?=
 =?us-ascii?Q?/aQYOqzOPzp3dK7vWHVT2rKV4ltongdhtt9CUJ9PBPsWOQTgfWyUvianPwD7?=
 =?us-ascii?Q?Z4Wr7g+HIrxTr4KFcf1WuOmBqZ1PKQN82F9jSqwsT3LvieRf3uhnWd6MXjdt?=
 =?us-ascii?Q?ewfqQk4/im2m69EPYypYIF8nbR87SGl3Ia4eavT49q3MkYABrm5jXfycyF7L?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a195bf-35d9-4be1-0bc7-08ddc2eab302
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:25:44.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Z10CWaPhI35+uYaC+/xGA/lbiQDzOL+QN+K4De0S/DHNambGz8pdRZWGhcbt4rc4yYXhIOCHf3o4VHUfOT7sDubPNfZWYu3f6Yb1/YTWVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6368

This patch set enables ethernet support for the Agilex5 family SOCFPGAs,
and specifically enables gmac2 on the Agilex5 SOCFPGA Premium Development Kit.

Patch 1 defines Agilex5 compatibility string in the device tree bindings.

Patch 2 defines the base gmac nodes it the Agilex5 DTSI.

Patch 3 enables gmac2 on the Agilex5 SOCFPGA Premium Development Kit.

Patch 4 add the new compatibility string to dwmac-socfpga.c.

Matthew Gerlach (2):
  dt-bindings: net: altr,socfpga-stmmac: Add compatible string for
    Agilex5
  arm64: dts: socfpga: agilex5: enable gmac2 on the Agilex5 dev kit

Mun Yew Tham (2):
  arm64: dts: Agilex5 Add gmac nodes to DTSI for Agilex5
  net: stmmac: dwmac-socfpga: Add xgmac support for Agilex5

 .../bindings/net/altr,socfpga-stmmac.yaml     |   9 +-
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 339 ++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  18 +
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   1 +
 4 files changed, 365 insertions(+), 2 deletions(-)

-- 
2.49.0


