Return-Path: <netdev+bounces-72814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCF1859B6A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 05:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5944D1C21340
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B346AB65A;
	Mon, 19 Feb 2024 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kO0cyQhW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1D256D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317511; cv=none; b=s5sZ7vmBzHfFFzAzTLKpF+LuVYCRXD8naP/7G9zymAhyZnpqICQzwlsTZcASUnIDhNJNnIxrImnCczgvOHSptnNePViUCjBMx8eeMbFmGsifYY94U3h96aMPolk5GgqrL9wPCJgAHhhYNeVI46idEF/zcYGAsYQzVPDovjlaucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317511; c=relaxed/simple;
	bh=td3XHKzOYfsy3w1IqdcXYg1tWIZKPWdkADTw6WSAHSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPkYIXG9Oz/TZhWVW9yNKRk2f4yRbLc8UYl3yvrJrg4TDx84MHHMZAlgtHaWSq1a8Sp5cRt3dl0DjzIFDvd5MQH8nwMfuq7hiZvAfFjMZ7Ng/M6yIL6Lwf2sSH//nxc+KMIEoNZ12mdY0AHp6orM8+yHqvXH6DPNd+0gmSSRy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kO0cyQhW; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708317510; x=1739853510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=772WpN3uwR2PUEva/jUsgoeuH3Miw5bLuxSFobyRiQg=;
  b=kO0cyQhWa+9VZO9hNEP0wd72YGrPpV7gsLUtl2CpHXiLQzYpeYUES5TE
   I0ChuXu2Tr2nOgDlapus9ByDgw7AUeMTYRtfwcSebgHs1jpwb2RwXo1Kv
   YLEtikGBxX4bo0Ot1IDepoGsbRmkBHMgHyH0mEz9CWmOvetTo3qNZjiXy
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,170,1705363200"; 
   d="scan'208";a="66911682"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:38:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:26298]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.134:2525] with esmtp (Farcaster)
 id 3b55a2a4-0f17-4d8b-a2ef-7ab370daddc1; Mon, 19 Feb 2024 04:38:28 +0000 (UTC)
X-Farcaster-Flow-ID: 3b55a2a4-0f17-4d8b-a2ef-7ab370daddc1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 19 Feb 2024 04:38:27 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 19 Feb 2024 04:38:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 04/11] tcp: directly drop skb in cookie check for ipv6
Date: Sun, 18 Feb 2024 20:38:15 -0800
Message-ID: <20240219043815.98410-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240219032838.91723-5-kerneljasonxing@gmail.com>
References: <20240219032838.91723-5-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Feb 2024 11:28:31 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Like previous patch does, only moving skb drop logical code to
> cookie_v6_check() for later refinement.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v6
> Link: https://lore.kernel.org/all/c987d2c79e4a4655166eb8eafef473384edb37fb.camel@redhat.com/
> Link: https://lore.kernel.org/all/CAL+tcoAgSjwsmFnDh_Gs9ZgMi-y5awtVx+4VhJPNRADjo7LLSA@mail.gmail.com/
> 1. take one case into consideration, behave like old days, or else it will trigger errors.
> 
> v5
> Link: https://lore.kernel.org/netdev/CANn89iKz7=1q7e8KY57Dn3ED7O=RCOfLxoHQKO4eNXnZa1OPWg@mail.gmail.com/
> 1. avoid duplication of these opt_skb tests/actions (Eric)
> ---
>  net/ipv6/syncookies.c | 4 ++++
>  net/ipv6/tcp_ipv6.c   | 7 +++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 6b9c69278819..ea0d9954a29f 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  	struct sock *ret = sk;
>  	__u8 rcv_wscale;
>  	int full_space;
> +	SKB_DR(reason);
>  
>  	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
>  	    !th->ack || th->rst)
> @@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
>  
>  	ret = tcp_get_cookie_sock(sk, skb, req, dst);
> +	if (!ret)
> +		goto out_drop;
>  out:
>  	return ret;
>  out_free:
>  	reqsk_free(req);
>  out_drop:
> +	kfree_skb_reason(skb, reason);
>  	return NULL;
>  }
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 57b25b1fc9d9..4cfeedfb871f 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1653,12 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  	if (sk->sk_state == TCP_LISTEN) {
>  		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
>  
> -		if (!nsk)
> -			goto discard;
> -
> -		if (nsk != sk) {
> +		if (nsk && nsk != sk) {
>  			if (tcp_child_process(sk, nsk, skb))
>  				goto reset;
> +		}
> +		if (!nsk || nsk != sk) {

!nsk is redundant, when nsk is NULL, nsk != sk is true.

We can keep the original nsk != sk check and call tcp_child_process()
only when nsk is not NULL:

---8<---
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9..0c180bb8187f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,11 +1653,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
-
 		if (nsk != sk) {
-			if (tcp_child_process(sk, nsk, skb))
+			if (nsk && tcp_child_process(sk, nsk, skb))
 				goto reset;
 			if (opt_skb)
 				__kfree_skb(opt_skb);
---8<---

