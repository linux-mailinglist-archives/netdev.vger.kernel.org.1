Return-Path: <netdev+bounces-168155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4852A3DC25
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908683BBCAA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A91B87EE;
	Thu, 20 Feb 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPDaaln0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A881BC4E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060445; cv=fail; b=eHTNqYyp13iBctfRUOEcA2PJ3y/mWOuYTbdiYU+VHhEIhP2bH16br3bdN+CzkUS/Oi3sFSe4rpFKYEVeesZcJN/dwQkg9gPcP076isMubyYbU2necPe4koG0veC/NI53uy1KEVFKfZLknGwoLcnsU5zHWWWkb1kdmtHgXjfolAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060445; c=relaxed/simple;
	bh=AoWNje1XW9+7tzeF1HoDHiu2jar4KqUIuOdNf3EX75A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GgUyjU6/kAiFPMZ6NntYlkrOCyqcAFy3p10pLZTEl7kZJr+9f9OmUCLRkV0KjR8u7oXZHGVdTaRqofPEH/JIE/+m1FcLceMaI4hd+vw502Zzbf1vQoRhyRjFCIx9723ggayiGzQNyfg1dWy4vMwDdHTqYwuVM+a4lEwQiN+syWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPDaaln0; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWEM+Wn0Kn9jvW1GD5Lg5S7bv+5I4jCyWKnLporDaXNErz7ThqUDXsNexTZ1U+hHQUb9UFuwWkPCDOveBzju6Fv2iesPeGHSIPdjmLc7ggy99leegNw7CJlDMHTPgxKXFdTe6cXHc0QKpAr7s/4F6aUsgMaEHYRHB3y7Op3r8XW5TC/HOCWU7LveJPpv/YDfPvjtvYS8yzmfVFZGuWVBxYTB7HPqh+rPVQkh+889rjee+w65/o4d5Y4QjVEUPI1zr+1XHZy4huU547t0p8n05F9cRvyP94ADrpk4tPyySef8sRnjWvfwix9U2alW3cdiW1+QUpeTe+JB435+j8LDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoWNje1XW9+7tzeF1HoDHiu2jar4KqUIuOdNf3EX75A=;
 b=DZ7gCHzaF7hshejtvRHAiLcQUsfi8DOfEU7oqhrzO1x5gMspS+Ae97Mn/Smd1wDfcaDQHsKpYOq3Gz4sbp6V/aMhUX0Gnou8qYQ87kTMlVH2uz+Uh13BjZKUlVfJ+B1GCajAnVsp7MlhGSa66IlvSxhb0LVFOJMCqnd+23TW/B/BIxwQikkjaQ81TRAKiKSjcgtEmMydn/lDb2psEbrzdkWtWj37NN0hl4q4UZHtgPd4mQW8d+Ob+eAE1oPh3pKH31LuwVaGhtV2NRXDNFe3I8++IiOjw6Qpq0AGTIQ/WzZx+vq0Y7d5Ycv5DoF/hJeFpsF1NnkMvvmUIubIuTtq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoWNje1XW9+7tzeF1HoDHiu2jar4KqUIuOdNf3EX75A=;
 b=oPDaaln0UUOw6XKkjirPrLvI6Yknau31RS7iYNGYfFRrEFkB5nOZZH5yZ4Gj8YwPva5Cg5j8elr0qoCOctJnB+iGY1BilSur6l84IZox26bT4RI3xC5tC9gQT6mdRg81c8PFaXxLK/vEtVvasogwiFnzalO8uE7WprkAdweJq0NMgVake4M9WcNXgRrtnkCcMiHHEi6WuHmZBNJcmeBNcvc6d1DchBp3QNtpuNj0AaEEI2hXa/r9GCx4Nu8ewqlHM0MFy24Ee1oClYAW1mjjSt1GVV0Bl1VoP7h979CssCPb9Pnv68uzQlc9c8Ui+zWURY25U2xzmLHvnYehVZ/ixg==
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.24; Thu, 20 Feb
 2025 14:07:22 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:07:21 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "kuba@kernel.org"
	<kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>, "frederic@kernel.org"
	<frederic@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/3] ptp: Add file permission checks on PHCs
Thread-Topic: [PATCH net-next v3 2/3] ptp: Add file permission checks on PHCs
Thread-Index: AQHbgSFY9WT8Aenod0SVG3gbvZBmTbNL8ZqAgADX9nCAA2DrAIAAC2Hd
Date: Thu, 20 Feb 2025 14:07:21 +0000
Message-ID:
 <DM4PR12MB8558E22807E8A9B082F0C3F5BEC42@DM4PR12MB8558.namprd12.prod.outlook.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
 <20250217095005.1453413-3-wwasko@nvidia.com> <87cyfgjp54.ffs@tglx>
 <DM4PR12MB855850D05B3332C4DDA0D76CBEFA2@DM4PR12MB8558.namprd12.prod.outlook.com>
 <87msegixqr.ffs@tglx>
