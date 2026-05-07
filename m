Return-Path: <netdev+bounces-285472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB16Bevk/GmGVAAAu9opvQ
	(envelope-from <netdev+bounces-285472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:15:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B3A4EDD24
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 21:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E995A300ED83
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB5747AF61;
	Thu,  7 May 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YG/o8Lz6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AbMQD8pi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE247CC97
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181260; cv=none; b=msF/lSswBp6M6e9zuBrwpGLCCuPzgeqLIIWfPLGU+VhWFYOL6DUOvelPGWAkhizuWFxveMWQ9KYx9zCRV4xhQUWcVU7DgKBao4P1l/dYS0372JuTEPQCpi8LmaAxuxSkgUxvuBmD/J5hNWPuy2oQJosRxbako2wOystzDApHeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181260; c=relaxed/simple;
	bh=bn6KIAftZFAgu0Fj8bdAqw+sb5cS+6rxHQsH6/lo5tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZ8SnypPn98eYUVlTxy5TOoXtYj2Fh8+YZKPxVJK6eF9NEJOA2GR4b3tb/W80yzG6+Ef7bvwYY8ieqi01OKYwrjp81djC5kpbnk3DlF4AQmnGlXY2uTrChS5/LugA69nHMEdDFQcg56Q5hgxmvMKFiGyTa8SucYXc+Gj56OV8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YG/o8Lz6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AbMQD8pi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647GEgA01669686
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 19:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	krw9NYPIRjOwvAqsLEaC0tplCBFZCd1N8FeCy+nD22g=; b=YG/o8Lz6gC0410iD
	dtKh56KHWDhifpwwqMiE099T24CGq0lRxrjtkI5k+NLsUoRnmQiIVbzIv1/uYrlH
	XFYTnKSfKMRjh7sMwlyHRCTz3sp3bXAaQSTeykGPMwRPmkAUm9Du+EXmaMcvmf+C
	mDdeLpXm7ojmb+iN4qk26fxLCpuGypRpFAY4ved3m9MlnJkm0nZIUWxnaDHscS6m
	f5ld2/vQlbo9L0k19hK/xeoL5J3io7t7ELAE0yfZKD5cHsqHKszo3jtRv70IdDYQ
	nykRjbmGJc5f/dWZCHOjFWl39eRCzbCgXo4V+pBT/b5m4Ofz1jwXQAsDHWxJm6yx
	Nd69jw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p3jys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 19:14:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso854927a91.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778181245; x=1778786045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krw9NYPIRjOwvAqsLEaC0tplCBFZCd1N8FeCy+nD22g=;
        b=AbMQD8pik6FhGN8KRrkJl3R4WV3AIwjv6SSpEmWAr93Io6O2pL3CzybnFBEmpgsq6e
         SZO1tkEhiSzxxSljlYj3PfxTsJQ+Or9XNTyvG6dvXi9n/4Z8AX5T27qkt36VTmO3b/it
         oOxytIOGOLaWsunLHc4OpZ6uP0vOklMSH4CwCVygqaO+wpfALHN0OOnliYR7wMBmp2vh
         6EQOv5OIkwaAx3XIgTlqgURV+nfBpf18nEz43PqBbMD06MAW8aet2bElT9m/eii0UXxf
         D+r5c62GUmPa+QA39XRF8bnvygFuISzBbUvL1xXB8L0r0f2oq4ZYny+uXt9HLzH+vpw1
         r47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181245; x=1778786045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krw9NYPIRjOwvAqsLEaC0tplCBFZCd1N8FeCy+nD22g=;
        b=Uh0d4BtupVFBadcnR9W1z2AcS+o132OnaCYWL1ZsUs4E8IpWIBCX0XU+ySY2MUx35/
         GluyDEEhvrrgiZZcIKbNQiAmFH8G49DmgR60GOxjInNl+UaZKAh6TXSiG2QjOFDaZXLG
         rEOB7EBL5KAKlZQFE2oE6Mzv0lNyoH0miO39Yn5Wk2JxESgSILh15z0y8KLdH4drxAZL
         9QyLMngoGxwPKQab7HArZlyDoKOHcqhk4qEUz9qEoIiRf/ekDCqzMkTDkTSHF0P6VL0G
         zeiWR1oSvDhMFE8YMwvy8z31MIT7y1e1WCEbjh7YU6Wmmmng2Ci7flrJW3xflN360mYw
         l6TA==
X-Forwarded-Encrypted: i=1; AFNElJ+rE/FeZK6HbziGkH1TJ9GoKXO7I9KurTZAZmPH1g/UO409WwCoL1WcXJyAG2a2xZBmhOMdUQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrIXdMe1WUSwy53Fp1SOphNMY0wEMy/l3vd10kA+wefrmb0+N
	LKU87Yo0T5fvbrGzrOR98X0Sr1F/hnj1sfXj6PNAVYvl02toHSxUvcVu7n7wnd5ccvQ/E2+BG7r
	OzwohKgEQ52ThtFaNctgC4vTkyjBXwg2vqWqdAyvaj4slwGAEL5AWID1kIDo=
X-Gm-Gg: Acq92OGVptRmCayjlc5qkv+k5jxI6ap7SqtwbBtB6lQwYuaxuz5boebXlwvIQ7UZUYq
	7PKXrqFumY0dv9SBiD5fxvKcyK0/XxGTkdHaiIIQLfpcoN1DCJ00/pVQYWnF6NxXokTpnxaYebl
	lmGa+V5rKwMEMTeqf2vAQHTvDyF6yFtbmZVhSaHx8a/xTnkJ8p4RqR7awnRvGYQPzU6j3wSeLBn
	azpT2kh0acmmUOHS4yd2cZe+TvUHUu823Q4A4gu6F6dT9KYxYGgBLX1CYQWfMprO+8f/lqFou+e
	har+we31LoQmCZn8ehLQ1JQ1xYGsrglCY1bLwNjE8fxQDm+k0JMISkTVouUgAtR7CO5OlO+v6CT
	i3lKV4inRFvVaugshVpRIM7qD88ePvuhrq72rZIyaQ0xxtikT3y0=
X-Received: by 2002:a17:90a:1c88:b0:365:d9e2:7511 with SMTP id 98e67ed59e1d1-365d9e27b9emr4444012a91.25.1778181244734;
        Thu, 07 May 2026 12:14:04 -0700 (PDT)
X-Received: by 2002:a17:90a:1c88:b0:365:d9e2:7511 with SMTP id 98e67ed59e1d1-365d9e27b9emr4443990a91.25.1778181244281;
        Thu, 07 May 2026 12:14:04 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.202.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-366478ddb86sm170288a91.14.2026.05.07.12.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 12:14:03 -0700 (PDT)
Message-ID: <4c6ad0ff-5b1f-4beb-8896-da325961f8e5@oss.qualcomm.com>
Date: Fri, 8 May 2026 00:43:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add Shikra pinctrl driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij
 <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260504-shikra-pinctrl-v2-0-14e9dcc2d685@oss.qualcomm.com>
 <20260504-shikra-pinctrl-v2-2-14e9dcc2d685@oss.qualcomm.com>
 <20260505-groovy-loyal-bee-0cf72a@quoll>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260505-groovy-loyal-bee-0cf72a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE5MyBTYWx0ZWRfX75aclw/y7Hi9
 BM1nNUj9QRegLlCpk9e3+SgY9y/11+QqoQO0+yPNp2sXuaToYL6FvOabXY+AiwP9XcuOf+OV7nN
 FK9rmaNopb6g6ChR3zyLmf8JEhAJkWNNXmtCJwR0pbJ3HrxcMnknXyRdVJMq5tqHtUmWaP0hOIc
 p+QppzMW2X9rSqd3knRdNnwz+a6lC8lS5lz/Yddnc2W0Wt/KYv2s/0kHNdklTqNvghL1Ed8CncY
 kWWPd9Q3Vl0dQPF2b88RD6Rckle44jQzZ01MFFFSkkmsWf4OYUAiGK1nAHI8ss+aQI+ENnYfxyJ
 fNMl8w6UyVQEDNXHpIw5bVNQSVBtqhFz8m1IpJNFqeTbIIzRlBIsMWY4GTpleh95mdD8taGp2M8
 ieuL+EY/0vLV/qvPPvjf4zLI9wJW8y55lnfH7Ab3GLyQ5Rl7h+PMHAomfeQjBm9Dk2vFYyKqDuO
 pxgnj7oy83S9QijzISg==
X-Proofpoint-GUID: RmIUEaYz9RfwANzxjVxQnGt4nYlJay5A
X-Proofpoint-ORIG-GUID: RmIUEaYz9RfwANzxjVxQnGt4nYlJay5A
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fce47d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=GlSZ2Rd4KtbczYCFEJIQVA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=4uznfLdumDQ2-nrduUMA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070193
X-Rspamd-Queue-Id: E5B3A4EDD24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 5/5/2026 2:54 PM, Krzysztof Kozlowski wrote:
> On Mon, May 04, 2026 at 04:18:43PM +0530, Komal Bajaj wrote:
>> +static void __exit shikra_tlmm_exit(void)
>> +{
>> +	platform_driver_unregister(&shikra_tlmm_driver);
>> +}
>> +module_exit(shikra_tlmm_exit);
>> +
>> +MODULE_DESCRIPTION("QTI Shikra TLMM driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DEVICE_TABLE(of, shikra_tlmm_of_match);
> This is NEVER placed separately from the table.

Thanks for the suggestion. Will update it in next version.

Komal

>
>> -- 
>> 2.34.1
>>


