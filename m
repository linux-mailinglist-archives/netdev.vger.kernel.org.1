Return-Path: <netdev+bounces-168622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C4A3FD1A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D09A19C26D7
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55024E4A8;
	Fri, 21 Feb 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="i/XNE0eY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925DA24C68E
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157857; cv=none; b=W2kz3rjXsXPWX5RAHl1ePTwCzX7v9XTm7e2j2F1kCz0iwpfRtutLgISbZNyBnogNml5BTJDZTqF9udYeXXPHhmR3I9zJzx/DcRcl4QsszV8s0zz8Dlhmkzvq/gULkY90OVhYhNONyNQ1LN7yWIceQLYMi5SwkAwLDTtIocO9U+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157857; c=relaxed/simple;
	bh=IFPPg7unvgRYJmnnyZpxqCXIrbhuOjl7IA1H9/KVlcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcyUKtEAE1P5GRESvtJsY6WZ9BXs4gblGpcvlbnoP8UL/hix9KVPWeBODHQm4lDDysYvw1MQlhT6GZqVHXiAFKUzRdk4UGgqowck4b9nfOLreHp0YFk18kKGYRUJXsMLH5BKR2u2By3ULbmTTo7GgjHGd/Yxa4Za5S+c5z7q7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=i/XNE0eY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0ac2f439eso244546385a.0
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740157854; x=1740762654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9v3Cbrwcv78yvNxb7YB7JB27GakVZt75JxjiAlrK5Q=;
        b=i/XNE0eY0qJv/Ue6874doU0sJpsBqUwL8Vhacs3iUBgOGwbnxPP1wUYqOPRSUaXvet
         U1JLGxIdKNvtVyAX+zpW0S4mWVNO6sW6XfL5ppi6fPPGaAW0L+O2zZcHObProdNZK0wp
         Ep1GSLfRcXKUuVran28bW/eRXA1wIqh478pow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157854; x=1740762654;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9v3Cbrwcv78yvNxb7YB7JB27GakVZt75JxjiAlrK5Q=;
        b=INV933/JFxNXztWniyPQxNqtiTOOHhes8n47zycNwF2+vSKxLZ9XBh4ZZoVMJc8yIw
         x1qlK/NX3If2JpYBOwNsQ1vzL1dly1W6I8Je/AyWdhm+kymNDPtaooNBVr3k6ptCmpzH
         bJuhZf5bp7gohW3mcriCmgCNSdfVcV7tIRNl/i7+ZCCs0NgwAvvNBUCfbJfVWNynoaF7
         daNHQXrgZVkW2Xz3p4L1+hNEBnxHmuAu72FAO1HSC0snFcxI9CohhiOLy+4E8+WdxwKh
         ZkH2hZN5o/FwWPz0JRQ9CZun3ylOdvXJRvl0uYasGSps9iFwBBg5M41Bj/hLUastNM0K
         aVzA==
X-Forwarded-Encrypted: i=1; AJvYcCWkXe8sLw/NO7X/Obnacs1N25JSffMmGbo8q3tAfGp3RBZShmGHdENAMtzdTpTW93JWi18JoYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMJYQRvjNqgFpiqaMLgioG86IaTFrK9cD0rSyoPxhOZENvsuC
	FXBZ0Clrqz2JtVeMRvFsCwPvN5mTQOtWKsyPOuZjKOdXMAkXAHqrby4YYo5pP1Y=
X-Gm-Gg: ASbGncuF1ARFMpK8tp69NJjJyq5CSKT7OC211aGayiPPU3IfVWSBXV9g4FfTkVLj0+9
	cVNfYINcqlecPox+/eyH50DhlLg5c+dICdPq/SiAgc6bj4aRxWclX2YlCaQvSpH+hY8jUCQK8V6
	T86s2eYP2m2JtYDjreRbyzQ2n9llHCBAVFgBYb3Cn+B1SOhELzFPyf50fPDBcpcQZuOrGu+f34+
	fc90+ODSxe8FukDvu+JM4csh+UL5X7hfgilUo55XtasP1M0HO2ScgWcaNyF44/gilaLf3ZDIMTr
	AB7V2H8PZi2SU4124j7MxMCEWnh+fhdrZfb0HDChY2qZMQGSjLKNf8z/YcWpJlXf
X-Google-Smtp-Source: AGHT+IGIaZsOI/NgG7xLu4tpdCyFiQnFknmoXIk5Ui/7ePCNWWqG90QxAzqloaFAiU0KRpUiR+zBKw==
X-Received: by 2002:a05:620a:1707:b0:7c0:a70e:b91f with SMTP id af79cd13be357-7c0ceee6424mr721462185a.8.1740157854374;
        Fri, 21 Feb 2025 09:10:54 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b368d200sm397346285a.99.2025.02.21.09.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:10:54 -0800 (PST)
Date: Fri, 21 Feb 2025 12:10:51 -0500
From: Joe Damato <jdamato@fastly.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 0/2] page_pool: Convert stats to u64_stats_t.
Message-ID: <Z7izmyDRvTmKpN4-@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221115221.291006-1-bigeasy@linutronix.de>

On Fri, Feb 21, 2025 at 12:52:19PM +0100, Sebastian Andrzej Siewior wrote:
> This is a follow-up on
> 	https://lore.kernel.org/all/20250213093925.x_ggH1aj@linutronix.de/
> 
> to convert the page_pool statistics to u64_stats_t to avoid u64 related
> problems on 32bit architectures.
> While looking over it, the comment for recycle_stat_inc() says that it
> is safe to use in preemptible context.

I wrote that comment because it's an increment of a per-cpu counter.

The documentation in Documentation/core-api/this_cpu_ops.rst
explains in more depth, but this_cpu_inc is safe to use without
worrying about pre-emption and interrupts.

> The 32bit update is split into two 32bit writes and if we get
> preempted in the middle and another one makes an update then the
> value gets inconsistent and the previous update can overwrite the
> following. (Rare but still).

Have you seen this? Can you show the generated assembly which
suggests that this occurs? It would be helpful if you could show the
before and after 32-bit assembly code.

I am asking because in arch/x86/include/asm/percpu.h a lot of care
is taken to generate the correct assembly for various sizes and I
am skeptical that this_cpu_inc behaves correctly on 64bit but
incorrectly on 32bit x86. It's certainly possible, but IMHO, we
should be sure that this is the case.

If you could show that the generated assembly on 32bit was not
prempt/irq safe then probably we'd also want to update the
this_cpu_ops documentation?

> I don't know if it is ensured that only *one* update can happen because
> the stats are per-CPU and per NAPI device. But there will be now a
> warning on 32bit if this is really attempted in preemptible context.

Please see Documentation/core-api/this_cpu_ops.rst for a more
detailed explanation.

At a high level, only one per-cpu counter is incremented. The
individual per-cpu counters don't mean anything on their own
(because the increment could happen on any CPU); the sum of the
values is what has meaning.

