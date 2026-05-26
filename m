Return-Path: <netdev+bounces-291560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKA5OSpGFWqLUAcAu9opvQ
	(envelope-from <netdev+bounces-291560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:05:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A82805D175E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A43D1300290E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE69380FFA;
	Tue, 26 May 2026 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeOs6iZb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fex4HEuP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14423A16A1
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779109; cv=none; b=WcJ2tVPURkVs0aCJ+en2KQLIrk4FsBZyD0kwyjzTEBUbU1q9vfJM50X1QqyxhYWjdyL/17yAKrKH8TwONJmH7oXJ7jy8R9rJ78cNbe39TILFbIhOrg1ZOQ9dbkjP/s4f450FQa88aJ2xDKRVpwJ8Wq9qssDSY312LbEnwBGWyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779109; c=relaxed/simple;
	bh=o2RBapBmX9hqXK1NnY+/NWTaE9ow+88lOkiLWkfu8tE=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=BH7uePgnsIdMjBNmFbnDSNaqS9Y873BFrJNJG+aKS4NPT3UfcrsUb+A3HPxG8T+IDbnhAKj5VhXbPrSF+f4X/GRkdSTD5l3i0ZbgerTF8jlIm5EX+0lb1odjuUhLEYbCv2eJgIrn9dsGpzOIwDcAb25SFlOP+vxpo/nh8EuzoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeOs6iZb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fex4HEuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779779107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFPSvUXpvUDVJLrY4mZQm5cudwGq3ibM3+1n/tYIJT0=;
	b=IeOs6iZbRnkhUyXWHQQVXNz4KA6Wq2VOAAuJTNDgbi5oZwogj7jJ0OoG1wqKt+XT8dZmRv
	Jcb3zg/VA+SSvgJWGft2txQSzaNg4ONH8zIQgPwfqrteAkdYpDK5WhSkQaoAJHIjM09p0s
	ORW8Cc2H/5ssnGNwaf1X0koL+zVYeD8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-hRC3YesoOY-3MGvegcxpcw-1; Tue, 26 May 2026 03:05:05 -0400
X-MC-Unique: hRC3YesoOY-3MGvegcxpcw-1
X-Mimecast-MFC-AGG-ID: hRC3YesoOY-3MGvegcxpcw_1779779104
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bd9a6aae530so655408066b.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779779104; x=1780383904; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFPSvUXpvUDVJLrY4mZQm5cudwGq3ibM3+1n/tYIJT0=;
        b=fex4HEuPwKwIEq42GjDKqBf/IFXAvfqKzwNgPeevAG3tyBMDId+Y1SPXLc2ANTvlfI
         6jH8yxarJeuhir7dIwH0OdFNbCBOusHf3TflaWXy+1srejfa6TVjh1gfDS5qzOJ3ctlT
         R33ipoWp1tP8ZjIJWlukoVLnTx1ZHgavgerF2ho/ujp6oUJ5HQdk9LvSmT/XBV5WHvQI
         +RCwQtYNya7DFtmRxpWwG5SWbM4TiyzlhgwD27AKCcztN/tWv5hbfAMzphnyAd2FYfAq
         cXKWv15CjJbG+e4ERoEdDmwYcFZDnvd8JDijPdDhoz/yDdXmErTqR6LRT8FcdKyG2TSJ
         rcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779779104; x=1780383904;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFPSvUXpvUDVJLrY4mZQm5cudwGq3ibM3+1n/tYIJT0=;
        b=OFwKSXOdF5Lhqo0mxvjW0Xf8jPRb5yqwECZyxQsfF+KLcIwbhYeO5lOxfQ8rFEI7Kz
         3CmRI/grPqgeGi0p9+aB0WG2FjlTA83U4yeom6O7XFVhDdBs1O+vmbjTeScffad6jmXi
         WS35ph2lIRUxxkqy+dHbO4UaF/2dttNXnUbWDIz9sx2/fhhU4uufnptgVEpCy0LP1lDR
         yYc1IsMF4FxarI9Bk73QXYg0g7qpYXTMvT457AgH5qp4dYlkgmt0gtXi6ra9H6uPd9za
         Leu9ojGI6F4+yRB7mJ2iqCTHY5VLoEXk7Jm39eNo9hV4/LbXePbbfT0LhQqMdlUBc9/j
         GvFw==
X-Forwarded-Encrypted: i=1; AFNElJ+wEa3oOwSl/g86bBKKPp0FC9ZeRD4kI4yOMts1o/AvneNuY+zrgK/5bOo+48Pco6hqwFD8ivo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymnvoYwJYnxuL7j7mk5JOXwe9iRYPAdkVJ/o53nMsrifrphqL/
	UPu+trklwAL8/Gjyk1RgJyg9+Lp1VYrNFwOX62Sa//yMeG3eQBKV4o7/cQ3HcX06f7N71KvPuWk
	QWlv9ffhs4XFby0zwir5TTzX/d0uom7hB+fEIAMStrivlAvNgJ1VgnN8PVg==
X-Gm-Gg: Acq92OHSTr3MLnVNpH2yF5va+azPsx8NDIERKfaL/UdgZFbYifAapJGETw6DzwbqwxT
	Cpoj+t4MuJEAPpkwQCxtuBBwu0uStp/xXCiKoLwrcmckAX8+gydm2jUO0F5G4GXkYV0TMhmIgxs
	pb6YLeywAnY/e4JuwlD6MAa9GQmULC+DtB5c7HGtI+5iU4bCH9uKcGWdXGqt8zral6NWE7LPSn8
	FXVJedOOFvZT5zkTY0xMOaIyK/FG8tO6mzHt24LWEZZFlcXHyqBjCi4zaDZyOnHDtI65YqEK2mn
	3dB14t28kUZ06pzfzC2D6kHg2BHxVwCTEOHsKJNOStnbi8D6BeceVYsRWzPERjRpMT0rrQSzyR/
	KJaqL/lewsQSjdh4IfTr6w23l1eRacewvQzf7S+z0sC14i7WoNg==
X-Received: by 2002:a17:907:2805:b0:bd3:1263:5a71 with SMTP id a640c23a62f3a-bdd282a7415mr812322166b.1.1779779103602;
        Tue, 26 May 2026 00:05:03 -0700 (PDT)
X-Received: by 2002:a17:907:2805:b0:bd3:1263:5a71 with SMTP id a640c23a62f3a-bdd282a7415mr812319366b.1.1779779103030;
        Tue, 26 May 2026 00:05:03 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5caeesm34028102f8f.29.2026.05.26.00.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:05:02 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net] vxlan: do not reuse cached ip_hdr() value after
 skb_tunnel_check_pmtu()
