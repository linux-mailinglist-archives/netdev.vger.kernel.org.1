Return-Path: <netdev+bounces-13424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A973B8BE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA11C211EB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244B28BE0;
	Fri, 23 Jun 2023 13:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1F883D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:25:36 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326182694
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687526732; x=1719062732;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PF+/RO7p9VEy+cUI3P2/HrlibzJs4eaZdLUqz8wg21A=;
  b=G+Cf/m+hKgLWooKf9ytrBIW1hM9c6ehohA98MF3TMgLtF9IlLtH4LFUB
   aBweXYarIJiqq4V8n/7kvRSSDHZKIgHmffa602Rh47yQl1Yjtm3uYIjtA
   m4KsM8KqAp6eSc4/ZgcffTKBmV+DpzGWhOVU898C5jGlVB9uiwNzVSXLO
   5ZsQQ/z49kQljJMip4GEjGQorhFaOMClXlqu6aZ+S/jBRmFgsDLtf2cug
   mPcC+eh1ndc2ZSNzl/tnnou1udKA31yH1MihiWjD9+iyZPyGUkmlxnu5t
   y0eJjXZAwv836nfjrA+s3K9e/ifSxhAh52h0DaZ64ToWFVSx65r3hZXSl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="359630546"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="359630546"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 06:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="715318174"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="715318174"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2023 06:25:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 06:25:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 06:25:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 06:25:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 06:25:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je/A6qnIB6PxnB59qX5ej4e1zOIYYICAazbtldA+MRJ1UZniUXlg60h9mD+RPKjGy8IOSb4LBB1CL+PQ/8wYpqFF94KXtXHk84cOa6EO0V39ETeWQ+ztbNvLo5UScqFSJrOiLvmUSDMiJOEqC5widcOM3pT7/7PMs73uVLtxT7tftknop7CjbOjhfjRuZ7Q5XbvPaPjBlGZkMZbwwpUu4BBtqzob/hO5XG1AdfeBu9Ij1SDn5h2BBAYNpONorLKoHwNvRITDz6VT3Z7hI7MiP3PBRfQbi4OD4x+IFXuIewGrPrTtXpwx1qQ5TchXIG4tBv8Rtq/nC9aZKO3zd761AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vlgZn+0VEobh5uyZaGAlQ1/WI4qQcX+D1NQBL1LCcU=;
 b=CTQKMl6u6ivLkvdLJccRcKEsg7kJ4QX758JrgZuc/14Phk5slzApmHHg/NWZdp+rnKTTSBRVTHfAvhJRBwL7FEiHey0eH9nu3lRSEO+daBwZaaJy6MZsYg+EJYKvzw3yIQeXTubW4bicNZxb0EMHcsW2/RdriSqhdT+Gt+TbcpEgWTwQ4vRxpGpgJ2HA3aZcXnJmgXBxqbRxWpUoXi0+lYOgaZqSFmDW8qstRbtxZIzhtsEc5FhMiZ/RqWUIJlApUwfe+qK+/7KjKsHJjf8pIMdmn9/2y5MExcwLujFLQRCrwRllccn8jRKOs4OabwtKMUgw/zhN3U21TM7i4A+DWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 13:25:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 13:25:27 +0000
Date: Fri, 23 Jun 2023 15:25:19 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Michal Wilczynski
	<michal.wilczynski@intel.com>, Simon Horman <simon.horman@corigine.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net-next 4/6] ice: remove null checks before devm_kfree()
 calls
