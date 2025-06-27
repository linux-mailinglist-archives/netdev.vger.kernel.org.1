Return-Path: <netdev+bounces-201942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35510AEB870
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E617CF7D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3702D12F5;
	Fri, 27 Jun 2025 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gf4DyZIh"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4A21770A;
	Fri, 27 Jun 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029591; cv=fail; b=IX2FmRoRUXja648C8ub+K+msD762aHDutZZ6R4wuuBUiyieGinuN2EIludrenao+Yz2NuZfF2RwjDoeEOYiIDr1K9ZiNK5Ju6SiFHIo0uY49nnUR1+d5JR0Oy4wZk8OpXtzCweqi35jRZVh2gcvocZqyqGE8CfJuA3u60m5MEeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029591; c=relaxed/simple;
	bh=Fg/olFv5+BJRZCzRxhJkqXnMXmMujLK6OkxeEUzPSz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GMd3LrsP3VRP+9dy4Mtjk3BWQDM34DaAlWZnQHWC5o84U922+kgHObiLme78rZvNHKWCxgtKiby7MMN6ypP2IYbhj73Nbd6W1bRZvXx688bQIAbp4qb3W89RndoEH+zj6VA6bZ+mCJI33n8qtInzj+IUJIl3HnzcOd8LfzOgu1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gf4DyZIh; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBdfJhXbb3rgn5G6UD+XUd/SjUzRUa26yCzGxRcYoku6PDPbAUIRqSUOTFpq2irafpocrnIYQqCsivNFTF4sfZAZ1ncgcOekgqEjVVbVuPDHZHkAD5NRcZmoYwLfD8u2scaSIPe4Rz1p1as/U8Cx1BRk7oTLVcw2aIbSSOtBHAEAhXRAd/ZeNn/+rfQddj0ZHcUJcPXobBMW42OubzOwa2tqp/Vv9s6jS9/EiHqa5aziZS/SEe83X5s3S/raFdE3PsG4LqoSwZFs0CFvwZSnShrHFy1SmSlSuHIFA4583k026xNkgZNdv1mk5b8RpToc/sEA55U3mIienCT3dTrung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XCi4iK87+e1g4123M7uzT01acQfry5CDDQSObwtjFY=;
 b=mq1qCSOiI9vzGcgrMmRqXncjHgaRcMvM9BThDoW4EQym0S9WqKG0JEmsShd5PECWyRI7vE2suc/VKo6+ewl69dHsXDNGHW22Trpx6Nl7KJi7xDrrRx39mAUDc1LOA7ajZdJJYhqRTgIwpAKZq0xtKQd/lyalSikEdglJnXeQQXgIaVTzNLYBUPwlznAmjbDZpzENmdHrX83I8s3Dxl91oQ62gNs8FOnJN+9jZaSM83pcQV5bNQtQIk9uvOUfYJeqgb0RSP8K+UcKV3c58kU/go2t+nF3g7VVHI+9BmyERsXG82T4Tq7wPhuY+1orHywBJnrCArebrjggvKhDjq8Raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XCi4iK87+e1g4123M7uzT01acQfry5CDDQSObwtjFY=;
 b=Gf4DyZIhGz/cUm254ykDJn9b6+m3Vwy1aInUXJfEYaApQYLHpUZom2ORNrRqZ+ZV78Q6diz6MQtMPUZu3lul7LM8BKNnWrc4EzEQQdGAEZMRm+ATj4WqlIse2ysBaaheXDlqi0X+E8MvydYOveVoDyC0SwuaZ95ClsYCYH7qHi+nksfOyDjYp2AhDpDkFRflurPmm6gPwJHgjF17fq6tpNdXZwVFoDSoAJSHyKLdW6zEYhFtDQz44pQst5ZOKmLUKBaxDWiC+yXa7vR3e9ctOU9/0LEt95YgJ2iwSeHLpEXY4oGzXzG5EvcFVXH4VYhtLVvEyOrKKOcOBHHmk86jNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Fri, 27 Jun
 2025 13:06:25 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8835.018; Fri, 27 Jun 2025
 13:06:25 +0000
