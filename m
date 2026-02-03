Return-Path: <netdev+bounces-256039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB/eIPlBgWl6FAMAu9opvQ
	(envelope-from <netdev+bounces-256039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:31:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28FAD3021
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EFEC3019C85
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6CB1DE8B5;
	Tue,  3 Feb 2026 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckfJ2+Jc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341D8834
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078709; cv=fail; b=RQTbhExpdmVDPBy4l7SDuvAlT49l3NtsDJbroWeCQ6gR0aCiHayEk7Lxeq1/58Y1vdLXluuc3KNGRoIPLtYVJRiswDJPDOa6SbvOtBivDSRMcMr9Rh6YshF65dhyYSRIokfT7YyFU2bZA6RssO9qPmSSjL8O3gfFoAwXPj1EGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078709; c=relaxed/simple;
	bh=EME/W5c4rDFCtVgw+ewf+j103OTdgcebiXQVSxTW8QU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTow147+iWbQUiT3iYtTZ07AzKpDvyfEL95hBe9nLT+PKoRpJyQCKT7uvEADfoLhPOy1f343ADQ6YQUnzv0LrE8q833/xUSQWamzNj1fGYqL7lnfiVNmKRcQRGa+ZL0J3Q9DCEzqALyJ0WiwTOzryLP+4Op1DSqY4yoURcAH73E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckfJ2+Jc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770078707; x=1801614707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EME/W5c4rDFCtVgw+ewf+j103OTdgcebiXQVSxTW8QU=;
  b=ckfJ2+JcDBkDCD1zuP4NQHac+JIyqtI/jejhAOv/c+Ip9iUI/d6K/6p7
   jsyjzJq6XO8eGENY63rPOiPSs8enp15Wug2Yy47+sVgZLDodHOHg2b7m8
   FUU6jBVLCVWDhUyTJT8q2sZrDFnKjQyGzwf4CDL2oyajWFR8naC4uJcRX
   hfObpRWXL64gklQzDC0Wds9MNOBSMxjedbeJJaDA+01i/90TNMe8U7AmP
   bP0qna53c96uL9jX5oht6ecj3qcZUXs/Zj2aWWwTQpwc4W+JXffK8EoXu
   ZfnnUe8uiHaPp+wssuJMYFdmhsD2vMInOhwqJzYGkPbbpNPUtqh8aUQ1M
   A==;
X-CSE-ConnectionGUID: YHtfMji+RcKdyQR7aRawyw==
X-CSE-MsgGUID: tKTWlbEGSYCTgecg7Bauxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="81982770"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="81982770"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:31:46 -0800
X-CSE-ConnectionGUID: STNydcPzQw27KRvODv/CxA==
X-CSE-MsgGUID: mhIUwwMTRcm+d80rJ9nbhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="240729210"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:31:46 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:31:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 16:31:45 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:31:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYysW/zorm6/05JuF0GWmh6RSLmI30hnSHOvecNQYmqsFGV2KKS0ambgY6He3ao6z+1PDpMdUBaQrirqd5ZsqbGkrzaWmG4xQS116MudLn6moMb1/4TvrEWWdiZQR6KTQ9J1aUujSHY2WQRkf02scHDk54fNGkhRuH4OvSqObSRtHl6+7j9iyT/zT2qhQtJOKN3I1AMAOU9cSrARpR+JgDNitwFOV7cbO3Is2Cx/PHUgIG4fovcsQIJEJDx/1fYaWEba7k/NzLfrggwO9q/NzJLe3tI+CmEtkYzBtRzti9bBgr4b2WQJrmlBk7AJIwUdm8OJateuVw86fS6mPcDVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XYpGmPCVMCzQBcAl2cR0i7LSFKa6Ips5gZBhot+DdE=;
 b=TGIYTv7y/7ebsDwCUcggkJGPj42Kt1xDhWslTD9mh0P+xNuA5SLmqcsRJcQYxN1kLjDITKAan9xD7MQ/B0XYDLPay4Ef3lw0i6fAaXygSO0n60980fAZFRC/Jm7AF9DQAuuRLN0Kaw0thRYLwHDcKnKBUHaqFYg9kPaGVZ3f55uFgdQo8j0Xn70TDZPHH+ceIksIEQG/8S0yT2s3kdeuR/zltQwiHfu3xOk9qC2pUUs165A1aF1jyF/K1daUrcv/dEE6OM2D9334tJ7pQmCPOdzQ/hDkm6N/aGaqJvOuPEMAIZ21MtqUzLtQOsB12JxNdlTZtYHSZcvo+O+pxO1WDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Tue, 3 Feb
 2026 00:31:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9564.010; Tue, 3 Feb 2026
 00:31:41 +0000
Message-ID: <bcefc3ee-4704-483a-8271-01677e47eb8b@intel.com>
Date: Mon, 2 Feb 2026 16:31:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 iwl-next] ice: fix NULL pointer dereference when
 changing RX queue length
