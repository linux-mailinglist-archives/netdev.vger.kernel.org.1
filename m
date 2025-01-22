Return-Path: <netdev+bounces-160375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5DA19705
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02D116B427
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978D215166;
	Wed, 22 Jan 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KSMIwplu"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF734C9F;
	Wed, 22 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565124; cv=fail; b=Gvn+zZHViGOXtDKzx0BzviLCCaLwvs/em/o9E3sDZMumwOnfBrPsfeDY6ZCl+4mtIOo9gwyclZdeL1T1txvsLVOOdzQkxe3Oi/0rblizADLgvLc+XQfpFX1qJasNr5ujnLcnNJuEDWP7wZM0c6FR2gJIFql+A/1bOpji+7y1v0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565124; c=relaxed/simple;
	bh=QztrVMCSLr4uh1JQztlN61Nd9pBoS/VlSXXBL1w6aIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+tT/Dgru6rafSPufzG0VF/KqBw+pDLWwPrc/nfxl5eGgSi66DS0GYYI/CQR9uojq5Po6G5fsvCzljWJvRBW2/VNVQovK666JuGmqqunUuNQdQkUU2/D9o0hJV5j8O3MQzDVGPPZiUVYEUgbcEIhm5NMmcmcdCe0y5VGfTfqLWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KSMIwplu; arc=fail smtp.client-ip=52.101.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTI+1DPTidsNbpRvYz0GzLR1HxHpgoVGMgMOVssq2osJFrLmjNrXmdfISkzY5Q7RWLqgBV+IkZ3AlSTqgdGMYZbgl1l+DEVSkyp8YVAYiKgJCCv/cTok3CBJKtlKM5JscXaJiqKz+cSDvcm4yr7i+kGLPucu3imHPr/rthsz1jeIsGTX7J6CnTnlNFbpVBjiyi5Gx+lokRYiMyHuqmlstjVB4El4x/UG0bH2I74w/edPudCe3+ARgTxv0ex5LpJRU3xBPoGRATPJyywonsB96Ont4deK4TSFerNx6GdXUvxJ/3+wPzYzn7GjXZ09ANZIsWlCSovuLI8/K2FVz+1rEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CpdxvD1NmQ+UUiuvLDGtdaFcgDv02/dQ4lR1qv/+Hw=;
 b=tKioeJ+eIHHBhjEo4wZ4SDHaseZMR+vaYXsUGHnbfhpdgKeBE2wUyRk9hs45seqaewcuzr6NpvCEiOvuf1ee1Dz/+4eTYHJH4eeudXz8mtypz4eaUgyBrThEq7yJsdtbQvuTUN5z0tF0HA9DGXbVsxQJk7Igh5ZbI1dk3fJz7EbDVcznE+oGLPVYDXU/NAuNMFhQmDNBxtMIdnEFBB6k5n+yq6W3iVAXQa5t5GVlv1Ma7uJSCOEwZ1LbBzUt0vQtJNIY84I4VgMT3Cqw1zlErtYAYXZxUe2Rukv6fW2ScT+TkTaBqWdFCIBySIi5nj7hTdEwB+KDmX9tT7eK7cz5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CpdxvD1NmQ+UUiuvLDGtdaFcgDv02/dQ4lR1qv/+Hw=;
 b=KSMIwpluOD4aNHXVZA287g1DjilMWSrQ9RwRsFQ60C9aGIlP9odejKW8bCd9V1zE5/XBHKt9tARAA4VHU4JXZXxvyYxLjAg6Xr8MDhpc72r5+TH6s8n98xDkFzZ5WlJeJMEFksd+BtlUor4GTAaL9KwsXPmQT7gUQs4JWC6gF8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5065.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 16:58:40 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 16:58:40 +0000
