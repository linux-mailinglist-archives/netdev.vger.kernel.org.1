Return-Path: <netdev+bounces-265991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE1WDp72r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-265991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:46:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7E249996
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85065315A2C5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF262373BE7;
	Tue, 10 Mar 2026 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkN0i8J1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dzbG6see"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3E371D0A
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139444; cv=none; b=Yd8FO0zZS184b3NZl2ogxQNxX8eE+TBlHOZU9hXTnYyQn4gGqBzGqkPGfakFuxN5yCAMrTp9WaNM/MjCq3d1nFQu/zuW7uJ1wFx57BY/bsP72AwATlRo2y+sJg0Bar8bZReuip8Bcvv5/i6Ix1lL4aC1o+vurpfXA6wS4IuuDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139444; c=relaxed/simple;
	bh=T+ZNuvPfZ1ijUPZUkzbUUMd0snmJEpXCJTKT8en2UNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+oj6jcsqEvEBm1XfsYNCsa8+jTkQF79akjC72w7jcWOq4L5N0MN2LV3whALlhkItHom3EonailT/6j/BbhllNHM9IU/EtqlvpVWj251LLI7yLUOciPne3NT7CjtQH1gTn1Rmq0Uu0Ue4H+E9fGGVb5XXIQt7+jbLUL30B1ET6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NkN0i8J1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dzbG6see; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9LBU12460640
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DOiATxKxwd5pn0Fw/t5rqGl+XclLEWRPBZaWkoAss0E=; b=NkN0i8J1rdVyS0Hf
	Vb7EY8IQLn6bmGTr4ZRDA0FpM+ZLPpIa3R4KD7JOLPcUNslMq6wLqhuPHvBHzOiS
	DjGIpcZ5powOKyoDKQ1lkH9CdkYbu+obXRtu5fl1R3LctmmfVd9zeI2cYZSM16fS
	HnXDmyiwpPRYLipURPyeqZybayxAc6dDboO+kfm/PS3peLDYcOI1Qp7T1QjSLis6
	PdfH9JIM8/CqpK80fOGcdGeRkn+t7cyN8vMWzJmgDv3v6kM4BwA4aJTjJWFJx3um
	87xYWSLQJ2O4YED0JJzZvvlI4vuTon3Uxqf2wDpkr+TELI/3pmeoCJgjKtQQCYuA
	eqL12g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv1bwf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:44:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89a09f050feso4395286d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773139441; x=1773744241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOiATxKxwd5pn0Fw/t5rqGl+XclLEWRPBZaWkoAss0E=;
        b=dzbG6seeCT8+kgaaWPcZWoVzThcVVIen50gSzmEGWSge+D//Xi+OLaHEAeKnjzrqfU
         fyrgjlOcVF9ae+zhEYMyapBjq+623B+JH30bIWviZm0dGxYcGq/sEHMSB32b1C182pqc
         e80Koyc3vgxc0Y7rsngL3yEDtihY0k6MAmS1jdebLC6rQx7O+YHUc7eYYJHyQKqB+t1z
         N+/27VmvsJ5DdmNri2zlJOyUkMSvI1/jFSYj/VPYjZVfIWAs4AYCRQD/Q0r+7EnLBioY
         W6NF5tVIIbWaO1ysYJCLWe3V4SUrsVkGTdnKYS4kvx1W7Z0tTX0HAY+uCM0m27fo4PT2
         EvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139441; x=1773744241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOiATxKxwd5pn0Fw/t5rqGl+XclLEWRPBZaWkoAss0E=;
        b=OHVSAQ7sW0gdUgTtGriyem1oEERwXbkPpAbLnAfehp7KrNC6aW/qk6Fjxb0ekCyQei
         7LBVHk/MYsdfZ5uzHJRoarV8qmd7t0DwC+jNPv95II46qzFJ3vZilSlRc4XEM1yksPrg
         E1SVRHOYMIjNrCMekOjtUKRnsLc1peW3/SR4Qxn7tZO7EqiYNG5+DTEk+D2BpXwJsO2x
         6zhXpoLsdR0zf5p1Vhw60HyDupuzXazRHMR1XWbPmEejDvog0nTZHebxpZg/glXzvrDi
         ERY75m6e/REy0N/qHnBGDj1th6DFkhV8iRYCwOk3XkSWaHYf2qFR3jGvAq7X/48G4iZ7
         45og==
X-Forwarded-Encrypted: i=1; AJvYcCXJSUXiae/lKmqcqGKgois14butGBts6fzXzoRniYlAtdka7mbS3PYDCYahfGOXCH1LUtHDW5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Lx5wTdz6McS7soHobF+U87CiEsnZr3km+H7puVUvUULAUtS3
	i/ba9+bvdPBBlWA2R59tK+N8ibuZx5Mlri4HAoRQBSAsm7oEm34d0f0cqHcA+XG4aBA5eeQyYjl
	rU15tujgX4ITuq3ndLx3yLmPH8BcZPYwcy/Juc/eTbSRiiDQ8qFiprX/pOVg=
