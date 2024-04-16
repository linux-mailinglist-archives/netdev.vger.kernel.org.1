Return-Path: <netdev+bounces-88482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E938A76D1
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5236B230BD
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC484FB1;
	Tue, 16 Apr 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JxU+6P7f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ny4p5Svl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEF6CDC0
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303277; cv=fail; b=IHihHn1GHqjN4ikF7zrIStMbABF4zK/ED5Z6ugPBbhVreOM61HfZ90OHpUSPOG7APJz8FCdWcqaAJqJW1mdJG9QnnVC7wlkdAQ0UJ4f+y32fBohNC6k0KIlU4hSYNHt1MXsDd/maMEQpZcfFP+wwCcVB4V4u9bunWUkh2ABGVjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303277; c=relaxed/simple;
	bh=JEbvgR0mo6u8OILRaQqSKdFmiAhRSoNiVnZxEXidOwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OWNPPNqDoleLGQDHdtxFaPV5dj55pdOy4E3bIxhVbanP64PzTaqceFEr/YlmlLJ269/WewbSX2G3zuP5dBWot2Xg/2JuIeFyeqEdpeHLHm6WanfHL+S99NcOacgoAmoDkseRxXgZi+AYsQ8qExAaawbEO1HmIpxboTC2i7yb4Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JxU+6P7f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ny4p5Svl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GJjvA0006470;
	Tue, 16 Apr 2024 21:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZQ2KWi87qz1wk9ASxZBC55wJzf6jAKPt89ZvLikORLk=;
 b=JxU+6P7fFvJxvHlqBZBqvgpbk61cVyPv5QzynEEfIQX7mxC0GtyXSQsxNtNEFaWmHXnK
 kuNKZTBWk3KAuL+3tJ3+hEW9aRmBFRsfzK2YbLwIPAUJFLljBWMmz0hX46SN0lKqs85D
 bSQmYMN63X1tVA/Du7sbxp34i7LqDRIyfgYIrTaBxPeD9VkPC6D2agEROUSDrYzaxASC
 0lKMaZ2qWrbpNwId94vmdb5yLbVlc0SFEIJSC1zsdeInVDcVZX7dz/Z3g6fk5HWqQRlA
 jiUEv49YPJ+XxPLa7WACPIKBcbbk1NuTy7bwbZykdgoS6d4RAv8cS5SYN07KFG/jUt1+ ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2pd5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 21:34:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GLRakq022438;
	Tue, 16 Apr 2024 21:34:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgge5678-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 21:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgj1QM6AZZSoxCbelP5G2+kxC9mzeQIFt4OvlmHKgEjmgosXXhHBHxsMOodHC3hZzzPs33VBXgizMf5phvQVtp0OSdjghYudjTAky5hA4tm0gmXzKWz12mASDSFGtjeNhfDvY7FIoyq2m2NvVDmkus7nEhhcwc64R+Zwf1PbUciVhHxCgBq1bzdXi9uM0xAMkFYi6/DhYtT443///M4LY89XeEWUhLOdKZeosRuXj9Ig7eUp7Ysd7soaruum1xtgaetFezygelIc3xqapcoRB4iS29Q9qOwkEBQxJL9G7U7WOAd3MyOaf19Lqx352jw5d9liU7GNl3fmOaf3CPu/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ2KWi87qz1wk9ASxZBC55wJzf6jAKPt89ZvLikORLk=;
 b=meJe9FhfwD0u3QsdEHu+zvpLshyuyeFkFeEELfpPlX1jIw/f1oKFkiBLVYsJ0bTn4GcVV1ZHtmqJPQPW4BhGw7kuhA6UDMTeOxrSs9aQQQkekClKewLOzEc2SBKzyuEzgQcglssCHtytTXnx7EQg/RHnKyQSkbnnu8ROjT9ovT0oBeHLIvfyzmNjUVwZf6wIhxApaOZn4X6QZSpMjVMzQTzk1Gb3boIMGZCC1iGXOyywol6nc6OBlktCw+Kjhfsug7qtsBzLAKVeM89leNQBMzfz47qbyX4xGVnQOzUfXlQmJei5dMv2CyFImZVjd52s7FipkFwvBpySpvPkNqn13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ2KWi87qz1wk9ASxZBC55wJzf6jAKPt89ZvLikORLk=;
 b=ny4p5Svl1bTbbFaaNcXXeSU2LGdaMZiVAp4kphVekajx9ubg6B7gXlA5u/0jBPZLrLFs39slbYUyTqASEwQZJmKl0SXDbkfRuNyaCydDfVjbG3yMR9e+E2O9LCPxZe9Fi99QrL4RyV9SiYVTM0gZZumqJxh4rIFpnk1dVhEDE0A=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 21:34:21 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%4]) with mapi id 15.20.7409.053; Tue, 16 Apr 2024
 21:34:21 +0000
