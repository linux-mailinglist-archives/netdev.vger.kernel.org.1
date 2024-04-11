Return-Path: <netdev+bounces-87133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57108A1D6E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902E328876B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD9D1DDD17;
	Thu, 11 Apr 2024 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGqMIqWy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391281DB559
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855239; cv=none; b=f00BB798XwIxXbbBNx8NUZcepM0I/AwyB5loPND4GOIBtAiYhPbZHQYyLkta3U+ZbEgx78oNNv3bvzYg3CqxWG/jf06TNsdzZsHFpvkxcm8AmaF+N32hn2c1sBFCbZLQYilcO2KOyHYnFKk7BEhxJCwnMmkDJlKyspX6XXB94gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855239; c=relaxed/simple;
	bh=A9O5soYqSFNYNCnyMqPdCExDet3UtqbFdmcW3IxENt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4I3DzVtHOQ6W5qrevKG6WpbQFe1ItPFG/nOP82LtXg/lztygX7PBVdEUcZ6w94O8TZZlTksMEN6WUnz+Al4vwU5082cdl4t++riQodrTzZQ0bRX/pZRSeCVzxo6cm15lDgXqHCC7XiwVsJ/S6iczcaAF1tz9xGZm4eCQEqqOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGqMIqWy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso76796b3a.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712855237; x=1713460037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANP7J4abMFbKeEXfpSeYI7gA7qoFM4B3V73RuxtbLRk=;
        b=eGqMIqWyK7bOE7nG72F+5uX4cPtOT7zLvlOJnDCYYsHrhRq/1/urp07DchaOSB+VQ7
         Jez4Y5xZnNVAnkVIISn2dgGl1aAN96dpVvXw80oJ/LZ7gbjFOygYXBjJKGiHIhDI5ptK
         5q8uKP6G8HPMW3bJnuzB6RIsJan4bOPdb4W0lkglEG6POOl3gflqfOy3d6NzlNLTGzUe
         r9hgglNCWI4vFtQUIloQltM21ale3WMErFjlZy39jmutOMDiuMLTiEDpCMXu8XpKZB7A
         rDX5tkh101crT8ixAvOz2nZ6dOe3Ife40Q147JdkLs7/1341TTEX0EAS11Kyi68x7h9G
         6UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855237; x=1713460037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANP7J4abMFbKeEXfpSeYI7gA7qoFM4B3V73RuxtbLRk=;
        b=CY2g8MD8QM58wy5dTkoKu0EOAn897yCruLsYdkJ+w/lPDI/bu2oc/EdiLR1kHb3Dvs
         8RrMVvzh/KeI7q89ZGC+eiCi3FO3uaCH0kCgAokKiiNuHEVdDE6AU01Qu6wbpGU0a6P1
         Q4eFkTkKweoL4H1OhGZMq8f6F5Htr7N+nFFVXwtgK7vdB1zEfW6OZQ8ewqsxB+cJDefL
         2DqYM1kAmAVxJLfKPfHG6dO/iEu7eqAUdrWcwtb7eaMu11HO5m6eGZcf6jg8/568VOk/
         c6FSIJhrJvoe5oKVhqa8aRHN4Gbn2OukMU/+PjNS0LFrlZwC0nav5DAd64HVzOqcwYVl
         3vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSWel219GnS1/tIiAH/QQgIIcdVfX4s199dSmscq6iiqDzY44LCA/QzYkOvrFK0YHf27cjxntKHfJAU1RtP9GlZrSN/QeG
X-Gm-Message-State: AOJu0YzMCZ/FUGBb8eM/mnftRBibX0NWPTBSc3KyN+wLH9ySqXEjG5a+
	NY780fgeXewqqYZGXJ6tZz9xeMyPjftcOkL1uv8LoDrZY5VGrCmN
X-Google-Smtp-Source: AGHT+IF8OWIRR5+1T5CfciPgBlCI+RBIJUb1Cw65/umC0BpM/kAby9g5HbgCp82/ssausDh3HTSRQA==
X-Received: by 2002:a05:6a20:6a20:b0:1a9:22b9:754a with SMTP id p32-20020a056a206a2000b001a922b9754amr576924pzk.7.1712855237314;
        Thu, 11 Apr 2024 10:07:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g10-20020a63374a000000b005e4666261besm1307968pgn.50.2024.04.11.10.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 10:07:16 -0700 (PDT)
Message-ID: <8deaf577-5224-4734-8e2e-ab8b3d454aaf@gmail.com>
Date: Thu, 11 Apr 2024 10:07:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
 <E1rudqF-006K9H-Cc@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1rudqF-006K9H-Cc@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 12:42, Russell King (Oracle) wrote:
> Rather than having a shim for each and every phylink MAC operation,
> allow DSA switch drivers to provide their own ops structure. When a
> DSA driver provides the phylink MAC operations, the shimmed ops must
> not be provided, so fail an attempt to register a switch with both
> the phylink_mac_ops in struct dsa_switch and the phylink_mac_*
> operations populated in dsa_switch_ops populated.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


