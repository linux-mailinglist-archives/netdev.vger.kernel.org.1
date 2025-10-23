Return-Path: <netdev+bounces-232128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA92C0183A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CA31A681AD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F03301037;
	Thu, 23 Oct 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C66+2BRk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CF2264C4
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226758; cv=none; b=PhUBZzMhlubDiowDsQzU3m45VA4IDt/lSf0kSwoiQZLCRwMkex9VF6cUHj8mP4nUwX+uJXeYsz6eyGpKTRBQtGkTfejOoK7bbJcJtK+keqgOhV70qPeCZ4LIavXelVUvC0FfulAKYpfypUKOhbbJMW4xP7wAJGIYxuR0jN41t/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226758; c=relaxed/simple;
	bh=nLCvLEkdc5q+ptZjzAZ6ZBYvlPEoBZk5NFegoEmROpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1wZTsNqxDpY7BRrZdfmtBeSJmdJCQCM+RaE2xu6SzDXkxqWEB/KeOoC2uPMh+oIv5BOZo0aX955TJ4700XXK6RUYk+U5nsd0t9CqehzkfZs5SaYvhwt21XYHrhV6aGDUzfLz4JsSY2q7l9r/JW1xn8KghC8mwqyWVd5NOcr1hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C66+2BRk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761226755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hRnqWZfluM80j2wuvefphaYJkh2F6l+zMWl7pNJRz0=;
	b=C66+2BRkayp0qSeDbqcVfV3vLXel/XwzNr18HVYcrc4uICdnRnD+gyXTDcubHV/J+JWvIf
	gdeD0EfC0V171tKL4dZanLw/Q+tfmh2SUYBkAoXES9AMcjDJna0qFPcsKQyGcRmjU3IeAr
	l7qgIjTfvGlmDNkfyUNG09t+7feAQwQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-uQQoCAx2MTyN15tJiNq0mQ-1; Thu, 23 Oct 2025 09:39:12 -0400
X-MC-Unique: uQQoCAx2MTyN15tJiNq0mQ-1
X-Mimecast-MFC-AGG-ID: uQQoCAx2MTyN15tJiNq0mQ_1761226750
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471005f28d2so5020845e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226750; x=1761831550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hRnqWZfluM80j2wuvefphaYJkh2F6l+zMWl7pNJRz0=;
        b=i2zDa/DwXV9boIbcM4gwatut49Grha/ejyJsFE234clGhqAQ72qUlMyOhaQazJuIP7
         j8/Va1fOmU2XKwgZCJpqNn+BOS85TQUvDuwUL/ItEdfywVJqg6QPUnLrM2nulYYo+CC5
         nZb+qXg2tlrv8A6lPEZ6zns2Fn7FOj9ebz73CNtpAvbAYEpuiC05UdATpm89b5fCYg9t
         ubymDJNt/HMh0EcFvbu+zXqRI/+q+B3n/hZCiQgaICg8E86ZCfmVfcEfB9uNtEjsPftZ
         MHdGBmmR3kLtMRqf3PdzBQPdtB6GUt4TvmPTBpTe366bl8D6K8ZA8ic1GCImaUtj2Ed7
         SwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8nqKW5OiYGjRnQduS+skXJQ8ScwIdTDY1yk+C4cbeC/hOw9OhhFhHvExdULIu/nwAPf3Ndhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUzAYThYlLY9SAQmcQcVhOBMIXCwFGI7MbDfXoxFb9SAcMpYl
	GxWRUFejTNrkLxdhugX173W3rGU687KHEuju9OXEKD4R2M1lzRAFwX+DzV0+gC2seAHGPHycv6D
	gH2xBNDEFqKaKP34lZiS1fkHnLHUiXLcslVOeP8fxlZK1wHT2M73Ju5CN+A==
X-Gm-Gg: ASbGncuU+A9KA+IJIfKFyz4ciOEDt4ke43xjLo0FN3DEWKB/0fdMmVy23IxJ2wsnQP9
	ZyUrFJ5I7BZaXnzjxU13QJkTuJXCdyTgBTsYLQJr6PkN2sxMG8Y1JKpaoscvqhd34F5l0sbKY6O
	9QvMCsEEj5fa46I8iU5XF14IkmyvExV6wjbPHk0eortezDrb3nL52McNu7a3pSuKMcbqdIGSMcY
	btHahVMYJZ2PBvwwpxbqd2bGgpkyyc/0g8D0XOOg2Vw8AmatD+KK2rWazQ+DTpK8EC4ugbbFwal
	aDBirTZJhWGV9ckNhZ8mr3U8NThTCCIrRERaG3g7+pOzpUAw+/jBNu4Tkirclhzn5TLmZkJYjm+
	WMAGiSqQNzbTGJ5j5kpjwCwaxDS5REcKFCr8Zpy5pBVmpWRg=
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr172514655e9.5.1761226749912;
        Thu, 23 Oct 2025 06:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhLfDdm1Baiu89q1xz5zPuRntG/uiMjewVHvOV38lU3g102EskTDW+dqa0AcTwp/f9+N+bBw==
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr172514505e9.5.1761226749560;
        Thu, 23 Oct 2025 06:39:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342373sm116434815e9.12.2025.10.23.06.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:39:09 -0700 (PDT)
Message-ID: <38605efc-32f5-4c78-a628-11f8f07668f0@redhat.com>
Date: Thu, 23 Oct 2025 15:39:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vlan: sync VLAN features with lower device
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Dong Chenchen <dongchenchen2@huawei.com>, Oscar Maes <oscmaes92@gmail.com>
References: <20251021095658.86478-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251021095658.86478-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/21/25 11:56 AM, Hangbin Liu wrote:
> After registering a VLAN device and setting its feature flags, we need to
> synchronize the VLAN features with the lower device. For example, the VLAN
> device does not have the NETIF_F_LRO flag, it should be synchronized with
> the lower device based on the NETIF_F_UPPER_DISABLES definition.
> 
> As the dev->vlan_features has changed, we need to call
> netdev_change_features(). The caller must run after netdev_upper_dev_link()
> links the lower devices, so this patch adds the netdev_change_features()
> call in register_vlan_dev().


> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> 
> I’m not sure what the proper Fixes tag should be, so I’ve left it blank for
> now. If anyone has a clue, please let me know.

Apparently the issue is there since fd867d51f889aec11cca235ebb008578780d052d

> 
> ---
>  net/8021q/vlan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index fda3a80e9340..4857fb0ee11d 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -193,6 +193,8 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
>  	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
>  	grp->nr_vlan_devs++;
>  
> +	netdev_change_features(dev);

Is this just for NETIF_F_LRO? it feels a bit overkill for single flag.
Also, why netdev_change_features() (vs netdev_update_features())?> +
>  	return 0;
>  
>  out_unregister_netdev:


