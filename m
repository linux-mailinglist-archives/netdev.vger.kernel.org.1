Return-Path: <netdev+bounces-95923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A568C3D88
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440B0B2267F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE61482EF;
	Mon, 13 May 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5kz7xcE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FD146A60;
	Mon, 13 May 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590185; cv=none; b=Z0GGZW27O1fw+3hwknv37azaKZQvFHFxjt7mky3GzfFTv7LWeEA63/c/rd33fMNaz5aI0j5OP3MHh5j+vXyiNiTtT/fUystGTZVT3S4thVPiDo+6JsgUjRw7JtpKyYgKpz9FXKi8vLyagFr0uOERnryZzvQ1D4huJNAYwsjen6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590185; c=relaxed/simple;
	bh=pqlWwJSnxCSApFWf+ztJT4c7t6r3Hc8iW0XoiL6wxdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoWz3VONz5V5fcouW5+rzMs55YL9Lg/ep/zfAz9TH6IBXbQxKyRMRV6Z3ijRYzu8tH1ZSpKoNuWxKv5dHOMUnHemW1fgYNBkILNZDWV9iwFPdn9BzWv43ygD9/q+9FGASV7rYau/uEp/oL7iwMZbM/rX5GTzkZWuRvtOKpysf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5kz7xcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23705C113CC;
	Mon, 13 May 2024 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715590185;
	bh=pqlWwJSnxCSApFWf+ztJT4c7t6r3Hc8iW0XoiL6wxdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5kz7xcE1JuAlXTQx6ICnJobXlPEp3jb5/Pok2Z+JaHVqoStZ72IeRM4Pri008gV3
	 2Eje3UHILieLxm2tCiZQEdUTaxtpBq7m37eqkGOXVErZT2kLtEHjn3AJhzPLhFJ1YD
	 KXpU3510h2KbImijQjYdEU0W8LWO7K4HPDFUiTTSlzTLfPCRJTjvKEtiYHKtMJS/n/
	 TY8ZqCgnSvG6bVqufSozIQsdqxq8XrGqZyX1AU3Y2RZKvNML19srIs+MyLjlmOsrCB
	 X5EY4QUNDd+5X28oqh6Bv94IgQRzAD4NGo3OOFLO9e9xQtHQV2YlcuxWn3SKi96b6S
	 1KyE2gQ0hhRZQ==
Date: Mon, 13 May 2024 09:49:39 +0100
From: Simon Horman <horms@kernel.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] net: prestera: Add flex arrays to some structs
Message-ID: <20240513084939.GA2787@kernel.org>
References: <AS8PR02MB7237E8469568A59795F1F0408BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237E8469568A59795F1F0408BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sun, May 12, 2024 at 06:10:27PM +0200, Erick Archer wrote:
> The "struct prestera_msg_vtcam_rule_add_req" uses a dynamically sized
> set of trailing elements. Specifically, it uses an array of structures
> of type "prestera_msg_acl_action actions_msg".
> 
> The "struct prestera_msg_flood_domain_ports_set_req" also uses a
> dynamically sized set of trailing elements. Specifically, it uses an
> array of structures of type "prestera_msg_acl_action actions_msg".
> 
> So, use the preferred way in the kernel declaring flexible arrays [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the attribute used is specifically __counted_by_le since the
> counters are of type __le32.
> 
> The logic does not need to change since the counters for the flexible
> arrays are asigned before any access to the arrays.
> 
> The order in which the structure prestera_msg_vtcam_rule_add_req and the
> structure prestera_msg_flood_domain_ports_set_req are defined must be
> changed to avoid incomplete type errors.
> 
> Also, avoid the open-coded arithmetic in memory allocator functions [2]
> using the "struct_size" macro.
> 
> Moreover, the new structure members also allow us to avoid the open-
> coded arithmetic on pointers. So, take advantage of this refactoring
> accordingly.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Reviewed-by: Simon Horman <horms@kernel.org>


