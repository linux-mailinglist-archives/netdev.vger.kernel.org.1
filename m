Return-Path: <netdev+bounces-297050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NRdcF54VKGqt9gIAu9opvQ
	(envelope-from <netdev+bounces-297050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C154660934
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:31:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kMFXdbLt;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iTePdh9t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297050-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297050-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03F523011856
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE082E8B98;
	Tue,  9 Jun 2026 13:27:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAB2D47FF
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011666; cv=none; b=D3T5fMKIK1xr0slzpjC5/Z3lbij+06PVOcWDiRBGQopJTmpLqhEDWcN5nVZgUZdTYOpRZnWtKZQGHyufb6q1bgxgEg8rPbVH3dzTOa9yoPy6JJdQKccH6tqVVPUVMBKk3i0xsUBUuolZy31RO2DDXhrmJTqgCioxY175gTZ7sD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011666; c=relaxed/simple;
	bh=nhc7KCz+OiYOb+UWgD3CZUOWb1ZWdh52MnddLfgT8QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGQ9FFVEQ/ysytBRa1ds2P1whgD0PhhDZozU0gBCQl8ACJiuWELAPgi66LTeIRAAFJ43h9SPR3CG3Bne7yvWFP3frf3Whueaj6JcurxAifIkxVmJFbeFwm7lmHSibX5Pi9tr3F0EGuV5b9xtRU+q6a0pzRi2rgF3ihG1nkPVHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMFXdbLt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iTePdh9t; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CmRtZ2625152
	for <netdev@vger.kernel.org>; Tue, 9 Jun 2026 13:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rgnLV2/w2XT7HKp712UjzXN1qIRKgOYZl9HRj+d3eUM=; b=kMFXdbLtYgXrT8sa
	NNtgbEqztvNikKrbSGT4KgTpkyEE377r12AZdx4Q4gsQ9HCCXamDs/AG84QjJu4V
	6xFT0nHSDSUy+vLhhmbsAaqM59S6nPCvKzPpxEqBObgMAtQmIxBs6CYwVTy9+f5C
	wAo/JWM0xpQkpr4C7y0l++x+aBadls/np1Uy3PWugi1p1IM9APCulfnJScl8VXyc
	Tpp4Zrvv2xXlXlu7RZ92dZScnEzC0Yvc1BUkPrFIbIhqt9X9c8GRw1zn+yDFDLvU
	ZHwg9QaVcws50w/cW1x2iH5rCiJIPJB5vcEDMfwwWKVR0HQoCQGJMf+rHbT/uBlO
	CU74GA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds9uuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:27:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51759082206so16573011cf.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781011664; x=1781616464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgnLV2/w2XT7HKp712UjzXN1qIRKgOYZl9HRj+d3eUM=;
        b=iTePdh9tlDtOHRYalu3pLZSDBKWbOqAiWVAc2XCvx7zaKbEIoRoMG3QpsMVYgNNYKL
         wUIYXmT68mINlil9dJOR4/Nn1OljEuv478z8RMj63sG/PmEC1ZTiySNvVuVzotVX5bBY
         0M0pMwZAbYUReEgT3Kcj2595liYE6YhtpsiVcmiiApdXlwvn6a5rxYFYZKyFPO+VfWbj
         WgrTdZ3Z4tzTtxDjXecWUMstVqH4YNPaq1ONCf+JsTSvTTiP9gZuno3p7Q0y7DbZGqUx
         136kvnonI76QVefg+mrufGeYnNCfY+GGkltsMXl2zo9Vio4ZNkdnhWUK1voA/0sEIGes
         hTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011664; x=1781616464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgnLV2/w2XT7HKp712UjzXN1qIRKgOYZl9HRj+d3eUM=;
        b=gbRLNpgCsUeVCtY+KDPrFwbBv1S34mrt+bVn/itmchcg7Rh3C23iV66FvxyildB+UG
         zTG21avkxbS/keFx+xeuMlvP8WGkApvD09X561vP3CTaxB5XtaUyPqX8VICwoeR1XOxx
         3lJ6/lHFKAoAHvo6d/SFKt6saQN0xICkUbBSw+iXBj20CdJ9j5v9zi5V6tqTTgPjM1RK
         UNRVbOYaCds5XKPQy2fjH34m7dWiyvOLwXatk0cZe8iLd7qIX4UB/6WsNv3wHgNfs2ua
         P0hWx5sz/3cRhq/2pQGQSmgIJXq2oFzYdC41NXXEOkpU7d7VAPRtDb7Y0B0b5G8+wLXe
         sAug==
X-Forwarded-Encrypted: i=1; AFNElJ/U5p7/9Kt+BsLE6mvrIZ9I+lXmOiF1vdDzDLpDGDcEWq+yo0RWYCaJNQAl402nhVs+ZWVVgk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXg1PVtRIp+ZnQVYXtc8r2YK4H4rXGy9xo9aMCjMATxA9YZmP0
	41zmooOD66JUpmehn7s9LOcxgrX1pBJ7Y/dd/nxParAB606qa1PWHnEACRMztO8tSfk3Dke7et4
	auFnqLG9D8gHY569AMDGKIFoC2jJMgMfvu3xJ1ObeZlKlmebuGxqQV3DsL3c=
X-Gm-Gg: Acq92OG/q6uh0GmJ4lpO0y1tYqJWeRCCgtmRziMlD/D8hfVvOEm0W7LdgIKldVI+tPB
	TQtuQSiyjf1OzT81R6zPbUbWE6G1TW0YbLwqGkjHvCelk4cc6HnisKCoH1bO5PaQtYlGOR1iJaf
	JUGrpEpilWC+SLwC6HMrFfGOSiLee1Y5R1zL63ONGUPB8qg+u3zA11rUt//ajgd4vhE+b3p4lNf
	tr5YLGWmUFEkIJb6T0aztoy0GujwRYbM4JyxHFHVu2jMB1wQay9gipAjlikHWwKzgyqHuPUwa6L
	0D8g8Id+ZLfhFoZfyEuGNatoKozFySlWwH7+G4ADX6DhPMf6nPM20e7ItsMGfQaG67Gp9ZtAW/G
	C07s+jrXw5uYgJIZqqCCyhovFxweNsMmRt6wsAfQnlXB6mZyXnXh7SMtR
X-Received: by 2002:ac8:5d0f:0:b0:50b:5286:f756 with SMTP id d75a77b69052e-51795b90308mr190603661cf.6.1781011663607;
        Tue, 09 Jun 2026 06:27:43 -0700 (PDT)
X-Received: by 2002:ac8:5d0f:0:b0:50b:5286:f756 with SMTP id d75a77b69052e-51795b90308mr190602771cf.6.1781011662748;
        Tue, 09 Jun 2026 06:27:42 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1464sm1058581866b.55.2026.06.09.06.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:27:41 -0700 (PDT)
Message-ID: <a516c0e2-0ac4-44fc-99f1-ef8dd051fc18@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:27:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pinctrl: qcom: Add gp_mn mux function for QCS8300,
 SA8775P and SC7280
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
 <20260602-pdm_clk_gp_mnd_v1-v1-3-1522662b6c53@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260602-pdm_clk_gp_mnd_v1-v1-3-1522662b6c53@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PqrRnQuKmr3kbtgPPkkZ_tzXYAdHMpQn
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a2814d0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZVpGCM6XPQlVWg26268A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: PqrRnQuKmr3kbtgPPkkZ_tzXYAdHMpQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNyBTYWx0ZWRfX7MqlDxJDdPNM
 woxeFx1qISeIJldX20kgt1mKtmsf1wy/21IR+JbwgCrkbr6QiK6kxZTMzh2bBWnMNwO1ERV0agk
 Z/yBsX9QddwQbsy1D97uCrFHX3BJnF7I14HdovGcoOtgWK/6aEW6VsuLPXMiGN5lkjGjzhrE0+m
 Wa0ugUTPVRBzIdSUBhzeYjniWp3jCaIavAvCLLM+g8iw1k/Q5dRyhVZHjeY4YCIDgJlP8tnlQ+w
 mNz6Ohu+nagtTCUqb+xFYD8IX6mu6rSgfZKZFpuW7JOaF7X2SDzAvaLa42CEuex/jgPPnNSfK79
 oCkYqEL/GQ0NWjKKhLdgHb0sSYrzq/ZCtjp2GUqM1/hde6PaY8h5H1S/PIT+Nu0i3N8B168HYvf
 GrIJyBWTK5csbpqPQdMsEU7yTUQc0AA/sg1nhvxwlPHEJUT61NZTV1JHRCap8hqnUC99ltc1zvt
 Ux1V5qeRSY1u6XDu0Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090127
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297050-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,baylibre.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:taniya.das@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linusw@kernel.org,m:richardcochran@gmail.com,m:konradybcio@kernel.org,m:ajit.pandey@oss.qualcomm.com,m:imran.shaik@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 3C154660934

On 6/2/26 5:21 PM, Taniya Das wrote:
> Add the gp_mn pin mux function to the TLMM pin controllers for the
> QCS8300, SA8775P and SC7280 SoCs. This function exposes the GP M/N
> divider clock output on a dedicated GPIO pin, allowing the clock signal
> to be routed externally.
> 
> - QCS8300: gpio32
> - SA8775P: gpio35
> - SC7280:  gpio60

With the changes split into separate commits for each platform:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

