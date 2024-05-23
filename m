Return-Path: <netdev+bounces-97671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43068CCA1E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 02:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4CA281DD3
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147EF37B;
	Thu, 23 May 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b="pbaMD+qH"
X-Original-To: netdev@vger.kernel.org
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2119.outbound.protection.outlook.com [40.107.127.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0E196
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716424312; cv=fail; b=uvxlECvEGB8TrTqOnRtNjGAxV/nBKvwkni35cwjAPAHx2XGPE6uhrTdXUjeGlDrZo+FjQJkihL1DFOHGM4ysa7HcbQf5SP6WjmB/5mEVXiJeMo0DNi+oqjr1mQonZ6FjPabnUm0cg6iHtBwPgL8iN9k3mbNCXMTuLj821bv2914=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716424312; c=relaxed/simple;
	bh=4XmNZiImTojmTw0RHhoh3JiXI1a+z/vvyjmIhfdQNcc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iWOGRnevcBHk0VEGF2PIaa3CznH660yTrF6Q6+TUCd3v5L3xR+zTZqRK6b7q7B2zcryrXMUl5l4nhaD52DrQFIkJzg0x/5WlxZlpkgo0vDqxHeT+jFVuctl55QOdFRY2fHkhQCVhdscD0L9FhYvSyVvIAnk53pvmtKJgKb6OdKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de; spf=pass smtp.mailfrom=avantys.de; dkim=pass (1024-bit key) header.d=avantys.onmicrosoft.com header.i=@avantys.onmicrosoft.com header.b=pbaMD+qH; arc=fail smtp.client-ip=40.107.127.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avantys.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avantys.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2ZuhD6M7lzbOl2B8Yv95Eo9l758Nl3Nnz6uUzYs4b3I6RHiQlNa2+nLjKw/DflFg/tFNXaMf2cS4j+0WFp6ddDQzDkcUpJNhw+he3YUm7ewl7e1zfZsFBCIq5DXqibU+Tq8HYWrkjfL+YdR3qUN5j/GrwMVvr50av6t86X9hwzA4CJ7l1YdHyYtAKdPCCYyweE3Z06eBwj012Dg36cUC7jCLC6i1G3qbnFOmyYe2th+APL/VuaLWvcQVOfRZQnAAxrUb7BuXxQ631vgY0iPkizsS6sNWSeLaNOSm9DHitVWndFxZGHSLm6ntVJDy48glfr49nK7KnyutFQ+QXMqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qSnnNDhkf10f3idW+CwrF2tMh7xvYkboXfhOAWmsCM=;
 b=k2CSfjV+DtWEQMFgwBQG3Lb2Olk1sPSXgpsA0r2ufqlRjQx/SXWgSpvWhZsdPQ9L9+suwgZUtP4/+bLxBTpnC11eFRHsIP63FQWOUiZ8ndYi7l0urYKuiZAjJaW1jqK8KXlgVEceOjmbo2a9XwzUixPLXWo1C69MhiPs+ydKx2dS/owEDagslgnWYF2chcUB7j3rcOfBFgljq/yEvWJwAcsr1FT/tLQNUHXkCwAKZqnOplPmO5iLDVqZJBx0UgwmQ0nBra4D8H/yQPXtkEjDTcoAo71IvfyiPm0g/xptlMJyCKNQ4P8RsZzq7N4RYzkAKuxaotSX/J66tLn1v264cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=avantys.de; dmarc=pass action=none header.from=avantys.de;
 dkim=pass header.d=avantys.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=avantys.onmicrosoft.com; s=selector2-avantys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qSnnNDhkf10f3idW+CwrF2tMh7xvYkboXfhOAWmsCM=;
 b=pbaMD+qH7ICoGSlQLC7pFPFYzqev3hqCjE0FcjQWd09aNe1zz6d2GYlZUQZctpCOrnpj0nyRjmr3VnC3ctZEZ48p5JOry6pldlcg65AI9mRwvL8n8p46c1aUGurcXkqTqbCYoR9N4t/Sg6jVlkGm7+q2Al5rvTWVA5WN50ND0bM=
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:57::7) by
 FR4P281MB4254.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:122::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.17; Thu, 23 May 2024 00:31:45 +0000
