Return-Path: <netdev+bounces-238332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39034C575A0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F03C344171
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7AC34AB09;
	Thu, 13 Nov 2025 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SZWDjLjr"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57034D395
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036045; cv=fail; b=EO9K9BP7PN695vpZV1xIrS4aI9G5f5FSdG11TA9xrfm5qu/Ka3XYu83rcMkOA6R73L9sDzLMO2Djve9ROLhEtrFKGncIIbuY0r5GvebFZBDgAY5+sVvwQVut77ZIp126XGmZPR5t0SlOFqEcK9h8DOtXSPKfLdjxky/EtOUILdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036045; c=relaxed/simple;
	bh=WC8lccvuuxfAtyR/4djobhQj2HGPboyihs6COVDX4iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivuaF5KLuR8Tj5eGMTeIqZjmHO/1paTEpvbBs7PSTLMWvL11IKVKzXCq74iEhbvnO45q+DSHzjzj7LlL3kiQIMtv8mudl+MVY7YMdXmDcL+p57jp6G5osgtFwWWQpd7E4BNn6POW+EGA/j/OYjO8MQ0LLycfuVyz4fXJS3f2nbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SZWDjLjr; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7QylL1W0jcyM8WK7wfcGaHdbxQIOucm3vP/7fauiTxCsQ4/zQob0iSiQ4lU7XI7JA2yLXZgYxrivTrV3CsVbPQUJcSnCwD7k26c+JBfcQx/4tEJUJlSavXC1f8hG87lfc4pUpJ00DU6jhxaetE7JwC17aKOL/KaS5yOWSPgD7HIxwyjfr8XUa/WdzBAOeHSX+Pc/v4NRsCrdqxo4UIjQLqX5k2UWMcdw0udnYG6C1K4eGcQKJRlEzl37+bMvz19I3fi/bPbCETzglHpYevQQX6ztp25nDvTOQYj0xPgRcVi7upPf7OggaFRlh3SckxXD1tSLIW9/qNEvLyo87cZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpMx0FDV/Jkc5U3QYRkcF6YgGv2irxXekz0vVXuMBvk=;
 b=d5B+n9Nf+jviUaeI6OULforDIuY2OCGg+IcUbvl2tZuYJCvHjUJT4dD2qyxbyjULxWOJi94Wk6NE09b0R4nOnROtYNYi/b0tsr0sVubc4ebJT2HEJcoI9exnjJHmz/vJiz1vq8W8wWNv/cNcqTcYyjRK6wfp5jq+VEM01Im+gI1Ec83osoUbHnOMHEDgOaZGEtVtrVUNrg0iF1R3dOaEh3F6lCWOmhVkrVMMcNMQcpuUqNem2o6ne5uD8ZTwI+rRm93IW4V/Dou0lVkez4KMHicGhq49mFrbhtM6XRc/L9iaPNh3p07q6fHyJyVkXkrMz74uNjyesYN9YRa39sIg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpMx0FDV/Jkc5U3QYRkcF6YgGv2irxXekz0vVXuMBvk=;
 b=SZWDjLjr8ZszotIh3FBApEWU1vUcAzELc02rnis0U2K6bu+ZYP4OJfDefqnP+q/8UCT29v+T3SyAZIPNE/uBKEwVBCTFIj6kfqsOw5UosD2/cVjhViQs6ybznVQwkl+d4ANmBRL4jv6uVYdCNOoFFKnSTZjmripETxSCw1c38hRoGLEb83m547T6IvwgHPg3scGpN42moCJk9qaYjoWpk27nJE4tmCmBLgynqkSzap8ryjJVjXdcQqcA7SWXgjZVetXsH5jewj/EAICPXSjbwLoMICC9uPoyytXWWpaqkkkLQOlCGyE5jy/lyqsr7QL0/i0yCHz8dga10RNYTzN8EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB7134.eurprd04.prod.outlook.com (2603:10a6:800:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 12:14:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:14:00 +0000
Date: Thu, 13 Nov 2025 14:13:57 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 net-next 6/6] net: phy: realtek: create
 rtl8211f_config_phy_eee() helper
