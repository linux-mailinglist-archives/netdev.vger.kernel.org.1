Return-Path: <netdev+bounces-186474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA84A9F520
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAB63AAFEE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D227A12E;
	Mon, 28 Apr 2025 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sx6GPblD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891C190072;
	Mon, 28 Apr 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856335; cv=fail; b=T1u+GVnHYjaqns0czJTam8U+LUgCqpl9QWSj9wzMLIAEXY31KL+sjyZD5uxqKP3n9x9bWyUBfuMw/oOg/djDsjfTT5c7y/3d9e7aXe4gDgMIfGloGpISPF2Yakqcnim2UEM6dpV5+UYtOzpCxQisby5+nc48SMkjm5+1J5PZ0sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856335; c=relaxed/simple;
	bh=tXZpbxJlkPj+09pQ/zEZVI/BZGkFDLObclgEqCaz5aY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJH14F7fq35WOI8U5I6tcIARAXNUEKg8H9e2zqGiKNhH5SV2fK+6XMqftHpIIeBDzW04Ua6Hf2Maoo9FxPMb8d//Q4OoM1spJeyTwbPdY0JEFst2cX+scoSff6aigyFdoDMYEWA/nNlqhU1RmRmjXBT80RgtBVoZqdtMvtUQOsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sx6GPblD; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb4c0c1CsbW0JuIRA2GoteKZKeLz10F5wjv1CHqyGhoQFzvMcHV/zsSKZccLSrgGWtW+7dsQd0ksSeHAAJd7XjmtZ0Am/8dFVPiOdslBhYld1kfVZ1I5dnRQXJShnEnG9d0xD9h5myMz/W7K9bQXwUhow0btQ+YYnOkR2U1EkPAOm3Fp9CWwxXMSPS3sf3Xh94idoHoSc4fB3BTPOkrPSvbAsxEedp603yTWqzQpNUv2I9rWq5VswdnYbCm0f8qKq6XW9r7B46aWYxRVD4/juHe+Vwzbq3Os65xDvEKjTD6/2HxfSFiPWVlk+gamGaXdumTljEQRv5x1lYMEdOyJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxbjoIBfsFVTXH0CZa7fg67JsPLVuPFBQiPA0ucz8Ds=;
 b=Z5Ri48teml6Rf2hvnXzRQsLSRFLmRKphvzg+ZonWkZ+VJbVqN1v24dNnq1r+xa6V4Q9AgUC7KbxWatxkTVM7Yd2U8ZzFlPu21nEBOXSEqBK8e2RN6HcSgwoliInSmmE8jigMHQyjQMfp/iVCvfIiBdF82bsqTzZu91vIhPpG6zvvrFosbQLO7PWLXSNzSlMcPBoAkM/QJPkCI/aU9G5w1p1Wkc1y/LTG6MmfOFgnoggQR1kCcl2OZmcuO78tfx4PX35+bEnI1aZpmKppSfWRNqLZvkT92QJL/k6/o87KQHNkzkMZG6b2UQGFyFxgn+SjsQUN5fGwcWgNwMXq+G8Yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxbjoIBfsFVTXH0CZa7fg67JsPLVuPFBQiPA0ucz8Ds=;
 b=Sx6GPblDA+u6AggUFhH1rMWhMXcIYLoo5UeggKSSmPh6azM3x0Ezs1GZsuHXVfWyfpVUpGs5Hh2twuvb5bXQhMO4NF0eFP8W8RLYKQ5cS+8K287w2lx3spLFT94pKk5LUUUxUADFGNOfyi/HUIjIpp/RQE/MlcPk1YRBGBYC9JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Mon, 28 Apr 2025 16:05:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 16:05:28 +0000
Message-ID: <b18129cd-18a4-40b3-94cc-0228f0e04d2a@amd.com>
Date: Mon, 28 Apr 2025 09:05:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pds_core: Allocate pdsc_viftype_defaults copy with
 ARRAY_SIZE()
