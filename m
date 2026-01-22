Return-Path: <netdev+bounces-252402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHaYCho9cmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:07:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BF8685F2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46C763000526
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D6338591;
	Thu, 22 Jan 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nM8tG0Pi"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B85322C7F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094416; cv=fail; b=BreQC1HliY1MKuGk5RgAmmS3WuiadZSjMetBFWJn+g514sep7EUlNwS+MesrRl7UbLHCwEw0dFPh8DMWWNULONDQhxxfkNzev8FNWNW+53ohSr6IXcFHS/92bOgacuuz0KPOzIgaka52VWRLazZLrO4ltWXWI7L+UgNPe8pWfeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094416; c=relaxed/simple;
	bh=bcKN9lc0R/zV7dc9t69R3IOm0FA9JM3FPLXlzHC+ya4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hquYut6k04tlMeDtmoZWwIp4vEBDHhHpGXXyUybc20T+UCNqyB+3LoSGjz+p0N6fMrhyv5SfDYDoNn7pRpOiqUXYP41Y5r7IyqdTgnIxPAwBCLJjpom/AhKmHOwYmg4s7H6yBww6FG1kXi56qQjQVeOVojoat4xI3pXiZOqOeIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nM8tG0Pi; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahdPbUBGDcdjrXlFQA0J5l2PJrZfOcl6+o/wFiB1VLm83tq12623iITY21PzOsewoIXqmiWEht8CdDIvuS8in2XQ5XASPipqiVKwZ5bygOXl6qhm3hNVOVp7+2tIDYtq0k7O+Rjyyy7GVUmIY5D/wLjILhTI7Q72IOJIW/nDRkCLrD60xzSaiaPNxnOGmRE/9PZG5asTOgBdeOV1eUHG5YWjb9Pdbz5zylhyWc7ij6o9cp03R72MqLoTVlGeAVh3nN4suR8XBgKAdDEtt1P2QOlCx4sk1XKCOWnPC5oLD1gPYzVrfuyEl5LEBWKSXpbwwdO9GFmb8bOepWQ3/M15Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsbCEwIypzdv8IOZAxf4B7vPO/w1N/rk5bn4J+XGmsk=;
 b=ZdiLR0wtUUw4nMMK8iri6NBWv0vzJV8kUl8fcipMZMKMy1NItLRir7xEBrNcCPa2bc/eZj4zmqDwBUtvLgG6Qr5G6KY6b9x85IsPKijHf2CQ5+hFtqs1apxmVG5S5dDBKh0ODAp1yrczUFeTour0gBxQnaJefgxfGJVd5cWJFD6jEkmjnUtfRxLmfTSSq/Ctq1DE7y1UuevddS+hXjgd7ubQNlwtF7/wgKAVy5KpPYCGITkzngfGd001gOIp4IG4PjGa7tF++OOGhbsChUX2P08vg6dgB/hCFypLq7O1siKvJfD3VcADjAskoJQpeJd3/tSQSCheYePX4LfBH4ydlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsbCEwIypzdv8IOZAxf4B7vPO/w1N/rk5bn4J+XGmsk=;
 b=nM8tG0PiYk+cFEPgbkWT9iLoGPkwDE9MpIpfd6QykWM4L6Pw8cf8Z3FYq9zSzlJi3+NEs/9t0Rr0xgqhvCeOlb2X1Jk2JyJNH0wsWDdVaaa564QqiBj97YMjVFgww2rsffcQ1KnRfChjV2b8HDWa1jO24V2spFkaooeCaOT4F64+lsWyT5zBZ3laTEUvVI6G8lmUQtm4Zhd3P2G0Cs1t8mrvxBHzGhzvhKrOHdiS4R3MLSqAXCdcnsm1UKhZyfbhsaOlKZc/ZsdlvrT02fx4qhTKWdpjtC7CBzsLXOubmmu3Hx/DgHtlG5ncFuUs5JB3mCEheFBicN7vf2uiXFDduQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 15:06:45 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 15:06:45 +0000
