Return-Path: <netdev+bounces-159695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98188A16766
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 08:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49BA165B41
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2F18FDD0;
	Mon, 20 Jan 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="DZuDJCvm";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="aBbxqG0G"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay119-hz1.antispameurope.com (mx-relay119-hz1.antispameurope.com [94.100.132.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21418FDC5
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.132.111
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358388; cv=fail; b=Jz+Idyb4pDZoZESsYPkc+X6AwqYYXCtAMaLWPvyDYOdUC3wVSuNyluxaaOyM7kdvPpFAIVOZS+7xoeYKWtLwr0SFxYDD/XrPBI4H198PyYG4+N3+CmU9LnEka1njDtbAGmUgnKDrdnXOdvfHz1QU5wvnHOjb1gAWYR7XKz5+X5s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358388; c=relaxed/simple;
	bh=Jd3DnU0WkH3wbR4X+HefGbhZv431K5arKlbbTgRNlBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwzVBeMByevQxqUy55AM1g1yPCHi+NAmEN9nzQ3aZJHDs6OqNjE/gUfAZtyMTpqNB2ns2bAxPyZrVCUsWOlT018ITlefOjSzFL9u8k5uYQiuXusD6hYQHOvJhquYEAiKiWm/msEB5Ym3hzKN7TCQgXoagTY1zbsWZNnEFNqAt5o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=DZuDJCvm reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=aBbxqG0G; arc=fail smtp.client-ip=94.100.132.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate119-hz1.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=40.93.65.4, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr83cu005.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=hQ3LYAl9d7b4VPU4mEnFxHE99VIZW4WI0I5bsTWaoC4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1737358316;
 b=ALbTJ7nSZPhawEfORCgW+cQcvLACHFuaNHFzppWE2bDr0yQicEe9nwzUJCXKXgy2sDfv1eKn
 QOKTe78KN/uEi4asMAtAU485mrYyitMbwEXhh3RZMEl6Owix8Z/M5YdgV8Xe0RrI6ks/AO62MpR
 6MnnhmzDg9Cb70Hr1Po6u4JTIdqgi4KkKRtQP9/cMMpM2KLyDU163YSWeMhlgxMMi7eLFBrPq2n
 Kw/RJ798YE/n12VkIgvgEt7LEv6phRxYjxKYI6KlyfwbiZFSXGXg924V+EdqLw2HVGon/l+pBI9
 7WLwxeb+4kZ7lM9nQ9zMc+OHLiabd/dzzaY0ML4z9tjtA==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1737358316;
 b=BmzrCJiRCMUXo1gLxfBgh/qs4YmsOM7v5cQS/vrkZ7msTyTj1qOV+sp/vRmsTSvtOtl2t2y9
 BcYLLNhEr5ekOL5zrGfwVX0AUj0wWacK8ceEKKL5c3Joh4pKYhhsxh4p+FfSO1y1v4Vh5i8pfyW
 USpOvQwxDRPGus1n6sv5gbZ5qdoMdQmcKCRkK5OmdKq9CN2yWLRljiysQmqoXw74ecLPpA8zPjO
 czAkNTbH39TUrq7lcN2J8ULSlgcVJGGWQRH7PdJMpiEW3kqpPG/xWKiX90aJ8L1smDzB5Xr5Isd
 5UHKXqYBoLyYMR16hI3j445gBcwS7UrY2eQMDco+zt8Ig==
Received: from mail-westeuropeazlp17010004.outbound.protection.outlook.com ([40.93.65.4]) by mx-relay119-hz1.antispameurope.com;
 Mon, 20 Jan 2025 08:31:56 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP//pTxuLD63PCFVdMk8kBjQ6F8S3VRD/UcD1eCorOD7t8y8jEWUMRw/mjjL2a0FqQOEhCksnTNnRimaVml+61LNefl886PDuTu6cklZzy/NI4GB1pOOAJl9YZiiJrQ6MqW8dQesEvjOJYb1u50R9fzdiQL3Ume+V2+hTUAtWFG3snKPq7V2PkBqJnkk9m854F6BGflrDIeacy3kCWi9VR4p4UazNGIzN3Gbq+nkoTy2iiP0Y7eZOJ6H4fkaNHM6qFWd+AUEjn0UdIy8LeRf/vARMi26RXAm4lfdg2KUMbYyMTqbi7+D2I0CCER8rv6RLx2MakALUIVrwihEUltx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ3LYAl9d7b4VPU4mEnFxHE99VIZW4WI0I5bsTWaoC4=;
 b=TyGHesrTMNplhN6E0VyDu77Soj/JqlsqzqggmydYQLflPKbCyfH/IKTTAwn39+sgVY3PTWjoHf2JnhaU8fGuUvz6Da7WIskXddRvH5+uxBRiKA5Fp4XV+1BvSwXM20mHfGGCT14j60PwsshH73v3c75ud42H2rFboHA1ol/JyE/m6yR4kkwGgxmhZHC5ICO/YdUGpRpcXDbagxT5TcY0VNSii9nV7CXe4wGJ8zqsD+SC0p3HnHLFGw+stkDrpMHDLv2orhL9IkGv1o4GVV25/d9mV+DAyD5eEl3+oljnLMDqS+K8ob+BZzRrAO0gelROOyASfYk+5SSCPo1U87lhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ3LYAl9d7b4VPU4mEnFxHE99VIZW4WI0I5bsTWaoC4=;
 b=DZuDJCvmv4gdx8Hvk89vvdmDVUbvchCbQeZ3WlWjJMsKm4XPtDfQb6Lpidy7082VEk7ss1shtKEFuXEUUrZonPfMXfE6MFcn6Uv0eO5uVCOXG0E2ISXN++irh+OTcGGTnkYFfQpubJzVziKkpRUq7Kf9qi8NSej0JjO/jw9TFmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:204::16)
 by AS8PR10MB6946.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Mon, 20 Jan
 2025 07:31:32 +0000
Received: from PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9]) by PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49c9:32c5:891b:30a9%6]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 07:31:32 +0000
Date: Mon, 20 Jan 2025 08:31:29 +0100
From: Stephan Wurm <stephan.wurm@a-eberle.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com,
	WingMan Kwok <w-kwok2@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in
 fill_frame_info()
