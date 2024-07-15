Return-Path: <netdev+bounces-111434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88596930F4C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B057B20DFF
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F3184123;
	Mon, 15 Jul 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EFbRq/xn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8122837F
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030673; cv=none; b=tPWlvW1XlLsLJ17E6Y/iLqi3qnfD2ELNj3KbfFUS9Y1yRwANnShUoUPiJCU+FBJ++b92j3AaKhhbyCzh8CgPPN3WaYSmZdgMZe2SwscfDHDdynvSyfc4D3L39jLw29upCM6k60qgRCLX4zo5SIB8OXqnxHezGr2DfU/tfKzUtZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030673; c=relaxed/simple;
	bh=pfgmG4zZrrqRhVkanoP0xDLU9g9d+TR1rmNzguVilz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpjbF8vNLdd7CaqNDXP+XuZB1jzBPBKvCPIML5J5RpcSdGGFrHfladbuAZiNdzCTZi9kouzcVAO7qEnNylH+hGVaqPeUFeNJysg6DbfdikpIOxpu1KRdRr3Y9lg9ZH+t/Z6N5Pzsqlq6Ea8BZDfaepdAYpm8up34aBBH0yKAGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=EFbRq/xn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so4442254a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1721030668; x=1721635468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiwcX9F4LtfC80GM31isd5gHfQz+XWLWe2fZmeMxBV0=;
        b=EFbRq/xnbNG8ZVVoiMu5zOXmxigOdgnqGXmn6rkhtv322S2CKqLuoJorny+DqsUL3e
         GSPhYW3Ks0ONr+wmmHnnzzHpfqbtHp2LWxWrJjLME9qurUVGm6+lmXVcwSr5XMfs3cbO
         SfprEqnO5QGFsEtiYBVenhsjEHFStxi2AiADt2qA3QWnBDaC9T97E8CrhU5rRf5JO2T7
         THjAvJ32DMq4ZWbnb0h2GLXm45KfFMwTF6iDc2bIXpeZibtkFJC26HLL2OSj5yhVJ69M
         R3h/C0NV4HJ5P0tmYk4h2w8T1HYEBRMagcc+PklPZFAot168LQlXBYejSp/fqx7BmxmM
         obIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721030668; x=1721635468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiwcX9F4LtfC80GM31isd5gHfQz+XWLWe2fZmeMxBV0=;
        b=xJGkxm09b6zSIoMID4WeuEf/NPAFVkCFCXEnHWhGyz0gwZ28P+kYg8TsrGTd5f+g0W
         MlNnqgwZVVZfQQFE360IUXFWH0hWHLQB0YT1WX8DCMPmixkTZuj04eKTlUe3XsUKgT5V
         IecunEIikiFE91ifX/RMwCiY0VQOAOm0VJ1vm7oqP+wOR+JL1OA90k1vlYRk8r0bidNN
         0fuPzqrBgUConnhja6poOdC8f+mIPoEaU8D4GdMAQmkVxm4mfbilc19Wg6WICv4HzXZM
         zMmuq93bUahRn1eefN8VQH8vDhQn+fkC4fq6V6wAl/ExJ9dMYV2LLWgmt1GNCPedky1l
         uxgA==
X-Forwarded-Encrypted: i=1; AJvYcCWP6SN5KuHSQF8IH4mfSKnj7VKobPqNjHKs1ju5T7IxSAaQ+HqqMzKnB6cvDRsq0LO3q2qmCTJquB5W80Kt92U7d1PPODUB
X-Gm-Message-State: AOJu0YyYbajMU68muC89/0+dVUvob3acg/EzB7wbVgAlfElqBN22pkVs
	Pc5LEDYNX10OrslQU/WqwxmzMD3/nW4suXmkHYfKuz36sb4XM+kfi4NLEJ5Nv6Y=
X-Google-Smtp-Source: AGHT+IGfLMp93Lvm4ZRrsDZSB1JnFiH19NTLePtvoM//z2ksSs/I+r4ZV/EUEPuFeQJ8h0publy2Mw==
X-Received: by 2002:a05:6402:350b:b0:58f:ebaa:64bf with SMTP id 4fb4d7f45d1cf-594ba9975bamr13862271a12.2.1721030668208;
        Mon, 15 Jul 2024 01:04:28 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f621c3sm3070229a12.89.2024.07.15.01.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:04:27 -0700 (PDT)
Message-ID: <7476d4f9-3a45-4586-99c5-9e878d4e02ac@blackwall.org>
Date: Mon, 15 Jul 2024 11:04:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove unnecessary cast from netdev_priv()
To: Chen Ni <nichen@iscas.ac.cn>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715024457.3743560-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240715024457.3743560-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2024 05:44, Chen Ni wrote:
> Remove unnecessary cast of void * returned by netdev_priv().
> 
> Fixes: 928990631327 ("net: bridge: add notifications for the bridge dev on vlan change")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  net/bridge/br_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
This is not a fix, the code isn't broken and it doesn't violate
anything.

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>


