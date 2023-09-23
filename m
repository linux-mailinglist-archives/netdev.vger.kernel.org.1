Return-Path: <netdev+bounces-35987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F083E7AC3DC
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 209F3281390
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50734208D6;
	Sat, 23 Sep 2023 17:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49428EC
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 17:08:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF10AB
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ctTK403ve+7708FJrvGS8L0+2Nd7/ZtrHDl4pzC6ncE=; b=AGnVeRgufS4PaavDzSzCYSCRUe
	V2pirHV3CERvMRM/IuvXMQYWqs4NRDJtN4AwffZrE2NqliW/1HgPQtEJZKfsm8GhO6MTaCWo875w2
	h4bGpeQUhmBquDGDK9fvgZuOJHXw0eykM3NWUB1sA92ysB6qQy5y7Xpw3pfcLZCHRo0U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qk67T-007Ir5-5d; Sat, 23 Sep 2023 19:08:39 +0200
Date: Sat, 23 Sep 2023 19:08:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: liuhaoran <liuhaoran14@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phonet: Add error handling in phonet_device_init
Message-ID: <820ee8da-f3fa-449a-ac5f-d6ac91f983f0@lunn.ch>
References: <20230923115847.32740-1-liuhaoran14@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923115847.32740-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 07:58:47PM +0800, liuhaoran wrote:
> This patch adds error-handling for the proc_create_net() and
> register_netdevice_notifier() inside the phonet_device_init.
> 
> Signed-off-by: liuhaoran <liuhaoran14@163.com>
> ---
>  net/phonet/pn_dev.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
> index cde671d29d5d..c974b64d52b9 100644
> --- a/net/phonet/pn_dev.c
> +++ b/net/phonet/pn_dev.c
> @@ -336,10 +336,19 @@ int __init phonet_device_init(void)
>  	if (err)
>  		return err;
>  
> -	proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
> -			sizeof(struct seq_net_private));
> -	register_netdevice_notifier(&phonet_device_notifier);
> +	err = proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
> +			      sizeof(struct seq_net_private));
> +
> +	if (!err)
> +		return err;

As the build bot has shown, you should at least compile test your
changes.

> +
> +	err = register_netdevice_notifier(&phonet_device_notifier);
> +
> +	if (!err)
> +		return err;
> +

If this fails, you should clean up proc.

	Andrew

