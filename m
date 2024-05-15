Return-Path: <netdev+bounces-96499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA38C63B8
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECB0285210
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1159168;
	Wed, 15 May 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idjcIBKp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687C58AA5;
	Wed, 15 May 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765566; cv=fail; b=M7kdKwmbqn8wLXXl5mypZkRVqAcyMixRTcPzuxx1TkfRhGdMvppkCMJGXztEIbRd8DEujpRvijKrIY9m3O6wjA1BRYF5q2g4fC6vM9BJ1NzYEDYLF+0aQue9SNnpT8UOMJae0CYPyKxkOCWmmcYI5BlgVQ8j8o7ZClQne7wfyc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765566; c=relaxed/simple;
	bh=aEH18198SMTaF4smWnhHym7fHJ9FlYSUUgjZx4yF11Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1kqWmDx0tGGtvnppdPy9a8qWXYW9IMdiopV7PEFYWNvep+97VuN5a8/xBbVb3H6qKUAUe4RHr/Ch/MSJn+zbTpaQMDVfzEQzzkkVM4iH6gf1K/8lK6I2O0ENbXSLtYYcpWKvzBTJp+Hg/l0P/uYUs7WCE3i8on9S6KonlOOtRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idjcIBKp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715765565; x=1747301565;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aEH18198SMTaF4smWnhHym7fHJ9FlYSUUgjZx4yF11Y=;
  b=idjcIBKp3V7Ws8uSED4v35Ygt5owjleD6nyK9M6j0jI2X9oVULfqkftG
   WRuAWLwNSpi1uJGo0Hw49Xp0N4/TE1NLmiSBWI5lh0tuI3ns7kmfMqdG5
   itvoZa0iQNDZdXChndnrNeKoHPVpPQ9Ifx++yl1MDJ1kE/ZF4NtUrGClp
   FzxfsTD4+m9mrSAhd22JCccFE0rixdEAvxC30xzAQJulT5j3uLYHmS6wL
   6zE4FV2K24OiQ2CLCtRA9Dvf6JNYTTiq2Uk19e/3me7Yx0zXNEWkYCk6T
   LJdyHq2en4khy+U3TFgnp+RmDBYgYVoDHk4xDE25F+6k3XzoRODNSxmFR
   A==;
