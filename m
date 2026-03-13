Return-Path: <netdev+bounces-267529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLyyIgE7tGk4jQAAu9opvQ
	(envelope-from <netdev+bounces-267529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:27:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590A286FF2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D445D30C76CD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BF3B7B6E;
	Fri, 13 Mar 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jy3sPAiC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btevF08+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787A35E941
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419015; cv=none; b=lUCAeWctFjTysh2pgZSHEhiHDOwrXmjTs9D5xpeZWJS7MGemU4i2Q28YvwnTcBZhqXBzmy+3lXZhS1vNrn1njHvTL55ROLsknv0McOXhtMU+beCc3USBuQtwZBbQFwLkYK+MyGDD46muHzPQgRb0GFcZI6bUtkbWuRcQdbjlP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419015; c=relaxed/simple;
	bh=tHbcA0byu4Y8ZDGc88V2vxlZ2JIf5T/Ft1pA6qUaujo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q46ijArzrQ2Z7SUJRl960h/Pk3VdMG2jswsxqwdV5y8cxrks3uAEXBh9fV1qVOTiBqjO/vNXs5CFo7bRPzLcStA9//iJ6xSdQFS8+pe0/DnIaH1PJFzHnpRewNCDFM6dsXPvwPlLwgLOWte5XyagmtMg/pBSOvJT0xCLpAf0m8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jy3sPAiC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=btevF08+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DEbddE2262702
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RiOQjyp/BmFXVNg4p7wTJxHnEmuU0vEYGOEkg9dtv3Q=; b=jy3sPAiCmNubecU9
	N0Wn9/88GrssM/d6B9HmWrxnjI+leHxHMUBdBlhrCkHw01ZYon5u1NWkewLd07sP
	4cWTFCVajprXmwRTbzl43Bc+kcKME7XcehmbTTJvznfnBppSWYkSgwfBnbImk2E9
	IW78wId2OPUOUBE0c62i+2aoIlVWvBKwajP3TpF/Ol3YOUexAmhpJgXWr0tTlang
	FGlv6wlypM66WHxUBSYzwkCzTDC2gIt50B9YqCW3aDMAfpC7bjk/Ac2HOx9f+3bu
	hMzQ7KInu7NhSOtrx+mmkobU+XpkPTXXYrUaqanHcrNA6sAy2wdYJhST0DnLnFqz
	rRfQcw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4st2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:23:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7774be64so1318597885a.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773419012; x=1774023812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RiOQjyp/BmFXVNg4p7wTJxHnEmuU0vEYGOEkg9dtv3Q=;
        b=btevF08+xcNG3I/gqZzM1J97NLLgTiw9T8C7kVD4Nk3aC5XvLF7nz7HHUkR+in3eOX
         UpPw+y9PdoyZGvmS8cmgPRa2RiD6nDuF1nF/K3Qo7aPbk2zuR2m5ue8q40QH/WPbbeoC
         4GdG4/U0aYbbFPyq8MIuw+oDuhwc6l4mwOnqsd1noTTfvitHh2y/ejczS/nMftccJIZY
         VW3owJiGpB429O225s5X+0+G4xXId+twg0BPvEv/dAXQIesC1YF4pbbDIaFlYu/Qmuns
         bevRBbvKAlzpmlNauNPKyg6xfVd7NvosXzGbOpL8lBeCgV0ewjIWTBYNDqzOnl3vOpND
         S6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773419012; x=1774023812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiOQjyp/BmFXVNg4p7wTJxHnEmuU0vEYGOEkg9dtv3Q=;
        b=NkUMinvk8TYY/HlPjWHiI4S5HHuqyXuBYl1HdjS/SFAHM0tI6cXKFv5qvDj/xDDpKX
         MAyD/6yCBZIjpDGcNzkhxfWSGJ5WEEVAxya6wFuCoTkfPZHzlK8ozmyXdQwr++uHMNCp
         b+rULME1O6zWxJ8y94amAPuy6j7n/oh/l99FymBJvHh2l1z7edc5dqzUiITFIxvC0d3U
         YI0CvH1KHR6RvCaaiiH7Gqd9KbcEHWYT62sZgS9ZSYTbnvNKYvHsjIGdIQABHQ84t4IB
         QGMb3+fkNRESba44uEaqz0QqvVvn/EJNxZWCkz+UJNc1/U+wnE2qkP6Q9RE3aDFPr2yy
         gPfg==
X-Forwarded-Encrypted: i=1; AJvYcCVDjvraXQ+zQ3kzzripAoEc5JSHlUHh/sHpqRkpTyeYeDwypoIaBTbR8NxScopDcajmuyHJ7l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYGGxSZDQH67p6VCLDastvclLRdLC1eZotYB+YEgEGWC94hKy
	dZAmev47W6W1qwBAnNa/p2YwHJ4p+uYr8GFwtrWPMp6ZFq9YswWlHADgykMdcLZWX6l1xraVmpx
	9KCXr2c5PXhORB717c8ccSJWji4wd9mF3S4keLeD3wylZyZ5TV4/uoJ5/Xgw=
X-Gm-Gg: ATEYQzwvK6aIErv2MN0ZWjYH0Yih8VPUjOwmMbeVL/BrA/exZhV18QX1se8iU6bTNL5
	/32szPFKBEBU91WC6ddagv+a2jTmybudySkp0+D7XC5dxf9d1WRGw0nakvaOnmuguJI40xhCBza
	Bsmxgl7Jo+llsHg/dTuVNtM5YYgmEpCpMWsmiV1INwzX1kAoYi7YfA2tPnVbNMmgFz1uYoRumpY
	WBOvUpiSPfyEle+ZVSGkdpl+ga4TiEvOmfqofh6dCPC4IwWf99j6JF2cjuz3MaOomvWC8l4VNk8
	p1DXKn/UKb/sOUuSL5XwlctHOoPI+BouiOYcXy5O/dMVUnBAq6RE0OaR+K/k0XpnBCBW+Au/Jbm
	K5zLCEZfnM2rVgy81xE9wXFzVpKg2ltaKqS/xel8tZq3iKittDEIcxOWEXjIkKYUgm8fGEwTFkG
	kD2mCMUkKlBD0cgQvafk+rd3u4fVCLutSdvok=
X-Received: by 2002:a05:620a:4482:b0:8cd:97a7:a334 with SMTP id af79cd13be357-8cdb5a17627mr538296285a.4.1773419012276;
        Fri, 13 Mar 2026 09:23:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:8cd:97a7:a334 with SMTP id af79cd13be357-8cdb5a17627mr538290485a.4.1773419011740;
        Fri, 13 Mar 2026 09:23:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a74sm1632878e87.75.2026.03.13.09.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:23:30 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:23:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
        r.mereu@arduino.cc, m.facchin@arduino.cc, geert+renesas@glider.be,
        arnd@arndb.de, ebiggers@kernel.org, michal.simek@amd.com,
        luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add Arduino Monza (VENTUNO Q)
 board support
Message-ID: <exq6gd3hxf32frza57636a32asftp22ufledjo7qq5wow3lvym@2kyhucp5mqxq>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260313103824.2634519-7-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313103824.2634519-7-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 9v0ShWCWCFF_ZyjbnIZFzabOwr9TAl-p
X-Proofpoint-GUID: 9v0ShWCWCFF_ZyjbnIZFzabOwr9TAl-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMSBTYWx0ZWRfX1RGFx2nlyKgm
 LYbPRbQggnVhE0J/aQQwfvI+7PE3vSh+wKCC8jiCqh7bhU6ufClVQmpOCdPdkKtgTvyngxN46KQ
 KKViGHca/NO1c0DNvqgLxUK8nvmYQWYOFkncRMHkhlBLc0DYdVSBSbqPJddswfoDpY5fewNsGzE
 syP+Ujt9SLMi6oTTRGy1Kp6lCRFI/P0/BHi1EmlPBFbqXMV80XraYMX7UUqvmInS9SX5L9a5YfD
 mZUic4ochDLXMXZZRgNXqlowLoafawzrsxm8sN8iVIp5O1FGynXaJIOxsK2sMo7UULiyz4/rJ7d
 VPTLQIMWG15GYoS0d+T5sNGpauwQMuQ5iikTYDLXeHnmkblHAlVPUUzga1K/RvGUV3HX+BjlnkC
 OYCKdf6MXgwLcr2RfsIbRzl0EJUBoQ34PGmJjyrUYerOe5ww6KRNlXbGehQkOnRtchKS8yXjFA/
 20yq7Zi1cbLW4XSxEsA==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b43a05 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=rta_p3Q9v_S9YyuTENUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130131
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267529-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arduino.cc,glider.be,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,0.52.125.128:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,3c40000:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3590A286FF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:38:21AM +0000, Srinivas Kandagatla wrote:
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Add device tree support for the Arduino VENTUNO Q board,
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
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/monaco-arduino-monza.dts    | 466 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/monaco.dtsi          |  55 +++
>  3 files changed, 522 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> index 53cbc08d4df4..837adf569485 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> @@ -2885,6 +2885,61 @@ lpass_tlmm: pinctrl@3440000 {

NIt: this might have better be squashed into the patch adding LPI TLMM.

Nevertheless,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			gpio-ranges = <&lpass_tlmm 0 0 23>;
> +
> +			quad_mclk_active: quad-mclk-state {
> +				clk-pins {
> +					pins = "gpio5";
> +					function = "ext_mclk1_c";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +			};
> +
> +			quad_mi2s_active: quad-active-state {
> +				data-pins {
> +					pins = "gpio2", "gpio3";
> +					function = "qua_mi2s_data";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				sclk-pins {
> +					pins = "gpio0";
> +					function = "qua_mi2s_sclk";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				ws-pins {
> +					pins = "gpio1";
> +					function = "qua_mi2s_ws";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +			};
> +
> +			lpi_i2s4_active: lpi_i2s4-active-state {
> +				data0-pins {
> +					pins = "gpio17";
> +					function = "i2s4_data";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				clk-pins {
> +					pins = "gpio12";
> +					function = "i2s4_clk";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +
> +				ws-pins {
> +					pins = "gpio13";
> +					function = "i2s4_ws";
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +			};
>  		};
>  
>  		lpass_ag_noc: interconnect@3c40000 {
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

