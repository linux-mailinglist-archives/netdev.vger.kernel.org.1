Return-Path: <netdev+bounces-152476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D831F9F40EB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFFC188DDAB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812213B7A1;
	Tue, 17 Dec 2024 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YC8e+IbU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3492595;
	Tue, 17 Dec 2024 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403332; cv=none; b=AgpFaFCr2QApAvMkdzI+J7j3QBldeEwrHegcssm5iMGlrc4Qy5iQzoSjikQRpZ2FPRUudzkrIS8dvIIK8QdQ02kP3XRdi17g0hYR3BOIF/DPzgKwHDYR+jQawrsxNdO6MyRRbG2lBhnfMxVpgVrrGFO30R1KEZTci/gCKzqDaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403332; c=relaxed/simple;
	bh=sxZHwktHLbmobkjo0Mrad2ue1QYN50MUOr5DU5+0mFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0Plriq9BWPvHaP7P+NsaU7SumM29OvspHeF/sod+EXcZaiuKl02wR5mvy+kf/InUMKaa6T5qO9xdtcc/DfCKSCtTw6pPf63HmK3bl6LMZRi3n234q08HmRxf4xu81QeaQKoAoELrTPGSba9JgfeNncokdS28D9PqBx/clUqEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YC8e+IbU; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734403333; x=1765939333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7u6OT2PYujYQCUkhEoUVtOLDlI0hXd4C0CDZ9AuT7gs=;
  b=YC8e+IbUWloKA9Ax6yn77qlO9f4CwKpiUIEg7t4ALpy6vAmk10h/ovsY
   2TP961Su11a0fAksjlUnmwROd4AiAzY/VeWa6C1whrjpgl4DFAz6XI6Bk
   p9BUMNcY7qiS+IpawKsWR8ML1BpPXgdVNCXj+vitA7KPxm+pgbFt+sQYZ
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,240,1728950400"; 
   d="scan'208";a="783912395"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 02:42:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:35891]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.52:2525] with esmtp (Farcaster)
 id b97cbbc6-b57a-4b3f-b068-55f90e4c1c6a; Tue, 17 Dec 2024 02:42:05 +0000 (UTC)
X-Farcaster-Flow-ID: b97cbbc6-b57a-4b3f-b068-55f90e4c1c6a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 02:42:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.246.225) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 02:42:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<idosch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH] rtnetlink: do_setlink: Use true struct sockaddr
Date: Tue, 17 Dec 2024 11:41:56 +0900
Message-ID: <20241217024156.43328-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241217020441.work.066-kees@kernel.org>
References: <20241217020441.work.066-kees@kernel.org>
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

From: Kees Cook <kees@kernel.org>
Date: Mon, 16 Dec 2024 18:04:45 -0800
> Instead of a heap allocation use a stack allocated struct sockaddr, as
> dev_set_mac_address_user() is the consumer (which uses a classic
> struct sockaddr).

I remember Eric's feedback was to keep using heap instead of stack
because rtnl_newlink() path already uses too much on stack.


> Cap the copy to the minimum address size between
> the incoming address and the traditional sa_data field itself.
> 
> Putting "sa" on the stack means it will get a reused stack slot since
> it is smaller than other existing single-scope stack variables (like
> the vfinfo array).
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: netdev@vger.kernel.org
> ---
>  net/core/rtnetlink.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ab5f201bf0ab..6da0edc0870d 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3048,21 +3048,13 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>  	}
>  
>  	if (tb[IFLA_ADDRESS]) {
> -		struct sockaddr *sa;
> -		int len;
> -
> -		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
> -						  sizeof(*sa));
> -		sa = kmalloc(len, GFP_KERNEL);
> -		if (!sa) {
> -			err = -ENOMEM;
> -			goto errout;
> -		}
> -		sa->sa_family = dev->type;
> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> -		       dev->addr_len);
> -		err = dev_set_mac_address_user(dev, sa, extack);
> -		kfree(sa);
> +		struct sockaddr sa = { };
> +
> +		/* dev_set_mac_address_user() uses a true struct sockaddr. */
> +		sa.sa_family = dev->type;
> +		memcpy(sa.sa_data, nla_data(tb[IFLA_ADDRESS]),
> +		       min(dev->addr_len, sizeof(sa.sa_data_min)));
> +		err = dev_set_mac_address_user(dev, &sa, extack);
>  		if (err)
>  			goto errout;
>  		status |= DO_SETLINK_MODIFIED;
> -- 
> 2.34.1

