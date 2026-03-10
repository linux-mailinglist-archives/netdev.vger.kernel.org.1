Return-Path: <netdev+bounces-265971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ABgOQrur2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:10:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE02C24927D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E40CD3035427
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D33436F415;
	Tue, 10 Mar 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxFLJaPz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="blWS/qYp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F944105C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137189; cv=none; b=Z67XezxZPBK95uTKWW1gKcjmMXFpqKad8j5GPNVuVeYdd5SagBUwZh3UaO1ezGGDl/Tsm4uQ/mW3OJgH/o4p8CsXSW5/Lr7w5Qk5M2IPHUoLAWo0ajUbA1LUre9ysZVZRVSL2EulB6puJUVVcTftsI9m2NiDEJZ5zJJYWccH/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137189; c=relaxed/simple;
	bh=g2XUM9dvvm8cVk5OWuSpx7/gOYlOEWshlkLBJaa0vAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOLTRTysYet2crEmwe1DmPHMRI1m+Ge3sJEQVPFDlakvi2bu14alGnXO/G/EiZFQTqU299m+xT9hhbPbQMet7hSTNOQvOxSFF7W8YdEiEF3YQ0m4+sJ8ZOqR82NFHE+Z/a0cJC1Ag+sJ5vljKnAyg6ZihWhhoSvbbWW+/c6tVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxFLJaPz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=blWS/qYp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7wS1x3124655
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zym8eQRUnoxy0/BAjJ8cuqc0CkUIHWRkqrzGNeSb23c=; b=hxFLJaPzisZZN+jE
	+7Pri14DDd7KUEvIaQZDPIXFcX+wCQndBf/2rnxMD3KjDF2LSRo56TcYutc88uU/
	vRgGWaD4jQRkDk3jG+MV1j1IkaYJZp3VdS8bRHr7bSXu6B3yME9iAtPKWgcFTrPC
	YHCjdpoIoEpVEDbNd+XQ8QpXs/d7MJcLwMQKH7hJabjPmitf2vkM5quy3YlwPx3f
	NEHENaRFEFR8Aom5OuVVbSZ82XJUu8R6EcvuTeoRmkjdHj9Cw1u9kfyqyX2cNsLY
	Hvj+bMa4eU1F7DnjQrK5jiyHp48hiSndNP4UqB7+sVMSKIZnTDilIS0OpDBWzNPf
	Th8iDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctfcj0gpd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:06:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7f6ac239so1540179485a.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773137184; x=1773741984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zym8eQRUnoxy0/BAjJ8cuqc0CkUIHWRkqrzGNeSb23c=;
        b=blWS/qYppNAmudHj5Uj16q4jA1HzAbdaWt2z13KrwkOxRlY+ntAi7v4dOTI8tbCOLg
         cVUWmiTRJov3m95ENWw78LeKWQfU7rsY0djPphO4T6B3/YSwe+edTJP792M28k/nPOvm
         LfyC5iqaS0usNyAci2kpB7gv2B6lRR504V2I+AfiaBxa8DZMQEf356+X8yeEVcepXcOO
         YUWlHdT3q0GB6GlG6azKyu3lcxYBgDgH0yS7YW558HaU2OL1mr1mB4jgdQAi8GEqSkTA
         OkVLNolfYey4QSbBOt410ehitdd06KJ63TLskNM8LOcvXGYG5z0HPzUwQNiL04WUOA7a
         eGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137184; x=1773741984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zym8eQRUnoxy0/BAjJ8cuqc0CkUIHWRkqrzGNeSb23c=;
        b=hU4gxs/UnkguJ01obVXjFIn+tcG4sGwHDyOADd31jxGzYfDNleCQBwTyOUFjfPZv/V
         qGIyjeDw1I5iQDkKhR7Y0MQw/lR1ZPn3lLUrSa54U7e31fq/vSfJzv4rk/h++K/HnAy+
         Mzk6vIjQsRcX0RvcPAXyWUM0iPMT/MF0aRMdaVHnfVSUTzPJo5kr+HyJYLpBnu2Zcaso
         kW7eDYy74yEHz1uLbLJOVBKW96fWVlbmULagc1ofGWw4mNy1z25WZrgT7c2K2PPd8UgQ
         c8hRdoQVdRBaneMFc1iaMc4aFiT0YwHBM++GuzByhS2XIRGv6ysJ9PjfWqR2OCvJGxnA
         YSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUCpApVlLJZXfySJyx0ZjX/Tpa9xtYt3i3G5nK1ezmCpWWZCK9k+Db0pKRqs9/Fq530t70J2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDhN2elMvCN++RUCfFJY0nECXLgaTzz0ESOaeJHwmVgrK7PQT
	Q5sD6uA9PsMKnFDqGuIRpdgZ9F3xRN1LPxXoNJwSs6V9SRNo0zH0rbiswjhONLHujcLAddvjgzD
	b9BDfHI2I/GMuMRyRJERMkQfPW7R0xC6sZnGcSY/Y7ctaSeC78L8UqyjIZUI=
