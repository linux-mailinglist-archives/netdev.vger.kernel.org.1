Return-Path: <netdev+bounces-194396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A7AC9304
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B79E36DE
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2E2367B2;
	Fri, 30 May 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlnLOxFI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EC236437;
	Fri, 30 May 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621280; cv=none; b=CuIwj5lP6HJU7pL/qQW12uuezM7RWMlZkryQ+vjZDFQIWI+DcCQnCnLkPGkNNqUorSDgbX31TLa+kFhnKeC5zbFUfXU99W+StTmXtIfFqvikN0uJyafkOESqdlSp4dpT/E6U3qHTSiN110fxgSZa4ZGV9LviY0Hn20V+Xvrh7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621280; c=relaxed/simple;
	bh=Inb1kviOqQiEmcA+XeViesPYtcihXynLI6yqhzJItKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQjFYQwpWE9c2N+BNB/x3s+xHzcUULbPZ8Y14Qthslfhm+BN9NzY+i5UEn8svgALINVCU0XrWbiSsgNH6z6Sk3YunEm2DCUM6N/lIegMdjIquBDrlGYUgWzdmYDh0L4ssoppQAOrg3QSNJwdCPi/PNDfKqT+alY8TWy20offGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlnLOxFI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2490831b3a.2;
        Fri, 30 May 2025 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748621278; x=1749226078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iQizrFHn2j72N7TbyO8d92EW8NfJHQh8LpbULUE74U=;
        b=YlnLOxFIQ04WTx7Axup3SMcW1OdUxwOqMVKJJoj0yj0iV+LE9pTYXfgtiBMzy1Q7dm
         fSCLxrp6JTVL7od0fEob9nBpZC87SWhh5vSZrTn/tD8vWhCjyAoDwLcCO8cO9IPk2bFn
         oIoKLXhTliTi5pz5b4KICoVKdBKaY6DP24zDOvd/e5m3dgbdaRtzVkarj+1D0nnlQYql
         eWyi9hLe4cfLVFlcvLWNcpVdOyBfn25qOLN21/LTdEqd/KQrUEXIGtVZlhvGtqTXfJgZ
         jB0JUeFjTxp9yKzuP1U1I3vtOgCpI6G6IoUq5xE2Ao/r2/XFvkZ9vSLI8HQxkETJf88L
         fIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748621278; x=1749226078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iQizrFHn2j72N7TbyO8d92EW8NfJHQh8LpbULUE74U=;
        b=UQHILJ62tU3rrtjNIjPVgAhMpyrzg9wOov4/HVvX5ez9hiC8YFcAlTU9FYVm6xCUpW
         kDcpKutUwHYiQv/XAFahXGF2TMb2qzUXEIHcKF82oXBaaOWWGXgKcVmSs+eeKO/Bk8nL
         vr8gGskW1OXg3LZzdI62VnZJ7vtU40XEcsZbOwCAXbrpMjF143RHhTlztzzIBhZvR3O0
         lkgWgpRuLwPuPaC9An2vW7hCBKc7EyooImmP4JGanWTl1eSg232eYbiXLMvTQSNsZFCf
         oyGjeEEWRx2EMtBF2b/JUAK5tj6CU0FEytZ1AyxVu/xzX/9eoVGp65cm+5ImK0P/mXaN
         q21A==
X-Forwarded-Encrypted: i=1; AJvYcCX5fZPeAlI2gHebPbPGwwFCfX6ocHhE0IFqyhcSJpmgb/cDhbYecSnp+e4u5PWEo/u5SZ1k/ocaeMxyCe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HA/LGNrK7UIkaxZ+MBgM8BLy0YxGkt71x0DnmEIz6MSkK3OH
	/C+MMdyt3Vevgi3M8SaNgI7obcSz/HbXyny8vfKjy4dlExz65hHzSeI0VTE5
X-Gm-Gg: ASbGncv7bn6xxqvQoEqZkF88JxnZeKqi2HTpJ6gfwUMBZH1cfKS+dkR3S+XABKzzt9y
	auPHeoh0UyTO1Pof/2SvzDJQat8wPIj3J9ezchIPZIC0GX4Twouqp/ygNXxhBJ9pUGj8lRvF+qe
	snKBpH4qIV7rmrqkM00/8JHY0tQlo+JbGOVPmN0DRoi8YBzgjOYgaKOVsLxP5C+Tbu7bUumCNDB
	RP7muKsTxCcNQ+jXIlm01apIwYRSAHWspZA90Zd0kBNLDsm3e5qsMBvq7x9iZuDgG67Xtui3M8z
	t2jXvejwvBlKUJ04QyOviXZuKd6clI5hPhoc+CwsrVuei4nqzT45sWWo6ddI095jKoj+uyQjuht
	re6piUZP0T21T
X-Google-Smtp-Source: AGHT+IHq9TGw0Pj+J5N8Oj9pPyP1d5xKHxwpwOg1osFyvVXdH/FEpY2k0hJZIS72mn+RWLkZe9RdMQ==
X-Received: by 2002:a05:6a21:6494:b0:1fe:90c5:7d00 with SMTP id adf61e73a8af0-21ad978cf8amr5827758637.28.1748621278230;
        Fri, 30 May 2025 09:07:58 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afe966easm3240447b3a.4.2025.05.30.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 09:07:57 -0700 (PDT)
Date: Fri, 30 May 2025 09:07:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "e.kubanski" <e.kubanski@partner.samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Message-ID: <aDnX3FVPZ3AIZDGg@mini-arch>
References: <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucas1p1.samsung.com>
 <20250530103456.53564-1-e.kubanski@partner.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530103456.53564-1-e.kubanski@partner.samsung.com>

On 05/30, e.kubanski wrote:
> Move xsk completion queue descriptor write-back to destructor.
> 
> Fix xsk descriptor management in completion queue. Descriptor
> management mechanism didn't take care of situations where
> completion queue submission can happen out-of-order to
> descriptor write-back.
> 
> __xsk_generic_xmit() was assigning descriptor to slot right
> after completion queue slot reservation. If multiple CPUs
> access the same completion queue after xmit, this can result
> in out-of-order submission of invalid descriptor batch.
> SKB destructor call can submit descriptor batch that is
> currently in use by other CPU, instead of correct transmitted
> ones. This could result in User-Space <-> Kernel-Space data race.
> 
> Forbid possible out-of-order submissions:
> CPU A: Reservation + Descriptor Write
> CPU B: Reservation + Descriptor Write
> CPU B: Submit (submitted first batch reserved by CPU A)
> CPU A: Submit (submitted second batch reserved by CPU B)
> 
> Move Descriptor Write to submission phase:
> CPU A: Reservation (only moves local writer)
> CPU B: Reservation (only moves local writer)
> CPU B: Descriptor Write + Submit
> CPU A: Descriptor Write + Submit
> 
> This solves potential out-of-order free of xsk buffers.

I'm not sure I understand what's the issue here. If you're using the
same XSK from different CPUs, you should take care of the ordering
yourself on the userspace side?

> Signed-off-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Fixes: e6c4047f5122 ("xsk: Use xsk_buff_pool directly for cq functions")
> ---
>  include/linux/skbuff.h |  2 ++
>  net/xdp/xsk.c          | 17 +++++++++++------
>  net/xdp/xsk_queue.h    | 11 +++++++++++
>  3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 5520524c93bf..cc37b62638cd 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -624,6 +624,8 @@ struct skb_shared_info {
>  		void		*destructor_arg;
>  	};
>  
> +	u64 xsk_descs[MAX_SKB_FRAGS];

This is definitely a no-go (sk_buff and skb_shared_info space is
precious).

