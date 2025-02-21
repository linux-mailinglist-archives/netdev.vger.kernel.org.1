Return-Path: <netdev+bounces-168629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA2AA3FE0F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCF418988F4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8232505AB;
	Fri, 21 Feb 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YZvkcRGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25524FC1E
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160772; cv=none; b=noHkDAyw1WMMNpGVBHfLFZtLNFpka8vw+QkwOz+Uh2OQrWoFJVx6xDMF2KWWpTUaNI1mubWKMDL9842cmfYnDGSXEIoaotT5I28u+j7s78FdAsGu1ORhZ8nLb+qtb+cE6wxormpHerMBsFXwLFk9txTbgwhiCosCmPKpq3KXEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160772; c=relaxed/simple;
	bh=Rg+Eu2K/iaZKLCV1bEX16lULBsUzCm/Bpp/hRlrSuGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0jA+qhni29+yrDTLR3Y/pzewZz2gFcTcNESfLBjd4GK7W2XIXup4f/yfN761yf+pJWjS7zuaQrTo78f8V5aR4YsGPOVVUg/Nr1IpLxNkoFPh+5R5QTeKOporTyTvDgdZNMNKQ2dSBw/KlwXwh9UjJbJ2NRNg13aVhn/MA0M1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YZvkcRGm; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c089b2e239so252758085a.0
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740160769; x=1740765569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLb8crReTH8G5XQzUpCmv5c6erOQlEwozixzAzmY5o0=;
        b=YZvkcRGmiAkoTTMvTq6e3GUDG0Sy+RR3WsQtpkl5OlO+m2idJ1cPU60J4Tgn+Li4fU
         9bSfzVrta+nPoJ9Rx6tyXIVAEZlSNFYKqtM0fbF/68zTT3FF+xIzxftsqNls/wINDAx3
         09JyJJnEe4Oqeepd/M7qjtLD52BwjEKQom/rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740160769; x=1740765569;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLb8crReTH8G5XQzUpCmv5c6erOQlEwozixzAzmY5o0=;
        b=p/rcRyA+uEl3Wg6RVzI6t2CQodxr7huiF1+I5JTxJ34RNgW8UVkxGHORZXU2WHkEwM
         /q67gm9NcPE46zSajurqoCVXsBTsRPqlSsaaX52h61lhUbEqE6lExiJRWV2hhJIHXM/6
         Qx7+5IWaKE3/KBJHGCVyra8aSU2gc9giHWwmH5o3S0cbtvJYTRUBnsEgQNPz/9W6wXyb
         ADPVhfVtkKndrXZ15pOQOhnQ7n6feKE/kQcoWhhtzKnprJFtugGL4Og3IuIBU038ZAu9
         9NpcDQFr44vYBT2oKjSPqtG6CCUwZOQ7XQOtwSvmPhoX3JmVvVOi8aIgWalG7yFrD/gA
         6OWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDEUpJVRGw0i6ahEeeVrOq9VWMJ33LGpUndvCNUwrXBvloKG56n3LVIzfmU0iejXocm0E6Ayk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWQg9SE1HKrffFhpid+EHE/FUPglbdsXvVfwd/ZwFiwsOvkap
	xb4rjrSR8lcvFd8OV95dZiiGO9xvWRvNF22bMmJWly5nWNQ3OHwvOhWOMwdQAgw=
X-Gm-Gg: ASbGnctB25JURbvpxMghb5QiF7ES3MxuQIaMZAfPJJXkHtL0429vQtQnurjZ8R6hLkA
	ihoiypU9fjyoHH0cUL4n35VhtZSp8Gx5k7lOYJrhUnmt9i1RQk2omofRKei3MFWSMEDHYcM5OIG
	uVrG0SCwWBPtaCXcnh/41/hzhFIvQc5ZmA0ohmOBIHhYOaDOZVzmRWRFAx7Dnt6xlnm7DiDOy+F
	SFBP6xv1Dw7xtt6ytqH4zsXxpZWtf9o/8LA1Gh7ZD+C3eUiZBoBE3p7GzpdmLapLv2Ntt7V742/
	o0laPPXAR3Dm+4n2fkWnzMqF9Q/Yl36gAom6mPdQxLADnHQjctugMGVl+qmXwTkR
X-Google-Smtp-Source: AGHT+IFymuqeiQwh9aOSDNeLongiyvckhPPNRjiwNf5oRAbqWTcgEvxl2sVwpcX2b5KlcbEpZbteLQ==
X-Received: by 2002:a05:620a:1983:b0:7b6:67e1:b4ff with SMTP id af79cd13be357-7c0cf194c26mr555829985a.28.1740160769186;
        Fri, 21 Feb 2025 09:59:29 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a07aa37asm617171585a.24.2025.02.21.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:59:28 -0800 (PST)
Date: Fri, 21 Feb 2025 12:59:26 -0500
From: Joe Damato <jdamato@fastly.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] net: Handle napi_schedule() calls from non-interrupt
Message-ID: <Z7i-_p_115kr8aj1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250221173009.21742-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221173009.21742-1-frederic@kernel.org>

On Fri, Feb 21, 2025 at 06:30:09PM +0100, Frederic Weisbecker wrote:
> napi_schedule() is expected to be called either:
> 
> * From an interrupt, where raised softirqs are handled on IRQ exit
> 
> * From a softirq disabled section, where raised softirqs are handled on
>   the next call to local_bh_enable().
> 
> * From a softirq handler, where raised softirqs are handled on the next
>   round in do_softirq(), or further deferred to a dedicated kthread.
> 
> Other bare tasks context may end up ignoring the raised NET_RX vector
> until the next random softirq handling opportunity, which may not
> happen before a while if the CPU goes idle afterwards with the tick
> stopped.
> 
> Such "misuses" have been detected on several places thanks to messages
> of the kind:
> 
> 	"NOHZ tick-stop error: local softirq work is pending, handler #08!!!"

Might be helpful to include the stack trace of the offender you did
find which led to this change?

> Chasing each and every misuse can be a long journey given the amount of
> existing callers. Fixing them can also prove challenging if the caller
> may be called from different kind of context.

Any way to estimate how many misuses there are with coccinelle or
similar to get a grasp on the scope?

Based on the scope of the problem it might be better to fix the
known offenders and add a WARN_ON_ONCE or something instead of the
proposed change? Not sure, but having more information might help
make that determination.

> Therefore fix this from napi_schedule() itself with waking up ksoftirqd
> when softirqs are raised from task contexts.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: 354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de

AFAIU, Closes tags should point to URLs not message IDs.

If this is a fix, the subject line should be:
   [PATCH net]

And there should be a Fixes tag referencing the SHA which caused the
issue and the patch should CC stable.

See:

https://www.kernel.org/doc/html/v6.13/process/maintainer-netdev.html#netdev-faq

