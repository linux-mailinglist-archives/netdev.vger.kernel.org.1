Return-Path: <netdev+bounces-147974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42559DF9B1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9CC2815FF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA273165F09;
	Mon,  2 Dec 2024 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Rs/oH1RW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05422A1CF
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733111595; cv=none; b=RY1pRR1CfDMgB4M9Fm0ffk0WKB6TMDDQMe9ON7+g20zz+T8FxCZ7ax0wSM7aBxjvA2WEkKJkBRavGsdmToo15Em5jhRGGkEj5k/vFs3wv6GoW2QzCf/3srh+KFcdoavOI8q+iFVKTsO9VggrLQq+Jsee0hz5k1QJIX3nhjV8gCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733111595; c=relaxed/simple;
	bh=ic/MOYkElQ7Q9WIbJkV+dRGMbDBV0/i/+LRXAPfgdnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLsZMaME5hyUpKEE5t0FfZdtYvWDonC2PDrWTZkeYXT00AZM7n6FgCfO5oUqHuZ/2tVXjJnTCrGiEI/Oz8/ShXqV77Y1XShNoAhruXzT828KpZG6tZZ6tb8gmLAk/RrCFddar48wY8n0tNTa3tDGpQXYQfguUVHaAZpjOI2wYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Rs/oH1RW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so32005915e9.2
        for <netdev@vger.kernel.org>; Sun, 01 Dec 2024 19:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733111592; x=1733716392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9DaL5Di0M7TtT7Wg/r8e3S5xuuS31AaHJl96QB5ertk=;
        b=Rs/oH1RWbzH9867Ktqoo8EzASzEAWXkpAFfeATeXyJ4RlRws6GyvFCQDNR9fi1cEs/
         Erlz6USLK/pXVBWXjfnLyGdXKpA/HTw5eZ0CsZFm6gVS1FQbYgjsU1NT24F2c5W4fijV
         CnuD6h+fHXv4+Oz5xG4ouRbb/UIX96rL7grrL6HGOODMLkhb3tEO0TbT195pGGGSyPWH
         ptMdrJNd/eB5FIS9t7ZQ/W4zQ3leD1VkI6cJa/buSTAfQFcWF8J4zJVuJMkdtZqsbUDm
         pASQiVsxXbUgLdgH1qK6lS2L868Xr4JnqBzZEIS/VA529caDChT/9o/37Nsb9Gcfz/xU
         dbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733111592; x=1733716392;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DaL5Di0M7TtT7Wg/r8e3S5xuuS31AaHJl96QB5ertk=;
        b=cnb4fM96lx9FFXqUEhZYcK8dpGnDYsWQLpQwDGf2smUbg4q9jjW77U70iFxWq+yZWp
         th3Qco6MrJv6Dh8pQXSXr1kc50EfZvJI2MIFAb7NieV25o2qUJdj9UVUfsJJBqjgsb3m
         Lwohf/Z7C+Ww4pVoaXOSTDbHjxhLz7gRjNWeJ03F1dcRHql64Fq3mSAHhmDE7fg3zmiX
         VDxBDu3+UtugtFxcyoCBRj0d7SVi80a/6LH2eEr4GxE75VpEKkKScPOU7i1DsjR1aq7B
         gIGJsGxqc+mZUmVBYT8AOoiNvm2Tk4RZNriQ2C2LhbIx38YNkaUJ2SQR/VzrHyPKEhtA
         M3cg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Gka0wtYJir0VkHinZb1XRACDfNf4wlV8q3aP7R/c9B4t6yqO/bTqT1PtP7lRXcs/bs6ZuZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Z9DVGPHGd6Pqt9bW/0ym004Z57e8f3bEYPZfxMWSbwm6zOvN
	kB336gJEXyKEATq7kPo6fSqKDnU0N+a3jHyxq7uf9ai0eWM21kJRshGLScCz0pA=
X-Gm-Gg: ASbGncszV788Tw5CVMo5RbfyMZ4+sTfc6UA3XcSBqz9eizPN0SoloAJw8WcsUfpF5H0
	NA0iqUUHBKeArwosd2xo2zCGrLwdlWDR3sRMyiBQYmBLWRrlOqQ+e1dmadctvMQphFqMVp/xU/p
	JAgXwZTEiHgq7C90L0zqyU9wcSwgc4tPXA9hxtdhcBDQUfTQZViEqgrlf1cBc5kvKNe0+2Gz5LG
	TjtNr5KXRJUU84wNIO/MKmZuWWD1BGhjb0B6tNUpdR7WRFd6M0KLnMIa9VFudOXtLQ0muC4a8ne
	YV40Zgng7g==
X-Google-Smtp-Source: AGHT+IF/olPQvsmD72d/PUqjMBhSWIVv+KiawJCdjHeDAAJD1nlD1u1SR8ywogsKWGDmk9388oZVzA==
X-Received: by 2002:a5d:6c62:0:b0:385:f1f2:13ae with SMTP id ffacd0b85a97d-385f1f21692mr1654393f8f.41.1733111591903;
        Sun, 01 Dec 2024 19:53:11 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4d54:a2d3:baf:1503? ([2001:67c:2fbc:1:4d54:a2d3:baf:1503])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de56dsm459548766b.79.2024.12.01.19.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 19:53:10 -0800 (PST)
Message-ID: <9d9fa546-ca92-4ea4-90c5-128cacb293e3@openvpn.net>
Date: Mon, 2 Dec 2024 04:53:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
 <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com> <Z0nng5uN6dlQrQEa@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z0nng5uN6dlQrQEa@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 17:10, Sabrina Dubroca wrote:
> Related to that topic, I'm not sure what's keeping a reference on the
> peer to guarantee it doesn't get freed before we're done with
> peer->tcp.tx_work at the end of ovpn_tcp_socket_detach. Maybe all this
> tcp stuff should move from the peer to ovpn_socket?

Actually, with the new approach of "keeping the reference to the peer 
until the socket is gone" we can simply ensure the reference is dropped 
at the very end of the detach, after cancel_work_sync() is done.

This way we know for sure that every activity is done and can release 
the peer.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


