Return-Path: <netdev+bounces-180905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEBDA82E52
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBDF3BEB2B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B121270ECD;
	Wed,  9 Apr 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/hJN9z/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF4277012
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222486; cv=fail; b=iX3OVdvCaFBzhVp96h1+RIprQFp62xoZMQwL3BStoO5UNefqMO+62giJlMar+vMyYVeWIc43vjX9QrqAZWMquAm6KNgSzuzdLF3dRQ1jCyrA6Wbc3QwRpJuGq+SuBjacKAFDauuXqdMzfTWZuaLxMBNNRxT+netnlejAtstc82Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222486; c=relaxed/simple;
	bh=e5bkdIK/mFZZ7hRDwJmuWvNH1O4ES6BP3nhdDy9vpXM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nosPBoiDmJrY573nJAVGMXRG7yIHpPosPX0gMgJHWSEvEGtr0D0h3oGDFqqv7al/cN3gpWc7z09qohIIkm8sUG9F/Hg1eF/Yq6RflEikzqmDPda/MqsiqUXQ1aC8JAuGTm5sENKwieb62DlpcvciDqdKCMLgzmLdDvLJJzfeoIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/hJN9z/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744222483; x=1775758483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e5bkdIK/mFZZ7hRDwJmuWvNH1O4ES6BP3nhdDy9vpXM=;
  b=Y/hJN9z/ve9m5rZuOqllaa5AGV/a7bF4AjJ5yKB/VhxliaE2DogVqq/N
   BFMytG5MYXYuJIePGXDOgQgxiu/SHz2tdzxE7RhCpvGKgV66DNPBDq6Yh
   1T4Anlj6y2Xe6vws6txbxb8yn03Z0Tkizh0NOILtUz9HuE6q37On1kSvO
   BJrTwzS7dVHAyvH2NQRABR3f5BNb6f5fmO6z0o+LZ2EYoe4gfbwJFz8pN
   ZCjZm1KXElUOI5M4X1rvBZ6Igevge4HBt4HSPSs2GbGscqe17SBI5ID56
   vP9CZsWx8MpHkL8g5kSzc1G06gHCHXejrKHSd8KFxtfx3wfk7Po+1JWVB
   g==;
X-CSE-ConnectionGUID: iOeAJsEjQ+KbjtWEKJ1ZjA==
X-CSE-MsgGUID: CavswqvITHWyP2TlXK6R5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="68199460"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="68199460"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 11:14:42 -0700
X-CSE-ConnectionGUID: Pm1JRRCxQbifzvlOy5gkTw==
X-CSE-MsgGUID: HJPiNvmgSlCD3oSoMK0tqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129014995"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 11:14:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 11:14:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 11:14:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 11:14:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHnX7YPSH5HW/l4sjBYvaIPaUolOkRAg9t0plZWuB8xFahgpEnDWgws407n5ue5TlNBF7Or3i20NvwAft8KtFdgK7WWi+wvUNyYJtITBU94AF5eC7ork9zCzl6nlImSOaWOy6enhHUZ3UDAhTyXWLS/iqbciWZoozVjbsaDCalScbTEi9kgEhCPeKLeOZksI9gmQRJ5U/GpJXKqRRxUxAqKS2GOCuDLU8p5/t8ucWHkYalVVYqL7xT4aC2QWlFvmMb6+zHskRbbQb6sRwXQix76l6mnXfcx5vQdHzPQJ7uBzYvr8Zn++C9vhI7tp5eysrOI4COTqBWHOjebRTuMZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRUnj+Cqo4BmdltuhNG0+spbZn/0JxLmFukiQDdC3D8=;
 b=awo7rv2kGDyraumXC+Y/lNYRB24zAHhnajdpZtPYGwYXDPLFbavHqaWq+R7RXw8iWsgNigK/tpkW0HeyCDlji0KW4JgZRekroqVsX4fZcB9TS9EuPs/Ys6jwN/7bpwAFRCYKlcNPcd5MPrUMMasSHgtA71iJ4iREmhwZEVrnr75e+T5bDANZAGNgjsTOoHOdjHqRhIw/6rN5uod47EFuJNJs+eYNgcL2c0OtrR78zlz2XFOL4MfFyXvtobYlftFDrPyQ6UY69sK2rgO9Z2uzkOMRqS8HMgH1c76B033iGfKrBkFl2P0crjl5HNXOZ75XU/AV48kifK9aqsH6M7ZELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 18:14:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 18:14:38 +0000
