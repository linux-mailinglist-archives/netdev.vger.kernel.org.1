Return-Path: <netdev+bounces-265994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGJNDIn2r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-265994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:46:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7019249955
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27CD130349B2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE0E37472D;
	Tue, 10 Mar 2026 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3+kH3OW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zxzo8RP4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1E371043
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139589; cv=none; b=CRpEB62Vefev3I4NfTAVi0uVGiEkyhEQ5yfZltTSzCGYShbg9mWACNk1c+GAPKZzji1DXctLo1urxS+75JzOfYVVR9F//JXe88Q70HELF+vIs8kAWyzViFwZoMcQHXxqCRITBQNjjytEo/2sRSEv4jnyKDyprJ3Qlgr4hMBMLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139589; c=relaxed/simple;
	bh=giejrRia4jPNnibbJiSYVAKFlFcXgwDtalJu++xZ69Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RozIz0cxCtZ/4avHwO5iBDfs6W5/giBElc7JiIetn93kZoLrbRjZgq0molYrgReUlzi+J6uJ6a5R0f8emStjdTt6h7FGj+dKAYWSaemAPJWTHBdv/AeR1P+nmjA0N/jJO6xVwMtSX+r+ZqVbK9jvxgigYdahm6m0prUymI5KVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3+kH3OW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zxzo8RP4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A6VL9K2021448
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WbD1AUBT9zmYKBHovxWsCgqbkDb+tmjWhMIAz/MeuLI=; b=Y3+kH3OWhTx8JEv6
	/0q2sWVp36Z58fQ8D/RMizqepY7RZzlWlk4nSlsc8gMVDD3x38vH9mfXgXTXKGJQ
	DjZMyKIIu424+WO3zpMuWjXbDiqIaCIq8YmSJrOkPp79O1EPC5QOCkdpH6j/n2WO
	iSb46Uq/Bi7DOD8+Usr6FTmC/Qy82ghLiFB/G+POMilXn8tZbvF8XxqVOAwB9oLQ
	Po0abtoH9bbSK/xpyU1KvqOXBb6iu2M/Nu1nsnqEs047+36IMTicCtAJPy6IG+jC
	LtFeu6WgVbuXaB88r+psdOXUMteUZ9c5gjL3u10XNdP+YwFbl0d1t8GFysqEWvIQ
	MbVmrA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cte3w8yh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:46:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd8dc8b434so121644485a.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773139586; x=1773744386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbD1AUBT9zmYKBHovxWsCgqbkDb+tmjWhMIAz/MeuLI=;
        b=Zxzo8RP4ddcHRotQyMRXP6GPwmjc+/GBf3BXImprcAGonb7DLDLnullkZ8JSKC+SFt
         epb+tFWolJVzgBdb4zpLystahGgnPKpcTCGkOT8ZkwOa3LVALD4b+Ridvk9Naep1XrCh
         NaXmvVbzMeSxtNHgBr9a5tRM2zU+Gtx9uG1CfTQd+jVNlQy18MKZGNy0GB8UPPVgezaH
         SFdsXlU23z71ovZXH9G1YC3HuYIheYtHfGIS/rVZyubOsMK0bxYbe/U/+uoThBilE3FL
         oxddx3mh+0PoZSqXY5zw+98rY7+Ui4Wy3ZO3/F4YzqGTMqxUl0uNnRxf3gEBnqrtvWJt
         i4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139586; x=1773744386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbD1AUBT9zmYKBHovxWsCgqbkDb+tmjWhMIAz/MeuLI=;
        b=nMNyD0fXd17evBbbJno9mxLsFu2VnL9VJ2icLlySPqbTePOtnyO+u2UotUen2Nlr4t
         P6weRhE2gLZZxRF69VZk9KYElJeHGYAX3TmAoyB8EBzKRjqprZOQy3jC3vg0sVIg43g0
         XsS0cVyrMTCRexMlxA2zxtzkiPgT/x0f+0RhfzgcDyxqGLEges5bboDuyMmE50PsDERp
         GZgaiGAyF0KVZn3SHWnSNdw+gFSOP62V8meyL0kq4ujpuvfjPXMMPyOLuR6tm4eivpKX
         cqt1ohcCR0oC34kb6Q7F9SAipJUyBpVccZ8HCu2KS0wwliyUDwL8domhym5Px1hmsqVc
         SShg==
X-Forwarded-Encrypted: i=1; AJvYcCWVMwm6mirUfnLiVys4OCqVv6SjfszML8ml7RVm4AEloYu9IqJw4FA51x0pnm2Kh7P/IdHDLZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQq0VJ1ORa/CNx4UqMz9av0mgbfHZtohAFkoBhBMKzuxdkrzFJ
	PjYXAsnrHhrH0bEp396IX7jMLOToIgRIaIDUcL8V1pM8FCGzAyiv1TO0MXbcotxYbkRhL5F76VK
	vm/HicKmgwPT0saXJpx2uBvTdHjCdHWqOXJ1HwaYZyQ8APxIjhGimV6dNupc=
