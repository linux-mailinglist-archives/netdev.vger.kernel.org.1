Return-Path: <netdev+bounces-105666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC649122FE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E29D1C20E0D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19451171E54;
	Fri, 21 Jun 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI5hU0/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA782D72
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968015; cv=none; b=iBB9VzpvBvBpgZykh2UGUyg986qXbBbJXQ0OklpcwSV/X3HVp4lLjJFFq20s6RAMTrh8FtXh5KE6Kom6LQ5I5VK719Ohsbzp2gF//EawCPYmhi2KZO+AFd5NLFUFKO4mDdtQV29bC2YX9sZXMNQxZkY50d/sOC6ySUeq4nJZyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968015; c=relaxed/simple;
	bh=6VOAciI3l+lpalhgYuIvKrw2Wbjh2tnPecABFpzuD/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYUvSlQAbmDxGkyc7nD1aOSqRw0F/XHiIRUqoISlYx2Kz8il/2XUJnrTZe4tTFOYEGClNCQv7IyOhWq6zpczfoeEznmNLeYPaOgqVYghD5PBTa013zbOGomcUMOYRrc/cLy2q1eyszy1c98lI1DzDKsPSQhbvixN162gLO7XLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI5hU0/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D57AC2BBFC;
	Fri, 21 Jun 2024 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718968014;
	bh=6VOAciI3l+lpalhgYuIvKrw2Wbjh2tnPecABFpzuD/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pI5hU0/qek0JNpnsfeIWGei/QbXZSFmzVHNgw+nWh/xMNN5kk4WOY8cZXvNUB+xE6
	 O1hhlc5Q1kSrUaeDgmeUIWhaVDpb/0BveGx6YjFiaXG8KF+fdGueA8XpzP0Dhv86QH
	 u/aX2c8yPQqCBf+XYiPkrm8trKOQDLCPTd7sDmuYGwN0pO9yDOsh/WM84kx2ZKqNOV
	 P1dZ1ij8V5cxIUo/KrSToaMJgDo3sRGag5O6bN5RJBOAogw3V7DBKDLl0h2rSbdUVU
	 ejlKlK2cQ8tzX+a/+/AznFfNvNmXA288hbjZ3ivGbP+k13fZv6hJiV0ml1i5XswyVB
	 OYpvIyHAczQ0Q==
Date: Fri, 21 Jun 2024 12:06:50 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 iwl-net 2/3] ice: Don't process extts if PTP is
 disabled
Message-ID: <20240621110650.GB1098275@kernel.org>
References: <20240620123141.1582255-1-karol.kolacinski@intel.com>
 <20240620123141.1582255-3-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620123141.1582255-3-karol.kolacinski@intel.com>

On Thu, Jun 20, 2024 at 02:27:09PM +0200, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_extts_event() function can race with ice_ptp_release() and
> result in a NULL pointer dereference which leads to a kernel panic.
> 
> Panic occurs because the ice_ptp_extts_event() function calls
> ptp_clock_event() with a NULL pointer. The ice driver has already
> released the PTP clock by the time the interrupt for the next external
> timestamp event occurs.
> 
> To fix this, modify the ice_ptp_extts_event() function to check the
> PTP state and bail early if PTP is not ready.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: removed unnecessary hunk of code and adjusted commit message

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


