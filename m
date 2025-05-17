Return-Path: <netdev+bounces-191278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F27ABA85B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 06:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7764D4C1FB5
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388519047F;
	Sat, 17 May 2025 04:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yD9t+QoT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722F27470
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747457633; cv=none; b=cyblLlUv576JOC+ydVyPsbFdpbC1zu1Q6OcLuLTXD00LOfVDqySgIeINtoqNqxpQ9mC+RaFAScdgJmtZMpzo8uhgO3fjWxojmJCXHyZCJL/O46Nsi2JDtsnUH6cs+rQ9r32XfOpyQ/nGVtsZlWOF/LDpMX1+xZceSB1UVMB8eCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747457633; c=relaxed/simple;
	bh=TqxPAsF2O5vZE3IPQhz9oqrLOFCwYO+zgm01pOCcPZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3GnyoQ0Dd3fSkLNG1PKxKRUXqo1II5w8IRaTdqyPrBSZlQ5QzGiBvNHpEdSJVgIoCAu/SwKLPD9vtzIE3m2szUAdShhmdud6rj3HcI0t/MReZGp+hbFyF/44xDeIizNQ6mrqPdZQd+g742KKun2z91oTy2LaG/DUwqlPSA3eYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yD9t+QoT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f61dc510so105855ad.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747457631; x=1748062431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLBC6DFCaMhDcBjh0CxDR7grbX7q8ka+MLLSJpzu+cc=;
        b=yD9t+QoTpJPnWbRpYxQU/z8ATFFJJvAP+XT7gnRRFlz7G+QYke0SbDuIjoSLtYbP96
         vFnewNw/+2fJOAyyBfNQMtPGLnPUWv8tN+lK6CM/Dl5obvNgMH3lMgCcTo5ztLcjzlmN
         ieeAQFdGbdWYCBA0iNHKfWyeVFTPwB2GvLVa41mLWP8HZOt0Icwz2f1KfO/u9+CM+fae
         T8Hc7y8z31VlXdP9Z4FQnP3AaRBXP9NObs6E5ePodgbi35vwiKSTQ+Mebjy5sy6IQW8P
         +FMR4+KHZzsW7t9miHGIvJdLVRIqq088mRUWbQEKq1EoUIu/5N1xUStdnO1DyWUnBkDl
         i6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747457631; x=1748062431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLBC6DFCaMhDcBjh0CxDR7grbX7q8ka+MLLSJpzu+cc=;
        b=QqNum8q3pGiSl/9tkA+HfOkuVjFdy1s+UIRC23J+6/WjZUrwSs83n8rY0QjwUR8g3y
         0W2RKbjuCshvuRsgUAcxjkrXGG8WCe3lC6cEFYQhKop0E/ygCH5stXcVQUuRt1ks0kMc
         1NghtBamN/JkAUhsm5VsbaE+vZeSE1flbIhGnRR6hoNiN5N9MWAK+PtepdgOt3c5M291
         GHniSD+evkZ0HlGTMkAKrb77j2O/fqrLhrXn7oARMXD3b179PuH/yN8xbHFlstv+Rujl
         +wNDg6+9CjZbbxLKF7Uhd/vcCcFiFvOy1zY/sQ7oqdk6uBUYQgtSKW7R28qs5WEoyuns
         XaAA==
X-Forwarded-Encrypted: i=1; AJvYcCVs9YILBQQ6u5JRTz8FhN/I1t2UzgDFhobLdeURmwwMxkkLmJC5hXmLzA12TiU6dQmZD4Qk6y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaf961kSjtqihrmu9uDFeKDpXgXB3oq3R/+6H35mQ9kU3RvrE7
	MpCpvl0vwVSAVzhR05cUyk7HM0QeqMQZBt3G7kSbQgM8NqsDsnh1f8pySsvgVpAewJyUhXZ9W9n
	/X1H73xB8izfegkJsL5713orw6lZiwkB0GLRGUh3Q
X-Gm-Gg: ASbGnctnUABHJUUAMbCmjChx6wWzOEEKnKWm4RqvfM0xr2swBnCZjgdR3Z5omvDqpWM
	LjfUdxEc6OQydfB7ujig3G9yDCSSW1OPrIzJEVnQ8rUMu4QC9Z5uJ+PUmbhi9oITxhJVZP4f+45
	0uqaTx12JTy29MD3OR4E/CBw5SkRLtbE8aig==
X-Google-Smtp-Source: AGHT+IEYQ75QOTBuWiuY/usXyl//AMAMWzV5ec/pBn5TK10hdDFrZ/2ZaQ1s7InlcVl53yl2kaY8inbWXVyHN+jTlDE=
X-Received: by 2002:a17:902:cecd:b0:231:d7cf:cf18 with SMTP id
 d9443c01a7336-23203eee503mr898975ad.1.1747457630360; Fri, 16 May 2025
 21:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517000431.558180-1-stfomichev@gmail.com> <20250517000907.GW2023217@ZenIV>
 <aCflM0LZ23d2j2FF@mini-arch> <20250517020653.GX2023217@ZenIV>
 <aCfxs5CiHYMJPOsy@mini-arch> <20250517033951.GY2023217@ZenIV>
 <aCgIJSgv-yQzaHLl@mini-arch> <20250517040530.GZ2023217@ZenIV> <aCgQwfyQqkD2AUSs@mini-arch>
