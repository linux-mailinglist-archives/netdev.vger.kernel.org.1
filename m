Return-Path: <netdev+bounces-215721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B855B30041
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F11BC76F6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130BD2DFA29;
	Thu, 21 Aug 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jCLrax+/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C7224225;
	Thu, 21 Aug 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794239; cv=fail; b=ZXRzWaFc11K33P3vWtkUtJv2E6Rn9rZ/+z0+bxrURGfEFGITkZIr/CrH20715UppaNRsZUR3Q2VAKjmMKewNjTAnMK6rXJQ8WzyH+ncnmiVwY/LlfsBICPO1EVJMAIqY1ikB0zVilBharmrv6AdlBCGkrK83x8xhx3JEcXAJGJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794239; c=relaxed/simple;
	bh=hjJsScqFjRMboG5j0+cHqQGjWwPv669V9gWbQ0gfsUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAI7n8Jtp/g+qi4pchFAA9EeExGIZ0BgbXtxRc1hwJq4KQgI7bbAQECR3zt70wYeBTvRc96DhjamTHaztbxx03hjRONFc6gxKv9sUfNQkCD3Fmg4MOJHgWRioY1j0ZzxcsyvM3Hr3aJ2jvloUIWaGW9ypDn56PvAn/pYJPSAiRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jCLrax+/; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2c+THglIYRxwvLhXuydoNDVK9bBwWuiWWAw4nrRUE/N6DaUkXVjW2R+u0hUAO9ICXgNXDDhhZGsWw31nCirMtD7S6biv/xGSy696Uw8cSziDOH/n4nNM5u++0gJ1FJC0EM6vYgI1sY6VJujqNEqKHhwBU9sBa0EbyrPmHC7ZEWg99LB0kTdeueg6CNvShfQq3r8Qys5OHYspJpZA7gICbrwzIOiF3bM3gnwJJwXeoX6Al/EqwK/PlvvgRRUfl38BNvJDvK6arSj6DnFq0Q3JAGiHgiaHMI2gu5bzCaXV8k3IB2iFkoQpl54e6gwoe0rCf/j2g3WO1tLI6djI5mFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJLOT2sAvN0746YVNigkt+QCTO8bHAejtmZ/PA01SAc=;
 b=f99/WNrxj5hmpHhV6xc/vVoUg/aPZ2WWro8cUQaBC/nF1gFoz6gpN+HG9rvZFFzWISDfk9O41HMuYybbx7FzraM5JSzWBWDa1owTdSb5JQUmuLPtkydkvE7SrujfvmaeORFTX11GEHpta9BVl84UnHVjifACWEMd9OC8y2B1HqqF5oDhi9sEeL4XD1rcF2GdHpjnNATFPq/JNzIUhRUw/NbDlvJLFj/9wZrKz6aTbW/fzkL7Vi0+spp8KV0Sv/fXiyzk33AnfqAlpKq7qhD5+6ke8W2+FGRDRTWc674SxrnGXVsxZLW1RuhyJ5A6Y4wXFXefgr+5PzYjxw0JSTJ6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJLOT2sAvN0746YVNigkt+QCTO8bHAejtmZ/PA01SAc=;
 b=jCLrax+/flTMOWBsUPF4wT7EMiXsRw/Tb2nyQJ83nyid+crR+W9IZN+G0xRkGiRmqMxJu0KIz8LGIOvZGvRdpVlHXbvfn0qDiaym/rE/bQy3bVUMduF78n/hKpKdiq5JrdHPR/LPgx3C/fw8heIxDcwrmFqjirOtaed1pOq+GrHisQD1JvMXqEDVzmWb1ffDoucT0GgHSCMwpTUXn9PhxNQGXMbK87IIUgn3pmf88TZxVwRo+PDkaU4lHj+0Y3Z+d7ED4PYx8MwnHBUJymNtyxUy64BFU1XSpQtQweTCgpAriu9mSS+O9388/RxEH6qXzYEKKzl5Eed/0BT56jFdig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.28; Thu, 21 Aug
 2025 16:37:14 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 16:37:14 +0000
