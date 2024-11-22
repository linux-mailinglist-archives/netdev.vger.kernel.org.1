Return-Path: <netdev+bounces-146780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C1C9D5BED
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 10:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B569B23292
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE92175D29;
	Fri, 22 Nov 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dRDlC0Lm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1310A3E;
	Fri, 22 Nov 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267664; cv=fail; b=n28QK0JmWpceXCbXh9akvEug8g9houYG+OplURlBmd8CS8UCjLgIhdgJeDp0tR3Qp18gPwxVSin2iSLMb6E0czn/QQ6yxkSQBuHkhGnS92wq9sXg091TF5MiCOkLfiwEbAt2W45zvhYYGrjj99VPse4s1w5JfoHbXkcfGHfd6sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267664; c=relaxed/simple;
	bh=eSunO1x+R0KC17L0t4T3Rs1IgizN4F1ewLOQwa8ACIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFswVF9NqTf4OPWgJh8InSqz9vIAeSuy4havB1I4aPdwachpGC1mZjMDXZuQ5j/f+7jOsgWwkyz+FViSGamwo1BJ92LZefptkR+FtFKOML75AHTryc/BDSKQdigLnEYAXtBWNpyX6H6JQf1C97zY/6RT+wVlcsd4/BaVQC4RJVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dRDlC0Lm; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvo4XsGa/GwySyN5klnu3D+dFRA2dwbxSn0ZR/g8fMvSA3TVjdLYgcuVySXZXWQzUL1s4NCXZuB3/vJ1pMhM55vGMguN2U2y4LS0/YeQrqXRdq65WJ5RSZBaAaw1qrNoo5x2yw6eShwq2RIRbHbIB0dFagtceiZxDTcXWiRDPi++SlpThQ7A0tagmTJtMZ46twk8/hhsSbd9P80Hds7hBGrOtFUN0EUNeNdbe3fuKWRiaCTXpkeG6iyo/nDdblmfYt1LQRy48Kv8/b72yRTXjAWwDkPilskBadfi0j6OVOINeIJZ9tVXER+DKsiFTZcyb9Su9L3BRoR4A5gUrOZJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBUzbmp+6MocWDq3VQHTW2PN+1pG+5GG0lA0CLmbBhM=;
 b=UVxDppxU2i6wScitFw0+7ZrItgC80r17H82t+vcNlL+ssrqrPg0wMZBIvhYjW5EtqyhHfvBYESixa31NFud+CrLmZmUeRCWqKh1tzMol1liP/7t6OZQu9mUafcOFgBon55mzeETXV0+F+VJyszWUi+wOKIm+ciXne02IVLCLkVdJsxYDpBYzpwjoL3eVln0eHYLzVc/MIfCiGhF3vr/skgc0RDhnIuoM6G8NJpPZnXmqcukzwc3sIWCUVF3iMWzsPei9XwA0YKdcgKyvztXuK9ovf6Y0EgYcJjhUWGkCgR2ENcDo5UwM5zoaNnHAB9SEmxLqAhVPgCAxLX7RnBpzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBUzbmp+6MocWDq3VQHTW2PN+1pG+5GG0lA0CLmbBhM=;
 b=dRDlC0Lm6zY/RRrFDNkzQh3iQoKVZ2I6t1Smx8JMOaqSkhL/9gtWzcbMZz4SZf3fXIGKub4naoxM3FAB8fJHv2p7AGPCA4+xs0+hNGspw7YlUnQShMEsPtVpzt1El9dQ11M5ZOa1vRIdIe4ijBUCummL6fL85LrIRj5LqNs9Xnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Fri, 22 Nov
 2024 09:27:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 09:27:39 +0000
