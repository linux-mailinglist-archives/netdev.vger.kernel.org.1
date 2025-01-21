Return-Path: <netdev+bounces-159902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B3A175A1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44C53A2622
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE554086A;
	Tue, 21 Jan 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARPtmqEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BB2629F;
	Tue, 21 Jan 2025 01:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422572; cv=none; b=Eim3kv9vtY+tEyZM36FMR/UrNb5uiCv71dL39MJq2aLCplaslwRpVibCB806fyWnztC1iL3DWe7DC/6Ae29G6jNf67sJoAHWuj7XDn9oFokbER29jKOxKhsi7phW5us7dtXWbmajyksSot3GV3mCf41jtRwQQQMN6oQzOflkb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422572; c=relaxed/simple;
	bh=W7eG8uJWetZv5PZx8aBcpUBR54+dfxzy4Asx7am4Sr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLtoRRc/frVKSs/x3ONsbMmdm3b1ZMJVlK+9EOHtmcOrdYWVJxSrBsxSGLdlQysC0FQYtAPZ0+XcoUYJIg+fiqB2EozjGoFlS5dekGiLXOrl1F29TqOurQ+jDe+LSANGaE6UzJMkuJD5+5nAauW4Qk3xgyOthEfq148qcxYjdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARPtmqEP; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844e55a981dso139848039f.3;
        Mon, 20 Jan 2025 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737422569; x=1738027369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ktuJ/IQhIqzktUIteQKCqG3X3vISHaHjd1OBRIoQk=;
        b=ARPtmqEPCOr7N3uUwmQccTQGPFnbCxTvE6cpwFI0qgB6dhLuREMRue3WUz+n9IPXdD
         qiumwHCHSarGPCXnu5203lCor+Z6hgsk4kB/XN4eW/TzR1O3+xJ2QxIypchNt4dL2GG6
         ssXJQ9d5qbOz33MULz5kz9jaDEg/XBJot6Y+zWiELF97oosGNW+MoWMRsa6dZ+8OoMVe
         fm2wYFXorZYGGjgX6c/Hg/oI2pS5tkUF8fe4tcbEj28I+TMczSSi6D7gx4nUxlonOk9i
         si+oDiNzeRFj/ujwdPy63DQDQGlqAwhU7M2niiactlZx7KdcHZj/KtqzCRyE99cx3zJM
         XwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422569; x=1738027369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1ktuJ/IQhIqzktUIteQKCqG3X3vISHaHjd1OBRIoQk=;
        b=rPJz7vGpnCL4d6YeZ/QyrZlyK3bBpjlPoCGrAeACe1WdEnJMIwx8jaHH6ZZImkeQm1
         y9QIDfT5aX0AodGocr0m6x3WXRTnknQS/9lpXShpwGYadfkXzy9ZtlwhDjG0J41KZnse
         ZiccMaxGIgDuCTLSczVHxxtkka5XkWWHiwBXUnRuXLsSC/q1p1nwWJgD5mo4zK4aP5nO
         wv4pd9s/8C8xDoen/8bJNq1mtkTotnbrAgHb5KPnDfO71GXNpEPpqW/7By1OTtviCpap
         0rVUz4apDVbigyDxNDTZKxMgQ+OGPI6PFmEsmsAph5Ex1RwiMzn99FqELIemNLBWkqar
         wKUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEdCp66WCYfRz3rs4e4/4ClHnlO7ll27svmUKS2YAc1syDvb72pXAo8+RdAVmr2y42IJvXb+W9gg5wO6w=@vger.kernel.org, AJvYcCVu3vwlmAO9mnXhIuaifgOp1iRs+HvEhHirvUwKRm5ifFtAHA8LYgJYIEbXtSg0Z/V95VNJIOdqeywTVmCMogG1JiMd@vger.kernel.org, AJvYcCVwUCK9LMTUO4jwhoDg4oq6LsAoe1fSoyNruGKlb1Pm3S/vW8v4L02TrLXOa7sdK3EM8evVmDVQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9uhVTW884l+J47WIdeuYze5mLeP23RJWE9D4fReCEBRTpDC2
	qY/HwsIKdZdCGHpkWYyEvui7P1C+uocYqL0H4KqTS1QbVCCJwcfxI8/wYw2zba56OFUGrqeDa6D
	T/jc1hj8JYfPuzJaKpfRRMxy5X8XJRA==
