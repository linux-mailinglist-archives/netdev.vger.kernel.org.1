Return-Path: <netdev+bounces-90037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2498AC8F8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006FCB2166C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6E54FB8;
	Mon, 22 Apr 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOwj0kGT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8950280
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778481; cv=fail; b=rrTHJ2GzdPxtbM5SUUpzRQsIHrfsarGOED+V+egzkK9ow7a26wGGIvVmK3pnhD5AeTVrFZNj2EjDRSZdjOR1xe4BPR5Go9K0/M/N2A/OhnQmK2thJH5FJZH6bD8o3SCdjINgujpUnX8ScfyARQxtbEXI9blSIHsBRdE3o65iAwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778481; c=relaxed/simple;
	bh=bq/NgEha0FHdVWB6rAeqGSdsld/KUoWskeAOW0rXwFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfVqd5t2aUxZ0vwf+/6+eqSAu7TmsJnUiPIpDxgU2OV2eMOINLIO4V7e16uM2P8LvznOBRgEd41gfpIHzM6PgEJdQUoOBRvcWnhXWKd/GZJa4Bqcf1T4FJCcZmiqiI2+dmZjP1xc60BjF878qseEA7CgcjpHa22tpNxfoasNNrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOwj0kGT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713778479; x=1745314479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bq/NgEha0FHdVWB6rAeqGSdsld/KUoWskeAOW0rXwFs=;
  b=FOwj0kGTYQRHYqMlGvoz2InIV1fLVg3A2fpgPHur/MmVU2yY/50hBP/K
   FJBwabRxMmjXtnBtCU3Nhpg+gYjZTq+PqVvSZDKOVFptzk2tCQGt5TOyY
   9EgkkRJ21TOE7deaGtVNyUA26Sdt6lgMBpNUAs7edlepiAKEZkUN+bX10
   VF1UVQSmXgJzHiCUtaDvXxgzTZEovj9ywD+Rvn3x63BGycx5xUJ4zZvfj
   kQ5VdD4QufWYgnxVlSlOholEJYGjCXMjN6YsXTH/ZVpj8zNI4MTM2fFnP
   3c9TjFmLaXo5CEaPPO9SLRtxc8xXC4c/JvKfFKo/9tNyUEeOz/mLBki5v
   g==;
X-CSE-ConnectionGUID: YM0e60+uRY+2RtQgYc8vqw==
X-CSE-MsgGUID: M93T+ZM2RoO0iYMrVXX7Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="31797724"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="31797724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 02:34:39 -0700
X-CSE-ConnectionGUID: vte2geYsR6qchfbVk0djUQ==
X-CSE-MsgGUID: 3HRYUnajTi+vYkanhJFQaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28628397"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 02:34:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 02:34:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 02:34:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 02:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFDUBcBT09yKVg4guVWc7fL0FOm1jVFjQMnGKm6CCJoQwxpyoGXvc1LQ1i/YgrHeDxi1MSo4s4WF4RAitBgDKHZRr926BrnOo+QryZlTmTfHNY1bCYxrFgMY+NuWQShGNHGORhd9jJu+IC/Geb1AExO+PJVN9d643y7b84nbuhR/Wz4qR4x2ExcMrDikFGIjcYc1SyKAGlEyNHZQWHtZt4bETTbodrUWGaUgn2Sn9gAIyt4Pm5ZKoPViK97ZbEPKtcMwlEz4+SAiTUB1kwbNfSlmOFzwHE5iMiNFY763ArrhBjh5dFNaqs19haGYn2hjvsO/jUJ4luf+XNkyTs4blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMSFW1S/l41SnknA9NcMw9XMMQcflWp5/VCFSA9r3Ds=;
 b=CSNGXR8nOOG56QcrLiNpqV3xXimQnuHML7nUYTlXE158jTozG4kxW40bYQvTwNN1OV8aT/bFFv9Ram+CrKJYeSrBEyzjZO8TLFYuGNnj+wL9YLi7Qw0Q3IqQX7vAraX+mIAVbKHRYVj7Hbf5UBWp7Uc7f+CG6InY5tQDZD+BfprP0GlHhGLqkX4hbsjRDEViXTgh5ylN0O1qu3yKoByO0S2Ql6DD3AT786dK2e5U1/8RKzwW5Ke+3mSOW2Muoc/P6PYRPBcawX0VzbGKX7iRU2Uj/zqffY9FkEPT0fj5SOLlVHoKrEq9qoriL27xGwxB6fjdBpgR2Z+3jmurOd7vtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 09:34:37 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 09:34:37 +0000
