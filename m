Return-Path: <netdev+bounces-21342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C4763594
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B751C2125A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734CAD30;
	Wed, 26 Jul 2023 11:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773E8466
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E5C433C7;
	Wed, 26 Jul 2023 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690372121;
	bh=eZG9v0oZO9uEfsEIeSuInQVaRCDGDxegAVVDWaK0lZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FO/McMF4qjCJ/ZEnvhx0ROGZLqNZRvkrnD/QyR5ni2dYbxz78blKyECZOeUSmTOYl
	 p/Bd0GGnU4Hq+WBUscxgIngIdoLN8Cfzw4quDBiosVJsARc4iSDKujlP6LM7yu8OEb
	 P0niNcp41mrQ7Is4Ri8H1gOTNcuIvI4M3voLzyhOpYoBtC4mw8Cn1MKcR79mjPF897
	 GCChIgLoqO3+kyWIV1LIkpTvQaBUE0/Kx6wiGjZ+tnSzW/YgClnDFO/TWSExNbOMJA
	 yg3yBBatxEnLBnr73eu6OgGvpori4tpJr/Aop2PkwBIJ1fUfwXkQwvFfLxAg+uHulF
	 zkrVjB6xThYWQ==
Date: Wed, 26 Jul 2023 14:48:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com
Subject: Re: [net-next PATCH] octeontx2-af: Tc flower offload support for
 inner VLAN
Message-ID: <20230726114836.GU11388@unreal>
References: <20230725103442.2749183-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725103442.2749183-1-sumang@marvell.com>

On Tue, Jul 25, 2023 at 04:04:42PM +0530, Suman Ghosh wrote:
> This patch extends current TC flower offload support to allow filters
> involving inner VLAN matching, to be offloaded to HW.
> 
> Example command:
> tc filter add dev eth2 protocol 802.1AD parent ffff: flower vlan_id 10
> vlan_ethtype 802.1Q cvlan_id 20 skip_sw action drop
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
>  .../net/ethernet/marvell/octeontx2/af/npc.h   |   3 +
>  .../marvell/octeontx2/af/rvu_debugfs.c        |   5 +
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  13 +++
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 106 +++++++++++-------
>  5 files changed, 90 insertions(+), 38 deletions(-)

<...>

> +	if (!is_inner)
> +		flow_rule_match_vlan(rule, &match);
> +	else
> +		flow_rule_match_cvlan(rule, &match);

<...>

> +		if (!is_inner) {
> +			flow_spec->vlan_tci = htons(vlan_tci);
> +			flow_mask->vlan_tci = htons(vlan_tci_mask);
> +			req->features |= BIT_ULL(NPC_OUTER_VID);
> +		} else {
> +			flow_spec->vlan_itci = htons(vlan_tci);
> +			flow_mask->vlan_itci = htons(vlan_tci_mask);
> +			req->features |= BIT_ULL(NPC_INNER_VID);
> +		}

Slightly better approach will be to reverse these checks from
"if (!is_inner)" to be "f (is_inner)".

Other than that,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

