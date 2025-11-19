Return-Path: <netdev+bounces-240009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52223C6F2BE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F3024F154F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001535A139;
	Wed, 19 Nov 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlANfVQU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VnFQTan1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA6325724
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561070; cv=none; b=Lx2oPR8UUHFOiLspBn6/99wh4Hto/HLAjNhm18ZA/iA9E2ODcrWV/HCOtCSRkCM/kJmNMJxxi4/nGshArATJgytHzP/V5tyJ9+37f9Bz67nqLqhDTFtRuqcTvg71rd3Ui3cSnlyPEWNizUhMrlvWoaRyAMwiSY00Ou+qA4yMeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561070; c=relaxed/simple;
	bh=MBk++SI7ocXheh2pdsa693Zbg5HkjC/WAL+010xdwt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9Pc9/Abn5YarR+SdKNltlo9+jm0fn4LD2/P1tieGcIiNJLuZHxircH5l7Y9sgiusd2zL4vzB1hbJvuFaqU39fFoXAjBkKRJKT9WsXIvDZRLdQTtnzh7boqqzImKfDFN9KuJNXoEoTy+pYkDLDj15MFzVpiSZDwRzGG+dl9eUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlANfVQU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VnFQTan1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJDV1KC2078210
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5eyCNmwWmDeNycXwiGh5ANHQUbpJfYnNW5Wx/BlGZLw=; b=hlANfVQU4adiwS26
	xTp9AC4R0M2msa6V9XVu3RrqwzGNAMicSjFkyErG8NHMKbQRH74rKyERzqGxY3W7
	NnrpbyGfQtqs6II959agMcFjTg1+77J9HL12fUsZEqh/XhN2ws2wivVKhJN0DKs1
	pncSt9AVjZ1Dsb8muflVgiTJNcXhfbgsh9Ex/VfeorMx5o+1LMjhiK0+Xyjfougm
	sDn6HSkHYFHtfrekP1F8Wly8wixwGP9vrZf7ORk5jILEva6NbsnNJi396aXapi3v
	3PKphYB8KokgvXFRFpajjs4hyHlgkKVfl3ZsG4K1MjYWk+WuMWho41injpMUMJLn
	5FULYw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah6fg9phb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:04:28 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-55b2ddeab8cso694252e0c.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763561067; x=1764165867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eyCNmwWmDeNycXwiGh5ANHQUbpJfYnNW5Wx/BlGZLw=;
        b=VnFQTan1wgaye6hHO5+Ib/MAn+uhM+C1XT6oD4U8pnzptI4A1Kr35bcxl2kQEG8saz
         JX5lL6Ci01Qw5QIZGKyMArZzG7h7ctqknQiLJMtn1ArNHiW4DS9IuIgU6so5GtaRzgav
         bbII0I3E9TzwugvfGbjNdp7PwYLxvRpg0AmqPGEBdtLsD9qEBxf6wop9cC/8NtiS2Hf7
         MvXSYEJ1X8r4udGYwHTTRQB7HedovQinsWd96IxEEDHkExamtuc0rPOVmkyisqB+hggL
         /b/HFpdxhf3R3mRs/wbd9pqUs293pIrRbE4XPGV8oGlNGOhvrqxH2f/bsq4Qhi2gg7NN
         x3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561067; x=1764165867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eyCNmwWmDeNycXwiGh5ANHQUbpJfYnNW5Wx/BlGZLw=;
        b=Y0UN8iN34h8FRt3VnR8ectkkEOmDfyHNPTYob0Oqpb92ZmBBBnlZPw8OWZwXpLMAwt
         aXXxl0XSfUlsLDcUwhGmgdIiLmLJm6DvjWs1vL6RXCqE9doDNG1MhMJ58c31OzdYBa9i
         KEWvICL5X+qF/Y/kF5BnDjW9xooEdOn2YnbAGNfXTiPd9eSCFxD1+4+Lk/x9VZYvK/ue
         6DPLZS+sL5vDQ7OaFAyAvqQQW3ENmSZTR9FXuJuoXWBhcYsyyXyRewXiGSPwoCiIMclK
         wl3t/KKNPxDIMQAnJPusK48Uwu9c9f8oMsLH26JYSGxrWrC6P0yCyCGvzKSgD1Sf2pJc
         x6gA==
X-Forwarded-Encrypted: i=1; AJvYcCVhJRckbJ7RR1W17WKzo3gpuz1Zw8USl5ibwwjR4Dk4FdrRViiHqkl8v4rIHZJQDMea4fKwlls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeP7Ltdtlbqsvb81LM9lUl4T5S7Pk4X4XgWSbyXZEPH4mnIFfx
	Owd0iwxkQCiT9xyAkT72+kMwocGKYxWg5593mYA5Z+gy/udgoQze8d7R72jSDQS6mbnGTTAakYR
	nfRN6xZCl9+lFxAOw++h84D6qSX21y9bhemNXyJPvqrIoICozfeqlmqsyY3g=
