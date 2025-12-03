Return-Path: <netdev+bounces-243472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580FFCA1EE6
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 00:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3902300444D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D52D0637;
	Wed,  3 Dec 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N67DDSey"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B62D2382
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804253; cv=fail; b=BHwXmQg8V4ZIUVwGGTjWQb1krAm9hWXMHw71EWJ94HLkbegxUAezIdNFriGbpLAtgCx0vwKZZg9/mitiOpNoFc6Lt9PY9MWqk/Eh2Nu0ONRx8Q3aipkL05Y8sUAATvga7SsndnSM/yJDnlstaeopLLw2Xos8UM90PFr+Xz1GJqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804253; c=relaxed/simple;
	bh=z55lHLtS1QnxEhzurMudI6iDFiI1lPmBj6FVia1grXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=medCTL5wBaKSUWzBC5/nll2m4PPkyyrllSA3NmSOwDvQy809+6EugrY1NAs+WTd866X+Dndr6ksIS+22JGvlsPU+pZz237xpTd7tEkm6t4ZhvZaQR0qDFzyyVTR9h2fg49q9ve1VtAEk0+qJZDc7vIcvJihM1BGXDi9elWdEiZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N67DDSey reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkE4L9cPsqF0TFY1XH3wGkuLvOeMvJWx6cljJYEbs3xUCJjGnvVjel05Y4jR6oPA0dZCy9jWjL9OQo6EID1VEz6tzX8r0xSSbyuRf+R/e8HHssFuGaCJJOuPVAMwQqdfrSsQh1JnJ9fxrOAapVZSGJ1J8U3+SlElO6WfR03e5g8wy3jMpQqCFqqs9TU7OU3t4Ljj/wrydFb5gk7Y8rkpmPYG54eiBcFretxo8ytvREFRbi4III5EvMH/xUi6q5opCxSIfj0dL7n9zYHGtX5HhBftUn/BANxKQIv9tHJeomPpUQzhnVmKEdJaSxySB1INxBKHkJAeMo0y59e9+Nn/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQazsqrqEBO+gYlOD65+68jovfkPEyEvOzAbzij/cu4=;
 b=nxNoxI3sLPNesH1Olky3GJIpq5W1nurr2CW4EzN9Hb3nu4tnmfXw03+2wq53I6DhyWQtrBj/R9tZbEl56USzaMGevHLBzISThAKNl9tEoKCmaMaVPiym5vNr2wudjRj2Ui2SG5swXJPjImQWdz9ypjK2ffQ5/U1KccbMKu5e1crfFy8bNbdka8ZBYquwdN3u8x2PxxUZ6L17BtevFElcfM1CeuIOgZYUbWSeCf/Ve0vq5cwYuTTHmbSsbsBcfCrYjGis04DrTXfvRYSCy07GwsvNckZF3Nh9vZUiGk3nPR4NoNSgs92wBwO9//4LEr6ddQN94JhnxwJo3hOZvE6uZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQazsqrqEBO+gYlOD65+68jovfkPEyEvOzAbzij/cu4=;
 b=N67DDSey+J2xbTTsdhyk48D2xcbAeLkymdaNNaHUgM8BstmNdedH/3FOKKv1xV4jYMsI3UnOYx+YKsWye7BEfXWSUYXq85pFB6BKDnfX8p+DqDMboVCcECIO2eJycAtIdnr5ZCbcP8ikGY8sASdu48JodLiw4bfMtQM7nddAWrTPA/LRljAQT8zGzGAYBel+vmP4iw9TYmaaBeBhwdASN+WHjYErpXnLVSqFpS8MtRw1es0qK9SjQnOmetJKhVtJ7zL4eaRQn3MKBeMe2soiYAMbs3QlZzD3NUtfYed69uYDaz5HGngBGlvuj4FR4vg1jNYm+hek9D+j7tH+4lt1JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Wed, 3 Dec
 2025 23:24:05 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 23:24:05 +0000
Date: Thu, 4 Dec 2025 01:24:02 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [RFC] net: phy: air_en8811h: add Airoha AN8811HB support
Message-ID: <20251203232402.oy4pbphj4vsqp5lb@skbuf>
References: <20251202102222.1681522-1-bjorn@mork.no>
 <20251202102222.1681522-1-bjorn@mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251202102222.1681522-1-bjorn@mork.no>
 <20251202102222.1681522-1-bjorn@mork.no>
