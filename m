Return-Path: <netdev+bounces-89396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EAF8AA37E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90271F220AC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB51A38E3;
	Thu, 18 Apr 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gi3Hb8z/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB91BED60
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469844; cv=fail; b=CYHRuluMAgWJ4npBI49YjgwQrfWELqFrCu7ED79OO2u7t+gve3clVKx2F4WyPNrzi6aw+45GtDiiAYradKMCbv0Bug+Mv5bOXu4m5Wbb3UeRzgStk8LyjipgtZUNUB2VHfvNqaFha3ogkLdNePXzjtopQopskVaW0Rp6XEn1L7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469844; c=relaxed/simple;
	bh=WCQXqLvkHa/83OLyPp6/15CHhUvd7AConybuY1RVJOI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=N2XGswLOZkBuPngSB8q42tr3C/il9cVhkaLvTwuNaTYxjLgJ5ApbEEqdaUT5J0XYJFbdRdj6jcyTVT86b9eibu9sLtg/PzA5fjENOyg2CEzYqW9uubnWGLbGjpNzvVqJUCtPA+wOXpfhcyS9YMhvL+htKn5REgiPrTdqefkdteI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gi3Hb8z/; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXZQY25yg14j86+Mo2IuMbCtsIT3ykbvBYCmV7nFe+5rlnlyzJ3y50DGD8hZGoDIm/pCfTtrHuw1pITLOGyYF5RzPkMHW5lQJpBOow84KBpjhbzea+5q1VmBAnxwHDusXCzn2JxONJ62rIijR2wa9Pe7loWszXnwseRuSm2/8lgSWb9IT3rufrZb+YPOXjwx7HBd421l9m+fX1QxkrZJZbABhitQb1cOOdgSack79TljacZ6cGVQmdNXzzlgziphfQU02SHEkQVWsofyNaPdIfqWWDU/94DUrMSzOJ2Rm692ToQscRokeRsX5CVXF0kZDZ0fbuWpBQS96xJbYwgBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCQXqLvkHa/83OLyPp6/15CHhUvd7AConybuY1RVJOI=;
 b=BEGNgaVmq0GRTuheXVavyNfMBMgZuF4NhJxM3LZiwe9zRKeQXVkdxpTlvm1wyZLyWUchTvp+AyEnWz6HMFeaCqw1F+EwfNtaA0MNNVLLBnTUbJL7QSblQWRKXlzT3BTSEy6Sq1CQjzAtHsxoMemqnOMQT0iWsW3bAx7S/H6XbLWgEslog4SMXjM0vP/jNG84214wvc6cJUzgI4v4/eP62/4w4GcPCrxy5pm8x81vmI1MdPl0BcVSV+/VjooeGloknfgLQCYX2Fz1AyVaJeya2cGGLbAGPJHrrU1xIhoXzWGTFzY1/+uPvY1Y+B3tNggzUfhHxfdywe190iD6KOeTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCQXqLvkHa/83OLyPp6/15CHhUvd7AConybuY1RVJOI=;
 b=Gi3Hb8z/k7XBQmIx6YqJfCqiq/rRUxl+4wieYPjYmMbZJ22lJuQ4ArALHC/aiDiUgB3ptIIO0EhRfU6pPcL4hR6Oq0iRQ8gX2eHKzCiNDGwVx5GWaIpbgmiFlTQdlhyavKIEn0nWuksC1k9rmuVQ2h7AVd25JpnhROskUb4xC5iX6gS6cphDqvBkZSfFV9qihUpBoVw3iwUrEDM6pSFMtc9dspJyhI5b0QINpmhUFkN8FgeaFM62CXFbSJDAdqq3tWwh9PoMNHTRmz96gJKWj4HqIuORt7nMcDs5CUAi3YI3zABV3Dyr7X5iNqLkXM+uvQjWMIQ0ZJdjpK0XCNNwKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.43; Thu, 18 Apr 2024 19:50:39 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 19:50:39 +0000
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
 <20240418052500.50678-8-mateusz.polchlopek@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 horms@kernel.org, anthony.l.nguyen@intel.com, Jacob Keller
 <jacob.e.keller@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 07/12] iavf: add support
 for indirect access to PHC time
