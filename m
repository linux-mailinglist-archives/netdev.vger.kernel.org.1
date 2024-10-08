Return-Path: <netdev+bounces-133015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D797B994489
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D9DB22A42
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7FF18BB9C;
	Tue,  8 Oct 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZVsvsAr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815F913AA4E;
	Tue,  8 Oct 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380592; cv=fail; b=p9OKna2BAmv/4739JeCjOpi/kYpD8Tgr0f+GsVtzN6ds//OlNx24lh+e53uEWHyogwC70B6xO9X69PmCxDy0wEkeU5BpG2S0K4IA6bnEp2QY+MRu5rNtr9rFkGH/YX87tDWAIDAwHyz8t4T0uVa6p2X2kiRLcqudPtIjmFuFSeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380592; c=relaxed/simple;
	bh=V5SVzFFCcTUKin2/gUK3oCkOKS49MFQPaXSV3D89XaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0q11iZ7glW4xfu39JHtQwyTKcuM5ondEFoTmrr3kq5dGdF/mrx+QjKbjDjnYRqAMXU/yYYy8Hzq2kY0f55UOFJkCdbqI9JsCrjpnZ1bwGQpQ9Q83q488Bi6BDXvM2sD77KHziZaGgNR3dEsT5MMqaztjClc4jA1q9q9ANtQKIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aZVsvsAr; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcuisMqxQEhwbc83xPvYqqgcAFLD4dy4So+UYgFh5cDoREfMul0ZqmfRXFiUy2pM9eYhkp+R2LdjGvlVibU0t9+KT7ePRCxNgxKs3cFqhjv0QLNz6JjVvpjYstEG2DSSmtJ+F5bpZWhydq14663JGOjzfZP5Un/HUa+Kq0w0kVJENbi6a0ACgFSzMrdwFhqg9Dq2oNyrJOtAFSI9IekxvTcWCFSKPWaSAYfiHz5aRfwCxEwgzkuiflb01odj5AKXOpjExfk6b+MTHgNsYQEDbEB2UBksPjpsq742bOU1G0cRhwQyuECzaWvn9GBu7IGruiHOGYv2fEV5i61fZ26Qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5SVzFFCcTUKin2/gUK3oCkOKS49MFQPaXSV3D89XaY=;
 b=x7qCxQ7mf7RpSZCiCQKlr/aB3ZdjMpbjD23D2vgVDnBO35boKqNooobw6XFFCelOFIXURKpsSWE8msVS61t1g8aT5fqYTNKhPnIYKx9dZoSLqBqLKsmDf0KjVMlQ2P9ZX7XnJ69RRCo0cLrYXO3f4AhI9SvHAWbnlUwP6mbhV648ci/CGsdG4FOUTy+rFB57f3vA6kBn4iIQJyGkenLRQkj1GqPQBaJ0wWYNXmb6CIfI1u3Ox0JGcjqBb0nLH3NZb2kJlIutM1Q5uKkhMwlOY6PJ+WB31DIckIxKH1Bqw4V4r7Kg5+svgZD0H2regv2I5Sn+l3u4PXfd73MOp+G3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5SVzFFCcTUKin2/gUK3oCkOKS49MFQPaXSV3D89XaY=;
 b=aZVsvsArOfKEymnzWfTRyus5/ndZi5KhxBnVrrpPJKGlXDu2oI88AVK4GnT46APY3/0DD2oq0SyCXRniXZRqlazxWh9wfKCyh/3LZ7qYuA8RSKNGFtSK/F47Ux3CN2rhz10y/asW5vZ9sn8AIB2zgF6umzzxr9w4fAeMTIuko6Qpy/YS6qhbtEASoUnfHvbFZ4jCSlalJc0mDmiKAqCcMFQbRYDl7AG3phjS43EZQFjRrxrPKHSEgngo7kqqpWIQ1J3o9fbLjKO1A2ffOPqLS72RBCs1aoVI7wgqqCFYyF5v0OKCHQHna2PzNmhQShj1TIZoBgMQxf86cefQUSewJw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10509.eurprd04.prod.outlook.com (2603:10a6:800:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 09:43:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 09:43:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 2/2] net: phy: c45-tja11xx: add support for
 outputing RMII reference clock
Thread-Topic: [PATCH v2 net-next 2/2] net: phy: c45-tja11xx: add support for
 outputing RMII reference clock
