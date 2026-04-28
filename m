Return-Path: <netdev+bounces-281994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH0mFeHi8GmoagEAu9opvQ
	(envelope-from <netdev+bounces-281994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:40:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5CC489262
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 282A130022EF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9B03290B0;
	Tue, 28 Apr 2026 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7SzQjo2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYkd7M3l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF7326945
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394398; cv=none; b=ksUpwYEyOKyZbs4yhTH7bz0T5I5Xql2wQ0hMoOJ5lBqtMqaAUD5fZup4/gCKtBGoVhHzr3cdQsZRAZGzbsamPL8u+6kt5lQrG+CEUfnoDTmZPAVnzQ48zcKAMnc4yDtyeKVeAbgo3yCFaYQxxqeVSdF4XpouLBJYO+Fwsi6114U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394398; c=relaxed/simple;
	bh=qZzhuuormOf8Rul9WUs1IcMncFOwAXE+8P8hcP9siEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx4FxanCFRuI+EQvTKLdEV5OeBlW035ZjRS+NL/zaMjbTNXwHBFOejMBqIjZmtpYNojQvbuhGdaju0bYLSokqAE9SodaiJlN7fgFitqU0CkCDLvONqZ4WY1e16X6Oo9TXI5ZRvg/ZUXVlKVoMW1QPd+4kpsGrbrG4wF3u0au+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7SzQjo2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PYkd7M3l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SFsPXK2843872
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vS7MZwC/c/EdYfGyVktKa95cOMof7DSqpzppE9rq4aQ=; b=f7SzQjo2A6gvPSWl
	4RSvhk1zwSXT5U1plZ2fJ5UTix3BYVLRUWvlmwud43vB0Z+JYf/OqNXL/5AbOrrG
	8mTZis37OGV2svwSeXhojxzhKhDvnGF3b0NiEXfvTbiVqOxmmpWe0YZeJUfcimO2
	n40R+UEiqXUZsBVkMiItGY+y6VBrQ/XMMw9sIwJ7f8R4Fx0xZhUcwQ9k0dURvFK0
	GOw8air9IRe8GaiBlW3fY3MeOVtlGFz5MVK/HPDRUIrGLlxSkYc/7l2YnYrMRUU2
	KF5YlhvY6ijYL26viLxaEbmRPQepuH9rTNJD1l7hW2aLWwIXa0ExsIIEXCCL58Lr
	gpo/pw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryda5a7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:39:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2e60238adb1so29393045eec.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777394396; x=1777999196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vS7MZwC/c/EdYfGyVktKa95cOMof7DSqpzppE9rq4aQ=;
        b=PYkd7M3l2rol7qbMxfQktGLF9kkFmuNQpkXpinnffGbsC1qXZNJk7uSRfnxgQKPVfC
         rHq6CLx/9kkDCpOBNHoyu1q11eHWl9A2kVRampazY3cVLo1zowGy7HHGHAd4N4sbmJKX
         yquzHKnc/lYscara73DVETctt+Qq0J029iAplhnZ9jfIfE3GB8u3/4X1EmtvnrAPJQ4Y
         qPj7RjEph9ryUgsSAw+Ymu/t+fOPOMpFo1LewPm2fujRmtUfINf5bN34coUk/A5ubaFS
         TrjRy9vG4oxbYYtTa5uM42ArxgdWfC61tjcZQHDrz0b1W+wdwrOGWS2KPp29wFHwUP8M
         lVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394396; x=1777999196;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vS7MZwC/c/EdYfGyVktKa95cOMof7DSqpzppE9rq4aQ=;
        b=OtUiwEEUYRh3XHHwcybwAHHtWg6x/ADikKA38dZSrFS1Jcr4uZL/lDCi6aI/gLpBM5
         rEQz8pggUB7mBnqVhNwX9xnfhVwGqQHHXgOcSbXS2Od7bOwPq1lu3WlKXCeSJiY18rIV
         hkOCe2gMVyF9pFMbKD5y01UJFWuJzkXu/wp3s2PkYkgedTCaaDzMFm0VC4+r+35pxggt
         dZGZZjsvyy4YHl4BS8x7OwpbvZeYMI9d6ym0uhOOQ5tAkKgaR0CQQ1GYp+mSuEPjJD7u
         uCcQ3myRQWRkrThTvflW3gLIp2t+g3Tu8S2Los63UqvgRoAQY1vDNuJSH5SY/T+aR2dV
         CWRA==
X-Forwarded-Encrypted: i=1; AFNElJ9eNHDj9rx2lKDCbplWiDTQSD4ewsYHjPJCjrmchYUfTeU6k2jqMfkPMlhU4vrq3To/KAGp1BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2cH+STUr9bVEBSX6wtUC6kpBLzwlzEC9lNvAA5kmb4qT6gIh
	MmOtwvaTZRGSEbzLt7ITMtQ7NPJehJ4JmabXYR+7G0iWflsUTAOakbT6WNW6UyeZ/q78OW6Puqv
	2wLSMgqzQBZW5MBshJUZpSppo94GRT+GSpeRbpGP/03deCH9jffgqYZdgmXI=
X-Gm-Gg: AeBDiesZV8+K3aXa7tGY5qmmPnNamwUP61jN8wFez7B3fzEOZ6oFmbjw+V7BuCiFbtM
	42LruziF5aphQHZ6JN2awyevvMh5ouFObKudxI3hdESOO9m/+ZsGhPkFFibOtJ67CEYg8YmTu6H
	as12zO2hGQVb3/g1vGLl13EC6JuSCUCtYfIwVUx70yx2ofwyEvDbWf2bUcSm5k7ajgDGbyo8Vtc
	FpmkMni9K94bei9Mpjbt7jtEKG2B+wJl4+5aHUWpqqJD5DCD3NFctnl1RRk/McNspRptWWME8Pc
	2vleM7++uCU3m5bJiAPl9rLjQQyvfTtFMKedUjryO8LxD6B2x4qw9Adog+OMmVdJda/k/CEj5CU
	Ua8zk6x41i4pYNPaXy5tc8QV6l7TR0JMFbP45ZvRoaRVQveMfhyQ4U8dkyh1pQcn/ulocpuOwLH
	yVRUSRlagjTqeCZiM/EtN0DzDz
X-Received: by 2002:a05:693c:3006:b0:2ea:3370:6e51 with SMTP id 5a478bee46e88-2ed09fb0d22mr1787688eec.4.1777394395778;
        Tue, 28 Apr 2026 09:39:55 -0700 (PDT)
X-Received: by 2002:a05:693c:3006:b0:2ea:3370:6e51 with SMTP id 5a478bee46e88-2ed09fb0d22mr1787668eec.4.1777394395038;
        Tue, 28 Apr 2026 09:39:55 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a0ce878sm2622054eec.16.2026.04.28.09.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 09:39:54 -0700 (PDT)
Message-ID: <e8c37614-354f-40d3-be3c-983f45e5bb3f@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:39:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath: Use the unified QMI service ID instead
 of defining it locally
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, konradybcio@kernel.org,
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
        linux-sound@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
 <20260316171419.2619620-3-daniel.lezcano@oss.qualcomm.com>
 <51e28a7f-8362-4bf1-9b9a-9af9cda1d748@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <51e28a7f-8362-4bf1-9b9a-9af9cda1d748@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G5pAfJKnV_DUTemha6lHUaSc9DXKtr7Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2MCBTYWx0ZWRfX8Tu61rT66zA4
 ICYsyqAOT+H7MSwO+ixMZ1xcv9XVdqCFMjMvSzc/ZqMMoF9mg87i9FyrbVYjW0BEoGX2KmMGrhZ
 Xy7lH4yriFYox6r1XeXrStDqepK64UUlJtu2t8wrhgS/aVqm+o6hVbBsZziUxitmPKa9G/+hpIN
 vYBRkwfYN2zqPEYluxdQXWIhJzPP9z/+TnCHkRMDAxE9FrtTQOEv2/MfLJkTJRfP9dwjNSfTMw2
 8ddv0tyMnifx2c6D0xhGUKXSiMO1BzwjPeVbBZV5qesO2KrQCfvypsVKZGQbdPgrFoxd4gSSMFd
 OFDR+ngjd0ni18svLP9en++7ifLhpVH6ziXSLgqMlcEGypql3x2OR4O+lzvcnYKEiT9a0uBCuv0
 5KmuxmA7Zfsd5hfPx4jBuEq1QamVM4V7h9uAM7EtwLHwaMkLYwXEr4zrS0kAQn8dBQrhxs85SE4
 k9rhLmsu1jgiF4D8MVQ==
X-Proofpoint-ORIG-GUID: G5pAfJKnV_DUTemha6lHUaSc9DXKtr7Q
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f0e2dc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=yneryZK0HH5dXzgVxAEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280160
X-Rspamd-Queue-Id: CD5CC489262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281994-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 3/19/2026 7:26 AM, Jeff Johnson wrote:
> On 3/16/2026 10:14 AM, Daniel Lezcano wrote:
>> Instead of defining a local macro with a custom name for the QMI
>> service identifier, use the one provided in qmi.h and remove the
>> locally defined macro.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Bjorn,
> Feel free to take this through your tree since I don't think it will conflict
> with anything in mine and it will take time for the definition to propagate
> back to my tree via the normal workflow (which I would prefer over merging the
> immutable branch).
> 
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Now NAK...

The definitions have now propagated back to my tree, so I'll now take this
patch through my tree.

/jeff

