Return-Path: <netdev+bounces-224107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E9BB80CC5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C155527A86
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF84314D28;
	Wed, 17 Sep 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3d7w4gu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FAE2F3C08;
	Wed, 17 Sep 2025 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124515; cv=fail; b=WfbMU0QyZaBqHu9z1oQc08xfu+Reesmo7n8anUF0/M9StrT/CVQBoPnfB0Ten+toU24XrbC4XRRZViXcxlEOaMJ2jksaRlUJKrUls63aPxR1GQHVZ7ZBjmtPxhGMVT8eoDmWGJDpXS+ufG60kcxgjf46OBVClAg/ryS39aXDmF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124515; c=relaxed/simple;
	bh=/FLh9roBsJnKOGcVCugqPCBndlLviSFjw8yNH1EQoy8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ST+8IE+ODTuAkCof2mzVLlNBPtkwr2+m0I5eErMRJEpZcozSEWb9F0ZHBvEMZVS35fFyHBIWdilcrV3+B/NXijmpasdRPI3gK3/6ozhLSznOQJ+GTlonkN+Iw5+BSU3P4eDgqDJJp6vpHZaoI9+LZXdwUxBxsu60RG37n+aFxNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3d7w4gu; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758124514; x=1789660514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/FLh9roBsJnKOGcVCugqPCBndlLviSFjw8yNH1EQoy8=;
  b=H3d7w4guX0v2Jal6k4/SGINDC3XpVR1vwpc4mtV1jMov7cBFyWpqh8ON
   FwnFYxyhyAxX/lwLAwoYbBW73Z3GGOjA58MFpG66eGRM17lBB06aAlKIf
   UdjChkwM9UvvFkuEXV65di1ZV923U7hYNPXnOOqBbOPQkVnK9lvgbQQj3
   K64XY89FbOKuITX+Oea7ZGWdRNKazaUWpn1ViqVYCHC3BBXndt0XWSX7r
   OFjaI0/QlSu4gIDaRl2UDOD7DxBqk5Cke8B9Gpi10nOsElWlg5ZAnwIhf
   EqDEbAlqw9tGRo/h3NBow+GNrHibHtMAc0DeZBtR15qE5hu6h7Oe6Ey14
   Q==;
X-CSE-ConnectionGUID: CnzogN23Rc2v2b83Ssh2qA==
X-CSE-MsgGUID: 1uO1cseoREyJeAbPcPpmbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64238529"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64238529"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 08:55:13 -0700
X-CSE-ConnectionGUID: C4fgnLTMQ4OndNJCsioZMQ==
X-CSE-MsgGUID: AWmKkppzQgmWo1jXJPQPlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="175083755"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 08:55:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 08:55:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 08:55:12 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.24)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 08:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYzX5WqKy5GwAu/fLj9Zj8h5mbYd5Z0JeNSWH2Sr3T8W59wxRPWJ10eAq1Z7KGWNvelQZ8BV6uJAX27IHbubYbrvgHH1BxSslEvApI1Y4Ilh3oQlGSRrC40cSHy5W6A8e2zZpFCHDdio2r/6sjM/WCpHZJA4ipE8/wQiR4o/4uV1yYSSwFfOAiIFAOHE0tap1c3dTKOe6z2odzsH3mSKicKXDo98a6yBXyo+mNktkoXg5yI+jvwe65kxTchZzVlymsiTNOqKZUVp6ecbrdhE+kXkZ/Gp+5mK1f4ZG537XFKCQ/bmQd2zv4oNcJnDJXd0Jo9LxnSnHmd6rgK7IbBwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNztOHxXpIv+Zrcf+0ERIrEdsA7bBvBjbNPTj1H17ZU=;
 b=Jij6TMmPg0XSQzbLZG3Ktv87Mx7Xz+q04kX38Jvsz7qYVVPu/bIu45yuSGrypnsUiinQnVD6eCrdbYTyexYApVgeXdkTA/whOj82uU77wC26RP/NBTLBCXKxk8rb+LUu31/9Rqi2T82e1JmSNhivXIi+TwZrwN92FD/Pa1aPK/t6PcQpPyP01Lfnij57LJMy+l76Wsi/hTfzer6tR6P20w/djRyOO9+Qbt9Cf0wqkDkuvRgUdql+gXWx8kMPhXm4gY4Lk7tvOjWaWxLqgKqS3/RTGT1a3/Kx9MFvLy8QYlazGNofOsGy/7hk+zZcNFsbGkJI5AUK9TqeYJorAGgr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 15:55:02 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:55:02 +0000
