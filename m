Return-Path: <netdev+bounces-166069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D80A345E2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC44E3A995E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE323645;
	Thu, 13 Feb 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbpOYmrt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743F26B080
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459431; cv=none; b=FbEvM0S5QVyXW4tewlPRIVj3VAToZjBGu9vBNtM+2WS30GOfJgrgzUxSmR4r7P6sa/3cOnblDI/HKJUWSNFd8JtDKn7XD+YWlcca4mqLtj/ZT5aag9ozsMgd2jJ3OzRwpxyBqUbVGtEEYN+gBIc4MoJHWZ+ojBeqtZek/85gczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459431; c=relaxed/simple;
	bh=mlUHk54TBcVBEyyj8ISfqDCrYc1KSxhmRU88rJVW6tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuOSwpOr9Ndmoy2IpNAjsMXTwGO8ocQkRVRUmHvFiVsVJhdi8Isyl3vA/qYGx9HJeRG8tyBs2PHxLUMWDIQP/bwV0XPQyWqpuPZOmsum8w5b3L7jhee+fA+18jK97DSBHlbPUC51p9cCCzyw4GzBlTLYJgYhEqfDnNyuMyQAKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbpOYmrt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739459428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDQ5AZYBvXdoOZ+xVF7vn+WOBNNkmODnOLSQYjW0w/Y=;
	b=BbpOYmrt6eidQstGy+um36E4oJadWR+qyx3xZk+rIQ5xGAu6F5tPmITLo9wKn/lSGjARAz
	LxNxu6mmcL3CQhHBU3i9VhBRUk4Xy9edCAdKJGR11I+vyibvrZgE4VgKBIT72w1FQTyCpT
	khF+iucnycr5oESqNBKkvytCcxL+5Yc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-maXr3nyGPCqaBDQS0k4c7g-1; Thu, 13 Feb 2025 10:10:26 -0500
X-MC-Unique: maXr3nyGPCqaBDQS0k4c7g-1
X-Mimecast-MFC-AGG-ID: maXr3nyGPCqaBDQS0k4c7g_1739459425
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-439605aea5bso5383435e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459425; x=1740064225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDQ5AZYBvXdoOZ+xVF7vn+WOBNNkmODnOLSQYjW0w/Y=;
        b=I+BuIIsBedmGlgzZYI0uv3Evbx8zBdE19iRPgmq1Vwo6m2IlK/F/PUzUhNl7nzqAIB
         yMJg04EREoe5AVU98mWXneb8+PaYIWaADlv/XQIO+0uxD3XihgqHM3DOMc9ilKBSuvR9
         ZMZ9NWqZ78QQ7A3MTBQRfa9nSpSHc0TR990cwX6ykxXofVe1mlkgN59R072N+LEA2SPf
         52xIzvnbhf8C5Har0tMy9O5j3HATMv3nTk3OxSf3xnS3ghanDpAcyZtcx4STrWd3N4Np
         qd/P4BMtxKPR6CR713tQQad9jiKJQ8X7ulrJ7bIouovHHYzDApm4nujgqgZr54j0p6aJ
         Ewcw==
X-Forwarded-Encrypted: i=1; AJvYcCW9QK2vokS+S5O88cSCeHpvTdsFmnHJZoIg+kbOrS46GdM69JBvbFjMTw0JkbhtMLVi4Zs7ZFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWc0S9acPjgs4WqLtwyMF8Yf6xhu2F5vnsQWohYlIlSX4YkHo0
	bJ3cfVr+VryJC6N9jbDJmcy/uBczbbkAuV3gVfK2HFpqzmMx1KXLvQr5uSHe3zWn59B7BnSayUU
	GqZ+dI6kSe+UDqUvmaE58XhPGtUwXDHKWq+s3mBaguVl8cyQSxD5CTIlxdvfTyg==
X-Gm-Gg: ASbGncsztahNrthEQsbMaIt2LRerIbbxqN8jEFYvnl1lmcMNENI6MLACdDwSlsHg2DU
	WNn6API9DosDAqimMsCux4e1mr5jIUPmecpbB8DLXdoF3sxnqJL83iEU1IlD5mkGVnWgcPLdHPM
	Ldp3lFOG3Fkv+v3SbEBfHlV0Lw7br0YHjT4nBnv0v8YuB9pTQQo3Zegwc7fAWLiInmJltL97v6q
	XQcpWGPyfiMNwn0JOMcpmOzDR26rvGClEekMSiHKLIWvb1gtAM6PqlhKeZJkpwR9F4+8c3fpMwY
	gRBE92EPawliX9xTITydzdD0ZHWNPZb4YL8=
X-Received: by 2002:a05:600c:3b92:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-4395817a562mr96471305e9.12.1739459424567;
        Thu, 13 Feb 2025 07:10:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9Uz2pT6ksqspDo0r4XjV4b/utq6qexm8C4TebCeUMDIlU/tH0G8FrFOPSQEbiWRBCSd643A==
X-Received: by 2002:a05:600c:3b92:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-4395817a562mr96469085e9.12.1739459423461;
        Thu, 13 Feb 2025 07:10:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396181026fsm20149105e9.18.2025.02.13.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 07:10:23 -0800 (PST)
Message-ID: <10ef7595-a74c-4915-b1f7-6635318410f7@redhat.com>
Date: Thu, 13 Feb 2025 16:10:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] ipv4: remove get_rttos
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, horms@kernel.org, Willem de Bruijn <willemb@google.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250212021142.1497449-5-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250212021142.1497449-5-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 3:09 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Initialize the ip cookie tos field when initializing the cookie, in
> ipcm_init_sk.
> 
> The existing code inverts the standard pattern for initializing cookie
> fields. Default is to initialize the field from the sk, then possibly
> overwrite that when parsing cmsgs (the unlikely case).
> 
> This field inverts that, setting the field to an illegal value and
> after cmsg parsing checking whether the value is still illegal and
> thus should be overridden.
> 
> Be careful to always apply mask INET_DSCP_MASK, as before.

I have a similar doubt here. I'm unsure we can change an established
behavior.

> v1->v2
>   - limit INET_DSCP_MASK to routing

Minor nit, this should come after the '---' separator. Yep, it used to
be the other way around, but we have less uAPI constraints here ;)

/P


