Return-Path: <netdev+bounces-210264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB77B1284C
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E301C8155A
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B487DA66;
	Sat, 26 Jul 2025 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgoQ8m5+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB221D555;
	Sat, 26 Jul 2025 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491310; cv=fail; b=k7Y1kNnCoufBEC/URFfqdfbO8ViQ+nQlo3tza4n8bUSkctsi93KkU6nCdYlNa/B1UjWAXPCAeddzQup0Zl3KLDYLTiEYfF+QfDGx1w7fsbjhTIwzLhidNWx2iwvNOqkLjnxCoXurY0tymiJBEwWwAXEduf8O96Lr56rrEkKRJHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491310; c=relaxed/simple;
	bh=Fy2g4nY+Uw0Xc6LeavN96exby+eZ8Eqc5vXtRtaKyXs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=lS13dE4IA/uzV55W9PhuTSwcV55anr0MWMmAn5WYzvdjxX4eYK/QbL0HgIgMCNV+lfybyc5WPg1Tci4cXnbF2cmjbyjdfBc9Itn4uY9Ny1Uk32BXCN7gefl75lixY2GbgFHreE9q3bR9HczpxahE9K3soRa04/MZcO0aMUlHZKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgoQ8m5+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753491309; x=1785027309;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Fy2g4nY+Uw0Xc6LeavN96exby+eZ8Eqc5vXtRtaKyXs=;
  b=ZgoQ8m5+bRSpl+JzA5ZBu4ioVx973YN1+fyxY/LrEtmMB0Hbzj/dCDGz
   axfs2B29+oOB3E9uEfomnsK0M3gFWe5P2uBsSpVRspp45NDtV9uCqvwxv
   G3C4TlPptjhnc48PLVV0EFWmBXDhdLsfL5OOGecuPVXtqJSJbVjsY/lE2
   Uv59m0iNTRE2gsRNRT6tUoF398sNflw3eZkvpsj5CA4NOR4Kt1dOPeQIK
   b5wb9hyUzQC3sClBiKq68oXPk6Z49aVn70VQUHMTsYdou9zrPyJqm+q+b
   5mQoDM+yyaPoVxYjIEonHDaFKGGZdlErZsAjCOfYqnLF7WiMNC3MyPj3m
   w==;
