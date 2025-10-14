Return-Path: <netdev+bounces-229024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD93BD7237
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722803B314B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A3306D57;
	Tue, 14 Oct 2025 03:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sIy77M5/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE319CCF5;
	Tue, 14 Oct 2025 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411268; cv=fail; b=CjUX+Yw2+aaqseI4/j5wTsfMx5JDBGyLJtSzAXHCrzrzy3ZycvZOljbONQdLvJIiP+PBmf35AeBg8PYUs4Q20Vw9wCeYiaqoq2gzYeD60vpTbX8qV4BdiE0PQv52DuWWqvpUVu01+Omb1ojJbp3tSCVQx5xOPfWPORvqy7TdFBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411268; c=relaxed/simple;
	bh=d6UGphLBIVPtl+XQNNzr4fD4D6/EeZyO43Iw0DEwRSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEqFyFKq9k/qZbYuJgtbWsqpHHPr4q2H68ydoHOV3LQgnI8Bs9xzsP4LXhfo1BZ4vCh/2OO8KIz/bAlHPcjHUQ7sfC1QvR0D/jVYWfa2PnnadpZ5SzrH9Ke8JYkSubplvRXxMjXsFZnfxKSCcha3Mv+NSklLkfG2k5jsr43V+DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=sIy77M5/; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59E1UkPk1649637;
	Mon, 13 Oct 2025 20:07:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=9H/VjbVlaLWlAqWTqL50H1VjMxI0aP2FYxffdPMlwqc=; b=
	sIy77M5/LnDWnKlmOB3iRJ0DsYCP/MNpFunXFFQ/ClcF1DwbSwlB6+ZtI+7k/Udp
	va51p0EcCuRjt8+dp7wRVUNzTaKfMJkj4HE8i1BNQt+M/oSI2nDa+WCt3iKDI614
	eHB7nJHuCQ+A0UuWioDH8xYjtftsg+3G8NzBHPmFxeQxMb5zN7hJ4XpYXJJWAyLr
	H3QpAohQXDNsMq3GDKonCK49g6hFX8+SwgfjeUPuZcKB7S7rCixd5+Kr3Ke/dscj
	3vMBN3MNQiv0wYQlNs1xZFm3T+4ABpUs4Q/iVRD1veyfkt81EUIYCiy3el4bUbTd
	EtDXlVW5NiYYqib3IlxPEw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qprdtabn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 20:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgys9WB7q8qfw+RN0m3Tixa2LEk2RocujgcbTa/y4rNO2lTPRhoHgFdO2WGVYsVomb9sAiCCiY4U2g+EJIM2jKFks9JT2Irfj6f3zDQ4r6Pi+yxN8Vq//0pDOf0XDP1CPqnmKUmtUOZNfmQycvik7mFdfwnQn8J2DFx0I5gQ3gc4wKfQVTC+QnVAFOgSFCbvYqsr5AB5ccnIsoImjwHeilCVJkazS7/Poc9M18S26uqEWd6ej4Qsv6OVkxRR9Hbnw519JIccgGJWtN8ZIjH8vY3ndmz/AWfHQTqFGqFEiCcWssuHXldC3p4/uMVK3kyDTpysgPOKqBc/gYNRb02tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H/VjbVlaLWlAqWTqL50H1VjMxI0aP2FYxffdPMlwqc=;
 b=VNBLFo18+OgGr435IykKWxXi0ObAanXC8lT5itDr+oEKg340Q21Gduq8CZ0FAdDdNAZh15ld3bg6ch/werLD1OJZW2OqrDEVmtqcVfIrWoy7KKpic3pw9v+u5BVEe97s1tvmCGrRdkq2lqeuOa2E/7YaeulW3B0AVQl9ZpCs97W/DJ2A/dv+Iu/+mBIoSldaQeSWXafRTCicF+fKoAy+c+5ykEPkU8La34xo3FJkEwsl5CaB+xrrj1jBW4xdG5FxyCH+NMiBqavKIoNa6BiJmuddiTgyKbdQ1F+K6dYS/GW7EzAr07eOOtLRVqPLqt5dgIN4cusrq7/QPhXvaEoyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) by
 MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 03:07:07 +0000
