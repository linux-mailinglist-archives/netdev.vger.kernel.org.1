Return-Path: <netdev+bounces-207006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E670B05318
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB711C21790
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D223B628;
	Tue, 15 Jul 2025 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q85n/0z6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BD26E6E6
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564049; cv=fail; b=mWsBtW75zahQTr9WfrQ6bwgfW0wGgrdpaH1e6azFkY9wx44Bc1ZQMpaaucMXnrUnyi4cHEBA+p7dWABSlJgG1DwO+hxRkgYJU+uPAPOJjWOvFzEv/w07eUCVkWmWfejKMV79DuSTQJM/5zvwFqnZFeMwsTuhb7PBFVALWp23dOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564049; c=relaxed/simple;
	bh=vc1TKW+b5C14XWBgiYDxNPIBF/2yTFtIUQOJ6+glTZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/+CBDNIOZJa+7Myk1q+fDL3mmCBKicY1SBJofQglV591nn4Y+uny3Kcp0vPnpN8NN3rhZUTlE5yBkiTPrqRRrnQp2JUIIpgI5b0Mqg5dxdasqHiC6/gr8gTrWv/Sl0Mui8RnrUlqXkJwX94df8gcJAjVd4WJZldUawfbL1EzR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q85n/0z6; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIIlI0iVEiTdicmxtQv1SmpEj3iO6yBYZJPj16XgCbiMGq6Atrip4VcbBGjqe9XdIgUQrpc8ffdWVJrsZH6Ras+KnFGDI/Al7/enS0R5vc/1UNFY7SPhalSqJ9TbqDtJDXKGUyAFQYv7ypXl8UT62uFkximEZJcbDjShNF1OXPwTl29Ps+jvgE0GsRf7m7ED/rOVn+dZ+hEzm+DMx/AZhxNbCDfzzXJqWjTLrxi9Rlov/JWvU/8FMQApUYS8imoYGfuEZdKzQ4uZgLULoahI+V7UDAwvSl9WaACpp3nE7iiC5jxgbxS+S3Fgy06gcJ4a0XKdp89oZmfznaTmEitWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LleUwDVXsMq4Vn03dNgwp3UitBwCPBjVaMN+T5gK28=;
 b=hLr6V1Nj0y3q4gTkxkAwU07Qs8Q1Llbcp0/716o+KPdR6prKsDMkRlOKIt/5gRdUaM+j6ce35gShJK4FIo9y67Ybf1eUvacjKPQXVKHDMqGGRQJ60EUr5iAOwgKFQy+xiUc9qjpTZV4pjgI50IMUZWCVPXIV0LdjNE01/eGsHVn22y3pv91OggKayg4qgiKrIPK3NXqwrKY++LqZgGBORWuAP44rsBfhpsiOJpIsBfemSd/ATMc1g4KwzTwSWASydMJeim6PhRtm2Kli1InJfse3paT/uxbeHsePyzhx71YtcCuJvVRvuC+HSbiwgMWaS8F5bVxlJi6fn3R+0tBjPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LleUwDVXsMq4Vn03dNgwp3UitBwCPBjVaMN+T5gK28=;
 b=q85n/0z65OfdxS3BPJdWqBhHd1t248jxvN0SSHVEzdSMv3uPv6h+Fa5zR37+416BfeoKTbG4Cz8zzR/orS9ZSYhuItjzr3I/568iP4+rhEOQS+M16IerIwP8BbxcldYbU/tSaFx1KWL/n3eosFxM+KeiHeM9lUM/db/RbI+hq3Sl8wfmsNxKHIQFyvyNCUjd4QtULoPBspgU0kq/1+bN5lYpBSzxj/XBg7o2LPl949bDAwS0BB1PDswr7EVr5VF6Oquyub7SS2v6rKunU5eRZQi+mY9Zv5TZrQlTpxxvojyP2y3qniolSG6Ds/j1lDMn2TMRbvn/iHkaYtbOOp/SpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 07:20:44 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 07:20:44 +0000
