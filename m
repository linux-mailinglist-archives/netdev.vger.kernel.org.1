Return-Path: <netdev+bounces-228524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F2BCD44C
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D763A516F
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478B22153FB;
	Fri, 10 Oct 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yOi/QjsD"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A922F2601
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103014; cv=fail; b=Rg0/yQDNeSKzTjOeH2aVbg93qquRObbAvMrlEguRvBdSBQEhm0+SiSjG6GoOzYxB7uyC7OR62csV3hA+aG9iInHQqXmbT6ckCotajdrTRrommbt5Yk2O4WcspQR1n+laJLUzuZD9TY0JMEsqqusNDB3ZV0Qiji6cWmhccmZiSiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103014; c=relaxed/simple;
	bh=XSqsn+FsP0sIh0ehCyIGA5Vto4MUjMHT+jxn4hWOzo4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=krKTkDB0GmUo2CrrAKtDCf5YYgs3IDCwP3cFpNbJDD3PIPlgvBg6+NNdVBCJpAd9kLezWB/wODQUtWsLNtdMe2cs5GFBa040bB8EOiMWmaQEGS5wXUMmCMwmnAlJSxtR78OtQz/72fJmKrB0FOKstRbyR47niQByl6JsDX3VQkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yOi/QjsD; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f++T0PGYhJG5cVOdhWuM+LTt6WngRB959Ul8XmMeKFcV7nGvoGdMsHV5qcLa+h606heUsp7RBw+V/UzsEgltrT0QpLy+dUTSt7jVxQzS+m0SPh7c2JdB/9MJBw5+2QNEzRzYFGG95K6izaA2jnYT68d/M4p19F1eE8Xwu6iPle9pHlH+12rLiI5hIIy26x7mELah+2McXJXlrG0/sHjy9zI9nkeqmKxNxBOhbvmMq3vC6ni4/V4yx0VcSQ0HlDha0ndpAbBPmzR0Hjdacj4QHjEtydS1pnGLHBQ9+MIGS4pF/32l++SaSu/Uh+JuG3mnkiFZBt0JVups8AmR+vtLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY5F6NTzhRijqi5jESZ1LLO5LHVjZBBWWk/jZLtxNXo=;
 b=ViouC9U8yQnTLXEoqdtYEIRPqOusxmNFWjM8UDzeH1HSApa7GaLnaqIdnI6XBuNbTKRIDGkiTDc+3hTwIXXHFPkMKLY5dcpXjMnAV+1ng/b6ECWwP05Wxy4k9eIZIIaxaykEJCiUWSzixeaniSgEnGJQO0oz38W/w7jZHUwpzwKSY9AbhiBuV9ze2ZZ+FojMGd+hwLJQUMTjGrSYfwtWc6MMfRbMpv7PoMzESQmzTipKMKHolToeAF/5IW/hoYuR4H62e45GeSdAsfbFB/WAmxaALS616QOEsiLLPJQfl5WzDpGwFmVUAIzrta2t+zpN1ajpQUVQqfYgAk2Rh3gnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY5F6NTzhRijqi5jESZ1LLO5LHVjZBBWWk/jZLtxNXo=;
 b=yOi/QjsDIH380JSaoKLTXkKAoi3YvAOGjR07llXf9ZdbdXjDSEmI4ef20l6MuJjcBWXw2HBJqg5wJM+koS+D/B8jOrh2XCmdlERWJJhEKjcz47u8XvyIzH/3O0PCTcobmOW4NWBLPS6QtjrYNpmlW9H9sZS1vdeqVEBOmMtjezs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:30:09 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.9182.017; Fri, 10 Oct 2025
 13:30:09 +0000
