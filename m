Return-Path: <netdev+bounces-69451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6084B499
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651E31C23998
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6D4132C04;
	Tue,  6 Feb 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khhHQvSK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCD13248D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221314; cv=fail; b=mGuS68dWS50ZkD/mgM9KrKFx2fnvxE+zmvTSrPnWpciifbRgsaKXzE83FPdrEL1te9guYjE8V4TkkHfxkRDREKlgARPvTmwHc59ol6PZ4KjNu1qOZrY+Pj/fte7aFjF18YYeGZsPGNjrCbA4aeu9snPB8wwmQe5LOqDSiawb90c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221314; c=relaxed/simple;
	bh=uPZKgNz71N228G3GasT8rmDNmtZkVZO1SZm44J6ZpNU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWMLrpnvGJ/PdsK9PCKe+5yBPdyi5Vkb9pJXS0hBErRmwMDeHH5Ng23UeV8Qvw7E6zCeOUbOyn5jq8nRxLLPGqKP45FA3K65xm4VcmPwVJqMnExKtYPno33MkVEB04LD0zh36/37F23Mh49ZeuHlkqThrV2L7MiofixAHbCyeS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khhHQvSK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707221312; x=1738757312;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uPZKgNz71N228G3GasT8rmDNmtZkVZO1SZm44J6ZpNU=;
  b=khhHQvSKwmuEGWKcB3Ci+6Z09UFovY7BmXTdyozF/kSEBkNoXv3sqdMZ
   Fn+km3qOtDKOyAKMcrJme8/TNzFbG5F6F4iqliLztX/5pGklND2HI3XL8
   Nj2WxCfj2+nNRb5FYUYsjzWDj30/JRWPRAN6Z6iQqb6mmIRZxoihhYFp7
   CpL/dTts+SyIzPCtm6bwnzaavoEmOEpnsBsHDnk2Y8h4lSmMFm5DrQbWv
   qujXjaTDQOH+AIoAKafbm2lArYxtCUwglLuZlNR4EWNrzYAKTBqWKXZkH
   ruAzgXTlPQj56A+DgIYYz7VE+dCRcOATMzl6vnFtBp5YSXjlQXMVGFsql
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="620940"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="620940"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1033451"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 04:08:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 04:08:31 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 04:08:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 04:08:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 04:08:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTrxDHjKOFtOqKUrp5iaiqnY+sPMKoR6LRrNJgegP4xd8LxxTizdmloHR5q7kYcQfJbh2BD6AOeMy203rEFup374ULOFOFhDJNrcSzi37/tqHn64okHGm/N9dQ3+NFWJcMa6V28wjyl4l7yfuec+PjUXps1TnJP2AsVnRuu5HHsTUuvLrl3mcDNnleirQ1hvUFODcgEi6gk864spePULuTLI51jHthgHXVs1/KswzAgCQgH+9+iGAIncEsZNEgUimbBMzgnA98QoSMI9fKSssrKQqp7xflF3PUGQoKrJ9Ha4AB9zuj679r4fF6MzC/Qsgp8x1yub9WMPavi5Pz+6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0Bt4z3ZXMbO+ucNaNbzQWNfN7uJtLXHGqD6Tw6y0PU=;
 b=OmDZET/1tSeoZXr7ID1NvdOWSFptb/ocC5zRY5kxg2V/x5sAyUhEhjnvliWvT7k0ue87Fm8gJR9iVSM//VYdnicm4zN/WAeOwbEntB5OOU/kBlfndOs0ZHUtYTGK4I4q4N1JvL97R+eb87tUvISF7wbrJ91+6li3xYKuC4u9xPeKOtb2DYbwsshBuR8wFEHqdBbQdMa2cduI8RuHUfbLI0eNFnX+rayXu3hqWOHYsbK7founG8NFx8lG5JWatwOb1WbD7KCaCZnOlBLgXatqtXVrrg3FCpmT2MPt4MzISWa3QmEF8SxRA6jll0P7u51e5+CkHnGCOeQO85jAgjpSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7170.namprd11.prod.outlook.com (2603:10b6:930:91::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 12:08:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 12:08:29 +0000
Date: Tue, 6 Feb 2024 13:08:25 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Seth Forshee <sforshee@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <magnus.karlsson@intel.com>
Subject: Re: [PATCH iwl-net 2/2] i40e: take into account XDP Tx queues when
 stopping rings
Message-ID: <ZcIhOWUU9aqU2kJH@boxer>
References: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
 <20240201154219.607338-3-maciej.fijalkowski@intel.com>
 <ZbvlltcGnSsq/Pf7@do-x1extreme>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbvlltcGnSsq/Pf7@do-x1extreme>
