Return-Path: <netdev+bounces-281829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WABYO8mg8GnrWQEAu9opvQ
	(envelope-from <netdev+bounces-281829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:58:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995C4484656
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDC4730358EC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A153F786B;
	Tue, 28 Apr 2026 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BHdeZn1Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BHgtB7Vr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D03F0A86
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777377306; cv=none; b=koOb8LYfRpkF3pRIW+fOmZ6OuPUnAl5RdXKn1wiBWnOjfbPZ3XQ1j1SVU49g+hOv5qXy3AOe+/9kokCTkendpYxkmQWyfc1RwBYgEIf6ErAKS5UjWI6PwORBsgReDUYL+mOoiovlwLqYciBP5AJ1XYLHvzNKZHFOSH+mnleNsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777377306; c=relaxed/simple;
	bh=5dJa+tGJRSBuI13nLl/GYz9NPVhY7r13IyAts1jqOo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxlMSy3+wZmzaqtfXWQbW57nMsJ1xEGUy6wr/uT95hLciz1oZMlk4I5YQHikCdCQUc4WWC+GozwZpHPBvyxouZbumeK5iEAfn4CK5YDxVHXmo8fHOgRjr/itrb/bT8t5B81xtYoYkrhf/c1KKpxRfeaGrjdgu5NaFXIChlNgr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BHdeZn1Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BHgtB7Vr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA3uBv3274994
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H09Zk0X4k8B+gAnXTVvs56d36dwNpYdV/aDUCW9XEzs=; b=BHdeZn1ZlOfzK2Lq
	SymdPaR0lAPQRP7+oYpY2dblSF9gH6++mORqqgfyi7xAyKsJrU7uOrOFXrIT9AzX
	7dfWAtquJQuex+Dv7dJdKnwcPRbcB7T4uVSQsRojzOZlX5cAsxYD8RLiELPegq6R
	LPY3afP2g6hYiTxteuV9SBa0VW2PFCdF+UUX59NMZF26Cq7pBT8KPmIAbzJsNbVs
	h0bvndziGPECkRZYIwYei7SCKnwlgwLrywv0LmiDycMQtR/jkt8M8+cQdL5+DT+v
	xf5MyRA89TxODVdxPceMg8lBZKZFmSCL8N6BF1Ogn3EKpNKl9I3nznDDEDuSFV2P
	kKnIAQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtttjgc71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:55:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a90510a6d1so93678915ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777377302; x=1777982102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H09Zk0X4k8B+gAnXTVvs56d36dwNpYdV/aDUCW9XEzs=;
        b=BHgtB7VrdeHPtevg6jFjYkwt9C/TVY9wWPgM4xQVHrz3y7FI1PLsA7BoHxtkac/gPZ
         AoEsXxpsz/hI2cAckd1X0EM/boINe3zrMridvSRNZwluSHOHVwFlFlaTGl89Pm3bIU5I
         IpSt+fGTIanfVGd/DXJHVPcJ9iVK4dn21yvgczudilnMPnjabkNhrPkKwNopGWBFgD20
         j86qrlu+aVzH7UxnetGskCzFEjPYQq3SZAn8y0UlbE7gkC1J1D57h28zBsWExsm0eijV
         9pdyZ7s0x2DGhcQ2UIr/Evy+CfWzCB3d5sxVbTesSerDTOnlE8+SW78Wc5sAM1PoUrRD
         aYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777377302; x=1777982102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H09Zk0X4k8B+gAnXTVvs56d36dwNpYdV/aDUCW9XEzs=;
        b=K24XZRC0eL40R+paikW7ccCCgKuQ/lT1mnvpbVe4Or/L/3wIrWvS+EcS+NltVkRFzb
         lekSdvj238gTTuZOzRh5kxIFjCa26CxZDQDtklLVNJTKB4AOYcC8DTd+L7w66WXO6USY
         oRIRtlfQWmDrvc4ekldzZXqzvM8mHqQZoBX1Bc3bQbKo5IMYj7E4hQrKR/29Rl8NYbPF
         KaV/n8mzuXwv2W6/VGhRuw/fq/HCyf91rDzayvba1uTPDzr4JIrmEYCW3xM8Jih4Op6y
         wngkW3eE8t+fUO+L0UU+xYZ1pffW9U/SBoITh9nTLyIebp48C3w+iyHg+4nCFLNoE32F
         XN/w==
X-Forwarded-Encrypted: i=1; AFNElJ+VjHB71hOyljxpnLPjGY6J3uGhJ3h0PmVRdf68d197CcYMAD+gciSn1zrD+opoERBkf0vi3js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4YoOt7ZaLVnk8eJ2muQctr2ByfDXwHpJR/yuvA5x7WHy45wl
	81YcPsI6pZrYHV9KGCcyDUzgDruOPhF7U24a/DcIwhDlCyAw90h9anwSHPDqm3PQe7dRLWFfhoO
	BlOv2iZXIuJpXwY0b1gR9mXBR8eJolCYLkVhI0iJhfwARsJrWO5B3EpTT0AKdxGBVOh0=
X-Gm-Gg: AeBDievUDfHlIyYujph2Y7nrp43wbVItdqlJP/CPpBhZ4ClCOre5jVZeSjeDYh3kG27
	aqAjTJv3KoCfBUZ3wgDdPck55+aC9kFYFimh6NphPtxeIGisUinfpGdcuypxsp1rQ7TsFFAlngv
	qpDk5ZvgI8qZRE9P6tRHuVgk10Ph7T9cUK1zdNTxBBurzNatwm7cZFf3uen7W2eDnFFIFvtI/Sw
	OcrLzEMePJgloxrOavh59nqEQnbd9TbCxD5A9CdRR4912uYkePSQEhY6BihQ8FAXQz5V2yWcnmX
	u7FLnh5l533b3AZxBn29w0mkThDENmXgIpHxys0ilYOIEXx8TcQ5S/vQ2uTZ6rtnc5XbcCFbE/s
	100aHfWP3G9eJNg2xks2CPVqE8JCQvYiuEnLVo9Ri97r0Fsz5v9JXWXoMz4VfdjwSPriSXT/3dv
	3qXC9zRwb7+Dko29Arw01jNKCgEbT68aQ0DbEg9NmTEZQdpVQCIr8=
X-Received: by 2002:a17:903:2ec3:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2b97bd6b567mr24234835ad.8.1777377302222;
        Tue, 28 Apr 2026 04:55:02 -0700 (PDT)
X-Received: by 2002:a17:903:2ec3:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2b97bd6b567mr24234515ad.8.1777377301641;
        Tue, 28 Apr 2026 04:55:01 -0700 (PDT)
Received: from [10.190.200.117] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac7b35fsm24140165ad.46.2026.04.28.04.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 04:55:01 -0700 (PDT)
Message-ID: <9dd3aa94-0306-47ab-8bc8-ec5ac4219f31@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 17:24:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: add the TLMM driver for the Nord
 platforms
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260427-nord-tlmm-v2-0-ade8e0f3d803@oss.qualcomm.com>
 <20260427-nord-tlmm-v2-2-ade8e0f3d803@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260427-nord-tlmm-v2-2-ade8e0f3d803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwOSBTYWx0ZWRfX6tW0w25PGp8N
 kh9YN6h67DcjijGsV3N0arIo2/LzNUuHEE5Zf+/fuq7fClsVSSiLmLMweEvMcMwcMwVQTjT/b4d
 +M3hYrviWUfY+E6qdlQYmTP6bc4rfadSBq7O/7HdwJGrIIiJYry7u0vArII4xjXPyY7bJq+SGa+
 AwITSGtbEzIJosgjysWJFU0IxB5V+XlXSAbCGglzFHgcxoOOmlHt/BW9PT0n98fuJIkd/Tpb0YM
 sbzP4sxzk2QTB6ywWQYpSxWUEmIFHFsPSLtIhC4d8qGf5p3naEjw7/c0CilDC8USecvcor6hMS9
 dRHHX82VWsw1sXNMiMT+zMP3KMieQGTS51RI9EV2N7mjtzSdlJ9ep16TPg9cz/F9s6Cc8j32f9g
 ZICh45JvXHskQqbAe+T82lbv3g3X8Vu6nfNyxlgi9cdQNpVSA1MWEP451M4fA5xm30OPK0I9fhm
 GYhK1fLBNRm+FCXRx5Q==
X-Authority-Analysis: v=2.4 cv=TZKmcxQh c=1 sm=1 tr=0 ts=69f0a017 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LJYSW8tzm8uOt92QnF4A:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: nQimZtN61Vw-fsGyq5m53Uwge6LpuOzD
X-Proofpoint-ORIG-GUID: nQimZtN61Vw-fsGyq5m53Uwge6LpuOzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280109
X-Rspamd-Queue-Id: 995C4484656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281829-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,arndb.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.patil@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/27/2026 7:30 PM, Bartosz Golaszewski wrote:
> Add support for the TLMM controller on the Qualcomm Nord platform.
> 
> Co-developed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/pinctrl/qcom/Kconfig.msm    |    7 +
>  drivers/pinctrl/qcom/Makefile       |    1 +
>  drivers/pinctrl/qcom/pinctrl-nord.c | 2843 +++++++++++++++++++++++++++++++++++
>  3 files changed, 2851 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig.msm b/drivers/pinctrl/qcom/Kconfig.msm
> index 836cdeca1006ff7ad5030ac5c537d775d3f0261b..67124ac607baa0f317e0713760a0a2fefba1e2de 100644
> --- a/drivers/pinctrl/qcom/Kconfig.msm
> +++ b/drivers/pinctrl/qcom/Kconfig.msm
> @@ -229,6 +229,13 @@ config PINCTRL_MSM8998
>  	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>  	  Qualcomm TLMM block found in the Qualcomm MSM8998 platform.
>  
> +config PINCTRL_NORD
> +	tristate "Qualcomm Technologies Inc NORD (SA8797p) pin controller driver"
> +	depends on ARM64 || COMPILE_TEST

+ default ARCH_QCOM
According to Krzysztof's patch,
https://lore.kernel.org/all/20260425155505.83688-2-krzysztof.kozlowski@oss.qualcomm.com/

> +	help
> +	  This is the pinctrl, pinmux and pinconf driver for the Qualcomm
> +	  TLMM block found on the Qualcomm NORD platforms.
> +
>  config PINCTRL_QCM2290
>  	tristate "Qualcomm QCM2290 pin controller driver"
>  	depends on ARM64 || COMPILE_TEST




