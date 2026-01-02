Return-Path: <netdev+bounces-246554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B99CEE12D
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 10:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCCF8300119E
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477D275114;
	Fri,  2 Jan 2026 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0KqSC4py"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0861E89C
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767346900; cv=none; b=e6GbcQRQ0X1YexCSuBSv39Q3cqRQJUFhw5uU8BDPiIaxjHk4fPJobeqhpRBJsHS/g6baxXFmnEHKZQlB7Hll6av9faUVnlxXIg7U3CUR5QnensOwyZXqib7zuGN+SgDmW7DQD5Z3nY1s0MqXRj+v8tG4MiiRkN5hy0EaIJiAqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767346900; c=relaxed/simple;
	bh=5uO8RDHjB/bNUyexWySF2lb28p//jJ/aWFv27W2+lGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvfBSqh22LudW+Y35QI5KTYWaOKRZbstiRbQ7ry0CIzqXqW+GPqGVl81OqjJciuhg1sFIJgj8ODmw1SVHryNeApD1iqRDw8/SmwUqry+BKpD8hrbpZnBn4rozKeJ6Kign33oQME7EKhxcYTtg7ovhICxVgmZyye3nwNK2uvDHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0KqSC4py; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so92577265e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 01:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1767346896; x=1767951696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uO8RDHjB/bNUyexWySF2lb28p//jJ/aWFv27W2+lGQ=;
        b=0KqSC4pyViPkpTROH9CyX2WNUasUj1P1HSM4M9RXZ3TCKDNha7nVjRv+ywP35R4VTf
         JpHx0ExghCjf0ZXzGGsat3v5bhkMbYhEy0lmo9DoP5Bm/4nLrc/ABL5xiPjetbXYO5Hv
         iGeEqCRjxymQ57m03RX7RlQcBA1F+bynBWCt3I96DR2/Rgn+U0rZPPfICc8pLAtlgzTG
         UNAO3/T9nCVQ1fumNQaQr5yvU2cb3cb2kzzM9hy8cJCPqkwmSj3PqMxj2olmGO9LM21T
         bV1WyktCX5QJGHtzfsnLIvOyQkPF5e9h5ojWedMcnO7s8uLsgPvM5N0qqi3vionxN2Qs
         LRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767346896; x=1767951696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uO8RDHjB/bNUyexWySF2lb28p//jJ/aWFv27W2+lGQ=;
        b=VWAwR1hctCu0I1y0JaJ/1G+JEZH2+gqS0vYnzQouRG0dUu5fLQhIy+y+e0VvK22NA0
         vKaOjkSr3KvLfxdAXakXs0o6jNa0d49AkTcblWYwyG1JI7Xytg04kKLH4AhmDdxo60KS
         fW6C/CBJl9Qxmhe3KU6poSuGAyTXl1gtnajHDqu6XDIQT+MxhHVs6cEHb/86PYxUw00B
         h9Uql4cFXeebiHnMBa5jtFTLT///D2OtMjVHcST5Z25bwxSWN9Z1U5p6etEFxokLIHlF
         BvU6qt2svmQ97yBRCY7AXT023s3Xa7cj6P2GbVXNzTAeg7puFKJQsDja9rWhEs12rQOG
         5Ueg==
X-Forwarded-Encrypted: i=1; AJvYcCU7L4j4Q7gcE3rcsTaKD3WptWYnumbL+KlI/D6PbWk5oTueJhe0TmHTytlKiqpqoti69xd935o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQZcJgs+WV6PssDUDAL6WTF1oG1CP83suAcWH5g3kkI87NDKq
	TbM3iEsGIDdleWE1Gwm0lSbkdWCGlfQ5n4DkrDM3L9tk7kjenwzgqUn/kluLB37Wedo=