Message-ID: <737f0ee0-d743-497a-8247-63413060a7d8@nvidia.com>
Date: Tue, 15 Jul 2025 10:20:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] ethtool: rss: initial RSS_SET
 (indirection table handling)
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250714222729.743282-1-kuba@kernel.org>
 <20250714222729.743282-2-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714222729.743282-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8fedba-4c26-4f02-1845-08ddc3701cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU93SVlHcytlZ2xQa2pDTzd4ZlVZS1Z2Y1hScno2K294MzVlKzlnRGVXRjFN?=
 =?utf-8?B?ZlhUbHQ4WGZWdGU0dXdHSVIyd1ZGeVp2aS9QMlpYUm1uQlMvS3RUblZKdzNB?=
 =?utf-8?B?UjlNUVBWUENJQVh3Qi9TdTVlLy8yVEZHZWZLZFBrVHJ1Q0NZQ1drL0QyaWxW?=
 =?utf-8?B?dlFBeEdieUgyT1R0RElCQ2w3dXhlWnhNaXl5WEpXQjAzWmxPKzEzOUl4YVM2?=
 =?utf-8?B?bXJkLzl0Z3dSdURMUzlEQnBxYjBkc3JIMVRoTE8zM2h4Q3lEYnFPbFNLc3Js?=
 =?utf-8?B?WmhXMXBROGlqY0dPRDgwZlVhaWR2WHp4Ni9Xay9ZWFY5d041NUt2QlF1bEFC?=
 =?utf-8?B?VnpFaWNFSU9CRHYyMU9NSS9aYm03c3dBU3FHTGc1M2pMTld0VkZOQWpodFV0?=
 =?utf-8?B?WHk4dHBSV0VZclhmN0UxNjNPak0vUnFrOGtnWlhIdXVwVmx2WlU0NzVwTkN1?=
 =?utf-8?B?U3pLUnNWWC9ENjZrMGVoYjRZRGVmRVlBRU9aNTVMTm5QcHFKNE04NnI3cmhD?=
 =?utf-8?B?bVdYOUovNGFhRFptYUFtV0JWUFVhYnowZEdQMGlZMWs2amc0S0xCNE1DQVNs?=
 =?utf-8?B?azZvdWlRU3ZFUU5KY05ucFFWV2lrYTNDcW1WSWZYaWVXc1RRUVlaNDV6TDF6?=
 =?utf-8?B?Sis4a1BTMGNDMnBtSnZOQVdWeWxVa3dScUpieHpNWWVOd1ZKSklmQms1SUlm?=
 =?utf-8?B?OG1ERGczVjBKVzdUQVFlclhQS1VCL2VpOG5FOHhCRkxLeFVSeHpWQVFaYjdM?=
 =?utf-8?B?QThoQzc5SkNTbzZBZlFzOUNYSElUTDhTMU1yZ3I2MkVqNGxDNm1KaHB3MTRY?=
 =?utf-8?B?Q01Hd1VTMjQ5bWxTZ3pmNTZqdlZqNWEwUWJuTkM1aThmTVlrRUtuN3BmZlpW?=
 =?utf-8?B?REFpOHhKKzU1WU9iU2MxSGcydmg4N3I3b29HU3VESDllM3BBU3JUTFhETTBN?=
 =?utf-8?B?NmJkNW5tTzVZS3RIUE5vamZDMGZrZDJZbzhOOVRGMmhuQllFdlJkck4zNzNK?=
 =?utf-8?B?ZTZHU1BScE5wbi82cDFSdmFmT05WV2E1aXJFOXJlczJaQTVINWpFVExRWHNo?=
 =?utf-8?B?Sm5RaVlWM0JLRVp3dkF2RTJQV0VSN2hTaXlXRTVLR3dzejBmQXk5NFFBVDVH?=
 =?utf-8?B?cVNPQXAvVGp5Qm1CSzhISXpMMk9XRkcxWU52aVZUaFhTdVZTT2MvRkVxekJk?=
 =?utf-8?B?NHRSNStIZkZ3ejE2bmduSkgraEQrS09DT3hmaS9JM1h6ZHh5SGlybzZBdVMz?=
 =?utf-8?B?U3NyTmZtUWdIUFpoNUVUZkU5L1FHR1lNRDBUbDJlVE9FYS8ydXE1MG0vcVpG?=
 =?utf-8?B?WFdpWTRDMkNndGNDYktFajRxdEZ1T1JvazBzWHZKdm5IYlcybWFxMXQ0aTlx?=
 =?utf-8?B?N2RRZGF2MWFXZ3BTNVZIazRxVEFBYjFOZlJTb1VaZnh3SG1ldGFpTElKMTFM?=
 =?utf-8?B?bExLc1FJNHdkZTNJK1U5eGZDRW4wOXdhUCtOUHNRRGU5eGp1ODVvSUh3eUF3?=
 =?utf-8?B?ckFFUmhtRGRiWGJtblVoYXZCN1RTK3A1UDJaRUVmVlQwa3M2MkhJN2RtODBS?=
 =?utf-8?B?TElBQmJDcWovS3p2K1RrUzBHM1RIeW5FQk11aWRldUlLZXV5NDNnWTlzdm8v?=
 =?utf-8?B?TXptOGlpV0JSU2ErRm1oVGFWZTBpSzA4N2I2VENIQzdFazRoTnZucDlCbE5p?=
 =?utf-8?B?SUNUUlZqbEhPQ25GdGthcHQ1VWxlMGVJNVE3bG9pbGRqOGVzTFE1b1BkU3J3?=
 =?utf-8?B?Z3JxK0N4S0RoQjdGZmxpMEgrbXVXaExCN2J1ZytvODRFKy9BNTczKzFzRnFZ?=
 =?utf-8?B?S3crdjFRWXhPZlBwVzloMFNJY0t5dkpZblpiaC9GZVMwenllMlVyajBaWDhk?=
 =?utf-8?B?YnA5bDk1Z0Fod01mZWNoM25JZUhUd3l2OFNTaEhpYk0zeVdWaWNoMFJwTHF3?=
 =?utf-8?Q?pd7J104yYIA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3UyWW83UGt0bnNuMTZNakhhQmJIZVZFd3g3N1E0VUpzYUhDSWdHM3V5NG1Z?=
 =?utf-8?B?azlBVEpUOUVNT3J1VmF5cGlqR1lIZWJuN1RMM3dYcitLMmE5WXVkSGZIMEZk?=
 =?utf-8?B?eVl4Z3AraEV3d1VQdHg5Z2tiK3dVeXduQkNKWXhnZ2RSZWlrYTk3TkxxQXpt?=
 =?utf-8?B?YlRzNzdlN2MranpjRE5ZLzN0REJtckF1cDY2clpMNEt3b1EwSjQyTkM1QTdh?=
 =?utf-8?B?M3BlclpVQWJXOGFwVXdnWnFCNGF5YVhkRlA4a3lZcy9ZOVlUWFhlaU41ejNS?=
 =?utf-8?B?YUlxQ2hGTXhnQ1dNM2hkaERLYzNwb3o1NlQyVDgyVGFidFBJUW1WSGJUREhn?=
 =?utf-8?B?aWJ4RVE1RjRmU1NaMlpUWC8ySXhQV2J5TmpzaDFEUXY4bW44N0FGNDZzMWsx?=
 =?utf-8?B?SXo4WVNRSVJSU3MzdU4vaHBsZWJtV2RJL3NpMmRIV3BLdmd3dGsxWmUxYmxW?=
 =?utf-8?B?aU1aZ0JwS2k0MVcxdndFUnFxT015U25YYml3Zk1CQVduUk5xeGNuUWRzekpi?=
 =?utf-8?B?MlJLaVlwNmM4YmdDbEpEZFd3R2J6T3ZsMHdRTWMxaWNqamNTb1JudEtWWXJD?=
 =?utf-8?B?SlFpMTk1YnV3bXpvaU9XVjVpeEpnZG9Qb29ZaEJGMUViOGtDTlE4OUxPRW8r?=
 =?utf-8?B?VVEvazAwN3R2OXlmYnRUc05vRGpEL0RaRFY5NFgySERqakgySkp4OEdZcHl4?=
 =?utf-8?B?TVd5UGVqN1VQdXhGN00wNUQyMEVlUHlXMHFZbjBYUmtnM1pCTGF3UUgzUXpI?=
 =?utf-8?B?QitQbndxZkgzY2pCMk9zS3FaTjEwOHdPOWJPSnVTMEpIcVVmZFJCS3U4T0V2?=
 =?utf-8?B?bTM2aDJkbEpGYmhTNlNGQk44b2EydXgxdll3MHcwS2FEL1VwVW5NWjNZOGhn?=
 =?utf-8?B?UlJXREVwaENweU1Dazh3M0I3Q3lIT3JmR2YyZk9kTUNmbUt2Y0dKb1dCWmtS?=
 =?utf-8?B?dTY0MjduMlVsQVoyMitiWnc3WGs5Q0g3SmZHeTdNcWc0dCtsNU9VYnJhb3Z0?=
 =?utf-8?B?VStZbDNiTzFMVWY0ZmxtaU9OcUE1Y0szN2dQZnE3VFN2aGMvYW81VDVkSDlI?=
 =?utf-8?B?QTVqNVhHcUVrbFphRVFOUEsxSlVvTGhoTlpnWTY0UmNtQ0YxSjFNU0F6N3FN?=
 =?utf-8?B?Qm90U1RjeVo2MGlINlJXSWJvTksxeXZhSVVHYlVYWkNOd01TQWVVdHFrZ0t0?=
 =?utf-8?B?TkZIcG1HbGRTcElCVENzdW5UMDR1S0VsaUJzSU1ER04wN0o2RXNTT2I0dDVz?=
 =?utf-8?B?T2M4a1N3SkFoMWVPOFpicDlQdWltNXA3YzcyK1I2N3NCMnJGL0V6T3AzRFgr?=
 =?utf-8?B?Vm5hblpPT2d3OTArNUQwNC9XTnFjSjNoTUloQk5WTVp3OENmdEZwaUVVWk5Y?=
 =?utf-8?B?b0dQeVAzOXpKTU9iUHpCS3RhRTNHODdid1pkOU03WGV4eGdvRkM4TWFMMk9X?=
 =?utf-8?B?czkvSG1tMmZRWUxRT3JQMWM3RlhBL3A5MkVXR2FRZkVDT1BBOG1QRVBaZS9v?=
 =?utf-8?B?NCt0V1Q3bFZBT0d5TlRHTWRQOURuRmZIZWl0REF6VFFob21vaHhIZGk2eDJ5?=
 =?utf-8?B?dHVPc1ppUU13WE5XQXNGK3pVMjNWNGRuSHlhV2twRkZweTBOSEJVVFpaK0Nt?=
 =?utf-8?B?OTFxcFc5dXhNZ2FFOTdtWHFpWlIyckU4TWFSL09ad0NXc2lzTTcyc3FGYnRp?=
 =?utf-8?B?eFVUSG5ybldLTDlVWVl6eWFNMC9WSjRxaUdoMEh4WE4rcWt6YTFYMEliYU1u?=
 =?utf-8?B?ZjlwTjA2dkx4emVDMnlQRmpKK252RDl1R2Z3enhnOTFpcHZ1Q2xkL0ljY0VN?=
 =?utf-8?B?RzVHZW5HbDRsNlRtbEVTRlFpNjlvRGU5UGN0ZWluUkJNNmQ4YUUyaDN0Qysy?=
 =?utf-8?B?UUxjaDB6bzNuQUlOSXppSXJseU5INEdRbW5RRlc3bXFOZVhMRGIzYlVaQXc3?=
 =?utf-8?B?TitVdXBVa2p0OGlReS9aODRFZVIvVmRMZHdsdnl5Ym02ZVpMUGN3dS9QblRX?=
 =?utf-8?B?U3VjMXVPZ2FxV0c2ZkZEWFcrTWRVa1BtM3piMmxIUWVDVnp1UkQxdEZaNFFF?=
 =?utf-8?B?RjhqdHlMVFQyTlluRktqM2xPWm9zM1lmV1ArcXBIemcrYUxQNXFGY0JabGpw?=
 =?utf-8?Q?BwTCV/uZhD2rvG/7+kwsz+88m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8fedba-4c26-4f02-1845-08ddc3701cd9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:20:44.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zNCQh05FdCxGnU80NvLYUk2uVy0sjs+FIMxUmJoxwb3KbC3Ci41ekwqnj44RGWj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282

