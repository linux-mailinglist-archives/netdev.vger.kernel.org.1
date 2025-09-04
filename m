Return-Path: <netdev+bounces-219838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDEB4361C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F99B1C2497A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473FF2C3768;
	Thu,  4 Sep 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzWBWKeA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C22C21CA
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975255; cv=none; b=ue1Haz7j6iLE+o9U0SCDAJly4ga5T04UtrZkJk2ct9eZXospEypyoDVIEevcjlkdtM6l27wfabMxDnebfVUJZOx24qP3aqbWGWLHUrLDW/3MuyI+/tJOiixGlD8Y/t7zVZqt6r6TwrKBmfaDs4+zHk4mlu3In/s/kxxlc1uMM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975255; c=relaxed/simple;
	bh=NeuaUx7smKmYtWJXPRDCSomZ5mneveiatz9Nf9EB2u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhqqrgQyFGxAuSjH60Qsw2p4SRf5Uh+mUODuGf+ZqxrXvTmmGoKak++VBA6BnpdwTYc5Cs5t4iGpKLta5MCrBfpHuWMSJfvqW4NV7Gq1sDajUCwUUDFPTuzGu8L0J2KaNCq1+7m/OZxN4r+vyslHn8N9ds0gxnlgPWw7QQh8uc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzWBWKeA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840NhvB016989
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 08:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LVRFBw8y4TYM0aV+IQrAzF1l
	KHpBMR6sAe/MnFd5W2o=; b=jzWBWKeAKpndbqbxCUK94/bpit/U2ASgLoaqpyKR
	iq6f2IvpOPsjCXSb4dOlBcfj0HZwmrKEwdm0pAmYAcMZ27rCGVNbaiuxqaeQmaRL
	ww8ynHlEYTgXkARIEA4SrublB4toxeQprTmMKC7HMajpw/Yb0zKDZUhn9nABOgO6
	mLcua/gsdL4g6Cmec5xbPZ3zW8xxv6jaHsCh+D9uGQ1PTM2onq/Yio7RC8T2RWoE
	9+Em7kGE84DrwvV2SQrW1LRy3acqFAgSRj5jl71LdKAJB5XA8HZZTapllwclTDVN
	063Vww36bMc/WHYy8tnHeg25lGfq66TuHLNqtx++ScIflw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj3by1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 08:40:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7723d779674so768062b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 01:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975252; x=1757580052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVRFBw8y4TYM0aV+IQrAzF1lKHpBMR6sAe/MnFd5W2o=;
        b=oJhtpNG2sI32b2QKkg1/FHp/Q8TXHETJUaTJpcZvriRnOeUgTuQiB3ovObVNRRt0gV
         VEUb/RZcGUzC/AZvUf1cxNP5YC2aLpgv8hDp5DZdagRXFohYfQjgukscAMU2UO8iZYf8
         NlMbn1aYtndZz7J3H8px/k2G8R/rt/aamQpKPAxaKwFifDi1gHpSehLEUKpgrScXNUPh
         XXsVpRc3T64VisAYlnY13Ml38drvbLE5DJgGazm9rxOEqYTBl71PYsy28F0UkAjtwf++
         Um1SauFLwv9KGeg+M9Q4oQ2GtfBm9JdpE7t0oBsaSQbGUqm5r5LNS5U4CC9bFJJIG/yf
         6FPw==
X-Forwarded-Encrypted: i=1; AJvYcCWfwhT/4W6agQUvW2Zj2duIftwEdf8Qs39KQivFi1O0hCJotRFCSlNvH9kCI9ciLhur9IPeB6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwakRYBV70MBApU3amdlQE/bq+GozfDZWRwDwq0v3ozLMwEhXBL
	BkeUvmRqnxg+W9pPL3vouF4+LfO7b0hOk1FCgOnI1KlzuhSibaAWPLR6T6IwRDFqhqBAtizwEPp
	ZZoL95dfMUfxptBXa7YlaNEXKG+j1Y5/MRJvKHnFaeKyMZoGbVKAPKwbanX8=
