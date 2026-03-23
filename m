Return-Path: <netdev+bounces-270728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBuON1ShwWmFUAQAu9opvQ
	(envelope-from <netdev+bounces-270728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:23:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D22FD283
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07330300373E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C73AD508;
	Mon, 23 Mar 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hrwgHYkt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBlf1LBF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60036D9F1
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297422; cv=none; b=Joob0YChFWIpWUFkMaS8wO9oll/AzN90ztDXKhny0VEi3ucImoQAZIqxOF/YK8YF5m/FDERnlE7g/LngiBUStLt8APp88wstG5zLS6qq+EE+wZheIoEk70V8yVxXyJzK0xjeVgJ+F5EzCHXCyVmKkg9z1hkBSk1O6xkoIOZAiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297422; c=relaxed/simple;
	bh=Ev6HL6r39nKqcDtyLtF9bFrf3NNu6kw4S+h7+fE4k2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gis5cGTnHVaFFwKxaoo2OvTt4TMR7yjvEH+Z20Kw3ITuWiWlnrNbBXY4/pDu3xA0V3OGWlIeUAkVQIeMK8/tpIlYlXLszMLAAkgdPOhoJ/rFzmG+iswTPXm9r4kfY83Vxo074MNuiUCIbWyeH4+1iRY7thOcgbz29GoenArvPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hrwgHYkt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OBlf1LBF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqZsS943555
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=olrg9+koKbp1wST4wwsyJvh2
	+Fhta++w8bB0JufkCNc=; b=hrwgHYkt1QFkdKuInaLwrkqFZ8cI3EhkOa53XLsD
	cbxrVjDJmZuW8PBe/zJ6hrCed2qH69LJeBNHdo9Q4QM3Nk0vUsnuK4T6/TEOXcEc
	t4h0TBFfOpYZFCzY8QtbYw+hyZ83aoPhB/RenJdJMo3cNayobtYjLa+fbbL6/Sio
	eAQwLkwYt09VoWUbb5LKI2OjES+lYfzalxhWGZxt8e0S6Op41Ut1YIGxlIuoLxL4
	7do+kdJn+/hTsV5vUryxB0tQ4DO7asIvpx1aFugKM6JPcSVkhoxsOjxAi1p9fsS8
	PXADvEucj7538b5FkLQpgU4u62f8QNlt707hQHifB4glzg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkst1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:23:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358f058973fso918598a91.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774297419; x=1774902219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olrg9+koKbp1wST4wwsyJvh2+Fhta++w8bB0JufkCNc=;
        b=OBlf1LBFJAtSYbbFA8jC0PPzVqWWxfz8ZaT7+bI/OJHJNH/QfHF++hwX59wotKtbGQ
         8v6E+ibGtQDpwBzdfWVclVbF5T7HsRU9XSjFlsueG8MuPfgy20e0f0iMkE+spAnNhAzX
         IKj/pukFm3zxjO0v++E9hb5ihwHZxGgU1v9MByTJ7SRf61UNwfVIRgEatoCrzS2T9h40
         hfrA0dGMdmoKHUyY+Tvb1iD0/hQBuWhR3SEHFgwV4gi9oKyqpIXYGyIVVVaT8xSqvZYv
         YnOH6cVasOnPOdXcDphPi0eRcUJUfx21hzJ97eLjC1Jg9cwi7PNUhC/8OPQ/bsMi7T7x
         FgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297419; x=1774902219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olrg9+koKbp1wST4wwsyJvh2+Fhta++w8bB0JufkCNc=;
        b=EVPIQ11Mzb0os4oxxL4El5+RfNKeEyADwNQShJHta5LvXTeaxReylNH5GEFWij7A0K
         PR6wFP+mjs4OKfcUm6Pwk32xPuZ58T5fBo5iWoVOvhOCJde5C3Ad6dMGx8jS6Q/RM/iA
         IlQ9/5htAkVk3aszXmZvSqNIRXnFcu0cxEkM9WIPlE7T4p9s9r1xgXpM5OTBS0gmvK3/
         cGz40G+bRtJjPuj+lmzgmZOUO8FdnM1oUS04enCdllMITyTW6Fqx+QCAzsB0a9bHM2Xs
         s4d10RIEPIazjOy/BkoMNwV7ez5owMGuqnOtab5xgK3TUlXul58CSjiyuS8vP3j2WMeE
         A5vw==
X-Forwarded-Encrypted: i=1; AJvYcCUiFXyuN0jL/cCUA7TOPk1o6pxuQni9kIzyFgimkVIsZQF5dVJMc1DSs6ENihSw7V47fp1lEFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5L/x7ZrzBzOeqLslkcToFHO1Sdnp1ugFFMNdTwimZ4A7sCR2
	DRyWn+OenEsYDoArNyfNp1QwF65f0hFiovtgQvJemWZMN0xJHfN5iOSFuE65EsQ9ZtNTJo+7FkG
	C9ucz8uvi3CJFXE8YFcHI1rYIgyWQEGbrgPvkhlvlR4Tb93/8APKKHXHaYpM=
X-Gm-Gg: ATEYQzzdJ14zJbNoYGSnPVGsmsSJtqd4YzN8Pjnkk1c3uFi/nmAkNRa5uH9TCzVpOzx
	h3fr1Ecta2Hh+r02twtdJmi6Jv4yc2DzJEATT7IVJnMDjQQB0iNJY4KMCqEnMS934Tqr2tF0txk
	VVn7WwDyGPibNgbMhSDf9myLUQz/gsdaX2IqdzMcBfdMolQYnbPQnenQXKTxJCiExS7e9BOxNeZ
	/mESB6pV4swaqaOvGUN2tuGhvYdKPA3FPbUqJ93wkacJrTfrMq5ZYgSFZI4TnOljWDM6gMRi0h3
	817Yp7CCQ3CIDDqge4ozL40kuJI7no6R9ZAxqAMqUUxzxMezG8tUP3jV21dlnKXr3IcdFfq2qno
	tlr4w0Xlr5kYfTn0a663wKCY76zvDBMlbQCA=
X-Received: by 2002:a17:90b:35d0:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-35bd2d0dabcmr12741294a91.28.1774297419028;
        Mon, 23 Mar 2026 13:23:39 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-35bd2d0dabcmr12741263a91.28.1774297418454;
        Mon, 23 Mar 2026 13:23:38 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c015cd6c3sm78727a91.0.2026.03.23.13.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:23:38 -0700 (PDT)
Date: Tue, 24 Mar 2026 01:53:31 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 0/8] net: stmmac: improve PCS support
Message-ID: <acGhQ0oui+dVRdLY@oss.qualcomm.com>
References: <abdEscs44fU4kRag@oss.qualcomm.com>
 <abdYu864OmNWiWIW@shell.armlinux.org.uk>
 <ablpxwGks9m38fhM@shell.armlinux.org.uk>
 <absjNQ2s3Z5N2Zwo@oss.qualcomm.com>
 <abtE7sDT75I7uPnk@shell.armlinux.org.uk>
 <abvAuHFZzCFobO-V@shell.armlinux.org.uk>
 <7566c66b-2dda-4b29-b59e-4e4a7e159e21@oss.qualcomm.com>
 <abvy6nZyjyxUXMuf@shell.armlinux.org.uk>
 <bcab38a5-e7f7-47c9-ab9c-99294e095c22@oss.qualcomm.com>
 <abwSHGw39FTJGNb7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abwSHGw39FTJGNb7@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE1MSBTYWx0ZWRfX61K5B+0w67/o
 O1KjiaZ97Xxj6ItQEc7FCG+eW2li/6VhjOGOTRssP+1YZDhAZ5QiJ4Fcy9RpGWLyCoAQYJujmj1
 vfpTh2K70RKoN6LEtgY8LhtOxj8LTZJX1MlBUusiBKa43ZEzL/sydmMgJrNkA9Oa9otSmEKXrRx
 5oIqCmm5KBkRjZZvqpv2Gper9Lm6N69CPleKY9DO/K60Zd8yip4TjqHV1TbM1mgx3dhVuoP7E8p
 3VbUK5N1fIueXTe0Cpl8edUla20ki1109yfcp/DkhhQqpmZ19ukC9q18VJIeBJETBVlyKlCwBHT
 QmOZpVYiLfDM469uKy5zwCEXrib9TkQdq7U+ZNJnq+DskCn1hLZnGn4JiN7qrXOjlHMKHvF28t7
 E/jwiEgdQICJqvIlu5ep/PpeJ8R/OLEac9BEX0fdNLU+rAFw4MXYn4IvPij2wnOuRiET3PeLYWi
 Twia1wmw4k18b8IzIHg==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c1a14c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=G4x0Uraz-9_3_ZZlgMgA:9 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: V9NhIeWFaVr2qqbbPW0dU5g6YpQoPShj
