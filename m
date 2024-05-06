Return-Path: <netdev+bounces-93869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4068BD6F1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9109282B71
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332DA15B14E;
	Mon,  6 May 2024 21:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A413D2BC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031875; cv=none; b=rMsSKl9uBe3a1dVC932NMqgpZ2UC+FMpDAehLmyQQi2v+rQXbSRKoc370nZKr1I+k+PgycLmEQ/u1AmuEIiO/cGHqe2kCj6kFJ0TQYBu6w1hsUqKawEvTMfho8WNDD0mF6+iJ5aYEI6ekJStkIrZWXMlNP3H9W21f/JuwDru2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031875; c=relaxed/simple;
	bh=xx3g5igoOnvpJHkPlJEzsZ0/MhapR0rIkOU3I8ahx7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCKN8vF2XlRNb21fc8NcoErJJAR7iUDjn2wu7CcM4Hndre7a9iLYrdtAE4xV2zEC2bKgk0s4Qahqs/NkGrewMdy4/NgFzG1bqqfqJkrWXnfNoshVYAT7uJ6vmCW+wjLYijjwO/kKQTyof5pq9KXnyZ+MWCZsVfQudvMKNUfPEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 008A6A02C2;
	Mon,  6 May 2024 23:44:25 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCTOHqICXSQg; Mon,  6 May 2024 23:44:24 +0200 (CEST)
Received: from begin.home (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id C6662A02A3;
	Mon,  6 May 2024 23:44:24 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1s468G-00000005xup-0qPY;
	Mon, 06 May 2024 23:44:24 +0200
Date: Mon, 6 May 2024 23:44:24 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: James Chapman <jchapman@katalix.com>
Cc: Tom Parkin <tparkin@katalix.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] l2tp: Support several sockets with same IP/port quadruple
Message-ID: <20240506214424.4wddiwjdpdl2gf4w@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
References: <20240502231418.2933925-1-samuel.thibault@ens-lyon.org>
 <ea4ddddc-719c-673e-7646-8f89cd341e7b@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4ddddc-719c-673e-7646-8f89cd341e7b@katalix.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Hello,

James Chapman, le ven. 03 mai 2024 12:36:14 +0100, a ecrit:
> > @@ -845,6 +846,20 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
> >   		/* Extract tunnel and session ID */
> >   		tunnel_id = ntohs(*(__be16 *)ptr);
> >   		ptr += 2;
> > +
> > +		if (tunnel_id != tunnel->tunnel_id && tunnel->l2tp_net) {
> Can tunnel->l2tp_net be NULL?

l2tp_tunnel_sock_create's comment says

 * Since we don't want these sockets to keep a namespace alive by
 * themselves, we drop the socket's namespace refcount after creation.
 * These sockets are freed when the namespace exits using the pernet
 * exit hook.

and l2tp_tunnel_create does not set l2tp_net, only l2tp_tunnel_register
does, so I assumed it might be NULL and preferred to stay on
the safe side. But it's l2tp_tunnel_register which adds it to
pn->l2tp_tunnel_idr, so AIUI it indeed cannot be NULL since we got it
from pn->l2tp_tunnel_idr, we can probably drop the test indeed.

> > +			/* We are receiving trafic for another tunnel, probably
> > +			 * because we have several tunnels between the same
> > +			 * IP/port quadruple, look it up.
> > +			 */
> > +			struct l2tp_tunnel *alt_tunnel;
> > +
> > +			alt_tunnel = l2tp_tunnel_get(tunnel->l2tp_net, tunnel_id);
> This misses a check that alt_tunnel's protocol version matches the header.
> Move the existing header version check to after this fragment?

We need to check the version before getting the tunnel id, which we need
to look up the struct l2tp_tunnel :)

I'll add another version check.

Samuel

> > +			if (!alt_tunnel)
> > +				goto pass;
> > +			tunnel = alt_tunnel;
> > +		}
> > +
> >   		session_id = ntohs(*(__be16 *)ptr);
> >   		ptr += 2;
> >   	} else {

