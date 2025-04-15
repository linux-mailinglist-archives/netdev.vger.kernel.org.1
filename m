Return-Path: <netdev+bounces-183029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6A0A8AB25
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C8C3BE152
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683A2580C6;
	Tue, 15 Apr 2025 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TxVSK4rp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727D2741D8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755210; cv=fail; b=g3co8NAqKedJpvrrrPCmM0JDWhQdRZXsqPwoVUPC3bo9fcFbhxJQGm/CslPL7E+8sMJGT9zb8BajmDBEGXh7dOU2RmFEq7yOKGi9EVUDiOJ5I2L/Bnml4ofUGqmZNXBkWV45YgDbotn8H53G27kE36xtt1dTqCeMKogtOMDJUHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755210; c=relaxed/simple;
	bh=usHegwGeIUrtw30iSeuCrgDDeKtmCq/kCj2Xc2Dviz4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=hjZdATliiZU3I7iDvcp2lQT7vF1yglyKyMYitEVtkO+ygNwY+eesZf4wZPnG7obpXcuUB5pBs2gBBFhOkAuPCfufc2NaapUt+KMMVY18ZliaJixMQCDlLv7ir0vtrx4bEuqCN4pZYTHUiaH1L9fQz0oHjLxMfTe6VmyfSD4i6Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TxVSK4rp; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FLgAko026718;
	Tue, 15 Apr 2025 22:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OKzZKT
	Ig3pthglWOwqp2/uF/A1Cb/jMc9Q8idRxl6vU=; b=TxVSK4rpB8tsKvMwjXBniO
	DpctfbeDZHPojVETcDN6ouZfCvKsaJikJOcDr9Au6uUZ1FYQUldXEPubrPT1MZI6
	PGXYBqAln2YEn+5LcXsuSp/0yhC7tJOVgDIZPCjo/OPIjHwjK/kEajr4RYvbyQpu
	LlTgnzUCAT8Df3QkyLqtd7lyFMQYa1Jxnt9/qgxEO+AUDdJNgUKKtwkyFy6wQsSH
	sXXcpJMPookRXDEP55qcQg0CqPgKRsUl7r/ZGpHP9Y2NcP3ExB1lIbid1rRlkep4
	ETVR3yykizWH6aI/JO5BQNqicHRFSnC6K5jKcgn5kbUYBnOaCLF7NIQpMnzHbAhw
	==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ykt02k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 22:13:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jw16B7ogL2+fCRBFzPNsT3Ei/xJlhJFgq/gZeHcxsMdv3sgETKVMQrTnMWqAjNhB0EIDzD8lJOEFLeaxNudCvB1K9GFiGpY09OZ6VjxWv5CdJJxquJs1/ZG6gXC/lcHCzf3SEzKGA1T51Ktux25LZqneLq+peSuYjuzC4qLJzSa+gNQvzVq0PlTvzWExVknmz/9/wi0sblJt2+gqXGOzoV52aADUhc3TgITPzYqg/NAmX85VXbdN6mL7uTlMNhXGkjmVfEDv8Ii4JJ8xEBeeZ4OXhNYN/LDa8SI3UoejMGDSS5W8zwiGVxVH+hyXqoVwxWD96hFG4VJ/U8AuNumMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKzZKTIg3pthglWOwqp2/uF/A1Cb/jMc9Q8idRxl6vU=;
 b=vuTmFQ+kZKbMaxkqvfoPPjNJ1n1VkkQEGyUgTGbZ677S5UFWmjDUli7rgfNbGB2COMTbHGsYqzwMZlP4x4iIwc+B7H8XhYL85PA/P6JXpJ/aFB7adHKv+acNTiatah3V5qVltahkLgpsfzInnwfdNDLVeM2AfJQcOf6lqIE53w0zEQwagXACGTwolokonfTDE+Fsyj4PN5c0gv1B1ZjEB7fkFUvldASoQiIxGWor0Y9Da8hx4ho2NEb0gLK0sjDOZ2jovWlGOGgZRCYmJttzZ0WOQAZsldPZdHonOn/RKeuhCYhOEG2wRxdJ/wxvl1TxO1LwlZpKwXNoBPM6/n2NVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by PH0PR15MB4701.namprd15.prod.outlook.com (2603:10b6:510:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 22:13:19 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 22:13:18 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jay Vosburgh <jv@jvosburgh.net>
CC: Ilya Maximets <i.maximets@ovn.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        Adrian Moreno Zapata <amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v1 1/1] bonding: Adding limmited
 support for ARP monitoring with ovs.