Message-ID: <79ca3bc8-a6af-4fbc-97bc-8b694fcc57d5@intel.com>
Date: Mon, 22 Apr 2024 11:34:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 02/12] ice: support Rx
 timestamp on flex descriptor
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <anthony.l.nguyen@intel.com>, Simei Su
	<simei.su@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
 <20240418052500.50678-3-mateusz.polchlopek@intel.com>
 <87a5lqfq6i.fsf@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <87a5lqfq6i.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0187.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::9) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|MW3PR11MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 37696074-db27-4cef-77ad-08dc62af6d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0Rvc2kvRXFDY3NkQ2R2bUZWK1d3WTFMWnhEWXpna3NidlVtdHJqTjBPVUJm?=
 =?utf-8?B?WGd6aUhJZFM1eVBaem1DUUVYbnpJTVZyTEZCMlZPZ1cwUFh2bnU1NXd4SFNv?=
 =?utf-8?B?bGNHeSt5WTJXM3hCQnphV0ZSK3I4U0liSWxiaWtpQXo3Y0dQaW03b1F2Nkwv?=
 =?utf-8?B?WUNidXRUbUZLajB6eSsybmdkQU1vZkU5aVJ1M0hSRTUxM1ZFSmhwWXJOWVRk?=
 =?utf-8?B?cjlOeGMyU2tIMlRYK2lRcy9BOUhoeE1uYUI3b3ozUE9adG4waWh3b29TN3Rz?=
 =?utf-8?B?QzFhWW9pbENzUTJjZ3V5UnZndkFCV3ZVZ2dFeHRkRG1ZQ05SbGtmNXdIbk1y?=
 =?utf-8?B?TWcvd2Vpekx3a2kvRUVFaFhFQnZhK1QxSjh4S3NaMjFhbWhwUk16Wk43R2Ru?=
 =?utf-8?B?YnRhVXlRUzVPRFVSNXpYMmNIUTVZcXF5THhhVXR6R2tqcHZQcjlOZHN3TGR1?=
 =?utf-8?B?c3NjWkZRYjU1dzFZMnhBOVNRdGRGbEdjRTR5K1NHa2VQNjB1Ujh0RGV3anFI?=
 =?utf-8?B?WGJVZjg1dGN4cEtmbnhLdXRzQngzc2hXYXJtKzJ3V05tdkQzcWMyV0Z4WUVz?=
 =?utf-8?B?bVJMbGdhaWp6aHBIalcwemJ1V2FrRzlNQWhoN2ExMGdzRldvN3lOYXJuN2Y3?=
 =?utf-8?B?ek1MVHFtZ2xHc2g1d0VNN2JNaVlLM0UxcjJHY3p6MWdUSSt0Y1lOL0daWTlr?=
 =?utf-8?B?QktZcURGem9IT1UxN3pSbGhYUGhTU200R25VV3Y3cEtCbXhsMDgza2VGeUxa?=
 =?utf-8?B?TjFqeU1qaUZoMGt3YTFjKytDMnFwMURkSDg5STVpWFFjS2VRb0ZDNU4vbzlh?=
 =?utf-8?B?T2R2VTlTU3NHUC9OZFptMzdwbXZMRWxyVUg4UjNuVTJyeTNGcTNDWU9UcEds?=
 =?utf-8?B?ZmhQaEgxRnhhQVord09jMy9WU2w3eC9iT2UxOENvU3VSdGllNmdpNVlqeFRs?=
 =?utf-8?B?T2dkQlJLN3J2U3hGdUlHRSt3L1c0U0JxRG9ScmxVRytiZmtvdk5RNVorYkha?=
 =?utf-8?B?MVRMQ3ZESjJubWc5NEMrRkVFL1FDdWoyOU0zVGF0clk0Zlo5WHg3V1ZMZlNC?=
 =?utf-8?B?TmEvS3d5aThhUGQ4clBJMUVnNk9YMk55L3RYbEh0MjgrMFlPWlAxaXJUYW1G?=
 =?utf-8?B?Z05NVCtlOUxFZHN1dkVTQkVZSytzajRZYXVTRWtURlBMa0Y1NGw1ZGZISUFn?=
 =?utf-8?B?Q0VpaGp5V2tKY2xMYTBLQzI1b2RkQzYxdDRMc0FUNkNJalFVNTFoUkx1ZDNx?=
 =?utf-8?B?ekViR1lXaTNHSGtsS2FyUkQ2cmtXL0s2Zkp1UkpSRGd4Tkc2OWdBaG5TcHVp?=
 =?utf-8?B?ckpXU3EwQ2JVL3B1TzcvSWZaMXh5aWN4WXBQaWFGbklkaVJ5ZG9zTlpqbkZU?=
 =?utf-8?B?bUpKUzEzSjNyUG8yanVQeXdyYW5uVVdjZUVJSjBwYXNPTTV6OENNOVNtM3pt?=
 =?utf-8?B?Z3ZaQUk5Vk5QbHE4ZUw4alhXL1QwZjdQREpzS1p5MnBsTFRzYVJtRncvSGxH?=
 =?utf-8?B?emlUUm5SM1lIdzU1YTV5WlJ2RzFRcjcvNHdmbSs0OVRHMEl2ZEdnSTFKQ3dk?=
 =?utf-8?B?RCtnODFjZTE3eHRWQUQ1TkJjUGgxcU96RVRLUDRHQnZhUUt6SXBXWEo3U2Y0?=
 =?utf-8?B?YTg3UGl0aFhpeUdGNGVFMytuVTFpcTdXL3dueHg4ZkFaYzRIdytTNDNvYjlU?=
 =?utf-8?B?OUNJWTRxazQwWUtGU2dEVjViVVdoSGNUNEY2WWVNNm5vSmVmNkhNUHNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFdLVSs5bzF3RkpFWFh1NHpZRTB6aExIZXpEZWwwbGw0VSt3cHNmd2xDQTR0?=
 =?utf-8?B?RGtvbCtEK0hqNGdkaHY2cmRiZ3hOWjNlaDZPeXBIdUFvTEpGN3hFaTdFTG9r?=
 =?utf-8?B?dnIzQ0NMVGVFSnFNM2N0SVo5b2NTcDBYNUhZaFRsamFnWWhzUzIxWldCaWxj?=
 =?utf-8?B?UklXT2Q1bGlMbk9Lc2Y2bVBPdzBWMEZDaEI5STY5blpEc1JwSCtFYk1RZXBN?=
 =?utf-8?B?cFFwcjNjbFBMb08xd0dwYWZuSFFZWXczaGFUb05LcjZaNEZNLzhmRlpoMFZR?=
 =?utf-8?B?bXM5SUhYWjRuMWsvMkJna2xuTnVFZEhEbTdoakYxRkRDcWtTMHlUMDNNM2lq?=
 =?utf-8?B?ZGROM1VBcmdEUWExbkZYOGlqKytwMnlVQ1h2b0ZIbjNJbm10NjlnVmhwQ2c2?=
 =?utf-8?B?N3Z0UFBpWFl2RHBHWXIwU3loTmVLODVPTUwwZ3BzK1JOUnBMSDN2czgzZFBo?=
 =?utf-8?B?NFZsbFVQNjRpdjRvcjRkcE9ZczBvdEYvbU40VDZmQ3NMUndOM0tGSncrcXJa?=
 =?utf-8?B?UGRWck9BeS9jMHFUKzFVVzZlZnNoRlhpbktBWkM4aGlYV3o4V2pNSHh3MkM1?=
 =?utf-8?B?RXlodHF1L2pCZDR0WEFMN21UNXowRVRReUIwZUE0Qm5RZmp2T0FyN1lnWnRm?=
 =?utf-8?B?T2RxRU14ZHVvai9IRjhLVWF5djVtbGpWUzM0OWVydmlPMzNkYldnT3BIaVRJ?=
 =?utf-8?B?YjJoYnBKMWw0cEpZNHB1TjZVbEVTRGVQdkNCWW82Qm0yOWVwUVRrT2ZxcmJk?=
 =?utf-8?B?clVGbzN0d0w2MHVGb0R5c1czQ0J1TTdyaU9pQ3Bhdk1sV2RURTM3ZytmVFVQ?=
 =?utf-8?B?WHlIWDJ0MlpJSG5VQ1k3bXlFQnlCSlFROVlmQU1XMTQ3RHh1dnNkVklYaERo?=
 =?utf-8?B?OHVBMkd3UEVQdVF3d0lER2pDdHhiNWR0dnhsdkJWKzMrc1N0ZXdVcnZLT2VL?=
 =?utf-8?B?cTZsdEdiUW1nNTZ2QllJY3pjcGJvd2l0MWZGRlo0L2xaWFZCWUhYbDZmQWpC?=
 =?utf-8?B?eVRQR3p3bUk2WUQydndMWldIK1VLY2grOC80OWU4UWRmdkt1aVNPYUdlbXVN?=
 =?utf-8?B?U0hHQVRsU0swM2E2SnlKMkc4bkV1RFA3cWw4aTg4ZFdLOEFQN2ZDdTRzeG9U?=
 =?utf-8?B?ZDlkMVpER2tsRzJKWm9uRXNzWmE2eVdpTjFFT0IxZStucUZQdHlRY1hQM1Ni?=
 =?utf-8?B?aXJKWTExVzY3alJuaFJEZGF0dzVKaTdFSHN2Wkx5UlFxZFlUMDBoK0RrSTlL?=
 =?utf-8?B?Mm9aZEtSNVlXdkVvQmJOcUNFMnNENVMrOFhndk83a3RSZTBoN3dKaXJWcVFo?=
 =?utf-8?B?cStBd3ZURkJia0ppM3JBT1NBKzNqUXBMVWxDSlZwTHVHZHdkVVdWTURRcXgx?=
 =?utf-8?B?bW1kZkVtNFR3bVJTSnBlRzRESzZLMGtqNTNiazVrK2RIYVN2a3E2dDZXNU1S?=
 =?utf-8?B?UkM1eDBEdGk1UWsvSWx1WTlKbnhRbGFrZWpIQ3RVSE1SWGZISDZ1K0lmMll3?=
 =?utf-8?B?bHIyNGU3c09YTkFXV0tic3hpbUMwOUJVMWJ6VWhwZ29WVHZZM2JpUnNnMER5?=
 =?utf-8?B?V3NBeU1BUkV4YUtkSHdTWFNWTlZyLy8rWTBiRTRvbVlhVGdiYXhnT3BGOSs4?=
 =?utf-8?B?Z0VsRkFMMkh3eFNVWGtpVHFIQTB5andOTk12UFNKbGZxYkFsdE5kSEFrR1F6?=
 =?utf-8?B?NFQ3Q3NmeERhM1hCbHlsZ0RtWXBLR3RpYXFNYWVtZCtqVUpsbzZWajlNM21p?=
 =?utf-8?B?Z1hPYThIM1pMdDFUZTRSeDBhdTFhZldacXhwUDZGT0J5WXJ5Qm5oanhNenZv?=
 =?utf-8?B?cURTVk9LMjM4QjY0cWlSM1h1S2k3czlNaHhRVDd2RGR1emFMb1NDT09WTFh1?=
 =?utf-8?B?VlJ3eittK0t2Z2ZHTHBjU2l4RnBPZ25SK0hHbFFGT3lXT1BXcndGUEQwSEtG?=
 =?utf-8?B?UDQxd0l6bmNWdEV0b05MNFM1VjJ1VUg5Y3ArQVhDalRRMURGOWJENkhiZ0hD?=
 =?utf-8?B?elNXTzE3dDlYdHlGcUxNb3J2K241RmdoRk9pNXVpTUlhQmlZUEFYZUNobEQ3?=
 =?utf-8?B?aklHbEppbGljZmFhcjhlOHlsTEhGdFBEalRFZnN1MHd1cXpqdkUwam40a0NL?=
 =?utf-8?B?aERxNlEvazhxSUw1YWFHRHNLSGtBbnJQQ0hLTURTZUowd3ZURlhtaWw0dHV3?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37696074-db27-4cef-77ad-08dc62af6d34
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:34:37.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVNXinQ+sieDJaEvjF8Zlmjs061Q7rZ1rRQ7keVEM+mPhGsOi9iPEB0wxzfl2nGY49cRvKNID+fhGqOrMNDjcXdomX40EV58VGUJnTlVLfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com



