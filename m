Return-Path: <netdev+bounces-217875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C85B3A3F8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4498C169EA2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02F821CC4D;
	Thu, 28 Aug 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+xFESxd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78576219A86
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394162; cv=none; b=ixe2OVVWHaahSJKcRYy6JWRFzxq2NJWGimv81LQFk5MMELrEVvMvdiBA+VNFPO+kNsYW4HxZ6c4cyk7ZxtE0QLuQqZRtRTeSXFrQQBwz6cqwLNxX1TQou9zAacq7UZ5N1/OIsQ5cWZyLn0PggpwMq6MNJH8jeDTXAHOAqfDEny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394162; c=relaxed/simple;
	bh=URRU48cWWZKXWYFt8cB99iHFjpEreIFbVOTSGj9tHNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu0l32znDpvQ81I5MAXa84fyHpVM47ZFCC2LSzh6f2M8T6DWDxF4tornRlPdRLA/XdourRS214/Vd3hA8ivSYWoY4zR2Wi8C7TRhHZXTMxFpOTv8HY2D7T6HkUJyi8Pm2Z3mP153KzpetxSCS+aRMyUVOISMY2NgARbG3H7+yTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+xFESxd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SADrlG006969
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=baDCJN4Ix+gOwGahkROrbNwU
	3+styHRf+7rMYdXAkDA=; b=E+xFESxdnnEimTHToxuR/9tA8PbNJaiQUx+qdK9V
	je7HYh6Yz2wxNfi+ENxmD85DkfWW1Ujm0SWws9G8YvBSeSJuGFXBK+7gcVHkFDx/
	D6Zi6tKtmOKkjlOQ8WC78/Ex7LnxC8PYY/nrUudmnU1QVOu3l865mND3Q+To30y4
	GKwPTD16++l0TPHutiTTdigM4zjsl9L6/7mq99w0jvqEVEWs2Ib1RKtKs5Ia0wUI
	MiT+ZELzLYOmhkPeAFXg8BhuGX7VOKTcUHP2QyZ4XcMts5J9+Kx5r0CZkv3MneNg
	IhZrzoxpuCyEh4RQgC/cXcaxqZ+jI2rgv2wceCSx9P4tEA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67gtjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:16:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-771e1657d01so938807b3a.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 08:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394160; x=1756998960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baDCJN4Ix+gOwGahkROrbNwU3+styHRf+7rMYdXAkDA=;
        b=WXX7u0LmvjKnkmHIVgUVBzWlLkiF5T4SX/cNDYKdfNaRbu6vRXiSEvnpc4SxOE2T+Z
         U3KxWXZNaPl4Z+ScJwbGfDyHBG9ixi4jZAIdeTCEnj7aBudXZtxCht17/Q+FFsSBOM5x
         41KbIMNMR/2JjFNAN7YGEznVn1cdzBahIW1v1TV/6Y7vum/s63/wzuzyQtIhVJpASU1+
         21JTtYCcj3zdyRS8cWWoido3XUanAC2h3zX3EgN64ek1QcsNdXMnuwIO+diT5QzxzXy3
         eZ2eWfYlmi2C7YwRQOQTBGjRAETTKFU70PfBVLXeMuTnEAcD8pFj9qxw1Qebzfzl34D/
         PeJA==
X-Forwarded-Encrypted: i=1; AJvYcCUXcz3JQfccX/WMV2/3UczYNP0O35yyneBwT1MyQW7Cbdq+R/tvLQ5lsbLT3fN2IK4evHNHg8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nFmDA1lTPBqzTBMC4awL4jc7BeMgBjepUr1DP66PSb2McI/r
	vV+igAuUTvZ8qO9MJeNzeCwZW4lA8yaWd5tgjBRaZaENdwyTsK8/CpDPF4fOkP41DdQXvxhrTnB
	TCFjbZsqOmK/P4jGWNL13tHjxX9PkV77VdCdVhyCx0NOumzq94X7cZLi4bKI=
