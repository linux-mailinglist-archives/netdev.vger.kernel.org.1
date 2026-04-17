Return-Path: <netdev+bounces-279399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGobFN124mnh6AAAu9opvQ
	(envelope-from <netdev+bounces-279399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:07:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B041DD11
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C0F43003736
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34B383C9C;
	Fri, 17 Apr 2026 18:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15223451A7;
	Fri, 17 Apr 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449064; cv=none; b=U0cj4JItP9/jvchg3efP/Fws65nDwL1gW0sleHEscK1lavWVxhL0PNKWdogWpds+6SxdcDWL/i/BYYUhV2ImwR00P2gl1Mkcgco445/2IvCAkZkcg5grbsUzG6BWD+Z+WwfMBh1ChugURVVrmB0d2oypcbj5ThG5+klITcfBDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449064; c=relaxed/simple;
	bh=Nr15fqSECyaVyLrYV54mTHvCpSpPQm7NQ/ksujh8my4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3PZ5WIDxJPM6PqrY0dIGc9YVPWGcxCIjVG7xLQm4wbeAQlG+oBll4YmOhr1LB7XRkBXi5hwf+2jsHQD2MOUYl4QfHHIUr3fBHwqxfCGQhK1fvshxMZCrwg93Ir4AfRmGwEC+kh0WPIifPIo/NflXkbyMHcCZ0+0BilLkBKgjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wDnXv-000000007HL-0Cuh;
	Fri, 17 Apr 2026 18:04:03 +0000
Date: Fri, 17 Apr 2026 19:03:58 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Breno Leitao <leitao@debian.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <aeJ2Di7tuIQ5RniE@makrotopia.org>
References: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
 <aeJjcoHyezEgUG_Q@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeJjcoHyezEgUG_Q@gmail.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279399-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,public-files.de,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 773B041DD11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:46:29AM -0700, Breno Leitao wrote:
> On Fri, Apr 17, 2026 at 04:55:57AM +0100, Daniel Golle wrote:
> > @@ -3404,6 +3449,9 @@ EXPORT_SYMBOL_GPL(mt7530_probe_common);
> >  void
> >  mt7530_remove_common(struct mt7530_priv *priv)
> >  {
> > +	if (priv->bus)
> > +		cancel_delayed_work_sync(&priv->stats_work);
> > +
> 
> Shouldn't you cancel the work later, after dsa_unregister_switch()?
> 
> I am wondering if the following race cannot happen:
> 
>  mt7530_remove_common()                  someone reading /proc/net/dev
>     cancel_delayed_work_sync()
>       /* returns: work neither pending
>          nor executing - true at this
>          instant */
>                                           mt7530_get_stats64()
>                                             mod_delayed_work(...)
>                                             /* work is queued again */
>     dsa_unregister_switch()
>     return

Thanks you for pointing this out.
cancel_delayed_work_sync() should be moved after dsa_unregister_switch()
to avoid this kind of race.

