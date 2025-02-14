Return-Path: <netdev+bounces-166375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326EA35C2B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1544C188FF60
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703325D539;
	Fri, 14 Feb 2025 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J57ylNPM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5925A64D
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531425; cv=fail; b=Ku0MTqLO1hbnmVkGKOR4BAXeFz5dAlCueGJbYMOL2mf8vZTIUmCEcDFvMqe9KHbokP1Pkkt1ZTn/1PQEEhSOhPQtgeXM9kBQRYux1LMexgJmEXMpGGBHyJaaTglNRUFQyT0jHBwUyvpMdfipmWB8tj202PaxXRyF/wN8mFTsLVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531425; c=relaxed/simple;
	bh=1sAkcvGMii8W2OQHnkvP6TIhJJtGsTj+sVt14vWkJDA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G2zAQJOperdMzAyX1LJiuvK45X4xyW0qMxf2fcezDOJeGOOjQKBx6uMbzZXOyTg1VXi5jxAYEnuTsne3eKJsGexyd9gE7l36HEstVlB8b1MUwunHjt24++pzG6k0ZBBs/BC8KK2R2V4UrIt72DLCs9voNArny6c81yCpF4Kkom0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J57ylNPM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739531424; x=1771067424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1sAkcvGMii8W2OQHnkvP6TIhJJtGsTj+sVt14vWkJDA=;
  b=J57ylNPMo0cQL53y2+IrIFFcYtagnybzDnaMfAWRc+TiPpznGBScfa96
   hQmFbBEqGZqdqc3WxJObgs406kkkRmilCfPxbn8XtDro7PkNCnDyPBAu3
   Koid6tIsOD4oO/ztZAbWQID08XKnjvJJa4bX4zJ+ZBuEgyxeakhzNAzQN
   JYyaWQ+d6k8bQEWALCfToMXjDQGwnvzcXYYYHfdaVEG3eJ7BgATTS49AW
   RDMKK1lQfHqo2Y5ciZiTW2jHwYhJRjPVdPoesdwyMzh5gJ4kjFon1FbAs
   dDRwWOdzUe0XBcLJnLuYDhqCu8gLLqOpzIgU/iQY+Nq4nttO/y8MicaIX
   w==;
X-CSE-ConnectionGUID: b1aMjsEISO2/J+jh0O8teQ==
X-CSE-MsgGUID: qYm4KD/BRviQpuLYqZcWmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65628684"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="65628684"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 03:10:23 -0800
X-CSE-ConnectionGUID: gxq3xL6ZSAa4btYhghZ5ow==
X-CSE-MsgGUID: HDixrzdlTPKNlgVOxDJoPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113954640"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 03:10:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Feb 2025 03:10:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Feb 2025 03:10:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 03:10:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcb6xox6IbanbC1QN/sFxAcaB1lvslbnYWxuhl5TyK91jjde3rURFOknDR6Tp+7D2N2Gr30rwba/FD9P2LWPFc5ravaSxuFJ70ECz2+GAUGcjY53MjWY/n90odXkSdkvKaXefqe8Qb6VOU37aMUoE4YKGIiaqCINgwQ1/fnyolVS5h+eOgQcyWYizn0/W9pvQEUq1LfeMVqUVaiTFVeQbxCs4MZqX+dFHLa87rYC1teLBNN5L9VhqxYRKPNFZbSQOvF+/YIk0x+WyewhbOmnPvSvXnS16zqOabIrbIndAuu89vi+Jk4XXYIC6laBNu+FK+m/fuisKef9v75dmJuaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny+FOc3cV+K7MIM24pPryeFfRc5GMEkv3FQM5uvAV2U=;
 b=CzTLdBBan8QxN5D7Jjt/Uj7eJWkiKQnt7hplnwtFgry48lLfT8ub850PH1Y2EDWFo8p4C49DuoNcPRlLhmM1rOG8XiXy3Jpt3aeQB9RFXULBg4V68Cjz5AfIrFWPc4P6Jl06+EyU7lumXu2ibVqym7m4hCW8Qfz9Vk+/NfsTiXxsA79/fawsBKwrjz42VczQ0A9KpFSFOK+Pn9XoxoasLZ8T7AB0OABqetFNXm/HHapOdTUzn1QdS3xpL0p/vDp7ESqOBKoJRNaVNpV3x52hranc+kNlmKO1KJX/afQKvL+75M3Wn5aBM0wvf0r2T4ob6PUoEqXHqpJzQzXkOr6n0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 11:10:19 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 11:10:19 +0000
