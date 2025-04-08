Return-Path: <netdev+bounces-180511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C39A8194D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5D81BA3734
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A9254AEE;
	Tue,  8 Apr 2025 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7Kgnwi7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9723FC4B
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154714; cv=none; b=rcgOenC4BpT9Pz6NpyIi7L1agl8bdrQpjIT4mincZDHVj4JqznXO2Rd5T1jlx4GInqkMAX/kEE68KaJrEL8VgG6bE8my35hLrqSueDM517qJj4IB9fBC3YsF6GZin7k8KRyFtlzUyMyIonyDmzCQf6zEvoxlNZuaqouxrPhOECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154714; c=relaxed/simple;
	bh=V6qfC59SiIeXwHdFJLKnfdaNgDpZfwkPDBtUy9Pq4/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDt73BP2M+S6gGswYPEQYLa1nN7qsxpDWnrGbGCCkoHuNJuNeiKud4jYJ65xLofD35zpEP692tQ3znIpXHltGrXUUoB24nXwtuAjGFEH5sPNx+ot4LDwiy1SgZ/z2TEfLTx3p1Ik0bPfeXopaC8tj6qzZHrcnieRVK1uGkV3Cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7Kgnwi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DC0C4CEE5;
	Tue,  8 Apr 2025 23:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154714;
	bh=V6qfC59SiIeXwHdFJLKnfdaNgDpZfwkPDBtUy9Pq4/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7Kgnwi7ii799IpfPEctRHrSCXulhn2vP+WUVBta0P3NxCqoMolzBzpaUlIEt1Mwu
	 gJekQZ2X/7+daw6Cp+hSccrxpYCL5TiIsu1QYF5/H4j9WsCXFdXHOc3AfU/fvCXVcO
	 +Tg1AO8nmzgqYqctKV6+7yEIquUG96U+t4Nl7Fgn9Pl0Ulpat2bMYN6Z96Ja9/mgdI
	 BHf/OuIla7mE2q9+RWwA1XoWEgWTxZC+lS5AoEAJvMNWCb75ly3KqE+JT83mDJhV5C
	 cbMJrBqRGrEuzBFrn+Iz2wor9VSN/pqwKDKhtgr+vEnCt9kMucbht57K98EcoObF/b
	 6oYZV4dpmV+zQ==
Date: Tue, 8 Apr 2025 16:25:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, "Pablo Neira
 Ayuso" <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 3/4] net: Unexport shared functions for
 DCCP.
Message-ID: <20250408162512.23a84b5e@kernel.org>
In-Reply-To: <20250407231823.95927-4-kuniyu@amazon.com>
References: <20250407231823.95927-1-kuniyu@amazon.com>
	<20250407231823.95927-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 16:17:50 -0700 Kuniyuki Iwashima wrote:
> DCCP was removed, so many inet functions no longer need to
> be exported.
> 
> Let's unexport or use EXPORT_IPV6_MOD() for such functions.
> 
> sk_free_unlock_clone() is inlined in sk_clone_lock() as it's
> the only caller.

netfilter wants inet_twsk_put

ERROR: modpost: "inet_twsk_put" [net/ipv4/netfilter/nf_tproxy_ipv4.ko] undefined!
ERROR: modpost: "inet_twsk_put" [net/ipv6/netfilter/nf_tproxy_ipv6.ko] undefined!

allmodconfig builds seems to miss it :(
-- 
pw-bot: cr

