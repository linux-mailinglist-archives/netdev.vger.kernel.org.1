Return-Path: <netdev+bounces-125204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A747796C3FD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE421F26DD8
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E11E1301;
	Wed,  4 Sep 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP03c9F8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6B1DEFDF;
	Wed,  4 Sep 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466833; cv=none; b=Yk4Z5IdHZ64oIgszu+Sh94QjVO5k0EC76L8Gjuwu7cxmJ2DgWJ3zZ9dYP88y6sUjYDJgEAiG6p7QlmvfJe+0Xb+pi2roAmpEYI3Y3uUtT2z2GmgxleYuS9fJ5Aa9I8mxK+RmKvQHtPjVNr2G+csfAxQcz+xI2i0fQyOlaTfAI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466833; c=relaxed/simple;
	bh=VoYT+jETiuda1xS2vqsmwkwlGs8dsq5FW7EalM3HycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgNVOM9JjvT2cBxdhe5oaeO86k51UUgXyVt3QwrWEx6YQTnsHmsM4VgLeZOwi4rFdvYpKWrXTMzLj5ldkZxRkAssV62OAefmizIK31O4pCgSjXTlLx3wYGRCoqSGaQiZ+Wji6fFZIR369Na+/JZpeV3XcfQhbnhGmYsHoul9wD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP03c9F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489FAC4CEC2;
	Wed,  4 Sep 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466833;
	bh=VoYT+jETiuda1xS2vqsmwkwlGs8dsq5FW7EalM3HycA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NP03c9F8ybbzutUGyi/oChtpifzmMuY6on3Tpr88/NuU8JHL4GZsJwTIEbDBIMnpa
	 DgT96YeusDcTTPvU4yTIKxCd3EbxjYRGoO3sTMjxP70PMyC130b4A1YzgX7ST0ieiQ
	 sbteagUXXeQcsV+6ETzvp4iXLxDrjCMD6Kj0J1YUokXqSFzK1V3EvG4yLOMzli2HpD
	 2CgNwCgYj4Vp6h2q/uqjPOHc2//Smtstsa7NCS88eKXSVLOEJPY8IoA9wNwSOyxF13
	 mOh9gu9ow24vOY4KxtvyfOvCG4sg/Cp6pQrutdQ2FGnM+Nt67zmnASDDllmgcsqrnu
	 dtR6F/UhaNJ1Q==
Date: Wed, 4 Sep 2024 17:20:29 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: xilinx: axienet: Relax partial rx checksum
 checks
Message-ID: <20240904162029.GA4792@kernel.org>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
 <20240903184334.4150843-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903184334.4150843-4-sean.anderson@linux.dev>

On Tue, Sep 03, 2024 at 02:43:34PM -0400, Sean Anderson wrote:
> The partial rx checksum feature computes a checksum over the entire
> packet, regardless of the L3 protocol. Remove the check for IPv4.
> Additionally, packets under 64 bytes should have been dropped by the
> MAC, so we can remove the length check as well.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


