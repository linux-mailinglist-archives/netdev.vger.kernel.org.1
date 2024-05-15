Return-Path: <netdev+bounces-96628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4CA8C6BAE
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9BB2814FD
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53685158858;
	Wed, 15 May 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRYladam"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E615884F
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795093; cv=none; b=T1HDTayzcm9Hqw/Cv4NXlpyvYcjoMeESPd6dRqLol2+1hV2dDR+WgfYEIVkVruVel9I5SMFx0Z/2ElreN8QYNZ4Q/LOn4WBe4h1QZu8TxBhzcShmtuI7zgNHkakTtNlYJBykdDOcXGAb9qiJSKS02kwVJTxKuDQVU0Eie67b7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795093; c=relaxed/simple;
	bh=HhT/UyiZ6inv0hfiadFIS4TuJteMpuQm5FvZwCiVsig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzdLSk3M0JTLIeaqqupC94HAThwKClXdiTGlsEETXPT4fmRqE67U010qmJgbUsQOZdlGXDIzdVkntvejFy91t4+nRjZq4/kiTNmYpwHkG58okavfbkL0rH6wPXivBWEmakK2MI7HnFnm2kVSaAm5fCOYoKqXSRCA00KEc5JqEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRYladam; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2dec569e3so1556611eaf.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715795090; x=1716399890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHE7vKazSCPusjGW9s/KeLr4sCT6I3eVwP0aPWhjdjY=;
        b=KRYladamJu7j47GlAiphAWAsLDyndxPilyLBKv9fEwne0BLcbIviQbRPGyqzgH9ix5
         KGeFfo3DN2j9XSHXu7sY/ocoUBFcHKfcGEZxG1/AyYMd3YrHZ/5xJ3XJtVzXEivITT1g
         oWN9Za3jRCNjSzdbIVfTaJVTv0FmrsvalNZ7F7ADj6PRnzRrAQXT2fP192o/yNA4NGUS
         OqtzAigNFQe33EAOS2NlsPLQXVFKGbH9FSJJfRzgjNCzuWrMKe0Zjh6NCw9inCYNsVl5
         K8ZmDZXtFsXSwn4Wti5MATSfIM6qLmoQDepPPtY4eQzX5mKtpUwXcDiePJHBl4mU/15Q
         INMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795090; x=1716399890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHE7vKazSCPusjGW9s/KeLr4sCT6I3eVwP0aPWhjdjY=;
        b=vC3wZW+UAPtP+RX3di80PGGWjFqycbV+jpx/u7vnrMHl2t54uecPqKJVQcNQGQ5PSu
         DOBqYuC1Ri3wzHTV4XwjEopbl6JIyEVfn0Cix+5q9ah8LMpzewesPR0iDGVjRjYiWu/y
         1sBtET6Nn6d1fj9cH8+k/eLY2F/gJcNIdtMw9AxI1SCMIqDu6qeZpr8qLeU7/nlZ/Syt
         gnM2mMNH8rnksfKYkcJNqqnQazUGzTLw1YX2dNnTmk5R4YEv12MLBFfXGGXCpayVmGAP
         FadaNnsJGV6GW5H/snaQu3MRcrCG4+7/zRLKQKH5djg+x6zVJRYOGZQdXAaRbTB3DV2a
         YRvA==
X-Forwarded-Encrypted: i=1; AJvYcCXpgIV+FjsS2EhywNMqiomCImBnkaneiKQr4+o/fmrkF70UaXWBosuYKknsH13swMJ5mIUU6OaVLmQrpsfuhTdDnsZTE5VJ
X-Gm-Message-State: AOJu0YxssGdN2LpLEFATY2gZt4t2il63QnmIk3/gABccr7btu97Z/rwr
	6YUWoyAI1i8uEl3hvrBfcBOL5UaaG4i0dZdfwflP0CZEucRE6+ETpWypPUlQiw==
X-Google-Smtp-Source: AGHT+IF16vw5ldq2DEQeMTmXB3e2sX+wSSbbVPVrx/3sJzxb2YomXPDc5Mwow7eXWfCtuMlI4cEQLg==
X-Received: by 2002:a05:6871:a00f:b0:240:eab9:1635 with SMTP id 586e51a60fabf-24172a904bcmr18531712fac.21.1715795088326;
        Wed, 15 May 2024 10:44:48 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade2c9sm11332969b3a.125.2024.05.15.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:44:47 -0700 (PDT)
Date: Wed, 15 May 2024 17:44:44 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Simon Horman <horms@kernel.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Pedro Tammela <pctammela@mojatatu.com>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15 1/2] netlink: annotate lockless accesses to
 nlk->max_recvmsg_len
Message-ID: <ZkT0jFN-XWKf4jQK@google.com>
References: <20240515073644.32503-1-yenchia.chen@mediatek.com>
 <20240515073644.32503-2-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515073644.32503-2-yenchia.chen@mediatek.com>

On Wed, May 15, 2024 at 03:36:37PM +0800, Yenchia Chen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> syzbot reported a data-race in data-race in netlink_recvmsg() [1]
> 
> Indeed, netlink_recvmsg() can be run concurrently,
> and netlink_dump() also needs protection.
> 
> [1]
> BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg
> 
> read to 0xffff888141840b38 of 8 bytes by task 23057 on cpu 0:
> netlink_recvmsg+0xea/0x730 net/netlink/af_netlink.c:1988
> sock_recvmsg_nosec net/socket.c:1017 [inline]
> sock_recvmsg net/socket.c:1038 [inline]
> __sys_recvfrom+0x1ee/0x2e0 net/socket.c:2194
> __do_sys_recvfrom net/socket.c:2212 [inline]
> __se_sys_recvfrom net/socket.c:2208 [inline]
> __x64_sys_recvfrom+0x78/0x90 net/socket.c:2208
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> write to 0xffff888141840b38 of 8 bytes by task 23037 on cpu 1:
> netlink_recvmsg+0x114/0x730 net/netlink/af_netlink.c:1989
> sock_recvmsg_nosec net/socket.c:1017 [inline]
> sock_recvmsg net/socket.c:1038 [inline]
> ____sys_recvmsg+0x156/0x310 net/socket.c:2720
> ___sys_recvmsg net/socket.c:2762 [inline]
> do_recvmmsg+0x2e5/0x710 net/socket.c:2856
> __sys_recvmmsg net/socket.c:2935 [inline]
> __do_sys_recvmmsg net/socket.c:2958 [inline]
> __se_sys_recvmmsg net/socket.c:2951 [inline]
> __x64_sys_recvmmsg+0xe2/0x160 net/socket.c:2951
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x0000000000000000 -> 0x0000000000001000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 23037 Comm: syz-executor.2 Not tainted 6.3.0-rc4-syzkaller-00195-g5a57b48fdfcb #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> 
> Fixes: 9063e21fb026 ("netlink: autosize skb lengthes")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Link: https://lore.kernel.org/r/20230403214643.768555-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: yenchia.chen <yenchia.chen@mediatek.com>
> ---

The conflict resolution looks good to me, thanks!

Reviewed-by: Carlos Llamas <cmllamas@google.com>

