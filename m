Return-Path: <netdev+bounces-258440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE+fOv6vjWmz5wAAu9opvQ
	(envelope-from <netdev+bounces-258440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 11:48:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E712CADF
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 11:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89315311DBFE
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8892F363F;
	Thu, 12 Feb 2026 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ny+wZ+B3"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2F2DE711;
	Thu, 12 Feb 2026 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893141; cv=fail; b=TBkGx4h332NgfGvRJF0nmSs94JNI9GvGYkh85dlz+K9D+3amgYxN7vKDW8wi3Hq8j1q+4oJmW6+s/GQXJvYtxz9CcnmT0D/05y+P42hMd7ndXabfyE8Tvm0Fq+rhwn1z599iBg3LwDML2ZBDv3JbKoLnh2TXFeG+fTCTS/tgDVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893141; c=relaxed/simple;
	bh=UzHGKZNdH0oh+nnljDDuSvtUyAjH0r+sSVBqhJNdv0k=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EeSDMF0GYgDxosB6/npXc01Lda2bocQbkOzzlGqQTEgi7lIh6Qhw9tDwAJi/NYnPggBuE3HKox4orLyyVgU0IA2EMgkyEv6Uq6wVe/IJwrCpSupXDDM/Y+zd1YFRRcMQkqkqYMYASQyjwc4hjZxNaW5yHh33WN1wQnkbwKzl/cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ny+wZ+B3; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkbGppCOucHcvtuNxnr53YsnlIVDR0p316F/pmDJmNYMVZndzjldKwsriy9eAzN8BMi6quGBE0qrBCR94jqUritKqzBKTnKEsjw9dHOPXQzD6tbZW8XLo8739Mk4UPQZnqxmRLbBCNDx80796LeD+bGiPrjGCHMJ/Z3OF21Hwh6XNdEAAZRWOghy1j1IWETDKUnUJNv9prPdUUW5PBU0y73lGpaneOWu2ACNUVv3fap/keYSaGwMb0ypCAqYcTJG7fLdkebOZNQ0pHXpBLbeBxezl9Z1FdmaRXjfPnAvi+Vy11mb/kfWxor2BRzN8Pk2JThsOtUx7/hO9J7kj+WKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXdk8Q3jw2WSvaG858+F8BIhyMO9CSIlLA4Q2HqHxC4=;
 b=ZYmrGU5CiKPlgmwQDNJ9Bpf0VuUJGwQEe7/XHXdOtdcDDeNhIgbHXRbvIHX9YkzkXyKrVe+hHhzZ2gKvhG35sgnZHE0OCABeDP+IletEuaKnut+einN2a93OPIUqAJN86r1jgEeH3OGUlbKHawjQOkDuk8+RIxV6mja7CzZM1c32f8DCjZaTnCGoCzcnEHXOxwlnXrLcZMVGSxSKhu4Z1sQ7OSjqX7pI/H0XYlKRji87GuI7LCHz6CKULZpAz5EwgYqKfuIFLN+d05To9w2zqaaQJC8w9bUQ28RaqkxGihde/7PQLKdyFV+3iexR3Q+G7DRVMuIWKA/jxwl4q0DX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXdk8Q3jw2WSvaG858+F8BIhyMO9CSIlLA4Q2HqHxC4=;
 b=ny+wZ+B3geDztes77ipPwF7KmiyaHs7EaSzOwf6N2wfTNawNqaM6ySCQCq0eMgZhhDvBpPW1Gz7xXkSG9Qef9Cia/nz5zg49KrPtykHB22oPrXJD9kTdkaZDNr+WLG5ASHyW680vsuCmFsctwzmh7Zv4QNrleDcqYzgRQMfGmQMHw87NtApjr3gFsGTuWOnDYHoUmFIYrLdoC2kLl/jvkRHKRhlcP+OhUwWGo6vqmtzOtmWnvdhkdDZmJmpbG5+apNqj1Z7ABq9s2WbYnKJ7jA9gJC5MoFox+hVd2ff9bSfeQHLGekrj6b8CxJEjKU7NkILZbCCb37YRGeja6bbZRA==
Received: from SN7P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::30)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 12 Feb
 2026 10:45:34 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::f5) by SN7P220CA0025.outlook.office365.com
 (2603:10b6:806:123::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:45:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:45:23 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:45:18 -0800
References: <20260211022146.190948-1-yuehaibing@huawei.com>
 <87qzqr5ktl.fsf@nvidia.com>
 <34e17499-e385-4017-801c-332c9c40d484@huawei.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <shuah@kernel.org>, <razor@blackwall.org>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] selftests: net: lib: Fix jq parsing error
