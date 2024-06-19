Return-Path: <netdev+bounces-105082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B19890F9D5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17C2282A4E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FB15B548;
	Wed, 19 Jun 2024 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLg8T1Nq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD215B15F
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718840676; cv=none; b=CwiAvieEWAImQXyTx3PSi5FQNwpiV+YcjTI1rG6Zso/h/GzIBcXxJXgeWQT6f03+mWvBuOilzBpi2dpvMlhPfhpmRoppqLhzNbwybJ9tIrF4vmOEkF1NAMM3Vo8/Mdlawxr6NZdp4hYlUg0mFYVBomgOEsgnVBzym+VnQ1GMIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718840676; c=relaxed/simple;
	bh=7QL/aCKqqmrZvjDnwqGIOyocu65Z0NKxHahCR7CRCXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrFMz2DWEAdBtdr/GXuLN2I3+/KcL/QPWofoPiHWXrvL/0rF7Wdb2nFULFjQuzh620I3+loxVcezWQkAq/tph4oCp2hfPebOA1Wh3D08wUw7/drso8UFLjioZ/PFQrv2pUiC+Sx5rxZvFNMWcp4eDVwcauMnXPWHN1HDx/Zfu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLg8T1Nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8718C2BBFC;
	Wed, 19 Jun 2024 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718840676;
	bh=7QL/aCKqqmrZvjDnwqGIOyocu65Z0NKxHahCR7CRCXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YLg8T1Nq6WDADneUzHOIa5BgOBF1svmzVDCWERbs41/yncZOyyby5yypoVg9NjWTA
	 szqtF4med7VF3ZMzjh3d1kklS+ByXKnzG8kODqzxNtitwN1541qk+bvhsxct+PeGZq
	 5voDIIiYU/hGN86Bavx3fIY/K6W/IeiT584D3asjZ5lvUzX3+f3BxGXp2Ri9EEC0fa
	 CDeZ5lnOAUfysXT4ehW2RVkln4idYRxmHyv74b7prcWqKedghwmbCSKtDZu3rb8//R
	 D+0s+ifi9WGogTxZimUJSqhxg3OyvRzdOfdVdrB7LkuWY7uzWNJTUilAMG5SY8veH/
	 ITbioKC1I/Dkw==
Date: Wed, 19 Jun 2024 16:44:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH net] ionic: use dev_consume_skb_any outside of napi
Message-ID: <20240619164434.46acb9fb@kernel.org>
In-Reply-To: <20240619212022.30700-1-shannon.nelson@amd.com>
References: <20240619212022.30700-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 14:20:22 -0700 Shannon Nelson wrote:
> I found that ionic_tx_clean() calls napi_consume_skb() which calls
> napi_skb_cache_put(), but before that last call is the note
>     /* Zero budget indicate non-NAPI context called us, like netpoll */
> and
>     DEBUG_NET_WARN_ON_ONCE(!in_softirq());
> 
> Those are pretty big hints that we're doing it wrong.  So, let's pass a 0
> when we know we're not in a napi context.

Just pass the NAPI budget in, and if not in NAPI pass 0.
A bit more plumbing thru, but a lot less thinking required during
review..
-- 
pw-bot: cr

