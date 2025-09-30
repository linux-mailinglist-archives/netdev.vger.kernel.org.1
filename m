Return-Path: <netdev+bounces-227282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15910BABC38
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7FF7A88D7
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD22BD022;
	Tue, 30 Sep 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D82SuFTX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B8222587
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216243; cv=none; b=AgDSRadT9eqVOCnczd0wf7deYWUcQQDLfQ0kxaz7qT0BoIbq3TtSM4as4RdpSNp3oNNMXKe1S7DaqiGQye/zFmjylsj+ewiUKDtJE4bdSr1GX2eKpQpr6D1GZfOKsOlOezi+M4yIdlv9LWd6jBRIGBWNvo763XR3xm9rgwAWny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216243; c=relaxed/simple;
	bh=Denl1qxGVo41Q7d0YQr1Lb2bxdfCpeSVRs9tMPHWmhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfphV0NSFs1dsdbC2t3CqsBkyidnwUgn4afGu6Mfo0hWj5vBEzU6rGKOMAIb+AjqNGMf7r61Ao1qvBqi+Xfw8H90O8DHLXxF7NOpnlsmjEH1IZQ53cYM3YziXdVESME2ZhOXk5sK95R89Q8WU9CVX867Cp1fO/oFtdnFoqPawYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D82SuFTX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso36782365e9.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759216240; x=1759821040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9RRPGHytRgN97Stdv6ppI5vkL5PAh7jux1HTdTPQWo=;
        b=D82SuFTXvTCOfz+r9Lvwg3dSnBSzcoewksfEcKRQG2sWCJe1HdtZ5HW1O0aF/AO8qW
         aM++AHWdbSWG0rSxMcBSbIYx01IZtaaxxma1IM7ZTwa+mN5ep30G+4VsiEMM0aCKCdaC
         ccwi8dpApv0C9grt45DKisadO5ReJVSXxLQL6pvRyKjsOrHyWRdqWwJJkjXDqN9wyBD4
         o2hF7cozesnLwl0V9pbRYhKX/KOaeWgqVrtpDLWYA+/OKqqCQfOvxymNwKOnQBWc4hLk
         QPR3ywtS7xNzP0hafANAuGHhhpiSQn/s/BHQxOOr0/8VGoJ8rAqLdLyDLb0yuebVLhXk
         WroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216240; x=1759821040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9RRPGHytRgN97Stdv6ppI5vkL5PAh7jux1HTdTPQWo=;
        b=Gqw2wVEr67j3O3BoLmP0RL/0c4zGGLgnbJMfzHT1XnRKWeIRtUEmF+MlMcYznorPsZ
         88uNHqllSetIgVQQgW/ZrC2XZMldJOb6Xr4xY13AIUymGeuy5THu0JbQW/gL0hF8LP0E
         Ui4PNuYQv73IFxdQDAomhlAl5gjFXtRDQUpfeQhYG4mcx/oOi19DZU/O3N3hGf8VQLbj
         awv5V6udAD2wvFkQPHr13l1IgzpJYl9t5tNlaKbRP9+k+pMLFEr8YfA9mZhuXKYMS0fd
         dpddSKMcFuEQLLsf0W93FrLKGAYPqAlXQAAKNEh+zHMGBhXSTN08kEg8FI6S/dCzx4Zo
         KeQA==
X-Gm-Message-State: AOJu0Yw946xuXtIhtRid+12wYnvpc2xbdjOFYajy+zZgXCA1ZCBjDYrC
	FrIjOHo0xPhQnLY7aGYai2SGVyfAMUBMK/p6O588jCOTd0PqCGOyI83Q
X-Gm-Gg: ASbGncu2B18gnFZuMNTYxXTX/acxk6rvCcz/htslDYSPE/SoJU7Z+TUsjUREHXiA0sg
	2pmUVCeL0liEWTEhS4yiYwZ1H+Q3sTGt3UeH0K9J8sD1KYg53dmO4Nu8b/jLg2PmaYka7c0kiw/
	IsQGuu56UcEOdxP9RJrbrtq0xHPaKfQrYjGebIx07gxJh0kgqAEeJqnmPStIGML1NQn7KwYW340
	TlYqY7kGuPFpqxdJL2BWno54faYXhNqLj5neD0z7LqHDIj2I7qUf2DvYPjFEmyydVuILfeih2uF
	vrIiF4lcVYmxWMWSdC26/DU7BbkQ5o9qfEjibMX8YyA30j8E6LTzkGW9gyWyxhbaefoiLSJvDhm
	1Eg+hzmgpmq9aAhzXI3nnTtnjVfvK4cd8qTkJ1qtPOnajpo30LgeQPpAdFOo3ThWCZ7ICRM4ew3
	QQZ3a/
X-Google-Smtp-Source: AGHT+IHlxvADxFZFgcYBNDOScTJX42OY6aNgaF1tsfuhrlEv7RiVBXLK6R30nOuArkYTYX9gLCEy9g==
X-Received: by 2002:a05:600c:3f12:b0:46e:41e6:28c7 with SMTP id 5b1f17b1804b1-46e41e6293fmr176295235e9.8.1759216240262;
        Tue, 30 Sep 2025 00:10:40 -0700 (PDT)
Received: from [10.221.203.31] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm257605555e9.1.2025.09.30.00.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:10:39 -0700 (PDT)
Message-ID: <5d2eef31-8e5a-4831-b050-cdfd65e99e27@gmail.com>
Date: Tue, 30 Sep 2025 10:10:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] page_pool: Clamp pool size to max 16K pages
To: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250926131605.2276734-2-dtatulea@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250926131605.2276734-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/09/2025 16:16, Dragos Tatulea wrote:
> page_pool_init() returns E2BIG when the page_pool size goes above 32K
> pages. As some drivers are configuring the page_pool size according to
> the MTU and ring size, there are cases where this limit is exceeded and
> the queue creation fails.
> 
> The page_pool size doesn't have to cover a full queue, especially for
> larger ring size. So clamp the size instead of returning an error. Do
> this in the core to avoid having each driver do the clamping.
> 
> The current limit was deemed to high [1] so it was reduced to 16K to avoid
> page waste.
> 
> [1] https://lore.kernel.org/all/1758532715-820422-3-git-send-email-tariqt@nvidia.com/
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
> Changes since v1 [1]:
> - Switched to clamping in page_pool. (Jakub)
> - Reduced 32K -> 16K limit. (Jakub)
> - Dropped mlx5 patch. (Jakub)
> 
> [1] https://lore.kernel.org/all/1758532715-820422-1-git-send-email-tariqt@nvidia.com/

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


