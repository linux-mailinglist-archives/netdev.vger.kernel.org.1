Return-Path: <netdev+bounces-44844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03687DA1A2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538972825D5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54C3E001;
	Fri, 27 Oct 2023 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmFseqpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6B6128;
	Fri, 27 Oct 2023 20:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DDBC433C7;
	Fri, 27 Oct 2023 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698437371;
	bh=8qOe6zqYIHj2idbffsJjjD3PKCwT2I2KO9VeV9xYOBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MmFseqpxW/dyUy6rA8YaIn9QJEnX27j2eYgPn5MmaZ1tO38vPlrwopN2YKLjGj5fs
	 HSKDyyWSHvJi7XaR2kwH584E6TAsl0cFdi05Zzw+dbvrbgBighN82tYHY2lIUISORj
	 mQ/2gW4xZ2cWfWh7cnMPcd4O+8m6kJZuQ85wLaBQlGt4v7FE7PECBsu+UQeiMvoVm9
	 2I2awERvGAG77ZMZqQCZYRUim6BgL3h7gvAP77uZAU4hS/Ft+Xtjb24DXjhzdhdujn
	 JU00g/V3y7C8K/kfULDindPODWXNN6LMxL7Xo3aYPWdX0/PPYzS7eb62TQikp/zV7D
	 NSanvVwSXEOSw==
Date: Fri, 27 Oct 2023 13:09:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Simon Horman <simon.horman@corigine.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, John Fastabend
 <john.fastabend@gmail.com>, Aleksander Lobakin
 <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf-next] net, xdp: allow metadata > 32
Message-ID: <20231027130930.7d6014df@kernel.org>
In-Reply-To: <20231026165701.65878-1-larysa.zaremba@intel.com>
References: <20231026165701.65878-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 18:56:59 +0200 Larysa Zaremba wrote:
>  static inline bool xdp_metalen_invalid(unsigned long metalen)
>  {
> -	return (metalen & (sizeof(__u32) - 1)) || (metalen > 32);
> +	typeof(metalen) meta_max;

The use of typeof() looks a bit unnecessary..

