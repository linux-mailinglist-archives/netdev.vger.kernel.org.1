Return-Path: <netdev+bounces-250647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15821D3875E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 105D5300D568
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA63A6405;
	Fri, 16 Jan 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o4gMIYY4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98B3A4F41;
	Fri, 16 Jan 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594717; cv=none; b=ltyvMY6oakIh0OHzr/V4+meiesrxmhrFxhJhjrLNAuUdGASBC96mP6SxLHKK3FchOxx6epn3hdZXW9w7iME7Uq1v4rq4IMDcs6++SipK4KRnmXy42yer3lOkBNKsXo5KFApspLgg9Fx8Rxc/5yve1La3l8lb+tImBLzGM+KzHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594717; c=relaxed/simple;
	bh=zmK0GOthOLIX641OEY26tPh4qGnp++jNaN4aIM+PNfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBNcH5Gz59t923sbDNDzElgIgLiF44xaY+oUpTQdspSsQr6cDZmLRWso1n+FeiyD8uPgZhVq/oJehS+7BMd5R21QRDqB0f5iuxITO79jtdDgJ8zsAJbLBaBWz5ED2ya2qsQ6Cj9L3a5pot/NQOruSwk4jG1VDIC1aJFYkdGTNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o4gMIYY4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=64BuC7i0BR/jQxcf3caEyZGpVGJQJ4GHac2qZI2aPkQ=; b=o4gMIYY4QiquKklZUI0MIDPjhi
	3cqCdI0YW8NGXwxrL9YhZ5s/tr40ensuR8TDbweu6dYLYG83LaDZXjG2xthQCGKNX0Fg5iGnAPSSm
	V4wPKkLdY9gFiFswy2AiUaZDLwmxNhzKfLwye6tG6l0hF4ZJHXEgf/KJC15NikZvvC/g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgqGv-0037GS-OH; Fri, 16 Jan 2026 21:18:17 +0100
Date: Fri, 16 Jan 2026 21:18:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Chen <justin.chen@broadcom.com>
Cc: florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: bcmasp: Fix network filter wake for
 asp-3.0
Message-ID: <eccbbe58-2987-43c0-8132-ea59b064f4a7@lunn.ch>
References: <20260116005037.540490-1-justin.chen@broadcom.com>
 <20260116005037.540490-2-justin.chen@broadcom.com>
 <f104b361-bc3c-4666-86e7-68fd5218eafe@lunn.ch>
 <3949edb7-70cf-4036-b6da-df4d3d927480@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3949edb7-70cf-4036-b6da-df4d3d927480@broadcom.com>

On Fri, Jan 16, 2026 at 10:55:44AM -0800, Justin Chen wrote:
> 
> 
> On 1/16/26 9:23 AM, Andrew Lunn wrote:
> > On Thu, Jan 15, 2026 at 04:50:35PM -0800, justin.chen@broadcom.com wrote:
> > > From: Justin Chen <justin.chen@broadcom.com>
> > > 
> > > We need to apply the tx_chan_offset to the netfilter cfg channel or the
> > > output channel will be incorrect for asp-3.0 and newer.
> > 
> > If this is a fix, should it be queued for stable?
> > 
> 
> Yes, will add a fixes tag in v2. Thanks!

Please base this patch on net, not net-next.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

