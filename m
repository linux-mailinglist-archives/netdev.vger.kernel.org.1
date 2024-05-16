Return-Path: <netdev+bounces-96745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2E8C78C5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE901F23D02
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858C14B969;
	Thu, 16 May 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qcki+jjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BCA147C77
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871393; cv=none; b=ASYOMGne8s7W4fCwFiFQ/5/x15kwdIJrtRv3Emt55HvPiM7Hxx+C/i84W4r6CsPP8jN4zg1x18Ns0U7U++Sj4pJ2t1tAPkmO9Z9GwFOFiXsp1DTnDg6MRTmLS0CisZmapkRIZJjuTlP7IfKa36Wajz/BE4ysyzZPmXtM5b7hK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871393; c=relaxed/simple;
	bh=hNwPUyQjZvET7OmyaBDgHpM/Hk6AuC0PtC9EuI6NIqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B84baKkRQR8xXQ2u0avmSlZSIhB6DF4xdI6+AI5etazoU+Y/11NcL6GdxsIWxE1khH43y9urZTdHuctyytNEq8JsvhgaRrMdofs1P8KIhuu9lLcHtPp9IUfAW8skstAjHlVQyj5QoldZSQRnCw8+sJVyXYsU2hLWWXXlLefsYd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qcki+jjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D32C113CC;
	Thu, 16 May 2024 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715871390;
	bh=hNwPUyQjZvET7OmyaBDgHpM/Hk6AuC0PtC9EuI6NIqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qcki+jjoXb63ksOxKa2KPdWb0Uw1ciEZUAktEEIDYASxGH2mfiLBtDvWxAwLjzhlK
	 hy1vYhUJabSbBjbBygwHj/gxu2V+H1cLE82dytBLenbAfapjZylsRjHC6FOQNLT2mB
	 XMNC+qxrpeMQZ4lxuIDn8dB3dicQxTYKfBwKlmbw6u5wXbhglREUY/SoLLNo5MncBn
	 scg7zkYCes2hbaubcxE1NiSudiG6tQIlBMPUpFQBB8A1iXsyYBZnTAmlOXgMCftMJj
	 Jzs3IWDZgf9XagVaB5oUsHnfWjm68wNUv3q26IMO3pi9b9LZ0Ucy3TiVtxeNlrxJAr
	 X/Oi3CojtbqmA==
Date: Thu, 16 May 2024 15:56:27 +0100
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH iwl-net] ice: implement AQ download pkg retry
Message-ID: <20240516145627.GB443576@kernel.org>
References: <20240516140426.60439-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516140426.60439-1-wojciech.drewek@intel.com>

On Thu, May 16, 2024 at 04:04:26PM +0200, Wojciech Drewek wrote:
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
> to FW issue. Fix this by retrying five times before moving to
> Safe Mode.

Hi Wojciech,

As this is for iwl-net, and therefore net, please consider supplying a
Fixes tag.

Otherwise this looks good to me.

> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

...

