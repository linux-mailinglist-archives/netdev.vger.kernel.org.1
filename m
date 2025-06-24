Return-Path: <netdev+bounces-200882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B7AE737C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84E53BBBD1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267B926B081;
	Tue, 24 Jun 2025 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAEQDbpM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AB2CCC1
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809041; cv=none; b=DRvNBeQzmFyppZ5mSmMcvVdoAuFpKeT805+ngwonUh/G/qZVDMQQ9QuLBIs87E6AL4M0hK5xoDWGPEnCNljfe4rJoBZD5VbdSNKFLhPCNGxbl8JX6wHudShnmURgFpEckKLWw6pkWlz4FVz7n5UH/1SCwmUuijNFQ52SjL0dkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809041; c=relaxed/simple;
	bh=l4xso0ieNaJj4Vv4ltY0j1STRw9xDEnmbpFN2PNEfi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9J78/Sv54d+IXRLbhgnoU2aNzU07SqFfZ5amT9cfA/CK1yzxvfhSrly3/FjtFPMR7QFbq0LyVDF7PBbX1vrKzdtt+3ZtlrWt6pyGSy7h3IFu9JDiaF0Stm5YhcrOkfJO7ki6s95aT6habY82SnPrSeRGwClfdmdUa/UvVmVfHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAEQDbpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDA2C4CEE3;
	Tue, 24 Jun 2025 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750809040;
	bh=l4xso0ieNaJj4Vv4ltY0j1STRw9xDEnmbpFN2PNEfi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BAEQDbpM+QGcsZPp31Gyk6qupp8dgVWawwJF4W76qC4y4+CxKbWXfkEjv7NuiPX4w
	 mAGgOasx9/rNQ6VJ2+3bMvl8PDjEXn7onHgruqMLUW/G2UeogFbh7gzUMtI1nAacAk
	 FuAU4HZFnpsA/cZrWBvgViCvfHSfBTmpGSnxRZgIvf4tNtmRjFzFD7TTE3sfYSikBl
	 qPx1RtoOQFR4+xE+zhV53Bx9p5zYnx9LxiJu7FJutgXX9Kxem5rn7bf26vkTn7NPHa
	 dQJJSzBqr83HVqzcdRGQRDPuzy8QaESJnGNrczB7G7l1x7oTMY1qUi494UKBkN7RZV
	 Ny7nkMiotagTA==
Date: Tue, 24 Jun 2025 16:50:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: willemb@google.com, Joe Damato <joe@dama.to>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller "
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, mkarsten@uwaterloo.ca,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9] Add support to set NAPI threaded for
 individual NAPI
Message-ID: <20250624165039.5bf4b3d9@kernel.org>
In-Reply-To: <20250623175316.2034885-1-skhawaja@google.com>
References: <20250623175316.2034885-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[swapping Joe's email for a working one]

On Mon, 23 Jun 2025 17:53:16 +0000 Samiullah Khawaja wrote:
> A net device has a threaded sysctl that can be used to enable threaded
> NAPI polling on all of the NAPI contexts under that device. Allow
> enabling threaded NAPI polling at individual NAPI level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a NAPI
> context.
> 
> Add a test in `nl_netdev.py` that verifies various cases of threaded
> NAPI being set at NAPI and at device level.

LGTM, but as we discussed many version ago my subjective preference
would be for the per-queue setting to be tri-state (unset=follow the
device setting, enabled, disabled). Rather than have the device level
act as an override when written. It sounded like Willem and Joe thought
that's too complicated and diverges from the existing behavior.
Which is fine by me. But I'd like to see some review tags from them
now :)

Gentlemen?

