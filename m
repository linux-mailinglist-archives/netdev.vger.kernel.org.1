Return-Path: <netdev+bounces-220324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C874B456C4
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2251C28214
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378072615;
	Fri,  5 Sep 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wz5hYcs9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948834A321
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072719; cv=none; b=VtuScZblzaKEoaFCo0L4YguAgn3U55GhIr7/+w4ahThtQBp9HyFrZPcgQA4AVVG6+oEQp8cSIbiOswDE59OfXQtyuoFrhmJEF+SesNVcFEgrmOkeYAOESwVQcq2OrFB2CatSe0pm3MciXjU2EjgYLp6GNfQEiDGW337XOtTWr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072719; c=relaxed/simple;
	bh=BGGZ/ELDswRXBatmlsy/yvTpLKnGxcJMcui0IavQz28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnlSV3z9R94ieUnc/Ef64GYw+UtiW8Gzots1b7ufGDPkHyOYnOoSbCGeUX3QHSBZe+Olt2ED6LNCLYQfHu/0ZkUZj8QprGp5jnVieVFoF5pNpZyfZ20LDP6IDf0HmZJu6s4s1UA/dhzWdfDvYhxxPXGogWjD5RgKHtlnPCwQ/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wz5hYcs9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5854eTwZ018594
	for <netdev@vger.kernel.org>; Fri, 5 Sep 2025 11:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JrwiK3+YBBKfTwjeyYweO2evQz8q+FFooJOWqyd2ccc=; b=Wz5hYcs9FTztI+IU
	CgkG401Y2rP/T87qgJJKLpMkXoqvnnWZ/MJGE0blxXjtnmeLp/jmueLL+UvM3yb0
	53L74HNwwUvgITVz3wEW3b/A65X6E6NJG9NxPJHXeySO5MA38uk/ALMNoG7S4p6Q
	F7E4MdiI6I7BOBDammHxZ8JEko2icpj6TQEd7e3NtlEr/pFakxcTuYWJKJCkZo9p
	rC0ZP79vLWy+doLCJ42luGh6gFNA9G6nYKcLGZosOVzm6UphYl0uwLAbzlFqlPN+
	8ChrLFMvh1M5RrEjnECuL0jCGX9ZT8uSG/Uun6Cm5hMqAWJZ1hZ9SoV/4/s2808E
	aNCyXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebutvea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 11:45:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ffb4a65951so680824685a.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 04:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757072709; x=1757677509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrwiK3+YBBKfTwjeyYweO2evQz8q+FFooJOWqyd2ccc=;
        b=lcSJfBhXNxQoDdT2LjtzLIEemd8KIzAgUmPi9aNi96DUPf795736AuXxCfwxpGM8MU
         aacU5lk4fgutu8h1M7bbcts2Bmo9JgX2WQ2ixMVUopwkC4zLE03FMfsZ3gU7o5fAY5Kx
         v8PybVGHjdjqtF7BXPHrIS5keCpmHiTREywqa4WwCzCzRrurHet5XzJ/qMSJizpMUzdk
         PsRk/Grmr57VapdCx3RYFh48kItzM+QzGUUxW/7YIn02S6/qOlRv9nYEbj9pFLqbQTz/
         lFDAeWBZth1ANCzA5mdHZHi8bEPOyQtFAu08Wj2HQKKPPJiq819ISHC47NiCQFz0UgVn
         Wvog==
X-Forwarded-Encrypted: i=1; AJvYcCXayV3a7x3nO/U44ccutuk6zQzMJQEqBXTjY3xOExvJGD9n3ypvxBbkFgZEtoS8hWf6lm5xmo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8vdttIcikq14OZbSuZsPu1GX/YT9pqHUr77Lgz5ks233OoWy
	WGQYPq9bmg57H4j+qG0Oef6cE2y4VeBGvpDRMmV+621JEudZlAvjJW+9leTqQIBUzBqA9mmCvEM
	+btrA9CwiIJpEHwYUfgk2UUp0fiVWHJr8O2ZYnZs308LYvEjgAjPx3H4Sa0s=
