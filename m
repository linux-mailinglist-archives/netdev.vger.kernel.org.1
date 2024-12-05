Return-Path: <netdev+bounces-149299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38669E50FA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9462F1880395
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994B1D5AB5;
	Thu,  5 Dec 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjcTHYIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0321D5ABF
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390107; cv=none; b=D2GKhKH5x1Pmc6qlAy2ybUd8Cr0d9+OoNni3TZtf3YS8UGmILAlDh615/SaCpIGJ5pkrG2ZwJ2CbpDgO9kCHtmfZv4e9cmrjNwEEn0snZC3MPU+VF0ysmB2YwQZiGWjmtfrR7gtzCHC858UNvx2lfIEziNrI6k9cQUrtaPtKI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390107; c=relaxed/simple;
	bh=OG0rEGDkFmfJuvGQEF0HUY8qiLqwjowQZR9lZVLEhsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUTCc0lp6/UMT4UuRvFHX8UCCbtBKTSizZkEKztx3xhMN77Ru0M2iOax5TXlmYNGMHjUf/XW9wS5Tm+LPot5Xd1cN9gvKoNwFlaAHLKh7tbtzw0kalWSHQeTuMVDKWOowiJBCzr4qsqszq0WhG3R1mNwanPpDOCVDOOOZtQe4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjcTHYIQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa62f5cbcffso9136766b.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733390104; x=1733994904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldisDTOQNTP8udxKoKMdQUWNCO4qphjAfrIj8OYwFj4=;
        b=EjcTHYIQHHsABTXiumgeqTVJtqm1+SGXvmEmiQFCicncosxKKA/3VW2CFDbWN5zrvu
         fJAdfGSk5EPWSKxDOeHU+VK97XXEaPkU1ybFDIR5UBn4lu6a4KwSKFhum6zsLR9Xuz04
         FuWaNbm5K1dLaRU1DpGrMwox7+FM56C7FM60yxPvTEy08Ji39Ewzw6pZDHw1r60ZiF+G
         4VozPg3za8ompWUotQ9CUsGZlhH4k3fUqFltlKFIAjF2jWVKzhuQJY5nW2Dw9mmLJ/3Z
         rQHu04KsWpJq6lyOyWcAYRr1k+9g7eegejstUhtxiWkKLS2QKwcgq9gEpTDZFZGkr4z0
         epFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733390104; x=1733994904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldisDTOQNTP8udxKoKMdQUWNCO4qphjAfrIj8OYwFj4=;
        b=UPYiEOWBNzQKk6gxorYb0dC+ew/2CUkNNf2fRIpwHQsizrvroZ8jU3E8RxREBBJ6nW
         rPJIl2Y3ZCWEqnC5Vxl+9cfpnUEwC0Fd+yiboEna9s4gUbq13HenOuQtSKYgNg2eEW9g
         hxkX2YWUN1FaBm7rD01IlHefgab3i8qowLHtYGBAQut0p3G7ANJqAiDNnN89TzD5qWsW
         sJOPJria/ASLIv4BA5jUtAhgamzsEaEmKrZOad5oM6/ubs6xukL+OdxMXcKC/WKGsIDs
         ya54AXBbQ+WIJsUVdt3JtAqq9xDIPkNT4NS+fQRH04rvV/aLgJlC38+sSGzXmXFZ8TKs
         wusQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLpUrsLD4jELrvQdGjBk+7gXFczpjOi+8ECuuS1uHIS25sRdeEhEHz2TP9qQiLKP+hmHHpOPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Ss6+K7iOzosm54PFHSqmOs9jLjAzoj5HQbt/oH1sa2CJPyN3
	PFGARSB1zFkywynF9UgIXn1MFYD9aCkd0/Dw91q7pbLqkMKNqShRv45kTtPDtZwp/NWXdFVxPvj
	JpMRV9xG516RlvBEnFgEoZlKYsVVbRfFLRBqE
X-Gm-Gg: ASbGnct73DynukAny6NN0x2aQ+cYClN58NgMY6dUFyiTzhGUSLSTRJqXd5943ecW6AP
	hpbtOjwGvxDe2If4bN/slXk7/WJKgGPg=
X-Google-Smtp-Source: AGHT+IGOsayoHPShydFnC9xa1LzXTaClJo6x/Sq7SmyuXQ90P6k4nchumOE1TY19v0hgKofphIPb+ShzGwbbAkP8dTg=
X-Received: by 2002:a17:907:96a5:b0:aa5:b1e3:c819 with SMTP id
 a640c23a62f3a-aa6219df3dbmr249634966b.22.1733390103882; Thu, 05 Dec 2024
 01:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204125455.3871859-1-edumazet@google.com> <a88b242a-a6ca-466e-9ca2-627e9193b1e3@redhat.com>
In-Reply-To: <a88b242a-a6ca-466e-9ca2-627e9193b1e3@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Dec 2024 10:14:53 +0100
Message-ID: <CANn89i+-Syy2spK6V3MK1RYT71nwuNYrMMVCJ0-wv0LAUwHvkQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: defer final 'struct net' free in netns dismantle
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Ilya Maximets <i.maximets@ovn.org>, 
	Dan Streetman <dan.streetman@canonical.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:35=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 12/4/24 13:54, Eric Dumazet wrote:
> > Ilya reported a slab-use-after-free in dst_destroy [1]
> >
> > Issue is in xfrm6_net_init() and xfrm4_net_init() :
> >
> > They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
> >
> > But net structure might be freed before all the dst callbacks are
> > called. So when dst_destroy() calls later :
> >
> > if (dst->ops->destroy)
> >     dst->ops->destroy(dst);
> >
> > dst->ops points to the old net->xfrm.xfrm[46]_dst_ops, which has been f=
reed.
> >
> > See a relevant issue fixed in :
> >
> > ac888d58869b ("net: do not delay dst_entries_add() in dst_release()")
> >
> > A fix is to queue the 'struct net' to be freed after one
> > another cleanup_net() round (and existing rcu_barrier())
>
> I'm sorry for the late feedback.
>
> If I read correctly the above means that the actual free could be
> delayed for an unlimited amount of time, did I misread something?
>
> I guess the reasoning is that the total amount of memory used by the
> netns struct should be neglicible?
>
> I'm wondering about potential ill side effects WRT containers
> deployments under memory pressure.

One net_namespace structure is about 3328 bytes today, a fraction of
the overall cost of a live netns.

It would be very unlikely a deployment would have one cleanup_net(),
adding these in a long list,
then no other cleanup_net().

Note that I am thinking of something similar for netdev_run_todo() :
Being able to offload to a worker thread
the final steps (the rcu_barrier() and following parts), because this
is one of the major costs in netns dismantles.

