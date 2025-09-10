Return-Path: <netdev+bounces-221758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1FB51C72
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256811611D1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980F327A21;
	Wed, 10 Sep 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y1GBgcaB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4324113D
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519522; cv=none; b=Zbv0WvhEOXEWuJcp+KOrB3V2qRPEwOVXn/Io80z/HWV40ovYJZKaPmW0eJ77n8I5lwsmVz8A5O4b1q17mQROuQaF5M4ZppJPSxenmjcVCTLScEQKBOU9aftREjFCtHzd/GAF6HlTkfsMNxS9wWGbQLZgpKn/ruzvVbt9Ljs95ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519522; c=relaxed/simple;
	bh=mvncor3HI+W9A/gmILLwXoL0QG8/oktXJxYei8rUIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF/f8KDLYk3k7H3XzNtxDhBN+0wEL0N9rbIGMISq1Qxr0VPiSavam1jkp+AG+oMBirNGw5ttV4+4sBY/9OFOJ+WK9LYl8QgN02652ZdIxDmNCf4eG4fjSDmQjfxuP2UNnXyUzgvpWG8X/aBwe0N+frWHhfOXYBufb42kjorIqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y1GBgcaB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso1324490a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757519519; x=1758124319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXqCK+svVlBuAMsr5p4huDSfMQXIvsA6yKXWJhLo+iU=;
        b=Y1GBgcaBhHBdzdjHWdJctGakxSRj+kMJI1Ps1TNkTxlqvMP0fXGLokw5tygfBg2zTx
         tmhelTbKHBV7xR/aECg9Bzy8FsW/PZIxKg363P0UANJBeNjHwpAF70ncVUWP94HmExuX
         XvAPy1lprQBoVhkroDfV982PSsEGbwXmGx3A9/2KP7nDVsDuf2jtJuHgQTMBcwWGuwtJ
         bRk6bSrBGrGET4dD/uiU9x8AiQRajepM2eGBPSelrE8okrBu6Y6n8GU9I0/jNQ6J21Rb
         q13LX7H92PCwTGLYlNB9Psn3ihJkMO0X4AW9yzZGc9e1/2zDeSoQQHU2WLpEZiYpt43i
         Qsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519519; x=1758124319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXqCK+svVlBuAMsr5p4huDSfMQXIvsA6yKXWJhLo+iU=;
        b=cbEBOQ3KxcIAU8uSA1Gx8XMlh0kRdOD6jAPw6Av8Jg+D3WAmU5+A/JdpxL+IdYD/zJ
         ZIm8d27e7hxZ16GsZBpmutJhmRdqJz3k8MuhER+f9fmeuXzCtAJCx6O1sNs55fnW7tjr
         3XYXXeReTREx8W9EtzRu4j62l1lghu2zYmc/l3XBmRqH8SxEcsPVfjM1FgbHvsJgvcrF
         xCxG/IrOdO/Z0CEYBPbOtdd7bOVyWMovJrLEwC14No1vSUIo9FNZ2txUaRMB7ud0ncI6
         PbmZVozFZlCfnFwnUHCB7PLggQRzwmP0EMZuo5q23EPLOxs5/6RYj0ASELgG3L3WTeXc
         Pl6A==
X-Forwarded-Encrypted: i=1; AJvYcCWgobSgffxuB+TnEyDP4W3c0uV0zjA9iFb40l7lvI05817T6NZRviODKiWQ75ebYEz+a9iOlYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCjhSLawL+ZJmewaHqQg6xP08VJcU54qUrEokPULWll4iRUGX
	4a4tPPPZokB05Sq+bZyaFSkv5aoBaPqT4oJSnXQXeGWaR6NmR6cH6KYToJ9Eryw+77s=