Date: Thu, 12 Feb 2026 10:51:15 +0100
In-Reply-To: <34e17499-e385-4017-801c-332c9c40d484@huawei.com>
Message-ID: <87ms1e5jgm.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3170a7-4d92-4738-10d9-08de6a23d98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wk+pkxvq80334djpiRE991kIWcbd8U7hNWHtgcQ/JHpSOBAJrgsbDI2cFtUh?=
 =?us-ascii?Q?vHKEZ5adwJuDqPiNwB47maYVs5TI12nzKAVjHWOtwNNkrpv1+WD6fGn1Vvqj?=
 =?us-ascii?Q?ckjy+xAmlp5OLXCWLRR9xrHVMdJYI1/OCjSM/zr/Xt27L7HCb154QXq9tihQ?=
 =?us-ascii?Q?FSzYVo1QicOy6TmHv+NTsm1c9L33SqetZxu83HImRNLvV3SMCMeKRYmwmj3t?=
 =?us-ascii?Q?1v8rsX/oqtVvK3e4mylf5gp3y8KEHuCBxqVqwfpMdk2Gjss50UTjOhTdZDxI?=
 =?us-ascii?Q?a2pHEBwmfVqoEdVm+PAUn7gjqdihb1cDh9K0rJn523aD70zMary2OJOwLP41?=
 =?us-ascii?Q?iR/5K1x9p3x/nI3Cn3DjqsczZQn9xjvqO/aJzIojNcz/izNoSKGOUAOO6oMA?=
 =?us-ascii?Q?pzA3wKKwwdntWvCMAZr95tIFRuzUnA9NQaxTstMbNa8saXI1nVcc6e+hR8OZ?=
 =?us-ascii?Q?2Fj12CuPIErRSj++3DztOT5c2nutn2sDDyhqZOgcyuETgAUz4wLMxF7yPpVi?=
 =?us-ascii?Q?26GR/0Lz559qwJv90Hf3zZeR5+hxQEryTwUu8fvJJJ4cHA2LTzwV403mePHF?=
 =?us-ascii?Q?T5q/Kg6Hjtl/lco2y2AGktQGdYOwPjEZzUOitVQIJBW77I00z5GX4U06SbVO?=
 =?us-ascii?Q?Pisc7foV67H5CMbdN1VUBLzm8lWobqS8PY4MIubcZkw9XD9vyXJpqBw46+ZR?=
 =?us-ascii?Q?32bQOdJJYcOiEmz1wCKsKYuW4oWzgVDuCOfjPuwH0pGsp6F7emo9NT8y3TJa?=
 =?us-ascii?Q?atbA9gTG9YlBL0T23NRUkZAkuPFr3LyITspQr7Lce2mlX2/c/BqYUhJCt0j7?=
 =?us-ascii?Q?IChETNGlvhIYZfE++7F0dG3TEauFih1Yw0/LxkFNcSflDPvrqk72KxA3HA0Z?=
 =?us-ascii?Q?6iqZRj5I8cSZXDtZluiUQ3yZr3ywttf03RxYm/TkKO5OuwSCoZVPryUQmY6J?=
 =?us-ascii?Q?DofFHLmxbOR6xJuM1abic4yx28cRYZlf0mZ9vzxegPmj3InooFLSXllh/uYH?=
 =?us-ascii?Q?ostg8VzA8VX9We+Izb6G98s15+quhWR4kDg1t+qlqPs521097yDeRzpGXP4W?=
 =?us-ascii?Q?P9fafEyCLNWpu3aqrr2CI+A40iYSffhkDrn5bd4BhdegfQfI0zmvkzOB375D?=
 =?us-ascii?Q?Ur9keBzywmI97TTMjVUgX7JnfRo+pPMZYr7NoWD33Bg4NHMSRDnndw8kvHyR?=
 =?us-ascii?Q?AHn7KzvdT+Y0Qkci7NYn9Hdiv3oMj/UQzeknyMHhMOBRkTJNXylCl3xUEm8b?=
 =?us-ascii?Q?6HsJQ6LOqQznMiaV0CVDqCUUui+g85t1B8HdU9FSNdL4gkGdftGzcBez0XGM?=
 =?us-ascii?Q?y+CzRWrGAAPwKoumBtGiM2afKwbqaDu7pqZV8wcYHqbbiuEpUQf1x8pQn76K?=
 =?us-ascii?Q?X6N3ydm9rFfEOdxIxkf8vAfDb+Ff3my/oA1HEUsFnZvD4R6ASsgLI3Lyz+h6?=
 =?us-ascii?Q?ELO1j5sOk1iGx2iMI9qcZd7adbAjpUn1k/GhC5/2KB3hCukiD1eY4xk9gwjI?=
 =?us-ascii?Q?6Lt5qrYNf2TtVoPNUKeTI1qnu+5h7C42F8A9bwVnFm0wUrSu4B3YIpLIPy5Y?=
 =?us-ascii?Q?aJYHC0l1EcPBfzue6R5k5+mXFpnXnD7/ndmOlooY8fP6bk6Mybha4jzPVsQD?=
 =?us-ascii?Q?ncezKeXxLRpdO1WzuGPstDTBAygcf7uFJ2HB8cYd2AbzqanIflqXRKq/Wnyj?=
 =?us-ascii?Q?VLsCww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	siOdnOzTcc7j2iZRVLmh1B7dNuqTBBqj9KjpLFaDfuvCTS7SiG5qapwG4tCL1UEHDi3kv2/SEWboAI6FOMH0zHRcnnuIsYLRh2ZhokDYxIjUEXxMQnAplInCOBgvCP1OkxzbM34W1wSoSqQBAWnhuD2Cg0FtOJcNTpOXL+XQM49s3bT3knI1R44BgBWEP/UCkA1WXsHe/LUqbJ1QqtJZ0ldSQ7WoHZb4yysXdnWvMspXwOL95jhO8yWUPceiNJlfTk48bFLtpeAkaze1M7lwKjTUXPleDGnUngSA9bZzUNMNnLPHB82tsGR77fHvD5Xv0SVR2o1wZOMYf4fet38VinFlg95kErqenTFQZF0y4JqAR0oPy14XnFlsgLdRw3uEMCWJlFHXSyutpQrxxsAlQSC8ps0CO1l+6ijPNhXjPhYFcEnLdNWrFpPHhquOqYoW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:45:33.8338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3170a7-4d92-4738-10d9-08de6a23d98f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258440-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6A4E712CADF
X-Rspamd-Action: no action


Yue Haibing <yuehaibing@huawei.com> writes:

> On 2026/2/12 0:01, Petr Machata wrote:
>> 
>> Yue Haibing <yuehaibing@huawei.com> writes:
>> 
>>> ++ jq --arg flag UP 'any(.[].flags.[]; . == $flag)'
>>> jq: error: syntax error, unexpected '[', expecting FORMAT or QQSTRING_START
>>>  (Unix shell quoting issues?) at <top-level>, line 1:
>>> any(.[].flags.[]; . == $flag)
>>> jq: 1 compile error
>>>
>>> Remove the extra dot (.) after flags array to fix this.
>> 
>> Interesting, both work for me on 1.7.1. What jq version do you use?
>
> I run this on Ubuntu 23.04,
> jq - commandline JSON processor [version 1.6]

Hmm, I see, 1.6 doesn't seem to have accepted the syntax.
Thanks for the fix!

