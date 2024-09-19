Return-Path: <netdev+bounces-129021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C98D97CF50
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3429E28368B
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D819ABAF;
	Thu, 19 Sep 2024 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="DMgqWz+z"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3B482CD
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726786444; cv=fail; b=CwDqHjPwoxnbHd2tDMBvC3euaRQxO+J74BTGwh/LdsLy42dDHPp/FNRApFRqi1JvKncDUO66G7s6w95thz2KxJWJs5GLYEIPX8yznLPBFM1TTaLMg74K800mrjAWEgWDm9w1JAuUAF8vmuW9f1pxltGH7DXZ5KQNzVobc0GI1yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726786444; c=relaxed/simple;
	bh=t4QbSWOplKWXCxPCfRMV8i1bC759lK/uOSXFXoJGZDU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I7bn+AtCeZlBhDEDRtNOaUW+0gihIRbkT8N2F7JQ5bAI7UUmEEcBs1FI7cpp1WMxYVdCGw0oSX/qlJly3VsfAVo8zDJdya6cfPPLBMQJvYv2X0qM1tJT9j/NoYRfj/COkJOCGP1EjT5ItylHc/1EAgb+7vz+3kxO7szRkAQHQMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=DMgqWz+z; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JH3HHJ024033;
	Thu, 19 Sep 2024 22:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pps0720;
	 bh=t4QbSWOplKWXCxPCfRMV8i1bC759lK/uOSXFXoJGZDU=; b=DMgqWz+zDW66
	j51Q3epYxOFEMY/xpJxHNA78gGnC7Y36Smf2hWvudbuTttm6EYC2NRxZSePA3tmG
	nT7J++mViIh2LvmuvFZcqrAs3QYPcFIGiSoATU+AIVDEp8KO67Ii6dx00Sl4+6Mk
	0ifeTMzhZ8bP3JU4hd6qCz0+8blTgsmV3pk+hS2udx/OfAm4zpSiaqBtTBTU/yEg
	esiFqIhEob7m3r0V5DDf/+0ptAMsSdDegx2llwp8Knsn14p+9Z9S7oqwdv5bsGkq
	ZVRHoZPOc6xB9toS/dBSKyWj3cHbulxTKFidm05anYzl8OD1U9WotSKuaIV6al7V
	symoxABD/A==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 41rr14jdy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 22:53:45 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3D257295C6;
	Thu, 19 Sep 2024 22:53:44 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 19 Sep 2024 10:53:12 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 19 Sep 2024 10:53:10 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 19 Sep 2024 10:53:06 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIWqvJSpEc7v+ybbCO9WUQf3inzOYT/M5ytI+l2W3cLehceziT+1+BULmhhNR/m3y0CD4UqQ260EvJYOtc2FMXeza02kbB7ICcRo7+86Xy1pSRXLcPyILh5ovRdPOKJn2U4MVw3u1fJiuBFsrJ3Qy2g572frjJ/53KYUokbNAcN+TgRBfj7D+wxGNUgEash2oQ2o5znAV4YzOcEyUT5enWC3aT7bACYhCSXZRE267gaVbAdZ0oDEYs7XGfC/DfoFQBUPIe21axna654aw9LMyWV4BsHpVoZ/Lmq1D/PbpjQg/32FgzNJswWEAq0Nui2JUfndDOCWpoEowWItMzqjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4QbSWOplKWXCxPCfRMV8i1bC759lK/uOSXFXoJGZDU=;
 b=Dw8ns6k+o/kKSnN31l5bvSX/3vPgHXzpYlXv8iuGX0yoK4hmkmfHXb6mDNwYZsvRw+VV3oz9ru9RjO0cgXwSAkzPrHPCPBVrTWfHIc+QfySQTZz2KMlRsVFoVRKl+1PA0hQ3hNEPfEPE/FBtqrd5A4xiojn6OZ2qUpXTXM7PHt5farxJ2CapMTaRWlsiUrdpwnf9Q3ssst5sZ8bPgwKtUhINKh75zIif9TJKREdkSRDRXqs1ZL9UtjdfLkeiqv2FUuFL3MzGungLYiTWw0fPAUgqtGin9womGT2gWXHVSjWRGJh43hdSjHGkpT7ImZRKkTLijRwjzdy1HV44brZGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by CH3PR84MB3469.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:53:04 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 22:53:04 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@kernel.org"
	<dsahern@kernel.org>
