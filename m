Return-Path: <netdev+bounces-162903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E0A2858D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9617A0700
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2B7229B33;
	Wed,  5 Feb 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hXuAhGH4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC23229B0D;
	Wed,  5 Feb 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738744142; cv=none; b=XeG+xXVStx/akGdHU2kZzovhJeW0FlygFkKNUZ8aqcy+CM0HRu2ERX0F4mDBghqWFn8GR0C5dmUr0Co6bVnJspdwLKfsTL6R2faSl/VzBP3lDpo8TXSkm4ArtEHejxm50SJ2GxUhmSoRF1rEcMLOF+qja6mpQSEQxuKmSreuFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738744142; c=relaxed/simple;
	bh=Q6F62UJ38W/MS6lPjPgw5ELFS8m0SJSyN+NibGranhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwBk4m6qSeszuXpOJLp3h8WI49Mbf+FqU1RoGXwQ2eRSb7Jm5ejUNsKDEqer96VxJtbHIUgrU5T7sjIVdfLZgEiZW460qqINOPT9RhQry45cknm7kYhNejzC+sEtFvu2BI3z3AS12vk8wPZcxW4zYXyiwGfqSQkCJ7pY48cLSH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hXuAhGH4; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738744142; x=1770280142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Irrk44yL9PVNITVe2ru2h9A7Eg4l2yRsDWys0WJFTMY=;
  b=hXuAhGH4D3Y0Rs/4wObmQhJSwoCPiLhPmVcz2XsfqYlLG4rkezNwgkJK
   lH7Wx2QPCYW1wRPlC8/pD9KW04Q2oO3JUCoPvpJ9fUCD8tDm6gfsTrqQ8
   SbIQu4rbDXcy+Q/ry/BceJfDBtATU3p8V144YzGo4HDFcsFVtcvw704HR
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,260,1732579200"; 
   d="scan'208";a="796218126"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 08:28:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:52174]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id ff01f214-874c-424c-8e61-00fbef4a2201; Wed, 5 Feb 2025 08:28:54 +0000 (UTC)
X-Farcaster-Flow-ID: ff01f214-874c-424c-8e61-00fbef4a2201
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 5 Feb 2025 08:28:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.255.254) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 5 Feb 2025 08:28:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <buaajxlj@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <liangjie@lixiang.com>,
	<linux-kernel@vger.kernel.org>, <mhal@rbox.co>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind identifier length
Date: Wed, 5 Feb 2025 17:28:41 +0900
Message-ID: <20250205082841.94701-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205060653.2221165-1-buaajxlj@163.com>
References: <20250205060653.2221165-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Liang Jie <buaajxlj@163.com>
Date: Wed,  5 Feb 2025 14:06:53 +0800
> From: Liang Jie <liangjie@lixiang.com>
> 
> Refines autobind identifier length for UNIX domain sockets, addressing
> issues of memory waste and code readability.
> 
> The previous implementation in the unix_autobind function of UNIX domain
> sockets used hardcoded values such as 16, 6, and 5 for memory allocation
> and setting the length of the autobind identifier, which was not only
> inflexible but also led to reduced code clarity. Additionally, allocating
> 16 bytes of memory for the autobind path was excessive, given that only 6
> bytes were ultimately used.
> 
> To mitigate these issues, introduces the following changes:
>  - A new macro AUTOBIND_LEN is defined to clearly represent the total
>    length of the autobind identifier, which improves code readability and
>    maintainability. It is set to 6 bytes to accommodate the unique autobind
>    process identifier.
>  - Memory allocation for the autobind path is now precisely based on
>    AUTOBIND_LEN, thereby preventing memory waste.
>  - The sprintf() function call is updated to dynamically format the
>    autobind identifier according to the defined length, further enhancing
>    code consistency and readability.
> 
> The modifications result in a leaner memory footprint and elevated code
> quality, ensuring that the functional aspect of autobind behavior in UNIX
> domain sockets remains intact.
> 
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> ---
>  net/unix/af_unix.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 34945de1fb1f..5dcc55f2e3a1 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1186,6 +1186,13 @@ static struct sock *unix_find_other(struct net *net,
>  	return sk;
>  }
>  
> +/*
> + * Define the total length of the autobind identifier for UNIX domain sockets.
> + * - The first byte distinguishes abstract sockets from filesystem-based sockets.

Now it's called pathname socket, but I think we don't need a comment here.
We already have enough comment/doc in other places and the man page.

$ man 7 unix
...
The address consists of a null byte followed by 5 bytes in the character set [0-9a-f].


> + * - The subsequent five bytes store a unique identifier for the autobinding process.
> + */
> +#define AUTOBIND_LEN 6

UNIX_AUTOBIND_LEN


> +
>  static int unix_autobind(struct sock *sk)
>  {
>  	struct unix_sock *u = unix_sk(sk);
> @@ -1204,11 +1211,11 @@ static int unix_autobind(struct sock *sk)
>  
>  	err = -ENOMEM;
>  	addr = kzalloc(sizeof(*addr) +
> -		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
> +		       offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN, GFP_KERNEL);
>  	if (!addr)
>  		goto out;
>  
> -	addr->len = offsetof(struct sockaddr_un, sun_path) + 6;
> +	addr->len = offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN;
>  	addr->name->sun_family = AF_UNIX;
>  	refcount_set(&addr->refcnt, 1);
>  
> @@ -1217,7 +1224,7 @@ static int unix_autobind(struct sock *sk)
>  	lastnum = ordernum & 0xFFFFF;
>  retry:
>  	ordernum = (ordernum + 1) & 0xFFFFF;
> -	sprintf(addr->name->sun_path + 1, "%05x", ordernum);
> +	sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);

I feel %05 is easier to read.  Note that man page mentions 5 bytes.

1 is also hard-coded here, but I don't think we should write

sprintf(addr->name->sun_path + UNIX_ABSTRACT_NAME_OFFSET,
        "%0*x", UNIX_AUTOBIND_LEN - 1, ordernum)


>  
>  	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
>  	unix_table_double_lock(net, old_hash, new_hash);
> -- 
> 2.25.1

