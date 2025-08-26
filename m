Return-Path: <netdev+bounces-217063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2421DB37390
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 22:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D435E8E2618
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2D4C97;
	Tue, 26 Aug 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5bJXNQy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F230CDA1
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238566; cv=fail; b=MIbQ8JLdLZgbdueklNPAvptF2C9FwcGWxBY5uvjlK4aE5pyyJLQHoz1q7qeeZao8UJGs3dz2hR1o2lXgN89iXfzfJOcf660V3mQ0eqJ5YCtUr+/0N+LL3t9hZ3SkQxNiK7vDCpoq9iC+uFAaPErtalkoqOBuXtz/DWvZGQTUNNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238566; c=relaxed/simple;
	bh=8Ye2zZZ7M2xC7GuOtg/WG62ExGA2HeuK7/u47Dye1qk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lxTLW0FjU+iEJlozgyByjC5foJR4Z4riTB2WftVPC1VG/CM9+6cbLYWI08LfQyCQC2KJt4VHZcRvWIM+mohpjIQ2FTnUWDvMZlzx/VoXba2+JDmBixBx2yh9gl8UufCuNAUkS6CSTAS7kESgWkv8UjNfhjheXKZcRi6IhG4Iy9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5bJXNQy; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756238565; x=1787774565;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Ye2zZZ7M2xC7GuOtg/WG62ExGA2HeuK7/u47Dye1qk=;
  b=V5bJXNQypu0ysuX9blp+QO9bpfNfmZaqfBc2GG0oiDdLRZrQWLsxcyWt
   eNZ3isiDnGi2SVsYneGncLUTjXfZgFJcqbKqiftPhVvfRnyNMKKFq3mgu
   HPNXmf3gSeVYs37Q6OEuaOboOYLbUgrHkW1gIPmDcS01CyqzVC+yGt1Ka
   WO2MdP3cbGs77F4UaPL9zCSWNsSS0kZnhs4/sGG08Y/slqrtxYSGCyrvB
   wy1liRfmcrCoMScj8P/gf/KbJc9rsJdjYJyqzKWnUoBCFy7fl4f1E/nil
   vuazm8sXoFUjELBLAsoe3y8zGzpo11Q6WlwMhog/QuIgh1MU7q7aNJgBY
   g==;
X-CSE-ConnectionGUID: QLOcvM9mTuyz/CfCZ0VSIQ==
X-CSE-MsgGUID: Dk9aKYTaQY+6pdwq0qsgfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="75939694"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="75939694"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 13:02:45 -0700
X-CSE-ConnectionGUID: 2swF88PLQy6fFIyG5Nx/jA==
X-CSE-MsgGUID: N9GjkUVhR+KSvrQt4NVXyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174066722"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 13:02:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 13:02:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 13:02:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.82)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 13:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHBvAP4z2t6uTyWHfuRIc85AQqS1DsG5a5D2U//JypXOoImHEPfZsNjtOJjuvu10HeMZZZ1kEcLJDbRQxVqyO3QTdGUEaFQl3GPa9JQC9aYTgJ6231djwhF7RpCO1S7E+L5QPzNduWKm2JfUwokv8AqBHsPjWdNsbwHq49tiv6Wzn03xcXZ+1/vfXFGLeAKqp5dKKzUUaPd71wJeAGRm20xgpJ47ajw64/nkF0JVvkXuPUDcmM7ZlrD3wbzh9JkXQEYVNfYzvdLow4EPR0I3PH1dyXwI0rJc1fnxWy2WCyYdBb3De1GZKisy6e2NTXyCrNyGQ7hTTSDB/oWpx54NHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX4HECKxWt0UIoJzZc4dQN75eLAh9jC15Tddb26AZoY=;
 b=chzM9FYXgUBHWfnieCXgiyaAz14/1CxI5VhuXTAxqH0TKEqpgXW/k7GBEiWZFZMqUF34UD9wW3hAQgu44IBCbItkUaBNX6lYr7Gfy6BI8JoDQiA3op/uQIaFylCHor++Vyy/fRt7bjOie1aoGYR+C8zxqNBXWZP+yHb+76ME/xG8Kyr/ZrluDjKFPPptgQdALPHq8DK3j6Lo11PmghWwgfJGXMe7hciJLIUiRXqYDslaXLtkLQPYyYTH36/4ThMngQ1dDs9twneay3nrI+nSb6WxZCM/ygrC0UgchZtoK9nxTwalRaN3JyNTmdBqGxSDULd+Od9seXlGsdBkBdHqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 20:02:42 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 20:02:41 +0000