Message-ID: <20260526090501.4a6c2c37@elisabeth>
In-Reply-To: <20260525203642.2389723-1-edumazet@google.com>
References: <20260525203642.2389723-1-edumazet@google.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 26 May 2026 09:05:02 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-291560-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A82805D175E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 20:36:42 +0000
Eric Dumazet <edumazet@google.com> wrote:

> skb_tunnel_check_pmtu() can change skb->head.
> 
> Reusing old_iph afer skb_tunnel_check_pmtu() can cause an UAF.
> 
> Use instead ip_hdr(skb) as done in drivers/net/bareudp.c
> and drivers/net/geneve.c.
> 
> Found by Sashiko.
> 
> Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stefano Brivio <sbrivio@redhat.com>

Thanks for fixing this one as well.

I wonder if it would be clearer to reassign old_iph from ip_hdr(skb)
after the call to skb_tunnel_check_pmtu(), similarly to what commit
31392048f55f ("vxlan: Pull inner IP header in vxlan_xmit_one().") did.

Or maybe even to drop old_iph altogether, as it caused both bugs (the
one fixed by 31392048f55f and this one).

Either way, you have a fix ready and I guess the priority is to fix
this, and I could also send a follow-up patch for net-next, so:

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

> ---
>  drivers/net/vxlan/vxlan_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index e88798497503b53cbaf5bffad72cf3e1cc956410..b5b1253ac08ba46933249b06f19d1fe5a2ffd114 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2531,7 +2531,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  			goto out_unlock;
>  		}
>  
> -		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
> +		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
>  		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
>  		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
>  				      vni, md, flags, udp_sum);
> @@ -2605,7 +2605,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  			goto out_unlock;
>  		}
>  
> -		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
> +		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
>  		ttl = ttl ? : ip6_dst_hoplimit(ndst);
>  		skb_scrub_packet(skb, xnet);
>  		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),

-- 
Stefano


