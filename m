Return-Path: <netdev+bounces-217832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C212B39EF4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA7E1C838BD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF14313E3D;
	Thu, 28 Aug 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WdVPK2jG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A6313E3A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387816; cv=none; b=Y2jtk11M1gOm/ok2dkOgPf7/DrxYSHtAeRm/DBLRl8rKzZ+HTyqP6PyeG3hmjBKEXcBtaMoBAfmoUs3vHwxOuhWAQ+Kf1Hzard6IjX4p+wJEMPhCn5tuqOndUggWC7E1beZUZ7eh58wcFm75uTSiNWIoJw0gTXtW5M/LglM7OCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387816; c=relaxed/simple;
	bh=cv0ZxHdea5CKsewlRvW/nTV3U8O64mbsID3Dg6IGx0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K27YB/PjIAAm5Zn9ijSmwp2T9YSwnWyDwvtVwthvgh1/zai8jbSmPKSjsgh1Hqwk+SaEsKjXZW6O/zy8VHmyPC6LEEcguFiqYcx86E4Lra/GUF0IyjBGjGaBq8HQMCn0o9diSMNK8hYWL/v1y1G2jvuEPcp0mlv789QEzQ0ZQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WdVPK2jG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAE5hi007245
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1IRldKz0gQmhFQYU2bb3SAPuJJrpPeWPFtRHihBROo=; b=WdVPK2jGbR8S0q4p
	vNFhQDsCRbecVWA+fCnLIBrkBx+EWt2dqWkdCKJ+OgemYk4l0b0y8X+shn5sZFmB
	LHlBk3TXiGkfoaL9vZFkTT2UTdIkluEnODuBI6TbGwHEUK7dlqS7H+YRQBfWsdtI
	moblJdPF52D+fmAQ11reSz25Q6iOxf1Qn0+OrARUkOcelB+PYrc+KxtAg8Rqr6Tq
	X3AqiNm/FsP7G0EQlyDxvBsZhb6a2QgcNKA5Ls6xGeDb0uy65begVgG1H/ON8unt
	ow24+4Fpv4f5mjUZGsvwW4XCDcbh6KH4GpbvGhRg5DvwUFnUtjJ//UH7nPbjucrc
	P6ssXg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67ggm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:30:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109be525eso21030971cf.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387804; x=1756992604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1IRldKz0gQmhFQYU2bb3SAPuJJrpPeWPFtRHihBROo=;
        b=HJsgolvoHhSJIpGzKicdUWsD/v4KY2X7bb+I+u3FPCeK4SbWRPagI+puTPBfd2jHKY
         kM9Rg+KoFFkVqd/UEJYBjWKKrRKDy6LexLAeK7IioySgAxRRI4Jhqz5tNyJ5PKWBIZN1
         yBPXlZJcfA15iPac4sguk7sLxqHn2Jqni0zTAa8y2JmfiAmrkPeO3GC90DxejIJpvXqY
         7ltJywE0VeSC2tok76a1NGD/ISXEoESVngD/8RjwBhEWl3fyjZ5N/ubtWzJ1/tCjbFln
         9QkbG5btQfI8YCmVY5Dym5IThJRmhRfSD7MDfTcS9XmnHaJqG7aamoN+Z+cEj9SUKSRU
         sHhw==
X-Forwarded-Encrypted: i=1; AJvYcCW8rHTtDVL79tWfpRHwRiCQyu4W57g6neyYdycwkYuB4aAfVs6MpiYp6p0YHj11X7vFUBHV7ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkQ5v1OLX5NwuJDYS34maLqUdCG2YXYNCXaRqZMcckT5Kpr3U
	JzDSvTola8tBdurrJeWkoA4bMFBqqLSI1LGtVaVkqEqYOpdZtjPJEplnJLWxGSvCVO2JOfSKSZ6
	P1HMCMTBzAg0rJxesbutmM748+I62yfbp+LImu6wbNHy9fb2DmKaz7eYQfP0=
X-Gm-Gg: ASbGncs6hWuUpdykgfbplBjgZfhoIK4nQpxWW73+PlgVDCVrhc5G23gGkFBTtkL58b6
	FLZMcwu3ZqoWnmfl/S1To+ag3SbyCVndqIFOlq0U2PVEzIT36/OPiKn0XB2mBxD5uinCclpLrw5
	1QUsL6nXMtyDjuOWM/y4Y2zpkmJviAwf/96eb7eqTq+3ijDTNu7xMAilya/Ga92hQkKR46LBTvj
	tSvTcfe29kUxC2I5K4i0SkXLz5a7a3z5A/ywdb75QXKzZPmNe7KPCYrCyHHIi3WQLWB9P3nwOba
	F1KyGo2tdq2VN6saumItdS4eynGuCn5A1A1is4pMK8sNzRSI02H6lVhsCZXxWddAPBBMSWm0uS4
	OeT6YRsv63xClFp71gjpIsm6d16W4rvG4BfiKCZFYk+PJUHBe8F/0
