Return-Path: <netdev+bounces-219626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72801B4266F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A637B61BF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA09A2C027C;
	Wed,  3 Sep 2025 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLUzOymx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403C2C029E
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916130; cv=none; b=Q3m9faeSAcHEqm209MLbvKPvL33dxdo/1k1dNdu1ynqcxwznqHnPbgl6Op0aBje0jpgDUTzwl2bn3ynpjmhWPTM4ljAzmP0seifwtfonB7N42zonAJxfCO99E3GexY1zP8ZMZ9+bnJi3xymC399pgAEcBpogZMjHzsqeEAgmgYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916130; c=relaxed/simple;
	bh=Aj/h6m6u4l7cbXvG79uFeWtqptowi2jhB/O/8KjO2kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+/IyzkDEoZ2SrLejXojwFKKsANsRKUQVdsADgr+pxvxuWdNFP4BwN7e6ta9FDjO/B5c1RC14mskfAHVXpMrUzyQj9XJc5b/SD8J2Jhh3d5wQNjp2o+XN6P4U5sL0gIeyz6BDWGBPU2LZJUVsNhDDdDJt077CabQOxR5KKGglVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fLUzOymx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxMCM030304
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 16:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PV8I53amMsdpCAWkiS8+8Gie
	vBsDJmqsY8SnpNsX1Sc=; b=fLUzOymxa1pTD013yhxViU4+oqpHhqhdhbTpnE0W
	BKNmHbmS1OA1gChpfxz9CF+iGkqu9lE4eutE1xt61E6DU2Lu1p4dDhnCCEATU8hh
	W+YX9RxUoiZnoK8LS7iz2o1RMXLTGDpHBXoOcu1qoB7wjUgEaCi+LhFe7Fr0Mw9C
	YcU+/wylo33nymbEfC3ddPxMaEbPWjoXa1Xoa1v4TX6i7a18kYO+NvOHDGqLpDgc
	ijtftlnvqdkIwwiWtjIBOVu7VkWU7whPUB6yEidUljnLgxbaCwLFXdEyXaS/Llix
	KzFrW1pBgV7p6hkhw/ofXL3GHi6P8kRD0T6W3edg4Ujb5Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpcgnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 16:15:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e60221fso120106b3a.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 09:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916126; x=1757520926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV8I53amMsdpCAWkiS8+8GievBsDJmqsY8SnpNsX1Sc=;
        b=XJKeBd7DYttHfQwPFJ6GPd0eQxzyC/EHEq4wIeQqk5iKWwMURgcfnW0gcgHul9bPvJ
         K2IRi7cpWZh+v4zIgjo5lYRhxEwfPJOpjajjuTdTNo53x9Wfauq8yZDEzWllhgKdK+MO
         zK0T8q0X/r4/1VGekWf7Uqbsr3weh5/+ZqO7CcR3e7ab7x0e0WEwwpFahQUoOeVTFyhz
         0gsIrEp0qLhGinRpC9Kq6Wj1R6YHqGT/COOjyOsG1ZQvSUWVojncmrNqSvgQwMVtSACq
         LoHJbwZ86A2llLVl3BIPHBa/TvYML0lhqqad7tJ8gdoJqC72szdd7zvoWibdy5bSzqtq
         FAJw==
X-Forwarded-Encrypted: i=1; AJvYcCWtwZS26VwsKYTt3QFwYjZxGhqOpyWeBBWZIk3kqjEM6tHD5qC06vyQ/tKA6NnGFVhA5vXdlXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVKhO/KcWZvzxeKu9W8DxJIg+hpDQbx80i0Gkyvt/txnrlyGNR
	F0tmYCsWWzeNYyw0b4jE2lD5XXnhH9sKc2AqzdAJoQWoggY/MIstT82U+9k8AjDJ+qYxPqV35gq
	bGG3e0ZrfdAtZitMeqHv+1IFI2NYanHcy4uP+7p4HWv8VkIBrwhO7xx2csCY=
