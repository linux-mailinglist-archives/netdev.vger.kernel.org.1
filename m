Return-Path: <netdev+bounces-306629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pDrUCVMgUWqq/gIAu9opvQ
	(envelope-from <netdev+bounces-306629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:39:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9273CA11
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=zCcH0Lmw;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306629-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306629-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971FB306BBD2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E694342EEC9;
	Fri, 10 Jul 2026 16:37:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6326F293;
	Fri, 10 Jul 2026 16:37:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701475; cv=none; b=UGUgZHJfE0AWo63PA08z9fWrO89/hie5sQjE6pOHIrdDJHCblTs85OJL2ldLIG2/oh3Eu090jSISWdiRgfX0ihaafgZcmzOCBx+E2WoX7xpr1LK0+dszWIC5pVaBXnPPT10+3EGZLOJAcFSIJdk5qU3ig9seanYF4pft8oA5ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701475; c=relaxed/simple;
	bh=6JQ5HtR8U5ofo03taD6S5+G9y2naXme5iUR2sOnmczI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcTeLFHkXdl3nc/3zHX6RDsj6B8ejCZ7VQAgbOEK7h8k9AeuWtaa5yvvnP/N0U91D0VJavlGnUJqsj6kpdwpjN5taO6nf/usL741GYvvYiJ5lmTyN0I1zcNBHYfttYy1ReXWNet33y6nwzpronSbQw5Lk8lBNzeXIxQqoEQmNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zCcH0Lmw; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KXSTbKG+7aSBdSKpvH/rz9uGEzE4kqyoxlMBzZZMa60=; b=zCcH0LmwiB0IoGAMB8jGU7HRwq
	qtj8nKoeRqxY3LEy0uR3TLT46GPLDD0+BkhJV2v1DFCj4sJ5U2dNDdfjf17iB06l//+tan1I6HvqY
	VZhpoWof9iIuF6ndXTHdv51SHIf0rLafrC7aSOSMex22wuVaeweLDgjI5RI4eUTBVAcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiEEW-00BfYc-EI; Fri, 10 Jul 2026 18:37:48 +0200
Date: Fri, 10 Jul 2026 18:37:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "chunzhi.lin" <linchunzhi0@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] docs: ACPI: DSD: motorcomm: fix docs build error
Message-ID: <532f6e46-ee9f-4170-8ec4-72374e761cb0@lunn.ch>
References: <20260710053106.730399-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710053106.730399-1-rdunlap@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,armlinux.org.uk,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-306629-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:linux-kernel@vger.kernel.org,m:linchunzhi0@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:linux-acpi@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:from_mime,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91B9273CA11

On Thu, Jul 09, 2026 at 10:31:06PM -0700, Randy Dunlap wrote:
> Separate the title with commas (since they are all run togethe in the

nitpick: together.

Otherwise: Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