Message-ID: <bb985b09-fe29-4fc9-9c06-310ff3abfad1@nvidia.com>
Date: Thu, 22 Jan 2026 16:06:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: use netdev_queue_config() for mp
 restart
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 sdf@fomichev.me, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk, daniel@iogearbox.net
References: <20260122005113.2476634-1-kuba@kernel.org>
 <20260122005113.2476634-5-kuba@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260122005113.2476634-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df4cc5e-4369-4f2d-cc44-08de59c7dbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU5kRHRNbE9ydzlLUk55M2Q2ZTZ3Q3o1dUxVTDI0OFVOZnpaTmJTdnl2dTc2?=
 =?utf-8?B?QlRsTlNsZmZyMklleVVhNlo5UmdJK0h2MHZVdmR2NWVWemQxTkMxQWVJdGxC?=
 =?utf-8?B?cmhFbFM0RUVMMHFTMlBSNVpiYkVqalh3aXZzZ0hTeHN6K1RXYXdKeU1rTmM5?=
 =?utf-8?B?K2d4b29UakJ4SjVZWUZ6YnFzSXJSWjl2OWJVQUcxcHkxOE5YZHNWLy9GQVNW?=
 =?utf-8?B?TXJ3aXlzR2xNcnErY3hYL0JaVGNOb09yTThSZmI3eUFpWTJxRUZxQjd5VWJD?=
 =?utf-8?B?OVBGWkZkVzBLeTJUd2llNHk0OXQreHgxRWFIZ0RHN2phVjBjS3RGVkpwTzA0?=
 =?utf-8?B?N3JKSkQxejZtUWJEKytwZk8vdkZlRzV3V1VXL0ExMUlHRkNPdGgyWjBnTU55?=
 =?utf-8?B?OW5jTUFzRWQxTVBVWXN5SUFZUTM1N0tCaXRtYlBLTXVVM0xqU1B3NUtnMDhL?=
 =?utf-8?B?MXB0dHN3bkdUclhtLzZLS0V2MEdpeWVPQ0J4WkNsNFU2ZHo4Z05YWVAxY1Bl?=
 =?utf-8?B?V21QUnh2aDIyaFJyV2VCUHNYYjFxanBhV0xwaHIrRzYxNkJWdHRhNHh5VUpi?=
 =?utf-8?B?UE9RYjlBU3JmYlpISk4wNmEvdG1neldmQk1EdmxxQTFtbitPTnRQWGpFMzZl?=
 =?utf-8?B?U3Jjajd3NFFnUGVselNQeTVYdTFaZEd1M28waXJuSUJOVU5ReFlyY2VIendk?=
 =?utf-8?B?SWR6dmh6RmdFQnNyclR3cXo4ei92amdSRnRZc0h1ZXFlMFdmckFFVXlQWHIx?=
 =?utf-8?B?TFU1VWcxWUZNc3FIZDBiaUVuMVRvb0NGTXljZDkwUmFmMUk4ako0clprdEFk?=
 =?utf-8?B?YkFnOUlpQjNGQngzQ1Jxck5ZNG8wSjNDQ3c0ZXdwQU1rR1NWdDJ5QVNwZGdZ?=
 =?utf-8?B?NzQ2eWg0empRQTIyblBtMXpIa2JvSjhDN0IxcFQ4WnQ5V2JEUmYzZVB2MTcx?=
 =?utf-8?B?dU1NODMvN2lxL003ZlhZK3l5d0p4UDVrMDVhOG5QN1p3N2s5YkxaL0NsLzBF?=
 =?utf-8?B?NXVBL3dhcWdFNUFHaWF1OFlCdHJFS2R1Wm4yVDVuTy9CcE5PdmpzOG1EVGhy?=
 =?utf-8?B?U0I4Z2FTb1FwajZGZEhWZWFZb0JTcFhwaVZJMlhRTCtQSkZOUlgweWlKT0Nm?=
 =?utf-8?B?MVF2TExQVzhXT0IvVWRoNmR1cm1oOTdQRGtMYSs5WTJodUNlQTZiZVlvVFh4?=
 =?utf-8?B?V2I4UFJWd3hIRXI1YzliRitESmhQQ3d4QTlsT2NoemJlOUM3TFVKdjNBdHZz?=
 =?utf-8?B?YzJ2dmJVbUpmVjR4dm9HcGJma3orOG5hT0J4VFIySC9iRVpxSEpLNW02NGYy?=
 =?utf-8?B?Q1N0N3hvVnB6Qm5YYnZDWG0rWkZTaTVpQVlaUEkwc3dNWXQrR1ZleU5Hd2FO?=
 =?utf-8?B?ZmZCbEk3WEdUUmh1T3VxSm1GemxlWFZCU2dVbzlUZVMyMUt5LzIrbk9mUEpw?=
 =?utf-8?B?TXRtaXZJU2pyS3F3K1lvbVB1VldkdXRmbThLUHlua2s5NVZsR2hqbTJLaWRB?=
 =?utf-8?B?NHlKVHpCZy9Uc1FpZHhaNExMY2M1b2d1RkFmM21XMkMyL3BzWmVHZFlzMG41?=
 =?utf-8?B?d0FoNTV6eWdNS000a3Awd1F3ZVpVeGFBR2JadTZNbzI3cTBjWldDMFBpV0JW?=
 =?utf-8?B?L0RiY21FOXR5bHQ5czRTUzE4cjdrZTh2dld5S1A2NHFod1VxaVFyNkIvK1BM?=
 =?utf-8?B?VWd3c284aUk1K2d2RGNyeFQvbXVlM3FRdkJHdW9sM1ljbjQvUmZvd08waC9r?=
 =?utf-8?B?UHJxMkdEamRvRWVmZkEvS1NOS2hYTUFkNEl5Q2R3UElCalNsTkEzZHpxVDJ3?=
 =?utf-8?B?RkJlRk1wZk1nbTFQZlV3QjYyeVRJUjVRME5EemQwZzE0ZXIwWnl6bWcvUUtD?=
 =?utf-8?B?bUtPbFdkZGdPdGx1UWkyMXRsVGJPOEtROHZESUR5TWdOZG5PaW1VeHdaN1g0?=
 =?utf-8?B?R1hRU0Rpd1JCRWRkbG9ubGVKUys3bndLdlFPS3dyUEpYUXRZVWxYeGVrb0FX?=
 =?utf-8?B?Y1UrblI3eFVGbVZjN1ZqWlZ1UWVKVGhteCthV2pVRE9uR0wrb0d1MDhSd1M4?=
 =?utf-8?B?NGhYT0xpNFA0VWgyOFIzS2MrRXBxZWhTd3ZoeVRNOFNnUnRrWXIySTRHYkg0?=
 =?utf-8?Q?D48g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2ZQa2QwdGxMSzliaFdMZDY0bm9xMXgveHBaU2MrSnFNZmRYRXpuQUNmTnNC?=
 =?utf-8?B?MUI4aDJkTExsTmxob0g2YjV3MmFkcTNlOXBSMnJvT0hwNkVYYXg1cWx0RFJl?=
 =?utf-8?B?MkN1MHBsVDFqZitYVDQzOUdYbTA0cFdnOTZHRk81VUhmeUhuRm5Ibkt5QkpN?=
 =?utf-8?B?dHJMc25YLzlNa2h3WjE4bjV6eFlxUGRPUkFBK2NLMnErZFBYSnNtU0ROOVJ1?=
 =?utf-8?B?V0p3bmVXQnZyYVRFZkcybDdDOERuNjgzTVVPckhoRXRpYmZoRGdxK0lyMlMv?=
 =?utf-8?B?ZUJDWjBBVEg5ampQVndrU1hOckJDVnlBY3NLcXJoOFRMbStRTWFNV1JFT1JL?=
 =?utf-8?B?eG5OV3dmRlVHVzRQZFZjajFpM3ZFRlU3dzl0OXJzek53ZWo0WloxZUxtZUZH?=
 =?utf-8?B?VnlieWN5N1c4ZldaOGVicGlCckl5VnRaUDd6NzdwNHdLM3VHZnBvQUZNVjcz?=
 =?utf-8?B?SFl4NVpiOElWUkV5TzNXUm1NS25XZ2pzR1V0UGJoZzQwN3dCMW1UaWdaT3F1?=
 =?utf-8?B?S1FWUHhocTd5ZHhLWC9WUVYzTzhpMU9uYkJUazRqSSsvcDI0NWxTblBra290?=
 =?utf-8?B?RWYrVDFuZUk2TEJkdDFDYm5QYW9OS2dGLzlXNkFIZ280OXIwcWZFcVR0WStp?=
 =?utf-8?B?NXhBSWF5YmxDZGpGZFhxd05TZm56Y2NReHFDc3FybFk0RmN4Tk5RcGJQc0FK?=
 =?utf-8?B?bjNSTE5aU0x0SFY4Y3I1TUtWRUt0TlBjcGdISXY1TUNab0lodW12L1BkYi9t?=
 =?utf-8?B?RHJ3cXhSY1JJaGdvQkdGRHNPejAvTXQ2SE5Ub2ptWFAxYmlZaUQyUlA0WXU3?=
 =?utf-8?B?WmNta0lUTEl6MXpOLzNsdGg1ZFhNL214OEp4WllQZkFKenN1MVI4VkozRXpF?=
 =?utf-8?B?WE96L0RLOVZCVFR0Nk1NQURPOGE2amNLSHd0U2xBVlpmSjZ1aW1hNmZMa2hx?=
 =?utf-8?B?YUJYT3VMSVQ4OEU3M3N5a1FvTVdSOUhINFM3bTBaR0kxRGh4UXQ1QnZJd1dy?=
 =?utf-8?B?SHhxbWVEZUI4Z1lzWCtyMFBRbHRtRng0WDVuWTFsZTBFeEJBaGZ3amhaT0dF?=
 =?utf-8?B?UHZvOFYyaGNwNjhsZDZ3WkJUUmhDTFFkZDlMQThJdHNDRDBZaVFwSjVSYnVi?=
 =?utf-8?B?UDVhMm5XL2tuSjNDbGlMQ29TeDMzaml5WWE3Sjc2czJybTU4Y29ZMzh3L2xt?=
 =?utf-8?B?aFBOdnkyc3lBSmxPTlJ5YnJnM3JOSTBidVgrejd3bUNOU1QwMnBMQWErc01y?=
 =?utf-8?B?TTVXZVRza21lUUlidGtPRHNzVjdWdlEyUElEQUxLdmR0Tk1rdVA4ZWNEZGVF?=
 =?utf-8?B?dWx5ZXZsZitPY3BVdUhpUE9ZWUQxd09HV1dzM3F2dVV6K2p2dFFZemhzR1cy?=
 =?utf-8?B?eEtzV3NQK1RmYjFsZXNBdnI3ZGJXNGs5TEhuOWN1NFZQeGRTcE9TOWs0Z3FP?=
 =?utf-8?B?ZElNeTJDZk5jNWczZ2I1Qk12VW5wZGxnWTNac3Fhd05pTDBVdEp6WTlqQW5U?=
 =?utf-8?B?Z2d4TXczamJzaGtIMktoSmhDR1lGRytuOXRLTzh5YXErUDRWbXgrWkVpaHFC?=
 =?utf-8?B?ZGFqQkp1Y2tvSHRKK21FR0J2ZVlYK3pmNkVQK3dDN1JQSVYxSzR6ZVlZMlhM?=
 =?utf-8?B?VEZGWDEvd3J6M2FPT2hUdlJPSi9zc2owOXZzU2lVeTFseFBRTUpzaWw0WU5q?=
 =?utf-8?B?enMrd3ZQSDVTSkhjMEx5NGVudkVSRVZOdkNLRytxT1NKSFM3NEVxN3M3QnFi?=
 =?utf-8?B?a2d5R1lBUUNKelAzWTU0dURKZno4alcwYTJLam0vclRPZ2ZmWjhNOGlIMFBo?=
 =?utf-8?B?bzJKS1JySUJ1ZkR1KzU3VCtiL3U3MUpLOXQ5Z2Q3OGNpeHZLSDIrZjhGTWo5?=
 =?utf-8?B?cFFkWG4wUlJWVnQ4emttVmRNNEowT20xcDIvK1J1Y21EL0NVUVFTaW1Obi9L?=
 =?utf-8?B?ZWVOczF0M2YxU0FLSk9TdkwrL0JMSE1LY096UXlQV3ZxdVJabExpenVUbTEv?=
 =?utf-8?B?RUZrbG84aEE0MEtIRFZPV2hwUmF4N0QvZEN2aldXSllsZkVBYi82dklCdFNv?=
 =?utf-8?B?OTRXcmZJR2ZyZFpPdEU4NGlENjhHa2VvdGpWTWRkRktJQ1FFUWpoOUhyQWJC?=
 =?utf-8?B?V2tkZ21pZy9WNlpCR1ZZZUh1U2N4ZzVjQ1o0QWZ4aFl0WWozUkE0RnZ0cW9U?=
 =?utf-8?B?WlpUVjIxTm1BVzVYMnlJVDV0blhQN0xpbytuL1dTTE9NVzZ2QkN4eG8vbElG?=
 =?utf-8?B?ZW14bGRZb3VkMlkvdm15Q2EwMTlVcTVUMVdFa3B3MkVmcWJYU0hGYmREYlRy?=
 =?utf-8?B?dURQSFZDa0t4THZ5UWxFTHFXVE9OUVJJN1haNHVBTjJleHFEVkhUQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df4cc5e-4369-4f2d-cc44-08de59c7dbc3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:06:45.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsZSm5EO1CG3Y1YX+IZgV4HkPDm3Wos9MAZSkjGrvb7KWWhxdrPEcEkTEL7j34HsHaa6+tQiN4bEaed6aLAE1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252402-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,gmail.com,davidwei.uk,iogearbox.net];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: B5BF8685F2
