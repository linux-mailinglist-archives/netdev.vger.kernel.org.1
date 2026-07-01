Return-Path: <netdev+bounces-303784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tzo6GmRPRWqq+QoAu9opvQ
	(envelope-from <netdev+bounces-303784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:33:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10996F05F9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:33:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=RDCtjEKy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303784-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 819363009CD3
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5E4B8DF1;
	Wed,  1 Jul 2026 17:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC849251C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:32:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927156; cv=none; b=nIY19rMC+XE+2xWvVZZUU6heU3rAXBZbRulIZQkD5P7f8/X4ny0yBFb1EWe8/yeUw6/ARsfz2rOPPnnbIBn2iWIAubPVczHAcy0k/UrGIN6hrLiuQjv7ZoGaFh0yj709m1aeNYVNNbP/4ZUk+XyfKvKv1pEHXHazhE/2kx5bKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927156; c=relaxed/simple;
	bh=+5WbAPI6giF0rN2NhE/RAchERp6a7S7eH7PbLr/l2tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7lFZ5M/DLcjxLbYi2M1GEm6KIjh22yJY0QAO9eLLBPEuxqXc2c/YJHG4Hsa9kDO6H/7dDqOBBQu88BQtaDvF5lOfWjB6pcGOyjId2ro3nbTUQwmlo5QrSxwT4K6L9AfRN/L1+vMT1Chq63LOUxmjpawMSyqE3XCHPdEM58Cu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RDCtjEKy; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bfZjKiEBjis0+ejAXoyWi/BTqw+kp2F5Q3eJhJCjT3w=; b=RDCtjEKyaoYj276FEFC7HRzAf9
	JTa6GnE5bzArs0Y7np5IZON8h7zXb5Lrd3BsdR16PPxJEnbE773//hyS2f1v/FtP4QBzAv3MihqeC
	fFLx1LcTvGbmT/ysSbc9zmLFpOTxhS4Pka+PrdYYNCnk/UO8tfxXGv+47+JAs9qRrylM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weynW-00ADZx-Fc; Wed, 01 Jul 2026 19:32:30 +0200
Date: Wed, 1 Jul 2026 19:32:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Das, Shubham" <shubham.das@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
References: <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shubham.das@intel.com,m:alexander.duyck@gmail.com,m:lee@trager.us,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:vijay.srinivasan@intel.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,trager.us,bootlin.com,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B10996F05F9

On Wed, Jul 01, 2026 at 05:10:43PM +0000, Das, Shubham wrote:
> > Sorry, but i could not implement that, in a sensible way, given its current
> > specification.
> > 
> > I suppose i could simply flip the first `inject-error-count` bits, and make the rest of
> > the stream perfect? I could also wait until the stop command is received, and
> > then flip that many bits before i stop the stream? But none of these seem
> > sensible.
> > 
> > Please make this specification have sufficient details, or references to 802.3, that
> > you could give it to another engineer and get back a reasonable implementation,
> > without having to answer any questions.
> 
> Andrew,
> 
> IEEE has clear documentation of the PRBS Receiver block and the BER counter as an output.
> Before performing the actual BER validation, it is a usual industry practice to introduce errors
> to guarantee that the checker is functional and accurately identifying them.
> 
> Similarly, in DATA mode, error injection is used to verify the FEC block
> by ensuring that injected errors are detected and corrected as expected.
> 
> Updated description.
> 
> +        name: inject-error-count
> +        type: u32
> +        doc: |
> +          Request the PHY to inject exactly this many bit errors into the
> +          currently active test data stream.
> +
> +          This is a diagnostic tool used to validate that the far-end PRBS
> +          checker or FEC decoder is functioning correctly. For example,
> +          after enabling a PRBS pattern and confirming ber-lock-status is
> +          locked, injecting N errors should cause ber-error-count to
> +          increment by exactly N on the receiving port, confirming the
> +          checker is actively detecting bit errors. Similarly, in normal
> +          data mode with FEC enabled, injecting errors verifies that the
> +          FEC block detects errors as expected.

There is no mention of how many frames to send in the stream. I don't
think that is part of the API? Because we have no idea of how many
frames will be sent, it is not possible to distribute the corrupted
frames over the duration of the stream. So that means i should flip
one bit, anywhere in the first inject-error-count frames. All frames
after that should not have bit flips. The assumption being, the stream
has a minimum of inject-error-count frames, and if the stream is
short, the counter will be too low. But it does not matter if the
stream is longer.

Your description has no mention of frames. Should it? What exactly
does the ber-error-count count? Can multiple bit flip within one frame
be counted individually? I don't see how, since the checksum just says
the frame is bad, and cannot report how bad.

As i said, give this description to another engineer and ask him/her
how it could be implemented.

https://www.youtube.com/watch?v=j-6N3bLgYyQ

	Andrew

