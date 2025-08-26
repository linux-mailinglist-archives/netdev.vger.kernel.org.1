Return-Path: <netdev+bounces-217009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A2B3707D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67893367F8D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30EE2C3261;
	Tue, 26 Aug 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtHV1G9R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7221CC61
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226120; cv=none; b=IxnHZ0PqIxQoS7DGohN6k1UFXCUNs22lzei9Xz/h9L6l57QyWp6gYt1SvKjYmoe5vAHd6/RJaXNaFsyqNDcBSncEtuxDePoNEDpuuOMfmXSpG/ntfx4TI3cwR6xzIBteEZBP3fDbZ1KO657GIgdDrK1mIOIbZQl4RqzdVcLHKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226120; c=relaxed/simple;
	bh=RXy/P3BFDKjMwYnAAb7VzfDCQdF7X+LWTJB5skhvPpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYJjWy+KkERe38SD4BqPe//+GJNYDCPYd3s4Jd/gh+VC0p9xPlIJ7zpSSftUWOjIiaqFIfricP+c237pyR5blaJW6afFzcMfOl3EoFlhFwS18RxaDbhg3/b5UAGNvfc89Y4KpSABTpVXbzDtrdND9eEY/Q2mawgRxaAmj6sSjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtHV1G9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AD4C4CEF1;
	Tue, 26 Aug 2025 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226120;
	bh=RXy/P3BFDKjMwYnAAb7VzfDCQdF7X+LWTJB5skhvPpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtHV1G9RjJI6b60CjhPL8k59MCnuEviwIschbIFbTppRHxbdW21w44rjQ541sRZIr
	 y++oTeasmmRktsYZBH068JVqQibAaZeecJ/lGT+cuWU7Z7yUdIPG91RzKcPqzZ3e94
	 MovkXjON9mTVuGpGaGeQ8OdwZ3Pcy24Pg7t7sGcyJiD0Y/W9dFsO3IVM8TnY/Pch6I
	 uuYInEA81aSL9V5wSJjQXEMSl/EGG4/J9PgTYoVTug9XNOJ0jjpwnLgH0FmlDSgtRh
	 KD4r/jzIuei2ugkLQbFuDFPROSyQzauBwoB9kpbouytfOMRnhJJwaHtz/SXbReOLZO
	 1mTlDuQ7DYzCw==
Date: Tue, 26 Aug 2025 17:35:16 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 2/8] i40e: fix idx validation in
 i40e_validate_queue_map
Message-ID: <20250826163516.GG5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-3-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-3-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:12PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Ensure idx is within range of active/initialized TCs when iterating over
> vf->ch[idx] in i40e_validate_queue_map().
> 
> Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


