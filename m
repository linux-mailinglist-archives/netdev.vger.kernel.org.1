Return-Path: <netdev+bounces-212664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F1B21988
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE7B8463078
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0302263C8E;
	Mon, 11 Aug 2025 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RggXwxys"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC2256C71
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956257; cv=none; b=qqMbtkAnx0f0M1zHkNB6dkuxoQqK86Jb/Cq0JvNL+dEXKx4jKgOpwSQTP9NSEB5nua6+Mgz6JeF1bokjIPjp1UrZNLifUgyjz2KsRMdJyGr33hfKlktafZLfmAOQbZOSNJM8JAv/j5VPNRxZNa5zBFARnpFQV+TMZUe5V8DdqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956257; c=relaxed/simple;
	bh=nyObxS/2Bub4mAdPZqrA0gIV7yIxbeYsYdIS5GnfdJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRuH3aeUdi253tDrW4GRvvP7fR+IR2WFOpCXMrwBJ2BD2tOcTzHDKP6K805kJbmCkZ/WJ0yRmB4Nc8ljiq76BlIu7zbAH0+BSdzFQFHaQpSmcSPpN2EcOx/4DEB+MOMeOkIvg6OeOB9/GMHWjkQNOVlduYWVVnUJizdd6k2n7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RggXwxys; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2401b855980so35814685ad.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956255; x=1755561055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TJtTTLwYllxpu5x9aN3bNHJxvrplAr8PtWCWw4sa64=;
        b=RggXwxysY+rFMZDmiLG6tuaqnarPA7Mw1yoTcAF75W9NmEnmnk77MEAGwIrb/kbUPq
         mYMIB1wlELbauyuJ6+YjW6aJO3uY7EYsmmLA8rHDOeKtUXRz53hdWZ/WVnVA2bzXj0h3
         VDgH7tFs9Q0LgoxTk7lPQ17cajj7Mzdu5e4tsZOMlGLdNYHDcGPWjyIl99fPH+jRlJZN
         PFR64sjfXKL4gqGlwKdBIMgS5cFVGmBGdaW+kpa+4BpUOAeXgcJ5KCwEbAAD4WTcsifL
         j6vRX3qH1OMZSBbvCj2Tx9Y7huXi4BI6g/JMrMz7P+esBjmnpLHy0iT8rMGcFA62Cjtc
         tErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956255; x=1755561055;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TJtTTLwYllxpu5x9aN3bNHJxvrplAr8PtWCWw4sa64=;
        b=NUqWZC0dsQXR1IijqydzQu5pELZuvq0csaxl0NOJtn8lTBF9kHZcm7dK+eJDmRe613
         EPPOho5eouFmTpYXzPBud5298j7G3R2MAjZQZdcdDgxOnyBlqhkW6blviLzpOoYI0Ibe
         cbTAtHHpgjxG8nixI2UNKTg0JxYJRytD7Ccf4NXxZM0GNtrWnqXbdpu1Xh4/eAMYXw1d
         tAvz6IE7eL49/8R3UY0IEFCUWtnTy7VGrWVtDRurjQfYuDKIHCJeDiAZIURMxOAgvIf5
         Hmw/VuRfDxVUch/cRsp3qvS2f0oAUSn0Gptuh30IY91oGv+O/hO9kUQamY9qvJVzFabj
         6FtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmayGtoGKJqRqKeuSyKuLmhTW6Nxtv9+f1BJqP8IjUfzczpx9cO2c2GzWM79bDoHKnT8RWPJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpivlOJhn6RJ1CR3qYjAHwHF0ULM32gMHo27QeDCT0OKs+xSm
	+f7VMXRqp23UF/I5kjLTDIQmhaWRiDDeliVeivFyNWc0E73xRSPslMU4S/6oqI6gIJQ=
X-Gm-Gg: ASbGncttZgkBASClhDl2PlHBO0U9KRrX2QUUAXVFBVfYYxRYlYU3dtDMRxj7gSngl+B
	olOF6bUgq0Idm6Q5omCnjdtUCCo+uNVASkr664t+s5tpi3hhlneDucTiJXyuP7hqBQx6UqtAYzj
	DNlJ5msH/dW4WLkwh+IB93JbTF8748RqW5Gwl93bO6eOxErPqzQLCvCuE3VvURWOfTPKu3HAOyF
	vPR+OQCDCXc2c5OH2nlllSYLe7e/aOqqsDGDuF2DDewYrYGsUZln/eQeQZrKdOW/lGNCEf7NkNZ
	TV38QIOOWc7tDr+K+f5sgTMf2A5iv0HA4P8ZQGy21qvM9TUrSsDj9JeDAaKargA7m0cNpDdkFDn
	ZlpcH7m7jvHwjuqt1NJa4e5zZaYs7tVQ3JAaWiWnfv8YyH9vqMnXEF5R4YQRpuk2JFjY=
X-Google-Smtp-Source: AGHT+IExhl97fHMJWOi2ei7Jgh0a4kSisSp2agHJTiHAKS403k5IyWnTeUF9b0oHIPPRoej3Wih1FA==
X-Received: by 2002:a17:903:2a86:b0:240:92cc:8fcf with SMTP id d9443c01a7336-242fc3700a3mr19346545ad.49.1754956255632;
        Mon, 11 Aug 2025 16:50:55 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6a8fsm281608045ad.23.2025.08.11.16.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:50:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:50:52 -0700
From: Joe Damato <joe@dama.to>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: Remove redundant memset(0) call in
 reset_policy()
Message-ID: <aJqB3A8LMcocbfRT@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250811164039.43250-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811164039.43250-1-thorsten.blum@linux.dev>

On Mon, Aug 11, 2025 at 06:40:38PM +0200, Thorsten Blum wrote:
> The call to nla_strscpy() already zero-pads the tail of the destination
> buffer which makes the additional memset(0) call redundant. Remove it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/sched/act_simple.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
> index f3abe0545989..8e69a919b4fe 100644
> --- a/net/sched/act_simple.c
> +++ b/net/sched/act_simple.c
> @@ -72,7 +72,6 @@ static int reset_policy(struct tc_action *a, const struct nlattr *defdata,
>  	d = to_defact(a);
>  	spin_lock_bh(&d->tcf_lock);
>  	goto_ch = tcf_action_set_ctrlact(a, p->action, goto_ch);
> -	memset(d->tcfd_defdata, 0, SIMP_MAX_DATA);
>  	nla_strscpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
>  	spin_unlock_bh(&d->tcf_lock);
>  	if (goto_ch)

Reviewed-by: Joe Damato <joe@dama.to>

