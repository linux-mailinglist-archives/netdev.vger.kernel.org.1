Return-Path: <netdev+bounces-146680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15379D4F32
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D68E1F22B96
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F51D9A6D;
	Thu, 21 Nov 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ehS+SLD+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4691D9A42;
	Thu, 21 Nov 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200481; cv=fail; b=Yg97+u4cy1A2Vp5mGWNylmYbnGFXhZ64Yaiuxecgr/EsgqkjizRjCRN/nygYpYz9AMSWRPNMsccmxyWOpRFn76kyBbtAa1lJOi0faIQ4FE6+ir6Cqrl+elgzmDxr3UCNWgzAv53YvlDRnNSFrZ7d/YhZmQVuPSc68ZA+ApRjLZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200481; c=relaxed/simple;
	bh=QviuiM8UUWp5Lc2TRe63RikxJSHHckHfhlv872caWNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mMlMIW3o+NiVplAu2hUAw995qUx6niHjgwsj5paRaAP6aN4UZnorVUj8Wbt/HMFTg6F8A16bM69xRFAK0P6ABOqLx1TRED+8gV27DAo7WYImwlnBP/t4pCavK4RQRG3DKHFSLYFkHP9wruejCgwJRMBFmF2e1G4SRkioeay52EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ehS+SLD+; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHoUkvC/HkrjBr8RFnLsXKDxeCuAT0efYlzyEq8aB/eUm1hQ54mRK14OYOmpui5ApG63vOpWoHN4odQJ+792rcdO1QzQdAlEGIH07wOWiohYZ+107YzM85hBk3hkAgkJbqSspfP8TZNMM6Od7a5nipUxt5W5GVAp3QhP4eaL1WwYTyb/Al/Mc9mWd2TI3VL8D7IWAvH6RfQ058pLf3xWoKcwHcLZXWYR8VT5H11Zh4vjr02VMEt/sI138CirGHANVs0Lyb63MIu/crTiVzZZ7Kq1eillvfpn0C7jFmmpOAer3o/di7iLzJoy+OrB1++hL6+MA5sTEHgM3QG3vyANfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l5F7bR8bfbtOmmwVmneeu/SdzGIhxyJTWfNA8bla/E=;
 b=egKUKvSV7EnFSc004ZHbYAKnCOSTZ4Jb9BcrtbTkGIBOm0VRNFcSvI9GnaEKJhwjeXu8HGRjYDXsNgKu3o+lS3NSHTyn6szBtBhyFBhfAtQHJi822wmpf9FoxlVkD5ntDLvALGtYqR/KUjFcv1kIoE8gDeV5M3Ix3fl+IHKCc5bOR+8ZsxFA4NvBR0Dae3dqJ1B7ot6xL30n+TTXUTDNl9NYoFwOalTinVsE6299fKM9Wfp0rBUnEBr2azMSlB4nx+PH5Y9IRARPOvtbFtaUMZ/GuPrsG5Ucc187puu/cC/+O5SJ5UApmMGgjDELiLd+2wASZD9mjbySr/lcKKe/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l5F7bR8bfbtOmmwVmneeu/SdzGIhxyJTWfNA8bla/E=;
 b=ehS+SLD+OFrCoP2GdVmLGr9A/W4yY0ejz1+S5uQ6V3T9PqjXAo4SXGPW7vqleo8gaLA73E4djSNe+GwYMqSLtuC8sqn/wle1tMDWF+ve+EeaBDSG9Ru7v8GdsrvYOtLo6mtI66AXNw0EO7zDwM7vUO4hxA+w6liser5XC3Tuy/KMxnOvexLidS5/YLsEbKepOy45VZNgEOG7/8SZh+2Ea0QEStZOoQ/Y+3hRbivZQCp6cbMZYTbrGgh4GsuD7L/HefxvkRC2NNz1PBnMU9/qd1EFq8kpgB1+jFGiOfmTZje4SSA6k/5AFO6lV/A2TqG1cbx6sgOLULZWovwe1JkC/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from VI1PR07MB9706.eurprd07.prod.outlook.com (2603:10a6:800:1d2::12)
 by DB9PR07MB7945.eurprd07.prod.outlook.com (2603:10a6:10:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 14:47:55 +0000
Received: from VI1PR07MB9706.eurprd07.prod.outlook.com
 ([fe80::1620:bf68:4eec:61c1]) by VI1PR07MB9706.eurprd07.prod.outlook.com
 ([fe80::1620:bf68:4eec:61c1%5]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 14:47:55 +0000
Message-ID: <ddd0019a-477e-469b-bef7-4e995a532f93@nokia.com>
Date: Thu, 21 Nov 2024 15:47:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Jakub Kicinski <kuba@kernel.org>, Breno Leitao <leitao@debian.org>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
 <20241113191023.401fad6b@kernel.org>
 <20241114-ancient-piquant-ibex-28a70b@leitao>
 <20241114070308.79021413@kernel.org>
 <20241115-frisky-mahogany-mouflon-19fc5b@leitao>
 <20241115080031.6e6e15ff@kernel.org>
 <9cdf4969-8422-4cda-b1d0-35a57a1fe233@nokia.com>
 <9837c682-72a0-428e-81ab-b42f201b3c71@redhat.com>
 <7003f775-7389-41ed-95e5-1e0e07f3f6fb@redhat.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <7003f775-7389-41ed-95e5-1e0e07f3f6fb@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To VI1PR07MB9706.eurprd07.prod.outlook.com
 (2603:10a6:800:1d2::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9706:EE_|DB9PR07MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: d870ae81-3d07-4808-f34f-08dd0a3b7bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVU3T3FlKzhQM0Q3Ri9WTmtvN3NrSUlMWGNHRWNUQnUzVzlXRjNrNTc5WnlC?=
 =?utf-8?B?c0d5dFA4MlB2OUo2R1Q3Z2VLYnRqTVpWc3BmMG0yYnJ4U2dkS2wzMVB1QS8r?=
 =?utf-8?B?V0RXTnRKbWYxYjFwOUhteTVQVHQ2dE8ydWhuQThDVTVtTVpQVVZ0Sk1ZdnZn?=
 =?utf-8?B?OXdmbkR4T2k1R1oveXZLNlNSMkxrMFNvUENOcWtSYko4TGtsRXdXQVZVbDh3?=
 =?utf-8?B?VTJXb1Q5dmUwcGwxMGVOZ2RWV1BhTVUwVXJsSHIwYlJWb2xPQ3BpZ09HWnNI?=
 =?utf-8?B?N25OMG5LR2hCWk5NYUtLN28xRHVXZDZ1Y1B0eG40WCtLSkZIMjVnbCtRQnlU?=
 =?utf-8?B?d0pseHpwN210eXFtcVdubWJrNmhTOWNBdUVPUHQvcVkxelk3WHU4NlExSnFX?=
 =?utf-8?B?em14NUtyRXN4Z216S0pTWnArQzRtTzBEZmlIYTEzbTU4V0UyRHBlODhINWdS?=
 =?utf-8?B?ekN4czJUSStJUnBRb29YOUdqYlBuM2RPc0d1WDk4dEY0bXhlWGhVTkdOa1gz?=
 =?utf-8?B?Rkg3QVpQOS9jdTdzR0tUU04vd3V4Z0U2QWViY0kydFBDaDNCRFErYWJmZWJC?=
 =?utf-8?B?b2FQNDNYc2hOK1BIcU95RHovTU5VbjdleUNsSnBFakI5NkNCaVRFVzcyRUpS?=
 =?utf-8?B?aVc5R2tLUWxrdjdMdm5NOXN4ekErN052ZEE5dEhWanhxNTVBeFJhc3BlQ2tp?=
 =?utf-8?B?K05nNTIxVURsbm5zeWd1VU9hblQyWndxRXRhQ0ZNYmNXeUErQVNXZ0FjQmhP?=
 =?utf-8?B?Rjd5QWxYTjJtV1ZRL0ZnV0l4alNTL25mZU8vYjNINGdsQytISWIrRnY1TTR6?=
 =?utf-8?B?K2JuZEVVRU0yaUpaQXQ3ZVVwZGVlemJKM2tsdDJoUnNGYWgxeEh4RTJJWHdP?=
 =?utf-8?B?RVV3WFdpQkdtOEZRVi9MQ2czam92VldPdTBUU1ZoOEdPbWkwcWUvNk0zcyta?=
 =?utf-8?B?WWczREFjZXFPRlVzdDFvNUswNU1iYnJxL0dZVHJvV3lES0NkSkRIcWc2NmtL?=
 =?utf-8?B?YkQrdnJvb0g5QURWd3FEZE9HNndTTkp4VW5iWU5UVWUwTmtveEVWdTlIQVQx?=
 =?utf-8?B?WmM0QWlydjRsbUJ1SXVET3VOUzNGODh2eFp0QisxUEtDSVhZamtnc0FBVFMv?=
 =?utf-8?B?Q1prYkVFSG1jSG5LNEtrSDRJWHZ6YzBFVUNKbWE3Z3pyRWlheDFhb3YvWC9m?=
 =?utf-8?B?dkZXT2tZbUh4dXhDMWppRVpPUE1sMUZTKzZ5OXN0VHlyc1czcW54L3JvUkh3?=
 =?utf-8?B?LzVnR2hTUlpFdVB6bGpXOWJyWjk3L0lkZDZhQTZoSnBIandUZWZ0Rm92T2xW?=
 =?utf-8?B?MndOakh4VGdrUWNNME45MDAvTFMzTGxxS296Q2xZUW4rUmo3cnNadEN3REI4?=
 =?utf-8?B?ei8wYVFtUFp5SXB1UG5XOHFUSEtJdzcyV3MyVHJCY1RYQ2FlM3AvWlRoLzNt?=
 =?utf-8?B?MVhXWmVBNmY1bGtNSEsyTDhzTTF6ejlJQ3dJbHRic0J0N3FOK0VqOVFDR2xB?=
 =?utf-8?B?MFdqdWVnVld2dWpybUpVVFZWRkw2eVc4Z1laQ2h1NU0xbURQS09KcHFQVmlu?=
 =?utf-8?B?RERmRXhQSzZOK2RycXF4UFlqS0hGc3BzczZIVGtIWnpoSSszYU42WWtad1k3?=
 =?utf-8?B?MTlad2hjVTZDWXNjVVFuTVJ1Sy9NNmVEV2dSVXlXeWFFMnFaNlowRTFxcVJX?=
 =?utf-8?B?dHpIWk01R2k0eWJoSU8wSFo1eEl1c0hGbmZYUmhTS2w4dXl4UmJlRnhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR07MB9706.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzhkS3JGdVdkYmpTaVFqZkhnY0VCYUZwRVBSK0JIVS9YMTk5TGVZNmE3NStI?=
 =?utf-8?B?QXZBcmkwUmFTUnYzZWpJVkNmaGI4UWp1bDdmRXFFRTI3ZDRQUm1LS1NMWUpu?=
 =?utf-8?B?bVhYTTBiQW9SWDc0d1lyV055WTBSNGhYTlBUY0pvZmlBR2JiVStpckI2WW5B?=
 =?utf-8?B?Q1U1MFEwZVRKVnNnMnZjNkFKWDRvbGlSdlZRejE1L1VhY3djSFcvRHJ4ZDMr?=
 =?utf-8?B?ZFZuRFkrTzcreGltNUtMaElyelkyUUpaNCtGUDRsOXBKUlRVY3RPUVBXQmIw?=
 =?utf-8?B?ZVgvMGZIZXhhS3l1Ukx4NU92QmNJNTNVMFpDWUlReFFuamhkM0NyRkpYWGdt?=
 =?utf-8?B?bGNRMFdJKzUyRXBBU0FyV2dQOTBmU2xZSzFlbHNCditjaFV5SlljZ3ZkQzZZ?=
 =?utf-8?B?bUxKRVVHdTJzSG05WDJHcElJUDVkeG9ScWduT3VUYTZFcEdna1VDRXZJTTEv?=
 =?utf-8?B?K1lka0ExRStZQTI4K01pZGMrOFFtd2hUK2NCL1hIbU16L0lyVUo2SmhmTWZ1?=
 =?utf-8?B?cUF2cnB3TWdYM2s0M1oxSUVqWmhEOVR4STd5Uyt0Uzh5TmwvemhSeHBPa0Ft?=
 =?utf-8?B?UGUxQ0tsM1JzOXR2SkFOQ2lpU2tHQ3l6eTU4WERxeUZ5UWZsb0pkTTRsdWo4?=
 =?utf-8?B?K1hnOElTMDN3TFFhVDVoZ1o2Q3FMNk1uZCsySitTbG84MVNuR0lBaGluSitK?=
 =?utf-8?B?UjJZUXRLbEpBZWtua2FqNi92aFEya2RMMUVGT0FvSmMxUDd2dHBxb3JVUm0z?=
 =?utf-8?B?bFBpNFU2NHVhU01UR09iTVJJSFpJQm4vTnVEU1Y3RE1YcWVLMmRZK25zK01H?=
 =?utf-8?B?ZldMYXFHOVZFTURRMFpldkcyZHFIS25ubDdaSldtMXR2aWlqcDFHQ1VxQSti?=
 =?utf-8?B?MGdpM28rdFZ1dUphWVU5aXpQRFZ5d0YxMHhvSU54bHcxaTBsNlJQMzhPSmp5?=
 =?utf-8?B?SFNvUFFKUGRWc3F4VTlnVDcxdW56ckptVW4yRVltOVRmMmFqN21RWlpEdWd1?=
 =?utf-8?B?TlRVUi9ndFRseGJVYk1na0xIMzgzWUV2Mmd1cG1DYy9NSENGWGVCMXg5ZG5X?=
 =?utf-8?B?aFBqUmZidmlDL3ZLcmVOcUE1WVZIcHlSK3VycXJUQmQzSzhBQ29BM0F2TnhK?=
 =?utf-8?B?MDBGbkoxYzBMdE5yZFltRS8zbDAxc2sySWNYdTQzeGtCd2Y4eUVzdzJPRlpK?=
 =?utf-8?B?V29meXpzMmI2OEJFZE9qZk5DaGF2bnViZ0k3czNOeElEQmRpV2NOMkxvd2V1?=
 =?utf-8?B?cGo2aUNjZjVvc3R6OGUvUnpoanlyZTIzazBtdHF0bUZNbW40dENMdnd3UlQv?=
 =?utf-8?B?dkN2SkxTZ244V1RCL0NMZi9UdTdNT3Z6NGxKQ050ME1zRVhSNFlMYXFIUVlv?=
 =?utf-8?B?TmN5VGE5ZHFLUHA3dXJmT1Z6UTM0UlFlWWhDMGpmaytFK3F2QVpqdFFmb2sr?=
 =?utf-8?B?R3VCeXVISnRDZHR3c2JIZFdZb3pTbkUrZGtmYUVSYmhUYjFqUDNGcjdWdmdB?=
 =?utf-8?B?WWYySkE4OXRIRFpqQU8wZTQxNEd2alNUeDkzUFJEbVJDNXhaQ292SlZzUWZq?=
 =?utf-8?B?clpZZjF2U2VBb0M2clprRDM4S2FpZHRpQU1PSmJ5elNEeDNZYVE5Z1ZYYkpn?=
 =?utf-8?B?Z2hSVnNIcDNjNnU1WGloY3BjL1VkMy93N3lPOFduVUVNOU5xb0ZmUGVhWlYr?=
 =?utf-8?B?VXNZcUNCSEtCeWxaTDczWkc5RTdST1JrYmN6TG90TWdWTitNSXhSZUd2M1Ex?=
 =?utf-8?B?S1orOUpUWmlkUS95c0RoMTNxM0hja3NnSU9OVFJFMzR4ZFlTbEtwRW9HY0pi?=
 =?utf-8?B?SWc1c1dXOVVqcldkUW0vNHpIVWVSbWdFV0NzSGpYaEJKU3ZCdTdHM0s4aExq?=
 =?utf-8?B?VisrcGw0Y3lxTFQ0R3B3Yms2c1hDd1BDM1A0Z0gveG5TeUZneURBZGZta1BL?=
 =?utf-8?B?alExYTBESlpaK0ViVjFPUG9xQmRNQ09wUDFyMWtDV00ydXduMGxDYXNvbVVO?=
 =?utf-8?B?RHI5ZllkZUNIN29DVmFhbzVYOGNscTZETzB1N0l3TGRoRzNLek1XZm1SVmsx?=
 =?utf-8?B?cVhIR25NRTdkL0tiNDBMeUJYZFIwMTJkNTFlTU1wd2g1eFplMjhBMUdEb2tL?=
 =?utf-8?B?YTAwcS92dHhObGpQazhwVEs5RE1CbWdTbGRlSXZFSXpkbjU4cStRK09GWlVH?=
 =?utf-8?B?UEY2cEJSak5UWktLWkQybzNHSW1FY3oyOTU3ZHRyQXBPSEZxVUxnTWpXVDZv?=
 =?utf-8?B?WktoS0FydHo1M3VDTUp6ZnpGVGhnPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d870ae81-3d07-4808-f34f-08dd0a3b7bb5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9706.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 14:47:55.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osRkWmdH+psPZrbUT3DJbzgatpaqyVOHe93YwSs5iSq0iW10wWrRE6wKAU73y5BipaADKLyFElp/fHqRJubVF0S6TH99Pwyg8XAcAjCFhwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7945

> On 11/15/24 17:55, Paolo Abeni wrote:
>> On 11/15/24 17:07, Stefan Wiehler wrote:
>>>> On Fri, 15 Nov 2024 01:16:27 -0800 Breno Leitao wrote:
>>>>> This one seems to be discussed in the following thread already.
>>>>>
>>>>> https://lore.kernel.org/all/20241017174109.85717-1-stefan.wiehler@nokia.com/
>>>>
>>>> That's why it rung a bell..
>>>> Stefan, are you planning to continue with the series?
>>>
>>> Yes, sorry for the delay, went on vacation and was busy with other tasks, but
>>> next week I plan to continue (i.e. refactor using refcount_t).
>>
>> I forgot about that series and spent a little time investigating the
>> scenario.
>>
>> I think we don't need a refcount: the tables are freed only at netns
>> cleanup time, so the netns refcount is enough to guarantee that the
>> tables are not deleted when escaping the RCU section.
>>
>> Some debug assertions could help clarify, document and make the schema
>> more robust to later change.
>>
>> Side note, I think we need to drop the RCU lock moved by:
>>
>> https://lore.kernel.org/all/20241017174109.85717-2-stefan.wiehler@nokia.com/
>>
>> as the seqfile core can call blocking functions - alloc(GFP_KERNEL) -
>> between ->start() and ->stop().
>>
>> The issue is pre-existent to that patch, and even to the patch
>> introducing the original RCU() - the old read_lock() created an illegal
>> atomic scope - but I think we should address it while touching this code.
> 
> @Stefan: are you ok if I go ahead with this work, or do you prefer
> finish it yourself?

Please go ahead, I have neither the expertise in the net subsystem nor the time
to ramp-up (since this is just a side finding for us right now) to proceed with
your proposal. I'll follow the discussion though and hope to learn something
along the way!

Kind regards,

Stefan

