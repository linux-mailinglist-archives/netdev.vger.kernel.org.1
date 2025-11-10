Return-Path: <netdev+bounces-237152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F91C46366
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EC234E0F69
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ACC211A14;
	Mon, 10 Nov 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lh2e4O1Q"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775121D9346;
	Mon, 10 Nov 2025 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773842; cv=fail; b=jOhTIlcxvbaNqlezkLSF/XovYTbh/ud0fm6XYQRUU88CxV1qrd+QuXNE9CURa48PAFV25htXn9WbxpO1sSQ//QqKdHC6yHDI+WVDLyDa5hA6z8MDtbwrfqtwuBjWR+f+3i4u2A/FuR31j+1kirNOXXh44escpBi5TujI1bS68tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773842; c=relaxed/simple;
	bh=TcEaHCOQ8qRij+kqyKsyxdlf6CUFPCWzOPJHtn3v6g4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qbRxV8eQfktN8/z/KgSUPeScyp1QOOluEplcgFxoUr5OuQZ7P2wMFcwTIRlEkW00jcf37uFLDBgoTxRc4kqiiT9aWXMSn9miiejgRANb99KNe8uGFo47352xaaexXPF4N4FzQLaGkWy8KGdYwKnvnIQhN+iCUzrgB/cTc6/ONXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lh2e4O1Q; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sjzz8V0e5FY3Ks7sfgCK2p5N4ufGOKjSCikaRxyu01lx1veUikYsQs82MFMLF96fmF00FsULxbN/Wp81OFaC7LnkfaHtm1s6f92n62z/tFaR6If/qsY7YMQ/gf0PMfxbpaHxdqtNRiIdsmyij9IQyGFU7CNL+65t97MaxGRXNvMyPS+j0YOeuL/7Sdde3ORp/buflR9X3S7tAHMDZbMlIA35d7IDdWakcNwfImaDJi5yGfHB2W0uXHMtTdKMrJXIIJ1woVznObjw8h7Qdw0b+6ozvqIskIAWi0gsBBkjKU6vJYU4jBSApXf1gqn+/Ps2kSAn2TrI2QPHfel2Yc3syQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig6X1jzdHycR+ZA1/+oYrODr5c/q6mhvH1lyqnm8DQo=;
 b=ncOBcf0GESxI+pa49wOC7tw1rCOo943g+wifdT5TWGRgm9OxQmYv25AaAghEunlF9GRb648BCTUd6fTX/T2yA37iTI6m+a6x1ckHh/e4gwPKirC2+/ytgyTX0L0D6pIpIF6hyjjW+AjFJm4p8/ISWtwzLVUiGSGGhz3pP9I0FhddZ8z4FVzHZXjnOPcIHlFESfXH1XQNIlFHUcZN32fiAxWo9f5Qwld6HtsEIx5BgfuZI2gO3KDpebMJXiMLIU6jwcYOtg9vcSzgG5QHGIcgMcLjWd/vvkKGKwgNGMUfGOLE5hHKMZvCHVwodJMrAGKic1OnDdo20Z3P3VAIOnuJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig6X1jzdHycR+ZA1/+oYrODr5c/q6mhvH1lyqnm8DQo=;
 b=lh2e4O1Q8gIt93AQKosg5K6HD57hI86SjNyXXQqujgrFPjo5iw2YAgJqZT2/odO8U8CP+2Lrsyi6fDdEXuuJ1ek/oG3NGR82DzTKQW7VaEBjSDcEsrci1uzyIy+BomGDCymoFGYgPHHh0dduO2oh7cGViYPduH/OsPht0tMQc2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB9495.namprd12.prod.outlook.com (2603:10b6:610:27d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:23:58 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:23:58 +0000
Message-ID: <15f7fc60-b7e5-44f2-99aa-a73dbc145f59@amd.com>
Date: Mon, 10 Nov 2025 11:23:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 06/22] cxl: Move pci generic code
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>,
 Fan Ni <fan.ni@samsung.com>, Alison Schofield <alison.schofield@intel.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-7-alejandro.lucero-palau@amd.com>
 <20251007140113.000028ad@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007140113.000028ad@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c678af-1370-4057-1293-08de204ba3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eCtGeEIrZ1RRd2NuN2JxeEdpaEpFS0VqbVI0NzQ5NGhJdGs0TzRTcTlHcERJ?=
 =?utf-8?B?VStyNi9kSSswVmJBSjV5VzkrQUMxVkJ0Q2VVV1pLVXZWMVU0MUkrS011RXJz?=
 =?utf-8?B?OHhjcWtqc3VKUzZxOTE3aWUvbXVGL29QMzN3NXcrcEpVck45YlFSVDdGMGhV?=
 =?utf-8?B?aHRrbUprN1R0TEJuY3d1RFlYNm9STlpnNHkzOGQ1ckhwVXZmbDNDcFRLanBG?=
 =?utf-8?B?dTBRM1pIdm0rUWd0Y3lKcEU3QzN1RDg0bzBMQjZpQnVTU25Bcnl3MnIvREs1?=
 =?utf-8?B?RTc5ait6WnltZCtvMTB4cXR2YXVEZkZNOGlBMytNWHNwRTRqbXdrTEJIUmVG?=
 =?utf-8?B?TFloaXp5ZE1Odkt0U1lpSXNxQzhYeHBEdnREOXNxU2oxUzFWQmo0TEtBRi9Q?=
 =?utf-8?B?WWx3dnZ0Zkp5SlZqVm1HUFllMmpVU1JPaXJHQXc5R01HYVdiQVFCQ1BBLzB6?=
 =?utf-8?B?S2F1ejFPZDk1b3FRM3N4RDl4T01jR25lRTVoUFFmdEJDT3ZVVWNpWFo0aXlo?=
 =?utf-8?B?ZFU0eXpkcFkrcU1mWndnZzh4TEZFREJlamFibDJpSDhkeit0bjNxRUFQV0c0?=
 =?utf-8?B?QVVRWG5KbDlvVlJhMTdnUUJxbDB0WVo5MXRNckdxSWV2WlpEb2dXL1NkanRm?=
 =?utf-8?B?YXkwclFma2NxaDFYMmR6Nitlc0VRUk9CWmNCNk1nOUhDSlI2NEEzU1UraUJp?=
 =?utf-8?B?NmM0K2JWZHh4TWtVNlk3Q2t3aW03UE44Wm80aEgyaTVCRE90T3d2ZmNUbzZp?=
 =?utf-8?B?YkpZb2lLTmQrN0FhMTBjbGdvbHJXVlZsN2xESTUyLzR0cFoxTFIvVnY1eXVM?=
 =?utf-8?B?Y05HcGpVWDNvbVFpM3hRQ1RzVC9Nc2d3Q0EwRzlNODhXc2lSbG90amd4Tnd0?=
 =?utf-8?B?OE1DR2pMQmt1R014Vm92QlpYRG9Ta3J0RGtvQ3MvclpqRXRMamQ0eDA2SWFl?=
 =?utf-8?B?MXVMaHRRTldhVkxaMEpiTnNydG1SQnhrb3dLRG1PNldMWEtVOWJCYmJhOXlE?=
 =?utf-8?B?Z24xMDlVRGNjcEEvQ1J2RFlpREVZMlRvS0xEbVdqODZPbG1TbDl4NGlyblBn?=
 =?utf-8?B?OWpENkt3K243SFFlRUdCME56Ly9zaW9QRUZPVzhCZFlicDl5Q1JRKzdHUEMr?=
 =?utf-8?B?Wk94RjRCOUkzS2JKTFVENjViMlFSd0paQjZWeEpGWUFQbVdXNk9pZnN3YVFo?=
 =?utf-8?B?amVDOFhGdmRaL01rT0tLYVFpK0Y0UDAwRFdEMVgxWGFNN1pBWnBzVzZ6bDJk?=
 =?utf-8?B?NFJEMTUyV0M3akZGWWNNOUJPMkFJZ0k0MlZoc3AwQmVQY0cwMmlqUmN2SW0z?=
 =?utf-8?B?RE9rejVWd1pKemxPdHk2SVpqU1NGcmV5SVc3bWhnWDM1TGRuTnNnSlpvSjNl?=
 =?utf-8?B?KzdlUFpLa3g3MS94RHBzdkllT2xBL1FNYkNTRzVXc2pSM0RDRmpVK1hwTENT?=
 =?utf-8?B?clc3S1NoNUkwRzRJRTRva1VNN2xId1JxRHIzQnBHdlhjWmdvQUZPZ1Z0MzRE?=
 =?utf-8?B?SW9ST2lTbTlDZ1ZqTlJmeXRnVWdnN1FFb2hwWnZ5RzMrbGpYSkxxMGcrbEhr?=
 =?utf-8?B?MzB2ZVVja0plZFNOcnR1U2pCYmpablFZVVp4M005ekIvenpHUEg2SVczKzFE?=
 =?utf-8?B?dnJRM1BpS2RkclIvZUxXYmRjanpDY2tkVGNZditlQlVsckVIclEyR2JMQ0Rq?=
 =?utf-8?B?UHU5T2RCTE5rcFVtbDlXRElYL2JGTk53bFNsUWUrVkR4VmdyeVI2QzJldzFI?=
 =?utf-8?B?U0pyNFhodVI5Q1gwUHpwbHpJemViY0R3YVJCNDRHNFp0UnVYOE0xMFNBUkha?=
 =?utf-8?B?OHRIOUdDOUQydHpwRFpQbHJFNk9jZ0d1bDFRYVBuajFKd0NoWG1OVGU5NFdq?=
 =?utf-8?B?dVk3WUxXdGswTGM1ZjFyUjZYMXdyL1VFekZSNjRTRE9aZ2FjSWFwSjVrZUUz?=
 =?utf-8?Q?MrSuNWpzxAUQq0MwMfpBwvWZpQUK/fN/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3FVcmwrMUdxM2FpNUF1RXp2MjhSbnNSbGlERzAzOFl0VnRSb0FvQXRuVHRu?=
 =?utf-8?B?eG51WkJZMHR5RGVNUUI4NlozblJmUFdwNFJoeC9yU3Q0RGVUM3Bra3h6WUI3?=
 =?utf-8?B?WU1KNUlEQ3dTZEhZQUI1Qk1nTmY1TlNYNzgrZ3A4YndDMkpiVkJhVWVRRjg5?=
 =?utf-8?B?VlZQQXRJTm01dzBrM051NXEwK05lbGhoZmV0Y0Rub3E1QkdwMjdyRjN3b3lo?=
 =?utf-8?B?Myt2dkRWS252bWtIbGV0TU54TWdJcHNXYU1hRnlKbVhLZGxaK2VtbytJaS9u?=
 =?utf-8?B?VFB1cnVmT0dYL3dLd2xBNWxHOU42MzBVNVBzS0d5dW5xVktMdnkwRXpqVm04?=
 =?utf-8?B?UmNOdms2SjloODRPUEJuUG1ZSmlEY01HWVVVc1JZTjZUUlRiZ1B3M09FYURy?=
 =?utf-8?B?ZmFlbDRCd1BMcElqTEVVYnpqcFdpbEFvb084YU4xNGxsM2E3Qk9zUDRIaXpn?=
 =?utf-8?B?cnFib2JlSXB5R204bkhuR0xyVWZnaHZWb2ZKbnkyNXlldUNSUFl1cFRBUDhy?=
 =?utf-8?B?S1lSU3NMSnJDQXNMdTFGaWI0VEJIUThldGswUVoxNC92QnJpOG1SYXRBeXBF?=
 =?utf-8?B?SEU4dUJXSDM2VmFnQ1RmSGM1U3NJNFFGandTZXR2MWxORi8rSE5nak5aZEU1?=
 =?utf-8?B?RFh1eFM3ZWhJSWgxYmFYZkJva2VGMngyYStqUlNpVDVna1h2Skh0eUFaODlP?=
 =?utf-8?B?RjE0aE4wcU9PRTg0ZUlDTEJRUUJQZ0VXV1NFd0QwVGt4MHBnQ3NNVGRLYVJR?=
 =?utf-8?B?T0RZRTBZUVB0aVFGYmNZQW1nV2NjekJKVVdqWEo0VWlSS3dTdkQycnZXOGxI?=
 =?utf-8?B?RWQ5TnpmRXRaaWVSc2FxRVRaQnpZTmFnejR0TGJwZGhFQVUrWHRrV1V2WS9Q?=
 =?utf-8?B?R3dnRmFqNlZoM1lUa0Vjd294VFM4NkpXV0todi85V1k5Z21TQ1o0SmRmUFdh?=
 =?utf-8?B?TWdTYmxvSFZGMW9QUkJiSzlrRkYxSEQ0SVIvUE43TllyeEEzcm9HOXN4L3lY?=
 =?utf-8?B?V3J1T0p0NjRqMW8yY04rem5kUFp2dEFiRlRCa3EyVkJGYlE4NlFZR3p2RGEx?=
 =?utf-8?B?MHlqbytxNzdBdGhGTmhTekhDTkdRNkVBbEpHVFJaWVVJRTRZbGM1ekI1b2tk?=
 =?utf-8?B?OGRSaXorQUc1MmhHcXZKSlJkSm1UMitmdTd5Vm5Dd05UT0xOSk5TdkFDak5E?=
 =?utf-8?B?b2dETHBaYlQ4M093eTFlVlZuYmR4Z3IwSCtDUlgzMDI3TjFqYlZQMUlNVTMw?=
 =?utf-8?B?Sy9ETGJxdDU5d1JJa2ZmRWpWbjBFKzB1VElsQW0vY0k4N2NxdlA0QnRGSklw?=
 =?utf-8?B?M1pZTlJwTTZyZ2NvZFB1M0FQWTNBdzJ5TzlRRk9wREVPb2d4RnJyN0p3dUdh?=
 =?utf-8?B?OEdTNXZIdnFVNU9OMG5VemVmRzFycDJuaTZpVUFrN3lmdUZFeENmdUw0SW9I?=
 =?utf-8?B?cFNSbHhkTVdzcW5KUjFHNVUxaTh6QzhmTUVaVk96SEc4eWd0T0lWS25QTGVa?=
 =?utf-8?B?amd3YWFva3piQndKbWoxQ0M2bDVYY3djSjJzSG01cGNSL1AzZitUSUhwelNV?=
 =?utf-8?B?S2hSR0d0SnNKTDJrVG9zR3l0bFhKSmF0bG9sbHQ1TDNRbjdpN3pDRFpWMUF5?=
 =?utf-8?B?dHJWc1I0SG5VZTlkYnA2cjhkazdWQmcwSTVLb1REcFllcTl5azk1K24zZHJ3?=
 =?utf-8?B?dDhiQXl5NzZpQkVKUllic2xlOUZzcGdObU9oODk4WHVyZi8rcFVZejAvQW1i?=
 =?utf-8?B?eThlQVJLdXZQRUhqUGJLUkxHMVljWTFoMUVzSzlWT2JUU1NDSDZvc01vcE9Z?=
 =?utf-8?B?eUJMdUVPOVZwWm15M2VYZXh6VUhsNkoydGR2dnplN1phTksyTUZWNm9xTjZi?=
 =?utf-8?B?emlGd2FKYkEySVZmeUh6M0RYODNzZythRGpLNTJpYXVqSEpYNnF4aURKRkQr?=
 =?utf-8?B?Wm8rOE5aQ0hjemROSkc4NkFqa1R4dU5sV1gwb0JtOUEwc0hFTDVxUjRVOS9V?=
 =?utf-8?B?Z2Q1RU5UMWZzQ0hhd2h4NTdRKytYTzNOaDg5ZFE4WHNkS0ZzVjNab3RPSXpj?=
 =?utf-8?B?QUs4T29RWFptZWxtTXBVUnFVUU5vS1dyVzhPQndpc1BtOGU0Wk1qdUd1WklY?=
 =?utf-8?Q?RgHX0dNZjpkoHuPDvDVg4xMNx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c678af-1370-4057-1293-08de204ba3b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:23:58.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBgly+VqtixrjiozjOMXYjboFV7GIWVzfnb0uz1ccmQCI6KmrzodPS66OHT0HJJo3md3vKopYxN/2B9sMjHhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9495


On 10/7/25 14:01, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:14 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
>>
>> Fix cxl mock tests affected by the code move, deleting a function which
>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>> setup RCH dport component registers from RCRB").
>>
> Trivial but can we pull out that code removal as a separate patch?
> It's something Dave would probably pick up immediately.


The justification for the removal comes from the changes introduced in 
this patch, so I think it should be fine to keep it as it is now, but if 
Dave prefers, I will do so. Not going it for v20 though.


>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index ccf0ca36bc00..4b11757a46ab 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -74,9 +74,22 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>>   	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>>   }
>>   
>> +/*
>> + * Assume that the caller has already validated that @pdev has CXL
>> + * capabilities, any RCIEp with CXL capabilities is treated as a
> In PCI spec they are RCiEP so we should match that rather than lowercase
> for the P.


I'll fix it.

Thanks!


>> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
>> + * registers in a Root Complex Register Block (RCRB).
>> + */
>> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}

