Return-Path: <netdev+bounces-102352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF34D9029EA
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C2E2847D4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 20:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725947A60;
	Mon, 10 Jun 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BS4mV88J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F03E47E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051149; cv=none; b=bVmcTsxp3Ou3rMnQMAJ1mRbxoJeUhQu0qUSuc6KvX7+8patyu71i+dsuVmt3hoIyopA8hJtrx5yz1sSuLGFnW3CON6ZmgWTbw/G+VHpdBJIWmVdgPzAAZQrzZ+7QhRwyjx0VU/bsmUzZeUn+Qu7L+XPADoXv9op3/EAxH4u2Lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051149; c=relaxed/simple;
	bh=SONlq9bXQbAkTw0EihI5/xjKerm7ff58Ryq6LfBbhF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDFrKfsCdIi2sAFe0+XqB0sKIMg90oC8S+infvPRtxYSpRcriyUmzyPJs9pSLvXDxdVZsHZ7/KgDi2CXsuLRUspf/a0bXU4AOMS827pPSYus94suFMWzo5Wjv1xPDkvYPvZaWVcStaycJ0aY617oT96Vzi8UWuv/j19qe7GXW30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BS4mV88J; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so3758773a12.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718051146; x=1718655946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wH3mYXJPFC56KG/UdINpo4FbUx5USQeX53C3PDh1Bk=;
        b=BS4mV88JHJcQKOZH4AjD/VXAJRB4cGA+sC/iEuSHK1446agPTX8IyrvQxzYXAcDKrz
         /jxI4dUEFadkJGS9o+OFujWmP8VmZ5LHersUiOFaltIVoPQORYzB3qfd6xeMnlIOACA1
         7ociECb8aVwKYIzvu7VHQY1nu840AiC10HUeseLxS28KI1IgwqUa8QQTlKhs71S6+Zlw
         XUZu4bfEmcnNt/X7iZF+Ext3RIfANRLjNA4G5sqHv0ketyjXscSebxmeLo5hoT2KVMP3
         LdGLT1cItVzGnsZ3O8850AVnsYU8pW60fLbVNJgIf/sn1QdvyTKownzX3WKscDGgpMIs
         ozrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718051146; x=1718655946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wH3mYXJPFC56KG/UdINpo4FbUx5USQeX53C3PDh1Bk=;
        b=QMsm75HFKcKZkTB9pxqZHxIB5HZDeBL2WiUurVx2uq6PYxkvHR6dWGdbWs6uBHcqLl
         kOmolAM81z6aL8YK8m5QMVItb63Hq+eIAEUNOfeKWQIyBLepOmS+l8vVKMWV/YRC3S25
         tCLFvPfz1c6/uu2g2dFVfTruOVun341bhMh76FZF/uRu69K0HJ4HD2hrL+Cz0F9tReaX
         4mMmKekuJadFaIEGxDHnLFP5AK3dXSKo1j4/+Z2noliKASdrcSbXAAEatFhLlzWeUiC1
         EOgCw+Ddg5nLgBe9KKahgsKQK6NaafYa9MG7d6p9Q/QxSubyz+ukhE2L+GMKx+wM2qQb
         an2w==
X-Gm-Message-State: AOJu0YxpOcVyUPcaO6WnmFZMA6RikXcKV1c0NsHPg8akKdxXiQBITTV4
	yOGPj34qoGEsUyxDRia0Z1MolxsF3wGz5rarN3BpAuxN8nLO/p3giIAHvBsY6LMyVZbOfoFc+X1
	u8PPTE5gZKd5zShNj+p+iZLaDDgxSAunITC0PKw==
