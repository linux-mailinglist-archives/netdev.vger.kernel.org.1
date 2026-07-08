Return-Path: <netdev+bounces-306011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CHjFGE7cTmp1VgIAu9opvQ
	(envelope-from <netdev+bounces-306011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:25:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C38CD72B1F6
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="JPl0K/re";
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306011-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306011-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D031E301468E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 23:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646638B12F;
	Wed,  8 Jul 2026 23:24:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEC384258;
	Wed,  8 Jul 2026 23:24:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553099; cv=none; b=JC4kXw8EE0KEiwRKMVhCBoEFtkeuhfrdgbx0ZnhIaWHsud69rXsYSxTRQuIPUIY3Ml3OqKKbQ3MrvgtjtV6I5IX2VAGmLg7J3IVyZMYvf1YzRiu3uu0kmufR4pUeOuMl67gTnM8PSp5PccOWDqndWsvQIcNMFHMmrKB/PtdIN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553099; c=relaxed/simple;
	bh=colcPy/HvCFD0iHMZo82bzQUXxyVoKK1AehGxTHIq+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw1kT26aB8Yj3apZZ97eostX9mqoOo8c9uJFoxF9bwpzCEh+OgXi0clrW7QkiaxpeLYA1m2V5vgzuISOAZrAqt/3+15jaXMkSx8HFfjzUHn0ju+MRmP+p8so+K4aG19uZ45Ps7jQtFhhDrG0b47SO0xD+NIFQzZYaJzGMuYogpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JPl0K/re; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=73wizBzIsbVDVnLfmPPJAwE4HesInlGCWL7biAiSn+c=; b=JPl0K/reYE6JvwP0l12t2SV0t6
	LtfEpmWKB1ZLCvykwYsuQbKMk+yZZdwaBxvcbzQm2WNuUZ/IP427OA81BZAUdR+6LYCf3vVkcpWg8
	wEZYtPJb7ZxW2Fet0IHnddaZPUPfEoiCWxwCXAaEp0uy7AKTwh55Xr7/nEwhaHsRbJ8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whbdJ-00BPLj-2Q; Thu, 09 Jul 2026 01:24:49 +0200
Date: Thu, 9 Jul 2026 01:24:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <b3fc69ba-9139-4933-9a4f-455393a7cfaa@lunn.ch>
References: <ak0KOrM5E2_sPIHf@makrotopia.org>
 <42792433-a95c-431f-ba0c-dc0644dcbdb5@lunn.ch>
 <ak6s363rweBPZhQZ@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak6s363rweBPZhQZ@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306011-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C38CD72B1F6

On Wed, Jul 08, 2026 at 10:02:39PM +0200, Daniel Golle wrote:
> On Wed, Jul 08, 2026 at 07:27:21PM +0200, Andrew Lunn wrote:
> > > + * The flash process takes approximately 15 minutes. Progress is
> > > + * reported via devlink status notifications. After a successful (or
> > > + * failed) flash the driver reprobes the device automatically.
> > 
> > Have you tested the failed use case?
> > 
> > I assume if the firmware in the flash is invalid, the bootloader does
> > not boot it, and it remains in the bootloader waiting for another
> > attempt. Does this DSA driver still load, so devlink can be used to
> > try again?
> 
> No. Without a running the firmware the driver doesn't probe and only
> a special rescue tool allows to recover the hardware.
> Having the DSA driver detect the presence of the switch stuck in
> mcuboot mode and probe without registering any user or CPU ports
> also isn't straight forward.

And that special rescue tool exists?

Why not wrap it in a script which unloads the DSA driver, let it do
its thing, and then reload the DSA driver?

All the other users of devlink flash that i know of can operate while
the device is still running. So it makes sense for it to be part of
the driver, it is something just going on in the background. This
device is different, so i don't really see the advantage of making it
part of the driver.

     Andrew

