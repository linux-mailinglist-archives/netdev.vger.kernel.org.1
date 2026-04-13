Return-Path: <netdev+bounces-278200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB2/Ly1f3WmadAkAu9opvQ
	(envelope-from <netdev+bounces-278200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:25:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB493F3843
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA7493040A85
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019A392C3A;
	Mon, 13 Apr 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yIneI1O/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF7D358375;
	Mon, 13 Apr 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115287; cv=none; b=gD9rOcwIpdWORIxUyPm71YirpDEWw5zPVLHrwvT4qC50UK66A3V6nBeyxR6KMjrgRuur0mCv3cgNahM4fj4sumB3+L5re1oF4zOo1kCi12F4tywPAhTz500+yGotlu10NpgHXV9aQS7iKV/cYeBG9gocOIiRO/sIxDqaBIMQf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115287; c=relaxed/simple;
	bh=UkrbpQrONEPe4in/f01/Wr6ex9QhoOm6+Imr26aWJwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNEh2T7GS5uErlvq+zLt51Axop7lOr/XFP6+Av8oCOPvGtlQf8482o6avm9LoWbz9vWi4ZZYZ35OH+yjspAu1y9g81nOA8jF8vCLwox3ZMGcHwp9Ki43/qCVlZYvvcSyRcxfZ1T8leHPt/KkeuJRk+1dVOCS9scxyC9i0/2cfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yIneI1O/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H798k1mLXDWXnV36MebiS4K88tqZg7CpUrBU2pwLPoM=; b=yIneI1O/3kMe+QauIaQ0Z8z1AQ
	UDkUO87y2/fxs4VONEn9WL5k1hGoq2npIqsr4+r0oQbyJgv3Tp5iDHngBZ0epQO1jOMmI2CiPW6lm
	gIFbAn/0yTH+E1l6vA44wxH6IWdnHBuHjCRZr3qcD3HVU7JN1ptqJxQiTfwsThH4O4WM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCOia-00FyAD-Aq; Mon, 13 Apr 2026 23:21:16 +0200
Date: Mon, 13 Apr 2026 23:21:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: f6bvp <bernard.f6bvp@gmail.com>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 1/3] rose: fix race between loopback timer and
 module removal
Message-ID: <8e76226b-c861-45f5-9d18-8affa0c80525@lunn.ch>
References: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
 <20260413174238.112418-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413174238.112418-1-bernard.f6bvp@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278200-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 1CB493F3843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 07:42:36PM +0200, f6bvp wrote:
> rose_loopback_clear() used timer_delete() which returns immediately
> without waiting for any running callback to complete.  If the timer
> fired concurrently with module removal, rose_loopback_timer() would
> access rose_loopback_neigh after it was freed, causing a use-after-free.
> 
> Three changes fix the race:
> 
> 1. Add a loopback_stopping atomic flag.  rose_loopback_timer() checks
>    this at entry and mid-loop; when set it drains the queue and bails
>    out without re-arming the timer.
> 
> 2. Switch rose_loopback_clear() to timer_delete_sync() so it blocks
>    until any in-flight callback has returned.
> 
> 3. Wrap the timer body with rose_neigh_hold()/rose_neigh_put() so the
>    loopback neighbour cannot be freed while the callback is running.
> 
> Also fix a pre-existing bug: dev_put(dev) was only called on the
> failure path of rose_rx_call_request(); it is now called unconditionally
> so the device reference is always released.

Hi Barnard

Thanks for the patches.

A few process points.

We prefer lots of small patches, with good commit messages, which are
obviously correct. When i see a list like this, it makes me think the
patch can be split up into smaller patches.

When you have a patch series, please include a patch 0/X which
explains the big picture.

net-next is current closed for the merge window. You can post patches
as RFC, but don't post anything expecting it to be merged.

There is more information here:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

