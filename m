Return-Path: <netdev+bounces-245699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73965CD5DB9
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC8CA30021EF
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 11:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAE132695C;
	Mon, 22 Dec 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yrq8x1e7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxO3tczf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7B32E148
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404215; cv=none; b=cHnEhGzmWx0yAqJxWkSaZ8ybWNQShLHeNhL9HvWh41KLPV82u43VTQpeumeXXauUUgtynqcGiBcjP9LkQA1hqnSc3JjNIJILPcIrgbCDhGMmOYjEbYw6irquHOrp6R4fRJEbvFbVgoGICuRADhxoGU7MUBYRGaCjbg5N5mvGI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404215; c=relaxed/simple;
	bh=1RTEL3fXSoievhmTGkDQQGrzLBDPQPQdbykQFNvZfL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtEmGKnmR5oyzFVJMOGiKxvnC6kXCkpfQ09LeLEqYvJWAfYH7g5fQe9Y3NKh/xSi4zkOZLQpzvnJvLoHot0s7s/JPb1RguASg6vtoR5thdba92T2N5v94cfc7aX4T6hmD/rgdvmQ50g5BLxAJZrc9z3UzLwlkLh8Vbj0vRSMZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yrq8x1e7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxO3tczf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766404212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMALY6ZhNYo19lnmySAg/8ulxjAE0UAGCN8jLmq8SkE=;
	b=Yrq8x1e7KqnFUmw1LPQA3CzW30GbZbVMSG87siaRrNV+CRUNIMz9prWNP/zolbDeHwhHd3
	0bItNf6Bdl4NHadH0GTxWbTHpgfhz1OfCAjMGqLbMovd4BkCgSaNls6Z31rtWt+8yxsGN5
	wPJyJpuzRZy/WibtejhhITYdIhKcGqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-VMLp84WWPUiN9dmPv5ed0A-1; Mon, 22 Dec 2025 06:50:11 -0500
X-MC-Unique: VMLp84WWPUiN9dmPv5ed0A-1
X-Mimecast-MFC-AGG-ID: VMLp84WWPUiN9dmPv5ed0A_1766404210
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42fdbba545fso2479943f8f.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 03:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766404210; x=1767009010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMALY6ZhNYo19lnmySAg/8ulxjAE0UAGCN8jLmq8SkE=;
        b=ZxO3tczfK7N6M7YMSp9CUIRjhhjDxeS0Dx6ipNMpAeSrE9sooHpDweym909b6HZgOc
         o/L0cQoZGKUHWqkx2vFWcU4qfj3K7REbgaky3QupJjf3WaD2BlEDQ3OcsDh9BqPLW7zr
         xoATS5GiZMghZKnIZMx6SVy+1/Yr0MDekOf0BZshIrSIakIQdqJkFZ4Q3xzjHUI9Bl9n
         VXDcNaNVDnarZfPD0rLoYrfxpgRWx96vf+i5hIObtI1ypBvMv92+v23nFl47neDVcHf6
         dcwyo10QYFjZG/Hhdx7fzG99zrnpY6Mao31gGJh9BL4QD4B994T+3eGl9uaXCiaAtpPX
         9h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766404210; x=1767009010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMALY6ZhNYo19lnmySAg/8ulxjAE0UAGCN8jLmq8SkE=;
        b=uVGFGDW1j9EM/H8lPt9BVExgsUsr5Y8H9JGMnCBqDTZ9I58a+MPUoZEFHDygAWTGEU
         8dkT4PJVhQI+nhLOagcZ4bth/dU6GxpdPdvdpycjL9dZhawrDCpkSkNy3lebXIQRNQfm
         Vg8yRw9u+V8ZsFZquRwVvqTv5X+qt2pATwCSdRrthHhaPMuknB23kLMQ0JZoZtKp77rB
         WdXki1GjBynUZfB3C69VcO+u9CHP7an3LT/q+1xZ2me8S56HC61+hQz+5TYtGhz2K3Qf
         KDKNCC537jkyOY3Kc7gnsyUrT0SwMNPk54/o0ECBkka95PZWApFjYymHGXMX1tQ/2/qK
         KEmA==
X-Forwarded-Encrypted: i=1; AJvYcCUlmHwK995iLGY+Sgjpcjk6pIxZiBLRfI2yEfVh+5eqhLc6S7PvX0HyAfhGoGujw5MMBnGA0Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMD1wxq8+ycdkckGRaAABrAzG3rPtRSS6hhzdqrNSlvSAJzX43
	uJqaZY75se2dZpzBzwjKvQmdUyuwnXGy7FiMA2wCE9lcYfCzlpZR41UvuMEPFD5/71l3PFbIwSZ
	MpWdFYk/Lax8iMo6JiBtm2HyA2yOnnt0lA/MviZACfrX30IDMY/wqmUDsHA==
X-Gm-Gg: AY/fxX4082GsJhwSGwNLAsLkHMQ0ZNtdB+6L3PuUwSkBpEAfQMUfEApc7sOp13DBORA
	DrwKtszLwux3RkEQHATFUKmTT4EXobBcpw6Ag4czmLLvhcmt+3fjAP28srtN4Xq9p7zR/qkZQke
	xcg/QilnUAmwAzK1t881AlKo/pfZJE9lEhjFTemA88QuPzLgrpdPfd7g3m5AQ7gf0Ib4UaIZxTe
	Dhb23AW+jTYXepAq/W/9259J46ECXRQWvpnz/BvJJKuzmZj7NHuGo6dSNCd7i2Z7oR/pjL0Meth
	M9ngyPdKfMmGyeigcI6sIFcBkhjpfD5DaucfjNey7ETJx/KAGgQC0p6KRciBBONNUr6r5pR5ZKy
	bPW5uajhvkACd
X-Received: by 2002:a05:6000:1247:b0:432:5a4e:c023 with SMTP id ffacd0b85a97d-4325a4ec1bcmr5163310f8f.13.1766404210254;
        Mon, 22 Dec 2025 03:50:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTPl62p13XAIbi9lZDvIY4z09abGkkrGMCB9WGUgY0R3j7kKyjCubla1YJ/bQnHOVKp5mhKw==
X-Received: by 2002:a05:6000:1247:b0:432:5a4e:c023 with SMTP id ffacd0b85a97d-4325a4ec1bcmr5163279f8f.13.1766404209864;
        Mon, 22 Dec 2025 03:50:09 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea226d1sm22136327f8f.13.2025.12.22.03.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:50:09 -0800 (PST)
Message-ID: <190f75e8-fabc-4c39-90e9-eb733c64d3c2@redhat.com>
Date: Mon, 22 Dec 2025 12:50:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net: dsa: microchip: make read-only array ts_reg
 static const
To: Colin Ian King <colin.i.king@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251219213334.492228-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251219213334.492228-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 10:33 PM, Colin Ian King wrote:
> Don't populate the read-only array ts_reg on the stack at run time,
> instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


