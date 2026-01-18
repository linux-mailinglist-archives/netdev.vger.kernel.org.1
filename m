Return-Path: <netdev+bounces-250919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B842CD3999A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 20:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 638813008FA8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 19:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FC1AAE13;
	Sun, 18 Jan 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lOGx5lhC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C300CA4E;
	Sun, 18 Jan 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768765645; cv=none; b=ioQKFrWOXPHG2y0905eGe9Qj07IWZSk433ehGPTOa55XY8IZrhPYdZ77+BfiMME3NMTZ8UhxQVwRj9BsASlBehZ+GijvwAUCU9sTPqc4hK4+122uv6Vs0FQitIkq/dmx5Uqu2mNKklnKpNT4DavqHUY/DVPz31p+iEg/HVRuzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768765645; c=relaxed/simple;
	bh=vUzjgbm0D4u8uUB+cP7JQ1rJKEMnH4LcAXAXOSwptbI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DAiZcsRtCzN24eFhLjrWGNvg69ocv0vWyohCgvHGujQNjFv2OuRpRZOwxQKQ7ZrHgMlN0ghi0Bpk/QIoMaRvsb1o3EX0QBOZcvv9IiQ3zVytIMnpTFCFVgzRkFC4d+HSlVlF+hCAGuKe05ORrD5URGCQPXFQdSBIdUttuI3cymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lOGx5lhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A7C116D0;
	Sun, 18 Jan 2026 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768765645;
	bh=vUzjgbm0D4u8uUB+cP7JQ1rJKEMnH4LcAXAXOSwptbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lOGx5lhCmbXPXMJ55k+rLvjOMXEEV6nnae1xuNyXciyQ0mJ1cXDQWhitqJU07CFFN
	 zIg5yg32ok9zTuR/q4ddzkAGOCgAD9IHYEnG8OddMDbMYwk9AlPO9aJYvWmANemJ+z
	 vPuSDQC4fj28DO1syDXS+v/3yNoz8FyrjPnjMHDQ=
Date: Sun, 18 Jan 2026 11:47:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-Id: <20260118114724.cb7b7081109e88d4fa3c5836@linux-foundation.org>
In-Reply-To: <20260118152448.2560414-1-edumazet@google.com>
References: <20260118152448.2560414-1-edumazet@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 15:24:48 +0000 Eric Dumazet <edumazet@google.com> wrote:

> inline keyword is often ignored by compilers.
> 
> We need something slightly stronger in networking fast paths
> but __always_inline is too strong.
> 
> Instead, generalize idea Nicolas used in commit d533cb2d2af4
> ("__arch_xprod64(): make __always_inline when optimizing for performance")
> 
> This will help CONFIG_CC_OPTIMIZE_FOR_SIZE=y users keeping
> their kernels small.

This is good.  __always_inline is ambiguous and the name lacks
commentary value.

If we take away __always_inline's for-performance role then what
remains?  __always_inline is for tricky things where the compiler needs
to be coerced into doing what we want?

IOW, I wonder if we should take your concept further, create more
fine-grained controls over this which have self-explanatory names.



mm/ alone has 74 __always_inlines, none are documented, I don't know
why they're present, many are probably wrong.

Shit, uninlining only __get_user_pages_locked does this:

   text	   data	    bss	    dec	    hex	filename
 115703	  14018	     64	 129785	  1faf9	mm/gup.o
 103866	  13058	     64	 116988	  1c8fc	mm/gup.o-after



