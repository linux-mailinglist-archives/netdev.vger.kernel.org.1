Return-Path: <netdev+bounces-13373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A573B5E5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63302281A86
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD77230F3;
	Fri, 23 Jun 2023 11:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853E17EA
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:14:14 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB9B7
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687518853; x=1719054853;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sgrbxbwzVV/BAn82IESc+8SwbidgwrjRFBG/3raZDr0=;
  b=BFytyGtPgG2XJeFpe4YsVyi+YA8RRbostyAfkf5rjwcOCI/PdgC7fE0H
   G5F4sAVsSLZuV76oOAiOpbejilUFYnroLHVZ76zZkN7q//0/kKXWa1GCb
   4AEGd0B9WcQe5gQULep9H0S/jZMVL4mgmWTj12YReq1wfkjn12889uoN1
   7hJzCVQQ0NbVKG0rabG/Eqy7/R21FfHjwxEzhy3ly+DNDTrqtXGvtFgaS
   Wb1V0dZKSTaNlmmgFDzLS7hwo9Hu/hG03gYKb3CPXjAjiEhcAOeCLhzaW
   bjHV00++EZ1QePFyjoWtEww87sY9fuqssKoB4m8I4X6CkiNBacURztLfY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426727565"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="426727565"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 04:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="744967018"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="744967018"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2023 04:14:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 04:14:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 04:14:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 04:14:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 04:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTqDydAChLeclcXaBZ5EmMj84lSZKkroivMYZ2yzx1Hndh80TRbrFcrFEDelX1voTq4qFEQIk7MHcM202uS74pHKm/gHmJnLOKOu8+TDB7+ukSJuY0MOXb2z/5XfdhUvc0H04x3vgqKJWTPHmXqw5qP+MYRILYRM1BEenZ6kYKWMjZMYIR+/GMecO/pnEDSpAAqXWq+Pm5VRYJOdEk9bg/3sdipanXdCRoq4TVBE+cpy4+Pa1jcg6SFxlyl1Fmvygt8WjvKagdFgO/zQjnnXQpL8JJG6+bnKhBHXkDbPk8HjparpFVVzYz3qp75aV/5X20Fpyb1cPQPxMFr2bm85mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tC8LBWfULtIYSUtqh+Sz8pKkH6OlD8+p+l0QrI7ZAc=;
 b=EH3WenBkLNeS8Mdw5OSZBbSDE9i6QCik26JNb6eRKYOct8PA9Ll8Bh3Qy8HVW3SmLFti8uGY4ZDDWBomAOyPhhcmlGsXE/i97tSyk2eh/q7nA7NI11SBUneXlALjT05xjP4JPkEGQgY2xlJUbYNZs6w+cOakPiELEbFB9YF9EXEzZXitG2hNDE6qLEKisptc8Y1E34AtnsdgF2WDDzXP9DnNO6ldomxPVl5cBEjCm9n5aO6h73YqfPBw/8DckKHdG5pGzqE0OUbbE3giC+I4PXCHkbZgOQUkmYvoiwTJMImeGyP4dLq6C4H82CaKv3SYugV+BuwwuTKXG9WKLtxhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Fri, 23 Jun 2023 11:14:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 11:14:08 +0000
