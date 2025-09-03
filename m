Return-Path: <netdev+bounces-219625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD6B42665
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94175188CE86
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A742BEC57;
	Wed,  3 Sep 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8G4ebPH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A22BEC30
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916088; cv=none; b=J1uvtbNbALBD77gRuHeimQcnlDBWEHsJBye57kPzDVXiWFbELOe+5axNRDdUYm8CN3l9uL0xmiTeDDlT2swFrR7+IFPPS21nrqvs1DCYIF60gO5qO8P8OgciehlRgRSAlLJrnVHHHQaYY+gQzDfJSU6nZ4faqkgdBpSiE7eX+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916088; c=relaxed/simple;
	bh=15e4KV2uKHJPOVsBfG9vaA4N6uUsqxcFksJxJYT4tQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlMeETCkGT8Nc1YL98XCFQaPmbrEsvg7Khb+1Dkm5IENDlHTTPsK9J2bFAtWlUIwQ56TGO3CxzKXvrIgnyTHgi8G4FQvJo1zZvsWICuzugtReUkLN3sgIKmz5Z2BUfEt72xTQM2pyT/7drrByfWGc7N/7g0zeA2BRDD7MLO1crU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8G4ebPH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwvoe007938
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 16:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p7A2A36WC5hNzLUFGe9+5GUr
	6YgZGXzB2kAzl3I+Zec=; b=m8G4ebPHfdBWbfEBqrnyIXVeXIkMcLttOwjhy+p9
	aESVUv+N3OBwniKB9YFGpLkV2PwYTywpf7MyIj71SeDf3kj8yNPBkT00pc41zXhU
	VCxJqpHjxIe/P3S2LmI+Xm1C6x7EZlQoftYl1Q2w1FFFdoW3u6q3B9kVBcvBjrS4
	mPTc7QQYjlIyTRZdDOa61TLUg8zSnmEQFHoBfrDMDT9NQZ4r+xxFwkIVZMKWuFT/
	gZeukkl6iEqfIKHBriMW4REe5Xn0OFVvAU9d3lXy8Dnb7VF1VbUY42CAUYWAoPHy
	QVbC8Idg5WMreuITfpxMbiLE/FldfFDY06dtJyktrAQrLQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy887m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 16:14:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77243618babso83733b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 09:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916085; x=1757520885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7A2A36WC5hNzLUFGe9+5GUr6YgZGXzB2kAzl3I+Zec=;
        b=W4sTAqTr8PGjmYnCZJCMd9xP5RWIUDCA2p+qpQRt8mgcHGqLZrFGGFzRvQU2dZlQDu
         nmUgr6GS5kCBE2m06ZGzPFM0GJWKyWm5odlZJvrZ9QFeJZibI8ERnQxjbdoWl3k9pwhe
         G7ltRZLZB2kZ1OqEWqJj03NJ2hp5nYokeYOsPvkOVw8nS3mx1ArWsXZTRNLKGiqahyAw
         KAqi2KQWkCbnJHAGO+KF2ErKuqHY6Nl0kiAAdXhbDw0n12bh7Bj4ckMQGrR7frdlbtJE
         eY37RUUO8monEQIGDLmL/tfxK+I+ndwY+6o/Ccnc0Uryp8CPH2GJVv4wvtNISYUVtTDp
         PNLg==
X-Forwarded-Encrypted: i=1; AJvYcCVIwHgoXN4eMw0q/+B+luNv5vbq1DjOSCB2nhVufFqfIs2jgKeeIjnNoWmnSqAQHxA+amwoCU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvM0pPPo+TpgUcAVLBZGFOmKdS+nwtKiiGW2sFi1OLnH2bdC8B
	VtDxloMprd+3VVC2RfhpEPX4UXZykHXl/BWV1xrAup5f+pBdNFrRUvIZGU5ORirIjsSGahn4Wrg
	+wv2iBhI0To6ordEBPt9akJXpl6ex1aSUH+Q7iFRIN16f/mNDZHZJrm+Enao=
