Return-Path: <netdev+bounces-224067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDDB80592
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29C954E29F3
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0B3195EA;
	Wed, 17 Sep 2025 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXsKyTIm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A3306D4A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121296; cv=none; b=IrbFBVAUlmkkQaJzYeXtj2sFVkLKMWSL5b3PI7w0Mei0bbthzUN+0D9F5DaAdtEwwxChaQ6JX26K5SRw4jgPNA7k/plSy9DNGIFVgK1dLmDabFi/sxIsx1rnKXVYpHI1rg3yQ1AnF4+OeOUVya0QdljBy+4dRRS43soJuOLEMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121296; c=relaxed/simple;
	bh=2qaQMC8FDwD+w9a/puBNV2guu8+XJ9dUkrMI2JvuZAg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iVje3WTOwslSposPZLX3jHOH0MyXBQ93LVGsRrfpmbedpHL+doX9biMNs/wX9bW7jaYgICxyQrBTrTOcgy9loVr8rXXr3/gtRK7rc6un270NrA+Q7UiKvH1Kc6r+E+opRlul1qDpgZt5ordlu3t/hGvJGSbC521EjanCVoMcROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXsKyTIm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-82a334e379eso233970785a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758121293; x=1758726093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxqWCMRYbZ/luGKuH7Ti4JvSxyQ3D+YDp6CKHkqJYek=;
        b=XXsKyTImM3lRn4zjbNFDosKQ4QjrZV+h8vKUuSbVgCCkoqD5gUX+QyMLKtbJD3Zy/f
         Cw8uf8HhG3gT3vwsQgZdefeB4Tsxeg8Wkj8ITWl/WrNV6/KBPskLZgMsSR6xKE4ajuw/
         OAYZLHjsTYcnGIQiwAnufGiytS0rSWjn5b2wdjhyINFjlUH3pvdcWBFWXfF2Rm0gnGKy
         LgiMdUMDXOCRO6kf2jKSCNIsWMLYvq32VBMcDzf5LaVvQ+P9Q9mrIjkyvw0MAOjEszk2
         cAykQhH33jsBm99Kwy2LNkMIO+49byDYt1RLtz/mAgR1grvfg3sdFcIUIXsSKrUKURCE
         U4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121293; x=1758726093;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KxqWCMRYbZ/luGKuH7Ti4JvSxyQ3D+YDp6CKHkqJYek=;
        b=k4mUQwi5vCWEQ3YNN8cyyiKPFTagoE+JsXCFj0XEww1aD0B/FzG0QiE5HMqgNlFx3A
         wUYiQMYRtZwUsCfU2cv1bsdfVUBqCRdJ7YWJh5T8pqQGrYuCQeg7bODXPLEN0Tn5xPCf
         D7mhwCSYU2yy29ZMXPucMTFii9GACbj1PaQHeZwLLHjCC2w6vLPsW5LDb1NHnhKZMWL5
         xeXoZDXOhvvyi6AsPrjrIKuiFz6pVx6463MzDFjlnMYMfhpoZm22b5JRP+tVIZIie/Iw
         CgNfIKfIS8m+YfpxFGg3SycwREtxfe2OtS3HrcVTGWj3LIcz+giQ8Z+fr69oJdLHkOHh
         3Geg==
X-Forwarded-Encrypted: i=1; AJvYcCXeKlAIWIN2TiLSdxxIIoI+ez4aSo6kpgYYFrj+3N2sTfwBoSezsUKGyIEpOKo8OuXjl2t/arw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp453wn0SczsDSBih3GOvy5HEEV0Gd6n7xQC8hOMP4HsWBxabX
	bkk4YoR2FvJs0V4XRFgrjoIB6ZN9L1tSlc6cK3E95KMuMyXtBi4zYTI4
X-Gm-Gg: ASbGncsHzokePyzCBwZKH/1j4czY18G37UD93+JPGMB5L9IhQOS8/0h8V9F2JGc97j7
	0B1qXeX2E+y7SmOczqvYt5ADyF/wGMxvxwZKjt/jbzfwQx4x9z+BAb+W9RNFsVX+dRBCCJqVWX1
	Ks1Pjh07JMmx3kVPLY4nuELzC/inNNoW2153QyA44/zKWdXGz+VEslFb5O5JEdC1miTXKwwVrp3
	n1oJZTG0h/bxzHBxbJLAdb7KXlpccpaTHsxYkqDjsHU5iVYKRo0nilQDCefWq3CWXRjfPFKa5ki
	+s7rZFUIBE5joqIYh7RoYbr2GjRlaUAGyUZtSi4wyB2oLH8sVW5ysozPku6a93Drh5/Vty23tol
	hqPDzcN6VUbUGGZo4AjZi5c08jb4p8NPzfo7vdxRv05yvBUMmw55MvsbNv39i6nE=
X-Google-Smtp-Source: AGHT+IGVDsjAZ2jhOQvhWEZLfteQqaX1QmfjGFrqH7yRSNohu5Yk5qTkSYX2dqzXKmNOOtuCkr3H2Q==
X-Received: by 2002:a05:620a:4044:b0:80e:ce0a:404f with SMTP id af79cd13be357-8311053e3dbmr187570785a.56.1758121291533;
        Wed, 17 Sep 2025 08:01:31 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-77f44157463sm62195476d6.2.2025.09.17.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:01:30 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:01:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.111bed09b8999@gmail.com>
In-Reply-To: <20250916160951.541279-7-edumazet@google.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-7-edumazet@google.com>
Subject: Re: [PATCH net-next 06/10] udp: update sk_rmem_alloc before busylock
 acquisition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Avoid piling too many producers on the busylock
> by updating sk_rmem_alloc before busylock acquisition.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index edd846fee90ff7850356a5cb3400ce96856e5429..658ae87827991a78c25c2172d52e772c94ea217f 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1753,13 +1753,16 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	if (rmem > (rcvbuf >> 1)) {
>  		skb_condense(skb);
>  		size = skb->truesize;
> +		rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
> +		if (rmem > rcvbuf)
> +			goto uncharge_drop;

This does more than just reorganize code. Can you share some context
on the behavioral change?

>  		busy = busylock_acquire(sk);
> +	} else {
> +		atomic_add(size, &sk->sk_rmem_alloc);
>  	}
>  
>  	udp_set_dev_scratch(skb);
>  
> -	atomic_add(size, &sk->sk_rmem_alloc);
> -
>  	spin_lock(&list->lock);
>  	err = udp_rmem_schedule(sk, size);
>  	if (err) {
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 



