Return-Path: <netdev+bounces-283738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMqEHspQ+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:54:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E44B9AFD
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D673F3003BFA
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E1311C3E;
	Mon,  4 May 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eB7tNgAM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R29SngMI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1E30595C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881259; cv=none; b=EWWvBrarmAfAJE6fYQrFB8mdLFeULMbKpzkMM3h96IJeywM2fynvNMA5v/3FjIzSPUMCWTtKF/KV2M7+zA6caSLEBN7U9TYD5pP4S7P8WaIvuU+vGJDOVNCuDOqvHo8GIzCgQh7MnaIDzT/Mk3tp07Bq0YAnBLnBI3FoFjt2MvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881259; c=relaxed/simple;
	bh=T/NTBBFEzaxAlwpKUc6y5t7nXGWmMKdb9NSBix0FWmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uykU3ewZ/IbH/wjI0yyxPCfbTdniAVcTal4f0sx5aKjbi0Xe55+AfChyyUkV6W97YBj2UQsr6i5fLCp1L5HXsW/cDxjUhCPcX6m4L/n0AcNv4AhdO4HEKBuoFIjixjJ2i5iFWiHI/WCvmVRJvw3TODvXFI1i/JgtteTHQRv+82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eB7tNgAM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R29SngMI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DaU73470957
	for <netdev@vger.kernel.org>; Mon, 4 May 2026 07:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Za4labmzB8LC6ifgc58LLb3FdJ28JeS0v47Vu+6GOvQ=; b=eB7tNgAMC4ra69B/
	OtlZTyQyB7nFDWo+BDSEiD4JS4TctqFKtCMdJtlMRTVKUpbUFlTWBScO4RatFCK0
	tNwn8YdzCOOFthupdnoPRNTy3Mg1rlCXa6X5016QZxI+q1jLwePiWG3ZAR0OQglW
	6Q9vN86xjh1nE3vA4XA2t98QIzKe1i8G6Z0YjRBoB77ifJKoo1DVTB/4XxGGHyBB
	i7N4lb7VJ4+MiBI/D6a/g6NfZPLc9swyooOYmK2n4wT879tHUje+xAHSNeRZPACl
	mEnO5K+CnasulxUpwpG+qjJ27uxADpkRHsBCp8vgAVFswtrQbbUeiA0YceEt7Vkq
	s4lW0Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9bvms4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:54:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c797d8c9c2dso4691394a12.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777881256; x=1778486056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Za4labmzB8LC6ifgc58LLb3FdJ28JeS0v47Vu+6GOvQ=;
        b=R29SngMIf0eRuWbW/MmUPNYc4YbG97dScZQdR6xIj6QsUY1WLA/nl040hCSbTvuVnN
         VEIjidBS5NqW5XHbQgzpppdaTBodh+6oNg2NTuCfXSe+TvchUNwkevtCu41wYQThf2r5
         MloiFCyezG6YWHjNS+wZ/YYCp7lybj4PHedeqDTjLUVqBiX0ZmCH5XTyhhK/HfOr1DF6
         yqwCOHf0UWLnLVT39ynlUjA7xdsn2Hmr8aBH9yWzP0FG5q208VK95y251ailqoe4M+K+
         HbvTUw1Sbq3UlLZnznNiQYIn34w+kLgGjnaZxNSez7XM5UMj+ZiviSymKCLK3gReTJuM
         rUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881256; x=1778486056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za4labmzB8LC6ifgc58LLb3FdJ28JeS0v47Vu+6GOvQ=;
        b=aADloKmmmD4tcjvRSG/otoGcw6bUsrUKgiGRyj0/4SwXb82h/pSPiSouLvIOJ//2gA
         iHLVj4IUG7IFXalkT/BeH16ZUn5EpyU9xMP0RtqDCz1y7p8/ai0RaXy/fM6/nK1eBmJP
         rB58LK2NfUICv7yKyA9Wj6Jwmx+kqJ2wHlWnf1eUM+iO+nKhkqOuLrq9o9zj/JtKdhiD
         lsOtC2eHdkP23bDV1dpDL/MgQO5BVt+IsqPixuPxMDUMPyA3AVdY9ABvvm904RAm8buR
         y6kqceXHdc3QMJwTubxeV8BVFZj5VPu7TXeLq8DtAo0YBpDfT7uQewtBOKUUQl11dH2E
         sywQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WEJdIeRL4c7i90SY8Y7oUaUleSSHkb0NGW9pnBSLbM1oUg6IOGysjTkoQgB3E0544BhZF+6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+a4R6/zRl1HNNRuxeqKR2sLWmfoyzL5QOL90E31qRXMJkwkY
	vzr0opjgkuaCmdNErUI2qjxRwMiTpA22RoX60hOzsP5M4FCcyG1GbYLivYgNzpFz7IBHcwR+BXR
	queGlhb/jurc35WWlgsQRyemrN7ETuSBrBgjsP+dhik0anLKTgfzTvYbJ8tY=
