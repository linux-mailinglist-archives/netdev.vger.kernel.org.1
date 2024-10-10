Return-Path: <netdev+bounces-133974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE199796D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E9B1C21AC6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D53D7A;
	Thu, 10 Oct 2024 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTJI3SJR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05236C;
	Thu, 10 Oct 2024 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518465; cv=none; b=bLoJCEqBDSpLUmqbT0ijnhDk9gLyU/xDEqsdPoFn2EBUEXJwTJQ0TA5dfUIXO9zFXIMoWjTp94rmj8a01kC4Njk/HDDcwovFw7DshIsI5os4VFJaVzYyvL4zRTglgfDUIlHFvMhi5kddB4tmiPiH2zwYfdrzqaoifULd0/rm1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518465; c=relaxed/simple;
	bh=dr2LfrrEzJmigC9ayHJC4QWG19jmWEVbmR0xRv/38xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUhBbcfLe6e71O+AMDDdM8AcbFQCj4fhV5rslxn2sPyYfy1T9YrrAIthOg7ZttpgtrwSypRpzfUNgndJSiNyVf7T/pGwgxT+EGJpkstNlpH8s8Rrjq0OJYZ3A0teJudJrwKjOGeN+eDKFAYqtmz6Kp9UuLmjnSAOJGCADDpKO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTJI3SJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E348C4CECD;
	Thu, 10 Oct 2024 00:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728518464;
	bh=dr2LfrrEzJmigC9ayHJC4QWG19jmWEVbmR0xRv/38xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XTJI3SJR+XkmjG4/z0dQeNBgU1dMp3gSFYEShLQ6ZuSHtZZ6syHCBQfFy9/NpW5Ij
	 toDP0PxtZVpQSMDEGMQZWUMPMKmrmNv4p1u67XlgxLFXpyzeAAhwz7NndHcjQPWUBN
	 +OXWy8IVAPJQIpIXtFjhKyhCEvsvQaJqpHpBu+VYMsRsSa6RrVVB7acXSkwvdG2euT
	 CIskZESML2QpmzlcAM0uMhDoK4OdrumwJVqXanjtR9BYlFjkxBMZFntb/TUw8T2t+2
	 xZLbd+i+OjFzaKOzL54Yk4z9SRgqaA52b84lDB+JuTSbzyir5B6Gfr2159VSD72EpR
	 kB56xfftfdWNQ==
Date: Wed, 9 Oct 2024 17:01:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>, Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com, kory.maincent@bootlin.com,
 andrew@lunn.ch, maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory
 tcp
Message-ID: <20241009170102.1980ed1d@kernel.org>
In-Reply-To: <CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-8-ap420073@gmail.com>
	<CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
	<CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
	<20241008125023.7fbc1f64@kernel.org>
	<CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 00:37:49 +0900 Taehee Yoo wrote:
> > Yes, but netmem_ref can be either a net_iov or a normal page,
> > and skb_add_rx_frag_netmem() and similar helpers should automatically
> > set skb->unreadable or not.
> >
> > IOW you should be able to always use netmem-aware APIs, no?  
> 
> I'm not sure the update skb->unreadable flag is possible because
> frag API like skb_add_rx_frag_netmem(), receives only frag, not skb.
> How about an additional API to update skb->unreadable flag?
> skb_update_unreadable() or skb_update_netmem()?

Ah, the case where we don't get skb is because we're just building XDP
frame at that stage. And XDP can't be netmem.

In that case switching to skb_frag_fill_netmem_desc() should be enough.

> > > The reason why the branch exists here is the PP_FLAG_ALLOW_UNREADABLE_NETMEM
> > > flag can't be used with PP_FLAG_DMA_SYNC_DEV.  
> >
> > Hm. Isn't the existing check the wrong way around? Is the driver
> > supposed to sync the buffers for device before passing them down?  
> 
> I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
> for dmabuf may be wrong.
> I think device memory TCP is not related to this flag.
> So device memory TCP core API should not return failure when
> PP_FLAG_DMA_SYNC_DEV flag is set.
> How about removing this condition check code in device memory TCP core?

I think we need to invert the check..
Mina, WDYT?

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..c5cace3f9831 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -331,12 +331,6 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	if (!binding)
 		return -EINVAL;
 
-	if (!pool->dma_map)
-		return -EOPNOTSUPP;
-
-	if (pool->dma_sync)
-		return -EOPNOTSUPP;
-
 	if (pool->p.order != 0)
 		return -E2BIG;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..c8dbbf262de3 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,6 +287,12 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_priv) {
+		if (!pool->dma_map || !pool->dma_sync)
+			return -EOPNOTSUPP;
+
+		/* Memory provider is responsible for syncing the pages. */
+		pool->dma_sync = 0;
+
 		err = mp_dmabuf_devmem_init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,

