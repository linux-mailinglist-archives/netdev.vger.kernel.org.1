Return-Path: <netdev+bounces-169172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A011DA42CA5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B323175522
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CB1FDA79;
	Mon, 24 Feb 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHgcLj00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865C1FCFE1
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424996; cv=none; b=orLGUSionmagZAFenDQNXFXv54YbhtrAlCvq5gN3zQVlslRbvCMKnOywAdbGPDAVmXnHvLCy6JkbqlWGntDO5132YNw3yhwx7Nl0SlYMNsVXLf9bAU1J4UCf2TwIuRtT4tlYQ8n7xaZIAWzH3eTkAa44Etjd16yH/Ue1qkEubmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424996; c=relaxed/simple;
	bh=MuxBrNIX06+MBlaJPoUCPaS8vE9mO1mdJznRkFGE6ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8yiwAVMcX1VBu7XaknrnjHqTpStsffhaoYK0XmsmudEtmw8JB+lfkBQnquh7S9XcrdM3cWG7QUbpRrdZJl3/nmLtM1aypGlGHWUwMVvm2NpEMZBvxZifkVIy5niGYbAW+VJYOX4NoM/UAu0NNb5Hc9nhkA2oxUnuzxJiH0glcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHgcLj00; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so6823529a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740424993; x=1741029793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G9JOwMMqctfXuBGODgzmfMVslmCh5Emd9i+EC8Wh/o=;
        b=tHgcLj00AAnkKI8aQt7gSbFjqqkq0FGg7X/srfkxhdwKmExjXzgED7als5mQMK6irq
         W0RCnO0SBUxfdvsUac1heVRRDwYxKYGsVpkgNFjJm2gJAk4j0JtMQnm8hV8nykP2TPJJ
         +mPCkbU+1rWl74XxVSH2JVuqjDE9XRuRpwzayRRn5lCH6sIFgrrYLbrunru4qAHumRbK
         8y2UF10CGMThGr8jOZEY1RIN2OSxTBKiXs6lLG/l1XujrekTrJ7El8D8cnHKGhYA4vfP
         dPDNFH6Tib3yLXQdsymufPstsZN4t9kd3zufgz8SgKtDeoBwz/xEjaGuxk7k0jcdYg6w
         /WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424993; x=1741029793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4G9JOwMMqctfXuBGODgzmfMVslmCh5Emd9i+EC8Wh/o=;
        b=Og6gqRhhJ64MZNId7MCyxk8m0iaa7sUdk07I+zQ5t9Z+Jl0LwX9Cro3shh1oZM2OrY
         BacWjwlllgSXr7jytJZc45hDBDSAG98znVFNL0BF7zOlwm5DGqMw7T11GAdnKRbohiye
         le2RnQfexJU9AmKBkBkSrQzxmhJ0QFLmR1k9rBVdbRIOj9OkIc4G4kIoxTOlHziLxKSF
         af1W3/wPKcb6EyxjvHu4y6ArFvLVpJveyy4qZVEh2v+B43npErtMjPp+d3SjAvZnB/dg
         jAyHTW92haN2WYMUbJIf2FrIHrnLSuLCG+ylb1n/8i0PxzCSyr5dakaXx4Sa0qBNTgVg
         Dntw==
X-Forwarded-Encrypted: i=1; AJvYcCW0+gxGW0DqcaS5VZ5mXfCkCoeymGH7UOfBq3lB3SWhk71c/uA2+L4CiV2vtqyX7An14CULIio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1F+GCItDuBGyqlhQCvBGlvvQdmOVCMVWX38w/ytVLPPyOESB
	aWnd/HdztggdWXQi67DkJOa596fTnWROjd6X3h/8CYc/Uff7CNI5zAgueKUWdLZ7QGcmS9V1kWD
	THvczaOlChhghJ6kRNIxcO7DjBJloragrZGNC
X-Gm-Gg: ASbGncvMVJFy5TCxQ4zyNl3tIWtRWqFCKp3xjTTcISVgEwZgt1yhSzO4BmTSW0wG8fe
	rXu8rFfiirDRRmYNBq5dGBdmMiPNvBLVi3mfTx/lidcyJfu9+Pie+p97wjAOxawmYS2IU0GSUss
	GdotApuQ==
X-Google-Smtp-Source: AGHT+IGfiIchpM9eOMnXtJ/WcKCVUkgDFUa2p/xrMF61h/aNYjj6Fhs5Fbn5eztpvP2RHcdoRWctJt81jVevyjeHkjo=
X-Received: by 2002:a05:6402:238f:b0:5e0:348a:e33c with SMTP id
 4fb4d7f45d1cf-5e0b70d674amr10053613a12.10.1740424992694; Mon, 24 Feb 2025
 11:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com> <SA3PR15MB5630CFBB36C212008DA8ACC7CAC02@SA3PR15MB5630.namprd15.prod.outlook.com>
In-Reply-To: <SA3PR15MB5630CFBB36C212008DA8ACC7CAC02@SA3PR15MB5630.namprd15.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 20:23:00 +0100
X-Gm-Features: AWEUYZnUmpoUUWnKefqPzOGV3a3YKaKSZHqzoRXrvSuNNgfx9ij51R1mq4ffPRc
Message-ID: <CANn89i+zxMje+wbQzLKbSq_WKYnwGdMyAdStMm4GqkdJCvWPOg@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
To: Yonghong Song <yhs@meta.com>
Cc: Breno Leitao <leitao@debian.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:13=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote:
>
> > ________________________________________
> >
> > On Mon, Feb 24, 2025 at 7:24=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> >>
> >> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabli=
ng
> >> the tracing of TCP messages being sent.
> >>
> >> Meta has been using BPF programs to monitor this function for years,
> >> indicating significant interest in observing this important
> >> functionality. Adding a proper tracepoint provides a stable API for al=
l
> >> users who need visibility into TCP message transmission.
> >>
> >> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> >> creating unnecessary trace event infrastructure and tracefs exports,
> >> keeping the implementation minimal while stabilizing the API.
> >>
> >> Given that this patch creates a rawtracepoint, you could hook into it
> >> using regular tooling, like bpftrace, using regular rawtracepoint
> >> infrastructure, such as:
> >>
> >>         rawtracepoint:tcp_sendmsg_tp {
> >>                 ....
> >>         }
> >
> > I would expect tcp_sendmsg() being stable enough ?
> >
> > kprobe:tcp_sendmsg {
> > }
>
> In LTO mode, tcp_sendmsg could be inlined cross files. For example,
>
>   net/ipv4/tcp.c:
>        int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   net/ipv4/tcp_bpf.c:
>        ...
>       return tcp_sendmsg(sk, msg, size);
>   net/ipv6/af_inet6.c:
>        ...
>        return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg, =
...)
>
> And this does happen in our production environment.

And we do not have a way to make the kprobe work even if LTO decided
to inline a function ?

This seems like a tracing or LTO issue, this could be addressed there
in a generic way
and avoid many other patches to work around this.

