Return-Path: <netdev+bounces-247147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B360CF5043
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1911C300819D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98965337B8C;
	Mon,  5 Jan 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Foj1a50k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385733BBCC
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634471; cv=none; b=KCCQ+pgzXRXphfPej5/iioEzywACEv/ar/9P5cM+TCPVYCRxnDU6T/O65u1TVWgkIIa0AZLCX0UfaZkCDBpoSjixpm9LEv+/EQ51g44Oc2uvIfFidLzwnNaCRH3rfuTQRhsxX0UkBqlIEyZS5Ha1xxUUygK/5DPJTFui0x4iJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634471; c=relaxed/simple;
	bh=+jgJSxpmZjWfvJxK2c/JIkRHK0d/ih2f4akyjIPtTOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdHt3G8B3fqpFpo6fdSYClXXlghvj8Ye6Nhan0/kdRfTCHLz6nqlskSWEDXh8eq06etog65unBh1dkBuqSBGK4tL9oho9hXibi20cuc0a4EByrmcOUfreAIZv2KJRD2+uEDh0aR8jZd8MIZrOKbLWcQW/p7TgzinV7/kaJSVkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Foj1a50k; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3f584ab62c6so79621fac.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767634467; x=1768239267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wof21Ye/iriQceFuK7oaB45YPpccWh/bxfAHTi5Sjec=;
        b=Foj1a50kTnOnuOL/yJnMqZQGFYgFIa2uJEswW+ob+0HowPYA3ghg0OuEvZ+yWiwvwA
         HoJezma+d3kby4XzfgsCDNcHNGzF1p1KtGlw/s347r6JkEo1Dw+eBxprKHoU9npC9k1P
         iSM4Jg9w55r8BNRzdNyAcE4OWwz+l1MdxzNAHNOOitMLzWtm85cTiIsFlbdzcdIn2Lt1
         4aGx3XugVQL6oSWhnMEAqgv4x+WH1d2ZwB/VNmcAWZONZZF4XR0PNOBtsTqfcHdifgTE
         1L6W734g6HVrlWVNutKVpWGwT7kXQRlLq7sEOlMvmk8rIxKu7DkDRMYf3MGmg27yyZ0S
         n/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634467; x=1768239267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wof21Ye/iriQceFuK7oaB45YPpccWh/bxfAHTi5Sjec=;
        b=PpnI4vKTyf8AbN9RqlH+0jHitIHw/Fn0nCRygU/tEGi2yUeHsKGxqXyPX7LKNN8N8w
         5Cej/z4NGFcHPC951AzsVfDOEeeNYnpBt9i7yCpqgx0w2m9uYfnH6Pw3zYnSWcXYlqw/
         chM+VC1kuCiFFjMOrTSGSV9ezcRsjxH93nRnFYXRkNGjusVEDpgV1NUfiD/WKEXVm51m
         hgtUXGSWGjFu3JLLQuBh8XMnQOyiaX4A8L2cDMtvBEOn7bBXoBq8zZdqOkz7/+lP3cRm
         m/7gpsPoNBg7/0MidTtpXZ5wYgWC/wrCudconKctOoMnwEnwUlyusBQVHp/W8OHbeent
         DfCg==
X-Forwarded-Encrypted: i=1; AJvYcCW4rK/KE0VtNFbm7tYwEb24VLeMg/oBp5Opj65000HKesJ+zLc/1XLeneI1gJqFBDnFird1UEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFQK65kwqy0GEwemst8espGlUGH5aqulA3EBHh4Iq02ZgmnPZ
	i8WqQr/R8zpVLSlYzBIln0O2unjAVuvH9cFD1Pj53lC2EI3leli7Dt+yT374W0TOGxo=
X-Gm-Gg: AY/fxX73glvX6OHUYTJqgngRC1Ja6QvNefI1Pd02I26TVZeTSrrpYMEipiQi1pY4TaZ
	TLqkh3kQDTW60adgfbSXaO/HOvW0BSSXiA0puWNyGBjNJ9nA8jeKdE7TpJpNJT0F7+FdFdeI4zh
	WlqsaXz7ulUTD/exlNAJlmVV3uz6t33O7yBWRNrlLx8Wug/7H29ZIzt+CeRkQ7ZOK/vYkR498oy
	ibBb45RSqoNTbvK55szexDopidhcSNQLg896UHv74lW2qzIGZrPQhaHZSiJtXQ2o9KNhuDvtx8g
	4/gy+Xbbm5eJt7ca8WPZ7JfHJLlcQG2s+KGI0wZr/F8txsuhslquQ0q0Elezt/XWVjQdKvGxuH+
	xqujLqauNhpN4F2iZ0OziIzdZ52JLwVrF/DCCfXzSyxqXg8qD62yOEtxCHBrhLUJOiW/6mbShlN
	T8ABs07VsA
X-Google-Smtp-Source: AGHT+IEI5Ifmw3xcAnjeXL2v5MXUWwo624uwk5nTpx612pgMboDW3Zj/rx7tR2d+Sfr9CuMohoXiRQ==
X-Received: by 2002:a05:6820:4b17:b0:659:9a49:8dfe with SMTP id 006d021491bc7-65f47a653a2mr103038eaf.64.1767634467574;
        Mon, 05 Jan 2026 09:34:27 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa030d77esm120688fac.14.2026.01.05.09.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 09:34:27 -0800 (PST)
Message-ID: <c85d912d-8123-41dd-859d-255b4940b4cf@kernel.dk>
Date: Mon, 5 Jan 2026 10:34:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 Willem de Bruijn <willemb@google.com>
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 9:32 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
> 
> This is a kernel-internal variant of msghdr only, and the only user
> does reinitialize the field. So this is not critical.
> 
> But it is more robust to avoid the write, and slightly simpler code.
> 
> Callers set msg_get_inq to request the input queue length to be
> returned in msg_inq. This is equivalent to but independent from the
> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> To reduce branching in the hot path the second also sets the msg_inq.
> That is WAI.
> 
> This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
> post cmsg for SO_INQ unless explicitly asked for"), which fixed the
> inverse.
> 
> Also collapse two branches using a bitwise or.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

I also ran my usual testing, and as expected, looks fine as well.

-- 
Jens Axboe


