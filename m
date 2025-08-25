Return-Path: <netdev+bounces-216492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A12B34232
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A8D1A860E6
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2F12C21EE;
	Mon, 25 Aug 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DT7VHQKY"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBC1279DCA;
	Mon, 25 Aug 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129637; cv=fail; b=kpTpYZ4V1BXYPFf8XuWCXpvdKSlVqzf6cO9jpisKEI/qbXfkcw3w8cfS2VOz5cQwUplttvOjN+jy3MiuflLnuOgB81dXU3zm2WenR9iCZPhnrs033qtRCrRWUyws6oZnV6kfchmqF6eIV95Hn45aSVagbM/F2JGbrW11z2WIpSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129637; c=relaxed/simple;
	bh=PorkLJJlrfFyuf/mSAAKEo1Wsv82B3o1FixRdz66nww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o/LeoSEmOEc3fDW5mhdDyBiSuSWnRA75bsMunAmVZLP6cb9GgsBodjuvLTbtDuo1OdvED9zkPDzxEiR17Ug9msBBCYBFYGC4cN6Z1B/y81YBrxaOUVlFCvKrsWDaUv5kw3lr3v7Oe5inggTWL6WXctjAiQkIo5M3nbDecYjE1Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DT7VHQKY; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stSMasvbxG9yTN+hdnHACj07eX7Cjj+HjSJgC5nfdagqctp/HLMz00p/3MJzTrgedxyZZICPFf9h4xQ/iuSIzDJpvAtoDkoYRcNiSrzA8mlNiQ8yZP32Vqq8XZXrEHv9PKG3gioX6K3Eta+Qv1ReqxsowU7nx7XPcKbmf9AhEkVNpipsSIWFopNr6tvqtFFS6/XjzwfWuvV4VrcdlsGpk8a5pwBZyIFBK1ZPGeMpFL4vBrhp2dzk4x820Y1XdXgsNXlFr239txo93L3NR3E/dfHoZddElBx3QKl+pMiIJXPXdvUr9CKIX+CNEyMbuujqh57UmBPOaNchKecgDSLSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNlYSAZA4sznB0vUBRTf18qPujJpRuKiWE86wewSEZw=;
 b=mtZOhkJf8ojUff3LAnGQg+jGAOYXVyCL3NjA2arM6dRhcFNh5BCZgNGsXyoLDwcobMA9e3j2qJva85lh9CnHY2dSNd3wLUkoNTnlb5wlkDZgPdD7rYQlngCf6IQ9j7tKKDdfA24k/tumsexU9HoCnDJRZHOimoPGFFq0QI+ZauxrJWe4HLUP8nY72akCFHHdsad4JyLMGj+zCZ3FqoMYJKQhzEgLLB22q9w8MiGQBUra9e3eugy3xqnis+YhqAlKi8vFOKqJ3XyghJVXg84CmmXcCSfhEKqwMQWA1HBi8Z0uzWrSbxuRKoTDL/9y+YtnKS3C6/nqd+BpIfSZo3hFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNlYSAZA4sznB0vUBRTf18qPujJpRuKiWE86wewSEZw=;
 b=DT7VHQKYlDEmyzeYcDflpPm9Mcr4jXQCbyVtxJeooN5RCZHjFKRVKU8D2RqmIu9gjdMlaZEGQ5ygP+bq6GhIitdFBWNfn/jgPfgsbIdzG9i/IFkC/iOGSSapOMmAAxxtTFwJlQUf9APHXl+DDOybgFtwJGmSkba6crFximKyCq8P1DSPA33cDlorN7IjWnZhR3sZBcSzPbXfCzzEVFKKu+WkX/rUQJAR8To0bSpA09g5zDwn0RVf1bVB0/MbYQmY1Jvrqu/eZbNzX815ggVcZXqpNH0SfH9BxMCD3450m84/6S3h2QPEAamIbp9ATeFZUR/rydiGJ+kgZo1qhFfkNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 13:47:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 13:47:12 +0000
Date: Mon, 25 Aug 2025 16:47:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	rmk+kernel@armlinux.org.uk, vadim.fedorenko@linux.dev,
	christophe.jaillet@wanadoo.fr, rosenp@gmail.com,
	viro@zeniv.linux.org.uk, atenart@kernel.org,
	quentin.schulz@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] phy: mscc: Fix when PTP clock is register and
 unregister
Message-ID: <20250825134709.kk3tjc3sxuyo57pw@skbuf>
References: <20250825065543.2916334-1-horatiu.vultur@microchip.com>
 <20250825065543.2916334-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825065543.2916334-1-horatiu.vultur@microchip.com>
 <20250825065543.2916334-1-horatiu.vultur@microchip.com>