X-Gm-Gg: ASbGncuhd6DwiWhpcRvuWJ7meQgVZqXJsn5EMRqodbxTsTiEaR/HLslIcMUsCf43Ku4
	pxaEbmYws8AXT6Ib/5iS1IdB+5cv4Bqf1/1J1PHz2P2wv1HUTJ6UDu2cfL+mp/JEXXcMaAKDybH
	h7drZx9XA1aQ2omaSRkF/5JSndriAnE8Ne5YCKGfVedScitMr0yRKRricwYTxZNdRSTAJkPxYc+
	Y7E22rRHZ2qbHLeSXSCQWvtqcLHt/O+8epf/s+eKvDsHaspH7KWCRNWpzhtBoljaVgzwBK9Dpqu
	c1U4k4+lkuzqhjQNQpceQ7+v2Gzj33uLBemeJsEqPNG4xr3zy8tbf2eAx+PSE4gHbh80
X-Received: by 2002:a05:6a00:80b:b0:772:50c6:47d6 with SMTP id d2e1a72fcca58-77250c660aamr16685505b3a.2.1756916084639;
        Wed, 03 Sep 2025 09:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFN8Fk9FYilCvfsVTUpXK3eaQZpWzMaZJtyrt/idToT1wN7680TzLMcXUUYYpYB/Pxpe/CGg==
X-Received: by 2002:a05:6a00:80b:b0:772:50c6:47d6 with SMTP id d2e1a72fcca58-77250c660aamr16685461b3a.2.1756916084165;
        Wed, 03 Sep 2025 09:14:44 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77285bb2614sm1757820b3a.58.2025.09.03.09.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:14:43 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:44:37 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Subject: Re: [PATCH v2 06/13] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
Message-ID: <aLhpbRL/mNfIMg/P@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-6-bfa381bf8ba2@oss.qualcomm.com>
 <facc2270-e700-49e4-a7ab-3b473e343ccb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facc2270-e700-49e4-a7ab-3b473e343ccb@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b86976 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5vNF0T9NdgVroHtUm1oA:9 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: htZo-3TtzZTlEmVM9g-M9VT3L2D80xdO
X-Proofpoint-ORIG-GUID: htZo-3TtzZTlEmVM9g-M9VT3L2D80xdO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXxqKt5cq4X/HJ
 H3MY6GHAuKJ62Sn92MB0KAdCJ8Y1bJTP5U4r9ZCZ3tPoUIERLJwHvZ33xa/n94dKwXDj9YHEMJH
 bH03/mAxauQnYFn//Ssw2aH2CX+3JhGuqJy+LB+SjjJzUPdw1pr0btEijNYcpP26ZUr1ZO0Akb9
 3PugBQ7ijZ+7KsyUnmmI3JxdqiloSB/IYRCOIMrmtuOKwpgHl9Zn51JwfwktQ5SEnDcMMqvneyb
 dNHA1B1CFaoO5rKdpR4LS7l0NWslwLwG7f1OvVoeEVi6KWEt8wpqgs8KJzaQk1TUI30SQyG7PcV
 rCtBQYrv1KAK8+brS7ix8uM9ERqPB4SUp5TVQk7nKSGioM8UkU3i1E5TsF1RQ6Y+SiQwVy3DX/y
 IbmJDkw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Wed, Sep 03, 2025 at 05:50:00PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > 
> > Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> > 
> > PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> > attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> > 
> > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 82 +++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > index 196c5ee0dd34..7528fa1c661a 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > @@ -379,6 +379,40 @@ &mdss0_dp1_phy {
> >  	status = "okay";
> >  };
> >  
> > +&pcie0 {
> > +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pcie0_default_state>;
> 
> property-n
> property-names
> 
> in this order, please

Ack.

> 
> Konrad

-- 
Regards,
Wasim

