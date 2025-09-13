Return-Path: <netdev+bounces-222772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44423B55FC1
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 11:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007C4A0724B
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1302EA173;
	Sat, 13 Sep 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSbkRV2H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FE2C0F75;
	Sat, 13 Sep 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754435; cv=none; b=dGlSm2c7TPlENppKf0XRJu961fJvc6WwEUr8ExXKo/X9E/ndPH41Ws62GHeL2JhqwAne5mw+HyEAaFJEaUgJaVeMqXIC0lyqf5gEUOTGT2ihM21mZEbzZJ5SyfhEj/maWezw9HOiureGScbOiqTqTiOYZ1F4oGbRk9kZw4JKBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754435; c=relaxed/simple;
	bh=cb2Q1hU2BTJSMSERZdg9xxImCo1b0IDRVIFl13zEi7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgShBX8zzY5WEv9tNO/zLiUau1BcEITNZJSpVArtDPUWGEymSKcBc7V/1NGFKtp8t1VLBYgjfm3J+rvFU9faiTusWbKZMLJJu3b13EJGO4cTi/bBdYVZpmg/uyGRQdG7Ljp/GvReL5uaeSoAimmUJPhNI2TNPROZu5s7Aa23J2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSbkRV2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A797AC4CEEB;
	Sat, 13 Sep 2025 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757754434;
	bh=cb2Q1hU2BTJSMSERZdg9xxImCo1b0IDRVIFl13zEi7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSbkRV2HmBGKR0IvjNlWBMNvMj2ZwzM+axTyyVP0B1NhK/lPu29kleoUZYZ0kzHE6
	 iIBLvIEwW1BrD+itZRICi/qMl2r8xilMBWAge74VRMSj4izWj0p87oYKpn4rMlfUaM
	 DWwYT1YW/7jKzKB805wqGN1AccB+foRDwD4JNeKfK2PaUxdNUHLHTdPZN6WOCs3OLY
	 /AoWkr4njKga7pyCKxB/j32CHsiUjr0DmLygOuEsa6+h37sc8aMQHT35aW8QDKqEKz
	 dMA5GDF82bnpzuTGiEDr7R11sFiFMwABTlL/Nq6UfaNM5QHGL7IOLq9DpyslmjYNOf
	 SDmPuQPPsda1Q==
Date: Sat, 13 Sep 2025 10:07:10 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
	corbet@lwn.net, Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v3 5/5] ice: refactor to use helpers
Message-ID: <20250913090710.GJ224143@horms.kernel.org>
References: <20250911-resend-jbrandeb-ice-standard-stats-v3-0-1bcffd157aa5@intel.com>
 <20250911-resend-jbrandeb-ice-standard-stats-v3-5-1bcffd157aa5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-resend-jbrandeb-ice-standard-stats-v3-5-1bcffd157aa5@intel.com>

On Thu, Sep 11, 2025 at 04:40:41PM -0700, Jacob Keller wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Use the ice_netdev_to_pf() helper in more places and remove a bunch of
> boilerplate code. Not every instance could be replaced due to use of the
> netdev_priv() output or the vsi variable within a bunch of functions.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c   | 48 ++++++++------------------
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c |  8 ++---
>  drivers/net/ethernet/intel/ice/ice_lag.c       |  3 +-
>  drivers/net/ethernet/intel/ice/ice_main.c      | 10 ++----
>  drivers/net/ethernet/intel/ice/ice_ptp.c       |  6 ++--
>  drivers/net/ethernet/intel/ice/ice_sriov.c     |  3 +-
>  6 files changed, 24 insertions(+), 54 deletions(-)

Less is more :)

Reviewed-by: Simon Horman <horms@kernel.org>


