Return-Path: <netdev+bounces-266154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI9QNQMpsGn/ggIAu9opvQ
	(envelope-from <netdev+bounces-266154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:21:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB888251CD1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF4D83213E80
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EBF38AC84;
	Tue, 10 Mar 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pVrXf5o/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LEc46TCx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D71374182
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149028; cv=none; b=bMUrKPKDQoB0s/puzCsaWnzm0h2cVGwJ9aPm0VX2qYKJZx3PiTDPiMXkbTloIH26Jt//g9onfRnMZrrZQ5vY/ALAN1RM7fvX5ViL2nvCyC4Uu5nVhejjc/2o8cl+8m+HpsquBvpzkafFmZfxehKuXyrni9FR5Jo+oYvsbX1hNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149028; c=relaxed/simple;
	bh=YD2z3hHvCix7UCDpbM2li1t6vWmITYSKd1Ek8SNEmIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrvLWFYnQ4qaDIk4h/538dLCzsIcb1XWBJcsShk2eiqwGn7zjW8zMXpaJMcYMLCa2/mwGMEQe6jllxyQOXgK7Nr4meQ/8QDwUExSy4xHomLgDFzK2AD/wERQBezNolxpjKMP5jPqfZe8ziYkOB8IBmR2zqeFl+dEsp/GtffTF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pVrXf5o/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LEc46TCx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACnofP3893470
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 13:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	orEohHfy7GJzc6faGQD96uNhCW1mOo5TuHLKgf3TG6c=; b=pVrXf5o/EVBmE+wg
	BT73Rsn6SpKJ5wq+G76Ylf7BWahcXxLYD+eUmWPFXcaWhkwUpobx5lK3xRmxITXS
	bC+3ReO12w5lG0ypF9by+SDzV7dKvczmi4V1ObY+HulYNow/9x+coIgQOc0FDR5z
	tqh/NwxX4y8wUkQqnAe2Ol0tx6qnoYrTNmZo3PQbWnPYlAZ96o/M5CShmfzCT3Q4
	AKPsiGpksVlygVdcqY4yPVfjY54SOoGDSeJUIxOABYkWnjdZlzq8wUrR88zzeQ8x
	0ey8qW+7bpHy0Tuk5wPV+wlDXL8O9vInB7v/+JNZUUTfdiow3BeHh16CYZpK3pDP
	/hjuyw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyr477-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 13:23:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd767c51efso377161585a.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773149026; x=1773753826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orEohHfy7GJzc6faGQD96uNhCW1mOo5TuHLKgf3TG6c=;
        b=LEc46TCxHWP02IkGnKUfFjjsd3LWiuI7cwJOJE1Cjc7fsm8mX+tVjXPdPrZ424LFbD
         0uRLbPS9smhYv+TD8Di4cDW8D5fbXWgXA+kRcz511RNvFqb1kKtYSHEHvi090jgBoaYN
         xrS4eWwHuW1NzuqWGFRkDfyNJHH5uutGpgEEpDKOJiMoF1M5xEc7vkkWwKGV0nUETXEg
         PJET3n3+lZlXUbSA6AAeLNIfwd/MTKqMUvlhiQRI7tyv4R4iPvSu5BN1xGbNckeVcTne
         pJVtw1A1XByclnfqgEzakklx2pBZPuffNDFLxCaUJ7il6lKXgSYL9HhVVn7GPslfr9Qe
         /ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149026; x=1773753826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orEohHfy7GJzc6faGQD96uNhCW1mOo5TuHLKgf3TG6c=;
        b=TAqf2A43QKGEkYgJFs/mN3hnzYVKRRDTfH8hfeRPEn2OurRxkRD+Omaej0xXTw3n9M
         GxxPokcrgkHco+Czf9Sp0xirOQICzDqf4335oWe+RSO813eMKK7eWopdnFJsxtXVmFzS
         33j/RdLFnf0IE2nirsfeqG0VLU1DBI0MAyHtEAioNbI3SrnEmoF8zCKhw7CLuatWkfLF
         NKf/06dS3/RlWZxEtO3/ivrnxM8iqbiQZCwCDRIZ33KC3R0G/24LdJzi3revibuPQrxb
         ZokSbhku1/WzSfGkdZfIPcef9VRVSNHxXdxiUpNY4VNYPpu54/Xg7UtsPNCoRkfSQ8y/
         /VPg==
X-Forwarded-Encrypted: i=1; AJvYcCWIJllvzq+m2Rphs1R2jMTweoDVsrkTAOmmU5+K04/GqzB3c2wIiIbq8idtvTah4yesRCrzzMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9txfahIPtfAYRgjH87i1pe7PtuimrGY9d8DhILXCPKCI7YyTC
	dIjvEXBwrNI056eWCDeoTxn01vPXiRwMdcMLXpC9eo5VDyWreTLU+9jRNDtMXV4SCMSlfQRe3+L
	LpfYQhqiWs5Oo9N3JmjxmGzuJla2wGVAdZM3C7lWk6rg6jN5WzemjhR+KYpw=
X-Gm-Gg: ATEYQzxIpJz33RPQBikU/OPzQiLJL7OF4KF9j4kvlQXitEmKcfOIdKJHu+Fbgc84b6X
	IgJYu0m8WGRwA2M+krI6m5BR4u/UtMUfpcBKigjUryXxnLtigrrSUJRcXz4lEuAjK5/RwZ5GB2r
	Xn+8hB/0Vib0eew6ZBuKjSFG1lX4wb1YVjaGPmryxThCEkPEy90MuSljJ/qmn0hgA1qw0bN2mnH
	o4Vhu0Am+ZE3u6iCJOy8UADfdXtHcmqLqqVcUAu8VcRsp2VkDhGIYovYPTgoAFwMFS8tBPu25ft
	1/S2L/+yhV2JNmUsZpmX5wMQJvkfQj/DlGp1XN47bM4SDnK+J1kPgmEMoZNHbYjmM9hiLjUxfpk
	tp1z+RUUTcsZbHv+qweEpPZC1ueDacI9fqL9Hf4mlmJ3dhcmbS7PnvBn7Ycob1GqwcktujnUNEv
	myfs3JwSNF
X-Received: by 2002:a05:620a:4507:b0:8cd:9938:9809 with SMTP id af79cd13be357-8cd99389e77mr147056185a.26.1773149025733;
        Tue, 10 Mar 2026 06:23:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4507:b0:8cd:9938:9809 with SMTP id af79cd13be357-8cd99389e77mr147048985a.26.1773149025121;
        Tue, 10 Mar 2026 06:23:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8da01sm37186097f8f.1.2026.03.10.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 06:23:44 -0700 (PDT)
Message-ID: <8ad5ecc5-ddd9-4d79-acca-41b3797f0f3c@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 14:23:43 +0100
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
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b01b62 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=M45qCTXPNjoLw3xkhRYA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: EfRStQHo3uheOH-LAtuoFSOMl9uz1_oG
X-Proofpoint-ORIG-GUID: EfRStQHo3uheOH-LAtuoFSOMl9uz1_oG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExNyBTYWx0ZWRfX5viUxHzo9wvT
 QT9ot2dMRPY/EKo3ayBY319XFCItrPkkzlGVFQ6fhz6nkscOyrO6X2L/mGtc+V5sKIPgJKsxCX5
 aSHGRT425Cpc4QeyLMWdoEE5A7d7qKx5oKel09MkVTZ36rSOkrYIPCWtsUFX2Md2hctQATnZ6sk
 Q4vA6qhL9lUwM4tRm0MMTESnMfPR1aoR7VEovnMygwic5epUyq5sz/UXbI24iRGsJh3No3mbtYx
 WrwY9Z6LECRDJhvk5Kj7pGYakxRl0tYB6P7rgLGNNAuBQCEiTHbLWoE43O+Y3/e2CqnKrZ8gDpv
 9DSK+B1pao715rtwWEVLtvN2qnrKHqPQw0LpGhMtTaaAq83YXquDvfwAa844hhnV89dIR8QJ+Vo
 MeMh0nBkYLuWZTRPIOfkWil3sW05UgZ7PN92tH7iR1KcVQV3er2hVCyXN3qP01M499GYJF/CT9Y
 7a0AI5ulU2Ti6/Uf9xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100117
X-Rspamd-Queue-Id: DB888251CD1
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
	TAGGED_FROM(0.00)[bounces-266154-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
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

I've the same number of patches fixing the copyright for each patch 
touched in this series. Shall I post the series separately and fold them 
with the corresponding patch ? (IMO the former is cleaner)

