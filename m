Return-Path: <netdev+bounces-166047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D2A34155
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49AD16DCBF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B9214A69;
	Thu, 13 Feb 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3xqAZml8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF19241673
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455208; cv=none; b=pUyWclK+u4JRDFIyIJAvfvc6KtJeQSHDB8Jl0p+ZDyYDzXKchPEnlCr/Z9VY5o+M8REEov3PXfZ/nqUJ9Iv+euolSwKNuOY190MGpUNPoFVY8vF/UGkBmrHGDblfH0YouszZV1Rs2j8IVHKAUrICdOVGngd0TvfUO40TFyG8ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455208; c=relaxed/simple;
	bh=u5d4e860xYhOUFCbFll6zpAVTKFydiyG+nBOYnrT4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzW+tGCfTYBCsl9tx9rmG/vxEIwNR2FRecHF3dP1dZG7PmI7/e+/6SU3ROh6BVa8URIPYYX0yFcL5KaYJP3BeNQkVvCvD0MNPizf97AihCECJFZjpFbeVeAWluPIQXOPYG6r/IlRsVJc92Ys5Fkb1yUGAL+25yMdEuuvMDK+NPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3xqAZml8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iAkqaPrjGvvDOF/J0Di/U1TzDlQA7dlhYFHUtqlikkI=; b=3xqAZml8JXN46N68s7e/3HwMtk
	6Hq8ulO+K7Gm6cf0IUsm1A4MbG+BFPC9OD+VD3o+2yfK6ColkJXLJLcyai197nTSNUahnff6drAvb
	PAdiqY4fSa1zlVCmlb5w5JKU22+P/3yHR7n9fJ0jKg14QHZAhBQPNw8y7TfyIgKpZmMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiZl2-00Dkpu-5O; Thu, 13 Feb 2025 15:00:00 +0100
Date: Thu, 13 Feb 2025 15:00:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, suhui@nfschina.com, horms@kernel.org,
	sdf@fomichev.me, jdamato@fastly.com, brett.creeley@amd.com,
	przemyslaw.kitszel@intel.com, kernel-team@meta.com
Subject: Re: [PATCH net-next] eth: fbnic: Add ethtool support for IRQ
 coalescing
Message-ID: <089b8fb8-5eb7-455b-ab3d-5301f9058ea5@lunn.ch>
References: <20250212234946.2536116-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212234946.2536116-1-mohsin.bashr@gmail.com>

> +static int fbnic_set_coalesce(struct net_device *netdev,
> +			      struct ethtool_coalesce *ec,
> +			      struct kernel_ethtool_coalesce *kernel_coal,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +
> +	/* Verify against hardware limits */
> +	if (ec->rx_coalesce_usecs >
> +	    FIELD_MAX(FBNIC_INTR_CQ_REARM_RCQ_TIMEOUT) ||
> +	    ec->tx_coalesce_usecs >
> +	    FIELD_MAX(FBNIC_INTR_CQ_REARM_TCQ_TIMEOUT) ||
> +	    ec->rx_max_coalesced_frames * FBNIC_MIN_RXD_PER_FRAME >
> +	    FIELD_MAX(FBNIC_QUEUE_RIM_THRESHOLD_RCD_MASK))
> +		return -EINVAL;

You have an extack here, so you could give an indication which
parameter is out of range?

	Andrew

