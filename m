Return-Path: <netdev+bounces-231906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5704DBFE736
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA23A6681
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0427F4CA;
	Wed, 22 Oct 2025 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKIlcPPw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FB211290;
	Wed, 22 Oct 2025 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173394; cv=fail; b=KYlIrN0uiJgJEIbJd09yz5xKovOTpjFAl0KXSKnpkq83SPONXApPjxZVYzpeg4cfh7XKiqh4YEx7OMl2x+zA6qlCAAobPvs5Hs19W8TA7I+2u2eXiT4TP4CzLu/DL3BzV3nx2wkezvBcauNBQwlU5lApsrCf7QK+jA7Ayap5AQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173394; c=relaxed/simple;
	bh=f5M4vDOr1DKzboEO8FrvyWvW8y7qyK2XgBOW7Zs3X7g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnHDZp0dkd+1IBKy/n2N0n26bxZTKVEkAEiTCBQ192cnuya7bV72898Fe3/0rUo/tq91cxDIc5GljWKLmP4dH/qrEIxatSgXR/C9J++wsetCPbbHnPYnZFLRmzfJGK5JrcqVGY7oDjjE9zuNJrk3Jkv9gXiJwLTu7U0U+IfbrIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKIlcPPw; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761173393; x=1792709393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5M4vDOr1DKzboEO8FrvyWvW8y7qyK2XgBOW7Zs3X7g=;
  b=nKIlcPPwT5m5QG42X7mUr+7+pnKKwTCObILeb2ta90G0E5v6UbLh+wDl
   OshCQP0bA7IFgosYT2u3HBLkZ4TExzmwJQ2pI5K+hM1q1HYdX7HnamNHE
   CDcuhsJn98wADP8Xz81KKC7R5JO/VeWgcZTd4mdzC9UlW37SQzwr8ermS
   kGLOETBPg2sMo2Gzacd0zzUIJFtIErvDpfig6ugH6h2k9AxMY6LOLSIya
   c4RXSZmSDv5pmJ9sD8cyL2cfT9rfp4ig1aWOhsCS/lHbmggibNXGSIW9m
   rG8/xA+wfiRDLvjcYWH1gQG6GLDxedBYopkKaVpJjlChMbp/QNxgwGMRS
   g==;
X-CSE-ConnectionGUID: 6QoUMHWqS8+Z0j7a/lLmiw==
X-CSE-MsgGUID: e/9ieQIAR22jSYf75Kxs5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63480890"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63480890"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 15:49:53 -0700
X-CSE-ConnectionGUID: qwaaCTIcT++yJ+U74hd6kw==
X-CSE-MsgGUID: I7sIum+QQS6zx7vCZovYUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="214648956"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 15:49:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 15:49:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 15:49:52 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 15:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWTTNHja9EvKtnf07fxH2O2fQ9jeh5IOlsBGdLLNcehptvQH8D8xCI91WKNkRDIejQuT49/PIh8rPUg+XzjXTLSerujmmTC5ga1S2Ej7TslvwxHHoi29K4UFrDlRg3t8v5I1x6qILsdq1ei7Y02mOi3Q55weifZ2GNQmtW9eICsObC2Vh/GmpMmPnVk2QT0SwK0nu61XhGw1KTfbWgb8fp1Cich+Cq1wR/jn3SXinVKmLFFFYIrhyUVc3s0kMLV0enuHYBTEoEXtPaEHiKlIeBtK3xn62dRuv9QRrerBHzZikq+a5Bfi/943FFQg5bV4UwOiCNIFonpOlpKxyR18fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2+WQD3Ajh/XfE4cs8nF+HCEMgsM7YSuv4NowO9MZK0=;
 b=Pn7I3i2c+KuJ//U20BTRzm9pI/4HnCvmtSZx6XY0Jwp2/SGnZElE3hVoDPmw2iczJmxlAxSohnfbh2HBSmKBxqRCA7/c5cagUON5zI1SuIbSLGzWR0sQBQjpTtjmNWsR6PZSVVB1yz2VYt89pRDJzNDrd08yUI6nX46r/jQFri64zrT9Pb8lsmI8Mt3fJXR/iKzkh8kNicNHagxXqwQAM35jj4XecunNvmEfHRLygeCCwCuZnOSmWu4KxWitx4O3aR1+Q/xL3x7P+PaU/Ng4poYIpt7k5aRRfrz9WLkvqTeItv2s9GIWboLAPZz1LhwQn9cMw3FHoF7arZ2sZjSHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12)
 by DM4PR11MB6166.namprd11.prod.outlook.com (2603:10b6:8:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 22:49:50 +0000
Received: from MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::e117:2595:337:e067]) by MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::e117:2595:337:e067%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 22:49:49 +0000
Message-ID: <d7c4aa1f-f880-4b9d-96d8-fa54ac6557dd@intel.com>
Date: Wed, 22 Oct 2025 15:49:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] idpf: fix possible race in idpf_vport_stop()
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Pavan Kumar
 Linga" <pavan.kumar.linga@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Phani Burra
	<phani.r.burra@intel.com>, Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Konstantin Ilichev <konstantin.ilichev@intel.com>, Milena Olech
	<milena.olech@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Joshua Hay <joshua.a.hay@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Chittim Madhu
	<madhu.chittim@intel.com>, Samuel Salin <Samuel.salin@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
