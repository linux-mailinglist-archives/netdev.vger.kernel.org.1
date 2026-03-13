Return-Path: <netdev+bounces-267361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE/vI/rcs2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:46:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C8280B7A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A41DC3014110
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B56145A1F;
	Fri, 13 Mar 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X6RiS6DP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9IaAyxs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59032ED32
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395187; cv=none; b=YxYdBjLy7Ioeert8L/qcNuU4x1My73NbEaDPvlFpSCO2eXpWes73l5HV9XKzqfXu+OpwTrwAoqpob4l0/4r1Y65dbpZE0YVYjTvMhYgnTIaQTYzFsiGf2DT95Mq3f7UZ86JgMCy18TPb/o3vt7UDDSyl1L+yLPum1Xj3WDT1Rhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395187; c=relaxed/simple;
	bh=TYUKUEoBrM1BQyt6ClrZVUZafDom5ngzEiUEt/2EYQY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nheerj1E+rcd8joHIclW0RZMEHVQIuFVEyRs5j9XP/Vu5pE/5itszoe+5YpkIewMz6I5CP3je0LUT18EQvUoopbJZ2Y4PdkfQAz3wfN2Dhbs84nD3mbxmMWeZUm68o9s1Kb3rN+RAJYCI21lNqsd2IcS/AntX4HwTyidty8bc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X6RiS6DP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9IaAyxs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6oNmF793015
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Ar3ph1QO6x9yxfdvQm4f9T5MkufBjrKVBdUDfQCqBA=; b=X6RiS6DP+JpvTwrw
	475rjaMemWDyshDpK6ovKpk6bxGoz+zEch3iiZBTuoCnCsF2dgtFbFHspHhLCVpf
	71e2hOjQVJPmYbc7uW8NZY4DGbu31LMoEEVI+O9UXmixhjdwIjUdeaY7gbBbdnlp
	ektEgjlIfB7gQgUv/KGCVT0hLLtvHvFQ6x5wyZpQMx1QRSRKJSSwMnzmPsQQgtf0
	Z6/Ek6iR4UbqLnV32OjoLaBbXBIo3jO3t6r5IMF2wznSm7QlvxE5MemQKGFpDikd
	5H+CLed2Z0A9mYBEIQoDfU1x/BqxrSOqMXnQ2eC8mZ8uisORmyC+VMnUfsleQdlw
	UNftSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvdnt0nc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 09:46:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7de0e161so1349887985a.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773395184; x=1773999984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Ar3ph1QO6x9yxfdvQm4f9T5MkufBjrKVBdUDfQCqBA=;
        b=D9IaAyxsBKJKhXEhBjEwXLM0FiZXToxTui3yNOnSR7fjL9CYHckiQgENsORgzgXIP9
         1PBgouDY9UAnbhI1dXTUUkP+0L/vZWwGg8MPBDiY6hvICZUv2O0wcbfff+WBPWhdTGU7
         aoAWPsTV03rFKa7umeR919uVqoeIaJ5egxQnoU9+7W8db+w3QzAOAt+p5FTzY/Nna75Y
         QwG3iaTKXdEKS9mfvDx9XpRofpjHzd461c7dUhE3BCR/BmAics4HRTqZv7uVOs0sNd9o
         F3eyYfjJ3o72L4sDR4JvkksnotdLWSkNN5B7iKZnUJdkhuFRFeUVc3yMvY0rx7vVJ4I1
         UOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773395184; x=1773999984;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ar3ph1QO6x9yxfdvQm4f9T5MkufBjrKVBdUDfQCqBA=;
        b=Taj6o1cgdy1dKz1bC29z5/uIFRjeoX4sG4dm5qMEvEiFaO2W/Je9LeeAKsSRRKGz8d
         BuJ+GQ5OREom3sHZujYQoxw4KvroAcjd8N/pAuueWAJK1Qk7tKdE2B4eYAP7mOX0cREz
         zCiMAwScvyRdnxwzd+MfKTurPGT9XvdfMrUc8MXaZ5OFa4tuHIeTyaEbyp70PcBh9u9q
         OlYjwTZkELAa/bKKzc19CRb6MFVx2uAeBJ0TlzWC6gqjOzNn1Nb/+UGnpb24vVmtdeJX
         ubLetk9/fOU441TnvIjy+bHDVoPNaJVsLl6tpJfNAhpF+rAZwurQaxUJMNPfjsYx0Dy8
         Jrcg==
