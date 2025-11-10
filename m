Return-Path: <netdev+bounces-237182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F159AC46B29
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38B21886781
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1E30F54C;
	Mon, 10 Nov 2025 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="btHWFXBs"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D22FC866;
	Mon, 10 Nov 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778952; cv=fail; b=ZLxLEnZwpHV3it1mY/amWoqDVnKSzNzVMm8XEVj1/LNWJHmLmPaaKci+o5PhnT3vjKMR+jHO/JczIp/UmUOnPn8GLa7y+Ul5p2qfsE2COL3i2zK3kq0DqhnJse92G1EggAynsAJgFMLyHxgm7nh0qrsLAWk4UleVafdtQI7Q3/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778952; c=relaxed/simple;
	bh=hQ3WAxKc2o/S+OXFNvkYWdD7LgtaCk99UCwxEXqRgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uj3kO8SbaIr+xWQRg0j40Mcoc5iA0Raj1PS+hJwEpiwFlGm8e3EofDAwXYb54++WY+thO03TWrsKUji4Juaj613O/QvrFQ7Fb5XVjP3XD/1YraaGNOTzQr2zi+tSK1Tjm0tJy7HQPhrNu1kX4BDHQnZL6nJGsfXqRpCTIPNRhiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=btHWFXBs; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBYWSkE33pKGoua6Nicx66wWTf6hq8iF8eU9PvE3vyc/lr8Ndcl8mDeE0waNU9kb5wHYjroGKm3IQYCO02dwFQ5sIsJ+kLPR0qz9Of2NVlpFWGEQOm/tuUcR0pVHH6C8GlQ8ukAiTzrdWaXujKCeHYsg1EoOpn6f5aIONfP2DO3r2ocbhOJr3qAllRqSCL6RuribzvlNp0zaD/LN4xVCrzMKLwX6xvX2dnG92zRiBW/9FFiwTElG8FiNnNNf6ftGNfmhx4qP5kEZ/NreDn3En9H18MPLRXyI3upGAUh0r7YMtHY3yy++LlFm4x5sdQ8oA4xvV1CpiLTBR8a4/2Gh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iil5a5Rq39sRNzkaDxpLtkeAS59akGYo/7WmN8dwrLg=;
 b=pzCnfw0PzO17oyz+WQnKrvtICGMSFQsZPjjEfgAwBpfDkc8JtcQuky2QvYpiIOriRrT4zjLRtuepgE3aEl0t4JHTI8PfUMWoTdEaJdP45i9/48NPZz0BRxfe5eze8qWMZlWfcmscvlhED29xtnl3HTLmkm5KcsydMCnYVLBJlEzgooX1NyPXDo1GB8/kEhZOLaX3rEm8uCdtr6X27DYF2E4Lwz1fi55ycDBgHsromya9c+gwjKtRAkL9xpkL0M983tmyjEJ5Lg7KnVEobpa9uNvh42SdVEJtncdMXnIorSlRdM7KAA2Nidrjt3aqgqPfZbv7gHX2L+jujjIPwcaw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iil5a5Rq39sRNzkaDxpLtkeAS59akGYo/7WmN8dwrLg=;
 b=btHWFXBsaHk41Ua+19Ih/hxh+ARN87SEawWFpMWpGGmrXNQMj3yPbpdVlnJrrU62zBqRpRxaJlv049cinnHYaJHD+raiytcDmUpoW8Lx6PQEhLSJn+JWihT45LzjpFWNS5poNjCIS/HV+g2Brt4xrAWdVal0CjcmSr6l4K8XvJo+F6dhGbMTovpaSgOPluGEHfbmbaZylSyztofNQQ6TuXhSTFicbIzOjrwf7j/AgTNiCpRIuiBJksWWqa51hxSqvktaBPH+k5pI2LM9YP3HKBYqmgB68pU2aJcHshJVeCMjcjBKDjYV+7b0tSKHVZ5xjAiyXkTDv1UNel2SZWzSEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 10 Nov
 2025 12:49:08 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 12:49:07 +0000
