Return-Path: <netdev+bounces-122954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE543963455
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A245B286E17
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F11ACDE1;
	Wed, 28 Aug 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvuMK13k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DB165F17;
	Wed, 28 Aug 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882629; cv=fail; b=sKVZXFD6T4ICkACYsHUFua2o4hBDzrscjij2V8EIXkoImjJt1M/Awt9KqDrVr+j3X/uQwUtuB1B8KBOUMrgOq9SmJ5t14XKMCBlhvZ9fWGbOu5fuuwdkIAFjd4RV36j0VobL8xtRJ+q0Vp3yki9TvoVYx+TkVne86Phpv3GiLLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882629; c=relaxed/simple;
	bh=Pld3So51kObsT1X9mVlnie3PFFtW/uAwhSHqgGiVXgM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=njWbzMc540PljHZqoftdnmPsn2isDo5KzGCh5xvfwgbHrfh80I+9ypwsiDFjTjLPzaqAOvcMw1GjAqpv67pcFWD+ZEOwS/pRX4QDPeGEijsAWnk3cD6zbZrwFZI8VlyGbNDBm+Z09Qq4ND/EWGhqIstHDSQsSesRkvSHmJ9cDow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvuMK13k; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724882627; x=1756418627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pld3So51kObsT1X9mVlnie3PFFtW/uAwhSHqgGiVXgM=;
  b=jvuMK13kP5OFoN5x0FWTU5svrDf5aW3QGcc4oSKM/KEimGXXPnZ9kw9B
   J5cpxK6noMpcpUJwzxiNR0DKVOyo2uxgFCqhHk31MAzATZoBcMOeJWoEt
   uWm17WrzwX5O1i170Z6S/cTr8LdxxBG+tMW2RmMYsRti/l3JCGYklKihM
   kMKxovyNrN+bpBAxuKZmLSeqZgQE3vyOzR4VMw42hB2+C0u3upyeOOgXS
   Sd92ck5JgASNkX5QTdC6wBFdMFEIJBztUqAs+Qm7dQ5NYV/ZtYEO5b0VR
   Np05QW2eVX1neFhV9fW3VzfiKv+CxTEg8FP1ovuFI9oRWXVMrNLco/hZs
   g==;
X-CSE-ConnectionGUID: 8JjYuNSqSfWZxwoVIsJm1w==
X-CSE-MsgGUID: HMjiBqc4Q5CBWwcEMaXqxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="27209986"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="27209986"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:03:47 -0700
X-CSE-ConnectionGUID: POL6IH8/QWusL/g3KBMetQ==
X-CSE-MsgGUID: C5V6oHRLSh6yjd781smr0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68039083"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:03:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:03:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:03:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:03:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfexM1mXu+kYv3DWY2G4ErVuPBy3kupzKiSXVH6Nmgr3F5Sh+CDW/MFxsRNGbdmnXUQiBQiEZxwbPklwJf6+js/UzUvx/glCKmgjXG/3hq5NQ8kTwMPj7sS82mGHsuFtO+TrazVfM4Seyu1RVGGGdfNkIXgsl/8OMFtoTlzNY0vnw/mFe5hrMsszAWkC1/sSdfXPTklxN9hdwJz3FwLpQFgJwsth0jjXGWNQKsUJWvi3NJL3k+Tw4GRTS19lPhCVaLAqvnOOm2Kqqqze4FhGalwmtypwEs4YYTRfaUvIpxm0JGbLLjKI5QhRGe5lcCPEvVAt6ZX6uu8ag5BL9oTStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44/83dSiH+4KFsA9xjliNML47LTbqgerp+zLEhV6zOE=;
 b=ZhvQFApg0BoP0Devj1zn0Qv/7Q8wk68b8frsSmSOeruE7Q8mK7czahMLSHvZtqlJQ12Lsl4foSSo18/35xfN90Klnrbb/677Y4Rh+L0JE1aQ3fn15JRqF02xmrEexY1qjgb/8DgBSb5a/N1HbSFJxy13pYnmueuYUVfQ1fDOQFuAaEnXWuLcNXpXUeXKRTZTzUTkPaT1WKhqNS7NAOLLTHjIaloWQ6X8H0wjYB8CtsLGQ7yYDVZ26SnbNtaMljwBN7ksfAND5nzMh3HjqaZnM0zfPPGS8U1sqMrcf/UdnKTGLQ11V5NYauJ96yFdGtqEKvOgGf3QnwWJYnIghxCslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.34; Wed, 28 Aug
 2024 22:03:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:03:26 +0000