Date: Thu, 18 Apr 2024 12:43:00 -0700
In-reply-to: <20240418052500.50678-8-mateusz.polchlopek@intel.com>
Message-ID: <87o7a6e9gx.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4dfc8b-0263-467e-91b4-08dc5fe0d268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9+tQUluzyA3tpgFNYVQU6KRKyXeYQ7G3m0QK64x4TPI2kMo4nekWXVlfqGD/mOFdkFqR4YKM8bYwvddY4Bvhf1tXA7h3wMSBzF9OhnHy6ZkzsWAYKnpbdiXEPaZ3XljU0bNmqF0KmZbBA4v11LZJ11azndwuGh2Pfc+nZi0W6W6xblMiDW0MnoSOTUDWRFaWLWMChJnr49dk3pmUDj2aieulO5M5k7OMzfs0vFHCM6X0WdzLG3tT7atoNnlcI5EKxQsy0UaB50JB2G+UvUQ8T0f5ZnxgaEtADJby2IM74O+fFVQ/PfSl7nu1Kip8Xkixrt8V261eRMqq919IbiOiaXrv2cenf91pIPSI+S5fASuLLMVU4BVVpCWM8PhnYF27jDieUPP9a5fwGXIki+NVv+W2vFMwksdKzxdLKNDDk9/4FNYhcj7/kRT7KJCQ5kmLgGVHcucRsgMt6HtZkpM0IdW2lknlGb0YZce+gjb7nJ45ZNl6gd/FdoF6zYdChfMhIX95IkJu2dKF11xwLka23652FKhxwqcyTnwz8fxb3lsCT8PIWSO0tqHWyWlhAROzEqEC3SakSQleMwBVel0zhfimSEMrVuW9sM99zq0AVI+2QEQDCys+YsWCIaishtViciZVjXC/CW8U869ybZ7/YBke9yaiaaONWxmPvhFSzLo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYeinWIdXtJgXh9/z2qj4adH/n+HQUS7pAzVNOUQc3XB3+N0Od2RRY6nSlON?=
 =?us-ascii?Q?nalfXjb/t9Tl/b2yWBt+3XlIG+8Ad+m9eY3yyY24IPT29kRlAuIj3KZcbUIv?=
 =?us-ascii?Q?8Jtzz20gIhzNaZkePP2kOA+DIipYroOSOfPuERM3R2cOcWOSvorWExYVO11c?=
 =?us-ascii?Q?BUS0OX5O57PIkK+QeKbADLWwcVVkxgY0E4lGgVOyUlTnXNspjOMZ3eHV+2BL?=
 =?us-ascii?Q?cGj8amvtoclOtbHzfh44EOedpXy2pBMv7iIeXTVKk/G52D84KwdFJuPxv2el?=
 =?us-ascii?Q?gwe46OxeKg2K6cuAHOfBoT2VjpstHjUiRB3Yxm3ouSFHh+iZ/MOCiPBuy4k8?=
 =?us-ascii?Q?V3T+lu4sn2NjjqhvqI1yt7Q/7G6+uXi3XXZezNw8zSyNZKEhQ39CcPZw5L4u?=
 =?us-ascii?Q?kj21H3sWnQvlD3Sg0FPMNDU+A/ZDmhXyK72plEQwROzoTRS9uaZQaSGCtyXF?=
 =?us-ascii?Q?pgL7bc0eQ5BR8WtpljbitV6zEOhFzK6gQgZMUNdlKdrJSHjjeuin8ZAEFods?=
 =?us-ascii?Q?9WW2QBGwZQPKxePw2RhVu/KargsLn0bBK4bOzObfh6TfiQRmFYukMmUQpgDJ?=
 =?us-ascii?Q?5bTfZ6WNaTKmwL9wMQtczZyHGnQmi46+A73vcuBvDeRtZMyQ6YlyiHW5/NV2?=
 =?us-ascii?Q?2My/Zm9jE0ZrGXXt6px8F0ip4IUSbXoD4+U6ALRJwurkzQAVGAhbzXU1CxNV?=
 =?us-ascii?Q?/XTKcRDReXnUJRMWMAUWTXpPoVZePhUbCgdIfugbIrc7XeWlIciA0Cd3WKdX?=
 =?us-ascii?Q?EyiDiuMJYg1yqbwjllE2hYqjCiGKaNavt5gLGulu7mrA4Sf2J3jKj+0RJqXr?=
 =?us-ascii?Q?GfHa6UvR3HRw4yyGcV5HeT6kNGjXO+vc/M/fRCz95tPud16WnECmjErFOdeS?=
 =?us-ascii?Q?D0Bv05I9OzCZ7omVeLiSps7DLuHUgeZMWFmXFFMJ7e9ViIny+K5xYx2fmIvL?=
 =?us-ascii?Q?VuHmaBzpghcYQxVd35p//clOAPni3G6r5RG0LVOf/KZ7QXV3WDGO4kRiL+z5?=
 =?us-ascii?Q?gaw0bpeBprmlsy9UAWDS4LXvXiMGhPUYrvZfpD88pjRhn+hAnZE2f5gBtrJu?=
 =?us-ascii?Q?q/5ZO59GXvc9idnt0kYrx9SY4jW/zNliI5IbeY5D2DPotGtOPmNb8J0C5lSQ?=
 =?us-ascii?Q?iVGn9RwD7JlcXTkBk6R5XFkYbAj35sT/Th96NwzC7vDYcpLQkfp2AU7I2/xi?=
 =?us-ascii?Q?idJhGsB8gfyEySehPz+htkU6Wi4rIWn99OWdSUbbMfUzNahIGd7zyIC84KXL?=
 =?us-ascii?Q?IkGc8VzQJwM+J+Z5JR4Y/p9fRY4kjh7wiCnhQJOQwtLzw6HOdwnrhfkKqO+2?=
 =?us-ascii?Q?T90JCFGJLAa52FTjQeM73akxbvZ3LBfkci064vtvaeD6/0c0AW59iL/6D4ZX?=
 =?us-ascii?Q?S5PcDwtMiMzKxibCpmb3lwjNesIEYGybCZMG87LTxEcmIJPE8oKd2ROsOQNk?=
 =?us-ascii?Q?9n3M3eDiccTvg1gxZ8LGRa7u2bL87EcOZN8my1I4cEuXjn5ZjISTtd6SJc1i?=
 =?us-ascii?Q?5vJev8em/oVy1lLfufg9bNjWcXLBc7Yw+j2pt4afHqARpCk5TutgshPo0pOV?=
 =?us-ascii?Q?CthnevhJ9kjYGXTL2AMrCXWpNfHqgQpib797IKcmuZnot2fmRu5eMWL61/A2?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4dfc8b-0263-467e-91b4-08dc5fe0d268
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 19:50:38.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AevhZHx1n7XIxm9++70D+50VFPS9wfF3p6OQIjCaBUkHqTAx60wcuzDetfa4zE6lnCA9hnUzM3wynaw7GJNu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559