X-Gm-Gg: ASbGnctaTkhEorAzpnBWeR8+Xorz4WnqJO7gKeLPb31yN6b4FkVHDOu2yO2BrIqJBAj
	36uaQ02SmoXC3QikLcM1ADqJqjMROtIzC1bc1gGUVbxAw8b/EZkgNSptxoowM6UV14XQ78Yakxr
	mbp3cEe8nfvbANYXzIvj/RyFEo6flBoma4PPMv8/bsEEb0x4fGPVvsJP0W0Ff5fdZbNcxUpkOus
	qwEp3XdcvsLbv+d+TvFl3Rm5gUSwwimvSll8r0uBg3SPLK1NKdI6i7ADE0LzpnHYeZAyKWf7B8I
	rnrLO6ssQYcK9jUvGUsljpEqUdpzq6a8KrbMs2XPqHbkDxZtcYVB1LG3PdQnbqO/akKGFWmWVz5
	Ypkt3tlxF5mk8qkSB5t7ga/UE0x7xDSbGtbuFZzTyDQECXWBRSDhN
X-Received: by 2002:a05:620a:179e:b0:7f3:62f3:32c7 with SMTP id af79cd13be357-7ff2b1d1980mr2415309185a.49.1757072708807;
        Fri, 05 Sep 2025 04:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcuxKXmP9sMAXZXFv5luGupilJaBfmlbkboCf2+phHC9krfABEbIlHwDZFOn6G2BDDWqoqSw==
X-Received: by 2002:a05:620a:179e:b0:7f3:62f3:32c7 with SMTP id af79cd13be357-7ff2b1d1980mr2415304485a.49.1757072708088;
        Fri, 05 Sep 2025 04:45:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3380f68331asm9641041fa.12.2025.09.05.04.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:45:07 -0700 (PDT)
Date: Fri, 5 Sep 2025 14:45:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
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
Message-ID: <xausmwmh6ze5374eukv6pcmwe3lv4qun73pcszd3aqgjwm75u6@h3exsqf4dsfv>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-2-08016e0d3ce5@oss.qualcomm.com>
 <rxd4js6hb5ccejge2i2fp2syqlzdghqs75hb5ufqrhvpwubjyz@zwumzc7wphjx>
 <c82d44af-d107-4e84-b5ae-eeb624bc03af@oss.qualcomm.com>
 <aLhssUQa7tvUfu2j@hu-wasimn-hyd.qualcomm.com>
 <tqm4sxoya3hue7mof3uqo4nu2b77ionmxi65ewfxtjouvn5xlt@d6ala2j2msbn>
 <3b691f3a-633c-4a7f-bc38-a9c464d83fe1@oss.qualcomm.com>
 <zofmya5h3yrz7wfcl4gozsmfjdeaixoir3zrk5kqpymbz5mkha@qxhj26jow5eh>
 <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57ae28ea-85fd-4f8b-8e74-1efba33f0cd2@oss.qualcomm.com>
X-Proofpoint-GUID: aZmQ-L_NHUbCGBmPP_x4rcm-olzjCu4M
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68bacd4b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Hq1aP8QxBszXHj81Fu8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX0iy/GgMEYWfh
 f900rkOvrbDbWXkpAk+y4QfGMBPvcxU7X49kDY18TVKvJCz/l8TP1IoZo3PHOa2NlsRtQp/Fm1b
 NzRuPHAWxQo34RBQzz0mmegLsOSvfwvQuYe+I5eKv/VnVifobnpJ1Aj0XEPEMvB2Y3LghnBxTZI
 ZfEA1TuDwuz1nBQW7MGlFFRBDt7c8dkq9jF2veGPDGSqd38YBwNOHhZmv9DF8DcShn6ayIsozvO
 JRTJ+OqdjRur/50HCphcTyvTFZDc5bVbrIV/Xg66oPW+QcTfHrkLVBycIoEe/CnrPj7ego1a1uj
 G4njbJk9FB36TY4sPaXizhPwAv1ntm2wlJIANBHLwCn8DoNWc6BnJobfrIC8sNeuM17y/gDJnQP
 Fo7YD8G/
X-Proofpoint-ORIG-GUID: aZmQ-L_NHUbCGBmPP_x4rcm-olzjCu4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

