Return-Path: <netdev+bounces-107529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B491B52F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105001C2148A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25EF1AACA;
	Fri, 28 Jun 2024 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="aBsSM9kZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA31CD11
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719543340; cv=fail; b=bzEX866OuBkqRfJwq/MfqR8rRhw5vNHOknRPByhMs38pqlSS9bexLM2XlNzTs7soWDOoKDmntB20oGQPoROjmbOsm8Hp6rW7fJAJVacxhKAXh/BDt6notKfaV7lCKnSPHHAfVjycYgDMcQsac1k6fPh7hkDPtzcFhewqiKtQ3Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719543340; c=relaxed/simple;
	bh=fl1yoj1ai5R980TkxCRsonkJPWE3CGviCCHoQZneUxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dFimBFKAy8w2zDq50W68z7Ow57fmSd3BuPXaNgCPn+JDWap8+1h8VA5drH14gLd9AK5Pj5SLJDUPtgeyEk07VDuThLnra6At0Un7gCUZXkupNqJGXZ9+5avziqwqkSFUJkzxjXMPi4Yb7H1Q1S9uKsrNpGK5wNzbdb6uvljAOYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=aBsSM9kZ; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RLalUH007896;
	Fri, 28 Jun 2024 02:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pps0720;
	 bh=Pfb8pY9yoWGTX38vSwXu5NyMWo40DAmP+/Su4UDGu2o=; b=aBsSM9kZ3URL
	sbLAhwB1w3SP3OpCanYL7ZJTvI3d4B8/mUTqnqONek6m1ElIsUSy6uhCcBc+E80L
	TQ6iUDPXdj/nAI0D8xq7ZhjV2O5JtTmdppeCLxfYvqLokY01PyKS/mnqbKgSgusI
	WkAhu16MxdIFewnPrCrby1BxRzwFpf1mbpYSm9/dHozCwgn2Nw+3bpnvJooxsP/Q
	lnl4E3M7/1KJP9fU5a66zkDnbcKYwV4n3zLlBcB7MBq/kGr3XnMFOr4CDuSVdTBA
	msoJb3pKxu9TgK9E+3hbux3vsaJDEB+/dXeTa/QJ1OHVqNHGM6ELcB8o3sO1FjP7
	eDah4NAckg==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 401ar9m369-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 02:55:35 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 5C272800254;
	Fri, 28 Jun 2024 02:55:35 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 14:55:01 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 27 Jun 2024 14:55:01 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 14:55:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n93ztR3H5pH82TBz6rapQxILSdxqMSEam6+MgYBM70pXv8DTPMHdaSORZy2WkDkNeSS/XLVmO4m2DmPELL9Osadw17V2lmyZrfxcZfsU+Uyrwq6Lbkmb+opZvUNZqBugTYjILVenEmJHTzl85Xed1EfYpwT4PJQNiZDQya1r+5rdOrw51NoKftG47rGYYLVLFlDnfdyI9RjCdZFyg3fjOk4zzhrvhQvicFxxVyf10dX9GufVL8hPSYwbm0k9jeyq61SjKNwGO9lqsh4RQxkn5eg/F+9iJcHvv7wBy5Zp5FYlW/fT3G7W44/Ip/UI25zhaxWO5T9cPVrbgJsYxtqEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qi7cf4nBA3h2EurWz2Wbkz6D4eWLtfsvfnW940ouWY=;
 b=P6Nhre9ARtzjhGue2vozxyNmRQxyOtZd88z3SUIqW6cRFBSLlnTJUilTj2c4IzBja9DdooPBVjbyaK4rOq4Ba9GakkuKjUSMayrnb+ZPGyStUh/D0Q5oz9XrsomDGPMeUYDBkhp+9sB4a/tOi8c/jwCa9GzVDDPHG+KMwycjSNXWThx493BalAiBHo1ywZG3Q0lQiL6NNO4VnwbhdrY48Cw0+/lTRbyvahuoo8AEi57uKhthRqcvP+bvWd9+ruVBqZ5H+HFxyK6xK3Vivp5T1VaaECDEFj8RakqFWKeupzQetf5yormD8pjuRrGBIqjK8c5YScPtJ8NR96atbCCTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by MW5PR84MB1524.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 02:54:58 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 02:54:58 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: "ip route show dev enp0s9" does not show all routes for enp0s9
