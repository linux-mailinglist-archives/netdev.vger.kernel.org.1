Return-Path: <netdev+bounces-51777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15517FC02C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8141C20A42
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E595B5BE;
	Tue, 28 Nov 2023 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcMRcUo3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF954BE0
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D412CC433C8;
	Tue, 28 Nov 2023 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701192057;
	bh=puusfip924NnsGJF8uNMJlJWB/vurJEyppEM+n1Lj8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tcMRcUo3ib8lMWDBEiKlESJpOBqLmCMzpGbDnyYHxYJiJVVG6EO9LB+uIsMNP6riu
	 yorYOJJEnjNEGL+E7gIqFRLj+pagLLcb/GTBSlAtxMk1xiFU4lXGf1WSlHjn4GHR2L
	 BP3z/4Urpe631EF7o8pKT2NYTcGKvnNNHQkW20MC/6AnyA4S4pcUkQwhP5URZbEWIv
	 7VZcnvkisjHDfggVetzKkTGOGJpQEL1F2qu0EY7vq+4yNrDM5i4BsdgiPkESRTzwxS
	 U7s+VyKoIBxJE8kh7FK9LA5aK+DxXeSZZAq3ER+G88Aq/F7gRTpSljY3zx7ugE314m
	 2kWTYk0Nscnpw==
Date: Tue, 28 Nov 2023 17:20:53 +0000
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com
Subject: Re: [PATCH net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
Message-ID: <20231128172053.GA43811@kernel.org>
References: <1700930141-5568-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700930141-5568-1-git-send-email-sbhatta@marvell.com>

On Sat, Nov 25, 2023 at 10:05:41PM +0530, Subbaraya Sundeep wrote:
> All the mailbox messages sent to AF needs to be guarded
> by mutex lock. Add the missing lock in otx2_get_pauseparam
> function.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Hi,

I am wondering if the call to otx2_nix_config_bp()
in otx2_dcbnl_ieee_setpfc() also needs to be protected by mbox.lock.

And although not strictly related to this patch, while looking over this, I
noticed that in otx2_init_hw_resources() it appears that &mbox->lock may be
unlocked twice in some error paths.

e.g.
	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
	err = otx2_rq_aura_pool_init(pf);
	if (err) {
		mutex_unlock(&mbox->lock);
		goto err_free_nix_lf;
	}
	...
err_free_nix_lf:
	mutex_lock(&mbox->lock);
	...

...

