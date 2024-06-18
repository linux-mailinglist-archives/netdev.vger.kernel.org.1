Return-Path: <netdev+bounces-104683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD690E029
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E374C284A35
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D5C16D4DF;
	Tue, 18 Jun 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFd+THN2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07BF13D625
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754581; cv=none; b=jA8yNi8BGk3aAdbarYu0jX16dGPTjwaNPFxBNGHkDOkrvrsPyA+M0PqdTOcIlLFc0EZtF1FWS1N3CF2263+F42nFfcbd3WBJ5CEgk+Vp2bhkPVvUa8+9bBz53O+PpMTQWI4I3VOuxFl2kubvxCCwqUUdTXRn1lDYEC6MTIF7zpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754581; c=relaxed/simple;
	bh=O2Hxg8acFLcKfXUk/RJsC/ExjhobBdI1sjYTSkp0q8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jfmd/qTPmyxumrTJfX5p72jxdyPk7vqDFOX+gjnHwY2Hcms8ekNFxieW1ki70L1omGK6XGdoE6rRtAsH9keZadaoJ4c9ZeT2eDhFKXbG/XNPOnVzKXHNWP2MYL/P/CTFgYDsunqwy9f4nohq9JIonG03lslWtAzxtFetew9bEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFd+THN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F64AC3277B;
	Tue, 18 Jun 2024 23:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718754581;
	bh=O2Hxg8acFLcKfXUk/RJsC/ExjhobBdI1sjYTSkp0q8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFd+THN2WfXWN6OVUUxw0hARXR1YcZLm0X8ZjrcIJoka96yi14Y+s7ihq2W5yESC2
	 13YaSchJDHKSbJDX6WLxkrN5lXH+2YACpcZyK/AsapTdkv5yZ6qbSNvCZBI72fN8cP
	 8QF+CGOPY4W1vWVRCRgfMtMZviG0X0WWOK5iQB9alKvK4Seif30nH7V9Eh22nRAhNq
	 yELOkfCAFpuvG21MGH+Dz2H+vsbFmShDsGp5mZMdrkNFHlEKmnpMQ5NRo4Qpb6GDQl
	 AVpjlxfTIDUnmd1adrOsReNWSrLP8kcb4aKoOptB5mY4HsNulUBcGaRXJLG/sev6Gq
	 lNxXV26xLJiUg==
Date: Tue, 18 Jun 2024 16:49:39 -0700
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
Message-ID: <20240618164939.0a0e5f4b@kernel.org>
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
> +		xa_erase(&dev->ethtool->rss_ctx, context);
> +		if (dev->ethtool_ops->cap_rss_ctx_supported)
> +			dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
> +		else /* can't happen */
> +			pr_warn_once("No callback to remove RSS context from %s\n",
> +				     netdev_name(dev));

nit: I'd be tempted to call dev->ethtool_ops->set_rxfh()
     unconditionally. Is there a legit scenario where context 
     may exist but there's no set_rxfh callback?

If you prefer to keep the check - netdev_warn_once() ?

