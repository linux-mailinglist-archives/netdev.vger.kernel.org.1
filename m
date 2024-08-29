Return-Path: <netdev+bounces-123139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40E0963CA2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B97286904
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6F16C86D;
	Thu, 29 Aug 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="CClcGaF8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1D210EE
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916074; cv=none; b=MhiSY6l0fkzWYZzvSmIwRGiL+IoG9hAE3v6zOQOUDgpqOrEvTUpdqWkxwmYQhtGpnjt90a3W6v+/5M448xI9m0NCwh9PWi3SZT6uPK923QBp9WYW2NZzG0IUtm8O4yviupjrrmHrQJ4+rI5lBf4lqmu7bY7m4qf6ltXMm+nTorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916074; c=relaxed/simple;
	bh=S+56N/yhi012/I5+LJLIIkHXTvArb5aNOzkSBdi4pyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxAuJM/SDtdAaxzVivV6OSlIMuq4qH4GfBqRBalOS0XlXZYhIblWfxMr7M+3WUz3FyfJbM3zyakdIznYgWFcLsOczTKGT4vug5FYyGgLwpVHQaNgIwU1NmMX193SpqXnhhbK+kTeYYAlZTJu72Mmy24qUBmuxSEK5reH0/llU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=CClcGaF8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42802e90140so482345e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1724916069; x=1725520869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rQYtJXscsRhxY38Bhs2hSJ21JvWjuWt9Ip3CuAgsqA4=;
        b=CClcGaF8zyJ4fC/rssGnNbZH7e++SCfw1L8sQUpjaKpBUbkWSPsp2F4HCdZm81Q+zm
         2e3Ql8Av9MhDHzEy02siQo1UJJvPkxc7LT3VYROz+GmkbUD+cnkKTSJG5bIR4yTB3tCZ
         A7L4Pzjf11sYf1JILGbV9p4Pna8iQ001cIYA5cnU9Xp37YPPzUGh5AD8spBujB6q5H+O
         rLEpOn4cx1oAeqnWqLeO8rImFBAY/8N2R3qUkHx+ESiTcYj/D8LDlcX8Mv4Q9hznwddn
         TMMjlzNWKBqU5ZEHxkPWKHF7hk18thrXpqCx0gAsh1G/o2Sd8SPRIZ2sJxshpqWsk7xc
         BkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724916069; x=1725520869;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQYtJXscsRhxY38Bhs2hSJ21JvWjuWt9Ip3CuAgsqA4=;
        b=wGkgxoacVF3b5cxGTz0d8JqtRfUQXp0Ex2wbwNLtIw26SUPOFAkIf63K9FXiO9rHbX
         tuUSJC19XwQ/9WG60cHLQQFqPA3YEWF+4zfHPePVXapXQEhumVs1UolSiyNsUYuA5BCU
         z78xW38fkcLVQaaunkUkaiRNVgQpOfpzxCE6D3ULUHHJd0Y256xcg8NKcYBWxcl2SMDx
         +Eccboh55cuzEuKPOItE8gCvf0wrceXcidEAZ9zNJoQwx4FZCN/3+8KMAyaBKI41tSJY
         WT+0yctKFLjUEd49uDjr6Zehp4/1eHGLMSBzqbG5HqvS54FaNdCAdse4SjPiW1CCwXZc
         ne4A==
X-Gm-Message-State: AOJu0YykmvlAi1lY36Z6W9c9dgcDHqDFsAeOHLAwOBo1OTwG85+m6+hj
	xDoRSuV6lXWlAMJLBMAIJaEnb5kl67gI7V5BSb3KIPnySHrwO9bDPekG9qu2zI8=
X-Google-Smtp-Source: AGHT+IGOXmGaSG0OIYpXp9df6RQjNpLlhljvNW2vPiHSvnjrIPQb8KVviv2qUt7s5heNpEWl6K6mWA==
X-Received: by 2002:a05:600c:4fd3:b0:428:f17:6baf with SMTP id 5b1f17b1804b1-42bb0221f87mr8757765e9.5.1724916069380;
        Thu, 29 Aug 2024 00:21:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:160f:b025:5707:49e8? ([2a01:e0a:b41:c160:160f:b025:5707:49e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6a10353sm8220675e9.1.2024.08.29.00.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 00:21:08 -0700 (PDT)
Message-ID: <1eb1e619-b72d-4b2d-bdc2-fefe7ee1ebc5@6wind.com>
Date: Thu, 29 Aug 2024 09:21:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: error check scanf() in a sample
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, sdf@fomichev.me, martin.lau@kernel.org,
 ast@kernel.org
References: <20240828173609.2951335-1-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240828173609.2951335-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 28/08/2024 à 19:36, Jakub Kicinski a écrit :
> Someone reported on GitHub that the YNL NIPA test is failing
> when run locally. The test builds the tools, and it hits:
> 
>   netdev.c:82:9: warning: ignoring return value of ‘scanf’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   82 | scanf("%d", &ifindex);
> 
> I can't repro this on my setups but error seems clear enough.
> 
> Link: https://github.com/linux-netdev/nipa/discussions/37
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

