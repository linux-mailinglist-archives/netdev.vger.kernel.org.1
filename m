Return-Path: <netdev+bounces-209013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB06B0DFF5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADFA7B7BF9
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6B92EBBA4;
	Tue, 22 Jul 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzMJhF1r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC62E1C7A
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196520; cv=none; b=ibTWRdg+vDPhpLleNaYSg9FxGCmfb6T+WcbCU/U/wus4ryw3wp+Y5iKisTQ6ZbUU8oQyudoAlYHK108i+AYxCKFIpFr8verp5PEF0pKeAKzMlEVCa4jimvbdgNebq3e36AArDEeaCGpRtyAjf4IdxpRfQBy1AbYMegVitvirML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196520; c=relaxed/simple;
	bh=YmHvIykm13Ip/tOjb7KoHSGXfOvcdQou2fZ6EnWYQTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl3hNct+jp1RV1wiilQmj/JTz7e9q6Xsi893blUsbETWQSvJuYv5WPfkCMn20Gflkccp8BiIGJoshA//FdQb8ri7bZa8+uqUllvUXMforZAuM6ifk9sgWwHY75TUUR7RFyR+lXz1JX+BiESx4rzTFLniIte5JJpUBdqyhPOfVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzMJhF1r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7gQjV011559
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nQea+0bC6PD6eejJkZGOzWEWHSsdYyQtTKTo+7Hs0x8=; b=lzMJhF1rrwyfBKv4
	QY1FUQIGo7zdaPMs0+mvmgS6d50hl6NvrGiG8Xj+h0xnai1fCIZBeHDW+URvCzG5
	213nyitbdgiTo+ItZ6nS0EDKPX2BXtutwA+YowM5xMfh0p4M7FdShhhjs40+Ew7k
	y38edEMHc0tMqSZzLlayxhVpQqc4+eLJpcQv08khiTp+f8tOXoeAU1f7mZCG62ZJ
	bTMVKMh+f96wMDjQXvWCYDfxHLGCxX5F79zJXQvL7EtneKg02OyP1yiM94x9uKPj
	gdUEknpoPV7fHkG8O+gOMNWfiwXcMVpHNgo+CGcjDnXUNpajAcFmd8IUJGa+Ok0T
	PmJg4A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w30ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:01:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fabe7822e3so4927836d6.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 08:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196515; x=1753801315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQea+0bC6PD6eejJkZGOzWEWHSsdYyQtTKTo+7Hs0x8=;
        b=n0rG0AXSPC5qBUs4faPq/LU8cE0lpk6HZSWm56MEvnjSqv+6pS9fW/4AwR1PA/YY3N
         Ur1Cx2yYX7olkqkmMYHj8DvEGcVUlWGtrtOWYh4crLr2F3Pzc+bbXPOcGidt2CZ18r4F
         WH+awZzRKAOHZP64q1N9VEG8c+Pj74d+jHf7+St1AuF+Dss5gbjMtsUUZc3oSWR77C3p
         tqPL64Q6KBm8c7J6nD+l0yoas2a9TN7RtdKGfvVdNS7DuQIJcdsrRbSzfGCP/nK8I50n
         UkTY9Qvtp9xmMEg7I2abuXrqD1k9CHtVqSCR0c9PfWjAVfF270f7OGsiWDTxtiKpoMi+
         ambw==
X-Forwarded-Encrypted: i=1; AJvYcCXrqp7946uzeRTZaDcsEEqddfisGfgwIwbFfNYNMukGmgudi3TlCsQq16uimndJk4ZaxLuQuCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUvVNjtl+24LjCLNr5JdDOtFxHxRIUCgiX4ULgM5P89qvec68
	tzZXcFLfOXn9asPOeCJv8hD98ECCPZlRXpKhrDXQueHyCOXCWwD/43p+srFCNmQoWNCP74PsWZI
	95vau+xpMn/sXeVJYn04747vkUZrNlHYIzUDDF5GOO3dyFZOxiWRS5hAcZQ4=
