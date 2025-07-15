Return-Path: <netdev+bounces-207099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7294DB05B9C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400AF173EB8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778B2E1C69;
	Tue, 15 Jul 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lol7b52/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440991F4CB3
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585672; cv=none; b=ts+2qF1LPwq7miooPjDme1GXZNWLkl/Wyl6Bt0Fz036c820nMRJwmkefsZGnl3bNBXWafT+N8JIbP6v+28SgKBoE01OOHC0/WNY94AvMqAT/XOYW1Px5CNQj45IyzSt8PrqliYOv9ROSvn48lbX+SS1fjT5cbhYn+ymuns3F8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585672; c=relaxed/simple;
	bh=cduf0vQbAq00fGLYzsJu8a1YuwVf/h/K4o/Gu+lMZss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfH/o9fCo/nq+gVM7HxRGYeWN88tKYkvO2M/ohdvEf+dILewH6DoSmhMbVgzphjOHanuOI+9xD1AmuGoGmDLq3aiCwmd2RKZdfHZ7j+PIj3vErZSEqaY6ujvZ4hlObYgCLAbKKNH9K9PuBJuJONQ6A72bZLIC0WwBhUndkOuAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lol7b52/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8596AC4AF09;
	Tue, 15 Jul 2025 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752585672;
	bh=cduf0vQbAq00fGLYzsJu8a1YuwVf/h/K4o/Gu+lMZss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lol7b52/lO3B0zNyoiwbbYWc9c9u/KO/NANbkA3U5kQiVQ/rfC7SRLhcIYu69hgDr
	 8QtXWiGSx+CqsWMZ2OJbDdifZdgunB79HBZ4SylqTAEtEjfLBrGUvR1g3hkkQOCLV5
	 X8Rh8LK+nbAWXBiFlA0XVc0BNx7M28r4QSaF315sqITG24PkCveNxc8YASvnymkGa+
	 DXcvNDirOV/XEFbkENqWTmrNH3xiUE0nGXgpL9adhWUo0vizAmczzrxvsHfHzH7/Sk
	 ygG73ZFZxDqP/U0utmqzGxfiaho1GeGURZt1bGWs+X40tkYCx7fLbqkzWPlr+ZPPn9
	 1uGJZP+hKP/JQ==
Date: Tue, 15 Jul 2025 14:21:08 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, bjking1@linux.ibm.com,
	haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com
Subject: Re: [PATCH v3 net-next 1/2] ibmvnic: Use atomic64_t for queue stats
Message-ID: <20250715132108.GW721198@horms.kernel.org>
References: <20250714173507.73096-1-mmc@linux.ibm.com>
 <20250714173507.73096-2-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714173507.73096-2-mmc@linux.ibm.com>

On Mon, Jul 14, 2025 at 01:35:06PM -0400, Mingming Cao wrote:
> This patch improves the ibmvnic driver by changing the per-queue
> packet and byte counters to atomic64_t types. This makes updates
> thread-safe and easier to manage across multiple cores.
> 
> It also updates the ethtool statistics to safely read these new counters.
> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Brian King <bjking1@linux.ibm.com>
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
> Reviewed by: Rick Lindsley <ricklind@linux.ibm.com>
> Reviewed by: Haren Myneni <haren@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


