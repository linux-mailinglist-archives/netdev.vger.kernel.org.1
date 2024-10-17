Return-Path: <netdev+bounces-136460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F519A1D6D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF6F1F21B45
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E11D47A6;
	Thu, 17 Oct 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JSyi44Gm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FE1D27BA
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154543; cv=none; b=Gg0nNxyI8dRrJCeUy36xPqBWOOVZyM9xW3af8qk13uUZSWxnYfCebHQkQSDYAjL3xl+g3SdDMejnMlCu4GC06pZFJeswVsAaYjOO3LKN6CVcSc7wITfo0xjG6p/r1QGf+dyj8O/jT0kf846rNg9SmMW6fIEzV8PbMm4yxN37dCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154543; c=relaxed/simple;
	bh=imPn2OPqQjFc9uR/Yy7wp5dlQvYjTRKKCHXGDkaSesc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnSX+f7P1SV5QDQGNryjueKoENrTLMRfL9rgijYZYFkBa6qjzLBMJ7qiUyJ9wJhNCQHPOQFfB4MMoZ3v55+G32TqjDfQK/e1vqz8YFT4BoerCmUOk+Ax4+f/kth5warxIWB639fmzh8EUqLZE6ZAbJGeSV7ELyJsGB8/jEpOGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JSyi44Gm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d325beee2so323132f8f.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729154538; x=1729759338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWiM0Qenq6snzqlNmhPji/4J58MYPGrBoRLNt739ca4=;
        b=JSyi44GmLja+vBAWU983gSGJwijYIj+UzlPCRQy5XIIZmEowc8Gk02IcLN+FcQZmjS
         ro8eVp4bzqxBIXCgsJdHe0/NNIfo2pyaIEKxi8pDe8KGBrJdiE9UVIaHIKRLRzgt90lO
         gLSLp/lvUpJER+rAeARBvkivZB/LMaUM/9O54W8Dn2wznkdN06snSx1PcGQIO/ZcqhBZ
         PsuvwbVbhf00tKCRporihlF2VIiNptzbOcnniFh+pc5KRyf0jJVfyW+P6a4Edb+QZOCn
         0U8Og1ixmBfN+Djy5tdozOvO5TQE8lhHEZ7HCyjlDkAuK3RkM6iwVQh7avzTdpXvY+gf
         6iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729154538; x=1729759338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWiM0Qenq6snzqlNmhPji/4J58MYPGrBoRLNt739ca4=;
        b=JYXwVKFvuHXROYGnCLLT90P99a8AZCaDrYaHF6koQ6enm66TTvYDPZdP81V58qLyep
         jvY8njICumngi5GLSYdQ3Ww2RBuoIHDEUkLPA26gLX4/oBjNTa362DDuyuUAYx3jCqtm
         BZaGxNrGRzZRLrFPPnfwFWdecdSX9zM0s6l3+JOjR6wbfzksaSnlA+8g0rU+PFxmEJtc
         h68a1DTVEmskiQ+P2RyTdMlOOj4tS/fZ8L6IDaUFU0pgM9RrhZPsHVNd0fZWWJiUMcj5
         IycPUJkSqV8RFCBo9X7XjXdw1S/2o1T6FboGlC6vpAdAueSnwzKQhqmyOMN8cK8k83SM
         gaNA==
X-Forwarded-Encrypted: i=1; AJvYcCXUOmAnnNQRLPg8lKx/OKEUWVTAJTRtlsWdULwksBjZvgv343Sm55Hors8RA3XzBmt9HxikdPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIX8Z8WWmxmzznRVw6YO8lyuYrnaPkhJ2YbOq5AqnZQKG+JAz
	nLjOVfR/6MdvWOsGrM0B/IoKPBN8Lq8tfTBHzvNs+ZMwesw5Hf/8k2cO4XfQE/i3XgxS3VTnBBX
	Tr6M=
X-Google-Smtp-Source: AGHT+IEVgiUhH7ucVS53sBlraWGR7a3R6U5x91liQX4kmZ9vX7R+oJ19gK4jpj1dZi0K4wFZR1FHNQ==
X-Received: by 2002:a5d:47c2:0:b0:37d:37e4:f904 with SMTP id ffacd0b85a97d-37d5ffb9976mr14581893f8f.36.1729154538508;
        Thu, 17 Oct 2024 01:42:18 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm6534498f8f.25.2024.10.17.01.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:42:18 -0700 (PDT)
Message-ID: <2b710dbe-3a61-4ec7-8205-73139b8a4170@blackwall.org>
Date: Thu, 17 Oct 2024 11:42:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 3/3] Documentation: bonding: add XDP support
 explanation
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241017020638.6905-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2024 05:06, Hangbin Liu wrote:
> Add document about which modes have native XDP support.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index e774b48de9f5..5c4a83005025 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -2916,6 +2916,18 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
>  then restore the MAC addresses that the slaves had before they were
>  enslaved.
>  
> +9.  What bonding modes support native XDP?
> +------------------------------------------
> +
> +Currently, only the following bonding modes support native XDP:

If there's a new version please consider dropping this sentence.
It just repeats the title above in a different way.

> +  * balance-rr (0)
> +  * active-backup (1)
> +  * balance-xor (2)
> +  * 802.3ad (4)
> +
> +Note that the vlan+srcmac hash policy does not support native XDP.
> +For other bonding modes, the XDP program must be loaded with generic mode.
> +
>  16. Resources and Links
>  =======================
>  

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


