Return-Path: <netdev+bounces-206993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9599B051D3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 08:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2197B1AA0949
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1026C3BF;
	Tue, 15 Jul 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jfNxVFFK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266526A0EB
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561143; cv=fail; b=Q4ePjvnXslULY22M9OtPXJnRBR4qNiIaHIf6qx5SEiHdwnDKflKGDGDlHKzkzbjmfhWlyR9Dcgjsc7qnKAnRP2xP25hcyPah9fjfGKnqJFMajBzSqKzDffP+3N5d11LZLsLKxBgVFSgKPa7kRKL9Bu4lGdnZx7nA7fGlAe54YTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561143; c=relaxed/simple;
	bh=LaR88HEZ54rt5/NSvHJmvR20v5wIAdodV/bQrs6nHos=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SSukscP2Y/7QtTmJ35+DB1QuqDSqYika7Vs2u/xMzS0yQxxV5XmBj71Uwwxn3U9vIjN1QZLUKtxd59pPFtlh8kNou1/kvfRC/Xfq20wM7G9UX6j6Il/SxjKqKmdyAt/4SEaY0M+GR9FEG0VilThaDmXlIbgs91NkvDmPqOqn354=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jfNxVFFK; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaX9t7bqZQsyiOLJq0iOcnbMCKIuvNiLIZcVNl10+/Y8P9+wG6a3gP6SHgmzElZGwMuETsdmw+UK44najHIzSJY/Dyo37PR+uHjv1R5BgMhES9jHc01SC81vXlxihvsfrTqxDaa7VZaRshua9TgcTTcOGGN5IH7yKbOTkFLW7LVw8LdUK3aR9hlQlZKGlLu57Ql/vHQw8lC2Z42VU4/NtDY0sZNMiChYgR8n0i+9S5NC6zJbdvnsjdd+QTwDHVaVECEh5x4NpbmjXYqO/w4gC+wbj/Mc8wLKeiYuL/8E+FQPLhLph2rSGU3IaEpoQZ7qcQtiYI/qg8xk2y7b8QsazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEtsu45mq8YUTFTc+9FEH/Q9KKCy00eghTYXdPioCxw=;
 b=FzikzPBvokovRzuqYutaWFF4jU3kR8uZR96dTIr+0oPyo8ulPFl93evHYXvFt1smrWDY6eoAky78zWslJmCQ5wD+pv6lXsvNR6VAf6m7T5g3t1yZLH3VcIhd0AQRnNOJuLNC54AAp5182BOb/IQd9PwQ8QdPy/JyQpvDUUx0z3lK1/dqXNgDCrD9C9dipe5CSlb/9hGCQ8JTkh36HmDil9lGT2HfY7T9GwmOfm5K3uZm9oMGd9aRM2Voez9AODCWHLAo8u31harKc0+bQtMLkQ4BRYc1p2n2kb6P9/OdGvuesGnMT134lAnnmT3Kshzq0Xk+38BfKFe/VJEyppqrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEtsu45mq8YUTFTc+9FEH/Q9KKCy00eghTYXdPioCxw=;
 b=jfNxVFFKdJXKH+FscydmIvD333q481J4twKXjvkWIchYx4NVFK4sNos1sMabrb3UC2D17y3iPdgMvkukPtvrWp/EEnSexMboWXgl0TVADjUbkUnsiFqv3ih1SXw6T+nK4Xcuc+zqxhimPqXjmBSoHc/B0yVwucqR1kyCbzLOpfFe1MP9FE3wTYpLGnLsUvi42OfbkB7sKIAcrq7YIuEGQh5tfXbrFbmJDJ14U0M9RYOIsYoohWF+1OoraFL6/u3eyA6dYL+CQTRdGknVNp5SK8ID2ebeWtiMZJPeSvig1n0vhaipSCNc1bsLygnh4KOKab6740L5Bz8ScbFIyYdFNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:32:14 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 06:32:14 +0000