X-Forwarded-Encrypted: i=1; AJvYcCW7opp99eeYPI/uzjqgSjtEsO/dHUntG+RWFf/fOWQSZMVqKS9zy6SBrefeUcH59h+EE+rzRaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJowWXUOPD1+RttMa22jB1zNy0wI2eI1X8Jjlk/v+KRDvonw6
	TL7ysJNDTz0txAgXAFNnUlgitC+aElF50UvrjYNccQ3en9yUKhO/snWa5m0059JNzxGsHL6HQEK
	dGNU8f66FzE96FmbUloTbboq2cckNsXHmp1LY9mLSvYPGVIw/DVzZ1nyH+XE=
X-Gm-Gg: ATEYQzztvrR2aRnmZnX5PMHEKsYTlgSA5mQDa/gJS6uycXHA+kNeNq14XoXmOPRNvWJ
	+Uzam3Wac0hUaySNuZKsyybhEvl9KvkSLXyU5k3PgapBINyoo0xE5tda1MKdQwWMxEcUkfdgP0E
	kaim4dv8Lr+VM0c/VMxHW9McyMc5tyExKgZ1JLoUW9uecMWc3mTKW4jgZVlEkdMKJ4CUORvfxSn
	XoQ/wfgJ7dmyFAieTYWhUNb1ElteMWBgCO9QhiNpERQivWsBORQSdEckp36sru9CIsBa6Lx2Z3q
	e+o+Vmz4IpiIHmuRbXoQ9YmotxnCcYnP3xJlVOiRG3zMZ7HPui1hz90Ja8Od9HiGn04TDai+o3g
	WMFZVQTjRuXgn0oREq+i6zroW61ibif3Bl38eZyVv4+rrZFad
X-Received: by 2002:a05:620a:4044:b0:8cd:9020:f043 with SMTP id af79cd13be357-8cdb5a1c711mr359688385a.7.1773395184365;
        Fri, 13 Mar 2026 02:46:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4044:b0:8cd:9020:f043 with SMTP id af79cd13be357-8cdb5a1c711mr359685785a.7.1773395183891;
        Fri, 13 Mar 2026 02:46:23 -0700 (PDT)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm528764525e9.2.2026.03.13.02.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 02:46:22 -0700 (PDT)
Message-ID: <efca6405-476d-4ab8-a2af-cea5ad4d8115@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 09:46:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH 4/7] arm64: dts: qcom: Add Arduino Monza (VENTUNOQ) board
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
        geert+renesas@glider.be, arnd@arndb.de, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-5-srinivas.kandagatla@oss.qualcomm.com>
 <xkxk22xnv4nkwq6hdbwxy4a5lct3pzbzjoahvdpugectjscifi@tftbseheg5p3>
