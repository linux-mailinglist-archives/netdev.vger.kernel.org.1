Return-Path: <netdev+bounces-186767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D47FAA0FC6
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4F9165E15
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09421858D;
	Tue, 29 Apr 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewUEWx+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372293D76;
	Tue, 29 Apr 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938691; cv=none; b=eit1S501++t/tY0ftFMu8PtlXP1sudYlEIMUqRPdYJwcN/c79DA8PVmumDQPYFi1XoOVhSJxtQ68fndmAl1uoerV+AVPbbGwLEmGq6+2PqwF/nu8W5Pzpu5IRVlaXn0bN9QXFUX0EBXOwBW7E/ib+79rUfT167D8g9Xn4e6iW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938691; c=relaxed/simple;
	bh=YleDWhKU2qP4cswz9p6MCSYdrLHr6SUMgLRtYoTEHBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTggq+l+l1rci6Yi46ynX6VOv2YgmxKZUhpK3e5d3C4QFNr0fIhp1zIeK1TAmumq2YD14xeZtt3OSCgDTjIqWYtNiEY/Woozyyr9DlA4EzugSM2EgUKerITdTJiu+uU+zTlrx/4B/UJ1qCXt1DlgmYXd5AK1UBeNvF0S6pY1abc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewUEWx+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DECC4CEE3;
	Tue, 29 Apr 2025 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938691;
	bh=YleDWhKU2qP4cswz9p6MCSYdrLHr6SUMgLRtYoTEHBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewUEWx+wOlXntTP9LkOCjftXDtVT5lgDML3qOm5iTuGkTIJxDFsnvNr2LDT2dIM0c
	 4FP3UDlmFwQPgEFr6DyN3L4nSHOF/LwgbXqULqKwCBY1h+xvmpvrLjfLmPb+vSHdkh
	 E52treYVO0CfhoUbp4QMnbBWoLIgf6FlQ4GEEyukYAbtngyucGzvM4V2sKD9GQgXLW
	 de9zIcLrB+ko/E2BmEj/hfK+6fanfLWFC7WU+tFVSgaXokLb3rY1+9A5eIP9fhoK4C
	 FyP0pGRI8q7y8hxVtB0xb5vjVrAeIP/nCs/PwLdXM4EHSmehcQwRd2OdvJEwhV6oS3
	 fSptAJmeAcXew==
Date: Tue, 29 Apr 2025 15:58:06 +0100
From: Simon Horman <horms@kernel.org>
To: mattiasbarthel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, wei.fang@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mattias Barthel <mattias.barthel@atlascopco.com>
Subject: Re: [PATCH net] fec: Workaround for ERR007885 on
 fec_enet_txq_submit_skb()
Message-ID: <20250429145806.GO3339421@horms.kernel.org>
References: <20250428111018.3048176-1-mattiasbarthel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428111018.3048176-1-mattiasbarthel@gmail.com>

On Mon, Apr 28, 2025 at 01:10:18PM +0200, mattiasbarthel@gmail.com wrote:
> From: Mattias Barthel <mattias.barthel@atlascopco.com>
> 
> Activate workaround also in fec_enet_txq_submit_skb() for when TSO is not enbabled.
> 
> Errata: ERR007885
> Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
> 
> reference commit 37d6017b84f7 ("net: fec: Workaround for imx6sx enet tx hang when enable three queues"),

Hi Mattias,

The commit cited above includes an explanation of the problem
and the work around. I think this commit message could
benefit from a similar level of detail.

> 
> Signed-off-by: Mattias Barthel <mattias.barthel@atlascopco.com>

...

