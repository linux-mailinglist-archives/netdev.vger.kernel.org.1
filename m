Return-Path: <netdev+bounces-190463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1429AB6DDD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771D11B680B5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7806F18FC91;
	Wed, 14 May 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WKoEAqzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084417BA3
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232010; cv=none; b=RzOocsdSdzUwn6i+x7tsvpUu7eb2cQQYXEJe1+49W2KQVIiQEvMNCFx1bagOGsc1PwpjXuhwotKqM/7ndpntR9oj+w939HLAcBQMiD2XDqtkrVzxbS9kzNfxrC6O7LzoXTptwRCScEA7BTaWKrF7J0m+OO8uRhR1F9KVe+w9lic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232010; c=relaxed/simple;
	bh=5qkEHq+7ghacsiNQ/VBYo1XNNtjinlxuGGCVzqaJD9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n73+aLmRuyz21YRb06psMyBuigaN0KQjKr+EegysKT17b9djdfFZyZYys3Xwa7A/dEltFzbbzPNgguCNZ7sFWGIt4Q/Q90wY7KnIIut2VP/mH21Nhez0v0G2t6Z073ZcInDNWa53kY7MHDtkXp5DuHPhpiozgHILIXQ21NLI7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WKoEAqzq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso4017641f8f.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747232006; x=1747836806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CUSvS0eBl8C7QUfj852P4UimprtKLZSAqBFas6IzGhg=;
        b=WKoEAqzq7aM7+/OZKMYKEzxuqWQMbB88XY2O50rKv2UI6XymvxQA2O2N93CG/JaHII
         z+4EKRNCRNug7KIzeJMTG5nj3tTWk613E2EN/chmSfGWJllJNF3QdV66EvWuaWtShwM/
         mbl6KOhLgwDl0HA2XmM3l3WMxrkGy9RFUHAJNahGPzhomF1GWXN4kq82HlHILh6+9Xa3
         JMe4hs5ZDSOsTr3Ypb+wxqfF9kzNpXx6YoG+tAGhXkW82Qt17Yc+j9cEb5WMaJ+hQNww
         eycF/xMVp6U8vsaQri0yFwgVnZeHZ6TlgBxWK3TAnxXb0oEwiDphPDI9W6tKEuGPShKl
         dGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232006; x=1747836806;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUSvS0eBl8C7QUfj852P4UimprtKLZSAqBFas6IzGhg=;
        b=SX+KNmQdUL+fsp7PWQ7XjyYVT298tgaGNWadss7tK2DsU95eNjcRVuddP0lIYqGPSw
         Dow4z1D56RSOqE15cA28zMSHWhwb2jhD+9bB2HUzXSzAPKmqko9NMYpQeLBZBgCMP3Y8
         77F1MoKtrOPtlsZ1BDhGmN1JtKFeFoGio8q9+lu816+F2SwhLi2C5wbt5C6OW5n4DkXB
         PrqhH0LqAVoJwmEWSFCUUGG1h/I1f4bOdFLGdQraqqEXk/E597o1hBa/va+fiuhPBSie
         cmcD3EYZFP1UMF2gC5jtqWVXVIeKWRWRgcV5UpP0ApeRspG/6lZVFW0lS+koPMWILXSl
         d4xw==
X-Gm-Message-State: AOJu0Ywak9cB2DJcPsAAaAdGZf3MVGDM7unpSdZpiJb7djSJkxocgV6z
	TGqE3tF3bGf7br4PPTlax65Qffqyo6RdgTCdQgB1FuzS976eOezdnJHuU+YYlu2COasQz3EfxxP
	z54gcJfEGE1TnyzpQp86BimsadPBL3dVqY3RvHSC/qxFbY0mWKX4QexA4m/sh
X-Gm-Gg: ASbGncsKCNQ9p8wuPYtciyIL/5nJOHPakVULS0Lq3RiUvc+F49wk4R/q6kXa3/kX2FI
	LzK9N2DyGzpctYQ0qXKk/36u9XmmdmhO9RuxjnNh80s/Od46YOJeJCQQq0Qd0KZxvjUzZJ9bS8C
	Uf7ZvesyHo6Cgk/HmwTuAGY9ET6U0uyca1WoJfj9FmobmU4ccd9hjRFSWeOvtFl6y//DZmmG6TH
	id3dp6M2fiVxivqIqjulmTActN3Gk7EBsi/x0Jtb57xnk2HnJQgQNvLmkUuSTmINCDaTCuEjo+5
	Pkf7nfTZ28B4b+2laJe4LoIlPX5BeGmUSdWU4hv+QpaiaW2rjyu/UKGuspMhmH/4OpREybM2qL1
	v5nHk0/pg7PfM/w==
X-Google-Smtp-Source: AGHT+IGjHyeGsGNILYKcukNlGmhM7Oj8jTYjUl9JtCf6yNaQlKfW5nibJ6DVqZuVLkWI6RPwBKV2pA==
X-Received: by 2002:a5d:5f8a:0:b0:390:f9d0:5e3 with SMTP id ffacd0b85a97d-3a349694ab1mr3254106f8f.1.1747232005952;
        Wed, 14 May 2025 07:13:25 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:885b:396d:f436:2d38? ([2001:67c:2fbc:1:885b:396d:f436:2d38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm19773593f8f.75.2025.05.14.07.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 07:13:25 -0700 (PDT)
Message-ID: <3dc6a26f-e02a-4518-ab12-5a1b39b4ae92@openvpn.net>
Date: Wed, 14 May 2025 16:13:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ovpn: properly deconfigure UDP-tunnel
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Sabrina Dubroca <sd@queasysnail.net>,
 David Ahern <dsahern@kernel.org>
References: <20250514095842.12067-1-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250514095842.12067-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2025 11:58, Antonio Quartulli wrote:
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -442,8 +442,5 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>    */
>   void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>   {
> -	struct udp_tunnel_sock_cfg cfg = { };
> -
> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
> -			      &cfg);
> +	cleanup_udp_tunnel_sock(ovpn_sock->sock);

After looking at this some more, I think this is still racy.

We have no guarantee that sock->sk won't be nullified while executing 
cleanup_udp_tunnel_sock().

The alternative would be to change cleanup_udp_tunnel_sock() to take a 
'struct sock' argument (the 'struct socket' container is not really useful).

I see that also setup_udp_tunnel_sock() takes a 'struct socket' argument 
although there is no need for that. Is there some kind of abstraction in 
udp_tunnel which wants the user to always pass 'struct socket' instead 
of 'struct sock' ?


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