On Fri, Sep 05, 2025 at 01:14:29PM +0200, Konrad Dybcio wrote:
> On 9/4/25 7:32 PM, Dmitry Baryshkov wrote:
> > On Thu, Sep 04, 2025 at 04:34:05PM +0200, Konrad Dybcio wrote:
> >> On 9/4/25 3:35 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Sep 03, 2025 at 09:58:33PM +0530, Wasim Nazir wrote:
> >>>> On Wed, Sep 03, 2025 at 06:12:59PM +0200, Konrad Dybcio wrote:
> >>>>> On 8/27/25 3:20 AM, Dmitry Baryshkov wrote:
> >>>>>> On Tue, Aug 26, 2025 at 11:51:01PM +0530, Wasim Nazir wrote:
> >>>>>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>>
> >>>>>>> Introduce the SDHC v5 controller node for the Lemans platform.
> >>>>>>> This controller supports either eMMC or SD-card, but only one
> >>>>>>> can be active at a time. SD-card is the preferred configuration
> >>>>>>> on Lemans targets, so describe this controller.
> >>>>>>>
> >>>>>>> Define the SDC interface pins including clk, cmd, and data lines
> >>>>>>> to enable proper communication with the SDHC controller.
> >>>>>>>
> >>>>>>> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>>>> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>>>> ---
> >>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 70 ++++++++++++++++++++++++++++++++++++
> >>>>>>>  1 file changed, 70 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>> index 99a566b42ef2..a5a3cdba47f3 100644
> >>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
> >>>>>>> @@ -3834,6 +3834,36 @@ apss_tpdm2_out: endpoint {
> >>>>>>>  			};
> >>>>>>>  		};
> >>>>>>>  
> >>>>>>> +		sdhc: mmc@87c4000 {
> >>>>>>> +			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
> >>>>>>> +			reg = <0x0 0x087c4000 0x0 0x1000>;
> >>>>>>> +
> >>>>>>> +			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> >>>>>>> +				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>>> +			interrupt-names = "hc_irq", "pwr_irq";
> >>>>>>> +
> >>>>>>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> >>>>>>> +				 <&gcc GCC_SDCC1_APPS_CLK>;
> >>>>>>> +			clock-names = "iface", "core";
> >>>>>>> +
> >>>>>>> +			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
> >>>>>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
> >>>>>>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> >>>>>>> +
> >>>>>>> +			iommus = <&apps_smmu 0x0 0x0>;
> >>>>>>> +			dma-coherent;
> >>>>>>> +
> >>>>>>> +			resets = <&gcc GCC_SDCC1_BCR>;
> >>>>>>> +
> >>>>>>> +			no-sdio;
> >>>>>>> +			no-mmc;
> >>>>>>> +			bus-width = <4>;
> >>>>>>
> >>>>>> This is the board configuration, it should be defined in the EVK DTS.
> >>>>>
> >>>>> Unless the controller is actually incapable of doing non-SDCards
> >>>>>
> >>>>> But from the limited information I can find, this one should be able
> >>>>> to do both
> >>>>>
> >>>>
> >>>> It’s doable, but the bus width differs when this controller is used for
> >>>> eMMC, which is supported on the Mezz board. So, it’s cleaner to define
> >>>> only what’s needed for each specific usecase on the board.
> >>>
> >>> `git grep no-sdio arch/arm64/boot/dts/qcom/` shows that we have those
> >>> properties inside the board DT. I don't see a reason to deviate.
> >>
> >> Just to make sure we're clear
> >>
> >> I want the author to keep bus-width in SoC dt and move the other
> >> properties to the board dt
> > 
> > I think bus-width is also a property of the board. In the end, it's a
> > question of schematics whether we route 1 wire or all 4 wires. git-log
> > shows that bus-width is being sent in both files (and probalby we should
> > sort that out).
> 
> Actually this is the controller capability, so if it can do 8, it should
> be 8 and the MMC core will do whatever it pleases (the not-super-sure
> docs that I have say 8 for this platform)

Isn't it a physical width of the bus between the controller and the slot
or eMMC chip?

-- 
With best wishes
Dmitry