On 4/18/2024 8:57 PM, Rahul Rameshbabu wrote:
> On Thu, 18 Apr, 2024 01:24:50 -0400 Mateusz Polchlopek <mateusz.polchlopek@intel.com> wrote:
>> From: Simei Su <simei.su@intel.com>
>>
>> To support Rx timestamp offload, VIRTCHNL_OP_1588_PTP_CAPS is sent by
>> the VF to request PTP capability and responded by the PF what capability
>> is enabled for that VF.
>>
>> Hardware captures timestamps which contain only 32 bits of nominal
>> nanoseconds, as opposed to the 64bit timestamps that the stack expects.
>> To convert 32b to 64b, we need a current PHC time.
>> VIRTCHNL_OP_1588_PTP_GET_TIME is sent by the VF and responded by the
>> PF with the current PHC time.
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> Signed-off-by: Simei Su <simei.su@intel.com>
>> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> ---
> <snip>
>> @@ -1779,9 +1782,17 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>>   				rxdid = ICE_RXDID_LEGACY_1;
>>   			}
>>   
>> -			ice_write_qrxflxp_cntxt(&vsi->back->hw,
>> -						vsi->rxq_map[q_idx],
>> -						rxdid, 0x03, false);
>> +			if (vf->driver_caps &
>> +			    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC &&
>> +			    vf->driver_caps & VIRTCHNL_VF_CAP_PTP &&
>> +			    qpi->rxq.flags & VIRTCHNL_PTP_RX_TSTAMP)
> 
> Just a general suggestion, any reason we cannot use test_bit, set_bit,
> clear_bit, etc for these flags?
> 

No reason, I will try to use mentioned in the next version, thanks.

>> +				ice_write_qrxflxp_cntxt(&vsi->back->hw,
>> +							vsi->rxq_map[q_idx],
>> +							rxdid, 0x03, true);
>> +			else
>> +				ice_write_qrxflxp_cntxt(&vsi->back->hw,
>> +							vsi->rxq_map[q_idx],
>> +							rxdid, 0x03, false);
>>   		}
>>   	}
>>   
> <snip>
> 
> --
> Thanks,
> 
> Rahul Rameshbabu