To: Kohei Enju <kohei@enjuk.jp>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <kohei.enju@gmail.com>
References: <20260202161826.114393-1-kohei@enjuk.jp>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260202161826.114393-1-kohei@enjuk.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e81416-5931-4d03-873f-08de62bb996c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkhxejhEbXBoeGVlKzJnOGtqRkVZU2FyWWl0OUZld1BESmU0cnlmcDBvazFN?=
 =?utf-8?B?b0VpMndCKzJuQUJJTWdid25wb3hyVkJRUWo5ZDFxeUliSkJjQW00d0NFdEhD?=
 =?utf-8?B?cXNvcVAyTXZXck5EejQramt6SEc0TmgrN3pNT2pwVCtibmY4bXQxRjc4TGlh?=
 =?utf-8?B?NE90WGw2ZitaSThjUXg1cVNjSUozZyttbTJiNDBzckRQR21SRjVTMWRBblVi?=
 =?utf-8?B?YnVISVowamtjZEdVOEJtTUVEek9lSzNYY0pGU3hwVk9EZkh6REdpeFVBRFAw?=
 =?utf-8?B?VTB3RkxXN0lSM3VwTkhzSmMyejVqa1dPS1gyU1IvSXcvMEhGYVBJRktORHpJ?=
 =?utf-8?B?QmU0UThBcWpNZ25FN2pqbkJNckNWZEVha1lkeWd5OHBrRmFsUDRWNUhEaEFr?=
 =?utf-8?B?OEttaXlBWDRsY2hKaWtrTXNyY0ZLc2pLV0xoQ2RGcm8xTmkzOUgxbTJaUEg2?=
 =?utf-8?B?MDQrUGJTQXV2RmtIOUxob2tzSGpUdysrelVHVndweHdaTjBKQkh3bnhjbFVn?=
 =?utf-8?B?U2N6dHpCWlo4VDY4OUpIWTVCUmVva1JWSDFDK1hZYy9NNk8vS3RBZFRZNXJk?=
 =?utf-8?B?a0JPWnVMTS81cmJmNHE3R2UxVWZNYm5EZHFpdFgwU0tlSmI2R1MxcFZzMjJu?=
 =?utf-8?B?eUkwQnNMTDRPcGJJeWE1d3hBZ1R5Ty9wQmhzVnJWUm5yVDRMM3VQd3hMeHZl?=
 =?utf-8?B?MGgzTXYvUXl5bjY1T05mdkNwOW0rZ3VpT3I1WWpWKzgwTldkMUh2QnlDWlRv?=
 =?utf-8?B?aEwycU10em5ZVldOSnZyNS9TUXpXYkJ4ZnpPMENvVzFPMEVQUnNDN29SY0Iv?=
 =?utf-8?B?VEN6ZThuVFBNOVZRNWdCbGxTUzVHNCt0SHJwSDBDMjM1ZWd1OTA2aXl4bGJv?=
 =?utf-8?B?ZjlIakg1elhZMEdWUjlldXZtYTZsSElzOHJOb1B0Ky9TdW1zOWl4UVQxNnB1?=
 =?utf-8?B?RGVKMGFFTFgwL2grYTNiVUZMcFh4d3BLZW80MkdIVDJKcHZaTFdGT2g4L3Vj?=
 =?utf-8?B?SmI0NHNGaURlckRtL1U5NHBMRmd0eVRCYml3S3liY1U4OHNyK3JDQW9tTHRw?=
 =?utf-8?B?aW1FL2lvcVE1RkdLVEVyU0plcmJOSXVFVXJEbDNsS1g4SksyOUNGaGlVNDdy?=
 =?utf-8?B?UmtrR0pJUzltS25DYTh4VmY2Z2t5YkIvaENabkh6VkJtUGtnTGs0Und4S0Jt?=
 =?utf-8?B?K3Axb3dKbVU5ZVN6RHVTS0pTanlybVMvS0NQNWhnVXcwWnAzN1VqZXdwNHB3?=
 =?utf-8?B?dFdxalM2bzlOdXJmY2VMU1JSNFJIeHYzQkE3TWY3bERTbGs0a2tVODJhVzRo?=
 =?utf-8?B?STdFalZNRVFPekR5dTRndkx0eE1aU3dlNDUxUmxRUFY1YUV3T0tCTkhDdy83?=
 =?utf-8?B?MnZKWHByUFl0cTY2YXEvNzR6ZFhuc0phY3JtMGo4Nys5K29XNGo3S3hTaGs4?=
 =?utf-8?B?QW5sV0w1ZzU4OFVXZU1xcHpCQ2NxMkdJbWZQOVhHMGxTZ1FDSFVxbHduOFk5?=
 =?utf-8?B?YUltRCtnbm1Hc1FlRm5BY0pORTJiTEFIUUh3OURQODIvQmZMQ2lpOHVmbWdt?=
 =?utf-8?B?amNrM1dJbUsrTElJbnlVbmpYcWdYNWlIdUhvMGxKSTVLQzRmQ25HbkNidGZB?=
 =?utf-8?B?RWZrMGpKa3FZTUJGU0E0VU1DK2NwWGdYZjJhZlovN0RpK3ZsVUl5TDJHSk9S?=
 =?utf-8?B?VjVrT24zU0E0NTZlZ1YxSTFuL3UwcUhkWjJ3OHl3a3BSbVFDbXZQM1BMMlFO?=
 =?utf-8?B?TmErOW5oeFdQR2tURHVUcE1WakRJQzNLUUlJUnhNL1IxUC9tQVpSbm5GYVFW?=
 =?utf-8?B?K2JtMWRIbW9sY2NpbjE2cGpBZTg4N3l1aEZPVmErR2o5TDMvU0FzQ0JZZGdh?=
 =?utf-8?B?YWtuMTZ6N2RQelV0ay9xQVRVTFJIVG1TOEZTc3gxb3B1Rk10WEhZQkFSeXVl?=
 =?utf-8?B?Z1RQS1FjMFlIVDdldm1lYysxRmFrQVFoNEY3WElWWmFjdW5ZUkdHS3NZU3dL?=
 =?utf-8?B?dEtXQkpIRkRKSzVYdFczdG94VVoxamVIVXkwbjZBTnJWT3E2MDVZb3NGam5u?=
 =?utf-8?B?Z3BaM3J1aTRtSDk3U1VJc04rWm8vc1NmVHR1VStGNHJ2d0xwa010SE9ueUxh?=
 =?utf-8?Q?6hL0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVcrK1docTJjV2pCeDdrdGJpeXR5SjRlSU9ZYjgvTXBNRmFZbzJPRkxobUFC?=
 =?utf-8?B?WFc4QjArRytRU3BGem45VTZ4eWxFcEliTXg3VkhOcElmTFc3R1RxM0p3ZHRm?=
 =?utf-8?B?dmc1NTYyN2toRUZWS2MwUUNtZzdvOWtaOUZ4L1Z6S0pBeHhGQ2FUTkRxN29o?=
 =?utf-8?B?L0s1VDhsQjlERzMzWkgzVk1sMTBKemRQcnNjU3FqWU5QcUZheTZ4YlorS0ZM?=
 =?utf-8?B?R3JiOWJYMXVwdEprc1c0czM3dzNCdUhpQ3lHN1YrMGVYZEh4UlpBeVllcnJi?=
 =?utf-8?B?QkpZYXBaNjhCRm53aHd0enNuUjRoaUhPMXhjUHhhc3lvcWRFNmpiWS9IRm1N?=
 =?utf-8?B?OWt3akxFL3lnc2lJYWxLMzFUbmhhRGdiZTZEYVBqdVdFZmdxR2FmaEZDeVdx?=
 =?utf-8?B?d0NCYUMrWW9VUG9WQW9iMmNxK3NBcExrSGVxM1FtaGVFU0s2eERIMjR0dGRO?=
 =?utf-8?B?RTBOd1l4cDNiR3J0VGVJYjhiWHpPVzVvRHhWNFZCQXhMcEV2VElrMG0yZzFy?=
 =?utf-8?B?R3lCcnh0VjQyYnc0T2tKR0gyRURDQ0wrMU93OWVWbnNXcUNJN0t4N2cwREx1?=
 =?utf-8?B?R3hEUjVDR2M0cWdZMnMwOVhGMU5ENk1BMUF6cHp3SjI2ay84MVMrQ25CR0k3?=
 =?utf-8?B?Qy9ZenYzRVVja3VnUENBcWdWRURyQlpiYXRBbW84UzByTUhMUlBHVE41eTZq?=
 =?utf-8?B?MFVFWml4OS9tWGdlQjh5L1JlRW5FS0Uyc0xwaHNiSHYxSHBQcDRsdXZNN0dS?=
 =?utf-8?B?aDQ2SVFuRldTa3ZiQ3RBeFkyejNqeWNHMWFxWGF6SVhCK25BRXFnQlRYbU0z?=
 =?utf-8?B?TTUwQVRsL3JpdzVUbWg3WTBmYTlqWXNKaldsb1MyQWJPNFN0YklTWk1NYXZz?=
 =?utf-8?B?Vlk4OEFIeVBSa0w0ZGFhNXZlclhYRmQ1bUZpbnRmS0FVZGZwb2QwSDN5cnE5?=
 =?utf-8?B?VmhwVnNWV0xEQ2pUOW1vMVVVK085Qzd0ZTllellaVjd3RGFMcENFOVVqUi94?=
 =?utf-8?B?aWV5aFJaSy9HVkcxb095TWkveUJmUWw0djhqMGxoL2lqa0xwUzZBYzNZeE1a?=
 =?utf-8?B?NmRHWlNpMVpxOUtVNDRnOVNvMks4bXhtRFBzYUlZbU04ZUpzNDFRL2lNaHQ5?=
 =?utf-8?B?cGtncStXMXdCWE0zd1JXR0hmdmtUMjZ0eGlMcEs5RldRQnZ6WGhPY2V0ZU5B?=
 =?utf-8?B?NHc1WFZhVDdMSVhPR29vTXBiandCcW5kL1d4VS9jZFRwRi9nVHRkRnJpeUQw?=
 =?utf-8?B?ZHJiU3hpYzg5eStZaUFkVFJWRE5sbDRGMjdiMHNxbmpTMnJqbE5vZHhJbktQ?=
 =?utf-8?B?QnJhUGh6S2pjRk9aQTQyZ0JoU1ZCTzlsSU12anNzWExEZTh0aW5YSlB1TDlG?=
 =?utf-8?B?dERSU2JBL1k4QXFBZ2ZJWGtOZzN6WEJDVGFZcDkwRWs2alJ0aVhpeUNJNVZS?=
 =?utf-8?B?eXk0VG5BbW01LzNxdmdXb2hhWjlmL1h4emY5OVhBQUxFQXp5M0dabm0wejRt?=
 =?utf-8?B?UEYwNmhQVHhTZFJ2ZFVXNzZtMmgxMlQ1WHN6cWd3OVgzak1mdmVqZ21zR1l0?=
 =?utf-8?B?WFFkYkFaV2VCc2FuRjR1bTNVcERTeUJLOEJ5OTViM3pkQjRFZyt1M2hmeVdN?=
 =?utf-8?B?R2RaVjFkUTJtd2dMMk5yRWVHMGdJUTVweXQ5d25BRGNDTm1XM3R2TVFLalIr?=
 =?utf-8?B?c3AxWndlUXVQSmE2NmdjUjh4Uk1MRThvbDNVUUs0bUJicmFyaGlDZXFCRXVj?=
 =?utf-8?B?UDNLeVkyOVI1WmNkdTlVbi9PamY0VmVVQlloSFFrNnFmZ1RVSEdLcXVvV1Nk?=
 =?utf-8?B?cTRiQVNlZ09sU1JJbDhTT2hyLzZoOHlDNmhqK3lpeUlyZWpmeUdaQWI5N1pG?=
 =?utf-8?B?TzlhSXM4anpnZ3ZzU1Y4TjFVb2d0MGEyc2NqcGQ3cXNGZWFmT25rbjcrTURG?=
 =?utf-8?B?MGxRWVJaTnRvc0doY2hzYUh4ZFE3UVpYbXh1elZUa0lFNk5Uam94SjlnVm1P?=
 =?utf-8?B?NEg0MkgzYkFzTmZLYjYxek02Z2ZVelJSWnJGRHJnZllOSWRrWnpCQmg0U3Zv?=
 =?utf-8?B?UnhVcXM3dmFaM3EzYlVPeFc4Y0xaRWJCWmdSQmk4VkJnWHJURTFKNkI1SlNO?=
 =?utf-8?B?M3hZMmprNW85dk42dlVOVThWRDNNb0pyUmJ1Rjg2M0MxNE9Jb1dIQ2U1SFU1?=
 =?utf-8?B?SmJLSDR3c2lXRmk3QkJyOGI1alhiYnZsK1dTTTVabU9BZHRRM2JBYUNBaFhJ?=
 =?utf-8?B?RFQwT3FRUVFzU1pPSGUvYUpXdEtWYXNmS05OQ0xBSlpjS3h3WE1PbVYyczA4?=
 =?utf-8?B?Q052b29iRks4bUY0QVprdFNzK05YeW5tL0NxeE5iR3FpMUtuaUxKZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e81416-5931-4d03-873f-08de62bb996c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:31:41.0784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiP8eYYNZAgQ0ZqyJK9awQI/dT3BwPyKDp5hZIK1+SgZ/lO68+Bd2YcOgQKyoQ9WwAzUyCzElQfGnDXBStBaAVYusT6tBcJVY64PcvIu2qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256039-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F28FAD3021