Message-ID: <3ebb942e-532f-47c4-a002-b03cb831adf3@intel.com>
Date: Wed, 28 Aug 2024 15:03:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [[PATCH v2 iwl-next] v2 4/4] idpf: add more
 info during virtchnl transaction time out
To: Manoj Vishwanathan <manojvishy@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<google-lan-reviews@googlegroups.com>
References: <20240826181032.3042222-1-manojvishy@google.com>
 <20240826181032.3042222-5-manojvishy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240826181032.3042222-5-manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a9b85f-2b42-442e-7d1b-08dcc7ad3e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzlVRFVQZjRLOGtZRFp0eUFQNzZEQ3NhWE5WWGFnOFlLaTJZN1hlNzZ4VWNo?=
 =?utf-8?B?eDFHNmVlS081QWlHTnJjekRFS1JIWUczNWtGUkU1Zy8yemdZdDE2Yk1MVUxy?=
 =?utf-8?B?YS8vVUdBelNwYVpsUTF2QXUzY1QvYk1rQ3M0aHNtNGJ1WlJRRmp4aWhsb3Na?=
 =?utf-8?B?NTRrR3VnOGFJMnduVUFTeUNmMU9YdWNONjNjZ01NMVpTYmRRUHVDRGNwcFBj?=
 =?utf-8?B?OWxrckxuZUptNkovemVGVXBhVTkyUU5UYTJtR3Y3VHZvZis4R3hJNzNHeXNK?=
 =?utf-8?B?NTk3Zy9jc2ZXazF4SEcxM3p6eUlSQWp5YkN6ZHBhWmJXcDVxMHhISEY1cHd1?=
 =?utf-8?B?ZXJ4UjhoNCtRTUx2ZVlwOGpwSStVMGhOKzE3V2R3dXFGMGdzd2luZkJSMDdF?=
 =?utf-8?B?VDZUOVhta21ZamU1cEZ0UUVWNCtOL0xLVFB5eTJYQ3FnaDZZY2ZDMGQ5K3hu?=
 =?utf-8?B?eCt5OUcxNEFSKzF6bGRKdXRpZllLNjhjQThiNmZpSzZRaVNhQjE4b2YxNmNR?=
 =?utf-8?B?QmpTYm1UV1VBUXNiOHVOWStOTjZaai9TbzZVdmdNeUpaUHFlNnFDNzIzc1FP?=
 =?utf-8?B?eHBSWEQvUmxQay8wWnY3aVZuWTV6dU0zVEVwb2Z5OU04SThzSE82bFRLWEZY?=
 =?utf-8?B?RWVybzRER0JGZjczTUFhVXhBTTc1ZW1DMk93Smp2R2RBUWl5TzUyQUEyUkJq?=
 =?utf-8?B?SGZrNVVUWnlyYVNWcm9BUXJ1ZXJWejNZUGVkdFpOMnl3aGt6UTRFYkxoWFlF?=
 =?utf-8?B?THkreStwSEJsS2dIL3dEdlVUYk9jYW1YQ2w4R3NrdGVlMnJ3QTVPTWZUQmZG?=
 =?utf-8?B?OURvRkJ0VVVUUHRKYlBiT1FxYXIrQkVCNkh5NWoyMnRSSGRMQmwxRjhQZ2ho?=
 =?utf-8?B?NUM2V2QyREhQNGdaOHI5a0tTdnVYajhCVkltODNzOXBac3A3OHQ1OWxEUWE0?=
 =?utf-8?B?S1FwVENPd0hoQUY4WnhTT09DdHp3cFByZHRtbUVEQWphVEo5OU8wbldUNm5Z?=
 =?utf-8?B?ZDM1MVg3RmlGVmo1SXp4Qzg2QllhcGFVTEhJQ0NQalBocU1JejgxcE9FY3Jq?=
 =?utf-8?B?L2FIWnVhcVI2c2VpcVBONlEwVnFsZ1Jpa3RXNXFuMFBuc2R2K3NYWUZpU3Vz?=
 =?utf-8?B?eXFPR1BhQnNIam9lWitpdGFyZi9ER1V2ak45c1ovekF5d0JBR2k1eWJqaGZt?=
 =?utf-8?B?cG9vTUljRUVBMTBHL2oxZU42Y1lScStWRHMzY3NBZDdCSG93QVdiUXpXRHc0?=
 =?utf-8?B?OFBiS3JXekl4RUkxUWJadkJCWkpUZWUwSjR3QWFjZ0VYd1NtbGhnMEM3Ukxk?=
 =?utf-8?B?NmJJRkxibnVZejE1VG1laXRVcE5HTnpjU2Y1UXRTaXRVbyt3WS9iSDg4WkJu?=
 =?utf-8?B?U3Q3RUw3WWlvcXNFaDF1eGkrVksyYjI3bnZ2OFg2ZjBXamhHUWJkVUdCV3FM?=
 =?utf-8?B?OXV4RjFvdW1OSlZHRFA5MUlOcWJBbnRJQmp0cnhPa0xrYWs0SHRBQ0h1Zkl4?=
 =?utf-8?B?WEQ1MGNFUXBkMXlubjBQY2IwdEhUV1B4QlJTTktkWmprKy9pcS92WWRWWEdO?=
 =?utf-8?B?QWJQU0J5OU56dFdFVDJIazNuZXBMWFJQTmQyQzhVWEozUWhaRmNqUXFNMExo?=
 =?utf-8?B?S1BUOHdsWWJDR21VcnY0WVF6QmRmbTM3OUwveHROenE5bnJzZWF1NEpKWGtC?=
 =?utf-8?B?UTAxU3lRbFRiT2ZxQkdOQ2UxQjgrSXFQYjRINFZ2L29OUjd5VG45UXI1UzZI?=
 =?utf-8?B?MVBwYzlVd2pMUHB3YktJNzdHbk9RYndzbXErOTBGRWhlMkZBMklQTDRxWSs3?=
 =?utf-8?B?aTZNNllvRVB1K21BakhhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdBMkNWUjRFUFVHdFNSUlpvUDhHN1V6WUExTDBoNXloTkZFeDZpN2NsK1M3?=
 =?utf-8?B?M3RGUmlxMzc4Tk5CaGVWdkVwYWNFKzltRXVZdkVZd1dLWnJKMFBFOFBZTThO?=
 =?utf-8?B?OXdCWTNlQ0FtcERMRDQ5TndLUnBjdFJsYVRTclJjTXNCZTdlZk05bW1KQ2lt?=
 =?utf-8?B?WkJVN09TcWwyUUpvbE1HSFNkRldGaW5NWGFTSWt6Qk4xY2JmQm9EVTk5L25t?=
 =?utf-8?B?b24zNkJyRXZWQlI4SGFacm9DalpmOXphTzNqQW90Skk3dWEzeUZzc1g2SHNu?=
 =?utf-8?B?YXVLRnpPQ2RmZU5BWmxmOHpiVCtIc3lwblRkSENkZ1ZadnFVU1hpdDhtQ0cr?=
 =?utf-8?B?aE9rZWdDZXprcFJKaTVlTTVOdFgvcFJ6T0tNcnlKNSs4dzM4b3JwT1lVYmNT?=
 =?utf-8?B?aDB6QzNFaW5KeFNqL3YwaVc0am5hWTZMTXJUUXNIWDRSR2dKMFQ4RDNDU2Jk?=
 =?utf-8?B?bG0vVGcvQWlEMlQ1UTNlamg1akxJMzNXUFZjMmplSGw2SjRjeTREcGNPYlZH?=
 =?utf-8?B?SzRlcktBRXljWFo0Q0h2M0xzSVVqUzloOFE4VzN1VGp1MnBYcjZHZFAzODU2?=
 =?utf-8?B?K282UElSYmxjVUV0eDkxVlNQMmNWZHZlUm1kUmY5dWp6RXZObEJjTmptVjNS?=
 =?utf-8?B?RUpWTUhldVRuNE85WHVrZm03OGpHdUVjR016eDhPVkg3S2VWS3NFNGNRalpD?=
 =?utf-8?B?RzA5LytBWFk1bTJhVjRWRmZma3V6R0VDc0ZpUmxUU0U2QnFWZHpQR0tYeTMy?=
 =?utf-8?B?ZDNEejFycHRCRmdHR0hwWW9SYnFGZmpsc2V1ek1WS3ZuYWYwYWV0bVk5R3Zw?=
 =?utf-8?B?eXQ3SUF2OWRPZFBERnBQS0lFdkVUUzdiQ0F4eEZYYmZPUHlBbEY5TlJ5VjJB?=
 =?utf-8?B?ZmhyYUVJMWhrVkdyUW5NaTd2eHRvdkZKRUpiaHFFUmlCS3ZNZlRaYm1DdEo1?=
 =?utf-8?B?bzVMV2xqYS91ZWJqMHN3NG9Mc3ZMMGdqakhPVytRdFNDSTB3RS9WKzl5WU8y?=
 =?utf-8?B?VmQ0RTNPMHJCRnVaQ2JOZ01zYkJTU29nVVZvakdPVS9qRGVmR3pjQ3lyZHVm?=
 =?utf-8?B?ZHNwNWRZbFpWdEt2RmEyQ2x6TUwvRHBZbmwvWm5qYitXKytqR01DdXpNejVx?=
 =?utf-8?B?R2pGMTRoQ0syYnJKNXlqdlEyQW5hN0ptSXU4S0VZL1hJTHFkUjYvcUVZVFM0?=
 =?utf-8?B?d0NpaVlJQmlZaThoZENZWlVaK2pPZG1ibEFNTlkwWjZHQndoY29VSWtBOXdZ?=
 =?utf-8?B?OWZZL0lFeGFBUWhwTVhRYm54LzJnMHVaWThwdk5sOGpmQ0hPNHNIRDdDc1hu?=
 =?utf-8?B?eThiVTJ2WkJ3OFpIK0M5ei9zNDRvbnVJUjNhV0gwSnRIeUhwM2Fuam9EbGZY?=
 =?utf-8?B?K2JjZXc4anJyOTBFTExxaGlYV0hVUDh2YXdSeERIbTVHR09sOFdwT1NJRitY?=
 =?utf-8?B?TnpVVXoxek5hcXVPRTN2MW1EeTVJYzQ1MmRqQnVyaHl1dGhKdUorVk0wTCtF?=
 =?utf-8?B?dGt0UENSVEpNU0h4U2hhU2xnQVp2N0VyL0FOS0x4dy9renBvam5HZ1kwTVZq?=
 =?utf-8?B?cXg3WkpBSjE3V1pVK0NMT201dVJ0aDlDWGZ3UjhKaVhnVDZOTXd2dzhZVm85?=
 =?utf-8?B?WFBBRDBhSHFkTmt3OVB4MU1TSzlKYUhoWWViV0NRN1lVZkdWTTZ1Tk5XTFRV?=
 =?utf-8?B?ZGt5dmxrVDJCQmtkcmw5SXhxc3JaZkpRRjN6WEttZ2NlYWRDM0lNVUxZWG9a?=
 =?utf-8?B?cldxRGlmMlhLR01ndWlPSmR2cUVvYW00UC9BdkgwZVFHeS9PTGZvMVJodXor?=
 =?utf-8?B?dW5oRU4vdzl5RlArdGtPN2dXcStMZWhrdGRnUHorR2x0WXZHd0dsRzQ3aVZK?=
 =?utf-8?B?dTJ5TDFrTWlqd2RNbENYUDlndEhnODYvQnllcllCYlVIRFArcEpRQVY1bVhC?=
 =?utf-8?B?ZXlMblJGM2hZQTRoeGJxbHl2dS9kSlJ3TkVYYU8wWm5KR2Zpc1lLZnEzNjlM?=
 =?utf-8?B?K3VtYTk2TDg4emtoS3o3NzhFaW81eWRaVjRhZ01QU0FGMlJPZlVzS3d2d09V?=
 =?utf-8?B?azFQVXZFN1NuMldMOExLSWpEZEswNkF0bndLK3JSWk5IUWFvOVh1dmhDaXds?=
 =?utf-8?B?V3MwUHZiRGt4OFFkc2RaZnZScGhvMEozc3dOejU2U3VJLzlZRlRwSDhaQzBZ?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a9b85f-2b42-442e-7d1b-08dcc7ad3e08
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:03:26.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkcfU3v2pE70MNIqypJu8pMZ/1XFjbF0mWcg3naZyLor3V3xdFTFRW25Q2weBGxihyliLTjnMgLIXVTRr/sfwHfIgXGSOoZmFUZWWy1Q9UQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com



On 8/26/2024 11:10 AM, Manoj Vishwanathan wrote:
> Add more information related to the transaction like cookie, vc_op,
> salt when transaction times out and include similar information
> when transaction salt does not match.
> 
> Info output for transaction timeout:
> -------------------
> (op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
> -------------------
> 
> Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

