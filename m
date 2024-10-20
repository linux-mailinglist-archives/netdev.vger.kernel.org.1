Return-Path: <netdev+bounces-137294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489039A54E9
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626B81C209A5
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D50194094;
	Sun, 20 Oct 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJSXMkEX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFA2209B;
	Sun, 20 Oct 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729439970; cv=fail; b=hKJtF5fWttBdwRgEZTFbgxdTvCFXW3ej+LlLi32D0xQALL+LSgsi8WHp//JvoNlhQ6U8oLxkrkaDQTm8Tjh88FZ9dMD2l+zwqQ+LSxvLjGuBuwieuJP7uCaYSkpcPuL1mavXjPH9xW206modseFNf7J5VSa3fTEOxdneHR0JhQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729439970; c=relaxed/simple;
	bh=tYnEHeQRYRlCiovv+fEUK+jkyhFMWQW6d4yPbeq+A88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJXWb/l2ORuQmOnjKvVa/PvTns33H3ehNd7EZWx49nGHm9lMuOtDqMhUHW0fZPGab7xfYS7ZyxJUlUICjFc44hr/EI7/Rm8L2mkhVBXCJ+VFM43vOR6Qv+uD5mugIWxUmabD37ZZW/7hrMmE+VzyJCQCWexPEa3USVnyOIlyIAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJSXMkEX; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH9egBszPkx1Nohg4FXk4TsLl1ap49jEF4bI8BWwNHVaM2lktshm1ORkEnrElCVNPPn5KNfqTVzaurB455ExQ1gjaeqMxrycnCfhinNUJTKPomqy2P3Ya881kG9XCxXSZU10TnpmJz7rluWf2Klc/EgjPeON6tWQe3wwIbuRZhF4TN4biy+/c1qxOY16/1r5rfJTtCWECb5ej1GwoLfyMP2ZODKIBmz3y4yjdTQwC4k7fKnCTSLtSHcqr2buVehcweSdcbgwAn9VHdPDHQSF5y3xL9/Ui6haNQgO7mYzjqrxnlD5GyisVLif4M9U4E4G6PTWhTYOBx1BarT7WXg5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EYq0ZST+OTB7Qa2dvFmBVXc8GVj1d64OhhuI0nuvUc=;
 b=KqJqoSdMdzAJBJtu5EwVVFC07C4YCg8RZFaaVuxo4anuid5XWAQIhj6z7X81sAbGP2mYTBy5dZ432Z1fZxYrF95I1Gc0gv1EMagB9dzdSbUg1nnKVOdoWY056O545liK3Aq+04fJ5uuVOijbSnmx5CEadBBUZl3wavQjIVFW/xaKZJ6weESR1iVz5NyAQdKQMgv5dlojmUAFGzO/y8wKLiK4fty77EgXDa7FwQqP6B7JKL6ChtLROJLeQo360D5F6SOr+dqIuLhokT7XBqS0cLRX5o5cBqrJfD+CRhd5vf/8MpPIowFfKC79i0itGcnPxiozH4pRz2ntSfBHBmhovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EYq0ZST+OTB7Qa2dvFmBVXc8GVj1d64OhhuI0nuvUc=;
 b=tJSXMkEX797FBVPBRh+PVU4NviEd3ThOYnPUSuhZTqZSbBtX7hNglSrNln3FHSUUDFAQN8KT72gsu/3ZlAmHlnmPgbDtMND9wWFgXAvg5tbJcf/2d0fcQOloSPuhn5lBXh2REdOGlvp/Vj6j/I+uqKHNyCx4V4OL5bd/b+ju6iEkGulNpdj8tD9HqhHzTHU3AAdSHwDdpPGGQAETulIIeb95p7OOXlWKdcN90u6+GsB1kleePK61VW9T38y8K7U3BjQ2R/jRON/+DBPTa5e0j9HhKn1sjEQg+mwqYYQdCIsxegHcuKtCkWR2sum8dkNHiCbq+b4fPxDaWdP7pD/m3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Sun, 20 Oct
 2024 15:59:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 15:59:23 +0000
Date: Sun, 20 Oct 2024 18:59:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/6] net: sched: propagate "skip_sw" flag to
 offload for flower and matchall
Message-ID: <ZxUo0Dc0M5Y6l9qF@shredder.mtl.com>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
 <20241017165215.3709000-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017165215.3709000-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0d851a-7350-4984-7419-08dcf1202a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jeEL0odSsM+bWtUMqXXXFcrd4Zh1DItTDUTDAwCIzD7ZvCW3dv5FmaSyn6yi?=
 =?us-ascii?Q?eY1kjxHOQrg7cTsODb1NawauGKUpS8sPSCSx6TY2nNlqD8ZOoy9F4bEXuZ58?=
 =?us-ascii?Q?oiHGhVtrZ7Mx8scXGxyDWLqn8JtlTXvcxq/Wzn/QUYE3BwAVLmc1+o6YSArH?=
 =?us-ascii?Q?NELtTFkHqnWvYtCq6NxkHtWqzHbvlVwqpkiWiVLRwsP2K2pdJVbje986Ceun?=
 =?us-ascii?Q?gSEneUAYne79jmPL9fJ+vi/Zzg6nSEz6jxmLBN3RK9JXu4LeYqP1bGBuTBXD?=
 =?us-ascii?Q?Mzh3ig6AZjK06G8Iau6LgnW3JUdVixvjbAQ5zSOkVqKi+wXYKr4/cgRmGAhq?=
 =?us-ascii?Q?lB6PdZlHQseUXHUWrtdTQdEN1cQTaXCddtkrmFvKC6E5EBY4wzSB5LoYlyHR?=
 =?us-ascii?Q?D9ri4gGUS2wNHiU1qPibBbpz6w1Tf3tsI5msmSQJOxHFzAyK/BZU5bklMc2Z?=
 =?us-ascii?Q?tsGE3y9hfJi5MCbSRjs5trYdo43lmoZHCRmg8Tak/GMYYmI6hR7AUfskHz0Z?=
 =?us-ascii?Q?66XC9Ut99eWQ9GOT25TeotGym5jtrIvTP4+VFEaQY5IncKUCnwVhKCUHDelR?=
 =?us-ascii?Q?B5HcFiNOs/+RD4JRwO4vnOGHEahnmL8aSlwyIsLwqpmX+ZBzjW+obk1UN5xn?=
 =?us-ascii?Q?3msgEKOAW66gBUyEP7TNXCfaprCKiGn1RmANrjSzIqCZz65+H+QNumzwUlRj?=
 =?us-ascii?Q?F6/XoD8cnuW/VqMFPAFnW23oDYHXY1K/fo9TFcFTbPpK7Vbx5U7Obu623osc?=
 =?us-ascii?Q?mu8Zk7jF5jTf0wlndrKuJe4vQjtW39GNWVhxpdi2gMNNfoNU0XuR00vk/jcz?=
 =?us-ascii?Q?Obzn+z8UiKNAAunEt2Ta0ZSUu6E0Yb0fTEPdZaesYXbGUsyPl/LanO1IHrJR?=
 =?us-ascii?Q?FpDtIZIMFlJ08yhxNlavakEDUUKaqK3K/Ynh22p5bLHNP1zM0oLOWW+r42GG?=
 =?us-ascii?Q?cGRQsXA8Df/Rtw6I0MQEiGF/o0EHxBIKdXB6krblJTjbEXYPQR9qjYXZwAg+?=
 =?us-ascii?Q?jMoNCyYuaDHyvutaFS60ouEH4F4Z3fPH2CjHsoiJnoOUsDtb0S9aJbNW12fD?=
 =?us-ascii?Q?0Q4JX3tUfcX+brIm9yk+kVM4xlY1xATd2wbLGAmuhyVawlWiwNGodWTdPbVB?=
 =?us-ascii?Q?XUk1et8+1HZLa8pNJvNwHGPj9imhwun5Re13RB+EELOg0lK9IQ1ASrTc6qUn?=
 =?us-ascii?Q?VHlIYHbaQaVBdV8iDTAfQ7bYF/f2+Wr2LQDyyViKHu7cLF6pCvL/ltuJoCuC?=
 =?us-ascii?Q?+F5y93q4xt/iOGEBYmgfrsKOax38pK1syXVRQsmFDiogdWWOumayZPak9PaP?=
 =?us-ascii?Q?n5iFbA5xE6kg6BNCAOG8BPpy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ftIFOWyFw4oFPu8wkCN9CSFyKjqtT5icctub5wJtk7V7tap6MAUPDy98gwg?=
 =?us-ascii?Q?gWJkV3Tp39gyQCX1owGsS9cCPxaIj7EWhmc9+QCn+bZv/5QzdVq73SCCAXSO?=
 =?us-ascii?Q?+dYUaC8FpA6bkifAXWZlZOa7iCZ0OnIGW3AgIG+x6AZF0x1mmv9hyxv303vT?=
 =?us-ascii?Q?NoXr9kw/BARMK5PoVivj4sRhBiYGi0MQM3W3WhHr5wzbB7H3AfiVVrzAmRvD?=
 =?us-ascii?Q?elTM1DlQu5koIS/5V/eDJNrCL4XY8Oj8WnFBtzeSaDSzBk10IIR/Zjr4V7O3?=
 =?us-ascii?Q?fYqLEN0uMtx7sTRyihQtTO1YUjT7HhXR2df1Ytp+dBqtCciHoz8D54pyAp6U?=
 =?us-ascii?Q?uOrkBAIiLwn6SuR4ppQNM/1syhxXnzToaZRs2jo885eCraM1dS7hu6l4OhoJ?=
 =?us-ascii?Q?ppyD/IUDb62Yl5FlUc4G4QhwtSElV8geGQO2pdfC85tFnEEhmiHE0qpScGmr?=
 =?us-ascii?Q?1s6LIuF7xz69hQmaeVNpUGZ+J+NPf91OBiHF4Vm9bGVKTMWYOUIGCM+MymYa?=
 =?us-ascii?Q?ugip43NlmQL2fIA+lCGS3uYTg2e2drorSRZO1j/glGTiE2cLhpBVx5Skd4Ir?=
 =?us-ascii?Q?VrW+OTlu7Pf6JZU5O0Cm+36PdyJW2zkNbRn1/F35ECUdusoMtIPtxgotXAnt?=
 =?us-ascii?Q?g925VohnLzqG/zmaQhvQd3sz8nUu+SHVzoRpIXQBEhlN5lGZo2OCmgZtEhG9?=
 =?us-ascii?Q?bLqAwr/ovKmTtQpzJj2xUNlpJ/82zPSPFq3AxrHndbh/9r/mZ3wvYwXvziML?=
 =?us-ascii?Q?z83s9Gp0MXkoY0DTn6MTfOj9v8QGdHfzuvoxsk1wVSJ5UDpyHkGLNvwjnUht?=
 =?us-ascii?Q?rCHmDyS3dlLaBPSAwepU+e1FGt6rf/tILKkWpeBmFxYoOvwgVSvVlxXRrfke?=
 =?us-ascii?Q?LSlfmR1GQHKyU/h6tRBEZLsY0pBvYWJidM0Z8pbvR5+z5sMurpdvKDhGXm6G?=
 =?us-ascii?Q?NoBQZRGv5MBFUbq75CFQzLzV4yL1p74x4/MR9VX6LHqSkhlf0iIaMMypOz3M?=
 =?us-ascii?Q?IcY+sis63RI3IoGYh3Lf8RNLq46mUKMc4/KmfT98wtLmXP1bH1mTuvw85/i1?=
 =?us-ascii?Q?/GShs7xUVk60ER4jKahyZBq6P9evixbFpwD99gzamRofVWyNt/HU6N79hnUl?=
 =?us-ascii?Q?05lQRu7Yz8CfaDOIkSf1LWIA5YTgkmBNw4UWicnRJd2N2P4pQLppAhZLG70T?=
 =?us-ascii?Q?nH+V5x+BhuoYx3qK+T36BlL/83eOPe+C3vPQJtmwmDoraZ75Cjp84dQSszKs?=
 =?us-ascii?Q?of9ropr05LvOqagDEZrjURp4TzpaC4ObOul4RnILkdNBPN/GJwR5Tjdy5FWH?=
 =?us-ascii?Q?i+2a08VdEJGoDlgl+flz2iGOUjhoXD5bGEg0WsYEMPFwIv6dOGv04GamoaEk?=
 =?us-ascii?Q?sUONNH59xsgVrm8AKwhr+onmH/Zh/XcEregRMByY2TZSu5Fw9Ojlnd9aL5Nl?=
 =?us-ascii?Q?fkeG5tNWzB11V+UEoE/Bs8c5hhMk5j+uGXHIVNMHkri5VnDfb4z7ENh1nyuM?=
 =?us-ascii?Q?4iUQK1diJdHiHFkhLf7AQvROQsJOqWOIMJtSCBsJFmdBweoqQAudLMKvZTzC?=
 =?us-ascii?Q?KhAhAZ/0oOI4NbTi/LLWXtGrAvc151PdmFowLsdL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0d851a-7350-4984-7419-08dcf1202a42
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 15:59:23.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq3fpGAG4e5PzgzcApIszWoQT0oPwK1pTFbxbAbY/zprSl92yCCNmzu1D5LTqJ678NDl87mKHBGvzRC/DVShqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

