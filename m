Return-Path: <netdev+bounces-236167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B637BC391B4
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 05:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BB0C4F7365
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920812C2377;
	Thu,  6 Nov 2025 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AVuqPYjV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B732C234E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403789; cv=fail; b=JDKPciZzNNPQGz7dLubPgDj4/xwlXMWeuqJ1Dhn35ZvXyxBQghxtCKEr9+GmSFkqyGS1+g0maGlveroz9VgBVknYF63Mhu4hAzpbWPVBPK0RExEQsfunK3Mw1xJzEft1jg2huaBB03nj7b/atxHLvu51c8k9vTmZpQmI/RPxxSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403789; c=relaxed/simple;
	bh=/B2nCxcPPT9UoT5M0kAATIA23v+1YIm3feyF+eEZNjM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X07RDE6e4GEsMd/61vaGQCFXYIy1PACxskm8HnTU8jSGOM77Qd4K++MPor7LLPVUuckkkvjdPCENgHui7zT0senTWF97LLGThc9sjuMOo9luMZBrbAYXWNE/qPQX5DBqFsRnernW5EKJRQ8W5+LR2GhMMKhnPfkBpWhRVHCAmMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AVuqPYjV; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5NangS2470933;
	Wed, 5 Nov 2025 20:36:16 -0800
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022089.outbound.protection.outlook.com [40.107.209.89])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8gdhrtjq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 20:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGYLdfGqv9G1H4IfhcBfYASagbWpTHH6YKTZEYUhFa+PBdiF6KmbQadkCBp8oOIORSI7G1/iHY1qmiSmY2MmtyFqEzu+WrrpK3MSuhneJessk1JI6i71bfl791o1EIQhAlaCYL9qjN7wtoC4fsl07uMTMXjlCHp6bPJ1+2+SRf7Tj0jUaiugBifmb/8afUvLqAVyTI477Aoq/SjyzFBWTaWitTBzNDJ4RiVGCjJ5DzCvY/oCg0T2o5dd3g0mzP5lFOIFRQ8JbBfamIcC6vke8ZnXT5HzZYbFFLhzsnSeFqb8OY6zlgQlwezSW262i+Qaz0x2lOp13e6s4c/SrbvMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B2nCxcPPT9UoT5M0kAATIA23v+1YIm3feyF+eEZNjM=;
 b=wmJN9Vp/DtngbDw2iVJUDkKgrVOOX2OY7jkFzC56O8ujH8PTUweuHY7DqVppsYK4MkLs80q3LEXPkxz4BMwu8wc9qrSnO5Z/tQ8tAs/xsjBE3jhKi7NJaSG3XkxuVmLHNCkONRiuzTKkMGq6REtftD5VX2IFZNLy2WgEYj0TKTKhNFDIXyd4tGv1ChvIELcp8Tb+kPicNbW2+dtmQZk5tmd3L2gdAt59jJciSXec5yUmjvIDSYUP5mZNZNyyBCleaOB0X6vv9VxghMdZsLQ7pLmKTFhvIJZMRCoWqJu1CnASZy4gQDNu909b79/t6s06Br8W3tl96c+CRmV1JPmImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B2nCxcPPT9UoT5M0kAATIA23v+1YIm3feyF+eEZNjM=;
 b=AVuqPYjVeBRbi6hjus9gFtVm3isSonoVKiZCQeztN1JFGiiWg67njKB7awo/qsUhKHhTUu8A6fJmjys9Y6VoBJEuGLKXPMk7TaGItC6d+aD/y7q0+Lm2JeQSOKKdB7Rfjg87G2vlbNyInDEjZ118Aw1gmEgJV3dfML2LbiMCuqs=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by MN0PR18MB5848.namprd18.prod.outlook.com (2603:10b6:208:4c2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 6 Nov
 2025 04:36:14 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0%5]) with mapi id 15.20.9253.017; Thu, 6 Nov 2025
 04:36:13 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "joe@perches.com" <joe@perches.com>
CC: Netdev <netdev@vger.kernel.org>
Subject: check patch error.
Thread-Topic: check patch error.
Thread-Index: AdxO1di7t3Q7enJFQLGamYbens3tkw==
Date: Thu, 6 Nov 2025 04:36:13 +0000
Message-ID:
 <MN0PR18MB5847DF4315B6265D4056DC7ED3C2A@MN0PR18MB5847.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|MN0PR18MB5848:EE_
x-ms-office365-filtering-correlation-id: 9944b369-4a73-4b04-5ad6-08de1cee04a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1jEqwOZml6hN+rlmNt+B2YLEYRpHetubfPdEsk3cLYcivyang84vZR0Eb+Xb?=
 =?us-ascii?Q?kjlNIeeyzb3rIRKYFgtf4cxcf3OEvJnNWOVTTK8bUoihtPI2ciwTZK4gC8kl?=
 =?us-ascii?Q?ArndkKcIkh8/tpBUA4vM2Bmh5zNdXSvxHqbAqP9c0wyYMe8qyH0S7ZC+FCJ7?=
 =?us-ascii?Q?Gn6PMIjbX9cXAMb8aJRB3lK33PyyRvnqCiBVacQYbf6SLEAfgZPY/wEHXfYV?=
 =?us-ascii?Q?LB8B+j+l6ZMTjMtRpnMjK8Vro4i+JI64nXMcn2woy/KSi2o3v3QvkcBB2MR+?=
 =?us-ascii?Q?nmVgsGYaLFknHOjEc2RHDc+C4oiCmrlOfWU3HWF2Wd/X39qYP6tz9hz/6L9V?=
 =?us-ascii?Q?VQnbxIvY3+r2WptZ5GDCUSXDQzt2i2MbaaaZeFRK5hZpYj4WmF58tmZARVlF?=
 =?us-ascii?Q?Quvh6WbFfeSgOGKNCMe1DCMSa4lFAX9ZkrD5bPOUhCHHRv7CoXj/+3fvyYyo?=
 =?us-ascii?Q?BlOtY7FkTbqXwhiPJq0qQI2YyYgcznzwjTyZOh2j1XD+Kpyjf3JfjRLG3Hdz?=
 =?us-ascii?Q?zcF6A//PMhSNMPjdjHHrI6K9f3wOwFBMDv2+t6UCQsfmsUJWbbD4cL/FTNX/?=
 =?us-ascii?Q?nApECvXyxl2a8kTkyqZyq8N62oRO3N1kGDbAVQZmBHPDJ6jqROSLJIOUx4V8?=
 =?us-ascii?Q?y07Zfi41LCLZYQNOLQdCI+fTWYLNl8PflOX+8Mb2y1kcHEwVy3KLeeHsXuBF?=
 =?us-ascii?Q?T1vceLrj28rx0DEZ+ln1Y1Roou6FejX+vu3C54cCnm1U/0G7TvUaSCp32tL3?=
 =?us-ascii?Q?5qoD7vu8gqobguuA076OjvVE0HYaDrxqYzKzRLWl290nSbJbhBIUqsHweRJy?=
 =?us-ascii?Q?mNTLHNBjyTWHfWzS6ESt/9ALCHJTbwnEJHi9tkgWqmIy9niIjry4KU/c/xw8?=
 =?us-ascii?Q?8KNjNdqzwNK4Zginue0PE0Fw6Bp31HXIePwA5A7TCt7GZcpoTDGj1Xbk9tej?=
 =?us-ascii?Q?kDvuU+9hwORSuq86zULgDy42BkqWgIZM4ighq9vXVHS5F+rTCCSEg7B6EILR?=
 =?us-ascii?Q?FVNzUMLoMadpeJUtZKx+XzqoytxXSblP19PzLusoE1b2BIKDKkHzP6LcX2m9?=
 =?us-ascii?Q?eExdBxZ0hUdLi8cgNMnCIHznjLIbkL6+kJJ7DBBewXscndtIApswbvV4eGPu?=
 =?us-ascii?Q?X5D76koc+QVh41HYUJLnwNzVsBNHIeknYnAIFNtAyUDvhDqfnjlybYiOGMSk?=
 =?us-ascii?Q?gkDarbOvfvbGmRUAeR/INjIIC7RwAdOK0gv2fVcoj810w+CMTMfAeImJeT5D?=
 =?us-ascii?Q?oIZRTb9jg9sKyOF3/TJoNNTftqKqXhaqC6b1ZrPOH/vJ34SasGsqTnYvcnh2?=
 =?us-ascii?Q?1bBTB/aX80wjPccoR9PHgVZV3jZz4GpkrqslBhsA66QaarrE5av6uU2VCDe7?=
 =?us-ascii?Q?RzzmJor6wUWpIW5laDlu8v53Rh3HB019acUQOVxkMfdq8P5+uEkkwaZ9Qg2p?=
 =?us-ascii?Q?1msReVusCD9hHYsdMpX3wNnkDCAMtlh3DUOB4kwDGMZch7vgLk+njih+Uqqr?=
 =?us-ascii?Q?woEveG8iGfZi+PU9w+ehqHz7xJAdvixorWEE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iW4zIui0QChAWBJ64k2M6lR6CI5sB6OcqUnW9780pe7HByz1JQfXcFtbhkiu?=
 =?us-ascii?Q?evrdX0TPDKm3dPOvUj7dhYUCVqTl0gErr76mge/8W51bHcj+xTZxzMvtQ0/f?=
 =?us-ascii?Q?/7A/1XMHTftEWyfOzpGI27FxLE9lwUzUCvG+er4KoT0zf7O8+uQgtY/denDa?=
 =?us-ascii?Q?sCmF1jPoDo1jMuUjxpoJp8i64IrDGJJ0TFiPwm8Rp7Smxq0HZJds/LEe9ywA?=
 =?us-ascii?Q?2amdYIsyiA7Er1ge5DeFOa54iHnLxzTsj9Vyr5TLayLbUvI7/ivWiuBwkXJE?=
 =?us-ascii?Q?FBNSGBzg4L+wa4TuMkgEoodizd7Ywy+xgxn6j8Zh+JcHNzsHFCMiwWBardTq?=
 =?us-ascii?Q?GZVxpTKu/Woy3wR+Z3UHrvnCXFzVVyoRPtnQZFxHuX4xiGsGw8HpIoB50Twe?=
 =?us-ascii?Q?URAULCQMOvFFGOVJK7Jz7e9mPDUJL2M6eCWWeEMGnAxCBjWNt9vtBkc9XrNn?=
 =?us-ascii?Q?lhTo5WceWts3e+r6YoObm+R3MghL01A8Jo1rPl+i5LOr6dqD4YBYY5CiM2eX?=
 =?us-ascii?Q?hG4REP6kQ3jMr1y+m2lUflL4Is2bsQ6iPE9CkgxB1qfI38mG/3Jz5fo0WcZ7?=
 =?us-ascii?Q?fyYh+O/LrZ46YCEuM/gtYl8vgfWky9Dw31+OUuoHfmUdlzEej9FyGqxAB+ZA?=
 =?us-ascii?Q?nn4B0yVhsRvcd1Cnp8ht6/YDG0Q4UMe9Fl2PPChBzrhx+erl42wgqRgHq5ri?=
 =?us-ascii?Q?NhZLeSBK2SBCCKa/WGSclA1pV3+AupUItWls0U0TcyJ+f+nJ5186Cq42+4F/?=
 =?us-ascii?Q?Dmoe8qb6hrOeMfZrp+E5Q/GPvVQX/IeRCB+wAAacKNafsSJqDuhmW26AWulP?=
 =?us-ascii?Q?T0m77Cbt8yv95FfCbSh4mXSxqJg3WLCmCakmnp3Y5MdZeoGyxZgRqtyFoJrv?=
 =?us-ascii?Q?JcCSx4K45FpEmmntjVs9d6BCooR2MITxDhYhU67paD6w5jp63Dr24u61YgjN?=
 =?us-ascii?Q?aCP2USdHdWF14wvTNf9srgkBfaSV/kSdDnn+ER955/C/FnTiCq9ke81H+1Mh?=
 =?us-ascii?Q?4pLVwbPZYer4DeRIPZNQB2NFhqMhhRvOtUvKR0u9+HiX7xxUMWU8xyrHWtSv?=
 =?us-ascii?Q?81btlE/4Vqg8iyLrOCwvlHiYvNeyVb226Z+rPxEqVH5S/0ywqWJsnd1NdIVm?=
 =?us-ascii?Q?TSkmAwDJnk6mwQ5ggJvqBI7tNzeCgqBH7+oBQoYe5VEbDs7xiCFvgFCAQLPz?=
 =?us-ascii?Q?hmxU8qvvNNAEs/9J2xfLrx9omSdlhEzR4yCaPt7jkCh1zfKZU31KxrpOnyxc?=
 =?us-ascii?Q?CC3jjVMdLJ1ViTvKBx/LOQfQWKmrO/uRPStNhxBtRFx7oUf1Ai4VOP0WO1ae?=
 =?us-ascii?Q?PagUDSeo0Z+7LLANTRLbHOUrIVG6brcWTAlMcIjFLAbCMUcIbQSSNEc4c1Ol?=
 =?us-ascii?Q?EJL8wjL6rvdj4G4GcwVequKCT2/cLk2ypLj8WDY4ptqMEDKIIXgdZNfhbftd?=
 =?us-ascii?Q?voeZJLazr+EJyie97LCyNDbNVvFjRo0QV1/0U2P97plpHpjwPL06BG6dAI55?=
 =?us-ascii?Q?bjc01ZylKetUjW+nNcYI1aUvaMWl0uAjc5Qgwm0gZP+jXAH9Y7/n/cvM8fif?=
 =?us-ascii?Q?bEbrN24ZMwKY2kMCsu0pXHiveD2Bi3WSgNxCs23W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9944b369-4a73-4b04-5ad6-08de1cee04a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 04:36:13.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVXPmyCejBtYocYNmOyNBLKZvYRFW2WzGPz85WwNlgnVp//zfEBTgXOdeYYTLTpEhf2cJyNieR8d/Leg6QVmTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5848
