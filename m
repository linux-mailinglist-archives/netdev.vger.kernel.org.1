Return-Path: <netdev+bounces-227883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 006AEBB9416
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 07:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB47F4E11BF
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 05:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C81DF73A;
	Sun,  5 Oct 2025 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCWjjr87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75A28E9
	for <netdev@vger.kernel.org>; Sun,  5 Oct 2025 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759641770; cv=none; b=UnpUFkaZtkbDbz9q6CaDBRt1IBAy91eBG40GUizMaFGAPaSxjYHJcG5JjtdoRAAhX5XLSTs8Xw8Puin9Gv2PvQrKlVyqhFbo2x6TZr7Jjuxr+qKGZpxRkP2kHS/AJgy/FDjq9BynvWwm1bA7VTWtrDd3Ho5Gbs+kAvQUZOQ4Vkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759641770; c=relaxed/simple;
	bh=dqOi+MY78NsDOxDex+3RbETGEFiqYs1aaeXItxShAr8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ffJJPGm9pu/KcCbB6k7ip+C/Lsoev8Ktb3EIDLyjUrlwKpB4VZEx/ZLdsHTIRS/zxSiU2fz9KlxhsDMhPdNSyZVYDp5TdoqzRSjTOL9U/83IacTRKNjnwN3/kSKZoOjQvPjBnviiUfXOztqOEA48OEH++8QeoCdksqo9n3EdQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCWjjr87; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d53f4960so632644a91.3
        for <netdev@vger.kernel.org>; Sat, 04 Oct 2025 22:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759641767; x=1760246567; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl4f3lUngLx4Rr2JAATJH0JKZYoNdISvwmWY0T8sTHM=;
        b=RCWjjr87Rd2vecWCLnN6OxdPX0L0CntqhpnvNF8n/L6XNeqr6PerncDQbc36owty6Y
         5Osm00lgc5ASi4057sq5KWPpKYQPNdNPb31RnsoCevJT2M/Dy97CMkYJmngJUMoZtWjH
         xuZHdMc2NGxiAPznXuhH2rvWPlrJrIWsBJFAi8KOyKnjFLCmV/ax7wgcc3Y6lNrQo7eO
         O5fTRm3AII7Nzcn/7MoK2aMqjHVSrBgAgT6Kg6nyoppGhvrSUc3qNBArCFKJbWBxMGwk
         AvUwGEKPHO7pwsKN58gTLin2qX/eq6NnGKv8Z0qUEnpN9RPY1U9d+mLTxk1e+hbQcgpz
         46vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759641767; x=1760246567;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bl4f3lUngLx4Rr2JAATJH0JKZYoNdISvwmWY0T8sTHM=;
        b=uzVLKutR0JJ7XLaUk4y5ycIXxDGCB1K/7rHpNBQyvBZEN8c4ZudEtd58v06CIJuE6N
         +8sWpBvZ+hdAzoMgioYubCrDSGApJDuRE8hmRLesc1fSUuT8yONnbpe1Rf1DJIaMRNG5
         l466kVHfxvuD8dcieI2ecr5sv61nz46dKb+sMzmy9Q5TS3XPq842RwCZOViFpAgbSf8c
         vXx/SPyij7X1AynM7LBB1EgpBeWrOy1DCe12W806DJRN81RocEhXQLQueVvaU1y+EPTs
         TZz7+OHoO/dJIG0dgBAHZr6WhERvy5+z8sgjYEmsyD0aXca9vI7ZCxkBTgHPRlcCgagL
         b6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4GmxGPmOh7N5Wci2H6ZAGERdycPH+uilIU400frNlEb6uOpTBMeZXX6SwLCd9vkQ/vuXUaHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5BgSQ8+/qLNW6p4M12DzHfUEohTbfRldsJe2vQyuxMIJ0meZ
	UcQYXaBdaAgEdd+6qC2OalzYPdIiiY7bjNVRhwZFBtNeSh2JsLdeSNwj
