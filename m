Return-Path: <netdev+bounces-44143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD17D69BA
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 13:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EED0B21003
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26F26E2B;
	Wed, 25 Oct 2023 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYiu5eM2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93C210E2
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:03:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC9A6;
	Wed, 25 Oct 2023 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698231827; x=1729767827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JSI2u2AGFjf0KDAt+D0o0AcAzwcN/a19lKrO3xVjyl4=;
  b=RYiu5eM2jp4gepL8Em//IpGOfQvdknI6jBU+1H1k4Oi3OqsbjFjI5qwo
   l7rB91lvV3zVDMEAN+iiHZM++2A/LAlqnN8rG3VEpOq/3TmvCLGUh3MgE
   beQGgF8UbZRNwNOh9amNyWK2T+10JCzg5+k5FV+RBMhL4MyVDAgVl8O4y
   YkEUjuQc0zkz0ZxtJvdvGi3VIkvfcbTT2nYavEK7Oo3BLVQmfFwSCqiZl
   lKvrYmqZfnYfT3KM13XSf0UnkC4Yf7UPBXdngSnrDBcq5JbPPS12AwuDc
   OngkmPA2+RObQSA4XVpkUZZ69m+UmS+vQBr4Zz+NT1ZFreyht40wYjANO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="386167542"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="386167542"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 04:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1005981575"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1005981575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 04:03:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 04:03:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 04:03:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 04:03:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 04:03:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVWCnDLCczSNs6/URDhQ5EAgXWaVCIMR2m/yue/vN9X5gAl/ZsMdts65xKSRYtSI66813kaCuUdJx3YVpMsGsGTBTGGb9ttMCSbrIsKugvIGKDdl+7Ef6urM/hQU01JIxqRuG/2oH8nxTIaL1ma3ZH3uEUo7chUTZufb+MAXHoj+dMRw9WOZSvH8jKshrULOppkLe+64LlLzs46CfOsNSXrDCKh03olEi1tqRNJdqBDatmKTdxFQq0OsBYcNq2zLvnk3PHTbZz9uTAgun1xyRyWH1Vd2xANiKQzsarYpU4ZYb9wpx0ln8T+u3yn4jQ34qSCZlLLPA0MU6W5ld/qmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmu0qa9tPCxS8VbZuB7hhqUQSVgF8On8rhJ30O3r6rg=;
 b=PGbSC0N3OK1d5Z1DljP9pqTBUMd4nz7hDS2GPI+j3E8Iy3y88hUvAwBJMJEtoA358zeiHs9mnbxKHHrb0JGGjs0og5zr+mU95rJuW5+YEUF4qXnVffMM6NKtrztXwxpIUjrzZSRaZKL7ePK72ymGsDCNVmimP3UZVJAIJZ6ycowbUi9TxFwLBSDGvEFzJfQ3uPU2ObmO96cwHjTceFWYmuwybCtu76hMDwjvK1bNJ/rifD2SNeWUx6WOJoO3/GIQhOoHnLkmIem4Hi2abSL5Urbs5OrlxLnxNG/dRR/K7ZVCwcyzZHaG/4X50lEDwzJvsk89XUWEgkmdSkzKmU+rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 11:03:42 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 11:03:42 +0000
