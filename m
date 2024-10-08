Return-Path: <netdev+bounces-133172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB319995331
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BF1F267E5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE271E0B9D;
	Tue,  8 Oct 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQoD+oYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913311E04B9;
	Tue,  8 Oct 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400738; cv=none; b=SmwDyZedXKesFK4+COpSyoNzhO5Wj+V8HxVKpZnrXpmcUQbvxK5lj1mRyKo7+6V1gP+45HMAGFBOTjMXVrNNiu+XwLyk41tgYByHfPYT5jLmCGaXNj5VZiWyvjpk5nIg85ej6F+HoW+bI1cthS//3IHD4gYo5cL9ZWwif0GwwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400738; c=relaxed/simple;
	bh=pkn33NJ4MgkzYTgxtGLmkSxCtcGyKeDqZQWJttEly5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH9KPR7LDarn1ZHv4gEhPOhPW+5ZFOoTyilmm9fwO7EuOPspKCLToU4yiS0K2Nco7tRFNTHjgFwiq8hZIhou+6ebEy2k+hNtf/6NwM6P2DH85Dr9hKgQY4Op0LLkw1tJ+NyRuJrD3dIq6uvOgbf7lq/L46LpHIHolHV6WdLvP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQoD+oYJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7163489149eso5057463a12.1;
        Tue, 08 Oct 2024 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728400737; x=1729005537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkn33NJ4MgkzYTgxtGLmkSxCtcGyKeDqZQWJttEly5w=;
        b=dQoD+oYJK7ta/PeEs6SqCgkjjuUwG5zhGwS8UlQiuzVIOsN0UlKvARHeVBCOWC736T
         uqmjw58xhK/Infl6K721Lw3DmWAfwSvIcay+lfjaLOAPUFXuWCSq68dMpVz8ufrp9uUV
         IcmsdYhgNcH4dksPOYVQDDs/x/Ycx8bKTS3hGzAFTi2eaVQbK5TLAurwjcgwZ33TWFxz
         FVeyoa6wSBDo7bSPlqn9XGQadHdH4A2HRUzPZFYlV1RIyc082F1N1BqDVQGh4cjeb8C5
         0GBnae+PPi0YYX9vUahxxg8PSr9/9PwNPKWizjbZezG8rOiQ8hvwc8GGHDFcK3lLXHzi
         kGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400737; x=1729005537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkn33NJ4MgkzYTgxtGLmkSxCtcGyKeDqZQWJttEly5w=;
        b=bRBauc49W1gL4+e5ZgBKZAwi6wyPJTiVDwwqWkw+Gfu52tOJRutr7svUUyz9KZyOQp
         v0w9jU7e+viF+GuDwum0Vo+vAQvKZLrsiTCll+0QHDLXbg1eoDIGx207DFQ2rG09QH1R
         psR5zxvloLLo1i9sVPXXS5XP1Mp566xQ+ukUYRe1W6zoRiCQ6fUi7QUZDYewk6/5kxvV
         4CjcNnjuT0GrGvwwTaVLjwNsLbaJCOi53rosPWtan0glIVVM27FYZdF5tI/G7fFa6qNs
         +m+vnkOWygNdlIXzVJ9nKfX0HOSjF93mIWkfdgefid0QEFw+11vDKzG6b+62JwRoVyor
         xcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWJvahEPmGmPHYHtnh+gV1ZB7HRvkdkR9XBc6aZVtjsEAt2+HYJo/WS8iOuHiNSlM+OlInQEhL@vger.kernel.org, AJvYcCW1Q6FAdjdQ+bXrqzDrsFrlUefNrdQRfD8uHVMpho757yhYVyay2Dbe4PqOcu0DRV58CoknEhgvCqn4YL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoQB21ZZMKygpTQwb/spVgGtU92h3f5uoe1ulsk1meE0M+b+O
	h4RRifZ7QkzM43JQ+jJy7SJ+2+5y0jfUsucha+RaF9uNMYfB74dB
X-Google-Smtp-Source: AGHT+IGTW09Re3H/1XJwZkWTAvXGs8s8r+6whRLY8mrQOdPVdLlq9A8z9bvGR17kmGRSHCLSBZSFXw==
X-Received: by 2002:a05:6a21:3941:b0:1cf:21c7:2aff with SMTP id adf61e73a8af0-1d6dfa406a1mr29995008637.23.1728400736630;
        Tue, 08 Oct 2024 08:18:56 -0700 (PDT)
Received: from hoboy.vegasvil.org ([198.59.164.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e104edb29sm1722784b3a.220.2024.10.08.08.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:18:55 -0700 (PDT)
Date: Tue, 8 Oct 2024 08:18:53 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de,
	John Stultz <jstultz@google.com>, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] posix-clock: Fix missing timespec64 check for PTP
 clock
Message-ID: <ZwVNXZ93Tl6DykBC@hoboy.vegasvil.org>
References: <20241008091101.713898-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008091101.713898-1-ruanjinjie@huawei.com>

On Tue, Oct 08, 2024 at 05:10:59PM +0800, Jinjie Ruan wrote:
> Check timespec64 in pc_clock_settime() for PTP clock as
> the man manual of clock_settime() said.

Adding John Stultz's correct email address onto CC.

Thanks,
Richard

