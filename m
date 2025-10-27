Return-Path: <netdev+bounces-233082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE94C0BEFB
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17734345D97
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 06:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ADC298CA6;
	Mon, 27 Oct 2025 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te4zu4eU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3D1946DA
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545849; cv=none; b=MNpF8WpJyMcBwqRFSgA/dOsz0LxlHyvWLekVInGNcen4i+rw4ZtM2MA8eoKr88OERAYPcD45wHm6f8Q8WNTNIsUoK43+CrtPwQNN2tdFFWlQdHcW0mz2kRaKdwLjCm8m+xNbg3xmfms0F3b9LQiBevC0cxgvZxDFwo18pBPmHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545849; c=relaxed/simple;
	bh=s2y9IfOAbXVKdsFD+bd7mUEWaAn36Kc0djLxRb2Yg/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OcUwYzmTBwdxovI48+9H1s2TnBuuS8U8XZbwDxFnVLHgK3bhr0kvCgYPtjq4uglj1UybIX4/mIj2tG1UccvRKZHcwrJucFn9jiXhWnUmGCKhN3XQvZGcMa2wjKp3QgaJ/zxMydtBYFzwE4ruIHy6Z+yBXwpPIHicLbJpHh999MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te4zu4eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7538C4CEF1;
	Mon, 27 Oct 2025 06:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761545848;
	bh=s2y9IfOAbXVKdsFD+bd7mUEWaAn36Kc0djLxRb2Yg/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Te4zu4eU2OIkUie4Cv+Y90UJI8H4XMxQgf0vUo0Nd9GKBPmFvZQIAzlti+abz5jiL
	 fJosq5hGB5c6RXDrE3909I4hiy+WAvsGpckbku9EUI6XBkzbF+4VxhaDVMBmpk/YQV
	 EGzJ1AxRXos/ZWI7Zs0n0i+Y/uYkWnpUUrovH0EHFYinJD9pDraVtqR5vBIFkb5tis
	 AK3/oW4ZPBNpimnkI2z/RRIsjk0qKvf97qefgpcOOgZDxpXoUF/9yG1cNRCCTZ/sR1
	 9CZmKp+gW3b8BAS8oamMX9CGRpVUeXGSoClIvayzi2+dQMpQSDFyn4cn8lGibOt2O0
	 8UxDm4XS7zRBQ==
Message-ID: <b6964938358dc1af41c9fefda071c19e81c8e64a.camel@kernel.org>
Subject: Re: [PATCH net-next 2/3] tcp: add newval parameter to
 tcp_rcvbuf_grow()
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,  Kuniyuki
 Iwashima <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>, 
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 27 Oct 2025 14:17:21 +0800
In-Reply-To: <22536cac-4731-4b09-b1ba-f69755128665@kernel.org>
References: <20251024075027.3178786-1-edumazet@google.com>
	 <20251024075027.3178786-3-edumazet@google.com>
	 <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com>
	 <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
	 <44b10f91-1e19-48d0-9578-9b033b07fab7@kernel.org>
	 <CANn89iKgqF_9pn6FeyjKtq-oVS-TsYYhvyVRbOs3RzYqXY0DWQ@mail.gmail.com>
	 <CANn89iJThdC=avrdYAfNE4LqRvPtkGS-7fLQdLOYG-ZOTinjRw@mail.gmail.com>
	 <22536cac-4731-4b09-b1ba-f69755128665@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric, Paolo, Matt,

On Fri, 2025-10-24 at 17:27 +0200, Matthieu Baerts wrote:
> On 24/10/2025 16:58, Eric Dumazet wrote:
> > On Fri, Oct 24, 2025 at 7:47 AM Eric Dumazet <edumazet@google.com>
> > wrote:
> > > 
> > 
> > > 
> > > I usually stack multiple patches, and net-next allows for less
> > > merge conflicts.
> > > 
> > > See for instance
> > > https://lore.kernel.org/netdev/20251024120707.3516550-1-edumazet@google.com/T/#u
> > > which touches tcp_rcv_space_adjust(), and definitely net-next
> > > candidate.
> > > 
> > > Bug was added 5 months ago, and does not seem critical to me
> > > (otherwise we would have caught it much much earlier) ?
> > > 
> > > Truth be told, I had first to fix TSO defer code, and thought the
> > > fix
> > > was not good enough.
> > 
> > To clarify, I will send the V2 targeting net tree, since you asked
> > for it ;)
> 
> Thank you very much!
> 
> Note that the bug was apparently more visible with MPTCP, but only
> since
> a few weeks ago, after the modifications on MPTCP side. When I looked
> at
> the issue, I didn't suspect anything wrong on the algorithm that was
> copied from TCP side, because this original code was there for a few
> months (and its author is very trustable :) ). So again, thank you
> for
> having fixed that!

I have just tested and confirmed that this series, together with
Paolo's correction (changing msk->rcvq_space.copied to msk-
>rcvq_space.space in mptcp_rcvbuf_grow()), fixes the simult_flows.sh
issue mentioned in [1].

Thanks,
-Geliang

[1]
https://github.com/multipath-tcp/mptcp_net-next/issues/589

> 
> Cheers,
> Matt


