Return-Path: <netdev+bounces-180497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A273A817CC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD0719E81EA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA12550C8;
	Tue,  8 Apr 2025 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UsGO/xlw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6A521ADC4;
	Tue,  8 Apr 2025 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148688; cv=fail; b=bgMvsQZILIlYX2ZlA5jI3E7dnlMwwN8Q8tyjdyPcbdSQNFumJe0Y71V9VQa0xtnfZjKJSj+uGLvZg7k6plVR5aP2fHeTwmquUXkC/BiOB9Aj6qRk9Y45/DHtI4XkzIaodw/5DEPRCehlYpbyGYJ3DBSa2XPAOlJo5nj5WTSNOSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148688; c=relaxed/simple;
	bh=y2hwY+wGrx34pRHvRd7uAOnj3WcjX5xe+MOvWrfei+8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sVYZ8oUxSrSrTvX14c2ram34TmuUm4BtjQ0ilmocdBJrqmMRstlcRoJVMJDPiEEaIEnnVu0r6yr3kZaKSLydpz9BP1zgTy7s5wf2OjZHVifIKs6VoRyDBNFrCpUf+vaUIjMpywZZFWcoQpbgqCJoCTA8Hxi3GVofEHe6XMe0TJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UsGO/xlw; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhaAPO4mH72rq2K3AqCeCH+kpOG29nKAjopXi0wDGNtibzN19rKXC552ewJDyeGxx+W9mWtecipbaHXHVbsKvCBbE7c6Jib7vYg6Yh0Gpq7yfb9jV+onPLoPiEpqkLZ6Agb9lYmHW7nrbTWSXVgtMeMD73wHapb7bm1QDZEUOoec+ICdJUe0miWzLonWChFMCF4Pi93pesmaA6yyyQhZa3zlQUADRdMPidagtIZxKe5S6WcEyctvv1Hkts5R7Gw9Ow7wSAGXT+n3NVA/idJ0TSvDVfIOA6AWXndzxlOKC2ZRrjfbjDubF+vc+oJByVATbEhAT4AKmpJMgaaqIGsNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23ah1SVLPd/WYJ5fE7Twjap9C+G4R93kSB6+mMbMqeY=;
 b=hP4mF+3F52PJ6qvtUB4kV5MU/PITyM8TQ0xvxrV/PPmoCT2eiWcata2mmX3PkBVYmbuh0g39yW/QcK5mXSZno8+upMayV1DDHhOqrnRdMZogaMUhTOUmBII7Y45dNOsGxbcVehaHG2z8H7ZhK7HVlmah5oGO85Gp4B6IGJ+jsa1k3omRMRUqpkVI3G10FClyluy0McnM17uHQYisjQKfWcBjpb4ftAMvJb1kmlcPW/6/gbu0TntfLkR6Ld8IPW1omLT+vIA7J7ifaNtfPd2Km0Zdk8OdO846a1FgFNbVqaI5mK6H8XyMycmnNT4BwwLCeSidOu10s4T3wDtK7XiOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23ah1SVLPd/WYJ5fE7Twjap9C+G4R93kSB6+mMbMqeY=;
 b=UsGO/xlwrMGMaGu/sOPm+j6iKbkHIGtA043HqQkf2ON0EH6/NSkLj9iwZI+XorR35pDdgzIBEkn9cw6KGEu+vVrJhbsuy9ayec5A5gKlnCFn1FOUGBw7BYpntoaNU2/DxQc3NZuHxiZkcjpoHZdDFsoJx+FkMvafbJo0Sr0Q7LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Tue, 8 Apr 2025 21:44:44 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 21:44:44 +0000
