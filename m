Return-Path: <netdev+bounces-109260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9F927981
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C688628A25A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD21B150F;
	Thu,  4 Jul 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="SOlzHxIG"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021106.outbound.protection.outlook.com [52.101.70.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9781B1434;
	Thu,  4 Jul 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105436; cv=fail; b=eHBg24NMbK0p6Aq/iYSAfD4OvRigaH84zNrQvby7gAtAdqaSsQXM0YbPETIEJEVzM4Cr2yRkaYXOSsa87rh4AiHodrOWtpgoVwbSlUcWRf2wa/L3r4yDlHkL8d9w2XJ9qccs1R7iBYkVZhtVGFbsD4ccdczdth8JLSXtN921NGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105436; c=relaxed/simple;
	bh=u4mC5KtZ14UZr1liUxKPQvvalqsZt+yOK47rX6YcEeU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oTvJzrW0lrKMuK7EJM07IhHtPD/QkKxjIoHCvggCb8uoCjY/G3E5nnLJrg7vbI+bEatdkje3nGKgR77JgMAiJbKZ+MFaBQnDcuEMpnwNUDmBqfw8EqV5ddVVh3RY4imMfWuWD6PFrCzGKkGbK+XSTgA2h2v9xYZ17QWb88q1Kjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=SOlzHxIG; arc=fail smtp.client-ip=52.101.70.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHI2RPrs4H4asNLpU6JJlnfa5x/JSgxs0JFx7TurmqzLlZrvpCx+6bN36N7WBaR8HIlKqiH+vgoUgZmzcg/mxBF866/j27+p0pE+f9yo5SpkWobXnUzSqvOaBzyESdK2OeHlXAs9i+wIcZP1sVjfAgZIkN8dOTVi1k6e/nYK08DsWCSXb3rEA7a2wyd7DKu8uWd9EWK6FGqVI34GZ41X39sPFupj2mAQVvR6dWZmNJ3PFfUB/mUkwvqyEZCxdeJjdIBNEt+vETWDnD8HmLPRKnosw4//oEmnAUfp8QzfljclQNpHohXzj+DvLi20JVUe/Udj4pU/R+lrRQIVUsKINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r08/CNV3F/rcH9+hHhCR4c0GUS5lmkiVa6u9/WMTL0Y=;
 b=TwDlEoOq5LK1tGV9SC8SQXY45yKLAfrPzl1U/FJqdTEsVEakeGXVKU1otFqAdFmzfuQaOjqa5GX0re2Q8/b6kesbch7aj0DGSyykBm/dRsVwome9olPrn83O4GEKsl/DiAACyHN8k3YscjsLWXNMuzEkDTa2FywBhnqc1H/s6XuISEbsBh1NxgL4yle7hJSESTc/+hvC6BOMjJxUfuTgqq8/nibjvLlqbzvzWKDrRykvf/6SqEy5zlwkxvNek24C4qa/6dGF/alpg03LnhUYRX2HfvjdmHQYLeBAYNW9/FysmfaeiRXigtnJBrXpCKRvJRKZ8JDV7UXXL8PWBOMtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r08/CNV3F/rcH9+hHhCR4c0GUS5lmkiVa6u9/WMTL0Y=;
 b=SOlzHxIGZ1sWzQM7Gx/qeNlilfDvfM1k6b2wNfW3PBTHfgFPsx4pT+FGOGZte8/KdyVWM40AXubMbCtt4Usr86f+WRnLHzIwydj8bbb96UdBt7aYF5cadPyGZLX56xZxTS34/eK+CGFroOqyUyfh1GOJ8rXced1K0P2PkU5vGs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 15:03:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:03:44 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v7 0/5] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Date: Thu, 04 Jul 2024 17:03:18 +0200
