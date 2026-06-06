Return-Path: <netdev+bounces-296088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WcksMgjdI2o9zwEAu9opvQ
	(envelope-from <netdev+bounces-296088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:40:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE864CF40
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:40:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WQsKoxgn;
	dkim=pass header.d=redhat.com header.s=google header.b="nd1Lg/Th";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296088-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296088-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB74F301D68B
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A4316199;
	Sat,  6 Jun 2026 08:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CE2D5C7A
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 08:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780735221; cv=none; b=GQsfH1jZuFKrNjFizT7z7occbPR7Lp/cjGIrxxgS+GZbRKlJ12I5c/S9X9PHnXBF7737l1p/nVGYvvjrhd00b0RaRKatt2Kv+ml+JcN9N07zLncz624fkqKXnkz0+pd8rtwDPDblqIlXrgoI5toFmOYLZc3lTUSXdpWli9pjdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780735221; c=relaxed/simple;
	bh=rkhKQS89b50kiu4B39caolckRfcM07Ahq3gjWequ89o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwRC39yhwqGDhscdC42m7VuYcCDFH6oK8rp0voueAQIV0unM7Z+6HGyVMJjrVaPvfyVdEn4N5W6cA7XHQIFJynmSeKrqTSeBHVlZGfyXZod+OX9Zk1Gr09kkyxJhF8CU5Nt3ysyTxi5zJu9CGvUUvZxCpmjFuDZ/UABGuoG6aCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQsKoxgn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nd1Lg/Th; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780735219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a8D6PKyj3T42BmGkn1gN/k2Pm8r+kvs7tG5TWxDMy0=;
	b=WQsKoxgn3PN8/w8OeztXu0ygbG7QWpIIAEknMKDS3bHZ8wv4T3jamBQInPWiCjf2RhtB8t
	ra/Dg0+3ZOy3fUbj5fl+GRDIQPHXh7t7zkCucU7j6l/0r+/4BCmdc9yRbdqLdVFoWCCAIO
	v9NtuOBsU4YaS+6paub7IxlOqlxe2xs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-nq-pOYK7N0eS2UMeePWftQ-1; Sat, 06 Jun 2026 04:40:16 -0400
X-MC-Unique: nq-pOYK7N0eS2UMeePWftQ-1
X-Mimecast-MFC-AGG-ID: nq-pOYK7N0eS2UMeePWftQ_1780735215
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so23048065e9.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780735215; x=1781340015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6a8D6PKyj3T42BmGkn1gN/k2Pm8r+kvs7tG5TWxDMy0=;
        b=nd1Lg/Th4VRA1rN24GFqrT4gTMu484r2naWxluBqdunupDttAj6cCdx6kbrc56mtS2
         rrdXlGpuR8V698aF77DNCoUiNQDhhigQyKw//d8+jtuPwcbKR3u9DjovAfWe6gf2rVbL
         PfaHdkm0t2YW1N77PJYbC+fCIeKu6qU7YgJ3E2vMOyF6XN1WJ6YFeb2tUQ60vxBJvNeZ
         fdDjnfuvlPioRHhlA6rkI+agAchtPrmxZwmdazfPjUls1v3LxJa21j+WmECD7/WMLOWA
         NikJvFMeM3jEBbGmHs66BhCUHbLUf3rqWhDZ2BvIc3X/Xp79xXrFvphaC9bvvhDt5ymG
         AAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780735215; x=1781340015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6a8D6PKyj3T42BmGkn1gN/k2Pm8r+kvs7tG5TWxDMy0=;
        b=ljUVIhPRqp5mav58Y9+44TFaqlpkMjIMOb/TOfBYFb4pDJEvNDMkELG+CMRKKyZltK
         mfxo8VKsaMY+Voz726rXisLwPilUbGOvDrl47sAxlDnc7rhfSOI6lJgwK+/BAImUr+Fs
         JoACMTkD3zW2mo0FLpE+8vCeZ3ERzclaz7B9dbSI9wM70CM68Bl6IZDH7PD4IPL/+CBR
         5zgVSw2x1ezpx926q1iszc2mvL08NJzNsGFXStuvpa4UgYFOsSW5lfo2O571nuyiJU+v
         Ivh1SJnjifXkUNCkGnbAKB4MCtiKMcIjAjy1tSrOhhIDH14236Np9XXGre0Ju8QNl5ns
         p9fA==
X-Forwarded-Encrypted: i=1; AFNElJ9Wf/QqV+Zc/4dwEymfa7gVw5ddt7S+upefGI9YfvRbNE4zti3jfvcGKrF1TS4/LJx+Qzki4fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDP0ekL4LEgs1Z9ir+PP8VUIXTla8SvNVa1TQ6p15mzSaSMa3
	LJgzV0+tDDnWf9KX7yEozARfPjk7bGCxMwY6p5AzEJM5HaR/pCpKxsG4nhU5tV1XlGHNwTHgIDj
	L1H/XWt5JXXhlRBc1mnrl91pyMqnp6kevs4RfGTcEKGwVU4XVZeE93u2whA==
X-Gm-Gg: Acq92OFUPV9S95VTtxm8kn9xhLIYSDGdWPA3pcBWc8K1jMIJcM39wPCwHqAAgJmiHu5
	wJOzoL8zk3dg5JzZXI0y6X+A71FSjHWOv17CEiJ9o2utZmrJAd3UB67mIhw5/gS1d+8QcxZ5rd7
	OQ8MXg6xate4MVXzQNU80AVMYWRWHWn3j9Yv598+Qyb7SnRRQlSCHhKpINZbW5+t+yEfecjFx60
	540c7jwS2mZAgXRnCr/GGRrhec8V9LHVfyb5x5l1J5DC97XyYnYU5qDeJ+wItAEbhCi8Pz/oKoK
	0iGvLm8dcoQxPg6UNI57Mz51ltTBhU6V/NaPhHAqS4s3d935YXklMHAnm80X86GMwMmWHWz1wVY
	zzfuIBf+V2MsYEz7bYO8YA48=
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr107060605e9.9.1780735214986;
        Sat, 06 Jun 2026 01:40:14 -0700 (PDT)
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr107060075e9.9.1780735214457;
        Sat, 06 Jun 2026 01:40:14 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm222765095e9.13.2026.06.06.01.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 01:40:13 -0700 (PDT)
Date: Sat, 6 Jun 2026 04:40:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO NET DRIVER" <netdev@vger.kernel.org>,
	"open list:VIRTIO NET DRIVER" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_net: normalize non-positive napi_weight values
Message-ID: <20260606043757-mutt-send-email-mst@kernel.org>
References: <20260605194045.2625610-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605194045.2625610-1-sam.moelius@trailofbits.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296088-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trailofbits.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28BE864CF40

On Fri, Jun 05, 2026 at 07:40:44PM +0000, Samuel Moelius wrote:
> The virtio_net.napi_weight module parameter is signed and is copied
> directly into the RX NAPI weight after netif_napi_add_config().
> 
> A value of -1 lets virtnet_poll() run with a negative budget.  The RX
> loop processes no packets, the unsigned received-vs-budget comparison
> completes NAPI, and the NAPI core reports:
> 
> NAPI poll function virtnet_poll returned 0, exceeding its budget of -1
> 
> The device then repeatedly drops receive progress under stock QEMU
> virtio-net traffic.
> 
> Normalize non-positive values to the default NAPI weight before
> assigning the RX and TX NAPI weights.  TX NAPI can still be disabled
> through the separate napi_tx parameter, which intentionally sets the TX
> weight to zero.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>


Why should we bother working around admin errors in the kernel?
Leave it for the userspace tooling which can at least provide
useful diagnostics.

> ---
>  drivers/net/virtio_net.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..667026607cfa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6481,6 +6481,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  static int virtnet_alloc_queues(struct virtnet_info *vi)
>  {
>  	int i;
> +	int weight = napi_weight > 0 ? napi_weight : NAPI_POLL_WEIGHT;
>  
>  	if (vi->has_cvq) {
>  		vi->ctrl = kzalloc_obj(*vi->ctrl);
> @@ -6500,10 +6501,10 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  		vi->rq[i].pages = NULL;
>  		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
>  				      i);
> -		vi->rq[i].napi.weight = napi_weight;
> +		vi->rq[i].napi.weight = weight;
>  		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
>  					 virtnet_poll_tx,
> -					 napi_tx ? napi_weight : 0);
> +					 napi_tx ? weight : 0);
>  
>  		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
>  		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
> -- 
> 2.43.0


