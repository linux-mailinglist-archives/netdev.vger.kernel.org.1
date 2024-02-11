Return-Path: <netdev+bounces-70827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6251850A95
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35AA6B21A14
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 17:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719285B5D5;
	Sun, 11 Feb 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DENlQmkE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1B5B5AD
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673350; cv=none; b=lWbFHZFw44gSdnxBc7lPWoSbftZ0Mwl4qHzivokbJBW6TXE+KItPj08MHgkksB9d1z/gX9Cx7Zlx2+cBK8ygRj40Lyi0GT5/QYYJmtXtBtW6jdRONampgnEn1hVCa7o+LEuA1ZmCESuiwqZUPUc+DQxTT5Pbgfk1mVQXpbQWKoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673350; c=relaxed/simple;
	bh=6KtoZej55T9p+Uj/Gbztz+6EmdIHbwFuTGGDD8CgvrM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XQO81VxXGzFUfmtd8dJrMNWnhVxgMBlS9qz/UnknntI79htNyUaW69E/fpyfwE+lY7X30U9eZHQqCL8P6l/91xw7uXQV6Q4pYYfolYXd4gfJ3ZuM4A23+Kz+OX7WacnCj+UJzZU4LCWA+Th6MGhpGkQhRBDAXtJ2CrUDh4A5e2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DENlQmkE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68c8790aeadso19696716d6.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707673347; x=1708278147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp6EXQRuPCFGDweaQpwiHQvfY2WuCwKaje05aNYOgiQ=;
        b=DENlQmkE67uVL5X314e0p71Rau5ZZiFROUhT8zR0qHeHOW/k5iqzJ9H+jb+1JOMyvg
         sBEpeBzADX8R1vasfoOE5ZtQQdaL2NxGklmADpmEdTLgCXJazCl+/Omow4ueqo8Jp/g2
         GS/tiXsFAYd3vjv4iiEJ3vxcH0oJ/wNKR933OlkNftpGAjt2AaK9qWg0o9d5tKp5IUhN
         HbluQL3DG75shLuqpd7s7bX+0UBgnMxphgXSy18Myec5CF7MZlXqtPtKIet+a6M/ZDUZ
         HjCiO9M4n/2vKW4VauxkcA0c47RCLaD7EL9TUxY5zopyu0ACZ0x+tdAgX1pdA3eTKwdD
         nE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707673347; x=1708278147;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jp6EXQRuPCFGDweaQpwiHQvfY2WuCwKaje05aNYOgiQ=;
        b=iVGBQeH9kaUR866wj+erkq1IEU9wx4W8EEphL2+Gw7QjW0g8CH96Bz5y1J5juPakpM
         YNO19mMxsokwu04/5l11pGmx3MOwaujmsvTJqxSFrBzE+08uV9TCW0FFHQAfHSPufTCR
         UXlM7XYvK+zbxRI8VWaBd8J0l8+rAbdDJUWvB5lBBHz3T66WFyteZLyrhDuuJ5GZ5VA6
         sPZeKQ34OK/0MJC47PpU+1No66zkbej4zqhRwS2lJUlvoGbPXBB7MoyvWuPgxnu+dSb2
         VbF0pWfO/n3MvC6b8iBThxkrWR2hiTIoQpPutBhwvN41dEWqcagzaE6eLku0LA977eta
         pOXQ==
X-Gm-Message-State: AOJu0Yz9lTJj4Y63H+iEZQm0VB/5s3tb2AWBR786rQgw5FO+wwv3nM9R
	KNZYHTdALAElVUnsUZyfcs+sA9b/9DUHN+wvIWDjJvzftcaXYzhd
X-Google-Smtp-Source: AGHT+IGtQv34Szy4QwQu8X3UKisdslqff/rOauoK6kL0+aQO4xddM0vKdVaRZGSqLLYkBunEICIWYQ==
X-Received: by 2002:a05:6214:20eb:b0:68c:67c2:6580 with SMTP id 11-20020a05621420eb00b0068c67c26580mr7135723qvk.31.1707673347647;
        Sun, 11 Feb 2024 09:42:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNAMBdxHV9ZXHZEzhHyXGuFr5vYF0eEmqG61DdAWiyMVs87Cd3te5jd9RLjRhcfMeKE/Il+vxQdl7BRGTuYVyIMgxVmnu73bEM4o08inBDTHsteXmfpM9kkrLDNVaR/RgVg7hn62I3pLsmZrr/B2d4CyQAe+XdIcDrQNJJLhAQy7L/pNzAookPwesTTrVv8ZkSQIgq/vP7dAiDif7KpqB5tMFsNZhQBcP55iWfiuue5fqNHO53ReB1VrZ4qc4miBh1Npu5jh2v5CyKM+0tAfcKdg==
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id qn15-20020a056214570f00b0068c4aabcdb6sm2856703qvb.29.2024.02.11.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 09:42:27 -0800 (PST)
Date: Sun, 11 Feb 2024 12:42:26 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andy Lutomirski <luto@amacapital.net>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org
Message-ID: <65c90702da50f_178c3c294a3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240210230002.3778461-1-vadfed@meta.com>
References: <20240210230002.3778461-1-vadfed@meta.com>
Subject: Re: [PATCH net] net-timestamp: make sk_tskey more predictable in
 error path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
> the sk_tskey can become unpredictable in case of any error happened
> during sendmsg(). Move increment later in the code and make decrement of
> sk_tskey in error path. This solution is still racy in case of multiple
> threads doing snedmsg() over the very same socket in parallel, but still
> makes error path much more predictable.
> 
> Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  net/ipv4/ip_output.c  | 14 +++++++++-----
>  net/ipv6/ip6_output.c | 14 +++++++++-----
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 41537d18eecf..ac4995ed17c7 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -974,7 +974,7 @@ static int __ip_append_data(struct sock *sk,
>  	struct rtable *rt = (struct rtable *)cork->dst;
>  	unsigned int wmem_alloc_delta = 0;
>  	bool paged, extra_uref = false;
> -	u32 tskey = 0;
> +	u32 tsflags, tskey = 0;
>  
>  	skb = skb_peek_tail(queue);
>  
> @@ -982,10 +982,6 @@ static int __ip_append_data(struct sock *sk,
>  	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
>  	paged = !!cork->gso_size;
>  
> -	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> -	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
> -		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> -
>  	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
>  
>  	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
> @@ -1052,6 +1048,11 @@ static int __ip_append_data(struct sock *sk,
>  
>  	cork->length += length;
>  
> +	tsflags = READ_ONCE(sk->sk_tsflags);
> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> +	    tsflags & SOF_TIMESTAMPING_OPT_ID)
> +		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
> +
>  	/* So, what's going on in the loop below?
>  	 *
>  	 * We use calculated fragment length to generate chained skb,
> @@ -1274,6 +1275,9 @@ static int __ip_append_data(struct sock *sk,
>  	cork->length -= length;
>  	IP_INC_STATS(sock_net(sk), IPSTATS_MIB_OUTDISCARDS);
>  	refcount_add(wmem_alloc_delta, &sk->sk_wmem_alloc);
> +	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
> +	    tsflags & SOF_TIMESTAMPING_OPT_ID)
> +		atomic_dec(&sk->sk_tskey);

Instead of testing the same conditional twice have a local bool,
e.g., hold_tskey? Akin to extra_uarf for MSG_ZEROCOPY.


