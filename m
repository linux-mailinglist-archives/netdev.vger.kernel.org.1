Return-Path: <netdev+bounces-286320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CooI4CqAGrhLQEAu9opvQ
	(envelope-from <netdev+bounces-286320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:55:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09703504F1C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E6A30097FC
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AE39F178;
	Sun, 10 May 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwsFfPBx"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28C36403A;
	Sun, 10 May 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428492; cv=fail; b=guTXh6dfCkuvfKxOlL7qlTukKPY36XOibUYybFcfpdK/yuIG8bhndhPKtfHiWFj7BPjVK9hyqjckB9s0uz9N2hxwTdm66DjCTq9H6AWbSeo/05mg4wefegMcYTIcaJEwVVjF+VW+aCwO6a8XraqVt9lbraZh8IsI0kUbxSnTVi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428492; c=relaxed/simple;
	bh=9xvVBu7V+tOGbQZ1GomLWJrWTIhJmw/ERYWljJ0zueE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4KBY691mYCz/Z2hbve2Tw7yBurCBhgbopymBAXkoV7E6bEwz+IRSNPfeFMxqpuIEtisEMN3hVQEnbJviEM4T91oZr64dYY83rXOXHsaaJvSu250tIR1v50ThVJQQS6zZtP/U2soejZ0+RkeZ1G2WH57tanFBVUP2gf8CERJp5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iwsFfPBx reason="signature verification failed"; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aH3qf/maaWDqr01mPVqlZhcSlpLktfVzyprcfHHGeUS4tYt82JEDw0mPkqo9ZuZfNhjQQyeRfKcR3sQ66Ta5wz0UtmJA5GwGMZ9NPAmFhvoodbWIvg241K8QPGyqgEV+i3t/veTyVIJ7qbiFaEcXeSh+0swsM7gyFpEI92unrXS9As66Ya9bzQ6P3GYKGhOVq8sdvmOAF49TiDe25hyh5kb476PSCQS7lWMTrZx9xffvamvDP5MPT3VPH32zJh0DQS1fAWWOsmRM8/idzLwA+QKmxw8ljvFIVMlqjHRHSiu7GgtzuR+qDElsNNbz8vAl+AUTaZXtam17bEkJeWPXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4nF6EoLDWrtoYygUPOvzGNXFnWEGln4+00ssuNWV1U=;
 b=fj5nJk10guvlf80Nln98HpXmb3qamupN3Xg7mT8uFfvPVLTBeJPQWIBilC5ipFlWvWXqyaFBaX/ODXoISjmWChYFQQ8qhcI14jICbt+K3HZy8NWwbvrRZJvXXxy1SRWJNWnbWeLb+mUgUqwUHrGdXjGhdkfx9+Qf+bPWYn0O0nss2B40YTD6X8SCad4p32r4n1eBgYHxaiJn/PCmArDJG3bR5OMBq1YyR/64rrWncK+Gt75q+4vNInLQtQMBRk92S1SiRJl1vwKr3A7WgDwYpz1osMbkp9zp7teWLnwD2fVzfxyRPhU7eom7w+0du7R61L2VHTgxPpxofIG7VNz82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4nF6EoLDWrtoYygUPOvzGNXFnWEGln4+00ssuNWV1U=;
 b=iwsFfPBxxnCbSSXB9VcBjB0KCe8pERQE1SUAinaF0mI7reipO8IeGjlXr0SlsSqR2AUme42Cuh32xpg0Oh6kV+sztMXt/SeOdBueEPVm67PkavtROew8oFSeFqYbAzPIfnynFMSRc1fXFbIE8Armb+yChJzRbkucF6x0TL/FmEllXe3eRIlULb2t9zoLk+W6od8CvtNwUrkZDW8DORDGTSmDAo7uwZjky9EVJPMkW445TK5wM5EAGoP7SsAFqgo7ujZLzsEetMfuGHHlee5aEJVbdfdoqiR++BfYxe5Q9Dq66WvHhAN6+HaEEtcgXg2P1JZAH554PrICmk1T6upnUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 15:54:47 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 15:54:47 +0000
Date: Sun, 10 May 2026 18:54:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bridge@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on
 system_dfl_long_wq
Message-ID: <20260510155438.GA122361@shredder>
References: <20260507134815.295588-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507134815.295588-1-marco.crivellari@suse.com>
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: de5a4598-c994-42d8-ac3d-08deaeac763b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SVgjePjz/0YdDgO7QGZ9YnMQ+P0cFYn9A08iWD0NtG8BEiWqmBju6R4CoDo5Thaf7yTrfJ7FZ2tLqvwOBB0fMeU3fHTTA+bWiCWmKD5j/ndmvU54U2mLi2kwCc7IBpXqVAyddbMmwufGN7NLTylZ7/hDW/DIj1oMHfZq90AmKfB/euAED5yg3X/S6Lfi2jO1X2klN1lMf9kGv87sSW4pVQ/gH8SIqvh/iZFLFyBqe7XQgBI7StRNZEAZmNCan9n0O3KVU5hxl4Y3I4XgBgEOXGVDF4UQcnBLH2pTgpycL769AaXNu6DCAT13mBP4BDSZDhQIjz52ylXCpwoypbkJoazhO4y3cz8TIiH24LsVGiOlST7FuWZvR/DsvYNHBGbfrYvlNggNPB6gDqpkR6HebtP1WFFx0G3NCsauD6F4b7KNeQNHtHMv3fmBTit07RC94AaFJJ0HLSGt1z2O3j9Zw5Bi7ISnz0Z3ungB2yQfXezvQP+VMLKs1Y/dgrgAeHEk/0HquVPJ4jJFqV35nTEA8b9pkxwnAZblD5mnsmhjj3ck3mNRDwwLckUha85gFoU2ACRaX6Oh7Lg0FL8lvDSVqaSeA2ah0kWrjx/VIYj0v47vYKpjGkYHMzhjyvDXp+uCvDRuSEVid5gJZCuHZJkZisIsO3us3QEkO1/pmn1igTM/CWiHpd3wl6XPDA1LDtaT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?nPmJhUGfDCnUg9dv4Yrp/FR/8JcUFRRlB4BT51R5ApNB85FHvmzLzRdRe2?=
 =?iso-8859-1?Q?dSFt8Uh6jmNdhhmC27Dp3j4KhjHs7egTrD9GlARRr2LkrjBd32fz1xNG4M?=
 =?iso-8859-1?Q?OwdCA1CBIXm9HgwH0zsl/JCYJFq5gvrgOXwzERvI78cNzPDKrbHN+3H9xB?=
 =?iso-8859-1?Q?m/eJaNQTEHRgQUx24B3ZGzNwfWoIySaGy1X9GM+a4HmG/nBY27GrB/K7jP?=
 =?iso-8859-1?Q?tNnakQZ5kFSIbLbETbpd7bgrxW3DPG+QofHPaSimVl0SU1C4RBfhPXvZrJ?=
 =?iso-8859-1?Q?qrDBKcDZHbtk/WusjiEEXPKVLC4fDWbVVJXsiQiKmW5Zm6ZLrf9PjGgvYH?=
 =?iso-8859-1?Q?JVHo7opYjHZHMksgiTMqilrU5Rw+jtWbw2utcgU+E+K0j5wzhnRIs9ElRu?=
 =?iso-8859-1?Q?nU/yEZLokpXsJrA7HuABV8ZrdA9Tc4wqXUwcmoaxNTQbA4ZyyNpBNAC4Wz?=
 =?iso-8859-1?Q?uXQV04LEZPfbhTOH86Mv8XgDVHzg3Zw7XXkg/UmCxj73fSj1UwcZKqoGdH?=
 =?iso-8859-1?Q?zlChzeC2f/36lVEogooc5B0OjEkGXDhpdKvh6INJeHpx0PHVfC7aQDuxDQ?=
 =?iso-8859-1?Q?QiLYFfyStdEnpBEKpbfvZn1DYfkDuJtV+zSfCeG3cLTfjDRPRLXWnGA+Dm?=
 =?iso-8859-1?Q?1x8Aa4ZcpUCjEUccYdD3thLuC4aRmauGfulWwpOlIV2lnLVeJM91lRdDsI?=
 =?iso-8859-1?Q?ZBfWsHmlIEqNRqoQSufdVMhlOzd/fGVhJdKLAvqxyN+CCQMgg6SWcm2sbV?=
 =?iso-8859-1?Q?jsQKUc1tEu0zokd6hjqGGdegE8B//lar36c7q3bdJbymKLhVAxgKLtoSHL?=
 =?iso-8859-1?Q?1XqdLr2zBvjhTPweqf9xWv+ipt15C2aMMuQNK+vDvrAuYctq6GGBJRFdXH?=
 =?iso-8859-1?Q?fVoqKT304ZGMFvxx5zg8KgicABYwp6Fou8HmEJGG1/XvIKyESx8RvppPK4?=
 =?iso-8859-1?Q?V4D8+To9gJ45pqgkEkKC4AgbmSI+UvDSq1yP3U/hkH/KiVuKF5kXJ5Dlcg?=
 =?iso-8859-1?Q?e6s3RrsOlwfFVMM2vWWMOLIAbKRPcVNErpUMzYvlDU5kg4XWlWMed5H0kX?=
 =?iso-8859-1?Q?ZRUZng/6LI4pPqcH4noa5pcrc+PLCA6cavNH9U5ghpTvPmW2uTl3CgqnLs?=
 =?iso-8859-1?Q?i8YIoXHtmfJZCK0h8uSzNVEHiwbZWA+S3D8rwkL8cut5P1uIh0S3IMtN9A?=
 =?iso-8859-1?Q?RBRJ5/CX/YDWVfvpLVYH2gzwgWlaBUSMULOE3EgEiynSBQ425XBLp/1lr5?=
 =?iso-8859-1?Q?++hQvWs8UvWIMfptC8URpr1JjbfTW10gbFGYdylQNSZ1uAKKGPq8TeNlaz?=
 =?iso-8859-1?Q?g+RegG3xldwIgaXAfzova9AkYSYyPy7oxBE2HeKs3SpzQ9ZCEoUzQS1G41?=
 =?iso-8859-1?Q?vf3XBi4jEzdDI7o8RW8CIM4RWq4TfmWiLmtUpP9rklg7KAYYaVlYWBX3Zy?=
 =?iso-8859-1?Q?yoiruZEP1iQcuNdiFT2xzgOaS0MVgSrsMrh3UTPyuLBQH+BY5U52Ndkwyk?=
 =?iso-8859-1?Q?MJSMVhYYnkx+hIaxyO1GO+/+8gkY/mtNa3a73onK+uZ9h3UvJ4cGJGGpsj?=
 =?iso-8859-1?Q?YL11N8BaxNTnoPwCMqcIGpnYCRY8ni7S2RsuVR0apyExiLPhWMG9wJDo2V?=
 =?iso-8859-1?Q?wJzz8Wise35Wo7O1HC/Ej6USae2tY3edbKPLfgzqea1a5WtDcxwuBqulP5?=
 =?iso-8859-1?Q?CYOcDuIiWhyLJElZwynSD4Mfe2oO1rypO+R9zEtDm7QcRfpEYI9uoWxAwr?=
 =?iso-8859-1?Q?6TpOrdwXrJ5pZBdo4whQRyFgr5mKSC2tJneGXnYOis8PEU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5a4598-c994-42d8-ac3d-08deaeac763b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 15:54:47.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ5rp/yQSga/VBsv8UoMDSJOl9KqKZjMNSIWRDuA8ReGE6/HV3O2d9mQkBl+iFH9xKuhENVKbiI1oqOwYe7kLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
X-Rspamd-Queue-Id: 09703504F1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286320-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,davemloft.net,google.com,redhat.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:48:15PM +0200, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
> 
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
> 
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

