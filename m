Return-Path: <netdev+bounces-108476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AD923F1E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304881C21D1D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252B172BC8;
	Tue,  2 Jul 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AD/cxQQ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23115B143;
	Tue,  2 Jul 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927417; cv=none; b=VjEsxhSCzYKG3xm/oqNl9nZorTo21AqWFRNrg388qpVvZZcWXZR3Cc/QOShlj8y3YP4v1OfHs9osnKZu8j0+EeoPhYs6VkWLBXn6NiDM13XlShazA9Q+ffrfT77h3vS0UL1DgHiR2XtRJlzZ4YqY2EGx9Q2XfW70hs2kGhZUpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927417; c=relaxed/simple;
	bh=8xSDy43ox5BcR5NmXJ3vxQaOq5/T0Sg4W3yVzi9h2jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPIHBLg3cUffL2QtGwE9DBpR42OtxiZ5rahN6BOgw1K2V+Ixp4ENeyJl9sJCfOaJOnyRG+P8rulXhMSXiigcrAhb22Ibo09Vg0yu9HIPlGTs1c4ljt0b1KnUd8Vl7S7ZsOM6AxJNtgltoxIzoJGLhrOsWeJjndEx/71DDCTKEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AD/cxQQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE160C4AF0C;
	Tue,  2 Jul 2024 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927417;
	bh=8xSDy43ox5BcR5NmXJ3vxQaOq5/T0Sg4W3yVzi9h2jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AD/cxQQ6tU8fOUyYEmqZmX4tmVYHNJNOWIUXqayAgBSQ9kS6zJkxhQiggvkZ+3Nwl
	 pG51CYv5SU6yNaubNW253f+81aK1rrFFafQGob0PfKTFcGERuCfcMaNaZjW2+SCtG+
	 c2HIE4ZOxeWGvkfMzfAHB9c2uOjYcAM+6TfSMYWjwrRCYR8M41N+DnzRyqeSLbFjR6
	 buv8ZqtX0BHo6ueH4Gk0cvuPjLUmVYJ6LDVxxoKrFqPmqsmhUJCD2z9E667motgf85
	 Xmdq0AQTB3rs9cyt9nj5hSErt/XsyLlAbZWR8vIZoezfmwa8eO7HpS3JUrOF09NPSu
	 6F1+6ppV6rxBg==
Date: Tue, 2 Jul 2024 14:36:51 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Igal Liberman <igal.liberman@freescale.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] fsl/fman: Validate cell-index value obtained from Device
 Tree
Message-ID: <20240702133651.GK598357@kernel.org>
References: <20240702095034.12371-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702095034.12371-1-amishin@t-argos.ru>

On Tue, Jul 02, 2024 at 12:50:34PM +0300, Aleksandr Mishin wrote:
> Cell-index value is obtained from Device Tree and then used to calculate
> the index for accessing arrays port_mfl[], mac_mfl[] and intr_mng[].
> In case of broken DT due to any error cell-index can contain any value
> and it is possible to go beyond the array boundaries which can lead
> at least to memory corruption.
> Validate cell-index value obtained from Device Tree.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/ethernet/freescale/fman/fman.c | 7 +++++++
>  drivers/net/ethernet/freescale/fman/fman.h | 2 ++
>  drivers/net/ethernet/freescale/fman/mac.c  | 5 +++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index d96028f01770..6929bca3f768 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
> @@ -2933,3 +2933,10 @@ module_exit(fman_unload);
>  
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_DESCRIPTION("Freescale DPAA Frame Manager driver");
> +
> +int check_mac_id(u32 mac_id)
> +{
> +	if (mac_id >= MAX_NUM_OF_MACS)
> +		return -EINVAL;
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
> index 2ea575a46675..3cedde4851e1 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.h
> +++ b/drivers/net/ethernet/freescale/fman/fman.h
> @@ -372,6 +372,8 @@ u16 fman_get_max_frm(void);
>  
>  int fman_get_rx_extra_headroom(void);
>  
> +int check_mac_id(u32 mac_id);
> +
>  #ifdef CONFIG_DPAA_ERRATUM_A050385
>  bool fman_has_errata_a050385(void);
>  #endif
> diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
> index 9767586b4eb3..7a67b4c887e2 100644
> --- a/drivers/net/ethernet/freescale/fman/mac.c
> +++ b/drivers/net/ethernet/freescale/fman/mac.c
> @@ -247,6 +247,11 @@ static int mac_probe(struct platform_device *_of_dev)
>  		dev_err(dev, "failed to read cell-index for %pOF\n", mac_node);
>  		return -EINVAL;
>  	}
> +	err = check_mac_id(val);

Hi Aleksandr, all,

It seems that this breaks linking with allmodconfig builds on x86_64,
perhaps it is better to simply make check_mac_id a static function in mac.c ?

> +	if (err) {
> +		dev_err(dev, "cell-index value is out of range for %pOF\n", mac_node);

Although other instances exist in this function before this patch,
it does look like this leaks a reference to of_dev taken by the
call to of_find_device_by_node() on line 194.

Maybe it is intentional, I'm unsure.
Perhaps this can be investigated separately to the fix proposed by this
patch?

Flagged by Coccinelle (this one is on line 253):

 .../mac.c:238:2-8: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:242:2-8: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:248:2-8: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:253:2-8: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:267:2-8: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:273:2-8: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:282:3-9: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:320:2-8: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:333:1-7: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:337:1-7: ERROR: missing put_device; call of_find_device_by_node on line 194, but without a corresponding object release within this function.
 .../mac.c:282:3-9: ERROR: missing put_device; call of_find_device_by_node on line 285, but without a corresponding object release within this function.
 .../mac.c:320:2-8: ERROR: missing put_device; call of_find_device_by_node on line 285, but without a corresponding object release within this function.
 .../mac.c:333:1-7: ERROR: missing put_device; call of_find_device_by_node on line 285, but without a corresponding object release within this function.
 .../mac.c:337:1-7: ERROR: missing put_device; call of_find_device_by_node on line 285, but without a corresponding object release within this function.

> +		return err;
> +	}
>  	priv->cell_index = (u8)val;
>  
>  	/* Get the MAC address */

-- 
pw-bot: changes-requested

