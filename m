Return-Path: <netdev+bounces-102095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E30A90165C
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071A228177B
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED4642ABB;
	Sun,  9 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C8YNtAKo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F31CD39;
	Sun,  9 Jun 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943535; cv=none; b=POjZxEjWQpniIb6x/S4bJKvORipCqWUNvGRJhIKBhh/mip4uVNitAzCNjZAW9DNWuuzT/CmpEem6RRzMmQMqGwhwuOQznvAn/xqAkrCfzhj5NEjrUajibRz0qeV+j/BRye8ncqlyE/AorK74SSorF1mBKU2jr0ST8web4r6ClKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943535; c=relaxed/simple;
	bh=OGc4ydJ4eusmUomyVU3xWXMC6r5K28VTQsQGs5He7n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiXNuddWCaq4KvQmuOGoOujKJB1ONvRxc74sHuycTOg46RQoFINnG39Z9VO1KA95b81LTdQAxvEgJ8pYHdtWDI/DtwevKlekkIvcWTJvQbaKS+LzEvXsLdPNq/fPlPu3z0BR+EaTcAMWqzHrHKeegDm+PMv2NahBzjRNh2qkRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=C8YNtAKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166C0C2BD10;
	Sun,  9 Jun 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C8YNtAKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717943530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OGc4ydJ4eusmUomyVU3xWXMC6r5K28VTQsQGs5He7n4=;
	b=C8YNtAKo6799q3e2teULRncHewZjDG0PKWBml2ejuraEwPqTBCR0yckV5DJavzJ+nyu39/
	p5Y8SEhy3MfwXFtokJDEaF5FFt7M7tNjrCxDKO5ZMoCGZV3dWJxOCcWWyoxcBduKRF7+kR
	EBoEJdoiM9FQ0K01sCrsLnMnVZ/d3AQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 979f40c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Jun 2024 14:32:09 +0000 (UTC)
Date: Sun, 9 Jun 2024 16:32:06 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 01/14] wireguard: allowedips: replace call_rcu by
 kfree_rcu for simple kmem_cache_free callback
Message-ID: <ZmW85kuO2Eje6gE9@zx2c4.com>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-2-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240609082726.32742-2-Julia.Lawall@inria.fr>

Hi Julia & Vlastimil,

On Sun, Jun 09, 2024 at 10:27:13AM +0200, Julia Lawall wrote:
> Since SLOB was removed, it is not necessary to use call_rcu
> when the callback only performs kmem_cache_free. Use
> kfree_rcu() directly.

Thanks, I applied this to the wireguard tree, and I'll send this out as
a fix for 6.10. Let me know if this is unfavorable to you and if you'd
like to take this somewhere yourself, in which case I'll give you my
ack.

Just a question, though, for Vlastimil -- I know that with the SLOB
removal, kfree() is now allowed on kmemcache'd objects. Do you plan to
do a blanket s/kmem_cache_free/kfree/g at some point, and then remove
kmem_cache_free all together?

Jason

