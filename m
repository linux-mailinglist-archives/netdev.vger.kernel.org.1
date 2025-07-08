Return-Path: <netdev+bounces-205002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7400CAFCD7E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9253956788B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D52E03F3;
	Tue,  8 Jul 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D7BrC3Xq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142621CFF7;
	Tue,  8 Jul 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984625; cv=fail; b=E0Q5t0+vtKWQKuxj8MFj5wouz1O0SgixK53fGNHskys4A2CV9W/Wgxy7I77wKEUa+6GW57YwlhxqNTXJOzxhvZO41Iz4GOB586Ws317itn/sufbi3YEbsECbpancZ5r8rT4ELJcDMbuRPcvexxc2HJ2fH1amnLxKqmGkd9Wy9xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984625; c=relaxed/simple;
	bh=ReKVhJAeMBIn7+aVmGZ86agLijZodN614kBJx7LL5AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=We1DVo+PeZHA5vO5gNSmsvEm17Tskchk/5Bvwi47ItrK0LMpnwVSe2ccxwtei+7XUZG2AMw3+rpO+DvokSqv406wCQJ24PFEPlf1pxy2krhmvFyPEoeJah3S0nH23F8DiCHM/KwcbTxpZYgmZRIsi6EayDCZxMZ6YfWQT/4LKEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D7BrC3Xq; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoTZDBpfb/yq2g5fEeC4s+CTcECl6pgX+VKH0qQfQVU96iP+rSxpVZiQ/2cbuRpaElbdWqaxdWP1Qn3/nXBrzsqFwxYdcPFbjg5WFFvhm7cbMwgXGWArPmO/8KnOmvtUePcodRZU1p9//6TX/in4qaFX9+XrwzclW3rMN/YTVwUUFUXCYwL9JcTEDZW6UfeLpm7MYA/797SsZc7eAcgDTX1l12GFeWs/o8vIH12JXXeicRiHspFDa1WVeaUWqJZ1oN+hasGyP7mFESPP0lEr+N36DM7/dSmQElfsheVF/4oB8mnMEMJKPRVWGnwEFriQIyB2y9YXdc0X4iJiXtTyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=masxnX7fg6tuFWq3W+Qe35T3B1+lbqOmJYLrOjFnQo4=;
 b=qFLZkm0vlcyzELCH+zSLVgezh4Gt8w8u+1pBgpfqCqRfIlgxEXM2DhGEtrCRFnJTdcQYQE5Bs/t//KjHIFh1aE/AubBD6odPBN+sTGenxf4m6idm7X0MnfkMxhW1HHBIn2o6yDCX0hiCIaXeJ5SzfdOXrZH1f6edk9jW7mmfNTsQ3hVj3wkmE6jhAGeC66kolF8dTcVDvcjGNr993IpN057cVdqL/nTLRPOROTzYu+eKRWFNs86GNc06SW6leoMHO5PMSiavB3FIP+NsvMXwexUmJ6fVigGgCKlPTvASQPFETX3F6WSLsl+K0FmcZZxecFZILZFAPWIYCvoA+Lh3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=masxnX7fg6tuFWq3W+Qe35T3B1+lbqOmJYLrOjFnQo4=;
 b=D7BrC3XqtnEBDziHDJ3o1q9CBQMDMi0vnPtTo/mJJSB/HvulaTwgWKr0DuBCtSgPRBjFe17PZi9uxiizJvX5rFj+qy/hj122vYaZcBHjjnkp4+Hi3IC1mBHS8b8J9lhVZHIMsl58b4zxpPP22y4LKSgbMn03tzBsnMLwtWvugjQurkklP75z7dl3azwcwTmRFyGo57by/A5mJDvMKVMK1X78bTkCo+ccmUVVy5zae6Kt5UqoiOTSRnhQrKTEPOrJ3JisculKuhm1rt+eX1Ju2z5tKTKJID0wrZplXSzWasDF/EzCUYv41hYL3M8P4sFYkEEGufsX675p1YXCQxucfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) by
 SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:23:41 +0000
