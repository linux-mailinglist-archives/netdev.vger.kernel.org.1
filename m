Return-Path: <netdev+bounces-151600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353789F02D5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648E71882085
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427ED5674E;
	Fri, 13 Dec 2024 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="Fuaojy8/"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020101.outbound.protection.outlook.com [52.101.128.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B441374FF;
	Fri, 13 Dec 2024 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058673; cv=fail; b=IhgGdM3VsGGJwGI4xCEIBkEioiBc5Tqz+ke4C+DoeqlOTM4xrOeYe60k7hO/eAKmygYteA7sy13GyJeJFi4/r1OXMPPCszkIG7BVPBIACQQlDTiaE3/kR1e80wpIgmnwIXzcSKaSQuXLt60eboTcAnv2hwr34IdH9LZ+auHMwy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058673; c=relaxed/simple;
	bh=5l+lwqkNVtKOg09umtn6rayDQzilNuNA3g4NcA2QdqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:Content-Disposition:MIME-Version; b=CbcxKSxH1OGZcfEz7CmgO/J+Vd/d11v57beDtWl6VeODE/P6R708ck4HI/5LB8w2x2+HLpA9F/YfSNC/4AJ5jF7FuYI+IB8Nsv1AKE9Z1uZ1JfDwv4jSEfymiBiA5B5bAJBY0XoOej0Nw+Pv+MmvNqBtCgkGdcTonLamqoGDVmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=Fuaojy8/; arc=fail smtp.client-ip=52.101.128.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB7W7O2WN7kr5Rv6P+6rzn2U/PSeFUZMrQyCKgnK+p77MvsQ5rZY7fZpUng91CSwjEgFzP3au8k6o5rOoY7uZHTENQbPv7613R5BhkRrO1SYeLL1bFpxhoXHcc10E1DClR+Gy6CW91/hN1UvRgMxuupXYE9vp51GB/y6j2LhBAGNRmqoeBEIuMR3ewQ5iRnw1Qb4D03T5EQJTcAgzDBfCLPivw1/tsFGahAbe5g6wifKADdzeNoX6QPJXCzAgCaHeY25MqgVFWkENP8o/yLJB73UQ6MrN7H2tUg779dINFIKZu7EwdIIZqVojou+V5LMN0qqoZu63M3Ul10XCslE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l+lwqkNVtKOg09umtn6rayDQzilNuNA3g4NcA2QdqY=;
 b=Ss23jGN6b1W1+BJC7tE6QtDTJCi5JETJ29h99AdPdnO8oNMSCbpG/hiCUXGCz9QbAp30xMSHDJ6YYnKIiC6Q8NBGoNS1Kd3gNgK291/rRXt8TheDO2qR1aWtbHeDuTw74fTz6SA0aJXe2GMLqpQcdlUiA4PtKf84yzbrKR+y584Ljy+SdVA4+4dtS1S3JgzmzomnLO3vDV5D0eU1z4YIItrfzoX79KEHn2C5ZEBOuN4g20virrdJl5XmlbRZfZS0NE2SC6MIIkOZAioe75rkWZrv16xG2FjrtEg6vwjZxZUNsybuMF3nZWQ5FZjq1ZooMr9lvcN28+lLg9tu9GU8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l+lwqkNVtKOg09umtn6rayDQzilNuNA3g4NcA2QdqY=;
 b=Fuaojy8/IxU8iPMiW8qLrWeAh+dOhoIJpQpXEIAq/TLEu7UNpeKT9MRHgi4FN0d+UhD1kTJBVxDe6HJ5pOjb/TaOhv+AnI6o6/Ur1GV/j+E6i6QvUVTEf6vRqHjel73MM8VhEiEyViT5wg5uf5dnjqjzi/FM+pmHb9ui6clcBJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by JH0PR02MB6869.apcprd02.prod.outlook.com (2603:1096:990:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 02:57:48 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 02:57:47 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: helgaas@kernel.org
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	horms@kernel.org,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	korneld@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com
Subject: Re: [net-next v1] net: wwan: t7xx: Fix FSM command timeout issue
Date: Fri, 13 Dec 2024 10:57:00 +0800
Message-Id: <20241212161524.GA3345429@bhelgaas>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212161524.GA3345429@bhelgaas>
References: <20241212161524.GA3345429@bhelgaas>
Precedence: bulk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|JH0PR02MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ccdf93-bb4f-4c36-51ad-08dd1b21ec9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|4022899009|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56Ibt3eVgXwFm9SuVIijo/0zVAzmiDYj1NL1wKhfSbfiaL9iN2brPg3ouQun?=
 =?us-ascii?Q?3FjwlHYje3dg3PlMN3aexlKFzyZNtZKR7pIhXRFESsZCY0F0WgUBA4EPU/JD?=
 =?us-ascii?Q?YdTfUBb2lzmHcAqfqSk/TYs8T/aikJCOUJiJoO9zIJHgYADuSjcT4FTU7IPB?=
 =?us-ascii?Q?IIgUXYdTcWHPyH6BJc4mvbv9yE5epE15/LVwr8v/fpVYPloc86l6umIGhOs9?=
 =?us-ascii?Q?eIeORYOtGxGAHbe7H83/Le+UeP/hWbhToCy/WSu5N6idAacBuRnCLyh8LSgr?=
 =?us-ascii?Q?gFzNVuEMV038CZAUHhazeIvMSjrszh2b7Nx5Yv9E5Ao4WXxteVAoIQlb31vP?=
 =?us-ascii?Q?Txq9GaQ3kTYBVx/XVhs+2Bot1xKeTn1PoOA9RzrM+CRppJFLsBJUiQV28HSV?=
 =?us-ascii?Q?v8m+wWmAO5AbUg6PjWsoGXswZWRrD+22psrUXm+jE7amNToRIK8syQrtjNnf?=
 =?us-ascii?Q?nBTcauF5HJS56E+RxFnmDT0jolHCBESbwBF0XBGBe4X0Wj6dl9jJXA41HWBt?=
 =?us-ascii?Q?iGrLVqg1YyvZJWtUy02Lf8lb3dWADT4f5jS26JJJT+nlRoI11dFnyp7zhCwu?=
 =?us-ascii?Q?KHDgLQ17wzbzrqtSuYhCFa5n8GxQNrhDr8kgTmWRBDUbRjrz63AjBREWiJjP?=
 =?us-ascii?Q?2xjlw3l14/+OeEpXczzZ9Wfr3+hdo5S0dBJf+txHfjGnBlqVhB499UqpHZBl?=
 =?us-ascii?Q?vBKAkOIQxdZOyvHeBBNXMZuDJnuC+TFZGdy6hp1vHJffChHgyWt6tl8KHZMW?=
 =?us-ascii?Q?ZDRz/wC9iII+hlLtKHzP6LNb+gLl4p/qgMyXPQO43HQtyX0GCvzZ8qI5QI2F?=
 =?us-ascii?Q?BpZ367yfq+/IXschX/XEf7V0m1jQzEZXT0gwPIuJhzGp9FcYumj5hVS0rvA9?=
 =?us-ascii?Q?oO5p7neOwqefgrYl3B/PIiU7FlrzbHtdnrTsNLVRYDP0sjLaNgKKKXKF235i?=
 =?us-ascii?Q?gX7PIFqkI7M5RqxwRM2ZhW9yQYh5HgOe3mqsIXXDWiuScxkMiTOodclJht0T?=
 =?us-ascii?Q?AeLKjr4QcytwKTyLt2Txna5rnAZAB3nNQgUjgj1NXfxIyQwnhPsUCLAQ49so?=
 =?us-ascii?Q?pqcBTJpwXDx4niMnYYHEneGIH4FwjJPRhTVJtJ1T+AfjHbj4aV/cGbFP4Jxd?=
 =?us-ascii?Q?QQ4iQHwsKFl4xncmJykJTy5cBEn9WASc+KU4X9fpXVflqKQg0bo2JY9dxO9h?=
 =?us-ascii?Q?5mz4sWx9+91JM57LUZMQNyRgdT1l6FoMwA1NBIlQtRlGY+WuQSDFmcmOhJ1G?=
 =?us-ascii?Q?7IfC4qjR/57j5Bk0ThhEwAVJaFQ+GTWKVrr7vCQUKvsImt4JEOTuaaQoaFxV?=
 =?us-ascii?Q?NT2SKZ5n3umpLG2bHAjY508vzpMsh8tkHfrVB3eRCzYIYl1Fiv1pNluKPQjT?=
 =?us-ascii?Q?QK2dXR7DrCgflxHTTsHRUocNBujJyqGOUxu+nZSwq+Ocrw3+0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUbzcQ50/Wxqxt3NGK/3RF+aSFXDRXbIZEFcR7KTiMg7X5oh/gpUkMba+nIT?=
 =?us-ascii?Q?V7MoW7kBUhZY6eYZ1ZrD4QrLTMASF96TG+gLN2QSPqiuvMw0KkmuSxwwFdIp?=
 =?us-ascii?Q?b1U10f26d6qEC/wlukYFSq4QW+j5Cv3PnPNR3GTGL7HL3VUp4DpMXcXtuJ/B?=
 =?us-ascii?Q?/gNLVD/e2bVGGatGZogRz74HArGS3x22dV3YxOpN6qwVudoXOJq7v1k8ore9?=
 =?us-ascii?Q?sK3cxno/O0pbp/tfZhMKTBQmjc5TmCLpLoL1mVeqvXsJGgedmSnEhbOJMgC4?=
 =?us-ascii?Q?5x3Aw5KwX/DmqaMyq+HZvdJSDjTPJ7mTJfu5K6cbPJNwfMKHxwf/ZpajxDjh?=
 =?us-ascii?Q?OV6MBuL/QNAJZ44kFhvKHEt4FizNZYV6vQbyMnzYeSseMitFiDmCFOr/sm8P?=
 =?us-ascii?Q?+r89aKtaTNriN5dUv1yLKVEt+lgc3LPcgvmtO6QZNCwvrcz6VNoqSTAmtBN5?=
 =?us-ascii?Q?qO7EXMovXiTMVWaADzP7c42qTkLZgGpc+TJqNCmmAnyfYu/A1LT24OZ5/yIV?=
 =?us-ascii?Q?oG+PhmmT0Rwy/FDLcR041VHq9Zvuv8BliBmZUd4KtZz8gg0/Tz5J04d1r9Rg?=
 =?us-ascii?Q?0qV23hVbYy6rkBXjlIZTywj+z7clTBQslyILh66pSQCBmqDNw+8+rQPa0UfY?=
 =?us-ascii?Q?ovqaiTwwbrAI1tJ0bmxOxpCyTdGBcAgi2TkUqWuNWh3ckEOlgToJ70cA0ceS?=
 =?us-ascii?Q?5BKc4U9F8IliO2twdr0PQZtr7tssf8tQtUEFHb2TM0KJU554p2/rhZqQE0nD?=
 =?us-ascii?Q?WkMTpvRnJ92OmOV8iOoJ5inbEKsFH+LeofO5z7p3rp3YbDYtoL3RiAf/uqPf?=
 =?us-ascii?Q?dMA0XgepndKRum4Si36GoCAcR6vEiHjNFro5zk/A+bitW7cN4Gn9Kjz4fiLm?=
 =?us-ascii?Q?JwXdxOlbQAkhYD9goFjA5fzqITQmQ9FlZ6rCAxVcJsRaekDoD/+o7RISil7I?=
 =?us-ascii?Q?inFuW6jp5w9UaZs47zKk8hMFs95KzDXfF88ZE9WSkQHKbInkx0L4ijx1pbJL?=
 =?us-ascii?Q?LN/TNzlpCyKYPCt59mZybrgefqCSmtYQGfEabupi0qMdg8014AnCO3VTVx6a?=
 =?us-ascii?Q?VPEO8KyTKkt0wGDL7HG4M+uIKZfUxR1DPdjLaduSojByXM07+AWGrm3EaRJA?=
 =?us-ascii?Q?L9nb4e1ed/OWE0Nx6sJNKvcHC4Y0ryDwUjQaJKPiQBM1BQr8D2plRmJDeW+4?=
 =?us-ascii?Q?rMjvRPhKCUdXhI2eOsrxCI9J0/sr4Y084SSdmBEwB4+daUv7haFipfs5C+8Z?=
 =?us-ascii?Q?ImVJ8xuTY1+BkXDjMDOJgpI4IJMNWO0bkuJc0qbBxWU1tYQo8pvLxFc1X7Gn?=
 =?us-ascii?Q?Z8cuWps4dyVvoWDRBRCjvz8s5sx2weK9X2llnLz948HkuOAKA5q64PLMr+A7?=
 =?us-ascii?Q?uqD0axUZlZ7mj89WETj/jenQbcThVlZwOdLUZ0/OErSer2DXBRMA5HXKJTm/?=
 =?us-ascii?Q?mcHBebU2b6ZpxBoAvmf+FlOsK+yuKRGMxo/NASMjVrCvTJV5Lbr191zK1DX3?=
 =?us-ascii?Q?UIR0NnjnGMlM7gafqdnJVmisXJ2YSBA11db/fVWedfoe5gq9ICpl1bnsfCjj?=
 =?us-ascii?Q?JqIS6cs3BShN5GrbnoocRpiGkq5A9j0rSpT1BteRY0KMySEdjtIgbNvp2GjI?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ccdf93-bb4f-4c36-51ad-08dd1b21ec9f
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:57:47.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czw9sTfufe0k9VeFZ/m2xWXOt6CTDT1hJi39lUhLcUi3PtVDpsYtR69FMZZG8kCIGtT1mHAOKNN7JxwwvT3TO+demGxbLl0iuCXklL30m50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6869

>On Thu, Dec 12, 2024 at 06:55:55PM +0800, Jinjian Song wrote:
>> When driver processes the internal state change command, it use
>> asynchronous thread to process the command operation. If the main
>> thread detects that the task has timed out, the asynchronous thread
>> will panic when executing te completion notification because the
>> main thread completion object is released.
>
>s/it use/it uses an/
>s/te/the/
>s/is released/has been released/
>
Hi Bjorn,

Got it, please let me to correct these errors.

Thanks.

Jinjian,
Best Regards.

