Return-Path: <netdev+bounces-146116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5D9D1FC1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 06:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C917D1F21A98
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759B14B96E;
	Tue, 19 Nov 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="dmrOBWXE"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023076.outbound.protection.outlook.com [40.107.44.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650ED142E7C;
	Tue, 19 Nov 2024 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995471; cv=fail; b=K0epil/dD+j9jwly0m/jP37jZEXJaUGGyCj8ntgm1w9Wsvz0NxRtSW5C3nr2wA2yrfxhSwce1ZSAlSydv90PEf58383rL6CNZYBeX6STCaC+tHZcU5BXAGLeGBJVy8khQM4JMLeLyAloMRachA8MhT/HmmmQG4Puooy604wTUso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995471; c=relaxed/simple;
	bh=A7XuFI1xEiP0m1qjW84nqM4PpGZ8QAflSbr3j1e2hTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWZCwizrNFvzYHfqlsVJiGA0iF5WhJPjdb6xxOl88MjHbJRgG1WHm2U5Sfm4GvcddSGi3ct4Bym67+g5Z7u70lkqIi4Eek1EiOXPipQ1k5iW3ipePlTgTOELcoO++ooJceM1By8antpgTs0qUkGBKMZMtUrl6aI+SFxmzE3jJ0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=dmrOBWXE; arc=fail smtp.client-ip=40.107.44.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p80GDirwTxSJkaUBo/UWjtbPLo0D0bQs+GfUNPWkWR02OR/JZE38QsH0KYPhFvtYebQGQZZhzeGfKzRvSTAhmzHOErD30EWTIic/hvmLC1UEJ49bUkim4uf7p0B6FtjmkauDS0hZIfz81l0YDLOb3wahr6N+HMiIr23ZArVPFa226FrGFpfKp7emyvGv7wllZHlSeS/jXpHhhVKLi7wwCgTfxqFFtzd5vGEUi5sCp03bAMzSed9oMZl/f095ud8W+zx5nD0eTW1GrZ4Olugd2IWqCEhOOwh7wvWO8zed/ZUADzMtw00gnd+THzdGjV+i829j4xumBRgs6jsPWuhDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7XuFI1xEiP0m1qjW84nqM4PpGZ8QAflSbr3j1e2hTQ=;
 b=r2ur2NenqScryCogVIXnMVBZXkz6ZEzQhetWeD1J709bGYFoIWP0Cpv4rjcz+nuDx2ASKb5aUM/xWXKV62s9TsH4fiwd1231h+hO5urfZfmGd50VYnmUa9Na7/OVYUFo2JVJV9EoZry0GyOvGIIZH83FS4LS1IY9tGgxeTH/qL4/m4mpW8CjWkEtTrmEXzr7HOTL0/fXkR61MOYU7ptzpkea6pAk1UZNoXh1mh/4x8w7zSGlysarCzQG2cOTyUZi2f6KwCr0bUjMmxPl2tAmzGesaL11Qlc1mAWO4KTd5ogGJwob6KIWbpbRg+eFE9v9Qyg2E54HbYnRNTzk6V6G4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7XuFI1xEiP0m1qjW84nqM4PpGZ8QAflSbr3j1e2hTQ=;
 b=dmrOBWXEaGX9m/aATLlrTv9uQv4kJMwhT9bFpHABTvZo55P+mpKv8/JXdMzmR0OGoYGWpKA9wPPCra/E0HhVLuubjs6X+MWfT+sLxnjK5xUq2I/r2J6wXlvS5WBDGcONoAw3/4I5yz/YWnL3FbEdwfx8Vj+2G8fgMUt2vH41wiAE66AAq3VeuVfvbgeJ9QTZ8nugxLfGA07XFQt88IE2zxnKgQAoIQISPOgbd97hA/TQfweP5rdbpqkovWghYZre50pdzPVOlYNEBe9h6C8O/FzJoSiNNRfvOzXOUbPNo++rwNAuVLv8IegK40ktBMy1REordIPTVjpCNklRMrn3yw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB5002.apcprd06.prod.outlook.com (2603:1096:400:1cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Tue, 19 Nov
 2024 05:51:04 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8182.011; Tue, 19 Nov 2024
 05:51:04 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbbmV0LW5leHQgMy8zXSBuZXQ6IG1kaW86IGFzcGVlZDogQWRk?=
 =?utf-8?Q?_dummy_read_for_fire_control?=
Thread-Topic: [net-next 3/3] net: mdio: aspeed: Add dummy read for fire
 control
Thread-Index: AQHbOadMh8/4lWo6CUizIJ5277jZvbK9qXWAgAAuiICAAEGDwA==
Date: Tue, 19 Nov 2024 05:51:04 +0000
Message-ID:
 <SEYPR06MB51342D31DBD3C0BE9E81977B9D202@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
 <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>
 <b8986779-27eb-4b60-b180-24d84ca9a501@lunn.ch>
In-Reply-To: <b8986779-27eb-4b60-b180-24d84ca9a501@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB5002:EE_
x-ms-office365-filtering-correlation-id: a8144a7a-c2c7-4bb2-a064-08dd085e27b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0V2d0I0THp3a1pTQStsNGNmKy82dFNMRzJRdjlyaDR6UmFmZmFRcEtOSnVu?=
 =?utf-8?B?NEc4UEhHdktsT3ZCSEtzVmgzRi9hVDBCNG52bGI1Z04xMFNmM25UWmhCN2M3?=
 =?utf-8?B?SVN2ZVRWQ3dEMG9VelBxcVA3SXJDbGYvLzRUT21HTUpWcW9vbVpqQlYzZXhP?=
 =?utf-8?B?cVdEb3pQOHpNSk0zMTJLQm9HVW5pR0lMaTlQU1FncUt4TzgyY1cwVUxoUWo4?=
 =?utf-8?B?WUtsY2RSRVZGY3JxMThVZEpnLzM0VSttVlMya0dEVUwzOXVRMTU5TGhmL2Fi?=
 =?utf-8?B?U0ZyV3ZkSklST2kwb3FvdklCSW41Z3VYVTMzRXZ4WFVlWTlmb2VDZVQxZitz?=
 =?utf-8?B?ZkhkOFVyM0dBWlFBczBDeDhIQkRJOGh5eElXUWlneGpDMElqWUtSMFliUExQ?=
 =?utf-8?B?ZE1NTSt1c3JtMzRrSmRyWlZTdFdOalVWVlN0TFpSY0hFWE5JQ0VNQTQ0WE5p?=
 =?utf-8?B?YUNpSm1ZeG1mTEtUaEsxdkp2aGJ3MDRlaVkwSXV6REpyZEI2U1FPZDNpMFBm?=
 =?utf-8?B?RTFhcWtUZENkcGxqME5kWVJseE0rSjhuNDllcXZSdjFSTnA3RzJZVng3Mnd5?=
 =?utf-8?B?UEZGSFB4RWhMT2Ivb2Y5SnpzNUtsdXVrSXlNOEZYY1pDc3M3NHp3eXBnMFhw?=
 =?utf-8?B?M25Fb2hTTTRsME5Qd3A0UGpFbEFuWllKUkczb3VoQ1pDYm5zbGxHcGFGNWh4?=
 =?utf-8?B?bktpT1JxNFJOcHB5dlFqTXFSSlk2UENsV1dudC80NmZ1bGV2NGg3alkzYVBZ?=
 =?utf-8?B?dVZKU2xZK0xDOVA1bHRnblVOVnNWZ1BUOVh3aGF4VE52VlMvM3RMUm5paHJL?=
 =?utf-8?B?RTBObitKVE1jOVZqWjk0dFRWWTVTb2MxZ2lwWkVMTFhwUGNKMWVpNGZRa3Zw?=
 =?utf-8?B?QWxYY1pUQ2x5cHl6TXJQOHQycjExOGcwdTY5dlFpaENWTTQ0TGR6Z3VkMFE2?=
 =?utf-8?B?Q2tCaU5ZdDVmUG5uT3h0Ny9uRkxlQUtlandWWGhaYmVOeFduQTEreDhmRndu?=
 =?utf-8?B?T2lYMmpVNUl0dUF5K0gyWkFUcURWcWMvcFdPdnR1d0FnZEtXSlFSalYvUzBk?=
 =?utf-8?B?b2dIWnNuV0xtdmlTaDVrNXRiOFYyelAvK2NVQmtmQ0NPSzFZbUxtUEN0SVRV?=
 =?utf-8?B?VHJiWDZXYXhIWW1nQkVqQm8wZCt3alNTWVBpOVdvT0p0TVcwNjMvZi83UDk3?=
 =?utf-8?B?cEtZYmx0TWhBaS8yU1d5WTRFeHE3TjlINHVIK0IraTVTbkJLbVpYYStMMDAw?=
 =?utf-8?B?SGlYS2dRVlcvZkhSNTRoc2FJSXZFYXFZQkt3dVpKeXpEaW5OcmE1dDU4YVJ3?=
 =?utf-8?B?azRLVC9iRXdqUTgxeUlLUjhtaVk3alNZL0xiYUpiMmJRV3gxOVYrMlpPdVZ5?=
 =?utf-8?B?ZzZXSzNGSmdxa1lOcWt6VEkrWFBET1BGT0dNZmV6YS80UlMyMHFLb0hiT2Jv?=
 =?utf-8?B?M3dhZTFBSDdvZzF6dkk4VW5PZjhPSEthOUVVbnErM0NnYkhsclM1YzNJeDFo?=
 =?utf-8?B?ZkNZdkMxMm9QSzRxVk91MENPVndVUjdPalJNRUJ3TkFYbys0Z2d5aFg5Z1lz?=
 =?utf-8?B?eWJ3Vk5YeFgxTFZxc2ZwU1d3b1ZScWxzczFwdTF3YjNHeUF0blRzdHJBZFlS?=
 =?utf-8?B?aXFiMmVsanY4dDNVT0k3NFcyaExtZllQRm9tWXY0d28rT2xVREtPSFRva3k3?=
 =?utf-8?B?NW0rV0lDd2pjTlljbWswMDFBcVZaam5mS29ZaGcrSk1SaS9QMTlKQ3hndW85?=
 =?utf-8?B?NjFWazdwZXBVZzJkWmpMeld0RTNDQjlUYlpJQXMyL2lVcURETkdNV29IM1pl?=
 =?utf-8?Q?eyKEvDfjkxddPU/PsrXh87d5723SecD1SfhNg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXk5WlFiQ1dqbEVKS3dWQXZOZUszWWJqZ2VKRXF2WW1TdWZuK1NpcU5kTGNN?=
 =?utf-8?B?Zkh5SVppTFQwRm95bmU3eUEzRExCeFVYVkhNd3BZSUN0WmtOeWprQ2VMTmJk?=
 =?utf-8?B?WmRjTnBGdVF0SWdHcW9aSkxCbjlzVGNJUUExd2FnL0REVTZMWXBsU1hCRWF1?=
 =?utf-8?B?WjkzSnNJQUNGRVdpUjZPTVdVZ0lmcmd5REtuUnIxZFlZM3NvdmJqaTB0QWlz?=
 =?utf-8?B?cTl5bTNQZERkK2lCbUdsdytxdGV0eE1kMXRDWHFULzdESnFmWjUrclJaWkJY?=
 =?utf-8?B?bWJFbldUK3AvS2xnNDM1S1hUZm5SWEFZdlZFYkpqaTV6ekRpdzFxa1VmS0o2?=
 =?utf-8?B?L1plNTM1MjdCR3c1QVFBT3NGemJUL2lqT1M0QVp3ODJHM2NIZkZkZGVnSHo4?=
 =?utf-8?B?VUF5eEoxQkpHUXZvY0llQkkyQzJ4QUxHSWIwbWU5TVlQR1RDMVhveWMyTUpr?=
 =?utf-8?B?SFg3b0pyMk5rOEdwV1dKMER3RjB4TUhHUG1WazEvOSs0aWkyWHNHSTZOdVhT?=
 =?utf-8?B?NlBGNktJS1dvcC8yWHhrRjcwUDAvcDVsckR0dE5GRzJCbDNyQ1NITW01ZENB?=
 =?utf-8?B?QjNVTzFyTlNvK09uWjNuV3NyR0pyTmJtekRZb3BJdFFtbHBuSnd5Z0xjUVl1?=
 =?utf-8?B?a3BidzRIVGpLRzlGTjBOUzZmZmZ1VzNoek1UbzFGeUd0RkZhT2IwcThONlN3?=
 =?utf-8?B?VlIwRXdVZnNLV0xEWDJBdlV1Y0tmVDl0Q0JITlZ1OG5kdG1zVUkybXMwRUgy?=
 =?utf-8?B?MWNUenIwcHc3Q1JXNFJ4QmpreE8xdHU1VEx5YkpQMlBqQ0g4dWJsdHlsb2lj?=
 =?utf-8?B?TEo2ZHVxakw5Q25jd3RyVm9YaUVOSm5oT2dBTDE2OXpyNWdpUkthT1MrRnVI?=
 =?utf-8?B?V3NQa2FuV0krWmQrZmIzTUlCaWwwcWFBUVhwU0JIejY4WUtFNGhtOTF2cGc1?=
 =?utf-8?B?WDd3NmU4NWlaL3pNb1IvY3dhY0I2NEIzbmttLzlWUFNYWjFCT3RUUWNhRUIw?=
 =?utf-8?B?d2JmZVZYNlpleENUZnB2eEp3WlFWSHlUaHZNdUJDcllBamFJTXZlVGFDT0x3?=
 =?utf-8?B?ejZCeE41Q2RCZ2wwZVBnRW1tajFOcUlNdWNrb0Z0cU9ka2ZNUmgzVGdzZThV?=
 =?utf-8?B?TU1yd2RMYWNqbERIOWpST2Z4RTdPL0tpczVqZWpMSFVmTDRyYXJTRDR0aDkr?=
 =?utf-8?B?bTE1M2ZKUml4TVB0MDJNOU9EOCttc0xGN3liTVBUMnZzWFRGV09aZ3FIRUlT?=
 =?utf-8?B?MDlCelZEYnlvTVRYZXg0STdmSHRVYWNISlVkTnV5WjRmWE9aUlg1ekp0OEQ3?=
 =?utf-8?B?aHdHYXk3T2dGT0ptaHN3TTU3MzBjT1d6VVpYc29IMEVxYjVyeWNabHdHODM1?=
 =?utf-8?B?bVgrTEhseWhQZ1hIaUF4b1NDR01TdDhSUEY0N09LOGFyUUJqYjI4V00wWjk1?=
 =?utf-8?B?MnROOFN6MkVDc0Vmdm5JN3dHdVZxMDVJMXV2Y3FDZjRvZFBidVN5YXdwUXhr?=
 =?utf-8?B?UG8wR1o2Q0NQejh2OGJtMWdTYk4wd2I1V0NUWjZNa2N0RVJwZ1B5b3hGODlF?=
 =?utf-8?B?SmlYTnAvYXdWcDVMdDhnT2JLQldpOU9OYVovb2dpQ3B3ZU94MFlvT0V6dm1l?=
 =?utf-8?B?SHBacXFoTjVPUGU3ZWJXLy9nSkFaSDdEd29wM1JnWTdDSExtbGpYcUpIdE1F?=
 =?utf-8?B?NEZpSElXNThmUUNoMEwyVm43QXBCT2pBaGFwYWFRTHV2TjR3ZUNNTTczS3k1?=
 =?utf-8?B?OEVlWWJTWjBZV1JWbGlpUE5KVGYrbHdWTkJSdXdUS3FEdkNsajA2UU5qR2ZN?=
 =?utf-8?B?cGY5ZjJSU09vSDYxSG4zaXpBbDd6cWJxK1JTYmt5RXNGKzZYY29LaHh6TGF0?=
 =?utf-8?B?MWxMMnpQMWlCbnJpdEtxRUI2ZXIySHZZMlEwVjA0K3IrbzcyS2FWcmp1NU8z?=
 =?utf-8?B?VFBrdFpkME8wWTB4L2JST2JualdLY1E5YXlLMU1MeDZjYnhqWVM4ZXgxVGhl?=
 =?utf-8?B?RGZUOWxGUTF0R3F6eGxqS3dJL09nVnhnbVhlVS80ajBqUVUzcnBVbGRxcXVh?=
 =?utf-8?B?SDFuckIvMks5RnpFWVZxaC8xM2lkbmtJWERlVzlCL2NKTmw0alQ0MHNDSFRU?=
 =?utf-8?B?REl2NzdyOU9INkZzbjVwMngxdDlaTmRkdlR0ZjYxbzJBY25ndWh2VkNoMjJO?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8144a7a-c2c7-4bb2-a064-08dd085e27b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 05:51:04.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2i48yPDF+x/+oc0ywYPQ3As+TH11w+wStzrNdEDB5U7iRJWijq9t5OLJoq5A+hBRcnQI/oxVP5Ma56glSWQW6krwKex+bRjQC928UTD2SCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5002

SGkgQW5kcmV3IEx1bm4sDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoGlvd3JpdGUzMihjdHJsLCBjdHgtPmJhc2UgKyBBU1BFRURfTURJT19DVFJM
KTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qIEFkZCBkdW1teSByZWFkIHRvIGVuc3VyZSB0cmln
Z2VyaW5nIG1kaW8gY29udHJvbGxlciAqLw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgKHZvaWQpaW9y
ZWFkMzIoY3R4LT5iYXNlICsgQVNQRUVEX01ESU9fQ1RSTCk7DQo+ID4NCj4gPiBXaHkgZG8gdGhp
cyB3aGVuIHRoZSBzYW1lIHJlZ2lzdGVyIGlzIGltbWVkaWF0ZWx5IHJlYWQgYnkNCj4gPiByZWFk
bF9wb2xsX3RpbWVvdXQoKSBiZWxvdz8NCj4gPg0KPiA+IElmIHRoZXJlIGlzIGEgcmVhc29uLCBJ
J2QgbGlrZSBzb21lIG1vcmUgZXhwbGFuYXRpb24gaW4gdGhlIGNvbW1lbnQNCj4gPiB5b3UndmUg
YWRkZWQsIGRpc2N1c3NpbmcgdGhlIGRldGFpbHMgb2YgdGhlIHByb2JsZW0gaXQncyBzb2x2aW5n
IHdoZW4NCj4gPiB0YWtpbmcgaW50byBhY2NvdW50IHRoZSByZWFkbF9wb2xsX3RpbWVvdXQoKSBj
YWxsLg0KPiANCj4gQWxzbywgaXMgdGhpcyBhIGZpeD8gU2hvdWxkIGl0IGhhdmUgYSBGaXhlczog
dGFnPyBJZiBzbywgaXQgc2hvdWxkIG5vdCBiZSBwYXJ0IG9mIHRoaXMNCj4gc2VyaWVzLCBhc3N1
bWluZyB0aGUgb2xkZXIgZGV2aWNlcyBoYXZlIHRoZSBzYW1lIGlzc3VlLg0KDQpBZ3JlZS4NCkl0
IG1heSBiZSBhIGZpeC4gVGhlIHBhdGNoIGlzIGFsc28gYXBwbGllZCBpbiBvbGRlciBkZXZpY2Uu
DQpJIHdpbGwgc2VwYXJhdGUgZnJvbSB0aGlzIHNlcmllcyBhbmQgc2VuZCBpdCB0byBuZXQgdHJl
ZS4NCg0KVGhhbmtzLA0KSmFja3kNCg0K

