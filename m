Return-Path: <netdev+bounces-72188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C89D856E81
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DA71F249CA
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A913AA39;
	Thu, 15 Feb 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSXiedEo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720C13A879
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028609; cv=none; b=ukr0FXYfzGJXX4LtDF9f4RPo2MqwZMW4D7DlDoZDofoju2ddFyxnx85Of2X9DXbL1nk4IbY/Bqiaz++kn3jDI23FOQdnLCl9JVlYmNDIiHErnP9bC4AzeH+tUBFDtP84cb+pk7SgqfpJpBF3xSCKe5Iu/BtlOwNFvMkhTD8BRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028609; c=relaxed/simple;
	bh=1D+WvK1GlQuVjRbE3g6JG6QhxIRdYO3lve18plRPqGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MAc40zZj30Spe6IV43X8cs0LSqU+L3OWkwtYuN+gLNRmnnl6TrNsE1TsHYun2spgMuwoABZzufrJ29L//XhLdIs6V+i8RrvtUOm2VjAlhhpFUfZG4TYFVmjmc0AayijfEDIsX6xG3gUdI3cC5fk+cz6EhOYEUKMYL+kbuN2GCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSXiedEo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708028607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1D+WvK1GlQuVjRbE3g6JG6QhxIRdYO3lve18plRPqGE=;
	b=LSXiedEoZuijDijnFFN8c3SPOoL5wY9Y7Cbynn/a1cDsN2WvFe2NrsprglhncvbTGWNYXt
	dKpPdn31YAK1eZm5S2E+j4JR18VnE2KMJ8ExSzIdSHGS4IBYx3nDhPOj5aP8DimHxXcVXV
	swqX1gMndHumah5RWMfq/XqnTcBJ36I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-Fska3Z0COZqwp8eCDDbfrw-1; Thu, 15 Feb 2024 15:23:25 -0500
X-MC-Unique: Fska3Z0COZqwp8eCDDbfrw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3d38947c35so78089266b.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708028604; x=1708633404;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D+WvK1GlQuVjRbE3g6JG6QhxIRdYO3lve18plRPqGE=;
        b=MSp/5fksgR1vdAppWVp7E3hTHcC1JRnT2Y9NWtKQIpQEHYGv/sGCvfIUOlG+HscIm7
         yu1H8/QlB79vNqM5Y7RhbddWpdhibXhZ8CXCs4X7570iaQg48Nid8lvKGZuQcAotS28S
         c4KYNG1F40JRYKdw+SRtX8SF4pK/RoeCKZAfmgwu7WYjxy/efaBr5eVuyrfUwy/771k7
         jNq50YGcMHSIQ6lvIKA2FttN6yilaAN6XL8pi3drW7UZvnGliQgZQTdaoqyQRjVdPLPr
         KU9IigvU6hXg81AxSKEXmbz+eg1N7QktLEklOt6VtdAkmfHxcO7d3wT06wtF+L27cIdO
         xHiA==
X-Forwarded-Encrypted: i=1; AJvYcCUb1FLtY+uPc54ovcAR02ua8Gvyij3ZHt7jZyoIuXue8hoTXm6DwgDQXGXP8l2SGVhYQxOTAStFjXo+yKrX5Ft0z/OS7JVb
X-Gm-Message-State: AOJu0Yy7nWLUaZx/cBaLZaxa/BgNodEwd3OLMwznGpGD87p0flW3Rw55
	OjqplrPwkhMSMDND1R+xK9nwFMV85f4RejD6T3F1CPRO5l/e1nxDfDZZYsVlq6GYWBQgeUsfqim
	FCdvR3rKpZMJovr5sdl/AzliPIIR1diyhoX9/t4whjoqu+Cql56/Hcg==
