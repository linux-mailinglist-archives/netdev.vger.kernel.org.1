Return-Path: <netdev+bounces-253148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJGFAn3pdWn9JgEAu9opvQ
	(envelope-from <netdev+bounces-253148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 10:59:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4D80173
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 10:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E33C3001305
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF9274B39;
	Sun, 25 Jan 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OkXePm0P"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0B13C918
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769335160; cv=fail; b=Bwh2J69NbVFlqZkCvXVabdI92rcig1rSDfhRlA056JwmPkYDXt9DzRf1zU3CJLsxv6QwMl2m2gMbJTImI1D421/fDkO0cojWEeG9Ad30pJp/FXt1YQJ3V+sLL40UFqiBAHtoFXzq+0KZhBMbbZobfoCfD0jy3kwUXNgjQgHkk2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769335160; c=relaxed/simple;
	bh=ExnxqNcuWGOa0FvuqoaYAyI8kL+OybxO8y9rhnaMRic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACYuhIQH5lP2Zl9HmAVxjIKQhG0f7MBxGABUDseCXiDrnKTpbDTEcqGY0+x4blklSeDrlZhK7W+wc95YFMaw76AqX0LjDk6syQpBvJz6nVI9Ss0y/8QMDHF2A0ursbGYaHOiIqJ9TcPLWmFvXDD3SZfIEM7v5L6iBZkk95CczoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OkXePm0P; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btULRkNagvw25ovk2gKeu5K2Anb6FY11Rfxw01/tmg5ONGin+NSCBDQOpg/6z81YOSiy6kBIRM4BX98CWiIkmTOqdJET2QkcttPG3JJj0xh3F2sG+Q8iv2hgVY8tSTlZr/bTS/p1qAz3Iz/5Cn+1gQmiVjal+9TXPQy97jbyOleFiHngyHpQ0xKlARRwX9wYU8WMUBwnf5Ib1cy+Lb/QDIo2iK4oNC7ZBPRaWEFAZrTeYtR5SnDj2X6zvXYWXGQV2NWt42d1BC0z21ppJC66F0wM0ZxJ+LQgNQ42deoNBUVdbtMsLUobXYbEd433iz8omb2keW3VkYT6RDZT1/rNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXGMTV99NG6xMAzdpfE+0FReoPWE607AIYkySbbGIpM=;
 b=pVHgiF2e8jWotmX2S1nLlZd5bjOHzCQww0dELowFWRa2uyy31VQvevh7PGgPSPQBD+B6zMT50vXGD6xnG4a2jzv/kL6P55NVaO2Kral4N4Ve75fqIekzNXSTN9zwEuVo9B/UlCki4y301+/IxudQRShAQZbRaokE8RUxEI3kWUhymMM4+FauFtL2nN706MGuq9y/Hpc5d3l0kqWJMk6dqi/Gq+BaYW6RNM0dpXwmR1kSGAhyOdYHc+KEv2+iAvdbzMeRufmgPbjf6mMZ9sV9deS3FlnRICpfyHPC6JJnd6qL/id3il9isxMfoMGgAk7cGoSWrOp+f1gHARNVNuHuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXGMTV99NG6xMAzdpfE+0FReoPWE607AIYkySbbGIpM=;
 b=OkXePm0P6mjxfv780ukcjXExQJODdw7tBeu9kDzZrWwMsAt7vN4TiygTMZHGzw2J0KoEqkyZ3jclnxqVLyCYsyY1ld7Q49SsTHefO8fuA9rqgw/0lx1Za0GQsCMSp2wwK4WsZ/U1CP3bw73MnHDXXW5khJCVlVTe54RbimyHflCV+b5eE+waQi2XpbSHuJ909JBK1eBeEdBPegY5OkmxXWZDqrdag2qPcWDdFM4tZa/PVmgT9Vg2795iRGSjs/AeUNr+YMDP0yrX2FMtQ4OiORkaN9funrLLzaGqsp1dqVRnguwTRPVhPs1fMCzgTrgGdnJXi5Uez4QyMIIYUgIaWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 09:59:14 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 09:59:14 +0000
Message-ID: <aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com>
Date: Sun, 25 Jan 2026 11:59:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
To: Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, chuck.lever@oracle.com, davem@davemloft.net,
 donald.hunter@gmail.com, edumazet@google.com, horms@kernel.org,
 idosch@nvidia.com, jacob.e.keller@intel.com, kernel-team@meta.com,
 kory.maincent@bootlin.com, lee@trager.us, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, kernel@pengutronix.de
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
 <aXNAjOjkCqOESf5y@pengutronix.de> <aXNbTVF5KNz1yV-1@pengutronix.de>
 <20260123104031.16d914e4@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260123104031.16d914e4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0f2372-4bed-41b3-acf7-08de5bf86558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlNSaytTZHMwUzcyd2ZsSDZaQmVEbHVWaUZuNjlsQTJ4SVdGSmE4aEdFUVEx?=
 =?utf-8?B?enBWVE1iYzZMTE5hTjBrUGx0aUwvWEhEQXFYZThuTnNQUzlSdjJqS3hIU29Y?=
 =?utf-8?B?WE0yRWdZM0NqRXJBQ2dRMXBva0UzWUoyTWpRdTVXVnVmblNIYjBSQ0s4MDRE?=
 =?utf-8?B?VFdXN3NyVWdIK3gvM0RNQmozL04vOE5KNWRTK1FqQjBNWDdxWGRMdHhMV2Nt?=
 =?utf-8?B?a1lSWHd6eDFaUHZJZmpTRUxhQm5HUkYwOC9FQmFhVGUzdVAxVUVLN2FxSWtp?=
 =?utf-8?B?UlI4RmxUdUg4Zllyb2l1YldJRW9GdWxWb010TU54ZkdsaFlxeDIwemRhZThn?=
 =?utf-8?B?dXZic1UwbWZBYU5DK2RUZjV5Tkpwb2s2ZHBvdHRiV2MrRDBWYTFxOUxhZ0oy?=
 =?utf-8?B?Q1IxUnVwa0RkWE90bFdFeE5FVFAxMUZ5OXdOSUJVM2lENkdLazRINUZ5dGQ2?=
 =?utf-8?B?UkZDYkpaeTNid0RZMG9WbTZXK3RLZHNYeFZ2aURXUE5NUlltVEppUnQ3R0hx?=
 =?utf-8?B?eXB4V28xMERHdks3Q0lyT2wxVU1ZMVViUDFNclVvZTJlVG15a2g4aDZKWnBF?=
 =?utf-8?B?SE1NbFdDVGovN1BLcG9Ta3MvRFBkbzQycWNhQUxWV01TNC9ic0RzUWJqSDFR?=
 =?utf-8?B?VHNBZm9EbGtMdFNwd042cW5mZlhCa1YrTVJBa2lxekh3YmZhbFloODlHTk5l?=
 =?utf-8?B?STdGQzYrNFJNd1pqdUs4MnhIRHV0WjhKa1NlNTRSMzltcXpGTHF2YW1wNFMw?=
 =?utf-8?B?OU15TFQ3VGhwU1o1TjJSYTZSdlNwdnhjWWdGUjRGUnN2enRTREtoYkR6UnVi?=
 =?utf-8?B?NHFtb3Vyb2xPZXA1MDZMNUN2WUJORHRjeU5NR0lOM2xldVFCYU9abXo5b3BN?=
 =?utf-8?B?U1I2eS9nZXR1THFLV2Vyem1DUytRdlN1YTJ1L09PVDVxZThWUHRKZ3NZRlNk?=
 =?utf-8?B?UmE2S1dMUHJkRzE2bExpcFV3UjdUdnBNT3B1bnN4VXVvcGYrQUlyMFR3SVlE?=
 =?utf-8?B?SUwwUXIyUzNQQXQ0SG9MV0N4eER4c2YyUFhicThhTWVZRkppU3YwRVlIM0Zk?=
 =?utf-8?B?NjdEdHAwVkw3UDV2TVNQaEgwNHp6QklMN0FWTEhOMWNFSk0wSnR2cEdCREY5?=
 =?utf-8?B?NERUWk9HaVZUbzNwdXlRUHJUdk9wc01FUDJ5RXlXZm0zWWs1MUFYR2lwc1po?=
 =?utf-8?B?RExyUVc5Nnd3QzM5aEJQLzNvRDVmdHZYOGRnY0lhWFJobXJYZFZ1K25wdElE?=
 =?utf-8?B?a2FiZnlUdVpIMnhPQXhIQ3JzRStrd3YzZ0hNOTl6TUFvUE1RTmJhcjRuZVRT?=
 =?utf-8?B?UlJESDRvdGM1SitmaHgxWC9BRUZkQnBpUDk5VFVqVmEvRnVZYmhyVlBLOHhr?=
 =?utf-8?B?Rlo4UFNJWjNTQ1hLenZORk8vSkovUjJKay9qaGFaYnpRenRRVzV4bEhIeS9Z?=
 =?utf-8?B?aDhLYlNkTGZVNlllNG52WlJMZ1ZZSjEyY0Q1d1NxYU1JTjZaUk9ET3k1TUE1?=
 =?utf-8?B?N0NWTDdoUlM4SWxNR0RXMnc1ZlBvTXlYaXdIZkRQWVpRdjJSVHBFQ0pJNHlH?=
 =?utf-8?B?MzB1L1RWM3g1WE96V3lQY0MyczBNcGJ3NTh5bjlMZUN4K0RKTDVXWjhVbFQ0?=
 =?utf-8?B?b1RRNXVEdTRQbFg4d1pJcEZaZkNhS1RjdFAxSktTaWRIWXBjWTFDZHp3Mm5C?=
 =?utf-8?B?TGVBTjVheVJFZXI4cVFrMjFOcUc4dW5SV25sQUcvMjNua3dESkVTWkpSYkNj?=
 =?utf-8?B?UTZzUHhmRHJrOHNDTE5wTHZOanBwRXova0dyWDhqa2tLTUhNWWRvTW93WFpK?=
 =?utf-8?B?TFhFV1NNWmJGSzU5akdZdFZTakp3eXZVU1dSTmQzd2ljWHJIb3lJa3M3Z1dH?=
 =?utf-8?B?eTlOMlo1VXRUZ2FtOXlnejdyd2M2dkhCRUhVL1hiVit2NEpqaXpZZnB6bGhW?=
 =?utf-8?B?UWJUK3k0VytjWWdPazBNcDZCdFhwSjR3c2ZnNjdHVmU0MXprZlptRnhXSjhp?=
 =?utf-8?B?RkxsUEtUdUJia0gyeVdVaEI4amxkdW5VNFVMVTZkQTJ0djhwVjUyRHRUUDhG?=
 =?utf-8?B?YmNHc081NlhiUUx2Q0dTVXcwOTR5SFpNR05kemh4RGRYTGhCSlVPait2b08w?=
 =?utf-8?Q?UIbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ZwN01LT2QzOE1remhJdFNRVkNiSHk4b1E1Sm9WNm80U3RFMkx0VjBrSEVu?=
 =?utf-8?B?L3orRDNJdkkweG1SS0dMdlMyMGlJbVJQdlB2dk9iME5ST0U3VkdNTGdTUy9O?=
 =?utf-8?B?ZjFoWUpkdVM3aXVwRXZlWjFIdXlyWE5EK2p2cUoxQzN1QWc4d2VKWXY0T3di?=
 =?utf-8?B?ellxd1ZETVhUOEpSSU9lYVVvcFNQNnE4NDREWUNyVHpFRWExd3IzVVZGYmZh?=
 =?utf-8?B?NTQ4aFdyUy9yZlB4WDY5Q0VxYjVCOE0rRjBwR29udWU5ckVyaW9NVlQwUWZl?=
 =?utf-8?B?U3l1STZ6VEpNaFN2QmpXMEgyTVQ2RVd1UHVhWkNhNFczMzV1UTRFM2FlSWRx?=
 =?utf-8?B?ZEl3TzgrTUFzMG1Ca2JVdlNzYmVrNjhUUVplaU4za09sQkE3UHdMRlN6cjRS?=
 =?utf-8?B?dGJWc3dUL0hkN0d5bzVUZURWajdPbWcwZXgzUnJoeUxodFpTUzVnQ1JaYzJD?=
 =?utf-8?B?WTJ6SmtMMXdzV0lZRHJ6Qk9NRWNoYkhnSzlXSFlpNEZlQ0tBQkliZEZTc0hD?=
 =?utf-8?B?ZTFvV1VrUFlMNk1xM0hDT3paajFWYmVlMXpTaER1akpiWHhIZ2I2OUtqSzBa?=
 =?utf-8?B?Vis2RGFIMURNZStTWUxPdUJsUWoxdnEvMm5nT29vWS9ncGRGNDdCWEF4VVZa?=
 =?utf-8?B?UlJZOTBXVXhiaHgrMzloVWZxQWZlNmUwcWpRa2ZGQzJVT3h3ME53YkYrc2g2?=
 =?utf-8?B?TUh1RmdhVXpweUFDOWJ3WFR1K295TjhGRHYvSXVvQUJuc1k2MUJ5aFR2ajN1?=
 =?utf-8?B?RVJ1Wkh0SlV5VUo4ZmNNNTBaTW5CTkJpZ0FlZjdDOVBrSXhUYnJUcVRMY3hT?=
 =?utf-8?B?ODBhNDdxbHJhV3BhSTJKdGVIbnpFdW5QQzFFK2p3TmQrUUZpMXJVNzY0OFNt?=
 =?utf-8?B?aFNZTTAxN0hLbzJ2a1ZtMTA4T0xZN3czNFF5Z0dFQnhocTRyS1J5YUdkSlhS?=
 =?utf-8?B?aEQ1dWlrYUxGVlYwb2hYdnp5Ym92TXAvTXdZNTFWVG9KM3BBZXdzUVJMMTVu?=
 =?utf-8?B?ZW8zSkNYVTFiRldLQWljVWRJYWQ1Qm02R0l4WThDRzBsRW5aM1RrQTVqaEJq?=
 =?utf-8?B?NHVRT05BRlpoRWx5cmRmU0xkN3pCeGZ5ZFNHaVF4bnJ5NHBZVkdSYmtINXAv?=
 =?utf-8?B?WmdJdGJxQXhjVHdwTFlwK0dpL042YTRJVEJrV2VjZ0srRzVUaHNoZ2NDNjRJ?=
 =?utf-8?B?aHF6VUZ1cXNaTU1NY3RTdEJ2R1RsWGo2aHRZQ01xNnhVM0RuUVJQelhXQW8z?=
 =?utf-8?B?SklXTGp4TjFpSkRpYUdZK09PRGpzVUhLY0l2SDhtd2IzbmdaVFdXNzJFTWNl?=
 =?utf-8?B?RUxTTjlJclJXQ0Ntb3RCNHU5U1krWEFHQmc0dGsydWFPRVFpUkdHYjhQaFpn?=
 =?utf-8?B?SjNrdmVoQVBoaytzS28ybEJSc0pxRkJxZXQ5WEJlSGpoOGVzMDF0ZSthSS9Y?=
 =?utf-8?B?ZTliV213Qkhzbk8yRmZxaEljSEpjMlo4dWR0Tjd6VlFodTJNbnAvZGJMZDRV?=
 =?utf-8?B?NlFoOWJ6YkxLTnZ4V3NrbVpEOXZBVWd2MnhNQ2t0dW00Zk1vTm9FcnlXbDRh?=
 =?utf-8?B?YWF4bmJyWStrN092TGhTUGNyWEFVM3BMK3RvaUF4Q1VseVJCSDhYcy9pODR5?=
 =?utf-8?B?QTFUOEJBblFaUVJLVmx1NFRHT1dnQy85cXM2dFZpRXplWXMxd3c0aUwwazV2?=
 =?utf-8?B?L2lNN0s2K0FWSnBoUkJvRWx5RnN3NWtwcXhGWkNBVFloSVNNaW43UmJtMnV0?=
 =?utf-8?B?OVZBT0dPTms5QytKd1I3VDZJUGFiamFISmxDYTc1TnlkRDRlQVVwQjVpa1lC?=
 =?utf-8?B?dWczNVB1SzRPUEw5eE9LVlFOczVhTkJhdXU5V2d4OGQ1Z25DRTF3a1NPMjlw?=
 =?utf-8?B?WkpNRUlKc2hHbFpHOXVGK3F2VDAvUGZuWG9EbGthMjJ0cWk1UExQNkJ3QUdI?=
 =?utf-8?B?RXRtSnhEcjVvSytxQ0dCZjM4NnVwUG9pMkZiRlFpaytPSDE1RDlkZ0pBa3B6?=
 =?utf-8?B?VlpaMHBRQTFFMGwxY2pYMVVtVjdTOVhwUm9CaFdKWXdQaTg4Q1M1YkR6WVNB?=
 =?utf-8?B?RSttZkJVYTRsMzBsR28zVURxaHdjWDdNNHg4TFFHQXdnbnNMcG4wRndtcThS?=
 =?utf-8?B?eGZ5TTlvUTBFcjBHbVNseVR6UmFaY2QxMkNOa2VMSmxNNjJUTXFwaEUxNk16?=
 =?utf-8?B?ckwxRDEwT3dNeEpZSzdkSlJaallFSHJOMXlZZEFYQllaZzVaNmVTV2RtTmQz?=
 =?utf-8?B?ZlpwL0U5VmpycFh5UzRMQ3VYY0VPUDN5VjJTcnlQeEN6MmxucThDOTBQOVU1?=
 =?utf-8?Q?QnwC/3TEseISbzAIuf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0f2372-4bed-41b3-acf7-08de5bf86558
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 09:59:14.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Juz0WBikZ7ZnbLmgvSXN9IxxZDpxeDftal+r2G7IiBjR5Dk7h6LuJpBfWvwdHUEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253148-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,google.com,kernel.org,nvidia.com,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev,pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0A4D80173
X-Rspamd-Action: no action

On 23/01/2026 20:40, Jakub Kicinski wrote:
>> - The auto-recovery (service task) enforces a fixed policy. Can we make
>>   this configurable? I used devlink health (.recover) to let userspace
>>   decide between auto-reset or manual intervention.
> 
> There is already a tunable for this exact feature but for PFC:
> ETHTOOL_PFC_PREVENTION_TOUT. Should be trivial to add the same thing for
> non-PFC pause. But we didn't want to open the uAPI can of warms unless
> there's a clear ask and consensus. We don't need tuning (or so we
> think), and there was some talk about not adding uAPI for fbnic because
> it's a "private device".

I had to refresh my memory on this, but I think we've chosen a non-ideal
name back then.
We use this value for both PFC and global pause, I recommend you do the
same (perhaps with better documentation?).

mlx5 exposes tx_pause_storm_warning_events/tx_pause_storm_error_events
through 'ethtool -S', we can probably assign one of them into
tx-pause-storm-events.