Date: Fri, 23 Jun 2023 13:13:57 +0200
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
Message-ID: <ZJV+dUvm4Mg1QNeR@boxer>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
 <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
 <ZJVyiOwdVQ6btr53@boxer>
 <ffe3bbdf-eb26-5223-c1ed-1bdbaf577d84@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ffe3bbdf-eb26-5223-c1ed-1bdbaf577d84@intel.com>
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dab1190-f10f-40bc-1c1d-08db73daf6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W09O+d+mH+PQkmrUGnh2ox97+xVMwtW8e1MaOy9FKrArG+iS5ZhPWJd2FL8rc1hR3Xqs+IDDSI6bJWNUvsJmPczN1/Zz2QjtddbjBY9wInBCH9gW2FSDaQIxvBu7bFM1cBy+zPXeoHB+OwzJ7J66UVVBdc1ikzjjZoHjWOpllNLkTEo7w4VkXaRvcLtXAsrZqnou88gfmMWpl66QSxlErOwu6yp8rcZTUBbEgjCDJUnPC1aMEZVPtssFszDvyH/PU7EGibTA+teRYNDOa6Vk76MrggwaJhgacGZ21/JYBleSNt04xhyBnwLM/vA1PH/vdAnriSPRQlXD+2PJ53w5edXRCe7DRRs+PdfYOkiqBd+EnrgvGEmWzyNWAyODy/U14qpRO8rD2GBd+acB66IMXAVPnrIHcJWKQ/xsy2bCGSQTAixBcJvjC3xBAod+3kcDaXHl2HbgKcYg36UDDcb7jeHIkV7mS6gkdQE32/eyEuiXH6yT1W+9Ls1sGj0LAk+Vl90GORDV4dlv4oRFAMf+DF7KnnHsRZ26oj+ecAwYX19TPr2d01dlMvJGrXukwzZO0EeTMcSSsh/Htj3xuWhymFNezm1MAjnK5GsfRbbg0zQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(6666004)(478600001)(53546011)(6506007)(6486002)(83380400001)(5660300002)(54906003)(66946007)(8676002)(4326008)(66556008)(66476007)(41300700001)(8936002)(44832011)(6636002)(6862004)(2906002)(186003)(6512007)(26005)(9686003)(33716001)(38100700002)(66899021)(82960400001)(316002)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lpg+govz62XTbDc2l/f58Sl2ojUjgvLbBzbgkdohj+Rrr0eR0qCZjtVefgr2?=
 =?us-ascii?Q?D0WeJZ0G/W1FJVaPSieKP1EMW8JMYTAXeE1MLtJRQwOB0+ubjIP1my6Xw6E2?=
 =?us-ascii?Q?lxUYqEmDAM4x1NpLg+dLmjYqdAnRDxiQOBZCq7VpbMtWmJNsz8/uvKUqZd0m?=
 =?us-ascii?Q?l9WHfV6InATT22GM8aHAZgrpDkWjOPgnB2oyfjnhOLe0sYped9xEqGLd8mog?=
 =?us-ascii?Q?Wn3b3ZA5kzXs8xV2TPcJ79UXP4WyGndbuW6WurmBwxaQHqTsMImYcv9sWRko?=
 =?us-ascii?Q?KeU1+CSXsqs0ka53hJdHJNteHNGgv+qZXwEIFuCmQ/Iy+DRzlHdXvzLGkNpi?=
 =?us-ascii?Q?jokYZ+1G7QiwFrjk4pYeB2hBRydvVqSZBquwcuvTYOiCMoGojNm0QxQJl9+n?=
 =?us-ascii?Q?q9S10apcgpmYQcwCXnzBJ9nG4r4fRPPH4OFD7WmYi7JBAZGMD+dBGuB3UZXe?=
 =?us-ascii?Q?DhPwV9WwXLiGxRY7D/f5u0kNfS6RV/0efuEejN5ATf3MYZ0u1Cz5KdzNNfHE?=
 =?us-ascii?Q?OQrxTGswOle5EuON/5ZUe5NPsr2ki6IZUHsSCNR1iyXbM31xMRoLGRFA8vCi?=
 =?us-ascii?Q?y5mC3Wh3WeMUYn4XEPglr3zf1O8xjYVdY3usROvby2QPQwTUhQft26MaLXkg?=
 =?us-ascii?Q?bLQLLTCwNsMhhvtb2nuTQEcHsAaSu9C5wlG6Aw6R+HocxlN/q/DIsidFaDC9?=
 =?us-ascii?Q?wktz3Jchcmbw6LckvNaagjvycykljrWL/trotoK2bAMeBss6UZbZbHNHBnq8?=
 =?us-ascii?Q?am8/KKLErY7CS1Bj03paXRFXGE77pM7kyplpEas5rgok7Pyx2IoiXPxxi7t+?=
 =?us-ascii?Q?jHJbQWVyAwBl73r8nf9SRnsL7S8XpECFlU5Xia6nuXv62jLatVHyI7Jso6DW?=
 =?us-ascii?Q?/S9bTwgOSiTYrPrZgTSPWqxD0BHmsD3cBEIeco+jSjhpoiLLwF7IWTAo9825?=
 =?us-ascii?Q?HlyRTo3XPIbgzlqphBWhHxDbe+qOqYmybYsgBSpiav36Gj5fQMzoB5GugJWj?=
 =?us-ascii?Q?GfoUI/+BQSz2DJlqFfs3RvxsnsK8B92SgjfGEw7B2Cvk+dF1XSD27/uxtuwU?=
 =?us-ascii?Q?/2G5T4/T4u2XOJOh1n9CieAahmfmiBjURp8keuJ8QLHD5nuk3XHg2XrFoZdD?=
 =?us-ascii?Q?CadQpMxh4KCMNGmbPtwAHBXlR0vTpNduZPsZGJf0dRSkUxu1fFIM+NkfnwVD?=
 =?us-ascii?Q?xHnZfgs6OmqyjdE8iCb05DDuk+5bMflPVTcHhi2ISdry6IwVm6nleLldru7v?=
 =?us-ascii?Q?lGjy0ZijQi2GXvz8rGB2ZKMjBi+8PiG8TuO9Pgv0lOJw+mXDlDLPKwzjttyS?=
 =?us-ascii?Q?lHmfzrVR2NXkUlIQl5POL3861FpSwGet3V62J/sCiyCZv4txJA3yR+oXxUwZ?=
 =?us-ascii?Q?I+tgN/lAXzJ0Dho6/GCpUmDuGdItsL9nba6LK9jxVxQmNazvTRYK7VYuMDa9?=
 =?us-ascii?Q?rin2X1bPvaqfg9cf9EYn6LEl1olfiqBx4k68IKCwQGwAC34gVFkkaCUqhSOY?=
 =?us-ascii?Q?/VqA6WKLPO2b6d0/IfHzE20IPKhTXyA/hAyuezkJKyBXnkFevmsx2BgFDAZe?=
 =?us-ascii?Q?eIc3ZoFFgeGZ+vuX7D5UQy7LFHG8sDoXXUjuA8Dh13Len+J/ar+uWMbUaTmS?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dab1190-f10f-40bc-1c1d-08db73daf6cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 11:14:08.5208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihsb+XPIqQW4qaMd/ZwyNjsRcCHDpBrIkPREDhze9YbKgopjn6wFc2k1ZDMqf7kObQxa9MfjIUJLcUA2pqN7EMxZV5+RPCpoJ/sB51mnGY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 12:44:29PM +0200, Przemek Kitszel wrote:
