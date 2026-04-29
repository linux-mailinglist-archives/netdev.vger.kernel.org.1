Return-Path: <netdev+bounces-282357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPVtLX/o8WlZlAEAu9opvQ
	(envelope-from <netdev+bounces-282357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:16:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1B493663
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 582F6302E326
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E803F0756;
	Wed, 29 Apr 2026 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5rB5OFm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TpIUi8GU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA663EFD06
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461370; cv=none; b=GpOax8IYVOFASneN6ZhNHRTdvGadZIfB6/8yYmTk8z7iL3VZ+idJM3oI21C5a4m3lrmoWKTH869RYP35ttg6P1Zo5qUF0QYvIQPgk/ikQ/WjdJwdiPsz3rbuDX0EHfMpVBlgOh5w3EmTwH3cOGcZPMska1ubOQcGAGHPfctnb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461370; c=relaxed/simple;
	bh=r7g7Tm20OlslBUQU3g/4Mkg6hUWZfO2i7ABor2hIzoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDQymsaFdZGUUABvqZeVYMJM989j0LSvx1ksv1lwDiY3M0yKoYpib2DsnsodXTuu30lTRiXitrjOzeuZD6Q9Y+j+SAJ3cQOcWj6drvoETTvizHJWw50ia1qQKHW4Jt299Vt1AIUKLUVEwajbvxAjKimTT6Vuim3kxz1yqH6cB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5rB5OFm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TpIUi8GU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8psxe2094143
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DnnyIl7TvFweDB2FQ98uRWoiR/6/z2AgxM6DCJdfXXg=; b=X5rB5OFm1ATf9N2k
	gsp4otHkHwPssJEQPg84pB5T9XUhNfTcnv/7LFbt+nZ4MiNsINpMA2qYCDp0iVVh
	QgaUmW+wtEtpWmKHjzh0h54E6HbYNTS96h1QfnaojPM+bRxKQZ8ybT2hDZcBVUB5
	+o7cA+132KZkoIDB8w1n3jj/nOE3ePJRTkczHziV9vYGIYnBX5adY0B7aBig8dQT
	GdU/vUgwgehDIkkTokVefUI/AJ8blEwGqwwqEZHWHmobfAlJTIhC8Vu6OtH6b+OQ
	tD7MFdKGGIv7ruSnAuSC2vLAin6w2YS5XnLEBHKuENdz0QmMP1qZIB+h4RrLUcUt
	+BtXIA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3s173-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:16:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso24022646a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777461367; x=1778066167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnnyIl7TvFweDB2FQ98uRWoiR/6/z2AgxM6DCJdfXXg=;
        b=TpIUi8GUghqOGhnjPLUDdkKEnk+AHTroL+UIz5p/Fr2EAECMsa0W0QCqvelimOHtD1
         b1DVcpEeNOn2nNF4+iKiXN70oSHjuDlwY3ZP6nM0yxk9zOVEdRk8W4Kqyur7hLQi44sl
         f+hp4fXz5KY8w9qimSguT1iZeQwiwFZLIQybv2c3VrGPITIkFaubtCdb0VG8RfmZyj1b
         gkKwvutUio4G1PxZhOv9tQMS9c8IZU6bZXHgvY29/0LBQTp4nlYyBMA4gYXHNzDfsDrS
         i8Kt3HXo7ZDt+f+aqbx33m8HXWdjqeIdJn5tJiAIqbi8f8LZi8VCwv+OZFxFpjbHVb5/
         GEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777461367; x=1778066167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnnyIl7TvFweDB2FQ98uRWoiR/6/z2AgxM6DCJdfXXg=;
        b=KpVOq+01wxvtd6TL+7zEh/6Hud6wYiODck5GyXp89g7BnUaiL6jctX2oMrLP+O8095
         FggBgUZ5r9rV4QLJaq899mIKkAEGqC3iJ5hAQ7SN9NzyJ4HyDgoIGAC8TeL/THuxmhXb
         Ep9lLth5cH8C0wDFdaeXSjpGwQeeLtP6TjkRpeTphIoUQeyxLoMOA4oEI22DpbM456XZ
         kx070n7zt8eBQ5l7NsoKalcn6gXsjxavWRWVJEyiKeQJdxN8Ic8xg+RH1f0xttp4eUZ+
         VSI4/1SBpVCWvagtC/6+yXsyuNYb8qfgOvqRGrzYCo9dEEg3LrXRA3PNDNMSpNx50fxJ
         H2kQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Q6YVLI/O4mmoRM21b6SkuqWgqvfKbzcX8H8PnAmlVa9tu4ETv/AKCF6+W99CzXhTcb3Ttzyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNj7JBdmnXLemzNrgX6J2YteqGFfXe8T/iWKkxEFKdSM4JXuo/
	2nUseR3EZIz0APd86pPoMGFbe86uJvT0QojeR7bOvM9sIswHoo83TnJinlCY7u4qcK9saR48+H3
	NtYPfBZ4IzQZxPVbdD3f+mw+9p+PhOLnI/4YjKpFPVlW7AUZPnuBglWchnbQ=
X-Gm-Gg: AeBDiesZES3wH0UM/gb0pZiAxiGRTZal+eWt7Cv9bCYALGsZbdmeOZKd1qRgeZVd4jY
	ySSfarbfffF/Iokmw1gbrcfJulifAIaRFINK6eZp/aLehtE2MUOdfuRomtkC4Jd5P695WES5PiM
	vHsE2NziVmPczrLykTaijHnC+pqeula3Hq3VQI06ZNkwQ4R134/9obedKibfShwOZiPezCHB8u4
	Z7B8ThVpkm4+QydOidE0+DP1MJI6Ote0x3Z1qzf1wWYJlPItuxU8M6wR/D7EsF6vpnaiEr03rtk
	Q0lOj8grunuK/eflv45+6WCgybrCVvGOlLBQtcP9xk38iwrCNNTrGHKhCJfmtQDedkHOGxZScAt
	cJUV2g3dluOM9OHTWv2x3jS9fvi7L8mb5/5DNHnYXzV+cdH2ampw0HfsONQIv
X-Received: by 2002:a17:90b:4a10:b0:35e:58d3:329f with SMTP id 98e67ed59e1d1-364920a5a75mr7888712a91.13.1777461367013;
        Wed, 29 Apr 2026 04:16:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4a10:b0:35e:58d3:329f with SMTP id 98e67ed59e1d1-364920a5a75mr7888676a91.13.1777461366535;
        Wed, 29 Apr 2026 04:16:06 -0700 (PDT)
Received: from [10.217.216.225] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303f52sm3481185a91.16.2026.04.29.04.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 04:16:06 -0700 (PDT)
Message-ID: <6213ff0f-b904-4d52-890d-69d453c3db18@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:46:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: Add Global clock controller support on
 Qualcomm Shikra SoC
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260429-shikra-gcc-rpmcc-clks-v1-0-c3cd77558b7a@oss.qualcomm.com>
 <20260429-shikra-gcc-rpmcc-clks-v1-4-c3cd77558b7a@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20260429-shikra-gcc-rpmcc-clks-v1-4-c3cd77558b7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RnO4COc5O44xhb0mVqpm1M67W_66CzW8
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f1e878 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qXpo7wsCot1G_wR8kq4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: RnO4COc5O44xhb0mVqpm1M67W_66CzW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDExNCBTYWx0ZWRfXz2ncLZ51szDA
 YCi31+DwhI3BFgUKBYfGfUURJW1N4ph8VrM9SzImhLGUz5YXi9p0zaE4GGMKcuiCcktdpq+mYOy
 LAkXgK/SWYLLss2pVRR7AAE7VCmZDBzRqDAcl1tA5ussiBWEAOaALtE+vQQPOWF5h/UY4sgkEhV
 afznhASAzp5ql6CgySY/Ps0rbaY3rqh9Q2Fj3L9v2iN9BLdyNDU8FIjo/7T/RQD1+n70pQss9i9
 /DgU62q1/Hi1z6CbqvI3yDwer89sGFctB1cEeDeAProZeouixa3kUvAB+d2T45gSj6DUlLypYZb
 FeaeqTRhtJqnGB8dxNFpwMbQTl9KvstoNBWu0nD6/PVQRCy1N7wolUJ5RPrOK+LmoMKkrMY18e4
 tEmyfkkDJ5AiiuTfcftRPaAefAhQ4bDYaiUYizwcKOv2aaEfAdSmokQ5IDP0HZdBCMQmg9w0Q8j
 /1M+oqMUWqIyJnqh9Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290114
X-Rspamd-Queue-Id: 60E1B493663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282357-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[taniya.das@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/29/2026 4:21 PM, Imran Shaik wrote:
> Add support for Global clock controller (GCC) on Qualcomm Shikra SoC.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-shikra.c | 4428 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 4438 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index df21ef5ffd6862bec26e3a77ace62ad935ef44fb..a2c7751b091a482f22baa633d658cad0e52139fa 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -155,6 +155,15 @@ config CLK_NORD_GCC
>  	  SPI, I2C, USB, SD/UFS, PCIe etc. The clock controller is a combination
>  	  of GCC, SE_GCC, NE_GCC and NW_GCC.


Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
-- 
Thanks,
Taniya Das