Date: Thu, 21 Aug 2025 16:37:10 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	parav@nvidia.com, netdev@vger.kernel.org, sdf@meta.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 7/7] net: devmem: allow binding on rx queues
 with same DMA devices
Message-ID: <jj67tggdc6wlotpsj2ixnk4spfdlaxbw3knd3vrbn3s7awka7y@j3gy7ciwmahz>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
 <20250820171214.3597901-9-dtatulea@nvidia.com>
 <CAHS8izOQ=G-wVo5UXPyof+U=sxB-27Rv8UBfnVkvgtoOTW7Cdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOQ=G-wVo5UXPyof+U=sxB-27Rv8UBfnVkvgtoOTW7Cdw@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d327ee-c052-4181-b75d-08dde0d0fc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2VueXJnTDNvY2Q4QlFqUXFnejNVTStRUVFsaUFYK3lOakFvMTRXNFJtZ296?=
 =?utf-8?B?OFhmcVNTMFRLa0dkdnJ2amtuZTFrVkN0WHN4TElkWkQ5WWhHUVBSRVpPZlZw?=
 =?utf-8?B?cUM4Yyt1ZmFMSHJTN3JIRXJQNERPWXVSYytPVVFqaUhZbE5GOTFCdkp6akgy?=
 =?utf-8?B?bzkzQXNKM0dmQlFZVVMzRkRzUlIzNmdRL1p5aGZlTnZXNnpteWhXRlFINEVL?=
 =?utf-8?B?L0FUMHJ0bmp0eEpWNFNWcFJRN1VXTlIxcG0xaFBlbnhJYlN2MWZCbE1vOXd3?=
 =?utf-8?B?UXk0T2ZEYjlEdk1SaTQyemUraHRKaGpmSEcrQ3BRcVJqdUhCMm1PK0RLSEFJ?=
 =?utf-8?B?ZTVGMEdnU0VwcXBsNC9VdGp0bTZhdHBZbkJPTkkwTkdWL1pQRVBwQnBsLzJQ?=
 =?utf-8?B?MkdFYXdYNG5IK0lETTZXZ01STVMya20rK2ZMWDEwZXFkZ0dDTm9HTmVVdTRq?=
 =?utf-8?B?eGNmdjF0NVhKSER0cWtwV2hsMXdYRm9aS1YyMk5WRko3VmpVNnJSRW5YSFpy?=
 =?utf-8?B?WTUrdmNtQlUyZHhscjVGVzNGK2h0QXpCSXlyMGNST0syMi96T0E4V0lKaXJ0?=
 =?utf-8?B?a1g3RlRYRld1TC9LcW03aDUxVWw4Vkk2TVZFREprbnJHS2NXVldQc0Vwamsr?=
 =?utf-8?B?RzhTNG1RTEo3dTFWaS9LWEExTSswRzNkL0hRSjA2Sy9EVU51azdIL1RJam5q?=
 =?utf-8?B?RnMzYnJ0ZEhRVnJRNkVQZnN3Z0JUbGhla21Nc3pPTGxQMCswaVFSUldkUkcz?=
 =?utf-8?B?MGdQeElqeUJzUHp6MnV3bCs3NlBZY0trQ1NuVU0xWkN0a1A0MFo2YlZVam1Z?=
 =?utf-8?B?QUI3QTNKK25BUHlxYXFvMGhMVlU4TWdleFdQZnlpNng0OUwzRHUwdTB1dmov?=
 =?utf-8?B?a01LemhnU1h0WE1ZYTF5QjM4WGhiK0R4OHMvbWVnWFQveGJyTGJZVU9BbEEv?=
 =?utf-8?B?aTJiTkVKWkpHVnpWdnVnbm90MzRxS2NEUGhZak1zRitVbngzdi9SVkFPTnF3?=
 =?utf-8?B?d0RCeXJYb0hISDh3b2tra2c4K09nVFNnbWNYQ2w4WjN6RXdlNWZGVkpOS3BP?=
 =?utf-8?B?Z3RFbm1yOUZ5WVJ4UktlMVdtN1o4TE5LYlE4dG5WZnRkRTA5dGpSRFRaei9w?=
 =?utf-8?B?anlKcE9qTzVwTnk5RWdIYkhQcWJkcDc0aTl5WE1tZ2hyYldtZ2cvZmVzMUxz?=
 =?utf-8?B?QzhIYlRmR211ZTUzWXR6YXBhOXJDRFdITlEzZ25SWVV2UVRrRU9ocGhsUEQy?=
 =?utf-8?B?S09VTzI1S20wS3Zzem94OVNaRzg2UnlPUWVob3pIdUE5ZGVYbENtSk5YZTJR?=
 =?utf-8?B?ZUhJdW92ZG1kR2M1WW1tRXFkemdKZXgzaTBySFdLQ3pPeWZtQ0QwSk1iNDVB?=
 =?utf-8?B?TDg2czZmTFp1bU9kRTNnU1pOd2VYU1hYV3JOS2F0bFQ4YmNOdEZLS2ZqVnIz?=
 =?utf-8?B?MjNPUVo1clZwVlJqNDE3dmRRaDhjeTBUWU51ZDNqS3ZBejR4eDQ4ZUdvOHNz?=
 =?utf-8?B?cGo4WjQ1K0tucHhXYnQySlVLS3NXaThxbUJyRXcvb0tIOVhoeFVlRDRyMnkv?=
 =?utf-8?B?VFFEOUpMOWhxWWlhbkdXeCthcFFEdHNlbk9ocXJneGZsdy9TcyszYkIva0hE?=
 =?utf-8?B?NTNGcXRHRC9BN0dqOE5PWldtSi9ZV0s0OWdwMmg5S05QNFNhVThOYldqa28x?=
 =?utf-8?B?L0JQOUFzTktieXQ0dEJESDJtNldsUVpBM1E2amduSmFMWkIwSmtVMFhSeGZl?=
 =?utf-8?B?UTFIcVZzbUZIaHJ2TnR3eFZjdnhsYks4MlFrR0JkZkNwNEN6cTlsQkpMRFNL?=
 =?utf-8?B?ajNOeXhkTEp0Vm9sRTlYQWplK3JpWFNTYytyL0pNVy9Wa0JuMzQrUy9oTDJ3?=
 =?utf-8?B?Y2JpdlJ1ZjIvQk1ZSmo4eWlFNnZvNHJhZ0dGMUVNYy9MRWJyRHdqZ3dGbXVZ?=
 =?utf-8?Q?wb5TqsXZjRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckIzTnJUMHFtSk1vQTl2TzJadXIvelBzSGNPWFhyTHAxQ2IyeWFmek54bjlp?=
 =?utf-8?B?RkhrTTZRamhmd296MEJUUFZ3WXZVMnl4ckdOUkF5VFlDcGxpSGROQkU3UXB3?=
 =?utf-8?B?bHl5WjBSUzF3Q1hHUEFHTjdseVV4QXJnYmNhZ2plcHBsczZLNWRxZjJqajNz?=
 =?utf-8?B?MytUb1gxTXdDSWhoaHRmQnRYRmJsU1BIcWxSNVJSVWxjZFlkWDVVZEhxUUNM?=
 =?utf-8?B?anYzUVpzeFpYM0IrSlRkNDU1NGRPK2hEbVlYdDNYZVJWMC9lcC9zdjJLRERZ?=
 =?utf-8?B?Q3JBbTRxR1MzbmY3TWp6dFNhNXZBTUdVMHF2TXRyK2J6bTE4ajlab2dQMVl4?=
 =?utf-8?B?OTJWRi8rMjM2bTBUOWZzQjhTSmtTRGJKVlVrY1lJbjdad25UdFVMQ1A2V0lV?=
 =?utf-8?B?OUMxTmdsSUNncTdlV2grT0dWUEt0TDhzTk5kbTdCRithWjlBLy9uVXN3anVV?=
 =?utf-8?B?WFc0WUgyaUpnUm51VVBwa3lGbGNaNTZnMGxBaXA1ZUVybjVDeThFczF1WEhK?=
 =?utf-8?B?ODJhR0NSWnVuZytncUdWRG8zNmpBaG5mMDRKRkZPOWh4RkY1am5lb016QmhV?=
 =?utf-8?B?NlNkcFcvTnlFR0IwU1B0MDY1WmlkVWtNd2dWNjROSllSTnJoakJVdDJMYmdH?=
 =?utf-8?B?NnYvN1h1S2hTc2krQnFmUVk0ZUJzN1hQQW94ZlFVdEtwOWlBNnJJQ2dTK0lN?=
 =?utf-8?B?Y3JHdnNFeXJUK3NlbTBsNG1CKzdnM0x2b1hWOGRFeGJhdG44bnhhTGsySDMw?=
 =?utf-8?B?Y21wZ0NPUjRSNEtKT1N6YVd3c2MxMi95bjZnUFAvNTF5VlFSUFkvTCt5VG5T?=
 =?utf-8?B?N2VmQ3NCOGUwM3lGSlQvWHUvNnNzdzFIc3lqYmIrTDF1SGM2MWVCcmJ0YTZa?=
 =?utf-8?B?MHJLSTMwUVRIN1dXSWExS1NjZCtINXo4Q0FJWW5UTkJ3bldwOS9UR291RWdj?=
 =?utf-8?B?NjIxNDdDeE5SZk4rWVFReXZOZ0FLYTdDTXVwZU9jb25uS1RQYlMyclhNekxk?=
 =?utf-8?B?VG9jUEdMTnhMZFluQ0s2b1I4RXNqSzhiZm0rRmQzZzh2blBiSXNMVWMvQmpJ?=
 =?utf-8?B?V1p5cy9VZ0pCQ1VTbk5oMnYvSnRER2IrVUxrb0hzb0hOd0NQZTFkazl3VlVG?=
 =?utf-8?B?RXJZMDE3UUIrSWtVNDBxcnJaL041QVlobGh0TXkrd3FvZ3RHRjdGRDlrR0JO?=
 =?utf-8?B?dWlFcGxKMmdncXJkQU05andVanMvMWxuTXc2OGw1aWpVL3RudXM0eGhVc0dv?=
 =?utf-8?B?Ym9jV2VXR3E5NmJRQ25JdGgvOENndDhBUFhUNkNrNGp4K2o5OTZYUmo5WC9G?=
 =?utf-8?B?ZjBSbTlvaERzYnM4WnZIckFWZXN4TElYU2pjQWRKRzZGeUtBemxDUzZtSTY2?=
 =?utf-8?B?UFhNd09wbmlES216SVcraHkxQ3FDRUw4cEJxb1hPbDU0akNGV3BYTS9sV3E5?=
 =?utf-8?B?dnVBeVNMeDJyMlFzMml2SldWUllCY1FhOHVDd3dpV2c0blhPMzM5UlZWU3dK?=
 =?utf-8?B?d0tiMndaTkg5Ujhxck5mUUZ3NkZ6bkNUVXpTM3VESU9ESzNPTnliZ2IvREF3?=
 =?utf-8?B?MFpESUN6VnFqVUJ2MTBtSXdhM0NJNU9RS0g5djZia1o1RUFBai9URitJTXRm?=
 =?utf-8?B?aDM3N3M0ZVVnWEJ1aFY2OXYzbW9iTW1jY1Evekx3WW42a2lNMXJpVWIxL1g0?=
 =?utf-8?B?VnltaEtNVGt3MVlvMTc4SHBvdEFKRWJKcEFZVFJ4eG00cmhIY3Bsb3E5SnY4?=
 =?utf-8?B?RDFFckc2TU9rZG1JTHNqWjRQQ2ppa29LMzlqT3BhVXlhSUprTTdrVm15Z2hZ?=
 =?utf-8?B?OWl6OStPRkRvVnljblZsNzFlSUR2NUFwNUR2OFFTT2k0M25TYnJuVlF6WFI0?=
 =?utf-8?B?UG9xbmlLYzhwU2twcml5VS9vSys1VXl4MGREWEZzdm45TnJaMEJCQ3NkSGgv?=
 =?utf-8?B?SWdodlhlN1lFdVJ4WEpQOTFPaGxaaTYxNFF3OHBJNTcvT2lEblFWQzFaYlZ5?=
 =?utf-8?B?NzZwRkpBcDRxaU1GS3JoMjVPL0hibnl5S2h1Ump1SkRzakREYzcrTFFBRStN?=
 =?utf-8?B?enF5aWE3UGJlaEVrVjFHWlMxd21kcHpiQ2FRVDNoQWZMUlNIWGo1V2tvbUdx?=
 =?utf-8?Q?GoXzRcTvUqnRmCRYyeXasMFxt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d327ee-c052-4181-b75d-08dde0d0fc04
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:37:14.5280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZq2CBqcJW9SUvJE4ZvLqT/KbPcDMqQ8igKn3JM5BVORpXbKC+ZdPDXyPNOyXaV1BtZk8cGDZRmGXyvl9LdWhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985

