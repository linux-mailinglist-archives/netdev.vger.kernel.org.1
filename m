Return-Path: <netdev+bounces-241482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C3C846A8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87131348B93
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB0221FA0;
	Tue, 25 Nov 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMaI0LsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1021D5B0
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065846; cv=none; b=X8CaVCokXVJhLs5UrvJBTqIfs+YFU+pqZjiHaOwtgmZqySNq+Siax1GNrTLWAP1uMjgmp0/lRCe/TBEXSPzEvjmPHbbU7hQidwWE09pzbfrbeY33h4ENa92ytfLgSE9fRsd6j1DgIaSMfBeJtUah0ohpalqqMImeamvxUpYzDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065846; c=relaxed/simple;
	bh=+pMFBzeBiSSkVtD9D9tPh0ECAQKi6pgNAWor2JG1b7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PILdQBeLMEiGRAZWBFhvkqTjnioN5x4RshQUeWF/TkFINHvtPenxus5XkKDJmcWvznMkF4bWJ3pwKWfwKSPaBzlg1HIaVhzbXiMstH7bWQp1H0RBkaJve3rK6YdttL14pvfr0gO6PrimLCHnw19eIYuox0a2LPo1HM6gRcLBPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMaI0LsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D0EC4CEF1;
	Tue, 25 Nov 2025 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065846;
	bh=+pMFBzeBiSSkVtD9D9tPh0ECAQKi6pgNAWor2JG1b7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMaI0LsP8VYVwqG05WNDlXiOvlOCiBdZNATIR58JnkLibQeySZIoncLEaaCZlhTZo
	 z7LcmSGUdaHN1GsESvJPZkSB28jdK4rbfSFTBEIWh4dc1N0FbNUp73O+c/B6GcAiJ2
	 IbnSDbBJgfmAr6z4qghKHnsOxQ/RPv1b6Cg+bOyFFWXUGIQ0WmtyaEe3bzmk97b0wk
	 d+8Mo57oSJHOV1j/w+moFJtv7G3nC/XlJ0Gb0JzxtBgZ3iTv9KfGMAw5WYMO9Mw2fc
	 mN6gz8xKuncKq7yhzm1L8IeY9V2uDyx/GrBQPNhICzCz02UdV5m/7UEIU+QsnQk260
	 pPQ65X8v5xY9g==
Date: Tue, 25 Nov 2025 10:17:22 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 4/6] ice: use u64_stats API to access
 pkts/bytes in dim sample
Message-ID: <aSWCMsWk7eZoSR9e@horms.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-4-6e8b0cea75cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-4-6e8b0cea75cc@intel.com>

On Thu, Nov 20, 2025 at 12:20:44PM -0800, Jacob Keller wrote:
> The __ice_update_sample and __ice_get_ethtool_stats functions directly
> accesses the pkts and bytes counters from the ring stats. A following
> change is going to update the fields to be u64_stats_t type, and will need
> to be accessed appropriately. This will ensure that the accesses do not
> cause load/store tearing.
> 
> Add helper functions similar to the ones used for updating the stats
> values, and use them. This ensures use of the syncp pointer on 32-bit
> architectures. Once the fields are updated to u64_stats_t, it will then
> properly avoid tears on all architectures.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

This seems like a nice clean up to me.  And I think it makes sense in the
context of where this patch set is going.

Reviewed-by: Simon Horman <horms@kernel.org>

