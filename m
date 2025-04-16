Return-Path: <netdev+bounces-183172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D4A8B453
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB0C3A6D68
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE522D7B7;
	Wed, 16 Apr 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOuenfp6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3F21D594
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793405; cv=none; b=MFniZXCXuW8Xu/yImQoqL/H8H3ewkobZCeEB14m/2t+eiRAev/MG4cz3RzWmhckpitSe9f3u0AvPLwVC/dJxB6CHewXKyBP4rGcbnavasLlV8N5TOJZ8CQH15POzSxBd/uDIlcjLlXdHEDRdKnxAXA/6EWUO3/gN1SIldYmJGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793405; c=relaxed/simple;
	bh=uVsqcI6VR4kYIU9Kvc9q7+DwU3wcQSKu+J0DQYUcQCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri2mIYoShG6CI2vNroBpniHW4+U1xZy4yLkMtli1wmwA44eaY8Iq8siG4viPIUNUiJ4eJ1Pyi3rWXDsi+68syJnKyCt7wDS9EHB0+V/rFUIvPCBS0YQm96lYzJw5xGwWERl1tJTEMIaLKCjWuj4tXQ97eFQz0Wy71eq9nxvgoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOuenfp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744793402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2I5fgHi4AiXu6rdQabBdf1PCKc4o/YGmQRFNI+BkBc=;
	b=DOuenfp6XDNdacG9ncYNTWN/yiKUIa1/1O63Q5DrvHZJjRQ49wZMQJrE4m4Y7+9BOhFtml
	UEYgf3M7XH9a67T89u+/Kh+VbgK7mPXbQlchKqBVTDjlylW96uKkaXgkpzmayQB3aUEOTK
	+2rObLEEtk/raygy6onxmzXjTxi+qNo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-6EC-5xx6P3S1LOU4lw1tBg-1; Wed, 16 Apr 2025 04:49:56 -0400
X-MC-Unique: 6EC-5xx6P3S1LOU4lw1tBg-1
X-Mimecast-MFC-AGG-ID: 6EC-5xx6P3S1LOU4lw1tBg_1744793395
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so3716404f8f.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 01:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744793395; x=1745398195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2I5fgHi4AiXu6rdQabBdf1PCKc4o/YGmQRFNI+BkBc=;
        b=CNHRLCGyWZnM4pSmsYNKxQLGFh4d2iJ1CAsN1ZfUx+mPh63A8TaQjVCEGnbXUbj2I2
         ufOz0VdS0nCWuVsT/1ciyujp4naojujkSC0RfwSXwyXtE5lKbnM+HQ0KujEKlY55KIA5
         sGPhkV5iBsXSlFlQc4rHFMM2aBIR0rr72S1Hhln+B4FNQtpCIchB0yiai0uI3QemzYtc
         wtOaYu8PoPbOsv+xXOW+sdFoOijyOOlNa/dOOc+X2g/82XX7jCMY5TG5dS7Dg+p9dw6i
         RIst1FkA4DUt9KT9faPn2hl9OP297qxRQGELapdJoQkrPqA7pjEZ7mW5yL2K3LaGfB2I
         aK2A==
X-Forwarded-Encrypted: i=1; AJvYcCXMIIBKF9Ig0xI+moXM7wEtRe/TR8uBBmSWwQ0+VU78i/EQRFtiIYaRZ58V1H9+7BOGkcNPrSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyc6bR42UDPM+jK/Dr1b2+IPoy2+/yiB3SmcT3IhCdV6Zpo2Il
	QAVaJpy1ko05RHaeo2NrtEFXs3juS3LhsueI3lQ3+O4BIpDgUA+gADaTT3CSxFtG7FLIMxxwMj/
	GMPeHC1l7vwQ4duBh8GjXhEwkbzYffudV4ym2rw0LJ2lks+cFhpDwow==
X-Gm-Gg: ASbGnct6T7XmjM1nK+iB7kEzPkYl7zzzewUi0SGltvXDDf+HVkzzrrYjydIFDFdKm+y
	zrxn+gMPTPqsqmmSRQDtlXfYFHcYjSWYLTJhYKUXWW6HvNqcvQOCcYwYhSqu+InDlIWYvAl+DL2
	h0gKh5uFnRb/RnOcuWxYW90JGVRsYQ4HAU+Y5QbGU0PGRAOqgkT49QbHvwmxHe1sBHUxfTHezog
	Doil+1ladzMiRL2TA0IpzjpmHMwv8cvN0BHUNQjeRoIaMZepqwoY8YJf3LLUkLoG5QMJDQjv5Gy
	GIPB93vEi/MY5JjvMboitpGFia3NoOIs3/+726U=
X-Received: by 2002:a5d:47ab:0:b0:391:3406:b4e1 with SMTP id ffacd0b85a97d-39ee5b1638fmr1030845f8f.15.1744793395484;
        Wed, 16 Apr 2025 01:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM92w3DL3ad2OF53deZd14/W8S4J75EiizNKwhHOFVtgGu3bIFGQysZY2/gSIQ/Ce1S4Zrrg==
X-Received: by 2002:a5d:47ab:0:b0:391:3406:b4e1 with SMTP id ffacd0b85a97d-39ee5b1638fmr1030820f8f.15.1744793395149;
        Wed, 16 Apr 2025 01:49:55 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4d3064sm14458435e9.11.2025.04.16.01.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 01:49:54 -0700 (PDT)
Message-ID: <3e28015e-0ca0-4933-80b5-de45e3c43b11@redhat.com>
Date: Wed, 16 Apr 2025 10:49:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 02/14] ipv6: Get rid of RTNL for
 SIOCDELRT and RTM_DELROUTE.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-3-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-3-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> Basically, removing an IPv6 route does not require RTNL because
> the IPv6 routing tables are protected by per table lock.
> 
> inet6_rtm_delroute() calls nexthop_find_by_id() to check if the
> nexthop specified by RTA_NH_ID exists.  nexthop uses rbtree and
> the top-down walk can be safely performed under RCU.
> 
> ip6_route_del() already relies on RCU and the table lock, but we
> need to extend the RCU critical section a bit more to cover
> __ip6_del_rt().  For example, nexthop_for_each_fib6_nh() and
> inet6_rt_notify() needs RCU.

The last statement is not clear to me. I don't see __ip6_del_rt()
calling nexthop_for_each_fib6_nh() or inet6_rt_notify() ?!?

Also after this patch we have this chunk in ip6_route_del():

	table = fib6_get_table(cfg->fc_nlinfo.nl_net, cfg->fc_table);
	if (!table)
		//..

	rcu_read_lock();

which AFAICS should be safe because 'table' is freed only at netns exit
time, but acquiring the rcu lock after grabbing the rcu protected struct
is confusing. It should be good adding a comment or moving the rcu lock
before the lookup (and dropping the RCU lock from fib6_get_table())

Thanks,

Paolo