Message-ID: <ZJWdP+RPaF+mYYPM@boxer>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
 <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
 <ZJVyiOwdVQ6btr53@boxer>
 <ffe3bbdf-eb26-5223-c1ed-1bdbaf577d84@intel.com>
 <ZJV+dUvm4Mg1QNeR@boxer>
 <4278f944-57fe-6382-132d-728fa8c8f582@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4278f944-57fe-6382-132d-728fa8c8f582@intel.com>
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: dc23c3a8-0547-4268-6f91-08db73ed4ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVK9MYMd6miiue658uj5yo3MOhaTmFFQE4FJV6hFG76XwBnT7OBKs7ElhobQL0M2+A2h83YFSIgrjX0h3XCkw3y9pmh1Fyaj2/wedVC3bT0hQfZ22Yv3u5PrSO7PBQej9EHA5SBZ3BQvn6Pt44uc5IGvhFijzg594pcf5ulDDRJqBxTtDDu21Lk0qzG1Kp84Iqv55YFd1kojyYbdu2UeY03voC2zG2l7kUXEsyqJdFpRVeKpgRjjtoij8y4eSdzZwiEOxP7a/Qg2ri20wLzrMLn0lHFgSC47t3+JfnDC4Zh2rnU7xDRLrcAA46hfXz0I97glBTSALAEUuVKJNSL9ieo9ydBsxyd7UPWJJuiWiLz9kJNd2ovStttClwdRTMWHdg5PY0y5SwwZV/BD6Gz0w9IZAE7TJNGSQwO5gnBz4+XnHVJyqNpZ9EuIvw7MDkTvDX5eC10mFCY7za6BV8AXfu7au2iOQ1tp0wh/ubF8789O9T2Yq73JQUqzHBZ6cZHlbQID9gfGOT38lJi7FtaPNDwH30p1rHiW9ButdrokpGj5+tVu4hHhfSig476cEi280OatbUS3DOVsFEI6c6uqjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(82960400001)(38100700002)(83380400001)(86362001)(6862004)(6486002)(478600001)(6666004)(966005)(54906003)(66476007)(66556008)(4326008)(66946007)(6636002)(8676002)(41300700001)(316002)(6512007)(26005)(186003)(6506007)(53546011)(8936002)(9686003)(2906002)(5660300002)(44832011)(33716001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PcGeq+eB8/lhcTk6GCwLdpjofI+LQiZDno/9jsD2QIGOx7G6OGBlByDceFo2?=
 =?us-ascii?Q?M6uz+Y8SS4lVnbnN9T/8C2af8y++7wqrOY0tsPGS0XuZjGISrFbn1jflhZIW?=
 =?us-ascii?Q?UGHop+vOxQ8T9P89T/zJSa+9nTeM4yvsbTY2unqYS2V+iKrucjcySl8IPYci?=
 =?us-ascii?Q?I4GrFBLeCas3IbP/0xbtedqb+AKq+uTBVHIvflpP4FPNQOr0ReDtmKH/Iy8k?=
 =?us-ascii?Q?HnKZgWocv6K9kIsVgO8AP7z+CDfLxkXNRY5NN2SESMWzH+qzpxf541snTNuM?=
 =?us-ascii?Q?hpCUo2skvFQaN4OpNaY/OjMJX0sIpqTrGCwB8DrSNtIXXL2NaZNfHVGmZqHk?=
 =?us-ascii?Q?sWteTE5RlVB6R8tQeiBaYFpO40zm0Yp7tBDkYDDLMamFBPgDFihRrcB2AasB?=
 =?us-ascii?Q?idQKN79c43iiUi0fwLkUBxU+b1Q5Zx7KKV02aysQaFbwhTmbBkJ/XIHlmSzV?=
 =?us-ascii?Q?1+3bgJm6HG240GN6G8wdAnQsbbMpX4im3jfwRHepGI6Ic3a8c8dMtxoA4MfC?=
 =?us-ascii?Q?AwtgXXnk4YyfXZ6mPCZKiL6RJjlQYGvUBvCFWtADhK2FeDGgFsaFDWKyX1AR?=
 =?us-ascii?Q?fOgz6VXgDVvJrCuQTGOvfsfZ9fxXuLJxjDNDj+RfH3KPXnS61HcbGX03PupJ?=
 =?us-ascii?Q?pT70S2RAH8PN92lz/0xTVsMn2aBM1ynxStue6k4Uwn827992JMEdymM5gLet?=
 =?us-ascii?Q?H6uCKXs9WYLvTlvcF0Bfx8w+uQ7V/pRs+lyZUb1BN/GofOZPTTmy54748XRN?=
 =?us-ascii?Q?9iJyFctie2nMkL2R+2wx8m148EIkbLDppJHY7gSfJmblWBya5UuoB4dyqEhr?=
 =?us-ascii?Q?QvnxHQQWhW9z7RFU3Ln6IwwoKdy+7BUBgYABJBTPghjhjr0SF38A8dQFmDNV?=
 =?us-ascii?Q?r7H3HXqAYjqybZqgaamsRnGl7BPNBt9ETz37cW5GLv8uGj9z+KzB3WGfEnbw?=
 =?us-ascii?Q?n7BFYOPFEWOnHwPoH8AqoHjgnvbHkpypKhZfBYYpSS31aTF9rpG7DVEihRrA?=
 =?us-ascii?Q?i9Tvn8xFsgQCr4QotwEmfLLaDf0GYCqYVORMWMNnCzaDZxjpHaUDPH2IbwJZ?=
 =?us-ascii?Q?ZEdX/3kqdZL1kA9XxzIs82S0uDZA+UvX9KuPrBkWITxA6TAuohwua4hiabTs?=
 =?us-ascii?Q?Fb8Dl2jSwAUi76aqjJ7qRgTeX0+pZ2SZthDRhnTwlJqAZKE7j8svHEmlECKZ?=
 =?us-ascii?Q?kAEzG0lwYkah9E0cS/J4YSJU09S9cGqu8Ei2/jC3/zOGmZtP7woyFLPrryLG?=
 =?us-ascii?Q?oglEBXh0WdaaabXwiaCt8SvHMar4xRD6KCmHGDSBIQsKBtfA3quoMuthg+Mi?=
 =?us-ascii?Q?fLIqOP3N2FkjcJYtdjNGJIeDqBzW2ApakbnKjV9FYR47yfa2qwC6NENLN+fP?=
 =?us-ascii?Q?xOE9122+kMmPUWYdibiL44v6nrJ628quet09+Z0E+j8KAoMblQMSQNtHUR/J?=
 =?us-ascii?Q?D+IXkZXDmLfhRHT/uL+tlGv5wd7mZypSzN4m4bY7zBxSp1kIcP/RSmbz/a+Z?=
 =?us-ascii?Q?Ok60jr40cl7TXnUc1x6/v0ZyoA0udq5DcTIqHZctKcYfaxFOnCGszXDMVY8P?=
 =?us-ascii?Q?xCE4hZAqzgsn/DVlF/TsrhOMMdcLyfocYGxLW66LzKbu13Jd5RFaKtGqzNCA?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc23c3a8-0547-4268-6f91-08db73ed4ece
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:25:27.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpvcWM8RbiJZWTnho/39namhFM07fBDQzxbu6Zp6uEy0I6AgWD6bux/vJ2CIsd9617wt30CeaKqeVtcR+Goa+J6J5Su8czaDq08xCAbX2sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 03:21:30PM +0200, Przemek Kitszel wrote:
> On 6/23/23 13:13, Maciej Fijalkowski wrote:
> > On Fri, Jun 23, 2023 at 12:44:29PM +0200, Przemek Kitszel wrote:
> > > On 6/23/23 12:23, Maciej Fijalkowski wrote:
> > > > On Thu, Jun 22, 2023 at 11:35:59AM -0700, Tony Nguyen wrote:
> > > > > From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > > 
> > > > > We all know they are redundant.
> > > > 
> > > > Przemek,
> > > > 
> > > > Ok, they are redundant, but could you also audit the driver if these devm_
> > > > allocations could become a plain kzalloc/kfree calls?
> > > 
> > > Olek was also motivating such audit :)
> > > 
> > > I have some cases collected with intention to send in bulk for next window,
> > > list is not exhaustive though.
> > 
> > When rev-by count tag would be considered too much? I have a mixed
> > feelings about providing yet another one, however...
> > 
> > > 
> > > > 
> > > > > 
> > > > > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > > > Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > > > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > > > > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > > Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> > > > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > > > ---
> > > > >    drivers/net/ethernet/intel/ice/ice_common.c   |  6 +--
> > > > >    drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +-
> > > > >    drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
> > > > >    drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
> > > > >    drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
> > > > >    drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
> > > > >    6 files changed, 29 insertions(+), 75 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> > > > > index eb2dc0983776..6acb40f3c202 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_common.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> > > > > @@ -814,8 +814,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
> > > > >    				devm_kfree(ice_hw_to_dev(hw), lst_itr);
> > > > >    			}
> > > > >    		}
> > > > > -		if (recps[i].root_buf)
> > > > > -			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
> > > > > +		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
> > > > >    	}
> > > > >    	ice_rm_all_sw_replay_rule_info(hw);
> > > > >    	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
> > > > > @@ -1011,8 +1010,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
> > > > >    	}
> > > > >    out:
> > > > > -	if (data)
> > > > > -		devm_kfree(ice_hw_to_dev(hw), data);
> > > > > +	devm_kfree(ice_hw_to_dev(hw), data);
> > > > >    	return status;
> > > > >    }
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > > > index 385fd88831db..e7d2474c431c 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > > > @@ -339,8 +339,7 @@ do {									\
> > > > >    		}							\
> > > > >    	}								\
> > > > >    	/* free the buffer info list */					\
> > > > > -	if ((qi)->ring.cmd_buf)						\
> > > > > -		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
> > > > > +	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
> > > > >    	/* free DMA head */						\
> > > > >    	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
> > > > >    } while (0)
> > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > > index ef103e47a8dc..85cca572c22a 100644
> > > > > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > > @@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
> > > > >    	return NULL;
> > > > >    }
> > > > > -/**
> > > > > - * ice_dealloc_flow_entry - Deallocate flow entry memory
> > > > > - * @hw: pointer to the HW struct
> > > > > - * @entry: flow entry to be removed
> > > > > - */
> > > > > -static void
> > > > > -ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
> > > > > -{
> > > > > -	if (!entry)
> > > > > -		return;
> > > > > -
> > > > > -	if (entry->entry)
> > 
> > ...would you be able to point me to the chunk of code that actually sets
> > ice_flow_entry::entry? because from a quick glance I can't seem to find
> > it.
> 
> Simon was asking very similar question [1],
> albeit "where is the *check* for entry not being null?" (not set),
> and it is just above the default three lines of context provided by git
> (pasted below for your convenience, [3])
> 
> To answer, "where it's set?", see ice_flow_add_entry(), [2].

I was referring to 'entry' member from ice_flow_entry struct. You're
pointing me to init of whole ice_flow_entry.

I am trying to say that if ice_flow_entry::entry is never set, then
probably it could be removed from struct.

> 
> [1] https://lore.kernel.org/netdev/ZHb5AIgL5SzBa5FA@corigine.com/
> [2] https://elixir.bootlin.com/linux/v6.4-rc7/source/drivers/net/ethernet/intel/ice/ice_flow.c#L1632
> 
> --
> 
> BTW, is there any option to add some of patch generation options (like,
> context size, anchored lines, etc), that there are my disposal locally, but
> in a way, that it would not be lost after patch is applied to one tree
> (Tony's) and then send again (here)?
> (My assumption is that Tony is (re)generating patches from git (opposed to
> copy-pasting+decorating of what he has received from me).
> 
> 
> 
> > 
> > > > > -		devm_kfree(ice_hw_to_dev(hw), entry->entry);
> > > > > -
> > > > > -	devm_kfree(ice_hw_to_dev(hw), entry);
> > > > > -}
> > > > > -
> > > > >    /**
> > > > >     * ice_flow_rem_entry_sync - Remove a flow entry
> > > > >     * @hw: pointer to the HW struct
> > > > > @@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
> 
> [3] More context would include following:
> 
>          if (!entry)
>                  return -EINVAL;
> 
> > > > >    	list_del(&entry->l_entry);
> > > > > -	ice_dealloc_flow_entry(hw, entry);
> > > > > +	devm_kfree(ice_hw_to_dev(hw), entry->entry);
> > > > > +	devm_kfree(ice_hw_to_dev(hw), entry);
> > > > >    	return 0;
> > > > >    }
> > > > > @@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
> > > > >    out:
> > > > >    	if (status && e) {
> > > > > -		if (e->entry)
> > > > > -			devm_kfree(ice_hw_to_dev(hw), e->entry);
> > > > > +		devm_kfree(ice_hw_to_dev(hw), e->entry);
> > > > >    		devm_kfree(ice_hw_to_dev(hw), e);
> > > > >    	}
> > 
> > (...)
> 

