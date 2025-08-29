Return-Path: <netdev+bounces-218415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A947EB3C56A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634AEA24889
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392DD2D6E6D;
	Fri, 29 Aug 2025 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="BToTTssG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E582D6407
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508205; cv=fail; b=Gf+HxeBXyWwwNejxuMW94FyQZ99LCFlyFEqza1ISVKYFZDxqD28Vp5Jx0NwgTtDF9NlDi1wIjy5pjgX086c4RXs2wAyxOZs5d2itvAmlApzgFMrn/VFnxKErVXjq6Gs57oa5d61HnUrrn/ls5tdTfS3GIG4dRJ2t4LlJ7v0+iOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508205; c=relaxed/simple;
	bh=1FD6prROhh4sxnjnQFpCFo4xrQZZF/ZczepH2vfJJB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J14XLqKwtImhuHY/gCozMCdAwyAUNkrSH4J/H5AhVOXv0uuyZtvgipa5uQihMfFG0b0PIzcVbDOBQ6X4SCFakIKVY1n3sHdZqnpTv/KCS0Owlca1ZJsqH4m+wG+u5Twcf6sTqTj7tSNtrg6mPxshFwjWiYUT9ZlYUyurDSNwj0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=BToTTssG; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1756508203; x=1788044203;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1FD6prROhh4sxnjnQFpCFo4xrQZZF/ZczepH2vfJJB8=;
  b=BToTTssGu8MnP0O1LUeRqA3goKwE2mF1Qy1fSPjZ9iCnk9hlINMFNLVI
   YkvPHgnxqe65w7yL2nmCLMV2ddaIQZpmYIVahLakBxCsTQWQWONIbDzh2
   gM6XjqX2r+o/95pJrneNCeYmsoJ6faMYdAbU99v2EvxrX3i7eBWbOappT
   E=;
X-CSE-ConnectionGUID: aLgPmjSlSjeRYXmf90dGVg==
X-CSE-MsgGUID: p4SOsoZxTo+RuXI1h+WSog==
X-Talos-CUID: 9a23:uXJLJWxry52qDk/rjwdEBgUdPs8dd3/myEzSLnWJOWNnGeWZZmGfrfY=
X-Talos-MUID: 9a23:LlyIaQSOFqepXrqORXT02ApFL8Ba85ipS3oQobRfu4q7Dit/bmI=
Received: from mail-yqbcan01on2108.outbound.protection.outlook.com (HELO CAN01-YQB-obe.outbound.protection.outlook.com) ([40.107.116.108])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 18:56:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfY7Afg4UpHbjQHajkXJTMMWCWnOvf0yGqajRaW7cMxFNf1EyBsSuXRtStI3pAGMERuv3Q98PvxxYARxlpSOFKKS1OnxBHOwl21ZMrHa6Q7z6y0yCmuUk5Zr4cxZ95F2fxgXtCZuOmt77h3S/0P5/I8DWVTAqUptO8/o46ee1yLbL2l3J464pREGqbD1WTcuKteAi/6fL+O4budvSnOiXYW8B7x882cX+t2X+rcVUpDaBuehY/qy84H5ht4dNwgeQPZaeqkN8dCfpluUNecXLzP4o2Hk6/gNDJtm7s5XzXSA93Bxggtt2KXr8XIcOIcP9Wwy0i/ZJ8gChgAqG3h2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgA7peJ4vKO8qeh1pJHJZpByeBHbiUDzcK1o4xTscMo=;
 b=OYJTQhU4n3foC5myRuF3j7bGfX+tnKxF0isBPSv49x6m5XqQvvsZr6+dFEE4rppBy53LXhHN8Zo8gn0aoHa27KrF1hKotE40dJtULbv1RELBVqZbZY0J5RJ27d5OvJZOuCO1G0ZlaBbfZQZvGSirbJ3dW6XAE/3M94ce7piELvgjDUoOiKHVlxMy5w1ukUAiCYnKiKJ10eI5a/vX+r+nsRfVKRQjKfaMzPWFQkE1FXwUavOveoRAS+TAvUAkV+9G3PcCDg9LYJbL0NUYZyakdVaTx90jO6dNEjC31oI/CxlLTjjUm3raBA4ivd92YUxvZHY1XO6uMVwm1/T97EfLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT1PR01MB9243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 22:56:35 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%2]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:56:34 +0000
