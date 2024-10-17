Return-Path: <netdev+bounces-136385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E59A1922
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 05:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9E71C20B6F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C8012C484;
	Thu, 17 Oct 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dJx4AZ9n"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C529405;
	Thu, 17 Oct 2024 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134564; cv=fail; b=dFahoTa/pYMxH4UwWOKCM57qNd5VgiSjySOFKsxb7JZwJ6hzDkpWPLrba9Vn5M4webr9yXLDyrG6xBQll0NyA+4srxB/5tetJhOACTBbByN3aMDvPVmYObJRhPG5dTroe9P+1x2rjG0RSoMC0BXiS7/ouvclo3MJEpWXnmFGfXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134564; c=relaxed/simple;
	bh=lMSyStbvW/Juuy2Ms9zOPLiCaDWNXOZl0kAlV7YSmV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJ4dIYl2vtDMGUTuBXhl49gNcX+g1HMo2F8cFJv+CY/7vddoIQSgzMEuYw/MezqtD74Gd+1iEcxTqGLi519fj/f/FhtxD4YHVp3ujWJMpV+A0nrqNYcf3qdwOGjaepPd4OfNWV80XOF9fFEfAsZLzaIfp5IQzkCyNymjCTskDfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dJx4AZ9n; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvPSAa+Bi8FKzonCaYvetRF52lrPNAErXtw79/EU1JttP3zXJvyB7lEm+XG4l7fU+LrWMINSXfCSYkAXywHzEGs229+kvt92zt71ZMzMt6DcTeD1k+4/k+uEf0ZlEu6zXpHHzPkMiOsJd4UFk2iNT4ncAcTGzCsmbU+OJDot1zFjm5v2DPqCmW006kEyrFdvv9+7HhnBq4hKoGXvhhGtC0H9lkRxMttXkTFIcwaUuRdcvDytaxJIkL9/hWgPiYyhxzFbZSARoCCw6Ja1n6a4Xu+Iw53VvW6qJGhdMxhYxBxhfA2NNMTYsEy5iN0NW68XAWk/4+J5EZc6nvDS2F6x+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMSyStbvW/Juuy2Ms9zOPLiCaDWNXOZl0kAlV7YSmV0=;
 b=TGYALeXLyEyhVzg8qzr9ws6CTnn1mQHq1SAZAt4I4ieHFnUmLDDZLNmg5RCn570vofP9cwgcthnxvns2N6yS5KeMSQqfSWXDxmJ29ceuP2qBnWvMlRKrquKygvqyj5wzGtELrvbvptkBYXvBqXP4QqjKdB/n0PMJ1jrQ07pV37p5KqOb+ddQsbotJaLLB1/AUaZDmS+rrcMEToLGN8smez4RgiG5qZUxs3l86MN/J6wol/EHCbUO+je/tJ8oGbccbQPO1lbxXcEUAscJd6dX0ypWUVtJ10rrm/3EBX13faZU18V8AUePK43qgXycjcc/k1VIOGCfOtdcIZBlvpIfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMSyStbvW/Juuy2Ms9zOPLiCaDWNXOZl0kAlV7YSmV0=;
 b=dJx4AZ9n5s8pvClG9U/y8QATdN55CBLKzlv+e04EwEjzY+HnoBv+dD8po+V80gNtQT0UTg5MBcvqUOIXvXc8tYQxKqL7+cK9bD8DSC0e21WP2vY/OJWzuKqQTlgkunxAhe43XaGjoEzFxrHAQPFV0TsqEnwRoWyS6ACRaI/LcTuNHSLUM53crmZ8naMEQq8Asqh468Il2I8EOaEu45kelnDvi8XbvOcD/tB4XcAn2enHx+m2KO3mo4tKJj9jP0Z0MEWuKnVrMDf35OOrjjcS70wNailSKdi9gcRqA8Tnd/7R7489QV0NQjshkde03RV/jEBTKizqkMED2cWJfTdhiw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9388.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 03:09:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 03:09:15 +0000
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
Subject: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk: bring
 IRQs in correct order
Thread-Topic: [PATCH net-next 07/13] net: fec: fec_probe(): update quirk:
 bring IRQs in correct order
