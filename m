Return-Path: <netdev+bounces-217007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF696B37075
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C5E367467
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8B83164DB;
	Tue, 26 Aug 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFMfG8oF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DE031A567
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226064; cv=none; b=M2YCw7Todq9TP48LWqLfx0AShpiFf7y0bxxw+dh+0nMtyWnyTesnOxBjzIFeTx+930Q6x2SQMz8TL5cea6irsf+khmmlPHPlQpTjSHnoaYTaUs3FtgKbXf9YaI/bYgu6bBhpORTjxf+zQSRyS/1uoc1Jz1oGy23qxPUWY0ZGkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226064; c=relaxed/simple;
	bh=ofaBMDeT6+BelNyeq885K3p2YoYCdqxJeUKFv0Y2RTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVSCgx1lSTJfdmIgzqtjck+qCulmFgBhpdKR4FUuvJ79udxKU4N6a0s5WaUgFVITkDsuyNafGhJII2YRhgESdWL1wXslQqNLrAM7pVKjqOQEAebLrvyOV9ZslCL3aIc7aQKhdwJsu3eQ/24ZSOAjmIW/hot6JAlt0Q3c42tb2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFMfG8oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BA8C4CEF1;
	Tue, 26 Aug 2025 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226064;
	bh=ofaBMDeT6+BelNyeq885K3p2YoYCdqxJeUKFv0Y2RTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFMfG8oFkukUwW/3y/IEzWm1LWmf/+zMpJpBLzo5Zchn2yMfHXJ8T4jnzIkFdUIsF
	 uCy0VWrh7biuGY1QmggYKZ2sOWwK7dghN5O9r2ztghjTwEZQ2NSrxWHrzugEppWMmD
	 XA5tESiVVNKSXwKETbZtg+MNHQXRqoQq4plo9n+z12/W4NAYpQ1a1mlp0E/cMDyXy5
	 3GBkdmwwRYHlaJq+SUE+iqpCEGhbH8yDpWGFcm6glKFe6AUMiCUGzQuoPwuekCyR6L
	 PB46+QEZXAmj9rEaHdWXyyTetg4E0sTw+2BOf3pWG35QSTj3+xzOfOhrpKm6zHxPog
	 oJYmeDY37/RHQ==
Date: Tue, 26 Aug 2025 17:34:20 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 7/8] i40e: add mask to apply valid bits for
 itr_idx
Message-ID: <20250826163420.GE5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-8-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-8-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:17PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> The ITR index (itr_idx) is only 2 bits wide. When constructing the
> register value for QINT_RQCTL, all fields are ORed together. Without
> masking, higher bits from itr_idx may overwrite adjacent fields in the
> register.
> 
> Apply I40E_QINT_RQCTL_ITR_INDX_MASK to ensure only the intended bits are
> set.

I'm all for using FIELD_PREP.
But can this actually occur?

If not, it feels more like a clean-up.
Which could be more universally applied.
And targeted at net-next (without a Fixes tag).

> 
> Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

My question about the target-tree aside, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

