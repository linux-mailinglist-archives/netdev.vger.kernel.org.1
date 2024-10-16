Return-Path: <netdev+bounces-136153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD39A0910
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CDAB246AF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615F207A26;
	Wed, 16 Oct 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="EtKHXBel"
X-Original-To: netdev@vger.kernel.org
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC4207A1A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.150.181.156
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080700; cv=fail; b=N3/DAPTFCiH2l4XP3f8fKo158go1PeOUyDk943aJfrU2mF0rbMLNr8WJAbbYnUbN2hO0OpdIcmtsWDlyCLhXtTl7NCUI3p/n+1eiRbm5Zsb4c/KFw/G5SoCvGksZjBec/kroEphT1bmVCMvvXppKnTfpoGNAh57/gbPZaDCXZAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080700; c=relaxed/simple;
	bh=P/L2k2HVcs0fEs8Su4KJiTaJBiIXZ9jXy8+xJnVTx00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CJ1I8FOIpzSXMGL7Hp8GCxcdqP7cCK7rVlot+nsX97gv9IHrMRVDXW6z5Mrr3o53QlZO9ipTipmtzlYvpfQyQ4wiBPSJozRXyfrwWnwa6yp0ypd6jV93Ihh1ux9vDZ3smRw2KWUs0DkR4mUmRi61N+5hPR5yrb94XUzQ3PIZJuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiedemann-group.com; spf=pass smtp.mailfrom=wiedemann-group.com; dkim=pass (1024-bit key) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b=EtKHXBel; arc=fail smtp.client-ip=80.150.181.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiedemann-group.com
X-CSE-ConnectionGUID: K1UXypPHQda4OXvR6yZIBA==
X-CSE-MsgGUID: Aygd6hgNTgaA4BQlclxdzg==
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com) ([172.25.209.3])
  by mail.sensor-technik.de with ESMTP; 16 Oct 2024 14:11:30 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
	by stwz1.wiedemann-group.com (Postfix) with ESMTP id CF5A6B5A87
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 14:11:29 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
	by stwz1.wiedemann-group.com (Postfix) with ESMTP id A0583B5A86;
	Wed, 16 Oct 2024 14:11:26 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.110) by stwexm.stww2k.local
 (172.25.2.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 14:11:26 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.105)
 by stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Wed, 16 Oct 2024 14:11:26 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFsgech6cScnoqLe5XWfAQVFjh7MNse23jjuKjrEaYgiFayQi9xwercbwrm+Fw95Jhw5XQ/O3OuhhIorWQu4K/CdoomzmsyKNaJt46B9z5FFIaOBBxLQvXqohSCIuRjU2oIbkNrQF7ZPrNcIZD3VWRNQWTDbOJfEUKR2eQiDM9SWb1j06pcg6EpPFoYinsbYU7WgaUhyg9gmXXvGwuLwvOxc1WIjwcdxrWMpzw3BcmLVbxNX7hUHghj1lt/Gcg5VxuQabTQLyfP45o18I9LpCIzDKYTfBK9V2sPqRtiDKqrIJmaUl29ENpVwth8xrdnnKFTHeML7THssHrncGrzw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/L2k2HVcs0fEs8Su4KJiTaJBiIXZ9jXy8+xJnVTx00=;
 b=Q6gGY9YtXfSbW6jEdKVAQ19Sn7TDC131vNCzI/AtKE7DS1cIL6kQZ4IKaFKxiG3oHoVim3qsF1iEUPmOJBfm8utyHdvPmOLz3ksww/0cK/gq5VtYZL0hH4b8y8Q3Y4LAgVzap1OqzMwZEUvmyyYiAWb6qftvvzEie76tLFxi6Nqdz/l/KX2PMbcCD+9k08Hi/IUMFlwVWUQ80yJMKkQPTHhYSC9jVf2aFzZTWn9pQMrwMObw585rQ6aWoFaLqbW4qzs7mWrxeTrd+fj3bbtXxOUfUhRL69Kw4yav3or5Ws/jVb4hJi/pnLVuZNcWcnG4sr/4RRf9WEEIAbk+4VS+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com;
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/L2k2HVcs0fEs8Su4KJiTaJBiIXZ9jXy8+xJnVTx00=;
 b=EtKHXBelG2UX+i/ywj0U0tDK+yZcfVBrIQd+jD+W9Y+YWdKJalhmDui8GlITyZHfkjG/P/R7Ceel0FAPheeTQCl6mQCv73qNiiNUqrQYjEa2shKfoQsWAWuKxO1FzCZzU00uW7KxGX3FIiIeTTk+YN67Pj4rdBIS1XCL040LOME=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by AS4P250MB0558.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 12:11:16 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 12:11:16 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Dan Murphy <dmurphy@ti.com>
