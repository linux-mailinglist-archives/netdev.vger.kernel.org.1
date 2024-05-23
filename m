Return-Path: <netdev+bounces-97907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B748A8CDDC5
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 01:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22991B228EA
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 23:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74876128392;
	Thu, 23 May 2024 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b="kM3PXkkn"
X-Original-To: netdev@vger.kernel.org
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2131.outbound.protection.outlook.com [40.107.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7B17577
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507495; cv=fail; b=eZnwPw7Sgj+arjTKat+l/+nlvGxbTknJ7JL33olA7MixXTKGQ/3Ac2G8FV4mO84ERi98t6TR5ou2J4/PiaT3LUQPaFbLBRF9rnBqIof3irnulvFPyuYLl95yJmjWJj1vYNMwpJ4BfM+dZWXpyiJnFn1TXhRMMObq+gpj9lUmCl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507495; c=relaxed/simple;
	bh=GSLvoD+XdN5R5Q4Ta9RsyVhXFvmAGph7qDW7hiTJ1aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X6Gs4L+OGomTVrwLy7lOumbYYLC/uoE0QmnLgcPBrgVKdKwk6BTwMLCZeB6ekCMdLQVGPV9j9Tu01UpLQX3Ofg1TeRuFxybNWtimKFYrM70k7ZWN+LvEndQgJRMmRep1FqCWO+SAMVqgAmCBN3+laFKQXGX544yTREMmoc2r2A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de; spf=pass smtp.mailfrom=avantys.de; dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b=kM3PXkkn; arc=fail smtp.client-ip=40.107.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avantys.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpEDcxlFDhmgynm/w7vUVMmRUYYR7j70ew2srK6sljg+ZHzeUE84E5hAkg/4bX0NF+67i3/yRX5zdhT+63frmsk55UTYLEFkYJkSU7VWEBroojcFtDDovlI8p7jpSaN836Plf6zv5MX5rCJt5tOmnmwo5Di8y+Y1gljTnZKm09SdtSaZij7FgrSu0fjWZYay0KkswfD/QO6hlWzdpadN6p16krQvvDjrdvr2dManfWdFCa1zzYGeabn/rtC/uU6q4/JyXFvMPB9x3wVBP21pO+Cxr2ABuynZ/S4GOtCcuqWNkSK/1EVUDsXEIoALVHwAjbu10nnsHH2zsOnxyFYKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSLvoD+XdN5R5Q4Ta9RsyVhXFvmAGph7qDW7hiTJ1aQ=;
 b=iC8GU5HSWcCjGnbRAUuJZB7TqfsPIUrZ9s8F1AZqiEsUiKFmuU0b8N/NmhnD3ZDsoqrgX1YuHoA2SMtiBlS/MdwN1I2oriXSEpugTMhjyBarzuFJmJaEE0RbgWj8YWDHdvwE1wbgjnk1sLT8qvFkev85h7kx4ubTH1JJDnNiCU3rt5LeF6/rxcSzGsrVkJyFz9qH97xDtkDZQjvg7lm45y6ccks8+1iGoVbiScHKsnD1txT/6s73NfcJXWzqen/hMxbITKEMlZjqhDNOgaCD517HU8z3ASsBeZsQHwlXzDCddgmZ6ZGhrVKaz7/JgHDTL/fS3X7FlFzl/xQmgDaTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=avantys.de; dmarc=pass action=none header.from=avantys.de;
 dkim=pass header.d=avantys.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=avantys.onmicrosoft.com; s=selector2-avantys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSLvoD+XdN5R5Q4Ta9RsyVhXFvmAGph7qDW7hiTJ1aQ=;
 b=kM3PXkkn8ugu5MGRt+dA5jiqsZfUDFoG+7XvC88pGG9HRhkCU6Izv2xsQT18MB743uJBHp26b46UpEFdyhhvOzgTVodbosfnfV1jb17qeU9RyUW1J3TkqKP/hQmGEaY9Nqg2CQcPsOTEFDF+9nx2q1uYg8lMg7U3fQlTxsE5Wrg=
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:57::7) by
 FR3P281MB1456.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.17; Thu, 23 May 2024 23:38:09 +0000
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a]) by BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a%5]) with mapi id 15.20.7633.001; Thu, 23 May 2024
 23:38:08 +0000
