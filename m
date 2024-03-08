Return-Path: <netdev+bounces-78612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AC875DFE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6654A1C20CBF
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CFBEACC;
	Fri,  8 Mar 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iYJILN2a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52434367
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709879592; cv=fail; b=dplB9uA5EVEe/ctYwfzM55WGQxEdemRzAHmGrx/aWSTDdxPsdr5PVu0j4Sv8zhDQprFAU09S8V7tXa9vv9uvXOWTr1OvpWsRdupClgOBwZ6tRF2UaV60caAC+Nrd2D4D7wwBfqsnec6riwQJ+q3VRoQEJzwHGIwnubKgCO6n4h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709879592; c=relaxed/simple;
	bh=6VHoa2KRa+E1ENLFfQnK1ixfpZAQFywSVRjaGZ0Fm40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qgLTAfrSk3WyMCAYfllJF1nss/0/TaKEmZgEOEkaNkUHMgG1wo97DFXWiwDUZqrlK6OcLNiWzmMrrQ1D7J6AOr23BHbfR+qDi+DhYpdV3E2Y5Uto0ZslYHq7Rs5aUnHtod8MbJ9hyVxTakMtYoDHTnkLagHusy4h4SQO1vUFno4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iYJILN2a; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4283qLMK017205;
	Fri, 8 Mar 2024 06:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=yg9NT92pKeL1je6gsV9onbcMTwvWIWGGNHDQe9xd6wE=; b=iY
	JILN2aQEiQ+vIqFMx5sPbBwTustcqqleqXwg8J33JVH1Wp6y6fGjeHvZ++m+bWJC
	RJY71jAVgjtMZQPFZKfU8sZS3MTGRRm8TqFJzjDLEhR4dI0oCWxWJI7IlWOXsQ3I
	1NAwJdPjyGQ9t957nItQVYbRiuB3Y1Nu4LmnvYB+ayZsCEuS7L4+d6xvc9wExfdK
	vvLiJVTHQoT2Ss28zwsA+9LH1OM1mgXNiwX6ZeUct0Eig/ONjtma+UZk77EEwdQs
	bci4wPBZuCENOa8iWgQJ9LzwpsnlcTm1IM9Qgb0SLAlG3dC69h8VVegqHTJkhbTu
	NzIPhja4IGhCvVWosNAw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8qgyjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 06:33:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeUDEwukB3hx0ToGFtYvlwEikGifKbe0yVnE+qD27MwisDoNGjmJIdmAHlWsvtgn8jhlo2Oi8E7wudtErpgIvWRD5HL4c3ac8yZVn7yYmPoeIbybdxqIDJakdrOM5DmDpHpaoT1GKFFFfnBwvzz0uZARHnOEdv78i0k14MkzF3aycKOptwtXJYS2V68LntnQDSvofioUPzIvgmvUcVF+EZsXVr1mcZ81F/QyXDPRxBos+wCv3dM/18W+nQLD2lpssA6VbwmkP8SKVMXVkpJGF/TIJ6mVXXnXkguOKOIiYe1alehDwnNfe8R5yFofdXN5adFEcwCvND61UpoUMejrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg9NT92pKeL1je6gsV9onbcMTwvWIWGGNHDQe9xd6wE=;
 b=mqmMTgI1AQ/sURqGZn7gRYcmXwvv5Vv8e2ED7C+yzCLSO5sLv9AL1SeJUgsdDFSmyyvdyYYb65OGBuKGc55UKpG0dK8ZXUERpgWcIAO9DLqs/CCJfF0ZkBnFW4Rn1ucOO4fO8jhgswu15pDV9GuUch1LTc/A2V7yskU0AVmEj9jQcoCcH0c43508d5CzdcvMzj1tYE5qaW9sTAh8U8BZnMtwLZxafra46qmOFmoedp9fwxmZazQ2yaCVkSTqo+j+88cwb1/SFNJTvkv6uhE7AdA6xj+CZ5RFJMlWAKLmx69v0BQ/LjZCryFGkqYP5WnRIr+vaSUGMps5NCt+leVswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CY8PR02MB9567.namprd02.prod.outlook.com (2603:10b6:930:77::15)
 by PH0PR02MB7398.namprd02.prod.outlook.com (2603:10b6:510:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 06:33:00 +0000
Received: from CY8PR02MB9567.namprd02.prod.outlook.com
 ([fe80::7a26:6c6d:8ed0:e100]) by CY8PR02MB9567.namprd02.prod.outlook.com
 ([fe80::7a26:6c6d:8ed0:e100%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 06:33:00 +0000
From: "Sagar Dhoot (QUIC)" <quic_sdhoot@quicinc.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "mkubecek@suse.cz" <mkubecek@suse.cz>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "Nagarjuna Chaganti (QUIC)"
	<quic_nchagant@quicinc.com>,
        "Priya Tripathi (QUIC)"
	<quic_ppriyatr@quicinc.com>
Subject: RE: Ethtool query: Reset advertised speed modes if speed value is not
 passed in "set_link_ksettings"
Thread-Topic: Ethtool query: Reset advertised speed modes if speed value is
 not passed in "set_link_ksettings"
Thread-Index: Adpwd4LZ0sghOKL6QDSCL099ROM8fAAl41KAAAQKzNA=
Date: Fri, 8 Mar 2024 06:33:00 +0000
Message-ID: 
 <CY8PR02MB956757D131ED149C97F7D0DBF9272@CY8PR02MB9567.namprd02.prod.outlook.com>
References: 
 <CY8PR02MB95678EBD09E287FBE73076B9F9202@CY8PR02MB9567.namprd02.prod.outlook.com>
 <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
In-Reply-To: <945530a2-c8e9-49fd-95ce-b39388bd9a95@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9567:EE_|PH0PR02MB7398:EE_
x-ms-office365-filtering-correlation-id: a85eb25a-ad91-4508-5741-08dc3f399996
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KEIp/j0aLBAX7+Yb2PVsZCfZ79EZUFy+0tFqVCBVmmnIrB3uVOlrXG7v0pELb6TW6ilSSpMv/HtWww6QbGZaGiynY9JDmfyoqeuVOonIDPe9XA9XiKppXUiT8hBhooghMr//GMqYuu4PndfU2bB4UWVMQCPIaH+jj3IqHX5tBgYMjNayfWirasVMC5epS16uzbsCeqccq5WH8MeojxgBrH4wgLejYRYZcuuA64n+qBDX3vlT7wiijGIhlDmnX3oN0wT07iNJFDSvZocA64qTv2OuMHxffnS6uM/Fe42b20uEhjjY+s4Jva6rkQY0cJHswGHv3lyB7eakqebRdib/uvnxEfnwuqAGW3QMIZBZhKh3Q2EMEa5yPnwt3FnXUDIoZYJoMU7jsFMvlI8vaTd/fwAHc5v5Qh5eraKK0XAEo0oAYBWvdEk7VW+rMpy8a1ZPfddbeZpwvS4wWO8wcIACyzLay6ekDAS039EBMvtGYhLtMTIfJEfMVnj9k/9iLt65Ckuuc57Iwvb26dPEO3VqqYrf8m5DpxhE2EP/VeKtGz5G5EuggagLi7GfhqPgM1J2LkFJ5vJUE9dP3lrBK+V4Zdv8qNExC6i79LVJOqKTK3zvkkY5WyDjLPV0Xva2rALT+rVTRlYA8X+U+eS/Ul76gHQtuf5peQOoVeRD4bgQVEdDkUXDJgwhj1V9j66PtahNd27xy8DRaN5UeO7Iv/N74L4vJZXYyKyEBB0B14Eb0II=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9567.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2xXbi0vbIBtL5BdenCEBZZr62U8+Ih0HznkZ//wCC35u23WXD6JVWmjIn7/1?=
 =?us-ascii?Q?L9B+P4rwKFyXcX9hnVNH2MA7iZRDWslOaKELKgUSyv/uHrhlwMJe1D2+jVS7?=
 =?us-ascii?Q?2MRRToDDCFdfcwHWSLePRR675Bos/q5CNEmXVoNzq/QOdnx45XxBpvjzELR3?=
 =?us-ascii?Q?k5k3daKr9WcvqWpoFL0vDclWRArdGfjoAAlKhLeRb2ueyNHcOmFX0ngBtxdb?=
 =?us-ascii?Q?TnjigW76Q0htOw230yE9btk2o82uNLbtKmFZGVjmUK43idAPWgTv7hHmn2y3?=
 =?us-ascii?Q?StjvSjs4vtdHuVQ2RZoFQegACN9pAzxCB3/64I4oiL1YHoeC5/Ca7xjPJFwB?=
 =?us-ascii?Q?3mq3NG7u5RhmptYjdWv4N33sRH4zv4uBuC0ZJ4KCTdwSguxHjdfEUSKXvPBi?=
 =?us-ascii?Q?VeP0od3FqviSmDpgunG8rxjsBLln619PqwT+QW3+g6BTIRU9o95KIuyxvAyV?=
 =?us-ascii?Q?pBeJeo2XGG/5kt9DHtxLAT5tzlWRCpiwKyfEn1w0ycIzqJsvWRjYC1e6dKZf?=
 =?us-ascii?Q?R+SWQB7T1/6kRIOWL1VrJinzBLPZwKKOoSCm1AJBR2zpygkmPUAV/QL43aoq?=
 =?us-ascii?Q?tJkSG7oLrWxwGPiINg+ZKRhe9lFUH0qAZUgD+aviELFB6ldezDob1vRq/+FN?=
 =?us-ascii?Q?nIG7k3bEcjINsKgQKvmrLE2CojMPs7KCsSrT1ItQZClorXBK5u2aFSWzg7Ni?=
 =?us-ascii?Q?Y14AE/v5nwhhzUxOlmfG+pmwijIYg8tnqFaMQQQUNI36p1KVbE8b48uzswy5?=
 =?us-ascii?Q?vnkYotr1LFPKJjlEI+UOqZYH5BDdgi1YvOgkcHZINiP3wIQMdQgnOaYS8Jvd?=
 =?us-ascii?Q?ZW6s5T0JMgmmS8j3+Ks/9ar+PTPH01iEB6HF2qPG6kEk93rUU7PoPPFPzOly?=
 =?us-ascii?Q?0rPHjtymctKJRnqi52/41Y7xJNlyh6ZfyUgIUitoVN4nO4F65Pt3LzPamvV3?=
 =?us-ascii?Q?5Q/RpM/v5afH3YBd2axYcOtR6JoeSl5BUf23bwEfgSUayEXXKg3Ye1nId5b1?=
 =?us-ascii?Q?1oEnwI/S+05PUgFB5tfWc7zri5CJNOA99Ukxq9BVKHwOv0UqEi96G+qu8W55?=
 =?us-ascii?Q?0FxX/0iL5QO8mKerthLqF5SmfX6MgZOcEbx2AkTSG9kqLfT+DnQqaKIr0EHA?=
 =?us-ascii?Q?r/EpUUvS7S9MS5lNbw03Uh1Tt8wZioY9QWHzF7tR6oO4ZtP3d6RVEJZD/oqi?=
 =?us-ascii?Q?NCszf1i4WK5OaC+CNAPm+ikEumPb9h/WfzWoNhnSE6pR6oslIFhuJAA6EGiV?=
 =?us-ascii?Q?mdXagazS18d4FXc7AMikmcb0+goIk4OqnZfap0MJ/IYKQwwSO39bc7UkJ02E?=
 =?us-ascii?Q?R6p4MioGTKNLYBtk35AT8OaHbZwy8RZmqehUqRvHcva3niVgaZNU5ss7uSo2?=
 =?us-ascii?Q?nr+pL5ogaF9aUqZA0PtZ5pn4InqCOLvbbue+t5rsUDbox2i9M0ElPoz9vZC5?=
 =?us-ascii?Q?Jpawk+eSDQtYJc+NozWmPY2zp0HM15ZmQ/yJOwh4h6I6wbPQZR1Sdm/uubLZ?=
 =?us-ascii?Q?2W3oPWxZnPTtPlkPbLB/BW74A2QjwywuAhN9JBo1fMt9yqyf0wdaosVbUmJG?=
 =?us-ascii?Q?4/d+ycRM902a1pX9+kNsFariQGoqXKSpIpTLG06I?=
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
	P+7GEjO2QRSoi01j7eYDX6Hv1YmKnH+wNLVYqwKHuD9KIF+Jj8fRuzQYhKR9bDoj+ImeuKyMtEjBZJjAOfvjNcHouNbtK8/9OPFXhGFKip7mANABsOKHSXlJXZDhF/dKUHGJc6cRIzufLXsk868Ji3AZ1ioNWcRuIZA02qS0KsptUgJ85YO7Fzo/ZDejYZLPzkn81RXCtyACeCo8rHkjSLeo4lmuksRNB9tLgQWnnxr0AXF2hauWs1OPxuBLoJqGqC3D7tCMpAuV6IU+aR+XqBbpxpY7k7GYx7fmh0ol28LEJdE3bnsRYFB95VSfOOE9sbG7FMseLKA7seoiBMxeRCGXqeVMI+IOYFYJr+2cAYJGNcHvgNFpzoBGhC2Q2oMiyJaGYqkJzOs6EqmmGud/7qpZMiXAxNhBdibR2wT2y/Scwkd91SU71d7hTOkWlBG9W5wB3Uo5EqUW3jrgs/vWyugE6xVfzUombvzQ3XWY+OsGoNqn/2z6SpbomatXP4Dnxhtr+yw7k+iv/ZA7sFW3jlkHDx/OBdKdFq/zPitedVxXF9VCziEzmaDyeMBFQt2WjSjP6RbNCrnmTnVvZusAJlOOFlNskhdcJz59t1zflq8lTWOXOBXh1qMibrKDioBb
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9567.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85eb25a-ad91-4508-5741-08dc3f399996
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 06:33:00.2121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWAqfC3F/KNtbk3f1wsSu/zXr5CCbBqS2hOGYN+lf4tYh7pACAMsUpP7QnYt0lg4ITMqFVHu0wGMUW6588dAIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7398
X-Proofpoint-GUID: DFzyV5sXRRUWuLO6Eg9SBng1dK5Vugee
X-Proofpoint-ORIG-GUID: DFzyV5sXRRUWuLO6Eg9SBng1dK5Vugee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=878 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080050

Hi Andrew,

Thanks for the quick response. Maybe I have put up a confusing scenario.

Let me rephrase with autoneg on.

1. "ethtool eth_interface"
2. "ethtool -s eth_interface speed 25000 autoneg on"
3. "ethtool -s eth_interface autoneg on"

Once the link is up at step 2, "get_link_ksettings" will return the speed a=
s
25G. And if "set_link_ksettings" is invoked at step 3, it will still pass t=
he=20
speed value as 25G retrieved with "get_link_ksettings", even though the=20
speed was not explicitly specified in the ethtool command. So, after step2,
if I must go back to the default state i.e., advertise all the supported sp=
eed=20
modes, is there any way to do so?

Thanks,
Sagar

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Friday, March 8, 2024 9:44 AM
To: Sagar Dhoot (QUIC) <quic_sdhoot@quicinc.com>
Cc: mkubecek@suse.cz; netdev@vger.kernel.org; Nagarjuna Chaganti (QUIC) <qu=
ic_nchagant@quicinc.com>; Priya Tripathi (QUIC) <quic_ppriyatr@quicinc.com>
Subject: Re: Ethtool query: Reset advertised speed modes if speed value is =
not passed in "set_link_ksettings"

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Thu, Mar 07, 2024 at 10:09:18AM +0000, Sagar Dhoot (QUIC) wrote:
> Hi Michal and Team,
>
> We are developing an Ethernet driver here in Qualcomm and have a query w.=
r.t one of the limitations that we have observed with ethtool.

Hi Sagar

Please configure your mail client to wrap emails to a little less than
80 characters.

> Detailed issue sequence and the commands executed:
> 1. "ethtool eth_interface"
>       a. Assuming eth_interface is the interface name.
>       b. By default, the "get_link_ksettings" will publish all the suppor=
ted/advertised speed modes. Let's say we support 10G and 25G. In that case =
both speed modes will be advertised in the ethtool output.
> 2. "ethtool -s eth_interface speed 25000 autoneg off"
>       a. "set_link_ksettings" will be called and speed value will be pass=
ed as 25G.
>       b. Advertised speed mode will be restricted to 25G.

autoneg is off. So advertised does not matter. You are not advertising anyt=
hing. You force the PHY and MAC to a specific speed. You should not touch y=
our local copy of what the PHY is advertising at this point. You just disab=
le advertisement in the PHY. The link partner should then see that autoneg =
is off, and drop the link. You then need to configure the partner in the sa=
me way, so both ends are forced to the same mode. The link should then come=
 up.

>       c. Link comes up fine with 25G.
> 3. "ethtool eth_interface"
>       a. "get_link_ksettings" will publish the link as up with 25G in the=
 ethtool output. Advertised speed mode will be set to 25G and 10G will not =
be included in that list.

Nope. I would expect advertised to be still 10G and 25G. All you have done =
is disable the PHY from advertisement anything.

When you re-enable autoneg, the PHY should then advertise it can do 25G and=
 40G to the link peer.

> 4. "ethtool -s eth_interface autoneg off"
>       a. "get_link_ksettings" will be called and as per our implementatio=
n, as the link as up, we will return the speed as 25G.

So you have turned autoneg off, but not specified how the MAC/PHY should be=
 forced. Defaulting to the last link speed seems sensible.

Maybe you are mixing up advertise on/off with advertise N which allows you =
to limit what link modes the PHY will advertise it supports?

       Andrew

