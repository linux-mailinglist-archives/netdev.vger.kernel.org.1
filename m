Return-Path: <netdev+bounces-132329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E4B99141B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 05:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027721C21F75
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 03:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B31C6B2;
	Sat,  5 Oct 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROzGbtY9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1D748D;
	Sat,  5 Oct 2024 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099534; cv=none; b=HDDpD8MgViKo5IInZknifAO/8qaFCz+BYM+HIDK2BbH99jpdjCw7Fb/sBRWkfhYekVfcAk7qduCzcdJSuvDHK5TOF1Crei5ApICGvJcVQm1B9rvHG/SF24AyeMjVCGUT84QlZ+nifqzAH7+Rb2/wKZ+UegpMmtLO5D/jRHCylNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099534; c=relaxed/simple;
	bh=QZJijsDQVPjwJ8y+vgFhiIm44X7e/5KmJUXfyfIz6MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMA4bW14N+ritPqqI3nCpqA8grxNyACIQTqLplwfBNEzE+rThxVavMo79YdU0JiJBb1XyEavLGf1MfE5klMqgblt8gq332qXx/LNOMYlb4PLr3ppTbbRhojS6f5aDw9dZ+azZfVleoSKjTviWPSIqVV3ApstdqGHTfmeHj3zK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROzGbtY9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b84bfbdfcso25601805ad.0;
        Fri, 04 Oct 2024 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099532; x=1728704332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny51calOTNKcuKK/tM93jmDyw6S/M8DKGQJ/zq/PkIY=;
        b=ROzGbtY9+n/fv+W+H564zvcLLkWvm7vR8vii2bCRQgFtvI9osJfDpP4CS899Y7ti5B
         KG1018GLMFYIKp4S/CNMlpbCY0IpOqbvwu7zeZzVmToWCkxVeipm9r4DBgSBPQ1XJ4gl
         PprweupOedu9Jt19YxhoK4G0yBfyqkjRglTD1Ft77UzihLmiYYqnnyzb6SBS08JpjRaS
         yaJ66Mpa5HQQzSeCX4pYQbh5OSTAgcaFMSTb/O6uGU16GAdCki7DxN6IBsogeRDaIHTk
         S5wxmRmk3atEEMtX0BLPkri0e5fSDVKets5Cf2vkvuHF6Z1kW9DfiEnKnLHVJpxX9Sos
         M8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099532; x=1728704332;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny51calOTNKcuKK/tM93jmDyw6S/M8DKGQJ/zq/PkIY=;
        b=YMw06neuGLSOGD83AUuH1tCZPKqmwFHa2LrSOleZPx7pnyWEc+NOHJtTKgSKQXOEO/
         iMfNS8vD+oFBTSGLO0saqmSmFu53dLA0Mp1/X7mOVuZffgJdlfNAkaMuUg2enl2mz/uk
         gFyE1ZEXgvl71n5A3uNrDAPWJpylfbxk0ybF95QCSwbglhQMGx5lchpLRiYcl0EHTioK
         AHXAEM19ulZJ6/oSmE3XdeU51HbkUgT/+5XrXyNBU8+BS7DjkhoNUXd2QX8tVkdZmJo/
         FOOznD8uUIpcTtrhvcI8QQeVODMqUgSNH+dBIQLn0LzbP8UNKuy5hon/wyVj8bLD4LBx
         pWPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVavUD7GDx+PPB8OnoIEhkMZSXbXwxKfiR7KqCo3xqZUVHef5S7StZBFawn6ixNjiais+NCAJM@vger.kernel.org, AJvYcCXqtKSLek3qEeotDtqHUxnc0gqUAwdMVcgVlGJUjrPrWULxNI/4mraMQlGtFfpJPRYx34jkW6ZmEvfFsi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4kvfIplGNGPkRPaX1xos+ExbtEt/GMBlo1AcEFrMryOMKP1P
	weyUTF1wrFSm+EpK4vvYH1Kc70NL0oJctHYD0L+o6mw3yRdYGtLk
X-Google-Smtp-Source: AGHT+IGxlbwfhIRf0gczlJw5ONFO5bQWsf5Cn8z+MDiqFcwOM6Awfsa8pBi5Ak0xRxHSYJa//FDV6A==
X-Received: by 2002:a17:902:d512:b0:20b:831f:e8f7 with SMTP id d9443c01a7336-20be1898a91mr137349275ad.11.1728099532015;
        Fri, 04 Oct 2024 20:38:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c37515sm628714a12.75.2024.10.04.20.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 20:38:50 -0700 (PDT)
Message-ID: <1ca99004-c194-4d60-b328-40916b685ffa@gmail.com>
Date: Fri, 4 Oct 2024 20:38:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] net: dsa: b53: fix max MTU for 1g switches
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Murali Krishna Policharla <murali.policharla@broadcom.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
 <20241004-b53_jumbo_fixes-v1-2-ce1e54aa7b3c@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241004-b53_jumbo_fixes-v1-2-ce1e54aa7b3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/2024 1:47 AM, Jonas Gorski wrote:
> JMS_MAX_SIZE is the ethernet frame length, not the MTU, which is payload
> without ethernet headers.
> 
> According to the datasheets maximum supported frame length for most
> gigabyte swithes is 9720 bytes, so convert that to the expected MTU when
> using VLAN tagged frames.

Only if you need to resubmit:

s/gigabyte swithes/gigabit switches/g

> 
> Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


