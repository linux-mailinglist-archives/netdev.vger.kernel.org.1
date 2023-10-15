Return-Path: <netdev+bounces-41092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C847C99A4
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 17:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC4B20BDA
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E369C79C7;
	Sun, 15 Oct 2023 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmPkmpkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB84749C;
	Sun, 15 Oct 2023 15:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201E7C433C8;
	Sun, 15 Oct 2023 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697382384;
	bh=VFgG/GeOFjZBpWQhFBCt12gjtE4bL5QgGojqf6ykkEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmPkmpkk8dxofiw/rBxB87ue0PkE1wqtTN/hWDFuBD6+kgyN/F2bsPnDK5VssS0yW
	 YczAhfcBOERdXnuB/NGwNdLd6upUPdXPfNdbVve3NwXWxqvwOk8O4yGbiw2sDA3Fnv
	 FuBYJNZsSjkTgOG1i8r6dpaEbHjIgl9gh4EMG53XP4fbCotfhaR5wKyPpW9xY+fmD7
	 Ya7VX+o7Xi55Q7B89miEkxf9k27VUdfQPm0juny7V7zmWyPNcX1o/mUU0ABKV2KPfm
	 faUxYFIBv5vED/iwT9jvC/CmAlSR1k0l2SdVaq2F8jXIhymnA+RHd1q7CFVKlWN3Z9
	 7j4SGgGJgAy/g==
Date: Sun, 15 Oct 2023 17:06:19 +0200
From: Simon Horman <horms@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Thomas Sailer <t.sailer@alumni.ethz.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hamradio: replace deprecated strncpy with strscpy
Message-ID: <20231015150619.GC1386676@kernel.org>
References: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-hamradio-baycom_epp-c-v1-1-8f4097538ee4@google.com>

On Thu, Oct 12, 2023 at 09:33:32PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both hi.data.modename and hi.data.drivername to be
> NUL-terminated but not necessarily NUL-padded which is evident by its
> usage with sprintf:
> |       sprintf(hi.data.modename, "%sclk,%smodem,fclk=%d,bps=%d%s",
> |               bc->cfg.intclk ? "int" : "ext",
> |               bc->cfg.extmodem ? "ext" : "int", bc->cfg.fclk, bc->cfg.bps,
> |               bc->cfg.loopback ? ",loopback" : "");
> 
> Note that this data is copied out to userspace with:
> |       if (copy_to_user(data, &hi, sizeof(hi)))
> ... however, the data was also copied FROM the user here:
> |       if (copy_from_user(&hi, data, sizeof(hi)))

Thanks Justin,

I see that too.

Perhaps I am off the mark here, and perhaps it's out of scope for this
patch, but I do think it would be nicer if the kernel only sent
intended data to user-space, even if any unintended payload came
from user-space.

> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

...