Message-Id: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALa5hmYC/23O32rDIBTH8VcpXs9xPP7f1d6j7MKqWYU1lriFj
 pJ330kZJCnBq5/w+eqdtTyU3Njb4c6GPJZWak/DvhxYPIf+M/OSaDMEVCCF47H3QgJv9cKdctm
 ZEE8QIiNwHXJXbo/Y8YP2ubTvOvw+2qOYb/8zKNaZUXDgVgiBNijwIb+3+lUSH37611gvbE6Nu
 HA6G47EZegQ0UebMO1xueJiy+XMNQRjk1IZwh5XC9eAG66IQ8CMnYgWktvjes39hmviXisv80l
 H63c/bxZunl43xJ2XxJ1JKtpnPk3TH9Y9pCTjAQAA
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GVXPR04MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 59aa3144-c3d1-4b32-64f0-08dc9c3a7fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzRpTmkxTUFtV0VKMnRFNFd1MFFKVzZ6Q0ViUlhDUSttQjllcVJ1ZGxHMlNv?=
 =?utf-8?B?S0FBaVB2eEgvN1A3QURJZ3hoRkRsMlQ5bjI2MHFJelFnSW9UYW96VFc2cGZm?=
 =?utf-8?B?MVhQMnRHVEVOSmQzZTJVTzJpZmR1SlNHdDZNUmdkbTVsMlJhOVZQZnFTSldW?=
 =?utf-8?B?VHhGWDBPT2tWTGRrRVM0NEhPTWFuclhNc3J5R1AvMjdSdlQwbEY1RUo5aGZW?=
 =?utf-8?B?YzlSREtjV3NBOGh3ZlhSVHI5WElRem9HQ0Nna2ZUSjRjcEFJZ2N2ekJKei9X?=
 =?utf-8?B?elBVai9mK2dhZytFeWh1M1NITXZ6SlBNbFVRNzA1S2ZmMDNUZnJETHFWais4?=
 =?utf-8?B?UElvSHF0WTJFSXlYcC9wd2llSFF6dnEzb24zZVAwM0piQTA3OVZST25BVVYv?=
 =?utf-8?B?bEFvalY5MkJxQ0pzdmlaekhKZkwxbXd5b241RFNIMDVjTGlmZmVPWi9IY1Ar?=
 =?utf-8?B?NjFKQlBaamJyWlNBdncyWGVha2hWV0FPdC9wNTNLSDhyOGR4c0RuYWZLQ2VJ?=
 =?utf-8?B?cDJmRFVkQlQzMmlLQ3FTMUxIWExVR25yYTVuL1NYR2JaNk1nT1RLT0dHdGJk?=
 =?utf-8?B?cWJaeHczRXV1K1Y1aDJ1anVaS1NaSlN1VVA0dkNnZ21UMUY4Zk5vcSttbzlN?=
 =?utf-8?B?UVZTbHdaUnRYNHdKTnRsTzNYUHpJbDdtM1RGZFhNTHg0djF4ZEdkV3g5SERZ?=
 =?utf-8?B?blh5NGpXVk5PZEhkMW1mMW1ZbkhvbFNaT0FMVVFoQVQ1dXdSRURzUEc1dnJE?=
 =?utf-8?B?WGhHUi9ONGtZZ2lhU0RhODQzMm5Yd1E2TzI3OUVPQ1FRNUxoTkpKTXpLRFl2?=
 =?utf-8?B?OXVnWFg4ODlQeS9KTGRONFZFZEY1cWRYdTVUdncybnRiQTZuSk83SkZBM3BI?=
 =?utf-8?B?amo4bjZhN0ltV1JIWEJUVFh3MGtBaUpYbE5WK0pDekZiaHZWTU5EUUtuMURs?=
 =?utf-8?B?U3E4c3BGYy90bzA2VVZMMWNKLzVPbkRlWGRlTUdldXI3aGg3SlBYN2hhSVlV?=
 =?utf-8?B?YjJHWUpJVHNTUjc3VjAzUzJCbUJJaUpmZHVPWmtobmtGSURtRTgwS1lWVGdw?=
 =?utf-8?B?RTU2U0FuamlyV3NPSWNtY1haM2NFRFhhOUt3UVZiaWhBbXoycjltNHhiS0NK?=
 =?utf-8?B?RDJndlhVRjRSeFpGbmZlTW5JbGxucDFkTFByQTByeG9EaHFvWmZVSElIR0ZQ?=
 =?utf-8?B?WWh3MVk1RGtxVjBqVWJPUmJqNW5Wd1MzWmRkL2xiZVcrekNvaDhYR3p6NVhK?=
 =?utf-8?B?MXRXTFVjQmhPNjU0Q0VMWk8yb2psb2RRRE1SRXU2Ni9WMTRLSXRHNUpxWmVN?=
 =?utf-8?B?K0hSL01JU1FabStlWUY0U0FjbzRnTEZrUE9DaWpic09TTjd2bGFndVUrcnQw?=
 =?utf-8?B?eDU0ZDJLekR3a0YxeWJ0K1VzUVZMTmRUT2ZvL1ZPN09qYk0wd1lIc0RUR3hY?=
 =?utf-8?B?dFlqVHEvSk1FczhrWWJzelN5RmZTQVpZMER2Zi9sSnZsc1NnMTU1QTNDWmhh?=
 =?utf-8?B?MmZLRlNxRDFnWk8wb2FBaVV5ak53cWZrazBQRWZjcUg2bkFFQjEwMHZNTVY1?=
 =?utf-8?B?N0p2SC9UVHhNSjJoN1hpK2VCakRJL24wNGg4MitkK29QMlFtOTQxZDJGRUpi?=
 =?utf-8?B?Y1ZDZ0xnR1dCSDVUOWw4MTNFclRlZURtUkIvNTA2SnRncXR3YjU0L1Fyb2po?=
 =?utf-8?B?OTlRTXZOR1RvbEphcUdsSkJ6Yy94azdydm9sZmY1SUhKTGV3ZVh5MGs3SXc4?=
 =?utf-8?B?ZDB2MEExOVpHVEFjUWovcVZIamlYcGpjWEpXUEdYM3RpbjkxNUNDc2V5QmhG?=
 =?utf-8?Q?PJYx0Dl2xn+HHL+4Rh4W+QppNmeRF6SS+ADdc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmZqVzVra2tsWnBad1RqRnUvc0ZhUmlGWS9UVDRCLy9wQnRLWWRiVGJTVHZI?=
 =?utf-8?B?cDNlMjZWck1mek5uQjJYQXk3YktFYTY5b1FMVUZzcVpaV0tvVjZFbUxPaEM2?=
 =?utf-8?B?VjRiR05zeXprNEt2N0pxNXJNckhaMGFiUmJQK1VMV2tIdzNIOG11bnVEZlJL?=
 =?utf-8?B?dlR1T1UrY3hVM21nMTdpOGNpUmVSNE84Q2RFaWlwWEU5VE5RZ200WDFZcWRB?=
 =?utf-8?B?SnV2Q2dkMFpyKzJqSmhzZ3lnMUhOZ0YrZEJDQXQwM1FzK01Xcll1TUtKdlZp?=
 =?utf-8?B?c3o1Y1pMVmN1dHNzU2psaWhPNWwyK1ZHUG1qYlZzcWpvR3BiY2xsaFlOZkZI?=
 =?utf-8?B?NjdWTVg0VkZjYitGK3pZSU5RMEtHRFZtQjkxN2NIeVhHbWtMMkJtZDNWd25p?=
 =?utf-8?B?eWZPSHkzcFhnayt2SkNiZnVscURHNUhEZ0xYNzA3Yk5MaXo1WFRDVC9DQkt6?=
 =?utf-8?B?eHJBL0lTa1loNGVydHM0OVBtNnlPQ0JKbStYd2d4dzRJaW0xMCtGTE9rVUVT?=
 =?utf-8?B?VW1WWHBzQjhvUkU2QU5zKzE5YklJY1JIOXA2TUVDSU1LMnA3SkRFY1VpU3Q0?=
 =?utf-8?B?dHJseWtuVmtCQXlNUjZHMHJhTDBJOTVNQnRDT3Y5NldBMDhvUnVqMzJVZHRj?=
 =?utf-8?B?ejVadWFPdG1wN3kwZWRpenNvT2tBSDAwK3Z0UExSRGgycjJPU2xSRzAyMXBo?=
 =?utf-8?B?eUJVNVYxam4wU0lNanVvaUh6NHBqaHFpeUY0bjNRUlVTWmZaN3FBTVVBeGxq?=
 =?utf-8?B?cHlJM1ZPZVd6U2hldHZXWUQyY3JKUkRaaW40ZzZJTlBqczR6N2hYS2FmSjdL?=
 =?utf-8?B?K0FKUmNxYVNQNnRxUWZoSDBYV05sY0UvM1BsQWZDUXQ0eWFXSWZZcWNkMnFm?=
 =?utf-8?B?RWh4L2taV1VkQTRTQmhIbElxWmJpZzdkdjQ2VFdrSUY4aFNpdXhwWXNiazM2?=
 =?utf-8?B?bksxT0VjRXBuRE9NNEtYVGdzS0VwRy9HRWx2aVU3Q0VUaDVFcUxGSi8xN2tn?=
 =?utf-8?B?NHFlemtXOTRscGhWcjROWTJqbzZWclR5cXlsWmttQnRYV2xNM3dOcVJ2aEJT?=
 =?utf-8?B?YnVybGovNFpzZVdzU3MyMW9kVHpCdFlvaDIxWG0zSHl4aW54d25JWEVUVWRW?=
 =?utf-8?B?SVBHTFl3SFBWaDlLVGI3VCtySVpSVUFnUFlGL0hRbnJ1RVN4SHkzTXZmNkE4?=
 =?utf-8?B?L2dIc1JSR3pvTGFTTFcxT3Bpc2gyNS9tZi80dXF3bTVXUG5waGVxSzBPa0hz?=
 =?utf-8?B?U2Q5R1hBajBWeU5lVjJocm14MGJqTzBmZHNaTmYwL1djTWRsTWRjbGQ5N2NN?=
 =?utf-8?B?Ynl1YUlOMU91QjZySWVHYW1rcVVxRmxKNGMwWnN5Y3Z0N2w0T084QWdHT1J5?=
 =?utf-8?B?Rk1JMEZYTFh3RjkwOWRIZURKc1ltRjNzd1NZbVNINXFRSUVzU0JiVzBlaEU3?=
 =?utf-8?B?MzduU1dMZnhSL0VJN0RsNHRPQlFrWGdRa3lDcDhDeDlhRE5hek5mbjFYYUhw?=
 =?utf-8?B?c1AvRE56d3JDTWNSSXFqZm11WlZVcjFEdWF6TTNRK1g1d3RLVEF0SFFzRTB5?=
 =?utf-8?B?VXhERFBFTmM2cFZaUlBMdUVRVVZyK3lRZUthR0hnZjdNcXhvYVRvU2tHeno1?=
 =?utf-8?B?bkJzWjBqYlRpWElCd1lrdCthMlhCWWFJWGdFUHJIOUJRc0JVaC9ZbXlDREFo?=
 =?utf-8?B?eXlsNk9EK3pERG9EN2tUckt3SFE2WWpVREN2b0gyaHN6TktEMnJ5b3ZXQWZJ?=
 =?utf-8?B?SUR2OXNnSXZPVW5WSmZzLzdyQXZWdm95ZXRhMVFUS3BnVXQvR0ErQjc2WFV5?=
 =?utf-8?B?bGNRY2dzejBraFlEcFlpaWVjSis1VzY0SGUvc1RXSFhvSjZ4RlZJcmh3YWJE?=
 =?utf-8?B?TDdpVWtITFpvUENDc1NPdURucW1udklreHVyQW9tWE0zM0JpYUk3cys2WVlq?=
 =?utf-8?B?eXhwWmFiWGU1dmtHRFdBVzZWZ1hZMUo5d2svazV4NFh6UnNSenJIUFh5clds?=
 =?utf-8?B?Z21iSnA0TDFoTHNkS005MHoyNHlLWTRWbGcvZ0RSamZ3cGF0cWgxYmEvRWxP?=
 =?utf-8?B?TEJTREk5dXh2MkdWN244NE5lTTlkNmZaQ2NZY0ZTTmdSeVBSVHUwU0k0c2Rm?=
 =?utf-8?Q?Dz/rC2whbj2XA8sxpwtm5bX4g?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aa3144-c3d1-4b32-64f0-08dc9c3a7fd1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:03:44.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWDAgphBDHtgT3Ir2q56VOuhWur5NPIw9mY7WA/cGFj3oEi/2EPutsvQukA2X4gjwQC/5xJYWmYsLGDmndqQLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928

SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
SoM used in Clearfog and Clearfog Pro boards.

1. Add new binding for compatible strings closely matching the original.

2. Add device-tree includes for SoM and carrier shared design.

3. Add device-tree for both Clearfog Base and Pro.

While dtbs_check is happy with LED descriptions behind dsa switch,
functionally they require supporting code by Andrew Lunn:
https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v7:
- dropped dt-bindings for usb phy and adc which were picked into their
  respective trees
- Link to v6: https://lore.kernel.org/r/20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com

Changes in v6:
- add device-tree for cn9132 clearfog and CEX-7 module
- add dt compatible for tla2021 adc
  --> I don't plan to submit a driver patch because I can't test it
  --> might share untested patch
- add dt property for swapping d+-/d- on cp110 utmi phy
  --> I plan to submit a driver patch, already prototyped
- removed duplicate node reference / status=okay for cp0_utmi from
  cn9131-cf-solidwan.dts
- rebased on 6.10-rc1
- Link to v5: https://lore.kernel.org/r/20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com

Changes in v5:
- replaced *-gpio properties with preferred *-gpios
  (Reported-by: robh@kernel.org)
- removed fixed-regulator regulator-oc-protection-microamp properties
  This property is intended to set a configurable over-current limit to
  a particular value. The physical component however is not
  configurable, remove the property.
