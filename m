Return-Path: <netdev+bounces-64400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB83832EA5
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 19:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCB11C2478A
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6455E4A;
	Fri, 19 Jan 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S7sIZETU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C653E13
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687921; cv=fail; b=AXrAPk2yiNy14TpL4d5nX0rxudzvnZmTI9UAaXv9Kvfag6cW/9fv6n+yr6l/LV39j92IihGs0+QfyqZ0q5GLd/bp7PZjqVUN0Okfr29fk4hOLi0O7vYcwJv0a1IyBawwquewwpTutcPKUAD+N08jJtCV5ic2rzD5p/y7KtpMBxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687921; c=relaxed/simple;
	bh=CZ3bY9Io5YA40LSpt9O86Kc+Ct+XQQ+CQLyH5MhVHXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aC25dXH1CN8lo1kFtxtbL1NM9Kb6Z58JebPLrFCidGR5wzVUfQ74Vbj9Jgsv8N86WaJ2HJNpOe8j/jU7mXuhoiRIt3odWyGYTc/AJ0ydD1oULTavVf28rZpVB4aUMfkYeHb6pOoqQPRhd7JQwDKt1hTui3MWP5tMugveGdbiihs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S7sIZETU; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diQh0DabK0i2QBCJsiQ59/oCQPoV5WKfThqsOnwYptZjZiWv1rbvPERiYQLtkmryC7L01tlhtdaNbhpZrENfKjTDzTVmmJk6uiDv8qhImOgaMHzcu2atgMYsfLTF4Amwo/kXYsRF+BxuvQsCVvkBBL7TAH29mtPMd9LRpwS7+JJV0Ou6jZsgx9rq/CpcD4nArdv5oFK9u8E54rBJy2NFhnLLt2E1alsep+YFqAX3Vw091UBHgAzqgjxIb/7uNrsD0iPuLCvPywvaPG90FZf7Hjjl62SPsP83qSytqJshArvor4HmRizg/XFFfrzjvWIL/HE6d3E/O4DuEq66Sc2IVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ3bY9Io5YA40LSpt9O86Kc+Ct+XQQ+CQLyH5MhVHXk=;
 b=acrR33CdAstLXnHs2gZjqDZUDjynDZhQfMdigUp/otyvzrRXk1QB4wizUdtX8pp8uzUFI2slL+YoUVS6PXq92fPyaO7FqEfdIxwSKyqCFdEDXxtffyn/Vk4DslN4/ZTndYbhzZXR4fxwrUZjdIUtnTxm8QC0d0keIOkuz/faV2TOpf2zM9BSzYNuXfyDtceFNluk9ueA+XTpGepUlTwD3IX8eaT4owyDpGkfu1AQzLLBnwqJZWtWZo4xeFdhKQbpDow8VQaauqR6gbcX+1Vf9s9HI0t6IBmNc/Uj26er+m3Ca58mM3uAKUQMMISrZKM+KSEqBGFmTeGWgxxMq0KqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ3bY9Io5YA40LSpt9O86Kc+Ct+XQQ+CQLyH5MhVHXk=;
 b=S7sIZETU1Zf/kbV7IEYLO5sm/tyRxFHz1qgJ/XTFEbb0XQ+kzfKWMAA3G6FLRPbQi81fPckJYOzS4pXTJMfT+Uru9raNLoN7MBGfp9WgeWeN35nbeN1p2WUtxmTaTeiY4lFnKhwiAmgQVhSOjib4lPqn7W9pJ/la8c0xLgTZk6UvrravjicEdpmZYAb37er5mfytY+hWbJH3YGVdt1T2Yry4z2c6pZwv/jaqN4QXU4PmAYrxXEaMij6oZdDqLOd04Ja61xQHPD7Vk9OzpKJOK6QQlvAdG/pjAIBL55JFUgMndFyVnbABd/LpmzqLbn1j1RDPDZ3P4OvWlQZJ2b9WsA==
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:11:56 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::f245:9cfe:fe84:ae14%4]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 18:11:56 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Topic: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Index: AQHaOAaE4SV+OFEcQEq30M+e72jYobDG55uAgABwPwCAGjhxMA==
Date: Fri, 19 Jan 2024 18:11:56 +0000
Message-ID:
 <PH7PR12MB7282DEEE85BE8A6F9E558339D7702@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20231226141903.12040-1-asmaa@nvidia.com>
 <ZZRZvRKz6X61eUaH@shell.armlinux.org.uk>
 <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
