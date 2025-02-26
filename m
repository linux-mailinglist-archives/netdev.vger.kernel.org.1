Return-Path: <netdev+bounces-169938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4969AA46888
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AFB17087D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2022A4FD;
	Wed, 26 Feb 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8V5yw0I"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2322A4D9
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592464; cv=none; b=TI5ClnqtduqNgjZ1uBhGLR8aVeFtkc3NQKFT82oHP51NsOsZeMw7mftWQu7dB42wHqS0fgjMJ7PtjMfFEfW5s1VgSNbOiGJt+Gj+Gv5SPQTQqov6sKjAhfx5Qa6Oy9btEJN91IpACY1b3cltR4Z4djkciVDYs7I6L/4SBV0/fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592464; c=relaxed/simple;
	bh=XCF9u8Z1rw6dikTB5uUuGFpoZde8WX8im3OQZS20lBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2sc4tqtzvvPzE+tXvj4ywTkJvEV//ot+FVYOSrYurRj+6FKdArqSaI0Ilxc116ITYuK9uZWnOnnUASB43x/4gBjI34dQij4NnEM4xARWCUdxUzrJBh+OiiGoRzJhbht4arkUabt1WV9KGRcTUEp9PqurAOKVulXny4jRpZMo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8V5yw0I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q9s2LU011698
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1UOTAeEYAiBnkyZpz44d78r5B7uBb0CODxrcfWD1kk=; b=l8V5yw0ILAnulhx6
	Udo4ZbASizJpDYsHqtpefcgGGV54J1PtaIwrnE/BaIuM4cwhH14lPz+98KiHeV3f
	4GgWcRUDnHJKtTHFPFcqz84Hve19eaxPrkmyMWQ0CAhtEkJm1C9j44V5HuGYwZzA
	ZG8wJQqYMnfpkHN+EkAoNaGnlE98wB/xnqzWpQwoM6npvGS8E9Vd7pFetyXtTl11
	/Nr9MzXO0klRoFdEDBMgwMzgbcgMF5MQiAv/offMvUwhzsSq+x1tLRm/HLMT9bxV
	WCZcekBdaiMKCZpQwwFPFFmE9zXBFNEt1EaF5ejGKAu/0wNF8HL/467F+X6Ict6W
	FT5nCg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prkauch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:54:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e19bfc2025so308426d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592460; x=1741197260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1UOTAeEYAiBnkyZpz44d78r5B7uBb0CODxrcfWD1kk=;
        b=ousew0/fvnvxkCS7eeoscLE6hYRN0Mmfwj2PK/x8NRhP0t/xdZ3/aUUS9JS0wNHuWp
         x4Voif/+yevYvSMfGNVcHX1H4ROYjcvzJP1pd5KQ9ORAUs96YnTo6Ul8stlbowM3wGr/
         e32vxa+CsP0/Yo0T9n7d8TxqB27e5ksLHs4FGtv25bx15IDvnyYsx+DzuOlifGPOnw3e
         BRE6GL2q1fbFGzDdurlKsf9rL2T20qcCLPGaFWzbuKq19wCuMgWeaDh/YEuAn47FJXyz
         nFxDpSJkWGK/tUhe0zy6TRCLyqVdkqAVR5HbgMU83lxNmFUBv6HRlO59m9bVPgz3xijt
         K9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVM4/WEP2oc93rRLj61L8hvSprOKTTZgPTdsSuaNLAURhHPOBj8CUhDMn3tdPtlc4A24WSSiIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOXXrI0f9JCy9JtCRPthChffOrZtNUqCm4nhGpbMN3yS0Nr+J
	tY2I6u4Q0jUzpkvXDC+d5S9Ff8nRIEtXSeRJdWpQLa75a/7iWA87KUE69mHkCg/CpfVWqwaNxIc
	NrszqsR6WpFcYjP4aaNy5+1BDZL9HycLQnR4LGr4OrzsrrfCx9nUk5Sk=
X-Gm-Gg: ASbGncvSmM/V5UxYA6NYiyzXY9s5VB02TqhRLjWJ26lTE2KCLmIwXab4RPzRZ5gmX4n
	OXgW8xl0FfEEpiTUHlHSIti5R8NrzdtvmsH5B4PGvejj38p8vIwVX7nfGzgk9H6/rnFAz8bA/QQ
	TzRdebdJekaMoVm++d39pAzo8aDW+5rm7yiswLwENlUs/WmVp1rV8Y+DT9OoVTY+KuJn1l9HJD/
	wnoWyABocy0oiQKOsqLPm474qmdkiOdeuW7rJeF6O5ZrBY0MlD1TLRDYwb6HYkKLVKHOMPar8nK
	3IR9iZy5I6QZihJua6G5iR8E4tPP0kbE0FK0SD/gAdG/jn+/CO/ahZRzcQH66vTgfTFuOQ==
X-Received: by 2002:a05:6214:21ac:b0:6e6:9c39:ae44 with SMTP id 6a1803df08f44-6e6ae9e22a8mr111525206d6.10.1740592460271;
        Wed, 26 Feb 2025 09:54:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7syWcS42OEo1xDcdvQ08ZhO/oF+3o+Ak0wcAu1DA2U5JLIbwlLDHrfoMof7nVe568CRcIPA==
X-Received: by 2002:a05:6214:21ac:b0:6e6:9c39:ae44 with SMTP id 6a1803df08f44-6e6ae9e22a8mr111524966d6.10.1740592459862;
        Wed, 26 Feb 2025 09:54:19 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20121dcsm370471266b.100.2025.02.26.09.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:54:19 -0800 (PST)
Message-ID: <e3b2678a-9e4c-4f56-a5ea-5ae46acd5e4b@oss.qualcomm.com>
Date: Wed, 26 Feb 2025 18:54:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: ipq9574: Add nsscc node
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
        quic_tdas@quicinc.com, biju.das.jz@bp.renesas.com, ebiggers@google.com,
        ross.burton@arm.com, elinor.montmasson@savoirfairelinux.com,
        quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20250226075449.136544-1-quic_mmanikan@quicinc.com>
 <20250226075449.136544-6-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250226075449.136544-6-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: V71aUA76vPEFxCKFRWWCNT_z5LSi7Zm3
X-Proofpoint-ORIG-GUID: V71aUA76vPEFxCKFRWWCNT_z5LSi7Zm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=598 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260141

On 26.02.2025 8:54 AM, Manikanta Mylavarapu wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Add a node for the nss clock controller found on ipq9574 based devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

