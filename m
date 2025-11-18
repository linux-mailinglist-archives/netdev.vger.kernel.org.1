Return-Path: <netdev+bounces-239522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE0C692C0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 528C0383DD2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C530FC1C;
	Tue, 18 Nov 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7FS7X9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECF3009DD
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763466092; cv=none; b=J24QHmRkxogDjSj2wtzLy8sx28bcm7YcdF2EIgQtPj7V38PnL0Rr06kalai4/tYvxEyyVyoiMsLzjmG83moslGipjbJz+hVfIEuGhSUNZ4nFhNXHm0aZDR5GRy/wZ6kN8KWu6hQNP6yY+rASTEU6KJkMxcVsPNfEZZxJqqJbA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763466092; c=relaxed/simple;
	bh=GCasney/+v/3JF7ZuKtH0cYYKb5MzrRqbecjXZrV8Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAhjoWQpaq/KivcGC05zly1EuoeKxeiiUR/0ZfACRhBOoBpaJOJ91+Bx+skckmgumex3n/84m5yqkE6/W89XKv8uFCR0ey7578cQbmDq1lTESGRR4ic8ZqxrzNiA7h26GcOG/M8rm5XiTVkx42NdJBQKWJdKcS2maPbhVrZ6yoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7FS7X9x; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4331b4d5c6eso21565685ab.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763466089; x=1764070889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0rdrQ0bR9gp8rN3RGfKes678Yrgs/gwNY/GEhcsxfg=;
        b=O7FS7X9xS+ZOT8cWKJQRfVCA2OtXUmhvrSqaxHJDK4Jst0hBOFhCRse8sFOYQ544gp
         RgnJs46bwL19daEe/5Fhmzm55/E3KH7QLF5sRwwRSYv6oVDXZsJqCaVBUMFXPnb7SZLW
         UXAj/DEx/zFjH/p/vSYZ8QVfKC+h1uTjzhzDPlkA18OwOx5s10JzJPgq8j4TK1xA7DaA
         phLiV5mk4ZbW9vc8w4kYA6a/fskNoDEKMzEeQ3PcXxLrN3/fZFfkKHbL2V38hTobPRpU
         Ye8z0GwMPj5cNSiGrZ3iSnXDkDbLGiufXmAlt2o7pCk4mOcifoqn8ZOWtGt+obPruH1Q
         vFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763466089; x=1764070889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e0rdrQ0bR9gp8rN3RGfKes678Yrgs/gwNY/GEhcsxfg=;
        b=uu4WbhIcDsTY8wrOcl4DoDTtegvtXVX9uh8FI42UWkgiPAXigV9+BfADW0ZHj0ghus
         VnvTNk2yTyTM4JozJIJRhSNiuMGWr9YzB/I45gA3CThmvy5kcR4v8ZswF5n44YMtxyVx
         NOm/VGEBKFF49K4F0074tO9c6VSttkSfeVpkk0ZRGlhBSqUqlPXwuwSuxU3spl5uoazP
         fQkxAwsi0LDoMVmW0yFLjOTCaZgLoYm4yUVApPgs2dcMQewDROIazkU2/gQ4TqhPEeEE
         nbUYuF006e19tdtWgaUtQpXV3tp2TTTkQzpQiiXTLzatRO23QIDEWS7zEGw77sr0xbRE
         4LIw==
X-Forwarded-Encrypted: i=1; AJvYcCVgACZyTQuF399wWDlnG3nIIJ7tfSG87/ousQIP+PZxUFNhI3WHd7oqkBEr9ohEay0d0Gse3XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4byVOWcE1xLHkHdC9WFBpgoUr9xMKDCANoGUyxv+qJXhTYfO
	6uI0a7xZP97eGyTFmoWDpSC+5KfQ8aPuEDgCB4B8B7PmWJHtnhAYVYiOHCENAD2iey6O3q8aHln
	Y1D3giCTDtW3MrmSOsciNYhOLJgzqNms=
