Return-Path: <netdev+bounces-242651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C8C93705
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 427F94E1328
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17E223DC0;
	Sat, 29 Nov 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZixO3ece"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0913A86C
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764385654; cv=none; b=azo91dV8nfaBbnrDGgbmvLgMCcsS8+cTOSaucKuhmjwJlWJILJD4Lyggm/arwq05MFv1pxmp6uEdBj+Kg6R9ZQa1HiUY6loL6UmKBVPin82RTMxAq9tL3RmLF74uYLULSaQideXM8ZEc5lZOamnuiijM354xxXQipehWnwkw4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764385654; c=relaxed/simple;
	bh=i7d/JjGE996R/8lwFrxhtcafs5K3uAtnPCbOmHcQzHc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nASrkUYOgFfD0DjWGOR834R0o+vq+5VUMZWxRh2Kl0u+2yuGMuQ805xzl3tb5r06LW3LIKxb1WKJ7fhdcPxTEyDyQtu8iwjZNkDHqmOHnuOo+xwuJKZBE1F1MRTMv8vaapesuP8n0/Usn1Xx/FMZoXjD6UkK+YyUJ7lhp6qI68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZixO3ece; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so1949847d50.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 19:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764385651; x=1764990451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dTc4SUlo6FET8I95Kfc8/GCajvNCzTaNB2LD+1bo1k=;
        b=ZixO3ececG4Vr10Z1pal8gQDzfETPFerpmiLGnRHCKwBHMOpAmuepbI99+GbFsRo0v
         NzvUEdOIuQiaTCA01GAr78yd6PWplyehgBTamQqaykB1T10JQjLcyOxve+xTDiqWrfa7
         qtC5Pqx5/4GboCwm25IfQQfy0KnH1ATyv6sOCRARZsmNAEiAWgR2B9+zU98KvRemfFt6
         nhTgJRPmCjSA8XvJzG1wgqBn6AXRUzStE74rE8tP7qGR75fuOPse/X5iPcXWY4SCpcu2
         OEsDbS007J1IGHVnxnTvwCFxeLXF3sxXKwGm2avPBaGhXKEG1IL9a2ThlCSlYc5dEyJE
         jIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764385651; x=1764990451;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dTc4SUlo6FET8I95Kfc8/GCajvNCzTaNB2LD+1bo1k=;
        b=fIPOr92ImInvvsx0DiOh0lbY3hDvINWVqpWWOMjt1yGPmhRZxJkdR6CTxtEfUjtlO1
         KbZRZkj4YSpQ2v+Vn0F6XOX7yURf8Ppu+V8WHTeX/+GmniPW0En0Bqi+GwQ2HMKo41Bw
         zPFNAIH+y/Bf9y+6dXjL2YT1MposVFvdLRVWUq6tieBqoVq+OoK8lh7q9YTZQ19TP88v
         vyoeKSBnGs7BXGNoFiYjMaOp2+dK+3a2Z1swBI686lVOpIQfeTkFrNJ1WgueSpm8ws0l
         z/xNmQNA8ECjkMwCL2Xck2zyp6bvsbV7RjEdl3jz3pg14haIVaGPoWRU98tnqFhZ9Bv+
         Symg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0z/U8bK0O/PBKil5EiSSCv6y/vIGW7UEHbmPQFN9hV7eV/PHLsHjHgPbyBQuhYnDFrPx6U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplX6UYnX2j97/PzjJrzv7Q66ZXCfDuV+A40brrtRaL/sR+7Qa
	i3W0bmXaZATXLlElZTExp1CzfuuiGSrUuCJlbk21nlMcOi7S+J4NApLP
X-Gm-Gg: ASbGncv9f3iiTiavlqOPTNJLJQa2n3LHSSMoStAEH1kThzaAOhIDFqtAPNlVUrPTYNk
	GU8Y28Epm+w0C1b/JOYfDts5Z64xCGrMoMULCwYUK356mn7GbbXqDCfvJuxj32z3N9eHHjn9SLv
	/mXt/0F/01s0XmjVv50/bP3nW9T0b0X84LaWZlnwZJqT/ZMJvx+oVeAhZBKKKI18oWDSpvPmkqx
	FhnSkLGw9itgATTjKOmbWNmJoSnjOWRVCSzBtLYAFhhOCu7tpl/6uFSAmlzpZWtkIgyWHq0kTNE
	qKA/T4HAIuEQkUrSrQ+vp9aAqMoSuoIpsEV1yfNyRFxEglvdoprAH810EjrrtAZLl8jwS4JStgZ
	5n8wEthFaJX0rBoeyrWW6yBd5hPHkjSxNm7cyYCF9N1Y1w9YO4pkugZNl6QRlg4O81vkPAxSeAd
	t1Hi9y3iZ8WOkxwv7RrrowYxaAt87coRifprTdUILIXq06uIbskboP1Xw01bJmrCxHTyc=
