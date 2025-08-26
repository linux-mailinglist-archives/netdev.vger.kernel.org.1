Return-Path: <netdev+bounces-217011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7973FB37088
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8136C4600EF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD213164D3;
	Tue, 26 Aug 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8/kVg+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F253164B9
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226154; cv=none; b=I1KdOMf+XUhmxPw181d5OkGDFod+TmWVu74LQlCl8JjiXWG69fdt0e2dhPVGE1dSmLxYAPv+Xk4XZhJWBDDw5OaRC3Wp6IlY6/kU8BIeyPoBC3YoofzaRW6/SVHNtPX0bUJBaUzpN/0bKVBI34lahtdymEoAsVPLRgNcISD6JUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226154; c=relaxed/simple;
	bh=BZBDOJvV73+BhoP7SobMXwQs7BVx+ppjYMAdXcPOIws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBFmrH+b/HnT9B0dfv74ykm6VLytRDxe5b+cA86UvlmpcyZIOfKBp7psA8Rz5kxqovg253PtEhtNXke7YwJ5bVbp2Kd/rXU53u+alyVlJaSMfwpfScYVVvz+VSLgR0r5NbGH/B563SFhKGC5QIp7tOQY4EXWpFAXi4CXoJb0anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8/kVg+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE65FC4CEF1;
	Tue, 26 Aug 2025 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226153;
	bh=BZBDOJvV73+BhoP7SobMXwQs7BVx+ppjYMAdXcPOIws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8/kVg+lK6tR95nPwCMXd0w7l6/njP6JOsiKcUPmJKtPwblqk9Xt23m/4Fcha1wUX
	 Xh/DuLe4rls49TlOekNQywk0fZPTDSalj6DRHGCzjdwfDTsmswpAxITv9LaCG4C781
	 uRxm6WOf/63+f61ZRGdXKWDltq8uW8R0tzDQX56zRNQxM2tbIk8MNHqScipMuO1HZJ
	 AX5UW3n5PUAxpwAnbQFidtY4WCwjKsArqHkVsyog/sZdRV1akNXw4HwJLY0xsuBwqe
	 +9zxML2BFcwKYyjtx4zH7RLosT4YAK0oTx08zVHCQXCT6cy1XPUy/DvuackfR8Eryy
	 xvUMS7+EaESig==
Date: Tue, 26 Aug 2025 17:35:49 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 4/8] i40e: fix input validation logic for
 action_meta
Message-ID: <20250826163549.GI5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-5-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-5-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:14PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Fix condition to check 'greater or equal' to prevent OOB dereference.
> 
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


