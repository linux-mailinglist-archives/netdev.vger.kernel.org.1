Return-Path: <netdev+bounces-228886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E9BD57A7
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A46518A4866
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF3303A0A;
	Mon, 13 Oct 2025 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HbjFmU9a"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B923D7F4;
	Mon, 13 Oct 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376339; cv=none; b=l8oAGOfPEiTsxaR7E70l+/xVvSqSAjVN/4I1mcO4Bd+GrCixvvDwvc9EGW5cDP+rfeaRnRwsW1cbJqWDRlRigMx6LK2QxyhFybhRZPTBrXoKpV+PQW0bJI7MdMnW52xaklXY+4uTtljE37HxVoHmM8js9h+guRKGiTk3OrVEs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376339; c=relaxed/simple;
	bh=UlOaVrzspTJDgkCtsEfuESTgzGdfCImxmGdrw+/RBbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts5JFrDjro3MeyukwhsfI+ImXiX7yFMsiR4lNxc0RBUYeMJkATiEuttAMtFDQfhz8YSD6I3tMpJomoH0GiusXL5jNJE0p5CB2YmtAiVrF/s2VkbDekWYx4qeto/JRWiVbMpMCSNEj53mqP21XegL67gWMlJXHuliZ9R/kfDWAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HbjFmU9a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mViysU4fstpkJe1v81vZ97t0ItjmFyl1yEzmvEtHZ60=; b=HbjFmU9aqyzgslZmHGNJLu/efF
	Ip/Ptjme0/TvrWsUiAyGsW7oPPpAJzoqq65BWfeAiTE4k3MEqzCgAaOI4a68a43NAR9ZjSTAtSVuH
	mFbaDpmpLShSGl4MrsZQobbhhWW36gpxeOV/gwHOwaWu8U0AV4Tl7LNdn8CHrjnj5Js0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8MIZ-00Aowb-JV; Mon, 13 Oct 2025 19:25:27 +0200
Date: Mon, 13 Oct 2025 19:25:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] netdevsim: set the carrier when the device goes up
Message-ID: <7e1d28c0-7276-448f-8d01-531b7e8bd195@lunn.ch>
References: <20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-netdevsim_fix-v1-1-357b265dd9d0@debian.org>

On Mon, Oct 13, 2025 at 10:09:22AM -0700, Breno Leitao wrote:
> Bringing a linked netdevsim device down and then up causes communication
> failure because both interfaces lack carrier. Basically a ifdown/ifup on
> the interface make the link broken.
> 
> When a device is brought up, if it has a peer and this peer device is
> UP, set both carriers to on.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 3762ec05a9fbda ("netdevsim: add NAPI support")

It was not obvious what adding NAPI has to do with carrier status.  I
had to go look at 3762ec05a9fbda to see that that was when nsim_stop()
started to change the carrier on stop. This patch makes nsim_open()
somewhat symmetrical. If you need a respin, maybe expand the commit
message to explain this.

Otherwise this looks O.K. to me.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

