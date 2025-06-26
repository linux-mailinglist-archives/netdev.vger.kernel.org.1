Return-Path: <netdev+bounces-201568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B538AE9EC3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C51165E37
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0D2E7629;
	Thu, 26 Jun 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i66UCXyi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB32E7161
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944458; cv=none; b=JfrLd+LS8/HP9J/AoRgQ2z9PkByJkCMywL1FbGLEorU3em54Cr1hKuRvgdnivTkMGwoS/8YApUEycBNVoBQDF+7Ae7HqNzK1lD5yHmXmPxg2jOzPJcBQmiMw++DdBi9um1xvEjmzkLssFA68FH8ApoHFlrdoCe+6EMJ9NQAN4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944458; c=relaxed/simple;
	bh=c4weyxBUzL8k5KIAD8qAcofeG5KQRXLNuubBwbq+E18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyRrrWmCKHZMboCMlCHtZb48Q8gbwLF6fF+jcgO8UC4jKrEBRMoiDHRDcljSaW+JLi7JubxPqTns0iZB/P0EwVr3Y/G2TwFiZFjVQEQncySZhyyjblb6ZzUPm3gXECASKV29jZbmLH2r7N8W1ey111ajLHwvI+HPvTDFybxEklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i66UCXyi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750944455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7yBDYslVgVpdkfW5zoX3kBytaEaiOnFiU0dQP3p6EU=;
	b=i66UCXyipAZsmxpIU84iN6+ylelIMdRJ8DEkpzc7hPfnEL0Yz/dMTkSgrWXxjwiMgizvsl
	mQDR7/1ZXb6cu/GUu1J3U8mjWSymJue07g+nREU6k90aycUCc3Kxi3g1W0lTrCdRy7Y22I
	zDPVTExoQBgiiR3IE8C6yBevxcI2h2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-5Jz0jjvLOEy_E6L43sRslg-1; Thu, 26 Jun 2025 09:27:34 -0400
X-MC-Unique: 5Jz0jjvLOEy_E6L43sRslg-1
X-Mimecast-MFC-AGG-ID: 5Jz0jjvLOEy_E6L43sRslg_1750944453
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so6455365e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 06:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944453; x=1751549253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7yBDYslVgVpdkfW5zoX3kBytaEaiOnFiU0dQP3p6EU=;
        b=aG0Nqxc21hsK/dq6lU7lGm4phhVFj+ISLMCUaMGVhZFnkB1jNMywFUoD+YtqeBiTnt
         ySL8sA6vMCj+x2BgaOASyTvDqSBIXWlKi9fj4MOlhokY5s9x57imfMbA8ZQl3Mwxj54e
         X4VWeTPPgCi76PPiBwbZ4l/U2BhqCLojcu/1IES8swPpXed3kTebSvnpbvvCWOEQYAQO
         Ln9rL73L6kvz59M+kH/Tr1UCB52NVawaZf+OTeJ0mq2jinUK3MClzObVP0quQJ4NIHjL
         UESHV36OeTOMSwW9u+33TtfXJX+bqmShdyP41+jG3C2WgQwZ4a12hiFvz55/wzEoxwf0
         RABg==
X-Forwarded-Encrypted: i=1; AJvYcCWzAkDRhkjxN1yR2u/bCL2vMsIFcDXShSRrHhXmSequAF899mqMIGFx61ntmIOVyERySFi3GaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHfAcdqlftzqAI9dqseCQV1U5aPl+9OsP4k9JhlzZC2zsYSYS
	/Tf9JuKWGdlCyXrY/4VEGyeN7agxqF0M+sewmuMWUINPg010zB+K7ZCHxFf+C0EMwHBNeGRzsLP
	4ml5fH/MBiwZ0CVHMffoc4l/X+RufqedKx8TeAJzHhJj7oMxZzabR8O+VPOPq/F3Aar9B
X-Gm-Gg: ASbGncvuFBpEHidkyopZq4JJeJzUUvJgyimXVPdCaUNggc9gisZQDR7GnbcJrKKmKhx
	91xxqeUPqGUSIFSqr0wd4bFCwO4KQ2sCPPZuLt0zJnIUoPVHtjjhRCQBg47V7fieJ5GYCUOPWyJ
	gwDL2mGbcja6Kod28U9nz1nLd+0ne1GkECI7LIr3a/03FvN7cEnEVIZJcd0/9vwsAdmFCT9Irl8
	ZVx4nA4Ic3Zf29LqAiIkE8IRzNq/BHolONWitQjHkAIOjoVYO8hKXCzAHUw6GiVDw1WZqvGcufH
	f9bMYhIrVa6yAQaelrw++mBQCy50XFI2evQc3KsbpfiI1iAlMA+ota+STZ/yQJibCCQ04w==
X-Received: by 2002:a05:600c:c4a3:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-45381aeba44mr61977175e9.22.1750944452740;
        Thu, 26 Jun 2025 06:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExjCMCiKJsjuQzsIOTZ1RjRsSB8YqZwGgDCFielM7eT+LLXKJLiEOKkXxdv1Y1dlsu5WUt3w==
X-Received: by 2002:a05:600c:c4a3:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-45381aeba44mr61976965e9.22.1750944452312;
        Thu, 26 Jun 2025 06:27:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe0efsm19834615e9.24.2025.06.26.06.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:27:31 -0700 (PDT)
Message-ID: <6c33dd3e-373a-41b3-b67a-1b89ce1ab1b5@redhat.com>
Date: Thu, 26 Jun 2025 15:27:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 00/15] ipv6: Drop RTNL from mcast.c and
 anycast.c
To: Kuniyuki Iwashima <kuni1840@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org
References: <20250624202616.526600-1-kuni1840@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 10:24 PM, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
> RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
> multicast code.
> 
> Currently, IPv6 multicast code is protected by lock_sock() and
> inet6_dev->mc_lock, and RTNL is not actually needed.
> 
> In addition, anycast code is also in the same situation and does not
> need RTNL at all.
> 
> This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finally
> removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().

I went through the whole series I could not find any obvious bug.

Still this is not trivial matter and I recently missed bugs in similar
changes, so let me keep the series in PW for a little longer, just in
case some other pair of eyes would go over it ;)

BTW @Kuniyuki: do you have a somewhat public todo list that others could
peek at to join this effort?

Thanks!

Paolo


