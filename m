Return-Path: <netdev+bounces-220516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F93B4677A
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAE23BE715
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F35622F01;
	Sat,  6 Sep 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEknfCmS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E25661;
	Sat,  6 Sep 2025 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118029; cv=fail; b=pT90J6UtaFRryj7xzUtnb7KWycrVxwGhzRQT8Tt/7AsAZxMzqlvlK5aS46ybTBYEwllsHLMOnEer51snVA3SyGbvoO7R5DkLN33qYD6w9qvwGN9KF4AkbR1N4ibplxMEkOYyBFDqGZkYxb6QJkAv8QqBrzsmFPADOjblt5D8lVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118029; c=relaxed/simple;
	bh=qiLiA/WW8HcJoaJ2kLVO6qwQY9ISnuPGTt9PIT/+sxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUXXI8lSo3VypDRb7hHsDnFBrdpL6U77LbpgDRlsEMg1BRqP07ReYfOU6uBj3BkxIA9YygeufQieRn1NJ8FKm+XyTeDShbUks55e05Cx8nAjH1dtfflFaWxrsNOt83oi88QU2FL4pYl/ve/zH+IcG3ODKPApsGCYU6ZHtrgHF7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEknfCmS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757118028; x=1788654028;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=qiLiA/WW8HcJoaJ2kLVO6qwQY9ISnuPGTt9PIT/+sxk=;
  b=XEknfCmS+xuUlztSITUGoCRouQaMwYfy5dMgxbE16HX/9tRwxPK7MSgN
   Ar1Dk9rxDvBpCHxTzLgPvGHZLVF+46DBA6Cb2708oYeQ6oPsW21U92AUd
   tfkz8yBYEgT3JxtpaObFlUbDf1talCUNbgi/e/aIMLT6oRD0nUQoBPj1P
   /rKqracbTH0Csv3js3KF4QxK7YbXmLDjd4UYeUaL5Sccc0483AMdoLBBj
   vsjnl1T2YPrrKPoTjNYSbizV8lBGjWUYOpyXQ9kMVCkypJX2ikaJh5Itl
   98KYjv+pICMYNykQO2OT+vREOAsARVmf/yXdnadkPKR+qrpY7GEPjD15X
   w==;
