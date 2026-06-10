Return-Path: <netdev+bounces-297861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fpDUIrH0KWpXgAMAu9opvQ
	(envelope-from <netdev+bounces-297861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:35:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F322166D640
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:35:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=fWezjrY6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297861-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297861-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24593025E56
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01635F185;
	Wed, 10 Jun 2026 23:35:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F16330317
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:35:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134511; cv=none; b=lL2f3PREXmOaFVVIOhqO/gQHyVcK/LXvhB50s9aHe2wtifX4bh2cSJKWrojQsQY9TOrA6F7RGewd55xWFwAnNhwo1MtleIcj6ldTrSymp+dX86akLeL1Yt8SOk3HODpJ3JhXR0RUThds/ht/z4ukjIsiz5zpZmZm5F/RJHbVhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134511; c=relaxed/simple;
	bh=Q0GHcH8Um8SH1FpKA3xq0Nka+lgPxYfvFIDdo8kKVp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMtVmrK971McKBof+YmnpPR1fOAzvESfEWCq841OR38bHsaJz81/uvdREluwgITn32g7PoyNPiRvlwGEA61jSFhgV4v4afRC52ERjuEuH+3XrNYhu4AVV8kKchqLBc5+ElknvV30cultOA14hLVySrP7MOCWtEDupL8Jq1FlXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=fWezjrY6; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso70579475ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781134509; x=1781739309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gu9x5/y7r12LiwFW9csPbVwnmzWa33CTWccxkH9Atw=;
        b=fWezjrY69yUKp/jEyS7yUomuRXrC28QlAYmhphcd6aIIXpqYeOFnoG/Sq+S2htGMcl
         SOZimFbNv6vgo1rycaj7eyd2BeqpvjB5ye/BGOrVoD7Hum6xTaNH2UB4fl0OHGXG0wtW
         4iQlO1+8ufzGArEdC5KdjBKEmYal19qY33Xc92BpM/qnCt/4ChdFDDeMhpmmWJYU3tlR
         0YiprBNAK6KRXaoAvxgk90OGJdnFYbMHG6GSmeEBj66ONMB3HgQKNvp2lwDN+cEIfOPX
         SDuJelLgdmdVJbZmDhJD0LBFeoz2whiMw7LmeoEDGf6PcFI1QjaN0PkPMXmFB2VsK/Kt
         TxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134509; x=1781739309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gu9x5/y7r12LiwFW9csPbVwnmzWa33CTWccxkH9Atw=;
        b=h8IbE+rFT1X2pKahAgdUd1Goe/fs3MzSeJaVu9KxTxkmU/Yp8E7stGB6e43YKByTa8
         FB5izjeg8ZFGWbscpwPV84f5nMpvnxnBs92SubnDrOhQx/iRaNGeTlT4t+b7UdeLQJvn
         0FIyIb5JR6WWuT0g0WytBjJv5kMQ+bKYQeB0k2w0q7yVkjUOD5gbC8uroaHUeRXlqNJ2
         IKTXt7o6Fa9lNOcpzscr0qJ7TIFOcQWi+TV1EJcdGl5PoxgGiMfXZXRjnVnDaHyJy3Ls
         fhZ1BZQK0bs4TvdbFD0IKDfoet/p0Cs9EzVMKR3EQYhM9WEu6N0M5CIXNQTyaybCNH3H
         PMhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3+9Uk84HKTNvveQDRE9NL7lGmY4VpPR1i1cQCbpX2m1hzozabBiDUub0zNGLFqx2mDMoYUuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYd5OVe37s7WSvJYrn7cViAzx0rAITrgiLpcP7UYiGEK4E2zfA
	1E+p9cnr72g/1ojiuCCICsVxbxOOOS577BfakE01KTEp1BLkxP6/cFyyC9AXz3qyrQ==
X-Gm-Gg: Acq92OFCdKEnJt7DZR5tBKXntGoj3/RuViC463zyyMXMf5klnTxNsZg1qJ3qf7xoucp
	cxRDRt1YOhBAYQEqrh+sFSlK77M63IHMogrKAbkzIN5HfrCETm2yHiJlf02n+AHQ2LJcUHMecw6
	LNuzvm1hu3RM0QkOwvpwb0Ykw42xL8ZoO2PRGVmwR5Hi6zyRnxzY6qbD5Xw6tOArx/cAfMkhMK4
	xwIZrJYyVdyAG2OzsDf6XaAmCV7MtqQyObreTkKZRAX/jGS/0IoFLkzK9O9L1ityBUbbKNY1SGy
	df3wvF3tK52GBRbOiEl80AI2zAih4QptgfdhIsvNBqiX35Xak12EsLSNbeaPnvMe7cU2l2VvqLM
	hrZ7PH1u3g2C6d4dUG3oX3FIRwp9zBDSPNhKnoCWXdb+BytUbK69VaSNAp4m1KJXRJWw9RmxICF
	VTl8in90lMYSmgc51l
X-Received: by 2002:a17:902:e745:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c2edae7b99mr2130765ad.0.1781134509375;
        Wed, 10 Jun 2026 16:35:09 -0700 (PDT)
Received: from p1 ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm7649435ad.77.2026.06.10.16.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:35:09 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:35:06 -0700
From: Xiang Mei <xmei5@asu.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
Message-ID: <5vtwwpfftbzq7ehm6itoq2263gffo67yv4nebrwgsa6fkb2t7s@wdxt4exrvfpj>
References: <20260610221606.1091465-1-xmei5@asu.edu>
 <20260610181911-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610181911-mutt-send-email-mst@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F322166D640

On Wed, Jun 10, 2026 at 06:21:49PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2026 at 03:16:06PM -0700, Xiang Mei wrote:
> > receive_big() bounds the device-announced length by
> > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > add_recvbuf_big() sets sg[1] to start at offset
> > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > check allows for the common hdr_len == 12 case.
> > 
> > A malicious virtio backend can announce a len in that gap.  page_to_skb()
> > then walks one frag past the page chain, storing a NULL page->private
> > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > write past the static frag array and a NULL frag handed up the rx path.
> > Bound len by the size add_recvbuf_big() actually advertised.
> > 
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> Let's instead (or additionally?), bound the frags array index.

I went with "additionally" rather than "instead": 1/2 restores the
length invariant in receive_big(), and 2/2 makes the frag loop
self-defending so it no longer depends on the caller validating len.

I didn't find a case triggering the issue of 2/2 so I could not produce
a PoC that actually crashes the kernel through 2/2's path independently
of the 1/2 bug. With 1/2 applied, the over-long len is rejected before
the loop, so the guard is never exercised by a real trigger I could find.

So 2/2 is defense-in-depth rather than a demonstrated separate bug.
Please feel free to decide whether it's worth taking. A v2 was sent.

Thanks,
Xiang
> 
> Seems more robust.
> 
> > ---
> >  drivers/net/virtio_net.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..afe73eda1491 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
> >  				   struct virtnet_rq_stats *stats)
> >  {
> >  	struct page *page = buf;
> > +	unsigned long max_len;
> >  	struct sk_buff *skb;
> >  
> >  	/* Make sure that len does not exceed the size allocated in
> >  	 * add_recvbuf_big.
> >  	 */
> > -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> > +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> > +		  vi->big_packets_num_skbfrags * PAGE_SIZE;
> > +	if (unlikely(len > max_len)) {
> >  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> > -			 dev->name, len,
> > -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +			 dev->name, len, max_len);
> >  		goto err;
> >  	}
> >  
> > -- 
> > 2.43.0
> 

