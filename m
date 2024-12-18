Return-Path: <netdev+bounces-152933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FDE9F65DF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B25C1621FE
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20CB1A0706;
	Wed, 18 Dec 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3kffD3x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8E19CD01
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524726; cv=none; b=PFPJ4ZLs1mQzWCd4anrRYvXilF2HLdU1omuvbbm62/d7A4Vl1nOZa4OnyGSqlo16k6/wxilpdqxJl1qZRqmLBJQ6wBbvvSyTR5xqiYtSknWfN3ujiI7hEZjj71BxeEaTBPnZWpyR6+hZ9ArIEqB/MEyTUdEpober880aTj8bNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524726; c=relaxed/simple;
	bh=FdFpiqV22MblOejbOyUzLPrF67j9DJcsAOaiSKHegVE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n24CYI7vT8TVkr3D8nZQYLK29YtG6XXbLAP2SQzaGyfZ2gtDcjDcFK/6rFBbNS83P7Ru2jXhpusa3OdLkq9L0hZUH+w/xbC/nWzAdPEuJZn22n9XkezTtbQOhwCIWJRfPuv37DsgcL1CW3JmJfnNJSXMPo6tFW7bXkkIx2uKq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3kffD3x; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436341f575fso51353615e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 04:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734524723; x=1735129523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjlngrUzTM77JY3Zl+nOz6jl5AEvnrVMJimbtHgDfKE=;
        b=L3kffD3xGMif7Z2oa9VqvsWCalGz91MaFZNby/JggvGVnxFEpU+ZDqRfz213eifSHD
         /BtTNqi99z/R5TYVd7TdnKMK2bHbNhACFWh6MGYsxijPeXBY0CoC+C40Cw+mfSYqnOrk
         rKKheMmZpNS5dj20oFGah6MsTx25AIBD1GaGG+ZtVrIEtVyJTvIsx96zK1E6iYIWQqOV
         +Wyscm84KNyOliJ6YBSAYj1QT3lNxqaF5FIY1ZC/b3a1qA2baj0neAv5zIwf+4SgsdSE
         YYux6OI7x4u2128zY8KtIlspX//4rCz33kGqE02DAzmA6rlrDKu0p/HN8WR6NV1OE0rw
         bfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524723; x=1735129523;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjlngrUzTM77JY3Zl+nOz6jl5AEvnrVMJimbtHgDfKE=;
        b=gjbldjGyQJWGlMsekbDJqMxAtaxVbAPJOwcokf+Om/X0VxCyzoXmzIl7gjY9N7jz9n
         favkw0NQu6TYehI565bBKAJvKHUhQOWtFJhtc7LER96bSpgaWOQo64AEz64oDDVOMG3g
         X+P4vTDkZ85qZ77nxxuVCo5Fk5YQrkt6+AHWRiK7xV09U1tVUqcWijMOcZiqoIPngWzM
         SjnJsUx6+h+qdTajJavAhIosP/YFh9nfdg8MRWvyZbtCxC002fc5XvPlR6EZKt7AEJGL
         wn5eVJAEwXVTJtyyX+XOeXpryALXRlbY+PiSuMOObptsz2KAKbfFR7JWHTPRV5YwXArn
         stJw==
X-Gm-Message-State: AOJu0YzXYIPZfMvOXH8ugTi/wUcqPLIrOxCt+ycY60SboY0HtcxBzqf9
	ldYLI2Zc7vcYH5ciTm1v9ogRyDa/ygZ86H3hWJTHntnNdzqqfosIpuuKFw==
X-Gm-Gg: ASbGncuYXqv8TvyqV2qfWhYOLGlSlxdE1x1j/1OLOP3xOoZzMQlc+rMbp5WPlB7KqR6
	tFAx0oas7OMwsRod/zXsXPyfLjS8nKGug4uxoa+SO4FmmUtAlmJNmjG9jOM7oI0bU/N3ikBcQ9A
	KI733ebnI5PKLJ+KlyWPzVteSsHJbIrD79pcE/6Y4w9XNZlN18kLoTFkNlVszf3bNqDEpcYRXhG
	fxOsiyLQHnJ1ffyuSpBbpG65rQcSD+s1mtEqiG5czhHdKcKU89ESN+JB0JsB/O6Od36AWOweH+i
	zB3uvSU86WhJEhaBAKh0olfwlvR7FxjyyaAuiFDtOl1u
X-Google-Smtp-Source: AGHT+IESfDZXfo/VGUwXdOJ1IYsywqDnKEuxae1n9ZBthJBlPGH3H8SjPSlvImL5oXLnOmHqP25ogg==
X-Received: by 2002:a05:600c:548b:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-4365540ce51mr20667455e9.33.1734524722674;
        Wed, 18 Dec 2024 04:25:22 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8011feesm13779278f8f.21.2024.12.18.04.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 04:25:22 -0800 (PST)
Subject: Re: [PATCH net-next v3 03/12] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
References: <20241209175131.3839-1-ouster@cs.stanford.edu>
 <20241209175131.3839-5-ouster@cs.stanford.edu>
 <8a73091e-5d4a-4802-ffef-a382adbbe88f@gmail.com>
 <CAGXJAmzVYDQtBVwdhazf9R2UgMCOOwppD+EM2-NY25t+N1vJhA@mail.gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e1ed4a57-f32c-3fcd-5caf-0861ef7cf0b5@gmail.com>
Date: Wed, 18 Dec 2024 12:25:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXJAmzVYDQtBVwdhazf9R2UgMCOOwppD+EM2-NY25t+N1vJhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 18/12/2024 05:46, John Ousterhout wrote:
> (note: these comments arrived after I posted the v4 patch series, so
> fixes will appear in v5)

