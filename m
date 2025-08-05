Return-Path: <netdev+bounces-211664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1630B1B09E
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A24E117F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C102264A0;
	Tue,  5 Aug 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCrz7EAQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6B19E98C;
	Tue,  5 Aug 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384606; cv=none; b=uWH7j4kw9Tt6yfIyzKjM0v4lV/bip0+T2fTGrf23QM+QGPEDkTadljFrSoVmz2wJvHZt0+/iivD6SybiZwmm5zLKM1wfQZKTd0WFbFkpxbiOoetl/eElY+BySMqVrvZnGm1YbZ+FaW+CB0PccHHiPeNlE0oBIgclSs2sqDOEWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384606; c=relaxed/simple;
	bh=o6eMxZP2MsznNp/Xgv+R9U+BLt2fssslh+l+jlH1kNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKGo90EXVYpVMYfbTEpW77BUK7597oBGwfnEMLXb+O/ECHnXz7354knuCfFz9oxvH011lMz5Eao5+3UaCyBxiUWrE1s3ciFBI4YJeP/xG54oR1fcOKT3SRbwLTJZx62WpMulibm2nJrwTQPX8f+HytLnyqOYFfLVOGiJtJZ88t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCrz7EAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1F7C4CEF0;
	Tue,  5 Aug 2025 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754384606;
	bh=o6eMxZP2MsznNp/Xgv+R9U+BLt2fssslh+l+jlH1kNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCrz7EAQc+9yWJrwahwSd+o644aBLgJ4Dn7o3mecxhTzTM+dCSnj6WXJ0QOWE6ZZH
	 akYw9Kiij1WkIumWHMxWbx/atKX4cbXsWXPwhNLf6uG1yppZNxjYhvMvHmPASfsfK5
	 l3Dd350i0hB1FxbNU05qzPBCtWpA0aoYXXqvAQSnm5YVZ19Rj8b67H28FzjZ2Z7hJ6
	 CthiXokomxGuzWJo6veAAGI1E2ZcWNTncLkcKl9w4j9ZGSQOBeqTLH7gtX0Ytde0cx
	 mtmT5nlZOaCF+rVcUV1/DT0ECmmPwaTkeeeUL+i6K3mMmDYEO+tjlN4JVm/yKzkKpD
	 TGZX3FFIy4WOQ==
Date: Tue, 5 Aug 2025 10:03:20 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 1/3] net: hibmcge: fix rtnl deadlock issue
Message-ID: <20250805090320.GU8494@horms.kernel.org>
References: <20250802123226.3386231-1-shaojijie@huawei.com>
 <20250802123226.3386231-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802123226.3386231-2-shaojijie@huawei.com>

On Sat, Aug 02, 2025 at 08:32:24PM +0800, Jijie Shao wrote:
> Currently, the hibmcge netdev acquires the rtnl_lock in
> pci_error_handlers.reset_prepare() and releases it in
> pci_error_handlers.reset_done().
> 
> However, in the PCI framework:
> pci_reset_bus - __pci_reset_slot - pci_slot_save_and_disable_locked -
>  pci_dev_save_and_disable - err_handler->reset_prepare(dev);
> 
> In pci_slot_save_and_disable_locked():
> 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> 		if (!dev->slot || dev->slot!= slot)
> 			continue;
> 		pci_dev_save_and_disable(dev);
> 		if (dev->subordinate)
> 			pci_bus_save_and_disable_locked(dev->subordinate);
> 	}
> 
> This will iterate through all devices under the current bus and execute
> err_handler->reset_prepare(), causing two devices of the hibmcge driver
> to sequentially request the rtnl_lock, leading to a deadlock.
> 
> Since the driver now executes netif_device_detach()
> before the reset process, it will not concurrently with
> other netdev APIs, so there is no need to hold the rtnl_lock now.
> 
> Therefore, this patch removes the rtnl_lock during the reset process and
> adjusts the position of HBG_NIC_STATE_RESETTING to ensure
> that multiple resets are not executed concurrently.
> 
> Fixes: 3f5a61f6d504f ("net: hibmcge: Add reset supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - Fix a concurrency issue, suggested by Simon Horman
>   v1: https://lore.kernel.org/all/20250731134749.4090041-1-shaojijie@huawei.com/

Thanks for the update.

This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


