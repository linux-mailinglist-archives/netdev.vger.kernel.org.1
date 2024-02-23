Return-Path: <netdev+bounces-74529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395AC861C5D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514141C2354C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCC143C4B;
	Fri, 23 Feb 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OLhVdZa/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C447F4A
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715875; cv=none; b=mNg+RTYIlIhuZp58SLSoeOGRvf9Iu7I4uiMvQBnWUnALCTbALWjxG9PTHJA3s9+8oZimDlYL03/0l8++5OeIldCQu1/JPvDnPF5YmkQzHUKcUGsqJKC9pXaoQdzP/b+2rjMkDe46aemJjBD4xhYHlxhNN7vrWRktFqVp4fUfkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715875; c=relaxed/simple;
	bh=wu/hq/nmyM/5wNAlNobk4MXqPQ344zYbMGOB6l3bL8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJM1IsxHIuM9cMUwYvFdVPdFMFwz38EUHrbSwFqgDyrnoKybbmAblNm4NSvja6fY+GCqY+gkMoq1GEzHnrpgxQbEL+wUWWOO5pJcSqTaDaxvkDcxOKmapvqqNoUvFsS8p7KNE0pn2OvBAihy2Hz8UZKjzwr1ydH9vM2Y+J7I1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OLhVdZa/; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708715874; x=1740251874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vM1vgdd6hZNLFz5lzDwY5M8v4cmWdv+UsqvIhMYtm6A=;
  b=OLhVdZa/unpNXY9O8V12DmQqAO6eog253mSVha8lkOIIWv4xlOeVaOGI
   crbpH61p20jySKNnWyYDlvIl/IBv+0L5+VMtFACpWSpyyzGI4ByKveRT9
   1qlwg2X2NMEI7t85vVlJdxFwJwPmbgyt0B+XulhjVLXBLLiCuIrpg+QMy
   c=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="276346403"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:17:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:44399]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.236:2525] with esmtp (Farcaster)
 id bdf27b99-591f-47fa-897e-af6a882f6b96; Fri, 23 Feb 2024 19:17:50 +0000 (UTC)
X-Farcaster-Flow-ID: bdf27b99-591f-47fa-897e-af6a882f6b96
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:17:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 23 Feb 2024 19:17:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 02/10] tcp: directly drop skb in cookie check for ipv4
Date: Fri, 23 Feb 2024 11:17:36 -0800
Message-ID: <20240223191736.4152-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-3-kerneljasonxing@gmail.com>
References: <20240223102851.83749-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:43 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Only move the skb drop from tcp_v4_do_rcv() to cookie_v4_check() itself,
> no other changes made. It can help us refine the specific drop reasons
> later.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> --
> v9
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> 1. add reviewed-by tag (David)
> 
> v8
> Link: https://lore.kernel.org/netdev/CANn89i+foA-AW3KCNw232eCC5GDi_3O0JG-mpvyiQJYuxKxnRA@mail.gmail.com/
> 1. add reviewed-by tag (Eric)
> 
> v7
> Link: https://lore.kernel.org/all/20240219041350.95304-1-kuniyu@amazon.com/
> 1. add reviewed-by tag (Kuniyuki)
> ---
>  net/ipv4/syncookies.c | 4 ++++
>  net/ipv4/tcp_ipv4.c   | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index be88bf586ff9..38f331da6677 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -408,6 +408,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  	struct rtable *rt;
>  	__u8 rcv_wscale;
>  	int full_space;
> +	SKB_DR(reason);
>  
>  	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
>  	    !th->ack || th->rst)
> @@ -477,10 +478,13 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
>  	 */
>  	if (ret)
>  		inet_sk(ret)->cork.fl.u.ip4 = fl4;
> +	else
> +		goto out_drop;

nit: It would be nice to use the same style with IPv6 change.

	if (!ret)
		goto out_drop;

	inet_sk(ret)->cork.fl.u.ip4 = fl4;

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


>  out:
>  	return ret;
>  out_free:
>  	reqsk_free(req);
>  out_drop:
> +	kfree_skb_reason(skb, reason);
>  	return NULL;
>  }
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 0c50c5a32b84..0a944e109088 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1915,7 +1915,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
>  		struct sock *nsk = tcp_v4_cookie_check(sk, skb);
>  
>  		if (!nsk)
> -			goto discard;
> +			return 0;
>  		if (nsk != sk) {
>  			if (tcp_child_process(sk, nsk, skb)) {
>  				rsk = nsk;
> -- 
> 2.37.3

