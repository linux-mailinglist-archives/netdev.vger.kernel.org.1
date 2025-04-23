Return-Path: <netdev+bounces-185148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFABA98B8C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633931779C4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58791ABED9;
	Wed, 23 Apr 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqa6pac6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9FA1C3C04
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415627; cv=none; b=HwbgE6CKjjSMd9ByimYonIun7l4MbEpwRgvRLciNsoNWH4x3zFlAshSwx9hmkfvbxZO/NY7lZL1RADbHbLDggHgPQHOV3FY8pIsnwLbCvKPnWEX53sV0w+pvMeCcxcu8cNh3bv53sRsmUdxv6xiSl1PGaVVByf8WDA7BayKLoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415627; c=relaxed/simple;
	bh=IbI+nb/is5P0KrD1xbkdWthbjwY2pi2xE3YupUSVimc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnX1ocMPW4V3YqfcHqyGnICrIOxZjXjcZ/sypqTLO4zlw/3fpbFYJnh7a5x33GUWRd55tUYTGixSyP1s3MFQY1epBm7+BrdoMlg1Y7jYkV4BZNqUwXDs1xZC67dYbFmsIdSkf4YEz8VzFp+396rMfypg4pQ1HHGYspsXvuN6ADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqa6pac6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11DFC4CEE2;
	Wed, 23 Apr 2025 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745415627;
	bh=IbI+nb/is5P0KrD1xbkdWthbjwY2pi2xE3YupUSVimc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqa6pac6EXLAf+7vy0zNQvIt6Zg3wO9uEWXb9WtLX4n4i7ZHHxO8tPxppdjn3AF6V
	 i0Z9JGdqpNW5lwkZiVIE0ngDFoU+wt3QjCs0SUyJ4FhKzRZTDJP1LuM0HJyEFZha3G
	 77ndsj4/qqu9+MDTEbivdMHafEi3ytawgqJRVV2o7+it1j0u55DChkpTMekV7mVD1L
	 UeXDHy1uXgYJiQPhR0PbkURQA4kfWbnIz1mI1fVvsG735mRBXDdVSKIdoBPgE9fcPm
	 lfs7LPqQFdQfVRcZ4agTgmmwWWVlLMbPMu6oyRWjzQ22O8USXML+hpY3/VfaYicpwY
	 8SSPc4qXpkifg==
Date: Wed, 23 Apr 2025 06:40:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <20250423064026.636c822f@kernel.org>
In-Reply-To: <20250418003259.48017-3-kuniyu@amazon.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
	<20250418003259.48017-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 17:32:33 -0700 Kuniyuki Iwashima wrote:
> -static void __net_exit pfcp_net_exit(struct net *net)
> +static void __net_exit pfcp_net_exit_rtnl(struct net *net,
> +					  struct list_head *dev_to_kill)
>  {
>  	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
>  	struct pfcp_dev *pfcp, *pfcp_next;
> -	struct net_device *dev;
> -	LIST_HEAD(list);
> -
> -	rtnl_lock();
> -	for_each_netdev(net, dev)
> -		if (dev->rtnl_link_ops == &pfcp_link_ops)
> -			pfcp_dellink(dev, &list);
>  
>  	list_for_each_entry_safe(pfcp, pfcp_next, &pn->pfcp_dev_list, list)
> -		pfcp_dellink(pfcp->dev, &list);
> -
> -	unregister_netdevice_many(&list);
> -	rtnl_unlock();
> +		pfcp_dellink(pfcp->dev, dev_to_kill);

Kuniyuki, I got distracted by the fact the driver is broken but I think
this isn't right. The devices do not migrate to the local pcfp_dev_list
when their netns is changed. They always stay on the list of original
netns. Which I guess may make some sense as that's where their socket
is? So we need to scan both the pcfp_dev_list _and_ the local netdevs
that are pfcp. Am I misunderstanding something?

For gtp was the problem perhaps that we were walking multiple
netns'es? I'm my understanding is correct then 4ccacf86491 needs 
a redo :(

