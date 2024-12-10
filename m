Return-Path: <netdev+bounces-150623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C549EB00C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09D8165EAE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850E2080C5;
	Tue, 10 Dec 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ay4j4Tnx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E31DC9A3
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830933; cv=none; b=P6j7vsJ49Qm6FoE9kvr5DFhgibf1SCgxmqkJm0Kil5Mkllz6qyPdKK2G2466T9NKdVlrEYBhlknZO/jrqCJS0ia4L69KfoRKhQ3Sm9qaQCzJzuvGfOhXKQNu59waWxhtEzSZJWoCdOXhFEG0x2QJfpCBd/3JrKMJZYsPyFXlrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830933; c=relaxed/simple;
	bh=Kf+XaQh301G2du7bqM56wTgw4yTqR5jN/wVknxGkc34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrWnjiBYDYjQtIXNJAgeRiGBwPTmIIjFXShwp4PffTKieMlTZTg7bxSp/ts60ssm1UbAclZ06DK4nxmCQHU0WO5gDkVbVJx0ZVBpw9mHjUCrJNKiLWwPVApYW8+WZ5gsC48Z/tTKjMljwGKMuJKfp2LN6OfAhQEIrRQzloFsTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ay4j4Tnx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733830930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/yLIg29ibVy56zdYGMACVmoilm9JAC9U8DHbAa4M30=;
	b=ay4j4Tnx3IN5Buewq0uN+xA3keeKtEWgcnmKdMx1j0eMCoj98DlF8TM3PMcAt4wjcX8r6R
	LTPVKq3ttXrSa+P9FtFShlzhQUvQ4cpN3BVF53AD9nNo1ol2IZbc6e/iu/Nsmu28BAME96
	+l2hwqoF+UY0EAcCAbqOvjQtYQAFxhs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-T25v_U6uOyeblRpFFqK7Zg-1; Tue, 10 Dec 2024 06:42:09 -0500
X-MC-Unique: T25v_U6uOyeblRpFFqK7Zg-1
X-Mimecast-MFC-AGG-ID: T25v_U6uOyeblRpFFqK7Zg
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6d04a0c4bso256418585a.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830929; x=1734435729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/yLIg29ibVy56zdYGMACVmoilm9JAC9U8DHbAa4M30=;
        b=kCO4KA6tIKZTXUhfM+zZ5IS7EitLxCYtzccTeruK/TwekHknJ1pHyA9/rTbs6bw3dM
         j8cmiiZSvdD7vuYZ7+fDD7adocVJYu0rWqDWH/UTz0ykHQf+flhFuPmtSHpr9MAl7BXY
         7IZ2L7JYq8kfJU3Xfzut9+qKdfWTP9rhXnNf9J+3Vvtp0Sql9VRzZdyBVFANU1YVRj38
         yOuM/E44w7KxJwgJqyJCK2ivlQ50eXktOa9xTciNWE5Om4mYYsC4y/vkFxF3ZIo/0HM+
         o7BspC1IVOBY+5n/4VnyhLt6ASP4xkl3uq/0pn/ODxTdjc+m+Gqa2mem9wZuiVxHVwty
         U/yw==
X-Forwarded-Encrypted: i=1; AJvYcCVLs4wAM+k3y0lk/i7hG7uwF04bDxqLcPAgK15w8uLVfgWp/nI/tt17rs6ubKtu0A+fXl/x4u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjArewxcoKQwAskU5Epzx7bsAkCdgt16rEM0vjfL+Mb5a7MDP
	/IK9AKIHeFgw00DXSZxGTqht9NyueZEiUJDPOmnXqgNJBw7Li+I9H64LFz25+T+s07JXNUSCmjm
	SXCkg5Vkt1JvqlHUwAou7Wi3amstYDmpUMXbmxbfeTpdkH/iAWnO5xw==
X-Gm-Gg: ASbGncvLojL7DwF2oytKYPepcH38Pm4NAq/OtQjb9B7trZa5Vks0RUBASMTNnrp7th7
	PGg+uC1K8B3TPQ/8DD//pMgw6ybEoi5rXpcS4PmZYFkArp/zUocJsyzcUo2gjIhtbWXNbUN2jQu
	40qmVj9jqzm9quqn9nqmDkWAAhk1V2BMLK+fuhYA5LY0xY2f422UoV3Y/czr2ed+0rUUUjUqYmH
	deg/vKfSUNC0/Gqstc500o5lFiRoxbuA+O6sgh7oWtSJBkuRAFuq8kFUKQI2yeeQHUiR1cNHpHG
	GL2sEqK8AaV9Zf7RSvy7Z0CWlA==
X-Received: by 2002:a05:620a:650a:b0:7b6:c540:9530 with SMTP id af79cd13be357-7b6c54098bemr1849068485a.25.1733830929061;
        Tue, 10 Dec 2024 03:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzzxp7sJ51T+7GFfeRG4XPl1Yu9jlCFTax9tvuYBU9T/xGqqXFU3cGBxZBqXFAJEU6UoG/vQ==
X-Received: by 2002:a05:620a:650a:b0:7b6:c540:9530 with SMTP id af79cd13be357-7b6c54098bemr1849065785a.25.1733830928675;
        Tue, 10 Dec 2024 03:42:08 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cfba1728sm252497385a.46.2024.12.10.03.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:42:08 -0800 (PST)
Message-ID: <f2b838e4-1911-48c1-9a7e-fe476f763def@redhat.com>
Date: Tue, 10 Dec 2024 12:42:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 14/15] af_unix: Remove sk_locked logic in
 unix_dgram_sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241206052607.1197-1-kuniyu@amazon.com>
 <20241206052607.1197-15-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206052607.1197-15-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 06:26, Kuniyuki Iwashima wrote:
> @@ -2136,27 +2133,21 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  			goto restart;
>  		}
>  
> -		if (!sk_locked) {
> -			unix_state_unlock(other);
> -			unix_state_double_lock(sk, other);
> -		}
> +		unix_state_unlock(other);
> +		unix_state_double_lock(sk, other);
>  
>  		if (unix_peer(sk) != other ||
> -		    unix_dgram_peer_wake_me(sk, other)) {
> +		    unix_dgram_peer_wake_me(sk, other))
>  			err = -EAGAIN;
> -			sk_locked = 1;
> +
> +		unix_state_unlock(sk);
> +
> +		if (err)
>  			goto out_unlock;
> -		}
>  
> -		if (!sk_locked) {
> -			sk_locked = 1;
> -			goto restart_locked;
> -		}
> +		goto restart_locked;

I'm likely lost, but AFAICS the old code ensured that 'restart_locked'
was attempted at most once, while now there is no such constraint. Can
this loop forever under some not trivial condition?!?

Thanks!

Paolo


