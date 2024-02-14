Return-Path: <netdev+bounces-71587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED656854105
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 02:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6028D518
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 01:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF38821;
	Wed, 14 Feb 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqRTBBLl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED08801
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873214; cv=fail; b=KwtcraFhX3QNg1WIpjFPKw4r2Saoz9OGPcSmhlpuLSOxY1cTvb+MEBl0V/r/pMHwtPtvVURTpZsZl8REaOskqhQ9+4Xq5/aiXTM8SUpaYH52nBSjHQoDoPTY+8ubC+2hSURV/TwCAOw8Nu7oCeZZmQaEvPJEM213AEX5Ig1pXFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873214; c=relaxed/simple;
	bh=VbmOEN7U3J3o14deDley5AijqoTAhXMkg/4gwXbA1qo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fMNSi4WQDEtraxQHl2/xAKTrtejOXYvYfcGJXR2rqB0xAT6L3eoysfG8c2vY3QYjo6HVrGE0FoRIp9t/vbNFvnaSEQA1Ep92pADbSogDm4Nz4wKuMZqnQl1KgDOlyhXLOdco1uLTPiAlX6xKPCxyweFfCAfvI1zuUa1X6GCqWC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqRTBBLl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707873213; x=1739409213;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VbmOEN7U3J3o14deDley5AijqoTAhXMkg/4gwXbA1qo=;
  b=SqRTBBLlDsqQ/3ww97KbHsGjRMJNCrCtjWw5N1k1KBGLsBGDlJICnGIo
   4nbAN1zZRsOZLftjF2p/1ZTRq3OMYRoUslNrpDFQroUYL/x4RRBAfuuWx
   iKdwrFOuB55bhdwgTPx2ryXztkoiYqleERvN9QDGdcxa/DfZziOIpVMaZ
   LIvc8ezzp5Mnvf1VyUmJn6Eg9jdOYq2XV/pJ6iW+MVzq6TINwvMqesfBm
   3ZIT9VfV5mI6BEgommlbGmt7P/oSo13IfVTw9QmJnR3MecbArG2lrhWE4
   yQ911l82iiFGeZuFlRrDrJufXr4A/MQMLRRYfsRWWKNEtJVAGjbXNnXNt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1759177"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="1759177"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 17:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="7690036"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 17:13:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 17:13:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 17:13:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 17:13:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 17:13:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I15XHaUCFbb1HwhlEeLlJmqScccQiA0v1E1khFq5BYRhYZIm7z+3wFwiTnszUFdvK3KdXKmbIKFtxTlq7UVY9/0YAMb7WZ6ljwtpfA39ILpkBxl/JqYYnrXqGWVGRfhnv8/vrb0Zmr6qP9QgLmGUS4REh7j5TT/jtRu+L9aISwO2k78S9o8fR7QkANwM91BCYCD4Sk4a4nOJwSfse8bh/uXZDzwhK42fhBvWkIPnUUsnFb9ZCGzR0aFrfnq/vzSetB2zhNbMRjrMhbG0FKVIHyV5rNRXPVNOLvohQZmFlWkmJQYmNLlT9GC6+69xw+pMF6fxmbGxovZezgcEHdXKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0QTmdUIrr+wy2I9Y0egpvLa1QyJsvUvyHdJjUGJ7/g=;
 b=NmPswVBNxCkG5Cq/bjqYRhsrAuWJ7+KTdcCt7ztyQK2rPYMKsUf2YTa3P7HmGLKGuN67aQQPifj8RjU2bzPW6PUr4vnHRWXqB0hTqBXEwoAOwUCUa4fWn2D9sy+fCfWMyA9n68N28jvRRRbvN2hP2XC6qQbcmyNcHkxDS50lktp4SGG8byYzoj4ks5hiL6jKDazbpXToeJExmjnNHYnwKWAUMBm6VkgYYdEgnTZ64yHlh63pEXiY3I8/wBJZ6C/BCCMS3KEHL31gsPlWnVgRP81H9fQwocIAat6/L/JJ3vtnfIICxdVDXMHhGxUQult/+S00AYfDmcZlhyNQBr5vMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by IA1PR11MB6323.namprd11.prod.outlook.com (2603:10b6:208:389::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 01:13:17 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::8cc7:6be8:dd32:a9e5%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 01:13:17 +0000
Date: Wed, 14 Feb 2024 09:08:06 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pavel Begunkov
	<asml.silence@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/3] af_unix: Remove io_uring code for GC.
