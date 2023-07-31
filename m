Return-Path: <netdev+bounces-22778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F476929F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEBF281630
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9117AC4;
	Mon, 31 Jul 2023 10:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6817AAB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 10:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3578AC433C8;
	Mon, 31 Jul 2023 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690797630;
	bh=XCQvNKE9hpAYSiyaw/udDhcxeHfFBfchLzpPzQ88kPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tk7S0+HEPzUlDT0NV8HEFWCeMMNs/Ut0Jl0zO0166GMfWAxuf1soVrttH9oZ5vUs3
	 M9Pfdfa2XLuncjtmAhGOA+24jgHComfIjVDazWicnV/kTXcItdC463gmereD2Mp0Fd
	 SknmabB7MwGcd8kqe824CVM/ID4y6BVr5NUEQsTM+kuo44LHV00jyCjO7hkD6lMPS3
	 XXZMDhxeY2Ntc4qUT2FkInY6YLOz8oj7H+q6nsf5zPzvyv8XnaLC6WlaGqc7GWIaVL
	 gdqXVSYNCkYPvI43CevbY7Yf+uMZNIVSw0KIlFBcMIkWTL9VwbpR2XlthFdjp7DLxQ
	 UJ0lxKIsrbwLQ==
Date: Mon, 31 Jul 2023 12:00:26 +0200
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel.machon@microchip.com, petrm@nvidia.com,
	peter.p.waskiewicz.jr@intel.com, jeffrey.t.kirsher@intel.com,
	alexander.h.duyck@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: dcb: choose correct policy to parse
 DCB_ATTR_BCN
Message-ID: <ZMeGOiANXBqDTBWm@kernel.org>
References: <20230731045216.3779420-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731045216.3779420-1-linma@zju.edu.cn>

On Mon, Jul 31, 2023 at 12:52:16PM +0800, Lin Ma wrote:
> The dcbnl_bcn_setcfg uses erroneous policy to parse tb[DCB_ATTR_BCN],
> which is introduced in commit 859ee3c43812 ("DCB: Add support for DCB
> BCN"). Please see the comment in below code
> 
> static int dcbnl_bcn_setcfg(...)
> {
>   ...
>   ret = nla_parse_nested_deprecated(..., dcbnl_pfc_up_nest, .. )
>   // !!! dcbnl_pfc_up_nest for attributes
>   //  DCB_PFC_UP_ATTR_0 to DCB_PFC_UP_ATTR_ALL in enum dcbnl_pfc_up_attrs
>   ...
>   for (i = DCB_BCN_ATTR_RP_0; i <= DCB_BCN_ATTR_RP_7; i++) {
>   // !!! DCB_BCN_ATTR_RP_0 to DCB_BCN_ATTR_RP_7 in enum dcbnl_bcn_attrs
>     ...
>     value_byte = nla_get_u8(data[i]);
>     ...
>   }
>   ...
>   for (i = DCB_BCN_ATTR_BCNA_0; i <= DCB_BCN_ATTR_RI; i++) {
>   // !!! DCB_BCN_ATTR_BCNA_0 to DCB_BCN_ATTR_RI in enum dcbnl_bcn_attrs
>   ...
>     value_int = nla_get_u32(data[i]);
>   ...
>   }
>   ...
> }
> 
> That is, the nla_parse_nested_deprecated uses dcbnl_pfc_up_nest
> attributes to parse nlattr defined in dcbnl_pfc_up_attrs. But the
> following access code fetch each nlattr as dcbnl_bcn_attrs attributes.
> By looking up the associated nla_policy for dcbnl_bcn_attrs. We can find
> the beginning part of these two policies are "same".
> 
> static const struct nla_policy dcbnl_pfc_up_nest[...] = {
> 	[DCB_PFC_UP_ATTR_0]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_1]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_2]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_3]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_4]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_5]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_6]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_7]   = {.type = NLA_U8},
> 	[DCB_PFC_UP_ATTR_ALL] = {.type = NLA_FLAG},
> };
> 
> static const struct nla_policy dcbnl_bcn_nest[...] = {
> 	[DCB_BCN_ATTR_RP_0]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_1]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_2]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_3]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_4]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_5]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_6]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_7]         = {.type = NLA_U8},
> 	[DCB_BCN_ATTR_RP_ALL]       = {.type = NLA_FLAG},
> 	// from here is somewhat different
> 	[DCB_BCN_ATTR_BCNA_0]       = {.type = NLA_U32},
>         ...
>         [DCB_BCN_ATTR_ALL]          = {.type = NLA_FLAG},
> };
> 
> Therefore, the current code is buggy and this
> nla_parse_nested_deprecated could overflow the dcbnl_pfc_up_nest and use
> the adjacent nla_policy to parse attributes from DCB_BCN_ATTR_BCNA_0.
> 
> This patch use correct dcbnl_bcn_nest policy to parse the
> tb[DCB_ATTR_BCN] nested TLV.
> 
> Fixes: 859ee3c43812 ("DCB: Add support for DCB BCN")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


