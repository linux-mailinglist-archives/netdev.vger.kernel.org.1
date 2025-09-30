Return-Path: <netdev+bounces-227349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6EABACCFA
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C76D19261BD
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1C2F9D86;
	Tue, 30 Sep 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K/PQQRGa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF02FB0BD
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235114; cv=none; b=U7nL0v703K5d+ibOoZBrlHTltDkhc0VO5hKGRqNLH0h6+cKKDvImsBOBGV9jJo2cJuUeXpPqMLilCW2SdGxkGMvhdx6+GCkctpAW399ZMLGgprnXr2gPqCY154bNY0sPodciA5j8iN5CfowksIGbLOJvtPzC2VsKfMcF/nZXZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235114; c=relaxed/simple;
	bh=QKDUayNXOzOOMtKL90Ar8gIilWI2F1XfDcDNm6l/qas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSskGqFgem7dI4b4hPeRAGVkqZfocwvEQgd8YK1I/gVlhaQdgcoK6Q3OILnYak9S69aNtXoHMNpWZ+Vc1qhSIfVxJX4ll0kWgro4ihdameiCw7C7C1CbPwJEgIYTj68OwSNjGjyS0BNH1YfXwm8fQWuShjP0km+gO11NdBn40KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K/PQQRGa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso4227800f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1759235110; x=1759839910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p+Vv7moa0Oy84aRbbzj5eC4jA/JL5ZO57KP416IAkbw=;
        b=K/PQQRGag4+Fz0CCDWIN0gsHu4Phwq3263THM+7zdShPQZlkPvWV7a0BZx9i3dG4ea
         i+EjSEFYRMPvVVXKdlFMv46Y9q7NHg/L8vDZKehrt7RNkwzPjrWkybpIKilb9XXVrweW
         b/snmJluQI+i09yaofBWKAZBzfFbr4lz5YFqOrtVbMP9e3AqLKp8mgzbmUDCYQzCM5mI
         5dpQ1dLuvpxWffr/Kq21mv9zZQdiAh631znxwcTp77pyOG3AkYfcrqXheXWLBWwupFvJ
         BMcd/9T4pgb+xcB4ukcCZbpOsSdJUTHtegDkj+Vd5QV+F5tmyq8vjAZyQX7wjISFdJRn
         rg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235110; x=1759839910;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+Vv7moa0Oy84aRbbzj5eC4jA/JL5ZO57KP416IAkbw=;
        b=eNcdAznZb0lSwT3x/FWyHcAHru2LisXV6/alJqYelGsH4jdbD2B2cBbwXXCgbiXk35
         H69P+6VGu560ini6zXzyqyXLB/1ycyIxBSOkK1MI0zpaqf4ighC5pvapEatHi0rpTyNa
         O5PymtUM/n/aSwv/Y1x1BO7SwvAZhN9eoAu6cXJyrcrgdSjPh9oqFn/Djwm7yii8+nwf
         vwxjBf8IVYxpWwS82vqTv5N13X+0scE9IKapAC+eM6rIUCbVQ4y2HL7tFvsBDbSxyurT
         W2B7P4+J4GZbQSq6FCWEEqGFpQE5YgYYdmw0FWLBodN2uqYjz5lbQIUJX+5MLungnKnJ
         oRvA==
X-Gm-Message-State: AOJu0Yzx8NgkmRFqgJEjxjYfHA4Uen9mGGriGoz5qJW99WFZ9eicLe4Y
	jUOne4mgb1OjwMfSF20LtarGfoW8C2dBswHZ0draYgmR0lwAiMcBPczW2dowgjcNNhTokvV47p5
	p5ad3kRWllCsnqDm9HasiMgVBnoUd35xdiBzSskpd5ipODfMq314=
X-Gm-Gg: ASbGncu+uM1mVqQTrMzISsmFY4xDcaXhVmUyZLO3M4FJgbzZcxsXcFTzRNCsOP0TPG7
	eAcGKnj4ckT1LC7oHsvlvXPkFiWgekh1RVYDhFOmnnDT8hqoRb70dG/4fcPXmInrqgXuRkI/8Xt
	zGzkQ4gmPKM7Dqf83LCEK4S6zWGt6H7PZ552BALizUk3FntFPLvOxfnOO/nWWHyhtMRdhqYfuiO
	W/RUEKYvzLQRQ1knBBkIV64SxphRzXECq23l9N05lQ7fWzpcluZdara6m5gou2TLLWBQvzrTttr
	bIDtJ3cgbvhehy7KydJhxpyqw9mlRA2Hj1pZa92yFPVc709TkxKNzgvA/6GSfn+rW+uqEp1P9fq
	o9zM/LNcqvGYXpwmGxxCizbLkgaFz94IbX4xCdYIP8+WOP6Hl6Tas/qTGUZn7/LF3cuG46FE/Yx
	Y5MM1a+mk=
X-Google-Smtp-Source: AGHT+IFoY6TKItJNzGEEwi7h0krjRzVGjyFsy0vk44BWxFxzF1vlg+Lc++e5Dw5n9ZwKS/ZZqoDXyQ==
X-Received: by 2002:a05:6000:2385:b0:405:8ef9:ee6e with SMTP id ffacd0b85a97d-40e4a8f9b38mr19809866f8f.25.1759235110064;
        Tue, 30 Sep 2025 05:25:10 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8f94:27ec:8b3:19cd? ([2001:67c:2fbc:1:8f94:27ec:8b3:19cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm23164461f8f.13.2025.09.30.05.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 05:25:09 -0700 (PDT)
Message-ID: <9de2bdf7-b246-40e1-ba56-37a6a1e49826@openvpn.net>
Date: Tue, 30 Sep 2025 14:25:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] selftest:net: Fix uninit return values
To: Sidharth Seela <sidharthseela@gmail.com>, sd@queasysnail.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, willemdebruijn.kernel@gmail.com, kernelxing@tencent.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 david.hunter.linux@gmail.com
References: <20250930120028.390405-1-sidharthseela@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250930120028.390405-1-sidharthseela@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30/09/2025 14:00, Sidharth Seela wrote:
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> ovpn module")
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

Acked-by: Antonio Quartulli <antonio@openvpn.net>

Jakub, if it's fine with you, you can pull this one directly in your tree.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