X-Gm-Gg: AeBDietUr5k2B/WBn7d8Si8KDExTlEkNJyXpTxzEOHPxFdabKzErfp3sFdupwpWthHH
	KHCMV+ds8hSRuxsNQ2W8jjmHlH0oIdMI5T3IPTtIU5d+NaBgF6DcixOW0hZw+RJN9bo9ezovj3F
	Wy/91xwPfVM7nkHz4YR1tr8gzOjmjhtRwgpmwOptp9p+nSqVskEMnslgB7T0BC74paxM+3eXbTq
	9rDnltghHw5X4B3q35tyoNykN1XSsOkd4PAeySry6yNIpcikneBRKHGdvoRLEkntP5o7OUyAD38
	WB4/y9r+DSR2a/4FJ9jvxHvpcUcX5hnHjnbv+wZlG5Q/0Cpbe4PCLfcg3Cn+3bzGJEgSGEpuQ3Z
	ySD0/c4VrMz2a7NC7uVAm2qkMXd5pCCx9vrpHu4AX3Ope023i3QJ+3N4gP6M=
X-Received: by 2002:a05:6a00:300b:b0:837:7e7d:3c8 with SMTP id d2e1a72fcca58-8377e7d0876mr2821345b3a.39.1777881255879;
        Mon, 04 May 2026 00:54:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:300b:b0:837:7e7d:3c8 with SMTP id d2e1a72fcca58-8377e7d0876mr2821322b3a.39.1777881255415;
        Mon, 04 May 2026 00:54:15 -0700 (PDT)
Received: from [192.168.1.143] ([59.96.95.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-837a0578a92sm2350052b3a.57.2026.05.04.00.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:54:14 -0700 (PDT)
Message-ID: <f671a58a-d3c1-434e-8b47-472b89f520ad@oss.qualcomm.com>
Date: Mon, 4 May 2026 13:23:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add Shikra pinctrl driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
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
 <bf1e9880-745e-4c7b-bfde-3c5ac39175fc@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <bf1e9880-745e-4c7b-bfde-3c5ac39175fc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TaG1ZD_jSDiDXasAabeQwOKN6yHiwolX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NCBTYWx0ZWRfX92B9THDzrnhC
 QBtGYp1kpNxWrhL4E3045rEg+rOgkjlFMsxhHSQeOAV5xwbcgfD1c5VmOFx+wrubS5T2SG1Vrp6
 gehqxEruo+xbFG+hCDNPamIbpWXXLx4BzzuUHqGzAY9jV7hTIAFueoXQR519FC5q5tRrVEveyVa
 3dY5ozDkRAXtM+LXu7j5UWyoOqo9Sd6JrfOGCC/evemXIWW9DrvMPBLoe4kbL9EsyhbVKrVeMWs
 KiaIhT5by3WfVbktDAcSnIPVeb0uPH5BD/SZsHm9X5EHC0npoQeUT440Kd1fzjO5FOuE1xfGm8X
 cxwjRGP8NTgk3qADghLgvXpvoEFO+l95wTrORrFeyEAuuBypeubVHN/ZhJugeRs7Pscf5cld003
 oMwHKxkTi0O/tho9mpelg5ciAyvl7Akz865ypu2MhRxRNsOJLntgukZrF93FsnDTRq2FL3/Hxwl
 1ROaA+ysQSjGOMBZzWA==
X-Authority-Analysis: v=2.4 cv=dqLrzVg4 c=1 sm=1 tr=0 ts=69f850a8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=d18XUvOkrfNYrh/LwM53Ig==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=v733AJcmkcc0okto1YYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: TaG1ZD_jSDiDXasAabeQwOKN6yHiwolX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040084
X-Rspamd-Queue-Id: 747E44B9AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]




On 4/30/2026 4:24 PM, Konrad Dybcio wrote:
> On 4/30/26 6:06 AM, Maulik Shah (mkshah) wrote:
>>
>> On 4/29/2026 6:41 PM, Komal Bajaj wrote:
>>> Add pinctrl driver for TLMM block found in Shikra SoC.
> [...]
>
>
>>> +static const struct msm_gpio_wakeirq_map shikra_mpm_map[] = {
>>> +	{1, 9},    {2, 31},   {5, 49},   {6, 53},   {9, 72},   {10, 10},
>> It would be better to have spacing before/after brackets inline with other pinctrl drivers.
>> {1, 9}, should be { 1, 9 }.
> If that's also something that the generator takes care of, let's fix
> it there too

Sure, we will try to take care of this in the generator to avoid such 
cases going forward.

Thanks
Komal

>
> Konrad


