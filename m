Return-Path: <netdev+bounces-105710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CEF912632
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C077728AABF
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13C15531C;
	Fri, 21 Jun 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPDyeK4C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989215444C
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974784; cv=none; b=aWWlA3JjHL7m73U8dZzCXPm7H7HAiMm+A9h9ZQH5YTTdlZ758FSE5QNn0ZxQBM3FPykS208n6AQ8zAeMZY4j4yX7dgNsKWo82gRRdWQTrEqZkSl0WQXkRx73ydXJ+rBe9FHDH9RI5rJG0HPIS0UhV3qC8ewW/jSMtyTZ3quLTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974784; c=relaxed/simple;
	bh=RQZU1MuYAm2lr4cI0F5mPSRJBUBEkLfT22Ka5vxkmak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0cSni2COpEOeRtVchPAjHATF+ZPYGXe7vDbjySZ15S9NYFS3W/cRoAySZ9HXywrwpuebar9UlmbZ1waKOdci0bDPIKAMwKqyFV7p8IZiFTIDkFgAFXXBICMSk82MG/UmQKv0h13obsTqbYBedNiNrqvIS8vAxLmEa0vxq9quWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPDyeK4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0FAC4AF09;
	Fri, 21 Jun 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718974784;
	bh=RQZU1MuYAm2lr4cI0F5mPSRJBUBEkLfT22Ka5vxkmak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPDyeK4CPnftzjJ0crm4owGVDnzpI+u5LHugndhEZkUwXI0JPWqv2td4bJXcqjwTk
	 RWT3a9jRwy3GMwrIvw6mQ0nRBabCFPXn4JIm2b/F0RptxTn6MggKc1TMhnMvZ98GKh
	 UzKb1iEpSCugkd2rjlZTV5Hs0rl07V9iINZ4VBQLA9T8pG/d1mugDR0zqsNo/ZtWeq
	 SAFwZGlRTe9A+Yt+F3alzHEHkWUJkZ+afueGVfmpjeClVL+c7wygIiSAJzpXyA/EUy
	 wZ2c0HGM+eLg6LURslNnlBfGcSc4Up6xPIstWrr0cH/rgRwgaejh3okM3DIuabIBmz
	 vgLqj9Fa/LQ5w==
Date: Fri, 21 Jun 2024 13:59:40 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, gnault@redhat.com, samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: Re: [PATCH net-next 2/8] l2tp: store l2tpv3 sessions in per-net IDR
Message-ID: <20240621125940.GE1098275@kernel.org>
References: <cover.1718877398.git.jchapman@katalix.com>
 <22cdf8d419a6757be449cbeb5b69203d3bb3d2dd.1718877398.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22cdf8d419a6757be449cbeb5b69203d3bb3d2dd.1718877398.git.jchapman@katalix.com>

On Thu, Jun 20, 2024 at 12:22:38PM +0100, James Chapman wrote:
> L2TPv3 sessions are currently held in one of two fixed-size hash
> lists: either a per-net hashlist (IP-encap), or a per-tunnel hashlist
> (UDP-encap), keyed by the L2TPv3 32-bit session_id.
> 
> In order to lookup L2TPv3 sessions in UDP-encap tunnels efficiently
> without finding the tunnel first via sk_user_data, UDP sessions are
> now kept in a per-net session list, keyed by session ID. Convert the
> existing per-net hashlist to use an IDR for better performance when
> there are many sessions and have L2TPv3 UDP sessions use the same IDR.
> 
> Although the L2TPv3 RFC states that the session ID alone identifies
> the session, our implementation has allowed the same session ID to be
> used in different L2TP UDP tunnels. To retain support for this, a new
> per-net session hashtable is used, keyed by the sock and session
> ID. If on creating a new session, a session already exists with that
> ID in the IDR, the colliding sessions are added to the new hashtable
> and the existing IDR entry is flagged. When looking up sessions, the
> approach is to first check the IDR and if no unflagged match is found,
> check the new hashtable. The sock is made available to session getters
> where session ID collisions are to be considered. In this way, the new
> hashtable is used only for session ID collisions so can be kept small.
> 
> For managing session removal, we need a list of colliding sessions
> matching a given ID in order to update or remove the IDR entry of the
> ID. This is necessary to detect session ID collisions when future
> sessions are created. The list head is allocated on first collision
> of a given ID and refcounted.
> 
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Reviewed-by: Tom Parkin <tparkin@katalix.com>

...

> @@ -358,39 +460,45 @@ int l2tp_session_register(struct l2tp_session *session,
>  		}
>  
>  	if (tunnel->version == L2TP_HDR_VER_3) {
> -		pn = l2tp_pernet(tunnel->l2tp_net);
> -		g_head = l2tp_session_id_hash_2(pn, session->session_id);
> -
> -		spin_lock_bh(&pn->l2tp_session_hlist_lock);
> -
> +		session_key = session->session_id;
> +		spin_lock_bh(&pn->l2tp_session_idr_lock);
> +		err = idr_alloc_u32(&pn->l2tp_v3_session_idr, NULL,
> +				    &session_key, session_key, GFP_ATOMIC);
>  		/* IP encap expects session IDs to be globally unique, while
> -		 * UDP encap doesn't.
> +		 * UDP encap doesn't. This isn't per the RFC, which says that
> +		 * sessions are identified only by the session ID, but is to
> +		 * support existing userspace which depends on it.
>  		 */
> -		hlist_for_each_entry(session_walk, g_head, global_hlist)
> -			if (session_walk->session_id == session->session_id &&
> -			    (session_walk->tunnel->encap == L2TP_ENCAPTYPE_IP ||
> -			     tunnel->encap == L2TP_ENCAPTYPE_IP)) {
> -				err = -EEXIST;
> -				goto err_tlock_pnlock;
> -			}
> +		if (err == -ENOSPC && tunnel->encap == L2TP_ENCAPTYPE_UDP) {
> +			struct l2tp_session *session2;
>  
> -		l2tp_tunnel_inc_refcount(tunnel);
> -		hlist_add_head_rcu(&session->global_hlist, g_head);
> -
> -		spin_unlock_bh(&pn->l2tp_session_hlist_lock);
> -	} else {
> -		l2tp_tunnel_inc_refcount(tunnel);
> +			session2 = idr_find(&pn->l2tp_v3_session_idr,
> +					    session_key);
> +			err = l2tp_session_collision_add(pn, session, session2);
> +		}
> +		spin_unlock_bh(&pn->l2tp_session_idr_lock);
> +		if (err == -ENOSPC)
> +			err = -EEXIST;
>  	}
>  

Hi James,

I believe that when the if condition above is false, then err will be
uninitialised here.

If so, as this series seems to have been applied,
could you provide a follow-up to address this?

> +	if (err)
> +		goto err_tlock;
> +
> +	l2tp_tunnel_inc_refcount(tunnel);
> +
>  	hlist_add_head_rcu(&session->hlist, head);
>  	spin_unlock_bh(&tunnel->hlist_lock);
>  
> +	if (tunnel->version == L2TP_HDR_VER_3) {
> +		spin_lock_bh(&pn->l2tp_session_idr_lock);
> +		idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
> +		spin_unlock_bh(&pn->l2tp_session_idr_lock);
> +	}
> +
>  	trace_register_session(session);
>  
>  	return 0;
>  
> -err_tlock_pnlock:
> -	spin_unlock_bh(&pn->l2tp_session_hlist_lock);
>  err_tlock:
>  	spin_unlock_bh(&tunnel->hlist_lock);
>  

...

