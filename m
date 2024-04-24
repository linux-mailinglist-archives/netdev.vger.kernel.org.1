Return-Path: <netdev+bounces-91006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD7E8B0E63
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5631C25800
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98F15FA70;
	Wed, 24 Apr 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkp6KENO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349815B97E
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972603; cv=fail; b=A1FXJcyzhX24pp+3hgaTJrDDszxwSIx5cBmQc19kEttIM7BIwBxfGQZ1iUOJ3WBCSwxu4rqrVCU3dNMg/DlPvSwbaNn7P87r309FAko1ZArX7gyTq5MnHWzefv08xzHQycoY/WFx5GGWkhxNzaGr4sYtnuoku0PlZIjKXpUXYI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972603; c=relaxed/simple;
	bh=nZiN8OvmbtF7hjuaShC6o2lzNdxQwCj6MHEsw2MijNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rV/KiYfesPB/zty8DN2cNXKDAHJcjya2bBBIXq/8vU4Kpk9u5PcNfDztsBQkfVOXdd2RNMsaJhqgw2W2QIWGAhQu/QXjMxXKRF3vEqDtDfqIgL2GAmYjFFeHLHhXumxmxvItdZJsy+VpMy3RNqW9GuOVCaRgeHzCRqqU/7/oI/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkp6KENO; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4bHdcw4xYDPgp1ZQq06WBa+iYI1SQec9TDKmpWnizDxiI7qJmM1JCNUwUmj/L/FgHCq9c8VTNDdIixD1Z4O/9G2JmqpdIm/eGeDWF/43wnL9o/w9p5MLpaaYzH4kVrL15v7zQRNp9lNqjVLBYkim8dFrVL1KbsBIRH6T582DNWo6D43lqBgtBMh2vm9cgbd6N86X54NAnax7m/EID7K5a6+2Ybem0UMg9PCCw44THb5RPZl3dot03sqQFP/0pLtKXUs32sNplSYWpFXe0/BpnqHzHF1q/G2T/+8v1GgAFqwvIBPk90TvUQ3y16881M0yWaA8Oq4B6/EcrGXnQssCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z27niFi9orxrPfY6/9ZCA+MMNE+fr5Mw6bSCrubs6q4=;
 b=YLB9xM2z/BZ9iSc9sGgjmKWmDWK342aw8sWrwK8Jsk6W63kgdzEHMGzySr0MWStQSxmO7IBtve3TX7qk0pNZfwhvzNlg+xwByQiO3YOkMGlo8mUJiFO+To9+E65I144nKVhmwlpfrUPfNNlHy4lYWl+555OWjzVX+MNjZlRE65XUE2PKM56WmKogsMNRi2gq0lkLqFgo2Je9ePe+ptTMLJyP0seT1A8aX6JSKk139Nbp4ILIifkLMAMXhZ+9F7MkhuNrx4LJAcZobAuXrtJKTm0B7Ii30tgnGl5G7EgwfKu4NOtUACHoKejwTHchyY/N3S6AOaA7Wwt+E1mBXcg97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z27niFi9orxrPfY6/9ZCA+MMNE+fr5Mw6bSCrubs6q4=;
 b=fkp6KENOq1uysgB7WyrDY5ADb3/tNwZimrHsbu/HHNr2rrqR5JEtYIWLzQjOymIrDBOAhV7G0L3627k596gqUVLSNqd0+Z42Nnkw3nKf7ZpkIU6qG3uCyu2uH+m56d2PAwwN5t2vYpBQmFUNRWeishrK0HfSviUsr64VamyaI+gz19djJGTNYXsCyKGiLY1/oxLIHhJVpEqNL1UsiZF8MyJKZsFfS+4ET/cWaU4nVYLn+/IoDwZ4fDdDuZZBiHpGTMg9pWmk79tQylzooxxbtBkFQWIyhQhcReekTerLACN+59S8CiycDv/5dqP1wEWsXtycsFtcnvT1VwYzRspjXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:29:58 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::35b1:d84c:f3ea:c25e%3]) with mapi id 15.20.7519.023; Wed, 24 Apr 2024
 15:29:55 +0000
Date: Wed, 24 Apr 2024 11:29:53 -0400
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v6 5/5] selftests: virtio_net: add initial tests
Message-ID: <ZiklcfBlSWhyew7c@f4>
References: <20240424104049.3935572-1-jiri@resnulli.us>
 <20240424104049.3935572-6-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424104049.3935572-6-jiri@resnulli.us>