From: Daniel Glinka <daniel.glinka@avantys.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Thread-Topic: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Thread-Index:
 AQHarIzbCS7l1FmJmEuVD1CPnXQSHbGjzOgAgAAn/fGAABmkAIAAqa5mgAC1jQCAAAwC2g==
Date: Thu, 23 May 2024 23:38:08 +0000
Message-ID:
 <BEZP281MB277644CC87093C154A16991690F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <0d5cfd1d-f3a8-485c-944d-f2d193633aa7@lunn.ch>
 <BEZP281MB277651F9154F2814398038C790F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <6d0f1043-cf3a-4364-84e0-8dec32f8b838@lunn.ch>
 <BEZP281MB27767E9FDEBECA454A503C4090F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <2f7170c2-af24-420f-a816-0f15c069a212@lunn.ch>
In-Reply-To: <2f7170c2-af24-420f-a816-0f15c069a212@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=avantys.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2776:EE_|FR3P281MB1456:EE_
x-ms-office365-filtering-correlation-id: ba0a3e86-39af-4e46-2d23-08dc7b8166e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?f18UpYmFyxwEx9AVj5ogNcq6DY/Uf01AwdPgeNqFDJW/G69zWzeCJRMLOS?=
 =?iso-8859-1?Q?QirbRMVhBPMrr7uKKQrE0nGkP/I0hMdhVzJDziyl3apCs013MfDo3PXUcV?=
 =?iso-8859-1?Q?w7JsgHBwHny8Wpw1F2cWThIGrouPLoXHVaRY03oaqSN45Ip8iIIfw6mwoW?=
 =?iso-8859-1?Q?gqJJF6KmNzB0GKNVqXBaQrLVKFe9FQ3YN4v295iDAKDPevzDkDIF1aPlk0?=
 =?iso-8859-1?Q?1BuTZIylroPZVfRkfL7ixdDc+nKuBURDcLX2RbMgeVCoF6HZu6MFmFnjrh?=
 =?iso-8859-1?Q?t04CHpqfDibkQZDTAcohr6dddigcIP75asHSWscMQZ2E8w6AGoyBwHRFJR?=
 =?iso-8859-1?Q?0JndWYXOQfk3mmfoCh3nMGANPb3Ia60wvdEp5OEhcTv9DNpk7HIEo3uGsd?=
 =?iso-8859-1?Q?Zpyt83r0rmZRHphBwB4hJxgLXM89t/dZWVsbJdOVE8a6YDL1p13TAWXM5s?=
 =?iso-8859-1?Q?pWlfFxfrhQ1ZiOwqbsoMqdP4W0MPtIU2TLApU7mGs64YI6RlzKMh2GrStN?=
 =?iso-8859-1?Q?ei848QhnOarSExUebkJ7J2902Je7gjkHhqNRdTHiuz41f+i678HHbCLMxu?=
 =?iso-8859-1?Q?wx/MwZ/adzK2kN5HdmlE1jrqkFDAvAlK5v/OsyDhleoXAhKqEjtKGTHpJw?=
 =?iso-8859-1?Q?4bnE0GGrN2fyvoL0w7JvDgYb99WQGPLUY7+pNiz8MjqElh6H6VHDnudUa2?=
 =?iso-8859-1?Q?zALe7sxuTftUZGwKo2ITic9lCdfy1LECSNoSyNcUzAb4pYP6HekXrfG6Mf?=
 =?iso-8859-1?Q?gTjntdPu7kyNtIfz2HbSR08htOPRYa7V0TPHS7eA/98gJmGuj0FK/sgi9H?=
 =?iso-8859-1?Q?LiEa6PAZorOGahQ7mqfaTDUzm9ZjMKbvM9a+PaGimG5ndCXtO84b7AY+11?=
 =?iso-8859-1?Q?vu7RBjbEXJORa067sWuvwtdSxzZ+DkYEBKtvPcAsJunS1qGWSbbCn04bvd?=
 =?iso-8859-1?Q?JSZPwZvZZCh6ERx3T39F6ds/F42REek/MJFKDJ+XT7xw5CSUWJnYOSQb9X?=
 =?iso-8859-1?Q?9oEM8UY8OxqLvABjp1nhyC8nRbhVBfzl3JkJwrbhkh8QC9h+11FXEAUDEY?=
 =?iso-8859-1?Q?9nI/mLvUCay38A4qzcin31hB6cxhoxtAemLSDHX1R9w3HonYggsH7mIK01?=
 =?iso-8859-1?Q?HuClkG98HV3E6Ulge1pcfRU1HkiDD/mBl2Ql70PnZ8pn+tFgq/ThH9L79H?=
 =?iso-8859-1?Q?a9RuR/nYPquBryuwcDj2/ODmtlizma6UbthLW7sHmQsVwhe5l/gM2Y4zGg?=
 =?iso-8859-1?Q?maOw0cm0EnbOmSVejBqoc8zsopiWN3pMu/BhqWxWy9HtGrI4OzXp873OKW?=
 =?iso-8859-1?Q?acknpsQQYmJVLFJgwQ0iGrJCFg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?g5J7uI8cDVbQN/2u+XwE52JLMYc3lQo/SuBeCnmq3zy2SocN2lA9N4Bdc8?=
 =?iso-8859-1?Q?1QuhXRw2D5sYDlyV+qWqOhL3quF9WVCpS5et2sYpuY1CiL5gjzR5ZQfMBp?=
 =?iso-8859-1?Q?tizgMh/dkAw8mDEWNXxxa2NWXrQBB25Md1SXUnyidxfEd4Gcwbo+NMH3cW?=
 =?iso-8859-1?Q?UwzO/xortXsXC77YKhnqFCNnLqtRgALDuVo2pvz24IjJ5asGxfccwnJrMA?=
 =?iso-8859-1?Q?vZcjCRl1llCTM8uIZ71Eo10AH0+S8BaVOj6s/QZxU12URn3gerHArqpCzQ?=
 =?iso-8859-1?Q?45qhrTKrT2pnPproSDgpj1arm3SuT6iLKUR4EWh/5Q94i8SnvHtir7VbCz?=
 =?iso-8859-1?Q?5Ywb7JCHp08Enc7aj7SHkTRHCjp+aBsMJPW6mCuk+8CPCyxPn93kgt+IWy?=
 =?iso-8859-1?Q?MlKp7w+5oykHDBI1M65ve/hhK8DFmygtZ4iW8Luf/41F9JqPX7h7CNA1eD?=
 =?iso-8859-1?Q?zt8m9B1fU7fg09b2BPQbDt2x/gpG0R7BtcFQaQoxyZqki9cE9siOQmJFlY?=
 =?iso-8859-1?Q?zt3V8bIDqYfgXF8As3yNZM+SQqMjCqU+3r553qMc0GDP7Nd7vSDs3x3Wco?=
 =?iso-8859-1?Q?XQFQBedGFR0T7CbD+6FbZxaWzdjsS7iXpk/+M+WGzAO/lwxgqHyXz3EhjR?=
 =?iso-8859-1?Q?B2ykbof1O8gZETzW35kDB6+tI4okvUvNlEfrO2qs1gOEVs6XtDxfBtuanj?=
 =?iso-8859-1?Q?pIr894UYX8wULYDONYrBDRq5NRMYD5NpJ79h1xwp7RKaRlvHA+fAdh+e+f?=
 =?iso-8859-1?Q?ze6N4E4Bfcqbss71HL5jzt4yl19t72WkhJL33h06DwerkByjybimszAM41?=
 =?iso-8859-1?Q?YtFwUogHgsFU8Rg+yk59E6hh8QlsITilkrvcKI4kyUvn05ikjRMA6qTUwL?=
 =?iso-8859-1?Q?wQmqKIboi3yGYpLY/acvnOH+oIn6Dv1yk+lHQwTR8o58i3jR2JBpCwn4ua?=
 =?iso-8859-1?Q?DOr62auKeZLhYnntcgcASQYonqXfT8O37XogAK07yflpxNLrYEsOmFGZ7x?=
 =?iso-8859-1?Q?3cLKbl2szUTPpjte6fSRajUc3qZySkhRuN/NIoThjKYMrJLGeQCqf7GdVZ?=
 =?iso-8859-1?Q?VPSsA71nE0xdIbsbRq4iOAqtATKFJVNWWOHithjqlITAuy/pOlYY9+64Ix?=
 =?iso-8859-1?Q?t9LHNIpcvNDQZKV8RIgr5adktn2auN3qn6/+KSMaaNvuO0KaVvWglt7PWV?=
 =?iso-8859-1?Q?0M98X/rGqfqOSRCVbNThOcoDCkXWWjR6Bswug7Rpqi8l1D3qP7sNbrpvXO?=
 =?iso-8859-1?Q?+kCxz7062Yp71mGHpFbAsap9gZ1NhlPvi04+FUtAdBx5+NWvkmGRSk6wuC?=
 =?iso-8859-1?Q?PUYAq1SLlZSQ4fwVv3owN/BLv3s6ncaAAbcgkicALI1gkHXAHuswKTZxF5?=
 =?iso-8859-1?Q?s6rZkHZolg6JijzHT4Gl/wnZOoeY8xmtzhkRnLB7TG1ZohJ1IiGKd+bz9N?=
 =?iso-8859-1?Q?ENky/SOpLZN9AK550i+AX0sSyLR0MskLEZw+0TgJviOi0bzg8Lak4PdO9F?=
 =?iso-8859-1?Q?fg5igGJoLcmgR84vFqD8kcw5c1TCymimbnuOnidhzm/cuVWT9Ks40UTqVF?=
 =?iso-8859-1?Q?MnZv8zkExYTyYKdPjoij8Qgdq8Qa6cAfWefiw8UWKHRz4i8YeYAk85rizA?=
 =?iso-8859-1?Q?LAxrWR+DuWyqLvcqF0UOfYKcIHBQyMJLrW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: avantys.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a3e86-39af-4e46-2d23-08dc7b8166e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 23:38:08.7156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d7bbaf1-8dfe-40cf-ac5e-41227cb807ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oE5Bs0qfvgd2Q+iqDlLiiUDe1jKsSoyy/oOcT8KGIEJjLMX0qCVAtz3YVPVIZ9IFLQBaPKBxu3npwEpPEO5htYGtMuDLofIfxFNPyO4/7Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1456

