Return-Path: <netdev+bounces-161182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1DCA1DCCE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755CD1882C3C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 19:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DE192D86;
	Mon, 27 Jan 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO1cU+5v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34386192B90
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006674; cv=none; b=Z3z8Qycb4iidmPPWXMGKzHd6X0aH4CxEmpJYjrQHVzVFYSimeD+tixOXcB/gxjDzvh1uAzk7DTta71iXNo6+JV2Rm91WKZmo16ab4XBcBmcIdHGETRl2H8U/X7sg32oF4JajJ0DYfp/emTt6Hde+vgSjA2+zUmrTn6kvVeA3vWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006674; c=relaxed/simple;
	bh=foxA2L/+4FGqo1Ez7fCuuER5N09cKkuLdZQCMwdNYAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eK3eG5BsozdNxrwlorXcJAR5mlbXSIrWGdOxOxMgZKyC2uIHPH9YHWcqxc5x8hUQmNkHSup7EthNK5Oo7u9DUjzWX61jdSph6l1wGa1iZ9qwkKcyB2rbPxnjBT+yn6cKR9ZiE0GqblFgRCVgMc06IZ6S+m8V+oCpJ3IV0nXIJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO1cU+5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63AEC4CED2;
	Mon, 27 Jan 2025 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738006672;
	bh=foxA2L/+4FGqo1Ez7fCuuER5N09cKkuLdZQCMwdNYAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cO1cU+5vTzW2agjQTfHHy8UsXV5DsiAHlZcibNrFp6GkYxx/wOrWS48LeumK1INUN
	 vQKZwmtMLArNLRYMz0vp62Mr0YERO9a2XX1Rw3ICTmzdhXkvzlZoPovAKCuxmXktMe
	 N0S818gJEJyaegEDnNYwfZ6q5EXBbg+x4kMHRRV+ZKtqez1ZNyjs9peD6ztTkGyvMw
	 7AZ8SQNEvDflUwyqDGA6gcAkNTRfxslno/gd59qfpp4GNOROwcUgkLGgYy9RRYDect
	 1Atmh59yPDK1GpubmuMkC1Ecjn6nF82qQzqzCHmsq5OTfpfI/cVtYDRyQFqldS0sG8
	 LaTsT58CCYy3w==
Date: Mon, 27 Jan 2025 11:37:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, asml.silence@gmail.com, kaiyuanz@google.com,
 willemb@google.com, mkarsten@uwaterloo.ca, jdamato@fastly.com
Subject: Re: [PATCH net] net: page_pool: don't try to stash the napi id
Message-ID: <20250127113750.54ed83d4@kernel.org>
In-Reply-To: <877c6gpen5.fsf@toke.dk>
References: <20250123231620.1086401-1-kuba@kernel.org>
	<CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
	<87r04rq2jj.fsf@toke.dk>
	<CAHS8izOv=tUiuzha6NFq1-ZurLGz9Jdi78jb3ey4ExVJirMprA@mail.gmail.com>
	<877c6gpen5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 14:31:10 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > +
> > +/* page_pool_destroy or page_pool_disable_direct_recycling must be
> > called before
> > + * netif_napi_del if pool->p.napi is set.
> > + */

FWIW the comment is better placed on the warning, that's where people
will look when they hit it ;)

> >  void page_pool_destroy(struct page_pool *pool);
> >  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(=
void *),
> >                            const struct xdp_mem_info *mem);
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 5c4b788b811b..dc82767b2516 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1161,6 +1161,8 @@ void page_pool_destroy(struct page_pool *pool)
> >         if (!page_pool_put(pool))
> >                 return;
> >
> > +       DEBUG_NET_WARN_ON(pool->p.napi && !napi_is_valid(pool->p.napi));

IDK what "napi_is_valid()" is. I think like this:

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a3de752c5178..837ed36472db 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1145,6 +1145,7 @@ void page_pool_disable_direct_recycling(struct page_p=
ool *pool)
         * pool and NAPI are unlinked when NAPI is disabled.
         */
        WARN_ON(!test_bit(NAPI_STATE_SCHED, &pool->p.napi->state));
+       WARN_ON(!test_bit(NAPI_STATE_LISTED, &pool->p.napi->state));
        WARN_ON(READ_ONCE(pool->p.napi->list_owner) !=3D -1);
=20
        WRITE_ONCE(pool->p.napi, NULL);

Because page_pool_disable_direct_recycling() must also be called while
NAPI is listed. Technically we should also sync rcu if the driver calls
this directly, because NAPI may be reused :(

> >         page_pool_disable_direct_recycling(pool);
> >         page_pool_free_frag(pool); =20
>=20
> Yeah, good idea; care to send a proper patch? :)

...for net-next ? :)

