Return-Path: <netdev+bounces-159773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8CA16CF0
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E399A3A2F0F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596DA1DFE16;
	Mon, 20 Jan 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOGErsal"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DD1DA3D;
	Mon, 20 Jan 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378442; cv=none; b=p5wqZpBeTHWYBB2ye6HdN/3hNUZyJ3sxDFQD9padHmDKhdKJuVt41sImujx3L8avip7rm6Yw1WL1EoW2Qf5qQVb2kKXG4fyCHir3p2CUizpkpmtOJ2RPAIrvKkFxiAf05DUB8O3SCscCsWxXOSTvkq2tCT6T8i3EvHAnR2T8m0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378442; c=relaxed/simple;
	bh=PCBVjaoNEhsBY5v97sPWSZrrtK46PpEQz8Hgc5/Rt2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljGCPkjmpQCfTOSpemDhFHsZcm5IIF9uPkDHNOmOTftCAYQLp/85Ya9IIFBO6oXVQh5waIQePGFwUPiRkYx9jrRyrY/pZAfAMFgGbqzt8/bYN15NUp9FHlV4eQKXcoMZy8tzWd6V54ygMDtRXgbRZ3NJxHi6YKJkZXtOJuxYX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOGErsal; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ce7a33ea70so16284585ab.3;
        Mon, 20 Jan 2025 05:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737378439; x=1737983239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEN5ywwnLq6wHW0B8Ad5cY0PLb+vuJhnClSqZxYQH6w=;
        b=MOGErsalwr+kB5gZPzxYpX6Fpqd2vn1eMSZ+MXB6To5tej9UFUJV3aMA74SQcT39QS
         Y2YelHvhzUWVcS1kiUGhU6ZeFqWPy+R6q47U2VP72tZr9AH+F6Q8K1TUgYNUd4kYjH4C
         ucV4ub1iK+3DkrVEgMCfDPqEmMU2RaYMDFF9Qy7p+cQqmLz6jnA/jprNJebsqyglFn/J
         1YoXZcsUlQPliFMKcK5VrLD92qoXlLkfbKoGToejxsVQXjWsNn5E+0Lgo3SIfBg67cqq
         +zY6j3hhlVx0tFxbEWUXRgUfVzKRlJiecsfoRB4lUGTYsf4VuzbiIRKF4RyIucsg7NXs
         Na+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378439; x=1737983239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEN5ywwnLq6wHW0B8Ad5cY0PLb+vuJhnClSqZxYQH6w=;
        b=E7ntNjygA/WjLh1x/R2e9/yKQmudsiq1XV8RJSJvrkgf5Kf/v5lo57cLW0kK+lrj7J
         5UEqWBUGtrkXAfF9Te1m9jRkTOAOlTK3Gs6cJviesAyBQQJWJUiZly5jMuOB8PB7mtlm
         YBIjxgBgn+PQ/DrI/YRmJL8rnktN8h+XRav345ILRFpzSytxOXDR67SgyNi7hVcIUaSA
         C7c/j+i5lAllwXYz1OY5n4/M68uZgsL2NVSaDdkAVfr4Exg0EKYrySgxZKjlIQCTwtRp
         Cd0ela/fBV+pI+0vZ3z26ausc8yOwbE+9YmkyXPDd7FeZy71IMnzakqVQ8+kSSbXBzYB
         uUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiSN60AhXO0wfD6K3VeH5RtZV3XMtmOBN1p64bptXvGyjHlOTQs1sduguoP7dcK0uTfsVsl6/cFaDR/GvMdnP5Goc3@vger.kernel.org, AJvYcCXABZkh+NeAeygWgUcUDzWZlTnLQ0e+NLthJ2XSKFsrESH2hBhJkqi2udxtS2cXcH7gFfP/sMCixYN2H2w=@vger.kernel.org, AJvYcCXgklsCwOzhUdrQ93t60fPy3M7BlAj65Sthh8mMrGJGBR73rg5yFTlp9ryKKm99qEwyTiujQ+EH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz306d1RfYAdkCVIL47cm+7iCxpaP62iYwjRP03c4zrTdMmAObu
	eZm/6d90UKScjK1ScmSojrM6/FF+6Kon0IWF2Nv6eFQi7KDEwAJ7xWT/OmaC3k3MsfkdXPxV5ef
	ANEGwZ7Eycwmp3WjwWSgbBoPOERw=
X-Gm-Gg: ASbGncsngkr7SqbSRx9OGh/D+E/XwCcc/DQmCpAkF4n5uMeG6tNmxSUZd0Ls+cgEnue
	nslKmfQ/J0tS9wGzE1OevZoab++W6GZsEukB7xA4dcQmFqVmOGu8=
X-Google-Smtp-Source: AGHT+IF2RGj2HaPACCganH4xBokX2kiyI7QmDpRwWml29FbraFhJaL+5PPt+X+TnrmxdusrRiCcspIJWAJWFOIUbKgY=
X-Received: by 2002:a05:6e02:2383:b0:3a7:be5e:e22d with SMTP id
 e9e14a558f8ab-3cf743c99c4mr107790495ab.2.1737378439494; Mon, 20 Jan 2025
 05:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com> <20250120-panda-of-impressive-aptitude-2b714e@leitao>
In-Reply-To: <20250120-panda-of-impressive-aptitude-2b714e@leitao>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Jan 2025 21:06:43 +0800
X-Gm-Features: AbW1kvaOo_KH71g_sMDbJCBL5sZ3e691-6lmmGB0hxIFx-zTjCy061vYB4NUu6Q
Message-ID: <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
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

On Mon, Jan 20, 2025 at 9:02=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Jason,
>
> On Mon, Jan 20, 2025 at 08:08:52PM +0800, Jason Xing wrote:
> > On Mon, Jan 20, 2025 at 8:03=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 4811727b8a02258ec6fa1fd129beecf7cbb0f90e..fc88c511e81bc12ec57e8=
dc3e9185a920d1bd079 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int ne=
wly_acked_sacked, int newly_lost,
> > >         if (newly_acked_sacked <=3D 0 || WARN_ON_ONCE(!tp->prior_cwnd=
))
> > >                 return;
> > >
> > > +       trace_tcp_cwnd_reduction(sk, newly_acked_sacked, newly_lost, =
flag);
> > > +
> >
> > Are there any other reasons why introducing a new tracepoint here?
> > AFAIK, it can be easily replaced by a bpf related program or script to
> > monitor in the above position.
>
> In which position exactly?

I meant, in the position where you insert a one-line tracepoint, which
should be easily replaced with a bpf program (kprobe
tcp_cwnd_reduction with two checks like in the earlier if-statement).
It doesn't mean that I object to this new tracepoint, just curious if
you have other motivations.

Thanks,
Jason

