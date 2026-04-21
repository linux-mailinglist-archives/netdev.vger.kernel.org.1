Return-Path: <netdev+bounces-280083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COlfJzBe52l87AEAu9opvQ
	(envelope-from <netdev+bounces-280083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C043A12D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 828D830387F0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C87A3BED44;
	Tue, 21 Apr 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU9jm6kG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A43BE643
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770577; cv=none; b=hmS7LYtYYR1s6Jkjsy4kn/Ro51cmZZ2v32MlyzS7do0cu0Oqg7Tgi7eMfUw9NQxsIRF0pcZZFNAJrsHjKAmnFp/tD9r8bKlpNgdF2LJyfNO40GvVknfnzNAWKTWxRpxhSR+xFNExNK282YhTXTdS/r2d+7GYZ37Lv26CI9DuuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770577; c=relaxed/simple;
	bh=7J5sLUyTcEtZ5b/o54KJz2TjlXrWGH0W+oigsdVGJYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUgGYf8bFOxHA9Eb/ampr15QFqEmWhSb8pURCrmCmkH/AU7I2IByR3Of9HvBTB+/3/VMFcBHphsCvfk8HUtt4l1xzFT7eGwZiohA4OqmRcrJdLZaJhc9gj0fYyUrUddDSFYyYb3/8w8e4+hVpIZsXjWP67QLsJU4vt5xc4wWzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU9jm6kG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f943870baso1460248b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770574; x=1777375374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=lU9jm6kGqDjqxIjkWxGDeqDvr17UMQYeVNP9rS5P3UWd7+VE4cpTrRwlYKSpCHI1KD
         zZA4+dsX0fyXlhWGoGhioT7GlAk6Cad2+kFgyXXf+ZkLjXgYuVSOk6W9JhbsksRhS+cn
         JjoUEw79Nz86BTgOmxYEMCIS5sQKYiwZ5dfniI9hbARcbUXmygsWFT4/6ZYrU7er4B5b
         AF39CTz+lEumwPTp8qh8DUlpS3e4Z+amiPfglYGt2PS3FjwfgzzvqXLqKOW/KsOHooqZ
         aJdiZQCu+ux924UJHp8L48osT1cgJGdd6A/cCTA6wbL1kWXsoMldHo20OThek5XInH4F
         NHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770574; x=1777375374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=RqN0c4vbQKUN2t0H4Xy2ozhrZQI2/yUsgBP35v5fxRvS/MmsVTt1YG5EL5peD/RmHQ
         X+SOpEQRLLZCIO2GvSDoLt6s76xnsQ5bDq5VXAxd3SWD0xmX48JN2zLC8R9T2saTxTOt
         CECom74XJkwoOmsos5v9OGwdc3TmJKOTtmT31qr3USXgokKCUQIGWWk3Kck3c5LXC5uh
         NGMcSqwAP9fGiwcP5Ii4qBzZLvguFjQAGCU4J84ZO9r/e1H/CyMKMMT+xQepPLimxAQ1
         YRct+1zxzcn4hMrdy38dy6Q+Q7LPK+BeDB0MmXrYOqi2hzic2V5gclkF8QBlc8+GP8nF
         K2mQ==
X-Forwarded-Encrypted: i=1; AFNElJ+N0BGT55q1UgD9RN9vvAE9oaJS2zbRYLIrDYKXOmF7CCWgbnSxBcIhbtJsJDC5YzL/5syRuQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNqfHTto1J0HICTOcZi2ZwoqTFiaGXYIBUJV0KJzBKNYZCdkN
	lYPGJz7I12a65JZnVt/lecErDtEjRtw5E3uScluM05f2sndyYYs/I/1+
X-Gm-Gg: AeBDievrhYU1bTuerYOdgz0j0e8o3nydFimKwYYYzvLH9lBodHtJT7mF9hzN2kvINru
	3bm/1LwZLo+AUcu22SKA4W1sRH4y/KgKjhqrAOQ3oKzcyHg5ZIZyzhIExLb3PH7VC5+wbsCb3ro
	UHlkR1Wo4xXTPIW34GWXgj3/mo5kSA6R2QaQutznv7iJsDHrBIjfGhe91pph0TKB1JMYpQDfjPv
	1vstd8Lzmub4Legf4XkldEjR0RPF4oKa27RWmjwmlFop0wkzuSF9I6qgLOnmoMc9b6f0dRT0DWx
	0LiTLfKkEmN0eO8q28dCatZcj5gFLfGB+SQgMO/XaIgJLazIhxYs8AYo2KyR7zB6Ui+rTffSHnc
	H0G0ZlMb5V+lm/RzAsXRd1BK9BemhlLQN6qC9iskq3kG9mCJ3x8Yddc8xKTKsF+6DtYAe9If9b5
	gLWp2f8f4n3fMoJ2c4iNTxNlGz4w4JdnxvgJlc6iLqomnhKDfqjQBomm99dLmW8V0hv/WRqBdh6
	LdQLA==
X-Received: by 2002:a05:6a00:6988:b0:82f:aae5:c7a9 with SMTP id d2e1a72fcca58-82faae5d438mr7228492b3a.27.1776770573719;
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm14155014b3a.3.2026.04.21.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:52:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, 
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, 
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 33/38] powerpc: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <aedc9UddBSYXzrAj@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.789114053@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.789114053@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280083-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,lists.ozlabs.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,linux.ibm.com,davemloft.net];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkchauras@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ozlabs.org:email,li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com:mid,ellerman.id.au:email]
X-Rspamd-Queue-Id: 181C043A12D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:21:09PM +0200, Thomas Gleixner wrote:
> The only remaining usage of get_cycles() is to provide random_get_entropy().
> 
> Switch powerpc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
> 
> Remove asm/timex.h as it has no functionality anymore.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/Kconfig              |    1 +
>  arch/powerpc/include/asm/random.h |   13 +++++++++++++
>  arch/powerpc/include/asm/timex.h  |   21 ---------------------
>  3 files changed, 14 insertions(+), 21 deletions(-)
> 
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -150,6 +150,7 @@ config PPC
>  	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTDUMP
>  	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_RANDOM_ENTROPY
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
> --- /dev/null
> +++ b/arch/powerpc/include/asm/random.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_RANDOM_H
> +#define _ASM_POWERPC_RANDOM_H
> +
> +#include <asm/cputable.h>
> +#include <asm/vdso/timebase.h>
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +	return mftb();
> +}
> +
> +#endif	/* _ASM_POWERPC_RANDOM_H */
> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_POWERPC_TIMEX_H
> -#define _ASM_POWERPC_TIMEX_H
> -
> -#ifdef __KERNEL__
> -
> -/*
> - * PowerPC architecture timex specifications
> - */
> -
> -#include <asm/cputable.h>
> -#include <asm/vdso/timebase.h>
> -
> -ostatic inline cycles_t get_cycles(void)
> -{
R> -	return mftb();
> -}
> -#define get_cycles get_cycles
> -
> -#endif	/* __KERNEL__ */
> -#endif	/* _ASM_POWERPC_TIMEX_H */
> 
Build tested for this series with allmodconfig and allyesconfig on ppc64le
machine for ppc64le.
tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git getcycles-v1

Boot tested for this series on powernv9 qemu, powernv10 qemu and pSeries
power11 hardware.

Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


