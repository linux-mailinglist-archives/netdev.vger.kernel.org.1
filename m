Return-Path: <netdev+bounces-71040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BE851C85
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE37281D85
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA53F9FD;
	Mon, 12 Feb 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsKyH9VW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256413FE47
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761515; cv=fail; b=pT7i6bR1VRTn3I79yz03hZnRwPk0XtbZCAEVlCaHAlAZmrqTFM0cw/SSm+LEj/EFRhiyXjaYy+NE+fqZS02mEpe1XcUghi1+Ny/B4QzyU+1YR70q18D7/Gu/6D1XuoCGc9oOMFBAC9alD9QM3sXirqmEcaNtdwLDR5We59IzRuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761515; c=relaxed/simple;
	bh=X9Cwu1c/kvprNj0MOJ86baXNEV7IneFwUujimHudPQ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qNPScqso/vDeEM7VLHnFGzchiSlLyxKzP0tV0Y5kyCcEn7ZZpJbhSoWcyxzsiL/He3hhihTl4AuNaPhfoTBAOTdunvwebjGa4Fnmfnr6KVAMKvyhdwOi5YluZ/E6rkfrrP5fUf9iiQt33Kfj6ALb++Qb4RKZkLXXHQrp37EFDsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsKyH9VW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707761513; x=1739297513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X9Cwu1c/kvprNj0MOJ86baXNEV7IneFwUujimHudPQ8=;
  b=AsKyH9VW2ggEag7Cyl4Huo6AOsph+2oh7SqUVrswy8eUPrQNbb6mwKu7
   616iX734/K1MCAUq84MttvqVLlP8L8LjVJEwCkPJiF6Gyjt8p++IgNmKH
   FGYE1ooREtkewnizI4yHIrvAJ/9oLlGMNOpuQsbDtixoxY3LkWf/rvwCB
   FPR22dHiG3QX+ZUC2A2zvXZCUPHwdWQU4PNP36dP2rMElK9iRUs/4jQ/M
   epnXSYX8kwzxWhE25wZdc8Bb+pzKKMyqFGRK9g8gXyiaQ0yP9Q1n3NoNe
   j8myejBBcz67FnwdI2tf8IByasweso+6Muwv1fNLNzE3QaWOJ9AkNBFlV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5585513"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="5585513"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 10:11:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="33452866"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 10:11:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 10:11:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 10:11:51 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 10:11:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1t3L+DCuLry9DcSWEHHGgMc53HAFHhAkg5bgCRIJAqodz2u+TIXJlGVvpnqZewZB3bQqq69F1rms6q02eSZWGzbwKAAUchKwZKvw2zgQ3pMFHYDPQpSFOV7UYpjfsb1TykdweaHS7ou9mzOP4Ai5LZDY6e1G9FvfCsAXx81PpGCsjdOk39MMc+ze6FJsmvGG7DNrd/AzIt7ZV2j5jm1cotRl1yq7HgVTEowSJpWYQi+uI5qd3ujuFCgXF/WG9Pr+TgUicIfrejBOsmwLsRBp8568zLd7c2rTzuBK6ecylPQnxA2OM3VUkwI84kGXAFjSgxGaWpxC+otO/LzxSYJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqf0EAy2iIJK8OLlrnY3zQsE2YgdgxTrm28f78IQS+s=;
 b=D9cIqDYx3Q7DIbwILJBjElDBOCR6pC6LEk2tQpaEGrTRIr2McgpGMgFSHEv2lYnWTMqOJC/Ha4kUZqdAYbcawd73Xz5yEIOT06gn5vu7YF6ehL58DWvBL+xF69fOkrch9NnWTH+MYfPheWHG9JMjR9NGXMXYQQUe3xf9VwYprM6/22/lBkNZFdgxHQIlWETmOb1tvH1iZonxbiHONOwvDJAe46MEDwecaFUK9mbrn6+B5e0cmQcdt6V0YpxPddG4XPrFHdOE9RtxSXxbzX1Rk9RTTRyVMqRYDphFiZNAYD9wGYCBFGixs7b5PYWm73YyM/QiUOL7cELcNVGSmKvcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 18:11:47 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%7]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 18:11:47 +0000
Message-ID: <18049617-7098-fee3-5457-7af2e267b0d0@intel.com>
Date: Mon, 12 Feb 2024 10:11:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net] i40e: Do not allow untrusted VF to remove
 administratively set MAC
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
CC: Ivan Vecera <ivecera@redhat.com>, Simon Horman <horms@kernel.org>, "Rafal
 Romanowski" <rafal.romanowski@intel.com>
