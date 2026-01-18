Return-Path: <netdev+bounces-250884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4243AD3970A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A6FC303C9E8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C4E337B8B;
	Sun, 18 Jan 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AU1u6WOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04324335070
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744995; cv=none; b=CPsYiwhH3sY6yVRMFNMum/54rd0rg/gwUq54+UDpbi+MRdH+WYDq7S0yOMyRmQ6hl3yEkbc5fMYZ9R619XoQZEvf74M25RWHOFFeab9UNZcQr28gL5dBET+MaU6IgXXpi6WVQZSrXefmval/I9pqmAC7hqG7FabsbGxumbT/ZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744995; c=relaxed/simple;
	bh=/GsF+Uwls1Cn2yinM71Z8W+ioXcZeW9vpkl4szRkNjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFqA0IddFy5+EaOp7LWKZFze7N4nscVTFMjYiqqWE2Y+rAw1xpd8LtSbNK7ffZ7vT2S+WJnw0zMXMztWIyO9at319DpQWCRBvBnq6LfYKsF+ZF3PeQXYqbCD6j0AHt2ZWHiUjWF7Un15qTOYRcBc32iW2kX7GwW4f2MhlqQPUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AU1u6WOt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso16213715e9.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768744991; x=1769349791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMK1YqKVaUf0IoyRsQOMCKJ4gS01F7A0JEX5JckEMXs=;
        b=AU1u6WOtLoi8xhtxE3eZH2de7tMEOJBbWbxjQ3yhiZkjPT2U+TxzYsQSeFKocZiPFp
         AfUR8WeygLNHXiE9Viiw1RtzFAsj1KyVxaWitGd2d8N3ANyj+Y7kO43+hm5JZhbBq+Lb
         lPvGKm4ZddOA32TKUnbLjuE3F06FWBpu3jNeWG8PxL6W7eEJcdrnLaI8SrtPWsd/V4W6
         +EAvlq2BKqQ/VvftFp9V9f78dx1EN5wahowO2gdSHzutwK6Z8mTGZRreowFvAg6oCWZ7
         I8ZU60NADPdABqce0/chNtZRxbKpG3J3sqT37gvVSYI6RT6C+EjRstJOaUfYQFkChaEz
         m0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768744991; x=1769349791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMK1YqKVaUf0IoyRsQOMCKJ4gS01F7A0JEX5JckEMXs=;
        b=u3YQ9fKN+1FFtstw8qUxzGObDhvoAUft/A14RzJ0y22RIhIRb9tn5qAECXgtic6NUL
         Rve46W0EAshSIMIGHaUgKz+gaVMW9tHS/Rc9HwCc9yJp7/JzXRlhdqye+e4r9orNLk3J
         qdxzV9vleA8aSCEBvXXNEM3aujZaJj5DsCnFUVReZVE+pUJVb2fxDkXR5AFPZfw0vijU
         ynT4j8n4FwpGrX+aCDMAwFV3dHTX1EBtKD2xx1BJ7sT9aYAGwClNQfGy0GAHSt8XP84K
         nfRwq4JnbljRKozoSFw0ghZ9SNQEVB+2C5uSjWi56AcugOUlKtlLNZARjDzYoQao4FIe
         WHTg==
X-Forwarded-Encrypted: i=1; AJvYcCVuaKgyLZVKQlXMGOysrEJzHBug23FEYwEGs9ODJ8GwrrBWIVYOwpuBcneUER5H17cJKZF1oos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oaIILw1//nvcKEI1VdytFr4+8oPR9bnjxgBhlJ0m+FdUyDHM
	chnsP3PBKnunJzqZq4lrg0c/vHTV1hb9uXKv3Ue0TZBERslHLmsgCObKZdYYydzUQBY=
X-Gm-Gg: AY/fxX6MFKXQhf7CCdSjgGRMJROhKdLD0OmkqE3CmlzvN3laXBOgD98OxECo4lMQP7o
	z+nBu6eJJacGSk29UwZyo4PGVrX5nxLCfzZn921jT9fYPlPwY7HftWDmafQvGWAColvquqLqNBF
	NkO5D0ykf2g9rsF6cFmgIB5frpfIuj1wUd/82Dj73XzhT3ei2nKsnSX6+TwYLNeIbwoO/cBu4FT
	sutmcOXa/e8WoA5ERPRR20jlkgiSK9gFtIBreD6pTeYS7HjakOBooFzmUSzSoxUhg2EHD1s0Zxz
	/J+xF3MTG106KrG9tRR0dz27NrcXYcCettZ57ODeDyCUCd3kqazlOnYr5IaaNR7JJ7nrblB1izp
	KK4mTcOA9SO6F0Y7BeZW8er1Y/VgA2B9hwsd4stqHQ8V1f7/EMvrXvb10SkBxOHmzmsSZNH6r32
	9748ulcq3wWs4Yfho9/Q==
X-Received: by 2002:a05:600c:4da3:b0:47d:7004:f488 with SMTP id 5b1f17b1804b1-47f428f5e9amr84049025e9.10.1768744990847;
        Sun, 18 Jan 2026 06:03:10 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921df9sm17725892f8f.3.2026.01.18.06.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 06:03:10 -0800 (PST)
Message-ID: <9c34b805-8c6f-4711-9718-6c39a141d451@tuxon.dev>
Date: Sun, 18 Jan 2026 16:03:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: microchip: add EV23X71A board
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, lee@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, linusw@kernel.org, olivia@selenic.com,
 richard.genoud@bootlin.com, radu_nicolae.pirea@upb.ro,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, Ryan.Wanner@microchip.com,
 tudor.ambarus@linaro.org, kavyasree.kotagiri@microchip.com,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-12-robert.marko@sartura.hr>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260115114021.111324-12-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/26 13:37, Robert Marko wrote:
> Microchip EV23X71A is an LAN9696 based evaluation board.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

