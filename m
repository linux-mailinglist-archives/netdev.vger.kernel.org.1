Return-Path: <netdev+bounces-66448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479883F491
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 09:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319B1283D6D
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 08:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62FD50F;
	Sun, 28 Jan 2024 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D43eZIFb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22596D51A
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706429635; cv=none; b=Pu7R7l+sS3HRxpfwPB4iO37c73yzC+HG55G441RTrNuV7vvekTQQ+Qh2xd6tsUGO3ZqBz+0yGY9hsbrSlKgxyzAa9u9cjQk5z9CyxvsDgkizIal86HhbuGsEXdbgSEkOP4wCqydARQxBIWrsT1PiEnbA0tGpnXEhP3tU/aPfq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706429635; c=relaxed/simple;
	bh=oiuezi+p9fcVBCmML8h5GbRPOKxgyvl/5Bi0k5NehEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwlyIhu1OT9gCO5UOHmXb06jYggbKH6kCyenc308MCth0vPcV3Qb0IWjzVwp2mp1vok6827Wkdl9Jvdj2S0wDbRAA8YPwboAC55d8IJowRhlhvEe6fqQYFYqa8TXntC5Im7kFOGR6/cKwel6p4qBH0u6pPFCrAd6FtMh0W3PPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D43eZIFb; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706429634; x=1737965634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uhWaMOp6Cth5WtpkeNlSYWUHuUszKknIZr/Yn36/Ry0=;
  b=D43eZIFb1OGPg2v7e1WEfN1lTCu07zKoa8kS5PE+uZBSCMubEyeToUDe
   KjpCioQotlnsQVimILcgR2LDTrl/5+QoafD/rNeB84MjJKuPuFpesz8m/
   R1k27OhdFZy1m2o+Mn2GO1g6+yzbf3lHaG7jV2fYa6jlPlL16StBUtoi5
   0=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="270007618"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 08:13:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id C7D5080679;
	Sun, 28 Jan 2024 08:13:48 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:35453]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.214:2525] with esmtp (Farcaster)
 id f5618c40-7b02-4b52-b413-3d701d05460a; Sun, 28 Jan 2024 08:13:47 +0000 (UTC)
X-Farcaster-Flow-ID: f5618c40-7b02-4b52-b413-3d701d05460a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 08:13:46 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 08:13:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <ebiggers@google.com>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+32b89eaa102b372ff76d@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] llc: call sock_orphan() at release time
Date: Sun, 28 Jan 2024 00:13:33 -0800
Message-ID: <20240128081333.2392-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240126165532.3396702-1-edumazet@google.com>
References: <20240126165532.3396702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Jan 2024 16:55:32 +0000
> syzbot reported an interesting trace [1] caused by a stale sk->sk_wq
> pointer in a closed llc socket.
> 
> In commit ff7b11aa481f ("net: socket: set sock->sk to NULL after
> calling proto_ops::release()") Eric Biggers hinted that some protocols
> are missing a sock_orphan(), we need to perform a full audit.
> 
> In net-next, I plan to clear sock->sk from sock_orphan() and
> amend Eric patch to add a warning.
[...]
> 
> Fixes: 43815482370c ("net: sock_def_readable() and friends RCU conversion")
> Reported-and-tested-by: syzbot+32b89eaa102b372ff76d@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

The plan sounds good to me, thanks!


> ---
>  net/llc/af_llc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index 20551cfb7da6d8dd098c906477895e26c080fe32..fde1140d899efc7ba02e6bc3998cb857ef30df14 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -226,6 +226,8 @@ static int llc_ui_release(struct socket *sock)
>  	}
>  	netdev_put(llc->dev, &llc->dev_tracker);
>  	sock_put(sk);
> +	sock_orphan(sk);
> +	sock->sk = NULL;
>  	llc_sk_free(sk);
>  out:
>  	return 0;
> -- 
> 2.43.0.429.g432eaa2c6b-goog

