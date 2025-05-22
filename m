Return-Path: <netdev+bounces-192812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC9AC130F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04F83A72DE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369DC19E98A;
	Thu, 22 May 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xxYpn5fV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688F33F3;
	Thu, 22 May 2025 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937494; cv=none; b=aHMKMAzKsG/SXYNbiueYCGu8GRfzllmxFDJwU04BxuaWbyJ5nqLi9gAzMQpVZn7qFAZwFEamV+ZDJ8CiRy4uv3azMc/OVcT5oe4RtfNubNpb1T/se2OhYsXiLa6W9FmhDZSVNTLTTkr5OzhORNnm6WI1+2yXdM0Hf3a4SesNzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937494; c=relaxed/simple;
	bh=A9A13D7xo08SXPs9HU+KUi+CSGBExmpV3bKA+Xj2P8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbpzOVDCF6dBg3kzIlgzilcLggBoB8uZRJLyJn9Xwhn5ojet0uJvoUdQmeQAplbUOhLKSaSfqsFjFVq/XPDjR9BHRREoe0zMBpqjwPKOS01jNIstibVKP0Qmv3+dFqYI5zsxoyqljmT0c6Sj2hzPMPSNoScr+zIdnhDN+InFyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xxYpn5fV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZqB1LOv+8bmezfvZqkWc7UwmyeA3+lxJ+Fn8QWU2m8c=; b=xxYpn5fVDdwDNNANF8amQO4FIR
	G2W8EFlOndMpLEnvTTuMZTbBqlRgqycRaULlHvDebda3278xYjQvaNUlYHPpNg3qRzZhcWilIVZR3
	GQBEzFq5zsZIfFOspDknsa+ZdR8hHhmLg9Sta0wVLY2L47AJrurJkvEwiSzzgK9Q79Vc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIAO1-00DWWL-La; Thu, 22 May 2025 20:11:21 +0200
Date: Thu, 22 May 2025 20:11:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@ieee.org>
Cc: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
Message-ID: <d4f047f6-59ef-4f8c-b64f-ec958f0323ca@lunn.ch>
References: <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
 <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
 <2025051612-stained-wasting-26d3@gregkh>
 <D9XQ42C56TUG.2VXDA4CVURNAM@silabs.com>
 <cbfc9422-9ba8-475b-9c8d-e6ab0e53856e@lunn.ch>
 <9a612b07-fe02-40d6-a1d4-7a6d1266ed18@ieee.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a612b07-fe02-40d6-a1d4-7a6d1266ed18@ieee.org>

> > You have listed how your implementation is similar to Greybus. You say
> > what is not so great is streaming, i.e. the bulk data transfer needed
> > to implement xmit_sync() and xmit_async() above. Greybus is too much
> > RPC based. RPCs are actually what you want for most of the operations
> > listed above, but i agree for data, in order to keep the transport
> > fully loaded, you want double buffering. However, that appears to be
> > possible with the current Greybus code.
> > 
> > gb_operation_unidirectional_timeout() says:
> 
> Yes, these are request messages that don't require a response.
> The acknowledgement is about when the host *sent it*, not when
> it got received.  They're rarely used but I could see them being
> used this way.  Still, you might be limited to 255 or so in-flight
> messages.

I don't actually see how you can have multiple messages in-flight, but
maybe i'm missing something. It appears that upper layers pass the
message down and then block on a completion. The signalling of that
completion only happens when the message is on the wire. So it is all
synchronous. In order to have multiple messages in-flight, the lower
layer would have to copy the message, signal the completion, and then
send the copy whenever the transport was free.

The network stack is however async by nature. The ndo_start_xmit call
passes an skbuf. The data in the skbuf is setup for DMA transfer, and
then ndo_start_xmit returns. Later, when the DMA has completed, the
driver calls dev_kfree_skb() to say it has finished with the skb.

Ideally we want a similar async mechanism, which is why i suggested
gb_operation_unidirectional_async(). Pass a message to Greybus, none
blocking, and have a callback for when the message has hit the wire
and the skb can be friend. The low level can then keep a list of skb's
so it can quickly do back to back transfers over the transport to keep
it busy.

	Andrew

