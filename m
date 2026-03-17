Return-Path: <netdev+bounces-268493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJezMG0WuWmOpgEAu9opvQ
	(envelope-from <netdev+bounces-268493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:53:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7DA2A5FB1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C3030057B1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A939D6E6;
	Tue, 17 Mar 2026 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ASZ/MVVe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCClEhJU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20430AAB3
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737498; cv=none; b=bCv56pLYR0VAWf42fKLJW1I6cEuOnAWQ10WmG/z6G3sAcYe4kJGbWiJHbJu6verh+cedA15XjjfQZaL+w4PDVdp6Zj7F5VrN3crjuVZ1dRjr8HKLStdpBhYK6pYQdUHv4xCjFIqzAws5GmXjG+wdEWg+yjBs0cA9pHNi2JRRugE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737498; c=relaxed/simple;
	bh=4QgBtB8A9KYHumYiqPxwg3Mhj07QBFZK+AfRokd9Gas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKxsiwIIW0sXVs39N34hweZaYEncNnGx31YvnktsJu4rdYDLAZ0IkBEMYvPBaPab/gdCtFOwybSKnFITSuabe//jKhErh3scbhWTq/U1EUT3M6oWVFiYgALMRwOYOJsG37+FL70OqpJFbz7HAOxKr5zdEX0TXEtWFcnEOATS8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ASZ/MVVe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCClEhJU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H5hw9R1042729
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 08:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxITSj4z8OO1NrLzEXCXkSrkOXhqxZm0zTAv5L09paM=; b=ASZ/MVVeGtJMu1Fc
	XLhAANnTMxH1a/V03vG/LTkSxc0F4h1bFIMtAPhjCNfhnr3REamoVzaRvJ/Ifm5q
	DWpnOtIKVZ2lztx3+oTq0s6N3eKWOBuea9uI0iDZ/3DENDJ2W4IrKaTj0qitnYsP
	PTKVUSzhCM3E4DrZZcryCru4YuPS/gsXqVf5pYvK1u5TnwI4y6JlvXMSeP2McicD
	+oZUlt7pYG43FnWbT6wLNcih1Qj/3DZZC3c8zJFvrpMgtwdfF/FtCG5S9fRhbnGF
	JD5kglBhyIBwiy5g50f9b51gKOOlJnxwyhF91X4sV0+pn+xbASdGOs+h0EFSpdzf
	YmkcHA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkuy3782-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 08:51:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd98d96382so621142085a.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773737495; x=1774342295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxITSj4z8OO1NrLzEXCXkSrkOXhqxZm0zTAv5L09paM=;
        b=iCClEhJUF5Dcxya/Kwlwq5RgaYQDlrMdRhjSM+zbkfkNUe8Q2NQjwIb2whshr4RLRz
         i6uA5HNBYbSMy10DqSa+MIdei7aW41WMeE5kz6tuahZO8PY6AqxAkGURslGhd/5EeOty
         8wGZyJ01oDHlEn11oD3IYkpIaWH6PMlUJT4OypKjFfkOtGbhZSWYr0dV7NXE793GOa7c
         MQgjqV3WcrGq3fWPplXE9TwZHfbD9EUvL5inAKAaI2bCdyPoEpqVqrgmpz/lEfF7V02J
         qo81rN324pLXtKJRRPN1oUggUuSlI1CDATPlxnc+khQ4xSK4a6iR1vMd5wjHk0iTTZSY
         6p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773737495; x=1774342295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxITSj4z8OO1NrLzEXCXkSrkOXhqxZm0zTAv5L09paM=;
        b=ohiIdRiN7/rpyVox3mau7BEYhvE1Vc/hHw7cxifWlB2RtH8smax7OuDRGNlqkTwbVl
         6mid6T1YxKmWrvU5GNNNBhN6hCa3zI02vZwxIPuVgR6VgAsmUFH7PUnJ0+wllMy+16AA
         ZQ9t7yGOxP27WOK0akv5YoxMgqXvdFY/zBiCPYEDZ9iO/f3QYiOMGWp/XfxWetGZmBrh
         jXHJTvQI/xXVGpsC8LZ1HKf5GcqOMvGFogrUuaDsbQFr1RHhAHu1dyk7arQqkakd3rSW
         JwbR0DXZLM6YRI9sf/hHDPufG/Z6kgVl1VXQG8XUzCZviRObudXeograpnRPcuw5PJVd
         gwew==
X-Forwarded-Encrypted: i=1; AJvYcCVDr2lV75PA7f8MXwavDmnM/eW5CBFguKGMUhhihVxrgtc7OxUqsee+aYCAJtUev5rPYuYE4x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6PBo34NVsKKn0azYSSR7rDSMZpNGCbNMWqi1qiTFqCx8/6Sp
	r2MeEkW6U1bS9zIqoMkP5TUyETnBdZavZF6ncXlhY7NGZYdKhkBcIxdsd7ImxJ5HCXvXV4kGyeg
	GHuy4nbKUVVPxXnIeow93gxcdixC9L2hsjGbbQTTCE4NxfdaNFkgLxQ9gYNc=
X-Gm-Gg: ATEYQzzwRgRy1G4aiJsumd+f+5LOKOD/Uju3Gz0hKoR+EEPQXBjEd/dh4oGnprKc6a0
	oYtbx8tm8px/mri/T/6AX6J6XszKzbnqYUu4lVoQjjhB8iWDQOIGWUVixWQI+zTBHC4RVBV4VvP
	F2GeKekIEB9VLUHnGQnin9Fhj6QeW1UXhF+QZEQvLErwr/Hq75nvxFgqUBzQFsML/DQ9bemzD5S
	jA5ciUMHeBS2b5MM9ENaT1Us94rAHsul0aaLHpCGihnAVEuoLP2Oj7M/uwPDIkQLCXApoVj9LEv
	RmbN52i38WCiWaPsw1X/H1ILQHHIGKS0VkEhCD9aGU4TOiDlcXoc6R+bJlPs7bXkwBn7jCQiaPn
	VgKnu6mwNdJqLFS6pTGkvcdF9UpWxguYXYlT5/G34JtYOIMK3/7wPnWlbDDSqUlbdwo0+c6tDlk
	zzMSuKhpSC
X-Received: by 2002:a05:620a:2915:b0:8c6:e224:d55b with SMTP id af79cd13be357-8cdb5b0a024mr1966586785a.41.1773737495237;
        Tue, 17 Mar 2026 01:51:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:8c6:e224:d55b with SMTP id af79cd13be357-8cdb5b0a024mr1966583785a.41.1773737494732;
        Tue, 17 Mar 2026 01:51:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:67fb:53f6:20ba:ff45? ([2a05:6e02:1041:c10:67fb:53f6:20ba:ff45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3322sm46732245e9.10.2026.03.17.01.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 01:51:34 -0700 (PDT)
Message-ID: <8757aec7-8c36-446a-9a34-f0717f64202a@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 09:51:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Use the QMI service IDs from the QMI header
To: Jakub Kicinski <kuba@kernel.org>
Cc: konradybcio@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Jeff Johnson <jjohnson@kernel.org>,
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
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
 <20260316172251.2d57d0aa@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260316172251.2d57d0aa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=69b91618 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=rySjVtX6Rl8zv02YFYoA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3NyBTYWx0ZWRfX69Qzl1d8Nocn
 6ufWVneIw7esVFL6rtVQ5bcUMxi5p4KAip2uKLDDoxmmppgrOMFxdR0Hnc7fi3kRUEKmHmZXTy/
 54ELIwfGvBKQi5xaXAfvak/uZ14FgtjQPGlWiSwVwvE1yKYq+qbWGhGPorY/JLUNHRI7/KQGF2z
 AATCuLjYt+xF7B96Aowa8+C4F0a2RJ0Dn5Q1OE7S3LdA3xU8S9GUQ1kpx9BdNCT3Ckv3pdDZQ/I
 f+jSpBfFgq91wT3y6UBgtT5AsptPKt5dnGHpaRWcljHVkr7ipmFW82lZ7uTJB8CiqhIs2kt7NUY
 Kdd4Jy+5h1A12IOG2u6DZJlfBBU2ANs50P797Nv/81bQgraCywtdDd+Q8x6KIP9gS4GOV0gQziu
 aM9JOFa6S+yi1RSsrGC9vxnbr+mz68qhMjAYrHtvEFizeiHz5faVceSXwwHsueq6KdSG6N214TV
 tx48/M7tIeq0u1Pq5Vg==
X-Proofpoint-ORIG-GUID: 0pz_PcCeMVk4wI5Curk9ggwH7eVRqBiZ
X-Proofpoint-GUID: 0pz_PcCeMVk4wI5Curk9ggwH7eVRqBiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170077
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268493-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E7DA2A5FB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 01:22, Jakub Kicinski wrote:
> On Mon, 16 Mar 2026 18:14:10 +0100 Daniel Lezcano wrote:
>> This series is based on the immutable branch [1] containing the QMI
>> service id definitions along with some drivers using them.
>>
>> How a patch can be merged ?
> 
> Wait for the dependency to appear in respective trees after the merge
> window then repost the patches individually. I'm starting to get
> annoyed with all this cross-tree QMI/MHI noise.

An ack is simpler for everyone, especially when they are trivial

