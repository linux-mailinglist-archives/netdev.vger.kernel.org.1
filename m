Return-Path: <netdev+bounces-167000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB4A38467
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CDE167E2D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B021B8E1;
	Mon, 17 Feb 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JNeR4kYv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBA216388;
	Mon, 17 Feb 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798251; cv=fail; b=MXMr41D93WVfrXDkEYe/oMRDlKd6jwqFGgfRMQoq6fN8nQxZANIuetOQQ56nQnanuEjpkw6f2tL3b0zOIAv8crh4raegqy29+8cqzSWUxp0V+0iC6I8ovPoVufDse/nL/lQso2zQc71jwGkh+RbJ7OUOmAunaHN9IGP8KW+oK7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798251; c=relaxed/simple;
	bh=uqOeKaCf7Zh7xNQNvi43+PiWScVCUTojmBxAXo9PpNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HeJnvD3m4hFtL3aONvaZZ0sjOyDShRhS6GG/nyfYHUncUWR6HJGZ88ZM/MMEZzdo6KWdJ9Twm3wq9iHcFQhPTYraB2831ARD2II0GAkF3c7zULemzD884u0cSenxNT41gt8cdldKbwFTkN0WfUuZ3CZRQlVtbzEa+NKByQIftrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JNeR4kYv; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4aepPWDzUtIJtGdVgNKtcEQXnAM9rqyfv6IL9rHCH7brhAd6NikeVYBms7ORLAntJu46A7u80STeL6Kd2JrDNtCajlxIehgxG0wcBWMna5l9JQFjuQAsCN/LjQZVJ/O/GTH/deqCgUMpYEhNf72VBhJ6BW+47X5vdzGBwDl0QcysBJQihu3zUVtdSuIhq59curMxSD3HfbxlbUpxiLX/4eyOjb6/IatPK2Dfec8IJENMb1tEMgFpO3UqDc2nVy0V/Bj3aAPyTzH2usJCtbMR+dfbhKFBIao9Y1+uTu5nNv+IxVMFtn2CPUH4OpMTh4FlJRi6mTf3dA6Mup/cddsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0NPc1X5CohSqVQslB9URYGt6Em5RElbpP0WCrTF3xI=;
 b=UhdjGTiZAcs9Lr4drybfyAm7WkVAcvbtQCTQP32kyBg6U48zQGSMtzdsDVkBgBKX1J586Cg+t6lYBj9RslkXD4exaewg0r+jo8OdkqpywnDV9FBdTfk8R9u/iGAHW6X5zukKII7ILCuEJQaW+1atiuuLrfRxaIIvCMhozlk4FdCkhCtBPTbRwQtpjJg8xo5/3Lz7xnbXq9hamMFa4Msw6PeWC3wZ/pvjS7MwAScYfWYEXnN8YKk+buroT0VRX+0n5oMfi1Pcr8uhYG8UbSUGDtlBqgEufLhBL0iKkRKJI9IDQKXp84PYmShGmLD0LHmqkiTscv/+QjnLSQXKIEcuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0NPc1X5CohSqVQslB9URYGt6Em5RElbpP0WCrTF3xI=;
 b=JNeR4kYvQl089+Ejd/SnHkEr2cmhuba/VA7q7D7OqEEWCjD4fLlXDuI3AKfIPpSdAUg5L4G536KZblD0WrBlUCq9coDMfP3tEE8JVnt1JY0qOh0bN1XAsLON1TS1nBKNjU4B+RhoN9o3p2ETNGor+CtRyHUGED4ftwdArXo6+hU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Mon, 17 Feb 2025 13:17:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:17:27 +0000
