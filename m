Return-Path: <netdev+bounces-181970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E3DA8722B
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F447A93C0
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FE64A98;
	Sun, 13 Apr 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAN3Q83G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561729D19;
	Sun, 13 Apr 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744552154; cv=none; b=YGny5BBjjhM/35MOMld9iyve9nQAgHGTHWFNbaI+Bkt9x0VGJwFaYZK3vS3INA9t8uFMKIoXRY1CVFIROK23XgLm5qmpo1fso1xjgaqUWr15CZExQvYA/2Fr99bAdOZQegJnSAvAnvTHz397SK+n5v6BRiA2Pa6pxK+bOkTciQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744552154; c=relaxed/simple;
	bh=jeQsVJa0vppm+ID7Xf8rHqgwVUOGxnSmKmlpNXztA6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jo0YhuvIsaTKsojsSLaZPjLW+cDrkzN8u/DAq0HT5xI6tkDYPp0sMmvaI6vMySs7jjUWZhyBeGwZdtiIaRMZce0PmL5aF9KcgwoNWm0W2kPAzSCStNpaa1c76fuVkYJhRmiYIz7blzZTQfJiNmqJR0wWc5nzJEiYbjB3XJ+HHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAN3Q83G; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso23855335e9.0;
        Sun, 13 Apr 2025 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744552151; x=1745156951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7+kRcuKH5IFKqnlJs+Igo3/04AUw/PWeejVPoDXRmXY=;
        b=SAN3Q83G97CKroirUDOyixpERqQhYGvPkOVVqgXbU5meOZkIXOwyq41C6NqZdkuwRM
         mCKWHXPxT3MXzRdLojtwl5c7sKoidArzDStUwJDsh+qDPAUKAFPQskwWlP48owPRxK5G
         KiHIb8MPW518Ih+SfyrZJk/2y6SdHlxtXswM+LBgPa/+leYa1kzHm5zVKKEb5jZuqDA2
         ywV5sWLdyAekDNqYC6iKrKPZVYakmgNlu73f2symG3n1seqYD0EEtq7wd/ixUBOTx21L
         d4KU6ZZT8b6cNZkqec4qd4ALJtJZZoeM2mT0c3CqQqowBqe/0QRIY1ZgYr6RMdvTrGtn
         e/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744552151; x=1745156951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+kRcuKH5IFKqnlJs+Igo3/04AUw/PWeejVPoDXRmXY=;
        b=R0FDbM8CEPEpJLIGJeHDaboIvG2Mz8yE083BNN3XvciV0Xwu0POyy27YU4AZk5T60F
         0AxL6V4vPcohf1r8UqD/BMTYKklrVSm1glb9PpoJtQ+QiAZKDvEvyJuDZBJ9g6nt0INX
         YHQ1KSJfmthPkSTkw9j9swLeO1jz0wSoX2vr+PA5nliLAGBAmTA5jc9duXWvIk1yAL8f
         0ewa1joqOydhdzlPdDj86YLCHEMurKHQn3bY24cvcPUn0aozcGo/4gWrV/VqjCscYr9H
         N6cV8oBbM7p4ejSkxPRSx6FBZofCbespK/GCAq51XAYwnXaRiAw8nHb8iSXVwNEUvO+c
         5m3g==
X-Forwarded-Encrypted: i=1; AJvYcCW2bN3PN3DS+WsU2eWs881r1GnBJYv/Th5QSzaHLcgcuUXVHIeEQzXCNTeMPK1ZHvfK9aLOwowkKT/Ug/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzHlODLHaA4QutQFeDFKmt3YhJBO8v8KDxmZ4Fhy1Ib2CWcX+w
	g6RBsKytVeB4TenZHzWr+QgjtSdP9v0r8hjxw7x7KIpNANUhrqKIJqtACw==
