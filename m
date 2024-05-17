Return-Path: <netdev+bounces-96828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BE8C7FA5
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 03:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162731C2141C
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 01:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1FE10FF;
	Fri, 17 May 2024 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V5aPeKru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82EA32
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715910353; cv=none; b=AlxDgE3NnbcB9d/+CZqxZ8HIN8G5LupOieHCHd5ZApPjVhEYRe8DUhnL/4RVh5P89QgjpQgQsZQJOsP0wxxJrHjpnsnKapz4u4sGzZ4MR2uMl06nGSsQc9skWQlLIixAUS3VppugIjhB5jBoejfesIcNC8vSilYCpNzB4IlyU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715910353; c=relaxed/simple;
	bh=4/KMWK+ZGuhRuaDYKF9IxeyIEcAysuwl8Pfmi9WhQAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9UnFTyc0XEEshKnuNvfCFbV6vh+qaAWAYF0b805x+4+JMDBWF7vD+n+T42Kk5NUezs4+mHsnKXFbpVE8oIuprHASSwgzIRVynet2M3OicClQPRd8cL/llhfWYS1OdDfiiGhmyDUv2M8hOQSjqgJxFf1ox9PVFDsEpNnTJuAmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V5aPeKru; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715910351; x=1747446351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bbSmciwIH6LocXInzwGIDbMIeeVQSjjLxtsNOiGvTV8=;
  b=V5aPeKruBmHi+MVCqpkwRbIZzeNcucDaVWmw0lsV3uLSWQklVtZgE4Pn
   Lq6TKKkC/+B2nPwTpxfI5SKCfZ7JREUfHQkAKKYTDIge4Yqn3menvc/jx
   xnwVFdgqK8oEfgBr+7QkJWQ2FT2RZtZU+qkjcS7IOqYYuywPIerH5EfIC
   M=;
X-IronPort-AV: E=Sophos;i="6.08,166,1712620800"; 
   d="scan'208";a="726973331"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 01:45:45 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:47460]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.185:2525] with esmtp (Farcaster)
 id d7edd87c-7d5e-4ef1-8c63-9bab82d5eb6f; Fri, 17 May 2024 01:45:44 +0000 (UTC)
X-Farcaster-Flow-ID: d7edd87c-7d5e-4ef1-8c63-9bab82d5eb6f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 01:45:42 +0000
Received: from 88665a182662.ant.amazon.com (10.118.251.223) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 01:45:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>
Subject: Re: [PATCH net v2 1/2] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Fri, 17 May 2024 10:45:29 +0900
Message-ID: <20240517014529.94140-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240516145457.1206847-2-mhal@rbox.co>
References: <20240516145457.1206847-2-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 16 May 2024 16:50:09 +0200
> GC attempts to explicitly drop oob_skb before purging the hit list.

Sorry for not catching these in v1,

nit: s/oob_skb/oob_skb's reference/

> 
> The problem is with embryos: kfree_skb(u->oob_skb) is never called on an
> embryo socket, as those sockets are not directly stacked by the SCC walk.

", as ..." is not correct and can be just removed.  Here we walk
through embryos as written in the next paragraph but we forget
dropping oob_skb's refcnt.

> 
> The python script below [0] sends a listener's fd to its embryo as OOB
> data.  While GC does collect the embryo's queue, it fails to drop the OOB
> skb's refcount.  The skb which was in embryo's receive queue stays as
> unix_sk(sk)->oob_skb and keeps the listener's refcount [1].
> 
> Tell GC to dispose embryo's oob_skb.
> 
> [0]:
> from array import array
> from socket import *
> 
> addr = '\x00unix-oob'
> lis = socket(AF_UNIX, SOCK_STREAM)
> lis.bind(addr)
> lis.listen(1)
> 
> s = socket(AF_UNIX, SOCK_STREAM)
> s.connect(addr)
> scm = (SOL_SOCKET, SCM_RIGHTS, array('i', [lis.fileno()]))
> s.sendmsg([b'x'], [scm], MSG_OOB)
> lis.close()
> 
> [1]
> $ grep unix-oob /proc/net/unix
> $ ./unix-oob.py
> $ grep unix-oob /proc/net/unix
> 0000000000000000: 00000002 00000000 00000000 0001 02     0 @unix-oob
> 0000000000000000: 00000002 00000000 00010000 0001 01  6072 @unix-oob
> 
> Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

with the above corrected, you can add

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/unix/garbage.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 1f8b8cdfcdc8..dfe94a90ece4 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -342,6 +342,18 @@ enum unix_recv_queue_lock_class {
>  	U_RECVQ_LOCK_EMBRYO,
>  };
>  
> +static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
> +{
> +	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
> +
> +#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +	if (u->oob_skb) {
> +		WARN_ON_ONCE(skb_unref(u->oob_skb));
> +		u->oob_skb = NULL;
> +	}
> +#endif
> +}
> +
>  static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
>  {
>  	struct unix_vertex *vertex;
> @@ -365,18 +377,11 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
>  
>  				/* listener -> embryo order, the inversion never happens. */
>  				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
> -				skb_queue_splice_init(embryo_queue, hitlist);
> +				unix_collect_queue(unix_sk(skb->sk), hitlist);
>  				spin_unlock(&embryo_queue->lock);
>  			}
>  		} else {
> -			skb_queue_splice_init(queue, hitlist);
> -
> -#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> -			if (u->oob_skb) {
> -				kfree_skb(u->oob_skb);
> -				u->oob_skb = NULL;
> -			}
> -#endif
> +			unix_collect_queue(u, hitlist);
>  		}
>  
>  		spin_unlock(&queue->lock);
> -- 
> 2.45.0
> 