X-Received: by 2002:a05:622a:5b9a:b0:4b2:eed0:4a61 with SMTP id d75a77b69052e-4b2eed04cffmr82140691cf.71.1756387804432;
        Thu, 28 Aug 2025 06:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaOiP53QzP+S1t68Ggm4fjMOYi9fuzbFRp57u9VDUOAbeZXX2cOuJSczfNUU5F5LjJth2aNQ==
X-Received: by 2002:a05:622a:5b9a:b0:4b2:eed0:4a61 with SMTP id d75a77b69052e-4b2eed04cffmr82139901cf.71.1756387803743;
        Thu, 28 Aug 2025 06:30:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f489f09a8sm1977650e87.116.2025.08.28.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:30:01 -0700 (PDT)
Date: Thu, 28 Aug 2025 16:30:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
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
        Monish Chunara <quic_mchunara@quicinc.com>,
        Vishal Kumar Pal <quic_vispal@quicinc.com>
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <zys26seraohh3gv2kl3eb3rd5pdo3y5vpfw6yxv6a7y55hpaux@myzhufokyorh>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f94ccc8-ac8a-4c62-8ac6-93dd603dcd36@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfXwTLRVuBpvB/t
 JmLRiZ3LojgthDKxQMZOADYhabe62152lyfaUnipF6oGa277hKD6WFJE5S9x8Snr1NPm5eAT6r+
 M69QAbb0r1HJsiadKYlbCV49mpJVf4DmALKUE1dpZNXtzc752QmOmNynLdnuID0pld/31e0BZNc
 CdhGEkz0kkuxRTl+34h+RL6IdHtvFan7AA3qf27CleMvVIJH/KkMTO0fAIuUexIi32GVOxqqNi1
 xKIJF4Ym97d/cUCmJkua4P6JXKNsgAzOwYse0gJaDsByySWDP1teYyhoUNfd0azn6sSNRwS0h4r
 K2xyNyoUfhgom9Rcbp48XgaEPH0kLOffJtXL0K2ylvfXIM7cjvtvzlB1mwlYpm4afKMYPbW1c4L
 e9iOgDOk
X-Proofpoint-GUID: g8D6uTC-Uc04oNpIGy0XsLsGcQwZuWW0
X-Proofpoint-ORIG-GUID: g8D6uTC-Uc04oNpIGy0XsLsGcQwZuWW0
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b059e5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=bO8WyBFqmgISiikzXHoA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

On Thu, Aug 28, 2025 at 06:38:03PM +0530, Sushrut Shree Trivedi wrote:
> 
> On 8/27/2025 7:05 AM, Dmitry Baryshkov wrote:
> > On Tue, Aug 26, 2025 at 11:51:02PM +0530, Wasim Nazir wrote:
> > > Enhance the Qualcomm Lemans EVK board file to support essential
> > > peripherals and improve overall hardware capabilities, as
> > > outlined below:
> > >    - Enable GPI (Generic Peripheral Interface) DMA-0/1/2 and QUPv3-0/2
> > >      controllers to facilitate DMA and peripheral communication.
> > >    - Add support for PCIe-0/1, including required regulators and PHYs,
> > >      to enable high-speed external device connectivity.
> > >    - Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> > >      GPIO lines for extended I/O functionality.
> > >    - Enable the USB0 controller in device mode to support USB peripheral
> > >      operations.
> > >    - Activate remoteproc subsystems for supported DSPs such as Audio DSP,
> > >      Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> > >      firmware.
> > >    - Configure nvmem-layout on the I2C EEPROM to store data for Ethernet
> > >      and other consumers.
> > >    - Enable the QCA8081 2.5G Ethernet PHY on port-0 and expose the
> > >      Ethernet MAC address via nvmem for network configuration.
> > >      It depends on CONFIG_QCA808X_PHY to use QCA8081 PHY.
> > >    - Add support for the Iris video decoder, including the required
> > >      firmware, to enable video decoding capabilities.
> > >    - Enable SD-card slot on SDHC.
> > > 
> > > Co-developed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > > Co-developed-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > Co-developed-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> > > Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> > > Co-developed-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
> > > Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > > Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> > > Co-developed-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > Signed-off-by: Vishal Kumar Pal <quic_vispal@quicinc.com>
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/lemans-evk.dts | 387 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 387 insertions(+)
> > > 
> > 
> > > @@ -356,6 +720,29 @@ &ufs_mem_phy {
> > >   	status = "okay";
> > >   };
> > > +&usb_0 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usb_0_dwc3 {
> > > +	dr_mode = "peripheral";
> > Is it actually peripheral-only?
> 
> Hi Dmitry,
> 
> HW supports OTG mode also, but for enabling OTG we need below mentioned
> driver changes in dwc3-qcom.c :

Is it the USB-C port? If so, then you should likely be using some form
of the Type-C port manager (in software or in hardware). These platforms
usually use pmic-glink in order to handle USB-C.

Or is it micro-USB-OTG port?

> 
> a) dwc3 core callback registration by dwc3 glue driver; this change is under
>     review in upstream.
> b) vbus supply enablement for host mode; this change is yet to be submitted
>     to upstream.
> 
> Post the above mentioned driver changes, we are planning to enable OTG on
> usb0.
> 
> - Sushrut
> 
> > > +};
> > > +

-- 
With best wishes
Dmitry