X-Gm-Gg: AY/fxX62WvEvj9KXJlmXKFkQD2sB+6IdefDseloxqGq9GY+WrQ0BnlN1BNO0pLOtgCi
	sALSwF69wDMubdKcUlYNwWXKPkYVDior1PuX2l3Ir1GzDVOes/EjRghWer4j6MTx81Nq5FnTR03
	bVPSMeVix3j4pRLlIYOaPZHzZoegZ/cUgsNy2COxXPKllVGXLjgZSK0CicNiDZ4P/0D2al/ly6K
	j64urX/TLRjB7aWXFjmwoqBapbfrnStbjV5Z2u3ycI0zTX4E+ktD7Ti9g5iFRkUXkxKoUgUr1tm
	T7DXwBgVbrKS8cIfcSzXmiBmDyjwH6fy5lAoOlwK4lzuHNHTHLC6XWrgzR3r9gviKMxYuIgze6U
	J5h4cBMPZMe9InsCBuJ9xCYKLEUaGzLCP6bUyeryJfQJSIIyRhQpjW2YctkVqJkkrYWimK0tNJ/
	cT4SWRTvW/zRyUhwFim/zrKzY=
X-Google-Smtp-Source: AGHT+IGD39cVObDVeZ6xmuQpCvjSA+AN2zRcHRkFTjgfnuPMfho0Ql5qklljpYqa27sF3WBPpLyf3g==
X-Received: by 2002:a05:600c:1914:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47d1955b79amr465110435e9.7.1767346895958;
        Fri, 02 Jan 2026 01:41:35 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d5372sm760352485e9.14.2026.01.02.01.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:41:35 -0800 (PST)
Date: Fri, 2 Jan 2026 10:41:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xiao Liang <xiliang@redhat.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com, 
	saeedb@amazon.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3] net/ena: fix missing lock when update devlink params
Message-ID: <auk6ifnbjy7xhmv5il5mhkttlg2sgvj2fqmmryt53pf7ifhga2@a6m25efjduln>
References: <20251229145708.16603-1-xiliang@redhat.com>
 <20251231145808.6103-1-xiliang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231145808.6103-1-xiliang@redhat.com>

Wed, Dec 31, 2025 at 03:58:08PM +0100, xiliang@redhat.com wrote:
>From: Frank Liang <xiliang@redhat.com>
>
>Fix assert lock warning while calling devl_param_driverinit_value_set()
>in ena.
>
>WARNING: net/devlink/core.c:261 at devl_assert_locked+0x62/0x90, CPU#0: kworker/0:0/9
>CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.19.0-rc2+ #1 PREEMPT(lazy)
>Hardware name: Amazon EC2 m8i-flex.4xlarge/, BIOS 1.0 10/16/2017
>Workqueue: events work_for_cpu_fn
>RIP: 0010:devl_assert_locked+0x62/0x90
>
>Call Trace:
> <TASK>
> devl_param_driverinit_value_set+0x15/0x1c0
> ena_devlink_alloc+0x18c/0x220 [ena]
> ? __pfx_ena_devlink_alloc+0x10/0x10 [ena]
> ? trace_hardirqs_on+0x18/0x140
> ? lockdep_hardirqs_on+0x8c/0x130
> ? __raw_spin_unlock_irqrestore+0x5d/0x80
> ? __raw_spin_unlock_irqrestore+0x46/0x80
> ? devm_ioremap_wc+0x9a/0xd0
> ena_probe+0x4d2/0x1b20 [ena]
> ? __lock_acquire+0x56a/0xbd0
> ? __pfx_ena_probe+0x10/0x10 [ena]
> ? local_clock+0x15/0x30
> ? __lock_release.isra.0+0x1c9/0x340
> ? mark_held_locks+0x40/0x70
> ? lockdep_hardirqs_on_prepare.part.0+0x92/0x170
> ? trace_hardirqs_on+0x18/0x140
> ? lockdep_hardirqs_on+0x8c/0x130
> ? __raw_spin_unlock_irqrestore+0x5d/0x80
> ? __raw_spin_unlock_irqrestore+0x46/0x80
> ? __pfx_ena_probe+0x10/0x10 [ena]
> ......
> </TASK>
>
>Fixes: 816b52624cf6 ("net: ena: Control PHC enable through devlink")
>Signed-off-by: Frank Liang <xiliang@redhat.com>
>Reviewed-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

