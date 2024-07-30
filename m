Return-Path: <netdev+bounces-113894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961E5940452
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E7B1C20F4B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9722A20326;
	Tue, 30 Jul 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7K5hAhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBADDDBC;
	Tue, 30 Jul 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305760; cv=none; b=R3Gni019brk/kWiMvwYrBCghYo3Roir3cXSipxqo5hzHJEvROS76nXx4C1sp47bRq61tzH3uy2Y8FW8uRUXxLOS83Pdsv8hObLzSL6unvtxtGAO0+DYWVfvBTH3EzxwYTA6vQjzLmpC40uOFCpgebNi+jX/fXgUQDmds3fdiECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305760; c=relaxed/simple;
	bh=20eNhG0o3qwpa7TUPIaF4+N+FPxO7gS4x/a475jXxaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfEKof2+5tLroY4XeDP7jdOyPgpx5XgRU26hiw6Kv12PF9cZBnVY31rk9bcH0KDXudkNHW3tBGiYoNJks/lHpNhpWW/0lfov4igTC2ZFJuxMlkQL9ttS0O5OW9nUmEngdNd733usiIMSL4dhhtKOPhIwR6CErfUBoOiyGlh2y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7K5hAhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40C6C32786;
	Tue, 30 Jul 2024 02:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305760;
	bh=20eNhG0o3qwpa7TUPIaF4+N+FPxO7gS4x/a475jXxaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R7K5hAheLAKL0FYQAhxs+u1RuYApRstqMaPxE/UsSEYzUgYFzj6agVt4KigYn0OHV
	 wnuhopUO1/oyA8nAljibbSe8GzIgJFOYePu4YdGypwKVOSu3qqPnUZFK96gXBLzZpW
	 OhG+YPhDg83s8vAPe39bCJ5+z1OSyFrxqLJNhwETNhWQkAyMbYqlrkCDoqleNBhD+F
	 PV3uiqziWk8/QKW9NDvJbxFofAjwfQ7iME/QTA4iTKqPnhhmq35oIooJJttn5m4vpY
	 bO6I0p8R/67BPVz9SO/Gb7p7ub+QgYKU1QaSKwXzaeHNJhdXkbnk13cgXkDL78z2gD
	 m9Z3w93X3Beog==
Date: Mon, 29 Jul 2024 19:15:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v25 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <20240729191559.1683ec63@kernel.org>
In-Reply-To: <20240729062121.335080-3-justinlai0215@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
	<20240729062121.335080-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 14:21:10 +0800 Justin Lai wrote:
> +	page = page_pool_dev_alloc_pages(tp->page_pool);
> +	if (!page) {
> +		netdev_err(tp->dev, "failed to alloc page\n");
> +		goto err_out;
> +	}
> +
> +	buf_addr = page_address(page);
> +	mapping = page_pool_get_dma_addr(page);
> +
> +	skb = build_skb(buf_addr, PAGE_SIZE);

Don't build_skb() before packet was received.

One of the benefits of build_skb() is that the skb is supposed
to be more likely to be still in CPU cache.

