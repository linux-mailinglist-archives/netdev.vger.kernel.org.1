Return-Path: <netdev+bounces-63317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9082C461
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A363F1F247F3
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91971AAA3;
	Fri, 12 Jan 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="VdaN0TuE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0601757F
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40CH9pNq026412;
	Fri, 12 Jan 2024 17:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=J3RGdM2tKioMwgRNfKqgjB+Xpo8sWUWICUh9PCxIhe8=;
 b=VdaN0TuEfNEQE0lrMCZNfR8Wezg/Y2xFOFYDAnH6rgEz2MSTJL+ophsz2ZKQVkMWlYiJ
 f8AUl6RMWYsnnZpBUteLopJbMNGAoG4Yry4PvYrCC/u7gYN1vnfTZTErYOhRsQ7qil3T
 0LzePg/qnvYMGSEEM8SMqoIZKRMmvrOLOYklQO0Dw0xsGQ3sF+0XmVvsHd/0pBbA9jIc
 P9wYhV+YG/aG5T1mZVrNSBfrkIl1aDuL9UlR1FCJ3nJ5zBIrzYv76REus/HBvOU8NTmZ
 dFU7uvUfRT4SJ/4Fbz/xHOxpeoNvBPWMBXqMliz8qD6g7IYUEfO+CPjhd07oyr8smBih fQ== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vk3b5kmw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:11:15 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 55A2713792;
	Fri, 12 Jan 2024 17:11:14 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 Jan 2024 05:10:55 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 12 Jan 2024 05:10:55 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 Jan 2024 17:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL0r8cRe0FFKlvIKsRKBgEovpa/B7ArDhiQq3u58J4UypdCdq50k8tUNMT+RwHhKhF4MEj333VJqWu0CO0NpdLjOwBR8KoIlorO0HGt8rh+lPPerkPAUdMpI2ziz3kMGlW4T9+lbYGd997PA/KSS6xcu2ipHl5vacrctxY+MUHMbsv4nJOIhr66tY8eNuk2sUe+Nqx1oJFGmrY/qGCACtreBVCcqfZcaUrM3uL5MgxHSSXroiTVAl3lV/8/NVyNHTJKeFxDbQWoqA+XIa6LtUazGikVVkLst8RdK9VK85sUyvq1NClDv9qoo9PnBUFyPbZcP2i9MVwQHyakUp1zy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3RGdM2tKioMwgRNfKqgjB+Xpo8sWUWICUh9PCxIhe8=;
 b=RYTsQjz9DD8bF7/NDo7U5wyI4+qhjM0s9Zw7Uh4U7h4qJ4lOlRfkSL9znxFpI7+sin4H9R4rAxUiHZ8yV1nPlAMTVH7jP1IIJH1shLLW9pveA3lIJikJerxbloWr/RE4EpeRocNn7MwnhM4oufHYUC47j1z1/zNwpJH70qE1uavDLiGc0qmNf9KNdf85UAewPeka97jbmrWItgjewGeyLAVF42Kbr6zZGPkzHQSYuZpmKZ+TU+P/yPSDyjVQOwC3YGWUHKO755W7CkDrRjyQVsSHWNfAneHu89jOImi0xmczPkGUcga62peW86BpP7lqUM+c+hciyUQwnJ1IcUFqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:9f::22) by
 CH3PR84MB3947.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.11; Fri, 12 Jan
 2024 17:10:53 +0000
Received: from DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d318:5325:b35:6085]) by DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d318:5325:b35:6085%7]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 17:10:53 +0000
From: "Natarajan, Venkatesh (HP-Networking)" <venkatesh.natarajan@hpe.com>
To: David Ahern <dsahern@kernel.org>,
        "Udayshankar, Daksha"
	<daksha.udayshankar@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "K, Praseetha"
	<praseetha.k@hpe.com>
