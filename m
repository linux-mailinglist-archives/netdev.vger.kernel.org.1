Return-Path: <netdev+bounces-43694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34877D4423
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 02:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68DB1C2098F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9931851;
	Tue, 24 Oct 2023 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tzz42RgA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0F7E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:44:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1799B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698108256; x=1729644256;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kc8HWMEmooYy9FcSdtHg6rFALrDusPuSOXITsFqxiQ=;
  b=Tzz42RgADEWP8HgABPnEk1HWRPBlf+SQsRlKCAkPDxpfNOuZGWSF5qt5
   vG5kGDEYib0Io+5YFHTer7B0lApf5rnTZAHBVlgbEs8JY7sfliCK5tO7N
   lvHcKKL3tV3QtzlZN4w15UtJntFkepMKEaJqvsSldLVagS5AxSS6WQUFb
   mJbeugHl9IBGdWNITvpkuHHQXIUFaXLvikvRn7VNojF6TUL44c1rzKyBv
   EAUYnnxVPp5MsD0lr2gKw80I4iY5GxkoI2wNXCvHXAgmSzMs/YuU5Fx2O
   2bCgYmie4E8urP8YmxINPS2WGPaCLGq3gidE+Z2xFRfbBLoB2odPu4CHH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="377333758"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="377333758"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005495220"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="1005495220"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 17:44:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 17:44:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 17:44:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 17:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxd6chNbo4mFVoQpmhWVeVAXqRRDkiWiGQ13bDACeF3dVn3PlP9qvZIW6Y8dYhSgIbHBm7uDbUaKdFz1EJsHj6MDS/SsKAPIUk17ykMgsuHRlGTWN3YVKF8s8iWrLf28J77T7IkUsZtTkGGqDCzalvs/qy3nHuq0R9XOk6j8Gy4AU0/3K/dWDLhrIOIgFC4hcD27QYDnZs5HCD5mMpPGU1iuN0LCoXFv/nTh0QN5uuTc16Gr7Hjj8f3CSkh7leg+lNYHk6sx8h/0FyALx9TFyHq2G/IyC8pJM4DMQjK6lQWHxUj52z8oIbUrZvza371hZHKH4xppb9nNBdYUvvmKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJfEBHKnhXZ1aUvqs38w2+9ftewyM8ufRl+dmczEGo8=;
 b=DBWXiK/VKFZsesAjOvxjos6YiIxqLkc0eHjRTxnbexlyTOyWZypLFRBEuvmHJviLJR1BlitOxaYbAhNbAkuQFUoTptZOGqK527sQpbEycpFuxVI815rKTzDWQawZOyte1C0xgEvSz4aqZ0JQJsVJd+jYM2ahYA8yCaqGxfUuFgs/vxAJkQtM3Zp5Ejszlgf2D9g1taXGgdVOUoaqbJlSeM460tMWAc43BdYO8OAYA6K4j4NJwpP9078vWJYg2S9TJctvaSsRVwucac+wcB6DG0AXpzFXdkM1jh92OVoyj6aAEg/pnjJ/5oeBTP4vYRRsBE0cJipIKUn1v2Yfz64deQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 00:44:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 00:44:12 +0000
Message-ID: <3e9cf19b-9f04-4356-8d69-0d8a4cd9e087@intel.com>
Date: Mon, 23 Oct 2023 17:44:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: fix firmware loading for
 MT7986 SoC
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>
CC: <lorenzo.bianconi@redhat.com>, <nbd@nbd.name>, <john@phrozen.org>,
	<sean.wang@mediatek.com>, <Mark-MC.Lee@mediatek.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<frank-w@public-files.de>, <daniel@makrotopia.org>