In-Reply-To: <87msegixqr.ffs@tglx>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8558:EE_|SA1PR12MB7152:EE_
x-ms-office365-filtering-correlation-id: 782731af-f0e9-4ba6-0355-08dd51b7e4f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mDtOvcc49LVovpXUDSoKbLKDlvsQblJtKG4s7bGYRvYSv3DonM/Z6+Bd7I?=
 =?iso-8859-1?Q?zLLh3tr+53R10fwh7E5IjkNZdGThvxRJ++gyM4CNVSgXTzsxjk1yqGJQ7c?=
 =?iso-8859-1?Q?P7+/J+SiHKdK6W+SLf2/hroSAgFa5QklnYKnAZ+gSftoxK6kZhjCK6RUhB?=
 =?iso-8859-1?Q?nSB2zI8Mr6vEv3Bn4U4CbBNxvpLVbT1Et7QQ4BVfZ4uFPoEzuCVIEvZxYF?=
 =?iso-8859-1?Q?SOWnBxVT6mtJhkydBL+S+kHaFtpN87+MG6Q+LuK2Xs4/g6prpbb+BKz0aL?=
 =?iso-8859-1?Q?jWHefP227RHtX540cOD8kv4Vbu6CEJpFoUVn8J6viOfZDu/zHu7zH9Wy1a?=
 =?iso-8859-1?Q?FLMHX4l0sDcXiFH+mbIU7QPwCNuJo3d+B/ZvIy0W19YwH6AbeIzzwrb9uT?=
 =?iso-8859-1?Q?QsGS4PeuSyWfPxCFY3p+CqPVK3EYuBTu8bnupVQaXfqsZt486t/3ph+t09?=
 =?iso-8859-1?Q?siaZleerxCM3uWmlykBAh+ONYy8M1WpwI/8pkHJcllN4c55n+vKlMR8zO5?=
 =?iso-8859-1?Q?bgfHLkCkCcIdF7u2Q2DQY01uVCbhYSzHa2TC6CB+DB3WZADBj28ydUf3tT?=
 =?iso-8859-1?Q?OiKvAUyKPeDTebgtPk7HjtEgMokv0zpNe3boVWbnh3uEVCtlmpD89FxAfs?=
 =?iso-8859-1?Q?VL7j8tNjSdxXbiOnHm2kpFNS7CFUcCv4ZbfZDEjrRu9uCn/Jm3pdML8Zty?=
 =?iso-8859-1?Q?SGyYQP5rtpeZN8+kDNXFDPX27/G2m6RGp8tuixCZtK9BkqywVDlRTKwn+b?=
 =?iso-8859-1?Q?beb2XRH1SSLlsRGx8Qy3OYUqInsBkwVagoDSnlCNGM6711WVJgVUAUSTj1?=
 =?iso-8859-1?Q?xaR0TtfPlhWtq6cEbpadpP60aX0zCnuqWW955/2zdfG3XJvC/AdfvziqFy?=
 =?iso-8859-1?Q?wTa2XosottW8ERPlyo4j0Xb09coXDHlWigX4ErOJWMxnPKbLuJ4jCq6tag?=
 =?iso-8859-1?Q?zbJz22izsgMiutEVfPELDArxYM7JFcT9SzuvF0NWvfO1cKO8QmISya/fl0?=
 =?iso-8859-1?Q?qzk5g1vx+UGTfeYhVZtulhyd5urC8nuLyVWVYF12OMhbYPDSyD0qCOhvN0?=
 =?iso-8859-1?Q?XYETwRqGTS0b5ZMF+xwVBnn8DKEgTMaE0tbE47ui0RQU3ETe03XK9GG+pt?=
 =?iso-8859-1?Q?dbBIBnAvdHu1DIxiBxaleCfEAwRhJDEKMHioEOSM5YIjd3YDzL80TgPFX4?=
 =?iso-8859-1?Q?0FstUsKZYJrUeZbUGNFXk3virR3zpHRvqfQpJ/ZqSCKCtJxhzDEmfAYLMf?=
 =?iso-8859-1?Q?b4qWYUbFc+K9XX+iSFsgAwon0TEgPpGaMhkhxO0EU+5cLVqLbsxjl+YuAZ?=
 =?iso-8859-1?Q?hEHSurS33MckGGEij8ALVj+pSRHwXLGl7AzIUlrDeNY0DPGPC7vqS0m8a/?=
 =?iso-8859-1?Q?YI2JUw0bh4a0biH4u7aG1B0rpoR7fNelhBY1aqRhRItWA1BNQEMarft9a8?=
 =?iso-8859-1?Q?JAz9BBpNA+DpPV8lfkxVAE4fnYi+CTsp6tB/76nzq/ZJIAzf0wbez5cyvz?=
 =?iso-8859-1?Q?RObTlV7w319Mh6sswi8++5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YxIwZgdwlXaYINhuRHFp+6qdAh0T6ao5SlTJrQIbi9krlZ6J0Jor//k4JL?=
 =?iso-8859-1?Q?db2y7CcnkN1tq9MJb7rA+q5jW/hBI3AQ3Q3BqeV9C8NwyWRRjeOMZwxYnd?=
 =?iso-8859-1?Q?yAhh5BJXBPyHhleGpTGuJ4sOCkxjPqwd1W2+LZw8ZCd6c+/wqnZwU0/rr3?=
 =?iso-8859-1?Q?SN5L5ENpbK0uJYvVMEAFGPq3cGYq/GuN42lNVQH5yILcDEXaVq9rsBvUBG?=
 =?iso-8859-1?Q?hYDf9P69BoII8xKjZWZtA4HDFI1L9eNqAk8vNno4A+EAUctGcr1rwX1PPv?=
 =?iso-8859-1?Q?9cWoPFvS3/0JLEhc2fdbbC7gpp5qazf1/TbYMqhzPJGUb9iSxIJNFCIYiG?=
 =?iso-8859-1?Q?Tn5pEFWvyB6UrctazJzD7uLV5XxgQ7EopMc7UhvC5ZPqnz25Hb9qC5qJy2?=
 =?iso-8859-1?Q?XT2f/L5hkb2XQIS8vFebfCo4B0VKDtXksu9Bv1d/R0o0f+G1TJv+vHbnsb?=
 =?iso-8859-1?Q?ccJVb3+s0pwroPM3wh5EyMItM2OkWaDmLbUloEHcp6GZbo88Q88Zcon3LO?=
 =?iso-8859-1?Q?PdjDuCO1Y8A8Osoi01Mzi0fxSTauVDSU5HOvS0wG7r5CAaLMCy2CDeZmDh?=
 =?iso-8859-1?Q?+c0PVuD6wq5k+aP4ZzJ1bnjAHK3PEPMmrKwAfhweZN7yo5p345Sas4LpH9?=
 =?iso-8859-1?Q?ByiZ0n3rnORonUdB4MKS1us6W9mqb/jVvNfWgmEdAu37E0njS8z8EGEtB6?=
 =?iso-8859-1?Q?p72P3EERfaeZ0YJxvguTI+/tHL+f49ZuPxhHxAmRhY7jZxXNFnqwBubx/Y?=
 =?iso-8859-1?Q?DSaerFVUpxwdUzXtHVUNnBI6ENqLpMq7alDzmGRm2CHUmkXe5ywmVRhCl8?=
 =?iso-8859-1?Q?Kb6IuvhDLVxA317PGP3/FWLwmMNn3DtfFAXUgD+cle353cp8tT23OwkGI7?=
 =?iso-8859-1?Q?ymN2gHgz2MgmxpG2ZnljJnpcCcZSBOR+g2UofkG6N6e8cx3dT0hOVCk0ep?=
 =?iso-8859-1?Q?BWPUhekWl3k5ubfa5bJumFyzJlkMP3choxRWD+4umcD4uchOTRQ+VxQOai?=
 =?iso-8859-1?Q?ra5wtuRFJZYz4yyEHPUDbjRQN1xvEcVo21q/fRJuEGbYMPE61nGuT0C6GO?=
 =?iso-8859-1?Q?mByz6yNh0afysVWAq7V0gWOtYQY9XwU/24mw/cr8VaK8nsuWj1mq+a26Z7?=
 =?iso-8859-1?Q?YfqSZHH8AlzatudH5x5tl+cU/v/gR7HRUeafJ6n1lGI19oHLr8ErtLSL2a?=
 =?iso-8859-1?Q?/+tqgGxKuxIShBgjef8bRa5e4BvkiYsCtf//lXEbNUcPw9tjQXZIIW2Bgx?=
 =?iso-8859-1?Q?gszi/r4kV/pM/KGbPdaES5GZISdW/ylTR0VluM8dm3VhyLrRlqJoVdErUi?=
 =?iso-8859-1?Q?imyFuTbiBSxiukHlP+oC8qkE78CQJznw/Bz2QmcU3LwFZghuwKjYI31pP8?=
 =?iso-8859-1?Q?KCUbzjgPKu2UzPq8S2Tp/thHT0OI40Tz2d8hndCjfvuU/6vvKPSXyWvS3s?=
 =?iso-8859-1?Q?mGov1JuLTCDwOQIGVckhhq/EM8Y+TuGeFzX6samE/PoCodvBZJSkHGVVCI?=
 =?iso-8859-1?Q?G7BynDvKXcNueJNl1w+k/f7HW3tTxV6oTJ2mdHY5L1ckgIB7gn4in4UjJp?=
 =?iso-8859-1?Q?Z8vCaM3mXpJPxhasvgJiR/E2qdeZHLY+r/Rg5V4ZUbdesk8MT9IbL6GYPh?=
 =?iso-8859-1?Q?Aj0grVbEMmOAc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782731af-f0e9-4ba6-0355-08dd51b7e4f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 14:07:21.8833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afOaZehN1z0f9rD1MYawXuxz4SGaqBoZaU4OeEx8z5Cr2mNgQxYjq282/rnZQa/Um6cGCtd9PhGImdZRMBSOyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

Thanks for the explanation, that made it clear. So in v4 I'll=0A=
modify the condition for dynamic clocks adjtime to require WRITE=0A=
only if modes !=3D 0.=0A=
=0A=
Thanks,=0A=
W=0A=

