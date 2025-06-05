Return-Path: <netdev+bounces-195261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CE5ACF19B
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF20C3AD63C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0B1E519;
	Thu,  5 Jun 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sE5gACtk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4151A275
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132990; cv=none; b=cMljE5fmyCHti+uRZ4ZEcI7XbhqJXTqmthRz8+2a5v09fgT6WcPHeFV4gVXcSQ5sDQ8nNLAdiw6OM0yHJx/R424WGB+F6ntaY3PHX9AG5Uym33U0O6Btl6fM3G5L5VYfbeefb5jF1AEQfuXBafsnUOvVsCvUKc1m9eiisfs6Z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132990; c=relaxed/simple;
	bh=6M3R4u3mEbS+qldJiabVnqkJGNOsv9dAzeJKcvL9aEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awcZp6eOBRjRghFx/ejx7zVebZqoFkoJWCj8uxy4hyjbZXu8fxlL6tlk5Bag05+DoTZs/5Z1pKsrb8+kueHrO8YiaN+TiWudlFui3xKlKO8EokyduXLY7DcH27I+wNIpnYMMDyBd+srQP+eGNk9lLRCy5kx9j7BsgDg1OfJyi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sE5gACtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109B1C4CEE7;
	Thu,  5 Jun 2025 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749132989;
	bh=6M3R4u3mEbS+qldJiabVnqkJGNOsv9dAzeJKcvL9aEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sE5gACtkSNjSUznsqUTkGO+AKJfLvvWNKts3vAmwOgofp2yPCyC/Zbk4M0WHnmuux
	 mTTxHsuxe8hzd6L6K1YSAsz6buiozpD6PzXPEK1sIZx7LuGaC/THVyGGsjvdWIBtN/
	 K2ovtwjvqIkjPrbCbfVS7vk+YGxAq4OnlkVQbYXXzrp2Jdp6OQNXf65Lpj/WNpzNbi
	 Dasaoq3pkKiJycZQu9seB04r02xO+DQ4SA2mSIvD7tDPUypWwj4xAMVueAMB8l1BLb
	 /RPI/OXv9blOjvuVvD0CUZhQeWYUtqyQvCwxzYzoy6xfBmbiZHj7SH73NLAnuDmjO9
	 91Nck6CQ1YCNQ==
Date: Thu, 5 Jun 2025 17:16:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-next v1 1/5] xfrm: delay initialization of offload
 path till its actually requested
Message-ID: <20250605141624.GG7435@unreal>
References: <cover.1739972570.git.leon@kernel.org>
 <3a5407283334ffad47a7079f86efdf9f08a0cda7.1739972570.git.leon@kernel.org>
 <aEGW_5HfPqU1rFjl@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEGW_5HfPqU1rFjl@krikkit>

On Thu, Jun 05, 2025 at 03:09:19PM +0200, Sabrina Dubroca wrote:
> Hello,
> 
> I think we need to revert this patch. It causes a severe performance
> regression for SW IPsec (around 40-50%).
> 
> 2025-02-19, 15:50:57 +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > XFRM offload path is probed even if offload isn't needed at all. Let's
> > make sure that x->type_offload pointer stays NULL for such path to
> > reduce ambiguity.
> 
> x->type_offload is used for GRO with SW IPsec, not just for HW offload.

Thanks for the report, can you please try the following fix?

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a21e276dbe447..e45a275fca26d 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -474,7 +474,7 @@ struct xfrm_type_offload {

 int xfrm_register_type_offload(const struct xfrm_type_offload *type, unsigned short family);
 void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, unsigned short family);
-void xfrm_set_type_offload(struct xfrm_state *x);
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load);
 static inline void xfrm_unset_type_offload(struct xfrm_state *x)
 {
        if (!x->type_offload)
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 81fd486b5e566..d2819baea414f 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -305,7 +305,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
                return -EINVAL;
        }

-       xfrm_set_type_offload(x);
        if (!x->type_offload) {
                NL_SET_ERR_MSG(extack, "Type doesn't support offload");
                dev_put(dev);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 203b585c2ae28..2da7281f8344b 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -424,11 +424,10 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
 }
 EXPORT_SYMBOL(xfrm_unregister_type_offload);

-void xfrm_set_type_offload(struct xfrm_state *x)
+void xfrm_set_type_offload(struct xfrm_state *x, bool try_load)
 {
        const struct xfrm_type_offload *type = NULL;
        struct xfrm_state_afinfo *afinfo;
-       bool try_load = true;
 
 retry:
        afinfo = xfrm_state_get_afinfo(x->props.family);
@@ -607,6 +606,7 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
        kfree(x->coaddr);
        kfree(x->replay_esn);
        kfree(x->preplay_esn);
+       xfrm_unset_type_offload(x);
        if (x->type) {
                x->type->destructor(x);
                xfrm_put_type(x->type);
@@ -780,8 +780,6 @@ void xfrm_dev_state_free(struct xfrm_state *x)
        struct xfrm_dev_offload *xso = &x->xso;
        struct net_device *dev = READ_ONCE(xso->dev);
 
-       xfrm_unset_type_offload(x);
-
        if (dev && dev->xfrmdev_ops) {
                spin_lock_bh(&xfrm_state_dev_gc_lock);
                if (!hlist_unhashed(&x->dev_gclist))
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 59f258daf8305..1db18f470f429 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -977,6 +977,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
        /* override default values from above */
        xfrm_update_ae_params(x, attrs, 0);
 
+       xfrm_set_type_offload(x, attrs[XFRMA_OFFLOAD_DEV]);
        /* configure the hardware if offload is requested */
        if (attrs[XFRMA_OFFLOAD_DEV]) {
                err = xfrm_dev_state_add(net, x,


> 
> -- 
> Sabrina

