Return-Path: <netdev+bounces-164861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A50A2F69B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE531888A42
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3A255E58;
	Mon, 10 Feb 2025 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k98TtJxG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D325B690
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211356; cv=none; b=FUg1/DTpdG9yMVOXR6uLtNzDT5maExVyMA+kzFTeYmP+Ss4GG5ygXncx2ho5RXQ1Osqszcr1CZ1qbR0M2DOIhM2ATB+8zYmwk0cogVSQ/aj8HetLFC6IvIMPuiLMskBjlH4VYnXIwIS7PXqrgHKBK5sNG/tyh56+gwpllxlkc3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211356; c=relaxed/simple;
	bh=DEygm5HWW7X1xdGiLNElosyRq33AJuWmRSE4tqMOcIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gT6cfirHireEvNpFroZzzfKLxgZmb4Ae+KSGqokWC3JHHug/1GqPaRGz8aZ+NxApx1rpD1nQ+etG8F61h5Gxjn6KXSSa2u2ukZpVj4YEvuyCheO1ktTXt2h/PZNKeWvtDjC+E+58ZZmOl+9AW5nSgLhdmQXA3SsQRutx2lfSoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k98TtJxG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AHptUU015767
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zCHZNtni/CSZJ0FFRkrYJ71iWbDqICIFGe1C4Jypxx0=; b=k98TtJxG9YSJjlkz
	AZn4RsntfJ37bbMCwWkkY6LGBUw+WXm0i23q95qFfFBG9wSOxFzQ7aQaN1vLHXTc
	t16eCKLZcEd9Ng3RlWoINgr4B+0iu3EmsBXovO5HGRPRM76udX/swr8InhRYzYM3
	qYnKXvuvldCKB8tuL6lCSgs8yqklbLHdBFPdtyKW5TZ/JrfZ6Cvx6b/hZLoZWaqj
	ICqGUL4Edn/+pVeq0nvdeyfFlAsFa/bqwea3trGlIlbuFTFh7zu29JDM3BpyONdB
	XWT0mlS5euFx8RvxLJY01O72MUSsjzb8cnXLoduwp9bOvuTzJ/SmaPj1SOjKnXuj
	EXff7Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe6nsjg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:15:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4718cb6689eso3926171cf.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739211351; x=1739816151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCHZNtni/CSZJ0FFRkrYJ71iWbDqICIFGe1C4Jypxx0=;
        b=s1jpU1m4Kwj9iDy7ROpPIvkBPZ803WtOH3rpKUeaVdpdEfmor6KwDGe8O8Mv3Uur5b
         es5tYh9ms/TQx8OMjZDo+pEOcCq7EoNOw8D4x7gFxi3r3ZOJ4afefJGresN1Xl+5S+zU
         p4mcEwJbBw1ZlU2dFqbciNkjKxewF9vQbNczESmI+wY1QmIza8c/z4hMx8d8UQkprESN
         emviFl+7KG0cjGtzABXjiwdS0MCTg66bWPozaC6ybGiXlLOFqHDlGl+MV9mT27uhZnxN
         rQFcffi6j343gWJDEuos8mpKDbM5mksGtD2bakTKhL+YuisUb+9G1snBiOVyVYtXTM8d
         OaQw==
X-Forwarded-Encrypted: i=1; AJvYcCXDOG+E9fnRVAsl9elZ7GvOixykQUGzF6NieCShDujVYXwFOOdzeQC8yZ46zjVuwVIC49D4HtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yDYFVJCLkIFV8+VU8Jb7ynLGS6tzTwiU1L1C0fQKSpTpAdFR
	ZbUVZZkqsDyheY/mqRlEEMF3BH902ih0bh91Zc1n4/b4haw2scbfHQrE8VWwkBar8oxoaa4IYht
	RruDsT78BGUf0Cr1B/4DE2uPIeewnSu7db7ZZYZxNk/lSd7FTXqf2kWY=
X-Gm-Gg: ASbGncsVG3qet4EPMVdal3pl44R0f4HSFkGIct9TcAPUzNTwLKSrV9UWVCPk64buY6G
	CwblxU2mQ5sBA0MXjUSoSbXcpnEFpjACoZ8A6oj7EjBPkVFwMaivL9Og/gccdq7quvPitMa+AjQ
	qPb2AzzIgGYabTtLqYKzm7T5xh4EEhOSFnYd8yUbg01rxZVJfsO5yNvaH6zPo/DPfMR+H0Hc3VB
	A6dHBqSTvpfBPEp3qh3y5jBsF1AkVHGvE+4VKFZm1FiJiaQ3XjBQsujigqeegfPvV2VHBA1/5E5
	AL9dmAa9e18aTN2Gi95mwv4okOPfYr+LVFmceJ+9nUUNa2FV7YTmwDjpTOQ=
X-Received: by 2002:ac8:5fcc:0:b0:467:672a:abac with SMTP id d75a77b69052e-471679dc26amr71995131cf.4.1739211351342;
        Mon, 10 Feb 2025 10:15:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+wRXNnWRPbq293evDdIvEhGqEHzq1kYbvdr3w/KyUUAyfZrYq8rC1dDpVfln5xyQdRsb5ew==
X-Received: by 2002:ac8:5fcc:0:b0:467:672a:abac with SMTP id d75a77b69052e-471679dc26amr71994941cf.4.1739211350986;
        Mon, 10 Feb 2025 10:15:50 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf9f6c77esm8235727a12.69.2025.02.10.10.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 10:15:50 -0800 (PST)
Message-ID: <0a1735a3-b57e-4a98-a3c8-46e92b5cdf0f@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 19:15:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] clk: qcom: Add NSS clock Controller driver for
 IPQ9574
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
        biju.das.jz@bp.renesas.com, quic_tdas@quicinc.com, ebiggers@google.com,
        ardb@kernel.org, ross.burton@arm.com, quic_anusha@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250207073926.2735129-1-quic_mmanikan@quicinc.com>
 <20250207073926.2735129-5-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250207073926.2735129-5-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8w_vzvti_3chqCCm_2JafuJzNkAroW6x
X-Proofpoint-ORIG-GUID: 8w_vzvti_3chqCCm_2JafuJzNkAroW6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=684 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100149

On 7.02.2025 8:39 AM, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add Networking Sub System Clock Controller (NSSCC) driver for ipq9574 based
> devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Thanks for getting this buttoned up all the way

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

