Return-Path: <netdev+bounces-287229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJTDMYNUA2pq4gEAu9opvQ
	(envelope-from <netdev+bounces-287229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:25:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45984524A18
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A059D30AA0A1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182B3C819E;
	Tue, 12 May 2026 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5/1cDWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A997081A;
	Tue, 12 May 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601825; cv=none; b=H9TLjP9w8G3gqvBCg/FMpYr4SZMnaUStgiupgrkU8Na38P3PLKQm5PtXx+eHvpUMs4LzW8p3zGKxpXeDU3QEbyMoh51eau8J/eHsigPPoys88r3KBRJSR0PSTs+b2VR4gBg2JKAjqak24t+iHzdwBtSF4ikimXCilTHLX6TUY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601825; c=relaxed/simple;
	bh=hN8ptaNvSOxU6v4Xfdr3YqfTxz2H8Z45w+RCfymBy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJvpNL6o1WRqFl3ISRUXLcO361S/rNsuxVBiakygNTyEid6UNRco1nK06OUpKzCKQbNDDsDZ3V/usGfgD4UEl9NpyLQfzAoyEVrht5MvMU2M3cjuknCOVgDgPYo0BNDf9g9YQ3WoLMMHTobWOIbXcufFOCX9S/p6xuYIvO5VLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5/1cDWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E81C2BCB0;
	Tue, 12 May 2026 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601824;
	bh=hN8ptaNvSOxU6v4Xfdr3YqfTxz2H8Z45w+RCfymBy6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5/1cDWGdzrK0q2TXSNVKVDSwRY1lJWE/V+/TqqMqmiuzM10S6USpy1hhOdzJ98fW
	 I4vStU//h4Ewv21SBlEvE2FAhTLj6R9Y6rWOlQCTDJZtrOyUvdYcw1nMlo8b4E/qXT
	 Pi49Itb+wkdnDonCxkCar0maTzTll6hH5suEQz+NytndoGOimRamUkgmi7/+3AMxqC
	 fApZuB3Fp0iRYYKywsr5Lz2B5iz1w4ri+Jqs6iK7rfDsViTmwo6GVWccMZzTCnPmBb
	 eEy2+SD3rxIcpA6+r8kunNB24J8OfpS6rAe0utvyKO+OKNawC1Gwnz9cJSMVPIdBxN
	 b5RtRBtTW1RDg==
Date: Tue, 12 May 2026 09:03:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, daniel@iogearbox.net, jonathan.lemon@gmail.com
Subject: Re: [PATCH net v2 2/4] net: tls: prevent chain-after-chain in plain
 text SG
Message-ID: <20260512090342.15779c9a@kernel.org>
In-Reply-To: <agMKcBrJYK5UIcsZ@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
	<20260511174920.433155-3-kuba@kernel.org>
	<agMKcBrJYK5UIcsZ@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45984524A18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 13:09:36 +0200 Sabrina Dubroca wrote:
> 2026-05-11, 10:49:18 -0700, Jakub Kicinski wrote:
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 2608b0c01849..3bfdaf5e64f5 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -789,21 +789,33 @@ static int tls_push_record(struct sock *sk, int flags,
> >  	i = msg_pl->sg.end;
> >  	sk_msg_iter_var_prev(i);
> >  
> > +	/* msg_pl->sg.data is a ring; data[MAX+1] is reserved for the wrap
> > +	 * link (frags won't use it). 'i' is now the last filled entry:
> > +	 *
> > +	 *         i   end              start
> > +	 *         v    v                 v            [ rsv ]
> > +	 *  [ d ][ d ][   ][   ]...[   ][ d ][ d ][ d ][chain]
> > +	 *    ^   END                                     v
> > +	 *     `-----------------------------------------'
> > +	 *
> > +	 * Note that SGL does not allow chain-after-chain, so for TLS 1.3,
> > +	 * we must make sure we don't create the wrap entry and then chain
> > +	 * link to content_type immediately at index 0.
> > +	 */  
> 
> All this wrapping with extra "hidden" slots is so confusing...

Yes, always takes me an hour to swap the context back in.
I was hoping the diagram would help.

> > +	if (i < msg_pl->sg.start)
> > +		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
> > +			 msg_pl->sg.data);
> > +
> >  	rec->content_type = record_type;
> >  	if (prot->version == TLS_1_3_VERSION) {
> >  		/* Add content type to end of message.  No padding added */
> >  		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
> >  		sg_mark_end(&rec->sg_content_type);
> > -		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
> > -			 &rec->sg_content_type);
> > +		sg_chain(msg_pl->sg.data, i + 2, &rec->sg_content_type);  
> 
> Probably a silly question: why do we need to chain the content type?
> Could we just drop it directly into the right slot of msg_pl?

Good question, IDK either. Maybe anticipating the need for padding?
Do you prefer that as the fix, or follow up in net-next is fine?

> (I'm also a bit puzzled by the "last_filled + 2"/"end + 1", because
> that would leave an empty slot between the last_filled slot and the
> content_type? and maybe even overwrite the first actual message chunk
> if we had filled the message?)

Incredibly confusingly the value passed to sg_chain is the arrays size.
So it's entry target + 1. IDK if that answer your question but it always
confuses me. I even added it to the comment above but looks like I ended
up removing it.

