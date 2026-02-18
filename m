Return-Path: <netdev+bounces-259241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N8vLBKIlWnqSAIAu9opvQ
	(envelope-from <netdev+bounces-259241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:36:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E30154C33
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED1A63010245
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555833A9DF;
	Wed, 18 Feb 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnH8X0+s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE1319864
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407374; cv=none; b=Q/UuOV5JUEwaPbX6OzP512BXxThBemMdAsOxu88hlmXxD52pyVW/Z6Yciok1qAbo5zjr6YZdftN1h5ispaX1VGCkG8mNz81V/azxmJXPJRL1l7qd7fAwiQ6stsngHLxVJIjPoDy/nn0UCfd625zYnLxPoxZcRrqDBxIwYtyBK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407374; c=relaxed/simple;
	bh=gQ6MPdOMsERvQzft4Tv59+KHrFI9aFUHwFWACOmrb4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh4s4foacw/3Z/mG8GGLbD/LwB29eM6+LKOJzZwPTPIWaao6vXlsjpvESlvsIDKCEBxBS2AHrdVWLLf0UEOGLkcacLwgXykxDDnOuS7gb71xVw3mzzUCYL4dYKkTZ7aKU8DLjjMpfHozsAKOsNg9oQ7mfPhjcwEfcKMgc5NJjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnH8X0+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C59C19421;
	Wed, 18 Feb 2026 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771407373;
	bh=gQ6MPdOMsERvQzft4Tv59+KHrFI9aFUHwFWACOmrb4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnH8X0+sOUAV/I0guIN1x+gT+m0cYPyCmdXutoy9CZOrjafGVGFLZ9NcI+KGp0K1s
	 /4oMOhoVz0oZkIfXJiZvB2gozMm+smiX8V9cZLZg7/h8SyYnQpD5QH6gMV5JfW2ypz
	 9DI9jVgYlaF56pI3BWwOayP4OKKKP76rxJeZJKnZGmk9iRyVHKI9xTKvK0hS4OM9IH
	 2SKwwIx0HNsalVLY27hdMBiZjgy4wrsRabr+GEKXwUTzZ7ZBR1cPRe/Yhq5S80r/Tr
	 xXYnn32LFihtoupGO3/ocgf0+sr6Q/UMgs5hziDFyOK51CsmUtEU3iR3Y7rzRXTgTj
	 VEFy16s8C2EjQ==
Date: Wed, 18 Feb 2026 09:36:09 +0000
From: Simon Horman <horms@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: tls: Use disable_delayed_work_sync() instead of
 cancel_delayed_work_sync() in tls_sw_cancel_work_tx()
Message-ID: <aZWICa8b0JF4fWq3@horms.kernel.org>
References: <aZLotq3aZY0b-dI8@v4bel>
 <aZSLHaFj7k8DPmLG@horms.kernel.org>
 <aZSbSOVuRgkjeezg@v4bel>
 <aZWHpBwpMVTUNYTg@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZWHpBwpMVTUNYTg@horms.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 15E30154C33
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 09:34:32AM +0000, Simon Horman wrote:
> On Wed, Feb 18, 2026 at 01:46:00AM +0900, Hyunwoo Kim wrote:
> > On Tue, Feb 17, 2026 at 03:37:01PM +0000, Simon Horman wrote:
> > > On Mon, Feb 16, 2026 at 06:51:50PM +0900, Hyunwoo Kim wrote:
> > > > After cancel_delayed_work_sync() is called from tls_sk_proto_close(), 
> > > > tx_work_handler() can still be scheduled from paths such as the 
> > > > Delayed ACK handler or ksoftirqd.
> > > > As a result, the tx_work_handler() worker may dereference a freed 
> > > > TLS object.
> > > > 
> > > > To prevent this race condition, cancel_delayed_work_sync() is 
> > > > replaced with disable_delayed_work_sync().
> > > > 
> > > > Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
> > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > 
> > > Hi Hyunwoo,
> > > 
> > > Thanks for your patch(es).
> > > 
> > > Some feedback on process from my side.
> > > You can read more about that at
> > > https://docs.kernel.org/process/maintainer-netdev.html
> > > 
> > > * I think it would be good to mention how this problem was found.
> > 
> > Hi Simon,
> > 
> > Thank you for the feedback.
> > 
> > This issue was found during a manual code audit. I will add this 
> > information to the commit message.
> > 
> > 
> > > 
> > > * As a bug fix for code present in the net tree, it should be targeted
> > >   at that tree like this.
> > > 
> > >   Subject: [PATCH net]: ...
> > > 
> > > * Looking over git history, it seems that an appropriate prefix
> > >   for patches for this code is 'tls: '
> > > 
> > >   Subject [PATCH net]: tls: ...
> > > 
> > > * Also, please try to make the subject a bit more succinct
> > > 
> > > > ---
> > > >  net/tls/tls_sw.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > > > index 9937d4c810f2..b1fa62de9dab 100644
> > > > --- a/net/tls/tls_sw.c
> > > > +++ b/net/tls/tls_sw.c
> > > > @@ -2533,7 +2533,7 @@ void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
> > > >  
> > > >  	set_bit(BIT_TX_CLOSING, &ctx->tx_bitmask);
> > > >  	set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
> > > > -	cancel_delayed_work_sync(&ctx->tx_work.work);
> > > > +	disable_delayed_work_sync(&ctx->tx_work.work);
> > > >  }
> > > >  
> > > >  void tls_sw_release_resources_tx(struct sock *sk)
> > > > -- 
> > > > 2.43.0
> > > > ---
> > > > 
> > > > Dear,
> > > > 
> > > > The following is a simplified scenario illustrating how each race can occur. Since tls_sw_cancel_work_tx() does not hold lock_sock(), it can race with tls_write_space().
> > > > ```
> > > >           cpu0                                             cpu1
> > > > 
> > > > tls_sk_proto_close()
> > > >   tls_sw_cancel_work_tx()
> > > >                                                     tls_write_space()
> > > >                                                       tls_sw_write_space()
> > > >                                                       if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
> > > >     set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
> > > >     cancel_delayed_work_sync(&ctx->tx_work.work);
> > > >                                                       schedule_delayed_work(&tx_ctx->tx_work.work, 0);
> > > > ```
> > > 
> > > I think that the text above would be best included in the patch description.
> > > At least for me it is fundamental to understanding the problem.
> > 
> > Understood. I will add the race scenario description to the patch.
> > 
> > > 
> > > > 
> > > > Best regards,
> > > > Hyunwoo Kim
> > > > 
> > > 
> > > I see three similar patches on the mailing list.
> > > The comments above go for them too.
> > > And It would probably be useful to just handle one at a time,
> > > to allow for proper feedback. Or bundle them in a patchset.
> > 
> > Since the core of this bug pattern is espintcp, I will submit a revised 
> > espintcp v2 patch shortly. 
> > I would appreciate it if you could review the espintcp v2 patch. 
> > Once the espintcp review is done, I will apply the feedback to the 
> > remaining strparser and tls patches as well.
> 
> Thanks.
> 
> I have looked over the espintcp patch.
> 
> It looks good to me. But I think it would be good to include
> some sort of race analysis in the commit message: something similar
> to the cpu0 / cpu1 text above, but perhaps with a different case explained.
> 
> Also, I think the other comments above apply to that patch too.
> 
> I will respond to that patch pointing to this message.

Sorry, I was a bit hasty there.
The comments above are for v1.
I'll look over v2 and respond there.