Thread-Index: AQHbqwoTrDjAZh6IzkG7iJ522lMXdLOfJPkAgAAI5oCAAbHmB4AETtyAgAAQYlk=
Date: Tue, 15 Apr 2025 22:13:18 +0000
Message-ID:
 <MW3PR15MB39138C432D2CD843C20C0C10FAB22@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250411174906.21022-1-wilder@us.ibm.com>
 <20250411174906.21022-2-wilder@us.ibm.com> <3885709.1744415868@famine>
 <d3f39ab2-8cc2-4e72-9f32-3c8de1825218@ovn.org>
 <MW3PR15MB39135B6B84163690576F95FDFAB02@MW3PR15MB3913.namprd15.prod.outlook.com>
 <4164872.1744747795@famine>
In-Reply-To: <4164872.1744747795@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|PH0PR15MB4701:EE_
x-ms-office365-filtering-correlation-id: 7c8eced5-be91-410f-1649-08dd7c6aba00
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pKpe57RmqAUYQlRcJj36Wgdq9skJMDANxNJTfm3EvPWxHfw5fv45aDts+H?=
 =?iso-8859-1?Q?4uG5uSpMmDJZnxxC6h4FpP5XXB1/V4IoR9SXcRBuhKyDA4mny1g/bCBibX?=
 =?iso-8859-1?Q?dW59rfLLRHGqTC8WoaH1z1Izww2BqykZhedj4HRcJGJwV+15uW0i1iul7r?=
 =?iso-8859-1?Q?gc7v/WW0OENCO8sevjzZxmbVcoCbkGNu8VFpIZjZXY8udTP5Xp8mwe9nQ1?=
 =?iso-8859-1?Q?MZz0qrHDGY+286MgjCqk2+yuaiZnQ0ZtZkkZgsau1Uqw7HxKiXl/V9xGoB?=
 =?iso-8859-1?Q?P9E106zwmOXXs2qpH5fNVc0/YLqpmMpGLeg7yti2yiOzY9NDhtkK+zQN7m?=
 =?iso-8859-1?Q?tR2pbDqy5zmwyXTMlrXDWlOWH/T3IpRns8rxm0qkqEfSwASIT3FBRgb6A2?=
 =?iso-8859-1?Q?TIXIEeW+0BuNNwPr/mIPAWf/NEkmYg4c7/mYNCnH1H11jm/SYr8SurRI6a?=
 =?iso-8859-1?Q?aVSRx0MGfM/2TvwiKenOLjXeVdeyKi6Cy00Qp2ClI8Jc+Vb/EY57CRR2Jo?=
 =?iso-8859-1?Q?tZunN0uT4maymyvMRxevgWjVLLE+rdyqhKIYjcHjo/2v8u2IrsTT9iSO1z?=
 =?iso-8859-1?Q?oCk0fWXe0pMyNhicxqlq6UDaifCJFeYceTr+6cDsSwKRvs2txW6S5MH2OM?=
 =?iso-8859-1?Q?5zwhVSPRxTNO5H+blTkdNQXR7Ex09RND9r34nIM/UTFI7NK3cr8SBOsNUh?=
 =?iso-8859-1?Q?Mv0JZ5f8u2pFRPwgVfKnfC4ZKXoQI5Lw8yBj6GXuqQrVuSnGMroBbHQr88?=
 =?iso-8859-1?Q?Cq9o0eD85llm277kyFD/ZAKIuazWkxWEkw67NyAFRVMlOkWWMD2q7YSo67?=
 =?iso-8859-1?Q?VhrF/M+2Hc2i6XskACmzCNJ1wfiSOL1H03xtj6JWmCgkvFjoSKW/gYM9Gd?=
 =?iso-8859-1?Q?nv869iyqUaHOyhmvOKX3fNZ4E/1feB1n+JSVhHNan0NvbsvsPPbnkxDRR2?=
 =?iso-8859-1?Q?2wAeukoF0FppiyR0MusMBN8ToA0/n1e9PmRTQDHRTwb/ReWRrMubbAnwaE?=
 =?iso-8859-1?Q?8eEMmVkVrgCxCTmS2DpxaRzWEptmhLU7MwjuNeg97IN2i4cOV4EAGW4CEt?=
 =?iso-8859-1?Q?VREY03H3ymzWu2algvEFp+h5zR3aJIn4Za9SX7KfTEEAKZx3HmkY0W/y72?=
 =?iso-8859-1?Q?yZRwOt7fIohlDEK0wsMn8+xCxyHXfFOdeiU3GwAuhOTSPmnpWtO0J13Fp8?=
 =?iso-8859-1?Q?ncFRIimirkPiQJBoroAeXTxaIdy9G//dIblI1f7rx9OeRRVrbA2CmqMoqB?=
 =?iso-8859-1?Q?daZXbz0xu8orWHeUUGQUdNx3x6tLY5g85jseF3OPZNclJMIFlBUpgjqbXe?=
 =?iso-8859-1?Q?0sZ6qKaATJB3IHDqoNyiw+pZpX0vVewLtEaDvR+2KSuVU28hocJdxnC/rZ?=
 =?iso-8859-1?Q?zxTzDNHpU3WgYgt5VIjWh6MZ0TGMl97MDcIf9qJ88Q8geA8/ZSgJDxM14Y?=
 =?iso-8859-1?Q?BrDG5GTXUJlOpZx+TVnJjbn8CsEb0w8Ti0lUIMoEoMXGQKFCq2Fx0UsSRm?=
 =?iso-8859-1?Q?+0Dbij1+zdt7q/Y2u+7/sgrOPEQ9Jr0qZKKkCRQdJdBoCDWUncjzxyLGKJ?=
 =?iso-8859-1?Q?R+ONaKw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?N3N9H8DBMyYqMm/xGE4gmNP05Mqx+a95A3X6RSEmSZfJKq/5QNtpp5sX4H?=
 =?iso-8859-1?Q?jAgTqmEiaSHFDbkfCe4/CxHenbLAVvjKrDfVf6MzWADbbyzPuI9ixlgS6j?=
 =?iso-8859-1?Q?Xpd2OHVVF1eMyfbsNPmvctoii6uEP5TXDXpSm6snmekyqxAuhBBu5p0KML?=
 =?iso-8859-1?Q?ZeDc6PAI7l0R7ajmynZiD/a6T6k8n61MY8QvxwDJj0zHE2XcuvgfCtHVnf?=
 =?iso-8859-1?Q?b581vkJHsElTMDNlhYs6gpbn7bm5YYqLH/eyU46xNvN7iajP/8UHJGK2XI?=
 =?iso-8859-1?Q?OwO2CqbtET09uwQM/6AZtXD65OWjy1pcFXItzp0Xn1578OlrnKrSQI78ej?=
 =?iso-8859-1?Q?7khncugvVOHlIS2KAk43Zg/kggZXKeff4qo3xw3nwHel8YOOkjLuN3lacu?=
 =?iso-8859-1?Q?gQG0ctg5/b5cIqLAJLraTGHYFxTSJ6q/Tu4M8fXcK4FDDD0ODKlg9d+Aki?=
 =?iso-8859-1?Q?L6qGkjmeEBFJpk/KdSPjXPTik4ytW0HfN6pU+q/QB3J1yUWtJYfdNQdzDW?=
 =?iso-8859-1?Q?pmhzM/2iCf6VuvpVDwhAXYeO4qRTEQmxS9VQMaZt8xUis1dQWoaVKkfyUh?=
 =?iso-8859-1?Q?WeHD4qc3DCrBEKKv4oqJGAOYEbhLEbdNOagZCY0Apawc+xDjIec/ejG/ec?=
 =?iso-8859-1?Q?jnz0F3apNKg0ZgGqIvEo/wR5yfAcxZV7FxMhi0ppUqaSPVcHd8+SPZduah?=
 =?iso-8859-1?Q?7rx0T1HGXjUWwtWj2aL2hKrcWziAIUO6gNhbow39WA7IA5PgVUvXm0bD3T?=
 =?iso-8859-1?Q?YoCUI9OBuwHS6dRWX6Y+Ww/aTmzCChhy8+arJEKwgi8lrpDEr3Meb10fwt?=
 =?iso-8859-1?Q?NLakP6i99vhEnairNtg4EwpUJqPk9qzuHjODAUYE5W/8d3uCkk4bh4nE09?=
 =?iso-8859-1?Q?VSsPUi/epFgArqNqqQhFf7A7nZlm5nzquHqKMYc/nrZ1mcozdaamw2bNKk?=
 =?iso-8859-1?Q?60bgvA6oagPaohtjIdstaGcK7Oqv8OckGDRNKoWlZQfMr2r8Zlog4gSfKv?=
 =?iso-8859-1?Q?gc8rPsvLs1viwsUUX4SCKfG61VklUgvfNCAsErDL6OKAYrHnFKBYedIkbc?=
 =?iso-8859-1?Q?L8cL8xTUpjKGD+0c8l8JIOQ+A4NQUPzp4yabyJax2G9uPJluQCRyoBePMx?=
 =?iso-8859-1?Q?vzS5bdM68efsbcXVbEdT6eTBgDBF6d//NlPaBADaCP9xdwat1rkSg5QcVd?=
 =?iso-8859-1?Q?VMThnOXH4jSYGmR+Z5ViLDHMq5XxunujPbS6k3FsCzbQBsAtPzRLYheKya?=
 =?iso-8859-1?Q?H2zxTOKawkwCRBjhBC8J401+72HtI2q3a+sI2Une5KowHgu+z9F5p2carA?=
 =?iso-8859-1?Q?CYr38TRg5eS+WrRrMu2jjp8FFeSx6Q2xfqd8w5C5R12+pz/cRtgqyLFaA+?=
 =?iso-8859-1?Q?M4coo3K1n9ER0UAKdGzl9ZjeHjaUGk6TWTk0xnQrO2iE38owssJbRpMMkk?=
 =?iso-8859-1?Q?u1onUbhJUzU+8n5gVPg5jwivqGxg/Pgm0SqtHPuADfCGLa+3aubtV/m0C9?=
 =?iso-8859-1?Q?aJAappfobtOQb0nC+8s3HINg13UB/dDhVYzEU0JgvV1c99R8BEBa9gdIuO?=
 =?iso-8859-1?Q?jW63MOVK7vRAUzAqWuhEn+Gy8F1E/I2Voc0rX9IeVRDyv6w/4oUuQBxzdE?=
 =?iso-8859-1?Q?me7SEAED6EbYo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8eced5-be91-410f-1649-08dd7c6aba00
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 22:13:18.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9Ww11+UC7CDb3lhV9PaRyYX0bzp6SfjcVyFZ4etCgcMylC7PR3WTNe98Xgv0c00moZjJUnyjpay5d2c0bfpQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4701
X-Proofpoint-GUID: FPTq9psrdffdGLcS9DaBWsFkKjkjGmwZ
X-Proofpoint-ORIG-GUID: FPTq9psrdffdGLcS9DaBWsFkKjkjGmwZ
Subject: RE: [PATCH net-next v1 1/1] bonding: Adding limmited support for ARP
 monitoring with ovs.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150156

