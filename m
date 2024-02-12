Return-Path: <netdev+bounces-70854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B238850CE4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821F51F242ED
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 02:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92D186A;
	Mon, 12 Feb 2024 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewZxYCMx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49A1848
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707704573; cv=fail; b=Tov7r2DDFtKcEVFkLsCJ72a9cid7LCcIhYixuOPHG1nSqA0FCcw42ytHV77A6LV66rjwlKZM1LGTKyxRxDw1mTm5HXQh/PNJim+lPwQtfbCcnMFoghawjroIRVs4a/+CXdlefTuMNMf04y2RraJFvN6mzswzarNLM8uxpniEPig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707704573; c=relaxed/simple;
	bh=nJ/bVX8ZyZ2D44xw6TWjJi/Tf+9/TVh5aimCXkcIbDc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iYpexugIgck40haj1YUkmK+p50S+5Sj3Ml2/uq7PtUAMjEjPJN7T86iCh/JiFvIsSBhnnIfpMnKDF/t6cM1oBY4C/RT8eJ9gYomzrD/FEpxehq8ONXLNYxTO6kGbBGYEXhVgg2GW3aw2SxuWSJOwtKaP2CO9Oy8mXvCCPQFSUV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewZxYCMx; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707704570; x=1739240570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nJ/bVX8ZyZ2D44xw6TWjJi/Tf+9/TVh5aimCXkcIbDc=;
  b=ewZxYCMxbaNtPl/UDvcII5xpsZtYEZ76y7lZugz9Z/uL8Qjn7XgdDPtD
   OvvE+BX6XiC7VviCC3+aAsUfFNlRVonTgY+ep8RFBAvNTq5OREIWPRf0U
   AwqGYejw1J8gIJJBXAtFh4u8ZvX8QsrVnNP9rda6zmcgHnj61AfE9guMR
   rGQgh5dOJuhZSug6hfPkoZCSNoS7Mn17YRkh3zh8QfeM3cmb70ikh8Sxg
   6Vjt3xyi2N6YoaN10obzUNWxHVRbgpYP27Vq+mokptzmbk2ykmHqm4iL7
   /zgGCws9F1XGtIAnLiX1bI5Ai4yjyOtMhW/pEme5gWii3+Mp2iFK8Tcfy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12228476"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="12228476"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 18:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="7104950"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2024 18:22:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 11 Feb 2024 18:22:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 11 Feb 2024 18:22:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 11 Feb 2024 18:22:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQtThrK6dNlxURTDKxkiPXUR8jLSo/UCx3Stt/Gtaw2EY+bpqJ5yyAZKoPFAoU/CqqIwhDaJFteMJ7apfza6be93jk8TK7zx7SXcDZ5q88Mo2JXeipUSVlUmQRwfzTH9Kmq0ailho1cSnTHAAL84MCmrPkqLg09Zz01JjbPhpoN7uVKMPgK/FYGZMwdW88NkJZq/Cj5+xBEZlaJ14zcZENMq2rtiNxIY9PT7hLkqnnSm/jwXBOh0tXIsdDfrYGDLAKAYmJ4+vj2YpEns8D0CvpyPGI1xjmPB7C7UaF50C02lcI0gD9l3O5y+sf2YqSEMWYtfv4KVduUevI+3AHbseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN+R5+O+X+KtHwRdPPjMAnoCEr/WDIFAuIoJx5bg5oM=;
 b=fgZ7kubR7LPCzNOkY8xkS1zjHx7kDmZry9v1bYuuUKY4CZ1oXzd1/+bOhDGuK3vivxcihXzZElGWpdD/NN+LOC09X5rJLaOnExRBSiQwioEEyoN1rGEhxmLBZ+voKrl6+3k7h/aGP7FvbyUYadXJVp3e32oGLgXJBHal+A3US62DpenBVC1uzkCEGLfbg9rWdXEOsQkRpog8YJtAnp+E4a6rUq6BGsdu3kFu3Kl1kLlswepfjxGmnzhmSx6vmthdYyQPMfQEzY8S0ZJf8V2nIV4nDlMNE92IfsjqQAh0lCIsC9cCcYhmXITmdOc1ekpccgg6gg6K14BhIsOB6KJPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5376.namprd11.prod.outlook.com (2603:10b6:5:397::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 02:22:45 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 02:22:45 +0000
Date: Mon, 12 Feb 2024 10:17:33 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>, Pavel Begunkov
	<asml.silence@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/3] af_unix: Remove io_uring code for GC.
