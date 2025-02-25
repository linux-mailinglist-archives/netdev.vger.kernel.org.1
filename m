Return-Path: <netdev+bounces-169387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD178A43A56
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3543B6C40
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88712627F5;
	Tue, 25 Feb 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7anxuj4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9A26157E
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477025; cv=none; b=GzGfpXspidVtYWbziha3hBcuZr1fXRXjsKnI/DpSiOb1rF4kQkjTWNYNi4kecXqRF9ULD5pa9a2OtYxlwJ8eaUWUbbuXfSVQTqY1zJY0DHRAkpaaUD0OL+laU35L4dVZnPHn8uMCSL0PzhZKgfT6JE3SrJMRz+1kunqpNhav6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477025; c=relaxed/simple;
	bh=R9IAsn/L53EggdKqXzsabdBav6X8XQ4XTacPu2ZXr9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZLP+O+C/JuxLy6taXWpQi1x7dczX3sGmOeJywqy6C7AN+ddB7ynOoGPT69ZjiDViesR/u1kKWwXOJT3HQ1RReD4rfrKECloZBXnuXBi11rQQFQQCtHZzFFG3Q3zRzPWlOC+sOooU69gFpgFTeSU+MU6asLuqHWePNZuLkH9DgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7anxuj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4D1C4CEDD;
	Tue, 25 Feb 2025 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740477025;
	bh=R9IAsn/L53EggdKqXzsabdBav6X8XQ4XTacPu2ZXr9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7anxuj4xZR8gLYCKAqx5HjW6bptcnV+1b79c18Du6SwFwrk0MTHQmu70Pifdo4/q
	 lNnguyOL/DUbsZV8t2XuP6oWvI86FIo/FDJe2Rv5p7JCGob9aeXScX4K24iUqfLcvE
	 y4L10vND3+t9rQH71q4bpStkOJjMkPO0WWd+mmiIsUMeyWn7jtWsPvU/WDwKajtvf7
	 MdqTMG72Rk/fTfTI0/wNGeICp+FC6QBorHHJogHrAhnwJUSNHl5xPkvwQ2cCQa7526
	 kBYvzfOrB5xh1CtCxPB01GrcMoGcvWJ8hSRWGK9iBWLViAXQ+nqQ71sHE53IxWCgL6
	 AK6k/XP9lm72g==
Date: Tue, 25 Feb 2025 09:50:21 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-net v1] ice: fix lane number calculation
Message-ID: <20250225095021.GK1615191@kernel.org>
References: <20250221093949.2436728-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221093949.2436728-1-grzegorz.nitka@intel.com>

On Fri, Feb 21, 2025 at 10:39:49AM +0100, Grzegorz Nitka wrote:
> E82X adapters do not have sequential IDs, lane number is PF ID.
> 
> Add check for ICE_MAC_GENERIC and skip checking port options.

This I see.

> 
> Also, adjust logical port number for specific E825 device with external
> PHY support (PCI device id 0x579F). For this particular device,
> with 2x25G (PHY0) and 2x10G (PHY1) port configuration, modification of
> pf_id -> lane_number mapping is required. PF IDs on the 2nd PHY start
> from 4 in such scenario. Otherwise, the lane number cannot be
> determined correctly, leading to PTP init errors during PF initialization.
> 
> Fixes: 258f5f9058159 ("ice: Add correct PHY lane assignment")
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