>>>>> Adding limited support for the ARP Monitoring feature when ovs is=0A=
>>>>> configured above the bond. When no vlan tags are used in the configur=
ation=0A=
>>>>> or when the tag is added between the bond interface and the ovs bridg=
e arp=0A=
>>>>> monitoring will function correctly. The use of tags between the ovs b=
ridge=0A=
>>>>> and the routed interface are not supported.=0A=
>>>>=0A=
>>>>       Looking at the patch, it isn't really "adding support," but=0A=
>>>> rather is disabling the "is this IP address configured above the bond"=
=0A=
>>>> checks if the bond is a member of an OVS bridge.  It also seems like i=
t=0A=
>>>> would permit any ARP IP target, as long as the address is configured=
=0A=
>>>> somewhere on the system.=0A=
>>>>=0A=
>>>>       Stated another way, the route lookup in bond_arp_send_all() for=
=0A=
>>>> the target IP address must return a device, but the logic to match tha=
t=0A=
>>>> device to the interface stack above the bond will always succeed if th=
e=0A=
>>>> bond is a member of any OVS bridge.=0A=
>>>>=0A=
>>>>       For example, given:=0A=
>>>>=0A=
>>>> [ eth0, eth1 ] -> bond0 -> ovs-br -> ovs-port IP=3D10.0.0.1=0A=
>>>> eth2 IP=3D20.0.0.2=0A=
>>>>=0A=
>>>>       Configuring arp_ip_target=3D20.0.0.2 on bond0 would apparently=
=0A=
>>>> succeed after this patch is applied, and the bond would send ARPs for=
=0A=
>>>> 20.0.0.2.=0A=
>>>>=0A=
>>>>> For example:=0A=
>>>>> 1) bond0 -> ovs-br -> ovs-port (x.x.x.x) is supported=0A=
>>>>> 2) bond0 -> bond0.100 -> ovs-br -> ovs-port (x.x.x.x) is supported.=
=0A=
>>>>> 3) bond0 -> ovs-br -> ovs-port -> ovs-port.100 (x.x.x.x) is not suppo=
rted.=0A=
>>>>>=0A=
>>>>> Configurations #1 and #2 were tested and verified to function corectl=
y.=0A=
>>>>> In the second configuration the correct vlan tags were seen in the ar=
p.=0A=
>>>>=0A=
>>>>       Assuming that I'm understanding the behavior correctly, I'm not=
=0A=
>>>> sure that "if OVS then do whatever" is the right way to go, particular=
ly=0A=
>>>> since this would still exhibit mysterious failures if a VLAN is=0A=
>>>> configured within OVS itself (case 3, above).=0A=
>>>=0A=
>>> Note: vlan can also be pushed or removed by the OpenFlow pipeline withi=
n=0A=
>>> openvswitch between the ovs-port and the bond0.  So, there is actually =
no=0A=
>>> reliable way to detect the correct set of vlan tags that should be used=
.=0A=
>>> And also, even if the IP is assigned to the ovs-port that is part of th=
e=0A=
>>> same OVS bridge, there is no guarantee that packets routed to that IP c=
an=0A=
>>> actually egress from the bond0, as the forwarding rules inside the OVS=
=0A=
>>>datapath can be arbitrarily complex.=0A=
>>>=0A=
>>> And all that is not limited to OVS even, as the cover letter mentions, =
TC=0A=
>>> or nftables in the linux bridge or even eBPF or XDP programs are not th=
at=0A=
>>> different complexity-wise and can do most of the same things breaking t=
he=0A=
>>> assumptions bonding code makes.=0A=
>>>=0A=
>>>>=0A=
>>>>       I understand that the architecture of OVS limits the ability to=
=0A=
>>>> do these sorts of checks, but I'm unconvinced that implementing this=
=0A=
>>>> support halfway is going to create more issues than it solves.=0A=
>=0A=
>    Re-reading my comment, I clearly meant "isn't going to create=0A=
>    more issues" here.=0A=
>=0A=
>>>>       Lastly, thinking out loud here, I'm generally loathe to add more=
=0A=
>>>> options to bonding, but I'm debating whether this would be worth an=0A=
>>>> "ovs-is-a-black-box" option somewhere, so that users would have to=0A=
>>>> opt-in to the OVS alternate realm.=0A=
>>=0A=
>>> I agree that adding options is almost never a great solution.  But I ha=
d a=0A=
>>> similar thought.  I don't think this option should be limited to OVS th=
ough,=0A=
>>>as OVS is only one of the cases where the current verification logic is =
not=0A=
>>>sufficient.=0A=
>=0A=
>        Agreed; I wasn't really thinking about the not-OVS cases when I=0A=
>wrote that, but whatever is changed, if anything, should be generic.=0A=
=0A=
>>What if we build on the arp_ip_target setting.  Allow for a list of vlan =
tags=0A=
>> to be appended to each target. Something like: arp_ip_target=3Dx.x.x.x[v=
lan,vlan,...].=0A=
>> If a list of tags is omitted it works as before, if a list is supplied a=
ssume we know what were doing=0A=
>> and use that instead of calling bond_verify_device_path(). An empty list=
 would be valid.=0A=