X-Google-Smtp-Source: AGHT+IFeNM+vnJ0I5dqzaSHadBEEqlOnv2kTGQITQ/wXOYx520e/KZSJn/7E3GvgAEEb7/zIgfGp2FD5q2fX1wytAaQ=
X-Received: by 2002:a50:8751:0:b0:57c:7f3b:6b9c with SMTP id
 4fb4d7f45d1cf-57c7f3b6bbdmr2819913a12.5.1718051146118; Mon, 10 Jun 2024
 13:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717529533.git.yan@cloudflare.com> <983c54f98746bd42d778b99840435d0a93963cb3.1717529533.git.yan@cloudflare.com>
 <20240605195750.1a225963@gandalf.local.home> <CAO3-PbqRNRduSAyN9CtaxPFsOs9xtGHruu1ACfJ5e-mrvTo2Cw@mail.gmail.com>
 <20240610125422.252da487@rorschach.local.home>
In-Reply-To: <20240610125422.252da487@rorschach.local.home>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 10 Jun 2024 15:25:34 -0500
Message-ID: <CAO3-PbpX1RCcYgr_xKVoO=MYOrP6jBhtGuTbptjRMjR=VAvthQ@mail.gmail.com>
Subject: Re: [RFC v3 net-next 1/7] net: add rx_sk to trace_kfree_skb
To: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Mina Almasry <almasrymina@google.com>, 
	Florian Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>, 
	linux-trace-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:54=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 6 Jun 2024 10:37:46 -0500
> Yan Zhai <yan@cloudflare.com> wrote:
>
> > > name: kfree_skb
> > > ID: 1799
> > > format:
> > >         field:unsigned short common_type;       offset:0;       size:=
2; signed:0;
> > >         field:unsigned char common_flags;       offset:2;       size:=
1; signed:0;
> > >         field:unsigned char common_preempt_count;       offset:3;    =
   size:1; signed:0;
> > >         field:int common_pid;   offset:4;       size:4; signed:1;
> > >
> > >         field:void * skbaddr;   offset:8;       size:8; signed:0;
> > >         field:void * location;  offset:16;      size:8; signed:0;
> > >         field:unsigned short protocol;  offset:24;      size:2; signe=
d:0;
> > >         field:enum skb_drop_reason reason;      offset:28;      size:=
4; signed:0;
> > >
> > > Notice that "protocol" is 2 bytes in size at offset 24, but "reason" =
starts
> > > at offset 28. This means at offset 26, there's a 2 byte hole.
> > >
> > The reason I added the pointer as the last argument is trying to
> > minimize the surprise to existing TP users, because for common ABIs
> > it's fine to omit later arguments when defining a function, but it
> > needs change and recompilation if the order of arguments changed.
>
> Nothing should be hard coding the offsets of the fields. This is
> exported to user space so that tools can see where the fields are.
> That's the purpose of libtraceevent. The fields should be movable and
> not affect anything. There should be no need to recompile.
>
Oh I misunderstood previously. I was also thinking about the argument
order in TP_PROTO, but what you mentioned is just the order in
TP_STRUCT__entry, correct? I'd prefer to not change the argument order
but the struct field order can definitely be aligned better here.

Yan

> >
> > Looking at the actual format after the change, it does not add a new
> > hole since protocol and reason are already packed into the same 8-byte
> > block, so rx_skaddr starts at 8-byte aligned offset:
> >
> > # cat /sys/kernel/debug/tracing/events/skb/kfree_skb/format
> > name: kfree_skb
> > ID: 2260
> > format:
> >         field:unsigned short common_type;       offset:0;
> > size:2; signed:0;
> >         field:unsigned char common_flags;       offset:2;
> > size:1; signed:0;
> >         field:unsigned char common_preempt_count;       offset:3;
> >  size:1; signed:0;
> >         field:int common_pid;   offset:4;       size:4; signed:1;
> >
> >         field:void * skbaddr;   offset:8;       size:8; signed:0;
> >         field:void * location;  offset:16;      size:8; signed:0;
> >         field:unsigned short protocol;  offset:24;      size:2; signed:=
0;
> >         field:enum skb_drop_reason reason;      offset:28;
> > size:4; signed:0;
> >         field:void * rx_skaddr; offset:32;      size:8; signed:0;
> >
> > Do you think we still need to change the order?
>
> Up to you, just wanted to point it out.
>
> -- Steve
>