References: <20240208180335.1844996-1-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240208180335.1844996-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8bc5a9-8cd0-4242-e821-08dc2bf613c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lId5k1oPRnjRn62Vctu+O5LUTdi1O1UsiYqsMy3V01uv485E8pTN8aa7F230acCsFqsfQLfFFK3hrYhfjlHw72CkXnnnHhFLqZUeJt4msknntoTouROKvc1sOSocJmk/6tkiXHuRAy1Hyj+vXE2Lwr+f8sS6saSAM3Vz/6A3pQwxOB5R6lQ1oycRvGSBY/aLCIw4mcFoxQ83uKBFH5lG1ORHJUiGTOxDpKW6bSeKZPe4xLBomW/45wcIdgsh6udNENF2Q0tA4tgAae7qU9/jLu3WxcFeyDMVSwk1Aqdxdq+PufBm8G286ShvrgCC4wMToixS/amz/nUKXnSt4EhJWU0q91bRPIMJ+gk8zl6heeQiTFHma6MEQpEa6AiFFRMFy6WMCeAwghdZiWrCHXkwOgfmVRMuzkV7aNsot9JICuRaxJ43wUFG2ZdQvlLTHFqfCTUpTTc0tYrUPPumFezoscxA9PYbEr82Q/yzfMasOBzpXAjWLtLcKYGqDwktkDc+/VgLZCZa36YeYUiuAmLPV5Yad8hCiwgjQF5qkwBopPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(478600001)(6512007)(6486002)(966005)(41300700001)(8676002)(8936002)(4326008)(5660300002)(2906002)(6506007)(54906003)(53546011)(6666004)(66946007)(316002)(66556008)(66476007)(2616005)(83380400001)(31696002)(82960400001)(86362001)(107886003)(26005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enB5WGFJNTlCNDUzNThmZS9VNWlsdXdKeE8wTmpTNlIzeitERjRFUFk2SSto?=
 =?utf-8?B?eUN0aWQxK1FTNDk0KzE2VERZTVhjRkVhUExOaW11dnJEZWIxZjBXMkRxRHFn?=
 =?utf-8?B?YTJvMUZVUGFMeXMzcjNlM2xYN3AyZDZLdHFEaUQ3SllPTUZ5WXVPS2tkZXl4?=
 =?utf-8?B?RjdQOFJiOTIvdW80R0Z1dHFwUmttRFA4cmMvaldza0hDQVNXdTQranZ4Q2Zj?=
 =?utf-8?B?Z0VoYXJOSjdtRjhaOHAyWG5BYVdteUtlbEtlY3ZybHI3aGV3Z2NWSWVJMXFh?=
 =?utf-8?B?TzI2M09ibkwvL3ptNXBiMGNaMVA1OHBpZkV0QlpCbXdrZ1FoRUNzSW5CMkpV?=
 =?utf-8?B?ekFUcDN0dVUvcXUvZThxOGRXdHhQUXgwUUVVZ0dERzdxR1lpK1VrSjFtbTdT?=
 =?utf-8?B?ZFlycHp6cnFmODY3NjZIc3R0Um5YTjRsL3p4Y0U0dEhYNHc1U1VuSU0wQ2Q4?=
 =?utf-8?B?VFhOQ1FzZzFGalRQaSt1WkQ0WENxYjFxTy9RN0orRWgrTXQwMldnN1JWSXpl?=
 =?utf-8?B?cm1MVVlDZUJ1QWFIemRRTFo2Q0VncGs3UGNHRGZkQjk2OTJQQW9DdnJhQVZw?=
 =?utf-8?B?dlVmQWlEeldZK25pb0o2MDJTWkU1V2l1VnRqNFRrSUVBRk14VnhvQ0l4cWxw?=
 =?utf-8?B?ak9HbTVMT0o1bVZUTWhUT1V0RWdFRFlUTVBkdHArMU9JaG15K2NMalR2cnB0?=
 =?utf-8?B?VnhGS1NVa0ZaUi9wS29rbXVmQmMydWxzUnVVSHBhUWt2cXZSM3BBc3ZBR1dP?=
 =?utf-8?B?aUpUbG8vSCtET1VxRytBUzdOWnE4SVk4Y04rSjFQdldEZDhhM1ZmZVMyTUpq?=
 =?utf-8?B?STQvcEtMa3NiRjV2ZWlTcWxrSzY1RlhHbU5mTEQ5SDBhRGRZMlR2K1ByMUtK?=
 =?utf-8?B?S3BLYW9YZlQ4REpkWDJuRTNMYURSK25hc2ZsZVh6MXhZVWFlYkx6ZFQ2SGhP?=
 =?utf-8?B?blRlTVFneTErWElFRkp2S3RTTTA5UGhHeUlaRTEvU1BUckIxV25palhRb2tt?=
 =?utf-8?B?V0lOV3JFN1pEZGM3S0YvSHVNOUZIbzZIbjJzZjAxT2Q0cEpWRmZ5YU9yZ05Y?=
 =?utf-8?B?ZUdWeUJRV0ErOTZtampHL0xiL2ZyWkxXc1FQQ1hoUXhOTnhiK1Ivd3plUFlT?=
 =?utf-8?B?dERudFY4d2QxN3Buakk0SkVUSU1xT2szc2JLSHJmN2ljT04zSnlrVVExSDls?=
 =?utf-8?B?cktsRnhJRnBBQVhvN0dWYjgwcE94eTJ1bCtZZ3VoK2dqcjdWdzdybFZLNkhs?=
 =?utf-8?B?UDlIalRmZ3E0ZW5zYXF6VmRhb0FNUmZWQVZZMWJXSVJlYnRZd3c2azlGQVFn?=
 =?utf-8?B?RFE3aE5SSzVDMnNxY1hYaGdmYW9pQmhhbmlIdStCYzhlVTAyV0ZrTFRYMDNT?=
 =?utf-8?B?eFZBUHFpLzJVb1h1MFk5eGY5ay9NWTg3dk1SQjRxcmRoN05YTHRjYU4zNEVq?=
 =?utf-8?B?eDYwNGxacng5azFlam0vL3BYbmgyVXM1Mzd0bnZEZkdMUC9GM3lRcVNJTXhB?=
 =?utf-8?B?V3lpRXp3Z29TTGRVTXFZY3NRQlFBL2djLzZpcWc5OW0vRDcwVVB1TVZYNklC?=
 =?utf-8?B?ZUZuSElQVkZXdlNLM2tidE5NL1Rmd1F4ZjYvL3NOZlB2Q29Ia0srMnFNbFlQ?=
 =?utf-8?B?VFFhOWh2TzNibnkwRXNqT1VwckpjNzV2R01HY0dvcVJBaUJBMnIxM1lHdDNC?=
 =?utf-8?B?eXF5djJHeGIwMmlMdm5RK0loMmN1Y2xKeW1VOUNiMG5Yc1NSRUhnZTB0cW1w?=
 =?utf-8?B?MHd4U2NHb09sZzNoVmlVZ2JuQk5zSXhvYlp5cEl5N3pSWE94TWpJOUtpOE84?=
 =?utf-8?B?amlhNTJUdW5iNjFIOHo2a1pPbUc1cXpUWG4zUEFDVE0wQU0zSVZLOWw4TWF4?=
 =?utf-8?B?T1BTL1BwQVNzdDIyZDg5WGorUVh6bEgxM05vQlNiekFiTjR3RXV5WXBVbjN3?=
 =?utf-8?B?WlorenArelFpRXp3S044dnEvaWlFL09nbnltQW5WYmxkL3gzOGo4M2oxN2VN?=
 =?utf-8?B?T01yUnZ6dkhtTTh5ZSsvclY1N3lQZGQ0RnlQeTBnWnMwYzBjcytrQWtzVXp2?=
 =?utf-8?B?d3pFMWlhVURMbjVzallORm1LbEhsWUZReHE0UFRta3JQK1ZUSWZqaTAyakJ2?=
 =?utf-8?B?ckFtT2tVWjdXdFl0amtvNHM0bkFuZzNzbEVxVEp6VHFyOElIVVFTOC9ZcjVv?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8bc5a9-8cd0-4242-e821-08dc2bf613c7
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:11:47.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnKTBUPtflvecx9l9So+ULEW1iPscO7vXgISuA3jCPfzDSgtYoBQP2ZfiAxAl1BLDHuYHbWQaTzjaSX+xnADzYRIJmPMoOOQti6pBHQfux0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com



On 2/8/2024 10:03 AM, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Currently when PF administratively sets VF's MAC address and the VF
> is put down (VF tries to delete all MACs) then the MAC is removed
> from MAC filters and primary VF MAC is zeroed.
> 
> Do not allow untrusted VF to remove primary MAC when it was set
> administratively by PF.

This is currently marked as "Not Applicable" [1]. Are there changes to 
be done or, perhaps, it got mismarked? If the latter, I do have an i40e 
pull request to send so I could also bundle this with that if it's more 
convenient.

Thanks,
Tony

> Reproducer:
> 1) Create VF
> 2) Set VF interface up
> 3) Administratively set the VF's MAC
> 4) Put VF interface down
> 
> [root@host ~]# echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
> [root@host ~]# ip link set enp2s0f0v0 up
> [root@host ~]# ip link set enp2s0f0 vf 0 mac fe:6c:b5:da:c7:7d
> [root@host ~]# ip link show enp2s0f0
> 23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>      link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
>      vf 0     link/ether fe:6c:b5:da:c7:7d brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
> [root@host ~]# ip link set enp2s0f0v0 down
> [root@host ~]# ip link show enp2s0f0
> 23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>      link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
>      vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
> 
> Fixes: 700bbf6c1f9e ("i40e: allow VF to remove any MAC filter")
> Fixes: ceb29474bbbc ("i40e: Add support for VF to specify its primary MAC address")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20240208180335.1844996-1-anthony.l.nguyen@intel.com/