Date: Mon, 10 Nov 2025 12:48:58 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, Vedant Mathur <vedantmathur@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
Message-ID: <fdumvcrk5bcngulfbjxidtezrdifi6kzouea3ygr5rq5hrzdfv@mum2kdsiqkmz>
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com>
 <20251105171142.13095017@kernel.org>
 <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
 <20251105182210.7630c19e@kernel.org>
 <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
 <qhi7uuq52irirmviv3xex6h5tc4w4x6kcjwhqh735un3kpcx5x@2phgy3mnmg4p>
 <20251106171833.72fe18a9@kernel.org>
 <k3h635mirxo3wichhpxosw4hxvfu67khqs2jyna3muhhj5pmvm@4t2gypnckuri>
 <ca3899b0-f9b7-4b38-a6fd-a964a1746873@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca3899b0-f9b7-4b38-a6fd-a964a1746873@gmail.com>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4333d629-d740-490d-e0c0-08de20578974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjFHMEROUWt4a2w4dUlvWUd0dytQZlllSzB0QmZzUEhLL0hMRzQvSThSeVFl?=
 =?utf-8?B?WVdUSzlobWtvTVN5eDF5Z3ZnRldYeW8vci8wSnQ3QXpiVDR6b3hQd1hrTWV2?=
 =?utf-8?B?UEk3TVE3MzVmdFY2SmF3UnVpRGZKTjFxZ3crZ0NsSmxjN0VkV0VNTjZ1TGZS?=
 =?utf-8?B?VHIxTFZSTElOaDJiSnJhNVVPU25aRkpteFBQZzBvTXpXUEE2NVZNRE83eDhI?=
 =?utf-8?B?ZlVnbzJ1MEVYeHBta09NckY0WEh3WUNLZGRDLzRGRXRtZjV4R2s0YTMxMzEv?=
 =?utf-8?B?WnVyM3FEbkJFdlRGNnVmKzUrQzA4a2ExTmxMZGlBTlQ1K0U1dzJGQTVsSFh3?=
 =?utf-8?B?Q2JkVkxTMDcrRXdMRTdsU2E3cVNoTGxjRmpBMUxQUnAvUnlWSklHSzRHbFAz?=
 =?utf-8?B?WGpjOGcxdlE1M05aa0xhbnFKSitEZFI5RFRUdTU5MWxvQXBFUDBNMWk3Zjla?=
 =?utf-8?B?MUxLcGF6NFE2ZFd4UWNseGUyVmNXcXdKaFRON0tCSVV4NHZNSjA4eEFjb0dN?=
 =?utf-8?B?RG9BdXVqV2gxRTZQdkVoTlI4dndHRURreHJsYzl1d1hLa05SNGt0TFdPN2ZD?=
 =?utf-8?B?a2xVM0ZjZmwyK2V1ZklQbzY5aWZQbUtsanpDMU5hck5hRFFDZGcxRTdENWdo?=
 =?utf-8?B?WHhvSmdqdFJiNEZOWHNLUE9ZVGl2SHRseHMvbHA0L3VDSFdZNGlTUmdZVFZk?=
 =?utf-8?B?bG4zaXE0SXJiMU0rWVZIczJBSkFJaTcvVnNXT2lIMnJ5ZHRkTDhjeGYvUStT?=
 =?utf-8?B?RkhOdTE0Z3RuRUJHNlpBSGtRSFR6ZmFzd0xSYjNsM0VSM3g4UU9lb2pWK1pt?=
 =?utf-8?B?NHdjUVIxODhJU2VnWkhZSDZhbXBWbkh4RlJERVV0VkQyWCtnb0NZaDJ6K0g1?=
 =?utf-8?B?U2FNRHhCRkgvUTltSWZxakJuRFAreFhhV1NjeXNVOG1rRnp5TDRmV0JIUGFl?=
 =?utf-8?B?N09acFNvWFlEd1pPdUo0WkQ5Zm9udVhPUzk0V2YvSjlaTHFaaEtCZCsvNWdq?=
 =?utf-8?B?Ylc5SmhrVHhvNTFYM24yQW9Va2RVMTI1OUVDSkdBTEo4ZnNvQ2N5VHYwWGVm?=
 =?utf-8?B?REcreHhCbmFiQ0I3anNTeE1zZk13Y1Jmd1dpNy9ZL3ZJMWFjbXJEamhtODZ6?=
 =?utf-8?B?RFNwSklid1R2aEFRaTJoTGk4S1NpdC9VZmRQeEJPK2pVMERhNldYN1QvbFdI?=
 =?utf-8?B?QmM0bkJ2Z1RYaGptMWVFdy9hY3FQWGxZdE5TSmg2UFIxajVDQklmcDMyTnAy?=
 =?utf-8?B?a2xreStaSXBVL3RvT0FzNVhnaUlpMzBNU0E3cWJ0bTN0K01tSld6US9LdmtK?=
 =?utf-8?B?N283R3pSaUFQZWxLem14aE8xQkJDNjZ1SE1rWG9hNWtGMnVLMHhXbUliY0VQ?=
 =?utf-8?B?dllMSkFuckwrcmV4WUE1NHlzM0JhQnJDakI0Sk44WGhyL1JZa2hHQWsrbTQx?=
 =?utf-8?B?dlc2RTdoTmU1N3J6QkJ0L0d4UWloMlJMdDVzMk9NZUpHWkNEZERnUityb3Iz?=
 =?utf-8?B?SnovYlVyS3U0VWFZTmRhS0FhL2Q2MnBRMTFQbXJ3QXN1QTRNU3YyV094NGxy?=
 =?utf-8?B?ZkczeGxnc2JuaGlYaVNhR2ZNSzZRV09MNTBpWGZCb0NvNFRkN2VYSXVKVWtX?=
 =?utf-8?B?dWtkNWNvSWRsQTVYOGlVZk0wZHlneUtmdUFlY1c4UUxYeHFzSUw5UDl1ZU1I?=
 =?utf-8?B?QlRvaDcyRTZxaDVoV1F2NFFEeUZGMzVDQ1psQ2poOXc1bzFuaHZDbHlwakw4?=
 =?utf-8?B?eGxLNVU0OWZpNzNoVXhtTno1TENiS0JLQlJmVTkrOVMvK1JWRXlhL1VHdmR2?=
 =?utf-8?B?bXB1Qk15aysrY3pMNnBsZCtycHBpK0VQbTlpTHRYYTJoWVhuZHVtTWhta2Q0?=
 =?utf-8?B?SVFrMXJOY2M1UWFBb1VvdTN2VmVCREd0cVZORThnc1I1VlJPR1lFZHRsSmJ1?=
 =?utf-8?B?RTRPS0tTNkpVLzZwYnpHSUl3Y0dVU0ZhNmRUcDVlNTYvUGxJNWdhLzRaM2lZ?=
 =?utf-8?B?ZzIxb2dTUi9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFDMzNQN2JzbEYrUm94TCtya04rWENJVDQySjZIem1rUFBkV3hIK0NIblRQ?=
 =?utf-8?B?TXViVjBtcGN1VG9MdGhtbVhMT1JZV0xVRS9ZU0s3UkFQRGdrMmxoVDBra0VQ?=
 =?utf-8?B?azV0VlFrOTlSVy80VGF1bWlpYXp4cW5aVXVvQVo1bHhMenpkT1d3Z2ZGanBv?=
 =?utf-8?B?QTRPU2xOWVdCTHFraVhYd1M0N0cvRDBpcjdMblZzS0xIUFFJa3diZmtTaHNT?=
 =?utf-8?B?ckc4Tm5hcVQrdkNQeVVBV29XbVFrMUozYjRDc2Q0U0VtS2crdytsK3lUa2FO?=
 =?utf-8?B?UlpiN2luSnQ3OEdaOHZVL1dGRVJZRUx5MGlFeTJFY1lIblp3OFdPblNxT0xr?=
 =?utf-8?B?ejgrOFVnYUVuQXI5WUJQRkVzbDRta2l6RFN5ZGxXd25zanZDbTJlY3NUMGNv?=
 =?utf-8?B?ZVpmNlNYUUxFUy9NcXVxZG5WaFlSU0lHYzhncEhEMVdrQm5OM2dtMzlLWlli?=
 =?utf-8?B?Tmp0b3RZT3Q3Tk1wSHRjVkdBbHZySEJNbDR0ZE1VSGIzSUYzRnFWY0dGYUFL?=
 =?utf-8?B?dUdLZHFrNWVFSzRnS1Vaam9rbUJSOGdFZkJDNi9ZbmhpWjFOWHhFb0ZDOHJS?=
 =?utf-8?B?Z0xzM042OXhybXNJMmdpc1NuNWJBOVZIdC91ZUMvS0pPTW9oVmpoUzJ2RWpF?=
 =?utf-8?B?eDMxMEpBQ00rQzJVV1VmMko1TXlKT05ZTWZRK3JMcWRVRXV3Z0oyZERKeDlJ?=
 =?utf-8?B?Y295RVlnbExYakZyMDhqaWlIQzMzdlVkSmd5ZnRxWmQzbEFIKzNBaVlsTzJE?=
 =?utf-8?B?R3pNZ0h4RkYxcDJlVElITGx2RzZhcXI1dVk4NTNVVGxNRGtHQXVBUlI2bVVE?=
 =?utf-8?B?ZTB6aERGWTdzUW9DZ2U2REhyb2RPQU0yb01sNlZ0aXZpU3QzTURsa1RpTDg0?=
 =?utf-8?B?T2Fqc2FZUHVsVjA3TEZPRVpyNlRscVY0ejFKR2I2aU5YZFhSYjYwc05OKzIr?=
 =?utf-8?B?TmJzb3hJMHZ0eXdSc2pydEZMUDBNaU9vODZLWE5hTzhvWXJSRUdULzlIVEpx?=
 =?utf-8?B?ZVBkNGVGTGxIREcxR2dOemNPRVYvME5IVVhIR1JyWDBXQk53R1V5VVpQWDVD?=
 =?utf-8?B?MU5xOHNBeG53blI4VGRsa2VMMlJJWjNEK0h2ZnVIdzlvR0gyT09Lai95N1hM?=
 =?utf-8?B?d0lRclovYnZpbTk2bGdURTlLZFJiUXB0eDNmUTJ0Q1FKK09VTlEyNzZod1JZ?=
 =?utf-8?B?ZTM4aTdrNWJvckJDQzZKZkQ1a2dXVGxXUU05TVpyOE4xWE15a2hadzF1bEJi?=
 =?utf-8?B?UnBRKzIydmhIaDd4VXpkSHBFYk1HTnAvZ0tlTk4zQldRMXNiMFVNVmFSdWFj?=
 =?utf-8?B?ZDJmMVNTczkzZjkwNzJNdUlzYlljNG8wZ3p4T2RjUSs5YW94QzYvTjVrZVh5?=
 =?utf-8?B?dnl6V1NEM0lMWFdOWVU2YUNZTjZONVJ3a2ovZG1QbUNVSGpNZW1GRkxCVjEw?=
 =?utf-8?B?bG1uVWdjOS9tL3BBVFR2S2V1RFI2M0hHMHZSYjFRQXErc0wvTGhXbW5pVGNw?=
 =?utf-8?B?b3RCdmZCTWpCQyt4MUFHd1hEa2pNcU9YV0I3US9XYU10Y3JNdk1aQ0RpSlJs?=
 =?utf-8?B?MUEzSlN3WXAzNTRWUzBlZmJYeFQrMCtLcldZaTQxNE1kQ2RvVlFUNGZ5bWlC?=
 =?utf-8?B?SFpidGJ4M0Z4RkNxbWRkeW9lTzJRZmg1RVdZdEZ5QjFvOXFUNzlnZWV0UjBM?=
 =?utf-8?B?VVNRWTg1UXJhQm1MKzZNQng5eHhtQ0RRRmlEMUpmWUI5SHVZaWlqeHJYdlA5?=
 =?utf-8?B?YzRNWElyMDBCUVMzVFg3UVdQTE8yV3d2V3lmTUYwM1ZDL2R6MjNmU2t0UHNU?=
 =?utf-8?B?M3J3TUlQWjhwZjM0TWVUZjFhQjljb21WemY4NGx2RXk3V1RaYVU4ODFEVkRH?=
 =?utf-8?B?b0p5MVVFY3J3N25QSUdOYkJPWTFoZEM0SnUxZmlSQWNKWEZ1bGR6NUMzYWho?=
 =?utf-8?B?ZzdVOCtvQXo4WE5NcmFLZkw4RzdJYXdsckxsY3RpRDI2Qk5kTjZZanBKVGl3?=
 =?utf-8?B?cFdjSENVbDdGU2N4d3Z2eHZBWnFBQkQvbW1RNkFoRmgrb2tFaXIxR0pwenRs?=
 =?utf-8?B?ZHpvV0xjWFo4RFZlZW82SnpLaG5MVWhzK0lWcUpNaGJCcUpINWVmQlAwL3p3?=
 =?utf-8?Q?B+pb5wHg8djxzwtYsNej27jS1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4333d629-d740-490d-e0c0-08de20578974
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:49:07.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQBDhXHsp911y09pZiozA9TDhX/nyoBHj+oh6ro1gKz44YBqnKe3Uz2OUxT+wMtttk8+unD54dYvTudAKu24Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364

