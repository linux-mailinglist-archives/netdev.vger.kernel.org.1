Return-Path: <netdev+bounces-250929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B4ED39AA8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6401F30096B6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3030FF30;
	Sun, 18 Jan 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGQbiTFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407F30F530
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775604; cv=none; b=TEdmRIzo0bZJcef5Q+8Izv1W8kY66Jgy6dGUWgolFU+pvLiljNXvE7cXeNNxCRB9Q5VNyAJpjFvfjMMGufLmEEEZM042gI/tGHfbXIj819ukHXAeV4cUKQ6y44+OY+NatEjk+jCEIXzSenrYLcn4+SP9zO/a2J11HVvwHRgXt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775604; c=relaxed/simple;
	bh=2SA9QQ673KUOqHEy3/rqWkEDcs6dfPbhevlhyfQOLDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qc5r67GBb8EtUYVhwdn0CqdKmoYGC2Abc2N3BXoq8efDL2Pzh8FhbrWe4hc6DrX1fUuySPPvmc2Azr3CBuS+E3k59keW2hTjkJQvjKkblLVTr/ROCve7B87GaLdFrnnJ0S7PNnyBbhYqUNm4ah2aiIcjEdz41Gp90WVuo/Maj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGQbiTFP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso33066855e9.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 14:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768775601; x=1769380401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx9QpyQrvnFrvxngyHgURZOAcKI8WngXTJ0q+cPiikY=;
        b=PGQbiTFPC94Gcas40p7wRMZXkfgotCMR7be6qG0r2vhERXCGhHntav0iTbNqgIvIMZ
         Ct2n5amTeQZSqIrrh6xyqVpoo3rCc9JnKsWt0ebPH8Hdgm4A0oYyZ5034bBW51FnHaKX
         etgXigCaiE3foyYx1dAJN5HGxR0jVVVx7V5w6hVbSe6tDIdCYIwI6tnzt0pDb9IdBHmF
         RBVHQc14wxoCm5BqCFzazzCLZsFY1I+Hq+aYHqUSbOri3aqW+ppvFxDy0PKLRQaiXrTk
         FIy49boIi9HP9OB0VVkfaaTEkPTvboncxj9eMy94vLCPP3CNP9STYLU9KzcZuqxOK6jR
         UtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768775601; x=1769380401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cx9QpyQrvnFrvxngyHgURZOAcKI8WngXTJ0q+cPiikY=;
        b=EFunersf63ZCEYal1E9pVHyUe7KTSlceyduAaCX8HZSCRBFjkh0wKh4AR5nDo+MTYJ
         gQELUJgVgJZdEuR5omhrSWQcDE9ng0VeeIIVwoQsIN4z6Y+pj9clJIdEGRG0clgChTwj
         boob9JfQnWW0vWdOUVqCpSCjhf9IBPUCkGF2mvwYgP6k2aIpA2q7IINh8LCZ4SlWB+go
         7dpih3ri/rGzm29Mvxry4SBm/gxUnCGjK3P4pzAVSpCGfb7X3AJTFUOSTk0AxR1lyxXp
         ofl9mHFaWRi/RnrNdWxvAjff7VFYTysR01J7q52sJ7vNh/dVxHYbesJaryx0zr65E4b6
         jqbg==
X-Forwarded-Encrypted: i=1; AJvYcCXKDP3dXrJhdfMuHg2+skihqOMmr3QyHWLqBXwwGp6gJ8Cz08QgjHdFLSd+hGXi3r0WyNGoMUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3/Lg2or1hUrtblj3vZxH+leqVKVuIWSMOz38uT7Sh73oAHKw
	lHLy8K2mby037+MEi8+3mwvSBaq/sDbH3p0MKo5telV0HDEfMGyPXQwk