References: <20251001-jk-iwl-net-2025-10-01-v1-0-49fa99e86600@intel.com>
 <20251001-jk-iwl-net-2025-10-01-v1-3-49fa99e86600@intel.com>
 <20251003104332.40581946@kernel.org>
 <4a128348-48f9-40d7-b5bf-c3f1af27679c@intel.com>
 <20251006102659.595825fe@kernel.org>
 <048833d9-01f5-438d-a3fa-354a008ebbd3@intel.com>
 <ae493f48-ae07-4091-98dd-db254f2ee12f@intel.com>
 <20251013111352.5ff15ec3@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20251013111352.5ff15ec3@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::32) To MW3PR11MB4538.namprd11.prod.outlook.com
 (2603:10b6:303:57::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4538:EE_|DM4PR11MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cbbbc1-3abd-4dd9-e186-08de11bd4e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1ZlUVhpWEFMN2NEV21CL3U3bWxFWUprdWh6NlA2Z1YrVlpMTDV0aWJiNGdS?=
 =?utf-8?B?ZTA2R0d4VjI0akpnM01JQStDRW9rMjFneDRVSEV4L1ZrZ1FpbnBxQWswbmlU?=
 =?utf-8?B?Q0NuSEREQ0s1L0c2aXIwWkFYRlk1NUZaWVBSOVpZMGpqSFdWR0VlSExmY01p?=
 =?utf-8?B?c0svU0JoT2JDaEloMTlvdFZ2bUdWTHZ2S3E1MldjWkNBM3ZrcEh0N25vRzJ5?=
 =?utf-8?B?RlFWb21lN28vZWhsQlFzZ3hzYXQyd25wMkpqb1ljelpyNUh2Ty9LQmRPUHdT?=
 =?utf-8?B?aWpmMjRRaDFacEpwRGVpZjRmUXdQSmlxZzB2NExxVThnVWk3eGpybXJoK3Bz?=
 =?utf-8?B?aVhwNEEvcWRIaWNEWU9pKzlvcnc1NEVncW9pNW5VOVd3Nk01YzJDSkhDUWQz?=
 =?utf-8?B?YTdSbkZwQUpYSDRETXY5bnhqWEZBbEZqQm9Na3lLa3BWc21Ld0VYWXpBYXRL?=
 =?utf-8?B?MUhDelNBZTdJdzZsLzB1VUNFMCswRVF4MmliSTlqUmRGVm5reStZTDNkRDcy?=
 =?utf-8?B?WmUza1YrME41YTJPTWVGYzVmdDNWUFl2VXc1WGRxVWoybW5jd2I1UzJDaDNF?=
 =?utf-8?B?cCtxZ1VFYThhbmhkbHFsd1hkSFRxTnZTTUpka2lpcVo5MGFXYWpMUmpZQ2cr?=
 =?utf-8?B?L1NBekVRZmlXZEQ0N2FRQWsvcWQxejNIcWVsT053cXB4QzZaK3V1RFVmVWpm?=
 =?utf-8?B?bXpCdTRVdENEeUFvYjBRQWxTWU1jWHZXZHBucmtCZEU5MGQ2aFRGZ2NqZTJ6?=
 =?utf-8?B?YXR5WCtnTWtoS3BBVGZENkdQYkkvMlU1L0o1M1ZlWTZNN2pFYnJqSWNTSEZO?=
 =?utf-8?B?MmRGYkk3OHlHMXNTTmg2OTdqcFFUbUNXMkxKcjgwUGJkMldCcS9pMHRvcGxZ?=
 =?utf-8?B?NzZwaDZjQk1LTHkyVFkveHliVHVCUDNPQjZMVEMwT0lPVWVicFAvcGJycnp5?=
 =?utf-8?B?VkxkMURDUFI2K2s0b2x6M0ZXM3Z4ckNBT1JVdGN0UFZCdmxQWStwbFIwQ01P?=
 =?utf-8?B?WXJuYXIwVy92YUJXVzZtZ2JoOHNsZFNtVnc1UWR3ZFpYajlMV0huSVN2OVc2?=
 =?utf-8?B?SjdacHdPTmRsek9sVzBENUF3eFdTVXhzTVgwVHlsOFNnVGdMcEtLUHBMdWNh?=
 =?utf-8?B?cElMQUlLdmhjSkZ5dmpiQTR3cmtPWExXNjViYnJqbkhsQXJOQVlmTTZiblc5?=
 =?utf-8?B?aDNUSnl6SFVaNStKeXl0UjJZUEpFTkh0cjFpMEFRRXBEcHMveUJ2ZDVXdWRH?=
 =?utf-8?B?MEkrZzgrUmswazVyOWJ2enlkb1gyNlZ0UkREc09YUGdpV0g5SGpUNWVncE8x?=
 =?utf-8?B?eThXUmtscENKUldvaU03dXRnVU5FcDdkdVRiVlRabG9yOEhoSnV6R1hsTm9L?=
 =?utf-8?B?ZWNVQmtJVU9SRG5hY0kzRncyckhnTWF1MXF5Qkh4WmlnemVSWmdsbXBNbklF?=
 =?utf-8?B?eE9scUdvMCtLaHhXR3NCTGVYV0pFUVJSM1VFUjdMejExZnhyeDBhY203WCtN?=
 =?utf-8?B?Q01KTXF3NFVLdzJxMkJtTjRyYUVxdzcwRUJRZVBFUWdBREk3N3ErY1haWjdt?=
 =?utf-8?B?cXJSWkF2SzQ1bHhWazVlV0RjeUtnUEdIdTdrOHFrOVVjNGlub3Y4ekMrTTU3?=
 =?utf-8?B?emg1YzNJaG5CbHJJbDQrelhNVmhoQmZyQ0lQSXVFRkZxcEVwaUdjb2E0Y0Uw?=
 =?utf-8?B?Vys0SmdjQWZlcHAvbGFFVG96UWRMTWszMkRVaExYTHBzeXdNU3IxUVE3dEZ1?=
 =?utf-8?B?cFdZWEtIbHpIK0pvSDY1S29hcTNheVd1Z0pSYjdsVmZ6SUdZa21JVk83dldh?=
 =?utf-8?B?N2lVYnRtc0xhclhaTnp4TjV6dVlINTJ3a0ZQeEFtL3I1TjlObEozVDJTOHBs?=
 =?utf-8?B?MUJyYUw2bUtCRVREOVd1SHd6NCtuN3pDa0V1STRQVUtjZTV2YTJzSEI0VmVB?=
 =?utf-8?B?MVdXaW5NMGZmc0kreHpIMVpCZkQ1cTZWaHhFb1JQRU01NGFwNXFFUTlSdEh4?=
 =?utf-8?B?K1NhVUhTL3dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4538.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRpNEp1SXV3eWxsZ2Yxc2RHR05VS1dPTWR3dEZNYktIRERoRTU1T1BQQk94?=
 =?utf-8?B?WDgydktncDVSRjlWdkdFVWcwUDAvS3dBQXAzak42eDZnMWU0U29scjRqWi9C?=
 =?utf-8?B?c1RCWUROenVlUVhvRHJWWExFUUtwcnBxNjd6NklJU2RBODhWaDVZNXJJalVY?=
 =?utf-8?B?ckd0ZExreUR3eXNiMktpbDFieUZqQTZoUHRUVkRpa3dTR093SFhXNlB4RDBP?=
 =?utf-8?B?NkFLTHdhOVBxRUorUnhRVHVpUjY2UlYvUWJuZVI4ajFsRWxneW0wS3ZpeCt5?=
 =?utf-8?B?d2lwQmF6REVxVmhuZEZuWlJwVERBaUdiSTZSYjNQYkQzOENDdzd5S3A5UFY4?=
 =?utf-8?B?RCtmTkNhS1poMW1MUUJiNmEzdmhqNTdPTWR0cmU0UCt4THFNQVFQWWJYQVBj?=
 =?utf-8?B?ZXJPQlFXYXNhQW9OdmFpNWJrZmRjRk9CK1Y3RHVmK2tpY0xCTTBjeldmdFdq?=
 =?utf-8?B?UExTdUxDaU0wWDhZUWtmOWx0dnpOcXhqNS9aY1B1RmhtTmVEdDlyWEFvMzhT?=
 =?utf-8?B?eFBSWEZJRVQ5bjdXUU4xY0dyeGU1NTkvck51UHhNZXlldmNjN3FPRS90ZVNF?=
 =?utf-8?B?aDFDcHRQeTZyYWdUYnhyeWJ0MkltbFJjeEhvTjdFWVZoTG9aUUtJeXhSZG1F?=
 =?utf-8?B?aDVFMVJhYjJkQS95NnFrV1RXdUJHQmJoRG8rUTJ1VElmby9pajVpWWQwbXJC?=
 =?utf-8?B?TWVNUllJckcrVmVOamNMZ3M0MkVCcHVDbFQ5Rk1BMDVNMWk3NW1lSzJkNjNl?=
 =?utf-8?B?bG1QQzl5NytzV3RPUmphRTR6Qkc2bzRzeGxhMUpUYldrU2xOVVdhVlZLMXdm?=
 =?utf-8?B?QUN3MUxIbnNJaTRML0p0dmJpY0puT29lcjR6YUFvUWVadnFnYWVoV1BwZEl5?=
 =?utf-8?B?c1NUTW5XVHk5WkJjRUZmZmZwZWZjSkdNTEk0TS95TFpmS3NNSDhZeFlIZmlI?=
 =?utf-8?B?aDZKMXI0aW54enlJUS9hRy9hSUJiU280ci9oRzg3cWxIZDBXQ3J2VlhoRnV5?=
 =?utf-8?B?NTJhOWtTUTBWcW1TdDNaemFMcU84ZzdWNnFwM0RPejhUc2VBUHpkNnZRNDZF?=
 =?utf-8?B?OXl5cjlFYStLeElFcnJJTlJDaGhDa1ZCM0MyLzFVb0h4THdSNmp1VEg0TjZz?=
 =?utf-8?B?Z1ZmcGdVTi9YVVJQK0ErcDdhRFkxRnl3Y3cwZjVmNXpKa0wxSC8yTlJZcFBv?=
 =?utf-8?B?SEJjeGFHWnJobmJCa0NiMTgzTTJwYUFhNjZLbmpDZ0NTR3VGOEhPY3FMQUpX?=
 =?utf-8?B?L0RSdkRMRGJiVzMyZFRhVWRScTlOdjhMZThKNGhzNzZSNkg3U3BPYnNlUzZy?=
 =?utf-8?B?cm5LbC9EQStGY25IZTRzdEFJVXE1Ti9WR0lKa1VuSE9PbHVaQjJibHBzTTdk?=
 =?utf-8?B?RmxhYTVNR2ZxbFVsa3IxTUljMEdEODIxUWQ0eEdBcUEwTEZYMUFhZEp4cDNG?=
 =?utf-8?B?bmk5SGxTT2d5WWRJeHIrSHhyYVYwZkY2ZlF3VjlvaUgzMXo1Zm12VGl3bWlx?=
 =?utf-8?B?eXRCS0ZFdmEyTlJ3TEdCQTF6Zk05cExSTFc1Y0w5aWg1dFd0ZWp3RnRPVGFq?=
 =?utf-8?B?cU8vUUkyWUNvelBpVlB5NGlPbVlOV1NHdFRYcm5mMFppZllCdXdjanlUV1RW?=
 =?utf-8?B?NnJiNm9MTGRqVDlhcTlucUFER0s3THg0Vk1xdTlsUW9NVW8vUyswZlVsSDRk?=
 =?utf-8?B?RzEvZ3dkei9YUU1DbEJvaU5VdVRIbXV1ZWhDbHcvQkZGdVBxa1RmUUh6eUlM?=
 =?utf-8?B?VDFvNWphRGp4dEQ1Qk1NUEJVZFZjaDYvekpzL216cWh0UUg2eThFT3hIeEdB?=
 =?utf-8?B?bVpJNnZkSGEwTzBYdFY1ZzRCWEJOTVlCeVpIcW9zNFBHK3lxNlJ3MDVuU0ky?=
 =?utf-8?B?RlZGME83UkJ5Vi9hYTVNanNjNzE0RUZyVTVvMURBVEl2clM0d3dCci94cll3?=
 =?utf-8?B?ME43WmxpalFvNnJOYjBGbDhoMG5BQlB6YzVuUFJkc2NrOVhjN3I4UUpnTEtF?=
 =?utf-8?B?QlFVdDRQMUNkRU11RVhzSlV4cHBaL0N1dHdnNGVmUTUrbGV6V0d2eXVKSXJR?=
 =?utf-8?B?Rnh6ODZ0Q1JhTkxBZ0FsUG5TdnpqOTBKcHE0QkExa1ZJT2NIZTkwcTRVOU9H?=
 =?utf-8?B?MkVrVm9CU2JYSGR3aG5xRTgxSXlyMWhMVG13K3B1YjBKOHQ2S2djTkg2YnZP?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cbbbc1-3abd-4dd9-e186-08de11bd4e84
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4538.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 22:49:49.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdrED3ctD93KPjndFM9Fhd+dcuNtMlthB30KuyXA1Cyh0MlSR7IMNCY1HeRui1VOmoWYXjnNR9Kpru4fbsnkcJO6gvsMTM5Oh58iaiRX40s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6166
X-OriginatorOrg: intel.com

On 10/13/2025 11:13 AM, Jakub Kicinski wrote:
> On Wed, 8 Oct 2025 14:41:40 -0700 Jacob Keller wrote:
>> Jakub, from this thread it still seems like you won't accept this patch
>> as-is?
> 
> I haven't analyzed Emil's response. I hope my concern is clear enough
> (at least to you). If the code is provably safe I think the patch itself
> can go in, we just need a much better commit msg.

Actually we can drop this patch as the issue it is fixing is no longer 
reproducible, following the introduction of the RTNL parameter to 
idpf_vport_stop() by Olek:
https://lore.kernel.org/netdev/20250908195748.1707057-5-anthony.l.nguyen@intel.com/

I would still like to keep the first patch in this series:
https://lore.kernel.org/netdev/20250822035248.22969-2-emil.s.tantilov@intel.com/

I will rebase it and resend for -next unless there are objections.

Thanks,
Emil



