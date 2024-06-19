Return-Path: <netdev+bounces-104689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DE90E0C3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AFB1F21AAF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FB139B;
	Wed, 19 Jun 2024 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkThREOy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE1136A
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756465; cv=none; b=C3B0eYvUCj5FWNRf5W/FpG+U4CzU+oXha1QusxJx1BidllapnLy/ggmParmGglcXD/aJfHX8g5Gb1M9oNohNMq+Flhau2Hm3fSq+ap2GiC1lsIEO1E8NDLmPodHI/ZaBLWa/5zeAGcMxBo803kUu2rrEtMJ8IXaRYflpZB/LUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756465; c=relaxed/simple;
	bh=mH2Z8pX2/Ptc5VUYyTzFLaWosVoZi+aNw/8gjY48EEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEv7IoSePaeyGxniVLklBUPT5nijMptCS/NsMBpvJ9+HtKxEdtfw+HhZIZyAUiWq1rb905IDTUZtLOSPUwhZ3ja8Ms8ZL2NAoJqH5iogW6cQAatcLzYGHT5lf12wJTBlrvbxDlMrMpSy+5gJlCYUV0YV5ntdg2dS1T6X3uZbsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkThREOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C119BC4AF1C;
	Wed, 19 Jun 2024 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718756465;
	bh=mH2Z8pX2/Ptc5VUYyTzFLaWosVoZi+aNw/8gjY48EEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LkThREOy4oU3h2cQgGvUznmahyAGg/BfKPk1b0vSZ+FGt6j/5m7DEBtxGYkVuZ+/X
	 8o1YU/kKAeHHAN17hPIMdUSOmbqDMjK+wtoWaQfhlfhk6gbcR7ruXe7dBGrgi/24Gv
	 MdyJIRYd/lNzFUuA8QplIasVkrmNfE8bldfMK0jq0T+2rbJWcmceqA4OjjM3iF3hbo
	 Sq6nR8iO7HFIMFF0b95p5/dsLT+vjli3FObyxD5PA0Cdu8xJs4Lg4JUlGTZlX3EyIO
	 7yyy0c8HGuMhJqWfyzYoGDYEymWASMj3EkrOHkgbrffmosybZ4sXbTq8uPDRe52ZDS
	 +yrUE+MUKKKnw==
Date: Tue, 18 Jun 2024 17:21:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.com,
 edumazet@google.com, pabeni@redhat.com, Edward Cree
 <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 sudheer.mogilappagari@intel.com, jdamato@fastly.com, mw@semihalf.com,
 linux@armlinux.org.uk, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, saeedm@nvidia.com,
 leon@kernel.org, jacob.e.keller@intel.com, andrew@lunn.ch,
 ahmed.zaki@intel.com
Subject: Re: [PATCH v5 net-next 1/7] net: move ethtool-related netdev state
 into its own struct
Message-ID: <20240618172103.312f1e24@kernel.org>
In-Reply-To: <5be9c248-8d63-4199-89ef-4cd9023604d7@davidwei.uk>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
	<03163fb4a362a6f72fc423d6ca7d4e2d62577bcf.1718750587.git.ecree.xilinx@gmail.com>
	<070a3de4-d502-45f9-913f-5392e0ebee45@davidwei.uk>
	<20240618164307.7138ce89@kernel.org>
	<5be9c248-8d63-4199-89ef-4cd9023604d7@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 16:45:56 -0700 David Wei wrote:
> >> dev->ethtool = NULL?  
> > 
> > defensive programming is sometimes permitted by not encouraged :)  
> 
> I've been here enough to know this bit!
> 
> But, kfree(foo) followed by foo = NULL is a common pattern I see in
> kernel code. free_netdev() does it a bit further down. Is this pattern
> deprecated, then?

I wouldn't say its deprecated. But I'd certainly let the author choose
not to do this, especially on a straightforward path like free_netdev()

