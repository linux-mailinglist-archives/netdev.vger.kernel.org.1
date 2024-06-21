Return-Path: <netdev+bounces-105805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AC912E69
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 22:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58231C21012
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF5216849B;
	Fri, 21 Jun 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z54p/2Jp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C1156F2E
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001202; cv=none; b=B80vNfbtOscoUKHq7QKWRG49dpMiV1wEqFfeAVUjXyrtEw6GC7ppfy/ffELrqAyuzapbxjr1fc73G6ykt6bbHsS/KHcWmR7TOnrfu/XLy6i0o2eA2DW1XU+HiYv13yFyveKmprfjvAqMZndx1+qe2tJTZfrGFhK9W8m6RgUQBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001202; c=relaxed/simple;
	bh=bZN0IhRVI02xHvZjdoaBe9yK4aixo/GeHqSUKPuTuuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNV1ezhv0+ADUJNVu4w3hpQoyv+zUogyNlxZh2+TWHQqEFZGoxUGuvMyztRp+imZ5erFWa/ygCPc1OLNSLXLKQWy0gGnsoxBHRD86tM7plhENINSzqoShKGVut6IyI/UuOWN+4ifORoPJ5SJgpsfDd/CGbrnsyRfKr3uk4uHtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z54p/2Jp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rtQolWAVt290fkCNZrZaV/A+RMU7zVq2j/xIedg8JZ4=; b=Z54p/2JpMwSiPhKSOzRfjBDkvE
	a6V3m64F8ekTJuAtPJAAly774MBirCmGVWBXQfZ/rZHwBBryCPdiufLdyqr0SPfYDvU/ICpch2pvg
	uGu3N+y1OudYxSLUZUBmpCS5lDbwQ5oCP4ZkQtKYWLCsvPKPbiNrsAFC63a7803f6IWk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKkjl-000hLU-6F; Fri, 21 Jun 2024 22:19:57 +0200
Date: Fri, 21 Jun 2024 22:19:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Allen Pais <allen.lkml@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 14/15] net: marvell: Convert tasklet API to new bottom
 half workqueue mechanism
Message-ID: <e96a54d2-5908-4277-871b-3ab532482ea1@lunn.ch>
References: <20240621183947.4105278-1-allen.lkml@gmail.com>
 <20240621183947.4105278-15-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621183947.4105278-15-allen.lkml@gmail.com>

On Fri, Jun 21, 2024 at 11:39:46AM -0700, Allen Pais wrote:
> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
> replaces all occurrences of tasklet usage with the appropriate workqueue
> APIs throughout the marvell driver.

drivers. You are modifying two here.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 671368d2c77e..47fe71a8f57e 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -2628,9 +2628,7 @@ static u32 mvpp2_txq_desc_csum(int l3_offs, __be16 l3_proto,
>   * The number of sent descriptors is returned.
>   * Per-thread access
>   *
> - * Called only from mvpp2_txq_done(), called from mvpp2_tx()
> - * (migration disabled) and from the TX completion tasklet (migration
> - * disabled) so using smp_processor_id() is OK.
> + * Called only from mvpp2_txq_done().

I've not followed the development of the bottom half workqueue
mechanism. I assume the documented assumption is still true? If so,
please could you reword it as appropriate, rather than delete it.

Thanks
	Andrew
	
    Andrew

---
pw-bot: cr