Message-ID: <Zcl/vQnHoKhZ7m0+@xpf.sh.intel.com>
References: <20240129190435.57228-1-kuniyu@amazon.com>
 <20240129190435.57228-3-kuniyu@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240129190435.57228-3-kuniyu@amazon.com>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 83408085-bbe5-4650-e698-08dc2b717f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9erGJV71tJ0lbBWI6joOVxJkUBnj+gi/5MVfBVrqA4MsM4ue4QAvs8mlqAsvL45eM4oysm3iznQTvXlSE3zeofrnSIGm4mVg08usEdDUcx7DxEN/JMiO8xSVRCu6fK8+8VuGJshM3zmRUCfZJ5UKxumm1DF4qCa/noK4uG8TWw5cTXlFDMmuYBUqh3kz/kiPDn8hJKtKsdHVxYuvAwDwKJsv13UdJxOb1m96jtW0nYKfJU+6eht6ZpYiwkHcESqmh/TvtSiEFQl6s/h/gzqW5Na6fJptZK0Tc353bxzwSQF+17ZoxFLk96RSEEuyP7ZPBK7ibcrDqTn/DQoOb0IJ85sDGfRluTL3zKXwotsoomSEIfK0U9C7IoVW+BhGpcAw6Y9ZoGTOOdg2WHid1dLmbhtDGWUGBLraz6ON/RSjctJn2QRQT4zbq12eCmhDAG/Y2a4BgKN1hDAgFXvkcjj3Si8PQNv2aJUYqUPbKrfo3Mtlb8BUht33vWVREtKz6IxPsMLHJIXWrRg3Oz/YQHp3LtcYbCH+08uDf+X83T+fmGkUbFV68fccGS9XpTpb5bTCqMOKAflque0MGQGywPi+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(41300700001)(45080400002)(26005)(38100700002)(82960400001)(66556008)(966005)(53546011)(6512007)(66476007)(6506007)(6666004)(478600001)(54906003)(316002)(6486002)(83380400001)(4326008)(66946007)(8936002)(8676002)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eMmZwRSIz/YPLsDIX49xIQ9BAHxeeLAxyR58RnQHhi2xeSEG3H0WlUPkKSPa?=
 =?us-ascii?Q?ZEEFMYar7uJC6Om8iqDZwSCMjbv+LD6vPB7/e30G63MnluBimb4YRxUaiTmq?=
 =?us-ascii?Q?Q9U5DZYVu/CSShouGK+z+Byoa1vfNQfc1DkoYuPwKkhKGzyyjEARGKIRkrDp?=
 =?us-ascii?Q?5QY0uo9e2pG9IHqcSMzDEvsTg2jrogqvF7iMqx1FsnCcU3K/aYhrSHKveNIh?=
 =?us-ascii?Q?++uYyUNQdmMY7MDgoXv8t6vN3UCyNHpF3HLeMoUUJLhUq8cnpvrl4tiXLKz7?=
 =?us-ascii?Q?vd84DmUpVVF32YQH36+CAvfAgYPuJptENFvy2BHuZIi25JxgYL2QNpKwqors?=
 =?us-ascii?Q?8mHJzGclJsIP2CqDXcNCaNcorC1+917xcqBr4fCQrjeAXxcQszzLLyFB8PGS?=
 =?us-ascii?Q?wmzWQ+YbioOSMhC2+wsccbuSr8g2HNLw2w+IqiT34lMMkovhCyFeReKfJxBI?=
 =?us-ascii?Q?f4GRkt8sxpoUmspXYD6FHMSU8z1uaHIHogsiIme/z7aIE0Tbh9CxK+FaViP2?=
 =?us-ascii?Q?tqQslTtOidrPA2JUj+IOwMLMtFBsWYb6gFveFWpxs6llUZJiajFe/Z653jjJ?=
 =?us-ascii?Q?C3gOQM99sdtkikog0KZuBjxt8W+okgxTPxJr+OPvmnMaQgCxB9ss5D5kGLs7?=
 =?us-ascii?Q?7KRYqNRxLYnMvEzcmaMjbP/DIMcVK6YAGlImPYDIWt/wANix81mzotVKIt8G?=
 =?us-ascii?Q?yHKMssleKkn9D9uqOqkcx7kyDnDKpiZBc6wC6UmEdfX5rqDO0t6QeIQieLNR?=
 =?us-ascii?Q?krzmrp617GdQcZytuJTRF3AFrqqTdNzSn1m3D2WRLygK7r1pFAMQQNbc6nIx?=
 =?us-ascii?Q?sK6nR6gPh4LooUocscQgGiNyO5kQm0r0lY9l+X+kHVK2F3jFyVJyQuLiMHHW?=
 =?us-ascii?Q?9Aue1ldA8fdajyst4SjN30WXb+3HucXdAjXq1W+kCA2x+pu6RJOiuXg5Dlp5?=
 =?us-ascii?Q?dtJAMCbAG7bXYsFZbDPHZZjbg6+nyMaxCrQ0gdIEi/YYje/Yb5xuFCUYkJaT?=
 =?us-ascii?Q?D1XpCSIEIDzA0otd1cgXlS5n6gMGmPSSg3Bg/9/zk9nhBkdzcgF4iXpdEn9H?=
 =?us-ascii?Q?/uDKk3ygQGfeR0vzWVDYoyfxrwfJECRlTWgAN9EGwjzaCz4N/e/BF8rx3YlS?=
 =?us-ascii?Q?KaznOsogTmBwu9tip/tNTDdj4UJmF1okBFoO6eBauPRd3iGMkptlnx0B8RT3?=
 =?us-ascii?Q?cuYKxoCxK97S6re9AA0y2pZRjlqFviAZTm5dagCC8q6RCMVXMJr4kdKtdnUa?=
 =?us-ascii?Q?GxSaOZXL7ojqNTJoZNUY8Hbxnfy2LFunM+TwUbX7BMS10dFsVnjeOsJ8MUvH?=
 =?us-ascii?Q?DIvIsrCYMfdzsNOTzo4KVYCVgP5T65ewCTPxyvPJu3dDAMRsjvQMcNGm+e7b?=
 =?us-ascii?Q?o0GUl52a/ZWLC9l9HXXUYi3bCEMeQXzjQoXvy8y3w+dMbfuA1ADh1hhSuObt?=
 =?us-ascii?Q?nNKuXNeEBrTcrIwgZJwx1gXymjqlV39u8SXu/Q4RzBeltSrAbXtqL1QzJaxH?=
 =?us-ascii?Q?LnC36nm9l7B7gAIQPUIWIXFtbCqiU6RU1F28IRupP9go6+mQ7EFywbjapKpI?=
 =?us-ascii?Q?qULuR9Ol44kKvbCh4oup5MLMj4de+ZRcvezsDaiX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83408085-bbe5-4650-e698-08dc2b717f94
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 02:22:45.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn9zySylLcN/aU+3g+gzeXxN17h6Th/us2Oogm8OTpJvcYbsZpcBMdtCXvtXZmZ05d1rDOQwwsCqqlrZtO+9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5376
X-OriginatorOrg: intel.com

