Return-Path: <netdev+bounces-275209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E2yEQcj0Gkp3wYAu9opvQ
	(envelope-from <netdev+bounces-275209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:28:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B294F3982A8
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2CC93034A08
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028573D810F;
	Fri,  3 Apr 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMeK7VGB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QF6Rmltl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0253D7D84
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248128; cv=none; b=bDQqT2Pk5zSfyh6HByl4nw2GUOcqXfnjRcV3MFAI/7SXjdtVveUF2vIqnTmcneNUHhtoX+gbzzMSyx2nv1T+xom1xGurTsPgtvjmihGsyDJkFogRvg4aVtOMfPmZG7oPELBx71TU97cxY7Eq0mzUVoQ2fK9UuAfg8QVDKazADeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248128; c=relaxed/simple;
	bh=qrrW5DHRneVpOdMcREizH80SwXXqXh1GoF8jzymiKFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc1Q3UF7/gfdIxF4vCxO0SNahX8frBKbvpPicgZ9cLXRKW3M7Is7zHEq0DVlKdlWuYA5nrSlgDTlVj/vVFOZ5HI43qP4/rxI0UiBj9GSmJz7ljQLD9fqngM9y8AY0Ddqsmvh73Js4kXLXprCcwvHcHlS4gkWVLSRTybTwW+wgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMeK7VGB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QF6Rmltl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633BgZx73780256
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 20:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J19NRcOFC4DO5B8IoTjtidQNHQSolsOYWwFm6ZIT5Nw=; b=BMeK7VGBwhdVTTv9
	FSdhQbn4wZOd8I+iaXF5f52I9aVDhFTFVgjqdj64Qb4JI/7noo/iIeOgvxS1FVQV
	2g1T1mfA771U1Iz9PeVtH4DYppnVFt7fVgDLqJ5dzz6MF09QLeD1SXj6dD0t7jyk
	LQEhMDjrf80Ltw9Zr7TNOgD0Fy4eaWnavEjvjnUk1fo7XXNuIYmUpxPnYTjdXbqE
	PAwKcjbLdLnRhE7t0zxikpK5weTkuo6TengkUs87xD4musE3BPW3GWhPrbIvGVCo
	bsFbAXr/D4RHvJcDdhcm+vyOCyTU+bqQko0+dmpbOEQQEf1ixNNd3VaVDpxeVLdF
	8Oz49Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da663jr6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 20:28:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5aa81907so45930561cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775248125; x=1775852925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J19NRcOFC4DO5B8IoTjtidQNHQSolsOYWwFm6ZIT5Nw=;
        b=QF6RmltlD6ibV/wmhyEbRILcpTPt3maO4FUf9MUGmLUxV8YWDxIL8sFClFRb/GFfJT
         g4J9mEPh7IJ1Le74GcWu+7qFAoWh6Ti0wCOewyLTKVg2kJoi8CUyFstja8n7NvxgHDxd
         BfJJWORUnI8DtjTpYUHd/o/c5Qz4/3nydFWKr9tjT1hbpQdv1Xuvzd/zRvELGScLwLlq
         wnE28rA9KzT6tal+ogRanEZM4dtOjVCRLu0JpjroMtB1dx3kZkFaWtZYpghf8Rzxr+Rc
         D5JaZS9v1cPt/mW+A0MKVf68SNG4oP1h43kMe/0SZLQ5kpDBT9z2iyZ4yBGrHAAXNDfG
         aRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248125; x=1775852925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J19NRcOFC4DO5B8IoTjtidQNHQSolsOYWwFm6ZIT5Nw=;
        b=TbVSqTlMEwd3tN+gkXe0AK7i3DqEO7FFWldQMGfs0lGmF0advv7NYWtzkf30/6OHHX
         9LE9E1ZEogiIx8xP8w1rMhEYRI+kZxK58uC8bAA8M4UTwsgqYeHhJwv170y7r03/uQYE
         9huYfXVbchZpgWRg0FU7E1kaqNvLSAweqAU80t0zJzQbmVVyBkTYrd/WkPHKv6VSSL68
         5RRBOo5w9lr8CYMpd1iZch18Tdfue37I2gRnoZOnWLe5RKvG0xtz/F/gyC2xmooD2E7/
         I5u0N189B3ywZLhnOJhMUB6g5GNARlnKQMa5Re+/wHEQr90GwebELAaXq67sM1cVsPAz
         G/vA==
X-Forwarded-Encrypted: i=1; AJvYcCWNMH5ge2N0SIrxpCssf2AlDdFtjBorND5FbKAF97prDk5Nje92QGJiCFcEm6y+RX8nZc8qQsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxSlwnNzSbnxl71ZpSx7Uh2tjtydN7ChUTgHtysKSYPLvnYHG
	onhEflxhlcpwbr+yZ9yThMaKPWb8FnAAJRLD7GnuuFLyFrgR9MfgM0vX3pfdGdoAO46VOgMWf63
	AGV0gW+1zcXCl6flbKGXrHil+BcgF7vlTN7oHSPykPFZiqHB+d32Sm2Y6cAk=
X-Gm-Gg: ATEYQzx+67v1o5ZkcbX3Nv2e+f8WlvdUV9kbjldTmCoAeaRTWQsXwBV7qS104EO1+7p
	VXwQP7O14VKsgK38DTo9NXRp2uqaU54yoKJmMeakeFTWffY16MBXYr6ap7REIkTROu7Ake6IbPz
	mTSE7s5G9fYjqBu+A+3OqYnK7d8YeZ5zGnKBu8lwCl6J886ZcCoHI7ATkZfUJCArQzK/eV/LdcW
	ZYBFZUBd/XowirpbP6X31jjb2vKVUCt+8/nFdY1XEP0diIMunxnnAfzj8NzlUnwdH4rK2mU7ApC
	+T/Jr4WkEV1jWzhmVde9wtdvUgvdlfOIKreLcVQYk/mDHdiLnltujfSE0vI/zpvx7Rn4XrRfpNR
	FEFD1cXuP69EXc1oZct63KDUF4OOaWqOD+DNt/Ry1TZMyQm47rkS1xgpCwyxCs4vKvqIRR981/g
	ZesMYLMijAlTQtWOPRQ90XtpkiUL1ZaJzctOw=
X-Received: by 2002:a05:622a:153:b0:509:1e54:a501 with SMTP id d75a77b69052e-50d62614df9mr67424881cf.9.1775248125282;
        Fri, 03 Apr 2026 13:28:45 -0700 (PDT)
X-Received: by 2002:a05:622a:153:b0:509:1e54:a501 with SMTP id d75a77b69052e-50d62614df9mr67424531cf.9.1775248124765;
        Fri, 03 Apr 2026 13:28:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd1fa84b0sm15396251fa.2.2026.04.03.13.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:28:43 -0700 (PDT)
Date: Fri, 3 Apr 2026 23:28:40 +0300
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
Message-ID: <zyarcaimg67uivssnm4uxqiwc2jadolf5kx6moycwlbzhg4gmv@xa75wcpotzpr>
References: <20260401-monaco-evk-ac-sku-v2-0-27b5f702cfba@oss.qualcomm.com>
 <20260401-monaco-evk-ac-sku-v2-1-27b5f702cfba@oss.qualcomm.com>
 <7baeajhlqv6ujiqzmknjw3h6qr4mdw6qdywhaczm3c42pzjiue@nsgcbd4jsba5>
 <0f2612b8-5c44-4934-a625-27a66eeb7bdd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f2612b8-5c44-4934-a625-27a66eeb7bdd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE4MyBTYWx0ZWRfX/VHcenAwCPY/
 yL+AM33q+ueBKwRa4cBBloAy7mR+y8KNp673sVeM6Rt86QwhDIB3dv5l8LdLZZR7PFw3ySZE0Xu
 WonhcH/0Sj7fcRfWWSVBxjk+n/m/FUCsZ01W8B+27+HncdBnMNlAndwu1aLskv7yHpj5LAxolaN
 9llzij+8DkKKx5F5k4PfrtA8MO6MPzH0z9G8yryHYJD7cf/l1aS/aZXjChWEj6poK+HkVh5tigZ
 /XeU4Ny5RdDpSQu29AShKjulAzMileUiH/1Eis6V3DiOR7m+lxWm3XPC0pGplqpaRP3HcL/HIkw
 EIwcEpfeYfe6vLzsKMERf0ode4cmuR9D6tPKNXl0KKahc9va/rZszGymqAuhRDoAq0Dc1WgAF10
 72pvj9y9HG4ymempMyeFAhWWAG4Ak7PYGvQ5vZHW+2bNhVRifUSxuzkI+fK+louQ41jxEB0h1Nd
 KOBeJdr6Sh5GASnKQNw==
X-Proofpoint-GUID: 0YCQcksE1mr6so_npovrvH46r7I3UeYD
X-Proofpoint-ORIG-GUID: 0YCQcksE1mr6so_npovrvH46r7I3UeYD
X-Authority-Analysis: v=2.4 cv=Acu83nXG c=1 sm=1 tr=0 ts=69d022fe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=bypAB7O1tipGkwTwlEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030183
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275209-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: B294F3982A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:14:28PM +0530, Umang Chheda wrote:
> Hello Dmitry,
> 
> On 4/1/2026 5:06 PM, Dmitry Baryshkov wrote:
> > On Wed, Apr 01, 2026 at 12:14:42AM +0530, Umang Chheda wrote:
> >> Introduce bindings for the monaco-evk-ac IoT board, which is
> >> based on the monaco-ac (QCS8300-AC) SoC variant.
> > 
> > If it is a different SoC SKU, should it be reflected in the SoC compat
> > strings?
> 
> Monaco‑AC does not introduce any S/W differences compared to Monaco SoC
> -- All IP blocks and bindings remain identical from S/W PoV, Hence
> haven't included the SoC SKU in the SoC compat strings.
> 
> Hope this is okay ? Your view on this ?

You are descibing -AC as the main difference between the kits, but then
you say that -AC doesn't bring new software interfaces. What is the
difference then between monako-evk and the -ac variant?

Also, from the naming point of view, it is monako-ac-evk, not the other
way.

> 
> > 
> >>
> >> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> >> ---
> >>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> index ca880c105f3b..c76365a89687 100644
> >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> @@ -918,6 +918,7 @@ properties:
> >>            - enum:
> >>                - arduino,monza
> >>                - qcom,monaco-evk
> >> +              - qcom,monaco-evk-ac
> >>                - qcom,qcs8300-ride
> >>            - const: qcom,qcs8300
> >>  
> >>
> >> -- 
> >> 2.34.1
> >>
> > 
> 
> Thanks,
> Umang

-- 
With best wishes
Dmitry

