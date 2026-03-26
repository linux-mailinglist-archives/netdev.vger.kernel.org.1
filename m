Return-Path: <netdev+bounces-271990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPD6NR8bxWnr6QQAu9opvQ
	(envelope-from <netdev+bounces-271990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2517334A1D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B25AA303582C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A73ED122;
	Thu, 26 Mar 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nY5PlCsU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GJ8NsJfu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AC3EB80C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525206; cv=none; b=GRmATN0PKc+65+31HBOVxKIgHm399BbNA0YUUwnd9dOoSul01ajiKDBP7V5BnulB/sWhuUsTj42giUVJnczTK2t7UmPiN0oMOGU9MOg0DCY3noAIoohdXSsgy38KmZ30zFsKRIoD7+ZixYyqc2EnynOQnJTepcKaxc6YcKK4NmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525206; c=relaxed/simple;
	bh=65eoDA5aXZKiN86gCHpFmmdUEmkkKaAXVNwubjRij5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJGGq2OHCZwpUjWYlikMPp3PLCF8ViG2ix92FoikKbOPXVST0Brjg3b5PuQD/LvKe2T8u8tNRvj1R3IidlXBOov6QAkAQ2JOy2Ia1Q81cqXsatbetZyUJ6Mz6GlbPV7rgUqL/tqezx3TxABBmX7AmUYCPf6mFdV8mFKPujELDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nY5PlCsU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GJ8NsJfu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QAGkNc4015117
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3sX8nCJoTG/mn6XePX6oysvzTyZ/0eyadLiabjS3doA=; b=nY5PlCsU7Q4oc7Gr
	o6E4xjYB6CqSMJRRVArxY34+zAlEXSBJFsXMXE7DweGbtEoRMFuLsznxS1Kfj1m3
	tUlRmhF3jj3tr8xw48rHKRxnnAA6mhtRviSHEy0yM170OR4v5M//S8+Y6LA2L3yA
	vouAnDsWAc/LZCYJFr5dGDFZiyY8ZOHgu1bscUcszZbFvRqFrfOlygePLKPX3z9Z
	q4MMNdtlnnEaNS8O609DPVVRokQH3fnnM0P60gYt+ynPXiJbDo1YaynGeO/9HrZ7
	GUGpvXVyC4TbY9aIRugD6p7RQpBZhcp2u+sIbXfNlU6jd+A3jYu0dHMJbiG2JS8B
	cqDaZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4w1q9k1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:39:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50947db2e97so2991731cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774525196; x=1775129996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sX8nCJoTG/mn6XePX6oysvzTyZ/0eyadLiabjS3doA=;
        b=GJ8NsJfuumma3A3h75iA+VX5BBaHl6SN3yO7zAQmnOpU1Fh7cRPUe74qBN5i0UPGSP
         zWjBChpPZ4BCsreQSOddDmzlrLoggkSMxQ9p0KcRMaovLMryJLdOXtcvg+CLEYXah4cP
         iuuZbKTJkG2Ha8LEH9EHEipO+KbvMMaRgGWfYsC5GETjlfMppecTWVxFUkdT9P/rBBHG
         cv/4/GoWhgbbgnvduHzpQNgSUd8mDlj54mH8NdbeqA3MLJq3ares9unIjPuanWzUmTTy
         a74FirzG/UJxcE+F8q4yuwnzR43Y6/1cLrO6YhdcPqo/3onVOmeXcFNENi25kvebB6l1
         FWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525196; x=1775129996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sX8nCJoTG/mn6XePX6oysvzTyZ/0eyadLiabjS3doA=;
        b=bq/KZozpSPyO889pw7n8soa9tZtScEQQgvMQCFLCspw7gtDSO9oDLssLd5noMe3A2V
         ug+eTN2TaRrm6mlOy8Sn4JzXtqcooEHeIpqORDFPhG70AIgOrZjjfp4t3ouA9/DR4ZpO
         Nh95jaRVeuatG0ffxzqNizbUPyDrqpnIvDMlw/GsKDecMyXlQgOnObIMuyrU2XF/rX/0
         J3256Wz6Bv5QTCMS3+CtOmBe3pHkLQdMePDP4LAqXKzJ63wGDlKxsf5per7tz6zu60Y3
         DF9o0jfO7kjs7OYbd8Isj7doLjAK4rjIqIlKB7ruIzZ/34bxjI4Xh6RsVr9twnWlgJjc
         DZew==
X-Forwarded-Encrypted: i=1; AJvYcCW2aJENjcYb8SnSgiO3OptNybwJP3RB85duQg2hSLekBrKYclb0Qq991ldLhKu0oz5V8c+SeCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJfuOzygC000Fu/cjpVW5VL7CZ7P3iOEQBUyL2wQ8fjhJ+Bpi
	QM3Eu4tXbarFIPTI4J1T2TA9R7Hs6W2n1QIbSU0JBeKb1f5w8GPD4WkKu8anzFogUGQ1f0D1VOC
	un3tMirWeY7NpDvuOUcgESwuPxZk282PbMaGkRu48cBRZ5JnosWyepYv18x8=
X-Gm-Gg: ATEYQzzRkHliwdIHn2X4rhNHoHqHgm1zLoha/8zLDD9Mjgx6V0AbDc27X4zrm/j8exu
	0EBYeH0OCm2/Lnf11QRN/HSJadBFbg7cyTJ6fYRjy7+Pyh7LKUzLfNWw6SKV4y6MaFu57ScfaKe
	TbwHFMkTuL3PYlf/e1dCmGOk3axylh9SDZ6qHoo7iF+rsqcBRIdOoQpVTMfXV1AAKtYjQZzY5rx
	znddC4tpK4TT8ZMlhkiUHUs2UNlIo3n27ssGtr0jhSzvzsCm7vhA21lA1G3O0daB/S39XJS8kr1
	VOHbrTwVTi6vm10YWfCVtw3aeynkdvg2TpzdngE2jbAVjRAU+Ws2sO6KDO3JZ0gnwZ6riVZvLwp
	gq1NbzlJXvLjGlp+iUCKWPfStvEu0iFS/BdVsUb+SRMwS+FsM7GRKvqhPMGrX+vSuklmfshFP7d
	8eNlA=
X-Received: by 2002:a05:622a:4486:b0:509:882:9e7b with SMTP id d75a77b69052e-50b80f10b80mr46079901cf.8.1774525195968;
        Thu, 26 Mar 2026 04:39:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4486:b0:509:882:9e7b with SMTP id d75a77b69052e-50b80f10b80mr46079731cf.8.1774525195353;
        Thu, 26 Mar 2026 04:39:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203c2231sm108580566b.38.2026.03.26.04.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 04:39:54 -0700 (PDT)
Message-ID: <e79139f5-b737-49e5-91d4-c9269be41a47@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 12:39:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sdm845-shift-axolotl: Enable NFC
To: David Heidelberg <david@ixit.cz>, Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Martinz <amartinz@shift.eco>
Cc: Petr Hodina <petr.hodina@protonmail.com>,
        biemster <l.j.beemster@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        oe-linux-nfc@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20260324-oneplus-nfc-v2-0-3eef052c9bc6@ixit.cz>
 <20260324-oneplus-nfc-v2-2-3eef052c9bc6@ixit.cz>
 <9d9ec994-c954-445d-97b2-772614d66f35@oss.qualcomm.com>
 <041766dd-422e-40e1-9e5d-c220580871f5@ixit.cz>
 <a0da2236-27b3-4491-862a-457a03cb4c5e@oss.qualcomm.com>
 <6638c874-8472-4383-bf83-21c5b632e73e@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6638c874-8472-4383-bf83-21c5b632e73e@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Nr9KVpFqcFJcwR9TFTxsCsO_wx1UAAht
X-Authority-Analysis: v=2.4 cv=HvV72kTS c=1 sm=1 tr=0 ts=69c51b0d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=-PauhVP_RH9yc3VFBwAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4MCBTYWx0ZWRfX6Np//x62FQbg
 tCXwbpIW1iXui2cTWKRmhaM2l654lsmPLsHlwt74F6jTLOew4OKDUMq+3oTuxsryWYtjkWbto3W
 J8xc6U+r/MYhwnbDl8znlDOaZS5q5Coibo9G9gG02ntYMeMNATveup+70pLKQOnxR7K79xA2BSh
 UH+jDkhLVt3Rs3TktHeaXx06qz5dEeRje7sX1mbuC3z8KZtJtOIegkSwafV/cQEB6hJUTPEAep7
 o4DS6iEwB+Xfgo4bgAZ1ypJkOhYCV4AyoUqTA0KThREX2HgoFTYTCJCWUEVheYNmrsmrlt0iT77
 o20XVXgIfQrPzjqD3dyLr2gx3JLKl30XEyqVL1Bly+IOIFLyL8cR7lGzr035XXh6PndIZr0kY2h
 CA9RdmMR6TE2paUyRJl9rcdxUlNSQLibTAvB02yB58TDWlGj4fDL+0lE7P4JHS7z4KteO7ACBkF
 B2LC5cQonCAB+FoqwCQ==
X-Proofpoint-GUID: Nr9KVpFqcFJcwR9TFTxsCsO_wx1UAAht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260080
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,gmail.com,vger.kernel.org,kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-271990-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ixit.cz:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C2517334A1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 9:17 PM, David Heidelberg wrote:
> On 25/03/2026 12:20, Konrad Dybcio wrote:
>> On 3/24/26 7:08 PM, David Heidelberg wrote:
>>>
>>>
>>> On 24/03/2026 14:12, Konrad Dybcio wrote:
>>>> On 3/24/26 12:20 AM, David Heidelberg via B4 Relay wrote:
>>>>> From: David Heidelberg <david@ixit.cz>
>>>>>
>>>>> Definition of the NFC.
>>>>
>>>> "meh" commit message
>>>>
>>>> [...]
>>>>
>>>>> +    nfc_enable_default: nfc-enable-default-state {
>>>>> +        pins = "gpio12", "gpio62";
>>>>> +        function = "gpio";
>>>>> +        drive-strength = <2>;
>>>>> +        bias-pull-up;
> 
>               bias-disable;
>>>>
>>>> Are you sure about pulling up an active-high pin?
>>>
>>> I'm not sure, but downstream does it (and "works for me"). Maybe Alexander would know more details here.
>>
>> Would changing it to bias-disable also "work for you"?
> 
> Yeah, works for me. Should OnePlus 6 do the same?
> 
> Looking at OP6 datasheet, there is no pull-up/down on 12,62,nor IRQ 63.

Generally the internal bias would be used to counteract random noise posing
as signal, to ensure the line is kept in the "inactive" state when not
actively driven

I can see that the driver initially requests both to LOW and then sets it to
high based on the desired mode in nxp_nci_i2c_set_mode(), so pulling up is
perhaps never really desired.

Konrad