X-CSE-ConnectionGUID: asl4CRO2SQe+B4AAAT0/8g==
X-CSE-MsgGUID: OF2bJC6iR46woWV0mRsU+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11536102"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11536102"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 02:32:43 -0700
X-CSE-ConnectionGUID: eKaG+aWbStWRP5KmWhnXtQ==
X-CSE-MsgGUID: Tpt5adRERWOiJ/a9DIL1ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31583349"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 02:32:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 02:32:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 02:32:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 02:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/0wf5U9IyfIxjs+1Z+fqFcmY6R1dsAPe0jZjEcjhNN823LbStG/gOavUTCuAmXda9zV9zg8X5bOVAWXkRsO5HGJEyC3WQpXp2shlPFgIEvTMnMmtatWLJScsztwXzfn4c01TA4ikXylCRknq75qzTdyTzhpnQmS0rB1ppu9CPyLN2m4Ty0L0FYQRdKWShzMA6hUyctaIZ6gwHryYzl0yj4egzxD3yEtJi8sbSqCX88/l4p30+xKDaob2lAuOVs/2HKYa2Id+mPDlo0PqMT3ubsyfaPAKmspXYNNJInOLrxxg2fAU/60Hg7hY/N1uMmgwZvAzGx5E1BuuPCGQLyvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82TIYoouAI7AoyjLQIRtIA4xIuCRpduZOsXGbWJfFQ8=;
 b=WBvtTEJ0UwWsPLZdlfjuPsYAJpxme8YaFowftOWSjaW7H67vg/W9KdLziqNl4P6ADh6/PcVr9eWUwNFjWwoZ+1Nsg1Lx/7e7LlOGp9AIweUd+f21CYXv1aNIhKPcLVWpjG1xdbDP6mwk6qLBNO7mSGIaao3TzlQpJJ5WT7m2VLgpjtkb4MPY+kdyPBSxBUVIEcuGk0M2qFLaYIR5e/9HXRzVE1EKKa1X8EMcPc7EaURw6+WSloGBV/fE960BxIHsoRA8GpGPHBq05H6UO9xHIkRobUaDzWaTBlZdKrZtJtPXEl5tJhFuIT5qc7snZLyy64Ng5RVMlbmwHzgwBmflXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW6PR11MB8368.namprd11.prod.outlook.com (2603:10b6:303:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Wed, 15 May
 2024 09:32:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 09:32:38 +0000
Message-ID: <6d994163-abc3-4519-becd-b3813a43bf49@intel.com>
Date: Wed, 15 May 2024 11:31:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: don't skip over ethtool tcp-data-split setting
To: Michal Schmidt <mschmidt@redhat.com>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Michal
 Kubiak" <michal.kubiak@intel.com>, Xu Du <xudu@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240515092414.158079-1-mschmidt@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240515092414.158079-1-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0257.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW6PR11MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fb8d20-9ca9-4720-1245-08dc74c1f606
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG1uN09adHNVanpqQkVFQVhXUDFlcGRhZjRlbVUvYVd0ZlVTT2ZQVFhiZkd4?=
 =?utf-8?B?VWJzUFBYRnJ1amtKa3dCM0tEZ28ycVBxeG1HMTlkMzhoYzJqWUF2NXc2b2hB?=
 =?utf-8?B?Um9pd1JXbWdEb29MWEkvT1NvWXY5YkVjN2xZU2ZVd0hDNklRcjBDRUdaaFRE?=
 =?utf-8?B?blpLRzUwb2tJVXFjeGE2L1hQT1ZwZnhZT1BaYkY1amduOWdlV0NIM3pBajJw?=
 =?utf-8?B?MkdLVnRNSTlOdzR2OEJlTzE3UDA2UGFuNUUxR2M2RHozaUgrME4xS2hGR1hY?=
 =?utf-8?B?d09aRkxtdWl5R3lId0liYUYyNVlMcHAvZ2ZvNVZpcVdQb0N1REVka0FiWUNm?=
 =?utf-8?B?b0MzUkpSeStoSTlRdW81b0tDVU0vam83VS9Fc25DNFR1OTNPZnduV0ZzMXF6?=
 =?utf-8?B?WVN6V3RlaENubHRUYjZOencydFNHd3dEWDhCcWxGenhpd1JlUU9EaFJyV2pm?=
 =?utf-8?B?WkRsN2JZRWxMQWRmZFdhNjUrKzNJN0ZnZ0dmWGkzMmJmK0E5QmpWVHpQcXJx?=
 =?utf-8?B?R254K3Iva0N4czVUMi80VU15SWV2VThhWERldVlickdiNzJtck5UVHdVZjA2?=
 =?utf-8?B?R3NZWGNFbHArVHh3NHBlcS82Zm5kVXlGWVlGK0tkZkNra3VmMkhxMHpneEc1?=
 =?utf-8?B?dFNnNFMrM2V3RmhQRUMyZTdHRUgvRTR3MXk0YnBlcDJhSlZKTWRZU2dFcFFD?=
 =?utf-8?B?MlRFYTdHVWl3bkZEbG44MjhkV0NmYzlzN1ZKYTlrWi9KcjdrbWVVbklIbXNV?=
 =?utf-8?B?WFB4a1UzZnFxc2JJWlNtWW9OVGpmZFdZWmduVjEveXVEVUdQQkVFdmlWYW9r?=
 =?utf-8?B?d29LSVNkalJaRGwyZTMyVldCQ0F6SlR6TFVqM3M4WXA5TWdtbFBMS2FTaHpP?=
 =?utf-8?B?enFRcXU3aUxRM1ZzRXpWVyt1MU92TmgvdVU4aXY5MlpXSy9iSCtNRjMydHpJ?=
 =?utf-8?B?OGZNY1JnV25yb2ZLeTd6ajcvMVZRRWpnNkZFKzhTc1oxTXR3bzNlbUFUaHkv?=
 =?utf-8?B?a29jbWRTQXhBZHArSkpGNmdsM0dlaGFXcVJtMGpBVk9ZNytpWCtqTEFPbHRR?=
 =?utf-8?B?SFdmRlI2T3Voc3JReXFIRFFUV1pBTTh1Qm91bzRVNFgzdmYzaTZnaVZUWllE?=
 =?utf-8?B?NitOMVVRaWVQdHNrT3AzdC9oNEU5akxPQ1RndDN1REZtOGhYSGdoSUlpM0gv?=
 =?utf-8?B?QVdYTHdtWUM0eUpQdi90Z0VMeVZMeU5DVU1qQzZpSlR0RkhsMEpkbUZMZHU4?=
 =?utf-8?B?eTArOEl4UDRKZFZRWHc1VFQwYU9nd3pQbjdraHlsd1lzMzlmTjRPMDFWaDNm?=
 =?utf-8?B?KzQrdmFZZ3RSR29hd1lyWHBQUzlaR0orZXpGQVF0Um5XaGw0cktMT2t1NTNt?=
 =?utf-8?B?ekNnd3poRXZsMUdmaTM3d3VzT0JJZFdZMDNLRURoamVjYjV0cXBEU1ZGU01i?=
 =?utf-8?B?TGRNZ2xoMWxQTXcyN1g0MWdtM2FQTGlQU3ZKRW1pVmNGbllCdzI3N0lZeXJQ?=
 =?utf-8?B?VU5UVHFYYkpxMHdscTUwQTRFM2Z6S3E0QVUxaC9iT3huRUpVTVZNT3RYaXBa?=
 =?utf-8?B?dzhVQU90RktBMDlNT21Qd0g3bEZQYWJNbExDc1R1cndScmduV1NHdzBDdzBa?=
 =?utf-8?Q?uIKYHLD/5sCcx9gvyv3uLtJLEg+DGKj391S+ZPNDLwp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUh1WGhwb2RGMFhkVjFLYVB4ZzhlVkdwb2ZGdHFsblVkenpEWVQvemduQm91?=
 =?utf-8?B?M2VDcWRNcUtXL0hwRHdQaTdlVDZZNVV3Rk12czh4UUFHTTk3Q3JMZGp2Nlha?=
 =?utf-8?B?NEQ1WHR1ejVhclhDZmRkRVJKdkpKWk9paTdWOVg2cSs1TFNscUdIeHhTNXds?=
 =?utf-8?B?Wm5uY0ZaY0tzVFpoU3RaVUNzamxVeTNaRWIwVGc0dmFzN3IrRUsyT2FOcGl1?=
 =?utf-8?B?MnZMVUMyZ3RQUVY0a1h2NEx1TjlBQkZscDFwN0FndFZUMUV2TlJnRk9sZE5M?=
 =?utf-8?B?TXZZR0FVTjJxSlgyMmZQZmpRRkc2UWNzN3NpdGxMd1pSczNsbHhBTjVIZ2pR?=
 =?utf-8?B?UzkzRjB0aDFHR1ErbmZvSHY4UkVEK1FEak5SZGVQZklsN3RadnJxa0VkZjRJ?=
 =?utf-8?B?Vk9ySXA2TkUwUWlZdjU2aTZsTjJxWUhOa2R1djNadmkybEljdm9pWGVyM2Er?=
 =?utf-8?B?aVJvVTNpWWdMTGk4UXNoby8rNDZhWUswRU5KNkFBUG9kYmIwN29vUGNDeDRK?=
 =?utf-8?B?SlhDWWxWdUs5bWFPK2lYUVRRazFkR0Fwa0xQZU03bGsyM3djRXlLNEtnTW9O?=
 =?utf-8?B?R3RVV0ZKWTFpQnNEdVRVYzRROU9xdC9BQXFiV3piUDZmOXk5c2FpdDMzWTVO?=
 =?utf-8?B?czVDRWM4Zm41cXc1Y1FVSFdwMmQreGhTWnh6RTJxZlg4WWpzRGpWZ1JtMnNW?=
 =?utf-8?B?RkgvdTkzMUFmL1liYndIakZjcnN4M2JyRzAxZmRnWHJ1ZXYyQzNRSDJKTkJG?=
 =?utf-8?B?cGt2YS9lUEJlL2RyUFlZN0tPYVo3QWN0SE12RFN2K0M5YVRkNmgzZFIwdVVW?=
 =?utf-8?B?czNBeWRIRW9kYXN4UFdCRi92Qmc3dkJCZnVoZXF1TnpKckNpbXVkbEFveE5o?=
 =?utf-8?B?ZjVZMXdpblY3N0IwYjdDMXBOYUVZY2VFbGhaK2MrSkFHTHJlZnVDSitscndR?=
 =?utf-8?B?Wm9zV0JDODJsRTNlRGVtUmNNUWJvLzF0aklTT2hVREdKaHRsbWkyMUlOdlp6?=
 =?utf-8?B?SjcwZjdGQTZ0c3paeUZ5UVM3bEZjS2ppc2NzMWg0bnF5cmZtUEhZOU9rMm15?=
 =?utf-8?B?enliREpXS0s1RTZUUzR1TVBVaithTU9Ub3pNWEZjcXRZRnptV0tTZ0xqRS9u?=
 =?utf-8?B?TWVydXQvRGNrYmVvNDh4VzVmNzR4NnRobURiRjkvY21oYktreVlTUldJMUZl?=
 =?utf-8?B?bzIwUzgvK3FrSFI4YnY5cWNtancyN2lHWEtDQmgwSFdnd0hDbEgzVTc1aW1s?=
 =?utf-8?B?V2g0MmRpR0xLNEpaenp2dldWRm9aOTRDQk5NMlZqc0l3Tjd1b0hxZERqeEgv?=
 =?utf-8?B?ZWdFVUFhWTZ3T2FzUVhTZjlPMmMxeFNtOVpzSEdyRjhXekI3dlNZbXp2SHRu?=
 =?utf-8?B?MEZ5N2lkU1p5T2Zxa2xRNjJFaVVwdEt6WW43RUxEbW93bzN3NnBZbkl2Mmxh?=
 =?utf-8?B?djVHcE1ucDFFNnZhajZEa0xOaDY5ZFR2K2dSMkx3dHd4TWlFSnpJVTVTVUgx?=
 =?utf-8?B?NUVJb0x5TVM0Q1gvVTFOSFRIbEZuOWF4L0ZzQzRWOWtzWWtVbUpjcjVpK0Q2?=
 =?utf-8?B?K21JQjZwSEpsV2g3cFJNK2JraHYvVGFaREVKdTJYRGc2N1VveWllbTRURDlU?=
 =?utf-8?B?Tk5rUm50SDV3dVowNFRreHB6Z251VFFWcEVIVld2VVhVdGVwSFFodkI2UVBW?=
 =?utf-8?B?c2ptK1NiQXl6UWs5MzZ4OHpPTnZ1REREcFlNTE9yYVNJYzJONHRPQUxkQXZ6?=
 =?utf-8?B?U3NzOU13QVRCeFhsQzZ0WFlGa1lyYUJnYlhCTzhHY3d1aVM1bnpLcnA3bW5Y?=
 =?utf-8?B?WUZFTERkZjVEMWtScE14T0N2RjUwU1VHRm9KREZ1dHNJMmJ5NllacGJ1allO?=
 =?utf-8?B?SittYlIreFFLZXVLTTlUV3VzTlAzbmkzdVpVTlBjSnZVdUpqN2RicGlIRUw1?=
 =?utf-8?B?UkpkTTJEcEVQcnZPMVlyVXBJN3VUWlluSUowYUZwdlVCQ0JiamlaY3N1cWpy?=
 =?utf-8?B?d3BYMzdhYnlVMHlRM1dUanNrSEFQNGZxaUF1ZVJLeDZOQWg0L1EycUhiK09F?=
 =?utf-8?B?RkkxN0ZCTnczNVh0THpjL0RTbW1OM2NYQUxjaWxMbU5YSHBTdzhORUNlZGxh?=
 =?utf-8?B?cnNsL1hNMDVXbFFxTElVWU01RWo4bDM5Qm1weXNVR3Q5TnJYZ245bDlFYWFV?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fb8d20-9ca9-4720-1245-08dc74c1f606
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 09:32:38.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYqMr/mck0NvZglFB6p9d4DxxYFmeLB9WaLHSsjV/JEw9qhLC+lNHUrMk6vxZDR2KJVR/aok+yzRBp8pFkHRKAJmjVZ7eILBoquiBWkVlTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8368
X-OriginatorOrg: intel.com

From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 15 May 2024 11:24:14 +0200

> Disabling tcp-data-split on idpf silently fails:
>   # ethtool -G $NETDEV tcp-data-split off
>   # ethtool -g $NETDEV | grep 'TCP data split'
>   TCP data split:        on
> 
> But it works if you also change 'tx' or 'rx':
>   # ethtool -G $NETDEV tcp-data-split off tx 256
>   # ethtool -g $NETDEV | grep 'TCP data split'
>   TCP data split:        off

Oh crap >_< I'm sorry, thanks for the fix!

> 
> The bug is in idpf_set_ringparam, where it takes a shortcut out if the
> TX and RX sizes are not changing. Fix it by checking also if the
> tcp-data-split setting remains unchanged. Only then can the soft reset
> be skipped.
> 
> Fixes: 9b1aa3ef2328 ("idpf: add get/set for Ethtool's header split ringparam")
> Reported-by: Xu Du <xudu@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-36182
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index 986d429d1175..6972d728431c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -376,7 +376,8 @@ static int idpf_set_ringparam(struct net_device *netdev,
>  			    new_tx_count);
>  
>  	if (new_tx_count == vport->txq_desc_count &&
> -	    new_rx_count == vport->rxq_desc_count)
> +	    new_rx_count == vport->rxq_desc_count &&
> +	    kring->tcp_data_split == idpf_vport_get_hsplit(vport))
>  		goto unlock_mutex;
>  
>  	if (!idpf_vport_set_hsplit(vport, kring->tcp_data_split)) {

Olek