Message-ID: <c7f455ba-cbe3-4660-9ac5-e68f5a18963f@amd.com>
Date: Fri, 10 Oct 2025 08:30:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: Avoid spurious link down messages during
 interface toggle
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 9513cb97-61f9-4920-4340-08de08011fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ylc5ZktIbUZVY09aMW4ySmhsME43QVJWUlVmRHk2Q2NCK1FaOFdLSkJ0emVt?=
 =?utf-8?B?SHNoNFJLTmQ0ZWRpMDNpL1lvMG9qMkx5bDVzcXBiZXZhVWRkYWF5elowTWVq?=
 =?utf-8?B?UFU0THdneHQwNUNPOFltR2tBNGs2dU10dUtzSGp2QTRBa3FWZHFYaHNBeFBP?=
 =?utf-8?B?aFpRY3pRRzVsMmh2L3dLTGVETm13N0NrSC80RVZ6SnptRldxMWtHVURVL3pI?=
 =?utf-8?B?emg4SjNXeEV1Q21HZFFRZnJGdExSSjdVblBSeDlWNWFFOHI2OGI3emQ4ZTRW?=
 =?utf-8?B?YXNsejRUUXlUNHpBN1NOREk0Z3hnak1xVys3TFFDSkE0dU54c3IrTGZTYVZj?=
 =?utf-8?B?bTYwU3dZaUdRczFtZ3hieGcydmpBU2pGNWJ2QU05RW5NYjd2TDBSdkNueVMr?=
 =?utf-8?B?T01ma25qUmNhcVNIK3NuKytUUklzaWZLa1cxWDVKT1dxZjgwVmJvK2xLbjZo?=
 =?utf-8?B?SzUzS21XejZSQktUdGJFY2VjZlRoenNYY2phdjVHaVZtVGg5b00rSzc3bEFq?=
 =?utf-8?B?ZmJ1MzUvMGJzS1ZCNWJnanlUUzM4NnNuRFZsa2ZEc1N5V01CTlhzamZCK0ts?=
 =?utf-8?B?TlhJcnVTd25LWUw0RGFqZWJDVG9KTkRTMzkrQnUvYkdZRXFBMGR5cnpNZnpl?=
 =?utf-8?B?R2orblJYY24zTGdKUzBIZWpxa284Q0d5Yi9sR1NRTFpHZHFGbVduY1hIT1Zr?=
 =?utf-8?B?b0pFNzdyRlEwVDk5VUM4eFRoVURvR0pjaWhFOEtTbEU5NGt5eXNkL2JJYjRU?=
 =?utf-8?B?eHc3UHpheFUwdEJKL3Y4UWJoT1hyWGlUcmZYaFhyNDZzbXltZFcxRTdSMWJj?=
 =?utf-8?B?NzZBV0xaaVdXZUxhZ3VOYlppcXZ4eHJHNFBObVY3cGVUS2JWUkZWaFNBaEZx?=
 =?utf-8?B?TlhlSE4wUmJrb3ducTY5RnYvdGxacDhNMjhieEtXN2p1THhqcHdBd25ZTVdN?=
 =?utf-8?B?cU8vQnlSa1FvVFFvakRjbEIzandQcFg5WStpYzc3cjlLTEltaEdNdnB1Y1l4?=
 =?utf-8?B?dUNtOXJ6T1ZDRFF6M1QvN2tMK3ZOU3ZSUnVMOUQrME45RHp2TVNDS01jeHZX?=
 =?utf-8?B?ZkpNZWM5bURpYkNEVVZMdjlDMnoxdnJmYmlIVDhGaG84MW5xbWZ5Y2hoUDdj?=
 =?utf-8?B?VjJSNjhmQTFZenhPSjcrcm9xZjJ0SE9yNHExMkM2Wm95NHFKWW9uRGlucTZy?=
 =?utf-8?B?WFNOWUVEcnRDY3Q1di82ejZ0aUlHNkwxM1FlL2JXcmNjeGthNWRWTFAzYlps?=
 =?utf-8?B?UllmcUwyS2FYa0JUVFVscnY2Zzh2SHcvVmc2UnZ3OUJpWkYwdkdjOFd4ajhh?=
 =?utf-8?B?ajRyRHJ5Wm5jZEk0TVE2b1k3QWtScmhqVTR6VHp4aitDdEFJT0NDTWgyVkl6?=
 =?utf-8?B?YU1oaG9MTmJFc00wN2pNRUIwNm9RSUlpakdRWjMvUG5wWUx4M2pMeGlmYlFS?=
 =?utf-8?B?MlFYV2RXcVVYZzNjalVONUVHeFlKTVQ5d0l6cUNqbXFDUUNsTjRVYlFrS1Ji?=
 =?utf-8?B?Q0pUNk03SUl2MyttbVpYYkRzcGRKeWlVTEREYXd1MDhHTjEvMlhHditSRkVS?=
 =?utf-8?B?U1l2Wk5yYlBhVXBScUdITExjNzkvL08vS21SNEdLQXJpa0xxWFllcjdaRTRS?=
 =?utf-8?B?ejREQk05bHVHbStuZjl5azFxMXVWc3NveXc1MlkyaVVRSUNNd3p0b3dMRHpG?=
 =?utf-8?B?S2l1VU9FTkpNc0tHbU1aZnpoY1JhaWk4YnMyMm1zcU5nNE1YWTNVYWZjY080?=
 =?utf-8?B?WC9HdlNQV2Y4L1VLWnR1SUtUVFdkUUVPUERGUGRNSTRuNURBSHZveHBoeE9K?=
 =?utf-8?B?U040dVF0RXVPUlh3V25JWWErdDAxT29HcHhNek9Yb2xrbHU1UUhVaVFHSDBJ?=
 =?utf-8?B?anpSZmxhMGpNc01tL0Z2NkJycVd1TzFNNEZqRlo4dnlpSzd5ZGhPUEQ2K3dQ?=
 =?utf-8?Q?GBntprGDyD2iS9u3m16sPOofkpKkM65y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdSWTl1UmkxYVIrM3YyM2FWM0NFL1dtMnpjTFdHTkIvT3JJblgrK0hCSmFr?=
 =?utf-8?B?cEJWT1ZWNlR0cXNaSHl2TkdNYURKb1FRYWtOdGRGY3NhakZxSnJrOUlWeS84?=
 =?utf-8?B?Mk5nQ3FaWVJ4RjhtOHBuZS9wV0NpZkg2ZWVHTTl2VFpTM3Z5ZFpkSndPanFy?=
 =?utf-8?B?dXd4SjIwSVg2WDgzU3ZIU1FVTWZGb0ZDZGZMZmVraUNldWdOT3JWQzdBMXRW?=
 =?utf-8?B?dDllcU1lbkYrSUk3VFNmck1tck1qekhJb1RFTkI3Z2JHY1RtL3EzNDlvUXdD?=
 =?utf-8?B?bThOcTdUcWVBczRLOUoxNEluWU5lY2dmWWt1amxjbkkwQVB2aTA4dE9vUkE4?=
 =?utf-8?B?QkEyYTVjbHJDWTJlaHJUc0dPbkVnc09rakJxTnlJdDdLZGdpakRlck9rSDBn?=
 =?utf-8?B?NzE2VXJFdTZYZGY0bDJvRWREYjVJbUlmWEZqakVnT09yOXpML2g1eW1ibnEx?=
 =?utf-8?B?cHcrT0g1SzFUaFYrbGRoc2c5aEdWZXRQaXkwMzJsUHJ4cEhObTdpOFRiRTh3?=
 =?utf-8?B?cldNSVFpTm1LT2xqdDB6RWc0QzM1L3NHK244SFRIQkF3NWZheHFnNHlUWG5P?=
 =?utf-8?B?c0t6NUFDKzk5T2tpSG9ZYXhZcmtqSDVKQk1IMjVCWHlXZTl1VFNDL2dzb2R6?=
 =?utf-8?B?UjYzeUxHMjg2K1Y5QndVbHVUUDNpemJZM2FGRVJhVFh5UkJjeHpJTCtSN1N6?=
 =?utf-8?B?SWhqaEtxZXZZN3Evd216ZGxKcWlKNXd5WFpKVXhXOVJIWmFiUld5c0xZUUNM?=
 =?utf-8?B?WktFSTZjQUZ1Yms5RUFzODFlWXI2eTBXSUxXeHlGS0tXcjZwTEY2LzVrOTFM?=
 =?utf-8?B?YmpFTTBSYlVhbWtmd1lGdDlXU2huTzNYTEg5bnVSblpqQUFqK05rNEh4K3A3?=
 =?utf-8?B?a2NMVEgwWEs3UTlrWG14VzF6Y1pQNGsrZU9MQ2xqT2lmc2Y5U1F5NmxPTWN1?=
 =?utf-8?B?c3Nwckt3MDluRnBKdlQyVmdEcmFKaHk4VHI0blBGcVZvSzk1MVg1RWJhZkpt?=
 =?utf-8?B?TDNuTEw4cEF0N2tFbk5jWS96QWFOMU1SdG5uckcvbVZydHoyRnZuNTMrK1gw?=
 =?utf-8?B?MDFSS25TbG1Bbkw5Y2d4S21XTXJnZVd6a25tVnpoTlZzY0ZNUG1BblJrUHhR?=
 =?utf-8?B?eU5vYkpNUUFxcWJXVkgvdWxuVVNjU2JDYUtoWXFuLytBMUE0M21jSHNBU1hp?=
 =?utf-8?B?Vkkwc0xYZlZZQmxMb2pQVTlrS3RmdGNueWpzYlpuM2dOSklPQXU3KzFRVW1w?=
 =?utf-8?B?T3dReUE0RWdKUHdqeGtzRXE5OGo2UXRXSEtLRHU0MDRkME9LeU1ZcnpJc21I?=
 =?utf-8?B?ZHhYTmJTa0E4NU85M3ZraDhua0JuN0tyUVZlNjlCUXpObUxUQmgwdXUvOTNk?=
 =?utf-8?B?NHZSY0plbW9PWGx1V0h3YWxsbmhmMlZMR01rUWFYdUFVcSs3ZDBrUHN6bHRx?=
 =?utf-8?B?ZkFPaUFTM0JCYkpULzFNWXdYb09zaHpoQnRGT1BUdml3ZDhaRzlzSjNKZmZv?=
 =?utf-8?B?RjJFL1lzR09JUnRJaDdBUC91Q1BzR3RnM1k2NEtsYldhZjVvSHZDaVZyR25v?=
 =?utf-8?B?UUk0WGVxQ093cU54TlVoWVFVRy9XTUVOYWdVeEh5QmhTbG5nUGlHMG4yblBy?=
 =?utf-8?B?UnF2YWZqU0NaWW5wVnc0NVpKSXZuVjhqZy9oWjdiV1F6bVJwSEJNRWlTb0d2?=
 =?utf-8?B?VjJtQ3lmazFLcHdTQ1pGRTNPa0tueUxTa3JQWVhwc1ZCSFNlUk1Sd2VPMEI3?=
 =?utf-8?B?OWd4bHQrZUdhaDBDbGdHUy9uY2xMMXVQVzNUaHJaYVZEV1pka2V0UEV1YzQy?=
 =?utf-8?B?b29PMnZwQ3lwd3UrUVZEQXBOcTBlQTRGU2J5V1ZXd05RSkROQzBGZjVzS2p2?=
 =?utf-8?B?d1A1U1QxRExSeHBwZjZPMnJydjMzT2lsclJVWk9BOU11OHhiYWtnbnBoWFRT?=
 =?utf-8?B?cFJaYlRNQ2drR204Z01uWmNMa29kRC9tY2NxMWYzTURDdEZyNU9qU2hnUEJp?=
 =?utf-8?B?dDhXakVua20vRFR2dWdpdDRYUG5uQVpkUUZEd0prY0Y5YkIyZ29OMXFSWm04?=
 =?utf-8?B?N2NVSnZpaDBxOHRVMjNLY3NFM2NrK2VBNDBaUFlrY1ZnM3BTbVRGWERBSWxt?=
 =?utf-8?Q?tv/1fmiWa2hkhX5lKqQr05KE4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9513cb97-61f9-4920-4340-08de08011fc1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:30:09.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xzGB8kW9TPzq+swgzlRR8u0XlqCzp/aWcfzP/caENu5k/9CM71qZDvv6hpvugekHTo9MKvRBozWHd61P2Cb3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

