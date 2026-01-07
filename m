Return-Path: <netdev+bounces-247813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491F4CFEC5F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 17:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D10FF3001BE8
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441538F951;
	Wed,  7 Jan 2026 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVCUNNLF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B838F94F;
	Wed,  7 Jan 2026 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801350; cv=none; b=j2dwKTboXIKsjwRnYW6gKYS/aFDQ4N4ry56FUb7+Q1sWq25gp4kD5ySh8tMWCPkH5TDkjscC9MUdK/68ccr5uGHuSviuHzCj8zPHhHGPtUHHYv2WsqAN/HcfC1Vsj1JCyiWxy5IvNhoUCXh2iKVdTaqW/xfebKsPZj/tpyK7GUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801350; c=relaxed/simple;
	bh=EB/VxIMx+or4ZiyXJHHGPfuDj49Ot6AaGdeNkOaX78E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqJ2zTTjB8zczvTK02IRMqxoKcZ/DHUJaCAQwzvLxsSCyworo01GUCn2b2dJJtDlhMu5fga+zuxWYsAX/nKBtZCboT91+rn0bfe1eNzp7mzZcTl40fpj2TPVFFEsgwo6kH/SXlnCiUNqTE4erKevrrgspktOp/LZjW3Lo3qvH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVCUNNLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EBFC4CEF1;
	Wed,  7 Jan 2026 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767801350;
	bh=EB/VxIMx+or4ZiyXJHHGPfuDj49Ot6AaGdeNkOaX78E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVCUNNLFwjmvyiCDmOaypprhrA4/prpF/UwDfoITY14n2gKHlXuGadFOdE7gHMpH+
	 1/A856qoPrPnOKcMYd6lyjmbyV1zfgDothz9yKfPCkC1AntvNpcoAjh+bprOZ23TJ4
	 ZIjavXE+dihrbF1d/X6vyx3O5xqzwTQGIDFQ5ebtkPtkh2ejbRMo7TU7BtKiQSQLpi
	 VP1UUsjymLFnEYSn4LMcsbezTZTLnNwIs5AEkmYYeZd+Y0rZd/WO/74Yiu4XdVHDpa
	 YULUS+wCyO+xLImXEvXBpn9K9rrYSmHQf2U1eVqkOLyCSAWBRJZG578nYIUUlh8F+f
	 1Vxxxpsvg/eQQ==
Date: Wed, 7 Jan 2026 15:55:46 +0000
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 08/15] net: ftgmac100: Move NCSI probe code into a helper
Message-ID: <20260107155546.GD345651@kernel.org>
References: <20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com>
 <20260105-ftgmac-cleanup-v1-8-b68e4a3d8fbe@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-ftgmac-cleanup-v1-8-b68e4a3d8fbe@aspeedtech.com>

On Mon, Jan 05, 2026 at 03:08:54PM +0800, Jacky Chou wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> To help reduce the complexity of the probe function move the NCSI
> probe code into a help. No functional change intended.

nit: help -> helper

...

