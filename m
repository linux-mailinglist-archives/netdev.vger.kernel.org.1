Return-Path: <netdev+bounces-225342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE4B9268B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DECC3AEB45
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0E313E0F;
	Mon, 22 Sep 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdfgeFgq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7A313D73
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561935; cv=none; b=TcIVyE7PGApZUQ46BUosUNDAz6tt9A+r9d0KlQu3M/J+oQZINS+2KDzlum34LDlu1iWN5GRXLm8yHJny+VZgDm7qImEDQRIKDMiaS/1fSOudUGPWnef8k05vbAHp7+zmMgMdGqCGXag9cRiosbrycbMrIohpYLdTxYl06ZaYQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561935; c=relaxed/simple;
	bh=KAuXbOltxNgy8WInrPjwl+hbP8S2O9ZOc7MtIOcbUTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlK1OdxoLnIGVozmT99MqdOt9F5UEc6xhvTfQqQlUvVYn7XBY9zx9J/R1ywa5nr2bfr/Wbl9dW0xcPjIlKdl8TLl6hyGIIUkOHzbPeZX9UzKgP555L9HiSSNvL1tM4nDXkC58DHqcZNGUZ3ITzACqJu9SMa2P6Sr7XnXpfOmjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdfgeFgq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f2a62e44dso2249313b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758561933; x=1759166733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83D95CBgRcD/U9iqxIg7crplJ8r4aQkclY9VPZZgyWQ=;
        b=GdfgeFgqOxVh2urQIERiJYDbexbhDKKS86F8lmwn9GDnzp6T8PNznoW+twB6zBw7yF
         282f8+lfpdMh/4DtbXZpWbxiMTZ8lK4N6xyClpjCQhxZYCkETC5UVP/T81e0kumc+KJN
         cSA3ugGwDR2ajBvObtrNJl452Mr+uO19KJYS7Dg02uikWDeYpnZfPPNAohCmyVA4rqqY
         hUoBfOol0bwi4jNDUHoiExz2xyFEwkLTUG0QU0p+uM1h0+7v/UvVqoVbtEMW1gHe8t1z
         SKAFMIuVgq28rKIcW+CTnGrNLDqU9S5O2E5BSezT6IYqLE2lfy4z4vkeRXtGcTKfCMz0
         XiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561933; x=1759166733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83D95CBgRcD/U9iqxIg7crplJ8r4aQkclY9VPZZgyWQ=;
        b=HUCww5vU3rLNfHsAqqOmcwuWia5DVfHmLnGLOSYPEMt4YgQOv7bDWwdgFx0QuNWJwX
         8NR5/0jcjhayLgtbakhGc2nBiZv0LHtQES7lbfg8lk9+P30fYBjDV1af8ZSEKbhElQHa
         j+ej3jHxiDn38rDHCaWm8h+JBc0OSSMGcjAMZUU6kus97RIUqwnt6gouOD9jX+1S9RKn
         msGIxZHMnq7rS3UiJ1tOLOkVd19ayqi+UDmSyEDmtvwCAfSUhxWVEf/dor86rMgOkfMZ
         5DbG3d7rYqkLo6PT6cuBnMvaSzfp/tSRXI2Lzd9ST4pFzKF/1eZAB+TRRIIZSqmtGAec
         hCuA==
X-Forwarded-Encrypted: i=1; AJvYcCVgoNKYOEjiM2RkVfnzFSPuWH9THRaihd+FwQx7mgjAgsKqzWHn7VeY61vsyOaB7DuA9FNQkHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiLi9Yjbl9qidV7qe1TMZxMw+MvyrRpXcOT8Q/i3i4rCgWyNnz
	PUKzXavcRzjVMpU/mxOCMz6Zpc3HfqTCEn4wCIUq3wsFp02vStuVqT8=
X-Gm-Gg: ASbGnct8v7Dn40WnR3OBoM44cSVVTUhmNqeJQj/VefTIcikUA4FHAmj43/oGU9p8/BZ
	jHhbdcdx2ExLSIwWvLn7TyBsgjJN36tLbjDkIUs4fUjgSip4s2XX5Y9KDHpy2v8EC9ord/QNZ84
	Z9CdBlrFVsosK0hDCp1VsAt5qugz7d/PE+KVWzxnCKky9IjSQwQtMZzUusFfWKHirRuJkwJ+f0u
	o1F8NbmNOjm18uTmqWzSysYNZZ2Xe8T+am0EymPKs5L6bLJgCohmeMZLbqfpN9p8MdXPHZMBM/H
	JEPA6UxJyGTDSu7k31QbNCnrDI82jgYB73B0rfK2N0oN7QREoWTJqfwKyg4Dbcwft9QBio2GFy5
	HLG4LzXLi9b9cBJdUg77UNNZINbO4XpXhacKxvdxGK1qpeIw8l2K1zpforxdxgK5ONTQTwpnNOU
	JpABfXI3zdgdAkSJTuX1YQOX+p4aqohsQWs2WpzM6U/sl1YuR9I31n+gZnB6sFFU/7xICiwa+ax
	fCqXTl9lWuSNGo=
X-Google-Smtp-Source: AGHT+IE3N4rdtpdpacqN7GPlaTxmCFciYnc2RQAsf/slc5/UFJiPbgXgxGoXXCf5+yEOTyvFNLZkig==
X-Received: by 2002:a05:6a00:3c8f:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-77e4e5c5230mr13372885b3a.16.1758561933075;
        Mon, 22 Sep 2025 10:25:33 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77cfc2481d7sm13257873b3a.32.2025.09.22.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:25:32 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:25:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
Message-ID: <aNGGjMFT_bsByxcZ@mini-arch>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922152600.2455136-2-maciej.fijalkowski@intel.com>

On 09/22, Maciej Fijalkowski wrote:
> We are unnecessarily setting a bunch of skb fields per each processed
> descriptor, which is redundant for fragmented frames.
> 
> Let us set these respective members for first fragment only.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72e34bd2d925..72194f0a3fc0 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -758,6 +758,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  
>  			xsk_set_destructor_arg(skb, desc->addr);
> +			skb->dev = dev;
> +			skb->priority = READ_ONCE(xs->sk.sk_priority);
> +			skb->mark = READ_ONCE(xs->sk.sk_mark);
> +			skb->destructor = xsk_destruct_skb;
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
>  			struct xsk_addr_node *xsk_addr;
> @@ -826,14 +830,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
>  				skb->skb_mstamp_ns = meta->request.launch_time;
> +			xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
>  		}
>  	}
>  
> -	skb->dev = dev;
> -	skb->priority = READ_ONCE(xs->sk.sk_priority);
> -	skb->mark = READ_ONCE(xs->sk.sk_mark);
> -	skb->destructor = xsk_destruct_skb;
> -	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
>  	xsk_inc_num_desc(skb);

What about IFF_TX_SKB_NO_LINEAR case? I'm not super familiar with
it, but I don't see priority/mark being set over there after this change.

