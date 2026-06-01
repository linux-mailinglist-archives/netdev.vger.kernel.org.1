Return-Path: <netdev+bounces-293899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLDcEqHfHWpsfQkAu9opvQ
	(envelope-from <netdev+bounces-293899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:38:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4703624B65
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 21:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43D1300D917
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDBF37DE96;
	Mon,  1 Jun 2026 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS+XbDN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F8380FF6
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342684; cv=none; b=EqixUIgBMab7PXYzxl5c0G5BYhSNKy/HKWsqAHbfuErPZr5kqmxkS/OnQT7ZNj8kMSFscIbjaJFJH9XNtKdwIEHlz7SgFWB9pRtkDcau5N+A/W/g0tbBAa5yFdrIJa69UkAlzvrNr1Ur2vEslrbBrg0JI/J2j75G+vawKIaGqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342684; c=relaxed/simple;
	bh=yn8QoO6B++RiDRZWpnVl7nEGtcOXXjzMEp/aTYMO544=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFqf26JU89C9wEth6CPqNin9u0NulqHlOinDXVvuhSvc162j6ZrI7WIdGefNrg320+2+rSCQnxycO9xpd3sQ/AzP7ROtPVndpqSMnbhoK063KF8v/fmUUqs5LMgA/ju6HaagkqvK9HyulQ6Oey/mWLZus/G7AoNOTdMn6hRtTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS+XbDN3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490af320e2aso6227755e9.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780342682; x=1780947482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koHEWg7rZ9rnh8BMaCzEjh5C53SqOp62+G2T65KEvcg=;
        b=cS+XbDN33dNX6QGBXctU6aqa6dzqZGTN9FMCsOxo67/jab17BYGzXBwozPFU8Nt3yJ
         njLbQBnJstHsHJo2l56WkWNUtWtTi88oGOk/iVriakEqUBHu7p1DfNtv5ZrXnWrdGulU
         vadYC4H53KhMJufNbmbKARd+iz4/FUF+ff/s/7cRTL4XOc1VuRYpY46vHMIAwhpO9gxV
         XnRp+qWxNjZUHBDcmrOAmVe+/ML4wcpBjWsJQT3Xf1nIfWTCdTVJuBzdSZqFpKOSuJt7
         cLOZRxuQHo8FZi5w3KfCeuuJe+bgf//VMx1Z8vxmhH1sbonFynJhdRSbv7x8CJKFmiBt
         Q/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342682; x=1780947482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koHEWg7rZ9rnh8BMaCzEjh5C53SqOp62+G2T65KEvcg=;
        b=p2ooXt03jdCJbA81j/sb/5XNfnFUYZ2gZ8m9q9KYAi9AK0BT3IDUTuv1g5ey1+QSOv
         YpnMLCUVIvxjPdqCWORPt18kKEp8LsNMmm2Nb1WNotPvjrRbdXh1u2greros77wKfYJm
         M+Usev8980MBCqwp9LukV+ABNs8Kge5pe/6ajfLmhOVa9P+cWdGo0wCDzhkAFNnYDrTO
         Bp1Nr5eJO8Q5g7eCoFqvCkEtYxFutx5N/5K0yz6CGdo7wR+ba/ZjuZX9QEoku3uB5ao9
         pRjzsDTtG4TXDTUPKcLLxB35CY++wZYatb/8BnouF50vs7GpXgCOOK3b1fr5ed0mVkwU
         FzhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8K9jpmdKtY5TAjW0sReEklt0jUjRzx1amE3r/fR1zSyS4d4tUpF1Webq/JfUv8dwvoLfn5TeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1DHkfBJsl7Bwt0YRJpXwHW5SJi7R6TdyEoOzP0fkAxWvAQ0t
	ocW54L1VJKprDoZgE4qB23kjeJXma02mbyrKboMobRl5jNlYpvWLroBA
X-Gm-Gg: Acq92OHgJR6aVxxmzFJWAId0JxyO5D8HBKZMAQnq+MdN4CATbRLEMIsgfWXQK5Lsalg
	LfefGiis3fFPa9Y2jjb1ouJgdxRYvWbsNGOdfRH0dRhS+zsE1GHGDzsPqybEayabjxKQsomrhXB
	WbwfJMQTFslzpQmsxG6EY2sgdQZ5leAP1SDenAUusgBbDymgIr2hI7lwEGSHD+dOH6a6RcYsl1z
	8A6vc3UR0g+ClqO24PWIImdBdACcv4OKfyj4ZFkVbP6vIZ44CDMcKVzfnkHvAXRNjuaa9+EUgc7
	+ZHqc4iq89TOMuXUIYaPmkbRUxTgFzZ32pCpj8ImuVaqhS2fjuvddECNbBgd/UMcC4hwfRycwqV
	WOCOd0+J6N7NJ5aQ9ozGxn2Vp1Z8eECjCvshQfM5bepSgkhyN2uphqwVHtCI58UpfbDONXvD5ii
	cXKP0bTfnFXuLmP4bCXw54WALqdLaOLoKkQbpJXWk1BNb0f6xSKKbl00Epb+YNAkV+4HpTUT5BY
	v4XkkRjCIWmZtf62OrOwA==
X-Received: by 2002:a05:600c:3b10:b0:490:b0df:9eac with SMTP id 5b1f17b1804b1-490b0dfa72bmr15593725e9.3.1780342681385;
        Mon, 01 Jun 2026 12:38:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20bacsm12546705e9.6.2026.06.01.12.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:38:00 -0700 (PDT)
Message-ID: <5b434d06-22fc-4f1e-9122-05261f1237ef@gmail.com>
Date: Mon, 1 Jun 2026 20:38:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 12/13] selftests/bpf: Test using file dynptr
 after the reference on file is dropped
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org,
 kernel-team@meta.com