X-Gm-Gg: ASbGnctOpegtV0tv2l6/R4dtg8D2mSCY8K62PhDhYgm1Jl5ljIt+Oh6frFOADhVRq11
	nKyj2nOMLlktHe41uwjvs0/rtNTUCcgj2R+iMB3+ToD0Ij/K0Psf9wt2ZVNwQwnvNn2GqvAu98K
	DOZW32PnGQCxWg3s7aGDCCXawH78g0NPVXvGDzknTNxt8MOKUusSA0RjSUyfIOF4l30bP9bCeYu
	drTuU2ITPwto5xlHB7ezAlPTcAg2GGSFz+M1XekLvVUhqy2t03kHbJtXZdT6u8CH0xuG9fszqjo
	DjbKGsKlnl6vtI6SbfnFX4xPxLL2Z8hoF5Ay9Vi/ns9ThifiD40KQwnm+PWAb8zzSXKeX2Mb93n
	SuxxTeuprDnrhqsCpvIu71iuefqAKDaAG8CAV3To+kUCZrkkl9NWMpMI3Zet+dYihPLUrCLtIEq
	tlYZIYG66hWUnpFUe49cr3KR2YHAE7XOS1rGqQ8/vb
X-Google-Smtp-Source: AGHT+IG4xi8tiIswAd3XNRiLSzJQjEinJlQdM72KWa1bQmPEbjAKBYNuqQyXI4yolX+J7mAhmZ8FhA==
X-Received: by 2002:a05:600c:5494:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-43f3a93d850mr82183425e9.11.1744552150259;
        Sun, 13 Apr 2025 06:49:10 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af2b:bc00:419e:9df:ec7f:c3f4? (dynamic-2a02-3100-af2b-bc00-419e-09df-ec7f-c3f4.310.pool.telefonica.de. [2a02:3100:af2b:bc00:419e:9df:ec7f:c3f4])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e90sm145143165e9.38.2025.04.13.06.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 06:49:08 -0700 (PDT)
Message-ID: <0fd79f9e-fe6d-4c85-8dda-7f64e917129c@gmail.com>
Date: Sun, 13 Apr 2025 15:50:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: Fix return value when !CONFIG_PHYLIB
To: hhtracer@gmail.com, andrew@lunn.ch, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 huhai <huhai@kylinos.cn>
References: <20250413133709.5784-1-huhai@kylinos.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250413133709.5784-1-huhai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.04.2025 15:37, hhtracer@gmail.com wrote:
> From: huhai <huhai@kylinos.cn>
> 
> Many call sites of get_phy_device() and fwnode_get_phy_node(), such as
> sfp_sm_probe_phy(), phylink_fwnode_phy_connect(), etc., rely on IS_ERR()
> to check for errors in the returned pointer.
> 
> Furthermore, the implementations of get_phy_device() and
> fwnode_get_phy_node() themselves use ERR_PTR() to return error codes.
> 
> Therefore, when CONFIG_PHYLIB is disabled, returning NULL is incorrect,
> as this would bypass IS_ERR() checks and may lead to NULL pointer
> dereference.
> 
Is there actually any call site which doesn't select PHYLIB directly or
indirectly? When briefly checking I didn't find one.
So my question would be rather: Do we need/want stubs for the following
functions at all?

fwnode_get_phy_id
fwnode_mdio_find_device
fwnode_phy_find_device
device_phy_find_device
fwnode_get_phy_node
get_phy_device
phy_device_register


And a formal remark:
Your v2 has no change log, and please allow 24h before sending a new version.

> Returning ERR_PTR(-ENXIO) is the correct and consistent way to indicate
> that PHY support is not available, and it avoids such issues.
> 
> Signed-off-by: huhai <huhai@kylinos.cn>
> ---
>  include/linux/phy.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index a2bfae80c449..be299c572d73 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1787,13 +1787,13 @@ static inline struct phy_device *device_phy_find_device(struct device *dev)
>  static inline
>  struct fwnode_handle *fwnode_get_phy_node(struct fwnode_handle *fwnode)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENXIO);
>  }
>  
>  static inline
>  struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENXIO);
>  }
>  
>  static inline int phy_device_register(struct phy_device *phy)


