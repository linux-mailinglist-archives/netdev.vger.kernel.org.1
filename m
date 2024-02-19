Return-Path: <netdev+bounces-73004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C22A85A9CB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1730F1F2196E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28B446BD;
	Mon, 19 Feb 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9yRy1+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689792E834
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363242; cv=none; b=Ca1giNHAYrQc7+8a1hG10pNTwuS+UCu52jlC0wfenBzEVcFfSGw7WhHItIss40O4oxbVQaoBN+t8Om2CBATt0ZNv1fT1QCEouCqB6lkKzILju2sZXvx9TPX2mUIVSVob3gA+OUxfx0vG8kyQSBT1SiHEcMpRUQBW6/jBImntsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363242; c=relaxed/simple;
	bh=QLBo4XJIX2BmEePgICTaISiFISeV90L6B7CMGqaM3ZU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oCoo1lwDl8jp9OUs3292tfq4Q8Yuyn7V5RE/AHlZdawtklnWeTrDIq5l59q0qz80LQ2xtOOwwZKOZDy6o+RJfup0+/PSoMDNkCY+fBFfuBcIlja9cvSKU7SzrFfEUw8j/UHkwBDiQBH0LX72h6H934rGgRojp1O1FlfEE0OD1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9yRy1+N; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68ee2c0a237so29244806d6.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708363240; x=1708968040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWrIOSPpNuwGFE4/WFpwq1pDBGTaZt8p00gZ298ZBiI=;
        b=i9yRy1+NmhdXpDRTqqqTpwAzY9L2BooFHK5HbNcKw43D8eQaUeP6TS1sxvcRbCD+He
         ywhl7vEKoVGpiUGTLFSB62qZDaSJbifapikYnj6DEjx1VRwE+V85jyagXYljhUb/Rczw
         bUSsGMy1S/rb+vRB8FZnMbsRK14XNlQbaqW3TqXpSUGEX3ZWv/Lu1bGPjbE5OBZHx/cM
         St8ycknCn02n7fRUKmUTNEYGkz7CDbvsUavHCL+7yuRymGKpmLcE/kjihf0mFGmpcbE/
         cGlqjCqCiSkssibAK5rJYofuZYpndy0mOYi3mBbLyAO47+6GM5bCIQMB5lv3RfM8YeWn
         R6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363240; x=1708968040;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DWrIOSPpNuwGFE4/WFpwq1pDBGTaZt8p00gZ298ZBiI=;
        b=AOZNXqsktQFedE5mWJY0thtNukldzGSmXdm66FkJXHW2dj3lUNWZU4FVOxoolWmNad
         rxKvZUjOf4d2SMQlYd51cQ57h5ovvdDYodT6ljQFTTPloGd1Ns6S62FS6gGplpfkdLgq
         iCoxU9IZjc1L1k5n6fFmNuQMhEbyEJLa2Gc0F9QRIcVxDLUSdWawVOu0e6WJr90ZnKmm
         3fcVmotClMmeCt+s6bdYnJcW+yy4Yby/0xCYy4A0gT0vUoXY0kn4vUdeGrkFavJ+uj9l
         Ii+AMh3/x2u3rLtbMr4lUwiAmF7BbekVqP3SNCm5oYZ/2xlZm30+XvQLK8sxAHJvP9O3
         YKvw==
X-Forwarded-Encrypted: i=1; AJvYcCVS4uHH3SfTvqO45NfzF6mZkOj+u/1NFUYIEzLTrMu71ja3wEDywMvrdEwvcytRaV1xF27Ee+sGMt1FwRnIl24iPdtfzr3r
X-Gm-Message-State: AOJu0YybTJw/UROZP/tXfzTAgMUZsCPEY/Bm33MYgD8xghGy5Wvp0f3z
	1bE+gLOf62E6TLnQCnXt/xr5WLn6UECiDEQ6FsKT8mECNKIfvwWO
X-Google-Smtp-Source: AGHT+IH+Lnbfv04NuloWyLPrA3PQLDK2LzEpz7XkuCZUsEdGnbz6UYvLQOLZG3xR+Y40Kc4ZOlsqSQ==
X-Received: by 2002:a05:6214:451e:b0:68f:5d7f:6a8d with SMTP id oo30-20020a056214451e00b0068f5d7f6a8dmr8307448qvb.3.1708363240308;
        Mon, 19 Feb 2024 09:20:40 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id og15-20020a056214428f00b0068f8a21a065sm245302qvb.13.2024.02.19.09.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:20:39 -0800 (PST)
Date: Mon, 19 Feb 2024 12:20:39 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <65d38de7959f9_1f98e529449@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iJ2Cv+u+KhEN66RqL=985khA4oAOrnJmrNEje5N2KNupg@mail.gmail.com>
References: <20240219141220.908047-1-edumazet@google.com>
 <65d37cdc26e65_1f47ea29474@willemb.c.googlers.com.notmuch>
 <CANn89iJ2Cv+u+KhEN66RqL=985khA4oAOrnJmrNEje5N2KNupg@mail.gmail.com>
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Feb 19, 2024 at 5:07=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > syzbot reported a lockdep violation [1] involving af_unix
> > > support of SO_PEEK_OFF.
> > >
> > > Since SO_PEEK_OFF is inherently not thread safe (it uses a per-sock=
et
> > > sk_peek_off field), there is really no point to enforce a pointless=

> > > thread safety in the kernel.
> >
> > Would it be sufficient to just move the setsockopt, so that the
> > socket lock is not taken, but iolock still is?
> =

> Probably, if we focus on the lockdep issue rather than the general
> SO_PEEK_OFF mechanism.
> =

> We could remove unix_set_peek_off() in net-next,
> unless someone explains why keeping a locking on iolock is needed.

Since calling SO_PEEK_OFF and recvmsg concurrently is inherently not
thread-safe, fine to remove it all.

All unix_set_peek_off does is an unconditional WRITE_ONCE.

It's just not the smallest change to address this specific report.
+1 on cleaning up more thoroughly in net-next.

> >
> > Agreed with the general principle that this whole interface is not
> > thread safe. So agreed on simplifying. Doubly so for the (lockless)
> > UDP path.
> >
> > sk_peek_offset(), sk_peek_offset_fwd() and sk_peek_offset_bwd() calls=

> > currently all take place inside a single iolock critical section. If
> > not taking iolock, perhaps it would be better if sk_peek_off is at
> > least only read once in that critical section, rather than reread
> > in sk_peek_offset_fwd() and sk_peek_offset_bwd()?
> =

> Note that for sk_peek_offset_bwd() operations, there is no prior read
> of sk_peek_off,
> since the caller does not use MSG_PEEK (only UDP does a read in an
> attempt to avoid the lock...)
> =

> static inline int sk_peek_offset(const struct sock *sk, int flags)
> {
>     if (unlikely(flags & MSG_PEEK))
>         return READ_ONCE(sk->sk_peek_off);
> =

>     return 0;
> }

Good point, thanks.

Reviewed-by: Willem de Bruijn <willemb@google.com>
> =

> =

> =

> =

> >
> > >
> > > After this patch :
> > >
> > > - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
> > >
> > > - skb_consume_udp() no longer has to acquire the socket lock.
> > >
> > > - af_unix no longer needs a special version of sk_set_peek_off(),
> > >   because it does not lock u->iolock anymore.
> > >
> > > As a followup, we could replace prot->set_peek_off to be a boolean
> > > and avoid an indirect call, since we always use sk_set_peek_off().
> >



