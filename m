Return-Path: <netdev+bounces-112628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657A93A3DB
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AFC1F23A1C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786DB155A52;
	Tue, 23 Jul 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qD9ZAk/k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E77153BF0
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749375; cv=fail; b=Ru4jisb56bkUvcQlM8Tnce2Cx2E0B7N4MvoWpxHIWqyIt32YgP9JZM1vnfMLDSzVl5Ckx1gkp74omeEFbslwYt1SmD+SL12WyVPAHlf75OpNgME4xBoQ4zxwtMNpadVfWAgNlEPfO+E3Iys6QLuc6D/wkmKslmQcrOE6scidyEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749375; c=relaxed/simple;
	bh=EMmhYq7B7zOv2l+hQ0hHWni2m/3BIbTyC5KeL7nP6XE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o/PThgQbm6X1oibGom/1VdTvmLCSHPWdmFSGF8enIXw1OXb5GFD5QyMH6OX9JlmYUeUZ/lTQALU7dWJOQr9/Y+yYGhOxB4/J4QcpuSIXCSFFLIubKOBxy+yTC5U7gpG4kn4NHOX7xbz5/OCUe5bcJrh+ffQDXnlpLqe3ECTOd4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qD9ZAk/k; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7tvYV3Opi4Fm0oXnJAuh3zngsrSaefcBUfyHkGXVtaUgmATVABl1guBLCtGDEgy8njV0NCTMKYPBSHaCe8ashLFc1IOHBuOSpC2GRoA8hX8bpzqoyrHwRRpFBRoTM8TLn9C139kOOCC5Zd/WtKBkqJwGZUxo7BicRAxN7kY6Jc/NUXui4bs2TsXnZ8D8Rd4Qvt60DcHkDHAGP7yxznDkUV0IZ6X74fhQOSYDYmbSn/aX2BvG9mj6vmnR56Oo9agPkckcNGdthbVmvhFn+Aqv5GKRkPSnrKicuCMqZmn2k4J60XSCKCupXohWWpnqgAEV09t5Yv/lD0Fl7Ap5CJH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjuEIDeTTJljlycKvi/dqFzq8vEB3cPTrpnKXZSXFis=;
 b=FRaE1B0BtjkDecN50TzA/lM0VTGO4ikvHYqFQBv830VQhmeumhVJ+ILawefR76jkSvKRLhYMqilxe1gtElTiE6WZ1g1PvJwzQl0ZxbMRtvn/0RKRAj3WI6fxc/0VtWJxLmbSFDf064eXG2sceP5JsBeputOJ1KOgHrwaBEBKXC/3Ub0TSkB+KbJ0+Q1k3VAomh64n5pb7g9+iCyUxH2wQL+xE63oVf6ihuWyGbDT1UqoYleNJX4OW6w24aU/84gqFiS5nw1/DetAPs1+GRNAFw2OnZ3pVI7OcpW4Go8lbanBKMWvQFqO3lpQA6gpdu0+tWQdP1EpxgKaCO4cJGmchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjuEIDeTTJljlycKvi/dqFzq8vEB3cPTrpnKXZSXFis=;
 b=qD9ZAk/k+73pgg1wYJprwdcylZrkoeDF+wJsKnEq3LSGEikNFDHi2PXsdc8gCH7S+aadAl8dFe48sl7PixNdGwdBaM3pk4L5b1SfkVOu0yolpiSxFIArE7qI+oWRIkPY9ZZ9A39QIBfL2/C/EWG912QclWkN98/0j5UFij3snQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 15:42:49 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 15:42:47 +0000
Message-ID: <dcdf039f-4040-4a31-9738-367eda59fd04@amd.com>
Date: Tue, 23 Jul 2024 08:42:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart
 logic
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, michael.chan@broadcom.com,
 netdev@vger.kernel.org
