Return-Path: <netdev+bounces-70274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6484E37F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA06289303
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379679DA1;
	Thu,  8 Feb 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cI9qF1+i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B07994A
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403967; cv=fail; b=uV4zyDoOdeYrRplvzC3yGAOaejHMdVMyGZsE6pBILTXBRbKv7ac1CTlx8BiPuCPPsgPQdvHSv2smP8WukCkhAO88Hc+jKqPyfBntT8i7C9kMqJYKJLmbE0M1snX+mNyT5BiS0M1x8cYVCyjzI7GpuPtEhbEs/Ypio0X5zI+P5bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403967; c=relaxed/simple;
	bh=5kZMWcSf9UyQKhYq/+KYPBBBZl7lJYG5ytWx9i1NyDk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fddq1iTEwHVeHWVcFfRr9VRho8TuoqgSFC1BDerRSgTv7N5n2fz6VtsMlPkENRwRIAKqunhfLmGdUyKMvBAqkc+ZB/s6lbJoYCFTf6RB8lQBfQeMRPjBUhiPV0v1RICdW4HDApadJjuIX3pidIZsuQda9eufifIjGu/abZP57xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cI9qF1+i; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707403964; x=1738939964;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5kZMWcSf9UyQKhYq/+KYPBBBZl7lJYG5ytWx9i1NyDk=;
  b=cI9qF1+iv8siFs0kYRrlP5JHPWylxCI+fxVRELFqttDo1cVAkncrQ9ia
   G2akUFwyruYrDaTLYdmR15l7DIFd6GiCpgDmDqM3LurFbvGqk7TTDAK1P
   FHFVpENDTFaz/coEjKwEm3eXmfbR6xBYf6+NGddxjSiIqBmtpWZR5m4jQ
   ciiuXSZ1ZFPhfNNYcC485d+eVkW4Xm9rArHIb0oFpw0XQvpCcofQmTIa5
   6rIiUBAzLJa53kyOQhcqEH4Seeefem4n027LxARH8HBkgCRJwupgWEA61
   zIyyudEN0nKj1R7XbSjje8E28fNx+Ig2xy7Zau7qfC8xczlX2pLKO04pq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="436367107"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="436367107"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 06:52:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="824857619"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="824857619"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 06:52:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 06:52:41 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 06:52:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 06:52:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 06:52:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcDqyvxx43djexemn85YmF1QpjX83sueMNve1QtWOwAAqstA0GK9swiI53MNcDPLRuYoMfPIDpVG7/NOQ4+jQd8n3SDN0yubLDu7lS/TRJnTiIFzSzu217Afijd5VwDNqUDlu50keJ6Hzo20BlV/2nPiwfzJvT4AobFUZ36tFDRXzwwyx5s2RyecH1fGSG3zrEoyAPqSONu2iy1eRl4DaMTbrEWptearwnQgH3rDPq/BS/n4b4sCp+pK+dMSlIRdn8kQhfUNKv/u8EmAwcfy8iJpwl4e0MSyDnbXtDLyF8eyLYdmHV8IPAoufuOCYrTZjZVqwF/Qc6LqUYi454iopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc1cYM8Z+WtO+3MwMJHKP5ueRYaullbFj/srFizJOR8=;
 b=jqgM/gwVT/+hhcVFqv2N9phDy45PFrTAsHwwGOjftD5IMD8CqykNd/XxL06NTxe2kHmP7FLf68fpLxPPeRnK9vWoZrMdDKSIvnOohFlK7aGOwhuGgNbVi7OBhjBqTqAD/Fz/sVHCQq/UdjAJVKgapEPb/TqHmPb8+TIqsafjdJw7MuyJ/WkfbvgX8ZT0aAz76lXjGk+kVlcKthBRMYFw/FIqHbIhioNTSYxQQWxWj3lSpaLiO2mn4y5clgz5XGecL0u7U9WKSFWA/qrnOTql/A/Na13mewWzsE1/3FW08OoUsVRWeQAiKQdrRyWq/nZI2vhXbKKQXvzr/HDCt7ZVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB8321.namprd11.prod.outlook.com (2603:10b6:a03:546::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 14:52:38 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 14:52:38 +0000
Date: Thu, 8 Feb 2024 15:52:27 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Yannick
 Vignon" <yannick.vignon@nxp.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next] net: stmmac: Simplify mtl IRQ status checking
Message-ID: <ZcTqqwmGTIEq6bfO@boxer>
References: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
 <ZcTNCxrWTAfj90Es@boxer>
 <871q9n81s1.fsf@kurt.kurt.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871q9n81s1.fsf@kurt.kurt.home>
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cccd5f-32be-441d-f2fa-08dc28b597f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKBfqB0+3L6WmGDSO5FdKr5+rqvMN5TgfOW1iY3j1GymgaR+Sk1jyWggOPKAwDbPapH4Fnv/nJ/e6OuwQlzlY940OiuLWFyEuidIB/X1106OEBMRYSM4zBkAziOJjiMYZ4zrzIQiRmaDtEdaDUjKNQNYVWG1aSaSy4ovptwjnSSmfRAUA/61KqG5gUHlHoDID/OOAQfJrbcQLcorUKtsRSiHcKQCBUywZH8Ea7X70ZX/1QHu/G3Qq63JArr9aJKpbZUPM/Z6m904zEl5bPyMXGT4U9wfzyrgiDSwtOYmQ+bI5J+9AB4Z4MJIsksqiFC1y41ERyvrZeIJrIICwHCnUYd7JmooZMTFbNqH9ve1xrrgScGI98jqYrCgf5II2C3kprAApTcnO3/pDxegt3SqH2p44kxvCLwFxjeVbUD8heUIBsWeWmTYF60tIcjHFX/5XTCcOzyWr7plEV41wAbonNHgUjHo6VYDinNKyz+RZ3mU4IJd95whJxXsVPMB2MEvcqTdPYFhqVIv9jtINk7w9B4uYYKZlAFaLIwGRsffrQGhwV1Zf35wbl6z1Ic8yIhq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(33716001)(6666004)(54906003)(316002)(44832011)(4326008)(2906002)(66556008)(66476007)(66946007)(6486002)(6512007)(478600001)(9686003)(6506007)(5660300002)(7416002)(82960400001)(86362001)(38100700002)(6916009)(26005)(8936002)(8676002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9Wa2JXuR4qg4cGFXGrrKqiFg4SSzSOevdQ0ro0iTE9QLF0uFGA2s73jfYlF?=
 =?us-ascii?Q?UBO8XUQJTcUkrol1fceDPzzhzsG2VFGm4xMqf4Cl1v3tK65OtoEUlfN6WQkb?=
 =?us-ascii?Q?qk/52HERlk5xSjJlBlSpOJpEoDYhShMDxkS3Ie7OYqpciOjNHjzOg3SWjNZV?=
 =?us-ascii?Q?2y4sYUuhQJpgyNzHbyZVItj5oOTcoH/k8lZTDQQxGDc52PeKmEYWmy4wDLR4?=
 =?us-ascii?Q?ZDKraiwlxFNNhCMhycHVaDWyuuCEK10ocXH2pw+Xi7xulx2RAtb36jGhdo5U?=
 =?us-ascii?Q?K8Tl0C4PujIerbJh+1yoqrpySjYZ6rkrEyVD2QaXOHk/cZgr8pprCecmq4m3?=
 =?us-ascii?Q?PvprlSK/rhppaTLjPUlpXk6eJ2wX0BM7Zn7VXGOdicSpfLBAcz/fEBxADDBt?=
 =?us-ascii?Q?G7Bkw6fM0ARIV8hwmV+rWKwI1UoZxB0GiqhjHtwy2+eiCb7qvQ0piAI3/68s?=
 =?us-ascii?Q?L89gpfKn6ZN+Fw6cT8+rOF8Bk2nCye9HUoaVBRhGZI/fD0QWxlJOgPn0U66r?=
 =?us-ascii?Q?KdjG8DXaQ2r0noml08spiXg/o7qEL5BKN06UtYbYjKgNiFtLhDvSQe48wazK?=
 =?us-ascii?Q?fDNp4FEyepsUCty0ORTOP8Ux0gMSpvEZLeKHRH0KTROxsB3sBq3N74/F7qt6?=
 =?us-ascii?Q?TQmIjxa/crTlMGvh/WW7R30ItrZNSZRa3SRlfZNiWEwB7Lv3CfmugLju/rGz?=
 =?us-ascii?Q?EAFHZXtkLDZTWCvJnmM75l5Yp8oL+RNzPrcxTOUH5856xTF5ukGSM+USY0ZL?=
 =?us-ascii?Q?2xJQLfrxgMYJS3QdhSXVkUIcDQkFJsuf9D9e3GURDgkEU9mx1NBw9OHzvpuL?=
 =?us-ascii?Q?32RQ4Ggr9A+kqoFy5ObEftUp5NYJi+xS1XndqlgFSYeYN8Dvmw5t6miGSmCz?=
 =?us-ascii?Q?7VeyzMd+TNR4LQTWkx+dxpUuHU9H8u+8Az8kTDxQ19LjpmZwVznwXoNK01iQ?=
 =?us-ascii?Q?ieY5CC4ZEAS4ANpvclrSbp4SMdcGWvDZ/UUhmlo9dyDn0z0W6T9DIMnzrvL+?=
 =?us-ascii?Q?CqiCfn1GjhDuRLFan8T6rwaqc26C+hm/A8EZY4gJXgdTC5ep0XYG+g8qGbB4?=
 =?us-ascii?Q?e+BrrsYSTjVJ248DY3PHxo7WbB2SiFyzDnhI1xB0T/JQDEo8Ts6z7gZWtskM?=
 =?us-ascii?Q?npjwVc0wASoqTRWaf0YEAf9De2c/xLed2KbuGka6xtl6lSpyyZrLo+Q1fE4C?=
 =?us-ascii?Q?XMXtTY9wBwe5/Z4s4UTpqnj28XV/RhaDWAvhRTh+6LbeqZILI0BTG1BlVUdw?=
 =?us-ascii?Q?NcMzo0z0I1odVhtVoyio46WAHSJT9jyDslcDwvLjd/lm0f+JPXTEgXB5PPeY?=
 =?us-ascii?Q?4LZm+0zNb8eWV204Y/bRMG2s12/WHKCCTobzTzEovxC7LjtPU6OQ+08BW8EW?=
 =?us-ascii?Q?wBAbVo4woHZ1k2Lno+1n2P5KiNQ+q3JswQ/KsLFJe/EdrnpLGA6ftBjY3nSC?=
 =?us-ascii?Q?vhl+oMSuAV73mQuYq523sS8dAvBU+/M70CLKnccU7rTAcXQEL5VkX0vbibFm?=
 =?us-ascii?Q?bRrPNqiGCAxJsjUl4tpGSNPzsVONTq1L71BRw6n5koNOqguPUtgdMcsBctKY?=
 =?us-ascii?Q?YhNKGpBj1YxESItEHA/mhV90jupHYklZKAACmZL2T13Qr7RR4Zsgu3S4UCnc?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cccd5f-32be-441d-f2fa-08dc28b597f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 14:52:38.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MxG4YkK9deRpKQw+/Y5ivo2n24+IGH1/WmCPy+hhr6wxXAflPbEyazFd/VK9KrdItuPX72NEHdlLnJ6msT6CYU5ZesuV6w1k6c0qMjsSgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8321
X-OriginatorOrg: intel.com

On Thu, Feb 08, 2024 at 03:32:30PM +0100, Kurt Kanzenbach wrote:
> On Thu Feb 08 2024, Maciej Fijalkowski wrote:
> > On Thu, Feb 08, 2024 at 11:35:25AM +0100, Kurt Kanzenbach wrote:
> >> Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO overflow
> >> interrupts") disabled the RX FIFO overflow interrupts. However, it left the
> >> status variable around, but never checks it.
> >> 
> >> As stmmac_host_mtl_irq_status() returns only 0 now, the code can be
> >> simplified.
> >> 
> >> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> >> ---
> >>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> index 04d817dc5899..10ce2f272b62 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> @@ -6036,10 +6036,8 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
> >>  				priv->tx_path_in_lpi_mode = false;
> >>  		}
> >>  
> >> -		for (queue = 0; queue < queues_count; queue++) {
> >> -			status = stmmac_host_mtl_irq_status(priv, priv->hw,
> >> -							    queue);
> >> -		}
> >> +		for (queue = 0; queue < queues_count; queue++)
> >> +			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
> >
> > Hey Kurt,
> >
> > looks to me that all of the current callbacks just return 0 so why not
> > make them return void instead?
> 
> Well, there are two callbacks of this in dwmac4 and dwxgmac2. Both of
> them still have the code for handling the overflow interrupt (and then
> returning != 0). However, as of commit 8a7cb245cf28 the interrupt
> shouldn't fire. So yes, it could be changed to void along with some
> code removal. But, maybe i'm missing something.

Hmm, ok, my 'quick' glance over the code was too quick :) I missed
overflow encoding to ret within callbacks, sorry. But it seems that even
though they can return nonzero values they would be ignored, correct?

> 
> Thanks,
> Kurt



