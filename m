Return-Path: <netdev+bounces-128871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694D97C311
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 05:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDF7282502
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C013FC0C;
	Thu, 19 Sep 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Kn5pztvg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1428EA
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726715421; cv=fail; b=YAkB6Ps+taP5FxjpqdlGaV3ufCQZ7RLwd+xwyjwhL2J6Wsb88RBgM9a7qSN3P6EoodmenmvN0gRqxO3Fa79gLiBmv56OxRO0dvtsoSdQWqkuaMu1x5/5rg/Ts3/UHLWB/GZDyh/eABOLc6quoctxKrRBP0WEEtQz9cgO2z2cImw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726715421; c=relaxed/simple;
	bh=AUHJM9r1TdhqUgman8X22ZkO4JSxGk2oDAf9ICrpKWE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sRLDC/AudyE65SwvwaXDpAtHB6FHLPefoDoJ1l4p58ayZvLA0wscDXPgUIaWOMCe9PJ59s2HWsbAOoNiwOyazCN5sRqJW5nJBpws0bblZdekIdNdzuZ7J1p07osQLVuj4B/SJ/gHnhd9TboP3Cd3dtresTOORltxE2rcpAl70OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Kn5pztvg; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IITDeD008809
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 03:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=jrMUo5jp1
	pFDdjbeD2L1o5r24ghuEc7Tbs1AfU6wfN4=; b=Kn5pztvgfxoor4+bXvK8jPknz
	1odesx/4VCR3CT3Mi7TbgltZceflWUzOELKQKu6aaLMm0x475GzkmTMkpWwTMc+Z
	wKMgA3OS95B8QpaA6YQZ+92MdSb185EnXtvYnEJNCHYI01hiir5gRRFGRZgpgcGO
	lZw0ESbBd/yv5UCl3Hg3a+fG2ygX1qySGHTgyyxzsPumDyKHn2dcfRyox/MeBXIf
	xswMuuzFBXqkHw5dMujeyOLu3ioaBhvFuemsSoU+3a232JFsveZGABZMVzkDXHaQ
	yAeNYgLGRZH9ZkbspbxzdfecZPVO9Vb/TR6i6NNqldipR9MviMt3rBtdFwbfA==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 41qu55ex2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 03:10:11 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id EA4BFD29C
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 03:10:10 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Sep 2024 15:09:48 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Sep 2024 15:09:46 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 18 Sep 2024 15:09:49 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Sep 2024 15:09:49 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7ilk71LJOa0GpqhWFk0MXxlEsh8NykVWGaJe2lADSZ8xnJKcQCYpiwVHXwZuRnUCtFwXVzkbnJ64H5xy/iVRbsvbHVCUEd0G5BsyzGoaGSd6/pWBY08duUL9S0XBCBxLN/ou2iDMkPmkk6U7fOa3qvdOZc5UM4q67KSxe0wsWvy0mzRR7w/qmGTTniiokitJUSCFlJ0IwCNdm6l83nIusjWr5+h7ZwburLhCDgW/agP00tmkl6QqHSUmlAjm+yGmRudd2JwE8mo2nSmjqlgfhTspXV5CqSw/jgxAiUUg3zWfUY/wz/DqPJr4U3GdG2hVc1YyRnoFByI6/R/XTPhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrMUo5jp1pFDdjbeD2L1o5r24ghuEc7Tbs1AfU6wfN4=;
 b=Nd5Q5OgPrUB0ISYC8TurbVpVCqwK9w0Q1jKcnwMHOqiLgiHHd4kyR68yKbjnXxajts9Q+oN63QP6pAr3H69c3KAysTzWA94/cc1wNli650NXOmBWP9OLnQtXv4Hwg+HgLpOXz2dhWbv10HtuU3DRxgFXc1bOczmiTrZv/g4m6ya7VNVppvapCYT3NeHINZaHIs1D/u/kSWqR9fhntGm/nskVTlCXMRdi18PkFY6JmscPy8eF5WfvDsIafmbkjZab7eHk5Qm93CJLHhNWKuxCQK1UyoIOGN9px00YLYdkR6dCiuSjaXAytCTRK/dxmJV1t9Qt8KauQh5wnfqSVgxQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by DM4PR84MB1686.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:49::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.16; Thu, 19 Sep 2024 03:09:47 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 03:09:47 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next v3] Netlink flag for creating IPv6 Default Routes