Subject: RE: Kernel support for ipv4 route with ipv6 link local as nexthop.
Thread-Topic: Kernel support for ipv4 route with ipv6 link local as nexthop.
Thread-Index: AdpFE8+jDPfxLZfoRHSCMkgXPyimagAWEQOAAAOIhzA=
Date: Fri, 12 Jan 2024 17:10:53 +0000
Message-ID: <DS7PR84MB3061FEBD32530AD8FD477CA6F76F2@DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB14838465E04EE1E2A5C1AF12976F2@SJ0PR84MB1483.NAMPRD84.PROD.OUTLOOK.COM>
 <25fa3854-927a-4040-9942-56f36141c39b@kernel.org>
In-Reply-To: <25fa3854-927a-4040-9942-56f36141c39b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR84MB3061:EE_|CH3PR84MB3947:EE_
x-ms-office365-filtering-correlation-id: fa2edb2e-cb0c-4282-2bda-08dc13916f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJ1uixyek0K3yrC65sTybJC3tdpEyXTPUyZWuQju8cjHji2iPLxYybtp0nLtnixT0e6l1lWHj4dIj4zXsNhbrzuzGqw+7Pl6mcSzvC+0TN6WfP9gu6IUlIiK0LrlM6NS4Z0I+0QOkUMm0AjQTuaB7THsaj7H3zsmhvBB1nOfaBB9CqBM13ubaVHBFMvcM+74sgi9mpJili1CvyBP/a+T5zfc9DyA6CjvGcZbHqk84gRYfLJpdyQyR1gsauNHGRJGdFUUrd3PP8R67gWSBLUCOmgDcvO8yUHA06Kj4g/RZIEHsuqG8lCEp2DaXAkXIpfaXRyh+FAZI+xwEfo/kEou7GQya3bUMfL61OBP3k+DE7CU/QdH4t85Z5QNVNZB3W7At9n10obkBpuNAGt19RQ1HXnQoaGsH5rleDjT/mx1P/RTdYK7/3I61KvZ2nfG/qRqn/7hxsKCkOeHyxk1uPbum3kCJS6vhVxI5CJQbzXNR70W15PPs/JGVALEWorANVJi5hmaZX+uAPvsIuODKxrnoB3vOZJL+/9WH7uToEY4xSp+0GZSutgo50hz1O3tteE1EJ9GYe414i6VA3Gs1gLaK+laC/6MqAYJ9n6cd4/ezRNZq0SLNxfcqFShW/rYs4UZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(71200400001)(26005)(83380400001)(6506007)(7696005)(38100700002)(86362001)(122000001)(33656002)(53546011)(82960400001)(38070700009)(4744005)(4326008)(64756008)(52536014)(9686003)(110136005)(66446008)(41300700001)(8676002)(66946007)(76116006)(5660300002)(8936002)(66476007)(54906003)(66556008)(316002)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alV2YWlOTERBY1NMNGQxaExMMUM3Nko5Y0o2QUpsZXJoaUkvZ3QxSVlhcXlt?=
 =?utf-8?B?OGpNOXJQS0h3Mk9GRGVBSWhZY2dpSk8vVit2WTJHYWFsVTRnY05HSkoyVW5X?=
 =?utf-8?B?UDVCZXh5TGwxdDBGVlVrb2M4NUNWTWFTeEtEZ2ErencrTUp1QlFPdkpLZlJs?=
 =?utf-8?B?ZGwrWUJrREFKZ3FBdEgyQWx5SWsvclo5VUpIRnBJL0NyNXN6THZPeFFZQVpO?=
 =?utf-8?B?ZDFrakdqZHJmakFyb0VTRHlEVGRNVkt0SmxxNXpEYkRXRjZUK0d3YXAyaHV4?=
 =?utf-8?B?VzZKclRKWDI5TUVZc29ZQ3lPdk4yYzZZU3ljUGpHTFRmVTV5ZmRvNktpT3c2?=
 =?utf-8?B?MkQxbzJsTzM2MlcvN1lwT1NwaDhYZzA4R0pENVJXaHhBY2g3cm14V0QwUXN0?=
 =?utf-8?B?Q0NSM1RCYmIyUHdLL2dPSDlGK2lPZ3ZZdHU2RGZQbzhyR0R2cWxaS0U3U3Jo?=
 =?utf-8?B?OVBYNHFTczJHc2FsS3NUcUd6dUo0ekk3eFQ1RVMvWWVXa2pkUU5iWE4xbFBy?=
 =?utf-8?B?dXpUUCttNUY3dHA0eEx5MTZoaVZITk1wUGhuWFkyMUhibmpQd1l3V3pLekcx?=
 =?utf-8?B?L1d0NS9yYi83VXNLcGJXanlZNFJBQ09tR3RqUEtmU3pPRllmcVkwR0xITkhp?=
 =?utf-8?B?QW9sMmsxV0Mza1g4RjhveEUvek9oOWNjdUY0dzk2MFdUdlF0bWpXaGpWL2Za?=
 =?utf-8?B?eHhXcDZkR1NTLzJOQVVpSTd3cjFwazFGUGIwdlprcnhVK3hZTjk0SmtucGwx?=
 =?utf-8?B?WDluSFgya2FMVkhYZ3ZIU3QzeEhsSVlGd2IyUVdhZURZaS9GcW56elNxRE1P?=
 =?utf-8?B?TEYxV1NFQVU2dEd1UkNmYWwyVmRBdnQrSldUS0RuSFh6M1p5VlpNV2wxeXFB?=
 =?utf-8?B?UkZmVEkvZ1IxMHZzSlpVQ2ZhK2kwQVFieXVkV2x0czNJSmt2cml6RDZoYlVW?=
 =?utf-8?B?b3laMnErSmZIcVV2T1lHWVFmM3lhOG1CSVVubmpxTkg3MkxxRnVzb1Yxck9k?=
 =?utf-8?B?VVRXc1ZJaFYzdytmVDVvc2JwR3ViZndpVDkraEkvc3dpOVVwaFZXV3UvOW8r?=
 =?utf-8?B?N1lEYVR4TElvWjlhd1JhOUloOGdxTXJEaWRvekt2U2Y0WkxlUUs1cVFtNTJ5?=
 =?utf-8?B?U0U5dEpManN2ZWVKa1I1RkloUjZHSk8rOEV4aTQ1b3lvMEd0akhHcUZPU0JH?=
 =?utf-8?B?TWFLUW45L0djNUcrTWtWcFVpVWhPN1R6VVdMTWZ0dC9BU2JEZm1NSXVFSnl0?=
 =?utf-8?B?bDJIdUZSTVVUUzQ1NjdlaHU3L0Z6YkRtd3prUE1YdFVNQ2t6R3ZKMGxad3c0?=
 =?utf-8?B?bGJmdEh4V2IzOVhrOWlyaVUvVk1uK05zQ0ZiSVg0d2M3RHh4L0x4Mlg5dGpG?=
 =?utf-8?B?ay9ja2pvUkJIL1lPZ2o0anNUL25WZ3hSSkJtU2RLbkRVcDlRTVFXU2VWZlV2?=
 =?utf-8?B?UW9GcCt1ZTlwWWpWQ3hmOENjRG4wMUpJamt3MmJHcDkwVCthSnNqQTUwTGQr?=
 =?utf-8?B?aWRDUU9NanZGOEFwc1pzQkRQNnBtVU8zNzhoRDcvV1BCSURNK2NZZEZvc3Ni?=
 =?utf-8?B?QXFXSkRqWWRKemZTOWtKMHVwNlljVUN4UmM5eEY0SHFveDFucW8yR0F5Wm45?=
 =?utf-8?B?U3ZKN25vWlRFaGQ3MXpOOUM5ZGpibzNpd2hsRTNVZkVjb1VMWlNOandYRDEv?=
 =?utf-8?B?eTJNbHVmaDVBaUFOdVRWSzkxbjJUaHhnUmVBbjRhM1lnZ0dJZkduNXZEVTY2?=
 =?utf-8?B?V2VjT1FnUWNFWGw3YndTYmpwaVNpclVIcVVJZUhUalpDSCtWMENHVDNxMDMy?=
 =?utf-8?B?U0RXVFNPT05QNUVSMXkrQVdmN1l6VmcxNGUycFpUTzNvVThaT3VvRmkvc01G?=
 =?utf-8?B?bkgzTlBKRFNqS2tENjdxYXNleTZzK216QUtXRGdhdFZNNjN6MUVlY3AxNUtF?=
 =?utf-8?B?UnRCRHRCd0l4QjVMOXBTZnR1alRoeTBJYzBQUkhwVWNWWDBEeTRxeGV0a0hZ?=
 =?utf-8?B?bkwyc1VBZW4yTXc3dDNBelVrRDlTM3pZSmpMZG55WE9OdE1nWlZMWXk5OHQ0?=
 =?utf-8?B?clA3YnJpMGMrWDFLMThUM1hGVjIvRmUrU3ptTnJCZUd3dTh1SXRHY21HMmZH?=
 =?utf-8?B?VlBtWmIvYkZ5em9FVEhqQ1ZzT0FuOWpJQ2VIVFcxTU1yT2VZV1hmQWR4dklB?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2edb2e-cb0c-4282-2bda-08dc13916f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 17:10:53.4548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIdzd0GCbivQYV+ZKezATVmJX24vzC2ivVVK7eQywZVeoCYK0H78nEAaLjYnykZcfqa5KIGnXasLXGIKSqds5TFXwp8Exb/8VxhuIRj1cUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3947
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: aENS3Ryife_qFP7PFIQrPKf--mHvtAXZ
X-Proofpoint-GUID: aENS3Ryife_qFP7PFIQrPKf--mHvtAXZ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_08,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=490 clxscore=1011
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401120135