Thread-Topic: "ip route show dev enp0s9" does not show all routes for enp0s9
Thread-Index: AdrI67U2JlB2LTGbTXydBH/G1qpcpwAGEdUAAAAPaBA=
Date: Fri, 28 Jun 2024 02:54:58 +0000
Message-ID: <SJ0PR84MB20889120746B75792B83693CD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB2088DCBDCCCD49FFB9DFFBAAD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
 <20240627193632.5ea88216@hermes.local>
In-Reply-To: <20240627193632.5ea88216@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|MW5PR84MB1524:EE_
x-ms-office365-filtering-correlation-id: bf96b67a-18ae-4161-49eb-08dc971db264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?faRR8YttQy9ndgGohWsjt0rN8KFaKKPC6wdiDKiQHbEBXKPDxS1udoh7N98u?=
 =?us-ascii?Q?IZcQc8aWh2QB+UkuUQBwkfQ3fndZVU4pIOaChWX4X2k13EHEovLu5XKWnIvU?=
 =?us-ascii?Q?lvLGf6sxJTteRhctiikkcXT6wkn12MM10KyTphgjCV6MgT4JckEq8DWmICOL?=
 =?us-ascii?Q?ogjQAPVHNwOvAUrS8QrXCSjJ43pjJ+OMvQDaebs+bj1BZ54tIAXnzOhkauCu?=
 =?us-ascii?Q?9sRSNb8M51wBuMmgPGf7rZskVMfXQHM3d3g15CB5DbiJpjDZoEQbMs4gz+RL?=
 =?us-ascii?Q?qcau824GGgCSMVUyLLNanT+yddIskALHRhcc/ln+SB9VoOwYoVPRYCoAELBS?=
 =?us-ascii?Q?sxrXsutlDf2lpyyzBeaRQTdVsR2mlxzV/EQP72mZW196/qJR//xJed19wQ3X?=
 =?us-ascii?Q?pW33bLTBvnun1Qz1+kBj48B98OMyBuhjZBLKvWB4OHHp/t0f1nJ6VH4GJLlK?=
 =?us-ascii?Q?rG9FI97OEymIEqBL4OgDdjxX0Ko79PdvI0MVhxLzJpFASuV/sCyOpY9SSLK6?=
 =?us-ascii?Q?gx60gzhkQi+WvMQ6E2i3AG6M2IKizJWAxDn+Sl0i8bME/Xdu0ZgVIL0hwbGF?=
 =?us-ascii?Q?cIIqiji7bKOxpKk+jh2r/ZM6RmeB0trhbq88AjC3MyqNhveN1GBCU5RtxOVc?=
 =?us-ascii?Q?wlNIfVRQy0/4ZI1zelziE1V7h4EjDqgQZ3H6l0kYsSuAbZ9ngCVAhIekancL?=
 =?us-ascii?Q?KmUm7pzFz1lkEE8fEGZdfGIUAgrY0xtSR8piG7CJI3fKSoPfG2UoC/A9vixU?=
 =?us-ascii?Q?XIygykKlPfE4mD1R4Ba1hK5YgS4tFVB7l2F9B3Sg5CZbO6vQiXm3bamRCP8e?=
 =?us-ascii?Q?tjPMlhURn14JYPI+3EyvXT9HCkPpN4USD3inZQWJzilpo9Gmk3mZ7sCCS3wn?=
 =?us-ascii?Q?5/u1vOBD9D8fLLMr315ch6RN4yj547DAadooMQy/j+vg0m+HncczWDFgUXLm?=
 =?us-ascii?Q?sszt6D94eNnA0WqzRhdCqcccpselST/V7zGB+7YFKuGTNRJqHeUkSpfQqRdO?=
 =?us-ascii?Q?kP0Bdb/x6B/U7E7XXYYoCD/Q+kjo0GKurvs6SVJmi0XwDNP+kFKeqsoCuyiO?=
 =?us-ascii?Q?QjyS7FOJA4EpcWBwpLovfoieRiuTjYAG1thcriu9BnINdgAYtELKe/sHoaja?=
 =?us-ascii?Q?zVBQ5dZSiK0j2ZUMTl/F81xaIGFrcnoNakMS24STlWbp6Qdz2IDuZ+CjmkNf?=
 =?us-ascii?Q?hc80JRR/X/khUTi0DNiGciG2+5U/mUD3CEn7ShpKeADJto7a/ifMgG0ocJDd?=
 =?us-ascii?Q?USlSIAEotEx+IxmwlshemnZ1GfZDmb4sO8qkHawjtEygTjNbOnTXXBW+uKhi?=
 =?us-ascii?Q?75Z5EEdH6OnJER2PHjGLGdbgW3oOWlBeIhk70MfKFqEK1KbboIqxFhn990jj?=
 =?us-ascii?Q?IQYQMRw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CcDftF5XCqw9kmUIVAffKwdLRmZI9Ce7d61pnAfG4KPhYaE5r/zuVIvfuIpw?=
 =?us-ascii?Q?QBhsVpNJQwZvF0L2h3qJMEmLUHMsFTKBjUzcTKzQrdUVOn+q7Ks5PeUSqeJ6?=
 =?us-ascii?Q?O3ta1jAYY98VZ9XHlRT54EP/RyX07uIC+abrEUt/zfo9SCEIym/8cuJoOjZi?=
 =?us-ascii?Q?8JqpcNeGo1Gx3TfjmbayONy5GEJ40gDCwu7bS9PJ490BMqh+JwfarTv1UVd/?=
 =?us-ascii?Q?j35uL7yEsOKcS6t/EDRE84bqLdwPOjXcvqyF7vFkpD/CeW2wSOliH50Y0klT?=
 =?us-ascii?Q?UrkQcQl9JuMdIio1rosrTHOpWj43jJqcGL92PvcDOfGeXss7y1qaRkB+1R9K?=
 =?us-ascii?Q?kXNjQ50tsPzQZj418H/jbZ7q5CgaJeYg6OiPeU7lZbX6U+IQG9iTfkvFhnL1?=
 =?us-ascii?Q?XIQIbyMX0005hxCuhc8v54c8gSiUj2ADgsMrhPFix5tr2WPepIOe4qUdtNdn?=
 =?us-ascii?Q?nBNTLpbMG6/jclUoE0ZvAD8cmSjaF/G0wXHbdtKgdtYwQiLIK33JgkOuYV77?=
 =?us-ascii?Q?GgP6LFBMHau3mFmQ5Ndrsc/Conq7a6WEoAcpXeQLMPGXNrk517VQEoFUzMzL?=
 =?us-ascii?Q?HDqsKFDkfhaeor8v0ZNDAZbSTQZX26x3xkw6re+zAaLYFryR/vCQQvxDzjIV?=
 =?us-ascii?Q?gXJSwSf0yx0IrHErWpeQeHZZ8fbKPpJOyWWXfohiC//9mXtZAQTKIsQGJlSn?=
 =?us-ascii?Q?buA3iQX9L4rndxlUZD1ZyttgsuvilIGpigikTL9DtxwZlnLZS0TLqC3Csd0b?=
 =?us-ascii?Q?p9nEhAYIisroJqxtUAeWcC+Cw5Q72BF+WKuetQ84clhE8GldfFcGOnp4ALlB?=
 =?us-ascii?Q?TFJ8nd+Wn5bkSzt7Ui1uerYNNCJYvhqIRhol0P0mtbCzFUNJhR7kMWJlxCJC?=
 =?us-ascii?Q?c4EQQsJmmxhUK6nt11qi8O8kTiC/OKohXwR4al7fJWd8G0IIk/J6v+bDeExq?=
 =?us-ascii?Q?iUos57d4eJq3PhYfIhx6PFq1gWSttxXlkY47km2WfMh0jJHEm70qRuKbt3Ok?=
 =?us-ascii?Q?CgHzySC+AlPsqZaBJo34xZsjaTvnfLNFb9/DbokRwO+rYo13mqdtmodpBz0/?=
 =?us-ascii?Q?eJPSKnPJZT1WJSfsMxmE3XCGjDqyH7c8hFdjx+w19hBSpQA1pRifnEkKnYvq?=
 =?us-ascii?Q?5AjO0Sv6y61gAHUZLfhs+6s3Fv2gud1i1lnJxJ9iVXUIv7nFjFJpyfwnFQZd?=
 =?us-ascii?Q?4gE8QCkr8NBtesRPhsQ/hGulyojpQ15+W7QjUxM1+CMQKp+qaaHO2vH+NCY/?=
 =?us-ascii?Q?Zpb7zAfUlotPsAbQkoMdhw2EJuGLMtMKCHVQp6/gUcJpTMx9BsVGX/u90uXW?=
 =?us-ascii?Q?fwmKyL96UkQQhxeZzEddcLEknvUhRWMkhKCxYNy6lMrYddsNKU7Mb+fXLjTs?=
 =?us-ascii?Q?MTV9BK2xYR4s+YGS+XUnIIByFmfMwKsMp0rOgpQTT/nYcOfj9lEm9b+7sRkJ?=
 =?us-ascii?Q?svsrAtdfkZFQhzkLP4h4GQ3OxezsyzPVD254kE5y8wJNKx86Gks5qxEYyvHA?=
 =?us-ascii?Q?Ex1SJDT/iOqcGy9D815KjTKqhanXPjayx0xlgvZMigL2w5NoDH1I9oSJoCgL?=
 =?us-ascii?Q?wIecp2dlEbg6i1VhBdQf+r+ibkGiRTdWg2OeA6Us?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf96b67a-18ae-4161-49eb-08dc971db264
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 02:54:58.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9Tshhj3gZfbsh2iFYyz2k4SxdUieVCxbS0Kwz7nZf+8SJEet5Dbt1H/RXmtusbEO/nWm7sTixjC0HETQvEKW4qMyI2PuZwjze7Wcoxm9xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1524
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: BFM6G_8gbgK1HCIklIA3iuFzRU_f2i4I
X-Proofpoint-ORIG-GUID: BFM6G_8gbgK1HCIklIA3iuFzRU_f2i4I
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_16,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 clxscore=1031 lowpriorityscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406280020

> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, June 28, 2024 12:37 PM
>=20
> On Fri, 28 Jun 2024 00:01:47 +0000
> "Muggeridge, Matt" <matt.muggeridge2@hpe.com> wrote:
>=20
> > Hi,
> >
> > This looks like a problem in "iproute2".  This was observed on a fresh =
install
> of Ubuntu 24.04, with Linux 6.8.0-36-generic.
> >
> > NOTE: I first raised this in
> https://bugs.launchpad.net/ubuntu/+source/iproute2/+bug/2070412, then
> later found https://github.com/iproute2/iproute2/blob/main/README.devel.
> >
> > * PROBLEM
> > Compare the outputs:
> >
> > $ ip -6 route show dev enp0s9
> > 2001:2:0:1000::/64 proto ra metric 1024 expires 65518sec pref medium
> > fe80::/64 proto kernel metric 256 pref medium
> >
> > $ ip -6 route
> > 2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65525sec
> > pref medium
> > fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
> > fe80::/64 dev enp0s9 proto kernel metric 256 pref medium default proto
> > ra metric 1024 expires 589sec pref medium  nexthop via
> > fe80::200:10ff:fe10:1060 dev enp0s9 weight 1  nexthop via
> > fe80::200:10ff:fe10:1061 dev enp0s9 weight 1
> >
> > The default route is associated with enp0s9, yet the first command above
> does not show it.
> >
> > FWIW, the two default route entries were created by two separate routers
> on the network, each sending their RA.
> >
> > * REPRODUCER
> > Statically Configure systemd-networkd with two route entries, similar t=
o the
> following:
> >
> > $ networkctl cat 10-enp0s9.network
> > # /etc/systemd/network/10-enp0s9.network
> > [Match]
> > Name=3Denp0s9
> >
> > [Link]
> > RequiredForOnline=3Dno
> >
> > [Network]
> > Description=3D"Internal Network: Private VM-to-VM IPv6 interface"
> > DHCP=3Dno
> > LLDP=3Dno
> > EmitLLDP=3Dno
> >
> >
> > # /etc/systemd/network/10-enp0s9.network.d/address.conf
> > [Network]
> > Address=3D2001:2:0:1000:a00:27ff:fe5f:f72d/64
> >
> >
> > # /etc/systemd/network/10-enp0s9.network.d/route-1060.conf
> > [Route]
> > Gateway=3Dfe80::200:10ff:fe10:1060
> > GatewayOnLink=3Dtrue
> >
> >
> > # /etc/systemd/network/10-enp0s9.network.d/route-1061.conf
> > [Route]
> > Gateway=3Dfe80::200:10ff:fe10:1061
> > GatewayOnLink=3Dtrue
> >
> >
> >
> > Now reload and reconfigure the interface and you will see two routes.
> >
> > $ networkctl reload
> > $ networkctl reconfigure enp0s9
> > $ ip -6 r
> > $ ip -6 r show dev enp0s9 # the routes are not shown
> >
>=20
> "Don't blame the messenger", the ip command only reports what the kernel
> sends. So it is likely a route semantics issue in the kernel.

Thanks Stephen.

Ok, I have reported it on my distro in https://bugs.launchpad.net/ubuntu/+s=
ource/linux/+bug/2071406.

I guess the kernel netdev folks will see this thread and can comment too?

Cheers,
Matt.



