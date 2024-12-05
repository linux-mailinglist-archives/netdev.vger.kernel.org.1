Return-Path: <netdev+bounces-149301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA09E5108
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19291881D2C
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA51D5AD1;
	Thu,  5 Dec 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="J2idr4gt"
X-Original-To: netdev@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8541D2B13;
	Thu,  5 Dec 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390242; cv=none; b=i8ExLO8NAiQYJBVxV5sLpNs3O6rbzsPDEkCOgZtK+nAD/n6zPBuMxv3qlbfh6MrRHpb/cZVLTvT6j/jSP7JQxBeKcJOtrWRIcSFJ7mwdOgVCdN0sLvuIHvB8cTXOG/qyaiPee7/uXl8dW1oezSFZqztdUZqesDvejs7u+Tcr8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390242; c=relaxed/simple;
	bh=tPbYOTF0CMXSd8R3/KFtKpsnVD4vSkeYcnRwY9b3Bqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEbozIdFPoJNHXSJbO7ShGUgQe13HFCukzlaCwbljqcb9uqEj5cob1jvKW5aImo4WWGhbr6O4Cz1swRqBwKjcZueyKR5yrqa/umv7U78cESDIRVHkhYemlX2fNMguQdzJNKxFiR2+hyZ2wYSYaTyO4KWzBF+nG2mWZEL7xx/bnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=J2idr4gt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6414214C1E1;
	Thu,  5 Dec 2024 10:17:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1733390231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/rxV/5nRAVBGnps3J5CvAOT0C7Js4XrLtzupeueFGE=;
	b=J2idr4gtMfr1K17lm8FmlNmnVmxv2EX2n+4SN5Sd7zjTykC50lSpDzpBF25eyDcx1YTAsm
	raaYkyF+kVlpJvNybYPN2+7yMuziWGT3GBYYu33nac9i9ZTk+iI0j682xFgfBBVVmLEOEO
	DXY9cev6CwJG4a9otsDuRUJjXHrr+Xvu/KyIzq8oxVPZ0d0UlpOYHKMoEuoYC/5YTOZwsF
	LMG2zeL0t9UlPJqXYK0ZN3FGNJBQrQIkv4+m3/EHZtKpy6+WzGlj6dG3taL8DGZzql5CHq
	WUSe6WUvF8nCJ4fzqmhMC7dqUfk9chVk8PKvFAOu2wqUTE6l4eBdYCR5JCEOaQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 19df8861;
	Thu, 5 Dec 2024 09:17:06 +0000 (UTC)
Date: Thu, 5 Dec 2024 18:16:51 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for local
 mac addresses
Message-ID: <Z1Fvg7mJv0elnuPL@codewreck.org>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
 <5b93b521-4cc8-47d3-844a-33cf6477a016@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b93b521-4cc8-47d3-844a-33cf6477a016@lunn.ch>

Andrew Lunn wrote on Tue, Dec 03, 2024 at 09:47:57PM +0100:
> On Tue, Dec 03, 2024 at 10:04:55PM +0900, Dominique Martinet wrote:
> > From: Dominique Martinet <dominique.martinet@atmark-techno.com>
> > 
> > The previous commit assumed that local addresses always came from the
> > kernel, but some devices hand out local mac addresses so we ended up
> > with point-to-point devices with a mac set by the driver, renaming to
> > eth%d when they used to be named usb%d.
> > 
> > Userspace should not rely on device name, but for the sake of stability
> > restore the local mac address check portion of the naming exception:
> > point to point devices which either have no mac set by the driver or
> > have a local mac handed out by the driver will keep the usb%d name.
> 
> Are you saying the OTP or NVMEM has a locally administered MAC address
> stored in it?

I'm afraid so... (At least the Gemalto^W Cinterion^W Thales^W Telit
ELS31-J we use on a couple of boards seem to do that, it's soldered on
our boards so I can't swap it out easily to confirm but the mac address
is stable accross reboots)

The good news is that after having been sold at least 4 times it's been
made EOL now, so in another 12-ish years I'll probably be able to ignore
this particular problem :)


> Is there a mechanism to change it?

Looking at some confidential documentation I found on our file server
there seems to be an usb function that contains the mac address and
various ethernet statistics, but it's not clear to me if it's actually
writable or even how to actually use it in practice and it was certainly
not designed with being modified in mind.

(I suspect there should be some vendor AT command that would allow
overriding the setting somewhere but I can't find that either)

OTOH, just changing the mac locally (ip link set usb0 addr
02:12:34:56:78:90) works and dhcp gets me a new IP, so it's not like
overriding it is a problem either.
(interestingly putting the old mac back gets me the old IP back, so
there's a real dhcp server with leases behind this and I suspect I
could just bridge this out and it'd work as expected...) 


> The point about locally administered MAC addresses is that they are
> locally administered.

Honest question here our of curiosity, my reading of a few random pages
on the internet is that it would be acceptable for the modem to randomly
generate it?
(under the assumption that e.g. a reset would clear it and get me a new
mac)

Or does it have to be assigned as late as possible, e.g. we'd want linux
to be generating it in this case?


Thanks,
-- 
Dominique