Received: from DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::43bf:415d:7d0b:450e]) by DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::43bf:415d:7d0b:450e%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 03:07:07 +0000
Message-ID: <45e6e4f4-b467-4852-b1ae-badf3c815075@windriver.com>
Date: Tue, 14 Oct 2025 11:06:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH net] net: enetc: fix the deadlock of enetc_mdio_lock
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
References: <20251009013215.3137916-1-jianpeng.chang.cn@windriver.com>
 <PAXPR04MB85109BDA9DCBE103B0EE1F8F88EFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20251010105138.j2mqxy6ejiroszsy@skbuf>
 <20251010110812.3edrut6puoao36b3@skbuf>
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
In-Reply-To: <20251010110812.3edrut6puoao36b3@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0158.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::9) To DS0PR11MB7736.namprd11.prod.outlook.com
 (2603:10b6:8:f1::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7736:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7b9df1-77e7-42b4-2368-08de0acec25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emVzOHFWa2ZDQjNERFk4OUF5SUNvZlNFK0JDRm14aVhKcTdhMFFzaUtoTGJ4?=
 =?utf-8?B?YThtdStFcFVheXFlQzdrV25wRGZKdUZQQ2U2Y3NEdDVCNm9XZDVXLysydXJO?=
 =?utf-8?B?TmxWZ00wc0hCL3YxRnBtSCtaTFZFZTZBajI5TUFLeUtwWWIyOU5HdnRZWXNB?=
 =?utf-8?B?RkZIRnVEckJ2TS9xWEhvZlFUMzJQRDkwMEFpRTB4QnM4dmROZ1RyZGNjWU5O?=
 =?utf-8?B?dHkvdXVmY2VVdU5BNXFPU20yaHIzYWxQWnhuckE0TVFSYjA0TUtGeUV0Q29w?=
 =?utf-8?B?UjRES1lDS01aSENONi9YQklvbEVDaUVnTW44VnNpYVFaaGgyR0lYdnpvV2tE?=
 =?utf-8?B?YTVNZk85ZVNtY1ZrWERlaUI0ajJxbFR0QzBVY0xEUk5hdWZYd3l0L3dULy9v?=
 =?utf-8?B?SkNJT0RUYVF5cWpzUVRhbFc5c08vSk5nMUQ4MHBsYUd5eWdwSTY4S28yeExn?=
 =?utf-8?B?U2tJUUhCVVNXSUw5OWZ6L0ZXcENmcWVpZHk4T0c2ZEVLdVc1NnZQMUdMOWFY?=
 =?utf-8?B?WWpxUGp1N2dhMTF2eDhoY0JwUmxEam54bUw0Q0svSlNiRHJ4V21sUWtNcC85?=
 =?utf-8?B?SDF5bGR4WVpzQUJrMHZVeFFBNFlpUC9vS3U4VVVlMkhRZ243Yi8zR0NBcnBJ?=
 =?utf-8?B?M3dXeEdJbEdpNHd5M25wY2pHSHNrc1FuRFdzRmtkZzJEKzBBSFVSdG9aLzZi?=
 =?utf-8?B?dHg1ckdpL0U2VnRjekJWRUpNUmhuZHZocC9yNkg5b2NuV1hCNUJBeUFGVmdt?=
 =?utf-8?B?MndCQXZOdHpMZHJBQ1hpK0tCVWdvbFBLdTlCbkpZTlh2eE82amEyckJUWDVn?=
 =?utf-8?B?UGFCc0ZQQ1BXaEM4Z2EySkRMMlg0U0ZOcDVUdXM0QjJDZVpodkhMYW8xUWlr?=
 =?utf-8?B?M1cyTWdtNGNPZjFXMldHcSsvcnErRUV1NkQrMlBOaVYvYXV6UlVCYS9VV3gw?=
 =?utf-8?B?TkRVeGVqWDNYTTFNSmpsV2RpZkx3R0ZGVjdKeXRIV2w1N212R3dHWVVieVd3?=
 =?utf-8?B?Uk9UN3Y5UjlLRE02L0doVmVRN1ZuUVdSL1VxUSsrYTRVRTFzYTVBVFdXbXp4?=
 =?utf-8?B?MFZnaW1CV2pSeEIwMDMwRENRTzI5V01wKzQ2UVgyYkJlQ3ZZWEZqMWxLaDhh?=
 =?utf-8?B?Tk1hMnVVMnZzZVlVNEg4MFM1dVEzWUYvNVlEUlMrVG02Zml4cjdGZWczMjRF?=
 =?utf-8?B?aG5oanVPTXBCbmg4VEw0WWJCYVlNeUJ0eUdSQWRIOWlIaDM0Undld0JxYWg2?=
 =?utf-8?B?c0p0ZVErTzlIMndZekdTazVzVlEwS3FxTVN1N2VSaTlMaUlUZDJQdHUyamtr?=
 =?utf-8?B?QzMveGttTzRuU3ppQVI0NHlJaHI3QU5Fc3oxLzhhQUFER280SEhLUEhrWnNM?=
 =?utf-8?B?d0EvQjVReUVCU0hQMmVzRkd5UXZQUDlJYkRPWGI5MFlDY3k0aExjVSs3ZUh3?=
 =?utf-8?B?QXVybGhIdUhPaEJzYnZpZjdnQTlaWHY4UkZYRDZTZk1TZEgxOXJxY0FoWU90?=
 =?utf-8?B?NjNod0ZLMEF6Z0tacTY4SXcyOTNoL1lqMXVIMmJLR1N3VGVkZjFWOWhnaFNK?=
 =?utf-8?B?QkpmMld2TXcxamJHNmc5U3RDZFc1Ui8rL2FPVXkxK21ra0hOL2xPc3pYWGVK?=
 =?utf-8?B?ZWd1SHpPdzZCVHFacll1NkJNc1M0Uno2ZUZUd0VaY1dHcklvL0ppbm9JYk14?=
 =?utf-8?B?M1VweHk1OHdsOFdqZzh3eVdzdzExanNBWEtHMFMxYjhBUzZpOTRvZXUxSmpw?=
 =?utf-8?B?Z2NRRHBCdUNRdWNNRFhTckIxVllnSTkzcFVJWVpEVjdpNGpGZkxSdm5ZZXlY?=
 =?utf-8?B?K2duQ2g0dFF1NEF1bGMrK1VNd2hRa0lBMWxLblRLdGVDSzdueTNvYjYzSE56?=
 =?utf-8?B?RlZ4UjhDdjRpbmtlVzE5T1QwYjQwWFRTNnE1Vi9Cbi9wekNjbTBwb1B0a3JS?=
 =?utf-8?B?UjljNXZRSnIwOGlCWVNxbXkxeEFBSHJFK0hXbHo0bklGYTcrVm92dyt4TG8v?=
 =?utf-8?B?VkU3TE9pLzNvd2E0bExCenhTVjdTUCt3enEzUWhIbFAyQURTK2JWb2QyYndk?=
 =?utf-8?Q?XOaBaF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjdSU3pLaS80ZHczRTVranZsSmx6VE5oZGtSRkZUK0Fvc0FydlpaWVZaSk9G?=
 =?utf-8?B?S1lJcWh1TzBsYjYxVjdsRGFnb2pPNG1VNDZzdGp0cUp3R3k5dE8zRlV6dHZX?=
 =?utf-8?B?aTZpWGRjdXNlb3NBNkh6bmpKKzdRTndPZEJHME1kUEprS0F0ODA1Q01QZHFK?=
 =?utf-8?B?WmxIVXVPM3RIeWNSMXg0dzVpZzJobHlRYzVQeEJHRFlvYnYwZjg2ODBpVlY5?=
 =?utf-8?B?R0VJK1NuQ1R4dDBDQkthTUJRNFplbE1teGVYUnVSWU96WHdmSXh6TzFhODg4?=
 =?utf-8?B?eXhmemxCaEpWMklTZ1NYVFludk9wdG5BNHRwZzJhaWxxNjJvV2V4S25Ldktl?=
 =?utf-8?B?NGt0SHVxempQZUlROURjVm9aRjdjY2hwVUFuWHJkZzZFUWM3YnZWRVhnM2py?=
 =?utf-8?B?L3Z4WlBFT0YxMVpZdE5qRlY1bDNyUVFCR3dHa3daY09ENGVraHVVeFFjZW53?=
 =?utf-8?B?bFpHeUFZdDgxL2hvbGtWdTdUNGRscHZQUWFnSzlBOVczODVNcWxmSXVnRkda?=
 =?utf-8?B?WUZEM2p0SUpyOSsyS29sZVNzQ0w4eGhmc3pNWUZra3dHSzdHOU50Uk5qWHdu?=
 =?utf-8?B?VU5yL1JPWFFIZm5TM1l3V3k4dk01OUJLUzd0K3VOU2pDdnAvTmNtUE9aUFZl?=
 =?utf-8?B?TnlUbzkxWmY2NXpPT241emN4eHRhL3RtdVl1SXNVNTYxUDF5a3R0eUxTc05E?=
 =?utf-8?B?NTFUOEovS3MyVlJ2NFV4bjdTQnFmdDlubkQwRVI3V3duWUFrNkVnTlcwaWho?=
 =?utf-8?B?aWdWZkpPSlRmdmt6cHp5c1FVVy9qRlJaU1M1dmJLdVI3UG1xam5CMUhtbWh0?=
 =?utf-8?B?UjIyaW5ub1RQVEhTYXFyQi8zSXhnUHhiSVRxd3cxeG9kOUlNN2s2cllZVmRL?=
 =?utf-8?B?VHc0eER5NEtpUDc3YkJjTjVlS2tpZkJ1aXllaENOejB6Q2JVMXVlL2cxNWJx?=
 =?utf-8?B?TFlDdDhwc1FlK1R3a2xiU2E1MDF0eDQzU3JSYzRrSGhzL0M2L2lMdVlSaEJI?=
 =?utf-8?B?ZHdTd2JrcXhsN0ovNXgxNVU2MWlFbVdvMzFnaDFwZGc0R01OYnpzbS9ldG5a?=
 =?utf-8?B?UDJYdFkzOWdIM1VQMGZ3V1g5YnhBTFNTcDMxTVVrWjdSZjV0T1BiUURKOTQv?=
 =?utf-8?B?bUx0Q2Z0bDV5ZEJSazNSZHR4QWphaDMyc1l1c0dsREJYcGtBVlVZdWdWQ3hG?=
 =?utf-8?B?RW9Jc3Q5RFJJeVZWZ0JvOFBuSHBLSUM1TDQ3Yjd2SnJQNi93ZkZ4SnFCczNS?=
 =?utf-8?B?Y2RaVUhRbXR4TEE3VWdPWm1xaC9FV0FRK0M5VTN5Yy90Y1RsUUlNMGlzZk1x?=
 =?utf-8?B?MXYxenRoT0REODlveFZqQWhIZjJQRGRySWNvTk40ajdxRHVxRmhIeUJPZlcv?=
 =?utf-8?B?M2VtdTlsR0N3SVptOEZqTjc5RnNudzRtdkJJa29iMVZZdnJkRStvNFk1Rkx1?=
 =?utf-8?B?bi9nVk1lZWdBaEhhVnltM08zV3JqUzlUNFJkRy94TkgvS25LL29GdjhlN1BI?=
 =?utf-8?B?T0JkY3U1MzdvRHd3ODNiQ0NRK0JrTVdQMnFDeEZXSW5vMTJrRlcxU1kzN2VR?=
 =?utf-8?B?OFdheUFaZ0k5bENjWDVEZnB5V0duY0cvSG53U0M1UjR0a3ZWeFVMVnU0aVZY?=
 =?utf-8?B?STVidVZtYm9JNEQvSXBmTm10blczdjZoMHlFdlZMR0wzYkpIQW9kUzFkSllY?=
 =?utf-8?B?bkJrYVZBZTdFVHN1cW0zRGZ1MGdCK3RXYWVOakV3K2lpdW4yRXo0eFJtcmJN?=
 =?utf-8?B?QytIUTNjaG8zb3NORmZWeitROWU3Z0JRNnkzdnhQay9iQU54Wkp3alc3cWM5?=
 =?utf-8?B?aWwreFhjYURMbDRxbEhCL0FyZzB2bVB2RUNaSXBCZy9RM01HMjlrMzJQdU9I?=
 =?utf-8?B?ekFxbDFoeFduREV1QXVEWER1d2pOYU5lUHI5N00vbFdUL2F3Qmt4ZWs5ckVh?=
 =?utf-8?B?clI0WmwreEhORlptcStlSmtUUW9kY05VM1pmMDBBZllLRmh1REVYeUVaeUo2?=
 =?utf-8?B?Qlo2dW9qeVNIczdkem1hQXg4OXBIb0I0UnQwKzR4bklWdWFpelBaSmlLWHhC?=
 =?utf-8?B?cEVsMWZ2R3ROMXE2Z1Y4UjhhTUFCdEhQeE5ESHJRdXpCM2pCUm1zUjFINEgr?=
 =?utf-8?B?M2ZRS21FSG1OdE1nVUVNUk56S0ZOdHlydkVFMzFmbVRWcVA0SnFVbm9tM0hB?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7b9df1-77e7-42b4-2368-08de0acec25e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 03:07:07.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1FWMf7Dpg/RO1oV3YIMWz9KxuJDqTw7lDFjzbSo03wRo7kfriGmIFGJOKclcbp0KNQvfU7Gz/+01jTSIJPWZjT/JPesyjZS4b7Lrz6g/YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDAyMiBTYWx0ZWRfX4e22bG5b7XiX
 XhhzPU6Msh+3rrpLnXBph6mQM54mVPp8k/N5DL5MBb8NLl7onysCtOLe37BJcOJF0uApakFiqJ4
 PPGrVLB4/UUhDEQWErpvf1JkO5x28hMUBmFcpkPvkVG7eqiZuhMQJ6LGSc/osFOBIk2g68Re11i
 kEi3OA6Mo0hG1dYqhnyPhlDprmOTsOiseLWCq+5dRWRX3YM3wWzK4JTjWII7nlZIPyCrinhrf3X
 alboPxPmR+t28McWeVC0dbz+0xCUhDFDxOOaVYzOAEeatTzvph0GBdQ2R7Qh1BwzK/hwLDL81P+
 P/gIkfE0tuZ4/S1+x03CYNe2ST4tR5JQZpX++z9T2s4fyDLEzLVmQu6OVdUCjH+1A4v94/LOwDI
 7ZVMZGGWaYF9dcuFZTVBkJOm0BF4CQ==
X-Proofpoint-GUID: KMIpHHKEfI56iT__BABSUkECvov5yB_L
X-Authority-Analysis: v=2.4 cv=JaKxbEKV c=1 sm=1 tr=0 ts=68edbe5e cx=c_pps
 a=yMiMM/zaslgybVO5xx/4Yg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=8AirrxEcAAAA:8
 a=pfyni7RTWzDeVL4NsRUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=ST-jHhOKWsTCqRlWije3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: KMIpHHKEfI56iT__BABSUkECvov5yB_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510140022


在 2025/10/10 19:08, Vladimir Oltean 写道:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Oct 10, 2025 at 01:51:38PM +0300, Vladimir Oltean wrote:
>> On Fri, Oct 10, 2025 at 12:31:37PM +0300, Wei Fang wrote:
>>>> After applying the workaround for err050089, the LS1028A platform
>>>> experiences RCU stalls on RT kernel. This issue is caused by the
>>>> recursive acquisition of the read lock enetc_mdio_lock. Here list some
>>>> of the call stacks identified under the enetc_poll path that may lead to
>>>> a deadlock:
>>>>
>>>> enetc_poll
>>>>    -> enetc_lock_mdio
>>>>    -> enetc_clean_rx_ring OR napi_complete_done
>>>>       -> napi_gro_receive
>>>>          -> enetc_start_xmit
>>>>             -> enetc_lock_mdio
>>>>             -> enetc_map_tx_buffs
>>>>             -> enetc_unlock_mdio
>>>>    -> enetc_unlock_mdio
>>>>
>>>> After enetc_poll acquires the read lock, a higher-priority writer attempts
>>>> to acquire the lock, causing preemption. The writer detects that a
>>>> read lock is already held and is scheduled out. However, readers under
>>>> enetc_poll cannot acquire the read lock again because a writer is already
>>>> waiting, leading to a thread hang.
>>>>
>>>> Currently, the deadlock is avoided by adjusting enetc_lock_mdio to prevent
>>>> recursive lock acquisition.
>>>>
>>>> Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI poll
>>>> cycle")
>>>> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
>>> Acked-by: Wei Fang <wei.fang@nxp.com>
>>>
>>> Hi Vladimir,
>>>
>>> Do you have any comments? This patch will cause the regression of performance
>>> degradation, but the RCU stalls are more severe.
>>>
>> I'm fine with the change in principle. It's my fault because I didn't
>> understand how rwlock writer starvation prevention is implemented, I
>> thought there would be no problem with reentrant readers.
>>
>> But I wonder if xdp_do_flush() shouldn't also be outside the enetc_lock_mdio()
>> section. Flushing XDP buffs with XDP_REDIRECT action might lead to
>> enetc_xdp_xmit() being called, which also takes the lock...
> And I think the same concern exists for the xdp_do_redirect() calls.
> Most of the time it will be fine, but when the batch fills up it will be
> auto-flushed by bq_enqueue():
>
>          if (unlikely(bq->count == DEV_MAP_BULK_SIZE))
>                  bq_xmit_all(bq, 0);

Hi Vladimir, Wei,

If xdp_do_flush and xdp_do_redirect can potentially call enetc_xdp_xmit, 
we should move them outside of enetc_lock_mdio.

If there are no further comments, I will repost the patch with fixes for 
xdp_do_flush and xdp_do_redirect.


Thanks,

Jianpeng


