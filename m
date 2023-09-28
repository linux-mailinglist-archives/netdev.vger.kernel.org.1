Return-Path: <netdev+bounces-36801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105287B1D54
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id F41861C209A5
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4738BBF;
	Thu, 28 Sep 2023 13:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D81118
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 13:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1939C433C8;
	Thu, 28 Sep 2023 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695906361;
	bh=ztN4tmVjK6DmLj67wYolMBra3pmwbiRgHSjRQXIHMPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7LKGs3DhLaZG++qJ/3LGwvrMbNHB0gcMN1mU0ATgHwPwj+QW0lby6MCP8lL9Ik37
	 6btM+I+4LhAdKe1Hm53Sqzf8/AJub30SXYdI5jfaiThqwn6JCeIGhQdHF4vFQYWmPo
	 45Zrq5bpt3NqIrb0Udv1kTKT7xzDFUPYoyHNpCwu5m4gpzq3vPUtnwQKZj6dc4O3R7
	 VQbeMZj+ShqHYeU9aCE31OwnuoEKUi4ae3tCrgl2yY69ZfkFO/VLCPp2+dBf+lrhjR
	 eE6jv+rrHgHhOjQSDkS7wkunTabo7lCu/lRekGupLGAERZZm/0Kz5ByF7xJvFLShsE
	 xCkF0Sx7Ib1TA==
Date: Thu, 28 Sep 2023 15:05:55 +0200
From: Simon Horman <horms@kernel.org>
To: liuhaoran <liuhaoran14@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Add error handling in hsr_portdev_setup()
Message-ID: <20230928130555.GJ24230@kernel.org>
References: <20230923122402.33851-1-liuhaoran14@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923122402.33851-1-liuhaoran14@163.com>

On Sat, Sep 23, 2023 at 08:24:02PM +0800, liuhaoran wrote:
> This patch adds error-handling for the hsr_port_get_hsr()
> inside the hsr_portdev_setup().
> 
> Signed-off-by: liuhaoran <liuhaoran14@163.com>

Please sign off using your real name, which is commonly of the form:

	Signed-off-by: First Last <me@example.com>

Please consider targeting this against 'net' as it appears to be a bug fix.

	Subject: [PATCH net] ...

If not, please target the patch against net-next.

If so, please consider using including a fixes tag, immediately
above your Signed-off-by (and any other) tags.

This may be the correct tag, but I'm not completely sure.

Fixes: e0a4b99773d3 ("hsr: use upper/lower device infrastructure")

> ---
>  net/hsr/hsr_slave.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index e5742f2a2d52..ac7d6bdef47e 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -141,6 +141,10 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>  	}
>  
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> +
> +	if (!master)
> +		return -ENODEV;

I think this needs to jump to an unwind label.

		goto fail_upper_dev_link;

But I also think the unwind label should be renamed.
to reflect what they do, rather than where they are called from.

-- 
pw-bot: changes-requested

