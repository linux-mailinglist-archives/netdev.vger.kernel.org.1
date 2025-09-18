Return-Path: <netdev+bounces-224624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 231A8B8737A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BBD1CC0CEA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C72FE071;
	Thu, 18 Sep 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q32kYSOX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8FC2FDC47
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233927; cv=none; b=BlSJHTZRx5HTBeVKDj8GE+/hvnvfGp1e3SqZmT+kLkRYRhGMaEnUt2e4tNwY5WBX+tNuTVKiTg1HOUNZbhnphLEO+aZ0w6LbW12/vEdORdtYaO6Z2fEpQk4SOfkPi4dCfWjDsT5vZgPu1tEIWzoEs5Itoi+8ZNMW4iAtI/ZTWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233927; c=relaxed/simple;
	bh=S6cIfV3T6k8+3VMZBUVzQqrY5IhvkrDooFRPwjjtCPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX5OGmCztzQG7XV38Nk1skLAChVPMcrH1aQjBvHRuvLFSqs5m3DFRRLnhqCEw4B2t8mPZ1tY1pEJGO2o8yl1h01eR2/iI1CzU/EgW8l4Aqk2mhMFTenb/zGEKHxrEZeBVtERGaqMlU9prR0GzAsTJQnZHWVW5DJsZIbiz5v8ooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q32kYSOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EABC4CEE7;
	Thu, 18 Sep 2025 22:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758233927;
	bh=S6cIfV3T6k8+3VMZBUVzQqrY5IhvkrDooFRPwjjtCPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q32kYSOXxzxLlz0upe7KosjBb9q9nMnAau2u0ARjeXnZV0xduHoLPycwuCIRWv6uf
	 eqzTsQkv+6QaZVx7liZaVcFRp5MmxSBETHGsQxGOwKDfZ6KucSbLaLTkgMl0mRP5l/
	 p9IpK/fYNE2/lJ7N/Lb6LClEC6H7ukFFHa/fTsohbkbdqLUEqiI+LzZzIOhHLC+cO3
	 ekNCuQbFhJzOFSANznI1njrFi5yEOqJFgR6JTd/g96ANjzbfPwLdMLEEQuOBmSdHxo
	 IFcKs86NESoCPfydY3u5PiN4ZgeuKMmr07nxC98YVgAEfezQI81lJSEw2ybfPIUP88
	 A1F19eHifi8aw==
Date: Thu, 18 Sep 2025 15:18:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald Hunter
 <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, Yael Chemla
 <ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v3 3/4] net/mlx5e: Add logic to read RS-FEC
 histogram bin ranges from PPHCR
Message-ID: <20250918151845.32a90e3e@kernel.org>
In-Reply-To: <f84efe86-098f-4783-85af-4289f62804e9@nvidia.com>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
	<20250916191257.13343-4-vadim.fedorenko@linux.dev>
	<20250917174638.238fa5fc@kernel.org>
	<4d3a0a08-bda4-483f-a120-b1f905ec0761@nvidia.com>
	<20250918073551.782c5c25@kernel.org>
	<76611a9c-4c53-40a2-96c1-e1cf5b211611@nvidia.com>
	<20250918084000.1b4fb4f4@kernel.org>
	<f84efe86-098f-4783-85af-4289f62804e9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 22:41:38 +0300 Carolina Jubran wrote:
> On 18/09/2025 18:40, Jakub Kicinski wrote:
> > I understand that the modes should not be exposed.
> > I don't get why this has anything to do with the number of bins.
> > Does the FW hardcode that the non-Ethernet modes use bins >=16?
> > When you say "internal modes that can report more than 16 bins"
> > it sounds like it uses bins starting from 0, e.g. 0..31.  
> 
> The FW hardcodes that Ethernet modes report up to 16 bins,
> while non-Ethernet modes may report up to 19.
> And yes, those modes use bins starting from 0, e.g. 0..18.

Which means that the number of bins doesn't really matter.
You're purely using the bin count as a second order check
to catch the device being in the wrong mode (and I presume
you think that device in the wrong mode should never enter 
the function given the WARN_ON_ONCE()).

Please check the mode directly or remove the check completely.

