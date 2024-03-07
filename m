Return-Path: <netdev+bounces-78470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F978753F4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004C1288408
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6812FB17;
	Thu,  7 Mar 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKMLpz83"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E512FB24
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827852; cv=fail; b=Je7jZ5fbHj6TX95lFYZzjtKCbAfjgQkvK3MdV74TqfLMDGtG+31uu32iyfHe/Eqn+yajJOx8gQ3AyI3nywlEMsm39Da4PeW0u1t8fIgYKLG4FYZpFsfoquhK3hpXhacZdNCNml4ltfl/Ytuctin7RyTl7jKedqvI6rwoRx1JTxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827852; c=relaxed/simple;
	bh=Ltn5K/ITb7ppvINXjVGqpO1iA4APJuVVP5Tj00xtrRg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B7SPoQ2lnlTsPBLNMYDHU+jKF+yumqet6alZ1EIUAV5y1aCvrydP8gUkao4a58l0guUi5iDEw4WFkvDbvBRW8DgvsBjYWpgiqsiD3pg0WQRU+uTkSsnCUvwYj7eZ4HXMy6oFO8nFn0ukcoMYEBl6MuXVV+h12jn99I20OBgFBEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKMLpz83; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709827850; x=1741363850;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ltn5K/ITb7ppvINXjVGqpO1iA4APJuVVP5Tj00xtrRg=;
  b=KKMLpz838rW0qwIozZ0beyst96FBnjhGxWplb1GbEKEST9zzwlESskmV
   sW6/MN59TvUgujJwtXP5+9FCos4Oa0xVGQjS8zxhvAAjhgyd9uX6tbFBi
   Omw4r9vEt+nTJ0/CTQ1I6i2YII+Kv31eRlU73z1NGloGksXOGBQcYzYIt
   n4iVINY7alqBbLIligJWMm2811Oc0FhyoWT976jKfkWYKgKdtpkbSz7O5
   oulSvssVJuo3wNiazNJgnPXu5601mlVPr5s3c9b/bsSD9quZnCtZ1Tg71
   UrZd6NDMQii24PIPODy6brl2z9jt4Q0a1TpK0K2UCU6OF3Mx9MZcitzsL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4348632"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4348632"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10303471"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 08:10:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 08:10:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 08:10:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 08:10:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 08:10:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWKv7QbZw6JHWXPF0+6rDt2bbL2g1oOSKe1d1tBu1zZ1m7iVm//NrqoBm9ik2+5IcXFT4SW27qz3uU6Dn0gkcVM6gCKPGWZTTbW4UHjx1ysALb52PAY9EI1+1v+Ii2SFguAzTKGjoIjjs9im8g8JK+wlbhwuHElkjLJBeKJRbvyncpKvv8VNv3ohfMtG1PZqSIJAVpHyzu39VIqoomDGPFwPUF9gVgdrcmI1UPHwPr3gfDA+23sIOQaySd3Pyo3xushnshB1YKNLcOMSk99okhEAwlfwl6Dgy49glmFGYfARe/96f/UgnmJZ3jeOc8ZHY+ST96kJ+l/QEqxDkgOU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVlAKhsph34ee52wgTsE3z4eWXgM5GI01bxhIxOorP8=;
 b=WCDX0bHZd5TlLnXp7NVq2mjW1j1JPB2Jaslh++IwcU0/DuZOZr2sxRNWbIpq9v/5snAzzrNhv39MCQIjAfkFYVcf49X4Yn0fHYXQOeojGNVKfG7v4hJ+p+FCrwRaMjJ4nMCDwB0U/f2T3Y//rkwq2880BsfsTb70m52iY4qwjOcy1IgyWHXmTD0YXqAOHuwxCi36oKO7S7LhQzgKRa0nlMEvL/ZcfhmoBr9D96gI23kfykXmWebmn7RDgPa+CcDUEi4e5/bhwaCnsPaeN09E1zCdWA8a8feKbdh08mA/N3Q1oiPgAwRpAlzcik4VoQiyuPKl09yF9b9FrON+UPUTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Thu, 7 Mar
 2024 16:10:42 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 16:10:42 +0000
Date: Thu, 7 Mar 2024 17:10:36 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Robert
 Elliott" <elliott@hpe.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH iwl-net v1] ice: fix bug with suspend and rebuild
