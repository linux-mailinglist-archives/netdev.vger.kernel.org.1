Return-Path: <netdev+bounces-221372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE317B50589
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5644E27DB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB73009D2;
	Tue,  9 Sep 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFg66wXs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C11225A24;
	Tue,  9 Sep 2025 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443632; cv=fail; b=jGBjht6KLl7BsAxwo/BZFPJ7yXpNm2LDIS8WdOXakQPOn9OcHCUmr67j8pMtCwLcLeW6hCs6ZidOw1gCn5jSogxWSzEB8SptBp3iawCCtdMzr46dyJJTfL8ATeXASsb5zIcagQh6O2mJaGRouAom0ZXSsyjasKZbGwTyMYhqIUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443632; c=relaxed/simple;
	bh=y5N1nWyKlBHtpJXOZMBpOJYyYjxlN/w28M6TpT4BCcM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CT1Ez0p+KmiRBU14iYK4kjpQEhhMbaliJVJor5qvKVmDRDPHHx1EC9Oai7uoB9Ky9KXmXLjW1zhTp+Lf8J7rMf+J2PRIJ+cZjpjchZgAveQQtHVPDYBMWItfR5ejPKRxBh5j1l3Zj6Y9t5d/thmhzPbos/UAxqdHLglC7OyHIJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFg66wXs; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757443632; x=1788979632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y5N1nWyKlBHtpJXOZMBpOJYyYjxlN/w28M6TpT4BCcM=;
  b=YFg66wXskx8+sctQUin2lc4TCepGN1vIaNkKqShvFcDBqRRQMLyD65Yr
   L00+QYcEwNOjdUgUGuqkWFu5G20wXNM7PoPwbgO8frTgJkCPgTMLV1xkv
   bBSPsgTQBEYEvgz+JO3o795ml22KPrzptqxmzzHonr6wr2JrVL2HDor7k
   O4YS+3f2iATg3PAz0f4kn3LOR3H/5tRxV/Nc7yW0nwD7eRePz5rPhPvc8
   GX5GtES8Pg+pDcdl1TXbB7Nt+SV3mlp+8XLX6uwk+wfvp9LQCncAe/RDl
   O/Vw4vIi3JFCaIu+W8CLF21sqZjJ1W3dOAfMSrptqtdgpeKWtnrW5XDKU
   w==;
