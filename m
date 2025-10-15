Return-Path: <netdev+bounces-229579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38ABDE7FD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B5A23532A6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD323875D;
	Wed, 15 Oct 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDzhOzdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86520C48A
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531851; cv=none; b=k6QkLvT6EwXfeK0J+HszwinNvJ8n2yAJTQilrF7oRkHB61Q/b8TvziJ0ph/wn/E5jA99hDo3drswZs91X8Lf/nCVJ+FyS1Jb3W7ubyM9HMF+KneDXAVBV2sMEbHmC8xjz/48iAAsAO8Ps/vNuYb8uXYOF8dcAofAfVn6bme7wPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531851; c=relaxed/simple;
	bh=vAeHPZo/SbvwiHBbvBbMicDqv0CobCOFq5F15mnA5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJALycrc7uBA2UsPTjJb+qSNsVsPfiOST2owW9M4b+9IgjmZH6vWvh6LVEVMWW1eg/t/IxCzDXXGs0gZJfOSPWcRnl2J0OsObHdxsO31Yv43nkvoEYjwuIx5KOmEZY4qFRB5/bmafT9jGpagBRPCL63a7oSArzMwXHhtI3DnXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDzhOzdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9593CC4CEF8;
	Wed, 15 Oct 2025 12:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531850;
	bh=vAeHPZo/SbvwiHBbvBbMicDqv0CobCOFq5F15mnA5dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDzhOzdo2WG4GLuK6PyqXilZcSZpazJ7zHOhSIlPK/qFvZbcmRU68PkHplJsL/o/X
	 6WkNU2NH5E5Wj0qzZFZ6iVEvkL6403LzjI/u4j0XBkyRD7PS1EuQX/AQcTjxEJI8IB
	 IgIxXu34U0+VCQ5R6vdOfRSePglHrnEMqrNqjMIz9GxnDQfK2QRFBMBQV7pwscoBep
	 YesVv0Nz91vMsS4GOdU5fG3KPG5QwtaJd7J2bPyc4jhk1C/9XZ0qk7fkP3Q0IKOBHH
	 ++1038yioX1Gcwii4iX/MveUY1NoMeS33rHs1x15pY6zx+Q+3nCuYMA4aGKERTmF0X
	 OdPRQg68b1LQg==
Date: Wed, 15 Oct 2025 13:37:25 +0100
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 1/5] eea: introduce PCI framework
Message-ID: <aO-VhWosxJ8OnG_K@horms.kernel.org>
References: <20251015071145.63774-1-xuanzhuo@linux.alibaba.com>
 <20251015071145.63774-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015071145.63774-2-xuanzhuo@linux.alibaba.com>

On Wed, Oct 15, 2025 at 03:11:41PM +0800, Xuan Zhuo wrote:

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c

...

Hi,

This isn't a full review, but in this function edev is initialised
but otherwise unused. I suggest either using it or removing it.

Likewise in eea_pci_remove().

Flagged by W=1 builds.

> +
> +	err = eea_pci_setup(pci_dev, ep_dev);
> +	if (err)
> +		goto err_setup;
> +
> +	err = eea_init_device(&ep_dev->edev);
> +	if (err)
> +		goto err_register;
> +
> +	return 0;
> +
> +err_register:
> +	eea_pci_release_resource(ep_dev);
> +
> +err_setup:
> +	kfree(ep_dev);
> +	return err;
> +}

...

> +static void eea_pci_remove(struct pci_dev *pci_dev)
> +{
> +	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
> +	struct eea_device *edev;
> +
> +	edev = &ep_dev->edev;
> +
> +	__eea_pci_remove(pci_dev, true);
> +
> +	kfree(ep_dev);
> +}

...

