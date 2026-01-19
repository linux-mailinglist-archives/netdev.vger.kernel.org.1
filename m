Return-Path: <netdev+bounces-251132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DCDD3ABF8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4B3F3056773
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3038F252;
	Mon, 19 Jan 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GJEamvkY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22D37F74E
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832592; cv=none; b=qf0F3Jsw+me7ywpJ+wRRqMgPpmqeAJHbXKFJfBJcRpXpArfOm6tXNMLOmT7s5jp+AVkcUw3w2El2z/NDQJBShRG7ZrLYl5hID6WulEvv/L76vdFnJM1zGYr+fzqeFiBQ4XjAA8tP+p3g2709nzjlX7GBBH0f0djlufPc3Y4EK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832592; c=relaxed/simple;
	bh=+vmfe/9RjubEkc/PWFw/MXV3lawEBti8yLsTrI2+qnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxLA89ZGFFoy68jqwPBkqJP23jGZAJYrWSRMdtYKtVhX1rDt5YpMLi5TbN/RVwoFZ6qEte/906y/D0ACY4qzbbBUK2vDMZEtzzeqI9CNHG7V7N9aqtFmHbUvk8XZl3nU2QEa2kbx9VgQSHKWFQNTAIXzZvWazu+hgpp3DATDLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GJEamvkY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so31144305e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832589; x=1769437389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5onw7qfTHAR0LUkxhhircx4PkvIBzCwdRMgxoUA2IA=;
        b=GJEamvkY5ElGffmfX7AGgKj7YJUJvopPO2LaBtp9XRj37Y1pF4XsiUxwXL6W2aP/yh
         n3l5dQmBm4K1pDyAhmIlhFyBG7L7JIg2vYqwJ4W/JdoKDMAphxAtCQZDGPU/lfPNR9Uo
         YfV8QW9w6D06P/8MzsyNimrXOuyaREtEhEzFIFETKhOCEIroKOn5knM+Xyev6LumYGw+
         LS3fEWd51uxRjQpR3ZLllJaeRG9M2s2B/x8ytNeGl0lwVTZfcVS2u8EKUfTLLN6BYf4e
         n7+N0FXc58yXLszCguvfeI+/hvfpMdwqiNRh1e+jDtdjUlS3QN0vhMC2ZiDij9IZ4aw6
         QN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832589; x=1769437389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5onw7qfTHAR0LUkxhhircx4PkvIBzCwdRMgxoUA2IA=;
        b=KYWNlEMzgc4HiUQpYA9xyGK+EBcfyOHl8BwhTQI6XSvgA6/IAhw4wkbfuOYi/sIb8q
         kFMPX/dYeUrDfCGJXXHJ7ImPpr2Fg0LBCBYDWjgjLZglUQWl8DRK0geINuME/t70uih0
         DI84+bAojdJNmg17hQIO/Qv4hOgERvAMeCfrZ2GMne8odbkHRDVswvXhAG9HnoEXgWzA
         c99Fm2dgno5gIMQFJVcP5g/Q/SUdoXhiPCeJwphhyolUGNVl4a1qbMFXdUp+PCB6OJm/
         R47wR8obrxAVrnGyToBCIKYj2sEORaPi/diNAeUzsFMVPepLm1ao66/rYRRA0IBMWb8W
         smVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrhvC4Gye+08sc1Ji6Ci2JyRE60cjCGBRiQLg4eEfGw4cKBzUu3jJlRVkUQjwmQKCY9XAf5YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNQJMfVin5DZf2tJWjfHppyr9CGxrFgfwmM8pc+x4PSpvtkgs
	EFlAFe1U540drCbUR3A4DOw4l+JoqLy+H5Q7jwwTCYzq+PQHYIZnvq4W62Bvt+PVzII=
X-Gm-Gg: AY/fxX6a3SG15wvy+FEGqwnTqazJfaimwOM2Qh9gSPpl52rB317yU5LUknEBvN67ga1
	EYpM4DYsxKtH9GEGLS7DtfQ8ZRWBjbGHaNhDjJYgzQoc2Ei2Uw3Dlkvdd8zr1ueUTNEDXQZUTnz
	53y6aO7dIiwS8yCQRMisnb25OWXd+DqSRN5h1m8iIrWE9HDhxn/L85fG9xJ0gWkwRN7PSZnZNRM
	4p0yMWUjRSZhSWyw/wdmebJnxRV4G9jkOt8baiQrKt8ALjNPv3gqU+8TkxoNU2r1BXune3WvwKb
	77gsS+6/WcvJFQAZ/fpr/b7yY9tWsKdaopsoyuLcDqQIKUh4NpoiPrGyZu56mjRTwfYcuPW2dik
	Ja6vNlZyev3a8eH6ccPW5kTYFEx6VYKGPVLSPSjDw8xSXexVJPTPV4PP/JsxMP/oNzvyu5fVF9X
	uqQNpiV+7JrVoNfPKoDfSXB+F6XPEaTZIRMHdQNoDbgrNLH8S3937NDsmtIhQvn/8Bia7wYg==
X-Received: by 2002:a05:600c:41ca:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-47f428adf95mr122638725e9.6.1768832589084;
        Mon, 19 Jan 2026 06:23:09 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9daaabsm82247255e9.4.2026.01.19.06.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:23:08 -0800 (PST)
Message-ID: <a9150463-0c82-4e22-ac2c-99c2336be1c1@blackwall.org>
Date: Mon, 19 Jan 2026 16:23:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 13/16] selftests/net: Add bpf skb forwarding
 program
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-14-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-14-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
> prefix received on eth0 ifindex to a specified netkit ifindex. This will
> be needed by netkit container tests.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