X-Gm-Gg: ASbGnctxNWr35Mr6QEsytawe4x5qgoov8JX4Rv5hNzKDUeN4oi9oTpbgz20rADcUhmg
	XHrUogZS1mKE0klg8o3RZDHfcNfpLtovW3qDzHzcYBr1wyjupf55fjrIx8s4S3DsGNHEt2/I0fl
	ZvrQ9wOdIgjMXDpxWNfCszmYx9Za+mha+CjJjwafeJc1mseqXahw5PPXkonWwLLZn2cvDchxYmj
	qBawbbY5REZfxFWOMMSXkiZLBnC8P+PmQNVex3I79CkwY1IBdQUfqAN7sQ/
X-Google-Smtp-Source: AGHT+IFNMcTLPQ3/iVJQDUWjnyBtLiy0PPA/isYlypVTbpMoaXEFPmjqZSHowotKXExsMIWOGX+vb5BSyfcL+4GeF4I=
X-Received: by 2002:a05:6e02:3f0b:b0:434:70bd:8b36 with SMTP id
 e9e14a558f8ab-4348c896102mr192757725ab.7.1763466088557; Tue, 18 Nov 2025
 03:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQTBajODN3Nnskta@boxer> <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
 <aQjDjaQzv+Y4U6NL@boxer> <CAL+tcoBkO98eBGX0uOUo_bvsPFbnGvSYvY-ZaKJhSn7qac464g@mail.gmail.com>
 <CAJ8uoz2ZaJ5uYhd-MvSuYwmWUKKKBSfkq17rJGO98iTJ+iUrQg@mail.gmail.com>
 <CAL+tcoBw4eS8QO+AxSk=-vfVSb-7VtZMMNfZTZtJCp=SMpy0GQ@mail.gmail.com>
 <aRdQWqKs29U7moXq@boxer> <CAL+tcoAv+dTK-Z=HNGUJNohxRu_oWCPQ4L1BRQT9nvB4WZMd7Q@mail.gmail.com>
 <aRtHvooD0IWWb4Cx@boxer> <CAL+tcoBTuOnnhAUD9gwbt8VBf+m=c08c-+cOUyjuPLyx29xUWw@mail.gmail.com>
 <aRxHDvUBcr+jx49C@boxer>