On Thu, Oct 17, 2024 at 07:52:10PM +0300, Vladimir Oltean wrote:
> Background: switchdev ports offload the Linux bridge, and most of the
> packets they handle will never see the CPU. The ports between which
> there exists no hardware data path are considered 'foreign' to switchdev.
> These can either be normal physical NICs without switchdev offload, or
> incompatible switchdev ports, or virtual interfaces like veth/dummy/etc.
> 
> In some cases, an offloaded filter can only do half the work, and the
> rest must be handled by software. Redirecting/mirroring from the ingress
> of a switchdev port towards a foreign interface is one example of
> combined hardware/software data path. The most that the switchdev port
> can do is to extract the matching packets from its offloaded data path
> and send them to the CPU. From there on, the software filter runs
> (a second time, after the first run in hardware) on the packet and
> performs the mirred action.
> 
> It makes sense for switchdev drivers which allow this kind of "half
> offloading" to sense the "skip_sw" flag of the filter/action pair, and
> deny attempts from the user to install a filter that does not run in
> software, because that simply won't work.
> 
> In fact, a mirred action on a switchdev port towards a dummy interface
> appears to be a valid way of (selectively) monitoring offloaded traffic
> that flows through it. IFF_PROMISC was also discussed years ago, but
> (despite initial disagreement) there seems to be consensus that this
> flag should not affect the destination taken by packets, but merely
> whether or not the NIC discards packets with unknown MAC DA for local
> processing.
> 
> Only the flower and matchall classifiers are of interest to me for
> purely pragmatic reasons: these are offloaded by DSA currently.

Possibly a stupid question given I don't remember all the details of the
TC offload, but is there a reason not to put the 'skip_sw' indication in
'struct flow_cls_common_offload' and initialize the new field as part of
tc_cls_common_offload_init()?

Seems like it won't require patching every classifier and will also work
for the re-offload case (e.g., fl_reoffload())?

Something like:

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 292cd8f4b762..596ab9791e4d 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -685,6 +685,7 @@ struct flow_cls_common_offload {
        u32 chain_index;
        __be16 protocol;
        u32 prio;
+       bool skip_sw;
        struct netlink_ext_ack *extack;
 };
 
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 4880b3a7aced..cf199af85c52 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -755,6 +755,7 @@ tc_cls_common_offload_init(struct flow_cls_common_offload *cls_common,
        cls_common->chain_index = tp->chain->index;
        cls_common->protocol = tp->protocol;
        cls_common->prio = tp->prio >> 16;
+       cls_common->skip_sw = tc_skip_sw(flags);
        if (tc_skip_sw(flags) || flags & TCA_CLS_FLAGS_VERBOSE)
                cls_common->extack = extack;
 }

> 
> [1] https://lore.kernel.org/netdev/20190830092637.7f83d162@ceranb/
> [2] https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: rewrite commit message
> 
>  include/net/flow_offload.h | 1 +
>  include/net/pkt_cls.h      | 1 +
>  net/sched/cls_flower.c     | 1 +
>  net/sched/cls_matchall.c   | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 292cd8f4b762..a2f688dd0447 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -692,6 +692,7 @@ struct flow_cls_offload {
>  	struct flow_cls_common_offload common;
>  	enum flow_cls_command command;
>  	bool use_act_stats;
> +	bool skip_sw;
>  	unsigned long cookie;
>  	struct flow_rule *rule;
>  	struct flow_stats stats;
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 4880b3a7aced..7b9f41f33c33 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -782,6 +782,7 @@ struct tc_cls_matchall_offload {
>  	struct flow_rule *rule;
>  	struct flow_stats stats;
>  	bool use_act_stats;
> +	bool skip_sw;
>  	unsigned long cookie;
>  };
>  
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index e280c27cb9f9..8f7c60805f85 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -480,6 +480,7 @@ static int fl_hw_replace_filter(struct tcf_proto *tp,
>  	cls_flower.rule->match.mask = &f->mask->key;
>  	cls_flower.rule->match.key = &f->mkey;
>  	cls_flower.classid = f->res.classid;
> +	cls_flower.skip_sw = skip_sw;
>  
>  	err = tc_setup_offload_action(&cls_flower.rule->action, &f->exts,
>  				      cls_flower.common.extack);
> diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
> index 9f1e62ca508d..9bd598f8a46c 100644
> --- a/net/sched/cls_matchall.c
> +++ b/net/sched/cls_matchall.c
> @@ -98,6 +98,7 @@ static int mall_replace_hw_filter(struct tcf_proto *tp,
>  	tc_cls_common_offload_init(&cls_mall.common, tp, head->flags, extack);
>  	cls_mall.command = TC_CLSMATCHALL_REPLACE;
>  	cls_mall.cookie = cookie;
> +	cls_mall.skip_sw = skip_sw;
>  
>  	err = tc_setup_offload_action(&cls_mall.rule->action, &head->exts,
>  				      cls_mall.common.extack);
> -- 
> 2.43.0
> 

