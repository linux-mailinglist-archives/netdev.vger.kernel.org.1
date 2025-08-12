Return-Path: <netdev+bounces-212887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0630B2264B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891E83B1401
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FDE2EB5D5;
	Tue, 12 Aug 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wm94GUfS"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1C35898;
	Tue, 12 Aug 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000249; cv=fail; b=l+2lDsOItKv6ZM2/TxbJqTJ3GCeDc/LpeorbkxjAwtAOSCVHMQwkd16wTbBjBan5mMBLlaDT/p+JonWtYaJgV2hz8CIQMu0SMVP8Vc4ay8aCkz9AWAjFdr6K5OkF2kTf41wxv1XJUcr8my9sOdO7AijrOu3rgHZ8cFI9miyA8lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000249; c=relaxed/simple;
	bh=O3srH2V2e2vo+uVXIFkbX8bhv5K+oQKbEqndDcE75VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jaBsDRqeBsSvfhShD8Y4yyxjinIyiA6xxKrFJZoPTj5K3g1TWptDqUtKcn+B+oeF3UYHtDu4J2Mg+NuMfX0w6F9WZXfn79ye6+Ypkns6pOTlxSrCso2NG45unm/LuRYwVf+4BGQeyooloIABlL30qksU8mHKsAiNfbAg9kpd9Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wm94GUfS; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0NoP8xpiQ8YinPGyme6ir9FrcSJH0RNxmzmL6Zigi7sv2mqc6YZmijqPLfilqfd5+llyZ5/iaqM0qVR05ZVL9CKE4g+7s7VP/j3p05DmEYKm1kEIGKkCMWzU1VQaqyX2Vx85XcHz0XDY6Ah5eWL+QtaGdre65Nh/Y8aceSIEAxD7Es0ts/D9lpd1zxJDn91pf3MdN7vgyUNIiLJWuq4bxgeIgPYQZ1MIuGOaUHC4X/IO//Oa7kjaBelRtlg3snHHIsbHBs34o/Q8jjUiZ0DK7MBMagkTvpJovakKphfi81NFrnfD8f31hjSUkFc/derlbDAKnwOdWLShMc0w7V7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=198Zc/FH1hU+ut9AAJh4spEqbhJPTLiNrln+9yXiHG4=;
 b=HPeL3DCU5PRtLoTeyOyvFG59t7+GQgwt2a7ZC/IvF3FUWTLSH7+UYeJgjBcaqJKmkg/UzVECfNhDpweGcM5sZE+c/LmRGLneBWyVGBYCCXHCL38xS+5O6dJjJUNo5WTHs7jlhDtkKdIr8vXCr4yBMF86de1V7l1SfLaPt1TP5Bg+T6s9uXNpN7hL98PZi4BxCebLewCMWVM48WlhpxnBRK0FaOUNeHArbTqevhfu6sj+68iMg40DVou8PNzOZdtRuJVUJjMCs2/Fy3dUf57BOZlFkRxorWXm9svrMVJMi08v3oma3vqnaendZOFKeDBd3r7YTmbUjfpjhES7ZRMEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=198Zc/FH1hU+ut9AAJh4spEqbhJPTLiNrln+9yXiHG4=;
 b=Wm94GUfS7+9gBDSOlJl26ozGpGInff8dpeISFTyqMM/gNC03aDG5uaMjzsMHWkxTadQJpAIbuyFv2KmzlS6g62NYMgl8AtcRlFbHOFn83fYjz8iR+m6nJheu4/avXxgVm6MGIWROkmYwRUe20Vo1C2eEgMxLfBZsBtzpjTLXz6FMB7Eu0R3yMUis+cBXjjugspmr6jDzKvhNS205Y84yWOFT4jnXtvCD9YqPhXlvDoa5HCFTSbkbBc2pdiACeLz43/0oIFPng1uPr1GWtOaiCb3u58xSnAxyY0chmeJ/soJ0NwXfcBYKAYExVpbJF1TA18w63kFQmAwu+IA0Vlk6MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 12:04:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 12:04:03 +0000