X-Gm-Gg: ASbGncvxjZBpJSnRq6iv93M98kUAVW5mL4RWgCnhTp6jsLbroeKaD5/HGBSxMZ8c5TD
	6sw+IpHowlF6hwUm7Kg405BVOPCRCF4GJeqITwycH6FFXPst2F+Q=
X-Google-Smtp-Source: AGHT+IF3eBZoLrpFN3tedFgfBPfoCHfxakJQgd04vCdcfjZ9nrE7bLBiOt5oaSy0mcKIcw7n1XYPCO30gU0lcT7GN9c=
X-Received: by 2002:a05:6e02:17cb:b0:3ce:34b5:abf7 with SMTP id
 e9e14a558f8ab-3cf7440b2b9mr129325615ab.8.1737422569442; Mon, 20 Jan 2025
 17:22:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
 <20250120-panda-of-impressive-aptitude-2b714e@leitao> <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
 <20250120-daring-outstanding-jaguarundi-c8aaed@leitao> <CAL+tcoC+hVZU2rx6vVQO_BjAAfjLXvqCOVDHkDoBHYuykqS1dg@mail.gmail.com>
In-Reply-To: <CAL+tcoC+hVZU2rx6vVQO_BjAAfjLXvqCOVDHkDoBHYuykqS1dg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Jan 2025 09:22:13 +0800
X-Gm-Features: AbW1kvbkUJTvZFbUIGbPTGgEKEI94qMbEWvEfYimLKcXM48rNKp8jHvI8riteg0
Message-ID: <CAL+tcoDXjd-C5SiJHr-0fpFaASxKS8emaOUQWXv2R_POrjmYgw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Eric Dumazet <edumazet@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 9:15=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Jan 20, 2025 at 9:20=E2=80=AFPM Breno Leitao <leitao@debian.org> =
wrote:
> >
> >
> > On Mon, Jan 20, 2025 at 09:06:43PM +0800, Jason Xing wrote:
> > > On Mon, Jan 20, 2025 at 9:02=E2=80=AFPM Breno Leitao <leitao@debian.o=
rg> wrote:
> > > > On Mon, Jan 20, 2025 at 08:08:52PM +0800, Jason Xing wrote:
> > > > > On Mon, Jan 20, 2025 at 8:03=E2=80=AFPM Breno Leitao <leitao@debi=
an.org> wrote:
> > > > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > > > index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..fc88c511e81bc12=
ec57e8dc3e9185a920d1bd079 100644
> > > > > > --- a/net/ipv4/tcp_input.c
> > > > > > +++ b/net/ipv4/tcp_input.c
> > > > > > @@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, =
int newly_acked_sacked, int newly_lost,
> > > > > >         if (newly_acked_sacked <=3D 0 || WARN_ON_ONCE(!tp->prio=
r_cwnd))
> > > > > >                 return;
> > > > > >
> > > > > > +       trace_tcp_cwnd_reduction(sk, newly_acked_sacked, newly_=
lost, flag);
> > > > > > +
> > > > >
> > > > > Are there any other reasons why introducing a new tracepoint here=
?
> > > > > AFAIK, it can be easily replaced by a bpf related program or scri=
pt to
> > > > > monitor in the above position.
> > > >
> > > > In which position exactly?
> > >
> > > I meant, in the position where you insert a one-line tracepoint, whic=
h
> > > should be easily replaced with a bpf program (kprobe
> > > tcp_cwnd_reduction with two checks like in the earlier if-statement).
> > > It doesn't mean that I object to this new tracepoint, just curious if
> > > you have other motivations.
> >
> > This is exactly the current implementation we have at Meta, as it relie=
s on
> > hooking into this specific function. This approach is unstable, as
> > compiler optimizations like inlining can break the functionality.
> >
> > This patch enhances the API's stability by introducing a guaranteed hoo=
k
> > point, allowing the compiler to make changes without disrupting the
> > BPF program's functionality.
>
> Surely it does :) The reason why I asked is that perhaps one year ago
> I'm trying to add many tracepoints so that the user space monitor can
> take advantage of these various stable hook points. I believe that
> there are many other places which might be inlined because of gcc,
> receiving a few similar reports in recent months, but there is no
> guarantee to not touch some functions which obviously break some
> monitor applications.

Before BPF gets widely used, changing function names will not hurt
applications. Things are a little bit different now, changing names or
inlined function will lead the monitor application adjusting codes
through versions, because they are not kabi functions.

Thanks,
Jason

