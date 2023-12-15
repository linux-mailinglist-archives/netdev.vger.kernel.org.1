Return-Path: <netdev+bounces-57711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE34813F85
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909A0B220C8
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 01:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90E9650;
	Fri, 15 Dec 2023 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qj3u1NTW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212C7E4
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702605513; x=1734141513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gI/AeCQBvYfpqBer5ls1z6A8dVfxi1wQc7z5OFU5sCA=;
  b=qj3u1NTWcQdWCDEMVqaKca8+llFs6v2XW7a+UrebVxmtO/5mumiNGtwC
   YiKtC1RgRMAipyw8DedjAtxTrAnKxTYsqwaHd0BVMmd/1E3EHfuOtt2w0
   Wdi8vOx+EOmI5a8Eoyy5z5r4dbignHcg3D4T9HsZCgyIzY+x1Iu+58c7z
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,277,1695686400"; 
   d="scan'208";a="259895260"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 01:58:30 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id AEF9540D68;
	Fri, 15 Dec 2023 01:58:29 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:49142]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 43150f7e-b22f-4983-9746-87ea14b71030; Fri, 15 Dec 2023 01:58:29 +0000 (UTC)
X-Farcaster-Flow-ID: 43150f7e-b22f-4983-9746-87ea14b71030
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 01:58:28 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 01:58:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <jakub@cloudflare.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>
Subject: [PATCH net-next 2/2] tcp/dccp: change source port selection at connect() time
Date: Fri, 15 Dec 2023 10:58:07 +0900
Message-ID: <20231215015807.39107-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214192939.1962891-3-edumazet@google.com>
References: <20231214192939.1962891-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Dec 2023 19:29:39 +0000
> In commit 1580ab63fc9a ("tcp/dccp: better use of ephemeral ports in connect()")
> we added an heuristic to select even ports for connect() and odd ports for bind().
> 
> This was nice because no applications changes were needed.
> 
> But it added more costs when all even ports are in use,
> when there are few listeners and many active connections.
> 
> Since then, IP_LOCAL_PORT_RANGE has been added to permit an application
> to partition ephemeral port range at will.
> 
> This patch extends the idea so that if IP_LOCAL_PORT_RANGE is set on
> a socket before accept(), port selection no longer favors even ports.
> 
> This means that connect() can find a suitable source port faster,
> and applications can use a different split between connect() and bind()
> users.
> 
> This should give more entropy to Toeplitz hash used in RSS: Using even
> ports was wasting one bit from the 16bit sport.
> 
> A similar change can be done in inet_csk_find_open_port() if needed.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  net/ipv4/inet_hashtables.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index a532f749e47781cc951f2003f621cec4387a2384..9ff201bc4e6d2da04735e8c160d446602e0adde1 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1012,7 +1012,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  	bool tb_created = false;
>  	u32 remaining, offset;
>  	int ret, i, low, high;
> -	int l3mdev;
> +	bool local_ports;
> +	int step, l3mdev;
>  	u32 index;
>  
>  	if (port) {
> @@ -1024,10 +1025,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  
>  	l3mdev = inet_sk_bound_l3mdev(sk);
>  
> -	inet_sk_get_local_port_range(sk, &low, &high);
> +	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
> +	step = local_ports ? 1 : 2;
> +
>  	high++; /* [32768, 60999] -> [32768, 61000[ */
>  	remaining = high - low;
> -	if (likely(remaining > 1))
> +	if (!local_ports && remaining > 1)
>  		remaining &= ~1U;
>  
>  	get_random_sleepable_once(table_perturb,
> @@ -1040,10 +1043,11 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  	/* In first pass we try ports of @low parity.
>  	 * inet_csk_get_port() does the opposite choice.
>  	 */
> -	offset &= ~1U;
> +	if (!local_ports)
> +		offset &= ~1U;
>  other_parity_scan:
>  	port = low + offset;
> -	for (i = 0; i < remaining; i += 2, port += 2) {
> +	for (i = 0; i < remaining; i += step, port += step) {
>  		if (unlikely(port >= high))
>  			port -= remaining;
>  		if (inet_is_local_reserved_port(net, port))
> @@ -1083,10 +1087,11 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  		cond_resched();
>  	}
>  
> -	offset++;
> -	if ((offset & 1) && remaining > 1)
> -		goto other_parity_scan;
> -
> +	if (!local_ports) {
> +		offset++;
> +		if ((offset & 1) && remaining > 1)
> +			goto other_parity_scan;
> +	}
>  	return -EADDRNOTAVAIL;
>  
>  ok:
> @@ -1109,8 +1114,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  	 * on low contention the randomness is maximal and on high contention
>  	 * it may be inexistent.
>  	 */
> -	i = max_t(int, i, get_random_u32_below(8) * 2);
> -	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + 2);
> +	i = max_t(int, i, get_random_u32_below(8) * step);
> +	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + step);
>  
>  	/* Head lock still held and bh's disabled */
>  	inet_bind_hash(sk, tb, tb2, port);
> -- 
> 2.43.0.472.g3155946c3a-goog