Message-ID: <6f596fe4-5058-4c56-bd96-9bdf73605f35@intel.com>
Date: Wed, 9 Apr 2025 11:14:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v10 iwl-next 05/11] idpf: negotiate PTP
 capabilities and get PTP clock
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Willem de Bruijn <willemb@google.com>, "Mina
 Almasry" <almasrymina@google.com>, "Salin, Samuel" <samuel.salin@intel.com>
References: <20250408103240.30287-2-milena.olech@intel.com>
 <20250408103240.30287-13-milena.olech@intel.com>
 <fd2098e1-c5c5-4cf8-b34e-ebe0bd288248@intel.com>
 <MW4PR11MB588927730666406EEDA9B5A58EB42@MW4PR11MB5889.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <MW4PR11MB588927730666406EEDA9B5A58EB42@MW4PR11MB5889.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f23691-e4c5-4e15-00dc-08dd779263df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGNmcloxYXFMSitod04zbVVZdmpHVDMvbzlRVExxUkVoK3Q4a1VFVjR1UnJ4?=
 =?utf-8?B?aVVFdlhyS1JENzF4U3ZBWWlUOU1uWCs1MG1MTzE4WThiWDVnUFRYS1RFYURs?=
 =?utf-8?B?NkY4MnowRHVEcFRLcGFZQmNMSm5NcEhQRVRLcENKQVZCZUV1ZkpvMGNMQXlD?=
 =?utf-8?B?TUo5SXh4Ny9BT084eXlYRG16aXFLUnNPUEJUUFoxOUZqbHdWcnB6OGJ1L1Z2?=
 =?utf-8?B?b0lHNjI4Y2pwajV6SDA3dTFjNFhISGVpNWl6cHRnMm5vaDhCNVlxajl0NjNx?=
 =?utf-8?B?MTNka0NLR0xseWkwcExvSC96S1h0NnpBalZqbjZDdkd0OVVacjd3RFZWbnBW?=
 =?utf-8?B?dDV3c2ZSUVFZc2p1YndaOGd5RGdxYVFubDUzVG5aYVFFa1VLMmIyalBXMzRZ?=
 =?utf-8?B?NUs5ZmRyQWxiQTFYb3l4citQWEFoV3ZpbDltWE5JVklKbnhwMW50dVV1RFl3?=
 =?utf-8?B?NFpTMCt0QTcwYlBXMHphRzBVOVUyK3prRE5xSVNWTHNSN3FZcktWQWFseXc5?=
 =?utf-8?B?YUp1Wmx2NkplN1h2U29vV1QxK0JyeUFHZlovWkh1bHR4dThJWnhkK1JQcXpN?=
 =?utf-8?B?V1lDdHZqWDVWdlhZejdyYXhLNjNkdDVsazZrZnJuWStXYWxnSDVYY1AxSkla?=
 =?utf-8?B?NXVkWFZWQWtzMXpJdmoxcTErRVIvRXQyaUlhS0Iyc21sNlpZa1creGJ4TUVt?=
 =?utf-8?B?Mld0Q2s4citBRDN1SDFLQ2FiVlJOS216MFRCQytBdDdJYkxRcENrRVZBZlZl?=
 =?utf-8?B?aUFlZkNmUzVYRGVIME1mRnVtWkZuV0Z2Yi9vaitYTmRveGZvRytqS1l4ZDdX?=
 =?utf-8?B?aVJaOTFYd2ZXajVycjkyazIzemxkVmlHRjFRVDN1eTY5OVNmY2pQMlc4cEto?=
 =?utf-8?B?THB2bktScHZDcXNJbjlFZEcxR2wxS1ROUDFWU2NmVjVuck1oL3g5eUtlbWNC?=
 =?utf-8?B?RjNwWEhlSW00MHhBR2FjWW5YYk4rb0RQZUF1WDZnTGh6WXBQeXdyTGFBL1Q3?=
 =?utf-8?B?NmV5UE0wenVzK0VJUm9LdjE0TnVOMEdSYzBySG8xaGxBY1ZGekdlK1BFSkxx?=
 =?utf-8?B?TEZaSHhvZWRuNTVTaXZGTEF4RXBUSWJTWjQ3eHo4SEc5QWozbndsaVFyUlJS?=
 =?utf-8?B?cENCZFlRY0QwY0QyWDZHbjIveVpRdVBULzdXZTc3ZmF0Qmk5aXNid1pJaGlk?=
 =?utf-8?B?MEZXbkdtZ3JpSWtHOHg4VVA5Ti9ZT1pITHpqV3ZLL0p2UGJXczE3SlFpa09V?=
 =?utf-8?B?cFdkQk1pVUg4bGFabFFCV1JLMCtBQkZMb2ltUDYvWjg1aEp3SnE0WnAxdE9v?=
 =?utf-8?B?ZCtXWnBDS0xONlJLMVNGVDdtME1pN2pmdVJteXRyK2pxSjd6MzNPelFxN1lq?=
 =?utf-8?B?bldSa29PaTZ3aGdiVWoxaHlOZk9EbEh1U3RBRzZwUnNZcXZqS1dxalNhZzlH?=
 =?utf-8?B?ekFTUld1NlFXRXc0Z0pNT0tsQWVyMTJOUWFielJyZzBpZXErbzhxY1NTYmpQ?=
 =?utf-8?B?SzZ6dllWQzBqd3NBUVh1RGg3NUMyQU5YNlpnZHIyWW9jOUhQZ2tMTkwwRzNI?=
 =?utf-8?B?RFpva3p1T2t2NWlHdXpvNjhQWUMwL1dObDZCRW81VDFnRk5wWDkxMTRaYk5q?=
 =?utf-8?B?UFRsSGxjOExIRkZTMEk0RWVIQUJvK1dicnVSdEcyc2VBZ2pVRVZoMU53OENK?=
 =?utf-8?B?Wk81UnkzZmR1dVhBUE90dDI1RncwOXBDSHJUZDR2TGZwM2xud3BMMThqK0pz?=
 =?utf-8?B?RitPMW94YnJZQUliNWlnY20xU3NwY1d4bFZ0cHhrTUJ2eG9UaGR6YXFQeU5S?=
 =?utf-8?B?ZTkwTy9CeDNuYnlpMHlpT1EvZnRhOEN1SmxJTEdjY2thYzUrQXcrSk9LRy9S?=
 =?utf-8?B?L0t4Nkw5K0tSUDZXUDlaTWhxUTFua09CODJnT3BLLytsNHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFLZlRhdklZUjYvZkJ2NHBDZU5SUHVqaHVicnZEQ0cyQnZHeDY0c25EV1pF?=
 =?utf-8?B?aTRnNW1FUk40UC9zS0FlZUpBL3h4VnJ2eEQyMUdHTERXSW9DTDhmQ3hOYjQw?=
 =?utf-8?B?MEhDMDVWalJETGVrRDBwd2RIYlAzS2pJQVFXeFUxeWY5V1I4THVBRHlheTNt?=
 =?utf-8?B?UElVdWhZMXlKc3dlb0RDNE1sTEpGc3VsQ0REc1A5akRoRFB5Nmdhcll0YTYz?=
 =?utf-8?B?UWwzRW5KTGwxcGxiam9naU0zZGh4Z2lOZzdwSUhhQXFsMDVSRi82dENyL2g3?=
 =?utf-8?B?ZUtwdW02cTBhTE1hdjQvcW9Jb284TjhSNDNTSXdncnQ1QzJNazB4KzM2aXhu?=
 =?utf-8?B?dTM5T3huWG8xMUdEa2hQeDZIMzIyMU9NcmxUUWZMVTZyd3lZSDZ6SFZ6TFNh?=
 =?utf-8?B?TXFOWDFtektPaTV2SzQzcXVpSmc5dWtpMWU0d01PcFhBMENJc1BxcVlHUVlL?=
 =?utf-8?B?aERVdWNWVmJzZmlLUmZiTm5JcElYSzdTSGhRV1VpRmlQY3ZzSmZnV0lEV2Ez?=
 =?utf-8?B?Vmozc3l1OG14cmdTVkUwRElBOXloOWdFbDlWSkhqejhHQ0JsbytmSnZwMTNz?=
 =?utf-8?B?YjZWUGZHaUxEMk5KM2ZVdFQ2VVViVHZSbDZKYi9RTGt0L2VRRndBVTYzRUpB?=
 =?utf-8?B?eWJyZEk2cTR2TGM4SmFmdncrVTVFZ2hNQ3FQaktrOElsR0NaWU1vcEh6TGI4?=
 =?utf-8?B?NWxlZ1JURW9GaGhROW5aU1htMmQ1Uzl5dEJLU0ozd01aZ2pQUFJ4QmxQMGJu?=
 =?utf-8?B?Uy9ydXlEUWdTVVplbkpwOG5zdFc0eXFwU3pWU3pielpiZkZQNzhFTENra3lD?=
 =?utf-8?B?b1lMT242R0Q1S2VIUjgxcEZSdDM0TlNUU2daeTNmVm1ZbWRuMWR3Y1hZa0lY?=
 =?utf-8?B?SUtETy9hSjZmZlJMaHRhQUwvZ0YvditOOEVQbElpT0JOS1Btd0NjcTZydnNF?=
 =?utf-8?B?S1pqUm5LTU5lNVRrTk1uL1NNcDFscHluSWEwRzE5WjIyYTFtUFRqd0Mvcml1?=
 =?utf-8?B?MHh6dmNPSVpIVTVyQWE3R1ZCSlh5SHMvcXRPOW9HVzBsbGpKNzJZdUFaQUFK?=
 =?utf-8?B?TStIaFcyUE5RajlqaUZBU3FuTHlValFGSG1nYW95dTdxNXRZMEJqT0NlOG10?=
 =?utf-8?B?M2kxZk1BVk5rYkVubGh2UG8rUk13Sy9mWWc4cnFsOUY3elNYMVNDd3Y5VXpu?=
 =?utf-8?B?TnNCb1RJS21JaTVYT0k3QmkwMVFpbHkzbk9uQTdneU1sUTQyMW1CWE9UOTl6?=
 =?utf-8?B?WWJLQ0lHaEVIK3pVTFRReUZ1Lzc1YWl1aGdjM2FJdzRRSllpVGx1OVFNUk10?=
 =?utf-8?B?UTljUzR5V2xMYk1xUUlFNkh0L2NtYmZTZGRZdFF1cFdtWmhremFxWTdrZkFo?=
 =?utf-8?B?ZHMzeEp2U0tTcHhlMFd5eWptdm42K1c2c1lPcVJheG9EdVBlYTNyKytoZ05Q?=
 =?utf-8?B?NjAvaTVCZWlRY3BwWEtlVmdlYWpoaHJvMG5GSG1hMEZBdm5lalNLdjE2MmFX?=
 =?utf-8?B?YTB2SlJKd2ZaSUZWazFmOUdycUdOejVTRElDWUNtNEZpZXA5MUZpL0plSERl?=
 =?utf-8?B?REtWR1M1bmFnY3F6RkdpblB3eUZrMHJ1UUhCendRdFhXVmVDSWdFV0p1anlT?=
 =?utf-8?B?bm1IZFhhQkk2TjhkWi9GZFpkME9PZnBOQXU3cXlnMVh2Q0l5blZSVGR5ODEy?=
 =?utf-8?B?dnUydGtyNWRmS0htaVd3dzZ6YVpVaFZuRGRkL0g2M1U1ZUYyaXlsWFc2Y1FQ?=
 =?utf-8?B?a1RNV0lNR0V2V3JyZ2ZveUVzM2tEYVJPZWRmL2hVUXJoOHVOWVhEcmMxUEpV?=
 =?utf-8?B?Zk1odCtnZEc5eFdiRm5vZnhYN2haMWVrSlFia1hXVFpPYUo1WDhRUEhtdjZQ?=
 =?utf-8?B?L2gySVI3Y3hRR0lxdWZ4ZDkzM2Z6ZlBtZk9HNWh1S1g1Z1BWZWcwd1pDZUUw?=
 =?utf-8?B?WC9kckhsUmlPUUdqZm1JYXJwZXVIa3QzcVRrUndXMFdBU1lYc1NlK3dmOFFG?=
 =?utf-8?B?U1F5YzU0ekhSOVAvaEgvNG9SN1dQYkpxdjViSVFFQ01qamgzNDY0aDFYRFJh?=
 =?utf-8?B?SE9jbDFhd2dKUXkzeTF2a1FGSG5QTzJ0b0Noajk5S3VIMDVCbm5ML1F3N1dX?=
 =?utf-8?B?YWpCYW5rdjdmUno5TUFoWFFwNk5GNm1rbE1WbllMTEdRMVMwYm40WE4yUVRK?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f23691-e4c5-4e15-00dc-08dd779263df
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 18:14:38.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weHBD80wtbZK0ikhER1ONlF8m/AfHUWyEl48NMcT3caSqi4ql6Q8ALpiP3PUmYubcX4yvDgQ8hn/UJzg8qcMC7O9qNtsF3IdSB0LHOYzN/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com



