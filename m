Return-Path: <netdev+bounces-129648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1E98520D
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 06:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1726C28563A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 04:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA314B09E;
	Wed, 25 Sep 2024 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eUYyNzDF"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1B14830A;
	Wed, 25 Sep 2024 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727239055; cv=fail; b=P2GO1PS3JL1aMT4FElN4pKgmXeW/k2CkZVAONmq7tPjC16X9Sk5/81Heptvk/IHirsBVw4h97fwWOyUC4oGsMkJqkFT+Zne+36MldwDwt7QcDewG1CA9i2NCQBTs50cvMBsVP1CD9kNR0p3Dk0nrA9SQYCmXO9k+gkBjyMeecYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727239055; c=relaxed/simple;
	bh=V5lkcARFJInq4PrtP1z37IwlFULtsWnGfU2af0lW2/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aumwuORx5f/HL1TquSCFY69cPE2FqDp3nNkmhMH11cKK+hEpIG7s9DEXXX4G2HuT3tin/Ecn6FZtHvD4S1TeO9cFA9S5SPiz55iBFLKTnBzO0HULrq09KCmGLVjqfBuaufzTxbLbNzRgjq7e/shrmQ1Ha7DeeSfk4WKjpfqSk1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eUYyNzDF; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sc53d5RWUmuLyQoRKWPA1SH8XYWvkm0Ro/5KTTA7e/vvLg/58EVkZOWOqsuCgueUKKpbBg4qEe76LdBV6qheX/N4gDeiE32a85Rnx0DhFQZvUf0lH0hew5eghQN2E3RK4SfaTbgFS+JAtPGW1VcDiG+kHXAptQJbXG0Hli2kj0teKcFP7RB5txB2PJTlaRB+NKu1iTsHxgO+CsODHKqXF0vZ2UwYkqjyf9HGRDdvxl4j2JEO4wuiTFwDaNIdp6FrmQyba9SIGfIe6Mqljl/U7QPI6pu0B8zHCWysN7Y+hshAEUQJ0WbVqRnCDat2GR2BN8//McPXZ4xqnOmYBQhIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5lkcARFJInq4PrtP1z37IwlFULtsWnGfU2af0lW2/M=;
 b=QCmaEzAOVTMBjkIIaLkvOHnKtuv7PZmidbpM6bjs/bMZ2lYleOBLBs+akhz7NsOdYcPZaz2VnXRYZlvmZGdZSv0b35zNCUE7mhMx5NxTpId09IEHJiVkMLVpBkqEq9eCXOYEismEoNGpQZOv0NtlC1f6XRXEvCNt6iEGi2f51aNySiqVQGnaM9dh/WqM+m4b10vebfvzPIAbFt/bm1NWJqG9L0iuOjnEUbur+3TZ2BeCRMP2uVMsREPsXRlT/+53ztfRuV58Z/12+hgm8NOExpiw9zfnssYQVv2c7dLrrhBWSHdrfItB/rEroY5wnBqUjaX4Pyz6+CwwVL74sc5ejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5lkcARFJInq4PrtP1z37IwlFULtsWnGfU2af0lW2/M=;
 b=eUYyNzDF10O7/SebrbcBCBPm4LiR5bJDHi84BAhbAgljOOZEKWQQRIi8FlPA+3etmk1+FqInPP0pymcQDOFx1tYlvd2SWOnSqZwaV/YdSpfLAMplxtHVJOTHif+axV+h3yaxF1zoX/nvXNThSnqz5v2CWVCvTLCo3bEn0O9QgGh2muP9o0uVKHoynflQ4fKEqp2EvSqx/8XU7Dc8h0YVrDTvozduXt4Qe2yJ76Ai/OJD3mAEmH5P/Wk+tchbARqDiaLgcL4SC89UksIddPtLyV+1urE4drNDrGv5W152A5Pg+h0Vcdfh9QlgQXNFnom59VWQSF2Kh6SZ5UJAv0kDxw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 04:37:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 04:37:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: =?utf-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>, Frank Li
	<frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/2] net: fec: Restart PPS after link state change
