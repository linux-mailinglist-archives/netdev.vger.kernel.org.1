Return-Path: <netdev+bounces-207797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7592DB0895D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4884A47111
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405927C150;
	Thu, 17 Jul 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1OI6YOe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E328B4E1
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744850; cv=none; b=q8L72G8UOLWlpy5wHtWqg5F9h63fZh+sgb1ZN3FVtA1NMgg52ZFcLRKoiWpUJH7+i5N+xz8IUAlC0wG5l2wunmV50Vgd+OUoLffArutyCkrA1HjvMO0uYYfMnFHrKZBhzU//yz47/8wfex0uOIeQNfvwIO6dUi/OakveHdtLkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744850; c=relaxed/simple;
	bh=uCg04T4armDVGvOhViSESANqGepm/HiiKZADz90OFYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1JfQC8XjFBB5CEUmSfHr9zKEHsERXoQrpcTVuA4EKnGbWEA5OgqmvKjIQwmKVFD7RgSIlW4LYrevZ1YlpSP8ncp4UW23Y/A4GhH4QPBWzaud3TLJQFff6ccBvc2OQnczCh3Rk5ZJd3mKPpZ5ndQOuv0WbLJU0mp3Mluc2EI91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1OI6YOe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGKt4V5SInswPUHPy5o7rqt8HGv+lZZThvBbqAsKTvE=;
	b=E1OI6YOerYRPoOA3XEwD5A9FBWmYf8gd0nPw8fyigMw8gS820rXDGbLgPlU1Edz2ea+Ze0
	7LBzQcM0ByGyQ+tb8EDYtsNY77uVHsvPQfqP72gpp5O4ACzVEv9a2qsAfyBiJ6dB3+Sk2D
	U6Jj16wqp+Eh+jr0N6GIq8zMSauJBwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-izd-hdkBNSSrq_l4bPFFRA-1; Thu, 17 Jul 2025 05:34:06 -0400
X-MC-Unique: izd-hdkBNSSrq_l4bPFFRA-1
X-Mimecast-MFC-AGG-ID: izd-hdkBNSSrq_l4bPFFRA_1752744845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so7338835e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744845; x=1753349645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGKt4V5SInswPUHPy5o7rqt8HGv+lZZThvBbqAsKTvE=;
        b=iiq+Yf39fTKSPnJ/L9LON6o6OK2I81K6trlZUxwqUvtg6DK5ucSOIxKigb6QL93+If
         VbjvHbhODH0IxLBwg869Rt6QJOHQJMGE7gILevuMM31PfY5TCNaUjxR6+jo6Xacm8sED
         zGe52Qbr0+DQDm3sJNUXeK60BAAQKe8rcXIcUljcR2HxMEx8aCfk1k22YLLzTZYuzTHv
         ySxmSPwBinq9ORZNL3pa/iiBi/sv8vg5eJqZc1Q54SXolvgqEnAeziduo1H8KEzdFBqG
         gBs4aPpvBKJ1tU7tXZmusGblow03CEpGdPgbo06zyN8WwQkVs2wMiEsoSxu4YvXq7Pgb
         5n7A==
X-Gm-Message-State: AOJu0YzxYXFn6kBfmryvD1apfGSHrSPyWnOartMKSfdTSaG+NacNSsiF
	trhLskz3Kt34EOKsowOx8bl+4cHa+BZiiDFOR6Mznz2ky+EDl6FK7zafUNO3tVUdniCY8mq9llQ
	stMFZj0FNMXEbPaiVE0Z5dVf4Ez6Cj4+7EqM/6Y5jOwR8XRv2K5wIgcwHFg==
X-Gm-Gg: ASbGncud4A+mhEv8utBBMaV7om1LaWGxTPGFhqaz3VeHqWZ3q0OTogEkgxGb4pv+rM2
	69oQRcLSEIUGs2HRyXb+8gDjGAleXLioZcuPoCAEvWfmAi0u/wmixg2b8sx7e9ql5swX/MySZET
	ynFGOZGIFobamyoEd0PAyNlFcgmKh9n7CDH1sHafYni8WvpilTc/cDymkTmztUwXmNgy4tNxCwq
	Du7ay0UcdXQdwkhdbU8EmyAguuhUAScFFggNjxbxaHmwm+NYpjCDYfz2dCNGUxlkgE+F4/bwNjX
	IcGSk3HIv+fyCvt/0/PSnZhXJlqT8/ZDjNscruAgkLxXJgP6zbMLg1vlqivm7z2qsxlRJBpRGax
	3Y8gfNKbyKE4=
X-Received: by 2002:a05:600c:1989:b0:456:1c44:441f with SMTP id 5b1f17b1804b1-45634b3da54mr24030095e9.31.1752744844706;
        Thu, 17 Jul 2025 02:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoL286L5OmB5U+J2NEmtNEHuw/5SlW5RK4waTcG/dhhaMkDw0py5V5Y01XPe5N0SYLX6DBUw==
X-Received: by 2002:a05:600c:1989:b0:456:1c44:441f with SMTP id 5b1f17b1804b1-45634b3da54mr24029735e9.31.1752744844277;
        Thu, 17 Jul 2025 02:34:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8ab642sm44687895e9.36.2025.07.17.02.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:34:03 -0700 (PDT)
Message-ID: <06e138e3-bb54-4219-b700-bf0a307a1b99@redhat.com>
Date: Thu, 17 Jul 2025 11:34:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] selftests/net: Cover port sharing
 scenarios with IP_LOCAL_PORT_RANGE
To: Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
 <20250714-connect-port-search-harder-v3-3-b1a41f249865@cloudflare.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250714-connect-port-search-harder-v3-3-b1a41f249865@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 6:03 PM, Jakub Sitnicki wrote:
> diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
> index 29451d2244b7..d5ff64c14132 100644
> --- a/tools/testing/selftests/net/ip_local_port_range.c
> +++ b/tools/testing/selftests/net/ip_local_port_range.c
> @@ -9,6 +9,7 @@
>  
>  #include <fcntl.h>
>  #include <netinet/ip.h>
> +#include <arpa/inet.h>
>  
>  #include "../kselftest_harness.h"
>  
> @@ -20,6 +21,15 @@
>  #define IPPROTO_MPTCP 262
>  #endif
>  
> +static const int ONE = 1;
> +
> +__attribute__((nonnull)) static inline void close_fd(int *fd)

Please no inline functions in c files.

> +{
> +	close(*fd);
> +}
> +
> +#define __close_fd __attribute__((cleanup(close_fd)))

I almost missed this. IMHO it's a little overkill and the macro
definition foul the static checker:

WARNING: Missing a blank line after declarations
#181: FILE: tools/testing/selftests/net/ip_local_port_range.c:588:
+	struct sockaddr_inet addr;
+	__close_fd int ln = -1;

You could either use the fixture teardown, or simply close the fds at
test end, ignoring the error paths (fds will be closed at exit time).

/P


