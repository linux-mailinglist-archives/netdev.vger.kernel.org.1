Return-Path: <netdev+bounces-206627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A60B03CC7
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3240C1767DB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E523FC42;
	Mon, 14 Jul 2025 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3R5uK4s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392F239E60;
	Mon, 14 Jul 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490933; cv=none; b=Jf3yiCbwiuPxV9jt+ZdZGMImk8NSQzNuXdk31EA9r6oN8x2XdOUXFIIr8EI2HJXepA3XMwmP75dC8eM3Zvo26SQh3AK3U9f0YWH9YDXsDwa5MgVI3IXrUixASqxxmyiKYrgY59g9OulDBJ3TuXegiuDXyYu5VMNBu9tUESHYrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490933; c=relaxed/simple;
	bh=nPxink05T5UZYe3FMijXbIpttjgyGk6c2hQX0HSdz2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR5vBGWTkmAn5KXFuLWOTBTC7pcCv5lNr7islqOkMZgvakVyeR4GgufoBFcmQ+HvQANuDSL6wPJo/QSBmPJ74P3b6VwAA4aEW6vQOPSxlc9WKH6jyvMOUo9d8vVXZ0Hi/Gg5mpYJ4WD6CFo30drV1TTbTBLsN/+aFyGPzdjw4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3R5uK4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691D4C4CEED;
	Mon, 14 Jul 2025 11:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752490932;
	bh=nPxink05T5UZYe3FMijXbIpttjgyGk6c2hQX0HSdz2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3R5uK4sIyPd3KoHIFWgzDtMaGRUupHCjSrUaE74omqUFb3docOSmYQBSycv8G5EG
	 fKSE7Bq8rm/1fLWNp1oHKc4+eSyHVm6TsrwZ4LSxPNtLcjtl3FaCu6PzAF5mwEfVcm
	 21GzmF4/pm5Rx72n4eUJZ1Y4Z3d7T8s1CI1jHMyP5juQhYGxmDDmyoMNi9FmlzKJK2
	 pdL0MBQqfNmMCd1n5t6+LwrQgN75JzTWdbrP00m1LZZK7Hu77j4vwpuPnTR5cX3OOc
	 lpHgQN9i1tUVWQHSLYKoq9gApIrF/jU+IawGxwc59hNUI/rwChj+kH1X8feDAtQv1z
	 aviBLuPeo76mg==
Date: Mon, 14 Jul 2025 12:02:06 +0100
From: Simon Horman <horms@kernel.org>
To: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	John Stultz <jstultz@google.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	markus.bloechl@ipetronik.com
Subject: Re: [PATCH net] net: stmmac: intel: populate entire
 system_counterval_t in get_time_fn() callback
Message-ID: <20250714110206.GI721198@horms.kernel.org>
References: <20250713-stmmac_crossts-v1-1-31bfe051b5cb@blochl.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250713-stmmac_crossts-v1-1-31bfe051b5cb@blochl.de>

On Sun, Jul 13, 2025 at 10:21:41PM +0200, Markus Blöchl wrote:
> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
> 
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.
> 
> Initially assign the entire struct with default values.
> 
> Fixes: f5e1d0db3f02 ("stmmac: intel: Remove convert_art_to_tsc()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Blöchl <markus@blochl.de>

Reviewed-by: Simon Horman <horms@kernel.org>


