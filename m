Return-Path: <netdev+bounces-220712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016ADB484BD
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B867A1D1F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32D2E719E;
	Mon,  8 Sep 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFc07t5B"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7442E54A1
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315006; cv=none; b=nNzmm+SgkdSAH6DUhV+DsTSb4Qs53oAYtUc1oJpVun9q79wwNPM94iYrNJ3d9js6r62agUYNQTnR2IPSL8HE1Ph0Qv4aAQE7/s4cgL8PBoY/d95aE8Y4WmOsEA0mXqBBv6uK8pNW3wymUznH6KirmVUH5skj2unC+80WeckfY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315006; c=relaxed/simple;
	bh=17UQX824nlbVdC+aYTL514AyIs6q26ZvyaBQ/3ozHsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkA1G2OkUI8Pr5LxuO35yyMniZ1uqBiUTg6q6PeH9WhZ5nAgufGqlmqMDWYCFvyg9iQGBNuvXDsMv3Ih+nKieXF3LOBfbZRwIq2yeMbaS84upTJc5/KRS17D6dJe2Cjdi0FuutB61Qt93s5mcPfhqSRo5LQPuT2mFInP5DWVLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFc07t5B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MRpJt000749
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 07:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eFkNTr8zzb2XRVtI/ozEIlqL/lrSUHLn6CThYwbEDL4=; b=FFc07t5Bd0XZ2+lz
	jg9evOPzdBkZ8LbubWd3UuXnCz/MZXPVwboy8cG5qBvlOm9fnG5Uiyg8THGI4yi7
	d2Y1oNdwm8hWUNZqWIGA3GMHodu6qOQGnNSwd90gHH7I0hpsBZxOBjdEFk7a4MJw
	mowJLMyTuOaXYSTVZRYAWj76nhPyMja50VhXzVPXMQ7X9glH8Xs+ccPwnYFCgU+f
	PLdZGHQmZTUKWmEZUreEMA0OUfoVtBibCOKVST4wN2bsPuvHbiGg2VD8Xj2Q+Eni
	zm/tHrBJXLlfhe3QqyAcFYNOjUpGfQTZoWaNq+yZt1o1kgEkmUBaswrdNYJxWM3V
	nkiecw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j3m62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 07:03:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458345f5dso56826395ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 00:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315000; x=1757919800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFkNTr8zzb2XRVtI/ozEIlqL/lrSUHLn6CThYwbEDL4=;
        b=AsDssXXE9dEwfzm+YjPJ3HtRVqvt+KclkUTpQ5SOmfgjSiF8qGzzhDVLvn87RUNm2p
         jB6NJG/hOr8FRrgW03pJfi/rkmh33SLrGg/I4J1x8tnG3tMEEu9h7bwiiBHOGYp8AzNc
         /HsSM8C4fRhSUn0WVDGtRIg+2CrKbtV4HnDdARXmVMKHBqiAvnoVpqozCWimLkF97ySy
         RwSKd3xVqIDEe5tFV6PzD1zrHYh7/Ro7o9Ue7rgRA1a7E8cwdO/Sm7h3Iwo98e+Z5e5G
         CbCREW1GmQTA+6BR1oOcCS6TWXwo8FZCbfD6YNVn6Kfj0p5KXtRTQ7x6a4G84TFU+aBA
         qJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvV+xTidGqG6twufsbWo/WjvXHFhg/oCbciKHER0RL0uwRQMVRVGRwqyMMpzo7PtCFBhUX/rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOoWPWzdRfWOFHWNLW3JsZ4vpMdoZTi8NmpTAa4jMe0OAd9Fv
	iHaDPXlpYWIKGIBrM/juEwKwa8/7+XtJpAgCoS4f81bOeW5oAnDqXjzimDaDFwZ1Rp8p5Pw/MFV
	5MocnJ+9NFHDJf/SuWFaC4FU3DVed6TyCt5ok/gW/FmSyPzeJuMSdl9aKfUk=
X-Gm-Gg: ASbGncuNRbZcAEI5DBnhRz+QGjSo7HJwR81Xi6D3a/Q5VwgcH3RZHeOusbpVdQm2T22
	ZYF4h5PT4esOnt/mY3sAETPblYKJ5YevHzzS+eYSQmM1v4s7av0mNQe/rz3n0F4YQlMp8PCXVyZ
	eC/+Cvul6JQRYOV0BKnXEodueuGzU3c98OrO4gBTs4icoR2l3t7VFnQ9lwruSLtzKH8p+Rr1Jtb
	sycuINXdQrnvPy7MeI9TGB4blDoBIOhi6oSz9V7wi6+yHIJ1KFaBtj001ujPn/xmElHg68ZKYR/
	dX73Y5/juGO4pnS19TBP3E4jhsrFzJFdPfEm7ISn316kgJEmhp+2hdsY1vYbsacsJ2TE
X-Received: by 2002:a17:902:cf4c:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-2516dbf192fmr100673555ad.6.1757315000312;
        Mon, 08 Sep 2025 00:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHAR6RVUYMHh/34G5+HxwgKEqD/SZwYH4tzTafc/vIO61o6ubhI4u1IV9iY3SgcDS+3f8lLA==
X-Received: by 2002:a17:902:cf4c:b0:24c:7b94:2f53 with SMTP id d9443c01a7336-2516dbf192fmr100672855ad.6.1757314999648;
        Mon, 08 Sep 2025 00:03:19 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f89809sm238283025ad.2.2025.09.08.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:03:18 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:33:11 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 2/5] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Message-ID: <aL5/r65/WBXx2JHG@hu-wasimn-hyd.qualcomm.com>