Message-ID: <1168af15-14dd-4eef-b1d7-c04de4781ea7@amd.com>
Date: Tue, 8 Apr 2025 14:44:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipconfig: replace strncpy with strscpy_pad
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250408185759.5088-1-pranav.tyagi03@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250408185759.5088-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d29e4c-a8c5-4f3c-38b6-08dd76e6936f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2ZMT1RxSFhReldDUEhaTFdTQk9QY2ZUNThoeWNoYmJhakZha1RreHUxaTJV?=
 =?utf-8?B?Ymx5ZU5qQ01EaDhOL0g4SVA3cFo3SzlQS0VWOS92bnVpVk5NSkRWVzUvYW4z?=
 =?utf-8?B?TCtPa3FkTmdGWlRQQWFlWnlrM1hMSnVuazllRzV5OWhRdlp1eCtlcE51OThm?=
 =?utf-8?B?VUF0S0didE1WczBHSmlVVWJHZ3JNL0RLb1FuWUtJUmk0VE5hVEE2MStCVURM?=
 =?utf-8?B?OEY3WGdiR1NXWVV6eFNGWldaR1QwbDNGVGdvY29zWFo2LzNKTElleWJZcmcv?=
 =?utf-8?B?SFp5SktrQ2V5NjhyZGczaythTnUyeURnRmlzdzhmbWlyU0lRWUcxMWY1Vmtq?=
 =?utf-8?B?SVRzNWdzekdyUzdFY2xZYS9hb01ZN3ViLzk4MWdRSnhXMjF0dDNoVThoWTZQ?=
 =?utf-8?B?VnJDY1podjlmNjA4QWo1S2ZxOWs0TWlrSkJWTGVUTGxSR2gwWmpxdC9SU2xG?=
 =?utf-8?B?eDNqYUdJQ0I5Sm1vT0RlZS9JcENsaUlCVzlWOHVrME41b2QvaDk5QU8zV002?=
 =?utf-8?B?dGMybFBhdmNuQ1hSYmRNRTFoSEhGOXBQN1VaMGtrUDcrZG8waHdmTDdCZHl2?=
 =?utf-8?B?RGJDT3NJVnhKRDI4MXhjWWxJaXdpWldZOEhTNXJyVm9zUGltbHk5L08rTlZD?=
 =?utf-8?B?VVdQV0lxcWlkaEF3S3RTSVoxK0xTZVhSeTNtV2ZSWWJNTjgyQmVWdjlGMkVW?=
 =?utf-8?B?U1h0d2FDUnhqSjMvdjlPR3dncEFJZDI1alBtMllHbGFUaTlucGZrSlczNVpY?=
 =?utf-8?B?K2FsamRrbEF5NStOSjZDVkxmeFdHdGM5bWhRN3AxODhWbndqaFE5Q2dseGJL?=
 =?utf-8?B?M0FlZ3lzRU10MGxmZzlQOW5XMVJHMUVTUkZQZWVBcFJGcUxoRnp3QUNkWVM0?=
 =?utf-8?B?Qk1IWUg0NDlYMjhNQ1dMbG8rSkZkVkMyS1F2MDZxV3Z3blJPSE1ldThKTkg5?=
 =?utf-8?B?dUNYb2tScG93bXNFZmNubUJQT2hJV2FCTFFIcEZlOVFjb2psSDVmL29zbkF0?=
 =?utf-8?B?allKTERKcEhzVlRTaU1zd1F3NzJabGp4SmpQSnV6VVlObnBxVmtCaC9vUzBF?=
 =?utf-8?B?c0hodTlHQ0g0anloa3h3eTRsOWpoalFNOFpJaHBPZTRTQ2FIU1lXOWdHZzcv?=
 =?utf-8?B?WUEvVXZISU9ZWXozL0pHTzI2SnVmbmNBYnVxTE1qSHovNnplclpzVUE2STBv?=
 =?utf-8?B?SDFWRHlrVlQ3aUl1cHZQSWRuZWM2ejBiRVo2Nkp4VWhjQ0JjVWdtM282cTlV?=
 =?utf-8?B?eHdodFBKb21FN1gwbU5NSURuSjBBNk5sY1dFOU8rUHd0R2FNNmdncXppelpX?=
 =?utf-8?B?T0VzN3VLb2wyN3hveUc1dVJYWmRNbFFuVjJsMkZWQ2c4OFhOb2J4YXlzSDBS?=
 =?utf-8?B?QTduU3Z2Nko1YXEwZ0VuQ2NUaVRSWjUxaGQ5a3VXNTNxSy8vc3JTMEwxYXVY?=
 =?utf-8?B?aGZxWTBqd0g1ZUsrOThXc2JoYUl6YWlZcW40cER6ZnMxdnBSUmpwUHI2aXlz?=
 =?utf-8?B?RGNEMERQZjc4ekR0OXZGWkdGaW1QQ0l4dEdpMW9OdmkzRjErZ0JMVFlndDMr?=
 =?utf-8?B?dEFBYkl1Rk81SEQ4V3ovOXJscmlSV0hqSmRERUxmU1Y2Yi80NFByTGpzMlI3?=
 =?utf-8?B?RllIWk8rQmJlajNsaUpVdWF4NzBFN3FGM08zaXdncEY5OFIwSzh3Mzh5K2ZJ?=
 =?utf-8?B?MnY0Y0Nhd0pjd3Z2MkVoa3FYKzIzZDFvREpOZzN6NmRZK2dWNjcrOGZIc0hK?=
 =?utf-8?B?UDBrMEp6NHk5elBrZ002YjJEUk5DZ3ZidkVjV0NUbXhpSmNXZk1GQnV5UkJy?=
 =?utf-8?B?RFFZMUZaTFVCa0VabW44MHAyN0tiUmlJQ3l5a1Jmd1ZRRlhRZ282QmJzNW5S?=
 =?utf-8?B?bTQrOUI1QzBsYXUwdjE4cVVjbk1EQnpHZjdhZHlWUTdQNEZndnZGa3kvWjRp?=
 =?utf-8?B?dE5FSWYwQ2kwd3hNeDU2djNUemNwNnM0Q1ZKY1BodXRsbjg4YW81ZVovZ1JW?=
 =?utf-8?B?UE1FSEVvbjN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ci8yZTJwUG94TGNwRFBjYWVpNzRzVkVxTS9SRzF4N2VUMjI5YktNZ2w5ZWxL?=
 =?utf-8?B?MEJBbkVLOW5zYTFiVjEvclhxNC81RTBaNDROOHJpUW5YSldSaWZDQmVKNDVn?=
 =?utf-8?B?emxMUDhtUHErNkJmcVJSS3Yzb3JVWVNWQ01HbjZnTTBNRzl2NGlCc2VDQThh?=
 =?utf-8?B?YkpHSG5IODg2Q0toZTlmQTdlWVVmV09MaGZTMHJFckJncWlxb2E5VlZ4bDJT?=
 =?utf-8?B?QzZScDVzcm9HUVI0c1hmMkovK3B0VHF2RTNoYXFHQnh4VEF6OVB0emY1M1Nh?=
 =?utf-8?B?dTV3dmxDYVJzakdURGorMVdOVllKdzArZzNVSy9XajdNUGdLaCtBVVRieVZF?=
 =?utf-8?B?Qk5QNU1jbFdVY3Bhb29MemtDdXIvMmxYMUxqckROYnJpMjBxS1Jyd21TL1Iv?=
 =?utf-8?B?QUZROTM2Vld0ZC9MTHhYcnBOMXVDSW9sTERPRW9lejNWakczWG1Oa1NmVzBo?=
 =?utf-8?B?VGRBVUY5N05OVzlnTXhJM2NtK1ZESVlpQTh4eWIvNEtvUDc3cHZMcVBTNmtW?=
 =?utf-8?B?Z1FNeU9zRksxWUNXM3p1VGhkSXg4QnVmNnJEREdlc2Fjc2w3ZVBpQmVIeXkx?=
 =?utf-8?B?K2d6TnVWeDlUZGVpYW1CVWEvR2xUY3FHazNOMHArYXY5TUNKcHFCLzZUYU1G?=
 =?utf-8?B?bEFGRUt6bUR5SFZYZ0FJUk9rNUJFY0Uwc1B0MTRoVXQzY1JXbEw4djRVSDc3?=
 =?utf-8?B?ZnQ3cm9WUGwzWGFOMVlkZ1VrZ0lzUDdLV09VdW5vWEFyQXFGTzNkb0lxV0hV?=
 =?utf-8?B?a1U5d2FZdHhGWkJjeE1qSzExMVlXMUhYVWVqbUxjamJ1dGRtTzFnNFNZNU9Z?=
 =?utf-8?B?OG8wWFlVaENNZGkrdERMVitydVc0bTBvdjc5MlAwQTc2V2N2b3ZlQzVLUEVI?=
 =?utf-8?B?ai9HcWI0YmVCL05SWVhLVDhNbGlBb3F6aFhHbEFWZms2b25xOFhHOEJ5bWVF?=
 =?utf-8?B?dlkrWnBwT1dNRFYxbjBEZ0ZpMGJwUFMwVFF6SWliT1VHVlA4TzZvY0J1RzR3?=
 =?utf-8?B?KzNmSUpqTDFtR2t1WWZoZFpPb29BMmNqbkU1VitXN1lyeVg3cGRSK2l0M0pH?=
 =?utf-8?B?UVNNY2FrN1Nwa2ZYWDVGZ0J4T1gzd1ZscDVRZlVtTzRoQVdVS2JtUjZpRnFM?=
 =?utf-8?B?WkZralNzVEVhSG5LQWhwbFVIaDREMWNzaFZvUng5ZzRNQ2hvMjE2VlAvZy94?=
 =?utf-8?B?cjNETjBScytUanBOUVdmRkdBdXdIQTRYSmJjenArMmN2U0VYRGhFRUh6QTBL?=
 =?utf-8?B?T0JUemFORjFtcnA1RG9jZ2pPdFNiVGZEZkYvMVlsZ0RubjBjUDJZL0Y2dGJE?=
 =?utf-8?B?bjg5MjZNSTllenZsbnpyNEFsTWc1WWlEZTI2WXZvWEFSTHFacWZxbXlLUnBt?=
 =?utf-8?B?MDBZd0Y3MzAzMC9QTFoxQm8raWxJdHRwMU5wei92elhFbGdhQyt4NnlPRXB0?=
 =?utf-8?B?dzNnKzM2ZGFnYTNUQTZyNUJqeFBNZmNJUlZXVDN0M1pTLzJadkd4dVF3QmFT?=
 =?utf-8?B?SEtmZHB0TGsvZU5VTzlmZUdaVjdLc3hTMncxaUQyNTZYSWpOT0pqVGFiSk00?=
 =?utf-8?B?MUpwTDZLN3VrRjhjQ1hMREt6VjNQdnVVV3pEbFNOczEyWlQvYU0zWkIzR0Fj?=
 =?utf-8?B?Q2ZFV3EzTGQxTzRxbHVTRlZ6QUZCM2RXRFdyakU5Tk9KU2hCcjIzZC8wVytt?=
 =?utf-8?B?OHpyVTN3M0tUTHk1dHRyQzNoSE11cFBKYzA1QlFTc1drMmZ5UjN1QUhRUzBN?=
 =?utf-8?B?NTFpQVBDYnBXQm5pYjVGdXd1Qnh2MC80aS9hY0dlV0VhWUJtdGJzWldhYlgx?=
 =?utf-8?B?REV2eUdsRGw4NW12NUlQVGdzdmp3dGFZZGZWZ0FaSnpSeVFOUTBDQ1lNdXFa?=
 =?utf-8?B?S01RaXVUblhkaHlqcVdiTkRMQ3R2QVprUTllaWlZS2lmZGpqMUNWNCt4dnM3?=
 =?utf-8?B?UUx6dnc2L0dIaE1VZ0sxQWJEWDBBdmlIdjB2WjdDeXZBU1Y1TThqY2I5Nmsw?=
 =?utf-8?B?S2l0d1JjbkdrNzZoek1zcE5WTEF0YzQzQXNLUUJFL1Z4S2Y0NW5CMC9DTGVQ?=
 =?utf-8?B?VHlUaHRPb3Y3TGpIYk9JTmpNb295dEJlQkovL1JYb0oyVE9HTVJhcFpQdzhl?=
 =?utf-8?Q?ipb99D3lPwcmf08ZN1ddU2RJP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d29e4c-a8c5-4f3c-38b6-08dd76e6936f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 21:44:44.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIVVCsOLOeXWfpAEgunQzDBd+uNiwRsQSDZ7Jp/aFbdlGPWJmVkhQxBy5qea9AUbABwLw+LnUTRXNnt5lbY4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310

On 4/8/2025 11:57 AM, Pranav Tyagi wrote:
> 
> Replace the deprecated strncpy() function with strscpy_pad() as the
> destination buffer is NUL-terminated and requires
> trailing NUL-padding
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

There should be a Fixes tag here, and usually we put the 'net' tree 
indicator inside the tag, like this: [PATCH net]


> ---
>   net/ipv4/ipconfig.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index c56b6fe6f0d7..7c238d19328f 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
>                          *v = 0;
>                          if (kstrtou8(client_id, 0, dhcp_client_identifier))
>                                  pr_debug("DHCP: Invalid client identifier type\n");
> -                       strncpy(dhcp_client_identifier + 1, v + 1, 251);
> +                       strscpy_pad(dhcp_client_identifier + 1, v + 1, 251);

The strncpy() action, as well as the memcpy() into 
dhcp_client_identifier elsewhere, are not padding to the end, so I think 
this only needs to be null-terminated, not fully padded.  If full 
padding is needed, please let us know why.

sln

>                          *v = ',';
>                  }
>                  return 1;
> --
> 2.49.0
> 
> 