X-CSE-ConnectionGUID: qZJS/3xoS0eK9o4DkAKyGA==
X-CSE-MsgGUID: vk5g+XPEQuK3lOEpVBa1ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="71158488"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="71158488"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 11:47:11 -0700
X-CSE-ConnectionGUID: l2NHqOLHS6mQ7ZkiSx0Unw==
X-CSE-MsgGUID: Hc1mPfxaSHWreED/UvQUhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="178369988"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 11:47:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:47:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 11:47:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.61)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:47:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKtz275ev/Zpe4/LAJJFDNT/XCHg4t33mxLOVcf3AS0SAJc7jWD2apj8nbTitDHojUEMdmimFCXJfYvl6D8JOAPCwCTvAd+h5KrXetDxA085xU++hV6QGzD0DUZL/34lijKT9jcJA8clJv8ZIKWm2HI+VMCQuoefRqgcT3OosmTIxXB5jLJ87SOBZ83N1SSLdbLh1TZAOQGAEqIofNIaXSzduDVigWkxjndJlM5S5MsUe1S1NdExOcxT6d/LFeTK4rka1bPWRLksVNdknxj4vXl4MUAj06Ot35riN5PGRcJvU63X77L9vtHBcxRS/4TDVGhFCLzu2657yQ0gPqiFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwquFBhPex1AB3cACtHokM4ULUIInodllMfPn9J+qAA=;
 b=BfNiZCvZ821BDZcEDnMpLsFehhKntxXUWx7IDeEcwVR0yX585R597g29iUBlREPCkNH3rv8t4CHW5hre9pAnBoThrVYTjFd2k5ikFETanUPk8Of9iXoa0hf1YUgFusJ37tooGIpIPODffbs02UgUaI51a3NNiF9ql69G4WcrTVx+xyFKRFqtR5CLpL/5FfJ+CfoTRSWwYrktLivsp+UR5sjHUKXsMfoLztits8IyN7kJm2UPObpMxVzGACYWOtQ6CKlgL1KgU8uWZTsAHt3+07LqiBqTAmIRCLQlDxwxK2txQpQf8iIU1G37WlnV9mxHHl2iZzMmDw9aR9pUAzdRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59) by LV8PR11MB8535.namprd11.prod.outlook.com
 (2603:10b6:408:1ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:47:06 +0000
Received: from DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e]) by DS4PPFE396822D5.namprd11.prod.outlook.com
 ([fe80::ca34:6bb1:a25e:5c1e%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 18:47:06 +0000
Message-ID: <c8651cb3-6e54-4542-8523-c56c716bce4c@intel.com>
Date: Tue, 9 Sep 2025 20:47:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: stmmac: check if interface is running before
 TC block setup
To: Jakub Kicinski <kuba@kernel.org>
CC: Konrad Leszczynski <konrad.leszczynski@intel.com>, <davem@davemloft.net>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cezary.rojewski@intel.com>, Karol Jurczenia <karol.jurczenia@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
 <20250828100237.4076570-4-konrad.leszczynski@intel.com>
 <20250901130311.4b764fea@kernel.org>
 <e1e9c67e-04c7-4db4-9719-25e5d0609490@intel.com>
 <20250904185628.0de3c483@kernel.org>
Content-Language: en-US
From: Sebastian Basierski <sebastian.basierski@intel.com>
In-Reply-To: <20250904185628.0de3c483@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To DS4PPFE396822D5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::59)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFE396822D5:EE_|LV8PR11MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: c3908e30-a701-4a47-edff-08ddefd1461e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUs2RjVVaHpYakIzc0U4VzZoUVA1Q09iejk3UmV2ckdRd1orT3hzVS9TQzl5?=
 =?utf-8?B?S0dqak5SeHgrZkN2aG42UTlYM01KeFI2emQwc0p5KzBmYlNaUnJNZDloenhC?=
 =?utf-8?B?b09KZ2c0ZEtGQkJxVXh1dHZBeXc2ODQxMkIwVWJSRTBSY0NCckpzbUpQb1dm?=
 =?utf-8?B?OUFYN0xYNGN5LzhsdVhCZGV5TG1SdkxyWE50dmVsVWRoT2plWTRpOHNsSnpM?=
 =?utf-8?B?cGtjYWVLV2dKaTArNTU1WVVlTzNvQldveWNINFNaMXRpTUFwaHFyelZtRXhi?=
 =?utf-8?B?Zm12SjRZS0t3MGF1c0Z4emFJSTlXQ2s0dDZOejJVd1JTNkljSkxOVDhrcVFZ?=
 =?utf-8?B?dHMxamYxWmtmOUMyYzcxT0lXR1IvQWVmencwOG9xbW91b0RHM1dhMVQyMHRr?=
 =?utf-8?B?NTQyOW9xbDQ5REpHVUFEQ25NeUdQR05HMjdMUFhBYmd4WXcwQjBZVmNKWExC?=
 =?utf-8?B?OWt0dXJCb29VeUM4M3dJeFpQakJUTWN4MWlJTXJKWThjcWlRVU1HWlIxeEwr?=
 =?utf-8?B?QW83Ym9iVFhYTHRYU0dybno3M3JMbzgwRUo5NUx2cU1XYVBDSjVkVU4wYnhN?=
 =?utf-8?B?K3RJbERGM21kZU5pRkNYOHRHazNpZk5sWUpoVnZHTkMwTG9NMERKZ1ZLcmdO?=
 =?utf-8?B?YlB6T01XOGEvbnRGQmlqUG5HN1UrVmhJYWc2MXcwamF6WTdVL0E2OWJUd1Iz?=
 =?utf-8?B?WHQ3YlM5UUdEcXVYVFBSc3dRYlI0SGF1WkxueUVRTkRoaGNnZjFrQjczVWdm?=
 =?utf-8?B?ZWxNRjByVW9zcHp0VGJ5L1E4NGRKRlo2WE4zcXZhaTIrWEFiK3E2QkpJWXJ3?=
 =?utf-8?B?ZDNwQmZhcFJSVG80VXBiNlVodGtZanhnVi9JNHdiQU1STkd2ZGl6dmhvN0Za?=
 =?utf-8?B?cEVHR3VxRkFIMjRMVEljUlNDbEtzWGdtOFdXbXZVeU94NWhMN0RWczdkWjlq?=
 =?utf-8?B?d05qaUJpeEpkZmxWbmVSbXBCOHNBQ3pEVUhoM1dmRmxGSUt0TVhJeEpJcXR6?=
 =?utf-8?B?NExlOXpSSFJWdlVheFNHVUhhSUZMQkVGTjZQUzkxeUJrcXZsWHFnQXhNN3Qv?=
 =?utf-8?B?RmRrSnQxSXdpcnBOTUVHTnN1d1JlZUxlWTE0T1cyaVVmdStoOXB1REtEZVE4?=
 =?utf-8?B?ZU1SM2s2UDFDUUt5MXRhYjFGalF0MktJcTRhMWpHVXRSaXhqU1IzSE1rZ2Vz?=
 =?utf-8?B?eG8zMnJOaExYeHlIVU04d1M3aFJjSDdiNGh2TDFGc2M4aGZUaFpoSmF5U1By?=
 =?utf-8?B?dlFvK1NCNlhOSnpsR1VjNVQxeGpXaFRpNEdrWVc3VHBNYjc1NFptYUhxVW9m?=
 =?utf-8?B?OTkyTWdDK0V4bGJyMEFXRmoyOWwvbytNRlNjdTYxUTNMNFpBekRxWGZqOUtT?=
 =?utf-8?B?dkV5czlWUmJNM0RlaXo3R241MTM2UmVJdTBWbW43eXdiQWFHNW5EMGoyRUxz?=
 =?utf-8?B?Mi9wRGFrOW1VWlE0ZjFCV0sra3pHRDVWNmV0ZXNESVRhaVdOTTVsTGpCbnU1?=
 =?utf-8?B?YzFwY2JlZUQ3bjZ0VVBMNm1TZ3FGQ1ZtMm91TUpXY2VXOW5HTmxGL2lHRmdr?=
 =?utf-8?B?RWwvejBCTDBsdzFCdDlRcEFBWUdYOTVjeURzbUZXdGVmT2NJNE90Z29zVlRY?=
 =?utf-8?B?cVFGVjR5QjlDTTNDeHIxakVoc3BQemJDelpXMTNmZzlTdEVVRCtVN3htSHc3?=
 =?utf-8?B?Uk5kcFNmN1RnRUFGSVh4T01ITE1ydnMyUUN0THZOWDA2WFBpV3NpTG9vQzVh?=
 =?utf-8?B?eTFBN1JYTHJQdjczNC9NK2ZqeTQyS0w2emppcU5tMnlMUkpvb09iK2xIejFy?=
 =?utf-8?B?dm1GdlpiR3E4dkF2Z1A2ZGpZd256Y3JibFJFMHRsdkxLRlJOd0t3RGJZbm5Y?=
 =?utf-8?B?bTkyZlR6TmtuWFhBYURnYzRBQ2EySjU4cVR0MjB2bzgvVmRabmVvS2lkdUhL?=
 =?utf-8?Q?ZsQCRPBSfX4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE396822D5.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGYwbzhzODFrbjBBN2xNcUxPaXhoZ2p1RnVKT0lMVjg1ZmdUaEdGMCsxR2w4?=
 =?utf-8?B?R21ZVE8rVDVmY2dXNUI2QnorbDVOSjRmZVRrTS8wYWNocytFMWdnN1RtNzZG?=
 =?utf-8?B?QVhnUVFrcDNhMWhsS2pSMjV1T2NNMnVTbEhTSnUrY3JRWS9WQ1U2WEE5Wlp3?=
 =?utf-8?B?aHR3cGRwb1RQSnVVMmtSRjBCSnBnTEJLVisyUkdMZXZMQjR6aEpmVmM2TEVD?=
 =?utf-8?B?ZW1BclVJTG9ndVllYzlBK3NhUU5ZYjdBOXdkaWx2UG56blA2emZyMFhndlpP?=
 =?utf-8?B?bWEwSFlOVDYvTitVaVJsWGNVNDFiQWpNWkd4L05XYW51eEZUekV6NXBpQ0d0?=
 =?utf-8?B?cmN1eTVYckpRU0U4NzRIYkF6ZlhqMmdvWkp6cS9NTkg5YXJLeWEyajgxYVBQ?=
 =?utf-8?B?cGlSZDhyWWswTzkzTzFVRWloWW9vM0c1UDlUV3lsMGZtUTkvRFIySGk5L09L?=
 =?utf-8?B?ZFE2clMvemJjT3N5Mm9mWmdVUGNwOXFkNXQvaXdUdTFQZGNtS2N2Rmo0dkVw?=
 =?utf-8?B?dk03MFE1TThoemlCUXVoSHhIRlJrZ0lMZGQzOURHcjh3RkFVaXFPMmdqV1Ez?=
 =?utf-8?B?dnZIeWpTTEVxbEtzVVQ2Y2cyZlZkeUxUMXlLRmsxOCt6MkpIYWovRHEwSDJr?=
 =?utf-8?B?Rjd2ZUJyT0dkQXNxbkF3SGw5bkpZNFRHUFFNbE9PNkU2cks5K2hPeDFxTElC?=
 =?utf-8?B?cDNPMFVDcHRxM25aQXdydGRZZkhQT213NDJ5RkxoRG9jRlB2ZEd0cGZiNm4x?=
 =?utf-8?B?bzQveVZZdVhtT28zOWNMdGhEVHJYUTJMT3F6QmdEZkhRbTVZT1VRK1ZSN0Vx?=
 =?utf-8?B?Z2pWeVFZdThlZTFXck5pbUN5bythYjhwR2JGSzFnNHl6c3EzMmFSODFEc0Z1?=
 =?utf-8?B?L05KTWhnaWRrTHdvVVRFWkY5YW1Qb0xvWlphVkpoYUEvUXBoOC9Cam9qcytE?=
 =?utf-8?B?bEUrQ2tNckhZRTNIdTRnUDF1bHBpQXRsa1pDb213UkRCUHpFbXlBUi9GUmJI?=
 =?utf-8?B?eGN4bFRnQkZBSXo1R3FzZmlBRFBrbHkxU29kZEdEbmw3T1BiOUsveW9IZ0pr?=
 =?utf-8?B?MjVZUktuV241ZkVXblAwbUVkM2pkbVBWQ0lrSGthb05OSE5uTCtGUmkySElG?=
 =?utf-8?B?Q0xsazBHZlZsLy9XTTR5RTZ1ZnAvOVZ6a2tOdTVZaHdicGNyU1ZEK3htWXNW?=
 =?utf-8?B?VGdyVW9IRmtDOCtkOUF3bUgwSVdwU1lZVXZRR2gxWVpRa1BsR3hhVzVJQVdX?=
 =?utf-8?B?UlVvT013U1JLOUsxTW5FQUVPMk9zNEIxMG9rc1NlWUpRZTZ6V200b0dHUFVO?=
 =?utf-8?B?M254M2psUWZ2RVJVODJVaGxpYWJ6S0o4a1Y4RDE4OWhyVkRnb3JQM0cvUWcv?=
 =?utf-8?B?WDEzemlPcW1oWEpjY3hxeG14MmVKOGNzRk5zYktjZXZnR05WQmFSSXpjd2lz?=
 =?utf-8?B?NVJoQTJBYzRoZitqTkZuKzMvMlZPaDdpNVhHM20vNloyOHNwTEJWd3o4c1h6?=
 =?utf-8?B?WlNLM0N0RWhXSTVtd1gzMlRGaTJkbjhPMy82RzliSWU0RzVuYWlZY3NoajJi?=
 =?utf-8?B?SVp1dFlxaGxjOHRrTVVlYVJIODlhc3grcG13OUJXV3BCaEQzNUxtcmVzb2Ny?=
 =?utf-8?B?Wmk5eUZvWTgyYnFWQ0JOWmc1ZVpPMnFMbC8zWDF1Rk12akdWVTZ5KzhtdjZV?=
 =?utf-8?B?TW9lUGtNSUVHQVJmdjBDeEcvSmxmTEJnL05zTWtPVzRYM0RyZjBEMlhQU04z?=
 =?utf-8?B?Qjdab3dtYnpsTG05dVdPck90ZEVOOFBBT291WTlQeXdrbDVxS0E0ZGZEVW9M?=
 =?utf-8?B?SDFhVzJLWEkyRTRrdHhxQkNFMzRoQ1B5TXlHMW9pQldmcVBYcFJJZjVnODgz?=
 =?utf-8?B?cXh6bkwwNXMvb0d0Zm8zQjJKWXNEN0tJZlowK1JUVllNQzZyb0VSMUxhNXZa?=
 =?utf-8?B?eUg5eWJNYW9jRlNzZDhORkZIbnVWamNoSWk4M0dTa2dDSHdtMEsreXpZeFRX?=
 =?utf-8?B?ZXNyUDhTVzl4dmdXby9GallzazZlRE15SXV6K2h5NVRrTzFObUp1TmFsSENj?=
 =?utf-8?B?Rm5YTW9hOVc4cHJEUHIxN2hVMDB2Nk16cjJTa2JDUnlVU2FvSVN6S1krQmNI?=
 =?utf-8?B?aDgwUkFrcW9qMTR4dG9sbmJQV0xxQVdHWTJ2a1IrRWZmdTArRkZ2N2ZBQUtX?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3908e30-a701-4a47-edff-08ddefd1461e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE396822D5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:47:06.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHV3k/uej0+luxQ+EqDDyRvM5uvfVllQeqo+bWsS0HLn1zbJy1wYvMge9vIKaPCRcyMEMGv8v5GXGM0dis02yfHb1L2bG0pgrE4fjo9PnEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8535
X-OriginatorOrg: intel.com


On 9/5/2025 3:56 AM, Jakub Kicinski wrote:
> On Thu, 4 Sep 2025 21:01:49 +0200 Sebastian Basierski wrote:
>> On 9/1/2025 10:03 PM, Jakub Kicinski wrote:
>>> More context would be useful. What's the user-visible behavior before
>>> and after? Can the device handle installing the filters while down?
>>> Is it just an issue of us restarting the queues when we shouldn't?
>> Before this patch driver couldn't be unloaded with tc filter applied.
>>
>> Running those commands is enough to reproduce the issue:
>>     tc qdisc add dev enp0s29f2 ingress
>>     tc filter add dev enp0s29f2 ingress protocol all prio 1 u32
>>     rmmod dwmac_intel
>>
>> in effect module would not unload.
> Makes sense. Could you also confirm that the offload doesn't in fact
> work if set up when device is down? I think block setup is when qdisc
> is installed?
>
> ip link set dev $x down
> tc qdisc add dev enp0s29f2 ingress
> ip link set dev $x up
> tc filter add dev enp0s29f2 ingress protocol all prio 1 u32 ...
>
> If it doesn't work we can feel safe we're not breaking anyone's
> scripts, however questionable.
Sorry for late response.
I just checked what you asked for.
   x="enp129s29f0"
   ip link set dev $x down
   tc qdisc add dev $x ingress
   ip link set dev $x up
   tc filter add dev $x ingress protocol ip flower ip_proto 1 action drop
Looks like with and without patch ICMP packets are dropped.