=0A=
>        Hmm, that's ... not too bad; I was thinking more along the lines=
=0A=
>of a "skip the checks" option, but this may be a much cleaner way to do=0A=
>it.=0A=
=0A=
>        That said, are you thinking that bonding would add the VLAN=0A=
>tags, or that some third party would add them?  I.e., are you trying to=0A=
>accomodate the case wherein OVS, tc, or whatever, is adding a tag?=0A=
=0A=
It would be up to the administrator to add the list of tags to the arp_targ=
et list.=0A=
I am unsure how a third party could know what tags might be added by other =
components.=0A=
Knowing what tags to add to the list may be hard to figure out in a complic=
ated configuration.=0A=
The upside is it should be possible to configure for any list of tags even =
if difficult.=0A=
=0A=
A "skip the checks" option would be easier to code. If we skip the process =
of gathering tags=0A=
would that eliminate any configurations with any vlan tags?.=0A=
>=0A=
>        -J=0A=
>=0A=
>>>>=0A=
>>>>       -J=0A=
>>>>=0A=
>>>>> Signed-off-by: David J Wilder <wilder@us.ibm.com>=0A=
>>>>> Signed-off-by: Pradeep Satyanarayana <pradeeps@linux.vnet.ibm.com>=0A=
>>>>> ---=0A=
>>>>> drivers/net/bonding/bond_main.c | 8 +++++++-=0A=
>>>>> 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
>>>>>=0A=
>>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bo=
nd_main.c=0A=
>>>>> index 950d8e4d86f8..6f71a567ba37 100644=0A=
>>>>> --- a/drivers/net/bonding/bond_main.c=0A=
>>>>> +++ b/drivers/net/bonding/bond_main.c=0A=
>>>>> @@ -3105,7 +3105,13 @@ struct bond_vlan_tag *bond_verify_device_path(=
struct net_device *start_dev,=0A=
>>>>>      struct net_device *upper;=0A=
>>>>>      struct list_head  *iter;=0A=
>>>>>=0A=
>>>>> -    if (start_dev =3D=3D end_dev) {=0A=
>>>>> +    /* If start_dev is an OVS port then we have encountered an openV=
switch=0A=
>>>=0A=
>>> nit: Strange choice to capitalize 'V'.  It should be all lowercase or a=
 full=0A=
>>> 'Open vSwitch' instead.=0A=
>>=0A=
>>>>> +     * bridge and can't go any further. The programming of the switc=
h table=0A=
>>>>> +     * will determine what packets will be sent to the bond. We can =
make no=0A=
>>>>> +     * further assumptions about the network above the bond.=0A=
>>>>> +     */=0A=
>>>>> +=0A=
>>>>> +    if (start_dev =3D=3D end_dev || netif_is_ovs_port(start_dev)) {=
=0A=
>>>>>              tags =3D kcalloc(level + 1, sizeof(*tags), GFP_ATOMIC);=
=0A=
>>>>>              if (!tags)=0A=
>>>>>                      return ERR_PTR(-ENOMEM);=0A=
>>>>=0A=
>>>> ---=0A=
>>>>       -Jay Vosburgh, jv@jvosburgh.net=0A=
>>>=0A=
>>> Best regards, Ilya Maximets.=0A=
>>=0A=
>>David Wilder (wilder@us.ibm.com)=0A=
>=0A=
>---=0A=
>        -Jay Vosburgh, jv@jvosburgh.net=0A=
=0A=
David Wilder (wilder@us.ibm.com)=0A=

