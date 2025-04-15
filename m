Return-Path: <netdev+bounces-182996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947DA8A85D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FB31889C22
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262702206B2;
	Tue, 15 Apr 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0REqlYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02291140E5F
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746408; cv=none; b=itmtvw7r04NVmzklnorQsvaeujn1iYUkyY4G7TB7+vWQNtFHXNb+HsDLi28C1CQuHV0sZjDp1YJigHcUaob2sN9ow0yhQzcGgUuEEbUOl8P6rJH076cuyj5on2b8TnR83sUYrkm3sir8kO2zxhPmkaX+Lf1endeVv/u1Wu7K5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746408; c=relaxed/simple;
	bh=Lehm73pFOv1XPw6aNSbvciO5SUYCc++FebrjAsZmbgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gopunUJK5CByQbiYZaf1RdwdYEWOthqAH9yINIEpsxHNTwS5QhLTxJRHGDVirA/QZVCjX63PTXoE33YZKBUn1Dqwn4VfjbsFfXL6DUCMxza/BA34txwgOa9n2bhIPY9YCqMwpat/evXpqSwjPAS22AmHbN3YRN2h65p82422VGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0REqlYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EFAC4CEE7;
	Tue, 15 Apr 2025 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744746407;
	bh=Lehm73pFOv1XPw6aNSbvciO5SUYCc++FebrjAsZmbgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0REqlYLPqmDBuCvzojlLQA7o2kllp4dWQcXkMlA3Omr171j/D1LlZGIFCjCNDwws
	 izVDF07qNNR6eCtksuVPYOBQlGTCrNt7Jf8Sds4Ct4+yawqfT5pEhDaQQWca4DnqN4
	 I5haM9kxGzxcJSPzkQDgakt1dmsC4gPPzIdXrPgHthsCZdARsJG2y/aVuQcUNi+3V6
	 Bl79QH3Q8/jShegTO2NNyWSi1WqXu/u/4KJ7VGiq4Qj7c9v7Ydyrff4/LMhtUsgCuH
	 uVyBJoQkOq8zAOJ4YdaYldDYMi2vl7BdYUPA6npfttdz274Nfppj9BA3uag8C7QLTV
	 4ySVAhLl+2OUg==
Date: Tue, 15 Apr 2025 20:46:42 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net v4] ice: use DSN instead of PCI BDF for
 ice_adapter index
Message-ID: <20250415194642.GH395307@horms.kernel.org>
References: <20250414131241.122855-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414131241.122855-1-przemyslaw.kitszel@intel.com>

On Mon, Apr 14, 2025 at 03:12:41PM +0200, Przemek Kitszel wrote:
> Use Device Serial Number instead of PCI bus/device/function for
> the index of struct ice_adapter.
> 
> Functions on the same physical device should point to the very same
> ice_adapter instance, but with two PFs, when at least one of them is
> PCI-e passed-through to a VM, it is no longer the case - PFs will get
> seemingly random PCI BDF values, and thus indices, what finally leds to
> each of them being on their own instance of ice_adapter. That causes them
> to don't attempt any synchronization of the PTP HW clock usage, or any
> other future resources.
> 
> DSN works nicely in place of the index, as it is "immutable" in terms of
> virtualization.
> 
> Fixes: 0e2bddf9e5f9 ("ice: add ice_adapter for shared data across PFs on the same NIC")
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> CC: Karol Kolacinski <karol.kolacinski@intel.com>
> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
> CC: Michal Schmidt <mschmidt@redhat.com>
> CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> CC: Michal Kubiak <michal.kubiak@intel.com>
> CC: Simon Horman <horms@kernel.org>
> 
> v4:
>  - Add fixes tag for real... (Simon)
>  - extend commit message (Simon)
>  - pass dsn to ice_adapter_new() to have simpler code
>    (I happened to do that as (local) followup) (me)

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


