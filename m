Return-Path: <netdev+bounces-206830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B750B04773
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCF94A6019
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A024C060;
	Mon, 14 Jul 2025 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6ZlDIXZh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E826FD8E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752518361; cv=none; b=TI+Ie1UK+uf2v8PLpHBAMSzE/3qJc+wziuAiqBPfquawnXIN8Wu9NeImT4b8BC+4se/0WrXXXWb4U9mssB33pUfOxgXZX4d4qxXc11oU6TJXu4jkPiLDbwbZMOkEGv5W+wxHvfqrsrT8eE4t0Qf+7q+Ru0Fr0f6uf2LE+4jUZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752518361; c=relaxed/simple;
	bh=SubsgNZCCaeG9QVxEyW6Hg20M0b1soMMkVGUNSuhzww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLWXnGKBLuZbHKVfU7wR0TOcG/ocsp+m9Zcvs+LKJIPT0ZNU2f0c3At2YPIEuKCA/NxHTMCw+8RT1iYKSt74AkzutGr323yScQM4rJXaNQxFXBSSKjLP5tDuFUSvvXVDJLmvgNjfmgoocAbCKp1vVGePKzOWwB/N4waNSp60D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6ZlDIXZh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VHshUn4Jqsjc36RFvXDqeUrN9tkhjfQpm1zjkj8ZSrk=; b=6ZlDIXZhD2UmKvILONrgZEctz+
	3bPo9jpQ/hYy+lc/C4aatJppzjAhFZcUq+LZWigfTFhanQxkWf5olK8WVbw40Wl7arvTAaGGwnT+8
	h7Bb3FxhKW7JAl9//aZyzOqAeK3I/qPIXk2c9w825LWBsQKlBsA5rvFPduqVHRM5S00I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubO4u-001Uus-IQ; Mon, 14 Jul 2025 20:39:04 +0200
Date: Mon, 14 Jul 2025 20:39:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sayantan.nandy@airoha.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: fix potential use-after-free in
 airoha_npu_get()
Message-ID: <555d7fb6-091e-4c10-bfea-85898e644481@lunn.ch>
References: <20250714175720.3394568-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714175720.3394568-1-alok.a.tiwari@oracle.com>

On Mon, Jul 14, 2025 at 10:57:17AM -0700, Alok Tiwari wrote:
> np->name was being used after calling of_node_put(np), which
> releases the node and can lead to a use-after-free bug.
> Store the name in a local variable before releasing the
> node to avoid potential issues.

The description does not match the patch. You are not storing the
name, you are storing a pointer to the name.

> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> index 0e5b8c21b9aa8..30cd617232244 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -400,11 +400,12 @@ struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
>  	if (!np)
>  		return ERR_PTR(-ENODEV);
>  
> +	const char *np_name = np->name;
>  	pdev = of_find_device_by_node(np);
>  	of_node_put(np);
>  
>  	if (!pdev) {
> -		dev_err(dev, "cannot find device node %s\n", np->name);
> +		dev_err(dev, "cannot find device node %s\n", np_name);

What you don't describe in the commit message is why the pointer to
the name is valid. After the of_node_put(), the node could be freed,
and i would assume if the node has gone, the name has gone as well.

I think a better fix for this is to move the of_node_put(np) to later.

    Andrew

---
pw-bot: cr