X-ClientProxiedBy: YQZPR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::27) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8f0d1e-a468-4595-4670-08dc6473646c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9WBLeTguQoKxIY7EPOzvsQncbG/6l4z2G31O/unxFP1urPOA8LDQoWh8YJ6b?=
 =?us-ascii?Q?e5sduWHRw368dAEZR4VJLHYmVvTH8Mx0wzCBiGI609y8DfPezSk44fCsGbnL?=
 =?us-ascii?Q?rcBwygorvHfav19+KP2sV68DpPD63FJ4CkMJSQBHzm1YPMpy6YbqXw3zpSZh?=
 =?us-ascii?Q?9hZeQvJhZJ9nAbuDgyC952fR6Ho3JWXy4kCOkjeoVgvI/cYkzlOYAdZu7PPT?=
 =?us-ascii?Q?wBx2sNx/kz5XuZMXt2zOJnTh0l/NWRD8Q5HM6f6ooNrxD8x9G5R58S6xXOcw?=
 =?us-ascii?Q?mu0dDsrnudkBGyKYxsXjwWQZMKvf9UcQmFt/2cO0etpJgtTSr4znb91xbcIT?=
 =?us-ascii?Q?GT1kq1JR42uG4/WZmG/2Zt9kAiywLFKZE+JZ3qVm4+7eaqH/C9wy6f1a8XkT?=
 =?us-ascii?Q?1a+KnsFat75BqGrCs1OVL6JWeriiZ9IEmhNq4lNMm52m3QPOl1X0r0ChvEOi?=
 =?us-ascii?Q?12g7KeFn18Xze7SqbLRM7Gl1QmmnEUrAmquM0sA18bLyHAZom/X/j4qXZaDL?=
 =?us-ascii?Q?b9XucS6GvCZUuIV1giM9/y6uJfMd/LX14SmNRfleoaWpKjv9JSCsQKD2+WlB?=
 =?us-ascii?Q?149lMzwjFSIf/+TeTraisUSfW/S36NBhn9NBuNPc9A2SVtrHB2MNrCg0i8YI?=
 =?us-ascii?Q?xP7FQJ2K9qSS7hEdORl6zHmRguJGlxIS4FfUjnom2NCASXyXM6oOVizCopHG?=
 =?us-ascii?Q?d8g8UuIVqx6ctBuWYp+TWb8+mgv40Q/YKqxRuuSBRmDzOMahmk0TV6hcfTgr?=
 =?us-ascii?Q?L6Rae11V43hYr8qpIIv8O53mBAPTBTQtpCqqTYkDd/1dYaFW4z1wp4xwS6TK?=
 =?us-ascii?Q?zjDKqx6QA2DvYOWjmCTxi3vj6+RhfUtCCbWeV9NPHz7oqEewWccUs3q+x8wZ?=
 =?us-ascii?Q?GqmfIuFuzrLDoMsDsriv2zog8gUIO2f+pm8Uq24aVCY4ff2N7voGrXxImscL?=
 =?us-ascii?Q?AWfjwI4REdVgjDZfZ0Dz92rf5ZjWwBvgn7N7lnj6pkQoOMW0/WUGt/d/dhFS?=
 =?us-ascii?Q?/Qlelknm+cZh82KbX74iojdlmYCOP/9qeKBRPk0DbwOhjDoMaut7aMBr63wG?=
 =?us-ascii?Q?EfVRhPe8q9GvmdeFyipbQaX7QEYqnELcb7q4z4w3h+UgqcLbyC1efwtZqhgd?=
 =?us-ascii?Q?PwasMorRuEQGNq3NzEzro6X7MUzJ3YxgGYSl+SVHgkfOePnvevSbXk4tAmlu?=
 =?us-ascii?Q?EGi2IX2tBfjhvQKSyD9jqsBToN3SAk9jIwihyfqxmQkLYrhNzWH4G3D/W8kk?=
 =?us-ascii?Q?VZ3ao1rV0r/m+ylg2EF7drmP7QeRLvYxffSlSNVztQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mivo3+ZLKLhzZUoup9h+TRHw21dRP6UbCdj0gGAGDgxUH7mOl031FKS0XdDA?=
 =?us-ascii?Q?QSFdl9zsOW2m7GQPr0cUw06NiHGZCELZLRFLwBX7dhMBWav86RY7uQ14j4/t?=
 =?us-ascii?Q?0lS0Q0mmBGl4sw8PoCyFQKuvkqP4GBiI+/7ngaET80ch2AV4ZrEhZLjlLP+E?=
 =?us-ascii?Q?+FBBadK4XXksyQXQEhWvTWyqoUEy9TK6egVBcCqCyVhP6tAmoZHi4H7FD7tY?=
 =?us-ascii?Q?tnSJ6NnFkw1FEjPG4S7nvNzaztAa5WmnJ3G+29GksPVFaVcHA7FqcJLpKiMl?=
 =?us-ascii?Q?IASQoyq1Y9gwVOB6ATECCDjV4VgXDobtGMUPaxa0jw6MrXHOsuc4hlWsa9Sx?=
 =?us-ascii?Q?6HI4Vht8I02hdy9Nw1pNrZvYcU57GK1Fbdzvxa/6vXGNjv+Da0ctiRqe1t61?=
 =?us-ascii?Q?JmT7DxtO3mtjvvDxcidr6h8Kr5Jp/LrUJa8M9ajqcBQMpj/C2z/xj+T0R2wn?=
 =?us-ascii?Q?hkX7TXjvHRleMtYAWXibPYtalkteUCMcE7wttYnfTic+M91m8okWfLKCc2JS?=
 =?us-ascii?Q?C3354EGEW0gPUcHeFrxE65CKKo9aok6dv7awbb5RXTiy4tsPuXq+Qf5zmVDq?=
 =?us-ascii?Q?nRgZpDko3/DgZNEFtftPn7MY+LJ9Bh4Jw+IqPUwkHFQjBf99O7fXKRBaK9/Q?=
 =?us-ascii?Q?RzFbEtX2SK40/tpjS5PSB//BGkKrtIDLjHbMuKUINaEM29fgl/saFOPhegl8?=
 =?us-ascii?Q?VUv9nHbsvDG86hdgoUP76XJNxoPmxrtIWzYKrZySEH6zsUhT3ayc2bVgpvC/?=
 =?us-ascii?Q?KDg1BlWQ33tWdEBzg7yPjXE1ZIIfxJzDZYMeXbqOFE28y6O1eRJHJMBuZB8y?=
 =?us-ascii?Q?25bGHjodtXPI9ekiMdqVd0TQPVGLqAqyYnNpyYjZ3shlNTwfRoSTF5NCW5E4?=
 =?us-ascii?Q?3/Qf/C2sYuFbxlGIGRUSIXMDMZKt2rllU4qYYPMw96A/rpNoEmIzMnXADkQN?=
 =?us-ascii?Q?qTkuIRNSukD0mknEEG4KKdlTnhN3yTUrBFRtjjtcKzHHipAm8dqyDDPYz4TU?=
 =?us-ascii?Q?XopJSTt/+eJJMFaVtBugEtwegeGNTu6mwQaIuINNp9m3zdGRpCm1jsbWYE0U?=
 =?us-ascii?Q?m1Ke/lVY0SfvXX7WYjK63O14fOSRYNq5wMQJjacvrto94geNsQoCXTMBbcwR?=
 =?us-ascii?Q?LG/9aoWYBB2vt6mqMYSu7oWnyu0DqFJqcrNi9u2ZzubmyQU2EbiRcdnzdLBc?=
 =?us-ascii?Q?TJK3fSvuw7SCvslzAgJZKWAYI39nbubRT1W/xTRKOA5iZoCk56J2GJVp+tJd?=
 =?us-ascii?Q?tOWo7P+WFD5jBF/xVSYF15sZkcp2bUDWGBn2DQoQFun1aFF3wuzxYhf4uW6e?=
 =?us-ascii?Q?HzcwRLWq15lj5GFPQgsTiNfpBbp65k1AduJ5gGxwHaJ8iZtitrPNE9V7Sh2i?=
 =?us-ascii?Q?kgB7CcXRy+BfwxutwKMxXKNkiuD7F3YInXHh2LlGbvvH65kUGk/3jNPHvoug?=
 =?us-ascii?Q?Gzy2salqQyql/n3/GO+oasjZRseES3EIvCX6ECIVlSk92K2ZXfY+U+ZYfo+S?=
 =?us-ascii?Q?1MPWtboSl/aAQk7rC1mJj09jnXWIb3JdKwCBxjfsS5/odj0Ft30vXkkDqC4p?=
 =?us-ascii?Q?r6W7WzWWy6PA9zluKBoUF8xzfLpAJYWL3gt3pF13?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8f0d1e-a468-4595-4670-08dc6473646c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:29:54.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YI/ftgtnMDqKrG+dHGZqoX09+42q/G3e5Fm2nVxzksOaAokfliF9xT7ffMXL4nyQTWCHQtAMkbIX+fis26gGVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On 2024-04-24 12:40 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce initial tests for virtio_net driver. Focus on feature testing
> leveraging previously introduced debugfs feature filtering
> infrastructure. Add very basic ping and F_MAC feature tests.
> 
> To run this, do:
> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
> 
> Run it on a system with 2 virtio_net devices connected back-to-back
> on the hypervisor.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---

Tested-by: Benjamin Poirier <bpoirier@nvidia.com>

