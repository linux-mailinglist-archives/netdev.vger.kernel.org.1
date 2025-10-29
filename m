Return-Path: <netdev+bounces-234032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09656C1B781
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82D613448EA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB204311C06;
	Wed, 29 Oct 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Qy2YoGIx"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3B2F7465;
	Wed, 29 Oct 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749625; cv=fail; b=anEwD2LDQOQpedOdSxVj0HmictWyiUmZNhL9TyUv4hg6dfOYsTMJdf6RCzDM8fS0KEF8uJZGrB99SwaHo5vJFaZO+c9bfnbzZQVp9++oRFKOh+UeeKmQRpE9z088itxKfF4J8A93/7BggobEYd52feoG87Wfbc5zz7ZJKSisRIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749625; c=relaxed/simple;
	bh=YpGvHm9txdPEloDg1lC3S+pGK+n++R4eNPTI4hK4a34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/w3wmdxwHSfaOaLLsL8EP0mXS2IPbHE2KuFy5F9DEQ4fWlJ5DaAu+a8xp2NsrCOOuib6aAoZfZ4ML+qs61TSQXyyXbljRw7zjeOhpAYlcaXR48M8H+JubXH5+puOmqXJmA/zb12Be+lCnq0M+yccNl4Hj+x7TxofIXwxnTK6YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Qy2YoGIx; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/dHM0srBi2vVm9sQoRO6TBepYUu6JTuLSgyHDUKfTXpG1zo+l6hCA+zYqg6G+rEf2jg39k06bP3zmCo5duFA0vy+Qzi9UMgbLVJS4iCj2S/gZkTwUdl3JxyRfQuwlfcPb9FpuzUJD7Ln2BfbSb1TgxKSJpe4nrCA9NMkthrIQ4B3mDt275yvzQL7+c4lN5zSL8u4RXXXeGmp0YnSbmoI9s2XPheBO0Fu2yuNMMF8Nnh7MQ0Bi7oE2H/NLI3DHXQ/E9BN3pFEKg3oV6YINVR4vo1n6B7MuOeHVOt9sQMbXcOJNWQrlJFGULxJIwyktOuGhA3DbDPTcdCXlp2wFc63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3TTZ92PbAE0e2n5xy4KgPhB7lQBgKZcwRJAIyaRDT8=;
 b=TTvI1hgph19s3MCf1t9D0IjAlBhRtExiEG8ccUJdtcDrXSD8NgVvNTQIR6lXRpdzCM36yJdmk/XkfCn2V13qBLNiL8CYJwAk9FIWu623DgfFBpFAH8mSQTux8Bvkhh2xMYN7BxAzzj9qZVZHf+UeTHwBWakuzZ1NroOzZ2uzG8r8b6C4tahydXvSN/Qc8DdVLXrvA4GVZN2LxWxZHUsCPRIuuuq/sPR4/GaRn4vB3hErqhDSrxOW4pN5F4RxU9fD8NIGItOmYYDaAspiKzGQrBJBfx4+FzzQazVEeW9l4takxGdoca4kXIDnrbV2o7TmGKvtghJfgdcyK195143Wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3TTZ92PbAE0e2n5xy4KgPhB7lQBgKZcwRJAIyaRDT8=;
 b=Qy2YoGIxdmhNHtC2yfDF4gzeB/zGbZRoVu0s1RFkQzL4XgZA6DDDqwJrLxgp1o9p0IPFxd1FpZpHFXZj76k4gMWBPVlsCGhCcvcvL2GUCemnoczxJkykKzkOj2LJgSSgs2SZEgtaJmrEngImvLQgWes+S3g7HybA1HWU+IAdSo3JtrFsLAoRUULkro/tItKCurw6OViIzwZbE9zcACms8buRKeFPwRF+OE/2JGtCEr3mVyaTugkD60epBbAZEerDG+JzR76T7+E72a0tS8cK1l/Fmw0ANvCyyy0LcFq6Dbj7phNzkR/mMKh/iqbCNfQPC6JuLQig+m5QqFLHhQToWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by DM4PR03MB6207.namprd03.prod.outlook.com (2603:10b6:5:39b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 14:53:40 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 14:53:40 +0000
Message-ID: <db213912-2250-4d3e-9b2c-a4e36e92e1cb@altera.com>
Date: Wed, 29 Oct 2025 20:23:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: stmmac: socfpga: Agilex5 EMAC platform
 configuration
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
 <a871daac-364e-4c2c-8343-d458b373e1fd@bootlin.com>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <a871daac-364e-4c2c-8343-d458b373e1fd@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0135.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::11) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|DM4PR03MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1535fa66-2380-4615-1261-08de16faf277
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L241NnQ1UzEyS0NzeXpPVnc2TXJRVW8rajBwTVRwSkhhaStMc2ZPREJ3VkRW?=
 =?utf-8?B?REFoMDZOdmxKTFRKUk9peHJPcERUR2crdnF1ZDh5R1FZdENxS1Z5ZklnNEJM?=
 =?utf-8?B?OFh1Wk9pV3R3SnUwek1uNXRLcjZnT0xlUDdGaUxrV1VxZDdHNzNmS1k0REM3?=
 =?utf-8?B?aDhaVFA0Kzh0V3k1bURZTkM0eURSYng4S0d2Smp3K3pGQUlGNms1VktpYnl0?=
 =?utf-8?B?SzRvdlFhd2ZTckNLbWVQTzFOMXQ4ZGY2b1V3THdZcTZCMW4yUzBTdGpzbGdO?=
 =?utf-8?B?T2NxZTJBSkdPbjcxbzR5UnRxeXNiZVd1SkhnaytSNmNxZEIvZ2twakl0NDdz?=
 =?utf-8?B?VEZrR2hySW8veVg4TGdDdUwyS0l0Zi94NlFraU9NOUhZOG1tVlBKOVg2MVBp?=
 =?utf-8?B?NllHMHROa0NwSlN4TXV4c2N5eE1WRmlPcE1GLzNjMGc1c2VjcG9qdGRCMTVE?=
 =?utf-8?B?QVd1YnpSYlo0NWxPc29QYjh0L2xpbGlOT1RRb0tYeHk0R01LQ2twNzZvUE1n?=
 =?utf-8?B?bllZeVpaRndYOVlXNmV2L05QMUJMVDc2REtWQWltKzFabnh2NEJ1cWJ1ZGJq?=
 =?utf-8?B?aFVnZHgrampqbE9xNU1laEZzUG9OSlI2NTE1blVLcW40OWNQSElkRWxwUFVN?=
 =?utf-8?B?NUYxaFVQVU13UUEwdzdKK1BWN1FhaXRYcmhUZU5iUy9vcHpmNVBzdTR2T21i?=
 =?utf-8?B?UjJHUndiRnQyUWMxbmt3Ui9kUExrTzdXSlptT0lLcG9oSUhTV0VtV3NiZnNZ?=
 =?utf-8?B?TVYzclMxa2tUNkJwMUZkWFlwMDlIRWpQZE5GWDlPTE9hRzk4SmtHUVJLZUFz?=
 =?utf-8?B?ZzF5VWZSc3RPRlYrbkJPenBCRnZrTTB5aXk4bGNKRENHRXRxL3JXMGpoeXVC?=
 =?utf-8?B?QUpITm5DUUR2a2lVQXhJcDJBTEJmQlhQZjR2RGxtVGluNGhJajdUMDk2U0d5?=
 =?utf-8?B?ZU9BQkJMdlR1K1NmMFd2MUJ5eU1MNEQ1K1FCbVdlb1FMbit4NVBPdDVIaExE?=
 =?utf-8?B?Z1hHc0F2bEZWNStKaFIxaUpWYi82aENLOUtKZkwwMDhwZ3V0Nk44ZG5lU0hy?=
 =?utf-8?B?YllXS0JpNGZLQ05qaVdQOWhsOFFSTm1XY3V3OHBsejg5cElidmpQb3VFRGZt?=
 =?utf-8?B?c256amtlQ2FhWVJ6ZTRHK2lEZFpmQjRnSXZ5RDRVQ3JjK3ErQnZBWDRpQzdq?=
 =?utf-8?B?b3JiYmRaUjV6Ui9EbnFPMkorb09EMWYrQW1yZ0pDNGlLZDN5WHVpS1d6Z0FH?=
 =?utf-8?B?a0VlNEJEWHdDWDFCM0NsQ0xlbjI4QzE0cVdmbFpoMlJiVjRkTmRhT1kwTHZF?=
 =?utf-8?B?Zy9GQzRuVkxoU3RuT2Y1bERVZXFJYU1nM0w1SGNQOEVFcEtUeWc0WEp3UW5W?=
 =?utf-8?B?blZrV2txdld3dVZjTFZldHcrSCtsS0NCWFVwOGZoenc5TDlRaUptdmRoQzB6?=
 =?utf-8?B?ZGJhWFBBcXlkdlNTaTRWUCtJZzhMMWdQZDlQMVFRUDFtRUpvVEEyQVkrUkFv?=
 =?utf-8?B?TEtJVmYwNk9HTUxrSG8ralBqczNRb2tScThqblFrTy9qMHQxcDZVOFh1MGlG?=
 =?utf-8?B?L3RnSE1HQzgrcE5ad0k2QmdLd3BJaEZySEdSRS9hd3NZU2ZHaHJDN0o4dE1h?=
 =?utf-8?B?TXNNQUhieFZ5Ukp5NEdyUER5eFEzSUIrQTFaS09aTXR3b01jZ0YwREtCMzJx?=
 =?utf-8?B?SGhDc1hmQzcrU21lVWNyYk9vWkloQm95ZnNZRWpKU1EyTXJyODh5em1pY1Zm?=
 =?utf-8?B?SnRWT2E3cEovUzRTMWN5bFRhWlBaTGNlcW5ZdjhXenlWcHBaOFdDQVRNS2pk?=
 =?utf-8?B?QlVpQkV5MEMyMXlsRjI2VUxqRHhPRkNYOWh1bUZPMFpIZDVsUHptYVdnMG9l?=
 =?utf-8?B?bFVxNkZiZ1pkUVBJcXg5WERHN1k1YU94eWZtRjVhZ3NMY3F3c045MGpOWjVO?=
 =?utf-8?B?UEl3aXl5UGlaakcycldKcnNkcWFOblB4a2kyZnpoeS9VUGJyUU13S2JGaENO?=
 =?utf-8?B?RFMvMU5RQ2pkc210dDhUUXdacXBudUxwbVlTZENqdUdmTjhxdUs5SDVLcmtK?=
 =?utf-8?Q?jZmiRQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWZiNXJVbkJtWWl5TFVVSGNONmVmc0tVSXpFb24xanpwc3FnRUJRSWR2cGRm?=
 =?utf-8?B?eHN3eEpSNS9vSyt5SWNOTWhqUEpxQllLMWRQRzBwc3IxakFEVU1YYUFWZHJM?=
 =?utf-8?B?bnNQWkE1eG83NEJBbFlMMW1YMVNUMDU0S2J1MjRXayt4UDZmS1FNUUgzSXo5?=
 =?utf-8?B?eVI4bmpUL3ZuNytZVUZNRnUrbTdlMFVpZkFaUEM3TWt0blZiTmpZU2NCeDRh?=
 =?utf-8?B?VHNtSndiTGJlN1NQdjhkbU1ldC9jNnVQd2YvTFMvZUhnMEQ1VVRzb1hGM1FF?=
 =?utf-8?B?czU3UWV1T1dBcWZzNzZrU3VRc0V3RURFamFlOW5uekZFZVc0aklMR0d4WERF?=
 =?utf-8?B?MnpWVFUwMzJFMnZmK2M0V0RRemF5d1JhMUcxTzdYSEduaUx3WlV1WCt6Y0Yw?=
 =?utf-8?B?bDVLMk1hc3QzMDMxaUpnREtjSHdmUnd2MG1pMG5FMEFKQU5vMGxZSHZENzhk?=
 =?utf-8?B?aXM4ZndMRldLNG5XSnNla3V6TThaa1Y2UUd2cjFjNTdrcUZlbklyeWcrMElv?=
 =?utf-8?B?dzI0TFEvbzE3OXg4ZUV6Q3Z1Tzdud01pc2FaUWhMWGdYY1VkVzlqZkhUaXBH?=
 =?utf-8?B?VVZzVGlCaGpOUGlrVXpnNWZMMzBUNTR5UDJYMFlGalIrMVk4QUpubjREVlFD?=
 =?utf-8?B?eFY3WmlLMUFBRzhOcTZ4ZVh6S3djeWlBQ3JQcGR3RFJXUDVpV3NqZ3lLbTA2?=
 =?utf-8?B?dCtMb0hCaFgxV3pHaENoZFppM1pLejFqaVZ0cHA5MU8zM0s1UUMrYWY0dkdn?=
 =?utf-8?B?REhNZ2dON0RkTXc0MW03ckdlOElIWVA4R2JJSU1Pc29hWXVOU0pHMmlwQXBG?=
 =?utf-8?B?blhtN3BtNFZBdW9MWm5sYkhGeHVwTlZKbEtNMjBKVjAxVVlsWGdzNzd0aFBS?=
 =?utf-8?B?bHQ5c0pQR2tuUHdUTW1wQ1JQQTcrZ29neTlFNnplR1VKb2txbC9wcWNBYk51?=
 =?utf-8?B?T3BTUHhETHV2WmJrOG9EQU5BMDJyc2xoSlJkcG5pMndOTkJOY3RISkZhbFpC?=
 =?utf-8?B?VUV2UTBuNUFGUWtrOFo4TVEwV3QyTi8ySlp3cGZYSTc5eGRmY3gyWXZuNE84?=
 =?utf-8?B?VTVFZkljRk93NU9FL1o2WGltOVRNeXBObmNiaE1HVXhxSU5vNGxWcVpsb1Vi?=
 =?utf-8?B?d0x1dnE3YXlJUzMxSkQ5aGhiQlBhNDdvR0g2REp4dmV1R0JMMWFDb0NNenNa?=
 =?utf-8?B?VysyaEFrUWc2bmNPMTNxM3dBajZSNVFwQmluVEoxbTVRdCtMNE5PSnc1WDZL?=
 =?utf-8?B?WTJKRXBDQWJHc2ZPRkw0aE1XRVdESi9iQjBwemdKZEZKWnBNeTR6UWpoUFlF?=
 =?utf-8?B?ajNnNjA0ZUFrekNDMzk1WVRscjZqRHZBbzhvZ0hONThVS0cvZ1M5OWJxSWN6?=
 =?utf-8?B?ZGFDNmtteUJOSENRVVFKUFFiWTQxTDl2bjJGdmIrSXpSeEhKSzFaaHB6VW4y?=
 =?utf-8?B?a2FxWExjMjBrb0FaZys2ejJNMXBTeXdqa3cxZDZ5MzJRZWRCM3B0aUFCd05B?=
 =?utf-8?B?OWtmVFN0QmU1MjB0Uy95MWJJeGtKVUJXTVFZa0dBTlNURU9PbDR6cCtiQnlj?=
 =?utf-8?B?cnl4OUVxODZ3OElhb3g2c2Z1ZU5Id0lxWkZOdmxpTVI1RGd0SDhNVmludHNE?=
 =?utf-8?B?RXdCallTenlzRGhBS21YQWR5WSt1TDM0RXFmb1p4UlplejRtNk1GeEpRRm1U?=
 =?utf-8?B?bnNRSXhqM1Y2b1ZibmlzMjRwZGNmNU12b2ozZDRjMGFadzdUVExvWnZZaGx3?=
 =?utf-8?B?UkVLUXo4MTFZN3lBbTdVU2ZGMnp4Z1NVRHNZVHVpM25XN1ltRGhKbHZibUdE?=
 =?utf-8?B?WmZlYUtLanlyM1E3S0ZwdmhJSzgxODRQeFVQT1p5djVWTCtON1NFRlM2cWM1?=
 =?utf-8?B?eHBCY3cwRWxYd3dPUlFQdDQyN3BZTlhhenErUkF3WG9ITkhxV29WR0hJWW9y?=
 =?utf-8?B?dytuamg5RmZiMlJiMlZ1MVBCSWNHQWxFR3E3L2h4L0ttdkNnZi80b1cxSndU?=
 =?utf-8?B?VHlaZ3huQUlNRUJzOWFjak5PaU5aK1RacjNCWnp1TTViYTkyQ1drSVNSL2Fr?=
 =?utf-8?B?SEVYd0k0TkNra2dVT0VSRm5DektWaEh4TnZwRDJIVWxCTUt4djAyLzZGR2Zl?=
 =?utf-8?B?OWFzdE5pVDd3VVlOOGtWbVpPcVVrSUg3SFdHdkF4UmxCMmo4cDZ4ZGNOdWNU?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1535fa66-2380-4615-1261-08de16faf277
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 14:53:40.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBe/VXRt+logafozBbEovWTu8uRFWQFUkWTnrPqUChHt/xxP1F1aDFarktkSrAv3KJ8oGMtAVFDoSDvPgvG/Ol2YUJO7sJ7T0lH+V7yqWJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6207

