Return-Path: <netdev+bounces-70582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F484FA74
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C441F21447
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80536DD18;
	Fri,  9 Feb 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn1NBWl0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDE364D2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498121; cv=none; b=huuiMMi8Tw/61kv6KHioW4oNLqw1wvO1BuYx0jPVzjvebMHBhgu5yB3tl/+LFrrOnzFg7K/mrWHGhy7FWAD3ccWvFBDHHq7ZmazrC9s0JdES2ocAWWcopZReEAtuQ1mGxUbS6OM1jq2rLaa1UY9cSSkB87+gIUFTVGkDom7UMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498121; c=relaxed/simple;
	bh=qhbgSvAgxPjP/9ZwtR46TunoUtvWH6BA76JdIbxr7k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsofqhJchPu9ggsDhnT2fkZ2ugWN/90qlqdQ0pHJOBMfdWcoVdeOrFGzrHGnccXkeXDpNju2Un47IBAVj4z3ut5iyYTo4+R1jxobgHd91qKQTGFYnGbnQoO1zdfWmMNVjKCLCuGZifdN/NhSnkcOYMhf+8PUjCJDHF+HE07dq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn1NBWl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAFDC433F1;
	Fri,  9 Feb 2024 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498121;
	bh=qhbgSvAgxPjP/9ZwtR46TunoUtvWH6BA76JdIbxr7k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn1NBWl0V5uL6nOT8L+D3b7lp5CfAJ2taUHdg1oqVpEH2vM7MMWsgLa+CzDVGSMj5
	 bmew4w+hpYcn3hoD4z9D1Q52KEeLlNZbIatKDtSJo5CWlfH3vp/nxqjYmtXu4/jegi
	 s6sVQZZV/vq7IDV/iXe8crwbud262KbZSfEz/3VDauA7ycJaDYKVZ/QvVCJaOAbOl8
	 sDqC26HWaWA9PoYeJR0gchNqer4LF703NmFfhf7HzvvafccflVfBMpXL10v+PudrjN
	 +T+K3LtZnQhyl3V92qYUoYp/kiEqzQfz0YLVnFvqhLxu9Z/M1cwRBmCNSaegRUdJm3
	 mjJywghtoFMsQ==
Date: Fri, 9 Feb 2024 17:00:26 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Plachno <lukasz.plachno@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	brett.creeley@amd.com, pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v6 2/2] ice: Implement 'flow-type ether' rules
Message-ID: <20240209170026.GB1533412@kernel.org>
References: <20240209101823.27922-1-lukasz.plachno@intel.com>
 <20240209101823.27922-3-lukasz.plachno@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209101823.27922-3-lukasz.plachno@intel.com>

On Fri, Feb 09, 2024 at 11:18:23AM +0100, Lukasz Plachno wrote:

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
> index 1f7b26f38818..ec8a84b80a73 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
> @@ -4,6 +4,8 @@
>  #include "ice_common.h"
>  
>  /* These are training packet headers used to program flow director filters. */
> +static const u8 ice_fdir_eth_pkt[22] = {0};
> +

I think it was agreed to drop the "{0}" in the review of v5 as it is
unnecessary.

...