X-Google-Smtp-Source: AGHT+IFOjKnFo64ifG4JVzuMIvb28dYgZkGcRWeJz9pcMnM2KXYf1dWYdFEA98XMUayJv/SGqwxaVA==
X-Received: by 2002:a53:d905:0:b0:641:f5bc:69a0 with SMTP id 956f58d0204a3-64329386ac1mr10159067d50.78.1764385651529;
        Fri, 28 Nov 2025 19:07:31 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6433c4692a2sm2079598d50.17.2025.11.28.19.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 19:07:30 -0800 (PST)
Date: Fri, 28 Nov 2025 22:07:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org (open list)
Cc: Jon Kohler <jon@nutanix.com>
Message-ID: <willemdebruijn.kernel.1c90f25a9b9a9@gmail.com>
In-Reply-To: <20251125200041.1565663-4-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-4-jon@nutanix.com>
Subject: Re: [PATCH net-next v2 3/9] tun: correct drop statistics in
 tun_put_user
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Fold kfree_skb and consume_skb for tun_put_user into tun_put_user and
> rework kfree_skb to take a drop reason. Add drop reason to all drop
> sites and ensure that all failing paths properly increment drop
> counter.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/net/tun.c | 51 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 68ad46ab04a4..e0f5e1fe4bd0 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2035,6 +2035,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  			    struct sk_buff *skb,
>  			    struct iov_iter *iter)
>  {
> +	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	struct tun_pi pi = { 0, skb->protocol };
>  	ssize_t total;
>  	int vlan_offset = 0;
> @@ -2051,8 +2052,11 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	total = skb->len + vlan_hlen + vnet_hdr_sz;
>  
>  	if (!(tun->flags & IFF_NO_PI)) {
> -		if (iov_iter_count(iter) < sizeof(pi))
> -			return -EINVAL;
> +		if (iov_iter_count(iter) < sizeof(pi)) {
> +			ret = -EINVAL;
> +			drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;

PI counts as SKB_DROP_REASON_DEV_HDR?

> +			goto drop;
> +		}
>  
>  		total += sizeof(pi);
>  		if (iov_iter_count(iter) < total) {
> @@ -2060,8 +2064,11 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  			pi.flags |= TUN_PKT_STRIP;
>  		}
>  
> -		if (copy_to_iter(&pi, sizeof(pi), iter) != sizeof(pi))
> -			return -EFAULT;
> +		if (copy_to_iter(&pi, sizeof(pi), iter) != sizeof(pi)) {
> +			ret = -EFAULT;
> +			drop_reason = SKB_DROP_REASON_SKB_UCOPY_FAULT;
> +			goto drop;
> +		}
>  	}
>  
>  	if (vnet_hdr_sz) {
> @@ -2070,8 +2077,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  
>  		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
>  						&hdr);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			drop_reason = SKB_DROP_REASON_DEV_HDR;
> +			goto drop;
> +		}
>  
>  		/*
>  		 * Drop the packet if the configured header size is too small
> @@ -2080,8 +2089,10 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  		gso = (struct virtio_net_hdr *)&hdr;
>  		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
>  					 iter, gso);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			drop_reason = SKB_DROP_REASON_DEV_HDR;
> +			goto drop;
> +		}
>  	}
>  
>  	if (vlan_hlen) {
> @@ -2094,23 +2105,33 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  		vlan_offset = offsetof(struct vlan_ethhdr, h_vlan_proto);
>  
>  		ret = skb_copy_datagram_iter(skb, 0, iter, vlan_offset);
> -		if (ret || !iov_iter_count(iter))
> -			goto done;
> +		if (ret || !iov_iter_count(iter)) {
> +			drop_reason = SKB_DROP_REASON_DEV_HDR;
> +			goto drop;
> +		}
>  
>  		ret = copy_to_iter(&veth, sizeof(veth), iter);
> -		if (ret != sizeof(veth) || !iov_iter_count(iter))
> -			goto done;
> +		if (ret != sizeof(veth) || !iov_iter_count(iter)) {
> +			drop_reason = SKB_DROP_REASON_DEV_HDR;
> +			goto drop;
> +		}
>  	}
>  
>  	skb_copy_datagram_iter(skb, vlan_offset, iter, skb->len - vlan_offset);
>  
> -done:
>  	/* caller is in process context, */
>  	preempt_disable();
>  	dev_sw_netstats_tx_add(tun->dev, 1, skb->len + vlan_hlen);
>  	preempt_enable();
>  
> +	consume_skb(skb);
> +
>  	return total;
> +
> +drop:
> +	dev_core_stats_tx_dropped_inc(tun->dev);
> +	kfree_skb_reason(skb, drop_reason);
> +	return ret;
>  }
>  
>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> @@ -2182,10 +2203,6 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>  		struct sk_buff *skb = ptr;
>  
>  		ret = tun_put_user(tun, tfile, skb, to);
> -		if (unlikely(ret < 0))
> -			kfree_skb(skb);
> -		else
> -			consume_skb(skb);
>  	}
>  
>  	return ret;
> -- 
> 2.43.0
> 