Hi Maxime,

On 10/29/2025 7:04 PM, Maxime Chevallier wrote:
> Hi Rohan,
> 
> On 29/10/2025 09:06, Rohan G Thomas via B4 Relay wrote:
>> From: Rohan G Thomas <rohan.g.thomas@altera.com>
>>
>> Agilex5 HPS EMAC uses the dwxgmac-3.10a IP, unlike previous socfpga
>> platforms which use dwmac1000 IP. Due to differences in platform
>> configuration, Agilex5 requires a distinct setup.
>>
>> Introduce a setup_plat_dat() callback in socfpga_dwmac_ops to handle
>> platform-specific setup. This callback is invoked before
>> stmmac_dvr_probe() to ensure the platform data is correctly
>> configured. Also, implemented separate setup_plat_dat() callback for
>> current socfpga platforms and Agilex5.
>>
>> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 53 ++++++++++++++++++----
>>   1 file changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> index 2ff5db6d41ca08a1652d57f3eb73923b9a9558bf..3dae4f3c103802ed1c2cd390634bd5473192d4ee 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>> @@ -44,6 +44,7 @@
>>   struct socfpga_dwmac;
>>   struct socfpga_dwmac_ops {
>>   	int (*set_phy_mode)(struct socfpga_dwmac *dwmac_priv);
>> +	void (*setup_plat_dat)(struct socfpga_dwmac *dwmac_priv);
>>   };
>>   
>>   struct socfpga_dwmac {
>> @@ -441,6 +442,39 @@ static int socfpga_dwmac_init(struct platform_device *pdev, void *bsp_priv)
>>   	return dwmac->ops->set_phy_mode(dwmac);
>>   }
>>   
>> +static void socfpga_common_plat_dat(struct socfpga_dwmac *dwmac)
>> +{
>> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
>> +
>> +	plat_dat->bsp_priv = dwmac;
>> +	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
>> +	plat_dat->init = socfpga_dwmac_init;
>> +	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
>> +	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
>> +	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
>> +}
>> +
>> +static void socfpga_gen5_setup_plat_dat(struct socfpga_dwmac *dwmac)
>> +{
>> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
>> +
>> +	socfpga_common_plat_dat(dwmac);
>> +
>> +	plat_dat->core_type = DWMAC_CORE_GMAC;
>> +
>> +	/* Rx watchdog timer in dwmac is buggy in this hw */
>> +	plat_dat->riwt_off = 1;
>> +}
>> +
>> +static void socfpga_agilex5_setup_plat_dat(struct socfpga_dwmac *dwmac)
>> +{
>> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
>> +
>> +	socfpga_common_plat_dat(dwmac);
> 
> I"m not familiar with this device (I only have a Cyclone V on hand), does
> it still make sense to try to instantiate a Lynx (i.e. Altera TSE) PCS
> for that IP ?

AFAIK, yes it is supported by Agilex V device family also.
https://www.altera.com/products/ip/a1jui0000049uuomam/triple-speed-ethernet-fpga-ip

> 
> Maxime
> 

Best Regards,
Rohan


