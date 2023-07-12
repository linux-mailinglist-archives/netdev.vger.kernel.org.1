Return-Path: <netdev+bounces-17022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224474FD77
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E3280C67
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7280D;
	Wed, 12 Jul 2023 03:09:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5438F
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C858C433C8;
	Wed, 12 Jul 2023 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689131396;
	bh=Os4SCV5ZzvjtqSv6di6M5MCo9Im5sxnwXQeFenpBIjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/tEvxtA2Sfo9Djzp5f/eGjGpZaoyYSZ0Cgf9+dRDayXv7wOqSPv2kPbQ63UOGdY3
	 AI/2yI/2VrtISB9G5swwkkH1mcIMLuUF8hOvRoFobJaNFOioGNQ+8KzOJVbcBbk6Zm
	 ASbPOo7SnS7s2C3t9Z/NAb7ihcS0AuZuz+ZsHLo2kw3AUraOFi04I6xn8nzkRyw2D6
	 yLIW1Y6Lr/0FO4hLHIwCZ0yk9y9e+pFRd4XyX84mMay/0TwMCsOGhVBHyA3yuhWXRd
	 pirpb5L8AL9CkF26FcbGsp796/wlNR2vHQiPHwVhkW1cHI1B9gCCRF16stnFMPxNIx
	 95bTE+pLBNkoA==
Date: Tue, 11 Jul 2023 20:09:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: menglong8.dong@gmail.com
Cc: michael.chan@broadcom.com, leon@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>, Leon
 Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next v2] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
Message-ID: <20230711200955.2d3a4494@kernel.org>
In-Reply-To: <20230711110743.39067-1-imagedong@tencent.com>
References: <20230711110743.39067-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 19:07:43 +0800 menglong8.dong@gmail.com wrote:
> In bnxt_tx_int(), the skb in the tx ring buffer will be freed after the
> transmission completes with dev_kfree_skb_any(), which will produce
> the noise on the tracepoint "skb:kfree_skb":
> 
> $ perf script record -e skb:kfree_skb -a
> $ perf script
>   swapper     0 [014] 12814.337522: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [003] 12814.338318: skb:kfree_skb: skbaddr=0xffff888108380600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.375258: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.451960: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [008] 12814.562166: skb:kfree_skb: skbaddr=0xffff888112664600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.732517: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.800608: skb:kfree_skb: skbaddr=0xffff88810025d100 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.861501: skb:kfree_skb: skbaddr=0xffff888108295a00 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12815.377038: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12815.395530: skb:kfree_skb: skbaddr=0xffff88818f145ee0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED

I think this is way too verbose, people looking at networking code 
are expected to understand kfree_skb vs consume_skb. Your v1 was fine,
I'm going to apply it.
-- 
pw-bot: na

