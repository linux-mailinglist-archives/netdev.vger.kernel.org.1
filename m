Return-Path: <netdev+bounces-53138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21A80173B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FBA1F2103C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22D3F8CD;
	Fri,  1 Dec 2023 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nqf6Ie2N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F717D2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 23:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4989AC433C8;
	Fri,  1 Dec 2023 23:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701471739;
	bh=eSWVNATT+XifQVmkfF8oCMewQGql+i3BEy2GutPybjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nqf6Ie2N9l8fkPoJnTZQawM6HymZQluMsu/nWpZjLAedROBEamy157jgZkKgQ3Mpn
	 zw7qpfdxXmYJKDlmcrQz5d1Aax+Pat/jVi1yfWsI0pivSWyFFqgMmKBGox0WQ/g5OQ
	 oFPud4OQZhd0whAeGMq8+yqKLX7VzfqFO/AYEi14=
Date: Sat, 2 Dec 2023 00:02:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org,
	"The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Subject: Re: [PATCH net v2] packet: Move reference count in packet_sock to
 atomic_long_t
Message-ID: <2023120203-fracture-wieldable-484b@gregkh>
References: <20231201131021.19999-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201131021.19999-1-daniel@iogearbox.net>

On Fri, Dec 01, 2023 at 02:10:21PM +0100, Daniel Borkmann wrote:
> In some potential instances the reference count on struct packet_sock
> could be saturated and cause overflows which gets the kernel a bit
> confused. To prevent this, move to a 64-bit atomic reference count on
> 64-bit architectures to prevent the possibility of this type to overflow.
> 
> Because we can not handle saturation, using refcount_t is not possible
> in this place. Maybe someday in the future if it changes it could be
> used. Also, instead of using plain atomic64_t, use atomic_long_t instead.
> 32-bit machines tend to be memory-limited (i.e. anything that increases
> a reference uses so much memory that you can't actually get to 2**32
> references). 32-bit architectures also tend to have serious problems
> with 64-bit atomics. Hence, atomic_long_t is the more natural solution.
> 
> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: stable@kernel.org
> ---
>  [ No Fixes tag, needed for all currently maintained stable kernels. ]
> 
>  v1 -> v2:
>    - Switch from atomic64_t to atomic_long_t (Linus)

Thanks for changing this, looks good to me!

greg k-h