Thread-Topic: [PATCH net-next v3] Netlink flag for creating IPv6 Default
 Routes
Thread-Index: AdsKQUwy+5AXMFCsQyWGVNNd4Q2Tlg==
Date: Thu, 19 Sep 2024 03:09:46 +0000
Message-ID: <SJ0PR84MB2088FC1661ECE21663B2F59FD8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|DM4PR84MB1686:EE_
x-ms-office365-filtering-correlation-id: fc9dcaaf-68f0-4c96-6206-08dcd8588473
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kEIwNN485ahybYKdV1NZvP07FvYf7KWg66yQ4EBblnmIgXALcShJWylgqp1F?=
 =?us-ascii?Q?Bl7dr7zz5r+56gd5jBvL6cs1seUFOBLova+Edh44l2Nvu/Kz/e/FBHs2PWZ5?=
 =?us-ascii?Q?UxS5d0ELFJ50CwqarZHu7AUdyQMVIROyuJfln8OPznnRrk76nJgMojpDRID3?=
 =?us-ascii?Q?aw8vRle66o8/v7QUianc1CHfDzKU+a6C9+dCgwhs1Zie5JfnhaYTy3cYSQRq?=
 =?us-ascii?Q?Zk/A96075pVz2awL/Fdq2WL9tGzaKlnoSH6ecGTL8gk9jyAy07c3UW7ajjZn?=
 =?us-ascii?Q?c7ec3NvT6v80Mt/eF3+KBEG4ax4N08rqiicA64BaHF/l9RdrN3XyaHljRoTp?=
 =?us-ascii?Q?Wk+OuYRy7XYhk4v7mxok+Z+67zBw16Bc8puT476Uvt5sFChuYcv3GBalAE13?=
 =?us-ascii?Q?ncHgU8D7seUsRWDR78hRYm2QTh/fc94Olyu0WLLWuYDj+G8plHDsaEXg+4NW?=
 =?us-ascii?Q?wYSAipDV9UlciYQKzZI9is9rlV9kYcaKyJ7PGm4DdTg4AJB20pvvhHZ9g2xR?=
 =?us-ascii?Q?fmQ+V/7PiFIWRrH10wi4aXeia8r5ZJNy/XUMwTNu5CQjvYzCrdTV2LKKR500?=
 =?us-ascii?Q?ukHSH32KlGfDCGUd6o4h+fyaPmNTlwjRAb0gCvfG50QCQL5yf7ypxF+K3EMh?=
 =?us-ascii?Q?2I0PYPg7bRs0+ve72kCoiBHbrnKtrgnFrpsu9R04LKV9WGCrKBh4YZBGAIPc?=
 =?us-ascii?Q?QzY4YyayA28dXxTwm4UOW66VHo9qvvQFyKtA9W8zY1r3mg4AhPQeve8rk+xn?=
 =?us-ascii?Q?2hNLVqIW15OXj6V3bI5bJKYQmGIEawkl7xHySjkiYuF5McuuYyPT3/D1rxMB?=
 =?us-ascii?Q?x1zZP/m9mLud5gsujkrbpkJmBtyPFBkMKFE0aInYaPsB9JthUSY0q7ORVnFz?=
 =?us-ascii?Q?p/EHq/fJRsU8x3wnDBUBEEheQW7R172g1RT0JojlWO/OWcI1xxCWTY/Q0ZwS?=
 =?us-ascii?Q?OQ6cmHN4TBfAVHHRbalQkTpQYUtDvOWik/q25vs2hnslvwcaWDu9D0xjjgrP?=
 =?us-ascii?Q?zox1PPIroDTgJI1/iA5MxYikZIQLQJEzyZpkJw8kLzaJEK1mkgE4emM1Wr7f?=
 =?us-ascii?Q?YYcR/ECXpzVjCqnkK2gVzUoZ/MCgx27K8l10bw+VEQRtcbmjf9TxfO1w633K?=
 =?us-ascii?Q?tVIGbD8GMEQdQbSVN+z0e8O+rW8PF6mShb+Xsn1h4TI1tPBanOQlA8hh5mah?=
 =?us-ascii?Q?f+uS+7nkv3G9e3bP9ajqbKKyiM7wy3I0VH1UqGAmbxURmZrRodFzpQOwNvp8?=
 =?us-ascii?Q?3Ba9kMWYoXhg/TPG5G0l+LeQ1RsHKSB8cQI2CfmeyvNGFFxcjibtVnatlxU8?=
 =?us-ascii?Q?eLCTXumXLhOimmnh1JcMtcNLMIk8yZfx8sevVUjJ+VfNh4UL2SREhLlTbkM4?=
 =?us-ascii?Q?5quXe24C04VSEDyWY8/m+Qc/oEcSpFzdMqCBuKYkvlgGCMo04A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ycs5Fuz0LJr0BbXyLSeLP3vudxd6Nmbzc14s3yl4Xv65f+YbCJZKSGUVOnRc?=
 =?us-ascii?Q?kYHnL044iTomhx2IdTQJNPYk7jq+ThpQfCRgreHl+jSqaFsxu27lfJ23OeEH?=
 =?us-ascii?Q?3t8FBQSmO0nxtW+a6BE8CbrozwMcJYQLM61R8rRa4Iu19i0JMRvdOMiLyxi2?=
 =?us-ascii?Q?IHfsWPZrbJrs9jh19WC5YMEWFS7ZlAJ0QhQk6ogac+uido6LyqBvS3fw3b6W?=
 =?us-ascii?Q?Vt8YpchV+zjs8QYsN3BMDq1OpAer+iB0A55D+AFZ9u2kqsBdPAoRfRDqkM8w?=
 =?us-ascii?Q?C1L6lUp2C6RLo1AFV2G7wiMH5tSQjBkS5LStfkwwAuHPplX/OagyV9svT0Pr?=
 =?us-ascii?Q?vreGJoHAmnuTXBDDPlEr4DDWTp3McpUK4u1nEi2uTRU0AmbAe8bH0GebbQpW?=
 =?us-ascii?Q?ri0KB2F2zawFtlo4gC/Dud+vLALD+LvT8xAzZn825EdiCgTBvfXtQoksnQMp?=
 =?us-ascii?Q?oei0d081MxrA4tMlWiRhqhwNDqsLM4X6Q5xEIAWuz2UrbfcSwE1xDvGRSjlR?=
 =?us-ascii?Q?WndIdRGPTiBvVGpbtMcJPKj+FvqDLk2Gstfd1SDxVrmfPA7gc1SHu8bPbKtx?=
 =?us-ascii?Q?lQM07epOPsz4vsgajmYCt8p1E6+M2Rrkj13LSCYbMOLTwV8yvtptFCHIbwsS?=
 =?us-ascii?Q?XtbKfC0X2hHHN4/3Cc1OC5WfoJ95bEvcxc4wkifbyCaPT8dFP6cC64S1W7/B?=
 =?us-ascii?Q?0lqzg2Ldhxrr3CwAodf7gQyT//4GgBLdpMvX+K6VSWjcmI8BIfVQoWidCQ17?=
 =?us-ascii?Q?Lbw8Hns7AgRPMZrAKo6xvvuLXtS5CRtILzK5aeOZjeTczQHxKpydRggj07JH?=
 =?us-ascii?Q?8RxjmPaHhheHUaoxWd1c1HkgQhqsZBLBB/uEncCqBrikErVC+XnHI3WKnerO?=
 =?us-ascii?Q?DRG/uLGn74dqkUYLTIaSRTjLwwrIFM14DgKmSSuI8E4HY4X0mLGys/1LqllQ?=
 =?us-ascii?Q?9O3efiM3+oIV6BqG+miad2zHGCjPSuKE+xoqeEQAW2CTCL31l1WS/+XX+kgK?=
 =?us-ascii?Q?nEt6UecmaTwN4IAWU+vf+QZKxaRof9zOqPb4CzgKhSyZigoiKDwFmdjzwHT+?=
 =?us-ascii?Q?7qReJUrBm/eKm/tiE/+vgWkWMNKkpuqi355k2ytyIDk16YJaxQXQ7kgY91h/?=
 =?us-ascii?Q?ujyj6Kg2oe49ramaNpSq9GZm528scHDsnZzwD3lBki6cDPxeOyNKPaG8k27N?=
 =?us-ascii?Q?nOzjbt2oOvvu2WujRdfd3s2u+q/dQ/9mJwp1nmOnDSig/dZZNRoMZIZ85qB7?=
 =?us-ascii?Q?ZMZayN/psLyRlIAkgygwgOzJjVfFFeqw63mVnDuHRFU379ER+uezSlNb535n?=
 =?us-ascii?Q?5FEFeRweHPzGastUVQGyb+4dZpaXOn4X8R5frp6TOdh7RCilzEMwRMseM4Df?=
 =?us-ascii?Q?x5FJ1HFQNkrYPn6BXZsHTXc1A4nP5fWhK48Qo6mTwNdYgRjxnYiHDL30zjzL?=
 =?us-ascii?Q?2abn2GRFuxdrNEoJFddmIlfolmh4B3uRhFH8il2Qv1Q2I0ouyQ/LGXcJUsD2?=
 =?us-ascii?Q?omWWiOgu7lc4JvyKeerTOjRnGTJj1zFwoGzfZMVVHjuLDqLdHqCBddeY7ub1?=
 =?us-ascii?Q?vqCxF8iTdTX9y4qqinp96rKmKdfinP5crBcTnh0I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9dcaaf-68f0-4c96-6206-08dcd8588473
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 03:09:47.0080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRuA0Jarqrnk00DD1y0iSPUUlITE5ywdtY9jD9uITkj5r3pAppOUxzksWZu+smGvQGj0sYka0Y5m8f7TRyZyqzo6W1hxuQutZPNdV30m2JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1686
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 3Kzi8gHw62bKamvsQqJBEp6H3tylPOuY
X-Proofpoint-ORIG-GUID: 3Kzi8gHw62bKamvsQqJBEp6H3tylPOuY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_02,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190021

