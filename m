Return-Path: <netdev+bounces-243955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781C2CAB7A6
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 17:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533C53014A02
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3ED272E7C;
	Sun,  7 Dec 2025 16:21:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A2E1D31B9
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765124483; cv=none; b=dBunrQ0PyNRLuPKJFbGXyaU73C042PvJipNPKHQlpnh45OAM7p6z85EHTCQpKgUS1SWZUkkreaWoblt7Gnp2DwaqxYnXjkhC6uQVVWaHnW8os6jyvlRp7iavJSobENAthfKFvcIIbI4NdIvROS081NlS0APDgq4v7JA0o1Ms1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765124483; c=relaxed/simple;
	bh=sqBd7teEmiqcWftfCyDPVX/qYuxigHNRX21NcR+fUHo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=lxrjDmxVumrWEv2Xq++wqcZcYukOem01AlHTObMqmLdgqVMQDCZu7JGRO7Jf3irg/zIdLrLpm9hS9Rls0/qPuH8DWUny05iQ83R3XYX8nXiq15erQOY6OpO6uenOyXY4UpZ2I4TNaLZQtEOpxaHCvCfjUN+Nor3eF8NaCtYP3Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65979a343e5so4684843eaf.1
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 08:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765124481; x=1765729281;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yK8hTqy8PVIXC39GgrO6qaY/nPQFjAa27XyPkw3RyI4=;
        b=hpzrQTOSPGKNi0xOdervSTnebCshk0zcoDgRjWb6As6Iw5SonnGiUYEuIjKucpg1g4
         qzNrBbYsccswGYisL7xbG+erjeKFd8SBg7B4bjezIvTjOz6W1fZZu09MrWpiXO00tFMp
         Y15FqPyAqiljgsdt1mHTUPyqc46xqj/owGtfCm1AyfpEB7fFMXMb05di4KQlbxKvYl8w
         rYC7zOf/tVz421mELui5dgGF2l7IOwBE/PqNLpcBmZbFWiwqHIb0kYAFe5fEnX6cEQ30
         +zZLh8aBH4xL3tUT0mmMbZRFxiuLmrWv9nCkONIwuQjSH1+67FDNcN4OG5q8W87Z83Oy
         8kHA==
X-Gm-Message-State: AOJu0YzJocn7kDjkY8tBXtMXtbz0f7pAvR6fVGjFDvUo3c0j4ThKLK8M
	hFtfkQysuO27ctsQTKyaf10AlEFBf2/fqqYG2gv6iFfndzL79tu/EuevmfpjbUiQkcsL+OVT35c
	a+5mIYNDJr4X6YVqUjef9PxIRiumYK+qT1Q3jCej1mOJhMLL7bHcIEM/aWvw=
X-Google-Smtp-Source: AGHT+IFh9TFBCX0S1kX5TEG56FoAUjZgdDsIWiTZdA0k6Dts2hm119IsO72pnfLL7c7y4oRJxImuBbJhARYhHtIdJjk+xHXHmhI5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1993:b0:659:9a49:8f4e with SMTP id
 006d021491bc7-6599a8e16c5mr2094054eaf.19.1765124481552; Sun, 07 Dec 2025
 08:21:21 -0800 (PST)
Date: Sun, 07 Dec 2025 08:21:21 -0800
In-Reply-To: <20251207162109.113159-1-tayyabfarooq1997@outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6935a981.a70a0220.38f243.0064.GAE@google.com>
Subject: Re: [PATCH] memset skb to zero to avoid uninit value error from KMSAN
From: syzbot <syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com>
To: syedtayyabfarooq08@gmail.com
Cc: netdev@vger.kernel.org, syedtayyabfarooq08@gmail.com, 
	tayyabfarooq1997@outlook.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> Signed-off-by: Syed Tayyab Farooq <tayyabfarooq1997@outlook.com>
> ---
>
> Hi syzbot,
>
> Please test this patch.
>
> #syz test: https://syzkaller.appspot.com/bug?extid=0e665e4b99cb925286a0

This crash does not have a reproducer. I cannot test it.

>
> Thanks,
> Tayyab
>
>
>  net/phonet/af_phonet.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
> index a27efa4faa4e..9279decd680b 100644
> --- a/net/phonet/af_phonet.c
> +++ b/net/phonet/af_phonet.c
> @@ -208,6 +208,8 @@ static int pn_raw_send(const void *data, int len, struct net_device *dev,
>  	if (skb == NULL)
>  		return -ENOMEM;
>  
> +	memset(skb, 0, MAX_PHONET_HEADER + len);
> +
>  	if (phonet_address_lookup(dev_net(dev), pn_addr(dst)) == 0)
>  		skb->pkt_type = PACKET_LOOPBACK;
>  
> -- 
> 2.43.0
>

