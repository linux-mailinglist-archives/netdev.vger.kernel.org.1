Return-Path: <netdev+bounces-73361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0385C1A0
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB21F23693
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322A7640E;
	Tue, 20 Feb 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="xaMUtqwS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AED2599
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447529; cv=fail; b=e8wz1FxuSEGrTgoCF38IiC0wX9XC34afHuua0uPuvMYlSOUerjyZfQo8UB0csFhSgTstzN6kImonPoMUrxM2H3WtGAL1gHdtmfmZ9WtCzw90IUkVqxOwgIKFvl57U1HZtCrY055r/3+hHdrgYF+ZikfgZjX1v5GVqV281RpjSD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447529; c=relaxed/simple;
	bh=8cfi/MEfHQXCbMwHsIsCskGgwRQAvk6AB4V+LuFrb2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mWNItr9xyt3b5JegOVZzz6ZPSvOAMCrM6KjNlU1I+lsiaDYs/TjZrRPjT393HxWBc4lehDIdUjQ2MDAksgKBHe1oymaG7uE2ZP/e2L5cYzAqu4M9i/2uqr4V4zsdP8EMPs8Tvgd6OGKC50guOhjky4iTiK9D+lYeeB2+r0oRbBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=xaMUtqwS; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KBCLXo010235;
	Tue, 20 Feb 2024 11:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7saOoYDaXj6UAnUra9N7F4a3AAFWV2/3mruzN+aJ1Bg=;
 b=xaMUtqwSS5NFHq212EE7ayfc5tBDsi41UDKjoASBAeaipIcoHo4NnM7yyNj4jWALcgXO
 yGPdQkr6yIIZFHjkMr1gZM4NK5lxoCepelGI+9mFWrGX0GAFfAvDiIQFT+qADYsRMx3T
 W7ePpLpTQG5sf67hp4l7UV3+jotfUkqY+W35C/YZn3FsUb5PF8xeuieS3d1fmjhQXnAH
 cg6VKaBJHCWXu/AC+ALIgzSah7YvWrLbQ3TRrQAWpQrNxwPP85e1AgXTUMphmB8a9n9h
 ankt91kzMXryLcQedWyJD8Pp+kvYnCRKO3rBle3ZB4lYHhBvaCM3SOY+11xQmkzo2PeK PA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3waru2x99s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 11:45:16 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KGZWew031610;
	Tue, 20 Feb 2024 11:45:16 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3wcyqt05cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 11:45:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCuESZyEs44/yZFHaBiv27sZ+/m/Um1zgt76fTHC8bFTMiXsjzJO8y8S6kMxkKlP1Io201NbQoZuoUZ3vPkNWOB8OrC5cZbQwC//EQFu7s0/phyaYO/pk8RJHBdghV5z9wiqiK/X9BI2HdmJY+KoA3J5pr11uGGNzryRMp4uexadzyG86vmGtsdHMBP/ppd1LXqgbE4sm6IYBlA4L4vKf/YUsROSol05fP4kSUDRhtcElHSKVyQKpqrP8wyRV4RaTJ9NSgH9/kr6LBXlgn/eRTH+Fb3PqC/7zFc5YV6F7aw0O0pTsU4Rj61GYQkQXW+6aW4kgzryCMCYbWwH863pKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7saOoYDaXj6UAnUra9N7F4a3AAFWV2/3mruzN+aJ1Bg=;
 b=gw75qEUf0g4+iUBIwFKHzlmfII2fXSK7TXtM1oyDCVmY+8abIT4KnSXVnAzlvBPKoeeFuWI9OsxYbhM7Q77ulEm54fBuR15/Wzoql88sSwYnLFJG/mwJZEcFbMQhY+qzPYgpOPobl5fQd9NB+nWNAAWicDUIVdzucj7s3GO4rPm2qPzO17a8hOoSWn9DCTEU8VsF6FsEah5rhlxYOIwTS9kT7VLOWQe+rfm67345wpug0yihYwDU6t7NVw6mgqV1E3QV4o71jL6RQJFtEm30m6ZM8fk8uomwqPHSe0ldT2ySeJTHGuk+cm6pgBqBaHzx7+D2tGvy4bee1UH6tc56LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BLAPR19MB4404.namprd19.prod.outlook.com (2603:10b6:208:293::15)
 by SJ0PR19MB4747.namprd19.prod.outlook.com (2603:10b6:a03:2e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 16:45:11 +0000
Received: from BLAPR19MB4404.namprd19.prod.outlook.com
 ([fe80::c551:a720:e1cf:f530]) by BLAPR19MB4404.namprd19.prod.outlook.com
 ([fe80::c551:a720:e1cf:f530%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:45:11 +0000
From: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>
CC: "Rahiman, Shinose" <Shinose.Rahiman@dell.com>
Subject: RE: MCTP - Socket Queue Behavior
Thread-Topic: MCTP - Socket Queue Behavior
Thread-Index: AdpjPln1K8p7U6IuQcSvYKsg8BomjQAZRv2AAAG16IAABwYDAAAUyJNw
Date: Tue, 20 Feb 2024 16:45:11 +0000
Message-ID: 
 <BLAPR19MB4404FF0A3217D54558D1E85587502@BLAPR19MB4404.namprd19.prod.outlook.com>
References: 
 <SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
	 <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
	 <SJ0PR19MB4415EA14FC114942FC79953587502@SJ0PR19MB4415.namprd19.prod.outlook.com>
 <fbf0f5f5216fb53ee17041d61abc81aaff04553b.camel@codeconstruct.com.au>
In-Reply-To: 
 <fbf0f5f5216fb53ee17041d61abc81aaff04553b.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=9ede9acb-34a4-4834-b921-e60b68cf4367;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-02-20T16:26:17Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR19MB4404:EE_|SJ0PR19MB4747:EE_
x-ms-office365-filtering-correlation-id: eb2fba7d-809d-4887-9877-08dc32334e04
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 k/9EwU7c3RIJQt8SvQCXOB8QFBD72VTkAaW0mVQawyDRKH02A0gDdNvMyP59Gyi99Tsl7rz+pdLr1z4fHw0KY+qUD4zFo2857Ju9+/MjWiKkR2T8bp5qlkBj0Kt8xYbEJGb1o+p15RQM+qc26xe9/u7R4okALwz0a7D+D0V1YxchDYbktjFyOjqwRa9ZZT/75oPTYKeJbjGhktobDuurxwfm3thUMUUu35K+WkPeslRdHUPk/ImbyZfzoXKTKi2wAkEU+YWgtEJnJ8QWiB0np+N3LRumQN36H4OsyEfQRHSWca04/1Zrz2bbfxCkP/WQZeUrqvkkNd2ezIHsyv3s8m4XMXWhHM8R21vMHvnI11c9WG1ecwpwIBi1VwtgheZTQJn393dLWjUtPLoQ0UvSGmAjPM8gNM4iYJO3UINzlwxL/G33p6qwlROuuPLwY+suUjtsbR0kTFHyxKHnQIGjqeaeND/gBDGXl1gDokwbgyjuXBAuJxaeOGdhF/ooqzA3aiRa6n1kdGFJDQgR8o6oYfoye86ULU8f1ynPDcaZHYB0okuvsvuB7nq69w4MTK7ixSnpX5l4XpY1hw94gK2FIy4X0ijsMCC33O1xPKKf2ctUuB0194vkCfhC9E6SN06p
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR19MB4404.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?dDRoMU9wYWtObktmVXRHdUhiWW1yLzh5ZE5zVistYXRYQnMwaGkzc3dQN3cv?=
 =?utf-7?B?WXFIOVBWSkU4WTUxTVduSFFvZFNER3NrV1dJcmJrMmdtWk1UVTRMSjcwajI=?=
 =?utf-7?B?Ky1uZXVqVnJ3NmFpdTBESlZZQlJUKy01YW9xSkI3ZGdDU3pudjVUSHV6Y3JR?=
 =?utf-7?B?QldEcGxiSlphTFBkY3ZSMlA3V0NHcFZUbkpoT2pqMDlneWVna3lUOUVsTXFz?=
 =?utf-7?B?aFowL2RydzNvTUI1NEVML2VFRVhkMGFmcHkvV0RRT09qckdoZVFiNTIxa29K?=
 =?utf-7?B?WVA0YjRXQXNDbEFDODBmc2RBMHJEU2FsOG1rMCstMGtZNEZWZzgzalkycFZj?=
 =?utf-7?B?OXM1bnJXbC9heDkwN2JKVlZSMzRoYjFob1NIT2NJY2lyU2VJQWZ0UjlGcnY3?=
 =?utf-7?B?VnFWQTFmc01lNkQ5YXdiLzhYaHlYaHRKUTM5QzdHSW0vZU5kdUlaZmZ0SERN?=
 =?utf-7?B?UHJ6RXo4TVlrN0FVdUxxVUNNSistL1AwS29QMWFrbWFPVDFKd0tJTFVHYlND?=
 =?utf-7?B?V2VPbXBKeS96bVR0VzUxVk5pUkEvZzFZUjdZZHpaTFNySktPQ3Y3TnA3Tnl6?=
 =?utf-7?B?OGJLRlp1VystVWloSi8yeDVxM1pMYndReFRUQ2s3TGFxZTRtWXViZ0VtUHQy?=
 =?utf-7?B?ZVFzN1F1ZlE0V2J4bXhqQnBtZXVVcDdZT25IM3NKemV0STgrLVZJTG9mZmJm?=
 =?utf-7?B?blVpZmlUbmJRanF2YSstanY4N1JnUTlsMGdFa2k1dG1kZkdXdmFkT29GL1V0?=
 =?utf-7?B?d2NhTnFCRmhVRzBYZ21mUW00TkJFZFhlZFluSlF2MTR1Mkw3UEF1MmViMUxD?=
 =?utf-7?B?VUtrbU9NOE8vUGQrLVpIOXRDdUJNYlNRWVhqOG5XYkpjSDRaTEYvMXM3cnNp?=
 =?utf-7?B?Qmg0THF1aGVvYjJmc2xlUWJKWlY0SEZveUtvbm5rNWpnbkN2U216Q2JNNist?=
 =?utf-7?B?L2pEcTRnU0dmTDRwNDNVbWg3VldaNk1UNWRwZjJkdjFqSGhKcG9qdmhaS0h6?=
 =?utf-7?B?cTEzV3A4dEcwMElES2dUMWlkOWxWMEROandjZm9aVWt3WEhQbDBYL0dvSWtM?=
 =?utf-7?B?WUkvSDgzWVpmUXFmNystZ29ZWXJoL09qZFhkY1VqNjdiODNKQmpvcDFRYkdD?=
 =?utf-7?B?b0dOQzZEUEJsbHlua05pSSstN05JWkRMZ01KamZQRmJ5WHBJaVNUU2x0aHpj?=
 =?utf-7?B?REJ5WDRpR1FYa1ltUUFOQ2xnR2lHYUxKQ1FFZW1tQklYb3M4U0M5OXNpSHA=?=
 =?utf-7?B?Ky02Z2cxTHVWKy16ZTFTWlhYcndtUVV1RnZJQmNpMk9tL0h5dTQ5MTRjZXhl?=
 =?utf-7?B?VXVMcTJGTnNMWTU1bjd2ZWlHY1pIRVpIWFhhRnpOZzhaTmUwODF5OFZQUGVR?=
 =?utf-7?B?L01lYnB2cFJnKy1Nc0U1c3YvamYzVDBFajloMzNCZ1R6MERBMEpnbThZYmVl?=
 =?utf-7?B?Q2JkVXd5T2tKSFd6T0MyWktFZE5RUkFVMXNlZUJuTDF1MWp3bGdrTVo4UUlk?=
 =?utf-7?B?UEplTmRnQ1RYektmNHRsdmtLQ3NRNEo0cDdMcHJhT2x0YUozSTh5L0EydzRB?=
 =?utf-7?B?RXAwbUQwQUUzRG54T05wODg2bnlmZVlHMXRyZmE1M1BndUg2TWxmNmhwcEs4?=
 =?utf-7?B?MjdTZ1kxSk5XRFRUbUtmd3NuNWR1eW92bXFmOTkzZVZsb3NOd3l5Qmd0RDFz?=
 =?utf-7?B?eHNyWTFjWkxHKy1HWVVRemc4MHZ5N1Bjd1ZNSVM5RkVmZXhsaTJkbkg2WkNJ?=
 =?utf-7?B?ck9qM0ZNUzBjMDhTVVQ0cm9EKy1XcDRQb0pyM3ZMRUlCODF4VzE5NTM5MTNu?=
 =?utf-7?B?SUFrcXk5VjkzcE5iSHpZdnA5RVZmYWN5V09RblNxS0Z3YkdpTWVvREhvd0Fp?=
 =?utf-7?B?ZUkxbGNWODg5L2RtRkJXejRQQUVwTlJXUVVuaC9lRWVvanFWelNoa3BtcERL?=
 =?utf-7?B?RkJiY01mbzMvYTNqTkhyZk1odWpGZElvTnVTMDZUaHZZTFhObHYwUXQvUjJl?=
 =?utf-7?B?VDhRVE0yc1RoQ09TalQwVDg1VTcrLU1nYWFWVTkwbkRkQjY0RURQQVlYTUdi?=
 =?utf-7?B?bllxSGNBWmJNQWtUYjJubnduVkJ4blFWYnM5TldmbGp4YmM1enNoN0hMTW45?=
 =?utf-7?B?MkJWeGtTNTBZdGRGTDBIZ2RPTlQrLXJGdmJ2UVdNYkhzTDd3WkVTY21UaTFE?=
 =?utf-7?B?YWhWVDBEUFNLQlB6c2FpRE5UaGFRd1pabGJ0Uy84NUY5TjQ5ZnZpTTZrQ2c=?=
 =?utf-7?B?K0FEMC0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR19MB4404.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2fba7d-809d-4887-9877-08dc32334e04
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 16:45:11.3131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLctycWm0AMenhMJ18BOf93ScnGCFQS7JoL0IOTO/5n/rRq5JKxAmhmcyrVTeatwmHCz3sa6XwIu0VXXovcVVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200120
X-Proofpoint-ORIG-GUID: figu17crJeViv2YfdZpay6TDgbf8vy-C
X-Proofpoint-GUID: figu17crJeViv2YfdZpay6TDgbf8vy-C
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200120

Jeremy,

Few more queries inline.

Regards,
Dharma


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Jeremy Kerr +ADw-jk+AEA-codeconstruct.com.au+AD4-
+AD4- Sent: 20 February 2024 12:01
+AD4- To: Ramaiah, DharmaBhushan +ADw-Dharma+AF8-Ramaiah+AEA-Dell.com+AD4AO=
w-
+AD4- netdev+AEA-vger.kernel.org+ADs- matt+AEA-codeconstruct.com.au
+AD4- Cc: Rahiman, Shinose +ADw-Shinose+AF8-Rahiman+AEA-Dell.com+AD4-
+AD4- Subject: Re: MCTP - Socket Queue Behavior
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Hi Dharma,
+AD4-
+AD4- +AD4- Thanks for the reply. I have few additional queries.
+AD4-
+AD4- Sure, answers inline.
+AD4-
+AD4- +AD4- +AD4- We have no control over reply ordering. It's entirely pos=
sible that
+AD4- +AD4- +AD4- replies are sent out of sequence by the remote endpoint:
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-   local application          remote endpoint
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-   sendmsg(message 1)
+AD4- +AD4- +AD4-   sendmsg(message 2)
+AD4- +AD4- +AD4-                              receives message 1
+AD4- +AD4- +AD4-                              receives message 2
+AD4- +AD4- +AD4-                              sends a reply 2 to message 2
+AD4- +AD4- +AD4-                              sends a reply 1 to message 1
+AD4- +AD4- +AD4-   recvmsg() -+AD4- reply 2
+AD4- +AD4- +AD4-   recvmsg() -+AD4- reply 1
+AD4- +AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Based on the above explanation I understand that the sendto all=
ocates
+AD4- +AD4- the skb (based on the blocking/nonblocking mode). mctp+AF8-i2c+=
AF8-tx+AF8-thread,
+AD4- +AD4- dequeues the skb and transmits the message. And also sendto can
+AD4- +AD4- interleave the messages on the wire with different message tag.=
 My
+AD4- +AD4- query here regarding the bus lock.
+AD4- +AD4-
+AD4- +AD4- 1. Is the bus lock taken for the entire duration of sendto and
+AD4- +AD4- revcfrom (as indicated in one of the previous threads).
+AD4-
+AD4- To be more precise: the i2c bus lock is not held for that entire dura=
tion. The
+AD4- lock will be acquired when the first packet of the message is transmi=
tted by the
+AD4- i2c transport driver (which may be after the
+AD4- sendmsg() has returned) until its reply is received (which may be bef=
ore
+AD4- recvmsg() is called).
+AD4-
From what I understand from the above bus is locked from the point request =
is picked up for transmission from SKB till response of the packet is recei=
ved. If this is case, then messages shall not be interleaved even if multip=
le application calls multiple sends.

+AD4-
+AD4- +AD4- Assume a case where we have a two EP's (x and y) on I2C bus +AC=
M-1 and
+AD4- +AD4- these EP's are on different segments.
+AD4-
+AD4- I assume that by +ACI-different segments+ACI- you mean that they are =
on different
+AD4- downstream channels of an i2c multiplexer. Let me know if not.
+AD4-
Yes this is what I meant.

+AD4- +AD4- In this case, shoudn't the bus be locked for the entire duratio=
n till
+AD4- +AD4- we receive the reply or else remote EP might drop the packet as=
 the
+AD4- +AD4- MUX is switched.
+AD4-
+AD4- Yes, that's what is implemented.
+AD4-
+AD4- However, I don't think +ACI-locking the bus+ACI- reflects what you're=
 intending
+AD4- there: Further packets can be sent, provided that they are on that sa=
me
+AD4- multiplexer channel+ADs- current use of the bus lock does not prevent=
 that (that's
+AD4- how fragmented messages are possible+ADs- we need to be able to trans=
mit the
+AD4- second and subsequent packets).
+AD4-
+AD4- To oversimplify it a little: holding the bus lock just prevents i2c a=
ccesses that
+AD4- may change the multiplexer state.
+AD4-
+AD4- From your diagram:
+AD4-
+AD4- +AD4-  Local application                                  remote endp=
oint
+AD4- +AD4-  Userspace                           Kernel Space
+AD4- +AD4-
+AD4- +AD4- sendmsg(msg1)+ADw-epX, i2cbus-1, seg1+AD4-
+AD4- +AD4- sendmsg(msg2)+ADw-epY, i2cbus-1, seg2+AD4-
+AD4-
+AD4- Note that +ACI-i2cbus-1, seg1+ACI- / +ACI-i2cbus-1, seg2+ACI- is not =
how Linux represents those.
+AD4- You would have something like the following devices in
+AD4- Linux:
+AD4-
+AD4-  +AFs-bus: i2c1+AF0-: the hardware i2c controller
+AD4-   +AHw-
+AD4-   +AGA--+AFs-dev: 1-00xx+AF0- i2c mux
+AD4-      +AHw-
+AD4-      +AHw--+AFs-bus: i2c2+AF0-: mux downstream channel 1
+AD4-      +AHw-  +AHw-
+AD4-      +AHw-  +AGA-- endpoint x
+AD4-      +AHw-
+AD4-      +AGA--+AFs-bus: i2c3+AF0-: mux downstream channel 2
+AD4-         +AHw-
+AD4-         +AGA-- endpoint y
+AD4-
+AD4- Then, the MCTP interfaces are attached to one individual bus, so you'=
d have
+AD4- the following MCTP interfaces, each corresponding to one of those Lin=
ux i2c
+AD4- devices:
+AD4-
+AD4-   mctpi2c2: connectivity to endpoint X, via i2c2 (then through i2c1)
+AD4-   mctpi2c3: connectivity to endpoint Y, via i2c3 (then through i2c1)
+AD4-
+AD4- - where each of those mctpi2cX interfaces holds it own lock on the bu=
s when
+AD4- waiting on a reply from a device on that segment.
+AD4-
+AD4- (you could also have a mctpi2c1, if you have MCTP devices directly co=
nnected
+AD4- to i2c1)
+AD4-
Since the locking mechanism is implemented by the transport driver (I2C Dri=
ver), topology aware I2C driver can lock the other subsegments.  E.g. if a =
transaction is initiated on the EP X, I2C driver can lock down stream chann=
el 1. Please do correct me if the understanding is correct.

+AD4- +AD4- Also today, MCTP provides no mechanism to advertise if the remo=
te EP
+AD4- +AD4- can handle more than one request at a time. Ability to handle m=
ultiple
+AD4- +AD4- messages is purely based on the device capability. In these cas=
es
+AD4- +AD4- shouldn't Kernel provide a way to lock the bus till the respons=
e is
+AD4- +AD4- obtained?
+AD4-
+AD4- Not via that mechanism, no. I think you might be unnecessarily combin=
ing
+AD4- MCTP message concurrency with i2c bus concurrency.
+AD4-
+AD4- An implementation where we attempt to serialise messages to one parti=
cular
+AD4- endpoint would depend on what actual requirements we have on that
+AD4- endpoint. For example:
+AD4-
+AD4-  - is it unable to handle multiple messages of a specific type?
+AD4-  - is it unable to handle multiple messages of +ACo-any+ACo- type?
+AD4-  - is it unable to handle incoming responses when a request is pendin=
g?
+AD4-
+AD4- So we'd need a pretty solid use-case to design a solution here+ADs- w=
e have not
+AD4- needed this with any endpoint so far. In your case, I would take a gu=
ess that
+AD4- you could implement this just by limiting the outstanding messages in
+AD4- userspace.
+AD4-
We have seen a few devices which can handle only one request at a time and =
not sequencing the command properly can through the EP into a bad state.  A=
nd yes this can be controlled in the userspace. Currently we are exploring =
design options based on what is supported in the Kernel.

+AD4- Further, using the i2c bus lock is the wrong mechanism for serialisat=
ion here+ADs-
+AD4- we would want this at the MCTP core, likely as part of the tag alloca=
tion
+AD4- process. That would allow serialisation of messages without dependenc=
e on
+AD4- the specifics of the transport implementation (obviously, the serial =
and i3c
+AD4- MCTP transport drivers do not have i2c bus locking+ACE-)
+AD4-

Serialization at MCTP core can solve multiple MCTP requests. But if the sam=
e bus is shared with Non MCTP devices, bus lock must be from the time reque=
st is sent out to reply received.

+AD4- Cheers,
+AD4-
+AD4-
+AD4- Jeremy

