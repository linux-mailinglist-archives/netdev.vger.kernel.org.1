Return-Path: <netdev+bounces-166712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A0A37042
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B231D170313
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF31624D3;
	Sat, 15 Feb 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IC9iidve"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1521EA7CC
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739646031; cv=none; b=tJu2CAxa9dsGHsLR4yUAAcb+pE0kDQUOc7h7ECvzEYveV90ATiPzG1ipmDVbxsRKVRi2Qe5flVFTVIKmLkBHmkvwDfNGBbbQNPcwq5o8zAX4kNg1wXpL3EIRwEmOhqLz3f4iw42e2iw/v+cIanpxswso2PCe3MYPMoYvYetz6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739646031; c=relaxed/simple;
	bh=dx5KhR7TguaIni6G4jgk/l6odMr0pMdVCgDTvTMKeJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyutSyGqZDSh5s4h547W4UzHQD5nZfj/7SscLO7ogjFVOTuHRISp+f/cnouPKxdXhucPAEeBWsqGOxepmxZVKSpaFxX+petOR5CDjMi7OdhTN+k+fhSubL3RO6dQzpW2OjqMq0TJS0NKDRyB6uX7KqHsG10GvsGu2JBf99SBmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IC9iidve; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2vpwHJsq2PGncNrbYGt4bTuA2fiMEz2qgcBXdDf8Eho=; b=IC9iidve9OkS2iH8fZm2RgPbaE
	C3vZgT+iHMYeKgYvJ9xFkRKEsCNqUCm6ypEA4QwbCPpK6dN4Pxfx5P/OO8HoSKEtPR/hZpAsdGE79
	2nMfdLxRcr7CuqpCE1kiHuP7WCzkDeLQ1DBfbWQmYfAInGisuT3HekbDpnT/uYxd9PU4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tjNOm-00ESWU-P6; Sat, 15 Feb 2025 20:00:20 +0100
Date: Sat, 15 Feb 2025 20:00:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, suhui@nfschina.com, horms@kernel.org,
	sdf@fomichev.me, jdamato@fastly.com, brett.creeley@amd.com,
	przemyslaw.kitszel@intel.com, colin.i.king@gmail.com,
	aleksander.lobakin@intel.com, kernel-team@meta.com
Subject: Re: [PATCH net-next V3] eth: fbnic: Add ethtool support for IRQ
 coalescing
Message-ID: <a5f56aa9-41ac-4901-a6e6-d08f1bdb4ffc@lunn.ch>
References: <20250215035325.752824-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215035325.752824-1-mohsin.bashr@gmail.com>

> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
> V3:
> - Rebased on the net-next
> 
> V2: https://lore.kernel.org/netdev/20250214035037.650291-1-mohsin.bashr@gmail.com
> - Update fbnic_set_coalesce() to use extack to highlight incorrect config
> - Simplify fbnic_config_rx_frames()

When posting a new version you should add any Reviewed-by: and
Acked-by tags you received. Maybe consider using b4, it will collect
and add them for you.

	Andrew

