Return-Path: <netdev+bounces-214000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B018DB27ACA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936FA5C583F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DEA226D14;
	Fri, 15 Aug 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NtaGeCd8"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5BC20A5F3;
	Fri, 15 Aug 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246046; cv=fail; b=VWr3HhwDI/HtT1ZCWUmzEn5/Wih6Woehh63dSFOEIDT5bM6pXfaJPkF31SGdIfYmEKocq2czzNRssVojrXTvVqAgBqAfWj2u8oJzgZGbv1/etG4LHKEZxX+uqMwNI9IsHzA7E1aFf3gfiNiJqh4FFG/rHY7rI9yJJUg0JiBWSKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246046; c=relaxed/simple;
	bh=8xAwJeT2XGizMOSAZe76Q9hPsa+v1p3N+sLDwRFWecs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YDCrDNL6z+21Z8XwwL7KJbUVAB4q8oPfC1FydatihyVTOGSeMqXa/t7qm8B48ifwohr3akM50OVGEgGhVRQhR8lwgjV4cPhAA4AURlUIPKmdFK8HW5nhnPuLn5D5OkdHxuMdfaAuvIMq7P0zLl8Da6j+BoSoruKIK773Id8/7gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NtaGeCd8; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGJxpQFfI8NVs880vUZoUzyNOiEWPTvmX0xiNDAg5mzooFu8Xtuj8E64PyDXMPjSoMOQR94UN0s9EyJpKSe5QebAUmaDX64iRTqjmrEkH2QI/42RX2//Uz44WEHZhqnTF8pYQL19/6n1OUV+zIjuCn7x+NezduNiDbHrJhqlykf89bYwYNbJNg2B6vYJ+JSFlZ0MVBbWay6CB55mWVUx+Ry/NVkOSPgkrswj4n15jL5KD8Lq4H4YIrzm6DHIZs0XY+JG0zQbUeciLzZijUGCGzburiDZqs9fGL1NFtGps7FwIkljDgTe7D7f1LrNZGBbfi7/TFNKoYfxe8O5kz0BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7R71ePFyiC9FrQFghDg/ZorV/OxfpPc8R8sEPUvPWg=;
 b=Xe2c8Svf6i/RK4kGa6vP6WloTh5NyrjLhxjGWuzRf3ycn2JJRsOsczXCIjmEmP5cLT7xLa71wHQRJ/B2lfNJAyqrLnH4nlovP9qJL7aDOE8bJ2y8yRpyF+fqgp4YRseq9YEjIcnFV2e7yGdZI5UpU0IWa7SQtvFC/FPZYCVp7aRavvOpyimJDqya7pKGEekn6Zu3rQTWNIWf1DHqUctpE7IBjtnx+PE6qpX2EAQI2gNAwb7TgFKRNkgwYxg9tP0XcwbEBZTfBJ0h0QMuh4HnBQqjnTpK9PjOBLAOxONYyEP+LBxiUt5j8v6b6YTWBiH2N4ux2/P9ZLc0tauoubLprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7R71ePFyiC9FrQFghDg/ZorV/OxfpPc8R8sEPUvPWg=;
 b=NtaGeCd8PNtTeKhDp2oJOqR321MTzHc15gJMCF4NBuRot2KTY5PKwac7lXkX0ITmiKFXPnqRziPfw7vlPmhIqC7Rk+VUvNFOu0UVhcxslkKIxcPnTcHdL3O3Bn0mcS2Gwevh0TYT6ZdDgrug+MHPl5qoN29O8BYqn69hDVD5CveqGwsyDY3JjIqD4rihFTk+xLan1yF7Hyaobop4ISmpdgXkWEgJFAZbLKf0jM6/Av76CUrITkDGmmCwyXTeRphdrrX3MlDFUY16dzOAEd1CareEsd8dfw757OVYkkLu0bINkTvBluZjTjiBTSVcrLWsgAZuatanxZztBBmsO0nQQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI1PR04MB6863.eurprd04.prod.outlook.com (2603:10a6:803:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 08:20:41 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:20:41 +0000
Date: Fri, 15 Aug 2025 16:15:09 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, max.schulze@online.de, khalasa@piap.pl, 
	o.rempel@pengutronix.de, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] net: usb: asix: avoid to call phylink_stop() a second
 time
Message-ID: <c3e7m63qcff6dazjzualk7v2n3jtxujl43ynw7jtfuf34njt6w@5sml5vvq57gh>
References: <20250806083017.3289300-1-xu.yang_2@nxp.com>
 <a28f38d5-215b-49fb-aad7-66e0a30247b9@lunn.ch>
 <e3oew536p4eghgtryz7luciuzg5wnwg27b6d3xn5btynmbjaes@dz46we4z4pzv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3oew536p4eghgtryz7luciuzg5wnwg27b6d3xn5btynmbjaes@dz46we4z4pzv>
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI1PR04MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: daba5f45-4887-4b96-ba07-08dddbd49f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVl+GDP1eHPkKj+qgFoOjX6dHPVqKMXNIoEHCCzFrIlyIZvqPd8Td1Lq9TIy?=
 =?us-ascii?Q?l4Udss1WPq5uHMca6Vte/5LCgucDJRCKgyz/JglNNaYOKqdyHKTH3wZ6K2J/?=
 =?us-ascii?Q?tRwdHawal2+3McDueJsKdw55w0fzI0dLsQSBLcV1MTa54ESAebzVklcs8Dxd?=
 =?us-ascii?Q?M/51XxADG569y6XkFTnBps1+nxVHfQzxQE/grkFEp52EimJVucnm4hGKO1bW?=
 =?us-ascii?Q?t30FBqO02pTQM5tf9xsysjkJhPkMW7WofdWwY7xMHugXF+sk3utytUgeUpCh?=
 =?us-ascii?Q?qn0QwAFRn0yaz4TPoYbzQxD2qIEm/5HkdEVl8zTi8kKoeThaU3nuBLXZ+/mu?=
 =?us-ascii?Q?ouMOdv05lS6giIrbpOeXuArC4qBAe7nHU2b+7GcdfXy3UdKvnEvW7Vte0+kj?=
 =?us-ascii?Q?Mo8If2FbO4uOPbrRd10UtIeGfX56ep39jplk9fdb2ML7O+xg2+l7ebReyGcC?=
 =?us-ascii?Q?pgen9vmyfMVMQTl31182kEykO81x5joXGVk1bo0/v8EmKvX5bvqcaUHeDCyk?=
 =?us-ascii?Q?cbfvgqhcZSRN9FVthHWN30nJ/s+qm6LjYxro1gIK7qeHZKiVOu9A1+UtqyEa?=
 =?us-ascii?Q?uTuGOZS1p+7Xbs5Oc0byzZ5RBE+Aydiq3j93RQJPTe739hsM9yrCaJGyX2Uh?=
 =?us-ascii?Q?WTie3zpGfLM9ffqhL5EmFBR9r9ktDgs+wJPnzATch0aw8/KoQakuAyacw+jG?=
 =?us-ascii?Q?gBxL8mPUEYsRGbhjq3xOFYwGoPsHrfdTlVxXinIqoWXO8K4lP2Eoc9010Jk7?=
 =?us-ascii?Q?W2FNvoaQLaX/fa3/3pgP5MXXReIOyTO+PJyIZm4scYEvSMsi8W7bgNWIWLZ6?=
 =?us-ascii?Q?V5Vv236xr2igmm+SP0jHF/6KPNM6tBD/oGxBnXxUT7T5f2fyH2PzlWWEqMHc?=
 =?us-ascii?Q?jit4A+c0Rz9NM8vD8vwyBq1bOZCdt3wzKyA1h0MzKCMP3GfBB1xAaWWbrmBh?=
 =?us-ascii?Q?LODvOFBTRghqLhtk5IhzqVVxd/bqcLidmw+wI0KmwwOACXP819p/fzd7iua0?=
 =?us-ascii?Q?R3IN4Afjnd7tEr7oUrqq+DXB+okvrMFe39hisSayCwFitUbiLeXNrU1+AIDS?=
 =?us-ascii?Q?+idFoieyTcXTtwBNb8abi3aAzUn9t7LrKbQpTHP/ij8T58ySTcIeovQy79ir?=
 =?us-ascii?Q?8Jo5iCBxxrxoquBh33jmw1ZDr1NOYTyykgd68T04y6Ylapw3EIwCoNANcWyZ?=
 =?us-ascii?Q?L53oUOsT2Rg42W8gHEogHIYb45ivEWMlWqbc/E/f/MgyWRLLK8DO/Xtc4SaB?=
 =?us-ascii?Q?2QQpPh9YW3TmB6BKBgaiQERKkNlGoaFyg8nfIpgUPlxsizSFRVEderwmVwON?=
 =?us-ascii?Q?bun0cK7ewKmvuU+ciuwyZUqLDBjYO1vXh6lRssu+s+QQUG3II68IydM9DXTW?=
 =?us-ascii?Q?EBL/XkLTQy7bxNwcFRidpaprz1nHoiF0FVrDY4WYsCPyhGMYBc/H+PTGYpaP?=
 =?us-ascii?Q?7EQL5xUBv5SGCIOmtlp0YtgSKQAHQJxyC2zrtUZO7KGenXqHoDZUvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2/zossTeAKXTA9c1iNZi0LurM1/scfrUa9qLaBF1HS5YLJaVNGnPcE+ulwZ?=
 =?us-ascii?Q?+/qBirCxeB97kU+kSGSMaCGAnTt9RIRm9PzzO9+Q/FV2r4eQT7DIe1/U/7FX?=
 =?us-ascii?Q?3cyimrE+O5RVxqwubhEVV5yhcB5hzrNJiQQnG0Xkn6uxiijKI5Fpdw8Xris8?=
 =?us-ascii?Q?KpTt57daeDirQLdi4EHz/5+9r7ZLBH0hGe+w8QMCXJkoOp4/y8YA9hJkLEOo?=
 =?us-ascii?Q?GefF8CGTSqLwTRW3wszc6Q75Wnlb0xB9kLvFUKI2aO2/J/bFdmqUXnieYdAg?=
 =?us-ascii?Q?SPO9Z6fwbu5eL/lSM4uYmVRilizo8v4pewoEzLyKFVsUUj9VkvfSwQEIkc5b?=
 =?us-ascii?Q?JA1Ac01iBsZBQ/XZrnDv5g8IjfH3PKSnMetdNCgTK/UnJvE+lHK9hVh7WCqq?=
 =?us-ascii?Q?B6vMpFcKM0jad/5l5a5OeYR7keB7QcfCRqlQuwq3Nk+fKTGNSA9UJsX8Tzmx?=
 =?us-ascii?Q?LBX0PbXA7PGkl1UwSjGn/TYtYFx8tQKMGcZESQ5s6TCZ1xaSDrzzHja8PhjV?=
 =?us-ascii?Q?mxQMzCus/wl+ROx9al5eb/6MvW4Q3lI02ABkc5SaKye5HJM6l6VYElAAgwzW?=
 =?us-ascii?Q?UcsIsr2fA45+DiTv9pmIoMrqpce9mPhjQNnSVhMlMooDvQVPRjOwM+WK9B7T?=
 =?us-ascii?Q?aw9Znf6opmSxrtgKsCIGcQLmeg9z3nLvuf0S9NQZrOPYiuyQsepEXSEYZqKh?=
 =?us-ascii?Q?iiEGH/9VwYrTVwJVRchajIrSP+UvBD/qpI+Aw63WkCY+LTDSPzk0A3pOQUcc?=
 =?us-ascii?Q?Zb+XBFhC6t0VeNJS1Syw6KPu5aKjE7tQAvCMPKAuKXOKoRiS7YhlvaY4KH/O?=
 =?us-ascii?Q?wTtvan4NqLhB24xWVl+54rmpd2PRI6bE6zZA/bdFg3+faUbLL7RxYpJ54EZQ?=
 =?us-ascii?Q?0m9iEH8zvR/iQ6y1qTFWWq3X1ZpQkWsKQb995eVBScWesGxDDsYJcUYS3DJ7?=
 =?us-ascii?Q?TZYL3SINgPMcf7iE1L2mAfX2kePDGwVNSwM4C1OpaRovIX1P2wXAZ+ekihPw?=
 =?us-ascii?Q?M+6iYvNKihL/pBUcnqbC247KYRb3dpi95iIWy0auYWjvtKSBHxs+LWPtnlO1?=
 =?us-ascii?Q?xQ9m0XQpCi8z+xiM0RoSpBIqIxy0WdWqsKWveIhdGepo+MHIywD8I1Rso2n2?=
 =?us-ascii?Q?XQVBcm4tO4QbjnGNj9OBJ3kY7t68aD4WSI8ypkcm3gRz4YChApt/LqCjkphe?=
 =?us-ascii?Q?lDcytu8f471nWgBcECQG24/82UO0MNABM00K8GJHqdd0aa72sJNd2VxnpA4a?=
 =?us-ascii?Q?wi8K3rAhjYWVsgJ5fAMSCyKViNgyaRNbDyaUUyJm1RwlnvvWbQsy20pTTS7j?=
 =?us-ascii?Q?lXtt8rav4j4aSdIlaRJ/VJ9ILqPQIFdf31Ua2kf9tkQJhVyOiCIpgR2EWZUX?=
 =?us-ascii?Q?C87cgJRlvUIc+qEO4D/tO/SK8//x4NEPdUuBm3TalA1cZ2SnoKg/TYp8kwVy?=
 =?us-ascii?Q?cFR0nxDrv4saqBPANsLNBRW/cXRsGTeryFFq2t15lar1zEfG8fUw8gL9ps3r?=
 =?us-ascii?Q?jIV3vp/i0XeLFWVsLxOBgYzwfrJFVNbeM/3f+aTLvl4S/ECeexwX4vsuW5c/?=
 =?us-ascii?Q?OVhae5TYyPRudALlwcMzC7eiJB9yK6TObbfqxZwM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daba5f45-4887-4b96-ba07-08dddbd49f49
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:20:41.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoOmhOrY567NZw7AJYuDK3AoBq3OBWF+iLAyon0MBwb/xTJd4oHT3S9AeCo/+kVipyZU62TSmR5HyDd+17jehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6863

On Thu, Aug 07, 2025 at 12:03:39PM +0800, Xu Yang wrote:
> Hi Andrew,
> 
> Thanks for your comments!
> 
> On Wed, Aug 06, 2025 at 05:58:18PM +0200, Andrew Lunn wrote:
> > On Wed, Aug 06, 2025 at 04:30:17PM +0800, Xu Yang wrote:
> > > The kernel will have below dump when system resume if the USB net device
> > > was already disconnected during system suspend.
> > 
> > By disconnected, you mean pulled out?
> 
> Yes.
> 
> > 
> > > It's because usb_resume_interface() will be skipped if the USB core found
> > > the USB device was already disconnected. In this case, asix_resume() will
> > > not be called anymore. So asix_suspend/resume() can't be balanced. When
> > > ax88772_stop() is called, the phy device was already stopped. To avoid
> > > calling phylink_stop() a second time, check whether usb net device is
> > > already in suspend state.
> > > 
> > > Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > ---
> > >  drivers/net/usb/asix_devices.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> > > index 9b0318fb50b5..ac28f5fe7ac2 100644
> > > --- a/drivers/net/usb/asix_devices.c
> > > +++ b/drivers/net/usb/asix_devices.c
> > > @@ -932,7 +932,8 @@ static int ax88772_stop(struct usbnet *dev)
> > >  {
> > >  	struct asix_common_private *priv = dev->driver_priv;
> > >  
> > > -	phylink_stop(priv->phylink);
> > > +	if (!dev->suspend_count)
> > > +		phylink_stop(priv->phylink);
> > 
> > Looking at ax88172a.c, lan78xx.c and smsc95xx.c, they don't have
> > anything like this. Is asix special, or are all the others broken as
> > well?
> 
> I have limited USB net devices. So I can't test others now.
> 
> But based on the error path, only below driver call phy_stop() or phylink_stop()
> in their stop() callback:
> 
> drivers/net/usb/asix_devices.c
>   ax88772_stop()
>     phylink_stop()
> 
> drivers/net/usb/ax88172a.c
>   ax88172a_stop()
>     phy_stop()
> 
> drivers/net/usb/lan78xx.c
>   lan78xx_stop()
>     phylink_stop()
> 
> drivers/net/usb/smsc95xx.c
>   smsc95xx_stop()
>     phy_stop()
> 
> However, only asix_devices.c and lan78xx.c call phylink_suspend() in suspend()
> callback. So I think lan78xx.c has this issue too.
> 
> Should I change usbnet common code like below?
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index c39dfa17813a..44a8d325dfb1 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -839,7 +839,7 @@ int usbnet_stop (struct net_device *net)
>         pm = usb_autopm_get_interface(dev->intf);
>         /* allow minidriver to stop correctly (wireless devices to turn off
>          * radio etc) */
> -       if (info->stop) {
> +       if (info->stop && !dev->suspend_count) {
>                 retval = info->stop(dev);
>                 if (retval < 0)
>                         netif_info(dev, ifdown, dev->net,

Do you mind sharing some suggestions on this? Thanks in advance!

Thanks,
Xu Yang

> 
> Thanks,
> Xu Yang
> 
> > 
> > 	Andrew