Message-ID: <ZcwSdp8+gWAkXcru@xpf.sh.intel.com>
References: <20240129190435.57228-1-kuniyu@amazon.com>
 <20240129190435.57228-3-kuniyu@amazon.com>
 <Zcl/vQnHoKhZ7m0+@xpf.sh.intel.com>
 <8eb7c0b3-afc7-4dca-b614-397514a1994b@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8eb7c0b3-afc7-4dca-b614-397514a1994b@kernel.dk>
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|IA1PR11MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 83eb88d0-be75-43c0-1033-08dc2cfa2018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTNn0FuX1kRl4miA6RdvaZ9FzQ+qBPAUGcBWg56yf2rw65E1svYWm0+JudFRrHVcDH63QCo16ZY8lW1Wo2EIrKmmuo/jMgzekWQIQbwzjDQvgHF4AE9rVX/DMF1KWCGaF7Pea8VddrpbEWm8qdpTZbqCudX1EhdNA/gBJhpOB0IpNS1iD+I7bquN79i+qkl0IzYsboLhFRQPAL5zUYtQtygU72zgUJjuP71mpS0tKYoxWVtaibVDCkHlEhzgkbrzBFARL5Ru4E0uq8Tks2WR8v/chnCeSLELOCrcIFWTR8PUK4GiFLOaRlhKRl+W9+EUHbcDtzT+9WrIAR+br4Trj9A1vthdgO1hzGwc/ly5k5Dczx2/YU2t8L9IKrZ+ClXCXS3/zdZeEnidRSJWhcfhDcaDDKwvbVE/iSc7wTbjt+0M5xsftU29+Tpjuf+ve/RryU758HfBFe4rQ1J7q0jql3wo9OoqSAmAPmDoGGFPs1VBSy7rzQIoA0Q5Sud4zjHTodFh9xzakwIVoVPMd+DvfqkIEAd+1hJrH+5flbP5571/VQuxztBe/ASBXhqhExAU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(2906002)(44832011)(478600001)(41300700001)(83380400001)(53546011)(6506007)(6916009)(66556008)(6512007)(6486002)(4326008)(8676002)(66476007)(5660300002)(66946007)(8936002)(26005)(6666004)(54906003)(316002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+YeRM8eHGKBa3/1NihUh3qUGSPwMAqjn7uqKyY0uvIgm/PRFej3zlSESFoeW?=
 =?us-ascii?Q?e2JGdwkYoycRz2BWEDRO7h4xdgHrZyFkyT4AqXTmQyDV6TKrn9lK6hjnbfgd?=
 =?us-ascii?Q?arMHXR9eSBJfbM4vbmWRHpk+e+4IEVQ5huCSdmhTbyMoipJKebkzFqkSwIfR?=
 =?us-ascii?Q?vN4u5WwIyuvZQJqYp0cixZv5u2CdmH6edYymWeZx5WNlrPdasGBCy1dVHWcQ?=
 =?us-ascii?Q?FENoDrkEgB2qY640HA8r0iBGWuD1o/ZSapjp7tnR+9XRvQM92/ruAzaDLlwY?=
 =?us-ascii?Q?LJyEEiqw09/8zEFCn1VfBCQaL6RH7FtQITpITNtrAuBUxNITAf2RWQ1ZgHk5?=
 =?us-ascii?Q?EaCdh18j/H0pB1awqpLsv2ESn/Ir6jfKqhNzWl51CbBqFmNt51q3Tg1qJU3Z?=
 =?us-ascii?Q?y7v3G7cRz78frEJ0LFmS/bejsMG6Yb6Y+mbogngWonZ1srB10xGyKwVetJr/?=
 =?us-ascii?Q?3o77CNsICURSVclaevDI/hy2jwYUe4hx2/7DYHDs76esY6swznnF0Q1Ybl5a?=
 =?us-ascii?Q?jG0g1i0NsJCydbdBCtgNlrgT/G5FaJ324v5GauPngvpvBBy7QTQamfd9yOz0?=
 =?us-ascii?Q?bIcb5jYueFjC5MYPxpZLSYDsDtCDH/1Bfjdv4iOdV26JIRe/pyL5Mpf9GXzL?=
 =?us-ascii?Q?HLXf4SlRHjPb/R0TSkqJsd/dp4Jf+Vbn4y4YgLet9P6Re5jqA0pIVfi/6Hy/?=
 =?us-ascii?Q?fzTUvV2WP0+hJqE9Y2AJtoc86DAN5YarhXG98bhPHRmWvI6ApOoaVRzJ/HgV?=
 =?us-ascii?Q?wdbRV7xDn5z3DGg5UsvO4rH0gvA9pxMFaicqSCXAQfMR6xagQAiEJoul2H0b?=
 =?us-ascii?Q?4e/0NEkeVoDt8m0RW26PdY6eLIofVR4zP0ZnelDCb2a0jDqR4PHVxfrz6uXo?=
 =?us-ascii?Q?2u/pdXTeXhtHxh0VwWSKnUSc7z/+M4BK6OP+0XGA6+puH/c+JT16yKk0HNkW?=
 =?us-ascii?Q?nJ9cYUVEMOGFMEaa+rsVuoKrkc/YCcru27dx8fNXyCjD5rWt0GobCtSoCz2e?=
 =?us-ascii?Q?U7sJhEj38O4E/75Mt+gFe2E4H83LmGx3Fst9u/BAJ1qUkxgkO07Q0+SoAuTW?=
 =?us-ascii?Q?7/tdYUztAgeoe4csgK8ompsyMwCIoD6SWx1muj5/gg4wTgoru0FxqRXy6fh6?=
 =?us-ascii?Q?0vfy6FN2or/gJYIZvZyK3/q3pNbEh65L7cXLzzmuJvYjzOtIJ935qP/vhx36?=
 =?us-ascii?Q?IlJ/qCzV5BgkAOx5Ja3AFv86mSKf7bA4Mk61R8J3OvHXrSYJYTguUHSnkSnX?=
 =?us-ascii?Q?lCSMLTrVdW03lzTMycQLGIrD+rQNGD6cHgNpSElFqiLPbX2Z//vzhiUwHR9k?=
 =?us-ascii?Q?DxxT9HJtMiLFen0D2G7RqpC4jk/tjS02g6Sf/CHswv5T3qpLicEY/K/y60av?=
 =?us-ascii?Q?wvKokbpQ6DCvA4AO8g1EHBu9GrobmdbpjvsNLA1r6/qdSlhamFXfhk+UDzY8?=
 =?us-ascii?Q?Mqsot4EbvhVP8hjLdTkUAKiB1uwxOEd7rReRN3kbX0NaCJeUzjo431B8enMV?=
 =?us-ascii?Q?Q9KJprNiv9orxe0W0+lxbfaAC1cwKP8zFj3+elgNOupzG67bWKgvczA7at/b?=
 =?us-ascii?Q?qaLslNZWnl5IbRANyC8K7F57dcFWgbX0rh0j4lJy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eb88d0-be75-43c0-1033-08dc2cfa2018
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 01:13:17.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWLg5MEyskWiIKhP+e9M4OqTe662YwTBwHvIyY3M2nRkOpHpn1jQXBzfgMXl3fEeKpEcTCSTtgQXD0bj6YvJWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6323
X-OriginatorOrg: intel.com

Hi Jens Axboe,

On 2024-02-12 at 10:47:20 -0700, Jens Axboe wrote:
> On 2/11/24 7:17 PM, Pengfei Xu wrote:
> > Hi,
> > 
> > On 2024-01-29 at 11:04:34 -0800, Kuniyuki Iwashima wrote:
> >> Since commit 705318a99a13 ("io_uring/af_unix: disable sending
> >> io_uring over sockets"), io_uring's unix socket cannot be passed
> >> via SCM_RIGHTS, so it does not contribute to cyclic reference and
> >> no longer be candidate for garbage collection.
> >>
> >> Also, commit 6e5e6d274956 ("io_uring: drop any code related to
> >> SCM_RIGHTS") cleaned up SCM_RIGHTS code in io_uring.
> >>
> >> Let's do it in AF_UNIX as well by reverting commit 0091bfc81741
> >> ("io_uring/af_unix: defer registered files gc to io_uring release")
> >> and commit 10369080454d ("net: reclaim skb->scm_io_uring bit").
> >>
> >> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >> ---
> >>  include/net/af_unix.h |  1 -
> >>  net/unix/garbage.c    | 25 ++-----------------------
> >>  net/unix/scm.c        |  6 ------
> >>  3 files changed, 2 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> >> index f045bbd9017d..9e39b2ec4524 100644
> >> --- a/include/net/af_unix.h
> >> +++ b/include/net/af_unix.h
> >> @@ -20,7 +20,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
> >>  void unix_inflight(struct user_struct *user, struct file *fp);
> >>  void unix_notinflight(struct user_struct *user, struct file *fp);
> >>  void unix_destruct_scm(struct sk_buff *skb);
> >> -void io_uring_destruct_scm(struct sk_buff *skb);
> >>  void unix_gc(void);
> >>  void wait_for_unix_gc(struct scm_fp_list *fpl);
> >>  struct sock *unix_peer_get(struct sock *sk);
> >> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> >> index af676bb8fb67..ce5b5f87b16e 100644
> >> --- a/net/unix/garbage.c
> >> +++ b/net/unix/garbage.c
> >> @@ -184,12 +184,10 @@ static bool gc_in_progress;
> >>  
> >>  static void __unix_gc(struct work_struct *work)
> >>  {
> >> -	struct sk_buff *next_skb, *skb;
> >> -	struct unix_sock *u;
> >> -	struct unix_sock *next;
> >>  	struct sk_buff_head hitlist;
> >> -	struct list_head cursor;
> >> +	struct unix_sock *u, *next;
> >>  	LIST_HEAD(not_cycle_list);
> >> +	struct list_head cursor;
> >>  
> >>  	spin_lock(&unix_gc_lock);
> >>  
> >> @@ -269,30 +267,11 @@ static void __unix_gc(struct work_struct *work)
> >>  
> >>  	spin_unlock(&unix_gc_lock);
> >>  
> >> -	/* We need io_uring to clean its registered files, ignore all io_uring
> >> -	 * originated skbs. It's fine as io_uring doesn't keep references to
> >> -	 * other io_uring instances and so killing all other files in the cycle
> >> -	 * will put all io_uring references forcing it to go through normal
> >> -	 * release.path eventually putting registered files.
> >> -	 */
> >> -	skb_queue_walk_safe(&hitlist, skb, next_skb) {
> >> -		if (skb->destructor == io_uring_destruct_scm) {
> >> -			__skb_unlink(skb, &hitlist);
> >> -			skb_queue_tail(&skb->sk->sk_receive_queue, skb);
> >> -		}
> >> -	}
> >> -
> >>  	/* Here we are. Hitlist is filled. Die. */
> >>  	__skb_queue_purge(&hitlist);
> >>  
> >>  	spin_lock(&unix_gc_lock);
> >>  
> >> -	/* There could be io_uring registered files, just push them back to
> >> -	 * the inflight list
> >> -	 */
> >> -	list_for_each_entry_safe(u, next, &gc_candidates, link)
> >> -		list_move_tail(&u->link, &gc_inflight_list);
> >> -
> >>  	/* All candidates should have been detached by now. */
> >>  	WARN_ON_ONCE(!list_empty(&gc_candidates));
> >>  
> >> diff --git a/net/unix/scm.c b/net/unix/scm.c
> >> index 505e56cf02a2..db65b0ab5947 100644
> >> --- a/net/unix/scm.c
> >> +++ b/net/unix/scm.c
> >> @@ -148,9 +148,3 @@ void unix_destruct_scm(struct sk_buff *skb)
> >>  	sock_wfree(skb);
> >>  }
> >>  EXPORT_SYMBOL(unix_destruct_scm);
> >> -
> >> -void io_uring_destruct_scm(struct sk_buff *skb)
> >> -{
> >> -	unix_destruct_scm(skb);
> >> -}
> >> -EXPORT_SYMBOL(io_uring_destruct_scm);
> > 
> > Syzkaller found below issue.
> > There is WARNING in __unix_gc in v6.8-rc3_internal-devel_hourly-20240205-094544,
> > the kernel contains kernel-next patches.
> > 
> > Bisected and found first bad commit:
> > "
> > 11498715f266 af_unix: Remove io_uring code for GC.
> > "
> > It's the same patch as above.
> 
> It should be fixed by:
> 
> commit 1279f9d9dec2d7462823a18c29ad61359e0a007d
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Sat Feb 3 10:31:49 2024 -0800
> 
>     af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
> 
> which is in Linus's tree.

Thank you for the commit tip for the fix. This is indeed the same problem and
has been fixed.
I will check the community mail carefully next time to avoid reporting
duplicate problems.

Best Regards,
Thanks!

> 
> -- 
> Jens Axboe
> 

