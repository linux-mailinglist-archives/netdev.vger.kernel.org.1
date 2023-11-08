Return-Path: <netdev+bounces-46607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1897E55A8
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F2E280FBB
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C7A15EAA;
	Wed,  8 Nov 2023 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BICp6ChM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4482D2FA
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 11:36:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B4193
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 03:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699443386; x=1730979386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pl/i4OtLpt4gb8reUJoTzp1rN/cPFkMIjHlyNZnAUGw=;
  b=BICp6ChM71CaCuHdJeCvy/D4ZpHMtDNAp03TvGjkCzk/x9TCGoUFXpXU
   UL6Ul7Usm61RP/rSqlqy/gpuFTmzhMk6q+NWFtc82oUgoopV8TFoNvn7C
   ELW49jSMc60Y+aVYaDlht3v0PpdHKeNyeJpY9KGl5qUurX2lIcLrfTGOb
   BS7IuV4rc8oWj29P90+4GQmGraVLN3x/OLL1aNV9nxrh5c0BHKUScl06O
   aKIj3mFg5QSKlkFuOyb2guCj+gG/SrLXhaJ+FVJYggZ0kGyD6a1V5vhY4
   cfpexXncRp+C7eUY747sBSxYqcT4ZQ0tp1Boem+pkTke7/q8aykAyDNFq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="392614735"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="392614735"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 03:36:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828949964"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="828949964"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 03:36:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 03:36:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 03:36:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 03:36:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 03:36:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/W4R8VIv9zv2XvfjqdmYO2K5HxR9m8jJkof5qOnYYhS3AWJ/x+itgHuGijvU+1JRBGr9sfbfSD8Yodx8PP8u90X4nxdma9BjeztW/k9A8DrJ+ee++fmeuKgh9WNEO1aA8UqPxsiISin0RB125s8suu6F82/V5ZlYKiOfm2wlrcTBUTOnLI6CDgQ3PSrTz5KgEcD3AHeB5vlcxN0+1EG9RqxFNZvJ1qTo/J4E1g87kIH/OTPtNei0mFA9F+nZFAg18Hf5tj60qWzexgJeoffH4H9Uk2kX3BZqGZPtlz4O/nsjmzPAM2ck4vIvaQNuZrN/oKajLlWFi071mIDhB/Wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uWuSItYX86sx3G9M9SAi4Z3C68sZ8QwUzqL8j0jTy4=;
 b=nD34Dm6LXWiQwAMFj5IAIYP06mYasWVQoK3Ia98NsFRLDldyjiehgCIjrV954dHtgFmLVUSt/KUZBhLvQGo7fnXP/oQVGdl2dPMEDzjD18TjI0JUG+U+JrKfDz00V8liChsYQ7tTm43lVhLDH7lTfESltbiNhXwNqeTOsNqPyg9aZRJ6jN6jb0u3UVGEJXRcPwd/fxRejPOcnUchxZwX0l7qYkwxMYO0d3riJDO/wIvU77ATc2NigCaG99ySBdXtLTq0rjnmWjOpIEtKoCUx3RFJnuiuRd8sMxdVRAPspvxssrvRetm+YwcyIsGTGs0icEmpQsj2xkHr3phXsYzsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Wed, 8 Nov
 2023 11:36:22 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb%5]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 11:36:21 +0000