From 7b6ccc0ce49f1bb440a6f91f45fd2e46542d169c Mon Sep 17 00:00:00 2001
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Date: Wed, 18 Sep 2024 22:55:57 -0400
Subject: [PATCH net-next] Netlink flag for creating IPv6 Default Routes

For IPv6, there is an issue where a netlink client is unable to create
default routes in the same manner as the kernel. This led to failures
when there are multiple default routers, as they were being coalesced
into a single ECMP route. When one of the ECMP default routers becomes
UNREACHABLE, it was still being selected as the nexthop.

When the kernel processes the RAs from multiple default routers, it sets
the fib6_flags: RTF_ADDRCONF | RTF_DEFAULT. The RTF_ADDRCONF flag is
checked by rt6_qualify_for_ecmp(), which returns false when ADDRCONF is
set. As such, the kernel creates separate default routes.

E.g. compare the routing tables when RAs are processed by the kernel
versus a netlink client (systemd-networkd in my case).

1) RA Processed by kernel (accept_ra =3D 2)
$ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 expires 65531sec pref=
 medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expire=
s 595sec hoplimit 64 pref medium
default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra metric 1024 expire=
s 596sec hoplimit 64 pref medium

2) RA Processed by netlink client (accept_ra =3D 0)
$ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65531sec pref me=
dium
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default proto ra metric 1024 expires 595sec pref medium
	nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
	nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

