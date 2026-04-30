Return-Path: <netdev+bounces-282767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAWMFQI182kUygEAu9opvQ
	(envelope-from <netdev+bounces-282767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:54:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D294A1152
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EA8D301AB82
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47B3B3BEC;
	Thu, 30 Apr 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+wX++2s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vu/YtEYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A663B9601
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546464; cv=none; b=HufSFi6Md7yqYPoENJ1+9jgze1hN+E/m7SG6eSlM92wOHM0defG7+/7ZvBcNWaxlCUk1cEVHD/f0jatE2UjnjAIsgU9wfsdqz68dSUGjmwTjn3BDbREEfvvS4hyWVBm60ngxxpX8Wp1R5B25gqb42LsNwMKyKKJc1QDQeEmM6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546464; c=relaxed/simple;
	bh=NiGIsc7+2BG9Ag9y3ftpDM4w1lYngC9h5iIud/W5nAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nshNSd8h5rWpO4exyFvQ/jCZeqJxfbD1hdrjEYI7/Fao7LfSI7FpAvfiWxxootesWgmWjShtHopPoQpNnK5RVRctgkRKzaeNgRF7YPedwn/yx1DGaKqcam6FXRV2JFQ0+LWqWPg9BshSsuxzhxWeeN2LDrsjACJNqXEeQDfsLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+wX++2s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vu/YtEYJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U7ZlLR088549
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1EDKwO1UG1K0QkJS89ldvgWnbt8po5vsN8CULEuSTRo=; b=g+wX++2sRsPI55ef
	GBVjeOGFlzHmNokT2GEZzxno+pNQ8Fn5VsAA9bd5S5nmCyc8e+aJY+oVBinzPl27
	fJwa9PlB3jt15/9wc+94ryDK0lalNl8ofgdg8J3ESgnY5mN/c7JVKbNJ0NbN4d1f
	1yQ+hJaSfAaRSyRjSdRKO409lOMZk7syAaokmoj/7gwTmYc73kxNEcK1fYkTcQwH
	HHqTzrC35ykQYO97Nms9pcJVOMS18LmKb3kcsD5z/OuKU+QzSaF8Z4ouixDAst/q
	si56y2gLKz5BEpei7AOUK3IXfDrHR5oL2ymvabNJEGWr5Ti/Vj0IYtpAEXDP6IGQ
	OYWsng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv2u40vm7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:54:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d63aeaaedaso16830285a.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777546455; x=1778151255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EDKwO1UG1K0QkJS89ldvgWnbt8po5vsN8CULEuSTRo=;
        b=Vu/YtEYJXwTR9WPd9KUV98J5qekPNzU2r+STjbP8T/0w93oNi6iTcmZIsdx5VF0Zwc
         +cDYQrvV4/9Ag9meTXp70BHZROhsWGrSdvsvQJ40/xwOKHY812bV5/eJf5+tTfaifOIv
         K6xa0UMG3K+XZWcjcyTVWMM7vX+a3URhS1OLFcfzWJPBcVbI3BvC/zFuL+WEUHYM7yJc
         oRBTWY5tAXGz+1XJWfQhCViwfiCZE7HTZktxBkzClZNXyc6i11mHR5Q5CC2w9v7SUODm
         D9ubudzto7sJzJKRxsyJqE9yAkqPrCbeXT2HfBp0yHwZcl+TLBSYFEzHD1ykURQk9yES
         RNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546455; x=1778151255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EDKwO1UG1K0QkJS89ldvgWnbt8po5vsN8CULEuSTRo=;
        b=AuBk9GPLYijHEeHI9JE9Kl7hivIi+c0o21/2H0cAhwL38O/udjfi8k94T9TCMAjw1p
         mcOSaYqaJahfqfN6zjXoK02/G3WcV1cVNX159RzB3AxmAq/MWVN2ziEP5VxWPRtSQlyK
         C6yvZ8xMUkM7eyTDRfhU4i/6pglgs64G+p71laXgfljhGhVz3KOLGDT9FIyHmgLHMr+K
         o24ZOsiyK41fo41frcuJqf1KvCNMowVSP7hgIUQWwZ2JFWP1BuOCTb20AtjmhGmNnOXV
         aq2twPjC2Ejtce0KkQKL/9xlWOXFrDfSIdv7156AfxNuLNjoWjixmSZoTJZe8UBG+WZF
         U6bw==
X-Forwarded-Encrypted: i=1; AFNElJ8txN5rnpRl9VNmioyq3NWJiwB0EwF4xct72HlUb6SGbGWlcWrQBUTqYZ7MRDW2NzQylfaqRsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddsBxCvVh9jPdDOCqPGqXcxekXzUeb8Tzb5cAmIOpo1hzCkva
	Yze1SAY4qbHoCpF5nUNMCXuYIgwGZkvkZXZqL3eeTzWPcTNZxtwh+gZ5RTxLSSylsTewznmnEha
	o7V/RQhzYfMpf2GrSJjza9IWbTSk9pCzLRGsPXm4mCliTz4BDMroexXb9PmE=
X-Gm-Gg: AeBDievfcRnTWn+aD7JNZu258ZR5Q5X1fZCFE5z4zbYjLM2fABcniMKlb5m/swKJRIz
	potgZdu0EjawI2Ae2I/Kzhz2fHoynBmwoO2p3u71Fq3bAElbQ8vubeHc+pevfRVgDKJAXhQ8f0p
	jjA16JgkvMsnKkVV+0Zgh5nWKGNwMkrqpPCdCKHd8UfcGe/7HfvxroIooOM80vWKgPJm79pe37e
	XOooa49+Hy58G3eoZRLXWwC7q40Adf5Bby2zBbmZqoKgYmahzqW8IxsbJMnAJZg4evJjDSIX8S7
	J6mk1e1R8eF/Jm3S4VfmIIqTOugn742QU3/uw0h7SD851/WnSM8hpMJWkwiEvFHhJ8G8zxl3TZc
	Gm9PQuBOa0LiOWh3V3Mbs4FXcv01H3fE022Rds1BYuOm5yT2nS+MT9xU3wnQlpvecBT0ac3EiGw
	KKM/scn6/RQhpMHg==
X-Received: by 2002:a05:620a:444a:b0:8d3:f6c2:5196 with SMTP id af79cd13be357-8fa88a4341dmr240219885a.5.1777546454632;
        Thu, 30 Apr 2026 03:54:14 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:8d3:f6c2:5196 with SMTP id af79cd13be357-8fa88a4341dmr240217685a.5.1777546454135;
        Thu, 30 Apr 2026 03:54:14 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b220d0656sm1771099a12.11.2026.04.30.03.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 03:54:12 -0700 (PDT)
Message-ID: <bf1e9880-745e-4c7b-bfde-3c5ac39175fc@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 12:54:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add Shikra pinctrl driver
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
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
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <38bb1b79-67da-4a23-a0e8-3c3da77933d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ev/iaycA c=1 sm=1 tr=0 ts=69f334dd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=JYc5Ya0DD96nsJLtuCAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: p7qKUUbObnx4Di31hNvZrnp1jio-XAJd
X-Proofpoint-GUID: p7qKUUbObnx4Di31hNvZrnp1jio-XAJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDExMCBTYWx0ZWRfX6pKdGCDI7WeF
 /dI0ATHMDAtkQQhb3IwDUn8KK/F8Hng5SERg9m7LH90ulRdHw/uWI5l2XymVQHHTlRzs/wHYrBt
 FGcOsEVsnCv+tQw4gikHG5RaPNye/HWXqTcHAZ2wxH+/3KRsY0rLzNit/ihRr43qT2xhOJULPzK
 EdoMu2dx8DuzlJHAhC5SKRwfT7s6L+yEt/7a03AeSJjw/uRVmu+stirJ0f/KEPH9z6JGIp/HrEX
 JKanD27jXf2061vqnkDuGs7+/1gDWIHaG73ouPVXIjXLfLJZRCSjDWyAO5FIb6vkP7ZOXvcX+aO
 Zfvc3eLU1BaGk/t97KRjFYlKC9rJ9Buvv3Tu5Vb8HWukGtq8mdLiVZmpoxsqdQAcwNfp6/6htD9
 rqsE5rJOhuo/w+KZgUWdEbu9PmMN2EEkvusRvXKhkoMB4/mgSMb8Ak+2XI3B7WuDTBFCJwemQ8+
 1BGZZ/vvRIsoycnCqvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300110
X-Rspamd-Queue-Id: B2D294A1152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/30/26 6:06 AM, Maulik Shah (mkshah) wrote:
> 
> 
> On 4/29/2026 6:41 PM, Komal Bajaj wrote:
>> Add pinctrl driver for TLMM block found in Shikra SoC.

[...]


>> +static const struct msm_gpio_wakeirq_map shikra_mpm_map[] = {
>> +	{1, 9},    {2, 31},   {5, 49},   {6, 53},   {9, 72},   {10, 10},
> 
> It would be better to have spacing before/after brackets inline with other pinctrl drivers.
> {1, 9}, should be { 1, 9 }.

If that's also something that the generator takes care of, let's fix
it there too

Konrad

