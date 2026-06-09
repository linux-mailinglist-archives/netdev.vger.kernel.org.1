Return-Path: <netdev+bounces-297048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZVlUIEYUKGpR9gIAu9opvQ
	(envelope-from <netdev+bounces-297048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:25:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DD66085C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:25:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Eropqvh7;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Gx3FdBXC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297048-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297048-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E53930434F0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA929BDBF;
	Tue,  9 Jun 2026 13:24:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4972C3257
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:24:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011480; cv=none; b=kTOEBg4Edx8YsO2M+kXz2skrkLfqdqS3a4d7TzzPvtPRnlh2/eIklZmd5zlMXEsmRPw4MfUy/ambPEW/SzW7raQ1cuB0KVVcXl9dyJbHIeTCZyeTXNgw6kPjT5vpH2Fz0phFtqj1lgg0AXH1dKEZFYsAb3HlSMApYFX+TLC7nsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011480; c=relaxed/simple;
	bh=mNrOaTE0g5btHJAkH9znuBBNh9gkw5ZF+RBUq3Ym20Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8+wf3BHwwJrVnUvAhMG7hEy0hiFkl32Xq5d0xUoV1h4V9GDpjAMrGNm+MnM2CyUkvFJYC8avmlyuFmzRoyPCAbyvNtU+5eKjWjjskhRqxgWx//h4acHMZmSCOMePrzqVIkk2/70OxqPSxOzk6pBBWcWQ2TObunIb4jTrc1/NTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eropqvh7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gx3FdBXC; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClMUl2251656
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 13:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pSi6mbjLTt4yXQTEdhbGqtJWyZrXV7sPpk0t12kGMmY=; b=Eropqvh7d91kVX8i
	H0Xwow4ZDFnMtPc3V3ihNpeHvOTesHZ+yW/+cJ1gPNWYKixiwzPisOoS0dnhwuB8
	r5mtOPv8wMLEUraieQL5tRe/wqoXsNwxTnCAh3NhzVhFnmGQ5izKn/nKMb8v+md2
	l7/VszIr+EPdQ0abkVocbHpe1rFYTccIcZj8ZQq5mRtMaq+zq8ZkvVbFazcWlf/5
	+qR+PwzcaYG4KX1Pj2nB4k14uRlIJAVOTtyK7CEE7vXWvKynIoIrXm2FvMF7p+p1
	RaLBFYUcpEyumgTCmjSaLC+G8QKZm19o/DI2JQGZf03u706NdaJSm+p8t223ya5Y
	/7ppAA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgheg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:24:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cf9fa331ddso299746137.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781011474; x=1781616274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSi6mbjLTt4yXQTEdhbGqtJWyZrXV7sPpk0t12kGMmY=;
        b=Gx3FdBXCTATAmlT05J7jBW41FEVXYrNarBrZ7nJTeH1MJynaOOmfodzv5s8LYTWNZc
         ZW58rgueltcGPvSvcvv5ZrY/N4feDZTk20LAIbZ+3HKpYR0irn9ccDGNYVj8BgdNMzlQ
         LrJ9MbsFgYliXVWNrHIGXh//hTm8m1qBkYwGBRVgQLR3sTScXth1hQLFRBO6SUvDlsjI
         6fwehMmPZYdiS6rNjblO2BhGvuF4LozAxYAR3fYfP1ymfCEZ7f41Zd+7o2pDFKuErsGk
         vtrAcUMR3q3sXxcwbVKn8aO4hyc26lMO0XQ/hxE0gdxeqCEaMjSMt0OjeEs08lPESwVl
         kODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011474; x=1781616274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSi6mbjLTt4yXQTEdhbGqtJWyZrXV7sPpk0t12kGMmY=;
        b=DjA3UHBOMB2fqYIkrEu/LFDM4k1csmlGcq5fOO8C5gkXqZgNpquxH7YO2G1vBu7+Yu
         oMYaS3TYloAHg5KxpChIP0Kc2pE4JqPjgvRhpthd0+Kr/p3rSWia1fthuT5Voj09TPEE
         HXIJi/ESkj2dTmwYHB2mBoTuu4X5RAnSv1cIKn7GAuBGvPmiItIlt6zIW6aVq5L6lm8R
         Qw+ANC2j0X5Ej+0G2i81w2GQvJyQzabayy/IHy7D3G3oc1mIrPnY4V4k7PMEh0lsRqAk
         tWib3mawfLqufIaxauuX8tdPAjh3CV/UQcETXlxbg5WjBukXpCLEnQeAffuSAwKl6Wy6
         O7IA==
X-Forwarded-Encrypted: i=1; AFNElJ+zXvU8rqML67QBd4b1kNFHkvbP6kBMxak/p2hx3Zd+1iSrtl+yPOAuutiwRyfcq/MU4fZKCRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1BKObd9VcxiIRgagAnTLsL0sVrjRpCrGR+4lSnTN+P5ufheP
	GVxnLq96UiFnts12gdEK6FFbjmtQmIgl9IPAZovU0P5lerz7k/pXtcV7Muickmu3vlSw9OfRkUR
	zXMYI7OtmNgGIw3WtpK0fJldSiqbpBCcCbw4TUtlO0gh1/l/b1t6z4f8AEsg=
X-Gm-Gg: Acq92OF1w6rh3neMkjXMJVsmA4sIIE7Ky45eujN5R4eF+ceZzD8OzFdxdV05KdKhAYy
	bq08OW4aal1NHSey1Q+Q5M028ZTuv675ZmEiAwShYJ+stS2Tk2xJ4a9wtvb6y/SvP+abtOqs1u7
	M11cE/TUWAkggww+3mH8AVkpschEfmdtBgO02pC8wTzNhSQdvMTNWX3ODjyHbpTKqtHjGAD8QjD
	surLq25XctE/NFLakQBYIpxUtknpOqrt1+kp5p3o07cAPBPckjdTpeoGWCLtxixEYA0XU63VwyH
	6nr6Y1mhiWCtcTXM7dzv2Zcg6aoY9AxlQSjemklPsvHMrtM4xuExRrrZEprfdROhVNQVF1K5m83
	dGshv755PmlMZtLDnymc8sNOHXKIhbYD/tleTAdMtyOc+Rcu8LnAaQujH
X-Received: by 2002:a05:6102:1487:b0:637:25ea:99c8 with SMTP id ada2fe7eead31-6fef3c04af3mr3212909137.1.1781011474300;
        Tue, 09 Jun 2026 06:24:34 -0700 (PDT)
X-Received: by 2002:a05:6102:1487:b0:637:25ea:99c8 with SMTP id ada2fe7eead31-6fef3c04af3mr3212894137.1.1781011473857;
        Tue, 09 Jun 2026 06:24:33 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm4883372a12.19.2026.06.09.06.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:24:33 -0700 (PDT)
Message-ID: <bc3cdd77-9e67-4e72-9144-af854076b74c@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:24:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom: Add bindings for PDM GP_MN
 clock divider
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
References: <20260602-pdm_clk_gp_mnd_v1-v1-0-1522662b6c53@oss.qualcomm.com>
 <20260602-pdm_clk_gp_mnd_v1-v1-1-1522662b6c53@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260602-pdm_clk_gp_mnd_v1-v1-1-1522662b6c53@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNyBTYWx0ZWRfX5UKUyHOg6D9x
 mAuaupMo2KyV+NA4yKUp4K8yjJXTLVhOs2HyfMsUXNkfWCaycaZDN3Rk6ZpwU/P5cMHbQ1a58e/
 YpqPsXTSfOWGEj9fTm6KMb09VpuJGfyQeF+UkSyir4DEWteRTpzV0+3oO2jrGB1HC68Yn5yT/rP
 Ds4uzrusTAGHanrXP0rpO/qaipbkeHv5uDqs+xD+DLMGQwP0nHEQVqR5wypqDsWe2rDrT7vpSPS
 E6RahCbV7JRwnEios9syGqbqANfyR/ly8w7/1DEaFMoGhxac6cXkGb4jJU8LG4dekepirLkNlI1
 IiFsoeqth4FjnYxCMNmfFUNCjh0KbBe+KmJ6GEb5/BekB4lkSdOy6Fh/wlZ4x68Y+QfeuQtKeF2
 CCJjO9jFe3ApoYlQeEn6sgR701Vh/v33z/NKZVkmZ6k6Y0Q4N+PzOrTBg77JRKX/HhEXwng9i+c
 KfML+hVG+KzIRlMJOgg==
X-Proofpoint-ORIG-GUID: fwq6JT7iTXQO2BN9y6DN233ASyRFN-Px
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a281413 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IMCAxTU7yX7nb3N5cp0A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: fwq6JT7iTXQO2BN9y6DN233ASyRFN-Px
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090127
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297048-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:taniya.das@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:richardcochran@gmail.com,m:konradybcio@kernel.org,m:ajit.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 320DD66085C

On 6/2/26 5:21 PM, Taniya Das wrote:
> Add device tree bindings for the Qualcomm Peripheral Web's PDM GP_MN
> clock divider. The hardware generates a fractional output frequency
> from a fixed input clock (typically TCXO4) using the relation
> Fout = Fin * (M / N), with duty cycle controlled by a separate D
> register. The clock output is routed over a gpio controlled pin.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

[...]

> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    gp_mn: clock-controller@88d3000 {
> +        compatible = "qcom,clk-gp-mnd";

The compatible must be SoC-specific, looking at the table, we could
use these example socs for the versions of this block:

8960 (v1.0.0)
8974 (v1.1.1)
8994 (v2.1.0)
8996 (v2.2.0)

> +        reg = <0x88d3000 0xc>;

Let's map the entire 0x4000 that this block spans

Konrad

