Return-Path: <netdev+bounces-126021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F296F9B8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2F1F24228
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078181D45F9;
	Fri,  6 Sep 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jQDabZBM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453F1D3620;
	Fri,  6 Sep 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642418; cv=none; b=cOOluSmzXPLAUMFin1zQWJiabvvd4nXThR+I9KQ6AaXM7LFoZXJZam2AzbLr11+eknn5KzDpW5O+MX3ZuRq+IecTaccyepG7l/3WLjzoarpwnvU0SShpmJbeLwqhyw6L5wD6j9Aza47+1l7Z0bZUJKsXoRItTJ07nzadWoZljEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642418; c=relaxed/simple;
	bh=NPeJ4OMHStfV9bh6sMyiOGOpK3bthEZ12GHhtsAwF70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfP66TJff00Bk+Y5dIVreSH6o+JWwFg1bI+ocFiSJRy/ooeEx/3wsxD7IV0F9IasJy0qrr4mS9iXNT3fQQbEluz72IQZ2HCsZ6KBhsYnRya259hSV635s+ckcorvvuy3shIWsqu07i+nd9TQktudSKf3jC6Se/h5nVdW0ntQxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jQDabZBM; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725642417; x=1757178417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jn42wqH671vFB3InLNKwvEuNGUf5C0VRcB5rM3aOr5A=;
  b=jQDabZBMTVAAUUjlka9/tSwUlxtMu048+vRkHfYYgEVJ8Aa4wUiaRzqc
   yLRQLwt0CJfp/syjXLkklA98jXYiwq18jE6T8hoNg0cYaoD4td9GmfdmZ
   uCRQnYJpd165mJjLfzxohVk8pma/0hIj/Oc8EqmKq6mF1jBcc0jf+R+VE
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,208,1719878400"; 
   d="scan'208";a="757373509"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 17:06:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:10174]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.196:2525] with esmtp (Farcaster)
 id ef379f21-421f-4fe3-8d76-bc7e5742ec5c; Fri, 6 Sep 2024 17:06:49 +0000 (UTC)
X-Farcaster-Flow-ID: ef379f21-421f-4fe3-8d76-bc7e5742ec5c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Sep 2024 17:06:49 +0000
Received: from 88665a182662.ant.amazon.com (10.94.49.188) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Sep 2024 17:06:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <usama.anjum@collabora.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernel@collabora.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] fou: fix initialization of grc
Date: Fri, 6 Sep 2024 10:06:36 -0700
Message-ID: <20240906170636.69739-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240906102839.202798-1-usama.anjum@collabora.com>
References: <20240906102839.202798-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date: Fri,  6 Sep 2024 15:28:39 +0500
> The grc must be initialize first. There can be a condition where if
> fou is NULL, goto out will be executed and grc would be used
> uninitialized.
> 
> Fixes: 7e4196935069 ("fou: Fix null-ptr-deref in GRO.")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/ipv4/fou_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 78b869b314921..3e30745e2c09a 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -336,11 +336,11 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
>  	struct gro_remcsum grc;
>  	u8 proto;
>  
> +	skb_gro_remcsum_init(&grc);
> +
>  	if (!fou)
>  		goto out;
>  
> -	skb_gro_remcsum_init(&grc);
> -
>  	off = skb_gro_offset(skb);
>  	len = off + sizeof(*guehdr);
>  
> -- 
> 2.39.2