Message-ID: <6c039777-3455-eacc-8d7a-a248f7437c95@amd.com>
Date: Fri, 22 Nov 2024 09:27:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
 <Z0AKKKdMh9Q06X7e@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z0AKKKdMh9Q06X7e@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::31) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: b518fe81-7fd7-404b-0d38-08dd0ad7e87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXVJUUtFSUt3NGRQNGN3TlI2V2QzL2lkaCtTbUJKUFpRSTZFS0QveVYrODdr?=
 =?utf-8?B?aklhZERPRzRMZjJCbUFESGNlbE13UDNwTHdhVTlBR21qUU1IUkFqZEtPek40?=
 =?utf-8?B?VXM0eFpBdy81NHRYblRHazdLa2g1SnJFWE94VU1ycEx4WmxFeDc3S3l6eFk5?=
 =?utf-8?B?cmxtOERPNzdTRzIrQm8xcWwvd01WaGRqaEFlaTJVajY0RXcvVWxLcVA1NkI3?=
 =?utf-8?B?RU43eW15WjJyVVloWG41dzd0MWt2RGNVYWtrK3hWVzY2bnVYa1phb1F2dm50?=
 =?utf-8?B?YXUvbEYrT1V0a1FiQTBlOFduay9IbVlCdWxpZk9tYzZWMTlVc2RNZ1gxejJw?=
 =?utf-8?B?TnByK3M0akZXWW5TS0JjcGtCbmdtUHFBMHhnQ0Z5VEpQUENybkN1bHdkaVRG?=
 =?utf-8?B?MUVRY3pIa2RxMjMwU0lvM1ROTWxFUkFVUGdLQysxZXE4NURtcXNDQytsaHlk?=
 =?utf-8?B?R1UzT3ovSWd0Z0JkaElPZWN6WmVUa1JjaDBlaFpEVi9TWTF5blJVM2FCb212?=
 =?utf-8?B?cEVCbWUzT1JtME1iM29LZmVmNWVWUGpudEVjckd3WFIvcUdpOUxqMHUwZ2dZ?=
 =?utf-8?B?QzVxYnN4bHJaZ2RsSjd6SDBQT3hFK1RwQytPR09TY2Z5SGdGaW5RcFh1cVVX?=
 =?utf-8?B?dmlETG9PU2phU2hrWEgxWTBwT2IxL0xnanRiY3BOb1haUXQ5MnNCTXJicjFS?=
 =?utf-8?B?VVhtaDhuL1o3V2F4ejNuRmRWbVBQVTVWOU1Da0dsTFE4SWxzTi9vUm9ITzNv?=
 =?utf-8?B?SlVvVGpiT3dlRnF5eTdNbW1TcUFZZDhwS0ZWc2IwazVpa0YyOXdqOU96b1NV?=
 =?utf-8?B?ck5DZmIvd0tvb01qL3FrNktaOW1kOUR2ZGNYVjM1aEYzZmpoZ3YwdEdBc05P?=
 =?utf-8?B?d3lrYmJOeHNSZkVTbkphdStJcGFTa1lncWZ3dFUyTmNRU3oyaVpMS0dsMDdU?=
 =?utf-8?B?aUxLK3pFcXB2L2tnMzNuL0NqaG9Mc1FVNkg4SUptdWpFTk1SYzBGWXIwTVJo?=
 =?utf-8?B?bEVHWGFET1VQZGxjRkpZbnhPcVp6L0ttWisxOVdCcWZoeWUxM0xPdUZ4WDFo?=
 =?utf-8?B?UWVpM1VxcWoyYW9lM04rWFRsZjk5Z2N5cG4yWWZlWWR5VWhOU1BSc3JUaGNw?=
 =?utf-8?B?K1MvakxWdTVtWEVXTkk1ZTA3dXo2Tk1HQ0prYlJldnNlN0NZUlczSWpZWmVX?=
 =?utf-8?B?VWVOMkFjcjBHMVdTRW9JWEY1Tm1kZDNmWndLRDVTeC94SmFnRklZZ0RLYlhU?=
 =?utf-8?B?MHA5NlBTTzE3V2V4d0NvZmRoa3gzb2VqOUVnTFFKREpOd25hS3BFS0N1SFA3?=
 =?utf-8?B?ZHNSVmFPZHhKRGh3a2JUNUF6U2pEUTVobWxBTHBPcjhDaFdEMXJvazNUOUdQ?=
 =?utf-8?B?ZlNLK2FvRFg0RlZ4VDBuQjFXbUdkZG5sS1JaakVSbUkvTGRhYTIvZ3dyWXNy?=
 =?utf-8?B?L1FzcmF0NlczR2VkVHcxN3RtNFRsRzFBNHZMMUFWZENZakswSVB6OG1abmp6?=
 =?utf-8?B?RUdEU2c0OEFBMjRFeFF3d1NCTkdSTnNLZm82SzUyajFwMVY5ZlRUd3pteWYy?=
 =?utf-8?B?bjUvM1FqQWZNS0xNM2RqRHoyOGk2U0I3TzFQbWsrM2JTTUxnd2VDaWFSU1cv?=
 =?utf-8?B?SjFCZy9aTjJ4NkdoY21LUEVXaC8reUlQZmhLQTBGZG9iZC9VOGlpam5UQU84?=
 =?utf-8?B?WTVCam1CWkkrdFUzSWh3WHpMejIyK1plSGo1NHBNb2l3bk5keWRtUXJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXh0OFFoTnVaNFA0Ni9FUjk0S2RDUFpwc2dtZWY4Rm01dGx1WUl1Ti9yWWl0?=
 =?utf-8?B?Sm0xdWsybDZCNVRwbUwyVkFOZXFzTmR5RCtBdTg0a204WDVCNnBXNHFsQ2ZW?=
 =?utf-8?B?SlJzRjVpdFF5UGNEQURpMGRTdzJKb1p4a01LUlpKdUNHckhpNDlMNi9aTzNS?=
 =?utf-8?B?bHpGWFZrWG5WMnVJTmRra1VSbTVsaUd6dmExaFExNERBUDZBd0RNdlZBSDll?=
 =?utf-8?B?NHBpK1JOOU13NmVxUUp3eDFPeWpWYjI3THR1MUpjUHZDM3lrVThiakxGSDVq?=
 =?utf-8?B?VzZkZm1PNzJSejJwZXk4eUplZTNGcU5aYVhnTHJDZm9rTk44YjJSN01uSzRn?=
 =?utf-8?B?NmxDVDRGMTJIdld3azY2MHowNlFueERaeWl1SjVmUk1LQzFyekF6K0FkNEZP?=
 =?utf-8?B?dTVkTVc0WnRxQUdHNnRqd3lNZ0VoUmtmcVdvYzlqa0VKcGE1RUlHdk8vdVNu?=
 =?utf-8?B?WGJDU3FqOExSaTE4TldoSkdsNjMrSXBVZ0tpL1REblpGcGswVDVrdUE1RUNQ?=
 =?utf-8?B?S0NnMGpCRXhsSkNoZFFSdGp1d29WaTFGdTFtWVlQZ2MvQjJuUG04NkFMaFYy?=
 =?utf-8?B?MXQ5TVBWWlNmTGVLRzRzbHJhQW9FbTdxNmJiSDc0WXY1dXNWWVhrYUZjdktP?=
 =?utf-8?B?Z01QQ3ZWT2hXdlNPdlFvandOdzVqNnRmRHlLaVlVdld3S0E0SEFTRnZleTJX?=
 =?utf-8?B?M2R3RGVQdHRldlJ3MWZLRjJESk1aQVlaVXBpQ1YrcTNSQWFrdnkyQW1aUE1s?=
 =?utf-8?B?Tk5zUkc2V0tkODFBZHFuM0NRcTJpVU5kRlA0VmJGUFlqcTB2MGMzNDk4UVFH?=
 =?utf-8?B?YVFXRENHMzIrMmZjM1Z0QWptT25kcFBENWJ0UkRFeDVHaHJ3a2RxZGowbVMy?=
 =?utf-8?B?eW8rb0J6M1VZK2laVTBaMmdVYWkzV1I2WEphNVVyZjh2Q0xuN0tCL1dCYnFS?=
 =?utf-8?B?K1RUU2EraUQwTlJ1S0NiVk1LbGRTeGV2ak9pZk5NeXZPSndKK2Z0d24xL1g5?=
 =?utf-8?B?d3F1NzdjeG5qbmFmY1YwY2p6aXV2TGNENHRIdU1hOFJjTnB0QjRMNUFOMWIw?=
 =?utf-8?B?RnVJdjM1dzNXa2JXdjdYWi9UZ1ZHUE8zeVQ4M3BGcG83OXRnUzNhU1AvQnBZ?=
 =?utf-8?B?OUdhem9VaTFpTk5ZRjBDWTlEa2xDeCttdlZUei9COVk3T09pODBqcWZ5ZEJ3?=
 =?utf-8?B?akc1ZThBWGdHY3JSTFhZMmJ2NWRINVI2bWxhb0FSdVlGaDBIY2YreTBramo0?=
 =?utf-8?B?Sm9URVZYVzhPRVBSdUswZDdWSlVCWldvV2tGZFJKb0R2Ymp1Zng2K2F6NGFp?=
 =?utf-8?B?QnlBQUoxelNJNjdPL2pZTldVcFArTC9HYlJxcEd1Y3pqYUVjQ2xoUVFFTnVh?=
 =?utf-8?B?eml0K2FpczM3NzNXejRkaHFaMVErQWlUWFhwSnlaa2gvZXJCcFpQczg3TEFJ?=
 =?utf-8?B?TTRSWmhLVjcxVTB4ZEJYa2cvcUJZUHkyK1RLZEN3emRsZnVxbTFwWDVFYWp3?=
 =?utf-8?B?NUtEbFpIMGJ5SmFZVmNLc2hpa3RqZ3IvZU55UGoyZTkyb1VIeVdkSEpBR1VV?=
 =?utf-8?B?eVlCaU1WUWxJQkloWCtvaVhpSDRweW1qamhZWEtacmFFM2dzbkpFRXR2bk1M?=
 =?utf-8?B?R01wNUdDL01lMnZnL01KNXFERlovbTJmMjVKUm1DWFpLRkJPRW9IU1NWYlNZ?=
 =?utf-8?B?dTU3eWhub2p2aTJTOVQ0TmdiM1MzTS9LaEc1elhwU3hFZVhoNjZNRCtWSXRM?=
 =?utf-8?B?WTVqSnJMQjBMNXN6Zk16cGRjOWZ5UG5KTkNkbjF5S3d1MjdNRStIMm9hTDY3?=
 =?utf-8?B?c0RMVGpCOXhzcW1tNmw1NVZ1WjIrNGZEYkNvYlpobTlhck1vZ2o4SFZkM1VD?=
 =?utf-8?B?ZkIzbVZ4d1U3eG1GTTU1b0NNY3pnNk1jVndEbXVmQ09uYXpjTjlrSmh4aDlV?=
 =?utf-8?B?OURpMGd5SW4xaEc4UmE3bTQ1enVuUHErM1dFdVZ5VC9ZU2JGUkNsd0pIcG5W?=
 =?utf-8?B?L2N0RTl2Y0pGeFNwMDIyeWM0K1podE1VVTIxN25CbXRCcVVNN2F5bHVPZWpq?=
 =?utf-8?B?ekorNVFzenVhVmRqc0l4eFNjYmJBSWNSYnNCR0xXQ2VDMy9Pd1pyYkdZMkFY?=
 =?utf-8?Q?iCvkyMdeJexiv32sh8bYlkQ1+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b518fe81-7fd7-404b-0d38-08dd0ad7e87f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 09:27:39.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74zOfuTzqHJROi4fbvDeKLuWBoDNhcPsEmTGZkhDz5RjCcLkDl9ae5w7VUsDhZknETJMAPRJpCUvHTZBD51VEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967


