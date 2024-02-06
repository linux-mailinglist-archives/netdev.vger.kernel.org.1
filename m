Return-Path: <netdev+bounces-69375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D5484AE85
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 07:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019021F23835
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 06:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40AD128805;
	Tue,  6 Feb 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CjaqtdCu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8283CC8
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202564; cv=none; b=qQ6tw0I3niNOCbdeoxFF/DuYDKUOKoEpQjK3Mlnc9DmNQ4WCqJLMl2S9RGtkc3HTRe5HTawHqZGgVGFqWzrd6EpZm8NKIfxf7D2YA19niTB39ZrMYhB0QZYT8eZp7VEkFH4Wi4mXvYRwV7Qa8GT4SM+OdThaXsNsHKhwxoeg+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202564; c=relaxed/simple;
	bh=HXFjnqulQjDb0Wn97BGgu/HkAEsXQ2x/8BSVww/23+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtdP6ulNTmGfNJ7jRAT8a6iUIS/yjyPiLCpUN/TJJCQiv+CYSsDHIrXnBP2kLx70f+l2BImHY1gZK9blJvBnVgZHAJuf4zNTCaHWubtz9OqowiYva+ecnPxBmUu2lFH5Rb0ulyl9YcTLTq16NVzuwqrDEKTSoArOY41E7Fik+hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CjaqtdCu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707202561; x=1738738561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HXFjnqulQjDb0Wn97BGgu/HkAEsXQ2x/8BSVww/23+g=;
  b=CjaqtdCuz9m4VKFlkzu1kONEL/JUfkqR0JWKZFrFF4fFaNU6Pvm++YV4
   UfAl1XZaYxSAcP4j9qtcdgmbgxrgwE++d2DYJgL1vCyCqrs6y03HjayOi
   Pu7d/aNNcd7lACp61u8R+Qj9rA8GRf3ckDbyaDCUq6CQXfEAkQF89fMzY
   1bvHtSsLehmzXG7+AlgusQikRsfJ8EQHO1mlj9I2B4VG92bf+Gp/NW8fO
   wqovWeUSLQBMo5HwzlViYlhoCSrUVj9JEmLP325TAbCjRJNnzcRHDXkQ8
   BPnMzx6tH+7I52coGqjVauUwEHGol6aCLqjDV5b8488M1eFVntXfp4P8t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="823360"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="823360"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 22:56:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="1272388"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 22:55:59 -0800
Date: Tue, 6 Feb 2024 07:55:49 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next 01/13] bnxt_en: Use firmware provided maximum
 filter counts.
Message-ID: <ZcHX3dSlTQEpjPsh@mev-dev>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
 <20240205223202.25341-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205223202.25341-2-michael.chan@broadcom.com>

On Mon, Feb 05, 2024 at 02:31:50PM -0800, Michael Chan wrote:
> While individual filter structures are allocated as needed, there is an
> array to keep track of the software filter IDs that we allocate ahead
> of time.  Rather than relying on a fixed maximum filter count to
> allocate this array, get the maximum from the firmware when available.
> 
> Move these filter related maximum counts queried from the firmware to the
> bnxt_hw_resc struct.  If the firmware is not providing these maximum
> counts, fall back to the hard-coded constant.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 26 ++++++++++++-------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 13 +++++-----
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +--
>  3 files changed, 26 insertions(+), 17 deletions(-)
> 

[...]
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks,
Michal

