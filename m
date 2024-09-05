Return-Path: <netdev+bounces-125308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52B096CB8C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7042A2881D3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4338C;
	Thu,  5 Sep 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC51BajV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F731184;
	Thu,  5 Sep 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494959; cv=none; b=ZW3oWBjJ9RabeDXUhG4mtaPmMtsfpLCQ/C7XS06/g23Y5LtiI7yZARAv1uXaBxFtXsC/khCRwMBWQVE6uJBypWj8bNJrLu4zSvhJsdde1/nJzhaDcoWjNj/ftTnJKRPIPsAxvemEWKpx0X+9ogL9hRDvMNSPp144KpZ9GNiKeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494959; c=relaxed/simple;
	bh=q3AawZYiR83gvNqLyrg3h35TpmUjY6dSAlxTeoKxfcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSo0DKWbjpcE4dbQi6D8Y6rtVe+jZWayJOr79Z0+HmeYE/rcM7xbF3sYmXkLGL9qLeiFhFCeQ2U08vVURCd0i+qv3Y9EMF3B8ryo4E3aCpdBecvsfLlT4MLZEWqY3wvtVVHCP9sq7pxV3jsjxcHor3zMsUyxyqpf0EZFRinxeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC51BajV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8D4C4CEC2;
	Thu,  5 Sep 2024 00:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725494959;
	bh=q3AawZYiR83gvNqLyrg3h35TpmUjY6dSAlxTeoKxfcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PC51BajVeh8uoZEgXFXMlKJi/HIycQJtgVU0WBCWlMliGx3g8guZRxNc/MGJQykxH
	 MOsqd4JrGA7ZkMSO/raxNMsMhNiuJ1BkKI6A6ukmPFOBi3gntdT7KOqbWUmJ4NcIxy
	 FYwZk8WQEWZ6UtphDOVYvo71zGHpYjKVgN1EhVHpt4ZO/DP9sBVeN8z6GkIhXP75DX
	 yQqNpc3qtpumSa2dOjD7Cyki01Ledo1m0J2I8UZAhICtaE9hKyOQAIXSJgccMA5AnQ
	 IXd1N131JwopHBjQW8MItzWEqFB+UQj7Tp6tR5JbcrYl7pK9M742Z3JMMZ1uGWf/jC
	 E482mY15sYcmg==
Date: Wed, 4 Sep 2024 17:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@amd.com>,
 Andy Chiu <andy.chiu@sifive.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: xilinx: axienet: Fix packet counting
Message-ID: <20240904170917.29692bcb@kernel.org>
In-Reply-To: <20240903175619.4133633-1-sean.anderson@linux.dev>
References: <20240903175619.4133633-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 13:56:19 -0400 Sean Anderson wrote:
> axienet_free_tx_chain returns the number of DMA descriptors it's
> handled. However, axienet_tx_poll treats the return as the number of
> packets. When scatter-gather SKBs are enabled, a single packet may use
> multiple DMA descriptors, which causes incorrect packet counts. Fix this
> by explicitly keepting track of the number of packets processed as
> separate from the DMA descriptors.

budget doubles up as a "are we really in NAPI" flag.
You can't pass non-zero budget to napi_consume_skb() if not in NAPI.
-- 
pw-bot: cr

