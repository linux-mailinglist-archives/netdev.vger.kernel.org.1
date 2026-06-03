Return-Path: <netdev+bounces-294828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6bRrN5JTIGqI1AAAu9opvQ
	(envelope-from <netdev+bounces-294828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:17:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 720F26399EE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:17:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=rV5Nt2r9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294828-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294828-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D940C30A3FA8
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC33E0C70;
	Wed,  3 Jun 2026 16:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318963E16B0;
	Wed,  3 Jun 2026 16:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503045; cv=none; b=QQXNr9B/8HgeS1aDNEa/D4KgnPoUpaXaxX+snrja8AwzTqjVBqGDOUp1fvIpCwTJ4EP9e7iP4TS7Zt07xU3Cfvm5K+DfE+wKkonAb891LdJq3gm+hZRJ0wPLXDGDO6vT97I+fzkFWhYMbZRYnJj9CmaxtE7PvVUDBDwohhKdxPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503045; c=relaxed/simple;
	bh=LmyBxm+sQtwIQ2mXoo+xzE30jg9pR4UPA0NQ+oP1+mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZsRUSbRn9gs30dsyXSsFcLyRlr/rfLlyZtbPmpv6z4llAA8s/BTsjqTBMweN9VxaYHfY8M1cDx9co9gTrHEkR/NKyg/y9dxDTJA9EuxfVOJVpJI1xdqEq3uSJOpkzP/gy2gUYvm/GnuQCL4K1RV746tYc2U33ZGHJXiWgKX2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rV5Nt2r9; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PxtxjKNoYgUPQsMQmTzU6SuGaoU5BES3zxRcOY+fRfc=; b=rV5Nt2r9TkPzhzSTWHKkkLeH2o
	RVJNVdXyRXIRJfGiAAp4SQwwA7QR0r7lYys/ExD7RA+nhEP4eZ7592JQiDBKZQUoF6/92/0PdQ6c2
	4KOenNGj3ilJLUEIRRP+4RHzDAVsQRvnDV/FPhyYQy5zYdS0TXSf17vkvNjnl4KzucE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUoAp-005uRJ-Eo; Wed, 03 Jun 2026 18:10:31 +0200
Date: Wed, 3 Jun 2026 18:10:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cpsw_new: unregister devlink on port registration
 failure
Message-ID: <b02f66eb-8b5b-461c-b990-30e6a5ceca56@lunn.ch>
References: <20260603140742.1398659-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603140742.1398659-1-lgs201920130244@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lgs201920130244@gmail.com,m:s-vadapalli@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:haokexin@gmail.com,m:alexander.sverdlin@gmail.com,m:aleksandr.loktionov@intel.com,m:daniel.zahka@gmail.com,m:ilias.apalodimas@linaro.org,m:m-karicheri2@ti.com,m:grygorii.strashko@ti.com,m:linux-omap@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:alexandersverdlin@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294828-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,intel.com,linaro.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 720F26399EE

On Wed, Jun 03, 2026 at 10:07:42PM +0800, Guangshuo Li wrote:
> cpsw_probe() registers devlink before registering the CPSW ports.
> 
> If cpsw_register_ports() fails, the error path only unregisters the
> notifiers and then releases the lower level resources. It does not undo
> the successful cpsw_register_devlink() call, leaving the devlink instance
> and its parameters registered after probe has failed.
> 
> Add a devlink cleanup label for the path where devlink registration has
> already succeeded, and use it when port registration fails.
> 
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Please set the subject line correctly.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Does this bother people? If not, net-next, and no Fixes tag please.


    Andrew

---
pw-bot: cr

