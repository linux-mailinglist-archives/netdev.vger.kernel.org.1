Return-Path: <netdev+bounces-239430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3C4C683F6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA0524E1FCF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A67305065;
	Tue, 18 Nov 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWdZG2NY"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685572C3247;
	Tue, 18 Nov 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455411; cv=fail; b=Wj2AvWGIkURtGOCnfIz12RYkvrkwMaUpf18Nu5S9Ke+f87B3gKnWnDPHvtYejei1MD4Klc+bGP8O34rXsFjDT5i5yOQZK6qgvNEmsmlxyCXRHbpTnyzsZvk/Syal02UnhQqoo2VrksmNSTyq7kE770yN56m4ybKYjqX+aKjzlLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455411; c=relaxed/simple;
	bh=yCh2aOXPNZo0/9DuHGRRPIxfi2ZQ3KDh0ewLAkPLJZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2Yxtrp5IpwkQVXTNcsGu9QqCiH4gCFXZ6/WGszc1v09Ltsnw/hC1gDhgRabM6F5jS1CvS7sKRVk29op3hSjj8UsTTmT8FAnlhflZJXIPOpmUtsMFa/0+lc6sHX/IRZcH5n1GxJpszep02LeuFLwu88BrWk9brrl6VNttJeePAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UWdZG2NY; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcYJ7G0FVLmD8NDJR9/FwCNwharI+hoeF3Gq6KTqtpLwKCyOgYBhu/KzblF4W2GWOX6tinFma8c5MEVoPjYNT/xx89L7lm7hiBcxyhLIGzgHwtxH5MsCfGzlFTHxAoiquJ0PpJmW4ydlzW9qYZflxuyN5lkO6QiUfYOe2mXZ3hTSj5o3e/kTzqlaIZHR4IkNUUTReiydavhBhIFU3Mr7HKtVVzfUo57kTkYLHqbrA4IGTSKLKllL49+k4cZifI7TQpN2rAxf7WnvMRXVyGZj5E78hjUQutkvohjFK9NH6dw6jK5C71SdRu/WCp8/IJnkchOspMnGwpHw22Hkb5V+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCh2aOXPNZo0/9DuHGRRPIxfi2ZQ3KDh0ewLAkPLJZ8=;
 b=d4NfQ0AU90VVk6X3jcrG9lZ2enMbJdtG+FpdowW3gEzli+FWzroOM9+Uvfjd1vuGJTT6uDk0GgVqgVXxw2qD6iGLeR8d9VdcY0dOEw/V8jqNe6nvYlJO69n+n/DiLQFUblD03vLXW8AZWgxiD0UPZ1s+sMbKo/oap0pMfRq9eRZTMXgVXNec2e+Q/Tx/Dwr3nIZ2xTfSEaOd8tl/pVlk1U3QlCoTL+/vJ6vZpgA9gNa5qT7mRhNZyAq8XRQEh8ZPjurHbSsVwar4FI1NwEL701sc0S9AU/LLjT0ECHDiYvBvTYXZVwi1S+WZMUuAOQpPUyt8RgNHVuVCLj9cbqoUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCh2aOXPNZo0/9DuHGRRPIxfi2ZQ3KDh0ewLAkPLJZ8=;
 b=UWdZG2NYHygDzIQXvZ1vlzEW2RR6UVatwpunZd0YatMu00c36NXP94dfwZmLiNLGmznuu6Hf2p4WcoG5fE72/HuGWyPDcYrrxnYOqyfmfu1qaQ3up/gagMu6D074Zct5LgQZ6eGe1VEois5zDBPIVXqy7YgXzKO4BYTa42tnOuV4ql7YBzg7+hx1h4mwaHZ2Hf+9UR7RtFiSmYvBcatobwa+PD289KS39SeFswwhMwdEIsQBcg2fTsgkdyAWkVuO1nm/rYcUa8PUYtxI4uompON81fTxpmx3sUsm9CXYVGjaR2ySbckO/cFAZD9pmeAM1PmJuY1A9/ts5REAqWwCzw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9520.eurprd04.prod.outlook.com (2603:10a6:102:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 08:43:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:43:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
	<eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Topic: [PATCH v3 net] net: phylink: add missing supported link modes
 for the fixed-link
Thread-Index: AQHcV60dm5OqWbGSUU6i25P487WhzrT4GfWAgAAFJkA=
Date: Tue, 18 Nov 2025 08:43:26 +0000
Message-ID:
 <PAXPR04MB8510A92D5185F67DDC8CC32F88D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251117102943.1862680-1-wei.fang@nxp.com>
 <aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
In-Reply-To: <aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9520:EE_
x-ms-office365-filtering-correlation-id: 5b38bd20-0632-4523-01b5-08de267e8aaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6SRgBGW4oQZT66wWASqgeK41XW4g2CqZ5jNGeage/v71GNM/kPLiacwb93Bv?=
 =?us-ascii?Q?6K3qaQN1rgZMSmXoXqKLGwsE7QOATj6AsYaKqzrv9CL3fMRIcw7MmlLbq/hf?=
 =?us-ascii?Q?+ayo2K5etyq8sW7tWUQmSKALZXoE4jTAHrpCAXKjklFRM2mq1GuJfaRoREBl?=
 =?us-ascii?Q?850N6Jyf4qXUAs78BTI/WXOI1M06cHHaIAPOYSgs4NFJWTs8E4erz3e4SINq?=
 =?us-ascii?Q?M01xTf2nwt2ANI44Ibjn9gfYTNBgwVbdtGjur7MZD0fmUim0KGORHwOvuJo/?=
 =?us-ascii?Q?9tTDkPlfhaJgRD+BDUckuZNOaOjQdhx5XNYhqRSBxSihp1DtMPmu0BmLVXgz?=
 =?us-ascii?Q?LBEm65DhAplYmOFusAoX52sSMHICSAbj1XueJp3ecJTg2EF+C/vFH8KMpQWg?=
 =?us-ascii?Q?PshP0V7D3YeM48ms+z0ddh4ibb/TnyHer2Jv8QHATnAw76Po0yS0eeQz/PXZ?=
 =?us-ascii?Q?n6CDua0333809tAuMKSxkn9cqievtB5y5WKVTfTD5yKJSDmeNmjjK7BDB1YW?=
 =?us-ascii?Q?/5Lfzp8D+Cjr4wPaYplkb6ZX1g/h7jbBD7L9cCUEbrdG1wephz75aFHQUPCw?=
 =?us-ascii?Q?xTkNJ5QAxbydt6k0Kzwle72YgN5cOS3SjkdHg0rY+YaI6Ew/Hcq+nw3Nu39S?=
 =?us-ascii?Q?PHZlebmDOq55YpUvHTf3b+EL4FUioGG2etDVimqRc5hpCV6r7KWVXf8Eze5x?=
 =?us-ascii?Q?Wf7n7P4tTCozRa1DpK35hxplj1TFgi4fhzbtuBCva5otfnsJO3lTbPkMIh9o?=
 =?us-ascii?Q?LZh7FDRabOGCRz+0WGfiSrlwm8Vf1EF5VCWNITKLXI5bHe718Y8Gpi+sQV/e?=
 =?us-ascii?Q?4XQ4NFavzt811JUsQ8tUkXI8JNgk4dty0vNgVGy5IETbL92h1D136HMWIUcM?=
 =?us-ascii?Q?0/vwujQPjWk2c+5Jgk0QUU6ukfF6Eicy7NS/ptt9alDWU9G7GhkRd/cYvgFp?=
 =?us-ascii?Q?aA37c24OHEmE6vNoa43gYboSu0cgn3CDlChCUvzjFzJWrWijm+4oGbr8Qi0/?=
 =?us-ascii?Q?i265EjUIWr6Yp3e2qgfo4JVk2/F9bxOWja93iqWwfwMAYGT5DNeMlm2HCxgp?=
 =?us-ascii?Q?qRd47RBSrKzxSAhdidAEJNtSC9GOZRIcYfo0maktRunQ6+D8PbSGjRxdVybQ?=
 =?us-ascii?Q?oAHm2CQ1uLGBV+Y/3f1hnuTnvtKbBBJGJkYc5PnCaATlpqA7uHI6mC9k7Yqb?=
 =?us-ascii?Q?RJDM18y7vdM2r3+a8+AtJJZV6sgQ7FGIfs6yalKmR3GZJEFZWePFFsijc49D?=
 =?us-ascii?Q?g2TR3kmyqUp3Wg9GZzvTSBpC852khFXZMzA3I52gPhmAXqu22fm3598uKo4N?=
 =?us-ascii?Q?/e+PCdqvtwId2llYabWkEdMiB3tlKr6DpKiB+VIKRkq44oJmJquKTPugdFzX?=
 =?us-ascii?Q?23xp3OVlL7uZOcScaoafP2tuPDBcMVvnRmfAAHe2S6ta3p/G+/ulVxRArr16?=
 =?us-ascii?Q?aV8qVVgwslp9p63XoCZz7gu6WPsSHyu4hH/ppSrJEpY7rBghx8oQUv8phmDb?=
 =?us-ascii?Q?CUanpBNuBJG7LPJkBvYpgihX+le7wQlm4AhB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WcTLJbgCwOncucYmEPMlCSo8wAEj8tDAyt6BbFF5oqMbKeNPnjg5KNAidxZK?=
 =?us-ascii?Q?EJjq0ViWuZC7w2vECWQNVnz5VFV37ks/JPmzZYllZrmrugPeEYde6b+ZIlp7?=
 =?us-ascii?Q?xJNz9sB/LFuEIrKCpVVR2xfjBcNLGIKwxfTK9HNFi0VbQjrHPGBzxeTqLLMB?=
 =?us-ascii?Q?Z0PxrarTjKeebYgkX+abyilab1ek9pgO63Q9t2v23iQs9NQI6UE8VRHRZjVz?=
 =?us-ascii?Q?GY0RM/IG475GJaooDO9IP2AkDh1fkDRm0oTAAcdmqt4UKB19gopuJjAalpQy?=
 =?us-ascii?Q?530FdgNwzrwPWDc3BiC8gHf4jFDGNXgxdgY+podqy/16EwxzC0JYxp4eiGoX?=
 =?us-ascii?Q?kJilzRG80daGuUPgwIWHXhgCIHp1R9rnuYIk3iWb05sIkUcj01RKOW+rpdQ3?=
 =?us-ascii?Q?TmjdevC2pFB7UFhw1iauKi8MLv14BN+joUQalAlFwDKfGqCZpxMi+dpVCeES?=
 =?us-ascii?Q?uiH3FaaCwGP1c+HUcaUy1niNTxtcUewU1Vn4JS0JQbijQyigV29Os3SQtvDG?=
 =?us-ascii?Q?+ibA6lDIEMntiRtf4lk4sJzeUc3S2VUllMv45HdPU9cYPolOCkuY4jswwKIn?=
 =?us-ascii?Q?AV9TMSxGipoAgqQ3ewxpOJfLe22IDjtCw2bi2TU2+iQIHsCs2NM2ZoGjH5oI?=
 =?us-ascii?Q?73bnbxZDMSbap48+LwCobax1JbiXDOxh22+Drizj3Tch7KCGfi8snIUIKMID?=
 =?us-ascii?Q?+9unk2Zzn5geWDAQAKrq26pgymH3J3UPdNpH8w1gT+PnVLptjT+HiErBZJsp?=
 =?us-ascii?Q?g6tanrpgdLIjBV9ODkqBrnXxqGi7/fShQ8zbnRva1R6IKIN4iagTLSgKr2BI?=
 =?us-ascii?Q?TeHHNePZei9xx6ef3V8uCXdx9iBDXNzjhbn9Wu5vOWjkE/cfuKr7jwJ+01gt?=
 =?us-ascii?Q?jVTu23PC1Cvo66WYxFHXq3Ho22GH4oA2WmIyF98aN4IPiqElpKae8llA3WPW?=
 =?us-ascii?Q?f72tB6upoKJR6vexTbJGXG0R9TLu/y7SN2IJF5c+VgLeukBt7n6zZpgQ/Zw/?=
 =?us-ascii?Q?9P6/JcTxgiVAeDMwlU6OxRtynnsLv3L/XbqbA/UcIv5mE8cZSUssINKg3T09?=
 =?us-ascii?Q?ZqvF0DdZcHUSwHGETDhBiZ1MpItDJBV8yQexh9mZkGLNgnggNG3vPoapLPtR?=
 =?us-ascii?Q?7ZocPCyiyKxEnk+QdESAwlO7pZk7GHc2eOz9A4lFaFXWIOR9qQw8POKkd+jG?=
 =?us-ascii?Q?iZuSna0WWs7T7y6NbTTh5yCFAizClbpYgtlD9A9UglJiH/IrtfQwfSw6pxvd?=
 =?us-ascii?Q?qyg5eVRv3VQksu4gKFeqIFwOEnQvqDRGxaTaX9ehZsBmSOFVxjVi/+LrKCuo?=
 =?us-ascii?Q?jyy5vpy9EhhakWZmgaFGoBvKXLOrOBSQM75qbW0mw3YRgah1TNTlEMVUNNQO?=
 =?us-ascii?Q?c2j+QfNXwFNpJDladmEzP67OqqZg14MIkaL9hlrVDzKxj51fQQdliSheHBO/?=
 =?us-ascii?Q?BPWHrhRsBO1V/sHSmUZGdvNNM3IvdSeOeisRxnNeJCLluWdw7WwYR3sfyxcR?=
 =?us-ascii?Q?lwqjFotESz2vXhidgqkR0dntENpaSya7UOkct1gPTQmr/+4kmNdah40IhlaQ?=
 =?us-ascii?Q?n+rx5ucTjllNJ37ModI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b38bd20-0632-4523-01b5-08de267e8aaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:43:26.6802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZXGjNbSDcgOZmUkdNpCDhKNlC6sX6w17c+9sa3xPsQZOYdP0y2Vseo5STdUV/TPvuyNVAzk5BktVQYjb4HQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9520

> On Mon, Nov 17, 2025 at 06:29:43PM +0800, Wei Fang wrote:
> > Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> > initialized, so these link modes will not work for the fixed-link.
> > This leads to a TCP performance degradation issue observed on the
> > i.MX943 platform.
> >
> > The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
> > is a fixed link and the link speed is 2.5Gbps. And one of the switch
> > user ports is the RGMII interface, and its link speed is 1Gbps. If the
> > flow-control of the fixed link is not enabled, we can easily observe
> > the iperf performance of TCP packets is very low. Because the inbound
> > rate on the CPU port is greater than the outbound rate on the user
> > port, the switch is prone to congestion, leading to the loss of some
> > TCP packets and requiring multiple retransmissions.
> >
> > Solving this problem should be as simple as setting the Asym_Pause and
> > Pause bits. The reason why the Autoneg bit needs to be set, Russell
> > has gave a very good explanation in the thread [1], see below.
> >
> > "As the advertising and lp_advertising bitmasks have to be non-empty,
> > and the swphy reports aneg capable, aneg complete, and AN enabled,
> > then for consistency with that state, Autoneg should be set. This is
> > how it was prior to the blamed commit."
> >
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2FaRjqLN8eQDIQfBjS%40shell.armlinux.org.uk%2F&data=3D
> 0
> >
> 5%7C02%7Cwei.fang%40nxp.com%7Cf602663c2989492e292c08de267bcf5e%7
> C686ea
> >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638990510348901384%7CUnkn
> own%7CT
> >
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiI
> >
> sIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DNi8mNVFADhA
> 1SLOZk
> > z7yq%2FcogtuidA2u5GiK%2Bqm56L8%3D&reserved=3D0
> >
> > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link
> > configuration")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>=20
> NAK. I give up.
>=20

Sorry, could you please tell me what the reason is?