Message-ID: <b12ba8c7-4dda-4e8f-b4a5-da02f8fdc262@amd.com>
Date: Mon, 17 Feb 2025 13:17:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/26] cxl: move register/capability check to driver
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-5-alucerop@amd.com>
 <20250207125223.GQ554665@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250207125223.GQ554665@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JNAP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::13)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: d67d928f-7d3f-435e-22f8-08dd4f556c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHljRm1QZkpTMU9uTUREbHRQbDA5c3hNM1hRcHVhK1R4SUx1S1oyc0ltemJp?=
 =?utf-8?B?QXM3ang2QjEySEw0ZzA5OVdNMG03K2p0SUltd3hMZXVwaS9wMkowUWZoQWpY?=
 =?utf-8?B?bVdYSnRnVlZUVDZUSHhBT1lxSlFoS3BwY2FRakhudTBJd0QzN0xzWWh0Mko0?=
 =?utf-8?B?QVY1Y0E3VU1HSnk2K1JsSHlMcWZzN1JBbWJjSTBDcEQ5WFhNVXFVVTcyUnFC?=
 =?utf-8?B?Znk1YW4yZFFsU29yd2hpK2RYUTF2NzBrSGQ1T2RuL0ZFZmUzdHUrc01IMm9o?=
 =?utf-8?B?WDg3MUhkRDdWUjJYWWpsV2xJK04xd0l3MXdKZG1wN3RXRXhJS3JPREVZeEp4?=
 =?utf-8?B?RkFOYkJGK3NZVWViY1dpckQ5M3BuNy9FdjRLdk5YbjJ5RGFNV1RoWmZyejQ0?=
 =?utf-8?B?eWlZWHBNSnVSUW1JZXVXTzFFaHBCY0ZEZ3NHbEV0MWt2OFk3dGZlK2xEcGEr?=
 =?utf-8?B?cmlmUmk2MVZVUkpNNzZOUWZBYjB5b2Z1cTFqMHN3SXlodXFRVnlpRmtsYkor?=
 =?utf-8?B?OStmSkRWbVlON0lrZHZ2U3JhdXVLZU42OElSWVlsckxQSVZvNDVBQmk1T2Jq?=
 =?utf-8?B?cGxaNUpOWW0wK0RESFRoK2lsRFlzNXZ0WWhleWJETklhL1hRZDUyVUxSdmk0?=
 =?utf-8?B?d0NvQ3N0THV6ZHp2SVhOQi9kcGxXb3lQRWpnOFFjUVpVQldMVE9ZYi9GNnFF?=
 =?utf-8?B?UHpoQmY1aDlWNEhmNjRmZE9HM2NtdDc5em1SR3NFbjhMTlhVSFpkTzlGOHY5?=
 =?utf-8?B?VlFiOHcvbWdXS1NJODFGa1k5cjVvYnptRVhnYXh2cHJSTjBjVXRUOWdwR0RL?=
 =?utf-8?B?R0N0azByVEMyazJiVlp6NmNROHJ5WWNpbklZcmZZdjZGNzlld3hkYkpmYm51?=
 =?utf-8?B?eTNKS3VLanRvbkFOeEJQWTE1SlRhZ2lFRVM0OThDSWIwNGRPbmFTSGRpOXhz?=
 =?utf-8?B?YUlsMFh3RENJcDZKTnVCQVViZVJZWVNPb3N5TGNWenNyRmFXVHkwaFlzSVZZ?=
 =?utf-8?B?T3JJRkFlU1BZQ2dnWWdrcmdJYWpacTc4UGZLZGpkeWFFUndWWXpWeTd1eXBK?=
 =?utf-8?B?WUpaZnBTSThZd2NqZHB1MEhWVEF2U1VTUW5QbjBaekhoaTN5TXVjNDdiM0Z4?=
 =?utf-8?B?VFhuV1FQTGZWUmlvcG00WGwwakhnMmdQdEpXeXhpbWYwTm1WS3pSbldlaHg4?=
 =?utf-8?B?NFNiTEdITXJQU28wL0VjMEd1ZVFGWG1mR3ZRUUJuRWhLWVFGdncrc3ptYkVq?=
 =?utf-8?B?M2tHWHoyc2p4cmFWblVvN2x2eDF2d3BIQUlvNm5OeHJvZVRlQ0MxdTlMcUNl?=
 =?utf-8?B?Zm9qQkl4ZGp6eFBuakgvVk5VNmcycjN6ZTJHRGJFME9abUEvYW5mQWV2eXBY?=
 =?utf-8?B?Sm1EdHNSS1lwNDM4OXZkNjF1VlhUSksxODF5VHpqRU5oQ21OYnA0RFBzT1Yz?=
 =?utf-8?B?RTM1cS9mZ1dBSkFCSmRWTGpmM2FhdXV2QjB1RTJyN0FQQ3BGcmoraUNkSm9Y?=
 =?utf-8?B?U1BkWVJKLzdSSitFQWpzZ3N4bUVoN295TDRTaDYvQW56MHdzWGFVd056ckpt?=
 =?utf-8?B?V0E2SmlSQnZ3aWUrYXBFL1dJVkxWYUVWcGk4ZWJHcWdpMnVBemtzVDRzTGkw?=
 =?utf-8?B?bklRSGY1ZGUwb3owTmJ0WDR1c1RVOTFMb0xnOGVrWWJza2t5bjR6Q0xLbzU2?=
 =?utf-8?B?VDVYdjNIWUNGWTNqbHFCYWlmQzQ5bUxvejk4Y3hoblRjWWR5STdoL1dydUlU?=
 =?utf-8?B?WllTSGMvWVUyMERsZTVrR0N0SDZRVC90cURPakhqOEVkNXZzUFdibWlISzVy?=
 =?utf-8?B?SGNKOFBycjVjc05aaXArazltb1hsRjJwbHpab0krZUpYRk9JcTNKVUJwTmJU?=
 =?utf-8?Q?w/WvTkBqzm9ez?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUJ6S0dxWW1RNGhoVForUWJaZUJnMDFxQUhNRFgwbzVtLzVBNm54eXRiem9G?=
 =?utf-8?B?NW9hU3pXbjQxbWt1VG5rVjFXS2k5SWhjbmFsWSszanBESzZ2OGM0QVRrcnVl?=
 =?utf-8?B?YmRsZVM3YWZTZEVwWG41T002REdtbVZQeVBtUTE1ZGZnVG9HNWRYaGlURzVI?=
 =?utf-8?B?QmV1WEZSZjhlWWorMm1IZkN0eGllR0NEb3lzUmNGZ2Y2Z3F3SWhrZm9IYVNM?=
 =?utf-8?B?ekdVTGNlWDdIdjZYVVRCZzRnbGZCSG0zZHFJR1hnRlpvaXVuSElFU0tBUVo3?=
 =?utf-8?B?dGVuYkdobWJ0Z2NnSmYwZWxGVnpKS1VkaFpGZjRrQkN3U2hxbFhwL1pzTmYy?=
 =?utf-8?B?YXhpN0FCQ245bkFnc3ZCdlNHbnhiNW5jQVRWemEva3plY1g4a2VSSzFrTUVh?=
 =?utf-8?B?TTl4MmhCckFjc3Q3Z0NqUkhRdE13LzBxT0h6V3kvUWZkSXoyMHJLUU94TVB6?=
 =?utf-8?B?KzFUdWViZWhuWVZuM3poYnVKTnRVYjcvSjIwUzRuVEd1azdnai82VmZmUmtN?=
 =?utf-8?B?SklkQWRGSTVMUWtQOHRiRkJXUmVPdHB0MCtVSUk1RHZaa0RjUk4zeXVsVjAr?=
 =?utf-8?B?S290Rzg2NHJmY2FrSE4xK1Q1Y2ZLdHNmaWRDRnlObWphRmNaSWVUazFWRU05?=
 =?utf-8?B?Y2tad1VkWk5Hb0FFQThXSTJIekZzMVdJK3I3Y3VGL3l1NmN6cEFtRGgyODdm?=
 =?utf-8?B?RXZ5Q1BxZmpvTWV6THV5TXNqWTE2aWZKQ09yMGgyOVlGZDY5RXFSUWtpVk9k?=
 =?utf-8?B?OGdLc0JiTjdVOEhteERvRjFVUkRUbk11SlR1eTFVaFZhM1BSem5Za1JLODFn?=
 =?utf-8?B?UFJJejhpdzcyWXF2VVhCODBXZWRJTmkxRWJBa0xSTnVZUU1FTEVJV3hFa2Rl?=
 =?utf-8?B?aVQzYW80bkJWVmJHVW5hc2hJajEyd1BFeWx4dHZHVWE2dFE5aDZsLzZkbXZ3?=
 =?utf-8?B?eTJUaUN3VHJQRDQ3ODQveHErNUdZeDFUbU1sMU1NTWUwdnh4a2IxRWZtTVF3?=
 =?utf-8?B?WHlGeURLV2FHclJKb1czbU5KRXhBRnIwVFR0VkthZ1hDblU3M1IzeEpRMCtK?=
 =?utf-8?B?cVNncWViazB3ZjFBQjBQL3l0cUlZTlBsQURlaTR3YzloODl6ZWVBZ1ZDSUo2?=
 =?utf-8?B?UFl1enNxb09ySHhUY2h3ZXJlSVYvMmZpS20vc0R6d3c3Y2FWUktiL1d0SmRv?=
 =?utf-8?B?V05VQ0VqVnpCTnJJdVJpOGgrVWE4MW1QWFFHVkZMRzg2VENFbnZYRXhHTHg5?=
 =?utf-8?B?QU1lOXc3S25tRm5hQ0I3SG5oUHVPUkZzemdiK1haLzF0SFB2eUdwUmFIL0kr?=
 =?utf-8?B?RXBYSFh4K00xZGttTTNURzVpYy92Q0gzWHVBbi91ZG5kYm96VzFWQXJNSnJi?=
 =?utf-8?B?SUtwZXFVNVlQNUhRanRoM0kycVVweGhoTi9yVlFKRWZDdXNTczVlRC9ySm5F?=
 =?utf-8?B?YXNNWld2WGJzSjdQVjZWRGl4YzdnWVEvZm5QTi9vZVRTTlAzVUxkdWFuMUNX?=
 =?utf-8?B?UmQxb2t0Y0ZHY1ZSaS9GdFRLL0pEdzJrdnZvYWF5Nlgvam1zWWJpbW91M2oy?=
 =?utf-8?B?d01TZmZPUHc2S3R2ZUJNR2h1NVZHTGk4UEt6WXhaTVhNWEo2azlQcTlRSnVD?=
 =?utf-8?B?RmR4L0JYelZTK0huYkZOSU9ra1BuakNBTVUrUmlzMHdTSENBVitPQTBHanVq?=
 =?utf-8?B?UjFkdzFRcGM4WVNqUHpyeXpJVTdMYThuYkIzNi90MlVQcjlUM3p3TDJwbGtT?=
 =?utf-8?B?dTRHVER5Qis3VlM2S2R6RGNTRzNUOE45ZnoxcTRaVEhqTDZPc0x0VzNZWjZu?=
 =?utf-8?B?RVdKdXovMnFKN2RpN0pSSzJLN1NuV2V6RmNEK1MrUU9CQ0kzZjY1S3ZBR1k0?=
 =?utf-8?B?NTZMcG1BTVRKTXU5NS9VS0hJSzF6YkZMMVcvZGQ5REJzYlcrYUFJYlhZcEJx?=
 =?utf-8?B?ZUU1SlRtNHZZS1k0NDFPcEorSHlsaWE2UmRtRFJhNVZGZWl6UTZsTmN2d056?=
 =?utf-8?B?QnB0cEZoWGpjd0E4Q3djRDFCbDM5VEUxcjJrM3Y0dmUwdEVuMTlVZFVGMGdC?=
 =?utf-8?B?aEMrMm9RQUUrL0NhSnRnT0tLZlhjWXZPZ0hUZEgwSFpOY3BGL1VMZGNJY3Nn?=
 =?utf-8?Q?uwpr9h7y3Be9BNnyK2LqtXXyj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67d928f-7d3f-435e-22f8-08dd4f556c8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:17:27.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ3aWgmax+yFt8cKy0r6MH7xa5uWUkCxGf2V5bVTunSrHZUJjkEBzqPn+JpZSpv84atE5MEd6KQWJVkB8N7K1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112


On 2/7/25 12:52, Simon Horman wrote:
> On Wed, Feb 05, 2025 at 03:19:28PM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 has some mandatory capabilities which are optional for Type2.
>>
>> In order to support same register/capability discovery code for both
>> types, avoid any assumption about what capabilities should be there, and
>> export the capabilities found for the caller doing the capabilities
>> check based on the expected ones.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ...
>
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> ...
>
>> @@ -117,7 +124,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
>>    * Probe for device register information and return it in map object.
>>    */
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> -			   struct cxl_device_reg_map *map)
>> +			   struct cxl_device_reg_map *map, unsigned long *caps)
> nit: The Kernel doc for cxl_probe_device_regs() should also be updated
>       to document caps.


Yes, I'll do it.

Thanks



