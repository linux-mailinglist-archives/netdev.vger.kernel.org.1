Return-Path: <netdev+bounces-84925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD471898B0B
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B5B1F20627
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AC712BF02;
	Thu,  4 Apr 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="CaGAkL/p"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25B12AAD5
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244265; cv=none; b=ZSgRR1DhSCt4raqHeDbiCisVgPCWaj1a8+16W8tacWEOK8pjuBk8JTQTnquoXZel8Zff+ZjaBs4k+4Y5OK7tSY/WSrNYjkdLKtZx8rE1Is7l/DEJdaH54cOu0hf/Q6O+wGaxVmea47pw62KLgWMeoEazYtVXtt39wnA11CAoWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244265; c=relaxed/simple;
	bh=FLgZoebs8agQJcPEdZsAbm+S9zfAHvMnpbSUAiSbro8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCbMLcE4V0sdSGQifKd5Zi7ieEOXaToa2Yitavr70StAHzN1jIM+68Z0CUuCtkGoOfrk4H1uvXybXtRgXz6LDW1FlrcSaNFxexIHSKnofsa9DtyYBHwQfvzSvtl65G1mfKy25TOsEIXEE3dEqerLEYEiDIdQuyDMetKQI+ZJ4UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=CaGAkL/p; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 3e112685-f297-11ee-8fdf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3e112685-f297-11ee-8fdf-005056aba152;
	Thu, 04 Apr 2024 17:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=0wDOMMWp1jD71LsCPCE/h53luWFt9Pts2IO1mAIgc4k=;
	b=CaGAkL/paFkC/LxfEMotrgV1X8IQKUrUaRRt1ZOdRVQAXGKKnDgMhaZUU8P1dSemdJnpu7DTQhiuh
	 kF7XiSXu6gI5eZmWRdIp8Rv9Wj8YuY1LtFnK2n3GhfmdyfCTgJSUOEGwhX0BNilEjXuU+ikVMU9q69
	 Pux9NlKHwCyYdXIc=
X-KPN-MID: 33|75sJxgrQ6iYy3cvKN1+MXDLuBp5NjN/M6UZ7Nd9VUm6qj+Rs1nS4XaDWh2nVbgQ
 g846Q/d3Kumz4HE3HD3Pc5g==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|fAqGT7GGSI0EY7JZwRr686UtRDXFuReXyBKpRy4NDtyHcRMZdBgTndXnXptwkpE
 Nfh5AwJjDnI2IC/Y9pL/OMw==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 401ce427-f297-11ee-8d4f-005056ab7447;
	Thu, 04 Apr 2024 17:23:13 +0200 (CEST)
Date: Thu, 4 Apr 2024 17:23:12 +0200
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
Message-ID: <Zg7F4GwJIW6_ajdK@Antony2201.local>
References: <cover.1712226175.git.antony.antony@secunet.com>
 <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
 <28050.1712230684@obiwan.sandelman.ca>
 <Zg6aIbUV-oj4wPMq@Antony2201.local>
 <7748.1712241557@obiwan.sandelman.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7748.1712241557@obiwan.sandelman.ca>

Hi Michael,

On Thu, Apr 04, 2024 at 10:39:17AM -0400, Michael Richardson wrote:
> 
> Antony Antony <antony@phenome.org> wrote:
>     > Indeed, 10.1.3.2 does not match the policy. However, notice the "flag
>     > icmp" in the above line. That means the policy lookup will use the
>     > inner payload for policy lookup as specified in RFC 4301, Section 6,
>     > which will match. The inner payload 10.1.4.1 <=> 10.1.4.3 will match
>     > the policy.
> 
> How is "flag icmp" communicated via IKEv2?

As far as I'm aware, it isn't communicated via IKEv2. I believe it's 
considered a local policy, and possibly specified in BCP.

However, how is communicating it over IKEv2 relevant to this kernel patch? I 
don't see any connection! If there is one, please elaborate. Without a clear 
link, the netdev maintainers might reject this patch.

> Won't the other gateway just drop this packet?

That's would be a local choice, fate of an ICMP message:), akin to ICMP 
errors elsewhere. Let's not dive into filtering choices and PMTU for now:)

Just thinking out loud, I haven't seen forwarding ICMP error messages 
negotiated in other tunneling protocols like MPLS or pptp...., if I recall 
correctly, QUIC does indeed have it specified.

-antony

