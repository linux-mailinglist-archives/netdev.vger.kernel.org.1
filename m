Return-Path: <netdev+bounces-273451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPUAE4NDy2l+FAYAu9opvQ
	(envelope-from <netdev+bounces-273451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:46:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAD2363BCE
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B9DA300C32A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 03:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0BC19CD1D;
	Tue, 31 Mar 2026 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJq45ose"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10824279798;
	Tue, 31 Mar 2026 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928769; cv=fail; b=tRa/770DYfSkYATyxG7nyEWIvdRv4wM5gyuulKRFzbkero2k/D1JzFwc5/XJ0tPUXd3pCavqHrE3UEFv2/wyU0fCErWSFTYCdAcfqurHd3ZUHI37wY0Po+IjW7qvYHMlpYtpY79NC3KsmTBVoDzwuL9OcyreV+t03pblgFd/fio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928769; c=relaxed/simple;
	bh=Uh1I0lKIhF8Tx6KrfBlqX3Fq1PHrtZsn1AD1qfb4guM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=hTqFEsrsHXDHPhzK3/J1hFS98bROGw2XmspgOJAg+TkxZZtiFtQAPVTxcLc1bd9ne0VZEO/SWeW7ZX98yvoR0kpJBX7PbBD9u3X/vT79eOnY/ZptlMnzAOVV30G097gZiX4KlFCfX+ri+GoFhWRtZXzpgwYvAGgIhXfKeXkgJiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJq45ose; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774928768; x=1806464768;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Uh1I0lKIhF8Tx6KrfBlqX3Fq1PHrtZsn1AD1qfb4guM=;
  b=FJq45osep8u20yG3K4A1Aecpu1M048LMrYg1JhTSHMDiiM0yVGBcTxZn
   +/5a8NjrlNqlRJbnl/JVbp+S7rlf7PtTvIgqhAglKYN2yTXzAF9rDvvl1
   fa24QQZwEsrS+xziZMb9Wq3rqD45Wl+HzHBwxFlgDefzmXHeKwOKZRMIr
   FxJ9tLesOUoIoU03PXnfg36kN3O05tW0PzigY38l6VkdNec8ImVYyxHag
   6rlkJkteLT5oHuycHXUQBlXlPeWuoN0gH+WuPeDnCW0+LG2ZI+u9YDJMX
   MC02ucdjmvgYWMFKBAqX7VbYmy3VQljXCUmkNDsTxABuNay9f10XzBARR
   g==;
X-CSE-ConnectionGUID: ZU5Euq02R+WFnOvAabJTDw==
X-CSE-MsgGUID: iqLf17eQQaKY9dss3AGrdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75816310"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75816310"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:46:07 -0700
X-CSE-ConnectionGUID: KO/YPwcUQvu7+IYdy/RXKA==
X-CSE-MsgGUID: 3VGIBVJpRaqT3UtZbH4t1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="225407593"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:46:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 20:46:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 20:46:06 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 20:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3CsFFHHMsFURj/RMJ5Hu1kwmF0fVgEw3kqf+wHXGINuuFBLQOsOp4yAiJ1YjlggMEE5r4ejmsxjqon37pA6E/tKxitiKFHXExDQaZnppxLl2xdfHkrQbwAlUuTeGrdW28I8fAnDi3MUvOAA9RkUU6rimO+YyLAlJ8IczKxOJaI2laK9cfk7sDZ/vcMBAZ9JoYx9ntNqi6POL1+4oAoYS+0ZQ/e/dfxcDoxtEsxvSnVjUQ1XmDim1zZwSJgBoaDhB/fcMKbghoQn5HahuT1j6hhujOE6qPOUvBhTdCpjLa9QXRD11R9EXHQ4b92SS8ojP5SRQbD2Ik2RUFGBGewvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtbwZN+iOXFzpvE6zRn+buSM8mfqDVx8pOwu4kz2V7M=;
 b=TRKMVsbvaQXr/12qRyztikb51mt4BXUPD7PNysA4OvWdGSt5tKtHNDS4E8sEvNJ8ajTOnXGWTWj9pZVheY34Llt4DLTY/36QrVOx4hTusFN7n7meTGz4L2O9UVoJKbC32qUB1nsSLo6p4+OLRr/kUoc94cW8LL+F7w9ye9QhH1VDHo48mzAn+/rKZCvzJCYUAsSkuDtMiqZOnlXTaWslIYrWjiYy75VFKN5EGRbzJTEHYWd6zMbDH/24B3Y46efZpRIzFuDsjdcfeHU+SBwtLgkI9OfrNMRxXQLFx247l59G/rZPh2Kjkd8NcxiMEsq0tGBN2AvSR6HNWnOtdsp8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:46:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 03:46:04 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Mar 2026 20:46:01 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>
Message-ID: <69cb4379e2b73_1b0cc610085@dwillia2-mobl4.notmuch>
In-Reply-To: <20260330143827.1278677-5-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-5-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v25 04/11] cxl: Prepare memdev creation for type2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6500585c-b98c-46b9-63a4-08de8ed80883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gHtCI9KIP8DFfUbFaV22oVjronLTvkaraEwk0xj83d6D4YtE5qNUDKYQFTcqiagxSxZh3Eaup3WQNb+BQZZCOhkKrHyyUnQ0bBH22HocXwbwkAsb9qBLoOB0JwME2jMUcUT45Mt9Wur7IsFLJ7BDMByPgGGLBWOvAq0tlvdWyRbsKs8f7DkpZW958FiAyArutBmiERX61YEkouCK5+rTvHasArICr9Sg3B+EplaZtNinJ2RKE2xj3Mf5SniDLgvXzT9UanKG9GLNpHuPePt/1MlUU8TNAExngPgZRfrC5wfbOf3olfR2na4kZMIBOIXr51qGoArwE/C3QJdhhltXtznD1KesxMmpcLsv+UuaDY5++72vHEomzw8jcMYKS7IK1WIgZSAh+N2glNz9D3porq84GaXEd/cdnTmr2wotxKuGp3HcPiIS0Tnpl+eHab55G4JWqGgpcgwhbMWP31PKYh9kvoREgLVyRWY0VN5rsOLdNgOtZ3/d8FjhaWTzOS3vloTnhupck22vegeM/2LiDF6G/Gh0E1w50P+Yh+ZDs8iQqO0PpiD8A+/4iY4KEDhy0fL5KStHQMH8stq/6BoD3GZ4M9+UIBo6ZdCp/UqPYL0oHsH4MzeAU/aU+iZSYrVqddQ3bY0udH3l1rQ8a0oHomGbeLKBSTdHDXcW9kyRmBdq9SlufUKqkYNznqOA/z4HSHV78jx/J0qs0Ue1XDcVOiUD817AnAk0Dz4P7WMkK44FLq7NGA5XXbyFWJ73AchWASsYxaX/ztgT2k17XH2CUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStLcTBxemZLb202cGtEdzBaU1hhT0hUdWY0SlAvbkEzQm4zS2RmU24xU3Rm?=
 =?utf-8?B?ZC9ENndNMXpQK1lhZkRUdFBleWUyMVlLT0Vrc0NtWmtzV3FXTHV2UU92eHJZ?=
 =?utf-8?B?c2NobERmZ0t5V2ZwdjFud3RVZXk5ZVJpS2p3N2JWWkRkNVBqRllmYVNRbC9H?=
 =?utf-8?B?QkdBVTRnM01KRkNMQWx5a1JNR1pjTi9nTGl1RzhJKzNRc0V1TStFUWhPK2JM?=
 =?utf-8?B?ejMybU5MTmFRQ2ZOZVdwdmdJVTdwOVJHYkFIeE1tTjVVd1k2RG9XcUd4ZWJP?=
 =?utf-8?B?dmJEekVJVFB5VTJKM2thM1BGZ1dYT0lYc2dUUkZMcXdLSWl5Tm82UDRUakpN?=
 =?utf-8?B?Q1p2K2QyeGZRbHdKMHZPdFc4UEYwVmFMeVloSnpZaHhFcHJKY09xeHp3d1I0?=
 =?utf-8?B?cWt6NmVRdjg2cTRCeWxMYWtFVU9oellQVGdVVkU5T3V5dUNFMnJVMFZrajNQ?=
 =?utf-8?B?UGZ5TmRiMU1henVOdCtGY2plL0pGWnFPSXp4YjRiVklSZ3dKMlNKWE4rZnBl?=
 =?utf-8?B?Q0Q0alFRK3gwWTFjNXoyNytiTUhhR3V4NG9saTgzRHZWa0NndEdRdXNwZXVi?=
 =?utf-8?B?blU2OFFUNjJFaldGRy9KdXdvb2RSK2xDcEd1MFRWdGQ4K0dKRDcvbjdodmZI?=
 =?utf-8?B?OFhTN0pDbEptU2d6SXN2MzVESUZTeGxoUkpaTUNmQk5KNDJmZUZOQ0JmWlBj?=
 =?utf-8?B?OTgvdW5jWVN0cXYrQyt0T3dxNVJmQWgxcHVHTFpvWnlYSG14UnE3YmxVZnRu?=
 =?utf-8?B?U3Q1UlJ3VWw1MlFwdDRXNmRrOXBieS9rQmxoeGVNSnRyM1dHMGlIWFo0bGw4?=
 =?utf-8?B?cVB6NStiV0VUeVhGb2pNblZuUzVUYlQ5clBoTmdmQ3NHbDZoVHNYZWNhNWlw?=
 =?utf-8?B?VlFHazVQZEZyWnVwWlQ2d1lZMWdQRzFDWXZuM1lVL21LTm5lTWJWc05RNHhT?=
 =?utf-8?B?Rm56QXpPUWpDOVVQQW0xRGhpVWFGQTg2Vy85Qmh4QXRyNWtOc2tqUHJ0dU5J?=
 =?utf-8?B?TWlJYkJ2eXVQUyt2YnorcjlpNm9lc3FRdDNtM0RKeUE4eHQvUnVEd3Jydm9t?=
 =?utf-8?B?R2grTmE1TVgyZFpMSkRTc0VFQUx4ek4wZTFyRitnbTBieUdxOWFNNnFNbDNG?=
 =?utf-8?B?Tjc5V3ZZN25HMmZvMU1mRGFKc1hkWTZJMEZESEZSK2h6NlpzN3JDV0h4TTVX?=
 =?utf-8?B?RFc1SnZVZnh5VCtEUm8zMzNTcnNXNkFWVTNJQUM5VmZ5b2xyUnltNG9Kd2FX?=
 =?utf-8?B?NC9UV25BZlJpb3R6VEE5Qll3WmMyL254KzdiVjNFbTJobXZ1NUFIZFJXNENI?=
 =?utf-8?B?NGxRYlJyYWkvVE5xUmRCdGQ4MXJrNnVVc3hWdXJjc1FZdUNwbWZVdkZxd0ZJ?=
 =?utf-8?B?d2VoRG5YWG9GaFZzWjNYdmF5bzNiVVdCaThsZjdtcFBsck84akV5bFZqOWtl?=
 =?utf-8?B?bUVmMFpMOVRhSEEwNDcyVDYzczVwN0o3Qkh4ekh1RFFOVkU0cXl0UG1IaE1n?=
 =?utf-8?B?NVRZU1U5REdQVERWS2dOUzNHY0pmYWVXdkl3QWxtL2JMcHlHcHFTMTc0ZXlO?=
 =?utf-8?B?cXVUbFVFYldvc003TStsSlJwUTdUSUdRWUlaMStvMGhVZmpyQU9Oa3daR0pn?=
 =?utf-8?B?c3lJZ0lMSlRJdmEwWVBtZG9aNWlmNE52QVZyWnNZdmNVK09hckVYZy9sVUxM?=
 =?utf-8?B?M0FHdGd0M0hITjB4eEk1VGlPQUpGM0hld1NYNkFRbDBSdCthMG1LZ1ROM2Q0?=
 =?utf-8?B?TWVZeCtXRmxhR3JXT3g4b0M5U0JnTFk5L3VvR01zN1BVNHlJYitIQnpiVmtJ?=
 =?utf-8?B?T0tpMEFlQ3NqQjB3S2lmOVhoM091T0F6eDd2RkpRY09meWxIaGJSU3QrZmdD?=
 =?utf-8?B?alQ4bHI5WUZoQjN6QlJINEJmVnlIM05CdWxRYWx0aEFUMi9jNVNyaWhnbFlF?=
 =?utf-8?B?TEE0ckR5NUZwNUVGaFFWMEZsc08zK2pndTBqQndUa3Y2Q1B1dU9vT2hBYU5Q?=
 =?utf-8?B?UVV3dWFQZnBPaFBUTU5VaTI0WGE4NWMyaWZZWVVQcVJ0S1lNcGlSTEsxVFFO?=
 =?utf-8?B?K2loYytFTDB1RGIwanZ5dnROaDA1Q0ZYSVlOcnI0STFKU2hLNlZmU3Z5Zk5U?=
 =?utf-8?B?MFdpWXhrL3ZqTjNNYjltbmtybytlTGFIbWVkNC9RSlQ0ZnIwRnpCY2I5YTJv?=
 =?utf-8?B?MFVBTXM0NTV1MUhyUkZGSzhVZFQ1aHJJUFpjN3RxVXdxVFlmOTBNcksrTHdv?=
 =?utf-8?B?dzV2ZzU3eDM1WGFrMzZJYnJkL1RaWWpUSzdvSi92a1BwQi94YTVwc0t6Tmxn?=
 =?utf-8?B?NXFzL1cxTmlRdXFWUUFDaEhvM2MwYSt4anZkYVUrK0hJTkJ0cDY1UHBPeTZI?=
 =?utf-8?Q?fCt3iuM17jUzIxms=3D?=
