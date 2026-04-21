Return-Path: <netdev+bounces-280231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA9mEC7W52nTBQIAu9opvQ
	(envelope-from <netdev+bounces-280231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:55:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B843F1E7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595A6301F30A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3F37F744;
	Tue, 21 Apr 2026 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N4tTsZ1H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9F2773F0;
	Tue, 21 Apr 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801227; cv=none; b=CMlBh6I/KhGWzi4uOV3x0B6gsf1dWLDMmFRRIXH4XN4JstHgLwm8xLYAraehDows1q3Vmx8+hndbuqy7E/tmkuJv4Rrqj1cRtRO7hMwMIhqoFtS20iCgx7ie66prMZIKFHkixEeNni2ueEy0dNNOPCHLZWSrE/lpBDXGSn3pQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801227; c=relaxed/simple;
	bh=FaFB+DFyDWRWp5z+fgy1T/7I2LSiLos4OcuENnmIcUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O920TPk4rn0o/vsmmJQQG2+44zC7c58WqOdPAFWpjaRN/nGxM50q3wUiwqe2vbj9OTS6TkRIQTnLN6OW8IxUpmcAhweh5Gc8oPwQqkp19afGQaXV4vX4dDXW2LXEjHQ77bL8dCJ2VBI4GMg6HQGk5Bg+t0CRy0GwijBUBmacqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N4tTsZ1H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cwTGCdWh4RgUZd0GLY5pjfI07uMKtrCjhIjcs2S8+1M=; b=N4tTsZ1HVZKC1WFCoJ5mOaY0W7
	6HHo7selJTlKeBTU2zlkfgR3M57zKU20BN1a+/gU2/cg3FVANXfES2IWFfMXWM+fwCIlZ5zG+PUFP
	fSeSmbqvcGwOQ65G2Pjeqd1xYhlUe13F6jnT0Axfc8DkNNi8VISLpGK9lOdjnIJz1LO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFHAA-00Gwfb-86; Tue, 21 Apr 2026 21:53:38 +0200
Date: Tue, 21 Apr 2026 21:53:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <87441489-afea-44c4-afd9-8f1693b32ce6@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280231-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 990B843F1E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:31:03PM -0500, Andrew Lunn wrote:
> These old drivers have not been much of a Maintenance burden until
> recently. Now there are more newbies using AI and fuzzers finding
> issues, resulting in more work for Maintainers. Fixing these old
> drivers make little sense, if it is not clear they have users.
> 
> These are all ISA and PCMCIA Ethernet devices, mostly from the last
> century, a couple from 2001 or 2002. It seems unlikely they are still
> used. However, remove them one patch at a time so they can be brought
> back if somebody still has the hardware, runs modern kernels and wants
> to take up the roll of driver Maintainer.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Andrew Lunn (18):

There should be 18 patches in this series, but it seems like b4 send
and exim are not working together too tell and have truncated it to 10
:-(

I maybe have a fix, but i will wait the usual 24 hours before
retrying.

>       drivers: net: 3com: 3c509: Remove this driver
>       drivers: net: 3com: 3c515: Remove this driver
>       drivers: net: 3com: 3c574: Remove this driver
>       drivers: net: 3com: 3c589: Remove this driver
>       drivers: net: 3com: 3c59x: Remove this driver
>       drivers: net: amd: Remove hplance and mvme147
>       drivers: net: amd: lance: Remove this driver
>       drivers: net: amd: nmclan: Remove this driver
>       drivers: net: smsc: smc9194: Remove this driver
>       drivers: net: smsc: smc91c92: Remove this driver
>       drivers: net: cirrus: cs89x0: Remove this driver
>       drivers: net: cirrus: mac89x0: Remove this driver
>       drivers: net: fujitsu: fmvj18x: Remove this driver
>       drivers: net: xircom: xirc2ps: Remove this driver
>       drivers: net: 8390: AX88190: Remove this driver
>       drivers: net: 8390: pcnet: Remove this driver
>       drivers: net: 8390: ultra: Remove this driver
>       drivers: net: 8390: wd80x3: Remove this driver

You should be able to tell from this what is missing, and i would like
to remove.

    Andrew

---
pw-bot: cr

