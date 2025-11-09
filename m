Return-Path: <netdev+bounces-237056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C886C44131
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 16:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DB51887942
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA02D6400;
	Sun,  9 Nov 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="jEiMgCWo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11021C6FEC;
	Sun,  9 Nov 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700538; cv=none; b=EABF17KzbnwFRONvd27PYSAaWCXD5jX5e8IFns6VaGUHnjXvbU1EqLCAe0XGE10gNkmNk/FXRrFJdoN/ZhEAxkHBrBwvpu4Nk5oj25GoLdTGKpI1WAjz9KWKI6A4UX2GvUQlZm5MEQinYo0RG3uwGZ1R8JrqHQ0As48QMTyxWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700538; c=relaxed/simple;
	bh=Zkdum5SC2LYxCveNxXgCTkxgnkvhcptGomaCqwYs0vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3p0gIa2MapqaQhEXBKZSQYRkWNmyF9cQHLE4wQFXx7WqHovV3uTiukCN6Ts+P/DBNlV30xuyG/aM+O9rwy5GBbGczZNpNrsiyYB86DSGhU9EYZvbEq0syhlo/Go7XVuSaqlRNHoRhqGVA8+mhoAt64Q/qwlhqZ1lDavIMZ8Lbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=jEiMgCWo; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28ea96279;
	Sun, 9 Nov 2025 23:02:03 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: sd@queasysnail.net
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] xfrm: fix memory leak in xfrm_add_acquire()
Date: Sun,  9 Nov 2025 15:02:02 +0000
Message-Id: <20251109150202.3685193-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aQ8Wj0fIH9KSEKg7@krikkit>
References: <aQ8Wj0fIH9KSEKg7@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6923778903a1kunm581f46c89f1e10
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS00dVktDQx9JTU9PHUNNH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJQk1LSlVKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=jEiMgCWoka534VZyLiHiH7lVaftGNtIJVz4bgv9JPSxnNJJXzwbl9F5x890HJf/h+24fdwnPu45Domtv6qyMWej/0tNgLLqWTnBlu41CDaUhSQoD+RP0ypqjrFrhiEnsRMkoeLjz9S0Y32+S6TayPye8sNlEaveBA6ecMBbnWb0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=99ld6mKGou4R7C7V+AL1YXlKkWyHyUyysFU2gcsegaM=;
	h=date:mime-version:subject:message-id:from;

On Sat, Nov 08, 2025 at 11:08:15AM +0100, Sabrina Dubroca wrote:
> 2025-11-08, 05:10:54 +0000, Zilin Guan wrote:
> > xfrm_add_acquire() constructs an xfrm_policy by calling
> > xfrm_policy_construct(), which allocates the policy structure via
> > xfrm_policy_alloc() and initializes its security context.
> > 
> > However, xfrm_add_acquire() currently releases the policy with kfree(),
> > which skips the proper cleanup and causes a memory leak.
> > 
> > Fix this by calling xfrm_policy_destroy() instead of kfree() to
> > properly release the policy and its associated resources, consistent
> > with the cleanup path in xfrm_policy_construct().
> > 
> > Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> >  net/xfrm/xfrm_user.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index 010c9e6638c0..23c9bb42bb2a 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -3035,7 +3035,7 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	}
> >  
> >  	xfrm_state_free(x);
> > -	kfree(xp);
> > +	xfrm_policy_destroy(xp);
> 
> I agree there's something missing here, but that's not the right way
> to fix this. You're calling this function:
> 
> void xfrm_policy_destroy(struct xfrm_policy *policy)
> {
> 	BUG_ON(!policy->walk.dead);
> [...]
> 
> 
> And xfrm_add_acquire is not setting walk.dead. Have you tested your
> patch?

My apologies, I see the mistake now. To answer your question, I found 
this issue through static analysis and failed to test the patch properly 
before submission.

> Even if we did set walk.dead before calling xfrm_policy_destroy, we
> would still be missing the xfrm_dev_policy_delete call that is done in
> xfrm_policy_kill for the normal policy cleanup path.

Thank you for pointing this out. I agree that the xfrm_dev_policy_delete() 
call is also necessary.

> I think we want something more like what xfrm_add_policy does if
> insertion fails. In xfrm_policy_construct (which you mention in the
> commit message), we don't have to worry about xfrm_dev_policy_delete
> because xfrm_dev_policy_add has either not been called at all, or has
> failed and does not need extra cleanup.
> 
> -- 
> Sabrina

Thank you for the detailed review and suggestion. I will follow the 
error handling pattern in xfrm_add_policy() and prepare a v2 patch 
accordingly.

Best regards,
Zilin Guan

