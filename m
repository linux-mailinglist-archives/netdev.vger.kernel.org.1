Return-Path: <netdev+bounces-221572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A3B50F61
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35B83A7053
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6930AD15;
	Wed, 10 Sep 2025 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvUEoSQn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97730AD0D
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489318; cv=fail; b=EZNnjDOyISc11mLOo04Q2WmxWWI50DDXrBacflnQeYZ0XcHNeAKILi3qVwUz4hAVS4DlgHeQP8b+ochA9bTyhS7dBWwfzmpiH+EcYcQ/LEiml2ucLLKp/ewZ2K/uAB8c7BIjyEKGoAdTp4aFigOGI1tE4fN5eU9nr1R4N/Lf7Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489318; c=relaxed/simple;
	bh=ltrmr+xeSWJp5V29Xv/DG9mbka3IGxYNgASfzPXwvmg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jFW3MU5kRk/QUJ1ywuMW9+mvjAyBduG/0e1dxY1ffd2wGqg9J3vINgImcbFM6y3UQBUzlr9N/p4RrB+zysz91xqtV1JaB/wtWWxYm7o9sXR+DWZujqMCBsNQzlWYVd4pcu9WMgB1Hg6zLdGkPNqHrYMHk7TKh4hcsG7n9It0iU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvUEoSQn; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757489318; x=1789025318;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ltrmr+xeSWJp5V29Xv/DG9mbka3IGxYNgASfzPXwvmg=;
  b=kvUEoSQnsYJvVWBGcVBW9tlSQp1/7G9Ez+DjxThREyv4cxpC3L7eXC8+
   /FQr3JcUkmWQlcaMqvbUIiWXpOCcEyC9Rw8aJ8+6GiMaEyRhw5qH0YB8L
   EfOaxR0IS5S7+2vP5+lbvlONoNABW89NERI4aL5ddJD8w+RKIRROpaqas
   KipobFrGuZ+A5yO3U+NqYPHGiHJ31PpGIBFMPlNET/BrKScDwM3nD8p05
   yK0KMJyo3IRRHwIKjG7JDkiTshdEbvyqRwA1GuhuEtGREflTgV+df/GrE
   gAzgtSTTn3chP2Ul0zaaYPIEWmnGZKdw7GpRzyzrwpYZ5OKZ30REq7jXb
   Q==;
X-CSE-ConnectionGUID: 7+tyQ+6iRHKJHSPtlELwxQ==
X-CSE-MsgGUID: QX5q0dFsRXi9l+MMjxZpYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70890081"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="70890081"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 00:28:35 -0700
X-CSE-ConnectionGUID: LQfXjWESQpibhQG5iR1fPg==
X-CSE-MsgGUID: Afi4H9VXSayaKq+/AT0q6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="210437293"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 00:28:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 00:28:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 00:28:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 00:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uV0riZk7WIl/sCgmIEMCYiyB2/lbHN2oadeibmzBqeeW7qjO6scwXIE26XSkPANHhMm+uvjurAQelbQ/jA6Fp6Eufgmo8+XXKamsd14vIlJ7pfOEKpsZi+46XhyaZ2OZc7OyZWRSQW2vKMtbk+2v1jEDmwwf1oJFPQVDAqFwW35qSsZftid3sGjXmfCexW3uiOc5A8Qgg7SU8kn2xVujUWZI4AkdQGAM5ZCxMaOFOAQJYBWfRSpZxba/3xOkoqnkGXcbSpSMI7+O8vWhEXhiiV49ipcdZ84ASYdQqQH7oStXa8/AFd6AELtGvRKHPOF3FC5oEvvFIHuxaDwyaGT0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNdNfTmPjm6K1wkzKW5k07/qWSAaVJOHHFHubTneJrM=;
 b=X8ekggFdu1MFXNvU39MjfHwS3aTDujge4iC26VbbQY9MY4HKC/mDECrvcK1Bx3Gwcjt7pZDYWnSZOykXO0h0X6RhyVNmvBZ7nxPM7fi8t5kt6WcAuqEhaa5Nub+aoBn4azLScoNGrHvLtSfl4iJo79CvWxinixP3QUXOHKETGSj3uOcQP3xmf2+IqA6yA9FTkbfBs/bvsibVKlkgtkZ9gxdOdZlMgmBZZM3nuroTZm0JBLFfUj/G7TwoIvEv1bufPXVWr8OIXz2XNtN4kHS1U3oF0b54A+L+zAtTxFdrq1ZTiaUGj0fgvpDVpL0qsMoo75O8ZBpCRKPBcLSz0h8XqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::36) by DS0PR11MB7458.namprd11.prod.outlook.com
 (2603:10b6:8:145::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 07:28:23 +0000
Received: from DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::6cbb:604e:d0b9:97a]) by DS4PPF814058951.namprd11.prod.outlook.com
 ([fe80::6cbb:604e:d0b9:97a%8]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 07:28:23 +0000
Message-ID: <15453ddf-0854-4be6-9eed-017ef79d3c77@intel.com>
Date: Wed, 10 Sep 2025 10:28:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-net] igc: unregister netdev when
 igc_led_setup() fails in igc_probe()
