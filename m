Return-Path: <netdev+bounces-209125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BCB0E696
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F4F6C6758
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E9288C30;
	Tue, 22 Jul 2025 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOXVQGI5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D162877F2
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224089; cv=none; b=jrs4wgW6YRmtKYZqNA5sth28Q1frzmhmutyENJr3MxTqJwn0eT57ElB9VD+tRd3dlPnjQKPyHHlxhmNwi9Vdo5WwBVaSI1jfyAVF8btYKbOE0Bry73cRw1hpySSmtmIFcedrZ7IRIAfUUd+BAM6Jv9bR/zK/clpaXUSkFjE+GCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224089; c=relaxed/simple;
	bh=LKbzslX13d+yyOW/czAYIqCnBd5xBDogbtiL0Za0tgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhdE1npxbwiWd9Q9Lw9sKLcdk8mLp6FiPAmq8qeO1mSRjGbzj7ONC+8jo63HXBkghrk+una2GYZriMv0lVmrugzVZq6uXw3yr3eR0ohRCJXD0XGX86ah3T7S6AHkYD8ZumJ4vhZRANfkJb0a8qBjoabGN54S3XzjTzAogMqpwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOXVQGI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8FFC4CEEB;
	Tue, 22 Jul 2025 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753224088;
	bh=LKbzslX13d+yyOW/czAYIqCnBd5xBDogbtiL0Za0tgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VOXVQGI58EVLj4vv/qPUD29mQP+GRgGKI0IaWtPfjXWGEFhtk5DaxqzUIyz9VV6c/
	 kkSbzIFac2kaKt3kyUgSZYaaIt9CWvZ6Hpt/HhFzaP16PqGn7CW9diO72C94jKtbJL
	 BQVG0RGQZQdl+AxyEx+BSZjunlnrhNtD6C+/P2LiigI63RBj/dhQ088iYE5Nc/MWRW
	 KdVpx2QOhj4/27TJ0DT2LN7aL1IWLOeiLT37QByhyTbZKz3UmZKhH2S6m+JNxZHJch
	 L4faLp/rlWZkxc3z441BlL66jV5umfv/znXd24qq4ak6hBxhEANd8S1NV53lYxzttD
	 eBJjob3VWmVVQ==
Date: Tue, 22 Jul 2025 15:41:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/3] net: Use netif_set_threaded_hint
 instead of netif_set_threaded in drivers
Message-ID: <20250722154127.2880a12e@kernel.org>
In-Reply-To: <CANn89i++XK3BFzk4t4bvKeZtqXT-FUCaY_5SkSTOeV0AGNDdZg@mail.gmail.com>
References: <20250722030727.1033487-1-skhawaja@google.com>
	<20250722030727.1033487-2-skhawaja@google.com>
	<CANn89i++XK3BFzk4t4bvKeZtqXT-FUCaY_5SkSTOeV0AGNDdZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 01:21:58 -0700 Eric Dumazet wrote:
> > diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> > index 3a9ad4a9c1cb..ee7d07c86dcf 100644
> > --- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> > +++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> > @@ -2688,7 +2688,7 @@ static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >         adapter->mii.mdio_write = atl1c_mdio_write;
> >         adapter->mii.phy_id_mask = 0x1f;
> >         adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
> > -       netif_set_threaded(netdev, true);
> > +       netif_set_threaded_hint(netdev);  
> 
> I have not seen a cover letter for this series ?
> 
> netif_set_threaded_hint() name seems a bit strange, it seems drivers
> intent is to enable threaded mode ?
> 
> netif_threaded_enable() might be a better name.

Cover letter or at least a link to where this was suggested would indeed
be useful. I may have suggested the name, and if so the thinking was
that the API is for the driver to "recommend" that we default to
threaded NAPI, likely because the device is IRQ-challenged.
But no strong feelings if you prefer netif_set_threaded_enabled().

Since this is a driver-facing API a kdoc may be useful:

/**
 * netif_set_threaded_hint() - default to using threaded NAPIs
 * @dev: net_device instance
 *
 * Default NAPI instances of the device to run in threaded mode.
 * This may be useful for devices where multiple NAPI instances
 * get scheduled by a single interrupt. Threaded NAPI allows moving
 * the NAPI processing to cores other than the core where IRQ is mapped.
 *
 * This function should be called before @dev is registered.
 */

Since this is just a hint the function should be void. No caller cares
about the return value anyway.

BTW I think we should delete the debugfs file for threaded config
from mt76. debugfs is not uAPI, presumably.

