Return-Path: <netdev+bounces-105026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0EA90F756
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A2228275E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202978C9D;
	Wed, 19 Jun 2024 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eApfcEdJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244474E09
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827483; cv=none; b=lhO6raqTRDcHax1UKRTyx9JGXb+c6uf6vvi0joPoHIWlFnyswWgK2cQIY43/gfRjKrPBN31lBxyP8dxCKnMBes5JpXCHUgpgx+Rn8AEOWeiTO+Y9JCix6n9qRz7C08DxYVhK93xsGm/shimAA8MaBjFvU+rcPWI4v0mi5gX8zFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827483; c=relaxed/simple;
	bh=I9sXk2pHgOJhdEUI3/GVa4lPSME3S5OxvnfyB3pbE7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF5bnLgNI7HApdCsBjLsaatU2ZNhkOafTvO/9aTK+RgWuNAeE7oYWWekHNS0C54/uRT8B1u0XPiN2zhRU25ggQ5mhRbxvtPfN1UKIi8ZNNrBmhHNVTnEfCjSYvYFSmyEbH+p0OaxiVYe1HIj8jRCVGB0H8nSlroIr1Ivh8JoLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eApfcEdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D71C2BBFC;
	Wed, 19 Jun 2024 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718827482;
	bh=I9sXk2pHgOJhdEUI3/GVa4lPSME3S5OxvnfyB3pbE7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eApfcEdJ8+2eNjrmPYH29eOvgrsTx1YSKN+pcOAwuoczwHbqn7T9CYbGhehTpxj84
	 1RzAY5WwA0Dxey43JqVAV6lUnEFhpop9DmFxp+TKOJ0Jiy4UVSU0vhKuLIDxP9D0j0
	 GXgIfb5trCz6rN1GXPYYvi6RR1mNEPZ44xO5U0tKPJU71vByzH3rropSzuAKTx5Ypy
	 nXuEo+EqvUzcCKi+q7en9XlneUq5IRh/Ky0SMAONyeZKSEHxypbsCgRT28aaLlusUe
	 fTBBFN0B6mqqQNY7oYGwHv7keL0hVWpiYv8mjh0WPTwb7jNnCM1mWgi9I7W4T5M3GX
	 j/0A0XIvJfnCQ==
Date: Wed, 19 Jun 2024 21:04:38 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 3/3] bnxt_en: Restore PTP tx_avail count in case of
 skb_pad() error
Message-ID: <20240619200438.GZ690967@kernel.org>
References: <20240618215313.29631-1-michael.chan@broadcom.com>
 <20240618215313.29631-4-michael.chan@broadcom.com>
 <20240619200253.GY690967@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619200253.GY690967@kernel.org>

On Wed, Jun 19, 2024 at 09:02:53PM +0100, Simon Horman wrote:
> On Tue, Jun 18, 2024 at 02:53:13PM -0700, Michael Chan wrote:
> > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > 
> > The current code only restores PTP tx_avail count when we get DMA
> > mapping errors.  Fix it so that the PTP tx_avail count will be
> > restored for both DMA mapping errors and skb_pad() errors.
> > Otherwise PTP TX timestamp will not be available after a PTP
> > packet hits the skb_pad() error.
> > 
> > Fixes: 83bb623c968e ("bnxt_en: Transmit and retrieve packet timestamps"

Sorry, I missed that the Fixes tag is truncated.

Fixes: 83bb623c968e ("bnxt_en: Transmit and retrieve packet timestamps")

...

