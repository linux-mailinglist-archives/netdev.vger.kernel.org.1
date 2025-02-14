Return-Path: <netdev+bounces-166393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31367A35DFC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E8C1890C9A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3242264613;
	Fri, 14 Feb 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oh+rWHFF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DAD24291F
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537767; cv=none; b=hM/0morg1/ogIppkXwmi50QZ1VGMtVq8/rBmJ6EWCpBuX2SsKIGRmFPSfnSez9D2bfca70xLzAUNJ2RoWqG1m/xbAWQEXdTrPFcuOb2Svg9Qi04C0vaBElAEiDnefcoesrYTB0ROzbWc/MzrdVayVNclhxDSCDcNnvXGFh69u0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537767; c=relaxed/simple;
	bh=ojwpUwUMjiHFVlNSSpVEmHK5c+oUMwCP47ryH5F0B2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PW0YCE7ngUpCR99r895eg39ygoNWOWdBMUD8d+oM4KmZJpulT4xqFDoNp2o3BdD++tJD6VoRBXiJC+GD9Bs3LUBk3Le6xBFUAlOK+adKXF1lLuXFrd/VY+kmypGPQ295MByHWhrWdrL2ZdgjSYRvqZ/BXoQG8AzNoebf4nGtIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oh+rWHFF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n9k4uW8l5W7e8oOK/XQ0vmxtMr81+tb0T7YV8IoBSmk=; b=oh+rWHFFiGIiBdHKcyEym+pEMO
	lCsiWbjJS5VFO1Paq4IEfG+AxCWXq9c60Mtkha8utCSQHYiGfWHNPLIXkXxB1gU8NXM8Ec6WFda6z
	nyU/EuzO/Vux3aBSkp+bkmlBQtXfiOn6JILrlouzb7R0Ua9pFful2cmx8DHIiV0LZ8lk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tivEa-00E4Ej-VU; Fri, 14 Feb 2025 13:55:56 +0100
Date: Fri, 14 Feb 2025 13:55:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, suhui@nfschina.com, horms@kernel.org,
	sdf@fomichev.me, jdamato@fastly.com, brett.creeley@amd.com,
	przemyslaw.kitszel@intel.com, colin.i.king@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next V2] eth: fbnic: Add ethtool support for IRQ
 coalescing
Message-ID: <bd76941d-a6fa-483d-8f91-a5d699b6b945@lunn.ch>
References: <20250214035037.650291-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214035037.650291-1-mohsin.bashr@gmail.com>

On Thu, Feb 13, 2025 at 07:50:37PM -0800, Mohsin Bashir wrote:
> Add ethtool support to configure the IRQ coalescing behavior. Support
> separate timers for Rx and Tx for time based coalescing. For frame based
> configuration, currently we only support the Rx side.
> 
> The hardware allows configuration of descriptor count instead of frame
> count requiring conversion between the two. We assume 2 descriptors
> per frame, one for the metadata and one for the data segment.
> 
> When rx-frames are not configured, we set the RX descriptor count to
> half the ring size as a fail safe.
> 
> Default configuration:
> ethtool -c eth0 | grep -E "rx-usecs:|tx-usecs:|rx-frames:"
> rx-usecs:       30
> rx-frames:      0
> tx-usecs:       35
> 
> IRQ rate test:
> With single iperf flow we monitor IRQ rate while changing the tx-usesc and
> rx-usecs to high and low values.
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 150 tx-usecs 150
> irq/sec   13k
> irq/sec   14k
> irq/sec   14k
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 10 tx-usecs 10
> irq/sec  27k
> irq/sec  28k
> irq/sec  28k
> 
> Validating the use of extack:
> ethtool -C eth0 rx-frames 16384
> netlink error: fbnic: rx_frames is above device max
> netlink error: Invalid argument

Nice, thanks.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

