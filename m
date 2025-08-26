Return-Path: <netdev+bounces-216828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FFB355A7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6113AD056
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57228153D;
	Tue, 26 Aug 2025 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wWSnWMAt"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6727A928;
	Tue, 26 Aug 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193410; cv=fail; b=fJiUpHJQjQWXr0nwHKngzmh+JNr0Hk4TqppfibukDGSe8rH9mQbPpmYk4q9IrUimwPxjtalt7sfKMin+dO1R+L+ffF7VNG6HNC2omu1TtDcRXdaVz1Wuhx1YBNrhQ60So9V3d7puJAwzWC2XnL09bFDwR/X3Qfib7gowzydx32I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193410; c=relaxed/simple;
	bh=cYXgWqKb2kbrbgq7mekJpzITmCbHTPgQSTc91T+xG4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H7DKU4rdkINOn3FCQSv93Q1QtXUuPEho6P70Y9vMKy1ANawc9Y65AUR3FI5WNkNvJrXeewaDCvq0YOZ45jMC1dW3dHKoA3YnSsV4DlpJ4DYs4vHb8sHzRXH76BFTiKuB58XJqgc1RiQkj8t0t/GVQJeZCIvU+tK93WsMNhY3/MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wWSnWMAt; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocwuDvECCmO9DFaqedtmWYWDsyBduBLEoKghruNGTicL1zveyTo5rv1UOv3v/shRLRlI1KwMyorlLi5ZvJeg5Fhu4PFXnaqqNnBRXfDXSjG/EA7yJ+KF4aog58fAPJXFPD/DDCRv689Fx0AygtXPDWeoDPxoW6pK5ojBESLpZYWrDhXU43ooFbVZXRtHoWXbFt0ve6+XlA98DpIzQloVw5RwAwnE5dAL39OIwWEgcqiKFPqVVW8sZ3cjsvji1lGH9Il0g2hqXWkeKyIjo3X5SHaGc63RYDvi2mqcxHP7VhsWWR+rgY0xLhnZq2r6QGY15TARmZ+df5tTWKZpgP/qKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYXgWqKb2kbrbgq7mekJpzITmCbHTPgQSTc91T+xG4c=;
 b=UJYwFgKGMdgVMQ039lgUien55hqzJvhGYuAZduYFkO2SknqstGqDbRYQRgkHm13O1atalIO1WLOMCkFbiefDbkEnXViLLdzyE8aIjLZUA0xxFwBWvJzR5ceYKEY75SpviDqP5CDBk1OECZrGvdkN2XYN1oIuwxSFU05HdxSn+tz3t+hQecSDorYU44rTy9qHIZgyRIv5D30q9n3XiNDigrNWXI//M6ofo92oP9+X5WHnqtvuucnh8QdB3G66qGZKDWb8WQfyWFWXBQgn1OoAvlCIsiUepG4mpw6s8yIeE5S8SpQeM8JrCpiu+yjyqD/wH4svGyOHj3U5AGjyCf++ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYXgWqKb2kbrbgq7mekJpzITmCbHTPgQSTc91T+xG4c=;
 b=wWSnWMAtsWVi2sP6Lq4v/owvBEe/oeWZQgVTNukZ29GcSH9R4CI5lkNDn3NeqT8k7L/zeqO9/JY9iy1GNRBAf1vJI/OVwS5H1i5GqRBmy/eZz/4L0fgbzQMc1aFYMkRaEjiBCQuUZ8IXOBKGoB0WfVsxcU9AvMxDHfz6dyKdfq1InvepiwN4KQiLH7mHM5tOotKQAHqZUQ0mGgeFPMyTMwJQsyWtYkDBbiee6c74pq3mV3idCPVmFUc5wgYqY859HpXyeC6lynZOi7HtGipozt59MV1Ew4mBnEJkRqRVSF87hWic+L2mtfFFXPLJb2oMBNMLS7fd1v66e3YMWlX0pw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB3343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Tue, 26 Aug
 2025 07:30:04 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:30:04 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hauke@hauke-m.de" <hauke@hauke-m.de>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "john@phrozen.org" <john@phrozen.org>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>, "yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>, "Christen, Peter"
	<peter.christen@siemens.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH net-next 6/6] net: dsa: lantiq_gswip: move MDIO bus
 registration to .setup()
