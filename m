Return-Path: <netdev+bounces-299922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sw+XGACCMWq0lAUAu9opvQ
	(envelope-from <netdev+bounces-299922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C6E692B0F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HBcQsOmQ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Tbzczjuf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299922-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299922-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7784931D1572
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73747B432;
	Tue, 16 Jun 2026 16:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594347AF4D
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:50:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628627; cv=none; b=OSnJuc17dCOdWcqvWBYCwIu7PSGuCsRsPGZ9niJUZQHw66ehIjk+TcJ/ZmYPelAXah8dP+/t0VS8twGuBhvl9cEsV4cqp/XnMRIKDLCAGwAb7rXE6J/2NAwgWBfXj3POeJsY9rcmsvRtqQs3LyyuGqyFScPxaC3txzbiFp8/rhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628627; c=relaxed/simple;
	bh=IeLUcKceMGp4R1jgMISZkNO7RSur2PrOa7F1GuYJITo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISTcehCo0q9hcS31mwOCSTUIdP0lKJF9jn8GO5nN72DTsCowiGCViVVtxK8SOpoZ22z6D+M7E3VrN7l1hn7DcT22Wwv9N10ZPG8ykff1B3cefZwBTILAOXA1QdSLe00x/kKtohWrHG9i4cf4EzV2pOiodbfWl7/KhYDRPlDzw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HBcQsOmQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tbzczjuf; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFdbO13966193
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZOml+89Fh4slDZjDTDeUJgvR
	UxvqEHajVZitLYJCVjk=; b=HBcQsOmQY8YSSYu1Pd7AolxN7wxdOV5JaMmftSza
	1HmnymCwzB0EcCCZ+JHWjGiizsEHouhQPLgJtBorYRsBceIJMn/PdvlvpI/T5KqN
	3AbZMx7/dLKqnMSFkgyOhbbDaufPuy4VSJQNwYKOatlJuZMJUx6VC1ycTewcIuau
	ygQ9FUD/2J52U0O9X8Wku9yfzKGEnp9tumOCHz9H/uujiWMm/gHp/5CGLoR/KSr/
	xaDWJDrdvOsZxAQPnfxJOsH6bzoKNpvIRFDf/gTy4C3JMhSj1EKDnEDGV+2jOvDS
	s2moZqVXkPRroWF42OTK0RTB82EKAbFz1DQCgQWAWcjHyw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1ysth1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:50:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8422382178bso3025213b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781628623; x=1782233423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOml+89Fh4slDZjDTDeUJgvRUxvqEHajVZitLYJCVjk=;
        b=Tbzczjufot8QWUAQlWXp+NMwdsaCPfdHhQsRGRxL5bbNT30W4kZxUaIBbTwm1vDSdF
         kVyEwjvNH9WxsovhrjkJ6HpNbar8+DzoTEzwgxImjDDxr9LX71CadNZJWUHY2Hyl+yay
         rqYwHujowg1r1z059funcDpCME0DnONW0ZGK9w31U8sGvqHsxbK744lhMwA9bkcxl+Os
         vH/xNklUKAHfGQItZLN4NeqTTbuVZpqASQzh994EC3JIDHCROpSCRJv18baf+GZJyR4Y
         dzXPVQt5++uo7qg2W03fAZycf/p1vxqk2Lkkh7auCwRcYRakNKs1E39G5qCppqNnKKb8
         VkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628623; x=1782233423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOml+89Fh4slDZjDTDeUJgvRUxvqEHajVZitLYJCVjk=;
        b=piWiuSiZMepY1kz38yL+Cjv2tkRDrlcSNnOBCi/YQ4dcCh4z7Dg5cnlLaddvznT2Un
         9Dt/rv2LceqAeDZwDKKbnWA9Os1atjW/3IA97Z2iXA8XKFvEyBzRjJM33qODm99gHC7C
         fIrobxGEtSUe94erIA/5WIXf4c9ejbt8jZ/G3QcdVsb9wffnIbQHowd/+nlHbOYuuYUS
         wxnw2q0lh4AhEga4rZ1mPAz8V7UhWkb/hk9gbgauuBjF6mi9Amo4yoOOoR2zKHp33t2j
         lbN23PIgs58Qqhp1FSzqhS9nTuVA2Cds9PardPrl5X+9QbOF8fstG6C1G3eng2HcTTKl
         xDIA==
X-Forwarded-Encrypted: i=1; AFNElJ9/gj0Z7EoxuSHL9f6cO7SdlpWCloVNCZOyt7CyF2Wcny0FiwRiwAseu+Bp7oNr8GYZYO238pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU70hHc4Oex90KJJX7aDfxDwGSIEbwyTYGa0yT/l2c0wtpNM8T
	2TkvfliTMh2NL7YG898JAgM35emo07IYeJ7qUTSMkDTXrzXrmcHlLHrnL2nTclFCrb+pv42+0Ze
	kGn4H0X9qimekQJRgoCMNVsstF5oZcv17dfELRgieNEgTrf1LKwIjTGuKANw=
X-Gm-Gg: Acq92OGRRSDGP+9fV77JCdz5z8IwTZiOaS5XoJeeozuOXwL6Re7EMFFHSawguX8hliq
	jPUxJBDHhX/8bOYEwc+2kQGgvaSziJpe+RO3in7uDPFA69Cg97dDMuKoRFX4Z2A3lZdiXAZHPnp
	vPmclxnYCekcsigDjwvv4Ta06iWJ2nfV7D2PD5HiyuF++FglMWdKiGQmyySH3WmllY/yEWu4mHo
	tyVQPvq6pH8nfRfyXlewNVu8XI8Q+PwxI0JrNBZBX1PVTJiC79k3tGPpeversEz319Gd1YQ1TVW
	KXD8GRB0gW7nW/GwmjqsRdH5NMjd5t4d+bnJAMxjZH2PVe441B1+qmVq6R+sG4kRsSHvsRM1MJd
	J22DZ71uX89sA/A+d2jQjGPRLfK/omgDSy04=
X-Received: by 2002:a05:6a00:94cf:b0:842:5da3:9b83 with SMTP id d2e1a72fcca58-8451561d685mr4168477b3a.33.1781628623509;
        Tue, 16 Jun 2026 09:50:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:94cf:b0:842:5da3:9b83 with SMTP id d2e1a72fcca58-8451561d685mr4168450b3a.33.1781628623026;
        Tue, 16 Jun 2026 09:50:23 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b040718sm14167850b3a.51.2026.06.16.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:50:22 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:20:14 +0530
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
Subject: Re: [PATCH RFC 8/9] arm64: dts: qcom: shikra-cqs-evk: Enable
 ethernet0
Message-ID: <ajF+xlipLuZtf4HL@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-8-f0f4a1d19929@oss.qualcomm.com>
 <2cb658f3-f564-4396-884d-d025eaa674a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb658f3-f564-4396-884d-d025eaa674a1@oss.qualcomm.com>
X-Proofpoint-GUID: tqW3HORNJE-BeZleB5BaiL37Gq0g_B0p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX5sgA5e5L1uQ7
 JLiKvbCGn8b+myHRx5e60baVuN8m8S5YuJIkIvltm19iCD45AduX1HYTLtkSL5BIH5J8a7e+OEC
 +BEJkIYRLuEz6ktUAIGqTPJqcTuJo+I=
X-Proofpoint-ORIG-GUID: tqW3HORNJE-BeZleB5BaiL37Gq0g_B0p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE3MyBTYWx0ZWRfX2AlIpgL0lOIQ
 klIjm04SHXkWWUsQ3niF3J3UITPFKQCkTzPTDJiCaGYKE1Ixelj/YIFsSlKWzjGsJ/EAx4OsNfz
 pGUzwCzUqD7ipnuR9jBCCbx20v1yN5dBR6gcVzRjFUyxRPz4y7/+NWvs6xaaUZKFU5PMjGG5t0o
 2Mg25bzwmJME865EVxbtsmIX80AKL+LnouFGbanJZfUEt+JU8Xa3JOEtGgubfsAh4AAH4vXZdx7
 YTh1qW5hr3Ew4ZVB3fUMRqTS4ktYmtakENMxwq0S0bPqBsqBozVs6/ME/UCQdB1+9Oc5l5Ka88v
 JNggix4SXWEcvZPvxQiduOodeVY1obw81GK3cZlk8ovECDhLAn5bR4AKcKMl4pyERH2CKKOL5wW
 Q6Xt3Ac7cGkj5SzH2iMk7+BZTDg19O3Jq0DKdumKq/+qMPZhkueLwh5vhP05Fj1AHubWhoftBe+
 ejGlfeNTPpAaEmjQ6qg==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a317ed0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=u2jKJf8zFqWonMdemzYA:9 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160173
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299922-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2C6E692B0F

On Tue, Jun 16, 2026 at 11:50:26AM +0200, Konrad Dybcio wrote:
> On 6/11/26 8:37 PM, Mohd Ayaan Anwar wrote:
> 
> > +&tlmm {
> > +	ethernet0_defaults: ethernet0-defaults-state {
> 
> s/defaults/default
> 
> Please move this definition to shikra.dtsi
> 

The CQM and CQS variants have identical GPIO mapping but the IQS is
different. So should I keep this in shikra.dtsi and overwrite for IQS in
shikra-iqs-evk.dts?


> > +
> > +	emac0_phy_en_hog: emac0-phy-en-hog {
> > +		gpio-hog;
> > +		gpios = <149 GPIO_ACTIVE_HIGH>;
> > +		output-high;
> > +		line-name = "emac0-phy-en";
> > +	};
> 
> This looks like a hack - what does this pin actually do?
> 

The power supply to both PHYs on Shikra is gated by a GPIO pin. I am
unsure whether they should be modelled as a fixed, enable-on-boot
regulator or just like this. They need to be powered on early so that
MDIO can detect them.

Thank you for the review. I will fix the stylistic issues in v2.

	Ayaan