References: <20260529014936.2811085-1-ameryhung@gmail.com>
 <20260529014936.2811085-13-ameryhung@gmail.com>
 <29eaa2d6-784b-4a12-acb3-099052ba0933@gmail.com>
 <CAMB2axOb0Bi9Xn5RS1J+n0_vdD2oFygAa1xCH6O3JR4JJfihyA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAMB2axOb0Bi9Xn5RS1J+n0_vdD2oFygAa1xCH6O3JR4JJfihyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-293899-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4703624B65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 6/1/26 7:42 PM, Amery Hung wrote:
> On Mon, Jun 1, 2026 at 5:05 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> On 5/29/26 2:49 AM, Amery Hung wrote:
>>> File dynptr and slice should be invalidated when the parent file's
>>> reference is dropped in the program. Without the verifier tracking
>>> dyntpr's parent referenced object, the dynptr would continute to be
>>> incorrectly used even if the underlying file is being tear down or gone.
>>>
>>> Signed-off-by: Amery Hung <ameryhung@gmail.com>
>>> ---
>>>  .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
>>> index 0739620dea8a..d5fae5e4cf9a 100644
>>> --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
>>> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
>>> @@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
>>>       bpf_dynptr_file_discard(&dynptr);
>>>       return 0;
>>>  }
>>> +
>>> +SEC("lsm/file_open")
>>> +__failure
>>> +__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
>>> +int use_file_dynptr_after_put_file(void *ctx)
>>> +{
>>> +     struct task_struct *task = bpf_get_current_task_btf();
>>> +     struct file *file = bpf_get_task_exe_file(task);
>>> +     struct bpf_dynptr dynptr;
>>> +     char buf[64];
>>> +
>>> +     if (!file)
>>> +             return 0;
>>> +
>>> +     if (bpf_dynptr_from_file(file, 0, &dynptr))
>>> +             goto out;
>>> +
>>> +     /* this should fail - file dynptr should be discarded first to prevent resource leak */
>>> +     bpf_put_file(file);
>>> +
>>> +     bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
>>> +     return 0;
>>> +
>>> +out:
>>> +     bpf_dynptr_file_discard(&dynptr);
>>> +     bpf_put_file(file);
>>> +     return 0;
>>> +}
>>> +
>>> +SEC("lsm/file_open")
>>> +__failure
>>> +__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
>>> +int use_file_dynptr_slice_after_put_file(void *ctx)
>>> +{
>>> +     struct task_struct *task = bpf_get_current_task_btf();
>>> +     struct file *file = bpf_get_task_exe_file(task);
>>> +     struct bpf_dynptr dynptr;
>>> +     char *data;
>>> +
>>> +     if (!file)
>>> +             return 0;
>>> +
>>> +     if (bpf_dynptr_from_file(file, 0, &dynptr))
>>> +             goto out;
>>> +
>>> +     data = bpf_dynptr_data(&dynptr, 0, 1);
>>
>> File dynptr is always read-only, so bpf_dynptr_data() always
>> returns NULL. Verifier does not know this (not sure if we should
>> address it). Maybe it makes sense to remove this call or substitute by
>> probe read, just to avoid confusing example.
>>
> 
> Thanks for taking a look at the selftests and pointing this out. Does
> replacing it with bpf_dynptr_slice() make sense to you?
>
 
That'll do, but bpf_dynptr_read() is more straightforward API for reading file
dynptr, as you always have to copy the data.

>>> +     if (!data)
>>> +             goto out;
>>> +
>>> +     /* this should fail - file dynptr should be discarded first to prevent resource leak */
>>> +     bpf_put_file(file);
>>> +
>>> +     *data = 'x';
>>> +     return 0;
>>> +
>>> +out:
>>> +     bpf_dynptr_file_discard(&dynptr);
>>> +     bpf_put_file(file);
>>> +     return 0;
>>> +}
>>


