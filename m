Return-Path: <netdev+bounces-20519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC575FE18
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105571C20BEF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6FFBE3;
	Mon, 24 Jul 2023 17:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94468E574
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57402C433C9;
	Mon, 24 Jul 2023 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690220680;
	bh=ZvCIeXPtML1eefHbxFJM07QYwP5uIy2qwAnyhnutLOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL10NlEUThnOiXXtdsa4sja4xL/YW4tcTmoVDraN0w+OV0WS9J5sv3vsWzCRzP1+q
	 ZFfjPP956rRClQnRaRiylI8DqZSCZ7DrMiPNx5QbZJBZt6ttf1oj8nTqkn2yOu8y0f
	 LH8r9RO3/DmBnCQd8CSuJkWXwLsym63YLl9jtKc2tAuJhgX0gAAIoDW+Um42pf8bkB
	 HcQ+iJ2A/wVx3H+XIEIi1WRka4x7am5XvjmlHIUKEZ9972g9tg9cLu4N4kVP60/8ir
	 Mkj785kfacdOSQKxsw0J9Wy+DxrUqNceE88agG5QZeMu4Y9OcHlCY2iuY6AhMM3w4m
	 SUkFEwL+jddTg==
Date: Mon, 24 Jul 2023 20:44:35 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230724174435.GA11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723075042.3709043-1-linma@zju.edu.cn>

On Sun, Jul 23, 2023 at 03:50:42PM +0800, Lin Ma wrote:
> The nla_for_each_nested parsing in function i40e_ndo_bridge_setlink()
> does not check the length of the attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as a 2 byte integer.
> 
> This patch adds the check based on nla_len() just as other code does,
> see how bnxt_bridge_setlink (drivers/net/ethernet/broadcom/bnxt/bnxt.c)
> parses IFLA_AF_SPEC: type checking plus length checking.
> 
> Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 29ad1797adce..6363357bdeeb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13186,6 +13186,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>  		if (nla_type(attr) != IFLA_BRIDGE_MODE)
>  			continue;
>  
> +		if (nla_len(attr) < sizeof(mode))
> +			return -EINVAL;
> +

I see that you added this hunk to all users of nla_for_each_nested(), it
will be great to make that iterator to skip such empty attributes.

However, i don't know nettlink good enough to say if your change is
valid in first place.

Thanks

>  		mode = nla_get_u16(attr);
>  		if ((mode != BRIDGE_MODE_VEPA) &&
>  		    (mode != BRIDGE_MODE_VEB))
> -- 
> 2.17.1
> 
> 

