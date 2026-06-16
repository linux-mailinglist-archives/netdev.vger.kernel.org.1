Return-Path: <netdev+bounces-299914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AojGDSl6MWpqkQUAu9opvQ
	(envelope-from <netdev+bounces-299914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:30:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 933AB692266
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:30:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gbta7TdU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hinEEWEr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299914-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299914-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4AAD3228145
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4309243E4BA;
	Tue, 16 Jun 2026 16:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082B44CF37
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:17:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626649; cv=none; b=flv1J1SPH3L4JuBRm6AO+iKzeRAHj5BqOP2ka4fCPib2TvW/6ii8UQjPTqukBifKI6FrgEdscbnfPtZJ01exsHWZosBGhayCmf3hzlhHEiaQ2gqYFKcWP6Npef8tteJhaH/RsbHml61LkCBb3HcNcNgZ7quVr8O9zaLbz7M4b4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626649; c=relaxed/simple;
	bh=Gpu8Y3KK60SVZzWxPNeDmjgN5yrbsKeY2CSqd06xT0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlk5koNfg7Dsz5f37MxbFLmT3sACOnbJrVlIO+fnLQMrK7ywZNu9yJiG+orDXIguy5LKy2SzYGKEbUaBbvMURnbxjHGXp6K3oEl4rMXR9qAMCUpqpq4t1UXuBwjh4DIROHLffmKK+gAFsAcs0Sf2petQf/whuYHHTNuqC5cQDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gbta7TdU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hinEEWEr; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFcrII3666607
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=k8jmCjdOTgQQP3Z1ADzlmkhE
	ZtRTG+VtASOwyDTz8jQ=; b=gbta7TdUF6RhAfaKwmB36JsrXQPLO2pBds+OD6d9
	nKHaRAyIgTz7NxxeT4kAsQUIJCocUvOAmgffkmvki5Q6VI3Rd+b01RToTZqEVwOH
	QzNgjWF0gFkGKynJEPD7T9WeZ5MzyA6jZlfwswj/hacGUZrT3W70KTJ5cxP1TdwB
	+WViBjJ4SABFJVK/UPel1wBy3EP2/sYRKCZA/OC31JM+a+tKMjwRtomKGhB7EY1x
	tKjpS23Yf3gAdmBq6ylx3pkJ4U5UA6EwHvo0b0yPfS6mV4lDSy7z5Z88WS+H7JOS
	Zl/21WSpfszSNfTgUfKo44yX1wJogqbhzxT2FC6yj9xGXA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1762mdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:17:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d97955899so4598804a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781626647; x=1782231447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8jmCjdOTgQQP3Z1ADzlmkhEZtRTG+VtASOwyDTz8jQ=;
        b=hinEEWErZMYYuujvAd1yNAQCgAvUBQfPbs5hBQ1RRr3UdA0BOiuWi1Sdx7E292kzen
         L+caUY5W7RXyDGCwhoOvXU1fzfdLyoHKFrVreHMNs3Y62N9v+18eLDOVLPs1Ky7dfper
         rbLEHOgWPfjioNzyRzMw08KtXADuHmZNAp5T7JnY+Tsc8Xt24P7KfyDp1y2/Qk8EWEuQ
         nf0TFl7tnB5ZjR7FSe7GGi7TRO/OtajFR7ihHHYC7Y8szzqfVaMnpxpJvLt3zavT8mse
         tA/CDvZJ3R5s1dhtfOWc3BUJ2erT9bcI0hf+6LiRbER0KGvRdUAHsXu8W/XCEqm+uvCh
         FOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626647; x=1782231447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8jmCjdOTgQQP3Z1ADzlmkhEZtRTG+VtASOwyDTz8jQ=;
        b=aU7//KaTwth+d840wx/hRl41Ha1WrnzB74C1nYWfNV7zv8RQHbVFBf/pGIm0cse3L0
         PUeKK9Cti2wiNOIZuJPiGaIkPdDlV800thPwYCEioIdpk4z6wJm1tsmYFkQV7XyEyIIW
         hfrKNVgmNUGTUHUdTkyDH6TM3ZM4TCo3McSTNJlsMyvJ7ygL7JPiPqEH5u8Z4HhiLRph
         ZzFmkH4RPqTvtSanAG36/ekrch0QzVxINvGMd4cnfsVss98vqjpteqHmCVWRxQMAqPf3
         6uqKTCRTP3/moA185UfuPz/OfUEVX++57bTbqiRGbxFaYF2kdThUnr+1qAd/vgfwpFG1
         3PwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JBAk9oF/4MXwo2y3LZ8391XBqk2FrYrhVw5lwuSrovvYjMB024EAaRmy7x0qT34JS9kcpwRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3S3e/xqBsKx9GSpnT19Q0eN8tyPKRotBiykgDl+S21Ke2Wms
	s7GNuKIRZjOE/xuX1wc+5Zuxw3QkZUpv99jLiLN3E4P+jYFCGOyE6H3B3Cj2GDj+H6v7Xg4xaRZ
	OWjx+J6+zNh+mRfjEzzdH6szoVCqUUU14+E0UM9UFWjTtXj0wQKIzd4lDDdg=
X-Gm-Gg: Acq92OHbuA4eH5zWqBTKUFSmB6Hv23UUqcgBx6NEn4auTANn4SbOBsi6xogKOMfq33I
	XeyhmvTsWDeiU+qK23Pyo9yQWHl8DSbBRULXHvf9bZ1HELeUUXvVrCyO/dViXWk/RFxef482KWf
	I73ioYHJycOGzB1MQhaLFezWfJuTDrHNY4Y8K9d5VENZw/3ovfbpU+6Hx9IxfEx5AxSYSh0vb9O
	QkQ5/pHxN44XTByu0XF8L0BYjb/0Io3nyDccaNitXM46PcXtxRi6lYTmxy1yiPMfC9KhFWvXCiB
	+N3FkiBwMSiIz0qMkFwihsoc6yf1mTB2JHs57ihPF545uGKwtJrMR3k+aRLPsIV2XzM9tDV67s0
	MSPg1EWPd8PavzPlsDccNAjgjdNzqGATg9zg=
X-Received: by 2002:a17:90b:4ac7:b0:368:3d3e:efa6 with SMTP id 98e67ed59e1d1-37c93969a18mr139712a91.20.1781626646596;
        Tue, 16 Jun 2026 09:17:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac7:b0:368:3d3e:efa6 with SMTP id 98e67ed59e1d1-37c93969a18mr139656a91.20.1781626645979;
        Tue, 16 Jun 2026 09:17:25 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm12281484a12.0.2026.06.16.09.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:17:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 21:47:17 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 4/9] net: stmmac: qcom-ethqos: add per-platform NOC
 clock voting
