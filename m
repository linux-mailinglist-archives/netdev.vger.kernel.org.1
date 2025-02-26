Return-Path: <netdev+bounces-170028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E99A46EB9
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 23:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8301889FFF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 22:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12725E80D;
	Wed, 26 Feb 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwrbf/pK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331A25E800;
	Wed, 26 Feb 2025 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610036; cv=none; b=ItMYul9mU70kNbTlJEGqESaVVlBLDalljK9/7DO25acoAeJmxrWJq6V4JV6wJ7Zk6ht/DAZFH0t30k0vkrXEfI7t+R4zR21IkKH9a3H+jn/dyRnknJIay62yN4M5osIyZcxeVNqnN7LwRVYsDjkdvEmiL7Td5ars8zMphnoBaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610036; c=relaxed/simple;
	bh=NiB/0Hv7B9rJJ1mcVx0hEwGrXQNl2EhmmWqB8YzD7/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDHv4G5IFnPtF4rKYUe23Ix9gMi9XZqnNrGeGeHy8MztYwGLiLDjTSXD8/8iLp04WCQp9zHjZfZayWFHXpGZC5K5Vnnc6iO7XHWhk+qvARQbgv+c1QS4rj4OQsbNAAdDo9TvoBIILRM88Ldz/8b42Wz4Az7zPbM6K9PUuteMXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jwrbf/pK; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d3db3b68a7so2953795ab.0;
        Wed, 26 Feb 2025 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740610034; x=1741214834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiB/0Hv7B9rJJ1mcVx0hEwGrXQNl2EhmmWqB8YzD7/s=;
        b=Jwrbf/pK1iy04D/uVkYIb8+4T3E6rGCqfKjvXPeN/6BvwLDBDqPspodbDNTEBicbv2
         xZ597TNq+HKf2aO+Z8gVwFfLIKgPcAB1Z2Q3xmOCkTJ72qW7dLW5ZqWSdlPID4e8KB6x
         M8T+uEEOh1foKWIoIkHx8IpJIw2iO7Tr/rXDWq4u+QJ31JuC3v/7HF8KJmbxtlwJbnL4
         0xagzy462mnayguvawbnTUwg+V2YfJxiOZR4nlUD9QevdCZyi426X/sYJufIwOaLNjPN
         rhFN6NjxXomp5ggySMItWeR0RbsWUP6uvhLvZeSw4k0b6geBg1cbvK4NWUA0STJZp7WE
         snrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740610034; x=1741214834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiB/0Hv7B9rJJ1mcVx0hEwGrXQNl2EhmmWqB8YzD7/s=;
        b=vCv/3diSbxg7kje2lkiTV62bM+sTl6Weoxvr1BqCjIwegE2a5gQPMYMqGPHGlrQwAA
         vNjwYd2hnurpo5BgRYaOcBgnBqNSAL4c+iRalKQvz9DnShCuoTeyDjI0VJ0oXveFIiIc
         KTfnY8XmxLWekkTpNlZtNm34uz7Q8IhiubcIG9rocQQWMh3x6qP8q0+0BB6lKHOhIRK4
         ZZdC5sJIcCzSRRPQPXEk+oo1QkFaZCosYqprQYviJ95mRufTHGdH646t+Wk8d1615ThP
         qUmd2GvyXtD5YYVCedVSH6Yj7hQ5xq9zd/caPvogS6Q3VH9j7cDvTh2mOrOtyVZrX89P
         eQxA==
X-Forwarded-Encrypted: i=1; AJvYcCUL80ZXWz7JFcO5tyx4xsPerCSmLOoZ5DI0/ZVkvQMjtYdiy91hSqk+U2uPkB/WvKRRMSwcIxMABWq8RIFA+8qG6gDL@vger.kernel.org, AJvYcCUvWNZUAuvs9Xfw622Zulkb3HytC4tLtwS8XF53USIHlAucSWI9ib3PBZIVtvdzuvmkVqBTLgFfaNCaFsA=@vger.kernel.org, AJvYcCUwBkU4fnEkAduD6kxVBD+/g+w/M/AeuAGJJ38dW6b9pxAEL7U8r6Tx+X7b3hkZKU2/6AOdZCtN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoo3MmD0J30uAZH2+lTEy8Cq+MmrmfOeEdEwy8cPnv3/CNKcgB
	PxURwukOg87KseoPB1E0cpir2lEUkfEsXPM5v5QKKWqZQ9EXFKyBnr0TXyWayopXFUL8CGR4Klq
	7Dy1VBVCfG9xAlrKVnLzE/Kj/6iE=
X-Gm-Gg: ASbGncsATtoeWCkijLXIyQIEZuLK0AzmS6Iq6LfhJH50QrnlPSKnoC/ROardG9P8ld/
	p2yiUFq79FMQ65l1kUJ8PSbt3sZOKYibpS2LUYRSayfZRtje7dqgReRnSEgNn8bzXjW2QEJ/bjx
	PmN5USUQ==
X-Google-Smtp-Source: AGHT+IEDkyaBCvKG+jeUfydmJPq42wxXEiOEt/9TtX3jBybuaop9pjY/6wyBbjbU66wKxWXE4vHNAz1ftRtsBuFlmHw=
X-Received: by 2002:a05:6e02:1a64:b0:3d1:9cee:3d1d with SMTP id
 e9e14a558f8ab-3d3d1fa94camr61591535ab.19.1740610034120; Wed, 26 Feb 2025
 14:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org> <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
In-Reply-To: <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 27 Feb 2025 06:46:37 +0800
X-Gm-Features: AQ5f1Jq74MBOJohSv6TMoUiiDhSuH1iCbMaNWpxMH7brzPoWODwXEvzccr-WXTk
Message-ID: <CAL+tcoD=zr15PL5dMFzQm2huMsRrAsfxP1jqW57Atdk_gJjuDA@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: David Ahern <dsahern@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, Feb 27, 2025 at 1:14=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 2/26/25 9:10 AM, Breno Leitao wrote:
> >> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would cov=
er
> >> more use cases (see kernel references to it).
> >
> > Agree, this seems to provide more useful information
> >
> >> We have a patch for a couple years now with a tracepoint inside the
> >
> > Sorry, where do you have this patch? is it downstream?
>
> company tree. Attached. Where to put tracepoints and what arguments to
> supply so that it is beneficial to multiple users is always a touchy

Right. I am always eager to establish a standard evaluation/method
which developers have common sense in. It's really hard because I gave
it a try before. Maintainers seem not to like to see too many
tracepoints appearing in the stack.

> subject :-), so I have not tried to push the patch out. sock arg should
> be added to it for example.
>
> The key is to see how tcp_sendmsg_locked breaks up the buffers, and then
> another one in tcp_write_xmit to see when the actual push out happens.

Agreed on this point because a fine-grained BPF program can take
advantage of it. But it seems another small topic that is probably
different from what the original motivation from Breno is in this
patch: I guess, making the tcp_sendmsg_locked non-inlined can allow
the BPF program to calculate the delta between when tcp_sendmsg_locked
starts and when tcp_sendmsg_locked ends? I don't know. Probably as
Eric said, using noinline or something like this is simpler?

> At the time I was looking at latency in the stack - from sendmsg call to
> driver pushing descriptors to hardware.

So do I.

Thanks,
Jason

