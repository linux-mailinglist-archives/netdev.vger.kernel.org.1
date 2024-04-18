Return-Path: <netdev+bounces-89204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E78A9AD6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5283B1F25ACF
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A8136E29;
	Thu, 18 Apr 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tyGmx9Mf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078D8823A2;
	Thu, 18 Apr 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445538; cv=none; b=ufKNwYW2tfnLP9A2oMGp6MfCvTKF2dmGa4Z8JLLKPxCUUuCIB6kJgmPssTFSeUas65QHEZ1uQRg7AXdwFnF173c48pOJGiE+h2vgPosTB8XGUoIHWXLWV8vLrFjqC1HWpgCV3RhC0nm5ICjtNkF49bxLiiCdmKP2U4GuYrI6JTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445538; c=relaxed/simple;
	bh=oX2L1ktLDVgXz54XJCiyMPpSERt1/U10LKvx1j13dmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGQZMX7EW6E37pnqSlKuXXE82jrWHR+3AMiC7ePLb9kcqpMOcUNu8KCXJn7hObuHUBTz0MTYzgdW66kB+nKrWzZkqr6OVWPFwg8s9G7g49ZpSRFS/up7pTWZfvoTDoz5m8hNNUHqCbt1WAoI/0+iYfNB72Kf8tG71lzL9fq8qPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tyGmx9Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA0AC113CC;
	Thu, 18 Apr 2024 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713445537;
	bh=oX2L1ktLDVgXz54XJCiyMPpSERt1/U10LKvx1j13dmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyGmx9Mf8IonQSUN4N+iBpN/PSUXMYrby75Y4IT2x7/UKywDlf/fauVaOLiHLMh+e
	 D86Tr0UJBEjI/m6fJZlzuwvkBBvPfajSzHI6jk2eTVM4ot4y/CuR8f0j44npyj9aHX
	 8xg2FrL2ofdAyVb0ZfZvbHLdXgCnAeWzuj6E6zWE=
Date: Thu, 18 Apr 2024 15:05:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, mcgrof@kernel.org, russ.weight@linux.dev
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
Message-ID: <2024041825-sprinkled-popcorn-8a85@gregkh>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
 <20240415104701.4772-4-fujita.tomonori@gmail.com>
 <2024041554-lagged-attest-586d@gregkh>
 <20240418.215108.816248101599824703.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418.215108.816248101599824703.fujita.tomonori@gmail.com>

On Thu, Apr 18, 2024 at 09:51:08PM +0900, FUJITA Tomonori wrote:
> Hi,
> 
> On Mon, 15 Apr 2024 13:10:59 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Apr 15, 2024 at 07:47:00PM +0900, FUJITA Tomonori wrote:
> >> This patch adds support to the following basic Firmware API:
> >> 
> >> - request_firmware
> >> - release_firmware
> >> 
> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> CC: Luis Chamberlain <mcgrof@kernel.org>
> >> CC: Russ Weight <russ.weight@linux.dev>
> >> ---
> >>  drivers/net/phy/Kconfig         |  1 +
> >>  rust/bindings/bindings_helper.h |  1 +
> >>  rust/kernel/net/phy.rs          | 45 +++++++++++++++++++++++++++++++++
> > 
> > Please do not bury this in the phy.rs file, put it in drivers/base/ next
> > to the firmware functions it is calling.
> 
> Sure. I had a version of creating rust/kernel/firmware.rs but I wanted
> to know if a temporary solution could be accepted.
> 
> With the build system for Rust, we can't put it in drivers/base/ yet.

What is the status of fixing that?


