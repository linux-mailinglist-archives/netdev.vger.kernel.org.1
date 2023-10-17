Return-Path: <netdev+bounces-41951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B927CC6D6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB971C20846
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAFB43AB4;
	Tue, 17 Oct 2023 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOQ05k2N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2E405C8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 14:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4455DC433C8;
	Tue, 17 Oct 2023 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697554380;
	bh=p9QtTE2s4soDUgkgBYZixBU2OaceOiWiuHSpM/4Btwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tOQ05k2NhDretciRhjmj3c2wuEp9kgtFgrp9YCLGyq4e5Y3LIKE6S0DQupaM8wj+J
	 9ejyjqSiP7q1S7273fnm/rTN6vsrhi0fM/7qnewd6+WnGuD3JwPQGQNYRf6CKWMVoZ
	 DmSthPAY9aawmfRmELWerUkV1ffCOtLkbEKLSWs2NXYpP+wLZdn+nhSsyeYdbBwt+L
	 ean/dpAIwk98XyiAHSo4yGJUY+gAlld7GDPcEiQcc35/VoZOdcGmWacQYYUH8sYS42
	 85bHVPWou/frB1QMT4sCm9meGgqldY4YXBQnrnvwxcuF20zGhsBLwrI446B9Y/5hct
	 G5rAFEuDPyvnA==
Date: Tue, 17 Oct 2023 07:52:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net 3/5] net: avoid UAF on deleted altname
Message-ID: <20231017075259.5876c644@kernel.org>
In-Reply-To: <ZS485sWKKb99KrBx@nanopsycho>
References: <20231016201657.1754763-1-kuba@kernel.org>
	<20231016201657.1754763-4-kuba@kernel.org>
	<ZS485sWKKb99KrBx@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 09:51:02 +0200 Jiri Pirko wrote:
> >but freed by kfree() with no synchronization point.
> >
> >Because the name nodes don't hold a reference on the netdevice
> >either, take the heavier approach of inserting synchronization  
> 
> What about to use kfree_rcu() in netdev_name_node_free()
> and treat node_name->dev as a rcu pointer instead?
> 
> struct net_device *dev_get_by_name_rcu(struct net *net, const char *name)
> {
>         struct netdev_name_node *node_name;
> 
>         node_name = netdev_name_node_lookup_rcu(net, name);
>         return node_name ? rcu_deferecence(node_name->dev) : NULL;
> }
> 
> This would avoid synchronize_rcu() in netdev_name_node_alt_destroy()
> 
> Btw, the next patch is smooth with this.

As I said in the commit message, I prefer the explicit sync.
Re-inserting the device and taking refs already necessitate it.

