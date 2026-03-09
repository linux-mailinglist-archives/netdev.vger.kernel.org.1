Return-Path: <netdev+bounces-265667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO2JO/YIr2lzMQIAu9opvQ
	(envelope-from <netdev+bounces-265667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:52:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 745C523DFDA
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9CE3039ED4
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3D2D0C99;
	Mon,  9 Mar 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQcmXvXf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CziwBWvK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8627FB3C
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078435; cv=none; b=QSG9LUWM11BV3n/Xh1/tJQf2DJ9b6VQSalqL+5kFeV80qi9TiCo9bDUkesigylFzKFtfY5nD03NL2IOnp7qHMI4kNW0+4gpead+QfhWhlOZmmXfuCBb0t6p10AMl2msC9FrrX8QAThL9t+WRVYPDZ6ZolM/Oxs/iSMCPr0/tkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078435; c=relaxed/simple;
	bh=amu4C3+KJMcTnDyB1qFK2SonJmt+nIs3bCqcU7NAbRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ5bNeHkNu1PuQtjdT2ePh9ekVA41jrg7fWfxLxKMKXh2wcqVB/PlRF9Y+QUO10qrTAlUbB29YMiH0qmiTLMIcvOPSIKxaek3vT1aMJCK40OUZtvWeWvWU0WKB1sn3pRw6cQLncj494BJeXzLw+IgFnZcXBNhaCvDCmLe5gg3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JQcmXvXf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CziwBWvK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBkkl859602
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 17:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AEVmw5aPLupuoMRwd5bF0YyKWjnchf/iJOwFvIaVwxE=; b=JQcmXvXfIYmOhCDK
	+xTle3Q1wpg6BVDtPRi3M89imTxtkUH6FY3wbG7KggMgUOfakyYysXUcQzYowFIH
	iQLeW9NUjMB89wzVm52zGJGALZHc/1sPQdoARN7hXF94WdfXPv6cpW8mWnz/2Xg+
	GZywC6p16ItDr+i9fHzyLrH45gSfvbGlQC71kxHywOC9rjl3d5k3fqCsk90gv+iY
	PSgt/nw1teI8CeK+xllc/4lJdT+ehfbFGlkEE2hzEY4tXd/JAoDKTrTaVO63LPTb
	5YPNNhz4Q8dTVwuzul53eTRlDvSOOELxlSJkuj2/LQGui/FlFBttg6SQPcrP+5qZ
	YNSNNw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyhbrskj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:47:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd722c1a69so1478386785a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773078432; x=1773683232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEVmw5aPLupuoMRwd5bF0YyKWjnchf/iJOwFvIaVwxE=;
        b=CziwBWvKa0DR/6RSfZId19E7zwFb1cWWoEc0cvJ47Mzz3QvCW/kr/v7gR/7CPDvv76
         zkj28IEwK+17qjyvOEPcq0lMDflLCoFTxIDz5XaJePkZqNHwINdYUB/2fl2LH4qxuLjG
         4i8aeGbRU0Bv95bSVrSY97fQHWJq677/dX3hUh3l9rL8UAXfJuH1uNa2uYX2K4UcKEUi
         eFPAPwxWee3udSDrWOk1z0A1ANGwC95LKFwOuhOpQMrVCZlCO/eknckHZ63EjerDfPLo
         F8Rq7Vs+1JGnTBEjVd0JY+HoTz7YBhjTJkMMZnKRxwJyA4JKNvRbvvH2/YSpG9diCQQd
         xC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078432; x=1773683232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEVmw5aPLupuoMRwd5bF0YyKWjnchf/iJOwFvIaVwxE=;
        b=C+JXEmU8Hr/nJd/G2Ilo0pyxXy0lRzvLo4CAF/TVKkzPLBxDxrxRS3cG4+2lCZslFU
         5XRZZw5ffpqeT43jAKI7NKLGRVFayTkaH0tbNOw1sMjOYO+dHxN+EXzHEbIjLlMJKxJJ
         f7TtmWcyWiq126IM/s5msV4Z5EghJ6B35GtKmCMy56GM/3bW+iMX2pRZGaGLzB/hfyNO
         cVmJa2/DWMEpha9wnhK4FrK9ulzCgIB3zgmsDGxnXbDBntrd8bLprV2X5xMTIXvatWRs
         6rfEZTYBGahHbkS3Pe8WcOWZtwuoH5s/uzws711ZgbP6LRLCfIPQG//WOLI7o+5g1+DD
         TcJw==
X-Forwarded-Encrypted: i=1; AJvYcCWx4lOQcZMMITrLmpvwPuUtykSHYrSGtTrZgneSXCsOhNZX1TajDLl3Lc4bwSa21xTKIXwSzTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlg6JmktQ0hibRvVaoGrH9crDZOeZfKnlYlFOX6lY4IsktLxjn
	T5/RPRfmskSan9bOrRqQacCUGSX0Yem+Nf5bwIFyvaGmv6PGs9Sgf02UJAErEBuH3U9FBfpCHD/
	7mYuioPf6iRVWMxo5FmqEsSuvQTonyMMTa7AfvmhSDnu/xXI3iSY+5MpEam4=
X-Gm-Gg: ATEYQzzoZa2pGBjgXdbBhUpOMFsnf3Z5RQsXCL3xMPKZ6tqK4BcxCBjMAOnSJv2xAwb
	CVnCGdhhtEmT9x2A0ZhIq81ZdV59OU+9Qir/c4cf/Tln9LrPZo5he0WbrlqfucZE40p9svIe5SP
	wYQRCqBoI03QvNU/6oLjaFPNDjdFcucQXjK1tOdNUUifF3yW6cDMqYUaUVrH/VT9k/e2c9hFuvd
	c7FENU8vMzjRPxNmxw7nytEBAKSn+dnRPqqDQKPP/No1XeK1hCpEoANhVPTy9TLGG7LPdaGdEEh
	bVLoGYj9QM756nQ9t4SGxwO2g2NYopm/R4GxEVsid2qsvZgiw9H9SExNhWcOErfOSZdC/P6V1x1
	3jQ2p9JWiaAMjIXgkOZlibEbMwKzBv3C64xdNHvM4SccS5wOP
X-Received: by 2002:a05:620a:1a8b:b0:8cd:8938:f015 with SMTP id af79cd13be357-8cd8938f423mr566094385a.51.1773078432603;
        Mon, 09 Mar 2026 10:47:12 -0700 (PDT)
X-Received: by 2002:a05:620a:1a8b:b0:8cd:8938:f015 with SMTP id af79cd13be357-8cd8938f423mr566091585a.51.1773078432132;
        Mon, 09 Mar 2026 10:47:12 -0700 (PDT)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-439dae56300sm27867521f8f.37.2026.03.09.10.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:47:11 -0700 (PDT)
Message-ID: <36bfa98b-05fd-4788-afe5-f28751148889@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 17:47:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] dt-bindings: arm: qcom: add Arduino Monza, VENTUNOQ
To: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-4-srinivas.kandagatla@oss.qualcomm.com>
 <82b23341-d0ac-4b44-b50d-ad0eb5509974@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <82b23341-d0ac-4b44-b50d-ad0eb5509974@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Rcmdyltv c=1 sm=1 tr=0 ts=69af07a1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KQ5Aj9_w7GlCoQvhwioA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2MCBTYWx0ZWRfXyHZ3+cE2qrCP
 Pu2omXajm0Lghre05t8NH9UqCNbbeHpSixgyaWSJ6uBqP1LxOV/kAOS8GOTO3ogEtwRPIun9RH/
 tIR6ey9UxpiwxQKhnQtT82QSaIhHS8aXXZhuUcdBUp1t7CorcOaZOvFYmHmssPUhUMSnZoyqakH
 paf6fR+ZsuUuyyc1WE0GGCW7g2fI5AYvvWHWvz92pbgdGrHrTX94u05GNbVmDBSXglIPHp0aYfM
 /8WQfVrine9bVANEP1/uekqE5R1HkyiSX4KO02rdcDwnqx7tihzA3LftDCOLfeKYV3HoW4YMPnm
 D0FuWAJCd1AQ5XcBZwJx/biQAjB7SBY32M8hzDmQEUf8IBAOqnPQKWt7dbpTXxmTNwId3Et672d
 Cvq8odoV439As0gBdKmckqOA1EW5VLOxfxIClr0ctqIUXuqAZJPoDDa33JcViNDZuAHG6QMhdOl
 kG9bgXveTYUsTajSpBQ==
X-Proofpoint-GUID: MD7mO2XekTJhdQG6IRemQqc5ilExbjp7
X-Proofpoint-ORIG-GUID: MD7mO2XekTJhdQG6IRemQqc5ilExbjp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090160
X-Rspamd-Queue-Id: 745C523DFDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	TAGGED_FROM(0.00)[bounces-265667-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/26 3:50 PM, Krzysztof Kozlowski wrote:
> On 09/03/2026 16:24, Srinivas Kandagatla wrote:
>> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>
>> Document Arduino monza, VENTUNOQ codename. It combines Monaco
>> based SoM with STMicroelectronics STM32H5 microcontroller.
>>
>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> I wonder how two people were developing simple one compatible change and...
> 
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 153664da91d9..2edef7e86175 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -890,6 +890,7 @@ properties:
>>            - enum:
>>                - qcom,monaco-evk
>>                - qcom,qcs8300-ride
>> +              - arduino,monza
> 
> ... still place it in wrong order.
Thanks Krzysztof, I should have looked at this carefully

> 
> Best regards,
> Krzysztof


