Return-Path: <netdev+bounces-249327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6761CD16B44
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 06:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74E2F300B9FE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 05:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53290352C4F;
	Tue, 13 Jan 2026 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VxUIt1XR"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D4350D7C;
	Tue, 13 Jan 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768282376; cv=fail; b=DDWYZ2w2o40M/TvNb/giuXbgWBvB9wC+AW0dmLGuFr3bmcVRExblDR2eMi8sn5V5qelZUgLI+QQx9n5MjVTzW7jQJeLhtFhsoQtjTsFEP5cbGvDSV9GEhNVCH5sVR01QOvT8I98UzyWC80bj9+TAe2lJVT6Pxao8Xcd3L0YvKoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768282376; c=relaxed/simple;
	bh=rBfjSciT3m7FodtFLcpcQLhaSaRVFMyTQxDILHkYecI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RFvuGJAUB282h86yxYHEFUO3i5hYU9dMM9q5IMbMa3rXNBSbUIe6nco4RHs2IkOekQZ//KQdHw1+gRLq6znI4dy3hMd3SdaczodVWT0F8t/I36O+IWxGfoD35a+i/kmkJXW560o7533HfLJ7H7XnPHHicLM35yyX/WexdWjCSDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VxUIt1XR; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHNy8bymqEZoajTFj6NeuSwLdw5CWPdOY0Kb2pJ6+ob+TlItpG5oLHnrbl6gZH7jMDK3ZqEH3q6hL3v3kRS5qbZjBsQMqyu4kUElFKTiVk5LrHSPcSGfbID3galDnguAL2q8W/gn9CfT8xL0hRB+K/Vrgfuber6zLRAOm2TNwXwXOFbvpcNPR9b4oUPNYkzk+HXyUaMINmwamm3pUi6pucg2XAa480UNE1/pjAq5W9sCrkARH49iKy6vPDVrzjOhcVh51/M99Hdj3tYsZ/YR8PjHsdOLTjzjgvpy+42bMDMA1/sJ6BotwrnM6TBaks/wGfCjz0u/M7VamzxLfiUTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBfjSciT3m7FodtFLcpcQLhaSaRVFMyTQxDILHkYecI=;
 b=GnCCFwjbIVoHEBkp9Irn0pseFs/6A+YrLpN73UMK3ww0MENeoBS477eL/nDskEULp/Th7RqAYG58RWmV8PGOgTinacFMSp3lHFZSLaQ/Zl8pON7jSyDQnEKeY3BcPNiBSalMhsnqxBmoRBFGmo+DxvG9gUY9fSz8chIWfvnl29aqL+BPKd6QeIOhM7BTcZIOhGJFQy0rcI2m2cRuGCAGloYf5FOvm81WJYdyRGjqmeWe1fhqO/RG2VUQpcKlWAeKrCJpk1qw0Aa21ROHsE6jwgZtGdJ9ehCo2wSAp/dvulYtFHIt3gf2miX0AjqzQFq+mwU5AItmkENFV+yL1ZwiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBfjSciT3m7FodtFLcpcQLhaSaRVFMyTQxDILHkYecI=;
 b=VxUIt1XR3ReZ5hxQgKcSTvFEwxe6gSgd8kx3Osy8WyFhju7nbiF2+BJwZkW9Z+Hhd1M0QMq1CoUneV6VcheTvCj3R0ENrPaPjUMMeV/9WoUcZ26ZQjbFF23WSrAnnr7OI4EvUC+egtE/k9vzBTZGJ7WNG0xlhzaRgzBJ03B0PKE=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 05:32:26 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 05:32:26 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jakub Kicinski <kuba@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
	<michal.simek@amd.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bmasney@redhat.com"
	<bmasney@redhat.com>
Subject: RE: [PATCH 2/2] net: axienet: Fix resource release ordering
Thread-Topic: [PATCH 2/2] net: axienet: Fix resource release ordering
Thread-Index: AQHcgTcyuFf2Vi7DwU61kOBAb6TwCbVL0wsAgALQ8gCAAPM/0A==
Date: Tue, 13 Jan 2026 05:32:26 +0000
Message-ID:
 <SA1PR12MB6798EE87AC8F1C0E181D57CCC98EA@SA1PR12MB6798.namprd12.prod.outlook.com>
References: <20260109071051.4101460-1-suraj.gupta2@amd.com>
 <20260109071051.4101460-3-suraj.gupta2@amd.com>
 <20260110115306.4049b2cb@kernel.org>
 <e6499ec9-92d3-4a63-8172-3c09a8b64066@linux.dev>
In-Reply-To: <e6499ec9-92d3-4a63-8172-3c09a8b64066@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-13T05:24:05.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|CY5PR12MB6477:EE_
x-ms-office365-filtering-correlation-id: 3e79dc7f-4270-4f39-08ed-08de526522c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zjh1T2ZFcXFoT0xVMGEveUpCZTU4QU5ybkZiWFB6dmFlN21EMHRPV01xenND?=
 =?utf-8?B?ZWM1dnYybWdJd1M2alM5M1dadWlwS3d0SmxTcWtobmk0K0RoSCtvQ3Y1ajd1?=
 =?utf-8?B?ZGtQNlMwYkVjYzF6RnRkdGY1TjVaK0lsaGEzK1gvMHU0aGxCSFRzQ1NrUlJ0?=
 =?utf-8?B?cG81emZ5MHAzQ0kwSDFiMzFGa1drdVVTeExpTWpFMFpXeXl2OFBMMXhtNCs5?=
 =?utf-8?B?MXZnTEJiemgwN2t4bGdlUTNKYXlWMy8vUDM1c0VZdzBwVWcxc3oyc3FZdWdy?=
 =?utf-8?B?R01RdEs4ekdLYjl6VnFQQ1FOQ3EyKytrRytJRG1sZnEvazFJMGxOMlZlZTJ5?=
 =?utf-8?B?R3Y0Skc3NjZMTlovMjVYSWUzRjkvTHMxNFA2NExyOXhPdFQ4Y0hVUXFaWDN3?=
 =?utf-8?B?MkJNNzFVZGdhWmxhTTRpSXJBYTRad3dGVysyM3hwLzFHR1B1MHN4ZjhSekMw?=
 =?utf-8?B?RFpxbWlTUXdZMkNiM09qNGVJSldSQW4vc3k1UGFTYTNLbEE2Wk1RMVArL2hL?=
 =?utf-8?B?SXdGUkNBcUJFTVVnNlNQY2FFQWQ0V2p3QXd0eDd0Um5DcFlzMm5GTnBEM1F4?=
 =?utf-8?B?SnpFQk52MExLU0VHL21yMnY0OHRzYlR2YkoyWnFLVWhKUmE4ZDhpd0k1czFB?=
 =?utf-8?B?WDcvR213Q2ZleWpNU1FPaWhPMlhjRERBc2tCUWRKMUlTRFR3NnlaeCtxSU5w?=
 =?utf-8?B?NXpxS2owZ3JXVlBuc0FRUWxqR3E5Zy82ZW1hdWV0b3RoSnBMZGh0UXN6bG5p?=
 =?utf-8?B?QlRTcnFKQXdSMkJkUmZjSVdBNmxoR2YwY0d5eTRKa3FlUTNOVDg0TlVlazVr?=
 =?utf-8?B?QXl6ZHdWS01FN1B5REZaTVdyZkJlU2N6YVMvcUZDYUZrYWlDR1BCWmovaUhk?=
 =?utf-8?B?ZDVSTjNMV0lqTlBPaFpTbmkzWllRQTh0RDdNZmtZMlZ2Q2Q4QTZsNXI0elVU?=
 =?utf-8?B?b3B6OStjTndMUlFXMlc2NzBKR0JMbkY5Ny9KZDNmbmc1TnpOcVBBaDZ3YmZJ?=
 =?utf-8?B?cE1vSzdyVWdXSkxyS1Rqc1NtcHgvd1puSHcvS2VzeGdGd2xVWlF3MmlvMDJa?=
 =?utf-8?B?aUFKczVlOHpRSmw1L3cvc3FiWHBKRVpON1p0SVBmdUR3bDU5TVRESlpvN0NO?=
 =?utf-8?B?N0VSV2NETzMrV1Z5WVFyWHRsMjJzU0x3SnRYR1RxNW5XT0hJQ0UvUzVVZTUw?=
 =?utf-8?B?N0FqTTRXbGdaMEcrVDFoU2VBd25sRWtMT1hyR1dTclZYRDB5NVhWYmk5QTlQ?=
 =?utf-8?B?cFA4VEVDNkcrNDRyT1ZxeDB6c3ZEc1FDSlJIVkIxTEpYTE15elg4c0xNK0N0?=
 =?utf-8?B?QVdlRys1OG45bTRiNzJhbzQ3amZlTCtiRFNxS1R0OW1IMlhWSi94ZEZTMUxa?=
 =?utf-8?B?c0ZGdyt5d2ZPU0ZjdENsb1VHQWZsa2JnUm53N09VWVh6ZzkvOU54M0t1UWlx?=
 =?utf-8?B?OWdLUVhuM3lCT2daRWd1SlpDU2h1eE11SlJBbGxyOWR3OE9FWUNlZXh3Qms1?=
 =?utf-8?B?cm1wOXIrdzViRGxjeG52R2Fac04wa3BaMCtFQWNsbW8wYlUva1NxRUswOUJY?=
 =?utf-8?B?MWdLNUV4c1VtYW4xTTJrcS82WExOaU1VSHRNVFUvdERzYTd2bmw3bVNYUElw?=
 =?utf-8?B?UVNVaS9PanpXb2dTMXFwMTQzTUIwQjZyS0pHazB0bGYveGNReVpmMUtCSlJW?=
 =?utf-8?B?TkF0VEtSZk8rY3F3MWxiSE9INUpDVVFPNk9vaExWQmZHb0ZLTVo1VjZZQU1J?=
 =?utf-8?B?cWQ1OS85dEVCUTVlM0xHL1M5WnQxbS80aDZKRkUvZDJvSjVFb0NBUm1zZjNZ?=
 =?utf-8?B?V095Zjc1dXRjQXlsQi9CS1k4RHJFUFJVekRqZitoakNBOHFIVUw2UFVudEZt?=
 =?utf-8?B?TVhBVkRSckVpQkxZL3dUVUtQblhJd1FTaEVibXBoRkt0b3lWQm1jUWVGMC9v?=
 =?utf-8?B?UHhDZ1NMdlpobk9OUm05bHJueGNtQkVXU0hraXUyaGlUaGRvS1FicElPVTlt?=
 =?utf-8?B?MlIvVDBCVys5SHl3R2g2V1BObW1RbCtGY3BrcStzYVcxS2xSbFhibi9sd0Fu?=
 =?utf-8?Q?mk1dXj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE1NOWJoa0ZuVmp4OXVkdlptQzEwd0NnVmZ4QW9MaE5KSFJTYnFJdTl4QkM4?=
 =?utf-8?B?MXdmSG0wcXZubmZMVlVNeXlNVjU5dy9LcDhHOEtGd2EwbmZwMW4ycnJ6OGlN?=
 =?utf-8?B?d2J5VGZWZktUdTY1VFowdURRcEhQUEszMjlKSUN6ZGJZelg5K2xhWi8vcmx1?=
 =?utf-8?B?eExiOEZJd0Q4QXFxZEovekorMGJYbWZRcFpHdlZ6d1hRNGpCNS9kdGx5K0pN?=
 =?utf-8?B?dklNZWxvS3dSUXR3VTNveUFmQVJZK0VDdkhyVkdxSmRKSmFjMlVQWDhNZ2Ni?=
 =?utf-8?B?dGpnODFyc1FHcXVtdURVTHNzZEpjZ1ZiTlhtd20vYm1xZzlPeFNzUmdtSGMx?=
 =?utf-8?B?RnZHdTlnbDdvbmQvOEpNcGwzeC9PenhuQktGckE3elVRY2lsTlBmS1FEVUdy?=
 =?utf-8?B?UUF0K1BGZERnb3orbFl1UCtKZFpkL2x4SmkrUitZSFBjWnpYQjNOa0NYSHNC?=
 =?utf-8?B?V0hYM1h3WUQ1ZFhsdEY5Yks5bGFvWmEraWxBb1F2clJ2dmh3TWF6SzZONGIr?=
 =?utf-8?B?ZGFJeENwSDBQVHBzdGUvcU5EU0wrcFRkNXFpa0ltaW9YOFpKdC9DMVNaL2NQ?=
 =?utf-8?B?MkhSay9Ca1VKZ1oyVjVTNjJSdnIwQkJ6a2Y0dFRoV09jUnBheVlTTHZBQ2tV?=
 =?utf-8?B?ZXpkZ1VubExNa2pDc0hNd29peVJQL3Q4WmlZL2puR2g5emY2UTRVTndJVUhH?=
 =?utf-8?B?MUdlOEpURmNyWnEyUzdWR2pJNm9qQklVcnEybGw0NXlKaTBQOVZaUkI3VjFV?=
 =?utf-8?B?VWlzRUhIT0JDc3MvdU5wRHIzTkRGc1Z1QUlKOEh1L0JiZm4vSHlFVS9FRFBX?=
 =?utf-8?B?ZStzOVlBSGhHTzBBaTV4WHY0Z3craXIxYjlGWjk2UEtlTjhoSnpwbEVmT21D?=
 =?utf-8?B?MnlXUmYyWFU5SUhzUVJNeVMwd2hzVjFDN1J4SkpUQVVQb0xxNGNkemVlNGhN?=
 =?utf-8?B?MWRxeTVrT3kxL2tXcmlrZlZNZVhJVnc0VmltS3lza09tYlhHQm1FMWRlY29s?=
 =?utf-8?B?UFJ6bWU1dWhTUkFHMnB4QnhON2hnVC9OR2NMaFlBSzlJa3pMUE9jOHdCeXhh?=
 =?utf-8?B?Tm5Qb2d4WjNlU2x2dE41ZWwxNjlEUlFmZ2Q2UEd2TlRNbkV2OXVwdFNCWEpv?=
 =?utf-8?B?VGo2QUpQOVJUTms1a2s2eXZYN0gySCtTSjE2M3hEcDc2N2hXNHNwNnkzdjhU?=
 =?utf-8?B?NjNwVkdXTjUrTVBpeWZQcFgwU2hWQ2tUVUZrbWZ2d1hnYVlHdEtZZU5jTDl6?=
 =?utf-8?B?Y0tqV3hxYjA3UHdWbVpJZmRBTENFVlRsTGxLaWE0M3psK0V3bnlzcmFuaW5E?=
 =?utf-8?B?YkRBOU1lektaRHNTQXZSMFkxTFh5Sm50elFDRDU1QkFsM090U3VPaXBUdW1F?=
 =?utf-8?B?Qjc2MXpUNG8xa0g0M2FFcXZFZmFMUG5yR1RraTBtSm82c0cxNWMxMzJHNkhU?=
 =?utf-8?B?WkpGWDh5REdta2cyWXpKODRaMzlHa2txZEFnemZ2OVcyc2ozZ3Z0YkZtYWFP?=
 =?utf-8?B?WjhnMXR1eUtqNGhVVS81WndzeXZ4aHBpY1ZsQ2hEZ3NWemV0aTlJOE81eFUr?=
 =?utf-8?B?dTRNL1Y1V0tiZU9VNS9Lb0dYaWdZY3JDclloVkZDVm1Sd3FoWW9QS1JDT2E1?=
 =?utf-8?B?TVVQOEpqbm5aS2t0Vm1HUkFMYjZJeWNWSU5VYlpEb01PN3VzS045M0pLK01E?=
 =?utf-8?B?ZHJTKzVTYVd6NWhiRTdQRVZLVXlXK29sRTYyN3lIUERJOFR3OW92REhiZ1FN?=
 =?utf-8?B?WHZJMmZtSTJ5dGc2dEhmSkFXRDRaYm85aTZva2NtemVOT1dDbHhMZ25YR1Nh?=
 =?utf-8?B?VzBOWFgyMWlLSDB1bHVDaUgzWU9vUkU0VUg0T3RFd01xQmFuSXhzZlhHNFNG?=
 =?utf-8?B?UEZYZk1mWXdJbFEyVW5PbERhWHBCYVRQSXpNYytqZ0xlSWJ0YkwyRVdWQW50?=
 =?utf-8?B?T2Q3OEpweXgwWVQvMWFzc2wrSGQ1Ui81K0U1c3RYVmJhWW5HQWx4SW95clN5?=
 =?utf-8?B?cWl1TWt6UWJxUjBQbTgvdlhlcUNDbVVRSnluQjZKU3R2Y0RhUFNzTzlDMDg1?=
 =?utf-8?B?UG9qU3NreSsxNDZTT1dUNTJhdzdOd0R1Sm01Ym1qa2xZNldDbHhtSGVSVmlQ?=
 =?utf-8?B?bkM2U0NxOU5qekU4UVNCOThBa2YwWnprelNuSFlHOFNiUkhYZEM4aUZSaFBj?=
 =?utf-8?B?eUgvb2pEOHQ1ejRvdHp3ZTNnSExjT2F3N3ZrYlFyMXRqUnFuL1VpZnZlT0RG?=
 =?utf-8?B?UG1kL2NqeHU4b3VNRmxZZEJTT2RZa0ZmKzNsUkNLZlNnVUtYaTF2d0Z6c01s?=
 =?utf-8?Q?Grr/1sAX3yMUyV3saw?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e79dc7f-4270-4f39-08ed-08de526522c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 05:32:26.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09NEsHd6G7CaB4dHsQrmOaXSIEng2I/QFDxffjChywGj3/pvzqbNu4oZCg+T2w6TkysKL0QTYdc3ulJI30M2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIEFuZGVyc29uIDxz
ZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDEyLCAyMDI2
IDg6MjMgUE0NCj4gVG86IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBHdXB0YSwg
U3VyYWogPFN1cmFqLkd1cHRhMkBhbWQuY29tPg0KPiBDYzogbXR1cnF1ZXR0ZUBiYXlsaWJyZS5j
b207IHNib3lkQGtlcm5lbC5vcmc7IFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IDxyYWRoZXkuc2h5
YW0ucGFuZGV5QGFtZC5jb20+OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7DQo+IGRhdmVtQGRhdmVt
bG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IHBhYmVuaUByZWRoYXQuY29tOyBTaW1laywN
Cj4gTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4QGFybWxpbnV4Lm9yZy51azsg
bGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgYm1hc25leUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8y
XSBuZXQ6IGF4aWVuZXQ6IEZpeCByZXNvdXJjZSByZWxlYXNlIG9yZGVyaW5nDQo+DQo+IENhdXRp
b246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2Ug
cHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5r
cywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMS8xMC8yNiAxNDo1MywgSmFrdWIgS2ljaW5z
a2kgd3JvdGU6DQo+ID4gT24gRnJpLCA5IEphbiAyMDI2IDEyOjQwOjUxICswNTMwIFN1cmFqIEd1
cHRhIHdyb3RlOg0KPiA+PiBEZXZpY2UtbWFuYWdlZCByZXNvdXJjZXMgYXJlIHJlbGVhc2VkIGFm
dGVyIG1hbnVhbGx5LW1hbmFnZWQgcmVzb3VyY2VzLg0KPiA+PiBUaGVyZWZvcmUsIG9uY2UgYW55
IG1hbnVhbGx5LW1hbmFnZWQgcmVzb3VyY2UgaXMgYWNxdWlyZWQsIGFsbA0KPiA+PiBmdXJ0aGVy
IHJlc291cmNlcyBtdXN0IGJlIG1hbnVhbGx5LW1hbmFnZWQgdG9vLg0KPiA+DQo+ID4gb25seSBm
b3IgcmVzb3VyY2VzIHdoaWNoIGhhdmUgZGVwZW5kZW5jaWVzLiBQbGVhc2UgaW5jbHVkZSBpbiB0
aGUNCj4gPiBjb21taXQgbWVzc2FnZSB3aGF0IGV4YWN0bHkgaXMgZ29pbmcgd3JvbmcgaW4gdGhp
cyBkcml2ZXIuIFRoZSBjb21taXQNCj4gPiB1bmRlciBGaXhlcyBzZWVtcyB0byBiZSBydW5uaW5n
IGlvcmVtYXAsIEkgZG9uJ3Qgc2VlIGhvdyB0aGF0IG1hdHRlcnMNCj4gPiB2cyBuZXRkZXYgYWxs
b2NhdGlvbiBmb3IgZXhhbXBsZS4uDQo+DQo+IEluIHRoZSBzZXJpZXMgSSBvcmlnaW5hbGx5IHN1
Ym1pdHRlZCB0aGlzIGluLCBJIHdhbnRlZCB0byBhZGQgYSBkZXZtIHJlc291cmNlcw0KPiAobWRp
byBidXMgZXRjLikgYXQgdGhlIGVuZCBvZiBwcm9iZSB0aGF0IHJlcXVpcmVkIHRoZSBjbG9ja3Mg
dG8gYmUgcnVubmluZy4gQnV0DQo+IGFzIGEgc3RhbmRhbG9uZSBwYXRjaCB0aGlzIGlzIG1vcmUg
b2YgYSBjbGVhbnVwLg0KPg0KDQpUaGFua3MgU2VhbiwgSSB3aWxsIG1vZGlmeSB0aGUgY29tbWl0
IGRlc2NyaXB0aW9uIGFjY29yZGluZ2x5IGFuZCBtZW50aW9uIG9ubHkgdGhlIGNvbnZlcnNpb24g
dG8gdGhlIGBkZXZtYCB2ZXJzaW9uIG9mIHRoZSBjbG9jayBhbmQgbmV0ZGV2IGFsbG9jYXRpb24g
QVBJcy4NCg0KUmVnYXJkcywNClN1cmFqDQoNCj4gPj4gQ29udmVydCBhbGwgcmVzb3VyY2VzIGJl
Zm9yZSB0aGUgTURJTyBidXMgaXMgY3JlYXRlZCBpbnRvDQo+ID4+IGRldmljZS1tYW5hZ2VkIHJl
c291cmNlcy4gSW4gYWxsIGNhc2VzIGJ1dCBvbmUgdGhlcmUgYXJlIGFscmVhZHkgZGV2bQ0KPiB2
YXJpYW50cyBhdmFpbGFibGUuDQo=

