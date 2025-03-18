Return-Path: <netdev+bounces-175605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD287A66B09
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1223AA6D1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D111D6DBC;
	Tue, 18 Mar 2025 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="om8n361E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653487E1;
	Tue, 18 Mar 2025 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281313; cv=fail; b=lfQ1pzs+mE51K5KUOIjXyIftSYljyNit8fJJh2i3n2q14+MKOtwmqpnLUMLkV1X2rQm9gW0VzjTIEUR4woF7+3Jep0lPfiFfAGzX8O/EMnQWGqilCzBf9hTd8s2R3OJ1rIRhimBnruTeU+pDSL7RhjkQySRi2Hdj+OJTX/nKi/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281313; c=relaxed/simple;
	bh=H0BPSB3bJqltnxyj6Y/DcWV3y21nhT6T35J4HNRi1lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H3/UTGKGy/D3sRLH+lHu0bFsimq2pSv5cLvnQM9Ji+DDj5hwDlA0er7p+vB1Zc/UhNnBeQ9huoftZ6MDhPhujgVVAGNkHvwbfU1ILl9y/UNJnqVo8mBpMl80M9E9JX28Bto0qhnFkEKEEkRBAMz6LmTh6ZkCzmpyU5WXvVpW3pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=om8n361E; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmyAZGtQx+nKVfhaxg5Yabqt+UJ1dCoH1EEAe8/VxMxiTy+M+9DvC/gYj2WXOjaepWoiINnGT9LDTGhZFW03MTURWvw001zK3PIqPBGZ6HmKLe+7eleLNs6aR9I1K8ZOV2uQDf97Qsd5LQ3kUOvf1IIGt7xeW5V6QclNn1zjV58YJfswkrTQImzNT5o9czynOrNawSacl1dYQMUxHImenz4nAMDLlSdjwefIwqrw8sHYgMXd6ykf2YedlQfKksNn6E4kmL7e5aaEz4Bg3p7HUj5cb5yCfN2TFg29RSyl0Y8m71TiHhlxaEoTyriagP/jF9xdjoqDJYjYv6AL1fiODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0BPSB3bJqltnxyj6Y/DcWV3y21nhT6T35J4HNRi1lU=;
 b=BpP2ZtGCSHDKLRRJypOm8++kjkVNDRlgTBx/vWWLjfntjVenrs/nCyS9dJdvWpK2IQjFNSa2yubq/g80yxWQqKWiLG8xtZgXPOlaEfDoAz5EgkVBQ+4kgTPpg3p5eDnewD9en/W/qHH30uZQkhCqpaCEM4EPdq0T05kHFzUez9SoU/BQsiEshyvOeqL9MUN93sPumqqHqcNBgZMJHRSQNMO1GKEvLIZdSGWHjFhKjGnr02siAis/UohMFA6KRmisY3PrklFsuSZIl8dJVnaRf2EpWBXVeC/BHD1nIKJAoJmhAIxrf1qkTX5e4T05qlNrJQsquVDvv3MWPOSI1VWTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0BPSB3bJqltnxyj6Y/DcWV3y21nhT6T35J4HNRi1lU=;
 b=om8n361EEZ+7v/rlfWLI6AmHnyxeS9KPhELZC3N664QoqvKA4F8B2/DoQX+0IOdvsTsGZYA5YwaXw9Q0kZGPk6pPqfilEpjjOKjb1stQI1OrSWgtL4bdrpoy17Q2n/teKB8y1FNtsutzBdvWEJiDeJT8qs1NXNPOK8oddwKDuWc=