Date: Wed, 22 Jan 2025 16:58:37 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
Message-ID: <20250122165837.787867ba.gary@garyguo.net>
In-Reply-To: <20250122.224635.1710391280729820874.fujita.tomonori@gmail.com>
References: <20250116.210644.2053799984954195907.fujita.tomonori@gmail.com>
	<20250122.214920.2057812400114439393.fujita.tomonori@gmail.com>
	<CAH5fLgipKcAk55r-KCYTh4JTooGhAv42kUU_L46=g-tUSo5n+A@mail.gmail.com>
	<20250122.224635.1710391280729820874.fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CWLP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:56::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: e1781b0e-9177-4aa1-6970-08dd3b060517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y21mZjhYVlhOVllhNVdTb0JZdWhUZGdqNE9BOHNBNHN1SzRsMDZIK1BCTzYx?=
 =?utf-8?B?NkI1WGlua3V6RDM3ZWlIdFJNNFdpV1FCSkZZcm9hZUYvYlhXTm04bTFzUVhn?=
 =?utf-8?B?Zy80TmUvVFB2ZVFPTTh3N2pib015THZqdUdoNEFsT2FNZ2tCZG8zNlVwRGN6?=
 =?utf-8?B?bWNucFBFYjZXZ0JDU3RxZkVuNEl0L3Y0L1pHTnFVQzBMcUZZMStabWlnWnky?=
 =?utf-8?B?cklFUlBESDFWczZkbkRMNlZ5U084blR3UlVubGdFWFFrQVNydDl0dmhlRTRq?=
 =?utf-8?B?ajEzRlF6eS8xbkhrKytUYUJCYUM5TDRNV1V2NXZVa1FYNmRmMG9wTCt6VE9J?=
 =?utf-8?B?NzRrOG5TU2h3bURUbkF5UGIxN293c0ZxZWhIaW5hTHp2Y1JydVZQYk9Mbnl5?=
 =?utf-8?B?QW1ZUDZCNkt3c1J5QmRZdUlUZlJOWDlrQU43NElHUWN6cmg3T0FsMXIvTEd3?=
 =?utf-8?B?N0Z3MUlVWkFsd2ZnUFVCSXV2WVVROUsyTndmVXRtR1Z0b1dBUlFYb0FHeFd0?=
 =?utf-8?B?QmpYOTgvWmpMRTlFN082R25LcmM3WXFoVmRHUXhZeVRDMHRibXRwUVBkSVRR?=
 =?utf-8?B?UTZEOWMxeXUvK25OamJUNUduQm1QYnd4RXR4TklDU3h1NWdzMEFOamdMQVY3?=
 =?utf-8?B?RFEzWG96Z09HQ1M1THk2YnhCZDNxZnJEYjYwQldMbmVCTXhadUdwaTNSYUtL?=
 =?utf-8?B?RDdkWW1HYWVtV0xTVU1QWnlyRHZHUWxBRHdzRFFBZUJPOHFzSzBrVUsycUR6?=
 =?utf-8?B?WjNmMmpmcDdZUU80MlhLZEZtaEVNM1NqTE1aRVY4c0VGUG9lUTd5OGVIUWps?=
 =?utf-8?B?V2JRSW45T2hydzVxajg5S212anNQZldJOFFKKy9qVUdreE1CSkp2SFRSK29l?=
 =?utf-8?B?d3BNaHJOSVZaTkJndjFUdVZma3FGSXUwek1ocVpyUVczTE1zcEMyQklCNjhT?=
 =?utf-8?B?TjVjeWhjZ0N2Yk85b0dSUTVtTW4rSEpManUyeVpqQ0tiYWRqMHp1S2tvVS9L?=
 =?utf-8?B?MGt3dVZjZ2Y1SklhV250V04xYjJEMjBOd0NoUDlHT1R0UzdMWTZZSU00ZjRQ?=
 =?utf-8?B?YmNteHJTb1NXb1MycDJQaktocTZRS3lOTHlNY056S3N3QnFYazZHUmtIcFI2?=
 =?utf-8?B?Vkl5aldVOHBlNEw5ZlUrOWVmMkI2TGpIdVg3RjJITFJOL1o2QUs3WUhSTTVl?=
 =?utf-8?B?WmplbW9vQ2ZOalhBMngxcVFYa3FQckErSSs0YzI0YnlGZTRKOWtER0kzcnhj?=
 =?utf-8?B?Z2RZZW40eE80T0Y4eEI2UzVTY3pDajR3SjhCVU1nV01VeklsamVySDdWSUw0?=
 =?utf-8?B?ZUE5b2l5RGhoM3Y5Zlhhc1I3TGxudUlIMFJXa0RKR2ZscUYzNnp3dmxIVkV6?=
 =?utf-8?B?Z29Ra2lhZ0RmUzhEOWN5OFJhR3o1Y0JvZUNMbmVudElCc1JyN05QMWpSc1cz?=
 =?utf-8?B?a0JXbkNhbGE0MkZjUTl2ZFYyOGZtdVc0TkwrY21ScG90bHR3cVIzNHlySmVN?=
 =?utf-8?B?SEtJSXhJVEE2akRQcGZrL0NEamd5NG5od0RBTmRSOGloZUFBYUVPUjV0eWJH?=
 =?utf-8?B?bWtwNElrQlkzazA2eHZ1ZkNsOXYxMGlhRWl6U3RFT3VPVzAvUVlJL0ltN3Bj?=
 =?utf-8?B?VWRsNHd2aDlvZXNhSGxSMFlyMjRlMUZGVXFRenJ5aEZ0MTlJWmtjQml3UnhH?=
 =?utf-8?B?K0JFT040K3IwdGFDUEdocjJDSGpJeSt0Z1Jibm9jMjB2UFgxc3NMM1ZQZGlC?=
 =?utf-8?B?ZzV5S25QYXExQVBrWG5zRy9UT2tnYzIwV082cktaM09XVitIbUEwUG5SUWc2?=
 =?utf-8?B?VlhqZjBVRE1jY0tKUjFUK3lvTEsyNFp1cFFtNkM4VnRvZGdxWjlnQmYrTVJz?=
 =?utf-8?Q?VcXHUo7RqpV/Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S21ZRnl5bUNRT2VRNnVUdlJBbmVEenQ3eWh6MVJLNk41MncwdTRKMThUaFhV?=
 =?utf-8?B?Um5yVUNPZElTVkhGSGduU0xld21Jd0ZZRHBDZTNoM2RvclpiN2sremVLdTlP?=
 =?utf-8?B?RHpJMmZGV0d4MURka1RCeE0ybFBwMTNmTGFpd0gvT1ZmVXprOEFnOVZHbGJN?=
 =?utf-8?B?S0Z4eVF6Ym1sbFY4UTdWMGwrbXJiNjJHanF3SFZtSUtiSWpDZG5nZEdJV2dR?=
 =?utf-8?B?N2NJUHlkQ0JzRmc5d3VadHVIdGIxbkZPQnlKalA1a0EyNkJTTXVyclBPbkxN?=
 =?utf-8?B?MCtLeDh5ZndxQk84YVkrRU1adE1IdXFuL2hTcTlwaUdyMlZTRmt0M0pES2w3?=
 =?utf-8?B?azVqZ00vKzEvaWxmVGcwUFFveUNBSTV4MEJmUHBEZGoxeC9XeGY2a1ErM3BW?=
 =?utf-8?B?TnlXQ0MySlVPblFYTkdCbmFiZ2tJNDBaa1ZJOXgzQlZYTUx3UXJFM0k2N1o2?=
 =?utf-8?B?WVZjNTEwS1lCSWtpWS8vcGxmKzRiQ09Dai9FSHJuQnBENnhyR2hqd050enRD?=
 =?utf-8?B?d3hyOHZ4VlB3MXNzMW9jVlMrT0tOL2wzT2ZhaWk5TWdjK2lvRTNQTVZyUXJ2?=
 =?utf-8?B?LzNpNUlaMW12Mm5OdGxaRmdKY1ExbjYxUUhHN3k1NGVlV1FIYzYxdGRVL05J?=
 =?utf-8?B?UUxKZ1JGbWhSYXlqR09CbHNYNnhyallwYTMwS0ZuMFoxK1BZNDY3OC9aSlBC?=
 =?utf-8?B?MzVERkVISnZjdndIZTBVeWVrSUxHTlBFRmxJWHlwWVpsbmN3T1dHbUx1d1pT?=
 =?utf-8?B?eFhZYmRXb3dsdHk3ZkZ3UUJPWW1CNTFoRWhaMXRKL29PNVJyc3F1SFBYcVhD?=
 =?utf-8?B?OXZUUDBLWkJzbXE4VzRWZEcwR0JwdUpWNlBOcldHVkxGUS9WWi9CbnNNQ0VB?=
 =?utf-8?B?bWJtbXRhTFF3d1lvUE15UzRIUk5oUVRYVjNXNWoyelVzTDc5ajBSYVhjV1Zo?=
 =?utf-8?B?OXhJZ0hUL1E3N0hCbkRJUy92RFQxbTRqdEtEVWhmZ25hcko3TU9ob0VXb3Nw?=
 =?utf-8?B?dmdrYTRPVUtROVZMT09NQkx0MGIzQU02aEhxb0xlb1FWM1F4UzJ3SVM0RFBG?=
 =?utf-8?B?eVRTbnltYzFWcHNBOEhRQlZILzJHSHVOQUpHc255c3NueWRLcjdid1VldHJS?=
 =?utf-8?B?ak84NkM3VXdNZXZNQnMrUXo4TnpLL3BOQ1pOQ2s5R01DR215NXVYU1NTaXNE?=
 =?utf-8?B?TzlKR2dvVnB4Q1lpTDI5cm9sYWl3bXRYeUhXYW14cmNBaFlXMm5mSG9oYlVq?=
 =?utf-8?B?bG53KzV1dm1LdGNLcW5uU3NNUEc5VFpodm43dlpNTlhsSXlUSVFFejZnWjVO?=
 =?utf-8?B?d2YvaVA0MkxHQVdsQmFXY2xwQ1JGQUlRYjVMV1pwdmwrZlVnS004L1ZYRFNr?=
 =?utf-8?B?a0JpU1FQZnNDSXNWcm9RR3J2R0YzQ1lNYVNXSGJ1YkhKTFMvUGVrTjVZRE9L?=
 =?utf-8?B?dFdwUmVJT0xmcDBiOExkNHRqWXNnSExGeFB1M3lIUnQ5RnVLRlZKQXJWWUZK?=
 =?utf-8?B?L1JWWjhuVkpoa1gvUHM5L24yT2haV2N0OW9BQ29Vc2xBYmN3M2FqdXE0d1pn?=
 =?utf-8?B?WHpMTXJLN2lQelY1aEc5cmhsNnNIOUthYzVjM0ltQ3VwenIrdDB4RzJCQVZx?=
 =?utf-8?B?NVVWR0xJS3FMSkhQUlNxMXRndlg2QVppaDZ2UzJ5L0t5V2w4RVBrTms2ZFM3?=
 =?utf-8?B?Z1BCc3JvbkFOZ3hnODNzbko1eVpEOVhjeWF2b0dMQW1ZcWp5cmx2NnN1MFRX?=
 =?utf-8?B?dEZlQmV3UDFFSzFGckNwbk5BZXNGZmZTVEw4OTZlOEVNUXo3bGNoQTBLamhF?=
 =?utf-8?B?Mkp6d0sweW5xVnJsWlVySFdpMTdrYzU4bWlRZWJ1aVFiOGVtdElsT3ZBU3NU?=
 =?utf-8?B?b1Nta1FkcDdpVFFlVUlqei9xWmZma3FnUHA3K1hBZVIyS09MMFQrdHF4UTZY?=
 =?utf-8?B?aFRlZVlOU0tsaGI2Smh3KzRUeXUvNHlnTHF5SG9Oa2h5M0RUWjVSVXliREpa?=
 =?utf-8?B?UW1rTnpERkNaQlBPSy9rRnRkcm00UVc0M1U4d0RPMjdTYlE2Nkw3ZGcvQUxV?=
 =?utf-8?B?QWtkZnQvMlZxVjBWb0JKTFFhVXprRW5tcE5rSXBySzEvRmNrV2FPK0M4NmJ4?=
 =?utf-8?B?SHVPbFNDRjcvd1pXeDk4Vmg4QzBlcVNFM3diZGduVDFvanR6Ky9qM3h5cU43?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e1781b0e-9177-4aa1-6970-08dd3b060517
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 16:58:39.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsv1vhf7Zz5TrjuwvFsT+wzzwnA6hKA1kdxTnrdvd/QW93sUTEHQ36w6klLtlA7Ces+93DZJP5VnuU5frVBYoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5065

