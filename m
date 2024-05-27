Return-Path: <netdev+bounces-98268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C28D0804
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B6C2A8EA5
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5544D155C81;
	Mon, 27 May 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWBCJM+N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE017E903;
	Mon, 27 May 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826286; cv=fail; b=uQNRfrASaMy5WXQ6O+CaBWU3HdXcRfYPutlf0dMXEHmECUoceGktKjWKKNMY7nQ5VqiNeBiUO5pjJ17r5MPs0VIZjlNE1YsFHK7auw4EV68VfI65mAPZBQflaPdazN8J2fCe/gngxoD4JakULgUxpeaRLgKRpEw+l0C+uSEC/Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826286; c=relaxed/simple;
	bh=W9TUt2HD8euHgCVqc7Lxiitx7gHMO07Our+XZNjZzyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U9tqRgqfxOwynHgzo9Dghh0vrdSz17tkhOSdFT7264N5rVzmLBLjJtdgq/xj4838T25dzCf89J7MwLz5qFLnT359c6fFLuveEV41w7qhzqRG1GS271Tb8ZpGqKxrdUTCI/JE3kl+TBG+ZtkJfX9uOO9k7gMwVWGPZAG7jb9uinA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWBCJM+N; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UipVS/evSqZ/dIiYSY03bUDiET+t6FNHCAW5ywVNlY6EDRpkyFTtl2T0WhMFlFqlvNuaQ7S5ZD7x20NVhLMXQVPPxF8IINWGkv2PEKUE7OWualQAaLuffa5JxyTfWzBLOdJJ0MeQFMG4+A4mBE8YhStvF/Av4et5YYsWsxMJriSUXVuSWPgwVZiNNi0plaPQYs4+zfKHn+ohrN3S5mIe9+trDOBssj+PeZHWg6N50HDzaBi1vijd66+39yJ/LZFWKm2qm/3F+5mLWHFMnacV2j0HBexbZopdfzKFLcEEhT0h706UWt7W5sRRvu29jl1f3kU7NYmBQCSq1RjcOl7dnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaArSi71KIrEdD9/Uxvm7uhmZOrxcmqDzbwpIPt2O6Y=;
 b=K/T3dBULiFqU0tFjHzzIRyXHJkO/KO1cDsSUIjhpO2iNk3WVtXcgHWxzUAnbcba5ZM/NpvSSbr+kYuGp26r7dq+5CQEtAjNCQbMEXthnICg64AqmjIdDu2NKYhoHw0+EhYtGV1XyplH0Sq0R+Iya4yW9KJSR2OHpy+lHFl/X2ipkbanm+LPQMvQgaE3KkWGoEeHhFscD9muuVDWb2uHle3nKb9Dm2M6zlLlLjKiBO7AyewuCdN6d6Mc2ZWp1yo6oabNOOwZF7I3+1RgvJc0a53f2fHYVHFhuXl1uQQ0CaLOPQZk+yluNrMyoPvcr7bXuBPjZpyTgQsDp64oDj62jLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaArSi71KIrEdD9/Uxvm7uhmZOrxcmqDzbwpIPt2O6Y=;
 b=kWBCJM+N+HD1q6/oauUNiiM5ExJLd7eXCvlt5IbCR8qMPMlOvwhKEotQILzaI1H2uLb+jBIMqlnrdQnRFMs/mqR/1n+Pz5MapB10LLTL9oBDtXppoZcsR5EbaMjqNqBFlAz3wsyCZe/H06Sf5GcucuO+1XnXAilNvcuKhi2X3tL8dWwizhRq45zzRtG2iJFrrmwsdKvFNRilqrzweCD7zN7Q98wq8hbVUT/8hg4uQgRv3KXmfln+YqaAe7mZZtA/tBaDTovxt3Vvmni3AZDbIc8NAC3gBVXsK8ZASDT7HIIJGPM5wWuyNt55hW3Z3vL+kUhgZHPb9w/BcSSOVjpZMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 16:11:17 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 16:11:17 +0000
