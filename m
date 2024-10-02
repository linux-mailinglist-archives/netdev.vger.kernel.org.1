Return-Path: <netdev+bounces-131319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143798E12A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3661F24733
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDD1CF7C0;
	Wed,  2 Oct 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="q+s52np4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491538DF9;
	Wed,  2 Oct 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887656; cv=fail; b=LKJJ87s5Tin6bqeKSCtDEZ25sIskwS4OjHLvFspHI/3mEF+1ukuyuoFKkvHXY4RgQ+EUAtkkZ1i6nIWMlQ2MqVNJ8ZkhpZcVCqRGHNhHrnZT71etydq1tfASqSCCnUA5S3d2JdqG/v/YBFsNEuIgbQIGJYmmLco06SH0MoYtuIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887656; c=relaxed/simple;
	bh=GuxhAH6hp51IvDtS1ck59d3Jj2RabnAi48dKS9nYTaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jr7Hh+G4vrwStyw7klfFRDjZ4rcw60ciMMtpqGVAS6lZ3z/BuhhdSAeNeQLy6wize+U0nh/ci5PoVFTuDHkakLtXPj3OVxSIey2dmj1ZbvpOflEBbW+qEFeqgNQGD0Y+Di99cC0AWvNuDZ0aPrcDYy9S3EvPib1SPgW+En3w6Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=q+s52np4; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsXMOPSyzO59v9EYouIt8s7PsK4QxW06KCfddSwj4wZJVA3gq0VCYR8mVPqYd2INgpmPUDZLNzDfcZ0Vwbj6kur0MwHymckuGZFdTvYuSo8NKCbXi6BH+n1R5nVoG9kZuMfaTnXp9Ly6NlNfPfJtufJ9cZW++ssZfTW1Dp+XGli0Djh82pREuZQeRM++Vk3l6NClYHXKO52+J7ZyZCp64zIlaHRoIdNlr33ytT+mzICsaGphUlm80VAgqlPI1iAGde37D/Ahn02gN+UMNRtzxAVsq1BXim2K1OrtfldiAF3ZSxcrp60KxZ7eUjIsRRHoMg2Kur1ZXK0CbssmGONH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuxhAH6hp51IvDtS1ck59d3Jj2RabnAi48dKS9nYTaU=;
 b=nHC+8CfExrkYl+KOyzBaqVi5rQbPoMUGxNhrh5b5Y4ozDV4Fv7lNijv1JAvEn/SNZq5zEosiAjr3AQKLbc+JkQADOWNlw7GDluw8laARj1yPMCbFsyssIcjZ8zZ3qOLl5erWe72cp024KwHgy+wQW8m+uYmyd6P9p1za3Rf7+eQvrG5G4EwN+cf3PrIFLc6xIvhbCXU6Nw2weWwhycWdUy5moY0+wLuu0XTSXFzaB21tN30TxoS0rbhyEutpnzFpzUaLLQjSXk0D6z9m5oiWk+QTN31P+S99ZUvDxql3Bj9HwtlTf0l6lqNPdq4Nw5Qydm6PYkoJkkmym31OIckjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuxhAH6hp51IvDtS1ck59d3Jj2RabnAi48dKS9nYTaU=;
 b=q+s52np4HtYNJy/87f074AMUyfPL00AUQubq3Ek4+b1x5dE1PiAABMxQnpw5N9f8TPAPqG19F47faX2nm8ia72BxfrjTMgEiIUFY/+HrZJ/ULSk42H00+eI8BVm3fwIar0kDA864VCLkALobKUHLVbxePXWAKWXMB2MijvwY57h1Eap6P/E3+jU8o15ftqVOKzKdZr0yWdGu+0NzqN27+f+0+M2CwhJy3dUV9L1z4WGsVpBeCd5tb/i3c1OlvJrIWYA5yvphZOewLIlNWZtyAN82fCoYMDEKETjAqdxnYoirjyYNriRkA9xmEtJpTyh1YXSuojFo0R2iuHNJ0Q4HQg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA1PR10MB8971.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:450::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 16:47:31 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 16:47:31 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "inguin@gmx.de" <inguin@gmx.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "dmurphy@ti.com" <dmurphy@ti.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH net] net: phy: dp83869: fix memory corruption when
 enabling fiber
