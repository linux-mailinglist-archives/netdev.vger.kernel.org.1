Return-Path: <netdev+bounces-42973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59A7D0DF6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBEA282469
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463118040;
	Fri, 20 Oct 2023 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aqq3pUIV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE1179A2
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:56:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DF10C8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697799378; x=1729335378;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=C3nWSIKkMOh30ilFk5pjK79dRrCqZzmi5xm8YmE9Kaw=;
  b=Aqq3pUIVKFTxdAI8FiHqbJ/MrqNZPCLng5w2o3vJPh37eNwfnpSoHGUd
   ww9WGeM7TvaMlzSvHtvWs/6TLpgzmDV+ltlRMJG2vxAm6MWAbA1f/s3XO
   V5uj/PjehvmJ+AlRcT0f8u4mb2/oXhas6rmVSZfzLHRJF/sbfiyHlpnP6
   Tx4U2MOQE3cs3Qmm3JtElY+8jy6bvYFT8eBMTf0NcVAtR8gv8mxZeb/oU
   xzpRBTbvm7xVPkSyDFkk6VN8IDDu+71eBrUURKexZO0OH6lt3wwdlH6E3
   UwIYlpuqK9IlhIP7Qekdo2GuXzrH0B8b3h0gxqkHvPpxlZWQsc27V9CuL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389338797"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="389338797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="786756660"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="786756660"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 03:56:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 03:56:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 03:56:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 03:56:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 03:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm7z8wTcQC0tmSH4uH1B8wb0Z6VewLz0ax3BU5GMjdWK21yzzyrXa0kYcxKyY4m3AknFZslsAY7rF9PfBwRo6HnXJn2PXWBWEXCNb657tuRiELId+CmPcCwKqqM6kN/3r6QuQzVTR1BZOmouF6TtW/yhqWtTb2u1ajWrraHaxoAjUxLfqLwoHjePGywFuTfDkPVzNChkB+sThMVt8q3xEAkYxT+H6XFG7OjtBT76lIAcGC2svSNZD4xw1Mjk9g9mzryvU3TaikV74RSvaEHZRuuq3STkriH8CYMuy/x0Bf+3j9dy7Se8uZH1LqL6asjBomqx6Yp0i1WPzwgpFLTzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvCEjUzbeb16O7/7Br5gfopdxxmhgjIP7VluzfjFNIw=;
 b=h8TGPs40jAPZmVyoUu/5dDZ+hwVH+n2/zu2B4UGrQhpfmz3TzdDan2EmQ646RKco0p9chqp9TOqBq0ne+titf8f6b+3bevtPlaIEtRVPGvZgoHuSj4CsxRhg/YbtFBr0u664csjfSOTOGqa56pqLjO6AyH27A9GtxI6whbTbuxRg0WPdQSNCAA0KXmPENOuuJbfXTC9qgNnfl6jNHHDS1p7gHFQDbEgkeN+a9Iha924K24aYJ1eHmxfHMm5tRyQEUJfFEcK6rbtK8OfJfQKvNTt6KSb+OlA9k2Wlu4cE5HeeEblWGJpITR+koPGrvKQR4uwvRhr4uY7tDCDK80Qczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Fri, 20 Oct 2023 10:56:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 10:56:15 +0000
Date: Fri, 20 Oct 2023 12:56:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	<hq.dev+kernel@msdfc.xyz>, Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net] i40e: sync next_to_clean and next_to_process for
 programming status desc
