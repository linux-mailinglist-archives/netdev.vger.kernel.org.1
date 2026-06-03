Return-Path: <netdev+bounces-294681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MeClLeviH2o/rwAAu9opvQ
	(envelope-from <netdev+bounces-294681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515D6359AA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=louZ0E+J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294681-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294681-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD64B3018D5D
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C159740F8F8;
	Wed,  3 Jun 2026 08:16:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CBB368D48;
	Wed,  3 Jun 2026 08:16:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474599; cv=fail; b=tM1XsYyaLJyPqgeGOTGZOG7F24ZzewWJSz01tgODplwQYNaI/jx1t7XaeBPG7ze5xukTk7EbDJ1Ks7qe0aSdal1b0iHMYEad+KX6oX1R32QLcgRBmW1vzsakhiYXDF4zXUPk+RVzDKDh9ZnxtfKnn3A3xmv2v2fid+NScOol7I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474599; c=relaxed/simple;
	bh=bifYGyIofxpXYo7G3mQrKkD3LFFHlqNEZMJaaeMgfU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ucsT56ukp4Ge1Lxg9+k2uc1V8Cv89jdA0S7iWiPdpRSIvmzUI0vYPFT3Je8eK9+6O/kAv4oxhpZFxLy8IgI7HwKtYDfV3HJhuq+js2fITDGM1ePNjwdxgn/gWJuge/KmT3oq6NrhrhIlf8h6pVrU32i3sQmcgywRtoEzeafCWEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=louZ0E+J; arc=fail smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537K0Qk3579755;
	Wed, 3 Jun 2026 01:16:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QgGtuLyXNKlEQQ0APXVfRB+syL67axinPUZXhRa1v5U=; b=
	louZ0E+Jk1rXyHoto++X72imq1vk5Hcgh4ZvDf0ECflPHTveHQrkLsHq7C9riR91
	uNN63ujhHUSXS1jces3lepl/3yfuAUF5zGdY/qHN/g5IGuvc6CK6FjejcYZDL/Vz
	MIRipUPLLv2iA8FyVNL2+4zQZ07MgKKQpxvPXdr/EPJBDfzdpjKVFOVptvZIcs3n
	lWYrTuEsrTi2F7C9ufyUcLxhfOR/uNeRqs0Ow+Elvtsh2ccOGQYnDeI8zNC/PTt1
	17Q1mv4lcUyFBLMldNVpHESJmsMLklOMPT9cAFOifDrXxy7wFsTDPguS68+CVzH2
	oxw4+HK4XSot7BztZJhXzg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efu61x6m4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 01:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBcAdrbLIZASUFukXZsl78nlQxaejCSoNjzMrMbvG+sZ/AA8/tPBhWVCV6C6P+KPuf8rvafZeUUBFi+gnRhPbvImQbNVkvCQM1wERME5V2zs48yTufXwItpR7Qbt0OAGcSJ/4PhUCK7QKK4Ws4BknUXpvreybWO0JETL5RIYJK5ivQXnKLjbxTIgJkRN3AbIVP+qfi/mwhPmGV7rpwrgj9QvPOiiQky53ExsQIiEpHiv4MjRHyyZn0ZXZSMPiuLuyyQIypATh5kRfPoV5Wl4R7+L9atas2lmUZFmFaq8HNwvGEtBagak9gtw4u/RW7JwkLP2jmpm2S/z25CTz0Tzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgGtuLyXNKlEQQ0APXVfRB+syL67axinPUZXhRa1v5U=;
 b=UFBE1dk26Wik/rnlSJYhMRqd+n8gzV7W9+z9hy53R2V+vw9jATen3hO5f/NR/Hg1Hct+IpaNpyx/ra8Y30LZwYZcNzwkKdAxaPAmxpx9wsLqikJQNJkyv+VgEkNvVMOXPeRZlm9T3XOVSvjoWOgscoE9rEl4TZNMZojxYphx6gwtV/HWsgzJvnTNTVUDbYmkun85urc1tddI7kSnSZiho0xfmwrrYDBz7v5sCf/fIFtrEESZtZLJ+482PpOzgw56q/3ToGxC9HnIHzyvGzWMXFxl1DD1oXjLXbuLHH5+hA81lgGkzm+4/TLBw7amNThU8PATXlwbzN1EsuqwByoPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:16:07 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 08:16:06 +0000
Message-ID: <2fe4890d-842b-4595-b0db-6859579ca6ef@windriver.com>
Date: Wed, 3 Jun 2026 16:15:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] flow_dissector: fix uninit-value in __skb_flow_dissect()
 for ETH_ADDRS
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603030810.3593625-1-yun.zhou@windriver.com>
 <CANn89iL2OnKcFOV7hHON=70670bC9vsUXBFm3nADU89qgepVfA@mail.gmail.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <CANn89iL2OnKcFOV7hHON=70670bC9vsUXBFm3nADU89qgepVfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY6PR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::12) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: dbea149a-9ee7-4691-45bd-08dec1485c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Fn1m92Ifk6Eo1/d6IXlYV4YUpxscCZ8ra7zth6hxS0Zk1zi3eHt6yEf9QtPgyPxnaHN7gWSl90b+gApPLEso+e1pc0GQLApN76pgYlq6kyhvkvM8oUcIftCXGjc+g18FCrZlbUEr1AQXCqSQapRbTikC5ZeceXW6GrErzX4EdQ+meOUK+IMe75MPZI1dd4rqtzfJa7KsyTwwjhfPTP05K+NA+JualaSMJpYwj6ZzPkUZejwMQG7LkVuWlZ6txSDtcBOyCwimpuM4EfQdHBrDASjM9VOEbg4Zp0GoAE3KV0MufKf9ItTePzpKrnMB/Ib8dW+AP6v/0SXXShc2n/8Tc2ZFdRcjJ6+8e2UzxNslpqlAcg5QJWQiPZhXzftX/Snsh/lxHbsovFpPFEakj0OFPlt05Ai2w6TAjNMXfQR6u3+Og3kWwiesb6xOPPg0drNzb1wzd4f8I2PhAt126kcAmFgvyMUIKMGSCG7VI09JA3LZXi3GU7F+Rx0V+V8jbRyi1gJYQ9koVaMVrIPp8zpbgC/gfZpKaylqF68LPj6/DR1VMrAveshF8Clf8MDFd1q4Mvhft0HbDOqHwG/6V+fzEK2QywuchVrI4fvHZouC8VmWXjIeBohEMszL2vLqtPmKa/9vdpDt7ck+wyonMm9D+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjZjZnJudkxzQkp5RnZ5dUxRNm1RalpaNm9KVTZsV256L1VJczVXOTA3cERo?=
 =?utf-8?B?RHlMeDYxejMvU0ZlWlF4K1VxZ1ZqUlR0bjFpc3dGRDNrZncxSksxYVNtV1Ft?=
 =?utf-8?B?cmMvZmlsYjBRVGs3NmZRWkQyMlcrV3V4Nmh5b3dTaGZDbWx5ME9LdndDbEtQ?=
 =?utf-8?B?UUJzeVZjbUJwQXBLaDBvR0ZSSXlNVitLZ0xFL1ZhcDZDVW1VWGJKMkZzS1l0?=
 =?utf-8?B?VEM2NVY1VndDTWEvWGhzdDlsSVRzRGZRbmdzekViUEZEMDFhTnZDeTdFd2Z0?=
 =?utf-8?B?NDlpNGQ5Kyt5dXhuSnhLTElsdFRuejlzeFBGMUtYWVprZTcrSUxJbHp2aTIx?=
 =?utf-8?B?MXNFWmdXMldaclNqeWJzN1R6OXM5MnlFM2ZiN2NYQnhBVWhNTjZZbjJ2TnJw?=
 =?utf-8?B?T3NJYlNqekpsZzNnbEtrd2IyYy81Q3pEbmJHMFIyNzNqY3FZV3kyUTNTUzlJ?=
 =?utf-8?B?ME41YVBPVURXcjRPN2pLQ2o1K2tDS2MyMTNSV1JSY0g3OEIxemhiZEVzVmtD?=
 =?utf-8?B?UFZEYzBvVTJwWHZLTzhxZXhueUFMbWFxbHdHK3pJUEQrbGdOcnJ3WnpKTXNo?=
 =?utf-8?B?T21zdzZRK2tsOGtYT1RoWmVRQlFaWDE3K09zNXpKSUs5MG50QTRRaVllYXN0?=
 =?utf-8?B?WkJVVGk2VHNtQ2JFQWZFTm1EczJDMzc3WkFHVzQwY0dJdktsZkgzUldvcHp5?=
 =?utf-8?B?WEIvODI1WVc5Ymx5Sm1tUVlhazZocnFudUdDSW1pSE9PK3grREhhQ084TE90?=
 =?utf-8?B?VFdHWTJ0TzNDZHpRSEFERlBUaFJ4OWxnQVF2anJSN2l1QXhmNzBqVFRtek9v?=
 =?utf-8?B?Sm5EYWtiZmN0MWJ6RnhJbkZBaEUyb1dVTDJxY3llUWVRS3dSZlBnTGxHL0ZC?=
 =?utf-8?B?aEhwaVd5Tk1tQXJka0pZSkRBdnpJM2JtS0FSL0w0NS9nbkgzaFNlVnZlMCtX?=
 =?utf-8?B?eXpXVS9QUHQ3cUgwekpSMVo0UUN2NHZldHlhcngzMzhPN05NdmJGSWpKVXBW?=
 =?utf-8?B?WnFUZzBGVWlxempSSHdUODNvRGtMUlFaOE1UNndCeDh2dktYQzBCWVFNUEhw?=
 =?utf-8?B?dHpJVlZSZWJxWWRCZDgrNlhrWWNNZ2NxMXpXajZCUHBIOG94aUlTbVpHY3hH?=
 =?utf-8?B?Y1VRR0N1ejJLd20vcytCV0UyOWduY0dtZTJkcnhCR1d6TmJIZDRUWnV0S2pp?=
 =?utf-8?B?SWt4aUFBazErRStZcjliSlhGZ3JzNTJBak1BMmh5NzlNcVhlRjNKcHAzYlFt?=
 =?utf-8?B?N0ptSy8zRm5jL2dWVWNoU1FSbVZQb1RadGdQY2pRNXNoWTJISEdDdnphTlpR?=
 =?utf-8?B?NnNIOVFMTERiT1k5Z0pLcHV3TXNvNXdhNHdaSlYzMWh6Umd4U2hPcWR1ZDJx?=
 =?utf-8?B?M2lwL3lVRDhseXNOeHBHRHlzZWtpM3E1YzN4QmRNODFoc1IvNk9KSFN4dTds?=
 =?utf-8?B?VGlnNmZTOXRxeTFUTGZlNWZsUEFLMnpXTnZrTXl6ZlQ3UTlTcWhaSHRUb1Mw?=
 =?utf-8?B?U0FYRTZrbm1xcGVlRDBzbE5Xd2E5dldrTkN1YytXdE0wSW9QZVlMbjhUS3VT?=
 =?utf-8?B?VDlqTm5VM21Pc2hyb2ZQaTFlelk2R1lxcEhVZUhaUFhnZURzMzZTNHArMEJl?=
 =?utf-8?B?eUkxTXpvZFdDS20vNlNiMEFTeEs5bFZ4MnlzamlRWEc3TVNYcEw4ZVdlazdJ?=
 =?utf-8?B?dXlBRHVySEtFajZBVHlHN1M5Uzh6cUxnSVpqc1VvK1hpQTlQT3BUc0g1b0xH?=
 =?utf-8?B?czNianFwd1Z2S3k2WVRxVTJQZHZyayt4QVZlRDZTRFVQY1VrMThBNC94eVRG?=
 =?utf-8?B?Y1l2eHFCd2F1ZDE2WXVvRUR2ZWJwTTFVY0xQYlo0OVdjNkdCUk15QktxcXJh?=
 =?utf-8?B?ZVFYZHc5KzJIUTlRMEFnSXozenlJVnAxa3B5ZVBwbGdCcnE2QUtZUUM2OXRW?=
 =?utf-8?B?a2tKZWU3TVdoVm05UGM4YWtoMFNrNENybi9UY1h4NHlOSTkxNEJqbVJDUmZE?=
 =?utf-8?B?NEwyb01aam51TVNkbEoyRGdQRi9INWNvUHRPbXlUWFdyNXB2SnFGODBOVFJL?=
 =?utf-8?B?TmVDY3R2cGpRRDExSW11UU0vakNkZFBYTWU2K3VvTVk3WmtoUis3SGdhNU9D?=
 =?utf-8?B?QksyamU4OHVHOHJXaEN0aUdzb1VhL2RmeWdGeE1SUnlWY2JvMzl5TUVZZldH?=
 =?utf-8?B?SmJpNWdOSlpjTDFHVlJjYSszRGVJVFpKWFRick92M2c3ZS9oRnFXSnFMTU4y?=
 =?utf-8?B?VncyNko4dFN3SkJuaG5iRU9mTE0zL2x6N1ROQzZ6NSt2c3NWczRtMnFRM3Nh?=
 =?utf-8?B?ckV3RUxzWWhDYTN3Ky9ReldpeWE4dVUzMlkxbmJ6R2twS3ZXZEdHUT09?=
