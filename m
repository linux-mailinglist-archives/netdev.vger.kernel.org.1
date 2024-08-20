Return-Path: <netdev+bounces-119990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4C5957C9B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A720DB2298E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896FF5338D;
	Tue, 20 Aug 2024 05:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Uo4mCuJA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC528F0;
	Tue, 20 Aug 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724130648; cv=fail; b=LFELJxBsaGfCeejDedwBpzJS5Q49BiEUj3sMKJIcVstPWoXdk3KZZIPbF9/KJCI2fKRbDk6uVfsKvEis6CVq6pCSn4RxU9piA9lCV9+1hJ1FcpUfSpX8Bxvc2/wBDXhwr6Ilv6wJTcrDnbQ0ACQfeLiaLSvqbxJxZLppKcmT98w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724130648; c=relaxed/simple;
	bh=P9IlDUZaag3UQpsBUDndlMCPVM53+mrT9ltbLL5T1tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAcakXxcRnroQl5a0ze9EY03ZNFEqtin/++J8P3gdlONCHqGrs580Mlph/MBKLXPYVnaQc/oOXVCFE8kSBe2tZ6dLOlI52mqOkzZqSqlFnXeNYREFcVeuYbYSNvZpDwf84883IMbmYRTLhIMoJ1rhcadztYBt8p5nmhCtb0ei3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Uo4mCuJA; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWbyzLcQp53nPJFqMShlC5VPPjrrjQTAy+maPX8cJ9ZOuipF5xWEdNOVqlOFIRJ3kQV3vuIwLziKtGcWWu2BZIA97RIwgaM/OoorlozTAAEQYFpfBkPuP35ARu7v/SqfZptN1AVfYPHS68IOuKFdrK8sAX41oikZZE9iD6G06cyAiYHy+V6j84ChLYAlVXecd3HHy27N3JE+XyR8IxxjOgTnlkf0gt+X0y2yZBnX7HsijSsIqD3pW4+r8PHSkmeQNwRjQUsB6FLAdsgzosLdtzOtMk6YWXCChjgJekuooUZJ86GnrmEx2HEH+YjOIfcWPUuBZW++chSk5xt0m8j4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9IlDUZaag3UQpsBUDndlMCPVM53+mrT9ltbLL5T1tw=;
 b=aO6cWQIaPrt2xVVosfwig1HQq94eDt1thlclBmk8uutZpyZFQ0GwPYapMqxHHFbGfVb84Hefe8bNC+9vLsE8veiOE78EbRKWcxti3UnGUZK61mZmTdlYub0O/eGKsyuAsriNVfRycVlSetjs63dqGJo8/N5DD3a5/s5yk+ebektI9tPV0jZv1DlJHm+voVVKFH83dwcHQI8yNLctsvGTckprK+/Rb9cyfUz4c9BoSEA1eUT7ZIUwWbKJOrhZ8F2S2gV1t0QhyMkfKoglHpKxF3btEnvghWopXoWaCUYByoC52HtSdJjnfY7bKsl8IGl4iB2qG0z69s3+/NeeRfjqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9IlDUZaag3UQpsBUDndlMCPVM53+mrT9ltbLL5T1tw=;
 b=Uo4mCuJAXFVYFmUqjpO0lucQum+Z1rkqBvqCmVmlJc1od/k4oViW5uD8ge71heq6fLGmX+Ax0k9CL9+oxJeY+NTqPx7CVQcau017LpamEitP1yZQGA6COowbIockm0js5L+thDtcZ9LhGzVhVRJTIplulC1a8Vb5AojRsJocSazMahZ/NUaAhmKaUOwSbn0iZKt8U1dZ7slnPQoTaX+hZSJQEbfG1D6JBY2So/IOLJ26d3ODcg1J2MWRlFlyEy+MZbtuiCoJmcr/NuAr+dwqXE3tZOA6BUie9QFq8kg1SJvTT6tv/38GN8tFXQJmZXEZSrzpZLI56sClbnVQtuU8Fg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 05:10:41 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 05:10:40 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <masahiroy@kernel.org>, <alexanderduyck@fb.com>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <rdunlap@infradead.org>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>