Message-ID: <ZTJcyes2Zaug6dlD@boxer>
References: <20231019203852.3663665-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019203852.3663665-1-jacob.e.keller@intel.com>
X-ClientProxiedBy: DUZPR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f857d10-afa4-48f6-1fd2-08dbd15b2dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLZbdkNavX3XOi1FKnc3tgSqbo4ohu7BMjdQXrNFZoVT3hW1/wc6cTKEoUFh/syuq8wmp6Ja/+u2zzm2I2tAqvDYUoTb/LTHB62F/WkogJXoAX7v51vnFJpJ4fswTLk4DKLP1sbO0u4x95atDnSYMVI48/y14kfOIQXrvxYDJzJO3TZvAFef9PRsK0Wu6TTe8fV9vdMToX+KUykTVrUFASJaOSMT7JQeceZtuTmORfFOcy5sfYONCNCL5lmjS64CQL95KlV+uDjFXph8rzUC6Nkhl4DccQqEMzP4e//n9gnQBb3CsjFBnRNak5yx4cf4rBbpUh0C1Fg4i9s+xdXsbu6arVU9sH/MB1ExLQ/tvc2hbxBmNxE7YOM1msXk3c21htgaT7rkd3oEd0twp7B2nRbpx47YRSaCgtdmfvn/ahJgdB75eqBXTTx0uFxnt6QLJ2POV1ECnuthjjokskGvCY+3Rmr4jOTlkDY40BJaBdm2ueNCL6f5ZiG7qLVzOZKOvswy+tCY8PltCXSNc6I0Mr9TqH6d/bHyTrLi9wkgdv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(966005)(6486002)(478600001)(316002)(44832011)(6636002)(2906002)(66574015)(66476007)(66946007)(6506007)(66556008)(4326008)(33716001)(41300700001)(82960400001)(9686003)(8676002)(5660300002)(6512007)(6666004)(26005)(6862004)(8936002)(86362001)(38100700002)(83380400001)(107886003)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aXF/MVBfkPA7exzZ15dGxw6PoVNriuXFG2jB21LjGANUAVL/6vk4rFoZEs?=
 =?iso-8859-1?Q?TBZTWknoZutf7Px5fMXjGK7c6NmvU+AMajqS2HAzKfwE/8l4K6wgP7GZE9?=
 =?iso-8859-1?Q?zOSSJ6i7Xq2ELCijrDXSZEOYmS9ZqHR7Jl8fEUyECjKi3ZVwxcpbPtdcLs?=
 =?iso-8859-1?Q?z46dtF/gJxF11qbmEkwD+v4jevmlbP0OM+AjTsEEUBEB2pMqoayTCQ2F5u?=
 =?iso-8859-1?Q?EhpQ2/JqA9UqmGeL/tUYGbnBhpOLM363abWWtmniMpT5a98xKPd/oUSGT4?=
 =?iso-8859-1?Q?C69XUOP2OLTJoRZckV8S3KldjuN/r1+28mK4k6b8JytsHdZFcOnF1R8TqW?=
 =?iso-8859-1?Q?J8zdIpS0n5MhvjJW2Ta5ehZ3JZrS1kWDuNJcqFbBfR4V/Ky1cFiga5iUbI?=
 =?iso-8859-1?Q?UMctPHVHJ2wrOx2bAks4BZWxBppn9N4d4zzOSJAer2LER1LMviKUVDkkaV?=
 =?iso-8859-1?Q?wZ+rkR4A9LaZAT/tb7JHTCpgOxfMrNpRovoMjnsE88r7Qv6vEjy9qZbAYp?=
 =?iso-8859-1?Q?GwEF2ThI6qKlMVqgZOWMhFurFnNok7/+jQ4o1/8ED/vpWUNOgnvYtW4LiS?=
 =?iso-8859-1?Q?l0nCmVhrbweA9Zs940UmasCg2MHgJuvEW45s+9Euk3I6u2+nslTG6zas/C?=
 =?iso-8859-1?Q?4Hc1UL/GVvBnsVGFmAeANX8xeOGgyJpdWUIxih2adXJ457VIvdlavq8AB6?=
 =?iso-8859-1?Q?I6+Z5M5SL0b71Ij9+l753bFKjB8RohP6KMSxrYEG2LO943mH3HxNomNTim?=
 =?iso-8859-1?Q?AUMhv+j6jF1mljTHG8DG8pFCUPO6si7rrwar7kNUBNwsHSVxetjGRlHw72?=
 =?iso-8859-1?Q?txqSBHPDML1/yIuVqt7vghpSe46Pusbn7Y0BxgU+XYnfiMkC6WiRLtRpPu?=
 =?iso-8859-1?Q?RFw796y2tCL5zrIKRkVPfIuHHt8boCoQzfBnfSlTGO8U2QXegB0o66jC2O?=
 =?iso-8859-1?Q?IdgkViXUYlyqzx0Xil2BI4OT75fne0VLsuaYVY+7CfKsZSoRJCnjEnJsJt?=
 =?iso-8859-1?Q?SVNEnAOOKJsjJOfntLHJxK3JPK7By1rMV9v2n2NSVCId4viLAML0UQ87L/?=
 =?iso-8859-1?Q?FGK7EIigCxzkroDQ8+JkixCExSgDmcIQIsgkzDXkElJi1gTZ7Ch7iJHB1v?=
 =?iso-8859-1?Q?CO80tf3vlw/YeXq76nf4wKzLi1d/mwYlNTR7ZOiOaxx2L/3yVw95L0qx9U?=
 =?iso-8859-1?Q?aTxxL4cPkRXDB+2m7APzKTmLD13NuPsp4J0sfH6rquYPiscMz4Ktpf8KQm?=
 =?iso-8859-1?Q?5v3KXVF70U5Kakb+XNqwQpSTg17Zo2aW86PlABzWgLoAqmuRLr/6Ahrh/C?=
 =?iso-8859-1?Q?dTImxmjaPngQrDcIQKDUkLKYhx2gC35FGNEgUt2JBYVALqK0V3mrg488kv?=
 =?iso-8859-1?Q?szD7ggWWXR9/lzcGxBrJDZEPMh5j5Zw+rNnLLuvwVvRfNaiI3DlXzF9QUP?=
 =?iso-8859-1?Q?QMnf00VurPzstQmHG/g1eTGxVq8H5dFjrVj+wIl6tkudL9X95wb88BP9vu?=
 =?iso-8859-1?Q?ixPyjLliMKGq+p0k30o5W8xgeGoHVshUYbhVXzpsKmh0iAyfYfWwn19rdc?=
 =?iso-8859-1?Q?MmUcTAF6XHlFzNg8iZ82a8YoYwYXGIGndE9fvxYmwA21b/5+v3XWqHrNOm?=
 =?iso-8859-1?Q?NF+G6BV01EBmQizAzAEQ3TFvTIXtgp5B5Ekcfu26WIOZN4cCfmMlzshQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f857d10-afa4-48f6-1fd2-08dbd15b2dd9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 10:56:15.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HezW3uoNWaTlpg1W9IKfp5HzDcHOZFvWvACLEWg3pCW5LZwqYVdMMrJnEUT2azd81C8fIm6fm4T5tdnrRYBVMQDpQUDF99HlT52OjJw+IQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-OriginatorOrg: intel.com

