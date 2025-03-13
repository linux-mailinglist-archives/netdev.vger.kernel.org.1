Return-Path: <netdev+bounces-174458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD546A5ED15
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 08:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6001D1899984
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 07:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9025F98D;
	Thu, 13 Mar 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jRwwNX/Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C513BC3F;
	Thu, 13 Mar 2025 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851301; cv=fail; b=W8jiZ+dRgkqlXuKlzwkaaJa3xDPwkG+WZ+5QBG455GvAk70ilByZmSqTNDOr6DLIKy1OOvw74tTiJr5CFiL0XtQBmYgz+j9kcKM1iv4ziZNl1IVAFyfolOogXP3K9clAXmR2vRIkGwCvaiaEf8yJ+aS+MSFmf8DqcuSP9T9p00I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851301; c=relaxed/simple;
	bh=Tu3nZ8VEd2OOTPtofvHZtW4VUsS8H5m6AS/2CiFzen0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agiTCfLZvbupXMQan+TCOf84OvyFQ39m9Kh5l/0tuHA+TorOxPREFeE/N0uqptL2/6bvsyRYkE8GOTtKkNJq/IKpFh7t+8tZqxpl7PUaJu58RlY6vYy/H81xhujV3YIqsCvHJXWwZyN/6qGsAnlhttRJ8NEuG9RsZyoutn1WzRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jRwwNX/Z; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbghmJaQ/cMJjwzCcclISy0aa0LqV8lC1UM6SR3WpL5Zja2kG4jK52efEpk5O+5ql3RU/gQoD8VFHK8i/X6PtSYsiLyHtSgp/Y/qcOEvw6WSE1lnRbRg4H1p4gy66v7C79bpaQB3RWgAuZak3po+oiV3DN5t5LgrqoXHEMJs7iV8KQ8yj0MO0181NDg7D7y68V6QGCZSnLV1Su4io0Dec1Ia6B6pnmDyTyCzcGin90H6GeURPhhE7eS/bQjlEgCsqMdw6omJpr+lG/E0ZnCUUjE17bguCSxoxRydDETk4gPOVXKV2RA6sJAkvvpcLFnW+avAy7KXlvt/ncdjQ13qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKh8G+LwBkJ3MIk4e3k+H4mcCK2kqqjrk6p1SaoabOk=;
 b=a7qrWqq1Yl9WsrXqn7EucZTl2ZouptkjrY+xyDdSY66sNSqnuvlmtodUnj3hyKwMPDOqShGuM0EMp+o03xgAbqXON0PePuItiSvoVHAUlSRHFmrxipv6hT48cboROzo/uOnCQFc5a2o9o5IxrENxaBTTaWIHOK5sk4KieFIpFl3J6PU6Kcvmxjnp/nyUwDrY02+QvY8RSjwmv34GBdgRNm0VGlQ/GSPxQ3J7qKQjXVDsJlJQmmcCO4GgeZac36xfUXdmqcYQ0+egJe05FWavT1a5i1LzE+R4wp/hzVsY6b56GGTWxNJhSToVBiOAzdu9sHkoFciFdAu6LRmge000CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKh8G+LwBkJ3MIk4e3k+H4mcCK2kqqjrk6p1SaoabOk=;
 b=jRwwNX/ZR9d0QSvm5S3qfKPVVRs9tHh9ECJA+bPRMIThIC0wWZq6oEy1GK4QSLS/YMM2CjDF1kHWCGeGNC6I1diPHMsvJ3QtxRD+3oQjSfmFwiSgbDpwocVGSV4KApUPhib2TvrutrlTbq/JJI3LGXQ6tZ4hFdnuaMH+uc0vgcI=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 07:34:56 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 07:34:55 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Topic: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Thread-Index:
 AQHbkzTKsOmRASZLiU2r8QNuR6Yh/7NvfgWAgAANigCAAAd4EIAABRmAgAABiVCAAAgAAIAABycAgAA+CwCAACn9gIAAU7+QgABF/4A=
Date: Thu, 13 Mar 2025 07:34:55 +0000
Message-ID:
 <BL3PR12MB6571DF7CBA49AF626ABDA382C9D32@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
 <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
 <Z9GWokRDzEYwJmBz@shell.armlinux.org.uk>
 <BL3PR12MB6571795DA783FD05189AD74BC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <34ed11e7-b287-45c6-8ff4-4a5506b79d17@lunn.ch>
 <BL3PR12MB6571540090EE54AC9743E17EC9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <fd686050-e794-4b2f-bfb8-3a0769abb506@lunn.ch>
 <BL3PR12MB6571959081FC8DDC5D509560C9D02@BL3PR12MB6571.namprd12.prod.outlook.com>
 <Z9HjOAnpNkmZcoeo@shell.armlinux.org.uk>
 <186bf47a-04af-4bfb-a6d3-118b844c9ba8@lunn.ch>
 <BL3PR12MB6571E707DC09A31A553CB1BCC9D32@BL3PR12MB6571.namprd12.prod.outlook.com>
