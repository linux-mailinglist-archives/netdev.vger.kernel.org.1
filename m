Return-Path: <netdev+bounces-117696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3E94ED5E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DC9B2185F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBC17B508;
	Mon, 12 Aug 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWVEH93T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761E17B4FC;
	Mon, 12 Aug 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467015; cv=none; b=tXU4mCEmpX7GtRPtE1FAArY/Dsv88l5l48m1jEIWV9SFDm6NU2WUi0Wxyn8jZPMFdoLQchNaUt0ALGdbRwbnr8b/SfHL/Ikw+GBb99fjJHmtHTitGV4QhJoppQlZKoNljwaegtHG7w3I6lBlhUXFyyghZ4Aw5zdf/51tZFneq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467015; c=relaxed/simple;
	bh=e1KaX42oZAJAJMbEl7Hl/Uf9FVrBnvs4EClAfrvP4mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIWxiFbzyenIwJkV9C23KH1jAL1oF86Eh/SvdLIQyXkYS29pqHjppxfmz4tNY+zScweDhGviepwHiMcqGy4hnMbJzR8ux+kAv27HXQs+30WBdG8/O8aNhKb+qKdQsI36lYrGmBm19UrBILw+96enVOsXMRfam9c4NGp5CwzSLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWVEH93T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DB6C32782;
	Mon, 12 Aug 2024 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723467014;
	bh=e1KaX42oZAJAJMbEl7Hl/Uf9FVrBnvs4EClAfrvP4mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWVEH93TW+5hMhHZgdD60lTMGr0rBnl7IiqNahYPGoT7V2NgWTbs0Fi/djoIJjfPn
	 hsOMBgYHPrMb20FsAhQr9i3CkvOHteVPylFgY417l4FPsrEIhrq/mlB9qFO4jY3+lY
	 2VjgdelpEJJ1SOyd6IEx/KLWFraVTYrAcEpPHcQvQ2vy3hHwhNqXba4Vm/8HSpamIa
	 tXVpWxkgtU51QOo5RCMLmEKyv5QGj53M92q+iktRHq6Qc5uJ9dXFHPTODFhj0jXSNc
	 B24M+WlAA2WCUy6njtFeIRz4y7h4IwgyYh0x/zjhB8Cd3nlgJoZ1DfO5wLsPq2U+DJ
	 csUH3h2g3fm2w==
Date: Mon, 12 Aug 2024 13:50:08 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/3] ipv6: Add
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Message-ID: <20240812125008.GB7679@kernel.org>
References: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
 <20240812-ipv6_addr-helpers-v1-1-aab5d1f35c40@kernel.org>
 <827bbb8a-2d5b-44a4-81a2-258c7713ef59@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827bbb8a-2d5b-44a4-81a2-258c7713ef59@lunn.ch>

On Mon, Aug 12, 2024 at 02:37:36PM +0200, Andrew Lunn wrote:
> On Mon, Aug 12, 2024 at 01:11:55PM +0100, Simon Horman wrote:
> > Add helper to convert an ipv6 addr, expressed as an array
> > of words, from cpy to big-endian byte order.
> 
> Hi Simon
> 
> Is cpy supposed to be cpu?

Yes, sorry about that.

> 
> Otherwise, please add: Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 

