Return-Path: <netdev+bounces-117808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D834E94F697
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FC51C20DAC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F2189BA2;
	Mon, 12 Aug 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hO60aXFS"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B5189B87;
	Mon, 12 Aug 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486975; cv=fail; b=HvsBwesagOXymxKxkAYa6BJMfnqNljBfE/xNoDgpW9fZ7T19UEU1oXgHdLpw8Ephy/IXUaBCu3jlby66udY4z9+uIl2w6Gr5fH/gtfPPPdcyfoRJj7G2xaFJHXGFp92/OFcAsn2ZalZguWH2b7OYJjrPMjJxTZwKa5BQq2OpK8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486975; c=relaxed/simple;
	bh=MUeoMeK5DKSDNuaQley5wm54R/lKI8Dr91rZxgNxo1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GFKV5zUmxYUpup0ARxeeZT+z/sfNQqncDKeabGSF8G34/8xI18YmPKd4ZZ6z0xXkwKOc6Nd5ZGLNeJkUjba4SWoC1Kzk4rWLfTSsvPX5nNRUdHJn6UWKhbXWGGNv4rjrNj38JfVg96WUwcc3xqXlU8cA2Yw/yiGJWTk4fqPou3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hO60aXFS; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn5oYKp6Z9ZkRSgsdYatu2uuN10iAztoHGs/pNtiDZWizd7rYNR3/GjJEwginJ6ji5wVBOYnSbQ37DxSivuJ6gY7m0KFpSj9y3E6IquFlPe1gapi521wMTCQLcKfLLQ0qq1owhXRZFtRvfyG3D0IU4rQhCj9tkFE8f6Ef7VTWMnK04LNbT1IJKURBAtziRiJ+WzRPH9V5KkcXEkczcEVSuq4Uz/AvR5IluBgyXG62RL59BaroKRLGN64r578zrfuJrxVzPHr1K6XS8gAVssYjPUVhsDc7OOj53fKy31TRweWIDWchyyvicAdy0aOk9UY5Iu3Ozqkwfxvz0EMUWPQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=079KfLO/OlS34kNG2kVoSyR/PAsj/yWrwI9lpEFytL8=;
 b=fMnR/z8y3zs3LFOyfHc3lSlF1JoJt0jPTBC19COqlmEjftvdxA4tHia7hj9jh1jjM59bMxdHKQB48dpY/9OAF/RdfBlzrqZ78T2X5BD2iMh4tS/tOgAXVWCTtNLYkpdLeoj5tbUb2quD0K1wN8+/MB3S5RdwEkicZ5HjiYqCH9ajKP7qjEN8cN1uC2uqlGN1YsGxnSq3Ugl31Z9OxMsmF3hyZZjRvUdD0PibBFpOMvGqBVo3rkgeUDTQjk8vN864UIbpZc9qZtNF/BuQBqTRrFVyDLlLBzUw/bUIByvCwTnQqW/QGqj1TIr6UsTPCJ2l1KF6Xnm6vgswnzG78zgQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=079KfLO/OlS34kNG2kVoSyR/PAsj/yWrwI9lpEFytL8=;
 b=hO60aXFSicPuYPisALEj9AKQMq8UUIBkq9mz2DSO4V0C29QtV9BmToXvhRJ45V+lWyD9JVIrpLxvzVCjeCzHhi6PPgJfPRV9314JnDylugKBclMIcrkG2D3v254CzBvc2DXCSkN3Hp5MVwarMlPQ4wwCk0n8737hTxHTt6w3ZmHJxKu+6DBLxvbns07C0E14ebe/DD7zBrbJYTr0rBugAv1fe9m5QCO1vCFYfemgaLdxS0erggNNrHnAWgaM7JFgueIZ1Zrul5/WBhwVUbkdQIlhUhfcZwz0Pr9y+Cthu9DPJBYqiBJy34qgN3PB7ru8QzeWpv4WBj/0ZJLclzxODw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10969.eurprd04.prod.outlook.com (2603:10a6:150:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 18:22:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 18:22:49 +0000
Date: Mon, 12 Aug 2024 14:22:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: mdio: Add negative patten match
 for child node
Message-ID: <ZrpS7zJpa+YJZfjQ@lizhi-Precision-Tower-5810>
References: <20240812031114.3798487-1-Frank.Li@nxp.com>
 <20240812-unmoving-viscosity-5f03dfd87f1f@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812-unmoving-viscosity-5f03dfd87f1f@spud>
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10969:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e34aa1-7902-4cd0-0e27-08dcbafbc552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBEzvjcRbYOJT6jdMV+RA04AT6VfYDmlp5X3K8hdPkJL4dCBUAHyVIaNnmHI?=
 =?us-ascii?Q?K/OEkRA2e4kJR+su6DqDh7/QCUYqNVnD97krFqO7NlOFdLubXCb8tLUT/pPW?=
 =?us-ascii?Q?jUGEr1h7C8648YDnGIuM4whYwSX1FU9xwAz82YnLjbTa/AviezWVlxogW+0/?=
 =?us-ascii?Q?O6MA/q0gyNV6Mo7rX/UhZUfZjnRDigz+A7D9y/SwkkTXacbsnlMc73YCBzij?=
 =?us-ascii?Q?Bczim85mJUYrDDADw4/MjN7quvs4L4v5Mt2N3qqh9H4nnSnFXH4NNCSnbOpj?=
 =?us-ascii?Q?w7qd3REkqiFQPFX3p3ED1VNzkG9OYsCiKvStZG3Y5X57aA/bqd9r1ZhNHtbH?=
 =?us-ascii?Q?lO7ch4R7qqiJn4zGSk8KUZdMU3BUDaD6i0FESB8Qhrc9b1YY4xlZNwJznEao?=
 =?us-ascii?Q?i9+NNM2KKsyVR8zM4XHu8UXuSY7eY6YF3gB3yZOyq7JyVD1nOPk7+pfWP5Wx?=
 =?us-ascii?Q?VeoWhl6nu2FYi36SB+xStEm1zVWJe0Ctsuxi4cRM9KYH3aRgknDVVU/b1F99?=
 =?us-ascii?Q?g2aO11WSpVzf1OpKYqfa9xjiuDkmSiQzn+8UoJfNF+Fk7FJayRSw85JKKDmK?=
 =?us-ascii?Q?rP4b/HWqsPCQ4Bte9dhopb7rDesjYTcWTHntOPVLCi8rQoMeM6tzLZNPHB56?=
 =?us-ascii?Q?IZW2npW8aHF7Y7T/+LPaeNK+0aJn1bpd4PkPsBSbZTdZaQgUK4PEXmHNiw/d?=
 =?us-ascii?Q?mhKOdvcZHe+tcbUtY+1IgIM6N2pOnsU8ZICjZCP5TyQLBNlXJyy7u6NyxZJb?=
 =?us-ascii?Q?gOBOrIXPszmyCwAoQ+gCkGSeWGbJZxlhoihdNyKkkFStwqcdyvqtBRB6O9IK?=
 =?us-ascii?Q?oemEkotfTvyI2VSuj1oxlP07JQEQlvbd1QnN4joau0AoZfEYct8qxbS2vygp?=
 =?us-ascii?Q?mxAQFYW+2NOtHhieEjEu5XKkdKuHHmUvkS1O4wQNOTrNEzbyPfGGKJpsiDiL?=
 =?us-ascii?Q?hPpKvPm1ALAxOw/7uYjTQ6/H1k7IXCK6M2olG1nPfEfZGP+b3+BbQg2ZkklE?=
 =?us-ascii?Q?GRJFMn91Chuh0OYMkl188KJSf3x1od6H49VBrbUCiNnZZiQEBNtkAcOIzMOi?=
 =?us-ascii?Q?cOiY6weskwEI4adC3uyemmZ1jLRlgHZzLqp+9LLHjRBVjsAzhlD9+kXCI0Kn?=
 =?us-ascii?Q?OuW8ARxyh+401711nXggYOV53BNQanr7/eZ2xGSXMiYlvg+WvMo/YGX+rIy2?=
 =?us-ascii?Q?0ObhGx7jksJamYi8c+ldzsVwwABo5pSXmACAD9vZYxrVt5SELH+Nk64mbEbt?=
 =?us-ascii?Q?1hrEr1D7oMI2DeLoju9gVQBDZCEvp0fh9i3E8ixERdl0XKiwYadc2qCqUiWh?=
 =?us-ascii?Q?wq7AiAQNMWmxfKEYXyTs3viinAnuNVbt/nlnUtw+cfqTcnZGawdyoXHPdplK?=
 =?us-ascii?Q?Pe8ONUEyx2PhH/oR4kcaXAG9n5xa0XblSQwR2XdvjMdaAIci9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5R2r2oEjisDCWl7pU7gTrZJsYCYaIC07lpE/rlVenvqPE7Waihhq86p0yrx?=
 =?us-ascii?Q?XgFNS8VqKl6aiaXGyooNFyfiGoB2NjumNlJu9NsKTUVqdgO6BF7QcxlB0MPn?=
 =?us-ascii?Q?Nu51wfDBTuzJLl/OKSsM9/rnthQRASE5tfHMicFoNmcu7du2twiDsBrT8/OT?=
 =?us-ascii?Q?dKxrIH/fVb5E2bHS3xTaO+JREabtD6Udm9TtlcRTPOZh0CaszSB8JpFWtgec?=
 =?us-ascii?Q?oPVx2kQdckNIQDQKhYDTvDM435/uTsLe/tMd3lXOKT1FxEDBbNIVfyAn1Lo+?=
 =?us-ascii?Q?GHBX8KT9VlFd5D5KUfu5dpNN1BuP+YiBFdoU3C83dNTXwoBcPUPNASqi+Ueg?=
 =?us-ascii?Q?bQk/fW0Zes8P2v6EHwny432dcnveC1KtyX+NoE9WvA2pHPdS32x4wE8l7KJU?=
 =?us-ascii?Q?Nz/wYNFEBvgxbXTWfPMmDQS4062JutOloa3WXkm0XPK8rC6kGFe4F7sCocSQ?=
 =?us-ascii?Q?pEWYSLH5Wm32gmfZBtlmxj5Dbq7Q/L2hu4AgZYkKfO228KJ9AG3S/0aaMalg?=
 =?us-ascii?Q?hxIWe0gtXwVzbd/YHNnBttIy9QuLAPE14NPvIDFSzSuCNXul2VOdzUWUnEc1?=
 =?us-ascii?Q?4CKVzGqCeQXLclny/j/6k1Hg7IIb27EAnx7uKynURWygDpaQE2g2lfxIemqi?=
 =?us-ascii?Q?f4kOx+9nrncWzFU7HKcLz2AjNI3uVpjAa5xa9uKeu6RSPgGrT831dcav2KFW?=
 =?us-ascii?Q?JKLDMZWU/aJKFDoncC5NXX0anaIylotnnpXk5u7m89uio3+VoZ+GZCUd3s9V?=
 =?us-ascii?Q?nHe8QZr124KEHJO1buW9aAhO7fZTPRbQHuWaqon9XNnLZi3SQaNoF4cPOtzJ?=
 =?us-ascii?Q?nSkOMwVNT3uKnaruNaAEWzB2iafiz2N5hOQUMIEedgi9PXB2B6mBLIZQOa3L?=
 =?us-ascii?Q?pl0ogFvaSc6fLtfNPQLmNRKvgK64YyB81npLDiB6HGvPdDhin55pgirUyQDv?=
 =?us-ascii?Q?6vYF6GYGG8WKpuqp+rHuW6gxG+b5asCvU7OUo8bsMjhYR4D4fhUOEL0Cf4dx?=
 =?us-ascii?Q?NdLA3t76cHDYoB+9ayGPBbrFMfDnQYIaK/M1K2MdZBRE1JM/bJNdMelWZAWp?=
 =?us-ascii?Q?801gx1Fq7gHlEUap58OQFdz0TjRLu3SO1YvxzcYL8y3lhI1yc/C9TrPp26L5?=
 =?us-ascii?Q?5VXikpa4u+JjrBa2kooraSfKFuQS1cgyebi4eEUIAVzz287gOiAE+Tzu+inZ?=
 =?us-ascii?Q?EwhMT5kXWrltBOGh0ER6mw0bmbxahQ82chS6T42fJM0EvsKrKXOocxemuHUs?=
 =?us-ascii?Q?CzJOgLMHX/PlqfE5le8P6amM8VvUmSxJjik5ht8IIZvWg2+HPvNff5X+kMJZ?=
 =?us-ascii?Q?9CNnNEbe0nbDwEj0kEzARrOGvOpJyJjtVaCVq2rSBK/wl8CCx+At840sfxGt?=
 =?us-ascii?Q?rj4EuUiNtkltxAnuarPBOHTrJlqAqeoSUyG8laK0nHA70Ov5ASUR30uD2/iC?=
 =?us-ascii?Q?cxKG96Of0mqjJweccKdFHSVe5eNAFzWEq5s54sfsloxxrJpwq9D5uFpqz0m7?=
 =?us-ascii?Q?9yJLfOWjucbDJEIvcqGWG/uV1v5gU8zjZFqZX2P0detW4u8J4IL3/Iunw5D0?=
 =?us-ascii?Q?gmNkStvrSh0HTJoo/K0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e34aa1-7902-4cd0-0e27-08dcbafbc552
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:22:49.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NC2HQEQ+gEono9Yl5F77GjrtmuzL15ee1JDd9RKou3MCSrQchAEbgZ0Z9SxMJeC2TiBx28M+r/o4wrqwh/Flg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10969

On Mon, Aug 12, 2024 at 05:44:50PM +0100, Conor Dooley wrote:
> On Sun, Aug 11, 2024 at 11:11:14PM -0400, Frank Li wrote:
> > mdio.yaml wrong parser mdio controller's address instead phy's address when
> > mdio-mux exist.
> >
> > For example:
> > mdio-mux-emi1@54 {
> > 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> >
> >         mdio@20 {
> > 		reg = <0x20>;
> > 		       ^^^ This is mdio controller register
> >
> > 		ethernet-phy@2 {
> > 			reg = <0x2>;
> >                               ^^^ This phy's address
> > 		};
> > 	};
> > };
>
> I don't understand MDIO well enough to know the answer - does this
> actually solve the problem? It seems to me that the problem is that
> mdio.yaml is applied to the mdio-mux node because it matches the pattern
> "^mdio(@.*)?" that applies the binding based on node-names. If the
> properties in mdio.yaml do not apply to mdio muxes, then the binding
> should not be applied and the patch here is only treating a symptom
> rather than the actual problem.

after I change above example 0x2 to 0x22, mdio.yaml can report exceed 31.

Only issue should be only when "ethernet-phy" use node name "mdio".

>
> From a quick check, I don't see any of the mdio-mux-mmioreg nodes using
> the properties from mdio.yaml, so should the binding be applied to them
> at all?


in mdio-mux-mmioreg.yaml line 18:
allOf:
  - $ref: /schemas/net/mdio-mux.yaml#

in mdio-mux.yaml

  patternProperties:
    '^mdio@[0-9a-f]+$':  -> A
      $ref: mdio.yaml#

In mdio.yaml

  properties:
    $nodename:
      pattern: "^mdio(@.*)?
	        ^^^^^ mdio@20 Match condition A, it should correct.

  patternProperties:
    '@[0-9a-f]+$':
                ^^^^ mdio@20 also match this one. but I suppose it should
                     search mdio@20's child node, such as ethernet-phy@2,
                     but not.


Frank

>
> Cheers,
> Conor.
>
>
> FWIW, adding a $ after the ? in the pattern I linked would stop the
> binding being applied to the mdio-mux nodes, but if something like that
> were done, all mdio nodes would need to be checked to ensure they match
> the new pattern...
>
>
> >
> > Only phy's address is limited to 31 because MDIO bus defination.
> >
> > But CHECK_DTBS report below warning:
> >
> > arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> > 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
> >
> > The reason is that "mdio@20" match "patternProperties: '@[0-9a-f]+$'" in
> > mdio.yaml.
> >
> > Change to '^(?!mdio@).*@[0-9a-f]+$' to avoid match parent's mdio
> > controller's address.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
> > index a266ade918ca7..a7def3eb4674d 100644
> > --- a/Documentation/devicetree/bindings/net/mdio.yaml
> > +++ b/Documentation/devicetree/bindings/net/mdio.yaml
> > @@ -59,7 +59,7 @@ properties:
> >      type: boolean
> >
> >  patternProperties:
> > -  '@[0-9a-f]+$':
> > +  '^(?!mdio@).*@[0-9a-f]+$':
> >      type: object
> >
> >      properties:
> > --
> > 2.34.1
> >



