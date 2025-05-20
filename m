Return-Path: <netdev+bounces-191975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5D7ABE15D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60D51655FA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83626FA4B;
	Tue, 20 May 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INXqKr0i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39643257AFB
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760169; cv=none; b=o1FrjntkVEyPGj+EjYeW846aT9Sf9dd/n0hHSIyQwielv1pxCSIKHYyGZOh9aaEIB5V43liMIWYJQiLOsuzbWM4+cf6Mp1y4cYFdpfc1SY22nBVWjGbOzkIYpVAYF4mguli599Aoc3KrYmyjfqLYqYudiHBqbN8hMoz5eBbOZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760169; c=relaxed/simple;
	bh=5w1qLrApBS9fqgjzNsAWZqCOW8hEO4+6p2hf6u8zXx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpgv207aicS9eEP63JGzPfgWQgxa2NB0btnpF+valVSwlWu0y9GWa0/eX6aeg0AxPWWe7IqctiJ2Hsxt1l0OlU+bsoCuh1Qrh9lSr/f3qaOiJIUcSUZ1M9ZuT250NeMkBBj5MfODgZxtJzM5HCz8eLPhdLfACk9VGCxSYWDxY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INXqKr0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6DFC4CEE9;
	Tue, 20 May 2025 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760168;
	bh=5w1qLrApBS9fqgjzNsAWZqCOW8hEO4+6p2hf6u8zXx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INXqKr0i+opY3zmHyF/dm3zUMl0l56yuo+h5Cn2om1M7L7TjYJ9vw0UsklNJeoV6N
	 QlbmWhkaRCf0Opktw0McOBzQQbVIjClIWldyb05vgJs+ib+roN3O8UTnqHiVowT8CX
	 qkYds9MdpIt2zmJcB/MyCq2MnQ4/GTt1+8D+Yl90IQFD862j56J+3pKM04uIHdv+5D
	 lPpjnvPu16VgYpETN4kUXV9y2DS5EFYYRpApNjOSD7LApzCkma1sPRUbb+5Hgt7twW
	 vUkz1VtR3rtjdFJkx9Zg44wMtLQ8qhSEikXDm8FY8KLX4AJ86UxErITussREB/3OHH
	 VfsBocXuNnAjw==
Date: Tue, 20 May 2025 17:56:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 9/9] net: txgbe: Implement SRIOV for AML devices
Message-ID: <20250520165604.GF365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <CE302004991EAA2C+20250516093220.6044-10-jiawenwu@trustnetic.com>
 <20250519155833.GI365796@horms.kernel.org>
 <003c01dbc956$a2d65ed0$e8831c70$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003c01dbc956$a2d65ed0$e8831c70$@trustnetic.com>

On Tue, May 20, 2025 at 03:13:07PM +0800, Jiawen Wu wrote:
> On Mon, May 19, 2025 11:59 PM, Simon Horman wrote:
> > On Fri, May 16, 2025 at 05:32:20PM +0800, Jiawen Wu wrote:
> > > Support to bring VFs link up for AML 25G/10G devices.
> > 
> > Hi Jiawen,
> > 
> > I think this warrants a bit more explanation: what is required for
> > these devices; and perhaps how that differs from other devices.
> 
> For the chip design, the PHY/PCS attached AML 25G/10G devices is
> different from SP devices (wx_mac_sp). And the read/write of I2C and
> PHY/PCS are controlled by firmware, which is described in patch(4/9).
> So the different PHYLINK mode is added for AML devices.
> And for this patch, the SRIOV related function is added since the functions
> .mac_link_up and .mac_link_down are changed.

Thanks.

Just to clarify my previous email: I meant that it would be nice
to include a bit more information in the commit message.

...

