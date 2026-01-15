Return-Path: <netdev+bounces-250124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F555D242D6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A431300F31B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8324378D9C;
	Thu, 15 Jan 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRXqrtQp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkCqqllY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3C339850
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476594; cv=none; b=llWL1D5Eo0L5LdiFW0/FdGHWfEDbYemWKlq+KLEdiPOi8ZyNY4KjgVeCNrNAM2OkogW9Nk5S0Th2oKHPLRZQZpuksyK2sj4Mr4EVNlw0uM8o9rYZok6TArbQnkA0FtvtFHTPTT+miyDMj/CdtCAZIYhq6Lyz60lFJwCWpB6+quE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476594; c=relaxed/simple;
	bh=M4DvzLsCXZFYxMhwh/pssYVWxrCueXiZ8jeLD9VuKvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEdWUBIuJezB1yfLe6IixarUD6Av7g3zvxfSFA9a7vj+IyuO9iXb9Bd2NoE7PeXEw4o84IcaBa24Wqwjhar4xfUKdEGHp8dpoYnb9LCBqMBDxwj+4G/Jwv9dX3SirJUa+pOkHsmMegXHWSOvZMhZKl4pja61wq9fzZullf2u/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRXqrtQp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkCqqllY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768476592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0eXe1JzIQTafP79VBproknkanfNvCt+bvKV4XyaAgw=;
	b=eRXqrtQpMqAHyxoGCT6hCC2z59/AyLhvQUTQPtXT/kdFTnsqv2qi+c2qm6stfik1z6LlLe
	oRrTOz+P1LDyE6EjpINjZVMAhryoX0WgUqLsjWSJLgzYApQJoxaD4sr4FQCNM9/q7xNMHM
	tPJQXprfVDxnn+VZgl21tVlJjSx/x/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Un_4UEfyOeSnKi7Pq3lhcw-1; Thu, 15 Jan 2026 06:29:51 -0500
X-MC-Unique: Un_4UEfyOeSnKi7Pq3lhcw-1
X-Mimecast-MFC-AGG-ID: Un_4UEfyOeSnKi7Pq3lhcw_1768476590
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4801bceb317so3371155e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768476589; x=1769081389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0eXe1JzIQTafP79VBproknkanfNvCt+bvKV4XyaAgw=;
        b=DkCqqllY88wacqdRrjJAJG8GZ+LCfVB45iaXXJpsMiK9shGhnZ/90I9eRTxx8MFGV+
         MRtjRXBOyigkIa7DURMuOX321QSPxhojI/GdkAAkuxMXfyoBQXqtGXuzqq9ZEFzmPjsL
         ZM+HBFfroU7HSqANnEFg1qYvTHKAHcPH7MHpWOxRnF0jgYYp4u1V4OvrMPU521VSCks9
         9EJL6cSIK88srfEsTCePQyFgx/JIMgmGA8HCzhLM/FgnwUngznyjKgYyhACZtr6jRYaZ
         wVgkaec83rYB1NXky+5ksU0H8IfTE7n6r9WzkSy+iEx7n9ZjC1PFISRUDeFNqf11Eser
         1JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476589; x=1769081389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0eXe1JzIQTafP79VBproknkanfNvCt+bvKV4XyaAgw=;
        b=vm6QRSbY7Poy/3nET+j+LkWuRtUDOEMCUks9dl46cY5jyf8D4CHCH0D25TycBLIoJo
         6zhX4tCk9ucgXZ13EbPbSoVpxzRUByx0ZRUQmk85VS0LaT1AYYmfGKyTM47Ay3fHs5Ip
         9vONi9F9OfIyx878q6FneEx0yu4tJWtsIcwQO3V4UTXsK/Yj2xklf396LRPmSmaHwYR6
         6sVtpow8XPLGXyFxayeNvjYDAzYoe8UPfU9o3YVkWeqKz5ia801KIowfF2jHAmxckPDD
         xNpEB+8MHTXj+GQlO/KXJGa8wuLnzDFompUT7joTzC/ldSopJqg/6GXYFg6Rsld60KJX
         EjLw==
X-Forwarded-Encrypted: i=1; AJvYcCVWAblTOKbD8om8I1nQbFI4gJdwSW+c+WBfkwi1wIxWKNLQQLO1hJ1EQqHGw/RlbLElIh/0vbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14ZdktmyIvTu7oIQVlQz/t03M0n/RQyawAdwtUjNCP2DfS9QC
	DqVPf20z3R7YN27klReOjdSWDeb+/MGUHcmeem1x1G47/6ll6JCdB3YYlHSO8DhBOsvl1RPEqpL
	da8DGx4q/M8P0l9EkT8J3eGG5jAl8W9QvspBEtGG7GvfSzAx4b33ULNPxislOX+0MzA==
X-Gm-Gg: AY/fxX69D+NXVuJ1owFMNEtr/I1TsfzlOXQrOwTabBYuNXplw21dvopu2gZXRK2u4rJ
	8d9RkGzejICGbC2TkX+fxTzBAOlBYgSCdJ4oH7/aU690uAI0EY8qBq1CZOzcC1J3Bh+IFijUb4I
	Dj4b6txHLpmWotDD8Vif7dPsgUyZZp0cdphrjf5bXWQ5X6KpoODm32aLWi/bhovaQVup0+0YrYg
	Kc3OsghM5CbyPclF4SDvQ2ulN+koG7Ufo6W10HuPjk69uWN47P8nZq80jHPlyqOgnLdA3/xdlyD
	HRN4tGvb6R+M5Xw6zJcfvfhulYZahiXK+TtabjRQLbdozZ1T9YdLywRRkT1D3smDfijujv5J7tX
	69cMN4+2c3wahaQ==
X-Received: by 2002:a05:600c:8719:b0:47d:2093:649f with SMTP id 5b1f17b1804b1-47ee32e5de9mr75610495e9.8.1768476589643;
        Thu, 15 Jan 2026 03:29:49 -0800 (PST)
X-Received: by 2002:a05:600c:8719:b0:47d:2093:649f with SMTP id 5b1f17b1804b1-47ee32e5de9mr75610115e9.8.1768476589244;
        Thu, 15 Jan 2026 03:29:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428e5488sm43603615e9.14.2026.01.15.03.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 03:29:48 -0800 (PST)
Message-ID: <bc1b8d79-2229-486b-aea2-bbd71d1fc74f@redhat.com>
Date: Thu, 15 Jan 2026 12:29:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: inline napi_skb_cache_get()
To: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20260112131515.4051589-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260112131515.4051589-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 2:15 PM, Eric Dumazet wrote:
> clang is inlining it already, gcc (14.2) does not.
> 
> Small space cost (215 bytes on x86_64) but faster sk_buff allocations.
> 
> $ scripts/bloat-o-meter -t net/core/skbuff.gcc.before.o net/core/skbuff.gcc.after.o
> add/remove: 0/1 grow/shrink: 4/1 up/down: 359/-144 (215)
> Function                                     old     new   delta
> __alloc_skb                                  471     611    +140
> napi_build_skb                               245     363    +118
> napi_alloc_skb                               331     416     +85
> skb_copy_ubufs                              1869    1885     +16
> skb_shift                                   1445    1413     -32
> napi_skb_cache_get                           112       -    -112
> Total: Before=59941, After=60156, chg +0.36%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Not blocking this patch, but I'm wondering if we should consider
defining an 'inline_for_performance' macro for both documentation
purpose and to allow no inline for size-sensitive build.

Paolo


