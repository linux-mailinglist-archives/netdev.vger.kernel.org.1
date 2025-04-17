Return-Path: <netdev+bounces-183613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F7A91446
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F92A3AAF31
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DDA1BC9F4;
	Thu, 17 Apr 2025 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/qq9wG+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FD154430
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872371; cv=none; b=Yv2BomncH5/TQwvUVCAvOg/+QqO5VT5SHy1Wa4qLyJCQYcPEIhq5jfAFyJbaZgltrK/9yeI2Hi9Z0dZqUIdLvEc7x06fHmY+cza+7YHRrKl1TbKLxYpzGIiDIBXAjbEbO3D+znMF0JMwuYs1wMAsJ4hbShl727HKqm7QCnql84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872371; c=relaxed/simple;
	bh=JIv27Rg0aVzKYIq78qQDtChjbuj0DrbTQO9XUaPYAAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocxIqhu76l35NTPdAdqhwlOqaV0itR6xZ5Qkmm7DpH1hluhBQ/XjTRh/lOJB42MQvRiEKT6OYizJwHgCYV29ZpGApKXZPT0TnWWL6HCaynu5EXHt9ySU8f5/TX1PhKdhF2FItK/jaqMwrGXMUyMyAHLxvkjKRdPXyMyzo+K8J+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/qq9wG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744872366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnSxZovFrg9CXJ8gi0BUAt1W20GbgH0zF4GHBXAvP6w=;
	b=M/qq9wG+A7vHzm1WZb2nCMtZoRulHSjt+nd9NE3wGZmr4E7j+3jk57pyEKAFgXp7Z0HPwJ
	Rh1hPmrFpe4d4ij3sqaVeeVudjxZlsr0+ooC9HbPvkNaMdAFIEdoybGMSk4XjwipQ3snVB
	ZcZQPJkmjEqjBi5O/oEjOo23t6rf1E4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-flCTxAYbNq-iSJW5DxxOHQ-1; Thu, 17 Apr 2025 02:46:05 -0400
X-MC-Unique: flCTxAYbNq-iSJW5DxxOHQ-1
X-Mimecast-MFC-AGG-ID: flCTxAYbNq-iSJW5DxxOHQ_1744872364
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so2243235e9.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 23:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744872364; x=1745477164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnSxZovFrg9CXJ8gi0BUAt1W20GbgH0zF4GHBXAvP6w=;
        b=SPttkDdFWR+9vXZFszFgsTYqRR6lN5SYZKrUlkehwC6FqssaxKTywUlbnr0QCetWI9
         FMYUJdT/jA+DKCfjqvw5n7pORjMMXjXJV4lC1Opo5a6eI6QDFg/2vqmTfGwXz/FEJQ0I
         8LjWiRZ2fOk/llSqJbnnURvcWdvsDaxWuKJnWz+3OwJV9+fppEezU+jEk8LeLBf2izCJ
         3k4Mj+iyB6r4kBoy1U5l85Qj1XqAiniTC/pyoGi60tZ8CGZfNIvd2i+ctpE3TGu8l+C2
         XBL3oym502VOjHT2fuhZu0lAhL0E5bowhY2/pQG1iKcI7+KI+Ig3OWk4zxADjfd/S19o
         i3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzbMIbBqyCtK+A+3RPWyY6FPW6Xykfj4ZfL/5LBSf62M3MHFEHdZ6Y7y6kGCLCwgYWH4uZfq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9+JJf2TzGr8b5oDX5a7m4+VsDzVeqqIDYDhlJKHtxT4OOs37B
	y5EneXnMLXWaVfDDxpCKlLnKtoWsAGBXkwjtqvvljm2I2OYETtTIZB8KJ5nDtiRqtSJSljMnwDg
	8ljzEpBh8MJy17f3nx+9Ke/ILpWtAl4o3Hzk6cLolJkxscH6UCTfNWw==
X-Gm-Gg: ASbGnctZHY6zXW9EL7TOh/cI014YhMAy56dt3fJZmh6s/a4ciknZ7cwVhI96J08Wjyg
	8muMg3YeV5jbLxru1xCZz77CYAmzz+3eWOivlExR0eG6v/vzUdgXwNxpAl2zpCZZ9XDuqsDzXXO
	/MJxw6xozy1Tn6EsnRQnowI279TOQPFLgIV31hH2NH5l3gA+vf0aeYlWcDYjNDBjtsxNpeJ9nAb
	4xeSYiVlmKsQ1TWyiQHxh3ZxXz9bnoV5IRc1Zjp0VWWvO8arR6+9uwURXfWDSof1v7kDCUMrNx0
	bagWJr1KWZBzEhlptPopDA36Dfeshj5wdjaUmAnKEQ==
X-Received: by 2002:a05:6000:1847:b0:39e:cbef:95a7 with SMTP id ffacd0b85a97d-39ee5b1854dmr4139802f8f.18.1744872363970;
        Wed, 16 Apr 2025 23:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI+6u14lEnnPl6L5D0H366tU7Z/Uh2T3lT0Z3/BlEyCHqrUHc8u3mwJ9l1ru/6spoTS2GrAg==
X-Received: by 2002:a05:6000:1847:b0:39e:cbef:95a7 with SMTP id ffacd0b85a97d-39ee5b1854dmr4139781f8f.18.1744872363643;
        Wed, 16 Apr 2025 23:46:03 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cd17sm19182667f8f.78.2025.04.16.23.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 23:46:03 -0700 (PDT)
Message-ID: <f2c0341f-8b65-4671-891a-61f6892d6e1c@redhat.com>
Date: Thu, 17 Apr 2025 08:46:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 02/14] ipv6: Get rid of RTNL for
 SIOCDELRT and RTM_DELROUTE.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org
References: <3e28015e-0ca0-4933-80b5-de45e3c43b11@redhat.com>
 <20250416184559.99881-1-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250416184559.99881-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 8:45 PM, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
>> but acquiring the rcu lock after grabbing the rcu protected struct
>> is confusing. It should be good adding a comment or moving the rcu lock
>> before the lookup (and dropping the RCU lock from fib6_get_table())
> 
> There are other callers of fib6_get_table(), so I'd move rcu_read_lock()
> before it, and will look into them if we can drop it from fib6_get_table().

you could provide a RCU-lockless __fib6_get_table() variant, use it
here, and with time (outside this series) such helper usage could be
extended.

Paolo


