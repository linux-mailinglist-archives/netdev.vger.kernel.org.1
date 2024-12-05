Return-Path: <netdev+bounces-149460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE5C9E5B88
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE101635A3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0FB21D589;
	Thu,  5 Dec 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxiowLmv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CA1DD87C;
	Thu,  5 Dec 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416501; cv=none; b=OQ25EgCFWxpibx9URhhq7/T+7Hu7+oS9Z7K0MJyKFpYiFi7ZcUHp3XkDJSKRjPPGXtuTD4AePj+1emWmO1PaUbrSGGtH4NKiEWX0YHdSNTCxK53dXK7b1XDl4qv9hX3OKpM743h2k8Dp8o1/UrkpyLic6xOQgjSP+Q/JSaEG8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416501; c=relaxed/simple;
	bh=LkDpp24EoiR1aaZseVHVH5cOld710oeNG3SsznlyDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+USzetN5rvx3elZMVH1mz/R6I8d/yzRDmXgSMZL2wv3YKpVqWlNMtDgoIEQriqBx56zu+SmhZGcglr+XRH/t3X4VxlKuk8YJ0tG9EaCbUBciOO3m3p4efQR8fYq0D9+KLTTohFed3pH3Ww0CsSHsou9ArVWYU4a/w382H5plgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxiowLmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AEAC4CED1;
	Thu,  5 Dec 2024 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733416501;
	bh=LkDpp24EoiR1aaZseVHVH5cOld710oeNG3SsznlyDe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxiowLmv4WHmU6hQTOxS+kbaE3DMEPuPd3YB6mjoAZHUb6JMIdypYx9bmODcxOVQ0
	 ZI3VLZBHJpsdPK/j7Py8X6nI9HhPel0UmVy1dVsrDzR1pETOr/WvEfUY2LL3s8VFj/
	 WuyF2V4KktszFMjRJGsw6Jg0Orx5DlrpTG8avTJNnrKxRedUbGGdNUM1+3WxdNXHPT
	 I1I/T52MRhTurbduGnmIys4Bfcr4mintTbWKpU/iC7gmFxRq3UgVgIFg8kamkrWhJ4
	 7qMYvbOXsvpOJZiXPwbLtQsPtP9/XjqTmKPuHgTzpVfXbEhE6XGbEmrh+M2oFezs6P
	 IHuE47eYHMGkQ==
Date: Thu, 5 Dec 2024 16:34:55 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hkelam@marvell.com
Subject: Re: [PATCH V4 RESEND net-next 4/7] net: hibmcge: Add register dump
 supported in this module
Message-ID: <20241205163455.GD2581@kernel.org>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
 <20241203150131.3139399-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203150131.3139399-5-shaojijie@huawei.com>

On Tue, Dec 03, 2024 at 11:01:28PM +0800, Jijie Shao wrote:
> The dump register is an effective way to analyze problems.
> 
> To ensure code flexibility, each register contains the type,
> offset, and value information. The ethtool does the pretty print
> based on these information.
> 
> The driver can dynamically add or delete registers that need to be dumped
> in the future because information such as type and offset is contained.
> ethtool always can do pretty print.
> 
> With the ethtool of a specific version,
> the following effects are achieved:
> [root@localhost sjj]# ./ethtool -d enp131s0f1
> [SPEC] VALID                    [0x0000]: 0x00000001
> [SPEC] EVENT_REQ                [0x0004]: 0x00000000
> [SPEC] MAC_ID                   [0x0008]: 0x00000002
> [SPEC] PHY_ADDR                 [0x000c]: 0x00000002
> [SPEC] MAC_ADDR_L               [0x0010]: 0x00000808
> [SPEC] MAC_ADDR_H               [0x0014]: 0x08080802
> [SPEC] UC_MAX_NUM               [0x0018]: 0x00000004
> [SPEC] MAX_MTU                  [0x0028]: 0x00000fc2
> [SPEC] MIN_MTU                  [0x002c]: 0x00000100
> [SPEC] TX_FIFO_NUM              [0x0030]: 0x00000040
> [SPEC] RX_FIFO_NUM              [0x0034]: 0x0000007f
> [SPEC] VLAN_LAYERS              [0x0038]: 0x00000002
> [MDIO] COMMAND_REG              [0x0000]: 0x0000185f
> [MDIO] ADDR_REG                 [0x0004]: 0x00000000
> [MDIO] WDATA_REG                [0x0008]: 0x0000a000
> [MDIO] RDATA_REG                [0x000c]: 0x00000000
> [MDIO] STA_REG                  [0x0010]: 0x00000000
> [GMAC] DUPLEX_TYPE              [0x0008]: 0x00000001
> [GMAC] FD_FC_TYPE               [0x000c]: 0x00008808
> [GMAC] FC_TX_TIMER              [0x001c]: 0x000000ff
> [GMAC] FD_FC_ADDR_LOW           [0x0020]: 0xc2000001
> [GMAC] FD_FC_ADDR_HIGH          [0x0024]: 0x00000180
> [GMAC] MAX_FRM_SIZE             [0x003c]: 0x000005f6
> [GMAC] PORT_MODE                [0x0040]: 0x00000002
> [GMAC] PORT_EN                  [0x0044]: 0x00000006
> ...
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