Date: Fri, 27 Jun 2025 16:06:21 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] dpaa2-eth: fix xdp_rxq_info leak
Message-ID: <7qqvs4nsvm2mtjigbdto5onasf5eyiwwg4eq2wzl4s54wrp7xt@25dmnpgyo3h2>
References: <20250626133003.80136-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626133003.80136-1-wangfushuai@baidu.com>
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: a17e06a2-9251-488e-1418-08ddb57b6bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdgQrj5FtnGi3n+GbTkwikPyRSV6n+7857yViyJWt5qqFksys9PiKS7cuZ2s?=
 =?us-ascii?Q?Vq26BOwKT7QhdVIgwpY/j5Y5szkE8v/wMqcYJ99yAaF56fhEtivWUgtler9X?=
 =?us-ascii?Q?oAIEXhwtqxj5WmwY/b5w7BquVmraBZSiR3TJsO8vY55BJ+KLjSDYjLxb4eJP?=
 =?us-ascii?Q?SGJ3LVYBGm1ky0nLJ+VQHTEt/EBTPghi1u/omrqHhbsVtvzB96b3A+Mu5hvu?=
 =?us-ascii?Q?fBPfCiJWDEYjxeXdC7e+hEuo+ZV+3zyiJ1qOWCiizQwlnPiW/H9lOBv+GoT1?=
 =?us-ascii?Q?Yth7Rq/UeupO5y6Ngg4bIFHMiqkrKUJOqKpQiwzKKCuFlUq+rKhn9cu94BBF?=
 =?us-ascii?Q?qSYx5+6Q3+6rsccGMBAmCniicUS9k5oArvs764HOP9yLEVignQMX3u+J/0g+?=
 =?us-ascii?Q?6dBdyja22dsC+DqSEsV8CouNZKl6bOCHg/XJXVFK70yMgN6yJvMI+T+6JfrK?=
 =?us-ascii?Q?0RNpyINy4twBAxJPSZZZVHIgpYQwzl5zsUh7TdOT4HMQfcHJ/2PWqv7ZmG/f?=
 =?us-ascii?Q?I9cTMkym3Vc0aA5SWgNB8asGQQvAupqhNZVF2+tTfj7B37WjGHxRsL+K9XZm?=
 =?us-ascii?Q?ZJSoZc1oaPmYgsW+NZ9NYn1VCWrM9puX3YPdh0zHkuUrwCNK7O8pcProLNad?=
 =?us-ascii?Q?xq7gGdUjDibd93DlAge68gUgTGbHfMRtkL+rzFl7cyTcx686ZzzSdA/YQ8Ts?=
 =?us-ascii?Q?edzbA4F9cIUTAIo6P2bg5YgnldXbmk/NOUhpCDbRyWpm09J4hGP48cqRzHOM?=
 =?us-ascii?Q?GrKE9r07XbtQTVAmgOGpTmOzrm68Kr0G01LGEm/7Op68GiQ3v2O7TLbh0geu?=
 =?us-ascii?Q?kwW5jAXRtFoJtGiYuATQMZcq/7qryl7dGWjFIF4ok8eEg34aXbThLYhwJDd+?=
 =?us-ascii?Q?1GAL3X4RvMNnaa76oJN5Y3eQ+oUSVoMumCOtSRDn8x8QdUHUbyrtLopUk3E0?=
 =?us-ascii?Q?bjYZGj8udjRM2nLKew83x3OyNyh8Pu7sGx9dmb4lCjjz1wv/E+amDoVQhgWE?=
 =?us-ascii?Q?gfQsSLFKduuIyLIVXpwcrb60fD1epVxOlRCEbW6/q3Sagbh5kEuvsWc/BsjM?=
 =?us-ascii?Q?yBhDw57NdnJT6ALN2myhLGjAsNyzI8exwNOCmZNPtFQKZ9DXIaas4zIAMNOl?=
 =?us-ascii?Q?kjeLQgCRgsa16lWRO5rEwAS4SHzuDAuYlCKQSHCO7iHSqqtM8P/mE/lbA6zO?=
 =?us-ascii?Q?AwfnNtZocbIgN8G1R+Q7dURnMa80ohEyukVkDIq4UVwC3yZXcJvJV7GphMSv?=
 =?us-ascii?Q?QOiXvl0XQR2VL99K3GudncKtGFIXDXGFRlqo1O+MIP0DGbT5pgJTjq89FNyy?=
 =?us-ascii?Q?KGnnBy03+Q3BNY6JcbjcqEf6juejp/dhbRrQeJONnG3ZTsqwR7c6op0XNpby?=
 =?us-ascii?Q?Bicrvl6VBapL4RTYkaHxsHSIAdjlxajGjtBH4EgoYD1zKk2U4u2SbMrDdaHW?=
 =?us-ascii?Q?FJBnI8lePDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzSUQP18pvIOK4M/pL/ue8OaAigVhi4i6oNvbABxBt5c7ZcEnsDUB2rWm6gL?=
 =?us-ascii?Q?JH9zhKPFDgZCgJTrhAjrk+ibNY8IwWbXX50tD+2obVgCEDGMHIoHU5hci4Zq?=
 =?us-ascii?Q?SH6d9gTJMaZwT40vesL8dF1x3bqkUoQkcqaWtg1NeMEBBbfI2mG3p18X3MZQ?=
 =?us-ascii?Q?bFSfYdMWz9YK6htCksCDjU+hilr3P5AT/WXmgKLKFOn3yjfdY43tGzLE23Ke?=
 =?us-ascii?Q?owOhqvkL0wHsH3BIut+JYJ0bo9rkIGbeN5pq86+YHD8M/Sjmw1CFzHHXxV9o?=
 =?us-ascii?Q?ajriWxvhaBdi9tk+XVDdFKAz2ov7QMXuKp/MG3d+JoT95uajYQqWhhTofl8p?=
 =?us-ascii?Q?85yI3VD/rfTWYtBI2PVSiQBB7EnCbTK8wSYlESlFUwYlDmJnKId3OcqhnTVQ?=
 =?us-ascii?Q?Pob3ShAz61DxP+vmoLhHMjhB+cc/HgmRsOtSpAvpqSKEwsDmkpD2RJPhofaW?=
 =?us-ascii?Q?d1m9kOUT7cBwfoh9b0bMgj6syTtWPrwJaRUzCZArfo8TeTfZUchqispxn8Ih?=
 =?us-ascii?Q?NzRo1S8SbGDq78M/7dHy2YRhu0zcPSnC2/q2ll/nkETSvvb23u6nd/fDS/rB?=
 =?us-ascii?Q?v37axhpF3ypWiOPzw9hJ1Z7VE6OtWsgUWLEX5kcZLacA4kJiPHjSPrtpCqKw?=
 =?us-ascii?Q?ZKsvrNUDW7nH1m5+85Xze1lotkvaZXqfv7NqHlFeh3RBTbW9Vs5dPag8QDoS?=
 =?us-ascii?Q?v20K0MPhj3cJV3nAb2FMOdT96VKMLcx/c9/YDTydryWIKgOR4douLtOqxOc+?=
 =?us-ascii?Q?TeIySNmKk8FM9mypP5HxAFCNOR2GMlBlA8PZHfrjxIG0duXXcdDvf65LAw0F?=
 =?us-ascii?Q?rNTsW+ij+9tlZ/8L2kSHXKVTOfKLupf1qFAInH+1VqRb9+c2JXcW+z6Td3ZL?=
 =?us-ascii?Q?5guRmWNSRpjafOj49dShbk/ntDZQb9PBkgu8zqrFsZy8yxOZHLGT9kNTonC4?=
 =?us-ascii?Q?sBvdas1dDXWGrYfdE1JA78txhT5pusCK9/B1OC/qqOZX1r+RAqeE/lWw5CVp?=
 =?us-ascii?Q?TzYjirVAX7TCBqgY7W9tiLEdTe+ycltrJRyeEd5MMVh7PgtLJxQ+dEfnAei1?=
 =?us-ascii?Q?qUL7BIaO+8ivdivJ6Dr6o/1WkGsdX5d5g58NJrNcHr+o74b74tWPwUyY7sI6?=
 =?us-ascii?Q?twjD4NTocQntDxAAPzIMK3CnGTQyoJD2w6+iKzxdtXMtY0k5IlclSlw2EhVQ?=
 =?us-ascii?Q?RQ6yjBYRaEsBsW5TxVJun8uA92HlU1UdRu2wh0E6C3dp87Q1EZ3vKDlqqMCX?=
 =?us-ascii?Q?m1CB7EWq2GRPBng8puYbrhkAR+F9k9xcqX3y4CAH7ImL9A0+ooib6133McIV?=
 =?us-ascii?Q?MnbnvUS04I1KhcPuLDSn/5JSXq59JuFuEn6yZmOLTYJSEXMOdeRM/9g4ky3g?=
 =?us-ascii?Q?W+lieECHNVTGFO33YilYDrI4IRK1jhBgk5CJBEUrb7J0lUo3XulAZNsMRtTm?=
 =?us-ascii?Q?ElL5W5A5gRymjPZznq9IJbKmwLDizFpVULtB1m9Do56QxufCiUlNWP1hGQsT?=
 =?us-ascii?Q?0pcnfHzhd9VFat5BWxOAWEI5C0H4VheG4b/5GsLicmtVhAmFa5NfSK/mBQV1?=
 =?us-ascii?Q?g8ATTRFhMHPuRuaj6JndlDWaiSoLcIi0kj+6E+zR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17e06a2-9251-488e-1418-08ddb57b6bd4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 13:06:25.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytbkXTkI0wKrasLA8gjV9sg72Fk5XAZuqAgOw0qAZrDyO67oJXltXLErpo0BewKyqxYGAKOBukM4OfUJuRhVaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861

On Thu, Jun 26, 2025 at 09:30:03PM +0800, Fushuai Wang wrote:
> 
> The driver registered xdp_rxq_info structures via xdp_rxq_info_reg()
> but failed to properly unregister them in error paths and during
> removal.
> 
> Fixes: d678be1dc1ec ("dpaa2-eth: add XDP_REDIRECT support")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks!

