Return-Path: <netdev+bounces-139378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B149B1C5A
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 08:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44111C20AF7
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E552B39FD9;
	Sun, 27 Oct 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="InOvDXJd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD72905
	for <netdev@vger.kernel.org>; Sun, 27 Oct 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730014193; cv=fail; b=fPZwCGzxSJueA4/Cud6+DUzWENUSXK/rsyyYvlDaVCYvkQzpHrUOSWHI5lES+H3kIMTypcCVtmhWpZZTitwNyquef/ZEDx/Dt3hAKa41RA+0pnFyiTwWrva9gTSFYRBQ3X4p3nBkPxdbGKpOCjYdt/rq6s1KCKKcztQHp32uOCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730014193; c=relaxed/simple;
	bh=JT+wgTsjsOEkJIp+MK0KqWzKVaYnyS9cfkNF1TbIPzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mbSUzOzYvobM56eWDgVkRFGTkWqARR60y8uu8e75j/WnAPE8t2U23ZSSTp/lQmiGfA8dOhqz2LXLa62UYDfnv1+Iin9x4/sjuyR/cRO0YgL1HM3TkMM6O3KneVO1e5soVvMeLBcMX8Lb3zCxtxgaV9N0Dk7S3lt1jjbeMqVaPfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=InOvDXJd; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbICHZohfBXahxE3jqj8jbRWQ8ItDavE+GR9M+RRwKq9IIHVGv5UvuPxQ+92COuHNcjs1K3G44jcXBflxehIjlWsYH+MeaBRaMTKO0sPjOLfmrHo1WkfxCzUpYltHDEf59MuOsNIupRZoMacD6tNWHHnuQW5bTWyF+A4dW5rk8RHdYAApqwSb98JvJUiC4BxjoYIc4bnRzTjgtzfDZlDPNWwN5Pwwmd7evUTKMLUap6dT8ZKsZN0TvS36TLMKbUL+fAthDFbDFkEw4hinYv21PVuqqsYbPsv1stERYc11C8zmWGTtItrhRupR/ad5ebDCYDBzlDj+sKjeBIeeFxSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT+wgTsjsOEkJIp+MK0KqWzKVaYnyS9cfkNF1TbIPzI=;
 b=y+RFE7Zl6BCG8OtpS7UfBhT+2ya7FYBeOvP69CODN/X42Y81WsPiQQHSA/1wN3Jld2UuaEkY3jAcyl95IWwXmSvVoKlDDlGHzwxLyMxUQqHYcnNOJ63iXqwW/3QkvaRJC06817LKGrNCxFpxt0tYwnjJu9zEM7ciwmsLrkHUEAdwnJEaiEHXNv90QrV/YKEHtcSrjhL5pyOG22EdnXdMREc9ZIe3DMrr1g8Oz3P77/J0ps+vuejNR2yMujU102CeTuQj0zxOgZXfFDW2tnpTT+r/81quDT78yRcpVGbPHll7evfjFDMRjZ3VSHktVNzbVmQfyD6RxMYe2J9Jey3XhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT+wgTsjsOEkJIp+MK0KqWzKVaYnyS9cfkNF1TbIPzI=;
 b=InOvDXJdriOtxhg+D9nzetFK5q/kvqzvc+V7ordNN1PekR92VhNA4/nHKjHIxMG00IMb8rK8SFWbt6HOEDE8ZNms5+SORoAqJFAc6QPUBMUsjInT34UKlVxL9JixvaOVDIkZFmk9kRc+wJ/FetKWfRw4V7yMx42xKYBlpCDkSoHSqPI8uftt/jNxdCQdpdHEYIKThBSnsT0C25enuOkM6V5iKD8igJdKr9XKIYH/MeoSiSW1n/Ko0DF8BPsxBedHbqEMewOz+B79NKp6kqljxHhNnIZ3H5Y6hnlNac4SEgZvMYTj0mRuZs2LVwCD3+lBregwie4WJsAm/n8R7q0yFA==
Received: from BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sun, 27 Oct
 2024 07:29:48 +0000
