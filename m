Return-Path: <netdev+bounces-300782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xv/MIHdJNmql9AYAu9opvQ
	(envelope-from <netdev+bounces-300782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 10:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2E6A8894
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 10:04:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="hg BU+SZ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300782-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4E82301C913
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958634252B;
	Sat, 20 Jun 2026 08:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DC18EFD1;
	Sat, 20 Jun 2026 08:04:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781942643; cv=none; b=kPqOT5ytxU5gmm6MYlnzCq77zf9yHAxmWKCsTNNPMI9XTcRELbJtpV+MIL/+OdfEsDlF3MWUvzO4vcXDLqmCQ5oPJ/nRe2v4nvaI69Jky/1qcT0HG0YOYo1UlINinCWQCnIdFWO1XSwofMO9E7/YoThSZ6WZjE5Jc92cIuSWWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781942643; c=relaxed/simple;
	bh=dse7SYszSg3Jlnq5lHfSFp77L84duHmVVEKC5zjH7kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5FyjmPSUSjAyLTKJZyXQKkepZq5QW9dAmnjYq6AqTf/trmsJ/kuOwPm94vnipfsZbHIAheoDr53PqjYBYr1RGFczy8LGWquw16YoKMR/Y9sJS49NfMZJlqONqZqODhIk5AeXDOaWslJh2IwiWs9FOTSoPjdvSmCUZ441QJzeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hgBU+SZd; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=TpBfbDE6ulH2Pjr37Nyu6gVgrN1MUttbzTfMKK6uXyE=; b=hg
	BU+SZdbTdcICq19hQozITwbVEJtsme39PaW67ARYai6a9YaSqQ+B1cWjK0e1bSKq6SVe47LSYeeh/
	zQX+X0RM6VdrxwdcRNpCxTez9y8dsc7RdAeDLxAHxcL6rYjkIjNjXZKgF0fwlylaR9UeJUjDroOgB
	z7JOAhE0jsv07oM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1waqgC-008Zfb-Ev; Sat, 20 Jun 2026 10:03:52 +0200
Date: Sat, 20 Jun 2026 10:03:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 3/4] net: dsa: motorcomm: Dynamically allocate
 port structures
Message-ID: <fc82aaa6-ff6b-4d17-beb2-e6f156e64059@lunn.ch>
References: <20260618202716.2166450-1-mmyangfl@gmail.com>
 <20260618202716.2166450-4-mmyangfl@gmail.com>
 <f9234e83-e9e1-488d-93f5-1f3c20634c87@lunn.ch>
 <CAAXyoMN9a6nncr-C1UDuUQMf4i5FR-9s-sfhSpYLYs5nmh9Uhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMN9a6nncr-C1UDuUQMf4i5FR-9s-sfhSpYLYs5nmh9Uhg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFA2E6A8894

On Fri, Jun 19, 2026 at 02:46:24PM +0800, David Yang wrote:
> On Fri, Jun 19, 2026 at 2:06 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Fri, Jun 19, 2026 at 04:26:31AM +0800, David Yang wrote:
> > > With support for LED introduced later, struct yt921x_priv will be 17k
> > > which is not very good for a single kmalloc(). Convert the ports array
> > > to a array of pointers to stop bloating the priv struct.
> > >
> > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > ---
> > >  drivers/net/dsa/motorcomm/chip.c | 95 ++++++++++++++++++++++++--------
> > >  drivers/net/dsa/motorcomm/chip.h |  3 +-
> > >  2 files changed, 75 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> > > index 6dee25b6754a..d44f7749de02 100644
> > > --- a/drivers/net/dsa/motorcomm/chip.c
> > > +++ b/drivers/net/dsa/motorcomm/chip.c
> > > @@ -548,11 +548,14 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
> > >  /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
> > >  static int yt921x_read_mib(struct yt921x_priv *priv, int port)
> > >  {
> > > -     struct yt921x_port *pp = &priv->ports[port];
> > > +     struct yt921x_port *pp = priv->ports[port];
> > >       struct device *dev = to_device(priv);
> > >       struct yt921x_mib *mib = &pp->mib;
> > >       int res = 0;
> > >
> > > +     if (!pp)
> > > +             return -ENODEV;
> > > +
> >
> > Are all these tests actually needed? If you cannot allocate the
> > memory, i would expect the probe to fail, so you can never get here.
> >
> >         Andrew
> 
> Dummy ports are no longer assigned control blocks (in yt921x_dsa_setup).

This seems pretty error prone. A missing check will result in an
opps. At least it will be obvious. How big is each port structure? Is
the memory saving worth it?

    Andrew

