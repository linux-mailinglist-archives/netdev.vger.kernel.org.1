Return-Path: <netdev+bounces-234997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020EC2B015
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72ED3AD365
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B22FCC10;
	Mon,  3 Nov 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djPP1mm0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zfk4/82o"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F0F2ECE96
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165146; cv=none; b=NVFAlU27ysJXBmArKZPhyvm2gQ7pzZnsx7fVoKgho0RXtyZsAQprYVX7gF6Apofxv2juuWVfTEd17miUhMjFTEOD6RKC57ielTzEwpyZNBuGe/mWHEmGadarwzBLAGCzXecj+UQCAEpRgfjfhSpBWmgojc07bO2hSQL1wU+7WZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165146; c=relaxed/simple;
	bh=H7C+KIzAWfh65QFtg8MWjeDMEYAICepAjEQC8GHpXEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUAUMC3D8mVgfJx5DJrOVy+ymv+5Prdp0FCfmNdu98Qclx9vQOX25s81pamG/rfVvfHJ4dsRidVYDspj2mrw+hRx23Na0Ze8CGeSpR+AChSSR9siVFfHaV9qqd1VapS60hmvtW9zEBE8c7KATQF8OgUBMbAL5mM05p8qfqj0fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djPP1mm0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zfk4/82o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A383Uhm809005
	for <netdev@vger.kernel.org>; Mon, 3 Nov 2025 10:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8knuqx5dfDYzPF2+hLSNPS/P
	qg1EONZiI3O9dCKDeTE=; b=djPP1mm0aJ7VX4dcT/d0PQnmWqEhFzz/mtXA+/bF
	tE3R4rFCxO5vLEl0X0ByIA8soOO2KYMl1pVAGGYziZby90gF+VuQNnJbsDAQ1yvc
	OzjNVOJ/ad1Z2/x+q5+f2v0d2f/bftzI4kJgQ1tUkuhZ2iQn245y+9trM9A4ARWK
	QQ0ieuxVb4TbQ+PhT9bID8haq2OHOjUlX2gP36/YshVts+l0OQcnYAQJMFTjlNo4
	VW7WpkPWnB7bGfA5c0bH+bQTqRz1DUGulUm+Px194iwn4iPsQePgC7Q+iR39MWw/
	hjwYC5ygeh5w1w20dFELH8dHpaSN6xwek3dS7peM00v0aQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977cbst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 10:19:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956a694b47so16934945ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 02:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762165143; x=1762769943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8knuqx5dfDYzPF2+hLSNPS/Pqg1EONZiI3O9dCKDeTE=;
        b=Zfk4/82oTabqqztPyvTi4Vk/stZjNIiABGft5K5n8FmHkca0dtp3TwZufUMVWvaNRd
         3sPK4PoUJogc90l+jCgcogn62QqA6+Ob+30dw/bwQLifWoXQvFW0UUYp2bct5Fp5XV5O
         aDIq1enpgu0QBuG5q2QANjcmyhuUsUHHsivl5jpkJjPzQmBm0An2AqFYAGXvB1WovqTM
         wYkVrA88DFyNIXy7FhXXtdsHxaxq2edQsYEnaz8VAezZ6bygTSI1wYT1sTZvqhAqxlPJ
         S+rscFh0PIpOaff1qYHXa/GHLVKUrKcxqZyr5MRgtigjEqsoCcqX5aPhbdO9wBZD7Elx
         fluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165143; x=1762769943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8knuqx5dfDYzPF2+hLSNPS/Pqg1EONZiI3O9dCKDeTE=;
        b=ic+odNjT7QcA4fojwmmAgUxMdeNhApmEAIlu+gzZoEPGDWbkV4zvQOHzk/fsuXGEkF
         QNLC/IqKL0Yty5jnrmA82ML+KBSwwfFdMEM5htCfPY2wrLTIFVL0pM2sEc1tBcs6jo+6
         FTn1XQ1PMWmz/7DJPgU0uJ28RUCT/vjTVX9Fxeu6/6UJ8loy527BDJ6cjEp0OtLi8GB7
         2cubsgdwPiro+sEcsz/u0lKEfC+V6cJP76xNOlabdXw4CCdYTIdkE5gyKWu5Bll2VLDI
         bROQ8Tvi18KMrcPsZJ8v8NgvloOtHSABsk2bOtMiSEXLEG9FFZnL3F6UqRHCvk/6pVHB
         2aKg==
X-Forwarded-Encrypted: i=1; AJvYcCWYitQYUpV5x30nnE9f17BpYtALkjgs3k70L7X12QM4x1z8KrOin1Fuf4EzmUX7H3PRs/gPyfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrn45PJLZ4YikSYD6oo/MV87Cast3uRDLpWJ0ypBNWoQ34H3U6
	+liDdxiY5rG0qvykGz71xKiOZoz1XBSbMlSonkCA8lMh+6gR7IQnCR98Rt0vyPQWSuZc4ickcTu
	UkDcyJOhu7y7pvOma2nZiwFk1FtLnMiMI+L3apyr2Jsu4MxDAStv4YZZgqmg=
X-Gm-Gg: ASbGncuz8xWEADvOE+NEZqir6+83Q0ZepUQm4JmguJmeXUtpyDA6aqh3XDuXqmapbjf
	Z8dc/i7enNxaC/MprJy/XZlr5WiYFOxNB0DDgwf3/OjXK0QwPHGYb+uJFGaRqk10aPDVpAh7+mH
	h1Tm65YAk+fy6J67S8LPuzwezdiNwB/vGFgORgFKNfYPgv9cJ/FyIBYy+7LgXZ217NAdkJLKwwc
	+44i1bpC4VrMPaCwzZGOpTlJjTVTqMFdMbz5ygO4hDeAQFfmyL+PcBxCU8Var1va4MPtJr2PV2Q
	6gCjlF/54VGECcOnrHmaO9j+Fh9zirEyaoVyr5RTPrtaWjpdqT/ChWX0DUEFxpuLBH0I04HqH6D
	Hp6h45l/LrgZt