Thread-Index: AQHbIBW0EbmLSZRKu0+NHfJhzgqLtbKKP8NQ
Date: Thu, 17 Oct 2024 03:09:15 +0000
Message-ID:
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS4PR04MB9388:EE_
x-ms-office365-filtering-correlation-id: e8e11e75-4abf-46e6-ecbc-08dcee59153b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmpKY2lxbm1YMFkrNE9yRUF6UEN1aUFpUmpBNVEyaVBNSmpCU2lmYi8vQzBm?=
 =?utf-8?B?bFVmTTV2WXprVzNPb0Zpc05LKzNwaHhmN3hTQXliaGFHTkRDMk9mUFFCNjJV?=
 =?utf-8?B?bS9Vbk12eVV6TzQ2VDdva1V2Sjl6U2N5NTBiRjdwL0MvSHVJN09FL01BcVY1?=
 =?utf-8?B?ZzVVdzkyQm41ejYraXJ3TE8wVnVWS1hmU09Ia0V5TmNvd1E4WTRha1F5S1k1?=
 =?utf-8?B?MWJBV2dCQXlYTi9DUTJDdkVmTjdRTUJrWC9CYWEzSXZnNjc4THdwMWJweHAr?=
 =?utf-8?B?bm1BU2FVblpocXJNb0xFYkZBSjI4M2pKeUlqRHJsTDVsS2JBU3J2UHh1SUx4?=
 =?utf-8?B?a2tGaUNUZFlTL3F0anlsbmxUSkdTcUJjem5BZWRnM0MreG5lTHN5ZitNZ0xW?=
 =?utf-8?B?ZXY1SEE2VmZWRktpTU80NHNjcGU0TUxmQ0E2THJCNnk2WXBEYWJRRjc4YWdh?=
 =?utf-8?B?YXA5bm5WZXNHaGp5alhqK3V6WVZpTVZLKzdieWJydTFabXUrMS9uSWMweUtw?=
 =?utf-8?B?WDR5VU1jYmJsK0ZrbVlybUNLb1NpM3U2UzlkZmtwdGFTbUllZWZNM1lMakNZ?=
 =?utf-8?B?cTVuL0Z3UGdkRng1V2JieGQ0UWIza0Q5WWlOOVl2OGs1eDY1OXRISHZKWEtv?=
 =?utf-8?B?djRQNEc1L0JtZ0tNT3FFdHJUMGtJOUtkMEJCTHJVRVJwUkRBUkVueWlpWmJ4?=
 =?utf-8?B?alcrN1N2enNZbm1rK1pUQmQrMTRENlgvcHJodmxIWUdFTGhHZlRLeWNDQVpF?=
 =?utf-8?B?Z216dWI2OUVvMU1wTC92a2NMTm1qNkhUUHdGdVBDQ24wY0JuakpmY21vWkNV?=
 =?utf-8?B?Ni8yTnNheHNxWXZkMzAwU01NWmpUWEtNVGI0T0xEZHZaL1VqRENCNThZcW5Z?=
 =?utf-8?B?MXdhS055ZnZHSFRIRkgvVXlNVE4vQnoxNGNMbmkzTDc1YkpEa3RmWDBwZTZt?=
 =?utf-8?B?SzluZEFYSUNwZ3NiMmV2bzZabXFuWmlIeXJmVjk1NFpidTZwQXpSV0hMaExR?=
 =?utf-8?B?MUtjT2dXejlGbUxQa1hIV0lXZ0Y5M1BkOWozYjU0eXkxaHljYXJJbXlybFJQ?=
 =?utf-8?B?SCtUbGpnai9tN0NtL3BjYm53NWVkTE9MdHNnREhGeWJKNGJlS25VUkFDWjdU?=
 =?utf-8?B?bnZHaVQ3aVJObGNMTitsK1lXN1F1VTkydzdOdFA0ZE1YZytpc0s2M1A4L1ZM?=
 =?utf-8?B?VTludFFxMVJQMkVQUCtSK0VhSVQ4SVQ0Nm1IcHRwcWRBdGtnWnN3UThlZzdx?=
 =?utf-8?B?aVBtbUs1cVRXWFZPSnVDTnNYTmFvczJ6Rm1zQzdQTkRtdWNrM3J2VFVQTkVt?=
 =?utf-8?B?Z2k2WllacjE4ZVNzL1A3enQ1RDVQRURObjI1TVpPVVBGN2VncTVDUThpV1lv?=
 =?utf-8?B?N2tNUnl3ZDQ2ejBQbk1lMXA4eEpiY0lmQzhGeEl1TEZnNXRzVTFCeHQzUHlR?=
 =?utf-8?B?S2pac1RhZjZJcHR3MFpGVHg1cW1RaE5Kc2N5WnNUWWJjQWdUR2lzSm9IU01t?=
 =?utf-8?B?aVI5T2x2YTRNcnBmL1JsQ1BJeUMwVmpMdWo3QmZvOU5UOFNUdnFIS28rc1Jx?=
 =?utf-8?B?ZWlOeFdLY0dLTU16SzBKbWt6Ni80a2owQnc5Z3ZBa2JwSkdSNUdyQVNFYktm?=
 =?utf-8?B?NVJZLzBoczNidXNKZ1dxYU9jVlZFVTlLWXpSditKMmFNQm5IOVdSWEN0ZmlY?=
 =?utf-8?B?dEZNMXRFcjFEK0lqWkJMYURiVGt3VGhLbGZrVGRVUERFcXdqYjF1dkNwOGlE?=
 =?utf-8?B?N0plUDUwcGhuRjNNdmdvVktvMHpkdkpaamtUYnVqRHNqQi8vZmZQMHVSOXhL?=
 =?utf-8?Q?mhJ+jxkuHjYYdMe3X6cbFYYbPUHcH14pnWWUQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTVla0hDZEs5UktjYTNMa3VHNXRSNE4vL3VBeW53QUZScTB3d21ndkZKaGcv?=
 =?utf-8?B?MWQxM1NlTG5BS3A0cFZDbmtSLzc4QWhDT2ZMSjV0UzZoK3J4UlFOeGdCSUdz?=
 =?utf-8?B?ek5EY2grV1dVWS9KWUJzTzNQOGM3dElxa3NsZ3VsUVRKU2xid1U3K3FvWFRN?=
 =?utf-8?B?L0Q2aFpMRWZGRHlLcFl0MzRNbVBqNXdHQWYzOU9VUFF6SFRqOHA0WXhidFZ3?=
 =?utf-8?B?ajVIcmU3OTdOWkRYZGNxSXQ1YWlEVnlsaEUyVTBUb0lidm5zNVNQNHBEazhK?=
 =?utf-8?B?UmFmeFFBbmIrR2dONEJxaGw3MkZpKy9ueFRpOGVheUxTeGlqREsxREV4RGNs?=
 =?utf-8?B?UTBRTE53UDR2dzE3Z21wWHE5M2xSKzF5NHRIQTVtRDZHSGhxRXBjSUh1QVhz?=
 =?utf-8?B?SlRDeDd6dXBDS0ZaQ3BOSjBpUWtzKzFiMDBCV2hxVUlyVHBzYW5ta1Exb1VE?=
 =?utf-8?B?YXYzMFAxWUh3dlI3ZmViVHNNOVAxWnlFRUcwNWNncEl1Z2Q3bTlremM3aGJD?=
 =?utf-8?B?ZUxFTWs1Q1ZmT0N1RitHVHBuWUJGNXNvQXVicU11N01lQ0pXUjFDSmxpZFRG?=
 =?utf-8?B?VE5pTFU5MEYxeEZaTlVnU1B2MnoydWtFTGgyd2J3VUU4bjNpNlZGaW9QMzF3?=
 =?utf-8?B?dnRnYUI4a2pCSnJ1cmZNUVd0aTJ6S1h4RmZHTVRFM3VSa1EyMDlHQ1VqWk9U?=
 =?utf-8?B?cTlHQXRHQTJ2cU9RaUlMZVJFemErV01rcmdRYlg4NEZGL2RLTno4bnZ4Z2lR?=
 =?utf-8?B?SWdFdXd3cFdzcUwybVFPbldOTU5DdkgvZVYxYnFFSWpOUlpqRGJUV0xNM2R0?=
 =?utf-8?B?V1ZxV2dsR203L0xXVWptVjJwMk85ckNFbVd2c0RBWE5GbW5FaGJiRHdpckg2?=
 =?utf-8?B?NERqYzNpOWpYMEd0bm1MOU5Pb2NpeWVJVUFFLzN2NlVkdTlFMUx4QzB3SHlP?=
 =?utf-8?B?eDZjdzFCcDBuT21xSHhPUDNnb25vS05TOUYySXR6REU0VUUvREZzSWx4ZkRv?=
 =?utf-8?B?bFZKMVdSVVlhMlMvZy9QWGY3bmF2SHUyMGxrLzJ1Vm5sZTYraTRWTXRaVklz?=
 =?utf-8?B?d0lFQVdmWkg0SVVtVktPQmRSVlU1LzMxZ3VnMTk1aFN4MjdSeTM5MzROSnBD?=
 =?utf-8?B?QlVxbzRiYlR1UWR4R1lUTjkzem94VkttdWg4TDk3cGdwQlRjNVRwbm0vT05Z?=
 =?utf-8?B?NnFPc3RBa2U4eEhtMWxqTVFLTG4zSzUwckZvY0orM0xoWkNCeTF2T2N4VDIr?=
 =?utf-8?B?aHVPamtqSlBNK05MN3doZWNCamhQUG5DbkJzVUFaTWR5TUtoandLSzdtbDRw?=
 =?utf-8?B?b3VJNVkwTjRJVVZnbmNsSUU1YjFwTXoyeFRsSStJWnRUeG51dlduNTBuSDJv?=
 =?utf-8?B?a2JkYWhVRDU0dXJBTWJmU3lsZkdWMW1SanpzMHJsejRaV3h0NHcwTWZoUFRQ?=
 =?utf-8?B?VGc4Njl2U2Q4MkF3ZnRuM2NrU21CZnFGWkR2dFBEN01aRHFNVHkzaHl2TnBB?=
 =?utf-8?B?YllYcmhUWTc5ZVltSnNuKzlCYXk2d2JEMWFkME15OUtMYk9ObVlhUWhnREI2?=
 =?utf-8?B?OEpyOUJuQVM2RW85ZmZtbWFTdUlnbngyWGJxMVFZdlVGOC9QdXdQOFhlcm01?=
 =?utf-8?B?ZExxZnhWZXg4cDNTR2NtWlUrNVNIZ0NMZlMxamZTa0ZZNHBEcGlEeCtvWEIr?=
 =?utf-8?B?cS9CQTJCcCtUbGI5TjZDTlhiZzdQRVpkMllWdUMrS0tRemF0cVNWNnJLNk9F?=
 =?utf-8?B?eUtmZXppRlpSYnVvOGpSQ3owbmV3YUloallpMnpKSHBIaE1NN2dzM0loaVlI?=
 =?utf-8?B?a09tcTBxRlgyMy93WW1NZ3gvd1hHaHpMZUliZUlvTXY4MlRYcGZGLzArZTNk?=
 =?utf-8?B?UjFVLzVVQW5aTHJEMEgrTTlxdFo0OXZmd3ErVWFmR2ZVQTNlK0VZYkZkaGt1?=
 =?utf-8?B?dC9nZU1CYmVmaVlEcU9PdnVUY1g3eW1mTitnSGgvb0lBY0gzSENiTkthenZl?=
 =?utf-8?B?UlNmWmdKc3V3dXQybU9YY2xaMHFnemQ5cHVScVpmKy9UcEJEY01yeXZ5ckhn?=
 =?utf-8?B?dXdBSDEvaFFacmNPTjhweHZKblZEdEVZRXQyeEV4U0pQOWZHTUVhTll2R29I?=
 =?utf-8?Q?0RE0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e11e75-4abf-46e6-ecbc-08dcee59153b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 03:09:15.5268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +e8oEgfdLn/4VnKywGIGE7bzhoXiPY8ynZrVgDViKUEHuR7PvGk8L/WrlVOVrDcFws5qBkVTmYmq9od3c6tjvg==
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
Y3Q6IFtQQVRDSCBuZXQtbmV4dCAwNy8xM10gbmV0OiBmZWM6IGZlY19wcm9iZSgpOiB1cGRhdGUg
cXVpcms6IGJyaW5nIElSUXMNCj4gaW4gY29ycmVjdCBvcmRlcg0KPiANCj4gV2l0aCBpLk1YOE1R
IGFuZCBjb21wYXRpYmxlIFNvQ3MsIHRoZSBvcmRlciBvZiB0aGUgSVJRcyBpbiB0aGUgZGV2aWNl
DQo+IHRyZWUgaXMgbm90IG9wdGltYWwuIFRoZSBkcml2ZXIgZXhwZWN0cyB0aGUgZmlyc3QgdGhy
ZWUgSVJRcyB0byBtYXRjaA0KPiB0aGVpciBjb3JyZXNwb25kaW5nIHF1ZXVlLCB3aGlsZSB0aGUg
bGFzdCAoZm91cnRoKSBJUlEgaXMgdXNlZCBmb3IgdGhlDQo+IFBQUzoNCj4gDQo+IC0gMXN0IElS
UTogImludDAiOiBxdWV1ZTAgKyBvdGhlciBJUlFzDQo+IC0gMm5kIElSUTogImludDEiOiBxdWV1
ZTENCj4gLSAzcmQgSVJROiAiaW50MiI6IHF1ZXVlMg0KPiAtIDR0aCBJUlE6ICJwcHMiOiBwcHMN
Cj4gDQo+IEhvd2V2ZXIsIHRoZSBpLk1YOE1RIGFuZCBjb21wYXRpYmxlIFNvQ3MgZG8gbm90IHVz
ZSB0aGUNCj4gImludGVycnVwdC1uYW1lcyIgcHJvcGVydHkgYW5kIHNwZWNpZnkgdGhlIElSUXMg
aW4gdGhlIHdyb25nIG9yZGVyOg0KPiANCj4gLSAxc3QgSVJROiBxdWV1ZTENCj4gLSAybmQgSVJR
OiBxdWV1ZTINCj4gLSAzcmQgSVJROiBxdWV1ZTAgKyBvdGhlciBJUlFzDQo+IC0gNHRoIElSUTog
cHBzDQo+IA0KPiBGaXJzdCByZW5hbWUgdGhlIHF1aXJrIGZyb20gRkVDX1FVSVJLX1dBS0VVUF9G
Uk9NX0lOVDIgdG8NCj4gRkVDX1FVSVJLX0lOVDJfSVNfTUFJTl9JUlEsIHRvIGJldHRlciByZWZs
ZWN0IGl0J3MgZnVuY3Rpb25hbGl0eS4NCj4gDQo+IElmIHRoZSBGRUNfUVVJUktfSU5UMl9JU19N
QUlOX0lSUSBxdWlyayBpcyBhY3RpdmUsIHB1dCB0aGUgSVJRcyBiYWNrDQo+IGluIHRoZSBjb3Jy
ZWN0IG9yZGVyLCB0aGlzIGlzIGRvbmUgaW4gZmVjX3Byb2JlKCkuDQo+IA0KDQpJIHRoaW5rIEZF
Q19RVUlSS19JTlQyX0lTX01BSU5fSVJRIG9yIEZFQ19RVUlSS19XQUtFVVBfRlJPTV9JTlQyDQpp
cyAqTk8qIG5lZWRlZCBhbnltb3JlLiBBY3R1YWxseSwgSU5UMiBpcyBhbHNvIHRoZSBtYWluIElS
USBmb3IgaS5NWDhRTSBhbmQNCml0cyBjb21wYXRpYmxlIFNvQ3MsIGJ1dCBpLk1YOFFNIHVzZXMg
YSBkaWZmZXJlbnQgc29sdXRpb24uIEkgZG9uJ3Qga25vdyB3aHkNCnRoZXJlIGFyZSB0d28gZGlm
ZmVyZW50IHdheXMgb2YgZG9pbmcgaXQsIGFzIEkgZG9uJ3Qga25vdyB0aGUgaGlzdG9yeS4gQnV0
IHlvdSBjYW4NCnJlZmVyIHRvIHRoZSBzb2x1dGlvbiBvZiBpLk1YOFFNLCB3aGljaCBJIHRoaW5r
IGlzIG1vcmUgc3VpdGFibGUuDQoNClNlZSBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4LXNzLWNvbm4uZHRzaSwgdGhlIElSUSAyNTggaXMNCnBsYWNlZCBmaXJzdC4NCg0KZmVjMTog
ZXRoZXJuZXRANWIwNDAwMDAgew0KCQlyZWcgPSA8MHg1YjA0MDAwMCAweDEwMDAwPjsNCgkJaW50
ZXJydXB0cyA9IDxHSUNfU1BJIDI1OCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCgkJCSAgICAgPEdJ
Q19TUEkgMjU2IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KCQkJICAgICA8R0lDX1NQSSAyNTcgSVJR
X1RZUEVfTEVWRUxfSElHSD4sDQoJCQkgICAgIDxHSUNfU1BJIDI1OSBJUlFfVFlQRV9MRVZFTF9I
SUdIPjsNCg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJv
bml4LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaCAg
ICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDE4ICsrKysrKysrKysrLS0tLS0tLQ0KPiAgMiBmaWxl
cyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0KPiBpbmRleA0KPiA2Mzc0NGE4Njc1MjU0MGZj
ZWRlN2ZjNGMyOTg2NWIyNTI5NDkyNTI2Li5iMGYxYTNlMjhkNWM4MDUyYmUzYThhMA0KPiBmYTE4
MzAzYTFkZjJiYjViZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNj
YWxlL2ZlYy5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWMuaA0K
PiBAQCAtNTA0LDggKzUwNCwyOCBAQCBzdHJ1Y3QgYnVmZGVzY19leCB7DQo+ICAgKi8NCj4gICNk
ZWZpbmUgRkVDX1FVSVJLX0RFTEFZRURfQ0xLU19TVVBQT1JUCSgxIDw8IDIxKQ0KPiANCj4gLS8q
IGkuTVg4TVEgU29DIGludGVncmF0aW9uIG1peCB3YWtldXAgaW50ZXJydXB0IHNpZ25hbCBpbnRv
ICJpbnQyIiBpbnRlcnJ1cHQNCj4gbGluZS4gKi8NCj4gLSNkZWZpbmUgRkVDX1FVSVJLX1dBS0VV
UF9GUk9NX0lOVDIJKDEgPDwgMjIpDQo+ICsvKiBXaXRoIGkuTVg4TVEgYW5kIGNvbXBhdGlibGUg
U29DcywgdGhlIG9yZGVyIG9mIHRoZSBJUlFzIGluIHRoZQ0KPiArICogZGV2aWNlIHRyZWUgaXMg
bm90IG9wdGltYWwuIFRoZSBkcml2ZXIgZXhwZWN0cyB0aGUgZmlyc3QgdGhyZWUgSVJRcw0KPiAr
ICogdG8gbWF0Y2ggdGhlaXIgY29ycmVzcG9uZGluZyBxdWV1ZSwgd2hpbGUgdGhlIGxhc3QgKGZv
dXJ0aCkgSVJRIGlzDQo+ICsgKiB1c2VkIGZvciB0aGUgUFBTOg0KPiArICoNCj4gKyAqIC0gMXN0
IElSUTogImludDAiOiBxdWV1ZTAgKyBvdGhlciBJUlFzDQo+ICsgKiAtIDJuZCBJUlE6ICJpbnQx
IjogcXVldWUxDQo+ICsgKiAtIDNyZCBJUlE6ICJpbnQyIjogcXVldWUyDQo+ICsgKiAtIDR0aCBJ
UlE6ICJwcHMiOiBwcHMNCj4gKyAqDQo+ICsgKiBIb3dldmVyLCB0aGUgaS5NWDhNUSBhbmQgY29t
cGF0aWJsZSBTb0NzIGRvIG5vdCB1c2UgdGhlDQo+ICsgKiAiaW50ZXJydXB0LW5hbWVzIiBwcm9w
ZXJ0eSBhbmQgc3BlY2lmeSB0aGUgSVJRcyBpbiB0aGUgd3Jvbmcgb3JkZXI6DQo+ICsgKg0KPiAr
ICogLSAxc3QgSVJROiBxdWV1ZTENCj4gKyAqIC0gMm5kIElSUTogcXVldWUyDQo+ICsgKiAtIDNy
ZCBJUlE6IHF1ZXVlMCArIG90aGVyIElSUXMNCj4gKyAqIC0gNHRoIElSUTogcHBzDQo+ICsgKg0K
PiArICogSWYgdGhlIGZvbGxvd2luZyBxdWlyayBpcyBhY3RpdmUsIHB1dCB0aGUgSVJRcyBiYWNr
IGluIHRoZSBjb3JyZWN0DQo+ICsgKiBvcmRlciwgdGhpcyBpcyBkb25lIGluIGZlY19wcm9iZSgp
Lg0KPiArICovDQo+ICsjZGVmaW5lIEZFQ19RVUlSS19EVF9JUlEyX0lTX01BSU5fSVJRCUJJVCgy
MikNCj4gDQo+ICAvKiBpLk1YNlEgYWRkcyBwbV9xb3Mgc3VwcG9ydCAqLw0KPiAgI2RlZmluZSBG
RUNfUVVJUktfSEFTX1BNUU9TCQkJQklUKDIzKQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZmVjX21haW4uYw0KPiBpbmRleA0KPiBkOTQ4ZWQ5ODEwMDI3ZDVmYWJlNTIxZGMz
YWYyY2Y1MDVkYWNkMTNlLi5mMTI0ZmZlMzYxOWQ4MmRjMDg5Zjg0OTQNCj4gZDMzZDIzOThlNmY2
MzFmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19t
YWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMN
Cj4gQEAgLTE1Nyw3ICsxNTcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZlY19kZXZpbmZvIGZl
Y19pbXg4bXFfaW5mbyA9IHsNCj4gIAkJICBGRUNfUVVJUktfRVJSMDA3ODg1IHwgRkVDX1FVSVJL
X0JVR19DQVBUVVJFIHwNCj4gIAkJICBGRUNfUVVJUktfSEFTX1JBQ0MgfCBGRUNfUVVJUktfSEFT
X0NPQUxFU0NFIHwNCj4gIAkJICBGRUNfUVVJUktfQ0xFQVJfU0VUVVBfTUlJIHwgRkVDX1FVSVJL
X0hBU19NVUxUSV9RVUVVRVMNCj4gfA0KPiAtCQkgIEZFQ19RVUlSS19IQVNfRUVFIHwgRkVDX1FV
SVJLX1dBS0VVUF9GUk9NX0lOVDIgfA0KPiArCQkgIEZFQ19RVUlSS19IQVNfRUVFIHwgRkVDX1FV
SVJLX0RUX0lSUTJfSVNfTUFJTl9JUlEgfA0KPiAgCQkgIEZFQ19RVUlSS19IQVNfTURJT19DNDUs
DQo+ICB9Ow0KPiANCj4gQEAgLTQyNjAsMTAgKzQyNjAsNyBAQCBzdGF0aWMgdm9pZCBmZWNfZW5l
dF9nZXRfd2FrZXVwX2lycShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXN0
cnVjdCBuZXRfZGV2aWNlICpuZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAJ
c3RydWN0IGZlY19lbmV0X3ByaXZhdGUgKmZlcCA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiANCj4g
LQlpZiAoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfV0FLRVVQX0ZST01fSU5UMikNCj4gLQkJZmVw
LT53YWtlX2lycSA9IGZlcC0+aXJxWzJdOw0KPiAtCWVsc2UNCj4gLQkJZmVwLT53YWtlX2lycSA9
IGZlcC0+aXJxWzBdOw0KPiArCWZlcC0+d2FrZV9pcnEgPSBmZXAtPmlycVswXTsNCj4gIH0NCj4g
DQo+ICBzdGF0aWMgaW50IGZlY19lbmV0X2luaXRfc3RvcF9tb2RlKHN0cnVjdCBmZWNfZW5ldF9w
cml2YXRlICpmZXAsDQo+IEBAIC00NDk1LDEwICs0NDkyLDE3IEBAIGZlY19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlnb3RvIGZhaWxlZF9pbml0Ow0KPiANCj4gIAlm
b3IgKGkgPSAwOyBpIDwgaXJxX2NudDsgaSsrKSB7DQo+IC0JCXNucHJpbnRmKGlycV9uYW1lLCBz
aXplb2YoaXJxX25hbWUpLCAiaW50JWQiLCBpKTsNCj4gKwkJaW50IGlycV9udW07DQo+ICsNCj4g
KwkJaWYgKGZlcC0+cXVpcmtzICYgRkVDX1FVSVJLX0RUX0lSUTJfSVNfTUFJTl9JUlEpDQo+ICsJ
CQlpcnFfbnVtID0gKGkgKyBpcnFfY250IC0gMSkgJSBpcnFfY250Ow0KPiArCQllbHNlDQo+ICsJ
CQlpcnFfbnVtID0gaTsNCj4gKw0KPiArCQlzbnByaW50ZihpcnFfbmFtZSwgc2l6ZW9mKGlycV9u
YW1lKSwgImludCVkIiwgaXJxX251bSk7DQo+ICAJCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnlu
YW1lX29wdGlvbmFsKHBkZXYsIGlycV9uYW1lKTsNCj4gIAkJaWYgKGlycSA8IDApDQo+IC0JCQlp
cnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIGkpOw0KPiArCQkJaXJxID0gcGxhdGZvcm1fZ2V0
X2lycShwZGV2LCBpcnFfbnVtKTsNCj4gIAkJaWYgKGlycSA8IDApIHsNCj4gIAkJCXJldCA9IGly
cTsNCj4gIAkJCWdvdG8gZmFpbGVkX2lycTsNCj4gDQo+IC0tDQo+IDIuNDUuMg0KPiANCg0K