IPv6 Netlink clients need a mechanism to identify a route as coming from
an RA. i.e. a netlink client needs a method to set the kernel flags:

    RTF_ADDRCONF | RTF_DEFAULT

This is needed when there are multiple default routers that each send
an RA. Setting the RTF_ADDRCONF flag ensures their fib entries do not
qualify for ECMP routes, see rt6_qualify_for_ecmp().

To achieve this, introduced a user-level flag RTM_F_RA_ROUTER that a
netlink client can pass to the kernel.

A Netlink user-level network manager, such as systemd-networkd, may set
the RTM_F_RA_ROUTER flag in the Netlink RTM_NEWROUTE rtmsg. When set,
the kernel sets RTF_RA_ROUTER in the fib6_config fc_flags. This causes a
default route to be created in the same way as if the kernel processed
the RA, via rt6add_dflt_router().

This is needed by user-level network managers, like systemd-networkd,
that prefer to do the RA processing themselves. ie. they disable the
kernel's RA processing by setting net.ipv6.conf.<intf>.accept_ra=3D0.

Without this flag, when there are mutliple default routers, the kernel
coalesces multiple default routes into an ECMP route. The ECMP route
ignores per-route REACHABILITY information. If one of the default
routers is unresponsive, with a Neighbor Cache entry of INCOMPLETE, then
it can still be selected as the nexthop for outgoing packets. This
results in an inability to communicate with remote hosts, even though
one of the default routers remains REACHABLE. This violates RFC4861
6.3.6 bullet 1.

