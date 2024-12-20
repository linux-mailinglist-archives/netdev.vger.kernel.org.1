Return-Path: <netdev+bounces-153655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B046D9F90DA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552737A2CBD
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC67A1C4610;
	Fri, 20 Dec 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mudGkRzg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E31C1F1F;
	Fri, 20 Dec 2024 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734692448; cv=fail; b=TdntBMxNfi/jJBTQGwhFDSXymye3OlTIj1yuv51t9cI6mzb49FqfW5hhlRlA8wWzkJQRObuaHUJ+f1EgSkJU+i7i224SAb5s8otkQ7Wiyafm080jwQ8IboavifYlAuEdldeg+InqzUAfLn9Y/iA8ezGePpqO2tGM5EtEZ6AKkqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734692448; c=relaxed/simple;
	bh=sxZJHCGTQDYrQAyMn3Q9KaqUmqaH7aWkeB7mpxzuRKA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfZZo9z+yOQiwvCx29mSbMjpXpMQ9Y2RX8TUMPFb0/Uc7uBKEV0ZsFHIuDAMtgy4cFG+kw7W5wR3TzZAoRiv2+0r3CmyzsufWdu2fPPWjWDy0C5rsmutacUbDaN+PxydgcuBBkC+iH3NPrgk6odb9slbX++rnrM1tbkMJ3CV2qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mudGkRzg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734692447; x=1766228447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sxZJHCGTQDYrQAyMn3Q9KaqUmqaH7aWkeB7mpxzuRKA=;
  b=mudGkRzgXOrM6QXh0f//VBKlaLoY8ynwUtyvw+vHtLHME9Tu72JZ0UuF
   fvhJHW81wNFLdEm90IlEiABtDorqqCEVj+oZCcuGWDWuEmuooCohOOE+h
   DCRiWQZMceMxGo7Rof/rcbvyUSxt8wUZT2EShTlu3xdQnSSPvyzinD8Lf
   s4fqzHoEOdHICED4UpvbPeHksRiNtvheftbk/xU70hxCB3Srl8DnMFw9A
   E7bMX7Y2SEbkUSFdzNl9JaLF84Gp04plB4rUL410tt0edfRHAZeLrs3D8
   sPZEfWIHKv/Ks0wUdpqIoR0cCFbE1iyhAoRrJePHMRoa7IHAz9JMFZjE3
   A==;
X-CSE-ConnectionGUID: 6poL6VZ/QXWHFsVXcYMJSg==
X-CSE-MsgGUID: 9voOG7qxRXqg8VA2uWYiPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35404773"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="35404773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 03:00:46 -0800
X-CSE-ConnectionGUID: Cxu4AG/LTrW0Z5YSlTMwJA==
X-CSE-MsgGUID: uVh3ASLpRzGDiMdSuDy0JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103104818"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 03:00:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 03:00:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 03:00:44 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 03:00:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ+yKH60jJGCGR4dCcmfN/sM5DigDG7AzKkApkhN7Jos7LEhDrKYMi9/YiBJXLPmlCWr/ufhy+BdaRLEqoa0/R4204o4vIYroVSolb53wJgnQuHYIydnXCiSi6QSYSNxvgz51Cu9G2nm+OPqApe8N/WWcNZS8KY9hTTbJAjfMsK3XDyq34RmZF1DU9WmTeFWmqFPdad2B3XocyDe0F75QCws6wb1fTQUH+KOZ/tZTDiiyC4kiFQbA2+cM+GjHta3cOwYsk1v+Fu1yV7ThSivjmwV1xpg7gAe2mLjrJONuxJV3YgTLqLO4L4Ga9/O8R/0226YXefOYHI8sW1aPM596w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDYz/BUNgiCKL6azfHnSgd84nzOSbMfI3eerBTks2iA=;
 b=HAi51kqnfPnNblaPAlvHcJ4j0iDs5TN1tidr92EXoqrP4A3AePPpXGg5edh2lQGCV/SYSlS7Lm5T29KtQzwIGJUJMKtXtq85dqPBq/X+kHswiO0q54XIaFEIuOYMHrnF8TT6j3GCvwZwp4gp3qxW2NuZ37dZp7dO8XY9CPeHIqNg6PNZud9P53MetDIuVNw9QukvjfNoYP36yRCFG3x9ydcncD94GHGJnwmDPm8myKNX3zGxhJxaPk+eShbfe5H52b9vNdwOodUi5o9bLXdiX3qFcUyUrIuD9pSh8KjbhdHMaVTPnPd71FYLxftpRgt0dDrUk9VgK86bwL6doK6Xwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:00:01 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:00:01 +0000
