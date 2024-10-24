Return-Path: <netdev+bounces-138644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD709AE73F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC12289035
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D41E7645;
	Thu, 24 Oct 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H238C39B"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818241E571C;
	Thu, 24 Oct 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778680; cv=fail; b=ACLwg1UW+2Fxd7JkmRjuH+YIhPhag6IvJdsyUVBldFjsLOBU5eNeAgHQLF7MnRe0T2dgUcIrJGMz4nU0v/Gnw9slkONQZia0sgTlPWhFgAqc2SXw7qqo20FhgEXwuRtxvOZhFrl2YlUNMoiYCr7T2DoeaZy1IWcdxIhM20vCTHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778680; c=relaxed/simple;
	bh=77n/zJWGVPZn7ibpmmApFm6h1QbQMqRORIryCM3gKU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F/0fu00ZvpujnKDdCcJCAdM52yFBDSdzaaFDd03idXOFRITSIVz6ZpizLtVcQjdJVi2qh4Oi2RZcTdMy0Mq4lrTKqD10Nyl6zn6e3ZXAxcr09JKTb6FxQR4xjcrQWpsNCT+6LjFtilu4wtsGw/ras4GNfSJe+f4sP00My9lgz+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H238C39B; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln8qXrxknJ5fvnhrdBkTFMZIRQhEgHNDjL/raoM112F3hF2HKHT1IE0s9amoGU/hTgAZmOp1NjdLdo4H71/JzGgC9lf1lmVLww4UgN8coAVkvkvt9yKZtx2eWweaK7OuqZb6Uo80ff+xrV2ZuZxFHVTnvzI6VBXPp+2NjhiYWUzesZCorFopgXBSxQWPqWieX2fcJa0R/tk3+REnnuwzwp+yV1NGvxHA+Wsz9ibFnyGSmNZa+0SUAQhvELG0AhSjS7TpaybAQE2gDDXuLOO/ieem3RVEXkwCzzhVFpRvndv0TcX3m6pz7qgBGsgZPYsDHyprUF5JhZclBiCVqzsTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77n/zJWGVPZn7ibpmmApFm6h1QbQMqRORIryCM3gKU0=;
 b=L5Frfx8Km7LytDgx3bARbmy2RYrGPV0uouGkdDcTqRBrlgal/V7d59gsyEWuuraSCSyLODm+tCZtZfl6VXMk/k7NrQCWZ7cXTMGhon9V1iIQN7rFH08znMy4Z+sxk3NgOYc6pM0PxXxhKpbtsh1Es+uN3VeTpQR3/RxVsynEZZT1HynzRD3ohpXSmw6qWxSscC+qO7/UP9YP/cd0oBPCBXwl4zirWMWz7RBfnhIOIgmFF+DShCv9aX3IFnsJWS8Of+NFrhxsOMwY1m1MjMdyBRtCx4wCYYYirDQO0FamnnxfgHg6D/7s/LJLyKWzK/evZPxtVEh1R1dzdeFkhiJBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77n/zJWGVPZn7ibpmmApFm6h1QbQMqRORIryCM3gKU0=;
 b=H238C39BzBkxT+hJF3c+4NzNvJNzjXMAktvNbj9+sic1Ee+I2p4aeI4g9UR0diCx1XCUHGB3KRzMHw4GRl2SqXoFllNyhT8OZRrnYxMr2KteM/EIAZ4Wp5g14ZB3c39djM9n/S5IK8VyymRcqUFT1FGwLmtR+jb6MBqL9CflwOiijf/K1hE6nrONn8v5QjOTXjOKU0Po2bsMHOt7tBwXMZbI92qvTETvXzOp3SPYpSBeLehyV3XbhENGIt2Ahg/LT56NHW3TfPTCfwwzkGvJwVfJbclJ3fd8YeMbtgp1mIWx+Mpv7CuDTor12ZKx+WehTWYrEWT5gIGC9NjcMpeKMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 14:04:26 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 14:04:26 +0000
Date: Thu, 24 Oct 2024 17:04:22 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	donald.hunter@gmail.com, danieller@nvidia.com,
	ecree.xilinx@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v18 00/10] net: Make timestamping selectable
