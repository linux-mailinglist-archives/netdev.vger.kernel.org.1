Return-Path: <netdev+bounces-268104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A3VBmHet2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:41:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 878A72980BC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 412DC3013A48
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CA38F636;
	Mon, 16 Mar 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JeYwaiyS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hhwb/yxW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353238E5DE
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657691; cv=none; b=Q6tmLLp4Q9SjXM2M9rIsRA1h3cg89YfJQAzTa86i1pLQ8TssIaE2Xct0K1EfIU81S+KRjlhkuvChcfX63PXuIeGe9C/992FlzFGw6WgCM30kHGHpFQFSKyF8G3LzeH1VibSsuFr1Me24fw7qf7YsmLSIWug3+pIcdydFAAW831o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657691; c=relaxed/simple;
	bh=xGsdO9lvHQTEQqegkv3PbncSFZyHZckPB8k6omLSYbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c05dSJMRa6HnFTMuWERTSW29YBdHugEZTnaMvvg2TEyCc3qee457j5pp4vPr8rqhxwDlIXI23TwBw+Rjbt8drKDr0EdNVh1yrRN417GfxaAD7O9wFzvdIHuTcqjkAo1mo2y6WcPbEipdvqnjC/6uZBE/EZcVKvwDTYsmzHTEKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JeYwaiyS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hhwb/yxW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G7n2WD041968
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1QqnBdYN2J1s3k4Tlc9PyCtgucdWDLMMCEFYmM+WSvM=; b=JeYwaiySR8LxK/ap
	VGxH/KN5SNQsjCsh99I76ZWxnIQiAPWgYgZkNiomfJ9kwyBPtWS5BrZ9FFxZ+CgS
	74n0hAiZk6i0Grc6OqGTYAcM/9eUGap/KMM/zIpFKS5QACQvoB/iPomCOC8KXxt9
	T942vHJEBh30gUu/rKg9sRWL4Amocgdh8Q2IlfaWhJUgSX0e4WIBK6iwDyBI39sx
	1ZoRtAISamPcu9V4PPnS37lzfvketUEiZZjvpj8OyoZgqI6GeD05Io5pjqRPgjsk
	KFjdJpf2rAH/V2ugTFIKY8QpjGS4C0dkzhs8HWasGJ8j81F/A/Y64ya3VNYNmcDZ
	5QMtyw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxdt80m2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:41:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb50dfd542so310794385a.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773657688; x=1774262488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QqnBdYN2J1s3k4Tlc9PyCtgucdWDLMMCEFYmM+WSvM=;
        b=Hhwb/yxW2T6KbiivzMYmpuUhNeydgT2dCen1/8SbJZbF36qkTqv3l2DEmx9FpyuD6k
         WnXOVuzNKc6Bk9EJb7JqgLAMkkz/cxC+bOjbhPIgGD0kGeFTerjbjUPVBF2iVAwPXvsZ
         qW8m2OlHlM0PMtVI8IV5ceV/LsgN9oEuALxG2oHoYvZ7dibfzvzi/XRU1EOSmQAvWQhs
         caw3IBcvKB7KZeBH6x28dgissiJYCoRY0jC+zKWvvztS6ptdwwuTrIJ3N4X1x0dk6+op
         z9+N+Gj/phE78AzdCfKjRHBhaWWRpvubm1dIEqmxinoRvB96SbsTFPxYhuWtXrl89xL0
         FhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657688; x=1774262488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QqnBdYN2J1s3k4Tlc9PyCtgucdWDLMMCEFYmM+WSvM=;
        b=ZDzbgHR0ZH7yfDWD4MVHM3zVRfzU/UbdkK/JjJBckW6se8hG2+8z5Pmqybp5bbfhGL
         plQNy2RGLPOdgmvMxQ/j/S44OyGNJabaTY3VpEH/7lEYRQtavyTpBRKRmCLv6PQHuoFu
         ZM3siLRGLDFait9gXJJ+mZJruMubmWHd6Zog746YFozxogpAiuWqUgloX+zoCHb/lqEe
         rW38GY40Cc2lJ19hxV9WvA++n0dwUAewTc9X+BFDJQb8wIRTp79SQb6D0ABkovsa8mWH
         mzXluUidESB6IGIv5TRB4hENeOsmgyaWP9lcxDzFTbXxEEuwMwuPQ1zD+1lCpM/kk+cM
         GQyg==
