Return-Path: <netdev+bounces-230740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30EBBEE5B7
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 14:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD223A4ACA
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F472E8E04;
	Sun, 19 Oct 2025 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWazlU26"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E106824A3
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760878359; cv=none; b=STJrMaW9+/hX0gkiQzlRy+Q2+o8gATL6jZhFPo+Ww/8/Evbd3VN8x6mGv5pYsWdWklWyx46VTpj5xE2J4QnT5j3d/9ztLKKHsfws6eL4ByziwqMJCzZNMGb4MtnxNDw7HX5yN+hW294AcKPuG+vYB9kkiRP4KkH2m8Waq+hm/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760878359; c=relaxed/simple;
	bh=UbE88YWWAc8XyAp+MVFqgTRLPmVHI+mEJKw5PV4xPJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQYweHkTiGlPhQkvhnuFSEEC5UOr5QxExxW/bxEle8lD4gT6Vgy4gD6Us4Ro5jNBlQgchS4EcBGEl2ijV7Pm695BtPhyja1lhAaTscmYCRUZBS3IrKL/ZoH2Hh+a1En+Yv8rTgI2FyhbFdXPDShykM1oy/M6yB2WDiDvuxmcqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWazlU26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D965C4CEE7;
	Sun, 19 Oct 2025 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760878356;
	bh=UbE88YWWAc8XyAp+MVFqgTRLPmVHI+mEJKw5PV4xPJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWazlU26UIP2r3/7nSHClCUDd2fljjKVS3U2S3MijghV90B8txa7lRdERwqka3BBO
	 sp6o+TgAxQUHtq7+EIartjPYsQDdYWLWpek2zi2pMvx9dp4Fzl0DvvIwodFJqTslPq
	 IEQ+7FFsUIWJ6YWoqekPoitKNB8wTg0oFtbWgIOA+WfBL0fVZ8StI1ZFrtkfWp39K5
	 ri//sl9wukt79NZZ4/10t5CGxsOVwgR6uzD62G34z0ddIillr0Zlspj7jQx5fN3kZz
	 rRD+jj+uW0wXKYe00Sqv++ZshgpTI4QPtVnfMNQZjXUvvCm+foXjCYZkie+vXnhMth
	 QjH88B9wjgUtg==
Date: Sun, 19 Oct 2025 15:52:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com,
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v5 2/5] bnxt_en: Refactor aux bus functions to
 be more generic
Message-ID: <20251019125231.GH6199@unreal>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
 <20251014081033.1175053-3-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014081033.1175053-3-pavan.chebbi@broadcom.com>

On Tue, Oct 14, 2025 at 01:10:30AM -0700, Pavan Chebbi wrote:
> Up until now there was only one auxiliary device that bnxt
> created and that was for RoCE driver. bnxt fwctl is also
> going to use an aux bus device that bnxt should create.
> This requires some nomenclature changes and refactoring of
> the existing bnxt aux dev functions.
> 
> Convert 'aux_priv' and 'edev' members of struct bnxt into
> arrays where each element contains supported auxbus device's
> data. Move struct bnxt_aux_priv from bnxt.h to ulp.h because
> that is where it belongs. Make aux bus init/uninit/add/del
> functions more generic which will accept aux device type as
> a parameter. Make bnxt_ulp_start/stop functions (the only
> other common functions applicable to any aux device) loop
> through the aux devices to update their config and states.
> 
> Also, as an improvement in code, bnxt_register_dev() can skip
> unnecessary dereferencing of edev from bp, instead use the
> edev pointer from the function parameter.
> 
> Future patches will reuse these functions to add an aux bus
> device for fwctl.
> 
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  29 ++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 238 ++++++++++--------
>  include/linux/bnxt/ulp.h                      |  23 +-
>  5 files changed, 181 insertions(+), 124 deletions(-)

<...>

> -void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
> +void bnxt_aux_device_uninit(struct bnxt *bp, enum bnxt_auxdev_type idx)
>  {
>  	struct bnxt_aux_priv *aux_priv;
>  	struct auxiliary_device *adev;
>  
>  	/* Skip if no auxiliary device init was done. */
> -	if (!bp->aux_priv)
> +	if (!bp->aux_priv[idx])
>  		return;

<...>

> -void bnxt_rdma_aux_device_del(struct bnxt *bp)
> +void bnxt_aux_device_del(struct bnxt *bp, enum bnxt_auxdev_type idx)
>  {
> -	if (!bp->edev)
> +	if (!bp->edev[idx])
>  		return;

You are not supposed to call these functions if you didn't initialize
auxdev for this idx first. Please don't use defensive programming style
for in-kernel API.

Thanks

