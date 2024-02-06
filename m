Return-Path: <netdev+bounces-69578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087784BB87
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB40D2859FA
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE56116;
	Tue,  6 Feb 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irL9WGeC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7C611B
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238983; cv=fail; b=NvjgmD5uA2+15ZetdF00xZJsTORB+8oc0fJNV4if7SrcOCoaGk2G1oBTPFQwDJeIREt7NEBJOMqLI/+W9PkbMpYOOMYVuBx6F0Cftj7yMTPWucwmNWgSQuCeHYkMB3M8CHIm5hLri+EYdUjGfeMLxziZ5YrsVMnm/1dN/vd3yh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238983; c=relaxed/simple;
	bh=yNKMqbmfDDsZQeaT6TvkKiD7T9p7qyggV+WhO1VLkP4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6MNh6js1NENA+nmfJL2jrCc9NP6Mz13l/cMvZusR6y2wMs4U/3XLYHGR3f3cmMsxM9GEVYWA2oslcRT+JxOKLVhxQSpTDXf3wLhEx8+J3yPJtoM2yi5VjLGYPx9kqV+9jhy9B86c+TWS+7dIL/BkrvzeCJa2ee6tw9KcfiGkFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irL9WGeC; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707238981; x=1738774981;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNKMqbmfDDsZQeaT6TvkKiD7T9p7qyggV+WhO1VLkP4=;
  b=irL9WGeC0JKHV2slSaRqtpPZbl5Od0tKgVPGhMCT+XPi0PapCdnpcSbu
   F4XtoIHKRK9dDK3Zp0Cw/LsdlDIYU5Kk9LQJh4+8ka8Z7YaCXluO6z3JD
   PIChP00bHFazBaaVWHp98XerQth82nAxfominwT7EjpkrIzX+VQqpI9Ng
   TdKaHKJVmmnJSh0F982a31E4/fzUxA9XjLHSgQAPOMfwTmtC3lpednTfx
   jyzhghuMLHp20tmHhHZf+sS6bKph176/x6p2EjZPNy3YqqGjng1K8woPJ
   iDORd+RDqrgnSKkC0oB9NCaaKTOXBH4S0cQQ2SPPdbr4uMEakB9a4BMtP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4580409"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="4580409"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 09:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5705255"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 09:02:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 09:02:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 09:02:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 09:02:48 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 09:02:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3HhRv260yo9+xSpj+ZVuoUCg45dses1/HDpvkQ+jXHpa6H7SJvWxWUQugPdKeG2gAsLEv8Ball8I2DllAS3VaS62UPu0S6v/XwrmriwdUXVwZhsD6/FFRcgrzVMlnGBgwWpRp5TGgoW6k0AkpPmly0oE1FO/EhldXrqgYvadsBnv22fRQ2dJd/Juf9YZ3XkJsi2Kj/KxVAHAvhIeRMrFFgfmz9FLnL6I0CuLkhxHbNzv7prf2R5j400A8Ow7vluUsFAi/HES5YvUuFXIJcfFUrNjRJRENovzXPJB8TwdyVtC6zAXweFkUKrqhbGpBqhxpcnCPoulmBb/q+XjPlXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNKMqbmfDDsZQeaT6TvkKiD7T9p7qyggV+WhO1VLkP4=;
 b=ULmCEBvhnIIWHm6FKmQ29Wir2QB33ry4hllvFmYqgiNVvPuRZOSMQE6pjsKn8ayAJ2P9/X0D9ZZo4slprwchnOUTg/PfHiqtt9icq1Y+jKjKqIJqmZJChFUb/dy0opsOu9DXPKiEJhyqbB1P2Jsb8WOec8ou7AtWWRy64k0F+tautkXV0iKpVI7xRSWQRkRpaGdUGi5e+jeJxYkPNMIPR68prBmUX8lqYWdAGkEswQZnwpqICTIGhBm8LG+YsEy6nPbPLuX0k+34SkneN0K7XgMENAhRneaJAN0UXYjxYrSgKiFEJj2rZMxQE89vwAVNXb++jU+2DD1YQJf43ZEbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 17:02:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 17:02:47 +0000
