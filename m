Return-Path: <netdev+bounces-105913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C59138D0
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 09:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B94281CCD
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9C39851;
	Sun, 23 Jun 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfBgBSNa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62617C7C
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719128583; cv=none; b=MNMbxFs6q6se/5uyx4sNMALY2Zj47mC47+tvKTCkR7alFGuUa9n/5rxT5Whqu633I6YpnfQGYGEIB07UumMAFXzwAvwerenM78k88kDWCpCFACSyqrOUypA+slywV7XCdtRQbwnD4jROJt9uAIqGKIcAMTi5j5LYTa8J1E7DMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719128583; c=relaxed/simple;
	bh=vEPdkq96WIWo9yYnDl9dIYaRS7LoVPnQ83IY5GM9xi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKnKmIohJmdmy/AdByJ32bdr3tEC7OGyTFA5gFWpU8qY9uIICeu6K1FEyu2yF0ateOsoHWOH32E6nimI0j54uIZtpse06wi1gjCFn6Kpl2AlEvFPpJzIUW3uyS9d2SwvOZ7e8uJulUGzrJskkydP+Z+7qmsX9y+tGT7B27LmLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfBgBSNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D435C2BD10;
	Sun, 23 Jun 2024 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719128582;
	bh=vEPdkq96WIWo9yYnDl9dIYaRS7LoVPnQ83IY5GM9xi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UfBgBSNa3KslKKch0flmrdXc8oUX+TTzEBteYZegaGKliTKypvBHUFe8qajOTGiYA
	 uz/IkzMAIYn8kZvpFVzF+P/wjX2YZHPm+TnDQu/nkJ+YsKoDmNT/MexEixCQuWaPyX
	 b1ilY3WEt7FqBbvJ8Oas5c5R0PQux+P7BWdjI2+Fs4G2DpjVcDGsvMPTOs68jG7vdH
	 GS8/TVEuSkEvJFOkzVsVJwHsGp2ipH28suGfDnWywLE/k4RNa2A1XO6yKkUAZ50Ek6
	 r1IG7mh9iDZCgToGqkrIHdwUapG3tXU2djr9EO9+hlcAE4QbedVhdeNtzhXkRcieND
	 DfP/xaAcJchsQ==
Date: Sun, 23 Jun 2024 08:42:59 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, gnault@redhat.com, samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: Re: [PATCH net-next 2/8] l2tp: store l2tpv3 sessions in per-net IDR
Message-ID: <20240623074259.GJ1098275@kernel.org>
References: <cover.1718877398.git.jchapman@katalix.com>
 <22cdf8d419a6757be449cbeb5b69203d3bb3d2dd.1718877398.git.jchapman@katalix.com>
 <20240621125940.GE1098275@kernel.org>
 <e24ecc91-8fb4-fbd2-374a-2d1af2d8d3d7@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e24ecc91-8fb4-fbd2-374a-2d1af2d8d3d7@katalix.com>

