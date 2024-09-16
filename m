Return-Path: <netdev+bounces-128522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261197A205
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B69C1C20A7C
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A7156875;
	Mon, 16 Sep 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UC4ucdKM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129F156227;
	Mon, 16 Sep 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488907; cv=fail; b=c+tvuFMs2D/2PlW1r5cI0CgQZtRZl6XbKizE9WnzO0GZzLedXuO32ttxsbFy6QgNlxduY9Fd5V1XUD0Mb0aPPSNVnEvPqwIY5wZrZAuj65T6NbLZq9b3/Bh4nyK72E3NTP/2TazaydZkCzF/HgQEOa1Zy/9Ew4Lk2nmJr2SVNao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488907; c=relaxed/simple;
	bh=+1e49nhOFcGBGTgrLZezPfs7z4sHD/VBlqfb0xc2ils=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JcYj8Mm3iY0AvrioaUWsdcr6+sc2hc4YfkIICPEKRyYEArkj/15uXPVrlzQCmxOPa4WyOuflRXNUcyHTID9GsXPGwA/ia0f5j78/RB/kJYInzoy8J66K2piT1XECK9k0PfnsEOVGTgYqe5LNaypF+ug+8xYznxl12p8Cz907JEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UC4ucdKM; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv2uEWV1UL7baLTTbU0ylm8IyFEXOG2Mma1g2BJKeKTDfp51C+tr3/kfv5VNFShsq64NoEca7fhJ1vkxudfRVXOnRl1wFmX1o0bcO+rKgHNYNSJdo5HXqohIDKC7ijpuOC5wkfT3ZFuWTdJ3V+1FdF3SMWUkiu3zmHJvKp2JC6aCk7cnxvkvfVv8JH38Zx/16inW/90NO8+zibXHDvr2Ak9wrKcgDHwQyuJBPC0ZzL6R6ax2rX7/TXAwbjIRDq6xNxnsGGjNh4n5RyXCGogI9/dPLp2Uc4CQZn12SoM3L+3Thv59q+48PzUsbKf6e9GQLUTgXvh0uxkQdmeyvGEHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpqcD1tjdSY9wFETMMMx+bAt/6aLCwmKsWYvFX0+FVY=;
 b=pod1NuaA/WHlDvqnCA2I1sVgNrsIKtcG0b+buVT9l/3rj17w3d+haSrSoZZtVADKeVwJvN/5OaHDjsH/DCO/YPyO8bkIYL+W4GelGY3zcgZyfe75lSMl83UVHYKpgfI65c88SWF/Rvno89tidVZp9xlv7hqHBoJNzw/SnkYFP6O7BMdNHb9vS26ngkhmuVLaE/mrtEYwwJAnU8YcaYFWuqWqpID3R9a9/wDkG/zWH1WWdkbRMmyXAwYS1K4tr/2Z1PzZPR2719SzP0rpp0G/5lBIVHGD8z7gU9BfNTO2kn3M1UXMHdxI3eoeadbmPW5wz6/kNUFmBedrxcd8gdiZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpqcD1tjdSY9wFETMMMx+bAt/6aLCwmKsWYvFX0+FVY=;
 b=UC4ucdKMIpqwAd+RPkTf+z/XGnpKfEKvXON6nGh7EbJTI9H1BFzKdqmKhEDkspbnceCOnjXDgTB+NL0kRu0wwvm+QrvmuGug+J2RlJQ1c5tBS9XpvEiNs1JaxuJQva6JjX5KUGOzF53cgkfpCdffbRaZ5P01MIkPr4/G+rXGYx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 12:15:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 12:15:02 +0000