Message-ID: <a7fe079c-5ed7-4ff6-a127-adb34b2246f5@oracle.com>
Date: Tue, 16 Apr 2024 14:34:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <3e4ba1b4-ded8-4dd9-9112-a4fb354e1f55@oracle.com>
 <20240416205125.13919-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240416205125.13919-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CO1PR10MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: 822428b3-caf9-43f2-0ea9-08dc5e5cfa8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	A5tEjig3VSdxBlIL+q6CrVLamcYxFKp73E3bhrJn1JLWShA2jCQRzSYExkOalF6Dro30eLimPkn8P7Z9c1Svpaiakent4xYrgNsu2AgU+ne68AbNw+joVC1Mc/H77PST9tzOA7Rms0FXWuZ9uSzxknBpfN9VQKJ6eW6KeVipltIaCrc1lB0+r0LZf68usHF4ke+HrWkDriXw+y7O4OINZk3bkp+eXzUiVxxXujGR4CaQZ8fibZZaiYP4EtOgpnkesWBl8L7Vh1y6zMUi14BCW++szSPDB6Ek84X/i6Od2gV7JLmGuXrz2goHM48Uq2CaT5FPwLh2sgSla1XvMMWi0071ht88kipJ73bKNyy8cH2t/hblshhkfHCS1aigBx9KT7/mTofl+TW9McZpXlbFFqkAHJw4saa68zBG540h44tuBfB1ldeZbkACHDctas/7pGcBtRjdIJXurgBCvmwFlMo0Uj5954Rw8Ers3H0BJJzRKlVN0YRHr2YjnLGZxHG6VYuJy3tkH2DGQAVvE46r60GEete5M0XvEOeeNBQkmsdlekNqw6M9MO9K/nkZ0v2YtFFfYMw5sHjlpfcwi8n56m0SHeqIMwzVHGcBB4IeOoUdkxFNUegUFPG6B9MsGhH/tX9BwSGb7LqyWcjm1xo9ZhpBy4+TZdiSGFdIuxnWHEQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzFJUElhRk5VMjd3M2lrbkJGc3p2ZTZUMkdycGovZkZYM1Z4TmNvUjNJVVNO?=
 =?utf-8?B?aEptY0twczNZS0V0UktaKzN4WFIxTUNrUWVSd0FxWjNudzJGdnNkQmYwZHVx?=
 =?utf-8?B?aC9ieEFmNmc3dGRNdkd0M3hHbll1bFBack45MXRWMG9yd1dpakVvTktGcWRF?=
 =?utf-8?B?K290Z2pSbkptZG5DamR2U1FYdHVSak1vbjJxWXp0dFRTL2ltVmhQYmdueTc5?=
 =?utf-8?B?aU5wN1dpNGQ4ODBZeEZSNHhlWjdDYkNqVnUwSmVSa0NaUGVNMVlZK3BaRFd2?=
 =?utf-8?B?eEZ6Ukc1aFdBMnhqQU9hdisvc2ZUdWJJMnc0dFJ6WWVCZ1BWMVV5U2dsUXBP?=
 =?utf-8?B?bzhyRENETXpEYXBDNjU3MVczU3lBNWlNYSsybjg4a0tGbGM4dXJTZE81alZ4?=
 =?utf-8?B?b1VYZUpzRm1HVTNZcG1TdG5vVTdVWHFvdEFPY0FCN3NncEJHSGNMMm83cnE4?=
 =?utf-8?B?MHRZRW03cjBqUUVtR3JsRGNDK1c0NkIzcFVTRnNYOE1ycllBeUdJcFhnSTBF?=
 =?utf-8?B?eDg1ck9pQ3NGUE9kZzl3N0NRYmc3M1lvQ3VFNXA4cVR3VjFYSHA3eUZNazUr?=
 =?utf-8?B?Wm9vQnl4N3dlT2F5Y2JXakV5QmlIVTZGc25BdFNpQnFnc2FGa3dDY2J2UDNN?=
 =?utf-8?B?Y2hHZnlhQkRZYXk2SmVWVWVPRDZRWldkanlGS1FzYm1CYm8weERkbGJrejBY?=
 =?utf-8?B?b293TUp2clFYNWd1VjRHdkM2UVc2WjlJUDMyUWh0anZDeEErcjAzZGM1NTZG?=
 =?utf-8?B?dnBhL1BHWVZid21WWlZuZ201WUlqd29IRjR6UFVmTURVKy9JYmh2L0psaTUv?=
 =?utf-8?B?dHI3ZmFSU1Q4TWtxK0pDRE5rSWpuNXRlWnRiWTNydjVZUnlIYjlQQzA0S2pY?=
 =?utf-8?B?Y3kwdC96Mi91ODZzSnJ6ZzNyWk5lZnpTTVVCZGFRaGR4NWIzaHZCTkplME1m?=
 =?utf-8?B?ODhwY0Y1ZGcvRGlpQzJSNTBkeXpoeDZ6ZzVKb1hqblRMYmFqejd5a296T2dG?=
 =?utf-8?B?RldEaDQvRjA5S2VHUFYyUWllVXdBTlFjbkVNU2pnbi9NMDZ4V3B2KzlnbzVD?=
 =?utf-8?B?VTgzSVQrSHB6VVoxOWNJTmlPK1hMNk9aTzJibldxbFBrL3Z0aXlicnZUd1h5?=
 =?utf-8?B?R3RKL29tdXVrejFLQnhhQTN2QU82VktzbjVCR0JhMHRpcGhBVUplVDZoeXVK?=
 =?utf-8?B?dFJuODYreGdPdjdINVRhcHp1d3JqdEF1UUJtV0pLbnZOcXk0T0FkOTBKdmk1?=
 =?utf-8?B?Q0xGTlpFNEdROU9xMVlCWVBDMG0xVjc2MFhNeGZEVHRHc3NSdzhKV1NSelo5?=
 =?utf-8?B?WDVEWmZhTlZVSngvdWR0VmpCNmVjNEpSYjlkY05ycC81Nkl4Nmc0b0tBMDla?=
 =?utf-8?B?Q2VUdTBxR0xlUngyeVc1cndUc2JpY0Z5SW5MelRkS1NPTUhPQU9LNTFwNHEr?=
 =?utf-8?B?SVl2OGVCRGVTaXVwQTdiMnpIcnNMd3d2aEYrc2FUeHMxUTRtaGVnczJNVFBy?=
 =?utf-8?B?VURBeVNRcmE3UXlIdTJxWFVpc0VvUTZqTFZLZ082QUJVODVaQlAwVVQ1TG1r?=
 =?utf-8?B?Vi9YV2Q5MXJ6VzBsbzNqMHFHYVNmaGtsQUJrODM4L0VRZEtwWVJld1M5T1FQ?=
 =?utf-8?B?SWEwUGQrOGZMUVVsNGhrOXRCZUE4WXZ3SG1vVjd3bEtUVi9oRkN0c0Z1YWVB?=
 =?utf-8?B?QWw0MFRaazROcXZpekMvNW9KVGVheXJ0aG5wUGJiVkNxbzFkRlIwbXlJQ1Ez?=
 =?utf-8?B?NnFFcm9ldzdDcytWK3NEUWF6R2lRRmptSWozbzNBVkhpVlFIWkUwcnNUQjA1?=
 =?utf-8?B?WlA1blBVOGdjS1B2TVZ1cEJRVXdvUUtscDliQlhweFZ4bEtIcGhibkgwQmJW?=
 =?utf-8?B?VXhrcUFWV2dIUHlFMnRET2dnMFYvWHlrczRla1ZZL2FrcE1WdmpIajNKL0tk?=
 =?utf-8?B?RG5Xd2xZeWhZMmt1b1FBaVYrMXVzZmJNK3grZGVEUUY4Vks2RHhaRFI1NnJi?=
 =?utf-8?B?MDIxYmxtbEQwbkxXVUlJSzBPZnd2TnhEOS9SREF0Wm12ZFVldTAwZnR4aTc3?=
 =?utf-8?B?aU1qUEhkV1dGU05xNWpCNDlVK0g2TndrNm5NdnhJTDFrN2Y3R2R1MDBoc1RL?=
 =?utf-8?Q?HkaV6ue0jb4FKgPb04dTxen0v?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3OUKRPusPRAFMIw7MwADXzQd6uqvnHQd7lb/kRG09RaGRkTANQL2N0MjYpVsPK3/mnBnLu3k3DrrtpGeJTD7XbjiwNTREIB2ToY+Kwdug41BWOS5POd3e7DjCAJQDxTz6/c6pljrQ+NE3XB7wv4zd+cUCFmbt7Wcg9brxrHHR7Y1cZPTxSnLVVj/J0tzIzLq1ezZke4tmXgxT0NF1teTSCNy8SA4t/D1I5GNZNMgMGt0xvRh8ckgzjYL2KNUUwoGbX1FqnDDiC2JUNHl0qCRQ+ll7H+UkODkj2QGk4CubmVGJyCzuecWLCftNeEOFR3aukhZAv64v6zhZcQi8g1jUGYpcF66UabDr4RDs945+MKPftrpGzL6+i3tIGU7gakqdeQv7jOh7UyOO1yI+fXoo5uIdiMlIhu8d3pO+vAQJiIQZreehn476iK5O2FvZDd/NrQB7yWYGIFvu68zoCDfemZEtTpvP9rvGmH6pmOqfl+w0XV0TKY/RJfTlqyu6vtlgmjmq57AstMwtHuz9Xy1CaXtuomC0UE3esqkoVnw8rzqytKsGb/8HTZL3disyxZycibUEUcfExt3eY7MCOwqpp6NpQQvTdoYwgrOGYyTAKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822428b3-caf9-43f2-0ea9-08dc5e5cfa8d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 21:34:21.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REBo5bbcHu6Gql2NFW8S9DZ7TnZo+hfEl3MXstVNX+ujdRCbS1CFfd/3qEvPV4YhaVbtYTonUmigEXaGVsD77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404160139
X-Proofpoint-ORIG-GUID: j_sEn6EmZ-xWJmD_iCSwW60no_DN5kzb
X-Proofpoint-GUID: j_sEn6EmZ-xWJmD_iCSwW60no_DN5kzb



On 4/16/24 13:51, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> Date: Tue, 16 Apr 2024 13:11:09 -0700
>> The proposed fix is not the correct fix as among other things it does
>> not allow going pass the OOB if data is present. TCP allows that.
> 
> Ugh, exactly.
> 
> But the behaviour was broken initially, so the tag is
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> 

Where is this requirement listed?


> Could you post patches formally on top of the latest net.git ?
> It seems one of my patch is squashed.

I pulled in last night, your last fix has not yet made it (I think)

[rshoaib@turbo-2 linux_oob]$ git describe
v6.9-rc4-32-gbf541423b785

> 
> Also, please note that one patch should fix one issue.
> The change in queue_oob() should be another patch.
> 

I was just responding to your email. I was not sure if you wanted to 
modify your fix. If you prefer I submit the patches, I will later.

Shoaib

