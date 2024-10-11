Return-Path: <netdev+bounces-134692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF299AD3B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21C0282173
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866281D0E31;
	Fri, 11 Oct 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De4mju9A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9051CFEB8;
	Fri, 11 Oct 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676648; cv=none; b=EsBPeoN6VXagYkIoD962iAqgdgoybYiXbkkiAEPR4sEX6P2tsJDBilGPcyStOQU5E4fJ+zJIqifXWXAIwBrOlZBsLsPh4i0kzBitqdYWNybL87kRSYsHDw0TvCnuqkVLEOgaygUHsz6LxEMXJyOeHFR4jW7PzfZSCX+80kgGECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676648; c=relaxed/simple;
	bh=0kY+Mb0YPt6YPZrhDjewpkajYVYuLHNl0OMr/sFNip4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/Ztptx1C+0FxLInsSqrSsXxVBZwxRlDotepjiyC6JpoIllpRyYNu9s+NujlAG2yrWCkwsHSFIk4s/zpyxfVxbPpMkzz9rSPFV1J2JAhIFFIg8lbv8B3dW+jXVLtRWw7HZyaUQbOQ++5qAtZvgQBZ9j4RHnoQzko0ZHdjriPp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De4mju9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4462CC4CEC3;
	Fri, 11 Oct 2024 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728676647;
	bh=0kY+Mb0YPt6YPZrhDjewpkajYVYuLHNl0OMr/sFNip4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=De4mju9AiqC9FzbhRKMgdcjqhWs+AY+2a3og8cKJ/l2u636pOCb1jC42FTAZ0APRj
	 mCgyCUzpIis8mtIKmz3MLf9zAnMAwQWyy6n1wx1olm1HEKEag+xjEygYUhi0oDKJH9
	 JREFr/lbuF7zf+foSLm2hm3P8Up43GpUZVJ/BIDtpVReB/mqRzVdn6DegowCUfjbxv
	 du0TN7NQqg2tNyPpy2CPl2P6DV0waUHJbm/MJk5MAnwIdT0Nbk1mqwYUOsrsN81qUq
	 iXxEeZq4AdLbtrpXLdgi/BhBJKj2bW48OWbFBz6XgJkilJKcOv5mU/idAkYkrRd9EX
	 CM9AInv550ekQ==
Date: Fri, 11 Oct 2024 12:57:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <anna-maria@linutronix.de>,
 <frederic@kernel.org>, <tglx@linutronix.de>, <richardcochran@gmail.com>,
 <johnstul@us.ibm.com>, <UNGLinuxDriver@microchip.com>,
 <jstultz@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 RESEND 1/2] posix-clock: Fix missing timespec64 check
 in pc_clock_settime()
Message-ID: <20241011125726.62c5dde7@kernel.org>
In-Reply-To: <20241009072302.1754567-2-ruanjinjie@huawei.com>
References: <20241009072302.1754567-1-ruanjinjie@huawei.com>
	<20241009072302.1754567-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 15:23:01 +0800 Jinjie Ruan wrote:
> As Andrew pointed out, it will make sense that the PTP core
> checked timespec64 struct's tv_sec and tv_nsec range before calling
> ptp->info->settime64().
> 
> As the man manual of clock_settime() said, if tp.tv_sec is negative or
> tp.tv_nsec is outside the range [0..999,999,999], it should return EINVAL,
> which include dynamic clocks which handles PTP clock, and the condition is
> consistent with timespec64_valid(). As Thomas suggested, timespec64_valid()
> only check the timespec is valid, but not ensure that the time is
> in a valid range, so check it ahead using timespec64_valid_strict()
> in pc_clock_settime() and return -EINVAL if not valid.
> 
> There are some drivers that use tp->tv_sec and tp->tv_nsec directly to
> write registers without validity checks and assume that the higher layer
> has checked it, which is dangerous and will benefit from this, such as
> hclge_ptp_settime(), igb_ptp_settime_i210(), _rcar_gen4_ptp_settime(),
> and some drivers can remove the checks of itself.

I'm guessing we can push this into 6.12-rc and the other patch into
net-next. I'll toss it into net on Monday unless someone objects.