Thread-Topic: [PATCH net-next 6/6] net: dsa: lantiq_gswip: move MDIO bus
 registration to .setup()
Thread-Index: AQHcFh5xtUHypaixw0mz1pbocfmW07R0ijyA
Date: Tue, 26 Aug 2025 07:30:04 +0000
Message-ID: <3b0399d3535ba2546274733c3adb5266adc31094.camel@siemens.com>
References: <cover.1756163848.git.daniel@makrotopia.org>
	 <916803a5a597e9f8b4814cdbc9516c51f078d65a.1756163848.git.daniel@makrotopia.org>
In-Reply-To:
 <916803a5a597e9f8b4814cdbc9516c51f078d65a.1756163848.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB3343:EE_
x-ms-office365-filtering-correlation-id: 8c1e22ac-bc52-4ff0-eb57-08dde4725ffc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXJ6bDYxYVhyUC9lZjlEcTZyVTJnaStqV2ZOeVFPeXJTOU5DK1JMY3JWREMw?=
 =?utf-8?B?WGpvQUVJVWlYR3RHTUR2ZFY2RjVRTFJGN21zTnliY1YyRjYyU1lMcnVqQWNV?=
 =?utf-8?B?L3BUNHczNVZWejhNZ3l3L1NoRHVIUGVmRmdpWEpRbDFYcDhwMDFYL3luYjJV?=
 =?utf-8?B?eU15NWMvVTdVSjRFNC9vMm0ybnhBZVN5bTNaN3NSLzBROWtVUHBwWjNDdi9r?=
 =?utf-8?B?MXVobTB1bWxnTDB6VzNlMVZxaTZDV3BTZlNHZlpydDNNOUp2Q3I2NE0rZnpZ?=
 =?utf-8?B?azd1R29SS2lNb1ZKKzdJZGNjdWo3bFVNZVhlZFp3aEhWWGp5THNvMUVzVE5s?=
 =?utf-8?B?K00xb1hkTXh2bmo4ZmR5QW8xQU9QeU9uQVNpOGNNaUZvNjd2ZEYvV0tzRGto?=
 =?utf-8?B?L0Vna3lkQ1pOZ3VLMFdoSUtBOUV5clVpRTZhYTBRYUZzWlFhb3hrQzZSWWFN?=
 =?utf-8?B?MUh6OE51SUg3QTFOaUhMSFBIQ09qQnNsQVlFUmkrdlcrcklHMGR5Q0czWk1K?=
 =?utf-8?B?R01rYkVpeGlDeWxHVDNQc3FGNmxvaENzNHExbmZVTU12SU5BdFArYS9rN0lx?=
 =?utf-8?B?Nm9COWFOb2RnRDNSREFPeFZ2NnFreVp0R04vSGozR2gxMjhCM2RmcnJWMlA4?=
 =?utf-8?B?Z3dONGN6cHpUZU0zQUxMREV1U1R3UVE3MnA4NkdJZmNIaGJlZGw0QUpiUGp1?=
 =?utf-8?B?QUg5N2pORTMxbUUvWVhIZmQ0cjBPZTN6aFU5WG5lSkFTdEtZcTJta1dmakZ5?=
 =?utf-8?B?ZjVYQXk4cTR1TGRPMDZpeVE5WlZhdCtta1VZVWd6ZVdWTjRrOWdBWWQvdk1B?=
 =?utf-8?B?TmZvMlQ1RHVYWUdzVWRXcGV5S3lqVVlPWFAva1N2TU51bVJubFYzRm9mQXZ3?=
 =?utf-8?B?L2VQUnBSczJxd3lXcSszdndDK3A1ZGw3cXNzYlZLQVRSR2VBeE85YVkyRlUx?=
 =?utf-8?B?M2wrMmpldndKYmo5WFhIUC9Qdkk1RDdRellPYTJ1dWE5OEdXbi8zeDdVTDNW?=
 =?utf-8?B?VEhGS3hVbU0zOHM5YzZQME9lRkhnOWlXWmZMSmhrV0JwM1JIT25reHJzSE1Q?=
 =?utf-8?B?VjZDMUFSc2Z0ODhJQ0IxdFJ0ZTZ4QTBQQlhlbHNYQ2ZDakJnTkFHK2dSVEs5?=
 =?utf-8?B?QThoblJlK0dXQ1RjbXNUMUFBWm02bnIvOVZsU1Z3Uy9FbGV6SFQ5SGpFbFk4?=
 =?utf-8?B?bW42ekFEMUd3RnRLZWxTUkE0YlBkcGx3dGRVSFROaHNyOGtjVnhhWkJURkE2?=
 =?utf-8?B?R2pnZDAvTCtpeTdIRHdmWnlWTmkxQ25JR05lb0xUVFdzNHR4VXd1cjdaMnNZ?=
 =?utf-8?B?cVpuelVKQVg0cVdkVmk3cVdUSklXeG95bE5NbzM4SWNRTmR6M2RhaEVVSWx6?=
 =?utf-8?B?WWZ6SnFqWWdWUzk5eXhkSll1WmE5alVRRm5kSStxNGN6TzRWQTE2a3Q3Q25p?=
 =?utf-8?B?UFdmcEVtZ2tNcWZTWWplWndueDgvMjNuQzVVdmR0OTlPcXpGa0N5ekhTanFv?=
 =?utf-8?B?RS9yUVhqcG10eW9OVnlhY1RTYmJPRGlhNFZ3aVk3VjdYUXFucldKajBKSHNP?=
 =?utf-8?B?U0dyQ2dFa2NGZkdJb2d6SFlHRDlGaUU1WGNadDczTzBUMWlrbVBKUEtBaUp3?=
 =?utf-8?B?dGR6NDNTRGFRUFhTTk4rUXJybWw1MktkMnFFZUcvY0l0SXBvOGNJczdqUDRH?=
 =?utf-8?B?KzFxbk5DYXBoL1QzcnZ4UVVHY2h6MGVmemhCTkNBb2M4WWFuc1FHU21IbzE2?=
 =?utf-8?B?VytvUmhOREJuUm0wZjZNRzJtNjRweU9HZjRoMXUwK0VZNjV2VzBYN01MTXBi?=
 =?utf-8?B?YTRWVTI1eTk4N2RPUjYwUEVlK3IzanBCMi91aDNTdDBrc0NoZG8vMU9qK1pJ?=
 =?utf-8?B?VXB0R291dGFteUtvaGpiZUpBWFhVY0pUMUFiN2xzNUNFR0ZDMkJtcFE4ZkJa?=
 =?utf-8?Q?/tY2naZL41gA6CrCbO8cvTyIbysjeeQh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUt2d1p3bnJqWVBkMTZoakpvdmFBNjZsY0ZCL1hhNS9obHMyMzZWU0NYUHhx?=
 =?utf-8?B?VkdNR1RzOGNIOStlL2tianhmR05UQUlvYklhMUtjN3NIOEZrS2dUYVdpNkQ2?=
 =?utf-8?B?dURjVnFtQSsyUE9CZUxMc1BIckFsNHJyYkRZWW8zSTJXZFR0a0xYNjcrYzBY?=
 =?utf-8?B?RTBzMFNXV3Vubnl3dWUwaEZEYWp3UU1mR3pZY0JxVytRelBSQTd6QlpnOExS?=
 =?utf-8?B?eU8zWS9velVLaytlUkxBb0VYMmlsOEIraE5uUjFDL1dKalpXem5ZNEViNnpZ?=
 =?utf-8?B?M1d1bTlzdUxPRlN3b0Q1bUN3ZExxM0RiWEN6N3N5WVlacnppZ0o3WnBnTjIz?=
 =?utf-8?B?L3dDNnZTNnh2eHIydHJod0ZBSEhtMS9jaklZNXErc2RCRFBWdFhVY3dCQXJ3?=
 =?utf-8?B?aHh6Zmc1dXNEYVlNT2l6OUFoWDRPQStlaUhIL1E3aHZ1a0pSSEtFbVQrRmpZ?=
 =?utf-8?B?dDBNYXgrZlFrc3I0SWY3Rm9yeXpFVHBvYndveFJWOXllcFpPOCtmTjcxbUhl?=
 =?utf-8?B?NkVJNTVzMHBpT3hSV0o3aTh6eG9PcVN2bE90M0lGTEYwYUJRMHZ2VTJnMjFn?=
 =?utf-8?B?OVN2cUhvN0lXdDlIU05zdG13T1RLVm9wWTZVcHNwbitDQUEvTWZqWVhoQU8x?=
 =?utf-8?B?QWFkRXk3KzFkOEI1MEc5SDlJWmRrVkovY2NSVEQ3SytsaWw5TDdHc3c2Ylhj?=
 =?utf-8?B?MFhuQ3AzQThDU25FVis0bDFYa0tyUW9yZVMweGFhN2swbm5ZR0JYNk4vdU5m?=
 =?utf-8?B?UjRxbmcxc1owWXlTRzRmUmZKMFgySC81cjlVZytsSzgwbzFBR2tHYk9kUTlH?=
 =?utf-8?B?ZkV6T3p0eGpMV3JzanZiQW5zdW9BWWhVUFo2dXlBRHdiQXk1OXRSbHp2NXpQ?=
 =?utf-8?B?Y3dnOWZMaGpOQlBWS3hHWHVwbWVMNENtSnBydk92UjVBQ2p0c2xlTVhXVWVP?=
 =?utf-8?B?YUlmeHBmWWdkMFJKN0xISVBvTTg3SmlzWHFkNDdQMm90d2Y3ZzhRQi9PeS95?=
 =?utf-8?B?aDFXUE1rUERGWGFBOG41NzVLT2g2dWlKVDVoSXM0T2VZSnpXNzFWR1ZnZ2cr?=
 =?utf-8?B?Z2NtMFdKYzJtRVlXcTVYMFExd0xzcHMxSVdFM3JPbm5KcVpnbWhZYW1lNzdG?=
 =?utf-8?B?dThMYTBIa1dqNmt5ckZ3TkE0RG1yR2dzQ1dLdDNOTmcxbU80NXdrVG9LWlBL?=
 =?utf-8?B?cVZlK1RVRHYvSVRSbnhuV3l0R2R6MUxVK0loV3hpZUFhbjN0c2lySVhSeFk1?=
 =?utf-8?B?MHVkWVdPSkMzaGRMcEdnRGthUk5SSmVzckxtNU04VHhoc1QxRWVOeEZKYzh5?=
 =?utf-8?B?MGoxNCthWkMyUVJBazJ6QTM0SUxITmZSMUJYU3lZVjRBSU8xMXVyRDBvWmFD?=
 =?utf-8?B?Z2I0VGloTi9MVE9LZStHUUxVSjNwcElaRnhVcUxIeDdpbkd3cXhBb1BwTUxl?=
 =?utf-8?B?NzlqT2xQVk9Oc2xWZDE4amNFRnUwT042WlJNRGlkeStmQXRlMEV5Y0FITU1j?=
 =?utf-8?B?KzBLRitpRHBxUm90aTY3MlpOWTFNQ05Kc3BlRE5aaXFCakwxaTdrckRpbktt?=
 =?utf-8?B?cGgxYUNzL3llVWh2dkJ3bTlyQTZaT2NkWW0vOVU3TDlROXROV08yR0JyVk9Q?=
 =?utf-8?B?V0tZNXpuNXRGeE4xRkI3OGNzWUZ6R0h6WWRRb29HWmo1MzJzaE9jSW9rYkhZ?=
 =?utf-8?B?RnUwZU1sRGUwNGVSc01VT1BJSnlzYnhlcEpKemsxdlZSdVY2MUJvTWxjYjVJ?=
 =?utf-8?B?MFpXejQ5NzNXbis0clVlUE1IcUtLRU51WVQxQWNGSWlmcCtwOTNESERpTFBr?=
 =?utf-8?B?RzBrUHRqKzdtaStONWpNTU5rYmFvd0lJbVBsQWJ0TFVZUklMOHVWVS9CTC9M?=
 =?utf-8?B?emF3dHV0TGg4bU9WeGhOdGptSnFDeUdEdzVPN1hYUkE4TndlaTEvUi9kaHZ4?=
 =?utf-8?B?VUtIcWZlbzNycGx3MS9wQWpWV1dLdkx3SEYxNUMzQ2IxZ0kvSytGbUoxUXAy?=
 =?utf-8?B?VlNHUzZFMVRZYVpvMWxVcGUrMDZUamtsUWY5L21HOXFjNnBaSmJtbXR0RGVn?=
 =?utf-8?B?aG5MU292SU00SnRpaUlNbjRqWVdSZThkYWxmc05uYVI5enl6T1lQZFp3ekFl?=
 =?utf-8?B?bjd5Sjh3V29GNkZsWFcvRFJuZ1FCY3NpQ2w4bUptMEpCaXhVVThSVDRMcXpE?=
 =?utf-8?Q?4QLFZEzgISEmZqN8QRFYBv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C29DDFF647718D4A8447C0918AB8F009@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1e22ac-bc52-4ff0-eb57-08dde4725ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 07:30:04.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ITttXZzsnl0GhiG/UAV6E+BLupLqyJXHowdm8R/iWc07ZEuVXqXKchLZc+51D9vemW91Q5OL7OYbnhGe3+7dhsgZbgqvjJ9F9blx3Ji1mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3343

