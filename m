Return-Path: <netdev+bounces-206994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17764B051D4
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 08:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAB57A14AC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731DC25D1EE;
	Tue, 15 Jul 2025 06:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K6LIfz5g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3828B672
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561230; cv=fail; b=UgTdjWCqRK+Do1nUw9zmC8QU+T9WurxhNvrQo/Se2nyFkS1qiH6C4seHhwtX6qY3CVyEF4HAkOxPEjHkWF/xQ91C1hEdNaKAsZ0RU0f1bjObZUGV8d6aPs1r2uZSqwHWzsHBs/+6pnM5tq96wGsXRr5XjOBveUYKwBTDo6wBMf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561230; c=relaxed/simple;
	bh=WCkaGb3pS9dEIBfuNoz5inXgSvfckXcUezCjhCJDkg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lek7cY5/3v8kelsAJcbrlIzlLa0hJA+1hLyHQbs5H/vgVDnJZZ6IY1vpzdCx4jpwJtaWfGtC89tjXDNOS6nmfi92TnXuaVuoQKAhZQNCGbQb4xLOLtSvX4FDiLRfuvZbxAddHqd8pEQFDw3QYxunEFLpqbGSu8XwPfP9ZMdEYWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K6LIfz5g; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBrFsFQQaLR7qnOOiPZqkyJQdFMKWgaL9Ida2zTZAi9BbQqt9SK8B+Ih5+UYO5N3hy/S5lZ4jjcQZfVncC8QO6lvm8B0N6ByVAERryeCtANPngKjugkOVt9wBj7A9xn55YyVo9prDBDS0oHG+KOv8x3LsQAQwysEaVG8dJ70xrTPpX2bn+kYn6U0PPIRSEEgAUWQ06sDNFjnKsgkzWYQ6om/SXYOmyY3cMGzKvn8Nhriw10+sudJL/2nL1Jo4XYp8pPamUrBcOztBqlRNrj4tZSRlOHZIXlXxmIAdwS3/ksKhD1BifYfmwU63RY1VUbeTNnR0Y6NV4ks+zKw6AmEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2wnwuX8jJA821xOg/DjVzCUaA7CtN7UCIdYlJzdaa0=;
 b=f5JTfRCwaWeN9I2Ig2iyjCaABLh/mXnh2QO3LmnLDxEOiGI/EqB7ZHnEJwnX+nuOMofo0kNe883TvxYCY1QljOZw9ojBPe8OkS/mP1IF/zB5P2R8zo0ThR4sjrTUImIs6arV2GdQBqu0GQVEcl4SGIPMjnF781dJii+Vxx2Kq1DnUY56BbW337LWlTgOTWqlVwc9dyhtPGSn6NjUqDX/Ij6MNSpgMMA7776u+PhesqoJ6IVXm8ucHd4pcjNLYqoFm63rZ/avqU7jX7wjqAjpUeZs+yRcJ+Ov40yqWHE+CyMmrjKOSeWe6fMTH3jp6z4LeolUf9BYrSUoLmvFmitVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2wnwuX8jJA821xOg/DjVzCUaA7CtN7UCIdYlJzdaa0=;
 b=K6LIfz5grdMwyAQm9cEhP5pZSJNWXtM1K+0wnBI4xcTeTAzA7ZsfwD4dcNlknBCtfACdj2wyfuTNsRLAto93OH9358Xp9gTOoXahyMzKrbnqC/x5lkklT73H33wqcomoZKWupqPMjAnFjcLt+K2K03kURLOs0xFNh1TWoghs248kaojYlzqz8K0M5AJG87cDQYf4TijKbZk8pXU0Lu89Tx4nyEz81Dqi61xkZZsct5c/B6nnL3bGEO4EWZeV7KysWGQHrgpn0Ff6TblB9JN3ZhBj2zZjbd+viHHZ9NkjfhrA+uO9h2pmqNn5XziaUwPL5dPcF+rib54RcFPgkIXwMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:33:46 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 06:33:45 +0000
