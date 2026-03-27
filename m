Return-Path: <netdev+bounces-272318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GvuGzbfxWmECgUAu9opvQ
	(envelope-from <netdev+bounces-272318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A233DDF9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844D63056B4E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259E285C98;
	Fri, 27 Mar 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq/sxyzG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004B2550D7
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575361; cv=none; b=ClC6GtKFpEr1zfOErtdxjKSStNOM6LtQjvS/KfkUOtWN4HvqfcQK7USa/qOw9hQfDwqWWzy09HaitZ3p4cWJ3uQ814WqlqucYHkyh9cTZr4TgtvisKdrkfTZU7G0EMn2q7FFuvykxWsAvM90Jp+WaaKfNGnY5QZn22My7b/iwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575361; c=relaxed/simple;
	bh=5E/ZTXF593H+tA+AcBkifWXNJfPvDB8zYY9K+oRNOxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBBIhBgu8TTBKH5RxKd865EDkmXZeAL2C8aCBSi9vxpZErMn+3NydoBWgf3Xpg76kqzavpIaU0duN3LpnCYGq/P1lDKCdOz1//bfcYhbsfIZXg9xpY1aMqj48m+zC1ZGLRvO3csO37xmnA4lyHQjWzIObvZ28bGgLzfnd9ZAsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq/sxyzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46DEC116C6;
	Fri, 27 Mar 2026 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774575361;
	bh=5E/ZTXF593H+tA+AcBkifWXNJfPvDB8zYY9K+oRNOxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hq/sxyzGHh/Ur+3++PV5iCoZ4Yz4cX4rtCVNP8Y9cQCmq7EvWg81z7tha2NS0w/uZ
	 Spoyg+/RxV8On5sWvix/d2yhkKFnvnoy35Nv8hPLpmT+6ZoxpkNtMtE83OL3KhiIND
	 jL2SrKzV9H2VTMD2iLTfqT7se3HyYegN5+PnwfTCKaewILXzaDRGjmhya2JKatLigP
	 UiD0YyPc8YaRBWMxidip1+g5X6MVyoGKFmMEIYVUe8LxLcoA+GtBqgYHtsZ9zEva40
	 DlirEVThkuMCnaYmab/b0lMylyjuthUj3DUUBz1tuY3T6ml6UkZ2/M1u0t9fppVha+
	 dL6Q1lI6qT/RQ==
Date: Thu, 26 Mar 2026 18:35:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] ipv6: move IFA_F_PERMANENT percpu allocation
 in process scope
Message-ID: <20260326183559.6e7965f3@kernel.org>
In-Reply-To: <8c8bfe2e1a324e501f0e15fef404a77443fd8caf.1774365668.git.pabeni@redhat.com>
References: <8c8bfe2e1a324e501f0e15fef404a77443fd8caf.1774365668.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272318-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E07A233DDF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 16:22:08 +0100 Paolo Abeni wrote:
> +	while (!list_empty(&tmp_addr_list)) {
> +		ifp = list_first_entry(&tmp_addr_list,
> +				       struct inet6_ifaddr, if_list_aux);
> +		list_del(&ifp->if_list_aux);
> +
> +		if (fixup_permanent_addr(net, idev, ifp) < 0) {
>  			in6_ifa_hold(ifp);
>  			ipv6_del_addr(ifp);
> -			write_lock_bh(&idev->lock);
>  
>  			net_info_ratelimited("%s: Failed to add prefix route for address %pI6c; dropping\n",
>  					     idev->dev->name, &ifp->addr);
>  		}

Sashiko points out that there's a UAF on the ifp->addr in the print
statement. Could you reorder these in net first, to avoid the conflict?
-- 
pw-bot: cr