Message-ID: <ajF3DUGYPBs1iU5f@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-4-f0f4a1d19929@oss.qualcomm.com>
 <45d7faac-7c0f-4f89-808e-06129e8420e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d7faac-7c0f-4f89-808e-06129e8420e4@oss.qualcomm.com>
X-Proofpoint-GUID: gYbzIjrK5BCMCCk2_F3qRr-i7LCAO9XQ
X-Proofpoint-ORIG-GUID: gYbzIjrK5BCMCCk2_F3qRr-i7LCAO9XQ
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a317717 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=267an7I0AjvZusCT9TAA:9 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE2NiBTYWx0ZWRfX+C4mt72Gu0bh
 1p44f/9WhFOOX0XU80OwDawO3J8fCfK0dU8I0lglgBwfWp5Jraz0dAvVUHuNwcRHORj+Hyde83x
 odMJkbFBnyR3LGQ3btWgLUklb7OiBvQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE2NiBTYWx0ZWRfX/YwdRgHbpPkT
 YY4Hniye+jWG6beMyB0gNx5sddtsMCraveGY/WLRjvO8eMSW4uPUCBWY74WT4wfjVd39oShyC6k
 nzuZCUG2hUWe52tPWoFnEm8D4NGzCEaH4HwjiauSC+XeWMmM3KFG3w8TEoXwA37AuyPsg6YrnY/
 j7LOGQQ9HvK9InxvQ31rpfRL0+TyklB6LQEZWOmv9t4gOHJAodiN+8Lq327PTAaySUVz/7cNh92
 9usrfc32Zo/4AKU1Xxt1Mh2bUeW9gNw1BsdLRLMzptc3t98/83HE5UQHkoNI4cHJRzVRA/t5xMX
 g07Gv14nVPiWEIswk3eOeCg26C5Sba8HRGXb0pcWFsZpfll8lBIyZ9mgltzDmrChcCgi6qtbLjg
 Ah3tiax9MlOCpLQOaei8y5K4ZylEDGVtEGDfvzvr8LWhun7bMGim7Gp6MasfkjK2rwmVCexqhRY
 5PxVGbkI/ylv+upnooA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160166
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299914-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 933AB692266

Hi Konrad,
On Mon, Jun 15, 2026 at 02:13:05PM +0200, Konrad Dybcio wrote:
> On 6/11/26 8:37 PM, Mohd Ayaan Anwar wrote:
> > Some SoCs gate the EMAC's path to the System NOC behind dedicated clocks
> > that must be enabled before the DMA can reach memory.  Add
> > ethqos_noc_clk_cfg and the corresponding fields in the driver-data and
> > runtime structs so each compatible can declare its own set with per-clock
> > rates.  The clocks are acquired during probe and enabled/disabled
> > alongside the existing link clock in ethqos_clks_config().
> 
> Sounds like we should use an OPP table instead, we can't just do 
> set_rate() on qcom, as that will not propagate the required perf
> state to the clock controller's supplier power domain (i.e. VDDCX)
> 

Understood, I will test this out for v2.

	Ayaan

