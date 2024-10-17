Return-Path: <netdev+bounces-136436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6509A1BF1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EB01F235F7
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84CD1C2434;
	Thu, 17 Oct 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BP4Gad5R"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF71B6CF2;
	Thu, 17 Oct 2024 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151321; cv=fail; b=r1wcCODXonlzf5QvgdIE93Hz74wIjLBIijUaY6aDjbTOsOAgzlOXiN96utLJ+m7Fru+xNuESqiMGx2IUc4nls8HZPJ/ppXYfuStJuqhPLybOTM9r2p1KCpTE2WFvkbmbU/NHb9PVmkOBbGJE7PCZU/2AvxwBuALOIIMWJRxB4NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151321; c=relaxed/simple;
	bh=woLKDXs/YyloBHKNUFximCPd+sXQjQhyi5qbRlIzCMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YyIYZiSvauNH33jBVw+IS5KgBpn/2vZ3SpVKj6vh7y4LcHiwNLqDDDW7CCS1LtWjL6PrgV9MWy1XwovAmvKAFf7+eYN2W8w0WHqzjM6zaUp+V1OxfXBPJJXu5L75pO/PcMJJNnmFmfRS2SKTsa7G3Dq+V0ok3Cte5/Jf+L79Npg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BP4Gad5R; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQj0PkfBZyJwe09T1RLVd978LQbMBHnakARLoeimDyPrt53hWhn9KvzqgHdILqZ7fYdaLC9oRAbDJJtvn1he/OBR2mktKHhw+jCWdiL7wuO1jVLl0HxUQg1mj7WWeScYyJo58bxKLWxG6jE75DR4k6Lr4mgMObY0FCvPqHO4Bp2BBqkYm+sEvrLBapOv/mcBiZxWhw40k5VUxBVPeuX/NQ1BFHD8vHjLjROHqTRz2RQ6usteHZqAVb+VImgufDKr0MEtxCA8BlyKqBPZPGkw5aUtMkUl+3HoPPHjVcCfK2CN8zi3J6UPEBZR3d1SLTPCRnmC4nmkLyHaWK7o2IGB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woLKDXs/YyloBHKNUFximCPd+sXQjQhyi5qbRlIzCMc=;
 b=aS7mQYwLbV27wVjHCYAUNaml0GX6D+Ih1IK99RSMZUszBuGsA8bucoMJyED4eYJq40wVJ4BAmV25A7sECPFS995tFwBpw+BcrCPoByvvZ2tkTdtltOMnPnS1AtJ97MyzCzDDfwWSbB5E1cTRiGSoCJerm9nH7W98mltJ76ZDyQn3XywrOLAE/SUTkANl5SVNKyaTHLxmk5hSv08N02hRigcVcJNsleboghdwv1TrNYomfoSADbL79tnq1VMhgbG7szQa0J2vg/hoUyVs6WaOdvS1/C1J9sUK6MFkvCx+HxYesgEv7vWKYKC1jb2oKK7B65DyBc4bFK5AWUWPbXIXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woLKDXs/YyloBHKNUFximCPd+sXQjQhyi5qbRlIzCMc=;
 b=BP4Gad5Rxlamg+0aN8rVwnUIeM8+AMLEDzdRj2rzMWFDMURM9KY0sfBJu+sowUcNdiqywC0Wzs6QCUoxi43i7BHD0RVgEG7ifwGjTJs+ELiq3voLPgFwNlixC1Z5OW5AgsAuuHcfAVvV6kw2ZiUMYqYdiSfd8jWA93nam/eCuYsMNNgH0DvL9CGOo1ehdwNerl3P4pMJEeDh/PZZLHi4Xq29MajcjcztPqWjW7bmdlaCVSrKntoJxgV8Yl6gzAL36pVGwz9JawGo3CwIveATX51abC7g/SHCRXVDAnmBJdEQuqy8ZHOunIzNMmAAytQDv6K0sIO854phqf79GhCz3g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10921.eurprd04.prod.outlook.com (2603:10a6:150:227::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 07:48:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 07:48:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: RE: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue(): factor
 out VLAN handling into separate function fec_enet_rx_vlan()
Thread-Topic: RE: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue(): factor
 out VLAN handling into separate function fec_enet_rx_vlan()
Thread-Index: AQHbIBW1Ln+Q++z0lkqDR7nmqTk8k7KKSeZwgAA84YCAAAp/EA==
Date: Thu, 17 Oct 2024 07:48:34 +0000
Message-ID:
 <PAXPR04MB8510969C2BE65FD3D08ACBC788472@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-13-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85104DCA7DED14565615E4A588472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-fox-of-awesome-blizzard-544df5-mkl@pengutronix.de>
In-Reply-To: <20241017-fox-of-awesome-blizzard-544df5-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10921:EE_
x-ms-office365-filtering-correlation-id: 3b95f69b-f1e6-4fc1-b5e3-08dcee801a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzNDYTJ2Mzl6U1pBblA4aFhUOG9pcUxneVY1cjMyWTJZL3BqMzJEWlNqdFVt?=
 =?utf-8?B?dlRGM1VaSEJybkRFb2JTeXk4eHJiQ1Y3bFlHdHR2YUQ4bEMwbVdtZklHUWx0?=
 =?utf-8?B?Q255WWhsOU43NGxwK1I0V3Mvd0xMRmlhSjhkY0JTckVWcXVMakIzM2YybzVk?=
 =?utf-8?B?bjh1NEdxREFoWXNLNE9WaFRmZzdmOHRlcTIwazE0UDRQdjgyT2o1azRBZHF3?=
 =?utf-8?B?VnlXZHN2cm1ybHBuUGFCOW1nd0JTK1hOZzBmbk5HVGRMVTF3WVZlZzloV2Yr?=
 =?utf-8?B?S21tYk9sZHgremkwbWlBQ0IvZ1Q3L1IvTjF4cTlad0YrZmxwM2R5UHVaT3dj?=
 =?utf-8?B?NTFISGlCditEVzhpM00xK1VPUG9iUStVeW9ncXRPRUUvQ1VpOTNRVElYenlF?=
 =?utf-8?B?bENhdHAwQUMvOWtDeVZGamdTOGtmU1VsZFdqdm8yd2ZlOWU2SjNpaStJRmtv?=
 =?utf-8?B?MllseUlkT0JIQk9DVytGY0ZLWkFoNXdnODhUam4xdjZ5a0hCY3RBQ2toVVFh?=
 =?utf-8?B?MGcyemNFdml0MzhpanhaM2pibCtXTHEydEdKTE1raXNkcWswVzJHd25SZmhw?=
 =?utf-8?B?emZPVGhQVzhDcUplMW1MZi9TQlozdVplQkZvZUVzOVhVSDFIRGpPamF5Ulcw?=
 =?utf-8?B?dERqSVI0aEcrcEJ0MnE0TDZNcHBpS1Y3b1MrQWZ6Mng5amtYeGlOY2wzbGJP?=
 =?utf-8?B?TjIrVm1pOTE1akhFdk9KWjRsTzBkdXlYZW1sbGhZQ3YranV0YkpDU2hRM2FW?=
 =?utf-8?B?SlltQXZLU0VWVjZkUjhpaGNqYVl6Y2d2eUNvbDlSOVRrOVN5cXI4Y1VLTjRo?=
 =?utf-8?B?Yk92OWlHcmxyc1AwZklBdHBMbG1zRTR6MTA4VXRIckF3U3RQZTBXU1pBb0Z3?=
 =?utf-8?B?TjN6N1hzZitBeTljck96dE9GaWIreFN6SVg5Zjl4ZHlWaUxaVmJCVStkSnRr?=
 =?utf-8?B?S1dzLzdxamw5WVQ4TCtESFovcU40ZVpEQ3BqV2xpR0dtdllmdGhpOEF0YnFO?=
 =?utf-8?B?dEt1UTNRMWJwUVl2cUV4L0N6U0NYYXNFVkhobk9NQ0lCRmJ0bklmVzdWMzZ5?=
 =?utf-8?B?eisrWHpkSVpJbHBFTHN0K2dDemJ5K3htUFB3bFVCSkN4VTREZzVMeHFzbE9L?=
 =?utf-8?B?UGorZE9BT3V4RWZrUXd3ZVNndll4bkV3czJ5dkJOdWJzZ21KU1NVMkY3Q3lm?=
 =?utf-8?B?Z3h3OWx3bW5kdGVFRGkzY0lYbEF0WFRnTVhrazhJWlBwdHlDS3NYS3FLV3Bh?=
 =?utf-8?B?N3JEMXp4MDM5V0hLTDJ2WWN1MVJ4RGhHaWZuTUh2SEd4b1M0YVo1NE81N1N5?=
 =?utf-8?B?czZIdkdWTi9zbFRNUVM5ZmpES2ROcGVPTFFZUytFcEV0Q1Vsbzc1R21WY09X?=
 =?utf-8?B?YUowQnhjYk4wUlNseVBMQjJoRmFwdkZVREd1RkJzSVV4aTk4Z1pYaEhvdmhr?=
 =?utf-8?B?ekRpTTlqaHV1bFp6WVFoMDI0UGFSdSt2ellMZHRWQUhYYzJSTXZwY2RGSVlE?=
 =?utf-8?B?U25EWkppZEJNUTkzbnByV1JSY0RKU0dxb0VRYndVTVNCWEtHdzM0WEYxOXp6?=
 =?utf-8?B?NS85enE2ZUx0MjViajdBWXYxQURIZUVyeEpmakdybjVja0VUUkI5aXJZRjBu?=
 =?utf-8?B?YmFNb0daUDZBcCtmc20rRWJ0RUgxT2ViRE5rL0FsR1M1cWZ5ZzNjbk5vTG1D?=
 =?utf-8?B?ZHR4VThJN2kvVExHcFVEbWR3TkdqMEIyUUx4UmVpK3N0S3poRlRIK1R6T3ZP?=
 =?utf-8?Q?r667jECTqq4AJ14d5WAiMlAnABbfRdgD9YUxxW7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGtNalhyTmtRV082d0JZQXZHYmpmL3F6dmx6NEVtVUZzeWdtMmVuOWlKRWU5?=
 =?utf-8?B?Tm9hSG4rTzFoYnF3Qml2ekNGYVNyR0MwMTFoSzlxbm94VS84VG5sY3lEZjNK?=
 =?utf-8?B?bExxQ0JXZjJOV3ZMemVWVWxuZjB3SnBuNXoyYUkrRHUwVVNTNTByWUtteTRz?=
 =?utf-8?B?TkE1dlJtQ0lISEt3V1lvaFhVOXhCNkhjQjhEdmNNNmJwU3FydU0xdVQwb2U2?=
 =?utf-8?B?TEk4UnRNR1J5a2lHOTYxU1NoeTZIMERERnNJamdnTFdObmhzL2NlTFBVcDhh?=
 =?utf-8?B?SllnR3N4ZkV0Z1FTMS81c3JGY2VEbDBnQXg3SlQrc01Td3hnZ0lxVnd3YXBk?=
 =?utf-8?B?MjhqSXh3cFA4Z3E0Q0gxQWlwM3F6TDF1blRISlJDdWtLYzk5T1JtMk1wbjE4?=
 =?utf-8?B?Z09tNjNXTEVCK0ZJNGNUQ3V1U1BLem9pc0FoTVlvL2FWQVdnNXdnckFQUVRS?=
 =?utf-8?B?bG4vNkpwdFV2R2JRR0JjODlkWXF0cE1Td3ZQN1MwK0hpbFR0WU1sRFVVeEgr?=
 =?utf-8?B?QlpGc0RiRG5DMmloZVdpOXlkdTNFOFNiRXFKa1NkekxiWEZHS2sxeDBqbk12?=
 =?utf-8?B?THBxL2JHRCtwWUNzaEZpdGhrRUpKcnA5YU9MV01Jd21rbDU0NzBiNHJMVlY3?=
 =?utf-8?B?OC8vc25Kd01DQmhTNG5DVVg4STc0a3pQU2RvT0JOT1R1NUZUNm96ZGt2MjIv?=
 =?utf-8?B?TmlMcm90dE4wVndndlRQdHp0YW5HS0llbzd0Tkt5SkVsUXcyNlNPQzUxalc1?=
 =?utf-8?B?TjdIZXZacXQzbGFVUHpIWUVSOFNNV2Zrb1U3T3BpVUFCY1U1UDA0dkJDME82?=
 =?utf-8?B?QjFZQStqNjNKOU5GcWdKMVBwTnc1Rml0VlcvNVh2TUdKVzV0UkN1dURmRUtQ?=
 =?utf-8?B?L2ZpSTlNMitzdk9lSHl6MjFpRWVWNjZUYXhObEVUbWV2TVRTNkpVZnB3NE9w?=
 =?utf-8?B?NDJIVndaa1BydGdCMGlWd20rNVFEdE1iRDRSWjBMczhXRUsrWE1Zak1iM21y?=
 =?utf-8?B?NzdkN0xVVkk2cWdPd3hydG5VejZMZEhMaEZmcE96Q0lpNEJzWlVLcHg3ZTRL?=
 =?utf-8?B?a2Z6d0lhZ2JQSVh6WVNyRkhEOGNtZlhPNUgvN2RlSXkrNmdJdDhCRWl0ekdz?=
 =?utf-8?B?cnFveWV0MCtZclpNbjBsRFo1S2cvVEZJaUQxUW5tZ0htWVA4TktWNmdjY1NH?=
 =?utf-8?B?R2hSRHdYbXRab3hudHh1ZjRIYUVacnlId0hvdUxDMjZWSUJIYS9ERTlUMkRo?=
 =?utf-8?B?M25WQ0JESENrbGNJeHJTeksxU0VjQThqeHdLYnIxTExUc05IRVRUcHJVVHIy?=
 =?utf-8?B?c3Y5QlJubzlQWmVYaE1Va2tvTHFSZHFZazZpbituWWt3VmxNUFlyakQzSGhz?=
 =?utf-8?B?ZlVlcDVZQS94c2hxL0YxOW5yUWVPRGtSbkFvcXlVSHNvbFlsYkxOR0tWdG5Y?=
 =?utf-8?B?cnNPam1vb21FMFpOUEpGMkk4VzJ0UzFudWlWVEFCOXJQRnQ2MGZxUjErZXM0?=
 =?utf-8?B?SGlyckh4T0JlTFBaM1pDZEVITTRkYmxGU3BXZGUwdFhjTkNySHlYdnJTS1ZY?=
 =?utf-8?B?RldyU21lN0J3L3o3eTFySUg5VW5NRXhIcE5uU1dsRlVTRHUvNHJqM2ZrMWdY?=
 =?utf-8?B?TmVlSWl3UzdnQjV0ZFhFUldEL0NEekRrNCtORk9LVkdjUXFtcW1SOGpnNEZQ?=
 =?utf-8?B?YVp5QjhxMEk0RkJ5cUNJL0VHSFJmV0RjOFhoNEVIR1hMamdBczdqaG5JWnZm?=
 =?utf-8?B?Zjd1dW16VnQ5TjYxeXBGN0lCSGVaOGQ4cG91N1d1cUxhckgrd2ozUTJaSGVq?=
 =?utf-8?B?N0JjRWExQmxwRnN1cGlacGdlMVNsTTJxd0xOU21mWGtUWng0RFk5Qis5ekRL?=
 =?utf-8?B?VDdlZjA4dXVzQ0tDNXlhWTgrUDkrdnVCM3YwdzhGL1BucUl3YUNuT2Q0Y0Vk?=
 =?utf-8?B?cGtkZHJEYjI5em1tY2MyNFpSQlcyam9ER3FlaWdDeW0xU0RQZk13c3VnSW5l?=
 =?utf-8?B?V1l0M1g2dkVUSkNJQzdWWXJCM2dqaHFHeGgwaXF6SVpQWHBWMkY0ZjJaRzlO?=
 =?utf-8?B?bjNpZG9EbUVnK0Jyb3RsdlZJekVDblAySXJwVTIzRWNFdzNlRVkwb0JSWktP?=
 =?utf-8?Q?Peec=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b95f69b-f1e6-4fc1-b5e3-08dcee801a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 07:48:34.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUswCw+CfoB+p7UgsWFM4kfWEEYiPYvvFLbl7L7DUGEcrWzEZlW90FtDbg6zmprgMq1gDgwlD+RqmL5GsxhkXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10921

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0MTDmnIgxN+aXpSAxNTowOQ0KPiBU
bzogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBTaGVud2VpIFdhbmcgPHNoZW53
ZWkud2FuZ0BueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsg
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBh
b2xvDQo+IEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFy
ZGNvY2hyYW5AZ21haWwuY29tPjsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1
dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJlOiBSRTogW1BBVENIIG5ldC1uZXh0IDEzLzEzXSBuZXQ6
IGZlYzogZmVjX2VuZXRfcnhfcXVldWUoKTogZmFjdG9yDQo+IG91dCBWTEFOIGhhbmRsaW5nIGlu
dG8gc2VwYXJhdGUgZnVuY3Rpb24gZmVjX2VuZXRfcnhfdmxhbigpDQo+IA0KPiBPbiAxNy4xMC4y
MDI0IDAzOjMzOjA5LCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRl
Pg0KPiA+ID4gU2VudDogMjAyNOW5tDEw5pyIMTfml6UgNTo1Mg0KPiA+ID4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPjsgU2hlbndlaSBXYW5nDQo+IDxzaGVud2VpLndhbmdAbnhwLmNv
bT47DQo+ID4gPiBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54cC5jb20+OyBEYXZpZCBTLiBN
aWxsZXINCj4gPiA+IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpl
dEBnb29nbGUuY29tPjsgSmFrdWINCj4gPiA+IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQ
YW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkDQo+ID4gPiBDb2NocmFuIDxy
aWNoYXJkY29jaHJhbkBnbWFpbC5jb20+DQo+ID4gPiBDYzogaW14QGxpc3RzLmxpbnV4LmRldjsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5n
dXRyb25peC5kZT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCAxMy8xM10gbmV0OiBm
ZWM6IGZlY19lbmV0X3J4X3F1ZXVlKCk6IGZhY3RvciBvdXQNCj4gPiA+IFZMQU4gaGFuZGxpbmcg
aW50byBzZXBhcmF0ZSBmdW5jdGlvbiBmZWNfZW5ldF9yeF92bGFuKCkNCj4gPiA+DQo+ID4gPiBJ
biBvcmRlciB0byBjbGVhbiB1cCBvZiB0aGUgVkxBTiBoYW5kbGluZywgZmFjdG9yIG91dCB0aGUg
VkxBTg0KPiA+ID4gaGFuZGxpbmcgaW50byBzZXBhcmF0ZSBmdW5jdGlvbiBmZWNfZW5ldF9yeF92
bGFuKCkuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyYyBLbGVpbmUtQnVkZGUgPG1r
bEBwZW5ndXRyb25peC5kZT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgMzINCj4gPiA+ICsrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS9mZWNfbWFpbi5jDQo+ID4gPiBpbmRleA0KPiA+ID4NCj4gZDk0MTVjN2MxNmNlYTNmYzNk
OTFlMTk4YzIxYWY5ZmU5ZTIxNzQ3ZS4uZTE0MDAwYmE4NTU4NmI5Y2Q3MzE1MWUNCj4gPiA+IDYy
OTI0YzNiNDU5N2JiNTgwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Zy
ZWVzY2FsZS9mZWNfbWFpbi5jDQo+ID4gPiBAQCAtMTY3Miw2ICsxNjcyLDIyIEBAIGZlY19lbmV0
X3J1bl94ZHAoc3RydWN0IGZlY19lbmV0X3ByaXZhdGUNCj4gKmZlcCwNCj4gPiA+IHN0cnVjdCBi
cGZfcHJvZyAqcHJvZywNCj4gPiA+ICAJcmV0dXJuIHJldDsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+
ID4gK3N0YXRpYyB2b2lkIGZlY19lbmV0X3J4X3ZsYW4oc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYs
IHN0cnVjdCBza19idWZmICpza2IpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3Qgdmxhbl9ldGho
ZHIgKnZsYW5faGVhZGVyID0gc2tiX3ZsYW5fZXRoX2hkcihza2IpOw0KPiA+DQo+ID4gV2h5IG5v
dCBtb3ZlIHZsYW5faGVhZGVyIGludG8gdGhlIGlmIHN0YXRlbWVudD8NCj4gDQo+IEkndmUgYW4g
dXBjb21pbmcgcGF0Y2ggdGhhdCBhZGRzIE5FVElGX0ZfSFdfVkxBTl9TVEFHX1JYIChhLmsuYS4N
Cj4gODAxLjJhZCwgUy1WTEFOKSBoYW5kbGluZyB0aGF0IGNoYW5nZXMgdGhpcyBmdW5jdGlvbi4N
Cj4gDQo+IE9uZSBodW5rIGxvb2tzIGxpa2UgdGhpcywgaXQgdXNlcyB0aGUgdmxhbl9oZWFkZXIg
b3V0c2lkZSBvZiB0aGUgaWY6DQo+IA0KDQpZb3UgY2FuIG1vdmUgdmFsbl9oZWFkZXIgb3V0IG9m
IHRoZSAnaWYnIHdoZW4gaXQgaGFwcGVucy4NCg0KPiBAQCAtMTY3NSwxNSArMTY3OCwxOSBAQCBm
ZWNfZW5ldF9ydW5feGRwKHN0cnVjdCBmZWNfZW5ldF9wcml2YXRlICpmZXAsDQo+IHN0cnVjdCBi
cGZfcHJvZyAqcHJvZywNCj4gIHN0YXRpYyB2b2lkIGZlY19lbmV0X3J4X3ZsYW4oc3RydWN0IG5l
dF9kZXZpY2UgKm5kZXYsIHN0cnVjdCBza19idWZmICpza2IpDQo+ICB7DQo+ICAgICAgICAgIHN0
cnVjdCB2bGFuX2V0aGhkciAqdmxhbl9oZWFkZXIgPSBza2Jfdmxhbl9ldGhfaGRyKHNrYik7DQo+
ICsgICAgICAgIF9fYmUxNiB2bGFuX3Byb3RvID0gdmxhbl9oZWFkZXItPmhfdmxhbl9wcm90bzsN
Cj4gDQo+IC0gICAgICAgIGlmIChuZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfSFdfVkxBTl9DVEFH
X1JYKSB7DQo+ICsgICAgICAgIGlmICgodmxhbl9wcm90byA9PSBodG9ucyhFVEhfUF84MDIxUSkg
JiYNCj4gKyAgICAgICAgICAgICBuZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfSFdfVkxBTl9DVEFH
X1JYKSB8fA0KPiArICAgICAgICAgICAgKHZsYW5fcHJvdG8gPT0gaHRvbnMoRVRIX1BfODAyMUFE
KSAmJg0KPiArICAgICAgICAgICAgIG5kZXYtPmZlYXR1cmVzICYgTkVUSUZfRl9IV19WTEFOX1NU
QUdfUlgpKSB7DQo+ICAgICAgICAgICAgICAgICAgLyogUHVzaCBhbmQgcmVtb3ZlIHRoZSB2bGFu
IHRhZyAqLw0KPiAgICAgICAgICAgICAgICAgIHUxNiB2bGFuX3RhZyA9IG50b2hzKHZsYW5faGVh
ZGVyLT5oX3ZsYW5fVENJKTsNCj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBl
bmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAg
ICAgfA0KPiBFbWJlZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBl
bmd1dHJvbml4LmRlIHwNCj4gVmVydHJldHVuZyBOw7xybmJlcmcgICAgICAgICAgICAgIHwgUGhv
bmU6ICs0OS01MTIxLTIwNjkxNy0xMjkgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEg
MjY4NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctOSAgIHwNCg==