=A0=0A=
> On Thu, May 23, 2024 at 10:38:36PM +0000, Daniel Glinka wrote:=0A=
> > >> So, assuming you can use 6.9...=0A=
> > >=0A=
> > >> mv88e6320_ops does not have a .pcs_ops member. So the SERDES is not=
=0A=
> > >> getting configured. Taking a quick look at the datasheet, the SERDES=
=0A=
> > >> appears to be similar to the 6352 SERDES. However, the 6532 only has=
 a=0A=
> > >> single SERDES, where as the 6320 has two of them. And they are at a=
=0A=
> > >> different address, 0xC and 0xD, where as the 6532 uses 0xF.=0A=
> >=0A=
> > >> You can probably use pcs-6352.c as a template in order to produce=0A=
> > >> pcs-6320.c. Actually, you might be able to extend it, adding just=0A=
> > >> 6320 specific versions of:=0A=
> > >>=0A=
> > >> const struct mv88e6xxx_pcs_ops mv88e6352_pcs_ops =3D {=0A=
> > >>=A0=A0=A0=A0=A0=A0=A0 .pcs_init =3D mv88e6352_pcs_init,=0A=
> > >>=A0=A0=A0=A0=A0=A0=A0 .pcs_teardown =3D mv88e6352_pcs_teardown,=0A=
> > >>=A0=A0=A0=A0=A0=A0=A0 .pcs_select =3D mv88e6352_pcs_select,=0A=
> > >>};=0A=
> > >>=0A=
> > >> to the end.=0A=
> > >>=0A=
> > >>=A0=A0=A0=A0=A0=A0=A0 Andrew=0A=
> > >Thanks for the suggestion! I will try this.=0A=
> > >=0A=
> > >Daniel=0A=
> >=0A=
> > I had a look at the implementation. But switching to the fiber/serdes p=
age does not work. I did some debugging and it seems the page is not proper=
ly set in the=A0 mv88e6xxx_phy_page_get call. The function returns 0, but i=
f I want to read the value back I get 0xFFFF. I also tried to write to the =
register using the mdio-tools (https://github.com/wkz/mdio-tools) with the =
same behavior.=A0 But this is only on the SERDES ports. Therefore I would a=
ssume mdio works fine.=0A=
> > I thought it was because we have no phy (cmode is 0x9). Could this be a=
 different issue?=0A=
> =0A=
> What MDIO address are you using? As i said, 6352 has a single SERDES=0A=
> using address 0xF. 6320 has two of them, at 0xC and 0xD.=0A=
> =0A=
> =A0=A0=A0=A0=A0 Andrew=0A=
=0A=
I'm sorry. It is working now. I got confused between the port and phy addre=
sses and passed the port address (0x10 and 0x11). Thanks, for your help!=0A=
=0A=
Daniel=

