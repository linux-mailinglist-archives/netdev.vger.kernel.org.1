Return-Path: <netdev+bounces-32464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43204797B40
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF72F281673
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833813FED;
	Thu,  7 Sep 2023 18:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC36134DD
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D7AC433C8;
	Thu,  7 Sep 2023 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694110251;
	bh=+GlcYEFOlEcjEmHh6gw6oifVtm8vLXx4BRTWPKzRheI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tsg13g2YBmSKQiDxkDghbB47nKlLxshGwM0q0J1l2eMOjaZ9zcPTrLleZEuOsPBt3
	 ds4IqKjh/bXvztf1HhPQ1cT0eZWAXtop13Vd2kedHLgBYidfAYuIQRw9R9sy4BBV2w
	 J7maewB4byc+NK2BqlNhKsvOKK9oGPde22gq3GugdpkLESjMk+nwSKualdICdkqifS
	 GzJ8EtBH7D/Z0ciZMBH82nZ+R2hW4gCRFcl2EwpHdxQryJsS1qIpEaSj0Uq0/XbuAa
	 VbbjkUciMdWIbpAna2LsyDWfEsYtKJdXNeDRtIBRo6jx484ImOX11dxrv9bx2ANFBd
	 Xvkn7/9Qu+bWw==
Date: Thu, 7 Sep 2023 11:10:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Soheil
 Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>,
 Yuchung Cheng <ycheng@google.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing
 socket backlog
Message-ID: <20230907111050.30425753@kernel.org>
In-Reply-To: <CANn89i+TDVA9iXedyOgASce1Z2ZfdMS+7Nfw6ebOKkYerWo43g@mail.gmail.com>
References: <20230906201046.463236-1-edumazet@google.com>
	<20230906201046.463236-5-edumazet@google.com>
	<20230907100932.58daf8e5@kernel.org>
	<CANn89iJY8UypOGqSOJo531ny4isPSiTg2xW-rO_xNmnYVVovQw@mail.gmail.com>
	<20230907110015.75fdcc5c@kernel.org>
	<CANn89i+TDVA9iXedyOgASce1Z2ZfdMS+7Nfw6ebOKkYerWo43g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Sep 2023 20:05:29 +0200 Eric Dumazet wrote:
> > Interesting. Some folks at Meta were recently looking into parsing RPCs
> > in the kernel to avoid unnecessary wakeups. Poor man's KCM using BPF
> > sockmaps. Passing message size hints from the sender would solve so
> > many problems..  
> 
> Yes, RPC headers make things easier for sure.
> 
> (we internally have something similar named autolowat, where we parse
> headers to set sk->sk_rcvlowat dynamically)

Could this be turned into a BPF hook, possibly?
That's basically what I suggested the BPF people did but they like 
to rewrite everything.

