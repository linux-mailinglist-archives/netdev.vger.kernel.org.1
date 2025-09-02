Return-Path: <netdev+bounces-219337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13647B41058
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7747B188AA63
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A22777FC;
	Tue,  2 Sep 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAUhUlPz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414A27587C;
	Tue,  2 Sep 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853428; cv=none; b=msBaoGHHAWkBCgjN0b/X6wYVRaKRE2/eUeNQP7XG/A1aDfVBEnGBPZBZjY/IKEv8ns2mwmpJVNbU+B/CCAPDs0Cb+tPrr6paPvq7MYAFTxVuzao1vJtll8IqSvExbPgM+wG1Pn2wv9YEK1eqKQ3WveIxrSjYOUDFeEwoD4S5QqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853428; c=relaxed/simple;
	bh=VJ0ZObnZaXxnRWhbjNFj5HtFsZcyPM2WWMoCiOu53IU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W6a8zxiCLSiYKxRQF2JVMQ58dPjf5iqtWHc68AFHX7FlnC0vYwLBFVbChe4G+0h3onJelb5LrbHUwY+ZUTUorWl5BXkq9JhCzZTYA01ZHG7xoFpVa0OozdvTRiDvq2mMSdYbtwKmEzYJBzTFLmcs19loZf3AQ5cVBSG8gvAoVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAUhUlPz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e872c3a0d5so566709385a.2;
        Tue, 02 Sep 2025 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853426; x=1757458226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtLQPpLxI6ZjgQLK+QJDLph+ec5t3i/JbVs9rfBJ4lI=;
        b=lAUhUlPzpi5JXxrk48J/HEpW/JtHkWbt9HgnsnowLLFxyvqMPbV23sQ84TCDYOZYJW
         9G7AheOEGq/ORpj3LRUuE+MenFsQLa1yRFjTHDjIk0aNk9ilLVDODFe2APF4xqzH0GtX
         unVLLXMznIqls3dbvgrIGhx5LB3BpmsIDwRlW1UUeh16qa6m7AnVlGavwTyGFS4bvO1r
         DPvnOgE4B5cgIWNS3cBi1Hqq4nim8HcgD1r+DtNoFPvCvu0QbCmEQwFLL8n9t6MtNXU7
         kKHj4W0frQyYdjCRQT/Tb7jEqOx9byP9axjSnSocsM8h9b/ZWJ7/N6YCtmqRU5pN5T3J
         JLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853426; x=1757458226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtLQPpLxI6ZjgQLK+QJDLph+ec5t3i/JbVs9rfBJ4lI=;
        b=PLeOV2xgV3GPHaI8b9vofiZO0hd83apSwyNPZl0ddoAXrU5pvRAi1VM+hCzryvdXgQ
         gz0mOHdDnMVNu3t9NCYDluzvt3Xun/aCjZjycruUNxr0SZsbgAfz6NN/D64UTLMP6QNV
         5x6NRJWSsH8yXtMYZyOoDaNjOIdB8jjZKuvjC1FDANCDRNPnQTtoqdJWpr6oJX7KVakN
         dHukOxM3Uc/qpjcFwugD3fbGp/5lVBJF6NqcszOrhjq098xjhRf930MQkWkhEqnq5Aib
         dc7rh2U4z/3rzOd5ccRNM8ZibnaVX/ezYwbXQJRSYThz+zpQlxeYRUljMgr3gtuyBU9d
         psJg==
X-Forwarded-Encrypted: i=1; AJvYcCVV++CPWCE6QWyeJC4NIKNeTGgSj7Y0ZeZJg+89uEq3RP0LynxfCv5HJs0sDBV6DFMGTqZhBru+S/Lcmy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxymNn4gfyLW5HD4QoYxUi7WsHBu/8zUsMoFPK+xH+EVdG5B92
	fA5og+22XLVtih/YNTOTPdWQzBGLS47pAVNqEAiME/imQATpHjYQ9TVE
