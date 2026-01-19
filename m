Return-Path: <netdev+bounces-251134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C242D3AC34
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 748413026127
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19103803F4;
	Mon, 19 Jan 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Q/ay/aYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDA3803C2
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832626; cv=none; b=qcuEnWZfE/T3YGp6KYjZChDsjZsGkIzQNNpAzCCSncx19W9wrHWhZOT7qxd/YZSI6jJ/37noSdUsvPK5wwX+o1x7U/iHA7MaO+WSitAXYQMDxPJUB+qiIM+NrfnWsIPcfIGCm/I2bufB1XTpRN5awnokCZxnMvvlSoQb2K8sIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832626; c=relaxed/simple;
	bh=zZ0PjRaGNoNIjizP/YoFSsRkMVKdRT7t0wNKljIe4Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iiall1oP1XZwMunE65tV0MNj3syUjSaOKcg33XHR+ASYKK+Y94EtZ7ubk/TFgE1K2JvRKcFEnCLMIAza/20oPzJyWO3ihpjXekZEfS0t4wVQijSYt4rh7KwEvrvxO446odYk69pubXJVNeob3x6i+HYsR9onqALlRYWmPsacT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Q/ay/aYw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2358207f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832623; x=1769437423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sagjUhqCfmZJ0S1szqVmFs4xTlkzA3mfjQRcJnDcOk=;
        b=Q/ay/aYwXEEO/pVzzi0ZjwVOQnx7hQGWGQHzFtxKxpRWEUWnlszIbmXrh9FeQx4M8F
         f60ISipy1CDwjDtOtv9bKWEu1Kosuy9eukjCFe8TfPePb0m6B74HcXGLY4X91KLvCwne
         92laJ4KQwy6vKy8cmYrO1mxuumznFUIp90K0AEfxN4O34W0eOBrEHThqQt1kD0sSRYY7
         l/+oDPzh5LaYNtpKvM53V8UdeyXErHhr9IBsBoOhBDiigkvrkYCpsVYz1NeTPO8T3cf/
         LJhPufEuw4E1h5QOZtWVqxn0HjITfSL4aifExqChcacPNRM1XE+brpMRpCgmWYB8dHag
         kuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832623; x=1769437423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sagjUhqCfmZJ0S1szqVmFs4xTlkzA3mfjQRcJnDcOk=;
        b=SjqO9so1XPgVIUtkAvHXCSf8BKyNu2Kctdz5xCGYJ4xQqdL7GpKI6vyQ1yJPUomwSH
         GC1Dk2+nrfokoJGQXx+HKLIw9IO+/b4kpHhm6o7iWhyrTcX9c+rnQ6imJkmVv2Z/vDZ3
         +7F4EW1mtS5nBKeNLGa52r4zpmH4d1Wwa+1Es9OSuHw0eF3/LAiXlZqPahXLpZjsGoeN
         xVG7tcUV5EfTm6WV6JdCYMySXgHuANBcBFKkNHSnDokh9RO6Pl6ZfZ3oUHY0RsMdER7C
         jLFfOzuVx1gGqRl2VF+jZsT6goOsFiESpR/vjSKThc5S2YDAbSxFryhdvtjGK298aht8
         Oj2A==
X-Forwarded-Encrypted: i=1; AJvYcCV1wo5MZUHpnA7nX91hg/zohZjqRQiAIoFh+jdm86UuWxANzoUR/S5qzLMx9f4uivSRI5rlHB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIHZb5nC5ptmQHDFpClEijbxxKtCBDP3Lm0FQjkuwdID7zKOV
	SqDz9x9Z5s5EuFQ/k0OzIXpW1sqILJiOo9DigoHDWJXrKeTm90Qap+7tTsolA3BGMNM=
X-Gm-Gg: AZuq6aKA8WJMegVChyhCNrriMLGM4D1/tGj+66i5lSJ8oLd5Ke3+YT2KWinp1Cc4/c2
	HjtFXcvWlmgfojDBIbTcHFDboa09KHtE0hGo3cDHK9NDUhLPsOBcn2irKMgliwNI4hL26d+5T8B
	KP1a31dtJatkeRz+Vt2Dh0lG8vG7g6TtXrrGUuAgtMk04gQKda8a8YMI8316cmcOV3CpPa+PHaK
	eoLu3STwd9Yi1mehtfRexwwOmor17u2FOI7VWy5u8kTVcI7HTosYMYt0dRW0NSio9uWiWGL6CQ+
	GN/trCqlTCy+l03WNri5KkkMmMjW5Hku6EDWSzgA8lNK4LJXbw5vGluuH4wMSgbqKSXosyKDEHL
	oMwpjQOuMNrLWJ2+H3u+5VerfO5s7OJfArn9F9wuwo3IvhuuVpeaGmwRHAvVigdAfZEE9gibOrK
	SSPsHUVSeUgayXC7i915qxq6JW+fHfmr8wf07McZr1juCYsw2fNHo/7Idypc1KIN6oABuxBw==
X-Received: by 2002:a05:6000:288a:b0:431:84:357 with SMTP id ffacd0b85a97d-4356a0542f3mr15752591f8f.29.1768832623347;
        Mon, 19 Jan 2026 06:23:43 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356999824csm23310089f8f.39.2026.01.19.06.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:23:42 -0800 (PST)
Message-ID: <38c26cdb-3374-4d37-87a6-1647387e9f70@blackwall.org>
Date: Mon, 19 Jan 2026 16:23:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-16-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-16-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a new parameter `lease` to NetDrvContEnv that sets up queue leasing
> in the env.
> 
> The NETIF also has some ethtool parameters changed to support memory
> provider tests. This is needed in NetDrvContEnv rather than individual
> test cases since the cleanup to restore NETIF can't be done, until the
> netns in the env is gone.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../selftests/drivers/net/lib/py/env.py       | 47 ++++++++++++++++++-
>   1 file changed, 46 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


