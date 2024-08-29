Return-Path: <netdev+bounces-123520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D99652A0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F8AB23E0E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CB51BAEE9;
	Thu, 29 Aug 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA2IfzL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8731BAEE2;
	Thu, 29 Aug 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969104; cv=none; b=ubCsSXOtDv1YhaQP2312ZE5h0BVA4gZZP52Dlzr18bNL3hgZRP9rOImkBbWRL1AqMgWWMFyc39fWOLHhSusjBkYejFhuVyoXJKwuQ217CkKOwkX5+bartB/4Yg8aXspngEFkYhBxjkxD5cbe9tqYfkgTYVIcgW+ihgvYmXtVwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969104; c=relaxed/simple;
	bh=/XN9wOarhWdEVb6Lxab11NuoNZZbS0oVSdGa1YKfFFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZd6dmi1/AV1WcTESdI7UDB+8nIQHXpVLjKeVJqDVRh/c7XzbvwWo0H95ax7VGfGbC7Vu6zgkC+2Zbr15A5tUxncvl8BEVTgM5JkSBZxvkQxXdN3FUCsYrEJKpNjrSaHkMhTzYV3AdDlGsQtsRKLmdJ8O8ujf1OKy2aL43oqd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA2IfzL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2C8C4CEC1;
	Thu, 29 Aug 2024 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724969104;
	bh=/XN9wOarhWdEVb6Lxab11NuoNZZbS0oVSdGa1YKfFFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QA2IfzL4j+xRXaSTl7yMvdQdOClCFx9I4DIBAm64anbNhDDxvfWqNnX7YYkna8Raw
	 FD8woPjBxR5P+klZMS7NpEF5iWJjw/JMCiENxSHQcZNWomrXaKmue1c/3y07efvwlX
	 N1UST5WN7RFBbYIdCF2iyyYq3b2aB6+8jZFqy/QQAA0z566ZLsFSl5ZfS/eT0GHa82
	 i7WS7sr6kv9zy+XbffHpzvwtjljD+TrK9wmjGXf86v2+AuPde2KkHQmrPwUIzPvL8h
	 SRq5K1nM6MPL/uNEC7x9xb4U8sWlipsWIR836BLjchig/hwrXqGfdNfjw+mWFqnMjM
	 mp9jhBvc1cvgg==
Date: Thu, 29 Aug 2024 15:05:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Breno Leitao <leitao@debian.org>,
 Johannes Berg <johannes.berg@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 1/5] net: napi: Make napi_defer_hard_irqs
 per-NAPI
Message-ID: <20240829150502.4a2442be@kernel.org>
In-Reply-To: <20240829131214.169977-2-jdamato@fastly.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 13:11:57 +0000 Joe Damato wrote:
> +/**
> + * napi_get_defer_hard_irqs - get the NAPI's defer_hard_irqs
> + * @n: napi struct to get the defer_hard_irqs field from
> + *
> + * Returns the per-NAPI value of the defar_hard_irqs field.
> + */
> +int napi_get_defer_hard_irqs(const struct napi_struct *n);
> +
> +/**
> + * napi_set_defer_hard_irqs - set the defer_hard_irqs for a napi
> + * @n: napi_struct to set the defer_hard_irqs field
> + * @defer: the value the field should be set to
> + */
> +void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
> +
> +/**
> + * netdev_set_defer_hard_irqs - set defer_hard_irqs for all NAPIs of a netdev
> + * @netdev: the net_device for which all NAPIs will have their defer_hard_irqs set
> + * @defer: the defer_hard_irqs value to set
> + */
> +void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);

Do you expect drivers or modules to call these?
I'm not sure we need the wrappers just to cover up the READ/WRITE_ONCE()
but if you do want to keep them they can be static inlines in
net/core/dev.h

nit: IIUC the kdoc should go on the definition, not the declaration.

