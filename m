Return-Path: <netdev+bounces-227374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5905BAD422
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679C94828BA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2E30597A;
	Tue, 30 Sep 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="LmEuo2Dm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E5306D54
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243703; cv=fail; b=KGs5bQEqlKYFJxUiQKDknQxWDN0px7ceGUEyGyACYsLwGwdbrCXMmgnMYcILchWp5JdaHZqXzYYqB6YSts7F9kXMcRcD4w+61Y7UTYgaDm5omai27Yu5kKQ4+w2d/Mj1GWNGkRlbhqtZKb8cdESWwkZpmVF1H9Vk+krcIZA/BWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243703; c=relaxed/simple;
	bh=/QCvEfT3Xq38+gcv9XV2wit8oSPwid0fzdvI9n5xYIM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RQSlRLx2/fX7WR1E237pWXwxya6md4OQ8+Af+/uZXpm8WZjaaQVkfbo/ga4jnykZJY+bZpO2N8tN2o+YDBOX1jTcH7LfnfJ7WYSW2w2C7NUVoOjAtfrvofNUMLCdh0vxXsT86XneA7gnel33DB8eT5IYACSGTPU3lhPCrx9aFwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=LmEuo2Dm; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U7qLuS004509;
	Tue, 30 Sep 2025 02:47:35 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020107.outbound.protection.outlook.com [40.93.198.107])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49gb6r097y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 02:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDyQIpDJcLmD1YAqXLtZkTVbNTxh54DCqDgSy7XFGIWZZcmZfYOuqRLbOpr4lvmzt1FL2ksnJEPc4of9aJdGx8/+LMskSlq7vdNQ/gXOKUgsTeHqoOyTcH1zovQ5gKttFxH+l34h1nOfWvoCLZT1iJkB7ClPui4bqYA7sJX69lgAu0BTU0C7aaXhJqIAkBlxCy4CHj7am0JwfeQ65u6IkRDSqaUeF6+8klNp4X8XrXglFtUK3HzlsOtm+ZCSo2DfFQ3Y+AbEOTpStEzmjI7tE1uLowaOmUWeskums/g6aFG9meHWkC+SxNdXMnB/w4FBtXj8ria6ZQXXJWLn/mD+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0m5oR88nOyxMsux7Jnk2CzYWzhkv89y0mOYpG9qrbI=;
 b=IS6x5VkqH3AaJdh12v6YHjf4VjNakPXtKQPfyWK1bh7fM1NuNM1JN2QMo+cDZhoBL6suLL7ZW8AmAzaKVgv67WuW2b8qeUocSXUcdEchiisYC+1J2wQwNlRn8KV5TwBmV1znjuIiys7iW3AwReayK4oAQ95XPVF+AeXJsmDDRSBH4H3lHkKgpLQBlxxXIni8SmLkcRXMhCiDxHAgoqOeQMGdq7X2LhpM0i8/r68msSio5bnytd0T0/5vCJ7cvBTRYLfyA5ixoMRJDzWneNIvaGPvbgfpC7lI3fEQ62qafXxu+2Q1fE0ntFEgYQwKVHeoHPE6FmSL96fiwxoW36Qyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0m5oR88nOyxMsux7Jnk2CzYWzhkv89y0mOYpG9qrbI=;
 b=LmEuo2DmRBf22mqwIq6/6YymYQUm6lYrmQpWZQoxrcXMy+Iep05/o8Y/T/8zZYvBWK4qHQlDxqrXcxMK+Brc1lkJxJlkBE94HXoagaJQf+bGBiV6N6sfnGD1si31p/LVaQXyXZvSEba+7jbSJ5CsAOtMLljE21NQKg5IYZvrfbs=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by SJ0PR18MB5247.namprd18.prod.outlook.com (2603:10b6:a03:443::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:47:32 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 09:47:32 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Netdev <netdev@vger.kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>
CC: Eelco Chaudron <echaudro@redhat.com>
Subject: OVS L3 offload not working
Thread-Topic: OVS L3 offload not working
Thread-Index: Adwx7jxKYkTT9vWGTVCfJzzxtpcVag==
Date: Tue, 30 Sep 2025 09:47:32 +0000
Message-ID:
 <MN0PR18MB5847B49581DEBD1B6CDE17B3D31AA@MN0PR18MB5847.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|SJ0PR18MB5247:EE_
x-ms-office365-filtering-correlation-id: 34e9c076-58b8-4d11-f0fd-08de000660da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XWkGr2p1sauS8NBzkdieV/FYnPO3AeDpyQDbG1ojIw97ArcDX3qcBOCMLehb?=
 =?us-ascii?Q?DTgfwGMeGOGbRJRpWOMTZSHXvOQCOjvvPcxMOoX9JHCiXcCZJKEwA39g7uCU?=
 =?us-ascii?Q?FiSL489IzysSXXaAu7etQpvmzVXv/I2NsiUVoXgMgvLVY3A43khqpue1yUUk?=
 =?us-ascii?Q?GgmQAR/vR4wFDeDilZb8/Sxw2W6WnY7p22eFDMXqLFgTghOvVKmnQuJQP7lT?=
 =?us-ascii?Q?yRVa3GwzXu8R06ZPjz/RhBftabFjqZGUYhAWLc4NPTYWh0veOsZ1eIyh2wsG?=
 =?us-ascii?Q?w0Y4zZD3IomdrL/mibgwcIUx6PmaQgurvktVO/gOw5rYZDQlp2it9eutnVvb?=
 =?us-ascii?Q?0xp4guYxetUx/CZcA/u/1i+jCIwLg7GXR0MjquQYxgXF+JX03yWnsNOsEBFV?=
 =?us-ascii?Q?VVvtNnvnYYfWERYjoE9q6Ys3tqIUq+3SmzxkzUNXg/dLjgYUe10armDWdw3l?=
 =?us-ascii?Q?eOQTIOzrvKKScl+Xj0Tgrmxk3ezlgkIDw6p48VSXtuZvzlwDRhoXsLm5GD2r?=
 =?us-ascii?Q?SaL3G+f4bIvptL2wHn4c1kCRDQs4j2/S2aT0CMm1l3m87VHRzTSZXfeCRgRc?=
 =?us-ascii?Q?pmL8l0liO+98Ndlymm/ilWCi4aT08oNIrqsw7IW67Gal5lKhE3vbZ95zSioC?=
 =?us-ascii?Q?/28XzDeuBxQnakhqfwOMv6yZBisB28meoxgRaWgJTeMS1GmqIkvU47aNKH3B?=
 =?us-ascii?Q?OL385iwkAmHZ3mQ0LKKWmPseU5akR1584WbCyle0D2cwl3B/LY56EEoQH6ca?=
 =?us-ascii?Q?rWw2+evfYemN+gVqzLMNq8uAWL4D5gZnQBvvzl9r7t4+Y/rw8IZubvnl+v6I?=
 =?us-ascii?Q?3IF4yOlZwm5YNFEsrF0R+7W/2CIyI3OcpXfuqrzrIZ7Wz7gZhK+zi8onTcqb?=
 =?us-ascii?Q?Srz2XjRVS/zv7LLXyhoFjsu1OdU9gPyecGTMz3KdoWyUt2DhO5Twu5g7ZLG7?=
 =?us-ascii?Q?C2QwtXBSSHtK5mXb8Z4ZoM42aGNjBOhMvEMOPfyL94R9teXIUi1BQFicteuJ?=
 =?us-ascii?Q?yWPF5t5Ou63f3XOW/qg5cJdzuBrJLV5vVl6OZgXDY2FmpiWvdGX1wJL5eT8u?=
 =?us-ascii?Q?A7k8iq7Cc1LvHpbntRT+DxcnWr9RzZy0OopE3JYGfwQOKBY0yjJw3eZm83uJ?=
 =?us-ascii?Q?mhC8+NDDaKWk2mL+FTFofgoxzuU/2nwMgrkMp3X9YZDw3xeGTtQMQih/HI+n?=
 =?us-ascii?Q?NmTU8tq9owS42fTJOlcdGpoPu4wsM4Qv6hkEAngPbjORKLPpes90+0ly31xe?=
 =?us-ascii?Q?PqPoBk0asXc1yhchi73ieSx8lhsfooC3/fZ74aAGQfxGeDDBtU2foOeJc9Es?=
 =?us-ascii?Q?EiZ5Rlb41I5fDUhBCse72Gln7SvJXHAhzALm+tcY1MQCgz6vUCcrvNRx+q43?=
 =?us-ascii?Q?uMD9KEPQas/SH+zzVIgF+X1fI+fTe596O/ESq8DREUTzJhcZGxIRsc/xWONh?=
 =?us-ascii?Q?QmuCOWJz0WFwpzaSdiQPBzsU8N/zSABzM8KmcdYrkmVYeAKeZDF3v0Cgx1N4?=
 =?us-ascii?Q?hIFCtvujwR5ehICHQ3Z1t2MU82VJKN2X2SB7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d18HAOuSouw1C9aWpDTbYcmqb0pO932bJUloKUWrzCEt6KpirBJ6vnnBO1wm?=
 =?us-ascii?Q?VGwuSmra6WMLXHM2fyNyd3Sl8Zk8Wog9/9VK4E0Yvas6dnjTHJKNN0kA1OAx?=
 =?us-ascii?Q?DF/7+a/i400nYf/OpAzswZkRFFVbeKBadCGioey5R26lkpvbpHEKRO86Dqre?=
 =?us-ascii?Q?w9ISJJKf7qnP0MYMRituaRiLpF6nfQFfsug8Y5GoML04Vk4me9LApVkejAp4?=
 =?us-ascii?Q?issscM5dhLHHavcGR1Eh/by6sa+ylliH1P6/hHI3ZMdbaeE5II+Met0dKkmW?=
 =?us-ascii?Q?02tfH+1h+c+yVfhEYj4sg1FE6QCGs1m+3+BlqBzohPDoSed51ZpLVBBQDHUn?=
 =?us-ascii?Q?yFwQk11NGSIr1Y1x8krahu3s0kF6HdYSZLnEefjnP8RTb2uQUR/e3FxxmZxD?=
 =?us-ascii?Q?7gXLZW79vVDehUSjJHIM7ujsNDkmOXCm77A9VcX0CLgPjJOOuOFLkGI/viOX?=
 =?us-ascii?Q?DpLJ7lXXLXZWDoxZFZn2CAtt3WoB/pAB5cVxczCU3RO6SETgVSHu/ytWfFqb?=
 =?us-ascii?Q?snlu+l3sAPFGTil//qeJvw/kKLuwGgzoFr0bX00Q69qlWF4Y9M1YfaOS8hr2?=
 =?us-ascii?Q?BNvDKVcpGKGpEPX+t4XXOM+Af2ug7kYrIoVrFc/wWJAY8rbjjneHqwvpXO9a?=
 =?us-ascii?Q?utOJ6PPYOiJoXVYvtCcYUEOlxBWV/gkPI6rhIkZ6jnn6gsGghGObvyQdxmU5?=
 =?us-ascii?Q?W4b7/3xpP9MWLJEazRwaFymlca3q1MFaX5R1Q7jeiV4zIyeszlL74zAlsqTe?=
 =?us-ascii?Q?YdSFeFWb1soL9aMV6Kg0qIA5EST/C9swjvEqT4fV67e/jgJ2JyCgMCLEQqiz?=
 =?us-ascii?Q?S6rVBpy6+VPp5zFyAqICsrJ+tyX9pv7h/rRBEo+XS7Y7x5FIuQxk2N4GTJA0?=
 =?us-ascii?Q?/GAXkeJZxauJ2xlQgLCVRfsNwmuMIprJbrVX+Hi4jMBqXwp/zkKKb4T067/n?=
 =?us-ascii?Q?snhOmPHwmRgjpbud+krLO1siIfgzeYH11thMg27u2IKo+pLirgEViduVLuct?=
 =?us-ascii?Q?KjtM+uph1YthJaGipaZSDMgzhwXycIAU0S44WcR5Foui6vTDY0QSA+wh5Q62?=
 =?us-ascii?Q?PS32nzX24gZMnLYrnsezX0Gu24PPT7ouM1UEvKRMhPU2OEuA3kNrK9fseyKc?=
 =?us-ascii?Q?Pl782xFKaTHV7hZ16P8wxwmmObfI7R4RVYMKZ/HUK+248/dwHkJYjI/qJIeG?=
 =?us-ascii?Q?SDUyNirr3DMp/faUXs+HDEpkK9yusOlNi3f0yHY43C2QxocYdNIfkI5Pd8g7?=
 =?us-ascii?Q?TzizyAxPi9abTrzSJEWtINLnwMPz/642s25FYethrlJ5+P6+e8eASI43VLHb?=
 =?us-ascii?Q?b9ei71LpPYTkQrAZf/HjJzyidsu/ok5LHgIKDvL6JsgFyL9rPrOVmmcM1o5d?=
 =?us-ascii?Q?KaPPYObBOIDspTfWswqEBoq5zeU1fESU0U5V2nNowH38uiBP9ml+xNbH7XPR?=
 =?us-ascii?Q?/O5MEQbIo1BpPY+3IOh19zgZfW1ouzLVtegHlFc87B/I+5ignGz860/W/TG5?=
 =?us-ascii?Q?PJVYvbrxh39IURFHqnKRjBZoJr3TJ3O4h5gubl2rAKx8k3fxObGtl0xN7obY?=
 =?us-ascii?Q?XeNGwtNi8GJu8AtDhwbhscoO185+81iiegPk4h4c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e9c076-58b8-4d11-f0fd-08de000660da
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 09:47:32.7484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amKsvZAeF4BrcZHKDegTfI4+oitl68bP5wjKJTarlOlD10AttWWPtvRpdVz9ZS93rar5s1/X4hRmaiRRzard0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5247
X-Proofpoint-ORIG-GUID: PqCYaG9NnKYLxpXnwmGuxDbMEkBWi-5Q
X-Proofpoint-GUID: PqCYaG9NnKYLxpXnwmGuxDbMEkBWi-5Q
X-Authority-Analysis: v=2.4 cv=dN6rWeZb c=1 sm=1 tr=0 ts=68dba737 cx=c_pps a=lpCYFv1dv4XKb4XztGS+VA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10 a=niBMCaGCfJ_5xqR2ez4A:9 a=CjuIK1q_8ugA:10 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA3MCBTYWx0ZWRfX57oCDmKSZVNd rxQptOSPFLYr8m45V+YlSWj0w/WewSfHMggjoP1h1X7BhO1mw9KMZl4p82K+syl744usygEnD1g OxZnfApmlY6n49E7BpGVzpmy7BOJIKgVqxPbvOp+dJZZ9E9EhIvgrGxtUAkWR1uYTB7e2VDUn2M
 5D0xHnSgkDaWxh19sShgdR4QCDelZ+PfuKk3Udgk1QQV+o25W/XPVTShtcRiUeemnTCjAG7Ivfv d6an4PXEiFKSRsENcG9Lp9TqXH4HKWNBPD6RydK0pQpdK0BbK2FuF0sr5htj6Moe/e0s7ii043V P/NsvNYvzYZYEIbVxQXDCoCKB1HAuSStYLVSDhejSQ0uPh6ATTuWpstEegEIfnfn6ukwRKSUCEL
 Zdoveh8RmzQh+ofS/QHR4ozGvcIMwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01

Hi,

We are trying ovs offload  on 6.6.46 for marvell octeontx2 hw.  =20

L2 acceleration works fine; but L3 acceleration does not. (Please note that=
 slow path works fine, only issue with acceleration).   Any clue on what co=
uld be wrong ?

I am still debugging the issue.  I added below prints (please find below Ke=
rnel patch) in fl_change() function; and could see proper values for L2 acc=
eleration case . But all 0's for L3 forwarding case.
I also added debug prints in OVS userspace daemon as well (netdev_tc_flow_p=
ut() function) to double confirm that in case of L3 proper values are Pushe=
d.

I chose  fl_change() function to add debug prints as it was  kind of a midd=
le function  between ovs application's   AND  ndo->setup_tc() while flow is=
 pushed for offload.

OVS userspace prints are appearing  in both l2 and l3 case. =20
But kernel prints are correct only for L2 case. =20


------------------ Kernel_debug.patch ------------------------------------
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 6ee7064c82fc..ac9bbd4f4da4 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2365,6 +2365,8 @@ static int fl_change(struct net *net, struct sk_buff =
*in_skb,
                goto errout_mask;

        if (!tc_skip_hw(fnew->flags)) {
+               pr_err("ETH src=3D%pM dst=3D%pM\n", f->mkey.eth.src, f->mke=
y.eth.dst);
+               pr_err("IP src=3D%pI4 dst=3D%pI4\n", &f->mkey.ipv4.src, &f-=
>mkey.ipv4.dst);
                err =3D fl_hw_replace_filter(tp, fnew, rtnl_held, extack);
                if (err)
                        goto errout_ht;


Bridge L2 forwarding configuration (Working case)
-----------------------------------------------------------------

ovs-vsctl add-br br0
ovs-vsctl add-port br0 eth0
ovs-vsctl add-port br0 sdp1-0
ovs-ofctl dump-flows br0
ovs-ofctl del-flows br0
ovs-ofctl add-flow br0 tcp,nw_src=3D192.168.9.100,nw_dst=3D192.168.9.200,in=
_port=3D1,actions=3Doutput:2
ovs-ofctl add-flow br0 tcp,nw_src=3D192.168.9.200,nw_dst=3D192.168.9.100,in=
_port=3D2,actions=3Doutput:1
ovs-ofctl add-flow br0 udp,nw_src=3D192.168.9.100,nw_dst=3D192.168.9.200,in=
_port=3D1,actions=3Doutput:2
ovs-ofctl add-flow br0 udp,nw_src=3D192.168.9.200,nw_dst=3D192.168.9.100,in=
_port=3D2,actions=3Doutput:1
ovs-ofctl add-flow br0 icmp,nw_src=3D192.168.9.100,nw_dst=3D192.168.9.200,i=
n_port=3D1,actions=3Doutput:2
ovs-ofctl add-flow br0 icmp,nw_src=3D192.168.9.200,nw_dst=3D192.168.9.100,i=
n_port=3D2,actions=3Doutput:1
ovs-ofctl add-flow br0 arp,in_port=3D2,actions=3Doutput:1
ovs-ofctl add-flow br0 arp,in_port=3D1,actions=3Doutput:2
ovs-vsctl set Open_vSwitch . other_config:tc-policy=3Dskip_sw
ovs-vsctl set Open_vSwitch . other_config:hw-offload=3Dtrue


L3 forwarding case. (Non working case)
----------------------------------------

ovs-vsctl add-br br0
ovs-vsctl add-port br0 eth0
ovs-vsctl add-port br0 sdp1-0
ovs-ofctl dump-flows br0
ovs-ofctl del-flows br0
ovs-ofctl add-flow br0 tcp,nw_src=3D192.168.9.100,nw_dst=3D192.168.11.200,i=
n_port=3D1,actions=3Dmod_dl_src:5a:0e:52:82:21:ea,mod_dl_dst:00:00:00:01:01=
:00,output:2
ovs-ofctl add-flow br0 tcp,nw_src=3D192.168.11.200,nw_dst=3D192.168.9.100,i=
n_port=3D2,actions=3Dmod_dl_src:3a:5a:d7:27:26:6b,mod_dl_dst:b8:3f:d2:2a:13=
:54,output:1
ovs-ofctl add-flow br0 icmp,nw_src=3D192.168.9.100,nw_dst=3D192.168.11.200,=
in_port=3D1,actions=3Dmod_dl_src:5a:0e:52:82:21:ea,mod_dl_dst:00:00:00:01:0=
1:00,output:2
ovs-ofctl add-flow br0 icmp,nw_src=3D192.168.11.200,nw_dst=3D192.168.9.100,=
in_port=3D2,actions=3Dmod_dl_src:3a:5a:d7:27:26:6b,mod_dl_dst:b8:3f:d2:2a:1=
3:54,output:1
ovs-ofctl add-flow br0 arp,in_port=3D2,actions=3Doutput:1
ovs-ofctl add-flow br0 arp,in_port=3D1,actions=3Doutput:2
ovs-vsctl set Open_vSwitch . other_config:tc-policy=3Dskip_sw
ovs-vsctl set Open_vSwitch . other_config:hw-offload=3Dtrue

