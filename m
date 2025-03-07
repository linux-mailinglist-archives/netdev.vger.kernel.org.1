Return-Path: <netdev+bounces-172988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B501A56BE0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB35618915FF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3021CC49;
	Fri,  7 Mar 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5F52ShM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64972AD02
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361025; cv=none; b=PKWIt/VXGgodUk+0zLTzTsLrB4ok1HevwZ2xFZP43wLhUj2991FabCoZqbTSsiY14vwWNEVRPqPMSLqhT4xu5flfYtXUBqmfPT0TDUOh8zRQbnIVBF+y0E3D8aZyTeJFZ52EYu+qhiJk34MD4x2VApYd7rsTMliLkm5LZohaDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361025; c=relaxed/simple;
	bh=tN/AuGb/QnhlDHS2niFT91h1BxsKCv+HE6EkDBgoMs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh/O2gZn0ZhpQJ1rPBL7PHbfO9oG/PTXtd8IvbHMZ4zkpIdzpcRc4pMEKJoyd+OlP9aYIVa5rsmb4EKTS1V1kunMOtDHgqQnAOPMZKjZ9aW7bCM2gRrRcZ9O92kl1jKO5sdyRfAuQYtlmGjfNvKpFa//fE9U05OsyiLLTfOg4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5F52ShM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so3827643a91.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 07:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741361023; x=1741965823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oaFJPf8Pc6fRJlXR31/LN+nhSuAi3ftvBGQfhyi6CWQ=;
        b=D5F52ShMfLK6QeM03W3/CUlDo+qP9CSb8/9dsl17Ldpnc2XckXyEMznPDkRInIjGNY
         29ucTVvM2S8b1KtQBNGubpY+U65L3NfvTFW5NjyvDYn2fSWoWL1sdphY+GCVH1DSSnY2
         B14ZIN1CxZf/U6660QP/abEKvhthId96L/utApW6U9s2ZuUBDDvoA5TlFaokEtlHM7i1
         I9DHDImR96QQiQGAeAdLaPeqr7NBWREa/ZhuVLRQTJMVuSQ+4L6yB6itTsfdQ17oBE1O
         h8WygnHramJNKwI07cB63L0r3cqBLbrFPT55rsyXrqO1Mze4OVi3DFUMv9pgu1xgPGZ3
         s+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361023; x=1741965823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaFJPf8Pc6fRJlXR31/LN+nhSuAi3ftvBGQfhyi6CWQ=;
        b=kA712zI1FMb2xJ333w7tYmPGD475Qe6kEDEFsacTrN7qU9KSB1Gw00vRn2/fBhnWhy
         fFfg21yQNboRlwpwSZ11LsK1YPnlTo/djHPpONeaY2axTlw2DkEr3ckDBvhCoeGE9NvH
         f+2e34emdFODZUSk4/N6DzsDXRtWvkdwDGOsj3Xfi2Rqd/ckSHis2emiMpK+w9Rqpxys
         9/0wN7sZc/Y/NR4HxqMCFWZR3ZvhQNn7yM189kUCxOUfzoUAKI1q4rWl6CuiFkTdbnmD
         PJeZXQq4BWR8DX2LU1JFuktdp5aXp6ebbqAFuZW6r0JrXWR3Y0iR/6CerRqN0TjQEWeJ
         Vgxw==
X-Forwarded-Encrypted: i=1; AJvYcCUTTL5kwzqK/AgOw6Uwa2/j93ERbIFsz6fWGtlyQ7+3DK1+0cv3GnX3/uYAr4e76ffZXOGqJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3euiKw8DvCT1qWGM/3WIej3zD11UYMPFfilJVY/Pd4aAlwg2
	kw7FR1urfF6RvzqtG2B9j9zKdRqTUkLobhrKx6qxODMsJezxHIvzHh4l
X-Gm-Gg: ASbGncvrfVkZ1Xb37t3bGuX/D1GThJokpsDJi40ggZiClj3rpNnU2872fUKaEYCs25H
	N1hqrnf49G6EHhlcmLJdj9D2j+pnSxWlTAkIOJWcarNZDhKEjpWFyUkretjSf+DYbpA6zTgEENL
	FvxS8sUC/a7AiSssI/+IMAJnoJiy29zINj17g7vwmmRBzw+J5dNOXHUFmOhYqVOxs4P+VSuvX3P
	KyVEQYR2nge6KfjmSPUWStYpZJ8+puNxWZISIjqPISsvFpEmdjmF2zdzbsrl4bWJR5ZnP1xGRf8
	SCiOryf15m6cCWzIw/LJvsyZhcTYejCAnIx7rRS8SGto
X-Google-Smtp-Source: AGHT+IHkaYdH+XxHoA3WII4P39Lp26xYB5mM6DFATu8jdyaY/gGP59Y8uxaw4EE7XA+QXCmwupDPvQ==
X-Received: by 2002:a17:90a:d605:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2ff7cd31b16mr7289602a91.0.1741361022745;
        Fri, 07 Mar 2025 07:23:42 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e7ff94fsm5015814a91.36.2025.03.07.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:23:42 -0800 (PST)
Date: Fri, 7 Mar 2025 07:23:41 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] net: ethtool: use correct device pointer in
 ethnl_default_dump_one()
Message-ID: <Z8sPfRBBLWRGkyBH@mini-arch>
References: <20250307083544.1659135-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307083544.1659135-1-edumazet@google.com>

On 03/07, Eric Dumazet wrote:
> ethnl_default_dump_one() operates on the device provided in its @dev
> parameter, not from ctx->req_info->dev.
> 
> syzbot reported:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
>  RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
>  RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
>  RIP: 0010:ethnl_default_dump_one net/ethtool/netlink.c:557 [inline]
>  RIP: 0010:ethnl_default_dumpit+0x447/0xd40 net/ethtool/netlink.c:593
> Call Trace:
>  <TASK>
>   genl_dumpit+0x10d/0x1b0 net/netlink/genetlink.c:1027
>   netlink_dump+0x64d/0xe10 net/netlink/af_netlink.c:2309
>   __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2424
>   genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
>   genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
>   genl_rcv_msg+0x894/0xec0 net/netlink/genetlink.c:1210
>   netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>   netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>   sock_sendmsg_nosec net/socket.c:709 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:724
>   ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>   ___sys_sendmsg net/socket.c:2618 [inline]
>   __sys_sendmsg+0x269/0x350 net/socket.c:2650
> 
> Fixes: 2bcf4772e45a ("net: ethtool: try to protect all callback with netdev instance lock")
> Reported-by: syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/67caaf5e.050a0220.15b4b9.007a.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

