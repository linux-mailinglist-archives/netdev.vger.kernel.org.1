Return-Path: <netdev+bounces-191995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 416CAABE250
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B282F4A2F25
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6A27EC9A;
	Tue, 20 May 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck9EQlqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0332586EB;
	Tue, 20 May 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764387; cv=none; b=UgKeh3UtPi25UpQU/4OzCKbc3jevgDnqMJ+QZ7zjEEeF4BDbng7XXV8AX7kwKRGNBTL/zLn6RuRecr1R0kdo4s7roFUfO09Y09QxR5J3yzj2WnLkri714tbQvs87L/kM1D9ft4CIcOpvfnftPS8ed0X/V6OeV2M/I5D5B2wCW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764387; c=relaxed/simple;
	bh=7rPhaF4+Cy/tYmSEt2WlwqErAtQEjfZXAo1efvCcBdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn9EXbEo8TNFR3skIQH9+dGPHBFH5GNPTevM1z11Epn2k2H0gce7WnvJfYh6/sfRwcfo/QN7kv90SCeIXFg2i2eQgasZ3+HSK6rj9L+YFzXjbFEz/7Ll1bdZzgb5BvxLoJ1ZQDwQoriUvmnOhGlPlvKnGL1nqn/PGNhHc9W4rXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck9EQlqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DB6C4CEE9;
	Tue, 20 May 2025 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747764387;
	bh=7rPhaF4+Cy/tYmSEt2WlwqErAtQEjfZXAo1efvCcBdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ck9EQlqQUkqaFVmien8B6+8LGaXz6+lbxOqj1p55mWngr6s2aepPnSG7MaqbzF2iV
	 ISZWCaEohp/60hUy5oSTJBYilM1PmM9AtGhzHP8ppKd/92NqHlVla5GwkT+EL/Pk4d
	 pDEFgDgF3tAqYwhJ3uthq0evUO1SzmfrN9ts2iUTPJ5EYiupEUfJmxXx/VnhAkAz0V
	 KiFQVPt+7veNNK2Qf0N2oX7aRnREziWvi1/oNYMsMz5sAx5fKeI1CNshlgmwQHNhNn
	 aikdIf9RED2fUxyywrepCkPh64Nrb5KWHW0tzXKnMxGWnf85LoxRea8GjZxw4gP5XG
	 g25vm6vfJTUEQ==
Date: Tue, 20 May 2025 11:06:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: "dongchenchen (A)" <dongchenchen2@huawei.com>, hawk@kernel.org,
 ilias.apalodimas@linaro.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhangchangzhong@huawei.com
Subject: Re: [BUG Report] KASAN: slab-use-after-free in
 page_pool_recycle_in_ring
Message-ID: <20250520110625.60455f42@kernel.org>
In-Reply-To: <CAHS8izMenFPVAv=OT-PiZ-hLw899JwVpB-8xu+XF+_Onh_4KEw@mail.gmail.com>
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
	<CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
	<34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
	<CAHS8izPh5Z-CAJpQzDjhLVN5ye=5i1zaDqb2xQOU3QP08f+Y0Q@mail.gmail.com>
	<20250519154723.4b2243d2@kernel.org>
	<CAHS8izMenFPVAv=OT-PiZ-hLw899JwVpB-8xu+XF+_Onh_4KEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2025 17:53:08 -0700 Mina Almasry wrote:
> On Mon, May 19, 2025 at 3:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 19 May 2025 12:20:59 -0700 Mina Almasry wrote: =20
> > > Clearly this is not working, but I can't tell why. =20
> >
> > I think your fix works but for the one line that collects recycling
> > stats. If we put recycling stats under the producer lock we should
> > be safe. =20
>=20
> What are you referring to as recycle stats? Because I don't think
> pool->recycle_stats have anything to do with freeing the page_pool.
>=20
> Or do you mean that we should put all the call sites that increment
> and decrement pool->pages_state_release_cnt and
> pool->pages_state_hold_cnt under the producer lock?

No, just the "informational" recycling stats. Looking at what Dong
Chenchen has shared:

page_pool_recycle_in_ring
 =C2=A0 ptr_ring_produce
 =C2=A0=C2=A0=C2=A0 spin_lock(&r->producer_lock);
 =C2=A0=C2=A0=C2=A0 WRITE_ONCE(r->queue[r->producer++], ptr)
 =C2=A0=C2=A0=C2=A0 spin_unlock(&r->producer_lock);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //recycle last page to pool
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_pool_release
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_pool_scrub
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_pool_e=
mpty_ring
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ptr_ring_consume
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 page_pool_return_page //release=20
all page
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __page_pool_destroy
free_percpu(pool->recycle_stats);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree=
(pool) //free
 =C2=A0 recycle_stat_inc(pool, ring); //uaf read


The thread which put the last page into the ring has released the
producer lock and now it's trying to increment the recycling stats.
Which is invalid, the page it put into the right was de facto the
reference it held. So once it put that page in the ring it should
no longer touch the page pool.

It's not really related to the refcounting itself, the recycling
stats don't control the lifetime of the object. With your patch
to turn the producer lock into a proper barrier, the remaining
issue feels to me like a basic UAF?

