Return-Path: <netdev+bounces-218300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C189B3BD64
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ED9177619
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABAE3203A2;
	Fri, 29 Aug 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GCFacuxv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0CF3081A3;
	Fri, 29 Aug 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477284; cv=none; b=XG/IMqTlOj73W+XGpWOemYd9jiSGDCInB9GrV+yKcMu8DzmpcK5qs11uL1V0g+9QJGuUEsZiBJWYtI4yzos+EgZmst73L4sGtmY4byISSN3rJuTsgX2BFS4WSnXP9UmfI7VMiYfoBHyoEtHgWiKFjpMAbl0C2sVyqR4dF4BNtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477284; c=relaxed/simple;
	bh=tfAIjuJ5J2TwoW92KENZ24wEQ98X+ahdvOFhl/H4IX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyEXWPkZB0E41VLJOrdvd9jvfbXv27G9rIwSnoMs6uzAbWlNzOiz0sQ36ffixXJsYf4SAS02sNnIucTS+PzG8+u0aa/w+ZQua3l031UCd+07jlDAZTCK6J+WlbNS3QIU5FoSmmf+XAwmw45ojfgRzdGQBYTjhRROYMRTR9YXDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GCFacuxv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85IOl025398;
	Fri, 29 Aug 2025 14:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LaNpyKg4mbZQAhwLrnf66qbojUSjGBrnRIBLryRVAX4=; b=GCFacuxvCltGprVb
	K2naW8UWDLxp3POgYtcqqi0CeKfsv07DcTfVY+JRZtoC0XIJj0uO4xyu1ZSI9nVM
	sM6IZVaJdjBmsrCi4DCkGBia9bm64EnPXQXS8/acbVRWL2wXvtEf3fJZt+fJ6uv8
	/pjpc8Vm+ebJuVa3oFCWLeJ8/KpzeHefYCry3aI0PlMIrYVeR2KkncSg2doLWN3u
	y5zLQ5dBe+iwpBBmuDpesHT0OYIusdwR/k3WgqlzzFc4x4jDwjmdi3ZwzRu0zv7q
	NFLc5khzXlWb4EciM4So8pqsboVNla/jmaVHs6IP9yAbj7zT1AP1RbCW9IM29T6P
	LuU+WA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48u4xyhe2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 14:21:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57TELGJF027275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 14:21:16 GMT
Received: from hu-mchunara-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 29 Aug 2025 07:21:10 -0700
Date: Fri, 29 Aug 2025 19:50:57 +0530
From: Monish Chunara <quic_mchunara@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Wasim Nazir
	<wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>, <kernel@oss.qualcomm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Krishna Kurapati
	<krishna.kurapati@oss.qualcomm.com>,
        Mohd Ayaan Anwar
	<quic_mohdayaa@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <aLG3SbD1JNULED20@hu-mchunara-hyd.qualcomm.com>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
 <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDAzMyBTYWx0ZWRfX+lnamCJJrvYC
 2FoswfxuiWgfR2gKoFC6Z5PPemV6puf9GVnkjUpBTDUjt76SmhyfQqN/fF9M932LTLO2d6t4cgq
 frqG1PZs5OZwS5vsdg+LUwpbeby10SYdfAAcX52ZzTq0I2eSGaUObZ3MFKLm8QkejljZxEAycLW
 hY4wf48K1PupSfD8FG3NN2dieDPshES4S+CyBQWrnzPXrxEDcHqaaG2EJkTnB8MF3VKhpA8pL40
 foGvM5KBZpTPcJNI43PSkJ4YRkCuDQ6fUYEFNaGrmucUZyGZZJjkN1+DfLMWZWw5rDi6cPsSHEE
 QxCMZ/2kOFGrZLVdt5PrJO2lTBHsRHV/jrbquWcLC06nk1AxVYJ05M6h2Zj8khOXITlgmKTRljS
 k+145nKA
X-Proofpoint-ORIG-GUID: WZ4Xl5DvitPPdiIUqWaNktWpEgVWIVrE
X-Authority-Analysis: v=2.4 cv=PYL/hjhd c=1 sm=1 tr=0 ts=68b1b75d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=LQCaeKDmsfC3n-DSO_kA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WZ4Xl5DvitPPdiIUqWaNktWpEgVWIVrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290033

On Thu, Aug 28, 2025 at 04:30:00PM +0300, Dmitry Baryshkov wrote:
> On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> > 
> > On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > > peripherals and improve overall hardware capabilities, as
> > > > outlined below:
> > > >    - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > > >      controllers to facilitate DMA and peripheral communication.
> > > >    - Add support for PCIe-0/1, including required regulators and PHYs,
> > > >      to enable high-speed external device connectivity.
> > > >    - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > > >      GPIO lines for extended I/O functionality.
> > > >    - Enable the USB0 controller in device mode to support USB peripheral
> > > >      operations.
> > > >    - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > > >      Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > > >      firmware.
> > > >    - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > > >      and other consumers.
> > > >    - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > > >      Ethernet MAC address via nvmem for network configuration.
> > > >      It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > > >    - Add support for the Iris video decoder, including the required
> > > >      firmware, to enable video decoding capabilities.
> > > >    - Enable SD-card slot on SDHC.
> > > > 
> > > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > > ---
> > > >   arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > > >   1 file changed, 387 insertions(+)
> > > > 
> > > 
> > > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > > >   	status = "okay";
> > > >   };
> > > > +&usb_0 {
> > > > +	status = "okay";
> > > > +};
> > > > +
> > > > +&usb_0_dwc3 {
> > > > +	dr_mode = "peripheral";
> > > Is it actually peripheral-only?
> > 
> > Hi Dmitry,
> > 
> > HW supports OTG mode also, but for enabling OTG we need below mentioned
> > driver changes in dwc3-qcom.c :
> 
> Is it the USB-C port? If so, then you should likely be using some form
> of the Type-C port manager (in software or in hardware). These platforms
> usually use pmic-glink in order to handle USB-C.
> 
> Or is it micro-USB-OTG port?
> 

Yes, it is a USB Type-C port for usb0 and we are using a 3rd party Type-C port
controller for the same. Will be enabling relevant dts node as part of OTG
enablement once driver changes are in place.

> > 
> > a) dwc3 core callback registration by dwc3 glue driver; this change is under
> > � � review in upstream.
> > b) vbus supply enablement for host mode; this change is yet to be submitted
> > � � to upstream.
> > 
> > Post the above mentioned driver changes, we are planning to enable OTG on
> > usb0.
> > 
> > - Sushrut
> > 
> > > > +};
> > > > +
> 
> -- 
> With best wishes
> Dmitry

Regards,
Monish

