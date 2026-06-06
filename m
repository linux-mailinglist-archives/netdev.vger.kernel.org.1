Return-Path: <netdev+bounces-296099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q2yTHgUGJGpq1wEAu9opvQ
	(envelope-from <netdev+bounces-296099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:35:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5464D3A1
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:35:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Dyh0Ncdx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TclADoLd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296099-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296099-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1378300EF55
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F7390CB0;
	Sat,  6 Jun 2026 11:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDCE3242B0
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 11:35:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745730; cv=none; b=MQ//u0oH57kLWAQ6POeqotz2DX2iVcQ8sXCS0TxNkJqRE66nJV6hUlc9erfv6/mx50DGtUucg1uQHz/PyeVfeGz6J5ymqZdlWHjLi8SW3FaJuofwzSjv0X32Q+3xaVA89susd7g65prDVwIwj80KX3JxUrK+GLoBMxlO+h8/kns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745730; c=relaxed/simple;
	bh=uNdueR1Nq2+/2mkXdFQFHylHgZEcgPJArgWDAINFx3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwTtgrmi1U6SZ2ptNplgN9og6vypiqbapKxFbWJnjY7Ttas1LRZ1YLxpbHKJljcL+AJPmeL6eeIbWvzMxxy/q4hb0lMVW9b52QJCPQZUlcMY5Yn/0aM61hI7i5RNRLymkT//1SJ6AZUt9MtodDJQItH/9Ea8Tl255Q7BOzTCVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dyh0Ncdx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TclADoLd; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BJ32I1300130
	for <netdev@vger.kernel.org>; Sat, 6 Jun 2026 11:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=K2eoP/NzpVpO34TdHsZFoeE3
	+eHyzR4upcTrGDql8jQ=; b=Dyh0Ncdx8mDba192J6czd57AGZXYl6/05bZhA5J/
	kG1oJPztyxlOm7cjC19NUZtWbcXAHTRyN/hx4fd/1dgAgp/wL31zO24Wu1uYoniG
	MQSXVDVjXHiLrvJfhNDlwJcXpt6lNPNGeIeJUC9kBkDo1772v1JhZEBppEXGrnbl
	3n50G7P0nuodR8ybmxU7rOVrPQfKdteDHNJ5+k/cOMLwWizOhh84LAYMME3lw68l
	ZW0i3Tpj0nMy+n8DHDUdSDxq4kN8LT/pEdbVDRmUAMa1DOMuxZFZk9+ED2d57/XB
	WVT42i1/HXyNTZm4NExqT8IHPoh6lZ6oZ44MlZFzTRKF9A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3hces-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 11:35:28 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6e907a982f5so5276683137.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 04:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780745727; x=1781350527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2eoP/NzpVpO34TdHsZFoeE3+eHyzR4upcTrGDql8jQ=;
        b=TclADoLdNZCCfvoywOkOCjhJETVYgbdZm/uyILYEi/fk3tNrU7wXviEDIhXc8ls4/8
         qyrDkGI9/fORGZsa2SfDh0p7mLToT2aAHh2zWkEAY2xn9qvD2INux6eKoJAgro/wumt9
         oLNnimH40h9gaCW/d5YrOLdsb0gSVaGT+FeoRof2Kvobwrh9MysknRjkMhTCRcPLTC+q
         tFS2dYFlwddBHY3VteYuDBvbCPILsU3d/a3hMAjShJtxWXo6Yz6ZBAsFiBAHNxIkn7HF
         P5SsZNEGXdr1cvdsfGugbpK6tvxvYtgp1ZpyLngLfMAvVu4YIQh9mZGYyg+AH/NB2S8F
         pkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745727; x=1781350527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2eoP/NzpVpO34TdHsZFoeE3+eHyzR4upcTrGDql8jQ=;
        b=DvB2m1ny3L6Oe7tVdsgGnabBWdq9XAsHm8vihnZ6mDsigQFV1Kl8FjTrBnrLzmjm9L
         M3wazqM0fot3tKDfEjH91Y5UO6qIube8k053wOOjY46HZiMpATNNH8c4IzDB2aHoJMMP
         IkRLQ2z69nTExVRAzLQ3f+IzrtExVUMG5FnYJyb8TclANTbDUNkWAPBBO3WVItGL9ESi
         8ev4HNP3wBxnVQbVjl7NZCV9ZHbaKYROF3d6DQKgjhn3Wzih4Xp0kFQHYDQB5nrHy54B
         eDPitghwsLmV79mKdctNfDNB9biEkYYAjOy6d/97d7Krgh8k4YpAdd/ZyZbFVcs4psBF
         fC4w==
X-Forwarded-Encrypted: i=1; AFNElJ+vBK2cMQMvKdabmRQX09O7McWK6babwTtZQmJaXsuD/4sUcwEx8iwIbUtVXf5HR6z1/CejoUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRXRS8YUo91k+hNb0gkV51EwXoIlNPgfg+mO1U/UQCCiUxw0x
	OMgizytayfafqHEGglQpT+vQhSVUz1w9j5HHtHYYjctRedCuKmvqq9BT/PB3Qo1+zOXn1YMsKZ5
	fbxF3eWUVySZHblYOgR0d+qKuAABqZ7T3Mw8eMBXXuxsLqcNeiVHBau2MJJg=
X-Gm-Gg: Acq92OFOyg2FzqzYndMp2vNRO1cyPTwy4npC1JzYiLNT2rMOZ70EjUOBx86eiz5fYbk
	q27XePFuykVpgsqQWEgLGdLZ/vQnMw/n15fNgWzYOjr35YwXSlnATxxHxVH93DJ2uFXFTGMcJ8N
	ZhzDocNNIRMH/ZcoIoaoP7ttI87zGstBbYwtIyWME6GwWFGoeO0vpnq56VHPh3RGJMPZ7x+xRAl
	LznfvZZ2JKsxYfzbcpoNgSDpLAU29JWisbCZlKnu8qZbLr55HpZAgbGokXNr4HFCYH13XeSVdBZ
	UL3unE8M2OlaMo3nERpTgVA+lsEWLvLJ5AzDT5QdO//cPXYzf1LmyA7n2PFFa8+iZ+W6CBskyda
	MF9FdtNrb0W8v8DMm1TbIYvYV0FSnIxa6UtaYNL5eO//Y5wr08oMWxeZpsOkOC+DRfN4ihzdVxT
	8jrF9sTEcpxW0fW4PbDw1hBy3uAmCqo7PB2WV6kdXq1meBmQ==
X-Received: by 2002:a05:6102:46e4:b0:6c5:b556:6d50 with SMTP id ada2fe7eead31-70035aed2b5mr1840511137.13.1780745727433;
        Sat, 06 Jun 2026 04:35:27 -0700 (PDT)
X-Received: by 2002:a05:6102:46e4:b0:6c5:b556:6d50 with SMTP id ada2fe7eead31-70035aed2b5mr1840504137.13.1780745727070;
        Sat, 06 Jun 2026 04:35:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b90421dsm2376921e87.30.2026.06.06.04.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:35:24 -0700 (PDT)
Date: Sat, 6 Jun 2026 14:35:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/4] clk: qcom: smd-rpm: Add support for RPM clocks on
 Qualcomm Shikra SoC
Message-ID: <2c4insgmqmpk6zothe54ktcdrzkjbbaiql5m3csagq74znnprj@4p4liju4xcii>
References: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
 <20260605-shikra-gcc-rpmcc-clks-v4-3-a0a7bfb44455@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-shikra-gcc-rpmcc-clks-v4-3-a0a7bfb44455@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDExNSBTYWx0ZWRfX7PFwgggTMKJQ
 z0/h4rEsRTzZitCCfORTvdEZksceu1f4mVixZviYPlOOe3dm8y4ME5kj5CLfuad5XFjkUs9J4vy
 geHnITdcPxh4SpLCtdfxvtLvVV22kTKu4F5WU5O7i/g62UNz6wQtPdja5PlNpWkCOPBJNbBrdWW
 jtdBwHRW8+jq3FvFMeX6jYV7cn0y0Bz7UOc7hj8Ddch6Mz1ztebfNrbPNLYokkWlJIeAYmTbBbH
 Yzuhq+EIoUbOBGYNyn34nXDjtDRagabVrj/pIK9lauIVJjeysyohc2Dt/CeuC6jKCiYD+E0t/lL
 PUIeNJvwSNt/t3h75mur5o59XTbTc3Qs1H4J8Wn+jiPFr6TrsTRkF49sgtf3Mq6kLdh9lAsmVsP
 6Q/Rvb9b04LTjRcFP0k4QQoGHJbstLAxJWuisfHEL5NBHEHSSlALjLoxDfTzajp3jTCDQXfS8uz
 yaMZvalS+xVWgXAMNVA==
X-Proofpoint-ORIG-GUID: nSIba2H2RHV-KS9lVRfTrRmmrRhUIQMw
X-Proofpoint-GUID: nSIba2H2RHV-KS9lVRfTrRmmrRhUIQMw
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a240600 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=NxhCX_73iKeGXg_BdwEA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060115
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8A5464D3A1

On Fri, Jun 05, 2026 at 04:49:13PM +0530, Imran Shaik wrote:
> Add support for RPM-managed clocks on Qualcomm Shikra SoC. The icc_clks
> list is same as QCM2290, hence reuse the same for Shikra.
> 
> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 103db984a40b950bd33fba668a292be46af6326e..d0d19bf0616efd5f1bc2caa037ff36d830a3495c 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -1289,6 +1289,44 @@ static const struct rpm_smd_clk_desc rpm_clk_qcm2290 = {
>  	.num_icc_clks = ARRAY_SIZE(qcm2290_icc_clks)
>  };
>  
> +static struct clk_smd_rpm *shikra_clks[] = {
> +	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
> +	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
> +	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_branch_qdss_clk,
> +	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_branch_qdss_a_clk,
> +	[RPM_SMD_LN_BB_CLK2] = &clk_smd_rpm_ln_bb_clk2,
> +	[RPM_SMD_LN_BB_CLK2_A] = &clk_smd_rpm_ln_bb_clk2_a,
> +	[RPM_SMD_RF_CLK1] = &clk_smd_rpm_rf_clk1,
> +	[RPM_SMD_RF_CLK1_A] = &clk_smd_rpm_rf_clk1_a,
> +	[RPM_SMD_RF_CLK2] = &clk_smd_rpm_rf_clk2,
> +	[RPM_SMD_RF_CLK2_A] = &clk_smd_rpm_rf_clk2_a,

Are there no RF_CLK1 / RF_CLK2 on Agatti? Or is that another omission
during porting?

> +	[RPM_SMD_RF_CLK3] = &clk_smd_rpm_38m4_rf_clk3,
> +	[RPM_SMD_RF_CLK3_A] = &clk_smd_rpm_38m4_rf_clk3_a,

-- 
With best wishes
Dmitry

