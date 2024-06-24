Return-Path: <netdev+bounces-106158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D516C914FFD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B0B1F230D6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774B19AD5F;
	Mon, 24 Jun 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="Pw2olDuL";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="S2iMAbTu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780D19AA7F;
	Mon, 24 Jun 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239558; cv=fail; b=Kj1gSGUTP3JgYraRV5UzgSaARfM5Ext+kHsiwgmx506GeIAqr0vCnN4BqS7xDnFcCLQJnxvMGOhYY0pKUkXnVEQ2tOiMJI2o0/A5zfuqUvakB3LIVVe72jqpw/3e3XsAjVbRoqy+cO5sfqmqbQrBypuHdmoTiXprWs74htGiIPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239558; c=relaxed/simple;
	bh=UsHNUw7NnubdlyS+khngAJbLx9mDlzjwZUXC61i6N0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+0kxg8j+iHbbQJz8hWznAhpbWopdhYnbT04hMC8HIvNd6sh5pCk9UWf1Ntd2T1yEdbSXMvnBexJatPf/RYnzyaOoZBib4D9wpQVFWj3AyHWmc2hsjoFm10VmjxYlxtfHRKlQDPtaMkh93dz+cZ3t49nsk4mt4LT1/RvMqEM4JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=Pw2olDuL; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=S2iMAbTu; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODYZZo011774;
	Mon, 24 Jun 2024 09:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=UsHNUw7NnubdlyS+khngAJbLx9mDlzjwZUXC61i6N0s=; b=Pw2olDuL9QR7
	VXVazgOsidR5uO63veGalZQoeyLRZ5AcXV5mk0CD1nanaJeNkELcd6/UKgR7BseG
	Y4YjwaXnVg0BiIhOsDXlXWxkWZSjYKSZhjvlm1vsZK88LbWlkAG7GLczmaInsmF/
	31P3DRr4f6iBJTnshh7sV6RoC+6/a2We0mOtWtvpM+S74B6a+sfzzzhJNxDpAzjl
	LuWgknocXZ17pm2a0wSDQg6ElLdjpfeUmgc684rBIdbSyROBJrj3oHFY09jpG05V
	x6IJcFgNa7cA3syXs+mcldKcULS5xtZRA6OSVjU6m6GdaOCfY2h1fk93Gd9+R2MZ
	j55MVZpXeg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 3ywtx92e3d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:16:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkSvnmhQIqETa2vjAxxPVfCiRwY5KIKuwVWgikakUBdo/h6Xre4jNozaFXtZpLWNTnrgHxAQo3paakH+qksTDuZAJFiSnHcdO4fMq1hwuK2pME8jXWvNwLN8KEo7XzkCndiyI34JUvQ4So9cTJD89Oocj+rx+EaJzJwD9dWELpgify91OEgkq+bw4lfaaW0MGFjMPAA7NY6JSqATk2AMNb+uHGXbwk1U6IesLx5jZPTH6Psfvcx5JFHnRupxUMh1NQF5u3swqK3c41ydwuDjcOjWbXmM9o6t7D4NTS0iPXYq43az+Hxy/HimsGpIyF7i6pjMjAGwyPLSxUI3GVqycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsHNUw7NnubdlyS+khngAJbLx9mDlzjwZUXC61i6N0s=;
 b=WeHYiqeefQkemGNhWRMTJXv/FckMMA2UwIyoCmoj+udyCbFQl0yxtJfvM+Am0T21/WjZa5DT/zpgGLqxY3F6OTDM4Zj7etejXb1+HF67qwcs+gjzgVW4sRaYOAPJ6jz4zz5eIV8ZoDf80svoEyutvwjQQvoK9ld6O1aQzh50Fzc/68fThMln3g93k4f6HD+83QV+839S7YD325EKjkTl2ur3rGVYC06E4wqgFZGfFmZsbaOLKhqQo6RqdzFBggZP7KG6hDsdGpRXrx8fqWESOt3SK3chyrAv9Vote73r+jV7xC66oGivlWn4MDGtNkDQS4FdJgYF2aKlONrGHe3bng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsHNUw7NnubdlyS+khngAJbLx9mDlzjwZUXC61i6N0s=;
 b=S2iMAbTuifCFSeuleEZYUAAN+C2H+B7Vf6Ap1uzES9TteW78QyzYOQah4oY7zp2NVw9jrgo+hHanN+QfK4ewhLnVhHt0PNIIopbIWBwpjTuR3unc1dSLZfwQOU2KcZQiEhRIaZ20cNixRltADV3BXmZNJYs1FJHUyDZjJykgfMg=
