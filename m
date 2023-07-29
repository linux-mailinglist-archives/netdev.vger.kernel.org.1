Return-Path: <netdev+bounces-22503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28305767CEA
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED3D2827D3
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F28F17FC;
	Sat, 29 Jul 2023 07:51:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F117E9
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 07:51:07 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167E420F
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690617065; x=1722153065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2QsPGnGcwQUL3VbCpDKxsbrd5dRT9C6i0Ul8Z8Pf1u8=;
  b=mMn/fiHI1sDETVt0AcczJWKEWUhYVNMZpXkm4rjcP4JoUETwXDVY63id
   DyxHBYH4NjNuLszOvX7rcTIVpHWyz96u6vPyPgoEe/WaFncS/1tIC3luz
   v0cXkNBZlYgQHDNAKGuXZeLcdCrynh1QC50MMfZGGwlmiVFTn1c1IHLvv
   jI3+3EiRPpI0CAHYo5iZ1R44j0GCxsfhYENx+5qyJeYJx8f6zhhqPtca6
   n+TiETh2oZUcH5fMoRUId8DfLr13Xr8yXhja/vzAlhOkwct/LdPrGgKJQ
   Rj09GYLBXu7KIWxOTsFY8tvWAqhoK1W78wWwELv4WAT4p5CsMHnhLfJJy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="366211598"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="366211598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 00:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="901544041"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="901544041"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 29 Jul 2023 00:51:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 00:51:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 00:51:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 29 Jul 2023 00:51:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 29 Jul 2023 00:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMVPLSAxvGQ1H4KlYXY4+neY6+znsI1kUQDbPBGM+WoH23YmZedKNDkJ5GAnBKjQ4QMuJ1UAdmo4oaNxL+88mk/gxyHVVcgdaZ2h1KzmwtxbbCmSZT1zuTYaWWOeCZH1+b33p/jsEn4WH/IbnuMZjj0qgWlCaavziztyQPWf+vb9hUftIdN+TCL11WOKlNZEXhjh5EzqBWKqwEJqVEhprNLoYC6b+jSlRnmAB8TBD0h4GqRefdXwD/Qyhp9/b2M+lNQPF77IZ4ssaMBmZcgb3+nfbdudrP7rjpxonC24WRD8fBTXExJhIEWC1P0OxQJ1A0FiUx8hFl3ozgzabyeIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKh/eHaDLVJH/VOI4kki80QG8JfgqL1FwHaoa4jgLRI=;
 b=dWmYH+8ytgEjWbBtJY630ybSWYMHkGBs0sW/HFf3s6fxLxof54wiEx/UyQ2bE0gerO+DS/wWOqmpBHWaKO+pDU6cFKqvuhjNII4rt3ZBfRoLGA0PJ0yOTFlMs5I2U3OJSW0od0AsKzahn6gJWlWRm9K8L61BEeRimZzBf+BsPszM8Oq5+cFcFN7fHj7e25ZZRjOSNRDjUPm47SW6LpYwF72J1BNsrfWwwuGR09m7HJC1OmjVaFCD1Xu2PkYH8lT91HbPwco1jYWoTNvdraj//HpswQyvzQkP+VcOi2bIH8nMLWEnB9QcBja1saJDRC1AayAD/QOooUtVVOHBu3W1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 07:51:01 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::3d4e:c4ae:f083:de21]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::3d4e:c4ae:f083:de21%7]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 07:51:00 +0000
Message-ID: <c1f53618-359b-3500-cde5-651fd53b9d99@intel.com>
Date: Sat, 29 Jul 2023 10:50:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [Intel-wired-lan] PROBLEM: igc driver - Ethernet NIC speed not
 changing
Content-Language: en-US
To: <kkiot@tuta.io>, Jesse Brandeburg <jesse.brandeburg@intel.com>, "Anthony L
 Nguyen" <anthony.l.nguyen@intel.com>, "Ruinskiy, Dima"
	<dima.ruinskiy@intel.com>, "Avivi, Amir" <amir.avivi@intel.com>,
	<ron.soesan@intel.com>
CC: Netdev <netdev@vger.kernel.org>, Intel Wired Lan
	<intel-wired-lan@lists.osuosl.org>