X-ClientProxiedBy: VI1PR09CA0096.eurprd09.prod.outlook.com
 (2603:10a6:803:78::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a48d864-6d45-4104-a032-08dde3dde4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PRL29yF/h4Gu/GQZXoEbTo3wn1byTixsFoWGE3DtxwJ9SRO1Kbjzq8gHgpRX?=
 =?us-ascii?Q?IzFIya350KOIC30myllXzmQmNkCGv+F7LJDtJ+1sn/refEDfec6g8vnA2/4z?=
 =?us-ascii?Q?Jpdo+fbjM8EjXBJu0MZdEBFSIX12IN935eYO9UcM4q8Ip++/l5FWPIr5gmxT?=
 =?us-ascii?Q?UlYrUU+q9UoMjChdKILUHC9THzT9eIitUX+hCcWIqgVS9IGaURSqU7XtdUdv?=
 =?us-ascii?Q?GRbvR/IaixzUI6AFx3WWM3nnPq8w5an83usf/6PCP06djfXPGhI92yark6E/?=
 =?us-ascii?Q?fb90uAoSugqSDQosbTFhuLvSzm0RH+4zqUh82ogd/CVqBv60bhkUDXvr5gj1?=
 =?us-ascii?Q?UogEyk8GCA9H632futRJNewp5Tlzfq2pffqA0I2M7vOUEqw5/wl5CDV5cX6I?=
 =?us-ascii?Q?fUggxMmRegreRuNATptoW4ecVynW5VioXCeDjWJMhkHnQc10WbTjg+W97hIX?=
 =?us-ascii?Q?BAc/c+ihX9BA9oyE3U5YMmexQ5UaH15uNQYWtBUTmukBge9Od2iPYkdmckuL?=
 =?us-ascii?Q?rzVSPa9j83NPeREVSvq0hCeVUXREXk5l06fNZRkh1siudyeVtE3FrcN/sNm5?=
 =?us-ascii?Q?7knCKuFaihIQUL1lI3pih09KtsIJ/HZwmh4jTZUlsO2EhCkqnUYmVafjphzg?=
 =?us-ascii?Q?22KITeVNDVL3Mkkbzv9PK6UIOmdDvYAatzx/BZUFP8HkGX5lVBxf0apW9/OP?=
 =?us-ascii?Q?AxxX8jttyoExagjoGL1ChoLMlXF3Pe0S9E0WXGXOsLl65RNWBpM3Sreg7GmT?=
 =?us-ascii?Q?mplZfQ2Rl3o3c0MxIAxCOysDPRjWOAtJ599mBTjn0SBANmGWyILr4axXHGLE?=
 =?us-ascii?Q?Btrlt5UOzvzmc33iewprj5OS1Tv7kzXSDdoY82g5FRc/C20HbDIf2INypGnB?=
 =?us-ascii?Q?HtZBXDoA6nTJTiQ6ySy6L5N9kPR0BefLKHM/RH6XdzSWLmp7pbJXDXq5t3rH?=
 =?us-ascii?Q?u+zUQQxhX5TDv3zf3BxMra0iYyH43kW8sWyv5WT53zI9TyLLZfiMtDDxkRpg?=
 =?us-ascii?Q?2uvCgPC1K4DIFWdF8Vht/r8HGtIuLsHp51BuaZrXoJA26gibCRG8ctzCZxPv?=
 =?us-ascii?Q?eY9KIBbmvgRWZLiSi225noXXes5mVLXPgPXbnd8i/DhaH1p0mYk6fKaUN+y+?=
 =?us-ascii?Q?rjPyz7Fbri2Pm5Cwb/wNx/7BvzmaYqcVTw7UYLFSe/IjrcvJ2cE3uJXHIsKP?=
 =?us-ascii?Q?FZf50yeNYw/fTdmC4vQ28c4nC5Seh+i+0vhrWtRCRPE39ngyCc3VLB5zwHPm?=
 =?us-ascii?Q?t+wH+rBaxMWXVTOH0OMEbCWJ8wI41ndJlLDAXhgMuSN7vVCIPGwwktKxxt9N?=
 =?us-ascii?Q?cpFFobz1rb0GNKJq0AXN+Vxtpx1urgi7+aM82zfui6Cd9Aaiqggf7Tjke9H5?=
 =?us-ascii?Q?Jm2CpaNFP9ZpSJQgI5IAdNsTupYDNhxqO72ikHuifsBXP8OrNkmUpYf/d9eq?=
 =?us-ascii?Q?KnVJhIRGmOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQ74re1kOMiEMbunLsylzPCwJ8JnFF8Hm9cDmUjAULOrtLPznVdR4+WPTZAI?=
 =?us-ascii?Q?F+Jk+v3TEAiHkX8Juip0TCDek/rIu2YCRXJHPpanRR/PVIUqdQhqQM152bfz?=
 =?us-ascii?Q?ldRIsoq0pJdqkzMLlKk6d4loASEpcfXMqYqkmK4DQB9Rlb6Xe0VwPsiN47gr?=
 =?us-ascii?Q?/ORz2/VUFgds3fFuK2FigM2dETVP9et9c62eSKJupNf1hArtVa0WWzLLb0n6?=
 =?us-ascii?Q?kXR6aj1CK3ZGPyDCOHrSzcD3Lj18QrmYH5jD9avgQVMEsTlYAN1nKfD2Hclr?=
 =?us-ascii?Q?oO+U5cjw2Y0SXTntNcFM9a2pGkA/6iNW7Sldh0x/m04X0qrrBk+zX9agWkNr?=
 =?us-ascii?Q?PBXlsVPFzrp9YS7dRHKt1dNi++Utr+R9MmuHKCPM38wZ/fi+gWg1uhjR21Qs?=
 =?us-ascii?Q?MtoFWPGa+wNqup2s92cqSxr981go9GhKj1i+ZSNtPUGoco3n+nLh8w7hbB8J?=
 =?us-ascii?Q?G0eCimWR5uXP7UM2sZHWbEzamPneBC2n2HS1OFAwbwHbhutGiK2GlgigYrOp?=
 =?us-ascii?Q?HCDLegpTKoQW/Ma5HZo4gUI9gEzPZwSDiwBHF7HZpTqpYCR1T6PW7L9IMnRZ?=
 =?us-ascii?Q?Le2ItnZ1+vYDgE+7o3LfOMxMFiy9RRkST+ti/HmBuuVL/SA+Dx2W4Vtu16pw?=
 =?us-ascii?Q?aD7pHo/Tz0sGjvQh4xL2Z6d0M/wUNCaFjmkr+ii53F0HP/AMRD7vz+SAn+4m?=
 =?us-ascii?Q?JfPt1H/++sTzaOjgVcVMhRcbSWLS+knv3hPRdTpKZf+yL5gto9B5hkMSbpB6?=
 =?us-ascii?Q?lmvg5OOA3/UBOL/HYsmSU3I49f1+Ll7+m08T+mbGdapN6LoHwx6wBl3VcP3q?=
 =?us-ascii?Q?HJl1cASJbm/wEwpm89Q5UZfOhXvFHou8E/Uvp+39oQdd4oH2UhtkQk0QSNSY?=
 =?us-ascii?Q?/e478wtvGd1VPX8/nuuq5na7NgynpLygl6vfbrWW3u+OMawT4Ze8ssGPdP3k?=
 =?us-ascii?Q?ddOR5JweFs5qRAfamvkAkPemDi4iI2mXz1cEgo7HaCPVV/vjKkzO8uh+40uS?=
 =?us-ascii?Q?uLA7jQZzj02bVXD89HFPt0leM9r9K5PsYYGaneOj1Cgt346DxGNbp438wD8k?=
 =?us-ascii?Q?ckRr/uqPkk8jTYh+pU28lTEpjIIGMf1CGzuNFOsJmIEHZv+42+IqfRTRorLs?=
 =?us-ascii?Q?xfYkgjCSDHN6SpHSFdqP/gd/wTIng81TMJ15CH3QbupkjH52P59V2x5IXtsF?=
 =?us-ascii?Q?3iai39x3EpO+nk+Gtzq6tCTcyafpSIRjzd5MnmlLN9XyL3mzG6/W4ui1sOL8?=
 =?us-ascii?Q?glVPWs3w02WXDO4tCTV2wWoRDdXqMsAWb6A2rUpduMNJEoqtvZPMyiBXqRau?=
 =?us-ascii?Q?HnGgsc5pztxGWogjMjDBh/bBT8Q+iAo6flG6Jv8Et3w3hWS4PbImvCjvJUVL?=
 =?us-ascii?Q?Hwee4hDCfEVYC8SBq0Mdat9uI6DV2O2n9RLUjAjyWJVk7jm8cUaUQvMTsYNC?=
 =?us-ascii?Q?RwsIb7iUbe6AqUg5lyWnO8xmX8+ovBiwvgg6qqbsD18UDppt6ej5IZRQlrSs?=
 =?us-ascii?Q?gttSNEzD8/Fub2vAWBnt3N1vCPuNQ0UuRaQ1zNBLc+QgZNk5ieqhyX14roS3?=
 =?us-ascii?Q?E2pHWlxGxMcDmgiTZdCrVT2eRnYW+5ymwMwcDbgQ8vCeMFqAMlx2Yi0al1at?=
 =?us-ascii?Q?xXV7khrkvowUXknZoxPwjpI58ZJAUTFH7sBwaHvRCHlXg29g56tVwSUAUzSJ?=
 =?us-ascii?Q?PqvYCQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a48d864-6d45-4104-a032-08dde3dde4eb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:47:12.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpQESX97B97j/dON6L/W6XlbcVTIUYSzqfR24WguDjyrjJHpNOtSxEsl5y5eHnf2vUFyLPe4kKDd1/Nnmgvptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119

On Mon, Aug 25, 2025 at 08:55:43AM +0200, Horatiu Vultur wrote:
> It looks like that every time when the interface was set down and up the
> driver was creating a new ptp clock. On top of this the function
> ptp_clock_unregister was never called.
> Therefore fix this by calling ptp_clock_register and initialize the
> mii_ts struct inside the probe function and call ptp_clock_unregister when
> driver is removed.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> v1->v2:
> - move implementation of __vsc8584_deinit_ptp into vsc8584_ptp_deinit
> - drop the PHY matching and check if ptp_clock is valid.
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