Received: from BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a]) by BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM
 ([fe80::90d1:448e:9438:3f4a%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 00:31:45 +0000
From: Daniel Glinka <daniel.glinka@avantys.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Thread-Topic: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not working
 with mv88e6320 on Linux 5.4
Thread-Index: AQHarIzbCS7l1FmJmEuVD1CPnXQSHbGjzOgAgAAn/fE=
Date: Thu, 23 May 2024 00:31:45 +0000
Message-ID:
 <BEZP281MB277651F9154F2814398038C790F42@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB27764168226DAC7547D7AD6990EB2@BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM>
 <0d5cfd1d-f3a8-485c-944d-f2d193633aa7@lunn.ch>
In-Reply-To: <0d5cfd1d-f3a8-485c-944d-f2d193633aa7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=avantys.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2776:EE_|FR4P281MB4254:EE_
x-ms-office365-filtering-correlation-id: e09035fc-a077-494e-c915-08dc7abfb9a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PTU1RkY4rB+Ex6lCPFncM1BUtXzEb2odS785ijho0CV4Vj40XWw2k6qT7v?=
 =?iso-8859-1?Q?zxh0V/OI4q8nLD8Kcx+1Q67J2YGZCYLpjCgt5VnrFkx4q6jF6Cscm1bs1X?=
 =?iso-8859-1?Q?wWPmB87XY1jSAgttY9nKd3GvicneHS5arR63LLHBnoIbelXJLyLTh9gSK1?=
 =?iso-8859-1?Q?ce/ISR6Hns4kIyUZ53Y4F8OjEEt5+ldI+nejLNm7CWJtAiDB28hTxPM0CX?=
 =?iso-8859-1?Q?dZJQKpSCS1NNixKVc1lvTqjzT1gRfnk22BBADOVfc9FOWhHQLO29jtkEx8?=
 =?iso-8859-1?Q?+iCe3JJtC1i7418Mb6egIf6oaHXfDF/n/8omycLcf1bV/NFwzRwyhfsyeY?=
 =?iso-8859-1?Q?eLyHU/ilPoa3/pMjY/W5son+WlVnwOlK2dhgleQ/lvGBvMezzVZVDPtLTd?=
 =?iso-8859-1?Q?WIhATnJufyAz23aD2S23Pxe9km53bchwmUky4Rqux1X1aN90XWr817lGdB?=
 =?iso-8859-1?Q?5JChue6JdVCB0ZW76rWNxo2NLHGJZM62RK2BHpswRC9xRdisGqHWbRjcbC?=
 =?iso-8859-1?Q?ojOJVlzYPQi45yz5YDmgIC06h9+bqn79ha7OyAj7ZRVjosQzveXIGajn0+?=
 =?iso-8859-1?Q?VTIUQZ+QZNb+2arNDqsnWkQ2PZ73mCjAqASL8pTynBmwTPI4AuMYhNegz2?=
 =?iso-8859-1?Q?pbDx/X/Ljpp6sl2MoCATtjLGvlLlMEq7TM22mVGSuNTTpDXnMlnIO1V6+1?=
 =?iso-8859-1?Q?MAlGjIgLxdGp7+bGe4SVp7FxjdrC2RnVbJGmJZ61DZBbo98Ouu1b/IDMud?=
 =?iso-8859-1?Q?TX+AwnuIaojCZ7u8YpeVk+EZT69f+ljktLLBr6W9ndCyCo9oAJXQNQogvU?=
 =?iso-8859-1?Q?/A1JKG+SqfgvXqI/bU+IcChW55um0O7rhj9o1kuviXXS0eKGPYyQqxvNac?=
 =?iso-8859-1?Q?Igy+buJpsuLCj4B7txRlP5u1g6KE2Cx9uLA3gYlsghGEQXtAk+k3RRXKYj?=
 =?iso-8859-1?Q?gCRA/dgx/3VIcqQPXTm/khvnTH9uaiJpxAntM+5YQbMTwxx+1gxm7S3i6F?=
 =?iso-8859-1?Q?/VDYk8QKlj2cv7H8yg1HTVfdC9vc2OpG/WX82T5dEiC9esubVKahlI22Ip?=
 =?iso-8859-1?Q?La/Gl706+YcFTqgrhgK7/DZUC5Yefiu8lWH3X+PA0mQGYfpFmYFAWMB7Ag?=
 =?iso-8859-1?Q?HCrMwfb11MxsGkYqgHocu9tJpnqznKWcB4ljHmDVx07877o1PGsXngrjWM?=
 =?iso-8859-1?Q?3uGuDT0M9kYz0jIVLTSo03Tsl2ZEMAkAadPUVmPSp/6JdmawvBPU7vd2Dy?=
 =?iso-8859-1?Q?KyeSKvty5UyVrCthggfHq0ZwBZz2nPpWtsIaf32mZqUvbaHzjWIux1Jcoj?=
 =?iso-8859-1?Q?TDMLA3Usg2D9ai8IHtGVD2slGWiSBHdfJ4HaYpVn277Pfpb/g7J1sVaCr8?=
 =?iso-8859-1?Q?sEsm8IFa6yEgQRNDqBwgnP1dRQ8ZuU8g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2776.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fhTiiDrxFk8ehpX0rge8N+W+WJBStA8k/GN7ItfWvHpb6qtEeNwc0XxitG?=
 =?iso-8859-1?Q?3qF5WiezRzSVQiQ0I6g4v+s9Ac/0euepoM23zwCGT9ouueLQ23vWeY1H/G?=
 =?iso-8859-1?Q?zPf3wvCUCTl256RHxzYQ6tXKlzmwtbxnCNZGjYrWjnc9luOVMBcosBZcrU?=
 =?iso-8859-1?Q?Tz4XBXY8jhFmbk64ApxyBkiX1XuM7zoeLn6ezVWnMm4FzmZ5NXXllqhrTD?=
 =?iso-8859-1?Q?8Cnpr2/pA9DNC1MpNcWFT9DVvG0ny4dkdhFH6pEvMVm2gvseLJrxczuBVC?=
 =?iso-8859-1?Q?CKH21mzqwWTuIWUKmGpXX02EcGQE0nDqgroIpFjX7vjw1HsoTKg5Uq0ghj?=
 =?iso-8859-1?Q?vTnlcza6lo+Sb4zgACd5XH0zWIDtdl57JP1wHrfOEY/+svBmYPEtNzu4B1?=
 =?iso-8859-1?Q?mGcW7a0Ei8lvW9orvgN6hq2Dzm04+TDXtCFjZlUG1y/t/JiAjMI7GxuSfo?=
 =?iso-8859-1?Q?Eo7p3Mb64ppnS7HCWzmkTw9aB0DYRpglc4ae3PKvLQrCFb7vTgMPwajBLe?=
 =?iso-8859-1?Q?Bz0/uPlqlf6l0hfPfWI4JAWstXfyPHMYe5s1lEDHhJ9QJe28sdX/U3tGDY?=
 =?iso-8859-1?Q?hs71fkfyxLLzL+AmPhdL9lQ6890lDiDGiUwoDmN2C0joqiO8ksvnV8H5/a?=
 =?iso-8859-1?Q?X0ZGUbxQlL/pVarBNsob96/8je2KS77PCLVf0p2NXIBH1GmiqZIzzrG3HT?=
 =?iso-8859-1?Q?UINzceqXlZLbH7HWrBGUnTeG0owLUYYC6EkOtvBndzwuuVawtIlfZJujIp?=
 =?iso-8859-1?Q?3B7DrOcwoVv+SQOuk5cG2q64f60pOMi3/ZLDu0Tx1f2MOGWrZgdDMJefY0?=
 =?iso-8859-1?Q?99DcFsNhbb6AnvdBUXw7NM0y8gMjYKo6EuEX5EANnoiSyl8/LSiEyzWFQy?=
 =?iso-8859-1?Q?YyQ9GqF5meRMlb0zBauyWi+3EqROilgMQyZp1Tu/fRwraDsM+tHz3LQsE5?=
 =?iso-8859-1?Q?XUWfQq3VXWQSjYdGy6QrhSMcjQujwHm2zGRn22DqfGDF0lAa9uWCLyNMLO?=
 =?iso-8859-1?Q?Lbgj3lPkMNlMS6ZM24SSPrYN5/3WAEBeMSnIytTcG47AywPHz5uobRv1xV?=
 =?iso-8859-1?Q?4zgqctW3SX/Gf7Jl+jLvJr/jbQ+eH6MAJGukj9Lu74jHDAixvv7EKz/b0g?=
 =?iso-8859-1?Q?Zraw7c9smFptFNosOG3TurDZ81xkkX/44Cxi7IzT5D2RTlZ5PEuyDCIKGy?=
 =?iso-8859-1?Q?aG0FSfgsRD2acaKaBmhxoCQp6Oc+XHAXWpbGiBNrBJdGmIQ8CY1ZRuMWjG?=
 =?iso-8859-1?Q?VcNxzt5GzxSxr2eLhjrlF9usPoE+j8dgESbDbaPbzgEpg9FU5lGkclZj20?=
 =?iso-8859-1?Q?ITvQzgsHO8b89QwC6tlxHJ9huQKuFhG9aqdoAY5Jy5a42+q+V4CUn0RUQN?=
 =?iso-8859-1?Q?F4hF0NFibbH1R28XpoBbBH0wk3MnnqELzHj0bxakwMSbdjugV3iL0KlPZ7?=
 =?iso-8859-1?Q?ZQ1L6pQvIeINe2V6ZGILcQdqDATTA/41ejTHlgBaczRSBNAbJ6txxEC3C6?=
 =?iso-8859-1?Q?dZnyQ8WfS2QEPWgJeOnX8aZ51lRpFw31rLDXfWxxn7z+c0susc8RIQ9pTF?=
 =?iso-8859-1?Q?FDqD/HUc0DApNbgOCu+zR2SXvzIPw1eaWmMWu83vXyk6uCOUu4eNfq/XrW?=
 =?iso-8859-1?Q?07GUSNCT6xoxFb93sTuDmGB2xwZtGdylnW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e09035fc-a077-494e-c915-08dc7abfb9a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 00:31:45.1941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d7bbaf1-8dfe-40cf-ac5e-41227cb807ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6V2mFVEro2Os8NmDeCXwFDs+XsoOlEA5gAUvGqgYNln5MuDlb9jCMXSZxSyaZ3Che+C3ZiEPqe90PQhKjUOtn3gqERx6vHeSInZmQd8DpvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4254

Hi Andrew, =0A=
=0A=
>From:=A0Andrew Lunn <andrew@lunn.ch>=0A=
>Sent:=A0Wednesday, May 22, 2024 17:57=0A=
>To:=A0Daniel Glinka <daniel.glinka@avantys.de>=0A=
>Cc:=A0netdev@vger.kernel.org <netdev@vger.kernel.org>=0A=
>Subject:=A0Re: net: dsa: mv88e6xxx: Help needed: Serdes with SFP not worki=
ng with mv88e6320 on Linux 5.4=0A=
>=0A=
>On Wed, May 22, 2024 at 09:14:06PM +0000, Daniel Glinka wrote:=0A=
>> Hi,=0A=
>>=0A=
>> I've been trying to get the SERDES ports of a Marvell 88E6320 on a custo=
m board working without success. The SERDES ports are connected to SFPs. On=
 the >>board I have connected a network interface (eth2) to switch port 2 v=
ia RGMII. The DSA switch is configured to forward the packages to port 0 wh=
ich is >>connected to an SFP. The forwarding of the DSA switch seems to be =
fine. I've tested this with forwarding to port 3, which is connected to a R=
J45. This works >>fine. I can also see that the tx_packet counter on port 0=
 is increased, when running e.g. ping. Therefore it seems that the DSA conf=
iguration works correctly.=0A=
>>=0A=
>> The SFPs seem to be initialized correctly as well. The link is reported =
to be up and I get a link change when disconnecting the cable.=0A=
>>=0A=
>> [=A0 247.782415] sfp sfp0: SM: exit present:up:link_up=0A=
>>=0A=
>> The SERDES connection is configured to 1000BASE-X.=0A=
>=0A=
> What SFP do you have in the SFP cage? Are you sure it needs 1000BaseX?=0A=
> Most fibre SFPs do, but if it is copper, it probably wants SGMII.=0A=
=0A=
This is the SFP cage we are using:=0A=
        Identifier                                : 0x03 (SFP)=0A=
        Extended identifier                       : 0x04 (GBIC/SFP defined =
by 2-wire interface ID)=0A=
        Connector                                 : 0x0b (Optical pigtail)=
=0A=
        Transceiver codes                         : 0x18 0x00 0x00 0x01 0x4=
0 0x08 0x00 0x80 0x00=0A=
        Transceiver type                          : 10G Ethernet: 10G Base-=
SR=0A=
        Transceiver type                          : Infiniband: 1X SX=0A=
        Transceiver type                          : Ethernet: 1000BASE-SX=
=0A=
        Transceiver type                          : FC: short distance (S)=
=0A=
        Transceiver type                          : Active Cable=0A=
        Transceiver type                          : FC: 1200 MBytes/sec=0A=
        Encoding                                  : 0x06 (64B/66B)=0A=
        Active Cu cmplnce.                        : 0x03 (unknown) [SFF-847=
2 rev10.4 only]=0A=
        Vendor name                               : municom=0A=
        Vendor OUI                                : 00:1b:21=0A=
        Vendor PN                                 : MUN-AOC-SFP+-001=0A=
        Vendor rev                                : Rev1=0A=
        Option values                             : 0x00 0x1a=0A=
        Option                                    : RX_LOS implemented=0A=
        Option                                    : TX_FAULT implemented=0A=
        Option                                    : TX_DISABLE implemented=
=0A=
        Vendor SN                                 : SA1708250054=0A=
        Date code                                 : 170825=0A=
        Optical diagnostics support               : Yes=0A=
=0A=
>> The link is reported as down but is directly wired to the SFP which=0A=
>> reports the link is up.=0A=
>=0A=
> How do you know the SFP reports the link is up?=0A=
=0A=
This is the SFP state:=0A=
Module state: present=0A=
Module probe attempts: 0 0=0A=
Device state: up=0A=
Main state: link_up=0A=
Fault recovery remaining retries: 5=0A=
PHY probe remaining retries: 12=0A=
moddef0: 1=0A=
rx_los: 0=0A=
tx_fault: 0=0A=
tx_disable: 0=0A=
=0A=
When I pull the Cable it reports link_down.=0A=
=0A=
>> Therefore I forced the link up in the port control register.=0A=
=0A=
> You should not need to do this. You need to understand why the switch=0A=
> thinks it is down.=0A=
=0A=
>> We are using the 5.4 kernel and currently have no option to upgrade to a=
 later version.=0A=
=0A=
> If you have no option to upgrade to a later version it suggests you=0A=
> are using a vendor crap tree? If so, you should ask your vendor for=0A=
> support. Why else use a vendor crap tree?=0A=
>=0A=
> What is actually stopping you from using a mainline kernel? Ideally=0A=
> you want to debug the issue using net-next, or maybe 6.9. Once you get=0A=
> it working and merged to mainline, you can then backport what is=0A=
> needed to the vendor crap kernel.=0A=
=0A=
We need a feature which was dropped in 5.15. But to debug this issue I will=
 try to get everything running with the 6.9 kernel.=0A=
=0A=
> So, assuming you can use 6.9...=0A=
=0A=
> mv88e6320_ops does not have a .pcs_ops member. So the SERDES is not=0A=
> getting configured. Taking a quick look at the datasheet, the SERDES=0A=
> appears to be similar to the 6352 SERDES. However, the 6532 only has a=0A=
> single SERDES, where as the 6320 has two of them. And they are at a=0A=
> different address, 0xC and 0xD, where as the 6532 uses 0xF.=0A=
=0A=
> You can probably use pcs-6352.c as a template in order to produce=0A=
> pcs-6320.c. Actually, you might be able to extend it, adding just=0A=
> 6320 specific versions of:=0A=
> =0A=
> const struct mv88e6xxx_pcs_ops mv88e6352_pcs_ops =3D {=0A=
>=A0=A0=A0=A0=A0=A0=A0 .pcs_init =3D mv88e6352_pcs_init,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .pcs_teardown =3D mv88e6352_pcs_teardown,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .pcs_select =3D mv88e6352_pcs_select,=0A=
>};=0A=
> =0A=
> to the end.=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0 Andrew=0A=
=0A=
Thanks for the suggestion! I will try this.=0A=
=0A=
Daniel=

