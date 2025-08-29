Return-Path: <netdev+bounces-218339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E2DB3C09D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FABA58526C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981EB326D53;
	Fri, 29 Aug 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vx1+Nkfe"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DD322DAA
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484680; cv=none; b=JRfKDPLKLD1a37vDC47BC9aoXcTtZPj+8hE8RdZl5lEEoaLFRbrCDs0rtlZVHW1Q1mPDzlxJOOaaB6l+SMLWgmZbM4OdjAqqGDk/Qjf8jeytW4sxZ6EItBq3LkS/QO1310Kt47bsL4xu9Be0m/+gWumL1a/wwB53HoHPH2IT8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484680; c=relaxed/simple;
	bh=3B97zBH4p9jRcLgMlEAc2P4fRn926Py9yl1OWBr7GvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6b37/hHenQyUAzdlS2qU8iif9tfUlnuIeNfviONdOtzJeMleSwSSvGohYH/m5khuNnyrjtvdOknbOlfRQX9QP9w39JXHMVk301lWXquk4+QTUHBTiCPms0XcPzUqQ6tQ9G5xZhDy+dMlltgnIDoxb2wQi7b/Aoie1xQ7v+mFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vx1+Nkfe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85JdW025413
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XCIfjiGc29TyHYiTm4KLiwCktBOr1c2fqrZ/oTTcfZo=; b=Vx1+NkfegDhBk6Bf
	fz9QkSj4uQXedF2HcUipcq/YN/IeXx+DvrakGMN4PA8SIbyDMeF/EFY8+SGlJhCM
	hWQuULnOEPwdLEE9OI3kN3J9ENLVFPsOSQGeArClQUEq5AT2HDzNZZXN7cXGDlL2
	XEMstV+DzQaqKeu5+yvsyikbFjzUAsBHRJXkxz/H0qyhjmQUeNxQ4OMXTUVTOAFb
	hw2ZCWfBXFpoFE987qMsXv8Y4aL1WzcICnFpLL76rNO4YL2wqNF+jM2zBcUZCD1y
	MoKNK2FFxccJCt1R8PkBP7U6X615kh7h6V8HaaawsANhi73UCyGASKypSnlclA95
	rWCH/Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48u4xyhs8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:24:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b10946ab41so59705991cf.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484677; x=1757089477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCIfjiGc29TyHYiTm4KLiwCktBOr1c2fqrZ/oTTcfZo=;
        b=DZqvrksSisXpwJHd87o9zd8/ssH2GlL82uWvySHt6VRGMBR8UlajwzYAtE8nU8Zx94
         uFmiHHCRO36QKwcBobCbGVEVqZCDeLYkzd6B7YauxFxK02T4W+aYRU8EhY4P3rW9F4z1
         iqVWvgf/Z0/wvb46N+VIHoVZ+qOnU0RklZlZSY8TyK2AiddAHxCS9z1aNVrEtjCNc/DN
         D/ubiC1NvRhslbFciyRy1HlSmT5tqGHvwF+5cfAv3NPu/26mPJSCBBTK175QHHVNsiGU
         996g/kMEFMROXksGx7Mbcvie2SSbMBksjMINru0hAHy4hYpz91lURfOKVUocz1OhIImi
         GutA==
X-Forwarded-Encrypted: i=1; AJvYcCV4RYcrBQS0TB3D5GcoI/gEy4TP9b5L1fB/4KiFnpsP/BUNmnPw36zy5o9rZqEdccd8uXn520I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4aHAsstOtDdvnFpwIgU2Ozkbz2eRKwuFLz+3sbrsiq/UxEaW
	lZgCkN6MHMCm/bysorrjr7/eJ49LqaAtFuYeKRd4iKoW/6hhMC7KThjo0IzjFG6yf0+hagC4xvK
	oLUNBuRmfl6mB6AHCmNWMubb1H9Btqacvf0hn+4Tm3khGTeXuSFAR2/OG/uQ=
X-Gm-Gg: ASbGncsYt4Vo8SeD/z7T3tuin+D+aLJ8TK+IkABncFmUtpQMJVdFSvEgmF56SHS2L5X
	DT3Juk16cgi5xF8e/nmRT9yRTNe3zF16yQegE2YBi3NLwIvj8nylqNZMRwXTX6eNmMXjn7bBR2J
	vgObsARxRayzOhg7DNz/3JtBIGkhGbU0I5SkUNsS5vDbZ4B78OiHUBxmSm3Gp4NvvVwRcyCbc6B
	yOv6yRvSXUOGEhiejvVhPfpzVjbfL/ggJQbG9i9QYj6fgCyLwRglmosnBYWaYgSV+n3Q9OR1Lbi
	0ng7WR3wqQbsepzIBAIccJwTFzCdOe8e/DywE1TzHJf89HubhPD/I0SLD8aPbwS7+HNp93ZH+gY
	I+nmvJJq3zzl16J36zhJq2G6djiO7KJJG68FaCv/fMda1kWUeS6BE