Message-ID: <Z4370QW5kLDptEEQ@PC-LX-SteWu>
References: <20241126144344.4177332-1-edumazet@google.com>
 <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
 <Z4pmD3l0XUApJhtD@PC-LX-SteWu>
 <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
 <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:204::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4948:EE_|AS8PR10MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: b22aee8b-0ec0-4729-fc8d-08dd3924763a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STJoM0FZNXJ1dkpuOEFKK1U2d2dvT3FORjcvdk5CdTZPU1EzdlRQN0NWRzQv?=
 =?utf-8?B?ZHN0Z1pJWFhIV2lHRGdWZkVPd1hrckJ2TXROaGEzZnoyTmdHMkU4WWY5cnFJ?=
 =?utf-8?B?Z1BIUkxJdXNpMHF4ZzcwbXBaSkJLM1pnQXRyU3JuWkIwM3NsZjRyYy9URjJY?=
 =?utf-8?B?WjEvVjBCTlJLYWhtZUtWWEJHeUlsNFdZZUdubUcxdWFhTks4YlkyVDRObW80?=
 =?utf-8?B?ek9zMWRwTkZEMUhhYzNmN010Nld4bHFzWWZMOUpxbUlJRTcyWDdqZlljYmVx?=
 =?utf-8?B?WEVteWRPN0hoVUVnSlJZUWorOGZTK0tSQzA0akloOFU5UXZ5TkhXUkFEYXM3?=
 =?utf-8?B?bThlRHBoZENJY0YvQTJIc0FTaUpDbDlRV0JjRXFKWGpzbHJFWElBdmhFWVZG?=
 =?utf-8?B?eG95VHV0d2FRMVdac1pvT2NXMDVCcW04SlE1MnVRcUdEdnRPRUNXVFAwaktE?=
 =?utf-8?B?NUZlRnYzOFRGTUVMRi8wYUJRZ2V0TzBINkNHSEc2alpMeGNtayt0Y2k1dUdX?=
 =?utf-8?B?czdjL25vZFAxaUNDMm9teDV0dnNyL3ZIZEdHalQyd2FDdUdxbzFkL0FISVdV?=
 =?utf-8?B?M3hoUEtaVWxKT2VnZmNxQ2h5K2ZsdVBXT3hHUi9iU0kxZW5zOUVocWxESVlO?=
 =?utf-8?B?SjU5MnFoTTczMEljUkQxQkNFcUlxa0ZMT2ZzWjhmZkdhc3RYcHk0eThDWXd6?=
 =?utf-8?B?V0IxQUkyZkRLTlFDbG5pWVcrenpoUjJ6bHF4cWlYemhkM3luazg1WW52bzlC?=
 =?utf-8?B?ZFAzeHZRTllBUUJNUndvYzRRdlk5OTM5Ymp3bHFpWkswMHhISG5DZmVXSlZF?=
 =?utf-8?B?SC9mR3RpY0FuZ202UGs2Mk9JL3BLWnZ5OFVXY28zL0loMUtqMWY4eHpqcmxs?=
 =?utf-8?B?S0V5TCtuaW5ESDU3R3FmdDd4Tk1SQ2VMMlhVNmFBaGlwNzl5TnpoVU1MUlBp?=
 =?utf-8?B?SW5OUHUrUEFqdC96bW9VNEVrVFBYZWVHTHpzZUd5dVFSWm9SeGtpWldTdElk?=
 =?utf-8?B?N2xFUFY3OHUzS1FHTUxoZEh0cW1idFE4THFRT2VGWmMxS0xRY2ZhWWl1V3A5?=
 =?utf-8?B?MVNYN1dNUVRZanpwcEllVnluYmlDdVZicjU0ekVWU1NudUlGcThXU0JXSXF2?=
 =?utf-8?B?R1daSGVxWTQ5VkcyMFBDMUQzM21JdXY0dHNGWjd5NXlMczhOSWlHWDlpcC9C?=
 =?utf-8?B?Sm5uTW0vOE9HdlBTM0tIR2VxWEttVE91M2hVWnk5cHVha3BxUkdYUUZsc3Jr?=
 =?utf-8?B?NXBhL1MrWVI0azhSaFQ2UFBnNmx2ZXhhOWtjazJId1RJWk8vQVUzSVpiak5a?=
 =?utf-8?B?QTJmMXBwc3F0YWdNaTlFZ3p4VjlBZjc0T0J2aHBzdzFrdHgyMlZGQ3pyeHk5?=
 =?utf-8?B?V2RkU2hWWU5uYndaZFZKdE14Qm15UXF3R01hWXNQdXBUVkRZTXl1M21TMmhy?=
 =?utf-8?B?T1pjaUxoWGJGMllpZTFMcWxEa2d3cWRqVytwK1pSMlBpOHdzMDRYR210cWFu?=
 =?utf-8?B?LzF6UDFnNU5zRk0zY00vdWJFT2E2WTZ2K2YwTEd3NUlkTVBodzl2M3g1c240?=
 =?utf-8?B?bU5FS2JLL2pxOStMdXdidHVTL0QvVDYxTDFuYWIxUVVRZ0s1UnFFZlRDMVZS?=
 =?utf-8?B?cVJwUEMra3FyZ3lxNzUvMWJ2bGRHS2JpY21Ya2l2UGhXWjhwRE1CMGpCRmhB?=
 =?utf-8?B?UXErdUdCZEErS2ZqM1d3QStWM21FWUJFN2JIWXZDdFR6V1UwZkVWQWFGQjZW?=
 =?utf-8?B?SDVURTlOYjVxYytudXFGVWRMMmNJanVJcThGNUVaY3BabkMxeGNSbzJQMGpG?=
 =?utf-8?B?MVJGNElZbXNXTUFpQlQ0MFg2ZGR0TitFc25yL2xmOVZScFFhRVZmalhYMlFQ?=
 =?utf-8?Q?bBCsqy6vhNaeT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkNLVjZSaDYydEhQMDU5VXV1TVR3Tzh3YzZxN1VJbUZ4VWVRMnUxMVVlOWNM?=
 =?utf-8?B?YWZjLzU3ZnM4dUxhNW1xMnk5dERuWmNnYmxHL2NhbXhTbEFmQXpRcW02V1BK?=
 =?utf-8?B?M2FYYWR2cmZPbzVubkN1QVE2b1AydXJ2R0R0R2ptL2RwSUdsQm9Da2JsRFhp?=
 =?utf-8?B?SzJhVzdmaDZEaHRRSkdDcnBVU3ZKSVBXNWh5dC9MY0pRNGNZczZCTVpjdE1u?=
 =?utf-8?B?T0s4aDJhd2ZZRjAxZTJIbnBPalZqeEQ4blRIQVA5VStWS3RnTk9qWGtNaW9D?=
 =?utf-8?B?T2QrVCttVVhyN3ZEOEhKdmNJOXJUWmxDelFwd0R6aVo2V0lpSXkrL3ZlSFlm?=
 =?utf-8?B?dWZxRzhxTzI5Q1NRTTE4d3F3WjY2TjNMaEk5S3Y0eDNFQ1k2QnVaK1lTaEhM?=
 =?utf-8?B?Tm1FeW1iRnJPZXVObG0rNGtoYmJ6ZjdMNkdiRVg0VGkxUUxrY3lackdQVVh6?=
 =?utf-8?B?OFFRTHdrQmNEZDZ3VXFNOHBhQU9QME0za3owQjRabUsvMjB6YnBISnhlc21Q?=
 =?utf-8?B?MVNDYnBOeHVzQzRiQmI4WEZuMFRFS0l0SFQwMm1xVE1aako1WHdOKzZSZlVL?=
 =?utf-8?B?aXRZdTJHSjlHdXB6dEppVWVNL3lWTW5venpWTXdFcVBrN3pPcjk4SG0zM1g0?=
 =?utf-8?B?U1lTTncwYTVSMFowdFZWam5BZVduOTBGemhMcWJZSEZFR2xVdXczQldlUmNq?=
 =?utf-8?B?NGZnQThWTy8yRVlhMUJaZEI3TDc1dDNFSFBoUlRYbDZIbUhPSDE3Q1B1UW51?=
 =?utf-8?B?bDRXVEtqZytqSTVlY081N2Q1VXJvblhJQ2lpbENNSkVBSVhQck9xUk5jMVk4?=
 =?utf-8?B?MDYxUHBZd0NodHFOYmJMV1paMlE5cjZhYTd5a1RuMFZVOWtDYmFoeitUcWRv?=
 =?utf-8?B?Z0NwR2dEUS9nSE81dXFFbklrK1k2TTRhWjVlbWZGVnJQRmVHK0FEZm9uL0U5?=
 =?utf-8?B?THc1WWR5RkVVWTdiZlQ0Ym9xZkJtWXN1all0TFBOTENYR1VsRTljQWlGd3l6?=
 =?utf-8?B?L1lyR0pRdzJkbHNFeHlPL3N1L2JPRjF3L2JhdTB3bzhpc1BuelN4clQ5Zy8w?=
 =?utf-8?B?TXIvcDBCamxvOHppOWdDenVzL0psNkx1NzBSSnRKbUV5TzA5SGh2TXdwSmNU?=
 =?utf-8?B?UzAvUzZqOGpPeS9ldVljSHRzL3dBME1HOTBRY0RsUEtKemFqUHhzbGhmTTVU?=
 =?utf-8?B?STdsWUdFazk2M2h6MTJTbjBXRUs5blNXbVZNRXF6TkpwVGNyZzNRb0NvRnB6?=
 =?utf-8?B?bElWTTg1RU1ySitwRms3WUhkUGlhL1lGV3lYTTZuRDA0RXVabytGNTllckZa?=
 =?utf-8?B?MjBoVUNybEN5QVBpZ0tmVDBaVmxmSDdDWFBVMkorUEF5ZGVxRDBTZkRwcE8w?=
 =?utf-8?B?aG5oUHVHZm1kQWNGVWQwVnlUY2lvY0RzLzQ5U3dXZ2JxQzhXT0xyM2x0ZXN0?=
 =?utf-8?B?QXB0RGlZUUJNWDhtZ3FQcUNsVU5ybndERkgvYjBzS0hVQS91MCtXTnNLTS9j?=
 =?utf-8?B?U1ZBdEJMSmxyWDd6SndHcUdiS3crYXdtWGNQcUg4SDJLNDczMVZKTVVHWXRH?=
 =?utf-8?B?ZG1PTU9raDg1UHptMDZvNFF3QUt4Ynl0dG1rSlNWT3N4MDM4anFOdDcxbGNa?=
 =?utf-8?B?YVhqbkdIUnMzOGx4NHRsRmFDM2NnaitTelVTUHl2ZDVFVkZrRVJaSFdjdzJv?=
 =?utf-8?B?S2djVDFWV2F2QkFJWlpNSktScVdvUHV2K3dBUmY1Y2p0WHA2eDVFY1hvNGVx?=
 =?utf-8?B?WHhPQ3Rxc1huUXArQjIwOGRseXRJbWRnTVk1Y1Y2cEFnRnY2dm11NW94SFFn?=
 =?utf-8?B?QTlzVHAxWi81S2NidTZNQVI0SFh3TnpCL3BXQXFycFduN1l6SDArMzdTWGVr?=
 =?utf-8?B?bzVwKyt1M0NWMUpJbVNaT3JLY1FOSXF5L1Z3QVNwb1pXQXRLT2lsek5sS2Rx?=
 =?utf-8?B?WUxrMkpJdjJTM0V2aDJUaGkvbENDYXA1UUpDRHB2MGFUSWZUZTh5cjFYNUJJ?=
 =?utf-8?B?TGptVU0zUlZESlNtWjF1ekhzZWNNSjd5WjlTYkU1RU9vRnIyQWhsWFV0UklE?=
 =?utf-8?B?YnNpRXJIUUZjYmREYnVUekVvUE1INTFUbUhCQjdUZkNubDJKWmYvby9pblYz?=
 =?utf-8?B?SmJEeDc2eFY5ZGhQVXM0K05KYjcvbXN2YUR0Y1BvbVRPc0FoYm1rMTdIQy90?=
 =?utf-8?B?dVFoTnVXLzBiMHhHL29pODBYa0hGSFdpSUtYbFFXTDFOUFVIOE13QWtFKy91?=
 =?utf-8?B?VDBMZlRjVlF0YjFvSEtVWVVWV213PT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b22aee8b-0ec0-4729-fc8d-08dd3924763a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 07:31:32.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWQQH/lsleczsLi6w/Ulr/eqLOHLhlRNzmja2p6bE9TvgXwVwcDGntNgi7hQdL1N6HZFrRPqe7+V5EGtCy2BtH8Q6vJW17PIIpED+c84loU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6946
