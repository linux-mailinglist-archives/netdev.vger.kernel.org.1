Return-Path: <netdev+bounces-160874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1588A1BF24
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 00:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EEB3ACF7B
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB41E7C3D;
	Fri, 24 Jan 2025 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3U2iW3Gs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA729406
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737762588; cv=none; b=I3ZjBZR138a7tlk9Ck6X4GpjDoX0lWuJleRZRxzcBRMarb73t1x1ugCGZB0ye0PzRAyKtz9c/OdxTayhXX6FTf93YuAaY0spRJglPBI9igfW+YQAJQW6vnkmzwa09I6ULr6duYLkCD/XXe9ZK+AArMDZjrLzRA5kync2FUXabeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737762588; c=relaxed/simple;
	bh=7rFDHzGhqVP3tZPJWITX2s28i7H999MPCwgC1OVDAeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwANBmy5MpoCJ0msygo/KRHYfkSTDy/i1oeyTROJpQWw2KaBK4xEbtoSmVDNbD9VELM1fclhpFcaYCrZuxuUhJ4ii21T3zP8qdeX2WChOLJu6PPWtbedsNek66FLY43aohOO2u4k9hd/r07Mriyl1r5TlZKWSS4RlSv2FW5b+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3U2iW3Gs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215740b7fb8so51625ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 15:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737762586; x=1738367386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb62F8R/XGWx63wsMa3CDZN3mLSBlv9/FOygqye9Pvo=;
        b=3U2iW3Gsb2fODxXdGioP0VbUgqqTXTikcXCpYA56zVdeUs4adK40hurxULBQN23qna
         55g0Cu/G/jDxhVULbqPKkd/toDULADP+lRr3WsbI1CL5kw/s3XfmZcAjorJ2+wXJpZ5o
         F4/RY1idG37umOgRQ/5BD/5uFlWTUhs3q+UaqMYdfiU3b6Pke4Na6Lt+sZYfaomkdTL9
         dPbYwV1j3mYf6ZtrPBYVj4wFu2qYeA9aC7zn8IVLGbSXaWmuznMYU/uwSnGjICsVHfAJ
         eheFP8sSY9lpquJZVERidH14U1bR022FiNniaupHiaAmXmNKFFbb3qeaO10sv69vcOb6
         ZSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737762586; x=1738367386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb62F8R/XGWx63wsMa3CDZN3mLSBlv9/FOygqye9Pvo=;
        b=obntZ3iV6A5RjfmQRxBpuKMdtrRDzh6DAzbvxXPuBDFWKlKkD3JVavABMSJrmL2sjr
         WDyY8JUH5Xv+ZsIVoWqSSNcj3pgFj7dLGZe45Vz2wb4CAxaffoiityNF4sh8GI/UTpgW
         AmQnk0biaV8NwPBlUBBpAHBGoJXPWf0JNO7p0QPTJcE5rJqGed1zYBIu0nZ+X26nkix0
         UR7Y8e403T2E4wrr+5YNlOVz3ZOXpDV4wm6KTEYmoJHnLLxLTSWZefb5d5Yzyrdg4Rwq
         IMI7B4SkCz5a6vcO+2yPmYfQXHqUERdTVyoFaH+ZpyvaWFvTTOcu9FLBiRGgebvhb6Wz
         +Xtg==
X-Forwarded-Encrypted: i=1; AJvYcCXP5FkORj5JR60pG61374cFI1iVnwJk8FaPiCBqeGOAKKXWIFvMp3RTKruGfJwzuHCZoykRR/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxzn5qwVp6nKlmqp4235FM9R1x5jHpvME6hq/YUtg8KtTfoxf
	ixd3K1+D3rAm/lOPrX5pwEo0zI6B4yA7K/UnXp45hhtorVWAy3qEQz5isLcfEnkKv69jwawZ/j4
	qEk6NeFXWGnm8UNwpNO+sdbrRxdhRDMjAh3nB
