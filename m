Return-Path: <netdev+bounces-152263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73B99F3458
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEA618852E4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F2145323;
	Mon, 16 Dec 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyooOYaH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148E143725
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362494; cv=fail; b=TiLEdbIJzz4qTrSIl5M67fZ5wRUg6t9glAc1CICBMXbTTmznNtp6g2oNgOLKTh8bAI9vtIroUH0T3UpdvMF1E4ch/h2Jxq4pvMR/X6X0sm7ZU1AUTsYKijZaOx0dGW3FTxkUDrPDR8k+VWh90IkSN4Zlsz8IL+LmRwqkTKSJtms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362494; c=relaxed/simple;
	bh=kc0QPT83NZ9OhRqWmTIca2O7mJRCoPiWV9wJ1enGPEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFedQE4wahAE2QfphzSB+hnbC1pSzbxa92M996QgMgU09vG7fGQ7nRNuWODc5PEBAgKIXp2qCteH9FYRSinlT6qXIR8XgmMpoh5Giegpym+WTTNigjsmWxz9jh2Eu5JDniAvk1JxPbjJwuxVl/LsSCpa/kGfo+9sVok/0QfOUM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MyooOYaH; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koI3PHumbQjbLzJ+hJ/Rv2pVGeVXP7Rrd4+tQq/pN8sOLMpjboWhOjoXx58sVPEQAw+CBjkH4gKzn60IvZegiqvr4lECiksRDXcDmLpMc4tuF0orWl4p/3DJTwsjpch4Zb1BG3uwYydRkSS+QcQA9eWDqQSyD38hxSGnORU8bIKFRl0x8jGUy1zbCmLkOV0daN/LtObvoaSUgyESgjzaTECZJq6ursqXHJDhu3xL5HSI7ST2mhN4xwhgkNA72fFE5wJxIwfSUQvM+7KNz+90zZXy1W8KQc3ClYb7tTfhXKlIJLHiXI1rsQfViZLW/jjdCcuhWp9bRz+OMbCSRaaoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUyNEWDH946+Tu4C48pQycHxspkQ1YudS+cgAhgx6AI=;
 b=kluiRV7pptU5hYl9PYEjgVR6l58vdYzY3n7JgyqX7DWE4eFllwGXscp4CeEQcxqSCajd5HoIi/+xkciPTBzInsTcTnw5KgSdg5yCbCBl41cYEiI4wzS3ecGJ9IzJN0dn84qFsSPWfI1C2WaB2RmJ5Ckat+Rls8+blTqqWcEKqH+VDMk2rGTkbEghRF6JQnv4Xqr6X0vCynZwbRPNmAjivoJzD/9wgvdz5wnT4RcR8i1Q/5ziVapa8wq/GsalnMgyUXy4hUTIFH5dssVOoY8gF7QqiXjv6yIMSLNxr5y6hAzzmF3bK4ZJhGo9YQHlOVz1agh5eBlbzjVCgZLSh9MDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUyNEWDH946+Tu4C48pQycHxspkQ1YudS+cgAhgx6AI=;
 b=MyooOYaH6YG9jOAEohrNKcHp+3D8gxIPxO9zuc2XBbvZ0D9bQx1HAmXEj9dKLSqI2LW6if5Iv0vy1n/hxjVA4E4lV+fmMY2S3RVpCePqXMJbId1f7O+g3bAKi9yy/g3X6RR98+ZuRhtyox7Ftb2MWWYOFqSj03lDmKfWrtnaGt6epU4gd7Rt7OtZz+3+FzHEPbs1Ft9o4G1nJtUPD4VMxIwbZoIyc1XhmdO1ArfgtYkwWnfgmkDeOpVaqxiKaVh8sj5T8DM8CGSBTpcnrhwJradguHIWe8Z+yPMmlXVhf8rz4mCZqVFWlMB0cxzERbrz3dD9D8APdAHNsoTyxivF1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 15:21:29 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:21:29 +0000
