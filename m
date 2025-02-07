Return-Path: <netdev+bounces-163980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB029A2C395
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48D118890DF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E231DE89B;
	Fri,  7 Feb 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncqHG1xj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484222417DB;
	Fri,  7 Feb 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935061; cv=none; b=HSvEjv1ZO0HL2vnpLhiDtDQZ+RnuLZqAertHFfFtyWdoOIOKoKZpIO8ABmqInE+XXodiHt01raZ70oKPVM0+TotCeZpQTBkdtYTdLSboPf40oVrjv4mWulmPiPJuRXlCz8sxlntODJDO5M2tax7/c9ttj/16vk08+EDhcPPmS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935061; c=relaxed/simple;
	bh=NsSmOwhEZRd+aVZXPOwC9ZF+E9OTzkX7OgEXWYjui74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbZsJ/umuUEWaJnErc4k7DDfVHP4F4HBjtW5h9FJnYifvz8Itdrsa2Al2ZnW0ch1muGDB20pgtWc2/rH5jWx76Eya7497MHubdQQ34qF3ynyy1TVx4+rUimklpNje0IboC5wMUAlkh2C91ve1CONCnTVxcl2J1i21DqdY2xNumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncqHG1xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2365C4CED1;
	Fri,  7 Feb 2025 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738935060;
	bh=NsSmOwhEZRd+aVZXPOwC9ZF+E9OTzkX7OgEXWYjui74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncqHG1xjMH3im4kyO+IV6bpRSlqPmofmKvKKNQf0rhGaq4F8ERegSG+6SnFNxSO4I
	 HzuZ3Eg+So+TXGr2cq2X0sZPhkwIxZYEWNU7zXXGma8QsnvT3B32QX2IFJ7LEwzqeM
	 A/WYUQ3qxXWhUTsMbdXHIojsT2Ie2/Otp/agjBCFQsYuxAVRjL7ccoi2r1hJmI4ReE
	 OvWXd9toAFuQGnnwfqn3l6ZwW7fiueR0iduHnDhlezXX1K5rpIkBWKtjDgdoALsCYZ
	 oukD1BeMp4rVKmdMThw9imvlhQRQyzxtvJdHz4ADL2Z01jzVh4d0wshJQMkd1ro3gC
	 EGZDxXUriFJqw==
Date: Fri, 7 Feb 2025 13:30:55 +0000
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	sridhar.samudrala@intel.com, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/3] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <20250207133055.GU554665@kernel.org>
References: <20250207030916.32751-1-jdamato@fastly.com>
 <20250207030916.32751-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207030916.32751-3-jdamato@fastly.com>

On Fri, Feb 07, 2025 at 03:08:54AM +0000, Joe Damato wrote:
> Expose a new per-queue nest attribute, xsk, which will be present for
> queues that are being used for AF_XDP. If the queue is not being used for
> AF_XDP, the nest will not be present.
> 
> In the future, this attribute can be extended to include more data about
> XSK as it is needed.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

...

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 0dcd4faefd8d..75ca111aa591 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -380,6 +380,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  	struct netdev_rx_queue *rxq;
>  	struct netdev_queue *txq;
>  	void *hdr;
> +	int ret;
>  

Hi Joe,

Perhaps this got left behind after some revisions elsewhere.
But as it stands ret is unused in this function and should be removed.

>  	hdr = genlmsg_iput(rsp, info);
>  	if (!hdr)

...

-- 
pw-bot: changes-requested

