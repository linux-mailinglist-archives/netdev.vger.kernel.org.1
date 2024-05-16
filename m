Return-Path: <netdev+bounces-96704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC28C7359
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 11:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3681F237C1
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D7B143738;
	Thu, 16 May 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjzUamS7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C912143720;
	Thu, 16 May 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850019; cv=fail; b=gW0HQueUzQ9CacKSd0PfNwp6B0vS6qa8JwWV2Z0Pw8lky6xhbYst6Ad4y5eLVbP4CfHL4KseAviGWu8NcW2eRn7d06TsbUszqzVFTlkV2YWeb2Pni456/JiI2MmQk9BRIlaPyIWyECuFdXVsGSFvV3mVBwnorlqpyLLZTkfA6Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850019; c=relaxed/simple;
	bh=6gYMZ3GgBqlhyS6iCJHET6kJfqyADCTjh1Ll9MfI6jA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IKQJfyi8DC2Ky3+Hyed7WWW8xIDukdoKIpnIK4ij5RdXXbCukxpymTL9i5Y/IRizrXPZ3gv3DLShwFyjprwsdro6sXipjnoN/NKUn96RBUhMkcdU94FHDQ6NmlhrPmXJ7LdOoatj1SycywscPmXBYPGCIeZRT/57gNvSkhWztIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjzUamS7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715850017; x=1747386017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6gYMZ3GgBqlhyS6iCJHET6kJfqyADCTjh1Ll9MfI6jA=;
  b=VjzUamS7wa2efEvgbUmWslYkfH63VycvMLs1cN5I7bL+vkIl/1QIcE9h
   V3rzrKAwPLCWjDOWlMnLM393EUTFoYpOT3Qtt6GX8sjaxG3n2stFOWZxy
   BY3H8Kg1uCqkioCPg4VJQHF7PJ7wGnNkV6MUfKIzjsbKHQBbDBzamFxGv
   SguURBt2i4ZaoooRnnYsygUwVfEIDcOlNrNKrKrcDCk8Fv6PTzgUjKsrg
   0JUQyeNQD6vqrCmYkyLwVogPPVSUHtEtA7eETIFu/cj2EDbsIun9VmOgF
   DWDNRhoymccUdVGVbZ+I0HJk3hSDEvjYGiRArGkBRDCxhVvnkQNNCYMxD
   A==;
