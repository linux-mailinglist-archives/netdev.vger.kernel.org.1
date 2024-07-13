Return-Path: <netdev+bounces-111174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113409302D2
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6BE1F244B8
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 00:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649A4A39;
	Sat, 13 Jul 2024 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNI+l+jV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24C1370;
	Sat, 13 Jul 2024 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831543; cv=none; b=bvcrGrpq9E4W5aqHpYhhAP//y50u6QPcWJ4tTN3wvoo5+H0BTb4u2VMTgzc/W29dXpMLntTYM7MfISqAjvrIb0851UstPR8cYfuy+4zqEbjyCS+/4wNxVYj6MqT2QxwoeIPwq9cU7dVD9Ky3SYU7TwhHH+28NEfxqrM2z1PhV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831543; c=relaxed/simple;
	bh=JkYZvMvMjp2C3xzUtYG4+umluvBkVgq5RnDlPgh6Rb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGLxODwqro+J5ZPhwFVkHZ+4dEnnOkusB/Tg3RaB84nNKLAGBYJCKE6iMpLRjcjptb+9oAZ+gih16Ex8UP/LMnKQBiFTFnUbBD6dGDbhL3nRHG9traAKmdrY+8byFNjRHg+JqLkZ7CcrDvAiy+hei87Und7WRMjh+8zVGMfB/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNI+l+jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24ECC32782;
	Sat, 13 Jul 2024 00:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720831543;
	bh=JkYZvMvMjp2C3xzUtYG4+umluvBkVgq5RnDlPgh6Rb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pNI+l+jVLQO2ZHHD7Qzqzrlqal8WL3jR6TNRjk/oHLPkPnLi3dXIhH86TubC3Inas
	 Uml1r8bnNRNacJIpqTRtLmv6FPA/hK9Yq3Y9RWMWmkiaKzLGJ5XrzrzUN7jR6h7ubv
	 PpNIqgeNXlP5XElAz9oFXBGH65rB24tTZIMhBJP+vYG3lykmn2hVI6scoSqq2KveCc
	 QnzSRTJKc1FL9kjTIFoQaU5fyL28qh520mra8c7JS7Vqiuagxkwt22TQ3GR1vT1IZe
	 k7QnpM8/M7EaUssqw1fN0qflrwPYkOZNNNkjxKgqqj5DNoftVCeA4EwD5FAKxNiLqS
	 joFcuJD4/t0KA==
Date: Fri, 12 Jul 2024 17:45:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 rbc@meta.com, horms@kernel.org, virtualization@lists.linux.dev (open
 list:VIRTIO CORE AND NET DRIVERS), netdev@vger.kernel.org (open
 list:NETWORKING DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <20240712174542.4e84508f@kernel.org>
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
References: <20240712115325.54175-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 04:53:25 -0700 Breno Leitao wrote:
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
> 
> 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> 
> 	  __warn+0x12f/0x340
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  report_bug+0x165/0x370
> 	  handle_bug+0x3d/0x80
> 	  exc_invalid_op+0x1a/0x50
> 	  asm_exc_invalid_op+0x1a/0x20
> 	  __free_old_xmit+0x1c8/0x510
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  __free_old_xmit+0x1c8/0x510
> 	  __free_old_xmit+0x1c8/0x510
> 	  __pfx___free_old_xmit+0x10/0x10
> 
> The issue arises because virtio is assuming it's running in NAPI context
> even when it's not, such as in the netpoll case.
> 
> To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> is available. Same for virtnet_poll_cleantx(), which always assumed that
> it was in a NAPI context.
> 
> Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

