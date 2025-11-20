Return-Path: <netdev+bounces-240452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93287C751C5
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A824F361406
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539D32FA1A;
	Thu, 20 Nov 2025 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LF+zFlFE"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB13587CD;
	Thu, 20 Nov 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652993; cv=fail; b=KoGPmBFd4Y/tIABKriVx00E/Z+tttdfInmdqtpY8VZLVrsspQRP3Q2wSS7U2KvryGm2VFYXhVNWs1f4p7x5mTbepO4sJU5JeZXLLuJXSafO7ROpluvmH8jH+yif4tXgk+FlDauthjx1aCfN4dYEYwQhurY/2i2kjWCUOrTHFM1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652993; c=relaxed/simple;
	bh=gD/rM1Wt8vco3742abkNMEYqGgbK1k1cghP+887Uqbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOQWOSB60cpeErNICMV8eVUBteClnZstz4H0ePzfFXc8L49A4yC0Q8O66VR9DfnfkQSGpf+htIGTQU+XedpR4+5vMtXxQHz2kIV65m3QqJq267WvYIoZ7jR2yj6HjAoqlrf9tC2vWtx3qNmLSyZx9hTjL5jANT2VCGws1WPouHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LF+zFlFE; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCsHBy+3McrxFGbIme1U15au0HKY2axO0Xv6qiIuT/QRqQ2EJQZZvuixqv+K65DlHDlHV44UUMY0TyuO8sQdCVXfexXBub+c4Z8Zm7O3L3ZmZO8bebhJW1VfHNgf9JHeCJVgVNw2u7PVI+0CIJpkcnta+VGmINGzJf6yiycshq9UsF7nnd9mL+Hwmr8d4oNG/smpbzOedxM/kcQQHVTJT9hu7NNp94KNee0F+NoydjpxOjLTfOowjwJpczu/lm/ciAFgh8gSiE9n2OAe15Wjn4an8ljH+UhqEhswhhsi3hIttvshtuYu9Y/R3APwYrZUiAP9TPSq/ODgKpdLPxw8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpCAtuH44YzsQSxOV2jZuglRNZSTX02sL8meHguJIhU=;
 b=WhkTuModDTVoOUffcpZpfNpd+UJMVagpHHIPZ9akdCJd+Kpkk7rXPvE8i0/cNwKwZvjCbni1ECu+3/pMMj5SjWBKChQNkqmPu27Lf9u1vcyMhi8ky1GuxOuC9nBOmQ9xDav8Y/KLQkCnXazY00ZsvgT6uFDW4GDRhoU5inGsop7npcsKuToJcw5vMRXcRpXmOZffPs5d9ULSS1ehEUmscRhlrd9HGObygpZgF46x+nWAB7JYsFHS90CHWJSp33gciEFGeCBDNJGv2eUXBEOKzaQvkHZ4w/hfQa65C+CeLGyZ5MZwlb/oYeQCweWkAJsatDAi7zyKWLmtatfWzFVH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpCAtuH44YzsQSxOV2jZuglRNZSTX02sL8meHguJIhU=;
 b=LF+zFlFEsuiVzp6AM8Y4c+H1g2RbivAIUSjtelAjQElbLnmM01H6Und+4s/oEU+rcK6eUj+lfO3PL1Vnd3bN81E+iyaLms8FpBBc/NJ6afnOrlLeQSaWo39vNCddEOka/5FlSXa1FtT27/tjsgLMd6yZBqoOlMjPQCmAAblq878cPExWrN1IyXi3vjruAZojqMyhWkD9wIb61VtKPuY2cC9sYQJ7VqXBFzVc2unmw+NDBeXEH+m92HBW/kelkc4SopMXHDZn1H8Sc23o6SnPo3HDDNEKU50ecaOE33ilTRqFwnqwTkQWMI3Mn5g12Pl9xOvktax4s9F92u3uzAB4qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by GVXPR04MB9878.eurprd04.prod.outlook.com (2603:10a6:150:116::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 15:36:26 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 15:36:26 +0000
Date: Thu, 20 Nov 2025 17:36:22 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20251120153622.p6sy77coa3de6srw@skbuf>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-8-vladimir.oltean@nxp.com>
 <20251120144136.GF661940@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120144136.GF661940@google.com>
X-ClientProxiedBy: VI1PR09CA0157.eurprd09.prod.outlook.com
 (2603:10a6:800:120::11) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|GVXPR04MB9878:EE_
X-MS-Office365-Filtering-Correlation-Id: 4882ff91-d8a8-48aa-f88e-08de284a9110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92lfJ6Z0EbIfxIe46X0ufX1gZGmzBZWdPunRvwhwqGezOUCmzrF14OnwWx+k?=
 =?us-ascii?Q?gxtCmT6QejKtIKEG3CVLZMgMQnWPthJ9MqtZpvK0oUK4KepNVtxnyLaZlWVe?=
 =?us-ascii?Q?ujkXimVM0F834bz+r2avsGFkqhfPM729sTOTwEmTrq91U7iWRfr3WMmNWRFZ?=
 =?us-ascii?Q?vyNcN25fei9mxMOzUON76nkXriYwvBXv1D813C+Ec6CCMfGBL/aBicgw5NCS?=
 =?us-ascii?Q?a7Qs2Q6wrHdDOhl96WbuREMWdJdKm/BBdmymOibuasSZya3gqxFzwZomWSGv?=
 =?us-ascii?Q?tR0na979CfIz5PlJQf26QXD4i642V32ZkIHCs3lKnbLC/P5J9EhPW8MaZNjz?=
 =?us-ascii?Q?OoyqOL2lTyUMiRwZHlTrnJDGmwDleA50yTBknf2yi02w5nSTPLlFX3+e+Coj?=
 =?us-ascii?Q?0Sg+d7GHJI9IL6XWullKiTNJajcGGeq6+Nhkn3ObsBlnMskvbT6Xz3cRlxer?=
 =?us-ascii?Q?umEh0tn+/U0qIgXLiXWdXOAMYinH/6pbsCsX9VJ0l+Pyo2DjnmPpr/vcFzkG?=
 =?us-ascii?Q?NgEZo1tF6O4VPkPHFBhVQESaW+iwOBNbLpXYPv2PpRv/wy3prNao+H2byHmN?=
 =?us-ascii?Q?MhKcK/t1O0fhMqWU6OlwzwlZJYz/HcYAaQxTmyOu3cwb3wYsL/dKadCdNNFL?=
 =?us-ascii?Q?o6yCDIliXEgG3FcbGCimSSJ2U1aesiZK/nLwaD8Jaz3xLAaZ7b/qHS0mlBZB?=
 =?us-ascii?Q?pTVS39Y0Gfal98ipoXFxBL8zempSasm+W7SmXIsaJ/+Wb8ODnPG9s0RmW3Uv?=
 =?us-ascii?Q?OtrcjvP0kCGlIzNhERMT0NtszCdZdl7Nw+JtbHh0lOiZkDB/86wNsLPV0KUJ?=
 =?us-ascii?Q?P/HCXvbzrTj5bAFCvxm1Dnk8MFx8pSl0PILWMA/O2wj1vcKJwTgdfBnfnBeE?=
 =?us-ascii?Q?/pG7zvsaJ5ucFI/g8+myimK+RFJ4otP1F4MfnDtijqFd4Fe7AHQ1BsjNC93m?=
 =?us-ascii?Q?mSGnD0PQ+9bDDCRguesyQ5E27DbJ0SLa43ArYHywewhAL5O1MBrdAeOfYwaJ?=
 =?us-ascii?Q?USw8mbApheq4lbS9CpmIBXpsqdRApgSCXyOZZEYt5ZrGz+55LNDd4yJKO7CO?=
 =?us-ascii?Q?0DdkSoK4AcUP4njLfRsCpa2ocKsw6UKammMmWhV5wenB7oo6zL8fvS/8xDs0?=
 =?us-ascii?Q?DD9vZofvhRgOGGd6itvTQ9LvFtWxZxZN3niptD5v2uhEpIdlTPQaVL9Pa3s6?=
 =?us-ascii?Q?gxHbEMJUSShIvT309VkXnpXyuQD+IzCCANOQp2YipiDUJ4SbdNLWoPrSUuUv?=
 =?us-ascii?Q?EmuoxqeauDS1RA8gRAPlrCIM8AGnTmUa56hkbiDROpJ0IHz02s/2mTDPZljj?=
 =?us-ascii?Q?skDzH+joFQRB+JEYRSLV9wpGnQ5jamspzeY2I2vbePzA/s/DQ5wfzxFwK8Er?=
 =?us-ascii?Q?dgRTxUeP+AsN2Y/weURyMNTaxnmT9QjWq5NtfkRbw3oLHSPqiJk3fTxhwbyw?=
 =?us-ascii?Q?PSYwjatpmdA7bNLEsVptuuwj6i3UWnsT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ll3Ya3PhTVpjn8ohCAGpc5vK2aa+n3uRbboN9uFTei1awvXFfvwAceG0IGu?=
 =?us-ascii?Q?jRKr2VcQiy1q2uB0JZ47DFTJ7ymWgoCtO4M31x1vW+OnO1Yme+VyqYVHkSSp?=
 =?us-ascii?Q?QVlkH3EZvdjhh9/MtwfmTUC32HqMLuonP6G+d3BZa+E41xP+WOclK5hGqEL8?=
 =?us-ascii?Q?pk+CX20LTjGIkqkvcgDmsB1V+zFfT2DrbK8hRS46J0Uy7PvMbIsVAIx/zRk4?=
 =?us-ascii?Q?Az4tdDlnwCt3lJOWQ3u7pb3YTvn7K4DQEr29Or6ZOz1Q19xvIbKLcpxgI187?=
 =?us-ascii?Q?lLN0JNGTpisQzdDhtrQ3AVnRNEW6ka3rqqJ9W0w1CM8nC5g1lcJgxfj+dUqc?=
 =?us-ascii?Q?OrQVaPCqORVD/puhkLMTdm1lKlbR9V+VN4ZNB3zYkhblJ3jcgWcp6uqXP4L/?=
 =?us-ascii?Q?f+dYVK56SU+QK6MmhyOJz2YpJFYpyPi6ydh/XypSSGkV0kqpHtsBwIq7BoCc?=
 =?us-ascii?Q?SeSuLk62gM562Z0g1q75PPIMTnT9Ex7Lpb0s6f0OqVYyG78X10VlgxQ7/veS?=
 =?us-ascii?Q?FvN1RulV22YO6lFpYo2n/tZ8MNMbnhjqkbrFC1IIArKMMC1DtLvvS+0dDc+q?=
 =?us-ascii?Q?OO8Ag/gayBt5ZOSl+nib6vA+cDt9QLfv2arciUx4tcN5gWBXZ7VnLfOSkxAn?=
 =?us-ascii?Q?i6826J+XqxoQvQoFPBirrbpjywUXIlVjOfoDUqpO3nDpZRvB5WqK6povr3+w?=
 =?us-ascii?Q?M2GdShvUabn2dZk0M/u2d83BYuIfYvM4preyZA7fs5qgvS4+rdvKZDakHP/6?=
 =?us-ascii?Q?MpTpyazlFg/GIrcn6EoL/0K7Ez+UutRJO8MU+WqBu/2NfKi9Ha9cS8lScG1O?=
 =?us-ascii?Q?dFrDTJ+4xz8AFZnHmhjRetiyDyrxIFQkOqx7hrzuz6bXAhHujmrMJyCOCEm9?=
 =?us-ascii?Q?6ANTP6nweEoaKYaKuXAETynfd0N1Fovs5QpZ7aYVhZRkQmJCzwif6InkOgMl?=
 =?us-ascii?Q?9FUh41TkrmM/2fK47OFftljcYlwM9VNP7UiYUSTyfiuBh8wnwzYB2IHVKrtm?=
 =?us-ascii?Q?XOjQDTw3END+Qbzj1YTNAcTjVCw83n1j//2yVxljH+CEbtjOx53XN1ibSq45?=
 =?us-ascii?Q?4ngCYBpJbKdpgbpkmah221OrKJFbYdMEvyPtIy0z09owxCoQif79Qqz1sexi?=
 =?us-ascii?Q?T5BtRPe7IQ1wwmmonDZ/t+beqvfaRHg4nI3SCBBLKGUizpAFE/00BRRz41Bw?=
 =?us-ascii?Q?oQRQMa6dOAfPXU1uxUcE89/Eb9Dq3NYrhMezj44b8ukfb8wpyVJVVUjzbPkT?=
 =?us-ascii?Q?mv4ox86OklmMI4QsbRdi1YFEP91mfINcGEW+sXTOV/VW9nOzxWVfm3SH+0wv?=
 =?us-ascii?Q?z1wRFZyPDt8KH3wLeqgJ12O4/yg2sMO2W33vdEDJDFEfka/502u0LhKvFOxV?=
 =?us-ascii?Q?cLBFKYUCDI2znxjiZBrC4o0InsuMNpjOUY88jiXEaFJ7rBGGhd805C+3phVF?=
 =?us-ascii?Q?0aZu76G7mIVL9GqvsHgRnDp7cXLXNh5ICV7hoyd9hfHBJo0hk095qGgZ5Cfc?=
 =?us-ascii?Q?ktUV/r37MYMkUpZc7l/Dtxrk92Jhy4mhUD09mFd+vdYpO8gWxrKDfU9J/Rv8?=
 =?us-ascii?Q?ID4UDFXwyv4HUNoc4krbiAcKtDiuggt3g4s6wPA4tySkauH5CpUZRDBSBE41?=
 =?us-ascii?Q?KwpFrFog3nk4yznX9IrT/YQ4c0iTZjuN4E12R2KtluXJATf1Dp8Xw2ivHTTy?=
 =?us-ascii?Q?FvJ8/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4882ff91-d8a8-48aa-f88e-08de284a9110
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:36:26.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhLzx5vq2F+ZrOQ/Xh+AqzP9tIWa0FzQCCuAmCBpo1SelTjY/td+CLM2pgejZ19VwqpWos+lWDQwpTPMNsDSMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9878

On Thu, Nov 20, 2025 at 02:41:36PM +0000, Lee Jones wrote:
> On Tue, 18 Nov 2025, Vladimir Oltean wrote:
> 
> > I would like the "nxp,sja1110a" driver, in the configuration below, to
> > be able to probe the drivers for "nxp,sja1110-base-t1-mdio" and for
> > "nxp,sja1110-base-tx-mdio" via mfd_add_devices():
> > 
> > 	ethernet-switch@0 {
> > 		compatible = "nxp,sja1110a";
> > 
> > 		mdios {
> > 			mdio@0 {
> > 				compatible = "nxp,sja1110-base-t1-mdio";
> > 			};
> > 
> > 			mdio@1 {
> > 				compatible = "nxp,sja1110-base-tx-mdio";
> > 			};
> > 		};
> > 	};
> 
> This device is not an MFD.
> 
> Please find a different way to instantiate these network drivers.

Ok.. but what is an MFD? I'm seriously interested in a definition.

One data point: the VSC7512 (driver in drivers/mfd/ocelot-spi.c,
bindings in Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml) is
almost the same class of hardware (except the embedded Cortex-M7 in
SJA1110 can't run Linux, and the CPU in VSC7512 can). It instantiates
MDIO bus children, like this patch proposes too, except it works with a
different device tree hierarchy which I need to adapt to, without breaking.

