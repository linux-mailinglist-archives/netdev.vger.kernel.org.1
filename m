Return-Path: <netdev+bounces-107616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FC91BB3F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846E91C2083F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2FD14F114;
	Fri, 28 Jun 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIhbSLeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9814F98
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566097; cv=none; b=j+SqhLaIOtUwVleoNRcYjaO9SIFAy+BG8vnst+K/L0iyb7IQgdWf79K6uJ2kcQSB8gqynQUgXpEck3Krm3TTjeT/w0pyQ1G0l9jZDyhjMHwXdVLbo5WINze6mq5sPJbtUl7/6CIvjz543RlLW0ithjsfOluOd2aHqpzwHRyNzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566097; c=relaxed/simple;
	bh=C/2QRqwi6yPC5Kwibxzd52DRl+/5cLtI9gDRNvI30Wc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GADExXlq8q+jzk/dy0ch9ybaYWSAhjNBRPAIHI178cj4wRPtXR3ij+FJz8sko/XgzT/J2rQx+hT0cFEeRwnaW0TSjg/vpCu/sf/Q7miqjySVAtXJuVRAVbWBTh61SaeA3chex18OsyZQ8AC692fTdDemFCEWAHfnkxUqyKTkXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIhbSLeH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b29539d87so2179087b3.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719566094; x=1720170894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eve8hRnvlFIFTLl2HC2yyhEdHM+l18Igp3uvedaWtOM=;
        b=UIhbSLeH1PIZV78zjx9Jd+rF/KvTspuGP1beTVdAhdCfk/LGIjcLGpqR3qERm2BeqI
         ZMM6uJ82oJROrzHUZ1w0aDDOJsgfvJtPuYW2YAuaZwpBXhiiMj6ILUsAsLG88yCODJ/P
         HoRF11XzKXN+jLdvQlBSUluYH1Nd/V9aZ2sqZriWZrO4J5xnbH9xCk0Hon0/xn3vOtzs
         Rqre+WbxC//oVLQlGe5JcLxTys+fEMfuk+6OduL8WKexDaKEvXSiN9OW/QtzWHAkLnDp
         oi7wnbgBSZdjB1N6cVGkyLGy89ugsC6nFvnsMmA9DBJ2dzGsZFeRT3gpCtAzkPTvHRgZ
         LyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719566094; x=1720170894;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eve8hRnvlFIFTLl2HC2yyhEdHM+l18Igp3uvedaWtOM=;
        b=WTXGyriErqQqcd8kHhdiqIMAV6vz53eIbLmDbVaNfABjzMzG1VwF5cgZY2dU+Tq15I
         pXQ7Rk+NsVabqx6nLgh+TNH/Fb3fR3wyyeI4aObDwpc2aKgcLbrv9yjY1QQFUNrlGNpe
         atA3Vg0vO+lUFfqFW5iEVJ01dBYlM+bt0Z68gnZ+OVGC345s2ebt5ZCVZCQgQRwW8+w3
         vmPhw/xR/qV/Sv9qTlp5gPikmcfIWFVHX9imRqklw+hrNpYEqYewa0sJjjUK3y7Ci4wN
         RfPjptu8Ew4SKedFXt+5DA6VDN1wbdjYNRqOmuCcsbMvw/cAPyE0CKOymjAAY6OEtNaX
         NpaA==
X-Forwarded-Encrypted: i=1; AJvYcCV7WLi/xcXJ0lHbgrduAaR6WGm1aB9Flqv37r/7JOBgotczSuDEJR7x8vLzYYad8YlmgFP6KVZC792OGnImlGGTjlYAnj4R
X-Gm-Message-State: AOJu0Ywp0ZQo5Iwsf+BPmg7gmOXmPsgK19ytYu4JR7YluihhYhQRqDh9
	QjBTaiCP9AX7kg2ZCVrWydsC1tSfytcPF5OEXEqznhil/bCcNhh3ldh4E5hc
X-Google-Smtp-Source: AGHT+IHwUSE+ogOwEcMUGFKV0ibow9WPA905RigCDt1XlvuewKIm7/iJs7jEzl8qWVqL4GZllDHRbg==
X-Received: by 2002:a05:690c:f0a:b0:63b:d711:f06d with SMTP id 00721157ae682-643ac81cdfbmr193146467b3.33.1719566094471;
        Fri, 28 Jun 2024 02:14:54 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f5b12sm6243746d6.94.2024.06.28.02.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:14:53 -0700 (PDT)
Date: Fri, 28 Jun 2024 05:14:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
Message-ID: <667e7f0d78f39_2185b294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626-linux-udpgso-v2-1-422dfcbd6b48@cloudflare.com>
References: <20240626-linux-udpgso-v2-0-422dfcbd6b48@cloudflare.com>
 <20240626-linux-udpgso-v2-1-422dfcbd6b48@cloudflare.com>
Subject: Re: [PATCH net-next v2 1/2] udp: Allow GSO transmit from devices with
 no checksum offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> Today sending a UDP GSO packet from a TUN device results in an EIO error:
> 
>   import fcntl, os, struct
>   from socket import *
> 
>   TUNSETIFF = 0x400454CA
>   IFF_TUN = 0x0001
>   IFF_NO_PI = 0x1000
>   UDP_SEGMENT = 103
> 
>   tun_fd = os.open("/dev/net/tun", os.O_RDWR)
>   ifr = struct.pack("16sH", b"tun0", IFF_TUN | IFF_NO_PI)
>   fcntl.ioctl(tun_fd, TUNSETIFF, ifr)
> 
>   os.system("ip addr add 192.0.2.1/24 dev tun0")
>   os.system("ip link set dev tun0 up")
> 
>   s = socket(AF_INET, SOCK_DGRAM)
>   s.setsockopt(SOL_UDP, UDP_SEGMENT, 1200)
>   s.sendto(b"x" * 3000, ("192.0.2.2", 9)) # EIO
> 
> This is due to a check in the udp stack if the egress device offers
> checksum offload. While TUN/TAP devices, by default, don't advertise this
> capability because it requires support from the TUN/TAP reader.
> 
> However, the GSO stack has a software fallback for checksum calculation,
> which we can use. This way we don't force UDP_SEGMENT users to handle the
> EIO error and implement a segmentation fallback.
> 
> Lift the restriction so that UDP_SEGMENT can be used with any egress
> device. We also need to adjust the UDP GSO code to match the GSO stack
> expectation about ip_summed field, as set in commit 8d63bee643f1 ("net:
> avoid skb_warn_bad_offload false positives on UFO"). Otherwise we will hit
> the bad offload check.
> 
> Users should, however, expect a potential performance impact when
> batch-sending packets with UDP_SEGMENT without checksum offload on the
> egress device. In such case the packet payload is read twice: first during
> the sendmsg syscall when copying data from user memory, and then in the GSO
> stack for checksum computation. This double memory read can be less
> efficient than a regular sendmsg where the checksum is calculated during
> the initial data copy from user memory.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