VGhhbmsgeW91IGZvciB0aGUgcXVpY2sgcmVwbHkgRGF2aWQuLiBXZSB3aWxsIHRyeSB0aGlzIG91
dCEhDQotVmVua2F0ZXNoDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYXZp
ZCBBaGVybiA8ZHNhaGVybkBrZXJuZWwub3JnPiANClNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwg
MjAyNCA4OjU5IFBNDQpUbzogVWRheXNoYW5rYXIsIERha3NoYSA8ZGFrc2hhLnVkYXlzaGFua2Fy
QGhwZS5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0DQpDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgSywgUHJhc2VldGhhIDxwcmFzZWV0aGEua0BocGUuY29tPjsgTmF0YXJhamFuLCBWZW5rYXRl
c2ggKEhQLU5ldHdvcmtpbmcpIDx2ZW5rYXRlc2gubmF0YXJhamFuQGhwZS5jb20+DQpTdWJqZWN0
OiBSZTogS2VybmVsIHN1cHBvcnQgZm9yIGlwdjQgcm91dGUgd2l0aCBpcHY2IGxpbmsgbG9jYWwg
YXMgbmV4dGhvcC4NCg0KT24gMS8xMS8yNCA5OjU3IFBNLCBVZGF5c2hhbmthciwgRGFrc2hhIHdy
b3RlOg0KPiByb290QFVidW50dTE4NDM2ODp+IyBpcCByb3V0ZSBhZGQgMjMuMC4yLjAvMjQgdmlh
DQo+IGZlODA6Ojk4ZjI6YjMwMTo0YzY4OjUwN2UgZGV2IGV0aDENCg0KdmlhIGluZXQ2IGZlODA6
Ojk4ZjI6YjMwMTo0YzY4OjUwN2UNCg0K

