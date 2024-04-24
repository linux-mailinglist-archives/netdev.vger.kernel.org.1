Return-Path: <netdev+bounces-91106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99138B1661
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 00:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02222843EE
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5729416E88D;
	Wed, 24 Apr 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ip2IuUZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A616E874
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998711; cv=none; b=k5GdRAfaC53fdyo1bq3sXfEOLeMFp/sFyRTyirycnRGNMbuBoP5IZJBmmCl05uBd+rsfnaXpw2itieXWmI92HJbKPx5/B0UJJAokf3jjDWYFXS7qe80IGri0VPV/JIfgzvKpwAdUlg7JtXQOlQtWwJ6YoNDlk3t6vcELb86cRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998711; c=relaxed/simple;
	bh=PesUfngxJz9TzB+RXrKPi6gidufT5NJWBpNfqP6UeSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6n1MZlRS9XdoFSV5sesHKvlHsmJ9l8A1kQuvFB7IAoDXsz7ImFtPTvbNfhQMBZ4fwy1Fr9ID190/2fbheqS2e1S3t4ZFG2OfXvv2D/cZbVhDB0whDR6ozCB+dEVdyX1HeziE9Lzo+2TXnoadkzU3hKPuKmA5t/2Ar+eMab3y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ip2IuUZ5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso373788b3a.3
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713998709; x=1714603509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=Ip2IuUZ5LfeaeG8LgTT7FPRSNVprS1WtQ8j+0rOBMsdFH8RkkiUSJdxlYmcWm0keco
         D0VyxtpaYBK3q8eO/87uN8z81J/XdcHp44mFnYRtTQyLFhhWKfvbInbP/sym7rPhnNN8
         73IKrRKCZtycqCXOrZtxQ2k6kD6uCr8YzTm4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998709; x=1714603509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=oteRLuhPISLPAezM/inU9OBvZQIndjkBhfTWGOnQY39TirnV4Kl/OXaCp2Xh/m0KIU
         zd54XGeY6a3r3nfksWA3yhW++hSG6hfVET7jew04GxmuqHN1bdzOFAUWMgZxyopYgOA8
         oYkiGu6w8HqoWQY+pquaXkFA5WJWVdUJ7ptY/VWf/SJuqGcaonkJFBt0P73NOPWROG2Z
         iHEAwobiIh16bZvHcQxGJALaP8MbU2imob1/AAtXvrDTphJDa7g0/i07WSHv+wFjgSoz
         xQWmPkuPAM1R0tNXXiEWyE7+SA+CSo0Bq4AnA2zw43kloRVdoqNxCKE5IjB5/SAlIJwI
         DW+w==
X-Forwarded-Encrypted: i=1; AJvYcCVxAcsHu9b9j3b29DbGN+9VUelZmbdp8W8lSOCLjqYbc4pmRm9hgrBVvXAVcZCEL9uPtneaYE0R2PPk9VNMVcBDbukxD8+3
X-Gm-Message-State: AOJu0YyTUzc/In1Vhd6b8v3JIqZd1GWVpHEmmgbhXpg+kK7hSGE9SUM+
	KP3IFvKa6qoa9vLle5KvApgTWOHedJrNJCL0yVBQxAUfcmlZhBJYGBDDlQSTiQ==
X-Google-Smtp-Source: AGHT+IEAjXKcOqWbmJBmZ5dMg2rtYhG1LF2zwzQbtnGchw8LS/JZuvVMQDMhTtYVw79O2YlLzJPAxg==
X-Received: by 2002:a05:6a00:4fcb:b0:6eb:2b:43b4 with SMTP id le11-20020a056a004fcb00b006eb002b43b4mr5470380pfb.27.1713998708861;
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ln2-20020a056a003cc200b006eff6f669a1sm11902767pfb.30.2024.04.24.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:45:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202404241542.6AFC3042C1@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224141.GX40213@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> 
> > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> >  
> >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> >  {
> > -	return i + xadd(&v->counter, i);
> > +	return wrapping_add(int, i, xadd(&v->counter, i));
> >  }
> >  #define arch_atomic_add_return arch_atomic_add_return
> 
> this is going to get old *real* quick :-/
> 
> This must be the ugliest possible way to annotate all this, and then
> litter the kernel with all this... urgh.

I'm expecting to have explicit wrapping type annotations soon[1], but for
the atomics, it's kind of a wash on how intrusive the annotations get. I
had originally wanted to mark the function (as I did in other cases)
rather than using the helper, but Mark preferred it this way. I'm happy
to do whatever! :)

-Kees

[1] https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook

