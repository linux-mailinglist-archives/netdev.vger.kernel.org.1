Return-Path: <netdev+bounces-136004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895E99FEDA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5418B24951
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D115B130;
	Wed, 16 Oct 2024 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6WfmCUz"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2614AD17
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046061; cv=fail; b=kGqntsafRRKXggoVbIgx6VXcMGQO1AnRjFPy17+hsc4TRXhSTejkKt9oqAdkdIL4kaBzAJ5VZbyM1XxtKz0tXqS2yCnGQdtvOE66usuI66QZ7A1dWwfJ3+VDNnKCzwyV+Sx4h2w5Kcjjqt6fY33PtTphitbPGwdJ6cubDI7SSWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046061; c=relaxed/simple;
	bh=FPGFa1AIvPd4kUXcovOg+6ciOC0w/ELRYWo+WRmojG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5FFvaxY9y9VeFtGxxYyOG9Epx/2UyKOJpZGbP/wuV+rNgrbvsM1bleUpzUgTTtceWU9z+g+mUiWIvURXyj1893Npm+enepNFgwr5H7zzPZvfIt/vQf4s+ro8Qfiv/FOg3HjHD3jUrH71i1ESnBdKbI0qh672As34Kej/apWGHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6WfmCUz; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9ats6T0hxY6k17OLJAWHhZiJjkolfPQw76xSylwrbWW8f3CxCY3OiFHBvDTxAiu2jK5gt5fFjdE+kV/QRszR4QvFqI+oeCWXQHUq+Uw3Lg/72Z5d7vnPG8Cfn7MpWuG/cZo2HivtxInWHx59dQX5mWzh1ch4d5K+bRJ8GUc7lrABIIXNFB0kscdvHyPvITWhLZ/zmyAsTElqHOuveWNFnjWj0/Q2YYywekw3Ha+gUvdLr11RzysvuElxOxSLeUm2c8Qnjao5qa7WXQiZNa77w7VaDgtAxebICmTIar2WGSvw0iC0TDMcqjnHyIO8WvmxGkSoM6Aup6Yt/70xIcD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPGFa1AIvPd4kUXcovOg+6ciOC0w/ELRYWo+WRmojG8=;
 b=BpEi3ekW4amCqCa/0RyyZY2dwtJgYf+LcOAyDIXdvzWprHbp3vefVoTKe/D323UsT1EY3fp3kCBl5x4GkZsXuvtbB25ZGjU8mKzuCx6DdGk0K+UJOB/POjjW4Rfm/9nQhftsnRW/jVuRizuduusbU2W6gGXySad3YEy2ooGW+ZYcmtlomnufXaOGZ1eyDHx0tlL8EiR+i8tC6U0gNUHCUV/8tdm8emGD4DcCFVL/AvxdNIHDbfmlVpFng3qjS0yo/hZDicM87pAt2XudkUcNQQoB3+B+3CqcK06VENJ4TKxYvvFNqj11hX99vT3xm8OEOc4qqTaO4F9lTu3+tP7dqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPGFa1AIvPd4kUXcovOg+6ciOC0w/ELRYWo+WRmojG8=;
 b=a6WfmCUzvE7dlH6RNC78YmDVQUZ6KDuJuSLdtSLpPFr4vr9SsDKzh+Q1b35mTxkDxFzwwA27rGOdbH2IAekoR+f4BBM1HHeKHyKk7oYkgta7b/GcChFPscqdMKZzSiIv3qXaihdVi0zLIc+KYFwhNESRCoxPewhHDq7Law/Q0gqAief0Qeya+84LpOv5y4FgbSxAn0GofeuEFiHrEz3BtmPSnzvkCm9Urp8XIlT2UwkAtqGr6cfDLFd0W+5AplaLZNxHgeewIjJM1QCHaW20iH+TOPuRbrPLWLZUe5P2u2iJO/mjHjmIafKjEMFBb7k04tJfrnrPDRkO0YYaMsTseQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8873.eurprd04.prod.outlook.com (2603:10a6:20b:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 02:34:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 02:34:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Joe Damato <jdamato@fastly.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: RE: [PATCH v2 net-next resent] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
Thread-Topic: [PATCH v2 net-next resent] net: fec: Enable SOC specific
 rx-usecs coalescence default setting
Thread-Index: AQHa4e6Gyy/7BMfA8ES2MU+vtS4jLLIPD2OAgAJ3LACAd5f+YA==
Date: Wed, 16 Oct 2024 02:34:14 +0000
Message-ID:
 <PAXPR04MB8510C1030E70335B283B4ACE88462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240729193527.376077-1-shenwei.wang@nxp.com>
 <Zqi9oRGbTGDUfjhi@LQ3V64L9R2> <ada2c1b3-08b7-498f-91d5-3d5c1c88e042@lunn.ch>
In-Reply-To: <ada2c1b3-08b7-498f-91d5-3d5c1c88e042@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8873:EE_
x-ms-office365-filtering-correlation-id: 660455eb-e328-4a98-f509-08dced8b06b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?bUNlbFNCaHYzTmtQdFIrYXRzN2RCeVZQNllDdGJvR00yZ3NXWU1RbldCUDEx?=
 =?gb2312?B?MjJZaEs4bHd5MHp2dHg2ME1QUFdQdUZXNDBHQzR4ZFhGeCtRS21MMDN0S0xD?=
 =?gb2312?B?dVJJamRuZ28raHdiR3h3Wm00UGlra3lYZlUzSG0vUldNYTcvOCt6S3N4cDJt?=
 =?gb2312?B?OWJwOTl3NW8wa1NIejI0Vzc5MjNFY0FoMHJTRmpRM1FqK2tTbm1ubGpnVnVq?=
 =?gb2312?B?aDVoWW9UWWl2ZGUwMGNXVkM3YTY3RUhXODZtdDVSZ2VRbGt5b2R6WW9Fb1FJ?=
 =?gb2312?B?RjVaVHUvdjdWUmlrYVpvSlFSRDF4NS80MndiYzcxMzFGSWxOQlVUT083VEdn?=
 =?gb2312?B?cjhvcVFlMEw0RzMycnh6a21MbjI4UjRuN0N0SkRhUXBwUTZRaitlcEVFb2Rq?=
 =?gb2312?B?Q3dVckxmZjVjRk9yS1ptUDhUdElDUDFneHpXdHd0OGMrNG9UTmIzTlBFMmI0?=
 =?gb2312?B?NGE5dTdjY2JFRVN1YVZ5ODY0a3RwNzk2TFVENm01VjN1VVhuSDVuSHFuaWEv?=
 =?gb2312?B?cGhnVnl6SzdHa0lFM1NvNUlhTDNCYVIzQVV3N0l1SXZYUi8wTEtCbzVRY1Ns?=
 =?gb2312?B?YjlQY3JMNm9ZTFV5MXloUERrOHZacmhWWVBTNzFYOXJnTXh5VG5Bd3dUTEVo?=
 =?gb2312?B?UUl2UlhBRGFZVHB5ZmREZDNTbk1xemlVeHRBWFRsZlJTTHJoeUJIUW5qZUxS?=
 =?gb2312?B?N040dTRDYmhscW9Gam9Ud0twelhSTkhNcGdIMytNNmViakJ0SmEvbXY3QjVp?=
 =?gb2312?B?MXNzV1FLNkNpWEFEQ2hyOG4vMWdEOENyc0N0QXQyd0lXOGhEOEFCL0pDOU91?=
 =?gb2312?B?MnlvTnE5dWZWRDNoenFEOGFqMVlDZGRHNVZSRERYaHZuakZYVFNma0V3S1B5?=
 =?gb2312?B?U3dBVUdrcTJCV1R1WW1QVW9aZEhlUThqZURVQ0UxZWhTK1d1emxoS21FOHJR?=
 =?gb2312?B?cWpPdlNWNzBneUlpeklUYUhrbjZLUEF0cDJ0MTNibFlQTk5BZ0E0TTdlaWd2?=
 =?gb2312?B?QjlEOUpGbWZIVW4xNERkS0NDL2MxODhybGJ1VEdSVWNKbG1UbkE0aHVMKzVO?=
 =?gb2312?B?aTJ3YmFnYmF2dndQcFRrRENOYi9FdFNhWW05RjJmK2VYenljc0luVTRGdHVz?=
 =?gb2312?B?NmhqQVdPdkF4SGwrd2tZNUJNZFlOR2dkSUluWkpOc05IS3ZPQ2ZzTng5d2R6?=
 =?gb2312?B?cVVLKzR0WWI4d1F4WDRMTllNRkFLQVFFRGk0MXdwSVd1ZnFzY08rR1IzT0VR?=
 =?gb2312?B?VHFoSUJXbzNXeEhNSkx4cEMrV1QyVDl4RlllOC96VjdreUpzVTAwcm9ldFZk?=
 =?gb2312?B?M3MzSDBpZkQyZHJGdVRBdDNBQy80Vko0c2JORlYwcC9zMWFlV3JlQ1lKY0E2?=
 =?gb2312?B?OWU4THhHRTlvSFdjSlAzVXZGTUNSRGdpTDhjVDZOMGJzWEoxV21sS2JMYlE0?=
 =?gb2312?B?UW5qcjFRdGdvcTlWNmNXUDdTaXVNbVlOTnRxREdmWXoyd0JkMXdJbHJKbDZu?=
 =?gb2312?B?U1pJOW14Y0FObUZyUGh4RHM1SUZtdWtKdTI0M2FTeU80a1dDSWkwM25nZTVW?=
 =?gb2312?B?UlFnSVdlMlRDbkE2KzRuUnk0dXIxbkdBZy95bnVaZ0lyTGFrQzhrZW9mYWc2?=
 =?gb2312?B?TTBnQnUvdjBFWXVlVE03MHNEOXd0T1JyQnBycXRFbmdoYkY2bmJzQ2FxVFRN?=
 =?gb2312?B?WmNQaWY3Y0VBZVhqSXRjb3oveWZsQlp6c3g5OU15SlYrQlkva2hUVitwUzdz?=
 =?gb2312?B?bTVnVnRPcGV2ODRsOURDWGcwV1BrWVNTSTlZVm9WMmEwZlpYaWJWV0lBTm04?=
 =?gb2312?B?d3AzemVrTS9nSVVJZ2ViZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WFVsODFnZFZLbFJTcEJSbjJPb3JBUmpxa0JFa1czdDlFbnJwVGhrV3VpTUJT?=
 =?gb2312?B?YkxNZ25kOExEbVpvZE5HM2gvdGIvRDRpaTN6T2ZhN3h5VThxc1V2QVJ2WXhJ?=
 =?gb2312?B?MFNacFJ3S2NLN1I3WGFTTzNudEV3UUFvZXd4bFVsNXRYYlQ5bVRGbTVpem1X?=
 =?gb2312?B?Y01EM2lSL1FCbG9NK1lRVDlWWTl5Y2MyejM4T0dldVBCc0FvcHlDYlVOU3Zn?=
 =?gb2312?B?NWk3NEE1djFJVEs3WFRFQkJvSDRRS2toc3lET0hxdk5lRGZyWjZuZXlXMUJL?=
 =?gb2312?B?WVphMnEvYVZrcWtPNUJOTXQyL1pWL1Jsc3BXa1ozT2RydEFUV1U1d3JBLzh5?=
 =?gb2312?B?dDlqNTRRMWNNSU81Q1psQUJ4RG5vdVBsOEpQdUhuR1JWVHdvVytkdS9NbjVj?=
 =?gb2312?B?dmtlZ09RZzlyQ25MaXhzVzB6eTBWVnhLUzB0T1JlQmhicWt4NTJmU29Kb2Qr?=
 =?gb2312?B?RFpDWFRYb3lPS1psTHBUSWFyb0ZxSkhCSHBoekJVT0lsZ29JRjJPNFNaYkZN?=
 =?gb2312?B?RTRyQlFSR2ZZSEwxTmdJM2ZWT2lkWU9EaVNra2gvTEl1RktTc3lXMnpqN3pv?=
 =?gb2312?B?dHZHaFVpajdkazM2Qnl0ZnhaVytEcnpWZTEyMDArRm15enU4S2t3M3lpNWY3?=
 =?gb2312?B?bUxzTE9hNjQvaCtSTlcrRUxMOU9IWVlvMFZMOWZSNmJGeUFiR2xYNmxsOUJC?=
 =?gb2312?B?dk1tY3FwS1VTcm92VDZPM2R6T1FIQlJLTTNyVCt2ek0reEd4dmdaQ1BlekxT?=
 =?gb2312?B?VFZPL09rdW1BdG9UQ1QwdjAxL0hJUVA0TXhZdXo5V25IbXdKRGRZTy9XU2tY?=
 =?gb2312?B?SWJJN0JhQmxOK0FHYlpTTkVWRFR5MkczMTlzRENiR1B2SG1hMHkxYWROa3NW?=
 =?gb2312?B?TGxvZTFQMVNrKzNOYjlkOU1pWXRNNG4xUlFXbTIzVVlpZlh6UjNxQXZlNnl6?=
 =?gb2312?B?Tld1cTBPNGhkaVBCdGpKK2NHckNGbEMvMDNxdnZzdGdVWHNZN1BaVlhrTlNO?=
 =?gb2312?B?Rms5Zko2SXlCSGVpWkdnbUNncWRnNlFtNGEvWUdUOUZMNGYxOEFHeVpNNm9z?=
 =?gb2312?B?QXQyUHpwMW9kUXc5VWg0bGdGdUNjdThNWFA3UEVUYUhvNzNWb3lsZUk2NVBT?=
 =?gb2312?B?S2crRHVnLzFRVXN5dnJ0bWpwdThiT1JidzRuMW5DSW11aUJxRGdoRFpwMVg4?=
 =?gb2312?B?YU94VmRLMFVpVFlqa2xvVk1kYkI5Y2dqZERaeXYwNFpuTDhZQXh2bDVLSjBZ?=
 =?gb2312?B?alczWmpXb25uRno5LzBVVUFwNXFPd0krRm9wOHM4NzlIN3ZUOUxzTmsrejBs?=
 =?gb2312?B?WDBKTUJDK1JoaGhBQ1l4WkR5d0sydGtyWm1Td0l4RmFicnY3Q2l1dTByb2Fz?=
 =?gb2312?B?Z3lLWk9HbkJzSE8wY1YzUnM3aE91VC9jdFdldUtZUjY3Ylk1NmtHeCtsQnhG?=
 =?gb2312?B?eGZGWEZrUSthaGp3WmVaMWZBVXdQZFFLeFNJdFlYTzBFRnYvN0VObHN5cm93?=
 =?gb2312?B?ejBGcFQ4RmJqczVkUm1hL3RWN0dEcXk0RXZOSGM3UEhJN1gyWHNWYW52QnhW?=
 =?gb2312?B?K0ZWaXY1cnN4QjBSQks0c1hQNTVPalJtSW1GOXVqYW5OR3NiWHNNb0N1a0hE?=
 =?gb2312?B?L0JtNlpZdTl4OFducHRORDNWdzk4ZzZmeVIxeFR6SHFuaEhQaituV0U0QXF1?=
 =?gb2312?B?UmZHQ0RsSTBqek5BOWtrZ3d5WVBXZklvNkZVcnNCaFRHUU5RQW5aK1h6SEIw?=
 =?gb2312?B?R1ZrUVY2NWhMRkovTnI0UjNTdEdJM05BYVlLOXVrelZzQUVLSFdCNzZrdjBl?=
 =?gb2312?B?UElxS2l1d0ZyQVp1OStRQ1JoWUhjeHk4bitvYjBYMzgvT25sMjVNbHNJVXN2?=
 =?gb2312?B?R2ZEbmgxbFdQb2M5ajdueFhVMjhrZ1N0dlJnZ0w5WWtZSHFmajdCcytNd3Yx?=
 =?gb2312?B?bzZQUk5uTWgzYUZmSHdvM3Vkb21yRFgxc0xLdzAvN3ZqcUVzbWFIOFJtYXk5?=
 =?gb2312?B?UVpwY2NqVVJMZ0FBTXBUSGlBSGhWcXltT1UzVkpFanNiMEdQM2JSZFNGWlVO?=
 =?gb2312?B?bkpONjNMaWRkcE5vanQwT3JWZXU1RTA1WTI4WnowcjVSTnBjaGZjdzRUbDA5?=
 =?gb2312?Q?Lus4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660455eb-e328-4a98-f509-08dced8b06b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:34:14.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DU3cU6KKVpntSli5qoMNshSsM2GWRLHnAw8JYs26uvx/D2E84Z03orcPl77ZEDxo+xeNcEeVhL+qEYAxB2pQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8873

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jjUwjHI1SA3OjU2DQo+IFRvOiBKb2UgRGFtYXRvIDxq
ZGFtYXRvQGZhc3RseS5jb20+OyBTaGVud2VpIFdhbmcNCj4gPHNoZW53ZWkud2FuZ0BueHAuY29t
PjsgV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+OyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1
Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRo
YXQuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgaW14QGxpc3Rz
LmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dCByZXNlbnRd
IG5ldDogZmVjOiBFbmFibGUgU09DIHNwZWNpZmljIHJ4LXVzZWNzDQo+IGNvYWxlc2NlbmNlIGRl
ZmF1bHQgc2V0dGluZw0KPiANCj4gT24gVHVlLCBKdWwgMzAsIDIwMjQgYXQgMTE6MTc6MDVBTSAr
MDEwMCwgSm9lIERhbWF0byB3cm90ZToNCj4gPiBPbiBNb24sIEp1bCAyOSwgMjAyNCBhdCAwMjoz
NToyN1BNIC0wNTAwLCBTaGVud2VpIFdhbmcgd3JvdGU6DQo+ID4gPiBUaGUgY3VycmVudCBGRUMg
ZHJpdmVyIHVzZXMgYSBzaW5nbGUgZGVmYXVsdCByeC11c2VjcyBjb2FsZXNjZW5jZSBzZXR0aW5n
DQo+ID4gPiBhY3Jvc3MgYWxsIFNvQ3MuIFRoaXMgYXBwcm9hY2ggbGVhZHMgdG8gc3Vib3B0aW1h
bCBsYXRlbmN5IG9uIG5ld2VyLCBoaWdoDQo+ID4gPiBwZXJmb3JtYW5jZSBTb0NzIHN1Y2ggYXMg
aS5NWDhRTSBhbmQgaS5NWDhNLg0KPiA+ID4NCj4gPiA+IEZvciBleGFtcGxlLCB0aGUgZm9sbG93
aW5nIGFyZSB0aGUgcGluZyByZXN1bHQgb24gYSBpLk1YOFFYUCBib2FyZDoNCj4gPiA+DQo+ID4g
PiAkIHBpbmcgMTkyLjE2OC4wLjE5NQ0KPiA+ID4gUElORyAxOTIuMTY4LjAuMTk1ICgxOTIuMTY4
LjAuMTk1KSA1Nig4NCkgYnl0ZXMgb2YgZGF0YS4NCj4gPiA+IDY0IGJ5dGVzIGZyb20gMTkyLjE2
OC4wLjE5NTogaWNtcF9zZXE9MSB0dGw9NjQgdGltZT0xLjMyIG1zDQo+ID4gPiA2NCBieXRlcyBm
cm9tIDE5Mi4xNjguMC4xOTU6IGljbXBfc2VxPTIgdHRsPTY0IHRpbWU9MS4zMSBtcw0KPiA+ID4g
NjQgYnl0ZXMgZnJvbSAxOTIuMTY4LjAuMTk1OiBpY21wX3NlcT0zIHR0bD02NCB0aW1lPTEuMzMg
bXMNCj4gPiA+IDY0IGJ5dGVzIGZyb20gMTkyLjE2OC4wLjE5NTogaWNtcF9zZXE9NCB0dGw9NjQg
dGltZT0xLjMzIG1zDQo+ID4gPg0KPiA+ID4gVGhlIGN1cnJlbnQgZGVmYXVsdCByeC11c2VjcyB2
YWx1ZSBvZiAxMDAwdXMgd2FzIG9yaWdpbmFsbHkgb3B0aW1pemVkIGZvcg0KPiA+ID4gQ1BVLWJv
dW5kIHN5c3RlbXMgbGlrZSBpLk1YMnggYW5kIGkuTVg2eC4gSG93ZXZlciwgZm9yIGkuTVg4IGFu
ZCBsYXRlcg0KPiA+ID4gZ2VuZXJhdGlvbnMsIENQVSBwZXJmb3JtYW5jZSBpcyBubyBsb25nZXIg
YSBsaW1pdGluZyBmYWN0b3IuIENvbnNlcXVlbnRseSwNCj4gPiA+IHRoZSByeC11c2VjcyB2YWx1
ZSBzaG91bGQgYmUgcmVkdWNlZCB0byBlbmhhbmNlIHJlY2VpdmUgbGF0ZW5jeS4NCj4gPiA+DQo+
ID4gPiBUaGUgZm9sbG93aW5nIGFyZSB0aGUgcGluZyByZXN1bHQgd2l0aCB0aGUgMTAwdXMgc2V0
dGluZzoNCj4gPiA+DQo+ID4gPiAkIHBpbmcgMTkyLjE2OC4wLjE5NQ0KPiA+ID4gUElORyAxOTIu
MTY4LjAuMTk1ICgxOTIuMTY4LjAuMTk1KSA1Nig4NCkgYnl0ZXMgb2YgZGF0YS4NCj4gPiA+IDY0
IGJ5dGVzIGZyb20gMTkyLjE2OC4wLjE5NTogaWNtcF9zZXE9MSB0dGw9NjQgdGltZT0wLjU1NCBt
cw0KPiA+ID4gNjQgYnl0ZXMgZnJvbSAxOTIuMTY4LjAuMTk1OiBpY21wX3NlcT0yIHR0bD02NCB0
aW1lPTAuNDk5IG1zDQo+ID4gPiA2NCBieXRlcyBmcm9tIDE5Mi4xNjguMC4xOTU6IGljbXBfc2Vx
PTMgdHRsPTY0IHRpbWU9MC41MDIgbXMNCj4gPiA+IDY0IGJ5dGVzIGZyb20gMTkyLjE2OC4wLjE5
NTogaWNtcF9zZXE9NCB0dGw9NjQgdGltZT0wLjQ4NiBtcw0KPiA+ID4NCj4gPiA+IFBlcmZvcm1h
bmNlIHRlc3RpbmcgdXNpbmcgaXBlcmYgcmV2ZWFsZWQgbm8gbm90aWNlYWJsZSBpbXBhY3Qgb24N
Cj4gPiA+IG5ldHdvcmsgdGhyb3VnaHB1dCBvciBDUFUgdXRpbGl6YXRpb24uDQo+ID4NCj4gPiBJ
J20gbm90IHN1cmUgdGhpcyBzaG9ydCBwYXJhZ3JhcGggYWRkcmVzc2VzIEFuZHJldydzIGNvbW1l
bnQ6DQo+ID4NCj4gPiAgIEhhdmUgeW91IGJlbmNobWFya2VkIENQVSB1c2FnZSB3aXRoIHRoaXMg
cGF0Y2gsIGZvciBhIHJhbmdlIG9mIHRyYWZmaWMNCj4gPiAgIGJhbmR3aWR0aHMgYW5kIGJ1cnN0
IHBhdHRlcm5zLiBIb3cgZG9lcyBpdCBkaWZmZXI/DQo+ID4NCj4gPiBNYXliZSB5b3UgY291bGQg
cHJvdmlkZSBtb3JlIGRldGFpbHMgb2YgdGhlIGlwZXJmIHRlc3RzIHlvdSByYW4/IEl0DQo+ID4g
c2VlbXMgb2RkIHRoYXQgQ1BVIHVzYWdlIGlzIHVuY2hhbmdlZC4NCj4gPg0KPiA+IElmIHRoZSBz
eXN0ZW0gaXMgbW9yZSByZWFjdGl2ZSAoZHVlIHRvIGxvd2VyIGNvYWxlc2NlIHNldHRpbmdzIGFu
ZA0KPiA+IElSUXMgZmlyaW5nIG1vcmUgb2Z0ZW4pLCB5b3UnZCBleHBlY3QgQ1BVIHVzYWdlIHRv
IGluY3JlYXNlLA0KPiA+IHdvdWxkbid0IHlvdT8NCj4gDQo+IEhpIEpvZQ0KPiANCj4gSXQgaXMg
bm90IGFzIHNpbXBsZSBhcyB0aGF0Lg0KPiANCj4gQ29uc2lkZXIgYSBWb0lQIHN5c3RlbSwgYSBD
SVNDTyBvciBTbm9tIHBob25lLiBJdCB3aWxsIGJlIHJlY2VpdmluZyBhDQo+IHBhY2tldCBhYm91
dCBldmVyeSAybXMuIFRoaXMgY2hhbmdlIGluIGludGVycnVwdCBjb2FsZXNjaW5nIHdpbGwgaGF2
ZQ0KPiBubyBlZmZlY3Qgb24gQ1BVIGxvYWQsIHRoZXJlIHdpbGwgc3RpbGwgYmUgYW4gaW50ZXJy
dXB0IHBlcg0KPiBwYWNrZXQuIFdoYXQgdGhpcyBjaGFuZ2UgZG9lcyBob3dldmVyIGRvIGlzIHJl
ZHVjZSB0aGUgbGF0ZW5jeSwgYXMgY2FuDQo+IGJlIHNlZW4gYnkgdGhlIHBpbmcuIEhvd2V2ZXIs
IGFueWJvZHkgYnVpbGRpbmcgYSBwaG9uZSBrbm93cyBhYm91dA0KPiANCj4gZXRodG9vbCAtQ3wt
LWNvYWxlc2NlDQo+IA0KPiBhbmQgd2lsbCBlaXRoZXIgY29uZmlndXJlIHRoZSB2YWx1ZSBsb3dl
ciwgb3IgdHVybiBpdCBvZmYNCj4gYWx0b2dldGhlci4gQWxzbywgQ0NJVFQgcmVjb21tZW5kcyA1
MG1zIGVuZCB0byBlbmQgZGVsYXkgZm9yIGENCj4gbmF0aW9uYWwgY2FsbCwgc28gZ29pbmcgZnJv
bSAxLjUgdG8gMC40bXMgaXMgaW4gdGhlIG5vaXNlLg0KPiANCj4gTm93IGNvbnNpZGVyIGJ1bGsg
dHJhbnNmZXIgYXQgbGluZSByYXRlLiBUaGUgcmVjZWl2ZSBidWZmZXIgaXMgZ29pbmcNCj4gdG8g
ZmlsbCB3aXRoIG11bHRpcGxlIHBhY2tldHMsIE5BUEkgaXMgZ29pbmcgdG8gZ2V0IGl0cyBidWRn
ZXQgb2YgNjQNCj4gcGFja2V0cywgYW5kIHRoZSBpbnRlcnJ1cHQgd2lsbCBiZSBsZWZ0IGRpc2Fi
bGVkLiBOQVBJIHdpbGwgdGhlbiBwb2xsDQo+IHRoZSBkZXZpY2UgZXZlcnkgc28gb2Z0ZW4sIHJl
Y2VpdmluZyBwYWNrZXRzLiBTaW5jZSBpbnRlcnJ1cHRzIGFyZQ0KPiBvZmYsIHRoZSBjb2FsZXNj
ZSB0aW1lIG1ha2VzIG5vIGRpZmZlcmVuY2UuDQo+IA0KPiBOb3cgY29uc2lkZXIgcGFja2V0cyBh
cnJpdmluZyBhdCBhYm91dCAwLjVtcyBpbnRlcnZhbHMuIFRoYXQgaXMgd2F5DQo+IHRvbyBzbG93
IGZvciBOQVBJIHRvIGdvIGludG8gcG9sbGVkIG1vZGUuIEl0IGRvZXMgaG93ZXZlciBtZWFuIDIN
Cj4gcGFja2V0cyB3b3VsZCB0eXBpY2FsbHkgYmUgcmVjZWl2ZWQgaW4gZWFjaCBjb2FsZXNjZW5j
ZQ0KPiBwZXJpb2QuIEhvd2V2ZXIgd2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdlLCBhbiBpbnRlcnJ1
cHQgd291bGQgYmUNCj4gdHJpZ2dlcmVkIGZvciBlYWNoIHBhY2tldCwgZG91YmxpbmcgdGhlIGlu
dGVycnVwdCBsb2FkLg0KPiANCj4gQnV0IHRoaW5rIGFib3V0IGEgcGFja2V0IGV2ZXJ5IDAuNW1z
LiBUaGF0IGlzIDIwMDAgcGFja2V0cyBwZXINCj4gc2Vjb25kLiBFdmVuIHRoZSBvbGRlciBDUFVz
IHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSB0aGF0Lg0KPiANCj4gV2hhdCBpIHdvdWxkIHJlYWxs
eSBsaWtlIHRvIGtub3cgaXMgdGhlIHJlYWwgdXNlIGNhc2UgdGhpcyBjaGFuZ2UgaXMNCj4gZm9y
LiBGb3IgbXksIHBpbmcgaXMgbm90IGEgdXNlIGNhc2UuDQo+IA0KDQpTb3JyeSBmb3IgdGhlIGRl
bGF5ZWQgcmVzcG9uc2UsIGFzIEkgcmVhbGx5IGRpZG4ndCBoYXZlIGEgcmVhbCB1c2UgY2FzZQ0K
YmVmb3JlLiBCdXQganVzdCB0aGUgb3RoZXIgZGF5IHdlIGhhZCBhIGN1c3RvbWVyIGlzc3VlLiBU
aGUgY3VzdG9tZXINCnVzZWQgZXRoMCAoRkVDKSBhbmQgZXRoMSAoZVFPUywgU3lub3BzeXMgRFdN
QUMpIG9uIGkuTVg4TVAuIEJvdGgNCnBvcnRzIGFyZSBSTUlJIHdpdGggMTAwTSBiYW5kd2lkdGgu
IFRoZXkgdGVzdGVkIGFuZCBmb3VuZCB0aGF0IHRoZQ0KdHJhbnNtaXNzaW9uIHJhdGUgb2YgYm90
aCBwb3J0cyB3YXMgZGlmZmVyZW50IHdoZW4gdXNpbmcgVEZUUCB0byB0cmFuc2Zlcg0KZGF0YSwg
RkVDIHdhcyBzbG93ZXIgdGhhbiBlUU9TLiBUaGUgdHJhbnNtaXNzaW9uIHJhdGUgb2YgRkVDIHdh
cyBvbmx5DQphYm91dCA0MDBLQiwgYnV0IHRoZSBlUU9TIGNvdWxkIHJlYWNoIHRvIDFNQi4gV2hl
biB0aGUgcmVsYXRlZCANCmNvYWxlc2NlbmNlIHBhcmFtZXRlcnMgd2VyZSBhZGp1c3RlZCB0byBi
ZSB0aGUgc2FtZSBhcyBlUU9TLCB0aGUNCnRyYW5zbWlzc2lvbiByYXRlIHdhcyB0aGUgc2FtZSBh
cyBlUU9TLg0KDQpGcm9tIHRoaXMgdXNlIGNhc2UsIHdoZW4gdGhlcmUgYXJlIGZld2VyIHBhY2tl
dHMsIGlmIHRoZSBjb2FsZXNjZW5jZQ0KcGFyYW1ldGVycyBhcmUgc2V0IHRvIGxhcmdlIHZhbHVl
cywgdGhlIENQVSB3aWxsIHJlc3BvbmQgdG9vIHNsb3dseSwgdGh1cw0KYWZmZWN0aW5nIHRoZSBw
ZXJmb3JtYW5jZSBvZiBzb21lIHByb3RvY29scy4NCg0K

