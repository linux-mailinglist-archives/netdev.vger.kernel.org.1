Return-Path: <netdev+bounces-260979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMgNDc4Gn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:27:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F380198B8E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A862301C116
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582E387362;
	Wed, 25 Feb 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kDmLlarz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A272627;
	Wed, 25 Feb 2026 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029317; cv=none; b=Xt/SSd/NX5nUpbHlpez3j/f1mXYnQRh4anO9sN21eHMlmG9qMXHl/fDlcNGkVkki8QGPePmOFyDiJ6MlPsEYOLmRJVpfEX8I6tP/wNPfTstIVqiSIk/XuXgaL9x/Fl4rpBsn0yo+OMM95J+DiJTtiWvZE2hobcHNoQPOMXQKxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029317; c=relaxed/simple;
	bh=/yJB9goswptPCUWhnj+e3XoMlYvzVeG8i5OMylKAlEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da6pwebaAzg75fZ8NcXj8X0fl2GDMwMzJuVbmbZe/ghBCHS8TXAGlxPqB/LmmgbgU4cJX4VPGlB03WnRLUJuB3fH3/TrPXHmfRyxF36IJx3aA2agqXfEgAgVpl2v7ff0h6PxlReyrEaNVDVALb1TL41mo16YPLYUlgTqLe3yqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kDmLlarz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=U0bNEX/g9oEGxx38Gdtazi2VGtPKXCH7XZpQ6BCjdyw=; b=kD
	mLlarzxJrAG2oYqOLwucuxHyGFWVpFr4Mevg38BSzRi8KSlNwD4dzAH78zuibAVgkuI7aAF9CqsuK
	r4fO7vT/IE5hI2xyEmPA1vcNzTWsNQ0f8tkwkw0P4IAIF7HEZwWLga+p9dizZ/WGn8vmhlotnzWIC
	SOZuNg6H4YQ6/7E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvFlt-008kv5-1E; Wed, 25 Feb 2026 15:21:49 +0100
Date: Wed, 25 Feb 2026 15:21:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Refactor long register
 helpers
Message-ID: <26925118-5b6d-4518-b9a1-8df6455c7af5@lunn.ch>
References: <20260225090853.2021140-1-mmyangfl@gmail.com>
 <20260225090853.2021140-2-mmyangfl@gmail.com>
 <cb52e6e5-c047-4190-9e06-4f80a8bef051@lunn.ch>
 <CAAXyoMOVdeScayuJbtNKmS+QVmWdH1_5EGTUsLH9Oc4bkwDoVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMOVdeScayuJbtNKmS+QVmWdH1_5EGTUsLH9Oc4bkwDoVQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260979-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F380198B8E
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:12:36PM +0800, David Yang wrote:
> On Wed, Feb 25, 2026 at 9:52 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > -/* Some registers, like VLANn_CTRL, should always be written in 64-bit, even if
> > > - * you are to write only the lower / upper 32 bits.
> > > +/* Some registers, like VLANn_CTRL, should always be written in chunks, even if
> > > + * you only want to write parts of 32 bits.
> > >   *
> > > - * There is no such restriction for reading, but we still provide 64-bit read
> > > - * wrappers so that we always handle u64 values.
> > > + * There is no such restriction for reading, but we still provide multi-chunk
> > > + * read wrappers so that we can handle them consistently.
> > >   */
> > >
> > > -static int yt921x_reg64_read(struct yt921x_priv *priv, u32 reg, u64 *valp)
> > > +static int
> > > +yt921x_longreg_read(struct yt921x_priv *priv, u32 reg, u32 *vals,
> > > +                 unsigned int span)
> >
> > Just looking at this, it is not obvious what units span is. Many bulk
> > read operations takes bytes, even if the underlying code works in
> > words. I would probably rename span to something like num_u32.
> >
> > I would also keep yt921x_reg64_read, yt921x_reg64_write,
> > yt921x_reg64_update_bits() and just makes them wrappers which call
> > yt921x_longreg_read().
> >
> 
> I don't think keeping reg64_* would make it better. There will be more
> 96-bit regs as subsequent series progressing. It would be more messy
> to have three types of regs: u32, u64, and u32[].

The lower level helper takes a u32[], but your higher level is always
yt921x_reg32_read(), yt921x_reg64_read(), or yt921x_reg96_read(). That
makes it obvious what size you are reading, and keeps your patch
small.

      Andrew

