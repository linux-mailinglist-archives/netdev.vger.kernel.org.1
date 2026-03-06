Return-Path: <netdev+bounces-264929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MtRC8xHq2lcbwEAu9opvQ
	(envelope-from <netdev+bounces-264929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:31:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A8227F44
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04ED8300B281
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FD33043CF;
	Fri,  6 Mar 2026 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xtei8bKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4A22A7F0
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832709; cv=none; b=Gr/qT5cy+MsJWH3Y9zbPi2cAtKYVxA+y+jqsm71V1OqS80e+rqt2XfvxFB96//Tkkwuhgnz6zk4clym/2JA/8TuZG/p4zZvLTv6sgsYw579Ap2/aru73du8FBuQVb+uk22Cz/pOXciz3CzAA0TomnU1N6bV85TexonNytmR2t34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832709; c=relaxed/simple;
	bh=89hClAx9k5RyVOjc/gjoAKSMD876kmYAz2R8REOtWp8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=si3P5jggQbPPeOjBy4meLs6JlhGsg73ccDLB82jXakDRXc+KE8UPSgXTuLQL22BgBa2n6q8hW11PISWN4TNN/3Llxym4vM66CoWPX4dwTjvSl9xfLD5GYnlqbW9TBfHIefADF2fbUBnWAYF+xk8VsdV8pG7qgkNr2blWzqR9ODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xtei8bKg; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986e0553bdso95422647b3.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 13:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772832707; x=1773437507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT+JmKJs7KOCX+JTgaYiqGd07FCDr1R0k+/s6EkGVfs=;
        b=Xtei8bKgR+0rXUj4XFuRzSTjtKLs1wGiIdDDm7LaoEt2uDsXdCWOfCa0L0x8q6qEc/
         hngVwfw/3tVxfhoCqmzo7t6EWntn2nBHHUjMOXRXAcaEHjMoR9yoJKjmfaJCiO8lcEyl
         9ljrL3Y+FQCFx5d/LEn3BR42IXPMQ5k0usdabiL3INL60AB4c2tNCH1mBrX5RIhuYFv6
         x5Ks3QYlE2Df7DXaNzEnUmbelob0JikMW/Bu4Mt+wWCBXK3zurxGnGq0++v9QicJjRw7
         +HpIg4OVmdpPKOlBD9WBfjFYnBy83SNYGd45b2wtvb3nz5aryxj2jQuAoDFzedggnK0m
         MXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772832707; x=1773437507;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qT+JmKJs7KOCX+JTgaYiqGd07FCDr1R0k+/s6EkGVfs=;
        b=wbkxIVNIiU7j+K+srZLh1fTlUM8rV1KoKPwzzdNvaVA9lWkly4V62WWmQgdQe8w2m2
         60eB97FvGE4bMIn7UVoD1vCADBqT8lTpo+URiC6OcU2V29plbMIKwEyCNr+hau8XzJ7e
         Vys+gGqpRp+7uijbyTFGGAcFKiVF8HFs8CtcN5cecXwrKADNJ/1ZNG/hxmIgqO17RVjA
         M5W92+U//BMWkXXpEqx06whwNxX+jtGAmUMNS77zEsrs7BOohG/grcf6++fuw1fTe0nz
         3MGmfkp4+bPqIJVlP+y85EXp+EwqE4N7mkiZEp9I8+hjhZ9RBf4Uialsgk5XAD8FNTT7
         57rA==
X-Forwarded-Encrypted: i=1; AJvYcCXSoTWxm19C1HR4RTn4tB8HYROSLwHvFlp6qM2baW0bUfvnObZRPLa+oBg/frTccRTOjBdP1VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wQ1NazRNKauleurlG2Mo+cm2AKIpWyE8SZ2AzXLTLO0t64Bk
	+WSGYxI7rhbQHvSUUA+ic8e8t2xC8FsmWeV0tS4Ode9GQCd8OlknmGib
X-Gm-Gg: ATEYQzzoYfT8E+R/4kbIl7N3fYv2WoWWHpbFrP94nCXOtg3+ekgx2eWPAaFqUwmbgAs
	VKF68VhTz1QJ8/5cSTKNCxtjhZ87XSget/s8wLZlaeYIkh4NMKWbHlld4WR/19v65VOqIV6dgSr
	6rpltYrIF8pfEvZ+f4tIKmzxfAeWhkaQWTQoAnR8V+ezcp/LHOzEvbUTiqnfz7n5P69JP5T2qi/
	lgOoz3Gh7GS7u7VUGfjCPXvGa3TgTB7D2G0DKPwyxPXY8M+BfjU7Vange9qYkyqC3uznFSpYP0+
	WLTgaqI8DbRqSkuWUtEN3E+9N/PCDTNeXqph7oSXmEg3zbGFQX6mUYsSQgBFO9Upw1Z6/vHhQ4p
	IL/5wTyMGjlplfN+q5h152s93n1ReZo5m7zG0atYDgDSVb0JmdV1tQ9OwXT8zmO/kxPZO5BpBP1
	q8vCkQDErCL1HeFalhFd40GZ9ToqximDBkNBwvnWUBXxcazbVNOOe7YlrLHJqWr+nN58tUhNaw7
	FRT+PiRuQ==
X-Received: by 2002:a05:690c:660d:b0:796:74cf:df0c with SMTP id 00721157ae682-798dd6cba0cmr33098637b3.24.1772832707174;
        Fri, 06 Mar 2026 13:31:47 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-798dec8b953sm11857787b3.6.2026.03.06.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:31:46 -0800 (PST)
Date: Fri, 06 Mar 2026 16:31:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.7b1e33c85243@gmail.com>
In-Reply-To: <willemdebruijn.kernel.5d7aebff68af@gmail.com>
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-7-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.5d7aebff68af@gmail.com>
Subject: Re: [PATCH net-next v2 06/12] udp: Support gro_ipv4_max_size > 65536
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 266A8227F44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264929-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.970];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Willem de Bruijn wrote:
> Alice Mikityanska wrote:
> > From: Alice Mikityanska <alice@isovalent.com>
> > 
> > Currently, gro_max_size and gro_ipv4_max_size can be set to values
> > bigger than 65536, and GRO will happily aggregate UDP to the configured
> > size (for example, with TCP traffic in VXLAN tunnels). However,
> > udp_gro_complete uses the 16-bit length field in the UDP header to store
> > the length of the aggregated packet. It leads to the packet truncation
> > later in __udp4_lib_rcv.
> > 
> > Fix this by storing 0 to the UDP length field and by restoring the real
> > length from skb->len in __udp4_lib_rcv.
> > 
> > Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> > ---
> >  net/ipv4/udp.c         | 5 ++++-
> >  net/ipv4/udp_offload.c | 4 ++--
> >  net/ipv6/udp_offload.c | 2 +-
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 345ef93001fc..870b35107ede 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2690,7 +2690,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
> >  {
> >  	struct sock *sk = NULL;
> >  	struct udphdr *uh;
> > -	unsigned short ulen;
> > +	unsigned int ulen;
> >  	struct rtable *rt = skb_rtable(skb);
> >  	__be32 saddr, daddr;
> >  	struct net *net = dev_net(skb->dev);
> > @@ -2714,6 +2714,9 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
> >  		goto short_packet;
> >  
> >  	if (proto == IPPROTO_UDP) {
> > +		if (!ulen)
> > +			ulen = skb->len;
> > +
> 
> For normal packets, ip_rcv_core truncates skbs to their IP length.
> 
> I don't immediate see the GRO layer taking care of this. Which is fine
> if it can be done later, but not if these protocol fields are zeroed.
> 
> Should we validate that packets have no padding before we coalesce?

I should have read ahead. This is addressed in patch 8. Great! Never mind this comment.

