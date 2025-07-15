Return-Path: <netdev+bounces-207213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CAB06440
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02BC162E4F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDE1E3762;
	Tue, 15 Jul 2025 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OXgz+WsU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A62A1B2
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596605; cv=none; b=rCTqQ0hrIpqo6xk4CZTjl+KCCfL+FV0wgeff2Rh+lDcOcpKH5w1iKFXGo29pfhiwakCKGIruPdHcXTj0YBWPkzaygaS460GnPK7mPD2sdcm1kvjM2BBSr1t/Qn15EnEilCMjONxNYvE79vwTPcJ7d3R1PEQAjnu6fC/ltepPu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596605; c=relaxed/simple;
	bh=m83F+j/Z5W0MxlkC71y0FEgkjM+Lr50R1GiqCXn/Ou0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSioWPJNY2406WluNOniR0zNObPqNJIB9KN0ITgX1Xhz6wYuG90LZjFU0xcApTKtasU0ZHNBAINTOPBSLR+bSBg1lGoEBz7voAmkOTyGOgdDlx1u6JRUaFmMgC3h4l8u71SG6CUS84DoTdgyyVWglicY7QtqXN7P5139uaIuabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OXgz+WsU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6N5ixXzYqAsxEa59PwExtdaf3MvivnU2rrVqhDnhb4w=; b=OXgz+WsUaq4+gRqOqnKuH/Wbz6
	Bo6LBXtPMDToszQi/KI8NR7ZMQ4OTfo3Vm1SCrfjsWvYq4NBR2VFHyAtTqQh7bPqEROAU078VBAd7
	fi88CgzqGT4k3QZLNXgDabf6+liSQKfoXytvH8++pUiX8gj+FDaWzsMMcp5yGbap+OEo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubiQx-001bi0-BD; Tue, 15 Jul 2025 18:23:11 +0200
Date: Tue, 15 Jul 2025 18:23:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sayantan.nandy@airoha.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: airoha: fix potential use-after-free in
 airoha_npu_get()
Message-ID: <230d2600-bd9b-4144-81c5-b79dcbb42b46@lunn.ch>
References: <20250715143102.3458286-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715143102.3458286-1-alok.a.tiwari@oracle.com>

On Tue, Jul 15, 2025 at 07:30:58AM -0700, Alok Tiwari wrote:
> np->name was being used after calling of_node_put(np), which
> releases the node and can lead to a use-after-free bug.
> Previously, of_node_put(np) was called unconditionally after
> of_find_device_by_node(np), which could result in a use-after-free if
> pdev is NULL.
> 
> This patch moves of_node_put(np) after the error check to ensure
> the node is only released after both the error and success cases
> are handled appropriately, preventing potential resource issues.
> 
> Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

