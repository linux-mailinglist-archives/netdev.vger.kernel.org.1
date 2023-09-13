Return-Path: <netdev+bounces-33669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5804379F280
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 22:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F361C20AAD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595131E506;
	Wed, 13 Sep 2023 20:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659A33D4
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 20:00:06 +0000 (UTC)
X-Greylist: delayed 17667 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 13:00:04 PDT
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4261738
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 13:00:04 -0700 (PDT)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DDrpLA015241;
	Wed, 13 Sep 2023 11:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=OHd1KizEPrsV999RNV6rnlrwGnPP6SMnyMsVH44XBEM=;
 b=IzCXlG0k86QCbh2AsjQRqD6G3l5f2e3cx30Zv3AJPdtKIzisZPa2PvFvcG0zpRHHgAAE
 bAFCAzmCX4j2xWglmg6XkTyijCllsEykVkIppaWC+Pf2VQWS2YYmXhy/8ACGuUhQzzJf
 EvuXbXv9dUipiUxwi4IKNKpY5o2aIPcS87lsikG5t/m3T+CFL4qKM77jpz/JpECNQUAi
 4I0gt0XwxF+q1XB26Sv7um6XqCOzCXCOQPOeJadvpi3cb06HPxqiyNibfa9wy1JOZMZ1
 lMwhEJ6AYJJr2ayPNAuDfFuptWXzepJO7Vsu287A3FHRoFdrwkEpg3yD0kTwikuH0oFI +w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3t2y81mkye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Sep 2023 11:05:24 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DF07Am004230;
	Wed, 13 Sep 2023 11:05:23 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3t2yrpycxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 11:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkKO1CSNq+gHNJzd5YTZGjw7jwfoIX2zI72u+tERHMc1PnGTb2SnydCLh0UaOz1n97yROqBGpP7u7mfBvX3XbwCrlqEfZW8qtYsRn3FU4Vtg2IgMdP6ls48WuRvKhisttf1/iMAnP8gsMlnjlh/sQE0bmHeknSnhuDksESwf+NfqQisC6mZHTsBL5IsEjUVr6EgwAXMjDLAiBY7/xNpMfu4NOl48i4p1kOY3uu9gk7wQv9anbQrPTtw9YCTMODSCHgYac3iWxgZAQjfJDPkC3Njvq09aNz8AvaZ3nVL1thUER+ID/+/Os9z41SaSWGRbk8xKXbOK/vfAlyXT+NCPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHd1KizEPrsV999RNV6rnlrwGnPP6SMnyMsVH44XBEM=;
 b=hranXVAlP/tBpeUZ0NSnu3ZXuqhKkYIw0kchWH+mMfVU/ZwmSx3cw5DMcr6k8NpYV1pVjAvlg3CndnhSIw9DyRzl/F5HlJXqmXTAQurzt/0g718+RwTqI6SvzET4/e4laE4EBCwVKTQoql4IqO9fgaX6sfisdwZxOuj0IwE7zBUSoXbtCiwrcUham8w3PyufQ6OKSbHv6iqZhtP5o7KYeEiBYDb2x3mH5DfLS+JMCTBEzj471DGeh53qzOsKQ9ffyZB/Y0QhQQjd4a9OQoHQ6wSyISmbXCyAgcI2EQj88EetCyk9L9ysEXIblGDEF61g+sB+JBmOgPy5sTqBXwB3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS0PR19MB7621.namprd19.prod.outlook.com (2603:10b6:8:f0::21) by
 MW4PR19MB6822.namprd19.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 13 Sep
 2023 15:04:44 +0000