To: Kurt Kanzenbach <kurt@linutronix.de>, Kohei Enju <enjuk@amazon.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>
References: <20250906055239.29396-1-enjuk@amazon.com>
 <87ikht794t.fsf@jax.kurt.home>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <87ikht794t.fsf@jax.kurt.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To DS4PPF814058951.namprd11.prod.outlook.com (2603:10b6:f:fc02::36)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF814058951:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: a743b462-0814-4503-ed85-08ddf03b9fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXhhK2V3MHhuZmJic3laR1ZFd3N5a0JaTE1Kd21FdnozUUNFVlRqa3JncVV5?=
 =?utf-8?B?VUJmTUlHMWxHaFgwMkEwT1NTdlJ4Q1dTcHp5VWR5VUltRmhBV1h0d1NFUDNV?=
 =?utf-8?B?V0RlR2I3TEUvL2FEUklSZkNLckdEQ2R6WlNNU3pqa29LV2JPV01IVTR1VHdL?=
 =?utf-8?B?MFVGRXI0MXdTd0lZUnhzc0ZkdmZ2T3dmdnhQVDdqNXU2UU5ydzB3ZWFOYWhw?=
 =?utf-8?B?dUJ0dVc3bzFNSlRGQjRJekgzVHBCeFFHWHJMVzZsMDM2NmJVTklhbGpNYzdp?=
 =?utf-8?B?RmowKzZ5VTJXUHkvd1VHVGxnTFMvUVlabmpSckxleGxObDRDMmtabXZuTit3?=
 =?utf-8?B?cTYvWWlHWHhHVnJ3NENybW0zSnpCQXQwVlVGb0xBL3BuOEdLdW1tYUU5eWVF?=
 =?utf-8?B?MXlSb2wzalIzai8vVllLV0VqcnJDeVY4MWhEKzVJWUNVblN5bFpmUnhKdFNo?=
 =?utf-8?B?VHFPSUdsRW51K0I2cW8ya2RnbXREU3JPSVgxaStNeU8zK2tZSDBNYnh0TmNr?=
 =?utf-8?B?Y3dKWUVlbW5WVlpFSDYrZlRmT2hnT3dLVno3SEsxOGNaNE9FWmJNak5vc1R6?=
 =?utf-8?B?Q2Z0MHcrRVJ5SmpaN203dnN6amRaOGNHZEQwRytsbjVuM3BLTFEzLzBnMzdQ?=
 =?utf-8?B?eEIxanZEa2d4T3ZKdEtXcVNnYm9POFg2NmdGSDRXa21QRnN0Mjg4QmxYeGVi?=
 =?utf-8?B?M1NaWUp6eFBjN3B2RUp4S2hLRzN6RnZSWTZNd2ExbHJwbVYwZ1VvbFhJRVBO?=
 =?utf-8?B?bXFnODRGZXhiT3Q4QndIRWpiNmxPMW0yZktpc2dTZmtkbDBiek1UcFYxdHVV?=
 =?utf-8?B?VlRqMDFlanFiRVBvcURDKzBvMTBlcWRLaDA5d1BJTy9xaEt4MnhMeXZqRUJo?=
 =?utf-8?B?SG9QajNLS2RZTE9HVmE3NUpxL0RsNmhpN2V2OFpHMU53dVdHdUliOXRVaWIw?=
 =?utf-8?B?Wm82SGlkdlJMR1RXTktwSjJ2bk9EbnFwdFhuL0IrbzVOYkRrNU5vNFg0VEph?=
 =?utf-8?B?NVVVODlZMmtLcmdTWUxmQ1dIc1NONlhmWTVub2FQSXIrS1p3UHF4MUpiZU9K?=
 =?utf-8?B?SEJvY3BGeEVydUZ0anRLc2poM2JGTGpUWk82UVUzcU0vdlpHcG5ubXN4R1Zo?=
 =?utf-8?B?RnNyd3J1ZlUvaWhNTmcvVmVxS1FPcFFDNVNjbTNNa2pmK0hmYjB5bjNVaWFm?=
 =?utf-8?B?V1BpQ0FueXN1c0JaNzJsa3BBcDVGc3JWNFNqaUtNVDB5ZnlBUnVUS3JuMVBB?=
 =?utf-8?B?T0hacjRJSzVKWXMyaGlUMjlQN1hPdHZYTjBGTURmdTZXUmFodXBjM2V3UDNj?=
 =?utf-8?B?eWNJVHlBL3dZVGl0NCtmaDR5eDBEbXh4cVZYSUtsWlRZSXVqZWFZbHc5REVz?=
 =?utf-8?B?dERNczdUUC9WMFBUSmxqTGtGVmRjRXdmYVFCNU9seWR4dG1RV0pHb3QvYUpt?=
 =?utf-8?B?cTFQTDU2aVpobU5CeG9RM2JuYmU1K2dROFdzUDhmK1R5S0IwTE01ODZCaS9o?=
 =?utf-8?B?b0ZzeUxYckloSEFBS2F4cStRN0s0N1ZNcEllVkdubmt4N1pzRkttTVEzMGJh?=
 =?utf-8?B?UDdsdE5EMFdaa3h4SkM4WFpaVmw5cUhPSWhIbjdndjMrTXpNZ1ZySzhmNUNZ?=
 =?utf-8?B?bWV6NmJiTlByc3JJWjNqNnFqcmRER2tiOWVzb1Y2Zm80QmZXMEpobGlYR3l1?=
 =?utf-8?B?S1dWN1ZTUldhMjhXK0NvS0NFWDA1L3dia21oaXBBWGpQK0tKTTdycWFRMkZ0?=
 =?utf-8?B?NXpBK3VTVmJ6Y1dTVGl6eG8rNHZxUS9EN3NkV3RmRXJOQnFHZVFDaFQzaFIz?=
 =?utf-8?B?TUJKUGtYbW9vaEtsYW1lam92R294NUw2RHRkVGxRelVZOTdVZU1DNklPQUV0?=
 =?utf-8?B?TnJLcmpYMFN3TGlFemV4Y1pFQ0dOTy9KVHZVRHp6dEg4dVBOeU9aZHdOMUY4?=
 =?utf-8?Q?cU9TplKTcrU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF814058951.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJRbnEzWGpVSlZReHZlRUY3N0s3bCtsVTB2cWlZQ2d5eDRzL09MVlcyNmlD?=
 =?utf-8?B?RStwaWxZVDQzS0FtQzErR1JFZU4zUFRMcUpheTc0eWlFVHhibmM1UEtNUCtF?=
 =?utf-8?B?VjhJYVVJYnFMN0VKSVZkb1NXYStyVGxOVHNNaGF5a2kzdmRnRWNPOHZ0WjZj?=
 =?utf-8?B?L3o1b0VrZFViQ2FrOXpCdkpQREF1eVZlY1BVKzRRTWcxYkZKWDFFUVYvL3Jr?=
 =?utf-8?B?RWw4SGlzcm1McE55Ukk3UXpDMlo0c3VrOWdxc1ZGV3VmSXlHdEphZXNiVXp5?=
 =?utf-8?B?VXdQeCt2V0cwMlJFV0tUU3kyUjdNVm8xTFQyR3JLUzVTanIyUzkwSUNPUUcr?=
 =?utf-8?B?VkI4KzZZZXdRQ1dxR3owc2FyREU0eThyWjRYMlZFKzAxYVpHeS9QUWJZTEdK?=
 =?utf-8?B?cjUwcGxBSE1EaVpmWHdFQU42WXc5WkJUOU42dS94OTcxYU1KVkxQdW1CM2h0?=
 =?utf-8?B?SnE0KytmbzFUbWc1ZVNnVElVcVE0QVpFMUdYZUJXS0pkVmdUSnJWWVV1a24w?=
 =?utf-8?B?VkpubkFDV3lFeVNOYTh0cXE5aFIrQ2ZUNUs2NExteEFFc3U0c2VmR09BN00w?=
 =?utf-8?B?OU52V2h6ZVhUUk0rVTlSWTVSQjlSVWpaa29IaDF1NjhCUnYvNERLSkIxeUFV?=
 =?utf-8?B?RWtRSXU4Y1FuR3VFTitWV3JNN1BWb0d1czJKRjB2cVJOSmFUL0lXNk1ZNGpX?=
 =?utf-8?B?ajNTSnZsQ2IwZFhvN1pFTnhkeitqNkF6dWZQT0dObEJVL1F3YnltRUdwaGZs?=
 =?utf-8?B?YzFjVEFsdTVEcXBGbHVDTDREVG5uRkpzcThLY1JXZEppZU9kUFRLNStud083?=
 =?utf-8?B?Y1dvV04wWFU0ZWFFNmdFUUpreGxhZzc3YlJjdjh6cDFHcWhOdGRoa1hyVndu?=
 =?utf-8?B?ajJyenJiZlNwb2pJTjZOZURKMDkvNWdYMXVxaEdoWkFHYmZPQkNabmZnUnNm?=
 =?utf-8?B?enBndWhCbG5YSk9HeU9kSVFQWDVyYW9nTTlrUjUzaUl5cXB1RDBCY1lyM0t4?=
 =?utf-8?B?Wm8xUk9RdkgyY1BXLzdGbW9CNy82UlRPV1MrTkcxZWt4aGI5TTAzUmhodEt4?=
 =?utf-8?B?cU1idExCWlVqc0VZV1VTcStIVjBwTEtaV045SzJ2UXNyUENEY0lMMkc1Ti9B?=
 =?utf-8?B?cDNRRENTMmRVdWo4RXJFeldPYm9pY0tzRGNOTXBjRElkMk55SHB1MG9zTkhF?=
 =?utf-8?B?eGxidEpLZTRrWUJuMlY0eHFER0tWMTFvNVVCVEZZRVB0K2Rxc3Uxd1hrc3VE?=
 =?utf-8?B?TTdqTGU1YmpwdjJoMy9BaGZoVysxeWVjcVRwSitZS0E1blhldFFzTXpQZVlO?=
 =?utf-8?B?UXI2czlHTFFtd1VUNTlaSmFmeEk0RkJXN3FNUDZjeC8zdUF1WjN4QTIwdXBC?=
 =?utf-8?B?d1A4NWVwT2IrdUY4SWdNR1VWQm9TVTV1MHl1Yzh2RU9ocTdoL0N2WnBqZkly?=
 =?utf-8?B?WUo5NjkzVEpKcFJMejRabEh0K3VOa2lZT2RndXM2MnhOeHp4dnZXYTFGUUpK?=
 =?utf-8?B?d1JLVEtBdWVycE9LeEdkdE5mV0o0RVFEZVpzRVJUQWNPVkszTHgvbktnYlc0?=
 =?utf-8?B?eDIvTytab2F2S25odHBPY2ZESnBNZzhseHgxR25qOWl5TkVLejArMnlQYUlV?=
 =?utf-8?B?Q0prd0RIZlBsK3gvc1NWY1liR1FSZkE3Qkd4OGNsSGNGcExzaTU0SG5XZURp?=
 =?utf-8?B?UE9RNlBzS01OQkRKa0pKK1dXeFpveDNWTW5obDRqS2dZQk5iL2hWQTV3ZTJB?=
 =?utf-8?B?aEsvZ1huWXhIdlVQd2dlaGR1Ty9QNkM4Z25qd1BiSHRQN1BYUlYvUDZ0OHEv?=
 =?utf-8?B?SUd1Ti9yNHNlVGtKcU5vUWN3MkI5blIyN2VwSkROZ0EyYWFXMXhIdUhuY3Bj?=
 =?utf-8?B?bXVjU0tZMDhOS3RCeGlSM2padlZoa2NlNmRuejFLQjZxcm12VTNnejVuTTQw?=
 =?utf-8?B?WjdlTFpzQnBXTkVKZDNEempTNmQweFNvT1FJa2tSOTdUTlN4RlVDOFVTSzJP?=
 =?utf-8?B?NUgvQkpQRkp3RDRVMnExU2hRM1VGSnhlQXA3d1BEcC9VYTVoanpwZXMvVXhZ?=
 =?utf-8?B?ck5mY3lOS2NZOEZWZExkWXJtcnpvU2NkUTRCelA2SWczTmNkMm43VDVmMk1B?=
 =?utf-8?B?SGMwV0hKbkN6bGZ1Q0FWT1k5UWFRQzM0cnlDbDA1bmVHRHdOS0FiUmxVVmFQ?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a743b462-0814-4503-ed85-08ddf03b9fba
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF814058951.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 07:28:23.3047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE3GBZkbemvR72ak+3VaEa4672g3j7afi0FCZaMOFmQKvgVJGXmLlnhz1//lWeOzWuk5O3+h3v7JAqtpHeQUjYH64bXMUrqaMIWF8BDm/Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-OriginatorOrg: intel.com