In-Reply-To:
 <BL3PR12MB6571E707DC09A31A553CB1BCC9D32@BL3PR12MB6571.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e9a92bdb-0a75-44e4-aef5-e2da97db286f;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T03:10:41Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DS7PR12MB6262:EE_
x-ms-office365-filtering-correlation-id: 4b410aaa-b8fe-4629-3ccc-08dd62018d25
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mx8oadVTsKIpNFepZ5JKd/BbWnbhSD9a+2C1JHiBjFEHoaCDgOx63Wj5QjA9?=
 =?us-ascii?Q?NtgvLO3K2TL7F2u1OkZXN67EbZ2sChjucArPHYKTYZaLxuReTChmGDnmeqEk?=
 =?us-ascii?Q?A3V7D9U5F13pmtYvhsKsS4yeG7tbJLobTuAay/5C+Ijg8PtP6Oxg3u7DC6vQ?=
 =?us-ascii?Q?wbU64fBiqIHD19iUVH8dCcksRt5rxGcy7dvFwSj6nKxQmHIgJbwX+hPW7m0s?=
 =?us-ascii?Q?0q9EGV8xO7RohoCWDlCLy48RpqE4/0Sz65rKxdBjcy9HIejBCIMm9wvEDd7s?=
 =?us-ascii?Q?fpMN3I37jF1qxm4Klsjooc5A3f4ErHA3dSD0g1PBq7Ba/r33WZo153NMmOuz?=
 =?us-ascii?Q?WTAYLN4fsov40Xlj9eprZ75oOVBDeCGct0V1xY0n0zSt2tzO8ZRSKIKtGqAt?=
 =?us-ascii?Q?l6a+guAinAydH+n3j094Y+PHskiydsqpcLEcYjgxOQxkyVleGfx7QOASVJgo?=
 =?us-ascii?Q?lzTLv2fhVhVEpAXGYZB2EoVglhE/7mxKi9baMEEOudJNgkaxuzUBTh4i2cDs?=
 =?us-ascii?Q?h6/RsriO0m6HC51d0oyzbj5dW73A3+AnxLNCVBNd13skDFgXElVBBF8egMbn?=
 =?us-ascii?Q?jby+RlubwSkH/8wfiYnLwSSoBEgoxxh+abeOtGji9oiuTAMvEPBeBBqeRAfL?=
 =?us-ascii?Q?2bx0fSo5SwGFJwGcE/NGYFkVXHluOjeSkPJiphb49H/vwxLORdE4YkWyhicg?=
 =?us-ascii?Q?B1Adbq22JgwWMpoGzJkd4tBU9/EL1hGLad/MaLGzmwdEjSbIlQY73yQBkT7Z?=
 =?us-ascii?Q?HkVQ9szN5lCGylG+0G/Whynl//fWACG5fXqog/oqtv5xl7m5GZewqyTftQHp?=
 =?us-ascii?Q?h/rxWWy4tLTDYgkAs9R61YiK3QKGGDMJz0dZcvQTXxax8a7Yz5ou1iA7s7Dr?=
 =?us-ascii?Q?SQ05/i7Bo4HDfvAIYc5zpifnp5wPxQPDMndI0oXtVi9+KGme4dR2bbGHBaJ9?=
 =?us-ascii?Q?DZIgqDyAylxKyMxUdkCplYgBGkq828fLxdLaCePiWYp3dJIrHsrUXpMxgI0/?=
 =?us-ascii?Q?aN0zoIkGGHmUyHZoj5LDV2ibZOE1DTBlY2R7bsARIte/QB56yktKulTF3dfx?=
 =?us-ascii?Q?bYMX6tgGTx0Ov8K8W8hDIteDvo1VOhASz+gxIv2y2hrnIMd9Jy92exhtWrEj?=
 =?us-ascii?Q?1mNdo9bJLHCixPg1Vdr4vqJ8skuXAG8R6R5u6YNMkUghzsP7MnDm/HdjAxr/?=
 =?us-ascii?Q?ckmxuI/yeFTLjajPXP8Yu+O22XngfrAsSJmxsQACfVxGmUtEB9nqS3YWQH8D?=
 =?us-ascii?Q?J7NArJRslgBpEhXczNtPYEw7Abss55tr+THSedv19/1+P547Nx+6QM0adeCg?=
 =?us-ascii?Q?ezMwTMXOkTHplCb1AMqXdBeZvlTEOeu8nY3nSofZZv3yal+6GF3ylLy6bnO0?=
 =?us-ascii?Q?jnutuY+x4alzmm/T7gS/hZC7y+IydNoOkTA+FcZwYdV6fUe6zHoq9tV2uDJI?=
 =?us-ascii?Q?EP015eyFlKQoPVvmqMp8qqTKtO74L4hx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d8JApem87uwt76d8Mqk90WOHJXsMJzLbTF/L8SNQx/3ToEQGIe14e7nad5qF?=
 =?us-ascii?Q?vD2J9uP3jYOdfTn/FKlOZ0DtrnCDLETfVgbVDC06CHSVCXL38V7DEEshc2KP?=
 =?us-ascii?Q?ZatZbiaQt2w7NL6zTrWp8rjTsyQAgWYUejOdCGhDHseQ5AQgYkeLFvEAaLhR?=
 =?us-ascii?Q?6UCqSHYnRPBdUWEmGW2Cd48m0becD2ME9/qMIWzevsOKXWaqaKBwu/W3YpTn?=
 =?us-ascii?Q?rXjtebvasgo3VtgtEO+tHjnzVdLQMNHIYMCdwuu83DUBU0jKsPj/E11I/RFK?=
 =?us-ascii?Q?JBjO92oQ4JJIBaQunNX0yS2uZLvA2FuMz7zZMyXH3U7XXsypkxroi1gstNrY?=
 =?us-ascii?Q?se7fUkxo++0Fc/fRij5qJax/U0aNBzktCMbRBAipKjltTuEb5HCZntjRACiX?=
 =?us-ascii?Q?4d7AMdUUfXo/CgZsg2lpi4h83nqpteNDoAN7Nv+R0guWdbWx9H6yg+Joozfv?=
 =?us-ascii?Q?8W+Ss53mMntNCYllJ/+do6utbpGlHJ4oRPCSSw4h1CYcX/rlMDqe7S5JA8yz?=
 =?us-ascii?Q?zgjxIOfc9I8O4yhEVXrN84SaRnM/SMnfCQHhiuxUCCDQHR/VP3i8/+4wXXYf?=
 =?us-ascii?Q?n6GqYKNEzsZQVm7poCewOoHHrPrNmcMUGF0kMGGY5mVCSAIqY181SBlAINrs?=
 =?us-ascii?Q?RymRIUL+Af51S6yqkquhg2rUhosGnaDVEW8W7qbz2VdK4iIPNRGiEcfe90BD?=
 =?us-ascii?Q?DH5NKfAy2NdoP2Myj9hULepAh7nKk6vyTa6oeSsb3LH6OFyu+sGwdUdR1u7h?=
 =?us-ascii?Q?/Y/Ca+PJvIll9HrwcaqRUyNFaF7mXVoziMt3yveXvEcrRNjDfVgTyxiSqRUO?=
 =?us-ascii?Q?CD9bp3ARq16cEvJa3JL0i5OssjS+0r18pdlLhR6Pb+sPtKjHgbXY8IU0KqEt?=
 =?us-ascii?Q?QmrfTtahv4D5//Wxz8/d5nJTTk8o4A/2iPoFK2C6hqI19ZIR/4tmO0wLd/cy?=
 =?us-ascii?Q?kUmAcYPVj3ipTcS20kC5axaAkfit/DF723dGNvTNM/m/KG36PHwgFDkBXsoI?=
 =?us-ascii?Q?lGbKdQauUFKucaIpb7vQN7JccjaoX2b9w0LtqRJACV1rOH5SVs8sz+lcY97E?=
 =?us-ascii?Q?wuopIr+EBDz8+4vBrNhhoFVgNkCRpMFRNT/PTLJnOlqnK8B3KGUnRW6logxE?=
 =?us-ascii?Q?EjNIBgWXHBDcVuk6cxgBNX8ofZ8AaH1DxP7RCdCexml+RRL9XQTJCdRmpVMP?=
 =?us-ascii?Q?Wqx8yJS72qGyg93/xnV9Bq41JSPWWbS+XFOm4kNXMaUJVzaRx+UEBRShRMEr?=
 =?us-ascii?Q?0/0L+5F9nt4P97S8vLTxhAQeFGubD1T7g9PTdcihUWh0W378hMjT7IItbvUg?=
 =?us-ascii?Q?VVDBDVVxNphiK+mDkCqOoRguLiEd6tJN3pTHbWDEn1Cv95M+78pYgRpvDA98?=
 =?us-ascii?Q?VFW7gzMYxOaM3LKFt/VcKt/9rWvLNjIwGzrxjLJSLsHmpAZ7NZYCnrgyqWHq?=
 =?us-ascii?Q?b6EFK+I2W1Hbe1ZfWZuRcMRM6Jcefe9FmMpc4D9St6AWNtDEUAsZlPVVxrvt?=
 =?us-ascii?Q?MzHJrWxqd2JI3I5ifK3BvW5pTSIHF4zTEwrAnaTzzUDNKhGzwWy0Z2cGyNYy?=
 =?us-ascii?Q?GPfAb5pGNUSXOyZdLik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b410aaa-b8fe-4629-3ccc-08dd62018d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 07:34:55.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNmM7JlRoT2o5bRB/ONgftJ76CYGbDAuo1RefRr52YbXi/CW+TGpI1fxMKWvt9pXl7m09nVAQN4QKa63YYDTuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Gupta, Suraj
