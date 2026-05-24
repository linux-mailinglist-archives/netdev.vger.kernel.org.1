Return-Path: <netdev+bounces-291213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GpRNJMlE2pq8QYAu9opvQ
	(envelope-from <netdev+bounces-291213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:21:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D6D5C319B
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4FF13021E50
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA23A872E;
	Sun, 24 May 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/3Mc1T1"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0983A7D98;
	Sun, 24 May 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639264; cv=fail; b=RLOYAXxWN2chZx5t13eY1gDf1V9OLV4wZ6bSNpf0CCDqWR+14WXR01gyT4vqMgXTKNcs4G70akJe8AeOgkCO9JWrr76/45EfZhXs2rNDYhbzuHBfwvaBKaKFG6u5uO/oIlgBfZHIvwaKR49tj6ra8pRO6rlqgc7T6XEUuD5r0q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639264; c=relaxed/simple;
	bh=HZiDXvgEPhOHu+vjwkkFN0zDnCd+uVp+xUfvbpl+L8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KveM74pAfM9a8DzY0x034CESdpTbtBctcOn04ds1+QPUmCA4LRyc/TqxdWww6rrPRv/TaYCXUkaES+8RXxexFCDDtkeYJvDLnZmREV+I2aiDM2/1pviZ/F/IqNKowa3Qpl0khEWfukrdkYUkxBH8gmtrE2vkaYayN9iPfwglYbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/3Mc1T1; arc=fail smtp.client-ip=52.101.57.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXrSEDOBdmX+nW0/SAydI7Dubh7p3Gm6NGnawPhmX1NU/k2EMBBKWAFvRuQIyRl0YLYp9qflPLvgcB5JAU/jI9eKKocoJBE6T4SIIfoOdWBflI3wCdKe30QNkEXhOQjx04k8UpHpxVIoOutHWYMMS12xy4oreRB371T5TmQhPSiv6jsOvBBXXEHwxOkW2eFRafCreJ+RVTR48S6NAgtl0uevFI7Pz7SfGcCN408nTIp5UZkijQWXcw+4fsVsny+eiu68iL/bVdqRjKzCjTxVO7GRQmJ+oUNxGQkaPBYnXAlKTX6hg6vz8/qxEpMyltPa6VmbA//3LxcIq7V87LuzYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be6wSyCEpYbtcnVcXv6ORjSUlKiQFSiygEczvUI65BM=;
 b=QRp5/uBUWxD1k/gkuOL/XI/7vjTTfneTSe3cbWjX2ToGzR9jIAaEr9JOCZ0F8pFWjPfU5fInIUGilenI5yGfeb0JarrepecVjoc0hOLCI9RR25vmNaBwimS0mDo9TtAOxlWDkJ7hpT4n1m9AlkdoGh6ODc6v1YZklyneEmKVAq5a/j+yPi1geMMAS1aU1C3UYcG6KFpeBXRHqrRUunviUdGR8Q5HQfqmKOeON0moO8RVRJnCZPj01pFrkM+hDRNSATShpCrevIU7lVOF4Q+LQiwjFU6f78J1YVzKCDRSA8PQt65he31p5uTgj9uER4YvZXJBtqHNxGBwKr8nBFaDmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be6wSyCEpYbtcnVcXv6ORjSUlKiQFSiygEczvUI65BM=;
 b=M/3Mc1T1WrcIt0K/Oows4jNduXskO5AJKquZ7V7msHEr7EEqnN/UFWO7p426v6RDc5XkOGxuCMSb7gSF4+0FJp6CJDR2Y5wuWHzRkCaDIJ7RMQZSYB/Y/WtnLiR8FbPQJ4h2uwwgQNKr6SBe4E+jgzmoEmn8F0AlK9wNOzN7It58xDXNGRyW4n/P2B9HZVrTGOazv1pxrC5WmSd5My/iDys/4rSfHPuvY9rpBhe7/GTIfSnLPC2tplvfpGcqjHAK1kN1mGpFPxq2/i96sdcccNP6PKRqdGuWuCefBX6tSGmJuSy65+lF3HOYqIgPvL/6EGI24kVkgWwefvZgpHkIlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 24 May
 2026 16:14:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 16:14:19 +0000
Date: Sun, 24 May 2026 19:14:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org
Subject: Re: [PATCH 2/2 net-next v5] selftests: fib_tests: add temporary IPv6
 address renewal test
Message-ID: <20260524161409.GB110992@shredder>
References: <20260523103811.3790-1-fmancera@suse.de>
 <20260523103811.3790-2-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523103811.3790-2-fmancera@suse.de>
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 704c385c-f378-422d-e158-08deb9af824c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|4143699003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fc0mSkn6zwMcMca2Xf4BRspvD3ix0YZ1RRpoap+kfI8V4BU79uCJefilByVU/dzbaX+/gi+U84w88JibHY78QyXc3MXCd0vK00YyUg+2sm1nhsTOBZDGsVtNN4I5ph+GD4D4Owcy4VO4iqfLeDFTKdSW5BKxsjLE/Dn0AVxEMayyUUu60ybO5QBKz1sB6CaM1FAolMY2CVoMBQX2Y6CFICMB7qN1yDr5Hrgsefi40mfD70F1/RAHEZJdgKYJQvXQFKFXrDJP7lTUM/8lg5upS7or9iOrKn/GeXvLnI19VcNhLotoSPU4sSZ8EnDBAPwJpxYhF0NXK/JQXixoQpI79GJ3A0PVOFWG4rc+RvcSl9yBh7ftZ5dImjMmBVrhAvo+AAshc7GWcwWcvR9ZSLU/iUJ5sBtwvrvoPx7ZhMje24OVgXOyJvSDexYq9+d1LfKjvTU6lrpwF0saVKHHmYrXM0/8BBc66gu2twobi1matQiYzqPmO1MKVOAMThxb43DOL2q4xf2rGUpvRLsYd179fMjeqfEpNE2xq3tEgS+ZwutFfgm6ML64+OF6TwpRXpl8DsYj4pwl8i/CNy11GnbVGFsIFOba1p63vvpNlGhqwyecyNeY09bKw42u+JC0s7c2QTokh5qoMAaV3WdlLTGfeEkiL1H7gFB+ze7vS9yaD9cdW0EMA/10kDvSzfwVuG4e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jZhf/dcZ6UPDhGv8oWdocLxxd8gw4qSk8m0VrmWdvBN3A5sBUBP+yM//5ysn?=
 =?us-ascii?Q?6GEVpELKZT45nRgmHTSCMq1O3RtfcqvEjGJ8n8OWxTlqpQo48S2J32B9atH/?=
 =?us-ascii?Q?RMBUrLYxyAwJD0K1EgWVDDnHZ435z21Nb65rsQP28uhg+91b9+tK7PdAaY8o?=
 =?us-ascii?Q?c7jqUHnhaCWIsMp40g24bVQUoVqc3ou9RhuPdpXenH9658eugNKxAUWABqoo?=
 =?us-ascii?Q?tl3/ZFDR2dqX0vPYA9NF8ds80JBZ7a9+4QTAvohSiWMfniVixL/Fh0lLcxl1?=
 =?us-ascii?Q?XEnftDO+Smf/5kPJTlnOlCPjSk8aXdlQKx3OUYulYrWwZvQvB1lhPKDHnVCY?=
 =?us-ascii?Q?EmtaRPDp9hy7oCvnIGo3PfZGoeB+nkJYtNmt0ILJBwRn/jbH7IQtA7fsR5QB?=
 =?us-ascii?Q?xN3l3JGv3qweTcD8GwaI3UEAatAuLrL2yRi4m8k3NCfB9K4zaHnbQu+cKluH?=
 =?us-ascii?Q?N7YoXEdezqjfMHVZCHCfCi8BLuOrpizUoDekMCs3aKQdaQXuogb6pUN0TNFg?=
 =?us-ascii?Q?EA3Yo8Y2xhtuvgDiVlp+MS5H0988ZRtEUYBHTjdJ5w2T+SOc1jq1wwfyksBy?=
 =?us-ascii?Q?cvskpkAgl7d7GIMyVo451leCb8WscwEK1a4/MGdaO+03OkgcK7j+oIe6eW+S?=
 =?us-ascii?Q?wMw2oaYAorWTtGbfWrQaV1pMrUlo/XKuSoavXKm8cXGwOhNSNDg3ZP5I3mTN?=
 =?us-ascii?Q?grHs/9FdK+ReuBQYTElvz7Z1M67pg9Fw/Zf8N1eFsqAHWpmSTcPlaMrn4kYv?=
 =?us-ascii?Q?1C6wkDpLs80iIc7qM4CLvWohAHOMfM1Zn7/xP+lOyp2+L7xI7yqrcE05cTVd?=
 =?us-ascii?Q?vt8quhh4o6K9rZFZL7qYOENwOf9MpGe7LSr3q6sKfMv7D5D4632PQK1D38DT?=
 =?us-ascii?Q?h57GeFbi254oip2qb5dqg3H1R6FXVd50BaaPotGKbzVZPpVeok1FpX+gvDj7?=
 =?us-ascii?Q?UKzd2pOQh+Arj6Q50TZvRDVmYHhZhq4z3+usDFl2fmSul7GhfSvcH3GEsfCl?=
 =?us-ascii?Q?MCl5kJJfJkUGaS4UX3aLjXrsgxN+LQ7BdZwNR/b7x48Z5w/e+lHseJGZao0j?=
 =?us-ascii?Q?JLBp6OznlB843irktMoPP3UUQYdUGhieauKNvBZdfE+TBTVjvAcIq8O0VcH+?=
 =?us-ascii?Q?cp0gZlJhtzRHAqMS8RMNYQ3vUpKKa/bKk5K89h7Zxt4r8Tsr2qaIDmFCBsYb?=
 =?us-ascii?Q?h11FtCzCWEwxeSh5q+OW5aed9h6ENz1KTf7ed8Ewsa/ZZp71tr82plusLU4H?=
 =?us-ascii?Q?fMOCg6mTokUOqiNKAkve3H8i5ecJgJi14yO/a5Y0F25TkrQco09H4pK09sY9?=
 =?us-ascii?Q?aoCKAJ2wWk2dAmNDXOAhQODPL1ZYspHe9RNx25NQ0krTsG0v25USfL6VAFeq?=
 =?us-ascii?Q?P0fdBe0AHEjpLSvi+9TukpQKZlqdX7VqDnLOdYhs56y7/4GN5BvVKhCWLcag?=
 =?us-ascii?Q?rIA5b4yhoJmgkB89aE/WCVBKzSor+4aswxDpAlOdmGIZwdw6Y1ETegDo31np?=
 =?us-ascii?Q?i7Sl1apUwRe32bI1lvuoTAMqRw2sIfNQRTOXB78hfyI/uSRPqzTHh8v8NlH4?=
 =?us-ascii?Q?uZ5sCo10kF16+dOPUx0s7DD3yKaBOUkuXSoDVByH1+eHkXp0AX9BvvdYY1g5?=
 =?us-ascii?Q?IJ9RV22ssXHn9fbW+OFCKQBGIIhHjGZI2tJnV24wZj1ljM9XAI0SwVQjsIcO?=
 =?us-ascii?Q?wOI++aWuj5m4vrvlB9jucLqUaajwSmJfCCuQ17OEsEz7USPu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704c385c-f378-422d-e158-08deb9af824c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 16:14:19.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGR9EJDwGhKrfYPO+tFKvxy/qNLsGi5JK08i6hUeq9eqH7sgDskmr281tK16jOzG81RGsS7PdcWY6OjA4bZcYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291213-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,suse.de:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 71D6D5C319B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 12:38:11PM +0200, Fernando Fernandez Mancera wrote:
> Add a test to check that temporary IPv6 address is regenerated properly
> after the base prefix is deprecated and restored.
> 
> Fib6 temporary address renewal test
>     TEST: IPv6 temporary address cleanly deprecated and regenerated     [ OK ]
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

