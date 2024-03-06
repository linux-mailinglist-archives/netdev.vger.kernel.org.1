Return-Path: <netdev+bounces-78030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2E873CA5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4AEB228BF
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4613B789;
	Wed,  6 Mar 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgZ0KcAS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7A1361D3
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743895; cv=none; b=REjSqnyKNm382k1NY3zmaj0WC4/tkzLEmDMsT+pDp8j90U15Os9i2BLPd8W718O2K2+n/PD5e+6SLshUMos6woe3GrA5IrQlFmiZhUn1vjQ/v2PoKtIXWIn7keT+zc+Ig2FSbZBj+hYmK4JqhN9d339gVchDK4YdN7PNed2h7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743895; c=relaxed/simple;
	bh=2ZhRIiVOue9t1Wad+eKIOFn2M0PF3k+uzBlQG79ns5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAqvlki2qQ1CyVcsXmf5M+bFYz6TQFl8WXT0MG62pIfWPgcCpkqBBNiPnaaBtY887L6v9BkL72fvl8cJNCbRAvXBBne3JLWJR5dyxVhI8bk/lewpS45NtphNf1yt5EB6UZyDbKvUZrltpzfQp9R/69/awrrkiyDf+1lcsfo6WPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgZ0KcAS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-567f7bba941so1027426a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709743891; x=1710348691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAuNxTfS6x4OQHwyTAR2JW08hPHhuONnAVW1sMtWxI0=;
        b=MgZ0KcAS7HSS77yVu7xyCeHAcaC/1SdsNfuOebsPKTi47ADSikIPFHFpMVlwAuM3Lq
         ADh3B8tOCDjS8SO22bC5JH7v38MMF7sGik0mAt/5hJkVIW5AEQmXcFeW9oqhkFytK0rb
         /Ww9ONL83z+QuBnnhMONLXuuoA7qgm3K0ZfBZvgkcOLzqswyIaukdbQhLb3YNczFfmmx
         jgRR8h2ZQOpnYgWc7g+WCCi0m0f37F6bezegEtZlxh4cxVcQxJZp/udwbPuqUyp3aK1a
         0D9N4f04odZmGIVAHEJ6AuB6otT/H7GV6nWXPid/olVyvuohW5SN+xe5wVd+/4rfcXAt
         PowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743891; x=1710348691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAuNxTfS6x4OQHwyTAR2JW08hPHhuONnAVW1sMtWxI0=;
        b=A+iAxsSxADsWLgaGTC4HPbbO05bOSjN0dRqxh/eP4m3A33zFUgcGnE9t87RE1mDJb2
         v+4f0jHKx/aDY6gdu+fUUT6GU7WmXvhtA4W6A+bx7gfQKt9Rce8E26RJPoMFIGdYboba
         PDB9drcJ+K6y4U48PnqVGYhpcYh5yg9tCuaN7yclv1+eQIIOk5OPOS0WrTtPAqmotVTc
         u6tSlPdPrJft22fQwn6IoAt5cvTm0Ps56qg8bwFCmqYFzDQIggxdzHmQOlP7CxonzK0D
         PzZxdOgqtGMdptrKHiMS6/2LjUNlOxFQNEXD2vQKSJ8PDZfDB99MP8cDYo85XSmr68/t
         Po4g==
X-Forwarded-Encrypted: i=1; AJvYcCVI2G5bj+BOeTU4nCjAi5PmHD4Nbt4ufM954EcLZNU2OHJOSreRue+BarsjWiAf2T8bwAhhkWzMXQgQvlSkb4zdlzVbeXTb
X-Gm-Message-State: AOJu0Yz3yc4tiIKjptcZVO0lcdpqdvsC5uF5hFjxmwl+Kus/7TR0h9pc
	8AT4yeyA0vUmvhISkDFKMZEu0KtUTa/8Hla9KlRAInH7zWBv804VpRzEopmIF9Aeh5fsIxQASqL
	stigiH+k/+4KIfa9SBTShMdnobWcGrXOuNw0v+TfxKtilsChhsETt
X-Google-Smtp-Source: AGHT+IHrH3y3Ev3rFR65oa9/ga3T2bFvGKoWYUoW9uQPlR8wceBykqCSE0zANfpwXtxsNCt9XtLxrBXjLnroDNOKeBc=
X-Received: by 2002:a17:906:fc01:b0:a43:f267:789f with SMTP id
 ov1-20020a170906fc0100b00a43f267789fmr10647282ejb.41.1709743890406; Wed, 06
 Mar 2024 08:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-10-almasrymina@google.com> <383c4870-167f-4123-bbf3-928db1463e01@davidwei.uk>
 <CAHS8izP_PzDJVxycwZe_d_x10-SX4=Q-CWpKTjoOQ5dc2NSn3w@mail.gmail.com> <b85b36bd-7082-47a5-bf46-50cff8eb60be@gmail.com>
In-Reply-To: <b85b36bd-7082-47a5-bf46-50cff8eb60be@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 08:51:18 -0800
Message-ID: <CAHS8izMEJHWAHVjaKu9ZpeWRj1TwoLkmY5tCtDYxdDReBV8=Dw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 09/15] memory-provider: dmabuf devmem
 memory provider
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:59=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 3/6/24 02:42, Mina Almasry wrote:
> > On Tue, Mar 5, 2024 at 6:28=E2=80=AFPM David Wei <dw@davidwei.uk> wrote=
:
> >>
> >> On 2024-03-04 18:01, Mina Almasry wrote:
> >>> +     if (pool->p.queue)
> >>> +             binding =3D READ_ONCE(pool->p.queue->binding);
> >>> +
> >>> +     if (binding) {
> >>> +             pool->mp_ops =3D &dmabuf_devmem_ops;
> >>> +             pool->mp_priv =3D binding;
> >>> +     }
> >>
> >> This is specific to TCP devmem. For ZC Rx we will need something more
> >> generic to let us pass our own memory provider backend down to the pag=
e
> >> pool.
> >>
> >> What about storing ops and priv void ptr in struct netdev_rx_queue
> >> instead? Then we can both use it.
> >
> > Yes, this is dmabuf specific, I was thinking you'd define your own
> > member of netdev_rx_queue, and then add something like this to
> > page_pool_init:
>
> That would be quite annoying, there are 3 expected users together
> with huge pages, each would need a field and check all others are
> disabled as you mentioned and so on. It should be cleaner to pass
> a generic {pp_ops,pp_private} pair instead.
>
> If header dependencies is a problem, you it can probably be
>
> struct pp_provider_param {
>         struct pp_ops ops;
>         void *private;
> };
>
> # netdev_rx_queue.h
>
> // definition is not included here
> struct pp_provider_params;
>
> struct netdev_rx_queue {
>         ...
>         struct pp_provider_params *pp_params;
> };
>

Seems very reasonable, will do! Thanks!

> --
> Pavel Begunkov



--=20
Thanks,
Mina