X-Forwarded-Encrypted: i=1; AJvYcCWbSCjpMDfh5g40M5Cbt8lt4InkL+C+pfdqPAHdmTPsBBjKtyfiUhcoLxNK74ChmtH0TLvk59I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUrwEbg/GRd2m4/lAu5ISH/OSjDXfEvhN/AmmcabR0aQA0gPE
	hRi6vesLMEW8HCYdysDCswb0doHkSyDNM/5UpxLH04M5fUHtg3QxRJwSmSts86G1uJm0sY1ks0K
	Zyff2NMyFnsSod6KZ3wb5JEQ0rof7+R03927Svw9qsVhgCxvseNKoqSMZEfI=
X-Gm-Gg: ATEYQzylfZwI0lWW5WB5RWMm71v2IOPsbrBzquAYQ5MZwW0AVvVeAVTokbp+emtQegU
	p3pP8u1tVjTu6bJemnqg4PjoPYBFqidi33O9TnGobjU0b7IRvAYdaI3R3jZmJD9wv2t32qe5zT9
	LjPQdXcQXPYW1zlg3d6G/UO7D+YqLGTFji7VW2JwhlS3D7fcAMxzpllvMJOwJNQsXTwiENcWgIn
	Ye/xOMCks5DhUzKpg6jYU0m82W6eieelH9FzvlWcQj5oWuEEQxK8/mDlYAZHBAEdPBKgiGkgyIA
	kMJZADEIKr0DRlKI/d4DFC4ys+jA9imXNKQUrc9CGRz68R/fwOkGLV5TzxCQLhMF8N1mJQWPUdd
	l+9Atr2pooBaMILTZpI9gEyPZupEe9TqIxU1dFd7Xpkpd3viSvriWXeQjzkvYKwdwIVTd0ndKeN
	xC8To=
X-Received: by 2002:a05:620a:290e:b0:8cd:8736:9fc3 with SMTP id af79cd13be357-8cdb5b8a614mr1280364985a.7.1773657688610;
        Mon, 16 Mar 2026 03:41:28 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8cd:8736:9fc3 with SMTP id af79cd13be357-8cdb5b8a614mr1280362485a.7.1773657688178;
        Mon, 16 Mar 2026 03:41:28 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cf49fa6sm537613066b.58.2026.03.16.03.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:41:27 -0700 (PDT)
Message-ID: <c9b4481e-f109-4acf-b58f-2235efc7cd5b@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:41:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add Arduino Monza (VENTUNO Q)
 board support
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, r.mereu@arduino.cc, m.facchin@arduino.cc,
        geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20260313103824.2634519-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260313103824.2634519-7-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260313103824.2634519-7-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BWcNYY2AEofW0QKRO9RcmLeV9mCAbBnI
X-Authority-Analysis: v=2.4 cv=CKInnBrD c=1 sm=1 tr=0 ts=69b7de59 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5D_ixgJ-nfAih4ZOxbkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: BWcNYY2AEofW0QKRO9RcmLeV9mCAbBnI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4MiBTYWx0ZWRfX2h2UOmwYVE/R
 rjE3Dg4yYooG+plzxmFeikPjFL5g4OUfo253c4mI6L736goLa1x6ff/gaVLuI7kwyzALXn39HQ4
 ZTIRPWqsLiPaLGnmyYzgnTgDQtJr2gcrL9cUN+epows+HVspRY507ZUZfwDeZ9l8FoiiNdog2dN
 Iqodpxa+4hB5Ry+X0yCu9jtjWkt7YPK/q2yX/SCSAXIJnoEP6asOefCyNPzySHIGZtBL/3hv5B5
 641BH5f3Ix2R4sIh5NhkEFVjIMQudTlB+ehGE7R7R3CbB0uNUFBph3tgokwIIeUxaFe/k9ZnsyO
 O/Vdy1mAYbWK+j+NJSdEsogR5rVkY0xopKd9aVES9Ifg17TaAHqbq0aeXXrmohkmdWOHMUOyfXV
 4S5Yyd7xrn++P1/PH9j99BghMze6AC7bOoqFtCG15CYdYXHuXq3eSUA2VE67dDvBAANZl/Uq4Hk
 eFqDywkvYcUfA3taOqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160082
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268104-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 878A72980BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 11:38 AM, Srinivas Kandagatla wrote:
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

