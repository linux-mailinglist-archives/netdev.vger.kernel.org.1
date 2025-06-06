Return-Path: <netdev+bounces-195431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2006AD0287
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475C53AF122
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061327CB02;
	Fri,  6 Jun 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIqpasan"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C359F9EC
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214220; cv=none; b=WdU+iEYVzKw7ohv6qD7wUvaXS0FW4Hb2m4BLrBkhWC5lglFOetZhCrmbA5bpT+Dksy/+U22r+pbypOHzPbsRVzf6A7pfx4GFGfTUMdHYPCd3Uh5rDSuR6uGVeWFlkG6n5wdVQngHN2WYhDJDitbnOfgEaMdsD6SEUXDFrg5R6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214220; c=relaxed/simple;
	bh=6mtQXa9APW+oxzhnk0qABoX8QSUiF2tS39RTUQtorzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1eDnJ1jo+6NWDFz/TFqWtij3yDRmScOIb9zwCXWGxBWb8iC36PdXtKX0jx870lRSEUxwC4+MSrccQEC4cazbyCU4piBNgRRfNkX0vGdrNm6wy5XKX1aJes36EzRo+UUOyC7MmFg7c9cNKtpXrClgeP7HksJN6LXlguKQ5XqrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIqpasan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE22C4CEEB;
	Fri,  6 Jun 2025 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749214218;
	bh=6mtQXa9APW+oxzhnk0qABoX8QSUiF2tS39RTUQtorzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIqpasancCrtpz59LbEcXnql1PmHt/NeSqa1iODu+nBkeQIZrOl+nTbMGd0wJ+Ayp
	 +kb33sR1e8LkNvtzc0hcDDdaB8J0rMnRyLTozj8YWTW523JyS7S52r1XsxnqyVbKIz
	 vHXoqwb1czNnXxlfzOwMDoyw7+bXQj/dPEe4R6cukU4X3l/eO8TlDxsHZVQITjsadw
	 Jn49sCLE3g4tzXf1OeBTt3tus+If754bGsFNnMJgsi32onMwyQQ+G2xVmvjXTt/EsD
	 4lpwMqkK1URntMyVRh9P2fEo70xqbsLuHtTgpgPDbpo3ZKsNdHpFKNwP+k+XEOQHlQ
	 YlKmJP6Uemtng==
Date: Fri, 6 Jun 2025 13:50:14 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next 1/4] ice: skip completion for sideband queue
 writes
Message-ID: <20250606125014.GB120308@horms.kernel.org>
References: <20250520110823.1937981-6-karol.kolacinski@intel.com>
 <20250520110823.1937981-7-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520110823.1937981-7-karol.kolacinski@intel.com>

On Tue, May 20, 2025 at 01:06:26PM +0200, Karol Kolacinski wrote:
> Sideband queue (SBQ) is a HW queue with very short completion time. All
> SBQ writes were posted by default, which means that the driver did not
> have to wait for completion from the neighbor device, because there was
> none. This introduced unnecessary delays, where only those delays were
> "ensuring" that the command is "completed" and this was a potential race
> condition.
> 
> Add the possibility to perform non-posted writes where it's necessary to
> wait for completion, instead of relying on fake completion from the FW,
> where only the delays are guarding the writes.
> 
> Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
> command to ensure that writes to all PHYs were completed and skip SBQ
> message completion if it's posted.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


