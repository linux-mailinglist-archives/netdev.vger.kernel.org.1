Return-Path: <netdev+bounces-186683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC8BAA0508
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C616C3A89C2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0914A22170F;
	Tue, 29 Apr 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqyRBbbE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B031A7253
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913271; cv=fail; b=TYUg414yf0iLNCr5QR5axxYcVMlMGleeGqng4yden1e9b9NCVTpduMH05b2y+ChGrg0wP2lj5y1hMWYCQWtJXia5pPSe5xlZrWBz3+QdLqK67AVQP2AKQPV3Ut46mdPqBLMcqSY4f2zBO+o4c3XKduYkSyjO3GpJfIt2XuD0p2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913271; c=relaxed/simple;
	bh=6Lo4WmYdO9/wVyewiD6HeQymkzJ/HjJKCH0JXw9nqFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QQZLYTB9lkCfSznFZbVMzesiMnKy3y3kbpmj887rJa72njzrRTTdnVS36xbW0eWNOG8AyU3kYwWhpC/ISRgR1mle1/jAy72ZuUAFYIpeg/GkjrectwepoIZ+GFPObF/ZQBQ20mec1bLezRCbXtF/SihfpZxwsc+J9gP2L4+6SXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqyRBbbE; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAJNK91S+igZAJXzY6/B5XWfAweFByErBAXuJAaal8VLgGQtTsleR+vz6DXhkSU1Qu+DksHwTkuzIJjmODLckclw2UAXEk3QYaC2d+iS2F/oXuSDMgCVppGa6I/daOhxVjw7eiBTe2FKqljZXLWmb+8Hu6eWvVjyip7mvbkgreexm0VKvGIKTfDO9LDFFSlQIF2luO7LV03i6nZcU6DZvJq/w5/dszCd1yw/1fvEaBLwecfwBTHYh9pGD3BAEzECthwGsjo5oROkBAe3NCMD7SYalGTRcDMP9M6kaz3LNqJ83FMi358aXoS8S8/7iwGodA3oJabMhtiqX2+2De2iRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lo4WmYdO9/wVyewiD6HeQymkzJ/HjJKCH0JXw9nqFs=;
 b=iT2Tyekj9QaXXkj9a9e2dt6QKUv8Fuumilpe+ug2ndsb9HXPbkONcknX7QeRC7Db6sij8ZzeIQ2HF8fuwgI/moiuj2PZGoEeP/XAhO297YiX+UmZzHp3TM9cE3Jz4q1N535FsfRi/GlzuMv2jZDibtzt7nxbX8Dw2OqjIp8y///c01QyaGKGOVznA96XZYMlim/rKEkEQenlmeWXimDeF+l8fKYJXh4+MUT65rKHT1CRXtWBD0d4GEZV7xPYgytLY93C4s56ppANBjqBgnf32OtBxHakhp6dd6IxjpcBFxbsGbpxjMp/J5kql5ySc0chSp1fdE9Rds1ifMfe8t3OKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lo4WmYdO9/wVyewiD6HeQymkzJ/HjJKCH0JXw9nqFs=;
 b=oqyRBbbEWsPlCqNbfRtePUo+THxjpRcSc6UUaHqfQ4JWfS+OJuZ0kW4vnkUAZkEyvPUtMrq65FkfdDFDOVXCN8LTXE2tb11DUzNEAe0OA0KtlYhPyu4g/A/0Lq0mXUoK5PlhOJD+rQ8CPGAx4gSmBmfLWz16/OcozK3puWqF2yOV+6dSnOIOZpLi3LM3uW30DPLwoWvUGt8rm3l+Ige8EZ3vRcaiY1fmXt/ql2LU2fJIuD5ScBlw9W1J3x6sh0orTHXsHlFYbtTlL2SM5jI8WMNWHzmxQRNzQgDdpF7wRgwWyN4aGW3D4YoBpPLFO/o98uRjDKBuJ+X9sb0w0Q3upA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 07:54:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 07:54:27 +0000
Date: Tue, 29 Apr 2025 10:54:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	horms@kernel.org, kuniyu@amazon.com,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v2 1/3] ipv4: prefer multipath nexthop that
 matches source address
