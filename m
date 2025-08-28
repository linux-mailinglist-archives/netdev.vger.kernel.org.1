Return-Path: <netdev+bounces-217883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CDBB3A462
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CCB4677D1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563FB227599;
	Thu, 28 Aug 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVxtdhtE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AEB22689C
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394775; cv=none; b=MfoH3IHnYEvGZlHV2/O7LX30JkHeOHx/Yo3u+zd92rUg3DEikFDJOWPepaRxCb0x4b6Py0pDIggFM+VT5eEP+UV0CdCX8P/b8uCHtQuh1MsRKRWHkt0KBGsW5C/uf1XV7hJEMSgFYKzTPsaW7wQBeFmf6WESbJYI3z76X+65GXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394775; c=relaxed/simple;
	bh=LKxEw1OmIQI8RB8qGjvG3dJ8sEMFzODGxSmSws9LYuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMgKlgwKOyDMmY1wWVb44zravEpk0XzQNNNYM6TwfIG6SO6QlHklL3lAsX/jrJaksyEtnM3iXftA0bjtLnMSkE4cj29KuOKIHCUtMA5hR8eFHTdoORipfprVGogMcgDfJyCvefaw1UJXv1ccQcykJhOm8dibuCpdrWawdDEJGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVxtdhtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADA8C4CEEB;
	Thu, 28 Aug 2025 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394775;
	bh=LKxEw1OmIQI8RB8qGjvG3dJ8sEMFzODGxSmSws9LYuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVxtdhtEDm/bZbNBgkoxEctnsZ6fcrQkJS/kSVRLHJmBKq/P021WaugCy8LoY04Lv
	 g7/IqZ8voi7pB5F/nxXGyUvuXH1aJ1bFXSFf0sI0f5FgSle7CjXLaDKlBTf6PhHKDw
	 DbCfG1Mw0qrNTAmIhT0T5rAI6DNZl8AaQjoYEvCo+twedgx2NXtb9snrHeAK8aMbaU
	 sbOMNGx74PmMYHUzLLl/TirntI76/GfUvjIxm/96qYnDgLUWCJLZu8Bo70pLZwfWtf
	 xJARfJpU0pFazUK8RhTx5ejNiLKFvbr09JSgnLglIcAp1gBJcRRMPl0dnw1f4gLkV6
	 g7QXuTYQJAl/w==
Date: Thu, 28 Aug 2025 16:26:11 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/4] net_sched: act_skbmod: use RCU in
 tcf_skbmod_dump()
Message-ID: <20250828152611.GT10519@horms.kernel.org>
References: <20250827125349.3505302-1-edumazet@google.com>
 <20250827125349.3505302-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827125349.3505302-5-edumazet@google.com>

On Wed, Aug 27, 2025 at 12:53:49PM +0000, Eric Dumazet wrote:
> Also storing tcf_action into struct tcf_skbmod_params
> makes sure there is no discrepancy in tcf_skbmod_act().
> 
> No longer block BH in tcf_skbmod_init() when acquiring tcf_lock.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


