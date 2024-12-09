Return-Path: <netdev+bounces-150266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53189E9AE4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894951887F8D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF28384D29;
	Mon,  9 Dec 2024 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="HGK3zq3j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FED78C9C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759424; cv=none; b=BTrsLntkNatZiQhvWKibA/NoXAvGKkET7g95YbNfXn2+qj8uDkNLQDGdsUt6a15iOPWbIxPVk8DwuK4vz+Y4CbTuKhkGH+Ed0f+WQIZAHNh9ovB7eDQ9r/nAv5Da71igcpVSVPjTWZ6Xzunpsg22Jto44p0XG1qZppdfwnq6ASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759424; c=relaxed/simple;
	bh=aytamEz9AGfvqDSyA4tltCUbH2CyU2IuJ0VZeqmezvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvkojSQ70T1DqkczR98LUny1fo7VyBKk9SETgOg14r/WFw8pUKPvqYS2jZHDFTK9PJB5j/3+W1QokzDOKSMwl+EjEXbIGmRYjQMHJNcg3QKKXLDyhNTBwPA4P9eKStpgRSP9324kuEQGzNMb+eP0/vWD4WDdLC/D3ZWcPQFknMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=HGK3zq3j; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1582c86so3977495e9.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1733759420; x=1734364220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7kybUbYPpGDewx+f6Wt4KXTxL6OaSZ3M769h/rgbNyc=;
        b=HGK3zq3jnVYaOKn6KyqxUlfVdKpXBLjFqtd9uVxsXStjHGdX8kB0SLNsaNvcPd65BS
         rjuxGdrxXnAjxuCpPp/9DTzhicdutiRXX5kHfe6lzwo/vB1o2E/0r2utN4mz3MH5ENQ+
         C2lcB8/OgVS1gAPV1oh3SSmxziNAJfAufzRRWxas+zvhnnFs1YEJ7e+PGPFb4QLFJ5Mn
         rv57phjJahT5XaDcBxQgcNhVdReO6VCkewRcPlzwd7VAGHaCUszjrzr1IrkV7lSHiDjC
         Lt5vO+AD+0vLtCJ0aHNr1VtqZuUa1Sul/4XlLyuLc6XZ521V9qZ+AeTNXgq+A1aQl3gc
         Fi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733759420; x=1734364220;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kybUbYPpGDewx+f6Wt4KXTxL6OaSZ3M769h/rgbNyc=;
        b=DT2BgXjRv9EPbeTwzHR2o8vOFc7RTinerhFIwBZnJGTuVB9ZlZsebB+ByDqLkEMUHB
         vLDyT7aXTABiiteOZF9jzR14Irdj+mA2Ap1bdQZf1bSVJdp0yoUalmQ6MuIFhSHT4mVn
         Ko6eSWJWSgfrnI1o7z08U//dzXzW3IEvBMxZUefHkJ8E4jqkKWJTpYZ4MTq8euT6Yk5x
         nZcI/nAiBh566TAN+Z7UUtr1HIJ7rOVCN/tlfV7jYKkOBo46XdWoaMgB4zdqVTwVGuQX
         LWQJC9TRlxaZIm0mUxEdx4EJkQgnkL+4FmEFKITY92TKITnbmgr5qE/64K21bIsdg+nl
         h5iA==
X-Forwarded-Encrypted: i=1; AJvYcCWGIUBmQwk8wtRyi/T655NTpf+zCIRcf8O5GGM74oJ5qMojr1oyFgTx/AjW7RqAt1IigyH1VwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2X+E+nnb/sJlNcr/zB386gU8ERf33D2MTJ1cY1QBPZgop3EjP
	lk3ly4iHBRgxvK0SATnWInxTM+2lrnUWPMdvszTCKLiBtulxHvPO1x/mskzPhGE=
X-Gm-Gg: ASbGncvgQvUP8+wUmCV6PW3zLtCGjxTzXoMR/JXH6Nwt3UkYXJXPA2HQePWpDoDT4kx
	V26qVLRstzb5vAyVs9H1FbetNxWf4rUcQESZRqM8YLt/xaTxJDePooFrHk24LatFs/SJh+1wkqY
	IfBct6OwOgYpLbDQ6rnJbYURH6MT02CmhnvxMSNrkH33USaaLMZbyA487TC6Mo8j5ftpgsqF8PT
	oMt4h1lOgeST9Nfa81V8zyfbWOZVmrUx4sLgwuTi8WV/L49qgTFuZIEbWjgREZ5vNRJRvxLchGA
	BSbipYWqyZsoooCHER2DAq5yQaI=
X-Google-Smtp-Source: AGHT+IEjEHk5UnjtFZL9x+jCCCoiU6R/kvd7Y/slVL/tA8motNA5rfasWV97nI0WC4mUl8CjxkTSfw==
X-Received: by 2002:a05:600c:138c:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-434dded98a6mr42643155e9.8.1733759420157;
        Mon, 09 Dec 2024 07:50:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:9bc9:8e1d:2458:82b0? ([2a01:e0a:b41:c160:9bc9:8e1d:2458:82b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4350159f6a4sm2824085e9.21.2024.12.09.07.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 07:50:19 -0800 (PST)
Message-ID: <766da3da-04cb-4131-ba1f-6d821304dfa2@6wind.com>
Date: Mon, 9 Dec 2024 16:50:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2-next, v5 2/2] iproute2: add 'ip monitor maddress'
 support
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com,
 prohr@google.com, liuhangbin@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20241207092008.752846-1-yuyanghuang@google.com>
 <20241207092008.752846-2-yuyanghuang@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20241207092008.752846-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/12/2024 à 10:20, Yuyang Huang a écrit :
> Enhanced the 'ip monitor' command to track changes in IPv4 and IPv6
> multicast addresses. This update allows the command to listen for
> events related to multicast address additions and deletions by
> registering to the newly introduced RTNLGRP_IPV4_MCADDR and
> RTNLGRP_IPV6_MCADDR netlink groups.
> 
> This patch depends on the kernel patch that adds RTNLGRP_IPV4_MCADDR
> and RTNLGRP_IPV6_MCADDR being merged first.
> 
> Here is an example usage:
> 
> root@uml-x86-64:/# ip monitor maddress
> 8: nettest123    inet6 mcast ff01::1 scope global
> 8: nettest123    inet6 mcast ff02::1 scope global
> 8: nettest123    inet mcast 224.0.0.1 scope global
> 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> Deleted 8: nettest123    inet mcast 224.0.0.1 scope global
> Deleted 8: nettest123    inet6 mcast ff02::1:ff00:7b01 scope global
> Deleted 8: nettest123    inet6 mcast ff02::1 scope global
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

