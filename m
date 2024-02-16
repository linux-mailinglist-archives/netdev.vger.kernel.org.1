Return-Path: <netdev+bounces-72545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB958587E6
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4581C20E90
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A450E145FF7;
	Fri, 16 Feb 2024 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cK//LtsA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345B145B0C
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118363; cv=none; b=leObBaGVj1BVO4toByrS0EJkrJC70YE0Nx+8H5LZHKD7onhBABOc6xpnSjWmyvPvfKQN8xYy4K2x6I2fDLCsjVtOwp8xEQgCahRIgIOD3DzW+I8HAIRPKAIDHSr+0ms8nwQ/GcsRwgG4kQCqYMeJ6vFH/fbRP+jRVDImqo15fz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118363; c=relaxed/simple;
	bh=pjViwhXqVkFuRcb9TtMCBqAXy9IB1rtSAVc+/tWHUoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRsOXr3HTxulqNFnVihQhOjVFcoE94A18Idfh7r4EdqZ2wnYBW/Y11AsXMYfsB4qJklZuVuqn0Whd7FS3OdUX0YhUDJhsOeldURa34bdxDsUFSLohRmesNhybOx41sl5/13bjt8q3sTQMQ2Cl5EJhizrBdIXoXZ0XO4y+S48IzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cK//LtsA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2155714a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708118361; x=1708723161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Slargkifk+xN9eeRz4eeZrRCV6UdKDbpUow5tWWQ8Nw=;
        b=cK//LtsAUxR2N9tqu1a4AEH4D2i/Y92EaTnzsi/SJFgrT3dL9zfI5+nNd3hAKDw8TP
         momltlpGm0AD7E5gBbFA2Hypdq/fvYQLheII8S3zF0ZQQyVWd6jtMPnlLOzwAUZntsRQ
         G5NCF21aCMVf1iM/jXLB2XOn8k+OuwQmGfaFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118361; x=1708723161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slargkifk+xN9eeRz4eeZrRCV6UdKDbpUow5tWWQ8Nw=;
        b=dgvWqB2i+s+kD5FRsfcvnT8vZbNLiXopsTLAZhEHZVgyhjs6qW2sW/nVEqtsARVas9
         H3dlSM9y5WGBgZygGRs6jlP6Xkr7on5mp4pAFWf6WtfGYH6AjlY9HEbhs0DWmTzNmQbj
         tr6k3K5YeesKgMMr7i0yPCY8sGR5JLyBCLD2PXFSoKUD2vqxoMfIPuvD+iC5IX0H3FmQ
         scekHQ0NfXvFKMg2mwGPEprYDBJ82+gFdTAKYo6DbdGR7ce+ajuDKtPhTT4yVavtFJzf
         CY2tpNDVo0hzml68w6AbF07Dz6i6TKQxNOMGIGIB1hIk0komcGksyACP7k8bGkm18Inb
         dcDw==
X-Forwarded-Encrypted: i=1; AJvYcCUTmCEWlLUGNUWJdP/dKvokq5NPg4zi7pR4i/Xhogk3R3pOel/qaJXEa+2By2qx2M8iuouWstZZ3yggIQuxvNK1H1SGN1p9
X-Gm-Message-State: AOJu0Yw5B7Jz3SiUL6W2jY1XXZ4Y7Cp9S8GMm2hi+rMJ4IIArFaXSBa2
	badm2ivBsmzgvKxN1hZ6lStIUAYhYIfCukoYdnmsQ4eOtdJQoHUP6qruIgaNvw==
X-Google-Smtp-Source: AGHT+IHmIetBf12lZgnCIBsuyMKApScxQdHnKJTRQax45DnTFQUW8k5/OMVTOg+jgfmD8hQL5KfA0Q==
X-Received: by 2002:a05:6a21:670b:b0:19c:9b7b:66a with SMTP id wh11-20020a056a21670b00b0019c9b7b066amr6805585pzb.49.1708118361358;
        Fri, 16 Feb 2024 13:19:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kq15-20020a056a004b0f00b006db05eb1301sm395754pfb.21.2024.02.16.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:19:20 -0800 (PST)
Date: Fri, 16 Feb 2024 13:19:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Raed Salem <raeds@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string
 false-positive
Message-ID: <202402161301.BBFA14EE@keescook>
References: <20240216202657.2493685-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216202657.2493685-1-arnd@kernel.org>

On Fri, Feb 16, 2024 at 09:26:40PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-19 recently got branched from clang-18 and is not yet released.
> The current version introduces exactly one new warning that I came
> across in randconfig testing, in the copy_to_user_tmpl() function:
> 
> include/linux/fortify-string.h:420:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>   420 |                         __write_overflow_field(p_size_field, size);
> 
> I have not yet produced a minimized test case for it, but I have a
> local workaround, which avoids the memset() here by replacing it with
> an initializer.
> 
> The memset is required to avoid leaking stack data to user space
> and was added in commit 1f86840f8977 ("xfrm_user: fix info leak in
> copy_to_user_tmpl()"). Simply changing the initializer to set all fields
> still risks leaking data in the padding between them, which the compiler
> is free to do here. To work around that problem, explicit padding fields
> have to get added as well.

Per C11, padding bits are zero initialized if there is an initializer,
so "= { }" here should be sufficient -- no need to add the struct
members.

> Since this is a false positive, a better fix would likely be to
> fix the compiler.

As Nathan has found, this appears to be a loop unrolling bug in Clang.
https://github.com/ClangBuiltLinux/linux/issues/1985

The shorter fix (in the issue) is to explicitly range-check before
the loop:

       if (xp->xfrm_nr > XFRM_MAX_DEPTH)
               return -ENOBUFS;

-- 
Kees Cook

