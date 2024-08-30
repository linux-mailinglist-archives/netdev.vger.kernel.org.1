Return-Path: <netdev+bounces-123738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278539665D3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB0DB24E99
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EE21B5EA5;
	Fri, 30 Aug 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTW5lIaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CD1386DF;
	Fri, 30 Aug 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032200; cv=none; b=MrjndSwPtXyFZF2baxJkXoitA3tGcOpJ0bLZbnWqKUW7/qJq3SL2D1nrl83a8LrBOUv+YOs5yieHce7C+ZnTZ/gfK75AqVq75wp2iralOr1yuTuFLmgXNLBLWTQTsFidB07NmwjjCeY7eI+EKfVSsuL7aqbERCg1dpl1U77pGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032200; c=relaxed/simple;
	bh=XKLkN7swlMDapQ8Pi00Cr3mQaJz8vtD+lACwdeK6Kvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgy9773jBbA5lQvBPGx5/zD2ah3jZ2bWp11MlP0qouxdQdtjhj0rtzX6lKw71S60YqsgpDQUxRR4Ku50KzxtYRXbP/tq2IUDYceJT32Kv9zVx/gXL1AHnqWBlg7qZqZKOonGzKm8nJgMnULStUCbsUv+SLwsS0o1a+qmmzh8Cb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTW5lIaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077BBC4CEC2;
	Fri, 30 Aug 2024 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725032200;
	bh=XKLkN7swlMDapQ8Pi00Cr3mQaJz8vtD+lACwdeK6Kvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTW5lIaworEQj2H3MuCLXQ5pAKGOzZ9XgYnaqxuy42huZUM1L1kBVz/QaYYNtgxgA
	 Qk2gQqroQ7g27oRZp+vxzaP0wpOkPLaSPvNx0TeAgwrmlPMN5cIsgKUAWYd/kZ2Eqz
	 jh5PpCWCI6ML3gjwVaZwRCGih8mLoWP/921sw4Reaoq91ZCw7iYk/lSxSA4pOt4Uv2
	 jJgRIfGdkNpU3IBLc/IGpGqMIaAyW5tEpeuoCG8ipy44GjzXGNuLoBFowoGA3VXUfw
	 zDhSRP0rvX/7FdpvfiTMn+s6FauRPXcmdsoevA0/4dQhbkcLx0uuS98l/UnexnZ80f
	 kW62vMXiC+GGw==
Date: Fri, 30 Aug 2024 16:36:34 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com,
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org,
	petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/12] net: vxlan: add skb drop reasons to
 vxlan_rcv()
Message-ID: <20240830153634.GR1368797@kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-8-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830020001.79377-8-dongml2@chinatelecom.cn>

On Fri, Aug 30, 2024 at 09:59:56AM +0800, Menglong Dong wrote:
> Introduce skb drop reasons to the function vxlan_rcv(). Following new
> vxlan drop reasons are added:
> 
>   VXLAN_DROP_INVALID_HDR
>   VXLAN_DROP_VNI_NOT_FOUND
> 
> And Following core skb drop reason is added:
> 
>   SKB_DROP_REASON_IP_TUNNEL_ECN
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - rename the drop reasons, as Ido advised.
> - document the drop reasons
> ---
>  drivers/net/vxlan/drop.h       | 10 ++++++++++
>  drivers/net/vxlan/vxlan_core.c | 35 +++++++++++++++++++++++++---------
>  include/net/dropreason-core.h  |  6 ++++++
>  3 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> index 876b4a9de92f..416532633881 100644
> --- a/drivers/net/vxlan/drop.h
> +++ b/drivers/net/vxlan/drop.h
> @@ -11,6 +11,8 @@
>  #define VXLAN_DROP_REASONS(R)			\
>  	R(VXLAN_DROP_INVALID_SMAC)		\
>  	R(VXLAN_DROP_ENTRY_EXISTS)		\
> +	R(VXLAN_DROP_INVALID_HDR)		\
> +	R(VXLAN_DROP_VNI_NOT_FOUND)		\
>  	/* deliberate comment for trailing \ */
>  
>  enum vxlan_drop_reason {
> @@ -23,6 +25,14 @@ enum vxlan_drop_reason {
>  	 * one pointing to a nexthop
>  	 */
>  	VXLAN_DROP_ENTRY_EXISTS,
> +	/**
> +	 * @VXLAN_DROP_INVALID_HDR: the vxlan header is invalid, such as:

> +	 * 1) the reserved fields are not zero
> +	 * 2) the "I" flag is not set

Maybe:
	 * ...: VXLAN header is invalid. E.g.:
	 * 1) reserved fields are not zero
	 * 2) "I" flag is not set

> +	 */
> +	VXLAN_DROP_INVALID_HDR,
> +	/** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni */

Maybe: no VXLAN device found for VNI

> +	VXLAN_DROP_VNI_NOT_FOUND,
>  };

...