X-ClientProxiedBy: VI1PR10CA0091.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::20) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: d661575e-c432-4f18-e563-08de32c30d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?L/MEmbBz0JMzBJB3Fb1nT6WQRIf4mgfBytPutBCnsNWwuDtX1ksyhgC13u?=
 =?iso-8859-1?Q?mRTC5ECDaL3a7JXP3cZj/9djc/gG+o8BLAJ4H+M8jkLPVET4cKCzh/Pgtm?=
 =?iso-8859-1?Q?8LIkSz38meVp1t0YvrkRnimKQvg/ihd0KeAAD+q90/4HtNEF+OKlVw3VYj?=
 =?iso-8859-1?Q?WhSQ3uF/vQHY4/qwFq4mHGyeUsezOr3Uil1ihc1nNX2oCnDSnbHJrwqzZz?=
 =?iso-8859-1?Q?71D1FOdcNKmSInPc97tjvSuYc6EydZbo6xgDp8nQWFkamV9w7jkFnAXpVS?=
 =?iso-8859-1?Q?ZDiEmSk6US4yGGTa5Wafjy6nRyZtAvGIxpCx6S8cfsWgIUg71CnPELF/QR?=
 =?iso-8859-1?Q?10ShjPGAk+UTx+yLJ0qmhu0o4A80VUAYNJsOQTlPXHPBg6AJqWn4TDj9yk?=
 =?iso-8859-1?Q?87nubvooU3t4njH2rLA0zJ9SImPdZBQ5cD+fp1pbMozWqFtT+8A8JpYwQ+?=
 =?iso-8859-1?Q?aA+Zj7a5PzSNnlPvveY49OMCCHh+Xbktayz5rmLZ5zoa88pxegNHJfCl8j?=
 =?iso-8859-1?Q?kXM2p7WZtPv6HkBy1JHrmGm1E+ESuLfT5EK6AnIxQUhS9utExJrDeMA5/6?=
 =?iso-8859-1?Q?5dRznZKE/A8ch8RLyxsqgFKGVN71k2qtnUEv/eaOfFmOYk/Q5R8OHoSqV7?=
 =?iso-8859-1?Q?VVFvZiMV1cgWtoRDuHkukpW6jZIOKtLK+caPV1POeuab7THpwvWj42KQcb?=
 =?iso-8859-1?Q?fnYnK+Lqn9ho4q7zm1NiP2qT3f4nVBAJrRkuvc2L0fFgynvzaMEdLBLzgj?=
 =?iso-8859-1?Q?w8ttDhPn9rAfMuHoK7AlzN19sbSrX/sjcmk/fPlkgzRs+IwJbY6Ecl6lGF?=
 =?iso-8859-1?Q?PWg8V+OtUvAtabUOHLOqeeWRwpATZzdggonM+K8y0QSwd6JsklHkgSjl9y?=
 =?iso-8859-1?Q?FJn/DYM2nGkG37HqcGIh+6oysDZ9ZeFF8c+hDhSlW/RLM7oGOtY04nW5Mb?=
 =?iso-8859-1?Q?/DkizGMoJpDmJxCSSn7Uk6NB6xE19yxcdu1/rhrJ71xA0MB5VI0VQuo7bU?=
 =?iso-8859-1?Q?rs3VxlLJ30AykKxLQQJmdCMJb4ZNK20ZD0fuDuu29qU/A2w5OXleHYQoly?=
 =?iso-8859-1?Q?kWOKoIqw9H26dfeTNaHQClSW+vGuOLXZnyJuCs/KIHJblhy+SG024h5XJv?=
 =?iso-8859-1?Q?/ZFVuRrAAxLk9F0xxoiKzA00TyTxi+/ARHeR96KpD9mfnyZXKQLGBs2jzy?=
 =?iso-8859-1?Q?+tWIE3FfCEKENZBtPCblfgAr46NmjUJTfAgcQycZdx1VRKf4dmCWxV2UVf?=
 =?iso-8859-1?Q?MqeAMlvkMAJmsdbGVseiA7s3JR3Et/BOljq77ChzCsGlgJWK93xxozxm+H?=
 =?iso-8859-1?Q?PvN+hOre9XaIMcPnTDNcDCg9S+IztOmzc4nKAq67xjWzL6ZDybmIZKnNNt?=
 =?iso-8859-1?Q?XjW7zFIbtsrWExv8SdJ8h4+/wzvOa+5WlG+23zUaGgVMjcGDfHQ6lfOahZ?=
 =?iso-8859-1?Q?BDzTROex+QC1kVZ4CtMAIJRxxYgyH58W0e8Z4HnvsT8w8u3yoc0lDV1UfL?=
 =?iso-8859-1?Q?xnanSisTT/ml5HeZM9Sq6u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?5cyRK9pvX5XKQ2uajo9nbpHpp0EcEJIVuhrqTAeKCKremByKF15FK2M7/l?=
 =?iso-8859-1?Q?L3e/HSss64bt1vEfo0gvWZufyeuega+ux448/71m0AQsHOOZmNwBW7osaQ?=
 =?iso-8859-1?Q?3w7UEeM50KjLvqp6aoQfs+dffsKRGnud4STB3ZEYduTufEGLIyIopSRoJz?=
 =?iso-8859-1?Q?PLUkdmmaqIhfMp12GbYUI8V9/b2LrWKqRHbO2r9UcBdFkFt9hK9IFb+L4D?=
 =?iso-8859-1?Q?8Imvf8pxySOsLzk16TRL47Z4SpssGyyQLEhrkloKnNFqT5wIIHBAUHnoVR?=
 =?iso-8859-1?Q?I4XEiNZQtUL8t0NoWYdI9r7v3mBl3mFpZAlP8ECOamkWbttxUOHLnxH3L4?=
 =?iso-8859-1?Q?CtYgE5iQgkPgleg8G6iY3PgU4o0mFp726wb8vGiq6ev/nBDbi38tYODUAM?=
 =?iso-8859-1?Q?2Z8k3uZmd2rxZ2FBXopj8Q3dgAOgHD8m7gRmbWQr0b0RPOW24/ikPJsACO?=
 =?iso-8859-1?Q?nccUeqRhIdTMGBmMUR8qz+uop6SHoyKRi0VpYF88Vra9gl4Vl81l8tHpce?=
 =?iso-8859-1?Q?UsGy6Gpxgm8L/bIbiyOvKdLsDxmXCs5d+whptLMdmLt5XYgicJkK69B0zs?=
 =?iso-8859-1?Q?0UVwRwU3pxYOQo8QLuOBto2uk9+39nAlOf5K0i2I3xWSda7p51mHZbjOVh?=
 =?iso-8859-1?Q?kYvaYu5NMnG1yebJJrWSsU6umct3+tnPWGRL3yWYV7nWJpDSCPc86S/cOA?=
 =?iso-8859-1?Q?MwB0Yf9EzOgOqfM1LalvUMg5dnnH5DGKDxtAMhbopIFWCS/KrggzanZDmU?=
 =?iso-8859-1?Q?Mqnw6Hd+Qh+ZxaKKRGfabXJakJ9JGZ0lGOaLDcRzFFr6iyISSrf7EneDdn?=
 =?iso-8859-1?Q?fmqZCu1MdR2NO7seoSYGCNi20bSAObXYHklyrABGfJDx3g3zNUNR4g2iAf?=
 =?iso-8859-1?Q?AFBCv9CoZgLg9KUJsc3jV3CDeBCyuu0D+ZSr+a6bgl2/E9tjfPCYU6KsLc?=
 =?iso-8859-1?Q?scxm/NogjgAXryQTYRsr0AMnxBZHecXDNsrQHsv9fNDuY087JrJx16Tavd?=
 =?iso-8859-1?Q?Ng35y9o/g60lzfY7/kH+/zZIwrT8TMrv2eFucMqac3W/6UWQKx8XUenATx?=
 =?iso-8859-1?Q?BeDhgYzRx4GyI78nAsYN3esmgR49jfp/CMZM4k0fhjuEoNgAKRDGkkzVz0?=
 =?iso-8859-1?Q?1yS1XqpwAxAhYJ8anud5G+ztGYJT1R3S2Gx2fO0ot9H1e7mD1J4HGC95ga?=
 =?iso-8859-1?Q?W04Iw3wPVbouh3wOux1iMyMwZ0om93vy+RaPTmWVpmOI9Oh0LGq9PQ6nbC?=
 =?iso-8859-1?Q?jTu7G9aiPjenPWvZ5WsTUQ0hu/sjn2IStvXkU44nBARFUfTHpeaIQefQU6?=
 =?iso-8859-1?Q?ES2OofQlsnwNccpnhue5g9k9/vXfMM4JyAIVPAvCCX3UhUI/2ogrJswVu4?=
 =?iso-8859-1?Q?EPXl0D/LZmhp3BZoc2GXtnZqDeDud8x7m06rCj8ELqwTSxvTftHXL5CCga?=
 =?iso-8859-1?Q?wIsxFj6SEYwdWmiBYH3fCPX+nCILHNw3aanREfP5/GcpJfDkbRpqe1rpaf?=
 =?iso-8859-1?Q?/WMxxD8J0+o3A/s9d6MAhzOhCKEjzJiyR89m1xzAfQh91vFOuZeCyzbsQq?=
 =?iso-8859-1?Q?bJTPE7/Ds7VsCYXn1oKwWKyG+hAiAiu0D6tr37Fdhdopc9JY02hUrx8Crk?=
 =?iso-8859-1?Q?imBbj38s61PcvAtV+s/l/NBXSwxTRJUx+eJUvHXQMSBIeVXj59CwW2mUOe?=
 =?iso-8859-1?Q?DINEEWlEwRY4mNDfHi/noM9rTcWvFR/A6C2CeLQ7Y32oPE5Ta5HrLO/RB1?=
 =?iso-8859-1?Q?MiPw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d661575e-c432-4f18-e563-08de32c30d0a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 23:24:05.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TX/jxQoJiQrnq33K0O2zc6hB66QlI25KxFEBozrE9jnI73hvfe/cFye30uhB8/MjMeYJmEmK71DGur9JpL3n0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885