On Fri, Jun 21, 2024 at 05:21:48PM +0100, James Chapman wrote:
> On 21/06/2024 13:59, Simon Horman wrote:
> > On Thu, Jun 20, 2024 at 12:22:38PM +0100, James Chapman wrote:
> > > L2TPv3 sessions are currently held in one of two fixed-size hash
> > > lists: either a per-net hashlist (IP-encap), or a per-tunnel hashlist
> > > (UDP-encap), keyed by the L2TPv3 32-bit session_id.
> > > 
> > > In order to lookup L2TPv3 sessions in UDP-encap tunnels efficiently
> > > without finding the tunnel first via sk_user_data, UDP sessions are
> > > now kept in a per-net session list, keyed by session ID. Convert the
> > > existing per-net hashlist to use an IDR for better performance when
> > > there are many sessions and have L2TPv3 UDP sessions use the same IDR.
> > > 
> > > Although the L2TPv3 RFC states that the session ID alone identifies
> > > the session, our implementation has allowed the same session ID to be
> > > used in different L2TP UDP tunnels. To retain support for this, a new
> > > per-net session hashtable is used, keyed by the sock and session
> > > ID. If on creating a new session, a session already exists with that
> > > ID in the IDR, the colliding sessions are added to the new hashtable
> > > and the existing IDR entry is flagged. When looking up sessions, the
> > > approach is to first check the IDR and if no unflagged match is found,
> > > check the new hashtable. The sock is made available to session getters
> > > where session ID collisions are to be considered. In this way, the new
> > > hashtable is used only for session ID collisions so can be kept small.
> > > 
> > > For managing session removal, we need a list of colliding sessions
> > > matching a given ID in order to update or remove the IDR entry of the
> > > ID. This is necessary to detect session ID collisions when future
> > > sessions are created. The list head is allocated on first collision
> > > of a given ID and refcounted.
> > > 
> > > Signed-off-by: James Chapman <jchapman@katalix.com>
> > > Reviewed-by: Tom Parkin <tparkin@katalix.com>
> > 
> > ...
> > 
> > > @@ -358,39 +460,45 @@ int l2tp_session_register(struct l2tp_session *session,
> > >   		}
> > >   	if (tunnel->version == L2TP_HDR_VER_3) {
> > > -		pn = l2tp_pernet(tunnel->l2tp_net);
> > > -		g_head = l2tp_session_id_hash_2(pn, session->session_id);
> > > -
> > > -		spin_lock_bh(&pn->l2tp_session_hlist_lock);
> > > -
> > > +		session_key = session->session_id;
> > > +		spin_lock_bh(&pn->l2tp_session_idr_lock);
> > > +		err = idr_alloc_u32(&pn->l2tp_v3_session_idr, NULL,
> > > +				    &session_key, session_key, GFP_ATOMIC);
> > >   		/* IP encap expects session IDs to be globally unique, while
> > > -		 * UDP encap doesn't.
> > > +		 * UDP encap doesn't. This isn't per the RFC, which says that
> > > +		 * sessions are identified only by the session ID, but is to
> > > +		 * support existing userspace which depends on it.
> > >   		 */
> > > -		hlist_for_each_entry(session_walk, g_head, global_hlist)
> > > -			if (session_walk->session_id == session->session_id &&
> > > -			    (session_walk->tunnel->encap == L2TP_ENCAPTYPE_IP ||
> > > -			     tunnel->encap == L2TP_ENCAPTYPE_IP)) {
> > > -				err = -EEXIST;
> > > -				goto err_tlock_pnlock;
> > > -			}
> > > +		if (err == -ENOSPC && tunnel->encap == L2TP_ENCAPTYPE_UDP) {
> > > +			struct l2tp_session *session2;
> > > -		l2tp_tunnel_inc_refcount(tunnel);
> > > -		hlist_add_head_rcu(&session->global_hlist, g_head);
> > > -
> > > -		spin_unlock_bh(&pn->l2tp_session_hlist_lock);
> > > -	} else {
> > > -		l2tp_tunnel_inc_refcount(tunnel);
> > > +			session2 = idr_find(&pn->l2tp_v3_session_idr,
> > > +					    session_key);
> > > +			err = l2tp_session_collision_add(pn, session, session2);
> > > +		}
> > > +		spin_unlock_bh(&pn->l2tp_session_idr_lock);
> > > +		if (err == -ENOSPC)
> > > +			err = -EEXIST;
> > >   	}
> > 
> > Hi James,
> > 
> > I believe that when the if condition above is false, then err will be
> > uninitialised here.
> > 
> > If so, as this series seems to have been applied,
> > could you provide a follow-up to address this?
> > 
> > > +	if (err)
> > > +		goto err_tlock;
> > > +
> > > +	l2tp_tunnel_inc_refcount(tunnel);
> > > +
> > >   	hlist_add_head_rcu(&session->hlist, head);
> > >   	spin_unlock_bh(&tunnel->hlist_lock);
> > > +	if (tunnel->version == L2TP_HDR_VER_3) {
> > > +		spin_lock_bh(&pn->l2tp_session_idr_lock);
> > > +		idr_replace(&pn->l2tp_v3_session_idr, session, session_key);
> > > +		spin_unlock_bh(&pn->l2tp_session_idr_lock);
> > > +	}
> > > +
> > >   	trace_register_session(session);
> > >   	return 0;
> > > -err_tlock_pnlock:
> > > -	spin_unlock_bh(&pn->l2tp_session_hlist_lock);
> > >   err_tlock:
> > >   	spin_unlock_bh(&tunnel->hlist_lock);
> > 
> > ...
> 
> Hi Simon,
> 
> It's "fixed" by the next patch in the series: 2a3339f6c963 ("l2tp: store
> l2tpv2 sessions in per-net IDR") which adds an else clause to the if
> statement quoted above. Sorry I missed this when compile-testing the series!
> Would you prefer a separate patch to initialise err?

Hi James,

Thanks for your response and sorry for missing that.
I see it now and I don't think any further action is required.

