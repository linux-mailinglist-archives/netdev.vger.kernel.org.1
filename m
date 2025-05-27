Return-Path: <netdev+bounces-193653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D9AC4FE2
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0F33B1A9E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C2E2749C7;
	Tue, 27 May 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oftfNIZy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA49272E6E
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352866; cv=none; b=QFVL30i2Jr7MiCzQBTcgBpHuuvYmaPI8OGg1Xh0EDhRsFLBXHT7UZ8TEjjkh4bZvL8//n0qzsrK8DGAFE0+s9Rpl969QunHHYw3HSk9TX0fxgyR/aOyn3sQuTRntFxzbDJO2kRymM5wBVG8t7YG96y0DWiSREZywVoGkBtNRRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352866; c=relaxed/simple;
	bh=d/P02J9qQY8iTl3rVzuh5p3XJF7As7wmADUufJt0/BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbpmY9/hU/4dJRk3ZNZw1VuxA2IPWf7bnHQsw28i7U0jIHOZPeKEEiw5Me1E6KUG1S01duVPGDyBoiBZl0jkOJqdous09+9xmaVvN6yP7zsV4PExY6lfrn/gbn6aE21u9cfcPVEjYaRSXgFeRE5Xgit6OwGAR7Gdb3gRGBppBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oftfNIZy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RC7sfa017822
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zj3vrTg/vim0PVZvflmCqYbXIcZKAQ+i8s0YX2bmBXY=; b=oftfNIZy+HwWfIMr
	iPJf78k5r2/5aEbnrGhi8KoGT3BZ3gDranc8kl0eM4fgGu4OuAb6eZCZ8d7w9eeo
	qUNKsWhRZXYG4ftW0WWLkYO+ButPV6dw0JF5txNAbmGShK241YamnRydwsBZSFYE
	K6rLjXNfWJRV96gr2VFZSd3ZVhrQDIRet/l1oo0ijtV4HF04H4utMnOz5NdNbk2A
	ZO2J5CosmL+ay+/PTPH8aFmWtjPWxjwNIl3etmbTriqpOio/KsJjt9L4msLXwQAu
	v3dXMYGAS7hbZ2nOvfLpBMfFcD7LULOwcvs17Yv0mConBHuAKeq5acKhQGQZFIIg
	Lg4xrA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u66wf6xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:34:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c547ab8273so32126585a.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352862; x=1748957662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj3vrTg/vim0PVZvflmCqYbXIcZKAQ+i8s0YX2bmBXY=;
        b=JZTW+bL3zdBs5WK/aIOa0EkSuCas30mSw1UWcoUJKyBABkv2jzCWCYJOERBRjMWMUv
         bYUm+h8Mua18+E3jfmfn6qoF1kndU4kS3v8Sj5p2TTe7Otg3A170bzXsIRTU56jDc/de
         q5RAs90SwQ3rIrQB1O+gJlbC7sDHlOKwJ+P5YkftkeasBXxZMIL7RO2gMztLeXEEBt0p
         axdiAXoL2rEH2ZsyWo2189fah5QKoTLmhIunOyZAbNZKavStjtF+/OhIqmgds+JPI/UG
         Xq5wpi0IAawoBine466/YzOJFRpnniSwduRMc2xRn+1+Co0gnuNtVNJr2TousVhx/pJL
         r/Gg==
X-Gm-Message-State: AOJu0YxGv1NnNd1blPhXUQfcUIpWXNrFW4b0VYEzqynbN/ZkuCJz28FD
	oYJAEFasONHyf+4DDWXzGEiwkdwL2SZ56upup0wGLbVpSLVhgQi33iMqKP161fE9NtVt/0doQEi
	Hvum0MLcLOvGtw4lt8VXJa0jisHZD/ij9w8odcQeaII3zwmtM2KCqSxRFWCo=
X-Gm-Gg: ASbGncstsrQ/gM1tHViHvc9cRueN/yMqkbI3QCBw+ENPWeimN/bw0qf3aIq795c3LQI
	tXXEq3eFv9B0lCQxOZc0f1+ex4ALmqHfK4n7PXAPbQtul5hVlOR6vV1xeVTvkeQtJ14OQNHsSkS
	WI5u2KpzBmEdfv0Mh5gyPOAsK3CFWJM5+k2sMWkLbw1CF7fP+FCgGV9ggszlR9QnU1NCYp1B75s
	yEAuvKNTgn20jU+nIB5IiRPQBDbTp42eHEs5cCNgA2w/dUXifCFgkh5rydfG7CEoojv8yVCGDXj
	B1lssH2LWXpBuFfR+5u8GjTRUoJNE6EdnxA9yZye7zkh3nJFrJlL3KS7uGfYjnlI2A==
