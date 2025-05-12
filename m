Return-Path: <netdev+bounces-189611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45008AB2D11
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F61189D329
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3820FAB0;
	Mon, 12 May 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="zSaJc6I3";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="WDaq3mKi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989920CCD9;
	Mon, 12 May 2025 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013305; cv=fail; b=l71+8f7Rp1sjAYDMjTfn0TpR0moY0XmRHIIEQYpPaYvsJo2bjJvU0Og1909GxizMd+YtBxr7rhgeAUVpuVUpiPsXWBKyrpM1eX7eiRE0g2O5phUtYU4iFYIjs4ncfJ1ncE+Wm0bImeRwg5sgTHLmgdl6y5q8xB3DD072Wda9enU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013305; c=relaxed/simple;
	bh=aMS60t9zTRBt0XOMx8oIpVYR9NRurNUNAmPRcoNlJHo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJXaHq8EHy0Yl4DYpZzHOCFAtvgN/yVswg9SXMr7Dlq43u5ar1s822LTtF/psf2TBUDDSnHQsjzeAMe1ZDH7JAR6K8eCcrpmTdgb9K6VGOpooOFbXdN2gaIdaqJypAK6yK1fER6kOOSOysR54rcFtbIQwFO3OtK1HDm4JR+k58s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=zSaJc6I3; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=WDaq3mKi; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BNrmxx027097;
	Sun, 11 May 2025 20:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=jXjqROARcWrGFd7jep7SkaphFr1yP5nAdM7FauGXBl4=; b=zSaJc6I3/a0m
	mHy+yt44E8SnOFCtJK0kQSFFrOoLWT/gj/a9Gu2pHEuXKl+v/YZnk81y+70DlRbB
	hExSi0DMBXmXvXNCe8DD7hEOJceBZAkTi12ty5beecTH+OY+kgBcMMEzIZ4to+py
	1TqMpnL3Zw1BNOD4HujYQDvUzoFlyzsfySYFlTPn2J1WbrebmGGznTzpjjr7uvh0
	RoxOsH0gKIer21OLLfGGZ3XpXMuUABxAnmoPoLvrYcwPNBvUtK6biRSM1YmtqOM5
	iUcJ8NeOySzdwGGH405KDTFJeEXBs234Qk6CVVsBGc9cEbelpzNVjbyzlXwk3Sit
	+qchezFrDA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j0aahxd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3Smu8XjhuvGc0aWuZaDfZkdzYWFFCFHDrxogh9QdDrl5q3vgdSd98RB28NNr5YYG4w598EeNz53YRMpJwGojGfDAbigW4QzMkBfHHt4YuwzQmQmicSQRR2Hgfx5orGsefyiZXJ7uq/wj5jaKJqlLrjGDCVsbP1Xz8QJsFz7bWHsR4pzDzDITaBk5933KSCsb1wjQPAhE3hg0uN7ivmgJMLbmu+w4c0hKPZFJxenEH+7fGIlmLnIzBkByKSI0khVvozqv3G/tjYzCGEMeVTpYetX8farESxXlbNvzxTtmBOMv8RQi/pk5qTxvKm04WZm6vvFnG2hrAz6Nk2inVXGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXjqROARcWrGFd7jep7SkaphFr1yP5nAdM7FauGXBl4=;
 b=Jgw/IBBNC37UnkFLbw91sil3xHfSacV68aODJk+ByzdaLAj4vHvS7j3OmnGhWD61zeglkzsQuRYD4zcME6CWbZRAyREbzEXkaZJRvdMukXPGvdUEWGV6QmwTfQIPxwATD4FGe8CgmEnEgubveBuG/EdJPiXRAv8dQi2o/z/sogJsDMR3V3LoICOFVa+K8QNuxb0SjCBVP1aaI/lsuYrLauGwA51fhpMDandLTQGenHDrJSGTLHM55sCgQd6h+K1z1+mmphuF/xSjWmhNAhAW2mLdBpPibN+nIM5izgINdVkuJRF8Dq1QvHN8gNwEy3dk2VAnOJGYjA/uiqCTZNjrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXjqROARcWrGFd7jep7SkaphFr1yP5nAdM7FauGXBl4=;
 b=WDaq3mKi2+5i8C1hgFmugjyr/AGocfw0/bcH3iwAN4vb9kEJwVtV54Tz+x4qABJioIyBhjwgLyDGdPx56dFOpqh1nfisbkzz9LYo9k5UZxO0Xk9IP1ybXrH4yq6+zqHrQdxgIockhOR+wjKOCNCHQghPbwYNcTuvf21V1yLHbMk=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by IA0PR11MB7953.namprd11.prod.outlook.com (2603:10b6:208:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 01:27:59 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:27:59 +0000
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
Subject: [RFC net-next 02/15] net: cpc: add endpoint infrastructure
Date: Sun, 11 May 2025 21:27:35 -0400
Message-ID: <20250512012748.79749-3-damien.riegel@silabs.com>
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|IA0PR11MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: fedb03cc-9b2b-4b89-535f-08dd90f43adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUtMTlFiRHl0TUh4bnpFdjVkblV5M3dsNU5qUXNBaUczNFJ1RHpWNWwveG9S?=
 =?utf-8?B?RnJNZHFYK1p3bjJ6QWNTWjdWYjRwUTIvRGg4SmRkRWxTc0t6RGpsZm1za1dr?=
 =?utf-8?B?bVU1VlZWcjRwcmRHd1BEcjFXbnI1Z25nUWNSK3FtVy9qSE5XSVM4eWNsN2Y0?=
 =?utf-8?B?aHVoWmlYQ295RkYvQXRjUitrd0FxZkVFMFkxVEdFWFZzS0h4azNJbWQxWkNY?=
 =?utf-8?B?bGVsWkZLa2dRaEJzZU5UNnIrZVZDK2E0a084c0NXckZZMGxNNU9NRklWTWhD?=
 =?utf-8?B?eGhySVo1YnVqWWd0UEF0cDc5MFZ3cnNETTZaMDBmWm5vRjMvRHBaUXZ0MGtT?=
 =?utf-8?B?NVF5ck5iWHdaOTlGUzhSK0NUUzM0MWFMcHBCTTk2cFdvYmVwL01EdGFKQ3ln?=
 =?utf-8?B?WjJhMThScG5UMHNPYlJlUGtqRFB2ekFydlZKQzYyZnFJMFY2NG5WK0RwVEJ0?=
 =?utf-8?B?RnEzSVRwdmpvZFNYR3NETXI0T1ZHQ3c1QzhUNnV6WGFDVG1HUVBXRjhHMmJr?=
 =?utf-8?B?d25FMWc1c2RwZThONzkyWlM2V1NCZU5uL1RTbzBVdFhxa1VxRjVsb1ZkZWpI?=
 =?utf-8?B?Y1JTYjFOWU1RamRnbnNrWjFWNG5NZDdrelhGcjNib292SkNCenBsLzZTVnNO?=
 =?utf-8?B?dHV1cURVV2dGRUhzS0JnbFNLeDRRZ0p6SDUzNXJubnZacllVeDhiWWQ0bGhk?=
 =?utf-8?B?Ni8reTJncjF4VHBuT3QwZDVuZGxwVXJ3WlhXNmtLekJNNFFRd0VKdzV1NERU?=
 =?utf-8?B?UnBrdFZDS1d5STV4Rkt1R1dMNEVlSlNmVHdEM3pVYkFuWk5wTEJtWE9GUEZa?=
 =?utf-8?B?U0dUUTdEVlNNSUEvdG5Lb0NaNThNY2gwc1g5QS9DQmYyN2l2Uk4wRERDcHFp?=
 =?utf-8?B?ak5QZ0cyNzE2U1pCNWpJNnJxSWtMUEJsWk5lSkUrQW5Bd3VFWXVhby9NV1Ja?=
 =?utf-8?B?RmI1MDlxWElJSDBLVGFxeUFIQzZ6OXVvcndYS0xkcVVXd0N6d0VXMmxzUDlk?=
 =?utf-8?B?MUhFZ1gzVTdkWlE5c1NKYnROMmYvckJoS1ZSenNRUnNpVExFTy9JNytCaWtr?=
 =?utf-8?B?czNJN3pMZkNDL0wrRmtyVDl4WTZsY29aN0RPOWpmaWw2M0o0cEpaajk5bEoz?=
 =?utf-8?B?djBYU1d3aDcrN0xPYXd4MEVtL1o4bUJJRmk4a3FjUHNsOHNVWXBzVld1M3R5?=
 =?utf-8?B?RTlwOGZHaDBUQXVDdW1FajBiaW1Vdko2eGREMCtNb2lFUlJTaXE0OWNuaStX?=
 =?utf-8?B?YnVCVlhRRmUyc0krT1pKRHNKbUgyZXpxRTFMVGdkYUYrcUduYnhQd2FyRkdV?=
 =?utf-8?B?eWpUMGJ2cEJSRWIvVGw2dUE1UXBVL3dScDlWeCt5Y0M5Ym5GeXI0YlpCeTla?=
 =?utf-8?B?dm8yRERsR1lFa2xXOTl0QTJ2enV2OXpUUnBSUURFcHJ6KzN2QkJaTG1xTWhV?=
 =?utf-8?B?Yno1SCtRTXM0Yk9pcy9hdHMyMzRHcHNzUzljS1VKcVl2ZTFYanU1cEFkWFFT?=
 =?utf-8?B?cVBXYVNyYjVFM1pvQTdET3dkYk41WDVuUnhtSTJVMHFhYjJQUmZvRmMwVkt2?=
 =?utf-8?B?NDRlQVZKaHRlSWQ4MUpZZXE0dm5COUhzSFoxdTRaUGdkejZRa2F4d0dBMnBq?=
 =?utf-8?B?MVZYRW1zTXJjZStLR3dVWlJQVFJYV21zWlR0azFPNUh6NkVrbUVUYXYrSnZS?=
 =?utf-8?B?VmdMY20rSXRuaEd0RWNEMFBnMlRNbHpVNjkvczdiL0x4YlBveWdNUzFTK0xB?=
 =?utf-8?B?d2tXK1I5U1VrOUpkQVczLy9lR0pRcVhtV2JwZXg3T3dqcTFuRHRLdWJmT1Fu?=
 =?utf-8?B?ZlpTWWdzcm8rQ0Z2anJicXdlZTFFVk1KMmtjWm8xZkVPOW1xUzk3YUJaTVlL?=
 =?utf-8?B?WlRmQzk4V0NRR1FMUXB2NkFtSFVkOXNxRzlLVlpXa2MvUFpOSmxJZEQxV0k1?=
 =?utf-8?B?YjYrUWdwU3g4QXJtbGNjZGMvWitRTm9WaUFXZjd0L3l2dWM4TytUeU5Ld21Q?=
 =?utf-8?Q?wKDqBcs/7l1/37nGwd8yrQ72dWEyVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXdhd2t6V2pwUXlIRlZzTnlxQmxNQVZ2V0sxYjgxcGhCdHhXMU5BRmdIN0lo?=
 =?utf-8?B?VmdoakVZQUdWQTZTY1pnWFd1ZHRPSTV5ZnBxd0xxSExoaitsb2JjRWsvUHlU?=
 =?utf-8?B?ZVlubDg5ZzY3dzdLcGorNklDRVQyT3VZcWtmbW1SRmNCSklhN1NTZHZKcFJm?=
 =?utf-8?B?MldIbGpnUStWb0E4NTkrVFJwbjBFaGRxVEtCMVFiS25uYVZIcUw3dXZ3SUlv?=
 =?utf-8?B?WDkvbktxNWZyRjBhaEtUQllKaE82Y3hpaEswQ2pGZ2hZV0ZRQ20vRVcrZWFN?=
 =?utf-8?B?WE80S01uRGMrM0NRVWVFWU9talB4ajVIWndaaHhjdmNmME1FUEVZL0RYWEUz?=
 =?utf-8?B?TWpvb1FTaW5DY3JGWmlvbjZPekpOdFNpb0FLcnZGYVNZRkpOSTA5TkV3S3dT?=
 =?utf-8?B?OTNhdDVxT2VHeDNnUkJaazM4eEtKZklyWHlTOXFPVlVmbC9WdW44L28vcVIv?=
 =?utf-8?B?TmNzMEpjVGFOSm03dzgrVEVwL0NOOHBvUVhtMzZIcnRlU1hnREpaR0RCaGtM?=
 =?utf-8?B?VVg5WlFOeHFIN1JyVlBkb3dUaGQ5MVE2UGNnWGMvT3ZSblQzKzVHYms4WTR6?=
 =?utf-8?B?VjNrNGFjcjZRUndkamNWL0pIdFFJYnRjRlkyeDIxd096SDR0bTMyQWxNL1I2?=
 =?utf-8?B?WU15OTFmSWtDL29ESXc3QTJJTHJ4aWtmWTQyaldESTF5bkFIK0VsQU1kbVEw?=
 =?utf-8?B?ZnExMjlhb3dTRktCd2UrR0lzaGtjQm96TXdvTVZmNm4vN3p2bjdENjZxMWNr?=
 =?utf-8?B?R2o2RDZxbWZjRE9wZnFMRi9PcjF4TlNWYS95cDRhT3FqUE8wL21Iam5IeHJz?=
 =?utf-8?B?OWpDU0pocHZFRXQzc0ZldlpHQXN4dEpsdmpXYkM1akJDSGNaQ1UwNmdPZEw5?=
 =?utf-8?B?ZWdxTjhDa3Arb2hlSFdrZ2EzQkJPUXZoaGdEcFIwVnBUdm9XR1BHdng1Nmk5?=
 =?utf-8?B?cWRMc1VXaFcvZTBXOUtQaEhqWUl4R0VTdklTZVo4dzltYXJJd2g5Q2QyRkNr?=
 =?utf-8?B?a3ZNMkZSb3ZGTnBxa2NReTNRSEhMUjIzbHorV0dXMWVCOXREWG9pRDhNZnpu?=
 =?utf-8?B?RllGYWxKbDhzR1daRjE0RDQ5UkpRV00yTlJwZ1hsRGlvQVRjVFNkM01QeldH?=
 =?utf-8?B?NUVKK0NUWmJMNTBZSy9la2FEdVQ4aUdQd0hTcmdPem45ZWhqMFU5dHRqOTY2?=
 =?utf-8?B?Z3ljb2RucFBBOXVkTVM3cSt5NzExOWhNSFJCL25GRlFRamJNRUJmNzlaemlY?=
 =?utf-8?B?R0plb3ViZnV5bWZkSzRnZStqS0t6SGs5QzRqdXVwTy9lZDdVeFY5M0dlSHVs?=
 =?utf-8?B?NzFxbzBwejZBOHdqUlNYa3lqd1FLTDg5MlR0SWR2WEowcEJGekZveUdCd0Iw?=
 =?utf-8?B?eWJaMFloNXRJc2RodTA4Tm5FeDVBNW4wSWVMU3RwYmhLQWxEcVlETHFweU5s?=
 =?utf-8?B?SnNjb0pFZWVXNndJQ201bkE2eTdsZGNlN0JESnBwbzNOdmpuay9aSUdYYjVH?=
 =?utf-8?B?SExDR2JtK2lDZ0hzZ0JKL1pOTE1jdmFlRVdQeWx2dHcxSUpRZnpSWFZURTJa?=
 =?utf-8?B?dFV5NWNWNjF3N1JzNTNSVHgrSnczWWJrb2FnMHI0aTNEejQwb0p0WUt4QjRt?=
 =?utf-8?B?alRQWEMrYVdPMGVyMVZlK3kzMDI1bDJIaXptNy9icWt0eENTZFQyZ2QwK24r?=
 =?utf-8?B?MGxXQ2QxdUFpNFR4QkZtZWdpaEZZdG1DeDlIUVF1YVl6Ynh4aXQ3L0htZWxz?=
 =?utf-8?B?WWhaTEpvbnV6NUt4Nk5Oak1nQ0JDWDFUd0lWSTkza21kUTFGVWdLWGM0MGR6?=
 =?utf-8?B?RXFWcUpxbUozOThiaVFzOXFoS2NHYzNiSkVrMzhrSUpXbERYVG1LQ2M3cGlq?=
 =?utf-8?B?YzBSaGFBZkYwUjBKY1JtNzJ5M3lYcCtHTUU5Y01jV1F5NHJYUXpLbC9yczdQ?=
 =?utf-8?B?bTlPN1R1dmkvUGpjSHZ2SkpnN3F2L0RXTkxWeitpOUdKaURtWVFoV3BEaG5D?=
 =?utf-8?B?dXJRbVczc0NXWWZXNFZvZUoxM1p0RUpoUVJwY1BuNzFuVklGQTgvSXcyekdD?=
 =?utf-8?B?UlFXRldTTExJSDN3SXBVWXlUS0FtRkk1dWxXc1NuR2N4RFVIOFd4WUJPK3Bz?=
 =?utf-8?Q?8AqVYqfual7ljtxDJUr/idz68?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb03cc-9b2b-4b89-535f-08dd90f43adf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:27:59.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WZ07FSyiQaDIiEsfiMI23lgQFhAQ5mBT81merZfZXSKQWuvtq6c+DemtkdmxP0aN/Dt+3vxYCel9WvqyyIINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7953
X-Proofpoint-GUID: m7GQ6_qB8944kknOFpxMyXoeLT7gISB5
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=68214ea1 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=FtdxCg7vcX7QgciArP4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: m7GQ6_qB8944kknOFpxMyXoeLT7gISB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX8WG97dKaJNwL iyOI0bq76fN/OHkwV5cMlpboddvq7KJtdtpYaY5muewS1kU+we9H6+AA73xdY23g7JO24Zd4Jwz 6K8J1gMTsa2DALRVcJwCEctHiQy82ggh//bLjNiZlVt9PzvS8mXvjY0MwGdlejvxkub8B8TyZcG
 feIkj83dX0SXpOeNQRB7fBggI0F5o4zj4YY7SkXA+yYo6UaFVgaSvrcg/PEavNPLRXJCK9PieRZ 18O7ZDJQlVmUiyzo/hyINx0Pou/0M40V0uTGym81S1q3JC0iVcNJaDZvOR3GBSvh36oj6yoZZN3 ZFNgh09t/swEZHzcAa79ZjwHlEPBsZDUlGEBlawgMmvrYV8htG5Kd9sknp06v9PG32yqm418QKh
 8oE/4nC0pJP3q4wLNDowmZLey1qEPVLwfAobKKLc+L0FTJuotr0r6zBRzNddqDZ9OZJySXA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Network stacks using CPC are isolated from each other and their
communication channels are called endpoints. Within a CPC interface,
endpoints must have a unique Endpoint ID, which will be used to address
messages to that specific endpoint in a latter changeset.

Endpoints are part of an interface, this is represented in the device
model by endpoints being children of interface, and the interface
ensuring uniqueness of the endpoint ID when a new one is added.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/Makefile    |   2 +-
 drivers/net/cpc/cpc.h       | 101 ++++++++++++++++++++++
 drivers/net/cpc/endpoint.c  | 166 ++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/interface.c |  58 +++++++++++++
 drivers/net/cpc/interface.h |  11 +++
 5 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/cpc/cpc.h
 create mode 100644 drivers/net/cpc/endpoint.c

diff --git a/drivers/net/cpc/Makefile b/drivers/net/cpc/Makefile
index 1ce7415f305..673a40db424 100644
--- a/drivers/net/cpc/Makefile
+++ b/drivers/net/cpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-cpc-y := interface.o main.o
+cpc-y := endpoint.o interface.o main.o
 
 obj-$(CONFIG_CPC)	+= cpc.o
diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
new file mode 100644
index 00000000000..529319f4339
--- /dev/null
+++ b/drivers/net/cpc/cpc.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#ifndef __CPC_H
+#define __CPC_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#define CPC_ENDPOINT_NAME_MAX_LEN 128
+
+struct cpc_driver;
+struct cpc_interface;
+struct cpc_endpoint;
+
+/**
+ * struct cpc_endpoint - Representation of CPC endpointl
+ * @dev: Driver model representation of the device.
+ * @name: Endpoint name, used for matching with corresponding driver.
+ * @id: Endpoint id, uniquely identifies an endpoint within a CPC device.
+ * @intf: Pointer to CPC device this endpoint belongs to.
+ * @list_node: list_head member for linking in a CPC device.
+ *
+ * Each endpoint can send and receive data without consideration of the other endpoints sharing the
+ * same physical link.
+ */
+struct cpc_endpoint {
+	struct device dev;
+
+	char name[CPC_ENDPOINT_NAME_MAX_LEN];
+	u8 id;
+
+	struct cpc_interface *intf;
+	struct list_head list_node;
+};
+
+struct cpc_endpoint *cpc_endpoint_alloc(struct cpc_interface *intf, u8 id);
+int cpc_endpoint_register(struct cpc_endpoint *ep);
+struct cpc_endpoint *cpc_endpoint_new(struct cpc_interface *intf, u8 id, const char *ep_name);
+
+void cpc_endpoint_unregister(struct cpc_endpoint *ep);
+
+/**
+ * cpc_endpoint_from_dev() - Upcast from a device pointer.
+ * @dev: Reference to a device.
+ *
+ * Return: Reference to the cpc endpoint.
+ */
+static inline struct cpc_endpoint *cpc_endpoint_from_dev(const struct device *dev)
+{
+	return container_of(dev, struct cpc_endpoint, dev);
+}
+
+/**
+ * cpc_endpoint_get() - Get a reference to endpoint and return its pointer.
+ * @ep: Endpoint to get.
+ *
+ * Return: Endpoint pointer with its reference counter incremented, or %NULL.
+ */
+static inline struct cpc_endpoint *cpc_endpoint_get(struct cpc_endpoint *ep)
+{
+	if (!ep || !get_device(&ep->dev))
+		return NULL;
+	return ep;
+}
+
+/**
+ * cpc_endpoint_put() - Release reference to an endpoint.
+ * @ep: CPC endpoint, allocated by cpc_endpoint_alloc().
+ *
+ * Context: Process context.
+ */
+static inline void cpc_endpoint_put(struct cpc_endpoint *ep)
+{
+	if (ep)
+		put_device(&ep->dev);
+}
+
+/**
+ * cpc_endpoint_get_drvdata() - Get driver data associated with this endpoint.
+ * @ep: Endpoint.
+ *
+ * Return: Driver data, set by cpc_endpoint_set_drvdata().
+ */
+static inline void *cpc_endpoint_get_drvdata(struct cpc_endpoint *ep)
+{
+	return dev_get_drvdata(&ep->dev);
+}
+
+/**
+ * cpc_endpoint_set_drvdata() - Set driver data for this endpoint.
+ * @ep: Endpoint.
+ */
+static inline void cpc_endpoint_set_drvdata(struct cpc_endpoint *ep, void *data)
+{
+	dev_set_drvdata(&ep->dev, data);
+}
+
+#endif
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
new file mode 100644
index 00000000000..5aef8d7e43c
--- /dev/null
+++ b/drivers/net/cpc/endpoint.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/string.h>
+
+#include "cpc.h"
+#include "interface.h"
+
+/**
+ * cpc_ep_release() - Actual release of the CPC endpoint.
+ * @dev: Device embedded in struct cpc_endpoint.
+ *
+ * This function should not be called directly, users are expected to use cpc_endpoint_put().
+ */
+static void cpc_ep_release(struct device *dev)
+{
+	struct cpc_endpoint *ep = cpc_endpoint_from_dev(dev);
+
+	cpc_interface_put(ep->intf);
+	kfree(ep);
+}
+
+/**
+ * cpc_endpoint_alloc() - Allocate memory for new CPC endpoint.
+ * @intf: CPC interface owning this endpoint.
+ * @id: Endpoint ID.
+ *
+ * Context: Process context as allocations are done with @GFP_KERNEL flag
+ *
+ * Return: allocated CPC endpoint or %NULL.
+ */
+struct cpc_endpoint *cpc_endpoint_alloc(struct cpc_interface *intf, u8 id)
+{
+	struct cpc_endpoint *ep;
+
+	if (!cpc_interface_get(intf))
+		return NULL;
+
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	if (!ep) {
+		cpc_interface_put(intf);
+		return NULL;
+	}
+
+	ep->intf = intf;
+	ep->id = id;
+
+	ep->dev.parent = &intf->dev;
+	ep->dev.release = cpc_ep_release;
+
+	device_initialize(&ep->dev);
+
+	return ep;
+}
+
+static int cpc_ep_check_unique_id(struct device *dev, void *data)
+{
+	struct cpc_endpoint *ep = cpc_endpoint_from_dev(dev);
+	struct cpc_endpoint *new_ep = data;
+
+	if (ep->id == new_ep->id)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int __cpc_endpoint_register(struct cpc_endpoint *ep)
+{
+	size_t name_len;
+	int err;
+
+	name_len = strnlen(ep->name, sizeof(ep->name));
+	if (name_len == 0 || name_len == sizeof(ep->name))
+		return -EINVAL;
+
+	err = dev_set_name(&ep->dev, "%s.%d", dev_name(&ep->intf->dev), ep->id);
+	if (err) {
+		dev_err(&ep->dev, "failed to dev_set_name (%d)\n", err);
+		return err;
+	}
+
+	err = device_for_each_child(&ep->intf->dev, ep, cpc_ep_check_unique_id);
+	if (err)
+		return err;
+
+	err = device_add(&ep->dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * cpc_endpoint_register() - Register an endpoint.
+ * @ep: Endpoint to register.
+ *
+ * Companion function of cpc_endpoint_alloc(). This function adds the endpoint, making it usable by
+ * CPC drivers. As this ensures that endpoint ID is unique within a CPC interface and then adds the
+ * endpoint, the lock interface is held to prevent concurrent additions.
+ *
+ * Context: Lock "add_lock" of endpoint's interface.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int cpc_endpoint_register(struct cpc_endpoint *ep)
+{
+	int err;
+
+	if (!ep || !ep->intf)
+		return -EINVAL;
+
+	mutex_lock(&ep->intf->add_lock);
+	err = __cpc_endpoint_register(ep);
+	mutex_unlock(&ep->intf->add_lock);
+
+	return err;
+}
+
+/**
+ * cpc_endpoint_new() - Convenience wrapper to allocate and register an endpoint.
+ * @intf: The interface the endpoint will be attached to.
+ * @id: ID of the endpoint to add.
+ * @ep_name: Name of the endpoint to add.
+ *
+ * Context: Process context, as allocation are done with GFP_KERNEL and interface's lock is
+ * acquired.
+ *
+ * Return: Newly added endpoint, or %NULL in case of error.
+ */
+struct cpc_endpoint *cpc_endpoint_new(struct cpc_interface *intf, u8 id, const char *ep_name)
+{
+	struct cpc_endpoint *ep;
+	int err;
+
+	ep = cpc_endpoint_alloc(intf, id);
+	if (!ep)
+		return NULL;
+
+	if (ep_name)
+		strscpy(ep->name, ep_name);
+
+	err = cpc_endpoint_register(ep);
+	if (err)
+		goto put_ep;
+
+	return ep;
+
+put_ep:
+	cpc_endpoint_put(ep);
+
+	return NULL;
+}
+
+/** cpc_endpoint_unregister() - Unregister an endpoint.
+ * @ep: Endpoint registered with cpc_endpoint_new() or cpc_endpoint_register().
+ *
+ * Unregister an endpoint, its resource will be freed when the last reference to this
+ * endpoint is dropped.
+ */
+void cpc_endpoint_unregister(struct cpc_endpoint *ep)
+{
+	device_del(&ep->dev);
+	put_device(&ep->dev);
+}
diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
index 4fdc78a0868..6b3fc16f212 100644
--- a/drivers/net/cpc/interface.c
+++ b/drivers/net/cpc/interface.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 
+#include "cpc.h"
 #include "interface.h"
 
 #define to_cpc_interface(d) container_of(d, struct cpc_interface, dev)
@@ -53,6 +54,10 @@ struct cpc_interface *cpc_interface_alloc(struct device *parent,
 		return NULL;
 	}
 
+	mutex_init(&intf->add_lock);
+	mutex_init(&intf->lock);
+	INIT_LIST_HEAD(&intf->eps);
+
 	intf->ops = ops;
 
 	intf->dev.parent = parent;
@@ -85,6 +90,12 @@ int cpc_interface_register(struct cpc_interface *intf)
 	return 0;
 }
 
+static int cpc_intf_unregister_ep(struct device *dev, void *null)
+{
+	cpc_endpoint_unregister(cpc_endpoint_from_dev(dev));
+	return 0;
+}
+
 /**
  * cpc_interface_unregister() - Unregister a CPC interface.
  * @intf: CPC device to unregister.
@@ -93,6 +104,53 @@ int cpc_interface_register(struct cpc_interface *intf)
  */
 void cpc_interface_unregister(struct cpc_interface *intf)
 {
+	/* Iterate in reverse order so that system endpoint is removed last. */
+	device_for_each_child_reverse(&intf->dev, NULL, cpc_intf_unregister_ep);
+
 	device_del(&intf->dev);
 	cpc_interface_put(intf);
 }
+
+/**
+ * __cpc_interface_get_endpoint() - get endpoint registered in CPC device with this id without lock
+ * @intf: CPC device to probe
+ * @ep_id: endpoint ID that's being looked for
+ *
+ * Get an endpoint by its ID if present in a CPC device. Endpoint's ref count is incremented and
+ * should be decremented with cpc_endpoint_put() when done.
+ *
+ * Context: This function doesn't lock device's endpoint list, caller is responsible for that.
+ *
+ * Return: a struct cpc_endpoint pointer or NULL if not found.
+ */
+static struct cpc_endpoint *__cpc_interface_get_endpoint(struct cpc_interface *intf, u8 ep_id)
+{
+	struct cpc_endpoint *ep_it;
+
+	list_for_each_entry(ep_it, &intf->eps, list_node) {
+		if (ep_it->id == ep_id)
+			return cpc_endpoint_get(ep_it);
+	}
+
+	return NULL;
+}
+
+/**
+ * cpc_interface_get_endpoint() - get endpoint registered in CPC device with this id
+ * @intf: CPC device to probe
+ * @ep_id: endpoint ID that's being looked for
+ *
+ * Context: This function locks device's endpoint list.
+ *
+ * Return: a struct cpc_endpoint pointer or NULL if not found.
+ */
+struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 ep_id)
+{
+	struct cpc_endpoint *ep;
+
+	mutex_lock(&intf->lock);
+	ep = __cpc_interface_get_endpoint(intf, ep_id);
+	mutex_unlock(&intf->lock);
+
+	return ep;
+}
diff --git a/drivers/net/cpc/interface.h b/drivers/net/cpc/interface.h
index 797f70119a8..d6b6d9ce5de 100644
--- a/drivers/net/cpc/interface.h
+++ b/drivers/net/cpc/interface.h
@@ -17,15 +17,24 @@ struct cpc_interface_ops;
 /**
  * struct cpc_interface - Representation of a CPC interface.
  * @dev: Device structure for bookkeeping..
+ * @add_lock: Lock to serialize addition of new endpoints.
  * @ops: Callbacks for this device.
  * @index: Device index.
+ * @lock: Protect access to endpoint list.
+ * @eps: List of endpoints managed by this device.
  */
 struct cpc_interface {
 	struct device dev;
 
+	/* Prevent concurrent addition of new devices */
+	struct mutex add_lock;
+
 	const struct cpc_interface_ops *ops;
 
 	int index;
+
+	struct mutex lock;	/* Protect eps from concurrent access. */
+	struct list_head eps;
 };
 
 /**
@@ -47,6 +56,8 @@ struct cpc_interface *cpc_interface_alloc(struct device *parent,
 int cpc_interface_register(struct cpc_interface *intf);
 void cpc_interface_unregister(struct cpc_interface *intf);
 
+struct cpc_endpoint *cpc_interface_get_endpoint(struct cpc_interface *intf, u8 ep_id);
+
 /**
  * cpc_interface_get() - Get a reference to interface and return its pointer.
  * @intf: Interface to get.
-- 
2.49.0


