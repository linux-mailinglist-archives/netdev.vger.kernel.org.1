Return-Path: <netdev+bounces-169590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027CA44A85
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7288218918CC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A801A7045;
	Tue, 25 Feb 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VF0hf1Lr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284D1A5BAC
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508416; cv=fail; b=VW0l+liie3m2swcmaG/IyVCMCtKOb/9fxww8lxXGPHgnC+FeSCyH+RI/0TUpoyEeTLFzOuXUT4QtxqllDpjNSvaVbuOoHeM+3DNTczEdj6sVc3wk3ZADZh+aGF6viMD24z01ZX8Sx03hIkRycZ41ri35OLZXjUGl1i8BA4dmtfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508416; c=relaxed/simple;
	bh=PLK1AK8HGJHKZey3/9KkIdK9JdykPHpmFQ4wqbe+1gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PvRvQ/0Ns+AyUKv+JDLUigNIkyRYxn2EDFElD8BBf8NKeAeDmX+8D9dZyXfEGS9sx9hURfOuiiL75JIWOKBF7p6OnqrmRe4sc5VRqbbqEpVz9kF9wJis9Q+ziLAOskG6d6CIsPA2TvVdSgPyvW6AmZOQnL+0dXj+taVaxbVDNnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VF0hf1Lr; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMowg7QD2wjKN/kse0x6vkXpt0ZXPFAYWmmwg+bGisDoHaKZTkGyKxajTbgnOPzkF3/+NC/TPZUTrxRNgBieAGcmsLrLIFmHRkW9ezWSDOf72wRj0yx3jtOWITD+SZ2rdaiKCnnWaQFK05Tp2xMn6eiXr3QfpB0+yITuCTvntGj6F5eq/wIXhWiDDDSnN+W1+/vmKkblfyIOnpKGHxKftWruh3C+rpoLBx+gvo/gLAnSVjtsI06hhWtzigWY6Rxq+s+EPZT2PWYJ0+x9oPE4F3qpj7cpYNKNiuoZYTtnky8yzyLvET8GPPHHPD+JahbZMOcglIuz84MIPPiSan/Ezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AllUS7VJWu0/lTfHA7pYtGnMiUUXyVW5SynGZSxOSLk=;
 b=l0ZPnOL2gmCr7orl+GqMNaXoJARlSjz3TWXEg9f4VHKYBRkQScpcdkGujHEM1H2+ZzenilEsANxioyDsyPSRU3plk4USuFIcbuI4bpHMR9bR4XmuJgZW/Ybyg2Vju10j59gmItWAEgq64JxMNTPJ2Ld6D3xRoFBm9VhRM28leh3nEPUPKPcdjs+kvvLoXIMpNP4rTuTPHmNb/0+SkOVvKQOkjlo975azal4SlL1BLejiigSZX4hd21VYFdPFcfpWztQGDyxGoeEpA5fO53056RwcHi6nXgU9iD5ZBu3Rh+fezTSZnoFXZ5WrlrGmNBTmBJ8uMA0g2Ljs8zVLBGuGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AllUS7VJWu0/lTfHA7pYtGnMiUUXyVW5SynGZSxOSLk=;
 b=VF0hf1LrU3cQ6Php3d5xzjnykoEMIGLYvfyPwq34Ot8ANrVWIxFLu4pjfPLN6RED5ptlii3O/H3i3EljcNTKtnBZ5n9wJoX0bM7NLeAehiA9UuOEhaR574NtyERnmKLpVCO5ZgmLNRUpnE4m0opvNOfaelOmhYdwyGBTGQBd9Vb1uNjKLN7Cb0C5l/hRWEWRu+4yLW42hgDNEZU7+V2EHTmOWBbrBabnBMcrAGwznGdRvqMa3RtPtQ5tzAPYmOtFR+XKKueLaHH8hal4Z4QQFtt4MJDVCh89RiZ5wGTpWCn2eiOa1VaOOAO35TC10HwuyXAO6yl4YnvlzQEo5z1EHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 18:33:25 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%6]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 18:33:25 +0000