Message-ID: <d299d623-429e-ec64-2d36-c6456793978b@amd.com>
Date: Mon, 16 Sep 2024 13:13:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 02/20] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-3-alejandro.lucero-palau@amd.com>
 <20240913182552.000003ed@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913182552.000003ed@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0244.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e98323-7787-481a-64e0-08dcd64930f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VksyNE15Y1NTZlFCUjVSMzgwQ1dSUFloSkxKU2tNczVzVFVudDNSUnNmRE4z?=
 =?utf-8?B?RjZ3b0E4b1J5YzBqR0tjRmYrZXA0aFM2cHY5NVVRM2tUOFc0OERTbFR1YlNN?=
 =?utf-8?B?NTZIaitpMk1ncTB4OEhicFRKK2U0R2N5dExWbEFUWDRWQXR4VGNlU2ZZSjYz?=
 =?utf-8?B?eFJFUmZkM0RUUEc3UkpHQWRXdTBOVWRNdTRkSFJZK2puWGo1UmFjMWhwb2pn?=
 =?utf-8?B?U25ycDZTOVFMVVAvdUdSRGJZS3RKNU1nMThFeXordGRXbk4yblBLQSsvaStW?=
 =?utf-8?B?dFBidEFXUW5iNTJaNldHMW9MNTdNVjgrZ2h1cFFlc1o3ZGlmNThNVVFPdkV3?=
 =?utf-8?B?MkxVNGdqeVVGbmUrcGt6SzZza2t3cHZvS1dObnUxRFh6ZHZxdURQOUtkTjQ3?=
 =?utf-8?B?UnJta3AyczY0eW91dkd3aklKbzVJSC95aFRlN3BYaHJvd1VHRlY3LzhHbjRr?=
 =?utf-8?B?MEh3d3YzL09kQVU5M29pT0ROY2JiU29MVnVpTVlNWURsU00xZUx2QmxqdXNO?=
 =?utf-8?B?Nys5NE80TUhvbVdYRm96Z3ZjeDBGZ1hITTVZZzNxbGJYZXNiekVPdGNTcEs5?=
 =?utf-8?B?V1BKckx2TTVlVy9HQUVrd0xqRHFTMm5WcWdBRlR0SnRoRUZ5WU5zUmNxdk8z?=
 =?utf-8?B?OVdEM2pxM0s4T0l5eFZ6RjM0UGVCNXRVbDQ5cEczOTZhN2tTQXRycHhsVk1O?=
 =?utf-8?B?bEVTRTk1ZlpPMFc3RXlkRDZTVTNhYW95N0FtSWhQUzRxQ0FWbGtkakEzZVhK?=
 =?utf-8?B?eUF1a3MwcFRkcmdyL1l0OGdtTnVDLzBCcGJ4M1VlRW9nNHBMcjdxZndPOUFn?=
 =?utf-8?B?WTRyTnJIcFBSemxqVTRzaWhqMEo5UDV3UUFMMGxGZ1V5Vmh1cjlYbW41UWtK?=
 =?utf-8?B?bjR2Y3o3cmx6RGU5VmYyTkZob1J4WUdUQkJ6aW85cHFWWkMxWUZjTmgrUU1U?=
 =?utf-8?B?MlpWTkJaSUpEd2prU2JHcnNBRFcrbWlBcEoveTVXakRkWFBSM1lEdGZGaHh2?=
 =?utf-8?B?UER1VDlGTlM0RTVXdjYzVG8zL0hIUVVNUHB3aEFiemxSUDFUVHpscnBaYnpo?=
 =?utf-8?B?cXF6cmtWQkN3VUxDajFITlpxQzhvZGZUMU92b09aQlpnVGJLZE01QU1DaklL?=
 =?utf-8?B?a3VKT01mUDAzK0hxM2VOZmxEcFc4ZTlvbHZZSlV0eW1SbGJkR1ZzclhXdVhp?=
 =?utf-8?B?LytId3VZcFIwYkU4ajRGLytxT0xRYkROSlI4R2F1RWJya2x6SnREcU00cU1k?=
 =?utf-8?B?WjkrWkRnait0Q2Y0WkVtd044SWQzRW5pZ0NSMWhOZUZUNjUzM0g4YXF0eTJn?=
 =?utf-8?B?TXVIRmROSU10MjZ5TTNOV2JiMTRuNXAyc003U0k0a1E3Mmo0N3dRWExoRnhP?=
 =?utf-8?B?Nlp5bFRVZnZZWml6Qis5dHZrbGRnbXE0NUtRQXhTSG95Zll5OGhUaXZ0d3c1?=
 =?utf-8?B?UlA3VU14V1FNSld6Nm13eW5OeDNTanA0cTkwQ0Z5Z25xcUhzSnF4K1lBU2Nv?=
 =?utf-8?B?MmRsMDdXbURVTk5uazYzMXZzYS9MQkZ3dTZ5YnpLdEdxZ3g4eVdldGhzWEZr?=
 =?utf-8?B?NlFUY1lObm9FRldnZTdCVUNWWFBWSW1CbU5GUjN1MUM4dFNzMXBHNnNrd2M5?=
 =?utf-8?B?d0NBMlNDazNqSnBIVWIyZUt4b0pDcmduTDBOeWVNOEc1THV3R29VN1UvcTVF?=
 =?utf-8?B?dGFiZUxoQzRERnpCcWlYUElSVHdSNm1PQ2RuNTRFNTJBUkY3V1loUkZjUHBh?=
 =?utf-8?B?TVRrK3p4Q0tuZTBxR2h0VEFJS0NvYm1VVEpvV0RlampvbjluUGxlNnkzSGV2?=
 =?utf-8?B?K0E2UWlvSk0zbWRoOHpwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWhnTncxNUk4ZVEyVGh4N3hQbUdjZjFrZ1c4dVZ6d1dUYVhabnVreVhUVjRa?=
 =?utf-8?B?K2VnYW5mNGFneTNRQkwwaHlreGZxUFNjZ04rdzlrZVdJYjY1N3F2UXFta0Jv?=
 =?utf-8?B?MWhONTV3WFVkeDEzU0FrUmorZHY3ZVM5SlZkYzNqMmtsQUwzYTZKME95cHo4?=
 =?utf-8?B?K1FBY1BWenRDM0I4L0tGK1FnSnExS09MTWNuelZ0U3NLS3ZVQnV5QTg0eWZn?=
 =?utf-8?B?eWxpR0VNWklKbWxjWmloVjBjUExWWE9nbHNyOFlyOUQ2ZnpqM3plOEhRY2hV?=
 =?utf-8?B?TGlmZlB5TzBKZmFzMkYwQjBkaW1TNnFkd2hvR2xmeVp4dThycUp2UzBMWnNl?=
 =?utf-8?B?S0xVRmM2azVOUzRzQy9ReVlzbHVZNnhlaS9xRFYyaVVUZFRjTzUvMXNBWXNV?=
 =?utf-8?B?Uyt2emJXeHdvTDJ5U2dNOTIwMTg4OURXdmQwZFJBcXZqcjRYSzQvSjN6N0pV?=
 =?utf-8?B?VU5VVFUxaDdTcWFTeG5CaTc1TUNPNFhzQVkxMjU2eVpOTDVHSlNYZElRZmg0?=
 =?utf-8?B?NHJxQkpTS0xEdFJhcFFpVk0yU1hIWUlySUZLaWYrNk1NemdmNlpuSTNsRXJ5?=
 =?utf-8?B?RXJ0K2tFNzU1K1ZKaDFEeWdyakRFdWpBN2g3ZGkyY3hyZUExUVp4RlZDL2hx?=
 =?utf-8?B?eGZOWlJhZ1VWU0V6ZHZIU3l0WVNyOEVCblp1TDBSSyszb0hSVFNUQmVpM3li?=
 =?utf-8?B?c0Fqb1o5alZ0NVJ0Ti9EdnZiMkU5TExTMGRQek9uakIrRzFxT1oySlhNbnlr?=
 =?utf-8?B?cFBrOVZvTmljQzdpUmw4ZWV1K1A1U2JtMWY4Y0hNMmdSL2Vja2FoOGc3SXk4?=
 =?utf-8?B?bTg3cjZRcTNUM1prRFhRTFc0WHBDQmFqR0JhZ2xZejJBQ2xJYmZXRjZaaUtP?=
 =?utf-8?B?K1l0TEkyTXNsc296NVYzenJJcTNaMjlsdzJYUEl6M2hJUTN5TUhpUmROcEhX?=
 =?utf-8?B?V25ZUkJVS3lJMHFYQVp3S2E4LzdhWHV0MUlSa3RQdE52VlNHQjRWM3htVldn?=
 =?utf-8?B?b0lsYmtlNGtaZ0lZNm9kRVdScldyaGhVMVJSclBkOGV1UlRDaTJ2NVROQm84?=
 =?utf-8?B?YVhGbUdpNENndmJWUXRVZEZ3UDFjckpCY2VpbFZGMnBiUUVsVWt4NDZONmNq?=
 =?utf-8?B?dm9Pd25yblhkMzRsa0NQbmhhRHFRdWdiNUhzUWc0UkRqbGl5ejN1TTZJclh1?=
 =?utf-8?B?WGluUHNONFh6R01mWWx3bGtRTUk0RXgwTWEva2hxRmplR0xRZkpjZXZFekZs?=
 =?utf-8?B?aWZQOUJLbld0bGxwNEVMS0ljTjIxZFNrczJuNURxNVppWXAvanQ1OWlXWExF?=
 =?utf-8?B?eEhjM05MdWxxRmJvT2ZDVDZQSFM5cU5sVVFXTVgyUzloWTQwK3VIMlZtOGhB?=
 =?utf-8?B?N2NaeGx2MHF1TzBRNmpYb0JKQkl5TUhnSkRWdjNBaDkybkRUcEVzdENibUZE?=
 =?utf-8?B?bjlnU1pxL1o5ZFdnV2w0a041ZmpxYm1DaThOekhTSHJ2eWJIYm8zSEt0RjBN?=
 =?utf-8?B?c01HbHVQcHc0MW5sbSsxcnpCRnN1a1J6MkNTMGNmVVgycTd0YitYZjdEOWl0?=
 =?utf-8?B?Y1pESmdpVzZCSEtxczFzeTh3d3VPRzhYeTc1SWswa2dtZEhuYlJzQkJLM3hG?=
 =?utf-8?B?cWcvM1dwOG50SWdxekdyYW5OcnR3eGtGOTJzMjhKejhzbWRkZlB3aThBOEtO?=
 =?utf-8?B?ZExmNjhBcHV0RzFnMk5ZYkNrQzFLb2xkdUZCUllDSkV3bmZnK0N4MHREenpP?=
 =?utf-8?B?aGJvNzY0YkJ1UUgzMVNhMlUyTHY0SmhBMWMvWGFjV0RLdXgxMzBwTFFaN1Jx?=
 =?utf-8?B?SWZNUi9Va0dKaWFWWWxSOW9QdndsNzJMMkRHRXNiSVY5YjhDa1VUZEZJMHA1?=
 =?utf-8?B?cDlQR0sxK2Rac2hkV1FENDRUdU1qSjdDZzliMmlrZWVCZmhIRW0yQ2JKR3pT?=
 =?utf-8?B?VEgwMCsvRGtPYkRhSnZUV0t0QUVzazZSa0hwL0ptQ3ArMmpqV0pMMWxyUFR0?=
 =?utf-8?B?bG9YcVBaTFd4RjZTV0drSzNTYkdkTDhiQThUVm1qTXc2NzVzSnN2M3Z1blJB?=
 =?utf-8?B?cnJZQW9nZ0U4NmNyVkJMNDFXY1dDRFliVmFnNmlFSlQ4WS9ZcXVOcmpmRys0?=
 =?utf-8?Q?TdWG+kYicb8W06GCqyG8SiMfs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e98323-7787-481a-64e0-08dcd64930f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 12:15:02.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tdqMURfizTZLSJ45VJSpPRGhr90BeKYGpMvtpnUAdsZIQ60bY2IK4WR+kvvamti4+ujSCf4ib7Gwkaw+kto4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034


