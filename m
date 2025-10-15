Return-Path: <netdev+bounces-229637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD99BDF1C1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4366C19C2624
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF718219A79;
	Wed, 15 Oct 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpDIjLla"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4714EC73
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539133; cv=none; b=Bfv99nwBo8wl/I3XkJlU0o0ev925/rwTiuzF330s4yZRgAPGEl6PG21v3p1RqKpEzq0XDSsPXieh4wtaCIK5R/j8a+0jLd8AWA6H+TGeAAr2i/53oqQzrYKyU9X+sCtWunxXOsAIPHK+3z3W2j8xLINPGlnI1OwMyx13CmgNdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539133; c=relaxed/simple;
	bh=J2jlVNY+Ql6C7yC24t4oJxTsfBnVTegJ+Ra9bugJaqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsbe5JJkL18aueAgu31kVmZdv9dzGH3ozS+yItIqHiPH/EGkHc7KLM8uqKhmJQoHZRF0MWlSrcfvjB+9cIQ3Mn5hC6dMPSXiuDYQ5JKNK+0XVQG9TXQN6ADImREreU6LfhUhVzqxUKFMbWQLUktPXD58FJOp0RLP9Z87VwJJ354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpDIjLla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61943C4CEF8;
	Wed, 15 Oct 2025 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539133;
	bh=J2jlVNY+Ql6C7yC24t4oJxTsfBnVTegJ+Ra9bugJaqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpDIjLlakrDrStn/aCEoMfCMto5rf27dTKyALVmHllkUPgDoq72u8E8355Uhi208/
	 6RIhfZ6vDamw/Ch6XgdoHF3i9EuDYqmem9JG5XaiKPV/ZAH6ilvmr141DfibFU8BPY
	 Ke7PakYbfHxbOnQfU9/DR91LyG8Nvx+goSRfktykzZqqcnISn4uyv67sPmwPPjTPtq
	 mLF4F+Jpb+y9wwUXIld5VnParUzRCxuIMSrtJu4DVO6WWxa64ct1XNGAMVNaMZmFMq
	 T7BB25aRUdAJCiG2nrjGiceaqh29uYO3/7OoHFO5j0bIqEVU+EXEHXEMl4HlFTCBBf
	 a28Q8tlkAA8NQ==
Date: Wed, 15 Oct 2025 15:38:48 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] tsnep: convert to ndo_hwtstatmp API
Message-ID: <aO-x-PNBhSxDf6_z@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-7-vadim.fedorenko@linux.dev>
 <aO9xf0gW9F0qsaCz@horms.kernel.org>
 <d160e924-dee1-46b9-8d24-71c3d9c00ea1@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d160e924-dee1-46b9-8d24-71c3d9c00ea1@linux.dev>

On Wed, Oct 15, 2025 at 11:38:34AM +0100, Vadim Fedorenko wrote:
> On 15/10/2025 11:03, Simon Horman wrote:
> > On Tue, Oct 14, 2025 at 10:42:15PM +0000, Vadim Fedorenko wrote:

...

> > Hi Vadim,
> > 
> > I'm probably missing something obvious, but it's not clear to me why
> > removing the inner switch statements above is ok. Or, perhaps more to the
> > point, it seems inconsistent with other patches in this series.
> > 
> > OTOH, I do see why dropping the outer if conditions makes sense.
> 
> I believe it's just a question for git diff. It replaces original
> tsnep_ptp_ioctl() function with get() callback. The only thing that new
> function does is copying actual config into reply.
> 
> The switch statement goes to set() callback where the logic is kept as
> is. Original tsnep_ptp_ioctl() was serving both get and set operations,
> but the logic was applied to set operation only.

Thanks, silly me. I see that now.

Reviewed-by: Simon Horman <horms@kernel.org>


