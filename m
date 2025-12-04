Return-Path: <netdev+bounces-243569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A248ACA3D5F
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FBB730BA116
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A033F38F;
	Thu,  4 Dec 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c1CkllJM"
X-Original-To: netdev@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012013.outbound.protection.outlook.com [52.103.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE1279DC0;
	Thu,  4 Dec 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855108; cv=fail; b=YwHXmkg+KKslvnk8C2SQzfv6F4+b7KWDR9EEYnevc6BhyI5fvGaW72FrcAqyIxbLZSaPcDooRzuF/OhBse5DZv+bGXTgRYtfek/BcWlc4dYRSOH2p8RbLyml/7uB8qTs3t3uWPZxKdyap1RtszjHbb4JGzL5ptXqNl5sIfoMBBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855108; c=relaxed/simple;
	bh=9c6/aO/7Z/ZPK/JSoGVgInu4hcGhRiir6rXCUYifS/8=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=Z5imrZz+zhw0MCC9Zdu75RwmhIfELi0okUKUzvWi1pmgeBAOaA7Scf4t3AHDIP/ifBchUyS0qCODUg6ivOG7Tcsz8EDRzIVBXSNHUcaWZWPmOyLEmevMY0ilp+TXpgxObVRWUvdAQihnPxUBjgJXEjqxuG3O53B/ypHg4RuHLCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c1CkllJM; arc=fail smtp.client-ip=52.103.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJHQEYvSpuBNBiuDonGmFNEzH3mONgViNRIpv4hYuUHFX2ubW3DESl31hRnuTSaK+kcXD2Yb9g8LnjEvAsac4XWZ/UZHZ7kBcwoSaXYdQ7pkwkEY8MTlY/i4SaeHoVFzmVU4KfY84Bm7n2486gUzmWf9qE/HwKNSu6a8xmVaLRDmRGBA76q+zNG9AWO1oqWjwxHOsiRC1Lj9DhT00jRB4x3DzJfpkCN/XseqmPtaevaiFYqnV/nMUt8CPyH20NnZY6gSDKgWgcxZ6+7gAZHwTC6q6Aq5MordJErMAgnxkYujo2o5UqPOKBiVV3vWwqwJ8WufuSfmS/0uU3nbZXCOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSy7TP15+bupfKmdxXoXFGVT+btBKQr3kjaJDQ4w+tQ=;
 b=PH/ybSL6xl7QzWmJZaj9fuVDw6kzZse749xQ/pIjLvBoSO71enRDypntRiOeM3QuN8KlKbN0ZDpr8T5Wtplc8bdG0FaIs8WVqULMH74eQhMq3/39yn0+1S1MDTZdp0hfM2xZED4a+s+7IzXRy7fiPw9oTUBieZyRk5aTuaLSIurVIN6K/KlYgEzspfjn285zspivoEo8xAElG7UPOVttUaPTRV/JVN0Ieu+/ln37yN3VKEUWWqBwj4rxq1je61rOwyOJYu4942idL8kADt4+jMI5e4iYxiGM8Er9b35F7pW74yj1Nn4jeEESeXgdumFot363OJ5S8Vbkuz20j/qPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSy7TP15+bupfKmdxXoXFGVT+btBKQr3kjaJDQ4w+tQ=;
 b=c1CkllJM43whI4YoHmjoROaFlmhBN4ChX74h0E03S4LKqyDsAp7FLWAb7O499OlqaqgToZDe2U5tVi7o6aID6V5OwP8GWQ03QVVFfFZ7w85ofgi3ghZw1I5xgWbK1SniWfFXjyR9Hl27uR4ZO4W3iZsIVHjbRhRWcJie+y1bFZb3eTZnyB+lRN889yVVoF/QMCP660HeuFSaqW3facfH4OQtWGX1MMPQLvjgdcMPev4wR/MJMBCS3w4lXZBCwSkQE4W/gJUT15LkSZ1zcgwMGLN3xrppK3UQTol4onic+Lnaa/h0Qe5vvE5AlqaOAzHsz4JIZrCbo6PWJncY8yME8g==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY9PR01MB10236.ausprd01.prod.outlook.com (2603:10c6:10:2f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 13:31:42 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 13:31:42 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 04 Dec 2025 21:30:47 +0800
Subject: [PATCH] caif: fix integer underflow in cffrml_receive()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAaNMWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwMT3bTMitRiXSNjY0vjFHOjpLRkCyWg2oKiVLAEUGl0bG0tADuaLhd
 XAAAA
X-Change-ID: 20251204-fixes-23393d72bfc8
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Sjur Braendeland <sjur.brandeland@stericsson.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=9c6/aO/7Z/ZPK/JSoGVgInu4hcGhRiir6rXCUYifS/8=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhkzDXrPU1vnRs5r17zd4zI50z1Gb1z/phZWqwgnVFXknF
 RXcV5/sKGVhEONikBVTZDlecOmbhe8W3S0+W5Jh5rAygQxh4OIUgIlU+DAyHNS0E7lybTe/cPtN
 21PJlssrU/0Wct6tP9l8KvMAI4PeZYZ/SrWTPum5iCxknLOW7ba3Y87ZXtlDbAX2OzSmCcVP6Ob
 kBQA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251204-fixes-v1-1-2238878831f2@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY9PR01MB10236:EE_
X-MS-Office365-Filtering-Correlation-Id: afb68b7b-ea77-434a-43d3-08de3339763d
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnpLok0yW2cCj4p8xhSvSVMEycUOmnqcTXo4k6F6L0HbAXv/kGqYsxRAao++jOyTcSG67gBRbz/TObhts2QLQhPwA96qaNXROGjaQAemD8emcht5dcZe6bb8KjPjDa2LZ47kUEkir3Xe1nbOeL+p0ifiGeCLWcL/3VEnws/dJIDn8votXI43YRxhNMg6oJWpDLr3LQL0WyBastnEDfpChNkxRsNOO2OKO4r+mTNVx6NIJu+c/O9LwELTMbGzrygHxeE0/KPoqRqGLfZjRru6BUnVrbp6+nganC2qmPa4g8JE/johhEa0/9vGzWdu8rMekAlFxiN/IYOVNMoFtKToKbDG9lIHVleC62O/IcdNcR+k4TFClYxJyP7gEqKM1TxeY9Jkxjk8D3cQCQvDx1kF7jUXE1MIsexTcczFdqdnkRT//arw4c5nWpTeWVpMV3IOfdltAuOr8pOFj07Zgs+Cj6n771bvZ4rEBk+mmKdovs7U41YN4jH3GO1ybyGaDbXBeiaJb1pyzOzZOmF2jOVo2fAJHsMS1IfRCBsggd3PC3VW1cO1+HWBkhaaTL6RR9z1Pm/1niqGVmZZHSBplKT37+tu0p1fv92QaE1LmqcZO/xhOyioMghSjeJSnYsmJ4KnDEKn53k4//iIcd4K4LbU5XwLNYpNEAQ7VsXCgUASwbzXFggHr9JsAXKek76CWDsUvQ3nzfGJom9gl9sBWlH4uLe8KPBrRwsRtmyEKcn8kMxkhy2tCRDcTIDyscBCH8KkzbQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|51005399006|5062599005|461199028|8060799015|19110799012|23021999003|5072599009|15080799012|41001999006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzc0cmNUYnc1TkEyeC9hd1hjQVpXVFdmSEs3THZmUHVhR3RHRmVsT29tRnN3?=
 =?utf-8?B?U2ozK1RpMUhaamRVZWtMOHBCUk05RzF0MzlmMkRGcDNtUm1EWkw4V2dyV3Rv?=
 =?utf-8?B?eUZTTnFXZnkxMFEyU1RCd1MyZklQTHoydUw1MmhMZVZjV3l6NFUrd3F3TDh0?=
 =?utf-8?B?N29BbzlUekZUbmx4clRudzNiRkQ0M0NnbXVCeHBjUkp2RGhMSjlwSVJIOFpT?=
 =?utf-8?B?T094R05pV0lqcHg0QmFYdGNlNUdkczRqUWM4UkphRXQ0cWtSK2ZPUFRyalN4?=
 =?utf-8?B?SjVPSEo5eWFvSjdobmUvcTdlM1dvdTdDZHdSSkl6NkJ1b2dLRm9yd2t5WVIy?=
 =?utf-8?B?YUVZeFBhS2ZlR0t2NDdiUEdsS3VmNG5qSC9KbnZidHVTNERSc1BzcHlDUFJO?=
 =?utf-8?B?RWhPdWFyWXdsa1M0TnJYSU5FWEgvRzZHZnc0OHVST2V6eEZrcU1LblVZUHFv?=
 =?utf-8?B?U3FOaVJkMDU2a2tZM0dUQWxhRGw4Zm1YVmZGYjR1aFUrZlYzRVAxTmFLTER3?=
 =?utf-8?B?WEV1T1ZGVXBBWUdOMzMxdGZIMEpDMmZvM2EvallxNVRhYTFrbXI1TlVkUThm?=
 =?utf-8?B?amxObjhOclhtNHRlRE9UOWJSUE1LVFVVZjMxdmdmT2d3SUVQVFZzekJHektF?=
 =?utf-8?B?Sm1nQ1ZIVTZkUXRTaW56KzlpOEdoTkNFRHNyaTJoKzhkV3dSWUZjU1JpNG54?=
 =?utf-8?B?by9WazhXVzBYMVRmenh4ak9iMFlMT1dzcEpGR2RoZC8wR0RZVHBhYkEwR0xG?=
 =?utf-8?B?UndMb0trY1ZUZEJEVFhVcFlqK1JMZldnQWxpV3U1VWdiTjJCRFJ1RGRkTlA0?=
 =?utf-8?B?UHJsODlSVGN2RmI3Unk4bldBYzg3U2lRY3JnOGRGVGptSFEyejc2NW04OGtN?=
 =?utf-8?B?ZXpKTTVocVNYVnMvRXcvWGpOaFlCczBtcUJ3dmplM1hCM0xiQkJkZ3ZxTnN5?=
 =?utf-8?B?U0xUWFBQUHEwNk1uQVpZeXlYaGNKWDJCRmtWV3RPS0FtZ3E5bHBiU3hVZksv?=
 =?utf-8?B?emo4WmthdEgwNnRTZmlzaUFEQUdXazFna3J2eVVDeDdiV3dIVlhuVkpoVGJZ?=
 =?utf-8?B?V2NMcC9jUjNDR01YQWNRdlpXaWNQZ3NJSCszNE1aV3I1S3IyQ01Vb0ZrcDBj?=
 =?utf-8?B?OWgxV0hnR2Y1SnB3MXNZQzBlWW0zYXJBcmRYNnpvMS9KMis5bkpjMnB5UVdM?=
 =?utf-8?B?Rlp0U0NLalEydVNkKzhocnA5cG1BU0tOVGc3dnhMSzhPejNvY2FHUGdOU2pR?=
 =?utf-8?B?WGV0VDNGd2o3dXhkY0hpYWJWcU1BbEpqQncvMEpha1VaQThNeldRSlMrdUwv?=
 =?utf-8?B?NUd3ZEEyeG9ydXVka2ZESHFjclhhd2s1QzdoUE85VmQ1VmRaM1k5OGsvb2cx?=
 =?utf-8?B?aTB3MmpveEk5c3hUTG9SeEJIY1drb0pFZXpPWFdYY3J6Mk9zYTRZSWR5WUZF?=
 =?utf-8?B?c2Qxa2FiV3RYMDA2c3h2M00vK1hESlJYN2hSUTA4SmttQnFSWmVZUXByU0FX?=
 =?utf-8?B?OHR4M1NQZDhmc0JqMkhKdmdtU1F6VXRDcGFKaC9UcVA0c1lQay9mVXZXS3dj?=
 =?utf-8?B?Q2sxMFVSdUFoZFcwWC9PRS83ZXdMNWMwdXI0UWthaWpkamIwNmZWeHFoYVRU?=
 =?utf-8?B?WWRGcmJVNXdJeC9xMWRrbU5JcTFtcVZGZENKZlVpbjlkUU9HMldPalZNaUtU?=
 =?utf-8?B?ZnRoWGUxT0pwdE9PUEc1aStsMzZvNnl3NmJPL0VFY1M2S2lVcVdsRkM0WVZu?=
 =?utf-8?Q?z6Y0Tx/kAgA+Q6Jc+k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHdDWlJLc1VoMXRiL3Z6YU5vd0ZncGlpRWFLdXNWazFERko4ZkZzdzFWM0VD?=
 =?utf-8?B?QVVPVDd0NWFPZ3E4UnB6WHVldW9MaDEwVk9DWitQOGhjUmdta0JKLzFyemxC?=
 =?utf-8?B?YUFqcGxsNVNGZk5ISGdVbzdpYWQ1a3E3U3FLZWFObVEzZ0dKQzBlVDRqeWRv?=
 =?utf-8?B?MkViaTM3eGtCMVY0QXB3ZmdJNmxkRlNjcGNIR1FoNWtSaXRxZHh0aTE3VUhu?=
 =?utf-8?B?cXdQZXl6ZDcvMWdlVDZQbExUQ1gvSkZFVlJZYUJxekR5QUNmMXJtOE52V0ln?=
 =?utf-8?B?d3NSV0haSDhjK0FTM0NnWlhFai9wTWJnK2xBT05YQUxhcm9ZcWlHL24xRzhM?=
 =?utf-8?B?NHpVeEQyb2VsZk9PY1ZEanNyamZicGRNVmZQRllzNkFYWU1pcmFwZ2YwSjhz?=
 =?utf-8?B?eC9DT1pmdDl1RnRDRGphbmgwR2tWR3RtS3p3YkoybkZyZktzN3R6WUhmek1I?=
 =?utf-8?B?MHhsVEFvOXMza3FyTmVHZjJDdFBFM1Z3L2o1NlBhR1k2T0l6TTB2RWprRE9Z?=
 =?utf-8?B?TWJLTmVMK1VXc3NOSTVBTHcyUjd0QkRsZVZPcUFERHJ1cXQ1eDROS0JPRU5U?=
 =?utf-8?B?R0pHZ3g4SVhjOVB4b2RMUGpiTmVGZktkNFpNSjE2Y3ZJU2FKL1VyNGZPWXZo?=
 =?utf-8?B?MDFmQ0xISXpldGJONHFoOTZvMDZudDBHalVrVGI3b205NnU4bUJaSDdQcGlB?=
 =?utf-8?B?UUxQNzYwSHo0T3FUMUxQM2EyN0dHMk9PZ2ROYTVQMWdsVDEwYVN0TnJISUhK?=
 =?utf-8?B?SVlEZkROQkZEeVl1dytnb0ZKYU1EUnBhUlRhek9Ec21tbm03dlpvMlZaWWtX?=
 =?utf-8?B?a2p4dkdUNkVxcUZsMnUyY0ErWWRhaktEQ3NVd0s0RVorWEZHT0I4N3ZWWFdG?=
 =?utf-8?B?eDZkbnhnSHFIcjdWS3BQSE55QktwWkszMXpkcTJIWHFGT2M0eVRpVzZvVVNi?=
 =?utf-8?B?VUdub1BPQ2dGdHY0d2ZuRXBsSVoyU25rdWZvVGt0NTkvcG9GWVdFZVdNa0ov?=
 =?utf-8?B?cS92dEpSZSt6T3hCWU9pSE9zRDE0MHFCZU05RVFqejh2dGJHRXc3cVBtTnJp?=
 =?utf-8?B?SnNXcmtxT0dqUEtkMDNrUjJmblhuQ0tRWnp0ZjdOdGEvMUVKNk56cFE5dUdq?=
 =?utf-8?B?US9Sb1lBaHVxSjZTWWd3ZXg2NEdjOFRwMVhBMXIvOVNGVTZuL0Y1YU8xL3F2?=
 =?utf-8?B?b0Jtbk5sMnhWR2hQdkhmRnNXVkEzR0tXSC9jSUhleEF3QUdSNHRCTHpXVkNY?=
 =?utf-8?B?Yk9tNE4vTXVrS1VvamZ4VGJmQ2hxYnBzcTA0TG4va1RGSVIrcHJaeW5vQnZF?=
 =?utf-8?B?TWdqZFdNUzJ2ak1yZlJUYVZPK0gxMC84bVplNU9KL1FCblN6YXUwZGxsZlFw?=
 =?utf-8?B?S2lRWUhyRUhnZzU3aThjNUNRZDFyMmNWRU44TTZSVi9RcWRyQ0VJWloxUVpN?=
 =?utf-8?B?eWNSVjZvOGtCRStpSmdIYkhDVXY2L0h0WE5yY1pndjV2ZFo4bDFQcXhoc3NS?=
 =?utf-8?B?TFAxd0RRRWxKdHBvUmFBczZCUDdibVZOc2dsRENTUUhWQlNiTWNsUGU0T09i?=
 =?utf-8?B?aFVpSXhoVjR4V0RsRDQ3bEFHNzBYUVU2Y1ZGeWFNalcrOXc3bEg4OHJ3TktV?=
 =?utf-8?B?UDlDamo5b1ZoWkk4WFhPNHRtbFJHWWxHbzhxTWFPTDI3TjhQcFEvWWdud2hV?=
 =?utf-8?Q?w2ZTTzWj9h8Br8Y4xwDN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb68b7b-ea77-434a-43d3-08de3339763d
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 13:31:42.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9PR01MB10236

The cffrml_receive() function extracts a length field from the packet
header and, when FCS is disabled, subtracts 2 from this length without
validating that len >= 2.

If an attacker sends a malicious packet with a length field of 0 or 1
to an interface with FCS disabled, the subtraction causes an integer
underflow.

This can lead to memory exhaustion and kernel instability, potential
information disclosure if padding contains uninitialized kernel memory.

Fix this by validating that len >= 2 before performing the subtraction.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 net/caif/cffrml.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/caif/cffrml.c b/net/caif/cffrml.c
index 6651a8dc62e0..d4d63586053a 100644
--- a/net/caif/cffrml.c
+++ b/net/caif/cffrml.c
@@ -92,8 +92,15 @@ static int cffrml_receive(struct cflayer *layr, struct cfpkt *pkt)
 	len = le16_to_cpu(tmp);
 
 	/* Subtract for FCS on length if FCS is not used. */
-	if (!this->dofcs)
+	if (!this->dofcs) {
+		if (len < 2) {
+			++cffrml_rcv_error;
+			pr_err("Invalid frame length (%d)\n", len);
+			cfpkt_destroy(pkt);
+			return -EPROTO;
+		}
 		len -= 2;
+	}
 
 	if (cfpkt_setlen(pkt, len) < 0) {
 		++cffrml_rcv_error;

---
base-commit: 559e608c46553c107dbba19dae0854af7b219400
change-id: 20251204-fixes-23393d72bfc8

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


