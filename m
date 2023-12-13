Return-Path: <netdev+bounces-56896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380C8113AE
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159B7B20A28
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57412D7B0;
	Wed, 13 Dec 2023 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hA1bliJw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BEB1FDD
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702475497; x=1734011497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XaC9jolpsVx6z2Nr9vbXFn8g2aasGjkVdTey2sfMYAo=;
  b=hA1bliJwvvFoaXU6BqWn6EsvQo3EGfo0ToCHaUcTv0frK0JXFC/nkxK6
   3vu2pAoBjwWxb95eebl5O1qw5Whfimb0uFHK8qkWfS8tGx8NtpZOlgLab
   dBbC6RM7BnPJSjENwV22HrajLLWxoziO2ksVoIUi3bvIIZ2M3sgdi6dV7
   xzzcyJzd9/UeTubIBD7N+yBzdrO5LyHpFfK3Hb4Jf9ACDffa0VCoLFMa5
   cFnHjLBHnditCqFcsrsGgAzBZkmblr5y8aFIBkZ5QpF7XSbNCi9AuSiaN
   e56NdVSKS7nPUtFPf3WXSBbvEG5oiHly9ih3MgvbYc3gdQTGA5nUEIE74
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="374470295"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="374470295"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="917662468"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="917662468"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 05:51:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 05:51:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 05:51:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 05:51:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 05:51:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezEqjxzfWtFcLXaRCHoocVzo6wsuqorKhXUYrJ/O/KyEh3FdFyQ1Il1uk852RzHKHrq9eNaTskArPu57qAZ5l+FCWcK7cHLei5jrKMVa/ntlcRwNaE3pV1/6lT+dZEBekkLQYXClcI8J+AbVONq544uu+h1VhOV2gvTiFxZrC/r+BzNUrfc6DwUukyTtkcLafMEktB3gI6Bt1BUMVqGas7jn15Ku85NDAj4W5VoLWZlvZtNttlsl71OLMw/Uw5KlnKtd0ZMlYoHGJ/ii0snySzNi9FEhyCFOs7AXMo6z5/vTWpNOYLaqjaPGkIJeq+tZ91eDeUNbVRTjLYxmh9HOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqggKG5j20WT2QkowlpGApVKkG7Cg5HeupP/BOdhdsk=;
 b=BxkwiNhHzrBVxm4DJPmfybZabDA3WngqcTFpi8XMTSqOBqfFBVdiJWrS3j6NIjKkujGcr1gDoGh0Lj4nERdaCLRzY1eJwtAaJxCOvBiRRWOkVqTmeXSC2YejFRjLNwCI4e9XsyW5SpB29M/tJ5rnnMLABgKk/CH3Akr29+3E4Dcbz2D1O7U5K3030Y/OsDRQxFH09GD26vRsxpkrnvZnYOyKu07MgdxhQwUpAqSdPaiqq8Blr/Nl4tW5kEvd/SZs8rJc5zK5cONAJAAZjzJv4FlgKgS5GhHUTLFJOQbIWHo9a+xaWkEUj0AssICe6q7Z76rGf8c6Szb40dRsxiO/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by DM4PR11MB5391.namprd11.prod.outlook.com (2603:10b6:5:396::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:51:32 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:51:32 +0000
Date: Wed, 13 Dec 2023 14:51:20 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: Joshua Hay <joshua.a.hay@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<larysa.zaremba@intel.com>, <netdev@vger.kernel.org>,
	<aleksander.lobakin@intel.com>, <alan.brady@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: enable WB_ON_ITR
Message-ID: <ZXm22Iw+vSxacpkQ@localhost.localdomain>
References: <20231212145546.396273-1-michal.kubiak@intel.com>
 <78ecdb9f-25e9-4847-87ed-6e8b44a7c71d@molgen.mpg.de>
 <ZXmwR4s25afUbwz3@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZXmwR4s25afUbwz3@localhost.localdomain>
X-ClientProxiedBy: DU2PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:10:234::11) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|DM4PR11MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 8104f525-d01c-490b-2e26-08dbfbe29d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dq35O6VtnokHTWzkidREttDhfUmjnYcvywXzq45s/RmfkaFmTFfr5p0Z0Cjt1d8GYmne+j3L06hAEQh4qXxmYvUfVC8f0Sz4PdR/uIEJ5z/3qsgbaFlvbnUtftSwYUyKICYlWe13E5IiK+st5sZ+K1+nTp9CD1RBGpFzKGTqDkVKlbbzK1dg9ucxSVQehhHheNjg2qGSHh38WUS7hEItSdpUKeHHNr3RuP2W2C381QOqyu1dpyp0oi8kRkOdWm0SK95BSFVrWKvaNzrIy651EWzaLZQDnHXDlhI1DboDKtyiVmMkRm0234Ta3qBQFFTgynboXuRZ8//qwo8EW6bjcTTypYYXYGiF/6H64q2UEjn28aWwSuGxTrj4/gOyoKZst4gwIoKz36dWnxB3OoWRomrKgwhY50yCa52HQuts22D42MqIrQ26xKgvvbX2tWaXQyS9K+geAkzDR5070cDofNs64bCVCJUD7RqUmi3kcz474qjAdsz8bmpf4RH8X1tnEn+UxH046dMaRCuNO80FTonhBTWcykkW15ywKiwGPhOpmU7OWLr5kSM2Lf09KOqASgNw0YSxUuvnSjWRYlWRlQNilA/XhXAvN47hBhw3G0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(107886003)(9686003)(6506007)(44832011)(53546011)(38100700002)(6512007)(5660300002)(26005)(4326008)(8936002)(8676002)(41300700001)(2906002)(4744005)(6486002)(6666004)(478600001)(6636002)(54906003)(316002)(66476007)(66556008)(66946007)(110136005)(86362001)(82960400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wj1/tvelX1g6+vwKyuJmuIZ1gLf7R3FgqXf7reisQ/z5dkS7P8M+/08Ot7N8?=
 =?us-ascii?Q?v6kFnTJr62pCwzHnxA2pCKZFOfazUP7SWxYt6mkAXQst+V7dxrx76MQtVjel?=
 =?us-ascii?Q?VMO4Re0ZDC7rH/9LLu1R+EVLF1XmeAF0s/FzCov8j3++DN3hgtvL1wnqt+Kj?=
 =?us-ascii?Q?5grSKoEjZ5x21Vmdf0ikRCwFA4wolFbqA6NGm0wSJC4atX72ZmTsvyfteGFo?=
 =?us-ascii?Q?3DuHx+uIdqtkvdLjWf11s5q4iiNbEN0z/ehGrjTVB0D5WiEl3XzIylx72SW/?=
 =?us-ascii?Q?btSoXZQbYNWtPrcLroiajv1L+iMjcXvvn8uQyH1VYbqmzPrgmEM3vdCfU0xA?=
 =?us-ascii?Q?R2mfRrDZD9CNMt2rtl1CQZO3nUDhJhxXxqYllD5ZUonMtVWFe9EUL02DCGug?=
 =?us-ascii?Q?YWijAhU4L/cKgvdhQmZ0HQwxtzF12WdHPRUG7Wj5q5sJsahJDO3IXw6fwrbH?=
 =?us-ascii?Q?9xPMFIKgGQF8ChCcb/nFrf2rG29DJ6PMKt/nll63/SOhqsd2JruHPMc34RvJ?=
 =?us-ascii?Q?HPkXecAkoOpMvK4KRqrbJ5olhuW/cgHPF5Mg2OSfYDeNQlkFB62ZQm+VG9Fb?=
 =?us-ascii?Q?rTqWIkUjyV2VoTqcucf+97e46ZkiVvmmyaHCCBJA9R9w2K9FDwQxLLWWOBPJ?=
 =?us-ascii?Q?xQdBqqHGgkVnPZKN07mIzlpWItDgnfljTOMcbxJmrL/yYTIvTM7qHuHpRJiH?=
 =?us-ascii?Q?OUUe4XE1lffv2sOS4R/HyZWD+h9DhrVjnhIT8exIuIr+6J88P+JTRaz+t+jk?=
 =?us-ascii?Q?cUjl+5nu0TLZ1MEZekFkVbUUw+E61jICG+XPjOdGZUdPRjxrju73UjsV8Whm?=
 =?us-ascii?Q?0LfDHKgMnxT3SuKXGgeTFLBYf1rFW5taR/RpP9JyFzUnrtF3NhVrt5vcR17r?=
 =?us-ascii?Q?ICgFQShbvMkRkQ5XETFqxVEb/E2rNoh/3J5K700hY4XmB8JuaiI2M/Woz8AG?=
 =?us-ascii?Q?W4PX7y8WRp8ehhV7Fa/78gYaOrUeL1g2EM29N8E4IaGWJMRd/g4GeoO/iD1S?=
 =?us-ascii?Q?Qf1pZpVKOxGh9fC/gbMUQXfSUxeYQLCgpJUuUmEumv+ghmKUK7v7bxx6aLlP?=
 =?us-ascii?Q?pMNBGRKZkEpwpizcuaQGe1dHjc4ITAg5SGRY6FMeLrnknN9cJVq6GxiFX1l0?=
 =?us-ascii?Q?Tow+OD6y6og8bYc+ZZQMKfOoVTXqSFzTqu/Z/Kygx+bk8hn5+weSpewPeEjJ?=
 =?us-ascii?Q?FFr+P4ZAeP7vKO21m9qwbGiU04eWi8/7yhHMkJTRlNyxbP/WeNqSF/N66dj2?=
 =?us-ascii?Q?HsQhZPEdCjC/uLB0mfsn2feM9HVUOy9VWGTQMSRGt9wEUkCOITWycI1Z5VXX?=
 =?us-ascii?Q?wuMraocvT0MQpvmF5MbJYpcTdH9LExYRQ5I4iFF0VDthnkV314jwJ+nzk1JX?=
 =?us-ascii?Q?WVrjwNnMu8CQBMuphrAnKt7ogIDxI9VjOiL+LoXO6Gdymx3W1syzwuatZprB?=
 =?us-ascii?Q?qw08XY0MDYRpUVEVoHVeU9xb1787KZyUJZ8t9CqtgXWbYtnW+3AX6AJGmcRi?=
 =?us-ascii?Q?ZGE4je39Z5SruygGcmLMLIZKw7ntY0228z8P3L2YRIfcujcwkz0scmbAGQTk?=
 =?us-ascii?Q?YYCBq5hl/WstH7pfkSBUUaol32FxE8fM5xvD5atcgfxVYtc1D/6FX9xwxaEg?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8104f525-d01c-490b-2e26-08dbfbe29d4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:51:32.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUsAwILfbIlmMEsjvdLVGxokiFNtYAqSSKmZxNBqCKRzdQGgkMO+LJnciVRBkv69ZuwX0ZEqxoGiR3v5byTI2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5391
X-OriginatorOrg: intel.com

On Wed, Dec 13, 2023 at 02:23:19PM +0100, Michal Kubiak wrote:
> On Tue, Dec 12, 2023 at 05:50:55PM +0100, Paul Menzel wrote:
> > Dear Michal, dear Joshua,
> > 
> > 
> > Thank you for your patch.
> > 
> > On 12/12/23 15:55, Michal Kubiak wrote:
> > > From: Joshua Hay <joshua.a.hay@intel.com>
> > > 
> > > Tell hardware to writeback completed descriptors even when interrupts
> > 
> > Should you resend, the verb is spelled with a space: write back.
> 
> Sure, I will fix it.

Hi Tony,

Could you please add a space ("writeback" -> "write back") when taking the patch
to your tree?

Thanks,
Michal