References: <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
 <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
 <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
 <53aac104-76fb-42b8-9e0d-0e8a3f59b2da@oss.qualcomm.com>
 <zw6o6nxczrzz3dkreq2nuxalbrlv7jmra2hs3pljew7xnbuepo@b6rs47vnnctx>
 <d3e96be4-8c78-4938-8072-abdb0f0e8f05@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3e96be4-8c78-4938-8072-abdb0f0e8f05@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfXypVRSFeyJUe9
 LdmMSexteQ3Xxky743ByprOH+I1hKkTvOuBU61Wx54zhz0B07qGLLpAuCTZ9vKOdKh3apwt5bf6
 F4fo060xzm7/Ks73udCThD9ClPlpau/s2o2l6Ss6Z1lNyhVAswkQfyysvt+VIqj+afE7/8CNl5i
 OOWf79tT6yhIJO8GbVUNC/SM07qqKWe8ErHv5IphReik8yWaRTWGZSCqrd8pc9hs/hf4JfzXZO0
 7av9jvcPW7t6Csh8x3t+TlXib5kAl+ayyq3oekwPHS/Wt3zjzzXqzEd+OX5o5GAt0SWk3uc+5xW
 M8NgNSwh4f7EeS4vJ5h9qrI+kdNt6rPAPVPQpP+u54HlqOH1g8wzasHfvx5yaE5qcxBId4ufRhA
 H7wBoX1y
X-Proofpoint-ORIG-GUID: 4tbyN9yqrp24JnmLrY8P3cwSQl3hi-FN
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be7fb9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=jXrvpXCBLM6H2ZY3dOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4tbyN9yqrp24JnmLrY8P3cwSQl3hi-FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On Sat, Sep 06, 2025 at 10:28:47AM +0200, Konrad Dybcio wrote:
> On 9/5/25 3:44 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 05, 2025 at 02:04:47PM +0200, Konrad Dybcio wrote:
> >> On 9/5/25 1:45 PM, Dmitry Baryshkov wrote:
> >>> On Fri, Sep 05, 2025 at 01:14:29PM +0200, Konrad Dybcio wrote:
> >>>> On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
> >>>>> On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
> >>>>>> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
> >>>>>>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> >>>>>>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> >>>>>>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >>>>>>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>>>>>>
> >>>>>>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
> >>>>>>>>>>> This controller supports either eMMC or SD-card, but only one
> >>>>>>>>>>> can be active at a time. SD-card is the preferred configuration
> >>>>>>>>>>> on Lemans targets, so describe this controller.
> >>>>>>>>>>>
> >>>>>>>>>>> Define the SDC interface pins including clk, cmd, and data lines
> >>>>>>>>>>> to enable proper communication with the SDHC controller.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>>>>>>>>>>  1 file changed, 70 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
> >>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>>>>>>>>>>  			};
> >>>>>>>>>>>  		};
> >>>>>>>>>>>  
> >>>>>>>>>>> +		sdhc: mmc@87c4000 {
> >>>>>>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >>>>>>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >>>>>>>>>>> +
> >>>>>>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >>>>>>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
> >>>>>>>>>>> +
> >>>>>>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >>>>>>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >>>>>>>>>>> +			clock-names = "iface", "core";
> >>>>>>>>>>> +
> >>>>>>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >>>>>>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >>>>>>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >>>>>>>>>>> +
> >>>>>>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
> >>>>>>>>>>> +			dma-coherent;
> >>>>>>>>>>> +
> >>>>>>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
> >>>>>>>>>>> +
> >>>>>>>>>>> +			no-sdio;
> >>>>>>>>>>> +			no-mmc;
> >>>>>>>>>>> +			bus-width = <4>;
> >>>>>>>>>>
> >>>>>>>>>> This is the board configuration, it should be defined in the EVK DTS.
> >>>>>>>>>
> >>>>>>>>> Unless the controller is actually incapable of doing non-SDCards
> >>>>>>>>>
> >>>>>>>>> But from the limited information I can find, this one should be able
> >>>>>>>>> to do both
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> It’s doable, but the bus width differs when this controller is used for
> >>>>>>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> >>>>>>>> only what’s needed for each specific usecase on the board.
> >>>>>>>
> >>>>>>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> >>>>>>> properties inside the board DT. I don't see a reason to deviate.
> >>>>>>
> >>>>>> Just to make sure we're clear
> >>>>>>
> >>>>>> I want the author to keep bus-width in SoC dt and move the other
> >>>>>> properties to the board dt
> >>>>>
> >>>>> I think bus-width is also a property of the board. In the end, it's a
> >>>>> question of schematics whether we route 1 wire or all 4 wires. git-log
> >>>>> shows that bus-width is being sent in both files (and probalby we should
> >>>>> sort that out).
> >>>>
> >>>> Actually this is the controller capability, so if it can do 8, it should
> >>>> be 8 and the MMC core will do whatever it pleases (the not-super-sure
> >>>> docs that I have say 8 for this platform)
> >>>
> >>> Isn't it a physical width of the bus between the controller and the slot
> >>> or eMMC chip?
> >>
> >> No, that's matched against reported (sd/mmc) card capabilities IIUC
> > 
> > What if both host and the card support 4 bits bus (normal SD card), but
> > board has only one data wire?
> 
> Ohhh, touche.. I assumed it's "smart" like PCIe, but it's (probably)
> not.
> 
> Sorry for the trouble, Wasim. Let's keep 4 for now and get this patch
> merged.
> 

Sure Konrad, will move this to EVK DTS and keep it 4.

-- 
Regards,
Wasim

