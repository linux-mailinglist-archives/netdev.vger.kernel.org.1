Return-Path: <netdev+bounces-211053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D8B16511
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119815A5EFA
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6492DEA7B;
	Wed, 30 Jul 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsA40qPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCFA2DCF74
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894724; cv=none; b=EFB7NBTgxBqNpwTZ8KjDlhBhEasUyWrDkhfUghcnzJUi70acLdIZWjQeW6mYY37VhBOM4gtW6BscQp9uFu6zw5OtE0kljL8FK/YifrlwEUbBzNOo8BLKcsnqVaPexCTQn0TjWezmhhYbByr6Dr27RP4LZ1Ad8BS05+ZkyVxzIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894724; c=relaxed/simple;
	bh=54v3bzbw0nescITxi85iSTM3fxDNBHHqtZdwYKZ0fB0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VPnfTM47bU11tV/Nzjv1l0jPFpw6cFQwwwPYjq2/E2F/UQFsBfGPGVtF4mEkFXxdKKSIIW4Tcv6PJF549n3vNEgMzLhve2RWOKBbg8sxpzBqCB4b2fW4f6ravI+Rmn3ykFrBcvtNcX9W1l1g6Bv1U4ms6w4wE9nGPPnV0CE1qOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsA40qPD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-717b580ff2aso400487b3.0
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753894722; x=1754499522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IWxXiWmVPjESHDim+bjLIHEGiFk0DfaTgae+/iJVmM=;
        b=BsA40qPDuOFac354tcu8UqFZgVPrAahgYEzhNSRP5fYh+v1hcXJqpm5IS2bbM59M2D
         lOEfSBfDjDAGrn1k91y1fDUls+J7wxH8Z0gArFYPaM4AirOtnL/8AS7vtzDBiuJmCapw
         L51j25UmVKdjhkV34pke+J1boCJ1b9HBm/Ok+76qgLDyoXWq2PFUuFBcjaaYpfNM6yZc
         BXHiICFXuvaHVSUZHBWiiwNKyIE/s0ba1qTTkLOiHwakS7WRJGhNzMAQnXAaeroMkthu
         nNNwfjcmgwLYplvzHJpRFgp64C/kk6Ok+l0gE07mUu33qBVJg6ajMpNHhPwf5A5tgCDK
         bCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894722; x=1754499522;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/IWxXiWmVPjESHDim+bjLIHEGiFk0DfaTgae+/iJVmM=;
        b=FgXM63JSuM/jln3yuTo6FDwTYNYAOucMI+e20t/ctrzP3/uTvcO8yGK8DwFesjGycy
         8krlzXO11HmbwuO6qTmH2uuDPc4BrfULgzGIcbYeiuMP+ZwS7XZ1+j4lpTCdUlcfafYv
         YX4A883GB7mL0MVccgsCV0Tm6Y1abzd0SmM602vyymXqv77Bme1064nmh1yCTv2zBjuo
         sTE/mg0NzbBNjVC4XbHUqGxVurVPJnpowxrGEQ6lCDca/0goPOhaDdE0jA4/85LyqaTc
         DMqLf87XMtafgGDQTlyN70lEamezEgBtozjasyIhH9MENjPcN3BGQQvZADkr07wbW5zK
         9h/A==
X-Forwarded-Encrypted: i=1; AJvYcCW6KP6na09bqWAt3DEpr7nUM8kT7cW0NpQL37nj+EBaC7XTU9WNyq9wg8pJ/lAf2RybjEj0Kp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycyTBxJyVWEnek7qNMBtQvVoAri19Z+Uyk6HJu5bJFR0t0tmGN
	olr6U9c4ofaB2xQQWzW5OZpvao2UNtYz26zrTmpw9MFdZ7tswJuFhSsT
X-Gm-Gg: ASbGnctfbtQ8ianD3UAOLOvjtfwjS282lXMdahu00swL1HviXLYsRvFLC5PL5AOJ6Vb
	XnYX66Tl42IFaeliLgbfEGu7vNGdK2lnzwAM8eJbiQY+QJqscHV+zQee6mcbRGCpm7IZb4uZ13H
	DNR304d+dIqsfaho94dnqsTPhIdVh50e1Xhr519o+5Sci7lweYhw5F7ST2+bBUP/jji5sORKwTs
	wM6ibDnYKG3c2bUbVbVClQc+2wD4oaUHiT9Lz+7pfdiC/wGzStJP1xXh237W2yz6p3XhVnKLJEt
	Dsbr2P7cwntjFqCEBnwd3wfnEu9IhCIjc6va2Y8f4gAWw81Aq3cJKDvzpaz0daVOUq0wBPp+ZQG
	3LgAufCA7ru3rJWGmYl2C+tZU6S9Oa4PFtoHuzC/a0iRY4FzMmvDPgjVHN32ilqYag9Utzw==
X-Google-Smtp-Source: AGHT+IG1esaa0jeRYIopiwYvyW8UvJHiwMI3Wms5uLs9CjY4OldOKNvvUVoPC11/K6WavbQA6s6kXw==
X-Received: by 2002:a05:690c:6909:b0:71a:2d5f:49d0 with SMTP id 00721157ae682-71a465215aamr56873757b3.1.1753894722082;
        Wed, 30 Jul 2025 09:58:42 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719f23e89e6sm24779957b3.85.2025.07.30.09.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:58:40 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:58:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com
Message-ID: <688a4f3f7d969_1d29db294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250730131738.3385939-1-edumazet@google.com>
References: <20250730131738.3385939-1-edumazet@google.com>
Subject: Re: [PATCH net] ipv6: reject malicious packets in ipv6_gso_segment()
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
> syzbot was able to craft a packet with very long IPv6 extension headers
> leading to an overflow of skb->transport_header.
> 
> This 16bit field has a limited range.
> 
> Add skb_reset_transport_header_careful() helper and use it
> from ipv6_gso_segment()
> 
> WARNING: CPU: 0 PID: 5871 at ./include/linux/skbuff.h:3032 skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
> WARNING: CPU: 0 PID: 5871 at ./include/linux/skbuff.h:3032 ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
> Modules linked in:
> CPU: 0 UID: 0 PID: 5871 Comm: syz-executor211 Not tainted 6.16.0-rc6-syzkaller-g7abc678e3084 #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
>  RIP: 0010:skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
>  RIP: 0010:ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
> Call Trace:
>  <TASK>
>   skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
>   nsh_gso_segment+0x54a/0xe10 net/nsh/nsh.c:110
>   skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
>   __skb_gso_segment+0x342/0x510 net/core/gso.c:124
>   skb_gso_segment include/net/gso.h:83 [inline]
>   validate_xmit_skb+0x857/0x11b0 net/core/dev.c:3950
>   validate_xmit_skb_list+0x84/0x120 net/core/dev.c:4000
>   sch_direct_xmit+0xd3/0x4b0 net/sched/sch_generic.c:329
>   __dev_xmit_skb net/core/dev.c:4102 [inline]
>   __dev_queue_xmit+0x17b6/0x3a70 net/core/dev.c:4679
> 
> Fixes: d1da932ed4ec ("ipv6: Separate ipv6 offload support")
> Reported-by: syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/688a1a05.050a0220.5d226.0008.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

