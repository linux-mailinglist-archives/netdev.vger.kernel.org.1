Return-Path: <netdev+bounces-165212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A077A30FBA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A13160830
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03991252909;
	Tue, 11 Feb 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ge/ET/LI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8E1FBC9C;
	Tue, 11 Feb 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287619; cv=fail; b=sUdHGZa+g9qWGRLpzxNN18h0oDXO3PkIAxyMxyRGk1ZLO01q6ivVAC72CHGaNa9h2dHRxXOliYM4FQcDgRjCys1yPJMkJZRzo3iM3V1egCQ71D1W6Y6v5MaR7PcNMtmy/qiA8B5T/UZwbOOi9Oi11IVxxqFBU23ImKpP0t+HAZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287619; c=relaxed/simple;
	bh=lxyQHi+eYhfzqyTPTlDcRt5M4o87ZDhdBKCwTNIQUc0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTFSlR1zN1qZjbXy4hMJ+FQvWPVW+x5q+judC6DhcICiVZF+rIkR+85er9xCJhdkdqpleL1zsd+8Kgr6p70mCRKWMgklYlNDqVnOgZ0OXgibgRoAWNEuRoaQMsmdvC6pjd13rZG4roryEzdjuuXg1bfQOWiHJwyzdVgxA5DZlzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ge/ET/LI; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO+ukLNOk/DME/a1efPq7JDP4gXCvjABqQcm+QoaJmOkne/Ol2tCdEhmluEYg8KPGV2XP17zqrDLKIrx4VGcYhWkx7xBcLqnlUfqCEF2/YZbMfZ1IbFdhaFW3/iz5DzexJO57t5ECFi6+ncWdaA7pzStkiBNVh7/aKkJBJqHHEcNJsFYd0Crce/a91ayhMvNKXbS+oyEBuGgjMzYNS6kMALLHDjINMlT2D1OYWpN3eSKu/WRIxlSxugOEqpO23G2rGiQs/mDbSCV3ZNGyt3Orb3JZZMkF09HHMDOwaXvH20O+r6IyEP7JwmTSktH7O8oCQcAfP13Cx7M3WCJLO0wWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf4OQseCw5En4DkwgoUrZChj4DI2bUqG/oZ7Ui2PWT8=;
 b=xDJzC1YhY3pkoZl1+SMBDN71BxgSMYOfo1JKXzUH50GdTqpAq3CkKi2NfcR1UdJ/+yXPyFPHbyGI/s64gCeTF9ETnB3WcUtz2npgNDkxquUeHDTGoJdWf86myziS+WjrypTykZA1e85MHqU/pUoi7mCNkr+mCrPAPwgR0ds7qk7uhxs0BMFto3ZbgFiQDRHrrjeUgHpf0tz9I9f7UYi+VvqsZbriOk36j6mgc8P7Zt0wi440n5sIQkye1FdGGXbfYgpP5nqwpH+IMg53Ig0x0Vuf3PcJpiSPTfZYNev1gZ5blaUgvuIaYqwHlQWpo39mP04W/6uu8BlBy8gDLqy/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf4OQseCw5En4DkwgoUrZChj4DI2bUqG/oZ7Ui2PWT8=;
 b=ge/ET/LIG8ecBuuQlI2BXbeenYhMrzbzMvv+KSubLhuWTJVyRN4+90a3+Bix0OHvrBflo8o2SDZPEdRFVjoBr9NcZdfdXUxI0r+knflP+2qgzcEilslMRAsRwuCpLy4d3kbKZYhEertbFQcOVlUKFRuLiXQXa6nJ48khkE/bsFG8BCfqyvwBz4uHG/qkyqZAf45xXug/5pJIvozJJjdlJcJ7BEWWbqI/3rdPmRIAoH6fJ8Dn+DATJDiZQquurW+RgWZWFmQGu91nmk/JEfAJiZrjVbrpuTcPbgZoy9rhBXQusTU8ce/ght5SDk4PKJthhKx3qU9bAzoipwhHpGhhcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 15:26:54 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Tue, 11 Feb 2025
 15:26:53 +0000
