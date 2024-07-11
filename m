Return-Path: <netdev+bounces-110754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0692E2B5
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC321C214C2
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3CB12EBF3;
	Thu, 11 Jul 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR0alzbS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3B78283;
	Thu, 11 Jul 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687741; cv=none; b=jQTVVpUqZ23WSSiVsitVA2aqmj82AQTxnPyOgzQCGejybvb0kC3JfZ/Xgk9uIj34mIzXAaxLTUuGgj7XE9df4VRU+oXCAbV8TJAFIjcwTCCM7lqs4JCfXJFG4qPnwx5V5UiWNQp0Qh1vXAt7I+qsSC/AsUaO10ajNwoxGAYSNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687741; c=relaxed/simple;
	bh=KvSh6XeA52JyOMfHv09Hn8dqnlUTpUE6bi2Cxcgc3ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKekRMXM3SIGztfhJOuk7+2RFnR/aT+Wzpuv3pm+qZZU1gqsW4W5oOsdoJISqv5C3YoU6ifEo5FnPTR+cWy04K/ZOnPNKl1wdfmFBzz+sLGzGj76Mg4jjjHzacALaO9QEIFxzoW83nRpv9JN3GIecrBmegsMBApbnvBpTdhA+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR0alzbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78717C116B1;
	Thu, 11 Jul 2024 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720687741;
	bh=KvSh6XeA52JyOMfHv09Hn8dqnlUTpUE6bi2Cxcgc3ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fR0alzbSMLlG8PEUDZzG2UHxWzI1XW8DEVXqg8wuYWbTmYJgOTfK3FLogTE/gLZuQ
	 QP6mzkZ8VHIIRsXcca6bekX7QPUBWeWSWe84TBbS0SOwHAFSu/T7OdI2w8R57Y/Pg7
	 1/OMdzHb18YgPUu7om/UqQX9AliwDgssniukFsjwTV0xVnjulCZcDJ8WnmKsuqYp2y
	 tLi/VzXIfgJBDxmJuxk7lOWB2Oe68ETEeD5wI3uXv7ba/4xtvgh3VLyPpNKsj1gI/a
	 YKNPGt1TwC0CDz2mUNKnmBfAvZAw+cZYHVdcwla7lc1+/nK6utb3Qu17L7Bw506F88
	 qi1iMdZ9wFgDw==
Date: Thu, 11 Jul 2024 09:48:56 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v4] ice: Adjust over allocation of memory in
 ice_sched_add_root_node() and ice_sched_add_node()
Message-ID: <20240711084856.GB8788@kernel.org>
References: <20240710123949.9265-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710123949.9265-1-amishin@t-argos.ru>

On Wed, Jul 10, 2024 at 03:39:49PM +0300, Aleksandr Mishin wrote:
> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
> devm_kcalloc() in order to allocate memory for array of pointers to
> 'ice_sched_node' structure. But incorrect types are used as sizeof()
> arguments in these calls (structures instead of pointers) which leads to
> over allocation of memory.
> 
> Adjust over allocation of memory by correcting types in devm_kcalloc()
> sizeof() arguments.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v4:
>   - Remove Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>   - Add Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>     (https://lore.kernel.org/all/6d8ac0cf-b954-4c12-8b5b-e172c850e529@intel.com/)
> v3: https://lore.kernel.org/all/20240708182736.8514-1-amishin@t-argos.ru/
>   - Update comment and use the correct entities as suggested by Przemek
> v2: https://lore.kernel.org/all/20240706140518.9214-1-amishin@t-argos.ru/
>   - Update comment, remove 'Fixes' tag and change the tree from 'net' to
>     'net-next' as suggested by Simon
>     (https://lore.kernel.org/all/20240706095258.GB1481495@kernel.org/)
> v1: https://lore.kernel.org/all/20240705163620.12429-1-amishin@t-argos.ru/

Thanks for your persistence, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

