Return-Path: <netdev+bounces-209114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD5AB0E5C2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BEA560FCC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D326A0F8;
	Tue, 22 Jul 2025 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtZxINDh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6ED220F54
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221326; cv=none; b=la4IS9g+ClsvCY+jWq9XFrYDyHRp1z31FoWWDZcrpPo7MMKAxTH/ql1tjxGWU9BDCECtZ+SpN5t4D5O9n5zKJKGItaXZ0IMbkhBIbsVNJQyxWHnc7VnKd1sbBwYJlzFudLfwm5BZyGSPRXALUY84GgZYCiBXxDpOQEzCZkqN2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221326; c=relaxed/simple;
	bh=XHLLUPdj2/vdyibY59VKfyTfttqZE3jAKUXgsKOiZzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNZl6gF6Ozw//X7FZsNp7UqCbtDp+kAgeJZNbSKSVhe1SBKnDpYPQF1MPvqpELdisF7s/f0vOIheb68shpTuHoWKioi6uVeZ6aOTRFryWMsXIJvQqD34NzqNKb56JStmYf9Ga4XPh73UV6jLDMc45lNesBWgxPkVVHQspjYoM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtZxINDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645F2C4CEEB;
	Tue, 22 Jul 2025 21:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753221325;
	bh=XHLLUPdj2/vdyibY59VKfyTfttqZE3jAKUXgsKOiZzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TtZxINDhE2hEzVBLm/UoCfYMmc/ZfgeYJKLs9qlEU/UjylOWzS7CWQRFl9HEoAO8U
	 j+LPBmQuYV16SRTKkVcW7rGmRuHzMDRlz8/cR6l+ZoysrwCXtUzLTjFNcO5rn1JJ7x
	 zruovhog7k9rrQBMDEtgSlhngQBNLnOrjac+vNfXt4TphLB3Vw3qXusEXAwUwIaTjj
	 1UwiMwTb5BAcnRofM4PAXkA9Bn9gDMI4XGZTeAofbUCgl8IGY2zqjUMAZWPqJyNx08
	 BCH1kxF9opKVQQRVOaKox8/59v6W7VMJvh+RxpprJHgjm609y0XUawAJMdTmh4JNHv
	 MaUGW6UB2NjNg==
Date: Tue, 22 Jul 2025 14:55:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Zigit Zo <zuozhijie@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: virtio_close() stuck on napi_disable_locked()
Message-ID: <20250722145524.7ae61342@kernel.org>
In-Reply-To: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 13:00:14 +0200 Paolo Abeni wrote:
> Hi,
> 
> The NIPA CI is reporting some hung-up in the stats.py test caused by the
> virtio_net driver stuck at close time.
> 
> A sample splat is available here:
> 
> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-stats-py/stderr
> 
> AFAICS the issue happens only on debug builds.
> 
> I'm wild guessing to something similar to the the issue addressed by
> commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi,
> but I could not spot anything obvious.
> 
> Could you please have a look?

It only hits in around 1 in 5 runs. Likely some pre-existing race, but
it started popping up for us when be5dcaed694e ("virtio-net: fix
recursived rtnl_lock() during probe()") was merged. It never hit before.
If we can't find a quick fix I think we should revert be5dcaed694e for
now, so that it doesn't end up regressing 6.16 final.