Cc: somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org
References: <20240721053554.1233549-1-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240721053554.1233549-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6831f5-d598-463d-a71e-08dcab2e1a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTlVY1lyZU96ZjRoUHJ3cTBpa1Y3Vm9jNnBnQjQ4UkQwaks3aFIrMG5YVVlQ?=
 =?utf-8?B?Zit4TXNkZzYzQXRnKzRXM2xTclUxbnkvLzRzbG9CM1lQMjlZZHp4aVZkVWZz?=
 =?utf-8?B?UGZQV0FlL0dLWC9vWDE3VWJqK0VoSlNmWFRtUXpmMDdCVzVab090aVgzN1BR?=
 =?utf-8?B?RjdiVlhqMTc5RHRYYXRYME5vWTAzSjc4bXcwUXNaOUtYUW9RVlpHVmRpT0dI?=
 =?utf-8?B?K1VUb0lycXBzWlo2MXRlWU4zbGU3NnErK1UreUpsMDVtL0Z4S0ovSnZPbkU2?=
 =?utf-8?B?TDFTZG0vU25Vckl2TmZvSXV3a2ljTDhBeDF3RFZpMFY5R29WYlpEZDRsZWJy?=
 =?utf-8?B?UkdUVndMU2NHcEUydmhHVGgzMXI5bTZzRW9Gd0s2V1hnQVVKZTNPNjU3enhh?=
 =?utf-8?B?WWlrc2gxYjdrbS9VbStCMk9ocW1nT2tXdk5OVFNOSUVaeG9RMEppckpiSHZV?=
 =?utf-8?B?QjZ6WjFkWlNOcW5HREw5Ym5oTEJpUTFSMi9nZ1BGS1dsS3duTWl4WjVaZ0Y3?=
 =?utf-8?B?cnVNZ0FobGVSSVArRnMzc3pCQnNxMVIrSmFUNjdpQ0FDZHMxVDgzWjBta1Zt?=
 =?utf-8?B?WlZjTUhWTlpzWlVibjlhRnJrWFZKaHZ6eDIvamhWTnFZRTAwd1hJT1NuMHdE?=
 =?utf-8?B?azUxMnYwTTJMQ2Z2bmRpT2lkNDFjL2JhUzVFLzYrNWVuODM5VlJ2Y0o0TzEw?=
 =?utf-8?B?UHlMb3dqUG5mc0czMjNScFFBU2FEbngxZU5Qa3hsMkpmNnNvdFlUQ0U1U1Nl?=
 =?utf-8?B?TTRsWXdZUEtJMk43TFpVK3FORGdNazlMS2I0QWttZFcreUhkdTVlcWQ4V0ZZ?=
 =?utf-8?B?bDE1RnR5TmZCRzNGV1RSVER6N1VzVUdvdlVWL2wyOHBLNWR1OVhwWlBHaGRL?=
 =?utf-8?B?MDc2R25mcC9tTUJqRDdCZUowQ1d4aXMwcmRjc201ZzhiL2FFK0hQb0lXaWJr?=
 =?utf-8?B?QXVZdzlnY1JYaVpCSVJ1Ny8yamxoeTRWYXFPVzl4RFlFUmZSL2lBeG5XSGNF?=
 =?utf-8?B?bkUxWjhWM1dyZ0o2VERPZ1R5blEzMUVhZHJXWmwwRkd1MjJpL21JRkVac2ZY?=
 =?utf-8?B?NVdka054V1dwNlZhb3hPNnpFdzFWME02UCtuNG8vZVV1dHhveUFTWjNrN1B3?=
 =?utf-8?B?YVYvNTJGYmFueEdRZDEvWkt4aFNIWUtFV2Zza2l1V05lMkVVWEkwYnpWMkhw?=
 =?utf-8?B?V1dvOUJLaU5oWHgrbm9NTEhyVUIrdTczZE00LzFOOVlkc2lTQk1QMFppSElu?=
 =?utf-8?B?UEVZMzJ0VzhQVVhPakt6OGQ3aFRVbnA5ZTQ3V3U4MzdncGR1WDFvdXhlMVYx?=
 =?utf-8?B?dUVxdStqZ0YrclFPM28xTkFKeUdhcGE0NEF3WHJUNlYrSkRBK2x1ZWpNWEZl?=
 =?utf-8?B?VTgvb2lSNFUrS3RBS0NyNFY4WG15aEEwN0FoWWVFQUY2d20zMExIb3pRMGU4?=
 =?utf-8?B?c0RwSit6WTNNVzcvMWFQQXZtendFaUVwYXE2VzQ3bnhiYzZMTThlVllPV3Bn?=
 =?utf-8?B?MVZ0SWlzMzU1RUFhWnJhZldqd0tTYUtJTEd5TGF1TDFRemxvczlWSVRVSDNZ?=
 =?utf-8?B?NXQzNHg3dW1DRnROZHVoK2lHNzdBNjNxalJZMTQ3SjJSelhiRkxQbENaWkRh?=
 =?utf-8?B?ZzNQSzB6dEdraTBlWExlTHNHVFBaVlF5QnpOUlZUYU9CYmNBS2lkcFRYTHFP?=
 =?utf-8?B?N2g3OGVHOCsxVXdtb3JsM2pEV3JpZFcwTytMTjFGVDEwb1h6RDVLQzdVUjNN?=
 =?utf-8?B?VXpWa0JGakswRGxBcHZlTUhIazZ1eXJJOFFxb092cUFlN1FoN3JKL01oeTc3?=
 =?utf-8?B?dWNuditWNU0yRDMwQ3ByQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEtoQWltVElreTNZd3hIRVNkbkVHcGZjbXZoSHRubE5lRmZXNzBpOER3THAy?=
 =?utf-8?B?cjJMdmRMT1ArNEphQ0FiQlhreVo5RkRRSEJ4dGhDdVBoQUJlZEhNTFgrZzRH?=
 =?utf-8?B?UVJkR3FWdTBaRHRkRmVBaE1HK2FER2JHZXFka2twNFAzV0U4OWR6anlBVHZ6?=
 =?utf-8?B?TnMwanJDUDBldW1NL0MxYktNN2doaWxjVjhya3A5aUM0WlJaaVlQV3NvZHVj?=
 =?utf-8?B?eVUzNC8rSXRXNDNkSmdsMSt2U0dldnBJVTFreElLQjJVUEp0c0N0c1liL1B5?=
 =?utf-8?B?bzNFK2h6cHpFVklBczh2VW82VWtmRXdWSXFxTnRxOUhuQnJCY21PUnhXTDRR?=
 =?utf-8?B?bTJhcmN2QjhRMmVIUHFUZTlZU0YvQUhIazRONkhXZzBPT3QrTUNiUEQ0cWgy?=
 =?utf-8?B?bTRvQnZURzlVSVFoYjRYWStReTFWTEh3TnNkc0hQd3VVQU5CbE92RG14KzNO?=
 =?utf-8?B?WVhzcE52TDJOSGRXcDZLQnBhYXV6RFN1K0NBdnkzRmxDVG1IVUQ1eW93K2RU?=
 =?utf-8?B?SXF6SnluWElJUnhlWnJjWDlETEJCR3FQUGpMUDZPNWxIT3NpQ3pQRWhlWENN?=
 =?utf-8?B?RGN1WXZVdnVTS3lVWlZjakc2UHJZaXlFSXI1SWMzY2pjWWEwL203eUlLM0RG?=
 =?utf-8?B?ZjUrQlpkMlE2ckxMRnNBTVBvTUdBRCtnb1JpRFpGL296S2M5R3AxTnJrZkFs?=
 =?utf-8?B?SmtQUnRxWDAxRTdNUm5pVFZ3UXl1dk01N3V5YWdjYk8zVHpUTWI5MlNkQm5I?=
 =?utf-8?B?SSs3UFNOTXlBYW0yOU0rTWYwenc0VXorakUzYzQ2S0NmOW1sbzhMODloZnJC?=
 =?utf-8?B?WWpHd2ZubVZEYTgzQ1JlNmRhZ2hyWGtseDZ3S1RyaVdPTlRZZFI4N1JEV3Vr?=
 =?utf-8?B?SWpmY2hNU1Bucmg0dVhBdXRkOVpZdlFHWGwrcGd2ZW90Q1pUSXdZVDQ1L1RO?=
 =?utf-8?B?L000emJzSWZGeExyZlFUNG9iS1pCcjBpaElkRzl5K0toanFTSUJscVVtbWZG?=
 =?utf-8?B?RWRiUTcyVzhWb0M3SU4xRTJ2YnJTVXRqVkZ2a0RsNnZ3dTZibUZLY0owZDRr?=
 =?utf-8?B?UWxUWDZpdmJSZnhKNS90cytMaTcrc2NGYkNmUXg5amFUK2F1WWVORm9QaDZQ?=
 =?utf-8?B?eFZLdjJXdi90bjkzdGZWOHVFa1RtRnVnK3JtVmxrNHZIbSsvbGEybjVqbGdl?=
 =?utf-8?B?cXpuU1FvdWtUdmZ0eFBwUEk3ZnNZY1QwTFh6dEFGbElpWjd3elhGQmp3d3Fv?=
 =?utf-8?B?dU1YWnNxQVF4am9XNlgzd0hkUktwa3ppQWZXeXI5TUp1eklUaFJuZERqVEh6?=
 =?utf-8?B?ZXgxRnlwdmp6WEhCTHp2L2hZdlh5YnNKZFpPQkRvb0FjS2NCY3d2bFpVdGFo?=
 =?utf-8?B?V0JZWjVaMlpMTGZDSXdjSy9pQzVLelVtdWRlMHgrdjNVU21MK1RBNGhlb0k1?=
 =?utf-8?B?bllmUm41UnVpZXZuTHh2MitTbkVNTHFFN2dBb3UreE9mS2NaSU9DNWliVzE5?=
 =?utf-8?B?MXFXQVZ3b1gzSVlhem5RbW9zbjZwWUZJcWdzVUpsUEtoVlN0ZHlCYkVFNzEx?=
 =?utf-8?B?TnVOS1dwZUtrTTh0SjBnYmdlNmdiV0lZMzhGUmgzeDJmTGhKS295VWY3eTZn?=
 =?utf-8?B?WXhhUHRFUHlyd1RwNzJ2N0NMa0VKRjZpVm13MDVlTk1ZSTRnVkw4eDdrRTc4?=
 =?utf-8?B?eXZ5VWhodVQraDFkQ1ltR3J3Y0J3Q1JTSnpPY2VXNHF2OVlCcnJOdGFmMDZv?=
 =?utf-8?B?c0hTbGtvZ3ZSTnJFRnpUZnNsQWticno3MG1kODNJdXhKWm5jbmlWSE4zMTZv?=
 =?utf-8?B?bTJER0YvWndFaTRMeDZSS3pSMCtxdVRaRXAwcG8yZy9tdjNjRUgyMEtPYjAw?=
 =?utf-8?B?WVNVbE0weTNJaVI4WEhiK3VrUnltZjE4ckdEREI2VUh0NUVBd0JaMVdyWmJr?=
 =?utf-8?B?d2ttVjQ5ZGxHd1JJdzE1eWxYYmNIUzV3MWlPMk9welJMREU3NkZrak9Jcmg5?=
 =?utf-8?B?WlFwcE45YUNNZWtwV294QlRZUXh3QlliQ3F4N0hGa1lYZWFhYklKUFFFOGdT?=
 =?utf-8?B?ZVh5VENWMWRyRUJhaXJHNzRqckVjRWN0VG05dmFtYnJKVzBRZlJvcGxETEtk?=
 =?utf-8?Q?BZO8z7B2HAZ7ccJvGpxHmIeW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6831f5-d598-463d-a71e-08dcab2e1a43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 15:42:47.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXDK6vnI/nQfZ+rRIdRAW3C3ZHqvlXQiO9oK80oA12MIjNOJFNURxcD3/zDJ6FRRYelGX+KASUYG6iaSo7CbOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488



