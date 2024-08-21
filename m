Return-Path: <netdev+bounces-120710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B0695A5AE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3A6B2184F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44702166F24;
	Wed, 21 Aug 2024 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A7Ko9uW/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fMaSvVR2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SXp1tE7g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gEq3KilW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0E1D12F4
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 20:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271163; cv=none; b=WaTUNxPqv7pZz0gtH86K8J99JD9OT90HkbEFEV5INETCthj+gQ/Aj3LdiR0aj+dE2clPGVWkQJ0CQ7Fzc8d4TNywPODmVqNx7JlXs5vf64y+PCgWHqXK3DBscjc8CxvqeWnV5A/XCNR1thr/p+UPu7LmKEHqkcY8rUSazZjBqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271163; c=relaxed/simple;
	bh=2uyxIjmqhByk9l1NghJ++iULfeF5wMS5XNysJhthSCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoomE0/gAUS0pC3X0gB0ScZQP9Lysjp0Cp28qMo1sCXvrNYHbqs2RwORO0bzi2MS4UhSD+bGGtbnYImKmfKROMW/WmU9x73gwZ/DdUvT+W6ckspR9fW6BIdJ6mrVcqtXf0IdVsLhhWLnXRheqfajg4ZmZtyrUCp89D4TP9Ox+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A7Ko9uW/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fMaSvVR2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SXp1tE7g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gEq3KilW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E02C0200D0;
	Wed, 21 Aug 2024 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724271159;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI9dA4UWqdNNPAnI2NX1TIn4j4ObZM2uEtL2RlnaCMU=;
	b=A7Ko9uW/nKJKdXDh4TE9wIUZ6VQxPBuKlH3EGVlFE29QorreDi9dcVtlOh7OYmgT3UmCaq
	SWxCsJYmLIzjZV1OzvzmGlWXn9eTcgzU1XzZv+TRRb490pyFZgxZ/rsJC3pYn9KaNTvrHU
	Z/Me5U5F0MWTTUu87v1zlHTFr9s6QYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724271159;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI9dA4UWqdNNPAnI2NX1TIn4j4ObZM2uEtL2RlnaCMU=;
	b=fMaSvVR2mXKto8gMiPz6zMfmg5E9LFte7w6WGAj4K9yB9fbtYnL9Pz/Wos+wLRSnWTD2dY
	uMrn6TE2RR5HbcDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724271157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI9dA4UWqdNNPAnI2NX1TIn4j4ObZM2uEtL2RlnaCMU=;
	b=SXp1tE7g3slKqTYlomDZd6rVQfhWgZJUj1XE0rbeeyjFG9p8YqPeusxZOy+SN02bC1Gp7a
	lHm+A4CrghSGH3YwOK4bnkMP7/0z+lUWIxG61MWNJF8WOcTYQBRDU/4OJqO2eEKhSR9sz8
	xTZ5bmU9NTVDK+bR3+JkexxxRLLj3yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724271157;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI9dA4UWqdNNPAnI2NX1TIn4j4ObZM2uEtL2RlnaCMU=;
	b=gEq3KilWJr8iGQfsdagpTrfxEzIFIat+/cQgG/q/ltcHwa4267XcYFUi4CVFnWE0xHYqbc
	A7rbymA7CfBP0KDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB37B139C2;
	Wed, 21 Aug 2024 20:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0YkcJzVKxmYmHgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 21 Aug 2024 20:12:37 +0000
Date: Wed, 21 Aug 2024 22:12:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>, netdev@vger.kernel.org
Subject: Re: [RFC] Big TCP and ping support vs. max ICMP{,v6} packet size
Message-ID: <20240821201235.GA1101240@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240819124954.GA885813@pevik>
 <CANn89iJgK-_xgFSjpH4m0qmcgwEMaTse7D=XbG-2qi=Gnej+xA@mail.gmail.com>
 <20240820153840.GA977997@pevik>
 <CANn89iK6Zr4bTaMOevGkNZ-KYHGFaE-8x5y95UgJ5+AwJgdwJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK6Zr4bTaMOevGkNZ-KYHGFaE-8x5y95UgJ5+AwJgdwJg@mail.gmail.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Eric, Xin,

> On Tue, Aug 20, 2024 at 5:38 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Eric,

> > > On Mon, Aug 19, 2024 at 2:50 PM Petr Vorel <pvorel@suse.cz> wrote:

> > > > Hi Eric, Xin,

> > > > I see you both worked on Big TCP support for IPv4/IPv6. I wonder if anybody was
> > > > thinking about add Big TCP to raw socket or ICMP datagram socket. I'm not sure
> > > > what would be a real use case (due MTU limitation is Big TCP mostly used on
> > > > local networks anyway).

> > > I think you are mistaken.

> > > BIG TCP does not have any MTU restrictions and can be used on any network.

> > > Think about BIG TCP being GSO/TSO/GRO with bigger logical packet sizes.

> > First, thanks for a quick info. I need to study more BIG TCP. Because I was
> > wondering if this could be used for sending larger ICMP echo requests > 65k
> > as it's possible in FreeBSD, where it's done via Jumbograms [1]:

> >         ping -6 -b 70000 -s 68000 ::1

> I guess ip6_append_data() is a bit conservative and uses IPV6_MAXPLEN
> while it should not ;)

> Also ping needs to add the jumboheader if/when using RAW6 sockets

First I thought you mean to modify kernel net/ipv6/raw.c and net/ipv6/icmp.c
(+ net/ipv4/ping.c for ICMP datagram socket). I.e. to create "Big RAW" and "Big
UDP" (maybe the modification could be in just in net/ipv6/icmp.c for both types
of sockets).

But thinking it twice you may mean to modify userspace ping to add jumboheader.

> With the following patch, the following commands sends big packets just fine

> ifconfig lo mtu 90000
> ping -s 68000 ::1

Yes, it looks like with the above patch it's possible to send a bigger packet,
it goes from userspace to kernel, but here is broken.

From what I observed for 65528 (the first value which exceeds the limit) on raw
socket (net/ipv6/raw.c, net/ipv6/ip6_output.c), rawv6_sendmsg() calls
ip6_append_data() and after that somewhere in 3rd pskb_pull() call skb->data_len
(unsigned int) changes from 65528 to 0, skb->len from 65576 to 40 (IP header).
Also checksum (likely due this) fails.

ICMP datagram socket starts with net/ipv[46]/ping.c but ping_v6_sendmsg() also
calls ip6_append_data() and suffers the same problem.
+ I obviously needed to commented out the check in ping_common_sendmsg()

	if (len > 0xFFFF)
		return -EMSGSIZE;

I'm obviously missing something.

Kind regards,
Petr

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index ab504d31f0cdd8dec9ab01bf9d6e6517307609cd..6b1668e037dae3c88052c50f02f319355baf4304
> 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1473,7 +1473,7 @@ static int __ip6_append_data(struct sock *sk,
>         }

>         if (ip6_sk_ignore_df(sk))
> -               maxnonfragsize = sizeof(struct ipv6hdr) + IPV6_MAXPLEN;
> +               maxnonfragsize = max_t(u32, mtu, sizeof(struct
> ipv6hdr) + IPV6_MAXPLEN);
>         else
>                 maxnonfragsize = mtu;