On 11/22/24 04:35, Alison Schofield wrote:
> On Mon, Nov 18, 2024 at 04:44:08PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Based on previous work by Dan Williams [1]
>>
>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci.c    |  1 +
>>   drivers/cxl/cxlpci.h      | 16 ------------
>>   drivers/cxl/pci.c         | 13 +++++++---
>>   include/cxl/cxl.h         | 21 ++++++++++++++++
> As I mentioned in the cover letter, beginning w the first patch
> I have depmod issues building with the cxl-test module.  I didn't
> get very far figuring it out, other than a work-around of moving
> the contents of include/cxl/cxl.h down into drivers/cxl/cxlmem.h.
> That band-aid got me a bit further. In fact I wasn't so concerned
> with breaking sfx as I was with regression testing the changes to
> drivers/cxl/.
>
> Please see if you can get the cxl-test module working again.


Hi Allison,


I have no problems building tools/testing/cxl and I can see cxl_test.ko 
in tools/testing/cxl/test


I did try with the full patchset applied over 6.12-rc7 tag, and also 
with only the first patch since I was not sure if you meant the build 
after each patch is tried, but both worked once I modified the config 
for the checks inside config_check.c not to fail.


I guess you meant this cxl test and not the one related to  "git clone 
https://github.com/moking/cxl-test-tool.git" what I have no experience with.


