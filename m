Return-Path: <netdev+bounces-143172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245019C1559
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06211F2510A
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5A1C3F04;
	Fri,  8 Nov 2024 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dklhIjZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4F13CF82
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039269; cv=none; b=S6PF6c+Ud5LNEUBRttfAs3Vxd2CRz48X+ufuAnmBagZsyY8uxnhn1EqfuAm46kypzsCfX4fFwWYtxjfx9Cqm34zLWr7pZ35svCFWa22AjbmwUVZYPIHoZtDMPetlcHeO0rop9D2U5DI/LJO6MJL8kvXGP3XHFdEF1OWA4ITHfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039269; c=relaxed/simple;
	bh=96IN5uqddKY9UvAerK19LcK2DRnxzIU5dFlCO2q86y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNTJrSuP4bZyk3ghH3SBpvP1qaz4IY3kVt8B62Nwpn0/Md6sbNhnRCTZynb4Gltlv5cKFb4EvPTdZkQRujspqE4zYtk9cSKoeAxqxoagSW7AoJkE7AJ/+qOLSGNl7NVFeQmMOs746/ru0xXmMuE9qS9jdqNjdBpMmnd69pN3yRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dklhIjZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C6C4CECE;
	Fri,  8 Nov 2024 04:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731039268;
	bh=96IN5uqddKY9UvAerK19LcK2DRnxzIU5dFlCO2q86y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dklhIjZpRncJVN/qFFj3Q0PCIEMslYnbZia93W7Y5mL59x/iEGZLn/Vh0AVOa+Yrf
	 6iHdBQrBUYzGoSQrS13Et1cfYBk5+1er8H1OrW6q/L7cXYVAERQrdbmVGeSZqp3/JM
	 IVrq9bFMT1XT5F4HZhKtEzt4f8lI2C2LQi5idBOTO/ZRTBzvZwEKAIJ4j5LYX63Lb0
	 PkyuuCbxyqdUDg+wc0PeKvOmOJ1QUmoj01ARjJY9pOoMRUiV1KA8OGYELPHTO2fDYl
	 7epAELcLwwM9zzt5YdEwd8aWhxboIMYv2XZlB+1PygcdS54+xUoqmpKwdyJh7ZWmvD
	 +4coGgKBJ26bg==
Date: Thu, 7 Nov 2024 20:14:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, Alice Michael <alice.michael@intel.com>, Eric
 Joyner <eric.joyner@intel.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 01/15] ice: Add E830 checksum offload support
Message-ID: <20241107201427.28e00918@kernel.org>
In-Reply-To: <7aad3452-a08c-4c28-9bd9-3fa1cd1f9b39@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
	<20241105222351.3320587-2-anthony.l.nguyen@intel.com>
	<20241106180839.6df5c40e@kernel.org>
	<7aad3452-a08c-4c28-9bd9-3fa1cd1f9b39@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 17:37:41 -0800 Greenwalt, Paul wrote:
> > why dropping what the user requested with a warning and not just return
> > an error from ice_set_features()?  
> 
> I took this approach of reducing the feature set to resolve the device
> NETIF_F_HW_CSUM and NETIF_F_ALL_TSO feature limitation, which seemed
> consistent with the guidance in the netdev-features documentation.

My understanding of that guidance is that it is for "positive"
dependencies. Feature A requires feature B, so if feature B is
cleared so should the feature A. Here we have a feature conflict.

