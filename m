Return-Path: <netdev+bounces-189616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19229AB2D0E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919BC7A3598
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4A216392;
	Mon, 12 May 2025 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="iBmgavYd";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="DAvClvSh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BCA211499;
	Mon, 12 May 2025 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013309; cv=fail; b=shX3ltIZ0oRq4lNN6W2amQ6iClAFtQwnIfQ1Y1ip4wfLQwO+p3bz3BtC5UJNADzqX21C5xMOg4yEBbF94R2Fx/7uGWAqUobGpcC1csnUzj4x8iuUcl1aVs1uykO2QRI0Yk2JDGq89EheyiNHwxe6PsVpoFQRKCYF67pP2rvpRA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013309; c=relaxed/simple;
	bh=HcMliIS3j59GG+DIVMMKjHXvBw7ZwkpvyJxIPtoMdPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKn1yeMsg5R+076QArOBuWJT2L/4ZTLXOo/VpeIHeyhaBIzFkB4iih6/sShG4cr6E6d7IucfQAHPMYulPTHbsL+5k08aT0aindEsrYkO7LAHleo9TysYMWVAm6KalerEisWKMcATz3IVsrqEuGArRX1ZA2bXKxqXA63NhbvWlk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=iBmgavYd; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=DAvClvSh; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Rt027700;
	Sun, 11 May 2025 20:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=eqkql/xxfdoWTqO4kVd2ir53xSNoqDtwUtYMRE3XKGE=; b=iBmgavYdezAi
	I2h7a7JrtfbViWEpiMjBidTt5N37IPFkQBrgJ39Lyqhuo/RtGWb1rKjSghKcn9qG
	iZuncoBsykqx2xjG3KDlWz36kr+C6qC4/KcoKe7i66daoZg2bv78l4+Us1mYOECf
	vtqWeD/vMvxp5q3Ln91qsNd8kkihgjqbtnouNnCcVzOHCTYB7LiUl01kiUl5cyDx
	ME+PiE8jzOf1PIGzD6B63XcJUycLmPDicx2FAi6CMCmzZSwHgwrA13VJsuovzIvd
	cew7Cq03Vc/6ysUmK73Je/DxO8DiUVcFwIPvEPF+3vd9X/RxWT9rlLV3/jz/44O3
	TCtsJ5GQtg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsHKVAeIrt9SjYl89+qCOQq4zVCZNGcnnLVbbIuNrWqc57hob0uYC/S9x0/wvKJrhchTuLRfMsys9QsFvRippwkCXAi+CXEOs+AMEm+jdAjlLDVPObwrfJoe0poztFhJAKBgmrfv98A0+oDFQTSzbr/MXVJMpZ85ikKTNewE5uAS5coLCedrAyZylaQbhqBzOGX5do7k6hcFEUUC65LEKI2mIxIvPh8Bt8BDJMrXI1twE58bHS0Vabd8KSTj2uEXwJmRwHfk3yBmEcvvqRHtB3EDtAWkUGjlv8mDE8WQAs3tO/6751hpuvm3BiNVQF7ecPmvFzc2T2ieob3rHFk6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqkql/xxfdoWTqO4kVd2ir53xSNoqDtwUtYMRE3XKGE=;
 b=DBlwhkcW5JyLSKnh0P2QmTjGaqPrRTfROs8a8DEEijutVRJ8yG9Tl1Ou/AF6TeMEp3PfAJnUEU1NjvM2TWuiYny3Ph7cPFW2O7fjvKJSdBDgfnBdvLyTsSlO4KTOx2R5Jkm/AmimNTJRJK2OsSgsKSpEDlRkbhjj/VCVZFcqb53gVEy+mYQlX3chQG94zop2S2MKXR8OSe/h6pK+R3MwKBHUcds1FIbV3kOd/brnPsVfKJIXOxsy7SaANEZhL234DpP0xFPXOwXDIYFAclpA95QbLtpF8dttrTpszKKHNOU9PaQqJKcDMH9TpCRUhCJ4/rArAQ/du/rq3C87fckfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqkql/xxfdoWTqO4kVd2ir53xSNoqDtwUtYMRE3XKGE=;
 b=DAvClvShdywnDsvV+rJaQUehOrEIHndolnP61xPSynS+PQk4iSrFsENtla/ahU3TIE7u/Q8EczLPNvPg+4SIYVELidpzJ2MceMsPus6R+MTM7UsbX6ZLbCxzndS5vqlqw/t7QY+cB8jyBbxfWnn5jo1buNh9peEMuYXebhkjKQg=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:06 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:06 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 12/15] net: cpc: create system endpoint with a new interface