Message-ID: <a0d2089d-9392-3028-1265-efcfbfad7ab1@intel.com>
Date: Wed, 8 Nov 2023 12:36:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net 1/3] dpll: fix pin dump crash after module unbind
Content-Language: en-US
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	<netdev@vger.kernel.org>
CC: <vadim.fedorenko@linux.dev>, <jiri@resnulli.us>,
	<michal.michalik@intel.com>, <milena.olech@intel.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231108103226.1168500-2-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a468f81-ea0e-4aa1-ff93-08dbe04eee21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEYvxb87wsuR4MtCsZMo0k+hP8D4HS6GbJtTMLxqian9YpM97UTP3EegqsyNyM8LOXijJ1If/GVJhcsajc25fIeoLFhkzNuVXd/lj1Xl/yedOg3y6X0FOjQoM534k1NRuuQU2f1SJJ1XdjDnagqOroOhu3PhyY+7jByRIsiAW3TJqSbNKlhy2+4V6IpFJ/EhlLIjtDLcG2W3E8mXoix5d3PwQ5JzRLi2UFnkEODh5iiA+tuQHw+lUqjCdlPHXe5NqeR+msrF9zPr10S/Ylys2+qCHoFCux6h1sQUjXeMrzVOzB0rniaTuLkSVKQUe8TNhD1hBCMUuXq7mQzYPBAvl5wlWdFVBv9qxIaE5TeY/Q1QE01CGrd+jIC5C5xoVJXQZdZjwkirdbRy+uCY6zsWHE2NCr5WUVF4hzK0VmJ/O+ypgekzDFw4qL2opu8WYzm3EBszb70JFQgqYVDZgJoT8YygRPqbBBcVAYoNu2kNZKuH+c+nCFzn2+f2egkeINbC76vCX+ZS9DuiC+PJZWltOCPo2Q7C6g9JWJfRxxW2GszkWiA74G6shDveB5+ie8OgpjPvbfQjWkg4CgDlR1VYXnP7xEtd+TqCVrbd0J1Qt99HHz/NlsoH4qozZHifQofNAQ33M9bZQnDmVEC6oJYUsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(38100700002)(31696002)(82960400001)(36756003)(478600001)(2906002)(6666004)(6486002)(53546011)(6506007)(5660300002)(26005)(6512007)(2616005)(4326008)(8676002)(8936002)(316002)(66476007)(31686004)(66556008)(66946007)(41300700001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9RMytSZHVUQVNLS0Fzajh0WjBVTGVmMVo2NGo1TEZKREFCUU92S2l1MGEz?=
 =?utf-8?B?a3BxZ2hJaXg2U1NiVGVnNFdyVmRNMkJ6dVFiN1dBTXBRUzRTcFlIR1VSaDYz?=
 =?utf-8?B?YjhBTFk5U0VQK29BajR6eHljelNIY3pHK25ESlJxeWJrMWZWOFlhWTJMSkpt?=
 =?utf-8?B?aGZMTHNDVVRUNlVHTWRFNjhJa0tEeDVTYmh4dHZlbkVMUk80dTBiQVROUXpu?=
 =?utf-8?B?cFFIRExEZkcxZkFVQ3VFMEtYU3E3R21mU2Z4VUJudGdybllEOEYwR1ZPOEFx?=
 =?utf-8?B?SGxRWnNRV3BnZlpjLzZKT05TaW00U1RzODdPb243ZkUrMy9pbnRLcG00VUFr?=
 =?utf-8?B?N083dlQwRi9qcDNwR3U0RjZibGo4em9MK3hXVy9ZbXlTeUY4N3BNL3R3YmM0?=
 =?utf-8?B?aENzWEhTZnBBU3NtbjRmS2NteU1SUHArSUJvTTFFMnpLWjRGZEIxMzFrSHQ0?=
 =?utf-8?B?OE53MUExckpEL2hmUkxLYmRkckZML2dWcjZRQUpmeFQvaG1oUmNGWU4xTjJ6?=
 =?utf-8?B?Z0h3WTFIaU8xYVZ0SUM4TUd0c0JETml6R2Z2UjZ3dVMrOVNBMU1GV1paZDYy?=
 =?utf-8?B?d2ZsR1FnOFRNUy8vdUc0NjF4V2VGdVFBbWxSTVV4RkVNZXFUSFlnaVp6Z0R5?=
 =?utf-8?B?NU9CUm1YVC9ZZCthSEJNOFNFdlVrUlo2VlpzV1crVzcrWFNuZGRCelRtWEFS?=
 =?utf-8?B?bCtiMDhFaldrdmpCems3YWxJTWgzYk51VGZhRjhqOUtoZ056TURBZklRemti?=
 =?utf-8?B?UWN5U0puRGJFS1V4MU9XdUQ0QTVkRE1TcStxRlFKelVuaXI1VkowcnpjTlJ3?=
 =?utf-8?B?S1J2N0RxTFFjbzdSdll3dGtTeGJiT2NwSWcvanF5U0hWeVlwUkFyMVVTdzZm?=
 =?utf-8?B?Zm1HMnRpY3V5NnJUWm9VWlZUekdUaVNLSVZVanY2ZlliV01YSWNQbkZ3TU1u?=
 =?utf-8?B?bHpERWltYTlhRTllOXpJeURNMmgzbkRPejRYb2dFVnBlanFOcGlUVUNaZS9E?=
 =?utf-8?B?WEhQRmZ2bE5zSmltRi9xS2RJd1hPRlhDeVh1U2dyRHd4Smt3R1lncnMzNlZQ?=
 =?utf-8?B?bThiZmIybWpmSnhJbmhaeG53ck9kUzUvblBsQUI3d3RnU2RGSjg0blhpTU9W?=
 =?utf-8?B?NTBoS09EOE41L1dIU00yd2k4VExCMzRLQk5wYTl4Ry9BdS9qdUROdGlPaFZR?=
 =?utf-8?B?SCtWQ1JveDVwQ0FkUWtEemFaR0R3WGZObGUvdS9tZFlxYUNzYWh4b3o2c0Fr?=
 =?utf-8?B?K2Q2QXIzdXN6bWFqSy91by81YmNHTW1qYUxEMEQ4YzVaYmJFWkEvRUhjSW9V?=
 =?utf-8?B?T2NRdGlkbWd1ZkJQMXpTdGZrUEFMZjl5U2NSRzFGUURmMVc0eVdvY2U0Z012?=
 =?utf-8?B?NjREUDBnTjNhcVltdHpmTVlUcURQUUtOM1luTm01ckFJcXpSMS9UcFdZRTNn?=
 =?utf-8?B?S2Q4MzRIRjcvZEY4N2gyODRWVTJ4bHRsNmJVR0ZVeEhJSkNZRzZZZndhcEg5?=
 =?utf-8?B?Nzl3bG5lY3hNaDZDaEpSWTEzVEtlOW93SVRLKzNrSmlKMnhGTmtueTJRY3Y4?=
 =?utf-8?B?TlRycHMxSUdndjk0cWtkK3ozcUVIQzhtSU10ZjNwcUtqUVpWRFE3RXRpNksv?=
 =?utf-8?B?VHFXVVJpcDJ1akYrR0l1dmJ5TzFBamo3aDRPTkhsT3NyODNvK2NvNGY0RTNN?=
 =?utf-8?B?Q2o3ZlNUOERxbjJzUExNc1RubVpEaklsRUYwazlvb2RWd3FxU3R2b09td25p?=
 =?utf-8?B?eVlWUE1oTjZhZFNKYlREOWVWSlJRMVVjYkxMTnF3UG1PbWxIS2h2ME1MS0py?=
 =?utf-8?B?Z1o5bUdIUk9PQkJmK2Vnc2RtZWJhMTZ4Kzh6RHo1UWErL1VpSkVTd245dHlR?=
 =?utf-8?B?bzJ1dEtBT0ZJalZmUGZON3ZDU0lVR2VaZmpmb1dHUEVzZzBJUGtWQ3ZweHRF?=
 =?utf-8?B?MElzT1hSQWowUkdhV0NQdmNtWEpERlFDc3JablIwcGFBS28yNzNNUUZKVkxh?=
 =?utf-8?B?YkhLM00zYWIxbHJLbnJiYVFVazlna3QxZ0lMUEJNOXJEcTNKRjl3bDl2cUNP?=
 =?utf-8?B?MTRiVjdiZW5LTnZHRW43Tmd5aGUvZnJpOHJWbHZvekdaeXdVR1h6TWdYL0Q5?=
 =?utf-8?B?M3VIakRqSnI1eTdqNCsxUXN4OE5vb1M2YTcwMGVvd2NEQm5KenlDb0puMlph?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a468f81-ea0e-4aa1-ff93-08dbe04eee21
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 11:36:21.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzkTVpS+X+Nbfk0KTHtfUogoSLD5Vlr3A2FCoIH655Giz4ycbci1wLSdzjQLHxlqBMYc46eOioY6wxH71c/lLHBhB9MkQnlv6rJhCSaCVHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com

On 11/8/23 11:32, Arkadiusz Kubalewski wrote:
> Disallow dump of unregistered parent pins, it is possible when parent
> pin and dpll device registerer kernel module instance unbinds, and
> other kernel module instances of the same dpll device have pins
> registered with the parent pin. The user can invoke a pin-dump but as
> the parent was unregistered, thus shall not be accessed by the
> userspace, prevent that by checking if parent pin is still registered.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>   drivers/dpll/dpll_netlink.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index a6dc3997bf5c..93fc6c4b8a78 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -328,6 +328,13 @@ dpll_msg_add_pin_parents(struct sk_buff *msg, struct dpll_pin *pin,
>   		void *parent_priv;
>   
>   		ppin = ref->pin;
> +		/*
> +		 * dump parent only if it is registered, thus prevent crash on
> +		 * pin dump called when driver which registered the pin unbinds
> +		 * and different instance registered pin on that parent pin
> +		 */
> +		if (!xa_get_mark(&dpll_pin_xa, ppin->id, DPLL_REGISTERED))
> +			continue;

What if unregister/unbind would happen right [here]?
[here]

>   		parent_priv = dpll_pin_on_dpll_priv(dpll_ref->dpll, ppin);
>   		ret = ops->state_on_pin_get(pin,
>   					    dpll_pin_on_pin_priv(ppin, pin),


