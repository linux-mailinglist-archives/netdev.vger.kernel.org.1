Return-Path: <netdev+bounces-152556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2209F491C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926801619FF
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F241E3DC3;
	Tue, 17 Dec 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dZsHYjmk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CC1E104E
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432191; cv=none; b=WdYvyuObLAAONVYQ6HiENSiXl5J2cvtgcBOyjeYmSgvBbLrfwYDfVI/WqwRMWf90uypkHB6g9Bu+fgCmO/kqDNqG9zTGDCkXYTDIDz5ZpIxFSA3zguhquBs+4wLAxQM0aioEFQcXRdbl7jGjqfFC7xJ3AfI3GYmVLfIBDVvamSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432191; c=relaxed/simple;
	bh=y6kN0ytC+JEAm663I+e3ce52E/uTgwxjwdVw6gidIJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YW1ZoRD6TShQggTDz/PZebcKCJk+QATxOJMgVeEicnTaARo/g+Tjux5qA8GsrJzjZZTc5rZ2Tug35IyvrwXLtnMkVRBc4NJjs1frWE9EGOc4O608xX/r0u7fxvnj6ukObXcU6lUgsenJQoXjO86nE9tCKzuAp9p8wFd1PGQRUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dZsHYjmk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso25095625e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734432188; x=1735036988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=dZsHYjmkhvWBVsm2tNMZTYJ6fifUvbeljbA9rzuGPR4hxzY9sTa1bgk/BveyCJn/Bj
         010mgKQbGqWAeVoFnqoxUE8FX0smvn9wMVd8zLeNMV24ZhSGjjzHDVtstCR8LNh+dOQt
         RQKEHwEtPbCHTIFgMWzJwak1Sj1f5c71F8Fz8X2nUb5qtVihBlaJQ/dkqeAbhgbBxC2e
         bDL6ufuTtwJ0M7OtKhA6d7ncZ1Tf0zrYh35377rPYi/q5NqCA73aCAc2pj51VmqrV2KO
         YO6CUv3jdCn+/5p/brlrKV8WwhevbP9z6V3pTnZU0dVjSuF16UY6u3A3ZdfpCfxcO2+o
         GDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432188; x=1735036988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lPpgSVaAv355PXrM8WEJ5CO/JUa9i24YlHdFUS1Mag=;
        b=TCCWDt0jUFiKV0aqi6GrdOgONYzSbq9WP00Bw4GiJ3L4Dv3NicKS529iZu4hBmF/qJ
         i1aDxaM/RzIYJQtXJbBf8M4oT0HPWIsqEjB8/iKoNfIfimT8kRlY+870nzLAv+PXMajS
         ViAB0mcOc3CwoyMrZA2wfxLBYwG/DZu1oRZm9vi94ofznDsC4SxOZpXxlP5aiVUXt/h5
         +3g5nAkrzTsigOxAo1e8B9xLQhCIJI5+B0hI3xwcudb3CqYeVkN/1HvFNMqUO33glaGT
         fzirqsvsW+sva0SWbulSHnx3rOWHciga+ja5wBobEYuDk+CK61ZywICYksyHVBl1ZEJX
         UWEg==
X-Forwarded-Encrypted: i=1; AJvYcCWbTwgOjiINVZxfLK2/mL2e8ssvntevANIws4I9lMhoG5mdzjHZ3dZ7LYpjN+txAuNCIB3JqNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dXV5mSryIZ9UJZjdbqbNLJ6RkZLeC4VtMCwg6mdrQrOoABBR
	16TIrj0Glzrytqrp4abceoY6q3+kHcktrJwSFvVA2Eau+EEKLbpW+DJ+a6n6/m4=
X-Gm-Gg: ASbGncvMQruTXf2Wa7GiE3VFX4RkhVCHzqjaHvaQJwCop07qLwb/ilBF0ZN4WWJzLBj
	xTXBnh9gys63uTlXVnF+MKb86jQdRgC/qnKOJj5GVj5U94kYc6i6gg9SjyWS0OnFzHfVCVk60Q2
	KqWGO1VNoYUnrIuFuC1R17kTEHKuDjp+Uc61YEh8MJxBJYfa18WSQ2xcU9sIC+KB0kEJu8XSPvS
	bhvIZBpHIZuxo3YkY+vHU0qWJf5wNmXIRuUefkF6UNkIM1txFR6L3CYlOSVmNoF/bA8kxD5AncW
	Gbs0Sx3kqmxQ
X-Google-Smtp-Source: AGHT+IE+WugOposmvo/jcHeaw0Ch/ihxlIzSWqzgKieKmOo/fttsPn7O0uxSSG2XNkVbg/PrQmJctQ==
X-Received: by 2002:a05:600c:8715:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4362aaa8b9fmr140737975e9.29.1734432188304;
        Tue, 17 Dec 2024 02:43:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706595sm170469495e9.33.2024.12.17.02.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 02:43:07 -0800 (PST)
Message-ID: <66adcd4a-d4ae-4dc6-a706-2761efd5084a@blackwall.org>
Date: Tue, 17 Dec 2024 12:43:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: bridge: constify 'struct bin_attribute'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>,
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shahed Shaikh <shshaikh@marvell.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
 <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-1-ec460b91f274@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/24 13:30, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  net/bridge/br_sysfs_br.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c7e7feeffef3c993404529ba88559..c1176a5e02c43ce32cb3dc152e9aa08eb535a419 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -1002,7 +1002,7 @@ static const struct attribute_group bridge_group = {
>   * Returns the number of bytes read.
>   */
>  static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
> -			      struct bin_attribute *bin_attr,
> +			      const struct bin_attribute *bin_attr,
>  			      char *buf, loff_t off, size_t count)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> @@ -1023,10 +1023,10 @@ static ssize_t brforward_read(struct file *filp, struct kobject *kobj,
>  	return n;
>  }
>  
> -static struct bin_attribute bridge_forward = {
> +static const struct bin_attribute bridge_forward = {
>  	.attr = { .name = SYSFS_BRIDGE_FDB,
>  		  .mode = 0444, },
> -	.read = brforward_read,
> +	.read_new = brforward_read,
>  };
>  
>  /*
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


