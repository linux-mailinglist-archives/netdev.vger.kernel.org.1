Return-Path: <netdev+bounces-177493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5743A7053B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC093B1005
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC581922C6;
	Tue, 25 Mar 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7egyPdm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA6179BF;
	Tue, 25 Mar 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916900; cv=none; b=UwWzAoOZfMVK7Ol0nrb10XWo9IWWH2fUeh76hK+T+0TzzjvPAtEUMs3ECID+OJnzwv1X0SdR+XyxcHm07rILaC5KtAiUvkSyZ/dacre2nOeATL/c7OIoh+juhwZ0Zedan6ct131nZOlJ8ej1ra+GfzTKwnlQkLKg/vMDWq7x5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916900; c=relaxed/simple;
	bh=RbHFCG8u32jSkaP1gyCE7hf+qUuT+BdMulLJcQtbFaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOFzfHXj3wjGDrrEaNYgD3dMMs9ewSwnTjDlp7SMW44eAMove5y/2Hoj2zmgEi5lqsg4y4Si7/87cztRv5kpyJCUbTlJ6UtvZ+pPWvQIecPrsvMb0hbOB78VZyVYLI2StR07S4IQUEfDVv2XTVhc7+MzpZkS2aVx6UfBgjCf0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7egyPdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CBEC4CEE4;
	Tue, 25 Mar 2025 15:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742916899;
	bh=RbHFCG8u32jSkaP1gyCE7hf+qUuT+BdMulLJcQtbFaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7egyPdmQkbGHqoImT2T6ErmiqmH8sKXQ16AywoY5X+5GT6W5yQkJpNmSztwiQOoY
	 wOlUzOJQz4ajrRjAS4bh3Wtvbsyb5iOhSlwUYvbSwnS/kQ6ascQpqvCSK6SykjzP31
	 /lR9JTcqzNOPfwKM/qCgrBajedFT5JSnjo5ZQWolj3gTNihHfLNMwB04Us/gPIfbAf
	 0SAn+Jact8gEhrWvfG/X4Zez0mUbV/lDeFwUc1hx2rwy4pAkrgQXzqJvFcJG3J17sZ
	 z6BKjr1JPJqqBo0lSxyZGqqbrGUka506D+L2qTHUw+2b5GH6hQ5eQRYj8HEb3jbQ1N
	 Bt0zJ+mmUCCWQ==
Date: Tue, 25 Mar 2025 15:34:55 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: fix DCB apptrust
 configuration on KSZ88x3
Message-ID: <20250325153455.GV892515@horms.kernel.org>
References: <20250321141044.2128973-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321141044.2128973-1-o.rempel@pengutronix.de>

On Fri, Mar 21, 2025 at 03:10:44PM +0100, Oleksij Rempel wrote:
> Remove KSZ88x3-specific priority and apptrust configuration logic that was
> based on incorrect register access assumptions. Also fix the register
> offset for KSZ8_REG_PORT_1_CTRL_0 to align with get_port_addr() logic.
> 
> The KSZ88x3 switch family uses a different register layout compared to
> KSZ9477-compatible variants. Specifically, port control registers need
> offset adjustment through get_port_addr(), and do not match the datasheet
> values directly.
> 
> Commit a1ea57710c9d ("net: dsa: microchip: dcb: add special handling for
> KSZ88X3 family") introduced quirks based on datasheet offsets, which do
> not work with the driver's internal addressing model. As a result, these
> quirks addressed the wrong ports and caused unstable behavior.
> 
> This patch removes all KSZ88x3-specific DCB quirks and corrects the port
> control register offset, effectively restoring working and predictable
> apptrust configuration.
> 
> Fixes: a1ea57710c9d ("net: dsa: microchip: dcb: add special handling for KSZ88X3 family")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


