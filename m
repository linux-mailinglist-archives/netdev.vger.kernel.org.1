Return-Path: <netdev+bounces-277097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J9vI67q12ncUggAu9opvQ
	(envelope-from <netdev+bounces-277097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB273CE715
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D8DC3009F26
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ACE3BAD99;
	Thu,  9 Apr 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIczfAmq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C542DCBF8
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757993; cv=fail; b=uCyC7OaAN0DbQpNqdPTNAA9lvg08FYmwDll7+AXIlZed2dDWGE4wUS0+0mJjjOLu3r64XgLDYSytXx1FjbNpLMRykGVeh64TLS3wsVe3+n4JAPMD9GeRcR+pQC0z0PZb133HjHM7vyczN3hPwc0bl5UixM1ecVehIXn0TksnTuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757993; c=relaxed/simple;
	bh=J/glNLH8wYlpOoN/CvCkQKQEpyJ24Shlglvtf2irA04=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q5SpEMoQkB1xFPFoh7EoX/I/OxAWrG3CbisxpRM0OJ2C2TyOEJJpW9xFFowrzp8N27DwM0eUVj0xqybryQhrRrfICLh38AhQoJxA6IQq+/pyA4zfUq24Ea3tfa9Pat5G2fQ60iDFLO8AfHs9agoju7gjffgWuv+e4LG/Oz8CzXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIczfAmq; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775757991; x=1807293991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J/glNLH8wYlpOoN/CvCkQKQEpyJ24Shlglvtf2irA04=;
  b=ZIczfAmq2TZNlsj4jBT6WZZiCgGtp65hKHGkNVwxdX5niEIMRUp8D9Nf
   n0d2GpNqf8gCaTFwkEBhxEQ7fqL2YR/QB6NYsCWm6Npa5aoQAPd8ukawl
   2bZ2rruhkzLSZCAfhkMtau+4cUhKVkbvB+jIEJLp7zWrxZCCgv44vzYMf
   s6kWEvXgPBX+rFQPTVl8Kgg0oQjLZrCoT3j78gHcPbeAtAoqZdMIgPeoo
   bnvCTlnOygA9FTpTg8elQ4jOcANM0vSfduEtw+PWwYL2/fzJuGE6mQIUo
   1pPMGapJzh8Oc/3X22Kve1XBDYPn9l0+7HHLdiJi3wCB9lqftAIyF1rP/
   w==;
X-CSE-ConnectionGUID: y4VPPj6LQpagv4OVcVVpvA==
X-CSE-MsgGUID: BeQ5+4zETsuokUd3+oNTOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76489352"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76489352"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 11:06:30 -0700
X-CSE-ConnectionGUID: hCDtOcFGRnudmyY4Jl0F4g==
X-CSE-MsgGUID: 6jlGs024QfSzFfiMsbJ4yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="252164952"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 11:06:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 11:06:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 11:06:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 11:06:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cALC/J0s5X/DjtIWVXLRPSeWlkeXUqDyfmD36BpRTlITX2T6oxLPY7gPOy5nMGP3fbxkTdsO1gymqqgrO1CVE6fyz05CyDUpIw+81BdTlHWnxHHTNg2u3leqHdFUeJhwvjf/lpOoxU9HkKteeDgHVs0aCugtdEDQYU3BvAKZLO6isvpApb6/loTB9qVBMfsUP5rnRJ5sYyKGcFY+VhdUwsE5VbHy6396TiWYrps7Smf6/mEeDxrfYrayWxIen+h5h22nMbs4BJr31rn1hBca/lptKqoMapuj4unQR0lfBGYK0p8sAzaktwOYDc4g54Cu6IkcFv8LDypQOuNR2IYoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXd5oaxiB3eAyuNpI5vVIbD7vNfg7xLkg/i7DDfV2cU=;
 b=PF6GfMQGA7qutAb811EuAGVcB2E9eVfWQ5/Gzzj3HTeE0yc+CTkS4RKmNdAARxpL1WvoJnHazJE278WYpZKPsBQnUOpG8BloWOYAWym3LdJ1xoHwv0jyFnAn0se0OdxA3jY6nQuv+9DGOMDlugy1iCtUckvGfhBvEmNHXExnL0I9jLPPUc4U+VaXxXaVzJjuHKV37PP/gB+37aMcrmFy7MzXel7gPfk7EHFkO45mX4WzM9jkB1wY/aYtvPe/mmeXPELmnxiUCMW+jvRuBvYjxP9BoHKYWVB5Q1GweIjVBFYjOBNrvpUuotAC6G1q124J5FEOWDloLisSQ6YQnArFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 18:06:27 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.041; Thu, 9 Apr 2026
 18:06:27 +0000
Message-ID: <72450deb-d985-4c70-828a-ad83405caae9@intel.com>
Date: Thu, 9 Apr 2026 11:06:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates
 2026-04-06 (idpf, ice, ixgbe, ixgbevf, igb, e1000)
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
 <20260408200740.56feb5a4@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260408200740.56feb5a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|BL1PR11MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a3710d-7be0-4371-f2fc-08de9662b7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Asqdf1FHo8oayh1zHC+Het9Cf+QtfyL3JkFIk4E3412j4btaL2AoZPS+bGVsES6+7nlPTrh09aSYYJxbNkij+b4YCQUEtq/GKjnmDLAQZxbPL9G9Ef5GXiupW6QVzqTRQaqhh5z+8xuP8QrKaALi0VW5ByTSIgozV509c+kWl6dpapHUQLix7/DaIzVWtWVSluNXDE9oXyVgtxqnwUPY5v81UXw/c9vsMeHwPbVMURawVLqloBwN/ka68+MDK6AvTMCxtktYgabmlH/3gKBEcVDWoP6++MvhO7/bK13SC/4D53th8ee7GH5OwiRFZfUCNExv4Ab2oGmDrEbsxuZLa0eXR79t6rmnHk8v5gTN+ct7TLxuFaPFwVqgy4RSZviImiYmWRCTGH2GO3nyJD0zLq37WLH/qqLjgaj5/FBbr/Xh0InhqXllO8zd+fDOA6vZY9U0xhL2Y+xFAjEFIOzH5ViEsSoYq8ONCFnTymBeK4wUtHjvj1p+7kRLJIBQM+wG2IEyn+xXMB7FhA840njUSOJFFDH0pIsqNEOGCmjke1VgO25Ugs2FX5sYvCFgWC83ERhwb4rTRZPdhrlgSsIn1zxSNhFMKnSQ38/lwa47mcOHvGnXwJpBFTXG2S+9POMSO20Rhu7kz17JHKSuHVXrsa0GDHXwLQOUkZwBMV6BJf3io7UCeorOHcQw4USiBqp0AfbU2AHCCm0579JunDW/TpJ9DxilcK+W1T8dIqjIPPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUh2cHJmb0krNktXUkxOcnZqajU3RVdLdjQweXRWeDRDQmZoaDQ5a0pzRGFB?=
 =?utf-8?B?ZFRiQXM3MDNHTFZuMjhuMytud1d5Q1BPay9YL3dtWUJLREUyWjVZR284ZEFo?=
 =?utf-8?B?SlFpRktlMTk3VFU0b1F1M01ZY1VzMzN0bUNYSVJLVGI2NmJrQ3lILzNlVjA0?=
 =?utf-8?B?Vm1MejgxcFNjeC9oV1F1SksrL1ZtN29jZUZtQWptYVVwNWdXeVlKUXM1TjEv?=
 =?utf-8?B?NkFJYURrRXRVU0Q3SnhIcWNIMVNNL1pQN09udjc5OEhabUFwWXRaTFVva2ds?=
 =?utf-8?B?M241blZUMVVLNHV5Q0ZFZ1ptWTMxUWs3YWZrVkdrYk5ydXlrd0xvMnpJS0cz?=
 =?utf-8?B?MEFic2I1VjJ2RXphVXhFZVZaQm5ZdWt2T0JFZ0paV3pjc1R4dW4vbjdpZ0Ew?=
 =?utf-8?B?L1Y4NmgxM1NsMzlDcUczcGljRDEwaWtzSWlLZlY4Y1hYMzBVazdKM25XalVD?=
 =?utf-8?B?YVhYRGVTZ25sb3RJQVIzS0RYSXBEZ2ltcHIrdzQ2SWNJZXZHdHp0QkRvRHU4?=
 =?utf-8?B?a2tSdkVNZ2UwL01GcGpNRzZxUzlRQ1pzdDgyVWlzYS9ub3dPa0MxZXJVcFk4?=
 =?utf-8?B?bVEwaGNSOEdFNFV6NU1zNVpYVmlQREtCNHlyL0phd1AwaUkva3NtbXcyQnVQ?=
 =?utf-8?B?ZlRwdHRZR3YwL1lobUtRSE1RNTFhOVA2Qzg2bVNPWUVMSFhiajZzZHE4RWNq?=
 =?utf-8?B?a096QzViK014aDZMNWFiWlo4emQ2QWtweXpsN3p1SHlFYVkvS3FkeDR5SkpS?=
 =?utf-8?B?QUxWdXBtQlk2RU5zRHZ0NTRjRWVXR3N5UE5wai94OEY2Z21yM2xJMVJnRGlR?=
 =?utf-8?B?T09uTiswSnQzMkJSekQ0UFovbkc2akNXanZhTUZCdTJGYlJBc3d0UDlQVjUx?=
 =?utf-8?B?VmZBQ2JnUkszcEQrck1JMnZuc0FBallDcDE0dENxYUNNcExUcDJoTWN5WDJS?=
 =?utf-8?B?OEZYSFhHenpDbjNwTkFBUXlYSVE1ckljV2k4eXF0eExYUFl4VDg5UDJWTllv?=
 =?utf-8?B?V2VrTXRISFhDQ3ZucGFIZVd4bDVzVitXZlJ0OE5yaXlaa2dsb0tmdURiTWxQ?=
 =?utf-8?B?eVNBNEtNSWx2MG83NHNNQ3FjRjh2TWErR2p4ZkdtL2xZRGF6TE9tMTZodjZW?=
 =?utf-8?B?NmIxcEpvSWIxSDVOVWFCMUlSN1dCaEFoMzc4NGVaTzJQTXFmNGFNN3c0S0ZB?=
 =?utf-8?B?ZmNaRjI4ZDJqL056aGM1UmVRcnMzMWpYUmdCSm1BdnpPL01PbUFOU1pGc3pB?=
 =?utf-8?B?cmlQYnV2TExLNUZUNHg5TzRFYlhRUHg4dWdTU3kzeFF0bXJSSlR4aENtdG9I?=
 =?utf-8?B?Sm1NSEEwK1ZDREt1MDl6SHVEdkxHejlSVzhZSUMxNzRMWXoxV09aeGNqTEwx?=
 =?utf-8?B?TWlRT0xMdS9HdFNMMVo0OXd1ZVRvZy81OXcxZlJReGw4cFJUcTMwOEhPSURO?=
 =?utf-8?B?REZtU3pRdTV3dmZSTE5PdW9IbjZGR1lSV2MyZytibDZ4QWRrMXcxRXdNSkdV?=
 =?utf-8?B?WVZUOXVHazhhdEozYVppWFFUclp1ZW9HWTNNUjk2YThXeDFwN3I3dDFBSG53?=
 =?utf-8?B?VmFWNmxXNmdyZ0tlRkIzUVBBRXREcUhnMFMwYlRuWjZEYUhTVm13NHA3dFRY?=
 =?utf-8?B?OTFuREdjMExkYkwwb1Y1T3RwWWltZDVsRXNFWHBUdjBTM1VqTjhTN0FGcWN1?=
 =?utf-8?B?bnJZRjcvU3dpN2dPamIwM3FhcUlleFpBYVhYejRNUEdjelk4akxORkxxY3Nv?=
 =?utf-8?B?ME1KV25wajI1ekRCV2Q5NmNPSzFzYVhDRkd2RUNZMXRGdDBPcVZ6Uks0L0Jv?=
 =?utf-8?B?dGN3WUZoUWFWd2hIUGZIbFVUNUJMV25Ob2tlZll6R3ppTDVSdUJ4WTBnY2Zq?=
 =?utf-8?B?NFpZMlJtcU0rMmtUdjRkUUVrRTNVZUhjdVQxZVVJNzkrT2VPOHI2WnhOYk5z?=
 =?utf-8?B?RUdIdk5aMHQ1Tkh2MVppc1JUU3RhYVMxNThEUFV0QldVNERhUHB5VENpYno0?=
 =?utf-8?B?WFFPdVFBQVRESDZLeHg1d2I4SjdQRnZzSW5vbHhlZmhCSmxHQ25ydzlVU0Y3?=
 =?utf-8?B?UVVNQ0x2N3c5aWRwTTVvTHZHU3pVdGNKZGpML0wxdFJCSXJRclF5TkVJQUVu?=
 =?utf-8?B?STkydlJaS09hZXhjdDFGa3JsZ2xLZ1dQa21ZQmFvbjl0ZGNMcmdMN0J2bHF2?=
 =?utf-8?B?NjBUSVovNFN6NHhvUEFRazBiN1UzSjNHNzRva2g2bFpseVg2RXNlMzlJd3Rl?=
 =?utf-8?B?bVFWODZ6S0RsWSs4alVOQTBaMWdGV0hTRDR2QVVxWEt6SzZSWndLdFB1dlJo?=
 =?utf-8?B?WjJMQ1F3c1FrUFBzWnJucW1PR2ZPT3B0bVhLUCtjUXVvMzRSWVpQa2p6Uk9N?=
 =?utf-8?Q?moS0eF07xjl4rU9g=3D?=
X-Exchange-RoutingPolicyChecked: CG82IhV0npowlHXyUHrbPvtv/3VssCRzSyI2HS5oD9Q+eUCOx8pNoUcTozgptMszrQvKqdjQ/KdqNNVG1itqw1OtTDY0vRwFqjAUcM6oMReUNbcmeh3PEjxtwN0fT5Z1v0Xfgx6lRJbp+aN/SO7+ADt7hUP4L406workxNI665MTiTcZt/FhhtXn3QuwgL2BjMMPvmf6HV4ckEPIm/gy3pAhzv5GUPxqr2eEkJn/f2zrsvEkWQ100S0vv7b2Ok7u/Ren5siwpwyJ0CwFtF9nFnIIQtJEfKSR/vBcH5OTXsXR26zKIfktbjq2Txg5H0umE/S2pIfzRdxd9Yeksq4aeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a3710d-7be0-4371-f2fc-08de9662b7da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:06:27.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4uAliyzLhHRH/jwZ3MRW6dxuGrcZHjvjmqHywrk1Et34xRuHKHnAGhBjLeoh0DZl6UpiZhQET62HlpbIBkcP5fTwTCihcHnuVrf4xGQGV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277097-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AFB273CE715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/8/2026 8:07 PM, Jakub Kicinski wrote:
> On Mon,  6 Apr 2026 14:30:27 -0700 Tony Nguyen wrote:
>> Emil converts to use spinlock_t for virtchnl transactions to make
>> consistent use of the xn_bm_lock when accessing the free_xn_bm bitmap,
>> while also avoiding nested raw/bh spinlock issue on PREEMPT_RT kernels.
>> He also sets payload size before calling the async handler, to make sure
>> it doesn't error out prematurely due to invalid size check for idpf.
> 
> Sashiko has a bunch of comments but they all look orthogonal

A lot of this implementation will change with the ixd submission, but 
we'll take a look over these and see what may still apply.

Thanks,
Tony

