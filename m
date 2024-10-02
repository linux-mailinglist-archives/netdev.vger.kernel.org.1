Return-Path: <netdev+bounces-131230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378798D65C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA851F21A41
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42631D0792;
	Wed,  2 Oct 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsdRwGf2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77A1D078B;
	Wed,  2 Oct 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876323; cv=none; b=um02JybYriVLPzOnTSsQiryjHvdwfAy0O9r5UVM4S3MUTZX0YJaGNxn2v3iS3HFMfYP/o1uosyyGMhPLBeP6o4gtqqc4ml5QLow7iEPkQqZQ9KOCoTmaP3o/e+vlNIBRXTiGbL/1v7R3yW4R94g54uWT3FJJyBG9ANZtj8Uz1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876323; c=relaxed/simple;
	bh=cIQ2PZXRk0iGpvkJzbLGY/S5rVBJo9P+kgHxQHb4ANE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi4B/dWUKy42ILE9krMDM8OMRxlVgIGAZSuksRf6U32h0QNTPX6e952zx+DEeeB1gatZTf/h8eQxbjdedQftaSIjiDYHHKk+ua3NUFoAwIzEnfbPb+7wSeC23GwdRI4wtq7RxTIZm2hJjA9TlmjmyfsL41D/3XM2EBpw/P7xuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsdRwGf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FBDC4CEC5;
	Wed,  2 Oct 2024 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876323;
	bh=cIQ2PZXRk0iGpvkJzbLGY/S5rVBJo9P+kgHxQHb4ANE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsdRwGf2XQOLiyWiWsc7EY+LRr85mGE/1NI6ZugaEJCF1xHvKnyX7a6jawHiZFPUw
	 6keqf1TpZgh+ayztbkkbHUIFrDIDvwAIjiSvoQc/q8OPYq3/mnxMes0MprAjNRIXYc
	 Ybso6EYlG05ih21lXca0mrqUTP65tt6u4xKGLhfbTTbV2FF8pQkRLbFJE6eMAcHJdY
	 Ats3zoDd6AOF0N1UI+/uanRv2X8F52XmefAJNhLxwLIg1TlwroY6j3oyi4Hn8JgxOT
	 fLU8nFmeGkDkMbwEUOKFFYu6kHYO7otYs99mJpkLjUBCpE8GLhu1iA39RZ0WoZPetH
	 yAqa+MaczHSRA==
Date: Wed, 2 Oct 2024 14:38:38 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 08/12] net: vxlan: use kfree_skb_reason() in
 vxlan_xmit()
Message-ID: <20241002133838.GD1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-9-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-9-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:21PM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> new skb drop reasons are introduced for vxlan:
> 
> /* no remote found for xmit */
> SKB_DROP_REASON_VXLAN_NO_REMOTE
> /* txinfo is missed in "external" mode */
> SKB_DROP_REASON_TUNNEL_TXINFO
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - move the drop reason "TXINFO" from vxlan to core
> - rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE

Reviewed-by: Simon Horman <horms@kernel.org>


