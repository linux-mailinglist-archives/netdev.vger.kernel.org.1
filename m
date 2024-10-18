Return-Path: <netdev+bounces-136847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC849A3397
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3308E284156
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334915C138;
	Fri, 18 Oct 2024 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJScU/wh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376920E31C
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729224506; cv=fail; b=hyucrJo0wq2pmMpGnPxxcILs9yj22ObIuefLL9gAjwXrRjmkpBi4Qb34R8D1Q8KI3WdxI6xDg063EaUAKjUcOPhlIkGxnbV6bf30lkeuqjX0FwOT66eUZGT2Jbr6hhXA0wD55MJyYLOiva47ypzvdRGe3yJ89BUwU8rNyxaiyK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729224506; c=relaxed/simple;
	bh=Vwc+O+2ocOq2XtbpjS7cF1qhI5lBozGpdqx4NFCw87E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=L+jlC6tb9lGoopnLgGLbNOmn3B9FfK2UAZZezhzB77zGYxEJVUR3XsqM88VG6LI8eYRygStabn3nBr7iExUS9kHXlCu5YUNi4v85TVSouQVAFJa7zZOtfnpsozG65Vwq9qug672u6LJ9Yw83Lvu40TuumbKBju5im0Q7l87+fz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJScU/wh; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHD9GeWiMevKE3EsnhZcYEb+TSRTC3TIPQNL55VsQwEKuG3NkBeGFFnWjhoK64Cvjyr3K7eAmklhQRVuVEczjAYkQ9mmJirbdXXzMlX8AvJE0cMlow2p29GJsahuVRMp/WUrfmAFeX0rF93SuCadV9d7GT79UmxMAmRw31K9D4pqJg2mpwR4SoiE5yzTFJbE38Hc0BlPccUWWDDWeD5EnbxQRUK8hUhDcu9JXZTVafjr576V/r2uEzR36fYyI5w0fqX10hdvz/1G85H5i0Ci+NnCvWDJYC60zdI5BlXFUBR1LAqQAul4xu+El6y0eAss1mqse/BVDX3JtJnUQi0IPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKTvJC563otxJ7Uz/JmJuov4OzWeSNSO/8y++xYIlug=;
 b=NvSNCC1NLEDxP465PZShHQVSjv/lVqxGOUKEgFY/D8BFeuNguNsmnmvwk5z8XzIXl0eB9xta5nb0C88/3DHRjeF6Mj4j0FIm+LWvU0Kti8L5P/yKcXJKYcAqSfTCghYth+dC1UAtN8yjvx8NevmDSvUvT6XmIGcyX/eaFSi6sWvExOElCsGDKiYw1f5P8Iju6PSv87sPQKCIZ+y1QPFwh+L4lxqJY1A2er0O1UtA/qWipQ6X+APfFUoSbv8LPpNn+Hkdp30PUcKiWyiAvkXoPQN6G+uOsRRtUeGcXB+Dqd6F4tAMkHcXN0QMePSrowdTf3pPKWgWwtrsTHWAhb4tcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKTvJC563otxJ7Uz/JmJuov4OzWeSNSO/8y++xYIlug=;
 b=EJScU/wha5lF+9pogJssZLH8KfXJKIYLx2QygnXewU9aLEyCGbfMjy6v6H5rPk9wmQlopBBU7qzoglV7s9qJyNbOT+oSFCUs7S+k8Jc22mXKLXwRXyCx70PVytBrafMHXeuo4b/t1peiwrK3CJO8JeV+pHcyS2WGuv3ryONAex+tkk4Fux20wRJdipMqT8qxUeGT4zsvBAlzL3DxDqjB2LkEQHqkJSeG8yxqTX1gir7mxFJqPAnYF6HizC75mqRLX1rm8D8eURVbSf3GvIFzgfnCJYswIUTngG/ZaWF9VAedoh+zOw6jBnr67QIEzF9vcwYPh2qdKpcxAWUAQctrwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 04:08:22 +0000