X-Proofpoint-ORIG-GUID: V9NhIeWFaVr2qqbbPW0dU5g6YpQoPShj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230151
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270728-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_PROHIBIT(0.00)[1.95.144.0:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E01D22FD283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
On Thu, Mar 19, 2026 at 03:11:24PM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 19, 2026 at 02:50:29PM +0100, Konrad Dybcio wrote:
> > On 3/19/26 1:58 PM, Russell King (Oracle) wrote:
> > > On Thu, Mar 19, 2026 at 11:09:33AM +0100, Konrad Dybcio wrote:
> > >> On 3/19/26 10:24 AM, Russell King (Oracle) wrote:
> > >>> On Thu, Mar 19, 2026 at 12:35:58AM +0000, Russell King (Oracle) wrote:
> > >>>> On Thu, Mar 19, 2026 at 03:42:05AM +0530, Mohd Ayaan Anwar wrote:
> > >>>>> [    8.650486] qcom-ethqos 23040000.ethernet: clk_csr value out of range (0xffffff00 exceeds mask 0x00000f00), truncating
> > >>>>
> > >>>> Please look into this first - with the MDIO bus operating at
> > >>>> who-knows-what frequency, this could make reading from the PHY
> > >>>> unreliable.
> > >>>
> > >>> My guess is clk_get_rate(priv->plat->stmmac_clk) is returning zero,
> > >>> which means we don't know the rate of the CSR clock.
> > >>>
> > >>> From what I can see in drivers/clk/qcom/gcc-qcs404.c and
> > >>> drivers/clk/qcom/gcc-sdx55.c, this looks like this case - the
> > >>> struct clk_branch makes no mention of any clock rate, nor does it
> > >>> have any parent. From what I can see, neither of these drivers
> > >>> specify any rates for any of their clocks, which likely means that
> > >>> clk_get_rate() will be zero for all of them.
> > >>>
> > >>> Sadly, when I designed the clk API, I didn't think that people would
> > >>> be stupid enough not to implement the API properly, more fool me.
> > >>>
> > >>> Under the old code, we would've used STMMAC_CSR_20_35M, which means
> > >>> we're assuming that the CSR clock is between 20 and 35MHz, even
> > >>> though the value is zero. Is that the case? If it's higher than
> > >>> 35MHz, then you've been operating the MDIO bus out of IEEE 802.3
> > >>> specification, which can make PHY access unrealible.
> > >>>
> > >>> In any case, please fix your clock drivers.
> > >>
> > >> I'm not 100% sure the currently-passed AXI clock is what we want
> > >> there and the docs aren't super helpful.. is there a synopsys-name
> > >> for it? What rates would you expect it to run at?
> > > 
> > > There is no easy answer to that - it depends on the bus interfaces
> > > and whether the CSR (register) clock is separate.
> > > 
> > > The likely possible names are hclk_i (for AHB master), aclk_i (for
> > > AXI master), or clk_csr_i.
> > > 
> > > It does state that the CSR clock should have a minimum frequency of
> > > 25MHz to allow all statistics to be properly collected.
> > > 
> > > The rate of the CSR clock needs to be known, as selecting the divider
> > > for generating MDC within IEEE 802.3 specifications is rather
> > > fundamental. You may find something there which hints at what rate
> > > the dwmac's CSR clock runs at.
> > 
> > If it's either AXI or AHB, in both cases their direct parent is controlled
> > by an entity external to Linux and their rates may change at runtime,
> > based on aggregated needs of the bus. They're defined as levels/corners
> > (abstract term for a hidden volt+freq combo).
> > 
> > It may be that the operating range for the EMAC removes that variability,
> > but with no concrete evidence and just anecdotal experience, that's only
> > the case for the AHB clock
> 
> The important thing is that the MDC doesn't exceed the max clock
> frequency for the PHY and any other device connected to the MDIO
> bus. IEEE 802.3 specifies a max frequency of 2.5MHz (minimum period
> for MDC shall be 400 ns). Some PHYs can operate in excess of this,
> but one would need to confirm that all devices on the MDIO bus
> supports higher frequencies before using them. In the kernel, we
> generally err on the side of caution and stick to IEEE 802.3.
> 
> There are two ways to achieve the divider value with stmmac.
> 
> 1. if priv->plat->csr_clk is set to a value other than -1, this
>    configures the hardware divisor (for "normal" cores, it takes
>    STMMAC_CSR_* constants that can be found in include/linux/stmmac.h)
> 
> 2. otherwise, the rate of priv->plat->stmmac_clk is used as the CSR
>    clock value, which is the reference clock for the divider that
>    generates the MDC clock, and an appropriate divider is selected.
>    Given the available dividers, it works out at between 1.25MHz for
>    a CSR clock of just over 20MHz and 2.47MHz for 800MHz. (I have a
>    patch which documents the ranges for each of the STMMAC_CSR_xxx
>    values.)
> 
> Note that the dividier constants are not the actual divider itself,
> as can be seen in include/linux/stmmac.h
> 

As noted by Konrad, the AXI and AHB clock rates are indeed unknown to
the Linux kernel:
[    7.739389] [DBG] priv->plat->stmmac_clk rate = 0
[    7.739391] [DBG] priv->plat->pclk rate = 0

Additionally, here's what I found (focusing on QCS9100 Ride R3, but
most of this should be applicable to all qcom-ethqos consumers):

