Return-Path: <netdev+bounces-143901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77D9C4B5B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E2D280F41
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B00202F77;
	Tue, 12 Nov 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBTFoOpw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B046202F72;
	Tue, 12 Nov 2024 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373064; cv=none; b=NmGPZVDaxLI6/3Qfr/Lnl0RWgEaMv8efTC5sgh7QJ0pv9vz/vNWIqZBZDagu1P+n/2DWEkGFtKlt1PI8RB/qbaR98A0VK/rHxrWLlgPA4a/mfmUijz/74+WpbaLFneNEfrKLyrFfiiZNvMaezNBoEHMOAG31CdGcRn04WccRcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373064; c=relaxed/simple;
	bh=X1jU4OrC6TnsSC5AwwgJV79bbLnBG6QPTMhrUM2HahA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4tYByd/2Gofh2eu7Ubk16A0cRqESMsWjVbpUOAD3CQqsMtmZRoQrWUfSZPmhEY6FmOw6BPf2d68SM4TYO/wle2H4FhFTQzpMDEypPF5Pmiqb2Zcmgl250SBdci8MnVLucL2N1/+W04cW8SHdNce+GOb+FaO8PoUE5cUeyth52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBTFoOpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414AC4CECF;
	Tue, 12 Nov 2024 00:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373063;
	bh=X1jU4OrC6TnsSC5AwwgJV79bbLnBG6QPTMhrUM2HahA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kBTFoOpwxLbNrn4rxNOhy6Z4CkhWhm0mzqIiwM1+XvJ23WoZWci94D+Et0RAEqGON
	 x/fblNAIIdGywS/PBQjrRpXmiiTDl1GaCk9ejr0Jq+XnIDoQNIciBd7wTKa1IukYsI
	 t6x8zxm0XwyPlPsv4YLOHbR1lowLvadURtmYdKjqS2arHhR151sDqM9iNtJMcatCED
	 2m9X18n5fBBRHMQx8gZ3hymzAoNat4YTmJ9RNCfc9W1o/ntEbIvq8OBtaR7UaM2/LJ
	 PYA3QcvGQfuSaeOHoRfSm3cLjWEmtYuRsv/GP+DKuSxKg2qmxkoVFCEgqte/V4izv7
	 HImIpV8Icpi6w==
Date: Mon, 11 Nov 2024 16:57:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: netpoll: flush skb pool during
 cleanup
Message-ID: <20241111165737.129c8d2b@kernel.org>
In-Reply-To: <20241107-skb_buffers_v2-v2-2-288c6264ba4f@debian.org>
References: <20241107-skb_buffers_v2-v2-0-288c6264ba4f@debian.org>
	<20241107-skb_buffers_v2-v2-2-288c6264ba4f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 Nov 2024 07:57:07 -0800 Breno Leitao wrote:
> +static void skb_pool_flush(struct netpoll *np)
> +{
> +	struct sk_buff_head *skb_pool;
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +
> +	skb_pool = &np->skb_pool;
> +
> +	spin_lock_irqsave(&skb_pool->lock, flags);
> +	while (skb_pool->qlen > 0) {
> +		skb = __skb_dequeue(skb_pool);
> +		kfree_skb(skb);
> +	}
> +	spin_unlock_irqrestore(&skb_pool->lock, flags);

 skb_queue_purge_reason(... SKB_CONSUMED)

should be able to replace the loop

