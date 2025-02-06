Return-Path: <netdev+bounces-163557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1A6A2AB05
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692453A6F46
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB01C700C;
	Thu,  6 Feb 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="esM5+Wbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F201C6FF0
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851708; cv=none; b=S8wjz4iFqttyYGzKTubdiUGh7/2FPrhxYRevpFeuoo0geuIMww2qYYsLym070MJt+WYi0vxj0eSfsUPRr3OhIbdLvr5GCsKxlhPUMXJyqY9oWolPZWK9hS5nl+PIXLGPGLvAqiDVSkcfUAvLjkd+CFHWWSySPmJmxK/EKtFmPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851708; c=relaxed/simple;
	bh=/TJhMhlC9yfWlzDzdRKnoTLdE7CVcxNUHvoHyyqOcac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWCWz3ZZ0Duv6Psk+OGp+yDUyOLZntRdD+HLeCFqdEWt3DqMeoGxzAhnUU0MVc0Ns96v2HbvRsn0AcVhpb1hd37n6H3dCegQVG9/3dDHCEfDEtdSN6MdInYqaJxPjP/bkqkxiHhW3oisGnYIPNzO24bAGnjJANleQWbxBHgAJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=esM5+Wbz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dca4521b95so2119284a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851705; x=1739456505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzREIBb+bKP5i/Ck51DCfeo3RpAWV5APsV60x0FMqs4=;
        b=esM5+WbzOkLXd84M4aNxR/9+gAtddG4eZ5otCj0Q6vC2mEP8QnUTcVsAG7KU0VKMOr
         TMGEiddouSjPve9lC67WCOeL7bbAQCxAUJCIc+BlqymgcLYsFDtmErtpcNKGvOX5ac+B
         PRnvgnGf5V+q2U9dAKqP9xe9D/W2gxVM4MjKdXpuqgzlMUyEaSKCkNJsQcmQcRN3UngP
         LbaQBI2YhVs9SY5xUzXFUKkMLLnzKmw+2AoopfFNbc206YsRHt8WOGMmiXu/fRRT1gWi
         UA0QHd7BoxeR5dyMgagkv127PqjRNH9TEyHWUGxCSx7jwFOBgNDkljKlynKGgogzlsN4
         71vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851705; x=1739456505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzREIBb+bKP5i/Ck51DCfeo3RpAWV5APsV60x0FMqs4=;
        b=AXkAoduf+7MIzVCEXXGHfJ31yUjY3dbrKrfnbIX2Ivl27mzvnyT5hQOYMH9quypyLO
         sC3DszBWHqiQwP+J0xs4iS3K5ETZO683QtDPAzqY/lXpVWrGacn7NDI5FPrKrxw5S9cr
         sqyUMDkZv2+bGxAdyWDr2DwqyRZlE5x+2ysKr1ETCtycwhb/uC5dDfEdg/MbDACNpZbe
         Hc0YCKXpO2j/063tIMAnyvPX+vMZw7ETG/jGkiEFk0HSL409+yOSmjA4/qOMXSTsyCAB
         aUMdRcaJ2pl8AT6Bri0oX+zYlxtOxucVNisSOyIM1azHANt7mZgQxW+5ROl+B/V9ywGK
         I+UQ==
X-Gm-Message-State: AOJu0YyY2KzOaGCTASSHVd9z+MdJSuJX0GuWIWIMCh3QUN//E4b3CdwI
	7SauejCLG8oLOcDe6EBY/RBYmHEhS9UM1dtHnHx6URFD+08slvQDCbtuqxeYBKY=
X-Gm-Gg: ASbGncvIfUU8FiEH9TfybRkIriuGzCa562xp95Kpxddk7YMG4yX4/5rSa3pKqUSrc1v
	swzpm0YtfoxTrYK0k8MYat3UJ0zYd4KXPJarHFEa7HKh6Rb2MHviMiKavljekpeyy7U1McQOy2r
	dBu/pACohzd+d2v42MjdiJ/lDzEL77Z8idDfw+T8IjCyzXqllx6Vckc9VaKy+q/6+3DCJv1bZ8X
	T0x1+Cc3ESu8thhXvZKcpNddrnWTC/F/BKc5YNwkdrhrtGJRlJqLTqoGB6RsCNI2qE+/4wkvA3i
	MzWdP5JxC6OmjrOmpTev6MjkOgsHNjAZiqRsxKrqRHfBau8=
X-Google-Smtp-Source: AGHT+IHYDakGj/X5YiewxYiKiang3LLrhidWY47Oe3DTivu/rcwezti/yOY3bxt3zD/zpLuTb7KrqA==
X-Received: by 2002:a17:906:6a16:b0:ab6:f59e:8737 with SMTP id a640c23a62f3a-ab75e262320mr699358866b.27.1738851705010;
        Thu, 06 Feb 2025 06:21:45 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e70bfsm106144666b.104.2025.02.06.06.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:21:44 -0800 (PST)
Message-ID: <fef59299-aac3-41b1-9783-3a3f35dbb7ac@blackwall.org>
Date: Thu, 6 Feb 2025 16:21:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/14] bridge: Add filling forward path from
 port to port
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-6-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-6-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> If a port is passed as argument instead of the master, then:
> 
> At br_fill_forward_path(): find the master and use it to fill the
> forward path.
> 
> At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
> instead.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/br_device.c  | 19 ++++++++++++++-----
>  net/bridge/br_private.h |  2 ++
>  net/bridge/br_vlan.c    |  6 +++++-
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