Received: from DS0PR19MB7621.namprd19.prod.outlook.com
 ([fe80::c72e:5040:320f:cac9]) by DS0PR19MB7621.namprd19.prod.outlook.com
 ([fe80::c72e:5040:320f:cac9%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:04:44 +0000
From: "Zekri, Ishay" <Ishay.Zekri@dell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: MCVLAN device do not honor smaller mtu than physical device
Thread-Topic: MCVLAN device do not honor smaller mtu than physical device
Thread-Index: Adm0nnOW/GY+fujYQUOSxkfA6dMMTgAgeaMAAQ15WsALPk3LkA==
Date: Wed, 13 Sep 2023 15:04:44 +0000
Message-ID: 
 <DS0PR19MB7621F0DED7D784774EBA84309FF0A@DS0PR19MB7621.namprd19.prod.outlook.com>
References: 
 <BN0PR19MB5310720D5344A0EBDFC66D9D9F36A@BN0PR19MB5310.namprd19.prod.outlook.com>
 <20230712172414.54ef3ca8@kernel.org>
 <BN0PR19MB5310E984E53F00A146F74E269F38A@BN0PR19MB5310.namprd19.prod.outlook.com>
In-Reply-To: 
 <BN0PR19MB5310E984E53F00A146F74E269F38A@BN0PR19MB5310.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2023-09-13T15:04:42Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=15ccd244-08a8-4fa8-979b-c69b23dacd25;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7621:EE_|MW4PR19MB6822:EE_
x-ms-office365-filtering-correlation-id: 3a146386-e029-4274-67f7-08dbb46ac3d1
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hfEDzEafOYUCoB6d8l/GoPqfL5grpbtZ2wvwXPHrAlSG+EPv1845mkRQ0mJO3vEl4bE7vQvp597Pt53u51GhhJ7pIrvM4R3si1WzsDfbP/oEVzgtw/na3sJWv7vN2FfU0v9kOpJo5nIfbIi8pEsrLvrzwZ1CQuLF+BPYeg1x5AVgEw5bMRAesDvaJGp5mna8cTrMW+TjE/EwwGZm0/Fz6Cc5JO7jvebI1pJwU/RxHWLHZ4bFS/sjNQ5nT5QkxLvpxpN738ONbAOqkO+sUSss9FAEPny/ejLJXdS9oPsiLfRmdKOUB3WbrbL4MJzm02X8lLyJnj428nnb1QkLlJpLdTIEjIMT/4b3M26AqoJAwMEH7Ic3ZSjyR4bfymI8GM8CHmZvh5u9xVKxSuOLsdrj31KJO4Inm32cDWEEethcB6EreBfCHfWSRVocHMzS0i28mfcF+DhNq6Qf8HeifEXIn7Qtq0T/I13Ul74UMds/FO4ttkdiO1DYFLIRNiEVNhpPmrYKwRZWGoU7AK5Bt4OuAKQvNqJ/ZEwZBLtTL1gC2jHPJQlYawJP4ElNTH9FvUPVtvm/owJjVyLU6oBgyYrF9poXWTRobIbWyAnRDfjdQwg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7621.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199024)(186009)(1800799009)(82960400001)(122000001)(52536014)(53546011)(6506007)(66556008)(7696005)(71200400001)(83380400001)(33656002)(38070700005)(38100700002)(55016003)(2906002)(86362001)(478600001)(76116006)(966005)(54906003)(9686003)(786003)(41300700001)(8936002)(5660300002)(8676002)(4326008)(316002)(66446008)(66476007)(64756008)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?RWaiDLK0o9r2eM0uJorzciks8/Mp4kKpd8iO158cQx6Xgjaqp7vY0/ZDhpED?=
 =?us-ascii?Q?2zq9fXk8Sla30XUrX9z9roDRV89T7qNOcEdfnAk0o6Xsj8gSoV+xBrN2flr6?=
 =?us-ascii?Q?mT2DFTYtTfcIl1UpHDmU1+56breYRiPe1I6cB7Hulf8D3/HUmN3m0joGB6W3?=
 =?us-ascii?Q?Xo6X2S2VKeEffIuMg6r1eHQQAx5Ul0o8yW4sdw/tDRm1HVSymVFysVcjJ45v?=
 =?us-ascii?Q?pLG2zaMEvIxtQEDY6yBjd9diAhqxPA3KHr5qdK9TBH9vQMqkCYxDenT0BcRt?=
 =?us-ascii?Q?emnmpga8bGs1u2axX9yD2us2sKTAoNi5a5wMXjMMj23RNU7JvT+2AtgRU2vL?=
 =?us-ascii?Q?jtLR+gr3rOnwaBWOfASRwyR1trt9QuoTWHd5Ai80ZQk6sAjannyKkEPqGJYw?=
 =?us-ascii?Q?QrDlTCuBlUCYWLRSlmbGN+mfydHKvClDxsjku7bHe3h/ELLyACB9cGzxB2KK?=
 =?us-ascii?Q?cVdmKZmElznse3oiUmtD04U2mmmuhA4uKWgPX20b5lc45cFBA/tdTnfOQihj?=
 =?us-ascii?Q?md0M+gIAX9OXN72zt+XgQzasDYU2LUBxQZxS8A3/6sGwnHfeHLRZmA8/HCPh?=
 =?us-ascii?Q?eaoXF4HI/tha0hvya9E0WXBMXjIk5X+SRtkWBspT1JzCrs+zLDwoohO6f7rT?=
 =?us-ascii?Q?lFO5jBk0wi7DDYHTK4u/G+wHGdX9s08LHr8KQemGg/w+P3twisKzYpC5SpHd?=
 =?us-ascii?Q?H5soAH3GSs293ipi07x2YK5BYLK2RtQkMbXL1Ws0H/I10K9Bq4kCLiheP/1T?=
 =?us-ascii?Q?aS8UrS6ZedVOHcOK6WI4vNCT7ucRgR8HX582flLGQJZtLoSvh/vHniyfv6ZX?=
 =?us-ascii?Q?ooOBY9BClxyO3uprIQDHa4D0h4O0vyi9yMcz63QuDhCPb5Jm6PFOZqOCifK3?=
 =?us-ascii?Q?g/jxmJ3pn6iWemCt8lnPpFbAtqd0CGS0Z9HB8K8tAxWRmGuTJWGOhkzCh/DW?=
 =?us-ascii?Q?3fc40KXCbbn1Tv2UIrZykemxWFKEc/s0XEIGsT81Mj8075hFtUEIp8jC8Ksi?=
 =?us-ascii?Q?6c/iObNdYTyqrhHKzHb8KG2t0gAm/sBRnB8A23NWdjfYk8cFWbO2TfNM05qD?=
 =?us-ascii?Q?/V16hi/mE3m2AXnZ6P1h104GHv3aaHMHx9KAPYJVmjyODSsD4NvG55WzXyJN?=
 =?us-ascii?Q?pyYkYWJvOQwYEI8DIVgy/fwp8J/H6QvTDN3DvoHnZB8nhHTfhZJpnykxGyMe?=
 =?us-ascii?Q?9bEVdqLC97BeIE4KY2XN//XZvwuw65K7gJkcVOK9YnOtUAFjX02HAUPtGHH/?=
 =?us-ascii?Q?ec0dbZX/pOcG/ySCj7nMEstGx5JkChMo9qaHz9amsDzHITXKBPGyZqm8jBRk?=
 =?us-ascii?Q?0xNTsOLEWtiJ/FCDr7XKcgP6CnoDLFTNs7vf+PuAo2O5nT4yyfjFsyXADyPx?=
 =?us-ascii?Q?ylkqzpwGyBopn9vFEg4Up61aLilMaTZRUYhxZhqoZs+DrPKaeSKqGgqgC+ab?=
 =?us-ascii?Q?XJ1c5hPXklITpgUJQextXDwjeeE4ly6mi1hgQOn5aCs9Py7UUB9TSREydBf9?=
 =?us-ascii?Q?VJOrqlLB0sJJnN6OiFPYrTe+MShGXSI/9/XXlpwL8g2VuNPlpXaVkQ3YwLKU?=
 =?us-ascii?Q?Ij/Sn+h7+PBO+dQQprqLCuNh52xrMjvhcnXEhY9gAqhXNQbITd+e0QhwgO97?=
 =?us-ascii?Q?2sN/T8NUimGVJ8uIfiBoAMlqr/DGxeSGETUETGPyAOUQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7621.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a146386-e029-4274-67f7-08dbb46ac3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 15:04:44.7255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIiG8sGpzgV3nyusZxy31W4gweiAjeoC3guUJVjcyWLJBdglimpMF1ZYNIm4o+9c5uOdYkIFG5+oZoYeh7kP/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=656 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130124
X-Proofpoint-GUID: ZOeajqnDUkLiuuPkkk09At8lCFrKJJJz
X-Proofpoint-ORIG-GUID: ZOeajqnDUkLiuuPkkk09At8lCFrKJJJz
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 mlxlogscore=739 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130123

Hi,

I upgraded my kernel to version 5.14,
but still, I see the same issue in which the MCVLAN device do not honor sma=
ller MTU than the physical device.

My setup includes 2 physical nics connected back to back.

When configuring IP addresses on top of the physical nics,
ping with DF bit set is not working when the message size is larger than MT=
U,
but when configuring IP address on top of MACVLAN device ping with DF bit s=
et works even if the MACVLAN MTU is lower than message size.

Note:
MACVLAN device is created on top of the physical interface.

Any idea what is the root cause for that?

Please let me know if further information is required.

Thanks,
Ishay.


Internal Use - Confidential

-----Original Message-----
From: Zekri, Ishay=20
Sent: Tuesday, July 18, 2023 12:02 PM
To: Jakub Kicinski
Cc: netdev@vger.kernel.org; edumazet@google.com; Panina, Alexandra; Barcins=
ki, Bartosz
Subject: RE: MCVLAN device do not honor smaller mtu than physical device

I gave this post as an example to the issue we are seeing.
We tried to ping from host outside of the server.


Internal Use - Confidential

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Thursday, July 13, 2023 3:24 AM
To: Zekri, Ishay
Cc: netdev@vger.kernel.org; edumazet@google.com; Panina, Alexandra; Barcins=
ki, Bartosz
Subject: Re: MCVLAN device do not honor smaller mtu than physical device


[EXTERNAL EMAIL]=20

On Wed, 12 Jul 2023 09:06:20 +0000 Zekri, Ishay wrote:
> Hi,
>=20
> We experiencing an issue in which MACVLAN MTU does not limit the frame=20
> size, i.e. the limitation is coming from the physical device MTU.
> Kernel version: 5.3.18
>=20
> As described in the case below:
> https://urldefense.com/v3/__https://unix.stackexchange.com/questions/7
> 08638/macvlan-device-do-not-honor-smaller-mtu-than-physical-device__;!
> !LpKI!iFTSU67fNksfVLQ4yxAk3ggSMZPw-qM4PlkTINcLKkuCbWWhnSYQV3YxsBjFDTc1
> hIIiWqVFlWFH$ [unix[.]stackexchange[.]com]
>=20
> it seems like this issue might have a fix.
>=20
> If there was a known kernel issue that was fixed, I really apricate if yo=
u can provide to me the commit in which it was fixed.

In the post above you seem to be pinging the local IP address.

129: K9AT9i1G2x@eth6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqu=
eue state UP group default qlen 1000
    link/ether ba:c7:36:3f:9a:76 brd ff:ff:ff:ff:ff:ff
    inet 192.168.15.40/21 scope global K9AT9i1G2x
         ^^^^^^^^^^^^^
 # ping -c 3 -M do -s 8972 192.168.15.40
                           ^^^^^^^^^^^^^

Local traffic gets routed thru the loopback interface which has the default=
 MTU of 64k. Did you try to ping something outside of the host?

