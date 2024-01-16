Return-Path: <netdev+bounces-63638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592882EA52
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 08:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE2928502F
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8111197;
	Tue, 16 Jan 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nlju9rkN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88511184
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FL2lM2029904;
	Tue, 16 Jan 2024 07:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=fFHrLSTXMADC0iyP91ZElEqIHAWBUuLT9c5TSw7+5I0=;
 b=nlju9rkNnHvHkL9yzXIpjL+gnUqgkDz5McWAFFzVtA/4jCoSRGI+70AKwjtpIPfkidwV
 vxzpNnHThzUXdL44AaZUcIBE45mcsIguYIbzfteFRyLmh8Q9Z0MO7e3/WRFA80aLE4h8
 GDPXt4qFemutIWawd2+NHR6XWuh0oefjEeZdtFxQWhAO99HRtbwBDjbtRwONLbLvkuSo
 jHh2rEpQxwktXNyJYRK5do+t1On5XT0CLSn9w7hdMvo7XJPivnUSS+MpVsk+MA/mrEdM
 7p0epfmJ04h7ZIc12pWJGB6eEkTcN7xM9g0pTZ7c+CQafx48ZBx8RflDgsnDxG0+vGR9 zg== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vn7bdyg9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 07:47:30 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 290228005C0;
	Tue, 16 Jan 2024 07:47:28 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 Jan 2024 19:47:19 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 Jan 2024 19:47:18 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 15 Jan 2024 19:47:18 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 Jan 2024 19:47:13 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZcfgRy1XLsDtUZyPZSXmPBb7CsxzVZqPcfiuf4QozjjjFCORNtFf3waN0BBUg9F5fhzX71EnuPjxhYobxuCIrF4LQsPOJ0ZqJmYL1HWo8Fc/5wIqB6lpBn/MFdO61xnE4Pf4twbBhJFc+mDPGwgFbba5zn6aq4p0Jq1jvAPNM2Q4glXs16NpURiheRh72QLZhDuicxFpcEF3MTc3BwndL7L6BkKxFPLeqKJ68M2CPzEgG+pL/qX6AXnM7B98ejm5LOXNp1zO3qTALri9Ntn9NtuKvTVDh3aYMrXj6SxxUI0pk8xyTgNpKfjQaJrLX1L2/eNaEHnfsU5xGx8QWsLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFHrLSTXMADC0iyP91ZElEqIHAWBUuLT9c5TSw7+5I0=;
 b=df6TtUjB5Ph8KRHHIzrJmaDXn/1gsbbt4tXx1IAlmyFwik0aB6FuevyaU8kHVR5cnLF9WfipClpWoP3MIL/GmwJy7DJ/oYOZ4KHPTpK+Yfk7z5E1LSZUY2NJmPYY6PVXw6heQ05aOzjUT0Gz4xX9+uCv5AekkUTh9xAAa6ncM+SPiqFYzRibGRObgwPCoY5YHN8CKZrcWtR2inkKCUDlQkHPNdpBvGlVp1LUhNleQm+Rj28JlhzsK+kbgUX1WfVrtNEwfwKlEhkmUcYFKYSf30CWmynirmP8c3506z+aMRCwYBi7BRrRyC0fw0am6DpSiCpkxfkH78+y+C40fxRVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:9f::22) by
 SJ2PR84MB3826.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:585::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Tue, 16 Jan 2024 07:47:11 +0000
Received: from DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d318:5325:b35:6085]) by DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d318:5325:b35:6085%7]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 07:47:11 +0000
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
Thread-Index: AdpFE8+jDPfxLZfoRHSCMkgXPyimagAWEQOAAAOIhzAAtX03YA==
Date: Tue, 16 Jan 2024 07:47:11 +0000
Message-ID: <DS7PR84MB306135F069CAC2B2CBD6F811F7732@DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB14838465E04EE1E2A5C1AF12976F2@SJ0PR84MB1483.NAMPRD84.PROD.OUTLOOK.COM>
 <25fa3854-927a-4040-9942-56f36141c39b@kernel.org>
 <DS7PR84MB3061FEBD32530AD8FD477CA6F76F2@DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <DS7PR84MB3061FEBD32530AD8FD477CA6F76F2@DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR84MB3061:EE_|SJ2PR84MB3826:EE_
x-ms-office365-filtering-correlation-id: 9fd16370-7867-4e2e-65dd-08dc1667596e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e30xzWIxzqvUzvHS3RS/9tVSCru9dMn7tnjUeLq8SFerWHK15c0794+9ehHHsVHtiCnuZFQ8dwaM8zLsGk4aOscVo82RcLRA9rWlWnSeRMYWO3jMWV+Jhx+m1KyBIUMz/HAXLFVbSPmDxJ5vXTij03/S3KI9Sb40ugzVW9Ul9PlNsYlvzkawW/S9laPRV2lRY9PRmwPWOMovkgpKIY0bf7LVuxWv3BXM8UeHH7jO1edeBW3C+fpL4lEQXLNKxjmbH6xCxvq5F5e0gby7piFb5NdXgrq5AjCI419Mnjy/+2q6En0H0uS2OJPMkR9skznp5YM4f5p30hYljQ95AeAKaxMbQmpEAvbwKyrhJqCtrJvwFaa8R+Dloypc+a+1ITW+2YRrPxqF2MNwiDSVemsfuaZSh8P6SMztlTULi7uK3nwB89YD8MBnxxguJXFrfh1ut8IPWEvfWVAawCuKCC1hVUP4cJ63jO3eGMs/G6PbcGL7Ve8eWTrtWCJ8/wTbhlXu44xY2vuz4bgI2V45deunFvxa1jjqjuitmruJVVYnf7egErzKyH6kuIRpC+LrEt0HqASNtNTB9Q36AnKOqTASyqLR9rq/lMuiHSE+zUSu6d/1/bakXN2yOUeM0bnJKMbr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR84MB3061.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(86362001)(7696005)(26005)(71200400001)(53546011)(41300700001)(64756008)(4326008)(8676002)(6506007)(5660300002)(9686003)(66446008)(478600001)(2906002)(66946007)(76116006)(110136005)(4744005)(54906003)(66556008)(316002)(8936002)(66476007)(52536014)(38100700002)(122000001)(82960400001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0NQd2xjSVVqRlRFcDNwOEY4WTFlYThrVEFlcEprK0JyZzg3NC9XVzEwWFBS?=
 =?utf-8?B?dEtsK3pzcTRXd2UrOFh5RG5ERURqVWFWWHpJN2NrWVQzNlVEY3RpK2hNTG9v?=
 =?utf-8?B?UHRTbUZDTnpORFFmdTBpaFBMMTlTbkFBa1gyc1R1dENVWWpoZDdNVi92dlhM?=
 =?utf-8?B?dm1od3J3VEl4cnF3ZDJmZWR0N2V2akZkZUthYVA2UFhwZi91R2g0V0Y1Ly9N?=
 =?utf-8?B?aUJSUU9lUVJncU1DUC83MXRTdGtyOUExblhvWElodGx6RkNjMUg5TDd3dkdl?=
 =?utf-8?B?ZGFubGxaYjM1dFlsV1BNNzR1UlNuYmp6SFI1SlQxTndtenRkUDUxWS82bllO?=
 =?utf-8?B?VUxESWdSMUFEVWFPZ2M1MHQwWmxxeE1pRDV1b0NNL0VQRmIxK0dtS1pPRS81?=
 =?utf-8?B?NTlEY3ZWR29HUmRtWmVOM3g5R0kwbm9jcU1JaDhqRmFzbTNvZ0NsWEtCaVJB?=
 =?utf-8?B?ZFdDWGppU2IwOE9kRmsrb0oyNEVQcmNzSFR3N0xyVnErRnFRa0crbU1DaTRi?=
 =?utf-8?B?eHlPRGtaemtlK2NEai9xWW1kSE9RVkF6ODJGOXlvTVVEeklWQ2xWNkV2V204?=
 =?utf-8?B?RkhSRHhVVGJFYmZjN3I1THlWNGhHdis2RUxUSkowMGlJeFlhZ1kvS3NTL0Z4?=
 =?utf-8?B?dGlSY05HSXZidDFoQ1JWem9NQTFjUDYwU1pleHFzdE8zTW1BMzJ5N1hWeUor?=
 =?utf-8?B?Y0RqYW9XUTVIbGlEYThXOW1HVzJlU0ZaNGJOQ3lKOWtvZkxRYmZmL0xOWjFh?=
 =?utf-8?B?eWQyckE2Q01CRkdNank4cDQ5VnNReE5ib3oySzdEWEtrVjUzRnVMSno0NC9H?=
 =?utf-8?B?Y21mZU5KWHpxKzhaZDN4RS9mMjVsVHVEL3ByRWx6U1U4VGhOekg1cjhjSkY4?=
 =?utf-8?B?NklOeStLdnBVWEx5NldBWEdJR1BjWVE3NkxQOFA5MDdjZjZ2ZG9SdXR0d1Ba?=
 =?utf-8?B?dTBrOVM0U2FOTGJHVnNIN0Q2VFh5L2RpVFRMSE9xSzYrNHR0Uml5SnFuemZl?=
 =?utf-8?B?c2t3OHRDYTNuVUx0SlhLWityTU1vYmtJREh6UkxIbHAzajRSME53MTZlVTBw?=
 =?utf-8?B?SGlEUFdPbXN6RmRkZHVLWG11ZkdqMXZ1bEpaOFE3TjA2cEVtVDV5cEdia0I0?=
 =?utf-8?B?N1hFdnVsdXNvR1d4UUhwNUpud09Ga2U4Q2xjcllKM0dUbmkreGhhME1rais2?=
 =?utf-8?B?MEF2N1JyTzRPQUNRSk9TTVBzSkNrbXVzWW5YYllRRTVGRDFCdEl5N3Era3Ns?=
 =?utf-8?B?TWlyVHkrYlFLVjZRU09maWlKNTV5MzJWZWk5dEp0dGlVZW1tRit5RFVFVm9P?=
 =?utf-8?B?WHZaU2pseENUQjJWckp4M0VteXNURDd5WEJacGJ4amFGQmRRZUYzMVRNNVRi?=
 =?utf-8?B?Z1ZRRU1NZDZmTVlVK0YyZjRCZmd6ZkRHb002dCtrRWxPaGpSK04ySE1lTXVY?=
 =?utf-8?B?a2ZYdkthbTlKR0JFRkxFdE15TnpZNG1kbWNxeTFGaVl3WWhUOXJTRy9PZW1a?=
 =?utf-8?B?MEhpR1REajNTSVkrdnlkVUFLM25IMWhFSTdzOUUwdHMzSXVTdWZvRXphYUhL?=
 =?utf-8?B?dHRDcVhKY1JPWlhpejN3c0lIbEF6eXRqMnZHLzhpb2dNblZobzN3VTV0MWw2?=
 =?utf-8?B?OG02aUR0YzBLN29rNVFTcGdDajFrZHJOcUV5dWYwRGI3ckYyV0Njdzd5RW9a?=
 =?utf-8?B?Ulg1SHAvbTJteWQ4ampBS29rTnBGdWxVWVJTQ3M2OGJQWERxVGJpMlpVQVM1?=
 =?utf-8?B?KzIyZjVNcjVKSENpWFV4QTNXWlFlajNlUzNsZDNxczFhSGhpVXgyNUwzTjBi?=
 =?utf-8?B?MlFTUWlsSkFBdFhjVTFoZ0VBNExlU1d4OUM1U0VwVElLMENoVURIcWhOQzBa?=
 =?utf-8?B?WDlJZWk1UWZ6dGJEU3dGYkVVL2JTSHZFL296Z05FR0pVbHRJc0h6NlNITEwy?=
 =?utf-8?B?aE9uTVE2Zi80L0VtQnhjYkZrNXprWHJHSXZxcFZqMTkrZTdEZzN3WkU0bDNB?=
 =?utf-8?B?bmVKMmpvdElzUSsyUWNoWm94bUY5STByTmRibUdtTjlqMWVjS3NZQUpFMEJm?=
 =?utf-8?B?cVRWYjdRdkpsUHRwOTYrS0F4QU1BUWJlYVJqV1dKNkVJdnJIUmNYaGZVc1U5?=
 =?utf-8?B?dWFtUGlBUEVoejlIQXhPYS9SRE1FcmZud0xOUXZ6M2dNM1dOMmFKcHVRbWR2?=
 =?utf-8?B?eVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd16370-7867-4e2e-65dd-08dc1667596e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 07:47:11.7150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmvgK9du75LNOpw1++G5t16HlbKuQmN556XNRCsdXUmUea9wBGrKP65EVesjLNN/FIACQluYmZ7Y7Xv8zOKil+G2jWqd1CBvL/Ek8BjEQq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR84MB3826
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: vzUIHwwXfvbfMgL84uclArigYtW5dA_U
X-Proofpoint-GUID: vzUIHwwXfvbfMgL84uclArigYtW5dA_U
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_03,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 mlxlogscore=523 malwarescore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160061

VGhhbmtzIGFnYWluIERhdmlkLi4gSXQgd29ya3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBOYXRhcmFqYW4sIFZlbmthdGVzaCAoSFAtTmV0d29ya2luZykgDQpTZW50OiBG
cmlkYXksIEphbnVhcnkgMTIsIDIwMjQgMTA6NDEgUE0NClRvOiBEYXZpZCBBaGVybiA8ZHNhaGVy
bkBrZXJuZWwub3JnPjsgVWRheXNoYW5rYXIsIERha3NoYSA8ZGFrc2hhLnVkYXlzaGFua2FyQGhw
ZS5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0DQpDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsg
SywgUHJhc2VldGhhIDxwcmFzZWV0aGEua0BocGUuY29tPg0KU3ViamVjdDogUkU6IEtlcm5lbCBz
dXBwb3J0IGZvciBpcHY0IHJvdXRlIHdpdGggaXB2NiBsaW5rIGxvY2FsIGFzIG5leHRob3AuDQoN
ClRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIHJlcGx5IERhdmlkLi4gV2Ugd2lsbCB0cnkgdGhpcyBv
dXQhIQ0KLVZlbmthdGVzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRGF2
aWQgQWhlcm4gPGRzYWhlcm5Aa2VybmVsLm9yZz4NClNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwg
MjAyNCA4OjU5IFBNDQpUbzogVWRheXNoYW5rYXIsIERha3NoYSA8ZGFrc2hhLnVkYXlzaGFua2Fy
QGhwZS5jb20+OyBkYXZlbUBkYXZlbWxvZnQubmV0DQpDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsgSywgUHJhc2VldGhhIDxwcmFzZWV0aGEua0BocGUuY29tPjsgTmF0YXJhamFuLCBWZW5rYXRl
c2ggKEhQLU5ldHdvcmtpbmcpIDx2ZW5rYXRlc2gubmF0YXJhamFuQGhwZS5jb20+DQpTdWJqZWN0
OiBSZTogS2VybmVsIHN1cHBvcnQgZm9yIGlwdjQgcm91dGUgd2l0aCBpcHY2IGxpbmsgbG9jYWwg
YXMgbmV4dGhvcC4NCg0KT24gMS8xMS8yNCA5OjU3IFBNLCBVZGF5c2hhbmthciwgRGFrc2hhIHdy
b3RlOg0KPiByb290QFVidW50dTE4NDM2ODp+IyBpcCByb3V0ZSBhZGQgMjMuMC4yLjAvMjQgdmlh
IA0KPiBmZTgwOjo5OGYyOmIzMDE6NGM2ODo1MDdlIGRldiBldGgxDQoNCnZpYSBpbmV0NiBmZTgw
Ojo5OGYyOmIzMDE6NGM2ODo1MDdlDQoNCg==

