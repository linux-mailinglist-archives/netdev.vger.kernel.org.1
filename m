Return-Path: <netdev+bounces-136386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B069A1939
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564AC1F2110F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D01386B4;
	Thu, 17 Oct 2024 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hDP8D5dg"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD371531D8;
	Thu, 17 Oct 2024 03:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134735; cv=fail; b=CrnjpsC2xDSIV3jMs89zI58BKGfY8SA78REz3gIMH+uCJg2RLMrkGvHxLKvFJ9xWMFOFteb2XCCOc7qQUE86BQloWqZ8pmGYtUBK1ioSWzryBtjAvzhoTBejl4vRttRzDD2lO1nNp0OtZbAkq7hVs4br49hYy98f32vNoo92eUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134735; c=relaxed/simple;
	bh=hG9M8fAaUvPPsKRSZAZT75xvDrCl1oNIFkGUfwG7xXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dQScY6sEpZXXGJHGEw03abhB85LvDgh3//RaMQzhnHxtd4pazJzbRNk3t/6j+8+9x+AhkuMW/DWQGifehFAW1SiIPBJGHkZeF0ZlSE0puwN1VNw9P1xevAIXgGxPni/Oc/xt71lwwklKOHD384uymTb6lFUNjUiNVhpM7o5ToYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hDP8D5dg; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxgc75wuZvhZqMBm5myoMStEi9HQVtqk1Z5DuQBX35u/n3XIm1y5BtkEVgozMnmfPnN7IAOjLHF7/gSd+zQ0YrEA1Jm3jmog9ro8Qk9Ir+b2GHjXD4t7nTiucG+dO+E2ga3Ayv8m9P/d9TjVpm+WG7CTCIyRHR49o3nnPgUleSJrmdVGUfqtOJPOLis0WvUKyMSu+mpy+xatNtpfxoKudYHNHeB9AD9KUhFYYZno7jnaXf0G7+a2/2UMZddiWvNgyYdSvPW7sxOll3GOVOVgRdT3zLIi4sgH3ngBhoqXgXAJn87iNvLkLxfb+z89vMP5njoWT4WqwvMtaweA+tOIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG9M8fAaUvPPsKRSZAZT75xvDrCl1oNIFkGUfwG7xXM=;
 b=A7rrSEm8aUMvcMMht/btvrMar/CULBsLtwpDUFGw5aw0gQnCWtFCynxwKhXHgC0vqW0viEy46ICfrZNqULUtwmjdfWLyFOInaKDVYDkPDYGfRUCiTKcXz+TYhPHc7Ew/KyTwCEfQ0nf3MN87Sji3DAKTWW+2ojMjZtcCHzSlu6BKIt0dRJjgbrLL1FMnADZSEmgnHBkYGHPX7A1/dbQr5i1Ij2w/p3pj80iwXYa7TsfalZ2ExyO/1Zw7mo4WdwsQpmyl7bRy6ta2+6pSmmMNkBFTs/jlzLXL1r04mNPqDLUQdHyeSc1K6M3Uw+UVeByUn/I2ZHN6BhxVsGxBJJLsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG9M8fAaUvPPsKRSZAZT75xvDrCl1oNIFkGUfwG7xXM=;
 b=hDP8D5dgHNKxFWz+qWDPZE8mmgmCYyxML8GknI0uPPjDm6njXeeVORNU2gTMyd4JfAW0hjnzE6ZMyqlr51oJLj+xxmLvQYYvc65j11w2am8zkIfO0L9nsPv1m4Se5J/medGRlVzUVaZ/UL1qbxOi86myAkPtjb30mijj+LIZPjpK6SJrDLcLfsS2kXyuithhoNV4kPB9TAj11zCF9ahea3hjq/VSOgEyqUHjrGsIqZOGT55vi5k1boZqc6mYKLc57I7GbysRtVYT6LFfnYv0LnQ1mMprYgpVjcGf6ngoXYbc5popVp7JNMigDoWtownl3rsDROgNk8SNNQrhpW0YZA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9388.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 03:12:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 03:12:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH net-next 08/13] net: fec: fec_probe(): let IRQ name
 reflect its function
Thread-Topic: [PATCH net-next 08/13] net: fec: fec_probe(): let IRQ name
 reflect its function