Received: from BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858]) by BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858%4]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 07:29:48 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Petr Machata
	<petrm@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Danielle Ratson
	<danieller@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, mlxsw
	<mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: RE: [PATCH net 2/5] mlxsw: pci: Sync Rx buffers for CPU
Thread-Topic: [PATCH net 2/5] mlxsw: pci: Sync Rx buffers for CPU
Thread-Index: AQHbJun/nUGpfF7SqEiGNOogNuuH3LKXj2WAgAKlnkA=
Date: Sun, 27 Oct 2024 07:29:48 +0000
Message-ID:
 <BL1PR12MB592279200E7D9D923F989E31CB492@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <cover.1729866134.git.petrm@nvidia.com>
 <461486fac91755ca4e04c2068c102250026dcd0b.1729866134.git.petrm@nvidia.com>
 <151a8cbe-3b97-495d-849e-a5a2574c9457@intel.com>
In-Reply-To: <151a8cbe-3b97-495d-849e-a5a2574c9457@intel.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5922:EE_|DS7PR12MB5960:EE_
x-ms-office365-filtering-correlation-id: ffc6bb59-76ae-4aa5-520d-08dcf659232e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlRGUFZtNUM2ZW9WZWlyUzVCUFR6dEZqZkhSOTJTczQ5MDljSW9UNWg2cit5?=
 =?utf-8?B?cFpVSXQvSGZtVm9TSytsZHZ0SFlZekpYOTRDTGJBUkdZZzFTdVNtcEJJa2NK?=
 =?utf-8?B?a1lYZk5DVVpEZ0ZrZEs2VytLcTRQTXpiVEJLdlZ2NUFmTmtVWkk2ZXBCNTZm?=
 =?utf-8?B?NXJ6VXlmRVZOVlNldXBFRHlOWGkvME14SEh1QkdGSjB0Z1RvS0g5Y3JZdEZr?=
 =?utf-8?B?cE1KNlhHdGZ4dHpXTW83TjR0dEVnVE9EdkNxUmxTTEJVS0x1bTNXd2ZNN1Nx?=
 =?utf-8?B?ZGovZmJtb09uTkJERkwwLzE1bml3ZnM1ODFQUEoweXZ5d1lJZHhGMmpBbHkz?=
 =?utf-8?B?RTNJZmVBQ3hKU0lwSWdVSWlrbEFsNEhXSkliWEVoNlhLbEhQYkxBMUJ6VFdm?=
 =?utf-8?B?QjRsWTM2dHdWWDFDY1pSSU9OdXFVY0h4eUNrb3RrdXoxMUEzRkIxcFA3TXB0?=
 =?utf-8?B?N3FOSUU1cDZUVm1XT09kcDhRWFF3cXloOFZtQzcxOHJSbHorTTRVN1ZIbE45?=
 =?utf-8?B?K3hyc0t1VkFraXdzb1dZNVU0bVM1dnNGU1lxWjBMdjJSOGpIN3djWk1ielNK?=
 =?utf-8?B?dVhvRlIrMmlETkZnYVkrRlFIQXNXN0NEVEZVV1dGMFVuVTVhcmRJWnBzSVRQ?=
 =?utf-8?B?WWJCRnNqRjNUcDkvdGVyY1lyRGVYNWNCMlJjaWpNQTc0U0RyR3gwaFRLWDY5?=
 =?utf-8?B?TFpHTzZsMU5xVWswZU9mbG81a1pZYUVPNmNuczRIeUl5U2hYcU93QmlQWjJ2?=
 =?utf-8?B?Y1pvdjVrOHA2anNZVmt1b0U3UEU4cXlMS1ExclVBMHNtSGZGSlBmZktNTGJR?=
 =?utf-8?B?Rm5BT0YwTDE4SnR0c2t2aWVOcEdqMDdDUlJtdlpkL2tSc0Z6SVBJS2l5Q0JI?=
 =?utf-8?B?SXNSdG9YZVhGOEdDMjc1bkpkODZlMVBmWFJKWi9QSERKMTFwOWZTbFBTeEdK?=
 =?utf-8?B?aXA2SjJJT2ZhVmxGWEtiV2xkQlZyUmFNMUU4dERpdHJ5RkJHRUo2S1FYcFhs?=
 =?utf-8?B?TVNuN3pxd2dpcGtYTmZ2dGg2VThIbzFjcXVEdGJBNEQ5RmNMUzZSa3Z4S211?=
 =?utf-8?B?MG00NVV5Rjc2c0kya1A3V0lvaGo3RkUveUQvbURjYTRxODhpZkQ0Skt2dGk1?=
 =?utf-8?B?TjZOaTFaVFpnT0ttdjA0TU9xQmNVekxjdU1hYm1QWU05d2tuODJieUlFSmNh?=
 =?utf-8?B?emI0cGlKWEhCWlY0dFIwQVdQaDgzeFQrVVNpdWlCVlBSZDJPWVcxLzJFczJw?=
 =?utf-8?B?UUtDSmxxamIveEJmaWxWNEwvcFlYcndXTHRaYmo1SVhrblA3M3hnN3V3d3Np?=
 =?utf-8?B?QS93R3V6cWNNSEhrSzhtTlhPcVhoeFlvWWdsVVFpeVpZNkc0ZnFMNGd4Q2pG?=
 =?utf-8?B?b1lzelZ5Y1hNYU9kVDk2MkQ0MTB5Z2J6dExVeEt5ZDF1YWlDMzFqRWk3ZXBU?=
 =?utf-8?B?UVJBUXhkaC85TUdBaUdXSGFaUlRWMUtBR3V4TjEwc3J5S1ZSSzIwR3QzV0tu?=
 =?utf-8?B?RHpDRjdiYWZaTTBidURWVHFoVWE0UXZsUUMySklsbHU4S2xXOGhTVGljcWs3?=
 =?utf-8?B?bTR4SDJSL3ExUVZUWGtCaWtFbWhPV3dZUjlsbTJ2S2VNYWNkZkljN1NWcFhz?=
 =?utf-8?B?UmFFMUxoZlNyT24xV2JUMWViRnY3dkJlRW5sczhGR1RoRHhaYjU4UG1jbTdv?=
 =?utf-8?B?d3BtVVRxd0RsMktLcE1tWWZ5S2dOdWIwZG5aOFhaNXhlYTNROE1JaEp2cG5L?=
 =?utf-8?B?ODhLRm1ueldHZVNhOTVVWTlVSXd0Z0xkd0tCVUgvM2U4VlNKT3VRN1VqVHhi?=
 =?utf-8?Q?pJuqur9ZGIDiS31TNf0tPpQ4gOV1GHCwDYvz4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5922.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjEyTE5YR0FtWTVLaHZPNG9zUldYUGRoelhoSkdHZ1RiWWEyanRQNEw4L0Ft?=
 =?utf-8?B?ektuZWtiSnFscFpnVXZnOHluOE5VbXZtZmExWjRtUXM3L0IxdG8ranVvM1U1?=
 =?utf-8?B?elhOeW1oRjMzMG9ORTZVL1hyVFRjTHBKZEFmS2REc0liRVgvaW1mQTh3SnpZ?=
 =?utf-8?B?U0xwbFdCRVJoRmdRQXlsMmx6blVuelk2dThaaTJqVXBic2F2cjdLL1lLdnJv?=
 =?utf-8?B?VTROcWs4Z0ZzelJxMjAxMUMrajB5MlZMbEhKcnZpRWJpMUh4NE01Rk5Nb3Zw?=
 =?utf-8?B?Y2dBK1RycUtUYjdvZFgzUjNuWm4ralkveGRrTkp6RDZRRlVWcHZyUXJRSWFa?=
 =?utf-8?B?SFdSUkN5OE12MlRoVDJVN20vWmYxUmxKSEhLenBNa1cxWTVqYkJ1L3U2SnBr?=
 =?utf-8?B?WVhGQVhlb1hmNTRKNXZMSTFEbTN4akduSXdWNVphWjBtcWtCN3JGR0dWNkdl?=
 =?utf-8?B?NTRwRkk3MVNKREl3N2J2K0g0SC9Ob0dBNzhqbndMTmFFSHhGV2t4ZENwSDAr?=
 =?utf-8?B?YWNJYjFQWC8yREQxaUxTekVwdE9kNDExVkNLM2pKMUY1YWtKWTk4Sk5BL0Zy?=
 =?utf-8?B?WGJESWdNbUFuMDlURUVYWmg3bjBtZFhySkxqZGNicHd6QXhPbXBSRWI3Q3d3?=
 =?utf-8?B?WXdhSW1yc2NnZXVpN1ovMEsrdlJTTE9oTEhLczZidjRBV2oyU3c4a3BHT2s4?=
 =?utf-8?B?MjdnbEhpNGV4dXVtY1RVSzk1eEN3ZkZBcnQ3dkpDU1EyZmtxcXFTM0tOb2to?=
 =?utf-8?B?R2ZWYzZDcHZDRzlrR2xFUjIycTFzMDMvclp0N2hpaUhyOFVMQmxyMUUwbktk?=
 =?utf-8?B?R3QwV1I0ZlNSWkxtUWVTR1lPcHNDaTZOaTZqeXYvcCs4MWpUemV2elhVblNR?=
 =?utf-8?B?SEVpTVJZK29sckErdU8wOGRXNUVwdWd1dko4bjRLMXVhcC9Ddm5sOURRcks5?=
 =?utf-8?B?WjFFVVplUVpVOGhBTHJjUnJhbDd6MEtDYzBPVjd6T3pweitaOXhWdzZLeGNZ?=
 =?utf-8?B?VGo3Nnk3MjJJaEZnOE10R3MrdFM0WEJxWmlQaElKWE9TTEZIOWhoQW9JYmdE?=
 =?utf-8?B?anJRd3IxNE9SaGNSRnJBdFpKRHAvQzFtbjJJMy9BRyttdHdaKy91T0tNLzV4?=
 =?utf-8?B?NjdTUmpzK3BNK0c4V1pOcHFJdGZWc0V2MThNMUh4ZFhBcjJBd2lmai9Ra0FV?=
 =?utf-8?B?UzFCL1lRdTR5YUFSck9TUkU5aFFKclIzcUZHMU1Kay9VMDFVU0x4RkdjMSt5?=
 =?utf-8?B?TWQyM1lCTFJxTDZFOTM3dFBNM093ZGxtdEY3U2NUOEl5UmVmWEczdzdnN1hx?=
 =?utf-8?B?M05tNXFWOXZUd0tlMUZ5RHB5TUE4MXJkTGZjU0dzbzhkZjhWNVBUVzRKMklm?=
 =?utf-8?B?TmExZTZFcytBSFhvZUdXamo2eWxYVUpzQ3o3cFlIWS9PNG9FL2ZZZ2E0UXRs?=
 =?utf-8?B?NmVmRDFacUwySlY2V1dHaWdSUUo1bmQreTUzYnd3cXFuVkUrUCtYRk1lNnFY?=
 =?utf-8?B?dWhaSHZPZFVRMW8wWTU4dEEyQnFGRFV1citNNEd4MEp2aHNmQ1FLcm9WMFhi?=
 =?utf-8?B?YVlDdk41WjcxdFZxa3lDK0o0c0hoS0tXaU5uTzNtV2dwM0JvL2JLUmcyUjR4?=
 =?utf-8?B?Vy9WMGFkWiswYngyYUtpZDRvSEozY0tBd0hFQzhSMFMvVFBRYTZGUksrQ0Iw?=
 =?utf-8?B?cEVXaGFJelZKS3F3WkV6a2lpeFZlMm1Qa0cvOWV6ZzhKQzBWamhyV25EalRY?=
 =?utf-8?B?Q0VXK2pGVnhMUVU3Um5EbkcxMndIaXFsdG52aEJaWGtvcnUzWmExaU5iVU5Y?=
 =?utf-8?B?R05DVkc0V2IxaDI3Z3pTWVlMOTU3WDhNTUQyYStMZDR1Sjgyd0NwR3RrSCs2?=
 =?utf-8?B?b3RkaDNCTkY4U2VhS2NnbjcxaHdvcUdad3RGc3dhcXZsVXBZV1U5VDVzWlVt?=
 =?utf-8?B?NlgyNlJzQ3lvaFZwN1Y0N1I2TmFpQ2RBVy9PaDhjYUZYVDFyR2tpRTFhWUlH?=
 =?utf-8?B?RGdxcms0d2lIU0N4d2l4ZVBnZ3J3QXpvV1IyR1lCWVEzaWloSkNocmMxdElU?=
 =?utf-8?B?UHVaUDNzLzV4S2tDdWVLeit4c3dkT09FNUJLbWRPU1hUVWF6QjB5UnFrbVF5?=
 =?utf-8?Q?cv75keVbm+y8Ab/fbZzgokgr/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5922.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc6bb59-76ae-4aa5-520d-08dcf659232e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2024 07:29:48.2309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLC6mBw+NCoIc/1uHySMTcT8lr2HYayu7YE5nCnB33CeNfARxBXdpey59gYyUu+IRpnrcPyfIZGZMAlinqUtKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIExvYmFr
