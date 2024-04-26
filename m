Return-Path: <netdev+bounces-91796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710DE8B3F38
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28651C237E9
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85616DED4;
	Fri, 26 Apr 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgciljnJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95216D9DF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156115; cv=none; b=BLvz2ynT2Ljso+yxqjLUFCvaU7zjnEJJpcdcEtHU3k1mbOL2bo687HWnhpavqL0OpiOza+oj+rJqru56/ZGLS6Pp4sjJ1/AhLSj878j8kt+v44EO6Eh5QoW5IAJ3hWctIx3hw8o5zSq+RgID5y6BiFeLyUhDzVpQx9Y4NBl4XVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156115; c=relaxed/simple;
	bh=C9uGuH58AY/UWai5B6TJUNbzy1DwY7vuvR4mK4iAbVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2U1aQqT8TccYKy9LO6okkn3ZgE3yCUTuBSy5Vc2+KNhpKk4peexMaRUaQnygCn3N7kK+1EzkQ0sMbZcF2FF2vkN/H1HRavNqtvMcSFVpg0QYbNBPzBBZmv0yNa0UaABIB8QT5jAuR2hVYykfc/NdQiVuXzTMDV2gNP05ZqYnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgciljnJ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78f043eaee9so145295885a.3
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714156113; x=1714760913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxuRRvteUdqAEmI1MIs93G2Ks4hnY4lSEzCmXNv+x+k=;
        b=jgciljnJqnWgqpnfHQ1Sh9lLEUy/KKTtCpbMmzzXCzcoiIp8YNeJAKHZ0Ir17/4OHj
         k8Z1O7+1dRPRWlEDTw3TaKxjO1RVwOkgGnsOU0YaZ4itU57F9p4bffyTv4SifSsywJh7
         r1GMo/tYfyvtkIqKC3PoD702v6istVDTyTCzLDqbIr3khA6HC0SQQgrj/HBjh0l9aYQn
         eTa3kTThW7YQzwE9aZEhAh135YRyxdqz4U2gIxrI1Nx43TE4OM5NbOAT6KeLeQVig1hP
         YuyBqODc3dt95qtidk3PezvsvmPeGu9zb6RtR4ECtggaRw2+AiG8YidbMzwPGl7r4k0M
         btMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156113; x=1714760913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxuRRvteUdqAEmI1MIs93G2Ks4hnY4lSEzCmXNv+x+k=;
        b=RnjBtbiDdI0+ubhwYiEsgncueC8DPInNdEyqLRBb+pwgrY/jNdDGlrstSOAa4OonuH
         /eVJDGT3QWqzLpkoU2fzE5HAxS78TY4z8LjgszZ+HxGj7EbRcnJ7sObh498wDJTQ7SaY
         8+JjxmESE8FIWraWIw7yAjcD63QGC+stChXsncOd8uK/tolwnwOVotZsWzJ2+oXMOoa5
         oe8g+QmVVXtTJ4aNh8aju6FY+bTw7bNnJiY/oM59/Tt1JApRIh/obVLE7WzCmYLFAd8Y
         ldGtKm/8q1bkLceDILX0FR9uRkY82/Kn08xuyZS4DtdonKyE15P0cuBf2g6Q9uGqRTdC
         TUmg==
X-Forwarded-Encrypted: i=1; AJvYcCUxxJKdAuc2ghDr38YYwLX1nGEKhiBhquoLEnYGcccnJPS1VvSOW/laoznokQfzmVB5LZPcqEkWkCmn04XxpbkrNKvgUz1+
X-Gm-Message-State: AOJu0YytbszfvuaDdOpSqRFJpUVkmAFZhwq9ihXi9G1sNW/CiZqR2nt8
	Dy0QWYA669d+MZZuREST5vwnYWrJgZNkCKZMOLc7+yNW3ZrYsR1D
X-Google-Smtp-Source: AGHT+IGl+the1YRAQxyquRSGHE6BfuRjXM++k1uEzwzn/3ad4Amxpa71me/Mp6aH77dcrQM8GKQ16Q==
X-Received: by 2002:a0c:e78a:0:b0:6a0:a990:ef85 with SMTP id x10-20020a0ce78a000000b006a0a990ef85mr3249085qvn.9.1714156112700;
        Fri, 26 Apr 2024 11:28:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y8-20020a0cf148000000b0069f50e7ff97sm8016502qvl.66.2024.04.26.11.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 11:28:31 -0700 (PDT)
Message-ID: <962a74ed-9a23-4e56-ae61-d56ecd2ac7b8@gmail.com>
Date: Fri, 26 Apr 2024 11:28:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: dsa: ksz_common: provide own phylink
 MAC operations
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
 <E1s0O7H-009gpq-IF@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1s0O7H-009gpq-IF@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 09:08, Russell King (Oracle) wrote:
> Convert ksz_common to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
--
Florian