Thread-Topic: [PATCH net 1/2] net: fec: Restart PPS after link state change
Thread-Index: AQHbDmVktfgCZ0wiIk+sf3frfIu5BrJn2JWA
Date: Wed, 25 Sep 2024 04:37:25 +0000
Message-ID:
 <PAXPR04MB8510B574A53DAD7E1256A9E688692@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240924093705.2897329-1-csokas.bence@prolan.hu>
In-Reply-To: <20240924093705.2897329-1-csokas.bence@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB6999:EE_
x-ms-office365-filtering-correlation-id: 93710c8d-a6ae-4624-2c36-08dcdd1bc158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlkxK0FHYW96NUtJZkZrSC9hdFBMenJlMWZJMXVGa1JKNFNuSTdsYjRhQ1Fa?=
 =?utf-8?B?bjdQdk96MjE1aUFkMHE1RnFPaVNMOUVGRURJODhZOGppRmM5SEgvUFQ4cHRa?=
 =?utf-8?B?c05VS1IvcW00YWRjZmtnUVRRQ3RwOVZjZWRYMk5ydFN6MFFLVzlWV20wbXY5?=
 =?utf-8?B?anM5U3VQZm53TzBnQUo0NFFQbmw4ZEpkc2IzMDduZXgzbis4L0hJZjg0cU5F?=
 =?utf-8?B?R3AwZzdRRXBGZVloVkNGQ1l2aVVWb0RuY2huUnhudXREa1YyTlVzdGJUNSs2?=
 =?utf-8?B?dDdNQStOYzFSa1BuRnZkcHd3VU1IaW1YeWplM2dhMVR1MXRmM0VVSmd4U3Ja?=
 =?utf-8?B?TnZLeVRQcUZ4aXRQSXN3cTF5Wnc3T0tMMURXR09yME9uUlgrRTZ2aWd2b3p1?=
 =?utf-8?B?UzBKUlE4NVNiQzRhaWRWc2I5a0tkeGdOdWlJSXdvNGZ6U0VoQzQ2dEpabjQz?=
 =?utf-8?B?SEhQMEliSnRnNjYvVVlSaUpPbUhwVEI4ajVBNkMrc1Rza051ajEzRmpFb0xE?=
 =?utf-8?B?RDdTcnpDVUtUeUI4ZlA2dkl1dVNQbkh4M3JZTGN5alJ4RXN2Mk5nN3c5QVpY?=
 =?utf-8?B?NW5na1NEL04xUUVJdExGWStJamtkeE9lWlJwR2VyRHQ4RXRDWWxVSFJLdU11?=
 =?utf-8?B?WE9rdjFFTXRRd1pyRU5WL1hidkZwY1lMNmlkanFPYktGVGRqUDlqdGVPSUs4?=
 =?utf-8?B?eHVrdHY0SU4yZnpyQlFSNnYwdk1uc1JvSmZuZVl1aVhPUFVoY0M1U29mejZ0?=
 =?utf-8?B?QzMrNnlFQmtKK0hhblh3bk1sSGxXa00wMUYxTFRveDk2N3A3b0UwMXdQUnhQ?=
 =?utf-8?B?ZkplcHJHRDRsWWJBMHVwZmo5eThCQlFuY2tvdjhwL0Z6ZHhnY012bkhTZW12?=
 =?utf-8?B?M3V4VGdhTmw0SkUwUWZPTDJXeWVKRXJQRVgrU3BJWkkraUtYcnpFcnVLVFhy?=
 =?utf-8?B?R3IzdEtqV0wrcW1UYnZPd3NjeTRLNktjT1Vkd0N2V3N5Z3pIUHZtVXFQMHJL?=
 =?utf-8?B?bGcxMjYrRWZwajZueHhvWmtINXhUazU4cW9UTHJvbitvQjRxVGZvZGZHL0xq?=
 =?utf-8?B?TEkvRUhxWW9jT3BsUmVwQ2UwUkJzY3h2K0N6bXVtMnUzaGQxSmVmM1RsSk0w?=
 =?utf-8?B?VU9BcFl0RVljVzhBajl1a2hhS21LQmZGa2E2Yko0cHFvZnpERTNIKzVrUEJj?=
 =?utf-8?B?L1RaOGlXSFZ6d3IyclRQRjhRd2MwTjlKQ1Ryb1lNQXMvU1JOSkN3MFNHSm9m?=
 =?utf-8?B?VVp1V3p4em8wRWlVOVdBTDdmZUd1ektQNHRSVU9ZNWNVdlNnTVk2VTVibVBz?=
 =?utf-8?B?dHhyK01vY256TUtNdW93Tm84UmVYd1NJbENtM1prREEzQnozSjFJMDd5S1BY?=
 =?utf-8?B?OWd4UlMxNTdFREFzUHNVeXhQREhBc1JkSWJ2S1RLR1QvVUxFWk93M2V5VnRv?=
 =?utf-8?B?cFp0UFEwai8xRVhmRkJZaFhZVklJOUl0UHQzcjVGcWJCbEhlS1dYK09hR3Ji?=
 =?utf-8?B?M1BYdG5KMGsvK1MzZnV1OWlMdUVJREZhMDJHVE8xZ1BwVFNyM0VVcEJBQkZ5?=
 =?utf-8?B?T1FhZzI4V0ZMNkp2aXVkcklLdVVJSm5rdjBnbW1YSkV4cVRTSWNBaUZ3U3NR?=
 =?utf-8?B?Qjh5cVU1bFZNaDIxYzJDSWdaT2wxNmdjZEtJbDJtSm5kZU9qU3NpNktFTGwy?=
 =?utf-8?B?SWVZMUZ2OWpRL0RXUkZ3TTQ5VXl0WkZCQmJsT0JGSVNyblcyaEJzL3FIRzYy?=
 =?utf-8?B?UkxxZ1NLdGlpWlh4WkVCamw4RFRwOVFrU0xTd1VlQjloWGp6cmNaQWpBaFRG?=
 =?utf-8?B?aUdweXVtU093Tk5pd0Vxdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHpjemhZNFlma1Fhdm1yS0dBcE4rNUNKWDltb1JsNVVsaHlzMFYzdS9pSDFy?=
 =?utf-8?B?Q0hoYTJmOGNKcENWQ1IyTUlrSlFUaTVlaWtaemRHMXRzZm4xQXgwd1N1TXFn?=
 =?utf-8?B?MnlJd1pjcGF0djF2dWhFZ24rUTNlaXc2QlV6K1RZUXgxNmszS0V2eVNoQit1?=
 =?utf-8?B?NmFkYWRwQmhSZWtjQy82UEg2dHpxODI3VkJ6RlJ4TzVycXlqaFQ4N2NlTzE2?=
 =?utf-8?B?eGtDcWhyRWJhUWo5TEFQeUlzS3lQTDMwVGR2R3htOHB4ZTNFQUppWkV3VlNq?=
 =?utf-8?B?ZnVRc29NNkhpR1ZWV1J1bEord3EvdndDeGViSGNYdFhkNkpOaUdGRSsrQ3ZN?=
 =?utf-8?B?QWo2RWRZZTgwQktGZkVvWDNqV1lmeDQ3bmhtZDhpV3RGVEQwcUdhV1cyb0dm?=
 =?utf-8?B?S1cyRmtBVzMxdjNCemY2REVXWmo4amVRY0M3eCtnaE5CYm9mZTlDenBJTnFW?=
 =?utf-8?B?Mi8zVmpZbXhxU1hQWWhFODlqRzEwOWp5L1d3U1kwVnlsdTJUUTZGaTMvSlhJ?=
 =?utf-8?B?QVN4Yk9yU1hOWGRLeWRYV2FOL3pwZGlRWUduQWNCcmFyUTBmTndLQ1RrWWZW?=
 =?utf-8?B?L0FkMW43bHJXUEdBMWF2QkJydDltZzRCeUhydUg5UWtZS1owdVBhMHA0U0wr?=
 =?utf-8?B?UUpaRGEwTkl3NDBhczF1RmFNNFNOU3ptNkFpYTJidU56Tkt4Z3dkVWhhUDJj?=
 =?utf-8?B?a3NJL3c1dnlqa0VrSzR6SzBheE5IbzB0K2htMGFkcDRwQVUrQVNMK2xrWVhi?=
 =?utf-8?B?Mm1KaEpjYzVodGV6WVNtT2lHUWM1TXFZUlByU1YrcVl0OExLdWYxWmdFRkU1?=
 =?utf-8?B?cENRSnQxWDNRTEJCWEc1bVRYQjJNQ3JEcWNTcDZpTW50Rk5Ua21ReHBmSXoz?=
 =?utf-8?B?K2NYRGJBQmhsbWk4SXg0MDhoRDhGaWlGcXZraHdZRTIvTU04V01sTTMwN1Bk?=
 =?utf-8?B?aENLSlJ2LzBSc2czMVNWMjlzdGtaZVAvTjF3OWIyV3dVOEczUmhOckFRME5W?=
 =?utf-8?B?Q1dUdlo5YnNRRDgxdnpsQ3ZONHVsTWN1RUVaRyswZG9kZlQyRDRIMGdoSlNm?=
 =?utf-8?B?S0c2VERKOFZhNjQySk16YWlwZHR2ZW1ieTJuQzNvUzRjOUREUVVSdFVuMzJW?=
 =?utf-8?B?RVArSjhDVktORDhrRjlKSUZuUHhleE1kSXZrRG9wRmtwTk8xcVR4NHhKUUM3?=
 =?utf-8?B?Um1ZcDMzd2Q0MkhQcEF5eGlCMkpRVUdXTWxqMVV0ZDBUbU9TWklTT2l6MGpB?=
 =?utf-8?B?bGhSdzlobzI3cDBxWTcrSG1kR3lFaWVKREYxTlpuTUhIY1Vzb2JYajlSWG16?=
 =?utf-8?B?TGxOT1Fna0tpRGdOT3NPZ1k5YlNaTHdtcW54UWRTUWE2bmk1OGo5KzE1OFZE?=
 =?utf-8?B?K3VPRzRBUFFkYk5rNVBld0ZFOXBHcDNhS1BKMnpqVk1LTU8zaGh6YXk0eFFv?=
 =?utf-8?B?QjJkU0lmRDRDWDNVZTQ4SE1Cci9mbGpocndJaGRweGlCYnM3Mmh6dVNTQ2p4?=
 =?utf-8?B?Z3RiMGVINzAyOHlZaHNmNlJaVXFYYmV6eXdxc2dLNmsrUm9US0RjbFVyZFN3?=
 =?utf-8?B?VlBrd2Rrc1hLUUluRWdyNGJ1b3paZ2VOMzFvWitCaHdCTjl3WFZBYTJDQmN3?=
 =?utf-8?B?TzM1UU53bHg1NnR5UjVVTkRWMmtNd3d5b3dlcGhOaEIycUVhZExoTXlOOFJw?=
 =?utf-8?B?d00xTXdRdmlPY01reWM2ZG9aQUZEOFJvVWZlYk82dFlXWENHaU9ZQUhCSDJI?=
 =?utf-8?B?WExqM0dMT1NuRmNUTitwbG01aGxWLzNVYUkxdzhxTzMwY21Vd21NMU5vQU5L?=
 =?utf-8?B?RjA0cnk2Sk5lK3NncENSby9qWUMxdnRXSFNBbWdGRHBOR3ZTejYwNW9QcVZH?=
 =?utf-8?B?bG5hemNLaTVlNFpNRk5DbG8ra2FKdlZSSk8xQ0x1eHk4b0ZrYUF1dUMybDNG?=
 =?utf-8?B?cFplb2xqMUdISnFNUVRUdWtua25QRzRhcHZsaG02WnpTYWR3VFVZQkc1L2RQ?=
 =?utf-8?B?TlhZZ1ZkTkRXN0RlYklOUkZ6bUM5NDVyQUZrb0lyZkZWZDB4c2FuQTVPWFFV?=
 =?utf-8?B?dHI1VHVaVGtMK2V3ZmpCVU9UTTF2U2NlNGxZeEhIcnRnTlJyM0x1bjFvbjA1?=
 =?utf-8?Q?qGBs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93710c8d-a6ae-4624-2c36-08dcdd1bc158
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 04:37:25.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ART0ATXPHEoBeGtUpercyRrKBT8n91TdGpQN7pw1xeHtSEAU9XyKyV/RQbT2AVuRUzk8kPZjb5gy1tUEQn5Wng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDc8Oza8OhcywgQmVuY2UgPGNz
b2thcy5iZW5jZUBwcm9sYW4uaHU+DQo+IFNlbnQ6IDIwMjTlubQ55pyIMjTml6UgMTc6MzcNCj4g
VG86IEZyYW5rIExpIDxGcmFuay5MaUBmcmVlc2NhbGUuY29tPjsgRGF2aWQgUy4gTWlsbGVyDQo+
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgaW14QGxpc3RzLmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQ3PDs2vD
oXMsIEJlbmNlIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1PjsgV2VpIEZhbmcgPHdlaS5mYW5nQG54
cC5jb20+Ow0KPiBTaGVud2VpIFdhbmcgPHNoZW53ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2Fu
Zw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29n
bGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5p
IDxwYWJlbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQNCj4gQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5A
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDEvMl0gbmV0OiBmZWM6IFJlc3RhcnQg
UFBTIGFmdGVyIGxpbmsgc3RhdGUgY2hhbmdlDQo+IA0KVGhlICJ2MiIgZGVzY3JpcHRvciBpcyBt
aXNzaW5nIGluIHRoZSBzdWJqZWN0LCBhbmQgY29ycmVjdCB0aGUgbWFpbCBhZGRyZXNzDQpvZiBG
cmFuay4NCg0KPiBPbiBsaW5rIHN0YXRlIGNoYW5nZSwgdGhlIGNvbnRyb2xsZXIgZ2V0cyByZXNl
dCwgY2F1c2luZyBQUFMgdG8gZHJvcCBvdXQuDQo+IFJlLWVuYWJsZSBQUFMgaWYgaXQgd2FzIGVu
YWJsZWQgYmVmb3JlIHRoZSBjb250cm9sbGVyIHJlc2V0Lg0KPiANCj4gRml4ZXM6IDY2MDViNzMw
YzA2MSAoIkZFQzogQWRkIHRpbWUgc3RhbXBpbmcgY29kZSBhbmQgYSBQVFAgaGFyZHdhcmUNCj4g
Y2xvY2siKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDc8Oza8OhcywgQmVuY2UgPGNzb2thcy5iZW5jZUBw
cm9sYW4uaHU+DQo+IC0tLQ0KPiANCg0KPiBOb3RlczoNCj4gICAgIENoYW5nZXMgaW4gdjI6DQo+
ICAgICAtIHN0b3JlIHBwc19lbmFibGUncyBwcmUtcmVzZXQgdmFsdWUgYW5kIGNsZWFyIGl0IG9u
IHJlc3RvcmUNCj4gICAgIC0gYWNxdWlyZSB0bXJlZ19sb2NrIHdoZW4gcmVhZGluZy93cml0aW5n
IGZlcC0+cHBzX2VuYWJsZQ0KPiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWMuaCAgICAgIHwgIDYgKysrKysNCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfbWFpbi5jIHwgMTEgKysrKysrKystDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfcHRwLmMgIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hh
bmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBpbmRleCBhMTljYjJhNzg2ZmQuLjA1NTIzMTdhMjU1
NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlYy5oDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBAQCAtNjkxLDEw
ICs2OTEsMTYgQEAgc3RydWN0IGZlY19lbmV0X3ByaXZhdGUgew0KPiAgCS8qIFhEUCBCUEYgUHJv
Z3JhbSAqLw0KPiAgCXN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2c7DQo+IA0KPiArCXN0cnVjdCB7
DQo+ICsJCWludCBwcHNfZW5hYmxlOw0KPiArCX0gcHRwX3NhdmVkX3N0YXRlOw0KPiArDQo+ICAJ
dTY0IGV0aHRvb2xfc3RhdHNbXTsNCj4gIH07DQo+IA0KPiAgdm9pZCBmZWNfcHRwX2luaXQoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgaW50IGlycV9pZHgpOw0KPiArdm9pZCBmZWNfcHRw
X3Jlc3RvcmVfc3RhdGUoc3RydWN0IGZlY19lbmV0X3ByaXZhdGUgKmZlcCk7IHZvaWQNCj4gK2Zl
Y19wdHBfc2F2ZV9zdGF0ZShzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwKTsNCj4gIHZvaWQg
ZmVjX3B0cF9zdG9wKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpOyAgdm9pZA0KPiBmZWNf
cHRwX3N0YXJ0X2N5Y2xlY291bnRlcihzdHJ1Y3QgbmV0X2RldmljZSAqbmRldik7ICBpbnQgZmVj
X3B0cF9zZXQoc3RydWN0DQo+IG5ldF9kZXZpY2UgKm5kZXYsIHN0cnVjdCBrZXJuZWxfaHd0c3Rh
bXBfY29uZmlnICpjb25maWcsIGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZmVjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9m
ZWNfbWFpbi5jDQo+IGluZGV4IGFjYmI2MjdkNTFiZi4uMzFlYmY2YTRmOTczIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBAQCAtMTA3Nyw2ICsx
MDc3LDggQEAgZmVjX3Jlc3RhcnQoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAJdTMyIHJj
bnRsID0gT1BUX0ZSQU1FX1NJWkUgfCAweDA0Ow0KPiAgCXUzMiBlY250bCA9IEZFQ19FQ1JfRVRI
RVJFTjsNCj4gDQo+ICsJZmVjX3B0cF9zYXZlX3N0YXRlKGZlcCk7DQo+ICsNCj4gIAkvKiBXaGFj
ayBhIHJlc2V0LiAgV2Ugc2hvdWxkIHdhaXQgZm9yIHRoaXMuDQo+ICAJICogRm9yIGkuTVg2U1gg
U09DLCBlbmV0IHVzZSBBWEkgYnVzLCB3ZSB1c2UgZGlzYWJsZSBNQUMNCj4gIAkgKiBpbnN0ZWFk
IG9mIHJlc2V0IE1BQyBpdHNlbGYuDQo+IEBAIC0xMjQ0LDggKzEyNDYsMTAgQEAgZmVjX3Jlc3Rh
cnQoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAJd3JpdGVsKGVjbnRsLCBmZXAtPmh3cCAr
IEZFQ19FQ05UUkwpOw0KPiAgCWZlY19lbmV0X2FjdGl2ZV9yeHJpbmcobmRldik7DQo+IA0KPiAt
CWlmIChmZXAtPmJ1ZmRlc2NfZXgpDQo+ICsJaWYgKGZlcC0+YnVmZGVzY19leCkgew0KPiAgCQlm
ZWNfcHRwX3N0YXJ0X2N5Y2xlY291bnRlcihuZGV2KTsNCj4gKwkJZmVjX3B0cF9yZXN0b3JlX3N0
YXRlKGZlcCk7DQo+ICsJfQ0KPiANCj4gIAkvKiBFbmFibGUgaW50ZXJydXB0cyB3ZSB3aXNoIHRv
IHNlcnZpY2UgKi8NCj4gIAlpZiAoZmVwLT5saW5rKQ0KPiBAQCAtMTMzNiw2ICsxMzQwLDggQEAg
ZmVjX3N0b3Aoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYpDQo+ICAJCQluZXRkZXZfZXJyKG5kZXYs
ICJHcmFjZWZ1bCB0cmFuc21pdCBzdG9wIGRpZCBub3QgY29tcGxldGUhXG4iKTsNCj4gIAl9DQo+
IA0KPiArCWZlY19wdHBfc2F2ZV9zdGF0ZShmZXApOw0KPiArDQo+ICAJLyogV2hhY2sgYSByZXNl
dC4gIFdlIHNob3VsZCB3YWl0IGZvciB0aGlzLg0KPiAgCSAqIEZvciBpLk1YNlNYIFNPQywgZW5l
dCB1c2UgQVhJIGJ1cywgd2UgdXNlIGRpc2FibGUgTUFDDQo+ICAJICogaW5zdGVhZCBvZiByZXNl
dCBNQUMgaXRzZWxmLg0KPiBAQCAtMTM2Niw2ICsxMzcyLDkgQEAgZmVjX3N0b3Aoc3RydWN0IG5l
dF9kZXZpY2UgKm5kZXYpDQo+ICAJCXZhbCA9IHJlYWRsKGZlcC0+aHdwICsgRkVDX0VDTlRSTCk7
DQo+ICAJCXZhbCB8PSBGRUNfRUNSX0VOMTU4ODsNCj4gIAkJd3JpdGVsKHZhbCwgZmVwLT5od3Ag
KyBGRUNfRUNOVFJMKTsNCj4gKw0KPiArCQlmZWNfcHRwX3N0YXJ0X2N5Y2xlY291bnRlcihuZGV2
KTsNCj4gKwkJZmVjX3B0cF9yZXN0b3JlX3N0YXRlKGZlcCk7DQo+ICAJfQ0KPiAgfQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfcHRwLmMNCj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+IGluZGV4IDRjZmZk
YTM2M2ExNC4uZGYxZWYwMjM0OTNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX3B0cC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9mZWNfcHRwLmMNCj4gQEAgLTc2NCw2ICs3NjQsMzYgQEAgdm9pZCBmZWNfcHRwX2luaXQo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgaW50DQo+IGlycV9pZHgpDQo+ICAJc2NoZWR1
bGVfZGVsYXllZF93b3JrKCZmZXAtPnRpbWVfa2VlcCwgSFopOyAgfQ0KPiANCj4gK3ZvaWQgZmVj
X3B0cF9zYXZlX3N0YXRlKHN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXApIHsNCj4gKwl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmZlcC0+dG1yZWdf
bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJZmVwLT5wdHBfc2F2ZWRfc3RhdGUucHBzX2VuYWJsZSA9
IGZlcC0+cHBzX2VuYWJsZTsNCj4gKw0KPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmZlcC0+
dG1yZWdfbG9jaywgZmxhZ3MpOyB9DQo+ICsNCj4gKy8qIFJlc3RvcmUgUFRQIGZ1bmN0aW9uYWxp
dHkgYWZ0ZXIgYSByZXNldCAqLyB2b2lkDQo+ICtmZWNfcHRwX3Jlc3RvcmVfc3RhdGUoc3RydWN0
IGZlY19lbmV0X3ByaXZhdGUgKmZlcCkgew0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsN
Cj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmZmVwLT50bXJlZ19sb2NrLCBmbGFncyk7DQo+ICsNCj4g
KwkvKiBSZXNldCB0dXJuZWQgaXQgb2ZmLCBzbyBhZGp1c3Qgb3VyIHN0YXR1cyBmbGFnICovDQo+
ICsJZmVwLT5wcHNfZW5hYmxlID0gMDsNCj4gKw0KPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmZlcC0+dG1yZWdfbG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJLyogUmVzdGFydCBQUFMgaWYgbmVl
ZGVkICovDQo+ICsJaWYgKGZlcC0+cHRwX3NhdmVkX3N0YXRlLnBwc19lbmFibGUpIHsNCg0KSXQn
cyBiZXR0ZXIgdG8gcHV0ICIgZmVwLT5wcHNfZW5hYmxlID0gMCIgaGVyZSBzbyB0aGF0IGl0IGRv
ZXMNCm5vdCBuZWVkIHRvIGJlIHNldCB3aGVuIFBQUyBpcyBkaXNhYmxlZC4NCg0KPiArCQkvKiBS
ZS1lbmFibGUgUFBTICovDQo+ICsJCWZlY19wdHBfZW5hYmxlX3BwcyhmZXAsIDEpOw0KPiArCX0N
Cj4gK30NCj4gKw0KPiAgdm9pZCBmZWNfcHRwX3N0b3Aoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikgIHsNCj4gIAlzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOw0KPiAtLQ0KPiAyLjM0LjENCj4gDQoNCg==

