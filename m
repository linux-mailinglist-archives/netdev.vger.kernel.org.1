Return-Path: <netdev+bounces-178377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72135A76C94
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48C53A95B7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C982147F5;
	Mon, 31 Mar 2025 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFZz1Djp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468621420B
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442409; cv=none; b=Qk9qKiJVJhuVW0Kipf5tCMAW1SkOmGgqJvdNXnPROGWNIGBOtq48poUOiYYaUAt16IoOxQMQ5a6u0EQI3L39OD+0nUyQBbALAd0c/o7IySsxIijdfi7Wd59yBsE9WVk4AJ8yIfDyw5AyLPF62RmwpqUhiYOpeWmqTo5h2Owz43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442409; c=relaxed/simple;
	bh=A4Cnc7IYOANR4vFzHW4PWaPvY4antLhcwDlVZZIBaew=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DDgZ6G303GEEfoPtTDOCh9n3pV0I6TnThU9FcZ5tAwyu3uOb8pO8os9CqJHxcYPIbXrLjEAm+pPAlbSQajnckDVgjhTnNkST5QzlZx+2GCzr+zKryqLMmLNopSdyxQqduHot4jeobYFgGiiCTHc4TfmzTVBP3nvojdNp3NFtIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFZz1Djp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743442406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8I7Uh6YNEWrmn76HQxExg2zQ0YcdF9NBO4tYpBeEkeI=;
	b=jFZz1DjpoFXBQLUHYF05yfISfpvOxk0EG4m1ezW3pYRwyaim3UQnmDU0YsK0pm/Jq1qzlM
	Vg8HmDli3zYQYXQiOCVCep8cGymjJlqyN8E0kJyc+WlpiybomvKJtqh+Ti/AP2JeINW/ds
	Tv1JsppRxVGvNqFfQLoqFT4Qm4yFKg4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Dp8sX5AGMl-e5f94l5BxOQ-1; Mon, 31 Mar 2025 13:33:24 -0400
X-MC-Unique: Dp8sX5AGMl-e5f94l5BxOQ-1
X-Mimecast-MFC-AGG-ID: Dp8sX5AGMl-e5f94l5BxOQ_1743442404
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f6443ed5so96874876d6.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 10:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743442404; x=1744047204;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I7Uh6YNEWrmn76HQxExg2zQ0YcdF9NBO4tYpBeEkeI=;
        b=JVpWntpkALSx9TMDU/LkEeH451h+5ZzegMbCUl/C+t2015walZnt9ON3mwDq9E1Tzc
         IQba8XgCwOmYdBOGT2ec0CjYgJfiIyxQP8Ho5U3kK+OQBZgS0WgsfBGVXAAsqWoo2u5t
         9C/i9VjzW0kqN5GEotJOGYfpZ0cFCN9T96txRDOmNUjKydrLB2IX2eka6TAun5jKxt79
         Hi1zFnx599nA+VceTbwXu7th4bTSOy2yW5g+Tpwu4CWxVzRYSWTIoHxjProiEC3VXKYz
         edIrxZKEZnWLfm0tPx8wGYsdjlteViQL6f8PTjbQl5tZJV6uxMj4nAOC/3f/+u1Ssmph
         QKWw==
X-Forwarded-Encrypted: i=1; AJvYcCXmsjZRXyC5oUtx45+MhIGE0eh0QwIvwNew9mEVdpvw9NJqc291reCM1QEMpc7oZThAahNNiUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxix6njnPfqSre2GUVgMun+2ve2oIUxmafQYW6Rw2W3EgXmsbOC
	2mQHQ1gIuEOZNjYIywVemUS2qJ72XfBOIdcAsgmcE5+qcykYTEautMkqOLwFAZwwbjg5IJdX+IY
	e9Hh8lLMHhILwrxwJ5Ehx/T4lgS29kbF83FUFIGFly5VUlLZ8Y5CuCg==
