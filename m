Return-Path: <netdev+bounces-130821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6298BAA6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25FB1C20A14
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE51BE87B;
	Tue,  1 Oct 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY/zyzGC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F019D88A
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780924; cv=none; b=lRl/qTx1OjJKVDiAXp7yccUFJ4IOqWta+4IdS/SqKDf0J70fbCadaR6W90J68H6ZceOhM8AduWcDk5l7UK4gVCRSvTTpp575gyj7PdY+v4b4B8hc6Ea95mSg4ji+UMHkLQW+zXvDijJbEeVTwPWEcn/mgblO/ZOrXE04vp/b3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780924; c=relaxed/simple;
	bh=c/aZKErGt6JLpDaTKTuxlLwNa6VsRlhBE71G8X9NaH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOKTBlVGejcfcpq4ftBp62iq+bq9QG7n/Cd/k8OLWysCYEE1WtLyQMutNpLSu439I174REIFpknzILKKzAl2PaZp7qcsPyK+8qQ3W23RTBmghG2zRWQQPRANbDLyWqPkMWyp8RXpxEURcjIeXmJyXFksWl6FbuwFDQFBUuY90yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY/zyzGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D77C4CEC6;
	Tue,  1 Oct 2024 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780924;
	bh=c/aZKErGt6JLpDaTKTuxlLwNa6VsRlhBE71G8X9NaH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EY/zyzGCxfSf0Xp0bHtAQqhBbJDRdk1NM57mhkDBRNuBPLpSqsEQ7hgbZBiGfwrCG
	 BSbqb6ld60Is0myTSKywJXwyhONWRDfBWsuHFs2YQAAY2AOHF8i1BDPPRAd6mIh2hN
	 wAbVcf6iMmy/2B/u4oh4c+HydIMYXe1XN4xs0UmcdL4+f/DbxhZPNu0eOQaPNob+Qr
	 j87nVvOWlxxMVdNZ82AbagdHYDwdVG3iWjqIO98GtD70x6Wt20za96kN+PDbb8uwbY
	 OlkzShmZH24Ny2zZJ9bEch1zaMj0I3PXNrmD1/jafrJ5UHeoF1FN+YYNIobOazCp/R
	 vu1htJELj4mbw==
Date: Tue, 1 Oct 2024 12:08:41 +0100
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH net 1/2] ibmvnic: Add stat for tx direct vs tx batched
Message-ID: <20241001110841.GO1310185@kernel.org>
References: <20240930175635.1670111-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930175635.1670111-1-nnac123@linux.ibm.com>

On Mon, Sep 30, 2024 at 12:56:34PM -0500, Nick Child wrote:
> Allow tracking of packets sent with send_subcrq direct vs
> indirect. `ethtool -S <dev>` will now provide a counter
> of the number of uses of each xmit method. This metric will
> be useful in performance debugging.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Hi Nick,

While I see that this patch relates to patch 2/2, and I agree that patch
2/2 is net material, this patch seems more like an enhancement and
thus suitable for net-next.

...