aW4gPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgMjUgT2N0
b2JlciAyMDI0IDE4OjAwDQo+IFRvOiBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+OyBB
bWl0IENvaGVuIDxhbWNvaGVuQG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVy
IDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUu
Y29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47DQo+IERhbmll
bGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+OyBJZG8gU2NoaW1tZWwgPGlkb3NjaEBu
dmlkaWEuY29tPjsgbWx4c3cgPG1seHN3QG52aWRpYS5jb20+OyBKaXJpIFBpcmtvIDxqaXJpQHJl
c251bGxpLnVzPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCAyLzVdIG1seHN3OiBwY2k6IFN5
bmMgUnggYnVmZmVycyBmb3IgQ1BVDQo+IA0KPiBGcm9tOiBQZXRyIE1hY2hhdGEgPHBldHJtQG52
aWRpYS5jb20+DQo+IERhdGU6IEZyaSwgMjUgT2N0IDIwMjQgMTY6MjY6MjYgKzAyMDANCj4gDQo+
ID4gRnJvbTogQW1pdCBDb2hlbiA8YW1jb2hlbkBudmlkaWEuY29tPg0KPiA+DQo+ID4gV2hlbiBS
eCBwYWNrZXQgaXMgcmVjZWl2ZWQsIGRyaXZlcnMgc2hvdWxkIHN5bmMgdGhlIHBhZ2VzIGZvciBD
UFUsIHRvDQo+ID4gZW5zdXJlIHRoZSBDUFUgcmVhZHMgdGhlIGRhdGEgd3JpdHRlbiBieSB0aGUg
ZGV2aWNlIGFuZCBub3Qgc3RhbGUNCj4gPiBkYXRhIGZyb20gaXRzIGNhY2hlLg0KPiANCj4gWy4u
Ll0NCj4gDQo+ID4gLXN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqbWx4c3dfcGNpX3JkcV9idWlsZF9z
a2Ioc3RydWN0IHBhZ2UgKnBhZ2VzW10sDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqbWx4
c3dfcGNpX3JkcV9idWlsZF9za2Ioc3RydWN0IG1seHN3X3BjaV9xdWV1ZSAqcSwNCj4gPiArCQkJ
CQkgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2VzW10sDQo+ID4gIAkJCQkJICAgICAgIHUxNiBieXRl
X2NvdW50KQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3QgbWx4c3dfcGNpX3F1ZXVlICpjcSA9IHEtPnUu
cmRxLmNxOw0KPiA+ICAJdW5zaWduZWQgaW50IGxpbmVhcl9kYXRhX3NpemU7DQo+ID4gKwlzdHJ1
Y3QgcGFnZV9wb29sICpwYWdlX3Bvb2w7DQo+ID4gIAlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+
ICAJaW50IHBhZ2VfaW5kZXggPSAwOw0KPiA+ICAJYm9vbCBsaW5lYXJfb25seTsNCj4gPiAgCXZv
aWQgKmRhdGE7DQo+ID4NCj4gPiArCWxpbmVhcl9vbmx5ID0gYnl0ZV9jb3VudCArIE1MWFNXX1BD
SV9SWF9CVUZfU1dfT1ZFUkhFQUQgPD0gUEFHRV9TSVpFOw0KPiA+ICsJbGluZWFyX2RhdGFfc2l6
ZSA9IGxpbmVhcl9vbmx5ID8gYnl0ZV9jb3VudCA6DQo+ID4gKwkJCQkJIFBBR0VfU0laRSAtDQo+
ID4gKwkJCQkJIE1MWFNXX1BDSV9SWF9CVUZfU1dfT1ZFUkhFQUQ7DQo+IA0KPiBNYXliZSByZWZv
cm1hdCB0aGUgbGluZSB3aGlsZSBhdCBpdD8NCj4gDQo+IAlsaW5lYXJfZGF0YV9zaXplID0gbGlu
ZWFyX29ubHkgPyBieXRlX2NvdW50IDoNCj4gCQkJICAgUEFHRV9TSVpFIC0gTUxYU1dfUENJX1JY
X0JVRl9TV19PVkVSSEVBRDsNCj4gDQo+ID4gKw0KPiA+ICsJcGFnZV9wb29sID0gY3EtPnUuY3Eu
cGFnZV9wb29sOw0KPiA+ICsJcGFnZV9wb29sX2RtYV9zeW5jX2Zvcl9jcHUocGFnZV9wb29sLCBw
YWdlc1twYWdlX2luZGV4XSwNCj4gPiArCQkJCSAgIE1MWFNXX1BDSV9TS0JfSEVBRFJPT00sIGxp
bmVhcl9kYXRhX3NpemUpOw0KPiANCj4gcGFnZV9wb29sX2RtYV9zeW5jX2Zvcl9jcHUoKSBhbHJl
YWR5IHNraXBzIHRoZSBoZWFkcm9vbToNCj4gDQo+IAlkbWFfc3luY19zaW5nbGVfcmFuZ2VfZm9y
X2NwdShwb29sLT5wLmRldiwNCj4gCQkJCSAgICAgIG9mZnNldCArIHBvb2wtPnAub2Zmc2V0LCAu
Li4NCj4gDQo+IFNpbmNlIHlvdXIgcG9vbC0+cC5vZmZzZXQgaXMgTUxYU1dfUENJX1NLQl9IRUFE
Uk9PTSwgSSBiZWxpZXZlIHlvdSBuZWVkDQo+IHRvIHBhc3MgMCBoZXJlLg0KDQpPdXIgcG9vbC0+
cC5vZmZzZXQgaXMgemVyby4NCldlIHVzZSB0aGUgcGFnZSBwb29sIHRvIGFsbG9jYXRlIGJ1ZmZl
cnMgZm9yIHNjYXR0ZXIvZ2F0aGVyIGVudHJpZXMuDQpPbmx5IHRoZSBmaXJzdCBlbnRyeSBzYXZl
cyBoZWFkcm9vbSBmb3Igc29mdHdhcmUgdXNhZ2UsIHNvIG9ubHkgZm9yIHRoZSBmaXJzdCBidWZm
ZXIgb2YgdGhlIHBhY2tldCB3ZSBwYXNzIGhlYWRyb29tIHRvIHBhZ2VfcG9vbF9kbWFfc3luY19m
b3JfY3B1KCkuIA0KDQo+IA0KPiA+ICsNCj4gPiAgCWRhdGEgPSBwYWdlX2FkZHJlc3MocGFnZXNb
cGFnZV9pbmRleF0pOw0KPiA+ICAJbmV0X3ByZWZldGNoKGRhdGEpOw0KPiANCj4gVGhhbmtzLA0K
PiBPbGVrDQo=

