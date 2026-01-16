Return-Path: <netdev+bounces-250403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90CD2A4CA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C35A3015853
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B6733A03F;
	Fri, 16 Jan 2026 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSrf7wkn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84233A9F8;
	Fri, 16 Jan 2026 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531482; cv=none; b=uKdeZrmfbktozBsp5DvaxvA9NYct4BdBBjAjH+56iFFqFCawEoVHxQKj7VpwFIScNRYhB4EEPFROIu4aA4CJ8EHvZ2OadlUpKblrUGrxpwGHpCw3OeyOYtGlbo5zKOR9bgFAiWLjeqewdzz6MA17ULgHKONjXRDR3dBx7ZTaFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531482; c=relaxed/simple;
	bh=GHI0xIHJfpNcTjqUpfVIw6MpAws8VNEPh3y69QKjWkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOCQ60p/TNGD15XY8CWg4opWLE5tLV4A2IQps8MfM9XGs9BSQJZqZrgxoEYTjaf7XreQFlfuuliScpdylJbyPc4bF9pzKULIZoHZzB+yRIkxMa8yRMqAS+jbxSi0w/Gd0xYLMkUnJLtofwRjQCYbBhpxSdjFL/F1nxl5yAdRJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSrf7wkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347F0C116D0;
	Fri, 16 Jan 2026 02:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768531480;
	bh=GHI0xIHJfpNcTjqUpfVIw6MpAws8VNEPh3y69QKjWkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSrf7wknhr1DxfRKusSEFpRe/qJFK4Egk+hZyFqapI93tU4pyo4baedTi7zB33dg6
	 Jzh1Vwd+yb4spsR7ja8fhSwoGFqo5YDKU2nfv5Sh7ZZEIuDinsXVTTnSTVe3wynA34
	 6xMiaeBmNBuzXslRfM1clwvCvet9C+DDWErlalFfF6F0QWJOjTy6sXyOKi46+CjVyn
	 lZghqzjc6y7KrZWUGrI/GYCqK502ToTJMkcRQx/9kYBXt2hyeh7RcBh8W8/bYUxIjm
	 wxVxPUgaztUbPSJHnBQ+1GbsZf+FHVH8DNNkUD/gwfDahx5FQpT1oG0ME9dQsaJw9L
	 FQ+QUOeLwBUVg==
From: Jakub Kicinski <kuba@kernel.org>
To: slark_xiao@163.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	quic_qianyu@quicinc.com,
	davem@davemloft.net,
	loic.poulain@oss.qualcomm.com,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	zaihan@unrealasia.net,
	johan@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	dnlplm@gmail.com,
	manivannan.sadhasivam@linaro.org,
	pabeni@redhat.com,
	mani@kernel.org,
	ryazanov.s.a@gmail.com
Subject: Re: [net-next,v7,3/8] net: wwan: core: split port creation and registration
Date: Thu, 15 Jan 2026 18:44:35 -0800
Message-ID: <20260116024435.347774-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114625.46991-4-slark_xiao@163.com>
References: <20260115114625.46991-4-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wwan: core: split port creation and registration

This patch splits the port creation function to prepare for upcoming GNSS
port type support. It separates device_register() into device_initialize()
and device_add(), and moves minor number allocation into the new
wwan_port_register_wwan() function.

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 1da935e84008..1a9a77d597e6 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -357,7 +357,8 @@ static void wwan_port_destroy(struct device *dev)
>  {
>  	struct wwan_port *port = to_wwan_port(dev);
>
> -	ida_free(&minors, MINOR(port->dev.devt));
> +	if (dev->class == &wwan_class)
> +		ida_free(&minors, MINOR(dev->devt));
>  	mutex_destroy(&port->data_lock);
>  	mutex_destroy(&port->ops_lock);
>  	kfree(port);

[ ... ]

> +/* Register a regular WWAN port device (e.g. AT, MBIM, etc.) */
> +static int wwan_port_register_wwan(struct wwan_port *port)
> +{
> +	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
> +	char namefmt[0x20];
> +	int minor, err;
> +
> +	/* A port is exposed as character device, get a minor */
> +	minor = ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KERNEL);
> +	if (minor < 0)
> +		return minor;
> +
> +	port->dev.class = &wwan_class;
> +	port->dev.devt = MKDEV(wwan_major, minor);

[ ... ]

> +	err = device_add(&port->dev);
> +
> +	mutex_unlock(&wwan_register_lock);
> +
> +	if (err) {
> +		ida_free(&minors, minor);
                ^^^^^^^^^^^^^^^^^^^^^^^^

When device_add() fails, this frees the minor. However, port->dev.class
was already set to wwan_class above, and port->dev.devt contains the minor
number. The caller (wwan_create_port) then calls put_device() which
triggers wwan_port_destroy(). Since dev->class == &wwan_class is true,
wwan_port_destroy() calls ida_free() again on the same minor.

Wouldn't this cause a double ida_free when device_add() fails? The call
chain is: wwan_port_register_wwan() fails -> ida_free(minor) -> return
error -> wwan_create_port() -> put_device() -> wwan_port_destroy() ->
ida_free(minor) again.

Maybe the class should be cleared on error before returning, or the
ida_free in the error path should be removed since wwan_port_destroy()
will handle it?

> +		return err;
> +	}
> +
> +	dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev));
> +
> +	return 0;
> +}

[ ... ]

> +	device_initialize(&port->dev);
> +
> +	err = wwan_port_register_wwan(port);
>  	if (err)
>  		goto error_put_device;
> +
>  	return port;
>
>  error_put_device:
> +	put_device(&port->dev);
-- 
pw-bot: cr

