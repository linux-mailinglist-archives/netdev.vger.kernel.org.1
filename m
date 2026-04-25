Return-Path: <netdev+bounces-281131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JNAKf5H7WmJhQAAu9opvQ
	(envelope-from <netdev+bounces-281131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 01:02:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77D4683E6
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 01:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE345300809E
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE04B38C2A0;
	Sat, 25 Apr 2026 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njUgew/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA138838B
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157390; cv=none; b=HOoXBwrZe4Jw26d+vnZBWCixsYsJOUj+vN/2jnFVs1H+BouGgJBAjxiMMZkTjbe8M+YqZfaMVINjV3474V6aWenOd+aGyyV97aJ1jJohTISYev04EkCKezeqmUagrWFmZp7EO2JD1yivFAu9O3koAqeY3VYjd0s7uHy6JQrE5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157390; c=relaxed/simple;
	bh=NlJmQ99Eo2O4AE5jLnxX5tS8FjtsFDwC/kEMUdhH/to=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nknmmRyj25LKuwdEjAJRcB66tmFlAYTFA7OGEw/DL8fQzW0bXjSyHBo8xr6wrQMBQbNtyyFUi/ZB+jbXLAylRrgSeSlsSJ1Uzy3D2QmJ52ybqGRYD4516AaRr7UvGUWfbqv6F3+jnWK9Og/MvqM63FXawACcCakpu9YtcZZ9Rls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njUgew/0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so112392375e9.2
        for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 15:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777157387; x=1777762187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylk6+welFEnDY94rahWQ7HvD0zJjqoxic/dx4PIJEZs=;
        b=njUgew/0gxIhEm89BpgDShxUIrYjheWBreT15WL/ta4TQe9um/zz0ZtYGzkOXNxm5L
         IwkT1qUE20boc9rhEXE2Q1JIYGA+bHOOnxG32g10Ja2QKPOEBNLihH5/v1T7MB07D+qZ
         Z5HmMYKDNZY9yD+88fMS6lJJkmFqefQJbuEBJXtWgYMbqFhtTmPxYHvF4LLthOu7wfnm
         Bvc2tfZdZmI0v3kBi2PIDuZcUCZab2pjrmWTkndhG0ATKze0s/1iggcM0FvR6PKPleGc
         MhHmVkmkkTZS2OnhlgS1PFl1WEkmN3bVyR9q7u0O6WvVL6b2NV72boLReMg8Aza6VXwf
         kQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157387; x=1777762187;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylk6+welFEnDY94rahWQ7HvD0zJjqoxic/dx4PIJEZs=;
        b=QhoFddj12boNxP2FCJ7cUO8Pqpzwak8hbM/rXMfS0HWpk+HQxBcpsna5FOrDtpZ/AQ
         DjW2vb398EivuPwr2clhqXcs4ByFa36HK7mOqaOn+Zqwd/gZft5fbIG59+S1PUYXmFAu
         yY7HODKCszFjMKRkLckogtsuSu9Ge9AfpuM0hu7v1jkgDtQ7TG/f0/gpe+FSPWp+LApP
         9wKy/xvn3F8wDuHe6xRYqgGsvhz0O1P6lTLduNxo4QJaH2SyNECeOfyNKXVwanAs/rmz
         7jAPOGE/l9HcxJX3puPnuma9+T3GPLUotsy+s7n8Yb/WKQayUCNdB5WqBZapQKim/HEt
         S1iA==
X-Gm-Message-State: AOJu0YyEeQRCSK9sSE5r/HGszMV/TQk8fRFyfPYL7rRYxk6O71Le9HB3
	8BGTKgAEabzqGtXVQ6oTt/awS0zsSNNp0W3ZOw/eH+HUTpiPR7gTLRkf
X-Gm-Gg: AeBDieubtHPXRu9PVR17Zu00izgYImCsXJEtBwTmMbmNKw1c4Ailt3ICjOwmGNu1kqv
	YEmK/2JURADfgHzDmo25TDApQE47jJVD6OTrAwYHz/QJGMIe0EHMUW+3SoBplXtUHXjI19zQT4f
	rxstIEUAjM4H/WTh+Rn/wvDfbcWUFCI1VEswjtfx6Pd3Q5CggI6uDyaRA+EHQ3I0TxwvDH9Lqqa
	tylS2/+hAgjGwS0puS4W4j/isb/qLm47d11HT98DXw8ZRx6u52SkGQHO9Bp9+qvMqANwbePI3a5
	BK/ymk5wViPGMfckQZ/Anw8+Kv63GwuzzNE7O18Z2AIDhj0ZXDY08ikv4iyw65BQ+CSdZXR3qrw
	dAEGovVDO3B6GHUJq2Gb/f3xLXXNsmKaNDz+7ZEdMtu0TPe9KY6r9+1DyUzF5tt2AmRv5Gkt8iI
	7Mwhx4TvXjr/EQoUm67Huq2HXCqpvFEbOlWOirdoI6ChnCPz3LHjcN2hM0InTT1jZHPJZHtfkpd
	go+tdJFjp3wZdJx0sR502/OSvUqcU7u/JA4AZ6H7zUx15ChWer1GCZY91oZOnQI7CNcPYINU54i
X-Received: by 2002:a05:600c:8717:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48a568faffemr311297045e9.8.1777157387464;
        Sat, 25 Apr 2026 15:49:47 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f34:b800:6020:70f3:48c1:ca3e? (p200300ea8f34b800602070f348c1ca3e.dip0.t-ipconnect.de. [2003:ea:8f34:b800:6020:70f3:48c1:ca3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb754842sm210753475e9.8.2026.04.25.15.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 15:49:47 -0700 (PDT)
Message-ID: <39a35232-479f-4390-9957-dbafc3f3c468@gmail.com>
Date: Sun, 26 Apr 2026 00:49:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC Patch net-next v1 0/9] r8169: add RSS support for RTL8127
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC77D4683E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281131-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:email]

On 20.04.2026 04:19, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch adds RSS support for RTL8127 in the r8169 driver.
> 
> Currently, without RSS support, a single CPU core handles all incoming
> traffic. Under heavy loads, this single core becomes a bottleneck, causing
> high softirq usage and leading to unstable and degraded network throughput.
> 
> As a result, we add rss support for RTL8127. This RFC patch is just for
> discussing. And we do some experiments on AMD platform. Below is the 
> result.
> 
> Platform: AMD Ryzen Embedded R2514 with Radeon Graphics(4 Cores/8 Threads)

An older embedded CPU (AFAICS from 2019, refreshed in 2022) in reality is
unlikely to be used with sustained 10GBit traffic. It would be too weak to
handle userspace apps making use of this high throughput. This hw edge case
IMO isn't really an argument for adding 1.000 LoC, blowing up driver structs,
and adding the complexity of dealing with a register layout changing every
two chip versions.

It's really a problem that Realtek frequently changes register layout and/or
register semantics in a not backward-compatible way (and doesn't provide
documentation), resulting in ugly versioned stuff like the following.

IMR_V2_SET_REG_8125	= 0x0d0c,
IMR_V2_CLEAR_REG_8125	= 0x0d00,
IMR_V4_L2_CLEAR_REG_8125 = 0x0d10,
ISR_V2_8125		= 0x0d04,
ISR_V4_L2_8125		= 0x0d14,

case RTL_GIGA_MAC_VER_80:
	tp->HwSuppIsrVer = 6;
default:
	tp->HwSuppIsrVer = 1;

This messy hw design makes it hard to develop maintainable drivers.
This is underlined by the fact that Realtek has separate r8125, r8126,
r8127 drivers, even though they share most of the code.

> Arch: x86_64
> Test command: 
>   Server: iperf3 -s
>   Client: iperf3 -c 192.168.2.1 -P 20 -t 3600
> Monitor: mpstat -P ALL 1
> 
> Before this patch (Without RSS):
>   Throughput: Unstable, fluctuating between 3.76 Gbits/sec and
>   8.2 Gbits/sec.
>   CPU Usage: A single CPU core is fully occupied with softirq reaching 
>   up to 96%.
> 
> After this patch (With RSS enabled):
>   Throughput: Stable at 9.42 Gbits/sec.
>   CPU Usage: The traffic load is evenly distributed across multiple CPU
>   cores. The maximum softirq on a single core dropped to 63%.
>   
> Patch summary:
>   Patch 1: Adds necessary macro and register definitions for RSS.
>   Patch 2-4: Support NAPI and multi RX/TX queues.

Driver supports NAPI already.

>   Patch 5-6: Support MSI-X and enables it specifically for RTL8127.

Also MSI-X is used already.

>   Patch 7: Enables RSS for RTL8127.
>   Patch 8-9: Adds ethtool support to configure the number of RX queues.
>   
> Javen Xu (9):
>   r8169: add some register definitions
>   r8169: add napi and irq support
>   r8169: add support for multi tx queues
>   r8169: add support for multi rx queues
>   r8169: add support for msix
>   r8169: enable msix for RTL8127
>   r8169: add support and enable rss
>   r8169: move struct ethtool_ops
>   r8169: add support for ethtool
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 1437 ++++++++++++++++++---
>  1 file changed, 1238 insertions(+), 199 deletions(-)
> 

Series includes functions like rtl8169_desc_quirk() indicating a need to work
around hw errata. Would be helpful to add comments describing the hw erratum,
best with a link to documentation.


