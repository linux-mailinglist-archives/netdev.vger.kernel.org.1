Return-Path: <netdev+bounces-67887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCB8453F7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 10:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B331C258C6
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB4015DBD7;
	Thu,  1 Feb 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="c7Ho1cgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6515CD5D
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779835; cv=none; b=EnBhWh+pZeibG88I2s9yMb6yn2CtJVdr0jxhV/DiaTWtNIe4DKGICXz4B7jULIlTcSRivWAWHXUUZj2BvFOeHi0dK/LkhjFx3xSHpcq6yrVb8o/TuMV5HHkcMEqo3YHPxfs7tG/ZV1O2LCyhF3GVbX5Ir7PMYp/ya+jl7g9eQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779835; c=relaxed/simple;
	bh=AQLRSO7QsOgfEBze7cey6nPo8K0X16220Gp7pKE6Sp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOGkEgWIb3eHKZ90mLmQ7gkjJGjP6HhfQ0MiqYQ824zcj2qU9rbzy0dFOTAr87NsEJDG3OLtw8NhLa+8KLQfmNGjX2Ndx8Z+0DZcGS0WP4+ES67ycRnCkR63CNIAbGbyyt/Y3lalshj7xKG6MmYg9xa8az2oK9w8/MGR2vtyUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=c7Ho1cgS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso6103715e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706779831; x=1707384631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT2veEp5gZ9BtUA5KWjrnErg1xAAzrW6P7pOa3tNa4A=;
        b=c7Ho1cgSJb/154g2+8XxlQhCRpkd2eTm0XX7KOUay6yny78SOuylbsEgrwL6MlOmHS
         9tcwG/oziZOLC8GJU6nzVoF1IfImLD33NqhYYLHy7vI58ZytgmGA/ehvS/1bf/BIjpQs
         AwVNA9YGxJfIsDy1LrpLB2osLiO/ZnCSi7N+bZR3J8wB8CJGumKEzcByXvjyR083qw3y
         /KIO53IvaBLOOUPzylKpxA6HtTrty/PlVWoCKg+HxiIlEbwzglLXQ72T5mBV+KdaSTTR
         wHtoVIOof8jy8TZivLqamcId6ZjxSE6azMSgf74ENDDBMx9vczDrDx4nLCbePJNXCDk1
         5/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779831; x=1707384631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT2veEp5gZ9BtUA5KWjrnErg1xAAzrW6P7pOa3tNa4A=;
        b=d2BoBINuGbOHaA7qnGWTj4ww/XZd0J+J29/HDTJclAeIuePDv+Em3LrYBMGlEL5daV
         6Me2YfG3F7TD1uNG+yc1+oy+hQaISdKZ8zSmhS5LnOYvjoan28UdUdK/dt/uau0DGzBh
         2sz76JavjzMgyKi7txLhDb1F9TEVQM4uqf6+vbR7SfrdJUkINHgat94GuFQYQjnBParO
         LDJIX/m/NJ9Jww79M3C58enEmIV/isSJNVcYklcmFi2C8bymfZddNvrY8BsmTKopOWHN
         Te/oJ5ePr3LKt9lsHtj5ZQy8UwjgPj7xqjYehbhhxKxOl1JBD15vy08dAMmn0x7EX9hv
         YN3w==
X-Gm-Message-State: AOJu0YzmkjJLVNAoI9VCwwykEjbderMoZcDFXb57WU6R1WDzeFIzch3J
	/4jtvBf29V/jlL8b/bomzv8Ef+5ZTfj2bAcW8d3Ffe8nOqkIb/vPHoDcYFj3oS+lGwAoPgNSqk5
	/Dhc=
X-Google-Smtp-Source: AGHT+IHe6dxPN1npm+THenZ4TSMz8seJp5qgZ2AuzSqxYqDPHDOUd2SwKbXdeW8WUDAhvdOavztaSA==
X-Received: by 2002:a05:600c:a39c:b0:40e:55ca:5a48 with SMTP id hn28-20020a05600ca39c00b0040e55ca5a48mr1643450wmb.16.1706779831347;
        Thu, 01 Feb 2024 01:30:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQcicZMwzL/viLXVVI60Y6WMt8pIdyFBGB4N4gj83Uymsmfo75UdnBuoVUDgTeLd6ce0/DBe2rigaiPRy3GWO2
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k38-20020a05600c1ca600b0040e5945307esm3928108wms.40.2024.02.01.01.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:30:30 -0800 (PST)
Date: Thu, 1 Feb 2024 10:30:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] net/sched: netem: use extack
Message-ID: <Zbtks__SZIgoDTaj@nanopsycho>
References: <20240201034653.450138-1-stephen@networkplumber.org>
 <20240201034653.450138-2-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201034653.450138-2-stephen@networkplumber.org>

Thu, Feb 01, 2024 at 04:45:58AM CET, stephen@networkplumber.org wrote:
>The error handling in netem predates introduction of extack,
>and was mostly using pr_info(). Use extack to put errors in
>result rather than console log.
>

[...]

>@@ -1068,18 +1073,16 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
> 		      struct netlink_ext_ack *extack)
> {
> 	struct netem_sched_data *q = qdisc_priv(sch);
>-	int ret;
> 
> 	qdisc_watchdog_init(&q->watchdog, sch);
> 
>-	if (!opt)
>+	if (!opt) {
>+		NL_SET_ERR_MSG_MOD(extack, "Netem missing required parameters");

Drop "Netem " here.

Otherwise, this looks fine.

> 		return -EINVAL;
>+	}
> 
> 	q->loss_model = CLG_RANDOM;
>-	ret = netem_change(sch, opt, extack);
>-	if (ret)
>-		pr_info("netem: change failed\n");
>-	return ret;
>+	return netem_change(sch, opt, extack);
> }
> 
> static void netem_destroy(struct Qdisc *sch)
>-- 
>2.43.0
>
>

