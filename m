Return-Path: <netdev+bounces-32461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A15A797B07
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A8F1C20B45
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40D13AFF;
	Thu,  7 Sep 2023 18:00:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9871134B2
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26AC433C8;
	Thu,  7 Sep 2023 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694109616;
	bh=vMxdVhu77OgE3zvcI/BpW7/MVDaKTSjHlSue+4KdRds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bWWN+Tg4o1j47GXln1jE+mtTX3doYxOvjIj1qUvwqS9f3nd4Zqjjq9oqh/y6EAP8l
	 znM0bSJ7kgr67TP1bRNUqJvixYUNe80xZhM+MYfNrBYvXDXfM2BsHfyXqTXhAtK4t1
	 cLvljLo3hYVLCsdyFjSyRkZ86WZcbcz00nBrdsEe4CIciVCX+lWRIREH1yi88jbno1
	 mETYwmaQImjDTABZr0xgS+gR36Vw9MSGF4oVgZdW8uJrflRmKHRW56PQVGUcUSxNap
	 qyHiR/K1apMGxKCDlwF5tU2B5/PrTPYNmcAr2MR8jvz+IlD1i8RcczEikO/rEy11/7
	 ptJtFYPRjDvQA==
Date: Thu, 7 Sep 2023 11:00:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Soheil
 Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>,
 Yuchung Cheng <ycheng@google.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing
 socket backlog
Message-ID: <20230907110015.75fdcc5c@kernel.org>
In-Reply-To: <CANn89iJY8UypOGqSOJo531ny4isPSiTg2xW-rO_xNmnYVVovQw@mail.gmail.com>
References: <20230906201046.463236-1-edumazet@google.com>
	<20230906201046.463236-5-edumazet@google.com>
	<20230907100932.58daf8e5@kernel.org>
	<CANn89iJY8UypOGqSOJo531ny4isPSiTg2xW-rO_xNmnYVVovQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Sep 2023 19:16:01 +0200 Eric Dumazet wrote:
> > Is it okay if I asked why quickack?
> > Is it related to delay-based CC?  
> 
> Note the patch is also helping the 'regular' mode, without "quickack 1" .
> 
> This is CC related in any way, but some TCP tx zerocopy workload, sending
> one chunk at a time, waiting for the TCP tx zerocopy completion in
> order to proceed for the next chunk,
> because the 'next chunk'  is re-using the memory.
> 
> The receiver application is not sending back a message (otherwise the
> 'delayed ack' would be piggybacked in the reply),
> and it also does not know what size of the message was expected (so no
> SO_RCVLOWAT or anything could be attempted)
> 
> For this kind of workload, it is crucial the last ACK is not delayed, at all.

Interesting. Some folks at Meta were recently looking into parsing RPCs
in the kernel to avoid unnecessary wakeups. Poor man's KCM using BPF
sockmaps. Passing message size hints from the sender would solve so
many problems..

In any case, I don't mean to question the patch :)