Received: from DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438]) by DS0PR12MB9038.namprd12.prod.outlook.com
 ([fe80::7106:f1be:4972:9438%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:23:41 +0000
Date: Tue, 8 Jul 2025 14:23:11 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <ccbsutf2b5o4gy7275oy2557ieelxccc5623epvmnkb2kr52ki@mia7mpirwava>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
 <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
 <CAHS8izN-yJ1tm0uUvQxq327-bU1Vzj8JVc6bqns0CwNnWhc_XQ@mail.gmail.com>
 <sdy27zexcqivv4bfccu36koe4feswl5panavq3t2k6nndugve3@bcbbjxiciaow>
 <CAHS8izPTBY9vL-H31t26kEc4Y4UEMm+jW0K0NtbqmcsOA9s4Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPTBY9vL-H31t26kEc4Y4UEMm+jW0K0NtbqmcsOA9s4Cw@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To DS0PR12MB9038.namprd12.prod.outlook.com
 (2603:10b6:8:f2::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9038:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 443dc724-9a20-4f44-a214-08ddbe2b0945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUNrME96K2hVM0xrd0RtRXNlbFdLWnZmN2s2a21aT045Wkpzc0NpOHlSWjE5?=
 =?utf-8?B?dHdhYUNkczlwYkJGbS9ZNnVFbitodVh0OXBNNmhNbk5IRHVONkEycCtaZS96?=
 =?utf-8?B?OWR6UUlJVVdIRjJnUDBGcTNYL254WFR3WURValJ5Y21iNFlHZUhDd2M2NVpn?=
 =?utf-8?B?TG1VYWZmazRENUxSeFMzbUdqV3dORHZvR1ZsNWw5UGlGREltOWNmNXVrUkk1?=
 =?utf-8?B?U1AwV1RrdStUemdIaFZsS0duR05pS29NbUd6dFR0NUdjUk1jWVJWU0k0eXh4?=
 =?utf-8?B?aUtjSlFWS0psSlErUi9KVjByWEZUNEtQSitsTDFOZzEvNXR2b0RGRmNvbEs0?=
 =?utf-8?B?MitQMDBEMFdLU2dBS1huc2lJSk14cExVOElaTzR0cW1RNjdobDE4amUvaXhy?=
 =?utf-8?B?ZWFmeGRBZEtnTUluM0FuYk0yNzA4TWJqeFlFWGdRcUZSRzh6RE85M2I5d2Yv?=
 =?utf-8?B?U1hrNmpkWFI2Tm5saWpiWlF3SFJRMGc2MHd2MnB5VmY4VFF2eFhtUmFSUUFC?=
 =?utf-8?B?Mnp3SFpGQTBVQVZtb3NBamZLZ2l1dU1Gc3ZmQU1GV2pDMHlIYVhwRlNESVE2?=
 =?utf-8?B?MldFRFhxZ3k3N2FBK1JiNlAzL3hxYXVKOTlvNFdabWMwVk5EdExFM3kvd3Nl?=
 =?utf-8?B?bnpGdnU5Y3BLUjY5bUNpKytJa3Y4SHRMS1F0WXl4SWdMaXFTYnJrQS90Q0NS?=
 =?utf-8?B?N3ZNdGZ1TEtoTDBJdEY3VGFBSUd4eFlzb2N1RUdCdFgva0VxeWVQUjRmUWZI?=
 =?utf-8?B?Z1VPdERuNGcrcmlVaVN5bkxORG9SZjkvNHVkb2RFOHgvVzRwTUZqYWpOV0E0?=
 =?utf-8?B?L0cwTnNXZGwya2tPK1NkZXk4NWFqVkp2bXNibHFrZGxPaTRhYlFneWYySmov?=
 =?utf-8?B?YjExQzlyQWNhM0F1NENPYlVPb2lQckN6dVJQaVNCOGhDNXNrRVFFU0djbjRP?=
 =?utf-8?B?RTJrUFI1c0RKc0dsT0p6d1YrOVRkc1k2ZUZIVWhkbHhnajRHNDlyWENnVlUz?=
 =?utf-8?B?dEwyNWQ3dk9xcmFucDAvRW5OdnZiRnB3bUpNRW91aHQ5VjEzdG1yTDJjbzQy?=
 =?utf-8?B?eURkVzRacnJYaExmYVVJTCt4YTI5M3BJWGxXL1FvTFg2VWVzdUNFSWx1STBF?=
 =?utf-8?B?QWtBSy91aTN6TjRhbVRac3JkMXpJVmlKNHdiYzJuZEs3WEtaT0t0OG1xVHhN?=
 =?utf-8?B?UGVubHYzT3ZOcXJqN0JOdlVNc2ZWQjVYaFRzdHhZWTZZbEhZZFVtRkZhdk91?=
 =?utf-8?B?cmhCaXMyNU9HUWI2RTNhSXR3N1hzNldSZ0FxTWdoNlluVWl2WjZicVA5TDJX?=
 =?utf-8?B?MU5iNjRwbHlDdVZ0amFMSnRuRC96RjlCVU1oaTcvdzhQMis1VEdpblkwYUg4?=
 =?utf-8?B?bGlCenBjMm1GWng0N2x6cHRqbUwrcllYbEtKN0lmUWZLRHZiZit0cVBlNUhX?=
 =?utf-8?B?U2Q0VXc4bzZuQUlpS00vRHJYMlBOLzlXeVJ5R0Mzc01mMUNxRkpYc0x2Nk40?=
 =?utf-8?B?YW1KS0RUeFJhR0lZT0ZXSG1kVG84UTdxN3lXdWsvaHBXaVdFRTJUNmY2QVZC?=
 =?utf-8?B?OTVvQzdWcGhEaWpGMG5Ncno1YktMajlsYUlESzY5dkhxTjNyY21IRFZtNjBJ?=
 =?utf-8?B?eVNuMWJoT1gxRDc2K2JuRTNVd0VyeURxYlQ1TmpsNjMzWXNVSHYwQytseHlO?=
 =?utf-8?B?Q090cHF1L2ZpTzNLdU9obnYrMGFUQU5EZGhkNjNCeFlLZDBlZHhMcjVNS3Zp?=
 =?utf-8?B?b1RZWisvSTMwcjdiZU5HYk04SjVISUhmeG0zcTJZcUlZbDZlSkFENFFUdW5j?=
 =?utf-8?B?eWNmeThobVNPQlR5cEVSRXFCUEZyemhvMEliNTI5Y05Mby9wR29JdTJyM01N?=
 =?utf-8?B?ZFNRWS9CaUxNUXJHamwzVnQweUlYYjNSWEM5blB6YW9ZUTYzLzNKQkhlUWZ3?=
 =?utf-8?Q?Wp8/VlZcJBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9038.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0NNdG9NTEh2SndtVDhZeWZKUzVTeUpFc0taQjR2amV1dy85WWdvRjBDSksw?=
 =?utf-8?B?RmlZTTVtN2dra2h0THNtQUhMTzVPL2MwdFNiTUExeUY0OFlIaU9NUUVJNytP?=
 =?utf-8?B?QW16YjNTVlNNdDYxMzd4b2psSm1WU2FhY1FOMXREZ1ZuNkdHL3dMWG5Rc1Bj?=
 =?utf-8?B?YmRhRDRoRDZiMFMzR1dEcGl6UEVMQlI1TUR6L2xqam1JZ3FmUW1VZktPYVJE?=
 =?utf-8?B?YzJ6WXUxdE93Y2hTVUd3RW9CakV5aUZLbGNCRnQ2d29CS2JDeEZsTHF3QjhP?=
 =?utf-8?B?T1JxVVpXb3c1dHk3K3JhSDFXQnhSVE1FSzFqLzdXYkxEUlM1alN6KzlBcDBl?=
 =?utf-8?B?S2xrb3VPNU9zbzVHZDU4VmZaU3FVSVM4djhETjFZYW5XK3lLL2xGQUY1RHVk?=
 =?utf-8?B?NnkveExlZGZRUHlWeTRDUjhkN3JSU3UwMmg5Q0x0Y1JaYzl3dC8zOHRTV3cv?=
 =?utf-8?B?U0Z6aUVMdnBKZU5JSERhN25EbWQ5Q2c5R3hwd3o0Y2J2OU1Zb3dRK3RXYUJ1?=
 =?utf-8?B?a2dXSFJ3SlRWdk1YNjhQZHp0RlN2cWFqQkpDVkE1YU95bmRtNHJ2aTc3Unpq?=
 =?utf-8?B?MnhlejZieGh6czg3WnJOTy9qSnRjSEZrWTVXdnY1SUtyTHRvSW9BS09HV0Ft?=
 =?utf-8?B?UDAyWXhRbXk2Ync3Y09GWTA2ZFNuL1FLWlNsc0h1OHVMRG1EdEwvcXVNMXI1?=
 =?utf-8?B?OHVIRlpPVTRsT2ZQbW5mYzcwMGN0N09xTy92TUlLdWpSb1ZTT2RxejR0SzdZ?=
 =?utf-8?B?eUMweDBiZjJ2K2lDZ2RtdFdNTWNaUGd5bjQ5WVRJTWN6dkxSWVhCR3ZWSHly?=
 =?utf-8?B?aUVzWGtMYWVjSU1PSERod1ZGM0JGZmVsVUg3Qi85VjVZeHdOdHc5ZnFHUDNK?=
 =?utf-8?B?b1FySHBvQlZ5U0w5WVRSeVBFUUpMM1l4WUpHZTZkZTFha2ZFbXZwTUpvS1hh?=
 =?utf-8?B?cEg4dk95clczMjVPYTlaU2c1a0V0UWRhd1BrL0VJQ29SUmFPc3JYbFhXV3Nz?=
 =?utf-8?B?U09MaUVsWjRWRXpXcFN2UHQvQThQOHlrYWFvdHgzVXQyUXZlWHROOUJwWEM4?=
 =?utf-8?B?QXpDOXdXMDdQa2pDK2FhK2luTkRGbTMrdFVaOThqRVVRQW5qWnFjdk9aZHJi?=
 =?utf-8?B?UXIxQmhzVHRzTVVzTEYyWDVhR05Lczg5UnFVRjJIekdHeWZNc0picEV1ckJL?=
 =?utf-8?B?VkcveUlqZlExaGFySDdsWUYyMEVFRThxaGp2a0JvbkM2em1yTzlUUXpRdFhE?=
 =?utf-8?B?UVY1VVorOGNkdjk4SEZiVi9MU1ZOYVBFeHBzVFUxajl4VzB1SkxkaVd6NVY5?=
 =?utf-8?B?QUFHVXBrM0VnenA1REtqbmJ6MllqWDRqYnNBaVBLODhOcmR3UTBNSDlUbFgr?=
 =?utf-8?B?UnhwUlVaSDBMRUVFQnVIeHZEVWU3ZVE4SzN2ZTByQXpMQm5GelNQMzF2VTVo?=
 =?utf-8?B?d1JqeVZNblM5Q2R0Wi9uTDFEN0pPRThmbnpPZDkvQURoUVpmSGc3M3F2Q1BI?=
 =?utf-8?B?OXo3eEE0TGRzWTdYZkN0VUNUK3ZiUWpaTDhCM2Y0ZnFIOGtobkg1SytMb2tL?=
 =?utf-8?B?OHc5ZkErbWhvSTNUcXdIb2dLUnY1MkRZeGUramUwTm9CdE0zMko5ZmFjRjVJ?=
 =?utf-8?B?MGc2RFRrOGkwd2hYMi95L3k3Mkxjdlp2WWJKSm5jWnR3TDAxenpkSnpHUUxo?=
 =?utf-8?B?WTU0YkVZRllTMjZ3dVpkMDI5dGVML0M5amN4TURNaHFPblBsQWQyeHdBNDRu?=
 =?utf-8?B?TXFtY2dONkNaYUl3eU5mL1ZObVFacVpqcEpyQlB0WXNLdlkxUjFySTNxYjUz?=
 =?utf-8?B?QU1xOG45M3ltZVVIYnRVMVgrOW9pQ0t1M2d1TmZscW5nSEtYeEtyclYyaHRo?=
 =?utf-8?B?SU1YWkkxOE44c3dKMVhqUTZ3dGRQY2RqL3VBZEp2emd2cllxckZxMU9iVWxn?=
 =?utf-8?B?eCtmakJTbVI2ZTRNT1grdkI1TVBRNjV4azRJcFRuS2gxU0ZVNXNDSktuVnc5?=
 =?utf-8?B?dUlYRStta2ZmNE0zMkkvVWR6L01uVUFEMWR0Q3M3Y2JuWXAreUtKWVV2VWlG?=
 =?utf-8?B?b0paaXkyY05NbzlnOEgxL1kxQ29waWVjSWkyTXVMTFRzeXJpQm1UNVVhUmxK?=
 =?utf-8?Q?6RmgwOFsqtY8wDqihIjbfAkW7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443dc724-9a20-4f44-a214-08ddbe2b0945
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:23:41.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnnnHCdDItSLogK+r9SjFGfFq7jMCQa1o5pi1CmePJiur70qYeBhSRTMwhMIKlMpL46X53P3Vxzjlue1fIaNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144

On Mon, Jul 07, 2025 at 02:55:11PM -0700, Mina Almasry wrote:
> On Mon, Jul 7, 2025 at 2:35 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> > On Mon, Jul 07, 2025 at 11:44:19AM -0700, Mina Almasry wrote:
> > > On Fri, Jul 4, 2025 at 6:11 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > > >
> > > > On Thu, Jul 03, 2025 at 01:58:50PM +0200, Parav Pandit wrote:
> > > > >
> > > > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > > > Sent: 03 July 2025 02:23 AM
> > > > > >
> > > > [...]
> > > > > > Maybe someone with closer understanding can chime in. If the kind of
> > > > > > subfunctions you describe are expected, and there's a generic way of
> > > > > > recognizing them -- automatically going to parent of parent would indeed be
> > > > > > cleaner and less error prone, as you suggest.
> > > > >
> > > > > I am not sure when the parent of parent assumption would fail, but can be
> > > > > a good start.
> > > > >
> > > > > If netdev 8 bytes extension to store dma_dev is concern,
> > > > > probably a netdev IFF_DMA_DEV_PARENT can be elegant to refer parent->parent?
> > > > > So that there is no guess work in devmem layer.
> > > > >
> > > > > That said, my understanding of devmem is limited, so I could be mistaken here.
> > > > >
> > > > > In the long term, the devmem infrastructure likely needs to be
> > > > > modernized to support queue-level DMA mapping.
> > > > > This is useful because drivers like mlx5 already support
> > > > > socket-direct netdev that span across two PCI devices.
> > > > >
> > > > > Currently, devmem is limited to a single PCI device per netdev.
> > > > > While the buffer pool could be per device, the actual DMA
> > > > > mapping might need to be deferred until buffer posting
> > > > > time to support such multi-device scenarios.
> > > > >
> > > > > In an offline discussion, Dragos mentioned that io_uring already
> > > > > operates at the queue level, may be some ideas can be picked up
> > > > > from io_uring?
> > > > The problem for devmem is that the device based API is already set in
> > > > stone so not sure how we can change this. Maybe Mina can chime in.
> > > >
> > >
> > > I think what's being discussed here is pretty straight forward and
> > > doesn't need UAPI changes, right? Or were you referring to another
> > > API?
> > >
> > I was referring to the fact that devmem takes one big buffer, maps it
> > for a single device (in net_devmem_bind_dmabuf()) and then assigns it to
> > queues in net_devmem_bind_dmabuf_to_queue(). As the single buffer is
> > part of the API, I don't see how the mapping could be done in a per
> > queue way.
> >
> 
> Oh, I see. devmem does support mapping a single buffer to multiple
> queues in a single netlink API call, but there is nothing stopping the
> user from mapping N buffers to N queues in N netlink API calls.
Oh, yes, of course. Why didn't I think of that...

Thanks,
Dragos