X-cloud-security-sender:stephan.wurm@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay119-hz1.antispameurope.com with 4Yc28Q14bZz4DQrm
X-cloud-security-connect: mail-westeuropeazlp17010004.outbound.protection.outlook.com[40.93.65.4], TLS=1, IP=40.93.65.4
X-cloud-security-Digest:5b7ea976c5f056461ea1f4aedd5cae4b
X-cloud-security:scantime:2.211
DKIM-Signature: a=rsa-sha256;
 bh=hQ3LYAl9d7b4VPU4mEnFxHE99VIZW4WI0I5bsTWaoC4=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1737358315; v=1;
 b=aBbxqG0GbeqYvHcRaLCZ8fa9248742jdbhs8dxh5Hi8y6pP9REYYmeNoj8HXvbWd3ave19WX
 GPTxannXiCFQuZY2mUaaG5uccT9DZEIfznHNHYjG0Zd8sGvdokM3JAzAAjIPGnMueFmPPo30hHD
 M0JTMEOVfd18dANOyB413OXCsYSsl7DCCPDdjbvsbopQxYbwxswUH0/N+c64bDm3mK3T3Pbmjtp
 9RLwNZIzYV+NL9lrDaL3egSixlvXTZhSCDDdThcxME9W0NWldrXG0yvPxpkX/9zkXelk6+jwN7z
 j5+S86GUTpgIzdw1cslKzMHM1yr8eQhOyWPD/rrRnYJGw==