X-Gm-Gg: ASbGncs5FFkrNczHxGCNdq7Mq9MCXiHowqZ/Idxhj4MIJb0sDzcMyMyYla2/UzJs+OM
	RCdloq2mRm+1u0G7bgqAPMdVhHkmNzXw1KPmz1fNQdiLttiMu2f4esEWR1VhGVn2H7rCHcif9MI
	g+QT3m/0vyPQNr5raCPJunXASq+vDFWYZd/UAID1OfwaGS94/lxoKeJtWp7ibPgPS0TTaoElRie
	LLYJlDSTfZncFD2DE8qMNaJHjx5aW28TXANnUE9PH7tq68GfBMzwCOByJyLqc4OOcKTdwmIMU7w
	XCLkEjjGNUgiKHtYPU6XHegK9cfv9vOf0kzFSkOqWCc1QQMD5BxQ2nEQkGsYQBIhdYum
X-Received: by 2002:a05:6a20:4f8a:b0:243:fedf:b41d with SMTP id adf61e73a8af0-243fedfd266mr9715501637.43.1756916124648;
        Wed, 03 Sep 2025 09:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM5j7/sKnV77ewl35fCQ4KXYL+IlgEgwziqd/xP7B3RE++ZVU3ZpeVSYzTkVju3Z9dvwZsug==
X-Received: by 2002:a05:6a20:4f8a:b0:243:fedf:b41d with SMTP id adf61e73a8af0-243fedfd266mr9715456637.43.1756916124211;
        Wed, 03 Sep 2025 09:15:24 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd073f476sm14803635a12.20.2025.09.03.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:15:23 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:45:17 +0530
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
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Subject: Re: [PATCH v2 03/13] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Message-ID: <aLhplc1XCWGNlnp4@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-3-bfa381bf8ba2@oss.qualcomm.com>
 <bbf6ffac-67ee-4f9d-8c59-3d9a4a85a7cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf6ffac-67ee-4f9d-8c59-3d9a4a85a7cc@oss.qualcomm.com>
X-Proofpoint-GUID: SUESLFMuhBKChEpEskr7ORrMN2vXQbK2
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b8699f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=mdWu549IrBN_hmWUEDoA:9 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SUESLFMuhBKChEpEskr7ORrMN2vXQbK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXw+w3NLkzoRXm
 ZjJ2NFAkvXQbwP3vlCZ78mAeVVEzL7klz+HgLmhlQEARCmbGYKdr2RCB5Evh8EaJk5uDSWIGMro
 4QL0f8uzoTyrl1D3aCU/5n4SWjewA8XPh24jIpw5eO8xKQ0kjnF+cC4C3SI2tJK3EEB2/ygoGJ2
 oPpt1etiG0rJffMF5ylKAVdomzoxcsJZicPHiR+5S4rbZNvGDbhctYPLya2plAf2cqkE+1e0VsE
 +YZb4UD2kQAiK8Ms3Q2GB+pZN+KnZjaiq4ptoYxbBGRnA5Fvaq/CXj9kAYO4wFV0DLHVTA558Gf
 ZTCGTln84kFvdvgl6kd46OS5Zv5ymB7udHy7BXjrk2cJ+Kp5sGZgQfq5+24WxuFnR4nll0ttsFC
 lxqkCPF/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Wed, Sep 03, 2025 at 05:48:56PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > 
> > Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > GPIO lines for extended I/O functionality.
> > 
> > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > index 9e415012140b..753c5afc3342 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > @@ -277,6 +277,38 @@ vreg_l8e: ldo8 {
> >  	};
> >  };
> >  
> > +&i2c18 {
> > +	status = "okay";
> > +
> > +	expander0: gpio@38 {
> > +		compatible = "ti,tca9538";
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		reg = <0x38>;
> 
> 'reg' usually comes right after compatible
> 

Ack.

> Konrad

-- 
Regards,
Wasim

