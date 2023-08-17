Return-Path: <netdev+bounces-28345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEDD77F1B6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF60281D61
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E71DDBF;
	Thu, 17 Aug 2023 08:03:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C7CA58
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A114C433C7;
	Thu, 17 Aug 2023 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692259382;
	bh=qHhD0UVnV47SYp//W121/iPNgLZ88B0c8IP9WQRtSnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pX0JsShXEwIdADNqJaCdTF69t4iyiGO/hdr2+/12zhTsQtCy0dzli3q/1qS+m484c
	 1oEFFBt78BibHuyLtZUK93NGVKofIPtPHizxF2ck21hzlzNoHo7TUvTDJ4k4TVFNR8
	 CtnJFMIDIY9vuxvZzg/Oy7ce+Xs9yEtRwEhFYypNDStM2VsqV4dWbBwr0iJf+Rg2Xc
	 hqER9KuIk0RiOmL8kF24xuKLI7+EDelZvqMRoPNPPjiZf5YXOzjViI4Tb1NXTZFf2w
	 2kvBf7mA/MUcUUKacohPii2wHt2bmoBRY4fC77R9fmlhudusN6t0D5TOwn5wNns75y
	 krk5Weeeg30sA==
Date: Thu, 17 Aug 2023 11:02:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, horatiu.vultur@microchip.com,
	simon.horman@corigine.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 0/2] net: Use helper function IS_ERR_OR_NULL()
Message-ID: <20230817080257.GD22185@unreal>
References: <20230817071941.346590-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817071941.346590-1-ruanjinjie@huawei.com>

On Thu, Aug 17, 2023 at 03:19:39PM +0800, Ruan Jinjie wrote:
> Use IS_ERR_OR_NULL() instead of open-coding it
> to simplify the code.
> 
> Ruan Jinjie (2):
>   net: microchip: sparx5: Use helper function IS_ERR_OR_NULL()
>   net: stmmac: Use helper function IS_ERR_OR_NULL()
> 
>  drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

As a side note, grep of vcap_get_rule() shows that many callers don't
properly check return value and expect it to be or valid or NULL.

For example this code is not correct:
drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
    61         vrule = vcap_get_rule(lan966x->vcap_ctrl, rule_id);
    62         if (vrule) {
    63                 u32 value, mask;
    64
    65                 /* Just modify the ingress port mask and exit */
    66                 vcap_rule_get_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK,
    67                                       &value, &mask);
    68                 mask &= ~BIT(port->chip_port);
    69                 vcap_rule_mod_key_u32(vrule, VCAP_KF_IF_IGR_PORT_MASK,
    70                                       value, mask);
    71
    72                 err = vcap_mod_rule(vrule);
    73                 goto free_rule;
    74         }