References: <NaDlWbh--3-9@tuta.io>
From: "Neftin, Sasha" <sasha.neftin@intel.com>
In-Reply-To: <NaDlWbh--3-9@tuta.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: c34f6e8e-52cb-4835-c819-08db90088ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRxg6ivYE1NDzcXyVAVhVthouqtz/8h9jbqFID1e/7DOrSUgKIa85iLNIlz13nm9PdS3Vh7pm1PVBI6cAKYXO0akWPp+CTdOK+pw+agQbx/ztUUVVPfzAK1MA/+9HjssBe/OUnkL6C9vFnYBo9SJGABiYMdvmKY4V/miFwjvJ/kIH+AuUMcVNp4+gYAMT9VZy+Y2JAfSrntwQ11/5VdudAD7FhN3gC+GEG3BkDUD1qs4XAbVUSClS9YpatDFIX4O0NYHA/sIrniBOdwok0V5IYf7cAmChpE6pCN5a+A5ZZLShcC/qIhiAjHNmqBdowWHrf03UJKF6zjfRA4oRTMsQfCRRGzERMYt9pwjojXBY+jE9EKcqyQZ1/2lk484tKS0sF3Zgn8gU3eOSqFNS/7FhLln67dB6uQ6HJka+Xa+QxjACgCE70Ugd5Q1gL2w8QfwW5UbWvSHEYYEyZrQ23YQGxQQszs5K29WtvT/wPmDWIdhWUtPBPaA2BLhL3JSvJykDMIlQwnjTlLGAtMUN07NCct9i7o1JjPftOPTuNPYD5kWYk3k+wvAHmTqNKUridWS5dfF5um4URVbfiu6V0qaISeXEr6FnK3PrHWb1mJ2vAACP5spNVz8X60teoB1POb7TO1iVaNT7RYtZ4QJjloD5VO6xtfqn5WIWEkEURFZPyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(6666004)(478600001)(82960400001)(6486002)(83380400001)(53546011)(6506007)(26005)(6512007)(966005)(66476007)(66946007)(66556008)(38100700002)(6636002)(54906003)(110136005)(186003)(66574015)(4326008)(31686004)(2616005)(5660300002)(86362001)(30864003)(41300700001)(316002)(2906002)(8676002)(8936002)(31696002)(36756003)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdyZ3FObDlOdGZ6MUorVWtVc0lZUWlRMmx2eHJqbVNwakdTMDRHTXJ2MnlR?=
 =?utf-8?B?bGJnWEk1MFBjU1pnR0VueTQ3UWkrTlNicFJQU2hZLzV5SDNGbDJDZ09KZEFW?=
 =?utf-8?B?T2FvakZIeWJDTmtPdTFvMDg2WlM3RkZmZG1XbGNWbVBEb3pNSjZSZ0JFT29u?=
 =?utf-8?B?ZWNCVGU5MjlWYmREOWNuUjZpV3VoN3BwY2tCWms3WWo0amZJU0JPNHdjMWgv?=
 =?utf-8?B?ZHp3TDlTcmVOUEVTM1JLQmRrd1pXRFIwUVUrZGNSckllMXhrZEorVFppS1Vr?=
 =?utf-8?B?UTFzYjY3NUs0ZU5DWlF1REQzRlJ5R1JBZlpROVYzelhUbWFYcVA4bkRwa3pv?=
 =?utf-8?B?aWx2UGh5MHdJQmhhNTczMnNGNzJxT2NSTGdHRGgzWmtZSzNQQW5mbmZVSE9k?=
 =?utf-8?B?a0ZYOVRSZ1ZSWDdFeFNxZXlTWlBjZ2FFa3duOWJKcVluZ24wRkxsd01sMWR4?=
 =?utf-8?B?RUVxNFZXSlhzSGN2SG0rOHhNaVIvU2UyUjJYWG9ZNlZzZmRRUmF0ZTRwN3Vl?=
 =?utf-8?B?MWpwSTFtTWJlbzBYdVZpMStjeEl6eWJNb2ZXT01NNnFQMVNWeWQybnlCQ1RL?=
 =?utf-8?B?SHY4dTl1Ni9PNGtsUldIR0J6b2Zad0RWVEc5WXhucXN0MkpaY0Zmd2wybXdE?=
 =?utf-8?B?bTBmWlhFOEtEMk04U1RDNGh3ZnloVHloalZCS1pRaE5zeWV1bG50T3VPZlUz?=
 =?utf-8?B?UUZBaFh0SjRKVnVmNy8rMHFEOGphck9NSisxcHkzNWZFK0JnMnNzZkJLZ2xa?=
 =?utf-8?B?OURERllpREYrajM1ZDNEUURnTmQwQkJFOFhyQnZxejNFNWxySkM3V2hJQUdl?=
 =?utf-8?B?YVBzUTQ0K3o4ZFVoRlNaYm0wV3ZSN0xsVUYxbGpoVGR3RmZUVWs1WGR2Q1Nr?=
 =?utf-8?B?T09WaEVTU3JDMEJlbWcwVlQxdld3Ynd2dkxnMUJOdEZWNlpVNlc4Rjgvd2Zl?=
 =?utf-8?B?SXZkbnNWNmVFQm9YdlViWFVBa2IwZzBKbTBXektKeWZ2Z0JRQlo5bHlsVDhP?=
 =?utf-8?B?MmlzWU04dExiYTdCOXBqZ1BBSFI1KzZ3T2I5T2NqUjdtZzdRSGVxeFNkYnpL?=
 =?utf-8?B?ak1tOXorWmh0YWFTODgreC9HeUVJNHprWjY2UmxtQ01lVklBUlZOT21US3pi?=
 =?utf-8?B?SEFEYkhKTzh3VUZodG9lYWFZY0ZBK0RZSHgvcFZRYjNGOHB5MHZoazJtQU9H?=
 =?utf-8?B?WFZQR1VxZHU5ZlRZdW9OS2F0d2tOSVNId01sbTl0aWVDN0R3L204TktDd2pL?=
 =?utf-8?B?R2p3c3loSk96LzdWTXlRekdhK3NiNk45UENiRDJrbkJ1SmFIU2ZsT2ZsS2lW?=
 =?utf-8?B?UGllR1FmSkZtajlUTXlYLzZXaDU5ajFtNHFDVEVmK0N6YW00bGR4NVNVclZZ?=
 =?utf-8?B?TTFEd0J2NERxNzBRQW1sbjE2SWFoQ2xaaFRwTU1LazhWZnpPQzBwOW0wVVc3?=
 =?utf-8?B?akhyMkFhNzB4aHMreWlSdUJRL3RxQlZGS3ozbFI4OGdMa1ZWM0thWGdqZ0Jt?=
 =?utf-8?B?L1N1YzBwWENwK09JTjVhQTVhUGxvVmZyU0I1NkRPT0pMZ3FUVFdKVHVzcko2?=
 =?utf-8?B?T0tQNjEremdkNk9yNFo0ZmdFMEpqUWcyeWtNN1cyekt0MitBZURoZ1lsU25X?=
 =?utf-8?B?MmdjZW1MWUpRUlJ1MEUzdm0zZHRmRGRVNzF5aEpxRmpHNWNxRXJDKzFzWUty?=
 =?utf-8?B?MkVsOGtJYkRqYXJLYjNycjQwOEc5aStrYm9mVHEzVDI0S3QrTUwzNnJCL1hz?=
 =?utf-8?B?NlExWnBrUEdTYlFHYkp4bTV1cEV6cVlCMUdKUWdIbi9OL3lJSjdlNGRnQVFz?=
 =?utf-8?B?M1RKOExneFFZdXNrMzVNWFFYL1MyZkZLcCs2MVRRTFFUc0tkT05pbVVramxa?=
 =?utf-8?B?akRnL2toMmxRSi9POTF2bUpIOGRoUDJBTkhhTmlkQVNvTW1nbzVoTUtNMGFV?=
 =?utf-8?B?RXVob3ZxR1RwdzU4N2JxWHF5UjkzczhieWpuSGlZM0JSdFkrV1ZrbnhRUGl2?=
 =?utf-8?B?RVFpaUNzYkpoL2MzMVF2U1Fhd20vUy9RWmJzL3RQdTROaGhCMUxYV2pGY2Q1?=
 =?utf-8?B?Q1V4ZTBndXgvczFBckxOMm1FZ0tyUVQrRUJwZFhqVFNYLytnTUwvanRjYnQ4?=
 =?utf-8?Q?Mf97klecMjFaRY/DPqldEizfg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c34f6e8e-52cb-4835-c819-08db90088ce5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 07:51:00.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dssOiQYCMoyNZin3Yle3qB0v2VpTo+hvJW2utRtNHUeL2T3JT4g459p4bl1Wp15HnFy1V8KIOCGG2ohvg2DoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/25/2023 23:38, kkiot@tuta.io wrote:
