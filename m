Return-Path: <netdev+bounces-161783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5EA23F4E
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502AB16978D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA91C5F1E;
	Fri, 31 Jan 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsZdb1vX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E524502A
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738335395; cv=none; b=QGZy0rYIKb4lvxAy0RRjvzMi4NmeruYFW0qgWelumqpFykO44RQJY4YJzP4Zh/Q2nzI+B1Fs84WVPOKeVbI/GuMIhW2Qu3GsxKm39IQ6E5Nik9P3IioA1keLZyoaRMmnAwWBpN3FgwEF10EMFYiu55Gb/rgDDl1fdGms7NH67H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738335395; c=relaxed/simple;
	bh=+qOB8ecQF1mqWeRzosyh6gMdfavZ114YSX2AA7ma9oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKrPfNHtLVC3Jbwc+gUKqzwEXDmeNA08F1x0QUky/ZSPBMS7rIihjXOIiEFsZpUVV5pB2hTh53sx9RZQyfwq1+FuIbhZuoWMLBJ7TVLFRGmNdPAmlodrSOCOx4Ww66KYnmemLIt/y6kBSyi3wMjPLm51RHCkko7JKJu+yTYv5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsZdb1vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B9AC4CED1;
	Fri, 31 Jan 2025 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738335394;
	bh=+qOB8ecQF1mqWeRzosyh6gMdfavZ114YSX2AA7ma9oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsZdb1vXMHgeAufN2P8/tdBhL9dyeZpOw2fgRlvjh6Yqg+g/18ylES5nRnSVnqX52
	 rkEVp8KNZPY837eBndU+mNi74isovDqfnBnCDtXAxTjCBSk/UMO8BmbSnBtxsidXM0
	 mEVYQJYRlYluY3LppXM3bu36P+JL9UQv1oTUrPCZhplThXdFNzy28FAI9iF3BPOZHk
	 Y+AdScOermMV7x6jjGPKTpwbV8OluRbVghpGdG5KxVYxtOD/+uHRbrYQUtcW/PL0Mj
	 zbzOw08qLdEYnEuTJ6tykJmZEs0rKi5lNM0ZWr8NIlZZIJX+dd4G/Am68Ex5fVTAWs
	 FpyvSvEYvA1mg==
Date: Fri, 31 Jan 2025 14:56:31 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	dan.carpenter@linaro.org, yuehaibing@huawei.com,
	maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next v4] ixgbe: Fix possible skb NULL pointer
 dereference
Message-ID: <20250131145631.GA34138@kernel.org>
References: <20250131121450.11645-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131121450.11645-1-piotr.kwapulinski@intel.com>

On Fri, Jan 31, 2025 at 01:14:50PM +0100, Piotr Kwapulinski wrote:
> The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
> ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
> encoding. Propagate this logic to the ixgbe_put_rx_buffer().
> 
> The commit also relaxed the skb NULL pointer check - caught by Smatch.
> Restore this check.
> 
> Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
> v1 -> v2
>   Provide extra details in commit message for motivation of this patch
> v2 -> v3
>   Simplify the check condition
> v3 -> v4
>   Rebase to net-queue

Reviewed-by: Simon Horman <horms@kernel.org>


