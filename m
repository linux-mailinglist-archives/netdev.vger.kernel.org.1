Return-Path: <netdev+bounces-79954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87687C327
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A223B21699
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9F757EF;
	Thu, 14 Mar 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhn0Vvzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80585757F4
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442534; cv=none; b=RoymWFo49QWxVs2RlNC+znRsqfo08cWfVue5kusne7c7IaP7GDHZgcxlJgYk4t3wigU/Vso4Ii33knCeHKdmoCXQqCzT696T1JZlOfeBATsJQZUiz74XSXPVg4svpVwyhGOrMAsNcNCD1z7F5AaOVo0R0aHhIjx0fiIYU5n/zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442534; c=relaxed/simple;
	bh=xHa6xnC3tIFFwidVVKUAzeaOc1QArxpqWh+wKs8HJoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZWiTAHECMW1c+8PTce0ZPPDMyC/nGhL7p4PZvsw8/oYNuabIFwWgiHI7QRLhU2nYxVAD4chGcHxA4qUR+bh7cKVvtRNVEsaHz/Bivx/eg080QSCLga/DNODM5nkpdVCDwOPGjY9nbRPgRJUAblNfcKZyMhKJrMurweE27Bf+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhn0Vvzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75C1C433C7;
	Thu, 14 Mar 2024 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710442534;
	bh=xHa6xnC3tIFFwidVVKUAzeaOc1QArxpqWh+wKs8HJoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zhn0VvzlFUVcahbUaeaxPz70N27lWKj16Wz+72pTJfgrUY6hfFoulndiYc5akG8Pi
	 IJ3Z3lUD9sy/A9tNfZ7kviJ5nXMNO06S3k3dlhGPOjqB3UqARIpBvQBdnV/KDxveZN
	 8tuPWE29T+WGh1RPzWgzp8hnZ5muu10abbzqSEOgkQXTxCMzdb+UaHpvoeFOoG8Wy7
	 stcK0sDvQkpXsOaEGVOGpJY0MIC/cZllepIMEm8wIXp8rN1mesxj/nOfpQi7iyePxV
	 MuPWWcmXC1lyquxOrJWIYWR9c5LX3daIDb/dBUiPo+3v+SQ0fcrsJUU762rPoCBPAh
	 xKvQGH5eUwsJw==
Date: Thu, 14 Mar 2024 11:55:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijie Zhao <zzjas98@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, chenyuan0y@gmail.com
Subject: Re: [drivers/net/netdevsim] Question about possible memleak
Message-ID: <20240314115532.5ac9a177@kernel.org>
In-Reply-To: <ZfJdPoN7be+5ohpl@zijie-lab>
References: <ZfJdPoN7be+5ohpl@zijie-lab>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 21:13:18 -0500 Zijie Zhao wrote:
> Here if the `err_nsim_bus_dev_id_free` label is entered,
> `nsim_bus_dev` will be assigned `NULL` and then `kfree(nsim_bus_dev)`
> will not free the allocated memory.
> 
> Please kindly correct us if we missed any key information. Looking
> forward to your response!

/**
 * device_register - register a device with the system.
 * @dev: pointer to the device structure
 *
 * This happens in two clean steps - initialize the device
 * and add it to the system. The two steps can be called
 * separately, but this is the easiest and most common.
 * I.e. you should only call the two helpers separately if
 * have a clearly defined need to use and refcount the device
 * before it is added to the hierarchy.
 *
 * For more information, see the kerneldoc for device_initialize()
 * and device_add().
 *
 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.
 */
int device_register(struct device *dev)

