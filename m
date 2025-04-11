Return-Path: <netdev+bounces-181463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A8A85168
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC38C008C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63092279336;
	Fri, 11 Apr 2025 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUxnZM9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36F1CA84
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337430; cv=none; b=rlaGW5kHlcDEHN503Jy+T8fMw8L+nirSxnr2NmfzDtu7rPt0u99gpEozZRSKTCp2gUPO5qvvjoFmPxL7HTVzEA4vdIlGOpVtcPiFDMm8YUuilejIPp7pCfFASl1wVVDrIv+HXXaSrFoqaST0Dfki7RjyWJZhGTHAWsSxzoK/2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337430; c=relaxed/simple;
	bh=cOqmthV/8ltgapeI+DoVZm6PBvaFbwmX5CsNCLwJRHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOli8Fg8gPEOLBEaYPlWWNpvZqWfi/WSA5tE58m9ADfsgJn9yAAY1J9wIv5JaMElspv7Ra9bW4haYlBljEGbRvCqW1uVV9bfHGXCntVdeF7V7IsbREYHyVQcVJ18Bfuk8rMs37ZV8mTH+KYydxJW086UM/LhxsFvqz552vLMKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUxnZM9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6DEC4CEDD;
	Fri, 11 Apr 2025 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337429;
	bh=cOqmthV/8ltgapeI+DoVZm6PBvaFbwmX5CsNCLwJRHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUxnZM9lpcTYLxs2raRJa6gyz0g085MwtyjFOecevyNgkbuABxWO3xuLqPx4Bz/ys
	 i0ghT6TRj5r9GnvPYvNEP0vzfNoGgmH4s0cML4ITvmIYTU6GcXfQl8cgotVloOamTc
	 l+a0vVuyxd/FODQut77Y+A14wKDt1g5VXmRjWmh8NoLGoPzqQpKjFASc1PsDG4Ghd0
	 F3IhKmuLNRiWXPdF19/RcXRdzRuMkkqh6SA455EYyZf9agojWN6c1C6E6r9xHUB6H/
	 Uz7rpLObcdXgtjBcGzyoELCNuYKZ5wOyFaFvAavsfJu/UL1ygx9KXhSNj8iuUXD7HG
	 12/URaSZyZnWQ==
Date: Thu, 10 Apr 2025 19:10:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <hramamurthy@google.com>, <jdamato@fastly.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 6/8] netdev: depend on netdev->lock for xdp
 features
Message-ID: <20250410191028.31a0eaf2@kernel.org>
In-Reply-To: <20250410171019.62128-1-kuniyu@amazon.com>
References: <20250408195956.412733-7-kuba@kernel.org>
	<20250410171019.62128-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 10:10:01 -0700 Kuniyuki Iwashima wrote:
> syzkaller reported splats in register_netdevice() and
> unregister_netdevice_many_notify().
> 
> In register_netdevice(), some devices cannot use
> netdev_assert_locked().
> 
> In unregister_netdevice_many_notify(), maybe we need to
> hold ops lock in UNREGISTER as you initially suggested.
> Now do_setlink() deadlock does not happen.

Ah...  Thank you.

Do you have a reference to use as Reported-by, or its from a
non-public instance ?

I'll test this shortly:

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b64c614a00c4..891e2f60922f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -38,7 +38,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
        u64 xdp_rx_meta = 0;
        void *hdr;
 
-       netdev_assert_locked(netdev); /* note: rtnl_lock may not be held! */
+       /* note: rtnl_lock may or may not be held! */
+       netdev_assert_locked_or_invisible(netdev);
 
        hdr = genlmsg_iput(rsp, info);
        if (!hdr)
@@ -966,7 +967,9 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
                netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_ADD_NTF);
                break;
        case NETDEV_UNREGISTER:
+               netdev_lock(netdev);
                netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
+               netdev_unlock(netdev);
                break;
        case NETDEV_XDP_FEAT_CHANGE:
                netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_CHANGE_NTF);