On 10/10/25 01:51, Raju Rangoju wrote:
> During interface toggle operations (ifdown/ifup), the driver currently
> resets the local helper variable 'phy_link' to -1. This causes the link
> state machine to incorrectly interpret the state as a link change event,
> resulting in spurious "Link is down" messages being logged when the
> interface is brought back up.
> 
> Preserve the phy_link state across interface toggles to avoid treating
> the -1 sentinel value as a legitimate link state transition.
> 
> Fixes: 88131a812b16 ("amd-xgbe: Perform phy connect/disconnect at dev open/stop")

Did this always happen, that is, did this behavior exist before the recent
changes to detect short drops in the phy link status? If it didn't exist
prior to those changes, then the Fixes: needs to be against that recent
change, possibly limiting the amount of backporting required into stable
kernels.

Thanks,
Tom

> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 1 -
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index f0989aa01855..4dc631af7933 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1080,7 +1080,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
>  
>  static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
>  {
> -	pdata->phy_link = -1;
>  	pdata->phy_speed = SPEED_UNKNOWN;
>  
>  	return pdata->phy_if.phy_reset(pdata);
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index 1a37ec45e650..7675bb98f029 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -1555,6 +1555,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
>  		pdata->phy.duplex = DUPLEX_FULL;
>  	}
>  
> +	pdata->phy_link = 0;
>  	pdata->phy.link = 0;
>  
>  	pdata->phy.pause_autoneg = pdata->pause_autoneg;


