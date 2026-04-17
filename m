Return-Path: <netdev+bounces-279261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDrvN4jt4Wkj0AAAu9opvQ
	(envelope-from <netdev+bounces-279261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779941892A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E72F03042D68
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450A3A3825;
	Fri, 17 Apr 2026 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyvDIrnk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TQcOnZ71"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B024377EBF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413798; cv=none; b=ZGNAcgu31v5l4YZ6W0ezSopyEd/PG9vW41lTpP3c8jcUoWH3yT2pshILRhkeEYkNB/OQz6eYMCj0ui77ywt3hfxwvXb9j68eHkzwZ+NDjX70RATIVjakBsm/RhEaZD9UUWDPZpNFyPdoMJQFTt6Mna3LEFBl8KllnUDOqrYUabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413798; c=relaxed/simple;
	bh=RKY2A7kQUG4Vyi0JdkewaYZmzvqOE6urqPDc4FCyexc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL0rp1eF6SFwtguKslYkmpUp92/9qgY7kb/v9ZDx4UcqdyCN1hS2Cw0vtutyIAf3rLUdcsak1wcli79b2n58JOIR6MbNpiy1zSotFaO9RtrUBFAf8pq7sXyCJnWTDyLOPwOde5KSwicGQROjZ3qBi6gf4BhfeNoejp3vJ9yG5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyvDIrnk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TQcOnZ71; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H7Z6Mg2012082
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fKKtiLeF0L20pmIMzyjroAV629Hy56qQv07GTI/Es90=; b=SyvDIrnk9jeKdhO8
	pvOHtbSPffdT+heP01d6bwG100czvaG4QB6vOWk/D7Wv5xX3C4tBr4aDoDok6tPk
	HuEZu6hHCbGZEhcljGTYXDTHVGmsDG5PfRp+d/s5hdSlCwB72y/djAMpnQKZNKxf
	oAQAGN50rcE2/gihfixOggFapsSSTtt3YtOTPdMh7r0OHELjpDLrntwtH51JZBqL
	yxvmgaPdmLWBZ+DF5ddzjv9K4P5BoLwxW/aSAXBZXytH5ljK8NUjt/Dj/i6/n6uI
	gLulQbJVVi2T5WxXxb5Gg9aeiITJA/YD/P8RAyDSayboMkiK3JKm3ty55YngHNI2
	XFlt8g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djvrfcejw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:16:32 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b02ae267a1so583936d6.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 01:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776413792; x=1777018592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKKtiLeF0L20pmIMzyjroAV629Hy56qQv07GTI/Es90=;
        b=TQcOnZ71Xyne2xbpDRpAkGLxUR2dNEhz4bSGTsSyhkQlN+NnVTOfbp2nRSMQpZPQu2
         V2A2AJ9Kh9l7BJbr3DBVSbFc4I8cXhG/Z1xZSK30GI1wlSGX+K0IH1H4RJvTD2iMq+Uh
         08obGxTbQQo5OOchkLJYL4UD0Eb0sAmKM0/n8FRzdwiDZbLGUzZAvG8ET/PM+6TZjzno
         vrFysyryR5kBC5InbNQsH5OWxKizD2ajpR7DQDRUcSR0NjevBKI69HticNymjhiLrDKv
         AxW9ncu37V9+hTLHMxPucsbd8FMYsv9fIv7tu+2RfE+PPTmEa7eJ39rVyOSTsDQEd7CF
         KaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776413792; x=1777018592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKKtiLeF0L20pmIMzyjroAV629Hy56qQv07GTI/Es90=;
        b=jqPgH/K8b0zD7LV8JgoxqPLJo1eAbXajNYF8tIm1lC6ncSPTdrxKgrOtLoelhmoEbd
         U4z3OJKVEBViYYRW6tnFyEUq0+eSdwdS0tKkxIsLgKqLQ+vKjdCDfEjw9/iuc1y87Fqh
         PvjWWfRJP+BGHYiG3IwzNBd0IBGc9/Z1RVXIZnwdkGkccYyOes5Vicf32hvVUFtpLV1y
         z+6SQFSxHCtwzYSecYsMD71Bo+0PTQX/PSaCQcdsRTDDwCEdUt4D+AHGyc7mIsZr9NH+
         oM14xJyg+J5wyP84cr0Wpg1SlaDdkNWAZV6YR8d6T+x/qrCJxsT6GQ0f5LA9RdzfLY5/
         xaZw==
X-Forwarded-Encrypted: i=1; AFNElJ+f3TLSLMDA305YkACEqCkhiglctQFGupnsif7gyBPeQ51lfbZQzOBNc43Up7jA4r3T8VkBgg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwikmMliwMLuUC+Ntx/fVWRuvSZWa+DkJkxqDLVUzkeJeGORYEe
	CTiBcnn00WlqsY7R3bDmI10lmECHw2yYCMLTWut5hQjGvdK3d7xUtrjEQJBjezHJgqaIw3EjSUZ
	GajOTCPSy/W0LxhqOJHs1Atu+BypP+TF+/XpVeCTO/PoLCEfaKO6cIXLiGD4=
X-Gm-Gg: AeBDiesI07qZJ2tbTP9HMqD+HhX8LE2UvQbVRFvVsic3rxPmDXqztK9obHpYUCl8UWe
	g+oPHPeXNXIjjkLtkne5RY0vB2BnUdKdGVXAH7kjrI3NAcuvTsTzF1X9f4EfhgCo2OdrZ8xV3dc
	QBWMoNbnWCuxjJejH8rzMqU1zuyAfIMAOStbZs0d40/DNCShKqZkcNaSKTH0hugFMi8VgS3SBzo
	lKnxuGQw4SW2o/sTltwvcyVD+0O9p21AdoZh+NcyOjDVH2RO5A9AjeZzedI6Z0RuWVhRiW9PJKD
	oreTvixCRnzFEhV1fds8RPORTJ5hDBGJ5qFv9W958vhTB/xqJ6Dum89G7BSuGAvq55t7RI1l2mo
	orYzWduXfBDReEn0lQ2e6cte5ta05A/l2OdYr1bPtL+yUSps87ugZqf7Mxxwn0Lvl4LvN0B8zVM
	LMtEm3KyXRKWByEA==
X-Received: by 2002:ad4:4eab:0:b0:89c:5159:ea52 with SMTP id 6a1803df08f44-8b028181327mr20534596d6.7.1776413792351;
        Fri, 17 Apr 2026 01:16:32 -0700 (PDT)
X-Received: by 2002:ad4:4eab:0:b0:89c:5159:ea52 with SMTP id 6a1803df08f44-8b028181327mr20534416d6.7.1776413791886;
        Fri, 17 Apr 2026 01:16:31 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bab1sm29948566b.35.2026.04.17.01.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 01:16:30 -0700 (PDT)
Message-ID: <8b5a49ec-8120-4bd8-8aac-8ba1ab3cfdea@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 10:16:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-bindings: net: qcom,ipa: document Eliza
 compatible
To: Alexander Koskovich <akoskovich@pm.me>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260416-eliza-ipa-v1-0-f4109a8e43c4@pm.me>
 <20260416-eliza-ipa-v1-1-f4109a8e43c4@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260416-eliza-ipa-v1-1-f4109a8e43c4@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LlwJbleo7ngN-CO5wY7A6ruvUAf1NZ4W
X-Proofpoint-ORIG-GUID: LlwJbleo7ngN-CO5wY7A6ruvUAf1NZ4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4MiBTYWx0ZWRfX5LjGXQZ0i1zY
 y/ibIp8BfI6l1O4QevvNBx8nlnjPnqhdR2D2+FG4lUzW2xHrcE3nrlPDGqEE/CDSEgyqjcsKDYG
 dU/EWQPJ7qIzhh3Q1Et7m4/dkBg5i//GNZwT4FNcud77lOdTW5mvKU88aXLrpg0PmPe11ZKpP69
 zKS8lR8p9HkBBVpyYLuIng64jaLYTRrb25/tCiBgKknXThs3Hvb3YQkhuhKwAxxQ388x8vuenEx
 qZe5DXk6c4NeSGP5BxEpZEq/GQZh/eYWwlikpR4q0Q6yFzNvvyoL492P0rk9D1zogidTTill4kR
 qiKCwAPw1yDIIcBXGeVYiey1E4EsbZeBg+8XXusxXFyU6Kw0PcHMXleAoEzrmt63Sy5iRay6yOR
 +GfVW/TOzD1MXML3Pqw052EM0Jn8Rdqg1JP5DB6XYx6LoA+viofmAdoxtt3FZx6XKnXvEH0WDdK
 00cQ1DGr01ymG3eLVPQ==
X-Authority-Analysis: v=2.4 cv=YtE/gYYX c=1 sm=1 tr=0 ts=69e1ec60 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=MrVSDPw3tUfsMvSpUigA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170082
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279261-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pm.me:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2779941892A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 12:40 AM, Alexander Koskovich wrote:
> Document the IPA on the Eliza Platform which uses version 5.5.1,
> which is a minor revision of v5.5 found on SM8550, thus we can
> use the SM8550 bindings as fallback since it shares the same
> register mappings.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index fdeaa81b9645..38a5a337c34f 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -60,6 +60,7 @@ properties:
>            - const: qcom,sc7180-ipa
>        - items:
>            - enum:
> +              - qcom,eliza-ipa
>                - qcom,sm8650-ipa
>            - const: qcom,sm8550-ipa

FWIW:

8650 -> v5.5.1

eliza
8750
and a couple others
-> 5.5.2

Konrad