Message-ID: <08e761c6-d79a-4a64-a61a-9536dd247322@intel.com>
Date: Tue, 6 Feb 2024 18:02:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10 iwl-next] idpf: refactor virtchnl messages
Content-Language: en-US
To: Alan Brady <alan.brady@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<igor.bagnucki@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240206033804.1198416-1-alan.brady@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7413d3-cb26-4fd5-519e-08dc2735715c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTe2VC+rsxnwKYB0rMLGHVWir3D/YvuDJ2TV75XleZgrJ1n3u7tfNd4HI/7aPdCyvvhAwXnoCbd9qq7GFZ28kbyU9AyFWSau7uPG7ZWj60l/7K7/hEoe7QwSsmdntQl5Dlpf2w4VY3Vay9zKPo2QxOzzywt1Z4WSAGaqM9ore1oNVq80S0chfOHPVyg8OgCcxXRDC6mdlNdLQ7XWLASwZ6E1ToWME6vz9Yy4WpEKiSO1Hg7WBMNFXayI3yZ4WBrsx91VP0hSmMCTmTYYzPnV0fq6MVWc2r2WdG9EBOzPbUQcf3TP6zADDK8F+FttZzozAONgjjjquOMaxCYjSESuZH3jS67qIciejXDX0JEw3/4C0/w3hLIPYSDjaF8YlbDGX4EEohpuzbA13mhHFK2yrBH8mG62VK5ZdmBI9R0XQM/sYbg+Q6Iy3fZs0W1374wA/ZUXmepu24ZdCoEfshBnQ8GqSohbLwIgmOQs1PO/aiQZZVmzgzBXE8gq0vQ215ULftx5725AHoCMdayvofG24pvo4hgq6O79Ch3ATsvLVNBwqdLjcSaftDKeOkECC08HtV7gt99Jm16GMMX2uPPVaYwUUfgpcoHqs6d0bPgYZNZ5Zw4rjPaX1hCFrNsOwKjofCJ4fgGENqJnzOxhItm4nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(38100700002)(6666004)(6506007)(82960400001)(83380400001)(316002)(86362001)(26005)(31696002)(41300700001)(2616005)(107886003)(8936002)(6512007)(36756003)(6862004)(4326008)(8676002)(2906002)(478600001)(4744005)(6486002)(15650500001)(5660300002)(66476007)(37006003)(6636002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElxVWFpZHQvUUdXTHo5cjkwTGFVWmlYRnhJMTgrQ0xTT1RXYm5iZ1lVNXhQ?=
 =?utf-8?B?OUNlQ3JTUnFOZkJLakdsa1RMdE5FSUZWcHp0WEM1SkYzdHpTa1YyVERKSkJN?=
 =?utf-8?B?Qi9YRkk3TFFyTkFlWVBWVmF1RENOc29rRG12eGtjRFY3OXQ0b2dWdUdDOXdh?=
 =?utf-8?B?TTQyNUp2TitpZ00yODVJcnAwZ2QzbmU4djM2djdwNVJBaEIvRWRSa1VDNmRZ?=
 =?utf-8?B?M05ZbmNoNkhocEphck93dVBGRS9yOWN3eGRQV1htRlBSOEt0NmVBWENxNjFx?=
 =?utf-8?B?cWs0amI3ZUJmdHNoem5OWTA3MTArdFdTOEZId1lsV3ZRbEluRFZjcGI3Z3Jn?=
 =?utf-8?B?THRLbWI0NGNIa1l2K3F4M3dBRnpyNEtTOWx2V2hDTklSQkNvZ0kxWGFRQXdj?=
 =?utf-8?B?UjRSZ3JoWUJoZXdQdWw1NFV1Ym91d2tuak8yM08rZldoTEtzelpUd01XWm9I?=
 =?utf-8?B?ZnFYUWkrdERiMnBGS2xFZ2VPRVNFYzZHUUgzK1FjN0FITWFtUUdheEdldG1C?=
 =?utf-8?B?L0lVSGFnSE50K21DN0Q1OXY2cmJIQnR1R1dtNlNzMy9USW9Tc0R3MitKQ1NK?=
 =?utf-8?B?anc2aTA3cS9UZ3pTbnJuMUMwSFJwSnBNTXVUS0lNNUtKVSt2bElUUFdHSHVa?=
 =?utf-8?B?Yi9iNCtKbERlZExtMlVIZXpNVVNoT0JzdXd2dTh0c2drYjZhNTFraDJGakd0?=
 =?utf-8?B?dWNvcCtablZzSHlRdmE0UTFSLy9sSEE2aHd3RnlnTm51RUgrVFNmbDg3a3Bs?=
 =?utf-8?B?eWlGQm5JUmkzaDYwZVNLWloxMi9yZUtOSTZqK3hTSzRMb1dhcTdHSDk1R0Z4?=
 =?utf-8?B?VmhTdHdqVzhYZkJOZHRhT1ZkczFPRjJ3QUR2RTdFeGFWcTNFdkF0SlVTaDRh?=
 =?utf-8?B?R0dNNXdUYVduTWJTVnY4dXc1aWhCdXhjQTBZL3NSV05BWHRpYTJzc3daUitI?=
 =?utf-8?B?dVZlYzlqQkhtNk1OUE03eGhGVUxMZlFNaDN2YnB0MmtRdDZBRUV2Tk1CdTc4?=
 =?utf-8?B?allYU0I2Q3gvck52TTJJNmZFQkVhcHFjalkvelJPYUpVZXpOdWxVczBPd0ZY?=
 =?utf-8?B?clhTN0JWN3RtVG5rSU1uUEtiNnRrWWxUV0R4ZjF5MFcrZ3BVU0duZjM0ejFs?=
 =?utf-8?B?SjFibWRONEljdmt1eXg0My9hY0lOb2paSmZ4U0NJMTZpcnUvTmJnck1EWjdU?=
 =?utf-8?B?Yk5xYk9jV1NsN2ZEMXNYdWpENnA2QkhDVXZqS2dLWWlHTmV0YUVrekFia0tj?=
 =?utf-8?B?ZGVZRmRmc0Z1aENkQ09ObDlnTXNXdVBiVWh4TG5TMnpRQkdBVnFJQ2ZaYXNs?=
 =?utf-8?B?Y09qekkzMllTZjMzWFVzendhazVpWVVSQnBBWStSdzI1VU80T1NRUmFHOC8y?=
 =?utf-8?B?Njg4ZkVhUXIweFE3Q1gvamxEWHptRDdST0R4MUJBRlBEelZNdGp2NmhXWTJ0?=
 =?utf-8?B?N0pHZ3dsSmpXZ2RvM0pNSUdxRGFhRmtpZzl4c3BqMS9BK0RGWVpNOXNST2I0?=
 =?utf-8?B?SWNhalJGT29iSWhPWW0zTldmMFo4Rm9EaHVpaFV0NzBna3pCaXhsMmxkam5U?=
 =?utf-8?B?a29JL0EvdE81SWlQZ0k1SjFLZk5QTUNrYXkyYnhQUkJaVDBLbUlwOFhVTHJL?=
 =?utf-8?B?Y3lMT0FGWVVlQ04zblFEUkFHR3RaZjQ1TEkralVlSk9iQWZHY3N1QnhhNGhN?=
 =?utf-8?B?akdNVWwvR2ZFUU96eTVNZklXK3FDaTYzTFhnclpEL3Z1ZW5pa3N1ZnVnTmNp?=
 =?utf-8?B?bkhISEJmNzErbUxQTmptQTFubE8zNlQveTRlTzZHZERsL25vK3MzOTV1UEJi?=
 =?utf-8?B?QmM3K1Z6bGphMW1rTlp0cjJtTWl1c1VhOGZldWR2dDNPS0F1ZnowbHVrMDVD?=
 =?utf-8?B?N2JRUVJjVUM5YXdkZVNBazF5dzFNMmxLMTRsM3pWTXBYVkRPV3VlS09NSlpR?=
 =?utf-8?B?ZTZtUnMvcGY4SVBGcVI3UkRkTURiZ0g3aVFjU09NRVBqMHByUHRQblpRMGdM?=
 =?utf-8?B?MHkzdkxIY0w5UFVOaGhNZ1Uxc3N5aG5iTk9jbkI2V0UxZ1NBRXBOOStMWUxY?=
 =?utf-8?B?V1NMTDlSRE9xUTNwT25JZG5abTkzS21yQlA2U1dkeXJQU1pPOFd6QktjTk1G?=
 =?utf-8?B?enREWnRpUUd3MEJqb1lua3lGUmVqekhISjVrb0x1V3NMcVBsL25iVERKRGgv?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7413d3-cb26-4fd5-519e-08dc2735715c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:02:47.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5do+Cwn1NL3gLU3wFJMe7UAFtH5+k6WfZbhfNsxFnfQ2+mGKMRxgJHqgsbBi9jVwh4h9cbL2HypmO/nypvFm1t0G3iiqhhH+JPLQo/HuxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com

From: Alan Brady <alan.brady@intel.com>
Date: Mon, 5 Feb 2024 19:37:54 -0800

> The motivation for this series has two primary goals. We want to enable
> support of multiple simultaneous messages and make the channel more
> robust. The way it works right now, the driver can only send and receive
> a single message at a time and if something goes really wrong, it can
> lead to data corruption and strange bugs.

This works better than v3.
For the basic scenarios:

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