X-CSE-ConnectionGUID: IY5AS6vyTUCQb8ib18xVxA==
X-CSE-MsgGUID: ImwycrIiT8WWKN5odkEyEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59482557"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59482557"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 17:55:08 -0700
X-CSE-ConnectionGUID: B2hxIr8eT2Gnbdf/Awctvg==
X-CSE-MsgGUID: kqKo8lV/SNClP5BHAbuLxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160936209"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 17:55:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 17:55:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 17:55:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 17:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwiHHMAwkcvPaI6jbuDmM4FKc9hf3c3tAXyky/O+ncHGG+pme6JjFPeroVarom4PekL6ldpmKZ1/r9swU7pYkGpSUe+vE4ngJxE8lAT9HxR/UZ8BQEwutn65fLnhnWaRIZHKuNbLAbg8AoTxdbMawhKzJU5u/fPvVAxN3OYssgvy5aSQLliN9qi4Jwx0ctKadhuu8IRqPuBqvma2WB/If36ymRJEiilECTZlomulkD0Vz9JSgYv3ohnyqBo+5i+5QIPFrRhY+V4GLFyZIW3fSZtQYQtcP5jcz6b/frqpYssMSGl1daVhiDSKYA4ON/pEGOR6MSSIohHcLe5otuclWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vraTeW1Oez3XoZ4mQHYkGyYASu94MUA+OTBupGRA97U=;
 b=USilrW8XfB5vO7mocmkabfA+jFy8QZKSe461nspehs8qG/NabWL0IgPxWyoN44vOawvpGk8+UDUbYyMMKq4SpOcW9xRm1TIImetvOtk/Do4N8V+Jxd1XerAodgdMUzaUY7yYwEUKX24IekEqksyJrG1mOBzQEwEnQ8IhsC9UJYJ+aNgqVguEYW/Vw1B5g2EuvYCcXRWi7Zmkq4kE6941oorMHt8NuJC8TCAPWOl64HfDJvwlSvz2/Ynv8KJSTJxIzoBy/Vu8OQrAkQE4kfslvV8b7R/WUghzFruqs0vG0x2wS9dlLOLZBA4smmJkimmKgcVPVkkr8o0t2Tk+PX0snw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF0084F97E3.namprd11.prod.outlook.com (2603:10b6:f:fc02::4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sat, 26 Jul
 2025 00:55:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 00:54:54 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 17:54:51 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <6884275b762d2_134cc7100a9@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-7-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-7-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 06/22] cxl: Support dpa initialization without a
 mailbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF0084F97E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d57138-88fb-48c0-9702-08ddcbdf0884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUZCd0RoeXp6TSt3bUdjYk9OWmRmaEhKUXZsTUkzSk1FbXlKS3ZlZTlaWDda?=
 =?utf-8?B?YkM4WHNPaERMYkJPaE9rZjNpcXFTR0txdEkxdDQ3bW4yM0d0S0VBZ1pHT3FL?=
 =?utf-8?B?RG1vTlVpenllSkVRSUY0SHIrUUxPTkMwZVF4SVZXbTBHcGM0RFEzN2p2L2gy?=
 =?utf-8?B?QnJDQ2ZsYzRvQmR0cXJlSmZlWk9XRm9JaU9oZGppdVUxRDVOMmtzK2x6ZkNY?=
 =?utf-8?B?NGk0OE00VFBUNVpQOFpqV1BaZUZEblAvZ0cwYUlzcE5ORTlFRmt1aXNuYTg1?=
 =?utf-8?B?YStoUm9lb1hlQ1ZRNGtmZlo2OHI1Vi9jWkIyVEZtaVlwNWRjZzFoNzFaekln?=
 =?utf-8?B?d2duclRwa2x0N0V4eHlrU3hYeHRYSiszM2c4TEtLbEVoWFlUdnp2OWhnT2sy?=
 =?utf-8?B?Ris4YWI4a091emFpREpEa3YzT1FJS254TjZpSXJTY0lvTEN2L0hYdzhEdll6?=
 =?utf-8?B?cC9LSDlBMSsrb3NPTFllVTNvdEFDeTRiNnlxV1FQS2ZqUUZIKzhXUHQ2MCsw?=
 =?utf-8?B?SFZLRy9FbmJlRlBoRTdDYU1HS0prUGZpbWE3M29VbElKRmx3RWVZd2R6VStD?=
 =?utf-8?B?Zk41RXR6cnlaM0pYbEkrU29YMGZkNnlBSkVqbGpsa25ORnVwSEVwQlh2cDYx?=
 =?utf-8?B?TUJ5bjFTOTVXQ0VNT0dNRDdGRjg3K1QwZXNuanlSMXluWGR1UzRsQm9PRy8y?=
 =?utf-8?B?YjNQS1NQNGdtaUJybktLaW5Pd0d2dngyRGR5TEx5cElIRzg4UHZWT1N3L0Vt?=
 =?utf-8?B?MGhIc09xNGRJdzhmUnJ6MCtCMTMvZGlFaTc3T25ZZFZ4M3BTMm1XZEUzd1I0?=
 =?utf-8?B?WEMrUkh0UjMrVWZ2NUJhOHd0T0VlSkJEMGtWSkJqc1NQTEMxd01qOHYwK1R2?=
 =?utf-8?B?U2VJZWMwUForYW9SbUlvY3dyQkkweGhyTEJyOWgybnhpS2VGSHdOL041RUlO?=
 =?utf-8?B?cHJ3cU5ZWlpiSVFITEtaK0dHVkFPaUFoallPYUVDTnJZaklrZUR3U1VKZlBM?=
 =?utf-8?B?dWxqZTJhVkNhdGpIb3p5UCtpZjluWkVuM2FlOHAyNVJ1R1JoL0lMUXJ6b2RO?=
 =?utf-8?B?cUdiRElMR0hGR1NrVzhsYkJ4cXNmV3RCOUVYMGR3aSszNVBKUjBvcXNmSi91?=
 =?utf-8?B?bjdjQXhmbEl2dUM0THBieU5PL2N3NGh2Rnpxam1VYVBCK3BUekg4RVh1d2kx?=
 =?utf-8?B?Rlo0WjlrVUh0dGFrM0FBTVV6empGR0xXeFFBdEVPS0Y1Uko5STdBQ0JqN0pP?=
 =?utf-8?B?ekVXQ0lJRVJSREFjeFlQL21ZNkF6M21QU0R4d1VaUVp0QlZaNGRuWXFsVjFY?=
 =?utf-8?B?VExNNFV3L3pUM1lSbWtUa09VMVRST29BRGtoR3d5Tnp6Z1BJSDNaWWk0ckln?=
 =?utf-8?B?TkhVWjdaN3dkc2xsK0xUT1V0VW4xQUNZQS9odWtYbnhWaGFmOVlVMnIyVlBH?=
 =?utf-8?B?T3VrSmtrTzkxd3NaMG5HUjErbVRGOUFUOFBjM3BXL2VHeGxmZzhBbElUeURn?=
 =?utf-8?B?ZXVMMzJGVmdrQ2QwbXhISmtLRFprWXdHY0EwWkxKcm5PdUFuZFB6VHB2ait6?=
 =?utf-8?B?dHdmempUbjkyL1IrcVZDd3Nzc0JGamUzd2xCL2ozVHRlRTNsWThnL0R6bGlW?=
 =?utf-8?B?R242dG1PQnMrZlk3RzI3SzlhWXUxLzBSYXJmbVQ5SXM0c0YvMnQ2RG9ZcURP?=
 =?utf-8?B?dmpPNmt2VHhPSVJNMkZ2c1phampBN1dvNkxjTkRwcnVmQzZTRXN2TzVQT2dh?=
 =?utf-8?B?blVJcUVPR1BwWnh1V2g5ako3Rk9DOEkvYll4M2w4NmVXcEpvVU5PazRyaUR2?=
 =?utf-8?B?ZEsxSENqbDc3Z1kzbnBxeXNxUHJuU29tb2Y4bmlWRFVlQXRqdXA4MUJLQTVy?=
 =?utf-8?B?K2M5c2ZiWWQzb3BUU0IxZzVadU9CVHFvMWFnVmRtOWhiU0JqRmNFQUhsVndk?=
 =?utf-8?B?WjNUOWhwRUJacjNJcDdvaWxEb0hyWHEvbGUyU3hYaXh3WndWc3FJWU5Gc2E2?=
 =?utf-8?B?Tk1pMjU0dEF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUx3a2IvT0RkeWhla05DbWpvVTVZOC9TNGJIeGc4Nys5YmtxejdQZ3Fub0Vo?=
 =?utf-8?B?M3NHcWlxSWIwYUNHbzNxd21QVzY4azI2RjF5Qm1CUmF3dG5IS20rcmIvVHAw?=
 =?utf-8?B?ZmM0bGJLaXNNdkJzZnJwcjg1N0l1aHUvRzJiT29RMitlRlpQczlDOWJpK3Ns?=
 =?utf-8?B?UHJyUnFubGQyR3ltUE5DelQ1ZzdTYnJmc0VsRHEzdnVhbG9VaG9JSStJSnEz?=
 =?utf-8?B?NjVHdExZTFBVUGdoVEttSjEyM2hDZkY4Q1gzMDBRTlhkVUw4VE1ra2pqOU5G?=
 =?utf-8?B?Q3F0cGhrV1BleW9ldFd6Z0wxaTU5NW05N1JyMlQwWEpXeTlMV1dKdTFHaGdX?=
 =?utf-8?B?N0wzZW9MWW91ZjlOS1NmT2cwazhRWFpGYXVhVG01S0E3eVVrcUpoSy8xRmow?=
 =?utf-8?B?SXA1cGpmMUpYVDRNdkg1Sk5hUVJuUGVxTTlwa2o2N3gxOVZvVnY3V1dMQnRO?=
 =?utf-8?B?TWErQUNPeHNSN2Z2VlBibXU5ejZRRmFqRlljcDl5a0Npbno2Y29aWHQwMXU2?=
 =?utf-8?B?aEt0SnhZOUR0ZnRDbzB5ODI3NDJnWlN3MjRwSE5jcVBDZThmSHJhNkl3MWpY?=
 =?utf-8?B?emNHUGtzNE1jK3lQZGxyVGI5NTkwWGdhZGYycmthODZHNTNmRmFaSGtlYStp?=
 =?utf-8?B?Rm9YRzYvM2dxMHFpdVdCK2FWZ242SkNYNS9sMTF6ZmhjT3NFZ3hvc1l2NHN6?=
 =?utf-8?B?VjVkS1VkY0tOblJXdjZuY1pGZW1RU05jV0orMXBCQXJadHZYWEdrR25ZcUhh?=
 =?utf-8?B?S1dkWVdkTlNKSVpPSE5FM1VGdFIzUStLRU1aSFVJTUV3N0ZFNWFzQzMrWFox?=
 =?utf-8?B?RzA4TlUvYUdWVWlvREt2R3ZIb1VVcS9IVzhrN0xJQ3JKbkJmUmxqMWdSaE9w?=
 =?utf-8?B?cHJNbGFuUmlaN2hvbXIzNUNKT1Y0eDBqellHRUgvMU1OTFdyQ2dRZE9KSTFt?=
 =?utf-8?B?WXRFMEgzZ2FFU1I3Ky9rTHVMWGp2WitJWGEwM1lkOGhDcGRmcTArRXJuL2FX?=
 =?utf-8?B?dHBxVVlLNUpqVjNHZml0RDkvUDdMb0tVUDJVa2NaQktUajBGYnhrMHVDcDJh?=
 =?utf-8?B?cThzSm8rcjQ2NjhCc3VOcFo0VEVhNGNPOEZUMEtZQUd0N0FzMGs0Wnp6UG93?=
 =?utf-8?B?YjZzSVhtZ0s2ampjZXUwRm83QlJYUkNIMkc1dkhPOWZmSUpKWjFsZXd0NUF1?=
 =?utf-8?B?d3VTWGk1eGlqTEk2OWM5WE9RNTNvdGhGaUxUa3YrektjbWJ6TFFYeHQ4ckJr?=
 =?utf-8?B?bWtYMDEwM0pCbmkyY1FCcWd6WUtMbTVWdjhmbE1WMFZFanlzSmh2YXNncGkv?=
 =?utf-8?B?My91L0JObjBEblRWalVTeTI1M2J3dEc4L2taRjZvTVpuOFFTaW5aNUhyK3lx?=
 =?utf-8?B?bkNFczNHekNNcjdBb1pHVFVFYzRYRkZZMU9rU3hpak5PanBzblhBdjYycGwy?=
 =?utf-8?B?Q0NIZ0R5ZVB3WWo3cTNHV0dVRXZ6LzRCY2JNbHhDYk9CYXZQeDVTZy84RkEx?=
 =?utf-8?B?ZXlCbGFNcVR0TWM0MmpxQllRc0VPaHE5MEpzem9RUHBQaTNTQ1B1NDF2MjVi?=
 =?utf-8?B?NklsOWwweTVmdmF1dm5VSDFMdjZSVlZqVHFwL1Z6VU5JRU1DcjhER3pJL3ox?=
 =?utf-8?B?Y2hzTXA3ZkVRUTY1cmlXcEZpUjZJUUJyOUEzdEd2VG1IZUtwb1JhK2dBY1hU?=
 =?utf-8?B?b09CVjBqL2xvd2tVQ1h6K1A2cnF1S291VUx1VWRJRkM3cjJTUjlEV0RtYzBB?=
 =?utf-8?B?elE5a25hWXBldDdYWlpibFRnRDYxTmtQdmZNMmFHc0JpWWF2QW1PUFM2NmJn?=
 =?utf-8?B?QzdPUk84Z0ZxZmhQY0N3c0ZYZHY4cFZVdncxLzlaTUVwZnhwWFdJWnlxcW5K?=
 =?utf-8?B?cS9iMGdGcjYzeWtveWtmTFZWTWI3K2N2TkR4TVlWWWR6Z1krb0xTTi9SNzFN?=
 =?utf-8?B?amlhM2hMK0JCcTFVOHQ2WVowVnhKWG1KWlhGQ3hXK1RpZWdtZEtJVGFjb09a?=
 =?utf-8?B?V3BOb0Z4Rm9zNlU1QW0xNFZMRnhXTk1aSTF0ZlNwTmJlYnRwM0RzK1p1YzFU?=
 =?utf-8?B?Q29IN3pYV3VnaXhBQjZQWmFwa25CTzNRMXJhSmFWRDFVY1IrWTNtY2RjbnB5?=
 =?utf-8?B?TTQ2ZFljVDNsZ0ZjdVF6NFVzd0ZDZEZkWTgvSWk4YzBzcWhlWm8zVDlEaUFX?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d57138-88fb-48c0-9702-08ddcbdf0884
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 00:54:53.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GRNaH+TPyAoKSxPzZdqex5ZjXx83Od+GkKGwX+XVEPaDdm2dsm/ve/9EyxvP1rV8qW2LSEyIe4vVMTmALOAn492g1RndfDW/ST72B/bA00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0084F97E3
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>=20
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
>=20
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
>=20
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> =C2=BA

What is that strange character on the last line?

> ---
>  drivers/cxl/core/mbox.c | 17 +++++++++++++++++
>  include/cxl/cxl.h       |  1 +
>  2 files changed, 18 insertions(+)

I would squash this with the first user.=