Message-ID: <5b407dd1-6a02-44f0-8fcf-5f3786c1ffbb@nvidia.com>
Date: Tue, 15 Jul 2025 09:32:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/11] ethtool: rss: support setting hfunc via
 Netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-6-kuba@kernel.org>
 <5686fbfb-4e47-48fd-93f9-25443aeb1d89@nvidia.com>
 <20250714092139.7862e752@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714092139.7862e752@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbd71e7-85c4-4d22-fe4a-08ddc369565e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rld5cHcyRnZqV3lTU1lZaHBNR2V2N3M3bjZtS0dQdzU5YkZrRE5zTTFZcSt6?=
 =?utf-8?B?LzY5c2Q1V01NeU1BS1FHLzZNNk5iZURLK0YxRTViUUVpWlp5RkxDcDRadGJ0?=
 =?utf-8?B?SmFyUlU1UndZY2RzS25RMWw4ZGIzZGR5VDhtZDFKejF0aHRDKy9ob0ZsdUNq?=
 =?utf-8?B?YzU3RnplK2k3azZVa0hZZ1VsYW9oelA5b3JaYXRZNEJXQjA0S0lxcjF0NTls?=
 =?utf-8?B?SlJZY0t1bHRjQnZMNjMzdDF0TkxIcEJkdVdEa1Y1Y0tCTUdZaUw0Z0dkNWU4?=
 =?utf-8?B?SjB3bWJzK3pWZWlaZFpsZUtmOTJUdzV5WjN0RmFOSWJQMFU2aDY1bElNb01t?=
 =?utf-8?B?QU5aTUp5MkNZQUxkZUtRd0cxR1FuY3lraFNJci9Ec09XS29vTERVc3VqUUZ1?=
 =?utf-8?B?NkEvRVpwZGM3Uk9FZ2d0aFBvK09TenJJQ2ptWXNkM3JSOVg5ZG81TVdlYnZE?=
 =?utf-8?B?YWw4KzNOTHFKTS9aUWI0eEZPWFJZbk5SeE40ck9pL3lYVXMzUTBaNm1pemtr?=
 =?utf-8?B?aGRwN3N0RS9MUWxxSzV4enVxbFRjSm54RnFxTk1kTlJpMHhSU1Nya0ZlQ1Nh?=
 =?utf-8?B?Y0k2bHVOVFFxSWtJTTQ1NkhDeittRTArZ05BTWtDaFI0WjR3a1BWT2ZQa3dH?=
 =?utf-8?B?YjRxaHJHR3p6bGdLd1FGbjAvVkNmMTFpVlBGRU4zSWV1RXowYkF1ZlRwdkdR?=
 =?utf-8?B?WkZWbmkzL1h2UENEVFhtSE9PNUlVc3pOWFUzVmR6WkNlN3NWd0dHVlNOaGVo?=
 =?utf-8?B?cU1uZlBwdVMyQWJYcVVnTFVxajQ2dXNvWlVvL293cDlqMHdVZktEckFnL0wx?=
 =?utf-8?B?ellZaE93YmNuSVRwQ3FROTZtY0liblBabGRxWEtLOU9lZ29TdHVFT25JbnVY?=
 =?utf-8?B?N2dOOXhFc0FFM3g2RFZBaU42Z3djN3c2MVdldG1iTXF0WlZMbVVWaDVLMklh?=
 =?utf-8?B?WnlDbzJiM2R5VVFjOGRkTjBBR2FxOTk2Uks5N01NVndvVUgrN2NsL1pKQTRN?=
 =?utf-8?B?eTRvQmVMeUhkTW9INmhwRG5aanhVT3h1RU9IRW9uMXo0Wk9uemdhNGp0cTFv?=
 =?utf-8?B?K1NoMVRjOWNtRm1DY3RKcDNjV2JlUkQ1YWt6cHEyeThvNEE3NUwrdDBDYXMy?=
 =?utf-8?B?RS9GVkhnYk1leVFCeVg1SnYrTVhaVEZIVmY0NEVqY2pBNzkzNm9WUnBwWWdv?=
 =?utf-8?B?aHp3RkdEakZzTWI5Y0VlT0JBVzZkZExGMklWaTFxNzdMQzI2N0t5WTFuOGR5?=
 =?utf-8?B?bFNVYTRCWXlVSmhqeTA3dmVmbnVucVNSeGN0V3kzUEFiS0ZhT3lnUFM3cTIz?=
 =?utf-8?B?Yjk5a0FuZ1JNdFBnL01ZeE94Vnd2ZDcvZGlyNnI0RkFEZWpLSzZNMEVlNVF5?=
 =?utf-8?B?M09jSDVjQUZ2MTk0TDlOWVU3a3ZYVVhJN29RcVUvRGMydVFzaWxiNzNYTks2?=
 =?utf-8?B?SlFlT2RKRVVsTmdYNEZON0pjMEFCTUQrRzhrLzJwZ3ArckFrMnRXT0xVWmQx?=
 =?utf-8?B?VmZybGZUcGdiU1IvWkx0RXBQQ0JoazVrUTdESEZ5TGl1MW9vSHBucjczVkM2?=
 =?utf-8?B?U2d0d0hIZk1jemNWZno0b05zR0RpWnB2NWliRWQrWmE5YUFEOVhGcmYwMEw0?=
 =?utf-8?B?SUJsbGJrdkFYUld1dC8yMHh5TU9XVERHMk5rZ1YrdTR3TDlqMlIyODRIYnNW?=
 =?utf-8?B?cjVWWmJpaTAzdnViWE85eThlMWdwdGJidDl6NEl5VGM5YVoyRjlmWFNwbTl5?=
 =?utf-8?B?SDVQUEhlRUdDdXZHbXpxaERrMnBGTCs2VEJ6cnFiNTZYV3dlZVhVNXVzMHR6?=
 =?utf-8?B?WmdNdU9sN1lSeUVzT2hsZGx1dStZOU5GdFQrS0toWlNGUmJmNjNDZWlOK3NE?=
 =?utf-8?B?NE1rK05vK3p3ZkNDWVRiRktxTXUvbUVGWWtnTkZJTEJwZDFPWEJJSzZFMHAr?=
 =?utf-8?Q?rm6OD3xPFRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUREazBER2NiWDdTell6MXUvNlpsWXFuTHRncTBDMVdLVXl5S1M0bjlzb1JD?=
 =?utf-8?B?aHdRUzRXam9nMitKQXUyZ2piV3NwUGtTcGFBWnNvdEM2ak5ZT1E4QytWZnlM?=
 =?utf-8?B?d1hiblg3RnJnZVNFUWJ6RFJpeUFBSHRBTW12NysvS05OUWxJejJXbEkyTEhV?=
 =?utf-8?B?TVNqQWFwdVJuTm13bFd1ZHhjTHgvS1JyTENLb29Kd1JvVVM1cnc2ZlJMSWMy?=
 =?utf-8?B?dnZpdVN5V21BYkJWU29vZWFaY2REQU1KWnlLRTN4Nmhwczg0bzdueVBzK3ly?=
 =?utf-8?B?STQ3TzZHU09Gb1ZzaUZIRUl1ZUF1ZksvMmt2QTJ4MXI5eXdTaGpqZzBBcW83?=
 =?utf-8?B?VFdSOVBCbTZvZGRyTUMzY2I2MkVjaHlCNStGb1BQUTF5dlM2eWU2aWdkTFdx?=
 =?utf-8?B?UER4Zlk2T09JUktrK3BvTHBkTFZyam05OHpuQzlEMVVjRnkxUFFIcG93TXFx?=
 =?utf-8?B?YlRSek5yS2FubUYvQlNSTS8xZ1lHeTZpanpyRWI3YjFMd0FvK3U2S1h3SUlz?=
 =?utf-8?B?bUlITHhjQ1pHMDltQWtETjgwNjV0L1dEcUFndHJHTk1uazZEc1U0aGg2NWZX?=
 =?utf-8?B?TXJVM0lvNkh5WTZZMWt1d2pFeU44eFZuSnoyRVMyQTF2TktaM3B2T2NBOFFs?=
 =?utf-8?B?cWdtc2cxemw5aVNOOE1PM0pYQWwzYm9tUlZyck9nVG9SU2VXL3QyNVV1ZUhZ?=
 =?utf-8?B?aUQyN3dxK1Y1TzRKUGlLTUJqa0hJQnpRNWtJUm9sTGd2eklBMFM4Mk9uVW10?=
 =?utf-8?B?T2wrVW5kWEpnRytETUhJMlJCWTJ1RDFWTThMVnYwaXdWM0RhUUFRcStZeWhy?=
 =?utf-8?B?VmNWVVJPb1BQRTBPUFNrNDB0SVkrM0ZsSUxCZFdOSXZwblBncGQvMlJ5N25u?=
 =?utf-8?B?bVVnWVpnaVQxL2NNbkYwYWNHc3JLV1EybTZaK01qTWRyUkIwbEFUVjh0ckJJ?=
 =?utf-8?B?ZVp4SkpSYWg2Vldnakl5cHQzbmtGa0V1ZlMwckxLVFVVZVpJRWdzMWlGNGhh?=
 =?utf-8?B?Y2hSbGczeEpCZmdXdnRySk1hUWFPbFhicko0QTlaK1d3bTYzaHRxRStoUXNw?=
 =?utf-8?B?RjBVTEdUazN1VERQNm5IQStrSU9sTkdpK2p1eGsraU5hZUlMZlNHVDlncCsw?=
 =?utf-8?B?aXlzTnZPWXloTnhIbWJ2VlN6RzNHVnExdnhSMmJTNzhLZlkvdWk2VVZJaXdt?=
 =?utf-8?B?am5JOWlNclpuNUFSbVFFcnJEVGNiVTN3ODFUa0FBSDgxTVFtbEswaVpjNEV1?=
 =?utf-8?B?QTJJQ0tWN2ZkVjdqR291T1RFVW5GZDFyRHA1VDEvQkhJN1pNcWd3SGIvZURO?=
 =?utf-8?B?YUxFT3ZodUxia1NITXhwSDRGOU54dnZpZEVnWTJ1RDkzempET05jMG1yZDVY?=
 =?utf-8?B?WHZWVGdBRG84NzVaVFkwMXFhMkFlYld0OVFtd0V0ODA1eVd3M21WdEJKd2l2?=
 =?utf-8?B?WHhKdFpPQ2RadGZtWG5VbjVDSHhuM1ZxL0ZjQjhUVlFnS2huK0M3UkFpWnRH?=
 =?utf-8?B?ajY4bEtWSDY4SG1kVWFpWUZ2U0Y0cFFVNkxhNko3MUJJMVZqOGVVU241ODlJ?=
 =?utf-8?B?Tkg0anFZZDdnOEtMQlh2c1VBMFVCOUhKdXROQzBkY253blVsZDlCdkZLWkMx?=
 =?utf-8?B?R2UzVmFQMWtkYmdQWFFaYm9rejZuOUpyNzRsdUNadGFzQ1dIcy8yY1BLV2Nu?=
 =?utf-8?B?bzM2SUFUY2ZNS0NtMzhpTzBHeUo3T2ozWlpSRVpUMXBCclBqVU54NGpRUXBz?=
 =?utf-8?B?d1pWTEdQa2oxNjc1S0lDYVlkY3JmNHBJQ0REOGczbSt3bmQ3MXFDR3FoOU9r?=
 =?utf-8?B?NFFYTWE3SjhOZjRKeDNGNzRORUcwalN1bFd1b1pOVFJoaG0vTGZIRkxOeSt0?=
 =?utf-8?B?QzZkWms2R21OSXB2U2xKRHFRNjlXRE81TkxiWTJtSVZqRXYwWjZnT2U2VGF4?=
 =?utf-8?B?K3NsSnlQSVZ1UVVuVEN3eHhtckVUa0hrQlFpU2ptRVMrall0MVpiRHcwUldQ?=
 =?utf-8?B?TmtIKzJxQ0czcnFaTUhKTWpMZ0Y4a0VoS3dwNHpBSEppQVdFZms1OTdGZkJ0?=
 =?utf-8?B?c0pzcEg4OWZHRGp2QjU5RDYyTUVBRDNDQVROZDR4bTBNNDQrRzY1TUh5Y3Vq?=
 =?utf-8?Q?46Y4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbd71e7-85c4-4d22-fe4a-08ddc369565e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:32:14.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcHYGkT6fkAAG9cNJ/zB4s5TRqrOynxA/0tdBO+RXE3DiE7gH5nSZB6DDyRqbL0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843

