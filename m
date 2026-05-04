Return-Path: <netdev+bounces-283735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id syYRI/JQ+GkiswIAu9opvQ
	(envelope-from <netdev+bounces-283735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6AE4B9B09
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 622723002F96
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51A3115AE;
	Mon,  4 May 2026 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cbixuad5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uihq98rp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777E2E040D
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881054; cv=none; b=YDcXinTm31Cz4/WBBAzsGksF1zSjRp3oPrhzHe6A4A8d7J0v8q4RTfY8V+3fd0Xvpw0HbZhwVzI/2I6YIm2B4kw4knTJdQ1dKRYan6J+UZ7iNTJLAIN0ptQ1w5Xu3AObte3JPX/vH6wTj8G2yJuOGez5JvpV+SvKKsCc4nFn2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881054; c=relaxed/simple;
	bh=3H3etX6ScAXZ/9quxEfOPdhOvtsFMMWW6RKeM1++m9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNouhX2DRfpWVZ1EdrsX6qicCsDX/yNTUwD/78udgSV7Ezlvh6QEOn/yoesF6LyOwITufJnZQLesYTkEspclAdXBLs/uiYO7ddBo7fQyzdXSGkAAw8HOEtdCDOc7oCsmZIrhDwj8vTB75RcWKiTjkRnPK32aqWI1ikVtjfvrELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cbixuad5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uihq98rp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446D8PF2431620
	for <netdev@vger.kernel.org>; Mon, 4 May 2026 07:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWhWZkkdYztsk7q2EQZkWe4rPMrdeAsMOgYo43K2FPU=; b=Cbixuad5adyEsKdv
	XrMUbiA22ZIGHLppkOSQM+DXlUjWJsu4yY00xZDAXC77fHRgonUt6kk3lqYk76on
	4LljjPqWIZBxdoEoNcP+xLZmzD5q5ONJiLElC7akD0bqRrwT6lGjeeLo85dGtqjz
	vtjfB4BMFz6TejoMq71ejj0w6jfkcVfKqn8kNVImsqBRBxjd38akUIzzdc/QOvF7
	YaQUquGW023EvbSJ+Ek7N+IZfYZ149/GiP0JDDiy/+YRuFvUE+vLCAIy1ar8EfHh
	WoKELgnZvKFD8ZV3hMNnMdY9uzLYs5+0gDAHN3zMbIydfFHtD1bQ0fIpLgIj3rbw
	GAGuWw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaj7crg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:50:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b258636d16so41416975ad.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777881050; x=1778485850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWhWZkkdYztsk7q2EQZkWe4rPMrdeAsMOgYo43K2FPU=;
        b=Uihq98rpcxwwCUq4YeRJK+Un4PdttrEsClq0DH9Iv0/yRK4CZ95Gd8CRLlxwVcc8vv
         0eMFDlv4jn/JGSq9ID3S5C27ZmKtQ9fBf/4HS01GwIhQhcShLUPamW5DJtrklxkWjzbi
         0yOrRgmneCr6Dfi41m0BtJMXrBYFdjhht+BksFakUC8kA/SEgSTKuJTTdzJYGJhNOn0Q
         4eDaQ6qZLkZJox64B2UZ3EyIxyTTh01f4I1/mz//7hZT1uLhf0CCDKotArvJ+tHlkSLd
         F448Q+fY2X77cyJoctwNkY6rDulYnLFVh5UXQEnxbZhULAolo1hNdks4Mb8pJGMXoc1B
         09xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881050; x=1778485850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWhWZkkdYztsk7q2EQZkWe4rPMrdeAsMOgYo43K2FPU=;
        b=ZnXNK/e+vJ51eVYxN5I7Fb6xnOiFDD67ZKWnCNWYEoyOfHjnDdL8IV3SFGwMdnGaQi
         eFjIjr3W6J0cVmXJRGdDZfz2V2lD9zExg2p/fZPAoiNL07IQyKsIHbk4nFoo4xs2bHwn
         8Zdstm8GxCI8caBaeIRs/csDvjxIDLHUy1TwxibDfMIEpSuX5S9Oo8zTYb5n39xCv3yP
         0FKX+FZE86k56MIpC/qbt6y1Z2KgPHD7R7K4ciKPXrp2bxvVTi1/L6lhz/mHjORKcyNE
         3ZYSGdgmfN++v8x/zTJiUK69whs2tGB0wYmV8ledySbJZrQL6wpUmP9Z3zATXNVa6K6i
         ko5w==
X-Forwarded-Encrypted: i=1; AFNElJ9R552/hT9PDG+xzbQzzkyM5sm99hMnlJGSRgAiM4djTWS/m6NxvfzIyIFiUUXUrb1aj3olTVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxsCjL5I0VQ9A8ej9j373TZp5MlzTp1a54FaSCxG9wRwIGtD4
	+sSC+YAR2f8KJwtJxpt84m1kncJYF/hToWPjzlu+CPfNXTta9PhQ6EXHyC3usCVhX40sUu7cLo1
	WC5MLOjxVa2y2bJR6G1NZlNwmKI3T0kF68MycpkSp1NEfg7AXQjKd8+ciqnE=
X-Gm-Gg: AeBDievKcDlDGQGPidU6MD3KeJHS1tcEfi7l42hk+hXcdWKsNgUaaeJfUGiqVRbnX+V
	JJYQM1Zs0cJjdODyfr7CzY38sPexDu3jWEEH/qjtklWhW8jcpe3pHf1mSKOp0L8Xkv5sWJC84o6
	cmgl7OKDBf5xik54bEX90zPHkXSIvN1GOjaLadxJvTeBExjcusMALnQrIwMZSd1EUgVZxERmphX
	8Qmfr5pM+HZrbz3dSK56NvsVfZtxdpOIz6sGOY1GozJ/5ioVUINVFptoiizdMkF1UsY3+0Lwa9l
	uE2oCdlcOsyz8KWPrAOs2vO+TCcOrOj1V5Sl6tTEor9cNpsJoB+1cDbZ+sSVZNSX6e3FpFfvnOj
	hCGNthrkcZEIQ0cDnZCT6T5ISoMK2S2ZEmx7QnwQAXfETpgcO2dYnIU1A5/A=
X-Received: by 2002:a17:903:3bac:b0:2b4:6562:642b with SMTP id d9443c01a7336-2b9f280a3bemr88539165ad.35.1777881050494;
        Mon, 04 May 2026 00:50:50 -0700 (PDT)
X-Received: by 2002:a17:903:3bac:b0:2b4:6562:642b with SMTP id d9443c01a7336-2b9f280a3bemr88538885ad.35.1777881049984;
        Mon, 04 May 2026 00:50:49 -0700 (PDT)
Received: from [192.168.1.143] ([59.96.95.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ebe8sm110471485ad.2.2026.05.04.00.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:50:49 -0700 (PDT)
Message-ID: <5973b8ad-819c-4d14-9e7d-415e2605fcc7@oss.qualcomm.com>
Date: Mon, 4 May 2026 13:20:42 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add Shikra pinctrl driver
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20260429-shikra-pinctrl-v1-0-1b4bb2b3a8d6@oss.qualcomm.com>
 <20260429-shikra-pinctrl-v1-2-1b4bb2b3a8d6@oss.qualcomm.com>
 <38bb1b79-67da-4a23-a0e8-3c3da77933d7@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <38bb1b79-67da-4a23-a0e8-3c3da77933d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UBf_9CC3PwtADPLaQUROKFJG28fMLtPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NCBTYWx0ZWRfX7rykqZXIM1aq
 On7OB9c5Cd1p28DMTQDt0InnS7KmbRXwnV6BHUPHjaTdo7aUlypSmPnclo27gJjE3Ol6yj3wZIj
 9EglKiLPHi3OnrpFFfywMnfeArPzEWrAmmBTZDBHdTE9zMk5+O70RcH5y/BMODEGW8j8hI0nTzc
 9EirokRImorgdgqNeeekFDR8xHdPp3v9CxglJpFYTYYs++N+aAvAFZHOlJFL2QN9iHijbziwIFr
 SGF30s2mSCNqfF5scBPczvI3y5bdGawc3mWN1XssQc4H1lBJ27aTcKGfITyCTqlFF1PCiAAceHf
 2FuCFrAXYitP9YIPLcOPxW8k/UE2RW9CZMBEj1rd+N7xFrbkUcKigyF0MPZ5GwroecpaciFcO2K
 3HCtS8nLGKBgi8DgKRm+dr4Ffby4quA8n9Dul2Mpa47p5mLCD53g/GvJ2J2IWTky5OAGypm02xc
 T9OR63XNwLel7FvtO6w==
X-Authority-Analysis: v=2.4 cv=csirVV4i c=1 sm=1 tr=0 ts=69f84fdb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=d18XUvOkrfNYrh/LwM53Ig==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZuckWHwAq6i6U7-C_84A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: UBf_9CC3PwtADPLaQUROKFJG28fMLtPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040084
X-Rspamd-Queue-Id: DD6AE4B9B09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283735-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/30/2026 9:36 AM, Maulik Shah (mkshah) wrote:
>
> On 4/29/2026 6:41 PM, Komal Bajaj wrote:
>> Add pinctrl driver for TLMM block found in Shikra SoC.
>
> [...]
>
>> +#define UFS_RESET(pg_name, ctl, io)			\
>> +	{						\
>> +		.grp = PINCTRL_PINGROUP(#pg_name,	\
>> +			pg_name##_pins,			\
>> +			ARRAY_SIZE(pg_name##_pins)),	\
>> +		.ctl_reg = ctl,				\
>> +		.io_reg = io,				\
>> +		.intr_cfg_reg = 0,			\
>> +		.intr_status_reg = 0,			\
>> +		.mux_bit = -1,				\
>> +		.pull_bit = 3,				\
>> +		.drv_bit = 0,				\
>> +		.oe_bit = -1,				\
>> +		.in_bit = -1,				\
>> +		.out_bit = 0,				\
>> +		.intr_enable_bit = -1,			\
>> +		.intr_status_bit = -1,			\
>> +		.intr_target_bit = -1,			\
>> +		.intr_raw_status_bit = -1,		\
>> +		.intr_polarity_bit = -1,		\
>> +		.intr_detection_bit = -1,		\
>> +		.intr_detection_width = -1,		\
>> +	}
> UFS_RESET macro is not used anywhere in the file, please remove it.
>
> I assume the macro keeps getting added since the file pinctrl-<target> is
> fully/partially auto generated. Would be good to fix auto generation to
> avoid getting this added as default in future.
>
> The unused ones were removed via [1].
>
> [1] https://lore.kernel.org/all/4429f44e-f7e5-449c-824c-83daa339b383@oss.qualcomm.com/
>
> [...]
>

Thanks Maulik for review, will update the driver to cleanup unused 
macros in next version.

>> +static const struct msm_gpio_wakeirq_map shikra_mpm_map[] = {
>> +	{1, 9},    {2, 31},   {5, 49},   {6, 53},   {9, 72},   {10, 10},
> It would be better to have spacing before/after brackets inline with other pinctrl drivers.
> {1, 9}, should be { 1, 9 }.

Noted.

Thanks
Komal

>
>> +	{12, 22},  {14, 26},  {17, 29},  {18, 24},  {20, 32},  {22, 33},
>> +	{25, 34},  {27, 35},  {28, 36},  {29, 37},  {30, 38},  {31, 39},
>> +	{32, 40},  {33, 41},  {38, 42},  {40, 43},  {43, 44},  {44, 45},
>> +	{45, 46},  {46, 47},  {47, 48},  {48, 60},  {50, 50},  {51, 51},
>> +	{52, 61},  {53, 62},  {57, 52},  {58, 63},  {60, 54},  {63, 64},
>> +	{73, 55},  {74, 56},  {75, 57},  {77, 3},   {80, 4},   {84, 5},
>> +	{85, 67},  {86, 69},  {88, 70},  {89, 71},  {90, 73},  {91, 74},
>> +	{92, 75},  {93, 76},  {94, 77},  {95, 78},  {97, 79},  {99, 80},
>> +	{100, 11}, {101, 13}, {102, 14}, {103, 15}, {106, 16}, {108, 17},
>> +	{112, 18}, {116, 19}, {117, 20}, {119, 21}, {120, 23}, {136, 25},
>> +	{159, 27}, {161, 28},
>> +};
>> +
> Thanks,
> Maulik
>


