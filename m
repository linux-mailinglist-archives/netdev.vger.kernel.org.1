Return-Path: <netdev+bounces-49813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEDD7F387D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98B8B216CA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC34584FA;
	Tue, 21 Nov 2023 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/raVCXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6514C584DB
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 21:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F9AC433C8;
	Tue, 21 Nov 2023 21:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700603349;
	bh=DpnixQJFA9eb8M4A75hdBojY32xhtK+7sGsb55CVSjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/raVCXqJD4Q7OURGuMUEAWD0kFWzz+YDjBt9CwmjFPZJ5jxF2p9knnVoqnpf7SgC
	 NLZHj7+F4ouDwo437+3yFOehTRZz/3g5sXMVRzsSjtFpKFEQdhajeHqAxEtk0qlCtU
	 FRfrP3P0ml+wOJDmqdGZS7Ip1Bi/t78BLsIiAZfSprWnodzt9rWNQ3+U0WJRx1EG4S
	 mpNiH0Pa2Gb0P+4x5o0FxlxDMsmdgHDHZpWl4gdCIw6PcoqQXMQb81afL6iwLxKYkX
	 R1ptTgxgReTCctUau9h2W5epCygAY96niwi0iQSBVAJHzyNyvs9V23G0jvoJFA6UtC
	 NzrHhRUgYUCww==
Date: Tue, 21 Nov 2023 13:49:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v2 12/15] net: page_pool: report when page pool
 was destroyed
Message-ID: <20231121134908.54619aa5@kernel.org>
In-Reply-To: <e64de1a2-a9c6-43e0-8036-7be7fbf18d52@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
	<20231121000048.789613-13-kuba@kernel.org>
	<e64de1a2-a9c6-43e0-8036-7be7fbf18d52@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 21:45:57 +0100 Jesper Dangaard Brouer wrote:
> Hmm, this is called when kernel could *NOT* destroy the PP, but have to 
> start a work-queue that will retry deleting this. Thus, I think naming 
> this "destroyed" is confusing as I then assumed was successfully 
> destroyed, but it is not, instead it is on "deathrow".

I wasn't sure what to call it so I called what the driver API is
called...

"deathrow" does not sound very intuitive to me. How about "detached"
or "removed"?

> Could we place this PP instance on another list of PP instances about to 
> be deleted?
> 
> (e.g. a deathrow or sched_destroy list)

Is there a need for that?

I mean - many interesting extensions to this API are possible.
I don't think they should all can all be here from day 1..

> Perhaps this could also allow us to list those PP instances that 
> no-longer have a netdev associated?

The current implementation uses loopback for that, since it's naturally
tied to a name space.