X-Gm-Gg: ATEYQzxowZ87kBxVyAZWdHi2pk+c8z5JYtlM/NG0cXafwad/wI4Cbpsd2zWKK1fzD8e
	afbW8av8MKAbj1id8nowedkNjL3QPwKk5MAV8d6y9VX8NpA/qnTDWQ8zvVep1gVrYuZrMOWe0lU
	zCkfd8ycMhbeI8BunGLYy2P6EZw2JcAN9Wqops13L4sDSw6+G+3wFLi06qUG9UuWbPIofFdgacw
	Lt4aiJxp1pOMeQ5b4FVRjNsIcWHuNgjZxOxK8SQ/I7d9S+CWFgCfjgBng1rSlJK+33vX1Bl6dqW
	IyfKVP1SaedeDF9nCKVFRcCQF9virxuoOjjygH62sJVO2svtZR3K59F4nh8eg/dMeKAaj1Es89L
	vrY6ZL/NI5dYHxsz6aNCCW/EY9OzgNRtZ66O7c0XSjz8QFXLMVamRFMPFH5iHLWkDcmsWptz7Ql
	7NkdA=
X-Received: by 2002:a05:620a:a28f:b0:8cd:86d4:648a with SMTP id af79cd13be357-8cd86d4668cmr553530385a.4.1773139585930;
        Tue, 10 Mar 2026 03:46:25 -0700 (PDT)
X-Received: by 2002:a05:620a:a28f:b0:8cd:86d4:648a with SMTP id af79cd13be357-8cd86d4668cmr553527685a.4.1773139585553;
        Tue, 10 Mar 2026 03:46:25 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f18bb33sm476643366b.65.2026.03.10.03.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:46:24 -0700 (PDT)
Message-ID: <50392864-dbe4-43b6-a4cb-e6b6b5b49a57@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:46:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: monaco: add dt entry for lpass lpi
 pinctrl
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-6-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260309152420.1404349-6-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MiBTYWx0ZWRfXw+EMyhn/CQAV
 obl/97qblZXiW3BRe3p2/UljTAyUnhqvWjQBogK0DFDd48xYnrp0IQCJBMcieyBtTCtxFIhrQ8f
 slspjFV+RP7MLWwotMLCZ24dgIHXY3yHh01aUyfzh+5R90iKqpBGLoGFLbQrEimcTN1mb/95u5+
 DbiYhKHV9XWcYBV3oEgxQvepajXh1fpjQDyOekbC13XKwSuxsNCcF/S+NoOmR4e6JeGj9T0QdLa
 c8CjdyY6uKEqiRhY1ib3aey1j6I5seVuugCRFXc68+CpYl69lYX7xpgWjcebnjBf2CC2Uz6TH9g
 Apm6h5LegHz0C2s7aOXIuzt29VLM/wGYNj/V7wMDJD0GuHqGjjjn5m9t42K9cKzf7nnwyl7hPQ1
 H5++csOTaQUVwNvM5T7fZYHDAvMxM6tflO8Br9wcZjggW77J26/DzRBgsbUpRr9Rg1UDFKMzJSD
 N7MxQgXpmYLCtlCgBFA==
X-Authority-Analysis: v=2.4 cv=GtFPO01C c=1 sm=1 tr=0 ts=69aff682 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=PSYRucXItuZ608vo30QA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 2BKgy5k1ZChAxB0Rf23JVmzPHlPon6CL
X-Proofpoint-GUID: 2BKgy5k1ZChAxB0Rf23JVmzPHlPon6CL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100092
X-Rspamd-Queue-Id: C7019249955
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265994-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_PROHIBIT(0.00)[0.52.125.128:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/26 4:24 PM, Srinivas Kandagatla wrote:
> Add LPASS LPI pinctrl node used for setting MI2S and soundwire pin
> configs.
> 
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> index ce1565c7cc3b..0727dbd44a75 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> @@ -21,6 +21,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -2872,6 +2873,20 @@ q6prmcc: clock-controller {
>  			};
>  		};
>  
> +		lpass_tlmm: pinctrl@3440000 {
> +			compatible = "qcom,qcs8300-lpass-lpi-pinctrl", "qcom,sm8450-lpass-lpi-pinctrl";
> +			reg = <0x0 0x03440000 0x0 0x20000>,
> +			      <0x0 0x034D0000 0x0 0x10000>;

lowercase hex, please

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

