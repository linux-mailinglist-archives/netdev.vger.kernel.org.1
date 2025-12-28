Return-Path: <netdev+bounces-246180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF21CE51AB
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 16:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C26A83009A9A
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED221A01C6;
	Sun, 28 Dec 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3/G5XOY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOEFL+Ai"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779FA41
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766934141; cv=none; b=b05VBVETTetQ/SJOjQonVd4LPpRUHWdEtCacnXBfdegUGeYiJ26yuyre8xGsneZGg19+Rh4w4AMTQfOsap1g/Z1hV/LLgh3GGm7mvtIVpzEn7bznCc8ACTI/HqAqpfUz4/Adh8KboDpTspARPCOYwrGzJvMlne5WWGTGITWLloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766934141; c=relaxed/simple;
	bh=RDI3VrEbchG391k8f7u4dPDQLKRuPGaB0glR5NyXv4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNb0ICIT0dcLgmohbZFP3WGv3ukr1jxYh6Maebnmql+Q745Zqwj9PIZPQee7iJneuF5I3P3Vf0wWBvu6insPs17Yih3sIRF8PP4VUiOQo01rlnxIRnG4L14Wr3Q63fwvwf5bqYTbHPga1B+lu7S4DJpGfoPfekNzGT5nbogTyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3/G5XOY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOEFL+Ai; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766934138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uirCeyBb3g6S/NRXILsUBYspxdlSYbkXOQaSFgZb15M=;
	b=a3/G5XOYWdFNQnEsb/4Pfr+RmWiiB81qUw84q22k4MieVInqcYPR+5ItLfV+0gJ9Eb8qpB
	DOAgIVxUd+iaRMfpLjIA1JxUoVV0oKDDsdrwCaRQ+K0ekDRi7XDdY2vAAR5n3ytiOHI9Cl
	OxIuq8dUCm0hLetuxJm+j5f1CJummUY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-XoVU70sMO1uxsQGU0g8T-Q-1; Sun, 28 Dec 2025 10:02:16 -0500
X-MC-Unique: XoVU70sMO1uxsQGU0g8T-Q-1
X-Mimecast-MFC-AGG-ID: XoVU70sMO1uxsQGU0g8T-Q_1766934135
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430f4609e80so4290510f8f.3
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766934135; x=1767538935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uirCeyBb3g6S/NRXILsUBYspxdlSYbkXOQaSFgZb15M=;
        b=HOEFL+AiTr4Gwc6PKh1A0yGNeYv7Cd1tLD9d6QX1KMp3o2HWmEwnkFsdHahKJVP/ES
         Dx6wsL1XXHZPGtUSFPEWKOpVgC5KIzglPsIWN83pHhxxZvenTr+ZtJa/7kuEp3eenQI1
         bnoATY8Mt8BFKdEP5VWOF4fg/XfKcKr7Mor3/YLhDnhgHLxYBCqkITTyZ+NAfeW4uB+4
         /c2N+80xCecyq+SXG3w8OQg5pc0LnKeEacflI3YOYpXwhx71rMC3g8nzRNgBSTJ5W2mM
         WYamU8gleFlB+12OYApkUFVhUUTlg488mIaex4zEbIdV/Cia3sHY3DtZ4m8Dmp7qBM54
         3AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766934135; x=1767538935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uirCeyBb3g6S/NRXILsUBYspxdlSYbkXOQaSFgZb15M=;
        b=Nq7H9a+oKt+GKHJ2euGLwz7mvvyoFV0EAlZ0XbMOZX8v3nsH9h49I+85iUlWyALX9V
         PfNF6+gFNLDdRiER3H12/siYy09H9uDS4U+EH1+yQOaGV3m4T7sW4I+J6KFItdKOjEUx
         90VMzgDa+3ZTRpYrxgotjdL49MBwelSFv0krj/Z1p3WGktEDggT+NWXeLao3rpYVtkJh
         on8nPHonKZU0dwq3iPuzA2tn3cvqL3wdMusGUaOQsf4I/U8lGfiej6OHyXPRyoauJegr
         qKHP76rSPgonh0Ow+m0x63jC9R3vyu2PQncmZsNX3JWHfAN/35u/Z2Zvc5cPw2HcK2Xe
         RANQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1q16FPwAW4z4vjBJGl5PYX0nav95lT5J1csShFFYJm/jVtMhnfr7k4+wRR98e1Qf8/TOyG9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4T6GJoMY4LKuRxkxWKFdOPhWZUIHzEkMML69FuX1VJCUgqhaU
	lvLWzmwy3AlqEF6CGxtrV+0/jBfa+3b3HmWuLrhBLX3NxRw880KaTN2kaDsoy5UHXgsQQpViX9p
	S6UaIlvffbm1qR/rt4oplJ5rW8Ca3UPbK2wqIvfsSD14WqaKWvqW+s3bOwQ==
X-Gm-Gg: AY/fxX4WV1FgkhHJvLZe5uy0k1MRfNcVfnikBsSimgGE2KCfPqJZzLePob03J22PEl3
	tIZ/PJNdI7dtgxULQqwCalk3npYOEnxOInuBV3oUxWAr+mGCRqoRWTgEfKDBNQEpqJY6v7CD4HX
	aHFBBaTaFWTMKiPSsI2Noj4fzc0zJygvHKHBZI4zJmKo9AdxMSDGxyVubqSPY8K33nKx0hnKeyx
	eH3TNeWd8ffNXiSBwjDrilpdrij4zo2f/oXG6FtZ26N2YGKZrZhGvcUP6uA0Y6G+g8+TnAd3E+L
	Z+lbVuHK7L0WTX7l+NZWnOdl0ScwQT2MhKZGpkd2B/mW1pOnl5tz0VhKBDu1LeDVe67l5IMxcXg
	yPOrpdIlyoGjGxw==
