Return-Path: <netdev+bounces-217744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A9B39ADD
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50713467DA5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5030DD11;
	Thu, 28 Aug 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HK8d0J5S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5930CDB8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378909; cv=none; b=KksT/Y7Yg58uLPQIK9DmzjFF1VzVcmbD/N+VyCTKEAYnAT3wHucyK9mZl51c03jVD6X16LLlRT4F9DNabLElM86G/Cv+EHtj67bqOaAikt97G7TFqdyj2kBgrFb5E4t95leIcrmnASHWimQfYu1itqaFt1yDDs9rlyHv07MuCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378909; c=relaxed/simple;
	bh=rIzLB0jFaq1zyL507dHxGg8FNAjcdbbEzFoAW2xyOKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBSbZuUJrdaWZ/odhi6O2ry0EsZIZqPc0BPmytDyL5BdMgylgiB+6bY4nzRVVi5h64gfHDT37WVnDiVnxun2zfSrn21LQuue509sI2xOq2RARj+b4mHk9F2XrQJ+PjhI+CcibKSkgLEtITnUPMk2vFilwiGFkEjxmiGp5SMXbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HK8d0J5S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S61hgc009458
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1me16EcnSUCukrxgcHBWrSlm
	42EZs4yV1yoRTh2A1HU=; b=HK8d0J5SfxyHcQDCuMJTR8s0YB5CO628d/x+4e9p
	Gb3feT4nnT8gyJOQPUrDxyF6pIOpAZA49r23YKY50Kr5gUdHZCJDUh7gbeACD4Ez
	M5+6iQEUI4zVZbMSqVG4tCLaDgUck7oo3EnmlncVlSP65zznzQRe6eBdHgFubwyA
	MAyOavOeDZ4FXsS+d3B0r1d9BiycLkjzjeevAgVfi2NFSTAbk729p6J/2Wfco/Rw
	Cj9e1tWxit+P5cwvEPCwJJ9W6k/+HUtJq3L65nLoYLnXt1m0hECglQLTdoCfkDEo
	0MVaIVt4DriEe77MzVWSVjHh8ZorfKYa9qrL9rLA3f6Oog==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ap80g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:01:46 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-53b175b20f2so322515e0c.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 04:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378905; x=1756983705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1me16EcnSUCukrxgcHBWrSlm42EZs4yV1yoRTh2A1HU=;
        b=dppYAVup2vgGZr96F05kYWdBGC9rNhe4lWiix5eFvqbxR4Z1JDPHcoZB37UMP59v+S
         ORulZRn2HNsEMxjWuszpj2sqj+ibelfSxtBJx9Q8I48Z29mT3YQzZGQcGD8VrbgLAn+d
         +QxItPtpFOxJfUTh+KKkOQkXdtMR7EbSMaZoKodFq2mT1kObgxsHYbauITVkWFaCt6u9
         QBikarsQLki2TSoVQ0eAHQjowlKuAwB+DD+ux0TUw9YaTYh+UqubxdQFafGw4LJt4YWB
         fp6LN5LxsnoYc00dylFPlIqqhY308GCujLn8MdCqlenKKvXuk1ramd75lUzgvkG09VXa
         C7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWENusLvemwVHbzj5rwbv1iXwR1eFBsnioKvZHAsSuv8NgoVaJDDxTEryc0tm957YXZ0oIvDX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaaGHQR5Xm5pGly9bhnh+XIBuWsJO+mtFaUcbf0mEES/rohnE
	tZvTkuk0KEFBCWzjrFZTY2mSCddGz4hbFEmj0bMHvSvMC1nkDHaHXN6fCJKVzYVKrPaESEVB0PO
	jULBOauYJ2zrCncavruONErobJ6toKpjFG2aJ9JrGw0eE2pY6DYxS7iYCxu8=
