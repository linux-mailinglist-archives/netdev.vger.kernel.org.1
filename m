Return-Path: <netdev+bounces-217706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E47B399D8
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246CD7C4F11
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380B30DEA4;
	Thu, 28 Aug 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOOfqvRD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848230BBA5
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376800; cv=none; b=HeI3GVB8uUxT0PR7rTNo9vEx+9ehlVtRbpiiu8Rm/buPA0QprBcXQoGgMAgph452QWn7HfxWRLxZSibApK7OGOVkQevKn9iJotBVkC8HjK6IRcS2hfulsomEZUspifO62mVX5BBSZ1IBmhmwZY90QAx6pdWvJShyCudH03nMy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376800; c=relaxed/simple;
	bh=jjWFbeI85fVGtJhHe9mfqBYFtnaSigDCTJa/SyiIuyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI5s907EC0/VOxw7pLitPD3wV8IMvgDqGGd5rfFXWxRC2xuIB69COsHiMV2/MxBZqHmzc1HGfimKyPGcqiNeCPF6QiRBu1K5jKw9qyQ/i33vs7jOjagj+phezyf9sSXoS4dffRGSIJr0ZslswFY5nTGFXOsQjSghBCZFM6wWuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOOfqvRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E825C4CEEB;
	Thu, 28 Aug 2025 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756376800;
	bh=jjWFbeI85fVGtJhHe9mfqBYFtnaSigDCTJa/SyiIuyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOOfqvRDUJII6AzFkajWGDE0OPPDUrigBiH+iC1mBhScX/JLPU0p2jwkrmuzeWqca
	 /dHBeZUbeZat8WMQp0/3y1O3/EHFw2l2Ld80B1xg9b8grQIDdCJa8566mOCKME8ull
	 mfMKNZa4FaxBisa9lp+sm4tuhxCpaOs7gwPDyBFVJcWI4ZE1pfGFWbUrpu2/DtjSyB
	 VaqEDvS28j4SdpqzAaDIzJE0AWA/MJu6d/laMlPkftMH2OUchYUCllpc1sdxlzNjKN
	 EG6iGaMbCaYQLNKSiCqzt0wBnSDEi3dyyjrZC2K6I7fug2o6mBwSpr3HoOMwujdZI0
	 hWo86aSRs3hVg==
Date: Thu, 28 Aug 2025 11:26:36 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 3/4] fbnic: Add logic to repopulate RPC TCAM if
 BMC enables channel
Message-ID: <20250828102636.GX10519@horms.kernel.org>
References: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
 <175623750101.2246365.8518307324797058580.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175623750101.2246365.8518307324797058580.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Aug 26, 2025 at 12:45:01PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The BMC itself can decide to abandon a link and move onto another link in
> the event of things such as a link flap. As a result the driver may load
> with the BMC not present, and then needs to update things to support the
> BMC being present while the link is up and the NIC is passing traffic.
> 
> To support this we add support to the watchdog to reinitialize the RPC to
> support adding the BMC unicast, multicast, and multicast promiscuous
> filters while the link is up and the NIC owns the link.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>


