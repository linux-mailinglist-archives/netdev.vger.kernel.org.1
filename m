Return-Path: <netdev+bounces-104897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7084190F08A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB9BB24902
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE6E1DFCF;
	Wed, 19 Jun 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ02ILO0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE71DA5E
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807434; cv=none; b=DO4X2Ml7WzvIL9iBabE1K5XAub5ib3tRtkb+KInwLorNRz4awdh6A7ZlyZj9VVdNHXalT+nDvlV8WAT2Lq05N2foVNkwiTVQ7TvaOip5jDT7WQ1+4PobZpTaN7bhvIc8jq9ed4Z/eCJbNwhMRqRd7pSBTfpM4AbNBPPNRzfdtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807434; c=relaxed/simple;
	bh=4dqXYcOHSyQBTfURchRvwWiv67TP6KVjD0fVQgcZbQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2ZZ5hSVb9xpY9fYedNiTWuXLA/RXIhdsBUZwkYIVLEJvWmHvOIY6kiHPQtf7S6fZ888QW3iqtO/4xrQ8Gx7//wxgalSPjojfs8oGQYxI1NHCEJaPW1SRzAvAx13XD/zAzjysc5CG5GHuwq2GC80XYt74zfQs6DA07KLy2YmvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ02ILO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C6C2BBFC;
	Wed, 19 Jun 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807433;
	bh=4dqXYcOHSyQBTfURchRvwWiv67TP6KVjD0fVQgcZbQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQ02ILO03uKOgy9aVnhLtAkIP96UYJD2zcM06j0jppyZGBtaa/VIX+iA6DV8G3ezw
	 u1lYTQcl0fOgxoFIpdQGDTvhoRR2iaZ7173OwmNIDM52EUegsewXpCEd7y20PgzEhs
	 53mB1nrIrcrC3FRulYlsQ5KqzhEzT6XI6JTum2t9Rs4FgJBdPBesIhI4S6lTkeyrba
	 yH48GtuXG60aL4wVp8OwVDc+gEY+WCWlUP2HFyHq9bSMj2oYT+NjDofnD8Rhku2U8z
	 WCKKXEAVBkuV+93kgBN0baib4oPwQegIKqf3iC4vL5ziLgS8PJEDAn0ZwTEVebyW0a
	 tb7XSP7BM+xTg==
Date: Wed, 19 Jun 2024 07:30:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
 <jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
 <jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: Re: [PATCH v5 net-next 2/7] net: ethtool: attach an XArray of
 custom RSS contexts to a netdevice
Message-ID: <20240619073031.01314cbb@kernel.org>
In-Reply-To: <9976837c86b656c1f2bea7753362f4770530f49d.1718750587.git.ecree.xilinx@gmail.com>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
	<9976837c86b656c1f2bea7753362f4770530f49d.1718750587.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 23:44:22 +0100 edward.cree@amd.com wrote:
> + * @indir_no_change: indir was not specified at create time
> + * @key_no_change: hkey was not specified at create time

> +	u8 indir_configured:1;
> +	u8 key_configured:1;

looks like names in the kdoc also need to be updated