On 7/20/2024 10:35 PM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
> updates(creates and deletes) a page_pool.
> But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
> connected to an old page_pool.
> So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
> bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
> 
> An old page_pool is no longer used so it is supposed to be
> deleted by page_pool_destroy() but it isn't.
> Because the xdp_rxq_info is holding the reference count for it and the
> xdp_rxq_info is not updated, an old page_pool will not be deleted in
> the queue restart logic.
> 
> Before restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 4 (zombies: 0)
>          refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
>          recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
> 
> After restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 5 (zombies: 0)
>          refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
>          recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
> 
> Before restarting queues, an interface has 4 page_pools.
> After restarting one queue, an interface has 5 page_pools, but it
> should be 4, not 5.
> The reason is that queue restarting logic creates a new page_pool and
> an old page_pool is not deleted due to the absence of an update of
> xdp_rxq_info logic.
> 
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>   - Do not use memcpy in the bnxt_queue_start
>   - Call xdp_rxq_info_unreg() before page_pool_destroy() in the
>     bnxt_queue_mem_free().
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index bb3be33c1bbd..ffa74c26ee53 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *bp,
> 
>          rxr->page_pool->p.napi = NULL;
>          rxr->page_pool = NULL;
> +       memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
> 
>          ring = &rxr->rx_ring_struct;
>          rmem = &ring->ring_mem;
> @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>          if (rc)
>                  return rc;
> 
> +       rc = xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
> +       if (rc < 0)
> +               goto err_page_pool_destroy;
> +
> +       rc = xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
> +                                       MEM_TYPE_PAGE_POOL,
> +                                       clone->page_pool);
> +       if (rc)
> +               goto err_rxq_info_unreg;
> +
>          ring = &clone->rx_ring_struct;
>          rc = bnxt_alloc_ring(bp, &ring->ring_mem);
>          if (rc)
> @@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>          bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>   err_free_rx_ring:
>          bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
> +err_rxq_info_unreg:
> +       xdp_rxq_info_unreg(&clone->xdp_rxq);