X-CSE-ConnectionGUID: QXTLKQ8UQnib0a5SbCYS/w==
X-CSE-MsgGUID: OuVJXrnVSGq2Lb058CEO5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59619005"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="59619005"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:20:28 -0700
X-CSE-ConnectionGUID: /XKuMKrwT6uj2ELobJsoHA==
X-CSE-MsgGUID: piRJK0OgQf++sWFEZD09Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="asc'?scan'208";a="209448271"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 17:20:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:20:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 17:20:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.72) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 17:20:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyThJbgbVBwU/FZ0lvdeQ5YuXM/hpSU/R0MIoaLb52y/aKmIOJOZi5GQ8n7lSaDHd1mkwGtUgXGvNz3rIe7PmQuwmJDkdbDDpVJg6cG2JTiG6VPMDrvajKTbtEz7/j+2tC2QO7cevYnaQs5lYbUopCZn1J1KvZwCbaGIl1d1BQGz0gosOQQt088rJuKdQASYAjnMNb9hDOHQiSKhA8DxEB7p3iyCx11GJz4zPAE3riZzbBbLOb6iAf+Ei5/JegB3i7nFVHt8hh1rInb9Hn2b3C1OLA9UqoKKSfk5TI2pXmvtVt47UdvVs1htORe+VeOmCw73aVodl4P40HrF3VMbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWw8ShyvrvASZuwIHmuJO2fIV+x8tzUDgGEVDOD+XP0=;
 b=qZ8aidv73anRt3PICWZvr8+ebLIYsogGtuajy4lOhUYG7OL90gq97zE6EnFKusMrc0epSdRlTGZNmW/MhYIw0ZMF0kTDZ0MWSxkcvdU4yTrIp/3YKrQRwj14BlvhvBZFiWoeL/xAySEk/OEGi293uk5DiAWlQkDuM2UEoPHUXRxN1iezfrzk2/bXBSlj+JCQvjd2efZB/3/BBsVCJnK6gLKiZuT7jntQzUibGEFogx3IZckd2hLEl6fny+nm5kvk36YQO/5smCICV/Ghgiwa9grEyhDflk39u2QEqGYqCUTHvSInAg+TchLDjEkt64LIqcbIEigY/kHdnWl7c8rUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6372.namprd11.prod.outlook.com (2603:10b6:208:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sat, 6 Sep
 2025 00:20:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 00:20:22 +0000
Message-ID: <eb1ed54b-f399-4e5a-9ffe-d42b5e969461@intel.com>
Date: Fri, 5 Sep 2025 17:20:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/11] tools: ynl-gen: add sub-type check
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-3-ast@fiberby.net>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250904220156.1006541-3-ast@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------pLp0PTqHigDnxpBLQyEdA2CG"
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a4a1e9-3eb0-40ec-dc08-08ddecdb2b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXVXVENTdk9rTEhFSm02aXhhc0dvTEtBQnFycHJna1VyUTBlVEs0bWJYODFD?=
 =?utf-8?B?OWRSOGJhWkMzZDhmUEovb09Mdlg0cTV0dnYwNlZmNjZRVWVCankxRjhYckpW?=
 =?utf-8?B?VWlvOUhpbVlHbFlKN3dsbXZUb0VubmZtdERaQ0V6bkRLYXh0Q3htUlNkajdl?=
 =?utf-8?B?MDNpbG82amZrRk1pTEtaRHRwUnFOUlo5TEl0ZGFDb1BkdDIrRWNXNzd4Q3Fo?=
 =?utf-8?B?OFNnNlZxaDFGcjJxQ1lEcHZJZ3A2S1BRcHlIV1NaaXpTN1lEeWdEb3A3OGtt?=
 =?utf-8?B?akNnWmNYYjFGYU9CU0lLNlVxcE9ZUHk2MDZVcGxlaC9VTWhCSkhPZUJ5K3Fu?=
 =?utf-8?B?bVRVZkZWNkdBY2xpeWRlM3BLQUdyTUordDRRdnNRQnFLWlR3U294bkRCOE5N?=
 =?utf-8?B?U241VDVub0ZVNjlucWtEcGVTRG1zN2s4YzNQVGdvT1VyR3RtOVdMNEJqamRz?=
 =?utf-8?B?UnVBUjJTUFJYUTJIUWczNm0xeThPMWNQamtOaXBYaUU3QzhCZXM0RjhjK0lK?=
 =?utf-8?B?KzBvOGNmb0dndlZOSEhHdEpRenR1SXh5ZlFYWTJnUEkzY2dpMDh4RURQclpB?=
 =?utf-8?B?VUc3eWZEeFBvSk9HVzFlY3gyZ1hoVjVWSEtYQ3RLVkpLV3BzVEY1OEM0ZkNw?=
 =?utf-8?B?NjJHdGNDYU1sZE5rZVkzNG1aVzBJUkEvRFB3dXFsNXR0UTBsb2RrNCtKaUZD?=
 =?utf-8?B?Zm9UYnlTc3h5aWFoTm84bCs4ZUM3MGxKVm0raVlKV29GOVBMS1VoeUdDaFBY?=
 =?utf-8?B?R0Y2aExyeW5BOWx1ckdLL25KNUJ4cVE3UVVSRWZtSDE0THBwWHNnemxBVFh5?=
 =?utf-8?B?WXJ0bnA1Wk12bmZUTTRKM2RkYUlpdmlNck00dloyVEpTV3RQd1JwZSt5dElq?=
 =?utf-8?B?Uk94OWhWblUxSERqOXZ3U1h1bGN6TDVQRmI5Uzk0dXRiUHZVQ2EyUC9FTG15?=
 =?utf-8?B?Zms1ck1xNU43Zm1sczFXOFpKTi84NEdwU3gzbExFNFFodEtZUGFKTWszU2Vm?=
 =?utf-8?B?K1RWRzZiUlROWEI4UHVGTjZWcS9JNnErMUt3SlZIRy8vajFud2NJZ285cDZm?=
 =?utf-8?B?dmpZMER0eGdtUXNNRVJVZTNXNzRkYkZTZEpUWXV6SDU2NUpoSHNYZHg5eEkz?=
 =?utf-8?B?dXRIMG5XYWpueGpTY0ZNcnVEQ0FCQWZNQkI4bGFXWjJyZkxPWUtFK3ByY0FE?=
 =?utf-8?B?aHgxZmQxWVpPMHJlWVpSczhvaHMvbWdBS3V1YVRtL2xUeGpFeGh4NXpPT1pi?=
 =?utf-8?B?Q2FObTlvUHhtaGN5OHBOd2lvYXlLNnFCZ3ArcDQvV2xxVmt4My9rZWJudHVM?=
 =?utf-8?B?aHZ1dkJqakZhcWNOOGhWRTI5VGZrcmlZemY1WGRPZE5UNWttNjFaK2o1SUZP?=
 =?utf-8?B?RUJIcDREQVU4M1A0SFVMTVBZNEpxUHR0cHQwUytzOWV3aXNKUVJOa251WEVQ?=
 =?utf-8?B?d0U1djdhcFZRbm1RVVBqTkpKOWJkdjV3TmNlbnpUNjhJSjdFc2tqdGtUUndT?=
 =?utf-8?B?Qy9iN1BGYVZPVklwZFBRUjAzOXMrcHRMNXp4R0Q2V1I2NnJxVUNDT3VJQ2hR?=
 =?utf-8?B?K1JRVHZhQ1J5ZWNXQWMrK3dRQzB4UkJvRUlDbTdEOTFQM1hxNzQrbDlYazlH?=
 =?utf-8?B?WUNkSzhKL2JPZWlxS1pFWGVqcW1wMDZtaW4ySkNuQmdhYmE2T0JxOHlPRThF?=
 =?utf-8?B?SUF1WmFPQjJ3MS9TUGtvamg0Si9nY3ZUakNFaXh4R1ZZNkNEcVkzWnRuTWV0?=
 =?utf-8?B?WWVLQVplQTdqT2lxc1VOV0R0eWNwU3gxa0lPcytrNjdBanVmM1NSbHZPa1J2?=
 =?utf-8?B?UkVCOThnWm9UK1hTRGhCd3RIMFJ3alpYb3V5TW9oMzh2NUFBajZ4cU43VFUw?=
 =?utf-8?B?TFl1elBMeXZyYmRBcUtiZkRIWXdrS1RINEdoYUwzMnNmTitTRHQya3RScUt4?=
 =?utf-8?Q?rBuTKhDeyeo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRIMDAyOW5PQkQrdU9OdUthb0c4MEMyOE1neEFUcUk0RVdGbk54Zi9PSGFv?=
 =?utf-8?B?UHl5dk9CU1FoWE5CcktXZFJldEZuMVJLblU3YlRBOThzSFdaMGJNSnhiUC9G?=
 =?utf-8?B?U0FYUlRqYTdiRXZoc0xXWlJ2a2Zpbmp4UWduZFVYdkRvZ0NFcVRTS2Qya2la?=
 =?utf-8?B?QmE0WFZTWTdnb0lFNmVBZktidVI4dHIyTVFkeWZvRUttQ292RDFBU1JBWno0?=
 =?utf-8?B?MmxEcTdPVXFjQzJnQkNFc3ozY2l4MC9INzNYZ1dwbmFTRS9nOXB1YithU1lr?=
 =?utf-8?B?ZG5FOXc1YnBsL20xeFNQb3Q1MFpIQXhXMFprUENXR2s0eTlEaHdQL0dUQmNa?=
 =?utf-8?B?YUdPcTFSSC9PcWFEM2dvUTdiRFM1SUhjZG5GT0lGSEhvN2M3VGdkOEFicm94?=
 =?utf-8?B?MFdSaU5vZDBZcFRYTG95VnRSOU1xd0xCM2JsWjVBa1Q5a1BzaFRZaGtvdGND?=
 =?utf-8?B?V2tlczJpbDdGR2xWa2g2YUN2K3REYTAvZmhIQ1F6dXRhbnFOMmtGV01rZG50?=
 =?utf-8?B?enpGdmRtSVFqWE1HMmlzTzF2eFVIZTFWdmlEVHBBeUdlQVg0dW9JRk1PczVN?=
 =?utf-8?B?ZmZURXdyZmplTGhxa1FKWjFjeTRNRFB1VDVSYmpWNENGZkN1dEhKbThFdlhi?=
 =?utf-8?B?NVV4K01oaCsrRE9PMGUrQWZNY1gwWVUzYkIzM2pYYXJDbzNya0VRcmxwenFU?=
 =?utf-8?B?RVBHREJ5OVZMR3VrZThiN2pBUG9lNk1yek1kbnc2ZG5nT092UUpHZEl3UDYx?=
 =?utf-8?B?aFcvdUJKUnlxdkJGZHR3ODhxRUJqRmdGRnBGQjhQZ3ZEdDVvSkNJYlpiZkdQ?=
 =?utf-8?B?bDRRM3M5TENYMVg1SWhMNEZnOTQ2UGdOSW1TcVpKMEhHRTUxWERqN2EyYTZn?=
 =?utf-8?B?WmxyMUEwcmFBclBITnNnM0FyTjBBWWpmcStrSml0K0tDNHRoNERvbEhHTkdK?=
 =?utf-8?B?MG9ubmpYeGx4MTlhOWdpUmlYUDl3dEMwVkp4UlVKV3hiZVowNEtCaDFHRW04?=
 =?utf-8?B?TTk2VC90blN5Zmd0aWFzZmNtbjNvZVY1cXlzTGFOdEZIdXo2QzZ6d25WMFV6?=
 =?utf-8?B?Z1E0MWZtTXpkcXQwbGxUcnlkaTMzdXUwenhteTBMaUZMeXZabUpYN3hHOVVx?=
 =?utf-8?B?RVlZc3F2dGN4RGx5c0NCT0NtQlNhQVJ5eXljY0MrajdiM01RZEVsaUJlS2lN?=
 =?utf-8?B?d1N1a1hmOS9MZmlQSXJTWHFXYWhkNzNJcnkvOEEwc1lkVEY1cFE1QWE5VDhR?=
 =?utf-8?B?MVJnNFF2UGkvd2tHbDVqcXArNDcxNmhCV2xxZXd2aEQxaFQzUEhudXArTkhE?=
 =?utf-8?B?UENMV3loQ2tSZUkvYmNhWXdSeHF5c1JYNHAwNFdqV3lyOE1Fb2dCR1JWY1VX?=
 =?utf-8?B?MTliRXNzL3oyOTF3c25sTFpKemxhYUs3eUg0aG4yUnRzZ21nbkJGbW5Yb0tI?=
 =?utf-8?B?MlJHaFVwK0t2QUpXeGpMTjhhYjlUdVhobURMUzdUdzVQQVpzZUd4N1R2Qkpx?=
 =?utf-8?B?UzlRcHpUWDVNTjdtd050RjJsMDZDUGJtbTdRMVNCQmdJSkN0bi8xRUs2K0xD?=
 =?utf-8?B?VmRpNVhHc3pHQlh5aVlLSEZJK082VVB6QWJycEovck9nbTZReGhLaVc4aTZF?=
 =?utf-8?B?S3N5NytDdFZDOVpVNFRyWjljUksxbFZKeU40eDM1a1E2N1NGcmY4cExadzFz?=
 =?utf-8?B?ZXZjM2J6WFBqeTJtaUFnTzhBbEVBVTlPNEVtV3QzeWNCYS9yS1BLQ3liTHJI?=
 =?utf-8?B?bW81cVFvRHR2cDY2bndTb2I2c3I1OFI4blVzbC9MV3MyTTBMN1djK3djUEZI?=
 =?utf-8?B?SmVWZmxSeUpQbTlEQjdXcmVXU2tvQUVNa1FFa3UrckVKa0hyOS9kamh2cFdQ?=
 =?utf-8?B?dENJY2FQTktVVy9uWmlGUFQwRnBoY09RdzZWRnU5enM1c1BQcC93emltRWlF?=
 =?utf-8?B?Vmt3MGVYcExMQXRKcEtidTZTSWRjaEFFc0Q4MXlnVXNzTG05Vy9QQ1Q4TWIx?=
 =?utf-8?B?Z2lHallqZXV4d2J3Q3B5WVVFa1RSb0RCK2dZYnZWTnBxNm9CTnI1WDNNdCtB?=
 =?utf-8?B?dy9KYkZwcGg3QnV6MCtmQmdGakNTQzRqYVJaWEF0Um5LdDRMT2EzUzI4LzBG?=
 =?utf-8?B?eDVKb2YxNEd1Vmh1RFh5d3JrcHZ4Mi9TajNGa2E5SWF2ZnpPNjNNUHEwZ3pV?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a4a1e9-3eb0-40ec-dc08-08ddecdb2b4a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 00:20:22.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mmpsXM0VJ4pVrbklCyZVwkicunu+UOnMRY93AwV+arpDgFmV3g5GgC3bz5D5NmJEugUDtwTKmplZh++rCrU1leJjEW/XqWQGaMB+94wtbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6372