Message-ID: <7f9b4414-a972-4256-953e-103e3055276b@nvidia.com>
Date: Tue, 15 Jul 2025 09:33:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/11] ethtool: rss: support RSS_SET via Netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <24aa8c69-89bb-440c-8d63-79d630800c88@nvidia.com>
 <20250714093537.438fc6fa@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250714093537.438fc6fa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c15e5f9-0456-4ef7-f5a8-08ddc3698cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm9TRWtYdjlvWm5uOFdBMGI4ekdoMmJJVE04aDFhTGk2Y2xtbXVkZnJYNzY2?=
 =?utf-8?B?ZnZCN2FldWdKQm5PV2tidlVsUEphMU9oTGFaSktxN3JyY3g0TnE1cGVLOVNw?=
 =?utf-8?B?dE1mN0dtblhOSFN6cTNwZXZ2dG5mRUlIejBKajVtK29TY0xCM3dSSGs2WFZm?=
 =?utf-8?B?YmRKUG04OGdJUFV4a01kaEIySk1RS3grbTF2VXpkK1lsTndmUlJsQXF6dzY3?=
 =?utf-8?B?OWovM1h0ck9vcHJNOHhEMDhENmRXUGVTZHdCMHFGM1pYT3hiQ3haMU1pVGVp?=
 =?utf-8?B?Sm1UeFBjdktQQUxuSWtvNU5qVWdKTlB6d3BIb0IzQ1VmMU84SVM2T0FmL2J0?=
 =?utf-8?B?RDFKaFpZT1pheHJuUVVrdXFMVzdPWTJiYWgvQm1kZTBwRlFFUWR5VFJoTyt3?=
 =?utf-8?B?ZEFJcjhud0pCcTNwWFdldUplVXZIOXlLR2VpbkJVa21XQXIzQlZpaDMyN1U5?=
 =?utf-8?B?M0JtTWVBZkpqRDd6RERkSk15M2FmNTlOMkNxM1dGcU9udWUxMnliYlhDY3Zv?=
 =?utf-8?B?VklrcXd0ZDhDUEhndW1KaVQxM3ZiNFNEZXBkT2dmazc2c1BKL05EUmE4c1h2?=
 =?utf-8?B?dXEvU0h4dkxIdVRsVUlNdnpyQmtNOXBQTnY0a1QrZW96RVFzbTBRVGpKSHlZ?=
 =?utf-8?B?SFRnWG1lU0hnVGoyb1VUVGkxRmc2ZFBsaTlKTzJWVWNhcG5XVkppZUdqVjB3?=
 =?utf-8?B?L0UrN0NvYW1PRy9LOG81OXRKa3JzbXlBN3ZBVkFTWlk1cVNCL05Dc1hyeE9Z?=
 =?utf-8?B?cENCb09ybDdHZkx6alpuZVQxUXAvdktleklKSm56MU9aeG9qY0VXRmdMeWg2?=
 =?utf-8?B?bThWamNIbFRaWGtkaUhlY0tFQ0RJSlhWVWVmeS9sWTl5RHZvSjMzdnVXM0NR?=
 =?utf-8?B?OFZrdU5KN2xiVFgvZlJPR2hWcVZ3MzAxRTFxdWdIT2oyNW9FY0UvQXFjRVp5?=
 =?utf-8?B?ZUR6aG9yUFFJbVVDdjlMZ3lHWjlsVUcvOXczYWpWVXFyamNEcDZ1ZElxL2FT?=
 =?utf-8?B?eUlsNUk3M0d4YlMrWHh5em9KekJBWlR0QXFIa1I2QTY2Z2IzbUtLclVDeTRU?=
 =?utf-8?B?ZHc0OGdmYkFOeTBEUDZVRGRYWmhkK1diUmpUTXJ6dVhJL1hrWGwvZ3dmd2ZN?=
 =?utf-8?B?dDJqc0ZyM3B6c1lPL0RIdWpQRnBBK0NKWTZxODFkbEwrNkxiN0V6WlRPQjY5?=
 =?utf-8?B?LzdHNDRyWXcrTDNqc3RWdmRJOXVKZURobnRPSUhUNC9WK2V2dk01VGlOckFG?=
 =?utf-8?B?UURlTU5rR3JYV005Y3BUUVU5blpLS2VjdTFxTzdkZU5nVDJRd0tuU2pleThI?=
 =?utf-8?B?ZmJrU3VpTEFHSW1kcFJLSDZOdWg0R2pObkRVMjc0d2NyVWNEc0pHSWpCUHNi?=
 =?utf-8?B?d1ZPOEY5dDRDODFlYXE3Qk80WGdiTEJVbTJvdSs2bzZpL2dYc0pCd0tMOU9p?=
 =?utf-8?B?MDlMNDltamZMWEwvdzZpUlA3allWT1k1N0NBWFlORGhxaDNHTXZyZ1hOWERi?=
 =?utf-8?B?S0E3Qks2T1lXYm90ZFlva2tmYUpqYnY1VXlBSGdmYVViMnNVdE00ald3aWxE?=
 =?utf-8?B?Z0tYT2RvWXRvMTVZbFcxZHlJK3RSKzdFd045MTMvTHBaM1R5WWFIZndVTnBo?=
 =?utf-8?B?SEZ1UlFtdHQ1Nk4xU2VtV1pKYWJYVlIzNytBVlN0RGxRdXBGSnNLbHlYWEhD?=
 =?utf-8?B?eHRPMXRNWXozV2VTS0Ztb0VnS01CdXlPemJpSU1tUzZUODN5eGJYMDBpYVRO?=
 =?utf-8?B?MHk5K2RWdlpVRUg1REVFb3BBZG11VTdiYXVDMXQ0UUV6Vk9kNFZrOXMwcFlw?=
 =?utf-8?B?WUJiczBSS1Q5MkJVU3hmS0pSTktiME1FdUJ4YmhVOHhVdjYvWmpocHZ0YVRi?=
 =?utf-8?B?MVRUSU53ekFvLzJZNDl4Sk1tQ0pZc0lFcUZRdzBWamI2cVIvZFpGSlplcFMr?=
 =?utf-8?Q?WzodAp5Xrus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEh4VmVQRWxVT1p6bGE3ejA1a1EvYUhqQ3B6U0NFZERpVlNaU0VqQWRIYVFX?=
 =?utf-8?B?azVaWFZnbGJqbVdTRmViNG5OZG9SaUtTS1pRM2U4NnJqaFZFMkpxaHhEdk8v?=
 =?utf-8?B?NmViRWVpdjNpTzdwQ0tvOG9oV0JrZ1dwaXRQN0ptek1IUXZqU0R3M3FwRFJZ?=
 =?utf-8?B?ZWNCelRoUFBITkZaRytzc2Frb053WW1jNHhiaHg3L1VLVjVkbVhRVDRWb0VL?=
 =?utf-8?B?TS9QQytURU4vVForS05sdVM3R1g4ZG90c0JsR1RCZ2JRQjE0SjVmOER6ZG8y?=
 =?utf-8?B?MEJaekkxVG43cFpOUWlWT1ZKZUFiVkJPYitCdStUMEFEYk5ZTzNtaWdvb01j?=
 =?utf-8?B?NzNzY0xJQzZkN08yM0pNYjQvbU1sb240Yjc2SzZXa0t4ZXhmMUNUOUIwYkkx?=
 =?utf-8?B?azFQdnRzeWFPY3BaQWVpMUYya0ZwSVRwZW9vcURtNSthaHZqNHVhblhIK28z?=
 =?utf-8?B?YVZZNi9MWi9meC9kSVRFWm1UZ3kreEVldUJBTzAxVWVPZ2hWdTBkNXRQR2FH?=
 =?utf-8?B?eDJtSlZtZCs4RjFXN1lyR0xMUnRGVllJK2o4UVZOUFpnb2VEdkNSaUV6NjNG?=
 =?utf-8?B?YjZkRkpSbnMrc2pTdnl0bVlqd0Y3c0NtVGVCQ2tDYzlLUzA4VEpCVERuWTNW?=
 =?utf-8?B?aDdMK04vMzNqQ1A0WGtjNWlSS1JUSzhjbWpRb2R3LzYyZldMVm0vdzkwMHdO?=
 =?utf-8?B?ZC9KYnNBd2Q0VktaQi9ya3c0a0hVbnlwVVBQb2pMYWtZUld1N1QyblJKTEd5?=
 =?utf-8?B?d1ZvK1dKaFlpOFAyK3JVdmlNMTdCWExhWlNQL0xWczhwOGwydjZ3SHpyaGNy?=
 =?utf-8?B?MVU2a0RGZ0VpVlNJNDhFUlRIdmRvMjJMTktaQ1FjUHExYk5TYkJLaFd2YnBi?=
 =?utf-8?B?bmYrSlQxcHZCTWFoeFkxb2dPR0Nyd3NqMVRPM3REbTZjMG9Qc0hGYlJqYUkz?=
 =?utf-8?B?bldxNE9yekZnaXU3RTlsWTcyQVFOMTQ3WG9KanhVd24ySmp1K0lLK2NjMGdh?=
 =?utf-8?B?M25naTBRZGdVb3lXbjlicmZvTWN1U1Y4bWZDNTRhK1RFY1pMSWtKdTdPdmlL?=
 =?utf-8?B?NTc2UGJIYkpJTktMZ0NPc2VFb3AzZUsxK1h5TW5adE9LMkJ2NkdhYVF2ektV?=
 =?utf-8?B?WXNKQmFPckVaajBrb1dVaTMvc0o1VGx6ckxSTWErRVk5ejVWUFpuUGM4M1Rm?=
 =?utf-8?B?Ukw5aFp5UXZ4ODhFTHd5NzhDSnpTcStBa1JneStqMEFBUlVTM055V1UvL1Mz?=
 =?utf-8?B?VHlkK2xSL1h6ZjZUWkJkdm5tc0U2UVpOUXdGN21OSHNWcThiUkx5VytBcXEw?=
 =?utf-8?B?d3g5RVpBNGJaRlNkbTUwZ1dlbkoxNGx2bGJRZ2M0NndLcWlvcm8wckNUcVhs?=
 =?utf-8?B?V0czWlRKdzJOYStxdVBKUk9HQnpLSVNNTGdpL3JlQ0pOQkZYais0b1RrWmtB?=
 =?utf-8?B?eFZGTlhTRGxvM1JIU2xDc0lCcUZWKzRpS0hSMWk4YXFtc1VIZ0lyODdiWk5M?=
 =?utf-8?B?dUFDY3VqM1Y5ZjkzRFJzcnI1NVl3MjBoTmM4OHlYcjNTMTB3SklGb0lDcWxs?=
 =?utf-8?B?aUpORksxeHgrNHkwSXNoWHNmbkIzWlNvTjRkT0YvNmRhUEdyMWlZQnBvZ2lF?=
 =?utf-8?B?TDIyS3V1Vzk5NjZUL2ZKR0d1Smw2ZStiY00zUGpPZjVRRGgwL1UzNkFwVkRm?=
 =?utf-8?B?RzFLcXpYVkRwRlRPTkRhYjlwSTN1Z2hJQTkzOVVsdnJlQ01YOUthb2ZYdHFX?=
 =?utf-8?B?Z3dZdjN4VC8vM0pQQS9PdThUcmJaSXdzQzhwUVd3RTB3RWdQZFJtUWg3a3dL?=
 =?utf-8?B?bTlYcURyVE52Qk9UOXBNY1ZuRXcrNXN3d0lzdzQ0V3dtL0JiUUo3RjZhQnpy?=
 =?utf-8?B?N0RTQkcrNUprOHh2aWtRR3RIVlZWTFRveW5RRld5QnR6clp4VjdyeXVENzlX?=
 =?utf-8?B?NXF0L3E3aDJKRE90QzlDSFRlZkppT0RzVWFxNEZrTXpVdklONElSNHgvNVNR?=
 =?utf-8?B?WU53SWErTEwySWJUMEVkV1JXZXNyL3lYeDJDY3VVUmE1YWpadFZETnhTZHFi?=
 =?utf-8?B?endJUVBiM05VeThvMXRZb2VwTnJud25RSWorV2R4Uit0d2daY2M3T0UrenVD?=
 =?utf-8?Q?eHSd04B4uNCkxzD0WIc3f7bJo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c15e5f9-0456-4ef7-f5a8-08ddc3698cb1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:33:45.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vvn1rG+WJjAZ9Wm8ZUN6OEpCL7soRt8wdAaMOk8ByfA+SXVECcTsOw4oK/YLUsg8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843

On 14/07/2025 19:35, Jakub Kicinski wrote:
> On Sun, 13 Jul 2025 14:06:25 +0300 Gal Pressman wrote:
>> On 11/07/2025 4:52, Jakub Kicinski wrote:
>>> Support configuring RSS settings via Netlink.
>>> Creating and removing contexts remains for the following series.  
>>
>> I was also working on this, but admittedly your version looks better.
> 
> Oh, sorry :S
> 
>> Given the fact that this is not "feature complete" compared to the ioctl
>> interface, isn't it considered a degradation from the user's perspective?
>>
>> New userspace ethtool will choose the netlink path and some of the
>> functionality will be lost. I assume rss_ctx.py fails?
> 
> I'm planning / hoping to get all of the functionality implemented
> before the merge window.

Are you also working on the userspace part?

