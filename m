Return-Path: <netdev+bounces-95393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA58C2262
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DA91F22678
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14A168AF6;
	Fri, 10 May 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5tN6W59"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DE14F137
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337907; cv=none; b=svKlHxYaxO8DDC69xQzQMZnNOoOwAWUyIjtcVyEoBhz3+5WXyaXizv6IpNSirjUpIIKtbcPYwb+Rzr3W7Fn+Y0bjNzXNbtArMnI1YvvjoHOzXKIkByuipovYSl4W+1rqTzHhqmgvIGDe991j4Wd6pmiX2MxR08K2q0FU5QftrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337907; c=relaxed/simple;
	bh=tElvt9E9NwoA0Oby7fn+mx7nnO8ePSqi5CcDKYc3gtc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZAXJq+/8I+CQ2ZMlitpt+qv+3UkZx0jfc1XHC+S6txzz7aEaQbN5P5r5skn3fwb+mSG9y4cGeCQ8Xfqlvlnzaj2SgKyPU5GCTwMZKSw+wv8y7xUlrMQMI3Ed9TGKzDNY1/O6eMb7sFDSkLI+pds//V2BXVr/ypV06UlPOBnlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5tN6W59; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715337904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DQHvF3/d4yTWRc0yVCYlLMPgiw6iLg9rAcpFg6/5oLE=;
	b=i5tN6W59TkRG0oBCzIM/X6wYPFrPwHLhJ57CiwuD1V50Ki0umeJJK4hxNn/sC6186mochu
	Mi0lG6d/Ei++cQYYDCUfzCYdv6nrC6DpLCMD3AY+4rccw8N44dQ/qbqOhhhOdkRpJjvz6i
	fZ3QmcBoQ6AGcbB2D3a1vlJeVnsFEe0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-m4p2e1wmNB2eQcqXR9NDtA-1; Fri, 10 May 2024 06:45:02 -0400
X-MC-Unique: m4p2e1wmNB2eQcqXR9NDtA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e226454713so3154821fa.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715337901; x=1715942701;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQHvF3/d4yTWRc0yVCYlLMPgiw6iLg9rAcpFg6/5oLE=;
        b=foZxPgfmGrAT/tXqzyI27wzJMuk8ounU3AIBm66mZlORHAFtTI7/c0RimRKuQasDQL
         4kdNRLXvrn5LTUJ4UipUoxSH2hHfzx5gPLr8iYLCq2MmGVtys6q0StOo611l25ukkao/
         lHapzbyEnZO4J39mwNjYYTfCGJcYG8L7fIDTGD0lGLD+nCRMTB3b+k4vh/0Qis/zNy7v
         qNpabKphvcWOPHfATRIwkybQBwip/DvmBMaOSpUxar3k7EVDlK+rbRdMAvtH4DZMDF43
         PREgDPb6AzCwQZtsx7Rmr6FpegFHhB4J9EAa4TTMCD5Au496YNQBMGcUV/6Bvtu00oAW
         C2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQad8l58FQiHgjto83vmqhAYLg4xJvUfHOgc76bSGLskWxpeAcnShsSi6V5uhjInC7X2XSx8uhpO1nWK+UoPhrvvLJIQ3O
X-Gm-Message-State: AOJu0YyuqYJuYMNhLaZ5K3bldoapMIzoqVKsnzAKpdHZlmp1x+uANwO/
	QWwZNkgsgzBMb1soJ4ctsFtzkMIrHv1KL26EOPT/VPqYXjr5GyQ+ywh1tQgmcQ8EHB2RS5SOhAe
	DbL61ZbMe1WRtkbjMNiolOAkIXtL2qDOonTafZlyOcJN8HkaWmzjK6Q==
X-Received: by 2002:ac2:48b3:0:b0:51f:6d6d:57b with SMTP id 2adb3069b0e04-522105844d8mr1320911e87.6.1715337900884;
        Fri, 10 May 2024 03:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgHGURYiLcIqGuzqHgU2H7Fg7EFX0ig8rjhbIGAd6iaufiXH6/CpxT34q9QbJ7SpJ5osUNXw==
X-Received: by 2002:ac2:48b3:0:b0:51f:6d6d:57b with SMTP id 2adb3069b0e04-522105844d8mr1320891e87.6.1715337900378;
        Fri, 10 May 2024 03:45:00 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92c7sm61231035e9.34.2024.05.10.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:44:59 -0700 (PDT)
Message-ID: <6dfcdb8b562c567995ae9786ab399a1f3a24c62a.camel@redhat.com>
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Billy
	Jheng Bing-Jhong
	 <billy@starlabs.sg>
Date: Fri, 10 May 2024 12:44:58 +0200
In-Reply-To: <20240510093905.25510-1-kuniyu@amazon.com>
References: <20240510093905.25510-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 18:39 +0900, Kuniyuki Iwashima wrote:
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0104be9d4704..b87e48e2b51b 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -342,10 +342,12 @@ static void __unix_gc(struct work_struct *work)
>  		scan_children(&u->sk, inc_inflight, &hitlist);
> =20
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> +		spin_lock(&u->sk.sk_receive_queue.lock);
>  		if (u->oob_skb) {
> -			kfree_skb(u->oob_skb);
> +			WARN_ON_ONCE(skb_unref(u->oob_skb));

Sorry for not asking this first, but it's not clear to me why the above
change (just the 'WARN_ON_ONCE' introduction) is needed and if it's
related to the addressed issue???

Thanks!

Paolo


