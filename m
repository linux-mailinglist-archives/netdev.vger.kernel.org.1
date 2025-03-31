Return-Path: <netdev+bounces-178246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB0A75DB6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 03:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2BF3A8DA9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 01:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF751EF01;
	Mon, 31 Mar 2025 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="STo2JnEC"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291836F073
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743386040; cv=none; b=MQGEL+7hRUZiGDv+jaCyO+/ykPAORVSE6uEOwhF/6AWAH3TF7/kYtq4pyVDcJpyRWL8nY4u1KpPZReUE5wuHOTiQ3UcchylR/7jOplLD9Bnuhx75c9nXczf5opcVbnTxhV/saZYj7BoOzTm7nTdVODWCdcTO3WsMCaKgChSsT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743386040; c=relaxed/simple;
	bh=Ero1N606ga4VPqMCdd6OYls3Rtn0az7DjDoYWKv6Fmg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=lBcWtmJP9T7jUMMqNBfMTdVW74Oui3ctBmsdyPAqv8iLagCW/OTO0TaklEfdgY22YBTmxB7MCIW1g4+fGWJtPVNiXuwfW8wIcyFv5wSNfEld3Ym0ggOJLfYcMinCiJ9wmR3L3ZNAy2OOChH6L33Cj+BfgHpjg4ewO706YGivsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=STo2JnEC; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743386034; h=Message-ID:Subject:Date:From:To;
	bh=SE5OPysL4e7VAggg0N3tcQm/1ihoYJqgruA9uRmvSKg=;
	b=STo2JnEChOpKKDfVKHw7dIS8j6GUMWQdh3pDwmlFYPRGX2PqP8bcZZ0R5YpIs5vqF/Ab9VmOEimUgfkqOqhkBulMXG3HWXe7es80JHmovkOcxYeEaBAzwrPKdMX8K9rDHJQndP1a9XCDP+Vt/+ZoXg49Y3JLNz4vU6oSeSMEO/M=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WTOTdp8_1743386033 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 09:53:54 +0800
Message-ID: <1743386027.4868433-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] net: fix use-after-free in the netdev_nl_sock_priv_destroy()
Date: Mon, 31 Mar 2025 09:53:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: jdamato@fastly.com,
 sdf@fomichev.me,
 almasrymina@google.com,
 ap420073@gmail.com,
 davem@davemloft.net,
 kuba@kernel.org,
 pabeni@redhat.com,
 edumazet@google.com,
 andrew+netdev@lunn.ch,
 horms@kernel.org,
 netdev@vger.kernel.org
References: <20250328062237.3746875-1-ap420073@gmail.com>
In-Reply-To: <20250328062237.3746875-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 28 Mar 2025 06:22:37 +0000, Taehee Yoo <ap420073@gmail.com> wrote:
> In the netdev_nl_sock_priv_destroy(), an instance lock is acquired
> before calling net_devmem_unbind_dmabuf(), then releasing an instance
> lock(netdev_unlock(binding->dev)).
> However, a binding is freed in the net_devmem_unbind_dmabuf().
> So using a binding after net_devmem_unbind_dmabuf() occurs UAF.
> To fix this UAF, it needs to use temporary variable.
>
> Fixes: ba6f418fbf64 ("net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  net/core/netdev-genl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index fd1cfa9707dc..3afeaa8c5dc5 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -951,12 +951,14 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
>  	struct net_devmem_dmabuf_binding *temp;
> +	struct net_device *dev;
>
>  	mutex_lock(&priv->lock);
>  	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
> -		netdev_lock(binding->dev);
> +		dev = binding->dev;
> +		netdev_lock(dev);
>  		net_devmem_unbind_dmabuf(binding);
> -		netdev_unlock(binding->dev);
> +		netdev_unlock(dev);
>  	}
>  	mutex_unlock(&priv->lock);
>  }
> --
> 2.34.1
>