Thread-Topic: [PATCH net] net: phy: dp83869: fix memory corruption when
 enabling fiber
Thread-Index: AQHbFOav70x6+fRR0UaOg7mNF5Tp87Jzq7wA
Date: Wed, 2 Oct 2024 16:47:31 +0000
Message-ID: <1153b13b10b423e362622a2b7a3fc6352703d8d0.camel@siemens.com>
References: <20241002161807.440378-1-inguin@gmx.de>
In-Reply-To: <20241002161807.440378-1-inguin@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA1PR10MB8971:EE_
x-ms-office365-filtering-correlation-id: d8f2c5da-fe36-47f8-5633-08dce301e861
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDVNUnpmY1Y4SzBhZnhoQ1FzVVoyU1Q2L3lqSHdLRldpN3A2aGk4bjQ4dld1?=
 =?utf-8?B?bS94enhTQldQMFN6ajh4ZldzZEcyNHlwb01VTkUxNGpNVUN6VjBTSEg5Zmxp?=
 =?utf-8?B?c0Uxd2tnSUVla0p6bmNXTWtSbjMyTFNwb2h2V0pMTlM5aWdxNzVXU3ZHbEo5?=
 =?utf-8?B?dW4yVC9YMTc1MTdzSzVVOGJLMlBBUXlSNG5UUjVPQTRzMm5LY0pmWmRlME1K?=
 =?utf-8?B?c1hUcDhCdHo5VWlVRld3V2doc0ZaRk1Za1N3VUU1RGZLY0pBamFGS2N0RzhT?=
 =?utf-8?B?WTROakY3VkY1cElSdnRqOGplVUZPTGNFRHFGS2tRRjJwL2pMVWFMNzVSaXZu?=
 =?utf-8?B?K0xiQlBvdUdWbFRUVkhncm94SzYwSWRKd2hZYVdLVnVyWFdNTHYyUklxS21I?=
 =?utf-8?B?VjFLWjNTaEFnQ1BvWFh0QzlGN1JBdVVvY2pRQjhzM1FHekttMGFiYUgvU1Js?=
 =?utf-8?B?Zkp4Z0QrYkxGK2NxZk5qc1JOYnBxdEl1S0RSK1VkVGliN0xINGtuclVwYW5h?=
 =?utf-8?B?cXJzbklSVGF4RENOckxFd0RGNUNTeWUwbU1lTXQ0N0dMMHdBMjFNa1dqeEgz?=
 =?utf-8?B?dlV5Qk01TFRrYVluMzhCOFlXcWIrNHJoU3ZxejdidDlIQWlCUG9VRThBZXdK?=
 =?utf-8?B?VStJTlJQT1M1eXFxaE9jd0Z4bWtneWlnYll2bmViTnFwSVRPbHhMZTlGWkNx?=
 =?utf-8?B?M3JTQ2VRTy9WM1RKZzBsSmMwVVh4YVlaclovMEtHMUcwVUtPa2VueEdWWEhB?=
 =?utf-8?B?SmxFbTNKNWNUZXEwaEwrMG5QZ0s2dVpRTXMxdHNHYU1udUI5YjFkTUdkT1l2?=
 =?utf-8?B?N0FyUS9HOW91MktyQ0VxWE42dEZYeWd4SFdabmY3WkwvSjdUQm84c3RhcUJ1?=
 =?utf-8?B?RlMzZEFMci9DVFdLTTJVYng5b1Z4cVhrNVpkbHhmL3hJcXRac1dXYWtUM3NR?=
 =?utf-8?B?L1hpSUF5SXRmUThORHM1RkR1TUJmdThNTnJaSEhXbkF0dGdpMFdJNysrVnpE?=
 =?utf-8?B?OGthYjg1aC90Q1M4U0hjR1V1V0RYVjlVdHUyQTc1WisyN0FnOGdob2pvN093?=
 =?utf-8?B?Qms3dS9Ec2k5eHhGelNZU0dJenk3eTE4b2ZOK0VyeVlLd2RhWkNOUDFaeVk1?=
 =?utf-8?B?c0FuNE4rSXFaWWhJUWg4dDJ5ZUtDcnFCaVlYN1RNTVZYbzQrSXNTVXVnV1gz?=
 =?utf-8?B?QXJuOUtpblMreEtEaTFFTm1QcjNTMnVpRWV1ZDArdzh6Si96enl6Tml3RmF3?=
 =?utf-8?B?ajVZb0dWVDNiYUJPcWJUNzlGcXZEUFBVbHVHcWxvQ3JFZUFVMVplN3RUSGdu?=
 =?utf-8?B?QUxQSzJIWGczc2lKWVBJOG5KOW9QWnVhK1pieFFMaVo4RVZ1Q0xWVnNjNjVr?=
 =?utf-8?B?R1ExR2FVRGNpRVQxR2dnbjA2bkg2ZGJ6OHAydmFsc3ZjQ01PcSsrT09YVVhH?=
 =?utf-8?B?US9vMEFmbHZudjZVZE1jZDh0YURFWjFvanZPRVZManJBdmx3UVZzRkJtTUlF?=
 =?utf-8?B?QlRmRklielE4bnFsdkN3T0VEd3p4OVUzY2Mwb0NnSWFmUWVGVGozbTQrd09E?=
 =?utf-8?B?cGNpc0E1eVR6SjhtMmtPUHVuQXdUdHR0K0lFRUNPOU9aWjBTTU9EZDhxZU5w?=
 =?utf-8?B?ZlFhSUhkUk40SnMwNnZKTldxMG13YmV1SCt3L3JkMGlIV1pPRjZVRGx6K2J0?=
 =?utf-8?B?dGtqNkxFajh2Y1NPbVVEdHRrN1dTbWRKczRka1EySVUrK2MvTFhtbmxRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmp0MzgreWJYRkpCZHdBbnorRjZYcE11NXArWnpCdXlLeVZ0L3VBN2hFeEp3?=
 =?utf-8?B?Qm5oOUNnNnVkMnFMazFhWGo3emdpY2RtSlhFU1MxcTN6SlV6SjVkQXh2em90?=
 =?utf-8?B?eWsvNDFiNjUrNGk5bmhBcGlnK0xRajhKY3oyYXpkbmh6NjNuNUZzOVAxT0g5?=
 =?utf-8?B?U1c5VllmMlRmcHJjazRlODZ1elJWUnNUT0h1SWJqc3RmaTdCUDBrc29NRXBO?=
 =?utf-8?B?ZmdOTUZqR2phY3QreitzMFQrTFlOelVLUHczNFh5aFFUblIvVGRoMXNUeTNt?=
 =?utf-8?B?Tmk2OGhEcyt0b1RKZzRPMjZZZVp0Q3RjVHVsWHV4bXdaYnhFQ0wwYTY1bG1k?=
 =?utf-8?B?NmVVc0VCbVYrVjVwR05weWZ4bnFQWG4vS1F0NEZEc1Bqc0Z6VGdHRkx1K0JP?=
 =?utf-8?B?U3hXRVkvTndaWXNYeFd4dGpxNkZiV1JiZEtuZkRCUzY4UmxxRGJFV0RWSGdk?=
 =?utf-8?B?UGJMVTZKZXBVWURkM1RaRUgweCtqQk5ZTkF3RytGTU50Q1Yxb1RTMlBJYVZH?=
 =?utf-8?B?cERKQm83WkQ2QVJpSStEN0JiRklmMmR3L2IyakZST2FHNEdiekV2cWhEbkE0?=
 =?utf-8?B?N3UrR0tVd3ZlZE9GMVlUZUJSR0oyQitSNVFmLzdub2t4NHdFNjlWQ0lKd3U5?=
 =?utf-8?B?U1FiYWRaRHpyZDVMS2E1aWxLTjBpOUxGQTBhUTdqNHgvU1c4QVpLOFJpbkJ3?=
 =?utf-8?B?NHVXQWFOZ2h6R1U1K0RHd1Y3N2YxMUp4R29oWVNxT1VBWXZXZHJKUzk3U3Zi?=
 =?utf-8?B?UldIYnJ6b1NKTVBxK3ZtakUyUUxDdGNFZlF1L082MGt1UERUL1BOMklaNXBu?=
 =?utf-8?B?aGJNYjJPL0cvczBlZkY5OUd6THBVcmtISUx6TVFKZVE4RitId28xNmhyNW1N?=
 =?utf-8?B?SmFTWURLNHQwTkdJSVJhcWFjOWUzbDNUVEdDNWRkWGZURTlFSjRmc0RwTWRl?=
 =?utf-8?B?ZXZLTkFoS1d1V1dXbTRQUnR2K3RIUWVMaHRQR2d6SzBua0R4NmZ6N1dkZndJ?=
 =?utf-8?B?NXJrdVhYcGdqM3B2WWhpYnVUbE5PeFN0Y2F6VkdESFZyNDJYa3RvWStOMW9X?=
 =?utf-8?B?ZVFTSjY3RlVjSW1Kb0pKR203WlNGeVNQTnBwWHlycnpSV0xrNUpwOWFhZWc5?=
 =?utf-8?B?VmN2MlpQUTNFTEZxcFBiSXZ5UlJyRjUvY1FmM1FLK0IxR2o2WjBiQm1YaGJP?=
 =?utf-8?B?eTJqRXAxYWQ3TGVpNFh5eEtwZmpkYXZrdlRiL2p2TTFvSmVmdWxsaWVKYzNJ?=
 =?utf-8?B?UGtkWGhyWi9UVW9PSTBqQWhmczV6bS9SS1lkdkg4RkVpd1Q5djdpVlpqeWFH?=
 =?utf-8?B?bTU4QmhDbnpRTzduZDRWN0VIOTFKY2VEVGsxNThoSGdhZzFmcUZFM0JMS3My?=
 =?utf-8?B?QVJsWG1va0FEdlYyek9ZUllCMlNYVHIzME14VXBSWWFGVWgrbjV4bGxhWmJM?=
 =?utf-8?B?djY1RHA1OTZaY3hPWnV6TjdTYlY0ZDM3dm9iRjE5RVdTUE5vemZwR1p3YUN6?=
 =?utf-8?B?QmZ2OEVuaHpCdUFWbWtyQmg5b2MvV1g4NlgzbWtQSmJTNEtqaDJmY3gwNmhr?=
 =?utf-8?B?d3V2M2c1WlMzOW9hZ1UrLzZweWVKekovY0VEcFRmZzEwYzlKY3dEQlVpQzhh?=
 =?utf-8?B?N3VLN1NyQTJpc3RIQzFzV1FoNm5YTFdhR0paQWphZ1NkSkk5cG1zZUtHUUFy?=
 =?utf-8?B?UE5ia29mbGwyVG95d3ZhSXVjbUFocTRsV1UraXU5cnNudFhWVDlYRkJKMk5R?=
 =?utf-8?B?bVUrWE9VNGVhZ2xDTDFTZVRtQjdXSlR4Y2V5TnRPRUtNeWFueEVtbi82Tnpu?=
 =?utf-8?B?YU5UdHdlTm0vZUdHTVY3YnZvNXJZSnV3aGdsUU9oM1dTR2lLczZiTDdtMUh4?=
 =?utf-8?B?THRFUllGWG1lRVNLaXVEbnBGbzJJOHcvU2w2T3pxNURiYUNrS00rSCt4cG5j?=
 =?utf-8?B?SzBzMjhHQU5EQVVlVTV2VFNFWDVrWEd0NjBrbU5NdW9DaWkzRkZsbXZmczJy?=
 =?utf-8?B?RzRaNzFmRkdKV052RlIyWHNMY2Z5MlR2L2xMcjBSeEMyM2p1dTVCWWZPOFBx?=
 =?utf-8?B?V0NRd0sxRDhtWVhFc1F4aS9TVGtyQ05pTDZWNC9JQ0ZETWIwOG1MU2lLTUZa?=
 =?utf-8?B?S3BCOU94TzJNK1gxblNWTG1Ibjh0M0JRRG9Sc25uQXZrazBmSVR2MDl2L00r?=
 =?utf-8?Q?j2/CzmjiYv7dArRrrP1a77k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E494B55CF3CC5E4DAA77C82F59BB80B4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f2c5da-fe36-47f8-5633-08dce301e861
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 16:47:31.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gj3mCrgEsQd5ilW0v2CWaI0Bpd44R79JcY39nOVo61ShaUW3VqWDpw5Gr8OnCKRS6lBiUpfao4iqhfn4J0WhsteJDZV6BnYu87gqdCdaWLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8971

