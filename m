Return-Path: <netdev+bounces-197471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2239CAD8B9E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042D516605E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD1023E338;
	Fri, 13 Jun 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RvMTR4n1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F422688C
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816463; cv=none; b=qC1gsKw5PQAtPizH9hYYjeAOyFpYuxck4XLh31MzdHAFmm+eMv1mEch7DbuqAK6AuDok4o3Hw3tzdXBa1dqSuNlwijXj9Xv6qmgYQrDoeZI+Gc8W24iqNTT4LM+QOAsXnQpulTt7/f5bzPDuKLrVYDu4v1NA0+CTq6ztOy2NZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816463; c=relaxed/simple;
	bh=dw+/2d23CWYaflUCx8yRKTMFvgtfvTK0Uw26ZiXjycM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR3IYPxKCVzva4KRAzg/DZ9sQcbUrGcYASVjYA5iOfdbdl5B20yDo+yE/xejJ+MdNOXFbxQxmHK7gJOgkz/H3WM/VBi0nUxuePpj1bKQiYPO2A4VRXpZDTyqju2mNHMlnM01mhjNjYvovV4McecYeJCmIBb8JnsxUGSjDI45USM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RvMTR4n1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1310669f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749816459; x=1750421259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acAtLseFdOzXV3/vSQyIZE2n086nZk8lcarjj4fTGN8=;
        b=RvMTR4n1UrjRqNKwmHuENPKn3T8acwu52R5cI/RHsYQtkRaLUgVl+P87T1VUcVOjKR
         gcVXVzHJoSsJSItZmZ9sT21h2goqykeHpxvo06Ze5NoZa6O84wCx//IGw0c0imGWWaqU
         7MJWfDQsDEHj40yAFsi0rTowJeYKcDHeyTfq+ZN000xjXCP1EJ29XYuFFg4lK6TFdzmm
         gsW03rzUREo+ISUB1IgX4j2B5krOwn+rj389KJ7Ystg0cxZ02vEii+3tkmeWQTPE6gcd
         IfpZqhdjg5oDp66R8na1Nu9D3ZZd9XwYW/Omqh+gyxuJZupufcOZZWO98fAEjYH7k6cA
         BnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749816459; x=1750421259;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acAtLseFdOzXV3/vSQyIZE2n086nZk8lcarjj4fTGN8=;
        b=CW7C6Mok0kT3qhoMyj7HHIjhiagii6DR86WZvOWH+1Z2PiUjE1fKlDrdBa4rP1x6qM
         /JrQBFRph7264Ia1DsaFWl78rFoSP+D5ve/P6oFCSE0D5Ff3PYV1UX37oEgcsJ5ZdGlu
         OZPGgiv+WT455eWaFI4XkogIkdkcS54FMHe+86jY65nY87WvE5R6xhXNKyN2GRosft+K
         gR9r0PI4EX6AUAR384nosRmIC8kVMQtopEmmbAFcot21E+gxLsfxrm6LQ77HDE624z0t
         FVBHSenIDr5nkEyuGhWJKJo5mVlLBIoE6gqyIjAEd0SNfv7A0k0oZczHzBLsu453c3lR
         xBwA==
X-Forwarded-Encrypted: i=1; AJvYcCXxRyAZy7TbAG74Q/rMEO7ubtS7XgxW42sSzaUTEZhl/aquxIgP73MTzS3CON7KtlM9MvUWbLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyclGr2OESKSAlFV0ULGPHt5YM1qy8vthaPOBmS073OIUyrxSWv
	gF+/N8jkiYCAUT22rryfGERhCki7+wr/amqpoCK0cVZAX/gfM6Eo8FOkJfm24WUG6KU=
X-Gm-Gg: ASbGnct4yXTpT2xZM/iY6jXbG98Sa9Mx+BeB0N5vaIrwXqHXyJddWcntkS4MrycRLuh
	T5hZlSLWZIAVHx1ZavIgdJxtd9mCOc1v33sJVb6WKgK0MYkbdUYRG27owAJ0Q4y++nYdfnY2KjD
	BAPF0aF1lFHYat69KbEq7xnFFFVGtDQd0SiE4nxj+NMmx+XSvA0o0mNqkHthT9QseDVibW5B78r
	OfxjlBQOgdHPTr+hK03jfKJ3Nkqzeyv22wPLVs/e6f8IDv5q9UAzTSMuY1uyzAFZtvq6wjcTdPC
	BPpZSmw+cuPN3UDzIeyhxDsUwzeBDRaifJLe58XNC4YVTCGLhdvSoao0JZJ4bAXpTMxBJ3Hl
X-Google-Smtp-Source: AGHT+IFwnfrbQNhYn+RKjvnvWq1fAt1wi2tjoULYiVKtV8KdDn2x97sSGXlAbKnPKoBdZNwQjgkRXA==
X-Received: by 2002:a05:6000:1ace:b0:3a4:f723:3e73 with SMTP id ffacd0b85a97d-3a5686709d3mr2590339f8f.16.1749816459324;
        Fri, 13 Jun 2025 05:07:39 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea15b0sm51167755e9.11.2025.06.13.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:07:38 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:07:35 +0300
From: Joe Damato <joe@dama.to>
To: Yuesong Li <liyuesong@vivo.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v1] net: amt: convert to use secs_to_jiffies
Message-ID: <aEwUh3A3gvj64v0a@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>, Yuesong Li <liyuesong@vivo.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
References: <20250613102014.3070898-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613102014.3070898-1-liyuesong@vivo.com>

On Fri, Jun 13, 2025 at 06:20:12PM +0800, Yuesong Li wrote:
> Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
> use it to avoid scaling the time to msec.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>  drivers/net/amt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 734a0b3242a9..fb130fde68c0 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -979,7 +979,7 @@ static void amt_event_send_request(struct amt_dev *amt)
>  	amt->req_cnt++;
>  out:
>  	exp = min_t(u32, (1 * (1 << amt->req_cnt)), AMT_MAX_REQ_TIMEOUT);
> -	mod_delayed_work(amt_wq, &amt->req_wq, msecs_to_jiffies(exp * 1000));
> +	mod_delayed_work(amt_wq, &amt->req_wq, secs_to_jiffies(exp));
>  }
>  
>  static void amt_req_work(struct work_struct *work)

Seems fine, but minor nit on the commit message -- when referring to commit
you should include the one-liner as per the documentation [1].

For example, maybe something like:

  Since commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()"), ...

Otherwise:

Reviewed-by: Joe Damato <joe@dama.to>

[1]: https://www.kernel.org/doc/html/v6.15/process/submitting-patches.html

