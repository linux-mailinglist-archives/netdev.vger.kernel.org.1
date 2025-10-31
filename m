Return-Path: <netdev+bounces-234789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCDC273C8
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0BD94E357E
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165342EC568;
	Sat,  1 Nov 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HubYdLtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9032AAA2
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955216; cv=none; b=QG14FLttoc/CxoCZdW3L0wM9EqtMSPNOOcoHzPL68Iq+c8Q9sSzOJ8ndDp5qoALnp2BoFt4TMBQ3IxcM+fqLbBVPE3D1N32CMan6ZMUHA7l7pGPCTjcJETKXquQT2O3qQmZai01k4JoGxi+MFdunv42Gigi2p2GQQ4slqwtbSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955216; c=relaxed/simple;
	bh=+35/7pDV5aHtbLm+WJ3oucpJf+JGDSplZl6Cxp0IjVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J924FNyGTEmdP/fqLBEVXwR4qDyo4KnsuLORrzWQ+oxuKaGqGzBfFEz3B9t+y+qWbpO2Qt7Uidh10zwIStJUpnis7te+PSV9ahSwKdizeQal4Rhe+P13sdLg+DcMjAnsiD1QOGCw7E7c76O1+zxMVIiToHzJf7fkIIsl5gQ7PMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HubYdLtm; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-9482931b14bso90441839f.1
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761955212; x=1762560012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MJ5WHi4v1NRsIzLB+zxCWG9/nSKi6YI0V6ws2xqZ6E=;
        b=HubYdLtm4AQn7kip/qrGPnYPdSPuRFIFBOhci/qIStoP9oJXqKKkXKJjFG9fSvw5V0
         Vx8HkiS4FivEeLJoMEtxPG6VXQcSb62oLD5MQgRoNI+O1onG0jBpgGNejxpKUMjSmMWL
         7MKaZ7wBoEFWAK6hNgERMztiY4iFRp6SbUNs1YVl6k/nM8YczMgWap3QVLjKkh/aNZ8o
         YLF0FBKej0KvkHAvncUwpgWAN4S7+l4oMIPyZhvCZh3l3LC5gKzoHlWf7HwY9s5fu3Sa
         jiCpX9laN/IpRuoSdRjtZ6cARUuZCb5x0/7Whq7ICRz1YSUqNnBqdeWKTSBM3vmOTqKn
         gpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761955212; x=1762560012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MJ5WHi4v1NRsIzLB+zxCWG9/nSKi6YI0V6ws2xqZ6E=;
        b=DAZUW43Suaxmk0PQrmYb2u9tMJjn9dYnbf+voxyeOPCpVO0QyjjX91kVVCaf5xiPli
         CI1NZSvSgbvNB3zEKp7wolAs9NwOUuNScEEfE4mGA6GYTip1V5vZ5YVv4nhlsgKhsj67
         iPPZRmuJY2ZoWxTsG9kLFRisnfRWcb2STbf8hRAfHVB7UKrUlFlPhnUz3ebZE5ojgN4Q
         AUis5AOuMMM/PXklG8K6bgkutsxaiCLvkWCpL3EafW0Py1LIm0glaZCXsa+Hh/wr4YdN
         OuI4P++tLzHOdjBN+U6wYLpyA47Xtn4Hh2blLpCmagN64K/bLFZ1PHVk6+SdjKlutzXC
         Rvjw==
X-Forwarded-Encrypted: i=1; AJvYcCXhokaxY37EMe2foU9397JSbb18VFeEwMlMAgjqcodOOd6RHDpVV1xF0bLt09TBBae0eXmxMMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ZyxrBOb1+BDUGxYr6S4JTkzFsKf2gJgLDSEyWF6rPKiWo+fG
	7U4gX0jwmeJgaQT7F6C5f/LjLP7qzIbH2zoxKoA5w5yGSGNfEViEzdkZ39lozrGUBeTnZXH1yDX
	gOtK33h98cr5++OEyg+2NIvgUPu/Z4xk=
X-Gm-Gg: ASbGnctDjsRSSSeuHKBhw+B0vtZq/sn2aqeNzwGE2RdKA6cqReEJCz5ngj+ybV4Pb9c
	fO/RexXErnhDBdloOO9kx7sHxvsXGL1/LHpAnAcdnO0+LGgByUBvPx8CzLyKH/g4e8jehkrSg2k
	FqqTTdqplPr9VQIKok5ONfvy8O12+IMg8kQVeQWnamz2W1BUyots/paQ5Al3g2KqQ7+7ogVwS7T
	mb5zFqClMTZgK9mPbZxR+GuxyLYA5pliKZooty64RtEiET/4y/6FfUOkUyxTFveMDMgx9CTVr0=
