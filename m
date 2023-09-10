Return-Path: <netdev+bounces-32726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F78799E75
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE90B1C20852
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7863C8;
	Sun, 10 Sep 2023 13:21:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7F1C3F
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 13:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC90C433C7;
	Sun, 10 Sep 2023 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694352094;
	bh=CY5nGdT16EpT3JKL0/13IgnKQD+cRVWOFlMEjZruoMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWDFuQj7E3gGpVdoNEVbl1XXUC0GrlM6/DtR1ujXBzJsTJspDb8NK1m/lb1U5NZZv
	 s/TgXeUm2/c3lGGJKh7J9GYFFpc4xs8wMH5WZ1rOVQU1DaabpukOFBA9l0XXTpMGlb
	 GzPgyC9mJo0ltuwSI2d7lJHPYCJdRr5RoyR3PlJ/oLjDhGLDDKX/YxRvxPp1RCRhM2
	 sa9EfJ4UDZsJa+TG5ouYPBZj6n80dSjr/jYEp+mRPuk/Gczp4HDVyRjx8CYlf0ZNl0
	 /up+5btFb83PG+8TKGhgR28Wcur1u+OnkE2sw5zJvva3+864hcE1/scBJQO/Pvt0+X
	 ujuzP2SUSXHUw==
Date: Sun, 10 Sep 2023 15:21:30 +0200
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH net] net: microchip: vcap api: Fix possible memory leak
 for vcap_dup_rule()
Message-ID: <20230910132130.GA775887@kernel.org>
References: <20230907140359.2399646-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907140359.2399646-1-ruanjinjie@huawei.com>

On Thu, Sep 07, 2023 at 10:03:58PM +0800, Jinjie Ruan wrote:
> Inject fault When select CONFIG_VCAP_KUNIT_TEST, the below memory leak
> occurs. If kzalloc() for duprule succeeds, but the following
> kmemdup() fails, the duprule, ckf and caf memory will be leaked. So kfree
> them in the error path.
> 
> unreferenced object 0xffff122744c50600 (size 192):
>   comm "kunit_try_catch", pid 346, jiffies 4294896122 (age 911.812s)
>   hex dump (first 32 bytes):
>     10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
>     00 00 00 00 00 00 00 00 18 06 c5 44 27 12 ff ff  ...........D'...
>   backtrace:
>     [<00000000394b0db8>] __kmem_cache_alloc_node+0x274/0x2f8
>     [<0000000001bedc67>] kmalloc_trace+0x38/0x88
>     [<00000000b0612f98>] vcap_dup_rule+0x50/0x460
>     [<000000005d2d3aca>] vcap_add_rule+0x8cc/0x1038
>     [<00000000eef9d0f8>] test_vcap_xn_rule_creator.constprop.0.isra.0+0x238/0x494
>     [<00000000cbda607b>] vcap_api_rule_remove_in_front_test+0x1ac/0x698
>     [<00000000c8766299>] kunit_try_run_case+0xe0/0x20c
>     [<00000000c4fe9186>] kunit_generic_run_threadfn_adapter+0x50/0x94
>     [<00000000f6864acf>] kthread+0x2e8/0x374
>     [<0000000022e639b3>] ret_from_fork+0x10/0x20
> 
> Fixes: 814e7693207f ("net: microchip: vcap api: Add a storage state to a VCAP rule")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/microchip/vcap/vcap_api.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> index 300fe1a93dce..ef980e4e5bc2 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> @@ -1021,18 +1021,32 @@ static struct vcap_rule_internal *vcap_dup_rule(struct vcap_rule_internal *ri,
>  	list_for_each_entry(ckf, &ri->data.keyfields, ctrl.list) {
>  		newckf = kmemdup(ckf, sizeof(*newckf), GFP_KERNEL);
>  		if (!newckf)
> -			return ERR_PTR(-ENOMEM);
> +			goto err;
>  		list_add_tail(&newckf->ctrl.list, &duprule->data.keyfields);
>  	}
>  
>  	list_for_each_entry(caf, &ri->data.actionfields, ctrl.list) {
>  		newcaf = kmemdup(caf, sizeof(*newcaf), GFP_KERNEL);
>  		if (!newcaf)
> -			return ERR_PTR(-ENOMEM);
> +			goto err;
>  		list_add_tail(&newcaf->ctrl.list, &duprule->data.actionfields);
>  	}
>  
>  	return duprule;
> +
> +err:

Hi Jinjie Ruan,

I think it would be slightly more idiomatic, and in keeping with the
prevailing style of this file to call the label out_free. But I don't feel
strongly about that. And clearly it would have no effect on the logic.

That not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> +	list_for_each_entry_safe(ckf, newckf, &duprule->data.keyfields, ctrl.list) {
> +		list_del(&ckf->ctrl.list);
> +		kfree(ckf);
> +	}
> +
> +	list_for_each_entry_safe(caf, newcaf, &duprule->data.actionfields, ctrl.list) {
> +		list_del(&caf->ctrl.list);
> +		kfree(caf);
> +	}
> +
> +	kfree(duprule);
> +	return ERR_PTR(-ENOMEM);
>  }
>  
>  static void vcap_apply_width(u8 *dst, int width, int bytes)

