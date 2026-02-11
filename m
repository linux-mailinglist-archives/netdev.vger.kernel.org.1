Return-Path: <netdev+bounces-258303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOiiDO6jjGlhrwAAu9opvQ
	(envelope-from <netdev+bounces-258303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:44:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF4125CF1
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F5B5301BA76
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA730FC1D;
	Wed, 11 Feb 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jcYwGx75"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B823101A5
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824611; cv=none; b=g9AxgBPxv01JhYSlSXhqgFs3NGiKIq7ONLp/XY7hO5SdBdly8RWzqzsRbyv+oIZIxyDHzF9TYcgUXGoKHVnUsrbkAR4uvyMQsLnQ/aSumrxR3fP9oLaIru+dKOyqyoTz2UOOz0ne/1edF0gT9lg1c/rGGxb4k4SEmWHMpivVOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824611; c=relaxed/simple;
	bh=ntX7WrWXZAIr4Wfzxmr+JN+8j4Fs82nC+PIAlymZFEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM6bt1k0jylFzJAJrCa1AUf/PMCm8bvHWneT3WhBZmUro9UCLRswr/W1lshuU7GI3E5wWDQr5mwnwMasF+HZfNb4G1E2qLBCSX9ytlvMR680aBIT8lYgoWXF4nIOnEBC+xNK4+h0ZzlnAT+dyvBjj2cmpZTfGoZetG0yT16bj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jcYwGx75; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oBIPpuAaoQq6D5085ZHkt1BT2R78gZG5j75v8kaSZ3U=; b=jcYwGx75BsTIKsILFNdXS0mTwH
	p2WndMBVmDVSxJ3+UAFXsPc+qFOSFP7fMmawb4P05VUdeihNwo517sMhz+qthJvz+ud1YjOHGkAjk
	k7jbyw/9xMZ/kbeUgyS2c1+ja0SPhDW2bD8n7Jm8LDHuPR7D2KTZdZbny+eqh/eZ8g4I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vqCN2-0070WG-CO; Wed, 11 Feb 2026 16:43:16 +0100
Date: Wed, 11 Feb 2026 16:43:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: ethernet: xscale: Check for PTP support
 properly
Message-ID: <168768b8-f26f-4f4d-9b76-230a76c312d2@lunn.ch>
References: <20260211-ixp4xx-fix-ethernet-v2-1-07567f886c8c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211-ixp4xx-fix-ethernet-v2-1-07567f886c8c@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,nxp.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-258303-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,openwrt:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 63BF4125CF1
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 01:58:21PM +0100, Linus Walleij wrote:
> In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
> unconditionally despite this feature only existing on
> ixp46x, leading to the following splat from tcpdump:
> 
> root@OpenWrt:~# tcpdump -vv -X -i eth0
> (...)
> Unable to handle kernel NULL pointer dereference at virtual address
>   00000238 when read
> (...)
> Call trace:
>  ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
>  ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
>  ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
>  __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
>  __dev_ethtool from dev_ethtool+0x160/0x234
>  dev_ethtool from dev_ioctl+0x2cc/0x460
>  dev_ioctl from sock_ioctl+0x1ec/0x524
>  sock_ioctl from sys_ioctl+0x51c/0xa94
>  sys_ioctl from ret_fast_syscall+0x0/0x44
>  (...)
> Segmentation fault
> 
> Check for ixp46x in ixp46x_ptp_find() before trying to set up
> PTP to avoid this.

>  	ret = ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
>  	if (ret)
> -		return ret;
> +		return -EOPNOTSUPP;

Changing the error code is unusual. Maybe add to the commit message
why this is needed, or somebody might ask :-)

    Andrew

