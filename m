Return-Path: <netdev+bounces-84824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C3898714
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10D81F27F62
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8A129A73;
	Thu,  4 Apr 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="STFQ6Tff"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B212129A77
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233001; cv=none; b=Xu7IsWHeZEUBTU/s9WE7bw5KdlCvupIJZgy8tc5qX/AZsoSKseqoHKSJWbdl+rqUQb3jmW1nAWPc6fcrMlPHO2EU3EwbGSEZ0W5PTCB2AdExA+4uPeNFHiI2swdDzrmGITzegWc135E3fJrSIKk5pM+Sp1KYlIY7k4YSxcE+Kf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233001; c=relaxed/simple;
	bh=RbM9izympFt15JsGMUNx2Nj1SYs4LoRDVTLl9T97n2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtLLPydaK3ZyIfRaEXQax9h3shLIchR158caH71P1XbP8QrJAHOs9pVSUIKoMpSXp5xaUHOpg0G0k4kFt/2T6oZ/eniXYeuaobFLqNrgnDg4ZHvvrlktaN5t01qExPBt3Xif+oXgOgu9VoZ4aaGBegr2WmZImi8xfwRprJsHlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=STFQ6Tff; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 1c22d34d-f27d-11ee-bfb8-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1c22d34d-f27d-11ee-bfb8-005056ab378f;
	Thu, 04 Apr 2024 14:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=0SWIcjqRtknLyn50llFxgflM7JwUXIS3wxjXCr3/KbY=;
	b=STFQ6TffP51rihDJQddbT4TT0SgU5G/vaMNZ6QDcyOwmZLZ7uln/yCBPwHJD1YS+QoybR8ibYCtwn
	 Pncs2CXi7VyRZHr14yaxQa6ey/BnGHywqMLS/E9IDeN2X+qThQTU5Ygt8iz+UzL2gBw2pFapbiAfl5
	 Y6CV8crTrOPtenRY=
X-KPN-MID: 33|6SrT1pAAy8YLmRA7/TsghRJkscloFNh1ohlqEyicE61yPCcd3YuFiU5j0q4yhm+
 ZEkKWkPTKZeeYK+wPZOBPtiLtjW7RoHWxmE8YZG3i3Vw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|UACsZenehqJok+ORlZKru/1XX+jqo7wcSII8GQMJIwM1m6OQnQA4jl7MMjx2yWQ
 KR8ikzFKItO5XA2vvvhh0/w==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2ccb0ca8-f27d-11ee-9f09-005056ab7584;
	Thu, 04 Apr 2024 14:16:34 +0200 (CEST)
Date: Thu, 4 Apr 2024 14:16:33 +0200
From: Antony Antony <antony@phenome.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net 1/1] xfrm: fix source address in icmp error generation
 from IPsec gateway
Message-ID: <Zg6aIbUV-oj4wPMq@Antony2201.local>
References: <cover.1712226175.git.antony.antony@secunet.com>
 <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
 <28050.1712230684@obiwan.sandelman.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28050.1712230684@obiwan.sandelman.ca>

Hi Michael,

On Thu, Apr 04, 2024 at 07:38:04AM -0400, Michael Richardson via Devel 
wrote:
> 
> Antony Antony via Devel <devel@linux-ipsec.org> wrote:
>     > This commit would force to use source address from the gatway/host.
>     > The ICMP error message source address correctly set from the host.
> 
> While that seems more correct, since that host is generating, it might not
> fit into the IPsec tunnel, and therefore might go the right place or
> anywhere.   Perhaps you could pick the internal IP of the gateway, but in
> more complex policies, the gateway itself might not be part of the VPN.
> 
>     > Again before the fix ping -W 5 -c 1 10.1.4.3 From 10.1.4.3 icmp_seq=1
>     > Destination Host Unreachable
> 
>     > After the fix From 10.1.3.2 icmp_seq=1 Destination Host Unreachable
> 
> ip -netns host2 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir out \
>         flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 1 mode tunnel

> 
> As far as I can see, 10.1.3.2 does not fit into this policy.


Indeed, 10.1.3.2 does not match the policy. However, notice the 
"flag icmp" in the above line. That means the policy lookup will use the inner
payload for policy lookup as specified in RFC 4301, Section 6, which
will match. The inner payload 10.1.4.1 <=> 10.1.4.3  will match the policy.

> You appear to be selecting the outside ("WAN") interface of the gateway.
> It would be less confusing if you had used 172.16.0.0/24 for the outside of
> the gateways in your example.

With this fix, I am leaving the source address selection of the error
response to the stack instead of unconditionally copying from the packet
that was dropped. So, in a simple case, the outgoing interface will be
the end of the tunnel, i.e., 10.1.3.2. Also that is the end point of the 
tunnel. 

> How will the WAN interface manage to talk to the internal sender of the
> packet except via the tunnel?

WAN is geneerating an ESP packet? In this case ESP tunnel mode with  
10.1.3.2. Note: the reciver has also the icmp enabled.

-antony