Message-ID: <Zenm/BHOwpwovNjI@boxer>
References: <20240304230845.14934-1-jesse.brandeburg@intel.com>
 <ZeidykgnELeMx6xm@boxer>
 <ZeigQdj9K6CZocbL@boxer>
 <02751cec-c273-4120-adad-6ea16a86532b@intel.com>
 <9662b26f-3bba-41fb-90a6-3a6dbf98b5f5@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9662b26f-3bba-41fb-90a6-3a6dbf98b5f5@intel.com>
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 7301540a-cdd2-4871-d050-08dc3ec12381
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sl20AYL6abhqyFTvlIdUJY0B2EIP3WHp/tXqWdlbWxFI8F9zkhyyz4nSdE5qV0xP2jwyAnelALDQWh01NkSR5SMX/9t2OCzIQDiTzyXtbbrXt3vfpvnUHnkklrSwbW1lnlOxFYOAAovGwpXIKNNu5oCID/jG/igwJCnn6OnOjGsIqsqC723YQQjV409Qe9RgDpNIXYFKeu5Mrkz1y0dguGzJV8i9YkQTmUS8YVZrd203EyHwGkx0pkZQ1tW8mf9EMCphxC+M5zOP1S1uCOqvJMyhj7xXxenT7tI8EberfW+7Qr8b1eyEp+4F9CHEQD3VxJqEj9KILDwVXPJeMxQ4jkhvzNpvkAkv1KF40Zh/RKLw2JuETQq5qu83Ke0CMEfk43qa7EOJ6m0K0clCK39NzjW1CgTqi/8TxG9KeMbaXeMk+EKW04xKphMiIb3LEKpgVUpLeSWlZo9JDaQpmXUneNMFOiP7o1Y8c+jddZBHwe302nQS5iUp7OGu47Rd39nNzu2+WvgrsrmIviCa73bmIzYRSBmQe6CS1B7191GB8nejOZS4dvLzYv+Un42U0N6zTA6DVzoF4gySJcEPiqJbeh4nahmeqGed288snEhI4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dqnwHnmy6H2pGiQ+OBBJz04lZgbcvc27NeBIMH7+1XcWFLd5wZ2Re+ZAwsot?=
 =?us-ascii?Q?OYFUicJrvr+mEUbo1KNzK1yJKXB1Assyb2cG4ZIUCUk9Roclr+Ut9g9OYcDR?=
 =?us-ascii?Q?N8Okr5P5EjGphx618k522cNKy0iRqtNNRez2CciNuk+FIef+CLdV7nIAkWoM?=
 =?us-ascii?Q?Ajr15QhXiE8fzhPnh77rOv8Vl5dmk5WCfxfZPeh/0xEgNIE2vbr/TvbvZUem?=
 =?us-ascii?Q?50ANxerlpmZYpPGh9aEiLKfy6w1qEw7NgupLzMT9Fqy/c5+DtoNSxtykx9Ci?=
 =?us-ascii?Q?suGc0jrkFPQJPTz+RqcUNK0kX7yuZntYi4x0HzG9vRypcJTzGSVAjQsNUmt3?=
 =?us-ascii?Q?3HuZAUwf2JNOgU3upTxfzwd1UrHG54RT13rEYFDK58gHTWOfmz1HO/qHCVXk?=
 =?us-ascii?Q?Y4ImgYagEbP+qGI/HE7jqyE9rKHSxvsz9QNTDsdVZNj1OMidNrE1AcPEtiNU?=
 =?us-ascii?Q?W5Oj7VJGfg0ZOm2GmTPDKp5btUy4gi0d1Q9KX6pd7LqGR/Qg70T+9vBYlZ9f?=
 =?us-ascii?Q?ZqGMaKZVS2zzzS6ggAPJRlRAHS8p8jNkyPfItnBwGOPl4NukLMtz0wlrnbon?=
 =?us-ascii?Q?+bz0Zl5Y8zSqqGZI193cqRODJdxwPDhR0ck/8o/+eXn0Zu7XMJbNnmrfS89Z?=
 =?us-ascii?Q?81jpXsCYePuigv8/t0zOhWIWkppXflaY8SaH3iFq+G4Ge7hv1sPbuydcHIxs?=
 =?us-ascii?Q?sZ5+zQwIqWZNH2dcqvBJlVc7qUxk4kZ0HG3l1SGjKR8sqAbSIVsRThwzn4a2?=
 =?us-ascii?Q?8XMEBjrAX5CalEIVZ4McixpgybfVewhCYvGCfGMJxBNH7icnUvIAqAM6F36C?=
 =?us-ascii?Q?iP5AgaXeYyuHejdJwqU7RYJGmVX76Toofga8jYpGkqEd9OCgerYNbZtobSzU?=
 =?us-ascii?Q?fush0csNUm3YXvfVleX/LTqnFnWXdRjFVxlirQecUjbJMwDeUkjVP8H4JSkS?=
 =?us-ascii?Q?YnJ8Cx9TW21FwHBgRPRYi7AE5/kWDvYa1dZPhuT5tCaaZy31KAUXW/MfZ9aZ?=
 =?us-ascii?Q?zriqaYTwFMoeNVhFCBTs0XH1zg1Z2IQV0aFJssZXjaEZNhoSL2TMq5cFLKcS?=
 =?us-ascii?Q?nxR25fU/KhKMk9n38s1MaTvjZbpUv7XdNj4bSdNyCZuysPss0waZu2RQ22LL?=
 =?us-ascii?Q?GsIL8HxyW2AO1C+V25laPYFBvjxp4IO2wKub9PKebBtqGVc5suwzefiQTO4j?=
 =?us-ascii?Q?Ap+T77Wbz2Cjm+Rrx3BpikfmfWDa6pzLzYrhgvnvpBjkiR/qTBPO12U+O1/E?=
 =?us-ascii?Q?9V9hrirZs08pHQ/YhOu9IXYKHGnA9tg3UQkbPHCujU1Pq95ZtOjdpYUYIA86?=
 =?us-ascii?Q?Pn4DqCu4+b3nmU81tHcTdrFITwnzKDNsIXUzyHp3RBkr56QNtKVfPBwao/HJ?=
 =?us-ascii?Q?bjlVcHBm4U9eaDFSvGEQlMCNLohZnR71CMO+nvQ5tMYmu5NicJ+tAnoUwH0W?=
 =?us-ascii?Q?A0ABdJDuTUI+PNyZrPDm7bFT6JeDRSSDOw2d5NtiXVBTnvwAcUntp9UifXdJ?=
 =?us-ascii?Q?HgSoe1gXchhc5pdaMi6Xk+1nE2TIAI45Le4+RMnkOVSspIuOjU60o1Jk3pmj?=
 =?us-ascii?Q?Bt0NHz8K2zAfI0DC8vHycF4p9KNeBRVNvmlYhoXjD8I7aoqN0KK07RWo/wHF?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7301540a-cdd2-4871-d050-08dc3ec12381
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:10:42.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTsquqg2SsD2a8GxGdK7NPoHIh+7XCC4u0+oHvf1/pYTIOAViAGo6VWAkBOx5Sg15OBwYERinkUdEJ2RMsy+NkvkKrkeFmrCPAJdjkOhUys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com

