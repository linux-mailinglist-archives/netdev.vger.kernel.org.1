Return-Path: <netdev+bounces-296335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0uwKBisUJmpKSAIAu9opvQ
	(envelope-from <netdev+bounces-296335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 03:00:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 701996520AF
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 03:00:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=qVQ6ov7N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296335-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296335-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70D673006501
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998D28504D;
	Mon,  8 Jun 2026 01:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB691CDFCA
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 01:00:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780880423; cv=none; b=Cq0r2+wQY53KzS+3eoFoILghyoL2VHI8OTOPgwAGvtyxbgA1pZ+UnHYiXj/s8J585wU/RFy/E0GBFkkrwHlx1vVDcuAy+3kOpcJWzqPOT6yKJqU/SCNAfn7GHJHMntgulFN6onQvBMOhWRRrPZu5ehGZ2drUH1ZPUM//GuNdmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780880423; c=relaxed/simple;
	bh=pxsBRDpzCaSXJSlYNmkIxUZ+hW+cKjVNZ10tp4sJHYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5D8Zm0BMey5L7OCo+CAMYKfLV1W+W2x/fV6Y+MOK7OEfGgH5W5Gms3R6kvqutr1O2YZeNRBwl8geyiZU+WbWpsXCFA810eZ88HlB/MRmYHrB1jC87vIoF/DNHcmyC/L0bW5BrYNx025pAgaYZb/wrM79j9qeVzmzwCDiBVJH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=qVQ6ov7N; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13810b63a1aso5195067c88.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780880421; x=1781485221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5Osf0k6o/Lbg67wyezRqjIUd5VU7+ISrwlc0l5JNNg=;
        b=qVQ6ov7NtVH2dvCFDM/JeATY1d2vkhNAH4cw+MXnXtEDXTrndvwnc79NFT5HLbNVTy
         zn8psJHlhJCvHz/JCmW5TpSEiyBCSjWf2udUlkBftVTZKgmsP5w4RHrOgGJK4U1FKP6a
         kyotMD3FNm61rSGvIKDGT/ShU5g34watwRFD/1+SRf7TCuZDB/X07bvHvpjFJiFfB5fG
         3Ij/I0jwI20v3SkTXhGGK29fcDr2KQYnbHorObSgmBuL74tVUPz9l2NwiSk8t4cK08cx
         l13J82UhC+e2Pqn5bA+FJyNBl2ARWvstgngtqWzD4+TnY+lJbJAGzfgY4+hTjh9VLMnv
         Ha0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780880421; x=1781485221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Osf0k6o/Lbg67wyezRqjIUd5VU7+ISrwlc0l5JNNg=;
        b=hO04FocXGTT8sVEw39zI9Y1k8MAF1OO5UdRWIPSf78oPU/EHtg2jyBuELbyEDmgvB1
         w0wbzHns6qAotQHUdchC3Rv2EvwOxlPAUhYfKEbubLrJqD+xbY8gC7HPlWzB+nECEddB
         ofgv27RchcxB9n3H6aveeE+MlTAFxmZBNX00Virux4ogiBhlL2JyD5lmn4wWlXULYT4a
         eB5eU68trWvw9SnTS3ZyJTkUZv1G1BCQ4DgflVwEiqnxjmyUfse4EijZH/p5xGmu3BRL
         D/dxobn2ExOkqFP+zXpGExLQuu36TTXva2JzFInOiwNtmgB5h/baWxWmqRyVZO6EqgXd
         CQ9g==
X-Gm-Message-State: AOJu0YxBky5FKdpuppcDsGBwz11LLq7MTKtLy35ZV8/XwlvK8/YlTGio
	xPSi50F4EOqWXk7QVveWlEQOGxh9fsL0hHAD71VoitZwkcMEDbaQpVf+DmWziiKfXQ==
X-Gm-Gg: Acq92OE3HSsLOZFBz0V0QjBom+P+HJttKsz2oxMikJcW4V3J+TKcmsVNpsMS95edI1T
	DBpKH5dig3GfFCcQRecYw8Qu3V8E40/PE5/1oU0alvq8ZXFfqkdAydL8B9m1y3pfEoZn9Atx5Gy
	oEG0dXtHdY68Bu84gGG+cpUE1nR74Pn1hqJHYDtuaRu6VAIJaGbTQBVhLYM/rWm4UfnKibEaxIQ
	yOeMoAGzuh9KYkoutqHNMySOyJZGgQyYc2jA1Nf68HRMF0op9UTiC78vU2Rrgp1Bm/Gbi+ka2Os
	SIDU15wTqM4e4UWqwOFCk4UBIH4Pbqslp7+8+r8rKpJkWENKbohwGEHHsZEJuWq1jQIk+XntQKs
	wBxGJFV+Qs60kWwNu3pHAhyttjvRMeJYuLrgZ5FmloxYNwMbJz9RawmpOrQn2+QftilgcSy5u0k
	Z9T7wIEMmRLJvmD42G
X-Received: by 2002:a05:7022:ef18:b0:12d:b26f:cafd with SMTP id a92af1059eb24-1380666872amr6843410c88.5.1780880420985;
        Sun, 07 Jun 2026 18:00:20 -0700 (PDT)
Received: from p1 ([2607:fb90:ecaf:d942:c23d:2198:9c43:68d4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5489d17sm10787236c88.1.2026.06.07.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 18:00:20 -0700 (PDT)
Date: Sun, 7 Jun 2026 18:00:17 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, bestswngs@gmail.com
Subject: Re: [PATCH net] tun: zero the whole vnet header in tun_put_user()
Message-ID: <mkkmzeske464wh2p5p55dpb5l6u3bsbtfum6vjvoosbxgek5xd@eezlud5652zi>
References: <20260607054428.3050243-1-xmei5@asu.edu>
 <willemdebruijn.kernel.134e1b2cf583@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.134e1b2cf583@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:bestswngs@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,lunn.ch,google.com,kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:from_mime,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 701996520AF

On Sun, Jun 07, 2026 at 05:12:09PM -0400, Willem de Bruijn wrote:
> Xiang Mei wrote:
> > tun_put_user() declares an on-stack struct virtio_net_hdr_v1_hash_tunnel
> > without zeroing it. For a non-tunnel skb, virtio_net_hdr_tnl_from_skb()
> > only initializes the first 10 bytes (sizeof(struct virtio_net_hdr)),
> > leaving bytes 10..23 (num_buffers and the hash/tunnel fields) as stack
> > garbage.
> > 
> > An unprivileged user can set the vnet header size to 24 with
> > TUNSETVNETHDRSZ, so __tun_vnet_hdr_put() copies all 24 bytes of the
> > partially-initialized struct to userspace, leaking 14 bytes of kernel
> > stack on every read of a non-tunnel packet.
> >
> > Fix it the same way tun_get_user() already does by zeroing the whole
> > header right after declaration.
> > 
> > Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> > ---
> >  drivers/net/tun.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 9e7744eb57a3..fed9dfdfcc3b 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -2070,6 +2070,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >  		struct virtio_net_hdr_v1_hash_tunnel hdr;
> >  		struct virtio_net_hdr *gso;
> >  
> > +		memset(&hdr, 0, sizeof(hdr));
> 
> Alternatively clear the trailing bytes only when uninitialized in
> virtio_net_hdr_tnl_from_skb. Sketch:
> 
> "
> +++ b/include/linux/virtio_net.h
> @@ -437,6 +437,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>                 if (feature_hdrlen && hdr->hdr_len)
>                         __virtio_net_set_hdrlen(skb, hdr, little_endian);
>  
> +               memset(hdr + 1, 0, sizeof(*vhdr) - sizeof(*hdr));
>                 return ret;
>         }
> "
> 
> But it's not trivial to very that all fields beyond the basic header
> do get initialized in the tunnel case. So clearing entirely certainly
> is a more straightforward correctness analysis.
> 
> >  		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
> >  						&hdr);
> >  		if (ret)
> > -- 
> > 2.43.0
> > 
> 
>
Thanks for your review.