Received: from SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:01:48 +0000
Received: from SA1PR12MB8163.namprd12.prod.outlook.com
 ([fe80::e117:c594:de73:377e]) by SA1PR12MB8163.namprd12.prod.outlook.com
 ([fe80::e117:c594:de73:377e%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:01:48 +0000
From: "Radharapu, Rakesh" <Rakesh.Radharapu@amd.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Paolo Abeni
	<pabeni@redhat.com>, "git (AMD-Xilinx)" <git@amd.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Katakam,
 Harini" <harini.katakam@amd.com>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [RFC PATCH net-next] net: Modify CSUM capability check for USO
Thread-Topic: [RFC PATCH net-next] net: Modify CSUM capability check for USO
Thread-Index: AQHbk0V8Nixv4inzgEOOfy/Iu46E3bNvrRWAgAAKm6CABVFGAIADdq2w
Date: Tue, 18 Mar 2025 07:01:47 +0000
Message-ID:
 <SA1PR12MB81638B84395740F6F08D44719DDE2@SA1PR12MB8163.namprd12.prod.outlook.com>
References: <20250312115400.773516-1-rakesh.radharapu@amd.com>
 <0b1cdac7-662a-4e27-b8b0-836cdba1d460@redhat.com>
 <SA1PR12MB81631C34BCAAA27CB25E271E9DD02@SA1PR12MB8163.namprd12.prod.outlook.com>
 <67d631ae62f7e_2489c92941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <67d631ae62f7e_2489c92941f@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ee72e18f-6c08-40a6-95c0-d06413690cf0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-18T06:58:01Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8163:EE_|SA1PR12MB6678:EE_
x-ms-office365-filtering-correlation-id: 81f38e81-3821-4c65-b56e-08dd65eac059
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1RNdXZpZC9mTy8wNkNzVGorYjBMd3o1TVF5eVZ6MjNSSDRYdmEvem1zREhw?=
 =?utf-8?B?dUEyMHBuQXg2ZkF3aUREeEdReU5YQ2wxazN4dEJUYnR2L2hvZlUvaTNzMDBz?=
 =?utf-8?B?dEIwRkhtWndyWDhJQ3RqdDhWYWJiTisvQWxIUGR3c2dRRTFZbjFRMVRWZXZB?=
 =?utf-8?B?ZDRUd3MwNGxQS0JOVWlod2ZPZUN5b0lhRmI5TjVpWi95WWFuQ2dnYUIvQ3ow?=
 =?utf-8?B?N2t4MHg2WXpBRzJhdzROZVB3YjRLMkFPVE1WUWpUUU92WjgyYWJPeWZwZnRs?=
 =?utf-8?B?M2JlZ29LQUFvdXA2RmJkRWtIdFU2cGphTGJaeXRPOUtQd0h6aFNsMURxSTRp?=
 =?utf-8?B?OVlEZjVseHlIemdRczFkMlpGOWpzUXhyRHk4Rk5zdTQ4K3ZBQU5JS0xEbHpF?=
 =?utf-8?B?cU5sem9INDc3Zko0UVJobS9WTENCWXptTUlWZktZZWFpM2pYSE01Vm5UdGRl?=
 =?utf-8?B?S3VqdjArc0FDMEU5dVdvSHNMbGQyVCtYNjNpYnpmVG1WSUk2ZHEzdy9tOXBM?=
 =?utf-8?B?R1gzL1JtZytoMllIRWpjakVrbFdoOFlhbDZTNHpsTVB4TFdVeTk5R2NlTWM1?=
 =?utf-8?B?ZmJwUjk3ek4xU29vMWhNSmJiVTRSeGJkVnlMd3NEWlpjZlFtUWZkbmdQUHM2?=
 =?utf-8?B?UWtTUVJXQ29McG1OR2JKR3dsRUNoZkROM05lUkl5Sm8zeGg0aTY1aWFmTWRB?=
 =?utf-8?B?S0dUTUJuWFRPeHVoTUx1aEdJaWduNlFkNnVuSlJaK2t4M041eFQvd1ZZNS9U?=
 =?utf-8?B?bjc5T08vZG9Fa1RnQTBxTGRVR0dRUGFndDhqM1cxNERZMjU1QWN3UXA0MENm?=
 =?utf-8?B?OWhxSmpqOFAzR0NmbW5wUnc0UWJMR3NiRzVLWittQnNqaFowejgzWFZLT1BP?=
 =?utf-8?B?Tk1NSUV3cGUrOWxKQVlCYkhSRFBYQ201LytaRXZuVGdLVm9laVVtNkdLYkVt?=
 =?utf-8?B?TTRqVjFjMURKV1F6UHNjYmdtYUF2bzRXUWZWRmNYWXhHbWhVNGZxQ0NibkE2?=
 =?utf-8?B?eE1GWHFMTGJZOWowTDJtYVIwZGoxTmdMSUdnNDI3djBUVTg3Vk5JTFkyVkcv?=
 =?utf-8?B?bTBXc1g0bWdzeXhuNG9wUGx5QWh2UkRrQ24xUUsrNHJTU29CSjBlbHVhREMv?=
 =?utf-8?B?d1lwSTV1RFIrbUVjOHh2SUhiajRZdmcxS3B3Yyt4bTBxTzRnQUwzeU44SGJ6?=
 =?utf-8?B?QlllQTBRMDY0dkF2TEpSVzJwdWdBMXVqbFN3cWhvaHBaSklLTlFrZFBmdlFC?=
 =?utf-8?B?TlpiTWRQRGwyeUpyaHlQVnVkSjB1TmV0U1lnc1JGUlNNNkszYnNPTWFWWHBB?=
 =?utf-8?B?OXBoY2pxY2RYYmJtODNmb3pRN1huZHFPVkE1UGNETVMweWhmYXduNjFCWGZw?=
 =?utf-8?B?aGNtMzNPZTFLazI2VGZkeG5uQVF4Y1RFb1dITDRNVVUvc3V0aW9ITVB3Nkgv?=
 =?utf-8?B?SU81TkNkK0xTcjNMRmZnSy9vVnpXMXNWbXkrVWhXaEV3ang3NTBMK20yUGVy?=
 =?utf-8?B?VWZhVG1iR3lqZVBWK3NCUEQwYW8zMjdNRk9acEtlSExrdC9HTVhHQ3Uvbm43?=
 =?utf-8?B?clZ1ZWpqbjkrVHdOREROeTZQVFNIbjErd0w2RjZ5OTJORGV3RS80dytwNWh2?=
 =?utf-8?B?VmFoVEZWeGJ2OVpwSWFXN0ljK1RUMGoyVVRRckpvT2lsVmFndlI0MkZrcDVm?=
 =?utf-8?B?MjNaVG13VmkzaEM5UTFuMFB6bkN1U0FBZTRiYnR2TE5BbEFlSzRKVEVFR3ZL?=
 =?utf-8?B?WlRqYVVaMnFZYUdXSkpCTHZ0WTJ2RTg3bmtHYXhPWkRLMDVGVXhlbWtjMXJQ?=
 =?utf-8?B?dGpsVHhHeUd5VXgxT0pjeENHbjZHelFMaWF5R2s1QzRKRFZLWFVTdmc2Uml0?=
 =?utf-8?B?RTJFRm4xeUVObmZYODFTcDVnSFNPRXBYakZwcFlxM1R6bDN4Qldwd3MzQU4r?=
 =?utf-8?Q?iNuWHW5PGlLGlXgWmwySY8tHZsvRUAhg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFJEV0VrYnZFNndTb2V1S3UyRlFiT2pkeDV6WVRGMEFoQy8vdGZaRmlXMXhx?=
 =?utf-8?B?SDFMVnRvVW5Obk1kTER1N28xTXhGRXpyWlVJbDMvSEwybmZneGFaaFFhYyt3?=
 =?utf-8?B?ditBdjZwRkk3Ym9FV3FXdG83Y2NxU29PQURyYUxwVmdONE9Hd0tTMys2WURI?=
 =?utf-8?B?SjY2MG82ZGxBRVkwbU9YbncvVW45VWtqWnJoaUhSS2FmallRTnFUakMzK0pi?=
 =?utf-8?B?R0hjS0JEeW5PclpGem1wZUdSN2VrNTgyVDIxRENWMVJWNkFoTmYvVm44em15?=
 =?utf-8?B?anRkZGt6OUp2U3RmTnMxcG5RRE1LUExDaGxvQ3V5RWJhMW5RaVNmUXhMcEh1?=
 =?utf-8?B?Ny80aDVSeERXOWZmWGRHMFNqcnFCZjV0REdyQ2dUSU5nZ011dlUxTlVzd1BL?=
 =?utf-8?B?bnlrTXI2UCtobTNFTzRFMXo3NnpuVko5dFI0Y0F1eWVVTCtzVlUydTMwV05Y?=
 =?utf-8?B?dWxrWnhqd3J1MWZid1A5Rlh1S3orbnJYdzlQdzJ1WEtiU05FZUJkTXRwL1Ew?=
 =?utf-8?B?czlrVHIzN3lWa1dXQW54emVYclluekVQVGlibnh3UnpEZVJmWmwyWGU1ak9j?=
 =?utf-8?B?U3FpdXlJTVZNR0NRaXZmYlpndVRIclNIMHZlNWNSL2hjS0FIMW9SQ2loVWxZ?=
 =?utf-8?B?V25KRGtyYWdVT0FFL0VnUEkwSHg0QTI2WE1XLzZMLzhrNmV2T1JOZE1QK1Zv?=
 =?utf-8?B?Y1FkRkRIUVFDclBzK3NmRWhrYk9EVEpIY0daRTFmTzM3SjVzOHRZQTVmRGhI?=
 =?utf-8?B?czNFWklaM0ZQOWZUeklKaThHWXBHSTM1ZEF2dUcraFlZejJ5Tkp0eC8wdGlC?=
 =?utf-8?B?YU0xa0t5MXZnRnRubHZHcnM0cmROcURaWmRMVTVtaDVVUE1mdE1pdlduRm5L?=
 =?utf-8?B?eGx0Y0ZNTFFaNEtuSUJOZWd4QVhtSXQwWjZ3NWxVNUs0NFE0M3ArYWx0Z2Nw?=
 =?utf-8?B?TWh5QnZkN1BPeG9mM2NsbEFiUi9ZT1R1aEwvemoyRm1hUEtWYnZ4TWJZSUVJ?=
 =?utf-8?B?c0VGdUIrdWJTSWoyQTlNcnNON1M1OCsrRGRib1YwYjdXanhFMTBGM2ZxQVdi?=
 =?utf-8?B?ZVpFRklvZldrem9jU1VGanFXSlpaRlBCOFptaGlGSi9CMGtsNG41bkp4eU05?=
 =?utf-8?B?NC9MRHlEYTI3TTZpMVhYeDJaSE83Y1RiL09nUW9DejYzVHJVWXFvdFlETnA3?=
 =?utf-8?B?cVlqenZkampIOHE2RWs0RnpFL0ZjcE8zK1Y2bzRUdXR6dlgyaVREc0NwaFRL?=
 =?utf-8?B?TEZzWWNsVU1hTzZ0bVJjMSs4VWkveHlEaVZ0U2ZIbjJqNDkxWUx2UmVxOWw5?=
 =?utf-8?B?RGpPNEZNYk1wL25qbWhxRVgrRjlYZHNEeStvMHUxakp3TlAwMUhYbWVhdHRR?=
 =?utf-8?B?VkN3dDhDRW82cWQ1VEkxSUVkMU1XVkhyZnBqSnloTDV2UVQrQ3V5MnhXUWlI?=
 =?utf-8?B?clg5ZUEzUWhzaU9Uanl0alpodEUzNUJURTJwT21ZVk01Z2RZZ3JMMFprd1B0?=
 =?utf-8?B?UDh6b0xNUm10VHp1TmNuVy9SSTcvQVBJU1AvUVIxSkhoZkFnbVc5eUFaanpG?=
 =?utf-8?B?Z0s3Ync2N0ZLdmZwdThYY3JPaEhMSlNpTWN3N1MxSGc0T1hzMFdjMStsdUFw?=
 =?utf-8?B?dDRjejN4MjN4MTlxVldIZlAxWkF1MC9XSFVtdzl5czdPODZxZ2NzR3VLUlBT?=
 =?utf-8?B?ajVtRG5aKzV1QiszeTlqOURpU3ZtUzJISk5hOWxkRnQrSGJvRG9kaGVOODVV?=
 =?utf-8?B?YlIxS1loQ09oL2daY3hMdTFFS0lmNWlUU1JDcms2NC9qTnUzem94UlBLQS9C?=
 =?utf-8?B?RUlTNGJJVGIyVTNnQk9tbG1hMTJwSGNMNU1Dbk9iWHFvT0ZFWDd6aXNMYXJQ?=
 =?utf-8?B?dW03Z3hwZm9MRG50MjMyZXh4YWJrYmhsd0g2NjFzZzU3RWswekhqc1dZLytB?=
 =?utf-8?B?ZEVEWlRPNkRvQzFTSHA3RGw5Mk4wVHd1VjFwV2dFb2FwOUhydmJpQ3hRUW9M?=
 =?utf-8?B?b1FQYzh4ckE4RWsvd3dFYUZvSmxyT3ZwNlFMMmpJdW5iTU9vcUdjMEc2TGRI?=
 =?utf-8?B?dW10WVM3M0NkR2lKZmllUWJHQXhvWkJJWVBVcDFuNG83YURJNG5neVR5eTVB?=
 =?utf-8?Q?yBYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f38e81-3821-4c65-b56e-08dd65eac059
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 07:01:48.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hFbxNgCMrbAmR3oTIBqUJQA0PiS6NVz38oQwtQei30Qx6m9f5GrzC+fia4lZbZ2attx8w+r5TjwdVadkvMXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXaWxsZW0gZGUgQnJ1aWpu
IDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPg0KPiBTZW50OiBTdW5kYXksIE1hcmNo
IDE2LCAyMDI1IDc6MzUgQU0NCj4gVG86IFJhZGhhcmFwdSwgUmFrZXNoIDxSYWtlc2guUmFkaGFy
YXB1QGFtZC5jb20+OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBnaXQgKEFN
RC1YaWxpbngpIDxnaXRAYW1kLmNvbT47DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gaG9ybXNAa2VybmVsLm9yZzsga3VuaXl1
QGFtYXpvbi5jb207IGJpZ2Vhc3lAbGludXRyb25peC5kZQ0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2F0YWthbSwgSGFyaW5pDQo+
IDxoYXJpbmkua2F0YWthbUBhbWQuY29tPjsgUGFuZGV5LCBSYWRoZXkgU2h5YW0NCj4gPHJhZGhl
eS5zaHlhbS5wYW5kZXlAYW1kLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1JGQyBQQVRDSCBuZXQtbmV4dF0gbmV0OiBNb2RpZnkg
Q1NVTSBjYXBhYmlsaXR5IGNoZWNrIGZvciBVU08NCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdl
IG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gY2F1dGlv
biB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5n
Lg0KPg0KPg0KPiBSYWRoYXJhcHUsIFJha2VzaCB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUGFvbG8gQWJlbmkgPHBhYmVuaUBy
ZWRoYXQuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMiwgMjAyNSA5OjQ0IFBN
DQo+ID4gPiBUbzogUmFkaGFyYXB1LCBSYWtlc2ggPFJha2VzaC5SYWRoYXJhcHVAYW1kLmNvbT47
IGdpdCAoQU1ELVhpbGlueCkNCj4gPiA+IDxnaXRAYW1kLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+ID4gPiBrdWJhQGtlcm5lbC5vcmc7IGhvcm1zQGtl
cm5lbC5vcmc7IGt1bml5dUBhbWF6b24uY29tOw0KPiA+ID4gYmlnZWFzeUBsaW51dHJvbml4LmRl
DQo+ID4gPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgS2F0YWthbSwNCj4gPiA+IEhhcmluaSA8aGFyaW5pLmthdGFrYW1AYW1kLmNvbT47
IFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+ID4gPiA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29t
PjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCBuZXQtbmV4dF0gbmV0OiBNb2RpZnkgQ1NVTSBjYXBhYmlsaXR5IGNo
ZWNrDQo+ID4gPiBmb3IgVVNPDQo+ID4gPg0KPiA+ID4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9y
aWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gPiA+IGNhdXRp
b24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gMy8xMi8yNSAxMjo1NCBQTSwgUmFkaGFyYXB1IFJh
a2VzaCB3cm90ZToNCj4gPiA+ID4gIG5ldC9jb3JlL2Rldi5jIHwgOCArKysrKy0tLQ0KPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+
ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jb3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMg
aW5kZXgNCj4gPiA+ID4gMWNiMTM0ZmY3MzI3Li5hMjJmOGY2ZTJlZDEgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL25ldC9jb3JlL2Rldi5jDQo+ID4gPiA+ICsrKyBiL25ldC9jb3JlL2Rldi5jDQo+ID4g
PiA+IEBAIC0xMDQ2NSwxMSArMTA0NjUsMTMgQEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gbmV0ZGV2
X3N5bmNfbG93ZXJfZmVhdHVyZXMoc3RydWN0IG5ldF9kZXZpY2UgKnVwcGVyLA0KPiA+ID4gPg0K
PiA+ID4gPiAgc3RhdGljIGJvb2wgbmV0ZGV2X2hhc19pcF9vcl9od19jc3VtKG5ldGRldl9mZWF0
dXJlc190IGZlYXR1cmVzKSAgew0KPiA+ID4gPiAtICAgICBuZXRkZXZfZmVhdHVyZXNfdCBpcF9j
c3VtX21hc2sgPSBORVRJRl9GX0lQX0NTVU0gfA0KPiA+ID4gTkVUSUZfRl9JUFY2X0NTVU07DQo+
ID4gPiA+IC0gICAgIGJvb2wgaXBfY3N1bSA9IChmZWF0dXJlcyAmIGlwX2NzdW1fbWFzaykgPT0g
aXBfY3N1bV9tYXNrOw0KPiA+ID4gPiArICAgICBuZXRkZXZfZmVhdHVyZXNfdCBpcHY0X2NzdW1f
bWFzayA9IE5FVElGX0ZfSVBfQ1NVTTsNCj4gPiA+ID4gKyAgICAgbmV0ZGV2X2ZlYXR1cmVzX3Qg
aXB2Nl9jc3VtX21hc2sgPSBORVRJRl9GX0lQVjZfQ1NVTTsNCj4gPiA+ID4gKyAgICAgYm9vbCBp
cHY0X2NzdW0gPSAoZmVhdHVyZXMgJiBpcHY0X2NzdW1fbWFzaykgPT0NCj4gaXB2NF9jc3VtX21h
c2s7DQo+ID4gPiA+ICsgICAgIGJvb2wgaXB2Nl9jc3VtID0gKGZlYXR1cmVzICYgaXB2Nl9jc3Vt
X21hc2spID09DQo+ID4gPiA+ICsgaXB2Nl9jc3VtX21hc2s7DQo+ID4gPiA+ICAgICAgIGJvb2wg
aHdfY3N1bSA9IGZlYXR1cmVzICYgTkVUSUZfRl9IV19DU1VNOw0KPiA+ID4gPg0KPiA+ID4gPiAt
ICAgICByZXR1cm4gaXBfY3N1bSB8fCBod19jc3VtOw0KPiA+ID4gPiArICAgICByZXR1cm4gaXB2
NF9jc3VtIHx8IGlwdjZfY3N1bSB8fCBod19jc3VtOw0KPiA+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+
IFRoZSBhYm92ZSB3aWxsIGFkZGl0aW9uYWxseSBhZmZlY3QgVExTIG9mZmxvYWQsIGFuZCB3aWxs
IGxpa2VseQ0KPiA+ID4gYnJlYWsgaS5lLiBVU08gb3ZlciBJUHY2IHRyYWZmaWMgbGFuZGluZyBv
biBkZXZpY2VzIHN1cHBvcnRpbmcgb25seQ0KPiA+ID4gVVNPIG92ZXIgSVB2NCwgdW5sZXNzIHN1
Y2ggZGV2aWNlcyBhZGRpdGlvbmFsbHkgaW1wbGVtZW50IGEgc3VpdGFibGUNCj4gbmRvX2ZlYXR1
cmVzX2NoZWNrKCkuDQo+ID4gPg0KPiA+ID4gU3VjaCBzaXR1YXRpb24gd2lsbCBiZSBxdWl0ZSBi
dWcgcHJvbmUsIEknbSB1bnN1cmUgd2Ugd2FudCB0aGlzIGtpbmQNCj4gPiA+IG9mIGNoYW5nZQ0K
PiA+ID4gLSBldmVuIHdpdGhvdXQgbG9va2luZyBhdCB0aGUgVExTIHNpZGUgb2YgaXQuDQo+ID4g
Pg0KPiA+ID4gL1ANCj4gPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBJIHVuZGVyc3RhbmQgdGhh
dCB0aGlzIHdpbGwgbGVhZCB0byBhbiBpc3N1ZS4NCj4gPiBXZSBoYXZlIGEgZGV2aWNlIHRoYXQg
c3VwcG9ydHMgb25seSBJUHY0IENTVU0gYW5kIGFyZSB1bmFibGUgdG8gZW5hYmxlDQo+ID4gdGhl
IFVTTyBmZWF0dXJlIGJlY2F1c2Ugb2YgdGhpcyBjaGVjay4gQ2FuIHlvdSBwbGVhc2UgbGV0IG1l
IGtub3cgaWYNCj4gPiBzcGxpdHRpbmcgR1NPIGZlYXR1cmUgZm9yIElQdjQgYW5kIElQdjYgd291
bGQgYmUgaGVscGZ1bD8gVGhhdCB3YXkNCj4gPiBjb3JyZXNwb25kaW5nIENTVU0gb2ZmbG9hZHMg
Y2FuIGJlIGNoZWNrZWQuIEJ1dCB0aGlzIHdvdWxkIGJlIGEgbWFqb3INCj4gY2hhbmdlLg0KPiA+
IFdpbGwgYXBwcmVjaWF0ZSBhbnkgb3RoZXIgc3VnZ2VzdGlvbnMuDQo+DQo+IFNwbGl0dGluZyBO
RVRJRl9GX0dTT19VRFBfTDQgd291bGQgaW5jdXIgc2lnbmlmaWNhbnQgY2h1cm4uDQo+DQo+IFNp
bmNlIHRoaXMgaXMgYSBsaW1pdGF0aW9uIG9mIGEgc3BlY2lmaWMgZGV2aWNlLCBjYW4geW91IGlu
c3RlYWQgYWR2ZXJ0aXNlIHRoZQ0KPiBmZWF0dXJlLCBidXQgZm9yIElQdjYgcGFja2V0cyBkcm9w
IHRoZSBmbGFnIGluIG5kb19mZWF0dXJlc19jaGVjaz8NCg0KWWVzLCBUaGFua3MgZm9yIHlvdXIg
cmVwbHkuIEknbSBtYWtpbmcgdGhlIHJlY29tbWVuZGVkIG1vZGlmaWNhdGlvbg0KdG8gdGhlIGRy
aXZlciBhbmQgd2lsbCBhbHNvIG1vbml0b3IgcGVyZm9ybWFuY2UgbnVtYmVycy4NCklmIGV2ZXJ5
dGhpbmcgZ29lcyB3ZWxsIHRoaXMgUkZDIHBhdGNoIGNhbiBiZSBkcm9wcGVkLg0KDQpSZWdhcmRz
LA0KUmFrZXNoDQo=