X-Gm-Gg: ASbGnct2RKf1jW/noJK0TKfFQsUASjw0K0+y9r624W4145/FNZi2PxBRKdkl0oBHyi4
	Hg1FPAjbgBGUA1vPu3UyLCWmkGVpuAPFIMDHKb1SsNxSrKaJKLQlBS9OScap271bRzG5hMiiTR4
	QGh4CRNoK3D20ZcspxB9e/BrkLNLFsjdoMtYDtBeVXsIYpxvCWZOaKS6cZ5v62HduEZ5rqfhraX
	yE6+OtmZxR9R9eWxFmrG68fY88EIALILv4LvfES8D71GUk2N/tlDH+2NqFh2V7kPAuWD47Ctx4O
	mGf1l11XNCnK6pianw/EUTK3xv41y1LK4G8qIBWRoPq3K4qN5MPPp/Csn27t6ZR2z/90atxviFX
	zZopJBqVj612BNmEzHCYSevunKLhiQy3PIr9RZIqUL07DaA+duMkVJ3EqnMbabDvy70AvWcofl2
	hiMg==
X-Google-Smtp-Source: AGHT+IE/kWt363/ZQE1Nw+pZybIpAW8G7ekOjiHkWmjQlOxKd2fohOCAbHVaJtwx8UN+tV0ugk5yyQ==
X-Received: by 2002:a05:620a:1a21:b0:7e8:74d:fdf5 with SMTP id af79cd13be357-7ff26f9fd2fmr1459440885a.4.1756853425989;
        Tue, 02 Sep 2025 15:50:25 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aab5a062fsm20291285a.48.2025.09.02.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:50:25 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:50:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.9ee65133b4b7@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
Subject: Re: [PATCH 4/7] netpoll: Export zap_completion_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Make zap_completion_queue() a globally visible symbol by changing its
> linkage to non-static and adding EXPORT_SYMBOL_GPL.
> 
> This is a true netpoll function that will be needed by non-netpoll
> functions that will be moved away from netpoll.
> 
> This will allow moving the skb pool management to netconsole, mainly
> find_skb(), which invokes zap_completion_queue(), and will be moved to
> netconsole.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/linux/netpoll.h | 1 +
>  net/core/netpoll.c      | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
> index 65bfade025f09..7f8b4d758a1e7 100644
> --- a/include/linux/netpoll.h
> +++ b/include/linux/netpoll.h
> @@ -75,6 +75,7 @@ void __netpoll_free(struct netpoll *np);
>  void do_netpoll_cleanup(struct netpoll *np);
>  netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
>  struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
> +void zap_completion_queue(void);
>  
>  #ifdef CONFIG_NETPOLL
>  static inline void *netpoll_poll_lock(struct napi_struct *napi)
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 9e12a667a5f0a..04a55ec392fd2 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -50,8 +50,6 @@
>  	 sizeof(struct udphdr) +					\
>  	 MAX_UDP_CHUNK)
>  
> -static void zap_completion_queue(void);
> -
>  static unsigned int carrier_timeout = 4;
>  module_param(carrier_timeout, uint, 0644);
>  
> @@ -240,7 +238,7 @@ static void refill_skbs(struct netpoll *np)
>  	spin_unlock_irqrestore(&skb_pool->lock, flags);
>  }
>  
> -static void zap_completion_queue(void)
> +void zap_completion_queue(void)
>  {
>  	unsigned long flags;
>  	struct softnet_data *sd = &get_cpu_var(softnet_data);
> @@ -267,6 +265,7 @@ static void zap_completion_queue(void)
>  
>  	put_cpu_var(softnet_data);
>  }
> +EXPORT_SYMBOL_GPL(zap_completion_queue);

consider EXPORT_SYMBOL_NS_GPL(zap_completion_queue, "NETDEV_INTERNAL");



