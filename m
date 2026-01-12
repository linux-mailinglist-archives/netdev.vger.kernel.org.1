Return-Path: <netdev+bounces-249147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C167DD14DD0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848A9301EC61
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010BB311C22;
	Mon, 12 Jan 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1VI4fIT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB531195C
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244882; cv=none; b=qSF7SozhRk4hbs/RfWYYZA3NEKb7eBpv4QYxzb0X/IlC8zm6vHKJEQJdFyTUumT40tCqlY+x46mt7c1Z6zu2qB9NfzPC00DA0g/CRFtO9/tWhAR/Z3gCcQEsclT3UebKm2EDqUK+dCwxe6820dubH6vP4XHuMVrXITNSVXPaD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244882; c=relaxed/simple;
	bh=Mq7uXqS6T5Xz1xoZKG18HBsOLjiBcAZdwTFCXme3IrU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eTJBT02izXCk72FLiUGgdi88Ka1BB4S9pzErUzg2C5H1EthyzZ/19wmiH9bNdQ69ziQdnusKOdK7I6Q0OryXhH2IN41r+ffRfEtrhlu0pN0JyKtESmXgV8dxHMuJZuAX+osGKtDNF4hJBXbG0oRl717hYsX1NTBMRaLklaFZHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1VI4fIT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78e7ba9fc29so71774977b3.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768244880; x=1768849680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lC9vBT6yM5y7jhlUfarQ88uAGxz1NwoUlxmckh4/4Q=;
        b=j1VI4fITKMfFurLUmaB+6Eo/rovhqH9ZcAjrG3yOnamZzhlra7kA4uUkjmoC+wjPHj
         IHoVV3ugWJtFefJf+U1roN56XuPezSGwkHgZmEBvvxSrtBJreGFNqSvNPWqtFpS/bcOB
         nyF3caGRqmA7QiHxl7SWNqMnyVXKbndEqZsuN6SYPB4FUbfa/gWyk92grQxgJBFWYFl2
         z9+lqCvKzT4QHajED8e00vgB9TMfBMMLNwIwq6g6RTs3VEIZ0Su62qVvI3kHkyfaVwpG
         T8U73LqJQNWSWIzeMO/LLJOo7NJSczFzm/ADSbGIf8xvGAkYupJrOKq/QJxOMqj89dcb
         qTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244880; x=1768849680;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lC9vBT6yM5y7jhlUfarQ88uAGxz1NwoUlxmckh4/4Q=;
        b=KtfQs9EK1CBTvsMBekQFjw4ZdIU1d2IvsPfUb1ZeCi5VucDbAe/1Ga9Y3cBiYa1lL2
         rTYIyflcr5X2a8Kl91S4qBwfBpnlA5ajyVZ5Nit0IvK2NjR3TY0s06fIrXbKi9meoSyx
         +PZ9lLsK8LgeHtVVBavePpR/VKxKWhVRgACHAkFEIF5ejZLIekJ+qpCVB3R2KL7sXCD0
         OUBpYMrj56wxBCsIZwXZAK126BrkpWjxwafOiEyr59zh21bG67+5pOBJNByEW+t35QId
         Od+c0VcrR7LM49xQdpRebPM0Ap+eJMpEl1KS6dqnqb7jeUU2OcsTPHj7b37I/VIgCBLA
         xfaA==
X-Forwarded-Encrypted: i=1; AJvYcCXGGje6dumWc8XPYQh6pcj9jVpFyt0fbhncyC6Uo8r3r7A+o2CqU++BLeW/S9x1RiAsYjxrMR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo92zxIO4ukIt4SUxbcWG6DdrtjMacqpA0rVjh+mi5iReAw3ui
	17ZOQMPiyXMUC3EA3SiAcZH80KyGtXwVOh/RUnLHYd8BBTCpuhtghGs4