On Mon, Nov 10, 2025 at 12:36:46PM +0000, Pavel Begunkov wrote:
> On 11/7/25 13:35, Dragos Tatulea wrote:
> > On Thu, Nov 06, 2025 at 05:18:33PM -0800, Jakub Kicinski wrote:
> > > On Thu, 6 Nov 2025 17:25:43 +0000 Dragos Tatulea wrote:
> > > > On Wed, Nov 05, 2025 at 06:56:46PM -0800, Mina Almasry wrote:
> > > > > On Wed, Nov 5, 2025 at 6:22 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > > > Increasing cache sizes to the max seems very hacky at best.
> > > > > > The underlying implementation uses genpool and doesn't even
> > > > > > bother to do batching.
> > > > > 
> > > > > OK, my bad. I tried to think through downsides of arbitrarily
> > > > > increasing the ring size in a ZC scenario where the underlying memory
> > > > > is pre-pinned and allocated anyway, and I couldn't think of any, but I
> > > > > won't argue the point any further.
> > > > I see a similar issue with io_uring as well: for a 9K MTU with 4K ring
> > > > size there are ~1% allocation errors during a simple zcrx test.
> > > > 
> > > > mlx5 calculates 16K pages and the io_uring zcrx buffer matches exactly
> > > > that size (16K * 4K). Increasing the buffer doesn't help because the
> > > > pool size is still what the driver asked for (+ also the
> > > > internal pool limit). Even worse: eventually ENOSPC is returned to the
> > > > application. But maybe this error has a different fix.
> > > 
> > > Hm, yes, did you trace it all the way to where it comes from?
> > > page pool itself does not have any ENOSPC AFAICT. If the cache
> > > is full we free the page back to the provider via .release_netmem
> > > 
> > Yes I did. It happens in io_cqe_cache_refill() when there are no more
> > CQEs:
> > https://elixir.bootlin.com/linux/v6.17.7/source/io_uring/io_uring.c#L775
> 
> -ENOSPC here means io_uring's CQ got full. It's non-fatal, the user
> is expected to process completions and reissue the request. And it's
> best to avoid that for performance reasons, e.g. by making the CQ
> bigger as you already noted.
Got it. Thanks Pavel!

Thanks,
Dragos

