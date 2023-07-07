Return-Path: <netdev+bounces-16071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28D474B4BB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7760628179C
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ED6107A2;
	Fri,  7 Jul 2023 15:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E764BE60
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F72C433C7;
	Fri,  7 Jul 2023 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1688745401;
	bh=bkZ09eBR9K1JcVuv4LdBb9/5RmwuTsr4HcJUCgWtcRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seq7cXOPzbXCYN0FwZuDKwocnEZzSoLnzDnKWhQwnBqkr2+P16c3tFKtRLEJeUeuT
	 OQnkM4lJw0mXnmABrRUBqiEHNWmhD2YidctMlfWXA+gRu6XrEe2NOJuRpaow+qiMeX
	 VEoPdnkGNm3vaemy8rAtPUQySI9R+qvGFAKeEwxg=
Date: Fri, 7 Jul 2023 17:56:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH linux-5.4.y] bgmac: fix *initial* chip reset to support
 BCM5358
Message-ID: <2023070731-boxcar-pointed-d73f@gregkh>
References: <20230706111346.20234-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706111346.20234-1-zajec5@gmail.com>

On Thu, Jul 06, 2023 at 01:13:46PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> commit f99e6d7c4ed3be2531bd576425a5bd07fb133bd7 upstream.
> 
> While bringing hardware up we should perform a full reset including the
> switch bit (BGMAC_BCMA_IOCTL_SW_RESET aka SICF_SWRST). It's what
> specification says and what reference driver does.
> 
> This seems to be critical for the BCM5358. Without this hardware doesn't
> get initialized properly and doesn't seem to transmit or receive any
> packets.
> 
> Originally bgmac was calling bgmac_chip_reset() before setting
> "has_robosw" property which resulted in expected behaviour. That has
> changed as a side effect of adding platform device support which
> regressed BCM5358 support.
> 
> Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
> Cc: Jon Mason <jdmason@kudzu.us>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Link: https://lore.kernel.org/r/20230227091156.19509-1-zajec5@gmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Upstream commit wasn't backported to 5.4 (and older) because it couldn't
> be cherry-picked cleanly. There was a small fuzz caused by a missing
> commit 8c7da63978f1 ("bgmac: configure MTU and add support for frames
> beyond 8192 byte size").
> 
> I've manually cherry-picked fix for BCM5358 to the linux-5.4.x.
> ---
>  drivers/net/ethernet/broadcom/bgmac.c | 8 ++++++--
>  drivers/net/ethernet/broadcom/bgmac.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Now queued up, thanks.

greg k-h