X-Gm-Gg: ASbGncskOJ0K95PuVltyM9XMHz47ASeOAxUC0B2z5MQg+TDzQPI8PyYUxOK3SouaObi
	MQPvPglOIxllHVdEZQTWsVcPeH0hgAxP5iKk6nmBrwphuEp1qEFCwsks7CuMjfKi/8+HBtsSCid
	FU1rlnn4cd9qhwlFEWWROou9xQdorq9NLeQv4Df1zzBpNLGrivpytvNVGuQ+iLrQheJK6sXQJxt
	gys/4GRcqjSQFfXnpZr87hIO0R6h1PnO0yHT8EZ4RkRmakHN+lqY/H6n7PRGmtiadzvK162zOc7
	5AnAT+iukD5e4ANGlX0w2vPoxU/pAzDKn3Us6tDiP3d3ksdzRln+bnE/vlVjRy7DFVCwYkOyVQP
	u9lbFM4hXC018p0XnqFkfNHzF1V5/HlvM4zrG
X-Google-Smtp-Source: AGHT+IFE9TusuMunCFfr6wNayngNXse/YHX3kwzAYccUed2qnbY4WVC4DPlKEEAXxnWfgkh/JZJ6bw==
X-Received: by 2002:a17:907:7faa:b0:b04:5d56:d838 with SMTP id a640c23a62f3a-b07a648315amr9092266b.20.1757519518832;
        Wed, 10 Sep 2025 08:51:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f6a7esm3543294a12.42.2025.09.10.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:51:58 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:51:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Calvin Owens <calvin@wbinvd.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	Simon Horman <horms@kernel.org>, kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <aMGenGUNcBbRUUf9@pathway.suse.cz>
References: <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <aL88Gb6R5M3zhMTb@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL88Gb6R5M3zhMTb@mozart.vkv.me>

On Mon 2025-09-08 13:27:05, Calvin Owens wrote:
> On Friday 09/05 at 14:54 +0206, John Ogness wrote:
> > <snip>
> >
> > NBCON is meant to deprecate @oops_in_progress. However, it is true that
> > consoles not implementing ->write_atomic() will never print panic
> > output.
> 
> Below is a silly little testcase that makes it more convenient to test
> if crashes are getting out in a few canned cases, in case anyone else
> finds it useful.
> 
> Testing this on 6.17-rc5 on a Pi 4b, I don't get any netconsole output
> at all for any crash case over wifi, so that already doesn't work. All
> the cases currently work over ethernet.

I like this test module. IMHO, it would make sense to get it upstream.
What do you think?

Some comments below.

> ----8<----
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [PATCH] Quick and dirty testcase for netconsole (and other consoles)
> 
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/tty/Kconfig     |   9 ++
>  drivers/tty/Makefile    |   1 +
>  drivers/tty/crashtest.c | 178 ++++++++++++++++++++++++++++++++++++++++

I would put it into lib/test_crash.c. It is similar to
the existing lib/test_lockup.c

> --- /dev/null
> +++ b/drivers/tty/crashtest.c
> @@ -0,0 +1,178 @@
[...]
> +
> +static ssize_t __crash(void)
> +{
> +	pr_emerg("BANG!\n");
> +	*(volatile unsigned char *)NULL = '!';
> +	return -ENOSYS;

I would use similar trick as SysRq-c and call panic() directly,
see sysrq_handle_crash(). Something like:

static void __crash(const char *context)
{
	panic(Triggered crash in context: %s\n");
}

> +}
> +
> +static void __crash_irq_work(struct irq_work *work)
> +{
> +	__crash();

and call it like:

	__crash("irq");

> +}
> +
> +static int __init setup_crashtest(void)
> +{
> +	INIT_WORK(&bh_crash_work, __crash_bh_work);
> +	init_irq_work(&irq_crash_work, __crash_irq_work);
> +	crashtest_dentry = debugfs_create_file("crashtest", 0600, NULL, NULL,
> +					       &crashtest_fops);

Match it with the module name: test_crash.

Maybe, do "sed -e s/crashtest/test_crash/g".

> +	if (IS_ERR(crashtest_dentry))
> +		return PTR_ERR(crashtest_dentry);
> +
> +	return 0;
> +}

Best Regards,
Petr

