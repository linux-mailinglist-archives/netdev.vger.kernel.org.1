Return-Path: <netdev+bounces-135718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2389699F02D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533FD1C20F90
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C301C4A24;
	Tue, 15 Oct 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRQL9w0S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13151AF0D5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003977; cv=none; b=SFIdBP54TOA0S7hxXsBVa4/tzO6Z35BgU0XM4qIdEXaZ7Vv83EmU+on12vzV7Dp6UnVzPcXp2i3WFpzgy+16Pflxj/X3xlas2cjWy+YOs8nb4R9fzMiNMZowZOM/awP6oLgpup+rZ0abe+lXi5/VZIMWlrpyIt5jkrVyuahIHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003977; c=relaxed/simple;
	bh=ULeqHrjM6cbbb/s4qCgU3Og1jHFr033Dqlv56eFagKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxKvefiJJcXqzJ7oZnh/+wX1HqYfjr43cGQ2VCgLbDIC+YimfkcvyXhI8NqVNcYjUL/2xw6kmNTZNyR3IJ80NL04Bz1KmSmW2nxg6s95VAlg2MLYxXDbkPBiqoBUuBzHRDuxIsQcgfMidMjHHbH9Mk14565gdJzS9NcLlAfell0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRQL9w0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAFEC4CEC6;
	Tue, 15 Oct 2024 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729003977;
	bh=ULeqHrjM6cbbb/s4qCgU3Og1jHFr033Dqlv56eFagKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SRQL9w0SZlfryymgG1uvMKHL6/+N8g2/+6xim/qUoXxzPvLDCvsEfXBp7uKJpf+x5
	 soKHGgyzAnC8DrtIG5Dv0sqWxym/2OsWLimZyPgAInZ/xbuMWR9UfEdAhbbJmS/n9s
	 /5rQrcndHIJV3L0AkOxxYK0jGmigK7JZ8YiTT/ukTyUU0tr13I7j/jE4s8oxtRdTK8
	 RoY9t1hSjvl4FE7OKA3fRi4trdrNCzK7ctWuFKb56adtMZ9gMURKiW+OH8FvftMBJt
	 v/d5cHjmzSeflwm5+rhSg9KChnjfg87h0Zw5GFqspKbgDsVPpQyBOAMMzX8CV/Yrly
	 UPrhu1WDT5sYQ==
Date: Tue, 15 Oct 2024 07:52:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH net-next v2] net: airoha: Implement BQL support
Message-ID: <20241015075255.7a50074f@kernel.org>
In-Reply-To: <Zw5-jJUIWhG6-Ja4@lore-desk>
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
	<20241015073255.74070172@kernel.org>
	<Zw5-jJUIWhG6-Ja4@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 16:39:08 +0200 Lorenzo Bianconi wrote:
> On Oct 15, Jakub Kicinski wrote:
> > On Sat, 12 Oct 2024 11:01:11 +0200 Lorenzo Bianconi wrote:  
> > > Introduce BQL support in the airoha_eth driver reporting to the kernel
> > > info about tx hw DMA queues in order to avoid bufferbloat and keep the
> > > latency small.  
> > 
> > TBH I haven't looked at the code again, but when I looked at v1 I was
> > surprised you don't have a reset in airoha_qdma_cleanup_tx_queue().
> > Are you sure it's okay? It's a common bug not to reset the BQL state
> > when queue is purged while stopping the interface.  
> 
> So far airoha_qdma_cleanup_tx_queue() is called just in airoha_hw_cleanup()
> that in turn runs just when the module is removed (airoha_remove()).
> Do we need it?

Oh, thought its called on stop. In that case we're probably good
from BQL perspective.

But does it mean potentially very stale packets can sit on the Tx
ring when the device is stopped, until it's started again?