Message-ID: <101a40d8-cd59-4cb5-8fba-a7568d4f9bb1@uwaterloo.ca>
Date: Fri, 29 Aug 2025 18:56:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 Joe Damato <joe@dama.to>, netdev@vger.kernel.org
References: <20250829011607.396650-1-skhawaja@google.com>
 <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
 <63ff1034-4fd0-46ee-ae6e-1ca2efc18b1c@uwaterloo.ca>
 <CAAywjhR_VcKZUVrHK-NFTtanQfS66Y8DhQDVMue7kPbRaspJnw@mail.gmail.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <CAAywjhR_VcKZUVrHK-NFTtanQfS66Y8DhQDVMue7kPbRaspJnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0739.namprd03.prod.outlook.com
 (2603:10b6:408:110::24) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT1PR01MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fb7cb0-f90f-4239-89fa-08dde74f4d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmU4K2RnWnprZFdkQ3Fyb3AyakowWVgvbzVsRkRucmZZNUNnTEc4QUdnbW04?=
 =?utf-8?B?RDhaSnlxb1RxSGphYnBSMmxDOUx0MExnOXlKYXFTVnNYMVovckRsTm8rVkNw?=
 =?utf-8?B?czNvYmJFbDN6Z3ZnT0U2dDNXQnUvQ05XRFo3bHZJYUFBS1ZZdTFXckU2ZG1L?=
 =?utf-8?B?QzgzVXNUczFsakdiQWYzaStHbFU3dHhhaWMxRE83bko1WlNuQU4reHZ1bW9O?=
 =?utf-8?B?SllyZy93WGVlVmpSUFVKYzBKdExXSDJTOXFvTFRvQjhDY0pETzNweHFyTEsr?=
 =?utf-8?B?NzdJa0QxUXhZZDFZeDJEclh4T21VZHNyUGJVc2Zuc1ltWjkwRnZpTjZkNnVn?=
 =?utf-8?B?WXU3Tis4S3VTc1NMcFgxY0cyQU9BYTQySDdWQWQyOHErSjVWNU5UZENqY2dx?=
 =?utf-8?B?ZExpUVl5YUZTV0N6Y0dxNllZRWZWdTRmUmc2L2J1QWxJMWU0UUt5cFNad3dC?=
 =?utf-8?B?RytBcHRRVC9MV3lDN3NYQXg2eGprd1hpeHh3ei9Zd2lJQVZZWDFXY05KVGZU?=
 =?utf-8?B?NFBNSmpMVEhPRGdUamJveXRwbE8rQmN3OTF1WmdROFpGK2tkNUVhYkNyZkV2?=
 =?utf-8?B?a0FZaUY5VURzalhKelFqbzlhVUl5NUF1dW0zS09BOEk0MzBIUVlBYzg0RjFa?=
 =?utf-8?B?dG4zdGlRTllUa0JIWWxKaW51OExqY3FhY0cyaTc3VGpCSnlKNVBoY1hnL3hY?=
 =?utf-8?B?bEl5NTZWemVFUmxhNFB6aFhVU1lXVS9BSkE1VEVxOGRrNDBueDVTUmdUdU1T?=
 =?utf-8?B?cGJ4NEdCajNwUXB0K1FaTnVqQzliZzNwcTc3TytUTWpxbDFyV25teTYrSW5R?=
 =?utf-8?B?REw2dUcrZ3RiRGVCa1FvQUVaT3NpdGlOUFg5aDk1cGxFWFljS05KRnFPbXVu?=
 =?utf-8?B?ZHA0VU9NMk9WRlVxNUxMaEdRZmxMSUd0UGY4OGpHM2hHeStLRmYvYUxWUUpG?=
 =?utf-8?B?Wi9GbzI2Z1hTN1ZXN016a0twZ2Y2aXBRMFNKckhqVDhERGFZRTFhSXV4c2JD?=
 =?utf-8?B?SlpZNzVPTkpoWm5VZDl2dThWMU8xd21nczJJbGZEWkl1TEp4NkhOTGZEZUQr?=
 =?utf-8?B?RWJwbDRpdlF0Yzh1QVNOMFJ6S2U3MXJVeThGM1g3V1VvVWxsMyt5V2x1Wld1?=
 =?utf-8?B?VW9mZGptRU5SbFh3Wm9BQTB6NFVIMEVsVFA1WmZTbW5GY2pqVmh1ZnhGUGNF?=
 =?utf-8?B?MkhHaTh1K0wweHdjdXFwMnZ4cnVQYW1DOGxIeTVjcUNicVE3dkdkWTg1Nnpl?=
 =?utf-8?B?RTVtNjY1QzBaYlNPN2xmQ0liSmFZVzFoOTZzNitKTy9jbS9icHNLV25HRHpy?=
 =?utf-8?B?cy93OXc4aG03SEVOSG1xK3ZNTG41b3F3SWVlb2FmM0ppcmtEaDdjUnZaTGcw?=
 =?utf-8?B?RXkyM0ZPWWFlcFdHdWFtampDNWFNV0ZTSFJLZHFRWVpYZTJNckJLMnJZY0dZ?=
 =?utf-8?B?UndqOFZHMXNFQW9qYnRLZWROOWxCeTJHNEpQMTZtelNhdnRRVk01ZTFLaFFh?=
 =?utf-8?B?RE50ekxoY25yakZDZUROb3ljbWJQODhZQ3RzYVlxT0RGeVB6UVl5dXE3RHU3?=
 =?utf-8?B?d1A5Zk91bWtFRy9zbFZnRjB1WTJ5TEF6RDhuTFdKR2NENTRTbmwvNFY2S0Nm?=
 =?utf-8?B?RFFheG1VaElHQms1S2tQNWFycDlsT0tPRUs5Z3ZrTkprUGhCNHBENjdzSnpZ?=
 =?utf-8?B?QUJDQ3FqeXlKNCt6SW5ub2p5Q1FnQ2M3NTJKZENPV1VzM2doWURDc2luWGd0?=
 =?utf-8?B?K1c1Ni9YcThrejNmcEswQ0VWRXlrRHRMNzdCTEdINExBbWZ4WkZlMmU0N3di?=
 =?utf-8?B?VTdaSEFIN0gyWFdGZUM5S2RCY2lacUtpc3BHenUvS2xiTk9IUW5IV0dxU0gv?=
 =?utf-8?B?YzVjeTZoa0pHMnUyQzlEV3RkdHY0YzloWGVPZEo5Vm1pd1BCR29nMFRlajNR?=
 =?utf-8?Q?oq+8xh8Q1S4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHplWXNWcHVuSENTSVovRm5IanV6S0Y4b1FTdm1YYWx1ajBNUXpTUHNGSHd0?=
 =?utf-8?B?Wld1bW5RYVJMTmp2WVRIQWZ1dmpTS3VBa2E4NzVOV1pqT2w2bjhLaGJraDU2?=
 =?utf-8?B?cVhqM2MzWU5qdndEL082dWxNOE5hQ0RFTCtJaU9JRnppUUZCM0ZPODV1QlBT?=
 =?utf-8?B?c3F1OTVCakxqU0krRENFdnAyL04rUnZxaFM5dWRNWk95djF2Y2xmcDlsc1NT?=
 =?utf-8?B?dTJDWHE5ZnVYMTNZZi8xV3dTOHBuRGJKZlpKRko1WFltNldhenh2TzdaRHdH?=
 =?utf-8?B?MU0xVFRBa2ljbnFwODNjVC9nWlBJN052Z20yV2N2VzhwZ2VkYjRyK3hBSkNH?=
 =?utf-8?B?MmtMdHhncGV1SS9QcGM2dExaM09hVHVYa21nRklnanJrcVRhYmJVVDlxZ0hW?=
 =?utf-8?B?eUZtTHlVeVlHN1k5VS9FcWM5amlFampTdVF3M2JZMWpDUTBFaFY1WHE3aFJ0?=
 =?utf-8?B?WGF3YWoyV2NkalBYSVF0V1RVcUZleFFzbW83eGhhWTRtM3NBY2l0N2txQjIr?=
 =?utf-8?B?aWs4clpMREhBamt2UXBTc0VCV1B5MDA1Z0ZOdWFldTBEcEJTU09pc1JlRFBs?=
 =?utf-8?B?MFFudm5XdFFjSUI5RGtQSkJtRThYQW9NdnNPYTNnMFIrMUt5RmVac3NLMlVX?=
 =?utf-8?B?SDBzMXY0OU90anBBeEdYVjF1VjJ0MEdzdTNOK01MR3QveGVzNlNhbDdqeUZI?=
 =?utf-8?B?SmIzUkRhTUdsYmdJODJqWmtYUmw0Yi9UNFFZcjJqWkZWU3VwYWxNSGxRL21M?=
 =?utf-8?B?cnUxOFVhMFhVeW0reU5RVFhSV1Y0VDRoRVBoUVMxYXNxY3BVL2M5RXdtcVhK?=
 =?utf-8?B?ektlb0o1Uk1nTXRtT0tSNWx0a3FnWnlOVnZIZzVLRkdpU1pidDJYRThVbmFl?=
 =?utf-8?B?THlQcVF4TnZPck90Nm5YTU95MFhiRVU3bmNnSHBXaHFWci9zMk54Rk1BTXpM?=
 =?utf-8?B?V1NVWGxLWllZS0tITE9STmVOQk5Sem5sUnpLcWRIQ1hub1U3cFZMSy9mN0F1?=
 =?utf-8?B?Z1VwNnlydldsZE1CYzlpbzJSNVFwZXYxcUZFcHYydnlCVkg0YnlmWTF2bXgx?=
 =?utf-8?B?aVo5bG1BWTByQzc4N3NMMEwzelE4bjdsY2xrVGlTMFBFNlBESzc5VDgrSkho?=
 =?utf-8?B?QXRlZjhxUU94aE1Mdk1MUnM2YXFicGFKcVp4M3ZIT09DSzVmUFE2QVlPRGtX?=
 =?utf-8?B?UWJmYS8xK2xJMGhWT09BcUVGNTBjZHdMckw4Uk0wWGdjalV3YkFmYzJSUXdr?=
 =?utf-8?B?NjBTQ3pDN0tTbTFvdVRUaUZORUxZUGl0TDlSKzZIQUZ5V2NKS3lLNm9PeDd1?=
 =?utf-8?B?REdaVWdjaUkyUVZrN1ZnSVhwemp4RjQ2QzV4TjlDS1NkVDFOZmpJb2orSmZR?=
 =?utf-8?B?UG5iQWMrUVJsWFoyT2tiYUxGd3ZTU1NaaUZDUDdNUERqbFl0cUNnZGs3MTVY?=
 =?utf-8?B?MnR4SkdlQVNhTDV0ZWdMYmxNdFRsRUMyQnpmeUFVV3J6dXBBazhET2tpdk5P?=
 =?utf-8?B?TGN0eUVleUNiRmxoR2tJTzVhTncrVlN4RC9ESThHemtoS1dXc2JxeHhiMjdP?=
 =?utf-8?B?TGdvUmZNa0t6NVF3QnZuZkVQc2ZTSzhpSm5CZGNwMXlMa2ZoZjNiUGF3T20w?=
 =?utf-8?B?ZGVuYVhsV09aSGtXV05neldvVVhmQTJUdjZ2Vk05THpxOWI0OXJOS3RCMEVI?=
 =?utf-8?B?VHZaOW1mSVJ4WGg2TGhTRG9UajV5cnhQSTBpekZtTkpUVXF6T1hibklnRjA5?=
 =?utf-8?B?Qnl6SWEyeW5MSWZIemdJK3kwK3JWTlg4NjFlQmdFdHRjUXBXM0dWdGEzMWI0?=
 =?utf-8?B?QzMyVUJNVzdKUTc0MjBEcWpsWldqT3VOZTN6aFp1b3VTc2NFdVI3T0QyL21F?=
 =?utf-8?B?V2lBK2EwMU1mNTQ3N2tEVUgvOTRGcnJtdzNmOHg2UFlpVlBIN20zTktrYmtV?=
 =?utf-8?B?aXZVNGNxRWxkU2FNV0YyT3BhSVR2cTZKQzFYNEF5NWliVmRXcU1scmJJNzZF?=
 =?utf-8?B?S1U0MnQvWXA3OGt3b05YMlVYcXQ3S0xzenBkUkRySkU0ci9mN3hURldlcDZh?=
 =?utf-8?B?eGZZNkxjTVJORzJaRlVzbmF5RGxod1o0emU3RnljOEZTY0JFdFZ0UE0yS1hK?=
 =?utf-8?Q?CElB4Td+tMWlyG7eLX4TrlD3Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5CfhxQb7snHSP07mhoaW+MpWdtkFHKj5TToeTcioQD+VDVnoaiKk9CfURlSUbnCgwoB7CvS9hk3EpMZ8Dj124OWA9wfvWOUDwshLOxTxnxZODj9H6tRlM4cXSS9zoZqD9w0+ItYi8+te5zg6GN1+m7bq87wqgBY4SaEHPwdqNT1mDKNahDxNwGvo1aJygR8yKAOFtHfcRsSNOvhJgGZZrMVRAuQbEDHVILXWOfp1j8V1j2b0pTyuIYbWBSdpI84E/evZkkyKuy8KxQv5KmQTUdoKygfsEfr6QUqFHf9aNPN4LzDLhJJLlT2U2GnRAa+NvuaywfV0NJ/4DToXQDSLFrQR8ux7Hq0KxHlq2ExBjSCxd3q9PejA1HpQFmFhywFFdLgF46dHaw1bjxW1PeA/i4R0OC4vF8EOylnUJJbkNg8pxDOdICo+918/VkNo0b2zurhpxj1o95xTmHpCzXDPqMXG1y0yt08NgbkuiB635JN8hUUBU9nGsttqYydu8XtwW9tt+A4ET2wTvoWF8TCIQWI3h1m0GYccpxOSeTTBgDP5Ed1c5jo7DhojWDXM0gtykphyDxZvarFG0LDWSKFaeADS97Tx8UHebNrz3Di85zb4wnbTR5zLa9DxEGOlpMu/
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fb7cb0-f90f-4239-89fa-08dde74f4d6d
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:56:34.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPBztJfyMD3ina6BYhuoLpVIXnec7qHUAIpLLRRpHPJgzQs5+HYpc12dVFu7dL0BeyMolu5AWUeBidQcCKS6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9243