X-ClientProxiedBy: FR4P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c11fd1-7ece-4467-d526-08dc270c548f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUj2+Ez8wxKESHsXVTbcO5Y2IAwhGOACOR3s9F56Xw4bS9A8xKt/ArINkzmBqxMH2BqpOVi6gKStYfZf+BbGRERY/bsjHO8UxsW5F3qU0bqVCFFlTQkahjB+LOx80ZypQ480aiF2Dnx+mXVO/De1RfiEMfytjdFJ+SlHPZoukxTK04lY0OJCNTrK6y2+Bs7AB9tbuatXQEbjbFU0ySbmDiuhTVNXWf2+mYXOc2GbQj0uUBSSVY2fhJs6EdpMzTBSW4SP7ctw/fLPjTptFIhlj8+RFLpCA3bGO2yIw2eTU7KSFrpJeoGmsgtZDzgv+H3bH6JyHV0on7mN62s501w8SML03x+kakxiHN6aqk+itRbZ5SyYjYRZDKK5bjPAyBIrzWcfjpuZMhXeLqahxCfmW9Gp/fSZ0jgn1aglOcMh889Sj7km+6iX/TN+FQL/KV6z+wCserZySNF5bq9PNvpR4YXrMJMvWZ7PFOxJKKurMVhg9lboAjZbPJi4q6haOaGfX7J3gCMaEGu/eZK7wIPedfYOAZoqNR0emR6Z1Vojxpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(41300700001)(86362001)(6486002)(966005)(8936002)(6506007)(6512007)(6666004)(66556008)(478600001)(6916009)(66946007)(66476007)(8676002)(316002)(4326008)(9686003)(82960400001)(38100700002)(83380400001)(107886003)(26005)(15650500001)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0c0MeeduCF1dWgT+y7q1MTuqf+2dFCxrHPNSkoj4YzJZK8PUUanwXoZtFHo0?=
 =?us-ascii?Q?NG7NLkpvY6wXVfkWB211O2tytH19RMyNFoZeJgLqGF0ol2BTLY5wz2xruD19?=
 =?us-ascii?Q?pvGHEbbSKfJLHuHfVQsELZhw344hv3jfyEsKF6V9hkB1zJGApmLx8UhqbKxw?=
 =?us-ascii?Q?dqIBRwZGyLFvfGziomE3cSQoh0JKIaVfGWEsAQqIPylwYUrKgb0z832u5JNw?=
 =?us-ascii?Q?209wLr1MEuByy5KK3Imszx0zQvj4bKpCZgvb/wq4TQKxCFbpxb77sHhJ0+j1?=
 =?us-ascii?Q?iOkUDIBe8RgrqtOas2Qmqmh4XETI1ch+w2nC0EG5tQQI+2BzmT3SaJ+UA8Rn?=
 =?us-ascii?Q?V3ok2A3TU5S1+c+vttVFFEKDZSp8H2SQ1/r+Uc3a4Y0oza2WirdOR4zJioH7?=
 =?us-ascii?Q?fgH52cXLK0+Hw6WMSfNRnQTugBztgZhX8cLZqGih61ar6c0wu7gWQXpYmGch?=
 =?us-ascii?Q?srGd+fyO9T3t1+X+3HGVV72OwltoMLeL7BqizYmP8/YBpQzqCyZInpE3DRC5?=
 =?us-ascii?Q?467TvcAlEk6GNSgdUaRBv42+G+9zEPeYLOGwnMsaZL0TaynaIUF10LibwtgN?=
 =?us-ascii?Q?nEIF4m2JMRQmLRS6YQjtEnNQF9P+uUVxT7ud6Ro3sjmPbnore0pPwDUG6pyc?=
 =?us-ascii?Q?yH1EObVa1IGvOE3C+sBfnVtBDKGG0f/okymFuc4Oc+jN3tdAjoQgqdLt8HAJ?=
 =?us-ascii?Q?Q1AVVJPDZQTS3jhb4LO03/Vs7jMR5A00mboWBwz/st679UcnkkxAy59Rm0Vq?=
 =?us-ascii?Q?hhpZEALQAu0FLQRyb8nSX5rFpsJQRiFeqV/yH3gvwFPTpYgX3PF4wiYSBMUE?=
 =?us-ascii?Q?R8QjyUvwJElyxv1TvBOL5KQMn6kzEPCeIw1XiDo0S7A/EoqS73lDhidsPsWU?=
 =?us-ascii?Q?2Ta2kabfzNw4fBpUYCZv/4ORLrXR+t1HaIGQyWYOA6uqEhSy3GYbJF29Or1R?=
 =?us-ascii?Q?8A/tKMiG1WQ8hAQUXFeuTHglJYE5kv7kKkGB57tr9moHn7glqIN16FB27taO?=
 =?us-ascii?Q?tDWXkR+MFhoQGNOcL7vpeqthmvbGj+93785iqeU5OBXlrm7vEJbmMKzXJnuh?=
 =?us-ascii?Q?5uCfSdjp3Av+gan1WxSQJ7K+msHBaortKnyKS2T5vcgipo7Obl6syRM2rfXs?=
 =?us-ascii?Q?ech1cvG0hD+O5C0PukUQq9sDU20Hudcz05ppXxINXLII4ZavuAavPm+fFTy3?=
 =?us-ascii?Q?FSTlTux1FcYirFxq3OWN39yH8+zQKsWrtKZcXCrNMpVTUo/ZgAlfzjs8lKc5?=
 =?us-ascii?Q?O+nKiMxg/1lSpZ3T9jLp9mf9FD/4OoMZ/i/D/6AvNJz12wJXpvmuNOqYjc89?=
 =?us-ascii?Q?7aG98Bm+jxPniXY2GzMuETCJ3+3gJHFKWr2b1lrgipIfDJusCiI35qfZw2H8?=
 =?us-ascii?Q?XZMeY+ngpZuXLJOPlD6/eu9W+nnXHJqhxkbv2MeTHcm/IfSqln/dzi2HdwiC?=
 =?us-ascii?Q?R8C/tCd6x7bAGroBsDq9X6nZBVlBfwzVlsw5fOqP9EVnpPOZSVDU9rtucbxH?=
 =?us-ascii?Q?QdHzD0vbhRSVsv2mgVAxPr1xFbDIKrc+GBJaAZoy8aubF9lFrJHC9ElYqrKF?=
 =?us-ascii?Q?P4cf0gb5xw01Vb1vsyHj1fca+EuPKJ4KS7wnSWZBGbPMCY/4CkqCPKW98NST?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c11fd1-7ece-4467-d526-08dc270c548f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:08:29.2492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D6uOw/2GQke1Rj3iEbwV4wsV3bdAVM1ZsCkzztcuMFjkUU0J9SBt03cAsLeh4ZZcUXAgl7m6jbTiajfRFVwzP8XWYC0XPj7YDPMsWqAfsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7170
