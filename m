Return-Path: <netdev+bounces-94718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D38C0591
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 22:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9EE1C21398
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 20:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A69130AC1;
	Wed,  8 May 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su/qH6Gm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A353F9C3;
	Wed,  8 May 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199726; cv=none; b=Jj6PpLgjCJi4ONrRTlhyO7Hh43RO1hGyjgvj0tVr8QcuEE+yQhqUQJuhLJb+6G72E9R8Nc2F5jXJYRtk6Xu3rfHRnvrMMS20euUgfp8b+3HfscqtvY8VI8Q3hRIgdwTSYJAnQM44AGkpWUk/3D0X2wy+dDbqCyQZtqJwcQxbFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199726; c=relaxed/simple;
	bh=VgHezigwNbuVnRg5EhEx/YG3xYXmzaOK+QgdsibCgPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aexGForrU3cjAzsi5PKU6HXOVIuzdvFpRBo6cxIq9ynZNdsHfbymbPiaze038JsZB9yvhgOOcnTfDRkQk5cmT54JxhgQ8tKMtGVCPKSQvErnHqdJOE1OQ7LrSGsACh6jPPL6dTK15sxzqErTNfZLXGw37PG/Ohat5ipA5RcAc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su/qH6Gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B24C113CC;
	Wed,  8 May 2024 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715199725;
	bh=VgHezigwNbuVnRg5EhEx/YG3xYXmzaOK+QgdsibCgPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=su/qH6GmH6XmtYOulJJd7uMn9eabEdIUK65FkTE7Lj62X7kiE//5mCCNad7LfuJiI
	 aJieJoFz5AXfNzpK3qJpUSqrzu9s7bjVlaM/AyfNgF2jcKEgXKLBM1zYY/M70MFHXh
	 YlobZsg3GrGNCFcrEHoPq9i3LOZ32Zrlg2DDjid3V5+/4VM4/TASGewgVH8aWny/Mu
	 +EBxa8iGCNPyFA2flpPrzLSDcD71f2iknkdZFXAvaPmCJXB0Ktanh8SKiYDn8xiSAA
	 Cr/5/sHIlvUxJZLRan6x2wQFEX3CuFv5OVQjBwo+CLvT9BmNK6IDHLt3V6MuistcLG
	 OmmyQ9mAU7rXw==
Date: Wed, 8 May 2024 21:22:01 +0100
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>, richardcochran@gmail.com,
	peterz@infradead.org, linux-kernel@vger.kernel.org,
	Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net-next] ice: add and use roundup_u64 instead of open
 coding equivalent
Message-ID: <20240508202201.GB2248333@kernel.org>
References: <20240507205441.1657884-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507205441.1657884-1-anthony.l.nguyen@intel.com>

On Tue, May 07, 2024 at 01:54:39PM -0700, Tony Nguyen wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In ice_ptp_cfg_clkout(), the ice driver needs to calculate the nearest next
> second of a current time value specified in nanoseconds. It implements this
> using div64_u64, because the time value is a u64. It could use div_u64
> since NSEC_PER_SEC is smaller than 32-bits.
> 
> Ideally this would be implemented directly with roundup(), but that can't
> work on all platforms due to a division which requires using the specific
> macros and functions due to platform restrictions, and to ensure that the
> most appropriate and fast instructions are used.
> 
> The kernel doesn't currently provide any 64-bit equivalents for doing
> roundup. Attempting to use roundup() on a 32-bit platform will result in a
> link failure due to not having a direct 64-bit division.
> 
> The closest equivalent for this is DIV64_U64_ROUND_UP, which does a
> division always rounding up. However, this only computes the division, and
> forces use of the div64_u64 in cases where the divisor is a 32bit value and
> could make use of div_u64.
> 
> Introduce DIV_U64_ROUND_UP based on div_u64, and then use it to implement
> roundup_u64 which takes a u64 input value and a u32 rounding value.
> 
> The name roundup_u64 matches the naming scheme of div_u64, and future
> patches could implement roundup64_u64 if they need to round by a multiple
> that is greater than 32-bits.
> 
> Replace the logic in ice_ptp.c which does this equivalent with the newly
> added roundup_u64.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

