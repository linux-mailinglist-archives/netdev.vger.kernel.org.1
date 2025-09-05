Return-Path: <netdev+bounces-220351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A73B45870
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27565A83E8
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D81D7E42;
	Fri,  5 Sep 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGfTKInG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55941C75E2
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077641; cv=none; b=lPX2e+9L8hVB2j+Zoif+mITQPEPBelnF2RfejUCAXxxXIZqGq0pw6+5as3X2rE0+/4TlsQNZJPCw21j2aH9Z/hfnVAptG7xbSnCkw46+vw/kEnKthcjSup0iiMkPAwW/jywVYpCrAItcysyH7mfuy5QqDhqhojrIR2CRbSxgsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077641; c=relaxed/simple;
	bh=JsdLLPrUmGM8Tgv1FnyKp6BjjHIfVQSZbw506i21JtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AinDkTFE1vmKRi4nFn4H9OmXikyqqwq7ueKs33/Q2qhkMPIitpP6DW0uvuLoUx4B5vSVtD9yb/6y6YOjpJzeuThy1L2j215yeJmgqRfHNX6P9vYWMxfZPj7lccZI+TtZ4dkqTJOv1M8UNygRhURkU7jdOjhvz/+bGg0aw95cJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGfTKInG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58570Pvp032214
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 13:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KrQKZP3w0ewlZNuZWmqjmyoq
	dp+JRPUq5JvWfsJm8Eg=; b=KGfTKInGLH016v/bWWLBLY4d0AWU5cpjdf1TzVMT
	LlSQIhkrXp03YU/0z+2IQ+1BmyRxGELsUmBwhj9nwXtkIKjmGxJc7CWgFsDdusgx
	JX3DvgR/W0KhH9iwOqQLJ3UxkwEdMj1Tz6MBKVDTTBB1iTAQ97stY5Y/szaA8zI5
	kiaTdt5l9ITkt1eF5gTuiWSqEv2TOC3twYKNBQt2WJMqJZovXcXBKw++nNqA6qBS
	56AHOEsNm/PaEbjHIGMUCLaFovQJLwABBEmwpkIVMAi2Ba8E4uh7mQHVJBIpmQ01
	6KdhKYZUmoV1C90nxvpKB8BnjPxmYv5gpFq4YFdqS7SJkg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpkbce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 13:07:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-329d88c126cso1997620a91.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 06:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757077636; x=1757682436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrQKZP3w0ewlZNuZWmqjmyoqdp+JRPUq5JvWfsJm8Eg=;
        b=QUytjd9shO8npenE3ssFtjBPlZdsTfrN3S4WSy4xf/Nb8Ey5bSyM6lQwX9jHCNb8Ar
         v5TIEpbfRDMviPukHMuRkwppM24SHPyOqq2q0teeAep9Q09kFcfw1Jwig+iTnCdZ7q5A
         t4FAHh0Rat6Z+oq9CyAIfQzkInnhGPvo1ABWDvHJo0GIMZJgFXd/GLtuaVQdVZiuYVCi
         ImQj++6LlEk9VOcaARFCfCv9Q64rQeIbbICg7tDJaNaBlfHBKvrNtTYW/1Vc3gp++M9o
         PF/7wPdV+OizI+jJJ0mXtUgWGTKfXV28BpsAVwx9bveEGrF27AvLJ30ExUVqS9VwVMLm
         HtJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzJGRtwUmNhVSFTB5sllNu9pn/GmZwJzgQ0+9ViZYmSCOnF6g3ZPKlZz5+h39372BTJOg0v1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfK1bafz5cBUGy7Np6sSwZkQqPq5uaZr0c3QLOosdIDcei+yv
	oJ9VqNPxZUQanRgnH4kaJ1Sktf4P6+0Re0NYN1JDZz4RVO8QOCldcLU/Z7yD0MNRDV3cThKxLRZ
	SmkOk3bVuLLl3SAuqL3lcD5NqhpoTA5Qv35c3SkHbCqgQJo6G4hySUMo6F+Y=
