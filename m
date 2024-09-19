Return-Path: <netdev+bounces-129001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002597CD5C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802341F23C9E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C3B1A0B1F;
	Thu, 19 Sep 2024 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHzg8Lfo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053619FA86
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768736; cv=fail; b=n3SZf+dFyqbjtZK6wrW2K9z7brtvOmr4QX8A0dH2iEVYxKcI+24WrlbgTVAvw08gcDLn0Khgqcx6OYR4UYszC1jIkSgglx5MwRdNsoqb9DHL+/w2DUB+xthubziXuzqtUjFhWIUuPFgGLWMqvDILWvshpXT9BS/sc6aCSRLOcjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768736; c=relaxed/simple;
	bh=oxZhrLD6htKdKI96FgceQpnICJU9dtPpiO+2T+GYXGc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHD3NOinZyxfPBgifGkKevBeqQ1G83xntXfgNZk/8ymTklloTbkZq8zDj0GcBvtWwQ7azMnF66TeeGQzZbcPsG70hDegGDuMAEnqftGXfOmKFVo7S0IIrO6vUZEiakoVn+tohp7Un6+J+vwh6ZJSKnUakkXOvLmDUjERVFYBifU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHzg8Lfo; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726768734; x=1758304734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oxZhrLD6htKdKI96FgceQpnICJU9dtPpiO+2T+GYXGc=;
  b=SHzg8LfooBvOBEkn15OlisK5lItZ6RFk0Qr7QLaDQ2L4IoMj/VgUzfZZ
   h46YLb3OYuXyf7DNf0NxkwnbI1emjExNjVY8nAI4GLKYqBrH7Vlo9bP/6
   16KN1ezE1+uaj/+T//2foKMjvExkj4GuXxwz5Gq713FK45KaB/DPkmHVX
   494pIpJGqC/PLkotQd9PhHFkhy8i6nRa+yDaH6sLf9Pc2NPKkH9JPkICs
   b1M2ptLRwnyBzgIiVKAGnI9EKWQ6fSxO9gR1N6Dd6f7kyWxSjbgAZvCBJ
   4D2hoOjMBWECiXFO0YRK5RVWSFFzOz0k3yEidqPepkUivnNfFmbAZQOL+
   g==;
X-CSE-ConnectionGUID: 9XEtP8QVTRmDJcSC6xcIBw==
X-CSE-MsgGUID: /JzOqyCfSs6qqJtr+UpZfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36417573"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36417573"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:58:53 -0700
X-CSE-ConnectionGUID: akFKzysZQFSCn+I2LVhB3w==
X-CSE-MsgGUID: M4NXkk01QumbRBEko59CVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74989724"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:58:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:58:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:58:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:58:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7GRIGmqUtjt16L7TDJyRhtrjjWhO9YRiIvJXr87tUJfIwyxByNtaNWRsWmGGU8tudrna+6l22ubevpA59NXdVzsTP60u/HxEtcNbgLkFz3x8a0nWFEs95oiDZvjtk5iWhL8pUl68e43K6A2hoK5DTx0fEYl0zH/lypHMhXBcY2k1gtHCCi3/zWsGhU7+qCVbcAO8+7N16CPhqjIvmXcygN4LAvgSNbr4v3CO+wCV335A/ndA7jmix0Rpp+1jrpCdFD+E4S7eqXL/nDB9EIy/8n5EnrH380iaGiX052CqgWmR78pFuCONJaqDtfQ9J1yVxdoEZPJZ82qKJF09nlNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhUy1cy7RnCA9WFiKf3jq396fcTA3kaZU/sJWGVBEYk=;
 b=nLqw+CuNDqvFmpwVehHpmStnbhaF2VEDv9CzXCqcp3gAC9AzHnY+ooPcMdgVPCrySRF14hse54OWLzfx2xB+6/ZJ+TZFkUFXiZl9cc5+bI+1vWNqjtzCodTdw036Efbdso0gICXzweeE/iW4Nnf29xV9CkJq4vaOtr6DV37UP+BZIe2CPwmi6Knj07MrXqI2mUV75SYB0YzKJKewGeS9+ZcZAEuuASP4roVy1MqnfVb1TzstMQWbVdP6XXdZqQ3B5VNcXUr4vR8J6YPAqFqDl/bNYfCUO2fb+0cOtD2AWio8oZqNR2JsccB1jB8dG54mEL4kj0K1DQzBy4q+CG5Gyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB6672.namprd11.prod.outlook.com (2603:10b6:a03:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26; Thu, 19 Sep
 2024 17:58:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 17:58:49 +0000
Message-ID: <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
Date: Thu, 19 Sep 2024 10:58:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
To: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Michal Kubecek
	<mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0035.namprd21.prod.outlook.com
 (2603:10b6:302:1::48) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 55179bdd-4afd-4d43-d058-08dcd8d4b6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWZ1UWcrOGkvZXJEaWkrWXRvL0ZHVXFGbnpXdXpodDZ1KzhtODZ4ZWpBZGxB?=
 =?utf-8?B?SXVSRHB5eFhZbm14TUYrYzE3ZU0wVkNwZ1RIQ0N0RmhiNXNycnR3THlmRTdP?=
 =?utf-8?B?NEhrL2lnK25Hd2hKbkM1d05ic1JsY3JaSTI1RFVGYTlaK1pOREtubFo0UTVE?=
 =?utf-8?B?VVlqQ3BRaERFejRBZEhwdG1UUTh4VTZLVytpNHYzY2NiSlNUMzcrZEdmbWdD?=
 =?utf-8?B?cDlJK0RSWUlEUnFTMnNFOE8vdnMwOS8zd1FMTllOTmZwaE51Z25aT3pXU1M3?=
 =?utf-8?B?YkJRRWcvVVQvKzJYZ3BsbEVlaTl6blNZVmJ0ZUFTdGFzQkNOMzBLbTVqZDVF?=
 =?utf-8?B?VFNGc1QvbDNlUXpwZmlJZUg1S09wSmN1c1hIc210S2l6bjd5bG9nNXpoZVFx?=
 =?utf-8?B?U2hJcFJjUjBjWVRNVDdRM251RUl6NlFFa1lIYXg5ZmRReHVRYWZrZ3grdFJI?=
 =?utf-8?B?L1BLa2Zid3dGOXo1ZzNtSXZQN2FEcnQ3eDBEcTNSc2xpaFVSYmUwVllEOU4v?=
 =?utf-8?B?ejd6eDNVeUpBWldzdWpublRpeFRtbHRoTmdLaWlQU3o0RlVuQTZWZ2dBclQz?=
 =?utf-8?B?V1VEUHFaTlZaZituY3dKVFh5a2VndXVaRklIVmppVFhHellpbjZxMFdUUkhD?=
 =?utf-8?B?TkRwNmJmck02eDZQNnZITVBEVEJaK2s2VE0yZThEbFd5Qk1tcCtaVHZydWxY?=
 =?utf-8?B?ZG5Zcjl4bkZMbnMyRE1GeTQ2KzBIMDRVQTR3Sm9IQnRUTVJ4bHQ0UmFycnAy?=
 =?utf-8?B?RzJ6UU9qVGhKQlJxeGJPakxQQXVzM0lYV0d0d1NoNGZQNEs5cFkzZG0zazNH?=
 =?utf-8?B?cXRjdFFSbGZ1WHZ0MXF6ekJNOFFyaloyK3hCZUptc1VTTjFsRWtFOU5vaWE2?=
 =?utf-8?B?ZE9RSkovZHFDWGpvaVdrMy9rbWt1NHNaenNoN2xqMzdBM1B6U1hTK05sc09y?=
 =?utf-8?B?M1RYblNpNG1lK0xCbVh0dkVRc2FkUUxQNkVTM2JqNURnQ1hiL3ZYSEJoRnlS?=
 =?utf-8?B?RlFValRiVysrM09tK243TWhIUmp0OVIxdFg4OWxIYm5qZCtQQ3RvTWJleFFa?=
 =?utf-8?B?dE40RWF3cW5lZWZ4RUZNdmFOVC90MHJzZnV3eDUybXVtTk45TXdYQlBydzdi?=
 =?utf-8?B?cHZOV3pTUjlRSGpUZktvZXU0dWRBbzlnL01JUzZLU1E4TDNzYXlqbFkrc1B4?=
 =?utf-8?B?UE80NVlkNktNZ3BiMWRJbVVPQzc2cnpSTTlIaC9ybmRuazdueXBZbDYzc0FJ?=
 =?utf-8?B?Wm44eGpHbEliYmo3WWZZWUs2ejFnWng5K3FvUnhTcmMwdTY5TnRoVkV1STdi?=
 =?utf-8?B?blJPN3NxWFlkdFIvS2JQRVpUbjFSOXhrVVMyOTRvY2taSzVvenBPNzhkV2lV?=
 =?utf-8?B?eCthc0V6cDZXcXNIdVlOeVN5UkVRWE9jT2kzeFdoQ0o4eGJOdjBaaG90emJi?=
 =?utf-8?B?MzJsMDFKU2N2OHMzRUFpYVcycjdKY0lGb3l2M1hnRWhMeFliajlGY1ZvdC8w?=
 =?utf-8?B?RDAxNk9tQzJibzNMM0xjUy9CYXJZZTI2Y2NhVUYxNFdZR3JlZmNSNWVocTVi?=
 =?utf-8?B?NktEcjhQT0E5UXJ5VTV6NjBMS202STJ6RE9RZnhiVGFvS1hLQTh4NndRYktu?=
 =?utf-8?B?NVlCMGkxVW8ySm9aa0pVZ0xva2xsOXExY3Z1THc2b1IyYk13U1hlVy8ya1Br?=
 =?utf-8?B?RmNsd1o5RlY3QTBRcTBvYkpOOXpQMEJNTVRyNkZhWng5bS90c2YzcXpSdGNI?=
 =?utf-8?B?RXJ3ZGVVZjR4YS9UV0lsV2I1d3AvRGhsZ0dMZEswUTVtUk9SOHRhMi9VTGFt?=
 =?utf-8?B?Z2ZpQTNkcTBPTzMrVE1uZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEE1WnVROGRldHptc1QyaGpKSWJQYTczOHpiUnBzZWt3NGJ5eDlNNjVQQWVZ?=
 =?utf-8?B?cU5QbGdOaFBZZFRSQzc4QlhqN3NGK0NBMnZoL00zMHZpVGNmazNtcVBvWWxK?=
 =?utf-8?B?cEVvYmRvN2NVOW5TVVB5N0MrM0NBNDJHc2NodExJR3JmYjF4SUlqLzUvOC9j?=
 =?utf-8?B?M1BxZDFJMVVrNHV2Vi96RUpBSUZFb05xZk5FMnBmcm9abUxZOEFMOFJ2VjN3?=
 =?utf-8?B?YmlvOXpocndtZTNzNi9UZ3VNMGRkNjErd0N2TkFTZWJpLzNTVkhQRXZ5UWRG?=
 =?utf-8?B?V25XNWtOaXpaeFN3RjRUK0dOSFpRZmdrTUltVENTT0FWSlhTc3U1Q1hiYk1U?=
 =?utf-8?B?cXlKTkpPY3VNOFlDY0k4TUo3RTdTaUx2RThTdWdOcGZ6eGYvTFBodVlac2NZ?=
 =?utf-8?B?aHRDSGNOQTVIWW5lV3JVa3RuRUhyQ1FDeXlLTzhIR2ZzTEI0Y3hNeUFZRlZ5?=
 =?utf-8?B?bUxPOVYyTlFhRXB5UEFMTHVYNU9GL0RIQnYxelRDelFZcW81ZllOY3ZVeVdC?=
 =?utf-8?B?S2ZSZkhEN1EwdE5USHNYU2YzVm15eVpNWCtHNTVuZExpM3hteEI3TU9Ka0dY?=
 =?utf-8?B?ZjBNb1NhaDNLekRwMXMzVUFhWkJtZUNoQUk4SkRiLytYUkZjUEcxNThxRXY3?=
 =?utf-8?B?bHNmYnVEYml0eUFMVlQ4ZGs1eURRT0JBbDQzTTcrd0p3aElhenRJcTduMVB0?=
 =?utf-8?B?Zk1yeGZodFpwb09BeXAyZ1ZmTyt4c1BtMUVia3ZvbHBNcys5S3JZZ1BBOVhL?=
 =?utf-8?B?NGhiTkVXSnBDNGJ1N1JZNFlJaHVSRG4xUUs5OCswakJDa1loemNyTmVZblUx?=
 =?utf-8?B?MVU1WnZwNkJneUJNMXJpN1V2aUFEc0RadlcwcURNa0ZwSHc2alBOdUVHeEY5?=
 =?utf-8?B?anhmcHRDS2w5eHlXRTlTNGswN2dYem9SQXFSeDBaM1Z3aEU1K1hMWm85NVRK?=
 =?utf-8?B?R1VMTFM1ZjRyUHY4RWNmb2RGTjI0Y25OaWJmR2hIbVJOa0pDZUVnMTNDbjNP?=
 =?utf-8?B?b2l5SXlCdFJHbU96VHE5MnoweFRnOGNxU3FjRHhzVWIyRzhaZzBiNHp6K256?=
 =?utf-8?B?RWFpVnJtWm15ZTAxTlc3dkNrTkFzRWtDUmRMTW1tVVNNMFEzTG9NTXMyeWxv?=
 =?utf-8?B?QXFSbERPUEQ1cUdyeWtabFZYbFN4N1NnTXdGV1U2aDBNUVM0WS9HbHNGL2hW?=
 =?utf-8?B?Z1RhWGg4Rk5mUXpDRFZXUllYUnA3R2ZHZFA5dTR2c0J2eStrcEJGTWQveVhV?=
 =?utf-8?B?c3lSNzROWEh2MkFxYzRudS9zVklWUHNnRTAvRksyVG55RkdwdlBSbzF6VHYr?=
 =?utf-8?B?Qy9GRWRKaHZydllxRVNMY0E1RnB4ZHR4c1dEVExkejJja3R2YVdLRzhwZUNN?=
 =?utf-8?B?b0FsOXhFd0x0cG43MjVuZFVpaFNGL3pNK0pYTUVCQ1JUU3Q5Rll3eXJDYzlW?=
 =?utf-8?B?c2FKZWUrNlV1ZTlNNmlIcERWbCtnSm5qRlEwR3FaN2xVWWFNQjBnTGZpTVhi?=
 =?utf-8?B?KzlZZVMvU21uRHVZeVd4aUhzMklPbnBYdWxoYTNkNFBqeFFaajZEYnpSWG9B?=
 =?utf-8?B?R1BISFFGK3hUM0dVRVBmSG9BTnBaaVNySzhGU3g3QzkvNlJtRXJlYmk1NFU3?=
 =?utf-8?B?VUF5VFA0bS9idTFsNWkzMzRVelRtLzBXK1hleUVoWFltZGNKZmpydDhYWlpm?=
 =?utf-8?B?RzlmbitWRGdueTNscDNySFJxV0YrL1VhdTAySnlLQ2MrVzJXMTdqY2tFTDNZ?=
 =?utf-8?B?dmM2N0svb0dyUGpBSFNzL1BNRXVtd3FiR2RxbFZ3T0lzL2EwRjN5VVQ1dHJJ?=
 =?utf-8?B?Y1A0R2Vtb00xSVZqU1EreFNVTkxhaXBCZUhaTnJJWFFzNVZTb2R5YnpMZmh5?=
 =?utf-8?B?QW00OG9CdW1hME9rOUJtNHQyK0JVTUo1aWx5ZjZpK2NvUEpEUThpSU50WTJh?=
 =?utf-8?B?QmpoMmswd1diQnF3ai9RbkRjN2xSbHRtQVJSQkRWQUp0YVB4T3JzeDh2SzRE?=
 =?utf-8?B?QWdRMENzOG9UOG5XRFYxTk5LTXhhck40dCtzRFZqZ0tPNzJCVk5hRXN3VTl0?=
 =?utf-8?B?aHY4QUV4SzdZTWFQNUhpVFZXelc2OVJlNzJLSlYxTllpcG85di9XUlFyU3BC?=
 =?utf-8?B?YThKWGhzNVRWbGU5cGdib0NmakQ3dWdzdnJHQVNpWUZ1cW40TEkxZHVMdTZ2?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55179bdd-4afd-4d43-d058-08dcd8d4b6e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:58:49.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19vCu9E2dJ3j4pRJ+pRmW86jUjYuM+W327FLrEg1UJzwPL5gZ+/JjpjT+pTsohqapnW2A1MgYxPtZ9FLy6+IyNsqGiJtpjuE4VbFzLHf4oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6672
X-OriginatorOrg: intel.com



On 9/13/2024 4:07 PM, Mogilappagari, Sudheer wrote:
> 
> 
>> -----Original Message-----
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Sent: Friday, September 13, 2024 3:49 PM
>> To: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
>> Cc: netdev@vger.kernel.org; Michal Kubecek <mkubecek@suse.cz>; Jakub
>> Kicinski <kuba@kernel.org>
>> Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
>> ETHTOOL_GRXRINGS ioctl
>>
>> Hi Sudheer,
>>
>> On Fri, Sep 13, 2024 at 10:43:19PM +0000, Mogilappagari, Sudheer wrote:
>>> Hi Vladimir, my understanding is ioctls are not used in ethtool
>>> netlink path. Can we use ETHTOOL_MSG_RINGS_GET
>> (tb[ETHTOOL_A_RINGS_RX]
>>> member) instead ?
>>
>> You mean this?
>>
>>   ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
> 
> Yes. I had meant ETHTOOL_A_RINGS_RX but I see it is ring size and not ring
> count. There seems to be no netlink message that fetches ringcount info. 
> 

We could extend the netlink interface to add this over netlink instead
of ioctl, but that hasn't been done yet.

