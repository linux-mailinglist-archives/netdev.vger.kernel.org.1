Return-Path: <netdev+bounces-166669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69897A36EA9
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 15:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC9189550B
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7564156C79;
	Sat, 15 Feb 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdkeIjoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62F8634E;
	Sat, 15 Feb 2025 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739628070; cv=none; b=UPKUMdMCzR4EseavdWi7cRU3zEdbo/Go4pdZQMteyh37Mwy8IORtD+GPcpBxVQhR75JYz3zTf/4C05rbgeejeqvvRxRDUcRMGHchVYL6lHkbEi4cCR/s6W35af7AMyzYCjWoRXHw7iKuGnehqAJN06fhgCLI+QzympdtJ8TbZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739628070; c=relaxed/simple;
	bh=3KZjQFG9kWj7eD82rZJTbZ9FPBolNJSFaZ87/g22y1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0AE3Vw5Pgc+XA1tSwRLZfDwZbt9F2J8ezrU00JY6R0NzwhZNWcCQ7xV+4ka9RYjIEvnELHKzraMSa4tocO5y4v3ODC1uguxSnI1+No5uBv4sGXKJ/zGBr1ztgwBcG7bwnD7jgUbqPTPcKBNnFsuQo8jHUVZRJpvzzfzx9IG3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdkeIjoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822DEC4CEDF;
	Sat, 15 Feb 2025 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739628069;
	bh=3KZjQFG9kWj7eD82rZJTbZ9FPBolNJSFaZ87/g22y1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdkeIjoaX5Cb1zuFkBFKRC5hh5M29XZV6OoodO/ZlM3RWcOllZD4faWThxIxKAilu
	 /iuMlnTsVOmvaUlKMWzMz5ioNFJOXsiMMall0OHQ5poQv5AalO30eE62ksKJNLys9m
	 avuff3LzCUsjxCRVh/t92j1yyH3H7FvPdXrKUOKmWJxLUey6VcZNnyDE1WeRjBfOt1
	 AAyWl08v6RedA0ScYvadnEDN2CwZ1fjFeeB+ivrxUOi3LQvWGLreBwFsweGGPCKke1
	 LDUWOLGA7xmCvobdxxd+EikL5WJC7hNXcHgTv8xCmhg8BHfFCEsi2cvputIOqUNCB7
	 SwzWhYoCaaffA==
Date: Sat, 15 Feb 2025 14:01:04 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 net-next] net: ethernet: mtk_ppe_offload: Allow QinQ
Message-ID: <20250215140104.GO1615191@kernel.org>
References: <20250209110936.241487-1-ericwouds@gmail.com>
 <20250211165127.3282acb0@kernel.org>
 <fe6509ab-c186-47c1-b004-4e17a875c5c7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe6509ab-c186-47c1-b004-4e17a875c5c7@gmail.com>

On Wed, Feb 12, 2025 at 08:33:52PM +0100, Eric Woudstra wrote:
> 
> 
> On 2/12/25 1:51 AM, Jakub Kicinski wrote:
> > On Sun,  9 Feb 2025 12:09:36 +0100 Eric Woudstra wrote:
> >> This patch adds QinQ support to mtk_flow_offload_replace().
> >>
> >> Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
> >> of PPPoE and Q-in-Q is not allowed.
> > 
> > AFAIU the standard asks for outer tag in Q-in-Q to be ETH_P_8021AD,
> > but you still check:
> > 
> >> 			    act->vlan.proto != htons(ETH_P_8021Q))
> >> 				return -EOPNOTSUPP;
> > 
> > If this is a HW limitation I think you should document that more
> > clearly in the commit message. If you can fix it, I think you should..
> 
> It will be the first case. mtk_foe_entry_set_vlan() is limited to using
> only 1 fixed protocol. I'll drop the reviewed-by, amend the commit
> message and send v4.

I agree with Jakub's comment regarding the spec, and his suggested actions.
But, FWIIW, I also think that situations such as this are not uncommon in
the wild.


