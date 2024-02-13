Return-Path: <netdev+bounces-71338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9085304B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E0D1F29A92
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C65D39AF0;
	Tue, 13 Feb 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPmUv4Bw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC93FB06
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826366; cv=fail; b=LwhP9WdoI8j/YD9X/23pyg0cCrXOTEEHtk4/VXINaXyGdkH4djYjNLZuikw/HR042+efiG3SGxaS9bfcGmqCWgACm9A9YkX2cl718LUXMrY/3PDH2V9CGq8y7dEyRL0Rvmr1IGez3skBk+tMRrtc6okjLxvFvWl1UQ5dYZFXuA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826366; c=relaxed/simple;
	bh=+1RzyxN5WNaD0wptMIwa8w8/6TpdminB+sEy17/Du2Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RDCOvdBU/AhdFhIjqm6tbzYgWrIWMy6b0s9aR3uLpbbCLqgZESRU2ou7wMWuNOL6kr2gsOWr/1XqjhpROxOK4bndpyqX+7tn6gmEpFE98VVfqZOgNi40gM3cTgccaOKtk4lFjRK9uavIUc8E22es0BfMqIiXPFkEfprBE4zh4gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPmUv4Bw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707826364; x=1739362364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+1RzyxN5WNaD0wptMIwa8w8/6TpdminB+sEy17/Du2Y=;
  b=KPmUv4BwP4eOSQwFJgTrtHTjBWn8+zcj++LS/tngBXlCCHyB7vW+1lqx
   01Eghro6D+4USoRl+3vkls2qrO4XEak9jEH8WuRxoXUp6KYY/RYzV9Nxx
   bmv+KB5EG97iY+lOQReSGmIxgXeFez5IZjwM+/FfjEO9osHrR4UI5TuUH
   caVw4tysqNQIrzhfEMVpAkUfJdBMLEoVb7J50iqpavGGdAwEs4q9MxD+s
   pQJott4gGLsvoBJOHb0m4a5AvMR6/kiBds6/ZC3NE8sVA6tVJM9iRf8fN
   zFAlZqj3v/RkucxxSexyuABuHgwnYFEQbBXuW/XILrFNYT0NjnoqGHi4S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1683404"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1683404"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3242463"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 04:12:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 04:12:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 04:12:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 04:12:42 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 04:12:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrwtnslM+PdTY/zZakzdWyTw7AbFYMpr/eN710v0C8vMh5WljV411tZf9iZ7k0btbKHsVViv2Wf8sTB97Nqe2lF58mxeLAAgXu+Qck7hfSPQjLpwJA5qqFWN4NK8eEjqA/VvQw78HgdZ5+U7NMsVkWV8bsP3YdnvjtVvRtFxnhPUsjrHWtPNtVdxgOd8kgD4Zbh7tmFvmQ/FrZIMNxK9nUKR1S+Ma7/LHqWw1LRRwn9jw88m6doAxLD/XZqtji2Ht0TK24eNCOhr2WwEl1k0SVP+Ws93DebG3wEeu/xj1PL+clCkbwvMGegYcaPybveeQFwVRdMTYk45iT5eZTWumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ovy002KePXBW+s6EKoIIo2mna4VGjnIFtVPtvom2Cw=;
 b=fxQEvQKDgCHFx6JXCgh7YSCSoskDnytgsZfuo3OxLSpwC5hsS1M110luaTnhq/JAfh+7ycgoMOhoqNnZpBbWOtN3WDl8z/5T1fJFx0FP+SU2MjgTYOUuFMuHXHW9PXicOGUjJ1+1kmxESZnUmlxQQt+T3FJbIv/Xq9+R+yQCcjjqcPajVf16imNB0ImT2Xf3MU3hxkc2YJ6zlpz1D9aCikNNh6JuwsN56Y/UAAejiqzSbnn4EaiwgvXvVDAoDEhkMhxV/gMyQM1T7kgqCV/o8rbF8Kh7wmUBusjWrV0oIyLa/7bdOdelGYmxiYxDhCn+djwq5aMaYVX/2HjMW7wqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by IA1PR11MB7318.namprd11.prod.outlook.com (2603:10b6:208:426::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 12:12:36 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::5e2f:2e89:8708:a92d]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::5e2f:2e89:8708:a92d%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 12:12:35 +0000
Message-ID: <fc773151-4f80-4a85-8dc6-5c2aa4e0a8e6@intel.com>
Date: Tue, 13 Feb 2024 14:12:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] igc: Remove temporary workaround
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>, Naama Meir <naamax.meir@linux.intel.com>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Neftin, Sasha"
	<sasha.neftin@intel.com>
References: <20240206212820.988687-1-anthony.l.nguyen@intel.com>
 <20240206212820.988687-3-anthony.l.nguyen@intel.com>
 <20240208183349.589d610d@kernel.org>
 <ce4065d5-656d-4554-b288-94105a3631cc@intel.com>
 <20240212090846.18c517fc@kernel.org>