Date: Tue, 25 Feb 2025 19:33:18 +0100
From: Thierry Reding <treding@nvidia.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Inochi Amaoto <inochiama@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jan Petrous <jan.petrous@oss.nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org, 
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: net: stmmac: weirdness in stmmac_hw_setup()
Message-ID: <j4y47hdsavbxg5loszsq5ykr5v3lky7t46nj77zcxptuzlbsx7@dgqi5fj42573>
X-NVConfidentiality: public
References: <Z7dVp7_InAHe0q_y@shell.armlinux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iee34zcto7vh6dyq"
Content-Disposition: inline
In-Reply-To: <Z7dVp7_InAHe0q_y@shell.armlinux.org.uk>
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e9f557-f5c5-4f00-dc67-08dd55cae3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Aka5C8x+jhe+R+IAPfVigHOktzl+RjxFU/DEtQahCBRXE7HkQu+h6KXBtcp?=
 =?us-ascii?Q?UKNZCovzGLrmcgc26e2G7AVus161C3D3h3qglNmGiFrHEsHHAfy52LnwLW8/?=
 =?us-ascii?Q?+fRtwBSq/6TZlRe0oqOclaNa+NnAduHn/LavESnSUA4snWe5A4RN2FvUTleB?=
 =?us-ascii?Q?lK+IyAUKVjyMrOaculHcxKSwn4cfbQ61Ye40JwRwa48misNG7ne+r5e14Y0g?=
 =?us-ascii?Q?0Af/2vg7tcGGJJF1fRR9FeiV9TTK9R5VnKfdnZyp8q17TU9BE2+VGZjZB21a?=
 =?us-ascii?Q?b3Wo0/2p2HNgbX8Ai30H/wPpx/mEMmn3p4rlMYA05RsoJRf05a+peebiUHUf?=
 =?us-ascii?Q?kVI/ahmAw1CZGsLQfYd0+2yi/4HOMLhdtPEBGSkp/B7yCu4JJ96M+ST+Dpiz?=
 =?us-ascii?Q?uuMG0m4ADoCi9vOSATErvAndCSd9Ru8B3gChCdjH9cZtqeUhkREirkCwNztJ?=
 =?us-ascii?Q?PLQa673xmQEGO8rmGPeDsjJAyQLk+VOPKNfWvxfsAO6/pI7kGcAlBDuPL3tN?=
 =?us-ascii?Q?I9itIWim+er26PVJ/EICG/D9y0rH0Ur1mBzDcQIhjDcu3++Z2LVblsrr3NBE?=
 =?us-ascii?Q?HBvuLVlMSzzw6xU6oF2C1TJEHIBxvoX0QflpRboCg97GVgQ4RdG30cCJaYwM?=
 =?us-ascii?Q?fziOMWZ/QG4KjcDCegaMHZj5pT5YYnvVc/gLwW6NMQQrx+8wamt53BA8Emjr?=
 =?us-ascii?Q?QsVln+VvQKkx/BF4j3vb8cJEO8ktTQeYk2JEZJgyfXnaVgiVOuDbrAISHAUg?=
 =?us-ascii?Q?0G4aYknchSKgzHXP8gAj4RfVi4k+KOtc2QudkO0xvOBNEFDcFTyMFTWgwY7v?=
 =?us-ascii?Q?nhRSeQOalnHh9ZzE1Jul9cHUduSXn0/yl0QQeWFsjcqWTRJtb9afgCQk1ox+?=
 =?us-ascii?Q?Py7L28CYHKg9Wn4tZjvvy161gpMZlIT0wT7DgI7Y30O3muf5JXG/kmiLTvOP?=
 =?us-ascii?Q?VLsrIXwrMYngjc7MwfOnbSrAPKFk6NSXF2rsUfg5LvQaAEKnvyvoPD9uw1fP?=
 =?us-ascii?Q?60aCYkIP6FIaPJ/6kqdCJix4f7foHEiV0yN2OjwFGUkOHSsMWsNtxynp5q26?=
 =?us-ascii?Q?jCeP+UJDOXqZv6feY4PJiPdj/UgNWWcDapMckYvXqD8Wf4vXtsSVNp/hmpbN?=
 =?us-ascii?Q?cJIosb3CcN+4ZiOCYgvGFQSsNrWVUDp3He7zJH0HrEqxWfyyV7T5ssuOL1PE?=
 =?us-ascii?Q?LjMJUTo8JqFrT4uSv5QTG0AOozujYpS9uUx6xEfqrAm0/fQJxG0J0MEPUMma?=
 =?us-ascii?Q?MDSZTeRxg5GAZKPA8m0q8KyqejRYmKD5wLpVUyOTZIhJbHHewll5luvGlxwW?=
 =?us-ascii?Q?b3Kz2pvVXS5sdOVD0i+jOd0LD3JW8K/eroU0IuXIlExOBnlGEL07+Rs94KOb?=
 =?us-ascii?Q?1LCr3/XzCdQ0JbBV6IPopMjZWUwc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pP0lLhWGxPahxtLjyd/wqjmDeXzxsEPJ2rtIzQSjphIYgfSPI/P+gv75Jv7a?=
 =?us-ascii?Q?SnAW38vRymm42yQGb49pcYhztrzcjY/LQHwjZD255pMvh+315ma6Z1BoGZON?=
 =?us-ascii?Q?5nT5Y4H9EwqjQliFYHMHaDur9jH2WtgnJbUzfV+Z2mH5J05rBYlXpRCEPu80?=
 =?us-ascii?Q?rD92oJbIj0Pxm5GedQS7K/QVrb4N85L2upwGMnsgQBWIusBbXaX5/J7D7c39?=
 =?us-ascii?Q?tKHeGBQ6wxwqh7M3fL5XOJTqEcSfzosP+P/y+1zwSi0aB1kk0V/KI7xo1ows?=
 =?us-ascii?Q?1Yb8eaoqjeGN2HnFodRy1dqgYi1TLWCGXRWzlRFPNj9k4OvtwmZ41MnulH8M?=
 =?us-ascii?Q?ZjZVncmKT6aisWvaKn3Ai45PMmslq/ikzaFAqsNtYq6jbI6HjrTIxLMOFMKP?=
 =?us-ascii?Q?dEU+U27xP3PrbkUxSMuJMLNRXg3pKTsvj3mTktvI8UHPZEZg5qdgmYI1CEdF?=
 =?us-ascii?Q?gNEO0eZJe2iWcSJvPCdHZfiDQTDM7Kl7NkPPtUEeYQ3nJiXJquFd45ev1N/A?=
 =?us-ascii?Q?iczJaRXdGSkW+mccECAO0FyA3flkk6RNvqMfdILFlF/zDliay+tyVBNDs+tj?=
 =?us-ascii?Q?P7DDkG8xohB+3rRYd/MVaECYQvBFWY0ozR66U739XZj1nMCzJDGSROgmzXAq?=
 =?us-ascii?Q?BfPbKSgSGJndJ/4pH3/uxaB3ec87O5UIJuyDJouhluasod/MrKbV5a5ymv3k?=
 =?us-ascii?Q?uOjl8G6WTPA5wwprtMkenSokgZap0M0DnFaImwgI3zFXR5wKNG/T/ZkZjGnB?=
 =?us-ascii?Q?/DXW9Od7c5c9KBEy7JMPasoYow94Miesu02BvCquyKkH9wDaEba8PUVIpqUw?=
 =?us-ascii?Q?qV0t4ddVPZWD0cGTrB7fk3mvNNxcSKlm2Tl00q8USJKBQn3e4CJx9J73m5kS?=
 =?us-ascii?Q?w7GBbz5mw63Q8sd2TtdFKUNrmzhNJkKLhiAztnfaBS7/LFGWCLvkNo7tOX44?=
 =?us-ascii?Q?Zurxbra1Dq85QlwKyvlSqzLbeR6g0w5jibuFaFvqOxyGaCTWiH+o22EKsfqT?=
 =?us-ascii?Q?V0+cch33hJjeOo+cK8MYZGinJUdvjoPCY0NIUym0ioWpGrvCAIZbdOkK3RHs?=
 =?us-ascii?Q?BD+4vslRZM1jzYyL2/Q3dkWP7GCjYz8O4TlYRT6Vko6YEXFvJukNG3kleBzN?=
 =?us-ascii?Q?OjDrv93U3bjVEeFFoPB4GgMioKkU2ovLzLIgC9AxN9g2XfeTsFslvZzzUdrZ?=
 =?us-ascii?Q?FPtq3rbzx4afvrwMAlgiP4SMVjtHxtdFbIDI0I287gJJBiB5aEOO+9IykUkL?=
 =?us-ascii?Q?7Ipq8cNs2sSA+I81yLggiliiWnm9NoQfczldty3jMUNtPZW9bYvwDyjlN4JJ?=
 =?us-ascii?Q?6vvhvJyONO41tlPcUssogxrqYwG9QEpVppX1DIHnAgw3CUV1fP9e60KWmRTq?=
 =?us-ascii?Q?W4L7tEAw53VTL+FRFQjyRUziU6o4EAjLv/c6/1wPHaOhThjLZ+gM+IR6xnW3?=
 =?us-ascii?Q?kGtEUAFYcYzqBh06ncG9aziFHJXfF7HwC1BsZHRni5IkCAGujRSYc2g46mg3?=
 =?us-ascii?Q?oTDArjWSB/MJ71rYfvuYk2b6hTAaayCeCBE2E83/SCZ5+iwxWcz5y6Hobgl1?=
 =?us-ascii?Q?KXVR4ViTU7yRx2qRGx4aiBbmbMCVp73qA4bnJ60dQIAjdfNsZQM5T/n1SY74?=
 =?us-ascii?Q?dMkTy5UQLsuiYPttgiZu5fgtfSKjEjG3LB4kbCsBLGDq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e9f557-f5c5-4f00-dc67-08dd55cae3d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:33:25.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2LW/p8d21Rozmk4sPhu6r4+Ax88s2ZgIEcr+fsRDBl9zjvJE4opwOy3lseJnfpF/VOQEcY62Z1vlb/wzgWQZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

