Return-Path: <netdev+bounces-268102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GYMJlPet2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:41:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFEB298093
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A7DD30078CF
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972538D6A9;
	Mon, 16 Mar 2026 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b5c+IPVN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chlPI7Ml"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA33451BA
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657555; cv=none; b=ayx5/aJQS/vkjevgQt18YE9hVC2t3QV3okW47T5ZruNahips1MWbpg/tEAa02Yw81+43thQWbXSAYmJ6BD5pplvUP+xPgFcNv7LSa8Kh0USMtIhyZHTMh9NBFUoL9xGoij4lyrsRBSJpQyT/D3PqIxs7M/A+ys93m7WJMPj02aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657555; c=relaxed/simple;
	bh=AFfI40R+WNVkpDzns7gNsGJaNp8GbnCbR28Yd0xU3A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqTQTEEaTDLQOd5Z/mWQOdxm+WTvB/O6Cq+0iz9IewMenL5p2RHIT+d5Mn01q6KAop4fx7R9BNXbBIUFjPkP/P6kWXAh5zGTIAVnrs4HX8Xx7KkOb7aqQPgfetxsrsW1AjNrMz4zuB48INcVvzYfZ5wJHenHoDMVyVtR4+c5ELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b5c+IPVN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chlPI7Ml; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64gjM2128555
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t60rKOeCZ7se+qnknJ2HOKTEie+XoswQYPSGTZuaCxs=; b=b5c+IPVNm6vW5vHO
	BdMQrIw2kIeyoo+uyOhWkAiQ2E2wHqOiVPYfzVCgMGXEGOCTeQMSMjAjskYhcppl
	WjGwVMaxUHTk4Slzds9AM0tibBTqqqKIyd6t9oSBPFNHT1YIvi5tZxJqy4wtopOF
	1d1QxPnAuO7vLbdwh1b6KT0tQyA8nY4zqM+avcrWJKRf31cFcuS5Iq9Pmuq+nEB0
	tRSBt9vh6PuYGBrW3xS6GBVKr/v0f1WTPJRgsIiA02ge3DDsXVWVLTbBSh/uxwqo
	WqMx7W5dQty47gMUwhfq8vHtuXC+jF4+1C0KmjBbmH3/Cow7O5lpQPR4zDZpqdgZ
	cGgVsA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00anbem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:39:12 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89a01982dc5so42663296d6.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773657552; x=1774262352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t60rKOeCZ7se+qnknJ2HOKTEie+XoswQYPSGTZuaCxs=;
        b=chlPI7Ml4oOxMuJj4zaz+VaUGxmvdlkwmIMsyizieufl/2GTbre3TrZP+CJMrnEmdm
         WxVVmThMeWS3UPbl1kRvtQBEvc0+y/4XZiuoAM0M97Ox6Ixkt/6tI6Ojjbfi3CMht3uV
         cml9wArBB/3pLrdSz5KCCdaX4kJYSju1sV1wcn46UPHhKIU+jUwjqAwvjKV9q+IAPnLO
         TkWTLVWX64OW5CV0CiGZvgmPm7IQ+mrvmt5Cs4p59a7j9/pwCfFmONjGxMUHT7ncVGBj
         PaGYWN2cIsNkMnM1P5pm9oxRlzcoOZO1pfsgcPSVKh91e2ZSZWO4lZV9FHCHXnwBnHIZ
         cbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773657552; x=1774262352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t60rKOeCZ7se+qnknJ2HOKTEie+XoswQYPSGTZuaCxs=;
        b=K7h+fFR4Nwfrtg2mMTNaiTQuEDkfESE5CZrSVpq28D9YRqvSaGQ9lHEgU37qGTtMhF
         amvwUmclE68TNduDHdUmB3bAQUkWEiRHipG4V4+0SflaHMU2UDzX1jlE/Zp/3XSNiA1x
         e25xESWjTplV7vwOCMYIt8OoxHifuc6nBuPTyHz/R8q4dWIBin4CUmDaY63pBU80wzUD
         +9jQChC4T49XnFAStw4FECDy7qUha99NXAbOk0MavA5Val1EwhgFDuxh7lGwwtK/KUjG
         rEZWmXGt5t6AexHljan8CsIKVA+OTMBcCyT/LeBrXXmfDZ9FD9quDCsJkBz/VWtGocK4
         tdLA==
