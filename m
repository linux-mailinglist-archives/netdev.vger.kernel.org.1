Return-Path: <netdev+bounces-136634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353EA9A2822
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CA6B21888
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160511DED7F;
	Thu, 17 Oct 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS7JImVt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66951DED70
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181244; cv=none; b=J1+dRSlJPdB7FxCVsLfFXQcTm1zPhi3J6cZV+FzxdZGIVNTfTts7lpiOTPk23rWDGDNNk78njliHYc2GGVT6OOURuUsS3RFtY9D7QzI8Wh/IzI/lUbUaRmWm8RmKuDyczPBXJsdHIOkkEBCxT7nBzPgRHV0WbX8uXkPDT6ertFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181244; c=relaxed/simple;
	bh=Ev6OZvm9BC7b0MyiFcGAWVlqBrHU3AyYK1jT7Y738QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nji9jxT++9ZFyfMtERo3BUMJNr2Fd6fQFuvNB9p8BICA3vJwAGrQx9V2pdWR5E78qqhB3oi1Enx+aDNJJmKHaIO5HBDuzB6FblxnHZtQl3i0KjTJ8sZwp6QKVN/M74VjynOhd9fO4FOIrVDkKBiPepdU8RdnqlFZnLxhDv40UNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS7JImVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1440C4CECD;
	Thu, 17 Oct 2024 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729181243;
	bh=Ev6OZvm9BC7b0MyiFcGAWVlqBrHU3AyYK1jT7Y738QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NS7JImVtc2ESyroTEsK0/Cp96hbWORmGZzfjFbp5Te9ZAT6+QLBa6uE5xiKuwnTug
	 6W/CvhSWFVorU/Jp2SmvhOfW4ssGOEn/GjbOvg4sXm79BjIlWvcn8vl52teopDZfl4
	 C7H8clo27YKUmPRXg+M6HEKdEZCm/FnUK5AIk5/WmgCSKyFsmG8H7A7LhrZNirER/M
	 mEtuSlE+pQYbUFpirX9ur/ygcnHvHlrz+SVt0aX+hGs10WIoXLzGMFebxNwidwt0rU
	 pfUxm+neuiiJ7EoMamHEsMoZSiyd3WQfltCI05IFYON87yLbeW/M1pShKHU3b7cnE5
	 KKijoMajbD/ng==
Date: Thu, 17 Oct 2024 17:07:19 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Pengyu Ma <mapengyu@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: avoid unsolicited interrupts
Message-ID: <20241017160719.GY1697@kernel.org>
References: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>

On Thu, Oct 17, 2024 at 08:05:16AM +0200, Heiner Kallweit wrote:
> It was reported that after resume from suspend a PCI error is logged
> and connectivity is broken. Error message is:
> PCI error (cmd = 0x0407, status_errs = 0x0000)
> The message seems to be a red herring as none of the error bits is set,
> and the PCI command register value also is normal. Exception handling
> for a PCI error includes a chip reset what apparently brakes connectivity
> here. The interrupt status bit triggering the PCI error handling isn't
> actually used on PCIe chip versions, so it's not clear why this bit is
> set by the chip.
> Fix this by ignoring interrupt status bits which aren't part of the
> interrupt mask.
> Note that RxFIFOOver needs a special handling on certain chip versions,
> it's handling isn't changed with this patch.
> 
> Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
> Tested-by: Pengyu Ma <mapengyu@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


