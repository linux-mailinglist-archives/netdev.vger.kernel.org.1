Return-Path: <netdev+bounces-281939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C3zDvLQ8GnDYwEAu9opvQ
	(envelope-from <netdev+bounces-281939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812C487BF9
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 308B8306632A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F644B674;
	Tue, 28 Apr 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wlOGnx/Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C044BC91;
	Tue, 28 Apr 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388412; cv=none; b=nBokanHwbC+qtTqSWaulC0B/vzrF7syZY58m6tuX0Uj2YWZQpyOE/v2EmSSwYWx/gazTdvkRtpK/4k8mjXocJg2Go4t+LjwjBIdzsJMBKjO0uhb/8gtzT0OJj0Eulm8Duwje+IjzNyX4rhgc3dGdoy0t7OZPOMMfIEOIjfxBE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388412; c=relaxed/simple;
	bh=8eRTBOr56lXyw5Nl1lPGUcROBTmAChk2KA3FfKO+tWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNcMLSIMZ1dUB56WGngVSjo20d95lCR6fIkFe5XP4IsSUchXHBXi5kX/xMa9yqTxvnawb2iBnjAEFS7qKT3gbN9VT9+XIcKFVAHBqXnFVEe+dNmIXVhjqusty81d1ga9xfqutbJPjfaGGBloOy3vatKrF4hkm29ddaEoPQSl4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wlOGnx/Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ThRatxI+ujPQ6DbNmNbwWdlsSWBi02bJgBeBRB/F5PE=; b=wlOGnx/ZeXAh9EdmKTRIryT+5+
	5Aq8f+cuo59z+0RjJMSKp82Q/plTczdwW0MonludM95gzkuVt/KI4GHF/cwa81S/D4xPZVnuab0IM
	xccErjFqLKw/yphhoj5rmImWOnKe4hXxwhh8vboLixOR98ZH/al0/a9y6TjA6IQsh2pE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHjuo-000M3b-FK; Tue, 28 Apr 2026 16:59:58 +0200
Date: Tue, 28 Apr 2026 16:59:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
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
Message-ID: <a0d3eec7-4c11-404f-804c-fa46515d25fe@lunn.ch>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-6-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428072209.3084930-6-mika.westerberg@linux.intel.com>
X-Rspamd-Queue-Id: 9812C487BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281939-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 09:22:05AM +0200, Mika Westerberg wrote:
> Instead of the core driver programming fixed value for throttling let
> the service drivers to specify the interval if they need this. We also
> allow user to tune this through a module parameter if the default is not
> good fit.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/net/thunderbolt/main.c |  7 ++++
>  drivers/thunderbolt/dma_test.c |  5 +++
>  drivers/thunderbolt/nhi.c      | 58 ++++++++++++++++++----------------
>  drivers/thunderbolt/nhi_regs.h |  3 +-
>  include/linux/thunderbolt.h    |  5 +++
>  5 files changed, 50 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 49673f7e0055..8771ca807933 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -218,6 +218,10 @@ static bool tbnet_e2e = true;
>  module_param_named(e2e, tbnet_e2e, bool, 0444);
>  MODULE_PARM_DESC(e2e, "USB4NET full end-to-end flow control (default: true)");
>  
> +static unsigned int tbnet_throttling = 128000;
> +module_param_named(throttling, tbnet_throttling, uint, 0444);
> +MODULE_PARM_DESC(throttling, "Interrupt throttling rate in ns (default: 128000)");

As i mentioned elsewhere, netdev does not allow module
parameters. They are hard to use, especially when you have lots of
instances of a device, or you need to set it on the kernel command
line because by the time the kernel has booted, it is too late, etc.
And they are undocumented, and every driver does it differently.

The correct way to do this for netdev it ethtool -C.

For something which is not a netdev, like your stream file, you have
more flexibility, but the same usability issues apply.

	Andrew