Date: Tue, 12 Aug 2025 15:03:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, Frank.Li@nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 06/15] ptp: netc: add periodic pulse output
 support
Message-ID: <20250812120359.5yceb6xcauq3jkqi@skbuf>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-7-wei.fang@nxp.com>
X-ClientProxiedBy: VI1P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc29db0-a77c-4659-5073-08ddd99854a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uIKiN2XsPK1QENE6FhY/qEK3mKQRbzBOQlCkapC6wskfpN1bFY1wemGKWIxo?=
 =?us-ascii?Q?hs2dOuUMBq90MAB7wASkso8jpIx0lDZdYHPGBXEbY8tE0FtC2DQpmiET7QS1?=
 =?us-ascii?Q?1/yPdYIg3s+70+sJ/24pn1Kq5qHdGSOSfEqocUkt9qcT9XOqnAdFeHlJOY7e?=
 =?us-ascii?Q?/+bqM9krvgY+nj9UZHNI2TyWDicspneAIzkyFz7T9Dw90Nnu1fwQvpL6HDuU?=
 =?us-ascii?Q?/TZ0UHqTDZQQWz8+F5wLdxMYYLp3eFmNDcAgi4pdzr3sMgN+nb+LUg1sV19N?=
 =?us-ascii?Q?BrRGQqNxAz/bEXYy2djMvX0D2V1SO840Yo+mQ5qNzOmtzDqUnygFaEnlKAdQ?=
 =?us-ascii?Q?HPSvmgsMhSYiJwGI7Z2XNltxKpzA9ShT/v8LhTqiyyIcWvaG5hMkJ4LVUpE3?=
 =?us-ascii?Q?udIBVUl0HR1cBfxbvRh7Srb7DnmlIhq/SSzrde/mR2LLp1T4OLOvXA12X6Cf?=
 =?us-ascii?Q?z+uAO6jFX4SpjKIZags2InP9/jZGtyazhQvo0Ro4mJDceaypGp4BsDC13iUc?=
 =?us-ascii?Q?KIdXLJEfwpARZCVSH8lSW08usnHGNWtv9b/Gwo1v4zapyobdtGNvgDz0rIBi?=
 =?us-ascii?Q?Tgt20//8Wq17D9wMhvOchzIN2ooYRU8mPFPceQqstH3D02uTzn+IhUVleWd2?=
 =?us-ascii?Q?zekNb9Cmt6nLbfbBTzE1Qh+xYK0WIrdAE96m4xzsw2yHYzJ+nBC7RhU+mlNL?=
 =?us-ascii?Q?Cmmcu48fKbPoxCpqllGEMK+DbQB/s0jWLagv6UE77YHpmSnP/I0Y7wSzGFz5?=
 =?us-ascii?Q?jIVTGN7qB3BL3c63GyDBOkT34jd+4X6/0RTSmJ9medYWWky8W5Q4G4JaPXSY?=
 =?us-ascii?Q?fuplhyPDTvYOi2H2USy56GPqLX8TlopXCync+dbJVi82xv+pQZXVMvbWruVx?=
 =?us-ascii?Q?EwTq4NARsVL3dHeIuJihPCKzLn+C4Xy1NDpgMrx02uyuh0RbVOAyb3X4zf6q?=
 =?us-ascii?Q?UO3RAXJnd+x5hcMgfw31kT/ffZaXqLxWe49FKfppL1QhLTvqScYpu9NWTrVT?=
 =?us-ascii?Q?LZ1/kYJA0WODtj2NWXdbhMk1Mn+QcoZGGaLPu4sdVDG7OVlJI3GieVumMR4S?=
 =?us-ascii?Q?lfZdnN8FLObn9Uc8PCqtrnrXi3qZqWnxCvlPSTZVIFZUjNs0gRpuqZjZNcjx?=
 =?us-ascii?Q?pNvhZisGqmeDDRxThryZnhFevZ48gXAKz9tIh0U0K1tckJECjxwg9D9jh2HV?=
 =?us-ascii?Q?45OjyctA+YawYcbIQZr0xob0FYI3bqVtMzPzXB572BcLhiZkHwQHtzOgQo9V?=
 =?us-ascii?Q?rJajW5shh7uXtBTSkUbsY+PdkfUiZ888J/wLj9By++agR1YbIF0waIa3wNFZ?=
 =?us-ascii?Q?dQC3UbU7NKFugoA7Ses6FPeyWcSZzLrkekA2Zni6zEH8omNrgvhTDoLF5uSF?=
 =?us-ascii?Q?j/v3X/E7CkQkrRzfw32jx2VM/KFdWS9UVPIRDuL7ifcVaodM+Ci1ArX/oBBG?=
 =?us-ascii?Q?GP3BNUIvSJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pE1j1gkUSZXiN3Jujv1P1fxeyRcpMCw9J/hx90RzROTe/sQiI3Prkrn0y5S5?=
 =?us-ascii?Q?K10Bj7Ia8ekabtyMSFGXIdfzXQ02ewEbQxp3tKUh5xaMFIUm0Cucilp7R58P?=
 =?us-ascii?Q?7DoSAE33qYKzs1JEmC/zoIuhKkNTyVoYA5W57z6xmkHJMN3Drx7P+OW6PN88?=
 =?us-ascii?Q?WyEpDZg7qNe69YpHvxgPXLlSLRq1SfdNEGBDogGNkHIyE2/QEry2H7K/8Pg8?=
 =?us-ascii?Q?pcjmsRxqR4XDFpavXx8dAeAQNjHzOdhzyRp8rqO+UoyWHBLuJpJmL+FF+KoX?=
 =?us-ascii?Q?1RUh1wv+hHeZiDKFu6z5AMRoFt/sj2FSZuKP7nQlJr0WQBQ3febYKtU9u2a9?=
 =?us-ascii?Q?hWI+Q9bAaa+Vq+9zaq41IZh3Trv8c7gToG4iRiONkaurHp/SbCPoXxrr33NK?=
 =?us-ascii?Q?eaxNE8xUcMxlEUBNZ5Ciz+UmTpJajMfeiwNn4oJOxiVdTBXosklLYrhAkP1Z?=
 =?us-ascii?Q?4EFurYAn6XVSY5RncLYfUyZOc/Hs0+s47FYlqrs+99BA7GKzWD6lIa04WSuN?=
 =?us-ascii?Q?wrYB9tYJJ7M/bps/MvY14mis9YMEVpNiLAjh8SuQDNXYYDj3xlGjcpP8yuWv?=
 =?us-ascii?Q?XDdqm9S9Z9FcVYXtHfcMLD7B0jY7olu1/wtUKcC4+M53bFML2HzAOA1eYbC6?=
 =?us-ascii?Q?5fGmTC2Qrn6ijHrgP3T31quxYDKRbwE97qHWX3DNOsdyJ4QiO7nczUo8jlB8?=
 =?us-ascii?Q?8xwg1EwvuumVJNJ2Sss6vc64Kb+izPj151fFOw/K1uIEih4l4VNuJ9Eatw48?=
 =?us-ascii?Q?ZzOHjH1Q+56c52qL2CyFfFW4JsYceFwMZGeF3kx53K9/roSjfAPS1xKkz1ii?=
 =?us-ascii?Q?pUG2d6P4gWk+/Am/EFE2asItNgOEtyz+YQ/8wfFipl3PxA4JB4bPwJmlgozv?=
 =?us-ascii?Q?5DScLXOYwRYL+URked00uMNYMYGZXBd9b7x2GKn6LxqgCa61xKwOc/hHsFaB?=
 =?us-ascii?Q?NLSQ8dnLspS6EZlmnNMteTqrOKNBrL2vL3wg2xfgB3FL/I53DjTj3gaJ1ZVO?=
 =?us-ascii?Q?CBjOM8qRq/+NomGw/ZXlyx5yByHb6iE4/iTFyw/PjzO9bFegcjj7WA5g7Z/p?=
 =?us-ascii?Q?WTCBUhe1tow7lNEMLxH3VQUoqTIeQ9bR/Qp5pI1iIdeFkYaqHrQSeQCSP0Xw?=
 =?us-ascii?Q?XSTlkR7K3g9swhxDrxtAur6ZY5wRIqmlTlVY2RHrJFV5vGkoIReqNUfwDwjs?=
 =?us-ascii?Q?XggWrA4tJ3JQW1voYfwRnW1Y5FS8VBXDvu3EMSFWi7qi6A5cWqb/VpYRfrk8?=
 =?us-ascii?Q?pP0jzgpsxdMp9OytFrcMSsQ3MGAO79d/swuj8WKW0haLIPh00lR88dUKkbPm?=
 =?us-ascii?Q?U/E2NaamhN5WuyxOkvm72LNN0zW9RwE41YNjAejsiwk+JVWhjJTj5q1/OF9N?=
 =?us-ascii?Q?3qkyJVM9Pss3t87Lwtln+BES1Z0BOuhTd4vJC+6ey5iLqqRzRSEumauIewFE?=
 =?us-ascii?Q?ZKMpUNzzaELFQpoKJBEL4hs/JusQ+YmjRKxc32aOuMn8iX0yrbw8CE97RKwj?=
 =?us-ascii?Q?wHrFyV2i/6zbE3jW6Ssa520Q7FGesQnrF9v9tOTBWdbNjLwSE3HBb9HfBpfg?=
 =?us-ascii?Q?ubon2AJkJItcnExl7HFH7hbJTQifjwcIkL/ODnNKGwlynDlsVtOHNHTZixZ9?=
 =?us-ascii?Q?uDg/Uy75Ui0JQvgj8RoS9StKbMKCrvEMHXs33ZV/FefIdUQS7fR4+q0j0DY6?=
 =?us-ascii?Q?47/g/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc29db0-a77c-4659-5073-08ddd99854a0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:04:03.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pROSdesNzjn309P+gfmbqYCx6iHxLtAyAGIgA1JVIm4skiTgksIDUKzUB+9aiREA7q8Mz58h4R/af/IMEXb7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

On Tue, Aug 12, 2025 at 05:46:25PM +0800, Wei Fang wrote:
> @@ -210,77 +343,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  static int netc_timer_enable_pps(struct netc_timer *priv,
>  				 struct ptp_clock_request *rq, int on)
>  {
> -	u32 fiper, fiper_ctrl;
> +	struct device *dev = &priv->pdev->dev;
>  	unsigned long flags;
> +	struct netc_pp *pp;
> +	int err = 0;
>  
>  	spin_lock_irqsave(&priv->lock, flags);
>  
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -
>  	if (on) {
		...
>  	} else {
> -		if (!priv->pps_enabled)
> +		/* pps_channel is invalid if PPS is not enabled, so no
> +		 * processing is needed.
> +		 */
> +		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
>  			goto unlock_spinlock;
>  
> -		fiper = NETC_TMR_DEFAULT_FIPER;
> -		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
> -				     TMR_TEVENT_ALMEN(0));
> -		fiper_ctrl |= FIPER_CTRL_DIS(0);
> -		priv->pps_enabled = false;
> -		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
> +		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);

You dereference "pp"->alarm_id before assigning "pp" one line below.

> +		pp = &priv->pp[priv->pps_channel];
> +		memset(pp, 0, sizeof(*pp));
> +		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
>  	}
>  
> -	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> -	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +unlock_spinlock:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return err;
> +}