Message-ID: <68e2a8cc-2371-433b-86a3-ac9dea48fb43@nvidia.com>
Date: Tue, 11 Feb 2025 17:26:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] Symmetric OR-XOR RSS hash
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 linux-doc@vger.kernel.org
References: <20250205135341.542720-1-gal@nvidia.com>
 <20250206173225.294954e2@kernel.org>
 <191d5c1c-7a86-4309-9e74-0bc275c01e45@nvidia.com>
 <20250210162725.4bd38438@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250210162725.4bd38438@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 94752eb2-f349-4c9b-c838-08dd4ab08346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENOWHkxQ0xkVFBxVlUyZ1UvQXhpSFBoaHB4RHc2TWRQdXMwNVBtakNXNzdx?=
 =?utf-8?B?VGFhVVY2MU1xRTNPcHZBN2lzRDkvUzV2QndOUHZraVBjWUFzaXpWbnJ4Y29N?=
 =?utf-8?B?b1VNTkRYWit5b1ZJUUZHd3Q5eEozSW14b3BVaGIwdUZXd3E1U3VtZ3paUGIw?=
 =?utf-8?B?QUl1b3p0UUtTRTl4VlRYRWlGTk52VXF6MDNrVDA1YnZicTJuYUpkRFJkQTJN?=
 =?utf-8?B?Q1pYUzlnUzFIWE1OS1lLTUxGUWMxRnNhVUs4cTdUaEhOcjdlOTNwQlRnOGFC?=
 =?utf-8?B?NkU5N0hvVW5jYS9Wa3k0M2lRMjVaWkFFUWQ1djBvUzFXWXBRZVQ4dkovU1lv?=
 =?utf-8?B?NXNRVlpxTFZQOGNZTWhIOHJHeTVZdnpsQXJJNTRSYk5GTU4wL3BKSXhKUlJx?=
 =?utf-8?B?QTFuQmpuTnpPTjdKa29UbnBITWdFUEZpTllGYlFRTGxSeUhVaDduNHBHczBW?=
 =?utf-8?B?bEJ4YlNHaytRaVEyTm8zOG1OUUR3MXRpMmovVHhsQ2FGZ2NlbU5EMW5jMkNJ?=
 =?utf-8?B?S014VUh1Um5MNG9GTnlPZEwxUWRrUVhGL2ZESzZqcmw3SDRyaWpwa2tKYVVq?=
 =?utf-8?B?WTM0R0ZpNVZEQy9ldmd5ck42OGNKM2RKY1B5V3huZ2luUm5tTTJnUjhoNGRh?=
 =?utf-8?B?ZnNKQklKcVJEUkJTZHJlQnpheW9oRElERy9xYlBYUHhNSEdGbHZhbGd1ZlBH?=
 =?utf-8?B?alR5M1k1N0dQcVM2WklPUUxocktGOXhMWU9xVkQ5d1cvR291L3pMeHlzTHd2?=
 =?utf-8?B?bXNoTEtaRDZaNnQwSWxyYTRTM2F2all3TU90NmJuZll4NDk0YktUUHNoNzBT?=
 =?utf-8?B?WWg5c1NuQVQvTlZhQms2VVM0dWl6R2l0Y0VLRWpUU1FmN1c4S1FueHNpejdo?=
 =?utf-8?B?aUlaOHRUandZdEVIa3FJKzZVOWpGelNJVHVvaUtoOHNnYzkxVERNVTM3eGJU?=
 =?utf-8?B?UG8xQ2V5SnZNaDJvcGxLdFhKRjFiY2tTVlFwbXVzNmthSlYrTGtsNFpTdmc1?=
 =?utf-8?B?MEdRdXBuNUFHeVR2YmlMd1lJQkxjYTFKbmNCMkVad28wRVExMUJ3R1cwZ0to?=
 =?utf-8?B?R2IyWHA0NjVONzY2eXBTRWtaQ2dxRWNRWGM3dnRCY2txUnRnNG01OWVaM2FB?=
 =?utf-8?B?Sml1THdud2JrU1VsekpidkZQNTFMYkpKNkt2SGt2dkNKN1NpNVhOVG5UdUlO?=
 =?utf-8?B?cXFXbVpCejRYT25TZGt3UkhUS1NYUFpHNkpRRmdBck4yUTFOTWk2QmRDakpI?=
 =?utf-8?B?WnlCL0l1VURqT3lxbGIzOHlIbkozaTAzZWtPT1k1aCtqbVYwcDdSTmExY2R2?=
 =?utf-8?B?V2NWZURjVmg1NkdjT1BUNmFsSlJmNlJ3djBVZHlvZ2xRZ1dTSDMzdDlhM0dv?=
 =?utf-8?B?bmxyNHJrbHJuUE1kSk14UFZjRHZvY1BzK0o2bEhPNmx5bWNaU2pzc3ozaXJr?=
 =?utf-8?B?SVBPbHF3VmtTb0dSSXd6NDVWVXAvZTF2ZXFQcnNUQmJFaGlKWEliZzZnZnVw?=
 =?utf-8?B?MzhvSjdVdWJSbEVPbXhEaDk0T3QyV2FzMnpqUHozaXIxZlRsbG0zWjVmNEYv?=
 =?utf-8?B?SlZKRXpqVk4yOE84WWlBV3gxeVJBSG5HQ09KTnlRRDBCemNqcWxBaWp3ZHZN?=
 =?utf-8?B?L3F6Yng1VXVtOTM0Q3JENmplc0VpcDRoaEVJRDdoR0dBam0vYlRlanRzUngr?=
 =?utf-8?B?TGd3eTNnQThCWVZpdExnN25aeVhLRGRsZ2JYbGZUUkcrenErTFgvNVR1ZDcy?=
 =?utf-8?B?NkRBbEZZaWtZWmkvVXBTcmc5NHB3eXpEd3A5R3BGOE04ZGFSU0V0cStWMnVB?=
 =?utf-8?B?T3BKUFU2c2tidXczcERsVWhTdmtNQVNYa1h0T0wvWlp4RGZlNURicDI4UER0?=
 =?utf-8?Q?5zB9ucJJ8R4OR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCtubC9VdEJsb2tHNmVmR0FNblpBdHZIaDkyYytuRm5FQ3hxbjRxYTRUcXVL?=
 =?utf-8?B?L3hXMmpHRmZyN1NydDNVNzlCM00wWXdCNDAzUEU1MGd3bTI0K3dod1hGalVo?=
 =?utf-8?B?SXhQTUhtZ3Fjb0ozU3J0V21qMUdYRGprS3ViQ0djR0psb0lJY3FHc1hYb1pi?=
 =?utf-8?B?ZW4zbG5oa21BMm5VNmtBcXJoOUViS0liYW9CTHR5OVpQV25DRkVqV2ZwOWRF?=
 =?utf-8?B?cnhPbEZKd3RjZ1RqY0p0MTdIZjR0d3I3dnB3Q0lmR0s5bjY3bkk0V29hMk9G?=
 =?utf-8?B?UmhmN0FkdW55bXdiQjNTcWdnSnVRWGZpeWV4RXBQMldZUDRkNHVGTGVodG1Y?=
 =?utf-8?B?bDIrQnphUGVPb0RWaXFTQjNyeDk3Wmc5MUlITmtPN3B3bGNMUkRDVUxYdi9H?=
 =?utf-8?B?VU8xcDh6RFBSRkhkZlZLK3pFVnI0T1dkU2gwcGdVaHNRUUNYemI2d01FMjNr?=
 =?utf-8?B?M3llc201U1Zick1XeGVURDJUalF3M0NFTTVKK2J4TlAyZ2dNMm1aeEI3Q0xO?=
 =?utf-8?B?d2lDUmNxb01GZzcxU05KTnIya0Z0KzFlNTdoa0lJdUdxRm5Pa2JxR0RBeXpK?=
 =?utf-8?B?aW4rNVFJbkM3Rnh5WnZiNTNpK2liWWNjdytpeDVlU1BLMzBYbUlKMUJ0V05X?=
 =?utf-8?B?elVHeFQrcXplYjQrbjZYMEtnNTk1U29ZeXpEWVg4NHhOVEF6VTA2MFF1Z1Z5?=
 =?utf-8?B?azkrd0ZvbHNEcjVoSmVINVkyc1dFNkd6ZDJzWnA3bHJtWFZnSlllRE9ETVZC?=
 =?utf-8?B?QXpKRW1lcFQ2b1hoNFlhTTd6d2toS3V1WldQeUI1QmowWjhIaHpXVUNPQ1I4?=
 =?utf-8?B?MzFTaW9VVHRyL3ZxaUJFa1RDYVZWcW9GNnRiSncwSlJ2YUhZdFRkbWF1QUlH?=
 =?utf-8?B?NVJVOWo4YnNUUWpwOUF5djYwdXRPMW92TUVzRGk4MGU4TWRQSXh5YzJORDJO?=
 =?utf-8?B?SGhMa3kxU004ZTB3L3hvS0ZvdnlKL3hpTzhIRzloSmc4QXVld0pZTzFMK0pt?=
 =?utf-8?B?T0FQR0FyZXByUmZ2SXVHVnFrQXZlYm5Ia3ByQjVxdFhSbENsUXQ3TzFvQjJv?=
 =?utf-8?B?NjBRRE5oaW9DYk9mWVdCbEY1RzRzYllsUEhDcHRuTnArdUtHdGFMb2JOZE5F?=
 =?utf-8?B?S0pyMFlhQXVCQWVTRHVBdThVWTVySXdaT0Q3cmFEUGlTbXNLektnZjlTQldy?=
 =?utf-8?B?Y3BMRDhmRG5NSm9FNktwcGUzTTBONjRtbys2OG5zNmc5eUJ1bkxweEVFc1JB?=
 =?utf-8?B?MWVkZFJPYUVnN3RVZmo2dWozd29qUitUQWFQdnN3YUxQZVUyWmlhT0ZFYkZz?=
 =?utf-8?B?SUt6aG1RUjYzNjhvNmNMK2xOdFdBNUg5dkxPeWs2ZE51eFhFYzJ3TVVpMzN0?=
 =?utf-8?B?UlVoNnFXbGRmZk9DTUkwcWtweUtHY0xkS00vdlYwYjBxT0VydzdDU2FBWXky?=
 =?utf-8?B?eDhvT1p5TnIwaDJPM3lHaVZ3UmtBMGVVeUs0SFk0bm5BTzFqV2NLV25mOTRR?=
 =?utf-8?B?Yk83RjlYay9EamhEZFdOWEhxNHRaWUY5MzJlWW43VjE2b1dOcE9JSk9PMVI1?=
 =?utf-8?B?eG5EWmZhL1NGNUtwQnV4VlhobTVMMDVRVTlqbkhIemp4bFBxY3VxZUpMUno2?=
 =?utf-8?B?bDlXcStPNEdFdTdSTDNmVVMyaFp6dU9hZWJTaXRybkQyUU10b1J2bUE0M3BC?=
 =?utf-8?B?Y2l5K0o5RWJBcVNYZlNRdlc0Y0VmUnFWQ0Z1VHZYYmtmQVArV1M0WWJ0YlM2?=
 =?utf-8?B?eFZpejJNWHhueXE5bjMwakwrRWRocEM1TzdqZVg1M3BhVFR5b3lGVDVLY2ZX?=
 =?utf-8?B?aUI4cG5ZZk4rUFVyU1g5eEJBN2pBMUVCb00zRVExamRFb240cno3TnJuaHZw?=
 =?utf-8?B?eTNvWmh6TTBkdUc2cnRmbWxodXZLd3pocGE5T2NiVFk4dmJwN2ZOdUpWT2pu?=
 =?utf-8?B?Z3E5WXJpWUhBc2xmQ24vZUlRb0dsNWpjTXVBbGNkZm16SEcwM0lyS1MyRG9z?=
 =?utf-8?B?STdFNVo2VFNpYXFpL0tRQ0lxZWRweVROeFRiRFA0MXBPUFdFd0xjc1hXanRo?=
 =?utf-8?B?alJWTXFYc205TFZvbktwNjZTKy9kWldjQjJvS2VsNGxmQmJjS2VhODluT2xI?=
 =?utf-8?Q?uqIqISR9/3D3NdfnTbAlZVqFH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94752eb2-f349-4c9b-c838-08dd4ab08346
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:26:53.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RNby7DoKykhyQq3zt8YvL5FRAxZIjDv7Si+/GAKJpcLloYOLC73nCcftgWWWePy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

On 11/02/2025 2:27, Jakub Kicinski wrote:
> On Sun, 9 Feb 2025 09:59:22 +0200 Gal Pressman wrote:
>> I don't understand the rationale, the new input_xfrm field didn't
>> deserve a selftest, why does a new value to the field does?
> 
> Ahmed and Sudheer added ETHTOOL_MSG_RSS_GET as part of their work.
> Everyone pays off a little bit of technical debt to get their
> feature in.

I agree with the idea that extensions to ethtool uapi should be
accompanied by conversion to netlink.

I don't see a connection to testing. If a maintainer has certain
expectations about which changes require tests, it should be documented
and enforced so it's not up to the maintainer's mood. FWIW, I don't
believe kernel contributions should be blocked by lack of a test.

> 
> I don't appreciate your reaction. Please stop acting as if nVidia was 
> a victim of some grand conspiracy within netdev.

I don't know what you're talking about, you've mistaken me for someone
else..

> 
>> Testing this would require new userspace ethtool (which has not been
>> submitted yet), I don't think it's wise to implement a test before the
>> user interface/output is merged.
> 
> No it doesn't. You can call netlink directly from Python or C.
> 
>> I assume you want an additional case in rss_ctx.py?
> 
> No, separate test.

Will address in v3.

