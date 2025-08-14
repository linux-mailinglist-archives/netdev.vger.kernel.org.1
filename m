Return-Path: <netdev+bounces-213792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4590B26AB1
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769191CC754E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2451721B8F8;
	Thu, 14 Aug 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4cdAZM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006011A3164
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184341; cv=none; b=WPVBu9r5m90ZKqxMnMhu3AW/T6F06TKLdgrFgiJ7BXXo4GRTb8iIv+etsbDPMRD8Z/zX+lsQSDNs/xY8RBBbHX6LGabjrLCLN7voLIx0Qnc/WNF/2mvTLaoKOPrvQkczDpmdgEAOj3JBT3ee9gILazmwPLtwLIse9SPEH4hodgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184341; c=relaxed/simple;
	bh=zjehoJwmNOK9X0UIY/ocJwa50I/LCX+EMpUO25Tlyjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEsYnsG2kBYAGdMIYswCOUvnc8c8mbobFlSLNLG425E+jrqK8soSc3ZMRCtdLnWnWrixyZNiWShhMhZZnuKwNUr1E/qouPZrxxc8XB8pVJp104vjT8Dq/abYBFTmGhs67Yj4reK3Nwu9OVNItopJ6w772NX0ZBkj+Y22i49s0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4cdAZM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9BBC4CEED;
	Thu, 14 Aug 2025 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184340;
	bh=zjehoJwmNOK9X0UIY/ocJwa50I/LCX+EMpUO25Tlyjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4cdAZM/GW/ySZt2hP+W4al+0wMsFz9OLBHhStl2FGUqzZ/gqv5c0xPlf2WlRYXPL
	 JF3407LZmXXUwHIePO3TB3kT87WcZPH0lnz66S47z7hScoYaIgZJOwaFZYINH5HGCG
	 5iM4CjsBmd+/aDEWfzziR0PeEifV4NbwoczHH42SwC3jTMAR+zHmJJVgn5IjIqowBZ
	 usKQnU/Y5WiKAMBCJxlIxc2b6bh26XyxB7yjW1fnjORPu9aSGVSMr+IHitEltTRpWY
	 FSNKxCA/GXaHFGVRzpAO/Z/WwcnFrAzILQWGHHUn9azLHbRfglZ04Ls9oY+Ud6EqMk
	 asjX5dCbH2+KQ==
Date: Thu, 14 Aug 2025 08:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David
 Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran
 Kella <kiran.kella@broadcom.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 04/19] tcp: add datapath logic for PSP with
 inline key exchange
Message-ID: <20250814081218.09b31c82@kernel.org>
In-Reply-To: <0c1dd072-8dae-429e-846f-08de9a69366f@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
	<20250812003009.2455540-5-daniel.zahka@gmail.com>
	<63d55246-fd88-40e6-bb78-8447e0863684@redhat.com>
	<0c1dd072-8dae-429e-846f-08de9a69366f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 10:43:34 -0400 Daniel Zahka wrote:
> On 8/14/25 9:18 AM, Paolo Abeni wrote:
> > On 8/12/25 2:29 AM, Daniel Zahka wrote:  
> >> @@ -2070,7 +2076,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
> >>   	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
> >>   	    !tcp_skb_can_collapse_rx(tail, skb) ||
> >>   	    thtail->doff != th->doff ||
> >> -	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
> >> +	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
> >> +	    /* prior to PSP Rx policy check, retain exact PSP metadata */
> >> +	    psp_skb_coalesce_diff(tail, skb))
> >>   		goto no_coalesce;  
> > The TCP stack will try to coalesce skbs in other places, too (i.e.
> > tcp_try_coalesce(), tcp_collapse()...) Why a similar check is not needed
> > there?  
> 
> We handle coalescing of skb's in various places. On the tx path, we 
> place a call to tcp_write_collapse_fence() in psp_sock_assoc_set_tx(), 
> to prevent data written into the socket as cleartext from being merged 
> with data written after the tx-assoc netlink operation has been 
> performed. On the rx path, for dealing with coalescing before the skb is 
> in the socket receive queue we call psp_skb_coalesce_diff() from 
> tcp_add_backlog() and gro_list_prepare(). For skb's that are already on 
> the socket receive queue, we rely on the fact that psp skb's will have 
> skb->decrypted set, and all tcp functions that try to collapse skb's on 
> the receive queue should call skb_cmp_decrypted() at some point. If we 
> have missed a case, than that would be a bug.

Stating the obvious, but please incorporate the answers to the questions
asked in the review in the commit message. I think this came up before..

