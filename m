Return-Path: <netdev+bounces-22933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0993976A15B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19DA1C20CEF
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F671DDD7;
	Mon, 31 Jul 2023 19:37:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C21DDD6
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E695EC433C8;
	Mon, 31 Jul 2023 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690832254;
	bh=+igubzzcF+E+vJODcRuhoZtTXUbV512OQ7Bu9W9uJB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iyms1TmM8j3WlVmmPc7MT1sd4RGfwDqJiRU0H7RcDsg4ER9aUMJ2ECg1PkMvtJhY+
	 sg6kMBWxaZbv1OHkeT7jPXzmC2iDE1LcX1vFafcfFfk+13J7okLSdek/TlMI2rPLjY
	 vwSMtYLPUOZP2rZ9w7QwcTV+UqRLPZ8pV4ctSscsIQbLqRC50x9YVKeW0wTm2eTPeB
	 jao5Ni0KX3BRCXvoM28hvtJHorDTxeMaVdq8QN5luN1vTo8vYKWvVJM8JDCA2ZEBNE
	 A1rdfX9D4YLhFiJ45w97h0IQXqVY6Y4E8CLIaRkM6xx8Q03zttb3Yd4l7gJjzUBTpQ
	 BgoGqpNC2pkbQ==
Date: Mon, 31 Jul 2023 12:37:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v1 5/9] netdev-genl: Add netlink framework
 functions for napi
Message-ID: <20230731123732.5e112027@kernel.org>
In-Reply-To: <169059163779.3736.7602272507688648566.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
	<169059163779.3736.7602272507688648566.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 17:47:17 -0700 Amritha Nambiar wrote:
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

Please rebased on latest net-next you can ditch all this iteration
stuff and use the new xarray.
-- 
pw-bot: cr