On 14/07/2025 19:21, Jakub Kicinski wrote:
> On Sun, 13 Jul 2025 14:10:20 +0300 Gal Pressman wrote:
>>> @@ -617,7 +623,11 @@ ethnl_rss_set(struct ethnl_req_info *req_info, struct genl_info *info)
>>>  		goto exit_clean_data;
>>>  	mod |= indir_mod;
>>>  
>>> -	rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;
>>> +	rxfh.hfunc = data.hfunc;  
>>
>> What is this for?
> 
> WDYM? data is filled in by the GET handler. So we init rxfh.hfunc
> to what driver returned from GET.
> 
>>> +	ethnl_update_u8(&rxfh.hfunc, tb[ETHTOOL_A_RSS_HFUNC], &mod);
>>> +	if (rxfh.hfunc == data.hfunc)
>>> +		rxfh.hfunc = ETH_RSS_HASH_NO_CHANGE;  
>>
>> I think that this is a distinction that we don't currently make in the
>> drivers/ioctl flow.
>>
>> NO_CHANGE was specifically used for cases where the user didn't specify
>> a parameter, not for cases where the request is equal to the configured one.
>> mlx5 for example, performs this check internally because it can't rely
>> on NO_CHANGE for requested == configured.
> 
> Yeah, no strong preference. We have to live with the ioctl path so 
> the drivers will need to keep handling all corner cases. In this case 
> I chose behaving somewhat consistently with the ioctl behavior (assuming
> user space is well behaved). 

There's no harm in passing NO_CHANGE in such cases, but it is not
something that the driver developers will be able to rely on. There's a
certain risk of someone assuming ioctl will behave the same.

