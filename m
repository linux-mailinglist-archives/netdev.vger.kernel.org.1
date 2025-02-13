Return-Path: <netdev+bounces-165885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30446A33A07
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA92D16583A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09FF2066D3;
	Thu, 13 Feb 2025 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW6MgKex"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085831EF08E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435540; cv=none; b=NvNtTN/XVDbhTo2AuXiSAeO+Kg/7UuVqKvTnW+0DAYTgdaYphvNelR8CPGjS+hMvZYxxyJ4RnGDud+5iE9S06AlhhuD2Opaf8sMCb5PZpjvBk0fxVkFfh/PlCQdjQHKUtsfN+5GZQeMB2yyso5JVGL4qo5ggEXmDYiNAIa5+FTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435540; c=relaxed/simple;
	bh=YlefXjGTL0eSQvBmi2CslFXUiC166yKtYDiMoY6oWFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D08mkfPfvGorln/lVo+wjFaE56tx4v7LZXrp/WKyHRFN6nYEJl0+cxUErTyqZ1e4B4qRXPoFqOh9x0qwdSO9+zB1hI5vriRKQQuVFWsoBE8HxotFKx14w+cP1Scy+8CzV/m4e94gM+FutuWQyoRl52f5tYHewS5BTHBQAKYVn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SW6MgKex; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739435538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENuQ32gYhMX1EzHPxj9FF4Xz7hJZvyYYLV1/58R+loo=;
	b=SW6MgKextFI8/LoK6yOG4B0xCH/jPSQ0Mhp62VV4+NDnnTJS/Yt9aLPqM7f4xY3YM+pgPQ
	t60fuMq17B6y1+vaSgb5HkovTqrtMaFXI665NwK997cw40RE0kJlI+cpIbHyzcLR/yWxt+
	h25cPt6SJf+41HuGjWtI+vARA++ICFU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-1uILxxOvP_iPvA8JEuJVYQ-1; Thu, 13 Feb 2025 03:32:14 -0500
X-MC-Unique: 1uILxxOvP_iPvA8JEuJVYQ-1
X-Mimecast-MFC-AGG-ID: 1uILxxOvP_iPvA8JEuJVYQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dd533dad0so408503f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435533; x=1740040333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENuQ32gYhMX1EzHPxj9FF4Xz7hJZvyYYLV1/58R+loo=;
        b=lIIQWqVSpqgBOIYfl7zcgDprbKEM/7R5C+Hi1uMaZtg+3TInmfaY55Z1W18TTmaE6n
         Nhrju3Fm20PlloFKlzvbMdCmlZvlwVM38MFG+1/MJIgQ4OSFe6fLIxxXQ2GB6LSAXrdw
         aerLYsQ9FVQjG/d6uHsXqTpzORHd3dgwW1no9YTLZWlq9JULMlQ32XtIi9zOX6Dq5zxC
         rKAJ/vepBYc7QH4OhIhcmwjM+sr2wk9JrAO51BoZLt37/gsg6Flx9NelB6XrKH2P4AS3
         DlhPtrIjYHvwISUfsRTKglTm2NHRHXm2rpF7ho4ss8RozakaQtbXXxieUnoSaPP94Vnf
         iubw==
X-Gm-Message-State: AOJu0Yz3JyG/WgASdOC/WXHy+0lyGFp5zh/HaBuhjRI+KY+PXSGGcCks
	cz8O3NevyquqE583JFcw+xLeNp5ZHEc8Pu4dCSJPsL/UgpzshPZ8hG3lPBXdl6SLWQ98kP1aRU1
	4/YHqaraiyutH3cd6FBfEjKoJJf5LDyRY62TkrWmRspIP/1izgynfTA==
X-Gm-Gg: ASbGncs1003e4w8R5Gj2OZiCMPOqhyk82cyRIxScoRlFeBZ07mXXhRZUEXxEi334hCH
	IBQVCfGFTloK8BWEBDzMJAulG1zYoHLpReGyrfcWa4Mmwo5tgSJVrnuWxcq3UY7LJQo0Pf9PdFT
	s6RRHZ336yzWI9jTk7YPtp7DSZ8+KiSn8zhUu7PhrP0Cai3hJlqQ0xv2zUO0+C4ptC0qWbCDGx5
	slwkAkYNRrGQsxnEHC/O7Z34sc2zjA3bsLHWWYS5E906kg1EXlAIX8Ikv4q6KDWyhPRPP5zfrDg
	QhbizIehzUt1Tqc0dzGvblAN1bc1hZD8MKo=
X-Received: by 2002:a05:6000:1863:b0:38b:d9a3:6cff with SMTP id ffacd0b85a97d-38dea26e512mr6609021f8f.16.1739435533447;
        Thu, 13 Feb 2025 00:32:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiFu/jSTpXC/+T3CTqn5p3U9vYIZMeiFX1UGb8dak8XGP707d4uTzj0+ewO+aRimLoPXa5Jg==
X-Received: by 2002:a05:6000:1863:b0:38b:d9a3:6cff with SMTP id ffacd0b85a97d-38dea26e512mr6608990f8f.16.1739435533113;
        Thu, 13 Feb 2025 00:32:13 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c29sm1188049f8f.72.2025.02.13.00.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 00:32:12 -0800 (PST)
Message-ID: <94376281-1922-40ee-bfd6-80ff88b9eed7@redhat.com>
Date: Thu, 13 Feb 2025 09:32:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] page_pool: avoid infinite loop to schedule
 delayed worker
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, ilias.apalodimas@linaro.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, hawk@kernel.org,
 almasrymina@google.com
References: <20250213052150.18392-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250213052150.18392-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 6:21 AM, Jason Xing wrote:
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1c6fec08bc43..e1f89a19a6b6 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -1112,13 +1112,12 @@ static void page_pool_release_retry(struct work_struct *wq)
>  	int inflight;
>  
>  	inflight = page_pool_release(pool);
> -	if (!inflight)
> -		return;
>  
>  	/* Periodic warning for page pools the user can't see */
>  	netdev = READ_ONCE(pool->slow.netdev);

This causes UaF, as catched by the CI:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/990441/34-udpgro-bench-sh/stderr

at this point 'inflight' could be 0 and 'pool' already freed.

/P


