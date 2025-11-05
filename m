Return-Path: <netdev+bounces-235995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C98C37C25
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A56234E15EF
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C33002CA;
	Wed,  5 Nov 2025 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6QEOpxMo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B442FDC42;
	Wed,  5 Nov 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375032; cv=none; b=iwptXQEisDfM1DpFQqosoQTQ7GaQdlE5GWvdUYdjnfH969JxsZrFEXYPwMVse8rZ688l5T/A7Uc+2HWEP8lmXYnwDxkYhxaEzsTCUawc88P6Eh+CWqlPqFKa5wq2MCXoBt9N06SrzXG3nHRZkNd1qGqLTuBR2/sSu8T7d5HYyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375032; c=relaxed/simple;
	bh=muwKqzLMJYkC5bScsgl/ewFQY2fXk4L0ZUkJmMtPU4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDdIxl7Px3ind5sA9XJ7mveUawUbywaPrln+2BDjSY5XbpP/JEY2MerjF4yYupqgno74umJNQZrWUHUPw+bd5NYTjNF5E/A69emERMfM91NU3df94eLMgy2z1AtfRm/Z830qdipDotoDeCCryakZjGxh8nMP5oD2nbTuc5tKFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6QEOpxMo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W6ehPsM5gg9RaSLqrceyWQW4IW17EYg8KIyTamvdBxM=; b=6QEOpxMooT6+RON7QspUZKx8d2
	LfN01Rg14ZGSuVA3Txoqnc+Zy/mqok3PNYKobIIdnig/85EqZxUFarigqeoeGCEQAIXqQ5DgEiI1/
	28w0sjPK38jEFK4EhhTERoZY5sJCGRB++eaxD8liqBw45cyf8or8AfqvfUKBxAe+SdP4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vGkFe-00D2Sl-UU; Wed, 05 Nov 2025 21:37:06 +0100
Date: Wed, 5 Nov 2025 21:37:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
Message-ID: <11301ae7-ac18-4a2f-9728-28cf1ba1afdd@lunn.ch>
References: <20251105195626.4285-1-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105195626.4285-1-dharanitharan725@gmail.com>

> -	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
> -		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
> -	if ((res = usb_submit_urb(dev->rx_urb, GFP_KERNEL))) {
> -		if (res == -ENODEV)
> -			netif_device_detach(dev->netdev);
> +	usb_fill_bulk_urb(dev->rx_urb, dev->udev,
> +			  usb_rcvbulkpipe(dev->udev, 1),
> +			  dev->rx_skb->data, RTL8150_MTU,
> +			  read_bulk_callback, dev);

If im reading this correctly, the usb_fill_bulk_urb() is identical,
you have just changed the wrapping. So this again has nothing to do
with the issue you are trying to fix. Changes like this make it harder
to see the real change which fixes the problem. And at the moment, i
don't see the actual fix.

If you want to make changes like this, please do so in a patch of its
own which only changes the wrapping, nothing else. That is then easy
to review.

Lots of small changes, which hopefully are obviously correct, with
good commit messages please.

    Andrew

---
pw-bot: cr