> On 6/23/23 12:23, Maciej Fijalkowski wrote:
> > On Thu, Jun 22, 2023 at 11:35:59AM -0700, Tony Nguyen wrote:
> > > From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > 
> > > We all know they are redundant.
> > 
> > Przemek,
> > 
> > Ok, they are redundant, but could you also audit the driver if these devm_
> > allocations could become a plain kzalloc/kfree calls?
> 
> Olek was also motivating such audit :)
> 
> I have some cases collected with intention to send in bulk for next window,
> list is not exhaustive though.

When rev-by count tag would be considered too much? I have a mixed
feelings about providing yet another one, however...

> 
> > 
> > > 
> > > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice_common.c   |  6 +--
> > >   drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +-
> > >   drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
> > >   drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
> > >   drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
> > >   drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
> > >   6 files changed, 29 insertions(+), 75 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> > > index eb2dc0983776..6acb40f3c202 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_common.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> > > @@ -814,8 +814,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
> > >   				devm_kfree(ice_hw_to_dev(hw), lst_itr);
> > >   			}
> > >   		}
> > > -		if (recps[i].root_buf)
> > > -			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
> > > +		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
> > >   	}
> > >   	ice_rm_all_sw_replay_rule_info(hw);
> > >   	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
> > > @@ -1011,8 +1010,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
> > >   	}
> > >   out:
> > > -	if (data)
> > > -		devm_kfree(ice_hw_to_dev(hw), data);
> > > +	devm_kfree(ice_hw_to_dev(hw), data);
> > >   	return status;
> > >   }
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > index 385fd88831db..e7d2474c431c 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > @@ -339,8 +339,7 @@ do {									\
> > >   		}							\
> > >   	}								\
> > >   	/* free the buffer info list */					\
> > > -	if ((qi)->ring.cmd_buf)						\
> > > -		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
> > > +	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
> > >   	/* free DMA head */						\
> > >   	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
> > >   } while (0)
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> > > index ef103e47a8dc..85cca572c22a 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > > @@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
> > >   	return NULL;
> > >   }
> > > -/**
> > > - * ice_dealloc_flow_entry - Deallocate flow entry memory
> > > - * @hw: pointer to the HW struct
> > > - * @entry: flow entry to be removed
> > > - */
> > > -static void
> > > -ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
> > > -{
> > > -	if (!entry)
> > > -		return;
> > > -
> > > -	if (entry->entry)

...would you be able to point me to the chunk of code that actually sets
ice_flow_entry::entry? because from a quick glance I can't seem to find
it.

> > > -		devm_kfree(ice_hw_to_dev(hw), entry->entry);
> > > -
> > > -	devm_kfree(ice_hw_to_dev(hw), entry);
> > > -}
> > > -
> > >   /**
> > >    * ice_flow_rem_entry_sync - Remove a flow entry
> > >    * @hw: pointer to the HW struct
> > > @@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
> > >   	list_del(&entry->l_entry);
> > > -	ice_dealloc_flow_entry(hw, entry);
> > > +	devm_kfree(ice_hw_to_dev(hw), entry->entry);
> > > +	devm_kfree(ice_hw_to_dev(hw), entry);
> > >   	return 0;
> > >   }
> > > @@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
> > >   out:
> > >   	if (status && e) {
> > > -		if (e->entry)
> > > -			devm_kfree(ice_hw_to_dev(hw), e->entry);
> > > +		devm_kfree(ice_hw_to_dev(hw), e->entry);
> > >   		devm_kfree(ice_hw_to_dev(hw), e);
> > >   	}

(...)