X-Gm-Gg: ASbGncuEroLMg7jro9VBw+ES4cNscFP7/3KlVgBMvkiAwjZcriQzkpZCAHCTp/vdT//
	CkUcHF3hQPPQF0GVAVkUjymJ0QNDaJCdpQmj+hRtsX/mgosAwfTTN6WsUI/b75v5+Sl+rSP1MHa
	ojZff5lpoqoU4bp8N1BhduVijl+TMMxdTb7PxgSVcMpPJlbXrWCoGMnl4T1UJI/F3C45DFkQ9zy
	bxZXNqRhvkxP2nc1Gm3gs1CqpDg0aiU88CJAv1VOXhke4aamQXh4whzBzebkQaqXIiWRIb2CGSU
	wUlcJ65xbBGzulSDkR61maKZWYCwJ2PNWNBSWWkY/EhmZlFU8WRRrxd7txX/7qh+BbB+
X-Received: by 2002:a05:6a21:8311:b0:245:fe25:7024 with SMTP id adf61e73a8af0-245fe257561mr7818352637.30.1756975251855;
        Thu, 04 Sep 2025 01:40:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHShG+ywVPwMMnN5ITlEBaV4t7zgpBVXXayaVZuxH1iz3KDcZhyTFEKIB2j/DH6XqeArvxfnw==
X-Received: by 2002:a05:6a21:8311:b0:245:fe25:7024 with SMTP id adf61e73a8af0-245fe257561mr7818320637.30.1756975251313;
        Thu, 04 Sep 2025 01:40:51 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f317ee7cfsm11700910a12.3.2025.09.04.01.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:40:50 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:10:44 +0530
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
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 02/13] arm64: dts: qcom: lemans: Add SDHC controller
 and SDC pin configuration
Message-ID: <aLlQjAmEe795u+nF@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
 <8a963e12-1113-4604-b15f-a5867c4b5bbf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a963e12-1113-4604-b15f-a5867c4b5bbf@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX3avxVeoqcFbB
 mZ6XoOtYHcoPOyEbju2J4Amr+YFUXG2h5Qt2LQ68qHhnVMe0srALfJ2I5E9JJyGresEMnZHB5PL
 YEO9/2dxh0ZszvVI39RA3WahSBIrVBGey6WjOS9hhKPbDHDONv3Uut2iyYJZJegyyRUyQJMx1sV
 L+HBlqt9QrIyi80W7hRXaG3SF18g0Ue/Fv1wIsabw0xTNnR5Z+N++LDDJKDlEMKxWM6Os2iNRNw
 MonG8GgUDf48ctDMZXR9QiuEappnybDGKMrrsAOSGPwg3x5DcqLInNLsVaiC4O5Hh/t6quer84O
 zOaqhDk4v3BQffGgblqzdn9KKZLiDGC38sYjpcZsGeIFAa1IGeZYLatoJJwN2wLa3ShxD6DMxBS
 IzOgOWR2
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b95094 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=k3xEAXBReI645-sCZUAA:9 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OKwESo48LkP8xDteX4OsFI6sXa7-QV9W
X-Proofpoint-ORIG-GUID: OKwESo48LkP8xDteX4OsFI6sXa7-QV9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On Wed, Sep 03, 2025 at 05:48:40PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Monish Chunara <quic_mchunara@quicinc.com>
> > 
> > Introduce the SDHC v5 controller node for the Lemans platform.
> > This controller supports either eMMC or SD-card, but only one
> > can be active at a time. SD-card is the preferred configuration
> > on Lemans targets, so describe this controller.
> > 
> > Define the SDC interface pins including clk, cmd, and data lines
> > to enable proper communication with the SDHC controller.
> > 
> > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans.dtsi | 91 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > index 99a566b42ef2..9e4709dce32b 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> > @@ -3834,6 +3834,57 @@ apss_tpdm2_out: endpoint {
> >  			};
> >  		};
> >  
> > +		sdhc: mmc@87c4000 {
> > +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> > +			reg = <0x0 0x087c4000 0x0 0x1000>;
> > +
> > +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "hc_irq", "pwr_irq";
> 
> 1 entry per line in xx-names too, please> +

Ack.

> > +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> > +				 <&gcc GCC_SDCC1_APPS_CLK>;
> > +			clock-names = "iface", "core";
> > +
> > +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> > +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> 
> QCOM_ICC_TAG_ALWAYS for the first path, both endpoints
> QCOM_ICC_TAG_ACTIVE_ONLY for the second one

Ack.

> 
> [...]
> 
> > +
> > +				data-pins {
> > +					pins = "sdc1_data";
> > +					bias-pull-up;
> 
> Please put bias properties below drive-strength for consistency
> 

Ack.

> Konrad

-- 
Regards,
Wasim