Subject: Re: [PATCH net-next v6 10/14] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Topic: [PATCH net-next v6 10/14] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Thread-Index: AQHa7KKPrhiVuFptV0eS+tbagLmoKLIqIq+AgAQNJICAAQrEAIAAar0A
Date: Tue, 20 Aug 2024 05:10:40 +0000
Message-ID: <aa183159-81fc-4463-876b-00e749e18760@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
 <20240812102611.489550-11-Parthiban.Veerasooran@microchip.com>
 <20240816100147.0ed4acb6@kernel.org>
 <1cd98213-9111-4100-a8fa-15bb8292cbb5@microchip.com>
 <20240819154838.3efa04fa@kernel.org>
In-Reply-To: <20240819154838.3efa04fa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DS7PR11MB6248:EE_
x-ms-office365-filtering-correlation-id: 5425bce4-4003-45db-f490-08dcc0d66f97
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFRlb01lVGFiMWpoeG1jaThTY3BPdzdGdXgzTTBYVlVIZzFTUGpNYTlZUVAw?=
 =?utf-8?B?bE9KblNEVFZ4b2w0b2VpL2JyTmFndjByODN1cHUyMkdUMkdMZ0pRNFhHdUZk?=
 =?utf-8?B?U1pTT3dEa2ZTSkFsSlY0TjU1MGtweVA2ME5tNG9nVE53TEZGUU5WaTI1R2Nm?=
 =?utf-8?B?V2czdnhVTCtmV2d1OURhb1NGaEpBOTRWQXozSWYrZjBHTEN5VWJxN2dwNUd4?=
 =?utf-8?B?NGFyNzEyejgvNC9IdjNrUTF3VldVSFp1TnJHOGtYZEFWOExxMU9xeTY1bUVw?=
 =?utf-8?B?RU5rRG9zNHVuOUFtNHF5aXQvMWdWcmtpT1ZlbWVNM0pEU0pUUzlyNzcrM2g2?=
 =?utf-8?B?S1RlNGRPaXkwbzVMejdwNFhZTlh4ZkJJSWtqanJGbFl2SmxqN1RCaUtCZVhm?=
 =?utf-8?B?TTd0bUZCM0kzblFkZko5RUowdTVQSFhBRTBocTEzZlNSWHJhQjJNYWVkMTZS?=
 =?utf-8?B?M3FNUVVzOTFxUWN0b3A0bGRIbVZOVGJXdWVSdDBSU1ZYc0NPWHNCWkFRcVZS?=
 =?utf-8?B?Y2dJNEs4NFBKUjRWS2l0eVpJY0xRV2dnSnV1TFBGRHczU2F0UHpNU09XbEZi?=
 =?utf-8?B?TE1meGN6bzBqdlU2R2I3eE5rOU5jTTdjNDljNGJHb2Z6MHJ5dVREUFJvQjBl?=
 =?utf-8?B?STNqYWlZb0lldUZVcE9SbW9neG8wMThrVTFldDFHcVhRa2I4dWhmQU0yMmlh?=
 =?utf-8?B?QzBlT21LSG4wQURrbVEzcVh4YlZHTmZyTGhUQkIzZHE0a2lidnNOaEtOWkM2?=
 =?utf-8?B?UjBoSkZGOWc2eFIrT205VGlObnN5NXFBNXhjY1A1dGZ4Wnd0djg1RjExNGN5?=
 =?utf-8?B?TkM3RnNWSTUrcGpZalJCdUxCZ0VEY21zYnA2d3Q1SjdsakoxcGxpdFZrbjRt?=
 =?utf-8?B?MVRSOWNBQ0tIQ0xtUFVMSWppUmtjNEJqeXZhS0lZMFNqWlhKUDZjZStFeUNM?=
 =?utf-8?B?T1ZMemJCUHFyUHhWSUdFRG9zenRsV1pXd01MVDZoQis2Wmp4ZXQ1QnpsbFA0?=
 =?utf-8?B?dUFtTjJUaktuVjlTbzJoakd6dGRXWGZ5NTBmSGRwVWhqdXR2ejlsektTYXhj?=
 =?utf-8?B?ckJPc3MxZXFyQm56ZDh3ZFpzZ09FNkhCR2xLNmV3L1NHNGVEcGpSVTFqNGdr?=
 =?utf-8?B?RlNqdk10UENjWDhoUkl1MFpmU2lWQmlKc3ptSjJVRDAxOEVQcXN6S21HUUFv?=
 =?utf-8?B?aHdIaURXTkdtZnIyYUNCUGJxSUx1TWl1a0FoZTY0SDVWdlg2OFUyRlg5OG1E?=
 =?utf-8?B?QjFDcG4ybkJTV25mRTQxMW9McHlRRjhIOVJUZzFuZ2hkQUx4dXlSOERzTXJj?=
 =?utf-8?B?Q1paTEw3TVZPN0cyZDd5cTRybmorRUJjcVAyUVB1eWczL0ZQUmtYV1NPdGVX?=
 =?utf-8?B?VUI0VG5BRUZBZTY0OFNnRzNLSTgzcExQVnJBY3VBV1Y0WFdKc3NZWWJ0VE9Y?=
 =?utf-8?B?c2FkZXBIMHBuM3lXY1pLc3BROWdkbWdrZlRyQktoS0svZldFR2xmV3dlR0V5?=
 =?utf-8?B?TDQxeUROaXY2NnEyTERHK3BrdFRVM2JmZ3JEZ2V5RVcyZ0ZFVHV0OHpQcGhr?=
 =?utf-8?B?Sjc3d1NkTnc0Ny9zRFlsU3F0OHdKY1FaUk14QlVFeDUrN1RIWml4UDV2WXJH?=
 =?utf-8?B?NnR5TkJUVG45TTByS0NZdzJIQS8rN3N4SDdrRjFhbVZHeng4eVdXTGdJRGxS?=
 =?utf-8?B?L0lFMjFXTThMczkzU1JYWEt5MExvWm1MbUtYVkVFakZwNXFUNzNoUnE5RHBi?=
 =?utf-8?B?dUVVWS9IbGplWDFvOE5WQUEyUDRCVkZTc1dVVGZjNDdZTEJab0tHMGppU2sy?=
 =?utf-8?Q?m6RNUhX/KcfHTQHsDdjJaEEXHTlg2MAB5UfQ4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S25WYllSU0orZTlhZk8wc0RQbGNVUnZTbkxSWUo3OEhMdHNXVmMrVHhSY3Uw?=
 =?utf-8?B?OXI0RkFraFROVTRTOUM4eElqMWI2SGF2Y3BmSlJFRlovNDNwQU91TlpHbG0z?=
 =?utf-8?B?djhkMjNNZjRyUEJWZ1VmUjdveitPMzhwVTRvYjY3bldrQStxT2x3ZHhYMHV5?=
 =?utf-8?B?OWF0NEhZZjdLbWJBL3lDUEwzQ1B5YUk4MzBzUjkwbDZMK29OWVQxS3F3Q3NY?=
 =?utf-8?B?SmVGOHFyL1N2Q1JFUUxoczN1T2pNL0N4NHhtRitGSlUxaHozWk9OSjhHdGQ4?=
 =?utf-8?B?YzVlVHl6cHZ2N0VSUEpjTGZ5dVlSR1cxTWdYUDBFL0R5a0hBUEZ1MjBrVWhM?=
 =?utf-8?B?MFAvaFdxWkpwTVpLVjZrLzc0aCtkQk1MNUtLUDU2V0JrNkZ4aEg0eVVCc2JR?=
 =?utf-8?B?b2VBTW83elNNMUJYbnpTc3JWeVV1dlpmN1B4alpqY0Q1T2lrNmJJMXBDOGo1?=
 =?utf-8?B?M0w0eTBjdmZNVXVkN3Y5KzJVK3ZJZUV1a3Q2eWE0OUx1eEIxSWw1QnpVd2lp?=
 =?utf-8?B?REdQdGhlV284dTVQQjVuclJoN2xUbS9USHhMT1M5SzVCM2pxUFNSMTV5cWNr?=
 =?utf-8?B?VlM5NytvNWcyNVk3RVRrUUxSQ2VsbTUwL3dXSlpzSEs3SFZWZWlyWnNFWDJk?=
 =?utf-8?B?dWpKc3VaVHZIbjBueUx3dy9BM3F0ejlrL3JtU1dDRWhmR3FjZEdmQ2x5K21a?=
 =?utf-8?B?VEEyblhDOWVUS2JCcGd2TVVVQktvUjJkNVUwcklrSUFwTVJGLzlzVFZCT3NS?=
 =?utf-8?B?S0dUdWNtRCttYTMrTDRFbGhKZ3ZNbzNuRmJIWmkwOCtLV0VSSkZES0RBdWI5?=
 =?utf-8?B?MWcrN0xWaGRLL0c0UnNQRm1vQUFpY0dWZCs3OWg4M1FRUXUreWswZHRQOWdJ?=
 =?utf-8?B?MlYvUTdqWFFqRVJjRWptTmRBYi9NWHZ1Z1UrU05PUi9xK1I1VnMxaVFxYTIx?=
 =?utf-8?B?Tlh6eEtYYUJTajJqRVJZa0JieVJMbXMwbzVlaFdMRnpJbEUxRE5GOXZBa1VB?=
 =?utf-8?B?SUdIbENINUZ2SndhVTlET0tQb3ltenN1bW5tTmF1V3ZTTllvNlpJQ1psanU1?=
 =?utf-8?B?SmJXU3MzK1d6NEc3VlFYVTRrVkp1K0FJZ3g5MCs3cUNJbFFhZTZBelRnUm5y?=
 =?utf-8?B?WWJhRndZT1ZUOGRRMHNUR0F2VWxIbDhsYTFnZmZUZVdKT3BHeVVpVTBENUVB?=
 =?utf-8?B?WUdhRnFTZTdJMmVOUkZtRDJFSm1rL1dlZW9BcG9nNlJPa09lVFJTRXJubjdp?=
 =?utf-8?B?bEo5UTFPUlFZRUpNM2FYRkFXMCtFNGtFcU13S0xLL0k2VHNXdzdyRVFyMU1w?=
 =?utf-8?B?UUswK0ljc05MRXZOT2hrL0JLOEFWSkZJajd5VGVzVWZ4TlFIeXdaUk9JREVt?=
 =?utf-8?B?RGJTZW81cFhGZTlOYW9KVGhpVVdOUXkxZEU4VjVTVFN6QjlWS0l5NlJjcUJ3?=
 =?utf-8?B?TEVpZGVnTW5YZ1c5cmdCRG1QbEdZd1IzYS9FSGpMcytUbk8zZ1RwWlVXTklp?=
 =?utf-8?B?aitXQjFPQ010KzhXaHNqVjN6QVFGUVFQSHgvR0RITWdZR094RldUSVRvMHZJ?=
 =?utf-8?B?OG9jVG9UT1FyY0F4akZRU1g3TzlLaEsycUZCN0F1cGxTa1JoRFkySndsNUFu?=
 =?utf-8?B?Zmw5QmVOZG1kSHkrd2pKUW01TGd1MS8ybnlpQzNhQWVGa2JlRllEWlZIZ1ZM?=
 =?utf-8?B?TjdzeEczSXJKT2M4VHduUmNUckFVSzFxUmorL0lCQ0hBdW15c3BWdU9EeUl6?=
 =?utf-8?B?dEN1RE9hR0pCMmN3MThZNVNZRjVFWHlRN3hFOTJuaTRkV2owbE9ucTJYR0I2?=
 =?utf-8?B?dkVVbENRVzRJTlF3ZXhnNVdPMmUrVEFFTW9OZ3hQM1NoL3pNK3oxR3N1SGIr?=
 =?utf-8?B?bzFiNmpzcXB1M2ZiQ3g3ZEtDd0tuaGJKQnVXTmduNHlvOEpsU2ZyTUt6d0Jt?=
 =?utf-8?B?L2FRYkZHb2V1ekt3WGtGcHRLNnk5b1NuaFdyMnB3VTVqNHJsZGx4THFrQ3lk?=
 =?utf-8?B?NlBrYUI4RTRRS0lzRGZHTmF3V1luUEMvMUVlM1BTVG9YQ21LR2JLdEJadTBK?=
 =?utf-8?B?Mm5IWVNWSkQ4MFpZbWtTTUkwa3VNeTJvYmtuNG90OXhHV0VxeFJNTG9FNGV2?=
 =?utf-8?B?a2d3c3hpQzN6UWQxWGk2ZklwZHFqaC8rdm1aNHR1V2h4b0ttL3c0Vkd0eStz?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <625BBBE24A2E1240B06E9D1ECE53627D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5425bce4-4003-45db-f490-08dcc0d66f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 05:10:40.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zmh/bLxRijQsz4+VdT8T7DUr+IfrUfqjzLuOoIi+8s5scUyrTV0nevxQi5D4Uh9+lOL1jR4jy2EPjuIOUPP0ZUhpJPlAloEUhbwEPkzl8yvtv57nCdQzaVaBhwU7ng3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248