In-Reply-To: <aCgQwfyQqkD2AUSs@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 16 May 2025 21:53:36 -0700
X-Gm-Features: AX0GCFv05ogkNccah3Tcx0t_520Ll67PUCfBoUsGgefZcK03_LvVsfsR3n0m3B8
Message-ID: <CAHS8izOSZS8F7vbNVS4VeyxdNBbjcaC47_GXYKTe-0t6qorcTQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in sendmsg
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com, 
	kaiyuanz@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 9:29=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 05/17, Al Viro wrote:
> > On Fri, May 16, 2025 at 08:53:09PM -0700, Stanislav Fomichev wrote:
> > > On 05/17, Al Viro wrote:
> > > > On Fri, May 16, 2025 at 07:17:23PM -0700, Stanislav Fomichev wrote:
> > > > > > Wait, in the same commit there's
> > > > > > +       if (iov_iter_type(from) !=3D ITER_IOVEC)
> > > > > > +               return -EFAULT;
> > > > > >
> > > > > > shortly prior to the loop iter_iov_{addr,len}() are used.  What=
 am I missing now?
> > > > >
> > > > > Yeah, I want to remove that part as well:
> > > > >
> > > > > https://lore.kernel.org/netdev/20250516225441.527020-1-stfomichev=
@gmail.com/T/#u
> > > > >
> > > > > Otherwise, sendmsg() with a single IOV is not accepted, which mak=
es not
> > > > > sense.
> > > >
> > > > Wait a minute.  What's there to prevent a call with two ranges far =
from each other?
> > >
> > > It is perfectly possible to have a call with two disjoint ranges,
> > > net_devmem_get_niov_at should correctly resolve it to the IOVA in the
> > > dmabuf. Not sure I understand why it's an issue, can you pls clarify?
> >
> > Er...  OK, the following is given an from with two iovecs.
> >
> >       while (length && iov_iter_count(from)) {
> >               if (i =3D=3D MAX_SKB_FRAGS)
> >                       return -EMSGSIZE;
> >
> >               virt_addr =3D (size_t)iter_iov_addr(from);
> >
> > OK, that's iov_base of the first one.
> >
> >               niov =3D net_devmem_get_niov_at(binding, virt_addr, &off,=
 &size);
> >               if (!niov)
> >                       return -EFAULT;
> > Whatever it does, it does *NOT* see iov_len of the first iovec.  Looks =
like
> > it tries to set something up, storing the length of what it had set up
> > into size
> >
> >               size =3D min_t(size_t, size, length);
> > ... no more than length, OK.  Suppose length is considerably more than =
iov_len
> > of the first iovec.
> >
> >               size =3D min_t(size_t, size, iter_iov_len(from));
> > ... now trim it down to iov_len of that sucker.  That's what you want t=
o remove,
> > right?  What happens if iov_len is shorter than what we have in size?
> >
> >               get_netmem(net_iov_to_netmem(niov));
> >               skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), o=
ff,
> >                                     size, PAGE_SIZE);
> > Still not looking at that iov_len...
> >
> >               iov_iter_advance(from, size);
> > ... and now that you've removed the second min_t, size happens to be gr=
eater
> > than that iovec[0].iov_len.  So we advance into the second iovec, skipp=
ing
> > size - iovec[0].iov_len bytes after iovev[1].iov_base.
> >               length -=3D size;
> >               i++;
> >       }
> > ... and proceed into the second iteration.
> >
> > Would you agree that behaviour ought to depend upon the iovec[0].iov_le=
n?
> > If nothing else, it affects which data do you want to be sent, and I do=
n't
> > see where would anything even look at that value with your change...
>
> Yes, I think you have a point. I was thinking that net_devmem_get_niov_at
> will expose max size of the chunk, but I agree that the iov might have
> requested smaller part and it will bug out in case of multiple chunks...
>
> Are you open to making iter_iov_len more ubuf friendly? Something like
> the following:
>
> static inline size_t iter_iov_len(const struct iov_iter *i)
> {
>         if (iter->iter_type =3D=3D ITER_UBUF)
>                 return ni->count;
>         return iter_iov(i)->iov_len - i->iov_offset;
> }
>
> Or should I handle the iter_type here?
>
> if (iter->iter_type =3D=3D ITER_IOVEC)
>         size =3D min_t(size_t, size, iter_iov_len(from));
> /* else
>         I don think I need to clamp to iov_iter_count() because length
>         should take care of it */

Sorry about this, I was worried about testing multiple io_vecs because
I imagined the single io_vec is just a subcase of that. I did not
expect a single iov converts into a different iter type and the iter
type behaves a bit differently.

I think both approaches Stan points to should be fine. The generic
change may break existing users of ITER_UBUF though.

Lets have some test coverage of this in ncdevmem, if possible.

--=20
Thanks,
Mina

