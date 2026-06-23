Return-Path: <netdev+bounces-301295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GxxPCmM+OmqG4gcAu9opvQ
	(envelope-from <netdev+bounces-301295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:05:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C236B517E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:05:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=X0WJUTU8;
	dkim=pass header.d=redhat.com header.s=google header.b=j2QenRJh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301295-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301295-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094AB304DFC6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6083CAA49;
	Tue, 23 Jun 2026 08:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E73C943F
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:05:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201918; cv=none; b=ZLH/8HEcJPiOc38MHG09tu2ziZr2w3QiVp4AJb7GnNda0AedxcUCd3ehuPyvYumKjA1/ddKRCRsJos4GpV7CrBvM/4VegHjdrDEfD+WAEPYpyzxvdw4hTk0ffDtQXtDQhai+ANdetd7uwiSWn1N2/XekAI6XehDUswBAvlLw1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201918; c=relaxed/simple;
	bh=z8RvWdot26AIdyqinmxjP1L72l87WKROiKfccjgBEn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXg8ZHFL/WNxIbxv4oKqSJQ0o+kOqSDtH0BnfRoUX/6ZR2mrUWgjFEB9D63JLJ/g80HKcvYay6CJ1pF0fdnGhUFZoIhYve07yRnqvTqtejzuh9mjNOI7TlKYgAN7TRGbtrNfKZBA6bqBPclwfo/PUm9z3xAYjoU64lzMuum68BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0WJUTU8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j2QenRJh; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782201914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H37DJNSgbktZvrq0/IUNk6TM3HwW87HOBuP9nTk2Et0=;
	b=X0WJUTU8BTF2L1B3h9RVhZVtEKE2tONuL7fsSn5uurMbCnD/uSbSA75kuF078N1OmL29iY
	1lu2SFNBaN3CYXZCyUv5qD1f2G7+rvJGF3HR0vcPiB6CvuhB80sLBHQ5TYHkJfMifwJFwE
	fIcybAxy0RfN2Be5Cr21ohvc0gIG/eQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-vWX9wOhQNlq_R2mqcMf6IQ-1; Tue, 23 Jun 2026 04:05:11 -0400
X-MC-Unique: vWX9wOhQNlq_R2mqcMf6IQ-1
X-Mimecast-MFC-AGG-ID: vWX9wOhQNlq_R2mqcMf6IQ_1782201910
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4923e05e961so4336725e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782201910; x=1782806710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H37DJNSgbktZvrq0/IUNk6TM3HwW87HOBuP9nTk2Et0=;
        b=j2QenRJhEOPGgnh+J3gxg8uw8EW1Kjpl3/cb3QipSLmYbdFpN0eBSErTJM3oPm0d1I
         mGPpne7P4njoqD+HXqsAwvlCAIhQr/GJnM6WMRaQoVXEh5VMaHIrfDKxBwqq+26mzfIQ
         QmyKrYlXVlPEBnkxLp+bdN0/aSrpu3QmGXSp9Ac3Co7V78ts5Vu8zVA9QjKgnztdwBQq
         SsklGKGhwoGkX7OQraawiP2tZfanwPKFF4hP6rKj+f7SPn1W2gM2Wnw6c0Dg8DipS2WK
         m/sf6ycr1AbHZhKx5VrPeYKi2zxHna/wnH6RcQNm5kfcwo8rb6HzuDiRg0kuV4ZDW94b
         w9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201910; x=1782806710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H37DJNSgbktZvrq0/IUNk6TM3HwW87HOBuP9nTk2Et0=;
        b=Hpo3II4hjDjbC83FWDg+sMtXCJuBWVBabZVJHnV7cGMKFCSs7+YydAPztS21KoXfZI
         b525aGBuItWV6mT7ujiUTedoFKH7fkWc2/Rijeg9Tsla1fyWq1sC+Oz4+xqI7ADVh7Rq
         q/w4bdx7Kdq6r7ZHID0kxX6vIFToViv7RjJAxFQzoUCVaLSHmzRPQys8PoEUkGYHnTLC
         AWuRc93KxBFefJhb+Hng/Xrxnzmkf3WGk4wo/0H7+OJJ2UDealyXO49dMF76HfWAGsYJ
         kbK1Q2UlkFYFd2Szv41UKDb013Xp3snoG10B/MD5OQpV23K76UNGoDy4pGiU/GHokPZY
         RLbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/AXTsOI+CMi7/ecrhn5HBjLHATjOoyolpXdxWsZrPdC0szEiZ0pl0SOugGyYBNtdMTDRGrJWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yGP4oDzlPl+eZxs4DTnCRwe7CDV1A4onoNyVo/uiJgaBVM0e
	hvQSiMnoygJRKuwER9UF3IJfvbbrlC8ji0yltczuzpECofCUEBGoHAuC0lgel5XPambjfTaDvZd
	OWCZUEy8q6GaXWAzRqeaukRpqdfHCGv+vyyJyyIKUuj35HT3da4rfXs70
X-Gm-Gg: AfdE7cnsYF25QGCEfj3BdXRUud83eRiPEHCAjdKy99MOZeO3fgqEEgpTHInfPLDP4bZ
	nrSAQeYnCP3TWAuzXTi8hyoCTb9o0c5n4IA9iSCQNgbAwtzkPw8fJMgKE5vszlXr+W/7/VwbT/K
	eCdKMLyHjrmFdaRdSeXdHM9bGTkiEEz2eTPrN64Y3TMCVF86iWQ3DjLrJyEVXdni/8NT6BS/EJm
	4IwDOwhoNn8/Y6fpProQFROmaD8Ij9MhiaSJarXlPxUA8l/lCoseuH2N3NUPUiDkSTrqb9ifLtE
	+fCKxTvVyVo2iD3i68ZY5qvMucPYkp8rh4Ay2w98Z8X0JosyunRb+PiVCI9jSMluTSp9Yazn0Rt
	5
X-Received: by 2002:a05:600c:4688:b0:492:4889:3d1c with SMTP id 5b1f17b1804b1-492598cacbamr26260865e9.3.1782201909531;
        Tue, 23 Jun 2026 01:05:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:492:4889:3d1c with SMTP id 5b1f17b1804b1-492598cacbamr26260445e9.3.1782201908855;
        Tue, 23 Jun 2026 01:05:08 -0700 (PDT)
Received: from tp ([2a02:29e1:404:f800:9fbc:ecd8:5c1a:509c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49245a69f81sm333197965e9.1.2026.06.23.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:05:08 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:05:06 +0200
From: Beniamino Galvani <bgalvani@redhat.com>
To: Ralf Lici <ralf@mandelbit.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
	netdev@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and dispatch
 core
Message-ID: <ajo-MgpZ8jA8YDwi@tp>
References: <ajjzF3W-0xDC133f@tp>
 <20260622155612.591109-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622155612.591109-1-ralf@mandelbit.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301295-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bgalvani@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ralf@mandelbit.com,m:toke@kernel.org,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgalvani@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74C236B517E

On Mon, Jun 22, 2026 at 05:56:11PM +0200, Ralf Lici wrote:
> > speaking as a maintainer of NetworkManager, I would also like to see
> > this feature in the kernel!
> >
> > In NetworkManager currently we are using a BPF program [1] to
> > implement the CLAT, but that approach comes with limitations: for
> > example, we can't fragment v4->v6 packets if needed, and it's not
> > possible to recompute checksums in certain cases (e.g. for v4->v6 UDP
> > packets with zero checksum, and for fragmented ICMP). systemd-networkd
> > is also adding CLAT support via BPF [2], with a fallback to userspace
> > for the cases that can't be handled in kernel.
> >
> > It would be very useful to have a native in-kernel CLAT that solves
> > the limitations of BPF-based solutions, and can be used by different
> > tools without having to re-implement everything from scratch.
> >
> 
> Thanks, this is really useful context.
> 
> CLAT is exactly the kind of consumer ipxlat aims to serve, and the gaps
> you hit in BPF line up directly with paths ipxlat already handles. I'll
> cite this as motivation in the next cover letter, if that's alright.

Yes, please do!

> While reading the BPF programs, two things stood out that would help
> shape v2. On addressing, both implementations use a single NAT64/PLAT
> prefix for destinations plus an explicit local_v4<>local_v6 mapping for
> the host itself. ipxlat today maps both source and destination through
> one RFC 6052 prefix, so this suggests v2 should probably support
> explicit 1:1 address mappings (EAM, RFC 7757) alongside prefix
> embedding. Is a single local mapping enough for your case, or do you
> foresee needing several?

Based on these:

  https://datatracker.ietf.org/doc/html/rfc6877#section-6.3
  https://www.ietf.org/archive/id/draft-ietf-v6ops-claton-14.html#name-obtaining-clat-ipv6-address

there are two cases to consider for CLAT.

If the node doing CLAT extends the IPv4 connectivity downstream, it
should acquire a dedicated prefix via DHCPv6-PD for the downstream
network, and use this prefix to generate IPv4-Embedded IPv6 Addresses
(RFC 6052 2.2) for downlink hosts. In this case, the ipxlat device
would need to be configured with two prefixes: one is the NAT64 prefix
used to synthesize IPv6 destinations for IPv4 Internet addresses, and
the other is the delegated prefix used to synthesize IPv6 source
addresses for hosts on the downstream IPv4 network. Ideally, the
ipxlat device should also be aware of the address range of the
downstream IPv4 network, and check that the source addresses of
packets belong to that network.

If the node doing CLAT does not extend IPv4 connectivity downstream
(or it does, but it also uses NAT44), the "downstream network" is
basically just one host. The CLAT only needs to map a single
locally-generated IPv4 address (usually in the 192.0.0.0/29 range) to
a single SLAAC IPv6 address reserved for the CLAT. In this case, the
ipxlat device would need to know the CLAT IPv4 address, the CLAT IPv6
address and the NAT64 prefix.

Currently, NetworkManager only uses a single IPv4 address and doesn't
request a dedicated prefix via DHCPv6-PD for the CLAT. If it needs to
provide downstream connectivity, it does IPv4 masquerading so that the
traffic originates from a single IPv4 address. I think the ipxlat
implementation should also support the delegated-prefix case, as this
architecture is described in the standards.

> On the consumer side, is there anything in how NM models a connection
> that would make a particular kernel model awkward to drive, e.g. needing
> to attach to an already-managed interface, or conversely being able to
> create and own a dedicated device? We're still settling the
> kernel-facing model for v2, so consumer input here is genuinely
> valuable.

Any of the solutions mentioned in the thread (dedicated device,
netfilter, LWT) would be fine from NetworkManager's point of
view. Compared to what we are doing now, they would be a great
simplification ;)


Beniamino


