Return-Path: <netdev+bounces-159797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731FA16F12
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA6E3A9B19
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC21E7660;
	Mon, 20 Jan 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5TyzWEi3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E11E570E;
	Mon, 20 Jan 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386103; cv=fail; b=EMh7Z4UeqbycZPnLfYckJ6iRoljx5MzIaNn+VfpTV2D/zcCWaEDa+q8Bgj06XjQ9A1NJfJC9ssCZHVt+EmAhOowRDxsJHnGrHbz5NK0Ot14Yiry8UOMHAXyPIgetllCHDk6rHfr6F3ze2w8o/yjt5PlyoAtinCzuCGmqhdLV18E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386103; c=relaxed/simple;
	bh=NW8XSaEDMSOEqWjr0UR6YqK3LzLzr6gmJAZ9UUze260=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UJxxhJIg5OONHkMZp1WHhJyCQjE2C5bQL1uqhH4MmKEEVLzE+LXsjlpuEUXb7SIEIa1vQh4GM3YFY/AVXyome4t4ui0rk+gJ4QetMDowKYxNoukxtQXHuimN5YJqltT3wSFyc/fvc3KOZehao8cL3iIdnoJGUJfwuIMlS13ril8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5TyzWEi3; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOkQwHrkZtzLvsB8PVB79i2XdTTy5HYYDB90OVLBBt+j02zDBHSdnGaAXLNcNxcx0mgIAL3r12585GS0DniVE8CYs5JfyOHpQiWE4J4dYvkBb36LanLPm3TOS+dNxTizeki1TQ8NlZbwRWolREsm6BOhbgNYnHh7RdntRSrxna8mhhsDsuke4LkcUFGQdu8XAS+mRhAdwbt6NeD80fxACD5M5DCwV7whhVq7BaThmhznfwFFURTjfdxHPHuI4nrZx1mjmk8xkF4/Ml9tp8LQ7Ut0aPcPaNzk6e1m+4XpHM87tWZU5mb2hlCUNgcqfeWwchVIKclLso2XTACNC0zOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVep4QvnlI8vxtyqEFuMIA/BxslnIraxRs500cbd/44=;
 b=d7sa7oFNlxp/ufRcDCYkbmE6xTazd7bGxRT5WwxdKtbgQJcE4ni1PbzX92YRlG/a+OJrYEY129qTQPfxxX8rQXQDPoaXK9dI27IC4nNF/n3Hr/7/C5VKLPkUUFJVSR5e6RCj8AoWKh2VI/qetpxdNQMskSTiic0Wjz3wCcZz52XNlOL3v4C5gMusVsmReZHpX6hB+q5EoBI1nQ08Ev1XHKe9INOo5BLVz3lXn7anPjGyzKg0o0CNsQUwUw5eC5MOO7UsDZmDrQo6579+Kc5IG05ObZ5d3x+iZPVZ75ty4qfV1asOKteWVH7gX5Z3B5oQ+ehMHIj0xtc9qI7d3eTM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVep4QvnlI8vxtyqEFuMIA/BxslnIraxRs500cbd/44=;
 b=5TyzWEi3ktdE+leb5i1BDTb/9SMqdZMe0klVq538NgLIwVz6+EJAvKXdL3N764RhctWOv3Q7wap5Q3eub68CtkWF7JXXJuluYBvFTyqFfnaT7OOLAdwG/Kx76r1jsS8nyDlyUop97oqAqgEVKGcttQhc4ycF3rPyhoAj4Y61rFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 15:14:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 15:14:59 +0000
