Return-Path: <netdev+bounces-244164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C630CB0EF3
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 20:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18E8A30C0CB8
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC95304BB3;
	Tue,  9 Dec 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5jQSDgc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65948306486
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765308478; cv=none; b=ir6Dz6V3JbIrERCk3VJf1mK65VsoprGu1usbTOfBGq7jbBQjUIQPQFr916MqG9tCONMn1+q3LkoNicW8FJPYt+hKPvoHieMRNq3vOInopKbtf2IkdxzReyiiRRI3+Bz3lCSAthTFmfaeAfFUDO+WGoEOcjKbiLG0N5xot5F7gfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765308478; c=relaxed/simple;
	bh=wjbxWJSeRleQvETobHDfeRjHY1+mXH3Frsntw51pLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IElJ51pF9uqjQOG+K00WB6aoxwnBpTuvRWQF52vWvs+0Cc+7obp7D/Djf6Y2qbxEYHuaR/pSqQxtG6vTDoql+n0Hzeaiw4xM8rfnOGeoumGKNSv1gdb076YNbfdzCLcRptPL5eU7lhKU3H/afipmeNoX7TCtyYuSNA5o0/Pgd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5jQSDgc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765308475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CBEhM01DwH+mNTDzXCIduQ5j9yuBc3fGFQPO8YqgPP8=;
	b=e5jQSDgcRjwHCc89kxR9//e4pFYc2ueRPdLODTNPoJKWkRFu1BthgHNTE7x5Eot97ukJsO
	to5+Lzq8Z8ApR3G3GIvKXDbrCYYEaS5hDhUOKGutGdsJndd5t3HeSG5gC16oxKvdekNIne
	5mqqhDj1V6TFIMFjUNWPf6Qmu1Y8WWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-zkwNK1LqOSG81f0jV4qDuw-1; Tue,
 09 Dec 2025 14:27:51 -0500
X-MC-Unique: zkwNK1LqOSG81f0jV4qDuw-1
X-Mimecast-MFC-AGG-ID: zkwNK1LqOSG81f0jV4qDuw_1765308470
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D38ED195609F;
	Tue,  9 Dec 2025 19:27:50 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78AA51800451;
	Tue,  9 Dec 2025 19:27:50 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id A224754CA76; Tue, 09 Dec 2025 14:27:48 -0500 (EST)
Date: Tue, 9 Dec 2025 14:27:48 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] net/handshake: a handshake can only be cancelled once
Message-ID: <aTh4NGPQfWl-uurT@aion>
References: <20251206143006.2493798-1-smayhew@redhat.com>
 <938c82cd-9760-42e5-b0ce-123c86710782@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <938c82cd-9760-42e5-b0ce-123c86710782@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, 06 Dec 2025, Chuck Lever wrote:

> 
> 
> On Sat, Dec 6, 2025, at 9:30 AM, Scott Mayhew wrote:
> > When a handshake request is cancelled it is removed from the
> > handshake_net->hn_requests list, but it is still present in the
> > handshake_rhashtbl until it is destroyed.
> >
> > If a second cancellation request arrives for the same handshake request,
> > then remove_pending() will return false... and assuming
> > HANDSHAKE_F_REQ_COMPLETED isn't set in req->hr_flags, we'll continue
> > processing through the out_true label, where we put another reference on
> > the sock and a refcount underflow occurs.
> >
> > This can happen for example if a handshake times out - particularly if
> > the SUNRPC client sends the AUTH_TLS probe to the server but doesn't
> > follow it up with the ClientHello due to a problem with tlshd.  When the
> > timeout is hit on the server, the server will send a FIN, which triggers
> > a cancellation request via xs_reset_transport().  When the timeout is
> > hit on the client, another cancellation request happens via
> > xs_tls_handshake_sync().
> >
> > Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for 
> > handling handshake requests")
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  net/handshake/request.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 274d2c89b6b2..c7b20d167a55 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -333,6 +333,10 @@ bool handshake_req_cancel(struct sock *sk)
> >  		return false;
> >  	}
> > 
> > +	/* Duplicate cancellation request */
> > +	trace_handshake_cancel_none(net, req, sk);
> > +	return false;
> > +
> >  out_true:
> >  	trace_handshake_cancel(net, req, sk);
> > 
> > -- 
> > 2.51.0
> 
> To help support engineers find this patch, I recommend using
> "net/handshake: duplicate handshake cancellations leak socket" as
> the short description.
> 
> The proposed solution might introduce a socket reference leak:
> 
> 1. Request submitted: sock_hold() called (line 271)
> 2. Request accepted by daemon via handshake_req_next()
>    (removes from pending list)
> 3. Cancel called:
>   - remove_pending() returns FALSE (not in pending list)
>   - test_and_set_bit() returns FALSE (sets the bit now)
>   - With patch: returns FALSE, sock_put() NOT called
> 4. handshake_complete() called: bit already set, skips sock_put()
> 
> What if we use test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED) in the
> pending cancel path so duplicate cancels can be detected?
> 
> Instead of:
> 
>         if (hn && remove_pending(hn, req)) {
>                 /* Request hadn't been accepted */
>                 goto out_true;
>         }
> 
> go with this bit of untested code:
> 
>         if (hn && remove_pending(hn, req)) {
>                 /* Request hadn't been accepted - mark cancelled */
>                 if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
>                         trace_handshake_cancel_busy(net, req, sk);
>                         return false;
>                 }
>                 goto out_true;
>         }

Thanks, Chuck.  That works.
> 
> -- 
> Chuck Lever
> 