I think care needs to be taken calling xdp_rxq_info_unreg() here and 
then page_pool_destroy() below due to the xdp_rxq_info_unreg() call flow 
eventually calling page_pool_destroy(). Similar comment below.

> +err_page_pool_destroy:
>          clone->page_pool->p.napi = NULL;
>          page_pool_destroy(clone->page_pool);
>          clone->page_pool = NULL;
> @@ -15062,6 +15076,8 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
>          bnxt_free_one_rx_ring(bp, rxr);
>          bnxt_free_one_rx_agg_ring(bp, rxr);
> 
> +       xdp_rxq_info_unreg(&rxr->xdp_rxq);
> +

If the memory type is MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() will 
eventually call page_pool_destroy(). Unless I am missing something I 
think you want to remove the call below to page_pool_destroy()?

Thanks,

Brett

>          page_pool_destroy(rxr->page_pool);
>          rxr->page_pool = NULL;
> 
> @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>          rxr->rx_sw_agg_prod = clone->rx_sw_agg_prod;
>          rxr->rx_next_cons = clone->rx_next_cons;
>          rxr->page_pool = clone->page_pool;
> +       rxr->xdp_rxq = clone->xdp_rxq;
> 
>          bnxt_copy_rx_ring(bp, rxr, clone);
> 
> --
> 2.34.1
> 
> 