Am 17. Jan 19:18 hat Eric Dumazet geschrieben:
> On Fri, Jan 17, 2025 at 7:14 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Jan 17, 2025 at 3:16 PM Stephan Wurm <stephan.wurm@a-eberle.de> wrote:
> > >
> > > Am 17. Jan 14:22 hat Eric Dumazet geschrieben:
> > > >
> > > > Thanks for the report !
> > > >
> > > > You could add instrumentation there so that we see packet content.
> > > >
> > > > I suspect mac_len was not properly set somewhere.
> > > >
> > > > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > > > index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..b0068e23083416ba13794e3b152517afbe5125b7
> > > > 100644
> > > > --- a/net/hsr/hsr_forward.c
> > > > +++ b/net/hsr/hsr_forward.c
> > > > @@ -700,8 +700,10 @@ static int fill_frame_info(struct hsr_frame_info *frame,
> > > >                 frame->is_vlan = true;
> > > >
> > > >         if (frame->is_vlan) {
> > > > -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
> > > > +               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr,
> > > > vlanhdr)) {
> > > > +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
> > > >                         return -EINVAL;
> > > > +               }
> > > >                 vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
> > > >                 proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
> > > >         }
> > >
> > > Thanks for your instrumentation patch.
> > >
> > > I got the following output in kernel log when sending an icmp echo with
> > > VLAN header:
> > >
> > > kernel: prp0: entered promiscuous mode
> > > kernel: skb len=46 headroom=2 headlen=46 tailroom=144
> > >         mac=(2,14) net=(16,-1) trans=-1
> > >         shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
> > >         csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
> > >         hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
> > > kernel: dev name=prp0 feat=0x0000000000007000
> > > kernel: sk family=17 type=3 proto=0
> > > kernel: skb headroom: 00000000: 0d 12
> > > kernel: skb linear:   00000000: 00 d0 93 4a 2d 91 00 d0 93 53 9c cb 81 00 00 00
> > > kernel: skb linear:   00000010: 08 00 45 00 00 1c 00 01 00 00 40 01 d4 a1 ac 10
> > > kernel: skb linear:   00000020: 27 14 ac 10 27 0a 08 00 f7 ff 00 00 00 00
> > > kernel: skb tailroom: 00000000: 00 01 00 06 20 03 00 25 3c 20 00 00 00 00 00 00
> > > kernel: skb tailroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 3d
> > > kernel: skb tailroom: 00000020: 00 00 00 00 67 8a 61 45 15 63 56 39 00 25 00 7f
> > > kernel: skb tailroom: 00000030: f8 fe ff ff 7f 00 d0 93 ff fe 64 e8 8e 00 53 00
> > > kernel: skb tailroom: 00000040: 14 0e 14 31 00 00 53 00 14 0e 14 29 00 00 00 00
> > > kernel: skb tailroom: 00000050: 00 00 00 00 00 00 00 00 00 00 08 00 45 00 00 34
> > > kernel: skb tailroom: 00000060: 24 fa 40 00 40 06 17 c8 7f 00 00 01 7f 00 00 01
> > > kernel: skb tailroom: 00000070: aa 04 13 8c 94 1d a0 b2 77 d6 5f 8a 80 10 02 00
> > > kernel: skb tailroom: 00000080: fe 28 00 00 01 01 08 0a 89 e9 8a f7 89 e9 8a f7
> > > kernel: prp0: left promiscuous mode
> > >
> >
> > Yup, mac_len is incorrect, and the network header is also wrong.
> >
> > Please give us a stack trace, because at least one caller of
> > hsr_forward() needs to be VLAN ready.
> >
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 87bb3a91598ee96b825f7aaff53aafb32ffe4f95..6f65a535c7fcd740cef81e718323e86fd1eef832
> > 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -700,8 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *frame,
> >                 frame->is_vlan = true;
> >
> >         if (frame->is_vlan) {
> > -               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
> > +               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr,
> > vlanhdr)) {
> > +                       DO_ONCE_LITE(skb_dump, KERN_ERR, skb, true);
> > +                       WARN_ON_ONCE(1);
> >                         return -EINVAL;
> > +               }
> >                 vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
> >                 proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
> >         }
>
> BTW, also please cherry-pick this commit from linux-6.10
>
> commit 4308811ba90118ae1b71a95fee79ab7dada6400c
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Sun Apr 7 08:06:06 2024 +0000
>
>     net: display more skb fields in skb_dump()