X-Forwarded-Encrypted: i=1; AJvYcCWb3GSW0bsDhisZlZ2tSm5bXI6hDERkgJZiC2X4ILbxGNEh5712Aza8r3EYZ3O30Dvh1CfCOZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJReHh8qCVel+AXRAzYPeVrTFwmNgjv0GmGA2VfzDDvorUeuKZ
	7lVkQIU7Wmpn46+YcsIEksRzJP5TqO+CMjl9wy8M2LWV6STu1VWjsiVvjvyfpPvAn8flOPhDLcr
	x5HillA3SG4KwBWFm/oi/VU27pBgzVD7iNQhzk282so3EDasazXtih6tL9V8=
X-Gm-Gg: ATEYQzzfV77W99H7uSv+Rzp3dAqmisjqFj7KihTrARyetlS8kuJHeVOFcMhlUk7xSX1
	QMyLMjkWo6cgPg7+cMHmm3X6V6/3GdNZAgxG6cmv1s+wkixSeD9yrF5/8J69iuu4vE5n7SS/tjG
	OYIDEk0lO32xFsUhLToStwptxjnegcbeSE9uzbS4j03xqXyWJ0Nbro58qdu2WoO+JxLOmSagiVB
	q0iRc9CY8xCZZi0DTF5ZIQCQ3FvCNzsU1e38xMTBqT97BtOdZXabxgOMvB6BB/aJfBNYS8HBF62
	TcZjJvKzrWqLbFcaFQOXpWaCthYWE0aaX+wFO+7QGqJLM+4uq5wf8WQqTCN7FCXWxTXl8BV/NS4
	efY9ao1Hh4Dd9snqp79fjan+ugEtrtqO9mVg+N3Z5jbKECuPt85wuXgKVEBvw59/BKt2JCpdy0m
	/inQU=
X-Received: by 2002:a05:6214:4c46:b0:89a:4fd5:6998 with SMTP id 6a1803df08f44-89a81ccc828mr123393376d6.1.1773657552421;
        Mon, 16 Mar 2026 03:39:12 -0700 (PDT)
X-Received: by 2002:a05:6214:4c46:b0:89a:4fd5:6998 with SMTP id 6a1803df08f44-89a81ccc828mr123393176d6.1.1773657552041;
        Mon, 16 Mar 2026 03:39:12 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cba6eacsm550572066b.14.2026.03.16.03.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:39:11 -0700 (PDT)
Message-ID: <7e575228-60d0-47dc-acfc-90489a702d1a@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:39:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: monaco: add dt entry for lpass
 lpi pinctrl
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
 <20260313103824.2634519-4-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260313103824.2634519-4-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z8FlQh-VXXIRbIkdDNNDuF6N0Ol0scLu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4MSBTYWx0ZWRfX8Cxmp2fQkRyf
 CkUDx/N2W55yE/2//mUhSTIk7GZ5dtWm7inxFvSLNHQnR2cshd02CukVCpBUfheGGTsnjbFCRzo
 pQxenTAaGMmYVG8K5IBWr3RokObg4EdloqIRwwHdlMSE5+SQNySFoyuv+RbmYxPBLMrFGcI7MC4
 CvT2J8eDA/2j4g3vQYGGh8RWachfQng8kZWqkCnfJN9yTq1/557v+5lqbV7PyhOW/qfIkv4yhjw
 2QEjNhgU2mviHq4nsBTDw0+QyMTURXcL8YhNvRN35SB/ly50cdgv4yyOo9ad4uhvl1jsZu5dRmn
 yUJ0CeSytW9eYbO2Sph4+K+94KIrsR7OnvE5qe9gN0HoW/RDWod/V4/S+b71kJbVvOtqAoSM9TE
 9o1vy44BT0k2JHSbWFc7J6FjDYLonK3CGh86dvR6q98PIWIEPB+xmxSKFlaNOLxGFAj48PYQzoB
 pV8WJ/xxh9KeQPhDRMw==
X-Proofpoint-ORIG-GUID: z8FlQh-VXXIRbIkdDNNDuF6N0Ol0scLu
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b7ddd0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=fNMmvbdrdlD2suN_VgQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160081
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,arduino.cc,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268102-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1AFEB298093
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 11:38 AM, Srinivas Kandagatla wrote:
> Add LPASS LPI pinctrl node used for setting MI2S and soundwire pin
> configs.
> 
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