X-Gm-Gg: ATEYQzzPPCxu1VHYosE8B6rdzWHtWUp4Wj/rNpPUw+R0GoZYl05GpOOLeQGvKRRnAxF
	40PjXHuD/wJfhMspowHhEFzhPRneE4BWS7rJ8YLCNRrZHldlHNRSYDkK1zLxz3mlppNjVtT+g3V
	RaZNt39KhZUGsEfJC9YO9c7l5hwVRo8s6GRs2tXLIL0FFZIU8299QaPiXtUNZUga7lfxF7Ahkn5
	H7gJiQFnrBh/VOlBDceYhaD+//6SU1J2xHMGfoACeykk3aUTGd4WxxVMazIltayP/XO4/kFpTA3
	T3diO0uOKZN5YLphn6hA+h0Tl8W9zN+9tHIxDEJuzDcs+r+x1t5aZUHmG8vk+iJgVe3VczAsb9v
	WB1djwhbFpEqHZXPCleSnPVQnmBRrDgSV13/z0HUQKUFOb6vF4WavWDEIl3LHVdtb+usO/mT9fm
	9RXCI=
X-Received: by 2002:a05:620a:468d:b0:8cd:923a:87a8 with SMTP id af79cd13be357-8cd923a8cdemr368967985a.1.1773139441130;
        Tue, 10 Mar 2026 03:44:01 -0700 (PDT)
X-Received: by 2002:a05:620a:468d:b0:8cd:923a:87a8 with SMTP id af79cd13be357-8cd923a8cdemr368964385a.1.1773139440618;
        Tue, 10 Mar 2026 03:44:00 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b943cca3c0asm415890766b.34.2026.03.10.03.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:43:59 -0700 (PDT)
Message-ID: <288bf404-17fe-4efe-b256-2ef76b543658@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:43:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arm64: dts: qcom: Add Arduino Monza (VENTUNOQ) board
 support
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-5-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260309152420.1404349-5-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D7BE9ogZpW4MTD4_gwOs_OLs8Ji4OhUA
X-Proofpoint-ORIG-GUID: D7BE9ogZpW4MTD4_gwOs_OLs8Ji4OhUA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MiBTYWx0ZWRfX0qb3BpcuMr74
 xlbBgizl+1MkAXb+1xZQvHX5CDP4dvKELzUnSbSjnk2jIsm/EC5NIe1MZj7YNHDqFSeQRHcldai
 GteRgXMuxflXxjaH/AEegoJM31N6LygSPlpbSwG2WIeuhfDC8XIYyGi5WafkiqfG9Nk2BwKtcXG
 eWccAHt2Ac97HRYC/1C30BMGXe+B1F4KFSnPNR57skhB3+WQXZNw9eBbu4s4BGqABdrdISedw9n
 jPsNXcNkCaUHCAXn9gqLqVcXixthaEky3Yk6TSA4HpSiQ3tsTYVwKFys09va4nbS6R+940rp0Ko
 ai0eYTccWZ+aMB9XRlDGH/LpYLsTwWR5p4qgTHTFg2n6rBb7RVzQ0/BMQIcH1dZ1qDEPTIpucQm
 Z3otWkQ/CjIyk9eo5QKn59dAwfJFkKOnGRsjl5SeOIxFh9DZ2MIvBMlnsWw3nitAKd0yVpW9kTF
 mKfXoc9qS+Ylj//ubwg==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69aff5f2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rta_p3Q9v_S9YyuTENUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100092
X-Rspamd-Queue-Id: 8CE7E249996
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	TAGGED_FROM(0.00)[bounces-265991-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1c:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Add device tree support for the Arduino VENTUNOQ board,
> based on the Qualcomm QCS8300 (Monaco) SoC.
> 
> The board features a Qualcomm Monza SoM and integrates various
> peripherals, including:
> - USB Type‑C connector with dual‑role support
> - ADV7535 DSI‑to‑HDMI bridge
> - MAX98091 audio codec
> - 2.5G Ethernet PHY (HSGMII)
> - PCIe0 (to onboard WiFi chipset and USB bridge)
> - PCIe1 (to M2/nvme)
> - Button (via GPIO‑keys)
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

[...]

> +&ethernet0 {

+Andrew, could you please take a look?

Konrad

> +	phy-mode = "2500base-x";
> +	phy-handle = <&hsgmii_phy0>;
> +
> +	pinctrl-0 = <&ethernet0_default>;
> +	pinctrl-names = "default";
> +
> +	snps,mtl-rx-config = <&mtl_rx_setup>;
> +	snps,mtl-tx-config = <&mtl_tx_setup>;
> +
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hsgmii_phy0: ethernet-phy@1c {
> +			compatible = "ethernet-phy-id004d.d101";
> +			reg = <0x1c>;
> +			reset-gpios = <&tlmm 50 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <11000>;
> +			reset-deassert-us = <70000>;
> +		};
> +	};
> +
> +	mtl_rx_setup: rx-queues-config {
> +		snps,rx-queues-to-use = <4>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x0>;
> +			snps,route-up;
> +			snps,priority = <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x1>;
> +			snps,route-ptp;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x2>;
> +			snps,route-avcp;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x3>;
> +			snps,priority = <0xc>;
> +		};
> +	};
> +
> +	mtl_tx_setup: tx-queues-config {
> +		snps,tx-queues-to-use = <4>;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +	};
> +};



