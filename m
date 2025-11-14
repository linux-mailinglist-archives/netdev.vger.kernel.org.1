Return-Path: <netdev+bounces-238641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DACC5C7FA
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 11:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6664359155
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E843530ACF9;
	Fri, 14 Nov 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAH3EZ89"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE78D13A258;
	Fri, 14 Nov 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114984; cv=none; b=hszrwmqrvyRjo3Dj9xIEpe6KyVyF4oanuCGyipdeRomrHP6KbNEIEnzqLuD/1dxTVhV+v7cDCHkaWMaw+64cwQcxaR74xDkJTcrWHckHJzGBrbNxybvNoe2NvLXIM9ucTqLR1oC/tnCyaE8WbQFm39VRMLvLayrUMxAEzoJqhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114984; c=relaxed/simple;
	bh=3FPisBOj9ak9xPE4SRE6FfLYTzBMXBsTCrX3XBItwsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnXVDGa8b/cejoe1pfyRLKDbS+rbxW54Vnh60GQIRKJoH2CKCQrBNLZ7xqbbdlB8xqbhQ8VSnRfPKOC3nwKNhtBc9W87mW1rNEassJQTjXlxJhuIULjJEdn132dIoTVSrsn/hkBK9aJxkbhv7xO9y8kth6Hv4FAKF/biVb3eyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAH3EZ89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0E2C4CEF8;
	Fri, 14 Nov 2025 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763114984;
	bh=3FPisBOj9ak9xPE4SRE6FfLYTzBMXBsTCrX3XBItwsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAH3EZ89a4elLYpbNHW8qvo2f6IxnT+9vSDLnBIzISDEtTbgFR6RfLxV/HqIwtjrJ
	 0b1wt4Gezo3lqYZgOJcHiWo1ow/pVPe+xx5r9Uo1XNuhJOf4wVObbRJodU4j7FeJd9
	 q6uXtcaDGCEMoHazQ8enQKc2//ot+OApLd2z5n/BLVoAinejtYeALxPEFjdhcrCnbO
	 K5pd7GmCAbYPH+PfMNW4q1mgdcIh5YZzbyGa2PgevNCYwZECQsajWcl1gBOICKeLZQ
	 aNH63QF0rClbWlrfFDyKdwM6Fr7JGpShEwEVFygr78BGU0B6PaJGyjtfP1leUudVd4
	 Hx9qeKgz8COCQ==
Date: Fri, 14 Nov 2025 10:09:39 +0000
From: Simon Horman <horms@kernel.org>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com, boon.khai.ng@altera.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: stmmac: Fix VLAN 0 deletion in
 vlan_del_hw_rx_fltr()
Message-ID: <aRb_42Er4k9tMGZO@horms.kernel.org>
References: <20251111093000.58094-1-ovidiu.panait.rb@renesas.com>
 <20251111093000.58094-2-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111093000.58094-2-ovidiu.panait.rb@renesas.com>

On Tue, Nov 11, 2025 at 09:29:59AM +0000, Ovidiu Panait wrote:
> When the "rx-vlan-filter" feature is enabled on a network device, the 8021q
> module automatically adds a VLAN 0 hardware filter when the device is
> brought administratively up.
> 
> For stmmac, this causes vlan_add_hw_rx_fltr() to create a new entry for
> VID 0 in the mac_device_info->vlan_filter array, in the following format:
> 
>     VLAN_TAG_DATA_ETV | VLAN_TAG_DATA_VEN | vid
> 
> Here, VLAN_TAG_DATA_VEN indicates that the hardware filter is enabled for
> that VID.
> 
> However, on the delete path, vlan_del_hw_rx_fltr() searches the vlan_filter
> array by VID only, without verifying whether a VLAN entry is enabled. As a
> result, when the 8021q module attempts to remove VLAN 0, the function may
> mistakenly match a zero-initialized slot rather than the actual VLAN 0
> entry, causing incorrect deletions and leaving stale entries in the
> hardware table.
> 
> Fix this by verifying that the VLAN entry's enable bit (VLAN_TAG_DATA_VEN)
> is set before matching and deleting by VID. This ensures only active VLAN
> entries are removed and avoids leaving stale entries in the VLAN filter
> table, particularly for VLAN ID 0.
> 
> Fixes: ed64639bc1e08 ("net: stmmac: Add support for VLAN Rx filtering")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Simon Horman <horms@kernel.org>


