Return-Path: <netdev+bounces-129434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15C983D6C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A7C1C2282D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7881745;
	Tue, 24 Sep 2024 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQK7S54S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B842AB3
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161012; cv=none; b=aU0yn+iLI7oT+O3dMEXwzuGAK7x25f5cBEpKnUDXBADLAE9D2YrwoQY5u3Xew2Xxu6AeBF/seYE1h5/zZnLU+ofI8DqtWl+D3CGScuE65SGaUrXevwbgojE8o8HN4ZEC+cPveZAdo7GDrlBqcsOWjd4wQAuIr3Xmw4gfNmNb3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161012; c=relaxed/simple;
	bh=ofTvkF/mmzHGwcIuloNc9Ojea00VUkw5pNfVGUZMTGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tts1ltk5vNNvfCmX1Iyesgme4Y8M9l9o/ZEznv9jOXsFLkrlqJ4fnScpKzuuvm0OlWRgWRZ+aOrj1k9/DphvnZAznQtH8e8z3AWrUK/pkVkrtXn+9jfnokGYO4+hn0SrNCoW8xMgVbJk/XuwfGNjgC84vhbpuFHSFIJHEDHA6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQK7S54S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C624C4CEC4;
	Tue, 24 Sep 2024 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727161011;
	bh=ofTvkF/mmzHGwcIuloNc9Ojea00VUkw5pNfVGUZMTGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQK7S54SHK6KGaDF4yiIBLLsGpDt6GtRmrfcj8y5dlj67aPL6y8j6XqK/sTUdYx+5
	 RI9YY0nBJMU3duIx40038cWynSriJUNPOr539xmBHGv+QVXdKNEYgZRKitpffbbagV
	 6+a9cZBLFeOHCUFXLGL5xTE+hnI358D7GPRwtskPRj75M7aaaV7YubUN6sgyExNpju
	 Is9165Oy7wuE4bgo8qydT3L0pHeU+QfNYbCVeDZdvxViNgw7qsNvxkRex66Yjs1Mdn
	 BoR/WWkNWPrAf7cRnmOVtgt2Cd1yamTqbZ80oZa2bSVHoGCJGGSBO7LFs5OAO6/4RJ
	 hrrFsFhzWAA8Q==
Date: Tue, 24 Sep 2024 07:56:48 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-net v1] i40e: Fix macvlan leak by synchronizing
 access to mac_filter_hash
Message-ID: <20240924065648.GA4029621@kernel.org>
References: <20240923091219.3040651-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923091219.3040651-1-aleksandr.loktionov@intel.com>

On Mon, Sep 23, 2024 at 11:12:19AM +0200, Aleksandr Loktionov wrote:
> This patch addresses a macvlan leak issue in the i40e driver caused by
> concurrent access to vsi->mac_filter_hash. The leak occurs when multiple
> threads attempt to modify the mac_filter_hash simultaneously, leading to
> inconsistent state and potential memory leaks.
> 
> To fix this, we now wrap the calls to i40e_del_mac_filter() and zeroing
> vf->default_lan_addr.addr with spin_lock/unlock_bh(&vsi->mac_filter_hash_lock),
> ensuring atomic operations and preventing concurrent access.
> 
> Additionally, we add lockdep_assert_held(&vsi->mac_filter_hash_lock) in
> i40e_add_mac_filter() to help catch similar issues in the future.
> 
> Reproduction steps:
> 1. Spawn VFs and configure port vlan on them.
> 2. Trigger concurrent macvlan operations (e.g., adding and deleting
> 	portvlan and/or mac filters).
> 3. Observe the potential memory leak and inconsistent state in the
> 	mac_filter_hash.
> 
> This synchronization ensures the integrity of the mac_filter_hash and prevents
> the described leak.
> 
> Fixes: fed0d9f13266 ("i40e: Fix VF's MAC Address change on VM")
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks Aleksandr,

I see that:

1) All calls to i40e_add_mac_filter() and all other calls
   to i40e_del_mac_filter() are already protected by
   vsi->mac_filter_hash_lock.

2) i40e_del_mac_filter() already asserts that
   vsi->mac_filter_hash_lock is held.

So this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