X-OriginatorOrg: intel.com

--------------pLp0PTqHigDnxpBLQyEdA2CG
Content-Type: multipart/mixed; boundary="------------0dTeaQ9M5B8Kc0zmXlf3WWpT";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <eb1ed54b-f399-4e5a-9ffe-d42b5e969461@intel.com>
Subject: Re: [PATCH net-next 03/11] tools: ynl-gen: add sub-type check
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-3-ast@fiberby.net>
In-Reply-To: <20250904220156.1006541-3-ast@fiberby.net>

--------------0dTeaQ9M5B8Kc0zmXlf3WWpT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/4/2025 3:01 PM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Add a check to verify that the sub-type is "nest", and throw an
> exception if no policy could be generated, as a guard to prevent
> against generating a bad policy.
>=20
> This is a trivial patch with no behavioural changes intended.
> > Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  tools/net/ynl/pyynl/ynl_gen_c.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl=
_gen_c.py
> index b7de7f6b1fc7..04c26ed92ca3 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -826,8 +826,10 @@ class TypeArrayNest(Type):
>              return f'.type =3D YNL_PT_U{c_upper(self.sub_type[1:])}, '=

>          elif self.attr['sub-type'] =3D=3D 'binary' and 'exact-len' in =
self.checks:
>              return f'.type =3D YNL_PT_BINARY, .len =3D {self.checks["e=
xact-len"]}, '
> -        else:
> +        elif self.attr['sub-type'] =3D=3D 'nest':
>              return f'.type =3D YNL_PT_NEST, .nest =3D &{self.nested_re=
nder_name}_nest, '
> +        else:
> +            raise Exception(f"Typol for ArrayNest sub-type {self.attr[=
'sub-type']} not supported, yet")
> =20
>      def _attr_get(self, ri, var):
>          local_vars =3D ['const struct nlattr *attr2;']


--------------0dTeaQ9M5B8Kc0zmXlf3WWpT--

--------------pLp0PTqHigDnxpBLQyEdA2CG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaLt+RQUDAAAAAAAKCRBqll0+bw8o6K01
AQCQwa+JtY6oKMlqWxZw4outY+JhHg/fhOxj3Q32hP3erQEAy9z8JOiWcvhvFwt0EDtWq8gDrm9a
9pr3NnEMrT+LjQk=
=uDnL
-----END PGP SIGNATURE-----

--------------pLp0PTqHigDnxpBLQyEdA2CG--