Date: Mon, 16 Dec 2024 17:21:10 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: ericnetdev dumazet <erdnetdev@gmail.com>, daniel@iogearbox.net,
	sdf@fomichev.me
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, gnault@redhat.com
Subject: Re: [PATCH net] vxlan: Avoid accessing uninitialized memory during
 xmit
Message-ID: <Z2BFZnV2goMfoGh4@shredder>
References: <20241216134207.165422-1-idosch@nvidia.com>
 <CANn89iLt9uKxzcceP=xWp5gr+VmghsZROwjHtK=878zDQ+7BpA@mail.gmail.com>
 <Z2A8vwvlKMqQf8jQ@shredder>
 <CAHTyZGyAO_NtuNiH62m5z8tEWjjWCobsyr-wvSLfeBNaBEYe6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHTyZGyAO_NtuNiH62m5z8tEWjjWCobsyr-wvSLfeBNaBEYe6Q@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb2bb8e-e8c2-4229-e43a-08dd1de5506f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1AxT1hnQ2o1MlJTV1BvV0VoZnk1cGsybWJvUlNpNzYrQUpiUDlPMkxjb2Rq?=
 =?utf-8?B?aEV2UnBZVFU5RWJXMDFZVk9waVJhZ0RnODd2VGpXMlBkUnd5SEptTUhyZUJz?=
 =?utf-8?B?VnM1dUIyWkM1N3B2ekxodHB5UVRVRVpMazYzamxPMHg5V1lxQS9XZ1JxZlVV?=
 =?utf-8?B?MDZjWTI1Q3Q0aUtRQit0RGZXd1R4WmJvK0czK2RzVmpDWklVWm1RY0dST3BW?=
 =?utf-8?B?Qm1FcVBMOGpyODRuUVRBSTQ1UTJ0SW13VGRrTUhPVERFdjFmN0hrQ3R0eERP?=
 =?utf-8?B?Vk9RVFRJQi9mcGU0bnQrUGZIMmIzL3F4TEpjSDhyWHNCcGxyNWVjeXVnQ1Yw?=
 =?utf-8?B?ZDdvM0h5UlpzUmhDdzR0ak0xMG9xdHZ4R2tIenhZYUZJUHZjc3I5Q0s2akRh?=
 =?utf-8?B?UmZsMURLK2NxWGxkOEdqTUZ2ZWY0WHBiaVNTL0RHNHVoa3NZcmdNVTEzTWh6?=
 =?utf-8?B?bW9MU0ViRFpoRVRGUmVCdU9VU1lLOVA1cG5uQkorQ3dPNFY0YnVVTHdYQnlV?=
 =?utf-8?B?eTIrRTViU3hpU2F4YjFpc05lbkVBSk5qdUN6dE1hMVpWOW5PUkF0Ylhza0lt?=
 =?utf-8?B?UVlGaHFRRk9mSW9kZTFnNVRxRUQ5KzF6WXhmOUdOTnZpQmFlcmxlUytQZjV2?=
 =?utf-8?B?MndjNWs2RDE2SE4rOWU4dENaL1NSTCs3SVNCNGR1RmdMK2hKdGZDRFkzZWRL?=
 =?utf-8?B?ZFh0d004UEVTTElseUNFZ0Mxc0ZUQzA5b09SWExNQWFwQ0Z6cHFONURqdTR2?=
 =?utf-8?B?YWluUHA2cjRQdk42VG1kbmVyeVppQ1MwSmg3WDQ1d0NnTjgzOU9KNDZXaExD?=
 =?utf-8?B?d1dOdWk4MmZha0pWaUNVYXdWa1ExcEJsNGkxWXRzRFlDU0lFOE93anhRd2Q1?=
 =?utf-8?B?SHordGxyUXU0cW8yYXNiV2YyNkZ6enBqakgxUGhMM1hzclpwd1NuODBaNk0r?=
 =?utf-8?B?NjI4RnRlK3I3cW5EaDRjaVFxTStISy9heUZuUjhGWEszNm9qY2FnU1p0bzJU?=
 =?utf-8?B?OGJNR1MrK3dkU201K0lpVGZ3aTNCeHVQNGJhclB2cGhLNHdlMVl4WmRPZDBK?=
 =?utf-8?B?T21wSk1GUnlINDgrLzRQWmhXaHpSN2RkY01PelJPU3R4S3VhbXgzeGU2UEZU?=
 =?utf-8?B?UnZxN1hicmNiR0pVRENFTGpyRk8vVXN4RmhsSU1JL3M2cUNuQWZsMEhvK25i?=
 =?utf-8?B?TGVRMzJia1RPckduWEk1eXl2MzlYQzJKa3RrQ1Z2UkNyU0NwRkpiWlZGVGhp?=
 =?utf-8?B?YVF4SldUeWs3UTg1MjFBcUlva0JqSG5nT1QyYStINGhWc1VGZjVFNXZBOVhY?=
 =?utf-8?B?RG5DNUhBUURDQVdTeEptdWVUME5XTzNSUEs3T0FtU0NVSk40aW9ubzlScFFJ?=
 =?utf-8?B?cDBPTVd3YlQwNFhvcnNlayttVE9LZk1NdlJVWXZzczE3M1RwZFJwUklyNUtE?=
 =?utf-8?B?K05QV0VmU0tiN1p2T2tBSWN1aVR3amZGYlFyeHJzNFhhZjRSQnQvOXVrbnpz?=
 =?utf-8?B?Y0RKVVF3Wmd3QjVWWHFWZmZ5RW54ZW9iZVp5WVphWlZvRmU1QlBJNS9IcWhO?=
 =?utf-8?B?cUx1bVpQamdnS0FpQWI3Z1MvVUY4djU5OEZiejRjY1dYM2ttSHJKZHRaa3pT?=
 =?utf-8?B?ZTdHeXgxSk1ubkY1cGR0VlVFYUdIenVPL1lmTEtTZkFydlpqNU5CTUlLWEJM?=
 =?utf-8?B?TmlYVmg2emdpYzkwOTNLSGZBVWI1SzZFZHpYeG43RDhtNUorUXhkYm9yUmN4?=
 =?utf-8?B?Qm5GTER1dHlCVkZLZkhpVnNTNERCMVJnVnhtVEZxNXNiVHhhN3VZTlpOaUto?=
 =?utf-8?B?UnJKYXJtdWQzQ01rcDZuRjRZT3JodlJhZDlLSDJpb1dDTFpHYjlkSWNnTURs?=
 =?utf-8?Q?nQiMj8F02RXRx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjNKa0JuUEtkNVRlcEdSZ0JaenZQT202WC9IYkRBK0lQeHRIYU1ZNFd5UVpq?=
 =?utf-8?B?TWordnVBa3J4SGFLMHlLMm80NGswOHRTaGF5NzVrdUJiS0FybklGRXkrUXZR?=
 =?utf-8?B?VkV0SkNpd1k4ME4xTlBJR25JTVF4aWRHSzNhanloOEw4R3IrMThlMkNDYlVG?=
 =?utf-8?B?Q2E0ZG1KdDlyenc4YksrN0F4NDZMY2NoUlRQT3BtVUFQRTNITThqeGFQZEtK?=
 =?utf-8?B?T3U2S1ozUVNOZDdBS2xoWk9EcHpUdTFuelhrcksrV0pwMDV0dDM0VkhZdndE?=
 =?utf-8?B?UEJXNS8xUysvdi9oT2VrZUJzemFtcG5Pb2p5Y3hHSTczU0MvQnlhV1pXQUdW?=
 =?utf-8?B?ZGtUby9qc1J1RnlpMi8zVjlyL1krai9nWDFTY2ZzMWd0akZLRVZ2YmRJaDhC?=
 =?utf-8?B?TkJmMlhvMm1RMmpEZ0R1RmhWQzBzMEZPR3p5bWRNZ0d5c2xzMjNLWU5wenBC?=
 =?utf-8?B?cHpQclExT3AwUDNMcGpudTBTSjcvc0RNTUpDTDRoWTNlakRMSW9nMU4rK0R4?=
 =?utf-8?B?cjIrRUlyTjdUdmlNekNPS25SVnYxUm1qbjJLUjg5ZnJXRDREZURiNW15SWJk?=
 =?utf-8?B?M1F3V2ovZllZUVB6SHE5RE1hb05tMkNONUJPaUFUTGZ3djJnTGhLRFc4QWJZ?=
 =?utf-8?B?TGJBT0FGS1NYTUpOSitlbmtENGVaRXBobjNuaUZhL1JZWFc1b2NPVHJoUlo3?=
 =?utf-8?B?b055c3dIbHVxT2NKeERkdk9adVAwVDZudFdONG1VMVgxK09MaXZYTmZ1cWZK?=
 =?utf-8?B?VXNlNlAvWjY0SFE5cnFSMUc1TGswUGRtdk9nWVN6TDl0SWlFM0t2TFJONHFX?=
 =?utf-8?B?M1E4MXY0SktFVzY0NkpPeDgyZjdmdFZuSUUzNVhBWDNiNjNCQVRSWklxMWJZ?=
 =?utf-8?B?K09uVEpuVVdJSjF1VE9LRjBaMVVVUE4xdzNEVFpjY2hjMSsrdXluMVk5aUtn?=
 =?utf-8?B?TGpYQTZiZXJpTkxZWEdNZHNhUGxmcDA4SGptWGFHUkRTdDlrekh6VVRaNnMv?=
 =?utf-8?B?ZTZYSVNRS0NqeGs5WFRHdEozWHBwZnlYZ1BXZW9IUUMyMHJ3WC91cEVoRkhJ?=
 =?utf-8?B?S0k2V1FmNDJUQUF2clVEYVFzRERKeEZXR3hGa0wzT01mZW1paEkraktTSHJn?=
 =?utf-8?B?eVRCTzQzSm9QRkFRWUVjbk9HeVhqcWF0UVoyZVNVOEtlU3Y0dSsrSHhOZFBn?=
 =?utf-8?B?c056RFJwb0s5V0RDb1c5b05lRFdNOVJ1c0N4cENFdnl3cFk2MGNRQVNrZThz?=
 =?utf-8?B?cnFrQTJ0dWx2MlJTMENIdTc3a1MwOHJMakp3eHdXaHN2dkp0ZjRramtYb3la?=
 =?utf-8?B?L01LellCWjBXOCt6MW92a1pObndhZVQrRVN2SU0wQmJnYWRRalRIdVpVU3p0?=
 =?utf-8?B?cU1xbHFWT1ZTYnhiY0pLYXhaZDIwVUp1akhmMG4vR2xJY3FlVDFubG9aMjg1?=
 =?utf-8?B?ZXdPb1lZcHdES3U2Y08wdWFESFpZZTVVZHR2S21JY082NXdjZ2VMWlphWlZm?=
 =?utf-8?B?RFBEbTk1MlB3cmM4SHdwYmtubkI0d2FjVm5NUUhacEVZTmRYc0tMdUZOUG1v?=
 =?utf-8?B?TXUxVE9LUlFKemxEV21pdWZJV29LeWgyZ0piOFBnWW5XaUxKTlZ4cWdVN2RC?=
 =?utf-8?B?cHo3eTQrcDcxRmxDcWRPNmZUbnFKZzR4T3d5UmMrTjZCY01Pa2FLTUljaUNN?=
 =?utf-8?B?b0xMMUdoQlZYUW1ZRmhrRHR0R09UdlQwb2RRWDQ5Yk1wcHVSZlpUVHFMU3ZV?=
 =?utf-8?B?d2lhV1hjYk5HbkRqK1RyZCtFeHAxb2VXa09GUGIwWjZUZlp0T3ArQTFUdWVo?=
 =?utf-8?B?OUNMR3RCWFRDck9nWXNyME9zS2t5c2Q2cVN3RmY0QSsyb0pDbXd3OEVwREU2?=
 =?utf-8?B?WkhvdDY3dGdTbUkxVERZZ2tvVkJObjBCdExPK0RINUdROS9zRVJrdXpKMjI3?=
 =?utf-8?B?SG5CSTJITWpIT2xZMWlBbHludzgvdGxibERZWGQva202ZXRZVjNwd0lIUnZY?=
 =?utf-8?B?bUlrMmgzcHA4Znk0QzNPSW9qdHBpcHdOYXZsY2FvYkw2V0JpNlpjalh5bmIx?=
 =?utf-8?B?ZUc0QUFRMVRFTDRQTWdYUGlFZzI5RkdyRU1INkxReHg2SC94MGpOYitPbkMx?=
 =?utf-8?Q?z2rVCzdQ4DmBO1YdOIt65yJpx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb2bb8e-e8c2-4229-e43a-08dd1de5506f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:21:29.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLnTV16YqQ3sasMT7wapCPQkY2EUpSMZKOPLkRwfinPX/5uysB3F12vtCXqBaoZXNjJv9ksNJmSZ9WsVC14MeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