SGkgSmFrdWIsDQoNCk9uIDIwLzA4LzI0IDQ6MTggYW0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgMTkgQXVn
IDIwMjQgMDY6NTM6NTEgKzAwMDAgUGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20N
Cj4gd3JvdGU6DQo+Pj4gVGhpcyBpcyBhIGJpdCB1bnVzdWFsLiBJZiB0aGUgY29yZSBkZWNpZGVz
IHRvIGRyb3AgdGhlIHBhY2tldCBpdCB3aWxsDQo+Pj4gY291bnQgdGhlIGRyb3AgdG93YXJkcyB0
aGUgYXBwcm9wcmlhdGUgc3RhdGlzdGljLiBUaGUgZHJpdmVycyBnZW5lcmFsbHkNCj4+PiBvbmx5
IGNvdW50IHRoZWlyIG93biBkcm9wcywgYW5kIGNhbGwgbmV0aWZfcngoKSB3aXRob3V0IGNoZWNr
aW5nIHRoZQ0KPj4+IHJldHVybiB2YWx1ZS4NCj4+DQo+PiBUaGUgZmlyc3QgdmVyc2lvbiBvZiB0
aGlzIHBhdGNoIHNlcmllcyBkaWRuJ3QgaGF2ZSB0aGlzIGNoZWNrLiBUaGVyZSB3YXMNCj4+IGEg
Y29tbWVudCBpbiB0aGUgMXN0IHZlcnNpb24gdG8gY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBhbmQg
dXBkYXRlIHRoZQ0KPj4gc3RhdGlzdGljcy4NCj4+DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzM3NWZhOWI0LTBmYjgtOGQ0Yi04Y2I1LWQ4YTkyNDBkOGYxNkBodWF3ZWkuY29tLw0K
Pj4NCj4+IFRoYXQgd2FzIHRoZSByZWFzb24gd2h5IGl0IHdhcyBpbnRyb2R1Y2VkIGluIHRoZSB2
MiBvZiB0aGUgcGF0Y2ggc2VyaWVzDQo+PiBpdHNlbGYuIEl0IHNlZW1zLCBzb21laG93IGl0IGdv
dCBlc2NhcGVkIGZyb20geW91ciBSQURBUiBmcm9tIHYyIHRvIHY1DQo+PiA6RC4NCj4gDQo+IFNv
cnJ5IGFib3V0IHRoYXQgOiggVGhlcmUncyBkZWZpbml0ZWx5IGEgZ2FwIGluIHRlcm1zIG9mIHJl
dmlld2luZw0KPiB0aGUgd29yayBvZiByZXZpZXdlcnMgOigNCk5vIHByb2JsZW0sIEkgdW5kZXJz
dGFuZCB0aGF0LCBJIGp1c3Qgd2FudGVkIHRvIGxldCB5b3Uga25vdyB0aGUgcmVhc29uLiANClRo
YW5rcyBhIGxvdCBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzIGFuZCB0aGUgZmVlZGJhY2sgdG8g
YnJpbmcgdGhlIA0KcGF0Y2hlcyB0byBhIGdvb2Qgc2hhcGUuIFBsZWFzZSBrZWVwIHN1cHBvcnRp
bmcuDQo+IA0KPj4gU29ycnksIHNvbWVob3cgSSBhbHNvIG1pc3NlZCB0byBjaGVjayBpdCBpbiB0
aGUgbmV0ZGV2IGNvcmUuIE5vdyBJDQo+PiB1bmRlcnN0YW5kIHRoYXQgdGhlIHJ4IGRyb3AgaGFu
ZGxlZCBpbiB0aGUgY29yZSBpdHNlbGYgaW4gdGhlIGJlbG93IGxpbmsNCj4+IHVzaW5nIHRoZSBm
dW5jdGlvbiAiZGV2X2NvcmVfc3RhdHNfcnhfZHJvcHBlZF9pbmMoc2tiLT5kZXYpIi4NCj4+DQo+
PiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvbmV0L2NvcmUv
ZGV2LmMjTDQ4OTQNCj4+DQo+PiBJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJlY3Q/IGlmIHNvIHRo
ZW4gSSB3aWxsIHJlbW92ZSB0aGlzIGNoZWNrIGluIHRoZQ0KPj4gbmV4dCB2ZXJzaW9uLg0KPiAN
Cj4gWWVzIQ0KTy5LLiBUaGFua3MgZm9yIHRoZSBjb25maXJtYXRpb24uDQoNCkJlc3QgcmVnYXJk
cywNClBhcnRoaWJhbiBWDQoNCg==