--iee34zcto7vh6dyq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: net: stmmac: weirdness in stmmac_hw_setup()
MIME-Version: 1.0

On Thu, Feb 20, 2025 at 04:17:43PM +0000, Russell King (Oracle) wrote:
> While looking through the stmmac driver, I've come across some
> weirdness in stmmac_hw_setup() which looks completely barmy to me.
>=20
> It seems that it follows the initialisation suggested by Synopsys
> (as best I can determine from the iMX8MP documentation), even going
> as far as to *enable* transmit and receive *before* the network
> device has been administratively brought up. stmmac_hw_setup() does
> this:
>=20
>         /* Enable the MAC Rx/Tx */
>         stmmac_mac_set(priv, priv->ioaddr, true);
>=20
> which sets the TE and RE bits in the MAC configuration register.
>=20
> This means that if the network link is active, packets will start
> to be received and will be placed into the receive descriptors.
>=20
> We won't transmit anything because we won't be placing packets in
> the transmit descriptors to be transmitted.
>=20
> However, this in stmmac_hw_setup() is just wrong. Can it be deleted
> as per the below?
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index c2913f003fe6..d6e492f523f5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3493,9 +3493,6 @@ static int stmmac_hw_setup(struct net_device *dev, =
bool ptp_register)
>  		priv->hw->rx_csum =3D 0;
>  	}
> =20
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Set the HW DMA mode and the COE */
>  	stmmac_dma_operation_mode(priv);
> =20

