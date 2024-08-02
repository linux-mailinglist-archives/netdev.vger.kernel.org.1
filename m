Return-Path: <netdev+bounces-115427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F429465A1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571301C21B3B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BD78C88;
	Fri,  2 Aug 2024 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIHHYeA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FB1ABEB7;
	Fri,  2 Aug 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635687; cv=none; b=iV0hRnGVfCT7UqMaAak7YSZt+cToKVojqV3Bs6+aMdL4Rz6IusVj4JLB64YCPdPtpSSzePAP75Mrv5k5uJH0CXa9F761EgdOcDaB17oHEdbwO67dfhbaCgRH08MuzJKzEKhMgHCT6/PJSMbMElHQW8zJWBJpzL4+dzf/fqzCR10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635687; c=relaxed/simple;
	bh=Met6Q4ZG5uPAIKcgHShjEWc8lk92o01eSxPsfGsSDEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDzrI8iKa4mtWuS+vNGAZt/TZj8Bo8qEDLgairTXACVVWCVxlzPV3qSVigU93S7BxptzwiUI3y5ylDnXvFFTK9k+847lvruIzOuBwYmU8R21tRB2M0RtoBCyKi7j4yIMjqiXLKZsDz3h5Jo3xe0OAtdyj1JAs9yMQkyBB8Sg2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIHHYeA0; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093705c708so8775590a34.1;
        Fri, 02 Aug 2024 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722635685; x=1723240485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFzgaRpmkgiqQpj6I4LpSSrD96r51nW21+lhUQc8eAw=;
        b=RIHHYeA0la1QHHfloSrzKiJ5NHhQbCgUP2EhUlBvgF1qM4mSHIfRz0GFcyNlQ+F2lP
         3kfUkFbyjmTwmzVxOPQFn2d46pb+J+MEiCROVkt6+/MA/bvIkm6zqDIKGh1ez4VUy9oY
         L597lVVYGx3rVDqhKKSQ4ef4cMYExQZ7SGqebbZ0U7k0rL2dN745UtmOXhnOYIms+Exi
         uHOZrUGf2R5eASql9IOa4RWDPSQ8NN2EdmXObvy8ltCdcVBtxK2VCvapKM3uOwCDIqMd
         1LAjXVy0SgNdIRkzD3y6f8l9TrGunF0BsLUH/hjHVCvNImvkF/+AJr+vG3PH2z7BsPM0
         o6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635685; x=1723240485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFzgaRpmkgiqQpj6I4LpSSrD96r51nW21+lhUQc8eAw=;
        b=mgxnkDhVFsM/4j2BsYdmWmTUHUKnijn7QjTnmp9BiWx1Di1A4/plWYE1WpixHd9fKo
         jaukXXuk9QCULTI41p4lB/q3juP0QJ512GhiIT2OiYGTezKOcenonKen/6QZryacRXoc
         ca97rHkNs6MU6i9gFwby1LXiUZ45iy7jTHxE82gmLcC9LB0vF73EWIqcjoZ5yHZ6A/L/
         wCSQkvKul82uiLTI1PicU+8Rqc+V8X5DKVJ4L4yR5fwIsb4SPssWj2wqFmnKFG9rOJbs
         7Tv+HYyG9DGDvRaP1QxwLDAMLzjkFwn7o2wXnG9mLk1MYhQ6aiFFhrJh+CsQ9Yx1UsAH
         YKbw==
X-Forwarded-Encrypted: i=1; AJvYcCWpzZM4PA5pRXKH7f914V23WfY6pdG8lza/jVbClVz+qtOoWBUaRbjdfStEl/Q0tB90aMH7b9BuBJ9eMzXv+qOz4074lzzJ+2UTasNb3HsqvoA+eIMt3oPKGot8k7fvaatzilDW
X-Gm-Message-State: AOJu0YyapktrfiGOPYw53sEjZYOcV7OO/pyHYTEWpfi9GdqYGfgRlxSY
	q9/3C1QhxVnjW3Bl+IEpXo8hBImgAF5xwZXrlItN5edtOx15RG6H
X-Google-Smtp-Source: AGHT+IGfaIm5ScasNYtmKcQ1ZgBLbP3z9t5dvBMBD87GAIbkMkGJOMWqhiQopJXJBZnTmuixPuAFag==
X-Received: by 2002:a05:6358:54a2:b0:1ac:660a:8a10 with SMTP id e5c5f4694b2df-1af3b9fed8dmr584670555d.3.1722635685012;
        Fri, 02 Aug 2024 14:54:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bb9c7b7b2asm10525016d6.62.2024.08.02.14.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:54:44 -0700 (PDT)
Message-ID: <71d28aad-f978-4bc8-8007-bd0018b010ab@gmail.com>
Date: Fri, 2 Aug 2024 14:54:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/6] net: dsa: vsc73xx: check busy flag in MDIO
 operations
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org
References: <20240802080403.739509-1-paweldembicki@gmail.com>
 <20240802080403.739509-5-paweldembicki@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240802080403.739509-5-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/24 01:04, Pawel Dembicki wrote:
> The VSC73xx has a busy flag used during MDIO operations. It is raised
> when MDIO read/write operations are in progress. Without it, PHYs are
> misconfigured and bus operations do not work as expected.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


