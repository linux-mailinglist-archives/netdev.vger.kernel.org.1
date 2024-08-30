Return-Path: <netdev+bounces-123736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 936889665A1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E881F21EFD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C571B78F2;
	Fri, 30 Aug 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgjdio1G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDF1B78EF;
	Fri, 30 Aug 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031907; cv=none; b=UELXOOwtI4XliX5BMXL3IB5Z+IXPJsBcihoqagLtucTyU7yc8t0nIxCR3ziz578uxI4eKuE5TYDP6fGd6Wlxi3eHC+Si44YlGKXTj4EA+jQxSLFUHz8P6fDGrLSPtfZAb+kNfOR7fVAeAuVuoT1gmVRB+Nku36rlPjJvRRfNvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031907; c=relaxed/simple;
	bh=PAfGEfl+vyHhVG/c04iAi4hg18vNYz+br/OtNeWwlwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+zqvOOasJ4BTNukRiYsPNMaSfJiDRu1w3qt/DomRA9o/ob1OgCAxRKlOZqHrdBbSecKGk2Tb+qtp5x09b+kphQxxnKebBzbsYS/5b4txC/FoRDgLJPF+EU8T5aIAL1JZihgK1fDIW5z9LAzbXcjoKeoGfTfCLA6RtWKKcDaPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgjdio1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339C2C4CEC2;
	Fri, 30 Aug 2024 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725031907;
	bh=PAfGEfl+vyHhVG/c04iAi4hg18vNYz+br/OtNeWwlwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgjdio1GUgPxAXMgxpIOLvwX2eKytPvPGk7nUXrym92o7yJJZWRAa1vZlQGpVWVA0
	 3N3Qz6YrnNngPhFlQB8X6zab338S2neHBhohJnxwZTc9aVIh+Hku52pCogDHO0FWBz
	 sNTHYPPLPypcQzw2L7SP2PBx4JEcRdvIr6kriYtIGr9K+sQiBZOiAtnPgsjJoUpph4
	 PBBQ4GNRjVtFy4AaDHPk+U5G4f7jT5baFEVKfd3MaDzAF2bAOmjJkqT5kgFkUjvgZx
	 2PinD/rxxHFTbkEqUjq+OJfuparB3Ie0KXYGrS1/C+WAc9loujCq0M89j6ioV9vHCk
	 IupWyZxhCwW0A==
Date: Fri, 30 Aug 2024 16:31:41 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com,
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org,
	petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac()
 return drop reasons
Message-ID: <20240830153141.GP1368797@kernel.org>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-7-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830020001.79377-7-dongml2@chinatelecom.cn>

On Fri, Aug 30, 2024 at 09:59:55AM +0800, Menglong Dong wrote:
> Change the return type of vxlan_set_mac() from bool to enum
> skb_drop_reason. In this commit, two drop reasons are introduced:
> 
>   VXLAN_DROP_INVALID_SMAC
>   VXLAN_DROP_ENTRY_EXISTS
> 
> To make it easier to document the reasons in drivers/net/vxlan/drop.h,
> we don't define the enum vxlan_drop_reason with the macro
> VXLAN_DROP_REASONS(), but hand by hand.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/vxlan/drop.h       |  9 +++++++++
>  drivers/net/vxlan/vxlan_core.c | 12 ++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> index 6bcc6894fbbd..876b4a9de92f 100644
> --- a/drivers/net/vxlan/drop.h
> +++ b/drivers/net/vxlan/drop.h
> @@ -9,11 +9,20 @@
>  #include <net/dropreason.h>
>  
>  #define VXLAN_DROP_REASONS(R)			\
> +	R(VXLAN_DROP_INVALID_SMAC)		\
> +	R(VXLAN_DROP_ENTRY_EXISTS)		\
>  	/* deliberate comment for trailing \ */
>  
>  enum vxlan_drop_reason {
>  	__VXLAN_DROP_REASON = SKB_DROP_REASON_SUBSYS_VXLAN <<
>  				SKB_DROP_REASON_SUBSYS_SHIFT,
> +	/** @VXLAN_DROP_INVALID_SMAC: source mac is invalid */
> +	VXLAN_DROP_INVALID_SMAC,
> +	/**
> +	 * @VXLAN_DROP_ENTRY_EXISTS: trying to migrate a static entry or
> +	 * one pointing to a nexthop

Maybe it is clearer to write: one -> an entry

> +	 */
> +	VXLAN_DROP_ENTRY_EXISTS,
>  };
>  
>  static inline void

...