Date: Mon, 27 May 2024 19:10:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <ZlSwbTwRF6KjPfJ5@shredder>
References: <20240424133023.4150624-5-danieller@nvidia.com>
 <20240429201130.5fad6d05@kernel.org>
 <DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20240430130302.235d612d@kernel.org>
 <ZjH1DCu0rJTL_RYz@shredder>
 <20240501073758.3da76601@kernel.org>
 <DM6PR12MB451687C3C54323473716621ED8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20240522064519.3e980390@kernel.org>
 <DM6PR12MB451677DBA41EA8A622D3D446D8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20240522072212.7a21c84b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522072212.7a21c84b@kernel.org>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d0d46b-1d31-4593-66fc-08dc7e67a3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUFSTU5NY2xSVVhEV3FraVdWVS8zZGZpaVZUTnpRbzgvOGlYQnppc20xZWVB?=
 =?utf-8?B?NVFwTmM1MlZrQXlnRGN5dmhWOTdBNDh3dldaSTY0R0VvbDdzQUh4eWZyZ1JH?=
 =?utf-8?B?UkJkQlpXbElBVWtKeFVMNllNaGErWkJwWklnOERxdTVGNURnMmJBa3FPczNv?=
 =?utf-8?B?WXdQOVo2a3VXNjZrTzNmeVplUjBMbWRZVzQzZGltZWcxbXRHYWtOQUU4QmlR?=
 =?utf-8?B?dERvYnkvNTl3bVBOMjR6czBiOVhHYkRubDI3VkRoRVhWbHVXQVMxSXJLNkt1?=
 =?utf-8?B?cXUyV01QQXFLU3FYcnFHL1c4bk1qL09aU1RrZEt4N3JFS21NKzYyUzhHVFVM?=
 =?utf-8?B?MTRIeEpqbHdMc1ZQTlFBSVZaQ3N0bzlINUZSZHBmQ2h1RVlQRThxQ2pYbHJO?=
 =?utf-8?B?eGlaSHMrMHdaMGkwRktyQzlxNUdSU1FKOXlHY2hCdVdJTFd6LzU0VzJpeVVh?=
 =?utf-8?B?NUNMR1AwbGpzZ0hrdVB2UWxzUTZTS0VUYzc0K1ZlQXVldXlsZTk3bGI3a0Vv?=
 =?utf-8?B?aEcxNWFxejJGV0tTaGxjVkt3UXFmNklUM3JJcjhobjNQaEgwMzhDZ0I2Z0RU?=
 =?utf-8?B?M2YzRHVoSWg3Z2tUbUZuVERYR1VLVlN4c29uTjRWU3FoYmRVY29DYXdkeUx2?=
 =?utf-8?B?d1hJY21NTE10MUVrVFpjSzAxb0xmWlpqUWc5emdYK3FKL2ZoTTZYT0grcGhu?=
 =?utf-8?B?OWVaMFc2UzRScjFENmEvNTViaEtleGNoazYyNXRRYnBpSlJSWWM5ajFGYzhq?=
 =?utf-8?B?dXNCcmdSYXBvazZYUFkvNEpidE5ZQUZXMzA1SDBoUWhZSG84NUZmaTJZV2My?=
 =?utf-8?B?cGtyczBGdDdmWWN4amkrSEFkSVhCV2g3U09hTWRFMk9QODBVWVBWQ1o3dDky?=
 =?utf-8?B?aWJZaUE3WXhRVnJpaDNNS3BHY2VQVlVwcGlWM1hWeUVaditvaCtNTno4YnF1?=
 =?utf-8?B?cGh3ZjlzUzJQMzlGZEpmMDdyVVc2UUpmTEhrc1ZMbHNDVzRBeTBtYVg3RkYr?=
 =?utf-8?B?d2s5UHFSRVJ1QXgyOG50Sko3OEYvRFZvRWtpTzFEMWNTNzlVMWdkY01YZ25a?=
 =?utf-8?B?R0oxN3c3VTQvcGo3YzFhaWxIVGpUNW9LZC9ka25OMmhscmoxYUZvSTM5SmZL?=
 =?utf-8?B?SlRuL2ozQU1vYUFYWWRGQ252b21vNlJLZTNIcW1SREtIRjA0bXFyY0FZK2ZB?=
 =?utf-8?B?cHhUQ05tcXZJcm5mN1ZWb3pSS2U3aXBQaFkzbjQ3akg2aDhMbStsY0EwcVZ5?=
 =?utf-8?B?bm0rbmFTdkR0ZFdVbGNOZWQ1TS9Pb3BDbHVFTW4rcTdJUlhwQks1VDRLTkU4?=
 =?utf-8?B?MFFMMlY5YzF0cm5KeXh5d0NPWndQZjhqNEVaZFBUci9temhNUWZGZ1RWNm42?=
 =?utf-8?B?anM1bkZGS1BzZmRqb0FNRUJnT1ZqSXVkMzB6bTV3bEViek8reXFYdjh5WWYr?=
 =?utf-8?B?MVRNL0VpMEVQVGRZMEdBUG53bklnSXc4ekRCRHMwSUtKaU5UTFpLc0J2bnd3?=
 =?utf-8?B?WWRFWDBXeHNmYWdpMTFQMlNTMm1jNG5JL1hNZlRQNW5kdG1uRC9xbjhiZGo3?=
 =?utf-8?B?Z1dJd2NvQjlRa0FYN2s0MTJHY2hvY1NMUWdSdjB4NjBNbU1CeE4zZmxLei81?=
 =?utf-8?B?QWd6anhMazRiaC8zcm9GZlVQM2JEcVZmUUZBRmNuWkJaYmpHVHdrS0ZrVzYv?=
 =?utf-8?B?Z0V6OHhLTG84Uzd1b3VtUjlZSWYvYVpwZG05MlRNYWI0WjM1MEE5dnNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHgzcXYrbU14a0pCbXpuRXArUWxlQXVDa0x4OFAveEl2Z1ZWNk1LZHJ5VW96?=
 =?utf-8?B?QnJVL0FtclBXaGxtTUtZRjdlYkc2UHBBZWdUcEhoVDBySEp2cHJaaUlmRmIz?=
 =?utf-8?B?aXdoVExGOEFvVGMvelBZMTBoTi9odDh5a24ya2pTVTFEaUdya1NndXBzSE1E?=
 =?utf-8?B?QmV0aXhsUldZNGJYMFlGRjJXcXZtc0ZwY3FXb3ZKNFBzODZhTHZhMzVKZzg0?=
 =?utf-8?B?Vm9tSHFZWFdVR1F0dDJZd3JXenB1VnZJemp5emhPRkgwSnVieTYwOFZSdnZq?=
 =?utf-8?B?UEdEUVRQb2FpZ1drZmNnNFVuWXBnV0c2UzNKVU9HaGFDNnpSNEd3Zm51NTU2?=
 =?utf-8?B?alBRMFdnZEdQYzhjaHFDVVJzVFp6eFIrc3hseThMTjVSZmZWTFFoeTBqMURB?=
 =?utf-8?B?akJPd3NCNUR1ajI2V21uanY4YWdsS2lUbmZzVFdzR0dSR2t6Z29kSHRMVnNU?=
 =?utf-8?B?dThRTVRDUGRTRkc5a3pNTGVVekNiVy92TVFDUGpBVTF4cXo1RFZoOC85dU1s?=
 =?utf-8?B?YXZ2SVlEWThlNGtnbFVPeGNIL0dMcGsvWXhFWDVyM1JHcktaclVYYVBvYWZG?=
 =?utf-8?B?ZWFTelhHcmRDWmFkR2gwR1VZeG5haG1sUEJNTkhkS1Z0L3J3ZU93QXNaMnhP?=
 =?utf-8?B?RnJicStJSGc1aGN5N3dHakcwZElodnEwa2hFTTdiV1liR1VRYjVvRWQ3UndX?=
 =?utf-8?B?RGpCY29EVWtZSE9kVHRtRWNzMHdGNUJWM1JiRC9uV20vTEF3eFp6U0VQNkZT?=
 =?utf-8?B?L0VkRGVHa3ExeEkvZ0c5NlZybG9vREpSUm1BelBoTkVpeG9WVmprUlFEUTRN?=
 =?utf-8?B?clZLZWZVUFJlazFpR3N6RzRXNHJsYnUrdzlvMlN2dWE3dW9iSEQ3STBYMFBv?=
 =?utf-8?B?Vk1aNXhuVEpLL1h0VVV4TE1OSVFmV2t0LzZNZllwMGhENVdWRlN5dDVTOXQ2?=
 =?utf-8?B?VjJkNGZ6RmNybWlZcE02d2FpVE1QNVlhQVF0MlVtUkNVMDlTVVRPNjg1Yk43?=
 =?utf-8?B?a0ZqSEh4NWFqN0tSTGtnamNsMzA2bU9oa1d4R25pd1JRTldETENmaG5MQml3?=
 =?utf-8?B?OEhmM1RFc05aQ2pxSzFKc2hYU0hZbWJLbE9LaGpKbC9Db2xZVDgrMmwwWlZz?=
 =?utf-8?B?bGRnVzNwQmF2bVVBN3d2djFweTEydzlLZGlGVmRuQmQzcTFwc3F1K1YyN0lp?=
 =?utf-8?B?c0NOcWM5L3NTMyt0Ymt4cnlHK3RtakM1OGxZZFFGajRjeGtkME4vUnpKRWE2?=
 =?utf-8?B?aE5DMWxFdmNwVVpQUFQzRjI1bUt1eTgxVi91U001c3JySUYwcGQvbzVwZkxo?=
 =?utf-8?B?Mnc3SE5JZXM4RVgwb29iNHVLeWlwWHRDWlVuVjJVeHZsZSthZTV5Z0NPNEZ3?=
 =?utf-8?B?enM0R0kyV3dKWmpBaW5KN1hTckJqSWJHcUdwV2laeGVuQ1N4Z082Ri9PaTEy?=
 =?utf-8?B?MVVuaFkxYnF2Q0swMXJQQTBmRXljdkQwM1E3OUVna09XYjhRaHNNY2tQRHV1?=
 =?utf-8?B?UzNaS1pNYXVxaUYwdFc4OWRBYmZzMUJKQWtRRTR5UXJ1eEF3c3RXSVo3WjFD?=
 =?utf-8?B?dGM4MEZBTWtzRm5QRTAycy9aWHNwMjR0VGdGZzViUnBxM1RWRmVGUW1XWUsw?=
 =?utf-8?B?UWtDZDJtMVNuSGZqNVRaekN6S1VoeWFYcjlpQUx0SWRoWEVaWUdhcEkxY1FD?=
 =?utf-8?B?Q1hvc05oa3RBUVpNYmlZTGJGSzlVdk1ZM3F6Ni95cWNsbXZMa0YydTlGYjcx?=
 =?utf-8?B?b3VzaURFU05NbWc1akhBOWN3K3dhVm90NERXQ0FSaWVIcU1wS3kvSm5VdDI2?=
 =?utf-8?B?T093Wk5NQUgyTnluQTVuM1lxdkhvOXFaM2J1b0UzSjVqeHhGcjNCTTFOWFB5?=
 =?utf-8?B?V0FwclU1QkFLczllUENVRkVsRWtiTWM0UW5rMTZkNGtUeGNqN0x5M0xXaEFH?=
 =?utf-8?B?YlE4OTFKN01OWFB1NTAxaklZS0lOREpBcW4xSEN2MUtMTUNuSTBDb0F6Wktm?=
 =?utf-8?B?OXdNUG1Wck9VRzl0UzhxcTFXUnVIdTJPOTdnZ2lUZmR1TnEvalBHWnBMM0tP?=
 =?utf-8?B?ZmlxRlcyUkVJZ1VuUFc3TW91VVI2OG1XMGNIU0pBRzEyMXVMRGUwbEtQL3VQ?=
 =?utf-8?Q?niwit3ZFZYMPrxWuyByutqVHb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d0d46b-1d31-4593-66fc-08dc7e67a3e9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 16:11:17.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6Vsq5cl+Kuz4W0q9vCXs1fb0STe3AEiBJcWTUiGhs0YWqI3ORc8jHzFG0zu0KC8VrB4+yYjBwV3DhTrzS8X9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

