Return-Path: <netdev+bounces-162454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D946CA26F66
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F81886F87
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52120A5DF;
	Tue,  4 Feb 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqLPdWsf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185745CDF1
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665628; cv=none; b=ItiMyO2m5WsYiXq8VcCd2LsTJLznNIaHVswudXeAFWRKDeADMXmRsnak7wO07mmSFdKEnX2HwAEsiuAKUG2sQzqHc6dK9Jh6FjM25s2dyRLmFg6qDCcGWCAxllZRd7oQcjYdcdYx+CXksFbWCqQxORQRc/zGpCBWmasMl55N8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665628; c=relaxed/simple;
	bh=172cUWlhoQgNf/Z9lM1RjxC+OqlWmgKCVShfli6QUsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLKhlS6oVuUu6fIKNKSovyYVWu9aRX0AT1/t52ZvTJCUX9seb5tBu3ujbOjtpynGAsm3YxL/RGA12bzmXht9NxuwTj3xlYc1sEvzGlj5h/1zo3117l2XjAYMbCFhtXA3XnSEF+KbjsLzvu6hjFXMqEdUEhOd8HUhi+MYYMo0B/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqLPdWsf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738665626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCFgA/QhpVNocdNIuyeEH/cghaHxUWNYBCCDRrHvU7k=;
	b=NqLPdWsfK3F7oivtsfrFEnM/TwvDMsadOk+LGpRDGQXPOY6k6cUN8FpDMmdCN+MZifR79/
	RsAuAXg3QxyH0vW/WKpKTAB9ZFcAyubScTQhR2VB+xf0s5Z7zw+vgpf7EWvOlXwHugkp6X
	w45UQYLctpWLjR7YT8OimQFwiQH54TA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-uudxXtXvNXiBt5jQHK4z9g-1; Tue, 04 Feb 2025 05:40:24 -0500
X-MC-Unique: uudxXtXvNXiBt5jQHK4z9g-1
X-Mimecast-MFC-AGG-ID: uudxXtXvNXiBt5jQHK4z9g
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38bee9ae3b7so3556350f8f.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 02:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665623; x=1739270423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCFgA/QhpVNocdNIuyeEH/cghaHxUWNYBCCDRrHvU7k=;
        b=BNp2yaIMBGNvjDd4k2OrriZWYVhQGZrYZwwGq5D8XK818j0H9b1W/dqJVXkQHsL4zD
         Xp4rsi7d8334jJwhPRrC2LjSkhmEaR+q9M0yyOq/uRhYOZnWiHJwLJVQ0g2buEaCqUC4
         11y89+HK7QbTLsftX4KEl4GFQFAl09emnb3UEla0kz+6MaMFccIzufdvVfl5/lQc5jfj
         dt7nopLjDsMNPpIA+gLJdvjlfBbVO7KqTalRAVQJfy4zqh4W+vAbv+TRa37pSxdb98Sv
         q7pl7u9tIJhsWMdwbcUa6GkbDuIEoNZor35wOTtKTPNTDy+u01b91rRkmlhH3iDhZUkR
         WhPw==
X-Forwarded-Encrypted: i=1; AJvYcCWuqU7cP66SZKFvhZ14YREAWu2BdInyX75choGgeMn+vei44o6qxdnkxq0q6YKXUHEbevokhoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXzf8cEyXUqvV/HtxD9mGHJcR7absjhNeNLi4jGHDvUgas5ML
	G8+uYUfoApzN6rzhmu+8HisGDk/Dkv+q8jdBhjJLSheXMxiZlSbh+wVf0pWCsfkjRWsqgA+i6rd
	9PTzBb+BQ5VNzVjD3MiZSf1BRnXpBiJJflLJE7lfHet61Vf/X0GccMQ==
X-Gm-Gg: ASbGncvuviql6FaNqmZdmqtVXzBZDOwomIrcPWQ+HFZe6dzKiCB68X9sLCyYtk7s5h0
	YeaGEOX9CxOPfr3Rw2UR7z/zNInRL8nydDCRWUpCq2GAbzTOCUsBse5ONydrgsseEly6XLyYf24
	TFdlkXZqs9I4PXThJdNhC/CHSiCEc+9Al43U7MQz8M7p3OqRQNmruw4HHAV+eN4c7v7gRmSoE4W
	Du2LA82dk9T51D/pi9zWLWQ8XqxO7rrjBAEg1SMaDLLGhJYRFAN+ZtF3TML4RD3zmpAk4QcF4GP
	1utY6nt+5thT33Sulhsd8eSR79rpfIZa8do=
X-Received: by 2002:a5d:584e:0:b0:38a:8b00:6908 with SMTP id ffacd0b85a97d-38c520b0b23mr22055239f8f.54.1738665623495;
        Tue, 04 Feb 2025 02:40:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUEIF09zz2Q0ae7dPZVMSCm1S5VnN6t28UpOZM4XPVDSCDcccMxy8E1ydHF9KTDFcxhKre4Q==
X-Received: by 2002:a5d:584e:0:b0:38a:8b00:6908 with SMTP id ffacd0b85a97d-38c520b0b23mr22055210f8f.54.1738665623166;
        Tue, 04 Feb 2025 02:40:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43907f1b570sm12259835e9.1.2025.02.04.02.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 02:40:22 -0800 (PST)
Message-ID: <914e488e-af7d-4301-8be2-410db5325f14@redhat.com>
Date: Tue, 4 Feb 2025 11:40:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/10] net: pktgen: fix access outside of user
 given buffer in pktgen_if_write()
To: Peter Seiderer <ps.report@gmx.net>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-9-ps.report@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203170201.1661703-9-ps.report@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/3/25 6:01 PM, Peter Seiderer wrote:
> @@ -806,6 +812,9 @@ static long num_arg(const char __user *user_buffer, unsigned long maxlen,
>  		if ((c >= '0') && (c <= '9')) {
>  			*num *= 10;
>  			*num += c - '0';
> +		} else if (i == 0) {
> +			// no valid character parsed, error out

Minor nit: please don't use C99 comments, even for single line one.

> +			return -EINVAL;
>  		} else
>  			break;
>  	}
> @@ -816,6 +825,9 @@ static int strn_len(const char __user * user_buffer, unsigned int maxlen)
>  {
>  	int i;
>  
> +	if (!maxlen)
> +		return -EINVAL;

It looks like this check is not needed? strn_len() will return 0 and the
caller will read 0 bytes from the user_buffer.

> @@ -882,39 +897,45 @@ static ssize_t get_imix_entries(const char __user *buffer,
>  		pkt_dev->imix_entries[pkt_dev->n_imix_entries].weight = weight;
>  
>  		i += len;
> +		pkt_dev->n_imix_entries++;
> +
> +		if (i >= maxlen)
> +			break;
>  		if (get_user(c, &buffer[i]))
>  			return -EFAULT;
> -
>  		i++;
> -		pkt_dev->n_imix_entries++;
>  	} while (c == ' ');
>  
>  	return i;
>  }
>  
> -static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
> +static ssize_t get_labels(const char __user *buffer, int maxlen, struct pktgen_dev *pkt_dev)
>  {
>  	unsigned int n = 0;
>  	char c;
> -	ssize_t i = 0;
> -	int len;
> +	int i = 0, max, len;

Minor nit: since you are touching the variables declaration, please fix
them to respect the reverse christmas tree order.

This patch is quite large and mixes several things. I'll split out at
least the strn_len() caller fixes (possibly even the num_arg() and
hex32_arg() ones) and the refactoring in pktgen_if_write().

/P