T24gV2VkLCAyMDI0LTEwLTAyIGF0IDE4OjE4ICswMjAwLCBJbmdvIHZhbiBMaWwgd3JvdGU6DQo+
IFdoZW4gY29uZmlndXJpbmcgdGhlIGZpYmVyIHBvcnQsIHRoZSBEUDgzODY5IFBIWSBkcml2ZXIg
aW5jb3JyZWN0bHkNCj4gY2FsbHMgbGlua21vZGVfc2V0X2JpdCgpIHdpdGggYSBiaXQgbWFzayAo
MSA8PCAxMCkgcmF0aGVyIHRoYW4gYSBiaXQNCj4gbnVtYmVyICgxMCkuIFRoaXMgY29ycnVwdHMg
c29tZSBvdGhlciBtZW1vcnkgbG9jYXRpb24gLS0gaW4gY2FzZSBvZg0KPiBhcm02NCB0aGUgcHJp
diBwb2ludGVyIGluIHRoZSBzYW1lIHN0cnVjdHVyZS4NCj4gDQo+IFNpbmNlIHRoZSBhZHZlcnRp
c2luZyBmbGFncyBhcmUgdXBkYXRlZCBmcm9tIHN1cHBvcnRlZCBhdCB0aGUgZW5kIG9mIHRoZQ0K
PiBmdW5jdGlvbiB0aGUgaW5jb3JyZWN0IGxpbmUgaXNuJ3QgbmVlZGVkIGF0IGFsbCBhbmQgY2Fu
IGJlIHJlbW92ZWQuDQo+IA0KPiBGaXhlczogYTI5ZGU1MmJhMmExICgibmV0OiBkcDgzODY5OiBB
ZGQgYWJpbGl0eSB0byBhZHZlcnRpc2UgRmliZXIgY29ubmVjdGlvbiIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEluZ28gdmFuIExpbCA8aW5ndWluQGdteC5kZT4NCg0KWW91J3ZlIHByb2JhYmx5IGZvcmdv
dCAidjIiIGluIHRoZSBbUEFUQ0hdLCBuZXZlcnRoZWxlc3MsDQoNClJldmlld2VkLWJ5OiBBbGV4
YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0N
Cj4gwqBkcml2ZXJzL25ldC9waHkvZHA4Mzg2OS5jIHwgMSAtDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvZHA4Mzg2
OS5jIGIvZHJpdmVycy9uZXQvcGh5L2RwODM4NjkuYw0KPiBpbmRleCBkN2FhZWZiNTIyNmIuLjVm
MDU2ZDdkYjgzZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L2RwODM4NjkuYw0KPiAr
KysgYi9kcml2ZXJzL25ldC9waHkvZHA4Mzg2OS5jDQo+IEBAIC02NDUsNyArNjQ1LDYgQEAgc3Rh
dGljIGludCBkcDgzODY5X2NvbmZpZ3VyZV9maWJlcihzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2
LA0KPiDCoAkJwqDCoMKgwqAgcGh5ZGV2LT5zdXBwb3J0ZWQpOw0KPiANCj4gwqAJbGlua21vZGVf
c2V0X2JpdChFVEhUT09MX0xJTktfTU9ERV9GSUJSRV9CSVQsIHBoeWRldi0+c3VwcG9ydGVkKTsN
Cj4gLQlsaW5rbW9kZV9zZXRfYml0KEFEVkVSVElTRURfRklCUkUsIHBoeWRldi0+YWR2ZXJ0aXNp
bmcpOw0KPiANCj4gwqAJaWYgKGRwODM4NjktPm1vZGUgPT0gRFA4Mzg2OV9SR01JSV8xMDAwX0JB
U0UpIHsNCj4gwqAJCWxpbmttb2RlX3NldF9iaXQoRVRIVE9PTF9MSU5LX01PREVfMTAwMGJhc2VY
X0Z1bGxfQklULA0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNp
ZW1lbnMuY29tDQo=

