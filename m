Return-Path: <netdev+bounces-165479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DBA3244F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AFA3A835D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00C209F41;
	Wed, 12 Feb 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwZLqGEQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EA2AF19
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358503; cv=none; b=L18J/nt+0XEbSufDhfMdEfBb9/1vOkHGvYosQguU/d3tQH0/MuclFxhX0GaejtZtLTacydCE+fEC6FAFV65kHuHxnOw1yzqlZTFGE0QsO24Gh1IywCqfQAkW5wv+sntjF//dkFMuY8A9L//CSOTCQRXeaxJ4jpBbOaKc37yn0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358503; c=relaxed/simple;
	bh=85Co+d19kT1cakG0SZaW0ZS3CqpbLTGrvVd9p5IU+yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhZ9XoNoAxlJ1IxSpL3VPrKKtqxqzqK8UODJpIhMOboj6mAyK9VP73kbDs5V2HVYCFSwNPykVZbXjQ1eltvwMQaPjFs9VD+2lWLSrKpf68XzUVF73UbjxHgf/OnQjWksI+UqO1XGZVMHG5SN879eFt32cJiXrlL2Ac6uqPpjmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwZLqGEQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso2316385e9.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739358500; x=1739963300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BuYukZKR4OUv0U2411Jh9NdqWkm3InFFN1pT/WlmnY=;
        b=VwZLqGEQH22WqQoPLVkox4dpnWXAe2TaIydqKUXK3qYQe8IN+9Rcvo6/TEfyp9E5ST
         T4qHbAIdPNFP0Va4WbYJ7ejrSYnE38ibKveGooktLjziIoG3G0PW4x6oz2wZFRlxva0P
         TzuMfO4X6c1pX2uQizq6k28DVwDQ6wcc/ycOnJRtVUbDeU/7zFjPYFv4DGmFEsZZabcy
         wvhOQ10FPBtbqmIqlFuK6ReyrPtw29BsDzQhwrxBuz7GmBsAJpcFYnYrakUdCJdbfBYz
         X2WcXG2gPpG+59IaiKauCXglzGVjFIV0J2SW+1MJe1J7TeqZQWm4O7KVKCe5Na7n2Iub
         SX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358500; x=1739963300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BuYukZKR4OUv0U2411Jh9NdqWkm3InFFN1pT/WlmnY=;
        b=Ma8wpU1vFAY9MvBMi6eL5qOXSXxItymrA7NoPqidG7P8MVIx69pJSmOpn2TbIhUnEy
         9V5qzIg0hOJE156mwgGWAMkYy3fk8tUWxLsX1pPdkR+pPZ9TKb7prSSb5Ebh06eiIRb2
         4MvJGeGyPFpJ7F9dcsnxHf+z2KdA7yQs7dZKVSZhOBcGVytM/6YnFKHw103JaQ0XmufN
         CWmc/LV5K350DBGQPJCKIiwFj/ch2bHOm0nA4mqZgU9kkEDYeY30IFunOAmGYTNRBGw3
         vhLHS34tr9WDjtMMumfC9VexsxQEvLrhtoOpw88CGwot2Ns/AzklR09Vh5QpPPrLL/lQ
         NHbw==
X-Forwarded-Encrypted: i=1; AJvYcCVqNUZEeQniHDP6+iC2uiI13tlYgGycFr9FE22W8LXKpiAJ6uWXoVyvo3IHNWJbUFyBpCh841g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpFTtsK6UfISybBSgJr/O9dwYK0wJQ9WwcXWngA3kKmv9tdsr
	YeSwzEu3dBL1V6ZY79u7uiUTS5EwT72xaafJ/MHo0+AsXY7fK5Zn
X-Gm-Gg: ASbGnctTM80KLz6Rlccn7Q6PVPfoPj/G6KWSiicDYRNZlmOrkck1JspgM/fNWc9qOvy
	fOYGl+1ipdTouOpMa9F2gIycoiOeyBzikG5k+5arq9fwILRbYt1e1wpt/qpK21l9VjpZBPOWwFt
	a6sA2RvuImP/BcvKo7Ews4HGr2vurx4/PIPGtzlKrrNCBrAQsJ8ijBPZ3wK1qUoiRATE7bxO9CJ
	Gid8Qh23xiptLnC4RG92EZzZ8GaN30dNUjCzk4QAOyHtCm7DY3EHQNZ+xNc8FIk2cqnw9Ika6Br
	OoM0UwybF74FzJAaFIu0lnQYbd1XraI0
X-Google-Smtp-Source: AGHT+IFiSER2ZLNBLrYGSO1KxxlIJqsl0D06vFKkNHhbSkdsg0InIohUC2MXfM7SQp++w1EXxZZUKw==
X-Received: by 2002:a05:600c:1ca9:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-439581c9c75mr23983815e9.27.1739358499399;
        Wed, 12 Feb 2025 03:08:19 -0800 (PST)
Received: from [10.80.1.87] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06ae8asm16362955e9.21.2025.02.12.03.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 03:08:18 -0800 (PST)
Message-ID: <1a87737d-6677-4fee-989f-47964f782725@gmail.com>
Date: Wed, 12 Feb 2025 13:08:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] Rate management on traffic classes + misc
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
References: <20250209101716.112774-1-tariqt@nvidia.com>
 <20250211193628.2490eb49@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250211193628.2490eb49@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/02/2025 5:36, Jakub Kicinski wrote:
> On Sun, 9 Feb 2025 12:17:01 +0200 Tariq Toukan wrote:

..

> Tariq, LMK if you want me to apply the patches starting from patch 6.

Yes, please apply.

> The rest of the series looks good. Two process notes, FWIW:
>   - pretty sure we agreed in the past that it's okay to have patches
>     which significantly extend uAPI or core to be handled outside of
>     the main "driver update stream"; what "significant" means may take
>     a bit of trial and error but I can't think of any misunderstandings
>     so far
>   - from my PoV it'd be perfectly fine if you were to submit multiple
>     series at once if they are independent. Just as long as there's not
>     more than 15 patches for either tree outstanding. But I understand
>     that comes at it's own cost
> 

Ack.
That sounds good.
Can be helpful in some cases.

Regards,
Tariq


