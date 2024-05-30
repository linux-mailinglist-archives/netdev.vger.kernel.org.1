Return-Path: <netdev+bounces-99287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971358D449D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 06:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AC6282ED4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4814372B;
	Thu, 30 May 2024 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDoM/DPB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5642CA8
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717044400; cv=fail; b=STAl8XgUa6wtLTTixV/PsoH5GdQjqMTFEHeYtP4t/cqK4LlNeeLRW5jbSMdmbLYBynI2MiHUbi9wkhiEc1VKiAuh0sg0VoESuV60kzp6B8OxU849JB2EXBDA2jYHhX56/GpGW6Nj0/Tv5Xw8ZY6fNL64YqtXzuiezYXI2PIhi44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717044400; c=relaxed/simple;
	bh=XOQiGMpYml8G8yTM26IstSRNBjYyE6NSw/PvRTxKHck=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=HiSnXS5rdbwuuNsCfdJMG2rLLKB0BtxJcMXgqU4lmPpDS1WZo8Uqrj5yUXOB9NXbbJxtdYFKbsmfUkcOmel8m4AU4j8v2SZVau0olt7v/3qFwVIiQlN2x9QcUUd1F9QxJG5XyBng2WxkMKLVV6Z//ROAvJF8yMjZLjgjfbEurNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDoM/DPB; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhwvarjsTUK7zB3YeogCIGpZ/kmQjoVoUxhrCWzQr2sixZNFdvUwg+j8Ixxc0tDSxFCKBGqMR/TdEWIeR/rJbkvEUlAx2UKRkmzkAnOsqJ85KqDG18tOIEjgLaTtout22AepLjLpODRGPo5Z9lpb2v49jpE6aU3ocQDotW4n8D0WbSr2kxorsVaET7OMUuakQPou1DCUoEUE4FcBb7Rh0K5yb8BNhHdPEER1wDWAzgi/cSlMbj5p/t8Qw6B0nt+A9lCf0keqlVbYhHuBwXiaNuTUqWexS2PDjlHdEaH7YXtLQswBKSjMJ1pcH7SeNg0tKTD+Lh+yqp+1LMuC159XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+ZEociqPgkkGM5cgHwRM0Lu/H0fdvyedIsT3DOCkUE=;
 b=dwgkHRAVcCIyQUWXuYdaLripPkKHaRPh4XPJlVmpMLroLA5FSvDhtd9yY6rLGlyrfsmzhN2W2mkVMC8Agz3Mwo0pXknRM0vrXTb6Qze2ZmUgvVwxAik9X3bqpnq/pRW2DmAwkUEwzWasGkMmboYSouUijwT6B/7sIjH8DWsAHFp0/upnZfwzIiPP9mFFKRPM5FBDwRn2GC2elbsDuPY8QOvxOpZJSB6KP85Vw8a+O5V3OhSUiJ6u95p+hGREjwwxIHzeZItrQPQp/do1cZfUq4DvYoXpQcoC8o+ygN/wauNsOjVH9JeLPeyXK2Sye36MUsM4JoDtRf1J4VdIjq+gSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+ZEociqPgkkGM5cgHwRM0Lu/H0fdvyedIsT3DOCkUE=;
 b=RDoM/DPBFbceJ6lCGvnmNk111B+77qq0ImDwKA4xRAutmU86AYV46xAoVBQ1wZsdp0lfTLbqkmp0epNQC/mUH+uJU5+D5op2VkCemnTC7XoVoUgqayaH/ivJjRrjCpcNeyyHbKPjpVCHyej4k/rJHA2AQXpIZiHF6TU+dJVuEN1KcARqNIgxX354AXPgT+F9W9gO1vXSpD3I0qp/rB2Y7fwweSHBc6+yz8+1Fuy8/vaq89enSMjPa3/oEe3nMaJPGbmHM1o5O7k4JV/nlUUsv1ZU11aTk+CoakhHDkzOUMUMFyAKs4XTqAShjLk1veKa43viPUIvZDzzK6hXUqWh7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 04:46:36 +0000