Date: Sun, 11 May 2025 21:27:45 -0400
Message-ID: <20250512012748.79749-13-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f19c9c-a967-4f7b-81ab-08dd90f43f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHEvd2QzcG5YaGJ6NUYybzFlNDZBK3NyV013YkZocXRwbDNMUlVDd0t1ejRP?=
 =?utf-8?B?WE1BMlNPTlR2NWdOa3A3LzU5NVlSaUU3QnIxaGc0YmI1dW5RZ1QvT3BiWUVC?=
 =?utf-8?B?WUJXbWgrOVB5d2JVajNmY0Z5c3ZFdUpKTGxzalplcHY2T1c3aUV1N29GZTVX?=
 =?utf-8?B?T2Q1c01KM25lb2NMOS9nK2I5bU1LSUdHTzVjaFpOVXRCMGhDTis4Q01XZFRN?=
 =?utf-8?B?Nk5MR1JjVyszMzJIVktSV2RoV2NKQWx2cUFRTEQyRVMwbGpYVnFxNlB3Yy9K?=
 =?utf-8?B?QWswTkUzeW5DZDlOMmFNTnRkb2dDOVA1SWx4eEdORFN3YTJZMkVlS1JiSURR?=
 =?utf-8?B?TFY1Q1JLVitmNDZBWG9WYXdsRVpKOUhKc09VRVllWUVKQW96NHRDVUdKMTBI?=
 =?utf-8?B?N0Q5Qnc5bWs1UjJ3eVBLN1FZZ0l0dUgzNWJMb3g1YVhQc0dKb2txVURlaEZw?=
 =?utf-8?B?cmVxaGNMdzdBVFZXcHFGVUpXRjRSMWtiWlAvdXBKSHhBWGYreEFackFZRGJO?=
 =?utf-8?B?cGExUkd5ZUYxOHpTYi9sNmJrN1ZqNlkwL1doMkltVFpjNU1kOG9qTG9jUVRm?=
 =?utf-8?B?SUx6UFVKaDl6YVZKcm9IM2Z1UkNuTEJ5QTlzTytXbXdKTUlnVFRDZjkvMWpB?=
 =?utf-8?B?OHY4T1YvWWVjWGlGeThIQk5UMlRxYmVpT0ZaMTFzcWNjbVp0MVFRWjBDSkkx?=
 =?utf-8?B?WGNwbjkrVmVSQVArZU04QTM5dll4KzNCQTlJbGNCckU5RHRqc043dmFqclVp?=
 =?utf-8?B?ejVQZDh0SWNZMUNmV1AxMjFMOGlkSy9kejNEak81MUdvbWNHRWJsbWl6bE04?=
 =?utf-8?B?S2cwVGFxbHBzNDJSOTNrNkx5K1c5a0c4S1Jhb3Y2V0lTQUEybWs5V2twZStJ?=
 =?utf-8?B?Wmp3NTRRZDdsckh2NnQwTG1MQitBcUJBWjR2Q2VCNTFwWEZ1MkNQL0Z5bnU2?=
 =?utf-8?B?eWZiK3Z2ZWZiTG5aMUlKWndJTDRlaE1aM1huWFIwMmU3YWJDOTFBK2V0d0F3?=
 =?utf-8?B?dlY0dGV1YUJDcE1idVdsS0d0S29VZDUvemNPVmxxbFlHb0h5OVZJTmdxdUlu?=
 =?utf-8?B?NkdURE9IaTZlcnljZVlHTThPUkw0clFvejYwTVdyRGFHQ1NRaitDalFmcnVU?=
 =?utf-8?B?S1hhUDlQaTZ4MVBodGU4cXZzZTh5OGluRTZSMC9nVXNMN2ovNE5BM3N3cDdt?=
 =?utf-8?B?NWZWcUtLWnQ1L01DbFIxelQ5UHE0dTZzTTZkNzRUdXo2RlB6ZURCRjJ0UExx?=
 =?utf-8?B?YTFtQWNoaUpLejdGM2Y1MGhjTUY5V0ljc01BSWgrNlhmcnZGelZMNXludnd0?=
 =?utf-8?B?YlVuVjhFemQ4ZzZEMzE0RFAxWHhuWDdQZ1YwVlZlaGE2RFNkd25xNEdRQWNX?=
 =?utf-8?B?czJnZEZMUnIwbnhBUnRmTE9OSXZQQjNkQmFvRG95UUFaYlhYTGZUdjRCL2F2?=
 =?utf-8?B?YWE1Z0hwWnA5R0l2NFBldmhIS3Y4UlJBT1hLVGkzc3N2V09paW10YUZvWVNx?=
 =?utf-8?B?N29JYSswT3pQZEhxS3IzUXV5NjFMRkVLYlJCK0pjS05QcStrTmhLN3I4dGVa?=
 =?utf-8?B?VHhXWmFhK2VxUnZBV0tCRTJCQTRkRm1HSGthMlo5Tm16L1FHZVN4MENaUXBZ?=
 =?utf-8?B?RG9OTTVQR1MyMnRScVFNZGFYemI2YnVNUytkV25Kc0E4N3BTWWplSHNFV1ZF?=
 =?utf-8?B?Kzc4TTBLbjVWT2Zackx3WVptU2hiZlBZRE1OOUg1SWNpeGY3RzZhRkNxV3Vt?=
 =?utf-8?B?T1k5cGN4dDZDUGFQdG9kWEVFWlFHSFdXMC9wYTk5Y0t5djg3ckovb0xxVm1Q?=
 =?utf-8?B?c0lCOG83OVc2TGJ3VFhEUjlVdkIwZWd1RUV4NnR4VXZubCtxSXVRS1NiRVov?=
 =?utf-8?B?bGgvNWhCVDg1OWs1OHZiNWxrL0JwWXdGdzBpR3kvU1hzUTdPMTNxOEFCZnYw?=
 =?utf-8?B?SFVhS2xlVVNWbkRUb1JSYnZ3MUNMVnFRbHd4UVg1Q3dRemFJR0RKd0htT1k4?=
 =?utf-8?Q?uFwFi9JBFqEPKhIlmhBuUzoZ2cpkv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE5OSzV2TCtFT2gyaDU3WmlkeGd2N0hwbEZQRXpSTFlZQlV6WDFCQ0ZpdTJJ?=
 =?utf-8?B?NXdYOEYwZUt3N1U1Zkhsb0NyN0g3WklJSjRmQnNsVnNkU2l1NFk2OFF4Sk80?=
 =?utf-8?B?OGtFMk0zT1hXNzJHeGdCODYwNTZKMzcxcnQ5bEZFTmZvdlN0RFUrOWJoYWQ5?=
 =?utf-8?B?ZjR6M0Ezd3IxUlo0TXNtYklLV2t6c3FaSUJjVkRDSWdKckE2aU56RVRDaUxt?=
 =?utf-8?B?U0xieEQ2SytCNkxLcmFjN0JmVGthSGdJTWlibEErTm82Z1NocE1mRU9UeTJY?=
 =?utf-8?B?NlF0TWNUdjl6VE9uc04zZWN0S0UraE1DT2NhZllVWDdVMDFKdEZXNWs3NTlR?=
 =?utf-8?B?S1BFUStOTHdQYlAwRmVVWWRMcE1iemc0SXI0d0Y1TUZhUTBBWFZMYWtPd2E4?=
 =?utf-8?B?NGZGeWJsT2h3WGdKTEtwbmZOSmtyNG1vSVVIaDViaTUxZ3F3c1haRlpOUk84?=
 =?utf-8?B?YjgwWFdyZXpkbFNuUmVzVHhvWkFJVG50MWlhcHIzeHY1dzhoRnZMeWtDeklY?=
 =?utf-8?B?SjE1R2M2SGNLSU15MXVJMHVUZGt0SmMxRzRnWG5oNkoweTVVZVoweFVqdG9S?=
 =?utf-8?B?MnhEV3NMOXpWVG1iUUNJWkYreWNzWnBWaDdoQmszZXprQzlJSlk4djluRXdy?=
 =?utf-8?B?aWloc20wSDlQRHQwTjdaQllFdE1mSEJsS05UTjdOckxZc1hrb05vTFp6SU03?=
 =?utf-8?B?TlgvTWc1Y2tCMFpKVWJseEM5SHEyeGZrSmdqSWZabG9aVXc4N2pOR1dFWkM4?=
 =?utf-8?B?elAzdlgyUUhUNWM5NHduZGwrTVJIZGVvQjA5cTlReXo5WFV0UFdYTHQxYzQr?=
 =?utf-8?B?MEllRlljZC9PazRmczArUzlIZkRoYTI5Q2l1QjZBWmxvZ1FUdFRpbHE5dTUr?=
 =?utf-8?B?dHg2OGpBWXBhVlF4OG1xOW9wTXE2RVN4NTJJNndCYzM5a0hpNUoxekQxTUJu?=
 =?utf-8?B?SGphODdtNzBvWEV5VGZVTlJKU0ZyalkxQ251Y3NEYkIrOUNmSHJzditLTU1O?=
 =?utf-8?B?bGY0THYyZFR1YW1yTFRDdjY3bUVXSlRoOEM4STBkNXJ5bW8xanJTMjlWUHU5?=
 =?utf-8?B?eHRKWnUzU0xTNm1TNXdLcUtiandzejRRdmR0b3MzOVprSTJEY2owWVlmeUJ2?=
 =?utf-8?B?L1BWb0FFWm9PL0p6T1Qwei9YOWw5UzZMUlR3a0VsZm4va0ZTS1BqNmJvNFZW?=
 =?utf-8?B?dnNRTUY5SjZ0ZmdqbzNlRXNLZGZtbmVKY2VPVGdYUDBCYTRXdFJmUXdLUXh2?=
 =?utf-8?B?S0RLRlJ2ei9QK1hEdm5EOWFYa1hRN0N3S3FBR2k1NlMycGJFMG5ueGhGejlh?=
 =?utf-8?B?dkxsQVNtbGJNcEFCc2J4Y2lDWExWNTd1TXA4bDlieTJNMG5CMUtJK3hnR2ZQ?=
 =?utf-8?B?bjU5cWVRdzE4NDVuN2tEMUE4bllpK05vRW90dnpSSFg2OUlTTDRSWXRtRGxr?=
 =?utf-8?B?VlpZR3pHbGUySkpLcHVja1h5Z0MzTXZtRHZraUdGaHRZTmNUQTh0MkY0c3c2?=
 =?utf-8?B?aTE0cDVtam1vR2hCZ0FRWkwvdzNsZzVSc2hQZUNJM2JWSjFWMkdCL1RYeU5C?=
 =?utf-8?B?QmExNzZRU0pGM1dZRlBIRTFFdllPaVI0M2NiNHFmMFNXOVloN0M5Ky9YVHBQ?=
 =?utf-8?B?YkREWi8wQlRlSjFqeUFrVnVNaktyT2o0RWZoUTdlY2xOMDRkRCtTL1Q5Y2Z2?=
 =?utf-8?B?U0ZEL0djMWdhU0ZwL2JpbXRQUVVqREQ5dWtGUStwL2g4Ky9saEFWTUdtaUlC?=
 =?utf-8?B?UW11c2YrdUI1VTJ0RGJpNDBub2pPaS8vTGE0RFA2emNPb1hJZ3RYS08yS3pk?=
 =?utf-8?B?aHBxRlpzazJCTEhQa1dFRnlLalFzQkNJTGptWXhUcG5hRzZ5anRvVno4R040?=
 =?utf-8?B?RHcxT25ob2hiU2s0OUluNXVldkRIS0pLc2dnMnZXcHJFZW5LdlJteFpzaTFw?=
 =?utf-8?B?ZjZmRVpHc295b20zck90cXd5YjN4OXgybDQ4b2hrNkNPNlgxTTJzZ1FsdWhp?=
 =?utf-8?B?bUV0a0Z1aVkwNHBSS1hTdGl1R2gzaExIZkVCOEpPVWFzd1Y5MzFTTUdtOWMy?=
 =?utf-8?B?cjhUTlMvS2NOUG03OFIzTUF4RHh2c2I0eHZzTFhwS25SdEl1Z0xIc0tSektq?=
 =?utf-8?Q?vNE7hd4gkHxtW7jUGsu5GMv6O?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f19c9c-a967-4f7b-81ab-08dd90f43f46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:06.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTlDq0tHZxhKkcz+C8FrBt/mIGJBGRNY+V90jRhSPCbdE/Yd/949rZczvPhzVg/V67B6X3FS+SRex5tUIkQiTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: -8deuHCCk87VqSWhX1vXWfEY2bnY97OY
