Return-Path: <netdev+bounces-22645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73277686A0
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 19:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E68281670
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45518100B2;
	Sun, 30 Jul 2023 17:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA0DDD4
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 17:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5549EC433C7;
	Sun, 30 Jul 2023 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690737361;
	bh=JAUR3sFRbOg2SMGbtNjGbeKDHVbKFdpW9UH/mS0Q/8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLNoLa9+6U02LccULUwB085MLo02TmamGXc9MJBaR3xZu9JTJPhbdXasKCSdBOphC
	 hTiSqz3pdeJo7eH9Xs0terqO5sL8YETyjBb9txjbskCC3k1xW3CNFU5oliB976nsiX
	 ezAlYnl9OyccO4SHpwExnVmEHrmwSkTEoBWUv0pz4eZwVMKLTeidavrFkuvtpXKn+O
	 ZMYngLeXlNfnBD+0Y0pblBUwI5RLFpgjDmrj8FfLW4gWdQ7vE2g4h/ycTMiYcImThU
	 1i3gWUX9y5jmgImmond9IxCGabjsDRpDlEGDkvTezzECjcGxDynjWdN17C1vtrLGe7
	 DcLh9UTFL+/dw==
Date: Sun, 30 Jul 2023 19:15:58 +0200
From: Simon Horman <horms@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v1 5/9] netdev-genl: Add netlink framework
 functions for napi
Message-ID: <ZMaaztfofIy7g9Qx@kernel.org>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059163779.3736.7602272507688648566.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169059163779.3736.7602272507688648566.stgit@anambiarhost.jf.intel.com>

On Fri, Jul 28, 2023 at 05:47:17PM -0700, Amritha Nambiar wrote:
> Implement the netdev netlink framework functions for
> napi support. The netdev structure tracks all the napi
> instances and napi fields. The napi instances and associated
> queue[s] can be retrieved this way.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  net/core/netdev-genl.c |  253 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 251 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c

...

>  int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  {
> -	return -EOPNOTSUPP;
> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *netdev;
> +	int idx = 0, s_idx, n_idx;
> +	int h, s_h;
> +	int err;
> +
> +	s_h = ctx->dev_entry_hash;
> +	s_idx = ctx->dev_entry_idx;
> +	n_idx = ctx->napi_idx;
> +
> +	rtnl_lock();
> +
> +	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
> +		struct hlist_head *head;
> +
> +		idx = 0;
> +		head = &net->dev_index_head[h];
> +		hlist_for_each_entry(netdev, head, index_hlist) {
> +			if (idx < s_idx)
> +				goto cont;
> +			err = netdev_nl_napi_dump_entry(netdev, skb, cb, &n_idx);
> +			if (err == -EMSGSIZE)
> +				goto out;
> +			n_idx = 0;
> +			if (err < 0)
> +				break;
> +cont:
> +			idx++;
> +		}
> +	}
> +
> +	rtnl_unlock();
> +
> +	return err;

Hi Amritha,

I'm unsure if this can happen, but if loop iteration occurs zero times
above in such a way that netdev_nl_napi_dump_entry() isn't called, then err
will be uninitialised here.

This is also the case in netdev_nl_dev_get_dumpit
(both before and after this patch.

As flagged by Smatch.

> +
> +out:
> +	rtnl_unlock();
> +
> +	ctx->dev_entry_idx = idx;
> +	ctx->dev_entry_hash = h;
> +	ctx->napi_idx = n_idx;
> +	cb->seq = net->dev_base_seq;
> +
> +	return skb->len;
>  }

...

