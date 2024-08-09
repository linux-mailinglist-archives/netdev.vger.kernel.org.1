Return-Path: <netdev+bounces-117278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA694D6C4
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E071C21C8E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA72C18C;
	Fri,  9 Aug 2024 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1GxE/Lv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09F624;
	Fri,  9 Aug 2024 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230089; cv=none; b=Vbl9ZHB4r0Poqj/Ot4ytGQy0YHH/+1eq+AhrbUO5MdSlyhhBwhChSYwFr1Hq0jnBikP0wqBue0HQZ1H6mhE+JsmDyuNaz7xFweQvORgAmcID3pkTyIi4atgO05eW9k1usazyfXftQn+ONi75NBWPwxRGApl2o9jYFp4OFW/7k0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230089; c=relaxed/simple;
	bh=ZLJsm1HFlTxuiPShZr4R4A26koLmfxhwfvdmvafiIqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=REtHGrka4G7SAhX4tOtTDJt7vu1rm3CFtGRQDEj3sr97akJCXe/Yv9KR8jFS1qb4HtkcfyjsraZ7+nxYgfR467cZY6JhHRO1B/e3q11H5No2Tt9wE9fvvLpFdj4oFSCV30XoLcb+8nu4AVyVCK97Q67Oyl44QxyHcpYertth7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1GxE/Lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE459C32782;
	Fri,  9 Aug 2024 19:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723230089;
	bh=ZLJsm1HFlTxuiPShZr4R4A26koLmfxhwfvdmvafiIqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t1GxE/Lv2tzSNQ+iy143aiponLOW1vIazmIBJe4p8umjdyfANs5Kv84Q4uxQvC84y
	 dVaioklo/IF110c+w93ZLz7wTjge4h5kcVTVdRkHEB/cf/qmDLebKs6VxxCWLLm/XV
	 bWb4laAidtcCnPQ7UjHq6xAMyGVktjPjnLFs8CeWlrgR8sEAYMdqOAW4HaVgLxaA2D
	 L/7IlbrWsFZ4h1x5ynUg4oubnMYetE9oA1l0CjZkQqr/uDqKeKn+DDnxgg9V32lYOe
	 cQ1bCNs0lo+F+wmGsd8CX4lTZNl+2TNolTVCPI1MwEo6S0bcLXl0JLYbGGB+cBV/fh
	 HB61PtKoZoUHQ==
Date: Fri, 9 Aug 2024 14:01:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
	corbet@lwn.net, linux-mediatek@lists.infradead.org,
	danielwinkler@google.com, korneld@google.com
Subject: Re: [net-next v2] net: wwan: t7xx: PCIe reset rescan
Message-ID: <20240809190127.GA206091@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809033701.4414-1-jinjian.song@fibocom.com>

On Fri, Aug 09, 2024 at 11:37:01AM +0800, Jinjian Song wrote:
> WWAN device is programmed to boot in normal mode or fastboot mode,
> when triggering a device reset through ACPI call or fastboot switch
> command.Maintain state machine synchronization and reprobe logic
> after a device reset.
> 
> Suggestion from Bjorn:
> Link: https://lore.kernel.org/all/20230127133034.GA1364550@bhelgaas/
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

I'm glad you managed to do this without all the magic workqueue and
remove and rescan of the device.  Thanks for working on that!

Bjorn

