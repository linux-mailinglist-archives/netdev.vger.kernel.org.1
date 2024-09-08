Return-Path: <netdev+bounces-126283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94F970768
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE01281949
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04BF1E522;
	Sun,  8 Sep 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnPTGufm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C01C01;
	Sun,  8 Sep 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798815; cv=fail; b=UAJBLxE5OChuN92B82zqKF1KzyZ+2lB7pjMu90dtivF/UrVd20/MOJiQ/nTC02U3QmWyZv4bjZR/lPuQFyUpFjRcqlibb1abvXjAbQQcdtYZQpq48eZwjoqL+42+rnnecWqKTyjihTnQymoqByEQT2qHJjnOta/YR6BnUiBzvOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798815; c=relaxed/simple;
	bh=Ea+gH1TspeyKHC6X2YrzeN8U/IjjWrC1Hullf7tFc1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hu2UeVCAty34IhURRCVGqNg008+MIaO936OZ7rEW3RrPPvOgiFnnzyNZmZdZlzJVvJwUzP0zm520kpwCpnUcnLwfMUfG9ppO+AubIE8GKndubnlFBYCqFtF/Mq9ZSOLZoV5oOK775Y7uu5ZAk9x1oubpZ1nUsfqjQTho1s9039k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnPTGufm; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaiFXA3wC9a1LyWPmplewY8FBGnvncCcgLTLdJ4LRaEjuJSzsmfSx17f8uKi9Z8rXChaTh1q/UlKNFDxVz3ucgDXnvnaUW1lMq8QiJEN00NEbyIETOMlasIfSEi3XAkQtH1ZWHKKiijxPASvdcxWbf6/ZaRZKGsPhGF9an+I/9D3L9NYctSRfS5Lgl1rV/UQilH+QaV5e/40kIeKgd2MYlwJygeqGImIEc3BeqIaw0crfKOpz7GPMxmyYPY+fF6hbezx3gq5DxxOHkGhEoUPtFRO41K0I56AfHi/IXcNxfs6UUbvJg/+uGbPM9AI9IxV470Nm3/Bj7DEQ67htPCS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea+gH1TspeyKHC6X2YrzeN8U/IjjWrC1Hullf7tFc1I=;
 b=wFq7ayNqzlW+EeOQYDT7/48MgG7QLW3IYRFwzGyweIOGcp9ENU0jadGkWm8dkdl+nFwMgxlybSS0RR0mOCbkVGnRJnsk6FlC0/zN3svhUnv011OLO5+tErWDqn1e3sEfJO3E0KxukEQkGkRVjFDhAW2lE6yKwRJ4ldnwbeQTz9FiIrMbpPPRub5rXmfNHox+fG2wys8WPVYVRj4MHwCngQJf2EvG+l9YOTqk/VBJIIWNzSebjtuBhK98+iWw6cqhILhZOL0/sQQ1nGT0t7ir1bBRxu+3t7k1XK0LWLqUJ+Kf/P8AtfP7eQ16Rsb+7RU4oFOtFMBHqU2YLPHaVolKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea+gH1TspeyKHC6X2YrzeN8U/IjjWrC1Hullf7tFc1I=;
 b=cnPTGufmUsHicMBYQh9wH7vKLvx/zEQnpgzsOpxtUBLN3ksPAwA/x09rEjbfIJ66mxFdVBltQWgDrBGGZqoNy7KDlvCOmrARieuR9Kn7Sxvri21xHe1/5tt+nII/iY2Rh+xWgkTWnCiWTdZrx2iImLajov2Tlko1VJLd5xSlCMt9TkQD2xv4+3wDtARr3TYMaLzmsrLNknZtbCIYhkgU1dXOasgeVixAgA/HP/+G2igk0Dl8piw/fu6lzufPTkKke3WtQm83NzOmyqBcWT8ph56t/WL2bJovLKt4iduZ4YyZAk6JoVC3BpGE9Xr1F5T2UHvDnlwcBwmERF2gzG+PWg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sun, 8 Sep
 2024 12:33:31 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7939.017; Sun, 8 Sep 2024
 12:33:30 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next 1/2] net: ethtool: Add new parameters and a
 function to support EPL