Received: from PH0PR12MB8775.namprd12.prod.outlook.com
 ([fe80::bce1:cfa8:f5cc:dcfe]) by PH0PR12MB8775.namprd12.prod.outlook.com
 ([fe80::bce1:cfa8:f5cc:dcfe%7]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 04:46:36 +0000
References: <20240530040814.1014446-1-vadfed@meta.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri
  Pirko <jiri@resnulli.us>, Vadim  Fedorenko <vadim.fedorenko@linux.dev>,
 netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net] ethtool: init tsinfo stats if requested
Date: Wed, 29 May 2024 21:42:05 -0700
In-reply-to: <20240530040814.1014446-1-vadfed@meta.com>
Message-ID: <877cfbrjo5.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To PH0PR12MB8775.namprd12.prod.outlook.com
 (2603:10b6:510:28e::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8775:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 450937c1-e247-4c40-51bb-08dc80637c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?At1Jp7t0yeiztoz0jWwuj4CZgjWeZwAS1KchZzxT47JBzk0oeTLyD4JKWcqX?=
 =?us-ascii?Q?wmED9RAyfqKESpt7hyWhD7qDk4FEE78KZnoJ/SFsU4GkdWxwUZCH/eZqGrXT?=
 =?us-ascii?Q?/ERqoDWlQIpSNVxhvZzwV7UGon3Pg+EYlA5J2nKRZlvw8t73JhBTWQtQxN80?=
 =?us-ascii?Q?RPLzv1jGKl++pcUt2ShXpJEQY/Lpps9flKKAaTDKDMQIeI/RG2+aKN1aFeAu?=
 =?us-ascii?Q?CbGcc8ig01K4CYFLt+4UwzCzbIZVHS7Dlyoru8VMaC8DOwGrdXAdK5WNXlfW?=
 =?us-ascii?Q?offVmE8fToRuZs6Likxc6cTVrFdfZCXnhQJpJ1c7t6Pnz90bMVKUg5/Vh6kD?=
 =?us-ascii?Q?khGsO6S9EgO4CuTHauyEr+Ukb4S/rSsTkfZvlvAorYxF1Fa5Auk6vvlgnF7M?=
 =?us-ascii?Q?/OSQCREpFHG8zCBtBg2gfkGwbDDljMUOif6O9BFHRZsXdyrqvLhlS1sgdYcY?=
 =?us-ascii?Q?2xBRTcDZ1qFQRTYjtF3/rgbbP5A2xHoPj0Ooce9IN0f/sIcSvsjRTIKMJa0t?=
 =?us-ascii?Q?GcGnFtIvMtjbKbpZI581bqH83qmGkDfanpPU/Pb1xCVlya+JbNiZFz5/XhU/?=
 =?us-ascii?Q?MFQOQ+4T6p7wzPTs8sCUk3IOf12NXzxjTakk4alWsjWn1opfXq8NGe8t3ahg?=
 =?us-ascii?Q?gIqGSN+xK2YUquvFGss3x/kp8zfOT813xQSlak70dJYbzm2hQLrGFKcMSA99?=
 =?us-ascii?Q?5/atqalfBebd/Pcd2bzg79O3Kdu2vLxemkqH6Fmdh/167ezop4Ovo64dIumA?=
 =?us-ascii?Q?ho0Rf+QqrlEa3ZO2MbcY8hZwfxGDLk8+FQsuK8EX3Sg/AF/j04uyA/RcoDIX?=
 =?us-ascii?Q?Ix5qUYvbDmyxps47JgYya7HrDEOvt+VD357NPlPAVakJT/+T3oeV+OQSW4vt?=
 =?us-ascii?Q?b8oHllq40xyZw7thnGXGM7rKTr0FfNRyV7xpRax9k3EBcxtJZ+YG5FeWRftC?=
 =?us-ascii?Q?tFf/cOjfGK8ZDBmETi97xATG1UGh53CckIxWZ/3VTv8R0LJNdG64w8vBCi1+?=
 =?us-ascii?Q?ebQj8JYkRGYjkZKWH/KCfQAURjvqmzi8RNlSTuB5Mz5yRqptPosN8YdJN+VD?=
 =?us-ascii?Q?RC7oOHvsjXhy6xu2j6HtH5YSSkeGrwxGT6u1uzmVksHw/F3fGfAZL3XLCDEs?=
 =?us-ascii?Q?Un0ziVE6ZvOmp6yp0+ViSFA4cyACjtmttKHJDZp6sk5KpzCpmYQ8keoZV9VW?=
 =?us-ascii?Q?k7C8mpgPkiUUirh3WoOc8onQe79BenBkX6UNp/B8cE6qM0pRkvLYQOlxBHVw?=
 =?us-ascii?Q?MbgTDP7Cs8yFCGZXWCZCdhALivDagYhfjLIpUqcRPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfZWmjmD4pbBfghBoUEaRnye/0WG55J8fKwTn9omR7icvb5ObHPCIQkexe0f?=
 =?us-ascii?Q?+un2rVzGKlh9zUKLiMjGR0YDOlm3nx7O9YGUdCkIafnoDpt4d4E872oz3omZ?=
 =?us-ascii?Q?tv34B+WMK86XxPTRsOqcSdmjZgdBBE0KmIrGfoNs3QHEthfwcjlTcrUe7eeu?=
 =?us-ascii?Q?82qwfeUfP0i9LquuM0PuEL2eN3zUTGwFqdSbamhXz4FWd0zAdewpqt4bGaGV?=
 =?us-ascii?Q?w11e5N3Nyn80fW04zKaoy8UY41rPMy5CPvg5bVCPreV6cZ81qBHeWiO3jTS+?=
 =?us-ascii?Q?QPJuZDt/T54eHaCduv5qRDKrcgKKXC8aESl8iEa6zP5v6XpUE4WpHpOQg+zE?=
 =?us-ascii?Q?bqjEGZ+1ri9tI8u1jfv8kAURPZghZtVZCF0nYf2bvddEXrHrR9RSqeuYYBXJ?=
 =?us-ascii?Q?J2u+WIEhQrG4C3qzqDOul9/mWHiqffQ0TdCXmN14cZm079ozdUArcywU2gTo?=
 =?us-ascii?Q?EF9lMv/PxC3M1B73ApAT8Q7O3z9/HMMTJJNzybWi3Y0rdmWNe+lKwxXYuPbU?=
 =?us-ascii?Q?GmaVCCQBZfDEtuDZZ8v4fcerPnjEjexFXlxsNLhfaQBrWmil1addunkQfgzk?=
 =?us-ascii?Q?3bP5JzKE5B9faGMm8DzbGOJ3r7EWK53Jb9+5UVio7eBNTyKTBOAZcnzvdsq4?=
 =?us-ascii?Q?Szb1yiw36dP3oGuYkVcuhJdJz2+UpCu+nekUpa9f22aOxSvDKX137Q9LnRoX?=
 =?us-ascii?Q?t+/wMLOsYz6wzh+PaYODNZJn14WNLk/8HN15YKeRh5J3hYm3TLgOsCQjMrMn?=
 =?us-ascii?Q?siV2sHX6SrC38LhpezSHyIKRGcMQRtPP2Gw11bqTmj//emkTfCmvskK3n9Xa?=
 =?us-ascii?Q?kA2pl3qY7BvcLGXOfLY9UoFsTZ5PhcmNGqMdHoats8h1pafoegUYxqAVDt6w?=
 =?us-ascii?Q?E7o589p/zIjFMX1le9uMnfCPj/4mUXJLN15TEptK06wHu6iQ5s7cWorFeO5x?=
 =?us-ascii?Q?/6CeGTVJNrnHkRSLUBs7r9bbQC0946IjZ4yJzA5L5i4wL0KuZxyncsET0WvB?=
 =?us-ascii?Q?ug/JM36OXQiCy/3zlsHsehDJsInDCZq9nx8pHzEZdT3N2HkA9zIN98U6w4Iy?=
 =?us-ascii?Q?8gJYmuyUK8PDaY/YApyOZSfz74grg1VusCgxzK6uosl6K9L4LEOoaIgwM2uU?=
 =?us-ascii?Q?dEYCCc6V8vQPcSvAbRgesYCiZxXZgEPnhVKpPXHbLwYTeHxajU86GMEHHHHT?=
 =?us-ascii?Q?1PXOmmKQBahZm0ksVrpKFm+MzyI9+eUEr6qzXSFXoCCjqsgsvfLK6tbXfWIj?=
 =?us-ascii?Q?uNRck/XiyO7YEdqE5qqUs9V6tdbTI3fp2nwhFW4wGiUxK+NYsImb0Sf2DObr?=
 =?us-ascii?Q?kBlYSLeISKqWMw6q8+DyeHIISGHAw72KE3anlxxIq4qQScUFyxItIz4sPU9M?=
 =?us-ascii?Q?pKvWq+6EGQEV7w/dw9WU6kInTCVJPutNK9F9JvUU5Edad6h6+OBjEp0jjHmx?=
 =?us-ascii?Q?sWxPrhbLOCSaSzHVAfCtjW+cs22ee1kr+fThZjG2h26KYv5xT7r+13cCBmLT?=
 =?us-ascii?Q?LelfZgJrexZHXujqHG2rINCIPjfWbbnZq4msj9F1xMF71Ns9Eq7bTL3wrAgL?=
 =?us-ascii?Q?O0MDCAMNfq9KW4Yp71yal2/++ZUm53usnw+/oYDmbzAD2k2J7QaMhpAaGo8u?=
 =?us-ascii?Q?pgFVCagK38uC91Hjaq4h9bor+QsQFeF+aQtzLzEq69Y+CUB2zWYPrgmlbw0V?=
 =?us-ascii?Q?5BAwSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450937c1-e247-4c40-51bb-08dc80637c82
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 04:46:35.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jx9ntKOWENGKysIc/Q4KPaWVTnDvtojpVbbD6w+EJol4qukoR9ppf3C9/WLB5As+NEXCw21P3x4yIt+x0nVPVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

On Wed, 29 May, 2024 21:08:14 -0700 Vadim Fedorenko <vadfed@meta.com> wrote:
> Statistic values should be set to ETHTOOL_STAT_NOT_SET even if the
> device doesn't support statistics. Otherwise zeros will be returned as
> if they are proper values:
>
> host# ethtool -I -T lo
> Time stamping parameters for lo:
> Capabilities:
> 	software-transmit
> 	software-receive
> 	software-system-clock
> PTP Hardware Clock: none
> Hardware Transmit Timestamp Modes: none
> Hardware Receive Filter Modes: none
> Statistics:
>   tx_pkts: 0
>   tx_lost: 0
>   tx_err: 0
>
> Fixes: 0e9c127729be ("ethtool: add interface to read Tx hardware timestamping statistics")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  net/ethtool/tsinfo.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index be2755c8d8fd..57d496287e52 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -38,11 +38,11 @@ static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
>  	ret = ethnl_ops_begin(dev);
>  	if (ret < 0)
>  		return ret;
> -	if (req_base->flags & ETHTOOL_FLAG_STATS &&
> -	    dev->ethtool_ops->get_ts_stats) {
> +	if (req_base->flags & ETHTOOL_FLAG_STATS) {
>  		ethtool_stats_init((u64 *)&data->stats,
>  				   sizeof(data->stats) / sizeof(u64));
> -		dev->ethtool_ops->get_ts_stats(dev, &data->stats);
> +		if (dev->ethtool_ops->get_ts_stats)
> +			dev->ethtool_ops->get_ts_stats(dev, &data->stats);
>  	}
>  	ret = __ethtool_get_ts_info(dev, &data->ts_info);
>  	ethnl_ops_complete(dev);

Thanks for this catch! I agree with the change. If stats are requested
and the device does not support the statistics, the initial values need
to be set to illustrate the device does not support advertising
statistics. I think the patch should target "ethtool" instead of "net".
Also added Michal, the ethtool maintainer.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