X-Exchange-RoutingPolicyChecked:
	qgHTiTwXt6Jv0Ztlx6QpdYm7hreHPXhwGuIM4zELM0iZN4+PMYIvsfguoEI1N8sW6FYuzg1ceQNeHzrkO0JOGU+P1rUD2o88bMlmNKeZZrg0Wn7RH+NlCmUok1dnrCON5mz0N+J71V5BkGXWAdmioIzlBnmhZxJffeUoE3mz/jnafsBGhsloGDYrA6XV2T/HUpVDg+UYh5qV9tX+fwnzTLPLPQS5s1i7+9OYh9gQq0ZsLxDGrG0sdcWDMiD1D8uxunfCZJ/AOIaV+C+bwrbfpGDS5o/hj99lnFxOWnZyjc3OF7Dn/TM06UiolpsoFORzV6ygeONaI3ALWfBgu7MI5w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbea149a-9ee7-4691-45bd-08dec1485c67
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:16:06.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms+kybXOhsJ0OAtaS4ft8HnAygip8UkuqywMN2Znm41kNnF8yHvHUxHVo4BgUTIeKZ8Cz4h8q9H36BAQwoT+Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Proofpoint-ORIG-GUID: AV-LBksmB2pG1NvyeM8c-Z42EKSKZ3cp
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a1fe2cb cx=c_pps
 a=aGwn47qLKbf7B3DwPvQeXg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8
 a=_KzehLE8vKIkgGZfGGsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: AV-LBksmB2pG1NvyeM8c-Z42EKSKZ3cp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA3OCBTYWx0ZWRfX7JHYQZSjCCuj
 iN2xh8TidMYXbGNkoFc7BfcwLb+jHkV/HdIIiT48a6Bzh7GYr08Hzy/1bPh5r53dgAoi4ZpFsnU
 j4RRW9ZFTjRycNawlr9mOPZAjJn3QuJgzq5BjAvkflSYZ4meSFTFzMEw4QF+30xezkpRZRh4lKd
 RylAJ+chfm0/mF1+kH6xpuvmO4JgxbiX1/DqeO/uUKqwUV52o/7Xo/ewbVzKAESuxcSK1dGYxaa
 pGwwHJDkRwlyagE9WbtScAGkvptc1JI3bnXOzOt9VCLkr0PwGvMPs7zZ8ZndopDyx85lgc7w3bY
 w1Ecf1ZEmDtjgre0PwxLw/8NQXHHU0TA2qhl6K6qENO9e/G6+TnIwZ0q8WPH6eh9BhJcvFwPdF7
 c6OCquOynl/lcR4NROr3kQaadRrnpLtLBeRYDc1AAXT5JLCBH/Bsce9w92IbBrjetv/ZfwCSL1s
 3LvXndV5IMaW/NER4Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294681-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,windriver.com:mid,windriver.com:dkim,windriver.com:from_mime,windriver.com:email];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5515D6359AA



