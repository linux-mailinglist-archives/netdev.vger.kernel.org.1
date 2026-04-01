Return-Path: <netdev+bounces-274069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKRdBdsEzWnhZQYAu9opvQ
	(envelope-from <netdev+bounces-274069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:43:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F05379A8E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D34A13080D61
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437353F87E9;
	Wed,  1 Apr 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+2YfixB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A71A74ug"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D713E8C5B
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043390; cv=none; b=V6oIPZ52CqWu+s/ngrqUl8B59EH2VxsQoEPVJ2192E8ke/oL8Dlh1OiALTaeAJ2+lLCNyunA+IelI+81sQhlC9NLUUpo33wnXW1atAX3Enp4m4smyFU9cvjhIJQRuQ2t9QquY/xYztMlOPnxvKTtQ4VZV2Fcb088vqjqay8J9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043390; c=relaxed/simple;
	bh=2qyilwUvmoPpBOyPOp3LPtXbOnhxrUvDkemZNQx/Tvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVWzIlqb1FJGY1em+81UTgN9XN9h2Hi2CBtuHn0xXWX7EYe67xfRXNKvGYpGPJFxGLWBVkPfrdRfJi8/w/DwP2LHVsiXqW2/EJfi1Z40pPoqmMUkO2Utg9QkSznG69SRIX2/YAY8K9wJ2aB6amj3OfFNh7j6boK7KUs3Mudvmv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y+2YfixB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A71A74ug; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63171duk1285928
	for <netdev@vger.kernel.org>; Wed, 1 Apr 2026 11:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HCYO1QFh3Q+hgTi19uYl6mUr
	jFcin1yJshF944ZFjqY=; b=Y+2YfixBtoVWKwgqzHIw2AYatOsMBnJx2PuXnPrC
	bUvM5bTwpnlRKJCPC4Us/jUQp+M22RR6g+K/iGX5gqAYV7lIxexN5AYtHwyCUep4
	oLrfi4AlJyY7W7kg6oXozvqHi3vTdVsiXaiObgfGpkZ3T20/nCVd0VwPT0bvLRUW
	tJcu1FBTWg1yk/5wNcxw0uUghjCLtS+40gBXzHcITFPhECkpcWlDyv8YsJ3z+3Ud
	bje8Sflm1ll01i/qS6pZkcY+lPpLyg76654zAVk+Boz0s2MGuR9iTwGhaF8kRdWY
	LX7cLs7awyEraj/rUk0ztYlvxFWYwBN8x8iQsln6cDwr6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3s0n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 11:36:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4ca7e7c2so172880341cf.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775043387; x=1775648187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCYO1QFh3Q+hgTi19uYl6mUrjFcin1yJshF944ZFjqY=;
        b=A71A74uglhtB6nxpWikP+/fdAN5p72t2mWxh9S8BkO5DAz/z5NPked3gS4XiwAB8Bq
         WnzbUIZ8Jv2urdNa6as+DkyTAaGzrXzKtk2jcfZQsoQw2Xf4S1kkiSfJfwHaaB/ZoUkn
         DFYGu8KtqAzpwsWqq35vKxN2olzQXmbxSA811UhQBeVOejnG/1BIGJnoTLaAq0bdKeYa
         N7Pzi3LUg7RCilfkVF9Z4x1vV7cgLnjqvxnDwavv6H/gJBRh1Z6Jvii5QPgHd4YrAn/T
         zVOnT/GeYxeUZwHr18Dzza7zoTXkvOoqvA136LTBFRcMRB8Rs/xKzO2eneJJJMACDLxJ
         SQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775043387; x=1775648187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCYO1QFh3Q+hgTi19uYl6mUrjFcin1yJshF944ZFjqY=;
        b=Wxoyjeed8RIVWfTDG0MXg4V/j0M1DtFw2x7xKY63jcuNzYyMUaLSsWAtZLyV/JM+6Q
         4mUwdt+kb2oDMp3YmUPFq5lE5m7Yi9SazZrtQixvpaEfniN0vERDdfgRFKyONoeszErK
         j8W6MwMJHq65wqWGJO97O7jntrM3kSMQY7z7KOYCZMTZz90I+CIvBuRefG3C5kOAKq9c
         WaJ7tIqsxbnkzqKqU9WApAmJcuVS04no3CPE7ZUuwEKew2+ploqqO+JyFZBKXPO0Me6i
         77qPfTlJdeuZTADyKfY+uKw7PNBmuKJNvwBQY5GXEaM5pa2EJrd2NwjoifXeAxVipU2C
         FS+w==
X-Forwarded-Encrypted: i=1; AJvYcCXUyyrs33QHj/FJpML6NQtX7mN/imx+G17a6fGCQNKd8ujUuuh0BwMF34kDJAaff0X8rqeqDog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZCtIfFRjNU13lHBKZXAWDkwonn22EUE274uQCf6RNAMLA2wW
	uKw1crMSxUrMcqAv73k5tz/CnF3Hp/XJRbL9bF/T6HLbCz0KZqlrMKdO549u1sU3sO/5FVKwabQ
	TIHi2E5+12WGWF0WWXV6HLCnbMEQcVLsaDLo0pEDI5EDNRmsJBYN9E7r9uQw=
X-Gm-Gg: ATEYQzwESnhbvv9dc7WLkyslkI2n4U2D9DHr06r1t/VSYCXh6I7QUKcUQZ9J5wedf91
	bgbV17wXLFg5g5tmrzrSMUx830MA6EyXyxi/hJATHFzoP6pmbPiO9ajRXraY+bKkK2GFrRIh5qY
	HomHlPjcjp+b97Ol0UNuMX5JHwW0UqhrYvppBgdAtCXwcIpqVUncoKAD7BxpJhJVKTHNnGVbo4J
	wzqaS46uRzybXHqojJ/zCo/zxB6vm5KvWgcjuHCllTcr6BWSNLDK2+WqxzMGilzdKoa0AFQ4vER
	i2Ty3+/bRttfe3qHFt11C7yzXPXlZUVPBfCpNRD8iUxfkyiYvI4/Ipcnu6Lh6x5PNncrARF8PMo
	q44CoH4f9D/wNMjA8ug8M1raRpHkRkgkDNtzzbxzcXT0IrKKfc61VknJYD2dN6mjF5RVHK3OR4T
	FEEhwpwrFhS+8YVsWMEXX/8z+wiYuaXwtBbB4=
X-Received: by 2002:a05:622a:1648:b0:50b:2d05:368 with SMTP id d75a77b69052e-50d3bd09620mr42887741cf.42.1775043387295;
        Wed, 01 Apr 2026 04:36:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1648:b0:50b:2d05:368 with SMTP id d75a77b69052e-50d3bd09620mr42887211cf.42.1775043386739;
        Wed, 01 Apr 2026 04:36:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c419b631sm416944e87.52.2026.04.01.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:36:25 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:36:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Add monaco-evk-ac support
Message-ID: <7baeajhlqv6ujiqzmknjw3h6qr4mdw6qdywhaczm3c42pzjiue@nsgcbd4jsba5>
References: <20260401-monaco-evk-ac-sku-v2-0-27b5f702cfba@oss.qualcomm.com>
 <20260401-monaco-evk-ac-sku-v2-1-27b5f702cfba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-monaco-evk-ac-sku-v2-1-27b5f702cfba@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd033b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=BfzaMqt4ej4OykdqmcMA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 8DA3K9GC_Cr1DJdTMjmiP3nXUxFsMIMG
X-Proofpoint-GUID: 8DA3K9GC_Cr1DJdTMjmiP3nXUxFsMIMG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwNiBTYWx0ZWRfX0lJsBv2sMHRx
 raO8rtCaIGU3pzVTuW0GT5AbzuuxNlxz3n8V1HOqeU4Et3UZ5ACASEilIle2WhODJi7cWwSeqdz
 xg6LHpvvLG97A73XbGKmwdJn9ZOWnQZfqjKBnotuOwFqmW8G3Nuky3FREZqYOZsotCSPPebvDrr
 lTG3krA4W2J148alhbLIjkS2M4Ju+pq32zbDo7FbbIqnP8HqZU+OMTVIeUm5spt9mO4hqL8kx6H
 2FdgcIbuWD5eW5QIqPjd9yQPt4kuaReIr/CurGMwXMr7+w3DNwGsZ9FhgUiMRmoN9KMWFtaO9uA
 LUNDAQVsdRp3qbFyk2f3RZ/RxckVzgC8Og3T6qwE5kw4PBN6LqdlK6orq5S3y1ubm4LbUUng+xX
 MNWFtgIXHE3d2JyY3sFoyJ37KhY2srBH+jqfXr1Re2QmeaOFQLtQIPkGOQOh5TBpVyhwAfCMclU
 wVGXR6SdB2pvgUfnVPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010106
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274069-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 64F05379A8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:14:42AM +0530, Umang Chheda wrote:
> Introduce bindings for the monaco-evk-ac IoT board, which is
> based on the monaco-ac (QCS8300-AC) SoC variant.

If it is a different SoC SKU, should it be reflected in the SoC compat
strings?

> 
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index ca880c105f3b..c76365a89687 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -918,6 +918,7 @@ properties:
>            - enum:
>                - arduino,monza
>                - qcom,monaco-evk
> +              - qcom,monaco-evk-ac
>                - qcom,qcs8300-ride
>            - const: qcom,qcs8300
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

