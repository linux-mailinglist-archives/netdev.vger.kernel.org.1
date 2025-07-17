Return-Path: <netdev+bounces-207805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E7B089BF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA6F7A4C72
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07972291C20;
	Thu, 17 Jul 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c/26uaIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4528A410
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745855; cv=none; b=n2KDgbwftRxQiUVEQkz3r4t0qul3mejOn+IQ/f4fqQkyumRbHtsGi9ZZggh0g2EuP9MvmHLspkgwOtRUYcv6z73VkE9UT+5oQPaaGJzXpw9AbdI/J6YdWLVqYMvUWSXPssBcXrGMTOVwpNkD4rCRXwt4OFQZ/NnMea73qsTP314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745855; c=relaxed/simple;
	bh=C5eXUccvSbYrKkymol6C57Kz3YViEL4QZsTZgfY+4gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSgdeJvviNkkfwHNCl0h9xyAs7flMSIbBEpWEnwiF/AIse6ZG+vXa0psjbS8ROMqZQeLSTRy9ejtpFvQ51mTMMYmtv2RptjZs90rvaADnPe4A7QuYKcDb1xB/Ql31+IC3cZbL9xdAgVDLc9OECEAzG0PkphEIpBhIyZfIO074bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c/26uaIS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so1140846a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752745852; x=1753350652; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KG08qELoPrwn1gHr9J95kn1aTOIhe1stWhOEg/YILg=;
        b=c/26uaISt8WoHGdo7Xt+l6CBwMABGBjd/3YWUviLxNte4cCi9ZKo9J/Nd1vqSuSTjj
         /GnvclW87dsQ/zvuOwA/EG/AjWkBJGVJGqh5PjI6+8aTxPWQ33xl5Q0v4vOVHq+mPUer
         1ULglA4598AMb9BwvoEoDvhUSWreLiE+vfpO96NM97kHEuXyrUQjrbww6LWV15PZRkt6
         KzSBz7MUrNWO0RAq4YiYqWxQTfxpgmdwEDhNYiNrxr730Jg+XDXTqkP3qdYI9ype10nB
         MAManBj+CyWRz3D+3kp2/cFlBXYEW2M/K1qsFAIBFsi3vskyJKUZ+9RL1wDYVSfzzToP
         lDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745852; x=1753350652;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KG08qELoPrwn1gHr9J95kn1aTOIhe1stWhOEg/YILg=;
        b=m+96/lDaHIAFKv+Glure+7+bLU/YeHJ4+vjq7wj+e62qD+sBhMFu/tRbIWggxgE9nH
         YjgQqemQG7AT3/gG03ltg/y8KHYYdAk08zELJxYYbcA/AOy7tiV8CJRjGl+cdhlP7EhD
         HMrBwB79si5LV7yIe8kfNLtaVQWUzLs7aaHUt2SuTP6AwFO7I+AMnhRtlqrPf4ESI8j1
         MIpiZi4E6pWA2iDnGI/Zv+8kDsJz6BHKxCuOiC8nHEtp3+M8KaPwaJT7k4+aVnW1eWnh
         AJsxat5FHmS4w/9TQ15Vka8np4vkktCHECWAClDFUmipxGD0kyjsZET2+WE14HZWIc8K
         6+qA==
X-Forwarded-Encrypted: i=1; AJvYcCUOm+HooI6DVamcThLqyAnyBMwP7CcB9Lmzm5tNpmyqFhOkLdEToysURi0agq8MHEEL9FMjw88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFmfs2I0E133wsV+v5wEJV2wsesdkKNZAfxYFye/8jtIIy0Yy
	ZnbIwWrXh5NJd4jIWrUUxwVBeKtvOcyoR5AopMUhUeo7ZGE+UJwRw+MCcehesSeOjnA=
X-Gm-Gg: ASbGncu8S2kWFaPsZMVprec3DSnvjLg27vGnoFUSleckfPMVO5DTMvimFYrEZw8M3Ei
	xauCmxhwsueAHobsQJpxtEKjRlG8o59+n1bBnwTRjJHTbm6Wn9eae31l+IEt9v2wSReHvI1vMOi
	8TpnhXqwx0LDXOJoTFBRaUC1Qsgy7eC2g5lC4Iqv2wFdERzNMdGND+gdS/a6hGhlaXGqKPfNoVM
	SwzF4yxC1CizpbGUikkLe5wAOqp9t3M2Vfx6VTD3Kucv4zS3ZI206Bjv9gqWwNJW7THgKLU/szi
	dEW7qoW+EneT0kXUAnTTCODWHChnJzKmr21gJAj7PBEkBJeyeWueDGxch6W1ubhIeCbr/cR0AD6
	cYzT6T46rPHWjSZ4=
X-Google-Smtp-Source: AGHT+IE+8A9U7PSBQOQPprf0hKYCdy54VLDwzfQjbrhEfZ6sygsqhe5gDVmk8i4tlXhfO+YBhYbdng==
X-Received: by 2002:a17:906:9fc9:b0:ae3:cd73:e95a with SMTP id a640c23a62f3a-ae9ce0d2aedmr612069166b.36.1752745852379;
        Thu, 17 Jul 2025 02:50:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645e6sm1332458866b.79.2025.07.17.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:50:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 3/3] selftests/net: Cover port sharing
 scenarios with IP_LOCAL_PORT_RANGE
In-Reply-To: <06e138e3-bb54-4219-b700-bf0a307a1b99@redhat.com> (Paolo Abeni's
	message of "Thu, 17 Jul 2025 11:34:02 +0200")
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
	<20250714-connect-port-search-harder-v3-3-b1a41f249865@cloudflare.com>
	<06e138e3-bb54-4219-b700-bf0a307a1b99@redhat.com>
Date: Thu, 17 Jul 2025 11:50:50 +0200
Message-ID: <87ikjrdu2t.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 17, 2025 at 11:34 AM +02, Paolo Abeni wrote:
> On 7/14/25 6:03 PM, Jakub Sitnicki wrote:
>> diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
>> index 29451d2244b7..d5ff64c14132 100644
>> --- a/tools/testing/selftests/net/ip_local_port_range.c
>> +++ b/tools/testing/selftests/net/ip_local_port_range.c
>> @@ -9,6 +9,7 @@
>>  
>>  #include <fcntl.h>
>>  #include <netinet/ip.h>
>> +#include <arpa/inet.h>
>>  
>>  #include "../kselftest_harness.h"
>>  
>> @@ -20,6 +21,15 @@
>>  #define IPPROTO_MPTCP 262
>>  #endif
>>  
>> +static const int ONE = 1;
>> +
>> +__attribute__((nonnull)) static inline void close_fd(int *fd)
>
> Please no inline functions in c files.
>
>> +{
>> +	close(*fd);
>> +}
>> +
>> +#define __close_fd __attribute__((cleanup(close_fd)))
>
> I almost missed this. IMHO it's a little overkill and the macro
> definition foul the static checker:
>
> WARNING: Missing a blank line after declarations
> #181: FILE: tools/testing/selftests/net/ip_local_port_range.c:588:
> +	struct sockaddr_inet addr;
> +	__close_fd int ln = -1;
>
> You could either use the fixture teardown, or simply close the fds at
> test end, ignoring the error paths (fds will be closed at exit time).

Not a problem. Will switch to managing FDs the classic way.