Thread-Index: AQHbGVMASQ54m6Ejx0iPYlWB6m6NiLJ8hjiAgAAP8pA=
Date: Tue, 8 Oct 2024 09:43:04 +0000
Message-ID:
 <PAXPR04MB8510E844BB7640F4A06C9AC3887E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241008070708.1985805-1-wei.fang@nxp.com>
 <20241008070708.1985805-3-wei.fang@nxp.com>
 <ZwTt0R_n40ohJqH1@shell.armlinux.org.uk>
In-Reply-To: <ZwTt0R_n40ohJqH1@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10509:EE_
x-ms-office365-filtering-correlation-id: 5524b3c3-3168-47d8-c767-08dce77d9b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?YndFNWgyRjFxdHgySzdCNklEMTNsZ2ZKcUhrKzQ5RytpRFduVGVwOUIxeTJo?=
 =?gb2312?B?S3RzMitob2IzZTF2a09XRldjSUVJNGxUMzFheE9vMnp4Z3Y1Q2x3ckhMN2x5?=
 =?gb2312?B?QTVVa2lSMWI2YWVMK2xtTm51U0lnY3FNejlkMFNpSFlxTWxQaUVTRUlNQ2lY?=
 =?gb2312?B?ZVBndUxpeHVzYTgzSFBzajhsNWlvdzJtWkcyWnEySXU5OVFjTllBaFNYaWIr?=
 =?gb2312?B?RlAyZmZvNC9DeEc5VWRISXFpZ21WVUZRRGd0bVBnSG14WFhUbkZkTVRDaUZt?=
 =?gb2312?B?QUhOUXgxcXNvWmxVUmlVb1FkNUxHbDl1UnBRb00zNmR3Z3ArVi9VZEJ0U2dj?=
 =?gb2312?B?UUpVVHlhSDZScUx0UzBjVjBnem1JS1F5OXJwQ1BHQVpMZFRFcys5blVPTkFX?=
 =?gb2312?B?TGJvOXpTZzA5ZVQvUURzNjcwbVhTUDU2MW04RGQrVGYyY2s0bCs0K3JuZ3Jt?=
 =?gb2312?B?Tjk4aDdvUXBzUGpiNmRZM1ZJTVFmWEpGcU5wTDJJbFVNQ0JuN2lMdVp1empS?=
 =?gb2312?B?dU9xUzl3SWVTZDBka0M4ODNmQTFIZDdTSVI1bEVoUmplOGNoSHJVQm9MNGIy?=
 =?gb2312?B?cVo0cUpVM1NyVm8zZmxPVFBiOGRnQ015M1BFdy9RZm1aZHdJZVpmWG1vc2Fw?=
 =?gb2312?B?TzlIYmduLzVQSTBYN05WeUg2S2dLTWNheVp5bGprdjRmQXp3b25ZUEVzb0VN?=
 =?gb2312?B?Yi9LUkorREZDMXJPNFBSV2Y5d0FWMnB0NUJoejQ3ZE8vUXhzcytkaEovMTJ1?=
 =?gb2312?B?NFZzbmdrSmg5Mk5SNUFZT1pmYitOR1FlZW1WU1pmS1VCQWk0bjlGT0gxbUtE?=
 =?gb2312?B?UkxjeDhXQURIME05eVpTcHV4Z2lUdzV5Yi9IM1BRU1VoOURDL1dPdnpxN3lB?=
 =?gb2312?B?bjd4S1FUN2xQMk4rMGtNL3dsSm02MkJ1MFFkRWlXS25wRmYwRk80aXJWKzZv?=
 =?gb2312?B?WXcxOWFIYkJwZHI2Nk04YkErSFc3ZjBwOGVvM3ZzYnB3blhlQ01Ld3RnOVFv?=
 =?gb2312?B?VUJmbUFjWUg3RTdwQmF4TUFEeks3SGlBbWZnempvZkhFWXV0ckN2YTUrbmFk?=
 =?gb2312?B?dmRVZ2RYTStORzdkZ3BzdG01S1g1YXNnNlNCREd6ckxlOE1wWlZ3WGJsMmdS?=
 =?gb2312?B?ZUkvNGdGdmV4UXJkUityRVpsY3BzamlHWUI5UFpCcjB2STk5emhXMjc4SVA0?=
 =?gb2312?B?WFRIRzBJTm9FOW90NkUvcHI4NnFFRkdvYWdxMzQwNnQ4YkNFd3NNd3NXdFZD?=
 =?gb2312?B?c2hteWIyMEgwbGh2bmJTMzVvQzJCT3RpeFFvOUtIL0FmQmlCQjFvdklLcEJp?=
 =?gb2312?B?bWlJeW5CT1RQc2xHOEJyODFhK3B1UXluYjdVbGVWSTlWbjNBUSs2UndlS1Uz?=
 =?gb2312?B?M1A2TjdaK0FFUUI2d0hyTHhSVnZZTDg0Uk1nc3BaUnBKMDdIb1dHM1d6WmRV?=
 =?gb2312?B?dUJaZ3pmS3dKaVRWcGpOMDhSeUpYSzU4SnRuR1JqdWFqaWwvam1rbCs5bDdV?=
 =?gb2312?B?eGRxMTNFYUNZNmJjWUpjWUd5OGNRaHcxRWZRZ3A3Zk04enJXbEk0VHJ0ZnZo?=
 =?gb2312?B?cWFTdkJKK2tGNklQZG4yYWFybzM4REQwNUJXL2hGU2dPMEYxNUZET282SUJM?=
 =?gb2312?B?M2p6bnlYUGY2L1g2OUE3bElyQisrK2hMaG1tcHhyVEMvRFRLR3NVTFdCRFE4?=
 =?gb2312?B?eDBWZDVBQk96L2FNR2xmdWRhODRRU1VMMkRsYVJSb0ZkWWIzcVlGdExmOWhX?=
 =?gb2312?B?b0NyNDVraHFFU2Z1am5aQVlLQ3E2T0sxQUJNSFE4dExqTzlVejdjK0Y3MEl4?=
 =?gb2312?B?d0FxY3BwSEI0TGg0bXFpQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cmRyWVV0czBBOUE2SjhTVHVFUit6MlJmNG9pYjA5cmJrMEV0QjVmblIvdXhO?=
 =?gb2312?B?UjlHdHYrbFdaM1B1czBQbjFzU1o0dWlndCtpTnlWUkRxTE1TUU53dGxWK2RG?=
 =?gb2312?B?b2ZGZVZLaTc5S0daeXUyZTRHSHlnNG5ZTFBOajljS2duZEVWUk16NHo3bmJJ?=
 =?gb2312?B?OTF2RzFNM2pNc3lZdHVrOXpXQzhoeHhWUWtaQk9IdUJQanpuYXJlQ1RKbDcx?=
 =?gb2312?B?TE1WUE5RYU02TUo0bm9PSWxGMnlSRmt3WDhFMjF5d3hSZGhoSFUzVXlHaTdL?=
 =?gb2312?B?dmNNdzAxNUQzbnhydWNoditJbUNpWVBvNG83NFBTbUJvOHVmNGgyOTlYbVZi?=
 =?gb2312?B?REs0MFd2dU9Qa0RVZlgwalVJVmRrSVRKbUx1QnR5ZGxucjZQOG9xcVJIbndG?=
 =?gb2312?B?dTJnYkNtMmpaaFFRWUIrU09lVCtYNVlKcVp6QysrR21nK3pDbk85L3A3Uk9F?=
 =?gb2312?B?cW1BWXZjbC9TTHQ3S25KbVFmcjBjRXNmMCt1eFJPbUZoZDZqdUxtY29USlRU?=
 =?gb2312?B?VmErM05oYU1IMUFzMVFSbjJydW5LY0tGYm1WQ3NyS1ljS2hZMUxNMjFGMkVL?=
 =?gb2312?B?ZGVKSGVHT28rcEcwcWJiczBJV1pUb3lHRng3VDBVZHcyakRTdDRBVjlXMXU0?=
 =?gb2312?B?MS84ekJvMkpLSjhqL1pDMjR6aGZPN1M5My8vSkZxclRpTU10OEZuWTVnVVhR?=
 =?gb2312?B?aGhla2FjbWJyakEyMTZaMkZQaWZxOFBCSm5QMUo4U1BvSitsYTNmVmtzS0Q0?=
 =?gb2312?B?b280VGpFTFhjQ1pobGNMUG00SW5nUGN5dTVwQi8wdDVCRzRKakRGK3dUcWZD?=
 =?gb2312?B?R3RyNGtMcFhYL2xNWmpVSUxqTitlV2FmaWlvVGNkWUF0OEhjbU91Kzcrd0M5?=
 =?gb2312?B?M3dpd1gxQnBkTzVpenBPWVZ2bXFpWWt1dkhhNkljWmxMWUIzdWxzdVFMbmI4?=
 =?gb2312?B?OURxQXJJVU5XTTlSOEJTNEhKWnVuNjZ4dWZDaDJpR0pqdzNUOXlFSzlXa0tF?=
 =?gb2312?B?UVU0NVhKbFpwTlRBUkFSWUE1bUQvZ0NNdWluNEdQa1o0dFV4QlVNYWh6OVlp?=
 =?gb2312?B?ZjZTd3BJM0FFUUt0VExud3VlS3RNcEdJMzRpUW5DUzNxMjQzVHltdjlKdFJa?=
 =?gb2312?B?N25ic0pPa01aVSs5Nkl4emRVTVFDcjdpM3hEK3VlSDBUVWNLTFBOcTBtUVQ5?=
 =?gb2312?B?V0VZWi9KazFoTkxyMEt4R3ZHRnhpa0VCVmttcUhzNTgvbTc2UFpKcVRJZy9S?=
 =?gb2312?B?d2I5UlFJaUVuYUZXVlZYaC9ZejRFbnkzSmNEekVsV0tjaHE0OUxOaXA0anpJ?=
 =?gb2312?B?M0Z2dGpucS9RVlhhOUJJUnNuaUpMMEUwVDB5Ti91cE9xWmxWcXR2M1phVTNx?=
 =?gb2312?B?eE1LNEZTYnZ1c2RoZXNtRUxlSmZ1UWtUNXNEUkJjVzhDeDBiNGRWVmJKVHVa?=
 =?gb2312?B?bVlucXFEYStkckZRVlVCMGVJZjRKK1B0V2lRS1Z4U203cjc5cVpTKzBJMjFl?=
 =?gb2312?B?NFZPZGM3S3pnR0RoNlBXcllKeFp2K3JVZ0kreSthekJmQ2ZGeWV2aTJBRGsx?=
 =?gb2312?B?cGE1aHNKb0N1UGpWT3BQSWx2ckhoMjA0bytUYktQbTJxeXdKdHJJRzZPZk42?=
 =?gb2312?B?UXM5cDR0U1hEcGZUSklWaGwxekRBTTVzUzNkaVRpeUFIY1FDU3U1cnJ5dHNW?=
 =?gb2312?B?VUx3bGg4eUdZQjFGUVA0SVN6Tis4Yk95Z3piUk9CNURid2E0Q2I3dXoyZHZM?=
 =?gb2312?B?SHIzNHVvQ2xDWWR4Y09mRG5EZkR2NnZpcEM3NmYvSk45TVlkWVBqWWY0cW03?=
 =?gb2312?B?bDBBbktLbGRsdDRBZVpYQTFOMXljNkhMSlFGc1laMHJkSHNrUHFuaXZzMU92?=
 =?gb2312?B?R1IxaEFnNUkvZUg2UktlVUVaVE53dHBzQWdhYlRjcWs2WGxhTFhWc0d5b2c2?=
 =?gb2312?B?MWt1c0U5NmwxNEhybG5nMUtVNlRBNmFuV3lKejZrSk5OOGdRUU4wSVJxcXFL?=
 =?gb2312?B?UkhVckYxM1N0cGg0a2h6VmlhWjdZSkMrMWQzSDBpYjJFaVZpeTVVdEtaVDJI?=
 =?gb2312?B?YWo0SjdjTlR1UVlrakZ5cE9Xa09wUGxsZER1cWpkRFJSVTc5WDZXeVF1VVln?=
 =?gb2312?Q?2Gq0=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5524b3c3-3168-47d8-c767-08dce77d9b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 09:43:04.4647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLmXByPNb05+oFaaZiZUsXvE6tWnHohbp7DryN3XAJ8bTrX/UDyNKRHcqv1bHK/5CzACCPnQwQJgkKPjoniINA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10509

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNzZWxsIEtpbmcgPGxpbnV4
QGFybWxpbnV4Lm9yZy51az4NCj4gU2VudDogMjAyNMTqMTDUwjjI1SAxNjozMQ0KPiBUbzogV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVt
YXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBy
b2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9y
ZzsgYW5kcmV3QGx1bm4uY2g7IGYuZmFpbmVsbGlAZ21haWwuY29tOw0KPiBoa2FsbHdlaXQxQGdt
YWlsLmNvbTsgQW5kcmVpIEJvdGlsYSAoT1NTKSA8YW5kcmVpLmJvdGlsYUBvc3MubnhwLmNvbT47
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHQgMi8yXSBuZXQ6IHBoeTogYzQ1LXRqYTExeHg6
IGFkZCBzdXBwb3J0IGZvcg0KPiBvdXRwdXRpbmcgUk1JSSByZWZlcmVuY2UgY2xvY2sNCj4gDQo+
IE9uIFR1ZSwgT2N0IDA4LCAyMDI0IGF0IDAzOjA3OjA4UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3Rl
Og0KPiA+IEBAIC0xNTYxLDggKzE1NjUsMTMgQEAgc3RhdGljIGludCBueHBfYzQ1X3NldF9waHlf
bW9kZShzdHJ1Y3QNCj4gcGh5X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICAJCQlwaHlkZXZfZXJyKHBo
eWRldiwgInJtaWkgbW9kZSBub3Qgc3VwcG9ydGVkXG4iKTsNCj4gPiAgCQkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gIAkJfQ0KPiA+IC0JCXBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5E
MSwNCj4gVkVORDFfTUlJX0JBU0lDX0NPTkZJRywNCj4gPiAtCQkJICAgICAgTUlJX0JBU0lDX0NP
TkZJR19STUlJKTsNCj4gPiArDQo+ID4gKwkJaWYgKHByaXYtPmZsYWdzICYgVEpBMTFYWF9SRVZF
UlNFX01PREUpDQo+ID4gKwkJCXBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwN
Cj4gVkVORDFfTUlJX0JBU0lDX0NPTkZJRywNCj4gPiArCQkJCSAgICAgIE1JSV9CQVNJQ19DT05G
SUdfUk1JSSB8DQo+IE1JSV9CQVNJQ19DT05GSUdfUkVWKTsNCj4gPiArCQllbHNlDQo+ID4gKwkJ
CXBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwNCj4gVkVORDFfTUlJX0JBU0lD
X0NPTkZJRywNCj4gPiArCQkJCSAgICAgIE1JSV9CQVNJQ19DT05GSUdfUk1JSSk7DQo+IA0KPiBO
ZXRkZXYgaGFzIGFuIDgwIGNvbHVtbiBsaW1pdCwgYW5kIHRoaXMgbmVlZHMgY29tbWVudGluZyBi
ZWNhdXNlIHdlIGhhdmUNCj4gUEhZX0lOVEVSRkFDRV9NT0RFX1JFVlJNSUkgd2hpY2ggY291bGQg
YmUgY29uZnVzZWQgd2l0aCB0aGlzIChhbHRob3VnaA0KPiBJIGhhdmVuJ3QgY2hlY2tlZC4pDQo+
IA0KPiAJCXUxNiBiYXNpY19jb25maWc7DQo+IAkJLi4uDQo+IAkJYmFzaWNfY29uZmlnID0gTUlJ
X0JBU0lDX0NPTkZJR19STUlJOw0KPiANCj4gCQkvKiBUaGlzIGlzIG5vdCBQSFlfSU5URVJGQUNF
X01PREVfUkVWUk1JSSAqLw0KPiAJCWlmIChwcml2LT5mbGFncyAmIFRKQTExWFhfUkVWRVJTRV9N
T0RFKQ0KPiAJCQliYXNpY19jb25maWcgfD0gTUlJX0JBU0lDX0NPTkZJR19SRVY7DQo+IA0KPiAJ
CXBoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01NRF9WRU5EMSwNCj4gVkVORDFfTUlJX0JBU0lD
X0NPTkZJRywNCj4gCQkJICAgICAgYmFzaWNfY29uZmlnKTsNCj4gDQo+IGlzIG11Y2ggbmljZXIg
dG8gcmVhZC4NCj4gDQoNCk9rYXksIEkgd2lsbCByZWZpbmUgdGhlIHBhdGNoLCB0aGFua3MhDQo=