X-Received: by 2002:a05:620a:bcc:b0:7ca:d396:11af with SMTP id af79cd13be357-7ceecc33efamr674542785a.15.1748352862480;
        Tue, 27 May 2025 06:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjlX2yUH3BsOWQUseqYtk4hJzkMKzeOB9JG5Z8E4YKWevQ8VORYoyV+OSVUqExMtXpm87OVg==
X-Received: by 2002:a05:620a:bcc:b0:7ca:d396:11af with SMTP id af79cd13be357-7ceecc33efamr674540585a.15.1748352862039;
        Tue, 27 May 2025 06:34:22 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad888f734f5sm152162266b.84.2025.05.27.06.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 06:34:21 -0700 (PDT)
Message-ID: <f2732e5a-7ba9-4ed3-8d33-bd2b996f9a1d@oss.qualcomm.com>
Date: Tue, 27 May 2025 15:34:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq5018: Add GE PHY to internal
 mdio bus
To: george.moussalem@outlook.com, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20250525-ipq5018-ge-phy-v1-0-ddab8854e253@outlook.com>
 <20250525-ipq5018-ge-phy-v1-5-ddab8854e253@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250525-ipq5018-ge-phy-v1-5-ddab8854e253@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aYJhnQot c=1 sm=1 tr=0 ts=6835bf5f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8
 a=KVjQAK92ZotTnYaee5gA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: DA4Z8pyiP8Dt_p0-9YFVsE_FMl4sVBDI
X-Proofpoint-GUID: DA4Z8pyiP8Dt_p0-9YFVsE_FMl4sVBDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDExMCBTYWx0ZWRfX3ks+wLQjXaIr
 y6Dha5TUwBHw89Gx+2KjKm0tkhVEYBRhrxrS/CnTO99qqeKMbZmhlit7uE1mygrbJVIODGUCx/E
 1qwxzvqnVmq4iNF6VNdGbhGHzuyderX2WM16a4E6bVy39Su/XxLhNNcsKB6V87K8Caa09zMRT40
 7jNjg3vCZrQTbRLVolrKO8vzcsqVRC8VCGWw0K1BSg2upS2aVg9wkbxmCW+SwqCaJd1MW7hWj7H
 j/xU8eb38uSZiBXEHAUDCrJg1xwZ0BBnxF7zJnpqNMQNhssI7hdgS1YoSZK6xl/mPrgGHXb5fRU
 hRM0N5+k0ibIZOl7VqKJexLXufsTgCBaw5uy3cgD+3671B+uCxP/GQjL5JYyyG8sCKbFFE2/WXA
 SeRPxs55cF3Rm4vjywWhoOtWQy76sT7Pm79+VocBJocoH2mKBs0XIvZxQn3kOaZEGdecotoN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270110

On 5/25/25 7:56 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The IPQ5018 SoC contains an internal GE PHY, always at phy address 7.
> As such, let's add the GE PHY node to the SoC dtsi.
> 
> In addition, the GE PHY outputs both the RX and TX clocks to the GCC
> which gate controls them and routes them back to the PHY itself.
> So let's create two DT fixed clocks and register them in the GCC node.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 03ebc3e305b267c98a034c41ce47a39269afce75..ff2de44f9b85993fb2d426f85676f7d54c5cf637 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -16,6 +16,18 @@ / {
>  	#size-cells = <2>;
>  
>  	clocks {
> +		gephy_rx_clk: gephy-rx-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <125000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		gephy_tx_clk: gephy-tx-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <125000000>;
> +			#clock-cells = <0>;
> +		};
> +
>  		sleep_clk: sleep-clk {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> @@ -192,6 +204,17 @@ mdio0: mdio@88000 {
>  			clock-names = "gcc_mdio_ahb_clk";
>  
>  			status = "disabled";
> +
> +			ge_phy: ethernet-phy@7 {

drop the label unless it needs to be passed somewhere

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

