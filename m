Return-Path: <netdev+bounces-78351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9C874BFE
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9612828AB
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB37127B7B;
	Thu,  7 Mar 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V9XPk3fB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CBD83CA7
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806168; cv=fail; b=XkZzGCjOp1iKHOYcPM7yGSAkrA3DWBd+c3wbe9JWZ3rPVkdhWnZhX4QNgz+UlzqLDEFPU2sGz+2cQeQdkE+v0pgVwrOQpkfGDWn9fzJRXucAMsfW6RtugQH1Ylzgwl4HIitFsR6mbCdmFLyJ8/msAfUOBgWKafqtIb1Xk8/XZOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806168; c=relaxed/simple;
	bh=2A++8BBoC/R/OoqYqiQp7lslUaMtWabBf0sjPtmStAc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mcuILIq4S+gsvMKs0Ag+aGu6t0ZF+qoBAIjEo3WkwlTVoDW/dtvr0tQfdxDFoMPP08fHhyN1x/+bHyQ/aSnKKQGdiNy954bSwOayR2putRO3KfsOO92rII+pNx0nL0QOkgkfdfiFKKC5d7u8ef2WrIxBTfEFg/cbH90JJMiLYu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V9XPk3fB; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4279OrGM025090;
	Thu, 7 Mar 2024 10:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=qcppdkim1; bh=SdrrizE
	sOEqEwA93UXBWBTFDTbxepnMp29CDufEW0Qs=; b=V9XPk3fBBVaHZgJ8HDnagNM
	N1jjZlw5ix3hEseTMG5Gf7c307h2NrG/xyXfVAbos8QNRVOCIFEWwyEGdQT77Vm6
	tLSf/0fzNtIKHDOKn8iCHHMFXqkQaScKh0YWaJpmeUA2g7sWtMELUc6MtzfcQMFF
	Bi//I2Z7d5+FgE+7f6jsSV02jsnELLeZdA0hhRJJQBteLxPaKqS9uHLJBuj4tsOz
	0vjFuXSbizsXWliI87IjkS2T4uf1ojBpK5qp+CtqpZ6tockVt8y7zENWD5A/CToI
	DbAUKiuT7fSvNejrVuB3Dn8+EPIt7YAmJXIBYjGwetDdTHkXuHUDJzHRytyX/Ng=
	=
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq7hurjwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 10:09:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvlqdeStl7rX8P8REfpQbO+SvcGcsrWg0SpvG7seUF0hDMFI563EABqGkbjFzkilo7Alqt38Do/P830wHc+ZeGiGceOt0ifzFDTsjMlUhaRXmiMCwicx/5Gwf559Hcn6iHMEyOBgRkNoh+JHbzLUCQpcrtGDGdg/enuCqiOjCKCSwo4vvQ79tuI4pqofjaOeNS3T2Ej6505PKA2o317er/uNFs385pvmkSDraHHrz4I3sgzhgRO8h7w+xh/L4SAixsU8HztbyQHagE0LVZSiecsjyI03/sKwTJEZHWJ9Bf/qHeiyCKukbc4mwd9Hun+qm2wWqTKX4NcCLaUlQUe+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdrrizEsOEqEwA93UXBWBTFDTbxepnMp29CDufEW0Qs=;
 b=md4eox7TehEQWqaIaj9fjKZItlMt/NM+e4W89cYB7YOoaDVZUEQJ/KEyXqO6EjkEMs3V4ukyYA06iEWB/xYVFtyFjmnDprA18EbfjijGu/cEqpVpVOshS1gXF3ACtBtZVHl4VsCdhuqmQ/G5Z8l7V8FhsNoyGJ6Gz+EB6WiYSdsx7acpd6JtyVpX0Sw/wU6/VzgKkWrDaG45nHar/HfRb1S3d+By++uGChGtB7XYT7SRzip1MV5Upp1H2GpYrJAzX2mFoKBoZvxc7HW/O/GqzD1J/xMeKts+o3eguSRZbf2nfeoqQ0Jfzf//DJHWMLMeNCFgyrGSjumgKZ1PLxeg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CY8PR02MB9567.namprd02.prod.outlook.com (2603:10b6:930:77::15)
 by SN7PR02MB9330.namprd02.prod.outlook.com (2603:10b6:806:34f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 10:09:18 +0000
Received: from CY8PR02MB9567.namprd02.prod.outlook.com
 ([fe80::7a26:6c6d:8ed0:e100]) by CY8PR02MB9567.namprd02.prod.outlook.com
 ([fe80::7a26:6c6d:8ed0:e100%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 10:09:18 +0000
From: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>
To: "mkubecek@suse.cz" <mkubecek@suse.cz>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nagarjuna Chaganti (QUIC)" <quic_nchagant@quicinc.com>,
        "Priya Tripathi
 (QUIC)" <quic_ppriyatr@quicinc.com>
Subject: Ethtool query: Reset advertised speed modes if speed value is not
 passed in "set_link_ksettings"
Thread-Topic: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Thread-Index: Adpwd4LZ0sghOKL6QDSCL099ROM8fA==
Date: Thu, 7 Mar 2024 10:09:18 +0000
Message-ID: 
 <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9567:EE_|SN7PR02MB9330:EE_
x-ms-office365-filtering-correlation-id: 2c7745c1-7c4b-4408-9583-08dc3e8ea6c2
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t/lv1wy6+NRS8sCv38H/Z9eXJ3xXu6yUFWUUADBSHjrgUCQgBg6N9tFHnetRwnwPDgL2aV9X13N9lQiVXjIyt5nrx3/KMQ1xYdX9maeNxHGoOVnUxnn7+h4IVTKmo9KGj1qrkCTVwzIFpN2FyaOihZq2gSUxEunyb2/sY1HXR1HdGeY8YZ7XxXmaergBvIt6VNVqxMc0W//8rjbc1zcGotof3jl3zNQfO+J0lNfhMYWkqFt/6jqo1jA1eXaOOyOS4qmJ2e4GH/6f0CeLhRoQv87PF1C7BGQ8MOvT1VukhLmY2m5iAZXtUblPmai9mW6A+D5lIXDsfwKUQFwCM9j6vj4m7H3iWVCd8xswHTzBrO+XBMndZpmSaUVGmjtF7U+eBoOEdk0mSwOhZ6vSw3C78rh7tM+xFkJxdSogELu+hqIwvkUHs5B8Z0aFVTTgGrIvMYRYmkm6MCPx2gntovd6EXowdaQrfdTRe0LbWAnJ0b9phZlNfKW2uF6VSiRa/g14ZGbkhxeYU6ivrKIEGL2EI7ueDEE9TUqKxS7cVXoA2+nvSSMiowSbR98Nke4zwR7pULxhHNMBIWsuPL5FGL6jequOvC+6hyQ0TWAV6+b7VL8IlxmyeRz+iCjByzARltF4rZTpz+8eY+ZSLW08uQVqP35nfq9O+7QM/prptsFBS6Ie+YwzlEjmC0RjpU7Uk2msndo49p+aXBRm8CPQe//ibSrgIzIA8j+o0EPsk0qhqA4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0AV5jM01yHa3n5ulyHgltzpPzM6BCK60IDU1w1g3kMuW5H58QQp0cvQZK6Xv?=
 =?us-ascii?Q?eVJodvU6CuOsKjrO/zon3pJDwQ4co1urJwUvGa52Q/woR5/xj0VFYA1Peyp+?=
 =?us-ascii?Q?NA66fhH5wVxCW/9GV1BAzuVGnjaPYKeODYaA4FyGJ93Bu4Oj1uOYbd1O06Tr?=
 =?us-ascii?Q?MndlCptSZHUAQBjgThrgzKKE3TXRQGp4koyIxb68oBHfbG9Pt7YAtoVcRsYS?=
 =?us-ascii?Q?g1Wp1LspokjNQ+S7nt+HCXAueTlIbrFGm4/3DpAosAsE/uAhMjaXT8Tge7I1?=
 =?us-ascii?Q?p2KBV2oMfhPbOqRm/9Q8aepoPLrObZc2qjwaRYFj/oAOiIoqq+WvxqSI6t4y?=
 =?us-ascii?Q?5wIRcCtSytpiC1ssyPmQHcz6GCCBYowtrT/wGNuR8ZwcEsTJvds6190MVbBA?=
 =?us-ascii?Q?C5MZvOl4cD22XBhtXCFdpxZNcaO+EAM3SZ3cv0uJUA7mHTPGibRHuR39HA6y?=
 =?us-ascii?Q?u+LOuUiuF9SMrs3vJsBpwiYCqQStr2Uu251pjz6IpfP8BWgImZ97+Z5AqfAK?=
 =?us-ascii?Q?G3KRvgOfFxe24w9k486DB0uIc0P3LBD70DcxD1K39oYjqUfT9m7XCg4y4Gji?=
 =?us-ascii?Q?O6pUb6kHmjUpzGG8p475GLwRE1KFeTIpWFGOXqIsrJ8JhR1IHQKXeSrR4U6Z?=
 =?us-ascii?Q?H7Z870HGWx9aH8EY+GbvV8E6xkGD8KNZsz0ptUe8tvujMvduPK4NkAurRTY5?=
 =?us-ascii?Q?fr8p14bUUUBEI1WHHQCG2/9VgHFjzFeqNpGODMLirm7lJDky9FkcmI14yzGr?=
 =?us-ascii?Q?re+d0cIeaPew6t2fxxqJlHXkamq9DMMmlDrYGicTcMeR8eMWuHIudIYHet2m?=
 =?us-ascii?Q?XHiZ3qr0bwy75RDy3j+uSIHEOOgk275ZxhfwBz+qT0Sc4BsoELXbyiq5ZpTo?=
 =?us-ascii?Q?ONFZ59EGzUdrFoNVqsyQgNX+MAS02h1XaN4/qoTPuqCSVcHaxlal5ilhRus7?=
 =?us-ascii?Q?itj3uYhWRzXxexgz0/246MU+AFY4a7U37WMMaHycj/WUeEwYoCOKdaKaBJx/?=
 =?us-ascii?Q?+FyUlvPGoBpn8r4g3w/3LMBMAg295iyO7OXl4zHqq7NNIyI4HSvpxjBOreJg?=
 =?us-ascii?Q?OrJUjU2DOQ6Fh/UofUNR2bMGF0bkCr5AuMStNMxvWPELnmUmfFI5+mPygXZb?=
 =?us-ascii?Q?LnJ552ENlLNg2MfR7M6bPP3ezSqtgVLNZ9p+l42GGbdNPkZUM1TgyPUqRAaK?=
 =?us-ascii?Q?/qdXdTYteDYFwJXE9Tq4W7e86tHFv0yMctL3H1fVkBmRf5Ondk+p7f0tN/Zp?=
 =?us-ascii?Q?8JJ/IVqcSFtOETxbswAuJrebOQB+RV35zj1r8bMKAz8HG5EROshzP7VYKTm+?=
 =?us-ascii?Q?6pV8vo7FYa9E/Qsmk55X7RuZfQTAGa1KfHv5WPi2OZbrGbyVs4BaY/g/zVoS?=
 =?us-ascii?Q?M8hjqGn1dr96M0J6JX0zOPUbBGGtzTG0HkFIwkRAEk17OcZsAYz0lO41Onf1?=
 =?us-ascii?Q?tm1Xjh6mUS842GVw+6hYTkoGLzm5lTRGga8ADty9KLOTFFPKKDK5ZdQcqp8c?=
 =?us-ascii?Q?ZWs23SdAClb66HD3jNyFkJ4vcy1HV6Mgw93LE904kx8PKPn0mE2LIPTgHArx?=
 =?us-ascii?Q?fFcbts9Hi5uQu6cyhcBdxcEjpFBr7lOYYuQnKBOO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6qOy0M1WmWOugkYIuj5xP/WtO4Jni/z6OfAISlZ4HDLLtIHXpc+4S7y/bfn4BSpW4MCyfweBD1GPoxDVttTHsdExnk7gwCB1WqLQYEHLxK7sS6dOJpBrP7Ux8LF7m9iyAMNvnmyJ5qHS+e2yzsz6n5FibieIxglVJejaH6xFC+Y8wc9bQ7fRdPeCj01Wg/gCWAmMkuij3lwUuhq+/estCHVXQaZyUdsgxK/jUpZmOdkkDyz+EqWOepu8zz6ZSDhz/qyZwlBo55MgwZ+q7BFvraOT4uT5nP5QUQxywrsKXYXHQtgcBAQ4lwn5QvEwfDIRcMT+ZYBJOL/aAAIvcZCS/SxHqi63M4QYb08nwwo29dChPCTafl3iK8+wMFvn8+bjTQwOKCQmo0Rw+pKpQKm3+c3bVC3JMIHG0TA8FsFLk5puvglkzuXCNDmH58r5k7kN5ktUQF2y9UQhWQdO1HxIxjXjt6c7X1lOeBi0C0YynSgNqtnVDvoqGeHI9A5X5LXLnf0Lpjq9Xfw8WaCv2OD0lINWM/LwInLdaY93DdKkR8hZM0uHm9opvreGgtcevI6d7DFJIx3ErgNUyI/YUeXP2xgrN/+msmQlpvd52cN+69W2Zk6IlQjPDTHbTKhxJF0W
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9567.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7745c1-7c4b-4408-9583-08dc3e8ea6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 10:09:18.3229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5oYoXDkDmh60geeuWasiWyOIHyBNWQF6aKaN/jTOqYlU4blTkyDCTxrxsxahXnfuf+KUye2Iyr6ZmNPrTxl0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9330
X-Proofpoint-GUID: B7T3kA8V5G7ATVokds5pEjb72Ie1bb4g
X-Proofpoint-ORIG-GUID: B7T3kA8V5G7ATVokds5pEjb72Ie1bb4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=957 mlxscore=0
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070074

Hi Michal and Team,

We are developing an Ethernet driver here in Qualcomm and have a query w.r.=
t one of the limitations that we have observed with ethtool.

Requirement:
	- We are trying to manage the advertised speed modes based on the input fr=
om "ethtool -s" command, and trying to support options like "speed", "auton=
eg" and "lanes".
	- By default, the "get_link_ksettings" will publish all the supported/adve=
rtised speed modes.
	- If the speed is modified using "set_link_ksettings", we will limit the a=
dvertised speed mode corresponding to the speed being passed in the ethtool=
 command.
	- And if in the subsequent "set_link_ksettings" command, if the speed is n=
ot provided, we want to reset and go back to the default state(i.e. again p=
ublish all the supported/advertised speed modes).

Detailed issue sequence and the commands executed:
1. "ethtool eth_interface"
	a. Assuming eth_interface is the interface name.
	b. By default, the "get_link_ksettings" will publish all the supported/adv=
ertised speed modes. Let's say we support 10G and 25G. In that case both sp=
eed modes will be advertised in the ethtool output.
2. "ethtool -s eth_interface speed 25000 autoneg off"
	a. "set_link_ksettings" will be called and speed value will be passed as 2=
5G.
	b. Advertised speed mode will be restricted to 25G.
	c. Link comes up fine with 25G.
3. "ethtool eth_interface"
	a. "get_link_ksettings" will publish the link as up with 25G in the ethtoo=
l output. Advertised speed mode will be set to 25G and 10G will not be incl=
uded in that list.
4. "ethtool -s eth_interface autoneg off"
	a. "get_link_ksettings" will be called and as per our implementation, as t=
he link as up, we will return the speed as 25G.
	b. "set_link_ksettings" will be called and speed will still be provided as=
 25G(from step 4a), even though the user has not provided any speed value i=
n the ethtool command.
	c. We will still restrict the advertised speed to 25G. Whereas the expecta=
tion was that we reset back to a combination of 10G and 25G again.

So basically, we are trying to understand if there is a way in "set_link_ks=
ettings" to differentiate if the speed value was passed by the user, or not=
. In short, a way to differentiate between:
	- Speed value explicitly passed by user via ethtool command as seen in ste=
p 2a.
		v/s
	- Speed value not set by user but still being passed after queried with "g=
et_link_ksettings" in step 4b.


Can you please help investigate this query and let us know if you need any =
further details. Thanks in advance!


Thanks,
Sagar