X-Gm-Gg: ASbGncsQ55tFBKnGXzqmStl/p3AKovw27YZ5fBPsffg7BAMGu10WOwhbrkzQaNvVN/x
	o12uhXW4+d0PUPZMINRA/vSa48D21QUK8GXmzrszhqQqRysXMgLTnaiM938HirzihiNyTfjVJkE
	XOXcONPoX+XfkqCvOgC8qW65m8cERlyzcbZeKC9bJw8VsbaxYfDp2JcMKlixWMSHH9Eur6DGhds
	Pl2fWoEmBN+gFWNc1U7boMaAEPOmKx+skqrKR3aMGILtvWe+4n1b9e6Bf0MnGe+Peh+6cq7a8UC
	ucL94dImQQvXKhFqTp7ZRgm/kV+Pusz+2x4GTt+tk+l1pbxyhKY+f5TocdrwVmN5fd1fxbbqKA1
	DQs5u4SyrunusEA+frdIz
X-Received: by 2002:a05:620a:8089:b0:7e3:3419:8ed with SMTP id af79cd13be357-7e342ab82c0mr1516901085a.6.1753196514607;
        Tue, 22 Jul 2025 08:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9HTTcR+tQSzuEDJ8+Kt0u51iSbuGAMBmDowZbgYVk1n01G8uxA0VUwMaUyhdWRTPvV72rbA==
X-Received: by 2002:a05:620a:8089:b0:7e3:3419:8ed with SMTP id af79cd13be357-7e342ab82c0mr1516895185a.6.1753196513449;
        Tue, 22 Jul 2025 08:01:53 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca310aasm867940766b.72.2025.07.22.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:01:52 -0700 (PDT)
Message-ID: <88a22bcf-2c31-48e1-8640-867727c02ea2@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 17:01:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: qcom: Rename sa8775p SoC to "lemans"
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@oss.qualcomm.com
References: <20250722144926.995064-1-wasim.nazir@oss.qualcomm.com>
 <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=687fa7e5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ziRkMoTaCqJTGmMilkgA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyNCBTYWx0ZWRfX1SpGtwJOqb5y
 07VWCYSRAtHDLWMpMPHLA4PyTY1ERDAa/Vb3tyWTknYWBUO0xDqK9U/rmv+a1YPP5pPVPz3rQZO
 79/6lbIeciPU7Wyk61CC6VslxklnAUj5IvlvH3fZXe+rye+ENPGgIsr/7t0pDGK+O0eB1JuWxY1
 0PnhqqmoQwo3aZUu0BkWptqI6fplh+0673FYkF5RHDujduYR9bryv4Hl1oQg3lK7pBWeGX1BppQ
 8MyuiRcSEaJp03zCZVEp9xBYofeHND3IVxqEUaim4B89nsHA0/ENhNIuhmupFFOZeNQHjvSwzrH
 GvwKD8EK0jj8br01KY4wFA7dYCBfxQj0RzZabRQc7UX0f1O7YouAwZrFFB5ThRp+togpSbGYGzZ
 5eNYVn03H7SZLEuYSn2QoHOC2v0jXlDo0LSEnCRTOLxb2sLpJnkr7PwgkZjwc/vKlfrNNerK
X-Proofpoint-ORIG-GUID: R0LFe2PE_EM5qYy-oVZxSzs3x9lPHqpf
X-Proofpoint-GUID: R0LFe2PE_EM5qYy-oVZxSzs3x9lPHqpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220124

On 7/22/25 4:49 PM, Wasim Nazir wrote:
> SA8775P, QCS9100 and QCS9075 are all variants of the same die,
> collectively referred to as lemans. Most notably, the last of them
> has the SAIL (Safety Island) fused off, but remains identical
> otherwise.
> 
> In an effort to streamline the codebase, rename the SoC DTSI, moving
> away from less meaningful numerical model identifiers.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