X-Rspamd-Action: no action



On 2/2/2026 8:17 AM, Kohei Enju wrote:
> When changing RX queue length via 'ethtool -G $DEV rx $NUM', a WARNING
> indicates the driver missed unregistering xdp_rxq_info [1], and then
> NULL pointer dereference panics the kernel. [2]
> 
> The following sequence in ice_set_ringparam() triggers this bug.
> 1. Allocate new rx_rings
> 2. rx_rings[i] = *vsi->rx_rings[i];
> 3. ice_down() unregisters vsi->rx_rings[i]->xdp_rxq
> 4. ice_up() registers rx_ring[i]->xdp_rxq
>     a. __xdp_rxq_info_reg() sees the copied state REG_STATE_REGISTERED
>        and calls xdp_rxq_info_unreg() to fix it [1]
>     b. xdp_unreg_mem_model() looks up the stale mem.id in rhashtable,
>        which was already removed in step 3, causing NULL dereference [2]
> 
> The root cause is that struct copying includes xdp_rxq_info which
> contains registration state that should not be duplicated.
> 
> Fix by clearing xdp_rxq_info after copying the ring so it starts with
> REG_STATE_NEW instead of the stale REG_STATE_REGISTERED.
> 
> [1]
>   Missing unregister, handled but fix driver
>   WARNING: net/core/xdp.c:182 at __xdp_rxq_info_reg+0x89/0x150, CPU#4: ethtool/1105
>   [...]
>   RIP: 0010:__xdp_rxq_info_reg+0x89/0x150
>   [...]
>   Call Trace:
>    <TASK>
>    ice_queue_mem_alloc+0x159/0x240
>    ice_vsi_cfg_rxq+0xc3/0x160
>    ice_vsi_cfg_rxqs+0x4f/0x70
>    ice_up+0xd/0x20
>    ice_set_ringparam+0x34f/0x4e0
> 
> [2]
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   [...]
>   RIP: 0010:xdp_unreg_mem_model+0x113/0x340
>   [...]
>   Call Trace:
>    <TASK>
>    __xdp_rxq_info_reg+0xfd/0x150
>    ice_queue_mem_alloc+0x159/0x240
>    ice_vsi_cfg_rxq+0xc3/0x160
>    ice_vsi_cfg_rxqs+0x4f/0x70
>    ice_up+0xd/0x20
>    ice_set_ringparam+0x34f/0x4e0
> 
> Fixes: 111a8e2be488 ("ice: implement Rx queue management ops")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> I see the Fixes: commit exists in only tnguy/next-queue.git, so I'm
> sending this patch to iwl-next, not iwl-net.
> 
> Also IIUC dev-queue in tnguy/next-queue.git is rebased continuously, so
> the commit hash will be stale soon, and I don't know how to handle this.
> 

Yea. Including the full subject line should be sufficient for Tony to 
find this.

> I'd appreciate it if iwl-folks know the way to handle it. Thanks!

Ideally we can squash this in with the implementation patches and 
include your Co-developed-by and Signed-off-by tags if you would agree 
to that?