X-OriginatorOrg: intel.com

On Thu, Feb 01, 2024 at 12:40:22PM -0600, Seth Forshee wrote:
> On Thu, Feb 01, 2024 at 04:42:19PM +0100, Maciej Fijalkowski wrote:
> > Seth reported that on his side XDP traffic can not survive a round of
> > down/up against i40e interface. Dmesg output was telling us that we were
> > not able to disable the very first XDP ring. That was due to the fact
> > that in i40e_vsi_stop_rings() in a pre-work that is done before calling
> > i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
> > account.
> > 
> > To fix this, let us distinguish between Rx and Tx queue boundaries and
> > take into the account XDP queues for Tx side.
> > 
> > Reported-by: Seth Forshee <sforshee@kernel.org>
> > Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
> > Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> This fixes the issue we're seeing. Thanks!
> 
> Tested-by: Seth Forshee <sforshee@kernel.org>
> 
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 2c46a5e7d222..907be56965f5 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -4926,21 +4926,22 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
> >  void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
> >  {
> >  	struct i40e_pf *pf = vsi->back;
> > -	int pf_q, q_end;
> > +	u32 pf_q, tx_q_end, rx_q_end;
> >  
> >  	/* When port TX is suspended, don't wait */
> >  	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
> >  		return i40e_vsi_stop_rings_no_wait(vsi);
> >  
> > -	q_end = vsi->base_queue + vsi->num_queue_pairs;
> > -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> > -		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
> > +	tx_q_end = vsi->alloc_queue_pairs * (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);

While this fixes one thing, it breaks another ;) vsi->base_queue needs to
be involved into tx_q_end, otherwise anything besides PF0 would not go
through Tx loops. I noticed that FDIR VSI started to get Tx disable
timeouts with this patch.

Will send a v2.

> > +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
> > +		i40e_pre_tx_queue_cfg(&pf->hw, pf_q, false);
> >  
> > -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> > +	rx_q_end = vsi->base_queue + vsi->num_queue_pairs;
> > +	for (pf_q = vsi->base_queue; pf_q < rx_q_end; pf_q++)
> >  		i40e_control_rx_q(pf, pf_q, false);
> >  
> >  	msleep(I40E_DISABLE_TX_GAP_MSEC);
> > -	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
> > +	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
> >  		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
> >  
> >  	i40e_vsi_wait_queues_disabled(vsi);
> > -- 
> > 2.34.1
> > 
> 