X-Received: by 2002:a05:622a:2c1:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e76f6c2fmr159960051cf.17.1756484676399;
        Fri, 29 Aug 2025 09:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3avH1Zre9WfCU8qCI5LcLOBiCx7PfjvDuQh+HklBIJkQz+ZtJjjyCJREb1zAER0kzRP6i/A==
X-Received: by 2002:a05:622a:2c1:b0:4af:bfd:82bf with SMTP id d75a77b69052e-4b2e76f6c2fmr159959551cf.17.1756484675754;
        Fri, 29 Aug 2025 09:24:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678450dfsm713370e87.72.2025.08.29.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:24:34 -0700 (PDT)
Date: Fri, 29 Aug 2025 19:24:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Monish Chunara <quic_mchunara@quicinc.com>
Cc: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <ozkebjk6gfgnootoyqklu5tqj7a7lgrm34xbag7yhdwn5xfpcj@zpwr6leefs3l>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
 <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
 <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDAzMyBTYWx0ZWRfX3COKScpO3pwu
 vIe306mtenFnJv1AcDXBKp/Bsu/AYSIyzvitlqf2xAcb+r4kYZuKi1DmKMFpObUVjuRk0tHzng3
 qFE+MdpGE3JA4kqXLIoKlu4ybfLnBkg9iD5t+AFbByW9KCCoXAbLrIWsNVSwEGnMj+yZf7f0XPA
 tj5qtT2c+vu8mCOTDE7NgGHm3xbAPTj34+/Lv5Ui1Y9mc98DFzbDwPsSgiu9AcudySb3nTLf/aT
 2jh5s87PM5egSnlRUpbidCEpVhBSdgPA2PbCo9fErCYe7qhLe45cxiOzwviwUPhHC9WAIqYfVAR
 obzgQv8Bb11Jv48wO/o0k9bn2lBnKOxN4sutqap5kBNKrsY/jq9QOfFCfFBlPeIGhtqHPW+Beqr
 HRBowC3X
X-Proofpoint-ORIG-GUID: sTtnLK3fa4OtyRMiYnNG7hm3gI4lXgqn
X-Authority-Analysis: v=2.4 cv=PYL/hjhd c=1 sm=1 tr=0 ts=68b1d446 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=YDAz1v9_iDTVm1Y559YA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sTtnLK3fa4OtyRMiYnNG7hm3gI4lXgqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290033

On Fri, Aug 29, 2025 at 07:50:57PM +0530, Monish Chunara wrote:
> On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> > > 
> > > On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > > > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > > > peripherals and improve overall hardware capabilities, as
> > > > > outlined below:
> > > > >    - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > > > >      controllers to facilitate DMA and peripheral communication.
> > > > >    - Add support for PCIe-0/1, including required regulators and PHYs,
> > > > >      to enable high-speed external device connectivity.
> > > > >    - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > > > >      GPIO lines for extended I/O functionality.
> > > > >    - Enable the USB0 controller in device mode to support USB peripheral
> > > > >      operations.
> > > > >    - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > > > >      Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > > > >      firmware.
> > > > >    - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > > > >      and other consumers.
> > > > >    - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > > > >      Ethernet MAC address via nvmem for network configuration.
> > > > >      It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > > > >    - Add support for the Iris video decoder, including the required
> > > > >      firmware, to enable video decoding capabilities.
> > > > >    - Enable SD-card slot on SDHC.
> > > > > 
> > > > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > > > ---
> > > > >   arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > > > >   1 file changed, 387 insertions(+)
> > > > > 
> > > > 
> > > > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > > > >   	status = "okay";
> > > > >   };
> > > > > +&usb_0 {
> > > > > +	status = "okay";
> > > > > +};
> > > > > +
> > > > > +&usb_0_dwc3 {
> > > > > +	dr_mode = "peripheral";
> > > > Is it actually peripheral-only?
> > > 
> > > Hi Dmitry,
> > > 
> > > HW supports OTG mode also, but for enabling OTG we need below mentioned
> > > driver changes in dwc3-qcom.c :
> > 
> > Is it the USB-C port? If so, then you should likely be using some form
> > of the Type-C port manager (in software or in hardware). These platforms
> > usually use pmic-glink in order to handle USB-C.
> > 
> > Or is it micro-USB-OTG port?
> > 
> 
> Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
> controller for the same. Will be enabling relevant dts node as part of OTG
> enablement once driver changes are in place.

Which controller are you using? In the existing designs USB-C works
without extra patches for the DWC3 controller.

> 
> > > 
> > > a) dwc3 core callback registration by dwc3 glue driver; this change is under
> > >     review in upstream.
> > > b) vbus supply enablement for host mode; this change is yet to be submitted
> > >     to upstream.
> > > 
> > > Post the above mentioned driver changes, we are planning to enable OTG on
> > > usb0.

-- 
With best wishes
Dmitry

