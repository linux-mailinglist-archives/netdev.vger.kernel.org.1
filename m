Return-Path: <netdev+bounces-178449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2EEA77169
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952E17A453C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCC1D516F;
	Mon, 31 Mar 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqeHVKLW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2115A856;
	Mon, 31 Mar 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464359; cv=none; b=SSLOU3U4e5M003BZzbHp+WXcHp7Jv2xLcgfJrZv8zRfIqvwZ/3E1tP7tRQiDDr2bMu9EAITG9qJR9QxddRq2mbtlM6nIHweO5r04Y2xrXjAbE6kXIDpp0OVamlBTF56dQMq2VP8uJge6K5auCrHf65mTw8LLjBNKGQUoNkGeh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464359; c=relaxed/simple;
	bh=iDDxk1vTM1N4XfhzpWzXSbHOm8EykhgNwj8YfZJySkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbdSfgzYNgs1erNS2OpsoX71wfM7TPPNv8MZr0S2ZBz/or5ME1bzewQ+SwrDD65Dto7T9AHVRX9t78+DPCa8KwyfgnPMOXzH1XWmTjxaculjOz9FWCLrSVv5Q45zc3updO3dIJ4nKELxEk3xreKtEXalifHLpcLE1J0Fp2Yal8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqeHVKLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9352C4CEE3;
	Mon, 31 Mar 2025 23:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743464359;
	bh=iDDxk1vTM1N4XfhzpWzXSbHOm8EykhgNwj8YfZJySkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqeHVKLWZrLjjj+ubooWaj9RMITJ5g/pGmmIhYfErGhGgi/0+Au+BsmrP7Iky7Yzz
	 29O83BSOexxJWPWD+VAGl5DcupQR5Lb/t3u3CUnQC94oCSIkdml6P4ZP8rd1mNR3yx
	 DSGkh4grOnzf/SMr1G4YN+Y7SllScY/SmRAZLc397nt4dqYnhqDpK2XgPYF1vKmUYm
	 ZXbIKmVrinpCcv5MEY2HbtqCilu9FJEGYKQ8d0nO9/rBntBkV+yIA+wmGiwSqpRYlZ
	 pDFyCWwfrlh907AQrZWK5gSLZHhrwLD/BkpQ6KcD8z4DviVeHTfzHSqlY/x/VclEMn
	 0hTzX9PdS/S0w==
Date: Mon, 31 Mar 2025 16:39:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>, Eric Dumazet
 <edumazet@google.com>, open list <linux-kernel@vger.kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [RFC net 0/1] Fix netdevim to correctly mark NAPI IDs
Message-ID: <20250331163917.4204f85d@kernel.org>
In-Reply-To: <Z-sX6cNBb-mFMhBx@LQ3V64L9R2>
References: <20250329000030.39543-1-jdamato@fastly.com>
	<20250331133615.32bd59b8@kernel.org>
	<Z-sX6cNBb-mFMhBx@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 15:32:09 -0700 Joe Damato wrote:
> > Would it be possible / make sense to convert the test to Python
> > and move it to drivers/net ?  
> 
> Hmm. We could; I think originally the busy_poller.c test was added
> because it was requested by Paolo for IRQ suspension and netdevsim
> was the only option that I could find that supported NAPI IDs at the
> time.
> 
> busy_poller.c itself seems more like a selftests/net thing since
> it's testing some functionality of the core networking code.

I guess in my mind busy polling is tied to having IRQ-capable device.
Even if bulk of the logic resides in the core.

> Maybe mixing the napi_id != 0 test into busy_poller.c is the wrong
> way to go at a higher level. Maybe there should be a test for
> netdevsim itself that checks napi_id != 0 and that test would make
> more sense under drivers/net vs mixing a check into busy_poller.c?

Up to you. The patch make me wonder how many other corner cases / bugs
we may be missing in drivers. And therefore if we shouldn't flesh out
more device-related tests. But exercising the core code makes sense
in itself so no strong feelings.