On Thu, Oct 19, 2023 at 01:38:52PM -0700, Jacob Keller wrote:
> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> 
> When a programming status desc is encountered on the rx_ring,
> next_to_process is bumped along with cleaned_count but next_to_clean is
> not. This causes I40E_DESC_UNUSED() macro to misbehave resulting in
> overwriting whole ring with new buffers.
> 
> Update next_to_clean to point to next_to_process on seeing a programming
> status desc if not in the middle of handling a multi-frag packet. Also,
> bump cleaned_count only for such case as otherwise next_to_clean buffer
> may be returned to hardware on reaching clean_threshold.
> 
> Fixes: e9031f2da1ae ("i40e: introduce next_to_process to i40e_ring")
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reported-by: hq.dev+kernel@msdfc.xyz
> Reported by: Solomon Peachy <pizza@shaftnet.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217678
> Tested-by: hq.dev+kernel@msdfc.xyz
> Tested by: Indrek Järve <incx@dustbite.net>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

You missed my ack, so:
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 0b3a27f118fb..50c70a8e470a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2544,7 +2544,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
>  			rx_buffer = i40e_rx_bi(rx_ring, ntp);
>  			i40e_inc_ntp(rx_ring);
>  			i40e_reuse_rx_page(rx_ring, rx_buffer);
> -			cleaned_count++;
> +			/* Update ntc and bump cleaned count if not in the
> +			 * middle of mb packet.
> +			 */
> +			if (rx_ring->next_to_clean == ntp) {
> +				rx_ring->next_to_clean =
> +					rx_ring->next_to_process;
> +				cleaned_count++;
> +			}
>  			continue;
>  		}
>  
> 
> base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
> -- 
> 2.41.0
> 

