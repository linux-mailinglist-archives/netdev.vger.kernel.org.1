Return-Path: <netdev+bounces-150099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F392F9E8E68
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49051883F4A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C118215705;
	Mon,  9 Dec 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vOzhckpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9B2156ED;
	Mon,  9 Dec 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735403; cv=fail; b=nZIzBmv+ZR+hlVc+wL5SHGNglZpekGBQ9M/1nEFE6G7DDtdy0M7W44rxuljCEJppizkWbG13wWnT3+PBEiDY8F+KOgHWxJP3bTkvBVvoU7rSqdermM4DYX+Rbi130Oc+6zgsdVbrIEIWpKrIO6agHk329DB/Z6NNxNoFkkngPqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735403; c=relaxed/simple;
	bh=XbCU81hbrEXNClA1LQ+6+VS1LJqpd0TJqR0bJuij6/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YPHXDAJEtlXFq3Jn06x5oCCIKhhTG1wYmLbQsXTjWusdrxL5fd9dNJRfdmIlPqbNreWb6k4gCf9ryqT9OviHb1v+byien5xvBqBlsGb9Hni7WELNuaRqor/LYHHeV+Vb8QWtyCWtbxTvYXOsxITdd0zBwcrXBjfQsjAVch5sSWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vOzhckpJ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B96xhwJ004851;
	Mon, 9 Dec 2024 01:09:40 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43dus5g7fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 01:09:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilJT8vQi1bltWBJC30ehd6KbztX8Xu7CKrGezSQTQuYR0xYRX28ZYlV9FGNQgYSspJIOWE8tfzuat0bLm8wVQJectvQQoh+wK2DnEWetUSFpOKav06afCrXgftSPuoYuSZFXPAiObtIGYWhL6nZzzS8u/XLkoRksYtItQiQCtEgBDjzCAQF9FxjrP5MdygqG14DCxmapdvjOVcjdXOcGamhR1szQXkAcL6xHd8FSfoIbrXTkz2QHPRIlmzZ+UmhR1GUYyVZfby48rvH5SlJOItCaUnLKchTLIf1xzUnTjvcK1OYGsQn+xCIqHBF3/ms3JFvuda+94iu+cCwyJA27zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbCU81hbrEXNClA1LQ+6+VS1LJqpd0TJqR0bJuij6/8=;
 b=BUWbgECIWug2PocFhHH50xT0aD4a3aYsY1+9TS6wA5VGO/ThaESb7qL6JRrmtrGdOPEd6BKZLKcT1GkSsLsx3v98MJAv3ptXRgTzHpsCylVHeeuf/UT9EYjNA7TUv0X/LtbVVYy19qsc4EIPv+a8VeIQPhe9ywcF1tSZ2nHHnPz8WjqlWa8fLmFUJYgEy+s/hxVTBROtRo13SiPJyYnzZwsVkYHv5y2EPRhKd3OupVZgQJylvMoxp5S0rqoZAjysenVSnmCXFmGpRu4kjHZCeACLYHL7C0VtAr8/vdqHr//okuy/ObGrfVJLn6Zivpxca4WZwWLkfZOCuUh8ToA54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbCU81hbrEXNClA1LQ+6+VS1LJqpd0TJqR0bJuij6/8=;
 b=vOzhckpJxewYR/XTw06BA0oVLhHirxiuYW06BXggn0t5bXyvUv98XbaWxahpOwCVfjDPOvdkRfd7Qu9Ny9b7ql+2KmuL3jtFm7yVPItlsTobNtBV18SaD2V1uadxO0Oc84CKuB162Y3w+WgpQW25rRV5tlFJvT0zHQ0cGkRAcko=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by CH0PR18MB4113.namprd18.prod.outlook.com (2603:10b6:610:e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:09:35 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::b3e1:2252:a09b:a64e%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:09:35 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>,
        Sai Krishna Gajula
	<saikrishnag@marvell.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com"
	<kalesh-anakkur.purayil@broadcom.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2: Set appropriate
 PF, VF masks and shifts based on silicon
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2: Set
 appropriate PF, VF masks and shifts based on silicon
Thread-Index: AQHbRlYFI0wrab2RJE+ee6/a8+CS4bLbp9UAgAH9LQCAAAHZsA==
Date: Mon, 9 Dec 2024 09:09:35 +0000
Message-ID:
 <CO1PR18MB4666941A2B96DF6FC59E7119A13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
	<20241204140821.1858263-2-saikrishnag@marvell.com>
 <20241207183824.4a306105@kernel.org>
 <CO1PR18MB466694B5C67641606838782BA13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
In-Reply-To:
 <CO1PR18MB466694B5C67641606838782BA13C2@CO1PR18MB4666.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|CH0PR18MB4113:EE_
x-ms-office365-filtering-correlation-id: fdaf150b-b4bf-4f78-0822-08dd18313372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?djFoT041QkovcFFYcjAyWUtjTDVLck84bUZTalc4NnBBbWJVWW1QaDRBYkVu?=
 =?utf-8?B?czk2TmVaWWZsa2JPK1kxaGc0RzVSVGZBVGRzTjc5Mndld004ZW13ajdpT2pk?=
 =?utf-8?B?NkFMeFBCeFJaYi9abnQyRnpXQVI3R1Q4VnE5MG1EbDBGUURrMnF3T2dIbFVV?=
 =?utf-8?B?cTgrd3l5RHZpanpCRmp0Rm9VZEI0UGo3SDN5V1ZWUWtmbmpwQWhDY1c2ck8v?=
 =?utf-8?B?WGtTZGJKMFZhd3BEM05lN3lCN3l4QkN1bE93SFVyWEVDUGFsL1pyUG9TOER6?=
 =?utf-8?B?SWE4SkVkaThHWFUyN3lDMkZPWjdhZWZicjRRVk9vNllxUlQ5UjN0ZGV5Z2F0?=
 =?utf-8?B?U1MwRGdDOGpiamNqUW43TC9QRXZuTTVXNDcxSGVucW9sR29lQ3lJRkd0N3d5?=
 =?utf-8?B?NjBYdWtlRktrUFlXY2tLUzBEaVdPcVdMWjU0RjJQcXlLc21jWE5aWEJDZkNP?=
 =?utf-8?B?anoxaXRqUGVzT2JyRXBFTmc1NkNSZGNIbE5GSENCdkVNaFpXYndETVNOVFpp?=
 =?utf-8?B?ODkwZDhJR1g5RnNWWEF2amVmRFhQNzQ4SGRTU0d0MXV6YThLUVdQV1l6OUJS?=
 =?utf-8?B?a2M3a0UwV2ZCZDFHendGREg4UDBySG5VM3dGemkvZS9PanZNT2c1WVFTQ1Ur?=
 =?utf-8?B?b1ZNVTBjZVFZajQxU2lnR25nUlkvZlNqN0RyRTMrUzlCRE1kL2pVem5aQitW?=
 =?utf-8?B?aHFYdERTUUJjSUtwSzIwSFplU3NoRXArcC9PWllXQnBDVmxmeXJOK1FzYU5J?=
 =?utf-8?B?Zy9adEJIUStSeDBXY0hVVElkS3h5OXY4cTlLRUtkSVZKVytDT3FuK2p0SkYx?=
 =?utf-8?B?WjlwWFkrWXFsaWt6ZC81aHAwZ0NEWjI0dklYYUUzMlNmSTF2N3MySEZnZURL?=
 =?utf-8?B?cW9sb0o4b2V0akw4c3JESnpBREd6aTJlVzE5TzUzeXBuR1UrM3g1R1gyQ2Z5?=
 =?utf-8?B?R2pWaG53enpPbnNzQjZxS0d6ai9oVnhwQTU4cG1CSkZjQ1c3TG1iQ2ZpbDVD?=
 =?utf-8?B?RnBrTEU0UUUrM1BMN2YySFg4TlFQd1Q0ZVM3a0ZwNDdhcnBROHdxc0JpN2Rx?=
 =?utf-8?B?VnptOWwyWlpRdkJyUVM2bGhwK3ZSQUNndnFmcUdjSE8wcEIwMTc3WUhyZ3Fs?=
 =?utf-8?B?OUQvVXgyMjVIRWxXdkVKQmRGM1FpR0lJTHQ5SjlxLzRJQ0NOTmdYczlaTTNV?=
 =?utf-8?B?dlQzVDUyclpFNXhNT0VQdWlvb3ZTemFKVjF0UDZScHM5dXYxeks3TlV3clNI?=
 =?utf-8?B?ZmN0bDlubjVLRXNEcXdWREkvNDVHMUgyNnBmM0o2bjdpQWhQeFRjbFEzWGM3?=
 =?utf-8?B?WDF5aG9pSGtxWFc3dW1IQ1JSV2E2M2hoWFZVckY2YkQ2RTBiRkhmOWo5dWdX?=
 =?utf-8?B?TUlrZGxvTjZhWE9nQmRGRlZ5SHpnWWpxRVZSNStUbWtIMzYxaTFlMkJQZVRn?=
 =?utf-8?B?Tm5SR3B3emZYZnd0a0NvN0RCTEFEQnNnQ3R1VXllWVE0M0EzVmNub2VCUFdK?=
 =?utf-8?B?d3R5b0l3T1RiUDVMQitTTzhWTk51WFl3YjZuRnJrWC9RaWsyTmZZU1g3bjVN?=
 =?utf-8?B?SVBtN2dBSHVrWitlRjl5TElIUmpKaVNYWk1ONHhHemovOU80UmhXejIrSWpH?=
 =?utf-8?B?YjJVQjdxVzZUdHNzS2tIdmNzZDVhQ0xKdmJPM3dVL1VBMlFGbnQ5NWg4dlhB?=
 =?utf-8?B?V2MxcTNkekowNGoxaHVwOUdGcEZhY2FJN2R4dkJQMHh6MmtYOXhGdmtoYzNB?=
 =?utf-8?B?YkJEVGhoeE5yUU5lamt2c2ZqS2xVTkphNjRHbS9KZVBVN09ka1g0SThONytO?=
 =?utf-8?B?b0YrSFhOYUhLMlZ0R1B2aVNYQ29SaVdjNkRFeUZXNlJneElyK3J0L0ViV0dq?=
 =?utf-8?B?Z24yMnp6MjNwZkdaSTRLdUJwUXdvWE03WENoMXNvZFB3TkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2lDdXJMbjh1eE0xRUEyM3RPc25FYmhTRlVhRXpadlQ5TGdkVmZSU3JZNDFD?=
 =?utf-8?B?eFBQckQ3Um1xMTBmRElNbEtnN1BlWjJsL2ZCcHcwOEg1L05vcnZtb2laLytu?=
 =?utf-8?B?anlGMWdWaFd4bjdpdnM0VXZSYi9tc21kcFRCdzA4RjdMKytsb1dLaXFSdzBG?=
 =?utf-8?B?eHY0WVlVOEl4Y0wvRHZqb0xuNGdxak5oaFlrcjUxek9EYkV0bmVmS2pwWDJy?=
 =?utf-8?B?M0MwT0VTak9wUnNpK2tLT29tbjVQQ2VrV0lvVit3K3ZxVC9kcG5HZWNnWVpi?=
 =?utf-8?B?d2t0U2tyS01hWjIwUjJERjBEUVNQazNwMVY3SDc1TytXdFRqTUZCaDA0QWNM?=
 =?utf-8?B?MENkYmt2RDR3bzhCcmV3TUh4NHVuSmFXUU5nWDY3T3l3WFF0SklDUzVOL21j?=
 =?utf-8?B?MytaMjF3bGgzVERuN2o4d2lYaWovM1AyZDlLaHpyUUVNWlNtSEFsKytFVXpV?=
 =?utf-8?B?cTVSbWZzWEtsdTdzSVE4UE1DajJMaVJEeXM0OUt3Y2grMC9UcG9VUmpmY28x?=
 =?utf-8?B?Zlk2RVg4L2I3aDVSRi92bXVucHkxVGpUenJ1aEhDdmJqaDBrRXVvUEd0b1Vk?=
 =?utf-8?B?Wjl2Q2RuTkRVaWZLbUpxN1NHNlBXeDNUYmV2bGpKa0dpMXk5dTBjK014aWJT?=
 =?utf-8?B?SGhPd2lIUDJtd1hiT0psTms5T3pTbllWcWtrUGw1SkE2KzRocDV4M1BGdnpZ?=
 =?utf-8?B?cFEvam5abzNVQncycjJVQ2FyUFRvSFdnWFAvbndZQmh3YWF0MEpFVGhVQVE2?=
 =?utf-8?B?WVI3T0dsTlN1d1hCRER0eGo4bmhPRkJYaGd2UExEaTc1d0ZGeEppSUFhL1dS?=
 =?utf-8?B?bHdHU0NTd1gwVkV5QmNNazJQK1ExL29GMC9IbTdWZWxvdjZjNWM1Z3hQSFAv?=
 =?utf-8?B?M0ZGZktXVHB1bHFZdVVIZzhXVFdNQ1NjN3p2M2tHVnVmQjdnbWh0NUxub0pj?=
 =?utf-8?B?Yk85czQxcnZyTlBSdmRHMzJrcEIrU1I4UWZ1VTZkV3UvMXZQUnVkc0pTUkVR?=
 =?utf-8?B?K3l1Rmg4UGl3d1JocDF6YmttRVN0a2hqa3hjekNmRTIyYXdsV1YxV3Q0RjQ3?=
 =?utf-8?B?cHQyVk9sME1rdnVXcjJvQ05nR1NBUkI3eit1QnkwajlqOXdUSmJiTTE4ZG4r?=
 =?utf-8?B?UU8vV2tESHdYSUYyRk5OZ2wxdjVncG9qZlZlRE1UT1FpanY0M3NsUFUycE5J?=
 =?utf-8?B?Mk01N2RmejdEQUExc1Q5Ui9YYnJDQnRJazkvQVZucVVTNW5GTWhkTXNjT2JT?=
 =?utf-8?B?R3lkNVFHQ3dkSnE4eGhwU21EVFZCcE1TaXJyODlGNFF1T3FTcytTTGRUeHlF?=
 =?utf-8?B?S0VzTVowaUR4TW9TYjgvcHdZdko5WCtEOERqWUdsUmVaTCtnbzF2ZUNSU3Js?=
 =?utf-8?B?bXhteG5ZRVVhQ1FWVnlKcGVvZk9VWFlIcVdMUjhZM24weXJpS1VJbWxGWG5p?=
 =?utf-8?B?enB1RHp1cEtVeHpweG9YUmZHV0ZPRWtwb3JEcllLcW5Ccmc0cm9wR2NENDNL?=
 =?utf-8?B?OFdlSkFjVHFSd2lPdVZ0TkZ5NEVrd2UxM3ZFdWZPbXBRUy9DSFlRVktBOUtB?=
 =?utf-8?B?MTZDMUdwUFRRR0FTYk9BdC85TjZoSkhObTcxT281N0RBY2krT3FBT0VlMU0x?=
 =?utf-8?B?bFRrS2dIY2FiTmJVLzQyNVFyR0ZyNGVML3g2aThKdlAyUGlyR2k0TjdTcXdJ?=
 =?utf-8?B?YjQ4elBiYVZQbU0xUlB6S1RDVTFCT2ZVM3pYSUxJUldadE15TG8yOU5KYWNH?=
 =?utf-8?B?K3VCcVB0VnlXU0tYRlVTLy92eURDcUhqbTY4QWsyeUdZSXJwUVl1OExiU01C?=
 =?utf-8?B?dXFSV20yNDZ0Z3JXQ1ZNdHUyZ0QveEl5NE92M3hxMk1KZUlsV1RkUjZpcHRj?=
 =?utf-8?B?U2pCaTA2Yythc2lQT0RtVjBDSlVsTlN2WnJYVVVlczJsbEZLMDlZVHpUN29j?=
 =?utf-8?B?endYcDQvbllrRTBoQnFRT2pJWmphS1N0VXpIejYrUUE0SXE2MFI4Sk9XMG4r?=
 =?utf-8?B?ZWloU0VMWE15OVIrZnliUWRvVG0yRlY1QUZLSkFLeVpLbDlLdGV4d3o2aUt6?=
 =?utf-8?B?bGlrK09xYkZ2WVBBejBkUFNSWnR3Z25jNG5hZ2Fmd1g4ZXkvbE5HTXJ2cTBr?=
 =?utf-8?Q?0HaSbdzRf2Dnppwbevqm22Aun?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaf150b-b4bf-4f78-0822-08dd18313372
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 09:09:35.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb+UNm+SFGw6d75lXF2bjDqhJ0pSc+pdPYK66KCN7oUw6cuprNebGzvY+dDWSa58Xp5ZfuPFEM09l5M/QdwBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4113
X-Proofpoint-ORIG-GUID: C-eeZuteYl7DLf2cQ8CGEXQbu-b9PRQj
X-Proofpoint-GUID: C-eeZuteYl7DLf2cQ8CGEXQbu-b9PRQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

DQpIaSBKYWt1YiwNCg0KPkZyb206IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+
U2VudDogU3VuZGF5LCBEZWNlbWJlciA4LCAyMDI0IDg6MDggQU0NCj5UbzogU2FpIEtyaXNobmEg
R2FqdWxhIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj5DYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+bmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU3VuaWwgS292dnVyaSBH
b3V0aGFtDQo+PHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2VldGhhc293amFueWEgQWt1bGEgPGdh
a3VsYUBtYXJ2ZWxsLmNvbT47DQo+TGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47
IEplcmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+Ow0KPkhhcmlwcmFzYWQgS2VsYW0gPGhr
ZWxhbUBtYXJ2ZWxsLmNvbT47IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YQ0KPjxzYmhhdHRhQG1h
cnZlbGwuY29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBrYWxlc2gtDQo+YW5ha2t1ci5wdXJh
eWlsQGJyb2FkY29tLmNvbQ0KPlN1YmplY3Q6IFJlOiBbbmV0LW5leHQgUEFUQ0ggdjUgMS82XSBv
Y3Rlb250eDI6IFNldCBhcHByb3ByaWF0ZSBQRiwgVkYgbWFza3MNCj5hbmQgc2hpZnRzIGJhc2Vk
IG9uIHNpbGljb24NCj4NCj7igIwNCj5PbiBXZWQsIDQgRGVjIDIwMjQgMTk6Mzg6MTYgKzA1MzAg
U2FpIEtyaXNobmEgd3JvdGU6DQo+PiAtI2RlZmluZSBSVlVfUEZWRl9QRl9TSElGVAkxMA0KPj4g
LSNkZWZpbmUgUlZVX1BGVkZfUEZfTUFTSwkweDNGDQo+PiAtI2RlZmluZSBSVlVfUEZWRl9GVU5D
X1NISUZUCTANCj4+IC0jZGVmaW5lIFJWVV9QRlZGX0ZVTkNfTUFTSwkweDNGRg0KPj4gKyNkZWZp
bmUgUlZVX1BGVkZfUEZfU0hJRlQJcnZ1X3BjaWZ1bmNfcGZfc2hpZnQNCj4+ICsjZGVmaW5lIFJW
VV9QRlZGX1BGX01BU0sJcnZ1X3BjaWZ1bmNfcGZfbWFzaw0KPj4gKyNkZWZpbmUgUlZVX1BGVkZf
RlVOQ19TSElGVAlydnVfcGNpZnVuY19mdW5jX3NoaWZ0DQo+PiArI2RlZmluZSBSVlVfUEZWRl9G
VU5DX01BU0sJcnZ1X3BjaWZ1bmNfZnVuY19tYXNrDQo+DQo+V2h5IGRvIHlvdSBtYWludGFpbiB0
aGVzZSBkZWZpbmVzPyBMb29rcyBsaWtlIGFuIHVubmVjZXNzYXJ5DQo+aW5kaXJlY3Rpb24uDQo+
DQo+R2l2ZW4gdGhlc2UgYXJlIHNpbXBsZSBtYXNrIGFuZCBzaGlmdCB2YWx1ZXMgdGhleSBwcm9i
YWJseSBoYXZlIHRyaXZpYWwNCj51c2Vycy4gU3RhcnQgYnkgYWRkaW5nIGhlbHBlcnMgd2hpY2gg
cGVyZm9ybSB0aGUgY29udmVyc2lvbnMgdXNpbmcNCj50aG9zZSwgdGhlbiB5b3UgY2FuIG1vcmUg
ZWFzaWx5IHVwZGF0ZSBjb25zdGFudHMuDQo+DQoNClRoZXJlIGFyZSB0b28gbWFueSBwbGFjZXMg
dGhlc2UgbWFza3MgYXJlIHVzZWQgaGVuY2UgYWRkZWQgdGhpcw0KaW5kaXJlY3Rpb24uDQojIGdy
ZXAgUlZVX1BGVkZfIGRyaXZlcnMvKiAtaW5yIHwgd2MgLWwNCjEzNQ0KDQpUaGFua3MsDQpTdW5k
ZWVwDQo=

