Return-Path: <netdev+bounces-265992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIHAJeP2r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-265992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:48:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 195CD249A3E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16923117318
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191437AA8D;
	Tue, 10 Mar 2026 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSaoErtb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HwLeQscv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2633793B7
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139514; cv=none; b=SGRg60G9C1+NaoTbNm3wiBTplh07R/nNP08l7Ytq6SXWNxvXCxFaafOl9WxQ1T8am/+vzf2jxaGVyFHwBoAnu+b7/AVP3XqXLFl2cLuELGsFj2JNWSba+ZtDyEYlrWGzkxO3IsVzjZQTqeY93EIHp4bx1cCL856RbzT6Ifjx6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139514; c=relaxed/simple;
	bh=+Kx6CW/dov2b+Z2F57Pk0PKvcNAXcXGjfBQOBOoPYp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOSfwN9bNYbkSbbt9n/DyI7DB+sxSmNvcW//0V1xnAlIMEOsJhnDbE0xkcUMXiEXAKZPyN+TDkRWXJyKGnljADYtZJvlyOmQKwcPh3zc0cXZg2gzFW7MkUfjSw+xIX19AW1pzfxbxw8HlYxUbD/TbFruIPvzHyd4zp377HQapqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jSaoErtb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HwLeQscv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7wkd73125153
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IyCjKE1CRtdrkKn3m0S53RpV96KhLjntxQ+MS5fj5gc=; b=jSaoErtbTjuYJIe5
	CR4lHMT6cSUu6FsxeX8CyOYJjnenINbmSTnnuJQV0iQwgeKQK/cMFiPCDDtb22/z
	WnzwUVG/EGTRsm8sNg+S3nK69T8sI8VcXwnMgG6wvghFVsHgBAJEIQ9rOcVt/MVf
	SZD1xaKbq1aXpxlHGXdctAiXhKftgfh80RJ3llHFCOBW8qMSeacsrLRFkvdOaIcQ
	9avQFoehgyizDQFpo7c0CeMe5n+TN/RIJvx/onM98G4hFkUKvcDtxGyJfuKW6PKm
	+BGL0MfyWO/1G7G8N8rD/OROg7GmIcHZI6KXQYXWmrOWV1BB8WpIEBbRlNLK5jbf
	3UeenA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctfcj0pmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:45:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb50dfd542so865014485a.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773139511; x=1773744311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyCjKE1CRtdrkKn3m0S53RpV96KhLjntxQ+MS5fj5gc=;
        b=HwLeQscvpXfMXrqXv30WBP9Vneu7wllFr/++fOVjRnHhbgpvIX6t7T9a4MLvYZag4/
         LIgRtr8x+8+XMPPCVh08kpCOAx/NCNqqFLVBpcICz+8X8UnVDZkURhdwi80o7z6OI/dQ
         6GjmPepxP7T6VWJmqaDKogqBDeZYo2VO6ZUeQIoD5ooDJa7HcsaUagIqlrGmojYLkpYk
         s3X3lvYIHYFgf0Zv6muB5IFeyc43Js8WoHO17j1h0W1oTLdeNX/j4sr+cpn71sxWFg90
         YkrANsa1FZwQE6e8sv5HNzrQ/gShmyXwoSNkAOpW9FWopnizZalm+cHzUzvj1REaslRy
         ezaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139511; x=1773744311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyCjKE1CRtdrkKn3m0S53RpV96KhLjntxQ+MS5fj5gc=;
        b=QkR3IU0b8fOzrDUhcmZ2nR10BJiLO71ywWJu6GlZOy88D/8peDHBNf4tEaNu1hNtgJ
         3H5VYgVOXdEPFXWtC62I0tbfFHq2XbY9UfUAbOi2ckGORKulB7Ht5rn+qhBZNs1ZVjv8
         oJzimAvpxiq1TxID4LBqkci62Pj791h0ix0MAj6jSML9RsgHquks2YiZcjqL3Njk1uRv
         adtqrtR0mtcdvr1aa/DntgZ7o6AOMj5/DHL5gMNGEGL5sG5gZ8PcUaZVqBq5u6WLTkz1
         nC8NyI+4SVcfHFMlMGBUTMSaIPk1efntbPQDZwZwT36MXkEVd2IHLD4/z3wT1eDAwF3p
         lqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjQTrI6zLzkrKGdt2SAwV0NXkPSWLBjGah0eJqjGcKhgyc+Rzj24FqzsDBsMgllV4IkWPMpC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0A6w+EJFe6gnkwOLg9ajl/Olr72nmooeLNWTvPX1gAIPqs8b
	X/PR/+oCuzPt1dHtUT8Srm4tA1WXEWLllGbf0dVsssv4IJ+rHpFKfvajnWQRaZVASc6OYoOUU4O
	B2hRpiDxKWSuOtPNt/D4ZNyU5xQqErvuK5kBpoj5jBOTN2Ylg9QO/s9zP8g8=