Content-Language: en-US
From: Sasha Neftin <sasha.neftin@intel.com>
In-Reply-To: <20240212090846.18c517fc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|IA1PR11MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 797ea49b-b324-429f-6c7d-08dc2c8d1069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OV0PasF8Ij+CDRU1ywl4oSC5eHGZdF9AZKWgBjOMs1dIwNWflJIKtfSb/Htn9tfkZqDDKA0Zq4tLEcWRuMTjWNa/weC3r1oN+bemiQxHrakpTIQnFOlY2wlqI58joterNfjn5/tdx0Xb2bXzfcU5BNL07KwEV8HihlWjUv7ciKgbY29MxGEQV75e92pPrAAm7y44wSzV21pajkQrAf910KZVXqamak0OaydcrAROh7dQAUnXsw/ZPkzg1kk7LSTImkHR4KtewLZwB4E29h+cdW5YgwQyrwdwuySvjvh0K/gbkulpThZC2vB2FdgwhW3h4efzWWC31azjd4zUAl51AmXlPyJt+m+65Zk4Kn1e7htp8/vZjVlQjmgWOmXMANbGKY6JyAiQYEToqj7W6Dcu81fmPKmpoFH0i99hpKYQj45M6A2NcMpfdwWxfaUwuTG61nSwNGSyOyPgeYO8V+1r5qF0dUG5ew1MrHMfl4Xq//0YzONVRtZU9Cu/OM/cpIBenLXLcuFwXhZnvGxdi9sYrzz6sFVJZtTzL/4SFlloi+JEhHYY2TPCn/l/9j4q4eaL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(6512007)(6486002)(478600001)(41300700001)(44832011)(8676002)(8936002)(2906002)(4326008)(5660300002)(6506007)(53546011)(6666004)(66476007)(66556008)(66946007)(54906003)(6916009)(316002)(83380400001)(2616005)(31696002)(82960400001)(86362001)(26005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW94MFpTRVZtVHdIcFRUWHh3Z0E0b1ZtTjhZdVplYUU3SzNrWkJUUFd2aUpy?=
 =?utf-8?B?bTV6Z0dyTzZQZURXK29DdDlTQjBYdm80TmU1NU1CU1ZFNnhRVFFiczd5NHNW?=
 =?utf-8?B?ZWlkKzIwQllYdTZXWEtJTHB2VWVzSzBOWW1XWC9pM0pPM3hpenVDRzBCR1pK?=
 =?utf-8?B?ZDQ5N0NWK1J0Um01anI2Tmt4VjA3R1JXQUlVSTNuZkFqQWtQZktSMFM2SXpT?=
 =?utf-8?B?MHMxTlkvZlUxZXdvekVBRkl0YXFVSEY0Y1MxazdTK0pQZ0cwSURlZG5MN2Jo?=
 =?utf-8?B?Mnh1S3ozTmE3L3kzWWVBelNBd09kTDllWkY2Y09uQ21WdHgxZ3NVOFprUkd5?=
 =?utf-8?B?VlhUN0VIQkYzNzljNlNzQXZSWTlhaERIeFRBQ0VqL2VpK29SeXVZUXExTE10?=
 =?utf-8?B?M2FOS2JOdzhuQmhJMHkzWXJNRHpUeEovTHI5d3M0MDE0dDAxN0NsZ09lNTJ5?=
 =?utf-8?B?bVJpNVlnQUpRZElLeHB5MWw3dDROdFJGc25EMDhUWW9CSzY2T1ZMODdadGRa?=
 =?utf-8?B?eTluL21IcFBVY2VKVXM3UGVOQWNTTVBNandXOU5Yb2pYcDdCQ29hTmYxbjgv?=
 =?utf-8?B?YjNCdnZCTXhLK3VHVGtGTkhRbXFaaGlwd3ZLRmNmWGRWZVJQa3RhNDMrVkc0?=
 =?utf-8?B?aStRMVh5L0pMRHVUOHdaVGxXVURRRERQZVlOdlNrQVVrck1KT2NnODZnSUZV?=
 =?utf-8?B?NGVjWmxLcFVvSkVxL3l5S0pqQ3BScXRCY25Fb2kxK1JUM0lubE5hOVZmaE5x?=
 =?utf-8?B?MGR2dmJvS2hzTzMxN0lldU1VUU5nd1Q1eXRzUGZPcExQWlpxcjNDMUtzUytE?=
 =?utf-8?B?ZEw4QUNtdHJDTDVhUkNDYXFsdkM3cmJDaGR1d1VQS2hGaXI4cGFjdlFXZUxR?=
 =?utf-8?B?anhvMVg5dHZtZHE3NDRaTXNLQWFEUUJyWE9QWnBXOWxBNk4xY3N2YUFMUGR1?=
 =?utf-8?B?eVNzM21VNGJzN3JscGhvdVBySTFUQTdLL1dZMnlaOXh3Q2l5eGhJTXFYd2RP?=
 =?utf-8?B?ZWxYRHBrQUpLSlg4NkR6MEpmMm11QW5EVGJUclZ4NUd3cjl4b29QeXF5bWlh?=
 =?utf-8?B?TDdjY0F4WDc1WEsyMWgwVzlZd1VVNEpIelBpN05TT0hqRUNJQVFib3p0amhh?=
 =?utf-8?B?S0VYMENuMExac3R0Y0pCYnFVS3dEQUpneDl1aWFNZm01NUJvckYzazg0ZVV1?=
 =?utf-8?B?ZklzZEVab3JnaVVxaGZUa2JlQ0JITzJpNEJhNlkrMVRNbDYvVjE5VmNnTFBI?=
 =?utf-8?B?YVhJQnFVNE03cHg5dHlYUS9kUlUxZ2I4azRjOXhlWXdReDhxN3hrYmo3UzZ6?=
 =?utf-8?B?SXpVZC9DRDZlZXdmK2lLS0ZCS2VnMTRoSGgvQ2sraEV1d2g0WjBoVVE5NGVR?=
 =?utf-8?B?RW5VMnROTzc4cVpoZTQxOFhKeTJnbGJTNVJIb0RqcHlyRkp5Tkl6K0o4MXM0?=
 =?utf-8?B?QjUvampKcWlFOU1BelNkSHNqTWw3TURMbG9GT1ZvV2RCOVhMeFBYS05jQkc3?=
 =?utf-8?B?eHdIV2RkeFdvMmVVbmp6ZGpJV2U4aVVGaWVTbWxZbFBLVHBPNEpiMm5Wblds?=
 =?utf-8?B?MVJ6T29ZM25WRmJSS2ZObHNGc3orczVQMkpYdWtSbXlZbUN5VUlyTXRFVkE3?=
 =?utf-8?B?czFqRmFyd0tTZ1h5T0l1c1hhQmhjeTE0MGJETkRaNWhBZitKSVArVnJ4eUNT?=
 =?utf-8?B?OFYwMkNMRHExTk1KcmoxQW1ua1g3UUE4bEllS2xzSDlrM1BEajRhNW9rRGZk?=
 =?utf-8?B?aHhzL0RJTFh1aE41LzNSb2Q1UkhoeThJN3pWSmZKczdWdGNrMTZLZ2pHZmk1?=
 =?utf-8?B?RnlsREhEYmdSMlVwN2xieXFPdG8wQmt2SXlrZUZpWldjcXBYOENZQkdWMGhv?=
 =?utf-8?B?WmJCYWhGS1pYYVhKVHprRUQyQ2ZNTkFPbUtUSjAyK1BZd0M1NXZxZWMydmlS?=
 =?utf-8?B?OTh0cFY4a1ZSbmx0SUlOVzBQb3FkU0d6ZEFNZjVyWCtjRHlmRk4yc0lwYjU0?=
 =?utf-8?B?UFpiNlJLeXh0cUpxaGFtTmtGanBjeEFCNVlnQjIrSUJ1RHJkYjBhTm85MEt0?=
 =?utf-8?B?QnhTWTN6OFplSlZzaXZRRGg0aGhobGtXZjd4OXB0a05Oa2xsRWRCOVRqYVhR?=
 =?utf-8?B?dWozNDNjSVl6SC9oRlR2V09tSGcwVFAvNkRwc2Rub0NjRFprb216M0hmbFNr?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 797ea49b-b324-429f-6c7d-08dc2c8d1069
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:12:35.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya3MtmtBA6/6UiF+B2n7niuI05MixXSBSy7fdhZi7p6KQY9LlGEeaW4Z8lHDPi0hNeNMF/TsiT9sXD/OKMJjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7318
X-OriginatorOrg: intel.com

