Return-Path: <netdev+bounces-124308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FDF968EBA
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 22:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC15B202DC
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B71CB536;
	Mon,  2 Sep 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6ABIrLRT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CC1A4E99;
	Mon,  2 Sep 2024 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307583; cv=none; b=WHLSCi7fzwt7fJ2OHNZhfagEHdseq/7UFLV1RC/X89pgJrH6BpXYGmabqhmAGrMD8i8qvFWqJ/9BrsI0MjjkTSEicrRsBiJW4L37u95n6IaMw5B9/oZikqOSkfndSFjDhr6mucHzHBkJhW/+zpR7jA3Wr0XMSxSCvQQ06LtlD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307583; c=relaxed/simple;
	bh=B/+0StplH1RHDGfN7NxuJ1nu5k0Gw/z/vX9zMjSShFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJyujDos82++J/FST6cSDRUxhC1rk0a9kan357CxX0GC0v/tpAw1Ds0jBng8//yv3gXHjXMmZRW/7yu341Oruiumm94vG7NkPodYshJgrnWfT+Cy/RlWDk4GA70Z3xc3xkZiCX6seSfT8RaZymfA+N7lqPnKLLYoPMX2tbqtH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6ABIrLRT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4ko4oJaKsPBrSHMqxY8h/Bc8e5D5+9ThHWKUHsZ8sGI=; b=6ABIrLRTwGNjNRWmQALSNMFBlP
	3w71BY9PgN7stMuVhHjV+e0jsXtX+gaJDnd1i+IRz26FlLoXxPwNNKlFj/oc3LSohv5qkT7ZmZWOd
	xaJZhLi+g81Z34ylJZwebO78rALaX1fd/qvOQRCTmhLN6CY50Zl9xKY2qCZoOUo/YJFA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slDJW-006KtV-AX; Mon, 02 Sep 2024 22:06:14 +0200
Date: Mon, 2 Sep 2024 22:06:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCH 2/6] net: ibm: emac: manage emac_irq with devm
Message-ID: <7812014c-a77f-441c-bcab-36846a3037cf@lunn.ch>
References: <20240902181530.6852-1-rosenp@gmail.com>
 <20240902181530.6852-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902181530.6852-3-rosenp@gmail.com>

On Mon, Sep 02, 2024 at 11:15:11AM -0700, Rosen Penev wrote:
> It's the last to go in remove. Safe to let devm handle it.
> 
> Also move request_irq to probe for clarity. It's removed in _remove not
> close.
> 
> Use dev_err instead of printk. Handles names automatically.
> 
> +	/* Setup error IRQ handler */
> +	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC", dev);
> +	if (err) {
> +		dev_err(&ofdev->dev, "failed to request IRQ %d", dev->emac_irq);
> +		goto err_gone;
> +	}

Is this an internal interrupt, or a GPIO? It could be it is done in
open because there is a danger the GPIO controller has not probed
yet. So here you might get an EPROBE_DEFFER, where as the much older
kernel this was written for might not of done, if just gave an error
had gave up. So dev_err_probe() might be better.

	Andrew