X-Gm-Gg: ATEYQzyPcR/v1mDXXALssswYj/b2iFztTvluuZ9lgSaB9q3Od6BriErinwpmdxrL6zt
	oOSQAxoAPU5Pla4NaVTTdtXrOzY0Yny2NfSXGFZvDSvTtYhaa7iLBgN3tuT/Gg9hYcwKkTKsCAM
	mC0WquG7p6riAg6gYGrGlTGb2vhmVirMP4uSYva2uWYP+1B/oDtiFlQg1nUQqb+vmW8t8JbnWJo
	aMWs8DFfNN9tuOPC7Ts92yn26xDf35OYlSKUgLzi0xLsi/JEZATXMv6nwEjTRVa13UsJkbTx97R
	GgS4bSiSaLrernwOpnQPdoW/DLhSdvncCFZ6qzZoREdr+dOkLFEk3noKAadGEbtsEaVxje+W8tS
	xj1jisJoDJ/nYIVhV9ahZWvmvPK3cQB8lGvlnRh71+Kdx3r+/eO1089k+pcimD1nd7D+uLRlfEi
	HDJ0c=
X-Received: by 2002:a05:620a:28d0:b0:8cd:9665:9f09 with SMTP id af79cd13be357-8cd9665a51bmr126363285a.4.1773139511343;
        Tue, 10 Mar 2026 03:45:11 -0700 (PDT)
X-Received: by 2002:a05:620a:28d0:b0:8cd:9665:9f09 with SMTP id af79cd13be357-8cd9665a51bmr126356985a.4.1773139510830;
        Tue, 10 Mar 2026 03:45:10 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a559b777sm4060854a12.27.2026.03.10.03.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:45:09 -0700 (PDT)
Message-ID: <3dccfa39-9562-448b-a982-447cfa7d5a5f@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:45:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: monaco-arduino-monza: Add sound
 node
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-7-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260309152420.1404349-7-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7fWAuYi c=1 sm=1 tr=0 ts=69aff638 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=PSYRucXItuZ608vo30QA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 6lHirZZ_jnNe6cKa4ZnbeqrQ7Ku9WwoW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MiBTYWx0ZWRfXyfmhZPx1t51h
 j0tpjfiRhsoKdsukq+ze1wW4/s2r252N12e/fn+s0i0/He+dZNApanwlbpGvDWClmvS6boHPPGe
 4hvmNt3WC5EMXug1vpz2chQ1R70DcZaFUPAcYwU6zxwcHpi0dWoy0lKF7j32qWQfhmgiVtHFTmY
 j/46NdPfP74GodS2k76EMGtZH8Y2wcUQ0RZ9fXJPExVmlUSBVXXjSYBT6gDxz/517Fd1tF1yMdH
 KKghcb/79oqDNQmOZCWQJ5SOUjz3y/mkmRxJU8ETf6dftepQVN2mfEf3eRA//hMm19WuhQFREk6
 hOnFfYLB8MFoTwFlvvuTabEYC5psrxsgVlOUZBwrl2lENcEvF369fz5rQDLSgLPTztDFqbRIEav
 IOd3AakxlpDxrGkv8+7mgQqHbfI0+JY+os01Wcc3uYSX+4Km/xxX11oKBTLKWCKtCBXU/0y/KM9
 SIppriRK4s49sWn/mFw==
X-Proofpoint-ORIG-GUID: 6lHirZZ_jnNe6cKa4ZnbeqrQ7Ku9WwoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100092
X-Rspamd-Queue-Id: 195CD249A3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	TAGGED_FROM(0.00)[bounces-265992-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/26 4:24 PM, Srinivas Kandagatla wrote:
> Add audio support for Arduino VENTUNOQ board, which has Headset, Mic, Ear
> and Lineout connected to external Maxim max98091 codec, HDMI audio
> via ADV7535 dsi-hdmi bridge.
> 
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  .../boot/dts/qcom/monaco-arduino-monza.dts    | 66 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/monaco.dtsi          | 55 ++++++++++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> index b6db2a7151f1..be62b3dabbca 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -80,6 +80,72 @@ hdmi_connector_in: endpoint {
>  		};
>  	};
>  
> +	sound {
> +		compatible = "qcom,qcs8275-sndcard";
> +		model = "arduino-monza";
> +		audio-routing = "IN12",  "Headset Mic12",
> +				"Headset Mic12",  "MICBIAS",
> +				"IN56",  "Headset Mic56",
> +				"Headset Mic56",  "MICBIAS",
> +				"MIC1",  "MICBIAS",
> +				"Headphone",  "HPL",
> +				"Headphone",  "HPR",
> +				"Receiver",  "RCVL",
> +				"Receiver",  "RCVR",
> +				"Speaker",  "SPKL",
> +				"Speaker",  "SPKR";

All lines have a double-space

other than that

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