Message-ID: <5bbc2504-6dc0-6d2b-eedc-06b4aafc43ca@amd.com>
Date: Mon, 20 Jan 2025 15:14:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 04/27] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-5-alejandro.lucero-palau@amd.com>
 <678b06a26cddc_20fa29492@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b06a26cddc_20fa29492@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: c5945583-4650-41b6-d49c-08dd39653484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3VGZ2FsTHlTQm1McTlBaTdOVXBLRG1rUlhUTExFNFJMdTBudUV0YXBUbC9B?=
 =?utf-8?B?eWF6aVdPalFzN0xBWHVRUjcyUjFidkNGV2Fmc2xTQXhGdGsxT3hJU1pRZmZz?=
 =?utf-8?B?VzFZcXJxQ3FjRVZuQXpJL3pnTXFoUmtDaHpIMWJMYXpsL0wzUUl2QWlnTGRR?=
 =?utf-8?B?UVdtamYyeUdoZ2lldnR0ZmVaWlRaNXMyQTA1b0RUUEhkQ2ZaeUtVdWxlekJF?=
 =?utf-8?B?TUM1UGdIZVIyQlFRRTVXa2U5ZjAxK0lHaDZqSnY4UXRCR3RPU3F6dzRleVU1?=
 =?utf-8?B?R0dVaVB6eTJmSWVsZzhzYlhzdlBodzcwUEU5UllFd2JmSWJqMHFoK0FSRE1C?=
 =?utf-8?B?WGhveS9ZK3RYNFk4SUFxRzN5QUk5UExwaWZkVGkwbmV2bGk4SFU0aVo3Z0Vu?=
 =?utf-8?B?TnNMMHR5L2N5T2xUNU9FMHRVMnNtRFJEUkVvWnJZRnd5WDgxMnJKZXdtdU0y?=
 =?utf-8?B?T0sxbFRTQkxLWTRudGN2V0tPNGEvREIzTHN3ajBHRzF3WTNjVit1NWxKOW15?=
 =?utf-8?B?OGN1NGsrcmJva2o2UU1Ua2I0V2NjS3RuMERmMDUvV0txekFEVm9ycjVDSE93?=
 =?utf-8?B?TVE0OVlEd2JvcG93ZVg1Wnk4VVkyaWwvM1IyMjcrNDB5RGpqYXFTblk4d2FE?=
 =?utf-8?B?MnR2d3I3SytSVlBVTEhmM1g1RXlJSWp2Y2FZazZkRDhwcmEwOC9obkZCTnFM?=
 =?utf-8?B?M2tvek9BTGo1bzZWSUJJcXYrQ3BDNnJhS3NFY05IRXoxWEpWeThLcDRucEdE?=
 =?utf-8?B?TFpxa0VlZGk2b1ROTUlpaTlndXJVc1d2SDVoc0lRZHhGZkNRWXlpeHkyTnhW?=
 =?utf-8?B?ZHFzZ3ppZ2VZblVoUVBpUUhLb2xuVnZ0QXU1NTk2M0RsTVh2em1JWEJjUGts?=
 =?utf-8?B?cHNyN0RBU0FKYXlmS0hzUFhzdzR5RXlDOWREcU96eGJ2dldFUFNMMDI4dkV3?=
 =?utf-8?B?RndXQ3hmdXYwSVlqQWlNQm4zOW50L2trZEpjaUNEaEtoMkU2K3JqblVQVXZn?=
 =?utf-8?B?amdWRGxaKzVEKzgrU1g3amhPcEdmaTZkNEY4NnE4TnhMN2QwR2RpY2QxZEJh?=
 =?utf-8?B?SVYwNUJnZnVYYVptZWp5bk9RSWNLaVlMRk5CR1hzTkgySDhzWUM5bUNUa0hq?=
 =?utf-8?B?cmdUdkZOR2Fpb09JL01NU2V3bTBXRWkyOUNRaFp0Z2U5aGMvblBPMHh0VVln?=
 =?utf-8?B?ckVPYVJHaWd6OFI2UVNrRTJRQWpkOTlMT216K2dVcGV1SnJhMXJwejFnYXRH?=
 =?utf-8?B?TEdScHVwakw4ekUrU2hHTlU4bXc1VXY5YTNpM1JlTndEbHZWM0lRSWx4Y0VH?=
 =?utf-8?B?WkRzZWNEVXpHc1dIMjhjNHlyeXQ3Z2JqM3M5M3FySjBNU2hyU253QXNOVWV2?=
 =?utf-8?B?SEFTcE1tSnZQUUJERFRRcFU5dXd6dDlsVUVKZGJRQ2NDYURtY3BSUEkrbXpS?=
 =?utf-8?B?bTZZR3JzUVYzR2hhdHFKOFBpOFQ2dHA4WGFKU2dTR1JBUWZjMU01MjlhRUd0?=
 =?utf-8?B?c3hvY3ZuZGZuYndxK2h2WUJCeFdXSGZOY3BmV216dUMrTlpHUUdIMTVzcHhY?=
 =?utf-8?B?ZGZoTlE4Q09aQm1jVTJFNjE2eWJHaXNhNlBDeVZRVTVNeDZCa3ZEMWVqZ1Nh?=
 =?utf-8?B?dk9PWDhRWTd6SG9lREtIYTRpd252Vlpnc3pnMEtMMXFjZHphR3p1QmFlTlNn?=
 =?utf-8?B?QVZDY1lJZGdOOG9PcHpGVVp3djMxaGFRem14WVBjZ284WkRwb0pzSUFrSVZp?=
 =?utf-8?B?STdtcVBNOVQxc3NEWGFWRXcwM2dGUTFETkNaU0tadmFvTHBGRW5iclNOVlRp?=
 =?utf-8?B?NXIxejJBTGZ4cE85VUx6bHV3MVI5Y0QxSDZnNGpTNDRlSmpUTmV5YmI2WkV6?=
 =?utf-8?B?WHZjS2pBc01CMTY3VlpIeGdOWXFYdzc1b0N4Sm1nK05mckVxdndZQ0h0VmRU?=
 =?utf-8?Q?tqB44p8RQr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0trSlFUZVVhUVdiNXFzTTJ4K21KRGpYNFhLMEgvSmlNTjUyVXd2TWN5dUtl?=
 =?utf-8?B?dXR0aUxWcVRBQlVPVTlmY1RaL2JKZFE5UEg0NUgxclVpcjhqbEt4RHpDUXp3?=
 =?utf-8?B?WVBxaUJpZHdKZlNaV1ZMZzR1WDlDOUdBVUhMN3BFZmNlTEd1b1lvdW1JUHlI?=
 =?utf-8?B?dmlZekpFN1BOZXo5WUVWWWozZmVDS28vb0x5K3dkOWVITkFib2QrNWdpN1Fq?=
 =?utf-8?B?WmFHSTZnTmxEZTlZdTAxK2pyTnNoZHRNUk5mQjkvVnM5SlZUMWNUemtmV1hW?=
 =?utf-8?B?Q2RZRTdwN29Cc2lOUGtYVndreVNJbGVxVHgvSFJHVGFOb2FtVDdTYTl1bG1H?=
 =?utf-8?B?Rk9lU25LWjYvZWVmbHJEdWdHRHVJOU1Yb0pkZ1BCUEZuR3FMZW9QejBzeUVB?=
 =?utf-8?B?NDJ0Y1ZNdjNiOXNJZ2JSMmVuZHRNeklYOS9JTGFXU3NQekl1d1RQbVdEaGpK?=
 =?utf-8?B?N01KeDBBNC9Wd0lxSGFoWWIvZWNjbjZ3WkdnT2pLVk9ScDNMdlFBYkhLdVBx?=
 =?utf-8?B?OEprS3hiN2xidHVwVlRWNElObng2RW5vcXpaSkJPb2lVS2l1Yi9oZjUxZ29l?=
 =?utf-8?B?bHl0dndlT1htK2RmME5yWDFwcjk5SlJqOUUrUGtoeFRoWG93MlFrdWs1UDZ0?=
 =?utf-8?B?SnJHa3RyRzg3dzdLQU9jZ25tQlJpMHE3b2NJaTZ5L0VianY5MndmczJzUHJs?=
 =?utf-8?B?OS9tcC80azFEa1NvdDFGRk9Nak5IRHo4Z3QzNW5IU0pEbENzeVN3ZmhBZ2JH?=
 =?utf-8?B?R3dkdTNyMkRHbEp1YW16Qjl1Z20wVkNkSytNbXRKcURMalc2eUY1ei9xL01w?=
 =?utf-8?B?cWxWblRvYVNwK3h1OUkwRmJqWlQvL0owSTUrWnVTSjFzVy9oR2Fsb1ljcTkv?=
 =?utf-8?B?ejZESUJtU2t3eXBiNklwSkZNbWZrZThaaDFMTTU1UlhYOWNDSWlXTDN2Nkc4?=
 =?utf-8?B?ek1zQ0ZodGx6Ry9NbUJSajBXTjBhQUgzNWFsK25nVXlnK0owbjRFMWl1RlJm?=
 =?utf-8?B?czhJOG9FbVptZkZKeDJpRXlxQXNsR0NoOVZTc2M2N3drNkJLQVM4MnptVjA1?=
 =?utf-8?B?NE5SSmtBTXp3cVZSVUxlVlVXd3l6TWRoUzdXQjc5R0dlRU1sT2d4dVc1Q0Z5?=
 =?utf-8?B?elUxUjFyeWR4azVBODhRcHRmL05mYzFiMHRPbzl5aXlyMFFKaFNVajZFNWxk?=
 =?utf-8?B?T1JRU1BUbzZVZndJYnFCbkNYRUhQR3MwRi9wOEhSRWhiNXlld09JcjFPQUNU?=
 =?utf-8?B?NHN2bkgwQjBNdlpFTUw2ekRJcEF6Nmd0dTdDaitlMmlTcjVZb2RPazZ4dUZo?=
 =?utf-8?B?SjZidjdyZVJHVDBKamRwK25qSnlZS1AwM2Yrdy9Jek5wcVRqaHhJdk8wOXJx?=
 =?utf-8?B?UHI2aXU3bUNacm03Zk1uV1VRRXIrUHlibjM0MnhHVE85U1RxVEFHOGlsOXA2?=
 =?utf-8?B?UTkzWU11MkhDbUhKZGJOaVN0OUhtN2J5OFJIZkZnTHl2NHdNbzIvSmlvSE90?=
 =?utf-8?B?SUpWZ3NoQUZCM0NObmFpRjBwTitsdmpNZ0txK0tFeXZMaXJJVmhEbmJRSXNl?=
 =?utf-8?B?SUF1b2FOT0dsTFg2Ty84N0ltSnFGQ1dpUnh2S2tWbzlqUGVpRzlKaHlJWWpJ?=
 =?utf-8?B?WUFGMnNWbjlSeTZMNHBwd3NLTE0wWXJ3eXdpL2FOWlc1R0llZml4Z0JDdjA3?=
 =?utf-8?B?b2tiSmFOa2srWmk2Y1BIem1ieTdPQjhDN3J6d1F4VTI3Y0NBRktuRnRiVmxq?=
 =?utf-8?B?N0lnc3NheE15VWs0czh3dWVLbFdaR3A2RnVtYWtHc3ZsQkpLRTFuS084RmRt?=
 =?utf-8?B?YkRaYU5KSnBscmNKVStqbWpMSnZUb1dCc3Z3SEZtVkNZZkw1NVY3bUlPQWZG?=
 =?utf-8?B?dFFGSFNSWnBSTG81MDA3eG5QeHcwRzdDQVFJWHY5L3FMa3BiMnNRbSs5Zk1R?=
 =?utf-8?B?MXFJQ05waUFYK3d4VVF0RjdNMUx2WlNVQmZmeFNVVXZxWTlZWFYxSEUwYTQ3?=
 =?utf-8?B?bm5ITlhnZUxTRFExcFNxOWhHYVQ3aGowMGtWcTZCdmxPM2NIWjFaVFFmek04?=
 =?utf-8?B?bTFVNkVQdjRFU1dsUHJIeTFXYVlmdkZwTkZOSEhUVHY4Y094RSs4TEFjcnNC?=
 =?utf-8?Q?x9PVCDp93EplJcuIRhKeKOU/j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5945583-4650-41b6-d49c-08dd39653484
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:14:59.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eXumpU4MHsJAoL0ynjmBi5oB4gqVdaZTJfW7sT18eqpXHmg1gyZIbev9jW8L1UDS1BzYdo0W0Yf+6d4HaxsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048


