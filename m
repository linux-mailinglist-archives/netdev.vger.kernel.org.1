Return-Path: <netdev+bounces-63428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD282CD9F
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 16:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DBB2251C
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3C257A;
	Sat, 13 Jan 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHN4GkHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C72564
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 15:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01E0C433C7;
	Sat, 13 Jan 2024 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705161387;
	bh=JP90HmKryrppomkNXTQg91TpcvYt4x4E+ciK3w5Ys74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHN4GkHYTvuQW7YZNeYz+G8t2+SLyNuP2n8xqSlPCFldWYdHP+nbierDnUbVzcdXF
	 rk8+eGJNDXEVKxf7jPUs9cwQgAcVjSIBkU9IGLl0wbSgSZrpuSw6H9/Rk8oioICm8W
	 MlOLlzFoUVb1VPznlMl38RvzYffsNiUDPRUsE0Bb2GxI3BAW6/HD05dejhVm5e9nbn
	 zsQVB/PZI77xAOeVUJIF8VE1GY8pl3O63Px7KAssR7QZYZSLf66bFv6DMtDpG3qo6j
	 GJaNgyyQD51jsQmD4EPrS/8dOMOZt12v0VqEi/c/+I2+LR5H3ZPgtHvZLXdk6G2dAX
	 KQ71yQLItohjw==
Date: Sat, 13 Jan 2024 15:56:24 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: b44: fix clang-specific fortify warning
Message-ID: <20240113155624.GJ392144@kernel.org>
References: <20240112103743.188072-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112103743.188072-1-dmantipov@yandex.ru>

On Fri, Jan 12, 2024 at 01:37:33PM +0300, Dmitry Antipov wrote:
> When compiling with clang 17.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
> noticed the following warning (somewhat confusing due to absence of
> an actual source code location):
> 
> In file included from ./drivers/net/ethernet/broadcom/b44.c:17:
> In file included from ./include/linux/module.h:13:
> In file included from ./include/linux/stat.h:6:
> In file included from ./arch/arm64/include/asm/stat.h:12:
> In file included from ./include/linux/time.h:60:
> In file included from ./include/linux/time32.h:13:
> In file included from ./include/linux/timex.h:67:
> In file included from ./arch/arm64/include/asm/timex.h:8:
> In file included from ./arch/arm64/include/asm/arch_timer.h:12:
> In file included from ./arch/arm64/include/asm/hwcap.h:9:
> In file included from ./arch/arm64/include/asm/cpufeature.h:26:
> In file included from ./include/linux/cpumask.h:12:
> In file included from ./include/linux/bitmap.h:12:
> In file included from ./include/linux/string.h:295:
> ./include/linux/fortify-string.h:588:4: warning: call to '__read_overflow2_field'
> declared with 'warning' attribute: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^
> 
> The compiler actually complains on 'b44_get_strings()' because the
> fortification logic inteprets call to 'memcpy()' as an attempt to
> copy the whole array from its first member and so issues an overread
> warning. This warning may be silenced by passing an address of the
> whole array and not the first member to 'memcpy()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This patch is for net-next, when reposting please annotate this
in the subject.

	Subject: [PATCH net-next v2] ...

[adapted from text by Jakub]

## Form letter - net-next-closed

The merge window for v6.8 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens on or after 22nd January.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

