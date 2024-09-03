Return-Path: <netdev+bounces-124336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC39690BE
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE802833B7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705281A4E6F;
	Tue,  3 Sep 2024 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQDKmRDi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BACA20;
	Tue,  3 Sep 2024 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725324586; cv=none; b=RPhfr4g+Nr3bvVtMKeDH/B1qHeDwdbdPdp5wBR44Hfleiu2t2d9vufKbeGsQ64yofboMToZ3bCs8HYHEeYavsc12yYZuZ0z6XaIZgSii7uUIuBPnm/CZUZIaRN9M8XqilGxbBSPGmEz4igvA/3XHMuXedEl7qhOTKx2CmMBmZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725324586; c=relaxed/simple;
	bh=YLql04D5bVmlLJCW3Ei9ILHv9x5JCQUJW9OQmJ5x/VA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjSgLIpbglcXTV4cRtkA9Zu0g6RBblzT/z7BqjCHwvFcZwqzwB9o9XBKkRnw4kC6nBA89EnCJNmuiG3pLNmHUumHNbje9b0uWx/d3rHhsstL+7DxqGXBTZXLhcdn+0jLmIxeUH1sfEBheLI96CadK6+7RW9B1xn+pSB3RpaIA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQDKmRDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D51C4CEC2;
	Tue,  3 Sep 2024 00:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725324585;
	bh=YLql04D5bVmlLJCW3Ei9ILHv9x5JCQUJW9OQmJ5x/VA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQDKmRDiEEGV3NLa9InqArMbxSAhulNxlm1BRY3a95FA5bXXZHE4LJcAD9OWJE4y1
	 mYyc5LJoyWUHU2xcN2IQPPKwA5uEwUUH5nwazKvia97tWiVqCDxgOP/zcUflF+uJc8
	 Wn8w2z8j9tJ0HbjCVesyhbG6+cdQKdnB37gpSutud1/sPqasNvwuPmQ3CjZlxD+nAg
	 jHTdw06pt/ic4xRfBxIbjlKolzyfo1nTi++63zK5gPWvgWjPmTsxA35sTQcuu8A3J1
	 aP2BbDhSqfwqBSh8f+fGylL3BhbjMrKRmBYGGx5KNnz/BKNa2wCWcZHibVjYjZL18z
	 NT5OV8yS26M2g==
Date: Mon, 2 Sep 2024 17:49:44 -0700
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
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20240902174944.293dfe4b@kernel.org>
In-Reply-To: <ZtNSkWa1G40jRX5N@LQ3V64L9R2>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-6-jdamato@fastly.com>
	<20240829153105.6b813c98@kernel.org>
	<ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
	<20240830142235.352dbad5@kernel.org>
	<ZtNSkWa1G40jRX5N@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 31 Aug 2024 18:27:45 +0100 Joe Damato wrote:
> > How do you feel about making this configuration opt-in / require driver
> > changes? What I'm thinking is that having the new "netif_napi_add()"
> > variant (or perhaps extending netif_napi_set_irq()) to take an extra
> > "index" parameter would make the whole thing much simpler. =20
>=20
> I think if we are going to go this way, then opt-in is probably the
> way to go. This series would include the necessary changes for mlx5,
> in that case (because that's what I have access to) so that the new
> variant has a user?

SG! FWIW for bnxt the "id" is struct bnxt_napi::index (I haven't looked
at bnxt before writing the suggestion :))

> > Index would basically be an integer 0..n, where n is the number of
> > IRQs configured for the driver. The index of a NAPI instance would
> > likely match the queue ID of the queue the NAPI serves.
> >=20
> > We can then allocate an array of "napi_configs" in net_device -
> > like we allocate queues, the array size would be max(num_rx_queue,
> > num_tx_queues). We just need to store a couple of ints so it will
> > be tiny compared to queue structs, anyway. =20
>=20
> I assume napi_storage exists for both combined RX/TX NAPIs (i.e.
> drivers that multiplex RX/TX on a single NAPI like mlx5) as well
> as drivers which create NAPIs that are RX or TX-only, right?

Hm.

> If so, it seems like we'd either need to:
>   - Do something more complicated when computing how much NAPI
>     storage to make, or
>   - Provide a different path for drivers which don't multiplex and
>     create some number of (for example) TX-only NAPIs ?
>=20
> I guess I'm just imagining a weird case where a driver has 8 RX
> queues but 64 TX queues. max of that is 64, so we'd be missing 8
> napi_storage ?
>=20
> Sorry, I'm probably just missing something about the implementation
> details you summarized above.

I wouldn't worry about it. We can added a variant of alloc_netdev_mqs()
later which takes the NAPI count explicitly. For now we can simply
assume max(rx, tx) is good enough, and maybe add a WARN_ON_ONCE() to=20
the set function to catch drivers which need something more complicated.

Modern NICs have far more queues than IRQs (~NAPIs).

> > The NAPI_SET netlink op can then work based on NAPI index rather=20
> > than the ephemeral NAPI ID. It can apply the config to all live
> > NAPI instances with that index (of which there really should only=20
> > be one, unless driver is mid-reconfiguration somehow but even that
> > won't cause issues, we can give multiple instances the same settings)
> > and also store the user config in the array in net_device. =20
>=20
> I understand what you are proposing. I suppose napi-get could be
> extended to include the NAPI index, too?

Yup!

> Then users could map queues to NAPI indexes to queues (via NAPI ID)?

Yes.

> > When new NAPI instance is associate with a NAPI index it should get
> > all the config associated with that index applied.
> >=20
> > Thoughts? Does that makes sense, and if so do you think it's an
> > over-complication? =20
>=20
> It feels a bit tricky, to me, as it seems there are some edge cases
> to be careful with (queue count change). I could probably give the
> implementation a try and see where I end up.
>=20
> Having these settings per-NAPI would be really useful and being able
> to support IRQ suspension would be useful, too.
>=20
> I think being thoughtful about how we get there is important; I'm a
> little wary of getting side tracked, but I trust your judgement and
> if you think this is worth exploring I'll think on it some more.

I understand, we can abandon it if the implementation drags out due to
various nit picks and back-and-forths. But I don't expect much of that
=F0=9F=A4=9E=EF=B8=8F

