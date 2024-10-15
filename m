Return-Path: <netdev+bounces-135795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4099F3A1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D3E1C228D6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933101F76B4;
	Tue, 15 Oct 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuZ/iySK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699DA1B395D;
	Tue, 15 Oct 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011689; cv=none; b=i4Ls58iD6lvoU489Or7nRloEJkf1K+uT3aevzI9awcexF6kNnz8it8HHE4ENFfQE2UDRUWJ/4TNd5VlArYhfQBkOEts5sdyCW+rnKhHZPKNZ81zkLlyofMG08WCYUasZvEalFcuyG+pV04ztko4XIKAeCkpQHN5d478Arg7yq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011689; c=relaxed/simple;
	bh=6ZDv1DPOViMerix/pLY35CjPShNwK71RUsI+6xNqQZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyyiRE7mmTlda/SCK3mxIKQoYxrJD432pFblGecf00aUdZG5tK0C6RvlRrK93yUkx+eYCqYpyfX/CvD7YhIxYoSF1K2a2r6M0J9vjsi9U4cj9T64nqZNQDIXp/+auswgz3gRGTL8B9LrM5St7o12xDcPkruI/3Uc0sEVzwHRPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuZ/iySK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791CAC4CEC6;
	Tue, 15 Oct 2024 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729011689;
	bh=6ZDv1DPOViMerix/pLY35CjPShNwK71RUsI+6xNqQZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BuZ/iySK0wA7/6Qj5+GZU5Hl8mY6k502ryKPZibWbmZ1Mh0eV5MtVBx6TLKuTYSt1
	 qJuHIP1I6SLRxdEUxU+Z/xCD6wfX7TDKnbsS5Who348woOcad/DL7ECGAHurQ9tc45
	 Pp/RNTlwYa+KvuAiJcpfaRKTWObWSuzzNkwd25De1PoNpL6cchpskVM4g9xSSjTORZ
	 wxVmYgewCZOt2dzoIdTKmqifaIkyuVhQrJu35Fk5zNhFxG2dhyzvOp8GZ1UI/JO9Je
	 84sOP1CuoCCCxFdRLnBAzYmpNp618EvKAl1aBUuVAAvS069bUJG14IjM+e3EUay4kD
	 C5YTTqtHUx9XA==
Date: Tue, 15 Oct 2024 10:01:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Hai <wanghai38@huawei.com>
Cc: <andreas@gaisler.com>, <gerhard@engleder-embedded.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <zhangxiaoxu5@huawei.com>, <kristoffer@gaisler.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net] net: ethernet: aeroflex: fix potential memory
 leak in greth_start_xmit_gbit()
Message-ID: <20241015100127.1af51330@kernel.org>
In-Reply-To: <20241012110434.49265-1-wanghai38@huawei.com>
References: <20241012110434.49265-1-wanghai38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 19:04:34 +0800 Wang Hai wrote:
> The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
> in case of skb->len being too long, add dev_kfree_skb() to fix it.
> 
> Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet MAC driver")

The fixes tag is incorrect. Please pay more careful attention.
Just running git blame on the code you're touching is not enough.
To save everyone time I will fix this when applying.

