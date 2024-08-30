Return-Path: <netdev+bounces-123844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C73966A70
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61771C21E95
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF811BF337;
	Fri, 30 Aug 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lloLewzx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B413B297;
	Fri, 30 Aug 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049690; cv=none; b=UsvzI5Ao0oyLk6rnhUlwlzbHAuasOyk0h4rgeyCFsXx5acIG/TwBY0m0wM0ELHWna+MN9202Q7v7S8xPdsWXUVF8USTz+D2L/QLJWYggZViS4Wn9AHOxubwAXAjzLg/5BMSBNieVUT/290KFp1vOG08+6HkIyXgJVoB1n08ZjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049690; c=relaxed/simple;
	bh=HNBaDpT3+FBGuCPDA3OX2AGWFC8K1JMZoreZb6bhrQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBe8EAfiDUpv6H68bVJi7Rs+bdx0ZFORbpymDO5ASNoxGKYblMf7PpgGeW7wc14gubu7ivD2jP3WzGa6JLedVOo1UlC6cIYyfZ6Zp8vglIeWEY03eW+q9L014lCjacSiafzAqORVP4LGKoeBRc5Z6tSSCYE6Uqx+NgfEPmIFJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lloLewzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4C6C4CEC2;
	Fri, 30 Aug 2024 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725049690;
	bh=HNBaDpT3+FBGuCPDA3OX2AGWFC8K1JMZoreZb6bhrQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lloLewzx1SIIUiGNv3z09+qwwfw2NS7Pzhl0CfI5wqTx5c1CAI6sj5zO8dhPkNdUF
	 RdoNXm1fAneVeMA6/l+QeB2yC8ghKBoze30tSYPAkqUD+DdaR9TUbOP92E/WXOxVzy
	 7bKuDiB9qLyZc2jy95h8jvELvXKh1qbGSvhPP+AIuinp2+dsKL9XKVphgLu/Nv9V4+
	 tH56G4c2qD9/VYWi3J73L0Z/u2nvkVBIYBtAJKAiC0tRvChxfjwZ7Y6GB+ioXTEXMK
	 JmPpQEiOi4mPT/qWH7JK6yoBpVy0Nzv1fmyQnf1HOAXjz7lkbmdIHwNxvcSa2vCC4b
	 FBpU780O4QVyA==
Date: Fri, 30 Aug 2024 13:28:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] netdev-genl: Dump napi_defer_hard_irqs
Message-ID: <20240830132808.33129d22@kernel.org>
In-Reply-To: <ZtGMl25LaopZk1So@LQ3V64L9R2>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-3-jdamato@fastly.com>
	<20240829150828.2ec79b73@kernel.org>
	<ZtGMl25LaopZk1So@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Aug 2024 10:10:47 +0100 Joe Damato wrote:
> > > +        name: defer-hard-irqs
> > > +        doc: The number of consecutive empty polls before IRQ deferr=
al ends
> > > +             and hardware IRQs are re-enabled.
> > > +        type: s32 =20
> >=20
> > Why is this a signed value? =F0=9F=A4=94=EF=B8=8F =20
>=20
> In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral
> feature"), napi_defer_hard_irqs was added to struct net_device as an
> int. I was trying to match that and thus made the field a signed int
> in the napi struct, as well.

It's probably because int is the default type in C.
The choice of types in netlink feels more deliberate.

> It looks like there was a possibility of overflow introduced in that
> commit in change_napi_defer_hard_irqs maybe ?
>=20
> If you'd prefer I could:
>   - submit a Fixes to change the net_device field to a u32 and then
>     change the netlink code to also be u32
>   - add an overflow check (val > U32_MAX) in
>     change_napi_defer_hard_irqs
>=20
> Which would mean for the v2 of this series:
>   - drop the overflow check I added in Patch 1
>   - Change netlink to use u32 in this patch=20
>=20
> What do you think?

Whether we want to clean things up internally is up to you, the overflow
check you're adding in sysfs seems good. We can use u32 in netlink, with
a check: max: s32-max and lift this requirement later if we ever need
the 32nd bit?

