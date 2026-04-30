Return-Path: <netdev+bounces-282550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j1yWCDKe8mlQtAEAu9opvQ
	(envelope-from <netdev+bounces-282550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:11:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93FC49B91E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A6BB300B444
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4100FE573;
	Thu, 30 Apr 2026 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5eYj4O1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21F8C1F;
	Thu, 30 Apr 2026 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507886; cv=none; b=JKppHO/5OEaI1/82OihlLbS9w+YEzvrpUxAQ/Bx109Y5FySfmC8QuxlV4OxVv8sRhprHLbhWjRf0Sbp7qvXIwdK+UQarkcSmkIInZyAEru/AslhakI2AZP/GWHiwzrOssS6QkwjP8waqqM2LUw8zqzHYRI2x1VmRjD9/2d/lSNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507886; c=relaxed/simple;
	bh=dikwfBZQLqVyHWFgcP3YIUb72CSXierGUN7ylhD4tqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWx0LRIHtQkpJJFMyzVxemaf6yAUWydny3Vzy5pn7BxjgSRRyn5ZKp4e/bDSZftVwMZFkZRobIsrClJcWJXSBX475ooqSeasyjfahoKu2uIhFWHw677hiEwCnibeak1jcsNdmfRxHDrBnYGajHm3ysep51g7d/kkajEkwnEzvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5eYj4O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D787C19425;
	Thu, 30 Apr 2026 00:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777507885;
	bh=dikwfBZQLqVyHWFgcP3YIUb72CSXierGUN7ylhD4tqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i5eYj4O119jYEsy0klfzCIF1GB1FqS6Ouh8OxOOtvCMEMUC1rqkMMP8dZHD6ibO6c
	 vkI7Ugl1oHOkQ9p0V/YKTm/f2rNTE/IOz/WGu6K+KKh2rKOGVTFzNlOoC5rNNLFtty
	 FDkCE74GzLMLZzuMN1nDq2khMsX1kCbXN5AAE1uuL8egfSbTpWeQoPmO5BxOzJeRvj
	 pHNQOOyO3FtpwEObXy6k37MjIWj36yjk0nhzaWYV+5/OOoR/Fuq34EzbuOTPu6GGEk
	 2+8Nnea0Uf9SCoN1Ji2p4M8Vu1/5t2OtrHmiQGw51/EzmyjvMdW7ycUYgmVHQWGLjc
	 jrTgEa4muZF6Q==
Date: Wed, 29 Apr 2026 17:11:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chester.a.unal@arinc9.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, ansuelsmth@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <20260429171124.07787599@kernel.org>
In-Reply-To: <afKaVQ27GUQiWZTb@makrotopia.org>
References: <16efd278e4f17776ccfbf8491e5be71a4689c137.1777385305.git.daniel@makrotopia.org>
	<20260429234612.2240476-2-kuba@kernel.org>
	<afKaVQ27GUQiWZTb@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B93FC49B91E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 00:55:01 +0100 Daniel Golle wrote:
> > > @@ -3409,6 +3476,9 @@ mt7530_remove_common(struct mt7530_priv *priv)
> > >  
> > >  	dsa_unregister_switch(priv->ds);
> > >  
> > > +	if (priv->bus)
> > > +		cancel_delayed_work_sync(&priv->stats_work);  
> > 
> > Could this call cancel_delayed_work_sync() on an uninitialized work struct
> > if the driver is unbound before the DSA switch tree completes?
> > 
> > The priv->bus pointer is initialized during probe. However,
> > INIT_DELAYED_WORK() is only called in mt753x_setup(), which might never
> > execute if the DSA tree remains incomplete.
> > 
> > If the driver is unbound in this state, mt7530_remove_common() will evaluate
> > priv->bus as true and pass a zero-initialized work struct to
> > cancel_delayed_work_sync(). This usually triggers lockdep ("trying to
> > register non-static key") and debugobjects ("assert_init not available")
> > warnings.
> > 
> > Would it be better to move the INIT_DELAYED_WORK() call into the probe
> > path or track whether the setup function was actually completed?  
> 
> Not sure if this is real. The fix could be simply
> 
> 	if (priv->bus && priv->ds->setup)
> 		cancel_delayed_work_sync(&priv->stats_work);
> 
> Anyone?

Not sure how much of the D in DSA is actually implemented but in terms
of fix why not do what the bot suggests?

