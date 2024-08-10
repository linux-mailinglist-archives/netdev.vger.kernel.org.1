Return-Path: <netdev+bounces-117366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A494DAE6
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224A6281560
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30A13C81B;
	Sat, 10 Aug 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDxIMJTT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE21CD37;
	Sat, 10 Aug 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267677; cv=none; b=CU1Th26p4FYl+rlub7ihbAwxCiNhH893vGVz/dmvAibx42gLtIE2zAbJBAp63nMXT9IscwOr8Mm3stqBWh0El9m+3CWNxFkExpAHsUbZkVlzuAa8aQrY0PeiyqrmNUhUQmAehEP9waiDAEclDeOcUTR9KF5Y/fUwHBXiVR/b8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267677; c=relaxed/simple;
	bh=ZRyDFNQw4PzqYPlRuv+Xp4nfbpJTGDpyUfszoxFzitY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cq9EdDX9vmfFiPtDhFhFWrtOw5+bp2VpnRjujnDBNwlpe9pXpPT3B2XuiHmZx6pmDhPuiWi1BTaDdVa3APcPL+y8omckLOH6HCNS1410meUPitnL2AEiB4OxzTLaZ64ai2zW+pPuvBkkla7O7XUQHXrvZaCxsZALBswWrJkJfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDxIMJTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA98C32781;
	Sat, 10 Aug 2024 05:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267676;
	bh=ZRyDFNQw4PzqYPlRuv+Xp4nfbpJTGDpyUfszoxFzitY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XDxIMJTTPpde2Fqclki+uzj44wOmbBB6aUt/MgqqFDCdf3isnnq8dPp3sMKciCzFb
	 FZZ+K/DWH4rce0GQCAkyN1zZd02DmM9w7WhqboSYNhrQ2kqEy5wiPZbf+hmvtYRKj3
	 P/z9sHyc/7S2mMiQk549D2eKF7tEsn0VPyKk+qnEYJsVo4yCyp8Xh89g9XV3W0zsRv
	 JtsVH2wquK7gCHzOvSIIJwXfdTLMMve0lvv/y4QiR7nKfWgBSTFU/5Nuxd910tTBAm
	 Ma5veOLyTmHDivQdKXH0IA50HInLwNMbyIoIXbiotSPWrIniY4tEVhoSgS1rVWYinJ
	 BqSy4KQvChZ+Q==
Date: Fri, 9 Aug 2024 22:27:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] netdevice: convert private flags >
 BIT(31) to bitfields
Message-ID: <20240809222755.28acd840@kernel.org>
In-Reply-To: <20240808152757.2016725-2-aleksander.lobakin@intel.com>
References: <20240808152757.2016725-1-aleksander.lobakin@intel.com>
	<20240808152757.2016725-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 17:27:52 +0200 Alexander Lobakin wrote:
> + *	@priv_flags_fast: both hotpath private flags as bits and as bitfield
> + *			booleans combined, only to assert cacheline placement
> + *	@priv_flags:	flags invisible to userspace defined as bits, see
> + *			enum netdev_priv_flags for the definitions

The kdoc scripts says:

include/linux/netdevice.h:2392: warning: Excess struct member 'priv_flags_fast' description in 'net_device'

I thought you sent a kernel-doc patch during previous cycle to fix this,
or was that for something else?