In-Reply-To: <99a49ad0-911b-4320-9222-198a12a1280e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7282:EE_|SA1PR12MB8947:EE_
x-ms-office365-filtering-correlation-id: c991c846-d106-4357-a084-08dc191a1f2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +l9NurQYKpTFmpLvtsoW4AX+HM5BjaCM6rs+8JU0EuUhqlJkISYbJ+Eo9z5TIUcPpFWhCA+J2QRW/t3msnMrYlBuGVMwhxtjmnfvRgj/bgVCbs2RwnoESpsZaNlfaWZwJzep9bAiYO8W2hJnqwsE57vFV+QEu2Mfq4fsFovtRJbQEj0dR1ZLP6kg0Xhsi8QqvIT5EO010rfYFO3LyzYxta0KfQSCW+YAjmcgWJhg6mDokaGlcIcXIVu6T0gTJpllqGzc6jjpB2L5+qI/kyYhe1wqbirRuRzeUwV2SSSRGB1Qcz2cW8q6rji1pF9oy3iN/saLcNUyYQYbJrDkc3MiUjnETs9HKx+8kdPS1nzI/RNfc0SPeW85GBrpNmFOCicDPXCUSd1xnVH/QJRahQkGxp5Ai+cVX+Q4hOcA0SA8oANZVMIKZl9mi9cL0guNVH+XDvxc1QL3GwUb8aYVWbhpHT+Dckb7sLOPF62Ad9pDuwSdmDpjrESzojMDklu2vTo4PXxk10k+KlSwFoJ9Rf4wS9uuLDw9c7auvgxj93pL70MP7viiDPjkN2Upkoil7RdquqffjIQH9X86skzVtjCGbScXDtp2I3ZCbQpaK5Achxy/QQczzW3mdz4pRL66pjml
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(6506007)(71200400001)(83380400001)(7696005)(9686003)(107886003)(122000001)(110136005)(5660300002)(52536014)(4326008)(41300700001)(2906002)(316002)(478600001)(8676002)(8936002)(54906003)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(33656002)(86362001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZazPSTatPR9006rU4pY9+kFRej5lYc3AI71yXVn5DAaSPolj77bkL6rhQmBP?=
 =?us-ascii?Q?tZdhwPW9QrLpFTDg2fiLjmV/54s557BOPNf4PMJYIGig8J9F8qXZ+HM3Bu6Q?=
 =?us-ascii?Q?qq4BAzairFSTRbE8t8vn8Ew9iNexE48K/TfI5GNx+zndkYTRL0zml590pcK8?=
 =?us-ascii?Q?+MdkzF5azp3AaY9yBz96KF4hLmhyIk7K76BgsfWX7NFXeQHQMFjUU7iz3+mR?=
 =?us-ascii?Q?+Nsc4DvNbHcTgM3Hs5VJb6Aa9nP/fiimSYbtqpQAZu1Us/dac2Oz/RwPOT6h?=
 =?us-ascii?Q?wW/m4pgC98qY0UVHUrnINqBwdEVcsO8mIRy5v1giUr1wBI3b074cFH1jA7H1?=
 =?us-ascii?Q?AvdO3gRPqrBTC8BLOiK2UzxcOiKzkO5kV2rR6kc7bFq0pq37Rwd7svoQS+1o?=
 =?us-ascii?Q?tAHKhGmomd3iHU8UXRqZx0o5+RRyGAhsIBa4bzuuX+xds9T9zamg7aoVNjHv?=
 =?us-ascii?Q?iw892bpYSE+u4J8j+SKdDWkM6xEWPs3oqkKYelNjav8P3biw0p8Wi2L94guH?=
 =?us-ascii?Q?QDvj/lr1lmRywfJiYfppT/LKtQ7skCG4WNN8aP2DDLC7dPFLvV8SuWOa9IbO?=
 =?us-ascii?Q?Xpfa/QQULV0zP5tnMDGNZuRBXtRIL16QVE1oVBSVN16gPwow2ceOYAIrM9Ba?=
 =?us-ascii?Q?rG4ve4lIGtYbjBlrP/W0bW8SMLoMparnJWx1k/TxAJIK20EvNsCMCdB6W2dz?=
 =?us-ascii?Q?Y4Crzms2Eu8s5jAlLP3eExiACMJJ8Q0kecDTfh3YG6IQfzjYHNr6xL9VM+oI?=
 =?us-ascii?Q?j+VXPDEKOpq91sDXGMVTRszQy7kuRAzx4qIlPJm4MdaKkLrF0Hr7Y7kAgXbt?=
 =?us-ascii?Q?iovXcYYt8U3j+Hg8aykoH51H6CdCytaXkRKFkc3L/78359nIXdw30M6PK/yw?=
 =?us-ascii?Q?7lBuqn1orVTTxq0ToVC0GPLzR4mgRk5LfxmWDnPo0q+X6tjoRWTRWGtXurlj?=
 =?us-ascii?Q?ze1X6lRphZdZFBcY6Ch9hOnYHXZ29wXQdNydCgF1VvP70qZc6OqlSTvcqEfS?=
 =?us-ascii?Q?zs3htk2sS2jLw+qBtL3NPfs3mjn0gbWfjiXfmZVnD6IDmHYKsH97b3kFJcmx?=
 =?us-ascii?Q?6gpqBVufnPOYTVoTebK5wAy+6VsVCLTw3cXX1xqPSgCxmIrz1ea+PBR0cE9P?=
 =?us-ascii?Q?kszi39uIw7KV2FSo7/O2Qp9/sl9ev8OG4eludxjQ/2pj62LNrjXBvKIqPXd0?=
 =?us-ascii?Q?AvabJBb7z5JOWc8dRi4dHdn/W5byyyBAGPVQZmZLFTOsnfBal08H53XxJLpD?=
 =?us-ascii?Q?g2zJMcPvV10DWn9hvsu+qhvr67vt44AXDBi06nLpb4lqORiDuY/jT5TlrPpy?=
 =?us-ascii?Q?K0Vusl0GeT2Mm6koeD9cdHiBmdTSTpA+5UP+z6AlAPY3gxhG9zC2HybLE88N?=
 =?us-ascii?Q?nEzf/OapFLxqqmAqJWF9WANYr0DlDGxRYkBYdYrnmwAPzKAEoDfbXaTvZwHj?=
 =?us-ascii?Q?UIiVJ5Tq8QwDTT4o7feRFupXVq79Y0qcgFjtG8cWlcse8Xc2sJIs4yz2EDgw?=
 =?us-ascii?Q?JoAiNulq/CcnCVpKaxRNbDzY2FY5Jx1AZReFaSumuDJqmCcELYc6XW/wL9Za?=
 =?us-ascii?Q?3IbYDz2+9xLZuOFX2lQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c991c846-d106-4357-a084-08dc191a1f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 18:11:56.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GTtsrPs2kiEsBiMUxJ6DdMaxrLDjLV+wBxjh0OM0VulP6ZXdge23fDBxeQWpzh83CAO1iBXZmhibeSubBoTFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947

=20
> Is there any status registers which indicate energy detection? No point d=
oing
> retries if there is no sign of a link partner.
>=20
> I would also suggest moving the timeout into a driver private data struct=
ure,
> and rely on phylib polling the PHY once per second and restart autoneg fr=
om
> that. That will avoid holding the lock for a long time.
>=20
Hi Andrew,=20

Thank you for your feedback.

There is no status register indicating energy detection on the KSZ9031 PHY.=
 This issue reproduces during a 2000 reboot test of the BlueField chip. The=
 link partner is always up during the test and provides network to other en=
tities such as servers and BMC.

We use this PHY driver with the mlxbf-gige driver. The PHY irq is used rath=
er than polling in phy_connect_direct. if we don't want to make changes to =
the micrel.c driver, we could move this logic to mlxbf_gige_open() function=
 right after calling phy_start()? This would ensure that autonegotiation is=
 completed. Please let me know what you think.

Thanks.
Asmaa=20