On 9/8/2025 9:26 AM, Kurt Kanzenbach wrote:
> On Sat Sep 06 2025, Kohei Enju wrote:
>> Currently igc_probe() doesn't unregister netdev when igc_led_setup()
>> fails, causing BUG_ON() in free_netdev() and then kernel panics. [1]
>>
>> This behavior can be tested using fault-injection framework. I used the
>> failslab feature to test the issue. [2]
>>
>> Call unregister_netdev() when igc_led_setup() fails to avoid the kernel
>> panic.
>>
>> [1]
>>   kernel BUG at net/core/dev.c:12047!
>>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>   CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>   RIP: 0010:free_netdev+0x278/0x2b0
>>   [...]
>>   Call Trace:
>>    <TASK>
>>    igc_probe+0x370/0x910
>>    local_pci_probe+0x3a/0x80
>>    pci_device_probe+0xd1/0x200
>>   [...]
>>
>> [2]
>>   #!/bin/bash -ex
>>
>>   FAILSLAB_PATH=/sys/kernel/debug/failslab/
>>   DEVICE=0000:00:05.0
>>   START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
>>           | awk '{printf("0x%s", $1)}')
>>   END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))
>>
>>   echo $START_ADDR > $FAILSLAB_PATH/require-start
>>   echo $END_ADDR > $FAILSLAB_PATH/require-end
>>   echo 1 > $FAILSLAB_PATH/times
>>   echo 100 > $FAILSLAB_PATH/probability
>>   echo N > $FAILSLAB_PATH/ignore-gfp-wait
>>
>>   echo $DEVICE > /sys/bus/pci/drivers/igc/bind
>>
>> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
>> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> 
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

Thank you for the patch and for identifying this issue!

I was wondering whether we could avoid failing the probe in cases where 
igc_led_setup fails. It seems to me that a failure in the LED class 
functionality shouldn't prevent the device's core functionality from 
working properly.

 From what I understand, errors in this function are not due to hardware 
malfunctions. Therefore, I suggest we remove the error propagation.

Alternatively, if feasible, we could consider reordering the function 
calls so that the LED class setup occurs before the netdev registration.