X-Gm-Gg: ASbGncvSCEBV8VjaP/8HINQ3a6wzw85av3Vu23T9Xcng1THYSCY1n38pTDWy3XErx0V
	UDEfGCtGbv52v8d9RFEE0+b8RmFahQxqHdLR1wMGfrcbTEgHk5IzCt1rK7PBEUCU1nCxMnf4dAh
	2Lgl2EQJ6J6+5/AIn1eJdVD0ueErhns++daP8yacdctDrCgtuoEouE3EcgRX8DK196Di3SY8Kpu
	turXnCoR6d0b52HBgwbgVHJGxchsMh+GDjuwMzQ6X27PM6bmSEXgitn3nckfjjUrrwBK0rr7qnM
	5pH7ygT9ZnKlLkr73M9EdkfmZme5pcFesYSD5W+Jl7g0gVYp+UHtXCIDOMnd5zsGNX7ZhwvJxDk
	2rP9eHkOLaChxpD+Aryw8akvn6jOCoP+fxclni5gwqTVBzvj+BP89
X-Received: by 2002:a05:6102:3306:b0:4fd:35ca:6df5 with SMTP id ada2fe7eead31-51d0cbe884fmr6423697137.7.1756378905250;
        Thu, 28 Aug 2025 04:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc+jb+s9qKPN/JCnUMGGuKVIUQOhVIj0EszZaiGONB7yq9VeiWgb02Pqf+jRkNnzG8OrY8vg==
X-Received: by 2002:a05:6102:3306:b0:4fd:35ca:6df5 with SMTP id ada2fe7eead31-51d0cbe884fmr6423646137.7.1756378904346;
        Thu, 28 Aug 2025 04:01:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8bb19sm3189208e87.73.2025.08.28.04.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:01:43 -0700 (PDT)
Date: Thu, 28 Aug 2025 14:01:41 +0300
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
        Vishal Kumar Pal <quic_vispal@quicinc.com>,
        krishna.chundru@oss.qualcomm.com
Subject: Re: [PATCH 3/5] arm64: dts: qcom: lemans-evk: Extend peripheral and
 subsystem support
Message-ID: <sqntqb4mce34vkiogrr5ze4jhgfsy4cprmmfease4e2ljiq25u@uobfvzzotj3w>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-3-08016e0d3ce5@oss.qualcomm.com>
 <kycmxk3qag7uigoiitzcxcak22cewdv253fazgaidjcnzgzlkz@htrh22msxteq>
 <25ea5786-1005-43e0-8985-04182d018aa0@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ea5786-1005-43e0-8985-04182d018aa0@quicinc.com>
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68b0371a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=bO8WyBFqmgISiikzXHoA:9
 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX5NSebALqpeay
 lxv4dSGeZGo+CF0QljwgbqpMEFsxTX0E+I2By1pWOwGfEjiIPQsiYLb131Lgb1WXFH2Tcf1TouZ
 5qhf5UM9M9zRoSkTikmZfh4qjh88Ih7xwUL+ILDCrShFb4FCGszRZoOrANkuW/1+AcwtGORjlSN
 8Jf48xMgWktsaLhurAoU49v5vKifZrMaxwn+SJsS+16tHK98DcLsM9x3RzttOWGt+LMCQ7/2lyr
 3uENQx4/TTrS9An4NgMRg16VS6IEGig9cY1e9MRJEH3e9/0F/wmuwrHxevoV+phN7Ey7KNFZy+u
 owhkCsObrQWYXwZlvSORszGLWHH4uS10wqpWmOdEBaAmLt5X4cTDASkGthYro2bY5zObQzBaGEU
 ffl13y9b
X-Proofpoint-GUID: auHpaklp70v8FaVBaBBkfQpUIMDdoYA0
X-Proofpoint-ORIG-GUID: auHpaklp70v8FaVBaBBkfQpUIMDdoYA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

On Thu, Aug 28, 2025 at 12:05:21PM +0530, Sushrut Shree Trivedi wrote:
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
> > >   	status = "okay";
> > >   };
> > > @@ -323,14 +505,196 @@ &mdss0_dp1_phy {
> > >   	status = "okay";
> > >   };
> > > +&pcie0 {
> > > +	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > > +	wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> > I think Mani has been asking lately to define these GPIOs inside the
> > port rather than in the host controller.
> 
> Hi Dmitry,
> 
> For moving these to the port requires changes in the sa8775p.dtsi to change
> phys property from controller node to port node.
> 
> Mani is asking to add these for newer platforms like QCS8300 not for
> existing one's.

Ack, thanks for the explanation.

The rest of the quetions are unanswered.

-- 
With best wishes
Dmitry