Thread-Topic: [PATCH net-next 1/2] net: ethtool: Add new parameters and a
 function to support EPL
Thread-Index: AQHbACGuaq+Ty7e4PkykxDXyqSCqnLJK5LYAgAK1aOA=
Date: Sun, 8 Sep 2024 12:33:30 +0000
Message-ID:
 <DM6PR12MB45163C3543368036C03B6E05D8982@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240906055700.2645281-1-danieller@nvidia.com>
 <20240906055700.2645281-2-danieller@nvidia.com>
 <970ef9b1-609b-4137-a76f-315c99fbf112@lunn.ch>
In-Reply-To: <970ef9b1-609b-4137-a76f-315c99fbf112@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|MW5PR12MB5681:EE_
x-ms-office365-filtering-correlation-id: fe21de31-e055-4646-57d6-08dcd002725e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2JpT01hV1lBSnlDOE9MSHNYMkhxY3ByYTFDcXdmanRhSkZ3bkd2NHNRSVlU?=
 =?utf-8?B?aHNPRTJRUklyU0pYUGxjNkpoTS9TUFdSZ0kwTS9STWJmWTNzd0VmekpKdjJ2?=
 =?utf-8?B?L21pQlB3MTB3RklNaVhVMW8vK1VWYVR6TTY1Qm5NYWtDOGJHcUNiZlk2UThQ?=
 =?utf-8?B?Q2l1V0tTc2h4VDI2d1dpTlhBNk8xOUFneFRzemN0d0VQZzB0bHR4U1pXWGZH?=
 =?utf-8?B?NE40M0g4Y2dpQklkZ2d5NFVPVzduc2o2c0pDTUptdEFHcWVxNUlLMXYxY3Rv?=
 =?utf-8?B?UXNMYzIvaVVqa29NdG02Wms3OFB0QkhqMUdaRm1TYnBWa0tJckJ4Q2xLZnAw?=
 =?utf-8?B?SHppYnZ3T0F0WGkycTA1ZGQ2STdtaFJBb0gwbkUyNzI5bVFuSWZRMUVjNHFM?=
 =?utf-8?B?TzQ5b0FvZmk5YXhOZlNaMG1DTVVNR1FuNTBrNjBQbHJpYkZQek1DV0s1L2dq?=
 =?utf-8?B?TjM4cVh2SHluQ09UOHRvUWVsUnM3bmVBK3duc215QzIrakNTbXhURGxBRjhI?=
 =?utf-8?B?N3pnWVBxbFNWcVRzVXQxbm80MWZCMWczT0wvRTZvMzUva2s1bGNiNjg2Smdz?=
 =?utf-8?B?UGJ4azFOVnJGK0VvZElTWFFZcjI5R3JIaWpEVTc2TGlWeVhxaVFOendvektT?=
 =?utf-8?B?d3ZTMWNYM2F1a0FCV2R2TGRDS2haa2FMUHZIRWdUVW10aHA0ZC9xT1ltVy9s?=
 =?utf-8?B?M2dJT1grakpKbU9QVlVrTFZ4ZS9qUE5SaHdZQ1pOeXArenp3RURCamZJMDkz?=
 =?utf-8?B?dVI1RmhwOWFMSVhGS05NZlBpV0drV3BqZ1F5aDFDRUswSmRtb2hRbExXbmM3?=
 =?utf-8?B?dUF6eHRQTmErbWx4YlpmQmFDbVB6Mm1lZk9oRmU2Z0lFYWFpakhoKy9NUklm?=
 =?utf-8?B?dHp1RHovOVkvNDRSaGIvYjJ6eWVZQnFaRUZXU2NkUk5hdnlBY3VtckhZQmRt?=
 =?utf-8?B?NHJtVlQ5K1B5bmhFMklKc3c0N0ZiZWlFUXg2Zk5pSmo0THZSZGw5Q09DMW1i?=
 =?utf-8?B?SHp6NTFTY2g4MktrK29XemthUW5LT3dpRGpKZnk5QmF4dTZPMkxyMFpwWWxP?=
 =?utf-8?B?cDhPUXlOTlVLTFVPSTIzOS9acTNQdEZaRVZSS2JQSldheTZzU0tnZCtvOXVT?=
 =?utf-8?B?Wm1XTmFnUDVpTTUvQU5TdFNOTlByeXFpRFAwVFdjUW51U2tZUEZpUDRsOGNt?=
 =?utf-8?B?SUJlTy9TQ2o3WklPd3NxcXRjTDBZcnhJTkRjT1NUTVIrTmZHMFQ4ZUZlOEZo?=
 =?utf-8?B?NU5HTDRscmJ5QWVYOUc4LzNNbnNRV2tXcmh3cC9tN3E0d3F6blRnR3ZsdEla?=
 =?utf-8?B?MG8wbmNESVQ0Ny9vcDdnUUxoSmpBbVM2YVFDT29DcUExVDgvNldHeVhzS0RX?=
 =?utf-8?B?cTN4STlGSTUzK0cxQ0ZMZnJlb0NDYnZ6SWtUaVJJTlVQUzN3RExJNkZRZTRE?=
 =?utf-8?B?OHc2SWhYbUlHNnFjRHNVNlZTb0hROUg1OVFId1FBT1NuV3NSM1pGeDRlV1RX?=
 =?utf-8?B?a3dkNkN3b3IvcHFORVc2RjdTTmg4QzRyRnRreEx2TThuRGFEdk9WcjN0d21u?=
 =?utf-8?B?MW05NUp6YTNzSU4xajZTRVNBTTdhSE13U2M4S0x4S2Z3ZDFzdzBROEZ2Tk5L?=
 =?utf-8?B?RzRSbXBSclJaLzFrSi9sclc3TWJiV3FQRFNHRnlpa1YySWdDeTRnU05IeERM?=
 =?utf-8?B?QnFsUGdVeVA5MlZnczlLRGl4TFRsWUplNzE0STk3M1NVaFlJdFg4QTMzZ1FC?=
 =?utf-8?B?Zk1pa3ZYbW1IdmVDWnRsbFRlOGhXdEltZEJYUE9VYnEvRHB5bHM0V0RXZWRN?=
 =?utf-8?B?NUd1RE1YTW1ibjFTQkpEemdoSU5BV1V3WkxCUVlGKzlJcmFBUGN1SFNQZ3FD?=
 =?utf-8?B?MFF0MUtvekpGazFhSUMwbHd3WFFEV2VjdWk2cGxOOE5Menc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmE1V2IvN2JYM05XRnk3OW80NlZBVGVEN0Jka0JoL0NoV244NXA1aU5JVmcw?=
 =?utf-8?B?Y1NBQlJCVDZJOTc4ZDB2cEg5elY0SU81QklaM2d3VGNzYXdaYzNNN056Tlkw?=
 =?utf-8?B?NktyT3NFeDR5dzUybnFMQW4za1lNSERnQlI4Y1FFRjAxUUxydHVQeWVnTTNx?=
 =?utf-8?B?VzJ3VDVwaG9kVm9kbUo0WThBUWtIVEx3ZXdFM0RCWWFYYnYyYUxXQ0VtekdL?=
 =?utf-8?B?a3loSVpMTTdKODAzdW1UTFZ3OGY4WnhBTzhTeUN5bnRSeW9PNFM0MjJvMCtM?=
 =?utf-8?B?TGIvMUh1SkRJcW9kRkc2OWc5S1BFdk1FdTBYYVhQRFduTHRza0M2c2lkNzFt?=
 =?utf-8?B?cW9KcVFpWGtRNTduaUl5aDJXaE5Cbnp6cFBOcFpoeUhOV1NuUERjbVUyeG9B?=
 =?utf-8?B?bnQxTXJla20xK1U0SmRmRHZlVERFMmRlVS9iMG1WSDZxR0tQRnF3dGF1eVRz?=
 =?utf-8?B?M1dUWkdQUFdFNmdTamVXdStzeHdLZkVIVEdGa2RyanVzR0RSckFDSkZ1d25H?=
 =?utf-8?B?TC9oMnhUbVpLTUFRUzhPRXphbE8vSlQ2YzlkdUVTMGxuVDgxa2poQk1rZjMw?=
 =?utf-8?B?eWRYNVE3ditqNFphWVl4YnBFSk5rSWJudWNwYkN0VXpTdTFXaUZGdUZuOEFz?=
 =?utf-8?B?MDJDblNIY25nYU5vbmhTbkpEbk5qQmVCa3UxK2g5Q2NSbFlzSXlhclc1TitB?=
 =?utf-8?B?eUJ2TFJJV09YNjJTc2JKcVFRTHgzNEhzc0dwLy82Tm91dGVYL0lEeFkvWk12?=
 =?utf-8?B?OUh4NmkwRXUxVVNyZWoxeFR6NHJla3VaeHNCWFZ1b1BLd2NVTDhLMG14dFZm?=
 =?utf-8?B?d1l2bGpPVFNRRkMvUjVFbkZBLzZzUmw5TzBzKy8yUVFTVmxnMEFpRWhlZHJ6?=
 =?utf-8?B?Ym1mRWZ6U2wwTSt6cWprZFFVQ1JGMVROZHBrYkJQWXdjUVR0bnlDZDNqbnJl?=
 =?utf-8?B?NUorSUNhSWtJUlpDazdzdGRpM3FhQURUdmo1eGwrV283YnhqdFlOaERYanVD?=
 =?utf-8?B?SUYxYUs5dVpoZmZxZzk3eTk1STcweXlhSk0vUFZ0UHRWTTAvc20xQVFzbVZl?=
 =?utf-8?B?U2xnbnNvTVp3TDM5Q1JiVXpWbXo2KzRBcDN1L1lydmJrcENrb3h2YmZ0VjJI?=
 =?utf-8?B?ekFrZUxmc2RmL1RHOWdTeWJHRm1oblFvNFUxVGdCa1RjcXp3UzJ5enRDV2V2?=
 =?utf-8?B?cWNveFFjN1hZSU13M3BFT0lhL3VUeFFmSm1yUE0zWWtMc1N1TFJDZldFc01z?=
 =?utf-8?B?Zm5hWW93TXhCRlRiYUd6UnRoUStxSnNpTjlqcU1Xejl3VjRWSldMbEV6Rzdy?=
 =?utf-8?B?WmMrcEYreUhnRXpCbjg1T1cvMWh2UG1jSVZSN05WNFdlSmlBS0tjY3BkRDU1?=
 =?utf-8?B?V0VwZUdZTVlUbGRxN1R5L3hlNXpic1NFSWRWZ0tYWnU5MnAzL3FxMTVyUHVp?=
 =?utf-8?B?bVRsekRZTnZTTmtXbXZaN2ZmNytQSzFLWkNLVkZIMUpRVDZnN0NjSmpwb3A3?=
 =?utf-8?B?OGtrTVpkQkZVTVQyUCtpaTRVbjdRdkl2VUNnelgrM0dtdTcxQm5la3FjbTNp?=
 =?utf-8?B?bEJkWWpBRTNmSS96ZW4yclY5VlRURlJiekpMcVg0OVNvMkJac2VsWk1YT1dQ?=
 =?utf-8?B?a1pIL3ErNHRYczNVMzB2MHpHTklTUmplZ0FtTml1U0xIWWhELzg1N2VRSEE5?=
 =?utf-8?B?enN2Qi9nei9mTVd1cWNNRkZ3TU5zSVJuVDdaUDNCbGppZFlQWWRzSldqb3ZZ?=
 =?utf-8?B?NDVwR0FwbEtJdnZuOGpkYkl5cTIyR29JYmRBTmpCTURNUFAwSDZ5ZlphQk9z?=
 =?utf-8?B?QzZyRWFNZVY1REc2Z1F0NGh4RGtCWmlpU1hKS2FOQW84UnR3bVMyalp0MlFi?=
 =?utf-8?B?MmxTT0RwL3Y2TnppdTY0cDEwSnNKdDAvWmFXTDZjL3RuQjBMY3VjKzFXZEFG?=
 =?utf-8?B?QllDblkzK2MyZE5pZCs5enVKZWlNNlFmdklQbVphTEN6emZOZFdVa29UOHdJ?=
 =?utf-8?B?MWJnMVVyb2NDak5wMklWVi9ySE5weW0vWVhRSlFkR3A0SlpWNGpuc01TUEF3?=
 =?utf-8?B?Q3QvcTN5c0NMTE9KcDRMSFFVSFZBcWNKSW1xOVdtSXpoZHpRY0lsUS9mUGJO?=
 =?utf-8?Q?JQZiKQ7yQVeUtEQxL1i1+fMJp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe21de31-e055-4646-57d6-08dcd002725e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2024 12:33:30.6861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLDp6oHLQnmxcR3QGSQ1EIxoyvbXJTdgzM8BvvPnuj/Cg9p+ShC+Moy09IV2prMJJEDNnRi59ibxga9ak1EZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

PiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IEZyaWRheSwgNiBT
ZXB0ZW1iZXIgMjAyNCAxODozNg0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZp
ZGlhLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhh
dC5jb207IHl1ZWhhaWJpbmdAaHVhd2VpLmNvbTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFBldHIgTWFjaGF0YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBuZXQtbmV4dCAxLzJdIG5ldDogZXRodG9vbDogQWRkIG5ldyBwYXJhbWV0ZXJzIGFuZCBh
DQo+IGZ1bmN0aW9uIHRvIHN1cHBvcnQgRVBMDQo+IA0KPiA+ICsvKiBGb3IgYWNjZXNzaW5nIHRo
ZSBFUEwgZmllbGQgb24gcGFnZSA5RmgsIHRoZSBhbGxvd2FibGUgbGVuZ3RoDQo+ID4gK2V4dGVu
c2lvbiBpcw0KPiA+ICsgKiBtaW4oaSwgMjU1KSBieXRlIG9jdGV0cyB3aGVyZSBpIHNwZWNpZmll
cyB0aGUgYWxsb3dhYmxlIGFkZGl0aW9uYWwNCj4gPiArbnVtYmVyIG9mDQo+ID4gKyAqIGJ5dGUg
b2N0ZXRzIGluIGEgUkVBRCBvciBhIFdSSVRFLg0KPiA+ICsgKi8NCj4gPiArdTMyIGV0aHRvb2xf
Y21pc19nZXRfbWF4X2VwbF9zaXplKHU4IG51bV9vZl9ieXRlX29jdHMpIHsNCj4gPiArCXJldHVy
biA4ICogKDEgKyBtaW5fdCh1OCwgbnVtX29mX2J5dGVfb2N0cywgMjU1KSk7IH0NCj4gDQo+IERv
ZXMgdGhpcyBnZXQgbWFwcGVkIHRvIGEgMjU1IGJ5dGUgSTJDIGJ1cyB0cmFuc2Zlcj8NCj4gDQo+
IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjExLXJjNi9zb3VyY2UvZHJpdmVy
cy9uZXQvcGh5L3NmcC5jI0wyMTgNCj4gDQo+IC8qIFNGUF9FRVBST01fQkxPQ0tfU0laRSBpcyB0
aGUgc2l6ZSBvZiBkYXRhIGNodW5rIHRvIHJlYWQgdGhlIEVFUFJPTQ0KPiAgKiBhdCBhIHRpbWUu
IFNvbWUgU0ZQIG1vZHVsZXMgYW5kIGFsc28gc29tZSBMaW51eCBJMkMgZHJpdmVycyBkbyBub3Qg
bGlrZQ0KPiAgKiByZWFkcyBsb25nZXIgdGhhbiAxNiBieXRlcy4NCj4gICovDQo+ICNkZWZpbmUg
U0ZQX0VFUFJPTV9CTE9DS19TSVpFCTE2DQo+IA0KPiBJZiBhbiBTTUJVUyBpcyBiZWluZyB1c2Vk
LCByYXRoZXIgdGhhbiBJMkMsIHRoZXJlIGlzIGEgaGFyZCBsaW1pdCBvZg0KPiAzMiBieXRlcyBp
biBhIG1lc3NhZ2UgdHJhbnNmZXIuDQo+IA0KPiBJJ3ZlIG5vdCBsb29rZWQgaW4gZGV0YWlscyBh
dCB0aGVzZSBwYXRjaGVzLCBidXQgbWF5YmUgeW91IG5lZWQgYSBtZWNoYW5pc20NCj4gdG8gYXNr
IHRoZSBoYXJkd2FyZSBvciBJMkMgZHJpdmVyIHdoYXQgaXQgY2FuIGFjdHVhbGx5IGRvPw0KPiBJ
cyBpdCBwb3NzaWJsZSB0byBzYXkgTFBMIGlzIHRoZSBvbmx5IGNob2ljZT8NCj4gDQo+IAlBbmRy
ZXcNCg0KSGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQoNCkFzIEkgd3JvdGUg
aW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB0aGUgRVBMIGlzIGFuIGV4dGVuZGVkIHR5cGUgb2YgZGF0
YSBwYXlsb2FkIGluIHdoaWNoIHlvdSBjYW4gc2VuZCB0aGUgZmlybXdhcmUgaW1hZ2UsIGZvciBl
eGFtcGxlLCBpbiBibG9ja3MuDQpUaGUgTFBMIGNvbnRhaW5zIGFwIHRvIDEyOCBieXRlcywgYW5k
IHRoZSBFUEwgdXAgdG8gMjA0OC4gVGhlIGV4YWN0IGFsbG93ZWQgZXh0ZW5zaW9uIGNhbiBiZSBk
ZXJpdmVkIGZyb20gdGhlICdyZWFkV3JpdGVMZW5ndGhFeHQnIGFuZCB0aGUgdHdvIGZ1bmN0aW9u
cyAoZXRodG9vbF9jbWlzX2dldF9tYXhfbHBsL2VwbF9zaXplICgpKSB0aGF0IGNhbGN1bGF0ZXMg
dGhlIHNwZWNpZmljIHZhbHVlIG9mIHRoZSBtb2R1bGUgZnJvbSBpdC4NCg0KVGhlIG9ibGlnYXRp
b25zIG9uIHRoZSBjaHVua3MgdGhhdCBhcmUgcmVsYXRlZCB0byB0aGUgYnVzIHR5cGUgbGltaXQs
IHNob3VsZCBiZSByZWZlcnJlZCB0byBpbiB0aGUgZHJpdmVyIGl0c2VsZi4gDQpUaGUgZHJpdmVy
IHNob3VsZCBiZSB0aGUgcmVzcG9uc2libGUgZm9yIGJ1cyB0aGF0IGNhbm5vdCByZWFkL3dyaXRl
IGxhcmdlciBjaHVua3MgYW5kIHRoZW4gc3BsaXQgaXQgdG8gdGhlIHN1cHBvcnRlZCBzaXplIGNo
dW5rcyBhY2NvcmRpbmdseS4gDQoNCkhvcGUgaXQgbWFrZXMgbW9yZSBzZW5zZSBub3cuDQoNClRo
YW5rcywNCkRhbmllbGxlDQoNCg0KDQoNCg==

