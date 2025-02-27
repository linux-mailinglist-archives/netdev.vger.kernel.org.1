Return-Path: <netdev+bounces-170064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6FBA47168
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C7D7AEC30
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D651D89FA;
	Thu, 27 Feb 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aAbq0dbY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57F1B3921
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619802; cv=none; b=oFbz2WQTtXpa3T+l5+EL5UV1Q0kUEBhcnZk7sKiPxU+0gbWJ0g85Cxqcy05V5u8LHH7pvGga9zYEyr/2X0AnU8kcN/TPquLuR1s2EjaojhYMZ4x/Ab99CMXYi5SAkwwOLMu4nGl2uYO9giVZhR1ZIxrTtVbcPMOFLUGl2S+N8BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619802; c=relaxed/simple;
	bh=B9c3y7NZWNq6ffLWn9Hk2e3RjY4Yp/8tjJZUo2bib0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKFYXCQXdx/tkE9Li6hQojD5Rwt6tKftoAjH5iViaAqO4RCpBcEesslLSJixycLBN4E8N5fiqZpUsGKX3tGeH9MiOizvBFMg7MfCWerVp+wN0K6kvsZQK6LQbWKLOkYBTps2hY0atT0/hpfDYwZ+GKUNddJz577bJ6EixK6tzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aAbq0dbY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso56300266b.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619799; x=1741224599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ktrxip9yk+a4pdJICPiWdWVPS6bBOwoE35ORjcqdJOM=;
        b=aAbq0dbYjHBZScK6HOse6WwumoaTWWWdDG/hb8MMKzJaZ0Blgutip634Ja8lwtVK6T
         BWLFpRoLr1QVO6FdFfP9lJvLD0oYC4wh/p5Ym+KJIEiZCCZTLJRJQdl5lyQGkOX37L2+
         RkHgzyxG1dEZ/P6ics/tzj3eIpKCQp4C/SIUBIwWT994K88aaJ434wV9ErwJ0bnz0kXb
         2V7F9wlq6Wcpn+g7LWohgWGB1pdiyTD2wSWBAqHc6o2GVixcIE2GUJvegZZSrxH5S0un
         1HFvD502gnA0OqM9q+MQq7xzByuuyn4TNvlCHLxEnCF5kEAX4QtIi0m3nqVSOgV/QQpG
         GPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619799; x=1741224599;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktrxip9yk+a4pdJICPiWdWVPS6bBOwoE35ORjcqdJOM=;
        b=nx/qaeqQtv0TPX4OxqLbooeFUKDSgmsqFS7zyLkV1dmqcvLmHCA5X8W6mcv5WYllpP
         QhQEdXFsiYmsULRVcwDa+eqCi3KvCRb1Rl6COzRbru2ydJBAJYvhx6C0LyJj7tdEURK9
         fHHVX2DicHS/9kpsbqOQAJsAZWwZVZLAqzwtjTii3otaRyX9lEy6jjIHUfQ6thxo60IP
         JZzgn9LESfcGE3H/zYQfdc1PFtvc9Fo67BzswmYqVF0eSRW7h+uqau6Humufw+ELPFyP
         lR7AAfwhWo7H3xWhi/Fd6J9MLM/ePOkOSerOQFwFFXQz8TyuZUo+oPV7dmNl8ZKm7kVH
         uNEA==
X-Forwarded-Encrypted: i=1; AJvYcCWRVIJaGJneUvC7ZB3+H1DhuFHDzVsxYwg0jNiVQge7bHMqMVxKIUefuvj2z84qx7VU2779PAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegRS+x7o9Fi19xWBnlynDbAgWXKYu0WJJjXg7uNtGyTgOyJJJ
	jUIP/cqhWz2qdgTCdJWhS487Xu9kMRh8jXITFqjVvPQXfZ9YTyS2tzDMqERixvE=
X-Gm-Gg: ASbGncscmX7FlgpSrrIQ6iUVoem+RPxO1FjBPBahXWvNA3mHtwAdKVfkV5h0SvCxO/C
	QOR5wvDzrufbVvn/Usl7M/GJvAuiJVtkGyo0gfg02QcnXtzaP7XQVeuSyGemuppCfrSCy+NIyXX
	VQ41CbnZnVMM6UzIgjs0Xdv5gZUGxx5FSXCGD4nrx/LKdGNhSYhSBNPHiFZjTqKfBENNJQ7sV3p
	cIaPYcB8OOL+e43hmcCz29pxljB+wUL31Mp+q/iBqyZa9gcE9TgewfBS8ckNhMQq067h+agfH8I
	faJgCyU+Luyrk1ihTWgvaD4m5kFJKghzJDpneSwxBOkC2nerV0RBPu135RUzroKg
X-Google-Smtp-Source: AGHT+IFNrdgBwLFhmfbGsQpDXm97tLJH8iW4Zw857mr0YhM6zDydrIbv5Wg7/bBqNbUdibh7HZOIKw==
X-Received: by 2002:a17:907:d307:b0:aba:5e50:6984 with SMTP id a640c23a62f3a-abeeecf5c4bmr824873566b.2.1740619798891;
        Wed, 26 Feb 2025 17:29:58 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:7418:f717:1e0a:e55a? ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b987asm36215666b.17.2025.02.26.17.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 17:29:58 -0800 (PST)
Message-ID: <53278a6e-dbb4-4f81-8c21-1bfb447ab8b1@openvpn.net>
Date: Thu, 27 Feb 2025 02:30:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 01/25] mailmap: remove unwanted entry for
 Antonio Quartulli
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-1-93f363310834@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250227-b4-ovpn-v20-1-93f363310834@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

any chance to get this patch merged in net-next, so that I don't need to 
resend it each time?

Thanks a lot!
Cheers,

On 27/02/2025 02:21, Antonio Quartulli wrote:
> antonio@openvpn.net is still used for sending
> patches under the OpenVPN Inc. umbrella, therefore this
> address should not be re-mapped.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   .mailmap | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index a897c16d3baef92aa6a2c1644073088f29a06282..598f31c4b498e4e20bffd7cf06e292252475f187 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -88,7 +88,6 @@ Antonio Quartulli <antonio@mandelbit.com> <antonio@open-mesh.com>
>   Antonio Quartulli <antonio@mandelbit.com> <antonio.quartulli@open-mesh.com>
>   Antonio Quartulli <antonio@mandelbit.com> <ordex@autistici.org>
>   Antonio Quartulli <antonio@mandelbit.com> <ordex@ritirata.org>
> -Antonio Quartulli <antonio@mandelbit.com> <antonio@openvpn.net>
>   Antonio Quartulli <antonio@mandelbit.com> <a@unstable.cc>
>   Anup Patel <anup@brainfault.org> <anup.patel@wdc.com>
>   Archit Taneja <archit@ti.com>
> 

-- 
Antonio Quartulli
OpenVPN Inc.