X-Gm-Gg: ASbGncudH1Z5C4qRXkx5IR7sQIRIYYq9QUbXK8qL7tBaVST3dPz3mqRaWW2s5MA18yc
	b2Z9/L8rsaACISFakY0W7Jh0+Ydb3Barzq4PwU/y94/uEmv+Tj2id2KHuZOwcWdzdJH6T8te1WO
	kuxPJUBezQ6MRJ8olYP4iaSv/mGMKiLvetsKwgq7Mz7h9TDJffnG7H3PmOUFzgWstum0XHhSmwv
	xCZaFJDGKtmpuTILT7ceDLml5c5DbJUo7sQykE7m+xjixx0UIBn431KcUpPdcg4DGAer7Rk9zrx
	ApXz3wm6qEWzTzdbIfiPYeZe7nrWiQMRBsRR+vQwz/Fd6cvbiiDAPMFPhGGUrmgG5vhM0Xmm7Lk
	kEDCzZn7KJxAVFEWa9lM3YkUQLsDmvEGsaJNjMzGMzmyO78+TsAIUoPvs7NXDdH0ThRs=
X-Received: by 2002:a05:6123:542:10b0:559:a30f:1648 with SMTP id 71dfb90a1353d-55b5ffb13eamr1091225e0c.0.1763561067040;
        Wed, 19 Nov 2025 06:04:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGozAIOyuCaP/CpSUrDdBNesIlCHdEhqQKyEjU3wClthJpKPW+79NQz3R96LxB0U2cncCgMVA==
X-Received: by 2002:a05:6123:542:10b0:559:a30f:1648 with SMTP id 71dfb90a1353d-55b5ffb13eamr1091177e0c.0.1763561066565;
        Wed, 19 Nov 2025 06:04:26 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a497ffdsm15258514a12.21.2025.11.19.06.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 06:04:25 -0800 (PST)
Message-ID: <76d153cf-8048-4c6f-8765-51741de78298@oss.qualcomm.com>
Date: Wed, 19 Nov 2025 15:04:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: stmmac: qcom-ethqos: use u32 for rgmii
 read/write/update
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
References: <aR2rOKopeiNvOO-P@shell.armlinux.org.uk>
 <E1vLgSO-0000000FMrF-3uB1@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <E1vLgSO-0000000FMrF-3uB1@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6WR9ZjZ55GAnQBBPpKy1xWW3tumXOGNx
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=691dce6c cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8
 a=jDdzDUYIFSdt8Bpb0fgA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDExMiBTYWx0ZWRfXzH7UUKD0vIYx
 0yZqvb93t/EsFywb7jOBwuCKqOFt3nR97j4qFnHMQTSeTFFRI6cX0G3/2Eu+pAwYBI8itFQsTrq
 duC9DocMCOQ3cjpl8s8Ed6VotAE51mqupgkvc9ls+Q7ZM6tZVjJmyugTd9Zc+ZL1ckGsHT53IY7
 nxxSA4dyoy/dw3O4cchwGhHGrWXU2rwdljJjvnFztbdYYcJCtPaG9N6Xr6f4G9oSgEsIWZFXrjx
 oIMu/vTkvgXPC0rShD9XeaFj0i+oVVyCNIyhGCYuIccriyyw9J7WcwhMJx79gYNAWpAJ4vpIQ1A
 wlrE6avYuES5sXhZF4rQ/LVPQIFPYsr3EFtoOZswO0yHJlLRG9qZbC0d+b3Xez8H0kOjsin4Ovq
 YNbXfTiXzRYHdlHRWsTvH/m0r31uKA==
X-Proofpoint-ORIG-GUID: 6WR9ZjZ55GAnQBBPpKy1xWW3tumXOGNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190112

On 11/19/25 12:34 PM, Russell King (Oracle) wrote:
> readl() returns a u32, and writel() takes a "u32" for the value. These
> are used in rgmii_readl()() and rgmii_writel(), but the value and
> return are "int". As these are 32-bit register values which are not
> signed, use "u32".
> 
> These changes do not cause generated code changes.
> 
> Update rgmii_updatel() to use u32 for mask and val. Changing "mask"
> to "u32" also does not cause generated code changes. However, changing
> "val" causes the generated assembly to be re-ordered for aarch64.

No changes, on clang 21.1.5 at least

> 
> Update the temporary variables used with the rgmii functions to use
> u32.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

