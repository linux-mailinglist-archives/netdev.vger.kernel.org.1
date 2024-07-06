Return-Path: <netdev+bounces-109626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E289293AF
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3882F1C20EF8
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DD757EA;
	Sat,  6 Jul 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw7DzEWC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244F4C79;
	Sat,  6 Jul 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720271217; cv=none; b=Wb5nuu4aSH4AAHCdfO82nX++4vyU5jleYrr+uAx9g+At80slYbuWmMth32E7bVCDxOurB58S8t3cGYpR71/RTECN4e56lrcgFYOh8RCm08ME8SFmcFSi0kiN1ZdIwRAfGJrNGUKj9QLkPnes/Ka6XCOJwv8SZ00BR/IkryMk8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720271217; c=relaxed/simple;
	bh=ITG/Z8kP1Mn7kjCQSGQLhNgA6BBoYTJl6W2jhxfXJjU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GD9ngv3xNWE4dODLLmlQqvP0jUq9CsGc+DZDn3nenOB0gFj8Kt0TObHX0vk08WEVrhZDJkr/8Uc6tFG2F2fdZ2g/F5/6l3zuB/UFpu//VOyvHmYVVDeqa4I7eZDVxCp85fikYWRjtd4jmAONNusyfSUkoeWfYhgU81xOj3MKkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw7DzEWC; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79efb877760so60368185a.3;
        Sat, 06 Jul 2024 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720271214; x=1720876014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSCQj2degSTK+qsPzw81NmlVV+zzbYgqLm9ceOV5bfw=;
        b=Yw7DzEWCsvieUYDZsuAybpw/9muDz8QSnu3oQjq2MfiqN7Izw0+sk/xQRguSStBh9e
         LsOovN2V4onC+5P94sMkDfmr/UYVE/w4exx4IM4alvvqDvp7k+0GLbbrI4sBrmg2nkqr
         diGQuvE79yGSI2ANwQaUSOPrCFDXuVlLWED9KxcWXM+pS4wzJSisIWMzcFC3W1wARWhp
         PPtSV9X3oRT2sSHsAsTtTKFF6GUp8irHPJO79b8MLMQrmQ/AsmQaqGe4Mbeb8H4wpE92
         bcd2KeG2Y9G6jAU4/WfSOHc4kQvs+pUo7WFKg6BQ2aoqTuOahH45ghJwFJunf4BqCH1p
         es9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720271214; x=1720876014;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qSCQj2degSTK+qsPzw81NmlVV+zzbYgqLm9ceOV5bfw=;
        b=c0L9hQLKa6AnNFsWkzT7xzpORoKSlPT0LAfRxUXATNzuLEaRuxrdTlClzjGsE8MI/E
         wsaFFwIDyIIv1Oiqifmc2UTdd2EDDrxKcIS4+ZbJTYPJHTMzUzsItSi0Ly9HfOdHlF9Y
         e9odS82IkHNTjBl03NDS9ha9kqr7nv3KO9Vno35SSq1oeWlELcJB9tSBgYJ4X7DcvU4Q
         8GcgbolzOEdVnC0rlvQZbBv3pXZnVDEYyrfVctP8V0Aom1LmJmBlnMXIhYVRZftFH7Zv
         coPCmcDDn1HcSRhL6gAFe/rk7hQWEoalyblxaaAktGNWz8TdUVDoiR41OiN6o4sD958F
         6tUA==
X-Forwarded-Encrypted: i=1; AJvYcCUPdneqsI9GHRP2m0hCdphHU08mRTS5oGevjWkL/4w7aQyrxNaZhyf9k6vmFZ/Wx3Ju7eoRZR+yC+cSbKALpCVDM45e6HN/eqynqBrd
X-Gm-Message-State: AOJu0Ywkiew7kmIBMOts0SCVLPKhQ0CuaC6zONVZ8CWDQzFZLEhR5o4q
	yVgwpR9GdNpLmrAtpBxYoOfC8dkCvLzJ5Ef2Pkd0Eo55YaSiS66+
X-Google-Smtp-Source: AGHT+IGIy7gqfCWqSXog2cFahn8QlkKDRIFTZEVOoyXeRoinbhclTmAuGAEy3AAyjKl3kxF2rloeZg==
X-Received: by 2002:ad4:4ea9:0:b0:6b5:dc3e:fcb5 with SMTP id 6a1803df08f44-6b5ecf8d18amr80474256d6.2.1720271214348;
        Sat, 06 Jul 2024 06:06:54 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b609925635sm42726d6.33.2024.07.06.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 06:06:53 -0700 (PDT)
Date: Sat, 06 Jul 2024 09:06:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: echken <chengcheng.luo@smartx.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 echken <chengcheng.luo@smartx.com>
Message-ID: <6689416d489e3_12869e29438@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240705032048.110896-1-chengcheng.luo@smartx.com>
References: <20240705032048.110896-1-chengcheng.luo@smartx.com>
Subject: Re: [PATCH] Support for segment offloading on software interfaces for
 packets from virtual machine guests without the SKB_GSO_UDP_L4 flag.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

echken wrote:
> When running virtual machines on a host, and the guest uses a kernel
> version below v6.2 (without commit https://
> github.com/torvalds/linux/commit/860b7f27b8f78564ca5a2f607e0820b2d352a562),

Prefer format commit 860b7f27b8f7 ("linux/virtio_net.h: Support USO
offload in vnet header.")

>  the UDP packets emitted from the guest do not include the SKB_GSO_UDP_L4
> flag in their skb gso_type. Therefore, UDP packets from such guests always
> bypass the __udp_gso_segment during the udp4_ufo_fragment process and go
> directly to software segmentation prematurely.

GSO packets should have either SKB_GSO_UDP_L4 (UDP segmentation) or
SKB_GSO_UDP (UDP fragmentation). Not both. Note that UFO is also long
deprecated and discouraged.

> When the guest sends UDP
> packets significantly larger than the MSS, and there are software
> interfaces in the data path, such as Geneve, this can lead to substantial
> additional performance overhead.
> 
> Signed-off-by: echken <chengcheng.luo@smartx.com>
> ---
>  net/ipv4/udp_offload.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 59448a2dbf2c..6aa5a97d8bde 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -402,6 +402,13 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
>  	if (unlikely(skb->len <= mss))
>  		goto out;
>  
> +	if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
> +		/* Packet is from an untrusted source, reset gso_segs. */
> +		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len - sizeof(*uh),
> +							 mss);
> +		return NULL;
> +	}
> +

So what this really does is bypass software fragmentation in virtual
devices that advertise SKB_GSO_UDP.

That's fine, I suppose. But is not what the commit message currently
says.

>  	/* Do software UFO. Complete and fill in the UDP checksum as
>  	 * HW cannot do checksum of UDP packets sent as multiple
>  	 * IP fragments.
> -- 
> 2.34.1
> 