Message-ID: <c800e544-82af-43d3-b07a-e7b1a4028330@intel.com>
Date: Fri, 20 Dec 2024 11:59:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: Joey Lu <a0987203069@gmail.com>
CC: <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<ychuang3@nuvoton.com>, <schung@nuvoton.com>, <yclu4@nuvoton.com>,
	<peppe.cavallaro@st.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
	<richardcochran@gmail.com>
References: <20241218114442.137884-1-a0987203069@gmail.com>
 <20241218114442.137884-4-a0987203069@gmail.com>
 <7a4f5769-0010-40fd-8bb7-a20f2725114f@intel.com>
 <216e7c97-e0b1-4833-b344-a71834020b15@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <216e7c97-e0b1-4833-b344-a71834020b15@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0037.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::26) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 346981bf-9f07-40a2-5d19-08dd20e5737f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3E2QkNaT1FyYkl2clNldlFVelpxQ0E4M2ErQ1JXVDcrV01QdnN5alRSZWlH?=
 =?utf-8?B?d3NzbmgrL3lvZTFwVjR1bWlyQ0RHY0JPYUJqZ05aZm1oT3I4U0NPVlMyQXJ2?=
 =?utf-8?B?aUhXZUFUZmRUUGRKZ2YyaGFxRkdaV1FDM2lqd2V2YWxLd2FvUXVINThXSTVl?=
 =?utf-8?B?cjRYcWhFUzFsZ3JncDcwOXJSdGZLRTZzajRBbkNrUVh4MkZMUnJkUjhpT0J0?=
 =?utf-8?B?RXVGVTgzaWU1eEFweVBYdW4vdTJUL0ZrUW43K3l6cHdFZzhzdGk3dHRIYlQ1?=
 =?utf-8?B?QXFNMUkxYklJZ0J3NHFZMjRIQTVmSXBvM2x4VSt2aU0zWkV2TGNkQnBXaStR?=
 =?utf-8?B?V3pwR0dpSmlOMmNqZTZrcmMrUGlkd1VHanNRZnM0YVJ1eWRoVVZVTTVrTTgw?=
 =?utf-8?B?VVhHbVJ5T2Zsei8rb2wxaHprSGFpdmdWMzR6SGpVRDQ5dmZmbnVJTDV5L3pR?=
 =?utf-8?B?dk83Q1ZuV3BNUWI3UXo5R2tzSU9ibERiWVZHZWF1N29Ed0U4WEhYSEN3cDR0?=
 =?utf-8?B?M1hQVnVBUXpjNEF4RWZtbWtFMVdnb1FLRUM2YXo3RUlOY0JqVmh2WVZKM29M?=
 =?utf-8?B?cUIzYzJRcUYwbkZ3Z1F2QWh0VitaSjVBVnp0RUlGUWNFUzc4eTZKMmo1Z1c5?=
 =?utf-8?B?cnJMSkE0NGZxVkxyRlA3WE5QRURKMmV4bUFpWUhMekRaVmhBOEFSV3ZQdnBU?=
 =?utf-8?B?ZER3TnlnY3R6clltd0tjZjZJODJ4blBtbTg0bExZOE80bUh2N2UvZk4vaG1R?=
 =?utf-8?B?TkI5MVMrMEVVTDhlN1ltcDMrZDRBZ2NjNmdWTmU2TDgxME9veFVXSkYvWmN0?=
 =?utf-8?B?Zi9uN1ZCVjJWLzJESVJ2cUdsTXBNMXFrejVnUVB3cFV0OURxdU4xUGV3bnFw?=
 =?utf-8?B?ZkV5UVQ3TWpBL0NBNzJSWnV6WUNmUmZya3pIdlE0eUROalQwUVVSQXdhOXIz?=
 =?utf-8?B?bXFrR3JFOC93bUI4OGVUZXE0cEF3K0ZIYWtpd3RNQ3hNVk90QVZ4SHRTNWpN?=
 =?utf-8?B?M3VsZFUzdlFGR0FLUHlPalp2V0hFbFZDZ0J4bFFiV2k3WEx2QytjTVE4QUtt?=
 =?utf-8?B?MU5WU3o4cTJmV0psSDA1OGIzc0czalhQNGlCSnJneHVuMlR4SEZzRk9uZzZ0?=
 =?utf-8?B?dXM2SFdwdks1Mk9BRXdCS3dYWmFiOHJML1B3OC9HTW9qQ2YvM2hreExuV3E3?=
 =?utf-8?B?NWNUa1hNa0FzakhrOWpJQlFYMUJlMHpzUy8zU2dJN2tWMXJJd3NsaGM1Y24r?=
 =?utf-8?B?a2JHTmh4R1pvR21RRVQ3T0twd29GQXhsalNJQlA1Q3hTNUVYSk05ZW8zY1l3?=
 =?utf-8?B?ajBmZFJFVlhFaU5Ia1J4MzFBb0RDbnZJbWwxa21ubU1SK2ZYbCt2eHdwV1I5?=
 =?utf-8?B?KzVUMWxaVEFQSXc5YTN1VnlMK3QvOUMzYklzcXBCUmJYbDFlTmgzUEhUOVI3?=
 =?utf-8?B?eTJtNCtYY25Xek9YQ0k1U24zQm5nKzNpTXhHaVR3c3FwYU9OSWpxbmdXalpy?=
 =?utf-8?B?SC9TNHV4b2dPdVh5WE1VRnlYVk5EMkY3M0VjWS9iMFJFS3pOSHkyTG5mT2FZ?=
 =?utf-8?B?YzdIR1dLZVVDKytCMjUyK25VQUlKc3FkL0JJSXoycVAyZ2RPOWNHbmpuRCtp?=
 =?utf-8?B?UTljNkpRR0Z1SjczZkgwcW5mdVdHVytPVXRrYVZmNTNXL3UwVHh4M0ZUemIz?=
 =?utf-8?B?VHgzd0ExS1d5Wk12Tlh0dDlqRmJ0WDlFS2JmV2tva3N0WCtneGJ0QmFGQ3Q1?=
 =?utf-8?B?eEZaNE43ek9HWmkzcUFpTUsycGlaSVptejdycHhrOWNZVFVESEJpWkRoSWNs?=
 =?utf-8?B?Vk1hVEt3K0R5dE1wV2dpU0VxQyt4UlpUWWlhNjdHUzZTQUVrS2lDWndwSWs3?=
 =?utf-8?Q?q7YkjXVEdrcHA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmlBYlZ4bU1HVlo4UGlIdDBvcStHRnBPSDRSTmJxNTYyVy90WjBvWUJDSTMx?=
 =?utf-8?B?dTYydm50dzF0YWdPTXZFcER0VTFIMUlHWW1ZVk8yV1Q1bEFTWW1FTnNxZm5j?=
 =?utf-8?B?OEFBS05CeHVHOE1ORVpIdVdZNEFZOGtBS3RFS244bjlrODIrRytrdGlLQ3Fy?=
 =?utf-8?B?ek9zY2lRNDhTcmo2N2MyY1cvZWptR2dRQ1h6S1ZoMUN4VGpXd1FpVUhzcVJQ?=
 =?utf-8?B?VjN4RXNSeDJJQnZoUisxeTJqZ3hmTXpjTDdrNmRFV2l3T3NlRGVxVTVZazJ0?=
 =?utf-8?B?WUVlbVU3RWRrZzBJa3JKVUlJTDlTSmZVdGtwT2wzL2M4WndaL0Vpb1gvM1lN?=
 =?utf-8?B?VDZkUFVCeWlBQWlNNkVSTU9aWllxUlZEdVpZUC92ckhUL2pQRjJwWC9HbkFu?=
 =?utf-8?B?TGJkQnNvWFkwSHlXdE95d2VFZDJNaHFSSkkzUHBwQWV3am1tZDRGdE1IY3hM?=
 =?utf-8?B?Zk5qRCt2a29tT1BBRHYxcXdUQklYMXRxbTVrc1VZaDIrcDJQcWdCNXhRMm1u?=
 =?utf-8?B?SjYvS2g1a0hpWHgyUkE0ZDU2M2NwQnFOdVpLdEdZbkxVWTZ3dmIwR0NGd083?=
 =?utf-8?B?MVNKSWxYdzhRNmVNTXRVNXB1MlQrbTBRM0VZOU9UZGJHaDJPWU1ybXFJU2ZW?=
 =?utf-8?B?b0NDU1dVbHNBVU9ua29UaWtpb29aOC9tNHdGTkc0Zzd1MGhqNHo1SjluZzFN?=
 =?utf-8?B?ZVhabXVMZ05QdzBaNUVsL0FNUXJZTU1Fb1BVcW1VaDdzbzZFcUNxbXVGbi9D?=
 =?utf-8?B?czYxb3pkZVJ5TnJzQ0o5dFpPZFVwSVVWMTU3L21FYVBURzZ5Rm9kT2MrN0N4?=
 =?utf-8?B?YVUvQkFva0NGK0FEbTI5bENGTmd5ZzBabVlMRmM3UFRpZjduVitWblFiRTNI?=
 =?utf-8?B?WmlCUVBlR0hzeWdLdG11TngzUFhVY1RDUEVTRzZ4eGoxYVhkQmxyQ3Yxa3Jm?=
 =?utf-8?B?S09QTDh1MzdtajczN2lLUzdVeS9zRTlZcU9ENEQzQ0hKSjArVGVKTms3eXBl?=
 =?utf-8?B?bmpXb05XRGVFYlFwTnVzWXR4TXBsYVhiemdRSkE5MENLV0RaUFRENHRiWk5H?=
 =?utf-8?B?NDJJM1NpNXVmZS9ZWFpqWVlLSkt3Wm40QnlLUnkwVGRLS3RDdDdnc01QaGF6?=
 =?utf-8?B?bmh0TFpGNDZwRTNZbnNlMldzRnpkNDJUSmRRUldHbHhlQ1FiNXozMnVnRExr?=
 =?utf-8?B?MmRkazF2cGdITkw4aWlTU09BTlEwNVBSdDREbGxiS1hmWTRySXZYaWdRQUsx?=
 =?utf-8?B?QjIveVI3S2xmaysvOXpGU3pOSDVvYmcxMHhqRjdSZHZkWW5ucnh6aHV2REdR?=
 =?utf-8?B?RCtoNkFUUHdsbm1tajdoTGZwWUN0ajF2QUhJNnN3UHA0QzVqaGpEN3BQaDRq?=
 =?utf-8?B?SzEwNGE3MkZpQ2o2cHAzQkNUM1I0citUbGRpOFlHcFIxWmRzeWtEZ3l3Wmlz?=
 =?utf-8?B?QjJtVS9ncHplVi9xRHNIU2l4enU0b2l6b3RaNVVaYVpEYWJoUkVvWWd6N0tN?=
 =?utf-8?B?TzNuWXF6YlRwM1hubVpxNVUrdWdubXdMcVJwOGFTUUc3U0lIeDFrTjNxai9x?=
 =?utf-8?B?dGl5eWNsWFk3SUhEakRwcnZrNDlqTmZ4N3R5c01pOEROdFMzZGYzN2xobzR4?=
 =?utf-8?B?RGZBRVJTVkxkeVpKbkRhclFkVDBmMk1Pa0QwemIwM2dxR0ZPTUNyakV2d2N5?=
 =?utf-8?B?Um1hbmZzQUJhbVpzN1d0M0N0ZDZNL0Y5azgxb3ptdUxIYndoLzNPNGRFcVpD?=
 =?utf-8?B?NUwydDg2eXkzRE12aFJTeFQzNlJNNjVoL1BmblQrVjdTZFhPa2dBRi9VcjRz?=
 =?utf-8?B?Y1FGVnVTOThML3JZdDhwM1puUnVycWRiREcvVzFoMW1WVzJmOVRLQU42eTZC?=
 =?utf-8?B?WnhNZC9NVHRaQnlVb2RnSkhCQnZyTHN6Ukg3eUtTMzNLd2IyeW9yMklwSlBR?=
 =?utf-8?B?bTgvWS9DaG9jNytrNDR6OHJvaDY2WkxmbGhRemF6OGdCVU9LaXQ2bnVGR293?=
 =?utf-8?B?eHpRMndRVGJrY09NUExaOUFWZUdKMFZsTGRXZU1jOWV3NkNYMk9xY2N0SWkv?=
 =?utf-8?B?QXZDZzhoVlBHSjQxd3k5a3d2SmFtVVdIRDZteG1oMXNJMUpac3lkUHpacS9Z?=
 =?utf-8?B?VkdFOFpEZDJHQk81TkVlVHE2Y2N6ZmtBQ2ZRc29wTDVibHU3aDRqMVVwZVZl?=
 =?utf-8?Q?kEIUJgsAuravRK1qSERyRJg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 346981bf-9f07-40a2-5d19-08dd20e5737f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:00:01.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHzL+TEXeGLKaOnXTWrueayb7OzvhmkFstIPVf/6XslSeal0huQmJwjZOXLn7xGkmT12r0ZH+sHkkcKLbPc0X/kBydKuOJrLij6tg7GECKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
X-OriginatorOrg: intel.com

On 12/20/24 08:07, Joey Lu wrote:
> Dear Przemek,
> 
> Thank you for your reply.

sure :)
please also configure your email to write replies as plain-text, instead
of HTML

I also forgot to say, that you should have target this series for the
net-next (--subject-prefix for git-send-email)

Please also note that your v2 should wait to be send in the new year,
as we will begin the Winter Break for netdev ML in a moment.

>>> +/* 2000ps is mapped to 0 ~ 0xF */
>>> +#define PATH_DELAY_DEC      134
>>
>> would be great to previx your macros by NVT_
> Got it.
>>
>> why 134 and not 125?
> 
> The interval is confirmed to be 134. The mapping is as follows:
> 
> |0000| = 0.00 ns
> |0001| = 0.13 ns
> |0010| = 0.27 ns
> ...
> |1111| = 2.00 ns

thanks, that's correct, sorry for confusion