On Wed, Aug 20, 2025 at 03:57:32PM -0700, Mina Almasry wrote:
> On Wed, Aug 20, 2025 at 10:14 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > Multi-PF netdevs have queues belonging to different PFs which also means
> > different DMA devices. This means that the binding on the DMA buffer can
> > be done to the incorrect device.
> >
> > This change allows devmem binding to multiple queues only when the
> > queues have the same DMA device. Otherwise an error is returned.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >  net/core/netdev-genl.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 0df9c159e515..a8c27f636453 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -906,6 +906,33 @@ static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
> >         return 0;
> >  }
> >
> > +static struct device *netdev_nl_get_dma_dev(struct net_device *netdev,
> > +                                           unsigned long *rxq_bitmap,
> > +                                           struct netlink_ext_ack *extack)
> > +{
> > +       struct device *dma_dev = NULL;
> > +       u32 rxq_idx, prev_rxq_idx;
> > +
> > +       for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
> > +               struct device *rxq_dma_dev;
> > +
> > +               rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
> > +               /* Multi-PF netdev queues can belong to different DMA devoces.
> > +                * Block this case.
> > +                */
> > +               if (dma_dev && rxq_dma_dev != dma_dev) {
> > +                       NL_SET_ERR_MSG_FMT(extack, "Queue %u has a different dma device than queue %u",
> > +                                          rxq_idx, prev_rxq_idx);
> > +                       return ERR_PTR(-EOPNOTSUPP);
> > +               }
> > +
> > +               dma_dev = rxq_dma_dev;
> > +               prev_rxq_idx = rxq_idx;
> > +       }
> > +
> > +       return dma_dev;
> > +}
> > +
> >  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >  {
> >         struct net_devmem_dmabuf_binding *binding;
> > @@ -969,7 +996,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >         if (err)
> >                 goto err_rxq_bitmap;
> >
> > -       dma_dev = netdev_queue_get_dma_dev(netdev, 0);
> > +       dma_dev = netdev_nl_get_dma_dev(netdev, rxq_bitmap, info->extack);
> > +       if (IS_ERR(dma_dev)) {
> 
> Does this need to be IS_ERR_OR_NULL? AFAICT if all the ndos return
> NULL, then dma_dev will also be NULL, and NULL is not a valid value to
> pass to bind_dmabuf below.
>
netdev_nl_get_dma_dev() signals DMA device mismatch though EOPNOTSUPP.
That's why it is IS_ERR_OR_NULL. I find that doing this at the calling
site would be possible but less accurate.

Or did you mean something else?

Thannks,
Dragos

