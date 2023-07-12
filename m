Return-Path: <netdev+bounces-17004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5E874FC81
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C65281577
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACA3378;
	Wed, 12 Jul 2023 01:09:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB91362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 01:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2BFC433C8;
	Wed, 12 Jul 2023 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689124178;
	bh=ltHNWLVPb2iZrrx11QvvdCUrxBBk4wMx2HLKSZtmABs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SggduFVRY4zF963GrWMTGQY0r6EANRo61woi92V6Hho/4t07pfycVl2feYoc7agZc
	 EVbMzpL+xkuamzpeOyiuei3xwcZGkg8gPxVfxDo2vqF/p6gLzgbfttxvEZB7ahts4c
	 MuB+L22Lb8+LCyw30YY0FNq/P9+2iXRwWJrk5oqxbVya8X8swA+XQxBcBfGzXrN2gC
	 lDB3WPQD6pHgOC3zkbtbbsjWvLubRl3w78nGJNqNwBIWIyRpQusqIzFmegRhqAOw/C
	 PfXzKzIGHRBvIigvdJ4y/RDIENW2uC63gUIMpQ4pOfop7apkSa8B4vomufwO458oqS
	 EWgbnjjID28yQ==
Date: Tue, 11 Jul 2023 18:09:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
Message-ID: <20230711180937.3c0262a9@kernel.org>
In-Reply-To: <CACKFLimD-bKmJ1tGZOLYRjWzEwxkri-Mw7iFme1x2Dr0twdCeg@mail.gmail.com>
References: <20230710205611.1198878-1-kuba@kernel.org>
	<20230710205611.1198878-4-kuba@kernel.org>
	<CACKFLikGR5qa8+ReLi2krEH9En=5QRv0txEVcM2FE-W6Lc6UuA@mail.gmail.com>
	<CACKFLimD-bKmJ1tGZOLYRjWzEwxkri-Mw7iFme1x2Dr0twdCeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 17:01:08 -0700 Michael Chan wrote:
> > It generally looks good to me.  I have a few comments below.
> >
> > The logic is very similar to the bnapi->in_reset logic to reset due to
> > RX errors.  We have a counter for the number of times we do the RX
> > reset so I think it might be good to add a similar TX reset counter.  
> 
> Never mind about the counter.  Since we are doing a complete reset,
> the cpr structure will be freed anyway and the counter won't persist.
> 
> Later when we add support for per TX ring reset, we can add the
> counter at that time.

Oh, if all the cpr stats get lost during reset or re-config, that's
quite unfortunate. We should get that fixed without waiting for per
ring resets of any sort, just in case that takes long. 

Can we stash the old sum somewhere and report in ethtool as "non-ring"
or "old" or ..?

> > The XDP code path can potentially crash in a similar way if we get a
> > bad completion from hardware.  I'm not sure if we should add similar
> > logic to the XDP code path.

Ack, will fix.

