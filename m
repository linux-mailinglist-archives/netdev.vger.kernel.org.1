Return-Path: <netdev+bounces-111311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C228F9307FA
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CB3B221CA
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048E1487CC;
	Sat, 13 Jul 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHSt7CYz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073A17C73;
	Sat, 13 Jul 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720911546; cv=none; b=P1d2EGWutLeKpzbPLB9oP4tOR12zfICqTZnrTiIMQ3Lca+gvKNGHj/ZFuYK9Vq1nxnkF0zgbGoo+WDJpHVgnAFSG8g4yP8oTQ6ysnUZ7/reVCZ0GrN+KYSmvzHCxigrO4RlGKpFbc1BkhQXurdomOyhtE9I7nU3eZUpDTts67uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720911546; c=relaxed/simple;
	bh=+M6TpI7CsdoKFXDrBfjCGt4Ql1FDaJ6r33Y/sLj0Zdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bl7kUyWd2y0ZFpGYdcXPtDR9zWGCCXrkbE32963cZ5Sh7Znur7/CB4BjJH7S1WP6erTUw5fZQHehyesyhkYbMS/umNzT8wvrW6bgl9qnfaHtdW+hmj9d2Zb6fiKNUr8J5vDsH6zmC+ivoLanoG0dr4wxTvyy1/RcnBI6OhLxQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHSt7CYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D8C32781;
	Sat, 13 Jul 2024 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720911546;
	bh=+M6TpI7CsdoKFXDrBfjCGt4Ql1FDaJ6r33Y/sLj0Zdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BHSt7CYzqE6hXo458ENPoqMcc5zO8KG9qm+OTL2rnihSHVl9lzgo03z6xvik2Zw5O
	 m3kqsjpv/8wbUZXXK/95FJEy/6xQG5rCW8+8K/IJQlPgyjqqHSQa/ZEzKP3E3vegh5
	 mOkoKRhLGc8wJu0ZToWA3LVtdTkMfjiycMI3Eej2CYpobqmLQOY9Ybj+jLBzzwycxc
	 x/AZ6XtyLRjz4gKVvcitMUViztd09FbDxLI8oYbjCaMVCiH0nXPpS/zXfcn7NF3jkk
	 qbyC3mJjlxyymzqZH/DkKjZ6Tb0FBWTQFFEWY77z18r2MqWnrtexJdHF3tuTT9cbuF
	 3vHPwEI2vqjiA==
Date: Sat, 13 Jul 2024 15:59:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 rbc@meta.com, horms@kernel.org, "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux.dev>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <20240713155904.72326bfb@kernel.org>
In-Reply-To: <ZpFEqbibtxoK0Xcn@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org>
	<20240712075432.7918767a@kernel.org>
	<ZpFEqbibtxoK0Xcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 07:58:49 -0700 Breno Leitao wrote:
> I didn't send to `net` since this WARNING is only "showing" in net-next,
> due to commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") being only in net-next.
> 
> But you have a good point, this is a fix and it should go through `net`.
> sorry about it.

Hah, but it doesn't seem to apply to net. Let's wait and see if Linus
cuts final on Sunday. If he does I'll apply to net-next and you'll have
to send the net version for stable to Greg. Less merge conflicts for me
that way ;) If there's -rc8 please rebase.