SGkhDQoNCk9uIFR1ZSwgMjAyNS0wOC0yNiBhdCAwMToxNCArMDEwMCwgRGFuaWVsIEdvbGxlIHdy
b3RlOg0KPiBJbnN0ZWFkIG9mIHJlZ2lzdGVyaW5nIHRoZSBzd2l0Y2ggTURJTyBidXMgaW4gdGhl
IHByb2JlKCkgZnVuY3Rpb24sIG1vdmUNCj4gdGhlIGNhbGwgdG8gZ3N3aXBfbWRpbygpIGludG8g
dGhlIC5zZXR1cCgpIERTQSBzd2l0Y2ggb3AsIHNvIGl0IGNhbiBiZQ0KPiByZXVzZWQgaW5kZXBl
bmRlbnRseSBvZiB0aGUgcHJvYmUoKSBmdW5jdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERh
bmllbCBHb2xsZSA8ZGFuaWVsQG1ha3JvdG9waWEub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0
L2RzYS9sYW50aXFfZ3N3aXAuYyB8IDE0ICsrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2RzYS9sYW50aXFfZ3N3aXAuYyBiL2RyaXZlcnMvbmV0L2RzYS9sYW50aXFfZ3N3
aXAuYw0KPiBpbmRleCAyM2I2ODA0N2YzYzQuLjllYzI2MmVjM2ExMSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZHNhL2xhbnRpcV9nc3dpcC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9s
YW50aXFfZ3N3aXAuYw0KPiBAQCAtNjI3LDYgKzYyNywxMyBAQCBzdGF0aWMgaW50IGdzd2lwX3Nl
dHVwKHN0cnVjdCBkc2Ffc3dpdGNoICpkcykNCj4gIAkvKiBDb25maWd1cmUgdGhlIE1ESU8gQ2xv
Y2sgMi41IE1IeiAqLw0KPiAgCWdzd2lwX21kaW9fbWFzayhwcml2LCAweGZmLCAweDA5LCBHU1dJ
UF9NRElPX01EQ19DRkcxKTsNCj4gIA0KPiArCS8qIGJyaW5nIHVwIHRoZSBtZGlvIGJ1cyAqLw0K
PiArCWVyciA9IGdzd2lwX21kaW8ocHJpdik7DQo+ICsJaWYgKGVycikgew0KPiArCQlkZXZfZXJy
KHByaXYtPmRldiwgIm1kaW8gYnVzIHNldHVwIGZhaWxlZFxuIik7DQo+ICsJCXJldHVybiBlcnI7
DQo+ICsJfQ0KPiArDQo+ICAJLyogRGlzYWJsZSB0aGUgeE1JSSBpbnRlcmZhY2UgYW5kIGNsZWFy
IGl0J3MgaXNvbGF0aW9uIGJpdCAqLw0KPiAgCWZvciAoaSA9IDA7IGkgPCBwcml2LT5od19pbmZv
LT5tYXhfcG9ydHM7IGkrKykNCj4gIAkJZ3N3aXBfbWlpX21hc2tfY2ZnKHByaXYsDQo+IEBAIC0x
OTczLDEzICsxOTgwLDYgQEAgc3RhdGljIGludCBnc3dpcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiAgCQkJCQkgICAgICJncGh5IGZ3IHByb2JlIGZhaWxlZFxuIik7DQo+
ICAJfQ0KPiAgDQo+IC0JLyogYnJpbmcgdXAgdGhlIG1kaW8gYnVzICovDQo+IC0JZXJyID0gZ3N3
aXBfbWRpbyhwcml2KTsNCj4gLQlpZiAoZXJyKSB7DQo+IC0JCWRldl9lcnJfcHJvYmUoZGV2LCBl
cnIsICJtZGlvIHByb2JlIGZhaWxlZFxuIik7DQo+IC0JCWdvdG8gZ3BoeV9md19yZW1vdmU7DQo+
IC0JfQ0KPiAtDQo+ICAJZXJyID0gZHNhX3JlZ2lzdGVyX3N3aXRjaChwcml2LT5kcyk7DQo+ICAJ
aWYgKGVycikgew0KPiAgCQlkZXZfZXJyX3Byb2JlKGRldiwgZXJyLCAiZHNhIHN3aXRjaCByZWdp
c3RyYXRpb24gZmFpbGVkXG4iKTsNCg0KTW92aW5nIHRvIC5zZXR1cCBjYWxsYmFjayBtYWtlcyBz
ZW5zZSB0byBtZSBpbiBnZW5lcmFsLCBidXQgaXNuJ3QgYQ0KLnRlYXJkb3duIGNhbGxiYWNrIG5l
Y2Vzc2FyeSBhcyB3ZWxsIHRvIGRlLXJlZ2lzdGVyIHRoZSBidXM/DQoNCk1heWJlIHRoZSByZXNv
dXJjZS1tYW5hZ2VkIGRldm1fbWRpb2J1c19hbGxvYygpIGFuZCBkZXZtX29mX21kaW9idXNfcmVn
aXN0ZXIoKQ0KaGF2ZSB0byBiZSBkb3duZ3JhZGVkIHRvIHRoZWlyIGNvcnJlc3BvbmRpbmcgbm9u
LW1hbmFnZWQgdmFyaWFudHM/DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFH
DQp3d3cuc2llbWVucy5jb20NCg==