X-Gm-Gg: AY/fxX4OH738Z1kXH0I89XUDqo6iVCw4+T+ZAx9K7DWsed+gR9nSWWbo7Mujv4ztNhj
	s+kqBpQS5Rk1j5c0FJ5PgD6Flf9F36sgOWqzlTvR+91n5qb1lu0qYtdfXLUARpRCOAxD/U8wr+H
	UnM799W09NjN+7TcejbRiWRIbjFqIxqmeqDU+jgpvUXtKyp7avMsX5zk/uKH23Lwzpm6JZXrB9v
	UPUuSjW+9Beofww0GGwmrC7r8psWCdfv+c6bRuJR6agCcnBp6pznt2UHSVegNaUw21hW869ZwfD
	bm1cKXcyX/SCExbOxZ4aMBY5GcPLvMP+Tb35zzg5XW867pRePvAEBlsuDAQ2L52Oq1mIO30GP1C
	SvVwMGRf4qio9MZVUCx2c/3Qz3E11BgDzIS3FOeruSz8zQvjc1WGnJ9h9m0wDLvKYSe6JlI+L+Z
	TGMVq/k4N1g869TSZ92V/DYfdOjIjZ6OFH5Dr4b9tFwD85rQuBqFoI2xCoqjE=
X-Google-Smtp-Source: AGHT+IGMhShTLSM5xramlWSucf+AFeyl1EZsQeY2uRviPiqlBmNrtG8/e82FQkvZl2O2Dz9mOq4QCA==
X-Received: by 2002:a05:690e:11c4:b0:646:518b:8f8a with SMTP id 956f58d0204a3-64716b399femr16233996d50.18.1768244880112;
        Mon, 12 Jan 2026 11:08:00 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d8c500esm8295975d50.23.2026.01.12.11.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:07:59 -0800 (PST)
Date: Mon, 12 Jan 2026 14:07:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.338b382b46c4b@gmail.com>
In-Reply-To: <20260112172621.4188700-1-edumazet@google.com>
References: <20260112172621.4188700-1-edumazet@google.com>
Subject: Re: [PATCH net] net: add skb->data_len and (skb>end - skb->tail) to
 skb_dump()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> While working on a syzbot report, I found that skb_dump()
> is lacking two important parts :
> 
> - skb->data_len.
> 
> - (skb>end - skb->tail) tailroom is zero if skb is not linear.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Good point on tailroom, I was not aware of that limitation on linear.

data_len is calculated from len and headlen, but may be nice to print.

> ---
>  net/core/skbuff.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a56133902c0d9c47b45a4a19b228b151456e5051..61746c2b95f63e465c1f2cd05bf6a61bc5331d8f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1312,14 +1312,15 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
>  	has_mac = skb_mac_header_was_set(skb);
>  	has_trans = skb_transport_header_was_set(skb);
>  
> -	printk("%sskb len=%u headroom=%u headlen=%u tailroom=%u\n"
> -	       "mac=(%d,%d) mac_len=%u net=(%d,%d) trans=%d\n"
> +	printk("%sskb len=%u data_len=%u headroom=%u headlen=%u tailroom=%u\n"

Maybe order len, headlen, datalen, headroom, tailroom.

And really no need to ever print skb_tailroom if end-tail always
captures that. Can just call that tailroom or tailroom* or so.

> +	       "end-tail=%u mac=(%d,%d) mac_len=%u net=(%d,%d) trans=%d\n"
>  	       "shinfo(txflags=%u nr_frags=%u gso(size=%hu type=%u segs=%hu))\n"
>  	       "csum(0x%x start=%u offset=%u ip_summed=%u complete_sw=%u valid=%u level=%u)\n"
>  	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n"
>  	       "priority=0x%x mark=0x%x alloc_cpu=%u vlan_all=0x%x\n"
>  	       "encapsulation=%d inner(proto=0x%04x, mac=%u, net=%u, trans=%u)\n",
> -	       level, skb->len, headroom, skb_headlen(skb), tailroom,
> +	       level, skb->len, skb->data_len, headroom, skb_headlen(skb),
> +	       tailroom, skb->end - skb->tail,
>  	       has_mac ? skb->mac_header : -1,
>  	       has_mac ? skb_mac_header_len(skb) : -1,
>  	       skb->mac_len,
> -- 
> 2.52.0.457.g6b5491de43-goog
> 