On 4/9/2025 5:55 AM, Olech, Milena wrote:
> On 4/8/2025 11:15 PM, Jacob Keller wrote:
> 
>> On 4/8/2025 3:30 AM, Milena Olech wrote:
>>> +static u64 idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter,
>>> +					    struct ptp_system_timestamp *sts)
>>> +{
>>> +	struct idpf_ptp *ptp = adapter->ptp;
>>> +	u32 hi, lo;
>>> +
>>> +	spin_lock(&ptp->read_dev_clk_lock);
>>> +
>>> +	/* Read the system timestamp pre PHC read */
>>> +	ptp_read_system_prets(sts);
>>> +
>>> +	idpf_ptp_enable_shtime(adapter);
>>> +

Aha, I see it now. You snapshot the time value here.

>>> +	/* Read the system timestamp post PHC read */
>>> +	ptp_read_system_postts(sts);
>>> +
>>> +	lo = readl(ptp->dev_clk_regs.dev_clk_ns_l);
>>> +	hi = readl(ptp->dev_clk_regs.dev_clk_ns_h);
>>> +

And this is just reading it out of the snapshot shadow registers. Ok.

>>> +	spin_unlock(&ptp->read_dev_clk_lock);
>>> +
>>> +	return ((u64)hi << 32) | lo;
>>> +}
>> v9 had comments regarding the latching of the registers for direct
>> access. Can you confirm whether this is known to be safe, or if you need
>> to implement a 3-part read like we do in ice and other hardware? Even
>> with a spinlock there could be issues with rollover in the hardware I think?
>>
> 
> So in this model we have shadow registers and we trigger HW - by writes
> executed in idpf_ptp_enable_shtime - to latch the value. I've made some
> experiments, where I removed this function call, and values in hi/lo
> registers are constantly the same.
> 
> In other words, it is safe to read values from hi/lo registers until
> the next latch.
> 
> To my best knowledge, ice does not have any HW support, that's why all
> these actions are required.
> 

Yep, ice doesn't have a snapshot like this, and neither does our old
hardware. This is much better: it improves the accuracy of the sts
values, and is simpler. Nice.

Now that I understand what the idpf_ptp_enable_shtime does its a lot
more clear.

Thanks!

> Milena
> 
>> Thanks,
>> Jake
>>