X-Gm-Gg: ASbGncu01nCdgE4Vj+MClcJXCdDEHZS5TzqXxwgyTyCthqHuuRUg9tP7LcXgh+BDEDl
	GBBHIuJlag8sVb3/1CyWFC6qp5xfP3iXjMqXipflBBzP+CGSx8jvEdTHU8hPu+24kvYQpFfmaWV
	WIzIhwAPx8JpgdPTYiLLOzc3qMM7QCVXVcdKHOjrGVsD/Rv+CN2Zo8r4ZSJBtkQGYwUkoyBQ34a
	4Q6jF49GbRlA+zywvooTIdFiJjKdxnSitK82bBX2nEVF8yPhe5Il+AOHGYp/psuhj7YHjN1Rts3
	lNALLsbdU+G2GQU4Z6KaEpxR9P/aK3nVs6oKEDtAPxLMWBgdJg3MCpqPAJqNAFICj43A
X-Received: by 2002:a05:6a00:2d85:b0:772:a5c:6eea with SMTP id d2e1a72fcca58-7720a5c7183mr8959034b3a.17.1756394159443;
        Thu, 28 Aug 2025 08:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+f+TmPKCG2a3iQClc3TLskdjaiUttLjb5wUJrFV04qdT1/xLcvX7ROCMwXEmiI50+eK2WA==
X-Received: by 2002:a05:6a00:2d85:b0:772:a5c:6eea with SMTP id d2e1a72fcca58-7720a5c7183mr8958959b3a.17.1756394158822;
        Thu, 28 Aug 2025 08:15:58 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770eb8b94efsm12551158b3a.40.2025.08.28.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:15:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:45:49 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <aLBypYX9y4KPPSji@hu-wasimn-hyd.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <bab2e05a-140f-460c-8c28-358e37727c6b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab2e05a-140f-460c-8c28-358e37727c6b@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX7julZqzDA0mb
 96LePbtIhCzvKs8f2p2VN6OakFVtdcplO5floIrEuAB0JXyLKVaKpbn1Y4ziHu6S5lx7WCUHdWJ
 Xw3r1vLOom0aDYjRa3Ui7MxL2mMcwpCXBM1DMfmCZCGBzTZP1KiKRwIF37+HXcUMrK296tPzLIf
 mBSYUmy2yxyg1Mm3WNhfrfYuV1oJYLupeEhJCxla1KSnzfEFLCJRATtiNIseZvNkKp5s4MjmQf7
 h5w/nmIjGjw/mURAkxTd35Vk/+zZfKEBCW4XVZP38ZCQDMfnfN8Anw0+91BXoR/uvQHPNTW3QDH
 A+COTNGcHSuIQ7TRrIieeTxVHHVb+thBf2mQg5yJTYj0gEvMmYU0EWU1Cdmb8I1SD9diSNc1d4T
 n9EnhR2R
X-Proofpoint-GUID: m-N28VBI79dEbWJzRdSxPNxreu5zWLQW
X-Proofpoint-ORIG-GUID: m-N28VBI79dEbWJzRdSxPNxreu5zWLQW
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b072b0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=UXIAUNObAAAA:8 a=ogXbWB_6-ELqwvBGSFsA:9
 a=CjuIK1q_8ugA:10 a=bFq2RbqkfqsA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

On Thu, Aug 28, 2025 at 08:56:07AM +0200, Krzysztof Kozlowski wrote:
> On 26/08/2025 20:21, Wasim Nazir wrote:
> > +
> > +&gpi_dma0 {
> > +	status = "okay";
> > +};
> > +
> > +&gpi_dma1 {
> > +	status = "okay";
> > +};
> > +
> > +&gpi_dma2 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c18 {
> > +	status = "okay";
> > +
> > +	expander0: pca953x@38 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 

Ack.

> 
> > +		compatible = "ti,tca9538";
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		reg = <0x38>;
> > +	};
> > +
> 
> 
> 
> Best regards,
> Krzysztof

-- 
Regards,
Wasim