- kept all review tags since the changes were minor, hope that is okay
  with everybody.
- Link to v4: https://lore.kernel.org/r/20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com

Changes in v4:
- Picked up reviewed-by tags by Andrew Lunn.
- fixed a typo and changed 3-line comment into single-line comment
  for clearfog-base/-pro dts, but kept review tags since change was
  minor.
- Updated SFP led labels to use "sfp?:colour" without "color" property,
  to avoid duplicate labels while reflecting they are each dual-colour.
- Link to v3: https://lore.kernel.org/r/20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com

Changes in v3:
- picked up acked-by for dt-bindings
- skipped acked-by for dts because additional changes were made:
  - moved legacy netdev aliases to carrier dts
  - fix status property style errors
  - add pinctrl for secondary spi chip-select on mikrobus header (& som)
  - specify spi bus frequency limits for som
- Added CN9131 SolidWAN board
- Link to v2: https://lore.kernel.org/r/20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com

Changes in v2:
- rewrote dt bindings dropping unnecessary compatibles
  (Reported-By: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- added bindings for two additional boards (cn9131/9132)
  support planned for the coming weeks, mostly serves
  illustrational purposes, to understand cn913x variants
- cf-pro: add description for LEDs behind DSA switch
- cf-base: add description for LEDs behind PHYs
  (Reported-By: Andrew Lunn <andrew@lunn.ch>)
- Link to v1: https://lore.kernel.org/r/20240321-cn9130-som-v1-0-711127a409ae@solid-run.com

---
Josua Mayer (5):
      dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
      dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
      arm64: dts: add description for solidrun cn9130 som and clearfog boards
      arm64: dts: add description for solidrun cn9131 solidwan board
      arm64: dts: add description for solidrun cn9132 cex7 module and clearfog board

 .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
 arch/arm64/boot/dts/marvell/Makefile               |   4 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 375 +++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 197 ++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 637 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts    | 673 +++++++++++++++++++
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi    | 712 +++++++++++++++++++++
 9 files changed, 2954 insertions(+)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240318-cn9130-som-848e86acb0ac

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