X-Gm-Gg: ASbGncvPp4Mmv4zxAr6S4PFtIGx5oEszm0N6WwK/P0NMY5srQL9PDkaty2sFsvCezBl
	FWhvqcVtIkhJ3OPL+REg1DOHUgz2QxXkwxbieIp93UgJ0qF20C3WK0/Bn3Tfkx2Zmm+XfZq4xpz
	vh0uYs2aZpcJceAQTg
X-Google-Smtp-Source: AGHT+IEzUmqAC1RHHankRyIOt9oThWdlbsTg57A7ZuDGGdLmv/HFoOnYTZWyKAtRSWS4lgVn9VDi7wDtzILlJ9Byzxs=
X-Received: by 2002:a17:903:988:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-21db03635eemr370285ad.27.1737762585417; Fri, 24 Jan 2025
 15:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123231620.1086401-1-kuba@kernel.org> <CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
 <87r04rq2jj.fsf@toke.dk>
In-Reply-To: <87r04rq2jj.fsf@toke.dk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jan 2025 15:49:32 -0800
X-Gm-Features: AWEUYZlERkd3xq8k-YvZej07eGymZ63JegX7G7ggqLA7rxtM2V-qiT4nvzI6caM
Message-ID: <CAHS8izOv=tUiuzha6NFq1-ZurLGz9Jdi78jb3ey4ExVJirMprA@mail.gmail.com>
Subject: Re: [PATCH net] net: page_pool: don't try to stash the napi id
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	mkarsten@uwaterloo.ca, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:18=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > On Thu, Jan 23, 2025 at 3:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >>
> >> Page ppol tried to cache the NAPI ID in page pool info to avoid
> >
> > Page pool
> >
> >> having a dependency on the life cycle of the NAPI instance.
> >> Since commit under Fixes the NAPI ID is not populated until
> >> napi_enable() and there's a good chance that page pool is
> >> created before NAPI gets enabled.
> >>
> >> Protect the NAPI pointer with the existing page pool mutex,
> >> the reading path already holds it. napi_id itself we need
> >
> > The reading paths in page_pool.c don't hold the lock, no? Only the
> > reading paths in page_pool_user.c seem to do.
> >
> > I could not immediately wrap my head around why pool->p.napi can be
> > accessed in page_pool_napi_local with no lock, but needs to be
> > protected in the code in page_pool_user.c. It seems
> > READ_ONCE/WRITE_ONCE protection is good enough to make sure
> > page_pool_napi_local doesn't race with
> > page_pool_disable_direct_recycling in a way that can crash (the
> > reading code either sees a valid pointer or NULL). Why is that not
> > good enough to also synchronize the accesses between
> > page_pool_disable_direct_recycling and page_pool_nl_fill? I.e., drop
> > the locking?
>
> It actually seems that this is *not* currently the case. See the
> discussion here:
>
> https://lore.kernel.org/all/8734h8qgmz.fsf@toke.dk/
>
> IMO (as indicated in the message linked above), we should require users
> to destroy the page pool before freeing the NAPI memory, rather than add
> additional synchronisation.
>

Ah, I see. I wonder if we should make this part of the API via comment
and/or add DEBUG_NET_WARN_ON to catch misuse, something like:

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ed4cd114180a..3919ca302e95 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -257,6 +257,10 @@ struct xdp_mem_info;

 #ifdef CONFIG_PAGE_POOL
 void page_pool_disable_direct_recycling(struct page_pool *pool);
+
+/* page_pool_destroy or page_pool_disable_direct_recycling must be
called before
+ * netif_napi_del if pool->p.napi is set.
+ */
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void=
 *),
                           const struct xdp_mem_info *mem);

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5c4b788b811b..dc82767b2516 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1161,6 +1161,8 @@ void page_pool_destroy(struct page_pool *pool)
        if (!page_pool_put(pool))
                return;

+       DEBUG_NET_WARN_ON(pool->p.napi && !napi_is_valid(pool->p.napi));
+
        page_pool_disable_direct_recycling(pool);
        page_pool_free_frag(pool);

I also took a quick spot check - which could be wrong - but it seems
to me both gve and bnxt free the napi before destroying the pool :(

But I think this entire discussion is unrelated to this patch, so and
the mutex sync in this patch seems necessary for the page_pool_user.c
code which runs outside of softirq context:

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