On Thu, 18 Apr, 2024 01:24:55 -0400 Mateusz Polchlopek <mateusz.polchlopek@intel.com> wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Implement support for reading the PHC time indirectly via the
> VIRTCHNL_OP_1588_PTP_GET_TIME operation.
>
> Based on some simple tests with ftrace, the latency of the indirect
> clock access appears to be about ~110 microseconds. This is due to the
> cost of preparing a message to send over the virtchnl queue.
>
> This is expected, due to the increased jitter caused by sending messages
> over virtchnl. It is not easy to control the precise time that the
> message is sent by the VF, or the time that the message is responded to
> by the PF, or the time that the message sent from the PF is received by
> the VF.
>
> For sending the request, note that many PTP related operations will
> require sending of VIRTCHNL messages. Instead of adding a separate AQ
> flag and storage for each operation, setup a simple queue mechanism for
> queuing up virtchnl messages.
>
> Each message will be converted to a iavf_ptp_aq_cmd structure which ends
> with a flexible array member. A single AQ flag is added for processing
> messages from this queue. In principle this could be extended to handle
> arbitrary virtchnl messages. For now it is kept to PTP-specific as the
> need is primarily for handling PTP-related commands.
>
> Use this to implement .gettimex64 using the indirect method via the
> virtchnl command. The response from the PF is processed and stored into
> the cached_phc_time. A wait queue is used to allow the PTP clock gettime
> request to sleep until the message is sent from the PF.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