On 2025-08-29 18:25, Samiullah Khawaja wrote:
> On Fri, Aug 29, 2025 at 3:19 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>>
>> On 2025-08-29 14:08, Martin Karsten wrote:
>>> On 2025-08-29 13:50, Samiullah Khawaja wrote:
>>>> On Thu, Aug 28, 2025 at 8:15 PM Martin Karsten <mkarsten@uwaterloo.ca>
>>>> wrote:
>>>>>
>>>>> On 2025-08-28 21:16, Samiullah Khawaja wrote:
>>>>>> Extend the already existing support of threaded napi poll to do
>>>>>> continuous
>>>>>> busy polling.
>>>>>>
>>>>>> This is used for doing continuous polling of napi to fetch descriptors
>>>>>> from backing RX/TX queues for low latency applications. Allow enabling
>>>>>> of threaded busypoll using netlink so this can be enabled on a set of
>>>>>> dedicated napis for low latency applications.
>>>>>>
>>>>>> Once enabled user can fetch the PID of the kthread doing NAPI polling
>>>>>> and set affinity, priority and scheduler for it depending on the
>>>>>> low-latency requirements.
>>>>>>
>>>>>> Extend the netlink interface to allow enabling/disabling threaded
>>>>>> busypolling at individual napi level.
>>>>>>
>>>>>> We use this for our AF_XDP based hard low-latency usecase with usecs
>>>>>> level latency requirement. For our usecase we want low jitter and
>>>>>> stable
>>>>>> latency at P99.
>>>>>>
>>>>>> Following is an analysis and comparison of available (and compatible)
>>>>>> busy poll interfaces for a low latency usecase with stable P99. This
>>>>>> can
>>>>>> be suitable for applications that want very low latency at the expense
>>>>>> of cpu usage and efficiency.
>>>>>>
>>>>>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a NAPI
>>>>>> backing a socket, but the missing piece is a mechanism to busy poll a
>>>>>> NAPI instance in a dedicated thread while ignoring available events or
>>>>>> packets, regardless of the userspace API. Most existing mechanisms are
>>>>>> designed to work in a pattern where you poll until new packets or
>>>>>> events
>>>>>> are received, after which userspace is expected to handle them.
>>>>>>
>>>>>> As a result, one has to hack together a solution using a mechanism
>>>>>> intended to receive packets or events, not to simply NAPI poll. NAPI
>>>>>> threaded busy polling, on the other hand, provides this capability
>>>>>> natively, independent of any userspace API. This makes it really
>>>>>> easy to
>>>>>> setup and manage.
>>>>>>
>>>>>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The
>>>>>> description of the tool and how it tries to simulate the real workload
>>>>>> is following,
>>>>>>
>>>>>> - It sends UDP packets between 2 machines.
>>>>>> - The client machine sends packets at a fixed frequency. To maintain
>>>>>> the
>>>>>>      frequency of the packet being sent, we use open-loop sampling.
>>>>>> That is
>>>>>>      the packets are sent in a separate thread.
>>>>>> - The server replies to the packet inline by reading the pkt from the
>>>>>>      recv ring and replies using the tx ring.
>>>>>> - To simulate the application processing time, we use a configurable
>>>>>>      delay in usecs on the client side after a reply is received from
>>>>>> the
>>>>>>      server.
>>>>>>
>>>>>> The xsk_rr tool is posted separately as an RFC for tools/testing/
>>>>>> selftest.
>>>>>>
>>>>>> We use this tool with following napi polling configurations,
>>>>>>
>>>>>> - Interrupts only
>>>>>> - SO_BUSYPOLL (inline in the same thread where the client receives the
>>>>>>      packet).
>>>>>> - SO_BUSYPOLL (separate thread and separate core)
>>>>>> - Threaded NAPI busypoll
>>>>>>
>>>>>> System is configured using following script in all 4 cases,
>>>>>>
>>>>>> ```
>>>>>> echo 0 | sudo tee /sys/class/net/eth0/threaded
>>>>>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
>>>>>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
>>>>>>
>>>>>> sudo ethtool -L eth0 rx 1 tx 1
>>>>>> sudo ethtool -G eth0 rx 1024
>>>>>>
>>>>>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
>>>>>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
>>>>>>
>>>>>>     # pin IRQs on CPU 2
>>>>>> IRQS="$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
>>>>>>                                 print arr[0]}' < /proc/interrupts)"
>>>>>> for irq in "${IRQS}"; \
>>>>>>         do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
>>>>>>
>>>>>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
>>>>>>
>>>>>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
>>>>>>                         do echo $i; echo 1,2,3,4,5,6 > $i; done
>>>>>>
>>>>>> if [[ -z "$1" ]]; then
>>>>>>      echo 400 | sudo tee /proc/sys/net/core/busy_read
>>>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>      echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>> fi
>>>>>>
>>>>>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-
>>>>>> usecs 0
>>>>>>
>>>>>> if [[ "$1" == "enable_threaded" ]]; then
>>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_poll
>>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>>      echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>>      echo 2 | sudo tee /sys/class/net/eth0/threaded
>>>>>>      NAPI_T=$(ps -ef | grep napi | grep -v grep | awk '{ print $2 }')
>>>>>>      sudo chrt -f  -p 50 $NAPI_T
>>>>>>
>>>>>>      # pin threaded poll thread to CPU 2
>>>>>>      sudo taskset -pc 2 $NAPI_T
>>>>>> fi
>>>>>>
>>>>>> if [[ "$1" == "enable_interrupt" ]]; then
>>>>>>      echo 0 | sudo tee /proc/sys/net/core/busy_read
>>>>>>      echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
>>>>>>      echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
>>>>>> fi
>>>>>> ```
>>>>>
>>>>> The experiment script above does not work, because the sysfs parameter
>>>>> does not exist anymore in this version.
>>>>>
>>>>>> To enable various configurations, script can be run as following,
>>>>>>
>>>>>> - Interrupt Only
>>>>>>      ```
>>>>>>      <script> enable_interrupt
>>>>>>      ```
>>>>>>
>>>>>> - SO_BUSYPOLL (no arguments to script)
>>>>>>      ```
>>>>>>      <script>
>>>>>>      ```
>>>>>>
>>>>>> - NAPI threaded busypoll
>>>>>>      ```
>>>>>>      <script> enable_threaded
>>>>>>      ```
>>>>>>
>>>>>> If using idpf, the script needs to be run again after launching the
>>>>>> workload just to make sure that the configurations are not reverted. As
>>>>>> idpf reverts some configurations on software reset when AF_XDP program
>>>>>> is attached.
>>>>>>
>>>>>> Once configured, the workload is run with various configurations using
>>>>>> following commands. Set period (1/frequency) and delay in usecs to
>>>>>> produce results for packet frequency and application processing delay.
>>>>>>
>>>>>>     ## Interrupt Only and SO_BUSYPOLL (inline)
>>>>>>
>>>>>> - Server
>>>>>> ```
>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 -
>>>>>> h -v
>>>>>> ```
>>>>>>
>>>>>> - Client
>>>>>> ```
>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
>>>>>> ```
>>>>>>
>>>>>>     ## SO_BUSYPOLL(done in separate core using recvfrom)
>>>>>>
>>>>>> Argument -t spawns a seprate thread and continuously calls recvfrom.
>>>>>>
>>>>>> - Server
>>>>>> ```
>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>>         -h -v -t
>>>>>> ```
>>>>>>
>>>>>> - Client
>>>>>> ```
>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
>>>>>> ```

