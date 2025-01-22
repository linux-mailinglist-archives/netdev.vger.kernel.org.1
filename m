Return-Path: <netdev+bounces-160300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E6A192F0
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC257162B46
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDC2139A4;
	Wed, 22 Jan 2025 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPqmzRd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE3212F98
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553857; cv=none; b=gqhf03meMuBOLVUn7Yx1IkrbJcYucT+p8qNxDgVVnKtWQl1IkMMmV06svcq8GnHmsXBYQq3Ms1YtKQIITlWFfhDCtmjHyv0j32JeFpv6wxEPB2uyFe7bysBALg/Fu1L4AkDZRQ35orgSlUyuH9oWn88BsNfP+h+H/p3SyC/BQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553857; c=relaxed/simple;
	bh=bks+dcymjfuxwpQMDs5ixSXGxUexUIw8mAnKAomCojs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcMTt9jy4DQNMrF04Je1o0Y6ljZFI+epE6AlyV3kz3QGzxEjPrOmzdVP2FXU+sOkPXb1nXmb9EfSjpTqRI/H/j7BVls32u1YIygidWiLkSCYMy4oQLDD68pNp9BmXDXp4RP0QxSlkLzaBqReoCBrIhg7f9L0S/XK8ZdNpEc4cwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iPqmzRd7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436281c8a38so50829295e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737553854; x=1738158654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeJQbMKgxTKE/VdTo5M9qbk3XdSIS18Xn3c/OFMKt/Y=;
        b=iPqmzRd7baIPYn33C3KRXTrV+pCb463BW28fABHTx8ITb24hrWxLQnJ+nviGXhxSfY
         zb+MNO9VEUyt/GeIcQCdh5cwTsZ6u81oMDftOkRtWp/lDnhFKYQnv8PgEe3AOO2Cys7B
         jCTVTMoJsesIeF8nJDx29w/IAF3PGo4v/5WUkGHEeQUdwweIup2Lo6F39lGioVi+FYaU
         qdkSxs1lUrSSjJg/uW2G1+TTq7j6HfgEbqcPibjxY2ZJr/rQxJ1qvAQBMz/tsTGm7XpH
         xuvJnxFuBVBrO9Bv2ya7BYoQ3paWVENWcHjKecPQeljXyasJkXGBSqgJTE6UYddMZAvL
         fpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737553854; x=1738158654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeJQbMKgxTKE/VdTo5M9qbk3XdSIS18Xn3c/OFMKt/Y=;
        b=f4FVRb72PEJKZxs7qXX9ELBhXdJME17DQAackWZCv7Efm1+7+kxiR0xJhgxJIQw0tP
         evEw/IXUSxUySPjaHNhQWqVcmEpMsnJfyyTiv1Kg1p7GTy4/Kx5yuS2+wlerpD5Sa2b8
         a0UdS2SnHfnsPThpZnZUVjCQw4PDO2vg8tzOqSqQtLd6zX/j6lW455BWrvccyXE9YHp6
         CDeXV0ZLtyFOFKk9GYbQhWoQotR338aVKmaO1De9ej4XSckRBAQUOeGf7L36WpAZ/erk
         GWwdYkt853dhlLwdfSLWoVcQXryuhe+3PkpWTTCwc7PjaaRLfh7coJ+RVc6y0HOXEega
         zapw==
X-Forwarded-Encrypted: i=1; AJvYcCVnWoFDmu3UuNnspJomlMaj2UXIQLiYvbhDxW5JBMOiXy1LlJ5AtYcDsZY3S8K/0CCqE1airCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VzWnXXTuLWO2m6nfUSwAgmczw4OcISxRQQRvFE2joesdFndK
	Jbh9dqh+kvzVMDdrjD88HiLPXbKYXopebULN7FN42XlplK9xfKETYvFh7WObbm/dqnARw4EeKcm
	9
X-Gm-Gg: ASbGncscb9drRLIN+aQFKKJfvN6EZy7lUwnSVSMSZIjWGGsWVl8xgnHkhKtCp9kP00R
	wtOa1xjRWVYdiO3BpMlqEjg4CpSsv624WN97Ug9P0gCDCwqQUQmIBRwyXEowzUUtpBe868kBJzv
	IiR3gO1YoFSTTra9OC5Izj2hqud4IzEskYZuEuHEa7ZczqSd6iAQNQQGg946lKSdXM/ef+mS+m1
	xHeK9MtIMUcjXkYo54dkRX8DyHMeJ/nkWCZAFAjixDwpFFL9dpFzRDgTHBVyXNPVImVW4kwp58=
X-Google-Smtp-Source: AGHT+IFV7PIhFkke0uCO2oWIdMNtHM2fB8T0QZVi6jL0x9DpK6ZPV63ZMQQxSYMhiuEQfz57I9x/1A==
X-Received: by 2002:a05:600c:4e06:b0:434:e8cf:6390 with SMTP id 5b1f17b1804b1-438913c6856mr195769175e9.6.1737553854420;
        Wed, 22 Jan 2025 05:50:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b3189924sm26248475e9.3.2025.01.22.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:50:53 -0800 (PST)
Date: Wed, 22 Jan 2025 16:50:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] xfrm: fix integer overflow in
 xfrm_replay_state_esn_len()
Message-ID: <32890a3f-1258-4c03-86e1-86c0e4e8e415@stanley.mountain>
References: <018ecf13-e371-4b39-8946-c7510baf916b@stanley.mountain>
 <20250122123936.GB390877@kernel.org>
 <670272e2-a4b2-4bdd-95c0-26d1e7c65816@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670272e2-a4b2-4bdd-95c0-26d1e7c65816@stanley.mountain>

On Wed, Jan 22, 2025 at 04:16:48PM +0300, Dan Carpenter wrote:
> On Wed, Jan 22, 2025 at 12:39:36PM +0000, Simon Horman wrote:
> > > The one caller that I didn't modify was xfrm_sa_len().  That's a bit
> > > complicated and also I'm kind of hoping that we don't handle user
> > > controlled data in that function?  The place where we definitely are
> > > handling user data is in xfrm_alloc_replay_state_esn() and this patch
> > > fixes that.
> > 
> > Yes, that is a bit "complex".
> > 
> 
> I don't have a reason to suspect xfrm_sa_len() but if we were to write
> a paranoid version of it then I've written that draft below.  I stole
> Herbert's xfrm_kblen2klen() function[1].  Also the nlmsg_new() function
> would need to be updated as well.
> 
> https://lore.kernel.org/all/Z2KZC71JZ0QnrhfU@gondor.apana.org.au/
> 
> regards,
> dan carpenter
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index e015ffbed819..ca7a8152e6d4 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -1015,6 +1015,8 @@ static inline struct nlmsghdr *nlmsg_put_answer(struct sk_buff *skb,
>   */
>  static inline struct sk_buff *nlmsg_new(size_t payload, gfp_t flags)
>  {
> +	if (payload > INT_MAX)
> +		return NULL;
>  	return alloc_skb(nlmsg_total_size(payload), flags);
>  }

Actually, this chunk is necessary.  Let me sent that by itself.

regards,
dan carpenter


