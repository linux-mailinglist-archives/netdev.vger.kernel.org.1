Return-Path: <netdev+bounces-59823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9981C211
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944B72880BA
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53527995A;
	Thu, 21 Dec 2023 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UESf6E2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115B79485
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2343c31c4bso164660366b.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703202276; x=1703807076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYgALaqHaxsIKBoPdNM24Kf+9GYUu7tWwLOH1j6ljO4=;
        b=UESf6E2nuapnO/93cfBZC6naRm3boMYkXVPonh+ZnJUinJ+lDpZwSCVdeq6CLi3DhW
         IT1l2KyQMY+m+HME1TJeUiSrERaAZFvty05AmQ/QSTF9E62XAzG0y2iukD3u+TSoUZRS
         GLWvh2TPZBe4pIR1Os5U14sJlpo/2t/QI4YJlXQFQ7gf63HJb6JwwJdOyB92yB81PrI7
         I5rhWj/6fKhsL9cTj5CBZd5nFSXAhjsbadmxDMHVvzczXnQZisn3E68Nr5tLddpvg0IR
         z0qWGIjF2Yxkmoi1oyz+8D+nyihH2gz/ANd/ui49xAn6FelycX3wD4RXuZrAi7KnGjeR
         m0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703202276; x=1703807076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYgALaqHaxsIKBoPdNM24Kf+9GYUu7tWwLOH1j6ljO4=;
        b=VO0nRtGLeOak0BN5P0NzTYNukTo8EygUez0cV56Bbd7U9oFoIF2NBqFiaa+vZoVWXd
         NDeY8CD//5grCQkAfW2Rg6MALuowJl3ZrNqa6Ic6rhWUBfJ4FytCKHeGakgqw8Xqt89z
         6Dgyx3X7MqvOkPjMEgdhjp3xuHKX6czkzg6J2CUFc/zUEKOn4IHXzo3yMnU3bujrHL0e
         /674DZK8Suyd5JajVlkXm6XMnvo7curEzSP5yHZCNPzjppu4KTuhtyClsLqvBsnTLOSh
         QFrJQWmDks/s/prsKegv+pgDl2fOCXyfH/i0mOv0lJbNgslaEESji8qhDs6pqb8g2SCf
         D8tw==
X-Gm-Message-State: AOJu0Yx1vBQgJkghPHekdIb2ee5NB7RoZbp9eZQoZuOIYT3yJMyrsZLe
	dfBz3ht/5hNASVhmiGIbD9VPCn2jL98kQXeCXFdqBltq2lFV
X-Google-Smtp-Source: AGHT+IF4YnX0GSegTZt10iFN/e+vBJQA9vJmhfDn27MRVIde4Hmgf0/aWtBQ1RkOZ0Yu0ijPN37izKe8CoGFD+mtOmI=
X-Received: by 2002:a17:906:81d6:b0:a23:526e:4425 with SMTP id
 e22-20020a17090681d600b00a23526e4425mr215040ejx.66.1703202276017; Thu, 21 Dec
 2023 15:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com>
 <20231220214505.2303297-3-almasrymina@google.com> <20231221232343.qogdsoavt7z45dfc@google.com>
In-Reply-To: <20231221232343.qogdsoavt7z45dfc@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 21 Dec 2023 15:44:22 -0800
Message-ID: <CAHS8izOp_m9SyPjNth-iYBXH2qQQpc9PuZaHbpUL=H0W=CVHgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: introduce abstraction for network memory
To: Shakeel Butt <shakeelb@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 3:23=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Dec 20, 2023 at 01:45:01PM -0800, Mina Almasry wrote:
> > Add the netmem_ref type, an abstraction for network memory.
> >
> > To add support for new memory types to the net stack, we must first
> > abstract the current memory type. Currently parts of the net stack
> > use struct page directly:
> >
> > - page_pool
> > - drivers
> > - skb_frag_t
> >
> > Originally the plan was to reuse struct page* for the new memory types,
> > and to set the LSB on the page* to indicate it's not really a page.
> > However, for compiler type checking we need to introduce a new type.
> >
> > netmem_ref is introduced to abstract the underlying memory type. Curren=
tly
> > it's a no-op abstraction that is always a struct page underneath. In
> > parallel there is an undergoing effort to add support for devmem to the
> > net stack:
> >
> > https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@goo=
gle.com/
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v3:
> >
> > - Modify struct netmem from a union of struct page + new types to an op=
aque
> >   netmem_ref type.  I went with:
> >
> >   +typedef void *__bitwise netmem_ref;
> >
> >   rather than this that Jakub recommended:
> >
> >   +typedef unsigned long __bitwise netmem_ref;
> >
> >   Because with the latter the compiler issues warnings to cast NULL to
> >   netmem_ref. I hope that's ok.
> >
>
> Can you share what the warning was? You might just need __force
> attribute. However you might need this __force a lot. I wonder if you
> can just follow struct encoded_page example verbatim here.
>

The warning is like so:

./include/net/page_pool/helpers.h: In function =E2=80=98page_pool_alloc=E2=
=80=99:
./include/linux/stddef.h:8:14: warning: returning =E2=80=98void *=E2=80=99 =
from a
function with return type =E2=80=98netmem_ref=E2=80=99 {aka =E2=80=98long u=
nsigned int=E2=80=99} makes
integer from pointer without a cast [-Wint-conversion]
    8 | #define NULL ((void *)0)
      |              ^
./include/net/page_pool/helpers.h:132:24: note: in expansion of macro
=E2=80=98NULL=E2=80=99
  132 |                 return NULL;
      |                        ^~~~

And happens in all the code where:

netmem_ref func()
{
    return NULL;
}

It's fixable by changing the return to `return (netmem_ref NULL);` or
`return 0;`, but I feel like netmem_ref should be some type which
allows a cast from NULL implicitly.

Also as you (and patchwork) noticed, __bitwise should not be used with
void*; it's only meant for integer types. Sorry I missed that in the
docs and was not running make C=3D2.

--=20
Thanks,
Mina