On 1/18/25 01:40, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> During CXL device initialization supported capabilities by the device
>> are discovered. Type3 and Type2 devices have different mandatory
>> capabilities and a Type2 expects a specific set including optional
>> capabilities.
>>
>> Add a function for checking expected capabilities against those found
>> during initialization and allow those mandatory/expected capabilities to
>> be a subset of the capabilities found.
>>
>> Rely on this function for validating capabilities instead of when CXL
>> regs are probed.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>   drivers/cxl/core/pci.c  | 16 ++++++++++++++++
>>   drivers/cxl/core/regs.c |  9 ---------
>>   drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>>   include/cxl/cxl.h       |  3 +++
>>   4 files changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index ec57caf5b2d7..57318cdc368a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/pci-doe.h>
>>   #include <linux/aer.h>
>> +#include <cxl/cxl.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>>   #include <cxl.h>
>> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>   
>>   	return 0;
>>   }
>> +
>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
>> +			unsigned long *current_caps)
>> +{
>> +
>> +	if (current_caps)
>> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
>> +
>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%pb vs expected caps 0x%pb\n",
>> +		cxlds->capabilities, expected_caps);
>> +
>> +	/* Checking a minimum of mandatory/expected capabilities */
>> +	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, "CXL");
> cxl_setup_regs() is already exported from the core. Just make the caller
> of cxl_setup_regs() responsible for checking the valid bits per its
> constraints rather a new mechanism.


I prefer to keep the regs setup separated from the checks, and I think 
your suggestion involves a higher impact on the current code.

Note this is the API for accel drivers and by design what the accel 
driver can do with cxl structs is restricted. The patchset adds a new 
function in patch 6 for regs setup  by accel drivers.