Message-ID: <20251113121357.uu3em364s24ehm2q@skbuf>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
 <20251107110817.324389-7-vladimir.oltean@nxp.com>
 <56b1deb7-2cc4-46fc-9890-bb7d984bed55@lunn.ch>
 <20251107143240.7azxhd3abehjktvu@skbuf>
 <9cb3808d-341d-4db2-90c9-12bf412d4a48@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb3808d-341d-4db2-90c9-12bf412d4a48@lunn.ch>
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b73063f-1dfe-4427-1164-08de22ae20cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7qOQaNkpkXJI8BBSEN2/ih99TiemChho7QVaeGi0MLECiJpWjvm75AZQSca?=
 =?us-ascii?Q?QghOREozLY8EOFE38RE+DuOccn2jHdLQe0mNeSw4pDKxE2j9lcIBblVCjmcq?=
 =?us-ascii?Q?wOSytU2tKSMpeJLUDB/bMh7NxtyLTIGVTYgeM+uYlFzuTyYy09tBwyQvAHRt?=
 =?us-ascii?Q?u3gid1aG5Bb5mwh1QBPRmIgTGhSoN9YKTxuXvYCN79W1JolXAnZixTmjTpsl?=
 =?us-ascii?Q?Bua9CpIQw8Yqd2OMPB15/K1svZx7efHixawDnOxe9ifC/F+zWEoiSPIh4SRa?=
 =?us-ascii?Q?jiaex4cv+LO2jy1r3PDz7+IDHXhmIeEmS9PaYVR9OYXNfk4e4eF7lyQTBFAl?=
 =?us-ascii?Q?3Rw0U93GD7sm4bXppAiAOffGw02V7cjczrQ6RWfRencf/WWRxGi6WiDj2P54?=
 =?us-ascii?Q?Zr8+5AW8S1ixGHgheq230plAJ9VpYP+4bAy//2o+1Bjf/UYBuah5a3GOLqzP?=
 =?us-ascii?Q?037dnIi6HjwyOOwFfyK5gRsPZSI8Qh7gaB9HCFnJsKivq1Kupq0C9k1JsjeS?=
 =?us-ascii?Q?KuCg2f+PMhEnyCJeVsynyIMZNTahQsHfQMysjqc5iccA+uW8fsxbaD3x6Ua/?=
 =?us-ascii?Q?I2e24wElfOgH3sUEm4qqcT+PuiHgke0XZaAdgL7d7sf6dqum7r7GJ4mmApZX?=
 =?us-ascii?Q?QO/InYP2WY4K2sUerz9ovB94Ud+4cTJSEGRX6hMKZROtm2ZGCkVeC3XR9Q17?=
 =?us-ascii?Q?bZ3dWta5sD3aLpqTyLlADt2BhKTYrD4R2Ts8/sKn0xf2kkAwTQm47rdMrmd6?=
 =?us-ascii?Q?TSilKOeDAsmLy6v4jI4d2DKB4l1Y90VjdvXxLd2pMkl+JOdCRIqLkihPUgaD?=
 =?us-ascii?Q?8vJCF9DKKpTFzwhkJU5/IZmcEdGoXWV4Ec+qy/HN2CQbXu57HVC8uuw1ny7e?=
 =?us-ascii?Q?7SDY083YJU9LfBSlg/s5zx4KKBVk/pOgPhaXNy2ndo87ZG5B2gsphm3pw4q5?=
 =?us-ascii?Q?Tt6UW1wHEHyzdX2ccp/kiOcxlF/Y7JMm4ePAAbTjOweimsJ62xrnvTxz03gh?=
 =?us-ascii?Q?sT2wIdh1FMKVMLSlrL9c7KAQi9wFKPVLjR5+ONDLiHpvBwLvFhSEa+K391x5?=
 =?us-ascii?Q?Hk1ym/CC45zMCBQtKP1aXX5Wbjjnb1Q8/DCaNv+gh1djNY/YMHXyyC24/K1/?=
 =?us-ascii?Q?3YYypUtCdpF+wCWxLwwQGNjtcAr5y+04/JMSZqPYCS8Kww1Trs+/CTbrkl6n?=
 =?us-ascii?Q?Lep8hIeic5JiaXEHhYsZ4iivaFxJjPvnHynvPt4hcTuzYqsqdyKR9IR22Z7W?=
 =?us-ascii?Q?PwGdC9m14cCimfvdSIEeI8C87zw+VDvFmsflPFm2MY/v5WI02uhdxzlR0mOW?=
 =?us-ascii?Q?HvfLgFxiYM2Lh/KLo4oJmPN4yN5AllFZi+MhMVojDJZXKZlQxYfPsfqx2qqS?=
 =?us-ascii?Q?Vi8RvJ9JC7TVrrMdYA9IlQbiq2KNJx+NJzQd+Qp6cZDowlUt7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ruSQ5kZmWhLWHAtpBBtuchRtSiirnMcunq7Kz7Uj4mFy465DWxOiwt13RY34?=
 =?us-ascii?Q?J0ewY5FtOS3+tNPuOgiFdzulEsIWcnmGidgOYyNpCPY8KUiTvarvnYrRKXbQ?=
 =?us-ascii?Q?q6285fTXMr+4IWwiqrBaMSisGSStXu7EjhwfG9RE2l2vEjoGfvwf82eDWOZ1?=
 =?us-ascii?Q?3HV3QxJ2D93mO1w7X84+AvW7Ndrj3VInIpfCED+jSwrIihV0so+Ib+QkiEXx?=
 =?us-ascii?Q?ExGxmXQ3fo3Ms/QJNa56IFPGqTM84oUBG2poWSGxCqiwo3pKUqMp4v5w+P7c?=
 =?us-ascii?Q?iDfEEMO+uYtJCwhsp2NA9RLoGg5pFCIb83Ae5Vd33aIMNXzEGLQfEhSJavDD?=
 =?us-ascii?Q?MEycaDGG2MUM8j4yy8dSKMJSsqz2hvhsawpfqCm5UfIEsAxcDtCJcOI3t8Ev?=
 =?us-ascii?Q?1cRHnAXjgEnkTe1JQoayHNwcPWLERcb+zOhlD/17+ctOnZRB0dm835jdmdtE?=
 =?us-ascii?Q?B3Kr/k+OrxTmENz+bc5NB8236OpJX27ZmFOiZwwJfD1A7U2UtUlE8AlAP82O?=
 =?us-ascii?Q?fMkXM/Jgl/fZLCwI5pyhCdtBIEok1YULRc1b6MR2I4TG9E/5O/kbFlRmkUKh?=
 =?us-ascii?Q?JTMS6yFaZoBC9xJvZnxujK87YsyYxIHF+Kbdln6HOZmppdz77WMA8rBmH0Rk?=
 =?us-ascii?Q?TSNqzZTqAM0xZiqNhaesf0HngGt9B8I88dwMKbNr0jTnfUz4+LNIguuTn3EP?=
 =?us-ascii?Q?48B5dVI03/hs9SN/8aOlkp6igvXbK33E1f6Wxto4yxAqp+4wta9mx3iTRMSy?=
 =?us-ascii?Q?tC39bZURKRyTIItQ5thI+ZN/iUomgHzmxE269So0s6+kiPhLcy7T5NmOo7mq?=
 =?us-ascii?Q?Rx8UVm1LDu4ut2QuW3LfObtc6fW7DlamcOE59S1cty8cE/pU3JJsDGtcufOm?=
 =?us-ascii?Q?e/xj5n34aLRNy0ACY6U3nm+I9qyqwcSzMMPdxwQkdOrjFdLuQqSBkryDj0N0?=
 =?us-ascii?Q?mIgrKJ6fz5kqvNNUnQMr3XvQm8M9mEHZ/VblU60i5WqYTHrnEWP81LTk/Vci?=
 =?us-ascii?Q?tnA3GbuJf7jYS9TEt/sa1YuVkUmt4MqMb4StqNWX+7OzsWTJV0JrKYydCnOI?=
 =?us-ascii?Q?8BU4mBPq3o4iwishu7pQSpy2o8Ui9CXTfDJrtfPB0QGY0lwhUtUvY3Zbt/+D?=
 =?us-ascii?Q?4wK8xgtoVx5KjqiZF1hu3adLF4rzZZlTFWOTs3ZbkUkWJUXrTB6KdMw+rjN2?=
 =?us-ascii?Q?QB++zXXBY0KxKabFUkmTrRt2JLWZNDTuCUjlFXKCcodTFrpUEFOCt/b4UX53?=
 =?us-ascii?Q?sb2KqZBq5aPMo5UapH95lofglXOFo3Lq5kJPyrjTGA2Lt4BU0m0ZTnCBI2lO?=
 =?us-ascii?Q?xJICmiyc0HKIwY1fijyv9athpNLCgbiJvMicj0TXJBl1klUStSQ4bL26MR+A?=
 =?us-ascii?Q?xQLpeN/DlMZOCiXbrKYNRQKVVJz5fZnr0D7U9c++1YbjN6Asy26EcAf5TZm2?=
 =?us-ascii?Q?oQ40meUGyzIPNv7Es5RVF9CVr0VzZ90chi5xybt0KddQJTxpKXGZdzZ+kOT/?=
 =?us-ascii?Q?rAFBMtKIJ0Zssc0cN9GhU+6bIGkNcN2nSaME4FzqqCA6bDGHDNzsM/t63i1c?=
 =?us-ascii?Q?EtCdZNT9N/LwZVD7cOwKPDma436mVp7qssT7gpTFT/ImQdBqzqfhWEE/Odbr?=
 =?us-ascii?Q?7JchKsvGP96oxCWnOeWpBkp5hdqPEjN116ahOoBXX+DXfjJ+wVgzRsVcjXcR?=
 =?us-ascii?Q?M0rW0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b73063f-1dfe-4427-1164-08de22ae20cd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:14:00.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9k9cHBpBCaJE8eaxYib9I8DPmbrRABPDrhU+0DdZdv8x3e7gIdVlvCvVyZ6XX2IJZ/QxdT5vJJXUA+Otc1rEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7134

