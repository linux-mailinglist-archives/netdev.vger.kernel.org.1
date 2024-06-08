Return-Path: <netdev+bounces-102022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B3090119E
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DA91F21D6E
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F37717836B;
	Sat,  8 Jun 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egyGoVA2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1F15CD74
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851623; cv=none; b=ilQ8vUJ5D5uCleO3TSzWtD0sK51xHDZ6eiZIWS6eFK8Vr9SUUClLcyChI0lAa7Q9FW///3rSQvL7X0+HKTfzQQ6VcK7UVhbXJYFsnW3xJDlOnytpZlq9Ox6ZLMpR7q5+S88ZdNr8IYp2CaNFzu/2deaxgxU7ZiM5YFjhnUEYPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851623; c=relaxed/simple;
	bh=7PfiwW4bAJ/Eo5hqFsyp1HnntREE7yvPLc6uJlfo4vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFa5lHPBmCGUDQkapfD1k27bgJjb8cu8dP8xDj7Q4AQBSVA1j321m0ZX4ZRVDVQvjOZ6jcEWgMH00ubrwgdNnEu/WwbbLO9B6tJKZ2m3qd2JkJa3kUbAFU1wQEd7KUM6gchodZY5aTTWizi+EdhJKW3TyTJ2d8jKemj3Z0zZdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egyGoVA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5514CC2BD11;
	Sat,  8 Jun 2024 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851622;
	bh=7PfiwW4bAJ/Eo5hqFsyp1HnntREE7yvPLc6uJlfo4vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egyGoVA24hS9jzoXgR5kog999cSAlF2mBgWN4bxHaZt3bWJ/rVuHZPIwlLeOiIwP+
	 thzwO6pAGSL2L4LBiSYm+kYgkcRLZqJxLYnB/HiC/AvUMuOlXSMIAy4cbpeXTPzZkC
	 oTE3IsH3ubvj22LfKyvYedl2ROAe/Y4XIu+2ucG70wso2TRcEff3Ofb62QdyVFdGSr
	 uHhVsykm3Fg/KHSapUjqU1s28dFoKAXkIqnJbagJ6RZBPJpGDW65QrLa8xUi67BWOV
	 EzSuQpWRmz9c7WQbLUBeJLLbR0DhmPBoDIz8y7DNe+R6HrMZuigYHQRW2szxNtXm2g
	 h8XJFiztXadpw==
Date: Sat, 8 Jun 2024 14:00:19 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 12/12] iavf: add support
 for Rx timestamps to hotpath
Message-ID: <20240608130019.GE27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-13-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-13-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:14:00AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add support for receive timestamps to the Rx hotpath. This support only
> works when using the flexible descriptor format, so make sure that we
> request this format by default if we have receive timestamp support
> available in the PTP capabilities.
> 
> In order to report the timestamps to userspace, we need to perform
> timestamp extension. The Rx descriptor does actually contain the "40
> bit" timestamp. However, upper 32 bits which contain nanoseconds are
> conveniently stored separately in the descriptor. We could extract the
> 32bits and lower 8 bits, then perform a bitwise OR to calculate the
> 40bit value. This makes no sense, because the timestamp extension
> algorithm would simply discard the lower 8 bits anyways.
> 
> Thus, implement timestamp extension as iavf_ptp_extend_32b_timestamp(),
> and extract and forward only the 32bits of nominal nanoseconds.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


