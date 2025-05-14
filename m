Return-Path: <netdev+bounces-190285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCCAB600D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 02:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8346E86024D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED66A634;
	Wed, 14 May 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsPcjc+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF528EC
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181325; cv=none; b=aq/BFUtwvtWtgH+byVyFWGZq0/TBVY3M/nu+pE7EJQ26fFIWsR201IF8i3YP5L1ZBHkwgvywkBRpDawI3E263MytwXHqURNtalkMjO5dGvRuvPk1m2QJxHQwR0lbg0tM6oHEXS7vl4HkSVYsfx57KM+zEGQXTEis/kjGL1WdpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181325; c=relaxed/simple;
	bh=e9+fJenbAzfMdlcaENqSvy+FdAmvx+hd0Heo749LyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcQ30fhHo3WcANr1v81g4Eyitm3jBIWCCfYQLaFCJR6ryoj0Ty1bHG/umJVaGPvNzpUM50rXOTC9dqIFGPx0FIvzUB1WO3GAGSIX4tDCXCTcS+VPmEjy3ijWmwGpqPhwoU5B2/FEzSMobhyrfhZu/JpYeyLmwl2RhbvideMjmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsPcjc+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23B8C4CEE4;
	Wed, 14 May 2025 00:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747181325;
	bh=e9+fJenbAzfMdlcaENqSvy+FdAmvx+hd0Heo749LyCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TsPcjc+txOCVzBhJ2IpQrKDgBHP04eadfbOzZYBtBV6HNPMZ/VhThZ5IOMhiHjere
	 +UuVsivVhe0ThNkg5eGH4AS9yjrCgQHyTCCyQmt8Csd1XDApgYefriZwpS1/dPFCVo
	 xeDyUlVk3BYeYyX+SpjXL4cQLdhtVsVxJJgdOQQquTz2ma/ZvwdD2SIHS7kiLzt9QR
	 qtMkBy3wEwEHAitG3PU/NyAH9ek5YEesTs3kgC3iKCLliXlMxvYsCJSPcIvq9lSv1C
	 GRl8OPH9U+MSweHStcP+A1a3UbiXyD2a/dMS+Bac+HhEOVEjkHNcuQwfXc+pXGhfZT
	 nIR9kMW2v9mcg==
Date: Tue, 13 May 2025 17:08:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, weiwan@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: stop napi kthreads when THREADED napi is
 disabled
Message-ID: <20250513170844.03ef5752@kernel.org>
In-Reply-To: <20250513002631.3155191-1-skhawaja@google.com>
References: <20250513002631.3155191-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 00:26:31 +0000 Samiullah Khawaja wrote:
> @@ -7463,6 +7482,15 @@ static int napi_thread_wait(struct napi_struct *napi)
>  			return 0;
>  		}
>  
> +		/* Since the SCHED_THREADED is not set so we do not own this
> +		 * napi and it is safe to stop here if we are asked to. Checking
> +		 * the SCHED_THREADED before stopping here makes sure that this
> +		 * napi was not schedule again while napi threaded was being
> +		 * disabled.
> +		 */

Not sure if this works:

          CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config)

  ____napi_schedule()
    if (test_bit(NAPI_STATE_THREADED))

                                                         clear_bit(NAPI_STATE_THREADED)
                                                         kthread_stop(thread)

                              if (test_bit(NAPI_STATE_SCHED_THREADED))
                                   ..
                              if (kthread_should_stop())
                                   exit

       set_bit(NAPI_STATE_SCHED_THREADED)
       wake_up_process(thread);



> +		if (kthread_should_stop())
> +			break;
> +
>  		schedule();
>  		set_current_state(TASK_INTERRUPTIBLE);