X-Exchange-RoutingPolicyChecked: gIbdmji5wMqzBPlsQhy4uKjRno66QA50Evb/ujQGsEIXBDjd7Y3BXKK+sx37iQ++8lvtMhWl/NCNMDpmyxFjX1VxgvuxrcwAKtgAOtTd5L4RV5NwO92onlbAUNvpXsfzVMItts7M2OLAPoOHdekgzegwb8rbZuN/Ec1SWU3XbXuMtVnIv28GnVOPgQPA80tPfXZbqQdBSQ0TUFLu8ISTBw/7hcjOzyZ0zUTRmKKPWUZDOUovyfiLjnC/yMTE6nb3Vp5W+ybBjLvMOaChXnth0px/678jhi0tA0CCENBwuSEjgP4uB0PF1+TabEGEY2PgOjV4/qNFruUD6QRutAxvHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6500585c-b98c-46b9-63a4-08de8ed80883
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:46:04.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJkSnP6X6pDg4+Kn4g+N62zxJu4tjwyedXmMmzgeVAPcHrPIaMaAlyNVLLQ/NbXfePVQJxo2gzETuz/JW2/KUHmDp5MXOeD5xd+88NhEDsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,amd.com:email,dwillia2-mobl4.notmuch:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: DCAD2363BCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accessible from an accel driver.
> 
[..]
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..ff858318091f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>  			 cxl_debugfs_poison_clear, "%llx\n");
>  
> +static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
> +				     struct cxl_memdev *cxlmd,
> +				     struct dentry *dentry)
> +{
> +	/*
> +	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
> +	 * cxl_memdev_state.
> +	 */

There is nothing stopping an accelerator from having a CXL mailbox, so
should probably circle back to either make this comment more generic, or
just delete it.