X-Received: by 2002:a17:906:ecea:b0:a36:fc15:c6d2 with SMTP id qt10-20020a170906ecea00b00a36fc15c6d2mr1983956ejb.5.1708028604662;
        Thu, 15 Feb 2024 12:23:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjMCOfzmzUW84gaUjk+fIq8/Pz5pfJYAG1xBKJ3oR8bLMhqrtDkSZ7woZT0xqoe7qN4E0QeQ==
X-Received: by 2002:a17:906:ecea:b0:a36:fc15:c6d2 with SMTP id qt10-20020a170906ecea00b00a36fc15c6d2mr1983935ejb.5.1708028604261;
        Thu, 15 Feb 2024 12:23:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id tl11-20020a170907c30b00b00a3dc41cc812sm143314ejc.17.2024.02.15.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:23:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3CFD810F5A55; Thu, 15 Feb 2024 21:23:23 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240214163607.RjjT5bO_@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de> <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de> <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Feb 2024 21:23:23 +0100
Message-ID: <87jzn5cw90.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-02-14 17:08:44 [+0100], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > During testing I forgot a spot in egress and the test module. You could
>> > argue that the warning is enough since it should pop up in testing and
>> > not production because the code is always missed and not by chance (go
>> > boom, send a report). I *think* I covered all spots, at least the test
>> > suite didn't point anything out to me.
>>=20
>> Well, I would prefer if we could make sure we covered everything and not
>> have this odd failure mode where redirect just mysteriously stops
>> working. At the very least, if we keep the check we should have a
>> WARN_ON in there to make it really obvious that something needs to be
>> fixed.
>
> Agree.
>
>> This brings me to another thing I was going to point out separately, but
>> may as well mention it here: It would be good if we could keep the
>> difference between the RT and !RT versions as small as possible to avoid
>> having subtle bugs that only appear in one configuration.
>
> Yes. I do so, too.
>
>> I agree with Jesper that the concept of a stack-allocated "run context"
>> for the XDP program makes sense in general (and I have some vague ideas
>> about other things that may be useful to stick in there). So I'm
>> wondering if it makes sense to do that even in the !RT case? We can't
>> stick the pointer to it into 'current' when running in softirq, but we
>> could change the per-cpu variable to just be a pointer that gets
>> populated by xdp_storage_set()?
>
> I *think* that it could be added to current. The assignment currently
> allows nesting so that is not a problem. Only the outer most set/clear
> would do something. If you run in softirq, you would hijack a random
> task_struct. If the pointer is already assigned then the list and so one
> must be empty because access is only allowed in BH-disabled sections.
>
> However, using per-CPU for the pointer (instead of task_struct) would
> have the advantage that it is always CPU/node local memory while the
> random task_struct could have been allocated on a different NUMA node.

Ah yes, good point, that's probably desirable :)

>> I'm not really sure if this would be performance neutral (it's just
>> moving around a few bits of memory, but we do gain an extra pointer
>> deref), but it should be simple enough to benchmark.
>
> My guess is that we remain with one per-CPU dereference and an
> additional "add offset". That is why I kept the !RT bits as they are
> before getting yelled at.
>
> I could prepare something and run a specific test if you have one.

The test itself is simple enough: Simply run xdp-bench (from
xdp-tools[0]) in drop mode, serve some traffic to the machine and
observe the difference in PPS before and after the patch.

The tricky part is that the traffic actually has to stress the CPU,
which means that the offered load has to be higher than what the CPU can
handle. Which generally means running on high-speed NICs with small
packets: a modern server CPU has no problem keeping up with a 10G link
even at 64-byte packet size, so a 100G NIC is needed, or the test needs
to be run on a low-powered machine.

As a traffic generator, the xdp-trafficgen utility also in xdp-tools can
be used, or the in-kernel pktgen, or something like T-rex or Moongen.
Generally serving UDP traffic with 64-byte packets on a single port
is enough to make sure the traffic is serviced by a single CPU, although
some configuration may be needed to steer IRQs as well.

-Toke

[0] https://github.com/xdp-project/xdp-tools