Content-Language: en-US
In-Reply-To: <xkxk22xnv4nkwq6hdbwxy4a5lct3pzbzjoahvdpugectjscifi@tftbseheg5p3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KZrfcAYD c=1 sm=1 tr=0 ts=69b3dcf1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8PAWHovNJAAVPi20LiQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: d19_q-6h81zdsmmuz2hHE5apm-fhQxmO
X-Proofpoint-ORIG-GUID: d19_q-6h81zdsmmuz2hHE5apm-fhQxmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA3NSBTYWx0ZWRfX3uOa2zAub2Ep
 8p7pAt6b6MwG/+G/vqtbDGq41n+vW2CYmIc+qGKJTpOCs0WaYgs7Q9M9oU8olskFYMBCHqFEgHP
 87ihQHkUp8lD9wSbFfCU5Ar3zfoHeEj/AMOuxtpFym8iRoLE/kVuf63Wjldl7CJFg0G0+JyNxX2
 y97JYv0oe9CnF+DXOD7E0KIE+KlEA6mMgauUQzRwRyPCvo9kMDxqHUwYWwN4+6ltNZLrNEx3n1i
 oWjIbx/jsgj786bZTtBduxXuAh0mtJ3cCyvQ2Oo957dVsRNJOZOoucl0/TwRrlexrS+4mP7132+
 AWgbwi4I+brbGEWLMtGl95ggyNkvm5vtzMfW12bRkSv1Zjh+xghTMaYsRE5XwIEm83qDJCzetKa
 rRlPabNN8GwZRkyUXTHHYT286NZwPLlIoTppQ9VWgejERBpOtsfHJStgnm6cNml9QXPq5ZYMOMS
 TyQT5ZmSNWC3x6dso8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130075
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,glider.be,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-267361-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,0.0.0.0:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.1:email,0.0.0.2:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 088C8280B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/9/26 7:37 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 09, 2026 at 03:24:15PM +0000, Srinivas Kandagatla wrote:
>> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>
>> Add device tree support for the Arduino VENTUNOQ board,
>> based on the Qualcomm QCS8300 (Monaco) SoC.
>>
>> The board features a Qualcomm Monza SoM and integrates various
>> peripherals, including:
>> - USB Type‑C connector with dual‑role support
>> - ADV7535 DSI‑to‑HDMI bridge
>> - MAX98091 audio codec
>> - 2.5G Ethernet PHY (HSGMII)
>> - PCIe0 (to onboard WiFi chipset and USB bridge)
>> - PCIe1 (to M2/nvme)
>> - Button (via GPIO‑keys)
>>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>  .../boot/dts/qcom/monaco-arduino-monza.dts    | 446 ++++++++++++++++++
>>  2 files changed, 447 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 6d87be639aac..8a9093c4b534 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -47,6 +47,7 @@ lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
>>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= milos-fairphone-fp6.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += monaco-arduino-monza.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>> new file mode 100644
>> index 000000000000..b6db2a7151f1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>> @@ -0,0 +1,446 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>> +
>> +#include "monaco.dtsi"
>> +#include "monaco-pmics.dtsi"
>> +#include "monaco-monza-som.dtsi"
>> +
>> +/ {
>> +	model = "Arduino VENTUNOQ";
>> +	compatible = "arduino,monza", "qcom,qcs8300";
>> +
>> +	aliases {
>> +		ethernet0 = &ethernet0;
>> +		i2c1 = &i2c1;
>> +		serial0 = &uart7;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	connector-0 {
>> +		compatible = "usb-c-connector";
>> +		label = "USB1-Type-C";
>> +		data-role = "device";
>> +		power-role = "dual";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				usb1_con_hs_ep: endpoint {
>> +					remote-endpoint = <&usb_1_dwc3_hs>;
>> +				};
>> +			};
>> +
>> +			port@1 {
>> +				reg = <1>;
>> +
>> +				usb1_con_ss_ep: endpoint {
>> +					remote-endpoint = <&usb_1_dwc3_ss>;
> 
> No intermediate QMP PHY, no DP support?

We are missing firmware support for this, it makes to really drop the
usb-c connector node till we get a proper firmware support for this.

> 
>> +				};
>> +			};
>> +		};
>> +	};
>> +
> 
> [...]
> 
>> +
>> +&pcie0 {
>> +	pinctrl-0 = <&pcie0_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	vddpe-3v3-supply = <&vdc_3v3>;
> 
> Is there a wired 3v3 support without an M.2 slot in play?

This is going to on board pcie packet swtich not to M.2.

> 
>> +};
>> +
>> +&pcie1 {
>> +	pinctrl-0 = <&pcie1_default_state>;
>> +	pinctrl-names = "default";
>> +
>> +	vddpe-3v3-supply = <&vreg_nvme>;
>> +};
>> +
>> +&pcieport0 {
>> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>> +
>> +	pci@0,0 {
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		bus-range = <0x01 0xff>;
>> +		ranges;
>> +		reg = <0x010000 0x00 0x00 0x00 0x00>;
>> +
>> +		pci@2,0 {
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			bus-range = <0x00 0xff>;
>> +			ranges;
>> +			reg = <0x021000 0x00 0x00 0x00 0x00>;
>> +
>> +			usb@0 {
>> +				compatible = "pci104c,8241";
>> +				reg = <0 0 0 0 0>;
>> +				ti,pwron-active-high;
>> +			};
>> +		};
>> +	};
>> +};
>> +
> 
> [..]
> 
>> +
>> +&usb_1 {
>> +	maximum-speed = "super-speed-plus";
> 
> Do you need to specify it?
It seems to work fine without it too.


/:  Bus 005.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 10000M
    |__ Port 001: Dev 002, If 0, Class=Mass Storage, Driver=usb-storage,
10000M


> 
>> +	usb-role-switch;
> 
> This should go to the monaco.dtsi.
> 
will move it to base dtsi

--srini
>> +	wakeup-source;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_dwc3_hs {
>> +	remote-endpoint = <&usb1_con_hs_ep>;
>> +};
>> +
>> +&usb_1_dwc3_ss {
>> +	remote-endpoint = <&usb1_con_ss_ep>;
>> +};
>> +
>> +/* Internally connected to the MCU (e.g. for DFU). */
>> +&usb_2 {
>> +	dr_mode = "host";
>> +
>> +	status = "okay";
>> +};
>> -- 
>> 2.47.3
>>
> 


