Return-Path: <netdev+bounces-138514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671B29ADF73
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6139B20A9A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829781AE001;
	Thu, 24 Oct 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxqH69Zw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED46189F4B
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759673; cv=none; b=pYFoLAj377PSQvTWi9dtrJc7+Gi8vsfBfXgwUVfm+MMtWwUDSDxV3L9awO391ooqVAEXYnQTB40pHbtaulDICALKp/NW/KQjfYu664QeVczOhhz78av36uBnoNOodIVr8ydB3d9oXEePor21sUlR6T0yTtRIcb0juKIantfaHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759673; c=relaxed/simple;
	bh=qhjZCMWnm45zGZSapYpTCxdl7NmglF37kg/mm9ap6FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPUIOiHp3SwUxN6kxCAA3CYsK3LohRcvZNhUGPfAcEnvXqdPXVg5mTZMeRLu/nt2eXFfnSOi+S8iAGeMypqxEwNiBXIZk/DRouu0l192TISe4G2keL94yvxl9s+t45JeAgOdI3S/4ba0wJ2FHsXDSg1XR+uB3gLwpJ8eSbpjIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxqH69Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8923AC4CEC7;
	Thu, 24 Oct 2024 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729759672;
	bh=qhjZCMWnm45zGZSapYpTCxdl7NmglF37kg/mm9ap6FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxqH69ZwXJCgrRaLpO/NmG8IdMLcM0TWkOLMeGhGsx1PJ/ow84XM7ZIPcypwCxE34
	 EJ3icEZK+72/tAMaF7rKIkDFXiOuC9seEbIgRh5EyYOHbD1tHjO4ghWEoRwTscqVZr
	 R+1UuYYdx0e4l1gdFoECNx+9Eu/+RrQqP6IPQJHoT3rdBUSD0Iq+hOUNFiEP48PrjN
	 /oOqDvBLnUlQ9ji7rOXZ+wD5fqc2PlIv+K3AXiWvRaR+xBvovX/+mle8UYhnzTirST
	 CEOux6hDNekoN6bD8meNMG+hjXsyWtPdOx7IRK/S9SLVGKVeEqjCCdImCPPoiBkY0z
	 yziAjfeBiRMuA==
Date: Thu, 24 Oct 2024 09:47:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net 2/3] ice: block SF port creation in legacy mode
Message-ID: <20241024084747.GF402847@kernel.org>
References: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
 <20241021-iwl-2024-10-21-iwl-net-fixes-v1-2-a50cb3059f55@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-2-a50cb3059f55@intel.com>

On Mon, Oct 21, 2024 at 04:26:25PM -0700, Jacob Keller wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> There is no support for SF in legacy mode. Reflect it in the code.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