X-Received: by 2002:a17:902:c947:b0:295:223b:cdee with SMTP id d9443c01a7336-295223bd149mr141657045ad.14.1762165142287;
        Mon, 03 Nov 2025 02:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgdcfwBp3HqfGTGr6bQPq69wlWi0qcKLftcjaOWW4Q7ozE69g6Y2EISLsaJgc9EFYI4f2kwA==
X-Received: by 2002:a17:902:c947:b0:295:223b:cdee with SMTP id d9443c01a7336-295223bd149mr141656545ad.14.1762165141713;
        Mon, 03 Nov 2025 02:19:01 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268cc48fsm114249025ad.49.2025.11.03.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:19:01 -0800 (PST)
Date: Mon, 3 Nov 2025 15:48:53 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Boon Khai Ng <boon.khai.ng@altera.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQiBjYNtJks2/mrw@oss.qualcomm.com>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
X-Proofpoint-GUID: CGTiNdFCWsL9Ix_hoIS0GdQHHJ6eGZlK
X-Proofpoint-ORIG-GUID: CGTiNdFCWsL9Ix_hoIS0GdQHHJ6eGZlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NCBTYWx0ZWRfX3SsEPIgF/npD
 MxrIZmvaIKEzSFz5LyNgHk8Sh01UJ6L7xwUme07AGymkApvC7UsjSGwwUBkzjh6mYJlf5sUApKN
 LJWmzaUSDJXyCuIw99l5cRHsrvZ+Dae7ywt35y+RwwxuB/B0PXMU4BMBSnu8mLA2/cDWmIs/nGY
 xOJbmfPAXfN6xRPFONelBFlOkuUmHdwXEsu3Qmb1iaGwbUYzmKjUhmJ7QCHg1n9NUsI7bpWLJK+
 B4E6PjT0DcuphyFh02/VHu+RwG52uwQAvWFairD73Z/iVfzl336KjRXMf7u/Fq6yHMfT7Sv1Nor
 RysNmufTnkt8KJMhqFgR47S6jFAw4zQKXFkZ2QCXjfemnwR5Nsbr1g6qyGsSZlE+n1IXmZxVVPZ
 tObmxeOFf/XQK5Z7J9qyB/IKBpgcYw==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=69088197 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=UWWzG2wtzVmZz2Rg0KUA:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030094

On Mon, Nov 03, 2025 at 09:52:38AM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 03, 2025 at 02:28:24PM +0530, Mohd Ayaan Anwar wrote:
> > On Thu, Oct 30, 2025 at 03:22:12PM +0000, Russell King (Oracle) wrote:
> > > On Thu, Oct 30, 2025 at 03:19:27PM +0000, Russell King (Oracle) wrote:
> > > > > 
> > > > > This is probably fine since Bit(9) is self-clearing and its value just
> > > > > after this is 0x00041000.
> > > > 
> > > > Yes, and bit 9 doesn't need to be set at all. SGMII isn't "negotiation"
> > > > but the PHY says to the MAC "this is how I'm operating" and the MAC says
> > > > "okay". Nothing more.
> > > > 
> > > > I'm afraid the presence of snps,ps-speed, this disrupts the test.
> > > 
> > > Note also that testing a 10M link, 100M, 1G and finally 100M again in
> > > that order would also be interesting given my question about the RGMII
> > > register changes that configure_sgmii does.
> > > 
> > 
> > Despite several attempts, I couldn't get 10M to work. There is a link-up
> > but the data path is broken. I checked the net-next tip and it's broken
> > there as well.
> > 
> > Oddly enough, configure_sgmii is called with its speed argument set to
> > 1000:
> > [   12.305488] qcom-ethqos 23040000.ethernet eth0: phy link up sgmii/10Mbps/Half/pause/off/nolpi
> > [   12.315233] qcom-ethqos 23040000.ethernet eth0: major config, requested phy/sgmii
> > [   12.322965] qcom-ethqos 23040000.ethernet eth0: interface sgmii inband modes: pcs=00 phy=03
> > [   12.331586] qcom-ethqos 23040000.ethernet eth0: major config, active phy/outband/sgmii
> > [   12.339738] qcom-ethqos 23040000.ethernet eth0: phylink_mac_config: mode=phy/sgmii/pause adv=0000000,00000000,00000000,00000000 pause=00
> > [   12.355113] qcom-ethqos 23040000.ethernet eth0: ethqos_configure_sgmii : Speed = 1000
> > [   12.363196] qcom-ethqos 23040000.ethernet eth0: Link is Up - 10Mbps/Half - flow control off
> 
> If you have "rate matching" enabled (signified by "pause" in the mode=
> part of phylink_mac_config), then the MAC gets told the maximum speed for
> the PHY interface, which for Cisco SGMII is 1G. This is intentional to
> support PHYs that _really_ do use rate matching. Your PHY isn't using it,
> and rate matching for SGMII is pointless.
> 
> Please re-run testing with phy-mode = "sgmii" which you've tested
> before without your rate-matching patch to the PHY driver, so the
> system knows the _correct_ parameters for these speeds.
> 
Sorry, I forgot to mention that all the recent testing is being done on
QCS9100 Ride R3 which has the AQR115C PHY.

My rate-matching patch was for IQ8 which has the QCA808X PHY. I am
putting its testing on hold until we sort everything out on QCS9100
first.

So, for AQR115C, what should be the way forward? It has support for rate
matching. For 10M should I remove its .get_rate_matching callback?

	Ayaan

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