1. clk_csr_i is connected to the SLV_AHB clock, named "pclk" in the
   devicetree. This is the source for the MDC. The "stmmaceth" clock,
   provided by AXI, is used for data transfers. It appears that the
   devicetree gets it in reverse as per the stmmac clock
   documentation added by Russell, i.e., the right order would be:

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 147ebf9b1ac6..f1aa2490bf6b 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -7111,10 +7111,10 @@ ethernet0: ethernet@23040000 {
                        interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>,
                                     <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
                        interrupt-names = "macirq", "sfty";
 
-                       clocks = <&gcc GCC_EMAC0_AXI_CLK>,
-                                <&gcc GCC_EMAC0_SLV_AHB_CLK>,
+                       clocks = <&gcc GCC_EMAC0_SLV_AHB_CLK>,
+                                <&gcc GCC_EMAC0_AXI_CLK>,
                                 <&gcc GCC_EMAC0_PTP_CLK>,
                                 <&gcc GCC_EMAC0_PHY_AUX_CLK>;
                        clock-names = "stmmaceth",
                                      "pclk",

2. However, even with the correct naming, clk_get_rate() would return
   0 for both clocks since they are firmware-managed.

3. For GCC_EMAC0_SLV_AHB_CLK, the hardware documentation mentions the
   range of 50 - 100 MHz. I am trying to check if there's any chance
   of it turboing to a higher rate. For now, I think we can assume
   this to be the working range.

In view of this, would setting priv->plat->clk_csr to
STMMAC_CSR_60_100M from the glue layer be correct?

	Ayaan

