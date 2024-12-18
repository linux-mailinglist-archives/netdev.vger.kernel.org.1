Return-Path: <netdev+bounces-153040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30A9F6A15
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B6B1885730
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0780A145B1D;
	Wed, 18 Dec 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rf1+9iR4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5613212A
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535984; cv=none; b=LpWzdMxY0J/GVckvlafoumfsU3CfsBsUw2uD9pijJrepxmWKgW9pT+rw9Y02+JkAdQEG5bhXunUnESxb2uXBRbLoCzqqhe6DOLB1vMj9DtOCXughK7PpI4gKp3T2peoRg+/7deVPP8tK43MvWdpdwf7p4ndBCE9u1VeNjUZ03fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535984; c=relaxed/simple;
	bh=M8Q7Kd0vWPb6CmsRnWPwh24MD2zZEYRUely4ukTddDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzO9+MNm1iiybWR5GBxlUtK4ldeuKKZA0rwWh+M7GzSOJ1DAQSFskqBrmO1tsEYf4jVj5dxmrWUXAO6/2eXY72Q1WFfZ66hS1tpAneZAf2Rdkmb1cLdarEKMSksxgyH9UhFzmKGh+pQk2R3sOVWE7z2X8eeqO9laF9ivsMdoGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rf1+9iR4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OKy41xsHlQtlJtlfLlxrl3P9OI30exCz1rxaH3/s0uI=; b=Rf1+9iR4mxFvk5nm7DP0qznSMh
	g/wHgbw3htvbIhmUsVUXXrRbO8h/qM9yCT+tQuIKFCH3OKIRu0MKfAjbr+TfM/NrDsM8/YK30gsS4
	L2ZcnD8W5iT4+mrCXqKMbASYRlOXn9GbP7X5gd/01YzjkCJ3QZut05k5OqzEe8ABL8RY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNw2V-001Jk2-VR; Wed, 18 Dec 2024 16:32:43 +0100
Date: Wed, 18 Dec 2024 16:32:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4] net: mdiobus: fix an OF node reference leak
Message-ID: <d9955c27-cfa0-4fbf-b0b3-8ab98467fc36@lunn.ch>
References: <20241218035106.1436405-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218035106.1436405-1-joe@pf.is.s.u-tokyo.ac.jp>

On Wed, Dec 18, 2024 at 12:51:06PM +0900, Joe Hattori wrote:
> fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
> but does not decrement the refcount of the obtained OF node. Add an
> of_node_put() call before returning from the function.
> 
> This bug was detected by an experimental static analysis tool that I am
> developing.
> 
> Fixes: bc1bee3b87ee ("net: mdiobus: Introduce fwnode_mdiobus_register_phy()")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

