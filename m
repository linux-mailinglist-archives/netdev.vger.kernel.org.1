Return-Path: <netdev+bounces-119351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25789554C0
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EB22830CB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E3720ED;
	Sat, 17 Aug 2024 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUxjecnz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA64A33
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723860111; cv=none; b=LLWx3aKrWrT0dfNXJpr1fQb6iXLOZzIX823VjZZx7gNeykkI3DTI5Yl38RNYe51ibXGzhjf4w6sM69dEf8u1c0KRGw0UZB7N0CkYqy2nrzkHQSzxpp9ktxPnlbEHCX6zoEOTCxUsb3/n5AdRvKkF1QhoWUd3RkGP0lC54rDohdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723860111; c=relaxed/simple;
	bh=5ojn20Ok4w3PgwmRbyc6H2CuxU4Fjdq695+tQv7lq0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4OSiMne//QM8eZ6O+nbUKM7Uog1C77vhMyHXYzgvWwElpEKu6l/tuiuup0ewzXop60t8i6DksET+CBkfwipj7bN4oYm0z1AxxOGCTa/HpkFqeXAzhtfn3dC0AQ07cFnXytD9I0jKbPgyhsIHjEoTW79ErbDsCvyQul8sDKFaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUxjecnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2A4C32782;
	Sat, 17 Aug 2024 02:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723860110;
	bh=5ojn20Ok4w3PgwmRbyc6H2CuxU4Fjdq695+tQv7lq0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RUxjecnzRJeILdhT3/m2vZUQFSWGjbX6JU3NZZtnuQEQFSwFeZ9bmwwuD3Lm9T7ry
	 8Am2UmL8Eo4aoSnE09ULOnz9NXXjO7OGG6Rzg6mYFfy+QApqYLCn9/jhaAj1l0WBPl
	 FkP+HE1J3rtOcNoqC85DqtHGHZBkwOUJKD8DylHtNxrGg/KFDUHNa3IoAalZTN2+MH
	 8U9MtvsMiTEddrwhTKAmwNRTXWVgKXK7oZyDMuiPEcCfPMou8WSMt8g86uoZrkLweP
	 KWX1F4NwGBS+2G3II5uyl3be1abRjnOTMKHxiwsWDvx9rZY1pxA2Hb9TGc/hOSZmue
	 Qd410+Zr03wRA==
Date: Fri, 16 Aug 2024 19:01:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
 <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>,
 "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>,
 "Bshara, Nafea" <nafea@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, "Beider, Ron" <rbeider@amazon.com>, "Chauskin, Igor"
 <igorch@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Parav
 Pandit" <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Message-ID: <20240816190148.7e915604@kernel.org>
In-Reply-To: <6236150118de4e499304ba9d0a426663@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
	<20240814121145.37202722@kernel.org>
	<6236150118de4e499304ba9d0a426663@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 17:32:56 +0000 Arinzon, David wrote:
> > Xuan, Michael, the virtio spec calls out drops due to b/w limit being
> > exceeded, but AWS people say their NICs also count packets buffered but
> > not dropped towards a similar metric.
> > 
> > I presume the virtio spec is supposed to cover the same use cases.
> > Have the stats been approved? Is it reasonable to extend the definition of
> > the "exceeded" stats in the virtio spec to cover what AWS specifies?
> > Looks like PR is still open:
> > https://github.com/oasis-tcs/virtio-spec/issues/180  
> 
> How do we move forward with this patchset?
> Regarding the counter itself, even though we don't support this at
> the moment, I would recommend to keep the queued and dropped as split
> (for example, add tx/rx-hw-queued-ratelimits, or something similar,
> if that makes sense). 

Could you share some background for your recommendation?
As you say, the advice contradicts your own code :S
Let's iron this out for virtio's benefit.

You can resend the first patch separately in the meantime.

