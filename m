Return-Path: <netdev+bounces-114607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A603943124
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9214284B02
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628C1B1519;
	Wed, 31 Jul 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp+f08jB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698A16C86F;
	Wed, 31 Jul 2024 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433274; cv=none; b=p9A/kWzJdVpVLbDZKI0QzJ4YAQjqlnWaf1Xyawgy9hLM93q67mSRIjYtW1RF9A1jpftotBA8IYrT3PTREAFt7IbSqQHrSJ10B/ByjIR+FyPa5H5eSh9ktdNDdUVAW1+p9RN3KCTeB+yOYQLpQlSUzZlm0I65GE3CyWuSf8Jnt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433274; c=relaxed/simple;
	bh=GccO9ruMcGXH/+lOhGMqHF37FBLyuNfwZ0zMFHVIwJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ie05EIzqWaafo+0QKnpI8ukKRyzJxt43gWcas7P9Of6BmlBuc0h09AeR0xapHilOrHVRynWZflJbrHPQXRcIu52moc7pRkPNsOONa5LC1g6mUwX/JihC7SYLZun/SOibWRKJMi6p4RJJEaZBTyJhuNdELwK5VHqokIPH+kYyKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp+f08jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEEFC116B1;
	Wed, 31 Jul 2024 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722433273;
	bh=GccO9ruMcGXH/+lOhGMqHF37FBLyuNfwZ0zMFHVIwJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vp+f08jBljVX9b0/aTwsRPfMNrSKMRkm73ZIAhrJ692PpzDi+Z3TXM2Jkycx8QHJb
	 rWp+ZhiyKrXcvcB1ocU8Tw4TPnRM5dJY8LxpCZn1zn+2zKFchsaWe3hxDDfGwa1ESE
	 ef2/qRb6PeaINtwtRbYFUuZ7BrzZAGJu8SLBf3kMt/eKXWPTiIaSSuFq9lDmSEh9Yf
	 j5gl42lxA2qNUh3czh3HhRK5gSY/Ha6UMziYOPvkge+9kZQPg/A5wH/mFnLsmLzKFQ
	 YLkkHdrS+SglrYhn8CKdoGCcbAyIWfSIBCp1kBHKbZGq+6MlpJolBX1DPsE9eanVJj
	 v4geCKM3u1mlA==
Date: Wed, 31 Jul 2024 06:41:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Youwan Wang <youwan@nfschina.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, Russell King
 <rmk+kernel@armlinux.org.uk>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [net-next,v4] net: phy: phy_device: fix PHY WOL enabled, PM
 failed to suspend
Message-ID: <20240731064112.040252ac@kernel.org>
In-Reply-To: <20240731091537.771391-1-youwan@nfschina.com>
References: <ZqdM1rwbmIED/0WC@shell.armlinux.org.uk>
	<20240731091537.771391-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 17:15:37 +0800 Youwan Wang wrote:
> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
> we cannot suspend the PHY. Although the WOL status has been
> checked in phy_suspend(), returning -EBUSY(-16) would cause
> the Power Management (PM) to fail to suspend. Since
> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
> timely error reporting is needed. Therefore, an additional
> check is performed here. If the PHY of the mido bus is enabled
> with WOL, we skip calling phy_suspend() to avoid PM failure.
> 
> From the following logs, it has been observed that the phydev->attached_dev
> is NULL, phydev is "stmmac-0:01", it not attached, but it will affect suspend
> and resume.The actually attached "stmmac-0:00" will not dpm_run_callback():
> mdio_bus_phy_suspend().

Are you just reposting this to add a review tag? You don't have to do
that. Please let me know if you're doing so based on some documentation,
if such documentation exists I'll go and update it..

Please include a changelog in the future.

And also please don't post new versions in-reply-to an existing thread.

