Return-Path: <netdev+bounces-224054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACDB801FD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3B13A56E7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846712F4A00;
	Wed, 17 Sep 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW3vELVL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC762F3625;
	Wed, 17 Sep 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120036; cv=none; b=NxnF16F8T9zms7agFcQIORsLWIbPC8Btn6MYoVSC/TQlTwdK1hwPkJ6ZwEXfJskfHnxwHzLc2s7+OzxwsDMOhk7/QtB+d7JA5C/E+7v04UouxC59XHT8UU1lIN58aC3IvVe0cor7lb4VQoRyLM37OA9HnCt2rNfwa9i21dMQEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120036; c=relaxed/simple;
	bh=amuwIP0ihWpW9RpSZ0ln4C1KrMMOWz79uU+9Of6Dhes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSPherwn0rq+5yCoRWJ9sRh1vtDb5RMA60cGiT5VU0gtlwuLHJW6GLJznbnn+L4UY7wH2YWzQh7euKOTQh0YMu2H7HnoAZRCafBivH90TPT6JcgUCYPWYHMzciZt/BAzgsTDQe1j3w8MlDyEcnS8U3+52SRsUbYQsBQp9IyqqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW3vELVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83612C4CEE7;
	Wed, 17 Sep 2025 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758120035;
	bh=amuwIP0ihWpW9RpSZ0ln4C1KrMMOWz79uU+9Of6Dhes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW3vELVLfmWf6BljAd38aX9vVBUUUj9A3NYQLjz1Paq5ejHWVJrogyiDP7Fj7psYJ
	 /SkiE8YQ+K7X/+hOKbPWtddq+6gqzd8IbrDKHdWPmNgtldUzZSh+Cb8cn1amaAqE1A
	 1ablq1TWleEMamoSgcoBE/NqBoNcyrGcSurfEcZ1pupQrdbX66R3ArwSgIdZW4XHp+
	 POaZR4qAwZRBmH+3+uV0j/UCBAGKoKUJkaSqsrdwXLwxOO0ljS3a0o04z39bvIqC/W
	 Rp0CeVgKjKROqWrdmGtwqkyFtzn+fhJ9t5c9Do6+HYt6TfjLsUmz3nIBmYymuwehlA
	 9OHpzwoEhm5Xw==
Date: Wed, 17 Sep 2025 15:40:31 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, hgani@marvell.com,
	andrew@lunn.ch, srasheed@marvell.com
Subject: Re: [net PATCH v2] octeon_ep: fix VF MAC address lifecycle handling
Message-ID: <20250917144031.GM394836@horms.kernel.org>
References: <20250916133207.21737-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916133207.21737-1-sedara@marvell.com>

On Tue, Sep 16, 2025 at 06:32:07AM -0700, Sathesh B Edara wrote:
> Currently, VF MAC address info is not updated when the MAC address is
> configured from VF, and it is not cleared when the VF is removed. This
> leads to stale or missing MAC information in the PF, which may cause
> incorrect state tracking or inconsistencies when VFs are hot-plugged
> or reassigned.
> 
> Fix this by:
>  - storing the VF MAC address in the PF when it is set from VF
>  - clearing the stored VF MAC address when the VF is removed
> 
> This ensures that the PF always has correct VF MAC state.
> 
> Fixes: cde29af9e68e ("octeon_ep: add PF-VF mailbox communication")
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> ---
> Changes:
> V2:
>   - Commit header format corrected.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


