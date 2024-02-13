Return-Path: <netdev+bounces-71515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4ED853BC6
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 21:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2901F249C2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A0960898;
	Tue, 13 Feb 2024 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPBQthgA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143F608F1
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854517; cv=none; b=D1R8/GVgWByxxSuiIFwa3DoCp+DJGT+1rUIaPQ3Y9TgoCGgZafKesyUjn4xf4HfUIRX67O8zwfCvma6S+RVNHhkhHjKtk1ZUD389CVRfX3p46IPmLNv3KxpjA7BnPq8+m0dNGVMl4fIMb8vccjmJ2Vo4Hd93XEEeWb2revKDalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854517; c=relaxed/simple;
	bh=V8RWr3buxdjWtLSDsasgQvCqzQOEr/31YvPitYMfD9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2MFXETX5xNUt2shnP0/niMvwtN/kDNS/KeuxmzWs8cygIEZTB4OHXOYT3ekczMmDWh1RD2Y+fqnrTFWdO3mrLXRyRz5YWFXSstQ1SQ8dWGOsx/YRdsOk6ScNOZBZegZb5Zxf9lwqRmox51XDDljksZGfueK55V18zuvMgded1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPBQthgA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3ce9a33fd8so15496366b.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707854514; x=1708459314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeZw1WsdK0ILhztiGUDCvc9s83gleGWTx/2AVhzfBto=;
        b=WPBQthgAOycku3bjtIr8wr5K9WkkXBqS3RMi2CMmfA/JK/iM2xslGlJ4FgFCrPGknW
         s27Am8uuZudDluiIg6pUGym9f6z+KCTCa90ZgJqusRWjdacMKwKCCDriV5/Fr/Gfa/RR
         p9Fsloiz3r2Zw4HDKdd29w4gxRuQk7zF+e710D4u+llV4yzIH4yZGpbzEOtJWpfpPBea
         DsbZ6TVLmfih1YwjJK3K4v6b25pYn4z/2V5kJy1aaVF7eS2oJ4r37KDW1qIFGZylZbnI
         A5HuiMxjEE/K39JjADBKHxu4AjRzKlKvGyKprrOtNYpyQxazACYo/Z3aSBckFB02Muna
         K24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707854514; x=1708459314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeZw1WsdK0ILhztiGUDCvc9s83gleGWTx/2AVhzfBto=;
        b=RHnAARIbPGEMdt0z7vPfHWGcXjp1LTmJKnd1KVy+NVkdSrBV0B9eJ74R7wACdQpg/r
         y+svexY/w9wwrsazVeASZYnuG+q1F/v8K+DUi+tfCPHjWKORM6Ga+3qpIxhQ2TIw+qa0
         Smf5DoeSGAgLfFPiodM9QMoKtcZz8Nru/RMx52ObPU7d1I/e53JJQT6htY/HNq6m0Wra
         9P7DB8tukNx3UEdrbBH4V5mVN7PF31XBmCd0fhBuBcoRFLwGmSbHRmgfKr1NnhRo2i1R
         W6mfzJRU8pZzPPZIN3wo6JTMMDEziRve31muenDa374geYCAaPC/aslFmex+76Jv5594
         JBjA==
X-Forwarded-Encrypted: i=1; AJvYcCWhBlFWIJuNjW1hBPqd2YquwAVXbzPl6Lw8KLwJW0bmV80sM7Hd+xV2+EBmsNvtWHhr1C/Ylf53TZV+TRi4GbjjuU912SVl
X-Gm-Message-State: AOJu0YxQ4ZmLWjNe0FcjE0KCiH+q3c38NpyskoNudS2IZ52QOK8hd/j+
	FZruqdbkYSDljdXWumNWHpqX5U4wl4WsRt+rasgbo8Xor31SElz+XfgaXQy1r0SwusFi5p5OVKp
	O0dScTuSOUOcVweov62QmZlhGh1ARcGoxsK0m
X-Google-Smtp-Source: AGHT+IEoAl64de8zNKAQZ6ETW1N1MxR2kab9dSI7Hv2FnuBLL+jAe6glKg5e1u5UvR1ALTVOEk3lvhQA2UzDwTmO1zE=
X-Received: by 2002:a17:906:6555:b0:a3c:e99f:be1d with SMTP id
 u21-20020a170906655500b00a3ce99fbe1dmr3141450ejn.18.1707854513537; Tue, 13
 Feb 2024 12:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218024024.3516870-1-almasrymina@google.com>
 <20231218024024.3516870-6-almasrymina@google.com> <94ff0733-5987-4bf5-a53c-011e03aa6323@gmail.com>
In-Reply-To: <94ff0733-5987-4bf5-a53c-011e03aa6323@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Feb 2024 12:01:38 -0800
Message-ID: <CAHS8izOJMEtC1a26yJGMzV9jsX9TtE2xWXzWQ6qSi4ynXnr2Wg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 05/14] netdev: netdevice devmem allocator
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:24=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 12/18/23 02:40, Mina Almasry wrote:
> > Implement netdev devmem allocator. The allocator takes a given struct
> > netdev_dmabuf_binding as input and allocates net_iov from that
> > binding.
> >
> > The allocation simply delegates to the binding's genpool for the
> > allocation logic and wraps the returned memory region in a net_iov
> > struct.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v1:
> > - Rename devmem -> dmabuf (David).
> >
> > ---
> >   include/net/devmem.h | 12 ++++++++++++
> >   include/net/netmem.h | 26 ++++++++++++++++++++++++++
> >   net/core/dev.c       | 38 ++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 76 insertions(+)
> >
> ...
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 45eb42d9990b..7fce2efc8707 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -14,8 +14,34 @@
> >
> >   struct net_iov {
> >       struct dmabuf_genpool_chunk_owner *owner;
> > +     unsigned long dma_addr;
> >   };
> >
> > +static inline struct dmabuf_genpool_chunk_owner *
> > +net_iov_owner(const struct net_iov *niov)
> > +{
> > +     return niov->owner;
> > +}
> > +
> > +static inline unsigned int net_iov_idx(const struct net_iov *niov)
> > +{
> > +     return niov - net_iov_owner(niov)->niovs;
> > +}
> > +
> > +static inline dma_addr_t net_iov_dma_addr(const struct net_iov *niov)
> > +{
> > +     struct dmabuf_genpool_chunk_owner *owner =3D net_iov_owner(niov);
> > +
> > +     return owner->base_dma_addr +
> > +            ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
>
> Looks like it should have been niov->dma_addr
>

Yes, indeed. Thanks for catching.

> > +}
> > +
> > +static inline struct netdev_dmabuf_binding *
> > +net_iov_binding(const struct net_iov *niov)
> > +{
> > +     return net_iov_owner(niov)->binding;
> > +}
> > +
> >   /* netmem */
> >
> >   struct netmem {
> ...
>
> --
> Pavel Begunkov



--=20
Thanks,
Mina