X-Gm-Gg: ASbGncuTeqMAI88PNmTsP3vLe6a42wh8+zQzbVpEqx9tJXQEAMaFQmRrDIk4aYy+3ir
	+CuaZYpG3hZDFLLtWQpu6s6yYwJzBL+esJ3sIV5c0lsMrIIZLOSjiHJg7d/7GIZNT6ICXCQAdOr
	EBfnGTKXh0VjTMHQe6dMLGd84TeiyNXH2vOLzRMztu2wpOlxnVRbXRzZZTTOd77OpKF4/brDrrh
	o07blP6FNTf7iCkp1kc00t2g6wReehOm3dkcMsICkD2+T/n44TZDhAK5dFVFb63p6Y9CMqkf1AW
	Scyh4kvqPyS0oLKJKj3NV7yy1z17+m2Eoa57WBhFQctc/+mrmfmIYsxHCLOBmvrYzSbp
X-Received: by 2002:a17:90b:384c:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-329e708c9fdmr18453347a91.20.1757077636185;
        Fri, 05 Sep 2025 06:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOWdaNrn1TEaOULcrKSkZdESm8pCYoEw9CzGYfoVI1gFXNQjbHfv1K5YlHjOSkq90MCHN1Fg==
X-Received: by 2002:a17:90b:384c:b0:329:e708:c88e with SMTP id 98e67ed59e1d1-329e708c9fdmr18453243a91.20.1757077635494;
        Fri, 05 Sep 2025 06:07:15 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32bab2022afsm3689920a91.2.2025.09.05.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 06:07:14 -0700 (PDT)
Date: Fri, 5 Sep 2025 18:37:07 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Message-ID: <aLrge0QLmApr881B@hu-wasimn-hyd.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
 <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055bb10a-21a6-4486-ab0f-07be25712aa5@oss.qualcomm.com>
X-Proofpoint-GUID: o0yKNexVaU5j4N6QfV-XB9wbP4CZC28H
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68bae085 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CfLhDO45pqEqRx8ihX8A:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: o0yKNexVaU5j4N6QfV-XB9wbP4CZC28H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX/AeiSrMxYg+k
 6mDHwpBKRFaQ72ZPgxdJPFzb0n5EQHidbQlKieyA3TPVJoDM3bUSI7IJ5CZe29GpdP5VSNRNZu7
 G3u9rYquIuA47UPf6Pw7+uNsdAJ7r7DQ4zr+XaKbHmwzEI+tzBabQSCWNyhLEHakr8Ri1dg5vPK
 YluU6Uv61+7Plry80CpYOKuAyJlePhmMpWxaWYMnB5HBIEXtMgr9tygAQvwJhkCc9EyH3B1lJxa
 gG2LixJWB5vSH1xc9dk1XyWUWppf7FY9C+GgHGO3EQ6UncIl0KTzs1paoTLBbKW5RwliQ9bsHTZ
 D9hpp5bmuPn/L2vXBh2k6fyWPUHoohssExBwAGzawIXt5UuAoy7va5s4Gxci/cREY0NZ3hXBeHf
 2ig1Tkpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Fri, Sep 05, 2025 at 02:46:46PM +0200, Konrad Dybcio wrote:
> On 9/4/25 6:39 PM, Wasim Nazir wrote:
> > Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> > Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > firmware.
> > 
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > index 17ba3ee99494..1ae3a2a0f6d9 100644
> > --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> > @@ -425,6 +425,36 @@ &qupv3_id_2 {
> >  	status = "okay";
> >  };
> >  
> > +&remoteproc_adsp {
> > +	firmware-name = "qcom/sa8775p/adsp.mbn";
> 
> Are the firmwares compatible? The current upload seems to have
> been made with Ride boards in mind by +Dmitry
> 

Yes, these are compatible.

-- 
Regards,
Wasim

