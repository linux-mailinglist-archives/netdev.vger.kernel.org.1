Return-Path: <netdev+bounces-250534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E84C5D32072
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7D0A300911A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882B2580CF;
	Fri, 16 Jan 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo2MnJMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D826ACC
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571032; cv=none; b=UtpNhZJ8tMuYObN8gqK8EDhcFeN8qbdEjxOW89BMNnWkktGJL6rPMHfvYdvQxj799dLYYHYT+uCSQQDuWCWPmkoTd1HliJLiRaEhOXem9GDw0QAR0JnKYqpzyfCWXIPB6fGLI0Pyz74d2B0KbMNXZczzyX3FVrnqu5BlU8k6pN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571032; c=relaxed/simple;
	bh=eUc0lUQw8/akWNsjNFabydRj/NiPMWntxKpCu0Tg0Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RN9A9+YMeea0yF9VIMBENnTdnX0dtO08fQh5xgXw43Qukv+5zqdYfdb7L/iJt+A//IA11NHrCPdv80TUBLa3GN94aKkSPT+h9hxYS1K/i5oJzVjPUlonwzcgPAOoanicR2JjzvhPyBoH6VyTpZrY3u2vwmYz11dLtfyIr6mm5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo2MnJMR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso267066366b.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768571029; x=1769175829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUc0lUQw8/akWNsjNFabydRj/NiPMWntxKpCu0Tg0Ts=;
        b=Mo2MnJMRTPYx8BGhIrphNtrxJEBH7r+fgtiSg+wQ8hiln+4llnyow7OUwU4psycOTo
         f1LGiQtvBNj1ykiy/xuJUOAHp3SXXUzBvJ8F3+pdO6mp8kskEUU/rmmKjggyXCVQyoXp
         WMVZgNOHicgmH02o/chVh1cfjUVoHAwDyI9DzQGM3f/sjYJMVBqL+QxAN8eUPuHI66Ca
         SwuPZlvQ7m7Tx7qTHwd1JY9RfRKyicYJgV/b+ZTxOc8npFypY+nvEh8gOA0wqm5b2U8D
         Yr7VpM3noA2ndgbZxIUCIS3brmQ1rgF6rEvI27lr2nz8mKqNxWzCxcbTibZ1effX5WF/
         FCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571029; x=1769175829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUc0lUQw8/akWNsjNFabydRj/NiPMWntxKpCu0Tg0Ts=;
        b=gi55RKzLfHvXy1TMThoARL340no0JgaP0FRjJQJyGG8uIVc5G5j8KWnKay8Fq8fD0O
         qWodfk+1+Inv0EBZdn+D7QY5h3kCiwG9cIJxHlm5noYcEjK3M/DqveI7lfOUC/P5LBTR
         mdciFybjZacSW+S1GSRBuULbB/IdEKEdVDueifGYUewUUfB7JRk4RkvdD1QmJmbE2LV7
         ozvCI04liRyiNGcbkGk5ZLMf47tuYLMURoccbGPZVKgOPNqK9CwEOUOGkJAktTKXCB8i
         blfmD19zb9R40bzkKCtrxvYlW+DG8CzKBTKeI69kBnqGQtT4Ezjn9cV5EQIHW3fIz9rN
         8tNA==
X-Gm-Message-State: AOJu0YxlVld1n4mBffaOXW6IzkmyGpecBl20Gv677TrRhZPceRAYR20f
	h5/LW2PQixG0NZXfZ2B05fclyvXx9K54JE0xwjX5qwKVkOsqUyvVELZ5
X-Gm-Gg: AY/fxX5657y9fbdq75WDqtjDjJA+WyPzA8CAhijX8UoGSTP04P5C8EnOyfik9eXuZ+b
	7kPdZDFV1+UPc/bphYZtLJ6nh4CtOclMiCkcfLAcpqYAJGznUu4AL0aqLhuf4YCOEWwpdfM0zRo
	avvr6EtxskpzZ1yvOOZ/eM5cEXIM+mIJ3f/I1VXAc8BS7pXu8PGoez7+spkIf4HRDrB9f9KsAJR
	PQBipHRnZ/N6yoyzEAznzxMkHP0CsaQhHpDroeNPr6YItd8A1EQBsPwOeQZWzlHX6K3vpIk2No6
	3KI1s32TDy/Rh0UP2Ip7K48S3h0i03Cd3e4lOs66tTeh610cJpFg6NJZLhL+7KVoqB2pbrMYapH
	dNNVrgAYEqW6GdPvo84FUmTrUy0XDUfWBSADA7is9RvcRV/PeLR34gMjr2q/XjpEOssIoFuJ9gr
	mG7mnhbp0ntiG4/W0ghdJrt+uLBDoiRAXMbdQnTg2dvteLsKbA/M78/vhgd2j7nyJTVsP77liJr
	bKHYjXH
X-Received: by 2002:a17:907:3f21:b0:b87:25a7:3ea0 with SMTP id a640c23a62f3a-b87968f6e82mr223247166b.25.1768571028829;
        Fri, 16 Jan 2026 05:43:48 -0800 (PST)
Received: from ?IPV6:2001:9e8:f13f:1001:fd79:63dc:69b7:40d3? ([2001:9e8:f13f:1001:fd79:63dc:69b7:40d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9bc9sm230975466b.33.2026.01.16.05.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 05:43:48 -0800 (PST)
Message-ID: <6987689b-35ac-4c15-addb-1c8e54144fa7@gmail.com>
Date: Fri, 16 Jan 2026 14:43:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: sfp: extend SMBus support
Content-Language: en-US
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260116113105.244592-1-jelonek.jonas@gmail.com>
 <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <6a87648c-a1e8-49a2-a201-91108669ab44@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 16.01.26 14:23, Maxime Chevallier wrote:
> I think Russell pointed it out, but I was also wondering the same.
> How do we deal with controllers that cannot do neither block nor
> single-byte, i.e. that can only do word access ?
>
> We can't do transfers that have an odd length. And there are some,
> see sfp_cotsworks_fixup_check() for example.
>
> Maybe these smbus controller don't even exist, but I think we should
> anyway have some log saying that this doesn't work, either at SFP
> access time, or at init time.

I tried to guard that in the sfp_i2c_configure() right now. The whole path
to allow SMBus transfers is only allowed if there's at least byte access. For
exactly the reason that we need byte access in case of odd lengths. Then,
it can upgrade to word or block access if available. Or did I miss anything in
the conditions?

This of course rules out any controllers which just can do word access.
I guess covering this case increases the complexity. But I'd be fine having a
log or something similar handling this condition.

Kind regards,
Jonas