On 9/13/24 18:25, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:18 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>> implements.
>>
>> Add a new field for keeping device capabilities as discovered during
>> initialization.
>>
>> Add same field to cxl_port which for an endpoint will use those
>> capabilities discovered previously, and which will be initialized when
>> calling cxl_port_setup_regs for no endpoints.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Hi,
>
> My only real suggestion on this one is to use a bitmap to make
> it easy to extend the capabilities as needed in future.
> That means passing an unsigned long pointer around.
>

It makes sense.

I'll do.

>> @@ -600,6 +600,7 @@ struct cxl_dax_region {
>>    * @cdat: Cached CDAT data
>>    * @cdat_available: Should a CDAT attribute be available in sysfs
>>    * @pci_latency: Upstream latency in picoseconds
>> + * @capabilities: those capabilities as defined in device mapped registers
>>    */
>>   struct cxl_port {
>>   	struct device dev;
>> @@ -623,6 +624,7 @@ struct cxl_port {
>>   	} cdat;
>>   	bool cdat_available;
>>   	long pci_latency;
>> +	u32 capabilities;
> Use DECLARE_BITMAP() for this to make life easy should we ever
> have more than 32.
>
>>   };
>>   
>>   /**
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index afb53d058d62..37c043100300 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -424,6 +424,7 @@ struct cxl_dpa_perf {
>>    * @ram_res: Active Volatile memory capacity configuration
>>    * @serial: PCIe Device Serial Number
>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>> + * @capabilities: those capabilities as defined in device mapped registers
>>    */
>>   struct cxl_dev_state {
>>   	struct device *dev;
>> @@ -438,6 +439,7 @@ struct cxl_dev_state {
>>   	struct resource ram_res;
>>   	u64 serial;
>>   	enum cxl_devtype type;
>> +	u32 capabilities;
> As above, use a bitmap and access it with the various bitmap operators
> so that we aren't constrained to 32 bits given half are
> used already.


I though maybe I should use u64 ...


>
>>   };
>>   
>>   /**
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index e78eefa82123..930b1b9c1d6a 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -12,6 +12,36 @@ enum cxl_resource {
>>   	CXL_ACCEL_RES_PMEM,
>>   };
>>   
>> +/* Capabilities as defined for:
> Trivial but cxl tends to do
> /*
>   * Capabilities ..
>
> style multiline comments.


Right. I'll fit it.


>> + *
>> + *	Component Registers (Table 8-22 CXL 3.0 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.0 specification)
>> + */
>> +
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_SEC,
>> +	CXL_DEV_CAP_LINK,
>> +	CXL_DEV_CAP_HDM,
>> +	CXL_DEV_CAP_SEC_EXT,
>> +	CXL_DEV_CAP_IDE,
>> +	CXL_DEV_CAP_SNOOP_FILTER,
>> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
>> +	CXL_DEV_CAP_CACHEMEM_EXT,
>> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
>> +	CXL_DEV_CAP_BI_DECODER,
>> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
>> +	CXL_DEV_CAP_CACHEID_DECODER,
>> +	CXL_DEV_CAP_HDM_EXT,
>> +	CXL_DEV_CAP_METADATA_EXT,
>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MAILBOX_SECONDARY,
> Dan raised this one already - definitely not something any
> driver in Linux should be aware of.  Hence just drop this entry.


You mean never ever or just by now?

Maybe I'm missing something specific to the secondary mailbox, but if 
the rule is if none used yet, do not add it, then there are other caps I 
should remove as well.


>> +	CXL_DEV_CAP_MEMDEV,
>> +};
>> +
>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>   
>>   void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);