X-Gm-Gg: AY/fxX6RgrMeke35bsj0/9ryQkHmvJC01HafeokMV875I9tO9k5HXdcyvoKT421PW2I
	lZutOQdwUT9+z/TpmV/EUO9P+3xm8j8+k8UZ1X8m8OPtZElRLtlbu/P1iMJvlQ7ygrGvYkkbBCg
	ZVJgQJPi0Kiqclp0tWRkftkg+F67hZajYe/pQ9Mf/sJc3Y4WWX89YcxT6WNdEmfJG6tE7QgLKDF
	IhuUaTDwJ2lpPnk/EvBgf3mmGHEfRxKL3LEuZg6YOuwMMYI4anrdslSGqtrQH3o6x9QMsoYPwWE
	3D4gdcLR89iNF+hYzNcs2fnRE2OvFd2o1y07eC60txNtU+mp4SVHyn/lWRaNZWOXaBb9LaYDmWh
	p0OFfpNsPobuua7alXFR8yWkTKo1r+0VAJmcpZyQrRSd8q2DNL7ZhjsIvS9MEgqgWR9WVKQdOvj
	HYh5r9qZzstbXAQtntKZSSG4XxSWZTkwrYSGgpuEZg2f1GVEPtp+XUS4bupSkCExc=
X-Received: by 2002:a05:600c:474a:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4801eb14b36mr116131045e9.35.1768775600441;
        Sun, 18 Jan 2026 14:33:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2672d6sm218823515e9.14.2026.01.18.14.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 14:33:20 -0800 (PST)
Date: Sun, 18 Jan 2026 22:33:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev, Linux Memory
 Management List <linux-mm@kvack.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <20260118223318.7a3e3837@pumpkin>
In-Reply-To: <202601190247.dDAvbbMH-lkp@intel.com>
References: <20260118152448.2560414-1-edumazet@google.com>
	<202601190247.dDAvbbMH-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 02:36:18 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Eric,
...
> vim +/__arch_xprod_64 +138 include/asm-generic/div64.h
> 
> 461a5e51060c93 Nicolas Pitre 2015-10-30  125  
> f682b27c57aec2 Nicolas Pitre 2015-10-30  126  #ifndef __arch_xprod_64
> f682b27c57aec2 Nicolas Pitre 2015-10-30  127  /*
> f682b27c57aec2 Nicolas Pitre 2015-10-30  128   * Default C implementation for __arch_xprod_64()
> f682b27c57aec2 Nicolas Pitre 2015-10-30  129   *
> f682b27c57aec2 Nicolas Pitre 2015-10-30  130   * Prototype: uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
> f682b27c57aec2 Nicolas Pitre 2015-10-30  131   * Semantic:  retval = ((bias ? m : 0) + m * n) >> 64
> f682b27c57aec2 Nicolas Pitre 2015-10-30  132   *
> f682b27c57aec2 Nicolas Pitre 2015-10-30  133   * The product is a 128-bit value, scaled down to 64 bits.
> 00a31dd3acea0f Nicolas Pitre 2024-10-03  134   * Hoping for compile-time optimization of  conditional code.
> f682b27c57aec2 Nicolas Pitre 2015-10-30  135   * Architectures may provide their own optimized assembly implementation.
> f682b27c57aec2 Nicolas Pitre 2015-10-30  136   */
> 5f712d70e20a46 Eric Dumazet  2026-01-18  137  static inline_for_performance
> d533cb2d2af400 Nicolas Pitre 2024-10-03 @138  uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
> f682b27c57aec2 Nicolas Pitre 2015-10-30  139  {
> f682b27c57aec2 Nicolas Pitre 2015-10-30  140  	uint32_t m_lo = m;
> f682b27c57aec2 Nicolas Pitre 2015-10-30  141  	uint32_t m_hi = m >> 32;
> f682b27c57aec2 Nicolas Pitre 2015-10-30  142  	uint32_t n_lo = n;
> f682b27c57aec2 Nicolas Pitre 2015-10-30  143  	uint32_t n_hi = n >> 32;
> 00a31dd3acea0f Nicolas Pitre 2024-10-03  144  	uint64_t x, y;
> f682b27c57aec2 Nicolas Pitre 2015-10-30  145  
> 00a31dd3acea0f Nicolas Pitre 2024-10-03  146  	/* Determine if overflow handling can be dispensed with. */
> 00a31dd3acea0f Nicolas Pitre 2024-10-03  147  	bool no_ovf = __builtin_constant_p(m) &&
> 00a31dd3acea0f Nicolas Pitre 2024-10-03  148  		      ((m >> 32) + (m & 0xffffffff) < 0x100000000);

Can that ever have got compiled?
Won't the compiler complain about 0x100000000 being out of range?
Lots of alternatives...

If u128 exists this should probably just be:
	return ((u128)m * n + (bias ? m : 0)) >> 64;

Which is probably the only alternative an architecture might provide (none do AFAICT).

	David