X-Received: by 2002:a05:6000:2303:b0:42b:5592:ebe6 with SMTP id ffacd0b85a97d-4324e459b12mr28415756f8f.0.1766934135335;
        Sun, 28 Dec 2025 07:02:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFMdPMfcWK3Ww4uTDkORmoROiGmQGrC5u+pZCYH+ScC3b8Rb6DpeHfZgh0Tmx3FKkXk1Pvqw==
X-Received: by 2002:a05:6000:2303:b0:42b:5592:ebe6 with SMTP id ffacd0b85a97d-4324e459b12mr28415731f8f.0.1766934134811;
        Sun, 28 Dec 2025 07:02:14 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43277b82a58sm23572604f8f.6.2025.12.28.07.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 07:02:13 -0800 (PST)
Message-ID: <3308e844-6c04-44a1-84c9-9b9f1aaef917@redhat.com>
Date: Sun, 28 Dec 2025 16:02:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] af_unix: don't post cmsg for SO_INQ unless explicitly
 asked for
To: Jens Axboe <axboe@kernel.dk>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev <netdev@vger.kernel.org>
Cc: io-uring <io-uring@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Julian Orth <ju.orth@gmail.com>
References: <07adc0c2-2c3b-4d08-8af1-1c466a40b6a8@kernel.dk>
 <willemdebruijn.kernel.18e89ba05fbac@gmail.com>
 <fe9dbb70-c345-41b2-96d6-2788e2510886@kernel.dk>
 <willemdebruijn.kernel.1996d0172c2e@gmail.com>
 <0f83a7fb-0d1d-40d1-8281-2f6d53270895@kernel.dk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0f83a7fb-0d1d-40d1-8281-2f6d53270895@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 6:27 PM, Jens Axboe wrote:
> On 12/19/25 1:08 PM, Willem de Bruijn wrote:
>> [PATCH net v2] assuming this is intended to go through the net tree.
>>
>> Jens Axboe wrote:
>>> On 12/19/25 12:02 PM, Willem de Bruijn wrote:
>>>> Jens Axboe wrote:
>>>>> A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but it
>>>>> posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
>>>>> incorrect, as ->msg_get_inq is just the caller asking for the remainder
>>>>> to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
>>>>> original commit states that this is done to make sockets
>>>>> io_uring-friendly", but it's actually incorrect as io_uring doesn't use
>>>>> cmsg headers internally at all, and it's actively wrong as this means
>>>>> that cmsg's are always posted if someone does recvmsg via io_uring.
>>>>>
>>>>> Fix that up by only posting a cmsg if u->recvmsg_inq is set.
>>>>>
>>>>> Additionally, mirror how TCP handles inquiry handling in that it should
>>>>> only be done for a successful return. This makes the logic for the two
>>>>> identical.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
>>>>> Reported-by: Julian Orth <ju.orth@gmail.com>
>>>>> Link: https://github.com/axboe/liburing/issues/1509
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>
>>>>> ---
>>>>>
>>>>> V2:
>>>>> - Unify logic with tcp
>>>>> - Squash the two patches into one
>>>>>
>>>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>>>>> index 55cdebfa0da0..a7ca74653d94 100644
>>>>> --- a/net/unix/af_unix.c
>>>>> +++ b/net/unix/af_unix.c
>>>>> @@ -2904,6 +2904,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>>>>  	unsigned int last_len;
>>>>>  	struct unix_sock *u;
>>>>>  	int copied = 0;
>>>>> +	bool do_cmsg;
>>>>>  	int err = 0;
>>>>>  	long timeo;
>>>>>  	int target;
>>>>> @@ -2929,6 +2930,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>>>>  
>>>>>  	u = unix_sk(sk);
>>>>>  
>>>>> +	do_cmsg = READ_ONCE(u->recvmsg_inq);
>>>>> +	if (do_cmsg)
>>>>> +		msg->msg_get_inq = 1;
>>>>
>>>> I would avoid overwriting user written fields if it's easy to do so.
>>>>
>>>> In this case it probably is harmless. But we've learned the hard way
>>>> that applications can even get confused by recvmsg setting msg_flags.
>>>> I've seen multiple reports of applications failing to scrub that field
>>>> inbetween calls.
>>>>
>>>> Also just more similar to tcp:
>>>>
>>>>        do_cmsg = READ_ONCE(u->recvmsg_inq);
>>>>        if ((do_cmsg || msg->msg_get_inq) && (copied ?: err) >= 0) {
>>>
>>> I think you need to look closer, because this is actually what the tcp
>>> path does:
>>>
>>> if (tp->recvmsg_inq) {
>>> 	[...]
>>> 	msg->msg_get_inq = 1;
>>> }
>>
>> I indeed missed that TCP does the same. Ack. Indeed consistency was what I asked for.
>>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Can someone get this applied, please?

For a few more days it's just me. That means a significantly longer than
usual latency, but I'm almost there.

/P


