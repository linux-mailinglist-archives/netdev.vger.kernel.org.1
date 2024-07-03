Return-Path: <netdev+bounces-108991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A205392671F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD17B23AA4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0C185084;
	Wed,  3 Jul 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jycsofBD"
X-Original-To: netdev@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680A18509C
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027808; cv=none; b=tW3co4J426vuJBD9hbLkTtEJN2ZRHQ3iTnwzlNPgO1Rs6K/pciOGhy8w44rdSzF5LvMO4LTMwX/IrV66287HZwLtBSv+uMX9lScAiY4n1JFrujmYg9Kdj9cbP8nrKRsRePk+A3AhTR7+PbH896H5+tQm5nYHwF016pUWs9S3vQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027808; c=relaxed/simple;
	bh=YO3367eKOVzqEhBWJKXgHLNJ1r7xt2165TS6ION24Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QymGHsUjTuKIF3Ct1aL6D0Bu3zrtqt9lVZPT2jNzAnOZGdI9NklcnBMtRZRiKqXcR6XQwT4EnK9R8pmiWXArzpuOBG2Q+4JByOw8g2wlcffXdgIgQWOYdoUHe5zvpFAUN2rDoOaxo7MBPSi8TSBI8k0rU0jxV8l1EWeeiB3Ug0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jycsofBD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 397AF1380276;
	Wed,  3 Jul 2024 13:30:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Jul 2024 13:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720027806; x=1720114206; bh=td4dDg/6UnYgOCuM1DPNBiuDdm6Y
	Rw6GR33x5SJ8mDM=; b=jycsofBDlofkQQkmMAGxxC0enCVNODAxzOW5kGE4ENfG
	8lXCY9LSqDRautm/6hrF0Gq1GnwYQFjPjXQIPWDr/SAQI/bygIRJoe414+zFCzXv
	kbUFygkc8Ojqd9XJE1mPoOH20yXicfZFegtJigsRuyghniMFh1HKWWo+nhtU6YlK
	zuNZQdkngWQqgs3uG/kZfi2KPVS2Nta2YBFgIhezHe4RlVD81exOMumrto3JSBWF
	UWoav3k+J9ltfsLcQN/WpaPbK8q1a8xrSSUm4+xZEPy2U2XrhQfbFrj49Trr1kZw
	29LQ1VWpUgHkFIb5Siz52Ue0Mt43Kt8Zozp9tSp1lw==
X-ME-Sender: <xms:nYqFZgQzaB2IxzFyURMx4NF3C2BaWkYa9QKtEfWNlBkbMXF7-AAq3g>
    <xme:nYqFZtxs2epw-hAJiQISEO_QsJ_XYuhAqfcO2LPjuj8343OS4KL_hWttJ5lgdIX0J
    C4_7MUYlSfoupw>
X-ME-Received: <xmr:nYqFZt1ZkXBvjp-YwrWcIw2mNYxTHzo5U5IHgJkI3vv7wzpYZR_uLNIF8wHj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgf
    duieefudeifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:nYqFZkA9P0e7z5UePYUts5vvKksXkq9XLAMMm0PCoJ_cnC4RhVwVZA>
    <xmx:nYqFZphYOFo6oRdSM3tWx5SE0npyE9Li3COE1lLs6u14cpIwXuGCBA>
    <xmx:nYqFZgrlnAY1-UXYMydyEhNVvPXmJYckMrqxzM6b8Q6BVULjJ2GLBg>
    <xmx:nYqFZsgSagpAcqkJohDILF6IkrlK6-3iIeku2MPCGWpuiaLWHzUXWQ>
    <xmx:noqFZqVzbod6PiV-AUzy_eoosNYirPrYQH46JiS3NTVTgHSp8T45yQ6K>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 13:30:05 -0400 (EDT)
Date: Wed, 3 Jul 2024 20:29:57 +0300
From: Ido Schimmel <idosch@idosch.org>
To: edward.cree@amd.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, danieller@nvidia.com, andrew@lunn.ch
Subject: Re: [PATCH net-next] ethtool: move firmware flashing flag to struct
 ethtool_netdev_state
Message-ID: <ZoWKjQO9qHxFTcn3@shredder.mtl.com>
References: <20240703121849.652893-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703121849.652893-1-edward.cree@amd.com>

On Wed, Jul 03, 2024 at 01:18:49PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Commit 31e0aa99dc02 ("ethtool: Veto some operations during firmware flashing process")
>  added a flag module_fw_flash_in_progress to struct net_device.  As
>  this is ethtool related state, move it to the recently created
>  struct ethtool_netdev_state, accessed via the 'ethtool' member of
>  struct net_device.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

