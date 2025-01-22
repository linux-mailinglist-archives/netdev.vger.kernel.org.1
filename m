Return-Path: <netdev+bounces-160376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57AA19721
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AB77A4262
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1650215066;
	Wed, 22 Jan 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PUntZ3/b"
X-Original-To: netdev@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020125.outbound.protection.outlook.com [52.101.196.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE230214A97;
	Wed, 22 Jan 2025 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565545; cv=fail; b=Gc3l2d53OqMshefkw7j2g2KNOTPKm07FrWmY8c7y/elHzkbJKKvUogFLG5kWTRewWcKaEDURSZV172czcdJUq02CPsBRjhr3AnbBn/46vbmf/PobiqciB6TQg6Jafes6A7ph5g4eq/FA5wAawi8odTNmAz9UMPjBgWLyNq9lIBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565545; c=relaxed/simple;
	bh=RobzaTbOYVFN2GdSyIRCATPXTuRTJbK+3SDA8ypSdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqAOky0jleknHT7NiUm39bugFYl0WpwBSmV33+6wJi1eoaFF1gV+Gypc3xGTCiTc3sb3frxVJtKuejG0sLOVwc3cQTZaxt93wh47Ldr+7xv469orStpEudvd9MVAx0vYlMsw+nLDKtXB+WH5zzSFaCQFj7xOVtxZopRwy67xqJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PUntZ3/b; arc=fail smtp.client-ip=52.101.196.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmG8sZpM70UvbPA/MCvuz9kNtDX82H3HKvMbdYV6Nxs483InN3YyXmMj32+mTCoPD6Qm2sbR9+hanooLmqRG/6LxXs9nCVDMgcwuES2S5Ja4t5tD+1lvbPSDAbjSGiZdZYv+NUJ9mv3s+aVKgZA7UyGBmmn8xu130IRlOfDfWpVIRu8mYOCq9lhPhVvIqb7zQX+FsqZUm43DEV2WQ9YDX81Fup8uWCp9YBDZjiAeH1sVNAFlkFaLpPD+dBiJBdx7YQ++5f5A23xJEXeORkDGRAL7E3Niuh6u53SkXZ61ly26VpcODu3Db5inCEdVgeJ8mVGSv+hGPj79FwGg3udGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDfiBbzns1I6n8Gz9bMT4kh2kSAlOKCZOXoGMSyPD64=;
 b=CPOBNDtbuK6EzF1RhfoDDXu1DRZWJ/NSXphelgz+dyqHtMy4DxIYpGA8w7M8xtbUGWgnKfHUXymo4ZO7XBWS7VD4//PXvYHaY2rKek41lfitIUnTFee5Z8SForkyxtk/H0eAqKiTsJqyqK2tUICa1o87g7P+OyZNtxzXH5Bi9AtvHw+YqNohoO0qqQOBtOTJJLD6iLER134wVzQbWs1mckl7kzf9IgI5CEivZS/zti4MqcFXHAJrcQYltwh7UpZsxS60Du8B8+e4wwvsCiTblb3dXQ6tV1VJ/sqAWcuOqetG8RQyDqoNljOr204XxB80+f6D2d0QqvVsnMclHsk1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDfiBbzns1I6n8Gz9bMT4kh2kSAlOKCZOXoGMSyPD64=;
 b=PUntZ3/b50l+itkbujUBKaZ+0a2dmMvhOVaNYdaFTRbdyNYlIhBIkHIKtwo7wcbBy0NX6KOCrOjvnYO2BGB3sj6xDbx89yDopMHqR64baZ+XzloCXa9kYpPO+IEAcwC0JH/ChV0shD5dirJxMm3WjBvSLBsMqMH/wwiDJ+5Q0tM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5065.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 17:05:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 17:05:41 +0000
Date: Wed, 22 Jan 2025 17:05:37 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
 sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
Message-ID: <20250122170537.1a92051c.gary@garyguo.net>
In-Reply-To: <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-5-fujita.tomonori@gmail.com>
	<CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
	<20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0347.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 81df9166-c707-4ce0-69b8-08dd3b070035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFU5SEc1WklBMEYzcGFYZTd4bFlFVHVPNTBQZXE4R1BaSGFVVmROeDR2cnJR?=
 =?utf-8?B?RVpHUndzTWJueUQxc0c4bzZFRS9hN2VPUjJ6emZ5Um81RzJlNjdxQ3A4WG5n?=
 =?utf-8?B?Q280MjhwNlJ4Z1dOMEpFWlBSOUwxbm1RYjhJalFqWHdORzRVam5XZUtVc1o4?=
 =?utf-8?B?QWxMZS9qVG00b0UxclhoVEJKMnl1WmZHRUxjWU9acmExMTF0dHp1cTgwS2k1?=
 =?utf-8?B?d3NsVU9Za01QTHZzbU9hR1BxREtOU0tBeEVJbjJZNGM4TkN1b3Vxb2h0V090?=
 =?utf-8?B?MXMyVDVFaWIvUm1VQnlhbU92TTJyeHR0ZDBxQlQrcU1JZElvZXJMQ01XeXVT?=
 =?utf-8?B?SDNEUXV5VmtEZmtwcFJZMG1ESGoveTBQci9uOFpZYkZ4WGxMNXQ2TVl0dlh6?=
 =?utf-8?B?MU5TM0tvQUxDSEpvMEQ2WnZ2UnArNmxDSU9KT2YwQ2pCQmt1Um5hK3h1REJI?=
 =?utf-8?B?Tlk5MlViWm16VkJDWXk2eVVEb1VORzBRbXZHQ0FyL0ZJTW14QXFWSnpESGho?=
 =?utf-8?B?cjB1ZjFESHROYWlSWDNUbS9tUFd1WEFMd3VuNzVVY1E5RGlMRXNYVGRWYWdH?=
 =?utf-8?B?TEU3bHhwcXAyM3NiY1B3QUdGUmg3TGIrUzY1c2RZcGxLV2gremtmTjlQbmY3?=
 =?utf-8?B?TXJUWlZRZ05OTnJjM0xTM1ZhTVpFZmNoa1BaeDRXQ3BwYnlPV042OHk5QnVF?=
 =?utf-8?B?SU8yN2RRMGQwNkhIOERkWDlHbDYyQmdoTjFaRE9zZ1ZCUTI4YUZlT3U1M1JP?=
 =?utf-8?B?cUdva2pSZWxQazZMN2VCWmUrMGpUOExsVzh4NXlSdlBlL0JFTkxXWmFUYnor?=
 =?utf-8?B?ZllBSGhIT2QrL0VOZW5WZ25xWHBmN01xNkRxU093bFlTQ0Q2TWgrTFkwb0dm?=
 =?utf-8?B?bVFuWmZhZHVUcWh1MXM5dk5pVGZJay9BNGhFRHFJMVl3d3hzNHZrY1VEOTJv?=
 =?utf-8?B?NGJvMnBHb2h1ay92V05ybVZYMDMzNWxibXpYNksxUENSUDN4Ukw3anprd0RE?=
 =?utf-8?B?aUpzT2h5OFhZWXpvNGcwWWNFc0tqWGl3dC9xaXBuSTVXUkMwUlZzbWZ3QUxE?=
 =?utf-8?B?NGRNTTM3dmVIaDNPdGg0eHplaEZOWmtwK0pTc2hsQmQ1U2hDdVRrMUVzS1d2?=
 =?utf-8?B?YTlXb2o5UnIzU0huTXh6NnpqU3ViTFBxanJoQnhvVG92Z0kzRzVnRnF6T0g5?=
 =?utf-8?B?TmpMazZ0UjBydXZwK1piUXZCQXdrczdSM0l2MlhXS1BXK0wrS1REak9BRUVV?=
 =?utf-8?B?RzlhUUZZck1tZ1dTb0p2NS9ONTBwZWNXcm5PRy9veXNBUmE0TTArcStYUTRR?=
 =?utf-8?B?eFNOKy9sOGljeFgxNXRiRFpGbWo4eE9sTDdYV09EUDhZbXBONnJNYWxvU2RV?=
 =?utf-8?B?MFJNNGtNNWw1aDhnTllJdXZhUTgxMWNnYmJZaXg0cDNmbTB2NFFGNExBbkRC?=
 =?utf-8?B?RTZFVW55MjM4bCtVTzZEVzBYVW95cGFVZ2w0akVxSE9oVmllWWdWWVh4bW0w?=
 =?utf-8?B?OXNiOGF3aHJJb3FWeHJSN3M4SzF6OVR1OWlBMHVkaUo1bzd6aURzckI2emcw?=
 =?utf-8?B?WkViejVSY1BVWUsrNWVCaUZ2Qm45SkFsbHFBbkhjWGFFZkdmMWIweGNiNHFB?=
 =?utf-8?B?SFcrbXdrVkpHNkRQV1dGVnlIaklYTWdQemJjM3NYb0tIYlBCUTc4OEVHWGRw?=
 =?utf-8?B?aVZtY3ovQ041K0ZtUi9yTC82bGhYaWphbC9XNkhiSGlFT1lZUC85ckdIWTZL?=
 =?utf-8?B?VmJRbEF0UWdDdktBczNRMGcvZDYycysrVzFUZXB4SzRjelp5V0FjUkdoS0hl?=
 =?utf-8?B?eUV1M3ZhL3k3VWVUcXVTc0UzTU4rSU1kaTZzdWo5b3NMNHVtN3RBSk5rNnVB?=
 =?utf-8?Q?nYlhPhavP8b0Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0RFeDhYRzhRWEV1OTk5K29odWVvKzVHaFlMUVJoN2JmcmpSMW5BcmdVNy8y?=
 =?utf-8?B?aERTdmRyNDdOcUJyZmNjYkUvUndLeWlCZzNITzU2RlhlYjRkRnBTWm95dUJm?=
 =?utf-8?B?T0JVQm91b3UrUEZIa3doV1poSG03dzR2bHRwV3VKN1M4ZHpxYm01aDQ1MGc2?=
 =?utf-8?B?c042dHl2cVZNZWFKTmYrNDRqS1ZxdEVaZ1FFUllkVHE5MWFYYVA2dHZ0ak0z?=
 =?utf-8?B?ZzBQNVNDN0F0Rk56ajlGaWpzZGFyWCtod1pRQ0xyTm5FNXVLTWpVb2RrZVB0?=
 =?utf-8?B?TnhEeGVTakdLaG9paHVJbEsxdm9zdTBDb3N6eUNsK2NQNUFnMGYyN1VGNE5y?=
 =?utf-8?B?VXdrcFhiQWRVSXdBWTYzRGNGSEZBUTJyNXN1NW13K21rWXlhdzIzbnRzeDlI?=
 =?utf-8?B?QnYwOU8yQ0kvWGNxOVZIeEhkSmFZQ0o0TjRNOFRzTFdzL1dvOFRsQWtLbWhh?=
 =?utf-8?B?V1N3UUxZVklrV2piRC9mSFlKL2dPMVR3WGFGN0J6b0ZlZHdhUnB1ZGtIbVJk?=
 =?utf-8?B?eHAvMmw1RGx4WVAzZkxpYWJuaHFVRDN4YTNaUVNCNkNsU0JoVEcxb3h1YnVI?=
 =?utf-8?B?MXNDeUVuNTlVRGc3cTFEMml4ZlRFcCtKMVBNNEtHNC83V0JOM3lMUHg1Y1pK?=
 =?utf-8?B?NHgyZFFJdTNHWVlqNUluenZIODJvRHEvOFNkU0ozV3QvZDIvY0xyU1hiL2tX?=
 =?utf-8?B?b2o2ZlNIaCtsd2JYVTRTSWVaeFhGbkFqdGg3Q1pVSzRLaVdQdjNCSzNlUUJU?=
 =?utf-8?B?MUxyeU5HTDdxVzFSOG9IV01vSVQzeEpJaVJ6WmxzK1d6MWI4SmY0cDhuQ20y?=
 =?utf-8?B?SU55ME5PWEpIZ2RJcEJxQ05vYnJ1MldvVXkwT3ZIQUNrT2xFRDFqeGZmamFu?=
 =?utf-8?B?Z1ZvOERuc0tIMDFQeHpqcGliZmRNQzhCWkRTSWRRanlnQS8rV2JtNnEzeWpT?=
 =?utf-8?B?SGxBZFgrUXFYaHR0V3ZQTEhBdmVFc1RUSGgzam5pQ3ZVOXpCSFdFWDFqMU4y?=
 =?utf-8?B?ZXZoeWx2bVlMQ0F0aXBVTG9VdDN0bkw2Q2IwYmd6aVhrdVI5UlpodW1DZGRT?=
 =?utf-8?B?dHVJTFhHak13dHAwUGZEYXhmQllGbGZhVXJqWjJYRUhPbHgzZkVyR3NONFJJ?=
 =?utf-8?B?Y1JLZ2ExMjJMMGcwaDQ2L3VqTkhWUFFFUmpucEZWU2xlOUxmOW5KSFhpc0k4?=
 =?utf-8?B?WVI1Nld3RDNybytZRGxUS1I2VlA0dmx6TmFGVDZoL2NUKzlJQktTMy9RaU9p?=
 =?utf-8?B?a1dmUCtjYUNjWmRGWUllbkt5Vno5YUxLSTYzc25sOHZ4RlFIcS9PTktVTnpq?=
 =?utf-8?B?NGZ2TXBsSDQxVnhlUVhabThhTTNwNzdSNDdRb2VVVEVLYXRUYjZZRTZ0N0xn?=
 =?utf-8?B?SE8xOGUwRnJGa2hwNU1WUzAxL2ZodGhNNnZLakJhTVp0QUUrOHJZVFhLeUhl?=
 =?utf-8?B?bWEzV3ZYVUlCVzVraTMraVRjSTJuMWZBVmxmK1ZzSnFmZGtEVFVMcFBpdmZS?=
 =?utf-8?B?cDJqZ3RmRDNqZUNuQ1p6SThRbEhSRnVGNjJDcXE2VG5ha0NLeEVIWHp1SERF?=
 =?utf-8?B?TG50ckhYeWZJNFFBRGZTOUtiTzBEalpOTUxhdWFrVnIyM1pzaTkvY3NIYTdm?=
 =?utf-8?B?V09GOUpVRkZ5NGUyU3AyeG5oQU9pajQ2RVUrdW1rUzVvb25FWUJQQnd3SFI1?=
 =?utf-8?B?bGxFZ29kY2hUTytPMUw2L2F0VXNDcEVJUktWRVpMeVpYNFJTOTF6VDViNGtp?=
 =?utf-8?B?bkl0L3ZjWXI4emRTVjlvMnBpRHhVZlNneVkrbDkxYUlPYmtFTURSdjNLcEJG?=
 =?utf-8?B?Y2RLN2VnL3JLSlFmRUJGNmZyamc3R1FMZWpiVVBPajEra1NJM0hVaTduL2JQ?=
 =?utf-8?B?anNkMkRUb0ZoN09INTB0RytsR2hOUGhNZTJ5RVVFWmQ1YXlTR0thaGgxTktu?=
 =?utf-8?B?Yng5eEJvb096N2EraDQwcm10UXkxU0h0SjczT1Y3Q3lRVTVxa1d3b2pURWhH?=
 =?utf-8?B?b2g3NzlZbzNvR3FvVzRnazdOTkJGZzM2L2tQZTdQYmc1aHdoZlRUcTBiaVBR?=
 =?utf-8?B?bHh0ZS9BVVFHNjJRVG9oMzM3ZDg0SUd3RUFOZ0dpb3FjQlRvOWV3UmlQWm96?=
 =?utf-8?B?OW9NQnFIa2RZTWtWSlRVRGJXK2Era2R5UStxeGRBMjcxd25hTXdvcHRTN01a?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 81df9166-c707-4ce0-69b8-08dd3b070035
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 17:05:41.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoOR/So0eZnlIlJokFhJtWf3X8E2dmRQTmKHGpnciYZZCVaiWHKm84vqOT/eK6yL7snnlguf8qZWczn6ogxEqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5065

On Sat, 18 Jan 2025 17:02:24 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Fri, 17 Jan 2025 19:59:15 +0100
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> > On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote: =20
> >>
> >> +/// `delta` must be 0 or greater and no more than `u32::MAX / 2` micr=
oseconds.
> >> +/// If a value outside the range is given, the function will sleep
> >> +/// for `u32::MAX / 2` microseconds (=3D ~2147 seconds or ~36 minutes=
) at least. =20
> >=20
> > I would emphasize with something like:
> >=20
> >     `delta` must be within [0, `u32::MAX / 2`] microseconds;
> > otherwise, it is erroneous behavior. That is, it is considered a bug
> > to call this function with an out-of-range value, in which case the
> > function will sleep for at least the maximum value in the range and
> > may warn in the future. =20
>=20
> Thanks, I'll use the above instead.
>=20
> > In addition, I would add a new paragraph how the behavior differs
> > w.r.t. the C `fsleep()`, i.e. IIRC from the past discussions,
> > `fsleep()` would do an infinite sleep instead. So I think it is
> > important to highlight that. =20
>=20
> /// The above behavior differs from the kernel's [`fsleep`], which could =
sleep
> /// infinitely (for [`MAX_JIFFY_OFFSET`] jiffies).
>=20
> Looks ok?
>=20
> >> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit a=
rchitectures.
> >> +    // Considering that fsleep rounds up the duration to the nearest =
millisecond,
> >> +    // set the maximum value to u32::MAX / 2 microseconds. =20
> >=20
> > Nit: please use Markdown code spans in normal comments (no need for
> > intra-doc links there). =20
>=20
> Understood.
>=20
> >> +    let duration =3D if delta > MAX_DURATION || delta.is_negative() {
> >> +        // TODO: add WARN_ONCE() when it's supported. =20
> >=20
> > Ditto (also "Add"). =20
>=20
> Oops, I'll fix.
>=20
> > By the way, can this be written differently maybe? e.g. using a range
> > since it is `const`? =20
>=20
> A range can be used for a custom type?

Yes, you can say `!(Delta::ZERO..MAX_DURATION).contains(&delta)`.
(You'll need to add `Delta::ZERO`).

The `start..end` syntax is a fancy way of constructing a
`core::ops::Range` which has `contains` as long as `PartialOrd` is
implemented.

>=20
> > You can probably reuse `delta` as the new bindings name, since we
> > don't need the old one after this step. =20
>=20
> Do you mean something like the following?
>=20
> const MAX_DELTA: Delta =3D Delta::from_micros(i32::MAX as i64);
>=20
> let delta =3D if delta > MAX_DELTA || delta.is_negative() {
>     // TODO: Add WARN_ONCE() when it's supported.
>     MAX_DELTA
> } else {
>     delta
> };


