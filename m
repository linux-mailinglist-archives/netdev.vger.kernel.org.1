Return-Path: <netdev+bounces-189996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F82AB4D49
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADBE864288
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B331E9B30;
	Tue, 13 May 2025 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxfXCqY9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA01E32D5
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122512; cv=none; b=F/hvkrKS+dlVbH4pPVl5Wd5HVftm6RbTOm+wASZHLgqLHo1Miq44a1qvaC7gKE6VuRXDrcW371xY6jXU9ydKylXmnaNdSEMa+cI/DMqjtShLSYxMrE5ubYStBmNMk6iKfcdYj8Y+TS3KogW3Hbdr3G7N6HIDQuqtNunfO/ks2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122512; c=relaxed/simple;
	bh=TVK+cY7QrzBVdkx07hJKAIjEnQWeQ3FLl6LGMJOcJZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lziI1DSMnF8sPXvWnKQ31TFjId/d+r08JN93wHuDT8eYXpO0Mi5PoYwZukChdH0CzuYDhHWCjN4ScUJ97VIBt1jUk1VgOWEAgkM7BVc+jII8nxvX0/F/0onGDf7pbq0oYY+HStx0Gxx4xKmryixY9aM1GjG7/9JzX8k+CZ0gUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxfXCqY9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747122509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/1Nw66JUOACoIEJnQOBfrLHho6i7gGQLfJohwFxlVw=;
	b=bxfXCqY9bRhlaWVD6KHA7ARlNswXgNCkUhnZroJ3dB4BAdjSxDE/RxvPvI0XkYZQgtloHB
	b9c91TILcY4LgFdEGsvEAo4cg6lOOnu+zptbKG0A+MXjn5+pJHNEFDcpPlBRn9nzSoF0y9
	cIpXorxVoIFvTbyPRc+YSG0GZFHLzh8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563--6M3L7UaMQ6gXBOTtj9RDA-1; Tue, 13 May 2025 03:48:27 -0400
X-MC-Unique: -6M3L7UaMQ6gXBOTtj9RDA-1
X-Mimecast-MFC-AGG-ID: -6M3L7UaMQ6gXBOTtj9RDA_1747122506
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso25182955e9.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122506; x=1747727306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/1Nw66JUOACoIEJnQOBfrLHho6i7gGQLfJohwFxlVw=;
        b=gBCLSzlahA/HeeY8m2cWIbyxE7ZihUv7pqCTJwcnh/EkiCnBr4vboPjAQLFbp4uw/r
         PHycuFiKIKJx+fGxYwHIzqce7Vo2MkKeJOFQl2UX89Kl3jsfH2kH8/gVY8cR+sJdUn9M
         FxqB3MFFp5Y4iK/sw/v2Rr4q3yxeJcGLj2dObUexJwu5FlPdVYo/DfnqD/GRh644dcf5
         kfvilE6YVwbahNN5TUbOF+tTUWclL0aEu39wdoOUCFgXSzfTeR6my31UCf4ueDI8BvMp
         uT8v3cgtEJ/+K4hFtoimq8HaRcSn9ngnfyEEV1VEAlgPv05PUag4JGA7nrQyVq1M4wOx
         L4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOC8KdtAOw18wjx5TkEn4FXEPNH9VK/Xr5wsDK6GehzymbKpKT3F6ba4N7HGVnOurw4LdCQYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJGwBDzV9CNCE5x/gnTGmbiwFtwWPMd15XkWYCApgRNDFV7VF
	8AHXECWusMSX5xwEuWfoi73yJ7ebbWMeLmOu+k3F6k4mbl3CGF/akPbJdpqxIyc6eg9jlRr7xtW
	r5fDWpjFval1adbTnXwqOB4J6BKR9vFtyfHSEQkmTAgNJqSMekWhlqg==
X-Gm-Gg: ASbGncu0h7Z+ryqu/UpcmoVXWSCGW2nuo8/om9CsuDh3bLji5tFjBhn3ZRN6PvG4Rfj
	5JmQOMk7WtKmvfKNaxXc7q3ObdZCJQDznqhHcNAo6ySKOYWtyrqmhkrDyRmVzU98XcPrnl6vse+
	xbCXU6M4GNm958uu5QEAUDhVQEcZA8HSyz1ZaHMUNPDnAyLz3YRfInOpYhiOcxgh9wkZHPgpezF
	eHtYQCeyqVuIHjzwP7spvoUbNwQd20vXwVYffZss6rF8d+f0DTGrnCmSKggP0jXfBuXE0lXpWkP
	8O2CntkfNXew7OpoJl0=
X-Received: by 2002:a05:6000:2a8:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a1fcd9fef0mr9757873f8f.12.1747122506235;
        Tue, 13 May 2025 00:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvdJ5oRhKsQd/OCiEdsNB4MhFVZQCw1Faz3heA6DUMMVXvqfu8u7jgxwnwGtrUy2mKs5MrnQ==
X-Received: by 2002:a05:6000:2a8:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a1fcd9fef0mr9757855f8f.12.1747122505885;
        Tue, 13 May 2025 00:48:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecb46sm15304464f8f.30.2025.05.13.00.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:48:25 -0700 (PDT)
Message-ID: <4b95deb4-d1f2-47c3-96fd-65d2a8edd775@redhat.com>
Date: Tue, 13 May 2025 09:48:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] selftest/net/ovpn: fix crash in case of
 getaddrinfo() failure
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-6-antonio@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509142630.6947-6-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 4:26 PM, Antonio Quartulli wrote:
> getaddrinfo() may fail with error code different from EAI_FAIL
> or EAI_NONAME, however in this case we still try to free the
> results object, thus leading to a crash.
> 
> Fix this by bailing out on any possible error.
> 
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  tools/testing/selftests/net/ovpn/ovpn-cli.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index 69e41fc07fbc..c6372a1b4728 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -1753,8 +1753,11 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
>  
>  	if (host) {
>  		ret = getaddrinfo(host, service, &hints, &result);
> -		if (ret == EAI_NONAME || ret == EAI_FAIL)
> +		if (ret) {
> +			fprintf(stderr, "getaddrinfo on remote error: %s\n",
> +				gai_strerror(ret));
>  			return -1;

Side note: you could instead use the libcall error(), even if at this
point it would be a quite largish self-test refactor.

/P


