Return-Path: <netdev+bounces-211537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D2B19FC6
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C3218955BE
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17D24677E;
	Mon,  4 Aug 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K1Ks7zCn"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C63111BF
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303757; cv=fail; b=lpgolzMz1tRrMkAPGxCKSw8dk5tXfJmJBDbHhznUqPXA/zu4hfBRjwsJMZaqAO0mMCOgBrk0FocK53QXWAml+P+qkdY9Huni4gTlWHdEntZLfnZKFMny2aqnARLkLDwcN8VZ7mu7GrMv/YTcze/9Wyog9Kz9mI7OVwNbjRJrfAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303757; c=relaxed/simple;
	bh=p39yq9mr2vX6GQL9yTBHJyTSMLXN6IWR+cFWIb7awqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=USndUpbqiLZkgwvV/6W1NdudwlhHc2lNM9mxZxonxvsMmQPtVBE+jwoTw11Jb0KPA/zzVAgMijMOgIpjwaaUTAOXLzy4srHFRZHSTLV9bR1Kb2bvhDR8rM61OoovrveDOKNeNqG1A8GwrrrL4a52x2pEGhCCNMLHGIKYXS7PzLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K1Ks7zCn; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQGm5zmbg0r5BtfSp3kA+SnNWkfnDXqFEAinrvOFEu27cF5OEdsI0u2tX4E0PXw5kvymN+knfuFSXTCZN4kJcqGyK8QThtKarw4ctBUbgNPrqz1L6Qih2hTKGXJS6MagELLO4xYZItVGQXDu4mTGIwo0IXJScTY06auiFAzSoBD+ACMY/k/AhT/UOhlfe1CQ5WF8zHdbbpqpCagmtNzOsGa/+jw49L2gXqP5BZ/wcPHZ7UT/NU5HACg4jPJ/uzF4+EScVK9M/iqzGyumQU4vZFTPFfyWoa9VP367t6W9H+/uFvqjHCAMJ84Uj8px/30tOCJ0G2nRf4qvZguGKSfUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu0qS0gxKZ9bYD4OPcIvlltXIEYLBSGDmXRCrUir1A0=;
 b=RXFdokmDWKqdEB9yDB55Ggr7KdXQRZy9xiB7q47hdyjU0T0ZKuamazi63khHlSw3kiqX/n1zEt9cEUumWzepPR+LyhXkgv5GoM715BgeHXYkPo4B10Uh8tee8aoc8EF905zxBclwdbl/xoxsvWFtQ8uLy4rcRvG49+Q4riK+fsD63QAm3Ozb6IJU5npmPGOXGpqEX+39LAwe8joDY5nZJmpcMEDI3Lux26rF2qzAY0eJyWVy1xecyb/NvdHhfsB3Tq/FV6cH4k7wp9r8hLvycMPkLa5TPxAkNPDE7Oa5MeQTTC62d58mgSZk8vlCfkHxslt/+VLYyTm9UKGsB1yWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu0qS0gxKZ9bYD4OPcIvlltXIEYLBSGDmXRCrUir1A0=;
 b=K1Ks7zCnn32Y8fn1eUeMRu2H4TkHoyGbD260GsOtZX5gIz08NUeweeCxA3tgcaGvgvHUqpO22UAu7VTj70cPFwOAjZIlVLMhs+woVAusAiPM4wrycw7rRcmO1pZRNUGKEIvLzQiWcdukX4Axnb1I2coh0ICa6ZaGw8xFij0MvfMSXKMaIDFMZ6m4/W0/+GlqxKp/4Lf4E/7AT9qL/rXWbBVcr6VM80W6DYM32ZWmVe9r9H5tlnYLISvndmw2efEHyqVtuz887ysLGoLzQjkFGiThkSY2i3wzgZ+Hv1ChW+vdYJAx+gV7Ebme43sbnuBY1f1oz7NH3fAvXOhLV6KBCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 10:35:52 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 10:35:52 +0000
Date: Mon, 4 Aug 2025 13:35:50 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, fejes@inf.elte.hu
Subject: Re: [PATCH net v3] net/sched: mqprio: fix stack out-of-bounds write
 in tc entry parsing
Message-ID: <20250804103550.4mbdb6b4zq3hb5j3@skbuf>
References: <20250802001857.2702497-1-kuba@kernel.org>
 <20250802001857.2702497-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802001857.2702497-1-kuba@kernel.org>
 <20250802001857.2702497-1-kuba@kernel.org>