see below
>>>>>>     ## NAPI Threaded Busy Poll
>>>>>>
>>>>>> Argument -n skips the recvfrom call as there is no recv kick needed.
>>>>>>
>>>>>> - Server
>>>>>> ```
>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>         -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 \
>>>>>>         -h -v -n
>>>>>> ```
>>>>>>
>>>>>> - Client
>>>>>> ```
>>>>>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
>>>>>>         -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 \
>>>>>>         -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
>>>>>> ```

see below
>>>>> I believe there's a bug when disabling busy-polled napi threading after
>>>>> an experiment. My system hangs and needs a hard reset.
>>>>>
>>>>>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) |
>>>>>> NAPI threaded |
>>>>>> |---|---|---|---|---|
>>>>>> | 12 Kpkt/s + 0us delay | | | | |
>>>>>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
>>>>>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
>>>>>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
>>>>>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
>>>>>> | 32 Kpkt/s + 30us delay | | | | |
>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
>>>>>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
>>>>>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
>>>>>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
>>>>>> | 125 Kpkt/s + 6us delay | | | | |
>>>>>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
>>>>>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
>>>>>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
>>>>>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
>>>>>> | 12 Kpkt/s + 78us delay | | | | |
>>>>>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
>>>>>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
>>>>>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
>>>>>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
>>>>>> | 25 Kpkt/s + 38us delay | | | | |
>>>>>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
>>>>>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
>>>>>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
>>>>>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
>>>>>
>>>>> On my system, routing the irq to same core where xsk_rr runs results in
>>>>> lower latency than routing the irq to a different core. To me that makes
>>>>> sense in a low-rate latency-sensitive scenario where interrupts are not
>>>>> causing much trouble, but the resulting locality might be beneficial. I
>>>>> think you should test this as well.
>>>>>
>>>>> The experiments reported above (except for the first one) are
>>>>> cherry-picking parameter combinations that result in a near-100% load
>>>>> and ignore anything else. Near-100% load is a highly unlikely scenario
>>>>> for a latency-sensitive workload.
>>>>>
>>>>> When combining the above two paragraphs, I believe other interesting
>>>>> setups are missing from the experiments, such as comparing to two pairs
>>>>> of xsk_rr under high load (as mentioned in my previous emails).
>>>> This is to support an existing real workload. We cannot easily modify
>>>> its threading model. The two xsk_rr model would be a different
>>>> workload.
>>>
>>> That's fine, but:
>>>
>>> - In principle I don't think it's a good justification for a kernel
>>> change that an application cannot be rewritten.
>>>
>>> - I believe it is your responsibility to more comprehensively document
>>> the impact of your proposed changes beyond your one particular workload.>
>> A few more observations from my tests for the "SO_BUSYPOLL(separate)" case:
>>
>> - Using -t for the client reduces latency compared to -T.
> That is understandable and also it is part of the data I presented. -t
> means running the SO_BUSY_POLL in a separate thread. Removing -T would
> invalidate the workload by making the rate unpredictable.

That's another problem with your cover letter then. The experiment as 
described should match the data presented. See above.

>> - Using poll instead of recvfrom in xsk_rr in rx_polling_run() also
>> reduces latency.

Any thoughts on this one?

Best,
Martin


