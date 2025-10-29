Return-Path: <netdev+bounces-234091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6404C1C90E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B155637C6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7D34BA33;
	Wed, 29 Oct 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="rC/Y2UOn"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B020C490;
	Wed, 29 Oct 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758104; cv=fail; b=Cv+mL3PBwyjkDuL+dlp3ZBANlAFnN66AC8XcDIMYZpsYmJEJ1IG8yRLdGGAhYo+1URHV52yiT053hrtlLqq5rd6igIQrBdoOCMwfYa9nY0rWo+zQNvj7OF54XU25TI5xp+BbyNSvvDuyBA0qJ7HJw5UJCxpBC82rRxXuqW5zbqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758104; c=relaxed/simple;
	bh=c6Fv++kGBWQ68tVJHoMOqrRd79xxVtXzH44ySFLGcWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Enh34P+qkOjaetWwtyKs99HWSNsY3iOojNAmWmjDUccB7eURxVB8onZzospfCfy/I1YtNQrn4r+2VHj30Ir6rDD2VihhWC8fsageSkQVeQyHoyrb43J8GXexGmKTf218rPWNTxQhRM5gwuAGCqSdjTwvyuVqjFWymyY9x3AhDig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=rC/Y2UOn; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJhYd3JreE+7T/M7kAt/snQ38EbqLa1NN7wSW4a007b9CT17QAkoJytM3fCesOM+No9Eibzmyqp34pkr9DaristRdKVDVZVrvvSoLzqbt7pXL15SWm4c4qSmbwDq0NWI6INQs4so76BsU9srZYfOdAv/I2XAnhINggKeeVg4O8owI7Irxq+BMRUtO/CidE7g9PXGR6WwqzaWH1BW9CmMHmOayK6sSPl8KLqa/6Me8twYvsYtcCfPZ7tw+NAKNIYLJmHejcxDJHRh/JNlW2u2mWyhAZGPdR0t9OMgmBYtf93EwxWqrN8yuTPN0aqXgpwXY2iiK3QsT2EozvxMcHlYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/9Oh9MGbaCX/yyx5d5B4nlurP470Qo4sWNbPV4S5nI=;
 b=sSVuCI5enRC8MzjkqJV8aRbSGJlA9sXUJd/Ic1XW+DKfxg8YqCXEPb6Q+HKPJEKlXzkqOR6Zb/lMArWl49WhFODRxa9Fz51BM5z/xsUhxJApAFaHXgM4qgJxmzfNHXXq8zWeEwwa4wTe4gUQSPh4HQbukUhTr+rCaPk/sjIbXCc6sGL2QAViVuZ2k3jlX59aiq6wc7/QY/Ec7NoWwWGDfEfd6N17pAEIVrlAxtfRIiMvs51DbDHatjSXGLJ4+z1lBhN+/NBAvM8AavaUY9MsmobVuEfw6jvuKBu04sHYwP9scrL0M6/ULIa0+AO+xpub6W/p1IlJ/SK26x8MyKGmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/9Oh9MGbaCX/yyx5d5B4nlurP470Qo4sWNbPV4S5nI=;
 b=rC/Y2UOnQAksq6C0Ok3wKD9vZnvQe6Hmkhhlcvp9s3fXxdAKj4sQPGVBJ9H2Vy4nCsXVfKo6NkdsKBkndpEu7jS6OSiQod+vIxy+WtCmPN6P9CQC9+GEqwpairrgv2bou2LX+4xVBvkuEbePliTzBCDJt7Mj385FV1e3THrSr3TE2Bs8j4mw7Pu0W8DtRVhniYAV92EYjesokh73W5bE88/POMpePtrJh2P74wVqqyy3ESehml4OSYhsF6MKTtBux9Ouz5eujjQPXfdPnEvTjaEcd3plh5t2b8Ft8JuX++822g779mnqJ0m0gXc5oBBu9/NtL+SlcBVnqs8Xq/g/Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by SA3PR03MB7418.namprd03.prod.outlook.com (2603:10b6:806:396::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 17:14:59 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 17:14:59 +0000
Message-ID: <9e4d264a-b188-4ca7-ac48-a8c90785d8f3@altera.com>
Date: Wed, 29 Oct 2025 22:44:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: stmmac: socfpga: Agilex5 EMAC platform
 configuration
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
 <aQI9ckiHEybp3c_y@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aQI9ckiHEybp3c_y@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::15) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|SA3PR03MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bf86ca-a324-4a41-fa2a-08de170eb092
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGV2dkpaVHE4bEpZUm10c015ZjgvM3FtSVk3aVNWRVZOUFBZN1RkYWJCa3Va?=
 =?utf-8?B?d2lNOUVRNmlmZlp0ZWxQNzhQaDdwNGdDUjRoZFh2L2M5ZlNCTGYzUkpJcFNO?=
 =?utf-8?B?UGJsY0tqc3pGSTAydThoNGNRSkY0ZmhkTUUwQ3d3TllaOTh4dXFFRFBMb3hx?=
 =?utf-8?B?K0JmTGhWQU1rR3BZeWl4RGZvZzVpU0ZBTjdUMnM5c3ZFaXVCckdzeElhc2I5?=
 =?utf-8?B?ZEZlVEhlNk9yN2tTSXB5NUY2a1FHa1NKdERkellkMmJhb3ZHcCtiY2xUcUFr?=
 =?utf-8?B?L3oxZFZYa3QxRVJQNms1bVJ6anBSUzEwdUZBY3hDaDFnOCtZakFkZTVIQkty?=
 =?utf-8?B?ZzJ1dCtxOGtHU094OEFEQnlBTWlOK3JaeTI1V01SeldxcGUxNnltOHlMU0F2?=
 =?utf-8?B?TktkMVJ2WTdMcXJtZERab0FYK0JKcWR4Mnh2cGtnbHJ2ajNSeStDZXZEajJC?=
 =?utf-8?B?OGZMOFlZN1JhU2dVNVo4SWFFcnI4K25QQUhwOXp0WUFMaHg2d2Q1eGVVNWhp?=
 =?utf-8?B?V01vc2NNd1U5L1p5Z0M4QThrM2l3ak05bHNZN09CZytpQ2pyZXU4eVhZMG1X?=
 =?utf-8?B?WGcxcFJGZGVaVWVRK3QyV3cyRlh0a1RBVFNldUxVaVdVUDUzU2tmUTlGZmk2?=
 =?utf-8?B?QXlibU1IUDR2MGZZR3hLRUJIb1BKbTlra1V5bjgwOTVVNjhxei9XNlc1emtN?=
 =?utf-8?B?eGdJU1Z5eWlma0VzYXorcDRqaW1BVWM4ait0ZG11OGJ0UC9GcW5OQTJwTW1D?=
 =?utf-8?B?NnJtR1dTZTJscDBwZUtodmRBTnR3WVhVdFFrRjFsMGhYdmFFeURHNU5wVmEy?=
 =?utf-8?B?YjBxRThpOW4zVlh5MnlXdGNDcWlpTVlFV3RySXIzRnF6RzI2c2FsQ0NmMnpx?=
 =?utf-8?B?cFhWWHhydnBTNHFmK3NNOFk0dE5DMmtwNHZkaUgxOHVienAwWlFNbjlpMEdE?=
 =?utf-8?B?bzJKSnZOVkNYNWMwYmtpblFiaERhQmZZMjUrc0YzMkRzK3ZncU51UGxVZERM?=
 =?utf-8?B?OXF5WkdiWGlRbnFTbkVXNGJFYzVyK2VpaU00dkVad0pPZjJGSGdBWm9BTTRz?=
 =?utf-8?B?ZWNlVlF6RmZhSnBhZGVwUjMrZHZuWGpUWjR0LzZGN25Id1JSMlowVHpWNG9J?=
 =?utf-8?B?empwSXF2UjBudDRVbDkyWnA4VDNPQUdBWTR4TnJ1RWVBdWtGZlZrTW5POWFP?=
 =?utf-8?B?RkFPME9JOTU3TUxjblRkY3Y2ZnRlTjFKSTlGMWxVRldicE5jYzVZeEpUTDdo?=
 =?utf-8?B?NEhGZnJMQ1l4QVd0b0dack9TL25zVGJSZW9aRTZBdk96Zno5a2lMQ21jNmdT?=
 =?utf-8?B?d3FBMGxyNU82bU5PZytTSmpnSmJ1RlMwcmxGZ2xCQUlheTRBVDNIZUNKcXoz?=
 =?utf-8?B?eS83WkZKbmV4cERKajZXQ0pHdUtOTi9ROXFZM3lDMW5BT2txSkxIZ2YrNlBp?=
 =?utf-8?B?V0pNY3ZsaXkrNWwvUzNVWkdJL1VLRnliZUNxVjdTS0pSaitIVG55NnJUWGFZ?=
 =?utf-8?B?TXJaS1JreVBpUzFCUnluVng1MlpOL0h4SHJZc0pzdVFFQWNadnlrdExoc01Q?=
 =?utf-8?B?NnlldTlFM1lKaFdRWVl3TkxzRlJlOHlOS0s5eGhoT1k5MjhlMjRhN0YrMnd0?=
 =?utf-8?B?elZMTWpISUY5cll0RFhjSEJQUi9KVlhyM0N2d1RtTVBlODM3ZEpXYS9PVVJo?=
 =?utf-8?B?U3g1WmNoVUFyZ2ttb012SEgrd1Q0NHY5WHh5VUZ4c3J6Tm5IL3FLYkhPL0Ns?=
 =?utf-8?B?VlhyaGIzeWhwcmpSRUJHcjVqemJpV1l1azVSMWZWR3BlbTJucXF1bnhxTEZ1?=
 =?utf-8?B?ajRtR2VvU01hcXlJM2Yya2t0YlZudEc3M1pTeTZycml3S0drMFB2RzdicTNN?=
 =?utf-8?B?MStoTEV3RzlhNnVEVWQ2c2JycUlYMjRVOXB1VDhVTWxjUXAvaENCOGNQckU2?=
 =?utf-8?Q?lE+3/kNs7bxUv/EV9mFI7b7+ql3oxRUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUxrdEdHZ3NUZUlCdTNLcTk0Z0lhNnA3MWNyYUtjLzFjVjFrdTdRUWZ3RGdP?=
 =?utf-8?B?amhXaVRKYzVmQkhKS3RwMzhCaHR5cHFGdFRQalRvU1Bra0tBSjFmOENDSmp2?=
 =?utf-8?B?TG9TVldXdlhHOW15Zm5mTzkrWEhMS1FESFdtNEhRcldzckV3M01IdTlZRitz?=
 =?utf-8?B?N1VVVFJ3VDlraGN3M1NIR3IwdXVvVVBHWXZRNnVvVTltd3RjNHhTME5WSnZO?=
 =?utf-8?B?Q0dnUEViNWdpdDBsN2dkNi81M0pCLzR3c3EyQlYvejVCSThRWFgvMTdjaVZW?=
 =?utf-8?B?OHR6RWdacXRIbHRoR3gxaUYyN29RcE9WOWRHLy9XNEpIOUJ2S0RLY2pXMm05?=
 =?utf-8?B?akk2SUNaKzBxTkVxMjNqeVdGamNyZGIrdlpIa2pPcm5ib3NwejlmRFZuU085?=
 =?utf-8?B?MjhBcExqWTNHelozaWJRK3E4SUpoakovTCsrMUorbXZLejR3Kzh2WDNkV2VU?=
 =?utf-8?B?VHFFYm8xVzRGWUJ2L1FKWkxYbkNDUDIydXlpYk41aUhWWTM0R0YvSDFEMGto?=
 =?utf-8?B?cU5yRUVERTQ5cFZ1WVhtbnFsSUhneHlZaGMxSUo0Y1l1U2EzZkVsS0VEdExt?=
 =?utf-8?B?VmtaaXQxdzJZb29Md3dJRDY3Mng3a0NRakVGbjhjVUJsOXJWNEI0ZmpYTlky?=
 =?utf-8?B?TG1iKzVSUER1ck5CMm9ZTmlWRThsR3U2Vm9jZk1Lb1V5YlI0S29kaU5EWjlJ?=
 =?utf-8?B?RXJSWjl6dUpPSVA2aytKRFRKRVdkRXZmY004djhoM0h3aElNU05EOXJQZk5k?=
 =?utf-8?B?SFFoM21RZkpUMThsV0MxMXRMMldIbDlXZGRSU0xJSnJvbWh4NjFnOGZXMUNr?=
 =?utf-8?B?Ujd4QnhKaWx2QW9tV0wrVlVNaW9Va0N1M3dlVGJzOWxzYlg5YmJrUy8reTI0?=
 =?utf-8?B?MUNkNWpSTTdrdU4xN1dlNWFLejVGb0Q3SFkrYlBPYVJua0J4MmZSTUNUL3Fw?=
 =?utf-8?B?emRlcDlFSGVJY0VZakUxL1dFbHJMMUhVMXhEdnBncWFBUkc3UnkzM09scmJI?=
 =?utf-8?B?SUhYLzU5VVdPdzRyZkc0N1lCdzNGVnR5M1FpSkthQ1lRZDZSdEVYSGo4WFJQ?=
 =?utf-8?B?RTZUUXJDVVJ0QnFtT0pmZTZRVndYcFFXMTlrSjIzbCtXelpEZXB0R0tXRnVX?=
 =?utf-8?B?eTB2NHA4NzdVRWJTeFVZbFNuQmZFbVQxdEJzajgxL05ScUhjNWJHRzlJakN0?=
 =?utf-8?B?aW0yMlhMN3FuanpIV2hMcCsxM1J2MS9NVmFZVEtjc0JhUmR6b2F2Rk1CMWtS?=
 =?utf-8?B?Y1FrYnkxVUc3Tk9odnlBc1ljRlgvdk1xTXd0d0ZnNThzUE8yeFcrNUlMTGFx?=
 =?utf-8?B?d3J2TTU0T1dsVUYwNHNMc3B1M0Z4MjNJVFp3VVNpeGg1aUlxSEE5OE1ocmEz?=
 =?utf-8?B?eDRvYjBWaDY2c2RHWGRzVFYydjNjQllpV3FiS1RnVjJtVGphRDNYQ1BML09i?=
 =?utf-8?B?S1d4V2tYWitPVXp0Ym1SUm4vRUhTOHJPOUFnSnNpYTlFdnpKemVTZk5LeGdO?=
 =?utf-8?B?UktBcXFIdi9Vd2taVk95cmRrWXU3VlR2Q3RxZkNBT2FtSUlCVERnT0pnZG5U?=
 =?utf-8?B?NDlUcDlFblBaZWNQWWlROEZkSXh3OVduRC8yQnJ2QkhVLzA3V2pWYnJ0SEY3?=
 =?utf-8?B?NWh4Sk5TSWRjV0dTOE1kSUkwUjRleHNZVjlMeVNtRUgrVExXZVcvcEpQUGlK?=
 =?utf-8?B?VnFibFp3RUlKTEQ1SUxiZERUbFRTZ2hNV0UvRXRZN3VKQlpvWm9DQnh0clRZ?=
 =?utf-8?B?c3gwWkV6MU01ZlZqS0JVTEZmaGh3ZkVIVkhsTnVISUtZSmxpSFA4Zll6Vytr?=
 =?utf-8?B?ZXE1cTBPNlI0Z3UvZVRkZlhrM1VjRVhvTEpTYzR6WkdkRGsyMzBMM2dyMDlv?=
 =?utf-8?B?Mkc1MHV5cWJ0VjM4ZTMvYzVRNVZodWFNM21hbE9oSUIrYlRSYXlOVEJSb2J1?=
 =?utf-8?B?VkpIOEhmNmhpK1RjZGFSTGhDSDNZWHIvSHdkdWh5R00raGxmTm1aQ1pQN1VK?=
 =?utf-8?B?TzYvaWhzSHFKa3ZtRDBBQ2UwWUlUSDhleTBHWEpSNElTckJwSEFYRmVnWU5O?=
 =?utf-8?B?a0JGTjB2Qzg4VG5qQk1FemhYL3VHOWZzK1ZYd3N6NFdUSXorTFV5RlZBbExn?=
 =?utf-8?B?eTdNNm5vcnl4ZkVlWTh6SlpoL2VnWE5KdHRtdjBBU2dhN1lXL01xaWEzUTV3?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bf86ca-a324-4a41-fa2a-08de170eb092
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:14:59.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aPCO/Efbw0vGoqn+BMpL57Tuzuq+K3fT/1AbsIAs64GVsaANlMAVRUDas+2fniRR4gyBUSiXSJgvu0jCaAWWZ65MxF7mu7WpyeLe9VkElg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7418

Hi Russell,

Thanks for reviewing the patch.

On 10/29/2025 9:44 PM, Russell King (Oracle) wrote:
> On Wed, Oct 29, 2025 at 04:06:13PM +0800, Rohan G Thomas via B4 Relay wrote:
>> +static void socfpga_common_plat_dat(struct socfpga_dwmac *dwmac)
>> +{
>> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
>> +
>> +	plat_dat->bsp_priv = dwmac;
> 
> Surely this is something which is always done? What's the point in
> moving this to a function that always needs to be called from the
> implementation specific setup_plat_dat() method?
> 

Yes, for all the current platforms this is common.

>> +	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
>> +	plat_dat->init = socfpga_dwmac_init;
>> +	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
>> +	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>> +	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
> 
>  From what I can see in your patch series, these are never changed.
> So, I question the value of having this "common_plat_dat"
> initialisation function. Why not leave this code in
> socfpga_dwmac_probe(), and just move the initialisation of
> plat_dat->core_type and plat_dat->riwt_off ?
> 

Agreed. Will keep it in socfpga_dwmac_probe() itself.

Best Regards,
Rohan