On Wed, 22 Jan 2025 22:46:35 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Wed, 22 Jan 2025 13:51:21 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> > On Wed, Jan 22, 2025 at 1:49=E2=80=AFPM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote: =20
> >>
> >> On Thu, 16 Jan 2025 21:06:44 +0900 (JST)
> >> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> >> =20
> >> > On Thu, 16 Jan 2025 10:32:45 +0100
> >> > Alice Ryhl <aliceryhl@google.com> wrote:
> >> > =20
> >> >>> -impl Ktime {
> >> >>> -    /// Create a `Ktime` from a raw `ktime_t`.
> >> >>> +impl Instant {
> >> >>> +    /// Create a `Instant` from a raw `ktime_t`.
> >> >>>      #[inline]
> >> >>> -    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> >> >>> +    fn from_raw(inner: bindings::ktime_t) -> Self {
> >> >>>          Self { inner }
> >> >>>      } =20
> >> >>
> >> >> Please keep this function public. =20
> >> >
> >> > Surely, your driver uses from_raw()? =20
> >>
> >> I checked out the C version of Binder driver and it doesn't seem like
> >> the driver needs from_raw function. The Rust version [1] also doesn't
> >> seem to need the function. Do you have a different use case? =20
> >=20
> > Not for this particular function, but I've changed functions called
> > from_raw and similar from private to public so many times at this
> > point that I think it should be the default. =20
>=20
> Then can we remove from_raw()?
>=20
> We don't use Instant to represent both a specific point in time and a
> span of time (we add Delta) so a device driver don't need to create an
> Instant from an arbitrary value, I think.
>=20
> If we allow a device driver to create Instant via from_raw(), we need
> to validate a value from the driver. If we create ktime_t only via
> ktime_get(), we don't need the details of ktime like a valid range of
> ktime_t.

Yeah, I agree on this. If we specify the range 0..KTIME_MAX as
invariant then this either has to check or has to be unsafe. I don't
think that's worth adding unless there's a concrete need for it.

Best,
Gary

