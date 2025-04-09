Return-Path: <netdev+bounces-180559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202D0A81ABF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6C14489DE
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A095315A858;
	Wed,  9 Apr 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfoMn3CQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDD41C64;
	Wed,  9 Apr 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163798; cv=none; b=EuEhSDeyppOrPUICt0XNwc4+R1lM68veb1o94/+ya+FrGscTEU6tvXJOlH6G/QvTfoxnZHv0jQZEfkuJlQG1xD8PDlNuahLGSYMs7qi8ByRgguq6EoFQ44z2Umdi18+N8waTd/409c0C8bUAESmkf6J2YPJ3wszmsnGuq5aAk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163798; c=relaxed/simple;
	bh=wogBXxkmsq3n6cxuOkr4dWeKoE8pceAArRWdt5jRii0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUeXHD0KWddxy7DgYWEUw9nNi1LrxmD1vYlJFxhiYqGt41Zegc/259YxQcIVySkQmvlkFOi3WPyP+Jz8d999Z2BUX9bkHa5qq1/4k4jct+v82+wLUUno94PZfVnoo60O4s2FE/OturVxwuneWja9ZJKSifJU25YFBXSmKQvgGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfoMn3CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B08BC4CEE5;
	Wed,  9 Apr 2025 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744163797;
	bh=wogBXxkmsq3n6cxuOkr4dWeKoE8pceAArRWdt5jRii0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XfoMn3CQHTxmeQ1ImWN9K8y9ucQsl21HGJp6PZCeHP81G1p7IUoHpSD4njlk0c1cK
	 /Fi7GrNqDeiKru3e1CMv5ZlOPhd+hrgJ9emtXKbYM6hUzOv883gUBts+dYwV3kx9tl
	 U3kUSUR7QOAhvOE2ihXf5/kVkenICTxS2umKVdnHhkCvErvwftYUPh6z06/BVFFzwK
	 gxsrzdLZ6+RMctQLdEsrWmlnCEUACFyzOgIetfA0dR9rMUDzvcP/BZlEe2sk0LGy8I
	 0O+gu1Rld63KfX0ORKeicG/BMtMc07TrP23nhZRZg532z0KmWQU6oZZfR22yLeE0Jb
	 TIMD/VyaWFPVA==
Date: Tue, 8 Apr 2025 18:56:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Paolo Abeni <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Yunsheng Lin
 <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next v3 0/4] page_pool: Convert stats to
 u64_stats_t.
Message-ID: <20250408185636.4adc61fb@kernel.org>
In-Reply-To: <20250408105922.1135150-1-bigeasy@linutronix.de>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 12:59:17 +0200 Sebastian Andrzej Siewior wrote:
> I don't know if it is ensured that only *one* update can happen because
> the stats are per-CPU and per NAPI device. But there will be now a
> warning on 32bit if this is really attempted in preemptible context.

I think recycling may happen in preemptible context, and from BH.
Have you tried to test?
The net.core.skb_defer_max sysctl may mask it for TCP traffic.

