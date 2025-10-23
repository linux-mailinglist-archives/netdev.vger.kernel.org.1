Return-Path: <netdev+bounces-232004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCCBFFC49
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 132214E40CB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAF42EA723;
	Thu, 23 Oct 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ov+Oe4lY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC022EAB78
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206637; cv=none; b=aHMTxtTK2h77jm4P3aCpS6Uiv/9NA0lBbrvUWgQLZMYhglfFrb8oH/l8B9R5oAao406bMbEWMna39SE4BxkSM4BsXfkaSze10FXAjq/GH1Q7pmzWq9Lai3XhF3k+3lcpq5MWRN3qESGCJ08LQWehHjwAyrhkwRHBnknAVW4E0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206637; c=relaxed/simple;
	bh=KhzVAaHU5fh6pRjS720ROJx9dOrWgBGCkQCH1Fd3c4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSY4enrQcg/4bQ0TmiP8msSwxzfRWENclZkpOGFzbXVk7C4wByH9yoey2fS+Z0oBdBliyBpCPVMW0ctA1zjdgHVw6YSjK0JmyhjGpYaq4013u57avZvhiNz7goxmCRLZUVE2/9A9dY9EvgQESd6ubrADHeob9HcfVnOzCQ2tJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ov+Oe4lY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso855026a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1761206634; x=1761811434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xKDRSgjVAiSn1RNbdHenowN5ttDIvg3FBYKJR23BpNk=;
        b=Ov+Oe4lYs6zO6oIB5g+fVx6ZNSNGdZIzr6FZLUCB8QilYFOSMc+pz8X6toelRQ8zCY
         xXv9BLF9dMZAD4KJ1ZFjqyrHpf+nnnuICqsF/Ca6cV6PFEcwqQvJRD2B3IPqz4WDsrJc
         ef3iUAxUs00juedWdPQUc+22ztGkkLmsyL2QNiatuZX7kl8x31D61v80fzJJSfIcl96V
         xrbOHHfAy4TlQ1nu5qBNM1OnsQrMzQjepE5Wt6zal/N9HZX6Zr4FzVsS4CtLctSNhxqe
         kYc0j7lLcEqD4GzKHr2T6C5XcLzEU8wtKQViVHoiyAXl9etMD8SluANVKhyQfi3dH795
         MfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206634; x=1761811434;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKDRSgjVAiSn1RNbdHenowN5ttDIvg3FBYKJR23BpNk=;
        b=MlhO7q/48CDP4WRsNZeYdKUZHuLKY3f56KhAZOI6oAQpwL6TR5SBxVC1caJQe0N3kp
         2Lz5NXR1yX5oujgcLIP9cz+Jc1+Cc8+EIR1JHFwQFDE7iAeDvcbmBpOV+dyf/Gyy95zJ
         TAl5ooalk1LB009sMOzsYwNjf16f2InnU4bxixzrme5bw8HWWDJdZsSc4EMYAQCp6kFP
         x9N4ZXjQdUjiEJG/7g+hOXiLkXt/Bb9YbR8jv4EiUGEyOkjOa3O+gRBaQHajurhqONve
         ZbJeuLYmB8g80oWOqiZ4xuUYwGE8taxH9/ciAQIDxuoAwiJocNx0QeoLxudGoQOX95rm
         t1og==
X-Forwarded-Encrypted: i=1; AJvYcCWivcqvqNOTidwS8YlO2KWC976VIYJTpNeleKfrEuozeOgMa0VMzgWygDJl8x/xOd/SweN3KB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljtMdyPe/tTob+LHsNYI1CQI5TBkTq2n5ukzOnu0PP5s47f1u
	BGsGMcu9pS3+BYB3XhvFqNT6IGgzRpPqM1QKV1Vz5rPnrLQSZoTXndDpDeAXe80IZ9E3K0q8jqe
	u70i/maoWXqkergVL8OjYZPMKx63AS0Bx3wi272sauCH2pBSYAis=
X-Gm-Gg: ASbGncuuOLEU8sjebZ7CoKk/6S3slea7xqKzXWeZOB/q96ydyPJ/+EwRfP0IeLBELLG
	rv9xvueUbB/KZxzTjS8LVCMp6wOyZfTimA70qpWxzaWnHWAthosc0Y/25LMmV152zSCkyoiwH41
	Q2CgErI5GldCoBB1aWLZs4Zt75dNZTLkT0iflBl28HX9XkoBU7kNz9jK3t4Cm2DZtJWNkm6ZooF
	vNbsvSzgzj74qzxqP1sLiz9tuEkuOblUZsrmjXS3CI7o3JG/bwn+xJRDC1N+A1L7suhDIOdJWDv
	jFhgbNcgucCfQHjrPfbUxmDUFHgMGz3pa9O1DB40yluDqA6Q5kxOWJjhoAJsIildqRLGcg/yW4d
	8ndTxlIVCaMCh5S0virMVfg97Lq4I65ja1pTA6H47B0sLvcHRLnxsb8AaoJskdQfocCivsO+jMu
	P+1QXoBWoz+rjJOEajTRuxH0fXvJNGw8W3zlWaTI2VDiQn4V84Kw==
X-Google-Smtp-Source: AGHT+IEUoMFyIcSzf/zrkQ8D3mNyh0FxlQfqGIjWZsP6gj5hs+WTut6BFpxR8MCgZiPwh4euSVev+Q==
X-Received: by 2002:a05:6402:40c5:b0:637:e4d1:af00 with SMTP id 4fb4d7f45d1cf-63c1f677665mr22946465a12.10.1761206633722;
        Thu, 23 Oct 2025 01:03:53 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:b0b1:8b9a:6340:3213? ([2001:67c:2fbc:1:b0b1:8b9a:6340:3213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3eddc237sm1060834a12.18.2025.10.23.01.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:03:53 -0700 (PDT)
Message-ID: <bd5478c6-8d48-469e-a6ac-02714d19d2b5@openvpn.net>
Date: Thu, 23 Oct 2025 10:03:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] ovpn: use datagram_poll_queue for socket
 readiness in TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Ralf Lici <ralf@mandelbit.com>
References: <20251021100942.195010-1-ralf@mandelbit.com>
 <20251021100942.195010-4-ralf@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251021100942.195010-4-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2025 12:09, Ralf Lici wrote:
> openvpn TCP encapsulation uses a custom queue to deliver packets to
> userspace. Currently it relies on datagram_poll, which checks
> sk_receive_queue, leading to false readiness signals when that queue
> contains non-userspace packets.
> 
> Switch ovpn_tcp_poll to use datagram_poll_queue with the peer's
> user_queue, ensuring poll only signals readiness when userspace data is
> actually available. Also refactor ovpn_tcp_poll in order to enforce the
> assumption we can make on the lifetime of ovpn_sock and peer.
> 
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>

Jakub,

fell free to merge this commit directly to net, as it's not useful to 
have it go through my tree without the other patches.


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


