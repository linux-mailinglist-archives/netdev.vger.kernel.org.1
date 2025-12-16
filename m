Return-Path: <netdev+bounces-244889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B78ECC0DFC
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1657A300502D
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F42334C2F;
	Tue, 16 Dec 2025 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmwJBtzH"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C332F74C;
	Tue, 16 Dec 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858833; cv=none; b=uS4GYpjMKHM91PoCnN3BwJeIfVbuDteOOmlFKOJQK5MNvmW3raLinohH09osV9IRr0BbWLCAEptPJqUF9/AjkTZ6KLyp0Qa4qKa8FuE1Anbw4bNGPuwVWI8Hhf1WIQKj5+o/TIuLchNLjiuPnVvWYvwSzboCxpdQcdMc5AFe7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858833; c=relaxed/simple;
	bh=wOdAh4tEPxCrrw0UeiDwtvSD5RwgC658OBnRtzXlSiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQSZnkgn5tdxKxxy6RapWfiyAYrpJSUagwTh/vUHuvNfYQ6anWirAZAhcDq8JPaHoUdkwQRn6j/X15C7uNZuBgQYIVZcl3BZvhqqBZ+o4jBMltfjEQvNct58rx0lVhZ2BABpBXhVebEJnS/OZJIWAiIiC1qaciJEfxDSmy0Y0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gmwJBtzH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6qQGXRw0JmSkbF1VRkTl2wi0ub7QsQOJpcz3FBQSCoQ=; b=gmwJBtzH6RNaOjJj8Ol+4ChGWs
	DLQ0MAdjqAWUojtjOdaaXRyI4S4UO50luZzYFGyO5UfHShg/i15PVUkr0z/RmCtNxLUxgaxSYHXMl
	2qN1M8cSXnrf754uT/fumx1dujDsKyolpWokXTECXKNKTQm75uW1tks19MZcTvr9NQZN2dYOXb6H/
	dDykcWGidk1hOuv42iF6Qs4qtrpFww65yJV8boCeE/BEvBsR+DrvVJ5N2sT1oY3f3e28GDI4v/48f
	LCPwi21hE8hQdy8oZdgHYTjQAtZFaSmlVqJue3lagnSUrgCc3MyF2jiPyl46XkByiv5PlFfI/GRuD
	m+eqLKLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVMXe-00000002o0y-3VFp;
	Tue, 16 Dec 2025 04:20:06 +0000
Date: Tue, 16 Dec 2025 04:20:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, harry.yoo@oracle.com, david@redhat.com,
	toke@redhat.com, asml.silence@gmail.com, almasrymina@google.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next] ice: access @pp through netmem_desc instead of
 page
Message-ID: <aUDd9lLy76sBejrP@casper.infradead.org>
References: <20251216040723.10545-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216040723.10545-1-byungchul@sk.com>

On Tue, Dec 16, 2025 at 01:07:23PM +0900, Byungchul Park wrote:
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1251,7 +1251,7 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
>  		rx_buf = &rx_ring->rx_fqes[i];
>  		page = __netmem_to_page(rx_buf->netmem);
>  		received_buf = page_address(page) + rx_buf->offset +
> -			       page->pp->p.offset;
> +			       pp_page_to_nmdesc(page)->pp->p.offset;

Shouldn't we rather use:

		nmdesc = __netmem_to_nmdesc(rx_buf->netmem);
		received_buf = nmdesc_address(nmdesc) + rx_buf->offset +
				nmdesc->pp->p_offset;

(also. i think we're missing a nmdesc_address() function in our API).