Hi Bjorn,

On Tue, Dec 02, 2025 at 11:22:22AM +0100, Bjørn Mork wrote:
> @@ -967,32 +1157,61 @@ static int en8811h_probe(struct phy_device *phydev)
>         return 0;
>  }
> 
> -static int en8811h_config_serdes_polarity(struct phy_device *phydev)
> +static bool airphy_invert_rx(struct phy_device *phydev)
>  {
>         struct device *dev = &phydev->mdio.dev;
> -       int pol, default_pol;
> -       u32 pbus_value = 0;
> +       int default_pol  = PHY_POL_NORMAL;
> 
> -       default_pol = PHY_POL_NORMAL;
>         if (device_property_read_bool(dev, "airoha,pnswap-rx"))
>                 default_pol = PHY_POL_INVERT;

I think we can discuss whether a newly added piece of hardware (at least
from the perspective of mainline Linux) should gain compatibility with
deprecated device tree properties or not. My concern is that if I'm soft
on grandfathered deprecated properties, their replacements are never
going to be used.

> -       pol = phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
> -                                 PHY_POL_NORMAL | PHY_POL_INVERT, default_pol);
> -       if (pol < 0)
> -               return pol;
> -       if (pol == PHY_POL_INVERT)
> -               pbus_value |= EN8811H_POLARITY_RX_REVERSE;
> +       return phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
> +                                  PHY_POL_NORMAL | PHY_POL_INVERT, default_pol)
> +               == PHY_POL_INVERT;

The idea in my patches was that phy_get_rx_polarity() can return a
negative error code (memory allocation failure, unsupported device tree
property value like PHY_POL_AUTO, etc), which was propagated as such,
and failed the .config_init().

In your interpretation, no matter which of the above error cases took
place, for all you care, they all mean "don't invert the polarity", and
the show must go on. The error path that I was envisioning to bubble up
towards the topmost caller, to attract attention that something is
wrong, is gone.

It's a bit unfortunate that in C we can't just throw an exception and
whoever handles it handles it, but since the phy_get_rx_polarity() API
isn't yet merged, I'd like to raise the awkwardness of error handling as
a potential concern.

You could argue that phy_get_rx_polarity() is doing too much - what's
its business in getting the supported polarities and default polarity
from you - can't you test by yourself if you support the value that's in
the device tree, or fall back to a default value if nothing's there?
Maybe, but even with these things moved out of phy_get_rx_polarity(), I
still couldn't hide the fact that there's memory allocation inside,
which can fail and return an error code. So I decided that if there's an
error to handle anyway, I'd rather push the handling of unsupported
polarities to the helper too, such that the only error that you need to
handle is in one place. But you _do_ need to handle it.

> +}

