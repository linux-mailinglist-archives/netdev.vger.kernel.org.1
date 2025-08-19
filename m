Return-Path: <netdev+bounces-214980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D4B2C6C7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 115887B77A4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CDB261B8A;
	Tue, 19 Aug 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWJJHnlc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798C258ECA;
	Tue, 19 Aug 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613094; cv=none; b=bJ9C/Waa3493UnJ9qH89525cxdqpjwo63gFwI8l8VH6RLU0SThamMWr9zB8ZcjFiBh6Hh0ypBpRL9D+KqCL0vP92/Ho+WScm4hjfcBBQCRvBA5naX4agXrBQbDlpIySZjO8N7X3LguWnjmUR5QVHE/tgZOK6VPk8XLewbHf7+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613094; c=relaxed/simple;
	bh=oW+rxafxapipm/J6ayYDWicouO20Glhp/GcEuVEZeC4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BKE05Ug+pLuNeqx5xxcsn69+TJbgYuO/xe5OP26WbbQXsTkqMttEgZANmmohs+cUvAWIn3oGNUr9+H+aj/8BDB34O+5Qsq5/yOWt6NL2af6umgzSYndSElm9ylCO2c2qTd8V6WnT8CYliU1phh+UFaYzstHvIlu2yZi5g3S5ouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWJJHnlc; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e86f90d162so531033485a.0;
        Tue, 19 Aug 2025 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755613092; x=1756217892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6N2bzu/Clqrn8RBenj8X9CJly6lk5mVWUKaIFJKlgk=;
        b=AWJJHnlctVUPYBxnt8xF7hwgb2NTwrx6DuCj2Nzg9x9MT7/h1d+M+x4DB7FGa8J5K6
         i0wh91zAMzRoytxjRahOd3yxw05lFpA8asm/gkm0jGHqWhqoOx2Pqmn6YWVmNO2Xe7gJ
         4zlg0CeOcXk09MRrU+oNHRwAefvA/JOc466WhfHJB9A/Jn0hrDnt3uZwNxF4mNMZrjI+
         NCV2fasZKV6cWkXqQ/n2mPPm1dfqhMHHB0yBCMzK6qSPbbMRJ7RSE/UKRQZfa0WDThre
         eu8C8a0Ie7cQZ7lAtMddi5DXgnAmxUEhZNkQ4U6C8WZMeUegJ3YXvx4HgxqSOS9puda0
         KsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613092; x=1756217892;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E6N2bzu/Clqrn8RBenj8X9CJly6lk5mVWUKaIFJKlgk=;
        b=MiGxWsUeQMuYuIoOoeHmzOjaRWrjXcHOPGUDQIvsouEx+qubuQGUy5IMDmXWSDOyQE
         yFFav9gHCdeyGlSBXoir97DgPgpJbuSZWIXXr1KVQtXkCGdy0JD2PcEj0j69AYvjYOAP
         unq0FKuGAf8GS97IIMVDcooYa7HYAlT2e7fUQzLQVSOgvh3TQhbV0IqRbJNuexvaXLSf
         qajzXM1H0FPpc77QGcMx7lF1F3VdFXmw+Z1MaEtuQ2bWpHH95QLp+hpg4W6FK3Z7rr1G
         //pvnRV0d6QVY5r98xUTfbQgL50TRoRFZPJbywI6nzWr88KjCiLQj7fL6VaWUgsKQKw2
         kYLg==
X-Forwarded-Encrypted: i=1; AJvYcCXFm9j/KpUwwPQHfZCHsYEr1+59+ReaaXGbm1I++3YBUD/gbAlX6nzbpt/Ox3gjDsmrjcLMKx3g@vger.kernel.org, AJvYcCXa5R4ds1tz5Ife/KuiruGFrzwFgmQPihMs80bErnrk9sRYPtR3lqcWLfodVDPfN8tmY5HkxxpxM9TzTcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmJeYo6e0NoF0D7Zhe1+33uIkT79zKi6sdZUT2l6jaChduM+W
	+Nolw0WssI9dJUacyW2bYEaAoT7uAfY4NsyPx/5AZ96Trd1hKE4OONSI
X-Gm-Gg: ASbGncvyLSbr7l1j2vr7oWAEX0eA/cIVXN00zzPtz5cEOr9qIoNJzed1v2snMhm9rFy
	v7Y42IOJsgr4HXis+aRjqBVv0/s3Ddn6ywwMHCMWjhjtcMBEBycK1+PIf57MhSncLrw1ZX3s8YQ
	jaBSX1He065IZWKrazelyAfrLpjFU0ecdjxPDZtLXAGrO4lzBhwEZy6RZpkFkoD5wzKAYBCDLlG
	ryQDgfWW66O5t6UbV49CvYA0oSkB8YnEJrUWTrVkzndBG48Bu/zjIOBXPdY51HLHLpVBfPoJ7VK
	R0fwnzbMc+8gSC0wUlKbkePdu70uZeYCMftXgHeIn1DcjbDPTuA6ob8PRQPKBbvTBcXXewkhqNU
	02Y2mXixKo+0KgHZBixIYlnXKnlHco0O8iuQ1smWp8iRFQYMFGytqHF4Yo5lfnMlibjEWIQ==
X-Google-Smtp-Source: AGHT+IFCAYHu4JhItU1LDghBDv2IjAAijEp/5jYekdS3K8kJvxOfyY6opc/yjFvioV6PhsI+hWNuCA==
X-Received: by 2002:a05:620a:1918:b0:7e9:f81f:cec1 with SMTP id af79cd13be357-7e9f81fd33cmr123920985a.38.1755613091550;
        Tue, 19 Aug 2025 07:18:11 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e020514sm770498385a.17.2025.08.19.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:18:10 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:18:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>
Message-ID: <willemdebruijn.kernel.1a86f7d92a05a@gmail.com>
In-Reply-To: <20250819091447.1199980-1-jackzxcui1989@163.com>
References: <20250819091447.1199980-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v5] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> +					     bool start, bool callback)
>  {
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> +	unsigned long flags;
> +
> +	local_irq_save(flags);

The two environments that can race are the timer callback running in
softirq context or the open_block from tpacket_rcv in process context.

So worst case the process context path needs to disable bh?

As you pointed out, the accesses to the hrtimer fields are already
protected, by the caller holding sk.sk_receive_queue.lock.

So it should be sufficient to just test hrtimer_is_queued inside that
critical section before calling hrtimer_start?

Side-note: tpacket_rcv calls spin_lock, not spin_lock_bh. But if the
same lock can also be taken in softirq context, the process context
caller should use the _bh variant. This is not new with your patch.
Classical timers also run in softirq context. I may be overlooking
something, will need to take a closer look at that.

In any case, I don't think local_irq_save is needed. 

> +	if (start && !callback)
> +		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> +			      HRTIMER_MODE_REL_SOFT);
> +	else
> +		hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
> +	local_irq_restore(flags);
>  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
>  }