On Wed, May 22, 2024 at 07:22:12AM -0700, Jakub Kicinski wrote:
> On Wed, 22 May 2024 13:56:11 +0000 Danielle Ratson wrote:
> > > > 4. Add a new netlink notifier that when the relevant event takes place,  
> > > deletes the node from the list, wait until the end of the work item, with
> > > cancel_work_sync() and free allocations.
> > > 
> > > What's the "relevant event" in this case? Closing of the socket that user had
> > > issued the command on?  
> > 
> > The event should match the below:
> > event == NETLINK_URELEASE && notify->protocol == NETLINK_GENERIC
> > 
> > Then iterate over the list to look for work that matches the dev and portid.
> > The socket doesn’t close until the work is done in that case. 
> 
> Okay, good, yes. I think you can use one of the callbacks I mentioned
> below to achieve the same thing with less complexity than the notifier.

Danielle already has a POC with the notifier and it's not that
complicated. I wasn't aware of the netlink notifier, but we found it
when we tried to understand how other netlink families get notified
about a socket being closed.

Which advantages do you see in the sock_priv_destroy() approach? Are you
against the notifier approach?

> > > Easiest way to "notice" the socket got closed would probably be to add some
> > > info to genl_sk_priv_*(). ->sock_priv_destroy() will get called. But you can also
> > > get a close notification in the family  
> > > ->unbind callback.  

Isn't the unbind callback only for multicast (whereas we are using
unicast)?

> > > 
> > > I'm on the fence whether we should cancel the work. We could just mark the
> > > command as 'no socket present' and stop sending notifications.
> > > Not sure which is better..  
> > 
> > Is there a scenario that we hit this event and won't intend to cancel the work? 
> 
> I think it's up to us. I don't see any legit reason for user space to
> intentionally cancel the flashing. So the only option is that user space
> is either buggy or has crashed, and the socket got closed before
> flashing finished. Right?

We don't think that closing the socket / killing the process mid
flashing is a legitimate scenario. We looked into it in order to avoid
sending unicast notifications to a socket that did not ask for them but
gets them because it was bound to the port ID that was used by the old
socket.

I agree that we don't need to cancel the work and can simply have the
work item stop sending notifications. User space will get an error if it
tries to flash a module that is already being flashed in the background.
WDYT?