On 12/02/2024 19:08, Jakub Kicinski wrote:
> On Sun, 11 Feb 2024 08:53:36 +0200 Sasha Neftin wrote:
>>> Any more info on this one?
>>> What's the user impact?
>>> What changed (e.g. which FW version fixed it)?
>>
>> User impact: PHY could be powered down when the link is down (ip link
>> set down <device>)
> 
> to make it a tiny bit clearer:
> 
> s/could/can now/ ?

yes

> s/link is down/device is down/ ?

I meant to the Ethernet link. The device is enumerated and PCIe 
configuration space is accessible. (ip link set down <device>)

>   
>> Fix by PHY firmware and deployed via OEM updates (automatically, with
>> OEM SW/FW updates). We checked the IEEE behavior and removed w/a.
>>
>> The PHY vendor no longer works with Intel, but I can say this was fixed
>> on a very early silicon step (years ago).
> 
> And the versions of the PHY components are not easily accessible so we
> can't point to the version that was buggy or at least the oldest you
> tested? If that's the case - it is what it is, please repost with the
> improved commit msg.

The version of the PHY FW is easily accessible (ethtool -i <device>). 
The problem is that I can not point to the specific buggy version. It 
was on the very early silicon step (it is what it is).
I will add the oldest version of the NVM we tested..