In-Reply-To: <aRxHDvUBcr+jx49C@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Nov 2025 19:40:52 +0800
X-Gm-Features: AWmQ_bn2TIX4xwq_x119sDR85ikZkRX9XDHY1Ly4Rm9ZYlCQ7P380Nqe5zxJ9gM
Message-ID: <CAL+tcoCPiDq807u4wmqNx+j_jMmYYzNVA5ySGmp_V5gDLYz02A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	fmancera@suse.de, csmate@nop.hu, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 6:15=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Nov 18, 2025 at 08:01:52AM +0800, Jason Xing wrote:
> > On Tue, Nov 18, 2025 at 12:05=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Sat, Nov 15, 2025 at 07:46:40AM +0800, Jason Xing wrote:
> > > > On Fri, Nov 14, 2025 at 11:53=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Tue, Nov 11, 2025 at 10:02:58PM +0800, Jason Xing wrote:
> > > > > > Hi Magnus,
> > > > > >
> > > > > > On Tue, Nov 11, 2025 at 9:44=E2=80=AFPM Magnus Karlsson
> > > > > > <magnus.karlsson@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, 11 Nov 2025 at 14:06, Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > > > > > > >
> > > > > > > > Hi Maciej,
> > > > > > > >
> > > > > > > > On Mon, Nov 3, 2025 at 11:00=E2=80=AFPM Maciej Fijalkowski
> > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Nov 01, 2025 at 07:59:36AM +0800, Jason Xing wrot=
e:
> > > > > > > > > > On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalko=
wski
> > > > > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing =
wrote:
> > > > > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > > >
> > > > > > > > > > > > Before the commit 30f241fcf52a ("xsk: Fix immature =
cq descriptor
> > > > > > > > > > > > production"), there is one issue[1] which causes th=
e wrong publish
> > > > > > > > > > > > of descriptors in race condidtion. The above commit=
 fixes the issue
> > > > > > > > > > > > but adds more memory operations in the xmit hot pat=
h and interrupt
> > > > > > > > > > > > context, which can cause side effect in performance=
.
> > > > > > > > > > > >
> > > > > > > > > > > > This patch tries to propose a new solution to fix t=
he problem
> > > > > > > > > > > > without manipulating the allocation and deallocatio=
n of memory. One
> > > > > > > > > > > > of the key points is that I borrowed the idea from =
the above commit
> > > > > > > > > > > > that postpones updating the ring->descs in xsk_dest=
ruct_skb()
> > > > > > > > > > > > instead of in __xsk_generic_xmit().
> > > > > > > > > > > >
> > > > > > > > > > > > The core logics are as show below:
> > > > > > > > > > > > 1. allocate a new local queue. Only its cached_prod=
 member is used.
> > > > > > > > > > > > 2. write the descriptors into the local queue in th=
e xmit path. And
> > > > > > > > > > > >    record the cached_prod as @start_addr that refle=
cts the
> > > > > > > > > > > >    start position of this queue so that later the s=
kb can easily
> > > > > > > > > > > >    find where its addrs are written in the destruct=
ion phase.
> > > > > > > > > > > > 3. initialize the upper 24 bits of destructor_arg t=
o store @start_addr
> > > > > > > > > > > >    in xsk_skb_init_misc().
> > > > > > > > > > > > 4. Initialize the lower 8 bits of destructor_arg to=
 store how many
> > > > > > > > > > > >    descriptors the skb owns in xsk_update_num_desc(=
).
> > > > > > > > > > > > 5. write the desc addr(s) from the @start_addr from=
 the cached cq
> > > > > > > > > > > >    one by one into the real cq in xsk_destruct_skb(=
). In turn sync
> > > > > > > > > > > >    the global state of the cq.
> > > > > > > > > > > >
> > > > > > > > > > > > The format of destructor_arg is designed as:
> > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > |       start_addr       |  num   |
> > > > > > > > > > > >  ------------------------ --------
> > > > > > > > > > > > Using upper 24 bits is enough to keep the temporary=
 descriptors. And
> > > > > > > > > > > > it's also enough to use lower 8 bits to show the nu=
mber of descriptors
> > > > > > > > > > > > that one skb owns.
> > > > > > > > > > > >
> > > > > > > > > > > > [1]: https://lore.kernel.org/all/20250530095957.432=
48-1-e.kubanski@partner.samsung.com/
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > I posted the series as an RFC because I'd like to h=
ear more opinions on
> > > > > > > > > > > > the current rought approach so that the fix[2] can =
be avoided and
> > > > > > > > > > > > mitigate the impact of performance. This patch migh=
t have bugs because
> > > > > > > > > > > > I decided to spend more time on it after we come to=
 an agreement. Please
> > > > > > > > > > > > review the overall concepts. Thanks!
> > > > > > > > > > > >
> > > > > > > > > > > > Maciej, could you share with me the way you tested =
jumbo frame? I used
> > > > > > > > > > > > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xd=
psock utilizes the
> > > > > > > > > > > > nic more than 90%, which means I cannot see the per=
formance impact.
> > > > > > > > > >
> > > > > > > > > > Could you provide the command you used? Thanks :)
> > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > [2]:https://lore.kernel.org/all/20251030140355.4059=
-1-fmancera@suse.de/
> > > > > > > > > > > > ---
> > > > > > > > > > > >  include/net/xdp_sock.h      |   1 +
> > > > > > > > > > > >  include/net/xsk_buff_pool.h |   1 +
> > > > > > > > > > > >  net/xdp/xsk.c               | 104 ++++++++++++++++=
++++++++++++--------
> > > > > > > > > > > >  net/xdp/xsk_buff_pool.c     |   1 +
> > > > > > > > > > > >  4 files changed, 84 insertions(+), 23 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > (...)
> > > > > > > > > > >
> > > > > > > > > > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_=
buff_pool.c
> > > > > > > > > > > > index aa9788f20d0d..6e170107dec7 100644
> > > > > > > > > > > > --- a/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > > > > > > > > > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_a=
nd_assign_umem(struct xdp_sock *xs,
> > > > > > > > > > > >
> > > > > > > > > > > >       pool->fq =3D xs->fq_tmp;
> > > > > > > > > > > >       pool->cq =3D xs->cq_tmp;
> > > > > > > > > > > > +     pool->cached_cq =3D xs->cached_cq;
> > > > > > > > > > >
> > > > > > > > > > > Jason,
> > > > > > > > > > >
> > > > > > > > > > > pool can be shared between multiple sockets that bind=
 to same <netdev,qid>
> > > > > > > > > > > tuple. I believe here you're opening up for the very =
same issue Eryk
> > > > > > > > > > > initially reported.
> > > > > > > > > >
> > > > > > > > > > Actually it shouldn't happen because the cached_cq is m=
ore of the
> > > > > > > > > > temporary array that helps the skb store its start posi=
tion. The
> > > > > > > > > > cached_prod of cached_cq can only be increased, not dec=
reased. In the
> > > > > > > > > > skb destruction phase, only those skbs that go to the e=
nd of life need
> > > > > > > > > > to sync its desc from cached_cq to cq. For some skbs th=
at are released
> > > > > > > > > > before the tx completion, we don't need to clear its re=
cord in
> > > > > > > > > > cached_cq at all and cq remains untouched.
> > > > > > > > > >
> > > > > > > > > > To put it in a simple way, the patch you proposed uses =
kmem_cached*
> > > > > > > > > > helpers to store the addr and write the addr into cq at=
 the end of
> > > > > > > > > > lifecycle while the current patch uses a pre-allocated =
memory to
> > > > > > > > > > store. So it avoids the allocation and deallocation.
> > > > > > > > > >
> > > > > > > > > > Unless I'm missing something important. If so, I'm stil=
l convinced
> > > > > > > > > > this temporary queue can solve the problem since essent=
ially it's a
> > > > > > > > > > better substitute for kmem cache to retain high perform=
ance.
> > > > >
> > > > > Back after health issues!
> > > >
> > > > Hi Maciej,
> > > >
> > > > Hope you're fully recovered:)
> > > >
> > > > >
> > > > > Jason, I am still not convinced about this solution.
> > > > >
> > > > > In shared pool setups, the temp cq will also be shared, which mea=
ns that
> > > > > two parallel processes can produce addresses onto temp cq and the=
refore
> > > > > expose address to a socket that it does not belong to. In order t=
o make
> > > > > this work you would have to know upfront the descriptor count of =
given
> > > > > frame and reserve this during processing the first descriptor.
> > > > >
> > > > > socket 0                        socket 1
> > > > > prod addr 0xAA
> > > > > prod addr 0xBB
> > > > >                                 prod addr 0xDD
> > > > > prod addr 0xCC
> > > > >                                 prod addr 0xEE
> > > > >
> > > > > socket 0 calls skb destructor with num desc =3D=3D 3, placing 0xD=
D onto cq
> > > > > which has not been sent yet, therefore potentially corrupting it.
> > > >
> > > > Thanks for spotting this case!
> > > >
> > > > Yes, it can happen, so let's turn into a per-xsk granularity? If ea=
ch
> > > > xsk has its own temp queue, then the problem would disappear and go=
od
> > > > news is that we don't need extra locks like pool->cq_lock to preven=
t
> > > > multiple parallel xsks accessing the temp queue.
> > >
> > > Sure, when you're confident this is working solution then you can pos=
t it.
> > > But from my POV we should go with Fernando's patch and then you can s=
end
> > > patches to bpf-next as improvements. There are people out there with
> > > broken xsk waiting for a fix.
> >
> > Fine, I will officially post it on the next branch. But I think at
> > that time, I have to revert both patches (your and Fernando's
> > patches)? Will his patch be applied to the stable branch only so that
> > I can make it on the next branch?
>
> Give it some time and let Fernando repost patch and then after applying
> all the backport machinery will kick in. I suppose after bpf->bpf-next
> merge you could step in and in the meantime I assume you've got plenty of
> stuff to work on. My point here is we already hesitated too much in this
> matter IMHO.

I have no intention to stop that patch from being merged :)

I meant his patch will be _only_ merged into the net/stable branch and
_not_ be merged into the next branch, right? If so, I can continue my
approach only targetting the next branch without worrying about his
patch which can cause conflicts.

Thanks,
Jason