CC: Michel Alex <Alex.Michel@wiedemann-group.com>, Waibel Georg
	<Georg.Waibel@wiedemann-group.com>, Appelt Andreas
	<Andreas.Appelt@wiedemann-group.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Dan Murphy <dmurphy@ti.com>, "Andrew
 Lunn" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] net: phy: dp83822: Fix reset pin definitions
Thread-Topic: [PATCH net v2] net: phy: dp83822: Fix reset pin definitions
Thread-Index: AdsfrkeuGN1t4G4rQ5uDp9cO4ywjXAAEFdaAAAF4EpA=
Date: Wed, 16 Oct 2024 12:11:15 +0000
Message-ID: <AS1P250MB0608A798661549BF83C4B43EA9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB060858238D6D869D2E063282A9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20241016132911.0865f8bb@fedora.home>
In-Reply-To: <20241016132911.0865f8bb@fedora.home>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|AS4P250MB0558:EE_
x-ms-office365-filtering-correlation-id: eaa1117e-5971-4fd2-bb31-08dceddba292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGtNL1lxTHpGeHJMNmFMSUdoWk1kamVEMU9BTWFWeVN4Tmpzb2ZVcVc1WHI3?=
 =?utf-8?B?bWNrbVBTVUlkQUtxbUlnNUZSOGpreXRIcCtNSEVsSzMyeWJCRGV3N1RTSEo0?=
 =?utf-8?B?ZE44Z05Sb1lzU0JGZmd2YU9ZUlA5Q2dGZDZqWnRZdnczaTVxOG9DS0xjQ1pE?=
 =?utf-8?B?aDRodEN3U3hoVFMwOWhTQW02cVBjMzdBTHkyZ0lsTElRVlBDWVFHbXNrQmRw?=
 =?utf-8?B?cXdHQURya21tSGRuRDdzdVo3R3JLd3FMOGN2bHoyWVU5RWhMeENkZWl3VC9v?=
 =?utf-8?B?V3lQaDkxT2RYMXZVa2VCaEZHMlpvT2JmeTNiSHBvbWg1QVI3bTdLYkVrcHow?=
 =?utf-8?B?OCtYU3NzKzRHakI4anh3aFptRG83RW14bGZhakFNTjVYNVBhdlYrbWoxT0Uz?=
 =?utf-8?B?cHF4N1drMWdzVkJVTzJtek5UcGx0U3BpQVM4dEdvTUtPMXlvMElZS09jQXF6?=
 =?utf-8?B?VGVLWWZjK2tQY21ZTjF1c0ZkV1ZZSWVFTGhjWFh1c1hiZlhheUdpNHlCWU82?=
 =?utf-8?B?OEdNVnVsNk9vK1h3dVF1bytUaEZ4ZWhDajJtdVJsN1o4NTNhT3Q0V0hQVlpj?=
 =?utf-8?B?MFo0VVM2QlJPNjJTSzdpcUgyYnFKNnBVb29jSVcvVFJONWRZZnBMaDBmMEFQ?=
 =?utf-8?B?eDZ0Zm0rNHFmMExNZjZJdFYzY3cwb3g4dEkzK3RYb3NhVTlJZjB2VXEwaEtl?=
 =?utf-8?B?TUJYT0ZEanJkYzZMQm81aGdZUkRZajlrdHIzd1YvUGNOTGpMMG5GZUFrVHRq?=
 =?utf-8?B?VDRqRDQ3Y2VZQUozQWxrWUd5NURoaUlUdlNCY3I3Q0JsY2c4VzhuQUI5ODU3?=
 =?utf-8?B?bHZjMEhRVmZUTms2TUNkRlVNaVREdnltR3lVYjRBVXFhR05yWVFsR3hObGlO?=
 =?utf-8?B?R2dtbXJlNHFHbjlHN0EraGFvMFl0d2w5bHk5TFM3SjRHL3o5bmpMeUs5S2wr?=
 =?utf-8?B?VHlhVGFTUVRMLzNKaWdTQ2phZnZHd3I5YzU3V2dtcGt5bGJjNngwTG42R0tu?=
 =?utf-8?B?TFIyTkhpVm55SG4rNnF2MkQvUXhWaElLdm84NlQwNFJ6Wms0TmxKR0xKS1o0?=
 =?utf-8?B?L0Vpa0xySVZ5Q2gvRUFrOFlpY3NZanZmWUhJMW5PNEZDemF5OFZWamttRlQy?=
 =?utf-8?B?TWM1YlVaYnM1ejhrVDhIL1VJTi9PdjdicjFERExIZUF2OFZTTDFQVVgybkE3?=
 =?utf-8?B?RXZlcXlWU245YWV0a3Y3VlhqV1N2TVd6OEYxY1lBc2RhR1Q3ZzlTRXltVWJT?=
 =?utf-8?B?TnNyY0piWnNHTVN5aHZ5Y1ZQdUgwbGhwZ2psczY1YitibVZIME1VQ2NxL1Jn?=
 =?utf-8?B?dy9TZVRGSWRhSHFUd2RCWlRFRnlKS2MyYjUvWG1Dc0U4T0NHYnI4ZFNzMkVh?=
 =?utf-8?B?NzE0cWt0d3F3Ymh2REFFYUh2b1NaN3pZR3d0MlNueS9DOC9Wa21qQTFsWGVW?=
 =?utf-8?B?MW9SWlY0TU5IK2E2R1paRlhDeDVqWXN3MlFzNmdTWGRwK3lnYVdmbEhnNktJ?=
 =?utf-8?B?LytSUXdQckIyMGN2d3dQSGd1ZnN1ZXFucDRCUG43cTJEbHN2RjBnV0hyR3k1?=
 =?utf-8?B?Z3JnU1R2UUppNlQ2RlNQMEVLblc5Q21XMGVlUCtZR2JESXhsL3N2THRlc1E0?=
 =?utf-8?B?bnkyQWJ6K0Q3NzlJUjYrNVloL3NSRHZMTzVlMVVKSm9aNldyNHo3bzE4TEtI?=
 =?utf-8?B?Z3BTSCtTOVNhZW9CTk5wcDRMa29MTlYza1JlemZjWWlVOExZNk92dlhLODRl?=
 =?utf-8?B?b0o4S3hncllFZVVLalEwVW9mZFcwa0hGZGpQWDZnSWFtUkZmNDk3UVZCNjZI?=
 =?utf-8?B?Sm94bEMvUjRaMmhibjZaUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmtGbVJ5YkV2clpPeXN1WFlDN055YUVuRm9GRzgwb0dIbmp2MG1qNGlldHht?=
 =?utf-8?B?dTdqa1ZRUlE1L0o0TUp6eEVVRXdKU0MxYTJLVHJXcXFTNXJYeUlRdjJnZU1F?=
 =?utf-8?B?bDVTTUk1Tmh3ZFkyK1VvbE8wb0xCd1JaTzE3SjhsMU9vaU0ybkJGdGtVYkhN?=
 =?utf-8?B?QjlUV1JlVnRvQmN0OW93WWhjY0FraHJzQjQ1NEYvQmZGSGFqYS8vMkVncUV4?=
 =?utf-8?B?QkpEdHNKeWNFWjdKUFlJcjliaWNaMWxrM1ZRSVduVmQ0YUV2NTkvY0NHMFJh?=
 =?utf-8?B?ZnlGQTlkMld4MzMveDFMYW95WjRvcGNQRWtFYW9KR1BQYm50N2daenE1SDMx?=
 =?utf-8?B?c25UZUg5S0w5M2w2S1dUVFNCSVJHWU4xK1JRT0pIMm1SbVNBWXd3ek9HaDg0?=
 =?utf-8?B?bjYvend4cFRLWFkvTnBLaks2cFBUUG1xemJtUTM2R2NsQWlBY0JUYnN6eEI5?=
 =?utf-8?B?eW1MeTgzWVJlZTRXbUxiOW5ENGVlZWpEbUlJcnJvWGhrd21IendLdXlkRkQ5?=
 =?utf-8?B?eXdSN011WGRvV1RvRHNnS2pJL0FiSndSZDlBU01HR1BWcjlHZ1N4cCtnamhx?=
 =?utf-8?B?bDdnSDc2R2VhWWZsd0NIemlDRjVhN0VQdHhiRjZMc1ZBOW1rQ2Z2L2taWW4r?=
 =?utf-8?B?dHBOUllTUDVSWTM2SFZ2eVY0cm9BQnRDellydjFkeXVNSjMxd0hWdTI3UFlR?=
 =?utf-8?B?OGJzaG02YithZjlXMlFZTzU1SUFCRENzODdwNitIZkozUXFpMmhsdnR1blhp?=
 =?utf-8?B?Wm4zNEpBdGJ3WVJtZmlSL2xkSkxER0NBallTQnlKdk1Uay9QQWVVK0RXeGFF?=
 =?utf-8?B?NllaTlVHR0M1QWVhZ1dMSkM2eEJQRE54bEJ5dUxzVVNyKzhnTmljODBjQjUy?=
 =?utf-8?B?Tk5FNUwwL1cxL1JRZFo5VTA2ay9sS2dGOURDWEFvMmJ5aTNJWWF5bDZzckNh?=
 =?utf-8?B?R0hFOVdhNzlvVFQycm1icGlOSE95ZU1pOFptS3BHRGo4eTQySG1IWU9YKzl0?=
 =?utf-8?B?dFdFczFpVjY1VmZQRWJIWk1tTHloZWtQNHJKbEFtRkc0Ty83VTQ2QXoxUzR6?=
 =?utf-8?B?b0s0OEZrc01zOWtoSjBoSVd2cktKV1ViY0hIdnRyR1NNWVN0QUVTcTkwaU8z?=
 =?utf-8?B?Rnc3cGVRUHpQdy9uV1RMdTdmNUwvdk94Nm9FUi9zY056Wk0zUzhQYTdtemVB?=
 =?utf-8?B?SDJicHVVMytnV1hIRnlXQnl4R2Nlc01yYlV6dHhjWmtYTjkwUmF6MWJxU01V?=
 =?utf-8?B?VW9RV3g1N0ZjRTdLaHNxWHJYYlQrN3ZsNXpaVWtSN083bUV2ZkZma2dCRGRF?=
 =?utf-8?B?MlRwZ1Y1NWswT0dsL2pyY2h2Y3kycmtBalJwOVRtQVBVSC9xZlhVcHlPM1Rv?=
 =?utf-8?B?Sk04YloyVUZmak5kVFphRFhIdHBkSGFuRzY5SFQrSERNV3lxTzFyM3YveUlW?=
 =?utf-8?B?LzJLRXQvOTdEODRrV0dLTHpzOW9QYldWTnBCTWpramRZRUpiNTJVY3BqaGJr?=
 =?utf-8?B?QWd5KzA4ZWhObnZxcE1Dejd1QlRXS1pFMWZlQjNtUGlXMWtacmMvY0lnWm9s?=
 =?utf-8?B?ZmZQbzFLVXpPa0c2OWxtNXI3akh1ZnVMR1U2dDBwbElMdE9mK3JtK1hLd2Nm?=
 =?utf-8?B?Z2p1dXFZdHU1VXljbmh6RVpQTHI1SDVYN3BPcnlXSWdmTEpKa2RiaVlqcS9m?=
 =?utf-8?B?VVcrd2FNUzU5Z3FuMm5pTGtJQk8rZW02bmIrUS9qRUprMEpocVJIWEhwS1lH?=
 =?utf-8?B?QVdJVnVIb2ZURVRzRlFUejRoRDNQbUxtQTY5d3pDcTFiWHhGY1ZKSlJtRGUy?=
 =?utf-8?B?SHp0SmllMTBZNlBmU2IreURPU2dZRmRvSmwrWWpYMitOd1hHNVNkR1RlZEdC?=
 =?utf-8?B?RkRWT0d5Mk5UOHFTb2NPOUduRWdpbEo0QnZ2c3piU1crZllkQS9LUmtXRHFU?=
 =?utf-8?B?dTNlL0UyQU4vcVo3MkdJRngwanBjVi9uTnIyZ0FERDdFU012Ung4R2ZmYzky?=
 =?utf-8?B?Y3pnM29YSFFtWHB2OGhDVSt0b3N4RDdSSHY0eitVYW43MllTcndyTGNVajIv?=
 =?utf-8?B?ZFp4YVlodktIK2Y4eXowVzN3dW9zRjZlWngwQUlFdDl1R1VtVWFKaEcxTnRh?=
 =?utf-8?B?ZG0yV1VMT2dEWkpyayswNEMxSGFtbXB1VXRENzEzcGNVN09IWkN2YWY0V0pE?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cxO2Lw2urlcaU6h83e+MCOh0wIPHdX5vYjVUoxID/9dQDJ2KvU8FCE8JxRr5N09IP5fVjRvfd3piRgnbbVH1a9yFkhVN6S2WBvdkLiezIQXbaUes+CnP2mWoi2Wk4AtC/9UeltcSWhbeL0uruT6fvpv2i9h8VZeVSZGfjcBLAr6vRQKhIU/YYrJcbAIrxpeU9zF52ybRJtZoqgwiSyuwvhTUCbmhd4K7FOZkKz7CqL5vU50od+Wz3JA55YNGP7HJqWUuEAoerZnrp4Rk8iwmz2ARqU19CRKMZTGNPQ+5wxGU+5Jj9hNkmW6QfbmLL2NouyzuUTxEC3DSTzNls4kf0FfdKAYIrBkHtsmb5fEtsUObJqqB54riXZ+WDZIkXYAdKLnOhvbapAqwNblv4N1JtqTA2g+0jMPcZyZi9PVquqIvXy4iAwPh2MjbSjfPdxbzlf2MpGbBTV39CvSIjeNmrA8Q83alwrLyFNcFInVJHJhVmfLcLa5lYEt3A4Ewh2XpyLjsl7V1HtsmdGNS8LIcXs1zsPIa0RJHkzSoJhDoHdYXXLFht/MPtLenV46e1EnMngsFgS+SyW63mqDze4RbnraQQbj2QfxJWwBPtgdvmH8=
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa1117e-5971-4fd2-bb31-08dceddba292
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 12:11:16.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XKntzzneBksh2tq9yDt6tRGD3Lk9YCkYwkgubUbAoLdO2JyuM0a/sLZc1KYg5MK16fVP6+kOQGbr3CqBzlScAddYH7gM9SBN9gVRsYsHFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P250MB0558
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Dan Murphy <dmurphy@ti.com>
X-TBoneOriginalCC: Michel Alex <Alex.Michel@wiedemann-group.com>, Waibel Georg
	<Georg.Waibel@wiedemann-group.com>, Appelt Andreas
	<Andreas.Appelt@wiedemann-group.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Dan Murphy <dmurphy@ti.com>, "Andrew
 Lunn" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-TBoneDomainSigned: false