X-Gm-Gg: ASbGncsn5En+h1nlKO+9JXWwMCR3Ey5LsZCO83r0tCpd9NNKqMKR+rQZUI5DZvUfsay
	CjhUFPwq12cH/IeBO7vquDOtsd57ogeT9Wsrwde6DCKEprkVCvhPpUpCFNs4CQ/L6i7qHMjMVkM
	pvSYRySnNeE8rlMgyvxZ1zCH17V2ohU3Zn2Ldj40XgjWgYlXtGxwrA+pnTnUtU7vgqi0keKjycC
	ZUoxFC+OCt5/T8w8fpZ3plevPvAMigtD8WBpcVwRGjMUoEMP78AXmIcUKsZ74sYPfLOc3yH50xs
	FgNiwbNKQvhm9dRnyutUYlf2gDCPjEqeZH76kLtEI9daZKbQQon24qsT2LNk9g==
X-Received: by 2002:a05:6214:1d0b:b0:6e8:ec18:a1be with SMTP id 6a1803df08f44-6eecb8a87edmr197715976d6.7.1743442404302;
        Mon, 31 Mar 2025 10:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLmzDn+USG4lxKUDYbhhAar07oCsaFnPS2tXda1/mwaN3q0EECdknBGIeoTjfoMQwJY4J4Rw==
X-Received: by 2002:a05:6214:1d0b:b0:6e8:ec18:a1be with SMTP id 6a1803df08f44-6eecb8a87edmr197715536d6.7.1743442403990;
        Mon, 31 Mar 2025 10:33:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9771b63sm48889736d6.85.2025.03.31.10.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 10:33:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9f5b500a-1106-4565-9559-bd44143e3ea6@redhat.com>
Date: Mon, 31 Mar 2025 13:33:22 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com> <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com> <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <Z-rQNzYRMTinrDSl@boqun-archlinux>
Content-Language: en-US
In-Reply-To: <Z-rQNzYRMTinrDSl@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 1:26 PM, Boqun Feng wrote:
> On Wed, Mar 26, 2025 at 11:39:49AM -0400, Waiman Long wrote:
> [...]
>>>> Anyway, that may work. The only problem that I see is the issue of nesting
>>>> of an interrupt context on top of a task context. It is possible that the
>>>> first use of a raw_spinlock may happen in an interrupt context. If the
>>>> interrupt happens when the task has set the hazard pointer and iterating the
>>>> hash list, the value of the hazard pointer may be overwritten. Alternatively
>>>> we could have multiple slots for the hazard pointer, but that will make the
>>>> code more complicated. Or we could disable interrupt before setting the
>>>> hazard pointer.
>>> Or we can use lockdep_recursion:
>>>
>>> 	preempt_disable();
>>> 	lockdep_recursion_inc();
>>> 	barrier();
>>>
>>> 	WRITE_ONCE(*hazptr, ...);
>>>
>>> , it should prevent the re-entrant of lockdep in irq.
>> That will probably work. Or we can disable irq. I am fine with both.
> Disabling irq may not work in this case, because an NMI can also happen
> and call register_lock_class().
Right, disabling irq doesn't work with NMI. So incrementing the 
recursion count is likely the way to go and I think it will work even in 
the NMI case.

>
> I'm experimenting a new idea here, it might be better (for general
> cases), and this has the similar spirit that we could move the
> protection scope of a hazard pointer from a key to a hash_list: we can
> introduce a wildcard address, and whenever we do a synchronize_hazptr(),
> if the hazptr slot equal to wildcard, we treat as it matches to any ptr,
> hence synchronize_hazptr() will still wait until it's zero'd. Not only
> this could help in the nesting case, it can also be used if the users
> want to protect multiple things with this simple hazard pointer
> implementation.

I think it is a good idea to add a wildcard for the general use case. 
Setting the hazptr to the list head will be enough for this particular case.

Cheers,
Longman


