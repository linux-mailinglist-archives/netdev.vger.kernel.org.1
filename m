Return-Path: <netdev+bounces-85218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55055899CE1
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040E31F230E2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522116C44C;
	Fri,  5 Apr 2024 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="HTV2bS2j"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E32E631
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320138; cv=none; b=r2QT/uMSVRhLD9JySbJ1zLrmvtiqrDlUyVVFwH0RL/LdsN4wpJVrat8hjo0bqVFQOOIWnrcg2YOoJ6gEM4TH5qzO8xv2EDbwQoMfx3xuy4CGVfoTAmZ7PXw5L8CPsZS+eoGRM31LJkdqRbcrZsGUQ5XLwZf+iIG/6hTqKHcAGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320138; c=relaxed/simple;
	bh=Aom5vEXieIdCwOvvgW9I4CvVakuhtN20co0+5Tm+Ytg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNX2WClPdkQpgwTQy7NHheIb1oaAPz6vMD8XE0rSp/1nvT3PNUvVR8+tDAaRq29fiR4M/f9EjxQo/XXieoElsmQaXmONo3N63KY3QjhrTzGoKrNrGcjd1vc9U8IsCHx6BZ0V/bXlZRcwWEsOaUrEzgQ4xhAmpHkxW4MD2FRvRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=HTV2bS2j; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: d4c9f4c9-f347-11ee-bbc8-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d4c9f4c9-f347-11ee-bbc8-005056abad63;
	Fri, 05 Apr 2024 14:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=G6uHXQI7kySNs5ML2OTeM2cLNKA+n3CtXX1crh5Y9gM=;
	b=HTV2bS2jzm74sbT8EBRznAT77GyKTMRwTuFnlIKNG6a9YUKfdluhYAn16uaBaCEITVDBwHkrL4M56
	 rtmncA0r0WKJPbtemnYxNt+/7vBMFGxwKDF2g99bp3Gvsb/l5plQ7NbLqvd96Dbe+TFxBlOCZke31l
	 ks0D4V62dNjf/oDk=
X-KPN-MID: 33|liCPiM/pYptY9pb+bTsww0kXBr6eRh3QGBIFSLGkgrXImPLUING+aV5LDfUUtro
 12mAcmEmKx3RElxe8rpPez53iFbeerdClg9nShDvH/Ww=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|VFUokyi1R4S6X9X7gV1GusCshnkizxSkjoLuqX+NaTF7oi3d+FQUnjWjshg3j/d
 jGug2/2ydEc23d7OSvOXvZA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e7197964-f347-11ee-a210-005056ab1411;
	Fri, 05 Apr 2024 14:27:45 +0200 (CEST)
Date: Fri, 5 Apr 2024 14:27:43 +0200
From: Antony Antony <antony@phenome.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Antony Antony <antony@phenome.org>, antony.antony@secunet.com,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, devel@linux-ipsec.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net 1/1] xfrm: fix source address in icmp error
 generation from IPsec gateway
Message-ID: <Zg_uP2G8HIury_lI@Antony2201.local>
References: <cover.1712226175.git.antony.antony@secunet.com>
 <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
 <28050.1712230684@obiwan.sandelman.ca>
 <Zg6aIbUV-oj4wPMq@Antony2201.local>
 <7748.1712241557@obiwan.sandelman.ca>
 <Zg7F4GwJIW6_ajdK@Antony2201.local>
 <23137.1712244957@obiwan.sandelman.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23137.1712244957@obiwan.sandelman.ca>

Hi Michael,

thanks for your clarifications.

On Thu, Apr 04, 2024 at 11:35:57AM -0400, Michael Richardson wrote:
> 
> Antony Antony <antony@phenome.org> wrote:
>     > On Thu, Apr 04, 2024 at 10:39:17AM -0400, Michael Richardson wrote:
>     >>
>     >> Antony Antony <antony@phenome.org> wrote: > Indeed, 10.1.3.2 does not
>     >> match the policy. However, notice the "flag > icmp" in the above
>     >> line. That means the policy lookup will use the > inner payload for
>     >> policy lookup as specified in RFC 4301, Section 6, > which will
>     >> match. The inner payload 10.1.4.1 <=> 10.1.4.3 will match > the
>     >> policy.
>     >>
>     >> How is "flag icmp" communicated via IKEv2?
> 
>     > As far as I'm aware, it isn't communicated via IKEv2. I believe it's
>     > considered a local policy, and possibly specified in BCP.
> 
>     > However, how is communicating it over IKEv2 relevant to this kernel
>     > patch? I don't see any connection! If there is one, please
>     > elaborate. Without a clear link, the netdev maintainers might reject
>     > this patch.
> 
> because, we are using a custom Linux kernel flag to get the ICMP back into
> the tunnel, then the other end might not accept the packet if it doesn't have
> a similiar configuration.

The use of "flags icmp" option here for ICMP handling within tunnels is 
directly aligned with the standards outlined in IPsec RFC 4301, section 6.2.  
This section mandates that both sender and receiver must be configurable to 
verify inner payload header information against the SA it traverses. It 
explicitly states, "an IPsec implementation MUST be configurable to check 
that this payload header information is consistent with the SA via which it 
arrives." Furthermore, it details the required handling of inbound ICMP 
error messages that don't match the SA's traffic selectors, emphasizing the 
necessity for special processing in such cases.
Therefore, the need for IKEv2 in this context does not arise, as Linux 
kernel approach is fully compliant with the specified standards.

> 
>     >> Won't the other gateway just drop this packet?
> 
>     > That's would be a local choice, fate of an ICMP message:), akin to ICMP
>     > errors elsewhere. Let's not dive into filtering choices and PMTU for
>     > now:)
> 
> No, it's not. It's up to IKEv2 to configure those flags.
> Your choice requires extra flags.  The previous behaviour was rather
> ingenious because it guaranteed that the packet always fit into the tunnel.
> (the bug was that it didn't do it for IPv6 as well)

While the current behavior might seem beneficial, it has a major flaw. 
The generated response matches the IPsec policy only because it uses 
incorrect source addresses. This is address spoofing by the IPsec peer.
This should be considered a bug, not a feature. In contrast, the correct 
approach, as IPv6 demonstrates, avoids such tactics. Ensuring IPv4 also 
adheres to standards is crucial. Thus, applying this fix is an improvment.

I think the patch should be applied, and leave it to the kernel community's 
insights and judgment.

> 
>     > Just thinking out loud, I haven't seen forwarding ICMP error messages
>     > negotiated in other tunneling protocols like MPLS or pptp...., if I
>     > recall correctly, QUIC does indeed have it specified.
> 
> So, what?  They aren't L3 tunnel protocols are they?

Based on RFC 4301, section 6—as referenced in the quote above—it explicitly 
mandates that implementing a locally configurable option/
Therefore, negotiation over IKEv2 seems unnecessary.

> MPLS is L2.5, pptp is L2 and QUIC is L4.

-antony