X-Proofpoint-ORIG-GUID: -8deuHCCk87VqSWhX1vXWfEY2bnY97OY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX/bI6xzwiONV5 K6LjehrlF4kSB/coWziWwMOtheJAwQqpM3Zr7mfOeYEjJQr3E4O96I6AOcaL7wuyfjvbrqhOSqa tVNYoMuxR6oOwrdBqe0KryjY65RoAVbOMfThsLHVfyG7Z+rpfgiVMrpioPro+hZ4kFdB+19jww0
 1OT0q0ro8EzW0ssrmGN0rEXZ/5VO+2tNHqwP8rCv+pjGGs1S6hs/mEr/tuoP+UB9QxEpmW5Ja97 3yli6BHZ+m2D4fJ6W+Cu9Ikl2bBFsrTYcLOPIjDdtLBBaJPCBl63ahqETAwCUuBkJvzOX5n3YMx h0/EA91Fw8dKjQVpnsjXZbWaZe4iaNcQVHNPndv67W0BxHrySpTSr74m2Zr09kM2lOhUu6JOL6U
 I7J1OJYygv0bCGwYA3yAxVjbJYnwsPHRI9HAxjDt6JDpINC1CHqmTj4Ob9CgqQ/lJtFgwMVu
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214eaa cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=rJb1O5Hunsf5rzLoQWMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Without a system endpoint, no new endpoints will ever be created on an
interface, so as part of the registration of a new interface, create the
system endpoint attached to it.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/interface.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
index 13b52cdc357..dec4c9be3c4 100644
--- a/drivers/net/cpc/interface.c
+++ b/drivers/net/cpc/interface.c
@@ -9,6 +9,7 @@
 #include "header.h"
 #include "interface.h"
 #include "protocol.h"
+#include "system.h"
 
 #define to_cpc_interface(d) container_of(d, struct cpc_interface, dev)
 
@@ -143,13 +144,25 @@ struct cpc_interface *cpc_interface_alloc(struct device *parent,
  */
 int cpc_interface_register(struct cpc_interface *intf)
 {
+	struct cpc_endpoint *system_ep;
 	int err;
 
 	err = device_add(&intf->dev);
 	if (err)
 		return err;
 
+	system_ep = cpc_endpoint_new(intf, 0, CPC_SYSTEM_ENDPOINT_NAME);
+	if (!system_ep) {
+		err = -ENOMEM;
+		goto unregister_intf;
+	}
+
 	return 0;
+
+unregister_intf:
+	cpc_interface_unregister(intf);
+
+	return err;
 }
 
 static int cpc_intf_unregister_ep(struct device *dev, void *null)
-- 
2.49.0