Message-ID: <aBCFp2nvK_Wnsz3-@shredder>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
 <aAujZJXqlG8VZpJF@shredder>
 <680cf54b983d5_193a06294ab@willemb.c.googlers.com.notmuch>
 <aA5px6qCjTWbHimM@shredder>
 <680fac4d8cc75_23f881294be@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680fac4d8cc75_23f881294be@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dde2d6c-8ce5-4fd5-84d5-08dd86f310a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8M+ADVx2mt5rCN4/H2Zm/RyZVkBbS6j7yjxorWuxQcYPpM5khEfLZtl3rmC?=
 =?us-ascii?Q?qdk4/R59pWeGkOVTtiMP1e8OCABSyk3zUD7E2A2wRRyvgf2bVLzQ8GoG4hAY?=
 =?us-ascii?Q?lVrt7H96dYq1QyelMf/MXKZ7Jh69cIu0o6+2GeY37sdOAvBLWWBup9A8FCIr?=
 =?us-ascii?Q?UiREpX9Gh4Lj/nPdYZUGBLLZ0QCRsQyzTSq95OFllSpJplXnIJ4FXCGjbRHR?=
 =?us-ascii?Q?gr0kMF4nlU4j3RVTNPkHPaHqSFBTPyPdMO1lEfyr44IQIflJSyMOLaJP5gYw?=
 =?us-ascii?Q?R2g7umy0U5V+ebEfhFi2wywAwDgCAh0SXdBsXQTT9QmR0hTt+LVUmYdo1JLH?=
 =?us-ascii?Q?+uSJeZrHsk21VsBvqvOjRFWQYaCFs4Du1sCfu3K3Xa8goYkbJrcuLUL9nBch?=
 =?us-ascii?Q?iVIohy1qJeJGBQqEEfhBS39BLs9PwfjloFhF4c/bw3jVmFL4sAUhg96Fb0R3?=
 =?us-ascii?Q?Dra/CSkwcEBxHD4jKFsmOOUpMtufQlgCHHnEK22r56MWUv4NMFvB2PeLnuk2?=
 =?us-ascii?Q?Ji9Fu5IYpNFbgqCYXVsReaAZg4QzqwqhqXRy0Rl54qLk5DcreTJ+NEGd0snR?=
 =?us-ascii?Q?l4489smAtvkU9IFyWbeszhIALiRRTHlYfN+B6gKokfy74tF4pFW+W2xthaat?=
 =?us-ascii?Q?+v61o38jC+2bFe2wf91anLT3fy+dlmak050mqJN2v5BQewr3nMMDS090t8zP?=
 =?us-ascii?Q?Fw8F66y04AnECsFY4sv32jOijFCCAQdDZaS4HBgOIihx8tQBpVRlH1QJvnkk?=
 =?us-ascii?Q?DVfUElkPAtXg0cHq0Ep4AsbWUj2Fm8I8dnzGvV10ylk44QlAXHRNpTz5Pw7X?=
 =?us-ascii?Q?jRqdwnrKv2Nf7hmTlz+nthSUU2f1a+s4+15caU/gioKbWsgmGnEuTMBPyYW1?=
 =?us-ascii?Q?Es9QDagCbUu/jbJFWlqlybqgHM4uWeQG4DLVbYLxO4nMRabRSHgVlKAW127L?=
 =?us-ascii?Q?SVUn3g7TEBH0eWL0X2B1uo5F4KJgoLD0op8WkTaEsTiMBPu4P/G5cpVWNtNU?=
 =?us-ascii?Q?1VdKRBaKrppRv1YGvDLcLVP76H7TeP3BKwN9w1q+lQ4SzgaHcAcbl6Pixglq?=
 =?us-ascii?Q?6YPUu/anpSTsvKnO6BtrBA3ceuiYAHXLHYZKw1XGXOxJStQ2hP1N20da5b1B?=
 =?us-ascii?Q?l1CHbI67f244sxqDHFYpgb1O1eanI7wyiNZfUUC7y1TtPyHljl2vOVFoFP/o?=
 =?us-ascii?Q?IhbTsKGWRQuzwoMU4lG6bTAljmuOp5U15G1Eq4k5OVOkvziBACi3zfqfaDF5?=
 =?us-ascii?Q?EkizjrJO/Al2DObl8U/OdxUXAs7qU6zZiai1XOZGaV/GxEvTNkFZ+3RLVzTl?=
 =?us-ascii?Q?1cinLGxcYdLUc0ok29zFutEp35LBVf1m5FuxEP3Kwhb9gN1U8Uvg+IKzNcPd?=
 =?us-ascii?Q?JifqhbRmCdu9NUndNcDK4NvtPA3FrJqNbqeDp4rIJiqkOqRZAs1DuDNNXRVC?=
 =?us-ascii?Q?8DS9WXaCo+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjvo4Aqb0qEkI7QjrK/QU1uG2/N+j8YodfuDWUjCgMExANKy2keiBYhwpw8v?=
 =?us-ascii?Q?CbjioklUbFLCAZMTleoMYJhJlxex4vY/qc+bpeHFus5OL8zyP4cvDJkImt/r?=
 =?us-ascii?Q?v2UTjbdYXSUZcvaubieuo0D7BAS4dlnzHojRvfUinj8Bqri8RZuoRn+p/e2X?=
 =?us-ascii?Q?jizXeqN25rTtbf1fyR6AK3qjWbkFrnNypdhbmAWWHt72Co+MeTn9TlIJFf0B?=
 =?us-ascii?Q?0/q0O62RR/f9B7X7RXjGIkSxBLr+YYRnOwbHHgg+G/6c9vqL8tuIPv97vX5h?=
 =?us-ascii?Q?38ij8qZ7lj0D5obXp4mqwE15YNUSLUxKZcf9WAS4Pg1OcRh+u2pWZgYAxlpb?=
 =?us-ascii?Q?OkqE0mv1W/Hg0kuntvxtXaY+RGJN2+LKXlr/nv4BaMNoeFiEy0fyFPJWo7cE?=
 =?us-ascii?Q?Old3J8zgOMc79Z5wTRZmNziCStktSldPTdxPc3Bi1wmxtUPSiwZDqkzrUY13?=
 =?us-ascii?Q?cJFUdhwiDSxFnnPgbLBOFrYF8/E0SsSg+3SfL1Yhie2bmcK03Q0xUbRB/zko?=
 =?us-ascii?Q?NSnSC+MzDED84LDMpBlikM5PzHzPicVlstF/aSZzz9mkuLUR+YduL7yF4Vu6?=
 =?us-ascii?Q?uSdQTlX9ULn1CLjF6ou9YA47PuV16BGX/9WGs3Eht82Jte2Zp3mukjFqnWbi?=
 =?us-ascii?Q?dEk9UUNZ0slOQRzLcJOM2F5wWHX2RuB+V3ckRE5c4YLchPZNQkSQacjlZWhf?=
 =?us-ascii?Q?ahNkeNjM8/Q+YsfJnEuOjZrjmu/csNqY7hJQ6Vx3+uGaxzH6oIR2RKu9K18f?=
 =?us-ascii?Q?SBWpZSVdEk7N4RfxEjaoA5vKFH7PLLMRDEIRxobo3Ox7R/vEbwuAGRYUjZfJ?=
 =?us-ascii?Q?GFgJHgMiB27SKu3Q+UV0v/3wCDx6ywPxLgWqMJC4n5yAmpjLirczF9L05OcK?=
 =?us-ascii?Q?gMAvfwTEzNIHYbl8PoznCRUvmIus+oHD2dKitWOskLjDIWKyYZM8I8coI1Jp?=
 =?us-ascii?Q?Raz08DiP8zEb3yX6dYs42XDkBCok06W9I5Y1KyJ3pXxltA4dHjEkdo76nbWN?=
 =?us-ascii?Q?7K2SUa2e8DzZ7Es+pZKDrVmpInFcm7PlXml5h2KEu59XMy7VNgNTmVrurECW?=
 =?us-ascii?Q?sGSYEoF+ZEWRMzl+mRAsPtB+SOm63uTzzynLu/KrXBDfkXjdfaoqB0JZ5C8v?=
 =?us-ascii?Q?rOPxqiHKu1ylvab8ANMkG4K1VKFTqIeBMMrmI/rPjzIcmGVzNS39LM57t9ow?=
 =?us-ascii?Q?6Q2fOSjiW5v+lD9QDFl0IUygnq4Rne9KAnyUSVD42vRJ7BRkLU0C0oiLYrdG?=
 =?us-ascii?Q?ai788NfxNGC1qKJ5jyAdAThWcSQVivbbYd2OCDuZ4sFwdRQXzIfl5BfGtIEs?=
 =?us-ascii?Q?Ao91UN+RWyEGvvjZbsgg2J99H1D9rNRTk8a6LiuLK9Mzx6i11TUUNH9tahM8?=
 =?us-ascii?Q?mpq1hi61akYyWWfQlLpMPk5rqkE6ZDiwLEIl6Vz2JFPfGMTagTjhIaBvjwhk?=
 =?us-ascii?Q?5OJYko7mc6DMjyoBcVesPVKRq7fy0rTSlczEmrQgpw6cZTWffGJo4lpjDZLB?=
 =?us-ascii?Q?F00xyg+c8XoKmU3NzRawDvF1cywcJwYrju+9wkJDV9VdDWUJKzWBnvcmVohN?=
 =?us-ascii?Q?U5jYPBTvAQo0YJh2q0eqi6BllsZD32MDoRhs1g71?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dde2d6c-8ce5-4fd5-84d5-08dd86f310a2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 07:54:27.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZjPfiTq2+I/fzEnef2CQFFQEvLijFC0wCEjlI585SpZv/Gv9sRpXLUjZKvI8HDx2WjXRHIuNptW31132aTnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

On Mon, Apr 28, 2025 at 12:26:53PM -0400, Willem de Bruijn wrote:
> Do you want to send the follow up to net-next once the series
> lands there?

OK, I can do that.