> [1.] One line summary of the problem: igc driver - Ethernet NIC speed 
> not changing
> [2.] Full description of the problem/report:
> Trying to change my I225-V's connection speed to 1000 Mbps down from 
> 2500 Mbps as a workaround to disconnection issues, but changes won't 
> apply, regardless of using NetworkManager or ethtool.
> 
> NetworkManager displays the changed values, but they don't seem to 
> actually apply.
> 
> Using ethtool to change the speed to 1000 Mbps (`ethtool -s enp6s0 speed 
> 1000`) also fails.
> The interface gets brought down then up with the same 2500 Mbps speed.

I would suspect "link speed" is a consequent problem here. Please, check 
your setup. Why does disconnection happen again and again? Any problems 
with the PCIe link? (caused by reset adapter)
I recommend you contact the platform's vendor support.

> 
> [3.] Keywords (i.e., modules, networking, kernel): driver, networking, 
> igc, intel
> [4.] Kernel information
> [4.1.] Kernel version (from /proc/version): Linux version 6.4.6-arch1-1 
> (linux@archlinux) (gcc (GCC) 13.1.1 20230714, GNU ld (GNU Binutils) 
> 2.40.0) #1 SMP PREEMPT_DYNAMIC Mon, 24 Jul 2023 20:19:38 +0000
> [4.2.] Kernel .config file: Cannot obtain
> [5.] Most recent kernel version which did not have the bug: 6.2.9 or 
> more recent?
> [6.] Output of Oops.. message (if applicable) with symbolic information 
> resolved (see Documentation/admin-guide/bug-hunting.rst) N/A
> [7.] A small shell script or example program which triggers the problem 
> (if possible)
> # ethtool -s [INTERFACE] speed 1000
> [8.] Environment
> [8.1.] Software (add the output of the ver_linux script here) Cannot obtain
> [8.2.] Processor information (from /proc/cpuinfo):
> processor : 0
> vendor_id : AuthenticAMD
> cpu family : 23
> model : 113
> model name : AMD Ryzen 5 3600 6-Core Processor
> stepping : 0
> microcode : 0x8701030
> cpu MHz : 2473.153
> cache size : 512 KB
> physical id : 0
> siblings : 12
> core id : 0
> cpu cores : 6
> apicid : 0
> initial apicid : 0
> fpu : yes
> fpu_exception : yes
> cpuid level : 16
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
> pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
> extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
> sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy 
> svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs 
> skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx 
> cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp vmmcall fsgsbase bmi1 
> avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt 
> xsavec xgetbv1 cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero 
> irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_lock nrip_save 
> tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold 
> avic v_vmsave_vmload vgif v_spec_ctrl rdpid overflow_recov succor smca 
> sev sev_es
> bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass retbleed 
> smt_rsb
> bogomips : 7188.50
> TLB size : 3072 4K pages
> clflush size : 64
> cache_alignment : 64
> address sizes : 43 bits physical, 48 bits virtual
> power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
> 
> (repeats 12x: 12 threads processor)
> [8.3.] Module information (from /proc/modules):
> igc 188416 0 - Live 0x0000000000000000
> [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> /proc/ioports
> 0000-0000 : PCI Bus 0000:00
>    0000-0000 : dma1
>    0000-0000 : pic1
>    0000-0000 : timer0
>    0000-0000 : timer1
>    0000-0000 : keyboard
>    0000-0000 : PNP0800:00
>    0000-0000 : keyboard
>    0000-0000 : rtc0
>    0000-0000 : dma page reg
>    0000-0000 : pic2
>    0000-0000 : ACPI PM2_CNT_BLK
>    0000-0000 : dma2
>    0000-0000 : fpu
>    0000-0000 : pnp 00:03
>    0000-0000 : pnp 00:03
> 0000-0000 : PCI Bus 0000:00
> 0000-0000 : PCI Bus 0000:00
>    0000-0000 : serial
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>      0000-0000 : ACPI PM1a_EVT_BLK
>      0000-0000 : ACPI PM1a_CNT_BLK
>      0000-0000 : ACPI PM_TMR
>      0000-0000 : ACPI GPE0_BLK
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>      0000-0000 : piix4_smbus
>    0000-0000 : pnp 00:04
>      0000-0000 : piix4_smbus
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
>    0000-0000 : pnp 00:04
> 0000-0000 : PCI conf1
> 0000-0000 : PCI Bus 0000:00
>    0000-0000 : PCI Bus 0000:07
>      0000-0000 : PCI Bus 0000:08
>        0000-0000 : PCI Bus 0000:09
>          0000-0000 : 0000:09:00.0
> 
> /proc/iomem
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
>    00000000-00000000 : PCI Bus 0000:00
>    00000000-00000000 : System ROM
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : ACPI Non-volatile Storage
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : System RAM
> 00000000-00000000 : System RAM
> 00000000-00000000 : System RAM
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
>    00000000-00000000 : MSFT0101:00
>      00000000-00000000 : MSFT0101:00
>    00000000-00000000 : MSFT0101:00
>      00000000-00000000 : MSFT0101:00
> 00000000-00000000 : ACPI Tables
> 00000000-00000000 : ACPI Non-volatile Storage
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : PCI Bus 0000:00
>    00000000-00000000 : PCI MMCONFIG 0000 [bus 00-7f]
>      00000000-00000000 : pnp 00:00
>    00000000-00000000 : PCI Bus 0000:0b
>      00000000-00000000 : 0000:0b:00.3
>        00000000-00000000 : xhci-hcd
>      00000000-00000000 : 0000:0b:00.1
>        00000000-00000000 : ccp
>      00000000-00000000 : 0000:0b:00.4
>        00000000-00000000 : ICH HD audio
>      00000000-00000000 : 0000:0b:00.1
>        00000000-00000000 : ccp
>    00000000-00000000 : PCI Bus 0000:07
>      00000000-00000000 : PCI Bus 0000:08
>        00000000-00000000 : PCI Bus 0000:09
>          00000000-00000000 : 0000:09:00.0
>          00000000-00000000 : 0000:09:00.0
>          00000000-00000000 : 0000:09:00.1
>            00000000-00000000 : ICH HD audio
>      00000000-00000000 : 0000:07:00.0
>    00000000-00000000 : PCI Bus 0000:02
>      00000000-00000000 : PCI Bus 0000:03
>        00000000-00000000 : PCI Bus 0000:06
>          00000000-00000000 : 0000:06:00.0
>            00000000-00000000 : igc
>          00000000-00000000 : 0000:06:00.0
>            00000000-00000000 : igc
>      00000000-00000000 : 0000:02:00.1
>      00000000-00000000 : 0000:02:00.1
>        00000000-00000000 : ahci
>      00000000-00000000 : 0000:02:00.0
>        00000000-00000000 : xhci-hcd
>    00000000-00000000 : PCI Bus 0000:01
>      00000000-00000000 : 0000:01:00.0
>        00000000-00000000 : nvme
> 00000000-00000000 : pnp 00:01
>    00000000-00000000 : MSFT0101:00
> 00000000-00000000 : amd_iommu
> 00000000-00000000 : Reserved
> 00000000-00000000 : IOAPIC 0
> 00000000-00000000 : IOAPIC 1
> 00000000-00000000 : Reserved
>    00000000-00000000 : pnp 00:04
> 00000000-00000000 : Reserved
>    00000000-00000000 : AMDIF030:00
>      00000000-00000000 : AMDIF030:00 AMDIF030:00
> 00000000-00000000 : Reserved
>    00000000-00000000 : HPET 0
>      00000000-00000000 : PNP0103:00
> 00000000-00000000 : Reserved
> 00000000-00000000 : Reserved
>    00000000-00000000 : AMDI0030:00
>      00000000-00000000 : AMDI0030:00 AMDI0030:00
> 00000000-00000000 : pnp 00:04
> 00000000-00000000 : Reserved
>    00000000-00000000 : AMDI0010:03
>      00000000-00000000 : AMDI0010:03 AMDI0010:03
> 00000000-00000000 : Reserved
> 00000000-00000000 : Local APIC
>    00000000-00000000 : pnp 00:04
> 00000000-00000000 : pnp 00:04
> 00000000-00000000 : System RAM
>    00000000-00000000 : Kernel code
>    00000000-00000000 : Kernel rodata
>    00000000-00000000 : Kernel data
>    00000000-00000000 : Kernel bss
> 00000000-00000000 : Reserved
> 00000000-00000000 : PCI Bus 0000:00
>    00000000-00000000 : PCI Bus 0000:07
>      00000000-00000000 : PCI Bus 0000:08
>        00000000-00000000 : PCI Bus 0000:09
>          00000000-00000000 : 0000:09:00.0
>          00000000-00000000 : 0000:09:00.0
> 00000000-00000000 : 0000:09:00.0
> [8.5.] PCI information ('lspci -vvv' as root)
> 06:00.0 Ethernet controller: Intel Corporation Ethernet Controller 
> I225-V (rev 02)
> Subsystem: ASUSTeK Computer Inc. Ethernet Controller I225-V
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 36
> IOMMU group: 15
> Region 0: Memory at fcc00000 (32-bit, non-prefetchable) [size=1M]
> Region 3: Memory at fcd00000 (32-bit, non-prefetchable) [size=16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
> Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
> Address: 0000000000000000  Data: 0000
> Masking: 00000000  Pending: 00000000
> Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
> Vector table: BAR=3 offset=00000000
> PBA: BAR=3 offset=00002000
> Capabilities: [a0] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
> DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
> MaxPayload 512 bytes, MaxReadReq 512 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> LnkCap: Port #9, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <4us
> ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 5GT/s, Width x1
> TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS- TPHComp- ExtTPHComp-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- 
> OBFF Disabled,
> AtomicOpsCtl: ReqEn-
> LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
> ComplianceSOS-
> Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
> EqualizationPhase1-
> EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> Retimer- 2Retimers- CrosslinkRes: unsupported
> Capabilities: [100 v2] Advanced Error Reporting
> UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- 
> ECRC- UnsupReq- ACSViol-
> UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- 
> ECRC- UnsupReq- ACSViol-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
> MalfTLP+ ECRC- UnsupReq- ACSViol-
> CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
> AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
> ECRCChkEn-
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> HeaderLog: 00000000 00000000 00000000 00000000
> Capabilities: [140 v1] Device Serial Number 24-4b-fe-ff-ff-5a-40-86
> Capabilities: [1c0 v1] Latency Tolerance Reporting
> Max snoop latency: 0ns
> Max no snoop latency: 0ns
> Capabilities: [1f0 v1] Precision Time Measurement
> PTMCap: Requester:+ Responder:- Root:-
> PTMClockGranularity: 4ns
> PTMControl: Enabled:+ RootSelected:-
> PTMEffectiveGranularity: Unknown
> Capabilities: [1e0 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
> L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
> L1SubCtl2:
> Kernel driver in use: igc
> Kernel modules: igc
> [8.6.] SCSI information (from /proc/scsi/scsi) Empty
> [8.7.] Other information that might be relevant to the problem (please 
> look in /proc and include all information that you think to be relevant):
> Relevant logs after running `ethtool -s enp6s0 speed 1000`:
> 
> juil. 25 21:14:56 kkiotarch NetworkManager[459]: <info>  
> [1690312496.0963] device (enp6s0): carrier: link connected
> juil. 25 21:14:56 kkiotarch kernel: igc 0000:06:00.0 enp6s0: NIC Link is 
> Up 2500 Mbps Full Duplex, Flow Control: RX/TX
> 
> [X.] Other notes, patches, fixes, workarounds:
> As a temporary solution, I have forced port speed to be set at 1000 Mbps 
> via my router.

rather auto negotiated to 1G (force speed is n/a for 1G/2.5G). This 
won't resolve disconnetions.

> 
> Apologies if this should have submitted to my distribution's bug report 
> first (Arch Linux); on my current kernel version, there should be no 
> patches applied here compared to upstream.
> 
> Thank you,
> KKIOT
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


