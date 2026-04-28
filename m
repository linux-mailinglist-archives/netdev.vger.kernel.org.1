Return-Path: <netdev+bounces-282043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e7u/IpX48GlpbgEAu9opvQ
	(envelope-from <netdev+bounces-282043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:12:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70448A7FF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A830306EE1A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B901472769;
	Tue, 28 Apr 2026 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FwGdACcE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PsZGnXFe"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722C41C31E;
	Tue, 28 Apr 2026 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399892; cv=none; b=IJxJq/Ktbff/h31vaPOoZwIvKRtXM6SU3EYUGkIqqMVEttU39u47QYJCKOhjlp3li5C4uT7englTmt8cPXe8OOw35zjfTp/BwiPiOLE2O5BzNoEXLZZ/qYWFlKK9KooR7FwsOHaYYY6FNJ6VJy797W3F7+dCoPv9nyTVBLNyPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399892; c=relaxed/simple;
	bh=UWGzQNftb8o8DGBooX3MXOLEiUysLsUT+gtpcYxnW+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFCFDqcDk0viFU3v5wUq9uLWEGh98NyG68cAGo51jVJznPQlWSKy3LKSsXRelNvQ7AMezC4spjdKlYGDCypaUhML2UW+HlDZd4icabYgCCrWG40ur9/QvtMZ8nmb3hieHtmkDOS8SfXa6I3iVIX9/0qdE9m/yiPUtZVzAkOjzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=FwGdACcE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PsZGnXFe; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 8E7991300E69;
	Tue, 28 Apr 2026 14:11:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 28 Apr 2026 14:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777399888; x=1777407088; bh=jRVLkUu+1D
	UdYPI1Lcftxijdj9hZ7OVSGf1XeqNrozw=; b=FwGdACcEnSvrpvbTfrMPjrIkJv
	KGZnM1oWOaRRCkQleoPFNPOjuvr81vKjEsM0JN3cBwM0QZ6WF3lDJUyCP78R4zJU
	n22CI18dmi8QrXo+HHkOITi3vOR8iFbIz336VSQxoKPTtfZb+btfSC2KEjvwkZb1
	3sv0dvqOA8cmdOCIaHmlwmQACPfsFPvm/bJmXQN2KYIPOL7II7hE2EeHOw2bdRbX
	pSbmKX0HJGWhJSnIao6pf/1c3vNsDXCzQiaSCmkVCi4x+XRDT5rKur1UIt5GlfF2
	RmieF2OAV0V+slRYE7eCvGZzUUb2u5YgRwX9kHQJzwvzERfGpUzneyOk81IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777399888; x=1777407088; bh=jRVLkUu+1DUdYPI1Lcftxijdj9hZ7OVSGf1
	XeqNrozw=; b=PsZGnXFes5woefYvRPXJpJaG8yvOFbWqe3blOjMVrhiSyLqFIke
	GUN0VCNI+Ou7ugttxPAEHl/PTycT/s7urY61pBFl6QuANl3nlvdSBPk6vcXOma48
	amjZ93FthjhsKh/haYkc+NhoTaBmqzOfvlMeNrc7/pIr/5S2267Y9Ce95BFGQUy3
	ewCGtPrABOOKttw6wgEJcly/+43plKHgRnZnAJAjKDAnO4pjM75x2rUTdC2QDyvX
	fOcOJHbwwS3xMHuEzorQPyUvUq0NaMOzaQ313jSuZ5UcKui6aPCYvJOyctysnemE
	CO+6zWu50Xhzw3nXmMFUdGuAaO8m/Zqhczw==
X-ME-Sender: <xms:T_jwadUn-CtnAXA52Su38s2Y-GWBGVIIiZ4NJdTX2g771iju8LODLA>
    <xme:T_jwaW6FLAxJv3XHWt2hYvV-RiahdlZVjcIXlGTo1tZEQobYY7Of5AlMkFmx09csG
    QoxR0sMypny73vXWAR2MQaWeWdp8kfyKCm5yYmZO80fcMEqcA>
X-ME-Received: <xmr:T_jwaRYND96jaB8GIf45V5HrGQy-G6d8fTwJJh1AvKJKYcfAxe79uzZ7BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugidquhhs
    sgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihvghhvgiikhgvlhhshh
    gssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdp
    rhgtphhtthhopegrnhgurhgvrghsrdhnohgvvhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopegrlhgrnhdrsghorhiivghsiihkohifshhkiheslhhinhhugidrihhnthgvlhdr
    tghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-ME-Proxy: <xmx:T_jwaaC1gXogkYAn5W4vQEkAKmuBOLPYsnOKJGTZIAPLRAgoMcjvnA>
    <xmx:T_jwaSq_2YXJRjAt5JB4I03Nnfnp-Jpw6xFNRZ9OVkxrSWfatkW1uA>
    <xmx:T_jwaYJ4Jf73p5PQ-OvMlVggvks5nyTweNcBm9NrIugF377SQYU_wQ>
    <xmx:T_jwadQxtT35Qq7TtlR7Qv2MM5bjo_Scwf60rI-sLiDdULwHGwH5Ug>
    <xmx:UPjwady4iLJk3JhGpGdX5EtIn1d9SuKgZF0tN6pvhnB_9yfj5oo-gnfq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 14:11:27 -0400 (EDT)
Date: Tue, 28 Apr 2026 12:10:49 -0600
From: Greg KH <greg@kroah.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-usb@vger.kernel.org,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 5/9] thunderbolt / net: Let the service drivers configure
 interrupt throttling
