Return-Path: <netdev+bounces-294760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bE7rDKwzIGoRygAAu9opvQ
	(envelope-from <netdev+bounces-294760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:01:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D7763854B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:01:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=X6+zCHDv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=SePFGBJB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294760-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294760-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDD5F30EF655
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054E34166B;
	Wed,  3 Jun 2026 13:53:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2B33EAED
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 13:53:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494816; cv=none; b=oIgQYI4fhVh/M/O84wWU/63+X90xLfX0wk7I2jPAiQCpmov7e7yQEz2R9Z92I4+ORa5hRaTw/hf+HvZih2Iu5K56w1xDTNsTxyymzbstTI6B7t2ulEg37QaYajm0OMRuDwiXP9nZ3zAJNHveOHdd8C4mzFGo3lJKYrNiqXEORTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494816; c=relaxed/simple;
	bh=Kxg4izlmwj7LwxfFLu2aBpQLhsk4DEUzcCIErk2RmSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMWQhH9jvyB3CeKjUFX6bwDfl/VkOoDvV/LtrmHzeK+/6Y8+ohSPt1KdOkGPs/v1VmvQgzFKY0ciu98qCUvxb3GsGDHP88o6Kvqj+mCC8mTT+aKsXuUPVeK/VMptZmLb/DhNOes/dqy4UabJ79fN0NINPAez3vlkVdkxH2YBVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X6+zCHDv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SePFGBJB; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653D1Aax1755348
	for <netdev@vger.kernel.org>; Wed, 3 Jun 2026 13:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o2gXuSzDvMwhzE9ePHaMQbJZ
	dEEJ2hqlmhoJd6fHVZM=; b=X6+zCHDvowsmUTUhYFBzwcPf35zZ6TfdaEhLrUKr
	qJV+tBg4zuJLlL7X1iB/BnYW69iOrkeUPR6AU0RaP/mbyR01BFVtR0B9K1A9xYa8
	iD+csB5QmW+aDmbfSiDHL9v/wKA5R/xjNdljFH2HXUgBbfoPO9eSCwOWb0eo1abs
	WHVejmiEYVAHMKFLo8FTzgyCrnOsxnWGKtdYwTGVeHVJksjfLGM06zAQjqhP6Gad
	dds2Bv+5hAlBgXDvXT5I83JIrrK2UxLa/L6eiOoXl58ayDlprI4DgJTIIajkCukr
	DGOLhLMq3Y381mtxW+ixav4348Gx/VCpy03klhQZIMZn5g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejff01m32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 13:53:33 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963b0a0b727so1179691241.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780494813; x=1781099613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2gXuSzDvMwhzE9ePHaMQbJZdEEJ2hqlmhoJd6fHVZM=;
        b=SePFGBJBq2ghnr+OkrunSQra2SWqOK2FV/QbUqCxj0DUxfdaoUNTcMz/uYbNIiH4/W
         hok8q6/B+Kt8z5ZzI72VMpekx3Suu5AgKMVNxD6v1cUTyD0h9XCQZfqNGUcWPDwerV7O
         gKbnju72QXXBH/mu4YAq9+u1JmNQTbhIbhmQE3RwG4MzAn6xzvvgUgyzRjcKepMbD8yD
         amUh1R03yQCyFKikXfBOHmYmv2dcP58Eg4S0DG7jAEkRz5ssd8SzDjd70FddLKqbfnF4
         +3z0vSxnLh2Np/7WoFgEUYXq1wQcc2sr6fb6v2gJaVWyPS7dkJ6lCqN0zSyxZVGjvuxz
         qzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780494813; x=1781099613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2gXuSzDvMwhzE9ePHaMQbJZdEEJ2hqlmhoJd6fHVZM=;
        b=HedP4c1c9CfRl1UX4pttLiv6rFtS7F1FUl4+i5UjPxBWH148333ab6KX9lirm2ErQk
         xJvEGKevRolKKjMu2GiLtZUf1uCw6qJNnS+Zz1+26eX4BxnRf/9qSdLez76hTeIWlvo0
         UDtmLThwKGMDwSEzN7afgDvlaR+/IP37LBXtmBlE24GAyldnkL3P1ZRwC3C58PxOBmpE
         BDBp68bvoKAyKWx99unjaJnwCwDz3qjH1K41wL1S5JY5u6GHNEvcaJAfURELQx3qq4RC
         Hi4Kgz6pKUO8NbsPWZPOdOZnBOWiqEcTgfxyrjrSe05raju64drYfervB3eQja0+IZUm
         eLcg==
X-Forwarded-Encrypted: i=1; AFNElJ+MyZoU+3Xfi4TcyXcKEb6R4LCROiuctxzDdlquJdLWSj7HtJWkf3+GcrGGEYl9bQ6ng/NuCkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKduyVNzGs00MeUPn73xb71MMBSoHbS7weidZr6bbKPkZejwX
	GBge0D7Inuw9uGNqqBNz5g3Sq08xPwkWaa+5IITRdnO5aI8iZpuFvo9Cd/x83MCkbiJFSSCX9Yi
	7mTINOZpQXtx4KIwKv3QqTPIPvzrWgWsOfpJ9HH+y42Ggq50VZoJfMEH6+kk=
X-Gm-Gg: Acq92OGPkkxbcTeJgtcYiXf+drhX7FvZpl1YMm4U2emkN0xkGCzAiFuePlfoTNDjt7o
	9m2gydz3UNXHUqSrgoWpauXlvQD/clAdhVbNy0Do/fB9l51kpH91sydaYbdBSgYkEhbXcIOfaSg
	kH8rwaLfQK8sOPe88617q9VaMp7fydNJIqhh+2M4NVQsYINMFPJHX9W5rL3VcnRlHDthmyQUMUO
	dhF9+YvM0mHBiObILmv27MbPY438zlIZZicqh74IoCp0m4r4+Q71yQVZVutpG2FiMHun674LWzY
	lPVKlXLmTvWpEtNhVEJ5tLZrz3/MsS1Axzq2JLf27TxhD5t2r8XgbIm8j0xKemc394YNCf/2dbH
	c9nTxwETTmQibx69jIvswwAgSr1VaIODBUawQcygbmityga0FRYgvTYpmTdzuBYPpXUriDjoMau
	hcBFCluUgg0mmIh0V4NPOsrnz3HzAdUfkC1XlMDye2lpHLtg==
X-Received: by 2002:a05:6102:14a8:b0:634:92c:bdce with SMTP id ada2fe7eead31-6ec2c4c37acmr1647388137.12.1780494813135;
        Wed, 03 Jun 2026 06:53:33 -0700 (PDT)
X-Received: by 2002:a05:6102:14a8:b0:634:92c:bdce with SMTP id ada2fe7eead31-6ec2c4c37acmr1647372137.12.1780494812648;
        Wed, 03 Jun 2026 06:53:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbcc7sm671127e87.23.2026.06.03.06.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:53:31 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:53:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
Message-ID: <o4a5xuxznwkgpdj46w3xi7ouvktkwziedkbkdmd5aqdzd444qm@ggkfcgyzjk6i>
References: <20260602-ipq5018-gephy-clocks-v2-0-65a1f1d881f3@outlook.com>
 <20260602-ipq5018-gephy-clocks-v2-4-65a1f1d881f3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ipq5018-gephy-clocks-v2-4-65a1f1d881f3@outlook.com>
X-Proofpoint-GUID: IvVU9o8VyCo2UkoL0ZuyU00haSEysYAR
X-Proofpoint-ORIG-GUID: IvVU9o8VyCo2UkoL0ZuyU00haSEysYAR
X-Authority-Analysis: v=2.4 cv=LYwMLDfi c=1 sm=1 tr=0 ts=6a2031dd cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=UqCG9HQmAAAA:8
 a=G26YxGutZnFJZCfQOsMA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMyBTYWx0ZWRfX8yg38+3B4nmz
 7482Q4g9QEXVizv80fpEd/9n07FnXgjpVvuqRG+nRl+hlZhQMUJBQNdifaDcFgtmGeeBPB7fKFR
 TlXL3UGg74VQnHiGHI4OYHZqQvuyb4K7Hh6dr0XyOXh3x51VllL6xFQnNeeqPxF5rOvuy+VfxVg
 TIT017fqIZqyIZl6Eynk2Pvo2ZNwFEgMooN9I7nR7mOqtzirumNiVNZrojbflCTkib7UWeKWmae
 B5TvPV9ZB5aDAm2I5Qyev7gTvdGekO0SUVrD8epkdC4lMH+YPCT4TJ0MbkHv+MUHsgm1woilfMg
 nyL+Te34iCBuZz8xqj7JD0q+LTuKlRZy9hyeFFbS6mmhGCNweeJenVYAYUrpmUSfID1wM2yYHw3
 roqhW8ryFUxUu9FFbF6DOcGf3T4dOQ/Soa8n5wZgogei6sOXQgBt9KhozI/VM4RCGoyP4Qv41iC
 9JsGGgKZRQgpyyc6sUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030133
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,outlook.com:email,qualcomm.com:dkim];
	TAGGED_FROM(0.00)[bounces-294760-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:f.fainelli@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RSPAMD_URIBL_FAIL(0.00)[ggkfcgyzjk6i:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[netdev@vger.kernel.org:query timed out];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3D7763854B

On Tue, Jun 02, 2026 at 10:50:40AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Acquire and enable the RX and TX clocks for the IPQ5018 PHY. These
> clocks are required for the PHY's datapath to function correctly.
> In addition, gate the clocks upon link state changes for improved power
> management.
> 
> Fixes: d46502279a11 ("net: phy: qcom: at803x: Add Qualcomm IPQ5018 Internal PHY support")
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/net/phy/qcom/at803x.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
> index 63726cf98cd4..b7361a14220d 100644
> --- a/drivers/net/phy/qcom/at803x.c
> +++ b/drivers/net/phy/qcom/at803x.c
> @@ -19,6 +19,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/of.h>
>  #include <linux/phylink.h>
> +#include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/phy_port.h>
>  #include <dt-bindings/net/qca-ar803x.h>
> @@ -176,6 +177,8 @@ struct at803x_context {
>  };
>  
>  struct ipq5018_priv {
> +	struct clk *rx_clk;
> +	struct clk *tx_clk;
>  	struct reset_control *rst;
>  	bool set_short_cable_dac;
>  };
> @@ -1062,6 +1065,16 @@ static int ipq5018_config_init(struct phy_device *phydev)
>  
>  static void ipq5018_link_change_notify(struct phy_device *phydev)
>  {
> +	struct ipq5018_priv *priv = phydev->priv;
> +
> +	if (phydev->link) {
> +		clk_enable(priv->rx_clk);
> +		clk_enable(priv->tx_clk);
> +	} else {
> +		clk_disable(priv->rx_clk);
> +		clk_disable(priv->tx_clk);
> +	}
> +
>  	/*
>  	 * Reset the FIFO buffer upon link disconnects to clear any residual data
>  	 * which may cause issues with the FIFO which it cannot recover from.
> @@ -1084,6 +1097,16 @@ static int ipq5018_probe(struct phy_device *phydev)
>  	priv->set_short_cable_dac = of_property_read_bool(dev->of_node,
>  							  "qcom,dac-preset-short-cable");
>  
> +	priv->rx_clk = devm_clk_get_enabled(dev, "rx");

Why are you enabling it here? Won't you get the notification to enable
it if required?

> +	if (IS_ERR(priv->rx_clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->rx_clk),
> +				     "failed to get and enable RX clock\n");
> +
> +	priv->tx_clk = devm_clk_get_enabled(dev, "tx");
> +	if (IS_ERR(priv->tx_clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->tx_clk),
> +				     "failed to get and enable TX clock\n");
> +
>  	priv->rst = devm_reset_control_array_get_exclusive(dev);
>  	if (IS_ERR(priv->rst))
>  		return dev_err_probe(dev, PTR_ERR(priv->rst),
> 
> -- 
> 2.53.0
> 
> 

-- 
With best wishes
Dmitry

