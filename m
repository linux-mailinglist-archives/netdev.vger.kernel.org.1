Return-Path: <netdev+bounces-169922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FAA46785
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B5F3A5AB7
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD25224888;
	Wed, 26 Feb 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BP9OuHYs"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2F224893
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589853; cv=fail; b=uSnfcjYPfBaBHbJPCwaBv2TZ8duaVeSZX/pZpS5hFhnAQw+k4In4H24gPAno+v5ShdaegxgW+Rg93CQiCSIKlOobtOYbVQk96FR+n0cVCZ7zym6bjmZw0fGjUqs6zz6BPXh8j6EwoZpcjcCCMAOK7soEDdBLYoD2OOMbKOPqIog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589853; c=relaxed/simple;
	bh=eyNw1JHwgW5mJfk7sL+wVNovmDzlRCV546zYFb373/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uX10cHC6Bamwrh5Jbr2nvOWzUwMxFKaloJtbVvYPEphpgVCm2yCj+zrddp7UDxHSKEBP9YUX8i9cVRXtVAOyJOoEoZPCFeCuZaw0osxFy4xOLCGhTmFuLphYeDxEO1XxqgSu99nxVpfgUNXyunDAWbmYDQQkp+u9t1p+mLM5p+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BP9OuHYs; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8WmIDe8hFkCoVq1/lS5z+/WK9TsAgOltLem12xM2vhe/c862yBttszFKfC5eC9pnG4+qBeeSVUI8xlMpb+i9jXybVjBww3YO4LxTP05HbEwe8gVxJ+lybbRy42jbTiTJ9ERwBxa8DFugfUQ8SESVn/EKD8Gj8JpPlnq7/TQC5ZMaY334gZPu/tqjtNK6LGRQC2kjDA7RMtp+YYv4KqxlbxnnlnM34az9CnkcTLLDh/lQvnGrVTdVN2R8Rhx7aaBwLMbiNwd1czdSM/3y3pt0uLHZL5Kis0/moyhmNP5wAXtGrh2+w1jiSuiw3JmUi3lLkUkev29ga29z3vGDc8djA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9xsLsYrVCUjvgG5koxUUOQhG702UvHkfVZWrIyITck=;
 b=f+IN0nriRF2lLhbf1uZItj4NrEemIXNcJpLVGIwcvTR+74XZD2KZk7rlXKZGzZgFcShEUVDRIgUFzSNcOL55rIQx4T0E6Uyi005qQMsabcWbLNTR3cxWvBaO+DhJ0X50PmlNOpZRkjgAGXRTeFyOc0wm5Nm0L0ZPzV4NBUXG3UlktJpQsU2dzCErRBVtFtdWaBq70FXRaBEyLOSQr58Xwj9RaWfirX26HmlgrCYeE7yg16rPiVlLnM1xj2qhWNFCx403p6I6t41M4UjATCPuu0YO1+BTCPZU8YOb1J3MVcvr6+spFOdgmij3ccCHNsbtPGUAp/9PrRh8g7vqRwaBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9xsLsYrVCUjvgG5koxUUOQhG702UvHkfVZWrIyITck=;
 b=BP9OuHYsQFfPfkeOHtsitEy6RZqM4VQkzZasCVAmyKM44fL6uTSKzm6/klgSIq9qEDYNW2QczDkkdLqjSYDUfEFMTEVIYAX08c7JRr3VMbu+VJ/EmlpW2vgknoTGpEQdkBfss7ZTdoq/nfdKcvV1be4ne2T4K/2zlT7DOQtRw3ymf/kbHs/HpurWXvRuJ+S/YvsltdFbkOu1mpoyXL8Ivspi5iyHSzenqXFXb1VXIdX8NkB78U1tHk/12+k7Ie5BzA6XAGRhGgwvyWFKZhhMIzLrW527TUiO+JXTMo3d8qN+wnYB1sV3Y/Vk8dPd4qVmgPbkMasAbd+GUswUKqyNbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9225.eurprd04.prod.outlook.com (2603:10a6:10:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 17:10:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 17:10:48 +0000
Date: Wed, 26 Feb 2025 19:10:45 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Message-ID: <20250226171045.kf7dd2zprpcjrnj7@skbuf>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250226154753.soq575mvzquovufd@skbuf>
 <AS8PR04MB91761FDBD0170D8773395E9289C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB91761FDBD0170D8773395E9289C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:802:2::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d9970a-3489-4b46-7b4f-08dd568883e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f4TdGpGkt18d8X2nWzAJNHjHa1SacHoK0YcJSsjM1QcyJ5kluhzXiu71DPDd?=
 =?us-ascii?Q?EuiROlL02o1Wipp4Lxx0tyyJ1zLqFhXYSPQ9Ftongruu+R+weykVUIOu9yKQ?=
 =?us-ascii?Q?BbKQHLMtXFePKm7Dl1uYR/fcQYhVXNzJGw5Vf8/Awl1k0dgaOaeFipYpFGAe?=
 =?us-ascii?Q?TZ8an3W+49tp861EdRLuYAA0Qpk3AikocqOXIDkAL7NUio4HB2fp8IA9pyVQ?=
 =?us-ascii?Q?4LEnfo4/xFantg0czPTuwgs7Sx9EbJiISqv7QT5Q5IpWJXAYWBkqnIlDXbyF?=
 =?us-ascii?Q?UzMufhS4EJJmKhlIaNUjtKXpx5VBjf2DibwNZXZatHcD4ZUaCXWX5bAcFA7f?=
 =?us-ascii?Q?TowWhoR8Ek5058fdgkRr4dP3ZADA9VDZakL8mmW+SqpytEeo/sbljmbIGO5s?=
 =?us-ascii?Q?Y9x0JQ09Ob0I6GRJm9GieNxftJ4cUG0MbjT6H5AxDen1o2Gl+cKR5qSzYRgu?=
 =?us-ascii?Q?+DT2yUPjhtc5g7oYnoSwnxD/y9FEFCF48IfZFj8Xd2vBcfEmslJvpsrl/3sf?=
 =?us-ascii?Q?QmfKa7qM0SgTREfSWxwP4cAmsaJCFEYxfmTZ1awJ/1Xz2T5W01vj77pInz/z?=
 =?us-ascii?Q?fM/+sfJBjXfEho4dCIkDta6HXidiY1KGjle4jIYhR2MizByM0QhU3pRweQY3?=
 =?us-ascii?Q?yt3x06iRSDVNu6BEEu+Erd+BvfZd6byaNKeD7Ydf7nVUsGNJV0A9CibJrNP4?=
 =?us-ascii?Q?IMJNRZad2mfEbHH2fd7jHfBijWYtRAHqmrT+09TZPFqVTEWX0jHbRjNLKdeD?=
 =?us-ascii?Q?ITbbDpu4Y2ctD6w8lOpWSupNIxbqLE3rLDTXHC/QiQilp2Huj0OQ9HS3RTrq?=
 =?us-ascii?Q?hplGxzB9XlCuVkCnAFBzhSP4LQKZc4mkAMxy7cwsQYTBPDiYrfgGfIldJWfn?=
 =?us-ascii?Q?udB7P4PblXi0g1BhxPmcR8m5idmWk52cdvoZA9lTM+Lxek+U+nJizTf4yP3C?=
 =?us-ascii?Q?g52HGKgIObG/3Xen73If2NAiDTbY412M66n71i/1sqVJKRRaXV5cP2WZpO4r?=
 =?us-ascii?Q?gk8COer7zUjv0iO4qUUx9VvDgMwHidNNkahW1MK/sNz1XKYZaC3uSUyidVR9?=
 =?us-ascii?Q?7asp5YMjywYxtPWKmausuDpBLERij10eD3UM4Hi9kyjhA10V//rfPZ/hpnNB?=
 =?us-ascii?Q?tjENeXokBxluB2HQVyMFQBkVWr1LkZeGdUC52IRNoDWJ1E11PgiJHwk2373X?=
 =?us-ascii?Q?6oQLJg1FGCTnVduHm6F6Rm/4m1ykNDffHmJ/SDYbmJkky+6swBJTc8ipQGh5?=
 =?us-ascii?Q?XNnmwIGdFjKICWBwBLxP8UPlJuRdQnRKw/o39dYCX2+SCPXLfengm8NVYwjz?=
 =?us-ascii?Q?qxolTc+xJy6W9/yRoq549q+wDKzXH7rOov3IkRXZb7jqvZzlD7mKikeRLO1j?=
 =?us-ascii?Q?9+mClZnkqXrf6Xx9qrnByEdw1yP9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WSHmXjisINhdixPludUkdrUex4G2xOPtIKQILyUtNw8FQ0JOpITaX3TEcQGO?=
 =?us-ascii?Q?3VMOUPee5dVPxa907E75VctaYWjP1RpYdRYG8EePZmrx8muTdY77bKxsv4Qr?=
 =?us-ascii?Q?BPATl3mYxalFx3gPKjLILPOPP+nOJ1N2r04rHJy0mybulpdxuEEkrsMjwNjF?=
 =?us-ascii?Q?6FJshzSTbiprj3emhod1rwygHa35OoH/VZaP1G+0I1d9CMML+k1GX3Yd3WnB?=
 =?us-ascii?Q?2xjIysCfxBeng70NDlgprasu690YByX/D1O/HE7Pn1bDDT7MVFthXsFZW19z?=
 =?us-ascii?Q?P22YyRBoMST5RRcZI3bxjtzG6/MduhhEm7kykuixne/fCbpJ4JmUMbcEjbMa?=
 =?us-ascii?Q?/flNeOurktU4NBV33nKfM2lOYhBdI+lFyb1SArTuKbbyWi8TAAcGubWQMaRs?=
 =?us-ascii?Q?tDG0UDgZUu72iJGNqwNInHHYN24oLcqq8N7RdxIeKW9JmhU5y+o50sMgethk?=
 =?us-ascii?Q?sllHa3wexdev+JV/2EyA+ApRzM+pvHc+KJjM/j1tCEjqGhNUwCHLN8eH83WT?=
 =?us-ascii?Q?+7lfSdF9ocORDGdR+bWAv/x1b0fPqATwfdpUr2JEZACNbkuTCVJ2nrn7lEj3?=
 =?us-ascii?Q?FmzWttxyBAbdRBY/jyv4cZk1Npsk5lnn+JdzqRSAUdfojw8PoYDSr15OuxV/?=
 =?us-ascii?Q?2LvXtwd/KbhXio8PlvoQNv7bgK1rl5aQmtIvAOMfr7haMfHSeIxEhzmsh/zM?=
 =?us-ascii?Q?pRMPrRWicmYwLF/QBMjTWqEretFx3tdlq0Z4+4ix5eu9FkEMZAfo5QfjdTlu?=
 =?us-ascii?Q?hqSpAGr57MWOpCL4KS2CA9XbJnW3hmo8CinbWwbOIleNfebmiDQYpkMNWw14?=
 =?us-ascii?Q?n2k5Lwoi5g7+wehiRbZvApXmMFEqFCg8S744ZLRYnwy6RKuoSPXCRq40rqEK?=
 =?us-ascii?Q?V4EijVagxq7XuuqZwQXSzG5AT9Q7LZgDwzrYLoB+g28djpXbv/u42LAOM6b9?=
 =?us-ascii?Q?AUDXmBdQPgbjw6knBHorreOjrvvg4XV1/9d/dwCiyf10pBmqlhuZKAKXrC3B?=
 =?us-ascii?Q?rARGsI8vxZroIjIg0NeGn9s4fIFORdBdS/Z+IId3PZbB6ZF2KJBZ5MeGnjD/?=
 =?us-ascii?Q?eTy3NvGIEgEC944wNaDrYBBTa/yRxPwkb3hX3hsDXh+Tub0Y1y0Km84b91lm?=
 =?us-ascii?Q?LcLXrBLlrDoHDsRHWUq+Iiv+f67z4rxkkXUXvWNlP0X8bBNoh4w6L52ORF/R?=
 =?us-ascii?Q?Fyz1hugZ7xVVaFk8j0TLrAhlZqbKDY2rELbqPE2L+3EYzRZTqlFm9xtQRhmJ?=
 =?us-ascii?Q?B3AwRhzlPxB7oT0dkcsPbW3bjVp3M292hacqoJb+l6jy0M2ZxTdQW41IgIRj?=
 =?us-ascii?Q?/mb6w+R27z6WS1MRFLZ3b5PpirKrx5upg0BsCDpr8OpwgJPmBu3zT7h5z/m9?=
 =?us-ascii?Q?UPXN+7R3jqgyyRd3IVghJ+inwRLRQGe3lANSv3YxmC1UbgsSrLCB4XD7zlqn?=
 =?us-ascii?Q?fk4M88VdzvUlBk51gT0dz6LVc9hzr6YBOlvfDgvWIRW5mpxf5H2gn5SUsybD?=
 =?us-ascii?Q?v4YqO/rTBFlaAAJf3Bc+YNP7e8Ja2wpSYJKGbk1wnHFMCWCOflVBfhpaabU7?=
 =?us-ascii?Q?3+7K1jXPBpO2SkqaagUAIWWl+V7WGOzc0iD6+aWAMH83CKdw6vtwtGLTMRLb?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d9970a-3489-4b46-7b4f-08dd568883e1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:10:48.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgygsW4boOS6+4oOnFu625n92mrtXbq4P/6ZGhBeeE3PDmVWCDNC65FJBiqEs9OU594k2D8V/IPcWNJfLVZmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9225

On Wed, Feb 26, 2025 at 06:46:54PM +0200, Shenwei Wang wrote:
> > Shenwei, you don't want the kernel to attempt to be very smart about the initial
> > netdev naming. You will inevitably run into the situation where "eth%d" is already
> > the name chosen for the kernel for a different net_device without a predictable
> > name (e.g. e1000e PCIe card) which has been allocated already. Then you'll want
> 
> The driver just provides an option to configure predictable interface naming. IMO, all 
> those kind of naming conflicts should be managed by the DTS itself. 

Good luck adding of_alias_get_id() patches to (and others) PCIe NIC
drivers (with a real PCIe link layer, not Enhanced Allocation).

> > to fix that somehow, and the stream of patches will never stop, because the
> > kernel will never be able to fulfill all requirements. Look at the udev naming rules
> > for dpaa2 and enetc on Layerscape and build something like that. DSA switch
> 
> Even with the udev/systemd solution, you may still need to resolve the naming
> conflict sometimes among multiple cards.

Yet, the rootfs seems to be the only place to keep net device names that
is sufficiently flexible to cover the variability in use cases. Maybe
you're used to your developer position where you can immediately modify
the device tree for a board, but one is supposed to be able to configure
U-Boot to provide a fixed device tree (its own) to Linux. This is for
example used for Arm SystemReady IR compliance with distributions, to my
knowledge.