Message-ID: <20241024140422.3okn5lfqu72ncbxa@skbuf>
References: <20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-feature_ptp_netnext-v18-0-ed948f3b6887@bootlin.com>
X-ClientProxiedBy: BE1P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a28736-d1d3-4136-6bee-08dcf434c502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FaB+dYp7+d6BvG5Di6P9XB+JEja9gWnhMFr3HXoKNzTpuV5Jd4yMaMx0ygLp?=
 =?us-ascii?Q?DFQGVOYrm0ufHTErLNwdLE4mbmZUzQX7SkKoDnyYK0rX2zQOIpbklas7Vlbg?=
 =?us-ascii?Q?hgaEkHV2iMge0dzeCKBYLaE2V44o3CvJpnpYmItUDYXKXqgCBRlyNDAKeYDi?=
 =?us-ascii?Q?PoJqqC/TRIHKB8zN4zH9OK81cLw9GXia5G+K93l9seNTIFCjKYTGcRXZpW5Y?=
 =?us-ascii?Q?av7d8Q9YDRH/cG8uHg9f5D5OZkHOnF23GsI8LUkAwsRvhYk44qYG1Zac6s4T?=
 =?us-ascii?Q?0oJX4fPeOAzAd8gAk210H+3oyc6yb65Uo5vPFIlt7SnBvZcOPN6xkvqYO45c?=
 =?us-ascii?Q?p1E7euV7oyAb0RxOP19FzjDRhbfFdC2OdKwqIZikyqfLy5wZ3Mv1Ochk1ZtE?=
 =?us-ascii?Q?CszwzxF0lXVDINDReKv5PEnB8IsL9ARjIy/ZPuo8uPnpgjfsLFILWOj2nK9N?=
 =?us-ascii?Q?UOewfHnnJVCwcDgV4ci3Yb2MvfFFKhtgXrdNKr2m51LSl7qUt0CnvtqourDM?=
 =?us-ascii?Q?XVfCUVVnYiG8w4gcUYO+vqBxmyeLVWFr7gJDRBeKduiPuTRCRSyFVIFfXH6L?=
 =?us-ascii?Q?v066EK3j7cMR4xhPVov937IbFLo4JUr2T+/XzImlmWqNeyjnA3XBg+DirFD2?=
 =?us-ascii?Q?XOqokZ61rcmMBT5cmaWuq25tar22/4axUi3WJxiL6PRvZt+ZtENvnOrip//p?=
 =?us-ascii?Q?kqu+3OtLg+ti1I8DTm3Wv+EHcNdEqobOriC+U1ln3mYwYCr6GTQFdRfpfVRc?=
 =?us-ascii?Q?wNrQV/Bch+4+2nnUrAJu4VWMYXPzXZxIDopR7BkXrOiMilSrsB3BUp3wWiWF?=
 =?us-ascii?Q?VOeXLY7HAFKO1efGxqQYm1BT86Ih/p4KvFndvc2mWs28rxkXIdSKpflz0ugh?=
 =?us-ascii?Q?RzRITHthHVf7j0JXwzIfp806RwkbUr9Bg7BMavAbsFNTz1UFjARbrocKClkb?=
 =?us-ascii?Q?aoS2zK2qGqUncI0NXXt7h5FGSzHi/Ni5jiHzf42UuDIViCMOS6xnu38vCK0U?=
 =?us-ascii?Q?pnY3UzqBTKAQ10wiv94EENRZCO7aMb5DG5ZT9x857YrDni66MpuyuIlk7bM9?=
 =?us-ascii?Q?/swxs5y5LyfEnMaEKaXliY9MWrH3KVBOCZ45DFOQADpL0dH/MwoRmdyaN/op?=
 =?us-ascii?Q?a23EGoyk7ujESTBf8KgqaLzITYHAzLyBAuiiM5Ck+h5a8H8wRENYEPJrSQ+l?=
 =?us-ascii?Q?/vkyk4RWZB69GZ4ZGJ6cbbP8/A9xMQbgEmKWD6t0m/VrJKUAVyw+m2t/liEq?=
 =?us-ascii?Q?p+1u8hdiGtm2o1i7lY/bmaMLw8ckMJPQwhKRLwmc5GlEBNHXdq4HIhy9VYuw?=
 =?us-ascii?Q?cHewkKJ2TsiaTr+bbLjpaEvk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vgbf7CJc9iOIuVnufdJ9eU2Hk3sRL1uXVsmGPV+RZdhrC2g38gmXRFRt4rKA?=
 =?us-ascii?Q?NHZslrjnogxxyHIGxyWT7/h8vkUeAxbN30rHLfS1WyOjlRNxjcQsj0XuFjM4?=
 =?us-ascii?Q?bE44364gWkgM1qcLVl2hCl6cWJbi1P00tp9nrXZQJwwmUHbI7XdV8d0YkjBS?=
 =?us-ascii?Q?zzluLGZEnxhrFrOs84E5BcEUgH8fhRyfcXDNXfdx3WOOHo9eetRUvlfSBr2N?=
 =?us-ascii?Q?EjmcD0DzFBgxGHETb0oiTZX0Hr62eNJkokXb7i0P9PNYdtqY4OVDiNHlPz50?=
 =?us-ascii?Q?7DZkaP4/jXspaJIgAW1fuUw7vsDABUVxpZqGB0+HyFVeywuNtX45kTS6NFKl?=
 =?us-ascii?Q?P8fzcNxBk692isf6p9lMeyVOd5Y/p+ezjh4UbY5AmN4FJlbo7ev2YljR0VyS?=
 =?us-ascii?Q?4mmklC8v43Uo8A7xJELN52SUI+ceajr3NnjRqj5YLvSc8APuyWeySG2qSKGR?=
 =?us-ascii?Q?klhLXueTiaOMr6lJGXPCZtQv4bfpFYZ0jijOcQ5yU/i1Pfy9RLUTmyY+a5cG?=
 =?us-ascii?Q?acja/QQvkfF2VEHAgD+HLjJX3oEbbOt85mlLQgk8lpXiaEZE2GhiXSvXJdEk?=
 =?us-ascii?Q?lmesODrr23YHpW0N9pPBrbdUXirXXgLRoTOJsaYY8h1izKNK95mfiBRo6Ld2?=
 =?us-ascii?Q?52SOF/RvHOcQxEnDu+o8UJx04gPxdMdHq8aRFIUdrXGZ7T8nIYMqg/G9oB6/?=
 =?us-ascii?Q?juuqETop6Eu9B4CD+04FRIeijp4Ce+TnvLDWUh62MQL4cH4n799o3Os9jRFc?=
 =?us-ascii?Q?z6aUVx4dSfSDJIn/3PTWE/JTtb6iWQ2GhlF0m8MJaR73V3+6LzVLepouDd7d?=
 =?us-ascii?Q?1B+LeL9CfB1z2ZtHXz05br0hskBezFvPmGi4cystR4hkj4YqRNfFg7S18zkV?=
 =?us-ascii?Q?/QM5/9VJpHmifF8qqKk1jrlLUDOOJroi5m1L0JqA9bheZERwicpgA7yCUEFs?=
 =?us-ascii?Q?87LZqSi5sE54MHdeIe6URZSbt7YAWGnARo+nVQGCIAZuks4Avae1trtRyRsO?=
 =?us-ascii?Q?82QHraBMsbTkvGN6tFGa6XJJAKP/kfti4Exf7i+mXflvkf01VdFrXVf6gp0E?=
 =?us-ascii?Q?WRJhxWiFivG4whw0tphLdEpVJAj+fWHqRJ5M+IuxRg7vL3olkqRtU+TTePgT?=
 =?us-ascii?Q?+fzA75pYpRnYYR+JFoitkppsx7XTHIOtMl4iNrKJW6P5TZdxQSpdGUYM09FC?=
 =?us-ascii?Q?6mcSW49rlYdIkfxDlS1KLgEgaGe/V33z37PrUPff/LKcxdgqEulAkagLecKZ?=
 =?us-ascii?Q?9aaMmgGJNXPCCp6chGcDfkDyT2fFhIv9Wej2Jm/FXnnnuTq5OjGdjtgGsvA3?=
 =?us-ascii?Q?Iy42V9A9sZFabo25FQfpajnDikhAWVvRDsemEjKrifAvi097aphDKmnOeBwU?=
 =?us-ascii?Q?kopSyPPh7i5tDt0beMRavhxEvL3EFkBPc2NvcJH8uJlArNYViQGk8401FTDX?=
 =?us-ascii?Q?jTv1k9t8ODUHAf8oDF8HEkK+sbKIn/V9xqOicqN2MUk4kZ7UC1CNZOjBTgmB?=
 =?us-ascii?Q?vbVoz91Z34QhzKi/2cbtofm8y7NXv7yo5DOLrnlmNhmjRk+0x85Q2m90CKBM?=
 =?us-ascii?Q?3sz2MvDEGfodvNG4yqZDJEbP9tDyBxJCC9kSCf48xg2FQ9wMoK3gDvU3kO1Y?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a28736-d1d3-4136-6bee-08dcf434c502
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:04:26.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEQPywxRcH07m41QJ5nbkhnWVQfH3gh4lzIayCA/2XRoZnFjWBJpThagLEBq7D3SG/T38dj6dD8x7iBA7QZExg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

On Wed, Oct 23, 2024 at 05:49:10PM +0200, Kory Maincent wrote:
> The series is based on the following netlink spec and documentation patches:
> https://lore.kernel.org/netdev/20241022151418.875424-1-kory.maincent@bootlin.com/
> https://lore.kernel.org/netdev/20241023141559.100973-1-kory.maincent@bootlin.com/

No point in posting a non-RFC patch revision if it conflicts with unmerged
dependencies. Since it doesn't apply cleanly, the NIPA CI won't run on it
and it won't be a candidate for merging due to that. But, if you post as
RFC PATCH v18 instead, you make it crystal clear for the reviewers involved
that you only request feedback.

