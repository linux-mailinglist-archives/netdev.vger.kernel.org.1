Return-Path: <netdev+bounces-165570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEC2A3293E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6732C164232
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5720E315;
	Wed, 12 Feb 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OBa0Ebqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B35271800
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372188; cv=none; b=Lo3X9BsZJQdI5RUWRI1yckIlMgXom+YbUVhvlLZrOGdNm6C3eG/gLG8uE74w56jhPOn3XoiDTDmY0ZikI0aLq2/rVj5ZnfYKuFnmFU/IiQJb/MbsNI6VBLv+qnlO+cat3UE380m+7AwaxHpeKU4jOhKKKYeONP0Ik/3hvhdRxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372188; c=relaxed/simple;
	bh=pBtP3PJBv+uE0HC+VHOSpbjcEj46158hZzOsdpipnic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbdF7YQ4knt3bm5VFlxZfHHp8MxTp9FFWJMzZ0+1z3D6Aq3HyOZkB8U+1WC0Fb6oHenKce053+8aP0+ghXudug2a7WST2bW2qobhwMDaium5U9yTDffkM1MZZsyXQnPfZl1zf64Znam6+8pfXFHewMZxP99mN173WManvBQgzuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OBa0Ebqg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4395b367329so4787505e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739372183; x=1739976983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnkN/P6LmoKmDkuFZdBdA+dTrCAiBXYMp/w0C6GDJVw=;
        b=OBa0EbqgYzWziU7cqQki6e51HOHyAKaPoIQu+M7BOHwNTheqijL9HDq8JjrhCFYZDy
         cXe6AD2/WHTH3kJvT8NNGE1chmNU1G2wN3v5WG3Ub/Es/cmg/nFJuNtERMjGQiZOKzVg
         yPKwPfnbTLF7DwGVZtA+lFUiVTZRu4BzDzXWp+QJldiXnxRVTFM1NKnDqZNDfU7r+Gu3
         FT8C4Ti0TXDu3gp/ax9IK4kfKMU7XnS+8e9bH1ZjLDhyVXBkZ7Zu1Vb78bUVyq7dwGDf
         ufK4PGBmhciQaIs00R8y2D2pd8ykSaEcyI2cK6sTx3l0U+0BxPFF1foAZxpOBQhgASgf
         6YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372183; x=1739976983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnkN/P6LmoKmDkuFZdBdA+dTrCAiBXYMp/w0C6GDJVw=;
        b=f5NWdHnfFnP2PkMvC7RGUMEDaOKQs0BiBPbvc4DlChifnHYz+F+TJDILpCjbtfOFdl
         T0x1XDagYg8q5N62vS3NXFqC1eVWB/5/BLM5rud1CSvdEbYCw8xlABUde2r7ASsfZLhg
         MeB94fsoFi3j59vUGieys0KFP3sAOSmbUhBTfa6948Rj1dFh5ltpSCh4tq6fGroddHz0
         C0A0XeJTYK/Zx7JumrNnCVfM0bv5dWmvHy5Xd5v+6OpeAH9qG5d2jsYq3VF9JdDk+9be
         tbxHYzvKc1+0DpY+rSQca16X4QTbNEWswMNVDVg8WMvgcg2l0J+nPtMWxp8HUwIW4Ct+
         qdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5oy75OyDYGGsMrO8/SLBeOhmUJTB3dt0i3GpYouow7iuIJ1A9HI7BD0gsoODoJwo6gjB41ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHg1PliM0paLaOQNv1IOuY4rIGT2FP07yReKlpPik+wonalxL+
	JQN8AR1Q+Gjq8m8A1FqCl9/Aebvy5XQS79rSFbNYlGD6j/TyKmQsrRmLxky+s2I=
X-Gm-Gg: ASbGnctc3uRIjEE7MZ9EzRzd0kaDj5M/uyu5z7FLoE5Pf5bzBf6X6hfcE5zM2v+rjki
	KSr7WyGeub8yOpqF0Y/jPHRfBWGxIMgKRytS/6bfHwyzqkHtJnmyfMPgFC0bWLDbzP5FPitaFfI
	H4M8Uv0Dxkhm/7lAYckkuffSAk9Nq7RyzTMji8nn+9bS2EpMsRowBiNiUz8cYdP0Qr6ptu7kHyX
	npuX0zRi1OtINCDEQCKaj8VT4uHyqtl3F/Jek3L+1N8c4B2Awjia1M0FTbWuw5JnMAKntcF0Bjy
	FHILGP8DiGxR0vazQsdEwtR6BQ==
X-Google-Smtp-Source: AGHT+IHe7Bo5PbIdGAWvXTGDpMk4ABsCsnSVfpdjdrs2w0um+3vtpKiqI9121oGeg4bMDTt7hVvbDA==
X-Received: by 2002:a5d:5984:0:b0:38f:230d:4c7b with SMTP id ffacd0b85a97d-38f230d4e79mr232530f8f.20.1739372182932;
        Wed, 12 Feb 2025 06:56:22 -0800 (PST)
Received: from jiri-mlt ([194.212.255.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f21ea3246sm764332f8f.81.2025.02.12.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:56:22 -0800 (PST)
Date: Wed, 12 Feb 2025 15:56:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] team: better TEAM_OPTION_TYPE_STRING validation
Message-ID: <in5ewbficpnwteyrybofv7hddflejivs4pveg6jppconfxiv5e@yiufg57uk3mb>
References: <20250212134928.1541609-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212134928.1541609-1-edumazet@google.com>

Wed, Feb 12, 2025 at 02:49:28PM +0100, edumazet@google.com wrote:
>syzbot reported following splat [1]
>
>Make sure user-provided data contains one nul byte.
>
>[1]
> BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:633 [inline]
> BUG: KMSAN: uninit-value in string+0x3ec/0x5f0 lib/vsprintf.c:714
>  string_nocheck lib/vsprintf.c:633 [inline]
>  string+0x3ec/0x5f0 lib/vsprintf.c:714
>  vsnprintf+0xa5d/0x1960 lib/vsprintf.c:2843
>  __request_module+0x252/0x9f0 kernel/module/kmod.c:149
>  team_mode_get drivers/net/team/team_core.c:480 [inline]
>  team_change_mode drivers/net/team/team_core.c:607 [inline]
>  team_mode_option_set+0x437/0x970 drivers/net/team/team_core.c:1401
>  team_option_set drivers/net/team/team_core.c:375 [inline]
>  team_nl_options_set_doit+0x1339/0x1f90 drivers/net/team/team_core.c:2662
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2543
>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1892
>  sock_sendmsg_nosec net/socket.c:718 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:733
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
>  __sys_sendmsg net/socket.c:2659 [inline]
>  __do_sys_sendmsg net/socket.c:2664 [inline]
>  __se_sys_sendmsg net/socket.c:2662 [inline]
>  __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
>  x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
>Reported-by: syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1fcd957a82e3a1baa94d
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

