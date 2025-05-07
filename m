Return-Path: <netdev+bounces-188676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24046AAE253
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EE8189771E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E2E28C5B0;
	Wed,  7 May 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K5HNH+DQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAF25F7B5;
	Wed,  7 May 2025 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626573; cv=fail; b=srAqUJ9mWJnmjlOiL0NNvsWdaqiyrMFkN+G5CNUt3VadhYMijTFlZj0exVY154H56cGSI86FDTSx5VGYgxbdAXrWVjabq2MMwBJBiPctWvIiPgE0tnDPkTBg7eYJtzy/f8PjS6yRqfBeDBlUzyYXqha6lM+zZJGG8iVeoaw/Kjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626573; c=relaxed/simple;
	bh=yW7IJvxAeOFaiHvQje1ZyKYNEvqXNiBPOZ35YCGfjPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QgpYRIbKL2IpO/76WMJ91vnVWimL5oM2k+hcwbiCfldv18wnQz18sNkIlQXfayCvajmO2TxWL4TYz+/r3I/0cAhLmG2+NUegSu4yy+/w9SnZc0KVvPDu+ey5OrfNyP/bUK99YmkdbROBF9MbGigPJS+i5i5HRAeFcllc8D4uQgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K5HNH+DQ; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytad8sBmdvkdPBVS6kgPVf/XvNc4Qb/WpdyehydT1iFdPeOJjpO45GfTVsLGu1d1vdFZTtUX14g+WgtCtagYy7JjOnz5gcAorWu2e+CgmUZmXUoQvNur6Ntvg6jLNlCIa7YglpvKKAy6kNka+TY8trfMOL1ESzSzgLLCRLF+GrhDy1DXjiiotr/pXts3uIZHYPGTVKAjg6dX9kTpLwpaYhzaidx2WVxMhQGJSX2jFGxmd/+ea8Zb1s1O9WevB0r6piCYxalg1o6abOTttR4ditADX1f+ACQm8mgmoSet15sn0QN6eyyrJpb9p/qR+s7zbZZaYbkIda4zV9ug3RNKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEp+l/tL8z6SD/EZBIOk+uQr3CQV3XVZ1kFq1GAI6Dw=;
 b=r8hJz7XZYiCnZc4hQqiI2Zi1Ts2H/eK53++5/yCxmCyqAjUwV4qNrmzM+lAq10PoCuMUpcXadGa1hkuJkRJyqynVHIwIGGFjWDqONOLU3izIrlTXUdmImunKWPwmK0i7lMsZ39PaSIviIwKbd8dak9lW87+5M6A3blwmYJBejnL1zSVu9XGSfDQ0qmKwzFkoWG1qYOAuID5RHKxNGYUFE5kaJ+1znoggRcIkvdvesUAF1R4Ftv2QzeKmJv3zJ/WVubiOmalF4yEKI9FjEwSSnClV6opmlqg7lbM0ZVibV5w5X2KZKbgSnQ4zJcIzllhXbU+jYxjZh5irkanzlLaAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEp+l/tL8z6SD/EZBIOk+uQr3CQV3XVZ1kFq1GAI6Dw=;
 b=K5HNH+DQcWXsHGihwU8gV+964fmcVB46oCNQl7dKv2+wVtWAesunvsxQxb+Ma02MSY4CuKAKRxgfeEebGLDGl6es+h1DPkDLHPphxOnwUTDtc/xrJS4WF8OU6khAxsrJJeGfIflobEBD/tEdzbq70FToo0oQ18CL3g2z+jTXqteR6XPwlK2fnt88kaTUUpPAPKU7xneAbIDFmDikVngwIo723nw7/hNxBTVZvSFUNBRFdtZUOxbacFfA6cAzDzEQUgs5c3wqQOkN3XEmLLl1/MAwHZV5GZ7QwrSI2PPER7ThVyO7eKJ0heGyxtfaxwMWrUpVupWtLvi6tG0tsxuEsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU0PR04MB9347.eurprd04.prod.outlook.com (2603:10a6:10:357::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 14:02:47 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 14:02:47 +0000
Date: Wed, 7 May 2025 17:02:44 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <20250507140244.f5a7jfv3ruwxmuxx@skbuf>
References: <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <20250506221834.uw5ijjeyinehdm3x@skbuf>
 <aBqhtl3m03J6pw3V@makrotopia.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBqhtl3m03J6pw3V@makrotopia.org>
X-ClientProxiedBy: VI1PR03CA0069.eurprd03.prod.outlook.com
 (2603:10a6:803:50::40) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU0PR04MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 18225034-d44b-4a3d-a34e-08dd8d6fd8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P5fZwb9MigCv//VuBWZv23hygrruqWzVnsp0kQXwyQYOe/jjD0sd39q0Jc4k?=
 =?us-ascii?Q?9mAYObrkMLEqO0KN34h9KuijkXg88krwxuY2trGTf2ITOEqixMVQU4kdEJUf?=
 =?us-ascii?Q?gIbRCE2cDcM2wMec+ZVBjke6y1nyzLrZfH3ZEPZ0T6A+5wMhbvMWhNaWjXQ9?=
 =?us-ascii?Q?pZNUmxhPs4i/H6iBEINh3prk2HjxCm8FWr6w2sDp28Gk/7WBMEO6wrn+d1MF?=
 =?us-ascii?Q?RTdTmuBnd057FUplIJmlGtoJD7KSXsgKZSCthZbyPVWOZGpk9lVsXXTK3vhY?=
 =?us-ascii?Q?I0erm+NL89VQ8g8HYejgXqNczm+1m2I/jUuNJNZ55qMDyccdh98XCWIc5An5?=
 =?us-ascii?Q?ZZqXletI2gKqHiR8F3V2Jecs//MWgCrsAb87v3ocFOZugT41aQ/i6HoQTpUx?=
 =?us-ascii?Q?y9yuUCEQfZWRzKBN/9ttwtngHiN7vCfIivzEigJlc4uY7VL+NpynbywOMJYU?=
 =?us-ascii?Q?dzk8mf6peYrSDXsFabIpJMXiWXEiroumNrj3/oFH7AS8h19KDHc21A8QI+1O?=
 =?us-ascii?Q?LaWwSae/MnzHfcjbY9eHuPVONHj68TOjWTE0bv4EYmohBx5x91WwEhDxJpki?=
 =?us-ascii?Q?7rgQuMgZZzWLd2pee0LnQ1D8bS+OCW2qdOQLocozPHb+BkFW+62O6CsetUNO?=
 =?us-ascii?Q?Eq0tMVmp76ENPzvX9ax+GqPerWN2ABPMDNeuw0EOBL8JaN9MuSnJbNSsbTiW?=
 =?us-ascii?Q?V09m80cpjxMziJ63QmBUL+ivwDtMPqqJPs20gV2kqVH3gtweGAHC7DgoAUTu?=
 =?us-ascii?Q?9h7ZQwdhzuxi361JTMt1s450+nbWxZ8xVFaGr/qeJrzySVCW+p+DzdvR7swk?=
 =?us-ascii?Q?HXQG1ecXiw7gaGOKeFDbE3FjP5yYU2FcItgNIFc31c4Hk7ns0TddiPUvmHvO?=
 =?us-ascii?Q?rTPAZ3XWTxzFnucjWxRMb99yK0TtK3zUqgQjQjVMeUh0pM6ByEItkXzho7yF?=
 =?us-ascii?Q?6b0CZZb+W+5qHiGxH9QagxMuAbX0wdOmQANP4F9gAylllYM1h9U0vTH0JHqP?=
 =?us-ascii?Q?tYc4l0QaY1gDLVuRjVWAh2xbEwasMhH0PPUB1w4OGOtAbgkaAZDyp7lrMoZZ?=
 =?us-ascii?Q?TCalemhKHpvwKkvuByaDKOialTvBTgKcxVSn+3aHMMD3pyNRgzkpuBFfGc8Q?=
 =?us-ascii?Q?WBt0fHb5LD6QXhrHWav4540uQPWiSKIuSaN7zDjq+M/DGPcKgWTu/N5BcPdU?=
 =?us-ascii?Q?s75T2jyqLbW6rnmYT7Y0MJQnZD6EzWuPe2Su/MfOi0Pr55Gzg/L2YYfNjK2j?=
 =?us-ascii?Q?yarwYcjxcB/4tgoT1D/g0hlQe/Aymkn/GmBPzz8kXUHceDFojA+rZ0tezWkS?=
 =?us-ascii?Q?8tKbMPXXJtIFcHQJBLSFb+ZvuNlXel3rlyNLlg8Bc1WgsQhsswtylxyVEGrd?=
 =?us-ascii?Q?U1CdQBSt0uon0XXDtq94x4egpvwb4oxxP5qvpu92LyvcTh+3LStDVlADpCM7?=
 =?us-ascii?Q?PwlTOlei42o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1y0NzkNkvfJ8FYw0BhVfBQUgZjjxCc+u36nfIFUWPFi15X4kPMy6KByKKivz?=
 =?us-ascii?Q?g54VEEpENCMAuDni6xysunuZ/W44R8PLw2ko3BxwjQnLD0YoEyyj427ZlsR7?=
 =?us-ascii?Q?VlTO1N8hnRi9/RtNssY/gK5BvZJxQPDDPesK/au065kA+f3LQeV2+rK16eae?=
 =?us-ascii?Q?bl/qNV9cfA9I/hTwroBEmWWPEN95g2LzCuOCtPB+fmoC1BzxsdvjHvY1UaDV?=
 =?us-ascii?Q?98l6WHWaOw1ag8x/8tWTrSlAVFmH34j3fZH9RW53AMZB8skH6Bf3qTqZDcnp?=
 =?us-ascii?Q?LJ9U8riQ4p+I+UBVgc9j4HhaRMmoHT30bZVqiO7jt45C2JkAzyT9Bi8N21sM?=
 =?us-ascii?Q?ZoFFyVOou7gGQQHoCiXGzpFJYtbhEO00K8hI/Z57Z/P50LRSpWrXxZd8HuK8?=
 =?us-ascii?Q?/nQVGSuRaevSdyebzUND99Jc9vwBZExqpjBcpVYxDLXdgnPz/n0i7Y2eDOud?=
 =?us-ascii?Q?uSVVMGRL/QXyyKlYXjnZUTPzh0nfjdgIXz61BXOGIu2PaZnZsxw+SaxSfQDP?=
 =?us-ascii?Q?EZ7kq25/HNFlenARutQfcKNJHtgPuUDS0g5Im0mfvOTnpTPW/6JG0Sa7eIDq?=
 =?us-ascii?Q?ij4K4cWjNGWNOcgaMIziZFIN5mMhER7O5GSEjWLPgp0YvA8JJZOolUlVcagi?=
 =?us-ascii?Q?Eejf66M93jVUryj1BWsW0f04IP030LxLeDVhExAQmsc58N7xbJ5BapKV0zwL?=
 =?us-ascii?Q?KsgyUvaxmwqtE+8Qkw6Q4jmEo85HKDTHV4fVnttWNr2HN9/T3arsBatkMiUR?=
 =?us-ascii?Q?ZzB8OB0Nn8RZDkvAiOrI+MdB7RLR0JkU76q2qvM0S0eM0G23ZGIXo5tHYZow?=
 =?us-ascii?Q?k1h7RndrSi79Os4bZIu7NO5habLD8mzUspS6fctkwu0Iv5+W216xgfQS3HFt?=
 =?us-ascii?Q?eZZx/nMQR9m6B5NZQ+jLTkCsTXyIyqVeai/nyD5tctmhAL9cyUj4q5QuYrVu?=
 =?us-ascii?Q?GGkqS2grfzCqYyDEc6FJNlIkczbaNXbxEEfqtCmj5IPyqDvVJj2EBLx1Vj4b?=
 =?us-ascii?Q?0L079GVv1kowLZAsEwJvxpUOYHAfkGWOqt3OXjRcb8cc156u7ADdND3ypJcn?=
 =?us-ascii?Q?Rf+H8Gw6Gyk7c+thC/c/ISrsgjc/RM72AmyEvBaII2QWkJSsXg95/YytoHpD?=
 =?us-ascii?Q?+0Ct/9WeEm3kHbA1kLILl0tIhLbsbyhvHDWzIzaw/Iv46tH0nMlT7qphI4zr?=
 =?us-ascii?Q?b9oRbR/ZICHTOvi+1/XKijfoj4oClldqVtqxTzNnIUdt13kAgndM930AHgZo?=
 =?us-ascii?Q?FiCVQoiCrEVsWitsFN5XyRxt9HsAfhjlcGr7hEzXyhXOvNeGlTA+s0+10SBd?=
 =?us-ascii?Q?bRzT95LsLwmx9byuL+DAPSumE49XraIU5GvIzQjHTMJjP9lSiShTL06paOzc?=
 =?us-ascii?Q?L6EKVp7gDLDWgaZ1EKkXFfrupf+/SVra3CCHBNp9oE/O92ARVFCkbguxx6FN?=
 =?us-ascii?Q?KQYhfqzi6twocsPIp7ShyYbdCsDSo9RCh4Awn7RPugwhpes4LeqAOnzNJpm+?=
 =?us-ascii?Q?j71yp1SNMWjqPGYs9InoL2oS5Fi4NGoK/xKjGoh8WnfQvCrKloUcFKEXBjKd?=
 =?us-ascii?Q?VBMnMotRTBzVW2SnpWvYsx4gdmQWA7ommcsEyh8R+h8oJDf+afPZ//n6T9kF?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18225034-d44b-4a3d-a34e-08dd8d6fd8b3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:02:47.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7nYuBkc4eGuzmV+gVSzhT7f88hwFVc4yMH3pHElqxl/XerypK1FeADyB6XWvAccskPXXapy1YlCqomltxCiQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9347

Hi Daniel,

On Wed, May 07, 2025 at 12:56:38AM +0100, Daniel Golle wrote:
> On Wed, May 07, 2025 at 01:18:34AM +0300, Vladimir Oltean wrote:
> > On Tue, May 06, 2025 at 06:03:35PM -0400, Sean Anderson wrote:
> > > On 5/6/25 17:58, Vladimir Oltean wrote:
> > > > Hello Sean,
> > > > 
> > > > On Tue, Apr 15, 2025 at 03:33:17PM -0400, Sean Anderson wrote:
> > > >> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> > > >> index 23b40e9eacbb..bacba1dd52e2 100644
> > > >> --- a/drivers/net/pcs/pcs-lynx.c
> > > >> +++ b/drivers/net/pcs/pcs-lynx.c
> > > >> @@ -1,11 +1,15 @@
> > > >> -// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > > >> -/* Copyright 2020 NXP
> > > >> +// SPDX-License-Identifier: GPL-2.0+
> > > >> +/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
> > > >> + * Copyright 2020 NXP
> > > >>   * Lynx PCS MDIO helpers
> > > >>   */
> > > >>  
> > > >> -MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
> > > >> -MODULE_LICENSE("Dual BSD/GPL");
> > > >> +MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
> > > >> +MODULE_LICENSE("GPL");
> > > > 
> > > > What's the idea with the license change for this code?
> > > 
> > > I would like to license my contributions under the GPL in order to
> > > ensure that they remain free software.
> > > 
> > > --Sean
> > 
> > But in the process, you are relicensing code which is not yours.
> > Do you have agreement from the copyright owners of this file that the
> > license can be changed?
> > 
> 
> I think there is a misunderstanding here.
> 
> Of course the licence for the file remains dual BSD-3-Clause and GPL-2.0+ up
> to the change Sean wants to contribute. However, as he only permits GPL-2.0+
> the file after applying the change would then only be covered by GPL-2.0+ and
> no longer by BSD-3-Clause. Legally speaking there is no need to ask any of the
> previous authors for permission because they already agreed on having the
> code under GPL-2.0+ **OR** BSD-3-Clause, which means that everyone is free
> to distribute it under GPL-2.0+ (which is already the case when distributing
> it along with the Linux Kernel, obviously). Only netdev maintainers need to
> agree to drop the BSD-3-Clause licence **from future versions including his
> changes**, and there are obviously reasons for and against that.

Thanks for the clarification on the legal aspect, all clear.

