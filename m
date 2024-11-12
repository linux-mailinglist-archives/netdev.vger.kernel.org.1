Return-Path: <netdev+bounces-144020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CD29C5225
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AEB1F232A2
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57120DD64;
	Tue, 12 Nov 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV8+96jX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885C1ABEC2
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404118; cv=none; b=l0hPK8RawhuUfiyfA7dQl/ynvlHlYQ8s/l3efkjxEvg1CX/0wDcPIL/+or8tyka0aGc9k1m5YBbGXQvBAkqcYwmOc3x8QtLY5qMPhJ1nE0pB4tX2s1AZw6rSEVYx6UTBL27rUQh0BZauWYyQeCHy7laz9mNhAGEmjMQMQs/FVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404118; c=relaxed/simple;
	bh=acpUqKrG6oG+MrKIaONUC+S4Jt1zravuQFGpRfNRTEk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MHtlM/KPqJLG1lA2OlOOuFaTZAn5lumG6V/PCXDHGX8FdtAaqn9K/bopMqLZl0K4Fvl0OEmcK4Y4AGxp3H9C2hJ0rOeOkcHpCcL59gErPLlPuyojGR3MM06sGyHhgqwi1JVt3kkrwRki2eS8fim4xZ1Jsu2qsuF7IBrHQ+oNbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV8+96jX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb561f273eso42911511fa.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731404115; x=1732008915; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmQSlmnwPj5fiFnpMrZXHSIn6sq7fUF/d7EDDE3cFw=;
        b=JV8+96jXXITYK2qTPO9qTp/k1IoOvDmUr3fGeA4lNczTZ0dV1MsWrsx7KAlFqLwMY9
         YPqAINIqhMqa7QefL2PSoxsN3svzp/nfDQjdBTB9siB/Ng4+vHf0DjmB/3GStILB8z8V
         QCV26jIpYVbfDbPRHtRaZCo53QaC//vHmxmMaQ1T7Ntldt+R91Xph5cVx7pQEBNRDlXL
         ZS37vy0k2CGSBHUHbOe1waBalQa5WyitEjNHnd7XZKviv7RT7VSniESRZAQCOtge/VJS
         0JhMG2EiYIdz90bpNtjuaEiMSpA/c2UJYLGnlMmkZq1euidIB420vG4qbnnlab/mph32
         DLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731404115; x=1732008915;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFmQSlmnwPj5fiFnpMrZXHSIn6sq7fUF/d7EDDE3cFw=;
        b=YkS510osgvDJS0aX0SlVazh/PgEzgKSrMdh0wmnHUCaj7U9ZJT8OOuYSkhqJ+pfKig
         7xzOZzDHF029oAPQEcO4Pm0XQEFWAYCAknNtZ70Yx2nacO7/dlbIOMeWcNT4xbbVUXH7
         pyjwLT9RKHQs/6HhT4EN3T8A7/zDTWqEEv7m1p9EGOg107uJpRwRQmU5q5jAtbzVJVYC
         AOJb4S4nATH4yXESyJ146Gj6HAN3EpPrHc6a8YUnUl6NbEgQR6f1clKohul16ki1dU3A
         VqzzbnFn0f3D+cMQ8WAYmn+rg2Dxpj/hSMXBF3kwK7+BFXyz4zfNS6qxTYSQMapcjr6k
         3+Pg==
X-Gm-Message-State: AOJu0YzKqgWfmH9SRaQHtJsGM03p0ADn3SitkssO0C7JQsMCQO4VRycF
	WpcICdSHIXxRyGym3UmfqJCYR1a7pcYs0ceSrS7ZM1dFxC7v1bGc
X-Google-Smtp-Source: AGHT+IHb12pvf9AX4EnaCWH7xChoqL2/zmn3A+E9Bs381DHtVvGdKaHDfMYSLVMBfCFvyEJiCBTb7A==
X-Received: by 2002:a05:651c:54a:b0:2fa:c0fc:e3d8 with SMTP id 38308e7fff4ca-2ff4271fc74mr11531781fa.38.1731404114660;
        Tue, 12 Nov 2024 01:35:14 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:a1ef:92f5:9114:b131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b053069fsm206814925e9.4.2024.11.12.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:35:14 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Xiao Liang <shaw.leon@gmail.com>,  Jiri Pirko
 <jiri@resnulli.us>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: add async notification
 handling
In-Reply-To: <20241111100325.3b09ccb8@kernel.org> (Jakub Kicinski's message of
	"Mon, 11 Nov 2024 10:03:25 -0800")
Date: Tue, 12 Nov 2024 09:16:02 +0000
Message-ID: <m24j4cvmlp.fsf@gmail.com>
References: <20241108123816.59521-1-donald.hunter@gmail.com>
	<20241108123816.59521-3-donald.hunter@gmail.com>
	<20241109134011.560db783@kernel.org> <m2cyj2uj11.fsf@gmail.com>
	<20241111100325.3b09ccb8@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Nov 2024 11:06:18 +0000 Donald Hunter wrote:
>> > On Fri,  8 Nov 2024 12:38:16 +0000 Donald Hunter wrote:  
>> >> +    def poll_ntf(self, interval=0.1, duration=None):
>> >> +        endtime = time.time() + duration if duration else None  
>> >
>> > could we default duration to 0 and always check endtime?
>> > I think we can assume that time doesn't go back for simplicity  
>> 
>> I don't follow; what are you suggesting I initialise endtime to when
>> duration is 0 ?
>
> I was suggesting:
>
> 	def poll_nft([...], duration=0)
>
> 	endtime = time.time() + duration

I want it to run forever if a duration is not provided, but here
endtime == starttime so it would exit immediately.

I thought the original approach was fairly pythonic - if duration is not
specified (None) then there would be no endtime (None).

>> >> +        while True:
>> >> +            try:
>> >> +                self.check_ntf()
>> >> +                yield self.async_msg_queue.get_nowait()
>> >> +            except queue.Empty:
>> >> +                try:
>> >> +                    time.sleep(interval)  
>> >
>> > Maybe select or epoll would be better that periodic checks?  
>> 
>> This was the limit of my python knowledge TBH. I can try using python
>> selectors but I suspect periodic checks will still be needed to reliably
>> check the endtime.
>
> I thought select is pretty trivial to use in python, basically:
>
> 	sock, _, _ = select.select([sock], [], [], timeout=to)
> 	if sock:
> 		handle_sock()
> 	to = endtime - time.time()
> 	if to <= 0:
> 		return

Yep, thanks. I sketched out roughly this, but using the selectors module
which will use epoll under the covers.

https://docs.python.org/3/library/selectors.html

