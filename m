Return-Path: <netdev+bounces-124251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C93968AFE
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634CBB21931
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE121A3058;
	Mon,  2 Sep 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdV54opd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE61A3055
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290831; cv=none; b=LhGbwJsvLOiwum8SdgZ9fNF+fBM3bfsUDksAgw0G2BnJfLc7N2/pkYAnVQEheO6Xw86Wd+NWDcJGoxVK7V0bzXUFec6fdtpVE3s2gwDjZVV4x/+3bvjswL6IParPRkOMcj4L/x7I89yIQj+l8vSCaP1tpgF+DtQQCQXowF7TCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290831; c=relaxed/simple;
	bh=NrgGCBWphUa6pn16X1Axjzk9mG5BENYVNOkJJsvyqaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OP2PG2B7W/R0+1jEK8b1/U83itVnZj7WKIbLUbzezUUz5gCM4eZgRuBxK9axWs581FjaIbfJkcNsTjBrI6FpxvDpPbp5PhLhcJJ7q2l+ud2LWTeNzav9w26RbPpwXflWPoWNlIe1V+3sQM1XRzW7GYolem1u7z5559Xp/o7wqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdV54opd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c3551ce5c9so19186366d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725290829; x=1725895629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yn0qNt/zGhRL+OYRVXMnNoHz4+u9oRNyoVfW+1+Klb8=;
        b=JdV54opdevYlrt/b7QL7z9qZt5YZMue1+CmtJ8apvT9qNFLPVjXnq3gpmt3jHUswQX
         FLSdPU8kdJr+lCTOsGqWWvljRGhjKXURFwtA7CUNXTEWEmOkZGc91ouRcoHpOpxNO75N
         EzQE8My5HXKxlrrmDDWwp2tfbgDBPLu/ezp1mt+x7Mwqd5rKrT+P/+/2cKM8zL2t0eXh
         at1bwOlNKxtO8+GAlh4r8vrp1UVzFQYnbLMjoodwygCj5HtOT9MXnZxCd/jc63bCiJ46
         +9y4xxsOjuK4Qw0OIfV7eOIKRq549TJJGXY07f4euLAdRI5F5KgAr6yEHTUg8HJhb1FR
         mh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725290829; x=1725895629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn0qNt/zGhRL+OYRVXMnNoHz4+u9oRNyoVfW+1+Klb8=;
        b=GJ7TyD0bbdruN22M8SclWiygPiNzaC3ToOjqz/AXlL+OhyVzsu4mBt7/plJJLNHFTc
         mEa4NJMPdH7IWsZjvGKzP5Ro9zEpSiOCQu9LB4TKaodE+yDjABmEpmJSqY5XcoGK8/FQ
         cYK4SUktjneKfTjPDj6FSGgVHPJSbWY9oUPLMse2fgvvUWL/hmYI7kYxkNG53EuFg341
         DdXOZrOjJfmE0us1wpHiVwFJ6Mu8VFPDX3Z0biSWMrpEv8E3Zn564Os9dAWQfbdeVfWD
         qwcSAyTRsu+vOPPonkyXckoWYM+Gw7v5SVgo6KzGRDqFN7jfnMavcmE3lMwM0AlbvIWP
         hw/A==
X-Forwarded-Encrypted: i=1; AJvYcCXRJtsZmG9KRj2IiBgRdlvYLEuYmR9EsjdA4jSVNvgKext18ZNCtfidW2+C3r+9Ld3JNaZWT+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2QmRth+4COr8LJKyqNc/1bAg5Wjaa6t5U42jKElBG4lUAg0D
	E+zLJJNNQRy1TuN4dDIf2orNX3AcqKCJZ0KbbH9Skfsd8quAPLi0
X-Google-Smtp-Source: AGHT+IHsh7TbDxj/S/ueFJoif6v3pnl6T+3d2f6M9FiCfeWDaYi7kmMexXjJ6EzI0V6gM/Tf/y2NMw==
X-Received: by 2002:a05:6214:62e:b0:6c3:7064:8175 with SMTP id 6a1803df08f44-6c370648831mr9215406d6.18.1725290829040;
        Mon, 02 Sep 2024 08:27:09 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c361eacd36sm16365946d6.137.2024.09.02.08.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:27:08 -0700 (PDT)
Message-ID: <1f2c95ef-465f-4f07-aece-b04d98c38adf@gmail.com>
Date: Mon, 2 Sep 2024 08:27:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/8] net: mdio: mux-mmioreg: Simplified with
 scoped function
To: Jinjie Ruan <ruanjinjie@huawei.com>, woojung.huh@microchip.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linus.walleij@linaro.org,
 alsi@bang-olufsen.dk, justin.chen@broadcom.com,
 sebastian.hesselbarth@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 krzk@kernel.org, jic23@kernel.org
References: <20240830031325.2406672-1-ruanjinjie@huawei.com>
 <20240830031325.2406672-5-ruanjinjie@huawei.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240830031325.2406672-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/29/2024 8:13 PM, Jinjie Ruan wrote:
> Avoids the need for manual cleanup of_node_put() in early exits
> from the loop by using for_each_available_child_of_node_scoped().
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


