Return-Path: <netdev+bounces-208016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F974B095D9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 22:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7143BB140
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC97225A32;
	Thu, 17 Jul 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FhQhQ2ET"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9E2248A5
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784929; cv=none; b=m5yM3rP1gLL3da3ICrseeV3vXYSO9tVIHC9mOiHw938PGkx35yhYzaKk50AOMr6eiV4WcK78ThgCWPk4p9pY9c668P5aIcRK4mcZkOrT0lrSC3OuaToh6DK7tUGn1X8iA4QRHwvmGvVh90hOXGQlEkwZbHTNd6zUsNFd5/JK9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784929; c=relaxed/simple;
	bh=rNJhrVaOXBgN447nIGb70CYE7BeWUHH6Lro6HxrOsrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSql7fBpmGsO88+Pn51OJK390UODrlAmSaAwq0L4+NGFnM2kXDAENcinf7GOLhnfU5B3L+dvO83CO+nBPG8cAjIIhMwNc8Mrh5831aNbwG0RGYm3MFFH0n/D18avhlZx3GPBZ00fGRl6znLaJUFrHZ+9rD/oHnOQep0CnbR8djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FhQhQ2ET; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFQ5H2016095
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TmpfxjkNhdt9dhUb9Z4sklqbRlDt+2S3rq7vCoARvZI=; b=FhQhQ2ETqrCc2+y4
	HFVwT1131Db7D+9s4XwC3oIlNrsScBTDWs9VTASF3EX4t8uZ/yISjsuRGBcRa6zs
	qy+oi3CA1Zwn23UH1vLa5d05L56n8CaVyfCMD3kLvjnVJErJSBm5RiislTStFI8M
	7Vph2rnsQTY8rU1WGJ6uY4zUNnBFZqf/brojlUeokI7DuPmEi9S+xR5ETye+2F/D
	ZbvqLezI2i+Yfld1A5Qwh45Osx5U3+wKekfrnR3kgA7L8UbvYxTirWo19hrWXIAB
	ZW0Uf2kPXZck9qz4j/rdpS+s2XL/alH5pw2VDRAU82BsZcE2mBR+VawUaxsvhbrW
	8VRfRQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc0xvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:42:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab61b91608so3974671cf.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784926; x=1753389726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmpfxjkNhdt9dhUb9Z4sklqbRlDt+2S3rq7vCoARvZI=;
        b=GlaCNtctYEyusXv3UDuhIsS6NNNGTKYlXl9VP8jmVDr2GR9wxM1UmU90b1vKdolq8W
         DKWG7skiV+9PMPLT2Cl9ZZyHdV3YIBcMdGHhcq2vct4H9bOcOW5KlYq+q9NMrxy2FJSe
         QvIQULWd0VFnz9zA6UAxGrEylk5FeBC+gg9u9UNfNdBA86bbDVnPtjLURhsEl86wpkVi
         Y340saQitVBZQ12MtZ5e+uKEjoERlYEcyqERJxCZ7Vj/qZ0r5K/p3UUVusOL39tzS8zu
         Ucsag8pjJm7ojOruJB+JAA9lvT78xl2mlzTqOFQq4UVGKohKOQjztKCmeicLqC3zrO8w
         iKMA==
X-Forwarded-Encrypted: i=1; AJvYcCXWoKyVjXBfAdUpFVlWvGhaoFsnyXv5QIJPrCw6RQW2YLno3sEYK/ZL+90AGYDGLCyBbT51BZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkp0D8CQOOH7H6YIR1fy9lC1GMihCVFPb4nIST5HBFaLKjxAEs
	g8rK7WMjoC40O33jPBAVFr2Eld0ifN/KKVHgmhzOHnXJBrrgksjvxYBwfQpx7TOpikJZm8mOpfp
	e51wvIMlmPcFQ3dWdJUI3OIXkz/cp/xzvzsUIAETMjW8b25zkYysv2VGgJ3DUhlArEKw=
X-Gm-Gg: ASbGnctt9TIVHKmyO5HAM2BIDwtqs8TE6QJOb5DjIDJLGpJKMoG8+4Q11PtNDeWZxu6
	evvtBnUWNN/m2i0gfCOdkcmGiZVKHDysfEKbg0iueWEkvaARcNoSb5rUf5WpBw3dk2pjwu8A+rZ
	B3CMgQIDvjPnVf7rXW68qxDJSFJD/HvJbSO7QlzcgtjIcjbSNX7LI4CgKz05kPtr5hhszf5IuRG
	Mei80Nz4PbeCHkxkng/BMFEKrSgJT0fd2kC3/J4aVd7sMOardjZv7JjL5MMlwBPW/hUV2YvHjyH
	hYxG+MqRURUIrTcNP/TtuhmGvCQqa2hF7LTVo1Cp1GqEiNIoKzCKlTnUZsIM7B+6Sg0OXv1aRQG
	phmW9SXWMRUNw8CgI0KRL
X-Received: by 2002:a05:622a:1a98:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4ab90a82a28mr55030331cf.7.1752784926073;
        Thu, 17 Jul 2025 13:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRWAhwxvL0YQ5lOLx3J9S62rBalvJHOr8MWbHqXNprUdHSqk24MYX4tdyqOdn3P7ha6yUnvQ==
X-Received: by 2002:a05:622a:1a98:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4ab90a82a28mr55029901cf.7.1752784925586;
        Thu, 17 Jul 2025 13:42:05 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611d04d8347sm10357916a12.42.2025.07.17.13.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:42:04 -0700 (PDT)
Message-ID: <193de865-980d-4fd7-9c43-39ae387a5d0b@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:41:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] clock: qcom: gcc-ipq5424: Add gpll0_out_aux
 clock
To: Luo Jie <quic_luoj@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_pavir@quicinc.com, quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-4-f149dc461212@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-qcom_ipq5424_nsscc-v3-4-f149dc461212@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=6879601f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=qx8TOUd7-QwhcYYS848A:9
 a=QEXdDO2ut3YA:10 a=jh1YyD438LUA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: dCH2YnWrYwnw7VPrVsfXOfBojuXWlJOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MyBTYWx0ZWRfX/L1vVb5ydX+Y
 M/PflYtA+58pKQrWzRF3+yKs2ljsTdVnBhLB9xhQFCJRes7RCzjbGfkO9jLswXuEEeneRPrd3rZ
 ofPgGEoDb42TPx/fejaxoPZwako8pJ5ocoD0UxQTYGloZ/Hgwp7ceg3UmTlNxfe/vX9sgWVyFZD
 z9yjn0JT/Va1BW8U5mjHp2szd2nx+zFA/ueVY2Ij9GsyU26kG68kEJRqUIQBGUadt+CFQ+sUdoQ
 HBG1YRYIEnEC1WuCuWjTwtOUQnxtzsCAn/DNPpx+25I3NrkpvcxOID6IviErLZby2x90pBGRx+x
 l2ugNOgUWrjuUUs/RjYufM+vmfGW7T5qSVHGaT/F/la6t6q8eUbjSxKG6IlnlHUIbnQU060l7E+
 Ulav220wqGRvyOb9TEpANfT6w3UNwYrT77yP2tvugk2K5F6aMprQb1QGCEaRiPbIngM9/UoE
X-Proofpoint-GUID: dCH2YnWrYwnw7VPrVsfXOfBojuXWlJOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=915 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170183

On 7/10/25 2:28 PM, Luo Jie wrote:
> The clock gpll0_out_aux acts as the parent clock for some of the NSS
> (Network Subsystem) clocks.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

nit: subject: "clock:" -> "clk:" to match the other commits to this
subsystem

Konrad

