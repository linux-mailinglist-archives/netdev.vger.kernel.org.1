Return-Path: <netdev+bounces-217944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D252B3A7BB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7691893DE5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422F334725;
	Thu, 28 Aug 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C41j/6Z2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205242A1AA
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401688; cv=none; b=u7dph5tspTAW+DYlgvkFeHqzvOjW0VanVG6tHDcyYhl+rq/uHqfcxuHVgBKDyxMAJQ1bJv00dXez707yNYfTKa2FnnrUf1t2PsD/xogiW/rMRgTNjTP/PlkoxiF2cLA+r40wkIOR4bkdLC1H6YEu09+eH0PIW/QrMvNL4Il7/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401688; c=relaxed/simple;
	bh=KHnGjRgKwHIlwFNt+76sYZzl66nObvGq0G9FHnT68tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoFZhWBjoc5rI+l2VTJoI2fr4RXbLpxMtVNSW7EknyNsvxheaTQvkn/u8OCMlbU8Cp6Un5WGhg0eoz5+Vuq5kl4eXa7FTYBae1eVatdEBDOW0b7Qm1deEKSY0qAHHm0m/Z/eb2Gu5pSU5Zq2zjJXobvdFQUWQn4iqmQesZ3f7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C41j/6Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C36FC4CEEB;
	Thu, 28 Aug 2025 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401687;
	bh=KHnGjRgKwHIlwFNt+76sYZzl66nObvGq0G9FHnT68tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C41j/6Z2q8NeuG0OcgCHMiieIEDFWvT5DEI7uwH/7cs1yTtI0TRZ4oCAwndP28Wp1
	 x14XUg/yUl/CWM3xgnkaseCdu+9RGm6L2hN89cue1cyOBmpDTJpQq6t3DwjamSmgzt
	 PMitng0ALlVlCZY9GYuwoXsZe8HEDrY3YzmZaQI5+MJ6af3rGreD4K9A74X4Eoi3as
	 uj/raNnqV8DBJ6SP/d0N48rQK/krmfxBMIRb11jOSnZ2l1yUN5SWElYTFZXPHBj5Op
	 ZoNw8frcPdzC/jER/NfI9Vecwglt79rlhng5gDRrK+0nxAfKeXo41CAuDMo5Bbt7jF
	 4ge65UjohyWyg==
Date: Thu, 28 Aug 2025 18:21:23 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] xirc2ps_cs: fix register access when enabling
 FullDuplex
Message-ID: <20250828172123.GD31759@horms.kernel.org>
References: <20250827192645.658496-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827192645.658496-1-alok.a.tiwari@oracle.com>

On Wed, Aug 27, 2025 at 12:26:43PM -0700, Alok Tiwari wrote:
> The current code incorrectly passes (XIRCREG1_ECR | FullDuplex) as
> the register address to GetByte(), instead of fetching the register
> value and OR-ing it with FullDuplex. This results in an invalid
> register access.
> 
> Fix it by reading XIRCREG1_ECR first, then or-ing with FullDuplex
> before writing it back.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> This patch is untested due to hardware limitations.
> If the Fixes tag is not required, it can be removed.

Interesting.

It seems that XIRCREG1_ECR is 14, and FullDuplex is 0x4.
And 14 | 0x4 = 14. So the right register is read. But
clearly the bit isn't set as intended when the register is written
(unless, somehow it's already set in the value read from the register).

So I guess this never worked as intended.
But I guess so long as the code exists it should
do what it intended to do.

Reviewed-by: Simon Horman <horms@kernel.org>

...