VGhpcyBjaGFuZ2UgZml4ZXMgYSByYXJlIGlzc3VlIHdoZXJlIHRoZSBQSFkgZmFpbHMgdG8gZGV0
ZWN0IGEgbGluaw0KZHVlIHRvIGluY29ycmVjdCByZXNldCBiZWhhdmlvci4NCg0KVGhlIFNXX1JF
U0VUIGRlZmluaXRpb24gd2FzIGluY29ycmVjdGx5IGFzc2lnbmVkIHRvIGJpdCAxNCwgd2hpY2gg
aXMgdGhlDQpEaWdpdGFsIFJlc3RhcnQgYml0IGFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0LiBU
aGlzIGNvbW1pdCBjb3JyZWN0cw0KU1dfUkVTRVQgdG8gYml0IDE1IGFuZCBhc3NpZ25zIERJR19S
RVNUQVJUIHRvIGJpdCAxNCBhcyBwZXIgdGhlDQpkYXRhc2hlZXQgc3BlY2lmaWNhdGlvbnMuDQoN
ClRoZSBTV19SRVNFVCBkZWZpbmUgaXMgb25seSB1c2VkIGluIHRoZSBwaHlfcmVzZXQgZnVuY3Rp
b24sIHdoaWNoIGZ1bGx5DQpyZS1pbml0aWFsaXplcyB0aGUgUEhZIGFmdGVyIHRoZSByZXNldCBp
cyBwZXJmb3JtZWQuIFRoZSBjaGFuZ2UgaW4gdGhlDQpiaXQgZGVmaW5pdGlvbnMgc2hvdWxkIG5v
dCBoYXZlIGFueSBuZWdhdGl2ZSBpbXBhY3Qgb24gdGhlIGZ1bmN0aW9uYWxpdHkNCm9mIHRoZSBQ
SFkuDQoNCnYyOg0KLSBhZGRlZCBGaXhlcyB0YWcNCi0gaW1wcm92ZWQgY29tbWl0IG1lc3NhZ2UN
Cg0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCkZpeGVzOiA1ZGMzOWZkNWVmMzUgKCJuZXQ6
IHBoeTogRFA4MzgyMjogQWRkIGFiaWxpdHkgdG8gYWR2ZXJ0aXNlIEZpYmVyIGNvbm5lY3Rpb24i
KQ0KU2lnbmVkLW9mZi1ieTogQWxleCBNaWNoZWwgPGFsZXgubWljaGVsQHdpZWRlbWFubi1ncm91
cC5jb20+DQotLS0NCiBkcml2ZXJzL25ldC9waHkvZHA4MzgyMi5jIHwgNCArKy0tDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3BoeS9kcDgzODIyLmMgYi9kcml2ZXJzL25ldC9waHkvZHA4MzgyMi5jDQpp
bmRleCBmYzI0N2Y0NzkyNTcuLjNhYjY0ZTA0YTAxYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L3BoeS9kcDgzODIyLmMNCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9kcDgzODIyLmMNCkBAIC00NSw4
ICs0NSw4IEBADQogLyogQ29udHJvbCBSZWdpc3RlciAyIGJpdHMgKi8NCiAjZGVmaW5lIERQODM4
MjJfRlhfRU5BQkxFCUJJVCgxNCkNCiANCi0jZGVmaW5lIERQODM4MjJfSFdfUkVTRVQJQklUKDE1
KQ0KLSNkZWZpbmUgRFA4MzgyMl9TV19SRVNFVAlCSVQoMTQpDQorI2RlZmluZSBEUDgzODIyX1NX
X1JFU0VUCUJJVCgxNSkNCisjZGVmaW5lIERQODM4MjJfRElHX1JFU1RBUlQJQklUKDE0KQ0KIA0K
IC8qIFBIWSBTVFMgYml0cyAqLw0KICNkZWZpbmUgRFA4MzgyMl9QSFlTVFNfRFVQTEVYCQkJQklU
KDIpDQotLSANCjIuNDMuMA0K

