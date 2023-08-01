Return-Path: <netdev+bounces-23090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956C76AADA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D63281853
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E21ED37;
	Tue,  1 Aug 2023 08:24:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075C1110
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342C0C433C8;
	Tue,  1 Aug 2023 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690878274;
	bh=gkk74t9As49XSJeT+8LUv0zRRxmwMv0p+C8NfbmPl7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZBz4x7Y8V6Yp4RfkN8c+sBfGIsAeDXHsN2N7xNltclI6Y37r0oskt+G6j7xErJbj
	 5NEXOYonN050QVNcZj8D3Wb2b9m6fl1Hr2Kvtpx+MQVpeadYQuV95XVSBBKKM30D1w
	 eg/sBJMZ61btbOLDO2LZz4Uo9f7mcybxSlrd1MlM=
Date: Tue, 1 Aug 2023 10:24:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rishabh Bhatnagar <risbhat@amazon.com>
Cc: lee@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH 4.14] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
Message-ID: <2023080102-certified-unrivaled-a048@gregkh>
References: <20230727191554.21333-1-risbhat@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727191554.21333-1-risbhat@amazon.com>

On Thu, Jul 27, 2023 at 07:15:54PM +0000, Rishabh Bhatnagar wrote:
> From: Lee Jones <lee@kernel.org>
> 
> Upstream commit 04c55383fa5689357bcdd2c8036725a55ed632bc.
> 
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
> 
> In order to prevent this, move the point of possible failure above the
> point where the reference counter is incremented.  Also save any
> meaningful return values to be applied to the return data at the
> appropriate point in time.
> 
> This issue was caught with KASAN.
> 
> Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
> ---
>  net/sched/cls_u32.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

We need a 4.19.y backport before we can apply a 4.14.y version, as you
do not want to upgrade and have a regression.

thanks,

greg k-h

