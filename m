Return-Path: <netdev+bounces-305320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zi1qC7W1TGoZogEAu9opvQ
	(envelope-from <netdev+bounces-305320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:15:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92544718FAC
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="i0Q/ZS+p";
	dkim=pass header.d=redhat.com header.s=google header.b=R4ZMIzYb;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305320-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305320-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F01263003502
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31FF2DF717;
	Tue,  7 Jul 2026 08:10:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7E175A91
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 08:10:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411818; cv=none; b=cRFNCY/79wEKXwMHp9g5neebUpaXuFC4LZWvKgH5dIkh6YUEifHNPEFnQbMs7J4fdGNt7pCyoq0LesEGKwb/13eG+u7RMqorF+8uaZfPXnycd+urWh4mhDiI7ivmWgd8H5I3cTZ3nV0udc8TGbe3Fydq8tETd/ss6ZAqQeH3nyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411818; c=relaxed/simple;
	bh=TGcYGBPVrAQNAFzB06db+eO7Nd9fUC6S3B/Q6n9QSec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIhTBrKDeDCnlyb3kk1Zzz5BSoGRNSnbutvifjodO58hFXJqAksHmRTehMrJj+zoAR3xqxL+wX4kaX5nYN4S8m33MhK02u0KT8en1dgxqogE5eh9mteqQMikOcv7a0mib53RfImagwHNb1jMsH7HVRh5b0Khed3uOktPUFtXowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0Q/ZS+p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4ZMIzYb; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783411816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwIuBnltJjcVH05UvK/HPdvAPa4OwSH5BV+mf/t4vPM=;
	b=i0Q/ZS+pvlJ2dfBk3Q933l1PYMWqqfLZEZf8nSku2vZeQoemRee9gpgHQBvbRQiQWkzm0f
	OQ5Qo5WStCdICiAtMbAnI4MwsnEKJ9SzieGuQo9cR2+j6v8140xzE4c/KO+mXNP9O83uTX
	J7a9nCAWTHKlzcAW2JmzCcF020RPIR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-LWOqDbwYP02qeWrXXf_fWA-1; Tue, 07 Jul 2026 04:10:15 -0400
X-MC-Unique: LWOqDbwYP02qeWrXXf_fWA-1
X-Mimecast-MFC-AGG-ID: LWOqDbwYP02qeWrXXf_fWA_1783411814
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493e0042895so3096935e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783411814; x=1784016614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwIuBnltJjcVH05UvK/HPdvAPa4OwSH5BV+mf/t4vPM=;
        b=R4ZMIzYbMfyE6BDOpvLXvVnhivKWK+aepEIY+9RHnAsl+7X1u30816f4QYRH0l34pg
         WuEuFLfR9sk6sFnzUXBqSRb8ho6IfVCiWcZSBBvazhRdcwQuLtLWpn49JL8KG3ql+XB7
         lvSoouTzIE5IHPuJT5YmfYVaEkGLizKbeZDaIOgioavRKKhrtCmevh6jjGr3ctJYSuAR
         zYlp8x5jTsuzXX1dqrd7FY9kSDurtHoV4Y9uytxhAaoIUo/E2ly7a3keEbvHvXxqq6oo
         ivb8t9fBdzGPHJ5NY+2RoeXyWRQpoaCGQXjePpW/m8HoEzg29nRN4MZdkfDmdD33MEOH
         O5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783411814; x=1784016614;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwIuBnltJjcVH05UvK/HPdvAPa4OwSH5BV+mf/t4vPM=;
        b=awMJIsLiMrt2w+TXiDXg+pjPIdLKtvn0+rOUAHA/jXCGTVsqEAu18f1ijSEP0fPMeY
         nqwoKaZ1AqY6FMH44R0xAYUirMZzTUr2zC0HQyzJLwVMEEbq+fwHoFfm6NDJA6dbBRKm
         wyfeYXBioD8hrHdKq1zM3mY+2/WAHrxk3M2AorMsslYpSLGrNK1HxSIujrDYr5qtMSlN
         0BedkOhizjRJyP4/dYqj0CiCuWhaxJ2aPnz0LuxoLd+g+2ODu+J7ksidNRx5cpWM7j3Z
         iChjCgxRJpJHjxvT0sboBJS8psZZL4P4sBm9vk9iVX9P2XP3sNRupf6XsCnobih6/way
         VLEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlkHMKU3fOyN+j5dPV1bsWOfvP0k0nORYorA0dv5d0PdnXNbCKB7gJQNQ7x6F6tBmTfJHrg/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgWVJ4+YnyBjn6ZcjFZ7+tpyRNy21d/hSvsOCl3IkZ4EexRdQ
	bGutjKxu28NEuoAP6nITaaBK20zjO1WMSeIFN55ot6F9PK7pVae4e6D4Xryc4l0BfXXeA8AnnZi
	GHkI9GFNN1F5bBFMc1ebtyD3TjuzJZpl0RDni/YUlDXXcPDlVrT0VZNulRg==
X-Gm-Gg: AfdE7ckxp0u4Cqnx1oEHAFNKVKewcm8iN53rS9bxHz69sG3vaJnzLwJAO80KI4UJQt0
	AhR/IZEfkKedp3wwN5xzmhP0NTjqpA/Gl+vOAioxPUwJXsJCj9UvpkFSidHHtX7U9RMljSB9+QL
	fSy+lz1NAobk2tUe6AMspbd3jZeCJylee44GdzthYZI9h/9I0AeUmFzoAXyci0sSP2xVsmQvsWC
	DH022HIDGQmaaIe/DE2R0m9Grp8E0liFUi6jS7Qim7kdqLr6xvlUKiNNW2ZKzJfIwHlTdpRi8KR
	mDR3IAQ+8FmKk0OKyFIm4UQHkUtpkmkl80IJ7ZlYxAqVWKVMvgGBZufyVMs9slcgYYXXE9EK5Sa
	gu5KDPvFz58UIpk94pyLWGKMLph9BkcSFS431OUhbVTdzEg2nShl3DlMCU8KuhsHoRJawn/0e6R
	l8R2471F5yfYKM
X-Received: by 2002:a05:600c:5395:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493df076a4bmr43339055e9.31.1783411813595;
        Tue, 07 Jul 2026 01:10:13 -0700 (PDT)
X-Received: by 2002:a05:600c:5395:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493df076a4bmr43338525e9.31.1783411813089;
        Tue, 07 Jul 2026 01:10:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ebf593sm39085795e9.0.2026.07.07.01.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:10:12 -0700 (PDT)
Message-ID: <1f4c7607-007d-49e8-b3bc-d1fd8034c570@redhat.com>
Date: Tue, 7 Jul 2026 10:10:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/tls: Consume empty data records in
 tls_sw_read_sock()
To: Sabrina Dubroca <sd@queasysnail.net>, Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, edumazet@google.com, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20260630191551.875664-1-cel@kernel.org>
 <akaoXcfamBp8_mYe@krikkit>
 <0a03d16e-d4ce-422d-9492-3e31d910d8e5@app.fastmail.com>
 <akbdFcQP7oTp_n3s@krikkit>
 <d036b6fa-4f53-444c-b376-83e122982f1d@app.fastmail.com>
 <akyxoZTzhNl7XCEG@krikkit>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <akyxoZTzhNl7XCEG@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305320-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sd@queasysnail.net,m:cel@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92544718FAC

On 7/7/26 9:58 AM, Sabrina Dubroca wrote:
> 2026-07-06, 15:16:21 -0400, Chuck Lever wrote:
>> On Thu, Jul 2, 2026, at 5:50 PM, Sabrina Dubroca wrote:
>>> 2026-07-02, 15:52:49 -0400, Chuck Lever wrote:
>>>>
>>>>
>>>> On Thu, Jul 2, 2026, at 2:05 PM, Sabrina Dubroca wrote:
>>>>> 2026-06-30, 15:15:51 -0400, Chuck Lever wrote:
>>>>>> A peer may send a zero-length TLS application_data record; TLS 1.3
>>>>>> explicitly permits these as a traffic-analysis countermeasure (RFC
>>>>>> 8446, Section 5.1). After decryption such a record has full_len ==
>>>>>> 0. tls_sw_read_sock() hands it to the read_actor, which has no
>>>>>> payload to consume and returns zero. The loop treats a zero return
>>>>>> as backpressure (used <= 0), requeues the skb at the head of
>>>>>> rx_list, and stops. rx_list is serviced head-first on the next
>>>>>> call, so the empty record is dequeued, fails the same way, and is
>>>>>> requeued again; every later record on the connection is blocked
>>>>>> behind it.
>>>>>>
>>>>>> tls_sw_recvmsg() does not stall on this: a zero-length data record
>>>>>> copies nothing and falls through to consume_skb(). Mirror that in
>>>>>> the read_sock() path by recognizing an empty data record before
>>>>>> the actor runs, consuming it, and continuing.
>>>>>>
>>>>>> Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
>>>>>> Signed-off-by: Chuck Lever <cel@kernel.org>
>>>>>> ---
>>>>>>  net/tls/tls_sw.c | 11 +++++++++++
>>>>>>  1 file changed, 11 insertions(+)
>>>>>
>>>>> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
>>>>>
>>>>> I think tls_sw_splice_read() suffers from a similar issue (returning 0
>>>>> even though more data may be available). Sashiko agrees, and also
>>>>> found a few more pre-existing issues.
>>>>
>>>> Do you want a v2 series with those issues addressed?
>>>
>>> I'd be ok with this patch going in on its own, and the other issues
>>> being addressed separately. If you have time to look into those,
>>> that'd be great.
>>
>> patchwork shows this patch continues to be marked as "New". Is there
>> something I need to do to help move it forward?
> 
> I don't think there's anything blocking it other than the length of
> the maintainers' backlog.

As noted yday:

https://lore.kernel.org/netdev/c0cd72bd-6298-47a4-82a3-c43811c98063@redhat.com/

current patch processing capacity is limited.

I'm processing this one right now.

/P


