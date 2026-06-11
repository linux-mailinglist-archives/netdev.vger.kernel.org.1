Return-Path: <netdev+bounces-297950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wbtIMudPKmoenAMAu9opvQ
	(envelope-from <netdev+bounces-297950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:04:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8966EE09
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:04:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BlagH+E6;
	dkim=pass header.d=redhat.com header.s=google header.b="U6Qo/yc2";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297950-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297950-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A8F0300F576
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A00433260C;
	Thu, 11 Jun 2026 06:04:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3C30146C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:04:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157861; cv=none; b=boPTGutYK+bS60Lyzez8at5qw+G3VSw4XI2YXYXOm4Yz6ICd2AQixMNL+oCb4lQm/nkmFtFp5XVEeanSNQ1UNU+RWXOGrdRwHL15oMzPqtV5hbMkFBuZ6w7iJG3zoMf4lVbT3VgBZ7/clMhkSsdkVx114hTkzDpaPhmYaaL9LXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157861; c=relaxed/simple;
	bh=THJuQE2MrTb5ZIYu3BzOWvVCOA5+CKpxg+aLafJ1Wfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV7qnkxnSZQreE6EfNr5JmorOvnqKGAtjTR4Fhs1KLfSBmy26t0GFQQXIp4BgfiJRyCH2DPv6TX9uHUMZxYV02fu6tdtjpwaNSZ4AKljm9Tmy9s4/sU0i9IFD2q5BbYnWqwh0UKnRIMvbFNDHq84anmf06GdJZbKLdLyeV5j2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlagH+E6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6Qo/yc2; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781157859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HRTToFtG9hV0gA1EWdpPvRzBaGUtoQe1flCF2qnScak=;
	b=BlagH+E6wk25ON9Gy7riL9mUXcJsoKPW9y1MHsi8Wak8RfgSS5TZ4VTicrIy/H5aor3crx
	aYrPZvFjLbFeK7Bcm2cLpEC7/Q1o4BlfRluqjHcUq5U2KpCgb3Udfr/rSZA3osaF7uqiOb
	DJZhjMVAIlQOxA4uNvwvhNdSfQ0a8nw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-P4TYRVtHNLW5u3KK4s3PvA-1; Thu, 11 Jun 2026 02:04:17 -0400
X-MC-Unique: P4TYRVtHNLW5u3KK4s3PvA-1
X-Mimecast-MFC-AGG-ID: P4TYRVtHNLW5u3KK4s3PvA_1781157857
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef55779d1so4750649f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781157856; x=1781762656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRTToFtG9hV0gA1EWdpPvRzBaGUtoQe1flCF2qnScak=;
        b=U6Qo/yc2aejiW4N1bmB9FzVythbgXP8ovnzGNGiFgcG0pY09snaH2eOmTnp+Gi2iXe
         p1hlL7PU2lBkQfO3YMiQ1PAFWFhM786i/pz4k387uoyWKQjDBix2h8DPms7F/T6iqp5/
         91vWPVOED29YPs05gvIICX8Nh4To7Gcd/FjK5NL1ZvhoSxNgRatDFvfzEozx3kHKoTRl
         1PobtvuhdwUolx22c6Xro8NEsll4SpYdY/uB+CFxkIHzzMl3eTI4knO1qOZzV/8efGg+
         Ok/tzD488vjcqsEppT2WQU64J4trfdziqECxJboxVJjNcfkIMv8srJoOGQcwQSH6DA8I
         v8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781157856; x=1781762656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRTToFtG9hV0gA1EWdpPvRzBaGUtoQe1flCF2qnScak=;
        b=UxUpEgPBCQ01aFMBJBXjLBerry4ats9Ju/aDO42jsM9eFfpy/vRmrsAPnribNjkhVD
         bN88DpvV3CzlJB/4wfYPNxIynY48zVvzcQ0/sa5Oid+Sao/mT4yQpOye3S7UYShHuduk
         pu4Cdf7cF2S/YFtPtufrzHBhT84rhN1AB6roSlBzlXgl1SBxQkq6yVICZhtSp5tWgnDB
         SoV/ROEB5CH7rYNt4Q9Y2hmYh22GYY1ZlZChTEVEQL6M29mYxPu5Bl9QREKO2oljIwG6
         V28rDhK+sRhAPWgRZcJb/4bPZy55c4ugBcGXhVPiB8R38RIJ1sfXqGW3xEdsOd1uXW9m
         kS+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/fEgxUkoQOYjmXZiK6BlZh/jatUCDxILxquBakvQaPMlgLgKVkEWFrUeu/3f9u0cjYPwMx9QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETjNGFM7Uqs3bMk9pltuiK8wyqDy36NvhVDXLQzvWUHnQDjVa
	zl6pn9pRzxSy21aZu6qkVAS/KwHOk34jCWJP2Z1WOHUD/gLiq9+1LI1knVqH5JzXAxGXtxOWulA
	Not1X8KWP5iRPi/rRgaWKSZxKKTPpXSVrMx5ZJzPnwLupVSWo/squqEhEKg==
X-Gm-Gg: Acq92OHhLQepj80DXwnnPkbYuyEOE8LSzw58uSQ7/7d6eMTaj5YiwLRoZGHOQBZgYSL
	d7eIVMHUF0T5ug+aQCfEomqrRvGoqLPdwBwQJlfrb0QdUQ9S9rsfOqY3L3bunAlJQWNM90VANlT
	IGxeSLYhF39tNrciThp+qk+96qeQjyrN9B6jhq8OKZtrMAm5kRsOVp88U95lgwGb34qPnNqA2O9
	GDChE2vhWHEUqc6lcj2id5vJgDvrV4cYk0nIUFyAEQXCl19p0teHDRsGhMJf/dquTWeC72pnpHO
	squbKVtVj+ZfqvvT3CV9wySyHjKOJvTc6rwtBc8nB3z5xF3Nm+5A02VwOcOOCTTCUF2XA5AZH4v
	5Nigc7TEZaXRFUthXRPk1IWe3t2EfOrj1gn9J911T7A5MWwEkKrdQDA==
X-Received: by 2002:a05:6000:460a:b0:460:3233:beeb with SMTP id ffacd0b85a97d-460677b4012mr1689572f8f.43.1781157856484;
        Wed, 10 Jun 2026 23:04:16 -0700 (PDT)
X-Received: by 2002:a05:6000:460a:b0:460:3233:beeb with SMTP id ffacd0b85a97d-460677b4012mr1689509f8f.43.1781157855948;
        Wed, 10 Jun 2026 23:04:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm135110395f8f.27.2026.06.10.23.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:04:14 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:04:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Xiang Mei <xmei5@asu.edu>, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, minhquangbui99@gmail.com,
	bestswngs@gmail.com, jasowang@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet
 frag loop
Message-ID: <20260611015712-mutt-send-email-mst@kernel.org>
References: <20260610232936.1176094-1-xmei5@asu.edu>
 <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297950-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[asu.edu,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB8966EE09

On Thu, Jun 11, 2026 at 10:18:49AM +0800, Xuan Zhuo wrote:
> On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > This is a robustness hardening patch. The slow-path frag loop in
> > page_to_skb() walks the page chain via page->private until the
> > device-reported len is consumed, implicitly trusting that len fits the
> > chain. It does not stop when the chain is exhausted (page becomes NULL
> > at the tail), nor when nr_frags reaches the end of the static
> > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> >
> > Both bounds are needed: the chain length is big_packets_num_skbfrags + 1
> > pages, which for an MTU-driven configuration can be well below
> > MAX_SKB_FRAGS, so neither guard implies the other.

i don't get it, and then what?

> >
> > Make the loop self-defending so it no longer relies on the caller having
> > validated len: stop once the chain is exhausted, and never index past
> > MAX_SKB_FRAGS. No functional change for well-formed input.
> 
> At this point, we are assuming that len represents the correct packet length.
> If
> there is a bug in the validation, it can be fixed, just like in your previous
> patch. Indeed, not checking nr_frags is also based on the overall design.
> However, I do not recommend adding this kind of enhancement. If we follow
> this logic, we would end up adding similar code in many other places, which
> doesn't make much sense.
> 
> Thanks.


I will be frank, I'm never sure where the confidential computing guys
draw the line.

Are speculative things of concern, for example?


> >
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: robustness patch
> >
> >  drivers/net/virtio_net.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index afe73eda1491..518c22fa1b68 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >  	}
> >
> >  	BUG_ON(offset >= PAGE_SIZE);
> > -	while (len) {
> > +	while (len && page) {


don't see why we would check page

> >  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
> > +
> > +		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
> > +			break;

so do we want BUG_ON here maybe?

> >  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
> >  				frag_size, truesize);
> >  		len -= frag_size;
> > --
> > 2.43.0
> >


