Return-Path: <netdev+bounces-253186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCtJMgdBdmm6OAEAu9opvQ
	(envelope-from <netdev+bounces-253186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:12:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DD981663
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A2D30000B0
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AE326924;
	Sun, 25 Jan 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LXbTQONU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E84318135;
	Sun, 25 Jan 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357572; cv=none; b=QK2GDVS7JRCvVcNSH1xK9+lsUp77TDzSG3YNrGRL54GAFEAa581kz6H+0RH+JmntbS8ffUU5CMUHTmlFx3DIkisYNJji5GAPFpYmhI54sCMkbKG4Ru2j1Nj2UKUZWccEMKbv+Fqs03rnKsUI4mVUz7TEcvyG0K3so+FSGmc/6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357572; c=relaxed/simple;
	bh=/MRFa+ksUtXOLYbtnhs8ngTi9AE+YCeO2EQ6syig3dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R870UXPnadtYHx94FqZ5WiUekNhnorXhGlANuONLJ1XOxm5cA+7jzATsMs6holAHtnp7ABgJGo7L3X0rwVfVd5nwF08yOnVQV+jvWjPUTAqWSRfEXvrnoTYI6mOWD4V0o6C2uAiPEjHRXNnN+Uu2vfmJ6RCQtAHTcZ6VGgtMvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LXbTQONU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yFYTbKXLQNYZ18jNwg6Ic/NTRPunDNzNmi8acNRMIX8=; b=LX
	bTQONUnK2y9RrfXtg+AHPtPV9W9L8l5BNZ45hRFWv3Yz1T+9qLlI+urJ7+3BiwjiG05KjIMtga5ZI
	x460cvxc761DrfMVJ8LwzbTDjBW8mwxFG39881ZQvCcdpUuqTwkyx0xjfml46GPUg8HwMW7127pLH
	yzu/RM3sCtbWtOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vk2jG-004ceV-DT; Sun, 25 Jan 2026 17:12:46 +0100
Date: Sun, 25 Jan 2026 17:12:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH net-next] net: usb: introduce usbnet_mii_ioctl helper
 function
Message-ID: <0a082885-5506-40d6-8871-056ef6cf3502@lunn.ch>
References: <20260124080136.75619-1-enelsonmoore@gmail.com>
 <8d17a810-9e74-4ef1-8fa7-3267a8678b40@lunn.ch>
 <CADkSEUig7Pp66nDx5ch+txDfNcbLj1wRUbC3n4a4pBuc9mBb4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUig7Pp66nDx5ch+txDfNcbLj1wRUbC3n4a4pBuc9mBb4Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253186-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 27DD981663
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 06:53:57PM -0800, Ethan Nelson-Moore wrote:
> On Sat, Jan 24, 2026 at 10:48 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > You are doing the same as phy_do_ioctl(), but for the old mii
> > code. However, we also have phy_do_ioctl_running(). It might make
> > sense to add usbnet_mii_ioctl_running()?
> 
> Hi, Andrew,
> 
> It makes sense in principle, but after applying my patch to smsc95xx
> to use phy_do_ioctl_running, smsc75xx is the only driver that would
> use such a function, so it would add complexity rather than removing
> it.

It is not always about complexity. The mii subsystem is in Maintenance
mode only. Has been for a decade or more. All development work is done
in phylink and phylib. Ideally, drivers using mii should move over to
phylib.

I don't actually expect many will, it requires a driver Maintainer who
cares to do the work. It might however be an good "intro to kernel
hacking" for newbies, since such USB dongles are cheap. And anybody
doing such a conversion would likely learn a lot more than mindlessly
fixing checkpatch and other tools warnings.

usbnet_mii_ioctl_running() would be a hint to use
phy_do_ioctl_running() with such a conversion.

   Andrew

