Return-Path: <netdev+bounces-125300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3E96CB68
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D14E1C21401
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A86F17BEA7;
	Wed,  4 Sep 2024 23:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbsngpK3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518E13A869;
	Wed,  4 Sep 2024 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494060; cv=none; b=bY7SRfW7tlQUp0zOu28s9w7SO7EMfUYgFaZgmX81BjzvgfgtEGZrsAIoShlR2uVFD18iK4/as1SxTzWlLy17kPLdLvm8EyvozulY99iN+aag1BpQXoT6YBqlLaNDKPr/XRgjVHmhzOS/1kKqF3oKUeHX5Kv3CVpac8p43qhuH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494060; c=relaxed/simple;
	bh=tp6w30st3IHF5zYKbUXxaoqZn/KFqYIevLoCWOPpQb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Shdb31t9vQjuCD2MqbdXFo6w3lTkCNCV0UGYotanf2JZEI2vaqlEtTrCrLNsdTTbvrepd1EoxqMgp9rUnOrU+s7y4wXwZE54pMzruoOvEvSpQOCQZ9hNmIDMvRGLIyJ7kHxjpoIfeHg20oClEz21OGg/FQ7bUmPhBYwrfHMvV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbsngpK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF2CC4CEC2;
	Wed,  4 Sep 2024 23:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725494059;
	bh=tp6w30st3IHF5zYKbUXxaoqZn/KFqYIevLoCWOPpQb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RbsngpK33XqyaasFSl8p+F/Y3m3SWPVYft9nBxc5y4X9oRUWVZz8LD7XbZbPBfXGn
	 MilvYrNm4rpLUQ660Jy2AQKNZpcBTNmejpTuCQdX6c/MfVJnP48lE1PtxiLCVHhUZs
	 Q8LvQgVZImE347m3uaJ4q0lydrCM0Yph9bCnVWxmk3HnTVMmnTjQoQzRTywg2xmRdu
	 oF5L7UlbtxHLL0QHBnxTVNHL30B1WoHSTlSuDr1e9KjyF8W5qss+CtcOoJp1faRYwu
	 JtZuI1eY4SS1W3BTVNvWngkpJbuA9rOMPVo09HzjOU6Jh5Zxkhxpl+XjHUTIt4Oaoe
	 2sZnHd6hZchRQ==
Date: Wed, 4 Sep 2024 16:54:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20240904165417.015c647f@kernel.org>
In-Reply-To: <Ztjv-dgNFwFBnXwd@mini-arch>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-6-jdamato@fastly.com>
	<20240829153105.6b813c98@kernel.org>
	<ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
	<20240830142235.352dbad5@kernel.org>
	<ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
	<Ztjv-dgNFwFBnXwd@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 16:40:41 -0700 Stanislav Fomichev wrote:
> > I think what you are proposing seems fine; I'm just working out the
> > implementation details and making sure I understand before sending
> > another revision.  
> 
> What if instead of an extra storage index in UAPI, we make napi_id persistent?
> Then we can keep using napi_id as a user-facing number for the configuration.
> 
> Having a stable napi_id would also be super useful for the epoll setup so you
> don't have to match old/invalid ids to the new ones on device reset.

that'd be nice, initially I thought that we have some drivers that have
multiple instances of NAPI enabled for a single "index", but I don't
see such drivers now.

> In the code, we can keep the same idea with napi_storage in netdev and
> ask drivers to provide storage id, but keep that id internal.
> 
> The only complication with that is napi_hash_add/napi_hash_del that
> happen in netif_napi_add_weight. So for the devices that allocate
> new napi before removing the old ones (most devices?), we'd have to add
> some new netif_napi_takeover(old_napi, new_napi) to remove the
> old napi_id from the hash and reuse it in the new one.
> 
> So for mlx5, the flow would look like the following:
> 
> - mlx5e_safe_switch_params
>   - mlx5e_open_channels
>     - netif_napi_add(new_napi)
>       - adds napi with 'ephemeral' napi id
>   - mlx5e_switch_priv_channels
>     - mlx5e_deactivate_priv_channels
>       - napi_disable(old_napi)
>       - netif_napi_del(old_napi) - this frees the old napi_id
>   - mlx5e_activate_priv_channels
>     - mlx5e_activate_channels
>       - mlx5e_activate_channel
>         - netif_napi_takeover(old_napi is gone, so probably take id from napi_storage?)
> 	  - if napi is not hashed - safe to reuse?
> 	- napi_enable
> 
> This is a bit ugly because we still have random napi ids during reset, but
> is not super complicated implementation-wise. We can eventually improve
> the above by splitting netif_napi_add_weight into two steps: allocate and
> activate (to do the napi_id allocation & hashing). Thoughts?

The "takeover" would be problematic for drivers which free old NAPI
before allocating new one (bnxt?). But splitting the two steps sounds
pretty clean. We can add a helper to mark NAPI as "driver will
explicitly list/hash later", and have the driver call a new helper
which takes storage ID and lists the NAPI in the hash.