Applying the new instrumentation gives me the following stack trace:

kernel: skb len=170 headroom=2 headlen=170 tailroom=20
        mac=(2,14) mac_len=14 net=(16,-1) trans=-1
        shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
        csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
        hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
        priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
        encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
kernel: dev name=prp0 feat=0x0000000000007000
kernel: sk family=17 type=3 proto=0
kernel: skb headroom: 00000000: 74 00
kernel: skb linear:   00000000: 01 0c cd 01 00 01 00 d0 93 53 9c cb 81 00 80 00
kernel: skb linear:   00000010: 88 b8 00 01 00 98 00 00 00 00 61 81 8d 80 16 52
kernel: skb linear:   00000020: 45 47 44 4e 43 54 52 4c 2f 4c 4c 4e 30 24 47 4f
kernel: skb linear:   00000030: 24 47 6f 43 62 81 01 14 82 16 52 45 47 44 4e 43
kernel: skb linear:   00000040: 54 52 4c 2f 4c 4c 4e 30 24 44 73 47 6f 6f 73 65
kernel: skb linear:   00000050: 83 07 47 6f 49 64 65 6e 74 84 08 67 8d f5 93 7e
kernel: skb linear:   00000060: 76 c8 00 85 01 01 86 01 00 87 01 00 88 01 01 89
kernel: skb linear:   00000070: 01 00 8a 01 02 ab 33 a2 15 83 01 00 84 03 03 00
kernel: skb linear:   00000080: 00 91 08 67 8d f5 92 77 4b c6 1f 83 01 00 a2 1a
kernel: skb linear:   00000090: a2 06 85 01 00 83 01 00 84 03 03 00 00 91 08 67
kernel: skb linear:   000000a0: 8d f5 92 77 4b c6 1f 83 01 00
kernel: skb tailroom: 00000000: 80 18 02 00 fe 4e 00 00 01 01 08 0a 4f fd 5e d1
kernel: skb tailroom: 00000010: 4f fd 5e cd
kernel: ------------[ cut here ]------------
kernel: WARNING: CPU: 0 PID: 751 at /net/hsr/hsr_forward.c:605 fill_frame_info+0x180/0x19c
kernel: Modules linked in:
kernel: CPU: 0 PID: 751 Comm: reg61850 Not tainted 6.6.69-ga7a5cc0c39f0 #1
kernel: Hardware name: Freescale LS1021A
kernel:  unwind_backtrace from show_stack+0x10/0x14
kernel:  show_stack from dump_stack_lvl+0x40/0x4c
kernel:  dump_stack_lvl from __warn+0x94/0xc0
kernel:  __warn from warn_slowpath_fmt+0x1b4/0x1bc
kernel:  warn_slowpath_fmt from fill_frame_info+0x180/0x19c
kernel:  fill_frame_info from hsr_forward_skb+0x54/0x118
kernel:  hsr_forward_skb from hsr_dev_xmit+0x60/0xc4
kernel:  hsr_dev_xmit from dev_hard_start_xmit+0xa0/0xe4
kernel:  dev_hard_start_xmit from __dev_queue_xmit+0x144/0x5e8
kernel:  __dev_queue_xmit from packet_snd+0x5c0/0x784
kernel:  packet_snd from sock_write_iter+0xa0/0x10c
kernel:  sock_write_iter from vfs_write+0x3ac/0x41c
kernel:  vfs_write from ksys_write+0xbc/0xf0
kernel:  ksys_write from ret_fast_syscall+0x0/0x4c
kernel: Exception stack(0xc0d8dfa8 to 0xc0d8dff0)
kernel: dfa0:                   000000aa 73058e53 00000012 73058e53 000000aa 00000000
kernel: dfc0: 000000aa 73058e53 00000012 00000004 6ebf9940 0000000a 00000000 00000000
kernel: dfe0: 00000004 6ebf90f8 766a17ad 7661e5e6
kernel: ---[ end trace 0000000000000000 ]---

