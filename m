Return-Path: <netdev+bounces-112087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAE934E27
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A7028121B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94784E11;
	Thu, 18 Jul 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulyVIguP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFF746E
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309271; cv=none; b=mqhfSPkQSMg3Pt9Frq6NIktJjpOor5iIh61a6gNADWOKwojXztw5/1mPyCtGEIxRFxHZjU2L7o5RhKMVU0jBAzZOJvubA/E92pGzNqh0HA0bEIQuESc5Rp7EjX59w6haI+dMXL6ZelWldt9ybe7BpQxOPt3ZL2vdyvB/4UivMlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309271; c=relaxed/simple;
	bh=Bwir8YwjJNMYpwGKtqwVqLQDS2SJgveBkV55Sw3I4RE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mf2Tqj9G3oljlS8ZgDYN4R8x69rT82la4mTZdLs1A1XQqqQhx86GcjVNCcCodMGp/NtHOl8JxWEY26HzADv123RxEqmDhx4pT2BRF5G2NPcJQsa3eZvrudDnbeIiilMiVi8vMNSLaHr7KiffNl7H/2D5hUK4GUm1fKWJvZXkI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulyVIguP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95297C116B1;
	Thu, 18 Jul 2024 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309271;
	bh=Bwir8YwjJNMYpwGKtqwVqLQDS2SJgveBkV55Sw3I4RE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulyVIguPv8Upum/vBS/DBzQTsWG+0SCR7VJb33okePoVWgo5b0IOuKXb1ZdyvfoFC
	 PKT/Q+CDYhII86Q++JBKmbauUx69H652fD7jyFYZSRizTiOhJsoAIhxc1tP5dUE/DX
	 rKfRsepwsIx/G53ny3fBScIs7kvOMbQsAj5oZKHYkK8EwEfh790MTz2hyj8tTWHTR+
	 RhDUCswngxQ5h6nDRKgf6EAxjQl7U4ajhq3hUO9m0XkJmagpwx7e6WL/LRcvdSJ4gd
	 s8BXBdumrXX0U74nYqmvXVoFu8518dcqIMc8fM4IYaIoy0+eD98fvb5YFAXzILPpEI
	 hN2qvM8oPH6+Q==
Date: Thu, 18 Jul 2024 06:27:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org,
 ovs-dev@openvswitch.org, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar
 <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, Aaron Conole
 <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next] openvswitch: switch to per-action label
 counting in conntrack
Message-ID: <20240718062749.2bcea253@kernel.org>
In-Reply-To: <cb6cfbcbdd576ce4f3b74be080b939a9398d21c7.1721268615.git.lucien.xin@gmail.com>
References: <cb6cfbcbdd576ce4f3b74be080b939a9398d21c7.1721268615.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 22:10:15 -0400 Xin Long wrote:
> @@ -2026,7 +2023,4 @@ void ovs_ct_exit(struct net *net)
>  #if	IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
>  	ovs_ct_limit_exit(net, ovs_net);
>  #endif
> -
> -	if (ovs_net->xt_label)
> -		nf_connlabels_put(net);
>  }

In addition to net-next being closed please note there is a warning
about ovs_net being unused if NETFILTER_CONNCOUNT=n.