On Wed, Mar 06, 2024 at 05:41:10PM -0800, Jesse Brandeburg wrote:
> On 3/6/2024 5:33 PM, Jesse Brandeburg wrote:
> > On 3/6/2024 8:56 AM, Maciej Fijalkowski wrote:
> > > > > Fixes: b3e7b3a6ee92 ("ice: prevent NULL pointer deref during reload")
> > > > > Reported-by: Robert Elliott <elliott@hpe.com>
> > > > > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > > > 
> > > > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > 
> > > > Well, that refactor of config path introduced lots of issues. Could
> > > > validation folks include a short list of tests they tried out against
> > > > tested patch?
> 
> That's a good question which I'll follow up on with our team, but please
> don't let it block anything for this patch.

Blocking was not my intent at all, just raising a concern regarding this
ever-lasting issue.

> 
> > > 
> > > Sorry, I got confused and now I saw the same thing Simon pointed out.
> > 
> > Thanks, NP! this thread is for v1, and v2 is already posted with the
> > refactor just moving the CONFIG_FOO in patch 1, and then the real final
> > version of the fix in v2 patch two which switches all the intel drivers
> > over to the new macros.
> 
> oops!
> 
> FYI v2 of this change was posted at https://lore.kernel.org/netdev/20240305230204.448724-1-jesse.brandeburg@intel.com/
> 
> Thanks for the review!
> 