Subject: RE: Submitted a patch, got error "Patch does not apply to net-next-0"
Thread-Topic: Submitted a patch, got error "Patch does not apply to
 net-next-0"
Thread-Index: AdsKN4cQPqFaBe0nSyiFGCTE3NqYjQAIUVQAAB1TxaAAAhvngAAD5tCg
Date: Thu, 19 Sep 2024 22:53:04 +0000
Message-ID: <SJ0PR84MB208867DD3FAFA15BE65A5640D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <2a39433c-3448-4375-9d69-6067e833d988@gmail.com>
 <PH0PR84MB2073021945EE35CCD20FAF33D8632@PH0PR84MB2073.NAMPRD84.PROD.OUTLOOK.COM>
 <3efb28df-e8e2-48e2-b80d-583ade67eefb@gmail.com>
In-Reply-To: <3efb28df-e8e2-48e2-b80d-583ade67eefb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|CH3PR84MB3469:EE_
x-ms-office365-filtering-correlation-id: db968392-cca5-4f62-47a4-08dcd8fdd25c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REhuVkUwTnZqa0xxbUhrbjltaEFWcXZwcVV5c2RxVlkxbnNXeldRb2JicHdT?=
 =?utf-8?B?cXovMUVqTDBpUGNXZ3NrQzJDc0FuS2p6TVVXNCsxSXE1V3RManE0MGJmTWpp?=
 =?utf-8?B?eXZqWTBvb05JNTNjVUhsUXM2ekFKUklYcmpXMFZ0Y0NQcmZTOXh6ckpnTzJm?=
 =?utf-8?B?elRjWk1nNGppUUEzQTVNTEF4VXR2R0VqSlkzbnJtQ3VZYUZEcUFNNzI1c1ZH?=
 =?utf-8?B?QkhHOGF0U0JQVmJHemphTjhCTEVsT3VCWk9yUGNkdmwreVBMQjVBUTJjWFAv?=
 =?utf-8?B?SElaVXl5Mi9mbEt1REVPYWFWQjVsbytqOWN1MUVRMFl6bUpPNFEyVlZLbHh1?=
 =?utf-8?B?ZkY4WlVoVzVCRTEraE1WcG15RlFQYlgzVkhOM1p3Wm1Yb3VuVnpOUGxjNy8v?=
 =?utf-8?B?cythYzRIcFcxQVh4Y1QrRTd5Q2ZyZ3dxMDJZeU1UMFVKWFh2aXVkUmdkYWpq?=
 =?utf-8?B?TmUyOU1BUnVPdlNlUDQwcFROM2ZtSEhGK3ZNVjNpK0x0Q0NSUFMybHovRmwr?=
 =?utf-8?B?dEc3WXlOSHFCY1NLS0VFVE10UWEvd0wxUksvTGo5bnptOXRZSE9abXl5YUpx?=
 =?utf-8?B?OGYzVjRBcHpTVTY1RStaWVdac3BtV2hhaXpDL3VMeFdxL0xyK3VrNWVCNkw5?=
 =?utf-8?B?aFdLdGMwQzlnYWQybmtwMDdPT0s1dk80UE5BNmduS0ZoMFBuK2tUNGdUbjhj?=
 =?utf-8?B?OHRaNk8yY2dZMGxEWGZJRDJVNVdTK2Z6NjB2bjNFbTEyNDFOaFd1SHFtQlVW?=
 =?utf-8?B?dHYxK2hvdEFNT01Tenc2RGo2VjA0Q3hxRmlPSUhSa21RU0RITjZUNEsyV3Jk?=
 =?utf-8?B?ZmI3MmhhbndxTUh1aWJodHZxa1F5a1N4THI5UmREa3lkdGlkYlp4dmFxY2tP?=
 =?utf-8?B?T2NmZjVoVjlsNy9FQVVUTEpyTm1vVDFIUGU2QlNFU01lQ2RuL0ZSRlMydm40?=
 =?utf-8?B?eVkrTlFWV1d0ZXo2L1A3aWhwb3EwSUE1MXIrWDl2a1lwa3FpL0pZYW1XWGo4?=
 =?utf-8?B?dUNCdC8veTNuT2ovTjlDN3lvMG9pK3BKaG11UktQMmdiUEo3SGREbGRhZm04?=
 =?utf-8?B?YjRJajhXc2grOTZFUTVKM0RYVHJSOXZ1VUY4NnNVYTRaRVdkMGg0OEtDNWVJ?=
 =?utf-8?B?RlBVMStrVHJlaXFZL0lPc2lOaG5URENqN0NMbW4vV0NWa21INTAzUWhaZ1Qy?=
 =?utf-8?B?Y0JLVHhjLzBpcm50bW92cWtwVFVYNS9pZzRXM1YrQUlUbDdvODBUVEdQdHBF?=
 =?utf-8?B?K3JhMWlKNFpSd3pTdlVRQ1RPRWsxcGdjMC9XWXg1dWlqZ01QVlJoWnVFRG1k?=
 =?utf-8?B?Sm5hKzlVUG9RZk5HdU5LaWI5OUdTMWFoVGVYVytFbWQrSUdvV0xmWWY0QzJX?=
 =?utf-8?B?eFIzNDVqV25wR2tub0JRTGJhVi9KOWRLRXd2V0Fxa2ZIT2ErSkV3VlYwQVVz?=
 =?utf-8?B?YkUxdmpMbEl6UDZJQXZYT3BQank0ckY4YlB0MWU1YXhNalpYa2Vhd2hrZHBx?=
 =?utf-8?B?Z0ZDaEwvTkl3Q2JqNElVeDdGNDZVZGNPV0o4UXE1L3BnRUc1NXlFMFNiSllP?=
 =?utf-8?B?ekhKb3RsdnpsNDg0TXVRdWswbmRib2RaVFZMS3pCRDBmWVNqc0FjbS9uRkhq?=
 =?utf-8?B?WTVQNnovU01EdFdkWmUzMWVpRExrWXUwbSt2NTFYUTZjNnRiTU1FZEVjbDhv?=
 =?utf-8?B?Um5mdlNGblorYkVNV2FWUy9YTWhpcGY3WTE4N3VaZmlIM3I2RlI5VUxuaFE2?=
 =?utf-8?B?T0MybHF0REZxT3oreWVHSDRzWWM3VVZUclhiOGYzNXVVZU04Q28xNkIyNU1U?=
 =?utf-8?B?VG8vTVdOZkJFVjdmbWFLZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUI4ZjdlMzloN1VqbVhoU3NNSXh1STRjWG9XZGV1VGZRcUtSY05KNml6Nzdl?=
 =?utf-8?B?TGR4MkR4T1d4MytMNG5tb2tQZmEydTlPSzFuUUZMcTArOTNKR3F4YmVqNCsw?=
 =?utf-8?B?anA4ZDRlVkl2aGkxQVJnNk5nb2txV0JxTmRBYU5oeWRWdzRlRnhldFVQUGU5?=
 =?utf-8?B?aVhxTEl3c3FhQXcxelM4bHR6NkVEcmpaazVYRGxmL1Q0OWt2OTNBc2FOSmhz?=
 =?utf-8?B?dkgrWUZtR0c1L0MreVZseVFoM3FZdXZiR2lMMzdBSnQwMGlJaXZtd0IxSGtB?=
 =?utf-8?B?ME0za0lvQWNVR09vVU0vZkkzbjcxaDRSSG1xOFQ5YURldFhzSG1PNXlRd295?=
 =?utf-8?B?NmRrWHZlaE9hckFoNFBRbWIzekpabis2MXRlQ0ZhOUpRU3hVVzdxdlVlbStn?=
 =?utf-8?B?Q1VtVldGZHFmekkvQk9aZk5HUDRhcVRCNlBXR3pTelhWR2RYalBYMDNjaGNJ?=
 =?utf-8?B?aDBUbFFUL0JhRi9odlI0dzlxTmw0Y2FwMnEzY3NjU2Y2QlV6WUNhRDVwOHl5?=
 =?utf-8?B?L2tEUjExbHMzWFQxWnMzcmdEbWdieGRWODFwNldLS3Q1a004VjZTZXdhWXF0?=
 =?utf-8?B?c2hMRlRCQkRZZkpZUzU0VThHQXpydGc4RDJFUzV1OG5aR0t4MFdqS3NtUGxI?=
 =?utf-8?B?VG1NeHZBclRGaHg5MFNBeTZleXFXM2VraklaNjFHZkhXYlFYUDBuTm55WE9V?=
 =?utf-8?B?UWZlRUhVczR2cFdJZ0NidThrbjNnMlBSWDJCaU54U3pyRTNvVjVnMW5zb296?=
 =?utf-8?B?dGVpaHRvRGxhUGhQUkhxeFRiNUYvSG50b3U1dHc3ZDJVdWtSR2dpcVJyM0Z2?=
 =?utf-8?B?UlFaM0YydkhwRDBqelk1QkVkR25GVnd6eVpYYzBsWmN4WmpROTFPd0R3VHZO?=
 =?utf-8?B?V2RGcVdtaVVxT1NMaFo3YjkrVG56dldsYUJmdnBBYkRHTWZJR2o0TDUrcm4w?=
 =?utf-8?B?ZytWTlJsUFkzTVVjcGNnaHFpd29kL3lETkhpV1p2eDdkTm9tRHA1amlDYUxv?=
 =?utf-8?B?TXV4WGJjR3Rmb1EzRkNSTFdPRTZzdUljc0xqUkt3dGNENmRTWU91dG5sUGwr?=
 =?utf-8?B?WlBnZElaSEpsbXBtQ1RzYkMycDJwbE1MdElkQVBXZDJHMDRsajdPSDJhQWtD?=
 =?utf-8?B?QW5Pb21VR2xrOGhQYWlMWlhxY1Y5K2s4ZzZVbm93V2Rad3RiYk1GUlRaOFpE?=
 =?utf-8?B?WXdWMnBSQmE1bXV1eUsyMGhaTUQ1S2FHSU1mYklEN3l4TnhvTllKd0RDdG1R?=
 =?utf-8?B?ZU1SOHBCaXFhd2NTa2NObkhSMUQ5d3oxN1ZoNENrd1ZmNkJDMDZFTFB2Tzlu?=
 =?utf-8?B?VWg1a3htNkFLWE53WEdxZmUrZzFNbHRYem1BMjFzaWc3cjg5T0tkQkU3bTZP?=
 =?utf-8?B?cERjTVVTOWJoaEFuNmlicTlCdzVRbUhHdlczZFovZHVJa3hZVTZtQmJDaGxK?=
 =?utf-8?B?QkU5ejg2WHc1MXRtZGNvK0t2d0lRL1lxYzd4NW1ob1lYWFYrMEdBeUVnMjcx?=
 =?utf-8?B?MEVsQU1Wcmc4K3ZXOUk4allaaThHd3dmTllZZVBxQ2xpZFhnVlhBM0lKUThE?=
 =?utf-8?B?dTFpZU80WjVZRWN2cDAySG1SelhRL0k2UkhXRk53N0xnTEc5OU9DZDUyNjhr?=
 =?utf-8?B?VmtBMjVIWjRRdGdMNStESy9wNTB6YVpLYXZ3NTQvU0lSRU16eHVGSVlxV3Rx?=
 =?utf-8?B?YzVxbGRIT2ljMnRNbm05VWg0bEtWRkN5RFJYNEV3RnVwMmtsMzdHcnppdkJG?=
 =?utf-8?B?eXUzNEFodTRoZm5Bbll6M2FGSmY2dElZRmgwaGxxTkgvTXVoZWJtbisrdVhV?=
 =?utf-8?B?SlpQM1cxZ0xjR1dmV2Jxd29yOWZ2dGJHUHlPMzBlY3lUbnN1YkpRazFibW9R?=
 =?utf-8?B?QmhLb1lmUFVKWmxiek9MN3pqa1NRZHhVVzNKMTE1QjYwcThXQ01ELzFHaktk?=
 =?utf-8?B?cmRJUDB3MEYxaXlkRVArTEtOeEl3TndQR0FxZDhyc2JDSjZ0bEhtK1p2d3Bs?=
 =?utf-8?B?NWRsY2FyOFRYazlIUWpmSFQxTW5EYXFldGo1Sm9BQ2ZwUGNCRk1WSjZ1RGJs?=
 =?utf-8?B?Q21MRWtlZGh0Qm9ibksySytKNUdHU1BQa2c1dzFtVUtYUjNrdmduaUZBRHFH?=
 =?utf-8?Q?7n3CDhSQj0pcOgtMrdPO//fSk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: db968392-cca5-4f62-47a4-08dcd8fdd25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 22:53:04.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XAa18VTURHVhKM7hIXe4ZkGmjQzVvWjb6jKI3Sl77NHgMkhHOy56es+9TvQr9VKL0BAb8ZNvvWSaqYa9fX5Sdg/mJH3+n9LSejW4+g55TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3469
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: sJEwgaDjz0iC36UqR0UFujTn9IzhNfoo
X-Proofpoint-ORIG-GUID: sJEwgaDjz0iC36UqR0UFujTn9IzhNfoo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_22,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190153

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhr
YWxsd2VpdDFAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIDIwIFNlcHRlbWJlciAyMDI0IDY6
NTggQU0NCj4gVG86IE11Z2dlcmlkZ2UsIE1hdHQgPG1hdHQubXVnZ2VyaWRnZTJAaHBlLmNvbT47
DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFN1Ym1pdHRlZCBhIHBh
dGNoLCBnb3QgZXJyb3IgIlBhdGNoIGRvZXMgbm90IGFwcGx5IHRvIG5ldC1uZXh0LTAiDQo+IA0K
PiBPbiAxOS4wOS4yMDI0IDIyOjMwLCBNdWdnZXJpZGdlLCBNYXR0IHdyb3RlOg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBIZWluZXIgS2FsbHdlaXQgPGhrYWxs
d2VpdDFAZ21haWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgMTkgU2VwdGVtYmVyIDIwMjQg
Mzo1NyBQTQ0KPiA+PiBUbzogTXVnZ2VyaWRnZSwgTWF0dCA8bWF0dC5tdWdnZXJpZGdlMkBocGUu
Y29tPjsNCj4gPj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogU3Vi
bWl0dGVkIGEgcGF0Y2gsIGdvdCBlcnJvciAiUGF0Y2ggZG9lcyBub3QgYXBwbHkgdG8gbmV0LW5l
eHQtDQo+IDAiDQo+ID4+DQo+ID4NCj4gPiBUaGFua3lvdSBmb3IgeW91ciBkZXRhaWxlZCBhbmQg
Y29uc2lkZXJhdGUgcmVwbHksIEhlaW5lci4gQXMgYSBuZXcNCj4gc3VibWl0dGVyLCBJIHdhcyB0
cnlpbmcgaGFyZCB0byBjb21wbHkgd2l0aCBhbGwgdGhlIGRvY3VtZW50ZWQgcHJvY2Vzcy4NCj4g
Pg0KPiA+PiBPbiAxOS4wOS4yMDI0IDA0OjIzLCBNdWdnZXJpZGdlLCBNYXR0IHdyb3RlOg0KPiA+
Pj4gSGksDQo+ID4+Pg0KPiA+Pj4gRmlyc3QgdGltZSBzdWJtaXR0ZXIgYW5kIGl0IHNlZW1zIEkg
ZGlkIHNvbWV0aGluZyB3cm9uZywgYXMgSSBnb3QNCj4gPj4+IHRoZSBlcnJvcg0KPiA+PiAiUGF0
Y2ggZG9lcyBub3QgYXBwbHkgdG8gbmV0LW5leHQtMCIuIEkgc3VzcGVjdGVkIGl0IHdhcyBjb21w
bGFpbmluZw0KPiA+PiBhYm91dCBhIG1pc3NpbmcgZW5kLW9mLWxpbmUsIHNvIEkgcmVzdWJtaXR0
ZWQgYW5kIGdldCB0aGUgZXJyb3INCj4gPj4gIlBhdGNoIGRvZXMgbm90IGFwcGx5IHRvIG5ldC1u
ZXh0LTEiLiBTbyBub3cgSSdtIHVuc3VyZSBob3cgdG8gY29ycmVjdA0KPiB0aGlzLg0KPiA+Pj4N
Cj4gPj4+IE15IHBhdGNoIGlzOiBOZXRsaW5rIGZsYWcgZm9yIGNyZWF0aW5nIElQdjYgRGVmYXVs
dCBSb3V0ZXMNCj4gPj4NCj4gKGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9u
ZXRkZXZicGYvcGF0Y2gvU0owUFI4NE1CMjA4OEIxDQo+ID4+DQo+IEI5M0M3NUE0QUFDNUI5MDQ5
MEQ4NjMyQFNKMFBSODRNQjIwODguTkFNUFJEODQuUFJPRC5PVVRMTw0KPiA+PiBPSy5DT00vKS4N
Cj4gPj4+DQo+ID4+PiBJIGZvbGxvd2VkIHRoZSBpbnN0cnVjdGlvbnMgYXQNCj4gPj4gaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NS4xMi9uZXR3b3JraW5nL25ldGRldi1GQVEuaHRt
bC4NCj4gPj4+DQo+ID4+PiBIZXJlJ3MgbXkgbG9jYWwgcmVwbzoNCj4gPj4+DQo+ID4+PiAkIGdp
dCByZW1vdGUgLXYNCj4gPj4+IG9yaWdpbg0KPiA+Pj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25ldC1uZXh0LmdpdA0KPiA+Pj4gKGZldGNo
KSBvcmlnaW4NCj4gPj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L25ldGRldi9uZXQtbmV4dC5naXQNCj4gPj4+IChwdXNoKQ0KPiA+Pj4NCj4gPj4+IEFm
dGVyIGNvbW1pdHRpbmcgbXkgY2hhbmdlcywgSSByYW46DQo+ID4+Pg0KPiA+Pj4gJCBnaXQgZm9y
bWF0LXBhdGNoIC0tc3ViamVjdC1wcmVmaXg9J1BBVENIIG5ldC1uZXh0JyAtMSA5NWM2ZTVjODk4
ZDMNCj4gPj4+DQo+ID4+PiBJdCBwcm9kdWNlZCB0aGUgZmlsZSAiMDAwMS1OZXRsaW5rLWZsYWct
Zm9yLWNyZWF0aW5nLUlQdjYtRGVmYXVsdC0NCj4gPj4gUm91dGVzLnBhdGNoIi4gIEkgZW1haWxl
ZCB0aGUgY29udGVudHMgb2YgdGhhdCBmaWxlIHRvIHRoaXMgbGlzdC4NCj4gPj4+DQo+ID4+PiBI
b3cgZG8gSSBjb3JyZWN0IHRoaXM/DQo+ID4+Pg0KPiA+Pj4gVGhhbmtzLA0KPiA+Pj4gTWF0dC4N
Cj4gPj4+DQo+ID4+Pg0KPiA+PiBUaGVyZSdzIGZldyBpc3N1ZXMgd2l0aCB5b3VyIHN1Ym1pc3Np
b246DQo+ID4+IC0gbmV0LW5leHQgaXMgY2xvc2VkIGN1cnJlbnRseS4gVGhlcmUncyBhIHNlY3Rp
b24gaW4gdGhlIEZBUQ0KPiA+PiBleHBsYWluaW5nIHdoZW4gYW5kIHdoeSBpdCdzIGNsb3NlZC4N
Cj4gPg0KPiA+IFRvIGNsYXJpZnksIGRvIEkgd2FpdCBmb3IgdGhlICJyYzEiIHRhZyBiZWZvcmUg
c3VibWl0dGluZz8NCj4gPg0KPiBJdCB3aWxsIGJlIGFubm91bmNlZCBvbiB0aGUgbmV0ZGV2IGxp
c3Qgd2hlbiBuZXQtbmV4dCBvcGVucyBhZ2Fpbi4NCj4gSWYgdGhpcyBzb3VuZHMgdG9vIGN1bWJl
cnNvbWUsIHlvdSBjYW4gY2hlY2sgdGhlIG5ldC1uZXh0IHN0YXR1cyBoZXJlOg0KPiBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsuaG9wdG8ub3JnL25ldC0NCj4g
bmV4dC5odG1sX187ISFOcHhSIWtQSmozeGlNWmtEY3o0Qy0NCj4gR3RqR3Y3ZE5tMXRWNnY2YmFR
dnNFNmpJYVhhdXhvYXN3aW9ZdHIzNWd0QW5JVlB6U044S1VXMFkxMHdlTHMNCj4gOW1FU3FjazhZ
JA0KPiANCj4gPiBGV0lXLCBJIHJlYWQgdGhhdCBzZWN0aW9uLCBleGFtaW5lZCB0aGUgdG9ydmFs
ZHMgZ2l0IHJlcG8gYW5kIHNhdyB0aGF0DQo+ID4gaXQgaGFkIGNyZWF0ZWQgYSB0YWcgZm9yIHY2
LjExLiBJIHByZXN1bWVkIHRoYXQgbWVhbnQgdGhhdCA2LjExIGlzDQo+ID4gY2xvc2VkIGFuZCB0
aGUgdHJlZSB3YXMgb3BlbiBmb3IgNi4xMiB3b3JrLiBJIGFsc28gbm90ZWQgdGhlcmUgd2VyZQ0K
PiA+IG90aGVyIG5ldC1uZXh0IHN1Ym1pc3Npb25zIGFuZCB0b29rIHRoYXQgYXMgZnVydGhlciBl
dmlkZW5jZSB0aGUgdHJlZQ0KPiA+IHdhcyBvcGVuLiBBbHNvLCB0aGUgdG9wLW9mLXRyZWUgaGFz
IHRoaXMgY29tbWl0IG1lc3NhZ2UsIHdoaWNoIEkgdG9vaw0KPiA+IGFzIGV2aWRlbmNlIHRoYXQg
Ni4xMiB3YXMgb3BlbjoNCj4gPg0KPiA+IE1lcmdlIHRhZyAnbmV0LW5leHQtNi4xMicgb2YNCj4g
PiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25l
dC1uZXh0DQo+ID4+IC0gUGxlYXNlIG9ubHkgb25lIHZlcnNpb24gb2YgYSBwYXRjaCBwZXIgZGF5
DQo+ID4NCj4gPiBVbmRlcnN0b29kLg0KPiA+DQo+ID4+IC0gWW91ciBjb21taXQgbWVzc2FnZSBz
dGF0ZXMgdGhhdCB0aGUgcGF0Y2ggZml4ZXMgc29tZXRoaW5nLiBTbyB5b3UNCj4gPj4gc2hvdWxk
IGFkZCBhIEZpeGVzIHRhZy4NCj4gPg0KPiA+IE15IHBhdGNoIGlzIGluIGEgYml0IG9mIGEgZ3Jl
eSBhcmVhLiBTb21lIHdvdWxkIGNhbGwgaXQgYSBidWcgZml4LA0KPiA+IG90aGVycyB3b3VsZCBj
YWxsIGl0IG5ldyBmdW5jdGlvbmFsaXR5LiBNeSBwYXRjaCBleHRlbmRzIHRoZSBuZXRsaW5rDQo+
ID4gQVBJIHdpdGggc29tZSBmdW5jdGlvbmFsaXR5IHRoYXQgaGFzIHByZXZpb3VzbHkgYmVlbiBv
dmVybG9va2VkLg0KPiA+IEluZGVlZCwgd2hlbiB0aGVyZSBhcmUgbXVsdGlwbGUgZGVmYXVsdCBy
b3V0ZXJzIGluIGFuIElQdjYgbmV0d29yayBpdA0KPiA+IGlzIGV4cGVjdGVkIHRvIHByb3ZpZGUg
cmVzaWxpZW5jeSBpbiB0aGUgZXZlbnQgYSByb3V0ZXIgYmVjb21lcw0KPiA+IHVucmVhY2hhYmxl
LiBJbnN0ZWFkLCB3aGVuIHVzaW5nIHN5c3RlbWQtbmV0d29ya2QgYXMgdGhlIG5ldHdvcmsNCj4g
PiBtYW5hZ2VyIHlvdSBnZXQgaW5zdGFiaWxpdHksIHdoZXJlIHNvbWUgY29ubmVjdGlvbnMgd2ls
bCBmYWlsIGFuZA0KPiA+IG90aGVycyBjYW4gc3VjY2VlZC4gU28sIGl0IGZpeGVzIGEgbmV0d29y
ayBpbmZyYXN0cnVjdHVyZSBwcm9ibGVtIGZvcg0KPiA+IHN5c3RlbWQtIG5ldHdvcmtkIGJ5IGV4
dGVuZGluZyB0aGUgbmV0bGluayBBUEkgd2l0aCBhIG5ldyBmbGFnLg0KPiA+DQo+ID4gSSdtIGhh
cHB5IHRvIGJlIGd1aWRlZCBvbiB0aGlzLiBXb3VsZCB5b3UgbGlrZSB0byBzZWUgaXQgc3VibWl0
dGVkIHRvDQo+ID4gbmV0IGFzIGEgYnVnZml4LCBvciBuZXQtbmV4dCBhcyBuZXcgZnVuY3Rpb25h
bGl0eT8NCj4gPg0KPiBUbyBtZSBpdCBsb29rcyBtb3JlIGxpa2UgYSBmaXgsIGluIGFkZGl0aW9u
IHRoZSBjaGFuZ2UgaXMgcmF0aGVyIHNpbXBsZS4NCj4gSG93ZXZlciB0aGlzIGlzIHNvbWV0aGlu
ZyBJJ2QgbGVhdmUgdG8gdGhlIG5ldCBtYWludGFpbmVycyB0byBkZWNpZGUuDQo+IFRoZSB0cmlj
a3kgcGFydCB3aWxsIGJlIHRvIGZpbmQgb3V0IHdoaWNoIGNoYW5nZSB0aGlzIGZpeGVzIChmb3Ig
dGhlIEZpeGVzIHRhZykuDQo+IEJ5IHRoZSB3YXk6IFlvdSBzZW50IHRoZSBwYXRjaCB0byB0aGUg
bmV0ZGV2IGxpc3Qgb25seSBhbmQgbWlzc2VkIHRoZQ0KPiBtYWludGFpbmVycy4gVGhlIGdldF9t
YWludGFpbmVycyBzY3JpcHQgZ2l2ZXMgeW91IHRoZSBtYWlsIGFkZHJlc3Nlcy4NCj4gDQo+ID4+
ICAgSWYgYXBwbGljYWJsZSBhbHNvIGNjIHRoZSBwYXRjaCB0byBzdGFibGUuDQo+ID4+DQo+ID4+
IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFibGUt
a2VybmVsLXJ1bGVzLg0KPiA+PiByc3QNCj4gPj4gLSBJZiB0aGUgZml4ZWQgY2hhbmdlIGlzbid0
IGluIG5ldC1uZXh0IG9ubHksIHlvdXIgcGF0Y2ggc2hvdWxkIGJlDQo+ID4+IGJhc2VkIG9uIGFu
ZCB0YWdnZWQgIm5ldCIuDQo+ID4NCj4gPiBVbmRlcnN0b29kLiBJIGNob3NlIG5ldC1uZXh0IGFz
IG5ldyBmdW5jdGlvbmFsaXR5LCBidXQgaWYgeW91IGZlZWwNCj4gPiB0aGlzIHNob3VsZCBnbyBp
biBuZXQsIHRoZW4gSSdsbCByZXN1Ym1pdCB0byBuZXQuDQo+ID4NCj4gPj4gLSBQYXRjaCB0aXRs
ZSBzaG91bGQgYmUgcHJlZml4ZWQgaXB2NiBvciBuZXQvaXB2Ni4gTm90IHN1cmUgd2hpY2ggaXMN
Cj4gPj4gcHJlZmVycmVkLCBib3RoIGFyZSBjb21tb24uDQo+ID4+ICAgU2VlIGNoYW5nZSBoaXN0
b3J5IG9mIG5ldC9pcHY2L3JvdXRlLmMNCj4gPg0KPiA+IEdvdCBpdC4gWWVzLCBJIHNlZSB3aGF0
IHlvdSBtZWFuLiBTb21lIGhhdmUgbmV0L2lwdjYgYW5kIG90aGVycyBpcHY2DQo+ID4gYW5kIGEg
ZmV3IG90aGVyIHZhcmlhbnRzLiBJIHdpbGwgcHJlZml4IG1pbmUgd2l0aCBuZXQvaXB2Ni4NCj4g
Pg0KPiA+IFRoYW5rcyBhZ2FpbiENCj4gPiBNYXR0Lg0KPiA+DQoNCj4gPiBJJ20gaGFwcHkgdG8g
YmUgZ3VpZGVkIG9uIHRoaXMuIFdvdWxkIHlvdSBsaWtlIHRvIHNlZSBpdCBzdWJtaXR0ZWQgdG8N
Cj4gPiBuZXQgYXMgYSBidWdmaXgsIG9yIG5ldC1uZXh0IGFzIG5ldyBmdW5jdGlvbmFsaXR5Pw0K
PiBIb3dldmVyIHRoaXMgaXMgc29tZXRoaW5nIEknZCBsZWF2ZSB0byB0aGUgbmV0IG1haW50YWlu
ZXJzIHRvIGRlY2lkZS4NCg0KRGF2ZSBNaWxsZXIgYW5kIERhdmlkIEFoZXJuIGFyZSBsaXN0ZWQg
YXMgbWFpbnRhaW5lcnMuDQoNClRvIHRoZSB0d28gRGF2ZXMsIHdvdWxkIHlvdSBwcmVmZXIgdG8g
c2VlIHRoaXMgc3VibWl0dGVkIHRvIG5ldC1uZXh0IG9yIG5ldD8NCg0KS2luZCByZWdhcmRzLA0K
TWF0dC4NCg0K

