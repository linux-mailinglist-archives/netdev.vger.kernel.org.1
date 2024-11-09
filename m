Return-Path: <netdev+bounces-143548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5C59C2EFB
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EA91C20BD1
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070D19E96B;
	Sat,  9 Nov 2024 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qayYb0yW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471E145A16;
	Sat,  9 Nov 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174927; cv=none; b=bQdqLI4wU+bUJplSSlb+nMVrHeEQDv30mm8DENMxrksLc7W1kmbBtUwbAnHESN/lwyjcNc/ErNR4bzsrC+FSQIcNjaoEuFets8jNi8VU57fbe/nEUFHDiQSzAw72NS3QH3UIUD6Q+fGF+4r2Uam3xIjfxwWqUBQLmgxgjgzH9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174927; c=relaxed/simple;
	bh=LuDagnwcF8ruqHKajr1QrxaWxF10mYA5s/koSh5vnGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY4z9mzwm10N39srDLWZ7SIOV2FBsSOYo+fPeBglFzzWT27KnuNXgiix15wjobkelEU4MZgqqWH+dUxsqIbo61OMPHiVtlixbGyz8CVgnoHRCsLdp/Un15BVr84jKMGxl+0/wlzJMJAF+R2vFqB+b0RiB7OQg3tYoaVbiXteH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qayYb0yW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dg/Y91hWQ/01NudkE6mrKHpZpP+lmx16+sK++8d2Ag8=; b=qayYb0yWAetRsmPPBGarjADAbd
	hbmIFeqG7kAxZ7vGwgJOMzgLHn6C6HJV7d9aZJROxeLQs0R0YTPoST6IR8leHhE+2R3NAa2cnGSt1
	uJMr2kh9Fv8oERkUMiTX7QnTOwCKLGOvFP1k198QQuF+bxj8IObu+MxnJDvzS4gBX7TI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9pfv-00Civ9-PD; Sat, 09 Nov 2024 18:55:07 +0100
Date: Sat, 9 Nov 2024 18:55:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev,
	jdamato@fastly.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] eth: fbnic: Add PCIe hardware statistics
Message-ID: <addc1303-c485-41dd-b31c-531b334b1d82@lunn.ch>
References: <20241108204640.3165724-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108204640.3165724-1-sanman.p211993@gmail.com>

> +static void fbnic_hw_stat_rst64(struct fbnic_dev *fbd, u32 reg, s32 offset,
> +				struct fbnic_stat_counter *stat)
> +{
> +	/* Record initial counter values and compute deltas from there to ensure
> +	 * stats start at 0 after reboot/reset. This avoids exposing absolute
> +	 * hardware counter values to userspace.

Now you are in debugfs, this convention from ethtool -S no longer
applies. You could simply this code a lot by exposing the absolute
values.

	Andrew

