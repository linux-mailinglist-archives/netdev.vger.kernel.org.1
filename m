Return-Path: <netdev+bounces-23760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3273A76D6F0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 20:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1DB281E50
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4109470;
	Wed,  2 Aug 2023 18:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB78847C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 18:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6770C433C7;
	Wed,  2 Aug 2023 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691001476;
	bh=T0M9qg4f1f+Qxc7YVpsVlrr+xtTUpzepRfkMPHQ+QQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfM2SUPjQ4v56lbiCGMxRnWeehXiTAMKtrUMPGpYPIdVRqqVWaEVEUhZ6G5ZaQlNc
	 GE5mINKg0aXtTcJx0QqWnPUa0Pdsu5J2CMv2C6Bp6Ve3VqeaolpoRrMxKLnMNTG/Jh
	 LONRIRNV6gWBksmgyexfyNPR9QpAD2jziAuSKdOxLWqbvvndqFMmtKaK83XWTaFV1Z
	 pvpnAYV0YLSyvLGbCkBNLCaQgxHEiZikosc+FqXs7rVc8edF/okagdS3+USkbzIDol
	 sJjznjIG9AktJWg07DdJkdxZdvZTR+T5VBIKSmPJznaMIJJPOCyuzbTiPhCwOFK6Y0
	 FdYf/Am+9vYFg==
Date: Wed, 2 Aug 2023 11:37:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic
 XDP handling
Message-ID: <20230802113755.4451c861@kernel.org>
In-Reply-To: <20230802070454.22534-1-liangchen.linux@gmail.com>
References: <20230802070454.22534-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Aug 2023 15:04:54 +0800 Liang Chen wrote:
> In the generic XDP processing flow, if an skb with a page pool page
> (skb->pp_recycle == 1) fails to meet XDP packet requirements, it will
> undergo head expansion and linearization of fragment data. As a result,
> skb->head points to a reallocated buffer without any fragments. At this
> point, the skb will not contain any page pool pages. However, the
> skb->pp_recycle flag is still set to 1, which is inconsistent with the
> actual situation. Although it doesn't seem to cause much real harm at the
> moment(a little nagetive impact on skb_try_coalesce), to avoid potential
> issues associated with using incorrect skb->pp_recycle information,
> setting skb->pp_recycle to 0 to reflect the pp state of the skb.

pp_recycle just means that the skb is "page pool aware", there's
absolutely no harm in having an skb with pp_recycle = 1 and no
page pool pages attached.

I vote not to apply this.

