Return-Path: <netdev+bounces-229640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7BBDF200
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749643BB894
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880D29993E;
	Wed, 15 Oct 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjUbDyQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E195296BB4
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539223; cv=none; b=VnCGenSE5hqy1/yXnGeQEm+lOQbr5TVsVeOKiM0EvAkv4uWn+4xolWUSIkcq8g6pHS8Ya3qLM58IxbspDKtgSENI2+j3iSf9qL3gTZoVwgyLbQdGBRTJyCteSzF/M4v1ofMsqZmsCmZTbGm3RRG33i5oIg8Pytq4yf7WqS2gADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539223; c=relaxed/simple;
	bh=4y/zsXczC9oQc1cVgMvcFmpHD9joz05GOOTbO+4I/sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVvqkkIwpLXdjjtLSLXeXCt68MJZMZd5p0hhFImLnzXc5DyFjtIrYld+7cvUdZ84cv50AZIo9btEUrTEWMVux+IQp9yR8dC5gykz3S8eoOUHMXcOnXIkfk9LqOT16sVQ45em3Os3/fiJaFEuMWP1jfw79ERXj85irqyCi2SkGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjUbDyQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1B0C4CEF8;
	Wed, 15 Oct 2025 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539222;
	bh=4y/zsXczC9oQc1cVgMvcFmpHD9joz05GOOTbO+4I/sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjUbDyQkhAeacWWzgHEG0FuI92bYh1u6ynsFfhl2h3u5g68RBJUJgPMvGxVlWd2Tm
	 jqFZnUgUv8hCKNz9KLQBEbBWVY29ppPZHFO/wk+OLfO6EChpAzL84atRQvTTZrhAje
	 +pN9TT2lH8J/6th7uoKKdg3O1VgT3WF7WK2fIZCBZQz0GKiaKQWeGToJuTR5mV4DJN
	 dPpDYasRnE1POCqFZgwSoi6Fv8T278nJyhCEYVLga7OP4L2aCoLG+KrFoeBsC+A5n+
	 sich3z6qt2a3kyNTPn+kmjXqz062jdaP4l0xTmZzhyYktlZti0H2OvZU1KVxaXsukY
	 WkZX10k5dSi/A==
Date: Wed, 15 Oct 2025 15:40:17 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/7] amd-xgbe: convert to ndo_hwtstamp
 callbacks
Message-ID: <aO-yUeK-nxGClenP@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-4-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224216.8163-4-vadim.fedorenko@linux.dev>

On Tue, Oct 14, 2025 at 10:42:12PM +0000, Vadim Fedorenko wrote:
> Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> .ndo_eth_ioctl() becomes empty function, remove it.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