Hi,

On 2024-01-29 at 11:04:34 -0800, Kuniyuki Iwashima wrote:
> Since commit 705318a99a13 ("io_uring/af_unix: disable sending
> io_uring over sockets"), io_uring's unix socket cannot be passed
> via SCM_RIGHTS, so it does not contribute to cyclic reference and
> no longer be candidate for garbage collection.
> 
> Also, commit 6e5e6d274956 ("io_uring: drop any code related to
> SCM_RIGHTS") cleaned up SCM_RIGHTS code in io_uring.
> 
> Let's do it in AF_UNIX as well by reverting commit 0091bfc81741
> ("io_uring/af_unix: defer registered files gc to io_uring release")
> and commit 10369080454d ("net: reclaim skb->scm_io_uring bit").
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h |  1 -
>  net/unix/garbage.c    | 25 ++-----------------------
>  net/unix/scm.c        |  6 ------
>  3 files changed, 2 insertions(+), 30 deletions(-)
> 
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index f045bbd9017d..9e39b2ec4524 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -20,7 +20,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
>  void unix_inflight(struct user_struct *user, struct file *fp);
>  void unix_notinflight(struct user_struct *user, struct file *fp);
>  void unix_destruct_scm(struct sk_buff *skb);
> -void io_uring_destruct_scm(struct sk_buff *skb);
>  void unix_gc(void);
>  void wait_for_unix_gc(struct scm_fp_list *fpl);
>  struct sock *unix_peer_get(struct sock *sk);
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index af676bb8fb67..ce5b5f87b16e 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -184,12 +184,10 @@ static bool gc_in_progress;
>  
>  static void __unix_gc(struct work_struct *work)
>  {
> -	struct sk_buff *next_skb, *skb;
> -	struct unix_sock *u;
> -	struct unix_sock *next;
>  	struct sk_buff_head hitlist;
> -	struct list_head cursor;
> +	struct unix_sock *u, *next;
>  	LIST_HEAD(not_cycle_list);
> +	struct list_head cursor;
>  
>  	spin_lock(&unix_gc_lock);
>  
> @@ -269,30 +267,11 @@ static void __unix_gc(struct work_struct *work)
>  
>  	spin_unlock(&unix_gc_lock);
>  
> -	/* We need io_uring to clean its registered files, ignore all io_uring
> -	 * originated skbs. It's fine as io_uring doesn't keep references to
> -	 * other io_uring instances and so killing all other files in the cycle
> -	 * will put all io_uring references forcing it to go through normal
> -	 * release.path eventually putting registered files.
> -	 */
> -	skb_queue_walk_safe(&hitlist, skb, next_skb) {
> -		if (skb->destructor == io_uring_destruct_scm) {
> -			__skb_unlink(skb, &hitlist);
> -			skb_queue_tail(&skb->sk->sk_receive_queue, skb);
> -		}
> -	}
> -
>  	/* Here we are. Hitlist is filled. Die. */
>  	__skb_queue_purge(&hitlist);
>  
>  	spin_lock(&unix_gc_lock);
>  
> -	/* There could be io_uring registered files, just push them back to
> -	 * the inflight list
> -	 */
> -	list_for_each_entry_safe(u, next, &gc_candidates, link)
> -		list_move_tail(&u->link, &gc_inflight_list);
> -
>  	/* All candidates should have been detached by now. */
>  	WARN_ON_ONCE(!list_empty(&gc_candidates));
>  
> diff --git a/net/unix/scm.c b/net/unix/scm.c
> index 505e56cf02a2..db65b0ab5947 100644
> --- a/net/unix/scm.c
> +++ b/net/unix/scm.c
> @@ -148,9 +148,3 @@ void unix_destruct_scm(struct sk_buff *skb)
>  	sock_wfree(skb);
>  }
>  EXPORT_SYMBOL(unix_destruct_scm);
> -
> -void io_uring_destruct_scm(struct sk_buff *skb)
> -{
> -	unix_destruct_scm(skb);
> -}
> -EXPORT_SYMBOL(io_uring_destruct_scm);

Syzkaller found below issue.
There is WARNING in __unix_gc in v6.8-rc3_internal-devel_hourly-20240205-094544,
the kernel contains kernel-next patches.

Bisected and found first bad commit:
"
11498715f266 af_unix: Remove io_uring code for GC.
"
It's the same patch as above.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240211_144134___unix_gc
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240211_144134___unix_gc/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240211_144134___unix_gc/repro.prog
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240211_144134___unix_gc/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240211_144134___unix_gc/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240211_144134___unix_gc/3561c4956a5c9e7f995ae47d4ef703eb9c6a93cd_dmesg.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240211_144134___unix_gc/bzImage_3561c4956a5c.tar.gz
repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/240211_144134___unix_gc/repro.report

"
[   27.629798] ------------[ cut here ]------------
[   27.630447] WARNING: CPU: 0 PID: 52 at net/unix/garbage.c:345 __unix_gc+0x99e/0xb50
[   27.631312] Modules linked in:
[   27.631671] CPU: 0 PID: 52 Comm: kworker/u4:3 Not tainted 6.8.0-rc3-3561c4956a5c+ #1
[   27.632787] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   27.634018] Workqueue: events_unbound __unix_gc
[   27.634544] RIP: 0010:__unix_gc+0x99e/0xb50
[   27.635026] Code: b2 4f fc 0f 0b e9 6c f8 ff ff e8 0d b2 4f fc 31 d2 48 c7 c6 e0 8f 12 85 4c 89 e7 e8 ec f1 ff ff e9 32 fb ff ff e8 f2 b1 4f fc <0f> 0b e9 7e fe ff ff 4c 89 e7 e8 c3 dd b0 fc e9 9c fa ff ff e8 b9
[   27.637177] RSP: 0018:ffff88800c677b90 EFLAGS: 00010293
[   27.637768] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff8140b3c2
[   27.638544] RDX: ffff88800bfbca00 RSI: ffffffff8512a5be RDI: ffff88800c677af8
[   27.639329] RBP: ffff88800c677cc8 R08: 0000000000000001 R09: ffffed10018cef5f
[   27.640112] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88800c677c00
[   27.640992] R13: ffff88800c677c00 R14: ffff88800c677c00 R15: ffff88800c677c00
[   27.641768] FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
[   27.642646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.643285] CR2: 00007f6063373fa8 CR3: 0000000006a7e004 CR4: 0000000000770ef0
[   27.644069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.644876] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   27.645658] PKRU: 55555554
[   27.645974] Call Trace:
[   27.646266]  <TASK>
[   27.646524]  ? show_regs+0xa9/0xc0
[   27.646933]  ? __warn+0xef/0x340
[   27.647317]  ? report_bug+0x25e/0x4b0
[   27.647748]  ? __unix_gc+0x99e/0xb50
[   27.648190]  ? report_bug+0x2cb/0x4b0
[   27.648630]  ? __unix_gc+0x99e/0xb50
[   27.649049]  ? handle_bug+0xa2/0x130
[   27.649470]  ? exc_invalid_op+0x3c/0x80
[   27.649922]  ? asm_exc_invalid_op+0x1f/0x30
[   27.650416]  ? do_raw_spin_lock+0x142/0x290
[   27.650892]  ? __unix_gc+0x99e/0xb50
[   27.651315]  ? __unix_gc+0x99e/0xb50
[   27.651742]  ? __pfx___unix_gc+0x10/0x10
[   27.652209]  ? __this_cpu_preempt_check+0x21/0x30
[   27.652757]  ? lock_acquire+0x1d9/0x530
[   27.653219]  ? __this_cpu_preempt_check+0x21/0x30
[   27.653754]  ? _raw_spin_unlock_irq+0x2c/0x60
[   27.654267]  process_one_work+0x813/0x15a0
[   27.654757]  ? __pfx_process_one_work+0x10/0x10
[   27.655271]  ? move_linked_works+0x1bf/0x2c0
[   27.655767]  ? __this_cpu_preempt_check+0x21/0x30
[   27.656346]  ? assign_work+0x19f/0x250
[   27.656780]  ? lock_is_held_type+0xf0/0x150
[   27.657267]  worker_thread+0x823/0x11a0
[   27.657710]  ? _raw_spin_unlock_irqrestore+0x35/0x70
[   27.658269]  ? trace_hardirqs_on+0x26/0x120
[   27.658771]  kthread+0x35f/0x470
[   27.659153]  ? __pfx_worker_thread+0x10/0x10
[   27.659647]  ? __pfx_kthread+0x10/0x10
[   27.660089]  ret_from_fork+0x56/0x90
[   27.660535]  ? __pfx_kthread+0x10/0x10
[   27.660973]  ret_from_fork_asm+0x1b/0x30
[   27.661451]  </TASK>
[   27.661715] irq event stamp: 12659
[   27.662104] hardirqs last  enabled at (12667): [<ffffffff814359a5>] console_unlock+0x2d5/0x310
[   27.663049] hardirqs last disabled at (12674): [<ffffffff8143598a>] console_unlock+0x2ba/0x310
[   27.663991] softirqs last  enabled at (12306): [<ffffffff8126fcf8>] __irq_exit_rcu+0xa8/0x110
[   27.664946] softirqs last disabled at (12291): [<ffffffff8126fcf8>] __irq_exit_rcu+0xa8/0x110
[   27.665878] ---[ end trace 0000000000000000 ]---
"

As above WARNING and bisect info, do you mind to take a look?

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!


> -- 
> 2.30.2
> 

