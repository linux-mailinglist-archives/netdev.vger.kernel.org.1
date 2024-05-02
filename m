Return-Path: <netdev+bounces-93045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2E8B9CEC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3425228C1A3
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C08153833;
	Thu,  2 May 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOUi18yF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25052153563
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661825; cv=none; b=dIi+t7zmV88+CMkrofS0z19hIX6RXnv8RcOGwjOCAb7vLJulkbkWV3N35rzFfPqHDkXPrEbDSbAGpvuYPZDrYnd0MsWxfx0v7mHHnbm/KJN2FQEoLTwJP2BQOzfdJdPLB6Y3AptIfLAmlA+F0TDKAarqRwWugDoh1MpEWi+WDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661825; c=relaxed/simple;
	bh=NH4QIZCd1e7ll0ytLJZvsXtnpe6W+YknkMOUe2chw/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5MrC2oXWwELZ2woIZRMC01IIXRcSK2jPfoA7ZctAA+lWBOUd7U/Tnm5ApS1Q/2bHsLtU4sgSq5cIGRwswkTT15TQJ6y7qJPV6zgACP1lwoX9q8ACtAenTOrHgKMot3MgL/36/Rd2ELQtw07dLfBztf0lVj2tmeBtTgqTws+jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kOUi18yF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed627829e6so9393168b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714661823; x=1715266623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ8b7bzfCx6EpLlIeYt5D5YIUVdmKAgE9Z3grYfPDDo=;
        b=kOUi18yFJznxD0I7D2bkIZ7g/Dz5s7ufRd99GwsVKDDJ/1k+Iz8WyCULX0lfMSNvoT
         N/HMqCqJr8xQsdqdS8JzRgFSHfLSqGXlrDFq2HYc1VTvBTvH7JQ2KGDiYJ69ZGa1xpv7
         V8Ut/VQq+OdKe0cQfjViVvID918nnmV699qGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714661823; x=1715266623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ8b7bzfCx6EpLlIeYt5D5YIUVdmKAgE9Z3grYfPDDo=;
        b=QmDYs9okTceNFemogK4PWRTfLMJZRYF31uMTkdG5UGwgEPR0BImS2hX5HXX+QtoOz1
         nSNALYKlc1Pp7s2K+bUUP51yHLMM6MUg/ijkic5fe6MmKEFEAC1yaWxCtfziujiQNsGu
         ZjAHcglqdvs8cZ4M5yEgkTm2Arei2/B3RRqs/Unjju1weZf3EXcHH/M72pcnLLvgdB1C
         4NwuEOyqCYqJ1QYA+XZxq7Eoix8oWioHh5sxQPTUkp8ybgFJxg2mwFS1ngyO/TkwJXdw
         TUDoJyrC9ncZ3p61/gXTXyAVCFKSLOPoRvIVSifYmaZAqOFnATVDZqgBlfP6/WGu8N22
         +lTg==
X-Forwarded-Encrypted: i=1; AJvYcCVD9tZ9t4FqXP2tpcMExJznaFPCZBuTSRimKjz0VSkV+4hfh1q/RaiRGl7vhqSGBemFeZQ2agtEAYJ3ZnBwJiL9EzEFMM4q
X-Gm-Message-State: AOJu0Yy/RlFPiSL5gzT87rP1P9A80x7/nWj7O72DknRmOPit+Drmil0A
	tez4lspACMRJI+GLoK1VJzK6Dlraq36YaF/5QpJ+Qu9Gmi9EgWi0TrVZKkLtNw==
X-Google-Smtp-Source: AGHT+IEY8rfhYcGUjn6fkFZDVe5VtFVRmGTt2Y2qKWiykKokE+sE6ybt9GlDY7wg6G8EAaWAzHcprw==
X-Received: by 2002:a05:6a20:5b22:b0:1aa:411d:a8e with SMTP id kl34-20020a056a205b2200b001aa411d0a8emr5633798pzb.62.1714661823495;
        Thu, 02 May 2024 07:57:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cb5-20020a056a02070500b0061236221eeesm1175970pgb.21.2024.05.02.07.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:57:03 -0700 (PDT)
Date: Thu, 2 May 2024 07:57:02 -0700
From: Kees Cook <keescook@chromium.org>
To: David Howells <dhowells@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <202405020755.0101DBCB@keescook>
References: <20240424191740.3088894-1-keescook@chromium.org>
 <20240424191225.work.780-kees@kernel.org>
 <2100617.1714117250@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2100617.1714117250@warthog.procyon.org.uk>

On Fri, Apr 26, 2024 at 08:40:50AM +0100, David Howells wrote:
> Kees Cook <keescook@chromium.org> wrote:
> 
> > -	return i + xadd(&v->counter, i);
> > +	return wrapping_add(int, i, xadd(&v->counter, i));
> 
> Ewww.  Can't you just mark the variable as wrapping in some way, either by:
> 
> 	unsigned int __cyclic counter;

Yeah, that's the plan now. Justin is currently working on the "wraps"
attribute for Clang:
https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook

