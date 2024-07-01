Return-Path: <netdev+bounces-108287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28291EA7F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75C6CB2162D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF9171643;
	Mon,  1 Jul 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="gqVsMZsF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF42C1BA
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870722; cv=fail; b=iLSX1cwlm9oW/wgRioHhsCzqNhxPwhm6upCAnBHKpZL3FeQLGduNTpjK91x7cN3vsLT0cdG5haReoLZn2JhJc9ELursr4cZ0E+M30tEqaHX5ufmGRK1mmJp2ZnBS0euR6kOLcQHIVziqvBI1p2Ow/lWElzoZNx3o6UF3lovf1CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870722; c=relaxed/simple;
	bh=eUTlOjXMKLN9n2wR0MQvWoaAKzgBThpZJR2EHpBli0U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HmeDGBBBLWv7cTl/Bb0LiArtkfqN6hsC9+cKBW7aV7j7ks0LX+htm8rt+E3lp1cQ0gnQ7CARAIdPaR4CvwGCQtybNHUNs6hOLe7a0xFDraSfLlzKAKBctvnLv3EIPUpTSkslsAHKcSTEUIVWwM+9Ny9KjmeB0E30ZUKe1BdLQGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=gqVsMZsF; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461D3Tlo005345
	for <netdev@vger.kernel.org>; Mon, 1 Jul 2024 21:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=n9KfAz0GC
	y0VZCZ7yyiL8Z0ZFrBP5pNlsLKju+U/76s=; b=gqVsMZsFXD4jZ9wKEKMO4aWGS
	A3iN1F2lj84cs9dg3o5IoAuZ7djj14w4f3op8yzGdcDHMDCYbe/Kot1QSX/f86+T
	JjsxzMS+ShECgxeXrkFWIP1FlkUvoia4fhzeraXQCe33TurWgumMOpOzlC80QUFn
	PAjI2Ob5m4cXi9JeChimW1nfrznpotiEBFyobDZuCaooRX/KmOqPl6nNymecHQ4Z
	1J54GxVX1GTxCZOJGQD8jtWxaGfDPVGV5KU3tki09bjzZNcIcFnxVV3NbfDZ+/Ca
	1724KY7B/NlGpe62IKg2RpX/cZLqqODJALfbjQWHn2yJ/Jxy4BC3L7aM3jnzA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 403w0fun7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 21:51:50 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 58D2980025E
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 21:51:49 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 Jul 2024 09:51:17 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 1 Jul 2024 09:51:18 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 Jul 2024 09:51:09 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYxfrxImQjIbU8vqYbqdlPwanG7fX8sQPcpsYXX24Iyt2hgkdVMul51fCeMfoHJ+1CwWK1XbDX+a8R7N4j8getmkyZ44sM0lvg/1lxl77vv4TZU/kFtu2NVm2T+wflTtVh/pYzijlv3eGJjwVAhRvf92F3exlj7wKFj5IDJWzb8WRac/MWahs/HFfm1F2JUlyul1MmnChyn5Wcc+iInuL20zVyC0De/L2jNBIC33JNNqcQaE31NoAAmFVS6RUDSunoYh85AtI0Q5dYM+iDOwkRC6ZyrKYoJzgis+ckiszLmm1B8pBtMORKnKk2d9p7S1ZrhCTDSue1YsG9WXlJ411w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9KfAz0GCy0VZCZ7yyiL8Z0ZFrBP5pNlsLKju+U/76s=;
 b=nlIEiaBKyCE2Gw17vWl2UR/ac69/MEJIkJ5o7kRfyLp0/qbqywSfOCw1vy8IPbFKE1XcJJIcDFPuxnk/n0QT/DrFRBIv/eMRhh+oCOlMi4xlTq1kYi47J33DPOFATCFQj3ytF59RUMfqFFhsjAfDwPClf4tGbDTvBFfxlYuFrxECqvlBnplghaZF0uVZCBMZZ5i5ttuiR+Hc0VVLBseo/5Lbto0oWAllKb5nuPJ7JtOBz4KOQg1FArwxsfzkWWJ80S2l/gzERLd9pddjz9FDBvrX+/bKhAbqzlKIkmXQm0dxJhtGtTO50fp8fkx3zgjVqKV2JMNLp39Z1XYTZ4EYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by SA1PR84MB3869.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:806:3e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Mon, 1 Jul
 2024 21:51:07 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 21:51:05 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: ECMP Routes choose an UNREACHABLE nexthop