Could someone else try this as well?


>
>>   include/cxl/pci.h         | 23 ++++++++++++++++++
>>   6 files changed, 105 insertions(+), 20 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 84fefb76dafa..d083fd13a6dd 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. */
>>   
>> +#include <cxl/cxl.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/firmware.h>
>>   #include <linux/device.h>
>> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
>> +	if (!cxlds)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +
>> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops)
>>   {
>> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>>   	return 0;
>>   }
>>   
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> +{
>> +	cxlds->cxl_dvsec = dvsec;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
>> +
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> +{
>> +	cxlds->serial = serial;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
>> +
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return 0;
>> +	case CXL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return 0;
>> +	case CXL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 420e4be85a1f..ff266e91ea71 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>> +#include <cxl/pci.h>
>>   #include <linux/units.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/device.h>
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 4da07727ab9c..eb59019fe5f3 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -14,22 +14,6 @@
>>    */
>>   #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>>   
>> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> -#define CXL_DVSEC_PCIE_DEVICE					0
>> -#define   CXL_DVSEC_CAP_OFFSET		0xA
>> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> -
>>   #define CXL_DVSEC_RANGE_MAX		2
>>   
>>   /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 188412d45e0d..0b910ef52db7 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1,5 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +#include <cxl/cxl.h>
>> +#include <cxl/pci.h>
>>   #include <linux/unaligned.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/moduleparam.h>
>> @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	struct cxl_memdev *cxlmd;
>>   	int i, rc, pmu_count;
>>   	bool irq_avail;
>> +	u16 dvsec;
>>   
>>   	/*
>>   	 * Double check the anonymous union trickery in struct cxl_regs
>> @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	pci_set_drvdata(pdev, cxlds);
>>   
>>   	cxlds->rcd = is_cxl_restricted(pdev);
>> -	cxlds->serial = pci_get_dsn(pdev);
>> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>> -	if (!cxlds->cxl_dvsec)
>> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>>   		dev_warn(&pdev->dev,
>>   			 "Device DVSEC not present, skip CXL.mem init\n");
>>   
>> +	cxl_set_dvsec(cxlds, dvsec);
>> +
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>   	if (rc)
>>   		return rc;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..19e5d883557a
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/ioport.h>
>> +
>> +enum cxl_resource {
>> +	CXL_RES_DPA,
>> +	CXL_RES_RAM,
>> +	CXL_RES_PMEM,
>> +};
>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource);
>> +#endif
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..ad63560caa2c
>> --- /dev/null
>> +++ b/include/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif
>> -- 
>> 2.17.1
>>
>>

