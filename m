Return-Path: <netdev+bounces-97214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A628CA053
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CA8281F14
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15441136E37;
	Mon, 20 May 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqgOEFTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9784C66
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220539; cv=none; b=BbSm8y823L1eucJTUKIQP52z5y03VrOltu+ww/jp9XU6mg092wk6i+ZLhA72Yz0mH/n6NYrGstcxW5KCzOXozVFmU0/foRSD9iGlD6izqpppT8oSTX0VLgV+5YELqs78GcQejCA/T+7MZsWN/ta2SPjPq6mXPfEtsPuM+Mf8upM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220539; c=relaxed/simple;
	bh=pL4pgl58LiaiCsjJ/shOPyA+I2v6kEZS4ckmCh2VPa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxGy2K2VAqfvkBTrwzlgIze7Rn2kbJoyy2JUhZMRW3y90pgtIsmRNTw6AO4PM0Ay8Lepj4UehVp4xEOlLcpvqWdOfwvg6fBmZ6NLMigcP1bKVJhUdT3KwSok62TQj60OvagW2SA9MhvsuSkXKkMbnBkMoWIFX+tDd+QnGnFE0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqgOEFTL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42011507a4eso21338915e9.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716220536; x=1716825336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VmVex9jmSwDFelY7prfhwRXlLkvGgzGN+LKLCOdVOY=;
        b=IqgOEFTLO5J9U4L53qM6RFYQBrmL/AwoSq+wDCjofC3GmHfMxVSFJnPMPSv8M2bPyh
         lmWIoAVEF0yZYVhLwkYz1ISzvn7xR8cdMIJ2eQ5DvIJmhwdw5PaI5bzvPkG6ytHCekBT
         jtINUVmYDMnaah+B8Zy0N9nAx8WMhkHKy/viTWo3nCpjctaekM6rOJ2jxX3UhaJNMH7F
         xBQPimCgjsCSEAaplXHpur6azBn5xvKA+K0djx42BY4ywqsP+jJOcY66AagiUGNjW8HF
         If7y4zc9eUXIiDAijEf6OtsTAqZwbHRkjeiu044ZpkARfjUui8tHrt0NIj6P4X6bnxDj
         uwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220536; x=1716825336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VmVex9jmSwDFelY7prfhwRXlLkvGgzGN+LKLCOdVOY=;
        b=nDC0+NCN8vDg9KSDdufbReWZxNOeLTp7ISy8cG0oREixkOnx4d2mH8y5Y973/UYzsl
         3l+rDPVfB+hRYIZ1ekZhKsNzGNqg7gAsgPv2cjo4uZ4zYM6TJCiUS4U0qom5YCX68qEm
         PuF8LYTm0cBK3eICa0eDWKR9v3FP9A6iVZ8l4kkAdDOc3Fv1eGqZYapwWQeZuDvhkKKy
         E9Srv4n9GBs14+wmz7qBg+s0u2vZFUWw23tJoRXjw5wv1F9l3TGzJOYlmoas2qyaor5Q
         N+5HsbYUR8gCpqLqUXoAWgGWjI67Vamy/ddMqMTJx/VczM/8Gnmi85OfGRjFnUWI6arh
         iNbw==
X-Gm-Message-State: AOJu0YyKcw6WFW/s0tF8ETzO27bgWiI/XULo3tXipPNuQ2t+WGy0T+mC
	j2xwPaCL0+X1A9PawMJBDIEVIQlT8JxAxuOy+RgRJKALN7+/CUiF
X-Google-Smtp-Source: AGHT+IFRc7IBpnCqfRIEt+QIOEewXSvGmPf27umkedhWTdmjRYW2+XeCQKZ3xETLmSCFwNH6MQuUGw==
X-Received: by 2002:a05:600c:3582:b0:418:29d4:1964 with SMTP id 5b1f17b1804b1-41fea539b5amr231562995e9.0.1716220535458;
        Mon, 20 May 2024 08:55:35 -0700 (PDT)
Received: from [192.168.1.227] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42014c21260sm313194135e9.3.2024.05.20.08.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 08:55:34 -0700 (PDT)
Message-ID: <3d6e07fc-cef7-4480-a12d-1d70930cba1b@gmail.com>
Date: Mon, 20 May 2024 16:55:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "r8169: don't try to disable interrupts if
 NAPI is, scheduled already"
To: Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
 <af817788-d933-4cde-8bea-942397fd26fe@gmail.com>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <af817788-d933-4cde-8bea-942397fd26fe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I concur, Heiner's patch is correct. Sorry about the noise.

On 20/05/2024 14:50, Heiner Kallweit wrote:
> On 15.05.2024 08:18, Heiner Kallweit wrote:
>> This reverts commit 7274c4147afbf46f45b8501edbdad6da8cd013b9.
>>
>> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
>> default value of 20000 and napi_defer_hard_irqs is set to 0.
>> In this scenario device interrupts aren't disabled, what seems to
>> trigger some silicon bug under heavy load. I was able to reproduce this
>> behavior on RTL8168h. Fix this by reverting 7274c4147afb.
>>
>> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
>> Cc: stable@vger.kernel.org
>> Reported-by: Ken Milmore <ken.milmore@gmail.com>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
> 
> This patch was mistakenly set to "changes requested".
> The replies from Ken provide additional details on how interrupt mask
> and status register behave on these chips. However the patch itself
> is correct and should be applied.
> 

