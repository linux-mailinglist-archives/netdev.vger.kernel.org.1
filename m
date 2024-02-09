Return-Path: <netdev+bounces-70682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1B84FFD5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766F6288506
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D613210E7;
	Fri,  9 Feb 2024 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEhSQTim"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5F18053
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517483; cv=none; b=AR7I/4EZ5ZZYp9xYJm/JlreWY1+NC9Xv0ZcYx5dCMfhT7hE+JdQxgRtbpZ3Ay2FCE9Y7RD5OfdkHQ9K2jUtSfT26S3WmL5KfSijAkYh1ThJ2CXigDht2sBpUPK8euBdCeQOm4/rImuUyvVyRRs8d417u3EavAto+OFl7lZbVNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517483; c=relaxed/simple;
	bh=JW/wEz6JErYPRjl6quRHMQ0slNFL1XKVZn0LIh/pA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGcvJRdUMIe/Php8Id9sTPXGNloFSq/7VIdirsuuzOOx25/ITgqSX/mQkXLHbee8V67nIIaPdvvAgIRa2mwbcP+B0ud29vzSoNy4SDGNRvmdYPFYrQ16pKbR5fqxPc0BWqJZ8msfAU8k7zIBJAzg0Jmmmd4MC+CqFQs9WFHBoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEhSQTim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB902C433F1;
	Fri,  9 Feb 2024 22:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517482;
	bh=JW/wEz6JErYPRjl6quRHMQ0slNFL1XKVZn0LIh/pA9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AEhSQTimlaebZv2M+T+wcic8Dai41LwFnSG7HhUvbydz2jUKMucAsBncTtVA4464I
	 A7qNyS0gq/GPGGp4IBhSBuV3PR+2K1SKwJuIgwZRxF7MOxc702A04dG2C6HumaeVXC
	 o4/OKwKx1fcgFXt79+hANSjh8ea61sf1p96N0HQcuepjwreXt0j9Jn8siMVutr/8l3
	 t9jhnYUxUEPlHdnDOw1XsUP2RoxzjsEjMy76md/2nd+V73EXhcdp1LM/wx2xASSbFC
	 OifT69OHgkILT+0L/1VeCxUqYxA6rwd1iJeMO/4DMBwbS9U58vchFe/UBPGA08Ug9J
	 9rsrsgumwQiLQ==
Date: Fri, 9 Feb 2024 14:24:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/2] rtnetlink: use xarray iterator to
 implement rtnl_dump_ifinfo()
Message-ID: <20240209142441.6c56435b@kernel.org>
In-Reply-To: <20240209145615.3708207-3-edumazet@google.com>
References: <20240209145615.3708207-1-edumazet@google.com>
	<20240209145615.3708207-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 14:56:15 +0000 Eric Dumazet wrote:
> +	unsigned long ifindex = cb->args[0];

[snip]

> +	for_each_netdev_dump(tgt_net, dev, ifindex) {
> +		if (link_dump_filtered(dev, master_idx, kind_ops))
> +			continue;
> +		err = rtnl_fill_ifinfo(skb, dev, net, RTM_NEWLINK,
> +				       NETLINK_CB(cb->skb).portid,
> +				       nlh->nlmsg_seq, 0, flags,
> +				       ext_filter_mask, 0, NULL, 0,
> +				       netnsid, GFP_KERNEL);
> +
> +		if (err < 0)
> +			break;
> +		cb->args[0] = ifindex + 1;

Perhaps we can cast the context buffer onto something typed and use 
it directly? I think it's a tiny bit less error prone:

	struct {
		unsigned long ifindex;
	} *ctx = (void *)cb->ctx;

Then we can:

	for_each_netdev_dump(tgt_net, dev, ctx->ifindex)
					   ^^^^^^^^^^^^

and not need to worry about saving the ifindex back to cb before
exiting.

Up to you.

