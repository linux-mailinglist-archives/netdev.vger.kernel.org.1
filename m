Return-Path: <netdev+bounces-190365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7FAB67CF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DF47B5D6D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35022B5AD;
	Wed, 14 May 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qBzqFyNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8F21C16D
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215581; cv=none; b=Hk7Rpm4b5XplE1GPanVRJDWWVPros3jlfvw6uir0lTskmqXXitpIV/b72JdNB6jPeMMRhpwqRuoXiFaH4d3fEZcTivKv1+EK/Opr7SKlmdEEOn5L0zyb9ihYJZnNjfurV1hDRl9aiTQhzxA4+KiLb9gI8NG3nr2g8dz6WIXaOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215581; c=relaxed/simple;
	bh=ogoaUVoC2HTfC+R7KQ1whQLmBAtSJIcxQKZsoIKDNGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxA6t3JaTWb20H2n9U0yl2NOTOXfLwtZ2J1qdvcwo2MariLvNuA/UKPzXYKXo8nlss8fkBk7i+RhVMPQjQPD0XKtZzYKjt9YQf6IkO/JMXIuJT1hCRYkwDK3bMEBpSs+n1x6/JBOmu04blSUWcEEw6l/7sJGLdDY+GgACuIzM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=qBzqFyNw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso15253275e9.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747215578; x=1747820378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmQsPt16qvEzbCtcuOz7UNU1/ppaKsN7Gu6ir+jLiEs=;
        b=qBzqFyNwrqghqSv3r/xinLwHyHY+Xcpg6wq9ZJjsehZ/G0RRtlkJVPimNbLEjOfl5p
         AGQUrbt9asbUMqeYRKxRCvur34ZyH3GDQEAxLFH3U09+ISYmrZze9Y1SLpslBF17rS/x
         53VGnfJhR3GSBK3XL8i25ZDymMVUVsOaJkPXLyBYKyYLgXcS3tVJZ/YQ/OqJKjcyi1s+
         fXvslxU8EfNEQSIYQ8H2z95Z2Xy6XY3LvcV2PPCEbRrquYWKRCgvk4J+vOEjBS0xRQfm
         acFf6X3ObxWNPxkKtuFY8cLacj1jKqdjeUKw6NWqtmBb6UfUHlejDT19KY3odWzLS9jj
         v32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747215578; x=1747820378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmQsPt16qvEzbCtcuOz7UNU1/ppaKsN7Gu6ir+jLiEs=;
        b=RK2zDMY2CV9fnMB30c2YFRlxFHxY+Sty8RyP9AI1VZ9sEOx8OHoDAUhLWRrSflBSjh
         E/Lq0ndRjVpf5zEL6chz9mWbsSvnw9cYgQFsjETfojZwmCU1VebGWdV6uGutIO2vxKjz
         SwMfc//xve0Jcm4P4JTD0byPEaYLqN1KeFPbcJTqBfHAsWIAenC5MgSl+hRaW5WUDloa
         kHfQqM0Hd8+MY06EN+MH/JkLAKyX6RijZD/VCwWgyYXiXP/s8eFl/Z9cfU11RfkhJoK8
         /FYSkcnnARStEYbbLDVxtDCXBaFYwou3P03Icnwh7tL/aj0Z7xDt+DCGIsMdBmwMvJDj
         SGtg==
X-Forwarded-Encrypted: i=1; AJvYcCUH6CYhmYJQ4SzIXjtphUaeiqvS4W8/yQrsTFeSuGSTwervaGYj8Qsq2sNifNvcpUvRgXfW4xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxluk8/xIqSHVWMOGxtvN8s78/H2GVxVCvzDma/PgaSPoKgNkJh
	4vrPPaJK5NN0Xc6U4wjBtNBKkDqBJStIJh5AMarGyiyQoLVOawfnSD8q1Hlvq2I=
X-Gm-Gg: ASbGncvvt077TtpDjkOg8JPt705u11iY9SOlJwwDu6R3vf5Si6cSQkTwYFhflDtFx6j
	MIdIeScExhNEqPNQlJdnaodAK78ztkv+3Wvm62XE+J3wyXl8wFqU/MKQzQ59vj5H1YsTLWqDllc
	3L7ZMJSXd0bFzfHc7Zj43D953SxPp8Gvhr+l55qtOQeCEJ546pFvwe2Wm01l7b5n/euxr09fUSZ
	b5lBRRgXBliv73HsCCDod5bx/YwtG7wKGbd6xGxRPywhtVKZ5d3ODbFJfSzU+2QcH+FaSjsqoWX
	nGRVLNnbEn1dNFuYVwMlmcYQijBxuMnq/Fn2LvvP+AwR1RKEE52dWwPtUoxspuLWxmHsIOk11Vm
	TF02/b6A=
X-Google-Smtp-Source: AGHT+IGMjIkyJlHUmGyQ4sgxneuH8ylOFJQHi3aLp9S9RHuis0aOKuT0rPJB3ourTOfMx9L3AAfUyg==
X-Received: by 2002:a05:600c:3d15:b0:441:b076:fce8 with SMTP id 5b1f17b1804b1-442f20e73e8mr25259995e9.14.1747215577689;
        Wed, 14 May 2025 02:39:37 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3368f92sm23689685e9.7.2025.05.14.02.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 02:39:37 -0700 (PDT)
Message-ID: <cd45f194-0978-4e58-8c97-15494061f754@blackwall.org>
Date: Wed, 14 May 2025 12:39:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/4] net: bonding: add tracepoint for 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com>
 <DDF908383E15A2CE+20250514092534.27472-5-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <DDF908383E15A2CE+20250514092534.27472-5-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 12:25, Tonghao Zhang wrote:
> Users can monitor NIC link status changes through netlink. However, LACP
> protocol failures may occur despite operational physical links. There is
> no way to detect LACP state changes. This patch adds tracepoint at LACP state
> transition.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
>  drivers/net/bonding/bond_3ad.c |  6 ++++++
>  include/trace/events/bonding.h | 37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 include/trace/events/bonding.h
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


