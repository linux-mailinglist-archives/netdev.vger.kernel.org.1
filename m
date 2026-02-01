Return-Path: <netdev+bounces-255675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HJrNAm/f2l9xAIAu9opvQ
	(envelope-from <netdev+bounces-255675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:00:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A61C73B7
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 311A93004585
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DADB2D7DF6;
	Sun,  1 Feb 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDpDWUZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57092D8792
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769979653; cv=none; b=pMuzR3CR7P6uk6EpyMxh/VGWBWchUo6LYFQ9MYZ9d1OplDHVxC02tEgww/CpTSvizX01MyD1H9qua1nPIL2FxwwsA5vPgRNRvwukGKZSjmLbBGePTLucUFsCJjWTDCKhpxurAk5hxgGokim09ekpmk5YYOFTqcRX9he6aHq8/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769979653; c=relaxed/simple;
	bh=/KLKo4Flumlbcv8+m36qKmRqvJ7JsFyT0spsicfILaI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sHGB1IGvakMowFHG155H3Zr5I+2G2Z5rKzPcRAHW447YEwowuU4y8uG8hg6RJLPEWC7VGc7H+ZuT/JVwvMmLuRWV8jv9YHxGvEC8Ky76s+33fA16RpbVTkM2TE+y8esIpkFcMosnPvtK4jmupOZdN8d7r+3N/VMhdAu0E/KGIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDpDWUZY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-794d4f11a20so2561127b3.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769979651; x=1770584451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfxpBhG8NkbxSh3fbCVpxo3CZMgN0PUTK9yRw7CZ4dc=;
        b=EDpDWUZYSZXaVjwBFaCIGxnmoNVd9kvrNDxYCc6ySQUrJozPdC2cQTWqUPWBiJ2VW0
         IPdMfoWOcOq0PWt5NwXPlVC9K5UnRUCb8Qq9CH12Yf8xYMvaIUU3VwXHwEsjZjPeAJpt
         Ra/S5dqLq9uRqw1BatpeB9g702FQdIf/4psbu7L3QqdsM/ZATREKkSg5Tzh+rq5D5Lw3
         SI7++FQ9vPQ/6hGW07mzYPYgEtJUOMhwV47Pb5qABlmXl6jSnp3Ep1bRFQMZdA3K4+2k
         vZmlovG6Uf+fApsJcMWMUfxFWlnCioFcZWLzVZeyujhrnt3eCPYB5eOfQsFCuyIpiU7T
         ocMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769979651; x=1770584451;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfxpBhG8NkbxSh3fbCVpxo3CZMgN0PUTK9yRw7CZ4dc=;
        b=e0Z5DTeCU/S7Xkux/AYUlk4kWwor+bHE5o8Fxi9u0+BhKsH1yA0RqCb4SN1c6QjkC3
         VPhDlPUHUSnVtwktUCPdKIZtORkwoi+NLrEUwBQL1XqYZeJgdpZ09Tg3s7pgsvxzhd7A
         KhXZGU7L8gYdCl7K6yx37R281uk0dntSfbxswQxMLpEWFBxKMLGW79ISnfErdr1/CuiH
         7uGA4S9fGbn4Lk7tO4TjyJkiR5cDEL2BsmO5v/87EOcA5lMViCTa4fq4OnvPiqgXEH8t
         E8x4exdGTOdq8gNpFFLCCchDaMQVqvSHJtJvm0SR5srvCGDnLsKjkF8h7tU34Hd3qkKK
         YNyg==
X-Forwarded-Encrypted: i=1; AJvYcCVmt3mikiCO2jPaS/cRz9+UZMLRBt+iY9kaxBj/jNXu/v8CUQ/1spknYyQt+eUJD1AcQKj8240=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFje5wmO4hGoDY/eyyu4ij73G6AERSd3+hBMAMpLWnjewDaDU
	kfsgz0QxiRablx2LN6/+GXvXyRbo2w/ct0OMJuyZz45Q6MpHoIF8t8AL
X-Gm-Gg: AZuq6aKstae6AjbBm3EbvmEPyUmL8pD3sfcyiRV2zZ8cVKRrNhEZBq1zzBy48JcosSW
	zgmiGvrNLg3uU4pCofwbcu/RfLh7iAy/Qhqyaa5/xeJbv5NQNUjKzHc+5VGVTN67bf5sRoiHX/2
	vbiyq9a34YxnkNLF5f76Wg2vc67ovpZHrtFowmfQD2AUuPYHcM6pO884AGE9KYFY/KlVkInQQeC
	wqzfNMpx7bupf2mkeY0QbZerxyySIXD0qKJzLqLBkdxRhlZZ8xKeMW1BAWnDD2BMy997tKUZ4/5
	YkVetMvzH5068qI4da/s8QU2aex0A6cwj1bITD/M7Ry3XQzfwGIurBrpvoABzMIpysdNW07DiX7
	PJif7aDeS1UUO0NzbbI/BHlIYLTtSFOoK14P00GTFwr9WyqQMAsMmBt0lqpRzxpbiF6pvB50wf3
	7nVnRMx6nVK9oGbFf3VzQsy3KQJ2YadU8V987r0CiixW+IIQy9RFvETRUulqc=
X-Received: by 2002:a05:690c:10c:b0:794:d0b5:eb3f with SMTP id 00721157ae682-794d0b5f48fmr12637327b3.41.1769979650912;
        Sun, 01 Feb 2026 13:00:50 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794da35c55dsm2032817b3.53.2026.02.01.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:00:50 -0800 (PST)
Date: Sun, 01 Feb 2026 16:00:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.391644a186dc6@gmail.com>
In-Reply-To: <20260129-v6-7-topic-virtio-net-ptp-v2-1-30a27dc52760@pengutronix.de>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-1-30a27dc52760@pengutronix.de>
Subject: Re: [PATCH RFC v2 1/2] tun: support rx-tstamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255675-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 54A61C73B7
X-Rspamd-Action: no action

Steffen Trumtrar wrote:
> Demonstrate support for new virtio-net features
> 
> VIRTIO_NET_HDR_F_TSTAMP
> 
> This is not intended to be merged.
> 
> A full feature test also requires a patched qemu binary that knows
> these features and negotiates correct vnet_hdr_sz in
> virtio_net_set_mrg_rx_bufs. See
> https://github.com/strumtrar/qemu/tree/v10.2.0/virtio-rx-stamps
> 
> Not-yet-signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/net/tun.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8192740357a09..aa988a9c4bc99 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2065,23 +2065,29 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr_v1_hash_tunnel hdr;
> -		struct virtio_net_hdr *gso;
> +		struct virtio_net_hdr_v1_hash_tunnel_ts hdr;

This patch refers to a struct that does not exist yet, so this cannot
compile?

> +
> +		memset(&hdr, 0, sizeof(hdr));
>  
>  		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
> -						&hdr);
> +						(struct virtio_net_hdr_v1_hash_tunnel *)&hdr);
>  		if (ret)
>  			return ret;
>  
> -		/*
> -		 * Drop the packet if the configured header size is too small
> -		 * WRT the enabled offloads.
> -		 */
> -		gso = (struct virtio_net_hdr *)&hdr;
> -		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
> -					 iter, gso);
> -		if (ret)
> -			return ret;
> +		if (vnet_hdr_sz >= sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts)) {
> +			__le64 tstamp = cpu_to_le64(ktime_get_ns());
> +
> +			hdr.tstamp_0 = (tstamp & 0x000000000000ffffULL) >> 0;
> +			hdr.tstamp_1 = (tstamp & 0x00000000ffff0000ULL) >> 16;
> +			hdr.tstamp_2 = (tstamp & 0x0000ffff00000000ULL) >> 32;
> +			hdr.tstamp_3 = (tstamp & 0xffff000000000000ULL) >> 48;
> +		}
> +
> +		if (unlikely(iov_iter_count(iter) < vnet_hdr_sz))
> +			return -EINVAL;
> +
> +		if (unlikely(copy_to_iter(&hdr, vnet_hdr_sz, iter) != vnet_hdr_sz))
> +			return -EFAULT;
>  	}
>  
>  	if (vlan_hlen) {
> 
> -- 
> 2.52.0
> 



