Return-Path: <netdev+bounces-265810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFAdBDFhr2kmWwIAu9opvQ
	(envelope-from <netdev+bounces-265810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B9242E8D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B945300C3A4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553A175A9C;
	Tue, 10 Mar 2026 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dUPs77F4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U7zkj9lU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F39126BF1
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101353; cv=none; b=hUoCKJn2OBC2Lmm84ZIaak9a3yDIp9O4sAdSLyaif/heBXtlpRe9V+ri35z+CWajL+Ib0R1VkkOPlVVWlY0D9+mfr3Nh7PjIGAIjCk6K9Dl3PjMkkKKMQq/sWoS+PwDQRgavrRr30bzejMFO046wPYXsAl0F9by4+lmtSBI+FtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101353; c=relaxed/simple;
	bh=QvXfmbJud8HzeP33fX/kWH1MUfsrhkVzJGAW2ruT4+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVsLpVuLiEN91aenANxjt7IDMgqnEVunIbgYxrZrG3tLRTwSDwPU/ANSynZbxDsuTH/O4tCfsgg2QHuE1fukvS65s1yRK65zW4vJUx+cqjiFO8+kMwvt4AEwfYZy+i2nVg9t0Jr3kRk56CKwNAExT1CcDhXXTxQ+a1yNgxkRMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dUPs77F4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U7zkj9lU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBsrG1298074
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UzZKnoilqHx4458WKUDAbi2+T8n0C2ogsIPespO3GAw=; b=dUPs77F4pGXERTFD
	81tbz3Mys0cMxTotueTQZHr2XFKWf/Qrv0mB+kbTYqLTg6OKniVnRA7wK2D9ZVdF
	f8J3Pjfj00iYMNPne5rhQ2Ij6e0qFSEruhvUob6MWoygiBwySVHZtzb0fPGhuy+c
	r6GHvu4r2mnszOM4EqEscrBodR7PJJmf7xLXrK7WpKaOQQlEdNrjNZlHrl5mNeZb
	GLKoyRCaJLbuZT+o0k8PpI7lH83lHxqI/XwP1E4oQvNK3n7XgyibmT8jsmm2Bo5H
	FRsh7ENIQv/2QU06wGk/QKHEgYJiesvRZKtqycMfTdMbl21bIm7MhBuE6f4dWR4l
	0GkcIg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv19tu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:09:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd8b37d4b2so912710785a.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101350; x=1773706150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzZKnoilqHx4458WKUDAbi2+T8n0C2ogsIPespO3GAw=;
        b=U7zkj9lU8XjQER+Hrn5O1DB2+uuc2eSJuIwZZsliPk3febgqNoNaULUmCfjgYrcqS3
         dV24LrnpirIfcPyIZdDrVRVrEcS9VTd3bAQtxdsYbJeSotZJ+ozz1pZm5HoqMsnzyj2C
         7ZDWvDYzXR6jVqCUNGgVcMLLQAFqlZNDInwfMyaXkK4dFdDJ/uZT+HE3EIg0Yas0MUBy
         LL0I/grzt8Jk4Juzilu4HSBIK3SCzBugJ0L2M57rXEKDsGotweuKuZCUIJAdySF1APD4
         0m95WgBIe7LCeGR73RrsviEiQ/tDR2s1/yKIuX5ZrTZ0eh9iQLltqfs+0M7ho6HAQxiz
         2cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101350; x=1773706150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzZKnoilqHx4458WKUDAbi2+T8n0C2ogsIPespO3GAw=;
        b=pWq1ai4OxBIC1z2xbNt+D2/YWqOWD/fFlNKjePWuGY0CcB3HzmIklZi4viXjoZH4tV
         wqw92CHlNxsSVavPYiPwVYvNOG414uBa1/LDlGW3UtdGklznqrhwtdVJDKBuO2FKfMAM
         Sz+lmZTiMT6VnIt/hbP1XPWU0/RBB5WMyxm6xnvV/y/bFieiRdzZRFHEWaAowsN5cz6O
         Ue2gjdJEFlX5c9cz1c/lwiVyhTV8wHWLp8zuZLX6nfxqAgSef4GS2dUbIThqu9xv8lNp
         psUw/F8gF24icqleCXmxTzIDs6V09n1gRcLqGTnR46Dx/ZG7vZLgGwbBIE5kRivH3MsL
         XP9w==
X-Forwarded-Encrypted: i=1; AJvYcCWvE3kGE5ARppwsE13nM/I1mx7zYHFVOZceIzZFegGlM/jPT8uDheMhwxgQ+484j+OC2rSG9WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJHLFwpHsqcT8CrAptpa9mdjqsc37rydNHHY7/K+/IIO9y7Y/
	+RVF2gmX0ix8QqvopBA7Q0lUKJ3EUBpMLA4wBrT1Shlxa7eN8sIMlyfgRqcG3fsyE39+P6VXFv0
	IA8zdoiirnVxVucAxvEGeUZnop/X45K9bp6vT1nWyyrNeNWnpqzWuuS0Cmo4=
X-Gm-Gg: ATEYQzzk6EEgKvcpg0a/vV1+LEDJLPYcdSA3hKZjncByKLRg4WezbvG8Mu1+8MDp/Jd
	SmNgWNXN3L4cwL1BE7qzHJLPhBNwsDWukYP0ZdVAHC4l6w6tPvS9ky6vcG3YgNmGllW1qqkgqyO
	2BeRPP4v2pEkbU6A9Pq3NA8wwMk8aKpbRyErMXwHXxmMwqf4g1G4PmlaB7TD6HrWeNGLe/pjlmD
	P5PHzjmaU3bn64btwvfwcbKXk3zlMP1AeXP7cgV2dA0FH95QVzrRpodofhzU1LrDR6g2+mbJ3nb
	mefw2FJaPg2opq/LDpHH9pb6gxUG59jalRKgaRpc68So00wpJq52wdxW8KrClseSTrn5jEsghjg
	1Or0ukAoy9oKdUKlSRNmRUlXOZ7V0Ogmdiyh7/edRfRFp/kA1IILI3lhghHuDOmZNtblD9r6Ukf
	K49a/GI6jn
X-Received: by 2002:a05:620a:1485:b0:8cd:75df:f2fb with SMTP id af79cd13be357-8cd75dff685mr1012757285a.65.1773101350459;
        Mon, 09 Mar 2026 17:09:10 -0700 (PDT)
X-Received: by 2002:a05:620a:1485:b0:8cd:75df:f2fb with SMTP id af79cd13be357-8cd75dff685mr1012752685a.65.1773101349998;
        Mon, 09 Mar 2026 17:09:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm28840297f8f.3.2026.03.09.17.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:09:09 -0700 (PDT)
Message-ID: <3283cbae-4100-484c-9b00-1d7111c62456@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 01:09:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Group QMI service IDs into the QMI header
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, konradybcio@kernel.org,
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
 <9cc7638f-1232-4cb7-b4d7-cdac66a2f4ba@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <9cc7638f-1232-4cb7-b4d7-cdac66a2f4ba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LwR8QDJShN9uNwiHS34QhDUKRdWFZVRF
X-Proofpoint-ORIG-GUID: LwR8QDJShN9uNwiHS34QhDUKRdWFZVRF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX4Jx7ve6uHGuT
 6JLaHdxElbnGO7ptKcr0qdPGOuP3ZWGyk6lIFHcmeDl7PbkxSmaZJ9Z4BKiBt8L1O/VdqpQMN68
 PNkNR5RBmYxaSlZ6RrOfKISTXr7jaT83vp0WvwEfS+966vaoX+hhxmyTrRvQu8WSYgKpOnPOIcp
 KYgnLdp6vZSOkt+UpSlrattV4F2DReQwRnMQkEvlJi4WZyZ1QfjNBC2/0fMzb06UIXUIEo8bw9l
 HWSNm3t47dbnc5BOXAB+PJCiyjgd7ZigZ32/sYuez9UrLWGQ/ET2DDiZ2bdGGoC9E1a3OQ+gso6
 ADfj9KcP7XPcp/uA6d9fkAxae+2n/Dv7MrnnnrXgvUXCqhP1RDtFs0KgAxep0fwOoYjaZmHdmkc
 GU+NnQ+Td6VAI8Lc9l2H6O/hi46xrt6HJC+2UBsa8je4mZ57+kBRbuHRiH6ueYZW2oDcJn3MCg7
 U+i944ho8iypZZMHvjA==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69af6127 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=H3M1aXInkkIOK4AFoC4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: 0C7B9242E8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265810-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/10/26 00:50, Jeff Johnson wrote:
> On 3/9/2026 4:03 PM, Daniel Lezcano wrote:
>> The different subsystems implementing the QMI service protocol are
>> using their own definition of the service id. It is not a problem but
>> it results on having those duplicated with different names but the
>> same value and without consistency in their name.
>>
>> It makes more sense to unify their names and move the definitions in

[ ... ]

> prefix for wireless drivers is simply wifi: <driver>:
> so s/net: drivers: wireless:/wifi:/

Noted, thanks

>>    remoteproc: qcom: Use the unified QMI service ID instead of defining
>>      it locally
>>    slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of
>>      defining it locally
>>    soc: qcom: pdr: Use the unified QMI service ID instead of defining it
>>      locally
>>    ALSA: usb-audio: qcom: Use the unified QMI service ID instead of
>>      defining it locally
>>    samples: qmi: Use the unified QMI service ID instead of defining it
>>      locally
>>
>>   drivers/net/ipa/ipa_qmi.c                      |  6 ++----
>>   drivers/net/wireless/ath/ath10k/qmi.c          |  2 +-
>>   drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h |  1 -
>>   drivers/net/wireless/ath/ath11k/qmi.c          |  2 +-
>>   drivers/net/wireless/ath/ath11k/qmi.h          |  1 -
>>   drivers/net/wireless/ath/ath12k/qmi.c          |  2 +-
>>   drivers/net/wireless/ath/ath12k/qmi.h          |  1 -
>>   drivers/remoteproc/qcom_sysmon.c               |  2 +-
>>   drivers/slimbus/qcom-ngd-ctrl.c                |  5 ++---
>>   drivers/soc/qcom/pdr_interface.c               |  4 ++--
>>   drivers/soc/qcom/pdr_internal.h                |  3 ---
>>   drivers/soc/qcom/qcom_pd_mapper.c              |  2 +-
>>   include/linux/soc/qcom/qmi.h                   | 12 ++++++++++++
>>   samples/qmi/qmi_sample_client.c                |  2 +-
>>   sound/usb/qcom/qc_audio_offload.c              |  2 +-
>>   sound/usb/qcom/usb_audio_qmi_v01.h             |  1 -
> 
> You are touching a lot of subsystems with a single series.
> How do you plan on having these land?
> Do you have a maintainer who will take all of these through their tree?

Yes I thought Bjorn or Konrad would take them with the acked-by from the 
different subsystems

