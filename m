Return-Path: <netdev+bounces-250895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F99D39776
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C527D3007C8C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26E3321A5;
	Sun, 18 Jan 2026 15:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A539F21C160;
	Sun, 18 Jan 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750330; cv=none; b=JzheyXp0oC8nFu9GcZxIb0Od1mQJttABrtkhKSYgI+aN/qTsPpnB09V5lMVAE/hxYsVJRJxIRYtgpaqpVMedIt0O+Dc6hhNYbhGMPvu41MtHnbmIZf9wCPkH/p8/eN3Q2om5iX0w5522v8TCW/jro6/e22s0w8O2SUJ4TW4zCs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750330; c=relaxed/simple;
	bh=NUoeAYTwLiNWnM2ibyM/LH52ykiY2OZkZtFEvf/KkFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW+aPbyRdsYSMDGtn7XKARfopNIxlKupgnjGZiwX2uPRPSyKoArO2tAQxCff768Qle6XqIVGJPA1uyTQ3+ljXAqX4UoSPYfkZYZYnDoadQ++SlENG/LAOJAHEykw5NlvBo2RODOa52tNbrdr2Plr5f/1tEqKN7LyK41n4BDrBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 633D1602D9; Sun, 18 Jan 2026 16:32:06 +0100 (CET)
Date: Sun, 18 Jan 2026 16:32:05 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <aWz89X0y6UNH59I7@strlen.de>
References: <20260118152448.2560414-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118152448.2560414-1-edumazet@google.com>

Eric Dumazet <edumazet@google.com> wrote:
> -#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> -static __always_inline
> -#else
> -static inline
> -#endif
> +static inline_for_performance

..

> -#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> -static __always_inline
> -#else
> -static inline
> -#endif
> +static inline_for_performance

..

> +#ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> +#define inline_for_performance __always_inline
> +#else
> +#define inline_for_performance
> +#endif

Should that read

#else
+#define inline_for_performance inline

instead?

