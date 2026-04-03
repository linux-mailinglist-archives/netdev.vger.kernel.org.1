Return-Path: <netdev+bounces-275172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDBHHvsU0GmV3AYAu9opvQ
	(envelope-from <netdev+bounces-275172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:28:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8637397A47
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F33B3047AE8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0743D47C7;
	Fri,  3 Apr 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJWbNuXS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzBhphsN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8312F9985
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244480; cv=none; b=WFb0ZS7Tpc7B7e29eZpv9vho3G/ar1JJcixuyP7xBHGXvpFRAhi89S6r5N/IlORF7b/sVndv6YUnY/+kRJMZRl1M3ct3SByZz19lhpF/CqPI/F16EmGcoxxzCIXbAJz4xFOJD1NdCwLp6guD9vrQFAXhnhyVqQyf59OxfnD0zwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244480; c=relaxed/simple;
	bh=5q3xTAy3ceHEamuEbTFb4TuIH9r1qcuJh6uhVKuufQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu3r9Bs0v4En9zuwjxbsyjhSR3XRIJZK96cJaGH0t3jtlRnjtsDU2vyISb0yNztDKs8y3I/gkazI3w0Yo74a+fxxvWeueSGJ5iJExJYhb5Xr5ozcjuUtves7PMzNGEatKO0knDcegINxDf1eXVtbSTrRRXBxkUCa+obDLxBO8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJWbNuXS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzBhphsN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633B1fEM1453615
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 19:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/3sonBIdbluoUrAy71UfeN4h
	HhgvOxlNaGnfbCWEk9s=; b=nJWbNuXSuzNixGEpytL6xyKJyMgsDjnsUYKIy2f+
	1LiuE9rU9GXq7yfcWtsi+yBvoKvLPhm6RwabVBKTeIkib4b4KqM24Cuzl+N7sWTY
	bW4OGivTouXqQTRRPUcOSbqR6oCJZuXT2rPtk7rmo1wCJr691O88pqKmR+oJzDv8
	H4FwFLlkHKmVHu9qiI8vnDht8pbc4B26WbElO2hMQBDEZOsuKRrnuzPzdxyv2REs
	PvbBu0VyyCz5Vxpa8xpa3OJ+Z9M8Yt8q9rDnBceCqFi8zVH0oGO6OlpCuTlQsUl4
	Xqgrtfuci7BsROBaIXrAVK5HOksdsqQCWXQjZqI5cWAmrw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dacam9cfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 19:27:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4031b86dso73880491cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775244477; x=1775849277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3sonBIdbluoUrAy71UfeN4hHhgvOxlNaGnfbCWEk9s=;
        b=TzBhphsNtpy/A7sbPntxpp2hotWd2ORIgrFgpYMsePYSaowRLoRZOLXl73W0leQdRF
         yz6lbCnJrfwfuURokAwbSC2gzSRYuAWFMFXDfm/EyG6WKSEqCR97lVVFgninNE0eno3r
         c+E2U910bojy2Lg2Zfw8oipkDl9jw3kWR2WjLT1C5wHknSOMITf1BNSnQs94S5TXUjKp
         k0+LA1k3bwe7fjPuzCfKZu9omrtkuLdMoTPFAdq1+XkGR1JODvho7hMzeGs/V15X0SKo
         5Kq2SJmCNM654UYb+0WUQM232251rLyPlrmtIpezD5QGXw+sc5FnJF1s5NPF4Sq+qAG8
         esMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775244477; x=1775849277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3sonBIdbluoUrAy71UfeN4hHhgvOxlNaGnfbCWEk9s=;
        b=jkNaZ6ePV+dbULRNko4xsX6uUKCvbNtVMy9rakRrOwkieksoGOVjkPNa7d/peYcjPQ
         FWftzI5V7QyMMLX2F1dWFrwDFczeKDa60nM9ooPnA5jAOZijtBiC3TWI8HmZgX47ijac
         kpcPvIKrnLnGUK0r4Kz5DTmwgPQzJVAD67d4PhQ9Q0AMvWJdDA45ZmBMyMrkAPpEGrWt
         lshHuY/CQ5q2U3WHwqHajw98i1BxE9LO/fl+Mj5vwTLkSnUQOpd6X8oOzuOvqaAPiBZ1
         r4h9tpOfA25Tww3DpvfkMtcpGp/ydP3jWJ/B1JuJlC3V2TFwXS+YlcxNLGABc439OpMF
         5pcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpfVDzyjeSvImfmyzgqhQIf1N7BxSlG3BKttdb7RqA7q8RGfkeP2rmC4qNtKynw0IxwOFp1GM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf/Dh+w8Kmnktzmx6908REv6aBht6LQww37jauDTqAgXoeVu+L
	nRYOxqtNOx2yR5wk9/qSn1cHv+z//oMkRSSUh1e/p9fYyO0x3OXjEtUzRI9bxO7abh9GfvYYhZY
	f9I/za8RO2pQ79n1jBcpTax5hHsCdjccP+CjhK6BgIljLnkJRB9yNmPY1i1A=
X-Gm-Gg: ATEYQzx3X7OySBIuAe/sKi2dY49/J7t6LSwLXJdzkbbAgNrSaoDBA+ELAuE7St3+ATF
	7yQ+7vpcqarjts3n+LTPZH+95J5LTtMFgQtcAcd40J6EmxqkkoOWGTA/WYvsYOQTkUrppfBYWVL
	KUTK5L12oT6UUdORkFcIf1MLVpXOz3r90cfcuigk3QZ0b+kgfB/3LokxxgUcYANAQEeVqFO/55G
	fJUgP5fVuULgMWUc467x8S/3l/VhsD033+ZTLs+AAER4maGZDK0uaZzY4lTcfyb8Thl+Oahewtb
	NKztZ/F2QSYGmRAZoiGCqRzh9VT/rQQKV5xlVFlef1ulLasZJkbNl+xMkgeUnSYgq4D7dPpzczS
	hnxaYspBPOvadr3hcIJ50UHMuhovPitVbNxOkZYz3xc6lNOKTP5BKHadw6wGaua/1b6VVBqG/tA
	5y9Za21C72tMeAf4+18qem96Pi6S2MNGgEXd0=
X-Received: by 2002:a05:622a:40cc:b0:50b:40bb:277e with SMTP id d75a77b69052e-50d62afd8b3mr55933421cf.55.1775244476839;
        Fri, 03 Apr 2026 12:27:56 -0700 (PDT)
X-Received: by 2002:a05:622a:40cc:b0:50b:40bb:277e with SMTP id d75a77b69052e-50d62afd8b3mr55933081cf.55.1775244476399;
        Fri, 03 Apr 2026 12:27:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cccc83sm1618276e87.65.2026.04.03.12.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:27:55 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:27:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Koskovich <akoskovich@pm.me>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: milos-fairphone-fp6: Enable IPA
Message-ID: <ku4w5dbfk4ihxfslyf7lcxtxnbzabim5mmtm7xlhqbnmav36iv@zt3dky3vbfbo>
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
 <20260403-milos-ipa-v1-6-01e9e4e03d3e@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-milos-ipa-v1-6-01e9e4e03d3e@fairphone.com>
X-Proofpoint-GUID: eCT6WiYCmVcft5P9CGMVS7RlwXNtOvo2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3MyBTYWx0ZWRfX4bdQQWSiGMWM
 xdOEieSv8viV4zhCb9qz3oQVxvWjY4NdMt0zvlenjonBAkM8XQZQkWg3hPMMPPNQs1m2uA1by3g
 wKzPOT86i/ez0v+SrTIrC59cJhTffuCyIae57a5MbZNC6R7ZWRoepJ50htg4z7TiizucinMBj83
 1LDeODlPaVxmmCuqvxpAleYbQwParPeLFskkHlTFgSIvVCRCs2E5AlNFj6U4FYMLFRJKN2LupoT
 ypA6TDLRAynfmoNLfNBdyx04KweFcGfwhY/dxo6XZjQPvLvf6bwIkhFXtbyyGEdmXqp7XQ06Ez0
 vjCVbO5EpF7XcWKO6Cs7RwNGEtQQIO2a78hPilN/bFkoyymXNgGXCKiwLOJMhi7szi9k1BQLZ0q
 T39BEvHQG3TEY1UqaLWyVfAGwVZNRBbCtCeoR2czfJLSEUAMSWcZVgd214nOe58S6e4LsiE5d9C
 tUs8dc5H/MSfWJV3wCg==
X-Proofpoint-ORIG-GUID: eCT6WiYCmVcft5P9CGMVS7RlwXNtOvo2
X-Authority-Analysis: v=2.4 cv=ULXQ3Sfy c=1 sm=1 tr=0 ts=69d014bd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=6H0WHjuAAAAA:8
 a=EwYZka1PfJtyEMGjZCkA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030173
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,fairphone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8637397A47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 06:43:52PM +0200, Luca Weiss wrote:
> Configure and enable the node for IPA which enables mobile data on this
> device.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> index c1899db46e71..31c6d6627619 100644
> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> @@ -690,6 +690,15 @@ vreg_l7p: ldo7 {
>  	/* AW86938FCR vibrator @ 0x5a */
>  };
>  
> +&ipa {
> +	firmware-name = "qcom/milos/fairphone/fp6/ipa_fws.mbn";
> +	memory-region = <&ipa_fw_mem>;
> +
> +	qcom,gsi-loader = "self";

Are these two common to all Milos devices? Should they be a part of the
milos.dtsi?

> +
> +	status = "okay";
> +};
> +
>  &pm8550vs_c {
>  	status = "okay";
>  };
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry

