Return-Path: <netdev+bounces-22884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927A769BB5
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5821C20C59
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0819219BB7;
	Mon, 31 Jul 2023 16:03:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F019BB0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8BBC433C8;
	Mon, 31 Jul 2023 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690819386;
	bh=uCwYIf2GdCLT0KrjyXEfKtRASLPf6kzUQyt/i7QFRGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J4yNsUAVWOgeqbo83EdiL37XV51yRYiBeA3nl3TZDbMjEh8H6Drk9je+wJBbEW8/K
	 tM1L6KzncHjhWhLP2v62A3cw+V3eaBzX4ciis5Hv0OaWv3lU0/waVPC+GKFFGRrAIm
	 bpLAWvFszn3vmg2/f/ENwvcHn/ZHsLGmVe5lG5c0AXAqBNrMLw/troOH5aeGEI927n
	 RJqJnVglo6o2duvriBNGyGHCFyeZzJnOQXIyOJO/odjBkFRpaDpIDIhgvLc0Qziam5
	 p9wTdZuzCGKwe6ewrqYmixbn8vNAoMYSHOAIv/KSU0j3cv0CXGqeibwb98rMnyZxWH
	 VqLUwoRZ9hDtw==
Date: Mon, 31 Jul 2023 09:03:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next] net: make sure we never create ifindex = 0
Message-ID: <20230731090305.0c5fe7a1@kernel.org>
In-Reply-To: <20230730133219.GG94048@unreal>
References: <20230729015623.17373-1-kuba@kernel.org>
	<20230730133219.GG94048@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jul 2023 16:32:19 +0300 Leon Romanovsky wrote:
> > @@ -11271,7 +11272,6 @@ static int __net_init netdev_init(struct net *net)
> >  	if (net->dev_index_head == NULL)
> >  		goto err_idx;
> >  
> > -	net->ifindex = 1;
> >  	xa_init_flags(&net->dev_by_index, XA_FLAGS_ALLOC);  
> 
> You don't need to change xa_limit_31b, just change XA_FLAGS_ALLOC to be XA_FLAGS_ALLOC1
> and allocations will start from 1.

Because obviously there is a magic flag for this...

