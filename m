Return-Path: <netdev+bounces-124654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CA096A623
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2727287831
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918B18E741;
	Tue,  3 Sep 2024 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hgg3+D0t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7318EFED
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386786; cv=none; b=TjDsEe81JUKUNx29YCcpYETSLDWO6y6jQqoN4et1ciHuftcFV5StTghubgro039Xyj2RRbJ5aLhmxuYt7V7nIRvcNxiH1K/vp5q77TqQSpsoTYhWuZA329WkhVC74Nb/7/Fh4+jSfRVjhIRQdS7+Trj6xrBUUfWizo0EdrIuBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386786; c=relaxed/simple;
	bh=8LtJshcF78MwCkem83FLb9yKyENRHTqqJOTSxZkm2XQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oJikATEvnNQV3DvT8uZsIMbbnyiDwo2cfIFB8bU+mH4xn8ghzE6KQT09lCMTHCKz7WkkUa0unHhC1J7b62MuXjt0V3ULu0kCCAGbuaG7ZS4wkTZOvnWrhMO3icolFp6LWkDbT/VnfY4tpUhH4gou+IelKH6bAuW7iyiyIdfayZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hgg3+D0t; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71433096e89so4442205b3a.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725386783; x=1725991583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PAxNRyl+5iw9fL5FshM+dULs8RYFkiTQUToZxINMKuI=;
        b=Hgg3+D0toVPAFi21kfj6/q11Rq4sZgPiA0b2QfCEkjNe75qP+E+fs59LuDmdjHbYn0
         jmFefrmLYVSYXRMg5KcpEiUo71OvgDaAr+k1rPWjyfQDHGLAPozNw2qB0097a9wsdU8s
         icSZ/d6/OE3wBAjU8z/dPZAeCCNX1hJKkOsFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386783; x=1725991583;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAxNRyl+5iw9fL5FshM+dULs8RYFkiTQUToZxINMKuI=;
        b=a1Yovfgswab3Xqjvf66kD9zYLhq8zZ2fCY9iva8+DV+d3Jkft+vc0KCqQtVjjZyWrN
         z2Oo1zG41sbofduoa9i8WEEbtKlDVcYM6M8rcPtFoiz+LcQ1NyNOuMUovew4LaCHD/8Z
         GroX3xs4VGDg2ljbdiQ2UYo9TTOTpbqAovYEzxRSWPGn0oelR8+DpjjpTb2CxiyWs22b
         af4oLS3ovsQcrmg4uMuHHb+Y7oHCNUt1SoBFzXht4wsiDaqavX/cmNlj9HQKvdPYsZjq
         GuQUzMJ8McqNrByFcmGXP87aLCbWvmIFbBEK62zMIj8BAM7oJLxYZHJA4UGoYngxDtwZ
         Y6jw==
X-Forwarded-Encrypted: i=1; AJvYcCXUnU/yl+L/tKNsUZl4mLAecCgV89kp60oCQYtA2JkdgT7rhWhBt8qRPUVHUEt0pzt3MrfqrKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxLCgP/lM/qMJHbGDI0LOXVnFwdcsg4dAsGTR66XraOVp8nOg
	QDQjsPaevM3VZrcdctPsBO77r7azia3AhSOvhicpWXY+mfZoI7TxSHZjbdywog==
X-Google-Smtp-Source: AGHT+IEwkKSRG/SEZzavwprpB4VOWLoG2/0A6tFuVScaeVH4NIpIG0gr7j6yXBqJqlUszicz6C+xyw==
X-Received: by 2002:a05:6a00:1905:b0:714:2dc9:fbaf with SMTP id d2e1a72fcca58-7173c333c1amr11880781b3a.18.1725386783225;
        Tue, 03 Sep 2024 11:06:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177852108esm164537b3a.33.2024.09.03.11.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 11:06:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
X-Google-Original-From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b151952b-5536-4fb0-a908-d8ee4834f302@gmail.com>
Date: Tue, 3 Sep 2024 11:06:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] net: phy: Check for read errors in SIOCGMIIREG
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
References: <20240903171536.628930-1-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240903171536.628930-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/24 10:15, Niklas Söderlund wrote:
> When reading registers from the PHY using the SIOCGMIIREG IOCTL any
> errors returned from either mdiobus_read() or mdiobus_c45_read() are
> ignored, and parts of the returned error is passed as the register value
> back to user-space.
> 
> For example, if mdiobus_c45_read() is used with a bus that do not
> implement the read_c45() callback -EOPNOTSUPP is returned. This is
> however directly stored in mii_data->val_out and returned as the
> registers content. As val_out is a u16 the error code is truncated and
> returned as a plausible register value.
> 
> Fix this by first checking the return value for errors before returning
> it as the register content.
> 
> Before this patch,
> 
>      # phytool read eth0/0:1/0
>      0xffa1
> 
> After this change,
> 
>      $ phytool read eth0/0:1/0
>      error: phy_read (-95)
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for fixing that!
-- 
Florian