X-Proofpoint-ORIG-GUID: VBqR6i8tb5w2GFu4V2VgPQqee1cpMDrq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAzNCBTYWx0ZWRfX8dK37W0XCNvS
 BZLQx6iLpH0BJv62k3/FYDJhQ/14EbjkU2qmpMHHuMLe8jtqg0FyO6F5s+DQUw5VHZTB2JalSTE
 Kqb8LxpCCwgbMPxlV/Kky0GO2TzGJgy3dnzBnhJM/f6zTlnRTN02HCIytThOAc1uen048WLuwFx
 8ckAd8L5WbR39yUyy3PB7gXWzmmvE1HxcJuit+amOxXGcVoXuUOrUSRneuPZZrQDmPf87QySW0T
 w/q1K+huGT1SCjQXxjY6mz8dv6EMzWKJmLVt28RVmG1AW66RSru4O429KKDB3ixe1YQju42MmzX
 86BiUZPG4c7VuBhoo9y4wdOpSPRMeWXbl7knraHsnBiNg8ic4y1hzRWVOVmEnBazy91POPqf597
 rjhQ4Cq9BWNEOVjAMwSkKCa2AQQqZg==
X-Proofpoint-GUID: VBqR6i8tb5w2GFu4V2VgPQqee1cpMDrq
X-Authority-Analysis: v=2.4 cv=d+34CBjE c=1 sm=1 tr=0 ts=690c25bf cx=c_pps
 a=kIIydkLLkU7OvItTzr+vAw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-OA1EraxXup9IkrxshYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01

Hi List,

Check patch is throwing below error. Could you help ?

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/=
ethernet/marvell/octeontx2/af/rvu.h
index 1692033b46b0..2345eb3474a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+
+int func(int (*arr)[2]);
+

+++++++++++++++++++++++++++++++++++++++++++++++++++++
#$ ./scripts/checkpatch.pl --strict ./0001-octeontx-af-Test-checkpatch.patc=
h
WARNING: function definition argument 'int' should also have an identifier =
name
#22: FILE: drivers/net/ethernet/marvell/octeontx2/af/rvu.h:1161:
+int func(int (*arr)[2]);

total: 0 errors, 1 warnings, 0 checks, 7 lines checked
++++++++++++++++++++++++++++++++++++++++++++++++++++++++