X-Rspamd-Action: no action



On 22.01.26 01:51, Jakub Kicinski wrote:
[...]
> @@ -154,8 +154,11 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  	}
>  #endif
>  
> +	netdev_queue_config(dev, rxq_idx, &qcfg[0]);
>  	rxq->mp_params = *p;
> -	ret = netdev_rx_queue_restart(dev, rxq_idx);
> +	netdev_queue_config(dev, rxq_idx, &qcfg[1]);
> +
> +	ret = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
>  	if (ret)
>  		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
>  
> @@ -176,6 +179,7 @@ int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
>  			const struct pp_memory_provider_params *old_p)
>  {
> +	struct netdev_queue_config qcfg[2];
>  	struct netdev_rx_queue *rxq;
>  	int err;
>  
> @@ -195,8 +199,11 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
>  			 rxq->mp_params.mp_priv != old_p->mp_priv))
>  		return;
>  
> +	netdev_queue_config(dev, ifq_idx, &qcfg[0]);
>  	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
> -	err = netdev_rx_queue_restart(dev, ifq_idx);
> +	netdev_queue_config(dev, ifq_idx, &qcfg[1]);
> +
Is it ok to assume that on close we always resume to the default?
For now yes but maybe in the future we might want to save qcfg to the
state before mp_open.

With the very first rx-buf-len series it was possible to set a
rx-buf-len via YNL for a normal queue, switch to a MP queue and then
on MP queue close the configuration got switched to the default value
of rx-buf-len instead of what the user had configured. This was
not convenient.

Thanks,
Dragos