> Sent: Thursday, March 13, 2025 9:01 AM
> To: Andrew Lunn <andrew@lunn.ch>; Russell King (Oracle)
> <linux@armlinux.org.uk>
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.ker=
nel.org;
> linux-arm-kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>; Kat=
akam,
> Harini <harini.katakam@amd.com>
> Subject: RE: [PATCH net-next V2 2/2] net: axienet: Add support for 2500ba=
se-X only
> configuration.
>
>
>
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Thursday, March 13, 2025 3:41 AM
> > To: Russell King (Oracle) <linux@armlinux.org.uk>
> > Cc: Gupta, Suraj <Suraj.Gupta2@amd.com>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> > netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > git (AMD-Xilinx) <git@amd.com>; Katakam, Harini
> > <harini.katakam@amd.com>
> > Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for
> > 2500base-X only configuration.
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > > This is not an approach that works with the Linux kernel, sorry.
> > >
> > > What we have today is a driver that works for people's hardware -
> > > and we don't know what the capabilities of that hardware is.
> > >
> > > If there's hardware out there today which has XAE_ABILITY_2_5G set,
> > > but defaults to <=3D1G mode, this will work with the current driver.
> > > However, with your patch applied, it stops working because instead
> > > of the driver indicating MAC_10FD | MAC_100FD | MAC_1000FD, it only
> > > indicates MAC_2500FD. If this happens, it will regress users setups,
> > > and that is something we try not to do.
> > >
> > > Saying "someone else needs to add the code for their FPGA logic"
> > > misses the point - there may not be "someone else" to do that, which
> > > means the only option is to revert your change if it were merged.
> > > That in itself can cause its own user regressions because obviously
> > > stuff that works with this patch stops working.
> > >
> > > This is why we're being cautious, and given your responses, it's not
> > > making Andrew or myself feel that there's a reasonable approach
> > > being taken here.
> > >
> > > >From everything you have said, I am getting the feeling that using
> > > XAE_ABILITY_2_5G to decide which of (1) or (2) is supported is just
> > > wrong. Given that we're talking about an implementation that has
> > > been synthesized at 2.5G and can't operate slower, maybe there's
> > > some way that could be created to specify that in DT?
> > >
> > > e.g. (and I'm sure the DT folk aren't going to like it)...
> > >
> > >       xlnx,axi-ethernet-X.YY.Z-2.5G
> > >
> > > (where X.YY.Z is the version) for implementations that can _only_ do
> > > 2.5G, and leave all other implementations only doing 1G and below.
> > >
> > > Or maybe some DT property. Or something else.
> >
> > Given that AMD has been talking about an FPGA, not silicon, i actually
> > think it would be best to change the IP to explicitly enumerate how it
> > has been synthesised. Make use of some register bits which currently
> > read as 0. Current IP would then remain as 1000BaseX/SGMII,
> > independent of how they have been synthesised. Newer versions of the
> > IP will then set the bits if they have been synthesised as 2) or 3),
> > and the driver can then enable that capability, without breaking
> > current generation systems. Plus there needs to be big fat warning for
> > anybody upgrading to the latest version of the IP for bug fixes to ensu=
re they
> correctly set the synthesis options because it now actually matters.
> >
> >          Andrew
>
> Synthesis options I mentioned in comment might sound confusing, let me cl=
ear it up.
> Actual synthesis options (as seen from configuration UI) IP provides are =
(1) and (2).
> When a user selects (2), IP comes with default 2.5G but also contains 1G
> capabilities which can be enabled and work with by adding switching FPGA =
logic
> (that makes it (3)).
>
> So, in short  if a user selects (1): It's <=3D1G only.
> If it selects (2): It's 2.5G only but can be made (3) by FPGA logic chang=
es. So
> whatever existing systems for (3) would be working at default (2).
>
> This is the reason we didn't described (3) in V1 series as that is not pr=
ovided by IP
> but can be synthesized after FPGA changes.
> Hope I'm able to answer your questions.
>

I understand your concerns that current solution might break if any existin=
g system uses (3).

Russel's suggestion to use DT compatible we can try to send as RFC and chec=
k if that is accepted by DT maintainers.
Andrew's suggestion is complete IP solution and will involve IP changes to =
correct ability register behaviour based on synthesis time selection in a n=
ew IP version. But this will need internal discussions and IP rework and mi=
ght take few months.

Please let me know your thoughts on it.