Message-ID: <389ecfc4-dfd7-4c56-b18f-82565e059914@intel.com>
Date: Wed, 25 Oct 2023 13:03:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: Delete unused
 i40e_mac_info fields
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20231025105911.1204326-1-ivecera@redhat.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231025105911.1204326-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae12fe9-68ad-49ab-8c72-08dbd54a0c72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7TmKg0dWTR7Oe7sQn51iaIRwnakfjWgvSQZbxjPW1NcXpuvq+/5dJRS7vDjV4Lv4Ca6i7oxRU1H3RkswXe1QuEFjM+9wKpGHuGVYrRWQbTwlQ+umN77kLtoYhzoS46kW1VqhM94wb8yApHtkG3jMH3WXB7Wb+B4P1Rh7XU/nJP2DifpJvqgtU6ejZtN8NE6kUdialgClmDA9/k54iU+ZlmWzulGobgiKM1UGRGqWSNiwdOwZZB4cHiEwpvVoPKby/cL3/YA4IWmLlHRnSemecRrkdDISry7jqb/Mfm3DXTQdxV6qY2DHtptc7jGo/4dzFiBbJVvDol89SD6Legl7Jg1Mu5VfBH2Sy7k3EpN0HsiwcmWIZE+bMf/v6XY5sr6XAbCZJ3acBi4kA99aTXzXWdvyZ9E3hemI/dJWvymjQDJvNbr5c6JUXRPwkAaNsLQxVGWGDYkwCCk2FOyPV2eQlz11w3j2dTXDxE8+vS+O3oSGy+3FLp0+KuKVflqpB/+NcCpm6hna/bEUzBgQo844N7teSJ/8Y2tbG1E5TglTz+ui2+ZHlmBi5twxW+XVMQpABLWVUyHiVkyF3AXlRub1/EmDF17t2Gl5i0k7X1ssxBYrj0/wVyrte2l9Uhq9Pxr2X8QAd8p9zsYewqOk7F5kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(26005)(6486002)(31686004)(83380400001)(53546011)(6512007)(6666004)(6506007)(66556008)(316002)(8676002)(66476007)(38100700002)(82960400001)(2906002)(66946007)(36756003)(54906003)(86362001)(5660300002)(478600001)(4326008)(44832011)(41300700001)(8936002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVpWnVKZGhkUjMvYy9xUUloQTFaSlI3akFmTVN3cXBOZUlPbWZ1L3l5OXRm?=
 =?utf-8?B?amR2TE1kMVA3L2hHOUhEMVZBV0JGbmphcjh5aFRqb2dqU0xLZ2s4UzN6Q3Rz?=
 =?utf-8?B?VUJxb0hBemp6WEdTNkxZdFZ4T0VjdE9RWkpjdU9JSThlZGpZekZQKyswYmF1?=
 =?utf-8?B?R1VxQUxpUG45U3k1SmsvMlNGM3FEZ0Q0RDlnajhTZjZtVnVKOE42ek55YjRG?=
 =?utf-8?B?aHFjd1htY2RJZ29IUE1UcEVONDlOanRQbTlmalJtdEs1UTc2M1JpZ21IanRZ?=
 =?utf-8?B?MHU0WVZVWU1FVHB1MGl6YXpHeGhnNnpidUlyakxlbnJySE5sY01OZGJuY2Ir?=
 =?utf-8?B?aGNDSW1EMVpuQTlTOFo5aFBSMkZYeFhaaXNac1BJdDRGNGdsTDhvOUVVdWhh?=
 =?utf-8?B?WmpZejYzTVdITmhzVi9UMlRWbjRBRTZ4dExBd0VyTTdZYi9rem9sREU2OXNl?=
 =?utf-8?B?Ym5IbUJoWkxTczJ3Y2J4VERxNm91ME9wQ096T1lmSUhwRFZEdEl1ckVXUVd0?=
 =?utf-8?B?YTI4M1Jyd2xPS1AxNW1HaGRBTG9qbnVyNnpxK2dzRXlzZW1YS2QrVER3cE4w?=
 =?utf-8?B?OWtKMC9xYk43T2haYVhIT0dybGVMMHgzNVlZVkVRQWZUOHFvVUpoRCtsRlhX?=
 =?utf-8?B?L3dZMFNuWksyQUdSSldHQzJEQkpLVVNsL0lDT3BYaVVIVUxKZnhtQzVoR0RL?=
 =?utf-8?B?ZzBGbUtQd1ZXS0tiWk5CeUZZQVdzbGdPZXF3aGZRUlM0aitPRU0wdEJqSzNi?=
 =?utf-8?B?K2xGMWk0QWdWcjRzbHNlY1ZGQTRrWkdSQ0VYVUpDOFRHbjZzb1k1RFJ6K2ZE?=
 =?utf-8?B?MzAvcklGZUhMSFl3TXREQllQTXA1cFVSSFoxbjUyam1NaTFWYzhCVlp3RlBN?=
 =?utf-8?B?WVZzTmlvc2xyN0tBMHc3MFFXS1Z2SzNNb3ZCRWlTSzBtcVJySzlzVVRKRVlh?=
 =?utf-8?B?RjBheHN0enREOG8wTkVQNm5UTDVRN244VDU3NkY4ZHRnYWE0T011ejBVcWEz?=
 =?utf-8?B?dHdySXlPQkxpUTJxdjVxajFBRjRvUUl0S04vZTZ5UDNrT0lBTmJpaXdCVzJp?=
 =?utf-8?B?a1krZnU5eFdHN0NORVdpdGVhUE1RTHBIVisvczU2MFRIM0g3WjdabUpBZjlV?=
 =?utf-8?B?MXpKSmRkZzlPaVZyaG5TRTV4bTEwWnJWVVNERUJNaGlKc1V1YnQ4M2xkc0g3?=
 =?utf-8?B?NXJBOFN0a21Ndm1UcTJpNlV1d0lxM0NJRzB1eFlBSGlBR1RFcmdDaTlNeVQ3?=
 =?utf-8?B?MG0rTTZiN2MzaW9PVkV1QWZ2Um1BdXBsR21NMU5zNEVZWHdnRkt6Z09UQkF5?=
 =?utf-8?B?bGRPTENBZmxyM1BYVDBiTWtIcVFvem93a1RrSmdNRnFFREtqODVjZW5JTm9s?=
 =?utf-8?B?NEJsS1NFRm9BaUlGOVVzMEJ1YWNSQnIvY0pSV1ZMeGNqK1hzaTZoMVo2U3dK?=
 =?utf-8?B?dFAzN0dlS1RpS0hDMXdJdUZnekNmRE9KV2FYQlJEeC9RYnM1VjY0d0dVQzVQ?=
 =?utf-8?B?QnFCSHdXOUhueDBSRjdQdjVVN1NCUnJ6VkdPM2FyR3BnRWVRK0pLSVB5UVVy?=
 =?utf-8?B?cHJzbFlBVFl0TVIra3pJVW5qeVZ3aTJhWFJWMDFJNEw1ZmJkU3pRbzRpdWwz?=
 =?utf-8?B?RXQ4c3hUa1JwZy9nUG0rbkkwaUFDVXVKcFJmbExmeU96c3FOTC83U21rVXY1?=
 =?utf-8?B?dE1UeE56VjZNczNQRVlvcHo4Slg0bUI2R1FRN3V3Rzd6WkEwd3NNVktjNE15?=
 =?utf-8?B?UXE0cnFMQ1RiSlhKcHRWcnNEWTFocE02a2RXK1RzN0kxdllRYmlsRHpsRGdW?=
 =?utf-8?B?SUhEOFBqKytJV1o1T20zUkRmQ0FyVXBOOGVaRWp3eEkzdEdqSFl4SFN0ODFr?=
 =?utf-8?B?U01VbzNwWkRvVjdLTHphUEphQnpreXFzWGpQSm1HUGREbm85b25hcURyNXpr?=
 =?utf-8?B?VHJvelJaZ2c5MG05SXdoK3NueWhIMUhWWitrcmxSUTZDbXJEVHdndlV1bWxS?=
 =?utf-8?B?OEZBRGlDUUpRNTVyaUZIS0svZ0NYS0tFeU8zK2YzWjFXWVZqY09JWUNGcmpH?=
 =?utf-8?B?bHRqK3BGWHZ1T2MzajVSUEdvbGdzWkJMekNaM2xpQklHNG1pZ1kzTmdEam9P?=
 =?utf-8?B?bU5EL2F6UHBpMlNUZkVpYTY1T0NPTkxGL3dSWkkzQllwYit2OTNUWlVYRWJj?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae12fe9-68ad-49ab-8c72-08dbd54a0c72
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 11:03:41.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STyzB1EuUJ90n3d8Hym6nBgNjnsA2acu2ngkFbxBNDOgq5WUoE4ZCxweZk8l1OHNLDjxBwkXtsRpJOQDPWLkkry9Vfuk7+VaiIFY5XoTXk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com



On 25.10.2023 12:59, Ivan Vecera wrote:
> From commit 9eed69a9147c ("i40e: Drop FCoE code from core driver files")
> the field i40e_mac_info.san_addr is unused (never filled).
> The field i40e_mac_info.max_fcoeq is unused from the beginning.
> Remove both.
> 
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>

Signed-off-by from Michal is needed, other than that:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c  | 5 +----
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +--
>  drivers/net/ethernet/intel/i40e/i40e_type.h    | 2 --
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> index 1ee77a2433c0..4721845fda6e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> @@ -827,15 +827,12 @@ static void i40e_dcbnl_get_perm_hw_addr(struct net_device *dev,
>  					u8 *perm_addr)
>  {
>  	struct i40e_pf *pf = i40e_netdev_to_pf(dev);
> -	int i, j;
> +	int i;
>  
>  	memset(perm_addr, 0xff, MAX_ADDR_LEN);
>  
>  	for (i = 0; i < dev->addr_len; i++)
>  		perm_addr[i] = pf->hw.mac.perm_addr[i];
> -
> -	for (j = 0; j < dev->addr_len; j++, i++)
> -		perm_addr[i] = pf->hw.mac.san_addr[j];
>  }
>  
>  static const struct dcbnl_rtnl_ops dcbnl_ops = {
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index e0849f0c9c27..88240571721a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -147,9 +147,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
>  			 "    state[%d] = %08lx\n",
>  			 i, vsi->state[i]);
>  	if (vsi == pf->vsi[pf->lan_vsi])
> -		dev_info(&pf->pdev->dev, "    MAC address: %pM SAN MAC: %pM Port MAC: %pM\n",
> +		dev_info(&pf->pdev->dev, "    MAC address: %pM Port MAC: %pM\n",
>  			 pf->hw.mac.addr,
> -			 pf->hw.mac.san_addr,
>  			 pf->hw.mac.port_addr);
>  	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
>  		dev_info(&pf->pdev->dev,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index e3d40630f689..76bcbaec8ae5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -270,9 +270,7 @@ struct i40e_mac_info {
>  	enum i40e_mac_type type;
>  	u8 addr[ETH_ALEN];
>  	u8 perm_addr[ETH_ALEN];
> -	u8 san_addr[ETH_ALEN];
>  	u8 port_addr[ETH_ALEN];
> -	u16 max_fcoeq;
>  };
>  
>  enum i40e_aq_resources_ids {

