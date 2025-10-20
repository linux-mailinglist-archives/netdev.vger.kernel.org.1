Return-Path: <netdev+bounces-231030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AEBBF416C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4063B15CC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B19335078;
	Mon, 20 Oct 2025 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCCjcFoW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB872628;
	Mon, 20 Oct 2025 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004799; cv=none; b=ZMpG/zfDZEshBAz9V94BGCax81CJuiCqj83Jw36rR1dFQ3rAL4a5X/e3qb9DhUFwKCRDQvfACoOFmUA/eUFUHbnVGIPghCshXhz0Q7vVFsdKIX8d4TbbATFYJIHCWyXIevAyTBYlA0cfCVZ2KU5AbJFKjlGsUxXd288Ed8I7RTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004799; c=relaxed/simple;
	bh=hq2DKy2kEQVil563QjDfbIGT0J+Iyeb4JU92X7xZgHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8VDA8jBwhJ/Df62ITfxH/GeyPeUtEiM7pljaFhm2SAY5b3mM/AMGGIUqWSNAqAD3HhuaJ3tL0rSs3k33ShCooWaVxMABdbKl0THaJtdhqgz5+j5mXBK+Xwj5+dLzhzxGLQfpPYWA8xt+w4/CMPIWdCmAWKaFCm97zL55tGWhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCCjcFoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A0EC4CEFB;
	Mon, 20 Oct 2025 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761004799;
	bh=hq2DKy2kEQVil563QjDfbIGT0J+Iyeb4JU92X7xZgHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bCCjcFoWdnMma3K6JpHFAZHJFYE0niS44n50siUBRzOydl5rBF8QxShj4hd9JBx/9
	 o/YmkOPml8DlC21yE0vqVYxoK8sg+nltg3TDT0aSbmR8g1WOpHleQssh27G10hQfVr
	 FckyBJIR/eBIKxmmH0uoki91UWsD/IcqN4OxGNKvbn0p0GrOEfK7cE4Fr1rzUKubIF
	 RbXvB5TZt/pRwSXqTnlpIx7ZFmd7ZqUp2gN+dwM1RtVEfdm+yFD4P8oN9OZUl7tcm4
	 /3EHOqx2zpM0M4APswzi6IwM1WsL1Re2/vMDxUfllb0StdylKOedIPFaktzLlVpJr5
	 27Bpe6kjip6XQ==
Date: Mon, 20 Oct 2025 16:59:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
 <alex.williamson@redhat.com>, <pabeni@redhat.com>,
 <virtualization@lists.linux.dev>, <parav@nvidia.com>,
 <shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>, <kevin.tian@intel.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>
Subject: Re: [PATCH net-next v5 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251020165957.62a127eb@kernel.org>
In-Reply-To: <20251016050055.2301-6-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
	<20251016050055.2301-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 00:00:48 -0500 Daniel Jurgens wrote:
> +struct virtio_net_ff_selector {
> +	__u8 type;
> +	__u8 flags;
> +	__u8 reserved[2];
> +	__u8 length;
> +	__u8 reserved1[3];
> +	__u8 mask[];
> +};

> +/**
> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
> + * @count: number of entries in @selectors
> + * @reserved: must be set to 0 by the driver and ignored by the device
> + * @selectors: array of supported selector descriptors
> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	struct virtio_net_ff_selector selectors[];
> +};

sparse complains:

  include/uapi/linux/virtio_net_ff.h:73:48: warning: array of flexible structures

which seems legit. Since only element 0 can reasonably be accessed
perhaps make selectors

	__u8 selectors[]; /* struct virtio_net_ff_selector */

?
-- 
pw-bot: cr

