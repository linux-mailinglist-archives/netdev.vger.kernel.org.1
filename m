Return-Path: <netdev+bounces-176284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AEFA69A00
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3157AACEB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4C22147ED;
	Wed, 19 Mar 2025 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="A/YtrUwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217FE1A072A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415032; cv=none; b=NlK+6M+HedGSmCREAQEKPXDwcCFui25bgPlzlC6qz0RBUTnTddgV2CcKGGVNyENABvPr4If6XkHGXmm0W5Rb7mVJ4a4J/rmlomL1TJaX1wxz4Nm5YdlyILPxmAI+7KZIs9+hBMVO7+0ClwCZXz/6nnKXGUqZ25EkikHxfj6/hzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415032; c=relaxed/simple;
	bh=vVZNcEldGhErQzhychdSjKJkRDHaf5oXhzK5hCpX2Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOdB/ZpDw5HORkrjLxmg22wBf0YlOaDnRqyY/+BlO8YZke13YrX+xa7+k6YpVyYvCha8kbAHitiFyxxHe8dHJ0x6rUclmaP+YTnj/R/2FxnBLTTzVI/J5/1XxUSTgkmSmneH05mquRH2yI2FaBv81rb97IO+0PHKFGVgoZMa2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=A/YtrUwG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30185d00446so84688a91.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742415030; x=1743019830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEtyN/8iItZX0k96FPtUzWxAFcWBC5d55M1vhm8J8RY=;
        b=A/YtrUwGjIJsIK0FJ8JcNF1C0K6vgEzwuVqjRkMsH8HsUvYz/KvDG+ylAE67DGS8cS
         VcHH5YIDuwYiw+Yj1s5lxFB4xYokSsuUGR47VRIAIczqmBf10WtUoICPYVi/qre6P/RW
         W8oZgJrp53w/Gs3YHdTzvoCuL8DhliOei387Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742415030; x=1743019830;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEtyN/8iItZX0k96FPtUzWxAFcWBC5d55M1vhm8J8RY=;
        b=e3prardkwfbtAW1ZxAjAfsCJIpg8Gzwow+aSc5QzMun7jP5dwiTfy9qsAuypZS4ZBZ
         X859OpaJ9D6pjguh1ho0Pq1NN+jcwIpioNPJj3lXihgNVLTwe624ZMo4sbG7lDZ3ZFaB
         YhrpcoRvR95rJzzURFoUsJQa96sK4p0pfStkoi6C2KhvycUTtxJpaWtI01olt5YFXa1r
         LoOPiDCxYY7vIz55WbifBt1xFBtxehkx0gkIjRpiIq7XgMwOmjGU1GBq0ajseU9KkY2J
         aZJiA15zUhEfaktXZE3WOAmLdgmNob8nIzslLnO99IV7CIV57ZmZ2L04OVDywR8dyzhu
         V83Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB0mnEY0R2yjeWKaQj0ynM+9COzq+B18tjwy3q/Xm18H5LU7YfH6h9o0DzzYdjrRqfnqjaa+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrfEXoOsYS8ShmMEqjd648mTgPoSGDNdAlDa9056NRQuFuB7P
	xrSY6RozVYr1T11eJqMrB75G6uQdMeGVthABieNJN9gPPsvsqluSjYi3GyuI2Gs62/b9Sdn1ROr
	q
X-Gm-Gg: ASbGncs/Ky28nQNsJmxPwPNLJJjOrvFTJWC8mBzWz4litpEY123aAB1jGIICDeVUaG+
	IASq2rZtoBShp50KBuKZF80STKnf9hoLtIBPTsHDIlU616jSHbRaxG1qVVnHD3SmIhE9wfmzn/G
	7n/XYWslME/4DC1hXqr7IcVlpd0/+nj8SQZEcz4Q9VmwgifgkjvlpAApojix8trMS2U/h2OpVw6
	7lQe9q7zJPtDjLhLhWeWfWNqIgpUal/7sklVR/GrbAjkAy66rOXHKY4CrVln48GN7IFh7IeCGSD
	x7Mjl+y1habw620R8kDWhL6NXgwodiCl5SIb7gJNNSESvY1SadbKor4C0h2wikd9WEvFNuUDKs5
	XQMUBFaHR1ZIJiV3BaK8FfoQI04A=
X-Google-Smtp-Source: AGHT+IFYLxVyUqkLnV2m1VRjw9PzOMK+Xq+FeIEXzbiMp8R0mTZXmDwpyjpsyHGwLtXhjq0xg5cazA==
X-Received: by 2002:a17:90b:528f:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-301d42e4d3dmr1380853a91.8.1742415030368;
        Wed, 19 Mar 2025 13:10:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbffc2sm119374975ad.162.2025.03.19.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 13:10:29 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:10:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netpoll: Eliminate redundant assignment
Message-ID: <Z9sks79ntumxlsjP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250319-netpoll_nit-v1-1-a7faac5cbd92@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-netpoll_nit-v1-1-a7faac5cbd92@debian.org>

On Wed, Mar 19, 2025 at 10:02:44AM -0700, Breno Leitao wrote:
> The assignment of zero to udph->check is unnecessary as it is
> immediately overwritten in the subsequent line. Remove the redundant
> assignment.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 3cc3eae9def30..4e1dba572f5ac 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -433,7 +433,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  	udph->len = htons(udp_len);
>  
>  	if (np->ipv6) {
> -		udph->check = 0;
>  		udph->check = csum_ipv6_magic(&np->local_ip.in6,
>  					      &np->remote_ip.in6,
>  					      udp_len, IPPROTO_UDP,
> 
> ---
> base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
> change-id: 20250319-netpoll_nit-6390753708bc

Reviewed-by: Joe Damato <jdamato@fastly.com>

