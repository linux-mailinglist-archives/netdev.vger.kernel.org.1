Return-Path: <netdev+bounces-192515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CEAC0305
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287F31697B6
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEA3126BF7;
	Thu, 22 May 2025 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ3vN6jx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AE17E105;
	Thu, 22 May 2025 03:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884950; cv=none; b=O7miSKUeX2jNLWIcm7yNLKorWFK0fgJgGOLuLnflyIPFZyYlwU9wQBHFww+1H04rTLdwWjKBvwtwQKqvr80idcVT22u7I8zffgt1edQPd8ZbF601RqwAGhtQ/f7IQi79jsjxr3Tk/BbPeRG4U4sC27pzQlFEe28dHq5NvwndpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884950; c=relaxed/simple;
	bh=t2WGCOd+hZ3e1e76kH6PXBbgHX6CUfiBmh6jxHitVm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/AmaGlsMBxNAVQSP7VX5z5gvNFot0rglVLnIVd5jPRfjtpRoT68k8yjAANqU55XKqv/voUbfbiiKcQaXR9am4qI4EuRkkHCU2fuSocHmr8No+Yc4CdwUZau5FPwAbFnM+YFA5ueRXc4RpW0BnDsfusEy2OpUWKAfYI7K4/BC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ3vN6jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1579CC4CEE4;
	Thu, 22 May 2025 03:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747884949;
	bh=t2WGCOd+hZ3e1e76kH6PXBbgHX6CUfiBmh6jxHitVm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jQ3vN6jxqQzqLTqnwLvTI+oH4E08h7x/40eJWHsNSHnwuXSOtWi/NDOkJRQr1GdyQ
	 lL/4esU1w+nmuTejPGu9F6+bzhoLwXVWw62UM5UEJ+3F6U68DhswYBFfmzlD1mCxNL
	 BVgyyiAsuHUusX+0H5eJiBXUDxUIgGT5gLHTfkkrthccV5/T3+dqGznbhbO5s8W2Ns
	 1cFKCPhHSX9RZBJmm/UnFliyaxRoktsd/CVlRoUovGiCDHRO6hqYkuKsTUZ4NwVwZU
	 tYtCE+0r6ATKLtID9ecTGxFE4+M7BidePaufUjpr9ne8YFroWQVw+TQ9w3ulANiGDY
	 IK1d4kxj8fZQQ==
Date: Wed, 21 May 2025 20:35:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] queue_api: add subqueue variant
 netif_subqueue_sent
Message-ID: <20250521203547.43d73e5a@kernel.org>
In-Reply-To: <f59625ada94078ffc14f90a7ed6d4df344dc9cb2.1747824040.git.gur.stavi@huawei.com>
References: <cover.1747824040.git.gur.stavi@huawei.com>
	<f59625ada94078ffc14f90a7ed6d4df344dc9cb2.1747824040.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 14:06:12 +0300 Gur Stavi wrote:
> Add a new macro, netif_subqueue_sent, which is a wrapper for
> netdev_tx_sent_queue.
> 
> Drivers that use the subqueue variant macros, netif_subqueue_xxx,
> identify queue by index and are not required to obtain
> struct netdev_queue explicitly.
> 
> Such drivers still need to call netdev_tx_sent_queue which is a
> counterpart of netif_subqueue_completed_wake. Allowing drivers to use a
> subqueue variant for this purpose improves their code consistency by
> always referring to queue by its index.

You need to post it with a user in the same series.
-- 
pw-bot: cr