Received: from MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:16:53 +0000
Received: from MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7]) by MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:16:53 +0000
From: Mathis Marion <Mathis.Marion@silabs.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
        Kylian Balan <kylian.balan@silabs.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Mathis Marion <mathis.marion@silabs.com>
Subject: [PATCH v1 1/2] ipv6: introduce ipv6_rthdr_rcv_last()
Date: Mon, 24 Jun 2024 16:15:32 +0200
Message-ID: <20240624141602.206398-2-Mathis.Marion@silabs.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624141602.206398-1-Mathis.Marion@silabs.com>
References: <20240624141602.206398-1-Mathis.Marion@silabs.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To MN2PR11MB4711.namprd11.prod.outlook.com
 (2603:10b6:208:24e::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4711:EE_|LV3PR11MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 710ed98b-e27a-41b5-fac1-08dc94584c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4j+wvJtH8Ote7fKsdYMU+xss3LYNgbL3We97QP732lKID5wwxWaxJM2g/LFO?=
 =?us-ascii?Q?bZMAzW6yyjIEW6xPLfQE5yUynJGzvN7ldsBmKvprphYdyglLhWL+vfuQT2d7?=
 =?us-ascii?Q?yKnb+09ESqZRgmw0MsPLvTENyiBA3QIwsBLPx8qqmXSmX64iZK/LgHJRS4zQ?=
 =?us-ascii?Q?K8J0OzLwvvfqggpESnOQsohay28tJsMw1M1jy+t+rZuO/bvtrCE+8oyaAG5G?=
 =?us-ascii?Q?ir+U3cR6NNLO0UTLp2CflgptBaVHgMJxbuYtfJGfdjds6S3Cj376pwFi66Qz?=
 =?us-ascii?Q?ocRZBHBH9oDOTfQES4BUC7rZ9GIUG7YuX0P3zxJsOEY12EKVh/i88Ba3nW0X?=
 =?us-ascii?Q?kL7MMLyYlwqJWe94AmcfnI5t14N3a6WTZM4pEjEF2AhjGQMO85WWkvJSAsMF?=
 =?us-ascii?Q?nOrRk8EW3xz2bH4RqrgGU54Dwm6lzDWnvPHOhOJGLBEXYn9i4bnqCIzEfV14?=
 =?us-ascii?Q?a+osh+wSWbxhN5kex3kciIoimpLfm4npXXogJF6ssRJIgV1nyGfQXPS/mC8W?=
 =?us-ascii?Q?AAKB+YwELhKIEWXwLJAFdJlbubo7X5r9cFQo+Ds/p8Qh3oD0LzTNK9vLLoC+?=
 =?us-ascii?Q?TlfUZeWooKvIVBZcpuayYPWssVvn/GJxkrN1ldhoraymAIXQXm1c0RktAVcH?=
 =?us-ascii?Q?bsj5CyYT1Cqd5UweEXQxk1csjtUEQtoHETxK0RpY+4qH6eN49am/RExGw/1b?=
 =?us-ascii?Q?gQYhWCYTVjdbxEvmZ27O0dWgruH/ADPnFpuGeNVoCYukeWOumfWSZnNMqak1?=
 =?us-ascii?Q?+XhmL7BFjb3OrKgLA2ZfcbC5jOgj8SAi7gcyQBaCEv/YryGg25zZLq+RzjLz?=
 =?us-ascii?Q?RP+O7sXIWlS1nPOklzVM+ae5q8NWI/YjpkumFgjMkmmH3ZdkjJ10GVZQMase?=
 =?us-ascii?Q?wHZ3J5Su2L3EcpMKphiSoIWVmUfuBE8AbS9vFakmvQ64ZjignfUmXn2JdpUl?=
 =?us-ascii?Q?wXL1ffW8QCNgKipLo5wuyyiDFQacfyQBzZ9GtN7Ja4vaZRs9HD/heMbZkZ/U?=
 =?us-ascii?Q?0I1Ow9S+G1h5J09hz3/znBGFE74scjzlA+GmoBgP8X2IxuJC80AHCoVFE5c/?=
 =?us-ascii?Q?HsE67dN5GTf2FbOgjcklSgvo8q8V6NI3aQVLUy0kGqxIYTAtpJNBdi9u322q?=
 =?us-ascii?Q?+PHYVXRp5gPxgi/hSI3GH8/PhHJV5H3antC3R0UDHHvvgzphGB4Bgy9fhiB7?=
 =?us-ascii?Q?qtGJbmhsVdBUacx71OQyNSMvoTwZz2qXI+fLuDopj3HcNV0d/tw17/Zj9u3P?=
 =?us-ascii?Q?nnRlrPL1Yrda8qv2Srlf12Z6tk3QNx7Z+Bwxkj6+kJmc/ERh1PUCClBW27xS?=
 =?us-ascii?Q?sCYouYqwQFvybP3hFhTb0j3N9LFu15OdBOgSNqNaxHKq0LRU4te+Sn+iXXlm?=
 =?us-ascii?Q?EfLXd7A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4711.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Hn5I/HmvBMRHyqfOj3ZhD6EPwjTrae/6+l5j2HWlC/Le99DYWR4Tn+Vvyy4G?=
 =?us-ascii?Q?eGDHLoFqO9yPchfWqZWTP+F0+qxEFJgMA4Hns9mnIFOTKsBZF3xty2gCnf/S?=
 =?us-ascii?Q?CazkN9RraRUIsa9XOeJ2s2ASe6UYXU4qQzM/V1nxJxR1CP7WVO66UZhqrABI?=
 =?us-ascii?Q?dFtpEwJZpxH+eECkAzbCAkjp0lQJ7S+EL8rTULws05VhEa0qoe1WXXcqptTz?=
 =?us-ascii?Q?9uWGRigAa/sF9zacU1QDy+/6LEXe7lU/5BLGhwuiNm0B5B1XinEeaoJi5TK0?=
 =?us-ascii?Q?3htUqj5n4KoXMaJMrNQE2H+PpHwKle39rQjqZbXalOEZeOk3M9XfHUq4nvc1?=
 =?us-ascii?Q?2zqZegIONkKuYpCB2xmmZP5gmqhlaOboJhZwkoheEuhCVSG73vJprP4rA+ax?=
 =?us-ascii?Q?j8FlzELA0Bj1y3jaV/yiVKjSLE45qK2MYZTFhbGUilLJRoKM3htBbLY5/6O4?=
 =?us-ascii?Q?EmzKS2dzzmWhEegfuVaiKwul2iBX+4w9TaZv0wsFB1MtRWJzIr0/0a6tSUfP?=
 =?us-ascii?Q?jsycI5VlLRDO4cb0n8WKxvQtcyxmuWwdpat9U6LBu2MUna1719gw8Log+txZ?=
 =?us-ascii?Q?ie8wvCGswVuMIlk/7GMIut2a5V3klufN323J4pJ12URGHwUtiavpEtGZoMDo?=
 =?us-ascii?Q?V7bC6kgGs/ZTyoFtEDyLgH8gLRqBg7KIJrIfYK9UBHBthabN2QJtH5XLKrpY?=
 =?us-ascii?Q?3MdeAI0T2oEV9bpiLsKS+hALfIKImQ2yUTVD/X/QZyouUeNVXI920eeA1zjy?=
 =?us-ascii?Q?1BvZ+7i0H9ach+LHurLzVvSa+cueRx6YLkFIJXz0CNboEV09yd7M4acPKxP3?=
 =?us-ascii?Q?Ryei/VBETttLyHFsusy+7N1dr+Pl94NxCk7ZXVcpQUjG5Bt4tmW2q7U1Is8+?=
 =?us-ascii?Q?EI7vihQRrWlni3kb6EoRRoJg/yLdkskTPqocBzFLuGy1ZDxbVHkqXS/INjRr?=
 =?us-ascii?Q?cnXY65+vwFz1bc3HDxlFEKIa+bC4wZ34TH9MXL8eiRIcvgDvmppFTPXWvYCd?=
 =?us-ascii?Q?hroVIlj6gB4cSMyJmcQ2uYpN8k+feciscNxMGWdlVG3uL/ZojSMdOQkqQNum?=
 =?us-ascii?Q?LYzgNcuSFQvhXNeEDVWM74Pu69d40pZQEDLt6wQHu0S+sNJVzM+ZD6VOfAjE?=
 =?us-ascii?Q?2A8lTrwEzMtJvsPrKtYGyupEr9c5azA9YcOVVWaBzjKWhV+Mny6HtjUaquOZ?=
 =?us-ascii?Q?59LeMus61lFRQAY+JGkGyUD+jIfwYWZ3UOK/7xT1NwmXxWq4JmJnjlpupZG+?=
 =?us-ascii?Q?w7hf1OWU5+hHc3Uaencz89DKxrF5iCa+yfmtx5goPD3u59t2rnZnzbi2+Xu5?=
 =?us-ascii?Q?NovXqwqzH80duj5YlMplrJV6c/AVJRnqFmDpp7CKJSovKpjTzIoMww44n0Q3?=
 =?us-ascii?Q?sZMYZp8norC8VD097Vf1v59skbO8WKccjHTlPd+2aR9BaDAnP2mAGLroVdZ8?=
 =?us-ascii?Q?E27JdY6qoLCuzrf6RSLkiDTk3YZXrr5BUJU3880uQpIC2nZo9HknS9t+mnQA?=
 =?us-ascii?Q?PKxradaZsy5J16iom/6KqpZHT4Db/Yj3XpB3gnyRcOQfYKkVjTa5fl0RIV75?=
 =?us-ascii?Q?+cZLazlo01gndMfov9SWCuZpwmJFe1x4mUXJZDgh?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710ed98b-e27a-41b5-fac1-08dc94584c48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4711.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:16:53.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/WDuVk/IRwa/SrRV38Zqpz3xETFeRe4tQWi26nqEsGiRn03IV7Fb9kQWjF27XA8rUavPcKgIcoO2rLZJp4rzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-Proofpoint-GUID: UuVjjltVgkmlu-zlHvqjJoeYWaX6OYJG
X-Proofpoint-ORIG-GUID: UuVjjltVgkmlu-zlHvqjJoeYWaX6OYJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=980 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240114

RnJvbTogTWF0aGlzIE1hcmlvbiA8bWF0aGlzLm1hcmlvbkBzaWxhYnMuY29tPgoKVGhpcyBmYWN0
b3JpemVzIHNvbWUgY29kZSBiZXR3ZWVuIGlwdjZfc3JoX3JjdigpLCBpcHY2X3JwbF9zcmhfcmN2
KCkKYW5kIGlwdjZfcnRoZHJfcmN2KCkuCgpOb3RlIHRoYXQ6CiAgLSBJUHY0LWluLUlQdjYgd2Fz
IHByZXZpb3VzbHkgb25seSBzdXBwb3J0ZWQgYnkgaXB2Nl9zcmhfcmN2KCkuCiAgLSBJUHY2LWlu
LUlQdjYgd2FzIHByZXZpb3VzbHkgbm90IHN1cHBvcnRlZCBpbiBpcHY2X3J0aGRyX3JjdigpLgoK
U2lnbmVkLW9mZi1ieTogTWF0aGlzIE1hcmlvbiA8bWF0aGlzLm1hcmlvbkBzaWxhYnMuY29tPgot
LS0KIG5ldC9pcHY2L2V4dGhkcnMuYyB8IDEwNyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCA2NSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvaXB2Ni9leHRoZHJzLmMgYi9uZXQvaXB2Ni9l
eHRoZHJzLmMKaW5kZXggNjc4OTYyM2IyYjBkLi4wODNkYmJhZmIxNjYgMTAwNjQ0Ci0tLSBhL25l
dC9pcHY2L2V4dGhkcnMuYworKysgYi9uZXQvaXB2Ni9leHRoZHJzLmMKQEAgLTM2Niw5ICszNjYs
NDUgQEAgc3RhdGljIHZvaWQgc2VnNl91cGRhdGVfY3N1bShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQog
CQkJICAgKF9fYmUzMiAqKWFkZHIpOwogfQogCi1zdGF0aWMgaW50IGlwdjZfc3JoX3JjdihzdHJ1
Y3Qgc2tfYnVmZiAqc2tiKQorc3RhdGljIGludCBpcHY2X3J0aGRyX3Jjdl9sYXN0KHN0cnVjdCBz
a19idWZmICpza2IpCiB7CiAJc3RydWN0IGluZXQ2X3NrYl9wYXJtICpvcHQgPSBJUDZDQihza2Ip
OworCXN0cnVjdCBuZXQgKm5ldCA9IGRldl9uZXQoc2tiLT5kZXYpOworCWNvbnN0IHN0cnVjdCBp
cHY2X3J0X2hkciAqaGRyOworCisJaGRyID0gKHN0cnVjdCBpcHY2X3J0X2hkciAqKXNrYl90cmFu
c3BvcnRfaGVhZGVyKHNrYik7CisKKwlpZiAoaGRyLT5uZXh0aGRyID09IE5FWFRIRFJfSVBWNiB8
fCBoZHItPm5leHRoZHIgPT0gTkVYVEhEUl9JUFY0KSB7CisJCWludCBvZmZzZXQgPSAoaGRyLT5o
ZHJsZW4gKyAxKSA8PCAzOworCisJCXNrYl9wb3N0cHVsbF9yY3N1bShza2IsIHNrYl9uZXR3b3Jr
X2hlYWRlcihza2IpLAorCQkJCSAgIHNrYl9uZXR3b3JrX2hlYWRlcl9sZW4oc2tiKSk7CisJCXNr
Yl9wdWxsKHNrYiwgb2Zmc2V0KTsKKwkJc2tiX3Bvc3RwdWxsX3Jjc3VtKHNrYiwgc2tiX3RyYW5z
cG9ydF9oZWFkZXIoc2tiKSwgb2Zmc2V0KTsKKworCQlza2JfcmVzZXRfbmV0d29ya19oZWFkZXIo
c2tiKTsKKwkJc2tiX3Jlc2V0X3RyYW5zcG9ydF9oZWFkZXIoc2tiKTsKKwkJc2tiLT5lbmNhcHN1
bGF0aW9uID0gMDsKKwkJaWYgKGhkci0+bmV4dGhkciA9PSBORVhUSERSX0lQVjQpCisJCQlza2It
PnByb3RvY29sID0gaHRvbnMoRVRIX1BfSVApOworCQlfX3NrYl90dW5uZWxfcngoc2tiLCBza2It
PmRldiwgbmV0KTsKKworCQluZXRpZl9yeChza2IpOworCQlyZXR1cm4gLTE7CisJfQorCisJb3B0
LT5zcmNydCA9IHNrYl9uZXR3b3JrX2hlYWRlcl9sZW4oc2tiKTsKKwlvcHQtPmxhc3RvcHQgPSBv
cHQtPnNyY3J0OworCXNrYi0+dHJhbnNwb3J0X2hlYWRlciArPSAoaGRyLT5oZHJsZW4gKyAxKSA8
PCAzOworCW9wdC0+ZHN0MCA9IG9wdC0+ZHN0MTsKKwlvcHQtPmRzdDEgPSAwOworCW9wdC0+bmhv
ZmYgPSAoJmhkci0+bmV4dGhkcikgLSBza2JfbmV0d29ya19oZWFkZXIoc2tiKTsKKworCXJldHVy
biAxOworfQorCitzdGF0aWMgaW50IGlwdjZfc3JoX3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQor
ewogCXN0cnVjdCBuZXQgKm5ldCA9IGRldl9uZXQoc2tiLT5kZXYpOwogCXN0cnVjdCBpcHY2X3Ny
X2hkciAqaGRyOwogCXN0cnVjdCBpbmV0Nl9kZXYgKmlkZXY7CkBAIC0zOTUsMzQgKzQzMSw4IEBA
IHN0YXRpYyBpbnQgaXB2Nl9zcmhfcmN2KHN0cnVjdCBza19idWZmICpza2IpCiAjZW5kaWYKIAog
bG9vcGVkX2JhY2s6Ci0JaWYgKGhkci0+c2VnbWVudHNfbGVmdCA9PSAwKSB7Ci0JCWlmIChoZHIt
Pm5leHRoZHIgPT0gTkVYVEhEUl9JUFY2IHx8IGhkci0+bmV4dGhkciA9PSBORVhUSERSX0lQVjQp
IHsKLQkJCWludCBvZmZzZXQgPSAoaGRyLT5oZHJsZW4gKyAxKSA8PCAzOwotCi0JCQlza2JfcG9z
dHB1bGxfcmNzdW0oc2tiLCBza2JfbmV0d29ya19oZWFkZXIoc2tiKSwKLQkJCQkJICAgc2tiX25l
dHdvcmtfaGVhZGVyX2xlbihza2IpKTsKLQkJCXNrYl9wdWxsKHNrYiwgb2Zmc2V0KTsKLQkJCXNr
Yl9wb3N0cHVsbF9yY3N1bShza2IsIHNrYl90cmFuc3BvcnRfaGVhZGVyKHNrYiksCi0JCQkJCSAg
IG9mZnNldCk7Ci0KLQkJCXNrYl9yZXNldF9uZXR3b3JrX2hlYWRlcihza2IpOwotCQkJc2tiX3Jl
c2V0X3RyYW5zcG9ydF9oZWFkZXIoc2tiKTsKLQkJCXNrYi0+ZW5jYXBzdWxhdGlvbiA9IDA7Ci0J
CQlpZiAoaGRyLT5uZXh0aGRyID09IE5FWFRIRFJfSVBWNCkKLQkJCQlza2ItPnByb3RvY29sID0g
aHRvbnMoRVRIX1BfSVApOwotCQkJX19za2JfdHVubmVsX3J4KHNrYiwgc2tiLT5kZXYsIG5ldCk7
Ci0KLQkJCW5ldGlmX3J4KHNrYik7Ci0JCQlyZXR1cm4gLTE7Ci0JCX0KLQotCQlvcHQtPnNyY3J0
ID0gc2tiX25ldHdvcmtfaGVhZGVyX2xlbihza2IpOwotCQlvcHQtPmxhc3RvcHQgPSBvcHQtPnNy
Y3J0OwotCQlza2ItPnRyYW5zcG9ydF9oZWFkZXIgKz0gKGhkci0+aGRybGVuICsgMSkgPDwgMzsK
LQkJb3B0LT5uaG9mZiA9ICgmaGRyLT5uZXh0aGRyKSAtIHNrYl9uZXR3b3JrX2hlYWRlcihza2Ip
OwotCi0JCXJldHVybiAxOwotCX0KKwlpZiAoaGRyLT5zZWdtZW50c19sZWZ0ID09IDApCisJCXJl
dHVybiBpcHY2X3J0aGRyX3Jjdl9sYXN0KHNrYik7CiAKIAlpZiAoaGRyLT5zZWdtZW50c19sZWZ0
ID49IChoZHItPmhkcmxlbiA+PiAxKSkgewogCQlfX0lQNl9JTkNfU1RBVFMobmV0LCBpZGV2LCBJ
UFNUQVRTX01JQl9JTkhEUkVSUk9SUyk7CkBAIC00ODIsNyArNDkyLDYgQEAgc3RhdGljIGludCBp
cHY2X3NyaF9yY3Yoc3RydWN0IHNrX2J1ZmYgKnNrYikKIHN0YXRpYyBpbnQgaXB2Nl9ycGxfc3Jo
X3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogewogCXN0cnVjdCBpcHY2X3JwbF9zcl9oZHIgKmhk
ciwgKm9oZHIsICpjaGRyOwotCXN0cnVjdCBpbmV0Nl9za2JfcGFybSAqb3B0ID0gSVA2Q0Ioc2ti
KTsKIAlzdHJ1Y3QgbmV0ICpuZXQgPSBkZXZfbmV0KHNrYi0+ZGV2KTsKIAlzdHJ1Y3QgaW5ldDZf
ZGV2ICppZGV2OwogCXN0cnVjdCBpcHY2aGRyICpvbGRoZHI7CkBAIC01MDYsMzMgKzUxNSw4IEBA
IHN0YXRpYyBpbnQgaXB2Nl9ycGxfc3JoX3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogbG9vcGVk
X2JhY2s6CiAJaGRyID0gKHN0cnVjdCBpcHY2X3JwbF9zcl9oZHIgKilza2JfdHJhbnNwb3J0X2hl
YWRlcihza2IpOwogCi0JaWYgKGhkci0+c2VnbWVudHNfbGVmdCA9PSAwKSB7Ci0JCWlmIChoZHIt
Pm5leHRoZHIgPT0gTkVYVEhEUl9JUFY2KSB7Ci0JCQlpbnQgb2Zmc2V0ID0gKGhkci0+aGRybGVu
ICsgMSkgPDwgMzsKLQotCQkJc2tiX3Bvc3RwdWxsX3Jjc3VtKHNrYiwgc2tiX25ldHdvcmtfaGVh
ZGVyKHNrYiksCi0JCQkJCSAgIHNrYl9uZXR3b3JrX2hlYWRlcl9sZW4oc2tiKSk7Ci0JCQlza2Jf
cHVsbChza2IsIG9mZnNldCk7Ci0JCQlza2JfcG9zdHB1bGxfcmNzdW0oc2tiLCBza2JfdHJhbnNw
b3J0X2hlYWRlcihza2IpLAotCQkJCQkgICBvZmZzZXQpOwotCi0JCQlza2JfcmVzZXRfbmV0d29y
a19oZWFkZXIoc2tiKTsKLQkJCXNrYl9yZXNldF90cmFuc3BvcnRfaGVhZGVyKHNrYik7Ci0JCQlz
a2ItPmVuY2Fwc3VsYXRpb24gPSAwOwotCi0JCQlfX3NrYl90dW5uZWxfcngoc2tiLCBza2ItPmRl
diwgbmV0KTsKLQotCQkJbmV0aWZfcngoc2tiKTsKLQkJCXJldHVybiAtMTsKLQkJfQotCi0JCW9w
dC0+c3JjcnQgPSBza2JfbmV0d29ya19oZWFkZXJfbGVuKHNrYik7Ci0JCW9wdC0+bGFzdG9wdCA9
IG9wdC0+c3JjcnQ7Ci0JCXNrYi0+dHJhbnNwb3J0X2hlYWRlciArPSAoaGRyLT5oZHJsZW4gKyAx
KSA8PCAzOwotCQlvcHQtPm5ob2ZmID0gKCZoZHItPm5leHRoZHIpIC0gc2tiX25ldHdvcmtfaGVh
ZGVyKHNrYik7Ci0KLQkJcmV0dXJuIDE7Ci0JfQorCWlmIChoZHItPnNlZ21lbnRzX2xlZnQgPT0g
MCkKKwkJcmV0dXJuIGlwdjZfcnRoZHJfcmN2X2xhc3Qoc2tiKTsKIAogCW4gPSAoaGRyLT5oZHJs
ZW4gPDwgMykgLSBoZHItPnBhZCAtICgxNiAtIGhkci0+Y21wcmUpOwogCXIgPSBkb19kaXYobiwg
KDE2IC0gaGRyLT5jbXByaSkpOwpAQCAtNjQ4LDcgKzYzMiw2IEBAIHN0YXRpYyBpbnQgaXB2Nl9y
cGxfc3JoX3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogc3RhdGljIGludCBpcHY2X3J0aGRyX3Jj
dihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogewogCXN0cnVjdCBpbmV0Nl9kZXYgKmlkZXYgPSBfX2lu
Nl9kZXZfZ2V0KHNrYi0+ZGV2KTsKLQlzdHJ1Y3QgaW5ldDZfc2tiX3Bhcm0gKm9wdCA9IElQNkNC
KHNrYik7CiAJc3RydWN0IGluNl9hZGRyICphZGRyID0gTlVMTDsKIAlpbnQgbiwgaTsKIAlzdHJ1
Y3QgaXB2Nl9ydF9oZHIgKmhkcjsKQEAgLTcwOSwxMyArNjkyLDcgQEAgc3RhdGljIGludCBpcHY2
X3J0aGRyX3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogCQlkZWZhdWx0OgogCQkJYnJlYWs7CiAJ
CX0KLQotCQlvcHQtPmxhc3RvcHQgPSBvcHQtPnNyY3J0ID0gc2tiX25ldHdvcmtfaGVhZGVyX2xl
bihza2IpOwotCQlza2ItPnRyYW5zcG9ydF9oZWFkZXIgKz0gKGhkci0+aGRybGVuICsgMSkgPDwg
MzsKLQkJb3B0LT5kc3QwID0gb3B0LT5kc3QxOwotCQlvcHQtPmRzdDEgPSAwOwotCQlvcHQtPm5o
b2ZmID0gKCZoZHItPm5leHRoZHIpIC0gc2tiX25ldHdvcmtfaGVhZGVyKHNrYik7Ci0JCXJldHVy
biAxOworCQlyZXR1cm4gaXB2Nl9ydGhkcl9yY3ZfbGFzdChza2IpOwogCX0KIAogCXN3aXRjaCAo
aGRyLT50eXBlKSB7Ci0tIAoyLjQzLjAKCg==