Thread-Topic: ECMP Routes choose an UNREACHABLE nexthop
Thread-Index: AdrL/xI8WlDCx9EcT7OORZD3csqP+A==
Date: Mon, 1 Jul 2024 21:51:05 +0000
Message-ID: <SJ0PR84MB2088FC1C098F1CC996545397D8D32@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|SA1PR84MB3869:EE_
x-ms-office365-filtering-correlation-id: 99501894-22fc-4ab2-da23-08dc9a17e886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7YOkGLkKDfhEkodu09AaSrfvBqox7CSoXM2kbreijMHJYAZ5SSHj7EBkhBmc?=
 =?us-ascii?Q?Voqlqp5Imv18MtpQyvaQLneEakhTWpOwDZ5sl0XBh1M9ckzepSB0KLTZwU3X?=
 =?us-ascii?Q?pmwjBb2tZE5saTg1BfvY2a3ly/rkiow38wZ8zoux/izrY2zBLAK9XECBqiuR?=
 =?us-ascii?Q?4fBpVdfyHV/4OIOiR+QoJAYou0Cto1d9bN1Bc08vwlUK3RedETK8xVXIq9Wn?=
 =?us-ascii?Q?VHRUsWiTSkefr4/CPrKY4gTwVavG8wW/iKhwJ8DDbP3tS3fTqXVo7UrEocjy?=
 =?us-ascii?Q?4nnaCPG5wRrzq/GihH754TlATBVoFDSheA1JHAuujqH1uYoZd8zxk4GITp4c?=
 =?us-ascii?Q?3+E3HWw6TUS767e6qvPL4fEkeji9R6Tfs+q1jg91W5XJaoA4YrG1LbXiSKD2?=
 =?us-ascii?Q?jsjyrBGwx/gg8MIRO810FzjjqsP87at1yckFltAHHlT658dBVpBuVeN5AqVH?=
 =?us-ascii?Q?TUFE9VdoEBIkZt7igjz7eTXmWS8DBRGBAklcX9w24GHBMZziMSWx4ZMGGY6x?=
 =?us-ascii?Q?DIF7nkDywL1J5OyTzVf2ZjqOfzCl8YAvzFt0jc7M8UqJxkS7+2qp0RXMMJAl?=
 =?us-ascii?Q?4bZ+mUbJBVtA5REBKYl/1p8Dys12JNOCWo4VVvi3LCBt31eKVxDR96MRprEB?=
 =?us-ascii?Q?dao0FkSddbH82CTAxZhP0Yb8hmmD+t2NnQr/78tSedOffje444N4Q2qoexT3?=
 =?us-ascii?Q?rzBXmReioMzBGKnsUFBCp8W+ITjE9UrM7LGGT93xUEo96ovDn9fehAc7YUNx?=
 =?us-ascii?Q?UDmY8+bNOiY1QrLb8GGIVb3m886Tall9rrigiNZ+kFNVxlnagNkxSckcZKaN?=
 =?us-ascii?Q?ogoKDtciDPtNn5LUW6vrpl/1qesypqRedGd9yix2URaP6dW+iJbi24BAsrZP?=
 =?us-ascii?Q?r2TKPtSV8mCs4/lcM/tD/lbO3UCyGDjlChaJjAt9+i7DGeta51otu/KQz2H9?=
 =?us-ascii?Q?X35pYUu9ZMF+zfHEKp+6Gx7d/GGoVL9hOOPWc8V9eE2LX7LWY0eMiHjdNhzj?=
 =?us-ascii?Q?9fqMHdUTtLmSgHI34/5hm5RW4H0ngUN+ZVaaSDanFbyfBX77N3tFJTSPsS/W?=
 =?us-ascii?Q?D5OXtmzNiMwcoHqTRxCzkBgiLKmwnXMLkW4i0MKKcdosjmcw1AJ2aVxysHj7?=
 =?us-ascii?Q?lXjtcyr8W2sS/kw52WqSMG5qfT+dsLlsZM8deYgoRLMqybZ3Y8oVb2+JpEr+?=
 =?us-ascii?Q?/HdWRLi5GRKyEcBlKX0Mm61oEcyv/iPklTJQ0Gzbzm+A3g+cSRFuzdUro8/+?=
 =?us-ascii?Q?CayIejGVaQbaCVwfUA1obD4MDwOQk72jPDlHZ8uavfI7AqHHVxFKavWK7XWt?=
 =?us-ascii?Q?Of24wcn3ZkE1/T4f1PUivFf1NH198tFl3FvZxF4IP47Rrk90b1nukANnDfGt?=
 =?us-ascii?Q?CSfAnlYQw76sr6nOfG9uecbqyjPKvhpbUTgx7a4OdTGgJ2W6JQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C5wOr91m5zrC+qyb20CN5pqNBrSOH+xnRIUfo9kc1VJcDQnOV3DTeW4lfKKW?=
 =?us-ascii?Q?h/tYCECA1ewtYk6ARLMLQtcyY9V5VkdX11xoxm01YWvCbocBmPD+O82UfXuQ?=
 =?us-ascii?Q?VBLrLJ4rgORiUcs+7C/j78jwuEWZQ3yZVxPCeS0zAIAXwXgmMFzemUs/w20p?=
 =?us-ascii?Q?gBxuVqwlp0D8VhH1yBtefShZ5WxjVMcQaYnBRLm/MebZ3zD5LXc9w6Hd7x7G?=
 =?us-ascii?Q?ifRt6lgzYQpbGPI+ZlQnzOoysFIWdnJzLQF2Q2ZmgE/vjywUnP8WlbSRBZtj?=
 =?us-ascii?Q?08edpo791eNnUHNykRRWOHv1aHhEklivJVu8qrFaPAIRkXXjFFDS1GQ10REs?=
 =?us-ascii?Q?pC7UCrTWYC5q3lpiZUkRmo2efPT7Is4zzQeMP247vfOlIDyL0JOL4NnCA3Dg?=
 =?us-ascii?Q?Hy7blEq/w8A/kvhJXTOg2jGo57aH489bBCb9PWkMEdW3lb/2Ci9giddilzMc?=
 =?us-ascii?Q?w9KC4/ekKliI9d027kCa56ct6hwGkma/V3B97IM4Y+qzge0rMGRKSYpzqJLU?=
 =?us-ascii?Q?jgO8DGEeet+o8Izg2GJZWxAGJTbyE/HyBGzqIno6nWzyAKT6+seRV05R7HDs?=
 =?us-ascii?Q?F9kiNavqZUSxxtQOnJhhPbZnKIyEl+X6beUt81JgWwpYHZKXUc1s0mmR40PZ?=
 =?us-ascii?Q?Y2mc0A/utq+dezB7QRU1BFOOVu9yq4mZHaXKU+3C6hHO12SPR5kvh+tqmkFL?=
 =?us-ascii?Q?ciq6k1EeiGdMQh1BeFR6KYe5IZj3iqJvoyEu4bz20ULV1cFU431fD+lhBBeY?=
 =?us-ascii?Q?x0Si+J92yeKF7ZGqT2YeXkm260n2P2SmX/KUjddRooX7p11w8KAOI3oWm5sp?=
 =?us-ascii?Q?joKcfKQYvNt8//QPT+yy/1/JS784n8LR1rdShUbUpi1DXirlYOtTI8ZZVVkH?=
 =?us-ascii?Q?vwJZvCWcsI3BDhOvZQPgKYVm/09OOCBb/wXon/y22RxeEQ316a0yOiz/0vty?=
 =?us-ascii?Q?oX3xTa0rpwhe3PGUF2f9cdHnJsYSPSkP+F1VeQYALwtsYIfKLrBpxKuLkXni?=
 =?us-ascii?Q?Q7FqXmeGrdyjjKg4VOLNLohyj4rU7oKUu6cht0GNiHTklfSmEN4o52LoHyWP?=
 =?us-ascii?Q?wGfbdaoSQWH1KK1btk5oLwvoBoXRA/ZCvRmwMBQQM0E/DCUJUrF6csX0USza?=
 =?us-ascii?Q?Rx8R6Q0cqvgLRqb6kWq0zxEB+r4RMSUh7aKg4pHmnt9cmQHZ/EX5eEawqAwo?=
 =?us-ascii?Q?I56pQ0HRxBPuohNzo1kC2+s4UGiKRMq3Dwk94+80annXiiuc4zCguwQmm9t4?=
 =?us-ascii?Q?dt1RYaF/qcgN8ZFJeXtmeL/QzR4MblmdAq9MJU2zxciHDPDBuqaJZ+jfz2bG?=
 =?us-ascii?Q?1esvS4QCA41oRpz1gZEsedyFZ30Ph/88BH1iy9+5hEm8UOz0mEbURGeuOuaN?=
 =?us-ascii?Q?MpPHwO1BVjfT0B5Ae9Ovu1i9stxCInsuu04wn/TobP7056oaL00EcSL8Wp30?=
 =?us-ascii?Q?RbolCxnpTHm7sGISBup2QRJRwjxmX+MYwIIqJWDGUvuu3b3Y33VP7sdrwQxW?=
 =?us-ascii?Q?jFD37WI1wjpqgCELQcNmTOujwlWhoc7sNJG1KQ/WTcb50HrMZM+Ae5Ldnuxk?=
 =?us-ascii?Q?FC/JtvLKeTY2dOrlbefyQa9XtswNzlkYkg4BKtee?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99501894-22fc-4ab2-da23-08dc9a17e886
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 21:51:05.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poO9gOskIx+sDXUH1LH1/rcrUCAg9dBwWA46Er7cFw7bpqE+60gyIzQEVjMXwbyNiOaLiXFN3TvGFMewdvwNQLBK6mtt25yuf1VRUNdtKls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR84MB3869
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: fNyvKTM02E3WYSF2Jy9KXaF1jeUKFhGK
X-Proofpoint-ORIG-GUID: fNyvKTM02E3WYSF2Jy9KXaF1jeUKFhGK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1031
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=814 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010162

Hi,

I didn't get any traction on my previous topic, (Wrong nexthop selection wi=
th two default routers where only one is REACHABLE), so I'll try asking a m=
ore direct question...

Do you expect ECMP routes to use the Neighbor Cache when choosing the nexth=
op?

In my case, I have two nexthop routes, where one is REACHABLE and the other=
 is FAILED. The kernel chooses the FAILED route, which breaks communication=
 between endpoints.

E.g.

$ ip -6 r
2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65531sec pref me=
dium
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default proto ra metric 1024 expires 595sec pref medium
        nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
        nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

$ ip -6 n
fe80::200:10ff:fe10:1060 dev enp0s9 lladdr 00:00:10:10:10:60 router REACHAB=
LE=20
fe80::200:10ff:fe10:1061 dev enp0s9 FAILED

When the host receives an echo request via "1060", it responds with a NS fo=
r 1061. i.e. it's trying to resolve an UNREACHABLE nexthop.

Matt.