Thread-Index: AQHbIBW0ChD1ukwNiE6D2e7erXF2hrKKRF+w
Date: Thu, 17 Oct 2024 03:12:08 +0000
Message-ID:
 <PAXPR04MB8510AF4C75634866A296519988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-8-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-8-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS4PR04MB9388:EE_
x-ms-office365-filtering-correlation-id: 86a448ec-0b6f-44d7-1b9e-08dcee597c78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a25CQmQ3WFNSbmJUYlpMcWRydk5CSlI2Q2UySkpmMEdra09IbWh3YXdsNmFa?=
 =?utf-8?B?WUxVWkx5bHFOUlhzSkNNRnlQT3dXVzk4cWlWR2NvZ1ZLNjZYYVFZbnFiOGRi?=
 =?utf-8?B?V2pxcE9Ic1UxZVlPMHQ1VXVLajA1R0FYbmNPdHYyNUcyTElYQ2tDeHBSdFJH?=
 =?utf-8?B?L0RVSWgrN2MrNlhVSkZRVzI3K0piaFJ3RDlyaW1WVFFWdmk5M2tFdHZ0SXRl?=
 =?utf-8?B?STJVeUxvMDRhTGhvS1dMZC9KL2NxZGo1MFN1TEs4RkJIYzQ4SEFuOWpzRytG?=
 =?utf-8?B?ZFhGNy9nUnZpZVBRL0ltSDVBWG5UZXpkV3poS28wUGNZMlhQL3B3czUwU3h6?=
 =?utf-8?B?T2s4K0tqYVlDRXZWSi9vNHZOS0Q2OVZML0ZORFZFM0VNeHkwSVZHUk54Q2kw?=
 =?utf-8?B?V1JkRWdxM1d3YXpQZ0s0cEx1M29BUzZVYUIrUjJBU1czaVF6OUxubFBNLzRa?=
 =?utf-8?B?SlZCYTAxam80UlJFQkpSQkxOcVlSOXRqVDRxMzl2Q3BMckNwNzlNcGxEZUR4?=
 =?utf-8?B?eUZnWmVKeE1CY080b0ZtT09ZblBYSm5aWmZSM2dRYmxVUDJLajhiZTFIYlJr?=
 =?utf-8?B?bWd4WmFnVjRKdWNiQ0docFV6disrZG00RHNnY3ZOMm1URWc2Q2h0M3BoMDNJ?=
 =?utf-8?B?UWhEWXQ3YmsvRFllWDFZbkc2TkFyQXcvZUM3REswQTR2bk1aKzRiNDh5MG1G?=
 =?utf-8?B?YzNEWmovTXRyOFYyMU1naGdrUi9SOWhjMm9PaFpVNU5OZ1dvZzhDaGtwK0dQ?=
 =?utf-8?B?K0l0Yy9ieGVIWU1YcHczTXVSZ2JmcHNrUjVYeFhLTjcvU1FGZ2lNUVZVaFFF?=
 =?utf-8?B?d1d4SittaXdhalFKTEpuYzkxckFQdTNOTHRqdWl5b2lIeDJsWWJ0a0ZBNEZH?=
 =?utf-8?B?RlRHd1pvSTRiS0hVU09PUFlpSFlhTk9hTG1kdEhZNHFLZTlMQXBWWTFIZm5k?=
 =?utf-8?B?K2hxWUkrOVBPcS9tMmp4QlhLZzZ6L1didjNSSEtMRUFyZEVFNEFIaGVkVUFF?=
 =?utf-8?B?cmc0VnV3ZG5LTEREZE1Nb0t0K21oR3lQQ3dFYW1GR3crTkpUVlJkU1V6Zyty?=
 =?utf-8?B?OG9YVE95SDJHbndtV0MrclBTSTJSdmlBZ2cwUlRYZFVyV2pYaDEzR2FlbVBx?=
 =?utf-8?B?WlJZeTRVYTlicUUxbXI2bVBuVDhINFhhaGdoZG8ydzZabVF6OTlXbFF3M0Q3?=
 =?utf-8?B?ME55SVlUOFFwTUhqcG5GYWYzdVp6Uk9yanVSUXl6OHNnSU9nNDJZYjZqTnpG?=
 =?utf-8?B?RDA4ay92MXdDU0czWXEyYm9xU2w2THlMUkdOaG5Vbnc1ZEFPR2NYSExZNlJx?=
 =?utf-8?B?Sjd2SWk0OVhnUzd5Zmo1NUxDb3ozcllpSXFnVXpneXZEQmpQWUJNQVRBRUxz?=
 =?utf-8?B?T3d1T2s2RXlpdVc5dmE4UFpQZllvWGhGRVgzZkxveEVaVkdndVVKZlZHckZk?=
 =?utf-8?B?a255aEEzd29CeWRhWG1zNTNzdnQyd01OTEl6KzFKNFdjdE0rNVRnWGNaTXZO?=
 =?utf-8?B?cWlUM2NIcVhGMW8vRFlCUlhoUUhqRnVOa3VwRC9pZ0I0NDVYcFJtUGRsV0JD?=
 =?utf-8?B?SFp1UFRvenJiYkRiYnlHT2hMQU94QnovUFBvOXF0SVU4bi9ML1pDZmp2RUVN?=
 =?utf-8?B?RHJEZVNDdHBaSjNCZWNoc2M1ZVN6ajlvcVZjTFptRWN3ZTNQU1VqZ2Uzd3dm?=
 =?utf-8?B?WVV6Q2lhbkJzTVN2L0pSNEU5Vk1rMGNRdVhuL3lCRE9EblFNaHNNMDVyTHRa?=
 =?utf-8?B?dmYvN3I0ZnAwWE11b1BtWjQ4RkpmQzNNYlp6WjMzYkFNTFFnRzUyTkREcEEx?=
 =?utf-8?Q?Nr/hdoDfuE5sD3nvboOqPyriFEd0CYJKVnSeI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUk3NlVKNFNSVGoxZGZZcitSU1VaWStRRmlaVUZKZHN3ZWVmWWxJeVpjR3Nj?=
 =?utf-8?B?cytNUWwrK29IOEZZdFprMVMrNWVjTnlvZ2MwV3NTQklkYjBzMS9GU0V4aExQ?=
 =?utf-8?B?UzJkOERhNlY1Y05OZEg3b1FQS2V4STlCQ2xKK1ppM1ZKZWZVUTE3OVdCQm1E?=
 =?utf-8?B?K0ptc2NiTEdWalBkUzI3cjQ5WUg0ZXBSMmpZTVdRNmJ3L3lTSyt0RFAvVHdJ?=
 =?utf-8?B?M3lCaWhUZjQxUmhTc3JNWjVLRTkycTYxZlZkdkNuVnI2OVM4YlA3eXlOVHVl?=
 =?utf-8?B?dHpjRVNSSzE5aWlkVmdJaytFZ0tJUGF1WHpxWjdHY1NGWkRBN0hUL05pdldT?=
 =?utf-8?B?Mk4zemJKUGVxUStkdFFUQ3ltYUxIeGdiRDV2WkNzUnd4Z3lMVW0wVnFsSDhC?=
 =?utf-8?B?dUtkMmZSZUNxM21WU2V1L3R3ZENOcnVsUG5Qbll2QkptUWRldGUyWnRXTXhW?=
 =?utf-8?B?RjJhbDVwR092QXd5VmxJSVNLV255OEJJVjF6NHpDOWZRc3ZLWWtwbnhHT3U1?=
 =?utf-8?B?ZVNpL0ExZzI2Z1pJMjZJSEp5NTlGZldSaEpOSEJrR0lhN3pwYzFGRU9PYnhB?=
 =?utf-8?B?MmtmSG84dUZGUkNQT2dWRGZBZG5kS1dkSmdJWlFiMVFXTDVCeHE5c3FTMmwy?=
 =?utf-8?B?c0JPUzV1VVR2YUxtMHp0ZGVrMmkrV0NFalBsZk9KUytsc0oyTThZQkYzeVAw?=
 =?utf-8?B?dEZuMXpnOTdwU2pJanltdEtLY3NQTHdyeUdIZ0NCYVpxUDJIb3c4UUhXLzRO?=
 =?utf-8?B?ZG1WWHhheGw0enhBU3luMlpoY2NrcDdvYXhRUUw0U3k3Tkw1MWVtTmFGdndY?=
 =?utf-8?B?a2YrSEM3bUZCVmNQK3VjRDNNbGg0eDVXQkFKd3ZIMFJScmo1bFZzeTkrdXV4?=
 =?utf-8?B?cVJiZlJFRzAvUUs2dC9SWVFEZzM4bWJqcXl2SUNIbWdHbUI0dVNCbFBsWUVo?=
 =?utf-8?B?c2dYVDZON1VCdWw5MmZmMlJBQ3V4eFUwVVV1Rk1HK0RIY0wzOFR4WE5EYmV3?=
 =?utf-8?B?aDM2enl4SFd6WVBxZ2h5ZFV1UkxVdXVIaEN0WXdmSkVtWlVvcWNldHNraEVW?=
 =?utf-8?B?U0Q1TDk2SUdEKzZXaHRsOTVQNENtaHd0S0xBbG5zWjhsalkwN2FtTUxxTGpS?=
 =?utf-8?B?V1hScm9neDVxTDVZNmpaY25pV1owOC8vNFdNSkVxQ3BVT3VDYzJBbG00ck91?=
 =?utf-8?B?VWYwOEtkVnR1TGtveFNhZGRwcjlYV1p3YWxJVnpvMXBidGxpMk56R2lIZkRx?=
 =?utf-8?B?TDlBdnZNYjA1c3VHbnRQcWhQVDN1WUJqMVRuZVp6dVZWa1hTd0YzTXNqdVU1?=
 =?utf-8?B?dEhIL2Q1eEhXV25idVoyN242amxLOU9HYlhvL3JzZ1BFNnFCcXREa2xGMzYw?=
 =?utf-8?B?dmlkTlJGdW9abDlnaTBzalV1VmpkTGE3WllmNzk1cmRuK0JvMDZSUW5vWDJx?=
 =?utf-8?B?Q3ZCd1hodjdwcDVuMm5OYXpIc0hLQnNLU1lTYmQ2bksxK3NWSlFXVTZWQjJ0?=
 =?utf-8?B?WVhJWDFSa1VWZEdSdWNpcmZRYWEvcEFudlp2QURsKzhnNmtLbkJjd2JTTnQz?=
 =?utf-8?B?R1JMMFlLeVplWlRmN013Q3JPRUNnajFraUJPYVV0aHdvNmhzbnFZNGl4ZllE?=
 =?utf-8?B?Sk1WWGFETzExbDJkeGFBbWFXWE5SSHUwcGFXQndPWVlNL0hOTnZ6WXBRL1kw?=
 =?utf-8?B?VG85cVN6dW5aMDQwemNrelVHQkdyaGZLdVVDVlJoNE5naFVoVnBxWTIvam4r?=
 =?utf-8?B?S0ZlWUd6ZmlwenJzSTBPdVp2Y0c2UmlkQWV3Q2RCTDJneHkrTjYzM2ZZa1VX?=
 =?utf-8?B?TFJXdDZlZys2ajMxcWZMTEovbEhwekhwSEtGbVpENzRGNkI0WHpSV3pML3hk?=
 =?utf-8?B?MEgxMEtyQ2JVZTZpUGVSWUR1WkxudWZvbG9XdnpUZk4wM2x1M3kvMUFLUWdG?=
 =?utf-8?B?SjZaWTBrT2Y3V0NRUzJDTWR3cTArc1JrZ0tCczFHSENpRFdtQ1d2MGowaXpK?=
 =?utf-8?B?Q1hXRHVVd0RWSmYwMk1aOTB1TU9NSWtMdkdWeDR5cGxIYm1OR3RmeG9iTWR0?=
 =?utf-8?B?TVpjenRlSDZwaW9uVGZ4cmxTR2gxdWlUaXlmcjhwaVRwMWxHbnBNL2dwVitO?=
 =?utf-8?Q?aWM4=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a448ec-0b6f-44d7-1b9e-08dcee597c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:12:08.7434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3JYtSmBCStl9C9CyTL5EK6NJT7soPUWpuVULHmUVvd/DfAEEh0f9HIoO1qtpgFuVTUsII6EdRWRrVaaH5Owkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9388

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSA1OjUyDQo+IFRv
OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT47IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5n
QG54cC5jb20+Ow0KPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBT
LiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAwOC8xM10gbmV0OiBmZWM6IGZlY19wcm9iZSgpOiBsZXQgSVJR
IG5hbWUgcmVmbGVjdCBpdHMNCj4gZnVuY3Rpb24NCj4gDQo+IFRoZSBGRUMgSVAgY29yZSBpbiB0
aGUgaS5NWDcgYW5kIG5ld2VyIFNvQ3MgaGFzIDQgSVJRcy4gVGhlIGZpcnN0IDMNCj4gY29ycmVz
cG9uZCB0byB0aGUgMyBSWC9UWCBxdWV1ZXMsIHRoZSA0dGggaXMgZm9yIHByb2Nlc3NpbmcgUHVs
c2VzIFBlcg0KPiBTZWNvbmQuIEluIGFkZGl0aW9uLCB0aGUgMXN0IElSUSBoYW5kbGVzIHRoZSBy
ZW1haW5pbmcgSVJRIHNvdXJjZXMgb2YNCj4gdGhlIElQIGNvcmUuIFRoZXkgYXJlIGFsbCBkaXNw
bGF5ZWQgd2l0aCB0aGUgc2FtZSBuYW1lIGluDQo+IC9wcm9jL2ludGVycnVwdHM6DQo+IA0KPiB8
IDIwODogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgR0lD
djMgMTUwDQo+IExldmVsICAgICAzMGJlMDAwMC5ldGhlcm5ldA0KPiB8IDIwOTogICAgICAgICAg
MCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgR0lDdjMgMTUxDQo+IExldmVs
ICAgICAzMGJlMDAwMC5ldGhlcm5ldA0KPiB8IDIxMDogICAgICAgMzg5OCAgICAgICAgICAwICAg
ICAgICAgIDAgICAgICAgICAgMCAgICAgR0lDdjMgMTUyDQo+IExldmVsICAgICAzMGJlMDAwMC5l
dGhlcm5ldA0KPiB8IDIxMTogICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAg
ICAgMCAgICAgR0lDdjMgMTUzDQo+IExldmVsICAgICAzMGJlMDAwMC5ldGhlcm5ldA0KPiANCj4g
Rm9yIGVhc2llciBkZWJ1Z2dpbmcgbWFrZSB0aGUgbmFtZSBvZiB0aGUgSVJRIHJlZmxlY3QgaXRz
IGZ1bmN0aW9uLg0KPiBVc2UgdGhlIHBvc3RmaXggIi1SeFR4IiBhbmQgdGhlIHF1ZXVlIG51bWJl
ciBmb3IgdGhlIGZpcnN0IDMgSVJRcywgYWRkDQo+ICIrbWlzYyIgZm9yIHRoZSAxc3QgSVJRLiBU
aGUgcG9zdGZpeCAiLVBQUyIgc3BlY2lmaWVzIHRoZSBQUFMgSVJRLg0KPiANCj4gV2l0aCB0aGlz
IGNoYW5nZSAvcHJvYy9pbnRlcnJ1cHRzIGxvb2tzIGxpa2UgdGhpczoNCj4gDQo+IHwgMjA4OiAg
ICAgICAgICAyICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICBHSUN2MyAxNTAN
Cj4gTGV2ZWwgICAgIDMwYmUwMDAwLmV0aGVybmV0LVJ4VHgxDQo+IHwgMjA5OiAgICAgICAgICAw
ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICBHSUN2MyAxNTENCj4gTGV2ZWwg
ICAgIDMwYmUwMDAwLmV0aGVybmV0LVJ4VHgyDQo+IHwgMjEwOiAgICAgICAzNTI2ICAgICAgICAg
IDAgICAgICAgICAgMCAgICAgICAgICAwICAgICBHSUN2MyAxNTINCj4gTGV2ZWwgICAgIDMwYmUw
MDAwLmV0aGVybmV0LVJ4VHgwK21pc2MNCj4gfCAyMTE6ICAgICAgICAgIDAgICAgICAgICAgMCAg
ICAgICAgICAwICAgICAgICAgIDAgICAgIEdJQ3YzIDE1Mw0KPiBMZXZlbCAgICAgMzBiZTAwMDAu
ZXRoZXJuZXQtUFBTDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWts
QHBlbmd1dHJvbml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfbWFpbi5jIHwgOSArKysrKysrKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9mZWNfcHRwLmMgIHwgNSArKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJl
ZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXgNCj4gZjEyNGZmZTM2MTlkODJkYzA4OWY4NDk0ZDMz
ZDIzOThlNmY2MzFmYi4uYzhiMjE3MDczNWU1OTljZDEwNDkyMTYNCj4gOWFiMzJkMGUyMGIyODMx
MWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFp
bi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+
IEBAIC00NDkyLDggKzQ0OTIsMTUgQEAgZmVjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAJCWdvdG8gZmFpbGVkX2luaXQ7DQo+IA0KPiAgCWZvciAoaSA9IDA7IGkgPCBp
cnFfY250OyBpKyspIHsNCj4gKwkJY29uc3QgY2hhciAqZGV2X25hbWUgPSBkZXZtX2thc3ByaW50
ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLA0KPiAiJXMtUnhUeCVkJXMiLA0KPiArCQkJCQkJICAg
ICAgcGRldi0+bmFtZSwgaSwgaSA9PSAwID8gIittaXNjIiA6ICIiKTsNCj4gIAkJaW50IGlycV9u
dW07DQo+IA0KPiArCQlpZiAoIWRldl9uYW1lKSB7DQo+ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiAr
CQkJZ290byBmYWlsZWRfaXJxOw0KPiArCQl9DQo+ICsNCj4gIAkJaWYgKGZlcC0+cXVpcmtzICYg
RkVDX1FVSVJLX0RUX0lSUTJfSVNfTUFJTl9JUlEpDQo+ICAJCQlpcnFfbnVtID0gKGkgKyBpcnFf
Y250IC0gMSkgJSBpcnFfY250Ow0KPiAgCQllbHNlDQo+IEBAIC00NTA4LDcgKzQ1MTUsNyBAQCBm
ZWNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCWdvdG8gZmFpbGVk
X2lycTsNCj4gIAkJfQ0KPiAgCQlyZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIGly
cSwgZmVjX2VuZXRfaW50ZXJydXB0LA0KPiAtCQkJCSAgICAgICAwLCBwZGV2LT5uYW1lLCBuZGV2
KTsNCj4gKwkJCQkgICAgICAgMCwgZGV2X25hbWUsIG5kZXYpOw0KPiAgCQlpZiAocmV0KQ0KPiAg
CQkJZ290byBmYWlsZWRfaXJxOw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2Nh
bGUvZmVjX3B0cC5jDQo+IGluZGV4DQo+IDg3MjJmNjIzZDllNDdlMzg1NDM5ZjFjZWU4YzY3N2Uy
Yjk1YjIzNmQuLjBhYzg5ZmVkMzY2YTgzYmNiZmM5MDBlDQo+IGE0NDA5ZjRlOThjNGUxNGRhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4gQEAgLTc0
OSw4ICs3NDksMTEgQEAgdm9pZCBmZWNfcHRwX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldiwgaW50DQo+IGlycV9pZHgpDQo+ICAJICogb25seSB0aGUgUFRQX0NMT0NLX1BQUyBjbG9j
ayBldmVudHMgc2hvdWxkIHN0b3ANCj4gIAkgKi8NCj4gIAlpZiAoaXJxID49IDApIHsNCj4gKwkJ
Y29uc3QgY2hhciAqZGV2X25hbWUgPSBkZXZtX2thc3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VS
TkVMLA0KPiArCQkJCQkJICAgICAgIiVzLVBQUyIsIHBkZXYtPm5hbWUpOw0KPiArDQo+ICAJCXJl
dCA9IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldiwgaXJxLCBmZWNfcHBzX2ludGVycnVwdCwN
Cj4gLQkJCQkgICAgICAgMCwgcGRldi0+bmFtZSwgbmRldik7DQo+ICsJCQkJICAgICAgIDAsIGRl
dl9uYW1lID8gZGV2X25hbWUgOiBwZGV2LT5uYW1lLCBuZGV2KTsNCj4gIAkJaWYgKHJldCA8IDAp
DQo+ICAJCQlkZXZfd2FybigmcGRldi0+ZGV2LCAicmVxdWVzdCBmb3IgcHBzIGlycSBmYWlsZWQo
JWQpXG4iLA0KPiAgCQkJCSByZXQpOw0KPiANCj4gLS0NCj4gMi40NS4yDQo+IA0KDQpHcmVhdCwg
dGhhbmtzIQ0KDQpSZXZpZXdlZC1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQoNCg==