Yeah, I'm really slow at getting these reviews done, sorry about that.
(This is probably the last one until after the holidays.)

> On Mon, Dec 16, 2024 at 10:36 PM Edward Cree <ecree.xilinx@gmail.com> wrote:
>> Should parts of 'struct homa' be per network namespace, rather than
>>  global, so that in systems hosting multiple containers each netns can
>>  configure Homa for the way it wants to use it?
> 
> Possibly. I haven't addressed the issue of customizing the
> configuration very thoroughly yet, but I can imagine it might happen
> at multiple levels (e.g. for a network namespace, a socket, etc.). I'd
> like to defer this a bit if possible.

I think it's reasonable to leave that out of the initial upstreaming,
 yeah, as long as you're confident you're not backing yourself into a
 corner with either implementation or uAPI that would make that
 difficult later.

>>> +     /**
>>> +      * @locked: Nonzero means that @ready_rpc is locked; only valid
>>> +      * if @ready_rpc is non-NULL.
>>> +      */

Oh, I think I understand this now; does it mean that "the RPC lock on
 ready_rpc is held"?  I initially read it as "the field @ready_rpc is
 in some sense latched and its value won't change", which didn't make
 a lot of sense.

> This is a lock-free mechanism to hand off a complete message to a
> receiver thread (which may be polling, though the polling code has
> been removed from this stripped down patch series). I couldn't find an
> "atomic pointer" structure, which is why the code uses atomic_long_t
> (which I agree is a bit ugly).

As far as I can tell, ready_rpc only ever transitions from NULL to
 populated; once non-NULL, the value is never overwritten by a
 different pointer.  Is that correct?  If so, I believe you could use
 a (typed) nonatomic pointer and an atomic flag to indicate "there is
 an RPC in ready_rpc".

> I'm not
> sure I understand your comment about not manually sleeping and waking
> threads from within Homa; is there a particular mechanism for this
> that you have in mind?

It's not in this patch but homa_rpc_handoff() does a wake_up_process()
 and home_wait_for_message() does set_current_state(), neither of
 which ought to be necessary.
I think wait-queues do what you want (see `struct wait_queue_head` and
 `wait_event_interruptible` in include/linux/wait.h — it's basically a
 condvar), or if you want to wake unconditionally then completions
 (kernel/sched/completion.c, include/linux/completion.h).

>>> +     interest->request_links.next = LIST_POISON1;
>>> +     interest->response_links.next = LIST_POISON1;
>>
>> Any particular reason why you're opencoding poisoning, rather than
>>  using the list helpers (which distinguish between a list_head that
>>  has been inited but never added, so list_empty() returns true, and
>>  one which has been list_del()ed and thus poisoned)?
>> It would likely be easier for others to debug any issues that arise
>>  in Homa if when they see a list_head in an oops or crashdump they
>>  can relate it to the standard lifecycle.
> 
> I couldn't find any other way to do this: I want to initialize the
> links to be the same state as if list_del had been called,

If there's a reason why this is necessary, there should be a comment
 here explaining why.  I *think*, from poking around the rest of the
 Homa code, you're using 'next == LIST_POISON1' to signal some kind
 of state, but if it's just "this interest is not on a list", then
 list_empty() after INIT_LIST_HEAD() or list_del_init() should work
 just as well.  (Use list_del_init(), rather than plain list_del(),
 if the interest is still reachable by some code that may need to
 tell whether the interest is on a list; otherwise, using list_del()
 gets the poisoning behaviour that will give a recognisable error if
 buggy code tries to walk the list anyway.)

>> And are there any security issues here; ought we to do anything
>>  like TCP does with sequence numbers to try to ensure they aren't
>>  guessable by an attacker?
> 
> There probably are, and the right solutions may well be similar to
> TCP. I'm fairly ignorant on the potential security issues; is there
> someplace where I can learn more?

I don't really know either, sorry.  All I can suggest is asking the
 TCP folks.

>> I'm not sure exactly how it works but I believe you can annotate
>>  the declaration with __rcu to get sparse to enforce this.
> 
> I poked around and it appears to me that list_head's don't get
> declared '__rcu' (this designation is intended for pointers, if I'm
> understanding correctly). Instead, the list_head is manipulated with
> rcu functions such as list_for_each_entry_rcu. Let me know if I'm
> missing something?

I thought that declaring a struct (like list_head) __rcu would
 propagate through to its members, but I may be wrong about that.
My hope was that sparse could check that all operations on the list
 were indeed using the correct _rcu-suffixed functions, but if
 that's not the case then feel free to ignore me.

>>> +     /**
>>> +      * @link_bandwidth: The raw bandwidth of the network uplink, in
>>> +      * units of 1e06 bits per second.  Set externally via sysctl.
>>> +      */
>>> +     int link_mbps;
>>
>> What happens if a machine has two uplinks and someone wants to
>>  use Homa on both of them?  I wonder if most of the granting and
>>  pacing part of Homa ought to be per-netdev rather than per-host.
>> (Though in an SDN case with a bunch of containers issuing their
>>  RPCs through veths you'd want a Homa-aware bridge that could do
>>  the SRPT rather than bandwidth sharing, and having everything go
>>  through a single Homa stack instance does give you that for free.
>>  But then a VM use-case still needs the clever bridge anyway.)
> 
> Yes, I'm planning to implement a Homa-specific qdisc that will
> implement packet pacing on a per-netdev basis, and that will eliminate
> the need for this variable.

Sounds good.

> Virtual machines are more complex;
> to do Homa right, pacing (and potentially granting also) must be done
> in a central place that knows about all traffic on a given link.

I guess that means to support SR-IOV at least part of the Homa
 transport needs to be implemented in the NIC.
I agree that this problem doesn't need to be solved for the
 initial upstreaming.

-ed