On 15/07/2025 1:27, Jakub Kicinski wrote:
> +static int
> +rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
> +		   struct rss_reply_data *data, struct ethtool_rxfh_param *rxfh,
> +		   bool *reset, bool *mod)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct netlink_ext_ack *extack = info->extack;
> +	struct nlattr **tb = info->attrs;
> +	struct ethtool_rxnfc rx_rings;
> +	size_t alloc_size;
> +	u32 user_size;
> +	int i, err;
> +
> +	if (!tb[ETHTOOL_A_RSS_INDIR])
> +		return 0;
> +	if (!data->indir_size)
> +		return -EOPNOTSUPP;
> +
> +	rx_rings.cmd = ETHTOOL_GRXRINGS;
> +	err = ops->get_rxnfc(dev, &rx_rings, NULL);

Do we need to check for NULL op?

> +	if (err)
> +		return err;
> +
> +	if (nla_len(tb[ETHTOOL_A_RSS_INDIR]) % 4) {
> +		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_INDIR]);
> +		return -EINVAL;
> +	}
> +	user_size = nla_len(tb[ETHTOOL_A_RSS_INDIR]) / 4;
> +	if (!user_size) {
> +		if (rxfh->rss_context) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[ETHTOOL_A_RSS_INDIR],
> +					    "can't reset table for a context");
> +			return -EINVAL;
> +		}
> +		*reset = true;
> +	} else if (data->indir_size % user_size) {
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
> +					"size (%d) mismatch with device indir table (%d)",
> +					user_size, data->indir_size);
> +		return -EINVAL;
> +	}
> +
> +	rxfh->indir_size = data->indir_size;
> +	alloc_size = array_size(data->indir_size, sizeof(rxfh->indir[0]));
> +	rxfh->indir = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!rxfh->indir)
> +		return -ENOMEM;
> +
> +	nla_memcpy(rxfh->indir, tb[ETHTOOL_A_RSS_INDIR], alloc_size);
> +	for (i = 0; i < user_size; i++) {
> +		if (rxfh->indir[i] < rx_rings.data)
> +			continue;
> +
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[ETHTOOL_A_RSS_INDIR],
> +					"entry %d: queue out of range (%d)",
> +					i, rxfh->indir[i]);
> +		err = -EINVAL;
> +		goto err_free;
> +	}
> +
> +	if (user_size) {
> +		/* Replicate the user-provided table to fill the device table */
> +		for (i = user_size; i < data->indir_size; i++)
> +			rxfh->indir[i] = rxfh->indir[i % user_size];
> +	} else {
> +		for (i = 0; i < data->indir_size; i++)
> +			rxfh->indir[i] =
> +				ethtool_rxfh_indir_default(i, rx_rings.data);
> +	}
> +
> +	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
> +
> +	return 0;
> +
> +err_free:
> +	kfree(rxfh->indir);
> +	rxfh->indir = NULL;
> +	return err;
> +}
> +
> +static int
> +ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
> +{
> +	struct rss_req_info *request = RSS_REQINFO(req_info);
> +	struct ethtool_rxfh_context *ctx = NULL;
> +	struct net_device *dev = req_info->dev;
> +	struct ethtool_rxfh_param rxfh = {};
> +	bool indir_reset = false, indir_mod;
> +	struct nlattr **tb = info->attrs;
> +	struct rss_reply_data data = {};
> +	const struct ethtool_ops *ops;
> +	bool mod = false;
> +	int ret;
> +
> +	ops = dev->ethtool_ops;
> +	data.base.dev = dev;
> +
> +	ret = rss_prepare(request, dev, &data, info);
> +	if (ret)
> +		return ret;
> +
> +	rxfh.rss_context = request->rss_context;
> +
> +	ret = rss_set_prep_indir(dev, info, &data, &rxfh, &indir_reset, &mod);
> +	if (ret)
> +		goto exit_clean_data;
> +	indir_mod = !!tb[ETHTOOL_A_RSS_INDIR];
> +
> +	rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
> +	rxfh.input_xfrm = RXH_XFRM_NO_CHANGE;
> +
> +	mutex_lock(&dev->ethtool->rss_lock);
> +	if (request->rss_context) {
> +		ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
> +		if (!ctx) {
> +			ret = -ENOENT;
> +			goto exit_unlock;
> +		}
> +	}
> +
> +	if (!mod)
> +		ret = 0; /* nothing to tell the driver */
> +	else if (!ops->set_rxfh)

Why not do it in validate?