References: <d983cbfe8ea562fef9264de8f0c501f7d5705bd5.1698098381.git.lorenzo@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <d983cbfe8ea562fef9264de8f0c501f7d5705bd5.1698098381.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0289.namprd04.prod.outlook.com
 (2603:10b6:303:89::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: ad76173a-6553-4d1f-0859-08dbd42a579c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzRPRDIhrxiEYQ3XY2xDemxO12XWjxedmdy4ttF6b0W3n7XIi1JPhSjmwCYcvXkJ25AmlP7g6jVDIsf7BCOQbkXA66jO2NYIeWN4OpGCVUf71o0CGkrbHkQIS7mjYKrJhnpmdZfGaKSAF3CsgFDz5joxppM2AG6J6fceoTj19GO1XOOM7YmRs44fDEIEaYW+oZr2l0gKB2vwptJ74jP8igExRiErlBbB1XISWTL8+0hlDNrmSAaPBFTOXcGoumzLghy48Hpi4zPQHd5FIBV+Nv77wh1iNRIOcpab8mildU6Mjc/7eUofHWLSpnHVRdsK1b3UhjldCiuM3U21mq/uqYivSFGfEqQTbejSU+IzL9Xe1DPwREdaF+zMLLEmZTPMT4T9ON44QMMNuBL6enXWAtHEUe7qY6Sve6UwACl7MeHpuGIRltU2y+bOtfVmquw+rlKc2b+gZ0qdIwWwulJf7RYQGi6vrK6PhizNMcVSYtbX7novKEjVpXVKFCGH2oZCSRZsnvcioD0QuwGrlBZ77MCUCdmAnNK2EqBEbj3AmZSzS5mmjifQcVQjAEQRLWNHdiunGSDfD+RPCvCKTqaMGQnykZJ0NroE3peh01IvmO6r5IoCgoG0mPlI3O+ZosrZR6xFe71RR1P87kOA6nlQsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(4744005)(38100700002)(2616005)(82960400001)(66476007)(66946007)(316002)(66556008)(6506007)(478600001)(53546011)(6486002)(6512007)(41300700001)(36756003)(86362001)(7416002)(31696002)(5660300002)(4326008)(8676002)(8936002)(6666004)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGhySjFGSFlvb1F1bHRjYXFiTDU1ODZpblFhbXBXa2Y4emVTOWZid2hPZFBO?=
 =?utf-8?B?aERjb0JRa2dQUnp2OGZKRGlNRkpHZ3QyRFVNWjdTeWlKSktyNTN5bG5IZTlo?=
 =?utf-8?B?V1RuZFVIRnJFcXY0MzJWMnhvay9mR3JEMTNlMkE0M1FmdUxXbEdhemwvQzVT?=
 =?utf-8?B?YXNjcFFMYWFwQ1p3bkpxcTZqVHpKRVlDaVV5WWlpclRKdlY4ZGtlUnNuWXc4?=
 =?utf-8?B?Q0ZhRDYwSjdYRTZ4TUlWT3NBL3d5bkZtd01Jb2NBdittSzJsbWlsYmQrZ1Fu?=
 =?utf-8?B?Tml3VmJBYXRMUmlENzg0MGRMWEZDUGRsWXJmY1VKZktqZ0V3ck9KOUFtUmpm?=
 =?utf-8?B?Nkx1NUdOWmdkcFYvZDhwajJoYmhDNDdyRHhRVWYwOU9zdmg5TENRSVFHYnhS?=
 =?utf-8?B?cHQzdzFIenJpZTdyWVRVVlN0S0toSWpUQ0dwb2pXM2NidXFWekE0S2JRWkdE?=
 =?utf-8?B?RjZaYkdsdmljaGlxT0dPTjdaRzVjWVdLcVppdzR5eS9pRkRnNzdqc0ZVZDJy?=
 =?utf-8?B?K3k0UFpDOWFqRG9Ndk1jTlJCOGoxOTZua3V0RnZhMGloN1FkSEVOTVUwMi9a?=
 =?utf-8?B?QzUweHM4b3BkejNoK2hxSnBiNURJTmlvZ1lLMWxwNEwzTnFjT3l6cmNUbzMw?=
 =?utf-8?B?VkdoS2YvbkcrL2tTaHBxeDhjdCtGcE5mWGZEMVFPYUI2bVNxRXBzRC9hWEZi?=
 =?utf-8?B?bVIwNnlZYnMzSGNhcTVPZHp4QklQWkxmUFY4Z0RERms4bmJDeFN2WWpCOWFl?=
 =?utf-8?B?UGpWOFdtR2ZKRU55c1JuSmYwRzVSRS9IMXFWWmdqd2FsWFlqRU9WQUltQ3o5?=
 =?utf-8?B?SmF6VDhVZEFlOUZWMlVPN1g1cE9KYlVSVDZQeHhqWkRZb0VvR1grT2tYR2tM?=
 =?utf-8?B?SS8xNmI4M1RzNis0ODBUbnliQXBYYXBEZmdwcXdud0J1KzEycHl4RDNhTlYz?=
 =?utf-8?B?QmtpV0JuT0laV0t1VnZ0YWhkTU9sQTdKOE1NTFd4MXZzZ3dIMlFrVUdRa2xz?=
 =?utf-8?B?eGF0NXJNYXVkLzBuOUlPeVZ1bk1IWDJjV3dIZmFPdXRMMnVweFd1eC9EQXZ1?=
 =?utf-8?B?SVgrZGd0RGVQMzZYY004TEI5dm4zMVRSWnc2bDJoakZJYzNSSnhXNUNyaFhO?=
 =?utf-8?B?ckVTdzhsdkl5SXBNRXRxOWxrU0kxaXkvZURUd2dpVWFncGZSbzkyM0tyQTNS?=
 =?utf-8?B?SVphVFFMaHRydzV2NE1BVFdYd2V2OEpEQUJFa1ZtMG9Rcm41TURWZTRkMmJm?=
 =?utf-8?B?Z1p0N3ErTFYvdFA3aWxXT0UyRm0wU2s5ODhPWjd5YkZKWmV4SnJhVTh1VWdT?=
 =?utf-8?B?cHFsMmlqeW8xRm55V1A4VUpPMTNobWcweGc4aUgzM1kxUGhGM3FuM2JiS3lP?=
 =?utf-8?B?ZHJBZnMrb0tVQnpFcUVVMUxVYmxNZFNrSkxQSnNGUWdPbExPTkRmY1lSeG1j?=
 =?utf-8?B?Vm1RZ0ZDd3RpYlUvSnI3SHZQckFDQXVWaTNGSFNBbTNJV0RuYytJcDd3d215?=
 =?utf-8?B?R0MrTUxRQjdmOEpYSlJsQm9PQ0o5N2tqTVhIUjJpdXQ2WGwrdGxDQWxmKzBD?=
 =?utf-8?B?bEw2RHZseFJqNE01M1QvWmJpUnFacnplbm1MYnZWK3BxNSs1RTA4WFZPVWk1?=
 =?utf-8?B?dzE2all1WUJLUVdrOVI2ZThybkIvZUwxNm4vRUpJWi9kcU5GRERLbk92Qmxv?=
 =?utf-8?B?azVZdlQzQ2sxdlU2RGVpTkg3NjRlNWM0ZkU2QzZXS1lnWjdVZEFNZ0tBbHQy?=
 =?utf-8?B?a051YTFER2ZaZE1QdTg1V0VnUHFCMnJ1YVJLSWQ3U3QrcGl2bHdJRDE5UzB1?=
 =?utf-8?B?VHBRcUdTanZkc0IvVzFtVFh5QnZDNHM2RFIvM0lQTmhIcnB1NkZxM3Q2WlhL?=
 =?utf-8?B?bjdCc0ZVc0ZidDdhdkk3L3ZlbUtlN0VuTWxSQm5PV0pBUHNVL0RQWk9iWTFH?=
 =?utf-8?B?eHVnMXpic3NrQy9zM201TERXZnovSlY3aXBjY0hSRzJ6U0tiZXZZeFhlSklX?=
 =?utf-8?B?eTlBREhFSWNQank3UnhTR202QlhyOWRWc0FXQlc0OEdjUlZHYTRxdnlPdGRK?=
 =?utf-8?B?QmhVYlZSd3o0YUV4NnJoQW0yK1M5ZGNIdFExa1FPSDc2MTlzU2hrZXRTZEQw?=
 =?utf-8?B?SDNlNWllOTc3TStYdVZkUjlvNG5LT0RweFl6c2pycERzQkk4Vms2ajdDdTdU?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad76173a-6553-4d1f-0859-08dbd42a579c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:44:12.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCFoK9E4gmFGe3ONEOyGuWUrNtADQVu2G0uNdWimf0B054yxOOxJH02fieFIuszPe0TrPa/hy3CfJezR8FQno3ETYmmTmBc2qeM8eNHimUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
X-OriginatorOrg: intel.com



On 10/23/2023 3:00 PM, Lorenzo Bianconi wrote:
> The WED mcu firmware does not contain all the memory regions defined in
> the dts reserved_memory node (e.g. MT7986 WED firmware does not contain
> cpu-boot region).
> Reverse the mtk_wed_mcu_run_firmware() logic to check all the fw
> sections are defined in the dts reserved_memory node.
> 
> Fixes: c6d961aeaa77 ("net: ethernet: mtk_wed: move mem_region array out of mtk_wed_mcu_load_firmware")
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Reviewed-by: Jacob Keller

As a sidenote, this was rather difficult to read in patch format,
because the diff is minized to keep some of the meaningless lines as
not-changed including line breaks and }.

I applied it and reviewed by comparing the previous and current versions.