Message-ID: <082137af-95a4-4ad6-b9c1-050e46cb52c0@intel.com>
Date: Tue, 26 Aug 2025 22:02:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 5/8] i40e: fix validation of VF state in get
 resources
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Greg KH
	<gregkh@linuxfoundation.org>, <jeremiah.kyle@intel.com>,
	<leszek.pepiak@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-6-przemyslaw.kitszel@intel.com>
 <20250826163316.GD5892@horms.kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250826163316.GD5892@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0170.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7133ed0d-d8b7-4ec6-76fe-08dde4db83cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmpXYWVlOGl5dk4ySmkyRnNkNWZUa2dvSW5rUzVKa0RyNXBneHFFQld6T3c4?=
 =?utf-8?B?eWNiNW14dlYrTjhGNGJiWExBYzc0V3FqV1B1ZHRERjB5TldOY0E5eFEzUUxi?=
 =?utf-8?B?WE1EK1NmR2orL3hSVUcvUk05OGlBT3hEMFg1UGgrQW9JM0Z2dWlRUUNxbVdJ?=
 =?utf-8?B?VkVmQTlqSlkxdnl5YlFYQlRuaEZMN0szWHN6TS9GQllxa3hRdWFIa0FzZWlW?=
 =?utf-8?B?c2dqWThyL2lhNVkxRzZuVmNZb0pHLy9zSUlZOUlVQVBOZUxWdDNzanpqK29q?=
 =?utf-8?B?R2xxbzFpcUIyYi9DN0tmcjR6QXBjZmZzNUNZMWk3SkVtVEp1bHBsTk8rQlk2?=
 =?utf-8?B?RUh0Vjdpd0llMVp6cm85MEs1ZUZjVGZYc3hhRWxoeWJFby9Sa0NDM2tHc3Z3?=
 =?utf-8?B?NG1jYURWQnlwczlTSXd2TG1tNjhYRi9zZk1QMVFHcDExa2Qrc1Y1ZmpKRlJB?=
 =?utf-8?B?SEhOMGRYeVBGVVlMQTRCYit4L2F4U29JL0JzNmZFTVJRZUdKdXFaWms3M2Rr?=
 =?utf-8?B?eVFSYjA4czZlY0o1OSt3K0QvVFpacDZLNElEeFpnaGJUWXN2amlZZWRYcUZB?=
 =?utf-8?B?NDZYQ2R4eUd0ZGZaQmxMWmxuTEQ2OEhzVy8rYm1DTkdwUk8yUzB3cTFRcUtj?=
 =?utf-8?B?OVBLbG0yZkFJS3NVbXA1emhoQlUwRkgrc2RublI5YmxyWFR2MmlUZTgzb2Fq?=
 =?utf-8?B?cFU3WW9ua1VtZUlhT3VMelk4RmhUQTlvUWdXekRRSjBFQmFySUVBYlRyRTBQ?=
 =?utf-8?B?TUdLYzJxb0xudERMaFRQUkVNRjhIV29WempFVHRoUU1yaG9MM1Z0Nms4bWFn?=
 =?utf-8?B?dTZtbk5sY1pmOHhRN0c4NnRDRWQxRGo4emlJWHo3NVNhVVNjYTEzejh1aFdH?=
 =?utf-8?B?NDBNcDdLRXRQZHlYVlROYkpVVlFmNCt1cTk2cWs5WGdOb3RBK2RmV2paZHZQ?=
 =?utf-8?B?MlE4a3NoWFRDbDFUby9aY1ZqV2tXZ2NpQzRESGNHb1NMZW9Tb2svZWQ1UTYw?=
 =?utf-8?B?RTFjWmdHdzVQczZVMGhlZURwSzlQZmFVVDRWSElFd1FUZUNYNXgwNlpENHNS?=
 =?utf-8?B?WUZWV0FWRVZ5RDdSdmtxeWF1dldWMkRKYUtJbzUrekN5Z3RIR3E3akw3NHVK?=
 =?utf-8?B?RnpZZEN5eGtnaDhUMVVpY0hBWXd2S01hbCtkSTNjQTZRZlBNcUEzV2RWYU5M?=
 =?utf-8?B?TUZoVG1henBSMGtOL3dPdko0UFIzUVd1d0NlWUt6U3VmOHBhMmRXOXZ1cU5y?=
 =?utf-8?B?bWxXcUpobzAxQXBjTkJLOSs2d3dNcUptczh5NkRUd1FVQTRvVUFSbUNNZFBp?=
 =?utf-8?B?MEJlUjBpRUxZV1VRK1lDWnBWejlZRUV2ZXA2K2xJSVdHNndQVW04OWxQZjc0?=
 =?utf-8?B?eTdFb1FRUit1NWE1UE9lcTZFT0o0TlJvdHlvb3NkOGIvd0xXWkNOSzBuUlNQ?=
 =?utf-8?B?dS83a2Fic1B6eFhBQXAzTVNVUGFJYkp4eHk3YmkrNVhyQmtzcHJsWm5pVWJV?=
 =?utf-8?B?cGtnS2lDQXhPMWNjcFV6b3lKaGZMODJ2dkJRNUJzaTh1cllnNm9sZTZHQno1?=
 =?utf-8?B?TVFONnZTRUNwTXdJWlVCcXN1ZnZJQ1ZYdEVMaXJCVFRkVmk3TWxhWFVWMUg0?=
 =?utf-8?B?RTVtWCt6RlRmV1Q2VGZBT3dlN1UvZjBvcnFKYmlwWnJVc0J0SEdEUWFDMDNL?=
 =?utf-8?B?OVBCTVdRYVJJazlXSjRKTmVWR1ZKSDhCOHpYR3pwZlQ1ZGsvOTdxL0ZqVUFN?=
 =?utf-8?B?dldNM2RHekkwYnhvREQxU1VDbnVTREhBSi9VdFh6bmVWeC9obW5iL2p6Q0ZR?=
 =?utf-8?B?SW9EL0txc04xejV6SUhYc050U1F2cFh3emZ6UUtGSnVmRWI3WGd5SzVyaGkr?=
 =?utf-8?B?YWZlempWb3JFU1RNY3g2ZnIxdnMvV1l5dDF4S1F1TjlEQlZ6ZmkxQXR6S0ZK?=
 =?utf-8?Q?U5pUltX/oFM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3NZR3h6cDVEVDlsU1l2R3NTVXlqeEdiUVpGSERVMkdnQXhtczhMUElHZm1r?=
 =?utf-8?B?bFYwOVVjU3lqVEV1Vk15TjRYL1cyc3lUckdTRkVHM2s4eStidWt5SVVoWnli?=
 =?utf-8?B?MXVZR0U2VHhBWWNBMXdsSDdVUkMya3dDWjFaR1ZVQU1JRE14ck9CNnJZZkw3?=
 =?utf-8?B?eUhTZThIdUtWdE0raXpzT2V5cG9GZ1hSaDR6VXJuMWI4Q1Zadmljd1dPWS8r?=
 =?utf-8?B?YzZ1eXBGUHF0RTY1K2RwMlZzaFNZaHMyQ0R1d1V4TzFjd3NySmNKMFNIWHRQ?=
 =?utf-8?B?VzduUys3MjFJa2R6c1JmQUhkU0ZIbUhNbENpUEhxRWlWc01jYVhmMW00aUJa?=
 =?utf-8?B?cTBPc1JqRUwxSVhFYytWMjljOE1VVy9LLzFNWnlOVGZTa3pOV3ZNQXdkbmZQ?=
 =?utf-8?B?NTBCMDU3SVA5QzNCbUdEdWhrNU5semh4SDRJL2tUN29jMUxSWndVSjJQK055?=
 =?utf-8?B?YW9QYVBSR3FtNGpIaHFhaTVpbjZISWhTZEpHbjhMcDdxeTdmdlg1US9pU09v?=
 =?utf-8?B?ZDAxUi9NbE1JaHJjejlRc0IxcERqcWc4UHNoTVI0SE0vdnJGSzJqME9RcFFz?=
 =?utf-8?B?SFNTL0dyZGNxOU1sWHZzY3A4Mk93dDhhN2tOeXdJQ2hpZ3VNQnhKdnBHaWJ2?=
 =?utf-8?B?cEgrYUJvSEYxbkxjRDlkQ2ZtSTdXT2IrazhQejRxbGlORkRTY082aVd0UFox?=
 =?utf-8?B?R2QrMm5EaXVHaFE5SmJaLytOQ212Y1ZnTzZBT1puUzQ4eCtUdFlGQVJmcGxW?=
 =?utf-8?B?RlZFR0hzMFJIdTdoelJkTW5TY1ZaTjFDZmFWK0dNRXhzUFVDMWszb1psYW9p?=
 =?utf-8?B?bFpNS2xXUXI5WjVxUTBNbkcvelM0QnpvVTNydHFIT1ExOXR0dlJmdE5LVnpC?=
 =?utf-8?B?R1U0b0tkWXZDbmNDODNJdWpoK2F0enU3RU9TaWxhV1M1QUhDek9xVWladVJZ?=
 =?utf-8?B?a2grdC9FbVRFVkdzS1NhQVBMUDVZTGkwUVY2SERmdFF3L3AwQTFXdlJhRE1U?=
 =?utf-8?B?RXFjY1JvMG1jdyt0YjNOaUIxUyttQ3l6MTlIRG1pZ05pUmIxV1cwT2tpTVF6?=
 =?utf-8?B?anI1OWF4MDl2MklMaE9meXpTMDRjNmgrZkc0anRHWVVyYjA2bmpFL3hIem16?=
 =?utf-8?B?Y1EzS1kydmlocnNyeWh0aVgza09BZVBkTlNKMWhDNDlSMHovcWhjY3VkOTgx?=
 =?utf-8?B?c0NuNi9Vc2dZMUNDUVp6MGJxZlk0dnZFNkRqTHJTR08xZHJMMXc0MTdtRmtm?=
 =?utf-8?B?ZWN0ZWdpdTJJcGlZZlk5QVBzNGJjZ2JjMTFaRFBaVVltWW8rTmxEcnlhTUJG?=
 =?utf-8?B?YTIzRzVmZkMyUURhQVF4RWVjdDI3ZHh0OWNzZUlsU2cyVFYydzg5MjI2K2Vn?=
 =?utf-8?B?cGFIYVlrckhrdDlJSHlBNzl6elI1TEduSDNWVERITlZ6SmM5NHNreDROdUpn?=
 =?utf-8?B?UnFoaDhUclk3REdrZzhnMzJxZ3pZVjhkSzQ0aEpDaENEM2I2V2Roa3ZnNlpo?=
 =?utf-8?B?b29aUUhiOEpFL0xBZUo2UUVWLzFlaUp0NFJiRU55azZxQnF0SGduRFJHTnVm?=
 =?utf-8?B?WDBSdUdpQUl0T1FZY09sQjVOQ0dycTA0SDNIVEgwaG1RZjFTM01raksvaHpt?=
 =?utf-8?B?RitrSm5iZE9hWFBOSURHZzZUc1BFSCtnMWd5bTJ1bzYxem1XMTJ1VHJCSDIz?=
 =?utf-8?B?ZlRlQ0NPR2xGVTkwSVN1MUVzV0ZaRDRyNUxmOC8vMmNZK1hwTTdLdmUzMDlM?=
 =?utf-8?B?bTNMcXlEVTRERGJnWElEcDR2RWpWeGk4aTRoYjc0cTN3aHZBZ3NmaER2cjgz?=
 =?utf-8?B?WjRzeENZaW9rVXJUeXprdDh0REN4ZjVpNzA3eFczUkE1OTNwUFBVak1MOWFS?=
 =?utf-8?B?Q0pQVkdmVmVhVWJpMEI0STE1UFI4dkc2SnR0bGFuZWVGbVJPZ0g2aU1WaWhC?=
 =?utf-8?B?R1dZTlBZY2FUYkdsUCtmMXZpMGY5Tmw1dFlUQUovTXl5WEtvUFU2N3Z2b1ly?=
 =?utf-8?B?SzhwQ0g4Ly8wVzBnWnBtZkhvK0QzQWlJS0FXbllzTFFRT0YyOU5uZFMrMjZE?=
 =?utf-8?B?RzZyNXpkL3N0cUFUMlBkdmZjM3c4cEo1c0RaMEU5SVNVbGxrekR6bFQ0aXdr?=
 =?utf-8?B?VVZRbEwvWTlpVWkwV0p6ejNqN1dhZkxGNTVxckhFUzFLQTJvMVVpMlZHYmg0?=
 =?utf-8?Q?gEBOaJP71Fwn7makyxBWvpY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7133ed0d-d8b7-4ec6-76fe-08dde4db83cd
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 20:02:41.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG1qQir9jBFH3YCE8aSoVGsFRO5B6bDDiOkr1dRjkrbOAiE8U1MGbyfW3IF/1AoXZAyIdFTnIyBwxbBX1zuwwbmfrH+mkwIobjK9LCWPKH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com

On 8/26/25 18:33, Simon Horman wrote:
> On Wed, Aug 13, 2025 at 12:45:15PM +0200, Przemek Kitszel wrote:
>> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>>
>> VF state I40E_VF_STATE_ACTIVE is not the only state in which
>> VF is actually active so it should not be used to determine
>> if a VF is allowed to obtain resources.
>>
>> Use I40E_VF_STATE_RESOURCES_LOADED that is set only in
>> i40e_vc_get_vf_resources_msg() and cleared during reset.
>>
>> Fixes: 61125b8be85d ("i40e: Fix failed opcode appearing if handling messages from VF")

my initial conclusion was that the above commit changed behavior so it 
opened up a window for the second get-resources message...

> 
> I suspect this could be
> 
> Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")

... while the original impl (your proposal to blame here), while buggy,
would error out more often

> 
> But I guess that either way is fine.

that is also true, so I didn't spent too much time on this
other reasoning is "Fixes: tag should be used to point to a commit that
needs patching", and picking either one here would result in the very
same outcome (the later patch would be applied as a dependency of the
current (5/8) fix)

> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

thank you again for reviewing this