To: Kees Cook <kees@kernel.org>
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250426060712.work.575-kees@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250426060712.work.575-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc4ae0e-7bcf-4830-13f7-08dd866e7e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmxWa1NMVFlzU00rNGRKY0VhMnFhbWJRZ2hVbmhNdStIb0ducXEzdkxGWEhS?=
 =?utf-8?B?VTN3RkR5RTZuUHd4eVVXZ0NqalptSm5Wb29OR05qMUthdXJ6NEQ0MzZNOER4?=
 =?utf-8?B?MlVtdHRMNGRMYmQ3VVUzZWg2ZE13REZZeHFFWWoxSk83Q3BEdURKRDc1UFRE?=
 =?utf-8?B?QmpweC92emZKNk5RVFVqWk1JbXVuZFBPWU9ZcTdYVXh2bWVsTFQ3SUZGRDJL?=
 =?utf-8?B?NGl5c3Z4QkRkVXVVeU03WkxHKzFySVJPVExUSitabVpNbVlRclV1d1FlWm5Z?=
 =?utf-8?B?MG5NdHlwb0lmcHo4eDZGTTFWYXRGZFoxVktqd29sYVZTWmdBc2doQ1hhbmhv?=
 =?utf-8?B?NjVPMG9sNjRRTXJXTkhLWVVzbWtraEhSUm4xaGg4M3dJWkxNM29TZDhIWGNE?=
 =?utf-8?B?aWcwbldrbGYzcUpDUENUTCtIMlVDT3pXYm1vWFE4YTQzMzRhdnoyZjBTRTJW?=
 =?utf-8?B?TlZXbDVJaUxjWXZySFQwSDVMR1ZlV0k4OVY2NjB1dll1b0l5b3gvbWp2RlRu?=
 =?utf-8?B?OVV3d2NxT1NrSXlZdEZZN3hmSlVqbVVWM0ZlZzA4QUFoSmZXVExlMm5rdjV5?=
 =?utf-8?B?RzhNajdyM094K2hQNzIzY1hGWUtzVjRtWHd6LytuNEhkM2dWSjlNL0lCT0p5?=
 =?utf-8?B?MHJoVjBvZlhnL0g2YmNJY2lZQWZ0N29YM3ZUMnhrWWkvNitjK2RxYTdyZm96?=
 =?utf-8?B?dHdMUkluTzRNT0lQN2tmVnZ6TTZQYzlIUjllSFBudjlleVlaS0cwZmFoMHZF?=
 =?utf-8?B?SG1tb3hjZGl2OGZXNTRtVzl3dmp0SVFxdkpEZVAvd2ZReWxweitFUWxzZE5K?=
 =?utf-8?B?OTExNnFncEpWRXpLR21GNlN5NXZuVHZNb3I1VFZEd1BaYU5iWUFqVVdoeWl5?=
 =?utf-8?B?UU5ITlJrWWlrb0JXT0xKSzlLVEJFZm1VdC9TaHNuZ1VFVndmTnZDVER6amdI?=
 =?utf-8?B?bmN1cllWTHE0ck1DSFpKQjg4WVpic1BQS1FVVjkwMXVhSUYyRm84cE5QRFIz?=
 =?utf-8?B?TzZmeTdnbFRzRmxFQkRqMlkwem5Mam83SUhVQVJDNVhVb0NwMUl5dkpPMmE2?=
 =?utf-8?B?SjJuWnNMSGdOZTF6Y0sreDI5SmJNbE9VWldPMFJDWS9KZ00zN3lVM0orWXMv?=
 =?utf-8?B?WkFGdWM3ZVp2OFlwUFlGdEcwSG5meTQrYmkzSTAwYlcxNTVOU3RSZUV0ZDB4?=
 =?utf-8?B?Wm1henNucHRKM2U4cWpYRWlBc0p2MUhWTC8xSVB4SXVnRHJKMmxKWXloNE1L?=
 =?utf-8?B?STZHcURPUWFERUpENXVDVlFaRTVBeXI0QmlqRTErY1NuazNjWjB4VSthWml0?=
 =?utf-8?B?bFRMUmVmMTRHTW9SMVhRSWN0ODFkdTVnRFhSejNaWXNxWXBIaU5vVDlDeGYw?=
 =?utf-8?B?ZnpEZkRMM3MxN3dPWGpNTnFUbmtTUmtSYTNsN2t5VzBFUWpONzJTQVNFL25P?=
 =?utf-8?B?bjFHVG1GQUVBSUpEWlFYYlJ4V0E0S1lyc0dEa1dYYS9Ddzg1bnJMeElKMHQr?=
 =?utf-8?B?ZkZkeWxPcHplZ0MzcDE2bStxNjFYQ21KaGcvVnk0N1JlWmdia2VEa0xFNUVV?=
 =?utf-8?B?V1Y4LzJvWXZpWXpmclpOTzMydjlsdnRPZmRBWFExdUxRaU1qaXh6cTRiM2hz?=
 =?utf-8?B?L3pjR21oWHpQSUJrSnpHT2xJNmpoVkkzK2NjR2d0emZzZEphd0RmZXFDdE1s?=
 =?utf-8?B?WkU1OGJPSllrUnluZXJOV2lNRnVYR2RCaE1IbmQ4bWdKLzlPQ1BFS3YwWmpj?=
 =?utf-8?B?MEF5cE9jc3pmVTNLQTgwaXZ4eEl5S0pZUU5JUXlDYzNHSGZLZFRJdmdDTkdR?=
 =?utf-8?B?NmJOQjRpaUYxcmkzVkNWUW54UjhBbDJ5RTUwT1A5dXNLWE9SakNCMndBTER0?=
 =?utf-8?B?VDdQZ1FkaFcvdXRVUm9MRUtZUCthRmhzQTFFZFNnc3FsaXBHcU52cDM4MDVV?=
 =?utf-8?Q?FdVLACvU5oc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RThtVEUwQ1huNGZwb3o1Q1kyN3FoaWcxMVpXWVhIWFgyQzh6eHF2WUFCaFdN?=
 =?utf-8?B?ZzYweDJUS2tyaktUUm1zd0xwTzgzVUNCNFVlS29sMncxNjFqUWd2ZWNhZ1NY?=
 =?utf-8?B?K25TaWVkMyt4dW1aR3R2RUMvaUsrbHJSdFRzT2NUMzZsS0F1eUtIOE1BaUpu?=
 =?utf-8?B?b2lUc0VwYnlocjRtY1lwSFFjcWg4SXZ6Tzl1MFY0STJLZlRIUVpvUnlNdmxX?=
 =?utf-8?B?dm5aa3cyL25kZHNBUDNvSno5ZGttQSt3ZU1VS0g3UWN0c242cEFTRkxpVXVn?=
 =?utf-8?B?b1VOYUVCTGxrYUNCS0RYdVRWRWY3Zkc3dDhURDUxSHVmVVc2MHVUd24renhB?=
 =?utf-8?B?dXlEekR0Zm1YR244c0p0WFh5WVlhNFdvWXJpM2RwcmF1MHdUWHdpNk90akVu?=
 =?utf-8?B?dVhMRjFUTTk3TXJVQmpqWFZveEpiaGloYlhzSGFVa2tnK0tGNGoyQU1ZaTQx?=
 =?utf-8?B?d0N0NmZaSGppdjB5OUdvQ256M2N0Z0NPd1ZzQ1E2UWgrU3pMS1RqMHRGbTdp?=
 =?utf-8?B?dUVnYVVRVTJWU3cxanc4dXZjekt3Skg2YUdrYURRUWtvc2g0V2lPMkhhcnps?=
 =?utf-8?B?YUNyOGtaSE8xRk90d1lNY01TUnk1VzlUKzRpT1o5OXJIUTBWNXUwK0JXSkxE?=
 =?utf-8?B?cDRoSmk3RXZ6bzYxNTdQbWp3TERjdVhHZHdRblQrQnM2K1JzM2premE5UW80?=
 =?utf-8?B?Zzh1SmJYSGhqZHhnUGdNamtUQmRJK05SMXBsYkJwdnorSmczSDlXa0tIRWpP?=
 =?utf-8?B?YXh1SnZ6a296V1Fjb25ySUZySVJia3NXVzJ6Z1pwajFVbUw4M3JsSFpWNDdl?=
 =?utf-8?B?STRYNDMwN2V0Q1d6bWNScTBjK0ZaQ1FXMysrWGtFNi9ZYzVPVmVCRUlIL0h0?=
 =?utf-8?B?b1N0R1ZwRmVwTHdxczZhWG1Cc1RiNzduakRqaVNSK1FKUit1ZlZrV1djVmkr?=
 =?utf-8?B?Ty9ZTXVxQmZQdldQeFk3NDJmbitndEJPNk5LRUtiQjBtcmpMcU5vZzJhbHRP?=
 =?utf-8?B?aVN3ZVJ3TFhXN21ZWURIQWxHTDB3clprUVJTOVM2ZDBkVE9EOGlHcHVwWnIw?=
 =?utf-8?B?cWdkZWwvLzRNODh2SlR3R3lGdUV3OFlib1dFbFF2NnpOd3l4SFRlWVFYaWx1?=
 =?utf-8?B?MWdYa3RTKzZxZkhCVVN4YUlLREVMaHlETlFlUWRCd1hDd1VGMVdBa1hkTUxD?=
 =?utf-8?B?NklsTndLTHdSRzluMUI5Y3B2a2Y1WXpQRExiN2dWcHMrOW41a1FBYWc2cmVi?=
 =?utf-8?B?aG0wTVJUUmdHak1tVkYzSmpuSERwTVd3RkNya0VxZkh2VVJPUGhqZ1lxbkJE?=
 =?utf-8?B?WEVZV0lieDlwbnNEOG5nVmtWaU5CbmpwbDN6LzhSa0hOcEEybi9ld3BpRmVZ?=
 =?utf-8?B?VmQydkV5ZmRYWmdQaHdlRmUzckJGVWNwUWNWdGQ3ZlVsTnhUREJNWjRWZUFU?=
 =?utf-8?B?QlpWblNQcDFBNWQ5eU1WQ0RlK2hyUHkyRnlMYmRVbVAzejQ2ellrMmdJWG42?=
 =?utf-8?B?Q2tBZkRIYnBFV21tdjJMbEMySnpQUnRSb0lHV1BMcER3U3U1MVBTWFhOQnpn?=
 =?utf-8?B?Tmx4ZllXY3JKRWJ1b0FwazA5d2x3QUVxRWdmeTgzRnRKMjJWSUNwd2duMXNB?=
 =?utf-8?B?WDZZQ3FMMUM4TzErWm5vUkFUaW1Nb0pjamlTdTBSN3Jlc1h0YTM5b3RFeFhM?=
 =?utf-8?B?anRRcDhTRjFQbW5HeUZqVDFkVWxUWHdHZStvSTZCS20rT2hjMmU1NkNTR3E3?=
 =?utf-8?B?TUlVa3ZmcGlVQ1JIZlJEMHlxU3BTZ1FONldUU1BSRjFGeGd0WHUwTmo4TTFk?=
 =?utf-8?B?Rjg0SmpHMUk4WkNRelR3UkZHTWdjRzBzWWZOTEtGYWlmSlY2aXlpc3lKbnI3?=
 =?utf-8?B?bVcxK25NZnJHcHR6SmkxUUNmT2lWV3YvR3hPZmZzeVk2K0lLd0U2bmJLWkFF?=
 =?utf-8?B?ZzgvcXR5K1BxazRWRmdPaFZ3amJXYUNVUzU4bU1mdUhtYTRNWGI1SExNa281?=
 =?utf-8?B?VkhiRzRtZWhPdmF3ckhGME1rdENQUzNabmNSaFNqYjhOdUVnYXkrY0ROaTEy?=
 =?utf-8?B?YmFSNzdaQVQrQXJLcC94SEdlRW83alpCY3JNWTNnL3R5NWVEaUFjRGFYcEVH?=
 =?utf-8?Q?69QlX+kc8o0lovGoNoKgZsg/L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc4ae0e-7bcf-4830-13f7-08dd866e7e73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:05:28.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lQNErnco/6ROUdu8mtYiy+V1qy4zOWj3Gg+cr5ViPmETT8ZGtNIg6iBLt0Gr+PPzWs3zpvLWrj+JNqOeJHyLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

On 4/25/2025 11:07 PM, Kees Cook wrote:
> 
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> This is allocating a copy of pdsc_viftype_defaults, which is an array of
> struct pdsc_viftype. To correctly return "struct pdsc_viftype *" in the
> future, adjust the allocation to allocating ARRAY_SIZE-many entries. The
> resulting allocation size is the same.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks,
sln

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
> Cc: Shannon Nelson <shannon.nelson@amd.com>
> Cc: Brett Creeley <brett.creeley@amd.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: <netdev@vger.kernel.org>
> ---
>   drivers/net/ethernet/amd/pds_core/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 1eb0d92786f7..451b005d48d0 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -415,7 +415,8 @@ static int pdsc_viftypes_init(struct pdsc *pdsc)
>   {
>          enum pds_core_vif_types vt;
> 
> -       pdsc->viftype_status = kzalloc(sizeof(pdsc_viftype_defaults),
> +       pdsc->viftype_status = kcalloc(ARRAY_SIZE(pdsc_viftype_defaults),
> +                                      sizeof(*pdsc->viftype_status),
>                                         GFP_KERNEL);
>          if (!pdsc->viftype_status)
>                  return -ENOMEM;
> --
> 2.34.1
> 