X-Google-Smtp-Source: AGHT+IEVdQ5RhyNFNAvyojjJ1ti+zJbNcVc4GOdb7no78U2rfmD6BQ3bRpKhH9UT07fZsJo9s2ImChJIKUeTJGRlZUQ=
X-Received: by 2002:a05:6e02:318f:b0:430:b999:49e7 with SMTP id
 e9e14a558f8ab-4330d1df5femr94395585ab.27.1761955212448; Fri, 31 Oct 2025
 17:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031093230.82386-1-kerneljasonxing@gmail.com>
 <20251031093230.82386-3-kerneljasonxing@gmail.com> <aQTBajODN3Nnskta@boxer>
In-Reply-To: <aQTBajODN3Nnskta@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 1 Nov 2025 07:59:36 +0800
X-Gm-Features: AWmQ_bm-C1tVR72l0QC9N9w_Vlw7AltvmNhED9xPVwSrZnJ7IiRp8OGbkDKrcjw
Message-ID: <CAL+tcoDGiYogC=xiD7=K6HBk7UaOWKCFX8jGC=civLDjsBb3fA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/2] xsk: introduce a cached cq to
 temporarily store descriptor addrs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, fmancera@suse.de, csmate@nop.hu, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:02=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Oct 31, 2025 at 05:32:30PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Before the commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > production"), there is one issue[1] which causes the wrong publish
> > of descriptors in race condidtion. The above commit fixes the issue
> > but adds more memory operations in the xmit hot path and interrupt
> > context, which can cause side effect in performance.
> >
> > This patch tries to propose a new solution to fix the problem
> > without manipulating the allocation and deallocation of memory. One
> > of the key points is that I borrowed the idea from the above commit
> > that postpones updating the ring->descs in xsk_destruct_skb()
> > instead of in __xsk_generic_xmit().
> >
> > The core logics are as show below:
> > 1. allocate a new local queue. Only its cached_prod member is used.
> > 2. write the descriptors into the local queue in the xmit path. And
> >    record the cached_prod as @start_addr that reflects the
> >    start position of this queue so that later the skb can easily
> >    find where its addrs are written in the destruction phase.
> > 3. initialize the upper 24 bits of destructor_arg to store @start_addr
> >    in xsk_skb_init_misc().
> > 4. Initialize the lower 8 bits of destructor_arg to store how many
> >    descriptors the skb owns in xsk_update_num_desc().
> > 5. write the desc addr(s) from the @start_addr from the cached cq
> >    one by one into the real cq in xsk_destruct_skb(). In turn sync
> >    the global state of the cq.
> >
> > The format of destructor_arg is designed as:
> >  ------------------------ --------
> > |       start_addr       |  num   |
> >  ------------------------ --------
> > Using upper 24 bits is enough to keep the temporary descriptors. And
> > it's also enough to use lower 8 bits to show the number of descriptors
> > that one skb owns.
> >
> > [1]: https://lore.kernel.org/all/20250530095957.43248-1-e.kubanski@part=
ner.samsung.com/
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > I posted the series as an RFC because I'd like to hear more opinions on
> > the current rought approach so that the fix[2] can be avoided and
> > mitigate the impact of performance. This patch might have bugs because
> > I decided to spend more time on it after we come to an agreement. Pleas=
e
> > review the overall concepts. Thanks!
> >
> > Maciej, could you share with me the way you tested jumbo frame? I used
> > ./xdpsock -i enp2s0f1 -t -q 1 -S -s 9728 but the xdpsock utilizes the
> > nic more than 90%, which means I cannot see the performance impact.

Could you provide the command you used? Thanks :)

> >
> > [2]:https://lore.kernel.org/all/20251030140355.4059-1-fmancera@suse.de/
> > ---
> >  include/net/xdp_sock.h      |   1 +
> >  include/net/xsk_buff_pool.h |   1 +
> >  net/xdp/xsk.c               | 104 ++++++++++++++++++++++++++++--------
> >  net/xdp/xsk_buff_pool.c     |   1 +
> >  4 files changed, 84 insertions(+), 23 deletions(-)
>
> (...)
>
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index aa9788f20d0d..6e170107dec7 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -99,6 +99,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struc=
t xdp_sock *xs,
> >
> >       pool->fq =3D xs->fq_tmp;
> >       pool->cq =3D xs->cq_tmp;
> > +     pool->cached_cq =3D xs->cached_cq;
>
> Jason,
>
> pool can be shared between multiple sockets that bind to same <netdev,qid=
>
> tuple. I believe here you're opening up for the very same issue Eryk
> initially reported.

Actually it shouldn't happen because the cached_cq is more of the
temporary array that helps the skb store its start position. The
cached_prod of cached_cq can only be increased, not decreased. In the
skb destruction phase, only those skbs that go to the end of life need
to sync its desc from cached_cq to cq. For some skbs that are released
before the tx completion, we don't need to clear its record in
cached_cq at all and cq remains untouched.

To put it in a simple way, the patch you proposed uses kmem_cached*
helpers to store the addr and write the addr into cq at the end of
lifecycle while the current patch uses a pre-allocated memory to
store. So it avoids the allocation and deallocation.

Unless I'm missing something important. If so, I'm still convinced
this temporary queue can solve the problem since essentially it's a
better substitute for kmem cache to retain high performance.

Thanks,
Jason

