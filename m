Return-Path: <netdev+bounces-99240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065A08D4303
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82883B23213
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B81168B8;
	Thu, 30 May 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVS0zkBC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B887D299;
	Thu, 30 May 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033214; cv=none; b=H6oGW4SblIOPztHnsDcE8jwTrbzE2U4eMOqaTkRRZpFW1uGNnDT/QAfJDoHsDw6VeGAlvPMExwRuJSGY86qZbK8fBINuZKVg5jjRLGE5AQXU4pHtpa36jlXTAa0DjChhSUVVQi7LN22ZaLSmIs6pt1XPXJOp77orgAMzZ/HFpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033214; c=relaxed/simple;
	bh=/a3OkwfELwxb5Ut+MgxOZAlCZBTT6NvlJfjqQmhTdWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAchHOBNSx3v6MO8NraB3u7FmS/SSCRPPeO/ngAlDM0Y3r3m6U9CducDJ0E0O5choeTHTZdKvYBwLB5HF03zwArWuSuTi057+Batp92Kp15YWNHtqZMdKx9UG/sQREmPOuMR3d6k8VmvdaYhfUMCaniMceldOgqVBaHGOqHAgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVS0zkBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9478EC113CC;
	Thu, 30 May 2024 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717033214;
	bh=/a3OkwfELwxb5Ut+MgxOZAlCZBTT6NvlJfjqQmhTdWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVS0zkBChjBRfxjrk8h/Y2AmlnvdB+d8eGeHKJMORQ8Bjl8Xa/rn/45y/Q52ptF7V
	 Td7y4bX6N1H8YykoITZLPrmj+d6vPHa1DrqcrRrDsX/l47Z9LwW13399gZftI465pU
	 V56yNHpriGlaYYgoEjDD/saXWZiuazVXuJB4zTC+G5n+ZWTBR2HqL8P5Totxofpzn5
	 26JOioMSPfyw8J89E6RZIwphvXgp3tOltPD8krCXb2xpKzYmdtwWt00nOzbFD6HJ/e
	 EySqqyIOuNHU6aXi/NIcVxeWzErvWXkXovJVoAcJlwLPvZM1CHLjiRXI7bGhVWHen/
	 GPyjGMqrwsTVg==
Date: Wed, 29 May 2024 18:40:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mina
 Almasry <almasrymina@google.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 11/12] idpf: convert header split mode to
 libeth + napi_build_skb()
Message-ID: <20240529184012.5e999a93@kernel.org>
In-Reply-To: <20240528134846.148890-12-aleksander.lobakin@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
	<20240528134846.148890-12-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:48:45 +0200 Alexander Lobakin wrote:
> Currently, idpf uses the following model for the header buffers:
> 
> * buffers are allocated via dma_alloc_coherent();
> * when receiving, napi_alloc_skb() is called and then the header is
>   copied to the newly allocated linear part.
> 
> This is far from optimal as DMA coherent zone is slow on many systems
> and memcpy() neutralizes the idea and benefits of the header split. Not
> speaking of that XDP can't be run on DMA coherent buffers, but at the
> same time the idea of allocating an skb to run XDP program is ill.
> Instead, use libeth to create page_pools for the header buffers, allocate
> them dynamically and then build an skb via napi_build_skb() around them
> with no memory copy. With one exception...
> When you enable header split, you except you'll always have a separate

                                    accept

> header buffer, so that you could reserve headroom and tailroom only
> there and then use full buffers for the data. For example, this is how
> TCP zerocopy works -- you have to have the payload aligned to PAGE_SIZE.
> The current hardware running idpf does *not* guarantee that you'll
> always have headers placed separately. For example, on my setup, even
> ICMP packets are written as one piece to the data buffers. You can't
> build a valid skb around a data buffer in this case.
> To not complicate things and not lose TCP zerocopy etc., when such thing
> happens, use the empty header buffer and pull either full frame (if it's
> short) or the Ethernet header there and build an skb around it. GRO
> layer will pull more from the data buffer later. This W/A will hopefully
> be removed one day.

Hopefully soon, cause it will prevent you from mapping data buffers to
user space or using DMABUF memory :(

