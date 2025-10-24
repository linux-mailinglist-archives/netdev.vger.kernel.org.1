Return-Path: <netdev+bounces-232523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF8C06376
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB3A04E4C56
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B631328D;
	Fri, 24 Oct 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzJfhn+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66ED2D94A8
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308483; cv=none; b=MbvEpUUE1D4UdAL8KiZikC5DqwjZlgb2fesC/kZI9tRY5mVYeHHSNZIKsei8DinwlyFEBqlyf4Tet95TJ/MYT7EawA6YqWHFDXWeCnxH+z5xfcdXZvIcYM2lGFOkgam5yfKMvnygMYInImkjU3vuWs+CZZz2WE6Rqynl8tCq0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308483; c=relaxed/simple;
	bh=pRY+BeQgTC3sgFy7x6scZvVx6olKk1HglYkeda9tiVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSjOShvtcskjlsiBY2jnxzFVMVqEl1egwAfS9CVxV/TI+OnmrN+8m/ok+3kEB48VbEaKlOwq+oguwm78TwrQxa1O0UQG4NsY6Ixr7rcgHTBAoKUGp0Ujc8XnKFkRUY1ow3ixpT8fno0EF0P3NkrWos0SabFFew0ggve12ks2zLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzJfhn+A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so16264855e9.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761308480; x=1761913280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASZh8fudbVWKppfwk7tVsYkXKkMV1873aR5CHOC9ccA=;
        b=TzJfhn+A5+SZQ7k0fRJ1ALwGHZdAYeIku4Mh5MRt+ywtgRa6Rjeq9Nt79bVe1aRlmp
         0/gR9BajZePC7TLwQBOLVDJNWj6TmCgHfXw2n6JtzdnR5g5vd/bQcf3WkrRQrvl52QOO
         TfS/YycznqNX5uZKnkfp6nprzF6tlbG4QVtQ9irbiJIUHDEicL7sKbDEheShNjz9XAdq
         Ub74eRq7zTGe6lR2ee6Wa0t/UlgcFgBtb4DfTurRMGigQJMHIPttkj1hs5x82B7OQS9v
         lVBWUlvgTYJGPD5y+ztsQqroPzY3h+oxmxNGDF062RbTneDhE0d0ENC2YByx05f7d52e
         aWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761308480; x=1761913280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASZh8fudbVWKppfwk7tVsYkXKkMV1873aR5CHOC9ccA=;
        b=V7Nd1w6GbLa7tH5KN14Q/k5YdOwQ0eUF9+q4AwhkCIKkpPBxQKPO3ibZeq/Tqp3pUZ
         09VDEdEvm+YD8lFopUQ1E8CuSNB3T87+rYIIdSPIz/HB/QN0jrOA03YiI7RuDCSXM+G1
         zE7iPc1tu44ZFjuOEAvigKNw/4nT1N5XIxPk8ogPdee958H5X0yRts+lS5nxuFjU9cEz
         QTEhli0ctowZy1pAy8m9zrHIduFH2PEgY4HVj97Ay2RmjLrjcDEOx9cWDPqYoLjPXg2J
         3HzrT7mmStFbR+ylISGIbafIOwTr0EjGrhCAMjSM7ph5lsDpbn9pZP9x//ab7Zl1tbce
         2ItQ==
X-Gm-Message-State: AOJu0YwYPmlIFVELB1JJFiMHRfUfqs111wd6gPDNSMM0dN6eegcpWGOD
	8cpdTu+kuGiOmak4jKhjPAUDpAaF8UBgj6Ejzv45E/ujhtZ/8TudG0Ac
X-Gm-Gg: ASbGncuxzYYkt6fNLipJ1NpaxkGwAHz8dWxujFORTN19JvHFMi4rBQKb5tO8mp7SSSU
	gXEhuwNLh4vLDGAoANHP+oWQgrrqGhUuRFsJqNpYQv7kuOE8FIJNUnDjr/yLV82rpB5lhdzvo2Q
	clxwRTBtYuD3JHCjgLG+8NL/mcEln+r/CnXTnYPcrg/pDT3MxAyumRcbgIfshOozpSHLHBHhgJC
	291yA9LPopCQagccr0f44uucygFo/zEIvscjZIi6YgfA8GViczI7GCoswOTzOdS8tZyfI7jGC2k
	eC4hmZmgeEb1QwDUyxWVUkbUpEbRipW6aGipRxZCIVWLZQOzZgyS/iyHrBw8/tGDiwKFuN/Gy7k
	6nsvrT/S/HySum64TvmWxjUez9XTom1F1OrBMxQ99/HqpWYaFS/nge5+C5FnVpQbJulpMnxzHNk
	DLkIZ2EnmCEGB95n7wJAG2j1Yv4jkE3kOKYtnogH0ia8j1SMe3LoNY
X-Google-Smtp-Source: AGHT+IEbd+4q1oEaYkyVSizSec1ZLMt841VYzmkYm30kaim6aqt9zqjJycOchwQVXvxwo+rJdS246Q==
X-Received: by 2002:a05:600c:470c:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-475d30d21c8mr17720145e9.41.1761308479761;
        Fri, 24 Oct 2025 05:21:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm87470645e9.1.2025.10.24.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:21:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:21:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: yt921x: Fix missing type casting to
 u64
Message-ID: <20251024132117.43f39504@pumpkin>
In-Reply-To: <20251024084918.1353031-1-mmyangfl@gmail.com>
References: <20251024084918.1353031-1-mmyangfl@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 16:49:13 +0800
David Yang <mmyangfl@gmail.com> wrote:

> Reported by the following Smatch static checker warning:
> 
>   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
>   warn: was expecting a 64 bit value instead of '(~0)'
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index ab762ffc4661..8baed8107512 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -699,7 +699,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			if (val < (u32)val)

That check is wrong as well, probably (val0 < (u32)val) is right.
But the code is confusing.

>  				/* overflow */
>  				val += (u64)U32_MAX + 1;
> -			val &= ~U32_MAX;
> +			val &= ~(u64)U32_MAX;
>  			val |= val0;

How about:
		if (desc->size <= 1) {
			u64 old_val = *valp;
			val = upper32_bits(old_val) | val0;
			if (val < old_val)
				val += 1ull << 32;
		}

There is also an inconsistency with the read of *valp and the
WRITE_ONCE() lower down.
If there is a READ_ONCE() elsewhere then it not going to work on
32bit architectures - since both the read and write are still
likely to be two memory cycles.

	David

>  		} else {
>  			res = yt921x_reg_read(priv, reg + 4, &val1);


