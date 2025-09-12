Return-Path: <netdev+bounces-222470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFAB54664
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 407DB4E03F3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0A271443;
	Fri, 12 Sep 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBsWW6Lm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA322F74A
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667811; cv=none; b=NeB+aagqmFFrEwN3J+pTGeTrzsT45OuXIKKnPtyLCL5crpvlHtuEseprNbdleqg8QkFfaUGt14qPTZkjWm9NpEC10Ldk1IH8C7XcEIODKxX42MmAGoCSxW2usZX8VKwKzOZbEMP9nfVK3hJ5iNESG+rRxvcasIWY0On4TCOCwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667811; c=relaxed/simple;
	bh=Attib9RBEVEQ2BkPR2RH+anwU3Q3CI237poc2cq7Fs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3nuQxyc46X48GhNu/cHWynplLBo4mheDTXswhAMJtKrfWfYdO3/7QWLxR91bwd5QKVrv6c6EHSDtKIp+9pvMQuDQooBqopWtbyslAFz5pF5myl+IhyCY0y+U5IxcNuzXTbs8ZCh+EM0uePwbJmn45JuXGjI5oTiAw4Cgv/NWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBsWW6Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939BCC4CEF1;
	Fri, 12 Sep 2025 09:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667811;
	bh=Attib9RBEVEQ2BkPR2RH+anwU3Q3CI237poc2cq7Fs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBsWW6LmN/Fy43GhLo5gNxUaZu3u5OzBmT/yGi/HVdoCMO72vgGeh8iEhPoHfJ8MS
	 gZ+tLJT4j8phljtO4ne9mL191Heo1RD/dnQXUXLsIg1Y9JvUMo/Ecd0JPUfQPFQJ5h
	 LUg35jx52Y54q4yB6miMQiVlwW8+Nk3425PXZzWE+HOc9xVUNa6lTkd3k3huo6nQoT
	 Ic3rf7L6S9Q7UCqSqvdu+VE9MbWY0zGZMoIPvFRXg9Afi3rd8Xf23KiV9eiZYr1+Au
	 W0cOYuyOwbHGpPdEVWYelCA8zkbUvsJJkv62NHgLVheBNlPnKTeSHx1pRqmP3vhzhX
	 ni74bbfM1DVIA==
Date: Fri, 12 Sep 2025 10:03:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, mschmidt@redhat.com,
	Dan Nowlin <dan.nowlin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v4 3/5] ice: improve TCAM priority handling for
 RSS profiles
Message-ID: <20250912090327.GW30363@horms.kernel.org>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
 <20250829101809.1022945-4-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101809.1022945-4-aleksandr.loktionov@intel.com>

On Fri, Aug 29, 2025 at 10:18:06AM +0000, Aleksandr Loktionov wrote:
> Enhance TCAM priority logic to avoid conflicts between RSS profiles
> with overlapping PTGs and attributes.
> 
> Track used PTG and attribute combinations.
> Ensure higher-priority profiles override lower ones.
> Add helper for setting TCAM flags and masks.
> 
> Ensure RSS rule consistency and prevent unintended matches.
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