Message-ID: <ad040233-2196-4d90-9da3-326b637dedd4@intel.com>
Date: Wed, 17 Sep 2025 08:54:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] net: stmmac: replace memcpy with ethtool_puts
 in ethtool
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Simon Horman <horms@kernel.org>, Konrad Leszczynski
	<konrad.leszczynski@intel.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cezary.rojewski@intel.com>, <sebastian.basierski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20250916120932.217547-1-konrad.leszczynski@intel.com>
 <20250916120932.217547-2-konrad.leszczynski@intel.com>
 <20250916164530.GM224143@horms.kernel.org>
 <8cc527bc-41cd-48ae-a40a-05c69b2c4ac3@lunn.ch>
 <20250916162502.0fcdaf9a@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250916162502.0fcdaf9a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:303:8d::22) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bcffaa-078a-4b70-6608-08ddf6028fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmQrZnVSY2VSdm5qelRUWGxpOE1WcE84M25US2RLYU1nbm5sUnVjbHpYdGhO?=
 =?utf-8?B?NWNZaU90TGlkeGVZZGRQRCtZejdyN1V2cGxmYWNtakM1ZUNFWVhoWk85eWc3?=
 =?utf-8?B?STFBblRLYyswZU1PRlR6eWs0QVJOMlFwNjBSdnBBblgwT2p6QVRiK2RnUWlM?=
 =?utf-8?B?RkhvdnUzR1lRdEhCRFc3Yk10alNHMnB4SVl4NXltaGdBNm1HSElXTlVpbFNE?=
 =?utf-8?B?Y2kwOUUxZm4xY2ZGQmIrdGp6Y3BrR09VL3R1M3A5amY1WXkvZXJ6K204MFhP?=
 =?utf-8?B?cERuUzNuMENXVTRoTkNQdG9aTitSRzhkeW94dzV6cHQxZTRlV0RQR09SNFMw?=
 =?utf-8?B?a0ozM2dRaldpSVhpTU9YbEVuZWJzS2RxTDYzNjRqSTUzVHZCZEVYb2krOXpX?=
 =?utf-8?B?Q2lpT28xREMyM2ZHV3dvVVpid1ZRZ0kvMVZEMzBFWHZGUTRqRkVnZ0VBMXNx?=
 =?utf-8?B?anZOTGRPMllrdUE1UTB5QkRidkJ1Rk9ndXROMjNWdjJ1Y3UxZW1nNUoyOWpv?=
 =?utf-8?B?L2s0eHhTcGdRQ2FoQjUvMktITCtkS1dnTlpZeURjME1FR1Zyb0xXV3lPdDhP?=
 =?utf-8?B?ZksrOEdwWVdieHVPeXJGcUs4NFdMeWd0OW9zaHUvaHNKakdZaERDelRiejB1?=
 =?utf-8?B?VTNyTFhlL2hKdTArWEVGbXJWc0c3U2I5OXVXR3cyb2tZN0s1U2MxT1RuY0px?=
 =?utf-8?B?REdkWDNvMVJrN2J2UWhBaFowMlNvblp0eHdCajBYMFppZHVQNE9rNlVrQkUz?=
 =?utf-8?B?MzNVcGpVQkNHRWs1bC9Jb3E0UFRtcFltNHBaYnJQazdKaTEwcG9qTWVQdW42?=
 =?utf-8?B?VjhrdFBMQ1Q0dERHR1hHVzNWVStaMWNQUWFFUTJkVi9LUkIvOU55aXIzMXFR?=
 =?utf-8?B?RUQ1UFh5SkswTGxobzZQZUlQZmV1bEcyZytKR1R1YzBWMTRFRWo3ZHNTT2ts?=
 =?utf-8?B?aThvOXdpUGV1S3lTeU9INGFnOGVmU0ZDOGkwcDhMQTllQll3V0JCc2s0V0tp?=
 =?utf-8?B?TGpETENFVVlIMC9SQnlvSzFQRm5xZm5oc0h1dFdmUTFES2o3QUc5QkRYaVlO?=
 =?utf-8?B?NE43bU10UTI5bEpvMHR4eWNSc2JYR1UvUmtPbFdHL1RnSWNLNGxjKzFzeTRz?=
 =?utf-8?B?M0NUTHNOTWY4ZUxYSjMwYUpZbHUvY3pNM05US0dyYzdXaHNZbWhMKzZDTGtC?=
 =?utf-8?B?b1hRa0hpV3dVNGZiakhRTElTSENhaGc1dUVhc0F6eEFOclk0MUhrYmxYSGJR?=
 =?utf-8?B?bzlscnV5ZklxcXRFVDRKa3Z5SVdoRGM1L0JleWdtb3R4aWRHYllTWlE5bmVZ?=
 =?utf-8?B?N1VKbDZZTVdhSkJCNytwUHZQM3ArUmN3WDA1UkFwQVlHNGpzdVVxVWFQNXZa?=
 =?utf-8?B?S2NEbHdzSVNDZVd2R3YwY3lYK0IwM0N0aE12Wm9VQ1prVUlOeXdMK0pTWXRQ?=
 =?utf-8?B?YjVlRm8wOTNIdGVZM2gxamNLdWcwMGtYcnJMVlVFYmdzTjlVZXBzb0twLzRP?=
 =?utf-8?B?VVRjMCtaSHlsbHcxUEhMcEhJY3ljSUhGV2UzTktQeVZGNTlLTDAvcU1pUVpo?=
 =?utf-8?B?N2tFbC9BeVJhNVpsdHdhRlloOFloSm1BeGRlM0dSekpSRGNNc1dpcGpyb01E?=
 =?utf-8?B?NGU1YXZ0UTRULy9WNlRJUDViakIyMEo3Y0RmY0IzVXhRY2phczc1MGVhTWdH?=
 =?utf-8?B?dkg4OWZER2xPM0Q5U2pMNkFzcU40Tml0aDRtRGNRS0d5R3hOaUIvN1ZMM25m?=
 =?utf-8?B?UUJOK0VJcUQxTVJvWnRZdTd5TUJnZDhXVXlWZ0xpZ1JGaEdJem1CbkNyNGVK?=
 =?utf-8?B?bytYeVdVRkRqaGN2ZElkcklkTGc1RTRWS1Q1UVQydjhZSlI4QUNRc0RwNFBZ?=
 =?utf-8?B?cGtuYVFXam55d0RPNE5ibmRRaVdWZlMwKzFDaTVtUzRpaVR5OG1ubEVNSkJo?=
 =?utf-8?Q?X5WiVa/Qg2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SURzdUhFZzdwNm1ZNTZIN0FnWWd6NWl2bW1XOEhEbjk3QmFGNlA2eEZkVmJC?=
 =?utf-8?B?QTRmTWFEdkRzVTJRRnVyR3d4TjNYWFdvb3hxelJxNjc2Y2dLaTRMZ3RnU3VX?=
 =?utf-8?B?WitnSCtCTytkRjBBbFJ5d1NjYVgxTk9JaCttdE9tWTFxYjc4T2RIcUtCZnFh?=
 =?utf-8?B?TDFORjE4U3ErUVlNVWdrWTdVakthMGs0TnpKalpISlFqU0ZSeUpCZXlFdFAw?=
 =?utf-8?B?YUNuYVJEdHh5dkF5S1JsY1VIcm1MZTZBY2FzeUxWZWNHbUY2YkY3YVE0eHB1?=
 =?utf-8?B?Q0taOElhK2YvVnpDUnU2bXdTeHBTNExDM1lPS3JSY1dJcWJBeERHKzNhWXhp?=
 =?utf-8?B?NldSU2NHTGNTOVpFZ3ZRUEtxNnN0MklzUXNzUER1TnZ3V3NyUkJmNllnVVJD?=
 =?utf-8?B?bEVpMmh5WmUrbmExdDBRY1Y5cmd2VVZrN0l4N0VDZkx5aHlMNVlNZW9QTk5z?=
 =?utf-8?B?Ni9WQmpEZXRMWHNmV0kvSWdObkMyT3R2ZW9BMjFWSENVcHZhTmpKNDBPVzVk?=
 =?utf-8?B?d1duSW5LT1htTTQ4L0p1Ym42dFdKZDlkd1VVdXpHY3hSbS9kdFkwNGhycVB5?=
 =?utf-8?B?L0c1WERrSEdyT3hkS1B1VjMzWWxTZ1UrbVExdVNLQWo3eFdEWEdYYU1IOEpZ?=
 =?utf-8?B?UkEvdXBMK21BUDVobGI5cDZyUlBuZExQREtRRXp0TkpCOTRmc2d3dW1ZVyt6?=
 =?utf-8?B?ZHJtMGNzMUxYNTgrMDFsbVViTHF6YXl0V1dsdmg5K1Zua3RHQUZ5cjhxNWNR?=
 =?utf-8?B?UmxhQUo5Z1NoOU1KREx3N3I0QytFcnRrYmJwemVOZ1pzdktzOWxQVHJCQWor?=
 =?utf-8?B?UGVmRXV4eGtzc1FFU1ArTzk5cHZqWVo1cmliclArK05iSVZpVUNPTk5MNDBJ?=
 =?utf-8?B?bkFqQWZzYXg4czdyUEhxY3dKMnFBalQ2TTkyb2wwYUlBeGV0MlV4UzN4ZkM5?=
 =?utf-8?B?aS9XWVYyN2d4V2NSa3dDNXRPb1dlU01PbmM1d2lPRFNWelNHU05MZkpXbmZm?=
 =?utf-8?B?VThiK3pYUkJBd2o2VVlYL096VituSjk5Y0V0OGpYYU9hS1A5UW1zYnVzTlo1?=
 =?utf-8?B?NVFMVFcwdUs2bXRSWFZaajRCV3JhMEVLTHZ0eDJFcEh4MG5NL3ZZcG81UitG?=
 =?utf-8?B?Skt5Q2p5R2p4RlZFRGtQL1dyOFN1OU90eHRNT2tiYU9DVXFPazhDMWlTcVZ0?=
 =?utf-8?B?bldDTy9sZDJvbWdaNUE0aVFJQnhNOStZck1iN1FZaWNXb1c0eE5BY2dST2tL?=
 =?utf-8?B?ZFI0bUQxNjQ2NGorV3k2cTNTcndVT2I1Qzd5dE9Gb21yclpLc1N6d3N2dXBH?=
 =?utf-8?B?QmpER2NIdTNRcFYwNkF3WlNXMHFCdGUzNHljdVdkTlZiVDVEeHF6U3plS3Zm?=
 =?utf-8?B?RFQrR2lQNkZtdjRoRmt0aHFIT0NKcG5qVnRtbXZibXI2a0FXVVdOZVNBMXJF?=
 =?utf-8?B?bkxjaFRSNU1Ta3V3WjMwU0QzMy9uR1BQZ2xNVHMxdmpaSlRaWmY5aHNrbTk0?=
 =?utf-8?B?by9mRmZaRDFxeFVnSzZXVW5VWWdCMk9tODFGTXNJRS9tZFJ3ZnZoTUQvNXMx?=
 =?utf-8?B?R2Z6VUxBaWxLdUxadW5sak9CSllXUWZxeFJnZEdOaDhNZG1OWFZTU0FjK05s?=
 =?utf-8?B?dGdCbjNhVUpyVDRNRDFDRmpXdTM4amU0YTIybXhzUFB4WFlRNlJUTkUvSUtM?=
 =?utf-8?B?N1ZnNHhLY1EzQ0xMaFhWSVNvZExYQ2lpQ1FwdElDWCtXZ2EvYmdHcHRYMExl?=
 =?utf-8?B?VUJ1eS9DRkxHclRya1V5a2ZsWkFJcXQvY09lT3Z1RmZXMnJCcmExcnN3UTFY?=
 =?utf-8?B?RmloZ3VhUHp0aUZsV3lSY3BUNTU5Z3QxUU5mWGZHZkRQNjlIZFkxY1o2NHVE?=
 =?utf-8?B?em4raFhKMEhnb0FBSEZWRE83SnJIYitTWFI1SjJ5WGhIamhWZ2xrbEhoMGxM?=
 =?utf-8?B?MEhXMGZjT3NDMXdCNlNFZnNYbGUrK1lEZllVSXBBSlRPNnB3aDJYYmNUeEpz?=
 =?utf-8?B?Ti9YeWJucXlvVFZvSkg5QllKN2MyUFVOYlBsMGlOcmR2WDZnbnI0OC96WUlz?=
 =?utf-8?B?Skg2V1ZVKzhKTU8wOXNabVZQckMra0ZVbmRsOFVvOTYzcVBvYnFENXhWcWN6?=
 =?utf-8?B?UzlxSkNRTzJ3ZEpQb3JYalQ3UWt0Ni9GWkFQUE82RzVGRmV5OW4zL3QvcU12?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bcffaa-078a-4b70-6608-08ddf6028fa4
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:55:01.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJZ5cIxJep9PiJ6F4yg15ZOgJdjQ8d37UWda3mBspbGW9d60CP4TINv+JxTERe2FKRq0ZXppsHpc3x6dol7aGeHHr6s5VEvuR/lvBpYtXOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com



On 9/16/2025 4:25 PM, Jakub Kicinski wrote:
> On Tue, 16 Sep 2025 19:12:22 +0200 Andrew Lunn wrote:
>> where desc can be any length, ironically making
>> dwmac5_safety_feat_dump() unsafe. This is why i asked that this be
>> changed to be the same stmmac_stats, so [ETH_GSTRING_LEN]
>> __nonstring. But that seems to of fallen on deaf ears.
> 
> Yes, very strange.
> 
> Tony, Przemek, I suspect the folks here are from "different part of
> Intel" but I think they need some guidance..

I'll reach out and see if we can provide them some help.

Thanks,
Tony