On Mon, Dec 16, 2024 at 03:59:12PM +0100, ericnetdev dumazet wrote:
> Le lun. 16 déc. 2024 à 15:44, Ido Schimmel <idosch@nvidia.com> a écrit :
> >
> > On Mon, Dec 16, 2024 at 02:48:04PM +0100, Eric Dumazet wrote:
> > > On Mon, Dec 16, 2024 at 2:43 PM Ido Schimmel <idosch@nvidia.com> wrote:
> > > >
> > > > The VXLAN driver does not verify that transmitted packets have an
> > > > Ethernet header in the linear part of the skb, which can result in the
> > > > driver accessing uninitialized memory while processing the Ethernet
> > > > header [1]. Issue can be reproduced using [2].
> > > >
> > > > Fix by checking that we can pull the Ethernet header into the linear
> > > > part of the skb. Note that the driver can transmit IP packets, but this
> > > > is handled earlier in the xmit path.
> > > >
> > > > [1]
> > > > CPU: 6 UID: 0 PID: 404 Comm: bpftool Tainted: G    B              6.12.0-rc7-custom-g10d3437464d3 #232
> > > > Tainted: [B]=BAD_PAGE
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> > > > =====================================================
> > > > =====================================================
> > > > BUG: KMSAN: uninit-value in __vxlan_find_mac+0x449/0x450
> > > >  __vxlan_find_mac+0x449/0x450
> > > >  vxlan_xmit+0x1265/0x2f70
> > > >  dev_hard_start_xmit+0x239/0x7e0
> > > >  __dev_queue_xmit+0x2d65/0x45e0
> > > >  __bpf_redirect+0x6d2/0xf60
> > > >  bpf_clone_redirect+0x2c7/0x450
> > > >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> > > >  bpf_test_run+0x60f/0xca0
> > > >  bpf_prog_test_run_skb+0x115d/0x2300
> > > >  bpf_prog_test_run+0x3b3/0x5c0
> > > >  __sys_bpf+0x501/0xc60
> > > >  __x64_sys_bpf+0xa8/0xf0
> > > >  do_syscall_64+0xd9/0x1b0
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > Uninit was stored to memory at:
> > > >  __vxlan_find_mac+0x442/0x450
> > > >  vxlan_xmit+0x1265/0x2f70
> > > >  dev_hard_start_xmit+0x239/0x7e0
> > > >  __dev_queue_xmit+0x2d65/0x45e0
> > > >  __bpf_redirect+0x6d2/0xf60
> > > >  bpf_clone_redirect+0x2c7/0x450
> > > >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> > > >  bpf_test_run+0x60f/0xca0
> > > >  bpf_prog_test_run_skb+0x115d/0x2300
> > > >  bpf_prog_test_run+0x3b3/0x5c0
> > > >  __sys_bpf+0x501/0xc60
> > > >  __x64_sys_bpf+0xa8/0xf0
> > > >  do_syscall_64+0xd9/0x1b0
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > Uninit was created at:
> > > >  kmem_cache_alloc_node_noprof+0x4a8/0x9e0
> > > >  kmalloc_reserve+0xd1/0x420
> > > >  pskb_expand_head+0x1b4/0x15f0
> > > >  skb_ensure_writable+0x2ee/0x390
> > > >  bpf_clone_redirect+0x16a/0x450
> > > >  bpf_prog_7423975f9f8be99f_mac_repo+0x20/0x22
> > > >  bpf_test_run+0x60f/0xca0
> > > >  bpf_prog_test_run_skb+0x115d/0x2300
> > > >  bpf_prog_test_run+0x3b3/0x5c0
> > > >  __sys_bpf+0x501/0xc60
> > > >  __x64_sys_bpf+0xa8/0xf0
> > > >  do_syscall_64+0xd9/0x1b0
> > > >
> > > > [2]
> > > >  $ cat mac_repo.bpf.c
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > >  #include <linux/bpf.h>
> > > >  #include <bpf/bpf_helpers.h>
> > > >
> > > >  SEC("lwt_xmit")
> > > >  int mac_repo(struct __sk_buff *skb)
> > > >  {
> > > >          return bpf_clone_redirect(skb, 100, 0);
> > > >  }
> > > >
> > > >  $ clang -O2 -target bpf -c mac_repo.bpf.c -o mac_repo.o
> > > >
> > > >  # ip link add name vx0 up index 100 type vxlan id 10010 dstport 4789 local 192.0.2.1
> > > >
> > > >  # bpftool prog load mac_repo.o /sys/fs/bpf/mac_repo
> > > >
> > > >  # echo -ne "\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41\x41" | \
> > > >         bpftool prog run pinned /sys/fs/bpf/mac_repo data_in - repeat 10
> > > >
> > > > Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> > > > Reported-by: syzbot+35e7e2811bbe5777b20e@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/netdev/6735d39a.050a0220.1324f8.0096.GAE@google.com/
> > > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > > ---
> > > > If this is accepted, I will change dev_core_stats_tx_dropped_inc() to
> > > > dev_dstats_tx_dropped() in net-next.
> > > > ---
> > > >  drivers/net/vxlan/vxlan_core.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> > > > index 9ea63059d52d..4cbde7a88205 100644
> > > > --- a/drivers/net/vxlan/vxlan_core.c
> > > > +++ b/drivers/net/vxlan/vxlan_core.c
> > > > @@ -2722,6 +2722,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >         struct vxlan_dev *vxlan = netdev_priv(dev);
> > > >         struct vxlan_rdst *rdst, *fdst = NULL;
> > > >         const struct ip_tunnel_info *info;
> > > > +       enum skb_drop_reason reason;
> > > >         struct vxlan_fdb *f;
> > > >         struct ethhdr *eth;
> > > >         __be32 vni = 0;
> > > > @@ -2746,6 +2747,15 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >                 }
> > > >         }
> > > >
> > > > +       reason = pskb_may_pull_reason(skb, ETH_HLEN);
> > > > +       if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
> > > > +               dev_core_stats_tx_dropped_inc(dev);
> > > > +               vxlan_vnifilter_count(vxlan, vni, NULL,
> > > > +                                     VXLAN_VNI_STATS_TX_DROPS, 0);
> > > > +               kfree_skb_reason(skb, reason);
> > > > +               return NETDEV_TX_OK;
> > > > +       }
> > >
> > > I think the plan was to use dev->min_header_len, in the generic part
> > > of networking stack,
> > > instead of having to copy/paste this code in all drivers.
> >
> > Are you referring to [1]? Tested it using the reproducer I mentioned and
> > it seems to work. Is it still blocked by the empty_skb test?
> >
> > [1] https://lore.kernel.org/netdev/20240322122407.1329861-1-edumazet@google.com/
> 
> Yes, I am referring to a generic test done in locations where a
> malicious skb could be cooked/transformed.

OK, thanks Eric. I agree it's a better approach. Looks like it will
allow us to revert 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
at least eth header len bytes") and other patches I might have missed.

Daniel / Stan, are you guys still planning to adjust the empty_skb test
so that Eric's patch could be applied without failing the CI?

