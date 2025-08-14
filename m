Return-Path: <netdev+bounces-213751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B3B267F9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C07DA2654B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80B2FFDF8;
	Thu, 14 Aug 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHHBXEGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C33D3B3;
	Thu, 14 Aug 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178698; cv=none; b=AuMwG8TvqSid8ump9sk2xhYCZqHRsX7m9jxXWV3z586uqUfDEWdMI6P7brEkeK8xEAnCqCHY6UTYSm8ixYl+DkbAh0/2cRgotCV41hEuHXEwxvO9DK/gbuaJXr9LPq/dPTdSG7defYB2bG8l75m1r6qhChscTBZxbLQKra6XUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178698; c=relaxed/simple;
	bh=o9qk8uOfTrqRdBe3SDsQESSVu3+lhRsutZxsbnwPKLY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oDYD13A5o9JXNpO05OvXvNawKYsQd2e2bbB30Hz9DdcVdMh5zssP/97HV6W1O0SI7Gx45dczXa4kk1GK2qGCqHQDO6TiE/y4hOpyblEYCq2tdftpzUcb2/TLzMgU9YEb9gnp6lb5CAQExYvPe2LwOJVnHdpBN2Oc37Tab3HNmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHHBXEGa; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109bd3f9fso12396571cf.2;
        Thu, 14 Aug 2025 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178695; x=1755783495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGIc4nffFE+PrLDkgm6FVmeR04MphFi5PR2SeX2h40w=;
        b=aHHBXEGagcjLzrf8M1De1rN83KWsOOh8rlKKVe634bHGjMuCrc0DlqYTlVuaEidHML
         AQ0UdqYbIjLN66BL2ySwUIpzWqb+GhoGYJaJwxtl6gjA/YiWVOVuSN99qFRIcqOfwhun
         rvwckdgCFbF3pDziXV+IuueJPJ/QjH8ccx1lAr1f7vaS+XdK3SpXXLLE7E5Uo0mt3rpe
         ADc6acuMtQJeEbrDXqU/vbho/NMWR4jxL7VaE6feKdmTGtafzG8AX0Hwkdev8CnYh9tz
         Eyg8FUrIfGC4bv8BivohLF56Sm3NZiIeVeMEV8Agey9kQbBKU7uDJ0VjsRtLEJCpE5Nb
         sfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178695; x=1755783495;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGIc4nffFE+PrLDkgm6FVmeR04MphFi5PR2SeX2h40w=;
        b=sJJG9EIKSFSRbXZD/foCveH1a0IYYtntTcD7OeArF4nCx7d6CB1I4cjvcLr2WkPFBw
         LveS5Duf/gfGgAxxGnsqHMGjh6FPJAWfJ3B+Z4I4zc4y4Tn2FJj03gosxO+4/iEaXf+K
         wEvTykd6KMKxf9MfG3XofL0B04vAxUmM0w+Ka5jThl38BY4DE5/7dEwSQbZzFLjmioSS
         vM8nWWnQjMV5kpv3lhmniO6N+jEcf9pzMyqGisTjulQlIDPjPyQa1LL5cwSmTNvKB09K
         2Zfm/teqNTG2n2xGByz6NtiYr/SBCATpI3cSKkea6x4d3hMTVFdxpe60Nd1vTMSULMKL
         kq1g==
X-Forwarded-Encrypted: i=1; AJvYcCXHXrrtqN98YGCqsXu70CQrcRRx/c1kdqP3D7VMt9PQoW9m3nMNRyGEvVnwtIqhrW3962riLB5TQVAmI6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIo5ow7RcVF/burDMl5sBxLeLmlbn4bjUO3Arr3xqdBYQvXHrs
	yAu2YBHymwIiD+8tB1J0UichGfOPNi4tHv+un00M7qiEtO4BtYsDMmHY
X-Gm-Gg: ASbGnctQ6qctgmeuwmQSqf/xS5tltBnDHr2SkwWfjqWuzMw66/RZpCmdWZWp3ljZg6w
	zDYg7PSUxVOlBYMlZA6xezDTIk72RuHWsDu9EQPYjyNROrPcPzOuUoA0BzdEIEu1bGAZrsZ4F/m
	qHRdOIMQ21kMjimyeiqO5quERwDy2FBtEsKadhRtEWCrOrQNzy2vx3/2rZU9lUmtJP3vgGjY6Vi
	jWBbs5eiOWziaIjHWkZhj8XbLSYn8pcSQNvU8vjc7QpIGeK0aa8W7I5PIV6VqsOc3VQGSIsTEDb
	jz3zKHTCFMYaP9dGi9apg+FD05KIEk8DM0urYPJFRkgg47WFaDU0Pr262Smxs6CCXH2r1HtSrsM
	ORFDKKmMh5A9SIkqhkJ1/1YqG2Ek7h1DYir9W0V6zdbjFSHhXl5kPF37HVzxrCUevevMwBQ==
X-Google-Smtp-Source: AGHT+IHZiWOo/aney06SxA15+kwXyuNGIProzFRCP8gyiASlR9Q7U04w2jALrf0tITOm8chWl3+2oA==
X-Received: by 2002:ac8:7d0e:0:b0:4b0:78d0:dc44 with SMTP id d75a77b69052e-4b10a9aa389mr45565681cf.27.1755178694409;
        Thu, 14 Aug 2025 06:38:14 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f742e7asm2133120885a.71.2025.08.14.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:38:13 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:38:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pengtao He <hept.hept.hept@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Michal Luczaj <mhal@rbox.co>, 
 Eric Biggers <ebiggers@google.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pengtao He <hept.hept.hept@gmail.com>
Message-ID: <689de6c51e152_18aa6c2948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250814010111.15167-1-hept.hept.hept@gmail.com>
References: <20250814010111.15167-1-hept.hept.hept@gmail.com>
Subject: Re: [PATCH net-next v4] net/core: fix wrong return value in
 __splice_segment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pengtao He wrote:
> If *len is equal to 0 at the beginning of __splice_segment
> it returns true directly. But when decreasing *len from
> a positive number to 0 in __splice_segment, it returns false.
> The caller needs to call __splice_segment again.
> 
> Recheck *len if it changes, return true in time.
> Reduce unnecessary calls to __splice_segment.

Fix is a strong term. The existing behavior is correct, it just takes
an extra pass through the loop in caller __skb_splice_bits. As also
indicated by this patch targeting net-next.

I would suggest something like "net: avoid one loop iteration in __skb_splice_bits"


> Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
> ---
> v4:
> Correct the commit message.
> v3:
> Reduce once condition evaluation.
> v2:
> Correct the commit message and target tree.
> v1:
> https://lore.kernel.org/netdev/20250723063119.24059-1-hept.hept.hept@gmail.com/
> ---
>  net/core/skbuff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ee0274417948..23b776cd9879 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3112,7 +3112,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
>  		poff += flen;
>  		plen -= flen;
>  		*len -= flen;
> -	} while (*len && plen);
> +		if (!*len)
> +			return true;
> +	} while (plen);
>  
>  	return false;
>  }
> -- 
> 2.49.0
> 