Tested this on Jetson TX2 and couldn't detect a change in behaviour.
Booted the device using NFS and ran a few iterations of iperf. Same
as before, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--iee34zcto7vh6dyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+DO0ACgkQ3SOs138+
s6HbhQ//SdQcdM8AINmp4yWT54cFA6CIcq3VEd0/a4jk65kLnUxSDhvlE8uKIIbB
PjZooWVPy8c+Rfph1MP3yn9Cgzh1GJ3BoF9pmqcyaBp3f0OEjIR3xsiOoBOjfw66
PiqsgVKsoxW2HqddZeWzodxdy3gFWa+TwnmyxG4jeZj7IDdPOskllddLP/gFa07M
Pws+y1lu3eZ8n3aLmdjYw5CzwBL/DiSLuH4C+y2vgM7OM4Kc4sNzj4Lm4ESjIzEG
hDDgXX7IHwj9kkiK+F3HHF+RWb/JJs/U8rzwKn3lPRQckBu13TIWD0abZcpGOBJm
geFSg8fhOYLIzVYByudUUWMasd/8ZB7LjI5qJqI+D5z35e9f2yRnGKrTFkxVuBmn
0DjA1mlAdGIAN520/5yzh3z7rpnMuo4eJHkKzof8CDUIuYp+ZtxfLI0d5DMDJ9ka
ztaEC2/Y5QpSE0UVSchrZAKm/bLXHlJgDjsvoFb2tVuF1BFJftS4g9xHb0j7lI/t
qQ89ioqBQf7wEQH+kYbSQB4vi0rV6rHljDrrCce2zgUD8m4MeQdjjyA5TCbqoTUL
LNT8c0re5orgCHclC5LaWymRVFXuIw3yFLZxSdzYt1+HFJ/akdOk+Ng4bQFtSm7d
D3MhABU46CbAlHbuBMgP5teN8RLaZaX2vX/GP3GnFwBmJTwOj8U=
=5GR8
-----END PGP SIGNATURE-----

--iee34zcto7vh6dyq--