X-Gm-Gg: ATEYQzyzxf8Wt7kUS+lj/+p4eDSqFRYXx8eGsv8gCrvC+bMHB0Tn1lbRZhHKRsAUZp5
	UxF+PNbs58povbQygBnykvyZ/PKZUMV8z6wl5qtuM8IGQztAadrD8Yh3H8+HKnQileduFT9z9Rx
	0MDp/qdQgzikdQlEKDbCgjvZ/Iz5jgbJZdDHKGUyb7S5f+Kz/bLpz/WqkbU9qZIVvM3WHhMiq+H
	0k5+6QNT5m+PJ4DJyZJTmvXXX4k/gcW1Tp0XASbW8pW2fBDuaSL0MyBMo6AmI2Hy0BNvwelxRgB
	bEgD3wYhejr5Ilx+AOFHkN1unQSGiuCNsv83rGaUIntTMGCQt3Bvvy12mLOByCX1BPpMsbFStNW
	Ca9TwRBVmwBrTuNGMakEzHqZA8iTIZItku5iOWp8YkTSBFhQk/zxJ269dgUtjaJLKW6DehCqHp2
	npOMsM+EJ8
X-Received: by 2002:a05:620a:3943:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8cd6d429895mr1705195385a.42.1773137183854;
        Tue, 10 Mar 2026 03:06:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3943:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8cd6d429895mr1705192185a.42.1773137183406;
        Tue, 10 Mar 2026 03:06:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm32447848f8f.3.2026.03.10.03.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:06:22 -0700 (PDT)
Message-ID: <58f49fb8-75ee-4dea-b7c5-28e89711f9f6@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:06:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] soc: qcom: qmi: Enumerate the service IDs of QMI
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, konradybcio@kernel.org,
        andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-2-daniel.lezcano@oss.qualcomm.com>
 <7d036c96-e257-460c-a91b-deee0b9c348b@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <7d036c96-e257-460c-a91b-deee0b9c348b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7fWAuYi c=1 sm=1 tr=0 ts=69afed20 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=7MBKnE05AAAA:20
 a=EUspDBNiAAAA:8 a=M45qCTXPNjoLw3xkhRYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: vfYlyelhINTCtDSKZpGaTjuby-rFM03u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4NiBTYWx0ZWRfX1jwtop9ijqnw
 NQixnwsT3MNevY34yllo//pwCBvaSMQBENL9aH+OI/13/fMOJOXpI+IfS10O2iqcvrO00ssUpjV
 yxZ+oHTSztEe75p33PlKPh+554ywPux0AC5IQlAVVAlhNsdeUA3DqnwbqUqBead626FayToxHs4
 Lk7M++ftPS1sswk/47GQkFjXkrTBBXminzk0D6d6kLwkRgV9vWpS/3ft7egxAZSPpyKopcUeq7M
 kC/UsW50u1aAS9EDXLlz25g9cHDmt6jR7+yJ9nGHc+CI3q70K42V2azDoCgvOu8h5WT+PQc1eaM
 +PEA1QkXZ1wIp5VISxlo3SnN0PpkZ6LmhyjzAL0l+E/EXhwiewjjq0pYl2DUBxYBugsVhyyA6xc
 0DTY/KC0SFKu7aUgIA5kvkpZA+TtbWo5sxlXpFw/E8AS/IPrckwYfD1cOAV6/hMWAfpF1oKUlRi
 ZXDnWXMRid2pMDZq6mg==
X-Proofpoint-ORIG-GUID: vfYlyelhINTCtDSKZpGaTjuby-rFM03u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100086
X-Rspamd-Queue-Id: EE02C24927D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265971-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/10/26 10:57, Konrad Dybcio wrote:
> On 3/10/26 12:03 AM, Daniel Lezcano wrote:
>> The QMI framework proposes a set of services which are defined by an
>> integer identifier. The different QMI client lookup for the services
>> via this identifier. Moreover, the function qmi_add_lookup() and
>> qmi_add_server() must match the service ID but the code in different
>> places set the same value but with a different macro name. These
>> macros are spreaded across the different subsystems implementing the
>> protocols associated with a service. It would make more sense to
>> define them in the QMI header for the sake of consistency and clarity.
>>
>> This change use an unified naming for the services and enumerate the
>> ones implemented in the Linux kernel. More services can come later and
>> put the service ID in this same header.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> ---
>>   include/linux/soc/qcom/qmi.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
>> index 291cdc7ef49c..b8d07f2c07e7 100644
>> --- a/include/linux/soc/qcom/qmi.h
>> +++ b/include/linux/soc/qcom/qmi.h
>> @@ -92,6 +92,18 @@ struct qmi_elem_info {
>>   #define QMI_ERR_INCOMPATIBLE_STATE_V01		90
>>   #define QMI_ERR_NOT_SUPPORTED_V01		94
>>   
>> +/*
>> + * Enumerate the IDs of the QMI services
> 
> In case that's useful:
> 
> https://github.com/linux-msm/qrtr/blob/master/src/lookup.c#L23

Thanks !