Message-ID: <55a8f1eb-bd3d-497b-804b-1d3a202b8f6e@intel.com>
Date: Fri, 14 Feb 2025 12:10:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: phy: stop exporting feature arrays
 which aren't used outside phylib
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <01886672-4880-4ca8-b7b0-94d40f6e0ec5@gmail.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <01886672-4880-4ca8-b7b0-94d40f6e0ec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 49db7389-1ccb-4785-3701-08dd4ce82ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVdyNmJmMUZBU1VqbFM1TnZFMVJyRUJ4TjJWbEdNV3U2WTEwSEVQTUh4Z1BT?=
 =?utf-8?B?OXRTWUJ5TElIZ2U0MUFJVDlQZ2RaWVRyUmpRTktPRE5Sekg4RGIzSzNVeU9F?=
 =?utf-8?B?OEp4M0ZRY2w5YzBtelgrSzNvSWJoZm9GakN3aHBQZFN5R2lva0t1dHljb0RI?=
 =?utf-8?B?czUxbDBKK3JXWGlkSktCS044TkR4WVYzemxkNk5RUGdzWUJVUXRpdXA4NUw1?=
 =?utf-8?B?YjJ3ZktpbERJd0Y4RzhCZ0FBV0Z5ajVBUEIwMW9QSk8yVFpjMDIwNjV2L1c4?=
 =?utf-8?B?cU5GdWg5Nk1uOTVWcWFvOG83eld0eWxFMlprVEZOTWFDRExIbnZyeG5nWlZx?=
 =?utf-8?B?ZTdCTzVTT0tzNGhVREpmY0xLb3RSUEloTCtSUDRmUnZSRTJkWUJ6REpWb3hj?=
 =?utf-8?B?cHp5Q1Y3Y0hRK01vUmZpamh4WElOQU1DT3QrZDNWSDBFemJ4blpMQ3VmRnps?=
 =?utf-8?B?L1dUdFFPQ2l1SHZtQ1cvT3k3ci9GUnM1UDhuUDNQSU5MczhOVk9QekZvQnJD?=
 =?utf-8?B?bFdTT2lka2xrSEZoWTF6NW93U0ZMcHl6bnpMSUVkVkx5MW0rN2hneGZGL05M?=
 =?utf-8?B?bmQxMmRnNEgzNVZoUnZ2ZVdRc1Uxdkxycmd5VFFQcEhQM1UvWlBZWmxTVVUz?=
 =?utf-8?B?N3o5cnNBa0MzTTVsa1BWTGxnc3RWRWZCSTZPZDNNV0p5MUlDcUlmdExRd0I2?=
 =?utf-8?B?TlFFMEVCOFBuekJ5elorVURiSVhJOTlaZHBqTjZ3OTZURjMzTDZDSUlNallK?=
 =?utf-8?B?U3Fqc0FWNyt4ZXZJSTljdUt5RTZ4VVM1VmNIQTRDenVwekJqQktiRUpKdU1n?=
 =?utf-8?B?OFljR1dBbUlOWmI3RE9SaGo4dDRwbjA2MzdIRmVHelUzcmdyczNYUndpNEdZ?=
 =?utf-8?B?cCtqcW9WbUhoQWVIbXZ4QWpXSVZ6U08vWE5aMEEyMyswTWZHZ1dwNmVicmxT?=
 =?utf-8?B?YTZMd3JNWnhiSEpPMjFUN24wTnBOWWRGWkZnN1dtMGNQRE13cTBKbURGOW0x?=
 =?utf-8?B?bUFTc1pNU1E4V1ZVVFdDWWJybzVLZVY0bGRic2ZHZExhYWxBUHdnM0taYW9i?=
 =?utf-8?B?UG0raTdwTVJBYXJMWVJBNXRMSTBETGFLdnloY3Ryc3BFYzFqUCtXZTlxMTZM?=
 =?utf-8?B?N3R5NU85WGJRczFBS05EYlZaUGZaeHBQVE9NLzEycHlnRzBCaG0rVkN2OWcz?=
 =?utf-8?B?R1N3dVc0a3d3Sy9aM1pucVY4UlNzQVlOUHNWK1NuMTVjT3E2c2VwejZrR25Z?=
 =?utf-8?B?S3E4VGpuZGZUOENsZUc2Qlg1aEtXaXExb2Nic0lyd05ReVV3MGl6cXJOSHR6?=
 =?utf-8?B?QVZlbG0wM0w0aFNGSGRMOTJTMzRhRjZmdFBTQ1M3dnpaaUIwUlcxcGUvUHdi?=
 =?utf-8?B?L0EwYWQ5bEV4TVNJWHF4V0VOYkJmaWdqYlFGSERya1RNa3hxcE1pckNBWWwv?=
 =?utf-8?B?VXBDc25qYmo1TWdXMW82dEo4a3RRektqd3dEdTNzS21lcmJTVThUSWZVNndt?=
 =?utf-8?B?Vm5SME9lUjc0NGE4cjhSS2RZSGloVGxsRjhjQ2tpUkYyM3F6c1FKZmNLOGt6?=
 =?utf-8?B?TGcyWFQvWU5YQWc2b2xoYjhCUCt2S0o4VllwL2NucGo1RHd1RTh1cmFiQllu?=
 =?utf-8?B?SGdRRlZyUlVlSGhKSXVaRUcyMFN1TEo5MkhFZ2ZiS1JDQmZ2UEttWHM4bzNt?=
 =?utf-8?B?enlESFdib3BRK0ZVV0F5c0VhdWZuWDNHNVBBT0xQYmVIa2hadXhVWjkwVm13?=
 =?utf-8?B?dnkvRlVjVlZkSjVVMkI0UHpiT3NYLzM4S1ovc3dWeElXd2dYWExzVjVQMmpG?=
 =?utf-8?B?UHk1YmFNcTlvVkdqd09Ic0tab1FFa2kzL1NYSGRGQjRHZnZ0b2l1S2RrQkEx?=
 =?utf-8?Q?udcu99XgODuus?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVmakZRRGJMWnlPVVlSUXVveXBVREROQkFqdXJFTzFTWFRNdDZMT29sZUto?=
 =?utf-8?B?M3l3VVhCUzFCUCtJTUdMUzNSOEFOZytRR3REZk4rWlFoUnU5TE5TU0M2MXRM?=
 =?utf-8?B?TjRQZWNSTnlRZGFyRzNxd2R6SGZHT28rOFlHQ1gxN1hCVmJYRFJiSmo0VmNI?=
 =?utf-8?B?M25oa1I3WTNRemxXUEN1RlArYWtFa1ljQlQ2bG1tTVFoMldiNFhNOGk1SU5D?=
 =?utf-8?B?MFdEZlQ2Rk1HZ3JGTUF0THJ2aXpkcnI1aktYaFE5UDlxbzRNVk5SdGd2RitX?=
 =?utf-8?B?R3A3bnNDMUlHYmtwSVltVFNnL2FnODBPMDYxQ2M1QXZ4QUtJVnkvYklyMlJ4?=
 =?utf-8?B?ZWwvMGQ0ZnBFUEsydHY1QU9BalRkY0VQeUw1QnpIY3cxNCtoNDhKL2VxTGpM?=
 =?utf-8?B?cVpiUU5jY0hrcDExa28renNoTFJrNVZCWDk2Q3VFODRiZ0x1MUlIajNVSmRM?=
 =?utf-8?B?L3hEbURyc082YTlyMC93a0hFVmQ0WXpkWEw5TGZ5SmErV3pVRlJMZFVwTTk4?=
 =?utf-8?B?MGEycWlnZ1NJcjh2dlBTem1MWFF2bzRNLzYycm1aTDhqRzl0QWFTS1hlQUJ4?=
 =?utf-8?B?MngvcG4zT29JL0l2cXcyVDBIbCs4aGVEaWE5OHNzbERxZitSOWE0UDl0Q0pJ?=
 =?utf-8?B?a2hOQjZaOTlIM2pkbXA3WWR1QkV5SHdKNDJhazRya1ZvSWZqY0hocUxSeVY5?=
 =?utf-8?B?SFVJRWFjNWNGTlFXS1NueEx5Q0V4c09ZOWExSGRoMGR2ejd0K1ZWeFAwTTF1?=
 =?utf-8?B?QkxGTTdNK2pUekpZTG5QTEJXenpDeGpVN2U1LzZEWk9nQ0JMT05HcVBtQks0?=
 =?utf-8?B?bjJYbWJuOWp4SWRLS1FSNHhmbjN5QlpKbzFraVBkWEJPeWo2dm5QQ2NxUHpq?=
 =?utf-8?B?R3RjWS9aQ0FXK28zS3RlZVp1anNqeVlqT1BscDN6ZXM5aG9kZUR4YVI3SmVw?=
 =?utf-8?B?OEo0NTkvcHB2R0dZS0tBMHl5a2x6dkJDSURZcXJkUFVodCtLUDJVNXVMUksw?=
 =?utf-8?B?VFRGZUs1elNyeFVDMjFORVYwSHpRdm01aDZQTVdNN0VPUThHL1VwejVnb2cr?=
 =?utf-8?B?NlVqYjFVK3VObHpLNExrKzVEYzZ2NjRPUUJlMUppOU1pUEprS08wemNhQm1y?=
 =?utf-8?B?Mmo3a1dVMjkzVWJPcjlwWE5mR2U0VFp1dTN4MHluc0xGYkRJODI2UjRKK21X?=
 =?utf-8?B?YlEwN0ltRXJFTWMwUlI3SVl5T3QyR2tvSnlUM2p3MlBkVmZCb3pyWWYza2tE?=
 =?utf-8?B?SXY3VjlHb2JlY3oxT0JjRFhzaU5YTWdOVFJPVHkvT2hpczhWKy83NGNNZVo2?=
 =?utf-8?B?U3A5bkR1L0Q3QkZlWmkwcWR6M1B1N3ZQR3VLUWtVNXJ0cjZ3MFRFTTY3Sm5p?=
 =?utf-8?B?a2JlNjJNUkVGMUdJd1dtQVlvTnk5dXo3eStCRGp6Z0pWUTZzblVQdmlvNVU4?=
 =?utf-8?B?dHJXckIxN2RyZ2tkUWtmMlE4RVR1bVFPUFc3QVBoUjNETEcwYWlkdUNIYkN3?=
 =?utf-8?B?Z2FBb21Ub0Z5TVBod0YxSGN2UkJMTGphdmNCODRmek41bU1ySkJ3ak4rc1N2?=
 =?utf-8?B?OVhlaHpJSHVjd0ZzRnBVaWU0aGVLekp2c3FIN253d1lNdG95SVJPeHVkMng4?=
 =?utf-8?B?UmluV29SeXhqTjUxRUxuSXBmNXRiRmkyWmdmS05KbWdmdWhKenUzSDFqOXdM?=
 =?utf-8?B?QmgvU0oxeVRrSTdLUkFEQVdvNkxVYnZsM2RwYk9YcmQ2M05YYngzZVQ0VmJ5?=
 =?utf-8?B?RW50di9UclE0RXhOYjR2c0NaTWJ1TFV0a0t5Sy8yczFZQ1BrUGk3UEhlaWxq?=
 =?utf-8?B?emlnSkg0WWpPQWg0U0ZJYUJDNmFDRXNTWXVjT2E1ZkY5SGhPc1hKNnlad3BL?=
 =?utf-8?B?Y1R0K1R3ZEZCUFo3STM5ck94cmxvZXFxVTFLeWtLSUluL3ZWbzZtU3F1OEJN?=
 =?utf-8?B?TGw3c2JmSTIwbFNjczUzcE9HN0daVWZ1aXB0bGt5V1ZhZHN5MkUxYUxQaU8x?=
 =?utf-8?B?WmkvT09ibnBEb2l2MkVGL25Lcm9Bc05aeUhSeElFV1M4U0xUUTZiQlVXRjRx?=
 =?utf-8?B?ZFF3RHEzRE5XeFc3cWNubTQrUEI5TGhTcURqNzdReC9aMlY2ZjMyK0RkelRC?=
 =?utf-8?B?elFhaElhaVJPOUNqcStRTlgzWEtyaE1zVWlMWkVkZUZKNElzV28vd1A4K3VS?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49db7389-1ccb-4785-3701-08dd4ce82ab1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:10:19.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dzN8SdPQy1Oht8R8A3y4qqKdACjkfzJa7sbZBWznKTWi5yAYTi/Ccs790RHwYoCAEXtFr3yAo5qHGaSoyY+y/7xIJW93VgW16PEHrp2Ypg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
