Return-Path: <netdev+bounces-291499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLwwMzIAFWq0SAcAu9opvQ
	(envelope-from <netdev+bounces-291499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 04:06:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A725CFBB0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 04:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FB73004C45
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 02:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026AD280325;
	Tue, 26 May 2026 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TSv+80ly";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KN1m3E5P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F82EC0AE
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761188; cv=none; b=uO8q6y2UqZeF8lUiZ0fGYkPbfKkoLaOdf86BZMPpRIfnGXf+lVTWJpLbhsv2I0c1kaj9etwqT5CRGCm2n2b54AjbV/4ULKvxTJn1y/ZwaKPpu9PQ5kdTK/p09GronlnK1D4fRYOH4TMGUEAqkZLue/ONTjFF5CCXKg6Plzbfpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761188; c=relaxed/simple;
	bh=4dZ7FleHX9LEfyrsntrbMRB72EemimhZz++em3Ic2Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrIqRyvWTokGz9oigOZwSu8ZMJUwHJnI5Rkhg5KqEvo8mu876gec6Cllvigkr9D5zTWJEu0iSz4YzGA/w+qDFlQS1QROLW12MixEffPN7/g/5LRZ0uFmtHIxGCM9F1Xb56E1W5RURYT/mH7luwRn56hnTVP9e+xP57OoUIcJSwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TSv+80ly; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KN1m3E5P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PE5ouQ2823029
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 02:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERRTZnCM+tZxX3L47TbsQthWMZ9aDpguE3OZQKkowRE=; b=TSv+80lyY5KjQbsC
	CBTFdKX9c16b0+mNpSX0dZVA9Urqn1ylqsQE5NdMjn2Uz3TzE2qqnbA9W4gb9s64
	MlOwV5WL7+YJxux9FlZZbFr3y9AadHZFB9GHVEAjolrIQzgmfyHC/Nu86YSBNqO9
	r6shYezlOvXcMOifLN09IPzqCbszjJfReNqMYSnBdT/T1xyGrYpHpWHsMzRZflAH
	V7sniayzlOfAvZH/ZUFraPQzFsNKpWg14HmUvxKtw3Ad9BZ4/oqpkXhbP3F29Y9i
	0BteVN3B7Ac2T+0cjlE533C+M4K2wgXyLLFAfP0UlUfwiZmYRLXfWDCOBzEetyqm
	kzlnuA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqvwsk3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 02:06:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304627c66ddso998684eec.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779761184; x=1780365984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERRTZnCM+tZxX3L47TbsQthWMZ9aDpguE3OZQKkowRE=;
        b=KN1m3E5PARMWazGYPRaXF9FrV6x6DcvcSYPysU81CdfiEKgbua8wl1w9lf9rAE3ee1
         E/XWgZ3lYjymvAHuPfE/mf/6OolJuGWoQtcQG1hUHg55LtK4HLGPYKceaL6BydBqdzXJ
         HQEFqOWO3ISDYK/GYygVvR71tgsczS22Jervk2cp66K7PyQW0QEIyrxZiE+BADkJm0Yj
         yd7MNUl4fEUQv1J1k6kiB+yDTbVf9t5puwCfTnw0USdvpbIMlFfTCp3bVbdocqhwnMJe
         uRlHI46BVKvCTtRXjCrkAR+DjCvKMHr+IXsPHvGC2+54Kci6rKDxUSKMBhJc6YKlLNMI
         XIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779761184; x=1780365984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERRTZnCM+tZxX3L47TbsQthWMZ9aDpguE3OZQKkowRE=;
        b=ltNxDUNxsUM/BT4krmXF8vyi6nB43NtOQ858cSew92JkwKiVtKDeDvl/glcROcLhbd
         sOsQSB8jCEcFKgA2dGVvAvX6gqKtsQIffsYKDM6o38TzRi2gChaOIFrFNOWXBpk0KphH
         CO1OOmoUuAGGQS3x8Z2G3Z9hY3ffyr/MmP/uMgW2TFMz4kdWYbeZEft6xWJr4KAh+WWV
         pT279auN3jVvAENw5pl0bngIToh8gPhGH8UYUsBmnuJij4/vMALaYf+nOQdzV/6Dze0P
         rmznN2MbgXz9UI2NcIHDQlJzpECskpG36lc5Hy2UtZ6LbnGgcOYYSm9oRFN5lXVqeyPi
         JjFQ==
X-Gm-Message-State: AOJu0YzsypA9sCn3FmfbViOmOno0yc04Wrt0O3cpN43eCzwZLTEGBTyJ
	H9j02wq+EXBHfnko14FEyqKgoZkOarkdTU4hBnFCLOkv0lK3kE2h7PExd1XGl6X0wpHLiwTU4LF
	+L4wZJ/Ge6cb2BM+bXLCq2yWwVeJBnUA9+wA8/UZPjrX4KckdS7nAnEPcOMA=
X-Gm-Gg: Acq92OFjZQtdWIzl023Su5Rr4wGRTp9mHjM6PMwBY0ndIPJ9zaOo3iQMOokFOEvvrTm
	/91V6LMo1uLP70ICqY32AT6siTYVSZOXJ0GqrwvE3Jpeipms80umbG4e7uNSXjS0W9b7LiVYkX8
	o9cUptSJ0kb0BvSzdxhSI0yvKBCoO7JAPyMkz3mTPV7CnrRDvdbBXgoZandky4nl+qz90Xj4XPi
	zt8oqOkYqjtnJgqdt4m3mZiPkUpJfYCpFPyLnj4ZLo9+jwDmmUYQWrnU7esoKYGbzW5p+8xd5kP
	au85mi5TcyPnN9i/EOyw3iuWTLEcNQm8FLuVWSztuSaMsq8Opyk92GFsFZzvCEMJxI5LFypJ7Jc
	x55TRelJiDstcX51f9pKQwBASQ615RitUilWzCiGgtdYJZwx54jdDme/mx17yV+sBEaqnltRTRg
	8XKHrd4Qp0Kq3dOhVur0FrzVRrQWXbEQ==
X-Received: by 2002:a05:7300:4351:b0:2ce:3aa1:d39b with SMTP id 5a478bee46e88-304491490efmr8691178eec.20.1779761184411;
        Mon, 25 May 2026 19:06:24 -0700 (PDT)
X-Received: by 2002:a05:7300:4351:b0:2ce:3aa1:d39b with SMTP id 5a478bee46e88-304491490efmr8691157eec.20.1779761183778;
        Mon, 25 May 2026 19:06:23 -0700 (PDT)
Received: from [192.168.0.224] (99-188-240-205.lightspeed.sndgca.sbcglobal.net. [99.188.240.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef5492sm9077459eec.6.2026.05.25.19.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 19:06:23 -0700 (PDT)
Message-ID: <ff58c51b-507a-4db6-b9a8-ebefbdc5f949@oss.qualcomm.com>
Date: Mon, 25 May 2026 19:06:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
        yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
        rollkingzzc@gmail.com
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org>
 <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org>
 <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org>
 <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
 <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
 <20260522175507.02b4fe83@kernel.org>
 <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
 <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
 <20260523094641.2bef6580@kernel.org>
 <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
 <20260525083932.234f26df@kernel.org>
 <CAM0EoMmjg+qrc=E+1nSVcCUPFh9yUfw59ASLCOM4jcEvRtw4jg@mail.gmail.com>
 <20260525103443.1da3e406@kernel.org>
 <CAM0EoM=YDZB6oNN4A1sXck3FS1TsH8D9haqSuooLG+AFuKvHfQ@mail.gmail.com>
Content-Language: en-US
From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
In-Reply-To: <CAM0EoM=YDZB6oNN4A1sXck3FS1TsH8D9haqSuooLG+AFuKvHfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c5uo2OLi0m5jmL055OBgFtHQrYNqo42r
X-Proofpoint-GUID: c5uo2OLi0m5jmL055OBgFtHQrYNqo42r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAxNyBTYWx0ZWRfX6LiHo1APYZGT
 7Kcd/Hbc0S1b5rMr1Ypm71AdmaC/KdkdGriOdbSUOF3HNBmpB8ZoAvd/AxySY4M2ZCgWs30PR19
 rXqhU0AAfE3ycufOX5MywPODsCuJunhXJkYuZOywKmECDAL0jrv2ee3eMm7fSEHYVW9B5nzEQ68
 NVgkXuCBldpagphBCc6GdpArj4x+qOVJnb6sHiwwRYkZg4jgkbRgqVPnYsk+4XhozpL8VOWrn/3
 Gfu/oWAzxWIDd3OfhMXiQArMnRaGO+ogIivr5/tDamMJYJi1NGdwwbQ7y/yimVx0Kq6/INItF+E
 qVYubk8zidAECh7tSg2N3J0FJZQ8bJy7JJx9BMoaAHO52sq0bdQYrt38GX4jjOn/BwNVfj/1P/K
 03nEUsTqSnXag9D+jsGliUGWPAQLWlTZ6HE1rsbObp+XBZBJodGHgJ9tn7qoyMYeEzWThvwSpNO
 zaFEe/BdBZbKoGM/IEA==
X-Authority-Analysis: v=2.4 cv=M4l97Sws c=1 sm=1 tr=0 ts=6a150021 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=4ie1wpOwHSsQ5pQxgnv22g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=lo1kwYZmmkkWDZf47HIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_07,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260017
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rajat.gupta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26A725CFBB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/2026 12:03 PM, Jamal Hadi Salim wrote:
> On Mon, May 25, 2026 at 1:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 25 May 2026 12:22:40 -0400 Jamal Hadi Salim wrote:
>>> On Mon, May 25, 2026 at 11:39 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>> So as an alternative to the piece i posted? i.e this:
>>>>>
>>>>> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
>>>>> index 79921b8d89ba..8f0f84b50c85 100644
>>>>> --- a/net/sched/act_pedit.c
>>>>> +++ b/net/sched/act_pedit.c
>>>>> @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>>>>>                 if (write_offset < 0) {
>>>>>                         if (skb_cow(skb, -write_offset))
>>>>>                                 goto bad;
>>>>> +                       if (write_offset + (int)sizeof(hdata) > 0) {
>>>>> +                               if (skb_ensure_writable(skb,
>>>>> +                                               min_t(int, skb->len,
>>>>> +                                                     write_offset + (int)sizeof(hdata))))
>>>>> +                                       goto bad;
>>>>> +                       }
>>>>>                 } else {
>>>>>                         if (unlikely(check_add_overflow(write_offset,
>>>>>                                                         (int)sizeof(hdata),
>>>>
>>>> Yup! Even better.
>>>
>>> Dude, it's hard to follow you sometimes ;-> It's hard to grok what you
>>> mean the problem of "we are writing to frags".
>>
>> Long threads have the tendency of losing focus.
>> Better to just repost the whole diff than tossing snippets at some point.. ;)
>>
>>> Let me try to be verbose and you can narrow it down. There are _two_
>>> codelets dealing with "frags" both of which can be written to.
>>>
>>> 1) The patch from Rajat deals with zero copy from app with shared
>>> flags. That's whats being exploited in the wild.
>>> There's a piece of code there that does this in Rajat's patch to handle it:
>>>
>>> +       /*
>>> +        * If the skb has shared frags the user is likely using zero-copy
>>> +        * (e.g. sendfile).  Those page frags may point to page-cache pages;
>>> +        * writing into them would silently corrupt the page cache.
>>> +        * Linearize so pedit operates on a private copy.
>>> +        * TL;DR: if you want zero-copy, don't use pedit.
>>> +        */
>>> +       if (skb_has_shared_frag(skb)) {
>>> +               if (__skb_linearize(skb))
>>> +                       goto bad;
>>> +       }
>>>
>>> After you posted, i thought this is the "we are writing to frags"
>>> issue you were referring to.
>>> I if-zeroed that code and indeed it does not seem that the exploit can
>>> be executed even with that taken out.
>>
>> I don't want the skb_has_shared_frag() being added, that's my ask.
>> TBH I missed that skb_ensure_writable() when reading the patch.
>>
>> If we use skb_ensure_writable() before all the writes we can delete
>> the skb_has_shared_frag() (as your test proves). This is the extent
>> to which I care about the patch, anything else - no strong opinion :)
>>
> 
> Ok, I will send the patch probably tommorow AM because Rajat may be
> confused by now ;->

Ahah! Thanks Jamal, I indeed kind-of lost track. But if you need me
to test/help-with anything, I'm always here :-) > 
>>> 2) There's the frags coming from the other (driver) direction in
>>> particular when skbs get cloned. That is what sashiko2 (nipa variant)
>>> pointed out. IOW, there's no active report for that specific one but
>>> Han Guidong responded after i posted this:
>>>
>>> --- a/net/sched/act_pedit.c
>>> +++ b/net/sched/act_pedit.c
>>> @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
>>>                 if (write_offset < 0) {
>>>                         if (skb_cow(skb, -write_offset))
>>>                                 goto bad;
>>> +                       if (write_offset + (int)sizeof(hdata) > 0) {
>>> +                               if (skb_ensure_writable(skb,
>>> +                                               min_t(int, skb->len,
>>> +                                                     write_offset + (int)sizeof(hdata))))
>>> +                                       goto bad;
>>> +                       }
>>>                 } else {
>>>                         if (unlikely(check_add_overflow(write_offset,
>>>                                                         (int)sizeof(hdata),
>>>
>>> Saying he was able to recreate that scenario with a kernel module. And
>>> that this patchlet fixed it.
>>>
>>> Hope you are still following at this point ;->
>>> So when you said we can use skb pulls - I thought you were referring
>>> to removing the above patchlet and instead to use an skb pull approach
>>> (for which you posted a sample patch).
>>
>> Yes, skb_ensure_writable() does a pull already. So the only problem
>> with existing patch was that the negative offset branch was missing
>> a skb_ensure_writable(). Your snippet added it, plugging that hole,
>> so skb_has_shared_frag() can now be 100% safely removed. Hence my
>> "LGTM".
>>
>> Please also remove the skb_store_bits(), and skb_header_pointer().
>> Unless I'm missing something these are dead code.
>>
> 
> That also seems sensible. But needs testing.
> 
>>> I mentioned the two issues:
>>> 1) It will likely break the negative offset that work with pedit
>>> already (skb pull could conceivably be tricked to assume a large
>>> positive number)
>>
>> Your snippet looked fine tho unnecessarily complex in practice.
>> (AI generated?). I'd go with skb_ensure_writable(sizeof(*ptr))
>> as the worst case. Packets shorter than 4B are irrelevant in practice.
>> But again, up to you.
>>
> 
> Sashiko-nipa provided very good context and implicitly suggested a way
> to solve it (and it doesnt seem to be a mechanical turk ;->).
> 
> We need a session at netdev conf to discuss all this tooling. Maybe
> some of the security people can show up and share their secret trade -
> it's overloading.
> 
> cheers,
> jamal
>>> 2) that skb clones could result in writting into the shared data
>>> (which i said i may be overthinking).
>>>
>>> So which one of the two are you referring to? Or maybe it is both.
>>> Should we keep #1? or this the one that should be replaced?
>>> Are you ok with patchlet for number #2? Or do you want that replaced?
>>>
>>> Provide as much context as you can so we dont go back and forth ;->