Received: from IA0PR12MB7601.namprd12.prod.outlook.com
 ([fe80::ee63:9a89:580d:7f0b]) by IA0PR12MB7601.namprd12.prod.outlook.com
 ([fe80::ee63:9a89:580d:7f0b%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 04:08:21 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,
  Tariq Toukan <tariqt@nvidia.com>,  "David S. Miller"
 <davem@davemloft.net>,  Vadim Fedorenko <vadim.fedorenko@linux.dev>,
  Jakub Kicinski <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>,
  <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] mlx5_en: use read sequence for gettimex64
In-Reply-To: <20241014170103.2473580-1-vadfed@meta.com> (Vadim Fedorenko's
	message of "Mon, 14 Oct 2024 10:01:03 -0700")
References: <20241014170103.2473580-1-vadfed@meta.com>
Date: Thu, 17 Oct 2024 21:08:17 -0700
Message-ID: <87wmi6njda.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::31) To IA0PR12MB7601.namprd12.prod.outlook.com
 (2603:10b6:208:43b::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7601:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 574cd7de-197b-49a5-82bd-08dcef2a814e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0jcKlHNkeldwfjs2aDoaB2GECFbgElruimDof8sptZFuQ6IoVuHfYnrSXbXe?=
 =?us-ascii?Q?Hute/JzBe/qRNH8ZTaNhyqNR19od3Drrg6GxsmZ6iG9juCIMrmd4h8Z0/qRF?=
 =?us-ascii?Q?8sz9CCWd94vO4C37xUOiKERJW0dtez7erV820Zw+9kZW7bg+hOKxe2umMZ+D?=
 =?us-ascii?Q?Vu+h82pZ0FCmvur5f756zduRNYvdVy4Nlgfi4k+39mLiIPpmFpFd7Ng6dtnG?=
 =?us-ascii?Q?UnwDkYcMZjYbhXj9v4MDnDx3vqIwNPxrMc+D9aO0WD9oWSUIUtafeSq4t/Ov?=
 =?us-ascii?Q?IATpGagW93t/gvi002pCsSK4oed5icF1TAuVQm0hb9v8F2JRmDWR6xTlHsd5?=
 =?us-ascii?Q?+rf8l6x3jG4Yk0rvuRLKe5rHzcXm2Lf5aHEYFjTAWNFj5u5yAt/bZSxomrX0?=
 =?us-ascii?Q?8z+lLFj6fAwdmMTC5G1uk5zKfYkQD/RQ5Mtr6Md2AIhiBG4qVSoeA5zpZogc?=
 =?us-ascii?Q?lq+vbOtzeCHu5jf7XshqdwkoTaQUrvIRF+D3SRd7mOjeyRwI+wzRY5uyCMaG?=
 =?us-ascii?Q?pBRBMLLE8saxVHpo5ZL4vsJl2XtMUThHgFNptt2LXGYIwtB6p1FiE0H5Q10j?=
 =?us-ascii?Q?DtAjkGi4ztG/76KESl0C7+d890BX4ki3wQu0qDhQbeeTAMp2PXhK2YEd8CCD?=
 =?us-ascii?Q?V8ZiUVYKzpcksdI6kE859nQTKap6SDyqJD3xmdJwz0wX5j/NWnFsy6k11KLP?=
 =?us-ascii?Q?wDlaXUxD1ul4s6VwtAYeGPHinRwrFNeyNWak5+LRHf8xUSerLbEz0AMt22uz?=
 =?us-ascii?Q?TAwWAPsbYc3Z7+PNbqjM220Lkbx6hx7LPj+BKFej5vfhNq30MO7hnu7HMH+Z?=
 =?us-ascii?Q?K00LP6b8Yfkkl7SbHTFdIkKGTeaCrH++Rzon3BXPCO+I3ZjxpTNgaWQVdLiK?=
 =?us-ascii?Q?6FnmBk7USZnCBzPdOgKrNscwI/Ep8e1ZccQYFvz0BuDk4yV6r1JB0gsEcv0s?=
 =?us-ascii?Q?evjpfObqerbhKKciZDdHpcFdaR1jlJ82DGfpEuGb75mpo+kBQiwyzBpB+nbE?=
 =?us-ascii?Q?PE3Q+Go1uD5kTuGeRiMjMgiXL6FB2UJ6k7uJB93+ewdF5YkIS5GCsJcV1GS9?=
 =?us-ascii?Q?4sItCA6BfLFLni/raGBIAP9BxAXnZRCKKQPLys9PGau2aVwAjcgpxZvqccfl?=
 =?us-ascii?Q?Qy5LfEtWt/KfTAWTirBmN6KMWEN7pfjED2d01td673aVK5+hUX1bAqUfnG2I?=
 =?us-ascii?Q?nT+odHY5RcGKI31SsR0uNnyO8PLhYbb0y/bEGkPgENER8231fqqQvLGRIslN?=
 =?us-ascii?Q?y8u46oc0L7NBaV1pUwLQ9zrOz/ri+LuXGzEvE6TkEpW5u9vUH5z+DSsAYEvv?=
 =?us-ascii?Q?uyqzJfAQLIyx4aITIWB/JknM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tZObS/B+cWqMvJdO+NDwQyv+jrqo1tbHYZO3AHor2cgWLRAHkiEdjUNGyK5l?=
 =?us-ascii?Q?RstIkpGDVMKVhzH9L5sK1GUJxIApcHs3MmORr4GuOm2fx3QOt1zSOWLPjsWS?=
 =?us-ascii?Q?1vgDa594TpXsRsbxxBHKpyqUMfHwAhlyUgpTMvMtvWDu6BuFvMWW9XsTyIZg?=
 =?us-ascii?Q?apn2GWnIBTr2egkB9QQ99X8sNj+GJijHzK3mbkLmaoUw0+Z6get++yVoHCgW?=
 =?us-ascii?Q?n8JTY+ZDIyZZDbksQQew4AjESDRrj+N8VsuyloI0IrWR3gFRCIpftWlviG5Q?=
 =?us-ascii?Q?4fRIKJHuNhd8wnrNO7u8N1hH1HdnEJs+xNuXR82y2QVheZ4m3gWVeK/v1aH9?=
 =?us-ascii?Q?5uBHRVsy6C68m6sfQW8bW97N9o/GXCGZdfsPRoJQcyAuGvUCqBoznda+JxNh?=
 =?us-ascii?Q?AIhqLfI3klSVVt1xhMi9sN1rdcD3YB4E0k+m9PjOc+f82LqM4mgna5YrKG75?=
 =?us-ascii?Q?2HSB/Xwuu4v8ks7CYYLncHhAUTIvUXRbsByRVdnGWTXF5D5VQi9zejvZeL3D?=
 =?us-ascii?Q?n3T+HGHcyg5BaDo7DT+PVdA+aZewvv/VDJRaBk4wuha3AimZ0z05wNzYu6Ql?=
 =?us-ascii?Q?/28wz6NRd1cind01avQYPhyxj6BCGfQpPVmxwJGqockcTOY2bUkvva0NOwdF?=
 =?us-ascii?Q?gviSEkhitKrFMZuB4wLolu7li40KiIeGZR5/QVluJ3imMfIJtq5jwCPFdvKO?=
 =?us-ascii?Q?nsnXqDjj7Mi+gpJgd8BhYoi/lWFTEhN1Rfmgs9hKbfraEjM0tguvTmaUksdk?=
 =?us-ascii?Q?ghIiScDjHKR46CXutp4E4dcNcDfOm1aXpLTW7f1ZW17WF6xVfmAL8Rv0+aFy?=
 =?us-ascii?Q?yaGeXLuIjBvnEfVgR4z1nSmNYop3SYEIGwo0SVTpRS+p9WKSFfI+x2ilfMgp?=
 =?us-ascii?Q?ocpu3TyRiVHo3uuSw11c+2XY7LmPMz6Vd+a0VL0I+ZbVs5aHGI+9LmX9Hywm?=
 =?us-ascii?Q?YboKVA/yI8gGC20VsVO80PjMilxFnlR1K8IqEZ4vWuQUbKvU/lTJMPsgsaGB?=
 =?us-ascii?Q?5Eqr1qUGTw68FtB2+zqs+e8YTpYXduiRhppTOU09ZvoEqcwxpoSRCWT4+7Tg?=
 =?us-ascii?Q?iWOQj1bR1gP9yG+cBqNFyHb8mFTwT72mYsr6Kzv3RsLYHQ3TrXPljZC0LnR4?=
 =?us-ascii?Q?0kDLrBEY0a3rT77S62K5vSO8M9NaP6V0CVZwwPh1fxTtNrifq7lKRhU6hy4X?=
 =?us-ascii?Q?Qk3AkdKltg5fG+pnSi4hha+RlY+0voTP/poi/yvpusTk9gd8uPGGkwHKJtjo?=
 =?us-ascii?Q?qHVqqVJdc8fOK3wlcHGN0RBT+4WhBqIvz9bR1NfFaIWQZsKYsCYAedl8rpDl?=
 =?us-ascii?Q?7vcXT2q5YcTNl6lMjdGgOGoYevvbjvL6HnC6b6mpMcwt9j6+FXyulcTQSwac?=
 =?us-ascii?Q?qbjm5BqZgCileepVHwgbDngWGbqlBXVCRWkSAnVeevxLPdItk5ZSAydGE2gy?=
 =?us-ascii?Q?gvYsgYpyVdpCE1nwxko0699XDVDkyCqxvJlNC6E77CXacRiSt9gm9hqDiU4Y?=
 =?us-ascii?Q?ZUzhfesbqxKW2tDTSj5rQ+ACmMTQNunjIXvZoFnXIa4OHiiYnP3A8YRVQc+Z?=
 =?us-ascii?Q?GT9XyooNEraxgIyvXYpaNXt7DaHkFvGb2MbygvaL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574cd7de-197b-49a5-82bd-08dcef2a814e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:08:21.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icxbdAV3rfkXkQR+kurVdrGZzymVwJW1VvvCL3+ESNshiMqoYWPtyhYTQYiJws88TcPQsjph3/pdFZFMjTzajQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

On Mon, 14 Oct, 2024 10:01:03 -0700 Vadim Fedorenko <vadfed@meta.com> wrote:
> The gettimex64() doesn't modify values in timecounter, that's why there
> is no need to update sequence counter. Reduce the contention on sequence
> lock for multi-thread PHC reading use-case.
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index b306ae79bf97..4822d01123b4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -402,9 +402,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
>  			     struct ptp_system_timestamp *sts)
>  {
>  	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
> -	struct mlx5_timer *timer = &clock->timer;
>  	struct mlx5_core_dev *mdev;
> -	unsigned long flags;
>  	u64 cycles, ns;
>  
>  	mdev = container_of(clock, struct mlx5_core_dev, clock);
> @@ -413,10 +411,8 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
>  		goto out;
>  	}
>  
> -	write_seqlock_irqsave(&clock->lock, flags);
>  	cycles = mlx5_read_time(mdev, sts, false);
> -	ns = timecounter_cyc2time(&timer->tc, cycles);
> -	write_sequnlock_irqrestore(&clock->lock, flags);
> +	ns = mlx5_timecounter_cyc2time(clock, cycles);
>  	*ts = ns_to_timespec64(ns);
>  out:
>  	return 0;

The patch seems like a good cleanup to me. Like Vadim mentioned, we
should not need to update the timecounter since this simply a read
operation.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