X-ClientProxiedBy: BE1P281CA0392.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8deca2-481f-46af-4fb3-08ddd342afbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ylk0YURhUmdQRko3TDg3TEpHSExVYUJFUHVtaDU2OExnbG5Da01Za0ZFQkQv?=
 =?utf-8?B?T29uRmN1eXJTOEpJTUIvck14N1VQZStoWUVUQnJzRE9kUWR2SXFkcVB5WUdi?=
 =?utf-8?B?ZXNCTm9BbngzTGhUdDlsRERnWlJBNHlFa0tzUHRUTGtCZzhMUDR6ZWxucVYr?=
 =?utf-8?B?UXQ3QjdFVG5GRkRBbHBWOGZ0aVVnL3J3bVpXZ1pEZFRDank1WUFjSERZWHdM?=
 =?utf-8?B?a2RXeG91Vm55T1RYdkR6aXF3K2pLbXY3SEZ1aE5TYlJSL3YzNnF6TzE0VlNz?=
 =?utf-8?B?dytyZzNGQUdLMmM1WTJnRDVJakNGanJsbUJYWFUydGVTYkpCRlBUVS9XZTVX?=
 =?utf-8?B?R2hEZVFDUTFQR01wZW1mZjFUZFRRVEErNnc3a1BkYWdxT0dZZDJWRmFCN2xh?=
 =?utf-8?B?ZFJnd2w5TE8vWWNieUJnQXRyR05aeHZ2L21mTjBabzBqWGxZYy9oektsVUxv?=
 =?utf-8?B?TFNSOHIzVFpFVDNEM01XUWVPYXgzWGRHb0lSSTRNQmZieFllR09nMFFLTzFV?=
 =?utf-8?B?QloxVEg0WC9COVhNR095SUhqRlp0U0lYY2hXRVY0d25NOUNaSFZKaWIvaHBJ?=
 =?utf-8?B?R1paTkhRWThJZWVFUFVQQnNuSlVFb0lGWUN3RDhHOXhBbWcyYTMvVW1XM2k5?=
 =?utf-8?B?bUxkbldTWU9xVXNpcUNEZ1BPTTYreDJ3SFE4ZHRqSjVNNXdrVnZBaVNFcjUy?=
 =?utf-8?B?S1RPU3JqK2VTTE9TaEd1QTBPRWZxOW5NalBvS3lNWjc1UXN5OXlCTHNSRWc4?=
 =?utf-8?B?emY2cXhYRDB5KzFHcjdROGkwWFdFdytQQjE0clBYa3huZ1MrTXArLys0d3Iz?=
 =?utf-8?B?OXZ0eUFOaHNCMDdnNkdPSE42dTFyQTZydk5rSFk5RFpiS0ZnSU1kbFhKQlBz?=
 =?utf-8?B?UU81NlQ3eGJaVnlGcUFROFF5ckVKKzE4akwrS1RBdXIyWU8rN2FOZHRYOUhl?=
 =?utf-8?B?RGxHTmthY001WnRuY0dOR3o5R04vUVFzTEhaNEdIUmpqZWsvQkNwc2JOYW1Y?=
 =?utf-8?B?UjZPWmgzOHZvNmcwY1FjNVpWeTZDN1lyUUVReWxuTjRkNk1wa2UvUEU2L09y?=
 =?utf-8?B?d3dqNDExYU5lLzJvWmoxU29pTmJ6SFIvRmZQMXZJdWNwbFBqNHpSWlQrRXRR?=
 =?utf-8?B?Q2pVN3ZTbUtrUi9kRXVHZTFtbHh1WEMvL1huWFVkRmQyOWNFdXh6a01RaWJ1?=
 =?utf-8?B?UWx0ODhpUWZXRitNZ0oxMENsdjF3UGVHNmZCaHNISkNiTDRxcEdHRk4vWmdj?=
 =?utf-8?B?UEhJRUU1U1QxM2huT0NXa2hidGxxSzFmeFFZWkhyWjREVGVmNVRrRkEyRzg1?=
 =?utf-8?B?NEhkSnNaL1RZS2tPNTJYOGkzbi90Q1NhcVFhTzJ6d2kzQStGZXFaT0dSeDJK?=
 =?utf-8?B?cjlSSU1wN3dLRGR0Q0tYclY0eWpzR3BXVEJ5MWkzQzRmZ2xMaDFxZjM4dktw?=
 =?utf-8?B?UDFXbC9TeDgrYUdCZ2gwRUViVHFzdW9yL3Nia2FzM3lIK0xpaVJOcEhYZk1Q?=
 =?utf-8?B?NmpjeVJ5aEZpSWUrRWJlVnBoZEhpRTVFVE1xNkdTTnVUZzF1SXpMemVIQ0x4?=
 =?utf-8?B?SzVhTmMydEVQTFdhc291VmJNTUY1RWttSzN3eVV0eGlJeVdORnRzV3RtaTZX?=
 =?utf-8?B?dktEUU5RdG85UkNVY3lzeEFtL1NnZTUxVHNKZTg1K0h5bHpXcVFORjBzWFlU?=
 =?utf-8?B?UCtoM2UrZWVGL1JRZFJucTB6K0RJNzlHb2gwR2RKc2tTT3dhY2cybkVwSUJH?=
 =?utf-8?B?MFdBcU1PUkk4d2RFWmVuYUdNVFdrMDRRamxjc25DRDVqbG1wRWtXdERpWHZj?=
 =?utf-8?Q?K8wCA8g36R3Mhi+URPxSU6iijy6i28SOHz48g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWtRVm00VEZzRmxsWDluejUrcm1rdmtLbnRaR2RJQ1htMm9ZeWUvY01HOCti?=
 =?utf-8?B?Q05obDVtRUxLK1ZtaTBUdjJTeExjQmI5VnROZjFJOW5ZbUltRHhTNGZaRldG?=
 =?utf-8?B?WGNSZi9LbHhRVW5remJ1cTNmSVZGYnEzaFFBd3R2TWNTajNsQ0RpRDRUTjlQ?=
 =?utf-8?B?bTRWcWRHMnFxOG5jQ25naGZyRHNXdUlGMXUzdGZmN2VVSVJnbDJJVjJVdUxG?=
 =?utf-8?B?bG04c0ZVZW1Mejd1NFdaU2N3b1B4MVh3WmpyOTR2cUVTNTZTeDM4UURBcHJH?=
 =?utf-8?B?MkNqZlZvR3pIOEZkNmNVNWZ1TnFKVDczdUg5clA4dVRIQ1NPQzA4STNubFpu?=
 =?utf-8?B?VWpOMWZERjM5OVZOR0FNYWp4UGN4UW9oYk81OVlyS2JlcVN1QnUyWmtQbzRt?=
 =?utf-8?B?UUdwQnFmYWtFckdQdjl1QTVzQmc1eldWaGpaN0JwS0pONWVaNnl5VStUU25s?=
 =?utf-8?B?V1RPVXBrbC93MVY5S3dINy94Y28vZWpZRFBIbE1IUHpQNEwvaHVYVUQxNy9l?=
 =?utf-8?B?aGVJaGdvUERwZDd0dEh6VjhBZUZXR2JLaHRnK0RDSGFZR0VJeG1EU05DcHlh?=
 =?utf-8?B?bmZOTHVaMzl3NmZSa0FGaTJ1L1VkMm5odWl0NGRrQnA4NmNpdCtHZmtWbXlE?=
 =?utf-8?B?VlhEMmV0d1IzUG03V20zaU1IcC84RUJYN2gwSXVHTTFkYXFwc1ErN0hwb1ZP?=
 =?utf-8?B?OVVORVFlMWRWS3M5L3ZZOEdFNWN2L2pNWXB2b1ZxNVdUS0lzeGZRbitZY2Nv?=
 =?utf-8?B?c3BBN1kyQlFCZlhhUmtSOEpPZ0ZwcVpLaUVScThsenJwYVF5YmV4QmFpUnRh?=
 =?utf-8?B?VGdqTHpLODdhVlhIaU9GOVVkb2tLRXV1Vy9acDNYd3VwNy90MGljWURvZnI2?=
 =?utf-8?B?QUszVjZ0SEhobWJ4Q05uc0dxOEU1NUhDaitDc0hoSXB3a0N4Q3lDWWhWbjFR?=
 =?utf-8?B?OUxFbUNBL0tKRUlmT2hrcUg3N2FVVXJGaXZRWDhWVTc5ZHcyMy9VVnlvaHdI?=
 =?utf-8?B?TmVPS1poN20vOEhCT3NOamo3WXFDeVczZDZUa2FIUVJCQmZEaHFrUXZheWhU?=
 =?utf-8?B?TzdHN3lyamd6TWM0N1hSeVVOS2liUXFVcHRoMFNlLzFKZmlHNTU4OUJvVDVu?=
 =?utf-8?B?bUNnSVNxNlJaaEJjanpxVWhwOFhDcmpraFdGNzlqL2lVSUErVjNTWGJucXNF?=
 =?utf-8?B?U1VSbWFkMUdObnhlREc5cVlkbHdSbG45MitWZFdGRFdxclZNTUE0Kyt6QW94?=
 =?utf-8?B?d0ZvZG1aVERsUXU0V1ovR005U0JFdVdBNm5GeFZwVUc1OHJoOUhBUCtTQWlz?=
 =?utf-8?B?U1lUOGp6Kzg5Vm9OcWlwZWE3VlZhN3NvQ0xlQUpSUXZjUTFEd2FKVDZremd0?=
 =?utf-8?B?bkFHYnZMTVZ4dUNnZjNyUjI0Y05Ld0Z0REUwdUZmM2RPV2JRVHVIMFFHWkVl?=
 =?utf-8?B?WWZzNXBaSHloVjYyazU0NVpLZXRJcHhEUElYQ1l5MS9zcFYzbVIrWjNPZ2RI?=
 =?utf-8?B?UmVLUlUvL2wyVFlzaTBnSzdBMHI0QVd2Vzlqc3NaNytrakdPQnFDQyt2Wmh5?=
 =?utf-8?B?Y1p0RHBFUDI2c0xNQzhGZmx5SFkrM0I2aWZDaVhKRlE4MnAvaHVxa2FZUnl6?=
 =?utf-8?B?RWE3R3IvMldWNlBpemR6TjJEcXhuZjVTVG84d3c5RGd2NnZzWmg0dTBJQWQ3?=
 =?utf-8?B?VVloVkpUTVpPNFZob011OVhQV2M0R2dMNnAyTkV0OEhBS1hPTy9NLzdXNTda?=
 =?utf-8?B?WVZyTllVeWpYM3RnU1psUVhNQnJUb2dSZjhVOHZxdVRGRSsxVnRJZGlYUURt?=
 =?utf-8?B?VHp6VUNFY044K1lRYjV3dmVJMDJWR0RRdklKVnE5ZVZ3eVNOelYvcDJRQzV5?=
 =?utf-8?B?WnR0a2NpYzJlOWJSajJmS3R3ZEVhL0NUTSs0dGVDMjdOVi9jUmduZm9FWVJj?=
 =?utf-8?B?M2p3ZzdkWUZqZlJGMHd2VGl4Ny9pbk9YbkhPODZVWGIzU0dGQkxLS1lkVmQv?=
 =?utf-8?B?M093cnJMN1UvRkF6Mlg4Q2F5SWFaQ05GLzgrMUdEV2lDYUY0WWNjM01MeGVO?=
 =?utf-8?B?Sm56Z1ExMmcxVjRmSnZVdExXR0NhS0lCbWJxVnNDVEEzN2d3cVFxdUtjMFEw?=
 =?utf-8?B?dmd4UkpaYWwwV3k3NzA3NTloVWxoSmZQcVdJeTNpUXFNVHE3dWRmUVU5am1B?=
 =?utf-8?B?T0JCNEdiaC9FWFhmZVFhVU40OXN4SHhWN2JXaFlsenpneURjMEdiZDhJbVZM?=
 =?utf-8?B?M1hWSnhVdTVEcVJwZmpQRVY0aHlnPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8deca2-481f-46af-4fb3-08ddd342afbb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:35:52.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqAn0/Z5MDnCdy9HwcPxoXbks9tCxhvMP0hPQ9gD1uloGGfhIg3EO4phO5g/D4TQ+/OOKF9E04MkPQ8ndHK8uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

On Fri, Aug 01, 2025 at 05:18:57PM -0700, Jakub Kicinski wrote:
> From: Maher Azzouzi <maherazz04@gmail.com>
> 
> TCA_MQPRIO_TC_ENTRY_INDEX is validated using
> NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
> TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack
> write in the fp[] array, which only has room for 16 elements (0â€“15).
> 
> Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1.
> 
> Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP adminStatus")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3: repost for Maher, email problems..
> v2: https://lore.kernel.org/CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com
> v2: https://lore.kernel.org/CANn89iJNKR8uBNrRCdqs-M6RspvgSK9+vxzfvXe3xUvDT538Lw@mail.gmail.com
> v1: https://lore.kernel.org/20250722155121.440969-1-maherazz04@gmail.com

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