X-Gm-Gg: ASbGnctZebh+IJuTRULhkDXQUbDTPMWY27U+9G1jZGCx5JoRhyveaVgEj/G9F1QBgln
	+j7MG2MqE7I38fbR6rW7+sxJP5VzK3nJu5ND1A59W0kSK2Bm8weRXJGSz5OhSwqh1XZW3TK7f3f
	pqAAnYFbNP3gRcdp3poL5ZbSkFMZbNyTIJAOUkbSioHY58yOF7GNLBE5d2Kiz0UtlPMLJBRVznU
	ulqTwcXkKQQrHgOsfRdYwwNnmcQu0Tqwje2CdG1mjF8VjmqXGRIudXf/p3eaxJSRqZENh4Jbz8j
	cvAl+k/hLbMJTk8t1Hx3zxHeCZHR0DN/ehegpNlm2yuHpw2xEhS/offBE2Aw0jWnstSffSaABJe
	7GvgH4tAZrIOELNo2v2QZa9usXFudtWKgkrh4+oPlAOI=
X-Google-Smtp-Source: AGHT+IFRMPV/2tU3v8ACGpBhtXjHmMDZIjexNHZU5hi30zMXqAgqm8rywJTqpp3BUVdjaLbyzhqfkA==
X-Received: by 2002:a17:90b:1642:b0:338:3789:6c60 with SMTP id 98e67ed59e1d1-339c27b5af3mr9660501a91.36.1759641766902;
        Sat, 04 Oct 2025 22:22:46 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a0d50esm6732991a91.2.2025.10.04.22.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 22:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Oct 2025 14:22:43 +0900
Message-Id: <DDA4Y2GRUHD4.1DFHX01NOJYCB@gmail.com>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: dlink: handle dma_map_single() failure
 properly
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251002152638.1165-1-yyyynoom@gmail.com>
 <20251003094424.GF2878334@horms.kernel.org>
In-Reply-To: <20251003094424.GF2878334@horms.kernel.org>

Hello Simon.

I'm currenly re-writing the code as you suggested. I think `alloc_list()`=
=20
can easily adopt the `goto` pattern, but for others functions, it's not=20
that straightforward.

My question is whether a style combining `goto`, `continue`, and `break`
would be acceptable in this context:

```c
	if (np->cur_rx - np->old_rx >=3D RX_RING_SIZE) {
		printk(KERN_INFO "Try to recover rx ring exhausted...\n");
		/* Re-allocate skbuffs to fill the descriptor ring */
		for (; np->cur_rx - np->old_rx > 0; np->old_rx++) {
			struct sk_buff *skb;
			dma_addr_t addr;
			entry =3D np->old_rx % RX_RING_SIZE;
			/* Dropped packets don't need to re-allocate */
			if (np->rx_skbuff[entry])
				goto fill_entry;

			skb =3D netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
			if (skb =3D=3D NULL)
				goto out_clear_fraginfo;

			addr =3D dma_map_single(&np->pdev->dev, skb->data,
					      np->rx_buf_sz,
					      DMA_FROM_DEVICE);
			if (dma_mapping_error(&np->pdev->dev, addr))
				goto out_kfree_skb;

			np->rx_skbuff[entry] =3D skb;
			np->rx_ring[entry].fraginfo =3D cpu_to_le64(addr);
fill_entry:
			np->rx_ring[entry].fraginfo |=3D
			    cpu_to_le64((u64)np->rx_buf_sz << 48);
			np->rx_ring[entry].status =3D 0;
			continue;

out_kfree_skb:
			dev_kfree_skb_irq(skb);
out_clear_fraginfo:
			np->rx_ring[entry].fraginfo =3D 0;
			printk(KERN_INFO
			       "%s: Still unable to re-allocate Rx skbuff.#%d\n"
			       , dev->name, entry);
			break;
		} /* end for */
	} /* end if */
	spin_unlock_irqrestore (&np->rx_lock, flags);
	np->timer.expires =3D jiffies + next_tick;
	add_timer(&np->timer);
}
```

Or is there any better way to handle errors here?
I'd appreciate your guidance.