X-CSE-ConnectionGUID: Y/ZPDGT1See0Z4PSRYwdLQ==
X-CSE-MsgGUID: NKNDb1OtRI2bjqYepk9QQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11758002"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="11758002"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:00:13 -0700
X-CSE-ConnectionGUID: SC1MTSOWQNyWiVIuqnwbFw==
X-CSE-MsgGUID: ZOyCD4oKSTeDIXzaMU4EbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35874270"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 02:00:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 02:00:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 02:00:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 02:00:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cres9qkQo0TNdT3SzT1H42KFjaFNZlG06I3a5aG/JXPeSN2CAoqTdVwyxDxzq4mf1J9t4w57GA+JwKugbcruXxdgm+pRffOiCwDEl5DXsjCsuXW5dPwSBnxGCD2u2swCznSxSdriz95CSUoMeCCyqX4CLLDQKZvhtpMs4lAaYQ18Suri1l+vtzwcmBOVOldn+Si6qLFlLSA8YAmGrAKUizW5I27LKOWqomS3quFst1o509zHUhhtKLgh+M2R/gujcLHBduBRNkyEN+Ave+qbI5Sm4V5Py8485uU8wHJs/GghIaY2f3HI9Hoj/2JPqql7uRSI9oDg6bl6MKRG/LcsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQW6AKXRBm4a8tHSkIcnWnOs2m/y1lCPJq2KdtWLPHw=;
 b=ai7J0mmUXeAUb8TLg105x4M+fGFMQrHjyjGd05q4tcYnUDiuWxvvAVTEJRxx+zqYOEJEQJSi4CDHvUTWt5DGfvFXoR6O1iUmolL/Lg+cbPX7uVnMCHzclZjdYEtjeXIT7UVx1mxyoiYSKdkafD76KmJNVqg45IWF6yX4NfglOBqcZNlHaO17Sp9J5lso3bQjtnZIb8J+j5O3kvom/gCGQIay36RZYN3DjFXjorcAjnUrV5wTSPYkaEmDiCPKcTIvzsGmpIUAxAtLPIN45PDjhXYsKddxNiRYQiZJeHtbg2bkSTYfISux/qxxuxRc9pAnieS7qvwUmPadlWoqBi6/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7817.namprd11.prod.outlook.com (2603:10b6:610:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 09:00:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 09:00:05 +0000
Message-ID: <69f12f34-bedb-4d1a-b359-7488530ab4e4@intel.com>
Date: Thu, 16 May 2024 10:58:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Always descend into dsa/ folder
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <masahiroy@kernel.org>, Stephen Langstaff
	<stephenlangstaff1@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Lobakin <alobakin@pm.me>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20240516033345.1813070-1-florian.fainelli@broadcom.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240516033345.1813070-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0049.eurprd02.prod.outlook.com
 (2603:10a6:802:14::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a939f3b-7874-49ce-1ace-08dc7586946e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUROZEcwTFI2VXh2c25iYlY5Y2w2a1FaV3N0Qnc2YVhuWEFFMUM4YUVyN0Zj?=
 =?utf-8?B?UjFseHBFQkpxUEYvUEpMU2dJQjdVSXpYZ3l5ODhqS1k0TGJLN0RLMjBuVWta?=
 =?utf-8?B?bkVjaTR6L0pDaHlSdHU2TUxORVV2ZTlXVGhoQkdUWmt6bVlSM09rQ3JVQVFs?=
 =?utf-8?B?SzREM2JtdGNUN2RzcUMvRmlkVllLbFdHRlI0S2FBSUMxMDdTV2tNVS90OSs5?=
 =?utf-8?B?eHlOWDBHcEphWFhwM0srREIxeUZIb2UyM3YzSXQ3ZC9ySGxvSExHWUpzaFYv?=
 =?utf-8?B?N3ZqeTU5OVJMMzI1VndxL2ZiK0FUUFpjZGJ4Z1YrOVJjK2pjODJzdmNNbWVY?=
 =?utf-8?B?LzhDWkFvOW5YRjRYM2FQbHdRdXM2blVCUDVqUU5VK08wbVYvRDk5VmJOZVlo?=
 =?utf-8?B?S1dFSG5melpOY1QrTklrLzFwYzFvV3hOMG81RjU0aU1HcW9FaFJWRnlEc3c4?=
 =?utf-8?B?RzBDc0RwUUhLZG5GeTFkL1c2WVRDamZYckFDVHJTYTMwVEJEcVdrWHh0OWFB?=
 =?utf-8?B?YlZZZGszVkZTY2J3aW9MOVJwRmpQbnJlZDJzUTUxcXZnNS9pZWdZVE1kQjRu?=
 =?utf-8?B?ZUNQcjJ6Ym42ZmZzOVRmWUIxTjBXRGtYTEJ1R3dFNStnYjBHUkdNUGE1U2xM?=
 =?utf-8?B?UFNnalhtem52bThLdGZVVnk1TmY5M3NFQVlUY0xJRTdQQTVWUVo4Vm1wSDhZ?=
 =?utf-8?B?R1RvSWVvQVFVRFpFVmhQNno1NHYvOG9pb1owZ2NIMTgvY0hYWEZ4ZWR4ZmZV?=
 =?utf-8?B?dnVhNDNOY0RRUy9qOWQ3WHJoUE5mWHM5TFBpVExFaXVKQWwxY3ZUQVN2Y3ZU?=
 =?utf-8?B?c25aQitKWStXZnA2ZVlVWEFpV1ZBazRJdDd5NjdyZWV4eGVRUGpaZlErTVJU?=
 =?utf-8?B?eE9CaU1GbFZHdm5IV0lkUUQwa2c4bC9yWkYzZitxelRnR1RhanpzNmJVRVho?=
 =?utf-8?B?NEFVM1JLdXlLL3Y2aEp1SmQ5d1U0RmMxV3lNeUhlV1Blb3AvVFZrVDdCVGhu?=
 =?utf-8?B?N1dQUythUFJsejJUVHJUcld2L0VwWlZrTmdDcTkrTHhBMXlKbUFLS3VXUWhm?=
 =?utf-8?B?SFhZYWV3Q0duL3Rwb0RJLzVxZnN3S0d1TFFLbllyTyttM043OUVDWm1LYWRI?=
 =?utf-8?B?V1E5OGpSZTN0M2wyRER1aXM2NkpIWS9GcTFoYlJRY1ZUSFVVc1c5bUNIQk43?=
 =?utf-8?B?cjMzOFgrM0hUNmRBbVpCelFTZFJvY3pSTkZKTXdHRTY2d3I3eDR4R1FYeUhk?=
 =?utf-8?B?SUxoYjE0ZjRXTkFUTVFnc0RUVW82Q1ZYamg3TXVmUVFWQW5OYnZwNnl2aTJH?=
 =?utf-8?B?OG9uMjAyQWF4WVpSaDM5TG1xYzljNDBHZ05NYmJ1ejJnTG5VUjc2T21HdSta?=
 =?utf-8?B?WVFWS0FEWnpWb0FqT0gyNnlic0x0YlpuUEJFajRhb2FDOTkyQy9YRmhQTHFX?=
 =?utf-8?B?anQ0WitNOXZjQVhmQ3IrNThhMHdxTkdzOXFnd0wya3oyZ05QUFBzbFh6NUJw?=
 =?utf-8?B?ZUN5d3hnM082SDRpY0F4ZmNIdThRb2pMeUd2MzFQdkFQV3lsTW1YUVRad0lj?=
 =?utf-8?B?NDhyMmdMNnpzb1lFSnQ3Z2x5ekJ1djZwaDlWdStpOFJWdTU2aFdaYnVFOU4r?=
 =?utf-8?B?ZkZYeUE4S1cxUmsrTGhDN2tRUFNLbldQVjFZSzFMZlNzdks3eGdGa3NKdVB4?=
 =?utf-8?B?R3VHd2YxK0NNSkpMbHhFZVNWemxOQWhubndCdkhJMW1uNFAvL1dkWmlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkgwbXIwaEdrU3lNamhkaHpKZ2k5YlAwb01MWTFBemI3TWI1NzJvMjd2SlBR?=
 =?utf-8?B?dmFGWlZKMEpaanZjMndKMnlHb1VYWVFjaHZnc2xmRktEck9SV1FSVEZGYnpH?=
 =?utf-8?B?ZTJ2RUdPaStTZHpEK1FBVk1Kc2E1NzlaZG42Q1pEamVBdlBiVmM2bjkvVHZ5?=
 =?utf-8?B?VVA5dWlpM1F0VzdsM28zd0NISjZPK1lhcFUxbUpNSjF1dEo1bGlBNU9yMFAr?=
 =?utf-8?B?SzM2M1NDTVVXU0RVMy9xSXJIQlJ5ejg4MzhOaElxeXBiNlVUelJnTHlLR0RU?=
 =?utf-8?B?YWNMTU9paXI1bnF5WnhqN2FIeGpOU2NodjdVdUExblZiZUMvWEkrdnZHTHA2?=
 =?utf-8?B?aHpyOWVDWHQxdko2eHJ6VUdqemdoQVd4SkoyazNHU3NzaXdoTU9CMzN6aS8r?=
 =?utf-8?B?SFJEak5vR05BMmFpKzJhby9UaXNlSCtTKzRQNDhQRDFPSkVMVVBPREI5OEZG?=
 =?utf-8?B?WmlydDA5OXEzcnEyYzVTM0RmV2FMRTZqb2dpUTVBWEFoMXRoU0VURGFSQk5a?=
 =?utf-8?B?eEpMR2ZpaXNMV2kyZVdNSFhhckxSY2xHY3d0dXVxa3ZuT2kwb0VIUlB0YXg3?=
 =?utf-8?B?OWpCN0RFVTF4MWU5VjNYRU9MMWFpamtXSEpBaHVpdC9FczkrZllnLzRhRkw5?=
 =?utf-8?B?Smh0ZThJRERlZmlWNWpoNVRyVlhyMU5YTEJDRDlPRGlDdFJscTZNc2c1NjJC?=
 =?utf-8?B?cVkwdWRXWVBucDdiUDhXMjhJQXp4NmlEbnJGYTRxN3VoWVUwZE1PRDNBRW5J?=
 =?utf-8?B?b2lCNWh0bDIwWUlGYjNLVDlWeHAvVXpmUDdkUHNlTSswRVl1TXVid2h1eVFI?=
 =?utf-8?B?Mm9tY3V2ajE5c3oydUdqL2RHcGlHT0k5bkFsL0l1QnVhT1VTMm5XTWdtbkpo?=
 =?utf-8?B?SENQM1gxSkhicUI3eEZDT2k4SkkwYkM3OHdBNGFuK2M5TEFIb1YvK0svSmJs?=
 =?utf-8?B?Qk5WMDIvZ0dpdmlFaUJzNlRpVWxuUldML0I3THMvZEU2ZkNXeTNRSXppVEIy?=
 =?utf-8?B?V2FKV2pFVXB3SS9UbVZmY0FwazQyVzVacmRYZjRueEp4dERZQ3ZmZllyYWxj?=
 =?utf-8?B?MWlGSzF3QTFKMHBMNjRUMDNzbHFPYldNVy92YkxuaW5FQWJNWXBDKzdZRlQr?=
 =?utf-8?B?Y3I5cGIvMUxqeVo0QXZvSHZkOVBFaEpzMFRSRU5JeS91WHB2VmtIazRRYVBI?=
 =?utf-8?B?NnZ3MTBGUlZ4M2JiSW9jT3lBWllYZE1xb3lBZ0F6VkI2UjNTZVZnQ2diR3hk?=
 =?utf-8?B?SDBOcm5xNlpHNkY5Z1ZvSVFPLzdCZUdGVWZOQStwQnJydnFFbmx3T3RRYzVm?=
 =?utf-8?B?MU5xSjg3ZU5YTldzU1FLdDRqOE03T1NVWDl1Wm5mVUU0a2VmbXJFUi9lWXZX?=
 =?utf-8?B?NGg4Q0NiaThDajNQYzBsSFVqYVFMNmNKQVBBeW5MZ1JoT0g0M2JHSHdrZWhT?=
 =?utf-8?B?cGNJNWxnRjUxelZVTnJ0dUVLeWJwWjYyTHVkMDFtQVE1Z2h2N05GaG9SdW44?=
 =?utf-8?B?T2ttZWlYS213YkxyeE9IalAzaTF3QmxyQ1NvRVlNTzhKWmFHYk9BY3RDUGY0?=
 =?utf-8?B?aWdrZjd4blFibnRJQXU2TDVkSEZtS3dMT2hMQUJydjBSOGJUays5K011ckRM?=
 =?utf-8?B?MlJEdVo1UUVWSDZQSEF0TnR1WDdMMXRZTDMxekMxWTlqQ1lEbzY4cGVYWkxs?=
 =?utf-8?B?eGlwbTBLSm5oc1ZpMXJ6QTlCb0dCNG5JdjBBUFdaSC90ekZyQWFEZU9va0h1?=
 =?utf-8?B?eVlOYTRGMG03NXNhVjkyUEgzSnUydDBwTVBpd2J4UWNSWHhyQm9rc3hDRnll?=
 =?utf-8?B?OEtEMmJXVHdkMXFnNk9HNTdaUTdIbDgrMUE2YnpQQ2tmSXduZjFTWHE2aERC?=
 =?utf-8?B?OWU0T1dlbXlEOVR3cG01UFdvVXZaWllFK0xSWkdFVmF1Ui8xRkpKRmtjQ3ZZ?=
 =?utf-8?B?eDk2WEZvb2t5UENEaXNmYVNjQUtpMndhSlYzVHVLdThNMG1EbEY1ckplZzZk?=
 =?utf-8?B?ZHVFNzhzbCt4MzB5TG5wRjRKa2RkdGgrVkRITWZpUnowSFljd3JrRG1iUHJM?=
 =?utf-8?B?NEgrc3Bpc2tYdmN1bndOVWZwMk92NWh5YWlGUnV4VzBZWHk4WmQwTkVoYzR0?=
 =?utf-8?B?bkJuZkpBOE1qVE5NUGJQUXNPT0wxeUo3U1R4VE1heEkzbUllQ0V2WUYxbDJN?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a939f3b-7874-49ce-1ace-08dc7586946e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 09:00:05.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/W3SAlpJMpAI16V+V9jR3clMwLNnzev+VVUwMPseNwtQlPpiKDd2kR57+EF9FfQpo4gcwJ1ifsJw6L3dIkMWRkdurRLVTq18BjXWZPvyqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7817
X-OriginatorOrg: intel.com

From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Wed, 15 May 2024 20:33:45 -0700

> Stephen reported that he was unable to get the dsa_loop driver to get
> probed, and the reason ended up being because he had CONFIG_FIXED_PHY=y
> in his kernel configuration. As Masahiro explained it:
> 
>   "obj-m += dsa/" means everything under dsa/ must be modular.
> 
>   If there is a built-in object under dsa/ with CONFIG_NET_DSA=m,
>   you cannot do  "obj-$(CONFIG_NET_DSA) += dsa/".
> 
>   You need to change it back to "obj-y += dsa/".
> 
> This was the case here whereby CONFIG_NET_DSA=m, and so the
> obj-$(CONFIG_FIXED_PHY) += dsa_loop_bdinfo.o rule is not executed and
> the DSA loop mdio_board info structure is not registered with the
> kernel, and eventually the device is simply not found.
> 
> Fixes: 227d72063fcc ("dsa: simplify Kconfig symbols and dependencies")
> Reported-by: Stephen Langstaff <stephenlangstaff1@gmail.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 9c053673d6b2..0f6f0f091e0e 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -49,7 +49,7 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
>  obj-$(CONFIG_ARCNET) += arcnet/
>  obj-$(CONFIG_CAIF) += caif/
>  obj-$(CONFIG_CAN) += can/
> -obj-$(CONFIG_NET_DSA) += dsa/
> +obj-y += dsa/

obj-$(CONFIG_NET_DSA:m=y) += dsa/

?

or

ifdef CONFIG_NET_DSA
obj-y += dsa/
endif

I don't like always adding folders even if nothing will be built there
as we then have a lot of folders with just empty built-in.a.

>  obj-$(CONFIG_ETHERNET) += ethernet/
>  obj-$(CONFIG_FDDI) += fddi/
>  obj-$(CONFIG_HIPPI) += hippi/

Thanks,
Olek