X-OriginatorOrg: intel.com



On 2/13/2025 10:49 PM, Heiner Kallweit wrote:
> Stop exporting feature arrays which aren't used outside phylib.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/phy/phy_device.c | 22 ++++++----------------
>   include/linux/phy.h          |  5 -----
>   2 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 14c312ad2..1c10c774b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -91,37 +91,28 @@ static const int phy_all_ports_features_array[7] = {
>   	ETHTOOL_LINK_MODE_Backplane_BIT,
>   };
>   
> -const int phy_10_100_features_array[4] = {
> +static const int phy_10_100_features_array[4] = {
>   	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
>   	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
>   	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
>   	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
>   };
> -EXPORT_SYMBOL_GPL(phy_10_100_features_array);
>   
> -const int phy_basic_t1_features_array[3] = {
> +static const int phy_basic_t1_features_array[3] = {
>   	ETHTOOL_LINK_MODE_TP_BIT,
>   	ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
>   	ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
>   };
> -EXPORT_SYMBOL_GPL(phy_basic_t1_features_array);
>   
> -const int phy_basic_t1s_p2mp_features_array[2] = {
> +static const int phy_basic_t1s_p2mp_features_array[2] = {
>   	ETHTOOL_LINK_MODE_TP_BIT,
>   	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT,
>   };
> -EXPORT_SYMBOL_GPL(phy_basic_t1s_p2mp_features_array);
>   
> -const int phy_gbit_features_array[2] = {
> +static const int phy_gbit_features_array[2] = {
>   	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
>   	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
>   };
> -EXPORT_SYMBOL_GPL(phy_gbit_features_array);
> -
> -const int phy_10gbit_features_array[1] = {
> -	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> -};
> -EXPORT_SYMBOL_GPL(phy_10gbit_features_array);
>   
>   static const int phy_eee_cap1_features_array[] = {
>   	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> @@ -196,9 +187,8 @@ static void features_init(void)
>   	linkmode_set_bit_array(phy_gbit_features_array,
>   			       ARRAY_SIZE(phy_gbit_features_array),
>   			       phy_10gbit_features);
> -	linkmode_set_bit_array(phy_10gbit_features_array,
> -			       ARRAY_SIZE(phy_10gbit_features_array),
> -			       phy_10gbit_features);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 phy_10gbit_features);
>   
>   	linkmode_set_bit_array(phy_eee_cap1_features_array,
>   			       ARRAY_SIZE(phy_eee_cap1_features_array),
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 96e427c2c..33e2c2c93 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -54,11 +54,6 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
>   #define PHY_EEE_CAP2_FEATURES ((unsigned long *)&phy_eee_cap2_features)
>   
>   extern const int phy_basic_ports_array[3];
> -extern const int phy_10_100_features_array[4];
> -extern const int phy_basic_t1_features_array[3];
> -extern const int phy_basic_t1s_p2mp_features_array[2];
> -extern const int phy_gbit_features_array[2];
> -extern const int phy_10gbit_features_array[1];
>   
>   /*
>    * Set phydev->irq to PHY_POLL if interrupts are not supported,

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


