Return-Path: <netdev+bounces-66535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64883F9FB
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 22:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE72A1C21BA9
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB331A6B;
	Sun, 28 Jan 2024 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P9rnnXur"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271723C068
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706475865; cv=none; b=W0b8aOQCZWuTLL/oHETEU8G7IkKNIPp5z5MlDikumzlhAj6YInkxrWLLsXxwAZlDdWxoIWqRzAxoJx4haMIb9XNTPcaK2xvcLDRt+fZAhjq4bXJqGwQlx9YLWFdfPcovgu2REVqdPxg3USwhMBejOx2TZE1prCnrfB9N1KetZeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706475865; c=relaxed/simple;
	bh=SytNKwa5RNJtZHDKkXn9CchjVqVQeN0oLq9ivVraHws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzRh+ghmdW2G1zJU7uJFR+uTdYj8OJ3ME/1oteymUA8ROchpLniUYgS3Rj2oWe8tfnLglRFwXVGSJG/KabtTh0xs6KA2Yfn2jr6QQMwnW0m0qDG6zfwvGXGv10N9CEa9wzjB3cKrSfd9qqiYps3TVcvu2/B9XZ68OLlrpWQhkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=P9rnnXur; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706475864; x=1738011864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=na6gZfeN10yMW36LyhKKyDXsMHb72XFrGUmjasCeobk=;
  b=P9rnnXurL+MImCr022WryqReVKtYCqEyXjZ/uiOer5RRwfJL6pOHtJDJ
   MRHpbUFMFP8Nva5SyrXdw0TOlJ3u+b70/9jNBiYhNnS96nBjiIQhCZwaH
   zS/ChJ9BlEb95naktDrNWtR7MSBBuZyvV3GHb7UA9hbk/Tya/yEoT2Rco
   8=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="634074160"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 21:04:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 543E880632;
	Sun, 28 Jan 2024 21:04:20 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:38338]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.214:2525] with esmtp (Farcaster)
 id acb062cc-cb42-4fb1-a5af-873277111706; Sun, 28 Jan 2024 21:04:19 +0000 (UTC)
X-Farcaster-Flow-ID: acb062cc-cb42-4fb1-a5af-873277111706
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:04:18 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:04:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kent.overstreet@linux.dev>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH v1 net-next 2/2] af_unix: Don't hold client's sk_peer_lock in copy_peercred().
Date: Sun, 28 Jan 2024 13:04:07 -0800
Message-ID: <20240128210407.94429-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240128103732.18185-3-kuniyu@amazon.com>
References: <20240128103732.18185-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Sun, 28 Jan 2024 02:37:32 -0800
> When (AF_UNIX, SOCK_STREAM) socket connect()s to a listening socket,
> the listener's sk_peer_pid/sk_peer_cred are copied to the client in
> copy_peercred().
> 
> Then, two sk_peer_locks are held there; one is client's and another
> is listener's.  However, we need not hold the client's lock.
> 
> The only place where the client's sk_peer_pid/sk_peer_cred are set
> is copy_peercred(), and once they are set, they never change.
> 
> Let's not hold client's sk_peer_lock in copy_peercred().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f07374d31f7c..c5c292393be8 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -706,26 +706,10 @@ static void update_peercred(struct sock *sk)
>  
>  static void copy_peercred(struct sock *sk, struct sock *peersk)
>  {
> -	const struct cred *old_cred;
> -	struct pid *old_pid;
> -
> -	if (sk < peersk) {
> -		spin_lock(&sk->sk_peer_lock);
> -		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
> -	} else {
> -		spin_lock(&peersk->sk_peer_lock);
> -		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);

Somehow I forgot about that the client's sk_peer_pid could be
fetched at the same time by SO_PEERCRED/SO_PEERPIDFD, so the
lock is needed.


> -	}
> -	old_pid = sk->sk_peer_pid;
> -	old_cred = sk->sk_peer_cred;

but old_pid/old_cred are always NULL, so this can be removed.

Also, the locking order can be fixed as

  peer (TCP_LISTEN) -> sk (TCP_ESTABLISHED)

and we can write a lock_cmp_fn for sk_peer_lock.

I'll do so in v2, so

pw-bot: cr


> -	sk->sk_peer_pid  = get_pid(peersk->sk_peer_pid);
> +	spin_lock(&peersk->sk_peer_lock);
> +	sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
>  	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
> -
> -	spin_unlock(&sk->sk_peer_lock);
>  	spin_unlock(&peersk->sk_peer_lock);
> -
> -	put_pid(old_pid);
> -	put_cred(old_cred);
>  }
>  
>  static int unix_listen(struct socket *sock, int backlog)
> -- 
> 2.30.2
> 

