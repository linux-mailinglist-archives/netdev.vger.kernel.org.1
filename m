Return-Path: <netdev+bounces-51401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D97FA887
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710C72815E3
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B063BB34;
	Mon, 27 Nov 2023 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbwviPv1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF13716A;
	Mon, 27 Nov 2023 18:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEE7C433C7;
	Mon, 27 Nov 2023 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701108299;
	bh=yZAd/k08GdcTOr/Fs5n1V5VQl7oMldA6TqSlVGcOWQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fbwviPv1dKJaPLc0mEB/gU/U5HQ9sxxhmTt2ywizmRonX8X5jx9fQnlqvTROeXeLw
	 UneGMpLbqDgFR6nx1jr0mGGdF9mpMqy3sYSrRDhoJR6JSZyBAlOS+Qr68o0Ti0tcWb
	 HYjoHmsTHdfjpWaYSeXQIBB15vlhYlaXoU7TY0Z/uBf7+eKq1dNywBbzq9wUD8yn68
	 HeiXfFJn8JW6YLNetu8GFmGyZSLdkUS0Hy/VopQwr6N9cipd+iTXxRVFQzXLjg3b4l
	 dn80JJlLrOmkh5r51G83Zt0bIugxxrZmNvmCj5p4Z12FlVeDJwkDHldBfQNZZ81dAB
	 cRcjrAUGkdWWA==
Date: Mon, 27 Nov 2023 10:04:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 alexander.duyck@gmail.com, linux-doc@vger.kernel.org, Igor Bagnucki
 <igor.bagnucki@intel.com>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
Message-ID: <20231127100458.48e0ff6e@kernel.org>
In-Reply-To: <81014d9d-4642-6a6b-2a44-02229cd734f9@gmail.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-2-ahmed.zaki@intel.com>
	<20231121152906.2dd5f487@kernel.org>
	<4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
	<20231127085552.396f9375@kernel.org>
	<81014d9d-4642-6a6b-2a44-02229cd734f9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 17:10:37 +0000 Edward Cree wrote:
> Yep, I had noticed.  Was wondering how the removal of the old
>  [sg]et_rxfh_context functions would interact with my new API,
>  which has three ops (create/modify/delete) and thus can't
>  really be wedged into the [sg]et_rxfh() like that.

Set side looks fairly straightforward. Get is indeed more tricky.

> Tbh I'd rather move in the direction of using the new API (and
>  associated state-in-core) for everything, even context 0, so
>  that the behaviour is consistent between default and custom
>  contexts for NICs that support the latter.  Not 100% sure how
>  exactly that would work in practice yet though; drivers are
>  currently responsible for populating ctx 0 (indir, key, etc)
>  at probe time so how do you read that state into the core?

We can try to slowly move drivers over from the "pull model"
to a "push model" where they inform the core about the change
they have made. The main thing to worry about will probably
be the indirection table, as queues get reconfigured.

Maybe we can tie the switch over to the multi-context support?

Or wait with the conversion until the new API gets some use
for the non-0 context..

> And I promise v5 of the rework is coming eventually, bosses
>  just keep prioritising everything but this :(

Right, which is why I'm not asking Ahmed to worry about/wait for 
your work :)