Message-ID: <2026042827-pep-deeply-edc9@gregkh>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-6-mika.westerberg@linux.intel.com>
 <a0d3eec7-4c11-404f-804c-fa46515d25fe@lunn.ch>
 <20260428172629.GW557136@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428172629.GW557136@black.igk.intel.com>
X-Rspamd-Queue-Id: CE70448A7FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282043-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,gmail.com,wunner.de,linux.intel.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]

On Tue, Apr 28, 2026 at 07:26:29PM +0200, Mika Westerberg wrote:
> On Tue, Apr 28, 2026 at 04:59:58PM +0200, Andrew Lunn wrote:
> > On Tue, Apr 28, 2026 at 09:22:05AM +0200, Mika Westerberg wrote:
> > > Instead of the core driver programming fixed value for throttling let
> > > the service drivers to specify the interval if they need this. We also
> > > allow user to tune this through a module parameter if the default is not
> > > good fit.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/net/thunderbolt/main.c |  7 ++++
> > >  drivers/thunderbolt/dma_test.c |  5 +++
> > >  drivers/thunderbolt/nhi.c      | 58 ++++++++++++++++++----------------
> > >  drivers/thunderbolt/nhi_regs.h |  3 +-
> > >  include/linux/thunderbolt.h    |  5 +++
> > >  5 files changed, 50 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > > index 49673f7e0055..8771ca807933 100644
> > > --- a/drivers/net/thunderbolt/main.c
> > > +++ b/drivers/net/thunderbolt/main.c
> > > @@ -218,6 +218,10 @@ static bool tbnet_e2e = true;
> > >  module_param_named(e2e, tbnet_e2e, bool, 0444);
> > >  MODULE_PARM_DESC(e2e, "USB4NET full end-to-end flow control (default: true)");
> > >  
> > > +static unsigned int tbnet_throttling = 128000;
> > > +module_param_named(throttling, tbnet_throttling, uint, 0444);
> > > +MODULE_PARM_DESC(throttling, "Interrupt throttling rate in ns (default: 128000)");
> > 
> > As i mentioned elsewhere, netdev does not allow module
> > parameters. They are hard to use, especially when you have lots of
> > instances of a device, or you need to set it on the kernel command
> > line because by the time the kernel has booted, it is too late, etc.
> > And they are undocumented, and every driver does it differently.
> 
> Right. This was meant to be a "chicken bit" or "escape hatch" not something
> used in daily basis.

Put it in configfs if you really want it.

You shouldn't need any new module parameters.

thanks,

greg k-h

