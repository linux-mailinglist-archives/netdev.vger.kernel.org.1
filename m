Return-Path: <netdev+bounces-26743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3372778BF3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40A81C20B1D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B76FD8;
	Fri, 11 Aug 2023 10:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA536FD1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4125CC433C8;
	Fri, 11 Aug 2023 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691749446;
	bh=iFY0y5C/BNPee/4OykRohNEvTU8wlyAtgkdxJKcG1R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjPfAW1Ps4YL08T4tSzEb6P7KpqS9W2SdrlQJXj3TQG9vXgc+RSMtrBtq6KB0ywCg
	 v2MLX1/fSSfQh0bxQBon87ty79y5OstN/LX2b80moCU2eMa8tYBgaVAcO/9B6djuDz
	 laYQ/BFTYcv6M7kkkDLs9+rBlAW5ryUGu4xjaiDN63Gek1D9AjSgxnP6xYR9fuplFb
	 K+ga0yJddF+fJKzr6N8+zFJzk/mFYTDv5m6zn3UVDkb0qdrc1sPj+YEjU9PK97G+DS
	 vL4uuSLV96AWqk8ZcM4WGKjpcLpc2n03JsVU2LAOV2XaSIE/gta7/GH+4Yzov6lkY4
	 A1HpbbXHc/CUw==
Date: Fri, 11 Aug 2023 12:24:00 +0200
From: Simon Horman <horms@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 11/17] nvmet: make TCP sectype settable via configfs
Message-ID: <ZNYMQPCbsqxOtFur@vergenet.net>
References: <20230810150630.134991-1-hare@suse.de>
 <20230810150630.134991-12-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150630.134991-12-hare@suse.de>

On Thu, Aug 10, 2023 at 05:06:24PM +0200, Hannes Reinecke wrote:

...

> +static ssize_t nvmet_addr_tsas_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = nvmet_port_disc_addr_treq_mask(port);

Hi Hannes,

treq appears to be unused in this function.

> +	u8 sectype;
> +	int i;
> +
> +	if (nvmet_is_port_enabled(port, __func__))
> +		return -EACCES;
> +
> +	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
> +		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name)) {
> +			sectype = nvmet_addr_tsas_tcp[i].type;
> +			goto found;
> +		}
> +	}
> +
> +	pr_err("Invalid value '%s' for tsas\n", page);
> +	return -EINVAL;
> +
> +found:
> +	nvmet_port_init_tsas_tcp(port, sectype);
> +	return count;
> +}

...

