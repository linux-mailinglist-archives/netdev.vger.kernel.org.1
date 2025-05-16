Return-Path: <netdev+bounces-191084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2716ABA021
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949251BA5AFD
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1D1B87EB;
	Fri, 16 May 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T42LItu/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E37D07D;
	Fri, 16 May 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410202; cv=none; b=PeO+2Fkff7z0/cQ095xW4DpqnDE4Z4aYi4LyJb3sMic+7yROo7dhTRpp4FNU7gsDdHnFCbX8cOHT+gLlO5cWg46/A7L4BQuf18e0PPhE+r8nsWQQJGxLGkJo1BYG9JFVOoDMxYzKNXh9iddsBjfHTnewbQLicpXS01f/Py+z5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410202; c=relaxed/simple;
	bh=JX6JzbUHGsSlhtbCchsrt85j6DDVCcgzO9j3GrNG8PM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdC5MKidjUu7kWj3foLIOJFxMb071FbgdRxlAk9DJAt74wUkeNeTUhrrpA+nf5+9GoJMcxO6VBvjyrRBYYQT5WtbElq6WwIlyrZQ29bwzeUbjyv/Hwp9pIL0xht9Zox9d40lg92W7rqB9mS6iOfu3eZzp3HS9vTQX+plU2hO6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T42LItu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B69C4CEF0;
	Fri, 16 May 2025 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747410202;
	bh=JX6JzbUHGsSlhtbCchsrt85j6DDVCcgzO9j3GrNG8PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T42LItu/hK1i86e2aCIt+WEP4NJzf4EQ8lDPZyKYgO3dkrEMLM78MUkRcCoDKnnzC
	 /9WjEBYk989deDxl0d8r877edJv0c3Mlkbxpjtte66iq6UIR67890PwDSSXIA5Pjau
	 znqMjRHhNDgUHyu2cbOk0o7+9H2GIGfRa4+6aHt+OaCjN5eURvrkHxoaP1QYy/GvAk
	 eCy0T4bLBfr2cnlrV+wKiqXJNc+xxwsXAapB0qtnmOgWkB9W/dqwYyj+UPNydatxXP
	 sFz63Dg8wJ/9moBgA1cZdZVZZQms6APs9jDtbZubuCTKKT6tGWITa1WiV88T1+5FBY
	 fx5M4fHy8MM8g==
Date: Fri, 16 May 2025 08:43:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 corbet@lwn.net, danielwinkler@google.com, davem@davemloft.net,
 edumazet@google.com, haijun.liu@mediatek.com, helgaas@kernel.org,
 horms@kernel.org, johannes@sipsolutions.net, korneld@google.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 loic.poulain@linaro.org, m.chetan.kumar@linux.intel.com,
 matthias.bgg@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 rafael.wang@fibocom.com, ricardo.martinez@linux.intel.com,
 ryazanov.s.a@gmail.com
Subject: Re: [net-next v1] net: wwan: t7xx: Parameterize data plane RX BAT
 and FAG count
Message-ID: <20250516084320.66998caf@kernel.org>
In-Reply-To: <20250515180858.2568d930@kernel.org>
References: <20250514104728.10869-1-jinjian.song@fibocom.com>
	<20250515180858.2568d930@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 11:46:57 +0800 Jinjian Song wrote:
> >Module parameters are discouraged, they are pretty poor as an API since
> >they apply to all devices in the system. Can you describe what "frg"
> >and "bat" are ? One of the existing APIs likely covers them.
> >Please also describe the scope (are they per netdev or some sort of
> >device level params)?  
> 
> MTK t7xx data plane hardware use BAT (Buffer Address Table) and FRG (Fragment) BAT
> to describle and manager RX buffer, these buffers will apply for a fixed size after
> the driver probe, and accompany the life cycle of the driver.
> 
> On some platforms, especially those that use swiotlb to manager buffers, without
> changing the buffer pool provided by swiotlb, it's needed to adjust the buffers
> used by the driver to meet the requirements.
> So parameterize these buffers applicable to the MTK t7xx driver to facilitate
> different platforms to work with different configurations. 

Have you looked at
https://docs.kernel.org/networking/ethtool-netlink.html#rings-set 
?

