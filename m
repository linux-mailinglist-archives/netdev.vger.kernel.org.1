Return-Path: <netdev+bounces-20477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A0075FB02
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9AE1C20A95
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A078DDD1;
	Mon, 24 Jul 2023 15:41:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F68839
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48908C433C8;
	Mon, 24 Jul 2023 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690213287;
	bh=ykEBR5UUmS0xV+TmQli48AV2jUH+UxZHF+IllPg7RX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EfjI9rcOA+s2xPYRr6aoPR4wNLDeE2gKJHSSjKOoiDZoVzOBqAjDsemCW1miLggGV
	 FsF7RUoxel1MMqQ7xS+Q7IxV4hHCrrzCnELbJzmzkvz+gMwDMQylPlOSsm8QHF4lBH
	 xxpF75j3XBA1jR9EugEi9e3DuwHuDaWzq7vnokKcb/cZBZRETXVgJrobImCpJnHsyC
	 hH7FXJFDwVAA2q/k9s+mZnqRW3Xqu0H2+l2povNIKCmhRtIbEp18AWarOh5yG6bVxi
	 hPjQ5+ifWW+CP7Y5M8BOYW2kFy7d9xbsLDHQARsQSDy0+2XlV8SIYqFrmWEDXmEMMF
	 wQgVGM7Qguu/g==
Date: Mon, 24 Jul 2023 08:41:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 mkubecek@suse.cz, lorenzo@kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, Neil Brown <neilb@suse.de>
Subject: Re: [PATCH net-next 1/2] net: store netdevs in an xarray
Message-ID: <20230724084126.38d55715@kernel.org>
In-Reply-To: <20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
References: <20230722014237.4078962-1-kuba@kernel.org>
	<20230722014237.4078962-2-kuba@kernel.org>
	<20788d4df9bbcdce9453be3fd047fdf8e0465714.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 10:18:04 +0200 Paolo Abeni wrote:
> A possibly dumb question: why using an xarray over a plain list?

We need to drop the lock during the walk. So for a list we'd need 
to either 
 - add explicit iteration "cursor" or 
 - suffer O(n) for insertion + O(n^2) for restart?

Or there's a easier way to do it?
The cursor is not the worst option, I guess, a bit less intuitive
and harder to clean up on error, but doable?

> It looks like the idea is to additionally use xarray for device lookup
> beyond for dumping?

I was measuring it to find out if we can delete the hash table without
anyone noticing, but it's not really the motivation.

> WRT the above, have you considered instead replacing dev_name_head with
> an rhashtable? (and add the mentioned list)

The main motivation is ease of iteration for netlink dumps.

I'll admit that my understanding of rhashtable is superficial but
I don't think it's possible to do consistent dumps with it. Even 
if it supported "cursors" (which I'm not sure it does) a rhash could
rearrange buckets and mess the order up. The comment on
rhltable_walk_enter() says:

 * For a completely stable walk you should construct your own data
 * structure outside the hash table.

Given the iteration process is controlled by user space trying to
constrain a rhash also used by the fast path to get consistent dumps
seems risky.

Adding Herbert and Neil to keep me honest.