On Fri, Nov 07, 2025 at 05:18:01PM +0100, Andrew Lunn wrote:
> > It's good you point this out. Somehow, among all transformations, I lost
> > along the way the fact that the soft reset is necessary for disabling
> > clkout on RTL8211F, not for PHY-mode EEE :-/
> > https://elixir.bootlin.com/linux/v6.16.12/source/drivers/net/phy/realtek/realtek_main.c#L598
> > 
> > I checked the RTL8211F datasheet and it doesn't say that changes to the
> > "PHY-mode EEE Enable" field would need a write to 0.15 to take effect.
> > But it does say that about "CLKOUT Source".
> > 
> > Curiously, the RTL8211FVD datasheet doesn't suggest that modifying the
> > CLKOUT source needs a soft reset when providing the steps to do so.
> > 
> > Anyway, this code transformation from patch 6/6 is not buggy per se
> > (even if we change the CLKOUT on RTL8211F, we still get the
> > genphy_soft_reset() that we need), but very misleading and confusing.
> > 
> > pw-bot: cr
> > 
> > > For the Marvell PHYs, lots of registers need a soft reset to put
> > > changes into effect. I would not want to hide the soft reset inside a
> > > helper, because of the danger more calls to helps are added
> > > afterwards.
> > 
> > Ok, I get your point and I agree, but what to do?
> 
> If only the clk out that needs it, i would put it in the clock out
> helper.
> 
> Is a soft reset expensive? Is a soft reset destructive? The marvell
> one is both fast and does not seem to change any registers, it just
> activates changes.
> 
> If you think some other registers might need it, i would probably just
> do it unconditionally after all the configuration, assuming it is
> cheap and non-destructive. Maybe add a comment that at least clk out
> needs its, but other registers might need it as well?
> 
>       Andrew
>

With the risk of being unsatisfactory, I can't answer these questions
without completely throwing off eveything else I have scheduled to do.

The patch was delivered by Clark to a customer a number of years ago,
and the customer hooked up the scope to confirm that CLKOUT is disabled.
The datasheet doesn't suggest that genphy_soft_reset() is needed, but
looking at the BSP implementation, I see we did it anyway:
https://github.com/nxp-qoriq/linux/blob/lf-6.6.y/drivers/net/phy/realtek.c#L427

I think the safest thing to do is to keep the genphy_soft_reset() in the
CLKOUT configuration procedure, regardless of PHY version, which is what
I am going to do for v3.

