Return-Path: <netdev+bounces-219588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5FB421B1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DB57BB662
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC29301031;
	Wed,  3 Sep 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1LcaJFB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F04302776;
	Wed,  3 Sep 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906134; cv=none; b=WngF8Dc4Q/kRCEg6d4knRNe1g6sPy50oPay/tYalp5lamcu5ekYwIL0xxOT3vG2EdJemPziBng3NV9TArySXDkuQbFKPY/d0llVDg6XXYMd7x7X+BhFFEQfDV8OZL9s135cE3ildKFQKtgyzxAs6wniEra+tRth0ChXJWndwLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906134; c=relaxed/simple;
	bh=hsABvs17BadY5osyuv6Ozk7YDzMdfHke4VNm2Ky2Fzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSKG5uK8YsnA6vYexg8zcNjO2rMXVx5C1ShfTgb3hwiAvCjr/FdUkBZ2xy0fvQAwK3ZsJoB3xXz7y5d758L/bhxGk4HHmaB4vRih6Ji0RKVvu7gdS7rRIk1O2tlFeie3AZP7t+S2vIzLP7G4YlxLLhYZ+ry72saBfcVSeUK6+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1LcaJFB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b844f1b18so2116965e9.1;
        Wed, 03 Sep 2025 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756906131; x=1757510931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ip7GEHTLGREs3wFJiE55XHO29SvS6xXq6xvgtwM1hmk=;
        b=U1LcaJFBIl9DYc3Da6+Qdsa6u9UuELK/FrhMWzGd7P9oF1RQJ6H1Z/qfheYrlTVSC5
         /csr2DSMrOE5oXQqBNZsakGgCtoSeO/1/ZG4UVXLesozlp2TKufgxCrn/H4TMGYxE+MH
         yp8fGN46vJM+rqFFTeHO+ZkZbAuzygOIVlwsHpDs0nwM5Z4Xmj5+B1I30X6+aKjKO+sa
         k/P6m1ffNDzULUteTui6vUgiCfTfh2GSZuZyJOJwSfD6ZFFjafYatQBX9yFkqK5Utba3
         h8L+kMNXUlZlZ15W2uH29QV9PNmbw/JCVjLYrTD4unugwmmq6BnUmul3eT6y4oJ27uMM
         zzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906131; x=1757510931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip7GEHTLGREs3wFJiE55XHO29SvS6xXq6xvgtwM1hmk=;
        b=QCquI9PgiHGAFoPDwqUozxpB+tt5O4lsOsljeiLczN5Vr0NvcHKjxTGCSp/LShPBkG
         uSf/3sWOLGXjvPqlndy4LsJbDsQJKQNeWOi4wbr5ShiYYNsCBic5J1HphVub/2awBZE/
         vg7rJZViaFdVfIsp+upu3LKz8WK/RumZOAPOpWFe8a7nDDlfxOrldvyh3YsKwu3bhm1O
         PlZFe5zjFwJiFLHgxM2F0JuMGBcwlfyfGBe8dBc5fVFC9SAB4yj9RWu5VOeZWzZEoleX
         aAZGdQkgJ98mpSaX01eNjCWvqR+ivS0eT/h4+D0RNmfLJwXY7gc8CvKwIyWBazpyPF0K
         L8TA==
X-Forwarded-Encrypted: i=1; AJvYcCV0NhsTUeAq9uLwpZGXPmcKDpjoKCTtA919bSxPYEKHaWbAo77recRyU/KzpYCl3xYFWyofW1nZ@vger.kernel.org, AJvYcCWw+Qv7oITd2d7sePiCXuReLaa8E1xtsRGbVgEZAZceMgU3rudLcumctjelZxRNQgi4RNQJ0tpoH8mutmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPAC/08Ll4ISrY2enacRbhN+sMKpr4sc6trB0PrjXX01eWRLM
	OocfS1s5n9XLftGyt2CJA/MpOw8HSAYCfFOwVTrDaIV6VebA41CoFef6q5bORbU5
X-Gm-Gg: ASbGncvtUCrrzREiCVPETO3kzltztFK5Y+Q8F7pal0AXMC4/VdCNwoW9HtMzc66MWxj
	fQuqP+X0n3OX5QEjyM2FxmSLTLzV9JtMbVGjBB31Y9Vkjw3JwNdB1o+BPDc2HE1MSjHCFLh165m
	B/z22wxcnjNAY10i9dEzPCpy/zoyOYFUwpmKVV6fcbze/sZQcjDH2JVymhDJ7+iQFa0khjfV1HV
	CJRBftHs+PIT0KozZqprKm4B3OmrlPo5lH0I/FrnWRAPDucTHP3lVe8d2rlqEMSWKtN7bUV6Se2
	axCwWvpfiLK+muprF3Jmd29fIZg1wo7S3a4Z6KET1SWrUYA+8HPO6U30X7GJmXcFZ/AgaYWTIgp
	IukJYT/OkiJ52IhQnD7K0A8ZEiA==
X-Google-Smtp-Source: AGHT+IFeJ6G/GbGn+sWTQsbcWZbTftScTGIoGy1BjSSWZN3VsmKFELydGycedx9xP/3uz2B9wV8LrQ==
X-Received: by 2002:a05:600c:6385:b0:459:ddd6:1cbf with SMTP id 5b1f17b1804b1-45b81e2235amr68213045e9.0.1756906131066;
        Wed, 03 Sep 2025 06:28:51 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:e6e0:f5a6:e762:89fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb6e44373sm7552185e9.3.2025.09.03.06.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 06:28:49 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:28:46 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: dsa_loop: use int type to store negative error
 codes
Message-ID: <20250903132846.h4eeqi5faqkghrzv@skbuf>
References: <20250903123404.395946-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903123404.395946-1-rongqianfeng@vivo.com>

On Wed, Sep 03, 2025 at 08:34:03PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable in dsa_loop_init() from unsigned int to int, as
> it needs to store either negative error codes or zero returned by
> mdio_driver_register().
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing.  Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