On 6/3/26 13:44, Eric Dumazet wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Jun 2, 2026 at 8:08 PM Yun Zhou <yun.zhou@windriver.com> wrote:
> Please add a Closes: tag
I will add a Closes link in v2.
Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
>
> I found some not relevant syzbot report :
>
> https://lore.kernel.org/netdev/6a196faf.c16d89a8.217f2c.0002.GAE@google.com/
This should be the same issue. And it can be reproduced by 
https://syzkaller.appspot.com/text?tag=ReproC&x=12924152580000
>
>> Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
>> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
>> ---
>>   net/core/flow_dissector.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> index 2a98f5fa74eb..d5817b800079 100644
>> --- a/net/core/flow_dissector.c
>> +++ b/net/core/flow_dissector.c
>> @@ -1173,13 +1173,19 @@ bool __skb_flow_dissect(const struct net *net,
>>
>>          if (dissector_uses_key(flow_dissector,
>>                                 FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>> -               struct ethhdr *eth = eth_hdr(skb);
>>                  struct flow_dissector_key_eth_addrs *key_eth_addrs;
>>
>>                  key_eth_addrs = skb_flow_dissector_target(flow_dissector,
>>                                                            FLOW_DISSECTOR_KEY_ETH_ADDRS,
>>                                                            target_container);
>> -               memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
>> +               /* Ensure the skb has enough data at mac_header to cover
>> +                * both src and dst Ethernet addresses.
>> +                */
>> +               if (skb_mac_header_was_set(skb) &&
>> +                   skb_tail_pointer(skb) - skb_mac_header(skb) >= sizeof(*key_eth_addrs))
>> +                       memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
>> +               else
>> +                       memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
>>          }
> Can you show us a stack trace, why mac_header would not be set at this point?
It seems that there is no need to call skb_mac_header_was_set(skb).

