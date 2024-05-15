Return-Path: <netdev+bounces-96629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2A8C6BB1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27512812E7
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E6D158858;
	Wed, 15 May 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uB9QVarF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214013EFE5
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795137; cv=none; b=UKrDeCVKYghH/zSpcx53eIcX6lDFJBbjLhoP6YRS1K8AlMRAT3ym2dRvG2gLM0lGerUPj8E/HO90NSF2eZMPeXhGtWRWKcMyUvR0/GUJ+QJKu4yE/0IdFthSzNh70fKsQZfn4F/MJrFb2HiokZwYn6uhrUqukH4Oz+UgFej8IkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795137; c=relaxed/simple;
	bh=4/Ooyl624TPv9kwXfjH+lDC71HS+OXDH+JgzPAYD2uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSJJKQ3URqojPkph7HPhbNzJX56+igxKUBRTjKAQ6JtA0/tNCZNzK2Im3fKyQIrI3k3/rGP3SfNFhU6Pi+ygAMFrfAG8T/Rpb98pENq/UViz22aAMK74UPwnW5lTckK/w/xj7IPGtQ9Hp3eupsVPHyDLOKfyLrHfNVrwDCqOSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uB9QVarF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f5053dc057so3634084b3a.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715795135; x=1716399935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Inmc+syrxkqK6aZQdAoIkvH5UOxtf+2Na/UaXVJLBFc=;
        b=uB9QVarF9WLvj0e5WVOHnuGsT4TqCGGo5RmhUtWjXCWY1BVR6n5kkyJtwBRMnzM/MF
         euunpYdjb1LA8eKBRVoFGytmRrXrX+i4tuDnPjUpxWqjm7TJY0BJfkxgBup+o6ZaflPZ
         g7s21VvIlP93kTaDb4Fm6TQfmc5Y83UgJYI1UypSjOoq6lfKQoT9ksZmoZxfPdjH4qDO
         OEaGdB71kyFqAPqPLmJKfV4BerByzLwgroow7UFyh08y2/UcN+bGHIxYpeat9sNnEXqc
         dWqqPu4tOJ7OZaXC2hM5ttAgH3rCG1CFzuSHmLr8N5kT+3ITVRy17V77i5EPKBv3jkdv
         JJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795135; x=1716399935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inmc+syrxkqK6aZQdAoIkvH5UOxtf+2Na/UaXVJLBFc=;
        b=BWEzyrMb1gCMgAc7hHc/VhdFGCyw8dVrIIM5N+QJwzDQ0HyMotMr7nc1blDNKXOrqG
         OFkktZqtFoJpMYdJSbZo+F13OWc0kbLa5fKBJXkPqJT7LSqEbR/hfoszkejSd9J7jPpz
         4OWDQrGeRZILy+n1Fl5mS7mSt+JUJJyB33zV/GgzHiKyubufpftJB8xPMGmhnL2V9Dfx
         Ni2UAzqY5NjF9yQWDYg8TC9Jpp3YJtlKDW0pvs7YCJLKIAQNEQUp23AE2KlBONeGx1QP
         28BKejVVvvf2KkknWWX8O2ArSinOfypdP3XXET7je5KOtwu/1DJzv1BN+5I1iHLozKGh
         fXCw==
X-Forwarded-Encrypted: i=1; AJvYcCX6lNHlITWWhPuhCw+uTY7k08AFJPOUr+3q+YBPS3xdlkuN5PA+EDo3smPC3jFshTH6zpABPWWOum+fZzVvwPmxOFireDMK
X-Gm-Message-State: AOJu0YySbf4vPI8sZcz/lfnTQIVR+PZKpFboolJY1kPkgS59vGMHzQXs
	DIGAAGYRmVThhL03ADa6tYe5bOI8qz1Pa/31x6Pc5CrE2qDlsOEsZ10QLooVww==
X-Google-Smtp-Source: AGHT+IHqT+V07QT8d8OIJOetBXVRP2MvqJqTkiAGp4q63p16McqvNFOMMSJe88kfRvnGTsQMprg35Q==
X-Received: by 2002:a05:6a00:270f:b0:6f6:7b6c:51f6 with SMTP id d2e1a72fcca58-6f67b6c5295mr995107b3a.24.1715795135090;
        Wed, 15 May 2024 10:45:35 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a828e2sm11379011b3a.72.2024.05.15.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:45:34 -0700 (PDT)
Date: Wed, 15 May 2024 17:45:31 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Simon Horman <horms@kernel.org>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15 2/2] netlink: annotate data-races around sk->sk_err
Message-ID: <ZkT0u3RMc89Fe6PV@google.com>
References: <20240515073644.32503-1-yenchia.chen@mediatek.com>
 <20240515073644.32503-3-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515073644.32503-3-yenchia.chen@mediatek.com>

On Wed, May 15, 2024 at 03:36:38PM +0800, Yenchia Chen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> syzbot caught another data-race in netlink when
> setting sk->sk_err.
> 
> Annotate all of them for good measure.
> 
> BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg
> 
> write to 0xffff8881613bb220 of 4 bytes by task 28147 on cpu 0:
> netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
> sock_recvmsg_nosec net/socket.c:1027 [inline]
> sock_recvmsg net/socket.c:1049 [inline]
> __sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
> __do_sys_recvfrom net/socket.c:2247 [inline]
> __se_sys_recvfrom net/socket.c:2243 [inline]
> __x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> write to 0xffff8881613bb220 of 4 bytes by task 28146 on cpu 1:
> netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
> sock_recvmsg_nosec net/socket.c:1027 [inline]
> sock_recvmsg net/socket.c:1049 [inline]
> __sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
> __do_sys_recvfrom net/socket.c:2247 [inline]
> __se_sys_recvfrom net/socket.c:2243 [inline]
> __x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x00000000 -> 0x00000016
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 28146 Comm: syz-executor.0 Not tainted 6.6.0-rc3-syzkaller-00055-g9ed22ae6be81 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/r/20231003183455.3410550-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: yenchia.chen <yenchia.chen@mediatek.com>
> ---

The conflict resolution looks good to me, thanks!

Reviewed-by: Carlos Llamas <cmllamas@google.com>

