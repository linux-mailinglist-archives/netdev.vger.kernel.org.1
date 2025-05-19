Return-Path: <netdev+bounces-191405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04EABB700
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54EB189859D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F431EA7D2;
	Mon, 19 May 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAjI47z+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B710154BE2
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642772; cv=none; b=sFBSO8bcZK741sW7s6rjySinotH6B2hkXn8DrDURqk/HTXF18T2zpYZ6XstCc8SsiiiMWqxQepjm9PiqlTRJk0pXNHlhQ994U/6p+wnrXedypk/rBiPWJuDTgKYAJpq/zSP9hFjXtxRGEmSPULhepzUNgzyxKFbHEng3C7HvaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642772; c=relaxed/simple;
	bh=qHrNfjhkTdPxv7dsNvqIcEBZLFpkwwu2nyoz5CcYN5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wb7KPo+0rPSRlKJZQJ9RmEABeoT2mRoWgINkkXAKi9iQbkDgYsockfEqIJACls5GIuOTWDqGlOEWMkY0xnDe9euyK9O5LnIBSQuNlBS4jgXg/fx1FnuunHhg7GdmBLbugffhaDqqtAHEXApfU9PEa+ksavvuAKGK9KK1rGrI+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAjI47z+; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7086dcab64bso36498577b3.1
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747642770; x=1748247570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8T5GaC00Oh6pbsT/dB6kXpfiF0+p4YxQBaiUBsDJs9s=;
        b=DAjI47z+iyokk9PQu7oJPI0nCuMzWaMYBPS4ssOYfX7NYD4dP/wJKt0oLa8sCJRduN
         Y+IhuL/Zr9wfwqkYySs2b7ibZft8lmFwI5IlvfryVt4/Js3V4g4LBEUASXxAZjDdT+s9
         WxR/tmSvLcBrQzARwjStlGiNVUMrrIa5J3HnmyV3zlA0Jsc5xTinUwMjc5minCuhzTCg
         qF/QrxL8RkhPfcbQWXWv3ccusnW2JBVy1PKz+Oob7fSOSk86JAqdFOw5LBA2pOZj+vad
         oBeguNSk6c2xqCPJv/oG2+N9bjBSDl6wHuN4ZpEJ1jJCDDSbWz6WgcvukHBrzeeY7GaW
         MyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747642770; x=1748247570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T5GaC00Oh6pbsT/dB6kXpfiF0+p4YxQBaiUBsDJs9s=;
        b=Fy23ca2MFS3N92aH3Yjl5W8fzx2QMPgy+uEWVtMVHqArsnH6hM6Nx5/CFaW+frI+ta
         5ihaHFM3ts6ryokG4MqbAf+nfibzhsQWpM9jeGSYF92DMxoH01PAWQyFc8vNpNEI6hna
         yCPt0+3SevtF4ePyVguEnN2upGgqRebXYtewB05SE/K2rQZElgb3J+pbtksWMTAQhlMD
         U4LlxPv+9XpuIf/YlLOifOic+1tVbrF21n/dtpUhmSs34qUPQdxFWjVBRWWT9m9LoJcg
         vdBylwRg6URAV3+jkzrfzUfnfCBa1sdHXrYmujxDhMJ1mCWoandlTd1CKDkVCcHtGpCJ
         ouoQ==
X-Gm-Message-State: AOJu0Yyb2VrEPEDSkfFalrNGcDGRLoJ8qa/NPz2z7sv+KOOltorBnr7+
	DYdO5aU/C40E05iMvWTKAnOEQr5fByS/z3vdONnAKdAN7AhGlDM3j8fI880OrhWWuIQ4fBo7S+j
	1eL787DMx2XEbmENLHJk20khg99rwttF3EZMY0YKwGw==
X-Gm-Gg: ASbGncsqPFe3ng/858275m5fXxyNv5UuZvviYXkw7fowGNnTNYeE/TIJG+UbsAxj1dA
	8ZEo7PEwZE9Zip1nGRycrNXcXhNxePWcYopZimozvGk5vh0b+xfjHMuJ10DmxpxDR0tgN06zqy9
	5bZ6/XcwvO61YAZ2LY23uIK7r8l4k4cxv+rtjy2afLlvNe
X-Google-Smtp-Source: AGHT+IHVZEKHlEswOX5OCc1QRZakfm90tzT12Po7rI2xlHzceNCuiSGkBBA1efBixR4l+M9gq6fh9RiwtFmBEo54yDs=
X-Received: by 2002:a05:690c:25ca:b0:70c:cbef:df24 with SMTP id
 00721157ae682-70ccbefe213mr56246447b3.18.1747642770378; Mon, 19 May 2025
 01:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430124758.1159480-1-bigeasy@linutronix.de> <20250430124758.1159480-2-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-2-bigeasy@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 11:18:54 +0300
X-Gm-Features: AX0GCFtwBsLFjXBd32Ez6uitmmBx_lBhripiRgNhztcC93mzeZogx-11fGgxn3Y
Message-ID: <CAC_iWjLwssHzyn83XO_XJV8kYBbz76NOsSE2cT90aKPzGLu8aw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/18] net: page_pool: Don't recycle into
 cache on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian

On Wed, 30 Apr 2025 at 15:48, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> With preemptible softirq and no per-CPU locking in local_bh_disable() on
> PREEMPT_RT the consumer can be preempted while a skb is returned.
>
> Avoid the race by disabling the recycle into the cache on PREEMPT_RT.

I am not expert on PREEMPT_RT, but this sounds reasonable.
Did you have time to test this at all? There's a kernel module Jesper
originally authored to track regressions, which unfortunately isn't
upstreamed yet [0].
Any chance you can quickly spin it to get some numbers?

[0] https://lore.kernel.org/netdev/20250309084118.3080950-1-almasrymina@google.com/

Cheers
/Ilias
>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/page_pool.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7745ad924ae2d..ba8803c2c0b20 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -805,6 +805,10 @@ static bool page_pool_napi_local(const struct page_pool *pool)
>         const struct napi_struct *napi;
>         u32 cpuid;
>
> +       /* On PREEMPT_RT the softirq can be preempted by the consumer */
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +               return false;
> +
>         if (unlikely(!in_softirq()))
>                 return false;
>
> --
> 2.49.0
>

