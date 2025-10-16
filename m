Return-Path: <netdev+bounces-230055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC620BE35A4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A15459E7
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF232C31D;
	Thu, 16 Oct 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LtwxT8wM"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010029.outbound.protection.outlook.com [52.101.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5932BF4E
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617631; cv=fail; b=CHW0b/4KrtOyDdijWxfR3jWujFb0ArRH2aOCxgr1w8uNQ/88EvANKEhUtP30kR9YYRxT5pX2DeKIvqf+nIly24CKKSwClAdnHn3nmBjjNpsAxCMrtBdZmPyk/O2uxzyRMITgYhA6XRvwNGMbYPrmS+V18k8fBAYDp8n7BIR01UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617631; c=relaxed/simple;
	bh=ASmdW4zHhD5w9i4encgy/Q34JgcYom213njP4zDCQ14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjN5HhAPor2EPfPvcO9pN+XHeC/bq62xhIuothjPOremZ76WQrhv2XEDZNdI8knqwWw8WfmQdKkO0DwxHAZPl6zNe4LLoNpZs31AmjFuFN5mZeDAf4Qwj8cbvbYVDg2EOTShwphzHCkHTqv5N0cVgHPk42AhZkCRnFKt5/9SyNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LtwxT8wM; arc=fail smtp.client-ip=52.101.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXThIe+poWeUcHwDkts5MXSOVwvQ1eA6iFiDiDEmoMOuuLccUfbHzTELN/IDqfTKSmcHhW0RrRQ/xJmPVc+4m0UbI4iwVXu5CTc8HdV+lClVww0Fcsb5WGgKkEZCgaCmS7n9khD+IwRwfyjhvUMyO6KH11OifffXCZRMnWmDhP3R+8r7SZKPyWkq4vE1/+I05cKDYgvL3bIfJuOTfQYdmvaDzFg+FfdKZN48e4cSOAfA9Ad/B/JfO3wZr3X4qmI3OzzTjs/Zd5WjdFVr1xwY/T033hPLNjI7zQYvhPU84XOUVNVzDG8M1zMoNrmbq7Z0MghPyCubVEun4KCrh0gH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASmdW4zHhD5w9i4encgy/Q34JgcYom213njP4zDCQ14=;
 b=ydBx9YPHVpv7qEYp3z9fvTnXl5KwbXxt9k/YAwL3J4JDp7sLd4IDCf2igjSDDuGx302OwqCiC1FwUQmXEnOvHbAnMEYjPxFw1Cp6Q1U+vgbbfm4W4eVKl3jR9/IrAOX1V/3OzhwfUjAINbCzWltz2Kt8+gPziVltV1bk07D/JTv5EPBqF1CpG5FeLnUrtbGtKEerc3/8y8QVi7YBjrODaUJbfJ7Q/FwpzP4N9YQNvs6Cr1aDo/aTYtW/j8N+dBxD6+M206SjJ3lQ9nvF8DPzx8rY0H8vuWtzMq/6fmXhcnRgeShwX+UDEOrXqSZlUJeirs/dFczVQnteAApMIiFrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASmdW4zHhD5w9i4encgy/Q34JgcYom213njP4zDCQ14=;
 b=LtwxT8wMlmRw4lUK94B3L13GxyOUmkXFy6EgslfEdHVJE3poVw8WTFJ3D5It1YK5ijYkjee+5D9vjrCa/SMqSx2lmifPr1WUtzVsvFqY9pAKEHkh1ckcxI4NT1iidyPdxb1rykC/fbSjuULWF755Ihd/BaEU22/pMbGJB+Yecio=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TY7PR01MB14390.jpnprd01.prod.outlook.com (2603:1096:405:244::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 12:27:05 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 12:27:04 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: RE: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Thread-Topic: RE: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Thread-Index: Adw9xY/b5NfpgJ5gTyajqPRxZdkzngAH/RmAAAAZ2qAAAolSAAApi3Fg
Date: Thu, 16 Oct 2025 12:27:04 +0000
Message-ID:
 <TYCPR01MB120937363DC557306A11EA863C2E9A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References:
 <TYCPR01MB12093B8476E1B9EC33CBA4953C2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <20251015110809.324e980e@gandalf.local.home>
 <TYCPR01MB120933E9C8A96EE9CF617CF1BC2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <20251015162340.i7K71rpM@linutronix.de>
In-Reply-To: <20251015162340.i7K71rpM@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TY7PR01MB14390:EE_
x-ms-office365-filtering-correlation-id: f2c006d2-3d0e-4d66-383f-08de0caf50e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlFDNXRCaFdYQkh6aXlEVm5UblhDVjZ4cXl6OUY3Sk4zUy9RUnprQXNNUXFB?=
 =?utf-8?B?a2hMMk14NGp1N25STG9HOFNxT25xakxhV0lsRmR0bnluUmNWRWV1azU2dDdV?=
 =?utf-8?B?Rm5LQ0lUZDNXaVBWWWZQTkN2dGUrcitTUW8yN0d6OUY5UVhXNjZaNWdzczNn?=
 =?utf-8?B?b1YrRXc0TU43ckI0Z0x0VVkrU2xjK0VQQjlXZkFzMFVaZ0t4SG4vL1Q2b2xU?=
 =?utf-8?B?TkNMZDNZTXgzRXpyMXcyVDNkOUxUV3M0K3ZlUEYyOWIydFlrVURTQitnMHJp?=
 =?utf-8?B?S3BjZE1LT1NERVNGQWg5c1FsZVUzVkN2cmcwNzhlMlRCbG9JNUdZd2Y1Q2t5?=
 =?utf-8?B?cDRKd0J2dlhaSG9DRjc2V0Ewbm1EeVlNUTNXeFFUZGVkOUN1eEhmZG5mK2py?=
 =?utf-8?B?VmNKK0piRkxTelJKeGN2Y0x6MjhXeVY2Nnpoa0ZwZFBPTkQwb0xsb00zdTRT?=
 =?utf-8?B?bUNUWWtvV2VrN2tmaTVYUEphdmtsMlo3Mkl2L1lmdElKMUtJem1kYjZ3NUxl?=
 =?utf-8?B?Zmh0eFZTRmNWS0VFQjM2NElNT2JiZ0xCdWVWcVFMdURFamd1WHkxRHhQR2dG?=
 =?utf-8?B?Y1daZW1JeXpPQjlyMmMyL053MldORGcwWmtPNUE2U1BHallKRUxuSEVtY2NX?=
 =?utf-8?B?NTU1QzhHbnZkUWR1czc1eHVFdFh5MXhpOWFCWXJ1bkwxQ0J6OVdySTNreVZF?=
 =?utf-8?B?aDB5a0RQQW1ibUMrM2c3NHdwbGVFcmx6OXJUNGRTek1DUkM5RjlvMGloQ3lB?=
 =?utf-8?B?amtPVDN2S3pleHQ4ZExzZzNSb3hXQmJTK0JVaDhvWlZKeVhKa1ZHYzNoTDBr?=
 =?utf-8?B?TllPakpsY0NYa3hQV1JtRm1IOG9uNjdhKzRwcDFpQWIvVTZrSW5BRlNoRmJO?=
 =?utf-8?B?cTAzY0kvQ1dvQW0rNHhQTnU2N2laS0RlZVBnalJka0dmQnRuRE1Xd2EvQy9K?=
 =?utf-8?B?NjE5VVRVZzAwZTJKLzY0UW1WVlYrMmtJcEp4SnoxSWRPczF6dDJwaG1KaWY3?=
 =?utf-8?B?VzV6a2w5NWFxYXlwbldjYS94anptS0QyZjB6SUt0Z1pjLzc4MnI5STNYQjJ5?=
 =?utf-8?B?dVp4emZiU2t6UzgwKytJY0lKTlZTejM5bVl2TGQxR0p0QXkwTCs1WmQrRCto?=
 =?utf-8?B?UGdyUXVTWThPRTM0aGRKT2Q1STFVZkQ0V0xMcDRaZnhET29PTjVtMTBhVlZN?=
 =?utf-8?B?WjRLNXRYTlBLdTFvZ0FrbENCMjhaTTNvVmNKVEo4Z2FTcXdHTmh1NkN1WCtI?=
 =?utf-8?B?b3pkVSt5RTluRXNCMVM5NkF4Y3RDSUZsRnMyQjdPTXR2N0RGZUliWlczVksx?=
 =?utf-8?B?RVEwSkI2dFEra0lWZ2gxTG1vbW40dGtDcTlXN2tuMjIrY3owWEdkRlZ2YW4x?=
 =?utf-8?B?ZTdMa1ZzalhydWpuaDBKelV2QkhFSXRKVmdORDZHOHRkSDdMUTRFa2V2Y3ZZ?=
 =?utf-8?B?ZklLY2xNRDJ0UTUwK25pelFRTy9keGdoSnBkMkJMVzdsV3hBSElxa3FPMVBF?=
 =?utf-8?B?YlJXa3NlTUhqZ1B6K1RzYXBacDRicU92ZHU0RHFxenlnVVVmb0NzcU03SGJO?=
 =?utf-8?B?TnB5MzZ3RVc5UWdSLys5SHdGT0hyd0ZJYjFabTVhbXpFdTU2ejNOeXVUVHFZ?=
 =?utf-8?B?bFFXKy8vbkVWa1YrT1N6UXhrOVJiRGViQzM1L3BFVlNha1IyOGVXVmtFdXpW?=
 =?utf-8?B?MXJIT3Z5NmFPaWJaUnlROGlodGl1WXZPYjVzTFlwRTFKMGV4SmwySGhkNG44?=
 =?utf-8?B?dkt2dEc5bGV5YVVYNk05T0JRQXFsVlNaT3NJM0puZXNTTUljRXMvQzAzVlV3?=
 =?utf-8?B?WlZiK3gyc0xuRHVtQk1MOEdOWGVXd29IZHZBWXBBeFdHTVlUcXFhZXB0K2xP?=
 =?utf-8?B?WVR3bStQeGdXYmpOUVBQY1E4NHRpZ3JUVUZFQk95QzMvbXYwTFJ0eVpaZVFh?=
 =?utf-8?B?LzZNVHd4RHZyMXp2bTlKeXNlaUNweXdFYkFqVUhGWTJYN2pIeld5VU5CZVZx?=
 =?utf-8?B?NXZ3ZDVPTnpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2NobXhab3o3OTZhcERvblJuSlYyWW14cWhFSndpZzExNVZ4OExHbjhXeUdO?=
 =?utf-8?B?UkJFRUZZOG5MTERqZnNFekJLSHpxcjhSV3l3Q29MV3Y5ZzZrYkExeC9DQ1Q2?=
 =?utf-8?B?QnA5bncwK091R0s2SE9LZllnWlNwSW52eXc5eUZPc3RhNDlYdVdmTDZNVStk?=
 =?utf-8?B?d2JBbnE5dk5rTVdscmJjclpMTHJNcDRjQkJiZ3BjRVoyT3UwV0k2NitjV3d5?=
 =?utf-8?B?azdURFRyQjltL25HUFp5RHo3cDFPKzZvU1c3czBSbnpLVkJXaUlBWXFUNVZG?=
 =?utf-8?B?QnRvYnBQYzFwOWcyWVozZFJQTXZoMUNCeVVqanVHakxwbjlFN1BpK1lIOGJH?=
 =?utf-8?B?ZmxqSnVZQUdxc2ZxRXdpbG9RMU8zaGJOem9SNlI2azNkUFdHbGY2L3V1Qzdl?=
 =?utf-8?B?QWg3T1pRdzVvOTFSYVpKd1BKRmxHYytKNTg1alVaR0kxeWcwSkRoTUwxaUVO?=
 =?utf-8?B?cjU5VFdBWjRrd3IyMld1bG1TcytzY0c1L2FzQ3J3Z2lKMFZCMzB1eHhxWjd0?=
 =?utf-8?B?TW9KRWpCWDRmVHBhWHQ3THoyV0djWkI0a0o2N3NtMW43Q3VuOUYvaGkwbkcv?=
 =?utf-8?B?ODVNTW9XVkNqZlpTWWwxc1JPZU04QS8yVEtkSUJuMVp3dTVvV0hnQ0J5czFL?=
 =?utf-8?B?Y3ZIY21zZy9FRWtYbHpNdXRlZ3FGRGlLRFVoY0NXVG95RmNUQW9aNkVXMmR2?=
 =?utf-8?B?eEZzNjBlUjB3THFMMlRSejFldWNsVTd5VmIyZk5UZnIycE5VZEl3ZmZuS3Ja?=
 =?utf-8?B?Z0xqY3ZlZTg1TFlqTlpFcDNaUXZidHlFbXhWNGtRSFBpKzZtdmxIK0gxZVox?=
 =?utf-8?B?dXpBTFhHbGkwaHdLNDJ1aHNxRTRYbEc1VWlQQXNHU2lvVFVwWktwNkNUQS9n?=
 =?utf-8?B?TWtCNmkvZS8zZENOcjZGNlZqakZMQmNKZlpneFpGN2swdjEzcDZqSTE4VExu?=
 =?utf-8?B?NWcwamp5QzhHSVRBamRPaGV0UEVpSXZIQ21IQy83bldWOGJrRm42ZzJGUDUr?=
 =?utf-8?B?TW5vSU9SY3psZU1sbld2UTRYTDk1UHpUSG1DRDVxRUV3UEpPOEtFbkZ0MitQ?=
 =?utf-8?B?K3hadFhIb0EwdmtoaG9YS0ROZU5CY1d5aXhuOTBoTWNZUGVjN0tTQ0MydjJR?=
 =?utf-8?B?WitHZ3BuNXFIS1JNdGJhUVdCU3Qxd3pqMm1CLy9ZVnUwRmtGMmRxUWV6MFNs?=
 =?utf-8?B?aU1aN1c1ZWt4RGNBQ3VDa1JMZ20xbVdoMHVWRlBOV0RQSTBad2l3WHRxaGFS?=
 =?utf-8?B?bDR2VC9ZZmJrRmU2a29IMGpGemFRcW9DV1pUOTFTQkJFMmI2a09qSWw0T1JT?=
 =?utf-8?B?MnY5ZlRjTVFJR2NxTmxtVHJJMVJuQTBTYTBUQ0FTOEIrOUV1VUtSRVhYMWRP?=
 =?utf-8?B?SzZ2VHNsWjhRcklacFZaaUxxM3YzUUNTZktsOFlpc3dMSDIwNXU2eUU1UGFq?=
 =?utf-8?B?aXF5SURWQUtSb2g5ODhZaVBGN0p3R0M0aUFsbDB4ZTNIeExzNUdMWklJU24y?=
 =?utf-8?B?UzM3WVk5SnJORHhwSCtSSkl6VE0yVHZVY2hiR0ZPOFJxNzZ6UXZEbGZIMW0r?=
 =?utf-8?B?a3dQSU5NWEp4a0tvWTZKaGxPb3R0OFJxeDRLVkpkRnh4MVMwbCtoUmR6ZVhW?=
 =?utf-8?B?cy8rMi9WS3NmcFpJbVQ2TjllZ1djc0Jlbno1QjAzbWJCUU5RSDRWVUVBK1RI?=
 =?utf-8?B?MEFJZnlnbmtiRkxRbS9sYTNybXh3MitaQ2NZaTI4UHluSGFaUnRVOHFaekdl?=
 =?utf-8?B?RU1TWU9rUVJlRGl2ZkgyNFYrdmlSNkN6eXQ0RitWaTdkMy9Ub3I1V21kd0pM?=
 =?utf-8?B?YlhmRzI5Rm5EQm9rMDRhejB6ZGxPWVUwSjRDT2tLQTFJZjFzcEI2N0V0UUto?=
 =?utf-8?B?UDU5cUgrUzJrYzlUVTBHNWVSTEEwZ0twZDY2T1kvZEJmeUpNMEtZVWpSSWNv?=
 =?utf-8?B?NHBqdk1JUWFjMlZoMUdvTnpXOHRmM1pMQi95bHcrWFZsOE94SEdPWTVnenZN?=
 =?utf-8?B?eElaaW84NVdodGo2eFhxUUg3bFNlb1d0RUpPNnNuUmxCSVI2UGEwVXczVDNj?=
 =?utf-8?B?NWovNGJFM25HZFVnb1k1NWxpWDNVa2pMaW1kNVFvS0tmejdCVHVKazFqTjla?=
 =?utf-8?B?S09oM3VUUDRaWDBvRkhiaEdsUldWbFdHUmFGVjkydTRXNTZNT2tSbzl4Q2Z2?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c006d2-3d0e-4d66-383f-08de0caf50e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 12:27:04.9113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGfWCMdD9BOnSkxu8aq9tK/HCjz9Bw8FJDep79VNi3S3XbIcd4iV13y1QwO0zUdWw2HnnJS+WfvpTiXGlIbcy4SW5ZPlZE6OkhplPnC+OQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14390

PiBGcm9tOiBiaWdlYXN5QGxpbnV0cm9uaXguZGUgPGJpZ2Vhc3lAbGludXRyb25peC5kZT4NCj4g
U2VudDogMTUgT2N0b2JlciAyMDI1IDE3OjI0DQo+IFRvOiBGYWJyaXppbyBDYXN0cm8gPGZhYnJp
emlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gQ2M6IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0
QGdvb2RtaXMub3JnPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsg
a3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgYW5kcmV3QGx1bm4uY2g7IGNs
cmt3bGxtc0BrZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ydC0NCj4g
ZGV2ZWxAbGlzdHMubGludXguZGV2OyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5t
YWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFJFOiBRdWVyeSBh
Ym91dCB0aGUgaW1wYWN0IG9mIHVzaW5nIENPTkZJR19QUkVFTVBUX1JUIG9uIGxvY2tpbmcgbWVj
aGFuaXNtcyB3aXRoaW4NCj4gbmV0d29ya2luZyBkcml2ZXJzDQo+IA0KPiBPbiAyMDI1LTEwLTE1
IDE1OjQ4OjQ2IFsrMDAwMF0sIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gPiA+IFRoZSByZWFz
b24gZm9yIHRoZSBzcGluIGxvY2tzIGNvbnZlcnNpb24gdG8gbXV0ZXhlcyBpcyBzaW1wbHkgdG8g
YWxsb3cgZm9yDQo+ID4gPiBtb3JlIHByZWVtcHRpb24uIEEgcmF3IHNwaW4gbG9jayBjYW4gbm90
IGJlIHByZWVtcHRlZC4gSWYgYSBsb2NrIGlzIGhlbGQNCj4gPiA+IGZvciBtb3JlIHRoYW4gYSBt
aWNyb3NlY29uZCwgeW91IGNhbiBjb25zaWRlciBpdCB0b28gbG9uZy4gVGhlcmUncyBhIGZldw0K
PiA+DQo+ID4gVGhhdCBhY3R1YWxseSBnaXZlcyB1cyBhIGdvb2Qgd2F5IG9mIGdhdWdpbmcgd2hl
biBob2xkaW5nIGEgbG9jayBpcyBub3QNCj4gPiBhcHByb3ByaWF0ZS4gVGhhbmtzIGZvciB0aGlz
Lg0KPiANCj4gT3RoZXIgdGhhbiB0aGF0LCB0aGUgb3RoZXIgdGhpbmcgaXMgdGhhdCBpZiB5b3Ug
aGF2ZSBhY3F1aXJlZCBhDQo+IHJhd19zcGlubG9ja190IHRoZSByZXN1bHRpbmcgQVBJIG9mIHdo
YXQgY2FuIGJlIHVzZWQgaXMgbWluaW1pemVkLiBZb3UNCj4gY2FuJ3QgaW52b2tlIGFueSBmdW5j
dGlvbiB0aGF0IGFjcXVpcmVzIGEgc3BpbmxvY2tfdCB3aGljaCBpbmNsdWRlcw0KPiBzb21ldGhp
bmcgbGlrZSBrbWFsbG9jKCwgR0ZQX0FUT01JQykuDQoNClRoYXQncyBhbm90aGVyIHZlcnkgZ29v
ZCBwb2ludC4gVGhhbmsgeW91IQ0KDQo+IA0KPiA+ID4gcGxhY2VzIHRoYXQgbWF5IGhvbGQgbG9j
a3MgbG9uZ2VyIChsaWtlIHRoZSBzY2hlZHVsZXIpIGJ1dCB0aGVyZSdzIG5vDQo+ID4gPiBjaG9p
Y2UuDQo+ID4gPg0KPiA+ID4gVG8gYWxsb3cgc3BpbiBsb2NrcyB0byBiZWNvbWUgbXV0ZXhlcywg
aW50ZXJydXB0cyBhcmUgYWxzbyBjb252ZXJ0ZWQgaW50bw0KPiA+ID4gdGhyZWFkcyAoaW5jbHVk
aW5nIHNvZnRpcnFzKS4gVGhlcmUgYXJlIGFsc28gImxvY2FsIGxvY2tzIiB0aGF0IGFyZSB1c2Vk
DQo+ID4gPiBmb3IgcGxhY2VzIHRoYXQgbmVlZCB0byBwcm90ZWN0IHBlci1jcHUgZGF0YSB0aGF0
IGlzIHVzdWFsbHkgcHJvdGVjdGVkIGJ5DQo+ID4gPiBwcmVlbXB0X2Rpc2FibGUoKS4NCj4gPiA+
DQo+ID4gPiBXaGF0IGlzc3VlcyBhcmUgeW91IGhhdmluZz8gSXQncyBsaWtlbHkgdGhhdCBpdCBj
YW4gYmUgdHdlYWtlZCBzbyB0aGF0IHlvdQ0KPiA+ID4gZG8gbm90IGhhdmUgaXNzdWVzIHdpdGgg
UFJFRU1QVF9SVC4NCj4gPg0KPiA+IFRoZSBmaXJzdCBpc3N1ZSAod2hpY2ggaXMgdGhlIG9uZSB0
aGF0IHNwYXJrZWQgdGhpcyBkaXNjdXNzaW9uKSBoYXMgYmVlbg0KPiA+IGFkZHJlc3NlZCBieSBh
IHBhdGNoIHRoYXQgd2FzIHNlbnQgb3V0IHRvZGF5Lg0KPiA+IFdoaWxlIHRoZSBpc3N1ZSBhZGRy
ZXNzZWQgYnkgdGhhdCBwYXRjaCBpcyBub3QgcmVsYXRlZCBpbiBhbnkgd2F5IHRvIGxvY2tpbmcs
DQo+ID4gaXQgc3BhcmtlZCBhIHNlcmllcyBvZiBkaXNjdXNzaW9ucyB3aXRoaW4gbXkgdGVhbSBh
Ym91dCBsb2NraW5nIGJlY2F1c2Ugd2hlbg0KPiA+IFBSRUVNUFRfUlQgaXMgdXNlZCB0aGVyZSBh
cmUgY2FzZXMgd2hlcmUgdGhlIGRyaXZlciBnZXRzIHByZWVtcHRlZCBhdA0KPiA+IGluY29udmVu
aWVudCB0aW1lcyAod2hpbGUgaG9sZGluZyBhIHNwaW4gbG9jaywgdGhhdCBnZXRzIHRyYW5zbGF0
ZWQgdG8gYW4NCj4gPiBydG11dGV4IHdpdGggUFJFRU1QVF9SVCksIGFuZCB0aGUgaXNzdWUgaXRz
ZWxmIGlzIGZ1bGx5IG1hc2tlZCB3aGVuIHVzaW5nDQo+ID4gcmF3IHNwaW4gbG9ja3MgKGFuZCB0
aGF0J3MgYmVjYXVzZSB0aGUgY29kZSBkb2Vzbid0IGdldCBwcmVlbXB0ZWQsIG1ha2luZw0KPiA+
IHRoZSBpc3N1ZSBhIGxvdCBsZXNzIGxpa2VseSB0byBzaG93IHVwKS4NCj4gDQo+IFRoZSBkcml2
ZXIgc2hvdWxkbid0IGdldCBwcmVlbXB0ZWQgdW5kZXIgbm9ybWFsIGNpcmN1bXN0YW5jZXMuIEl0
ICh0aGUNCj4gdGhyZWFkZWQgaW50ZXJydXB0IHdoZXJlIHRoZSBOQVBJIGNhbGxiYWNrIGdldHMg
aW52b2tlZCkgcnVucyBieSBkZWZhdWx0DQo+IGF0IFNDSEVEX0ZJRk8gNTAgd2hpY2ggaXMgaGln
aGVyIHRoYW4gYW55IHVzZXIgdGhyZWFkICh0aGVyZSBhcmUgc29tZSBISQ0KPiBwcmlvcml0eSBr
ZXJuZWwgdGhyZWFkcywgeWVzKS4gVW5sZXNzIHRoZXJlIGlzIGEgdXNlciB0aHJlYWQgd2l0aCBh
DQo+IGhpZ2hlciBwcmlvcml0eSB0aGVyZSBpcyBubyBwcmVlbXB0aW9uLg0KPiBJZiBpdCBnZXRz
IHByZWVtcHRlZCBkdWUgdG8gJHJlYXNvbiwgdGhlICJ0aW1lIG91dCBjaGVjayBmdW5jdGlvbiIN
Cj4gc2hvdWxkIGNoZWNrIGlmIHRoZSBjb25kaXRpb24gaXMgdHJ1ZSBiZWZvcmUgcmVwb3J0aW5n
IGEgZmFpbHVyZSBkdWUgdG8NCj4gdGltZW91dC4gKFdoaWNoIG1lYW4gaWYgdGhlIHRpbWVvdXQg
aXMgZXhjZWVkZWQgYnV0IHRoZSB3YWl0aW5nDQo+IGNvbmRpdGlvbiBpcyBtZXQgdGhlbiBpdCBz
aG91bGQgbm90IHJlcG9ydCBhbiBlcnJvciBkdWUgdG8gdGltZW91dCkuDQoNCldpdGggcmVzcGVj
dCB0byB0aGlzIGlzc3VlIHNwZWNpZmljYWxseSwgd2UgYXJlIGdvaW5nIGludG8gdGltZW91dA0K
Zm9yIG90aGVyIHJlYXNvbnMuIFRoZXJlIGlzIGEgYnVnIHdpdGggdGhlIGRyaXZlciB0aGF0IG9u
bHkgc2hvd3MgdXANCndoZW4gdGhlIGRyaXZlciBnZXRzIHByZWVtcHRlZCBpbiBhIHNwZWNpZmlj
IHBsYWNlIGluIHRoZSBjb2RlLCB0aGUNCkRNQSBwaWNrcyB0aGluZ3MgdXAgd2hlbiB0aGUgbWVt
b3J5IGNvbnRhaW5zIHRoZSB3cm9uZyBkYXRhLCBhZnRlciB0aGF0DQppdCBjYW5ub3QgcmVjb3Zl
ciBhbnltb3JlLCBoZW5jZSB0aGUgdGltZW91dC4gU28gdGhlIHRpbWVvdXQgaXMgcmVsYXRlZA0K
dG8gdGhlIGZhbGxvdXQgb2YgYnJlYWtpbmcgdGhlIG11bHRpLWRlc2NyaXB0aW9uIHByb2Nlc3Ms
IHdpdGggdGhlIHByb2JsZW0NCmJlaW5nIGEgYnVnIHRyaWdnZXJlZCBieSB0aGUgZHJpdmVyIGJl
aW5nIHByZWVtcHRlZC4NCg0KPiANCj4gPiBUaGUgYWJvdmUgcGlja2VkIG91ciBjdXJpb3NpdHks
IGFuZCB0aGVyZWZvcmUgd2UgaGFkIGEgbG9vayBhdCB3aGF0J3MNCj4gPiB1bmRlciBgZHJpdmVy
cy9uZXRgIGFuZCB0aGVyZSBkb2Vzbid0IHNlZW0gdG8gYmUgbXVjaCBjb2RlIHVzaW5nIHJhdyBz
cGluDQo+ID4gbG9ja3MgZGlyZWN0bHksIGhlbmNlIHRoZSBxdWVzdGlvbi4NCj4gPg0KPiA+IEhl
cmUgaXMgYSBsaW5rIHRvIHRoZSBwYXRjaCBJIHdhcyBtZW50aW9uaW5nIChhbHRob3VnaCBub3Qg
cmVsZXZhbnQgdG8NCj4gPiBsb2NraW5nKToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9u
ZXRkZXYvMjAyNTEwMTUxNTAwMjYuMTE3NTg3LTQtcHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJw
LnJlbmVzYXMuY29tL1QvI3UNCj4gPg0KPiA+IEFub3RoZXIgaXNzdWUgd2UgaGF2ZSBzZWVuIGlz
IGFyb3VuZCBDUFUgc3RhbGxpbmcgb24gYSBjb3VwbGUgb2YgZHJpdmVycw0KPiA+IHdoZW4gUFJF
RU1QVF9SVCBpcyBlbmFibGVkOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQStW
LWE4dFd5dERWbXNrLVBLMjNlNGdDaFhIMHBNRFI5Y0tjX3hFTzRXWHBOdHIzZUFAbWFpbC5nbWFp
bC5jb20vDQo+ID4NCj4gPiBUaGUgYWJvdmUgaXMgbW9yZSBsdWNraWx5IHJlbGF0ZWQgdG8gbG9j
a2luZyBpc3N1ZXMsIGV2ZW4gdGhvdWdoIHdlIGRpZG4ndA0KPiA+IGhhdmUgdGhlIHRpbWUgdG8g
ZGl2ZSBpbnRvIGl0IGp1c3QgeWV0LCBzbyB3ZSBhcmUgbm90IDEwMCUgc3VyZSBhYm91dCB3aGF0
J3MNCj4gPiBoYXBwZW5pbmcganVzdCB5ZXQuDQo+IA0KPiBJdCBzaG91bGRuJ3Qgc3RhbGwuIEZy
b20gdGhlIGJhY2t0cmFjZSwgc3RtbWFjX3R4X2NsZWFuKCkgYmxvY2tzIG9uDQo+IHNwaW5sb2Nr
X3Qgc28gc29tZW9uZSBzaG91bGQgb3duIGl0LiBXaHkgaXMgdGhlIG93bmVyIG5vdCBtYWtpbmcN
Cj4gcHJvZ3Jlc3M/DQo+IFRoZSBzZWNvbmQgYmFja3RyYWNlIG9yaWdpbmF0ZXMgZnJvbSB0cnls
b2NrIGZyb20gd2l0aGluIGluDQo+IG1lbV9jZ3JvdXBfc2tfY2hhcmdlKCkvIHRyeV9jaGFyZ2Vf
bWVtY2coKS4gQXMgZmFyIGFzIEkgcmVtZW1iZXIgdGhlDQo+IGNvZGUsIGl0IGRvZXMgdHJ5bG9j
ayBvbmNlIGFuZCBpZiBpdCBmYWlscyBpdCBtb3ZlcyBvbi4gU28gaXQgY291bGQgc2hvdw0KPiB1
cCBieSBjaGFuY2UgaW4gdGhlIGJhY2t0cmFjZSB3aGlsZSBpdCBnb3QgcHJlZW1wdGVkLiBJZiBp
dCBzcGlucyBvbiB0aGUNCj4gbG9jayB2aWEgdHJ5bG9jayB0aGVuIGl0IHdpbGwgbG9ja3VwIGFz
IGluIHRoZSBiYWNrdHJhY2UuDQo+IElmIGl0IGdvdCBwcmVlbXB0ZWQsIHRoZW4gdGhlcmUgbmVl
ZHMgdG8gYmUgYSB0aHJlYWQgd2l0aCBoaWdoZXINCj4gcHJpb3JpdHkuDQo+IA0KPiBMT0NLREVQ
IGFuZCBDT05GSUdfREVCVUdfQVRPTUlDX1NMRUVQIG1pZ2h0IHNob3cgd2hlcmUgc29tZXRoaW5n
IGdvZXMNCj4gd3JvbmcuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBvaW50ZXJzIG9uIHRoaXMsIHdl
J2xsIGNlcnRhaW5seSBnaXZlIHRoaXMgYSBnbyENCg0KS2luZCByZWdhcmRzLA0KRmFiDQoNCj4g
DQo+ID4gQWdhaW4sIHRoYW5rcyBhIGxvdCBmb3IgeW91ciBhbnN3ZXIuDQo+ID4NCj4gPiBLaW5k
IHJlZ2FyZHMsDQo+ID4gRmFiDQo+IA0KPiBTZWJhc3RpYW4NCg==