Extract from RFC4861 6.3.6 bullet 1:
     1) Routers that are reachable or probably reachable (i.e., in any
        state other than INCOMPLETE) SHOULD be preferred over routers
        whose reachability is unknown or suspect (i.e., in the
        INCOMPLETE state, or for which no Neighbor Cache entry exists).
        Further implementation hints on default router selection when
        multiple equivalent routers are available are discussed in

This fixes the IPv6 Logo conformance test v6LC_2_2_11, and others that
test witth multiple default routers. Also see systemd issue #33470:
https://github.com/systemd/systemd/issues/33470.

Signed-off-by: Matt Muggeridge <Matt.Muggeridge@hpe.com>
---
 include/uapi/linux/rtnetlink.h | 1 +
 net/ipv6/route.c               | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 3b687d20c9ed..9d80926316b3 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -336,6 +336,7 @@ enum rt_scope_t {
 #define RTM_F_FIB_MATCH	        0x2000	/* return full fib lookup match */
 #define RTM_F_OFFLOAD		0x4000	/* route is offloaded */
 #define RTM_F_TRAP		0x8000	/* route is trapping packets */
+#define RTM_F_RA_ROUTER		0x10000	/* route is a default route from RA */
 #define RTM_F_OFFLOAD_FAILED	0x20000000 /* route offload failed, this valu=
e
 					    * is chosen to avoid conflicts with
 					    * other flags defined in
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..5b0c16422720 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5055,6 +5055,9 @@ static int rtm_to_fib6_config(struct sk_buff *skb, st=
ruct nlmsghdr *nlh,
 	if (rtm->rtm_flags & RTM_F_CLONED)
 		cfg->fc_flags |=3D RTF_CACHE;
=20
+	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
+		cfg->fc_flags |=3D RTF_RA_ROUTER;
+
 	cfg->fc_flags |=3D (rtm->rtm_flags & RTNH_F_ONLINK);
=20
 	if (tb[RTA_NH_ID]) {
--=20
2.35.3


