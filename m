Return-Path: <netdev+bounces-269286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO75Ov1su2nGjwIAu9opvQ
	(envelope-from <netdev+bounces-269286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:26:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 457AC2C575E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD09130AB5F4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45408369997;
	Thu, 19 Mar 2026 03:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDhxGOaC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107136895C;
	Thu, 19 Mar 2026 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890811; cv=none; b=HspWslGhj8+6pTBOkjXcix/20SjbESJP0zl5M46A69qY52/cCZE+CrgMqPlFQdYhoSmhV2nwkZES2lfqEljUQlIGxsX2oR7UXCggz8HtnOiHk0+i26jDFM08r1jxIadVrJ5KwwqvGzIf1zvJc2i28omnVvixCBkDpB6pdPsxisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890811; c=relaxed/simple;
	bh=Rtlq0JUZpyBPhjiv3ICVwtSl7cpISD31cuAaRsBhrBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktmcA5TW2Czj7vCbj48QzGBGq4AidfAh2lulbHnfpwFIcjIapjEhDEGrW/kzW17zW1veR82GqQXr6BuqrGyRfLb91+JDK2k2DPilZmPZRSs55YA9UBfB82f0KlebC6eUMybs6Tw/lWEkCQyTGZe1uwrWRDoWgTkJTqDAaRXtq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDhxGOaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B2BC19421;
	Thu, 19 Mar 2026 03:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773890810;
	bh=Rtlq0JUZpyBPhjiv3ICVwtSl7cpISD31cuAaRsBhrBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LDhxGOaCZGaL2Y59/Lzuv/FJ3JjSsKJ4ioxyP905byxA2H62pFxNrxlnWtnqPiEgd
	 NY5cOViSrcQLRJsqmKuD7pQhGidubOth4Knxy2Jfzr3iJReAL0gJmeacKHe5dCNqq0
	 lP3kOvH3Z3BkuWdqNQLYKeBMUOECj2atDalYcPsN4OAA54z0vVxt/3a0sKIuiFTZlj
	 rIOQVzC8ElzqO0lUa6NGeVo9N3kAKx45XGaEGuQQUPj3Y5lvgIS1YCfji3c24kX2lt
	 rSXmRr5rFfkqcmtB5ZS+E+PxkeGxrx4tFQziqPaHhEqzKfhy25d8SbDUzqDWvvgB8M
	 q0oPgEj+KTbfg==
Date: Wed, 18 Mar 2026 20:26:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net/ipv6: mcast: fix circular locking dependency
 in __ipv6_dev_mc_inc()
Message-ID: <20260318202649.004d33fd@kernel.org>
In-Reply-To: <f877e139-2da9-49d9-93bf-9b4155d687a7@linux.dev>
References: <20260317111208.62667-1-jiayuan.chen@linux.dev>
	<20260318181536.47ed9fd1@kernel.org>
	<f877e139-2da9-49d9-93bf-9b4155d687a7@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-269286-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.595];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,afbcf622635e98bf40d2];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 457AC2C575E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 11:04:24 +0800 Jiayuan Chen wrote:
> >> Split mca_alloc() into mca_alloc() + mca_init(): mca_alloc() does the
> >> GFP_KERNEL allocation before mc_lock, mca_init() initializes under
> >> mc_lock. If the address already exists, the pre-allocated memory is
> >> simply freed. Also move inet6_ifmcaddr_notify() outside mc_lock since
> >> it also does GFP_KERNEL allocation.  
> > Moving the allocation seems fine, but also having to move the
> > notification, potentially letting the notification go out of order
> > makes me wonder if we aren't better off adding helpers for taking this
> > lock which also call memalloc_noio_{save,restore} ?  
> Yeah, using memalloc_noio helpers is simpler. I checked and there
> are about 18 places taking mc_lock, so having a common mc_lock()/mc_unlock()
> wrapper that does the noio save/restore covers them all (if necessary).
> 
> The only thing that feels a bit odd is using memalloc_noio in the networking
> subsystem. It makes sense in block/fs to protect itself from recursion.

Totally agree that it feels a bit odd that we have to worry about IO,
but unless we can figure out a way to prevent nbd sockets from getting
here all our solutions are dealing with noio in networking code :(
IMHO it's better to acknowledge this with the explicit memalloc_noio 
so future developers don't break things again with a mis-placed
allocation.

