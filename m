Return-Path: <netdev+bounces-183110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE54CA8AE54
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282AC189CC2E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3872063D5;
	Wed, 16 Apr 2025 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgCEdIj7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D12746D
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744772369; cv=none; b=SuIp44ew3y4ur2NmHB5ypxtfPsGP/lu9yDAclatiayZIMIZFbZqUK+xAMIXyfcBpeQhp4ZSbjG5SC2T3MdxcxyngCS/PjFM9Mr7olYYOe8a0jpekeImGsVLplnVFTDciAjkWFDp65CsuWlVmOz4TiXjd/wHM1JyNAK70AoXNWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744772369; c=relaxed/simple;
	bh=B2Wp38bw4pvphWYcTvzA/EeIuzqBi3Ignipw1SSrm+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYli+obeepRds7kh9quINCsaAXhsOoLfnm/qGoUNu0cfVd2iX5zD3Ngnnl6eM6X1zS20gb80g6xfHogIeUWeGzlkqird6HYGJpVJW5bmlw8M61qFxPPBtuD/zjOVzDZYnlwPC8WnJqlIzIW+usNESw43k2nj6wOuGxryOJS1Wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgCEdIj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B59C4CEEB;
	Wed, 16 Apr 2025 02:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744772368;
	bh=B2Wp38bw4pvphWYcTvzA/EeIuzqBi3Ignipw1SSrm+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgCEdIj7rtgZaoHp6Paj1ZZACkCr8dSC+v+A0FWPECKc81lniOmpC2rF3UQ5cff8X
	 Bp5Y0qz+5/W/C0szjN/5xjW3NNxTa9r+RFLrXDQ/nIlGHUwVG4jPUMorjep4YfqaAT
	 H4oitKAEXmpJjkJoyOhc/CdxDk/jfYTel7r6ceabZpfdOx5czttsQHghuCFAuZkLTW
	 iiLXd/zPWadMFlAw91VQLAP8okUEtfFq3FPtHICPKK9pkzsJ3sxotdYk6PKZ2i8wJ5
	 WABHdGOGUbLdOgAfCpfl7kobB2e4b5yFQFPylav85UlzQ7hizExRgiaQCSsy8fyGSn
	 UpspHBgCydktQ==
Date: Tue, 15 Apr 2025 19:59:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, asml.silence@gmail.com,
 dw@davidwei.uk, sdf@fomichev.me, skhawaja@google.com,
 simona.vetter@ffwll.ch, kaiyuanz@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250415195926.1c3f8aff@kernel.org>
In-Reply-To: <Z_6snPXxWLmsNHL5@mini-arch>
References: <20250415092417.1437488-1-ap420073@gmail.com>
	<CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
	<Z_6snPXxWLmsNHL5@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 11:59:40 -0700 Stanislav Fomichev wrote:
> > commit 42f342387841 ("net: fix use-after-free in the
> > netdev_nl_sock_priv_destroy()") and rolling back a few fixes, it's
> > really introduced by commit 1d22d3060b9b ("net: drop rtnl_lock for
> > queue_mgmt operations").
> > 
> > My first question, does this issue still reproduce if you remove the
> > per netdev locking and go back to relying on rtnl_locking? Or do we
> > crash somewhere else in net_devmem_unbind_dmabuf? If so, where?
> > Looking through the rest of the unbinding code, it's not clear to me
> > any of it actually uses dev, so it may just be the locking...  
>  
> A proper fix, most likely, will involve resetting binding->dev to NULL
> when the device is going away.

Right, tho a bit of work and tricky handling will be necessary to get
that right. We're not holding a ref on binding->dev.

I think we need to invert the socket mutex vs instance lock ordering.
Make the priv mutex protect the binding->list and binding->dev.
For that to work the binding needs to also store a pointer to its
owning socket?

Then in both uninstall paths (from socket and from netdev unreg) we can
take the socket mutex, delete from list, clear the ->dev pointer,
unlock, release the ref on the binding.

The socket close path would probably need to lock the socket, look at 
the first entry, if entry has ->dev call netdev_hold(), release the
socket, lock the netdev, lock the socket again, look at the ->dev, if
NULL we raced - done. If not NULL release the socket, call unbind.
netdev_put(). Restart this paragraph.

I can't think of an easier way.

> Replacing rtnl with dev lock exposes the fact that we can't assume
> that the binding->dev is still valid by the time we do unbind.

Note that binding->dev is never accessed by net_devmem_unbind_dmabuf().
So if the device was unregistered and its queues flushed, the only thing
we touch the netdev pointer for is the instance lock :(


